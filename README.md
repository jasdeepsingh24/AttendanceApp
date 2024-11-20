# Attendance App

## Overview

The Attendance Management App is a cross-platform mobile application developed using Flutter, designed to streamline the attendance process for educational institutions. With a user-friendly interface and secure authentication via Google Firebase, this app enables teachers to efficiently manage classrooms, track student attendance, and export data for university integration.

## Features

- **Cross-Platform Compatibility**: Built for both Android and iOS using Flutter.
- **User -Friendly UI**: Intuitive design for easy navigation and usage.
- **Secure Authentication**: Utilizes Google Firebase for secure user authentication.
- **Classroom Management**: Allows teachers to create and manage classrooms effortlessly.
- **Attendance Tracking**: Teachers can mark attendance using swipe gestures for quick and easy access.
- **Data Export**: Supports exporting attendance data to Excel for seamless integration with university systems.
- **Efficient Data Management**: Integrates with Google Firestore for real-time data management and security.

## Architecture Diagram

The Attendance Management App is designed with a modular architecture that accommodates different user roles and their specific functionalities. Below is a high-level overview of the architecture:

```plaintext
+-----------------------+
|   User Device         |
| (Android/iOS)         |
+-----------------------+
          |
          |  Flutter Framework
          |
+-----------------------+
|   Application         |
|                       |
|  +-----------------+  |
|  |     UI          |  |
|  | (Teacher &      |  |
|  |  Student Views) |  |
|  +-----------------+  |
|                       |
|  +-----------------+  |
|  |     Logic       |  |
|  | (Business Logic)|  |
|  +-----------------+  |
+-----------------------+
          |
          |  Calls to Firebase
          |
+-----------------------+
|   Firebase            |
|                       |
|  +-----------------+  |
|  | Authentication  |  |
|  | (Login/Signup)  |  |
|  +-----------------+  |
|                       |
|  +-----------------+  |
|  | Firestore       |  |
|  | (Data Storage)  |  |
|  +-----------------+  |
+-----------------------+

```
### Explanation of Layers

- **User  Device**: The application runs on user devices, which can be either Android or iOS.
  
- **Application**:
  - **UI**: Contains separate user interfaces for Teachers and Students, each tailored to their specific needs and functionalities.
  - **Logic**: Handles the business logic and interactions between the UI and the backend services.

- **Firebase**:
  - **Authentication**: Manages user login and signup processes, ensuring secure access for both roles.
  - **Firestore**: Provides data storage and retrieval functionalities, allowing real-time updates and secure data management.

### User Roles

- **Teacher**: Has access to features such as class management, attendance tracking, and reporting.
  
- **Student**: Can view their attendance records and any relevant notifications.

This architecture promotes scalability, maintainability, and role-based access control, making it easier to manage features specific to each user type.


## Technologies Used

- **Flutter**: Framework for building natively compiled applications for mobile from a single codebase.
- **Dart**: Programming language used for developing Flutter applications.
- **Firebase Authentication**: Provides secure authentication methods for users.
- **Cloud Firestore**: NoSQL database for storing and syncing data in real-time.
- **Firebase Cloud Messaging**: For handling notifications and messaging between the app and users.
- **Git**: Version control system for tracking changes in the codebase.
- **GitHub**: Platform for hosting the project repository and collaboration.


## Usage

1. **Login/Signup**:
   - Open the app and use the login/signup screens to create a new account or log in with existing credentials.
   - Teachers and students will have separate interfaces based on their roles.

2. **For Teachers**:
   - After logging in, teachers can:
     - **Manage Classes**: Create, edit, or delete classes.
     - **Mark Attendance**: Take attendance for each class session.
     - **Generate Reports**: View and download attendance reports for their classes.
     - **Send Notifications**: Communicate important announcements to students.

3. **For Students**:
   - After logging in, students can:
     - **View Attendance Records**: Check their attendance history for each class.
     - **Receive Notifications**: Stay updated with class schedules, attendance updates, and important announcements.

4. **Real-Time Updates**:
   - The app utilizes Firestore for real-time updates, ensuring that all users see the most current data without needing to refresh the app.

5. **Logging Out**:
   - Users can log out by navigating to the settings menu and selecting the logout option.

6. **Help and Support**:
   - For any issues or questions, users can access the help section within the app or contact support via the provided contact information.
