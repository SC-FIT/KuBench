#!/bin/bash
PORTS=("30808" "30809" "30810" "30811" "30812" "30813")

VUS=500

# Function to clear data from the table
clear_table() {
  ./database/clear_db.sh
}

# Function to run a k6 test
run_k6_test() {
  local test_script=$1
  local export_path=$2
  echo "Running k6 test '$test_script' with report export to: $export_path"
  K6_WEB_DASHBOARD=true K6_WEB_DASHBOARD_EXPORT=$export_path.html k6 run $test_script
  if [ $? -eq 0 ]; then
    echo "Test '$test_script' completed successfully."
  else
    echo "Test '$test_script' failed!" >&2
    exit 1
  fi
}

# Main script execution
echo "Starting script..."

# Step 2: Run k6 tests with different scripts and report paths
for port in "${PORTS[@]}"; do
  export PORT=$port
  export VUS=$VUS
  mkdir test-results/complex-test
  run_k6_test "complex-test.js" "test-results/complex-test/html-report-${port}"
done

echo "All tests completed and data cleared."
