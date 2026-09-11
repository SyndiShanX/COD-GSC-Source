/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\cruise_predator.gsc
*********************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "init")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "registerVO")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "registerVO")]]();
  }

  level._effect["predator_pod_break"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion.vfx");
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("cruise_predator", "invisible", 7);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("cruise_predator", "on", 8);
}

function weapongivencruisepredator(var0) {
  return true;
}

function tryusecruisepredator() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("cruise_predator", self);
  return tryusecruisepredatorfromstruct(var0);
}

function tryusecruisepredatorfromstruct(var0) {
  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var0, &weapongivencruisepredator);

  if(!istrue(var1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      var0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(level.gameended) {
    var0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  var2 = getdvarint("scr_cruise_3rd", 0);
  var3 = runcruisepredator(var0.streakname, var0, var2);

  if(!istrue(var3)) {
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_cruise_predator", self);
  }

  return true;
}

function runcruisepredator(var0, var1, var2) {
  self disablephysicaldepthoffieldscripting();
  var3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var4 = 10000;

  if(isDefined(var3)) {
    var4 = var3.origin[2] + 6000;
  }

  var5 = level.mapcenter;

  if(scripts\cp_mp\utility\game_utility::islargemap() || scripts\common\utility::iscp() || scripts\cp_mp\utility\game_utility::unload_after_timeout()) {
    var5 = self.origin;
  }

  var6 = [];
  var7 = (0, 0, 0);
  var8 = undefined;
  var9 = level.players;

  if(scripts\common\utility::iscp()) {
    var9 = level.characters;
  }

  foreach(var11 in var9) {
    if(var11 == self) {
      continue;
    }

    if(level.teambased && var11.team == self.team) {
      continue;
    }

    var7 += var11.origin - var5;
    var6 = var11;
  }

  if(isDefined(var7) && var6.size > 0) {
    var8 = vectorNormalize(var7 / var6.size);
    var8 *= (1, 1, 0);
  } else {
    var13 = randomint(360);
    var8 = anglesToForward((0, var13, 0));
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "directionOverride")) {
    var8 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "directionOverride")]](var8);
  }

  var14 = var5 + (0, 0, var4);
  var15 = var14 + var8 * -3000;
  var16 = var14;
  var17 = spawn("script_model", var15);
  var17 setModel("wmd_vm_missile_cruise");
  var17.owner = self;
  var17.origin = var15;
  var17.angles = vectortoangles(var16 - var15);
  var17.type = "remote";
  var17.team = self.team;
  var17.entitynumber = var17 getentitynumber();
  var17.streakinfo = var1;
  var17.duration = 30;
  self.restoreangles = self.angles;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var0, var17.origin);
  }

  level.rockets[var17.entitynumber] = var17;
  level.remotemissileinprogress = 1;
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var0, 1);
  var18 = cruisepredator_followmissilepod(var17, var16, var2, var1);
  return var18;
}

function initbrc130airdropdropanims(var0, var1, var2) {
  self endon("death");
  level endon("game_ended");
  self waittill("disowned");

  if(isDefined(self)) {
    initbattleroyalejuggernautcratedata(var0, var1, var2);
    self delete();
    return;
  }
}

function initbattleroyalejuggernautcratedata(var0, var1, var2) {
  var3 = self.owner;

  if(isDefined(var3)) {
    var3 disablephysicaldepthoffieldscripting();
    var3 unlink();
    var3 scripts\common\utility::allow_fire(1);
    var3 scripts\common\utility::allow_melee(1);
    var3 scripts\common\utility::allow_weapon_switch(1);
    var3 scripts\common\utility::allow_usability(1);
    var3 scripts\common\utility::allow_shellshock(1);
    var3 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var0.streakname, "off");
    var3 setclientomnvar("ui_predator_missile", 0);
    var3 painvisionon();
    var3 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var3 visionsetkillstreakforplayer("");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var3, 0, 0);
  }

  var0 notify("killstreak_finished_with_deploy_weapon");

  if(isDefined(var1)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var1);
  }

  if(isDefined(var2)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var2);
    return;
  }
}

#using_animtree("");

