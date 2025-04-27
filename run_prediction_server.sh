#!/bin/bash
echo "Installing required Python packages..."
pip install flask joblib scikit-learn numpy

echo "Starting prediction server..."
python prediction_server.py 