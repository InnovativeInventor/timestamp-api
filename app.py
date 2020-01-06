import sys
import string
import subprocess
from flask import Flask 
import atexit
from apscheduler.scheduler import Scheduler

app = Flask(__name__, static_folder='hash/', static_url_path="/hash/")
cron = Scheduler(daemon=True)
cron.start()

@app.route('/stamp/<string:hash_256>', methods=['POST'])
def stamp(hash_256):
    if is_hash(hash_256):
        if not os.path.isfile("hash/" + hash_256):
            command = ["ots-cli.js", "stamp", "-d", hash_256]
            subprocess.call(command, cwd="hash/")
        return '/hash/' + hash_256 

@cron.interval_schedule(hours=3)
def upgrade():
    command = ["ots", "upgrade", "*.ots"]
    subprocess.call(command, cwd="hash/")


def is_hash(hash_256: str) -> bool:
    """
    Validates if the input is a valid 256-bit hash
    """
    try:
        if isinstance(int(str(hash_256), 16), int) and all(c in string.hexdigits for c in str(hash_256)):
            if len(str(hash_256)) == 64:
                if not "/" in hash_256:  # extra validation
                    return True
    except:
        return False
    return False

atexit.register(lambda: cron.shutdown(wait=False))
