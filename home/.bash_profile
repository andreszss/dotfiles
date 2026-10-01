export CFLAGS="-O3 -march=native -pipe"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j8"
export PATH="$PATH:$HOME/bin"
export DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/$(id -u)/bus}"

# LFS

set +h
umask 022
LFS=/mnt/lfs
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
