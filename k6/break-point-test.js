import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  executor: 'ramping-arrival-rate',
  stages: [
    { duration: '30m', target: 50000 },
  ],
};


export default function() {
  const port = __ENV.PORT;

  http.get(`http://192.168.49.2:${port}/test/device`);
  sleep(1);
}
