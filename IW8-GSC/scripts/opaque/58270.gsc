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
  var0 = getarraykeys(level.ref_12a34);

  foreach(var2 in var0) {
    var3 = level.ref_12a34[var2].hitstokill;

    if(isDefined(var3)) {
      scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var2, var3);
      scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle("emp_grenade_mp", var3, var2);
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("rcxd_rad", &ref_12a22);
  game["dialog"]["rcxd_enemy"] = "rcxd_enemy";
  game["dialog"]["rcxd_friendly_use"] = "rcxd_friendly_use";
  level._effect["rcxdExplosion"] = loadfx("vfx/iw8_br/equipment/vfx_rcxd_exp_main");
}

function initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("rcxd_rad", 1);
  var0.frontextents = 15;
  var0.backextents = 15;
  var0.leftextents = 15;
  var0.rightextents = 15;
  var0.bottomextents = 3;
  var0.distancetobottom = 3;
}

function ref_13e2e(var0) {
  var1 = self;
  var2 = ref_13e2f(var1, var0);

  if(!var2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }
  }

  return var2;
}

function ref_13e11() {
  var0 = self;
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("rcxd_rad", var0);
  var1.ref_133ce = 1;
  var2 = ref_13e2f(var0, var1);

  if(!var2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }
  }

  return var2;
}

function ref_13e2f(var0) {
  var1 = self;

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
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
    if(![[level.getflagradarowner]](var1)) {
      return false;
    }
  }

  if(var1 scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    return false;
  }

  var2 = var0.streakname;
  var3 = level.ref_12a34[var2].deployweaponname;
  var4 = var1 scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var0, &ref_14588, undefined, undefined, &deployweapontaken, var3, 0, &ref_14405);
  var1 scripts\common\utility::allow_usability(0);
  var1 thread scripts\cp_mp\utility\killstreak_utility::tabletdofset(0, 1, 1);

  if(!istrue(var4)) {
    ref_12a2a(var1, var0);
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      ref_12a2a(var1, var0);
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      var0 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  var1 scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  var5 = 0.4;
  var6 = var1 scripts\engine\utility::ref_143ba(var5, "death", "weapon_switch_started");

  if(!isDefined(var6) || var6 != "timeout") {
    ref_12a20(var1, var0);
    var1 scripts\cp_mp\utility\player_utility::_freezecontrols(0);
    return false;
  }

  var1 scripts\cp_mp\utility\player_utility::_freezecontrols(0);
  var7 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var1, var0.streakname);
    var7 = 2;
  }

  var1 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var0.streakname, 1, var7);
  var8 = level.ref_12a34[var2].teamsplash;
  var6 = ref_13870(var0);

  if(!istrue(var6)) {
    ref_12a20(var1, var0);
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var8, var1);
  }

  return true;
}

function ref_14405(var0) {
  scripts\cp_mp\killstreaks\killstreakdeploy::waituntilfinishedwithdeployweapon(var0);
  waitframe();
}

function ref_14588(var0) {
  return true;
}

function deployweapontaken(var0) {
  self notify("finished_deploy_weapon");
}

function ref_12e28() {
  var0 = self;
  var0 endon("death_or_disconnect");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var1 = getcompleteweaponname("ks_remote_rcxd_mp");

  if(var0 hasweapon(var1)) {
    var0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var1);
    return;
  }
}