function cruisepredator_followmissilepod(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "wingtrails");
  var5 = scripts\engine\utility::get_notetrack_time($mp_cruise_missile_move_intro, "shell_break");
  var6 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "second_missile_thruster");
  var7 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "anim_end");
  var8 = var4;
  var9 = var5 - var4;
  var10 = var6 - var5;
  var11 = var7 - var6;
  var12 = undefined;
  var13 = undefined;

  if(!istrue(var2)) {
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_usability(0);
    scripts\common\utility::allow_shellshock(0);
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var3.streakname, "invisible");
    self setclientomnvar("ui_predator_missile", 1);
    var14 = [];
    var15 = [];
    var16 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "assignTargetMarkers")) {
      var16 = self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "assignTargetMarkers")]](self);
    }

    if(isDefined(var16.enemytargetmarkergroup)) {
      var14 = var16.enemytargetmarkergroup;
    }

    if(isDefined(var16.friendlytargetmarkergroup)) {
      var15 = var16.friendlytargetmarkergroup;
    }

    var12 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self, var14, self, 0, 1, 1);
    var13 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self, var15, self, 1, 1);
    self playerlinkweaponviewtodelta(var0, "tag_player", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
    thread cruisepredator_playdofsequence();
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    thread initbrc130airdropdropanims(var0, var3, var12);
    thread initbrmechanics(var0);
    thread initbrmechanics(var0);
    thread initbrmechanics(var0);
  }

  var17 = "mp_cruise_missile_move_intro";
  var18 = getdvarint("scr_cruise_intro_anim", 0);

  if(var18 == 1) {
    var17 = "mp_cruise_missile_move_angle_intro";
  }

  var0 scriptmodelplayanimdeltamotion(var17);
  var0 setscriptablepartstate("main_thruster", "on", 0);
  var0 setscriptablepartstate("clouds", "on", 0);

  if(!istrue(var2)) {
    var0 playsoundtoplayer("iw8_cruise_missile_plr_intro", self);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var8);

  if(!isDefined(var0)) {
    return false;
  }

  var0 setscriptablepartstate("wing_trails", "on");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var9);

  if(!isDefined(var0)) {
    return false;
  }

  var0 setscriptablepartstate("wing_trails", "off");
  var0 setscriptablepartstate("main_thruster", "off", 0);
  playFXOnTag(scripts\engine\utility::getfx("predator_pod_break"), var0, "tag_missile");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var10);

  if(!isDefined(var0)) {
    return false;
  }

  var0 setscriptablepartstate("sub_thruster", "on", 0);

  if(!isDefined(var0) || !isDefined(self)) {
    return false;
  }

  thread cruisepredator_delayplayslamzoom(var11 - 0.15, var2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var11 - 0.05);

  if(!isDefined(var0) || !isDefined(self)) {
    return false;
  }

  thread cruisepredator_takecontrol(var0, var3, var2, var12, var13);
  return true;
}

function cruisepredator_playdofsequence() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.owner enablephysicaldepthoffieldscripting();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self.owner setphysicaldepthoffield(0.2, 300, 20, 10);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self.owner setphysicaldepthoffield(5.6, 5000, 3, 10);
}

