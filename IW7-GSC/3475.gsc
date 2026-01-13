/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3475.gsc
**************************************/

init() {
  var_0 = spawnStruct();
  var_0.weaponinfo = "deployable_vest_marker_mp";
  var_0.modelbase = "afr_mortar_ammo_01";
  var_0.hintstring = &"KILLSTREAKS_HINTS_DEPLOYABLE_JUICEBOX_PICKUP";
  var_0.var_3A41 = &"KILLSTREAKS_DEPLOYABLE_JUICEBOX_TAKING";
  var_0.var_67E5 = "deployable_juicebox_taken";
  var_0.streakname = "deployable_juicebox";
  var_0.var_10A38 = "used_deployable_juicebox";
  var_0.shadername = "compass_objpoint_deploy_juiced_friendly";
  var_0.headiconoffset = 25;
  var_0.lifespan = 90.0;
  var_0.usexp = 50;
  var_0.scorepopup = "destroyed_vest";
  var_0.vodestroyed = "ballistic_vest_destroyed";
  var_0.deployedsfx = "mp_vest_deployed_ui";
  var_0.onusesfx = "ammo_crate_use";
  var_0.onusecallback = ::onusedeployable;
  var_0.canusecallback = ::func_3937;
  var_0.usetime = 500;
  var_0.maxhealth = 300;
  var_0.damagefeedback = "deployable_bag";
  var_0.deathweaponinfo = "deployable_ammo_mp";
  var_0.deathvfx = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
  var_0.allowmeleedamage = 1;
  var_0.allowhvtspawn = 0;
  var_0.maxuses = 4;
  level.boxsettings["deployable_juicebox"] = var_0;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("deployable_juicebox", ::func_128E0);
  level.deployable_box["deployable_juicebox"] = [];
}

func_128E0(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_0, "deployable_juicebox");

  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_juicebox", self.origin);
  return 1;
}

onusedeployable(var_0) {
  thread scripts\mp\perks\perkfunctions::setjuiced(15);
}

func_3937(var_0) {
  return !scripts\mp\utility\game::isjuggernaut() && !scripts\mp\perks\perkfunctions::hasjuiced();
}