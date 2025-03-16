from fastapi import FastAPI, WebSocket, HTTPException
from fastapi.responses import JSONResponse

def register_endpoints(app: FastAPI, camera_service, websocket_manager):
    
    @app.get("/camera/status")
    async def camera_status():
        return {"active": camera_service.camera_setup.is_active}
    
    @app.post("/camera/start")
    async def start_camera():
        success = camera_service.start()
        if success:
            return {"status": "Camera started successfully"}
        return {"status": "Camera already running"}
    
    @app.post("/camera/stop")
    async def stop_camera():
        success = camera_service.stop()
        if success:
            return {"status": "Camera stopped successfully"}
        return {"status": "Camera already stopped"}
    
    @app.websocket("/ws")
    async def websocket_endpoint(websocket: WebSocket):
        await websocket_manager.connect(websocket)
        try:
            while True:
                data = await websocket.receive_text()
        except Exception as e:
            print(f"WebSocket error: {e}")
        finally:
            await websocket_manager.disconnect(websocket)