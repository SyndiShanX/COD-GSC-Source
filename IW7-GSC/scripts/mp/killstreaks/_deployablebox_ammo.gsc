/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_deployablebox_ammo.gsc
**********************************************************/

init() {
  var_0 = spawnStruct();
  var_0.var_39B = "deployable_vest_marker_mp";
  var_0.modelbase = "mil_ammo_case_1_open";
  var_0.pow = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
  var_0.var_3A41 = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
  var_0.var_67E5 = "deployable_ammo_taken";
  var_0.streakname = "deployable_ammo";
  var_0.var_10A38 = "used_deployable_ammo";
  var_0.shadername = "compass_objpoint_deploy_ammo_friendly";
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
  var_0.deathweaponinfo = "deployable_ammo_mp";
  var_0.deathvfx = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  var_0.deathdamageradius = 256;
  var_0.deathdamagemax = 130;
  var_0.deathdamagemin = 50;
  var_0.allowmeleedamage = 1;
  var_0.allowhvtspawn = 1;
  var_0.maxuses = 4;
  level.boxsettings["deployable_ammo"] = var_0;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("deployable_ammo", ::func_128DE);
  level.deployable_box["deployable_ammo"] = [];
}

func_128DE(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\_deployablebox::begindeployableviamarker(var_0, "deployable_ammo");
  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_ammo", self.origin);
  return 1;
}

onusedeployable(var_0) {
  func_17A6();
}

func_17A6() {
  var_0 = self getweaponslistall();
  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(scripts\mp\weapons::isbulletweapon(var_2)) {
        func_1805(var_2, 2);
        continue;
      }

      if(weaponclass(var_2) == "rocketlauncher") {
        func_1805(var_2, 1);
      }
    }
  }
}

func_1805(var_0, var_1) {
  var_2 = weaponclipsize(var_0);
  var_3 = self getweaponammostock(var_0);
  self setweaponammostock(var_0, var_3 + var_1 * var_2);
}

func_1819(var_0) {
  var_1 = self getweaponslistprimaries();
  foreach(var_3 in var_1) {
    if(scripts\mp\weapons::isbulletweapon(var_3)) {
      if(var_3 != "iw6_alienminigun_mp") {
        var_4 = self getweaponammostock(var_3);
        var_5 = weaponmaxammo(var_3);
        var_6 = var_4 + var_5 * var_0;
        self setweaponammostock(var_3, int(min(var_6, var_5)));
      }
    }
  }
}

func_17C6() {
  var_0 = self getweaponslistprimaries();
  foreach(var_2 in var_0) {
    var_3 = weaponclipsize(var_2);
    self setweaponammoclip(var_2, var_3);
  }
}

func_3937(var_0) {
  return !scripts\mp\utility::isjuggernaut();
}