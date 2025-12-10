/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3454.gsc
***************************************/

init() {
  var_00 = spawnStruct();
  var_0.func_B923 = [];
  var_0.func_B923["allies"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_0.func_B923["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_0.vehicle = "a10_warthog_mp";
  var_0.inboundsfx = "veh_mig29_dist_loop";
  var_0.speed = 3000;
  var_0.halfdistance = 12500;
  var_0.heightrange = 750;
  var_0.choosedirection = 1;
  var_0.selectlocationvo = "KS_hqr_airstrike";
  var_0.inboundvo = "KS_ast_inbound";
  var_0.cannonfirevfx = loadfx("vfx\core\smktrail\smoke_trail_white_heli");
  var_0.cannonrumble = "ac130_25mm_fire";
  var_0.turretname = "a10_30mm_turret_mp";
  var_0.turretattachpoint = "tag_barrel";
  var_0.rocketmodelname = "maverick_projectile_mp";
  var_0.numrockets = 4;
  var_0.delaybetweenrockets = 0.125;
  var_0.delaybetweenlockon = 0.4;
  var_0.lockonicon = "veh_hud_target_chopperfly";
  var_0.maxhealth = 1000;
  var_0.scorepopup = "destroyed_a10_strafe";
  var_0.callout = "callout_destroyed_a10";
  var_0.vodestroyed = undefined;
  var_0.explodevfx = loadfx("vfx\core\expl\aerial_explosion");
  var_0.sfxcannonfireloop_1p = "veh_a10_plr_fire_gatling_lp";
  var_0.sfxcannonfirestop_1p = "veh_a10_plr_fire_gatling_cooldown";
  var_0.sfxcannonfireloop_3p = "veh_a10_npc_fire_gatling_lp";
  var_0.sfxcannonfirestop_3p = "veh_a10_npc_fire_gatling_cooldown";
  var_0.sfxcannonfireburptime = 500;
  var_0.sfxcannonfireburpshort_3p = "veh_a10_npc_fire_gatling_short_burst";
  var_0.sfxcannonfireburplong_3p = "veh_a10_npc_fire_gatling_long_burst";
  var_0.sfxcannonbulletimpact = "veh_a10_bullet_impact_lp";
  var_0.sfxmissilefire_1p = [];
  var_0.sfxmissilefire_1p[0] = "veh_a10_plr_missile_ignition_left";
  var_0.sfxmissilefire_1p[1] = "veh_a10_plr_missile_ignition_right";
  var_0.sfxmissilefire_3p = "veh_a10_npc_missile_fire";
  var_0.sfxmissile = "veh_a10_missile_loop";
  var_0.sfxengine_1p = "veh_a10_plr_engine_lp";
  var_0.sfxengine_3p = "veh_a10_dist_loop";
  level.planeconfigs["a10_strafe"] = var_00;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("a10_strafe", ::onuse);
  buildallflightpathsdefault();
}

onuse(var_00, var_01) {
  if(isDefined(level.a10strafeactive)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\game::isusingremote() || scripts\mp\utility\game::iskillstreakdenied())
    return 0;
  else if(getcsplinecount() < 2)
    return 0;
  else {
    thread dostrike(var_00, "a10_strafe");
    return 1;
  }
}

dostrike(var_00, var_01) {
  self endon("end_remote");
  self endon("death");
  level endon("game_ended");
  var_02 = getpathindex();
  var_03 = startstrafesequence(var_01, var_00);

  if(var_03) {
    var_04 = spawnaircraft(var_01, var_00, level.a10splinesin[var_02]);

    if(isDefined(var_04)) {
      var_04 dooneflyby();
      switchaircraft(var_04, var_01);
      var_04 = spawnaircraft(var_01, var_00, level.a10splinesin[var_02]);

      if(isDefined(var_04)) {
        thread scripts\mp\killstreaks\killstreaks::clearrideintro(1.0, 0.75);
        var_04 dooneflyby();
        var_04 thread endflyby(var_01);
        endstrafesequence(var_01);
      }
    }
  }
}

startstrafesequence(var_00, var_01) {
  scripts\mp\utility\game::setusingremote("a10_strafe");

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(0);

  self.restoreangles = self.angles;
  scripts\mp\utility\game::freezecontrolswrapper(1);
  var_02 = scripts\mp\killstreaks\killstreaks::initridekillstreak("a10_strafe");

  if(var_02 != "success") {
    if(var_02 != "disconnect")
      scripts\mp\utility\game::clearusingremote();

    if(isDefined(self.disabledweapon) && self.disabledweapon)
      scripts\engine\utility::allow_weapon(1);

    self notify("death");
    return 0;
  }

  if(scripts\mp\utility\game::isjuggernaut() && isDefined(self.juggernautoverlay))
    self.juggernautoverlay.alpha = 0;

  scripts\mp\utility\game::freezecontrolswrapper(0);
  level.a10strafeactive = 1;
  self.using_remote_a10 = 1;
  level thread scripts\mp\utility\game::teamplayercardsplash("used_" + var_00, self, self.team);
  return 1;
}

endstrafesequence(var_00) {
  scripts\mp\utility\game::clearusingremote();

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(1);

  if(scripts\mp\utility\game::isjuggernaut() && isDefined(self.juggernautoverlay))
    self.juggernautoverlay.alpha = 1;

  self setplayerangles(self.restoreangles);
  self.restoreangles = undefined;
  thread a10_freezebuffer();
  level.a10strafeactive = undefined;
  self.using_remote_a10 = undefined;
}

switchaircraft(var_00, var_01) {
  self.usingremote = undefined;
  self visionsetnakedforplayer("black_bw", 0.75);
  thread scripts\mp\utility\game::set_visionset_for_watching_players("black_bw", 0.75, 0.75);
  wait 0.75;

  if(isDefined(var_00))
    var_00 thread endflyby(var_01);
}

spawnaircraft(var_00, var_01, var_02) {
  var_03 = createplaneasheli(var_00, var_01, var_02);

  if(!isDefined(var_03))
    return undefined;

  var_3.streakname = var_00;
  self remotecontrolvehicle(var_03);
  thread watchintrocleared(var_00, var_03);
  var_04 = level.planeconfigs[var_00];
  var_03 playLoopSound(var_4.sfxengine_1p);
  var_03 thread a10_handledamage();
  scripts\mp\killstreaks\plane::starttrackingplane(var_03);
  return var_03;
}

attachturret(var_00) {
  var_01 = level.planeconfigs[var_00];
  var_02 = self gettagorigin(var_1.turretattachpoint);
  var_03 = spawnturret("misc_turret", self.origin + var_02, var_1.turretname, 0);
  var_03 linkto(self, var_1.turretattachpoint, (0, 0, 0), (0, 0, 0));
  var_03 setModel("vehicle_ugv_talon_gun_mp");
  var_3.angles = self.angles;
  var_3.owner = self.owner;
  var_03 maketurretinoperable();
  var_03 setturretmodechangewait(0);
  var_03 give_player_session_tokens("sentry_offline");
  var_03 makeunusable();
  var_03 setCanDamage(0);
  var_03 setsentryowner(self.owner);
  self.owner remotecontrolturret(var_03);
  self.turret = var_03;
}

cleanupaircraft() {
  if(isDefined(self.turret))
    self.turret delete();

  foreach(var_01 in self.targetlist) {
    if(isDefined(var_1["icon"])) {
      var_1["icon"] destroy();
      var_1["icon"] = undefined;
    }
  }

  self delete();
}

getpathindex() {
  return randomint(level.a10splinesin.size);
}

dooneflyby() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("splinePlaneReachedNode", var_00);

    if(isDefined(var_00) && var_00 == "End") {
      self notify("a10_end_strafe");
      break;
    }
  }
}

