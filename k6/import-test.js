import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
  iterations: 1,
};

const filePath = 'test-data.zip';
const fileContent = http.file(open(filePath, 'b'), 'test-data.zip');

export default function() {
  const port = __ENV.PORT;
  const data = {
    file: fileContent,
  }
  let res = http.post(`http://192.168.49.2:${port}/test/file-upload`, data);


  check(res, { 'success upload': (r) => r.status === 200 })
  sleep(1);
}
