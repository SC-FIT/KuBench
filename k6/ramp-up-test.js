import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 100 },
    { duration: '1m', target: 100 },
    { duration: '30s', target: 1000 },
    { duration: '1m', target: 1000 },
    { duration: '30s', target: 5000 },
    { duration: '1m', target: 5000 },
    { duration: '30s', target: 0 },
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
