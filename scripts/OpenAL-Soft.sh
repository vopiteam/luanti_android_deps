#!/bin/bash -e
ver=1.25.2

download () {
	get_tar_archive openal-soft "https://github.com/kcat/openal-soft/archive/refs/tags/${ver}.tar.gz"
}

build () {
	# HAVE_WFUNCTION_EFFECTS=OFF: since 1.25.2 any clang 20+ gets
	# -Werror=function-effects, which the NDK's clang fails on armeabi-v7a
	# (operator""_uz in the nonblocking mixers). It only drops a diagnostic.
	cmake $srcdir/openal-soft "${CMAKE_FLAGS[@]}" \
		-DLIBTYPE=STATIC -DALSOFT_BACKEND_WAVE=FALSE -DALSOFT_NO_CONFIG_UTIL=TRUE \
		-DHAVE_WFUNCTION_EFFECTS=OFF
	make

	make_install_copy
}
