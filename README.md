# nn

A command line tool to handle notes

## Interface

The `nn` interface is comprised of the following commands:

- **doctor**
- **new**
- **edit**
- **ls**
- **rm**
- **template**
    - **new**
    - **edit**
    - **rm**
    - **ls**
- **setup**
- **sync**

### Creating notes

```bash
nn new example.go # => $NOTE_DIR/YYYYmmdd_example.go

# Creates a note in a nested folder
nn new path/to/the/note.md # => $NOTE_DIR/path/to/the/note.md

# With default filetype `go`, set in config
nn new example # => $NOTE_DIR/example.go
```

### Configuring `nn`

`nn` stores settings in `.nn/settings.json`. `nn` looks for the settings in the
following hierarchy:

1. `$HOME/.nn/settings.json`
1. `$PWD/.nn/settings.json`
1. `ENV["NN_<SETTING_NAME>"]` (uppercased and underscored, without `default_`)

These are combined from the top down (local `.nn/settings.json` overwrites
previous settings).

`nn` offers the following configurations:

| setting | value type | required | default |
| ------- | ---------- | ------- | -------- |
| `default_file_type` | string | true | `'.md'` |
| `default_note_dir` | string | true | `cwd` (if a git directory) |
| `default_template` | string | false | `None` |
| `default_prefix` | string [(**ISO 8601**)](https://ruby-doc.org/stdlib-2.6.1/libdoc/date/rdoc/DateTime.html#method-i-strftime) | true | `'%Y%m%d'` |

```bash
# Creates a new `.nn/settings.json`, and walks through the configuration
nn config init

# Lists current settings (grouped by source)
nn config

# Sets one or more configs in $PWD/.nn/settings.json
nn config set <config>=<value> ... <configN>=<valueN>
```

### Templates

`nn` supports creating templates, and using them as a basis for creating new
notes.

`nn` stores templates in `$NOTE_DIR/.nn/templates/`

```bash
# To view available templates
nn template ls

# To create a new template
nn template new meeting     # => $NOTE_DIR/.nn/templates/meeting
nn template new meeting.md  # => $NOTE_DIR/.nn/templates/meeting.md

# Edit a template
nn template edit meeting    # => $NOTE_DIR/.nn/templates/meeting
nn template edit meeting.md # => $NOTE_DIR/.nn/templates/meeting.md

# To remove a template
nn template rm meeting.md

# Creates a note using `$NOTE_DIR/.nn/templates/meeting`
nn new poc.md -t meeting
```

### Syncing

`nn` syncs notes in `$NOTE_DIR` using git. It pushes up a commit titled `"Note
sync: %Y%m%d"`.

```bash
nn sync
```

## Development


