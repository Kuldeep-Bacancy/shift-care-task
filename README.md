### Prerequisites

The setups steps expect following tools installed on the system.

- Ruby
- Used optparse library to parse command line options.(https://github.com/ruby/optparse)

### There are few assumptions i have made.
- All hash have same fields in json file i.e all hash have id, full_name and email as per sample file.
- You must have to specify file name with full path while running any commnds
- If you don't specify filed name then it will search with full_name

### Give proper permissons to file
- ```chmod +x shift_care_task.rb```

### Check out the repository

```bash
git clone https://github.com/Kuldeep-Bacancy/shift-care-task.git
```

### Commands

#### - List all commands for help
   - ``` ./shift_care_task.rb --help ```

#### - Search with field name email and search value test with file clients.json
  - ```./shift_care_task.rb --search="test" --field_name="email" --file="clients.json"```

#### - Search with field name full_name and search value test with file clients.json
  - ```./shift_care_task.rb --search="test" --file="clients.json"```

#### - Find duplicates
  -  ```./shift_care_task.rb --duplicates --file="clients.json"```
