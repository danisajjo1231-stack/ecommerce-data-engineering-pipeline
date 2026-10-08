from sqlalchemy import create_engine


SERVER = "localhost"
DATABASE = "ECommerceDW"

CONNECTION_STRING = (
    "mssql+pyodbc://@"
    + SERVER
    + "/"
    + DATABASE
    + "?driver=ODBC+Driver+18+for+SQL+Server"
    + "&trusted_connection=yes"
    + "&Encrypt=no"
)

engine = create_engine(CONNECTION_STRING)


def load_to_staging(
    customers,
    products,
    orders,
    payments
):

    print("\n========== LOADING TO SQL SERVER ==========")

    customers.to_sql(
        "customers",
        engine,
        schema="staging",
        if_exists="replace",
        index=False
    )

    print("Customers loaded.")

    products.to_sql(
        "products",
        engine,
        schema="staging",
        if_exists="replace",
        index=False
    )

    print("Products loaded.")

    orders.to_sql(
        "orders",
        engine,
        schema="staging",
        if_exists="replace",
        index=False
    )

    print("Orders loaded.")

    payments.to_sql(
        "payments",
        engine,
        schema="staging",
        if_exists="replace",
        index=False
    )

    print("Payments loaded.")

    print("========== SQL SERVER LOAD COMPLETED ==========")
    