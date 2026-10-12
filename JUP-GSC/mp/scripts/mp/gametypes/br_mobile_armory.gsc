/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_mobile_armory.gsc
*****************************************************/

#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_functional_poi;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\player;
#namespace br_mobile_armory;

function init() {
  level._effect["poi_mobile_armory_available"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_armory_white.vfx");
  level._effect["poi_mobile_armory_charging"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_armory_red.vfx");
  level.br_mobilearmories = [];
  level.br_mobile_armory_enabled = getdvarint(@ "hash_faf37a1bb44f33a1", 0) != 0;
  level.mobilearmoryplundercost = getdvarint(@ "hash_9c45dd1e0492ab50", 1);
  scripts\mp\gametypes\br_functional_poi::initstatemachineforpoitype("mobile_armory");
  scripts\mp\gametypes\br_functional_poi::registerstatecallbacksforpoitype("mobile_armory", 0, &_onenterdefaultstate, undefined, &_onexitdefaultstate);
  scripts\mp\gametypes\br_functional_poi::registerstatecallbacksforpoitype("mobile_armory", 1, &_onenterchargingstate, undefined, &_onexitchargingstate);
  scripts\mp\gametypes\br_functional_poi::registerstatecallbacksforpoitype("mobile_armory", 2, &_onenteractivestate, undefined, &_onexitactivestate);
  scripts\mp\gametypes\br_functional_poi::registerstatecallbacksforpoitype("mobile_armory", 3, &_onentercooldownstate, undefined, undefined);
}

function spawnmobilearmory(struct) {
  if(!istrue(level.br_mobile_armory_enabled)) {
    return;
  }

  mainmodel = spawn("script_model", struct.origin);

  if(isDefined(struct.angles)) {
    mainmodel.angles = struct.angles;
  }

  mainmodel setModel("veh8_mil_lnd_stango_static");
  var_7347f41687ba2720 = getStruct(struct.target, "targetname");

  if(!isDefined(mainmodel.interactiveelement)) {
    var_9d9f9751c9583c1b = (0, 0, 3);
    interactiveelement = spawn("script_model", var_7347f41687ba2720.origin + var_9d9f9751c9583c1b);

    if(isDefined(var_7347f41687ba2720.angles)) {
      interactiveelement.angles = var_7347f41687ba2720.angles;
    }

    interactiveelement setModel("military_crate_large_stackable_01");
    interactiveelement setCursorHint("HINT_NOICON");
    interactiveelement setuseholdduration("duration_medium");
    interactiveelement sethintdisplayfov(120);
    interactiveelement setusefov(120);
    interactiveelement setuserange(80);
    interactiveelement setusepriority(-1);
    mainmodel.interactiveelement = interactiveelement;
  }

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "active", (0, 0, 0), "hud_icon_br_mobile_armory");
    scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, mainmodel);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
    mainmodel.objectiveiconid = objectiveiconid;
    mainmodel thread _mobilearmorymanageminimapicon();
  } else {
    println("<dev string:x1c>");
  }

  level.br_mobilearmories[level.br_mobilearmories.size] = mainmodel;
  return mainmodel;
}

function _mobilearmorymanageminimapicon() {
  mobilearmory = self;
  mobilearmory endon("death");
  updateinterval = 1;
  visibleradius = 5000;
  mobilearmory.playersinrange = [];

  while(true) {
    wait updateinterval;

    if(!istrue(level.br_prematchstarted)) {
      continue;
    }

    foreach(player in mobilearmory.playersinrange) {
      if(isDefined(player)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(mobilearmory.objectiveiconid, player);
      }
    }

    mobilearmory.playersinrange = scripts\mp\utility\player::getplayersinradius(mobilearmory.origin, visibleradius);

    foreach(player in mobilearmory.playersinrange) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(mobilearmory.objectiveiconid, player);
    }
  }
}

function onprematchdone() {
  foreach(mobilearmory in level.br_mobilearmories) {
    mobilearmory scripts\mp\gametypes\br_functional_poi::gotopoistate("mobile_armory", 0);
  }
}

function _mobilearmoryendusethink() {
  mobilearmory = self;
  mobilearmory notify("mobileArmoryUseThinkEnd");
}

function _mobilearmoryusethink() {
  mobilearmory = self;
  mobilearmory endon("death");
  mobilearmory _mobilearmoryendusethink();
  mobilearmory endon("mobileArmoryUseThinkEnd");
  originalstate = mobilearmory scripts\mp\gametypes\br_functional_poi::getcurrentpoistate();
  mobilearmory.recordedusers = [];

  while(true) {
    mobilearmory.interactiveelement waittill("trigger", player);

    if(mobilearmory scripts\mp\gametypes\br_functional_poi::getcurrentpoistate() != originalstate) {
      return;
    }

    if(mobilearmory scripts\mp\gametypes\br_functional_poi::getcurrentpoistate() == 0) {
      if(player.plundercount < level.mobilearmoryplundercost) {
        player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/NOT_ENOUGH_PLUNDER_ACTIVATE");
        continue;
      } else {
        player scripts\mp\gametypes\br_plunder::playersetplundercount(player.plundercount - level.mobilearmoryplundercost);
      }
    }

    if(originalstate == 0) {
      mobilearmory.ownerteam = player.team;
      mobilearmory thread scripts\mp\gametypes\br_functional_poi::gotopoistate("mobile_armory", 1);
      return;
    }

    if(originalstate == 2) {
      var_9c71ef3ee76c7193 = 0;

      foreach(user in mobilearmory.recordedusers) {
        if(user == player) {
          var_9c71ef3ee76c7193 = 1;
          break;
        }
      }

      if(var_9c71ef3ee76c7193) {
        player scripts\mp\hud_message::showerrormessage("MP/BR_MOBILE_ARMORY_ALREADY_USED");
        continue;
      }

      player thread _mobilearmorychooseclass(mobilearmory);
    }
  }
}

