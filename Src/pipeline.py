from extract import extract_data
from transform import transform_data
from Validation import validate_data
from load import load_to_staging
def run_pipeline():

    print("========== PIPELINE STARTED ==========")

    # Extract
    customers, products, orders, payments = extract_data()

    # Transform
    customers, products, orders, payments = transform_data(
        customers,
        products,
        orders,
        payments
    )
    validate_data(
         customers,
         products,
         orders,
         payments
        
    )
    load_to_staging(
    customers,
    products,
    orders,
    payments
)

    print("\n========== PIPELINE COMPLETED ==========")


if __name__ == "__main__":
    run_pipeline()