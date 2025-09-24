import pandas as pd

def transform_data(df):
    """Transform the extracted data"""
    print("Starting data transformation...")
    
    # Clean and transform data
    df_transformed = df.copy()
    
    # Extract relevant columns
    columns_to_keep = ['id', 'name', 'email', 'phone']
    
    # Handle missing columns gracefully
    available_columns = [col for col in columns_to_keep if col in df.columns]
    df_transformed = df_transformed[available_columns]
    
    # Clean email addresses
    if 'email' in df_transformed.columns:
        df_transformed['email'] = df_transformed['email'].str.lower()
    
    # Add a processed timestamp
    from datetime import datetime
    df_transformed['processed_at'] = datetime.now()
    
    print(f"Transformed {len(df_transformed)} records")
    return df_transformed

if __name__ == "__main__":
    # Test transformation
    sample_df = pd.DataFrame([
        {"id": 1, "name": "John Doe", "email": "JOHN@EXAMPLE.COM", "phone": "123-456-7890"}
    ])
    transformed = transform_data(sample_df)
    print(transformed)