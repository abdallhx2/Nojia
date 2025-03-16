from fastapi import FastAPI
import uvicorn
from Camera_Services.camera_service import CameraService
from websocket_manager import WebSocketManager
from api_endpoints import register_endpoints

from Camera_Services.camera_setup import CameraSetup
from Camera_Services.object_detection import ObjectDetection
from firebase_manager import FirebaseManager

app = FastAPI()

camera_setup = CameraSetup()
object_detection = ObjectDetection()
firebase_manager = FirebaseManager()

camera_service = CameraService(camera_setup, object_detection, firebase_manager)
websocket_manager = WebSocketManager(camera_service)

register_endpoints(app, camera_service, websocket_manager)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)