#!/bin/bash
echo "**************************************************************"
echo "    Switch the detault Xcode to /Applications/Xcode.app/      "
echo "      (You may need to input the password of your Mac)        "
echo "**************************************************************"
sudo xcode-select -switch /Applications/Xcode.app/
UUID=$(defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID)
echo "Xcode UUID is $UUID"
for Plugin in ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/*
do
    UUIDs=$(defaults read "$Plugin"/Contents/Info DVTPlugInCompatibilityUUIDs)
    BundleName=$(defaults read "$Plugin"/Contents/Info CFBundleName)
    if echo "${UUIDs[@]}" | grep -w "$UUID" &>/dev/null; then
        echo "The setting of $BundleName is already done!"
    else
        defaults write "$Plugin"/Contents/Info DVTPlugInCompatibilityUUIDs -array-add $UUID
        echo ------------- Write UUID to $BundleName succeed!
    fi
done
echo ""
echo "**************************************************************"
echo "                Done! Please restart Xcode!                   "
echo "  ❡ ❡ ❡ ❡ ❡ ❡        Enjoy yourself!            ❡ ❡ ❡ ❡ ❡ ❡   "
echo "**************************************************************"