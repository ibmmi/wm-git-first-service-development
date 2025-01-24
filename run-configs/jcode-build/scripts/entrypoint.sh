#!/bin/sh

if [ ! -f "${GUEST_IS_HOME}/bin/jcode.sh" ]; then
    echo "ERROR - jcode tool is not present."
    echo "ERROR - Please ensure you are using the correct image and the GUEST_IS_HOME env var is set appropriately!"
    exit 1
fi

cd "${GUEST_IS_HOME}/bin/" || exit 2
./jcode.sh all
