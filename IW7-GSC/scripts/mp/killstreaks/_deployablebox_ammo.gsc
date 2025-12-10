/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_deployablebox_ammo.gsc
**********************************************************/

init() {
  var_00 = spawnStruct();
  var_00.var_39B = "deployable_vest_marker_mp";
  var_00.modelbase = "mil_ammo_case_1_open";
  var_00.pow = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
  var_00.var_3A41 = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
  var_00.var_67E5 = "deployable_ammo_taken";
  var_00.streakname = "deployable_ammo";
  var_00.var_10A38 = "used_deployable_ammo";
  var_00.shadername = "compass_objpoint_deploy_ammo_friendly";
  var_00.headiconoffset = 25;
  var_00.lifespan = 90;
  var_00.usexp = 50;
  var_00.scorepopup = "destroyed_vest";
  var_00.vodestroyed = "ballistic_vest_destroyed";
  var_00.deployedsfx = "mp_vest_deployed_ui";
  var_00.onusesfx = "ammo_crate_use";
  var_00.onusecallback = ::onusedeployable;
  var_00.canusecallback = ::func_3937;
  var_00.usetime = 500;
  var_00.maxhealth = 150;
  var_00.damagefeedback = "deployable_bag";
  var_00.deathweaponinfo = "deployable_ammo_mp";
  var_00.deathvfx = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  var_00.deathdamageradius = 256;
  var_00.deathdamagemax = 130;
  var_00.deathdamagemin = 50;
  var_00.allowmeleedamage = 1;
  var_00.allowhvtspawn = 1;
  var_00.maxuses = 4;
  level.boxsettings["deployable_ammo"] = var_00;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("deployable_ammo", ::func_128DE);
  level.deployable_box["deployable_ammo"] = [];
}

func_128DE(param_00, param_01) {
  var_02 = scripts\mp\killstreaks\_deployablebox::begindeployableviamarker(param_00, "deployable_ammo");
  if(!isDefined(var_02) || !var_02) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_ammo", self.origin);
  return 1;
}

onusedeployable(param_00) {
  func_17A6();
}

func_17A6() {
  var_00 = self getweaponslistall();
  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      if(scripts\mp\weapons::isbulletweapon(var_02)) {
        func_1805(var_02, 2);
        continue;
      }

      if(weaponclass(var_02) == "rocketlauncher") {
        func_1805(var_02, 1);
      }
    }
  }
}

func_1805(param_00, param_01) {
  var_02 = weaponclipsize(param_00);
  var_03 = self getweaponammostock(param_00);
  self setweaponammostock(param_00, var_03 + param_01 * var_02);
}

func_1819(param_00) {
  var_01 = self getweaponslistprimaries();
  foreach(var_03 in var_01) {
    if(scripts\mp\weapons::isbulletweapon(var_03)) {
      if(var_03 != "iw6_alienminigun_mp") {
        var_04 = self getweaponammostock(var_03);
        var_05 = weaponmaxammo(var_03);
        var_06 = var_04 + var_05 * param_00;
        self setweaponammostock(var_03, int(min(var_06, var_05)));
      }
    }
  }
}

func_17C6() {
  var_00 = self getweaponslistprimaries();
  foreach(var_02 in var_00) {
    var_03 = weaponclipsize(var_02);
    self setweaponammoclip(var_02, var_03);
  }
}

func_3937(param_00) {
  return !scripts\mp\utility::isjuggernaut();
}