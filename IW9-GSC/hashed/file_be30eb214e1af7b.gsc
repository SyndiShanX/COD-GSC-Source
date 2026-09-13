/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_be30eb214e1af7b.gsc
***********************************************/

init() {
  level._id_6CCEE8E6C00F06E6 = ::init_player;
  setdvarifuninitialized("scr_sixthsense_enabled", 1);

  if(getdvarint("scr_sixthsense_enabled")) {
    level.stealth._id_84CC26FCABCAFCE7 = ::_id_9856971A6BDA1BEA;
    level thread _id_6E09A830FAB9468F::sixthsense_think();
  }
}

init_player() {
  scripts\engine\utility::flag_wait("introscreen_over");
  thread scripts\stealth\player::stealthhints_thread();

  if(isDefined(level.stealth._id_84CC26FCABCAFCE7))
    [[level.stealth._id_84CC26FCABCAFCE7]]();
}

_id_9856971A6BDA1BEA() {
  self endon("death");
  self._id_088606454E690C77 = spawnStruct();
  self._id_088606454E690C77.active = 1;
  scripts\cp\utility::giveperk("specialty_sixth_sense");
}

_id_A293F22894E2466B() {
  _id_5AF9038262D22C96::_id_F9DD1250EA99D251(0.1);
  childthread _id_20704B3608E508DC();
}

_id_20704B3608E508DC() {
  self endon("disconnect");
  self waittill("lost_sight_of_player");
  self._id_77F9FBFDBAC2529C = 1;
  scripts\cp\utility\player::_enableignoreme();
}

_id_A1D7DF5CC0E9C6A0() {
  _id_5AF9038262D22C96::_id_F9DD1250EA99D251(1);

  if(istrue(self._id_77F9FBFDBAC2529C)) {
    self._id_77F9FBFDBAC2529C = undefined;
    scripts\cp\utility\player::_disableignoreme();
  }
}

_id_5AF9997F0EEFB9A2(_id_65661AE3A873C9AE) {
  if(getdvarint("dvar_F328BD7DB3329D5E", 0) != 0) {
    if(istrue(_id_65661AE3A873C9AE)) {
      if(!isDefined(self._id_19AE4118816007E7))
        _id_519BED5012F1C015::_id_36D589DC5C4191F6("default");
    } else {
      self notify("lost_sight_of_player");

      if(!isDefined(self._id_19AE4118816007E7))
        _id_519BED5012F1C015::_id_36D589DC5C4191F6("cqb");
    }
  }

  if(istrue(_id_65661AE3A873C9AE)) {
    drone = scripts\stealth\utility::get_player_drone();

    if(isDefined(drone)) {
      return;
    }
    if(isDefined(level._id_EF796AC0B0326726) && isfunction(level._id_EF796AC0B0326726))
      level thread[[level._id_EF796AC0B0326726]](undefined, _id_65661AE3A873C9AE);
  }
}