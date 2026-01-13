/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: behaviortree\seeker_mp.gsc
*********************************************/

func_2AD0() {
  if(isDefined(level.var_119E["seeker_mp"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = ::lib_0C26::func_98CB;
  var_0.var_1581[1] = ::lib_0C26::func_2A74;
  var_0.var_1581[2] = ::lib_0C26::func_2A73;
  var_0.var_1581[3] = ::lib_0C26::func_3D48;
  var_0.var_1581[4] = ::lib_0C26::func_3D47;
  var_0.var_1581[5] = ::lib_0C26::func_24D7;
  var_0.var_1581[6] = ::lib_0C26::func_24D6;
  var_0.var_1581[7] = ::lib_0C26::func_6385;
  var_0.var_1581[8] = ::lib_0C26::func_69F4;
  var_0.var_1581[9] = ::lib_0C26::func_69F3;
  level.var_119E["seeker_mp"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("seeker_mp");
}