/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playeractions.gsc
***********************************************/

function init() {
  var0 = spawnStruct();
  level.actionglobals = var0;
  var0.actions = [];
  var0.actionsets = [];
  addaction("usability", &scripts\common\utility::allow_usability);
  addaction("weapon", &scripts\common\utility::allow_weapon);
  addaction("weapon_switch", &scripts\common\utility::allow_weapon_switch);
  addaction("offhand_weapons", &scripts\common\utility::allow_offhand_weapons);
  addaction("offhand_primary_weapons", &scripts\common\utility::allow_offhand_primary_weapons);
  addaction("offhand_secondary_weapons", &scripts\common\utility::allow_offhand_secondary_weapons);
  addaction("killstreaks", &scripts\common\utility::allow_killstreaks);
  addaction("supers", &scripts\common\utility::allow_supers);
  addaction("gesture", &scripts\mp\utility\player::allow_gesture);
  addaction("ads", &scripts\common\utility::allow_ads);
  addaction("reload", &scripts\common\utility::allow_reload);
  addaction("autoreload", &scripts\common\utility::allow_autoreload);
  addaction("allow_movement", &scripts\common\utility::allow_movement);
  addaction("allow_jump", &scripts\common\utility::allow_jump);
  addaction("sprint", &scripts\common\utility::allow_sprint);
  addaction("crouch", &scripts\common\utility::allow_crouch);
  addaction("prone", &scripts\common\utility::allow_prone);
  addaction("stand", &scripts\common\utility::allow_stand);
  addaction("fire", &scripts\common\utility::allow_fire);
  addaction("slide", &scripts\common\utility::allow_slide);
  addaction("melee", &scripts\common\utility::allow_melee);
  addaction("shellshock", &scripts\common\utility::allow_shellshock);
  addaction("cp_munitions", &scripts\common\utility::brjugg_initdroplocations);
  addaction("nvg", &scripts\common\utility::brjugg_oncrateuse);
}

function addaction(var0, var1) {
  level.actionglobals.actions[var0] = var1;
}

function getactionallowfunc(var0) {
  return level.actionglobals.actions[var0];
}

function registeractionset(var0, var1) {
  level.actionglobals.actionsets[var0] = var1;
}

function allowactionset(var0, var1) {
  foreach(var3 in level.actionglobals.actionsets[var0]) {
    var4 = getactionallowfunc(var3);
    [[var4]](var1, var0);
  }
}