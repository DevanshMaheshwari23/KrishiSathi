// A simple crop prediction service that works offline
class CropPredictor {
  // Decision tree model for crop prediction
  static String predictCrop({
    required double n,
    required double p,
    required double k,
    required double temperature,
    required double humidity,
    required double ph,
    required double rainfall,
    required double durationmonths,
    double period = 0,
  }) {
    // Print input values for debugging
    print(
        "INPUTS: N=$n, P=$p, K=$k, temp=$temperature, humidity=$humidity, ph=$ph, rainfall=$rainfall, duration=$durationmonths");

    // Example values from GodFile.csv for each crop

    // Rice (high rainfall, high humidity)
    if (n < 80 &&
        p > 35 &&
        k > 35 &&
        temperature > 20 &&
        temperature < 30 &&
        humidity > 80 &&
        rainfall > 150) {
      return 'rice';
    }

    // Maize (moderate nitrogen, temperature)
    if (n > 80 &&
        n < 120 &&
        p > 30 &&
        k < 50 &&
        temperature > 18 &&
        temperature < 32 &&
        humidity < 80 &&
        rainfall > 60 &&
        rainfall < 200) {
      return 'maize';
    }

    // Pomegranate (specific pH and rainfall)
    if (p > 40 &&
        k > 40 &&
        temperature > 20 &&
        temperature < 35 &&
        humidity < 80 &&
        ph > 6 &&
        ph < 7.5 &&
        rainfall > 30 &&
        rainfall < 100) {
      return 'pomegranate';
    }

    // Mango (warm temp, moderate rainfall)
    if (temperature > 24 &&
        temperature < 35 &&
        humidity < 80 &&
        ph > 5.5 &&
        ph < 7 &&
        rainfall > 50 &&
        rainfall < 150 &&
        k > 30) {
      return 'mango';
    }

    // Apple (cooler temperatures, higher rainfall)
    if (temperature > 10 && temperature < 24 && ph < 6.5 && rainfall > 100) {
      return 'apple';
    }

    // Chickpea (specific soil conditions)
    if (temperature > 15 &&
        temperature < 25 &&
        ph > 6.5 &&
        rainfall < 100 &&
        n < 60 &&
        p > 50) {
      return 'chickpea';
    }

    // Grapes (moderate temperatures, specific pH)
    if (temperature > 15 &&
        temperature < 30 &&
        ph > 5.5 &&
        ph < 8.0 &&
        rainfall > 40 &&
        rainfall < 120 &&
        k > 100) {
      return 'grapes';
    }

    // Watermelon (warm, moderate rainfall)
    if (temperature > 25 &&
        temperature < 35 &&
        humidity < 70 &&
        rainfall > 40 &&
        rainfall < 80 &&
        n > 50) {
      return 'watermelon';
    }

    // Cotton (warm, moderate rainfall, higher pH)
    if (temperature > 25 &&
        temperature < 35 &&
        ph > 6.0 &&
        rainfall > 60 &&
        rainfall < 110) {
      return 'cotton';
    }

    // Orange (moderate temp, specific pH)
    if (temperature > 15 &&
        temperature < 30 &&
        ph > 5.5 &&
        ph < 7.0 &&
        rainfall > 80 &&
        rainfall < 150) {
      return 'orange';
    }

    // Papaya (warm, good rainfall)
    if (temperature > 22 &&
        temperature < 35 &&
        ph > 6.0 &&
        ph < 7.0 &&
        rainfall > 80 &&
        rainfall < 150) {
      return 'papaya';
    }

    // Coconut (warm, high rainfall)
    if (temperature > 25 &&
        temperature < 35 &&
        rainfall > 150 &&
        humidity > 70) {
      return 'coconut';
    }

    // Banana (warm, good rainfall)
    if (temperature > 20 &&
        temperature < 30 &&
        rainfall > 120 &&
        ph > 5.5 &&
        ph < 7.0) {
      return 'banana';
    }

    // Kidneybeans (moderate temp)
    if (temperature > 18 &&
        temperature < 25 &&
        rainfall > 60 &&
        rainfall < 100 &&
        ph > 5.5 &&
        ph < 7.0) {
      return 'kidneybeans';
    }

    // Muskmelon (warm, lower rainfall)
    if (temperature > 25 &&
        temperature < 35 &&
        humidity < 60 &&
        rainfall > 40 &&
        rainfall < 70) {
      return 'muskmelon';
    }

    // Lentil (cooler temp, specific soil)
    if (temperature > 15 &&
        temperature < 25 &&
        rainfall > 40 &&
        rainfall < 100 &&
        ph > 5.5 &&
        ph < 7.0 &&
        n < 80) {
      return 'lentil';
    }

    // Pigeonpeas (moderate to warm)
    if (temperature > 20 &&
        temperature < 32 &&
        rainfall > 60 &&
        rainfall < 150 &&
        p < 70) {
      return 'pigeonpeas';
    }

    // Mothbeans (warm, low rainfall)
    if (temperature > 25 &&
        temperature < 35 &&
        rainfall < 80 &&
        ph > 5.0 &&
        ph < 7.0) {
      return 'mothbeans';
    }

    // Mungbean (warm, moderate rainfall)
    if (temperature > 20 &&
        temperature < 35 &&
        rainfall > 60 &&
        rainfall < 100 &&
        ph > 6.0 &&
        ph < 7.5) {
      return 'mungbean';
    }

    // Blackgram (warm, specific humidity)
    if (temperature > 25 &&
        temperature < 35 &&
        humidity > 60 &&
        rainfall > 60 &&
        rainfall < 100) {
      return 'blackgram';
    }

    // Coffee (cooler temps, high rainfall)
    if (temperature > 15 &&
        temperature < 25 &&
        rainfall > 150 &&
        humidity > 70 &&
        ph > 5.5 &&
        ph < 6.5) {
      return 'coffee';
    }

    // Jute (warm, high rainfall)
    if (temperature > 25 &&
        temperature < 35 &&
        rainfall > 150 &&
        humidity > 70 &&
        ph > 6.0 &&
        ph < 7.5) {
      return 'jute';
    }

    // NPK-based fallback predictor
    if (n > 100) {
      if (p > 100 && k > 100) {
        return 'cotton';
      } else if (p > k) {
        return 'maize';
      } else {
        return 'pomegranate';
      }
    } else if (n > 50) {
      if (rainfall > 100) {
        return 'rice';
      } else if (temperature > 25) {
        return 'mango';
      } else {
        return 'orange';
      }
    } else {
      if (ph > 6.5) {
        return 'chickpea';
      } else if (temperature > 25) {
        return 'blackgram';
      } else {
        return 'lentil';
      }
    }
  }

  // Validation method - test with specific examples from GodFile.csv
  static void validateWithExamples() {
    // Example 1: Rice
    print("Rice test: ${predictCrop(
            n: 80,
            p: 40,
            k: 40,
            temperature: 23.5,
            humidity: 82,
            ph: 6.5,
            rainfall: 200,
            durationmonths: 4)}");

    // Example 2: Maize
    print("Maize test: ${predictCrop(
            n: 90,
            p: 42,
            k: 43,
            temperature: 26,
            humidity: 52,
            ph: 7.0,
            rainfall: 88,
            durationmonths: 5)}");

    // Example 3: Chickpea
    print("Chickpea test: ${predictCrop(
            n: 40,
            p: 60,
            k: 55,
            temperature: 19,
            humidity: 50,
            ph: 7.1,
            rainfall: 60,
            durationmonths: 4)}");

    // Example 4: Mango
    print("Mango test: ${predictCrop(
            n: 20,
            p: 30,
            k: 40,
            temperature: 30,
            humidity: 70,
            ph: 6.1,
            rainfall: 80,
            durationmonths: 8)}");
  }
}
