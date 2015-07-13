OBOE_DIR=~/research/oboe/build
LAPACKCPP_DIR=/usr/include/lapackpp
BLAS=/usr/lib/libblas.so
LAPACK=/usr/lib/liblapack.so
LAPACKCPP_LIB=/usr/lib


echo $OBOE_DIR

g++ -I$OBOE_DIR/include \
    -I$LAPACKCPP_DIR \
    -L$OBOE_DIR/lib \
    -L$OBOE_DIR/lib/libaccpm.a \
    -L$OBOE_DIR/lib/libaccpmcore.a \
    -L$OBOE_DIR/lib/libaccpmparam.a \
    -L$OBOE_DIR/lib/libaccpmoracle.a \
    -L$OBOE_DIR/lib/libaccpmla.a \
    -L$BLAS \
    -L$LAPACK \
    -o LATest.o LATest.C
