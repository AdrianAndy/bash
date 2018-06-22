#!/bin/bash
stty intr undef
stty susp undef

#Variables
a=While
b=loop
c=example

AwesomeFunction()
{
ech "$a $b $c $d"

FunkyFunction #Call FunkyFunction
}
a=1
b=2
while [ "$b" != "$a" ]
do
echo "DIVIDE BY ZERO!!!!!!!!!!! 1/0!!!!"
done
}

AwesomeFunction
