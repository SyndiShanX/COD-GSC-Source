/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\deployablebox_vest.gsc
*********************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.id = "deployable_vest";
  var_0.weaponinfo = "deployable_vest_marker_mp";
  var_0.modelbase = "prop_ballistic_vest_iw6";
  var_0.modelbombsquad = "prop_ballistic_vest_iw6_bombsquad";
  var_0.hintstring = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
  var_0.capturingstring = &"KILLSTREAKS_BOX_GETTING_VEST";
  var_0.event = "deployable_vest_taken";
  var_0.streakname = "deployable_vest";
  var_0.splashname = "used_deployable_vest";
  var_0.shadername = "compass_objpoint_deploy_friendly";
  var_0.headiconoffset = 20;
  var_0.lifespan = 90;
  var_0.usexp = 50;
  var_0.scorepopup = "destroyed_vest";
  var_0.vodestroyed = "ballistic_vest_destroyed";
  var_0.deployedsfx = "mp_vest_deployed_ui";
  var_0.onusesfx = "ammo_crate_use";
  var_0.onusecallback = &onusedeployable;
  var_0.canusecallback = &canusedeployable;
  var_0.usetime = 1000;
  var_0.maxhealth = 220;
  var_0.damagefeedback = "deployable_bag";
  var_0.deathvfx = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  var_0.allowmeleedamage = 1;
  var_0.allowgrenadedamage = 0;
  var_0.maxuses = 4;
  var_0.canuseotherboxes = 0;
  level.boxsettings["deployable_vest"] = var_0;
  level.deployable_box["deployable_vest"] = [];
}

function tryusedeployablevest(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_0, "deployable_vest");

  if(!isDefined(var_2) || !var_2) {
    return false;
  }

  scripts\common\utility::ref_13e0a(level.ref_11b2a, "deployable_vest", self.origin);
  return true;
}

function canusedeployable(var_0) {
  return !scripts\mp\lightarmor::haslightarmor(self);
}

function onusedeployable(var_0) {
  scripts\mp\perks\perkfunctions::setlightarmor();
}

function get_adjusted_armor(var_0, var_1) {
  if(var_0 + level.deployablebox_vest_rank[var_1] > level.deployablebox_vest_max) {
    return level.deployablebox_vest_max;
  }

  return var_0 + level.deployablebox_vest_rank[var_1];
}