/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\unittest.gsc
***********************************************/



#using scripts\unittest\call;
#using scripts\unittest\cond;
#using scripts\unittest\error;
#using scripts\unittest\loop;
#using scripts\unittest\ops;
#using scripts\unittest\patch;
#using scripts\unittest\private;
#using scripts\unittest\
switch;
#using scripts\unittest\threads;
#using scripts\unittest\util;
#using scripts\unittest\variables;
#namespace unittest;

function test() {
  unittest_ops::main();
  unittest_call::main();
  unittest_variables::main();
  unittest_cond::main();
  unittest_loop::main();
  unittest_switch::main();
  unittest_threads::main();
  unittest_patch::main();
  namespace_106f587ebebd0cab::main();
}

function error() {
  unittest_error::main();
}

function main() {
  setdvarifuninitialized(@ "hash_3b4e5f0e69f46421", 0);

  while(true) {
    wait 1;
    var_c990b60e12f60d87 = getdvarint(@ "hash_3b4e5f0e69f46421", 0);

    switch (var_c990b60e12f60d87) {
      case 0:
        continue;
      case 1:
        test();
        break;
      case 2:
        error();
        break;
    }

    setDvar(@ "hash_3b4e5f0e69f46421", 0);
  }
}