docker run\
  --rm \
  --name nfs \
  -v ${PWD}:/export \
  -e NFS_EXPORT_0='/export                  *(ro,no_subtree_check)' \
  -p 2049:2049 \
  --privileged  \
  erichough/nfs-server
