/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58270.gsc
***********************************************/

function ref_12a27() {
  level.ref_12a34 = [];
  level.ref_12a34["rcxd_rad"] = spawnStruct();
  level.ref_12a34["rcxd_rad"].timeout = getdvarfloat("scr_br_rcxd_rad_timeout", 45);
  level.ref_12a34["rcxd_rad"].maxhealth = 75;
  level.ref_12a34["rcxd_rad"].hitstokill = 3;
  level.ref_12a34["rcxd_rad"].speed = 140;
  level.ref_12a34["rcxd_rad"].accel = 20;
  level.ref_12a34["rcxd_rad"].halfsize = 27;
  level.ref_12a34["rcxd_rad"].spawndist = 30;
  level.ref_12a34["rcxd_rad"].streakname = "rcxd_rad";
  level.ref_12a34["rcxd_rad"].vehicleinfo = "veh_rcxd_rad_mp";
  level.ref_12a34["rcxd_rad"].modelbase = "lm_veh_t9_drone_rcxd";
  level.ref_12a34["rcxd_rad"].teamsplash = "used_rcxd_rad";
  level.ref_12a34["rcxd_rad"].destroyedsplash = "callout_destroyed_rcxd_rad";
  level.ref_12a34["rcxd_rad"].initbunker = 0.5;
  level.ref_12a34["rcxd_rad"].sound_explode = "recon_drone_explode";
  level.ref_12a34["rcxd_rad"].vodestroyed = "ball_drone_backup_destroy";
  level.ref_12a34["rcxd_rad"].votimedout = "ball_drone_backup_timeout";
  level.ref_12a34["rcxd_rad"].scorepopup = "destroyed_rcxd_rad";
  level.ref_12a34["rcxd_rad"].playfxcallback = &scripts\cp_mp\killstreaks\helper_drone::helperdronefx;
  level.ref_12a34["rcxd_rad"].primarymode = "MANUAL";
  level.ref_12a34["rcxd_rad"].primarymodestring = &"KILLSTREAKS_HINTS/RCD_MANUAL";
  level.ref_12a34["rcxd_rad"].primarymodefunc = &scripts\cp_mp\killstreaks\helper_drone::setreconmodesettings;
  level.ref_12a34["rcxd_rad"].premoddamagefunc = undefined;
  level.ref_12a34["rcxd_rad"].postmoddamagefunc = &scripts\cp_mp\killstreaks\helper_drone::helperdrone_modifydamageresponse;
  level.ref_12a34["rcxd_rad"].deployweaponname = "ks_remote_rcxd_mp";
  level.ref_12a34["rcxd_rad"].ref_11b06 = 1;
  level.ref_12a34["rcxd_rad"].ref_11b07 = 1;
  level.ref_12a34["rcxd_rad"].ref_11b17 = 73984;
  level.ref_12a34["rcxd_rad"].ref_11b18 = 73984;
  level.ref_12a34["rcxd_rad"].deathfunc = &ref_12a22;
  level.ref_12a34["rcxd_rad"].leaderinteractionthink = 1;
  level.ref_12a34["rcxd_rad"].diewithowner = 1;
  level.ref_12a34["rcxd_rad"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
  scripts\mp\killstreaks\killstreaks::registerkillstreak("rcxd_rad", &ref_13e2e, undefined, &ref_13e11);
  initmines();
  var_0 = getarraykeys(level.ref_12a34);

  foreach(var_2 in var_0) {
    var_3 = level.ref_12a34[var_2].hitstokill;

    if(isDefined(var_3)) {
      scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var_2, var_3);
      scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle("emp_grenade_mp", var_3, var_2);
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("rcxd_rad", &ref_12a22);
  game["dialog"]["rcxd_enemy"] = "rcxd_enemy";
  game["dialog"]["rcxd_friendly_use"] = "rcxd_friendly_use";
  level._effect["rcxdExplosion"] = loadfx("vfx/iw8_br/equipment/vfx_rcxd_exp_main");
}

function initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("rcxd_rad", 1);
  var_0.frontextents = 15;
  var_0.backextents = 15;
  var_0.leftextents = 15;
  var_0.rightextents = 15;
  var_0.bottomextents = 3;
  var_0.distancetobottom = 3;
}

function ref_13e2e(var_0) {
  var_1 = self;
  var_2 = ref_13e2f(var_1, var_0);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }
  }

  return var_2;
}

