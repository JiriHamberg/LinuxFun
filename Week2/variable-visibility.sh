#! /bin/bash

foo="bar"
echo "Within first shell (pid $$): \$foo=$foo"
echo "echo 'Within second shell (pid '\$\$'):' \\\$foo=\$foo" | bash
