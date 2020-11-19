# This script contains functions to create a virtual environment
# with the dependencies necessary to execute style and formatting
# checks.  This is sourced from format_python_tools.sh

# Active the environment if it exists, create it if it does not
source_venv() {
  VENV_DIR=$1
  if [[ "${VIRTUAL_ENV}" == "" ]]; then
    if [[ ! -d "${VENV_DIR}"/venv ]]; then
      virtualenv "${VENV_DIR}"/venv --python=python3
    fi
    source "${VENV_DIR}"/venv/bin/activate
  else
    echo "Found existing virtualenv"
  fi
}

# Install python dependencies into the virtual environment
python_venv() {
  SCRIPT_DIR=$(realpath "$(dirname "$0")")

  BUILD_DIR=build_tools
  PY_NAME="$1"
  VENV_DIR="${BUILD_DIR}/${PY_NAME}"

  source_venv "${VENV_DIR}"
  pip install -r "${SCRIPT_DIR}"/requirements.txt

  shift
  python3 "${SCRIPT_DIR}/${PY_NAME}.py" $*
}