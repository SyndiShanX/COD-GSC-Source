/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3474.gsc
***************************************/

init() {
  var_0 = spawnStruct();
  var_0.id = "deployable_weapon_crate";
  var_0.weaponinfo = "crate_marker_mp";
  var_0.modelbase = "mp_weapon_crate";
  var_0.modelbombsquad = "mp_weapon_crate_bombsquad";
  var_0.hintstring = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
  var_0.var_3A41 = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
  var_0.var_67E5 = "deployable_ammo_taken";
  var_0.streakname = "deployable_ammo";
  var_0.var_10A38 = "used_deployable_ammo";
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
  var_0.var_B7A5 = 20;
  var_0.minigunweapon = "iw6_minigun_mp";
  var_0.var_1E4B = 0.5;
  var_0.var_1E4C = 10.0;
  var_0.var_127C8 = 200;
  var_0.var_127C5 = 64;
  var_0.ondeploycallback = ::func_C4CF;
  var_0.canuseotherboxes = 0;
  level.boxsettings["deployable_ammo"] = var_0;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("deployable_ammo", undefined, ::func_128DD);
  level.var_5226 = randomintrange(1, var_0.var_B7A5 + 1);
  level.deployable_box["deployable_ammo"] = [];
}

func_1E3C(var_0) {
  func_128D7(1, var_0, "ammo_box_mp");
}

func_128D7(var_0, var_1, var_2) {
  var_3 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_0, "deployable_ammo", var_1, var_2);

  if(!isDefined(var_3) || !var_3) {
    return 0;
  }

  return 1;
}

func_128DD(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\deployablebox::begindeployableviamarker(var_0.lifeid, "deployable_ammo", var_1, var_0.weapon);

  if(!isDefined(var_2) || !var_2) {
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("deployable_ammo", self.origin);
  return 1;
}

onusedeployable(var_0) {
  level.var_5226--;

  if(level.var_5226 == 0) {
    var_1 = level.boxsettings[var_0.boxtype];

    if(isDefined(level.var_5222)) {
      [
        [level.var_5222]
      ](1);
    } else {
      setviewmodeldepthoffield(self, var_1.minigunweapon);
    }

    scripts\mp\missions::processchallenge("ch_guninabox");
    level.var_5226 = randomintrange(var_1.var_B7A5, var_1.var_B7A5 + 1);
  } else
    startpath(self);
}

func_C4CF(var_0) {
  thread func_E2B7(var_0);
}

startpath(var_0) {
  var_1 = [];

  foreach(var_3 in var_0 getweaponslistprimaries()) {
    var_1[var_1.size] = getweaponbasename(var_3);
  }

  var_5 = undefined;

  for(;;) {
    var_5 = scripts\mp\gametypes\sotf::getrandomweapon(level.weaponarray);
    var_6 = var_5["name"];

    if(!scripts\engine\utility::array_contains(var_1, var_6)) {
      break;
    }
  }

  var_5 = scripts\mp\gametypes\sotf::getrandomattachments(var_5);
  setviewmodeldepthoffield(var_0, var_5);
}

setviewmodeldepthoffield(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(!scripts\mp\weapons::isaltmodeweapon(var_5)) {
      var_3++;
    }
  }

  if(var_3 > 1) {
    var_7 = var_0.lastdroppableweaponobj;

    if(isDefined(var_7) && var_7 != "none") {
      var_0 dropitem(var_7);
    }
  }

  var_0 scripts\mp\utility\game::_giveweapon(var_1);
  var_0 scripts\mp\utility\game::_switchtoweapon(var_1);
  var_0 givestartammo(var_1);
}

func_E2B7(var_0) {
  self endon("death");
  level endon("game_eneded");
  var_1 = spawn("trigger_radius", self.origin, 0, var_0.var_127C8, var_0.var_127C5);
  var_1.owner = self;
  thread scripts\mp\weapons::deleteondeath(var_1);

  if(isDefined(self.moving_platform)) {
    var_1 getrankxp();
    var_1 linkto(self.moving_platform);
  }

  var_2 = var_0.var_127C8 * var_0.var_127C8;
  var_3 = undefined;

  for(;;) {
    var_4 = var_1 getistouchingentities(level.players);

    foreach(var_3 in var_4) {
      if(isDefined(var_3) && !self.owner scripts\mp\utility\game::isenemy(var_3)) {
        if(!isDefined(var_3.var_116D0) || !var_3.var_116D0) {
          var_3 thread func_93EF();
        }

        if(func_FFB8(var_3)) {
          func_17A8(var_3, var_0.var_1E4C);
        }
      }
    }

    wait(var_0.var_1E4B);
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

func_FFB8(var_0) {
  return !isDefined(var_0.var_5227) || gettime() >= var_0.var_5227;
}

func_17A8(var_0, var_1) {
  var_0.var_5227 = gettime() + var_1 * 1000;
  scripts\mp\weapons::func_EBD2(var_0);
}

func_17A9(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    func_17A8(var_0);
    wait(var_2);

    if(distancesquared(var_0.origin, self.origin) > var_1) {
      break;
    }
  }
}

func_3937(var_0) {
  return !scripts\mp\utility\game::isjuggernaut();
}