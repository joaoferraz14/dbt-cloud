-- best to use the dbt utils union macro. more complete, handles mismatch in columns
{{
    union_tables_by_prefix(
        database='RAW',
        schema='PUBLIC',
        prefix='orders__'
    )
}}