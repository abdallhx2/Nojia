from ultralytics import YOLO
import torch

# تحميل النموذج
model = YOLO('yolov8s.pt')

# تصدير النموذج لـ ONNX
model.export(format='onnx', 
            opset=12,
            simplify=True,
            dynamic=False,
            imgsz=640)

print("تم تحويل النموذج بنجاح إلى ONNX")