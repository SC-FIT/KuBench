import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  stages: [
    { duration: '5m', target: 1000 },
    { duration: '50m', target: 1000 },
    { duration: '5m', target: 0 },
  ],
};


export default function() {
  const port = __ENV.PORT;

  http.get(`http://192.168.49.2:${port}/test/complex-select`);
  sleep(1);
}
