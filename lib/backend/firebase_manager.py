import firebase_admin
from firebase_admin import credentials, firestore

class FirebaseManager:
    
    def __init__(self, cert_path="serviceAccountKey.json"):
        if not firebase_admin._apps:
            cred = credentials.Certificate(cert_path)
            firebase_admin.initialize_app(cred)
        self.db = firestore.client()
    
    def send_alert_to_firestore(self, detection_type, details=None):
        alert_type = "danger"  
        title = ""
        
        if detection_type == "child_near_pool":
            title = "child_near_pool"
            alert_type = "danger"
        elif detection_type == "adult_near_pool":
            title = "adult_near_pool"
            alert_type = "info"
        elif detection_type == "pool_detected":
            title = "pool_detected"
            alert_type = "success"
        else:
            title = f"اكتشاف: {detection_type}"
        
        alert_data = {
            "title": title,
            "timestamp": firestore.SERVER_TIMESTAMP,
            "type": alert_type,
            "details": details or {}
        }
        
        self.db.collection("alerts").add(alert_data)
        print(f"send alert done: {title}")