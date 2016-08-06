#!/bin/bash
#选中默认的Xcode版本
echo "**************************************************************"
echo "          选择 /Applications/Xcode.app/ 为默认的Xcode           "
echo "                 (第一次启动可能会需要输入密码)                    "
echo "**************************************************************"
sudo xcode-select -switch /Applications/Xcode.app/
#获取当前版本Xcode的DVTPlugInCompatibilityUUID
UUID=$(defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID)
echo "读取到Xcode的UUID 为 $UUID"
#遍历每一个Xcode插件，将UUID写入插件的兼容列表中
for Plugin in ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/*
do
    UUIDs=$(defaults read "$Plugin"/Contents/Info DVTPlugInCompatibilityUUIDs)
    BundleName=$(defaults read "$Plugin"/Contents/Info CFBundleName)
    if echo "${UUIDs[@]}" | grep -w "$UUID" &>/dev/null; then
        echo "$BundleName 已经被正确设置"
    else
#        defaults write "$Plugin"/Contents/Info DVTPlugInCompatibilityUUIDs -array-add $UUID
        echo ------------- Write UUID to $BundleName succeed!
    fi
done
echo "Done!"