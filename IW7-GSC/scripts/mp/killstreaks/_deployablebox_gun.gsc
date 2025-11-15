/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_deployablebox_gun.gsc
*********************************************************/

init() {
  var_00 = spawnStruct();
  var_00.id = "deployable_weapon_crate";
  var_00.var_39B = "crate_marker_mp";
  var_00.modelbase = "mp_weapon_crate";
  var_00.modelbombsquad = "mp_weapon_crate_bombsquad";
  var_00.pow = & "KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
  var_00.var_3A41 = & "KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
  var_00.var_67E5 = "deployable_ammo_taken";
  var_00.streakname = "deployable_ammo";
  var_00.var_10A38 = "used_deployable_ammo";
  var_00.shadername = "compass_objpoint_deploy_ammo_friendly";
  var_00.headiconoffset = 20;
  var_00.lifespan = 20;
  var_00.vogone = "ammocrate_gone";
  var_00.usexp = 0;
  var_00.scorepopup = "destroyed_ammo";
  var_00.vodestroyed = "ammocrate_destroyed";
  var_00.deployedsfx = "mp_vest_deployed_ui";
  var_00.onusesfx = "ammo_crate_use";
  var_00.onusecallback = ::onusedeployable;
  var_00.canusecallback = ::func_3937;
  var_00.nousekillstreak = 1;
  var_00.usetime = 1000;
  var_00.maxhealth = 128;
  var_00.damagefeedback = "deployable_bag";
  var_00.deathvfx = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
  var_00.allowmeleedamage = 1;
  var_00.allowhvtspawn = 0;
  var_00.maxuses = 4;
  var_00.var_B7A5 = 20;
  var_00.minigunweapon = "iw6_minigun_mp";
  var_00.var_1E4B = 0.5;
  var_00.var_1E4C = 10;
  var_00.var_127C8 = 200;
  var_00.var_127C5 = 64;
  var_00.ondeploycallback = ::func_C4CF;
  var_00.canuseotherboxes = 0;
  level.boxsettings["deployable_ammo"] = var_00;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("deployable_ammo", undefined, ::func_128DD);
  level.var_5226 = randomintrange(1, var_00.var_B7A5 + 1);
  level.deployable_box["deployable_ammo"] = [];
}

func_1E3C(param_00) {
  func_128D7(1, param_00, "ammo_box_mp");
}

func_128D7(param_00, param_01, param_02) {
  var_03 = scripts\mp\killstreaks\_deployablebox::begindeployableviamarker(param_00, "deployable_ammo", param_01, param_02);
  if(!isDefined(var_03) || !var_03) {
    return 0;
  }

  return 1;
}

func_128DD(param_00, param_01) {
  var_02 = scripts\mp\killstreaks\_deployablebox::begindeployableviamarker(param_00.lifeid, "deployable_ammo", param_01, param_00.var_394);
  if(!isDefined(var_02) || !var_02) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_ammo", self.origin);
  return 1;
}

onusedeployable(param_00) {
  level.var_5226--;
  if(level.var_5226 == 0) {
    var_01 = level.boxsettings[param_00.boxtype];
    if(isDefined(level.var_5222)) {
      [
        [level.var_5222]
      ](1);
    } else {
      setviewmodeldepthoffield(self, var_01.minigunweapon);
    }

    scripts\mp\missions::processchallenge("ch_guninabox");
    level.var_5226 = randomintrange(var_01.var_B7A5, var_01.var_B7A5 + 1);
    return;
  }

  startpath(self);
}

func_C4CF(param_00) {
  thread func_E2B7(param_00);
}

startpath(param_00) {
  var_01 = [];
  foreach(var_03 in param_00 getweaponslistprimaries()) {
    var_01[var_01.size] = getweaponbasename(var_03);
  }

  var_05 = undefined;
  for(;;) {
    var_05 = scripts\mp\gametypes\sotf::getrandomweapon(level.weaponarray);
    var_06 = var_05["name"];
    if(!scripts\engine\utility::array_contains(var_01, var_06)) {
      break;
    }
  }

  var_05 = scripts\mp\gametypes\sotf::getrandomattachments(var_05);
  setviewmodeldepthoffield(param_00, var_05);
}

setviewmodeldepthoffield(param_00, param_01) {
  var_02 = param_00 getweaponslistprimaries();
  var_03 = 0;
  foreach(var_05 in var_02) {
    if(!scripts\mp\weapons::isaltmodeweapon(var_05)) {
      var_03++;
    }
  }

  if(var_03 > 1) {
    var_07 = param_00.lastdroppableweaponobj;
    if(isDefined(var_07) && var_07 != "none") {
      param_00 dropitem(var_07);
    }
  }

  param_00 scripts\mp\utility::_giveweapon(param_01);
  param_00 scripts\mp\utility::_switchtoweapon(param_01);
  param_00 givestartammo(param_01);
}

func_E2B7(param_00) {
  self endon("death");
  level endon("game_eneded");
  var_01 = spawn("trigger_radius", self.origin, 0, param_00.var_127C8, param_00.var_127C5);
  var_01.triggerportableradarping = self;
  thread scripts\mp\weapons::deleteondeath(var_01);
  if(isDefined(self.moving_platform)) {
    var_01 enablelinkto();
    var_01 linkto(self.moving_platform);
  }

  var_02 = param_00.var_127C8 * param_00.var_127C8;
  var_03 = undefined;
  for(;;) {
    var_04 = var_01 getistouchingentities(level.players);
    foreach(var_03 in var_04) {
      if(isDefined(var_03) && !self.triggerportableradarping scripts\mp\utility::isenemy(var_03)) {
        if(!isDefined(var_03.var_116D0) || !var_03.var_116D0) {
          var_03 thread func_93EF();
        }

        if(func_FFB8(var_03)) {
          func_17A8(var_03, param_00.var_1E4C);
        }
      }
    }

    wait(param_00.var_1E4B);
  }
}

func_93EF() {
  self endon("death");
  self endon("disconnect");
  thread scripts\mp\utility::func_F5C6(0, 6000, 2, 0);
  thread scripts\mp\utility::func_F5C5(0, 1, 2, 0);
  scripts\mp\powers::power_modifycooldownrate(1.1);
  wait(2);
  scripts\mp\powers::func_D74E();
}

func_FFB8(param_00) {
  return !isDefined(param_00.var_5227) || gettime() >= param_00.var_5227;
}

func_17A8(param_00, param_01) {
  param_00.var_5227 = gettime() + param_01 * 1000;
  scripts\mp\weapons::func_EBD2(param_00);
}

func_17A9(param_00, param_01, param_02) {
  self endon("death");
  param_00 endon("death");
  param_00 endon("disconnect");
  level endon("game_ended");
  for(;;) {
    func_17A8(param_00);
    wait(param_02);
    if(distancesquared(param_00.origin, self.origin) > param_01) {
      break;
    }
  }
}

func_3937(param_00) {
  return !scripts\mp\utility::isjuggernaut();
}