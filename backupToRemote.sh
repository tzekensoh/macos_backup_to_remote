#!/bin/bash

# List of subdirectory names
subdirs=("images" "video" "audio" "bin" "text" "test") # "edubiz")

# Local main directory name
local_main_dir="/Volumes/Extreme SSD/mir"

# Remote details - NO SPACES via custom mount /Volumes/CrucialX6
remote_user="ksoh"
remote_ip="192.168.68.60"
remote_main_dir="/Volumes/extdrv/mir"

# Log file name
log_file="/Volumes/Extreme SSD/mir/backupToRemote.log"

# Ensure remote dir exists (one-time setup)
ssh "${remote_user}@${remote_ip}" "mkdir -p '${remote_main_dir}'" || true

# Loop through each subdirectory
for subdir in "${subdirs[@]}"; do
  echo "===== $(date '+%Y-%m-%d %H:%M:%S') Starting sync for ${subdir} =====" | tee -a "$log_file"
  
  rsync -avz \
    "${local_main_dir}/${subdir}/" \
    "${remote_user}@${remote_ip}:${remote_main_dir}/${subdir}/" 2>&1 | tee -a "$log_file"
  
  echo "===== $(date '+%Y-%m-%d %H:%M:%S') Finished sync for ${subdir} =====" | tee -a "$log_file"
  echo "" | tee -a "$log_file"
done
