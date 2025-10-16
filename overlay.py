import os
import subprocess
import uuid

def draw_overlay(display_id="0"):
    env = os.environ.copy()
    env["DISPLAY"] = f":{display_id}"
    random_text = str(uuid.uuid4())[:8]
    try:
        subprocess.Popen([
            "xterm",
            "-geometry", "1920x1080+0+0",
            "-bg", "black",
            "-fg", "green",
            "-title", f"Display {display_id} Overlay",
            "-e", "bash", "-c",
            f'clear; echo "Sandbox Active - {random_text}"; read'
        ], env=env)
    except Exception as e:
        print(f"Overlay failed: {e}")

if __name__ == "__main__":
    draw_overlay("0")
