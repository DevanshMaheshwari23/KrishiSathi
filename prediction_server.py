from flask import Flask, request, jsonify
import joblib
import numpy as np
from sklearn.preprocessing import StandardScaler
import os

app = Flask(__name__)

# Load the model
model_path = 'assets/decision_tree_model.joblib'
model = joblib.load(model_path)

# Define feature means and std for standardization
feature_means = {
    'N': 50.55, 
    'P': 53.36, 
    'K': 48.15, 
    'temperature': 25.62, 
    'humidity': 71.48, 
    'ph': 6.47, 
    'durationmonths': 4.37, 
    'rainfall': 103.46
}

feature_std_devs = {
    'N': 36.92, 
    'P': 32.99, 
    'K': 50.65, 
    'temperature': 5.06, 
    'humidity': 22.26, 
    'ph': 0.77, 
    'durationmonths': 2.75, 
    'rainfall': 54.67
}

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.json
        
        # Extract features
        n = float(data.get('N', 0))
        p = float(data.get('P', 0))
        k = float(data.get('K', 0))
        temperature = float(data.get('temperature', 0))
        humidity = float(data.get('humidity', 0))
        ph = float(data.get('ph', 0))
        rainfall = float(data.get('rainfall', 0))
        durationmonths = float(data.get('durationmonths', 0))
        period = float(data.get('period', 0))
        
        # Normalize features
        n_norm = (n - feature_means['N']) / feature_std_devs['N']
        p_norm = (p - feature_means['P']) / feature_std_devs['P']
        k_norm = (k - feature_means['K']) / feature_std_devs['K']
        temp_norm = (temperature - feature_means['temperature']) / feature_std_devs['temperature']
        humidity_norm = (humidity - feature_means['humidity']) / feature_std_devs['humidity']
        ph_norm = (ph - feature_means['ph']) / feature_std_devs['ph']
        rainfall_norm = (rainfall - feature_means['rainfall']) / feature_std_devs['rainfall']
        duration_norm = (durationmonths - feature_means['durationmonths']) / feature_std_devs['durationmonths']
        
        # Create input array
        input_features = np.array([[
            n_norm, p_norm, k_norm, temp_norm, humidity_norm, ph_norm, 
            duration_norm, rainfall_norm, period
        ]])
        
        # Make prediction
        prediction = model.predict(input_features)[0]
        
        return jsonify({
            'prediction': prediction,
            'input': {
                'raw': [n, p, k, temperature, humidity, ph, durationmonths, rainfall, period],
                'normalized': input_features.tolist()[0]
            }
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/test', methods=['GET'])
def test():
    return jsonify({
        'status': 'Server is running!',
        'model_loaded': model is not None
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port) 