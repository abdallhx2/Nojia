import depthai as dai
import cv2
import numpy as np
import time

def create_pipeline():
    # إنشاء خط الأنابيب
    pipeline = dai.Pipeline()

    # تكوين الكاميرا RGB
    camRgb = pipeline.createColorCamera()
    spatialDetectionNetwork = pipeline.createYoloSpatialDetectionNetwork()
    xoutRgb = pipeline.createXLinkOut()
    nnOut = pipeline.createXLinkOut()

    xoutRgb.setStreamName("rgb")
    nnOut.setStreamName("detections")

    # إعدادات الكاميرا
    camRgb.setPreviewSize(416, 416)
    camRgb.setResolution(dai.ColorCameraProperties.SensorResolution.THE_1080_P)
    camRgb.setInterleaved(False)
    camRgb.setColorOrder(dai.ColorCameraProperties.ColorOrder.BGR)

    # إعدادات شبكة YOLO
    spatialDetectionNetwork.setBlobPath("yolo-v4-tiny-tf_openvino_2021.4_6shave.blob")
    spatialDetectionNetwork.setConfidenceThreshold(0.5)
    spatialDetectionNetwork.input.setBlocking(False)
    spatialDetectionNetwork.setBoundingBoxScaleFactor(0.5)
    spatialDetectionNetwork.setDepthLowerThreshold(100)
    spatialDetectionNetwork.setDepthUpperThreshold(5000)

    # ربط المكونات
    camRgb.preview.link(spatialDetectionNetwork.input)
    spatialDetectionNetwork.out.link(nnOut.input)
    camRgb.preview.link(xoutRgb.input)

    return pipeline

def main():
    # تحميل الأصناف
    with open("coco.names", "r") as f:
        class_names = [line.strip() for line in f.readlines()]

    # إنشاء الخط وبدء التشغيل
    pipeline = create_pipeline()
    device = dai.Device(pipeline)

    # الحصول على قوائم الانتظار
    qRgb = device.getOutputQueue(name="rgb", maxSize=4, blocking=False)
    qDet = device.getOutputQueue(name="detections", maxSize=4, blocking=False)

    frame = None
    detections = []

    print("بدء التشغيل... اضغط 'q' للخروج")

    while True:
        inRgb = qRgb.get()
        inDet = qDet.get()

        if inRgb is not None:
            frame = inRgb.getCvFrame()
        
        if inDet is not None:
            detections = inDet.detections

        if frame is not None:
            for detection in detections:
                # رسم المربع المحيط
                bbox = detection.boundingBox
                x1, y1 = int(bbox.xmin * frame.shape[1]), int(bbox.ymin * frame.shape[0])
                x2, y2 = int(bbox.xmax * frame.shape[1]), int(bbox.ymax * frame.shape[0])
                
                # الحصول على اسم الصنف
                label = class_names[detection.label]
                confidence = detection.confidence
                
                # رسم المربع والتسمية
                cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 0), 2)
                cv2.putText(frame, f"{label} {confidence:.2f}", (x1, y1 - 10),
                           cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)

            cv2.imshow("OAK-D Lite YOLO Detection", frame)

        if cv2.waitKey(1) == ord('q'):
            break

    cv2.destroyAllWindows()

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"حدث خطأ: {e}")