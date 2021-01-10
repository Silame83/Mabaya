#!/usr/bin/python3
# A web server to echo back a request's headers and data.
#
# Usage: ./webserver
#        ./webserver 0.0.0.0:5000

from http.server import HTTPServer, BaseHTTPRequestHandler
from sys import argv
import socket
import time
import datetime
import pymysql

ts = time.time()
timestamp = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')

# Open database connection

db = pymysql.connect(host="localhost",user="ubuntu",password="Silame83@gmail.com",db="mabaya")

# prepare a cursor object using cursor() method
cursor = db.cursor()

# Add new column into table.
cursor.execute("CREATE TABLE requests (headers TEXT, contents VARCHAR(255), datetimes DATETIME)")

hostname = socket.gethostname()

BIND_HOST = hostname
PORT = 8008


class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.write_response(b'')

    def do_POST(self):
        content_length = int(self.headers.get('content-length', 0))
        body = self.rfile.read(content_length)

        self.write_response(body)

    def write_response(self, content):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(content)

        cursor.execute("""INSERT INTO requests (headers, contents, datetimes) values(%s, %s, %s)""", (self.headers,content.decode('utf-8'),timestamp))
        db.commit()


if len(argv) > 1:
    arg = argv[1].split(':')
    BIND_HOST = arg[0]
    PORT = int(arg[1])

print(f'Listening on http://{BIND_HOST}:{PORT}\n')

httpd = HTTPServer((BIND_HOST, PORT), SimpleHTTPRequestHandler)
httpd.serve_forever()