endflyby(var_00) {
  if(!isDefined(self)) {
    return;
  }
  self.owner remotecontrolvehicleoff(self);

  if(isDefined(self.turret))
    self.owner remotecontrolturretoff(self.turret);

  self notify("end_remote");
  self.owner thermalvisionfofoverlayoff();
  var_01 = level.planeconfigs[var_00];
  self stoploopsound(var_1.sfxcannonfireloop_1p);
  scripts\mp\killstreaks\plane::stoptrackingplane(self);
  wait 5;

  if(isDefined(self)) {
    self stoploopsound(var_1.sfxengine_1p);
    cleanupaircraft();
  }
}

createplaneasheli(var_00, var_01, var_02) {
  var_03 = level.planeconfigs[var_00];
  var_04 = getcsplinepointposition(var_02, 0);
  var_05 = getcsplinepointtangent(var_02, 0);
  var_06 = vectortoangles(var_05);
  var_07 = spawnhelicopter(self, var_04, var_06, var_3.vehicle, var_3.func_B923[self.team]);

  if(!isDefined(var_07))
    return undefined;

  var_07 makevehiclesolidcapsule(18, -9, 18);
  var_7.owner = self;
  var_7.team = self.team;
  var_7.lifeid = var_01;
  var_07 thread scripts\mp\killstreaks\plane::playplanefx();
  return var_07;
}

