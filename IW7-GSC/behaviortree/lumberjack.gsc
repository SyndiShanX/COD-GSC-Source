/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: behaviortree\lumberjack.gsc
*********************************************/

lumberjackfn0(var_0) {
  return lib_0A09::func_5AEA(var_0, 200);
}

func_2AD0() {
  if(isDefined(level.var_119E["lumberjack"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = lib_0C2B::func_98E5;
  var_0.var_1581[1] = lib_0C2B::func_3E48;
  var_0.var_1581[2] = lib_0C2B::func_10004;
  var_0.var_1581[3] = lib_0C2B::func_6627;
  var_0.var_1581[4] = lib_0C2B::func_6628;
  var_0.var_1581[5] = lib_0C2B::func_6629;
  var_0.var_1581[6] = ::lumberjackfn0;
  var_0.var_1581[7] = lib_0A09::func_FAF6;
  var_0.var_1581[8] = lib_0C2B::func_102D4;
  var_0.var_1581[9] = lib_0C2B::func_3E4F;
  var_0.var_1581[10] = lib_0C2B::func_3E29;
  var_0.var_1581[11] = scripts\aitypes\zombie_dlc1\behaviors::chaseenemydlc1;
  var_0.var_1581[12] = scripts\aitypes\zombie_dlc1\behaviors::seekenemydlc1;
  var_0.var_1581[13] = lib_0C2B::notargetfound;
  level.var_119E["lumberjack"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("lumberjack");
}