#!/bin/bash
K6_TEST_SCRIPTS=("import-test.js" "device-test.js" "sleep-test.js" "complex-test.js")
PORTS=("30808" "30809" "30810" "30811" "30812" "30813")

VUS=$1

mkdir test-results

# Function to clear data from the table
clear_table() {
  ./scripts/clear_db.sh
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
  export VUS=$VUS
  mkdir test-results/test-reports-$VUS-$port
  for script in "${K6_TEST_SCRIPTS[@]}"; do
    script_name="${script%.*}"
    run_k6_test $script "test-results/test-reports-${VUS}-${port}/html-report-${script_name}"
    report_index=$((report_index + 1))
  done
done


# Step 3: Remove all data from the table again
clear_table

echo "All tests completed and data cleared."
