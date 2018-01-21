#!/usr/bin/env bash

#
# bash thunder.sh thunder://QUFmdHA6Ly9nOmdAdHYuZGwxMjM0LmNvbToyMTIxL+Wkj+iHs+acquiHszAxLm1wNFpa
#

INPUT_URL="$1"

# 转换前, 撤除前面输入的 thunder://
INPUT_URL_REM_THUNDER="${INPUT_URL/thunder:\/\//}"

# 网址用 base64 解码
URL_REAL=$(echo $INPUT_URL_REM_THUNDER | base64 --decode)

# 转换后, 撤除网址前面出现的 AA 和后面的 ZZ
URL_REAL_REM_AA_ZZ=$(echo $URL_REAL | awk '{print substr($0,3,length($0)-4)}')

# 会得到一个 http / https / ftp / ftps / sftp 的普通传输协议网址 
echo $URL_REAL_REM_AA_ZZ
