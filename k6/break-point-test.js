import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  executor: 'ramping-arrival-rate',
  stages: [
    { duration: '5m', target: 15000 },
  ],
  thresholds: {
    'http_req_duration{status:200}': ['p(95)<60000'],

    'http_req_failed': ['rate<0.6'],
  },
};


export default function() {
  const port = __ENV.PORT;

  http.get(`http://192.168.49.2:${port}/test/complex-select`);
  sleep(1);
}
