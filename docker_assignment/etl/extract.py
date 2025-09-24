import pandas as pd
import requests
import json

def extract_data():
    """Extract data from a sample API"""
    print("Starting data extraction...")
    
    # Using JSONPlaceholder API for sample data
    url = "https://jsonplaceholder.typicode.com/users"
    
    try:
        response = requests.get(url)
        data = response.json()
        
        df = pd.DataFrame(data)
        print(f"Extracted {len(df)} records")
        return df
    
    except Exception as e:
        print(f"Error during extraction: {e}")
        # Fallback sample data
        sample_data = [
            {"id": 1, "name": "John Doe", "email": "john@example.com", "phone": "123-456-7890"},
            {"id": 2, "name": "Jane Smith", "email": "jane@example.com", "phone": "098-765-4321"}
        ]
        return pd.DataFrame(sample_data)

if __name__ == "__main__":
    data = extract_data()
    print(data.head())