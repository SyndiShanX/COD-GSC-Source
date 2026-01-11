/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3474.gsc
***************************************/

init() {
  var_00 = spawnStruct();
  var_0.id = "deployable_weapon_crate";
  var_0.weaponinfo = "crate_marker_mp";
  var_0.modelbase = "mp_weapon_crate";
  var_0.modelbombsquad = "mp_weapon_crate_bombsquad";
  var_0.hintstring = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
  var_0.func_3A41 = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
  var_0.func_67E5 = "deployable_ammo_taken";
  var_0.streakname = "deployable_ammo";
  var_0.func_10A38 = "used_deployable_ammo";
  var_0.shadername = "compass_objpoint_deploy_ammo_friendly";
  var_0.headiconoffset = 20;
  var_0.lifespan = 20.0;
  var_0.vogone = "ammocrate_gone";
  var_0.usexp = 0;
  var_0.scorepopup = "destroyed_ammo";
  var_0.vodestroyed = "ammocrate_destroyed";
  var_0.deployedsfx = "mp_vest_deployed_ui";
  var_0.onusesfx = "ammo_crate_use";
  var_0.onusecallback = ::onusedeployable;
  var_0.canusecallback = ::func_3937;
  var_0.nousekillstreak = 1;
  var_0.usetime = 1000;
  var_0.maxhealth = 128;
  var_0.damagefeedback = "deployable_bag";
  var_0.deathvfx = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
  var_0.allowmeleedamage = 1;
  var_0.allowhvtspawn = 0;
  var_0.maxuses = 4;
  var_0.func_B7A5 = 20;
  var_0.minigunweapon = "iw6_minigun_mp";
  var_0.func_1E4B = 0.5;
  var_0.func_1E4C = 10.0;
  var_0.func_127C8 = 200;
  var_0.func_127C5 = 64;
  var_0.ondeploycallback = ::func_C4CF;
  var_0.canuseotherboxes = 0;
  level.boxsettings["deployable_ammo"] = var_00;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("deployable_ammo", undefined, ::func_128DD);
  level.func_5226 = randomintrange(1, var_0.func_B7A5 + 1);
  level.deployable_box["deployable_ammo"] = [];
}

func_1E3C(var_00) {
  func_128D7(1, var_00, "ammo_box_mp");
}

func_128D7(var_00, var_01, var_02) {
  var_03 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_00, "deployable_ammo", var_01, var_02);

  if(!isDefined(var_03) || !var_03) {
    return 0;
  }

  return 1;
}

func_128DD(var_00, var_01) {
  var_02 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_0.lifeid, "deployable_ammo", var_01, var_0.weapon);

  if(!isDefined(var_02) || !var_02) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_ammo", self.origin);
  return 1;
}

onusedeployable(var_00) {
  level.func_5226--;

  if(level.func_5226 == 0) {
    var_01 = level.boxsettings[var_0.boxtype];

    if(isDefined(level.func_5222)) {
      [
        [level.func_5222]
      ](1);
    } else {
      setviewmodeldepthoffield(self, var_1.minigunweapon);
    }

    scripts\mp\missions::processchallenge("ch_guninabox");
    level.func_5226 = randomintrange(var_1.func_B7A5, var_1.func_B7A5 + 1);
  } else
    startpath(self);
}

func_C4CF(var_00) {
  thread func_E2B7(var_00);
}

startpath(var_00) {
  var_01 = [];

  foreach(var_03 in var_00 getweaponslistprimaries()) {
    var_1[var_1.size] = getweaponbasename(var_03);
  }

  var_05 = undefined;

  for(;;) {
    var_05 = scripts\mp\gametypes\sotf::getrandomweapon(level.weaponarray);
    var_06 = var_5["name"];

    if(!scripts\engine\utility::array_contains(var_01, var_06)) {
      break;
    }
  }

  var_05 = scripts\mp\gametypes\sotf::getrandomattachments(var_05);
  setviewmodeldepthoffield(var_00, var_05);
}

setviewmodeldepthoffield(var_00, var_01) {
  var_02 = var_00 getweaponslistprimaries();
  var_03 = 0;

  foreach(var_05 in var_02) {
    if(!scripts\mp\weapons::isaltmodeweapon(var_05)) {
      var_3++;
    }
  }

  if(var_03 > 1) {
    var_07 = var_0.lastdroppableweaponobj;

    if(isDefined(var_07) && var_07 != "none") {
      var_00 dropitem(var_07);
    }
  }

  var_00 scripts\mp\utility\game::_giveweapon(var_01);
  var_00 scripts\mp\utility\game::_switchtoweapon(var_01);
  var_00 givestartammo(var_01);
}

func_E2B7(var_00) {
  self endon("death");
  level endon("game_eneded");
  var_01 = spawn("trigger_radius", self.origin, 0, var_0.func_127C8, var_0.func_127C5);
  var_1.owner = self;
  thread scripts\mp\weapons::deleteondeath(var_01);

  if(isDefined(self.moving_platform)) {
    var_01 getrankxp();
    var_01 linkto(self.moving_platform);
  }

  var_02 = var_0.func_127C8 * var_0.func_127C8;
  var_03 = undefined;

  for(;;) {
    var_04 = var_01 getistouchingentities(level.players);

    foreach(var_03 in var_04) {
      if(isDefined(var_03) && !self.owner scripts\mp\utility\game::isenemy(var_03)) {
        if(!isDefined(var_3.func_116D0) || !var_3.func_116D0) {
          var_03 thread func_93EF();
        }

        if(func_FFB8(var_03)) {
          func_17A8(var_03, var_0.func_1E4C);
        }
      }
    }

    wait(var_0.func_1E4B);
  }
}

func_93EF() {
  self endon("death");
  self endon("disconnect");
  thread scripts\mp\utility\game::func_F5C6(0, 6000, 2, 0);
  thread scripts\mp\utility\game::func_F5C5(0, 1, 2, 0);
  scripts\mp\powers::power_modifycooldownrate(1.1);
  wait 2;
  scripts\mp\powers::func_D74E();
}

func_FFB8(var_00) {
  return !isDefined(var_0.func_5227) || gettime() >= var_0.func_5227;
}

func_17A8(var_00, var_01) {
  var_0.func_5227 = gettime() + var_01 * 1000;
  scripts\mp\weapons::func_EBD2(var_00);
}

func_17A9(var_00, var_01, var_02) {
  self endon("death");
  var_00 endon("death");
  var_00 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    func_17A8(var_00);
    wait(var_02);

    if(distancesquared(var_0.origin, self.origin) > var_01) {
      break;
    }
  }
}

func_3937(var_00) {
  return !scripts\mp\utility\game::isjuggernaut();
}