#!/usr/bin/env bash
# Descarga ElectricityLoadDiagrams20112014 del repositorio UCI (CC BY 4.0, ~250 MB comprimido).
set -euo pipefail
cd "$(dirname "$0")"
curl -L -o electricity.zip https://archive.ics.uci.edu/static/public/321/electricityloaddiagrams20112014.zip
mkdir -p electricityloaddiagrams20112014
unzip -o electricity.zip -d electricityloaddiagrams20112014
rm electricity.zip
ls -lh electricityloaddiagrams20112014
