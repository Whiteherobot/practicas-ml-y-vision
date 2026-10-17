# PRÁCTICA 2: Aprendizaje Profundo y Series Temporales

## 📋 Descripción

Implementación de un modelo de Red Neuronal Recurrente (LSTM) para predicción de demanda de energía eléctrica utilizando el dataset `electricityLoadDiagrams (2011-2014)`.

## 🎯 Objetivos

- ✅ Desarrollar un modelo RNN/LSTM para Forecasting con series temporales
- ✅ Aplicar técnicas de preprocesamiento y Feature Engineering
- ✅ Evaluar el modelo con métricas de calidad (RMSE, MAE, MAPE, R²)
- ✅ Implementar funciones de predicción para producción

## 📁 Estructura del Proyecto

```
Practica_2/
├── prediccion_demanda_energia.ipynb    # Notebook principal
├── README.md                           # Este archivo
└── datos/                              # (Opcional) Resultados
    ├── predicciones_zone_1.csv
    └── metricas_modelo.csv
```

## 🚀 Instrucciones de Uso

### 1. Instalación de Dependencias

```bash
pip install pandas numpy matplotlib seaborn scikit-learn tensorflow keras
```

### 2. Ejecución del Notebook

```bash
# Opción 1: Jupyter local
jupyter notebook prediccion_demanda_energia.ipynb

# Opción 2: VS Code
# Abrir con Python: Interactive Window

# Opción 3: Google Colab (Recomendado para GPU)
# Subir el notebook a Google Colab y ejecutar con GPU
```

**Nota:** El notebook está optimizado para **CPU**. Se ejecuta correctamente en:
- Jupyter Notebook
- VS Code (Jupyter Extension)
- Google Colab
- JupyterLab

### 3. Estructura del Notebook

El notebook está dividido en las siguientes fases:

#### **Fase 1: Análisis y Preparación del Dataset**
- Carga del dataset electricityLoadDiagrams
- Análisis exploratorio de datos (EDA)
- Feature Engineering (variables temporales)
- Preparación de secuencias para LSTM

#### **Fase 2: Desarrollo y Entrenamiento del Modelo**
- Arquitectura LSTM (2 capas recurrentes + 2 capas densas)
- Entrenamiento con Early Stopping
- Validación con división 80-20
- Evaluación con métricas: RMSE, MAE, MAPE, R²

#### **Fase 3: Funciones de Predicción**
- `predict_demand_date()`: Predicción individual por zona
- `predict_demand_batch()`: Predicción para múltiples zonas

## 📊 Resultados Esperados

### Métricas del Modelo
```
Conjunto de Prueba:
- RMSE:  X.XXXX MW
- MAE:   X.XXXX MW
- MAPE:  XX.XX%
- R²:    X.XXXX
```

### Salidas del Notebook
- Gráficos de series temporales
- Histórico de entrenamiento (pérdida y MAE)
- Comparación de predicciones vs valores reales
- Predicciones futuras por zona

## 🔧 Parámetros del Modelo

| Parámetro | Valor | Descripción |
|-----------|-------|-------------|
| Secuencia entrada | 96 timesteps | 24 horas (cada 15 min) |
| LSTM Layer 1 | 128 neuronas | Primera capa recurrente |
| LSTM Layer 2 | 64 neuronas | Segunda capa recurrente |
| Dense Layer 1 | 32 neuronas | Capa densa |
| Dense Layer 2 | 16 neuronas | Capa densa |
| Salida | 1 valor | Predicción siguiente (15 min) |
| Optimizer | Adam | Con learning rate adaptativo |
| Función pérdida | MSE | Mean Squared Error |
| Batch size | 32 | Muestras por lote |
| Épocas | 20 | Máximo, con Early Stopping |

## 📈 Features Engineered

### Variables Temporales Creadas:
- `Hour`: Hora del día (0-23)
- `DayOfWeek`: Día de la semana (0-6)
- `Month`: Mes (1-12)
- `DayOfMonth`: Día del mes
- `Quarter`: Trimestre
- `IsWeekend`: Indicador fin de semana
- `IsMorning`, `IsAfternoon`, `IsNight`: Período del día

### Características Estadísticas:
- Rolling Mean 24h
- Rolling Std 24h
- Rolling Min/Max 24h
- Lag features: 1, 4, 12, 24, 96 timesteps

## 💡 Ejemplo de Uso

```python
# Predicción individual
predicciones = predict_demand_date('2011-01-01', zone_name='Zone_1', hours_ahead=24)
print(predicciones.head())

# Predicción en batch
predicciones_batch = predict_demand_batch('2011-01-01', 
                                          zones_list=['Zone_1', 'Zone_2', 'Zone_3'])
print(f"Total predicciones: {len(predicciones_batch)}")
```

## ⚡ Recomendaciones para Mejora

1. **GPU**: Usar Google Colab con GPU para entrenamiento más rápido
2. **Dataset**: Expandir a dataset completo de 4 años (>210,000 filas)
3. **Arquitectura**: Probar Bidirectional LSTM, Attention Mechanism
4. **Hiperparámetros**: Grid Search para optimización
5. **Ensemble**: Combinar múltiples modelos
6. **Validación**: Implementar Cross-Validation temporal

## 📝 Requisitos del Documento

✅ **Análisis Exploratorio**: Visualizaciones de series temporales  
✅ **Feature Engineering**: 20+ variables creadas  
✅ **Preparación secuencias**: Formato LSTM (muestras, timesteps, features)  
✅ **Modelo LSTM**: 2 capas recurrentes + regularización Dropout  
✅ **Evaluación**: RMSE, MAE, MAPE, R²  
✅ **Función predicción individual**: `predict_demand_date()`  
✅ **Función predicción batch**: `predict_demand_batch()`  

## 📚 Referencias

- [TensorFlow Keras LSTM](https://www.tensorflow.org/api_docs/python/tf/keras/layers/LSTM)
- [Time Series Forecasting with LSTM](https://github.com/tensorflow/examples)
- [Dataset electricityLoadDiagrams](https://www.kaggle.com/datasets/rdizzl3/15-minute-electricity-load-diagrams-20112014)

## ✍️ Autor

**Práctica 2 - Asignatura: Aprendizaje Automático**  
Creado: 2024

---

**Nota**: El notebook puede adaptarse para usar el dataset de retail (`inventory.csv`, `sales_history.csv`) mencionado en los requisitos del documento. Actualmente utiliza electricityLoadDiagrams.