function ref_13e11() {
  var_0 = self;
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("rcxd_rad", var_0);
  var_1.ref_133ce = 1;
  var_2 = ref_13e2f(var_0, var_1);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }
  }

  return var_2;
}

function ref_13e2f(var_0) {
  var_1 = self;

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return false;
  }

  if(!self isonground() && !self isonladder() || _calloutmarkerping_handleluinotify_enemyrepinged::updateleaders()) {
    return false;
  }

  if(isDefined(level.getflagradarowner)) {
    if(![[level.getflagradarowner]](var_1)) {
      return false;
    }
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    return false;
  }

  var_2 = var_0.streakname;
  var_3 = level.ref_12a34[var_2].deployweaponname;
  var_4 = var_1 scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, &ref_14588, undefined, undefined, &deployweapontaken, var_3, 0, &ref_14405);
  var_1 scripts\common\utility::allow_usability(0);
  var_1 thread scripts\cp_mp\utility\killstreak_utility::tabletdofset(0, 1, 1);

  if(!istrue(var_4)) {
    ref_12a2a(var_1, var_0);
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      ref_12a2a(var_1, var_0);
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  var_1 scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  var_5 = 0.4;
  var_6 = var_1 scripts\engine\utility::ref_143ba(var_5, "death", "weapon_switch_started");

  if(!isDefined(var_6) || var_6 != "timeout") {
    ref_12a20(var_1, var_0);
    var_1 scripts\cp_mp\utility\player_utility::_freezecontrols(0);
    return false;
  }

  var_1 scripts\cp_mp\utility\player_utility::_freezecontrols(0);
  var_7 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var_1, var_0.streakname);
    var_7 = 2;
  }

  var_1 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_0.streakname, 1, var_7);
  var_8 = level.ref_12a34[var_2].teamsplash;
  var_6 = ref_13870(var_0);

  if(!istrue(var_6)) {
    ref_12a20(var_1, var_0);
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_8, var_1);
  }

  return true;
}

function ref_14405(var_0) {
  scripts\cp_mp\killstreaks\killstreakdeploy::waituntilfinishedwithdeployweapon(var_0);
  waitframe();
}

function ref_14588(var_0) {
  return true;
}

function deployweapontaken(var_0) {
  self notify("finished_deploy_weapon");
}

function ref_12e28() {
  var_0 = self;
  var_0 endon("death_or_disconnect");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var_1 = getcompleteweaponname("ks_remote_rcxd_mp");

  if(var_0 hasweapon(var_1)) {
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    return;
  }
}

