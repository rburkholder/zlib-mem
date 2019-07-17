ln -s ioapi_mem/ioapi_mem.c ioapi_mem.c
ln -s ioapi_mem/ioapi_mem.h ioapi_mem.h

ln -s contrib/minizip/unzip.c unzip.c
ln -s contrib/minizip/unzip.h unzip.h
ln -s contrib/minizip/ioapi.c ioapi.c
ln -s contrib/minizip/ioapi.h ioapi.h

cp Makefile.in Makefile.in.original
sed -i "s/zutil.o$/zutil.o ioapi.o ioapi_mem.o unzip.o/" Makefile.in
sed -i "s/zutil.lo$/zutil.lo ioapi.lo ioapi_mem.lo unzip.lo/" Makefile.in

for name in "unzip" "ioapi" "ioapi_mem"; do
  echo " " >> Makefile.in
  echo "${name}.lo: \$(SRCDIR)${name}.c" >> Makefile.in
  echo "    -@mkdir objs 2>/dev/null || test -d objs" >> Makefile.in
  echo "    \$(CC) \$(SFLAGS) \$(ZINC) -DPIC -c -o objs/${name}.o \$(SRCDIR)${name}.c" >> Makefile.in
  echo "    -@mv objs/${name}.o \$@" >> Makefile.in
  done

