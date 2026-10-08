import pandas as pd
from pathlib import Path


# Project ke output/rejected folder ka path
BASE_DIR = Path(__file__).resolve().parent.parent
REJECTED_DIR = BASE_DIR / "uoutput" / "rejected"


def transform_data(customers, products, orders, payments):

    print("\n========== TRANSFORMATION STARTED ==========")

    # =========================
    # CUSTOMERS
    # =========================

    customers["Name"] = customers["Name"].str.strip()
    customers["City"] = customers["City"].str.strip()
    customers["Gender"] = customers["Gender"].str.strip()

    customers["Email"] = (
        customers["Email"]
        .str.strip()
        .str.lower()
    )

    customers["Signup_Date"] = pd.to_datetime(
        customers["Signup_Date"],
        errors="coerce"
    )

    customers["Modified_Date"] = pd.to_datetime(
        customers["Modified_Date"],
        errors="coerce"
    )

    # Remove duplicate customers
    customers = customers.drop_duplicates(
        subset=["Customer_ID"]
    )


    # =========================
    # PRODUCTS
    # =========================

    products["Product_Name"] = products["Product_Name"].str.strip()
    products["Category"] = products["Category"].str.strip()

    products["Price"] = pd.to_numeric(
        products["Price"],
        errors="coerce"
    )

    products["Modified_Date"] = pd.to_datetime(
        products["Modified_Date"],
        errors="coerce"
    )

    # Find products with missing/invalid price
    rejected_products = products[
        products["Price"].isna() |
        (products["Price"] <= 0)
    ].copy()

    rejected_products["Reject_Reason"] = (
        "Missing or invalid Price"
    )

    rejected_products.to_csv(
        REJECTED_DIR / "rejected_products.csv",
        index=False
    )

    # Keep only valid products
    products = products[
        products["Price"].notna() &
        (products["Price"] > 0)
    ].copy()

    products = products.drop_duplicates(
        subset=["Product_ID"]
    )


    # =========================
    # ORDERS
    # =========================

    orders["Order_Date"] = pd.to_datetime(
        orders["Order_Date"],
        errors="coerce"
    )

    orders["Modified_Date"] = pd.to_datetime(
        orders["Modified_Date"],
        errors="coerce"
    )

    orders["Quantity"] = pd.to_numeric(
        orders["Quantity"],
        errors="coerce"
    )

    orders["Total_Amount"] = pd.to_numeric(
        orders["Total_Amount"],
        errors="coerce"
    )

    # -------------------------
    # Missing Customer_ID
    # -------------------------

    rejected_orders_customer = orders[
        orders["Customer_ID"].isna()
    ].copy()

    rejected_orders_customer["Reject_Reason"] = (
        "Missing Customer_ID"
    )

    rejected_orders_customer.to_csv(
        REJECTED_DIR / "rejected_orders_customer.csv",
        index=False
    )

    orders = orders[
        orders["Customer_ID"].notna()
    ].copy()


    # -------------------------
    # Invalid Quantity
    # -------------------------

    rejected_quantity = orders[
        orders["Quantity"].isna() |
        (orders["Quantity"] <= 0)
    ].copy()

    rejected_quantity["Reject_Reason"] = (
        "Missing or invalid Quantity"
    )

    if not rejected_quantity.empty:

        rejected_quantity.to_csv(
            REJECTED_DIR / "rejected_orders_quantity.csv",
            index=False
        )

    orders = orders[
        orders["Quantity"].notna() &
        (orders["Quantity"] > 0)
    ].copy()


    # -------------------------
    # Invalid Total Amount
    # -------------------------

    rejected_amount = orders[
        orders["Total_Amount"].isna() |
        (orders["Total_Amount"] < 0)
    ].copy()

    rejected_amount["Reject_Reason"] = (
        "Missing or invalid Total_Amount"
    )

    if not rejected_amount.empty:

        rejected_amount.to_csv(
            REJECTED_DIR / "rejected_orders_amount.csv",
            index=False
        )

    orders = orders[
        orders["Total_Amount"].notna() &
        (orders["Total_Amount"] >= 0)
    ].copy()

    orders = orders.drop_duplicates(
        subset=["Order_ID"]
    )


    # =========================
    # PAYMENTS
    # =========================

    payments["Payment_Date"] = pd.to_datetime(
        payments["Payment_Date"],
        errors="coerce"
    )

    payments["Modified_Date"] = pd.to_datetime(
        payments["Modified_Date"],
        errors="coerce"
    )

    payments["Amount"] = pd.to_numeric(
        payments["Amount"],
        errors="coerce"
    )

    # Find payments with missing amount
    rejected_payments = payments[
        payments["Amount"].isna()
    ].copy()

    rejected_payments["Reject_Reason"] = (
        "Missing Payment Amount"
    )

    rejected_payments.to_csv(
        REJECTED_DIR / "rejected_payments.csv",
        index=False
    )

    # Keep only valid payments
    payments = payments[
        payments["Amount"].notna()
    ].copy()

    payments = payments.drop_duplicates(
        subset=["Payment_ID"]
    )


    # =========================
    # FINAL RESULTS
    # =========================

    print("\n========== TRANSFORMATION COMPLETED ==========")

    print("Valid Customers:", customers.shape)
    print("Valid Products:", products.shape)
    print("Valid Orders:", orders.shape)
    print("Valid Payments:", payments.shape)

    print("\nRejected Products:", len(rejected_products))
    print(
        "Rejected Orders - Customer:",
        len(rejected_orders_customer)
    )
    print(
        "Rejected Orders - Quantity:",
        len(rejected_quantity)
    )
    print(
        "Rejected Orders - Amount:",
        len(rejected_amount)
    )
    print(
        "Rejected Payments:",
        len(rejected_payments)
    )

    return customers, products, orders, payments