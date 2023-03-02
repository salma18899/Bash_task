#! /bin/bash

read -p "Enter first number: " num1
read -p "Enter second number: " num2

echo | awk "{ print \"the sum is \" $num1 + $num2 }"

echo |awk "{ print \"the difference is \"  $num1 - $num2}"

echo | awk "{print  \"the division is \" $num1 / $num2}"

echo | awk "{ print \"the multiplication is \"  $num1 * $num2}"

echo | awk "{print \"the rest of division is \" $num1 % $num2}"
