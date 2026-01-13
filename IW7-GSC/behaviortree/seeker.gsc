/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: behaviortree\seeker.gsc
*********************************************/

func_F170(var_0) {
  return scripts\aitypes\melee::melee_init(var_0, self.bt.var_F15D);
}

func_2AD0() {
  if(isDefined(level.var_119E["seeker"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = lib_0C25::func_98CA;
  var_0.var_1581[1] = lib_0A09::func_9307;
  var_0.var_1581[2] = lib_0C25::func_1572;
  var_0.var_1581[3] = lib_0C25::func_13850;
  var_0.var_1581[4] = lib_0C25::func_F177;
  var_0.var_1581[5] = ::func_F170;
  var_0.var_1581[6] = scripts\aitypes\melee::func_5903;
  var_0.var_1581[7] = scripts\aitypes\melee::func_9896;
  var_0.var_1581[8] = scripts\aitypes\melee::func_41C6;
  var_0.var_1581[9] = lib_0C25::func_2BD3;
  level.var_119E["seeker"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("seeker");
}