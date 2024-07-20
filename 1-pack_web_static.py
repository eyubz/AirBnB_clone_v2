#!/usr/bin/python3
""" Generating archive for web static """
import os.path
from datetime import datetime
from fabric import task
from invoke import Context


@task
def do_pack(ctx):
    dt = datetime.utcnow()
    file = "versions/web_static_{}{}{}{}{}{}.tgz".format(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second)
    if not os.path.isdir("versions"):
        if ctx.run("mkdir -p versions", pty=True).failed:
            return None
    if ctx.run("tar -cvzf {} web_static".format(file), pty=True).failed:
        return None
    return file
