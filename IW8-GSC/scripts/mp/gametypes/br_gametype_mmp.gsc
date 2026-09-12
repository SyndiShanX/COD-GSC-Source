/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_mmp.gsc
****************************************************/

function init() {
  level.mmp = spawnStruct();
  level.decoyassists = &groundz;
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("giveStartFieldUpgrade");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("movingCircle");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("planeUseCircleRadius");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("firstCircleVo");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::ref_12B11("createC130PathStruct", &brmmp_createc130pathstruct);
  scripts\mp\gametypes\br_gametypes::ref_12B11("addToC130Infil", &brmmp_addtoc130infil);
  thread ref_127F5();
}

function ref_127F5() {
  level waittill("prematch_over");
}

function groundz() {
  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0];
  level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 5500];
  level.br_level.br_circleradii = [75000, 45000, 20000, 7000, 3500, 1500, 0];
  level.br_level.br_circleclosetimes = [1, 200, 130, 90, 50, 100];
  level.br_level.br_circledelaytimes = [1, 120, 75, 60, 45, 0];
  level.br_level.default_player_connect_black_screen = [1, 0, 0, 0, 0, 0];
}

function brmmp_createc130pathstruct() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = scripts\mp\gametypes\br_c130::createtestc130path(var_0, var_1);
  return var_2;
}

function brmmp_addtoc130infil() {
  thread brmmp_kickplayersatcircleedge();
}

function brmmp_kickplayersatcircleedge() {
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