function _mobilearmorychooseclass(mobilearmory) {
  player = self;
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");

  if(isai(player)) {
    return;
  }

  if(player isswitchingweapon() || player isreloading() || player ismantling() || player isthrowinggrenade() || player israisingweapon() || player ismeleeing()) {
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/MOBILE_ARMORY_ACTION_ERROR");
    return;
  }

  player setclientomnvar("ui_options_menu", 2);

  while(true) {
    player waittill("luinotifyserver", channel, newclass);

    if(channel != "class_select") {
      continue;
    }

    newclasschoice = scripts\mp\menus::getclasschoice(newclass);
    player.pers["class"] = newclasschoice;
    player.class = newclasschoice;
    player scripts\mp\class::preloadandqueueclass(newclasschoice);
    player scripts\mp\class::swaploadout();
    player.gearchangedfromloadout = 0;
    mobilearmory.recordedusers[mobilearmory.recordedusers.size] = player;
    var_53c0aa79eb3cb6c = 50;
    currentprimaries = player getweaponslistprimaries();

    foreach(weaponobj in currentprimaries) {
      weaponname = getcompleteweaponname(weaponobj);

      if(getsubstr(weaponname, 0, 4) == "alt_") {
        continue;
      }

      clipsize = weaponclipsize(weaponobj);
      var_cb2dbf59aaeec569 = int(min(var_53c0aa79eb3cb6c, clipsize));
      player setweaponammoclip(weaponobj, var_cb2dbf59aaeec569);
    }

    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(player);
  }
}

function _onenterdefaultstate(mobilearmory) {
  outlineasset = scripts\mp\gametypes\br_functional_poi::getinteractiveoutlineasset();
  mobilearmory.interactiveelement hudoutlineenable(outlineasset);
  mobilearmory.interactiveelement makeusable();
  mobilearmory.interactiveelement setHintString(&"MP/BR_ACTIVATE_MOBILE_ARMORY");
  mobilearmory thread _mobilearmoryusethink();
  var_18e46c38378f618 = getfx("poi_mobile_armory_available");
  playFXOnTag(var_18e46c38378f618, mobilearmory, "tag_origin");
}

function _onexitdefaultstate(mobilearmory) {
  mobilearmory.interactiveelement hudoutlinedisable();
  mobilearmory _mobilearmoryendusethink();
  mobilearmory.interactiveelement makeunusable();
  var_18e46c38378f618 = getfx("poi_mobile_armory_available");
  stopFXOnTag(var_18e46c38378f618, mobilearmory, "tag_origin");
}

function _onenterchargingstate(mobilearmory) {
  var_3058dbc123e6c741 = getdvarfloat(@ "hash_718bb8e6fbb6438e", 10);
  mobilearmory thread scripts\mp\gametypes\br_functional_poi::gotopoistateontimer("mobile_armory", 2, var_3058dbc123e6c741);
  scripts\mp\gametypes\br_functional_poi::showmiscmessagetoteam(mobilearmory.ownerteam, "br_mobile_armory_charging", var_3058dbc123e6c741, int(var_3058dbc123e6c741 * 1000));
  var_90d6a5c6923319de = getfx("poi_mobile_armory_charging");
  playFXOnTag(var_90d6a5c6923319de, mobilearmory, "tag_origin");
  mobilearmory playLoopSound("truck_reversebeep_lp");
}

function _onexitchargingstate(mobilearmory) {
  var_90d6a5c6923319de = getfx("poi_mobile_armory_charging");
  stopFXOnTag(var_90d6a5c6923319de, mobilearmory, "tag_origin");
  mobilearmory stoploopsound();
}

function _onenteractivestate(mobilearmory) {
  outlineasset = scripts\mp\gametypes\br_functional_poi::getinteractiveoutlineasset();
  mobilearmory.interactiveelement hudoutlineenable(outlineasset);
  level thread scripts\mp\gametypes\br::teamsplashbr("br_mobile_armory_activate", mobilearmory.player, mobilearmory.ownerteam);
  mobilearmory.interactiveelement makeusable();
  mobilearmory.interactiveelement setHintString(&"MP/BR_USE_MOBILE_ARMORY");
  mobilearmory thread _mobilearmoryusethink();
  activetimeseconds = getdvarfloat(@ "hash_e9149bfe8d43e5a0", 15);
  mobilearmory thread scripts\mp\gametypes\br_functional_poi::gotopoistateontimer("mobile_armory", 3, activetimeseconds);
  scripts\mp\gametypes\br_functional_poi::showmiscmessagetoteam(mobilearmory.ownerteam, "br_mobile_armory_active", activetimeseconds, int(activetimeseconds * 1000));
}

function _onexitactivestate(mobilearmory) {
  mobilearmory.interactiveelement hudoutlinedisable();
  mobilearmory _mobilearmoryendusethink();
  mobilearmory.interactiveelement makeunusable();
  scripts\mp\gametypes\br_functional_poi::showmiscmessagetoteam(mobilearmory.ownerteam, "br_mobile_armory_cooldown", 3);
  mobilearmory.ownerteam = undefined;
}

function _onentercooldownstate(mobilearmory) {
  cooldowntimeseconds = getdvarfloat(@ "hash_8f082ed019c7f63d", 120);
  mobilearmory thread scripts\mp\gametypes\br_functional_poi::gotopoistateontimer("mobile_armory", 0, cooldowntimeseconds);
}