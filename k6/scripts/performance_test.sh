#!/bin/bash

# k6 test scripts
K6_TEST_SCRIPTS=("import-test.js" "load-test.js" "spike-test.js" "break-point-test.js")
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
  clear_table
  report_index=1
  export PORT=$port
  mkdir test-results/test-reports-3-$port
  for script in "${K6_TEST_SCRIPTS[@]}"; do
    run_k6_test $script "test-results/test-reports-3-${port}/html-report-${report_index}"
    report_index=$((report_index + 1))
  done
done
#export PORT="30809"
#mkdir test-reports
#for script in "${K6_TEST_SCRIPTS[@]}"; do
#  run_k6_test $script "test-reports/html-report-${report_index}.html"
#  report_index=$((report_index + 1))
#done

# Step 3: Remove all data from the table again
#clear_table

echo "All tests completed and data cleared."
