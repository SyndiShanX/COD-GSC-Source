/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: behaviortree\crab_mini.gsc
**************************************/

_id_2AD0() {
  if(isDefined(level._id_119E["crab_mini"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = scripts\aitypes\crab_mini\behaviors::initbehaviors;
  var_0._id_1581[1] = scripts\aitypes\crab_mini\behaviors::updateeveryframe;
  var_0._id_1581[2] = _id_0C2B::_id_3E48;
  var_0._id_1581[3] = scripts\aitypes\crab_mini\behaviors::decideaction;
  var_0._id_1581[4] = scripts\aitypes\dlc3\bt_action_api::doaction_tick;
  var_0._id_1581[5] = scripts\aitypes\dlc3\bt_action_api::doaction_begin;
  var_0._id_1581[6] = scripts\aitypes\dlc3\bt_action_api::doaction_end;
  var_0._id_1581[7] = scripts\aitypes\crab_mini\behaviors::followenemy_tick;
  var_0._id_1581[8] = scripts\aitypes\crab_mini\behaviors::followenemy_begin;
  var_0._id_1581[9] = scripts\aitypes\crab_mini\behaviors::followenemy_end;
  var_0._id_1581[10] = _id_0C2B::notargetfound;
  level._id_119E["crab_mini"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("crab_mini");
}