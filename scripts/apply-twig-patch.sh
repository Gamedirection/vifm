#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
twig_dir="${repo_root}/submodules/twig"
patch_file="${repo_root}/patches/twig-edit-hotkey.patch"

if [[ ! -d "${twig_dir}/.git" && ! -f "${twig_dir}/.git" ]]; then
  echo "Twig submodule is not initialized: ${twig_dir}" >&2
  echo "Run: git -C \"${repo_root}\" submodule update --init submodules/twig" >&2
  exit 1
fi

if [[ ! -f "${patch_file}" ]]; then
  echo "Missing patch file: ${patch_file}" >&2
  exit 1
fi

git -C "${twig_dir}" apply "${patch_file}"
echo "Applied twig edit hotkey patch to ${twig_dir}"
