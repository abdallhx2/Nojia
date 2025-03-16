import depthai as dai
import cv2

class CameraSetup:    
    def __init__(self):
        self.is_active = False
        self.pipeline = None
        self.device = None
        self.output_queue = None
    
    def setup_pipeline(self):
        pipeline = dai.Pipeline()
    
        camRgb = pipeline.createColorCamera()
        xoutRgb = pipeline.createXLinkOut()
        xoutRgb.setStreamName("rgb")
        camRgb.setFps(30)
        camRgb.setPreviewSize(480, 240)
        camRgb.setInterleaved(False)
        camRgb.setColorOrder(dai.ColorCameraProperties.ColorOrder.BGR)
        
        camRgb.preview.link(xoutRgb.input)
        return pipeline
    
    def start(self):
        if not self.is_active:
            self.pipeline = self.setup_pipeline()
            self.device = dai.Device(self.pipeline)
            self.output_queue = self.device.getOutputQueue(name="rgb", maxSize=8, blocking=False)
            self.is_active = True
            return True
        return False
    
    def stop(self):
        if self.is_active:
            if self.device:
                self.device.close()
            self.is_active = False
            self.device = None
            self.output_queue = None
            return True
        return False
    
    def get_frame(self):
        if not self.is_active or not self.output_queue:
            return None
        
        in_rgb = self.output_queue.tryGet()
        if in_rgb is None:
            return None
        
        frame = in_rgb.getCvFrame()
        return frame