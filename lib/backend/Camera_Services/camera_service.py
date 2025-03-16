
class CameraService:
    def __init__(self, camera_setup, object_detection, firebase_manager):
        self.camera_setup = camera_setup
        self.object_detection = object_detection
        self.firebase_manager = firebase_manager

    def start(self):
        return self.camera_setup.start()

    def stop(self):
        return self.camera_setup.stop()

    def process_frame(self, frame=None): 
        return self.object_detection.detect_and_process(frame)