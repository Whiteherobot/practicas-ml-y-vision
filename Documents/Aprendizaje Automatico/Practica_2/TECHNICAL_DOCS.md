# DOCUMENTACIÓN TÉCNICA - LSTM para Predicción de Demanda

## Contenido del Notebook

### 1. **Configuración Inicial**
```python
# Desactiva warnings
# Importa librerías necesarias
# Configura matplotlib y seaborn
# Muestra versiones de dependencias
```

**Variables globales creadas:**
- `df`: DataFrame con datos cargados
- `df_features`: DataFrame con features engineered
- `scaler`: MinMaxScaler para normalización
- `data_scaled`: Datos normalizados
- `X, y`: Secuencias para LSTM
- `X_train, X_test, y_train, y_test`: Split 80-20
- `model`: Modelo Keras Sequential
- `history`: Histórico de entrenamiento

---

## 2. **Carga de Dataset**

### Ruta del Archivo
```
../Practica_1/electricityloaddiagrams20112014/LD2011_2014.txt
```

### Manejo de Errores
El notebook implementa fallback automático:
- ✅ Intenta cargar del archivo real
- ⚠️ Si falla, crea dataset sintético con patrones realistas

### Formato Esperado
```
DateTime;Zone_1;Zone_2;Zone_3;...
"2011-01-01 00:00:00";100.5;95.3;88.2;...
```

---

## 3. **Feature Engineering**

### Variables Temporales Creadas

| Feature | Rango | Descripción |
|---------|-------|-------------|
| Hour | 0-23 | Hora del día |
| DayOfWeek | 0-6 | Lunes=0, Domingo=6 |
| Month | 1-12 | Mes del año |
| DayOfMonth | 1-31 | Día del mes |
| Quarter | 1-4 | Trimestre |
| IsWeekend | 0-1 | Fin de semana |
| IsMorning | 0-1 | 6-12h |
| IsAfternoon | 0-1 | 12-18h |
| IsNight | 0-1 | 18h-6h |
| Rolling_Mean_24h | float | Media móvil 24h |
| Rolling_Std_24h | float | Desv. Est. móvil 24h |
| Rolling_Min_24h | float | Mínimo móvil 24h |
| Rolling_Max_24h | float | Máximo móvil 24h |
| Lag_1 | float | Valor hace 15 min |
| Lag_4 | float | Valor hace 1h |
| Lag_12 | float | Valor hace 3h |
| Lag_24 | float | Valor hace 6h |
| Lag_96 | float | Valor hace 24h |

---

## 4. **Preparación de Secuencias LSTM**

### Formato de Entrada
```
X shape: (904, 96, 1)
  - 904 muestras
  - 96 timesteps (24 horas × 4 por hora)
  - 1 feature
  
y shape: (904, 1)
  - 904 valores objetivo
```

### Split Temporal
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
│ ENTRENAMIENTO (80%)    │ PRUEBA (20%)  │
│ 723 muestras           │ 181 muestras  │
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## 5. **Arquitectura del Modelo LSTM**

### Diagrama
```
Input (96, 1)
    ↓
LSTM(64, return_sequences=True)
    ↓
Dropout(0.2)
    ↓
LSTM(32, return_sequences=False)
    ↓
Dropout(0.2)
    ↓
Dense(16, activation='relu')
    ↓
Dense(1)
    ↓
Output (prediction)
```

### Parámetros del Modelo
```
LSTM Layer 1:  256 + 16,640 = 16,896 parámetros
LSTM Layer 2:  128 + 9,216 = 9,344 parámetros
Dense Layer 1: 16 × 16 + 16 = 272 parámetros
Dense Layer 2: 16 × 1 + 1 = 17 parámetros
─────────────────────────────────────
TOTAL: 29,857 parámetros
```

### Configuración de Entrenamiento
```python
Optimizer: Adam (learning rate = 0.001 default)
Loss function: MSE (Mean Squared Error)
Metrics: MAE (Mean Absolute Error)
Batch size: 32
Epochs: 10 (con Early Stopping)
Validation split: 20%
Early Stopping:
  - Monitor: val_loss
  - Patience: 3 épocas
  - Restore best weights: True
```

---

## 6. **Funciones de Predicción**

