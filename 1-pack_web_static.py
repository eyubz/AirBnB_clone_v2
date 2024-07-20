#!/usr/bin/python3
""" Generating archive for web static """
import os.path
from datetime import datetime
from fabric import task


@task
def do_pack(ctx):
    dt = datetime.utcnow()
    file = ("versions/web_static_{}{}{}{}{}{}.tgz".format(
        dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second))
    if not os.path.isdir("versions"):
        if ctx.local("mkdir -p versions").failed:
            return None
    if ctx.local("tar -cvzf {} web_static".format(file)).failed:
        return None
    return file
