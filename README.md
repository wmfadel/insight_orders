# insight_orders

InsightOrders is a Flutter-based demo app that displays a list of orders along with a chart
visualizing the order data. The app is designed to run on Android, iOS, and Web platforms, providing
an intuitive way to view and interact with order information.

## Features

- View a list of orders
- Visualize order data with charts
- Multi-platform support (Android, iOS, Web)

## Installation

Follow these steps to get the app up and running on your local machine:

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Xcode (for iOS development)
- Android Studio or Visual Studio Code (for editing code)
- A web browser (for the web version)

### Step 1: Clone the repository

```bash
git clone https://github.com/yourusername/orderviz.git
cd orderviz
```

## Technical Details

### Project Structure

### Features

- State Management with BLoC: The app uses the BLoC (Business Logic Component) pattern for managing
  state, ensuring a clean separation of UI and business logic. This architecture promotes
  scalability, testability, and maintainability, making it easier to manage complex state
  transitions and asynchronous operations.
- Testing: The app includes comprehensive tests to ensure the correctness and reliability of the
  app’s functionality and user interface.
- go_router: A powerful routing solution that simplifies navigation and handling of different
  screens in the app, ensuring a seamless user experience across platforms.
- Deep Linking: Supports deep linking, allowing users to directly access specific content or
  sections of the app via URLs, enhancing the app's usability and engagement.
- Material 3: The app uses the latest Material Design 3 principles, delivering a modern, clean, and
  consistent UI that aligns with Google’s best practices for mobile and web design.
- Dependency Injection: Utilizes dependency injection for better code organization, testability, and
  modularity, promoting scalability and easier maintenance of the app.
- State Restoration for List Position: Ensures that the user’s position in the order list is
  preserved when the app is restarted, offering a smooth and intuitive experience when browsing
  through data.
- Animations with Flutter Animate: Smooth, visually appealing animations that enhance the user
  experience, from data loading transitions to interactive UI elements, making the app feel more
  dynamic.
- Responsive Design (Adaptive Layout): Adapts to different screen sizes and orientations, ensuring a
  fluid and consistent experience across Android, iOS, and web platforms.
- Interactive Graphs: Users can interact with the order data visualized in graphs, tapping on data
  points for more details, making the data more engaging and easier to explore.
- App Icon and Splash Screen: A custom app icon and splash screen that reflect the branding of the
  app, providing a polished and professional introduction when launching the app.
- CI/CD
    - Github actions to run tests based on a trigger -Commit here-
- Firebase
    - Firestore is added to provide a remote source of localization data, that is used to override
      the default localization data in the app, without having to update the app.

## Notes

- Localization added with support for one language as the data is static in a file there will be no
  data localization, showing the page in two different languages will not give the best experience.
- No Custom transition animation in router configuration to keep the native feel.