### `predict_demand_date()`
```python
predict_demand_date(fecha_str, zone_name='Zone_1', hours_ahead=24)

Parámetros:
  - fecha_str: str formato 'YYYY-MM-DD'
  - zone_name: str zona a predecir
  - hours_ahead: int horas a predecir

Retorna:
  - pd.DataFrame con columnas [DateTime, Prediccion_MW, Zona]
  
Ejemplo:
  pred = predict_demand_date('2011-01-15', 'Zone_1', 24)
```

### `predict_demand_batch()`
```python
predict_demand_batch(fecha_str, zones_list=['Zone_1', 'Zone_2', 'Zone_3'])

Parámetros:
  - fecha_str: str formato 'YYYY-MM-DD'
  - zones_list: list de zonas

Retorna:
  - pd.DataFrame con predicciones de todas las zonas

Ejemplo:
  pred_batch = predict_demand_batch('2011-01-15', 
                                    ['Zone_1', 'Zone_2', 'Zone_3'])
```

---

## 7. **Métricas de Desempeño**

### Métricas Calculadas

| Métrica | Fórmula | Interpretación |
|---------|---------|----------------|
| **RMSE** | $\sqrt{\frac{1}{n}\sum(y-\hat{y})^2}$ | Error cuadrático medio (penaliza errores grandes) |
| **MAE** | $\frac{1}{n}\sum\|y-\hat{y}\|$ | Error absoluto medio (promedio de errores) |
| **MAPE** | $\frac{1}{n}\sum\frac{\|y-\hat{y}\|}{y}×100$ | Error porcentual (relativo) |
| **R²** | $1-\frac{\sum(y-\hat{y})^2}{\sum(y-\bar{y})^2}$ | Coef. determinación (0-1, mayor es mejor) |

---

## 8. **Flujo de Datos**

```
Raw Data
   ↓
Carga & Exploración (EDA)
   ↓
Feature Engineering
   ↓
Normalización (MinMaxScaler)
   ↓
Creación de Secuencias
   ↓
Split 80-20
   ↓
Entrenamiento LSTM
   ↓
Predicción en Test
   ↓
Evaluación de Métricas
   ↓
Funciones de Producción
```

---

## 9. **Variables Globales por Celda**

### Después de celda de carga:
- `df`: Dataset principal

### Después de Feature Engineering:
- `df_features`: Dataset con features
- `data`: Variable objetivo 1D
- `data_scaled`: Datos normalizados

### Después de secuencias:
- `X, y`: Secuencias full
- `X_train, X_test`: Entrada train/test
- `y_train, y_test`: Target train/test
- `scaler`: Objeto normalizador

### Después de modelo:
- `model`: Objeto Keras Sequential
- `history`: Histórico del entrenamiento

### Después de predicción:
- `y_train_pred, y_test_pred`: Predicciones normalizadas
- `y_train_actual, y_test_actual`: Valores reales
- `y_train_pred_inv, y_test_pred_inv`: Predicciones desescaladas
- Métricas: `train_rmse, test_rmse, train_mae, test_mae, etc.`

### Después de funciones:
- `pred_single`: Predicción individual
- `pred_batch`: Predicción batch

---

## 10. **Troubleshooting**

### Error: "ModuleNotFoundError: No module named 'sklearn'"
```bash
pip install scikit-learn tensorflow
```

### Error: "JIT compilation failed"
- Solución: El notebook ya incluye configuración automática
- Se desactiva GPU automáticamente en CPU

### Error: "Division by zero en MAPE"
- Ya manejado con `np.errstate(divide='ignore', invalid='ignore')`

### Datos muy grandes
- Usar `nrows=N` en `pd.read_csv()` para limitar filas
- Alternativamente, usar dataset sintético

---

## 11. **Performance Esperado**

| Operación | Tiempo (CPU) |
|-----------|-------------|
| Carga datos | ~200ms |
| Feature Engineering | ~20ms |
| Crear secuencias | ~5ms |
| Construir modelo | ~100ms |
| Entrenar (10 épocas) | ~5s |
| Predicción (96 timesteps) | <100ms |
| Visualización | ~200ms |

**Total aprox:** ~10-15 segundos de ejecución completa

---

## 12. **Extensiones Posibles**

1. **Multivariate LSTM**: Usar múltiples zonas en entrada
2. **Attention Mechanism**: Mejorar predicciones a largo plazo
3. **Bidirectional LSTM**: Considerar datos futuros
4. **Ensemble**: Combinar múltiples modelos
5. **ARIMA Hybrid**: Combinar ARIMA + LSTM

---

**Documentación Técnica Completa**  
Versión 1.0 | Mayo 2026
