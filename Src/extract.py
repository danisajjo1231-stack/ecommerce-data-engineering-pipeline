from pathlib import Path
import pandas as pd

# Script (Src) folder ka path
SRC_DIR = Path(__file__).resolve().parent

# Pehle inner folder try kare ga, agar na mile toh direct fixed path le le ga
DATA_DIR = SRC_DIR.with_name("data")

if not (DATA_DIR / "customers.csv").exists():
    DATA_DIR = Path(r"C:\Users\HP\OneDrive\Desktop\Danish Data\ecommerce_data_pipeline\ecommerce_data_pipeline\data")


def extract_data():
    customers = pd.read_csv(DATA_DIR / "customers.csv")
    products = pd.read_csv(DATA_DIR / "products.csv")
    orders = pd.read_csv(DATA_DIR / "orders.csv")
    payments = pd.read_csv(DATA_DIR / "payments.csv")

    print("Data extracted successfully!\n")

    print(f"Customers: {customers.shape}")
    print(f"Products: {products.shape}")
    print(f"Orders: {orders.shape}")
    print(f"Payments: {payments.shape}")

    return customers, products, orders, payments


if __name__ == "__main__":
    extract_data()