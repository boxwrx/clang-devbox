[//]: # (README.md)
[//]: # (Copyright © 2026 nTier Training. All rights reserved.)
[//]: #

![Banner Light](./.assets/images/banner-clang-vde-light.png#gh-light-mode-only)
![banner Dark](./.assets/images/banner-clang-vde-dark.png#gh-dark-mode-only)
<div align="right">
    A Box Works Coding Environment<img alt="Box Logo" src="./.assets/images/box-small.png" />
</div>

# Introduction

This is a general C/C++ development environment designed to be cloud-hosted or started in a local docker container.
It is purely an empty sandbox for playing with C and C++ in Linux.

Once the environment is established, both the *gcc* and *clang* build environments are available, as well as the
*gdb* and *lldb* debuggers.
In the *Terminal* tab of the *Panel* (the area below the *Editor* in VS Code), compile *main.c* with `gcc src/main.c`.
This will leave the compiled and linked program in *a.out* in the project folder.
Use `./a.out` at the shell prompt to execute the program.

To run or debug the program from inside of VS Code, the *.vscode* folder has been populated with default *launch.json*
and *tasks.json* files that build and run *src/main.c*.
Clicking on the *Run and Debug* icon in the *Activity bar* at the left opens the *Run and Debug* view in the
*Side bar* to the right of the *Activity bar*.
At the top of the view is a dropdown list of *launch configurations*.
Launch the debugger with the run button to the left of the dropdown, or
from the menu pick <code>Run &rarr; Start Debugging</code> or <code>Run &rarr; Run Without Debugging</code>.

The default *launch.json* configuration is the template to build configurations for running and debugging any other program files in
the project.

## Sandbox Instantiation

There are three ways to initialize and use the development environment.
Pick the one which best serves your needs:

## <sup>&#9312;</sup> Run in a local Docker container:
<blockquote>
    The interface to the environment running in a local container is the Visual Studio Code application.
        <a target="_blank" href="./.assets/resources/local_install.md">This page</a> will provide instructions for installing the applications for a local environment.
        Follow these steps to launch the sandbox:<br>
    <ol>
        <li>Clone this project from GitHub onto a local computer with Docker available.</li>
        <li>Open the folder in VS Code.</li>
        <li>Wait for VS Code to notice the <i>devcontainer.json</i> configuration file and ask if you want to launch the workspace in Docker,</li>
        <li>or use the menu item <code>View &rarr; Command Palette...</code> and select the <code>Dev Containers: Reopen in Container</code>
            command to manually launch the project in a local Docker container.</li>
    </ol>
    Work performed in the container will persist until the container is deleted.
    </blockquote><br>

## <sup>&#9313;</sup> Run in a virtual GitHub Codespace:
<blockquote>
    A Codespace is a Docker cotnainer running in a Debian Linux virtual computer at GitHub.
    You must be signed onto a personal GitHub account to launch the Codespace.
    Do not use an enterprise account, it may be restricted for running Codespace, or GitHub may charge the account for the Codespace.<br><br>
    If you are looking at this repository open in GitHub follow these steps:<br>
    <ol>
        <li>Scroll up and click the <i>code</i> button at the top of the repository.</li>
        <li>Select the <i>Codespaces</i> tab.</i>
        <li>Click the button to <i>Create codespace on main</i>.</li>
    </ol>
   Work performed in the Codespace will persist until Codespace is deleted.
    </blockquote><br>

## <sup>&#9314;</sup> Run in a virtual Google Cloud Shell:
<blockquote>
    A Cloud Shell is a Debian Linux virtual computer hosted at Google.
    You must be signed onto Google with a personal account to launch the virtual computer.
    Do not use an enterprise account, it may be restricted for running a Cloud Shell, or Google may charge the account for the Cloud Shell usage.<br><br>
    After clicking on the link below, once the cloud shell starts in a new browser tab follow these instructions:<br>
    <ol>
        <li>In the <i>Open in Cloud Shell</i> dialog check "Trust repo" and click <i>Continue</i>.</li>
        <li>If an <i>Authorize Cloud Shell</i> dialog appears click <i>Authorize</i>.</li>
        <li>A <i>Cloud Shell Tutorial</i> will appear on the right side of the brower window.
        Continue with the instructions provided there.</li>
    </ol>
    The workspace will persist in your Google Cloud Shell until it is deleted.<br><br>
    <a target="_blank" href="https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/ntiertraining/introduction-to-ada.git&cloudshell_workspace=.&&cloudshell_tutorial=.assets/resources/gcs_tutorial.md&ephemeral=true">Click this link to launch this repository in Google Cloud Shell in a new browser tab</a>.<br>
    </blockquote>