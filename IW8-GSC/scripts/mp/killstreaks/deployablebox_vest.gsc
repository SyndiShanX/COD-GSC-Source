/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\deployablebox_vest.gsc
*********************************************************/

function init() {
  var0 = spawnStruct();
  var0.id = "deployable_vest";
  var0.weaponinfo = "deployable_vest_marker_mp";
  var0.modelbase = "prop_ballistic_vest_iw6";
  var0.modelbombsquad = "prop_ballistic_vest_iw6_bombsquad";
  var0.hintstring = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
  var0.capturingstring = &"KILLSTREAKS_BOX_GETTING_VEST";
  var0.event = "deployable_vest_taken";
  var0.streakname = "deployable_vest";
  var0.splashname = "used_deployable_vest";
  var0.shadername = "compass_objpoint_deploy_friendly";
  var0.headiconoffset = 20;
  var0.lifespan = 90;
  var0.usexp = 50;
  var0.scorepopup = "destroyed_vest";
  var0.vodestroyed = "ballistic_vest_destroyed";
  var0.deployedsfx = "mp_vest_deployed_ui";
  var0.onusesfx = "ammo_crate_use";
  var0.onusecallback = &onusedeployable;
  var0.canusecallback = &canusedeployable;
  var0.usetime = 1000;
  var0.maxhealth = 220;
  var0.damagefeedback = "deployable_bag";
  var0.deathvfx = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  var0.allowmeleedamage = 1;
  var0.allowgrenadedamage = 0;
  var0.maxuses = 4;
  var0.canuseotherboxes = 0;
  level.boxsettings["deployable_vest"] = var0;
  level.deployable_box["deployable_vest"] = [];
}

function tryusedeployablevest(var0, var1) {
  var2 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var0, "deployable_vest");

  if(!isDefined(var2) || !var2) {
    return false;
  }

  scripts\common\utility::ref_13e0a(level.ref_11b2a, "deployable_vest", self.origin);
  return true;
}

function canusedeployable(var0) {
  return !scripts\mp\lightarmor::haslightarmor(self);
}

function onusedeployable(var0) {
  scripts\mp\perks\perkfunctions::setlightarmor();
}

function get_adjusted_armor(var0, var1) {
  if(var0 + level.deployablebox_vest_rank[var1] > level.deployablebox_vest_max) {
    return level.deployablebox_vest_max;
  }

  return var0 + level.deployablebox_vest_rank[var1];
}