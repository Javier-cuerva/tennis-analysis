# Function to write logs during execution
function log {
  echo $1
  }

PROJECT_PATH=/home/javier/projects/tennis

# Pulls database docker image and runs it
log "Pulling database docker image and running it"
docker pull mcekovic/uts-database
docker run -p 5432:5432 -d --name uts-database mcekovic/uts-database

# Starts database container
log "Starting uts-database"
docker start uts-database > /dev/null

# Moves sql-commands.sql from host to container
docker exec -it uts-database mkdir /tmp/tennis
log "Moving PSQL script to container"
docker cp $PROJECT_PATH/psql-script.sh  uts-database:/tmp/tennis/

# Executes SQL queries and saves results to CSV files
log "Executing PSQL script and creating CSV files"
docker exec -it uts-database psql -U tcb -f /tmp/tennis/psql-script.sh > /dev/null

# Brings the CSV files to host
docker cp uts-database:/tmp/tennis/match.csv $PROJECT_PATH/dataset
docker cp uts-database:/tmp/tennis/match_stats.csv $PROJECT_PATH/dataset
docker cp uts-database:/tmp/tennis/set_score.csv $PROJECT_PATH/dataset
docker cp uts-database:/tmp/tennis/player.csv $PROJECT_PATH/dataset
log "All CSV have been moved to host machine succesfully"

# Deletes CSV files from the container
docker exec -it uts-database rm /tmp/tennis/*.csv
log "All CSV have been removed from container"
