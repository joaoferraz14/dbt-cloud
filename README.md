Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](http://community.getbdt.com/) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


### Generic notes
- `dbt build` will run the model + the tests for each node of the dag, preventing it to build downstream models with erros. if a test fails, the next node will not run

### Generic and singular tests
- Generic tests applied to columns (unique, not_null, accepted_values, relationships)
    - The relationship test in dbt is a type of generic test that checks the referential integrity between two tables. In simpler terms, it makes sure that foreign key values in one table have corresponding primary key values in another table.
    For example, if you have an orders table with a `user_id` column and a users table with an `id` column, you can set up a relationship test to ensure every `user_id` in the orders table corresponds to an `id` in the users table. This ensures there are no orphaned orders (i.e., orders without a valid user).
    
- sql code using the source or ref macros on tests folder -  test it run the command `dbt test --select model_name`
- Tests can be run against your current project using a range of commands:
    `dbt test` runs all tests in the dbt project
    `dbt test --select test_type:generic`
    `dbt test --select test_type:singular`
    `dbt test --select one_specific_model`

### Materialization precedence
- 1 dbt_project yaml file
- 2 model yaml file
- 3 sql code

### Useful commands
- list dependecies on models `dbt list -m model_name` or `dbt list -m model_name+1` to see 1 downstream direct dependecy
- list dependecies on models and all assertions associated with them `dbt list --select +model_name`
- build all upstream models and test  with `dbt build --select +model_name` or its nmr of downstreams dependencies `dbt build --select +model_name+<number>`
- `dbt run --select my_model+1`         # select my_model and its first-degree children
- `dbt run --select 2+my_model`         # select my_model, its first-degree parents, and its second-degree parents ("grandparents")
- `dbt run --select 3+my_model+4`       # select my_model, its parents up to the 3rd degree, and its children down to the 4th degree

### Use the following dbt commands in the CLI and use the dbt prefix. For example, to run the test command, type dbt test. (https://docs.getdbt.com/reference/dbt-commands)

- `build`: build and test all selected resources (models, seeds, snapshots, tests)
- `clean`: deletes artifacts present in the dbt project
- `clone`: clone selected models from specified state (requires dbt 1.6 or higher)
- `compile`: compiles (but does not run) the models in a project
- `debug`: debugs dbt connections and projects
- `deps`: downloads dependencies for a project
- `docs` : generates documentation for a project
- `init`: initializes a new dbt project
- `list`: lists resources defined in a dbt project
- `parse`: parses a project and writes detailed timing info
- `retry`: retry the last run dbt command from the point of failure (requires dbt 1.6 or higher)
- `rpc`: runs an RPC server that clients can submit queries to
- `run`: runs the models in a project
- `run-operation`: invoke a macro, including running arbitrary maintenance SQL against the database
- `seed`: loads CSV files into the database
- `show`: preview table rows post-transformation
- `snapshot`: executes "snapshot" jobs defined in a project
- `source`: provides tools for working with source data (including validating that sources are "fresh")
- `test`: executes tests defined in a project