function ref_13870(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_2 = spawnStruct();
  var_2.origin = var_1.origin + (100, 0, 0);
  var_2.angles = var_1.angles;
  var_2.modelname = "lm_veh_t9_drone_rcxd";
  var_2.vehicletype = "veh_rcxd_mp";
  var_2.targetname = "veh_rcxd";
  var_2.cannotbesuspended = 1;
  var_3 = spawnStruct();
  var_4 = ref_12a25(var_1, 100);

  if(!isDefined(var_4)) {
    ref_12a20(var_1, var_0);
    return false;
  }

  var_2.origin = var_4;
  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_2, var_3);

  if(!isDefined(var_5)) {
    ref_12a20(var_1, var_0);
    return false;
  }

  var_1.restoreangles = var_1 getplayerangles();
  var_5 setotherent(var_1);
  var_5 setentityowner(var_1);
  var_1 controlslinkTo(var_5);
  var_1 setclientomnvar("ui_rcd_controls", 9);
  var_5 scripts\cp_mp\utility\killstreak_utility::ref_11dc0(var_1);
  var_5.owner = var_1;
  var_5.team = var_1.team;
  var_5.vehiclename = var_0.streakname;
  var_6 = level.ref_12a34[var_0.streakname];
  var_5.streakinfo = var_0;
  var_5.owner.streakinfo = var_0;
  var_5.maxhealth = var_6.maxhealth;
  var_5.health = var_6.maxhealth;

  if(isDefined(var_6.damagemonitorfunc)) {
    var_5 thread[[var_6.damagemonitorfunc]]();
  }

  thread ref_12a33();
  thread ref_12a30();
  thread ref_12a2f();
  thread ref_12a32();
  thread ref_12a23();
  thread ref_12a2c(var_5);
  thread ref_12a2e();
  thread ref_12a2b();
  thread ref_12a28(var_5);

  if(scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread ref_12e28();
  }

  var_5 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  scripts\mp\outofbounds::registerentforoob(var_5, "killstreak");
  ref_12a29(var_5, "rcxd_enemy", 0, 1);
  ref_12a29(var_5, "rcxd_friendly_use", 1, 0);
  var_5 setscriptablepartstate("flash_light", "enabled", 0);
  return true;
}

function ref_12a25(var_0) {
  var_1 = undefined;
  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  var_6 = [var_2 + var_0 * var_4, var_2 - var_0 * var_4, var_2 + var_0 * var_5, var_2 - var_0 * var_5, var_2 + 0.707 * var_0 * (var_4 + var_5), var_2 + 0.707 * var_0 * (var_4 - var_5), var_2 + 0.707 * var_0 * (var_5 - var_4), var_2 + 0.707 * var_0 * (-1 * var_4 - var_5)];

  foreach(var_8 in var_6) {
    var_1 = ref_12a1d(var_2, var_8);

    if(isDefined(var_1)) {
      break;
    }
  }

  return var_1;
}

function ref_12a1d(var_0, var_1) {
  var_2 = undefined;
  var_3 = (0, 0, 45);
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);
  var_5 = var_0 + var_3;
  var_6 = var_1 + var_3;
  var_7 = 40;
  var_8 = scripts\engine\trace::ray_trace_passed(var_5, var_6, self, var_4);

  if(!istrue(var_8)) {
    return var_2;
  }

  var_9 = scripts\engine\trace::ray_trace(var_6, var_6 - (0, 0, 500), self, var_4);

  if(isDefined(var_9["position"]) && var_9["hittype"] != "hittype_none") {
    var_10 = var_9["position"] + var_3;
    var_11 = scripts\engine\trace::sphere_trace_passed(var_10, var_10, var_7, self, var_4);
    var_12 = undefined;

    if(level.teambased) {
      var_12 = self.team;
    }

    if(istrue(var_11) && !scripts\mp\outofbounds::ispointinoutofbounds(var_9["position"], var_12)) {
      var_2 = var_9["position"];
    }
  }

  var_13 = var_2;
  var_14 = 14.75;

  if(isDefined(var_2)) {
    var_15 = 1;
    var_16 = [(var_14, var_14, 0), (-1 * var_14, var_14, 0), (var_14, -1 * var_14, 0), (-1 * var_14, -1 * var_14, 0)];

    foreach(var_18 in var_16) {
      var_19 = var_13 + var_18;
      var_9 = scripts\engine\trace::ray_trace(var_13, var_19, self, var_4);

      if(isDefined(var_9["position"]) && var_9["hittype"] != "hittype_none") {
        var_20 = scripts\mp\outofbounds::ispointinoutofbounds(var_9["position"], self.team);

        if(!istrue(var_20)) {
          return undefined;
        }

        break;
      }
    }
  }

  return var_13;
}

function ref_12a20(var_0) {
  var_1 = self;
  ref_12a2a(var_1, var_0);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_0 notify("killstreak_finished_with_deploy_weapon");

  if(!var_1 scripts\common\utility::is_usability_allowed()) {
    var_1 scripts\common\utility::allow_usability(1);
    return;
  }
}

