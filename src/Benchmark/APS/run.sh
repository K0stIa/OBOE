OBOE=~/research
OBOE_DIR=~/research/oboe/build
LAPACKCPP_DIR=/usr/include/lapackpp/include
BLAS=/usr/lib/libblas.so
LAPACK=/usr/lib/liblapack.so
LIB=/usr/lib
TEST_FILE=lapackpp.cpp



# g++ $TEST_FILE -o test -I $LAPACKCPP_DIR -L $LIB -llapackpp


# echo $OBOE_DIR

g++ -I$OBOE_DIR/include \
 -I$LAPACKCPP_DIR \
 -L$OBOE_DIR/lib \
 -L$OBOE_DIR/lib \
 -c -o APSTest.o APSTest.C


libtool --tag=CXX \
    --mode=link g++  \
    -fpermissive \
    -I$LAPACKCPP_DIR \
    -L$LIB \
    -llapackpp \
    -L./ \
    -L$OBOE/src/UI \
    -L$OBOE/src/AccpmCore \
    -L$OBOE/src/AccpmLA \
    -L$OBOE/src/ProblemInput \
    -L$OBOE/src/Oracle    \
    -o oboeAPS APSTest.o \
    $OBOE_DIR/lib/libaccpm.a \
    $OBOE_DIR/lib/libaccpmcore.a \
    $OBOE_DIR/lib/libaccpmla.a \
    $OBOE_DIR/lib/libaccpmparam.a \
    $OBOE_DIR/lib/libaccpmoracle.a \
    /usr/lib/liblapack.so \
    /usr/lib/libblas.so -lgfortran
# -lg2c
