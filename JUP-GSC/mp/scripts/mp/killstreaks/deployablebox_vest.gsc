/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\deployablebox_vest.gsc
************************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\deployablebox;
#using scripts\mp\lightarmor;
#using scripts\mp\perks\perkfunctions;
#namespace deployablebox_vest;

function init() {
  boxconfig = spawnStruct();
  boxconfig.id = "deployable_vest";
  boxconfig.weaponinfo = "deployable_vest_marker_mp";
  boxconfig.modelbase = "prop_ballistic_vest_iw6";
  boxconfig.modelbombsquad = "prop_ballistic_vest_iw6_bombsquad";
  boxconfig.hintstring = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
  boxconfig.capturingstring = &"KILLSTREAKS_BOX_GETTING_VEST";
  boxconfig.event = "deployable_vest_taken";
  boxconfig.streakname = "deployable_vest";
  boxconfig.splashname = "used_deployable_vest";
  boxconfig.shadername = "compass_objpoint_deploy_friendly";
  boxconfig.headiconoffset = 20;
  boxconfig.lifespan = 90;
  boxconfig.usexp = 50;
  boxconfig.scorepopup = "destroyed_vest";
  boxconfig.vodestroyed = "ballistic_vest_destroyed";
  boxconfig.deployedsfx = "mp_vest_deployed_ui";
  boxconfig.onusesfx = "ammo_crate_use";
  boxconfig.onusecallback = &onusedeployable;
  boxconfig.canusecallback = &canusedeployable;
  boxconfig.usetime = 1000;
  boxconfig.maxhealth = 220;
  boxconfig.damagefeedback = "deployable_bag";
  boxconfig.deathvfx = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  boxconfig.allowmeleedamage = 1;
  boxconfig.allowgrenadedamage = 0;
  boxconfig.maxuses = 4;
  boxconfig.canuseotherboxes = 0;
  level.boxsettings["deployable_vest"] = boxconfig;
  assertmsg("<dev string:x1c>");
  level.deployable_box["deployable_vest"] = [];
}

function tryusedeployablevest(lifeid, streakname) {
  result = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(lifeid, "deployable_vest");

  if(!isDefined(result) || !result) {
    return false;
  }

  utility::trycall(level.matchdata_logkillstreakevent, "deployable_vest", self.origin);
  return true;
}

function canusedeployable(boxent) {
  return !scripts\mp\lightarmor::haslightarmor(self);
}

function onusedeployable(boxent) {
  scripts\mp\perks\perkfunctions::setlightarmor();
}

function get_adjusted_armor(existing_armor, rank) {
  if(existing_armor + level.deployablebox_vest_rank[rank] > level.deployablebox_vest_max) {
    return level.deployablebox_vest_max;
  }

  return existing_armor + level.deployablebox_vest_rank[rank];
}