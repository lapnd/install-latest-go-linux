# codenoid
# https://gist.github.com/codenoid/4806365032bb4ed62f381d8a76ddb8e6
# Function to check if a variable is set in the ~/.bashrc file
check_variable() {
    grep -q "$1" ~/.bashrc
}

printf "Checking latest Go version...\n"
LATEST_GO_VERSION="$(curl --silent https://go.dev/VERSION?m=text | head -n 1)"
LATEST_GO_DOWNLOAD_URL="https://go.dev/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz"

printf "cd to home ($USER) directory\n"
cd "$HOME"

printf "Downloading ${LATEST_GO_DOWNLOAD_URL}\n\n"
curl -OJ -L --progress-bar "$LATEST_GO_DOWNLOAD_URL"

printf "Extracting file...\n"
tar -xf "${LATEST_GO_VERSION}.linux-amd64.tar.gz"

# Check and set GOROOT if not already set
if ! check_variable "export GOROOT="; then
    echo "export GOROOT=\"$HOME/go\"" >> ~/.bashrc
fi

# Check and set GOPATH if not already set
if ! check_variable "export GOPATH="; then
    echo "export GOPATH=\"$HOME/go/packages\"" >> ~/.bashrc
fi

# Check and set PATH if not already set
if ! check_variable "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin"; then
    echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> ~/.bashrc
fi
printf "You are ready to Go!\n"
printf 'Run ~/.bashrc  to start using go\n\n'
go version
