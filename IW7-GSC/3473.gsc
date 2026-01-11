/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3473.gsc
***************************************/

init() {
  var_00 = spawnStruct();
  var_0.weaponinfo = "deployable_vest_marker_mp";
  var_0.modelbase = "afr_mortar_ammo_01";
  var_0.hintstring = &"KILLSTREAKS_HINTS_DEPLOYABLE_GRENADES_PICKUP";
  var_0.func_3A41 = &"KILLSTREAKS_DEPLOYABLE_GRENADES_TAKING";
  var_0.func_67E5 = "deployable_grenades_taken";
  var_0.streakname = "deployable_grenades";
  var_0.func_10A38 = "used_deployable_grenades";
  var_0.shadername = "compass_objpoint_deploy_grenades_friendly";
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
  level.boxsettings["deployable_grenades"] = var_00;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("deployable_grenades", ::func_128DF);
  level.deployable_box["deployable_grenades"] = [];
}

func_128DF(var_00, var_01) {
  var_02 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_00, "deployable_grenades");

  if(!isDefined(var_02) || !var_02) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_grenades", self.origin);
  return 1;
}

onusedeployable(var_00) {
  func_DE4E();
}

func_DE4E() {
  var_00 = self getweaponslistall();

  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      if(scripts\mp\weapons::func_9E18(var_02) || scripts\mp\weapons::func_9EC0(var_02)) {
        self givestartammo(var_02);
      }
    }
  }
}

func_3937(var_00) {
  return !scripts\mp\utility\game::isjuggernaut();
}