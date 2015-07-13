aclocal
autoconf

local_host= uname -a | awk '{print $2}'

if [ $local_host=='Ka' ]; then
    export BLAS=/usr/lib/libblas.so
    export LAPACK=/usr/lib/liblapack.so
    export LAPACKCPP_DIR=/usr/include/lapackpp
    export LAPACKCPP_LIB=/usr/lib
else
    echo "building on deepblue machine"
    echo "TODO: implement linking to lapack"
fi

rm -r build
mkdir build
cd build
../configure CXXFLAGS=-fpermissive

make install

INCLUDE_DIR=../../../../../phd_code/cpp/include/accpm
LIB_DIR=../../../../../phd_code/cpp/lib

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
