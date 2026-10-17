# Práctica 0 - Entropía de Imágenes (Visión por Computador)

Este proyecto procesa un dataset de imágenes (`images_pr0.zip`), calcula entropía a color y en escala de grises, genera gráficas, aplica modificaciones en al menos 10 imágenes y crea un **informe automático en HTML** (y PDF opcional).

## 1) Requisitos

```bash
source /home/michi/venvs/cv-ai311/bin/activate
pip install -r requirements.txt
```

## 2) Ejecutar análisis + informe automático

```bash
cd "/home/michi/Documents/Vision del computador/Practica 0"
python run_practica0.py --zip "/ruta/a/images_pr0.zip"
```

Salida principal:
- `output/report_latest.html`
- `output/report_latest.pdf` (si el entorno permite PDF)

## 3) Estructura esperada del zip

Idealmente el zip debe tener subcarpetas por categoría, por ejemplo:

```text
images_pr0/
  clase_1/
    img1.jpg
  clase_2/
    img2.jpg
```

Si no hay subcarpetas, el script usará una categoría única: `sin_categoria`.

## 4) Notebook Jupyter

```bash
jupyter lab
```

Abrir `Practica0.ipynb` para revisar/ejecutar flujo por celdas.

## 5) Qué incluye el informe

- Imagen + ruta + histogramas (gris y color) de muestra por categoría.
- Entropía en gris y color para todas las imágenes.
- Diagramas de cajas y bigotes por categoría (gris y color).
- Explicación de entropía (general, gris y color).
- Análisis de categorías con mayor entropía.
- Modificaciones en 10 imágenes (pequeña, mediana, grande) y comparación en gráfico de barras.
