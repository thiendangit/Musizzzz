# MusicApp 🎵

A modern music streaming application built with Flutter (client) and FastAPI (server). This app allows users to discover, play, and manage their favorite music with a beautiful, responsive interface.

## 🏗️ Architecture

- **Frontend**: Flutter (Dart) - Cross-platform mobile and web application
- **Backend**: FastAPI (Python) - RESTful API with PostgreSQL database
- **State Management**: Riverpod for Flutter
- **Database**: PostgreSQL with SQLAlchemy ORM
- **Authentication**: JWT-based authentication
- **File Storage**: Cloudinary for media storage

## 📱 Features

- User authentication (login, signup, password reset)
- Music discovery and browsing
- Audio playback with background support
- Favorites management
- Responsive design for mobile and web
- Dark theme support
- Offline music storage with Hive

## 🚀 Prerequisites

Before you begin, ensure you have the following installed:

### For Flutter Development

- **Flutter SDK** (3.5.4 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Xcode** (for iOS development on macOS)
- **Android SDK** (for Android development)

### For Backend Development
- **Python** (3.8 or higher)
- **PostgreSQL** (12 or higher)
- **pip** (Python package manager)

## 📦 Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd MusicApp
```

### 2. Backend Setup

Navigate to the server directory and set up the backend:

```bash
cd server

# Create a virtual environment
python -m venv .venv

# Activate virtual environment
# On macOS/Linux:
source .venv/bin/activate
# On Windows:
.venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set up environment variables
cp .env.example .env
# Edit .env with your database credentials and other settings
```

### 3. Database Setup

Make sure PostgreSQL is running and create a database:

```sql
CREATE DATABASE musicapp;
```

Update your `.env` file with database credentials:

```env
DATABASE_URL=postgresql://username:password@localhost:5432/musicapp
JWT_SECRET_KEY=your-secret-key-here
CLOUDINARY_CLOUD_NAME=your-cloudinary-name
CLOUDINARY_API_KEY=your-cloudinary-key
CLOUDINARY_API_SECRET=your-cloudinary-secret
```

Run database migrations:

```bash
# Generate migration (if needed)
alembic revision --autogenerate -m "Initial migration"

# Apply migrations
alembic upgrade head
```

### 4. Frontend Setup

Navigate to the client directory and set up the Flutter app:

```bash
cd ../client

# Install Flutter dependencies
flutter pub get

# Generate code (for Riverpod)
flutter packages pub run build_runner build
```

## 🚀 Running the Application

### Start the Backend Server

```bash
cd server
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

The API will be available at `http://localhost:8000`
API documentation: `http://localhost:8000/docs`

### Start the Flutter App

```bash
cd client

# For development
flutter run

# For web
flutter run -d chrome

# For specific platform
flutter run -d android
flutter run -d ios
```

## 📁 Project Structure

```
MusicApp/
├── client/                 # Flutter frontend
│   ├── lib/
│   │   ├── core/          # Core utilities, themes, providers
│   │   └── features/      # Feature modules (auth, home)
│   ├── assets/            # Images and other assets
│   └── pubspec.yaml       # Flutter dependencies
├── server/                # FastAPI backend
│   ├── app/
│   │   ├── api/          # API routes and endpoints
│   │   ├── models/       # Database models
│   │   ├── schemas/      # Pydantic schemas
│   │   └── utils/        # Utility functions
│   ├── migrations/       # Database migrations
│   └── requirements.txt  # Python dependencies
└── README.md
```

## 🔧 Development flow

### Backend Development

The backend uses FastAPI with the following key components:

- **Models**: SQLAlchemy models for database entities
- **Schemas**: Pydantic models for request/response validation
- **API Routes**: RESTful endpoints for authentication and music management
- **Database**: PostgreSQL with Alembic for migrations

### Frontend Development

The Flutter app uses:

- **Riverpod**: State management and dependency injection
- **Hive**: Local database for offline storage
- **Just Audio**: Audio playback functionality
- **HTTP**: API communication

### Code Generation

For Riverpod providers, run:

```bash
cd client
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## 🧪 Testing

### Backend Tests

```bash
cd server
source .venv/bin/activate
pytest
```

### Frontend Tests

```bash
cd client
flutter test
```

## 📱 Building for Production

### Android APK

```bash
cd client
flutter build apk --release
```

### iOS App

```bash
cd client
flutter build ios --release
```

### Web App

```bash
cd client
flutter build web --release
```

## 🔐 Environment Variables

Create a `.env` file in the server directory with the following variables:

```env
DATABASE_URL=postgresql://username:password@localhost:5432/musicapp
JWT_SECRET_KEY=your-jwt-secret-key
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
CLOUDINARY_CLOUD_NAME=your-cloudinary-name
CLOUDINARY_API_KEY=your-cloudinary-key
CLOUDINARY_API_SECRET=your-cloudinary-secret
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Troubleshooting

### Common Issues

1. **Flutter dependencies issues**: Run `flutter clean && flutter pub get`
2. **Database connection issues**: Check PostgreSQL is running and credentials are correct
3. **Build issues**: Ensure all prerequisites are installed and up to date

### Getting Help

- Check the [Flutter documentation](https://flutter.dev/docs)
- Check the [FastAPI documentation](https://fastapi.tiangolo.com/)
- Open an issue in this repository

## 📞 Support

For support, email support@musicapp.com or join our Discord community.

---

Made with ❤️ by the MusicApp team
