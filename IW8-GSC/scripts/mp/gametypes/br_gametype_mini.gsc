/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_mini.gsc
*****************************************************/

function init() {
  thread eggdebug();
  thread eggrolls();
  thread eggbear();
  thread eggbox();
  setdvarifuninitialized("scr_brmini_circle_setting", 0);
  level.ref_12966 = getdvarint("scr_brmini_questDomDistMin", 2000);
  level.ref_12965 = getdvarint("scr_brmini_questDomDistMax", 4000);
  level.ref_12962 = getdvarint("scr_brmini_questAssDistMin", 2500);
  level.ref_12961 = getdvarint("scr_brmini_questAssDistMax", 5500);
  level.ref_12968 = getdvarint("scr_brmini_questScavDistMin", 2000);
  level.ref_12967 = getdvarint("scr_brmini_questScavDistMax", 4000);
}

function eggdebug() {
  if(getdvarint("scr_brmini_debug", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("circle");
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("dropbag");
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("tabletReplace");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("planeUseCircleRadius");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
}

function eggrolls() {
  scripts\mp\gametypes\br_gametypes::ref_12B11("createC130PathStruct", &edit_loadout_think);
  scripts\mp\gametypes\br_gametypes::ref_12B11("addToC130Infil", &earnednuke);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerWelcomeSplashes", &eggtrigger);
  scripts\mp\gametypes\br_gametypes::ref_12B10("dropBagDelay", 100);
  waittillframeend();
  level.ontimelimit = &eggsetup;
  earnperiodicxp();
  level.ref_140D9 = [];
  level.ref_140D9[0] = "assassination";
  level.ref_140D9[1] = "domination";
  level.ref_140D9[2] = "scavenger";
}

function eggbear() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");
}

function earnperiodicxp() {
  scripts\cp_mp\utility\game_utility::ref_12C10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12C11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("me_electrical_box_street_01", 1);
}

function eggbox() {}

function eggtrigger(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_mini_prematch_welcome");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    while(!self isonground()) {
      waitframe();
    }
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_mini_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);
}

function eggsetup() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function edit_loadout_think() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = scripts\mp\gametypes\br_c130::createtestc130path(var_0, var_1);
  return var_2;
}

function earnednuke() {
  thread eggs();
}

function eggs() {
  level endon("game_ended");
  self endon("death");
  var_0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var_1;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "c130" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "outOfBounds";
      var_3 notify("halo_kick_c130");
    }
  }
}