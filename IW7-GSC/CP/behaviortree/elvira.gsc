/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: behaviortree\elvira.gsc
**************************************/

_id_2AD0() {
  if(isDefined(level._id_119E["elvira"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = scripts\aitypes\elvira\behaviors::init;
  var_0._id_1581[1] = _id_0A07::_id_97ED;
  var_0._id_1581[2] = scripts\aitypes\elvira\behaviors::updateeveryframe;
  var_0._id_1581[3] = _id_0C2B::_id_3E48;
  var_0._id_1581[4] = scripts\aitypes\elvira\behaviors::decideaction;
  var_0._id_1581[5] = scripts\aitypes\dlc3\bt_action_api::doaction_tick;
  var_0._id_1581[6] = scripts\aitypes\dlc3\bt_action_api::doaction_begin;
  var_0._id_1581[7] = scripts\aitypes\dlc3\bt_action_api::doaction_end;
  level._id_119E["elvira"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("elvira");
}