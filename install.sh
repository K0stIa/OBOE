MAKE=make

 # LDFLAGS:  -L/usr/local/opt/openblas/lib
 # CPPFLAGS: -I/usr/local/opt/openblas/include

# redefine these
export BLASS=/usr/local/opt/openblas/lib/libopenblas.dylib
export LAPACK=/usr/lib/liblapack.dylib

OBOE_DSTR=$(pwd)/dist
LAPACKPP=${OBOE_DSTR}/lapackpp

# install lapackpp
mkdir -p ${OBOE_DSTR}
cd ${OBOE_DSTR}  

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
./configure --prefix=${LAPACKPP} --with-blas --with-lapack && ${MAKE} && ${MAKE} install
cd ..
rm -rf ${FILE} ${DIR}
cd ..

# copy headers
cp -r ${OBOE_DSTR}/lapackpp/include/lapackpp/* ${OBOE_DSTR}/lapackpp/include/

#export BLAS=$(find /usr/lib -maxdepth 1 -type l -iname "*libblas.*"|xargs -I{} sh -c 'echo "{}"')
#export LAPACK=$(find /usr/lib -maxdepth 1 -type l -iname "*liblapack.*"|xargs -I{} sh -c 'echo "{}"')
export LAPACKCPP_DIR=${LAPACKPP}
export LAPACKCPP_LIB=${LAPACKPP}/lib

if [ $(uname -a | awk '{print $1}')=='Darwin' ]; then
#sed -i '126s/F77NAME(dpotrs)(&uplo, &n, &nrhs, &A(0,0), &lda, &X(0,0), &ldb, &info);/F77NAME(dpotrs)(&uplo, &n, &nrhs, (doublereal*)&A(0,0), &lda, &X(0,0), &ldb, &info);/' src/AccpmLA/AccpmLASolve.C | tee src/AccpmLA/AccpmLASolve.C
sed '68s/.*/extern "C" double drand48(void);/' src/genmd.cc  >> src/tmp && mv src/tmp src/genmd.cc
fi


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

mkdir -p ${INCLUDE_DIR}
mkdir -p ${LIB_DIR}

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
