# Google Cloud Shell Software Installation
#   - CS always provides x86_64 Debian Linux environment
#   - Software installation is not preserved, only the file system. This script must be run on every boot.
#   - CS has no mechanism to launch a script automatically, manual interventions is required.
#

# Create dependencies and prepare for the download

pwd=$(pwd)

echo "Initializing setup..." | tee ${pwd}/scripts/setup.log
mkdir -p ~/Downloads ~/.cloudshell
touch ~/.cloudshell/no-apt-get-warning  # Suppress the CS ephemeral environment warning

sudo apt-get update >> ${pwd}/scripts/setup.log 2>&1
if ! sudo apt-get install -y --no-install-recommends clang lldb >> ${pwd}/scripts/setup.log 2>&1; then
    echo "Failed to install clang build dependencies." | tee -a ${pwd}/scripts/setup.log
    exit 1
fi

# Add VS Code extensions (if they are not alreay there). This is installing from a persistent workspace, so
# the extensions are installed for the cloud shell and will persist across sessions.

echo "Installing Visual Studio Code extensions..." | tee -a ${pwd}/scripts/setup.log
if ! /google/devshell/editor/code-oss-for-cloud-shell/bin/remote-cli/codeoss --install-extension llvm-vs-code-extensions.vscode-clangd >> ${pwd}/scripts/setup.log 2>&1; then
    echo "Failed to install Visual Studio Code extension for LLVM Clang Tools." | tee -a ${pwd}/scripts/setup.log
    exit 1
fi
if ! /google/devshell/editor/code-oss-for-cloud-shell/bin/remote-cli/codeoss --install-extension twxs.cmake >> ${pwd}/scripts/setup.log 2>&1; then
    echo "Failed to install Visual Studio Code extension for CMake Tools." | tee -a ${pwd}/scripts/setup.log
    exit 1
fi
if ! /google/devshell/editor/code-oss-for-cloud-shell/bin/remote-cli/codeoss --install-extension webfreak.debug >> ${pwd}/scripts/setup.log 2>&1; then
    echo "Failed to install Visual Studio Code extension for CMake Tools." | tee -a ${pwd}/scripts/setup.log
    exit 1
fi
if ! /google/devshell/editor/code-oss-for-cloud-shell/bin/remote-cli/codeoss --install-extension vadimcn.vscode-lldb >> ${pwd}/scripts/setup.log 2>&1; then
    echo "Failed to install Visual Studio Code extension for LLDB." | tee -a ${pwd}/scripts/setup.log
    exit 1
fi

# Patch the launch.json file to match the Thela/webfreak.debug settings instead of the Microsoft options for VS Code.

echo "Patching launch.json file..." | tee -a ${pwd}/scripts/setup.log
if ! sed -i \
  -e 's/"type": "cppdbg"/"type": "gdb"/' \
  -e 's/"program":/"target":/' \
  -e '/"stopAtEntry": false,/d' \
  -e '/"environment": \[\],/d' \
  -e '/"externalConsole": false,/d' \
  -e '/"MIMode": "gdb",/d' \
  -e '/"miDebuggerPath": "gdb",/d' \
  -e '/"internalConsoleOptions": "openOnSessionStart"/d' \
  -e 's/"args": \[\]/"arguments": ""/' \
  -e '/"setupCommands": \[/,/\],/d' \
  .vscode/launch.json >> ${pwd}/scripts/setup.log 2>&1; then
    echo "Failed to patch launch.json file." | tee -a ${pwd}/scripts/setup.log
    exit 1
fi

# Patch the system-wide settings.json to not reopen the previous workspace

echo "Patching settings.json file..." | tee -a ${pwd}/scripts/setup.log
CODEOSS_SETTINGS_DIR="$HOME/.codeoss/data/Machine"
CODEOSS_SETTINGS_FILE="$CODEOSS_SETTINGS_DIR/settings.json"

mkdir -p "$CODEOSS_SETTINGS_DIR" >> ${pwd}/scripts/setup.log 2>&1

if [ ! -f "$CODEOSS_SETTINGS_FILE" ]; then
  # File doesn't exist yet — create it fresh
  cat > "$CODEOSS_SETTINGS_FILE" << 'EOF'
{
  "window.restoreWindows": "none"
}
EOF
elif ! grep -q '"window.restoreWindows"' "$CODEOSS_SETTINGS_FILE"; then
  if grep -qE '^\s*\{\s*\}\s*$' "$CODEOSS_SETTINGS_FILE"; then
    # File is just an empty object
    if ! sed -i 's/{[[:space:]]*}/{\n  "window.restoreWindows": "none"\n}/' "$CODEOSS_SETTINGS_FILE" >> ${pwd}/scripts/setup.log 2>&1; then
      echo "Failed to patch settings.json file." | tee -a ${pwd}/scripts/setup.log
      exit 1
    fi
  else
    # File has existing keys — insert before the final closing brace
    if ! sed -i '$ s/^}$/,\n  "window.restoreWindows": "none"\n}/' "$CODEOSS_SETTINGS_FILE" >> ${pwd}/scripts/setup.log 2>&1; then
      echo "Failed to patch settings.json file." | tee -a ${pwd}/scripts/setup.log
      exit 1
    fi
  fi
fi

echo "Setup completed successfully." | tee -a ${pwd}/scripts/setup.log