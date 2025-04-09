DATABASE_NAME="experiment"
PSQL_USER="admin"
POSTGRES_POD_NAME=$(kubectl get pods | grep postgres | awk '{print $1}' | head -n 1)
PATH_TO_DUMP_FILE="database/experiment-dump.sql"

kubectl cp $PATH_TO_DUMP_FILE $POSTGRES_POD_NAME:/tmp/experiment-dump.sql
kubectl exec -it $POSTGRES_POD_NAME -- bin/sh -c "
  psql -U $PSQL_USER -d $DATABASE_NAME -f /tmp/experiment-dump.sql
  "
  if [ $? -eq 0 ]; then
    echo "Database restored successfully."
  else
    echo "Failed to restore database!" >&2
    exit 1
  fi
