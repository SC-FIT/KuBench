import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  // vus: 2000,
  // duration: '60s',
  stages: [
    { duration: '5m', target: 1000 }, // traffic ramp-up from 1 to a higher 200 users over 10 minutes.
    { duration: '50m', target: 1000 }, // stay at higher 200 users for 30 minutes
    { duration: '5m', target: 0 }, // ramp-down to 0 users
  ],
};


export default function() {
  const port = __ENV.PORT;

  http.get(`http://192.168.49.2:${port}/test/complex-select`);
  sleep(1);
}
