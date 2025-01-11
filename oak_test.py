import depthai as dai
import cv2
import time

def main():
    # إنشاء خط أنابيب
    pipeline = dai.Pipeline()

    # تكوين الكاميرا RGB
    camRgb = pipeline.createColorCamera()
    xoutRgb = pipeline.createXLinkOut()
    xoutRgb.setStreamName("rgb")
    
    # إعدادات الكاميرا
    camRgb.setPreviewSize(600, 600)
    camRgb.setInterleaved(False)
    camRgb.setColorOrder(dai.ColorCameraProperties.ColorOrder.BGR)
    
    # ربط الكاميرا بمخرج XLink
    camRgb.preview.link(xoutRgb.input)

    # بدء تشغيل الخط
    device = dai.Device(pipeline)
    qRgb = device.getOutputQueue(name="rgb", maxSize=4, blocking=False)

    print("Press 'q' to exit")

    while True:
        inRgb = qRgb.get()
        frame = inRgb.getCvFrame()
        
        # عرض الإطار
        cv2.imshow("OAK-D Lite Test", frame)

        # الخروج عند الضغط على 'q'
        if cv2.waitKey(1) == ord('q'):
            break
    
    cv2.destroyAllWindows()

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"حدث خطأ: {e}")