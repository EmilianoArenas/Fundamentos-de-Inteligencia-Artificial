import pandas as pd
import matplotlib.pyplot as plt
from sklearn.datasets import load_breast_cancer
from sklearn.feature_selection import RFE
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import (roc_auc_score, accuracy_score, precision_score, 
                             recall_score, f1_score, confusion_matrix, ConfusionMatrixDisplay)

# Cargar el conjunto de datos breast_cancer
data = load_breast_cancer()
X = pd.DataFrame(data.data, columns=data.feature_names)  
y = data.target  

# Dividir los datos en entrenamiento (80%) y prueba (20%)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)

# Crear el modelo base
modelo = RandomForestClassifier(random_state=42)

# Inicializar variables para almacenar resultados
roc_scores = []
num_features = []
best_features = None
best_roc_auc = 0

# Realizar RFE para diferentes números de características seleccionadas
for i in range(2, X_train.shape[1] + 1):
    selector = RFE(estimator=modelo, n_features_to_select=i, step=1)
    selector.fit(X_train, y_train)
    
    # Seleccionar las características más relevantes
    selected_features = X.columns[selector.support_]    
    X_train_selected = selector.transform(X_train)
    X_test_selected = selector.transform(X_test)
    modelo.fit(X_train_selected, y_train)
    y_pred_proba = modelo.predict_proba(X_test_selected)[:, 1]
    roc_auc = roc_auc_score(y_test, y_pred_proba)
    roc_scores.append(roc_auc)
    num_features.append(i)
    
    # Actualizar las mejores características si se encuentra un mejor puntaje
    if roc_auc > best_roc_auc:
        best_roc_auc = roc_auc
        best_features = selected_features
        X_best_train, X_best_test = X_train_selected, X_test_selected

# Graficar el rendimiento en función del número de características seleccionadas
plt.figure(figsize=(10, 6))
plt.plot(num_features, roc_scores, marker='o', linestyle='-', color='b')
plt.xlabel('Número de características seleccionadas')
plt.ylabel('ROC AUC')
plt.title('Selección de características mediante RFE')
plt.grid(True)
plt.show()

# Evaluar el modelo con las mejores características seleccionadas
modelo.fit(X_best_train, y_train)
y_pred = modelo.predict(X_best_test)
y_pred_proba = modelo.predict_proba(X_best_test)[:, 1]

# Calcular métricas de rendimiento
roc_auc = roc_auc_score(y_test, y_pred_proba)
accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred)
recall = recall_score(y_test, y_pred)
f1 = f1_score(y_test, y_pred)
conf_matrix = confusion_matrix(y_test, y_pred)

# Mostrar resultados
print(f"Mejor ROC AUC: {roc_auc:.4f}")
print(f"Número óptimo de características: {len(best_features)}")
print("Características seleccionadas:")
for feature in best_features:
    print(f"- {feature}")
print("\nMétricas de rendimiento:")
print(f"Exactitud (Accuracy): {accuracy:.4f}")
print(f"Precisión (Precision): {precision:.4f}")
print(f"Sensibilidad (Recall): {recall:.4f}")
print(f"Puntuación F1 (F1 Score): {f1:.4f}")
print(f"ROC AUC Score: {roc_auc:.4f}")

# Visualizar la matriz de confusión
disp = ConfusionMatrixDisplay(confusion_matrix=conf_matrix, display_labels=data.target_names)
disp.plot(cmap=plt.cm.Blues)
plt.title("Matriz de Confusión")
plt.show()