function ref_13870(var0) {
  var1 = self;
  level endon("game_ended");
  var2 = spawnStruct();
  var2.origin = var1.origin + (100, 0, 0);
  var2.angles = var1.angles;
  var2.modelname = "lm_veh_t9_drone_rcxd";
  var2.vehicletype = "veh_rcxd_mp";
  var2.targetname = "veh_rcxd";
  var2.cannotbesuspended = 1;
  var3 = spawnStruct();
  var4 = ref_12a25(var1, 100);

  if(!isDefined(var4)) {
    ref_12a20(var1, var0);
    return false;
  }

  var2.origin = var4;
  var5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var2, var3);

  if(!isDefined(var5)) {
    ref_12a20(var1, var0);
    return false;
  }

  var1.restoreangles = var1 getplayerangles();
  var5 setotherent(var1);
  var5 setentityowner(var1);
  var1 controlslinkTo(var5);
  var1 setclientomnvar("ui_rcd_controls", 9);
  var5 scripts\cp_mp\utility\killstreak_utility::ref_11dc0(var1);
  var5.owner = var1;
  var5.team = var1.team;
  var5.vehiclename = var0.streakname;
  var6 = level.ref_12a34[var0.streakname];
  var5.streakinfo = var0;
  var5.owner.streakinfo = var0;
  var5.maxhealth = var6.maxhealth;
  var5.health = var6.maxhealth;

  if(isDefined(var6.damagemonitorfunc)) {
    var5 thread[[var6.damagemonitorfunc]]();
  }

  thread ref_12a33();
  thread ref_12a30();
  thread ref_12a2f();
  thread ref_12a32();
  thread ref_12a23();
  thread ref_12a2c(var5);
  thread ref_12a2e();
  thread ref_12a2b();
  thread ref_12a28(var5);

  if(scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread ref_12e28();
  }

  var5 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  scripts\mp\outofbounds::registerentforoob(var5, "killstreak");
  ref_12a29(var5, "rcxd_enemy", 0, 1);
  ref_12a29(var5, "rcxd_friendly_use", 1, 0);
  var5 setscriptablepartstate("flash_light", "enabled", 0);
  return true;
}

function ref_12a25(var0) {
  var1 = undefined;
  var2 = self.origin;
  var3 = self.angles;
  var4 = anglesToForward(var3);
  var5 = anglestoright(var3);
  var6 = [var2 + var0 * var4, var2 - var0 * var4, var2 + var0 * var5, var2 - var0 * var5, var2 + 0.707 * var0 * (var4 + var5), var2 + 0.707 * var0 * (var4 - var5), var2 + 0.707 * var0 * (var5 - var4), var2 + 0.707 * var0 * (-1 * var4 - var5)];

  foreach(var8 in var6) {
    var1 = ref_12a1d(var2, var8);

    if(isDefined(var1)) {
      break;
    }
  }

  return var1;
}

function ref_12a1d(var0, var1) {
  var2 = undefined;
  var3 = (0, 0, 45);
  var4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);
  var5 = var0 + var3;
  var6 = var1 + var3;
  var7 = 40;
  var8 = scripts\engine\trace::ray_trace_passed(var5, var6, self, var4);

  if(!istrue(var8)) {
    return var2;
  }

  var9 = scripts\engine\trace::ray_trace(var6, var6 - (0, 0, 500), self, var4);

  if(isDefined(var9["position"]) && var9["hittype"] != "hittype_none") {
    var10 = var9["position"] + var3;
    var11 = scripts\engine\trace::sphere_trace_passed(var10, var10, var7, self, var4);
    var12 = undefined;

    if(level.teambased) {
      var12 = self.team;
    }

    if(istrue(var11) && !scripts\mp\outofbounds::ispointinoutofbounds(var9["position"], var12)) {
      var2 = var9["position"];
    }
  }

  var13 = var2;
  var14 = 14.75;

  if(isDefined(var2)) {
    var15 = 1;
    var16 = [(var14, var14, 0), (-1 * var14, var14, 0), (var14, -1 * var14, 0), (-1 * var14, -1 * var14, 0)];

    foreach(var18 in var16) {
      var19 = var13 + var18;
      var9 = scripts\engine\trace::ray_trace(var13, var19, self, var4);

      if(isDefined(var9["position"]) && var9["hittype"] != "hittype_none") {
        var20 = scripts\mp\outofbounds::ispointinoutofbounds(var9["position"], self.team);

        if(!istrue(var20)) {
          return undefined;
        }

        break;
      }
    }
  }

  return var13;
}

