from fastapi import WebSocket
from typing import List
import asyncio

class WebSocketManager:
    def __init__(self, camera_service):
        self.active_connections: List[WebSocket] = []
        self.camera_service = camera_service
        self.broadcast_task = None
        
    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)
        
        if len(self.active_connections) == 1:
            self.camera_service.start()
            if self.broadcast_task is None:
                self.broadcast_task = asyncio.create_task(self.broadcast_frames())
    
    async def disconnect(self, websocket: WebSocket):
        if websocket in self.active_connections:
            self.active_connections.remove(websocket)
        
        # Stop camera 
        if not self.active_connections:
            self.camera_service.stop()
            if self.broadcast_task:
                self.broadcast_task.cancel()
                self.broadcast_task = None
    
    async def broadcast(self, data: str):
        for connection in self.active_connections.copy():
            try:
                await connection.send_text(data)
            except Exception:
                await self.disconnect(connection)
    
    async def broadcast_frames(self):
        try:
            while self.active_connections:
                frame = self.camera_service.camera_setup.get_frame()
                if frame is not None:
                    processed_frame = self.camera_service.process_frame(frame)
                    if processed_frame:
                        await self.broadcast(processed_frame)
                await asyncio.sleep(0.060)  
        except asyncio.CancelledError:
            pass