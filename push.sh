#!/usr/bin/env bash
# push.sh - Projeyi GitHub'a gonderir.
#
# Kullanim:
#   ./push.sh "commit mesaji"
#
# Ilk calistirmada depo yoksa GitHub CLI (gh) ile olusturulur.
# Depo adini degistirmek icin:  DEPO_ADI=baska-ad ./push.sh
set -euo pipefail
cd "$(dirname "$0")"

DEPO_ADI="${DEPO_ADI:-kisisel-site}"
MESAJ="${1:-Site guncellendi}"

command -v git >/dev/null || { echo "HATA: git kurulu degil."; exit 1; }

# Git deposu yoksa baslat
if [ ! -d .git ]; then
  git init -b main
fi
git branch -M main

# Degisiklikleri commit et
git add -A
if git diff --cached --quiet; then
  echo "Commit edilecek yeni degisiklik yok."
else
  git commit -m "$MESAJ"
fi

# Uzak depo (origin) yoksa GitHub'da olustur ve gonder
if ! git remote get-url origin >/dev/null 2>&1; then
  if command -v gh >/dev/null; then
    gh repo create "$DEPO_ADI" --public --source=. --remote=origin --push
  else
    echo "HATA: 'origin' tanimli degil ve GitHub CLI (gh) kurulu degil."
    echo "GitHub'da bos bir depo olusturup su komutu calistirin, sonra betigi tekrar deneyin:"
    echo "  git remote add origin https://github.com/seyitcelik/kisisel-site.git"
    exit 1
  fi
else
  git push -u origin main
fi

echo "Tamam: proje GitHub'a gonderildi."