function ref_12a20(var0) {
  var1 = self;
  ref_12a2a(var1, var0);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var0 notify("killstreak_finished_with_deploy_weapon");

  if(!var1 scripts\common\utility::is_usability_allowed()) {
    var1 scripts\common\utility::allow_usability(1);
    return;
  }
}

function ref_12a28(var0) {
  var1 = self;
  var1.owner endon("disconnect");
  var1 endon("death");
  var1 endon("leaving");
  var1 endon("explode");
  var1 endon("switch_modes");
  var1 vehphys_enablecollisioncallback(1);
  var2 = var1.streakinfo;

  for(;;) {
    var1 waittill("collision", var3, var4, var5, var6, var7, var8, var9, var10, var11);

    if(!isDefined(var10)) {
      continue;
    }

    var12 = undefined;

    if(var10 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var12 = var10;
    } else if(var10 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      var12 = var10.vehicle;
    } else if(istrue(var10.velstartid)) {
      var12 = var10;
    }

    if(!isDefined(var12)) {
      continue;
    }

    var13 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var1.owner, var12.owner));

    if(istrue(var0.leaderplunderstring)) {
      if(var13 || !isDefined(var12.owner)) {
        thread ref_12a24(var1);
      } else {
        var1 dodamage(var1.maxhealth, var12.origin, undefined, undefined, "MOD_CRUSH");
      }

      continue;
    }

    var14 = undefined;
    var15 = undefined;

    if(var13) {
      var16 = var12.owner scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var16) && var16 == var12) {
        var14 = var12.owner;
        var15 = var12;
      }
    }

    var17 = var1.maxhealth * var0.initbunker;
    var1 dodamage(var17, var12.origin, var14, var15, "MOD_CRUSH");
  }
}

function ref_12a33() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("explode");
  var0.owner endon("disconnect");
  var0 endon("owner_gone");
  var1 = level.ref_12a34[var0.vehiclename];
  var0.timeout = var1.timeout;

  if(!isDefined(var0.timeout)) {
    return;
  }

  var3 = var0.streakinfo;

  if(var0.timeout > 0) {
    var0.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(var0.timeout * 1000));
    wait var0.timeout;
  }

  var0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var1.votimedout, 1);
  thread ref_12a21(var0);
}

function ref_12a21(var0) {
  var1 = 1;
  var2 = self;

  if(!isDefined(var0)) {
    var0 = var2.streakinfo;
  }

  if(!istrue(var2.lbravo_spawner_safehouse1)) {
    thread ref_12a1e();
    var2.lbravo_spawner_safehouse1 = 1;
  }

  var2 vehphys_enablecollisioncallback(0);

  if(!isDefined(var0)) {
    var0 = var2.streakinfo;
  }

  if(isDefined(var2.owner)) {
    if(!isDefined(var0)) {
      var0 = var2.owner.streakinfo;
    }

    var2.owner.streakinfo = undefined;
  }

  if(!isDefined(var2) || istrue(var2.isdestroyed)) {
    if(isDefined(var0)) {
      var0 notify("killstreak_finished_with_deploy_weapon");
    }

    return;
  }

  var2.isdestroyed = 1;
  var2.health = 0;
  var2 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  var2 playSound("mp_killstreak_disappear");

  if(level.gametype != "br" && isDefined(var2.owner) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](var2.owner);
  }

  var0 notify("killstreak_finished_with_deploy_weapon");
  var2.owner setclientomnvar("ui_rcd_controls", 0);
  var2.owner cameraunlink(var2);
  var2 unlink();
  var2.owner controlsunlink();
  scripts\cp_mp\utility\killstreak_utility::ref_11dc1(var2.owner);
  var2 setscriptablepartstate("flash_light", "default", 0);
  var2.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0);
  var2.owner unlink();
  var2.owner setplayerangles((var2.owner.restoreangles[0], var2.owner.restoreangles[1], 0));
  var2.owner.restoreangles = undefined;
  var2.owner scripts\common\utility::allow_usability(1);
  var2 notify("explode");
  scripts\mp\outofbounds::clearoob(self, 1);
  var2 setscriptablepartstate("flash_light", "default", 0);
  var3 = level.ref_12a34[var0.streakname].deployweaponname;
  var4 = getcompleteweaponname(var3);

  if(var2.owner hasweapon(var4)) {
    var2.owner scripts\cp_mp\utility\inventory_utility::getridofweapon(var4);
  }

  thread ref_12a1f();
  var2.owner setclientomnvar("ui_remote_control_sequence", -1);
}

