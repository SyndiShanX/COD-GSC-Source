/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: behaviortree\alien_rhino.gsc
****************************************/

_id_2AD0() {
  if(isDefined(level._id_119E["alien_rhino"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = scripts\aitypes\alien_rhino\behaviors::initbehaviors;
  var_0._id_1581[1] = scripts\aitypes\alien_rhino\behaviors::updateeveryframe;
  var_0._id_1581[2] = _id_0C2B::_id_3E48;
  var_0._id_1581[3] = scripts\aitypes\alien_rhino\behaviors::decideaction;
  var_0._id_1581[4] = scripts\aitypes\dlc4\bt_action_api::doaction_tick;
  var_0._id_1581[5] = scripts\aitypes\dlc4\bt_action_api::doaction_begin;
  var_0._id_1581[6] = scripts\aitypes\dlc4\bt_action_api::doaction_end;
  var_0._id_1581[7] = scripts\aitypes\alien_rhino\behaviors::followenemy_tick;
  var_0._id_1581[8] = scripts\aitypes\alien_rhino\behaviors::followenemy_begin;
  var_0._id_1581[9] = scripts\aitypes\alien_rhino\behaviors::followenemy_end;
  var_0._id_1581[10] = scripts\aitypes\dlc4\wander::wander_tick;
  var_0._id_1581[11] = scripts\aitypes\dlc4\wander::wander_begin;
  var_0._id_1581[12] = scripts\aitypes\dlc4\wander::wander_end;
  level._id_119E["alien_rhino"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("alien_rhino");
}