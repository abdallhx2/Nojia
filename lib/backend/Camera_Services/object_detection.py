import cv2
import base64
from ultralytics import YOLO

class ObjectDetection:
    
    def __init__(self, model_path='yolov8n.pt'):
        self.model = YOLO(model_path)
    
    def detect_and_process(self, frame):
        if frame is None:
            return None
            
        results = self.model(frame)
        if results and len(results) > 0:
            processed_frame = results[0].plot()
            _, buffer = cv2.imencode('.jpg', processed_frame, [cv2.IMWRITE_JPEG_QUALITY, 80])
            return base64.b64encode(buffer).decode('utf-8')
            
        return None