handledeath() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  level.a10strafeactive = undefined;
  self.owner.using_remote_a10 = undefined;
  self delete();
}

a10_freezebuffer() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility\game::freezecontrolswrapper(1);
  wait 0.5;
  scripts\mp\utility\game::freezecontrolswrapper(0);
}

monitorrocketfire(var_00, var_01) {
  var_01 endon("end_remote");
  var_01 endon("death");
  self endon("death");
  level endon("game_ended");
  var_02 = level.planeconfigs[var_00];
  var_1.numrocketsleft = var_2.numrockets;
  self notifyonplayercommand("rocket_fire_pressed", "+speed_throw");
  self notifyonplayercommand("rocket_fire_pressed", "+ads_akimbo_accessible");

  if(!level.console)
    self notifyonplayercommand("rocket_fire_pressed", "+toggleads_throw");

  while(var_1.numrocketsleft > 0) {
    self waittill("rocket_fire_pressed");
    var_01 onfirerocket(var_00);
    wait(var_2.delaybetweenrockets);
  }
}

monitorrocketfire2(var_00, var_01) {
  var_01 endon("end_remote");
  var_01 endon("death");
  self endon("death");
  level endon("game_ended");
  var_02 = level.planeconfigs[var_00];
  var_1.numrocketsleft = var_2.numrockets;
  self notifyonplayercommand("rocket_fire_pressed", "+speed_throw");
  self notifyonplayercommand("rocket_fire_pressed", "+ads_akimbo_accessible");

  if(!level.console)
    self notifyonplayercommand("rocket_fire_pressed", "+toggleads_throw");

  var_1.targetlist = [];

  while(var_1.numrocketsleft > 0) {
    if(!self adsbuttonpressed())
      self waittill("rocket_fire_pressed");

    var_01 missileacquiretargets();

    if(var_1.targetlist.size > 0)
      var_01 thread firemissiles();
  }
}

missilegetbesttarget() {
  var_00 = [];

  foreach(var_02 in level.players) {
    if(missileisgoodtarget(var_02))
      var_0[var_0.size] = var_02;
  }

  foreach(var_05 in level.uplinks) {
    if(missileisgoodtarget(var_05))
      var_0[var_0.size] = var_05;
  }

  if(var_0.size > 0) {
    var_07 = sortbydistance(var_00, self.origin);
    return var_7[0];
  }

  return undefined;
}

missileisgoodtarget(var_00) {
  return isalive(var_00) && var_0.team != self.owner.team && !ismissiletargeted(var_00) && (isplayer(var_00) && !var_00 scripts\mp\utility\game::_hasperk("specialty_blindeye")) && missiletargetangle(var_00) > 0.25;
}

missiletargetangle(var_00) {
  var_01 = vectornormalize(var_0.origin - self.origin);
  var_02 = anglesToForward(self.angles);
  return vectordot(var_01, var_02);
}

missileacquiretargets() {
  self endon("death");
  self endon("end_remote");
  level endon("game_ended");
  self endon("a10_missiles_fired");
  var_00 = level.planeconfigs[self.streakname];
  self.owner setclientomnvar("ui_a10_rocket_lock", 1);
  thread missilewaitfortriggerrelease();
  var_01 = undefined;

  while(self.targetlist.size < self.numrocketsleft) {
    if(!isDefined(var_01)) {
      var_01 = missilegetbesttarget();

      if(isDefined(var_01)) {
        thread missilelocktarget(var_01);
        wait(var_0.delaybetweenlockon);
        var_01 = undefined;
        continue;
      }
    }

    wait 0.1;
  }

  self.owner setclientomnvar("ui_a10_rocket_lock", 0);
  self notify("a10_missiles_fired");
}

