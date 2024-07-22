#!/usr/bin/python3
""" Depoying the archive file """
import os.path
from fabric.api import env, put, run


env.hosts = ["18.206.232.35", "54.85.25.20"]


def do_deploy(archive_path):
    """ Deploying the archive file """
    if not os.path.isfile(archive_path):
        return False
    file = archive_path.split("/")[-1]
    name = file.split(".")[0]
    if put(archive_path, "/tmp/{}".format(file)).failed:
        return False
    if run("rm -rf /data/web_static/releases/{}/"
           .format(name)).failed:
        return False
    if run("mkdir -p /data/web_static/releases/{}/"
           .format(name)).failed:
        return False
    if run("tar -xzf /tmp/{} -C /data/web_static/releases/{}/"
           .format(file, name)).failed:
        return False
    if run("rm /tmp/{}".format(file)).failed:
        return False
    st = "mv /data/web_static/releases/{}/web_static/* "
    st += "/data/web_static/releases/{}/"
    if run(st.format(name, name)).failed:
        return False
    if run("rm -rf /data/web_static/releases/{}/web_static"
           .format(name)).failed:
        return False
    if run("rm -rf /data/web_static/current").failed:
        return False
    st = "ln -s /data/web_static/releases/{}/ "
    st += "/data/web_static/current"
    if run(st.format(name)).failed:
        return False
    return True