function ref_12a28(var_0) {
  var_1 = self;
  var_1.owner endon("disconnect");
  var_1 endon("death");
  var_1 endon("leaving");
  var_1 endon("explode");
  var_1 endon("switch_modes");
  var_1 vehphys_enablecollisioncallback(1);
  var_2 = var_1.streakinfo;

  for(;;) {
    var_1 waittill("collision", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(!isDefined(var_10)) {
      continue;
    }

    var_12 = undefined;

    if(var_10 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_12 = var_10;
    } else if(var_10 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      var_12 = var_10.vehicle;
    } else if(istrue(var_10.velstartid)) {
      var_12 = var_10;
    }

    if(!isDefined(var_12)) {
      continue;
    }

    var_13 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_1.owner, var_12.owner));

    if(istrue(var_0.leaderplunderstring)) {
      if(var_13 || !isDefined(var_12.owner)) {
        thread ref_12a24(var_1);
      } else {
        var_1 dodamage(var_1.maxhealth, var_12.origin, undefined, undefined, "MOD_CRUSH");
      }

      continue;
    }

    var_14 = undefined;
    var_15 = undefined;

    if(var_13) {
      var_16 = var_12.owner scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var_16) && var_16 == var_12) {
        var_14 = var_12.owner;
        var_15 = var_12;
      }
    }

    var_17 = var_1.maxhealth * var_0.initbunker;
    var_1 dodamage(var_17, var_12.origin, var_14, var_15, "MOD_CRUSH");
  }
}

function ref_12a33() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("explode");
  var_0.owner endon("disconnect");
  var_0 endon("owner_gone");
  var_1 = level.ref_12a34[var_0.vehiclename];
  var_0.timeout = var_1.timeout;

  if(!isDefined(var_0.timeout)) {
    return;
  }

  var_3 = var_0.streakinfo;

  if(var_0.timeout > 0) {
    var_0.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(var_0.timeout * 1000));
    wait var_0.timeout;
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var_1.votimedout, 1);
  thread ref_12a21(var_0);
}

function ref_12a21(var_0) {
  var_1 = 1;
  var_2 = self;

  if(!isDefined(var_0)) {
    var_0 = var_2.streakinfo;
  }

  if(!istrue(var_2.lbravo_spawner_safehouse1)) {
    thread ref_12a1e();
    var_2.lbravo_spawner_safehouse1 = 1;
  }

  var_2 vehphys_enablecollisioncallback(0);

  if(!isDefined(var_0)) {
    var_0 = var_2.streakinfo;
  }

  if(isDefined(var_2.owner)) {
    if(!isDefined(var_0)) {
      var_0 = var_2.owner.streakinfo;
    }

    var_2.owner.streakinfo = undefined;
  }

  if(!isDefined(var_2) || istrue(var_2.isdestroyed)) {
    if(isDefined(var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
    }

    return;
  }

  var_2.isdestroyed = 1;
  var_2.health = 0;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  var_2 playSound("mp_killstreak_disappear");

  if(level.gametype != "br" && isDefined(var_2.owner) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](var_2.owner);
  }

  var_0 notify("killstreak_finished_with_deploy_weapon");
  var_2.owner setclientomnvar("ui_rcd_controls", 0);
  var_2.owner cameraunlink(var_2);
  var_2 unlink();
  var_2.owner controlsunlink();
  scripts\cp_mp\utility\killstreak_utility::ref_11dc1(var_2.owner);
  var_2 setscriptablepartstate("flash_light", "default", 0);
  var_2.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0);
  var_2.owner unlink();
  var_2.owner setplayerangles((var_2.owner.restoreangles[0], var_2.owner.restoreangles[1], 0));
  var_2.owner.restoreangles = undefined;
  var_2.owner scripts\common\utility::allow_usability(1);
  var_2 notify("explode");
  scripts\mp\outofbounds::clearoob(self, 1);
  var_2 setscriptablepartstate("flash_light", "default", 0);
  var_3 = level.ref_12a34[var_0.streakname].deployweaponname;
  var_4 = getcompleteweaponname(var_3);

  if(var_2.owner hasweapon(var_4)) {
    var_2.owner scripts\cp_mp\utility\inventory_utility::getridofweapon(var_4);
  }

  thread ref_12a1f();
  var_2.owner setclientomnvar("ui_remote_control_sequence", -1);
}

