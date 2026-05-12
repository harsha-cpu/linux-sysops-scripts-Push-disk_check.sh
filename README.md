# Linux SysOps Scripts

A collection of shell scripts I use for day to day Linux system administration and monitoring tasks. These are the kind of scripts that save time when you are managing multiple servers.

## Scripts

### disk_check.sh
Checks disk usage, memory, CPU load and top processes on a Linux server. Sends a warning if any disk partition goes above 80% usage. Logs everything to `/var/log/disk_check.log`.

## How to run

```bash
# clone the repo
git clone https://github.com/harsha-cpu/linux-sysops-scripts.git
cd linux-sysops-scripts

# give execute permission
chmod +x disk_check.sh

# run it
./disk_check.sh
```

## Sample output

```
[2024-11-01 10:00:00] Running system health check...

--- Disk Usage ---
[2024-11-01 10:00:01] OK: / is at 45%
[2024-11-01 10:00:01] WARNING: /data is at 85% — above threshold of 80%

--- Memory Usage ---
              total        used        free
Mem:           15Gi       8.2Gi       6.8Gi

--- CPU Load ---
 10:00:01 up 5 days, load average: 0.45, 0.38, 0.32

--- Top 5 Processes by Memory ---
USER       PID  %MEM  COMMAND
ubuntu    1234   8.2  java
ubuntu    5678   4.1  python3
```

## How to change the threshold

Open `disk_check.sh` and edit this line at the top:

```bash
THRESHOLD=80
```

Change 80 to whatever percentage you want alerts for.

## Schedule it with cron

To run this every 30 minutes automatically:

```bash
# open crontab
crontab -e

# add this line
*/30 * * * * /path/to/disk_check.sh
```

## Why I built this

In my work I manage Linux servers on AWS EC2. I wrote this script when we had a production incident caused by a disk filling up silently. After that I set this up as a cron job on all our servers so we get early warnings before things break.

---

— Harish

