all_sources="omniglot aircraft cu_birds dtd quickdraw fungi vgg_flower traffic_sign mscoco "

for source in ${all_sources}
do
    bash scripts/test.sh BN resnet18 ilsvrc_2012BN ${source}
done