function ref_12a1f() {
  waitframe();
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function ref_12a2a(var_0) {
  var_1 = self;
  var_1 endon("death_or_disconnect");
  var_1 notify("rcxdWeaponTaken");
  var_1 endon("rcxdWeaponTaken");
  wait 1.5;
  var_2 = level.ref_12a34[var_0.streakname].deployweaponname;
  var_3 = getcompleteweaponname(var_2);
  var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);
  var_4 = var_1 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();
  var_5 = var_1 scripts\mp\utility\inventory::getlastweapon();

  if(!var_1 hasweapon(var_5)) {
    var_5 = var_1 scripts\mp\utility\inventory::getfirstprimaryweapon();
  }

  var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_5);
  var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);

  if(var_1 hasweapon(var_3)) {
    var_1 scripts\cp_mp\utility\inventory_utility::getridofweapon(var_3);
  }

  if(!var_1 scripts\common\utility::is_usability_allowed()) {
    var_1 scripts\common\utility::allow_usability(1);
    return;
  }
}

function ref_12a22(var_0) {
  var_1 = self;
  thread ref_12a21();
  return false;
}

function ref_12a30() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("explode");
  GscBinSkip4(0x6e, var_0, "disconnect");
}

function ref_12a31(var_0) {
  var_1 = self;
  var_2 = var_1.streakinfo;
  var_1.owner waittill(var_0);
  var_1 notify("owner_gone");
  thread ref_12a21(var_1);
}

function ref_12a2f() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 endon("explode");
  var_1 = var_0.streakinfo;

  for(;;) {
    var_0.owner waittill("death");
    var_2 = level.ref_12a34[var_0.vehiclename];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGametypeNumLives")) {
      if(istrue(var_2.diewithowner) || [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]() && var_0.owner.pers["deaths"] == [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]()) {
        thread ref_12a21(var_0);
      }
    }
  }
}

function ref_12a32() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("explode");
  var_0.owner endon("disconnect");
  var_0 endon("owner_gone");
  var_1 = var_0.streakinfo;
  level scripts\engine\utility::ref_143a7("round_end_finished", "game_ended", "prematch_cleanup", "ending_sequence");
  thread ref_12a21(var_0);
}

function ref_12a23() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("explode");
  var_1 = var_0.streakinfo;
  level scripts\engine\utility::ref_143a5("bro_shot_start", "game_ended");
  thread ref_12a21(var_0);
}

function ref_12a2c(var_0) {
  var_1 = self;

  if(!istrue(var_0.leaderinteractionthink)) {
    return;
  }

  var_1.owner notifyonplayercommand("detonate_rcxd", "+usereload");
  var_1.owner notifyonplayercommand("detonate_rcxd", "+activate");
  ref_12a2d(var_1);

  if(isDefined(var_1.owner)) {
    var_1.owner notifyonplayercommandremove("detonate_rcxd", "+usereload");
    var_1.owner notifyonplayercommandremove("detonate_rcxd", "+activate");
    return;
  }
}

function ref_12a2d() {
  var_0 = self;
  var_0.owner endon("disconnect");
  var_0 endon("death");
  var_0 endon("explode");
  var_0 endon("switch_modes");
  var_1 = var_0.streakinfo;
  var_0.owner waittill("detonate_rcxd");
  thread ref_12a24(var_0);
}

function ref_12a2e() {
  var_0 = self;
  var_0.owner endon("disconnect");
  var_0 endon("death");
  var_0 endon("explode");
  var_0 endon("switch_modes");
  var_0.owner notifyonplayercommand("jump_rcxd", "+gostand");

  for(;;) {
    if(!var_0 method_87b5()) {
      var_0.owner waittill("jump_rcxd");
      waitframe();

      if(var_0 method_87b5()) {
        var_0 setscriptablepartstate("jump", "enabled", 0);
        waitframe();
        var_0 setscriptablepartstate("jump", "default", 0);
      }
    }

    waitframe();
  }
}

