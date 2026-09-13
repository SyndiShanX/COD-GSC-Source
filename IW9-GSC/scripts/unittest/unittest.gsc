/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\unittest.gsc
***********************************************/

test() {
  scripts\unittest\ops::main();
  scripts\unittest\call::main();
  scripts\unittest\variables::main();
  scripts\unittest\cond::main();
  scripts\unittest\loop::main();
  scripts\unittest\
  switch::main();
  scripts\unittest\threads::main();
  scripts\unittest\patch::main();
  _id_60031AC74593EA4C::main();
}

error() {
  scripts\unittest\error::main();
}

main() {
  setdvarifuninitialized("scr_unittest", 0);

  for(;;) {
    wait 1;
    _id_C990B60E12F60D87 = getdvarint("scr_unittest", 0);

    switch (_id_C990B60E12F60D87) {
      case 0:
        continue;
      case 1:
        test();
        break;
      case 2:
        error();
        break;
    }

    setDvar("scr_unittest", 0);
  }
}