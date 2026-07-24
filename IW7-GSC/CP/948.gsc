/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 948.gsc
**************************************/

_id_2AD0() {
  if(isDefined(level._id_119E["zombie_ghost"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = scripts\aitypes\zombie_ghost\behaviors::initzombieghost;
  var_0._id_1581[1] = _id_0C2B::_id_3E48;
  var_0._id_1581[2] = scripts\aitypes\zombie_ghost\behaviors::ghostlaunched;
  var_0._id_1581[3] = scripts\aitypes\zombie_ghost\behaviors::ghostentangled;
  var_0._id_1581[4] = scripts\aitypes\zombie_ghost\behaviors::ghosthover;
  var_0._id_1581[5] = scripts\aitypes\zombie_ghost\behaviors::checkattack;
  var_0._id_1581[6] = scripts\aitypes\zombie_ghost\behaviors::chaseenemy;
  var_0._id_1581[7] = scripts\aitypes\zombie_ghost\behaviors::seekenemy;
  var_0._id_1581[8] = scripts\aitypes\zombie_ghost\behaviors::ghosthide;
  var_0._id_1581[9] = scripts\aitypes\zombie_ghost\behaviors::notargetfound;
  level._id_119E["zombie_ghost"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("zombie_ghost");
}