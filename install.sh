
local_host= uname -a | awk '{print $2}'

if [ $local_host=='MacBook-Pro-K0stIa.local' ]; then

LAPACKPP=/Users/Shared/research/code/python/jmlr/lapackpp
OBOE_DSTR=/home.dokt/antonkos/lib/oboe

else 
LAPACKPP=//home.dokt/antonkos/lib/lapackpp
OBOE_DSTR=/home.dokt/antonkos/lib/oboe

fi

export BLAS=$(find /usr/lib -maxdepth 1 -type l -iname "*libblas.*"|xargs -I{} sh -c 'echo "{}"')
export LAPACK=$(find /usr/lib -maxdepth 1 -type l -iname "*liblapack.*"|xargs -I{} sh -c 'echo "{}"')
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
#rm -r build
rm -r autom4te.cache
