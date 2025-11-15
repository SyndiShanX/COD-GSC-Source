/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\a10.gsc
******************************************/

init() {
  var_00 = spawnStruct();
  var_00.var_B923 = [];
  var_00.var_B923["allies"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_00.var_B923["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_00.vehicle = "a10_warthog_mp";
  var_00.inboundsfx = "veh_mig29_dist_loop";
  var_00.getclosestpointonnavmesh3d = 3000;
  var_00.halfdistance = 12500;
  var_00.heightrange = 750;
  var_00.choosedirection = 1;
  var_00.selectlocationvo = "KS_hqr_airstrike";
  var_00.inboundvo = "KS_ast_inbound";
  var_00.cannonfirevfx = loadfx("vfx\core\smktrail\smoke_trail_white_heli");
  var_00.cannonrumble = "ac130_25mm_fire";
  var_00.turretname = "a10_30mm_turret_mp";
  var_00.turretattachpoint = "tag_barrel";
  var_00.rocketmodelname = "maverick_projectile_mp";
  var_00.numrockets = 4;
  var_00.delaybetweenrockets = 0.125;
  var_00.delaybetweenlockon = 0.4;
  var_00.lockonicon = "veh_hud_target_chopperfly";
  var_00.maxhealth = 1000;
  var_00.scorepopup = "destroyed_a10_strafe";
  var_00.callout = "callout_destroyed_a10";
  var_00.vodestroyed = undefined;
  var_00.explodevfx = loadfx("vfx\core\expl\aerial_explosion");
  var_00.sfxcannonfireloop_1p = "veh_a10_plr_fire_gatling_lp";
  var_00.sfxcannonfirestop_1p = "veh_a10_plr_fire_gatling_cooldown";
  var_00.sfxcannonfireloop_3p = "veh_a10_npc_fire_gatling_lp";
  var_00.sfxcannonfirestop_3p = "veh_a10_npc_fire_gatling_cooldown";
  var_00.sfxcannonfireburptime = 500;
  var_00.sfxcannonfireburpshort_3p = "veh_a10_npc_fire_gatling_short_burst";
  var_00.sfxcannonfireburplong_3p = "veh_a10_npc_fire_gatling_long_burst";
  var_00.sfxcannonbulletimpact = "veh_a10_bullet_impact_lp";
  var_00.sfxmissilefire_1p = [];
  var_00.sfxmissilefire_1p[0] = "veh_a10_plr_missile_ignition_left";
  var_00.sfxmissilefire_1p[1] = "veh_a10_plr_missile_ignition_right";
  var_00.sfxmissilefire_3p = "veh_a10_npc_missile_fire";
  var_00.sfxmissile = "veh_a10_missile_loop";
  var_00.sfxengine_1p = "veh_a10_plr_engine_lp";
  var_00.sfxengine_3p = "veh_a10_dist_loop";
  level.planeconfigs["a10_strafe"] = var_00;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("a10_strafe", ::onuse);
  buildallflightpathsdefault();
}

onuse(param_00, param_01) {
  if(isDefined(level.a10strafeactive)) {
    self iprintlnbold( & "KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility::isusingremote() || scripts\mp\utility::iskillstreakdenied()) {
    return 0;
  }

  if(getcsplinecount() < 2) {
    return 0;
  }

  thread dostrike(param_00, "a10_strafe");
  return 1;
}

dostrike(param_00, param_01) {
  self endon("end_remote");
  self endon("death");
  level endon("game_ended");
  var_02 = getpathindex();
  var_03 = startstrafesequence(param_01, param_00);
  if(var_03) {
    var_04 = spawnaircraft(param_01, param_00, level.a10splinesin[var_02]);
    if(isDefined(var_04)) {
      var_04 dooneflyby();
      switchaircraft(var_04, param_01);
      var_04 = spawnaircraft(param_01, param_00, level.a10splinesin[var_02]);
      if(isDefined(var_04)) {
        thread scripts\mp\killstreaks\_killstreaks::clearrideintro(1, 0.75);
        var_04 dooneflyby();
        var_04 thread endflyby(param_01);
        endstrafesequence(param_01);
        return;
      }
    }
  }
}

startstrafesequence(param_00, param_01) {
  scripts\mp\utility::setusingremote("a10_strafe");
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  scripts\mp\utility::freezecontrolswrapper(1);
  var_02 = scripts\mp\killstreaks\_killstreaks::initridekillstreak("a10_strafe");
  if(var_02 != "success") {
    if(var_02 != "disconnect") {
      scripts\mp\utility::clearusingremote();
    }

    if(isDefined(self.disabledweapon) && self.disabledweapon) {
      scripts\engine\utility::allow_weapon(1);
    }

    self notify("death");
    return 0;
  }

  if(scripts\mp\utility::isjuggernaut() && isDefined(self.juggernautoverlay)) {
    self.juggernautoverlay.alpha = 0;
  }

  scripts\mp\utility::freezecontrolswrapper(0);
  level.a10strafeactive = 1;
  self.using_remote_a10 = 1;
  level thread scripts\mp\utility::teamplayercardsplash("used_" + param_00, self, self.team);
  return 1;
}

endstrafesequence(param_00) {
  scripts\mp\utility::clearusingremote();
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(1);
  }

  if(scripts\mp\utility::isjuggernaut() && isDefined(self.juggernautoverlay)) {
    self.juggernautoverlay.alpha = 1;
  }

  self setplayerangles(self.restoreangles);
  self.restoreangles = undefined;
  thread a10_freezebuffer();
  level.a10strafeactive = undefined;
  self.using_remote_a10 = undefined;
}

switchaircraft(param_00, param_01) {
  self.usingremote = undefined;
  self visionsetnakedforplayer("black_bw", 0.75);
  thread scripts\mp\utility::set_visionset_for_watching_players("black_bw", 0.75, 0.75);
  wait(0.75);
  if(isDefined(param_00)) {
    param_00 thread endflyby(param_01);
  }
}

spawnaircraft(param_00, param_01, param_02) {
  var_03 = createplaneasheli(param_00, param_01, param_02);
  if(!isDefined(var_03)) {
    return undefined;
  }

  var_03.streakname = param_00;
  self remotecontrolvehicle(var_03);
  thread watchintrocleared(param_00, var_03);
  var_04 = level.planeconfigs[param_00];
  var_03 playLoopSound(var_04.sfxengine_1p);
  var_03 thread a10_handledamage();
  scripts\mp\killstreaks\_plane::starttrackingplane(var_03);
  return var_03;
}

attachturret(param_00) {
  var_01 = level.planeconfigs[param_00];
  var_02 = self gettagorigin(var_01.turretattachpoint);
  var_03 = spawnturret("misc_turret", self.origin + var_02, var_01.turretname, 0);
  var_03 linkto(self, var_01.turretattachpoint, (0, 0, 0), (0, 0, 0));
  var_03 setModel("vehicle_ugv_talon_gun_mp");
  var_03.angles = self.angles;
  var_03.triggerportableradarping = self.triggerportableradarping;
  var_03 getvalidattachments();
  var_03 setturretmodechangewait(0);
  var_03 give_player_session_tokens("sentry_offline");
  var_03 makeunusable();
  var_03 setCanDamage(0);
  var_03 setsentryowner(self.triggerportableradarping);
  self.triggerportableradarping remotecontrolturret(var_03);
  self.turret = var_03;
}

cleanupaircraft() {
  if(isDefined(self.turret)) {
    self.turret delete();
  }

  foreach(var_01 in self.targetlist) {
    if(isDefined(var_01["icon"])) {
      var_01["icon"] destroy();
      var_01["icon"] = undefined;
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

endflyby(param_00) {
  if(!isDefined(self)) {
    return;
  }

  self.triggerportableradarping remotecontrolvehicleoff(self);
  if(isDefined(self.turret)) {
    self.triggerportableradarping geysers_and_boatride(self.turret);
  }

  self notify("end_remote");
  self.triggerportableradarping thermalvisionfofoverlayoff();
  var_01 = level.planeconfigs[param_00];
  self stoploopsound(var_01.sfxcannonfireloop_1p);
  scripts\mp\killstreaks\_plane::stoptrackingplane(self);
  wait(5);
  if(isDefined(self)) {
    self stoploopsound(var_01.sfxengine_1p);
    cleanupaircraft();
  }
}

createplaneasheli(param_00, param_01, param_02) {
  var_03 = level.planeconfigs[param_00];
  var_04 = getcsplinepointposition(param_02, 0);
  var_05 = getcsplinepointtangent(param_02, 0);
  var_06 = vectortoangles(var_05);
  var_07 = spawnhelicopter(self, var_04, var_06, var_03.vehicle, var_03.var_B923[self.team]);
  if(!isDefined(var_07)) {
    return undefined;
  }

  var_07 makevehiclesolidcapsule(18, -9, 18);
  var_07.triggerportableradarping = self;
  var_07.team = self.team;
  var_07.lifeid = param_01;
  var_07 thread scripts\mp\killstreaks\_plane::playplanefx();
  return var_07;
}

handledeath() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  level.a10strafeactive = undefined;
  self.triggerportableradarping.using_remote_a10 = undefined;
  self delete();
}

a10_freezebuffer() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility::freezecontrolswrapper(1);
  wait(0.5);
  scripts\mp\utility::freezecontrolswrapper(0);
}

monitorrocketfire(param_00, param_01) {
  param_01 endon("end_remote");
  param_01 endon("death");
  self endon("death");
  level endon("game_ended");
  var_02 = level.planeconfigs[param_00];
  param_01.numrocketsleft = var_02.numrockets;
  self notifyonplayercommand("rocket_fire_pressed", "+speed_throw");
  self notifyonplayercommand("rocket_fire_pressed", "+ads_akimbo_accessible");
  if(!level.console) {
    self notifyonplayercommand("rocket_fire_pressed", "+toggleads_throw");
  }

  while(param_01.numrocketsleft > 0) {
    self waittill("rocket_fire_pressed");
    param_01 onfirerocket(param_00);
    wait(var_02.delaybetweenrockets);
  }
}

monitorrocketfire2(param_00, param_01) {
  param_01 endon("end_remote");
  param_01 endon("death");
  self endon("death");
  level endon("game_ended");
  var_02 = level.planeconfigs[param_00];
  param_01.numrocketsleft = var_02.numrockets;
  self notifyonplayercommand("rocket_fire_pressed", "+speed_throw");
  self notifyonplayercommand("rocket_fire_pressed", "+ads_akimbo_accessible");
  if(!level.console) {
    self notifyonplayercommand("rocket_fire_pressed", "+toggleads_throw");
  }

  param_01.targetlist = [];
  while(param_01.numrocketsleft > 0) {
    if(!self adsbuttonpressed()) {
      self waittill("rocket_fire_pressed");
    }

    param_01 missileacquiretargets();
    if(param_01.targetlist.size > 0) {
      param_01 thread firemissiles();
    }
  }
}

missilegetbesttarget() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(missileisgoodtarget(var_02)) {
      var_00[var_00.size] = var_02;
    }
  }

  foreach(var_05 in level.uplinks) {
    if(missileisgoodtarget(var_05)) {
      var_00[var_00.size] = var_05;
    }
  }

  if(var_00.size > 0) {
    var_07 = sortbydistance(var_00, self.origin);
    return var_07[0];
  }

  return undefined;
}

missileisgoodtarget(param_00) {
  return isalive(param_00) && param_00.team != self.triggerportableradarping.team && !ismissiletargeted(param_00) && isplayer(param_00) && !param_00 scripts\mp\utility::_hasperk("specialty_blindeye") && missiletargetangle(param_00) > 0.25;
}

missiletargetangle(param_00) {
  var_01 = vectornormalize(param_00.origin - self.origin);
  var_02 = anglesToForward(self.angles);
  return vectordot(var_01, var_02);
}

missileacquiretargets() {
  self endon("death");
  self endon("end_remote");
  level endon("game_ended");
  self endon("a10_missiles_fired");
  var_00 = level.planeconfigs[self.streakname];
  self.triggerportableradarping setclientomnvar("ui_a10_rocket_lock", 1);
  thread missilewaitfortriggerrelease();
  var_01 = undefined;
  while(self.targetlist.size < self.numrocketsleft) {
    if(!isDefined(var_01)) {
      var_01 = missilegetbesttarget();
      if(isDefined(var_01)) {
        thread missilelocktarget(var_01);
        wait(var_00.delaybetweenlockon);
        var_01 = undefined;
        continue;
      }
    }

    wait(0.1);
  }

  self.triggerportableradarping setclientomnvar("ui_a10_rocket_lock", 0);
  self notify("a10_missiles_fired");
}

missilewaitfortriggerrelease() {
  self endon("end_remote");
  self endon("death");
  level endon("game_ended");
  self endon("a10_missiles_fired");
  var_00 = self.triggerportableradarping;
  var_00 notifyonplayercommand("rocket_fire_released", "-speed_throw");
  var_00 notifyonplayercommand("rocket_fire_released", "-ads_akimbo_accessible");
  if(!level.console) {
    var_00 notifyonplayercommand("rocket_fire_released", "-toggleads_throw");
  }

  self.triggerportableradarping waittill("rocket_fire_released");
  var_00 setclientomnvar("ui_a10_rocket_lock", 0);
  self notify("a10_missiles_fired");
}

missilelocktarget(param_00) {
  var_01 = level.planeconfigs[self.streakname];
  var_02 = [];
  var_02["icon"] = param_00 scripts\mp\entityheadicons::setheadicon(self.triggerportableradarping, var_01.lockonicon, (0, 0, -70), 10, 10, 0, 0.05, 1, 0, 0, 0);
  var_02["target"] = param_00;
  self.targetlist[param_00 getentitynumber()] = var_02;
  self.triggerportableradarping playlocalsound("recondrone_lockon");
}

ismissiletargeted(param_00) {
  return isDefined(self.targetlist[param_00 getentitynumber()]);
}

firemissiles() {
  self endon("death");
  level endon("game_ended");
  var_00 = level.planeconfigs[self.streakname];
  foreach(var_02 in self.targetlist) {
    if(self.numrocketsleft > 0) {
      var_03 = onfirehomingmissile(self.streakname, var_02["target"], (0, 0, -70));
      if(isDefined(var_02["icon"])) {
        var_03.icon = var_02["icon"];
        var_02["icon"] = undefined;
      }

      wait(var_00.delaybetweenrockets);
      continue;
    }

    break;
  }

  var_05 = [];
}

onfirehomingmissile(param_00, param_01, param_02) {
  var_03 = self.numrocketsleft % 2;
  var_04 = "tag_missile_" + var_03 + 1;
  var_05 = self gettagorigin(var_04);
  if(isDefined(var_05)) {
    var_06 = self.triggerportableradarping;
    var_07 = level.planeconfigs[param_00];
    var_08 = scripts\mp\utility::_magicbullet(var_07.rocketmodelname, var_05, var_05 + 100 * anglesToForward(self.angles), self.triggerportableradarping);
    var_08 thread a10_missile_set_target(param_01, param_02);
    earthquake(0.25, 0.05, self.origin, 512);
    self.numrocketsleft--;
    var_07 = level.planeconfigs[param_00];
    var_08 playsoundonmovingent(var_07.sfxmissilefire_1p[var_03]);
    var_08 playLoopSound(var_07.sfxmissile);
    return var_08;
  }

  return undefined;
}

onfirerocket(param_00) {
  var_01 = "tag_missile_" + self.numrocketsleft;
  var_02 = self gettagorigin(var_01);
  if(isDefined(var_02)) {
    var_03 = self.triggerportableradarping;
    var_04 = level.planeconfigs[param_00];
    var_05 = scripts\mp\utility::_magicbullet(var_04.rocketmodelname, var_02, var_02 + 100 * anglesToForward(self.angles), self.triggerportableradarping);
    earthquake(0.25, 0.05, self.origin, 512);
    self.numrocketsleft--;
    var_05 playsoundonmovingent(var_04.sfxmissilefire_1p[self.numrocketsleft]);
    var_05 playLoopSound(var_04.sfxmissile);
    self playsoundonmovingent("a10p_missile_launch");
  }
}

a10_missile_set_target(param_00, param_01) {
  thread a10_missile_cleanup();
  wait(0.2);
  self missile_settargetent(param_00, param_01);
}

a10_missile_cleanup() {
  self waittill("death");
  if(isDefined(self.icon)) {
    self.icon destroy();
  }
}

monitorweaponfire(param_00, param_01) {
  param_01 endon("end_remote");
  param_01 endon("death");
  self endon("death");
  level endon("game_ended");
  var_02 = level.planeconfigs[param_00];
  param_01.ammocount = 1350;
  self notifyonplayercommand("a10_cannon_start", "+attack");
  self notifyonplayercommand("a10_cannon_start", "+attack_akimbo_accessible");
  self notifyonplayercommand("a10_cannon_stop", "-attack");
  self notifyonplayercommand("a10_cannon_stop", "-attack_akimbo_accessible");
  while(param_01.ammocount > 0) {
    if(!self attackbuttonpressed()) {
      self waittill("a10_cannon_start");
    }

    var_03 = gettime() + var_02.sfxcannonfireburptime;
    param_01 playLoopSound(var_02.sfxcannonfireloop_1p);
    param_01 thread updatecannonshake(param_00);
    self waittill("a10_cannon_stop");
    param_01 stoploopsound(var_02.sfxcannonfireloop_1p);
    param_01 playsoundonmovingent(var_02.sfxcannonfirestop_1p);
    if(gettime() < var_03) {
      playsoundatpos(param_01.origin, var_02.sfxcannonfireburpshort_3p);
      continue;
    }

    playsoundatpos(param_01.origin, var_02.sfxcannonfireburplong_3p);
  }
}

updatecannonshake(param_00) {
  self.triggerportableradarping endon("a10_cannon_stop");
  self endon("death");
  level endon("game_ended");
  var_01 = level.planeconfigs[param_00];
  while(self.ammocount > 0) {
    earthquake(0.2, 0.5, self.origin, 512);
    self.ammocount = self.ammocount - 10;
    var_02 = self gettagorigin("tag_flash_attach") + 20 * anglesToForward(self.angles);
    playFX(var_01.cannonfirevfx, var_02);
    self playrumbleonentity(var_01.cannonrumble);
    wait(0.1);
  }

  self.turret turretfiredisable();
}

monitoraltitude(param_00, param_01) {
  param_01 endon("end_remote");
  param_01 endon("death");
  self endon("death");
  level endon("game_ended");
  self setclientomnvar("ui_a10_alt_warn", 0);
  for(;;) {
    var_02 = int(clamp(param_01.origin[2], 0, 16383));
    self setclientomnvar("ui_a10_alt", var_02);
    if(var_02 <= 1000 && !isDefined(param_01.altwarning)) {
      param_01.altwarning = 1;
      self setclientomnvar("ui_a10_alt_warn", 1);
    } else if(var_02 > 1000 && isDefined(param_01.altwarning)) {
      param_01.altwarning = undefined;
      self setclientomnvar("ui_a10_alt_warn", 0);
    }

    wait(0.1);
  }
}

watchintrocleared(param_00, param_01) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("intro_cleared");
  thread monitoraltitude(param_00, param_01);
  thread monitorrocketfire2(param_00, param_01);
  thread monitorweaponfire(param_00, param_01);
  thread watchroundend(param_01, param_00);
  self thermalvisionfofoverlayon();
  thread watchearlyexit(param_01);
}

