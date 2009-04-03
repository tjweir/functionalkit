#! /bin/sh
echo "### 1.h"
ruby generate_products.rb 1 h > p1.h && diff p1.h ../Source/Main/FKP1.h
echo "### 2.h"
ruby generate_products.rb 2 h > p2.h && diff p2.h ../Source/Main/FKP2.h
echo "### 3.h"
ruby generate_products.rb 3 h > p3.h && diff p3.h ../Source/Main/FKP3.h

echo "### 1.m"
ruby generate_products.rb 1 m > p1.m && diff p1.m ../Source/Main/FKP1.m
echo "### 2.m"
ruby generate_products.rb 2 m > p2.m && diff p2.m ../Source/Main/FKP2.m
echo "### 3.m"