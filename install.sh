MAKE=make
export BLAS=/usr/lib/libblas.so
export LAPACK=/usr/lib/liblapack.so

OBOE_DSTR=$(pwd)/oboe_dstr
LAPACKPP=${OBOE_DSTR}/lapackpp

# install lapackpp
mkdir -p oboe_dstr
cd oboe_dstr  

LAPACK_URL=http://kent.dl.sourceforge.net/sourceforge/lapackpp
FILE=lapackpp-2.5.4.tar.gz
DIR=lapackpp-2.5.4

rm -rf ${FILE} ${DIR}
wget ${LAPACK_URL}/${FILE} && tar -zxf ${FILE}
cd ${DIR}
# Correct definition of drand() function in src/genmd.cc file for Darwin platform
if [ $(uname -a | awk '{print $1}')=='Darwin' ]; then
sed -i  '68s/extern "C" double drand48(void) throw ();/extern "C" double drand48(void);/' src/genmd.cc | tee src/genmd.cc
fi
./configure -prefix=${LAPACKPP} --with-blas=${BLAS} --with-lapack=${LAPACK} && ${MAKE} && ${MAKE} install
cd ..
rm -rf ${FILE} ${DIR}
cd ..

# copy headers
cp -r oboe_dstr/lapackpp/include/lapackpp/* oboe_dstr/lapackpp/include/

#export BLAS=$(find /usr/lib -maxdepth 1 -type l -iname "*libblas.*"|xargs -I{} sh -c 'echo "{}"')
#export LAPACK=$(find /usr/lib -maxdepth 1 -type l -iname "*liblapack.*"|xargs -I{} sh -c 'echo "{}"')
export LAPACKCPP_DIR=${LAPACKPP}
export LAPACKCPP_LIB=${LAPACKPP}/lib

rm -r autom4te.cache

aclocal
autoconf

rm -r build
mkdir build
cd build
../configure CXXFLAGS=-fpermissive

make install

INCLUDE_DIR=${OBOE_DSTR}/include
LIB_DIR=${OBOE_DSTR}/lib
# copy files
cd lib
cp *.a $LIB_DIR
cd ../include

rm -r $INCLUDE_DIR
mkdir $INCLUDE_DIR
cp *.h $INCLUDE_DIR

cd ../..
rm -r build
rm -r autom4te.cache
