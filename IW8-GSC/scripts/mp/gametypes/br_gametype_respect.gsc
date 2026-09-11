/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_respect.gsc
********************************************************/

function init() {
  level.ref_12cb9 = spawnStruct();
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("firstCircleVo");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("giveStartFieldUpgrade");
  level.decoyassists = &groundz;
  thread ref_12800();
}

function ref_12800() {
  waittillframeend();
  var_0 = getdvarint("scr_redeployToken_convertAmount", 40);
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  scriptableinit();
  giveallplayersredeploytoken();
  var_1 = getdvarint("scr_respect_redeployConversionTime", 810);
  wait var_1;

  foreach(var_3 in level.players) {
    if(istrue(level.br_pickups.ref_12cb5) && var_3 scripts\mp\gametypes\br_public::hasrespawntoken() && var_0 > 0) {
      var_3 scripts\mp\gametypes\br_pickups::removerespawntoken();
      var_3 scripts\mp\gametypes\br_plunder::ref_12627(var_0);
      var_3 scripts\mp\utility\lower_message::ref_1316e("br_redeploy_conversion", undefined, 5);
    }
  }
}

function groundz() {
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("movingCircle");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
  var_0 = getdvarint("scr_respect_circle1_closeTime", 780);
  var_1 = getdvarint("scr_respect_circle2_closeTime", 120);
  var_2 = getdvarint("scr_respect_circle1_closeRadius", 3000);

  switch (getdvarint("scr_respect_circle_speed", 0)) {
    case 0:
      level.ref_12cb9.groundentity = [30, 30];
      level.ref_12cb9.ground_spawners = [var_0, var_1];
      level.br_level.default_player_connect_black_screen = [0, 0];
      level.br_level.default_suicidebomber_combat = [0, 0];
      level.br_level.br_circleradii = [75000, var_2, 0];
      level.br_level.br_circleminimapradii = [9000, 5500];
      break;
    case 1:
      level.ref_12cb9.groundentity = [60];
      level.ref_12cb9.ground_spawners = [var_0];
      level.br_level.default_player_connect_black_screen = [0];
      level.br_level.default_suicidebomber_combat = [0];
      level.br_level.br_circleradii = [75000, 0];
      level.br_level.br_circleminimapradii = [6000];
      break;
  }

  level.br_level.br_circledelaytimes = level.ref_12cb9.groundentity;
  level.br_level.br_circleclosetimes = level.ref_12cb9.ground_spawners;
}

function ref_12cba(var_0) {
  if(getdvarint("scr_respect_kill_logic_enabled", 0) == 0) {
    return;
  }

  if(!isDefined(var_0) || !isPlayer(var_0) || istrue(var_0.inlaststand) || !var_0 scripts\cp_mp\utility\player_utility::_isalive() || var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || istrue(var_0.isjuggernaut)) {
    return;
  }

  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(scripts\mp\utility\weapon::ismeleeonly(var_3) || scripts\mp\utility\weapon::issuperweapon(var_3) || scripts\mp\utility\weapon::iskillstreakweapon(var_3) || scripts\mp\utility\weapon::isgamemodeweapon(var_3)) {
      continue;
    }

    var_4 = scripts\mp\utility\weapon::getweapongroup(var_3);
    var_5 = 3;
    var_6 = scripts\mp\weapons::getammooverride(var_3) * var_5;

    if(var_3.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_3.underbarrel) == "ubshtgn") {
      var_7 = var_0 getweaponammoclip(var_3);
      var_8 = int(var_7 + var_6);
      var_0 setweaponammoclip(var_3, var_8);
      continue;
    }

    var_9 = var_0 getweaponammostock(var_3);
    var_8 = int(var_9 + var_6);
    var_0 setweaponammostock(var_3, var_8);
  }

  var_11 = var_0 scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(var_11)) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_11);
  }

  var_12 = var_0 scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(var_12)) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_12);
  }

  var_0.health = var_0.maxhealth;
  var_0 playsoundtoplayer("ammo_crate_use", var_0);
}

function scriptableinit() {
  foreach(var_1 in level.players) {
    scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_1, "brloot_equip_gasmask", 1, undefined, 0);
  }
}

function giveallplayersredeploytoken() {
  foreach(var_1 in level.players) {
    var_1 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
  }
}