# Práctica 0: entropía de imágenes

Lee un conjunto de imágenes organizado por categorías, calcula la entropía en
escala de grises y en color, compara categorías con histogramas y diagramas
de caja, y a 10 imágenes les aplica tres niveles de modificación (un parche
copiado de otra zona del 8, 16 o 28 % del tamaño y ruido gaussiano de sigma 5,
12 o 20) para medir cómo cambia la entropía. Al final arma un informe en HTML (y en PDF si
WeasyPrint está disponible) en `output/`.

```bash
pip install -r requirements.txt
jupyter lab Practica0.ipynb
```

El cuaderno espera `images_pr0.zip` en esta carpeta, con una subcarpeta por
categoría (por ejemplo `training_set/flowers/*.jpg`). El conjunto que se usó
en clase no está en el repositorio porque no tiene una fuente ni una licencia
identificables; sirve cualquier conjunto de imágenes con esa estructura. Las
salidas guardadas en el cuaderno son las de aquella ejecución.
