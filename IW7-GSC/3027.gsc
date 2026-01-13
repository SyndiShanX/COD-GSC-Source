/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3027.gsc
***********************************************/

main(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.var_B8F9 = "mp";
  var_3.dvarfuncs = ::dvarfuncs;
  var_3.init = ::func_963C;
  lib_0BCE::main(var_3);
}

func_963C() {
  playFXOnTag(level.var_A3B9.var_11888, self, "tag_engine_left");
  playFXOnTag(level.var_A3B9.var_11888, self, "tag_engine_right");
}

init_location() {}

dvarfuncs(var_0, var_1) {
  setdvar(var_0, var_1);
}

func_D31A(var_0, var_1, var_2) {
  self playerhide();

  if(isDefined(var_2) && var_2) {
    var_3 = "hover";
  } else {
    var_3 = "fly";
  }

  lib_0BCE::func_A2B2(var_0, var_1, var_3);
}

func_D05B() {
  lib_0BCE::func_A2B1();
  self playershow();
}