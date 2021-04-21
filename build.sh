#!/bin/sh -l -c
mkdir -p /tmp/recovery
cd /tmp/recovery
apt install tmate -y
apt install git -y
git config --global user.name "Dazzler555"
git config --global user.email "71560605+Dazzler555@users.noreply.github.com"
repo init --depth=1 -u git://github.com/SHRP/platform_manifest_twrp_omni.git -b v3_10.0 -g default,-device,-mips,-darwin,-notdefault 
repo sync -j$(nproc --all)

git clone https://github.com/Dazzler555/2185r.git device/realme/RMX2185

rm -rf out
. build/envsetup.sh && lunch omni_RMX2185-eng && export ALLOW_MISSING_DEPENDENCIES=true && mka recoveryimage

cd out/target/product/RMX2185
curl -sL https://git.io/file-transfer | sh 

./transfer wet *.zip
./transfer wet recovery.img