function cruisepredator_takecontrol(var0, var1, var2, var3, var4) {
  var0 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var0 setscriptablepartstate("clouds", "off", 0);
  var0 setscriptablepartstate("sub_thruster", "off", 0);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var5 = spawnStruct();
  var5.origin = var0 gettagorigin("tag_missile");
  var5.angles = var0 gettagangles("tag_missile");
  var5.modelname = "wmd_vm_missile_cruise_warhead";
  var5.vehicletype = "veh_cruise_predator_mp";
  var5.targetname = "rcplane";
  var5.cannotbesuspended = 1;
  var6 = spawnStruct();
  var7 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var5, var6);

  if(!isDefined(var7)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var7[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var1.streakname);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var7);
  var1.shots_fired++;
  var7 setCanDamage(0);
  var7 setotherent(self);
  var7 setentityowner(self);
  var7.angles = var0 gettagangles("tag_missile");
  var7.team = self.team;
  var7.owner = self;
  var7.streakinfo = var1;
  var7.lifetime = 10;
  var7 setscriptablepartstate("warhead_thruster", "on", 0);
  var7 setvehicleteam(var7.team);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var7[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var1.streakname, "Killstreak_Air", self, 0, 1, 50);
  }

  var7.killcament = spawn("script_model", var7 gettagorigin("tag_player"));
  var7.killcament setModel("tag_origin");
  var7.killcament linkTo(var7, "tag_player");
  var7 endon("death");
  var7 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&cruisepredator_empapplied);
  var8 = spawn("script_model", var7 gettagorigin("tag_fx"));
  var8 setModel("ks_cruise_predator_mp");
  var8.angles = var7 gettagangles("tag_fx");
  var8.team = var7.team;
  var8.owner = var7.owner;
  var8.streakinfo = var7.streakinfo;
  var8 linkTo(var7, "tag_fx");
  var8 setscriptablepartstate("fake_trail", "on", 0);
  var8 setotherent(self);
  thread initbattleroyalelootchoppercratedata(var8);
  thread cruisepredator_watchmissileinfo(var8);
  thread cruisepredator_watchmissileexplosion(var8, var7, self, var7.killcament, var2, var3);
  thread initbrmechanics(var7);
  thread initbrmechanics(var7);
  thread initbrmechanics(var7);

  if(!istrue(var2)) {
    self visionsetkillstreakforplayer("", 0.1);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(!istrue(var2)) {
    self disablephysicaldepthoffieldscripting();
    self unlink();
    self cameralinkTo(var7, "tag_player", 1);
    self controlslinkTo(var7);
    self visionsetkillstreakforplayer("cruise_color");
    self.soundent = spawn("script_origin", var7.origin);
    self.soundent showonlytoplayer(self);
    self.soundent playLoopSound("iw8_cruise_missile_plr");
    scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", var7.lifetime, 0);
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var1.streakname, "on");
    self setclientomnvar("ui_predator_missile", 2);
    self setclientomnvar("ui_killstreak_health", 1);
    self setclientomnvar("ui_killstreak_countdown", gettime() + int(10000));
    self setclientomnvar("ui_predator_missiles_left", -1);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      self visionsetthermalforplayer("flir_0_black_to_white");
      scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1500);
      scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", var7.lifetime, 0);
    }
  }

  thread cruisepredator_delaymissilecollision();
  var9 = randomintrange(1, 3);
  var7 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("cruise_control_" + var9);
  thread cruisepredator_watchtimer(var7);
  waitframe();

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function cruisepredator_watchkillborder() {
  if(!isDefined(level.kill_border_triggers)) {
    return;
  }

  self endon("death");
  self endon("explode");
  self endon("collision");
  self endon("emp_defused");
  self endon("trophy_blocked");

  for(;;) {
    if(cruisepredator_istouchingkillborder(level.kill_border_triggers)) {
      self notify("explode");
      break;
    }

    waitframe();
  }
}

function cruisepredator_istouchingkillborder(var0) {
  var1 = 0;

  foreach(var3 in var0) {
    if(self istouching(var3)) {
      var1 = 1;
      break;
    }
  }

  return var1;
}

function cruisepredator_delaymissilecollision() {
  self endon("explode");
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
  self vehphys_enablecollisioncallback(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.25);
  thread cruisepredator_watchkillborder();
}

function initbattleroyalelootchoppercratedata(var0) {
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("cruise_missile_finished");
  level waittill("game_ended");
  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0);
}

function cruisepredator_watchmissileinfo(var0) {
  self endon("death");

  for(;;) {
    self.missilelastpos = var0.origin;
    self.missilelastangle = var0.angles;
    waitframe();
  }
}

