# Práctica 2: predicción de demanda en retail con LSTM

Predicción de la cantidad vendida del día siguiente para 10 productos de una
tienda (180 días de ventas, `data/`, generados para la práctica). Se arman
secuencias de 7 días con cantidad vendida, stock, día de la semana y
proporción de stock, y se compara una LSTM de Keras con un Random Forest y con
una referencia ingenua (mañana se vende lo mismo que hoy). Incluye funciones
de predicción individual y por lote, y guarda el modelo y los escaladores.

```bash
pip install -r requirements.txt
jupyter lab prediccion_demanda_retail.ipynb    # se ejecuta desde esta carpeta
```

## Resultados

Último 20 % de las fechas de cada producto:

| Modelo | RMSE |
|---|---|
| Referencia ingenua | 7,31 |
| Random Forest | 4,66 |
| LSTM | 4,76 (MAE 3,51, R² 0,50) |

Con tan pocos datos la LSTM no supera al Random Forest, pero los dos mejoran
claramente a la referencia.

## Correcciones (2026)

El cuaderno no corría de principio a fin: la evaluación usaba variables de
otra versión (`X_train_flat`) y las salidas guardadas no eran de la LSTM. Además
la LSTM predecía las cuatro variables a la vez y su RMSE mezclaba escalas (el
stock está en cientos) frente a un Random Forest que solo predecía la cantidad
vendida, y la separación de datos ponía en test los últimos productos en lugar
de las últimas fechas. Ahora los dos modelos predicen lo mismo con una
separación temporal por producto, la función de predicción avisa si se pide
una fecha que no es el día siguiente al último registro y el modelo se guarda
en formato `.keras` (antes con `pickle`).
