# Gradle Build Guide

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Project Initialization](#project-initialization)
- [Basic Usage](#basic-usage)

---

## Overview

Gradle is a powerful build automation tool that supports multiple languages and platforms.

## Installation

> **Reference:** [Official Gradle Installation Guide](https://docs.gradle.org/current/userguide/installation.html)

### Prerequisites

- Java JDK 8 or higher

### Installation Steps

1. Download Gradle from the official website
2. Extract to a directory of your choice
3. Add `GRADLE_HOME/bin` to your PATH environment variable

### Verify Installation

```bash
gradle --version
```

## Project Initialization

### Create a New Project

```bash
mkdir my-project
cd my-project
gradle init
```

### Project Structure

After initialization, you'll have:

```
my-project/
├── build.gradle      # Build configuration
├── settings.gradle   # Project settings
├── gradlew           # Gradle wrapper (Unix)
├── gradlew.bat       # Gradle wrapper (Windows)
└── gradle/
    └── wrapper/
```

## Basic Usage

### Run Tasks

```bash
# Using Gradle wrapper (recommended)
./gradlew <task-name>

# Using system Gradle
gradle <task-name>
```

### Common Tasks

| Task | Description |
|------|-------------|
| `build` | Compile and test the project |
| `clean` | Remove build directory |
| `test` | Run tests |
| `assemble` | Build without testing |

### Example: Custom Copy Task

Add to `build.gradle`:

```groovy
tasks.register('copy', Copy) {
    from 'src'
    into 'dest'
}
```

Run the task:

```bash
./gradlew copy
```

### Dependencies

Add dependencies in `build.gradle`:

```groovy
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter:2.7.0'
    testImplementation 'junit:junit:4.13.2'
}
```

## Additional Resources

- [Gradle User Guide](https://docs.gradle.org/current/userguide/userguide.html)
- [Creating New Gradle Builds](https://guides.gradle.org/creating-new-gradle-builds/)
