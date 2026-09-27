from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json

class Handler(BaseHTTPRequestHandler):
    def do_POST(self):
        if self.path != '/translate':
            self.send_error(404); return
        length = int(self.headers.get('Content-Length', '0'))
        self.rfile.read(length)
        raw = json.dumps({'ok': False, 'error': 'model_not_loaded'}).encode()
        self.send_response(503)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Length', str(len(raw)))
        self.end_headers(); self.wfile.write(raw)
    def log_message(self, fmt, *args):
        return

if __name__ == '__main__':
    ThreadingHTTPServer(('127.0.0.1', 8091), Handler).serve_forever()
