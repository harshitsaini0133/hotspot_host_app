<<<<<<< HEAD

# Hotspot Host Onboarding Questionnaire

This Flutter project is an onboarding questionnaire designed to assess the suitability of potential hosts for a social platform. The application consists of two main screens that gather information about the applicant's hosting preferences and motivations.

---

## Features Implemented

### 1. Experience Type Selection Screen

- **Dynamic Experience Loading**: Fetches a list of hosting experiences from a live API using `dio`.
- **Interactive Card Selection**: Users can select and deselect multiple experience cards. The "Next" button is enabled only when at least one experience is chosen.
- **Descriptive Text Input**: A multi-line text field with a 250-character limit allows users to describe their ideal hotspot.
- **Robust State Management**: The screen's state (loading, success, failure, selection) is managed efficiently using the **BLoC** pattern.
- **Error Handling**: Displays user-friendly error messages for network issues like no internet connection or server errors.

### 2. Onboarding Question Screen

- **Multi-modal Answers**: Users can answer the main question via three methods:
  - **Text**: A multi-line text field with a 600-character limit.
  - **Audio Recording**: In-app audio recording functionality.
  - **Video Recording**: Launches the native system camera to record a video answer.
- **Dynamic UI**: The layout adapts based on user actions. Once a media (audio/video) is recorded, the recording buttons are hidden, and a media player box appears.
- **Media Handling**:
  - **Playback**: Recorded audio can be played back within the app.
  - **Deletion**: Users can delete a recorded audio or video file.
  - **Video Thumbnails**: A thumbnail is automatically generated and displayed for recorded videos.
  - **Video Duration**: The actual duration of the recorded video is fetched and displayed.
- **Engaging Animations**:
  - **Animated Timer**: A flip-counter animation displays the timer during audio recording.
  - **Animated Duration Display**: After a recording is complete, the final duration animates from 0 to the total time.
  - **Smooth Waveform**: A smooth, animated waveform is displayed during audio recording and playback.

---

## Brownie Points (Optional Enhancements)

- **State Management**: Implemented **BLoC** for the Experience Selection screen, ensuring a clean separation of business logic from the UI.
- **Dio for API Calls**: Used the `dio` package for robust network request management, including interceptors for logging and error handling.
- **Audio Playback**: Successfully implemented audio playback for recorded answers.
- **UI/UX**:
  - The UI is responsive and handles keyboard visibility by scrolling the content.
  - Attention has been paid to creating a clean UI with custom widgets and consistent styling.

---

## Tech Stack & Architecture

- **State Management**: `flutter_bloc`
- **Networking**: `dio`
- **Permissions**: `permission_handler`
- **Media & Recording**:
  - `image_picker` (for video recording via system camera)
  - `record` (for audio recording)
  - `just_audio` (for audio playback)
  - `video_player` (for fetching video duration)
  - `video_thumbnail` (for generating video thumbnails)
- **UI & Animations**: `flutter_svg`, `animated_flip_counter`
- **Architecture**: The project follows a scalable, feature-first directory structure.
  - **BLoC Pattern**: For predictable state management.
  - **Repository Pattern**: A service layer (`ExperienceService`) abstracts the data source from the UI.
  - **Clean Code**: Reusable widgets (`RecordedMediaBox`, `TimerDisplay`, etc.) and constants are separated to keep the codebase clean and maintainable.

---

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK (version >=3.0.0)
- An IDE like VS Code or Android Studio

### Installation

1. **Clone the repository:**
   ```sh
   git clone <your-repository-url>
   ```
2. **Navigate to the project directory:**
   ```sh
   cd intern_assignment
   ```
3. **Install dependencies:**
   ```sh
   flutter pub get
   ```
4. **Run the application:**
   ```sh
   flutter run
   ```

> **Note:** The project is already configured with the necessary permissions for both Android (`AndroidManifest.xml`) and iOS (`Info.plist`).

---

## Working Demo

_[You can add a link to your screen recording demo here]_
