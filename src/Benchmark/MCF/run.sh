OBOE=~/research
OBOE_DIR=~/research/oboe/build
LAPACKCPP_DIR=/usr/include/lapackpp/include
BLAS=/usr/lib/libblas.so
LAPACK=/usr/lib/liblapack.so
LIB=/usr/lib


echo $OBOE_DIR

# g++  -o  -c  *.C -I$OBOE_DIR/include -L$OBOE_DIR/lib \
#     -L$LIB=/usr/lib \
#     -llapackpp \
#     -lgfortran

g++  -c *.C  \
    -I$OBOE_DIR/include \
    -I$LAPACKCPP_DIR \
    -L$LIB \
    -llapack \
    -llapackpp \
    -lblas \
    -lgfortran \
    -L$OBOE_DIR/lib \
    $OBOE_DIR/lib/libaccpm.a \
    $OBOE_DIR/lib/libaccpmcore.a \
    $OBOE_DIR/lib/libaccpmla.a \
    $OBOE_DIR/lib/libaccpmparam.a \
    $OBOE_DIR/lib/libaccpmoracle.a


libtool --tag=CXX \
    --mode=link g++  \
    -fpermissive \
    -I$LAPACKCPP_DIR \
    -I$OBOE_DIR/include \
    -L$LIB \
    -llapackpp -gfortran \
    -L./ \
    -L$OBOE/src/UI \
    -L$OBOE/src/AccpmCore \
    -L$OBOE/src/AccpmLA \
    -L$OBOE/src/ProblemInput \
    -L$OBOE/src/Oracle    \
    -o oboeMCF *.o \
    $OBOE_DIR/lib/libaccpm.a \
    $OBOE_DIR/lib/libaccpmcore.a \
    $OBOE_DIR/lib/libaccpmla.a \
    $OBOE_DIR/lib/libaccpmparam.a \
    $OBOE_DIR/lib/libaccpmoracle.a \
    /usr/lib/liblapack.so \
    /usr/lib/libblas.so
