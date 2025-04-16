# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Install uv globally first
RUN pip install uv

# Create a virtual environment
RUN uv venv /app/.venv

# Set PATH to include venv's bin directory for subsequent RUN/CMD instructions
ENV PATH="/app/.venv/bin:$PATH"

# Copy the project definition file
COPY pyproject.toml .

# Install dependencies into the virtual environment
# --no-cache prevents caching which is useful in CI/CD
RUN uv sync --no-cache

# Copy the current directory contents into the container at /app
COPY . .

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV MODULE_NAME="main"
ENV VARIABLE_NAME="app"

# Run uvicorn when the container launches
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"] 