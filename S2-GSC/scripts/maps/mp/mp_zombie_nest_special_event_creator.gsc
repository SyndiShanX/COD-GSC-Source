/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_special_event_creator.gsc
********************************************************************/

_id_170B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self._id_695B = var_3;
  self._id_696B = var_1;
  self._id_6943 = var_2;
  self._id_2E37 = var_5;
  self._id_2DA5 = var_6;
  self._id_2DA6 = var_7;
  self._id_AC2D = var_0;
  self._id_AC2C = 0;

  if(isDefined(var_8))
    self._id_7D24 = var_8;

  if(isDefined(var_9))
    self._id_8C47 = var_9;

  if(isDefined(var_10))
    self._id_8C48 = var_10;

  if(!isDefined(level._id_08E3))
    level._id_08E3 = [];

  level._id_08E3 = common_scripts\utility::_id_0F6F(level._id_08E3, self);

  if(!isDefined(var_4) && !common_scripts\utility::_id_0F79(level._id_376B, maps\mp\mp_zombie_nest_ee_util::_id_4030))
    _id_0547::_id_7BA9(maps\mp\mp_zombie_nest_ee_util::_id_4030);

  if(isDefined(var_4))
    _id_0547::_id_7BA9(var_4);

  if(isDefined(var_11))
    thread maps\mp\mp_zombie_nest_special_event_creator_util::_id_4DED(var_11);

  while(self._id_AC2C < self._id_AC2D) {
    level waittill(self._id_695B);

    if(self._id_AC2C >= self._id_AC2D) {
      break;
    }
  }

  if(isDefined(var_11))
    thread maps\mp\mp_zombie_nest_special_event_creator_util::_id_9408();

  _id_0378::_id_8D74("zombie_soul_suck_threshold", self.origin);

  if(isDefined(var_4))
    _id_0547::_id_2D8C(var_4);

  level._id_08E3 = common_scripts\utility::_id_0F93(level._id_08E3, self);
}

_id_3135(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = 0;
  var_15 = 1;
  var_16 = var_11;
  var_16._id_1171 = var_2;
  var_16._id_38C2 = var_6;
  var_16._id_38B7 = var_7;
  var_16._id_38BA = 1500;
  maps\mp\mp_zombie_nest_special_event_creator_interface::_id_08F3(var_16);

  while(!var_14) {
    var_1[[var_0]](var_5, var_3, var_16._id_1171);
    [[var_8]](var_5, var_15, var_3);
    maps\mp\mp_zombie_nest_special_event_creator_util::_id_11B2(var_2);
    var_16._id_552B = 1;
    maps\mp\mp_zombie_nest_special_event_creator_interface::_id_08F4(var_16, var_2, var_4, var_6, var_7, var_16, var_12, var_13);
    var_14 = var_1 maps\mp\mp_zombie_nest_special_event_creator_util::_id_11BE(var_2, var_4, var_6, var_7, var_16, var_12, var_13);
    var_16._id_552B = 0;
    maps\mp\mp_zombie_nest_special_event_creator_interface::_id_7C69(var_16);

    if(!var_14) {
      level thread[[var_9]](var_1, var_2);
      maps\mp\mp_zombie_nest_special_event_creator_util::_id_11B1(var_2);
    } else {
      level thread[[var_10]](var_1, var_2, var_5);
      maps\mp\mp_zombie_nest_special_event_creator_util::_id_11B3(var_2);
    }

    var_15 = 0;
    thread maps\mp\mp_zombie_nest_special_event_creator_util::_id_11B0(var_2);
  }

  maps\mp\mp_zombie_nest_special_event_creator_interface::_id_7C68(var_11);

  for(var_17 = 0; var_17 < var_2.size; var_17++)
    var_2[var_17] notify(var_4._id_94D4);

  level notify(var_4._id_94D4);
}