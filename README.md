| [Makers Academy](http://www.makersacademy.com) | Week 4 | Friday Challenge |
| ------ | ------ | ------ |

Takeaway challenge
==================

This week's challenge involved the following tasks:

- replicating the inject method using iteration
- replicating the inject method using recursion
- developing a takeaway ordering system

Technologies used
-----------------
- Ruby
- Rspec
- Timecop
- Twilio

## How to run this app

Clone this repository:
```shell
$ git clone git@github.com:michballard/takeaway-challenge.git
```

Require the necessary files:
```shell
$ require 'task1'
$ require 'takeaway'
```

For inject method, create an array and test:
```shell
$ array = Array.new
$ array = [5,6,7,8,9,10]
$ array.inject_using_iterator { | acc, x | acc + x }
$ array.inject_using_iterator(5) { | acc, x | acc + x }
$ array.inject_using_recursion { | acc, x | acc + x }
$ array.inject_using_recursion(5) { | acc, x | acc + x }
```