function cruisepredator_watchmissileexplosion(var0, var1, var2, var3, var4, var5) {
  var6 = var2;
  var7 = undefined;
  var8 = undefined;
  var9 = var0.streakinfo;
  var10 = cruisepredator_waittillexplode(var0, "collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked");

  if(isDefined(var4)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var4);
  }

  if(isDefined(var5)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var5);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "CPUnMarkEnemies")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "CPUnMarkEnemies")]](var1);
  }

  if(isDefined(self)) {
    var7 = self.missilelastpos;
    var8 = self.missilelastangle;

    if(isDefined(var1)) {
      var1 cameraunlink();
      var1 controlsunlink();
    }

    if(isDefined(var0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var0);
      scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var0);
    }

    if(!isDefined(var10) || var10.msg != "emp_defused" && var10.msg != "trophy_blocked") {
      var11 = 600;
      var12 = "MOD_EXPLOSIVE";
      var13 = "cruise_proj_mp";

      if(isDefined(var1)) {
        var14 = isDefined(var10) && var10.msg == "disowned";

        if(!istrue(var14)) {
          self radiusdamage(var7, var11, 1000, 1000, var1, var12, var13);
        }

        var15 = scripts\common\utility::playersinsphere(var7, var11);

        foreach(var17 in var15) {
          if(var17 scripts\cp_mp\utility\player_utility::_isalive() && scripts\cp_mp\utility\player_utility::playersareenemies(var17, var1)) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
              level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](var17, "flavor_closecall", undefined, 1);
            }
          }
        }
      }
    }

    scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var7, 1, 1, 1000);
    thread cruisepredator_handlevfxstates(var10);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "eventRecord")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "eventRecord")]](var7);
  }

  if(isDefined(var1)) {
    thread cruisepredator_watchkills(var1);

    if(!istrue(var3)) {
      if(isDefined(var1.soundent)) {
        var1.soundent stoploopsound("iw8_cruise_missile_plr");
        var1.soundent delete();
      }

      var1 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var9.streakname, "off");
      var1 setclientomnvar("ui_predator_missile", 0);
      var19 = 1;
      var20 = spawn("script_model", var7);
      var20 setModel("tag_player");
      var21 = getdvarint("scr_cruise_detach_dist", 1000);
      var22 = getdvarint("scr_cruise_detach_height", 0);
      var23 = anglesToForward(var8);
      var24 = var7 - var23 * var21;
      var25 = (0, 0, var22);
      var26 = var24 + var25;
      var20.angles = vectortoangles(var7 + (0, 0, 150) - var26);
      var6 unlink();
      var6 linkTo(var20, "tag_player", (0, 0, 0), (0, 0, 0));

      if(scripts\cp_mp\utility\game_utility::isnightmap()) {
        var1 scripts\cp_mp\utility\player_utility::setthermalvision(0);
      }

      var20.origin = var26;
      var1 cameralinkTo(var20, "tag_origin");
      var27 = "cruise_predator_static";

      if(var19 == 2) {
        var27 = "cruise_predator_flash";
      }

      thread cruisepredator_startfadecamtransition(var1, 0.4, 0.6, 0.05);
      var28 = scripts\common\utility::playersinsphere(var7, 2000);

      foreach(var17 in var28) {
        var17 earthquakeforplayer(0.3, 2, var17.origin, 100);
        var17 setclientomnvar("ui_hud_shake", 1);
        var17 playrumbleonpositionforclient("artillery_rumble", var17.origin);
        LOC_00000385:
      }

      var1 earthquakeforplayer(0.3, 3, var1.origin, 100);
      var1 setclientomnvar("ui_hud_shake", 1);
      var1 playrumbleonpositionforclient("artillery_rumble", var1.origin);
      wait 0.5;
      var1 notify("cruise_missile_finished");
      cruisepredator_returnplayer(var1, var9, var20);
      var1 scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var9);
    }
  }

  if(isDefined(var6)) {
    var6 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "removeItemFromSlot")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "removeItemFromSlot")]](var1);
    return;
  }
}

function cruisepredator_cameramove(var0, var1) {
  self moveTo(var0, 0.2, 0, 0.05);
  wait 0.15;
  self moveTo(var0 + vectorNormalize(var1 - var0) * 24, 2);
}

function cruisepredator_returnplayer(var0, var1) {
  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var0);
  }

  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  self cameraunlink();
  var1 delete();
  self visionsetkillstreakforplayer("");
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_usability(1);
  scripts\common\utility::allow_shellshock(1);
  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  level thread scripts\cp_mp\utility\killstreak_utility::ref_12cc6(self);
  var0 notify("killstreak_finished_with_deploy_weapon");
}

function cruisepredator_watchtimer(var0) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10.1);
  self notify("explode", self.origin);
}

function cruisepredator_watchexplosiondistance(var0, var1) {
  self endon("death");
  var0 endon("disconnect");
  level endon("game_ended");
  var2 = [self, var1];
  var3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0);

  for(;;) {
    var4 = anglesToForward(self.angles);
    var5 = self gettagorigin("tag_missile");
    var0.lastknownmissilepos = var5;
    var0.lastknownmissileangles = self.angles;
    var6 = getdvarint("scr_cruise_impact_dist", 50);

    if(isDefined(self.missilebooston)) {
      var6 = getdvarint("scr_cruise_impact_boost_dist", 150);
    }

    var7 = var5 + var4 * var6;
    var8 = scripts\engine\trace::sphere_trace(var5, var7, 5, var2, var3);

    if(isDefined(var8["hittype"]) && var8["hittype"] != "hittype_none") {
      if(isDefined(var8["position"])) {
        var0.lastknowntrace = var8;
        self notify("missile_close_explode", var8["position"]);
        break;
      }
    }

    wait 0.05;
  }
}

