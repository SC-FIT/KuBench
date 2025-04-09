#!/bin/bash
PORTS=("30808" "30809" "30810" "30811" "30812" "30813")

# Function to clear data from the table
clear_table() {
  ./database/clear_db.sh
}

# Function to run a k6 test
run_k6_test() {
  local test_script=$1
  local export_path=$2
  echo "Running k6 test '$test_script' with report export to: $export_path"
  K6_WEB_DASHBOARD=true K6_WEB_DASHBOARD_EXPORT=$export_path.html k6 run --out csv=$export_path.csv $test_script
  if [ $? -eq 0 ]; then
    echo "Test '$test_script' completed successfully."
  else
    echo "Test '$test_script' failed on threshold!" >&2
  fi
}

# Main script execution
echo "Starting script..."

# Step 2: Run k6 tests with different scripts and report paths
for port in "${PORTS[@]}"; do
  export PORT=$port
  mkdir test-results/ramp-up
  run_k6_test "ramp-up-test.js" "test-results/ramp-up/html-report-${port}"
done

echo "All tests completed and data cleared."