missilewaitfortriggerrelease() {
  self endon("end_remote");
  self endon("death");
  level endon("game_ended");
  self endon("a10_missiles_fired");
  var_00 = self.owner;
  var_00 notifyonplayercommand("rocket_fire_released", "-speed_throw");
  var_00 notifyonplayercommand("rocket_fire_released", "-ads_akimbo_accessible");

  if(!level.console)
    var_00 notifyonplayercommand("rocket_fire_released", "-toggleads_throw");

  self.owner waittill("rocket_fire_released");
  var_00 setclientomnvar("ui_a10_rocket_lock", 0);
  self notify("a10_missiles_fired");
}

missilelocktarget(var_00) {
  var_01 = level.planeconfigs[self.streakname];
  var_02 = [];
  var_2["icon"] = var_00 scripts\mp\entityheadicons::setheadicon(self.owner, var_1.lockonicon, (0, 0, -70), 10, 10, 0, 0.05, 1, 0, 0, 0);
  var_2["target"] = var_00;
  self.targetlist[var_00 getentitynumber()] = var_02;
  self.owner playlocalsound("recondrone_lockon");
}

ismissiletargeted(var_00) {
  return isDefined(self.targetlist[var_00 getentitynumber()]);
}

firemissiles() {
  self endon("death");
  level endon("game_ended");
  var_00 = level.planeconfigs[self.streakname];

  foreach(var_02 in self.targetlist) {
    if(self.numrocketsleft > 0) {
      var_03 = onfirehomingmissile(self.streakname, var_2["target"], (0, 0, -70));

      if(isDefined(var_2["icon"])) {
        var_3.icon = var_2["icon"];
        var_2["icon"] = undefined;
      }

      wait(var_0.delaybetweenrockets);
      continue;
    }

    break;
  }

  var_05 = [];
}

onfirehomingmissile(var_00, var_01, var_02) {
  var_03 = self.numrocketsleft % 2;
  var_04 = "tag_missile_" + (var_03 + 1);
  var_05 = self gettagorigin(var_04);

  if(isDefined(var_05)) {
    var_06 = self.owner;
    var_07 = level.planeconfigs[var_00];
    var_08 = scripts\mp\utility\game::_magicbullet(var_7.rocketmodelname, var_05, var_05 + 100 * anglesToForward(self.angles), self.owner);
    var_08 thread a10_missile_set_target(var_01, var_02);
    earthquake(0.25, 0.05, self.origin, 512);
    self.numrocketsleft--;
    var_07 = level.planeconfigs[var_00];
    var_08 playsoundonmovingent(var_7.sfxmissilefire_1p[var_03]);
    var_08 playLoopSound(var_7.sfxmissile);
    return var_08;
  }

  return undefined;
}

onfirerocket(var_00) {
  var_01 = "tag_missile_" + self.numrocketsleft;
  var_02 = self gettagorigin(var_01);

  if(isDefined(var_02)) {
    var_03 = self.owner;
    var_04 = level.planeconfigs[var_00];
    var_05 = scripts\mp\utility\game::_magicbullet(var_4.rocketmodelname, var_02, var_02 + 100 * anglesToForward(self.angles), self.owner);
    earthquake(0.25, 0.05, self.origin, 512);
    self.numrocketsleft--;
    var_05 playsoundonmovingent(var_4.sfxmissilefire_1p[self.numrocketsleft]);
    var_05 playLoopSound(var_4.sfxmissile);
    self playsoundonmovingent("a10p_missile_launch");
  }
}

a10_missile_set_target(var_00, var_01) {
  thread a10_missile_cleanup();
  wait 0.2;
  self missile_settargetent(var_00, var_01);
}

a10_missile_cleanup() {
  self waittill("death");

  if(isDefined(self.icon))
    self.icon destroy();
}

monitorweaponfire(var_00, var_01) {
  var_01 endon("end_remote");
  var_01 endon("death");
  self endon("death");
  level endon("game_ended");
  var_02 = level.planeconfigs[var_00];
  var_1.ammocount = 1350;
  self notifyonplayercommand("a10_cannon_start", "+attack");
  self notifyonplayercommand("a10_cannon_start", "+attack_akimbo_accessible");
  self notifyonplayercommand("a10_cannon_stop", "-attack");
  self notifyonplayercommand("a10_cannon_stop", "-attack_akimbo_accessible");

  while(var_1.ammocount > 0) {
    if(!self attackbuttonpressed())
      self waittill("a10_cannon_start");

    var_03 = gettime() + var_2.sfxcannonfireburptime;
    var_01 playLoopSound(var_2.sfxcannonfireloop_1p);
    var_01 thread updatecannonshake(var_00);
    self waittill("a10_cannon_stop");
    var_01 stoploopsound(var_2.sfxcannonfireloop_1p);
    var_01 playsoundonmovingent(var_2.sfxcannonfirestop_1p);

    if(gettime() < var_03) {
      playLoopSound(var_1.origin, var_2.sfxcannonfireburpshort_3p);
      continue;
    }

    playLoopSound(var_1.origin, var_2.sfxcannonfireburplong_3p);
  }
}

