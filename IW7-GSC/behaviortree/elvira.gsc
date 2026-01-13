/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: behaviortree\elvira.gsc
*********************************************/

func_2AD0() {
  if(isDefined(level.var_119E["elvira"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = ::scripts\aitypes\elvira\behaviors::init;
  var_0.var_1581[1] = ::lib_0A07::func_97ED;
  var_0.var_1581[2] = ::scripts\aitypes\elvira\behaviors::updateeveryframe;
  var_0.var_1581[3] = ::lib_0C2B::func_3E48;
  var_0.var_1581[4] = ::scripts\aitypes\elvira\behaviors::decideaction;
  var_0.var_1581[5] = ::scripts\aitypes\dlc3\bt_action_api::doaction_tick;
  var_0.var_1581[6] = ::scripts\aitypes\dlc3\bt_action_api::doaction_begin;
  var_0.var_1581[7] = ::scripts\aitypes\dlc3\bt_action_api::doaction_end;
  level.var_119E["elvira"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("elvira");
}