#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mode="link"

if [[ "${1-}" == "--copy" ]]; then
  mode="copy"
fi

mkdir -p "${HOME}/.config"

install_dir() {
  local source_dir="$1"
  local target_dir="$2"

  rm -rf "${target_dir}"
  if [[ "${mode}" == "copy" ]]; then
    cp -a "${source_dir}" "${target_dir}"
  else
    ln -s "${source_dir}" "${target_dir}"
  fi
}

install_dir "${repo_root}/config/vifm" "${HOME}/.config/vifm"
install_dir "${repo_root}/config/lvim" "${HOME}/.config/lvim"

cat <<EOF
Installed personal configs in ${mode} mode:
  ${HOME}/.config/vifm -> ${repo_root}/config/vifm
  ${HOME}/.config/lvim -> ${repo_root}/config/lvim

Optional submodules stay uninitialized by default.
Initialize only what you want, for example:
  git -C "${repo_root}" submodule update --init submodules/treemd
  git -C "${repo_root}" submodule update --init submodules/twig
  git -C "${repo_root}" submodule update --init submodules/lvim

After initializing twig, apply the local edit hotkey patch with:
  "${repo_root}/scripts/apply-twig-patch.sh"
EOF
