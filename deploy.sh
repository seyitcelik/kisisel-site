#!/usr/bin/env bash
# deploy.sh - Siteyi GitHub Pages uzerinde yayinlar.
#
# Kullanim:
#   ./deploy.sh "commit mesaji"
#
# Once push.sh ile son hali gonderir, sonra GitHub Pages'i
# main dalinin kok klasorunden yayin yapacak sekilde acar.
# GitHub CLI (gh) gerekir:  https://cli.github.com  ->  gh auth login
set -euo pipefail
cd "$(dirname "$0")"

command -v gh >/dev/null || {
  echo "HATA: GitHub CLI (gh) kurulu degil."
  echo "Elle yayinlamak icin: GitHub deposu > Settings > Pages > Branch: main, klasor: / (root) > Save"
  exit 1
}

# 1) Son hali gonder
./push.sh "${1:-Site yayinlandi}"

# 2) GitHub Pages'i ac (zaten aciksa kaynagi guncelle)
DEPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"

if gh api "repos/$DEPO/pages" >/dev/null 2>&1; then
  gh api -X PUT "repos/$DEPO/pages" \
    -f "source[branch]=main" -f "source[path]=/" >/dev/null
  echo "GitHub Pages zaten acik, yeni surum yayinlaniyor."
else
  gh api -X POST "repos/$DEPO/pages" \
    -f "source[branch]=main" -f "source[path]=/" >/dev/null
  echo "GitHub Pages acildi."
fi

# 3) Site adresini goster
ADRES="$(gh api "repos/$DEPO/pages" -q .html_url)"
echo "Site adresi: $ADRES"
echo "Not: ilk yayinda sitenin acilmasi 1-2 dakika surebilir."
