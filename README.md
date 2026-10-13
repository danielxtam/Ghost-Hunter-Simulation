# Ghost Hunter Simulation

A multithreaded C simulation of a ghost hunt. Four hunters explore a haunted house while a ghost wanders the rooms and leaves behind evidence. The hunters try to collect enough evidence to identify the ghost before they get too scared or bored and give up.

## How It Works

- **The house** is made up of connected rooms. Each room tracks its hunters, its ghost (if present), and any evidence left behind.
- **The ghost** runs on its own thread. It moves between rooms and leaves evidence based on its type. If it goes too long without a hunter nearby, it gets bored and leaves.
- **The hunters** (4) each run on their own thread and carry a device for one evidence type. Each turn they move rooms, collect matching evidence, or review what they've gathered. All hunters share a single evidence list.
- **Fear and boredom:** a hunter's fear rises when they share a room with the ghost, and boredom rises when they don't. If either hits its limit, the hunter leaves.
- **Winning:** once the team has collected 3 different types of evidence, hunters who review it can identify the ghost and exit, and the hunters win. If all four hunters leave out of fear or boredom first, the ghost wins.
- **Synchronization:** semaphores protect rooms and evidence lists so the threads can safely share state.

### Ghost Types and Evidence

Each ghost leaves three of the four evidence types:

| Ghost | Evidence |
| --- | --- |
| Poltergeist | EMF, Temperature, Fingerprints |
| Banshee | EMF, Temperature, Sound |
| Bullies | EMF, Fingerprints, Sound |
| Phantom | Temperature, Fingerprints, Sound |

To identify the ghost, the hunters' devices must cover all three types it can leave. For the default Poltergeist, the team needs an EMF, a Temperature, and a Fingerprints device. A hunter carrying a device the ghost never leaves evidence for (such as Sound for the Poltergeist) can't collect anything.

## Project Structure

| File | Description |
| --- | --- |
| `main.c` | Program entry point: takes user input, starts the threads, and prints results |
| `defs.h` | Shared structs, enums, constants, and function prototypes |
| `action.c` | Hunter and ghost behavior and thread main loops |
| `house.c` | House setup and cleanup |
| `room.c` | Room creation, connections, and occupant handling |
| `evidence.c` | Evidence list operations |
| `init.c` | Initialization for the house, hunters, ghost, and lists |
| `logger.c` | Logging of simulation events |
| `utils.c` | Random number helpers, enum-to-string conversions, and status printing |
| `Makefile` | Build instructions |

## Requirements

- GCC
- POSIX threads and semaphores (Linux or macOS)

## Build and Run

```bash
make
./ghostsim
```

To clean up the build:

```bash
make clean
```

## Usage

When the program starts, it asks for a name and a device for each of the four hunters:

```
Enter the name for Hunter 1: Alice
...
Enter the device for hunter 1 (0. EMF, 1. TEMPERATURE, 2. FINGERPRINTS, 3.SOUND,): 0
...
```

Names should be a single word (no spaces). Devices are entered as numbers:

| Input | Device |
| --- | --- |
| `0` | EMF |
| `1` | Temperature |
| `2` | Fingerprints |
| `3` | Sound |

The simulation then runs on its own, logging hunter and ghost activity as it goes. When it finishes, the program prints:

- Why each hunter left, if they gave up (too bored or scared away)
- "The Ghost has won!" if all four hunters gave up
- The types of evidence that were collected
- "The hunters have won!" if enough evidence was collected before all hunters gave up
- The identified ghost type, if at least 3 types of evidence were found

## Configuration

Simulation settings can be changed in `defs.h`:

| Constant | Description |
| --- | --- |
| `FEAR_MAX` | Fear level at which a hunter flees |
| `BOREDOM_MAX` | Boredom level at which a hunter or ghost gives up |
| `LOGGING` | Set to `C_TRUE` or `C_FALSE` to toggle event logging |

## Notes
- The program is hardcoded to prompt for exactly four hunters.

## Author

[danielxtam](https://github.com/danielxtam)
