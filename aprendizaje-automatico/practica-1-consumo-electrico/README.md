# Práctica 1: consumo eléctrico de 370 clientes

Análisis exploratorio de *ElectricityLoadDiagrams20112014* (consumo cada 15
minutos de 370 clientes de Portugal, 2011-2014): limpieza, paso de formato
ancho a largo, variables de tiempo (hora, día, semana, mes, estación), consumo
global y por cliente, picos, valles y valores atípicos, rankings y
comparaciones por granularidad.

```bash
./descargar_datos.sh                 # dataset de UCI, ~680 MB descomprimido
pip install -r requirements.txt
jupyter lab analisis_electricity.ipynb
```

El cuaderno se dejó con sus salidas. Dataset: Artur Trindade,
[ElectricityLoadDiagrams20112014](https://archive.ics.uci.edu/dataset/321/electricityloaddiagrams20112014),
UCI Machine Learning Repository, CC BY 4.0.
