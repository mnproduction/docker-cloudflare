# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Install uv
RUN pip install uv

# Copy the project definition file
COPY pyproject.toml .

# Install dependencies using uv sync
# --system installs packages into the global site-packages directory
# --no-cache prevents caching which is useful in CI/CD
RUN uv sync --system --no-cache pyproject.toml

# Copy the current directory contents into the container at /app
COPY . .

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV MODULE_NAME="main"
ENV VARIABLE_NAME="app"

# Run uvicorn when the container launches
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"] 