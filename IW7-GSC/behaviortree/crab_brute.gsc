/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: behaviortree\crab_brute.gsc
*********************************************/

func_2AD0() {
  if(isDefined(level.var_119E["crab_brute"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = ::scripts\aitypes\crab_brute\behaviors::initbehaviors;
  var_0.var_1581[1] = ::scripts\aitypes\crab_brute\behaviors::updateeveryframe;
  var_0.var_1581[2] = lib_0C2B::func_3E48;
  var_0.var_1581[3] = ::scripts\aitypes\crab_brute\behaviors::decideaction;
  var_0.var_1581[4] = ::scripts\aitypes\dlc3\bt_action_api::doaction_tick;
  var_0.var_1581[5] = ::scripts\aitypes\dlc3\bt_action_api::doaction_begin;
  var_0.var_1581[6] = ::scripts\aitypes\dlc3\bt_action_api::doaction_end;
  var_0.var_1581[7] = ::scripts\aitypes\crab_brute\behaviors::followenemy_tick;
  var_0.var_1581[8] = ::scripts\aitypes\crab_brute\behaviors::followenemy_begin;
  var_0.var_1581[9] = ::scripts\aitypes\crab_brute\behaviors::followenemy_end;
  var_0.var_1581[10] = ::scripts\aitypes\crab_brute\behaviors::findenemy_tick;
  var_0.var_1581[11] = ::scripts\aitypes\crab_brute\behaviors::findenemy_begin;
  var_0.var_1581[12] = ::scripts\aitypes\crab_brute\behaviors::findenemy_end;
  level.var_119E["crab_brute"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("crab_brute");
}