DATABASE_NAME="experiment"
PSQL_USER="admin"
POSTGRES_POD_NAME=$(kubectl get pods | grep postgres | awk '{print $1}' | head -n 1)

kubectl exec -it $POSTGRES_POD_NAME -- bin/sh -c "
  psql -U $PSQL_USER -d $DATABASE_NAME -c \"
   TRUNCATE TABLE \\\"user\\\", \\\"group\\\", usergroupstate  CASCADE;\"
  "
  if [ $? -eq 0 ]; then
    echo "Table cleared successfully."
  else
    echo "Failed to clear table!" >&2
    exit 1
  fi