updatecannonshake(var_00) {
  self.owner endon("a10_cannon_stop");
  self endon("death");
  level endon("game_ended");
  var_01 = level.planeconfigs[var_00];

  while(self.ammocount > 0) {
    earthquake(0.2, 0.5, self.origin, 512);
    self.ammocount = self.ammocount - 10;
    var_02 = self gettagorigin("tag_flash_attach") + 20 * anglesToForward(self.angles);
    playFX(var_1.cannonfirevfx, var_02);
    self playrumbleonentity(var_1.cannonrumble);
    wait 0.1;
  }

  self.turret turretfiredisable();
}

monitoraltitude(var_00, var_01) {
  var_01 endon("end_remote");
  var_01 endon("death");
  self endon("death");
  level endon("game_ended");
  self setclientomnvar("ui_a10_alt_warn", 0);

  for(;;) {
    var_02 = int(clamp(var_1.origin[2], 0, 16383));
    self setclientomnvar("ui_a10_alt", var_02);

    if(var_02 <= 1000 && !isDefined(var_1.altwarning)) {
      var_1.altwarning = 1;
      self setclientomnvar("ui_a10_alt_warn", 1);
    } else if(var_02 > 1000 && isDefined(var_1.altwarning)) {
      var_1.altwarning = undefined;
      self setclientomnvar("ui_a10_alt_warn", 0);
    }

    wait 0.1;
  }
}

watchintrocleared(var_00, var_01) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("intro_cleared");
  thread monitoraltitude(var_00, var_01);
  thread monitorrocketfire2(var_00, var_01);
  thread monitorweaponfire(var_00, var_01);
  thread watchroundend(var_01, var_00);
  self thermalvisionfofoverlayon();
  thread watchearlyexit(var_01);
}

watchroundend(var_00, var_01) {
  var_00 endon("death");
  var_00 endon("leaving");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level scripts\engine\utility::waittill_any("round_end_finished", "game_ended");
  var_00 thread endflyby(var_01);
  endstrafesequence(var_01);
  a10_explode();
}

buildallflightpathsdefault() {
  var_00 = [];
  var_0[0] = 1;
  var_0[1] = 2;
  var_0[2] = 3;
  var_0[3] = 4;
  var_0[4] = 1;
  var_0[5] = 2;
  var_0[6] = 4;
  var_0[7] = 3;
  var_01 = [];
  var_1[0] = 2;
  var_1[1] = 1;
  var_1[2] = 4;
  var_1[3] = 3;
  var_1[4] = 1;
  var_1[5] = 4;
  var_1[6] = 3;
  var_1[7] = 2;
  buildallflightpaths(var_00, var_01);
}

buildallflightpaths(var_00, var_01) {
  level.a10splinesin = var_00;
  level.a10splinesout = var_01;
}

a10_cockpit_breathing() {
  level endon("remove_player_control");

  for(;;)
    wait(randomfloatrange(3.0, 7.0));
}

watchearlyexit(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("a10_end_strafe");
  var_00 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_00 waittill("killstreakExit");
  self notify("end_remote");
  var_00 thread endflyby(var_0.streakname);
  endstrafesequence(var_0.streakname);
  var_00 a10_explode();
}

a10_handledamage() {
  self endon("end_remote");
  var_00 = level.planeconfigs[self.streakname];
  scripts\mp\damage::monitordamage(var_0.maxhealth, "helicopter", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_05 = scripts\mp\damage::handleempdamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handlemissiledamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);
  return var_05;
}

handledeathdamage(var_00, var_01, var_02, var_03) {
  var_04 = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled("a10", var_00, var_01, var_02, var_03, var_4.scorepopup, var_4.vodestroyed, var_4.callout);
  a10_explode();
}

a10_explode() {
  var_00 = level.planeconfigs[self.streakname];
  scripts\mp\killstreaks\plane::stoptrackingplane(self);
  playFX(var_0.explodevfx, self.origin);
  self delete();
}