def validate_data(customers, products, orders, payments):

    print("\n========== DATA QUALITY CHECKS ==========")

    print("\n--- CUSTOMERS ---")
    print("Duplicate IDs:", customers["Customer_ID"].duplicated().sum())
    print("Missing IDs:", customers["Customer_ID"].isna().sum())

    print("\n--- PRODUCTS ---")
    print("Duplicate IDs:", products["Product_ID"].duplicated().sum())
    print("Missing Prices:", products["Price"].isna().sum())

    print("\n--- ORDERS ---")
    print("Duplicate IDs:", orders["Order_ID"].duplicated().sum())
    print("Missing Customer IDs:", orders["Customer_ID"].isna().sum())
    print("Invalid Quantity:", (orders["Quantity"] <= 0).sum())
    print("Invalid Amount:", (orders["Total_Amount"] < 0).sum())

    print("\n--- PAYMENTS ---")
    print("Duplicate IDs:", payments["Payment_ID"].duplicated().sum())
    print("Missing Amount:", payments["Amount"].isna().sum())

    print("\n========== VALIDATION COMPLETED ==========")