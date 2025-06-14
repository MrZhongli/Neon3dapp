# Neon3DApp Repository

Welcome to the Neon3DApp repository. This project is developed using Flutter for frontend and Python for backend services (separately). The purpose of the application is to provide a 3D printing cost calculator designed for precision and ease of use.

## Table of Contents

- Getting Started
  - Development Environment
  - Production Environment
- Repository Rules
  - ESLint / Lint Rules
  - Gitflow
    - Main Branches
    - Workflow
    - Hotfixes
  - Commit Rules
  - Branch Rules
- Architecture
- Features

## Getting Started

Follow these instructions to set up and run the Neon3DApp:

### Development Environment

Navigate to the application directory:

```bash
cd neon3dapp
```

Install dependencies:

```bash
flutter pub get
```

Start the development server:

```bash
flutter run
```

### Production Environment

To build the application for production:

```bash
flutter build apk --release
```

or for web:

```bash
flutter build web
```

## Repository Rules

### Lint Rules

Our codebase follows strict linting rules to ensure code quality and consistency:

- **Base Rules**:
  - Curly braces required for all control statements
  - Strict equality checks
- **Dart Specific Rules**:
  - Avoid explicit `dynamic` unless necessary
  - No non-null assertions `!` unless justified
  - Proper future and stream handling
  - Unused variables must be prefixed with an underscore `_`
- **Naming Conventions**:
  - Variables: camelCase
  - Classes/Widgets: PascalCase
  - Files: snake_case
- **Code Organization**:
  - Proper spacing between declarations, functions, and classes
  - Organized imports (Flutter -> Package -> Project)
  - Separate business logic from UI as much as possible

> **Important:**  
> All code must pass lint checks (`dart analyze`) before being committed.

> **Caution:**  
> It's mandatory to have the Dart and Flutter extensions installed in your code editor.

### Gitflow

We follow a **Simplified Gitflow** workflow:

#### Main Branches

- `main`: Production-ready code
- `development`: Integration branch for features

#### Workflow

- Each team member creates a **feature branch** from `development`
- Work is completed on the feature branch following the branch naming convention
- After completion, the feature branch is merged into `development`
- `development` is merged into `main` when ready for release

#### Hotfixes

- Hotfix branches are created from `main`
- After the fix, merge it into both `main` and `development`

> **Note:**  
> This workflow ensures stable production code while allowing continuous development.

### Commit Rules

We use the **Conventional Commits** specification:

```bash
<type>: <description>
```

Supported types:

- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code changes that neither fix bugs nor add features
- `test`: Adding or modifying tests
- `chore`: Changes to the build process or auxiliary tools
- `revert`: Reverting previous changes
- `perf`: Performance improvements
- `build`: Changes affecting build system
- `ci`: Changes to CI configuration
- `wip`: Work in progress

> **Warning:**  
> Commit descriptions must be in lowercase.  
> Example: `feat: add cost calculator screen` instead of `feat: Add Cost Calculator Screen`.

### Branch Rules

Branches must follow this naming convention:

```bash
<type>/<kebab-case-description>
```

Supported types:

- `feat`: Feature branches
- `fix`: Bug fix branches
- `docs`: Documentation branches
- `style`: Style change branches
- `refactor`: Refactoring branches
- `test`: Test-related branches
- `chore`: Maintenance branches
- `revert`: Revert branches
- `perf`: Performance improvement branches
- `build`: Build-related branches
- `ci`: CI configuration branches

> **Caution:**  
> Branches that don't follow this convention will be rejected during push.

> **Tip:**  
> To rename a branch: `git branch -m <type/new-name>`

## Architecture

Neon3DApp uses the following architecture and technologies:

- **Frontend**: Flutter
- **Backend**: Python (separate microservice)
- **State Management**: Provider / Riverpod (TBD)
- **Design Pattern**: MVVM (Model-View-ViewModel) (recommended)
- **Database**: TBD (depending on backend needs)
- **Hosting**: Not defined yet

## Features

- Calculation of 3D printing costs
- Customizable material settings
- Margin profit adjustment (slider)
- User-friendly interface
- Responsive design for mobile and web platforms

---
