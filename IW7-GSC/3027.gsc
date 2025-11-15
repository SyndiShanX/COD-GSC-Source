/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3027.gsc
************************/

main(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.var_B8F9 = "mp";
  var_03.dvarfuncs = ::dvarfuncs;
  var_03.init = ::func_963C;
  lib_0BCE::main(var_03);
}

func_963C() {
  playFXOnTag(level.var_A3B9.var_11888, self, "tag_engine_left");
  playFXOnTag(level.var_A3B9.var_11888, self, "tag_engine_right");
}

init_location() {}

dvarfuncs(param_00, param_01) {
  setdvar(param_00, param_01);
}

func_D31A(param_00, param_01, param_02) {
  self getweaponrankxpmultiplier();
  if(isDefined(param_02) && param_02) {
    var_03 = "hover";
  } else {
    var_03 = "fly";
  }

  lib_0BCE::func_A2B2(param_00, param_01, var_03);
}

func_D05B() {
  lib_0BCE::func_A2B1();
  self playershow();
}