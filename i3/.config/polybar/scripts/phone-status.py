#!/usr/bin/env python3

from dasbus.connection import SessionMessageBus
import argparse

deviceId = ""
deviceName = ""
interface_name = "org.kde.kdeconnect"


def argparser():
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", "--check-ok", action="store_true")

    return parser


def check_ok():
    import psutil
    import sys

    processName = "kdeconnectd"

    for proc in psutil.process_iter():
        try:
            # Check if process name contains the given name string.
            if processName.lower() in proc.name().lower():
                sys.exit(0)
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    sys.exit(1)


def getConnectedDeviceDbus():
    dbus = SessionMessageBus()
    objectPath = "/modules/kdeconnect"
    proxy = dbus.get_proxy(service_name=interface_name, object_path=objectPath)

    deviceId, deviceName = [
        (i, proxy.deviceNames()[i]) for i in proxy.deviceNames().keys()
    ][0]

    print(deviceId, deviceName)


def getConnectedDevice():
    import subprocess

    device = subprocess.getoutput(f"{kdeconnectcli} --list-available --id-name-only")
    deviceId, deviceName = device.split(" ", maxsplit=1)
    if deviceId == "0":
        return ""

    return f"\uf10b {deviceName}"


def main():
    args = argparser().parse_args()
    if args.check_ok == True:
        check_ok()
    # connectDevice = getConnectedDevice()
    # print(connectDevice)
    getConnectedDeviceDbus()


if __name__ == "__main__":
    main()
