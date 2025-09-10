# Crush Configuration

## Commands
# Install dependencies
pip install build '.[car,dev]'

# Run all tests
pytest -v -s tests

# Run single test (replace <test_path>)
pytest -v -s <test_path>

# Build package
python -m build

## Code Style
- Python 3.7+ compatible
- Follow existing patterns in codebase
- Use async/await for async operations
- Prefer type hints where possible
- Error handling: let exceptions propagate unless specific handling needed
- Imports: standard library first, then third-party, then local modules
- Naming: snake_case for functions/variables, PascalCase for classes
- Formatting: follow existing code style (no specific formatter configured)

## Notes
- Tests live in /tests directory
- Supports CAR file format via [car] extra
- IPFS Kubo 0.26.0 used for testing