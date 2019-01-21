#!/bin/sh

docker stop nexus

tar cvf backup.tar nexus-data/

#git

docker start nexus