function ref_12a1f() {
  waitframe();
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function ref_12a2a(var0) {
  var1 = self;
  var1 endon("death_or_disconnect");
  var1 notify("rcxdWeaponTaken");
  var1 endon("rcxdWeaponTaken");
  wait 1.5;
  var2 = level.ref_12a34[var0.streakname].deployweaponname;
  var3 = getcompleteweaponname(var2);
  var1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var3);
  var4 = var1 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();
  var5 = var1 scripts\mp\utility\inventory::getlastweapon();

  if(!var1 hasweapon(var5)) {
    var5 = var1 scripts\mp\utility\inventory::getfirstprimaryweapon();
  }

  var1 scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var5);
  var1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var3);

  if(var1 hasweapon(var3)) {
    var1 scripts\cp_mp\utility\inventory_utility::getridofweapon(var3);
  }

  if(!var1 scripts\common\utility::is_usability_allowed()) {
    var1 scripts\common\utility::allow_usability(1);
    return;
  }
}

function ref_12a22(var0) {
  var1 = self;
  thread ref_12a21();
  return false;
}

function ref_12a30() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("explode");
  GscBinSkip4(0x6e, var0, "disconnect");
}

function ref_12a31(var0) {
  var1 = self;
  var2 = var1.streakinfo;
  var1.owner waittill(var0);
  var1 notify("owner_gone");
  thread ref_12a21(var1);
}

function ref_12a2f() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("leaving");
  var0 endon("explode");
  var1 = var0.streakinfo;

  for(;;) {
    var0.owner waittill("death");
    var2 = level.ref_12a34[var0.vehiclename];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGametypeNumLives")) {
      if(istrue(var2.diewithowner) || [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]() && var0.owner.pers["deaths"] == [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]()) {
        thread ref_12a21(var0);
      }
    }
  }
}

function ref_12a32() {
  var0 = self;
  var0 endon("death");
  var0 endon("explode");
  var0.owner endon("disconnect");
  var0 endon("owner_gone");
  var1 = var0.streakinfo;
  level scripts\engine\utility::ref_143a7("round_end_finished", "game_ended", "prematch_cleanup", "ending_sequence");
  thread ref_12a21(var0);
}

function ref_12a23() {
  var0 = self;
  var0 endon("death");
  var0 endon("explode");
  var1 = var0.streakinfo;
  level scripts\engine\utility::ref_143a5("bro_shot_start", "game_ended");
  thread ref_12a21(var0);
}

function ref_12a2c(var0) {
  var1 = self;

  if(!istrue(var0.leaderinteractionthink)) {
    return;
  }

  var1.owner notifyonplayercommand("detonate_rcxd", "+usereload");
  var1.owner notifyonplayercommand("detonate_rcxd", "+activate");
  ref_12a2d(var1);

  if(isDefined(var1.owner)) {
    var1.owner notifyonplayercommandremove("detonate_rcxd", "+usereload");
    var1.owner notifyonplayercommandremove("detonate_rcxd", "+activate");
    return;
  }
}

function ref_12a2d() {
  var0 = self;
  var0.owner endon("disconnect");
  var0 endon("death");
  var0 endon("explode");
  var0 endon("switch_modes");
  var1 = var0.streakinfo;
  var0.owner waittill("detonate_rcxd");
  thread ref_12a24(var0);
}

