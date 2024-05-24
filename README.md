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

## Usage with Cron

To schedule the `raid_status_checker.sh` script to run every hour using cron, follow these instructions:

1. **Locate the `ssacli` Command:**
   - Use the `which` command to find the location of the `ssacli` command on your system:
     ```bash
     which ssacli
     ```
   - The output will display the full path to the `ssacli` command.

2. **Update the Script:**
   - Open the `raid_status_checker.sh` script in a text editor.
   - Find the line that runs the `ssacli` command (e.g., `OUTPUT=$(ssacli ctrl slot=0 pd all show status)`).
   - Replace `ssacli` with the full path to the `ssacli` command obtained in step 1.

3. **Set up Cron Job:**
   - Open the cron table for editing:
     ```bash
     crontab -e
     ```
   - Add a new line to schedule the script to run every hour:
     ```bash
     0 * * * * /path/to/raid_status_checker.sh
     ```
     Replace `/path/to/raid_status_checker.sh` with the actual path to your script.

4. **Save and Exit:** 
   - Save the changes to the cron table and exit the editor.

## Troubleshooting Cron

If you encounter issues when running the script with cron, follow these troubleshooting steps:

1. **Redirect Output:**
   - Redirect both stdout and stderr of the cron job to a log file to capture any error messages or debug information:
     ```bash
     0 * * * * /path/to/raid_status_checker.sh >> /path/to/cron_log.log 2>&1
     ```

2. **Specify Full Paths:**
   - Specify the full path to the `ssacli` command in the script to ensure it is found by cron.

3. **Permissions:**
   - Ensure that the user executing the cron job has appropriate permissions to execute the script and access any necessary resources.

By following these troubleshooting steps, you should be able to diagnose and resolve any issues related to executing the script with cron.


If you encounter issues when running the script with cron, particularly if you receive a "command not found" error related to `ssacli`, follow these steps:

1. **Locate the `ssacli` Command:**
   - Use the `which` command to find the location of the `ssacli` command on your system:
     ```bash
     which ssacli
     ```
   - The output will display the full path to the `ssacli` command.

2. **Update the Script:**
   - Open the `raid_status_checker.sh` script in a text editor.
   - Find the line that runs the `ssacli` command (e.g., `OUTPUT=$(ssacli ctrl slot=0 pd all show status)`).
   - Replace `ssacli` with the full path to the `ssacli` command obtained in step 1.

3. **Save and Test:**
   - Save the changes to the script.
   - Test the script with cron to ensure that it executes successfully.

By following these steps, you should be able to resolve any issues related to executing the script with cron.


## Contribution

Contributions to this repository are welcome! If you have additional Wazuh configurations, improvements to existing configurations, or new documentation to add, please feel free to submit a pull request.

## License
This repository is licensed under the [MIT License](LICENSE).
