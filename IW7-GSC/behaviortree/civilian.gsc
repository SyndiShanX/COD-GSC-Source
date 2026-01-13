/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: behaviortree\civilian.gsc
*********************************************/

func_2AD0() {
  if(isDefined(level.var_119E["civilian"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = ::lib_0C0E::func_97E6;
  var_0.var_1581[1] = ::lib_0C0E::func_12E8F;
  level.var_119E["civilian"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("civilian");
}