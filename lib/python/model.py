import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import joblib
import json
import sys

# تحميل البيانات
data = pd.DataFrame({
    'feature1': [1, 2, 3, 4, 5],
    'feature2': [2, 3, 4, 5, 6],
    'target': [0, 1, 0, 1, 0]
})

# تجهيز البيانات
X = data[['feature1', 'feature2']]
y = data['target']

# تقسيم البيانات
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# تدريب النموذج
model = RandomForestClassifier()
model.fit(X_train, y_train)

# تقييم النموذج
y_pred = model.predict(X_test)
print(f'Accuracy: {accuracy_score(y_test, y_pred)}')

# حفظ النموذج
joblib.dump(model, 'model.pkl')

# تحليل البيانات من المدخلات
def analyze(data):
    model = joblib.load('model.pkl')
    features = json.loads(data)
    prediction = model.predict([features])
    return prediction[0]

if __name__ == "__main__":
    input_data = sys.argv[1]
    result = analyze(input_data)
    print(result)
