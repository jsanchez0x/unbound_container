#!/bin/bash

DNS_PATH="/usr/share/dns"
ROOT_HINTS="root.hints"
ROOT_HINTS_BACKUP="$(date +%F).${ROOT_HINTS}"
REMOTE_ROOT_HINT="https://www.internic.net/domain/named.root"

echo "[i] Backing up root.hints ..."
cd $DNS_PATH
cp $ROOT_HINTS $ROOT_HINTS_BACKUP

if [ -s "$ROOT_HINTS_BACKUP" ]; then
    echo "[✓] Backup root.hints success!"
    echo ""
    echo "[i] Updating root.hints ..."
    wget -nv -O named.root $REMOTE_ROOT_HINT

    if [ -s named.root ]; then
        mv -f named.root $ROOT_HINTS
        echo "[✓] Update ${ROOT_HINTS} success!"
        echo ""
        echo "[i] Restarting unbound service ..."
        service unbound restart
        service unbound status
        exit 0
    else
        echo "[✗] Update failed!"
        exit 1
    fi

else
    echo "[✗] Backup failed!"
    exit 1
fi