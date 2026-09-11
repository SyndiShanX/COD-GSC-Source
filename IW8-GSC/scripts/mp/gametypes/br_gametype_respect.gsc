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
  var0 = getdvarint("scr_redeployToken_convertAmount", 40);
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  scriptableinit();
  giveallplayersredeploytoken();
  var1 = getdvarint("scr_respect_redeployConversionTime", 810);
  wait var1;

  foreach(var3 in level.players) {
    if(istrue(level.br_pickups.ref_12cb5) && var3 scripts\mp\gametypes\br_public::hasrespawntoken() && var0 > 0) {
      var3 scripts\mp\gametypes\br_pickups::removerespawntoken();
      var3 scripts\mp\gametypes\br_plunder::ref_12627(var0);
      var3 scripts\mp\utility\lower_message::ref_1316e("br_redeploy_conversion", undefined, 5);
    }
  }
}

function groundz() {
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("movingCircle");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
  var0 = getdvarint("scr_respect_circle1_closeTime", 780);
  var1 = getdvarint("scr_respect_circle2_closeTime", 120);
  var2 = getdvarint("scr_respect_circle1_closeRadius", 3000);

  switch (getdvarint("scr_respect_circle_speed", 0)) {
    case 0:
      level.ref_12cb9.groundentity = [30, 30];
      level.ref_12cb9.ground_spawners = [var0, var1];
      level.br_level.default_player_connect_black_screen = [0, 0];
      level.br_level.default_suicidebomber_combat = [0, 0];
      level.br_level.br_circleradii = [75000, var2, 0];
      level.br_level.br_circleminimapradii = [9000, 5500];
      break;
    case 1:
      level.ref_12cb9.groundentity = [60];
      level.ref_12cb9.ground_spawners = [var0];
      level.br_level.default_player_connect_black_screen = [0];
      level.br_level.default_suicidebomber_combat = [0];
      level.br_level.br_circleradii = [75000, 0];
      level.br_level.br_circleminimapradii = [6000];
      break;
  }

  level.br_level.br_circledelaytimes = level.ref_12cb9.groundentity;
  level.br_level.br_circleclosetimes = level.ref_12cb9.ground_spawners;
}

function ref_12cba(var0) {
  if(getdvarint("scr_respect_kill_logic_enabled", 0) == 0) {
    return;
  }

  if(!isDefined(var0) || !isPlayer(var0) || istrue(var0.inlaststand) || !var0 scripts\cp_mp\utility\player_utility::_isalive() || var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || istrue(var0.isjuggernaut)) {
    return;
  }

  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    if(scripts\mp\utility\weapon::ismeleeonly(var3) || scripts\mp\utility\weapon::issuperweapon(var3) || scripts\mp\utility\weapon::iskillstreakweapon(var3) || scripts\mp\utility\weapon::isgamemodeweapon(var3)) {
      continue;
    }

    var4 = scripts\mp\utility\weapon::getweapongroup(var3);
    var5 = 3;
    var6 = scripts\mp\weapons::getammooverride(var3) * var5;

    if(var3.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var3.underbarrel) == "ubshtgn") {
      var7 = var0 getweaponammoclip(var3);
      var8 = int(var7 + var6);
      var0 setweaponammoclip(var3, var8);
      continue;
    }

    var9 = var0 getweaponammostock(var3);
    var8 = int(var9 + var6);
    var0 setweaponammostock(var3, var8);
  }

  var11 = var0 scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(var11)) {
    var0 scripts\mp\equipment::incrementequipmentammo(var11);
  }

  var12 = var0 scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(var12)) {
    var0 scripts\mp\equipment::incrementequipmentammo(var12);
  }

  var0.health = var0.maxhealth;
  var0 playsoundtoplayer("ammo_crate_use", var0);
}

function scriptableinit() {
  foreach(var1 in level.players) {
    scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var1, "brloot_equip_gasmask", 1, undefined, 0);
  }
}

function giveallplayersredeploytoken() {
  foreach(var1 in level.players) {
    var1 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
  }
}