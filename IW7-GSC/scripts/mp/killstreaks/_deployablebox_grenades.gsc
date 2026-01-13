/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_deployablebox_grenades.gsc
**************************************************************/

init() {
  var_0 = spawnStruct();
  var_0.var_39B = "deployable_vest_marker_mp";
  var_0.modelbase = "afr_mortar_ammo_01";
  var_0.pow = &"KILLSTREAKS_HINTS_DEPLOYABLE_GRENADES_PICKUP";
  var_0.var_3A41 = &"KILLSTREAKS_DEPLOYABLE_GRENADES_TAKING";
  var_0.var_67E5 = "deployable_grenades_taken";
  var_0.streakname = "deployable_grenades";
  var_0.var_10A38 = "used_deployable_grenades";
  var_0.shadername = "compass_objpoint_deploy_grenades_friendly";
  var_0.headiconoffset = 25;
  var_0.lifespan = 90;
  var_0.usexp = 50;
  var_0.scorepopup = "destroyed_vest";
  var_0.vodestroyed = "ballistic_vest_destroyed";
  var_0.deployedsfx = "mp_vest_deployed_ui";
  var_0.onusesfx = "ammo_crate_use";
  var_0.onusecallback = ::onusedeployable;
  var_0.canusecallback = ::func_3937;
  var_0.usetime = 500;
  var_0.maxhealth = 150;
  var_0.damagefeedback = "deployable_bag";
  var_0.deathweaponinfo = "deployable_grenades_mp";
  var_0.deathvfx = loadfx("vfx\core\expl\grenadeexp_default");
  var_0.deathdamageradius = 256;
  var_0.deathdamagemax = 150;
  var_0.deathdamagemin = 50;
  var_0.allowmeleedamage = 1;
  var_0.allowhvtspawn = 1;
  var_0.maxuses = 3;
  level.boxsettings["deployable_grenades"] = var_0;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("deployable_grenades", ::func_128DF);
  level.deployable_box["deployable_grenades"] = [];
}

func_128DF(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\_deployablebox::begindeployableviamarker(var_0, "deployable_grenades");
  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_grenades", self.origin);
  return 1;
}

onusedeployable(var_0) {
  func_DE4E();
}

func_DE4E() {
  var_0 = self getweaponslistall();
  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(scripts\mp\weapons::func_9E18(var_2) || scripts\mp\weapons::func_9EC0(var_2)) {
        self givestartammo(var_2);
      }
    }
  }
}

func_3937(var_0) {
  return !scripts\mp\utility::isjuggernaut();
}