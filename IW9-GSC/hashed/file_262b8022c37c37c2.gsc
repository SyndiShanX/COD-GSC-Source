/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_262b8022c37c37c2.gsc
***********************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "mini_mgl") {
    return;
  }
  _id_4A0D1F5F6BE0F8C7::init();
  _id_FC6B0973B9E9E275();
}

_id_FC6B0973B9E9E275() {
  level thread brmini_initfeatures();
  level thread brmini_initpostmain();
  level thread brmini_initdialog();
  level thread brmini_initexternalfeatures();
  setdvarifuninitialized("dvar_E84CE12F7A01A55A", 0);
  level.quest_domdistmin = getdvarint("dvar_17A688FDDAE58969", 2000);
  level.quest_domdistmax = getdvarint("dvar_17837AFDDABF22E7", 4000);
  level.quest_assdistmin = getdvarint("dvar_CD101811114C12BE", 2500);
  level.quest_assdistmax = getdvarint("dvar_CCED2A111125F29C", 5500);
  level.quest_scavdistmin = getdvarint("dvar_E44264BCEA496A40", 2000);
  level.quest_scavdistmax = getdvarint("dvar_E41F7ABCEA2352EA", 4000);
}

brmini_initfeatures() {
  if(getdvarint("dvar_16BD795A6D0DD17C", 0) == 1) {
    _id_362C58E8BB39BCDA::disablefeature("circle");
    _id_362C58E8BB39BCDA::disablefeature("gulag");
    _id_362C58E8BB39BCDA::disablefeature("dropbag");
    _id_362C58E8BB39BCDA::disablefeature("oneLife");
    _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");
  }

  _id_362C58E8BB39BCDA::disablefeature("plunderSites");
  _id_362C58E8BB39BCDA::disablefeature("randomizeCircleCenter");
  _id_362C58E8BB39BCDA::disablefeature("planeSnapToOOB");
  _id_362C58E8BB39BCDA::enablefeature("tabletReplace");
  _id_362C58E8BB39BCDA::enablefeature("planeUseCircleRadius");
  _id_362C58E8BB39BCDA::enablefeature("circleEarlyStart");
}

brmini_initpostmain() {
  _id_362C58E8BB39BCDA::registerbrgametypefunc("createC130PathStruct", ::brmini_createc130pathstruct);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("addToC130Infil", ::brmini_addtoc130infil);
  _id_362C58E8BB39BCDA::registerbrgametypedata("dropBagDelay", 100);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerDropBonuses", ::_id_897B43997EA4C732);
  waittillframeend;
  level.ontimelimit = ::brmini_ontimelimit;
  brmini_cleanupents();
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level waittill("br_circle_set", circleindex);
  level waittill("br_circle_set", circleindex);
  _id_5D954F1724092F5A = getdvarfloat("scr_br_circle_object_cleanup_threshold", 1000.0);
  _id_819EDACDACB810E4 = _id_2695A20D4011076D::getdangercircleorigin();
  _id_E86632D645C137D0 = _id_2695A20D4011076D::getdangercircleradius();
  _id_3ACF1C0EBAF602F2::dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A);
}

brmini_initdialog() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");
}

brmini_cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

brmini_initexternalfeatures() {}

brmini_ontimelimit() {
  if(isDefined(level.numendgame))
    level thread _id_1E4A61DB11011446::startendgame(1);

  level.numendgame = undefined;
}

brmini_createc130pathstruct(_id_B2D2EEC29DBABA05) {
  _id_F9CBFF5134DA960B = (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], 0);
  _id_E5BD279D3767139F = level.br_level.br_circleradii[1] + getdvarint("dvar_F7236383CCA2D708", 0);
  c130pathstruct = _id_45B2B4A889E633FA::createtestc130path(_id_F9CBFF5134DA960B, _id_E5BD279D3767139F, _id_B2D2EEC29DBABA05);
  return c130pathstruct;
}

brmini_addtoc130infil() {
  thread brmini_kickplayersatcircleedge();
}

brmini_kickplayersatcircleedge() {
  level endon("game_ended");
  self endon("death");
  endpos = (self.pathstruct.endptui[0], self.pathstruct.endptui[1], self.origin[2]);
  _id_6687FCFB386CE7E8 = distance(self.origin, endpos);
  remainingtime = _id_6687FCFB386CE7E8 / _id_45B2B4A889E633FA::getc130speed();
  _id_8352485F68C78819 = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_kick_player_time_before_circle_edge"), 1.0);
  wait(remainingtime - _id_8352485F68C78819);

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == "c130" && !isDefined(player.jumptype)) {
      player.jumptype = "outOfBounds";
      player notify("halo_kick_c130");
    }
  }
}

_id_897B43997EA4C732() {
  if(getdvarint("dvar_E67C864263196598", 0) == 1) {
    if(scripts\mp\flags::gameflag("prematch_done")) {
      if(!isDefined(self._id_5BEC73DA4C07340C)) {
        self._id_5BEC73DA4C07340C = 1;

        if(!_id_2CEDCC356F1B9FC8::hasselfrevivetoken())
          _id_7E52B56769FA7774::addselfrevivetoken(1);
      }
    }
  }
}