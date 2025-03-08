# Knajping

Knajping is a venue review application that allows users to discover and share their experiences with restaurants, bars, cafes and other venues. Users can browse venues, read reviews from others, and share their own opinions.

## Features

- User authentication and profiles
- Venue browsing and searching
- Review creation and management
- Image uploads for venues and reviews
- Responsive design for all devices

## Key Technolgies

- Ruby on Rails 8.0.1: Backend framework
- PostgreSQL: Database
- Tailwind CSS: Frontend styling
- Stimulus & Turbo: Frontend interactivity
- Devise: User authentication
- Docker & Docker Compose: Containerization
- Active Storage: File uploads
- Solid Queue: Background job processing
- Image Processing: Image manipulation

## Prerequisites

Before running the application, ensure you have the following installed:

- Docker
- Docker Compose

## Running Locally with Docker Compose

1. **Clone the repository**:

```bash
git clone https://github.com/maciejbentkowski/knajping.git

cd knajping
```

2. **Create a .env file (optional)**:

Create a .env file in the root directory if you need to override any environment variables.

3. **Build and start the containers**:

```bash
docker-compose up --build
```

This will:

- Build the Rails application image using Dockerfile.dev
- Start the PostgreSQL database for development environment and test environment
- Create necessary volumes for data persistence
- Set up the network between services
- Run database migrations
- Start the Rails server on port 3000

4. **Access the application**:
   Once the containers are running, you can access the application at:

```text
http://localhost:3000
```

5. **Running commands in the container**:

```bash
docker-compose exec web bin/rails console
# or
docker-compose exec web bin/rails db:migrate
# or any other command
```

6. **Stopping the application**

To stop the containers:

```bash
docker-compose down
```

To stop the containers and remove volumes (will delete database data):

```bash
docker-compose down -v
```

## Development Workflow

The Docker setup mounts your local directory into the container, so any changes to files will be reflected immediately. The Rails server in development mode also automatically reloads code changes.
For CSS changes, the Tailwind watcher is running in development, so your CSS will be automatically rebuilt.

## Testing

To run the test suite:

```bash
docker-compose exec web bin/rails spec
```
