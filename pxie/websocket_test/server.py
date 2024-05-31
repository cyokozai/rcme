#!/usr/bin/env python

import asyncio
from websockets.server import serve

async def echo(websocket):
    async for message in websocket:
        await websocket.send(message + " from server")

async def main():
    async with serve(echo, "172.20.0.2", 8765):
        await asyncio.Future()  # run forever

asyncio.run(main())
