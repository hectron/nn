# nnn

A command line tool to handle notes

## Interface

The `nnn` interface is comprised of the following components:


- <the default path>
- **setup**
- **templates**
- **ls**
- **sync**

### Creating notes

```bash
# The following opens a new prefixed note, with the default filetype
nnn # => $NOTE_DIR/<prefix>.<default-filetype>

# If the file path has a filetype, it will be observed, otherwise the default
# filetype will be used
nnn example.go # => $NOTE_DIR/example.go

# With default filetype `go`, set in config
nnn example # => $NOTE_DIR/example.go

# Creates a note in a nested folder
nnn path/to/the/note.md # => $NOTE_DIR/path/to/the/note.md

# Same as above
nnn path to the note.md # => $NOTE_DIR/path/to/the/note.md

```

### Configuring `nnn`

`nnn` stores settings in `.nnn/settings.json`. `nnn` looks for the settings in the
following hierarchy:

1. `$HOME/.nnn/settings.json`
1. `$PWD/.nnn/settings.json`
1. `ENV["NNN_<SETTING_NAME>"]` (uppercased and underscored, without `default_`)

These are combined from the top down (local `.nnn/settings.json` overwrites
previous settings).

`nnn` offers the following configurations:

| setting | value type | default |
| ------- | ---------- | ------- |
| `default_file_type` | string | `'.md'` |
| `default_editor` | string | `'vim'` |
| `default_note_dir` | string | `cwd` |
| `default_template` | string | `None` |
| `default_prefix` | [string [(**ISO 8601**)](https://ruby-doc.org/stdlib-2.6.1/libdoc/date/rdoc/DateTime.html#method-i-strftime) | `'%Y%m%d%H%M%S'` |

```bash
# Creates a new `.nnn/settings.json`, and walks through the configuration
nnn config init

# Creates a new `$HOME/.nnn/settings.json` and walks through the configuration
nnn config init -g

# Lists current settings (grouped by source)
nnn config

# Sets one or more configs in $PWD/.nnn/settings.json
nnn config set <config>=<value> ... <configN>=<valueN>

# Sets one or more configs in $HOME/.nnn/settings.json
nnn config set <config>=<value> ... <configN>=<valueN> -g
```

### Templates

`nnn` supports creating templates, and using them as a basis for creating new
notes.

`nnn` stores templates in `$NOTE_DIR/.nnn/templates/`

```bash
# To view available templates
nnn template ls

# Edit a template (create if doesn't exist)
nnn template meeting # => $NOTE_DIR/.nnn/templates/meeting
nnn template meeting.md # => $NOTE_DIR/.nnn/templates/meeting.md

# To remove a template
nnn template rm <template>

# Using a template
# Creates a note with a specific template
nnn -t meeting # Uses `$NOTE_DIR/.nnn/templates/meeting`
nnn poc.md -t meeting # Creates $NOTE_DIR/poc.md, using `$NOTE_DIR/.nnn/templates/meeting`
```
