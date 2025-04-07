import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  stages: [
    { duration: '1m', target: __ENV.VUS },
    { duration: '5m', target: __ENV.VUS },
    { duration: '1m', target: 0 },
  ],
};


export default function() {
  const port = __ENV.PORT;

  http.get(`http://192.168.49.2:${port}/test/complex-select`);
  sleep(1);
}
