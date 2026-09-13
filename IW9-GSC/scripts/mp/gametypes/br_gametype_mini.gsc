/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_mini.gsc
*****************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "mini") {
    return;
  }
  init();
}

init() {
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
  _id_362C58E8BB39BCDA::disablefeature("movingCircle");
  _id_362C58E8BB39BCDA::enablefeature("tabletReplace");
  _id_362C58E8BB39BCDA::enablefeature("planeUseCircleRadius");
  _id_362C58E8BB39BCDA::enablefeature("circleEarlyStart");
}

brmini_initpostmain() {
  _id_362C58E8BB39BCDA::registerbrgametypefunc("createC130PathStruct", ::brmini_createc130pathstruct);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("addToC130Infil", ::brmini_addtoc130infil);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::brmini_playerwelcomesplashes);
  _id_BDA97B5C9F53268D = getdvarint("dvar_96C9BE1F54511DFC", 375);
  _id_362C58E8BB39BCDA::registerbrgametypedata("dropPlaneDelay", _id_BDA97B5C9F53268D);
  _id_362C58E8BB39BCDA::registerbrgametypedata("dropBagDelay", 100);
  waittillframeend;
  level.ontimelimit = ::brmini_ontimelimit;
  brmini_cleanupents();
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level waittill("br_circle_set", circleindex);
  level waittill("br_circle_set", circleindex);
  _id_5D954F1724092F5A = getdvarfloat("dvar_D6D1181CD67D957D", 1000.0);
  _id_819EDACDACB810E4 = _id_2695A20D4011076D::getdangercircleorigin();
  _id_E86632D645C137D0 = _id_2695A20D4011076D::getdangercircleradius();

  if(isDefined(level._id_41F4BC9EE8C7C9C6) && isDefined(level._id_41F4BC9EE8C7C9C6.activetablets)) {
    if(istrue(level._id_41F4BC9EE8C7C9C6.activetablets.size > 0)) {
      activetablets = level._id_41F4BC9EE8C7C9C6.activetablets;

      foreach(tablet in activetablets) {
        if(distance2dsquared(_id_819EDACDACB810E4, tablet.origin) > _id_E86632D645C137D0 * _id_E86632D645C137D0) {
          _id_7E52B56769FA7774::loothide(tablet);
          _id_6AFF3948CF4CCA03::modify_plunder_itemsinworld("brloot_mission_tablet", -1);
        }
      }
    }
  }

  _id_64ACB6CE534155B7::dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A);
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

brmini_playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_mini_prematch_welcome");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    while(!self isonground())
      waitframe();
  } else
    level waittill("prematch_done");

  _id_715028F54BAD19A1::branalytics_landing(self);
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_mini_welcome");
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective", self, 0);
}

brmini_ontimelimit() {
  if(isDefined(level.numendgame))
    level thread _id_1E4A61DB11011446::startendgame(1);

  level.numendgame = undefined;
}

brmini_createc130pathstruct(_id_B2D2EEC29DBABA05) {
  _id_F9CBFF5134DA960B = (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], 0);
  _id_E5BD279D3767139F = level.br_level.br_circleradii[1];
  c130pathstruct = _id_45B2B4A889E633FA::createtestc130path(_id_F9CBFF5134DA960B, _id_E5BD279D3767139F, _id_B2D2EEC29DBABA05);
  return c130pathstruct;
}

brmini_addtoc130infil() {
  thread brmini_kickplayersatcircleedge();
}

brmini_kickplayersatcircleedge() {
  level endon("game_ended");
  self endon("death");
  _id_DE97B83556C2E527 = 5;

  if(istrue(level._id_63A70FF2D38D8BEE))
    _id_DE97B83556C2E527 = 6;

  _id_432421C6EC2BFCD9 = distance(self.pathstruct.startpt, self.pathstruct.endptui);
  _id_42F65B4B53C1F5D4 = _id_432421C6EC2BFCD9 / _id_45B2B4A889E633FA::getc130speed() - _id_DE97B83556C2E527;
  wait(_id_42F65B4B53C1F5D4);

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == "c130" && !isDefined(player.jumptype)) {
      player.jumptype = "outOfBounds";
      player notify("halo_kick_c130");
    }
  }
}