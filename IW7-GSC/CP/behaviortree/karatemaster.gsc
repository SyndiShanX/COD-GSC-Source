/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: behaviortree\karatemaster.gsc
*****************************************/

_id_2AD0() {
  if(isDefined(level._id_119E["karatemaster"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = scripts\aitypes\karatemaster\behaviors::init;
  var_0._id_1581[1] = scripts\aitypes\karatemaster\behaviors::updateeveryframe;
  var_0._id_1581[2] = _id_0C2B::_id_3E48;
  var_0._id_1581[3] = scripts\aitypes\karatemaster\behaviors::shouldmelee;
  var_0._id_1581[4] = scripts\aitypes\karatemaster\behaviors::domelee;
  var_0._id_1581[5] = scripts\aitypes\karatemaster\behaviors::melee_init;
  var_0._id_1581[6] = scripts\aitypes\karatemaster\behaviors::melee_cleanup;
  var_0._id_1581[7] = scripts\aitypes\karatemaster\behaviors::shouldteleport;
  var_0._id_1581[8] = scripts\aitypes\karatemaster\behaviors::doteleport;
  var_0._id_1581[9] = scripts\aitypes\karatemaster\behaviors::teleport_init;
  var_0._id_1581[10] = scripts\aitypes\karatemaster\behaviors::teleport_cleanup;
  var_0._id_1581[11] = scripts\aitypes\karatemaster\behaviors::followenemy_tick;
  var_0._id_1581[12] = scripts\aitypes\karatemaster\behaviors::followenemy_begin;
  var_0._id_1581[13] = scripts\aitypes\karatemaster\behaviors::followenemy_end;
  var_0._id_1581[14] = _id_0C2B::notargetfound;
  level._id_119E["karatemaster"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("karatemaster");
}