/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: behaviortree\alien_goon.gsc
*********************************************/

func_2AD0() {
  if(isDefined(level.var_119E["alien_goon"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = scripts\aitypes\alien_goon\behaviors::initbehaviors;
  var_0.var_1581[1] = scripts\aitypes\alien_goon\behaviors::updateeveryframe;
  var_0.var_1581[2] = lib_0C2B::func_3E48;
  var_0.var_1581[3] = scripts\aitypes\alien_goon\behaviors::decideaction;
  var_0.var_1581[4] = scripts\aitypes\dlc4\bt_action_api::doaction_tick;
  var_0.var_1581[5] = scripts\aitypes\dlc4\bt_action_api::doaction_begin;
  var_0.var_1581[6] = scripts\aitypes\dlc4\bt_action_api::doaction_end;
  var_0.var_1581[7] = scripts\aitypes\alien_goon\behaviors::followenemy_tick;
  var_0.var_1581[8] = scripts\aitypes\alien_goon\behaviors::followenemy_begin;
  var_0.var_1581[9] = scripts\aitypes\alien_goon\behaviors::followenemy_end;
  var_0.var_1581[10] = scripts\aitypes\dlc4\wander::wander_tick;
  var_0.var_1581[11] = scripts\aitypes\dlc4\wander::wander_begin;
  var_0.var_1581[12] = scripts\aitypes\dlc4\wander::wander_end;
  level.var_119E["alien_goon"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("alien_goon");
}