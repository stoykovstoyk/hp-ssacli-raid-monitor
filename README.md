# RAID Status Checker Script

This script checks the status of all physical drives in a RAID array using the `ssacli` tool. It then logs the status of the RAID array to syslog, indicating whether all drives are okay or if there is an issue detected.

## Prerequisites

- [ssacli](https://support.hpe.com/connect/s/softwaredetails?language=en_US&collectionId=MTX-23cd69af016f4833)
- `logger` command (usually available by default on most Unix-like systems)

## Usage

1. Make the script executable:
```bash
chmod +x raid_status_checker.sh
```
1. Run the script:

```bash
./raid_status_checker.sh
```

## Script Overview

#### Run ssacli to Check RAID Status

- The script runs the ssacli command to check the status of all physical drives in the RAID array.

#### Remove Line Breaks from Output

- Line breaks in the ssacli output are removed using the tr command to ensure proper processing.

#### Check Drive Status

- Each line of the cleaned output is processed to check if the drive status ends with "OK".

#### Log RAID Status

- If any drive status is not "OK", an alert message is logged to syslog indicating the issue. Otherwise, a message indicating that all drives are okay is logged.

## Example Output

- If all drives are okay:
```bash
RAID Status: All drives are OK
```

- If an issue is detected:
```bash
RAID Alert: Drive issue detected - <output>
```


## Contribution

Contributions to this repository are welcome! If you have additional Wazuh configurations, improvements to existing configurations, or new documentation to add, please feel free to submit a pull request.

## License
This repository is licensed under the [MIT License](LICENSE).
