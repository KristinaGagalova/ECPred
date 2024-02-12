sudo docker build \
        --build-arg ECPRED_TAR=https://goo.gl/g2tMJ4 \
        --build-arg LIBIDN_UBUNTU=http://mirrors.kernel.org/ubuntu/pool/main/libi/libidn/libidn11_1.33-2.2ubuntu2_amd64.deb \
        -f ecpred.Dockerfile -t ecpred_wrapper .
