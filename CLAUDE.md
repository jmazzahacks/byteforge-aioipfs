# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
aioipfs is an asynchronous Python library for interacting with IPFS (InterPlanetary File System) nodes using the RPC API. It supports kubo version 0.28.0 and is compatible with Python 3.6-3.12.

## Development Commands

### Running Tests
```bash
# Activate virtual environment first
source bin/activate

# Run all tests with coverage
pytest --cov --cov-report=term --cov-report=xml:coverage.xml -v -s tests

# Run a specific test file
pytest tests/test_client.py

# Run a specific test
pytest tests/test_client.py::TestBasicAPI::test_basic
```

### Linting and Type Checking
```bash
# Activate virtual environment
source bin/activate

# Run ruff linter
ruff check

# Run type checking with mypy
mypy aioipfs

# Format code with black
black aioipfs tests
```

### Installing Dependencies
```bash
# Activate virtual environment
source bin/activate

# Install package in development mode with all extras
pip install -e ".[orjson,car,bohort,dev]"

# Install development requirements
pip install -r dev-requirements.txt
```

## Architecture

### Core Components

- **AsyncIPFS** (`aioipfs/__init__.py`): Main client class that handles connection to IPFS nodes via RPC API. Supports multiple authentication methods (BasicAuth, BearerAuth) and multiaddr connections.

- **SubAPI Pattern** (`aioipfs/apis/`): APIs are organized as submodules that inherit from SubAPI base class:
  - `dag.py`: DAG (Directed Acyclic Graph) operations
  - `pin.py`: Pin management operations
  - `pubsub.py`: Pub/sub messaging system
  - `p2p.py`: P2P networking operations
  - `swarm.py`: Swarm/peer management
  - `multibase.py`: Multibase encoding/decoding

- **Main API Module** (`aioipfs/api.py`): Contains core API implementations including BitswapAPI, BlockAPI, ConfigAPI, FilesAPI, NameAPI, ObjectAPI, RepoAPI, and StatsAPI.

### Key Design Patterns

1. **Async Generators**: Most API methods that return multiple items use async generators (`async for` syntax)
2. **Context Managers**: Client supports async context manager protocol for proper resource cleanup
3. **Multiaddr Support**: Uses multiaddr format for specifying node addresses
4. **Streaming Support**: Large file operations use streaming to avoid memory issues

### Testing Infrastructure
- Uses pytest with pytest-asyncio for async test support
- Test fixtures in `tests/conftest.py` handle IPFS daemon setup
- CI runs tests against multiple go-ipfs/kubo versions (0.11.0-0.28.0)

## Important Notes

- This codebase uses virtual environments exclusively - never use system Python
- Unix timestamps should be used for all date/time storage (per user preferences)
- Type hints are required for all function parameters and return types
- The library supports optional JSON decoding with orjson for performance
- CAR (Content-Addressable Archives) support is optional via the ipfs-car-decoder package
- Bohort is a REPL tool included for interactive RPC calls on kubo nodes