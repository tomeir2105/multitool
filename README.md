# Initial git, venv and folder setup

## Description
This is a project created using the setup script that initializes a Python project structure, installs missing dependencies, sets up a virtual environment, and optionally connects to a GitHub repository.

## Features
- Initialize a Python project with a basic folder structure.
- Optionally initialize a Git repository and connect it to a remote GitHub repository.
- Set up a Python virtual environment using `pipenv`.
- Install missing system packages with `apt`.
- Customize the setup by adding Python dependencies interactively.

## My learning remarks
- This script implements two methods of user interface with getops and read -p , while the latter is more comfotable in getting lists.
- When using pipenv, don't forget to export PATH to include ~/.local/bin
- GitHub Integration using git remote add origin
 
## Project Structure
After running the setup script, the following structure will be created:

```
myproject/
├── README.md
├── .gitignore
├── CONTRIBUTORS.md
├── config/
│   └── .placeholder
├── lib/
│   └── .placeholder
├── src/
│   └── myproject/
│       ├── app.py
│       └── static/
│       └── templates/
```

## Requirements
- `apt` (for installing system packages)
- `pipenv` (for managing Python dependencies and creating a virtual environment)
- `git` (if Git integration is enabled)
- `pipx` (for installing `pipenv` if not already installed)

## Setup Instructions
### 1. Clone the repository:
```bash
git clone https://github.com/tomeir2105/multitool
cd multitool
```

### 2. Make the script executable:
```bash
chmod +x setup.sh
```

### 3. Run the setup script:
```bash
./setup.sh -p myproject -g Y -e Y -u <github_username> -r <github_repository>
```

### 4. Follow the prompts to install missing system packages and set up a Python virtual environment.

## License
this script is free to use for everyone. 

## Authors
- **Meir** - Initial project setup and script creation