watchroundend(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("leaving");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level scripts\engine\utility::waittill_any_3("round_end_finished", "game_ended");
  param_00 thread endflyby(param_01);
  endstrafesequence(param_01);
  a10_explode();
}

buildallflightpathsdefault() {
  var_00 = [];
  var_00[0] = 1;
  var_00[1] = 2;
  var_00[2] = 3;
  var_00[3] = 4;
  var_00[4] = 1;
  var_00[5] = 2;
  var_00[6] = 4;
  var_00[7] = 3;
  var_01 = [];
  var_01[0] = 2;
  var_01[1] = 1;
  var_01[2] = 4;
  var_01[3] = 3;
  var_01[4] = 1;
  var_01[5] = 4;
  var_01[6] = 3;
  var_01[7] = 2;
  buildallflightpaths(var_00, var_01);
}

buildallflightpaths(param_00, param_01) {
  level.a10splinesin = param_00;
  level.a10splinesout = param_01;
}

a10_cockpit_breathing() {
  level endon("remove_player_control");
  wait(randomfloatrange(3, 7));
}

watchearlyexit(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("a10_end_strafe");
  param_00 thread scripts\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
  param_00 waittill("killstreakExit");
  self notify("end_remote");
  param_00 thread endflyby(param_00.streakname);
  endstrafesequence(param_00.streakname);
  param_00 a10_explode();
}

a10_handledamage() {
  self endon("end_remote");
  var_00 = level.planeconfigs[self.streakname];
  scripts\mp\damage::monitordamage(var_00.maxhealth, "helicopter", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\damage::handleempdamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handlemissiledamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

handledeathdamage(param_00, param_01, param_02, param_03) {
  var_04 = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled("a10", param_00, param_01, param_02, param_03, var_04.scorepopup, var_04.vodestroyed, var_04.callout);
  a10_explode();
}

a10_explode() {
  var_00 = level.planeconfigs[self.streakname];
  scripts\mp\killstreaks\_plane::stoptrackingplane(self);
  playFX(var_00.explodevfx, self.origin);
  self delete();
}