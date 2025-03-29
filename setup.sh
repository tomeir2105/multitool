#!/usr/bin/env bash

# Function to install missing packages using apt
install_missing_packages() {
    local package_list=("$@")

    for package in "${package_list[@]}"; do
        if ! command -v "$package" &>/dev/null && ! dpkg -l 2>/dev/null | grep -q "$package"; then
            echo "Installing missing package: $package"
            sudo apt install -y "$package"
        fi
    done
    echo "Finished installing packages"
}

# Function to prompt the user to enter package names
ask_user_packages() {
    local varname=$1
    local pkg
    local temp_list=()

    echo "Enter package names one by one. Type 'exit' to finish:"
    while true; do
        read -p "Package: " pkg
        if [[ "$pkg" == "exit" ]]; then
            break
        elif [[ -n "$pkg" ]]; then
            temp_list+=("$pkg")
        fi
    done

    eval "$varname=(\"\${temp_list[@]}\")"
}

# Function to initialize a Python virtual environment using pipenv
venv_init() {
    local full_path="$1"

    echo "Setting up virtual environment with pipenv..."

    if ! command -v pipenv &>/dev/null; then
        echo "Installing pipenv via pipx..."
        pipx install pipenv > /dev/null 2>&1 || { echo "Failed to install pipenv"; return 1; }
        export PATH="$HOME/.local/bin:$PATH"
    fi

    export PIPENV_VENV_IN_PROJECT=1

    cd "$full_path" || { echo "Cannot access project directory"; return 1; }

    if [[ ! -f Pipfile ]]; then
        pipenv --python 3 || { echo "Failed to create virtual environment"; return 1; }
    fi
    pipenv lock || { echo "Failed to generate Pipfile.lock"; return 1; }

    echo "Virtual environment created at: $(pipenv --venv)"
}

# Function to connect a local Git repository to a remote GitHub repository
git_connect() {
    local username=$1
    local repository=$2
    local full_path=$3

    local remote_url="git@github.com:${username}/${repository}.git"
    cd "$full_path" || { echo "Cannot access project directory"; return 1; }
    if ! git remote get-url origin &>/dev/null; then
        git remote add origin "$remote_url"
        echo "Connected to remote: $remote_url"
        git remote -v
    else
        echo "Remote 'origin' already exists."
    fi
}

# Function to delete the script or project directory
self_delete() {
    local path=$1
    rm -rf "$path"
    echo "negbook has been deleted"
}

# Function to create project structure and files
build_folders_files() {
    local format=$1
    local project_name=$2

    case $format in
        1)
            mkdir -p "src/$project_name/static" "lib" "config" "src/$project_name/templates"
            touch "src/$project_name/app.py"
            touch "lib/.placeholder"
            touch "config/.placeholder"
            touch "README.md" ".gitignore" "CONTRIBUTORS.md"
            ;;
        *)
            echo "Format not found"
            exit 1
            ;;
    esac
}

# Function to show help message
help() {
    echo "Usage: $0 -p <project_name> -g <git_enabled> -e <venv_enabled> [-u <username> -r <repository>]"
    echo ""
    echo "Parameters:"
    echo "  -p <project_name>   Name of your project"
    echo "  -g <git_enabled>    Initialize Git repository? [Y/n]"
    echo "  -e <venv_enabled>   Initialize a virtual environment? [Y/n]"
    echo "  -u <username>       Your GitHub username (required if git_enabled is Y)"
    echo "  -r <repository>     The repository name on GitHub (required if git_enabled is Y)"
    echo ""
    echo "Example: $0 -p myproject -g Y -e Y -u mygithubuser -r myrepo"
    exit 1
}

# Main function to control project setup
main() {
    # Parse the options using getopts
    while getopts ":p:g:e:u:r:" opt; do
        case "$opt" in
            p) project_name="$OPTARG" ;;
            g) git_enabled="$OPTARG" ;;
            e) venv_enabled="$OPTARG" ;;
            u) username="$OPTARG" ;;
            r) repository="$OPTARG" ;;
            *) help ;;
        esac
    done

    # Check if necessary parameters are provided
    if [[ -z "$project_name" || -z "$git_enabled" || -z "$venv_enabled" ]]; then
        help
    fi

    # Ensure that if git is enabled, both username and repository are provided
    if [[ "$git_enabled" == "Y" || "$git_enabled" == "y" ]]; then
        if [[ -z "$username" || -z "$repository" ]]; then
            echo "Error: GitHub username (-u) and repository name (-r) are required when Git is enabled."
            exit 1
        fi
    fi

    package_list=()
    project_dir="$PWD"
    full_path="$project_dir/$project_name"
    
    # Create project folder if it doesn't exist
    if [[ ! -e $full_path ]]; then
        mkdir -p "$full_path"
    fi
    cd "$full_path" || { echo "Error in creating root project folder"; exit 1; }
    build_folders_files 1 "$project_name"

    # Initialize Git repository if needed
    if [[ "$git_enabled" == "Y" || "$git_enabled" == "y" ]]; then
        git init >/dev/null 2>&1
        echo "Git repository initialized."
        if [[ -n "$username" && -n "$repository" ]]; then
            git_connect "$username" "$repository" "$full_path"
        else
            echo "GitHub username or repository is missing for remote connection."
        fi
    fi
    echo "Project $project_name created at $project_dir"

    ask_user_packages package_list
    install_missing_packages "${package_list[@]}"

    if [[ "$venv_enabled" == "Y" || "$venv_enabled" == "y" ]]; then
        venv_init "$full_path"
    fi
}

main "$@"