function ref_12a2e() {
  var0 = self;
  var0.owner endon("disconnect");
  var0 endon("death");
  var0 endon("explode");
  var0 endon("switch_modes");
  var0.owner notifyonplayercommand("jump_rcxd", "+gostand");

  for(;;) {
    if(!var0 method_87b5()) {
      var0.owner waittill("jump_rcxd");
      waitframe();

      if(var0 method_87b5()) {
        var0 setscriptablepartstate("jump", "enabled", 0);
        waitframe();
        var0 setscriptablepartstate("jump", "default", 0);
      }
    }

    waitframe();
  }
}

function ref_12a2b() {
  var0 = self;
  var0.owner endon("disconnect");
  var0 endon("death");
  var0 endon("explode");
  var0 endon("switch_modes");

  for(;;) {
    if(var0 method_87b4()) {
      var0 setscriptablepartstate("booster_start", "enabled", 0);
      var0 setscriptablepartstate("booster", "enabled", 0);
      wait 0.2;
      var0 setscriptablepartstate("booster_start", "default", 0);

      while(var0 method_87b4()) {
        waitframe();
      }

      var0 setscriptablepartstate("booster", "default", 0);
    }

    waitframe();
  }
}

function ref_12a24(var0) {
  var1 = self;
  thread ref_12a1e();
  var1.lbravo_spawner_safehouse1 = 1;
  thread ref_12a21(var1);
}

function ref_12a1e() {
  var0 = self;
  var1 = var0.origin;
  var2 = var0.owner;
  var3 = spawn("trigger_radius", var1, 0, 256, 512);
  var0 radiusdamage(var0.origin, 300, 60, 25, var2, "MOD_EXPLOSIVE");
  var3 endon("death");
  var3.owner = var2;
  var3.team = var2.team;
  var3.playersintrigger = [];
  var3 thread scripts\mp\equipment\gas_grenade::gas_watchtriggerenter();
  var3 thread scripts\mp\equipment\gas_grenade::gas_watchtriggerexit();
  thread watchgastrigger(var3, var0.owner);
  var4 = var0.origin + (0, 0, -10);
  var5 = physicstrace(var0.origin, var4);
  var6 = var5 == var4;
  var7 = "detonateGround";

  if(var6) {
    var7 = "detonateAir";
  }

  physicsexplosionsphere(var0.origin, 200, 100, 3);
  scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var0.origin);
  playFX(scripts\engine\utility::getfx("rcxdExplosion"), var0.origin);
  var2 playsoundtoplayer("rcxd_tablet_post_exp_static", var2);
  wait 20;
  var3 thread scripts\mp\equipment\gas_grenade::gas_destroytrigger();
}

function watchgastrigger(var0, var1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var2);

    if(!isPlayer(var2)) {
      continue;
    }

    if(level.teambased && var2.team == var0.team && var2 != var0) {
      continue;
    }

    if(istrue(var2.gettinggassed)) {
      continue;
    }

    thread applygasdamageovertime(var0, var2);
  }
}

function applygasdamageovertime(var0, var1) {
  var1 endon("disconnect");
  var1.gettinggassed = 1;

  while(var1 istouching(self)) {
    var1 dodamage(9, self.origin, var0, self, "MOD_EXPLOSIVE");
    var2 = scripts\engine\utility::ref_143b9(1, "death");

    if(var2 == "death") {
      break;
    }
  }

  if(istrue(var1.gettinggassed)) {
    var1.gettinggassed = undefined;
    return;
  }
}

function ref_12a29(var0, var1, var2) {
  var3 = self;

  if(!isDefined(var0)) {
    return;
  }

  var4 = ref_12a26(var3, var1, var2, 7500);
  scripts\mp\gametypes\br_public::brleaderdialog(var0, 1, var4);
}

function ref_12a26(var0, var1, var2) {
  var3 = self;
  var4 = [];
  var5 = var3.owner.team;
  var6 = level.teamdata[var5]["players"];
  var4 = scripts\common\utility::playersnear(var3.owner.origin, var2);

  if(istrue(var0)) {
    var4 = scripts\engine\utility::array_intersection(var6, var4);
  }

  if(istrue(var1)) {
    var4 = scripts\engine\utility::array_difference(var4, var6);
  }

  return var4;
}