#!/usr/bin/env python

import asyncio
from websockets.sync.client import connect

def hello():
    print("Hello world!")
    with connect("ws://172.20.0.2:8765") as websocket:
        websocket.send("Hello world!")
        message = websocket.recv()
        print(f"Received: {message}")

hello()
