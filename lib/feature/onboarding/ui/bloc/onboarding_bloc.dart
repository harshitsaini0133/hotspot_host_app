import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intern_assignment/core/api_constants.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ImagePicker _picker = ImagePicker();
  Timer? _timer;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  OnboardingBloc() : super(const OnboardingState()) {
    on<RecordingStarted>(_onRecordingStarted);
    on<RecordingStopped>(_onRecordingStopped);
    on<RecordingDeleted>(_onRecordingDeleted);
    on<PlaybackStarted>(_onPlaybackStarted);
    on<PlaybackPaused>(_onPlaybackPaused);
    on<_TimerTicked>(
        (event, emit) => emit(state.copyWith(seconds: event.seconds)));
    on<_PlayerStatusChanged>(_onPlayerStatusChanged);

    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _audioPlayer.seek(Duration.zero);
        add(PlaybackPaused());
      } else {
        add(_PlayerStatusChanged());
      }
    });
  }

  Future<void> _onRecordingStarted(
      RecordingStarted event, Emitter<OnboardingState> emit) async {
    final hasPermission = await _checkPermission(event.type);
    if (!hasPermission) {
      emit(state.copyWith(
          status: OnboardingStatus.failure,
          errorMessage: 'Permission required to start recording.'));
      emit(state.copyWith(
          status: OnboardingStatus.initial,
          errorMessage: null)); // Reset status
      return;
    }

    if (event.type == MediaType.audio) {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _audioRecorder.start(const RecordConfig(), path: path);

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        add(_TimerTicked(timer.tick));
      });

      emit(state.copyWith(
        status: OnboardingStatus.recording,
        recordingPath: path,
        recordingType: event.type,
        seconds: 0,
      ));
    } else {
      // Video
      emit(state.copyWith(status: OnboardingStatus.loading));
      final XFile? videoFile =
          await _picker.pickVideo(source: ImageSource.camera);

      if (videoFile != null) {
        final controller = VideoPlayerController.file(File(videoFile.path));
        await controller.initialize();
        final duration = controller.value.duration;
        await controller.dispose();

        final thumbPath = await VideoThumbnail.thumbnailFile(
          video: videoFile.path,
          imageFormat: ImageFormat.JPEG,
          quality: 25,
        );

        emit(state.copyWith(
          status: OnboardingStatus.recorded,
          recordingPath: videoFile.path,
          recordingType: MediaType.video,
          seconds: duration.inSeconds,
          thumbnailPath: thumbPath,
        ));
      } else {
        emit(state.copyWith(status: OnboardingStatus.initial));
      }
    }
  }

  Future<void> _onRecordingStopped(
      RecordingStopped event, Emitter<OnboardingState> emit) async {
    _timer?.cancel();
    if (await _audioRecorder.isRecording()) {
      await _audioRecorder.stop();
    }
    emit(state.copyWith(status: OnboardingStatus.recorded));
  }

  Future<void> _onRecordingDeleted(
      RecordingDeleted event, Emitter<OnboardingState> emit) async {
    await _audioPlayer.stop();

    if (state.recordingPath != null) {
      final file = File(state.recordingPath!);
      if (await file.exists()) await file.delete();
    }
    if (state.thumbnailPath != null) {
      final thumbFile = File(state.thumbnailPath!);
      if (await thumbFile.exists()) await thumbFile.delete();
    }

    emit(const OnboardingState()); // Reset to initial state
  }

  Future<void> _onPlaybackStarted(
      PlaybackStarted event, Emitter<OnboardingState> emit) async {
    if (state.recordingType == MediaType.audio && state.recordingPath != null) {
      if (_audioPlayer.processingState == ProcessingState.idle) {
        await _audioPlayer.setFilePath(state.recordingPath!);
      }
      await _audioPlayer.play();
    } else if (state.recordingType == MediaType.video) {
      if (state.recordingPath != null) {
        final uri = Uri.file(state.recordingPath!);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      }
    }
  }

  Future<void> _onPlaybackPaused(
      PlaybackPaused event, Emitter<OnboardingState> emit) async {
    await _audioPlayer.pause();
  }

  void _onPlayerStatusChanged(
      _PlayerStatusChanged event, Emitter<OnboardingState> emit) {
    if (state.status == OnboardingStatus.recorded ||
        state.status == OnboardingStatus.playing ||
        state.status == OnboardingStatus.paused) {
      final isPlaying = _audioPlayer.playing;
      emit(state.copyWith(
          status:
              isPlaying ? OnboardingStatus.playing : OnboardingStatus.paused));
    }
  }

  Future<bool> _checkPermission(MediaType type) async {
    PermissionStatus status;
    if (type == MediaType.audio) {
      status = await Permission.microphone.request();
    } else {
      status = await Permission.camera.request();
      if (status.isGranted) {
        status = await Permission.microphone.request();
      }
    }
    return status.isGranted;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _playerStateSubscription?.cancel();
    return super.close();
  }
}
