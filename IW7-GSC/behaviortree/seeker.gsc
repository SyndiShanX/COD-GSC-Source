/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: behaviortree\seeker.gsc
***********************************/

func_F170(param_00) {
  return scripts\aitypes\melee::melee_init(param_00, self.var_3135.var_F15D);
}

func_2AD0() {
  if(isDefined(level.var_119E["seeker"])) {
    return;
  }

  var_00 = spawnStruct();
  var_00.var_1581 = [];
  var_00.var_1581[0] = ::lib_0C25::func_98CA;
  var_00.var_1581[1] = ::lib_0A09::func_9307;
  var_00.var_1581[2] = ::lib_0C25::func_1572;
  var_00.var_1581[3] = ::lib_0C25::func_13850;
  var_00.var_1581[4] = ::lib_0C25::func_F177;
  var_00.var_1581[5] = ::func_F170;
  var_00.var_1581[6] = ::scripts\aitypes\melee::func_5903;
  var_00.var_1581[7] = ::scripts\aitypes\melee::func_9896;
  var_00.var_1581[8] = ::scripts\aitypes\melee::func_41C6;
  var_00.var_1581[9] = ::lib_0C25::func_2BD3;
  level.var_119E["seeker"] = var_00;
}

func_DEE8() {
  func_2AD0();
  btregistertree("seeker");
}