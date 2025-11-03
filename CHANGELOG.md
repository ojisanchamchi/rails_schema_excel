# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-11-03

### Changed
- Remove any previously generated worksheet with the same truncated name and emit a warning before recreating it, preventing export failures.
- Bump gem version to `1.0.0`.

## [0.1.0] - 2025-10-08

### Added
- Initial release
- Export Rails schema.rb to Excel format
- A5:SQL Mk-2 style layout with Japanese labels
- Support for tables, columns, indexes, constraints, and foreign keys
- Command line interface
- Ruby API for programmatic usage
