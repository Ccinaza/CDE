import pandas as pd
from sqlalchemy import create_engine, text
import time

def load_data(df, connection_string):
    """Load transformed data into database"""
    print("Starting data loading...")
    
    # Wait for database to be ready
    max_retries = 30
    for attempt in range(max_retries):
        try:
            engine = create_engine(connection_string)
            with engine.connect() as conn:
                conn.execute(text("SELECT 1"))
            break
        except Exception as e:
            print(f"Attempt {attempt + 1}: Database not ready, waiting...")
            time.sleep(2)
    else:
        raise Exception("Could not connect to database after 30 attempts")
    
    try:
        # Load data to database
        df.to_sql('users', engine, if_exists='replace', index=False)
        print(f"Successfully loaded {len(df)} records to database")
        
        # Verify load
        with engine.connect() as conn:
            result = conn.execute(text("SELECT COUNT(*) FROM users"))
            count = result.fetchone()[0]
            print(f"Verification: {count} records in database")
        
    except Exception as e:
        print(f"Error during loading: {e}")
        raise

if __name__ == "__main__":
    # Test connection
    conn_string = "postgresql://user:password@localhost:5432/etldb"
    sample_df = pd.DataFrame([
        {"id": 1, "name": "Test User", "email": "test@example.com"}
    ])
    load_data(sample_df, conn_string)