/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3476.gsc
***************************************/

init() {
  var_0 = spawnStruct();
  var_0.id = "deployable_vest";
  var_0.weaponinfo = "deployable_vest_marker_mp";
  var_0.modelbase = "prop_ballistic_vest_iw6";
  var_0.modelbombsquad = "prop_ballistic_vest_iw6_bombsquad";
  var_0.hintstring = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
  var_0.var_3A41 = &"KILLSTREAKS_BOX_GETTING_VEST";
  var_0.var_67E5 = "deployable_vest_taken";
  var_0.streakname = "deployable_vest";
  var_0.var_10A38 = "used_deployable_vest";
  var_0.shadername = "compass_objpoint_deploy_friendly";
  var_0.headiconoffset = 20;
  var_0.lifespan = 90.0;
  var_0.usexp = 50;
  var_0.scorepopup = "destroyed_vest";
  var_0.vodestroyed = "ballistic_vest_destroyed";
  var_0.deployedsfx = "mp_vest_deployed_ui";
  var_0.onusesfx = "ammo_crate_use";
  var_0.onusecallback = ::onusedeployable;
  var_0.canusecallback = ::func_3937;
  var_0.usetime = 1000;
  var_0.maxhealth = 220;
  var_0.damagefeedback = "deployable_bag";
  var_0.deathvfx = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
  var_0.allowmeleedamage = 1;
  var_0.allowhvtspawn = 0;
  var_0.maxuses = 4;
  var_0.canuseotherboxes = 0;
  level.boxsettings["deployable_vest"] = var_0;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("deployable_vest", ::func_128E1);
  level.deployable_box["deployable_vest"] = [];
}

func_128E1(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_0, "deployable_vest");

  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_vest", self.origin);
  return 1;
}

func_3937(var_0) {
  return !scripts\mp\lightarmor::haslightarmor(self) && !scripts\mp\utility\game::isjuggernaut();

  if(isDefined(var_0) && var_0.owner == self && !isDefined(var_0.var_1A64)) {
    return 0;
  }

  return !scripts\mp\utility\game::isjuggernaut();
}

onusedeployable(var_0) {
  scripts\mp\perks\perkfunctions::setlightarmor();
}

get_adjusted_armor(var_0, var_1) {
  if(var_0 + level.deployablebox_vest_rank[var_1] > level.deployablebox_vest_max) {
    return level.deployablebox_vest_max;
  }

  return var_0 + level.deployablebox_vest_rank[var_1];
}