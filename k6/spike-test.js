import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  // Key configurations for spike in this section
  stages: [
    { duration: '2m', target: 4000 }, // fast ramp-up to a high point
    // No plateau
    { duration: '1m', target: 0 }, // quick ramp-down to 0 users
  ],
};


export default function() {
  const port = __ENV.PORT;
  http.get(`http://192.168.49.2:${port}/test/random-sleep`);
  sleep(1);
}
