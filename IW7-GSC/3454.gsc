/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3454.gsc
***************************************/

init() {
  var_0 = spawnStruct();
  var_0.var_B923 = [];
  var_0.var_B923["allies"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_0.var_B923["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
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
  level.planeconfigs["a10_strafe"] = var_0;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("a10_strafe", ::onuse);
  buildallflightpathsdefault();
}

onuse(var_0, var_1) {
  if(isDefined(level.a10strafeactive)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\game::isusingremote() || scripts\mp\utility\game::iskillstreakdenied())
    return 0;
  else if(getcsplinecount() < 2) {
    return 0;
  } else {
    thread dostrike(var_0, "a10_strafe");
    return 1;
  }
}

dostrike(var_0, var_1) {
  self endon("end_remote");
  self endon("death");
  level endon("game_ended");
  var_2 = getpathindex();
  var_3 = startstrafesequence(var_1, var_0);

  if(var_3) {
    var_4 = spawnaircraft(var_1, var_0, level.a10splinesin[var_2]);

    if(isDefined(var_4)) {
      var_4 dooneflyby();
      switchaircraft(var_4, var_1);
      var_4 = spawnaircraft(var_1, var_0, level.a10splinesin[var_2]);

      if(isDefined(var_4)) {
        thread scripts\mp\killstreaks\killstreaks::clearrideintro(1.0, 0.75);
        var_4 dooneflyby();
        var_4 thread endflyby(var_1);
        endstrafesequence(var_1);
      }
    }
  }
}

startstrafesequence(var_0, var_1) {
  scripts\mp\utility\game::setusingremote("a10_strafe");

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\game::setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  scripts\mp\utility\game::freezecontrolswrapper(1);
  var_2 = scripts\mp\killstreaks\killstreaks::initridekillstreak("a10_strafe");

  if(var_2 != "success") {
    if(var_2 != "disconnect") {
      scripts\mp\utility\game::clearusingremote();
    }

    if(isDefined(self.disabledweapon) && self.disabledweapon) {
      scripts\engine\utility::allow_weapon(1);
    }

    self notify("death");
    return 0;
  }

  if(scripts\mp\utility\game::isjuggernaut() && isDefined(self.juggernautoverlay)) {
    self.juggernautoverlay.alpha = 0;
  }

  scripts\mp\utility\game::freezecontrolswrapper(0);
  level.a10strafeactive = 1;
  self.using_remote_a10 = 1;
  level thread scripts\mp\utility\game::teamplayercardsplash("used_" + var_0, self, self.team);
  return 1;
}

endstrafesequence(var_0) {
  scripts\mp\utility\game::clearusingremote();

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\game::setthirdpersondof(1);
  }

  if(scripts\mp\utility\game::isjuggernaut() && isDefined(self.juggernautoverlay)) {
    self.juggernautoverlay.alpha = 1;
  }

  self setplayerangles(self.restoreangles);
  self.restoreangles = undefined;
  thread a10_freezebuffer();
  level.a10strafeactive = undefined;
  self.using_remote_a10 = undefined;
}

switchaircraft(var_0, var_1) {
  self.usingremote = undefined;
  self visionsetnakedforplayer("black_bw", 0.75);
  thread scripts\mp\utility\game::set_visionset_for_watching_players("black_bw", 0.75, 0.75);
  wait 0.75;

  if(isDefined(var_0)) {
    var_0 thread endflyby(var_1);
  }
}

spawnaircraft(var_0, var_1, var_2) {
  var_3 = createplaneasheli(var_0, var_1, var_2);

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_3.streakname = var_0;
  self remotecontrolvehicle(var_3);
  thread watchintrocleared(var_0, var_3);
  var_4 = level.planeconfigs[var_0];
  var_3 playLoopSound(var_4.sfxengine_1p);
  var_3 thread a10_handledamage();
  scripts\mp\killstreaks\plane::starttrackingplane(var_3);
  return var_3;
}

attachturret(var_0) {
  var_1 = level.planeconfigs[var_0];
  var_2 = self gettagorigin(var_1.turretattachpoint);
  var_3 = spawnturret("misc_turret", self.origin + var_2, var_1.turretname, 0);
  var_3 linkto(self, var_1.turretattachpoint, (0, 0, 0), (0, 0, 0));
  var_3 setModel("vehicle_ugv_talon_gun_mp");
  var_3.angles = self.angles;
  var_3.owner = self.owner;
  var_3 maketurretinoperable();
  var_3 setturretmodechangewait(0);
  var_3 give_player_session_tokens("sentry_offline");
  var_3 makeunusable();
  var_3 setCanDamage(0);
  var_3 setsentryowner(self.owner);
  self.owner remotecontrolturret(var_3);
  self.turret = var_3;
}

cleanupaircraft() {
  if(isDefined(self.turret)) {
    self.turret delete();
  }

  foreach(var_1 in self.targetlist) {
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
    self waittill("splinePlaneReachedNode", var_0);

    if(isDefined(var_0) && var_0 == "End") {
      self notify("a10_end_strafe");
      break;
    }
  }
}

endflyby(var_0) {
  if(!isDefined(self)) {
    return;
  }
  self.owner remotecontrolvehicleoff(self);

  if(isDefined(self.turret)) {
    self.owner remotecontrolturretoff(self.turret);
  }

  self notify("end_remote");
  self.owner thermalvisionfofoverlayoff();
  var_1 = level.planeconfigs[var_0];
  self stoploopsound(var_1.sfxcannonfireloop_1p);
  scripts\mp\killstreaks\plane::stoptrackingplane(self);
  wait 5;

  if(isDefined(self)) {
    self stoploopsound(var_1.sfxengine_1p);
    cleanupaircraft();
  }
}

createplaneasheli(var_0, var_1, var_2) {
  var_3 = level.planeconfigs[var_0];
  var_4 = getcsplinepointposition(var_2, 0);
  var_5 = getcsplinepointtangent(var_2, 0);
  var_6 = vectortoangles(var_5);
  var_7 = spawnhelicopter(self, var_4, var_6, var_3.vehicle, var_3.var_B923[self.team]);

  if(!isDefined(var_7)) {
    return undefined;
  }

  var_7 makevehiclesolidcapsule(18, -9, 18);
  var_7.owner = self;
  var_7.team = self.team;
  var_7.lifeid = var_1;
  var_7 thread scripts\mp\killstreaks\plane::playplanefx();
  return var_7;
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

monitorrocketfire(var_0, var_1) {
  var_1 endon("end_remote");
  var_1 endon("death");
  self endon("death");
  level endon("game_ended");
  var_2 = level.planeconfigs[var_0];
  var_1.numrocketsleft = var_2.numrockets;
  self notifyonplayercommand("rocket_fire_pressed", "+speed_throw");
  self notifyonplayercommand("rocket_fire_pressed", "+ads_akimbo_accessible");

  if(!level.console) {
    self notifyonplayercommand("rocket_fire_pressed", "+toggleads_throw");
  }

  while(var_1.numrocketsleft > 0) {
    self waittill("rocket_fire_pressed");
    var_1 onfirerocket(var_0);
    wait(var_2.delaybetweenrockets);
  }
}

monitorrocketfire2(var_0, var_1) {
  var_1 endon("end_remote");
  var_1 endon("death");
  self endon("death");
  level endon("game_ended");
  var_2 = level.planeconfigs[var_0];
  var_1.numrocketsleft = var_2.numrockets;
  self notifyonplayercommand("rocket_fire_pressed", "+speed_throw");
  self notifyonplayercommand("rocket_fire_pressed", "+ads_akimbo_accessible");

  if(!level.console) {
    self notifyonplayercommand("rocket_fire_pressed", "+toggleads_throw");
  }

  var_1.targetlist = [];

  while(var_1.numrocketsleft > 0) {
    if(!self adsbuttonpressed()) {
      self waittill("rocket_fire_pressed");
    }

    var_1 missileacquiretargets();

    if(var_1.targetlist.size > 0) {
      var_1 thread firemissiles();
    }
  }
}

missilegetbesttarget() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(missileisgoodtarget(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  foreach(var_5 in level.uplinks) {
    if(missileisgoodtarget(var_5)) {
      var_0[var_0.size] = var_5;
    }
  }

  if(var_0.size > 0) {
    var_7 = sortbydistance(var_0, self.origin);
    return var_7[0];
  }

  return undefined;
}

missileisgoodtarget(var_0) {
  return isalive(var_0) && var_0.team != self.owner.team && !ismissiletargeted(var_0) && (isplayer(var_0) && !var_0 scripts\mp\utility\game::_hasperk("specialty_blindeye")) && missiletargetangle(var_0) > 0.25;
}

missiletargetangle(var_0) {
  var_1 = vectornormalize(var_0.origin - self.origin);
  var_2 = anglesToForward(self.angles);
  return vectordot(var_1, var_2);
}

missileacquiretargets() {
  self endon("death");
  self endon("end_remote");
  level endon("game_ended");
  self endon("a10_missiles_fired");
  var_0 = level.planeconfigs[self.streakname];
  self.owner setclientomnvar("ui_a10_rocket_lock", 1);
  thread missilewaitfortriggerrelease();
  var_1 = undefined;

  while(self.targetlist.size < self.numrocketsleft) {
    if(!isDefined(var_1)) {
      var_1 = missilegetbesttarget();

      if(isDefined(var_1)) {
        thread missilelocktarget(var_1);
        wait(var_0.delaybetweenlockon);
        var_1 = undefined;
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
  var_0 = self.owner;
  var_0 notifyonplayercommand("rocket_fire_released", "-speed_throw");
  var_0 notifyonplayercommand("rocket_fire_released", "-ads_akimbo_accessible");

  if(!level.console) {
    var_0 notifyonplayercommand("rocket_fire_released", "-toggleads_throw");
  }

  self.owner waittill("rocket_fire_released");
  var_0 setclientomnvar("ui_a10_rocket_lock", 0);
  self notify("a10_missiles_fired");
}

missilelocktarget(var_0) {
  var_1 = level.planeconfigs[self.streakname];
  var_2 = [];
  var_2["icon"] = var_0 scripts\mp\entityheadicons::setheadicon(self.owner, var_1.lockonicon, (0, 0, -70), 10, 10, 0, 0.05, 1, 0, 0, 0);
  var_2["target"] = var_0;
  self.targetlist[var_0 getentitynumber()] = var_2;
  self.owner playlocalsound("recondrone_lockon");
}

ismissiletargeted(var_0) {
  return isDefined(self.targetlist[var_0 getentitynumber()]);
}

firemissiles() {
  self endon("death");
  level endon("game_ended");
  var_0 = level.planeconfigs[self.streakname];

  foreach(var_2 in self.targetlist) {
    if(self.numrocketsleft > 0) {
      var_3 = onfirehomingmissile(self.streakname, var_2["target"], (0, 0, -70));

      if(isDefined(var_2["icon"])) {
        var_3.icon = var_2["icon"];
        var_2["icon"] = undefined;
      }

      wait(var_0.delaybetweenrockets);
      continue;
    }

    break;
  }

  var_5 = [];
}

onfirehomingmissile(var_0, var_1, var_2) {
  var_3 = self.numrocketsleft % 2;
  var_4 = "tag_missile_" + (var_3 + 1);
  var_5 = self gettagorigin(var_4);

  if(isDefined(var_5)) {
    var_6 = self.owner;
    var_7 = level.planeconfigs[var_0];
    var_8 = scripts\mp\utility\game::_magicbullet(var_7.rocketmodelname, var_5, var_5 + 100 * anglesToForward(self.angles), self.owner);
    var_8 thread a10_missile_set_target(var_1, var_2);
    earthquake(0.25, 0.05, self.origin, 512);
    self.numrocketsleft--;
    var_7 = level.planeconfigs[var_0];
    var_8 playsoundonmovingent(var_7.sfxmissilefire_1p[var_3]);
    var_8 playLoopSound(var_7.sfxmissile);
    return var_8;
  }

  return undefined;
}

onfirerocket(var_0) {
  var_1 = "tag_missile_" + self.numrocketsleft;
  var_2 = self gettagorigin(var_1);

  if(isDefined(var_2)) {
    var_3 = self.owner;
    var_4 = level.planeconfigs[var_0];
    var_5 = scripts\mp\utility\game::_magicbullet(var_4.rocketmodelname, var_2, var_2 + 100 * anglesToForward(self.angles), self.owner);
    earthquake(0.25, 0.05, self.origin, 512);
    self.numrocketsleft--;
    var_5 playsoundonmovingent(var_4.sfxmissilefire_1p[self.numrocketsleft]);
    var_5 playLoopSound(var_4.sfxmissile);
    self playsoundonmovingent("a10p_missile_launch");
  }
}

a10_missile_set_target(var_0, var_1) {
  thread a10_missile_cleanup();
  wait 0.2;
  self missile_settargetent(var_0, var_1);
}

a10_missile_cleanup() {
  self waittill("death");

  if(isDefined(self.icon)) {
    self.icon destroy();
  }
}

monitorweaponfire(var_0, var_1) {
  var_1 endon("end_remote");
  var_1 endon("death");
  self endon("death");
  level endon("game_ended");
  var_2 = level.planeconfigs[var_0];
  var_1.ammocount = 1350;
  self notifyonplayercommand("a10_cannon_start", "+attack");
  self notifyonplayercommand("a10_cannon_start", "+attack_akimbo_accessible");
  self notifyonplayercommand("a10_cannon_stop", "-attack");
  self notifyonplayercommand("a10_cannon_stop", "-attack_akimbo_accessible");

  while(var_1.ammocount > 0) {
    if(!self attackbuttonpressed()) {
      self waittill("a10_cannon_start");
    }

    var_3 = gettime() + var_2.sfxcannonfireburptime;
    var_1 playLoopSound(var_2.sfxcannonfireloop_1p);
    var_1 thread updatecannonshake(var_0);
    self waittill("a10_cannon_stop");
    var_1 stoploopsound(var_2.sfxcannonfireloop_1p);
    var_1 playsoundonmovingent(var_2.sfxcannonfirestop_1p);

    if(gettime() < var_3) {
      playLoopSound(var_1.origin, var_2.sfxcannonfireburpshort_3p);
      continue;
    }

    playLoopSound(var_1.origin, var_2.sfxcannonfireburplong_3p);
  }
}

updatecannonshake(var_0) {
  self.owner endon("a10_cannon_stop");
  self endon("death");
  level endon("game_ended");
  var_1 = level.planeconfigs[var_0];

  while(self.ammocount > 0) {
    earthquake(0.2, 0.5, self.origin, 512);
    self.ammocount = self.ammocount - 10;
    var_2 = self gettagorigin("tag_flash_attach") + 20 * anglesToForward(self.angles);
    playFX(var_1.cannonfirevfx, var_2);
    self playrumbleonentity(var_1.cannonrumble);
    wait 0.1;
  }

  self.turret turretfiredisable();
}

monitoraltitude(var_0, var_1) {
  var_1 endon("end_remote");
  var_1 endon("death");
  self endon("death");
  level endon("game_ended");
  self setclientomnvar("ui_a10_alt_warn", 0);

  for(;;) {
    var_2 = int(clamp(var_1.origin[2], 0, 16383));
    self setclientomnvar("ui_a10_alt", var_2);

    if(var_2 <= 1000 && !isDefined(var_1.altwarning)) {
      var_1.altwarning = 1;
      self setclientomnvar("ui_a10_alt_warn", 1);
    } else if(var_2 > 1000 && isDefined(var_1.altwarning)) {
      var_1.altwarning = undefined;
      self setclientomnvar("ui_a10_alt_warn", 0);
    }

    wait 0.1;
  }
}

watchintrocleared(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("intro_cleared");
  thread monitoraltitude(var_0, var_1);
  thread monitorrocketfire2(var_0, var_1);
  thread monitorweaponfire(var_0, var_1);
  thread watchroundend(var_1, var_0);
  self thermalvisionfofoverlayon();
  thread watchearlyexit(var_1);
}

watchroundend(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("leaving");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level scripts\engine\utility::waittill_any("round_end_finished", "game_ended");
  var_0 thread endflyby(var_1);
  endstrafesequence(var_1);
  a10_explode();
}

buildallflightpathsdefault() {
  var_0 = [];
  var_0[0] = 1;
  var_0[1] = 2;
  var_0[2] = 3;
  var_0[3] = 4;
  var_0[4] = 1;
  var_0[5] = 2;
  var_0[6] = 4;
  var_0[7] = 3;
  var_1 = [];
  var_1[0] = 2;
  var_1[1] = 1;
  var_1[2] = 4;
  var_1[3] = 3;
  var_1[4] = 1;
  var_1[5] = 4;
  var_1[6] = 3;
  var_1[7] = 2;
  buildallflightpaths(var_0, var_1);
}

buildallflightpaths(var_0, var_1) {
  level.a10splinesin = var_0;
  level.a10splinesout = var_1;
}

a10_cockpit_breathing() {
  level endon("remove_player_control");

  for(;;) {
    wait(randomfloatrange(3.0, 7.0));
  }
}

watchearlyexit(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("a10_end_strafe");
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_0 waittill("killstreakExit");
  self notify("end_remote");
  var_0 thread endflyby(var_0.streakname);
  endstrafesequence(var_0.streakname);
  var_0 a10_explode();
}

a10_handledamage() {
  self endon("end_remote");
  var_0 = level.planeconfigs[self.streakname];
  scripts\mp\damage::monitordamage(var_0.maxhealth, "helicopter", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handleempdamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handlemissiledamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

handledeathdamage(var_0, var_1, var_2, var_3) {
  var_4 = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled("a10", var_0, var_1, var_2, var_3, var_4.scorepopup, var_4.vodestroyed, var_4.callout);
  a10_explode();
}

a10_explode() {
  var_0 = level.planeconfigs[self.streakname];
  scripts\mp\killstreaks\plane::stoptrackingplane(self);
  playFX(var_0.explodevfx, self.origin);
  self delete();
}