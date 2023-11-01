#!/bin/bash

# dinf pid for command 'sudo npm run start'
pid=$(ps aux | grep 'ng serve' | awk '{print $2}')

# verify pid is valid
if [ -n "$pid" ]; then
  # kill the process
  sudo kill $pid
  echo "Process with PID $pid was killed."
else
  echo "No process was found"
fi