function cruisepredator_watchmissileboost(var0) {
  var0 endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var0 notifyonplayercommand("missile_boost_on", "+attack");

  for(;;) {
    var0 waittill("missile_boost_on");
    self.missilebooston = 1;
    break;
  }
}

function initbrmechanics(var0) {
  self endon("death");
  self endon("disowned");
  level endon("game_ended");
  var1 = self.owner;
  var1 waittill(var0);
  self notify("disowned");
}

function cruisepredator_startexplodecamtransition() {
  self visionsetkillstreakforplayer("cruise_predator_slamzoom", 0.05);
  wait 0.1;
  self visionsetkillstreakforplayer("", 0.05);
}

function cruisepredator_startfadecamtransition(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = 0.5;
  }

  if(!isDefined(var1)) {
    var1 = 0.5;
  }

  if(!isDefined(var2)) {
    var2 = 0.05;
  }

  if(isDefined(var3)) {
    self visionsetkillstreakforplayer(var3, var0);
    wait var1;
    self visionsetkillstreakforplayer("", var2);
    return;
  }

  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, var0);
  wait var1;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, var2);
}

function cruisepredator_shakerider(var0) {
  self endon("disconnect");
  var1 = 0;

  while(var1 < var0) {
    self playrumbleonpositionforclient("damage_light", self.origin);
    var1 += 0.05;
    wait 0.05;
  }
}

function cruisepredator_waittillexplode(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  var6 = spawnStruct();

  if(isDefined(var0)) {
    thread waittill_explodestring(var0, var6);
  }

  if(isDefined(var1)) {
    thread waittill_explodestring(var1, var6);
  }

  if(isDefined(var2)) {
    thread waittill_explodestring(var2, var6);
  }

  if(isDefined(var3)) {
    thread waittill_explodestring(var3, var6);
  }

  if(isDefined(var4)) {
    thread waittill_explodestring(var4, var6);
  }

  jumpiffalse(isDefined(var5)) LOC_00000064;
  thread waittill_explodestring(var5, var6);
  var6 waittill("returned", var7, var8, var9, var10, var11, var12, var13, var14, var15);
  var6 notify("die");
  self.owner notify("cruise_missile_explode");
  var16 = spawnStruct();
  var16.msg = var7;
  var16.param1 = var8;
  var16.param2 = var9;
  var16.param3 = var10;
  var16.param4 = var11;
  var16.param5 = var12;
  var16.param6 = var13;
  var16.param7 = var14;
  var16.param8 = var15;
  return var16;
}

function waittill_explodestring(var0, var1) {
  self endon("death");
  var1 endon("die");
  self waittill(var0, var2, var3, var4, var5, var6, var7);
  var1 notify("returned", var0, var2, var3, var4, var5, var6, var7);
}

function cruisepredator_handlevfxstates(var0) {
  self endon("death");
  self unlink();

  if(!isDefined(var0) || var0.msg == "explode" || var0.msg == "disowned" || var0.msg == "emp_defused" || var0.msg == "trophy_blocked") {
    self setscriptablepartstate("air_explosion", "on", 0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.2);
    self delete();
  }

  var1 = (0, 0, 1);
  var2 = var0.param6;
  self.angles = vectortoangles(var2);
  var3 = vectordot(var2, var1);

  if(var3 >= 0.7) {
    self setscriptablepartstate("ground_explosion", "on", 0);
  } else {
    self setscriptablepartstate("air_explosion", "on", 0);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self delete();
}

function cruisepredator_watchkills(var0) {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(isDefined(self) && isDefined(self.recentkillcount)) {
    if(self.recentkillcount >= 1) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("cruise_kill", 1);
      return;
    }

    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("cruise_miss", 1);
    return;
  }
}

function cruisepredator_delayplayslamzoom(var0, var1) {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);

  if(!istrue(var1)) {
    self visionsetkillstreakforplayer("cruise_predator_slamzoom", 0.1);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.2);
    wait 0.2;
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0);
    return;
  }
}

function cruisepredator_empapplied(var0) {
  if(isDefined(self)) {
    self notify("emp_defused");
    return;
  }
}