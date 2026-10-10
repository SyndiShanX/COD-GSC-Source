/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_gametype_juggernaut.gsc
**************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gametype_juggernaut;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_jugg_common;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_gametype_juggernaut;

function main() {
  level.var_cdc15ee14362fbf = &scripts\mp\gametypes\br_gametype_juggernaut::init;
  scripts\mp\gametypes\br::main();
}

function init() {
  level thread brjugg_initfeatures();
  level thread brjugg_initpostmain();
  level thread brjugg_initdialog();
  level thread brjugg_initexternalfeatures();

  setdevdvarifuninitialized(@ "hash_3d449b3ce63e3ace", 1);
  setdevdvarifuninitialized(@ "hash_c090696117b74c62", 75);
  setdevdvarifuninitialized(@ "hash_305a549345046786", 10);
  setdevdvarifuninitialized(@ "hash_6033e70c81d4b924", 20);
  setdevdvarifuninitialized(@ "hash_53800bc3e7ab723d", 1);
  setDvar(@ "live_lobby_max_time", 0);
  setDvar(@ "scr_live_lobby", 1);
}

function brjugg_initfeatures() {
  if(getdvarint(@ "hash_a780a85e3b40baf0", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::disablefeature("circle");
    scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
    scripts\mp\gametypes\br_gametypes::disablefeature("dropbag");
    scripts\mp\gametypes\br_gametypes::disablefeature("oneLife");
    scripts\mp\gametypes\br_gametypes::enablefeature("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::disablefeature("plunderSites");
  scripts\mp\gametypes\br_gametypes::enablefeature("tabletReplace");
}

function brjugg_initpostmain() {
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerWelcomeSplashes", &brjugg_playerwelcomesplashes);
  waittillframeend();
  scripts\mp\flags::gameflaginit("start_jugg_delivery", 0);
  level.ontimelimit = &brjugg_ontimelimit;
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onJuggCrateActivate", &brjugg_oncrateactivate);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onJuggCrateUse", &brjugg_oncrateuse);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onJuggCrateDestroy", &brjugg_oncratedestroy);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onJuggDropOnDeath", &brjugg_dropondeath);
  brjugg_cleanupents();
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level.startjuggdelivery = 0;
  level thread brjugg_managedeliveries();
}

function brjugg_initdialog() {
  wait 1;
  game["dialog"]["match_start"] = "gametype_juggernautroyale";
}

function brjugg_cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

function brjugg_initexternalfeatures() {}

function brjugg_playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_juggernaut_prematch_welcome");

  if(!istrue(self.infil_landing_done)) {
    self waittill("infil_landing_done");
  }

  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_juggernaut_welcome");
  scripts\mp\gametypes\br_public::brleaderdialogplayer("primary_objective", self, 0);
}

function brjugg_ontimelimit() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function brjugg_managedeliveries() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  level waittill("br_prematchEnded");

  if(level.mapname == "<dev string:x1c>" && !isDefined(level.br_circle)) {
    level.br_circle = spawnStruct();
    level.br_circle.circleindex = 0;
  }

  level thread brjugg_watchstartnotify();
  level thread brjugg_watchtimerstart();
  initialdrop = 1;

  while(true) {
    juggenable = getdvarint(@ "hash_3d449b3ce63e3ace", 1);

    if(!juggenable) {
      waitframe();
      continue;
    }

    var_fdfc755d4aa965c6 = scripts\mp\gametypes\br_jugg_common::getnumdrops();

    if(level.numactivejuggdrops > 0) {
      var_fdfc755d4aa965c6 -= level.numactivejuggdrops;
    }

    level.juggdroplocations = array_randomize(level.juggdroplocations);
    droplocations = scripts\mp\gametypes\br_jugg_common::showdroplocations(var_fdfc755d4aa965c6, initialdrop);

    while(!istrue(level.startjuggdelivery)) {
      waitframe();
      continue;
    }

    initialdrop = 0;
    level thread scripts\mp\gametypes\br_jugg_common::startdeliveries(droplocations, "gametype_juggernaut");
    level waittill("continue_jugg_drops");

    if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
      break;
    }

    var_b2afe11b32a4439c = getdvarint(@ "hash_6033e70c81d4b924", 20);
    wait var_b2afe11b32a4439c;
  }
}

function brjugg_watchstartnotify() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("start_jugg_delivery");
  level.startjuggdelivery = 1;
}

function brjugg_watchplayercounttostart(playercounttostart) {
  level endon("game_ended");

  while(true) {
    level waittill("br_player_eliminated");
    var_7f19e0518e7f95ba = scripts\mp\gametypes\br::getbrplayersnoteliminated();

    if(var_7f19e0518e7f95ba.size <= playercounttostart) {
      scripts\mp\flags::gameflagset("start_jugg_delivery");
      break;
    }
  }
}

function brjugg_watchtimerstart() {
  level endon("game_ended");
  var_65de8866109dfcd3 = getdvarint(@ "hash_305a549345046786", 10);
  wait var_65de8866109dfcd3;
  scripts\mp\flags::gameflagset("start_jugg_delivery");
}

function brjugg_oncrateactivate(var_d9bc1b05d016a86f) {}

function brjugg_oncrateuse(player) {}

function brjugg_oncratedestroy(immediate) {
  level notify("continue_jugg_drops");
}

function brjugg_dropondeath(dropstruct) {
  level notify("continue_jugg_drops");
  scripts\mp\gametypes\br_plunder::dropplunderbyrarity(100, dropstruct);
  var_8b3ebf50f99bdb43 = getdvarint(@ "hash_53800bc3e7ab723d", 1);

  if(var_8b3ebf50f99bdb43) {
    scripts\mp\gametypes\br_pickups::dropbrweapon("brloot_weapon_lm_dblmg_lege", dropstruct);
  }
}