if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

LOCAL_BIN_PATH="$HOME/.local/bin"

if which mise > /dev/null; then
  echo "✅ Mise was installed."
else
  echo "❌ Mise was not installed."
  curl https://mise.jdx.dev/install.sh | sh
  LOCAL_BIN_PATH/mise doctor
fi

if which tuist > /dev/null; then
  echo "✅ Tuist was installed."
else
  echo "❌ Tuist was not installed. Install the current version specified in .tool-versions/.mise.toml"
  if which mise > /dev/null; then
      mise install tuist
  else
    if test -d LOCAL_BIN_PATH; then
      LOCAL_BIN_PATH/mise install tuist
    fi
  fi
fi