function ref_12a2b() {
  var_0 = self;
  var_0.owner endon("disconnect");
  var_0 endon("death");
  var_0 endon("explode");
  var_0 endon("switch_modes");

  for(;;) {
    if(var_0 method_87b4()) {
      var_0 setscriptablepartstate("booster_start", "enabled", 0);
      var_0 setscriptablepartstate("booster", "enabled", 0);
      wait 0.2;
      var_0 setscriptablepartstate("booster_start", "default", 0);

      while(var_0 method_87b4()) {
        waitframe();
      }

      var_0 setscriptablepartstate("booster", "default", 0);
    }

    waitframe();
  }
}

function ref_12a24(var_0) {
  var_1 = self;
  thread ref_12a1e();
  var_1.lbravo_spawner_safehouse1 = 1;
  thread ref_12a21(var_1);
}

function ref_12a1e() {
  var_0 = self;
  var_1 = var_0.origin;
  var_2 = var_0.owner;
  var_3 = spawn("trigger_radius", var_1, 0, 256, 512);
  var_0 radiusdamage(var_0.origin, 300, 60, 25, var_2, "MOD_EXPLOSIVE");
  var_3 endon("death");
  var_3.owner = var_2;
  var_3.team = var_2.team;
  var_3.playersintrigger = [];
  var_3 thread scripts\mp\equipment\gas_grenade::gas_watchtriggerenter();
  var_3 thread scripts\mp\equipment\gas_grenade::gas_watchtriggerexit();
  thread watchgastrigger(var_3, var_0.owner);
  var_4 = var_0.origin + (0, 0, -10);
  var_5 = physicstrace(var_0.origin, var_4);
  var_6 = var_5 == var_4;
  var_7 = "detonateGround";

  if(var_6) {
    var_7 = "detonateAir";
  }

  physicsexplosionsphere(var_0.origin, 200, 100, 3);
  scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var_0.origin);
  playFX(scripts\engine\utility::getfx("rcxdExplosion"), var_0.origin);
  var_2 playsoundtoplayer("rcxd_tablet_post_exp_static", var_2);
  wait 20;
  var_3 thread scripts\mp\equipment\gas_grenade::gas_destroytrigger();
}

function watchgastrigger(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }

    if(level.teambased && var_2.team == var_0.team && var_2 != var_0) {
      continue;
    }

    if(istrue(var_2.gettinggassed)) {
      continue;
    }

    thread applygasdamageovertime(var_0, var_2);
  }
}

function applygasdamageovertime(var_0, var_1) {
  var_1 endon("disconnect");
  var_1.gettinggassed = 1;

  while(var_1 istouching(self)) {
    var_1 dodamage(9, self.origin, var_0, self, "MOD_EXPLOSIVE");
    var_2 = scripts\engine\utility::ref_143b9(1, "death");

    if(var_2 == "death") {
      break;
    }
  }

  if(istrue(var_1.gettinggassed)) {
    var_1.gettinggassed = undefined;
    return;
  }
}

function ref_12a29(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_0)) {
    return;
  }

  var_4 = ref_12a26(var_3, var_1, var_2, 7500);
  scripts\mp\gametypes\br_public::brleaderdialog(var_0, 1, var_4);
}

function ref_12a26(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = [];
  var_5 = var_3.owner.team;
  var_6 = level.teamdata[var_5]["players"];
  var_4 = scripts\common\utility::playersnear(var_3.owner.origin, var_2);

  if(istrue(var_0)) {
    var_4 = scripts\engine\utility::array_intersection(var_6, var_4);
  }

  if(istrue(var_1)) {
    var_4 = scripts\engine\utility::array_difference(var_4, var_6);
  }

  return var_4;
}