## Setup

New toolchain is set up as [described here](https://github.com/Bioconductor/Bioconductor/blob/master/documentation/new-toolchain-setup.md).

Important differences between this toolchain and the old one:

* Compilers upgraded from 4.6.3 to 4.9.3.
* zlib present in toolchain, so zlibbioc is no longer necessary;
  Rhtslib/zzz.R has been modified accordingly.
* In the old toolchain there was just one gcc, and you specify the sub-arch you want
  with the `-m32` and `-m64` flags. In this one each sub-arch has its own compiler
  and directory and associated tools (see script below for more info about the layout).


I did three separate checkouts of [Rhtslib](https://hedgehog.fhcrc.org/bioconductor/trunk/madman/Rpacks/Rhtslib), one for building the 32-bit libhts.a, one for the 64 bit one, and one to place the output (libhts.a) of the other two, and then commit it.

(All commands are in an msys2 shell):

```
cd /e/sandbox
mkdir -p hts/i386/ hts/x64 hts/both
cd hts/i386
svn co https://hedgehog.fhcrc.org/bioconductor/trunk/madman/Rpacks/Rhtslib
cd ../x64
svn co https://hedgehog.fhcrc.org/bioconductor/trunk/madman/Rpacks/Rhtslib
cd ../both
svn co https://hedgehog.fhcrc.org/bioconductor/trunk/madman/Rpacks/Rhtslib
```




I created this script, called `/e/sandbox/hts/htslib_envvars.sh`:

```bash
#!/bin/bash

# source me, don't run me

# CHANGE THIS depending on what you want to build!
BITS=32
if [ $BITS = "64" ]; then
 MINGWDIR=x86_64-w64-mingw32
else
 MINGWDIR=i686-w64-mingw32
fi

AR=/c/Rtools/mingw_$BITS/bin/ar.exe
CC=/c/Rtools/mingw_$BITS/bin/gcc
CFLAGS=-I/c/Rtools/mingw_$BITS/$MINGWDIR/include
#LDFLAGS="-L/c/Rtools/mingw_32/$MINGWDIR/lib -pthread -lz"
LDFLAGS="-L/c/Rtools/mingw_$BITS/$MINGWDIR/lib -lpthread -pthread -lz"
LIBS="-lpthread -pthread -lz"
RANLIB=/c/Rtools/mingw_$BITS/bin/ranlib.exe
```

First build the i386 version:


```
cd /e/sandbox/hts/i386/Rhtslib/src/htslib
# be sure that BITS is set to 32 in the script below!
. /e/sandbox/hts/htslib_envvars.sh
# if you don't have autoreconf installed in msys, do this:
# pacman -S base_devel
autoreconf -fi
./configure
make
cp .libs/libhts.a /e/sandbox/hts/both/src/winlib/i386/
```


Then the x64 version. First, edit `/e/sandbox/hts/htslib_envvars.sh`
and set `BITS` to `64`.

```
cd /e/sandbox/hts/x64/Rhtslib/src/htslib
# be sure that BITS is set to 64 in the script below!
. /e/sandbox/hts/htslib_envvars.sh
autoreconf -fi
./configure
make
cp .libs/libhts.a /e/sandbox/hts/both/src/winlib/x64/
```

I have confidence in the i386 instructions. I am not sure about the x64 ones.
When I tried them they didn't quite work (downstream packages, like csaw,
were emitting errors suggesting the library was the wrong architecture.)
We had built x64 successfully the day before but did not capture exactly how it was done.


Putting it all together:

```
cd /e/sandbox/hts/both
R CMD build --no-build-vignettes Rhtslib
R CMD INSTALL Rhtslib_*.tar.gz
cd Rhtslib
# add new libhts.a files to svn:
svn commit -m 'message' --no-auth-cache --non-interactive \
  --username your-svn-username --password your-svn-password
```


Possibly relevant:

https://stackoverflow.com/questions/20020264/i-cant-use-pthread-in-window-platform
