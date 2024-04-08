# git-template

This repository contains scripts and configuration files to set up and manage a customizable Git template directory. The template directory helps maintain consistent configurations and scripts across different Git repositories.

## Directory Structure
- **config**: Contains configuration files for custom Git aliases (`alias.conf`) and defining custom hooks and scripts (`hooks.conf`).

- **git-template**: Contains the hooks and templates used by Git. 
    - **hooks**: Contains custom scripts and Git hook scripts. Custom scripts are stored in the `custom-scripts` directory.
    - **templates**: Contains template files for `.gitignore` and `README.md`.

- **logs**: Contains log files for recording actions (`action.log`) and errors (`error.log`).

- **run**: Contains the script to execute the configuration process.

- **scripts**: Contains scripts to configure Git hooks, set up global Git aliases, and initialize the Git template directory.

- **utilities**: Contains utility scripts, such as `log.sh` for logging functions.


## Usage

1. **Custom Git Hooks and Scripts**: Define custom Git hooks and scripts in the `config/hooks.conf` file. Each hook type is associated with a list of script names, which should correspond to the filenames in the `git-template/hooks/custom-scripts` directory.

2. **Global Git Aliases**: Set up global Git aliases by editing the `config/alias.conf` file. Each alias is defined as `alias_name:script_name`, where `script_name` corresponds to the filename in the `git-template/hooks/custom-scripts` directory.

3. **Initializing the Git Template Directory**: Run the `config-template-dir.sh` script to initialize the Git template directory. This script sets up the directory structure and copies the necessary template files and scripts.

4. **Configuring Git Hooks**: Execute the `config-git-hook.sh` script to configure Git hooks based on the settings provided in the `hooks.conf` file. This script writes hook scripts based on the defined hooks and associated scripts.

5. **Setting Global Git Aliases**: Run the `config-global-alias.sh` script to set up global Git aliases based on the definitions in the `alias.conf` file.

## Logging

All actions and errors during the configuration process are logged in the `logs/action.log` and `logs/error.log` files, respectively. These logs provide visibility into the execution of the configuration scripts and help in troubleshooting any issues.

## Notes

- Ensure that the scripts are executable (`chmod +x`) before executing them.
- Customize the scripts and configuration files according to your project's requirements.
- Review and update the template files (`gitignore.template`, `README.template.md`) to match your project's needs.

## Future Enhancements
- **Structured Alias Management**: Provide a more structured and easily manageable way for registering and managing aliases. This will simplify the process of adding, updating, and removing Git aliases, making the tool more user-friendly and efficient.

- **Template Customization**: Allow users to customize the template files (`gitignore.template`, `README.template.md`) during the configuration process. This will enable users to define project-specific configurations and content for these files, enhancing the flexibility and usability of the tool.

- **Interactive Configuration**: Develop an interactive configuration tool that guides users through the setup process, prompts for input, and provides feedback on the configuration steps. This will make the setup process more user-friendly and intuitive.
- **Project Wiki**: Add a comprehensive wiki to the project. The wiki will serve as a central repository for all the documentation related to the project. It will include detailed explanations of the project's features, step-by-step guides, best practices, and tips for troubleshooting common issues. This will make it easier for both new and existing users to understand and use the project effectively.

## Contribution

While this is a one-man project, contributions are always welcome. If you have any ideas for improvements or new features, or if you find a bug, please open an issue to discuss it. If you wish to contribute directly, you can fork the repository and submit a pull request.
