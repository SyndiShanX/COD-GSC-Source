/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42933.gsc
**************************************/

init() {
  if(getdvarint("virtuallobbyactive", 0)) {
    return;
  }
  level.helis = [];
  level.littlebirds = [];
  level.heli_leave_nodes = getentorstructarray("heli_leave", "targetname");
  level.heli_crash_nodes = getentorstructarray("heli_crash_start", "targetname");
  level.chopper_fx["explode"]["death"] = [];
  level.chopper_fx["explode"]["air_death"] = [];
  level.chopper_fx["damage"]["light_smoke"] = loadfx("vfx/trail/smoke_trail_white_heli_emitter");
  level.chopper_fx["damage"]["heavy_smoke"] = loadfx("vfx/trail/smoke_trail_black_heli_emitter");
  level.chopper_fx["damage"]["on_fire"] = loadfx("vfx/fire/helicopter_damaged_fire_m");
  level.chopper_fx["explode"]["large"] = loadfx("fx/explosions/helicopter_explosion_secondary_small");
  level.chopper_fx["rocketlaunch"]["warbird"] = loadfx("vfx/muzzleflash/rocket_launch_air_to_ground");
  level.heli_sound["allies"]["hit"] = "warbird_death_explo";
  level.heli_sound["axis"]["hit"] = "warbird_death_explo";
  level.heli_sound["allies"]["spinloop"] = "warbird_death_spin_loop";
  level.heli_sound["axis"]["spinloop"] = "warbird_death_spin_loop";
  level.heli_sound["allies"]["crash"] = "warbird_air_death";
  level.heli_sound["axis"]["crash"] = "warbird_air_death";
  level._effect["flare"] = loadfx("vfx/lensflare/flares_warbird");
  level.heli_attract_strength = 1000;
  level.heli_attract_range = 4096;
  level.heli_maxhealth = 2000;
  level.heli_targeting_delay = 0.5;
}

makehelitype(var_0, var_1, var_2) {
  level.chopper_fx["explode"]["death"][var_0] = loadfx(var_1);
  level.lightfxfunc[var_0] = var_2;
}

addairexplosion(var_0, var_1) {
  level.chopper_fx["explode"]["air_death"][var_0] = loadfx(var_1);
}

addtohelilist() {
  level.helis[self getentitynumber()] = self;
}

removefromhelilist(var_0) {
  level.helis[var_0] = undefined;
}

addtolittlebirdlist(var_0) {
  level.littlebirds[self getentitynumber()] = self;
}

removefromlittlebirdlistondeath(var_0) {
  var_1 = self getentitynumber();
  self waittill("death");
  level.littlebirds[var_1] = undefined;
}

exceededmaxlittlebirds(var_0) {
  if(level.littlebirds.size >= 4) {
    return 1;
  } else {
    return 0;
  }
}

heli_leave_on_disconnect(var_0) {
  self endon("death");
  self endon("helicopter_done");
  var_0 waittill("disconnect");
  thread heli_leave();
}

heli_leave_on_changeteams(var_0) {
  self endon("death");
  self endon("helicopter_done");
  var_0 common_scripts\utility::waittill_any("joined_team", "joined_spectators");
  thread heli_leave();
}

heli_modifydamage(var_0, var_1, var_2, var_3) {
  var_4 = maps\mp\gametypes\_damage::modifydamage(var_0, var_1, var_2, var_3);

  if(var_4 > 0) {
    heli_staticdamage(var_1, var_2, var_4);
  }

  return var_4;
}

heli_addrecentdamage(var_0) {
  self endon("death");
  self.recentdamageamount = self.recentdamageamount + var_0;
  wait 4.0;
  self.recentdamageamount = self.recentdamageamount - var_0;
}

heli_leave_on_timeout(var_0) {
  self endon("death");
  self endon("helicopter_done");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread heli_leave();
}

heli_leave_on_gameended(var_0) {
  self endon("death");
  self endon("helicopter_done");
  level waittill("game_ended");
  thread heli_leave();
}

heli_leave(var_0) {
  self notify("leaving");
  self.isleaving = 1;
  self clearlookatent();
  var_1 = undefined;

  if(!isDefined(var_0)) {
    var_1 = heli_pick_fly_node(level.heli_leave_nodes);
    var_0 = var_1.origin;
  }

  var_2 = spawn("script_origin", var_0);

  if(isDefined(var_2)) {
    self setlookatent(var_2);
    var_2 thread wait_and_delete(3.0);
  }

  heli_reset();
  self vehicle_setspeed(100, 45);

  if(isDefined(var_1)) {
    if(isDefined(var_1.target)) {
      heli_fly_simple_path(var_1);
    } else {
      _setvehgoalpos(var_1.origin, 0);
      self waittillmatch("goal");
    }
  } else {
    _setvehgoalpos(var_0, 0);
    self waittillmatch("goal");
  }

  self notify("death");
  wait 0.05;

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  maps\mp\_utility::decrementfauxvehiclecount();
  self delete();
}

heli_pick_fly_node(var_0) {
  var_1 = self.origin;
  var_2 = undefined;

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6].origin;

    if(flynodeorgtracepassed(var_1, var_7, self)) {
      var_8 = var_7 - var_1;
      var_9 = distance(var_1, var_7);
      var_10 = rotatevector(var_8, (0, 90, 0));
      var_11 = var_1 + var_10 * 100;
      var_12 = var_11 + var_8 * var_9;

      if(flynodeorgtracepassed(var_11, var_12, self)) {
        var_13 = rotatevector(var_8, (0, -90, 0));
        var_11 = var_1 + var_13 * 100;
        var_12 = var_11 + var_8 * var_9;

        if(flynodeorgtracepassed(var_11, var_12, self)) {
          return var_0[var_6];
        }
      }
    }
  }

  return var_0[randomint(var_0.size)];
}

flynodeorgtracepassed(var_0, var_1, var_2) {
  var_3 = bulletTrace(var_0, var_1, 0, var_2, 0, 0, 1, 0, 0);
  var_4 = var_3["fraction"] >= 1;
}

wait_and_delete(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self delete();
}

deleteaftertime(var_0) {
  wait(var_0);
  self delete();
}

heli_reset() {
  self cleartargetyaw();
  self cleargoalyaw();
  self vehicle_setspeed(60, 25);
  self setyawspeed(100, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(100);
  self setturningability(1.0);
}

_setvehgoalpos(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self setvehgoalpos(var_0, var_1);
}

heli_flares_monitor(var_0) {
  switch (self.helitype) {
    default:
      self.numflares = 1;
      break;
  }

  if(isDefined(var_0)) {
    self.numflares = self.numflares + var_0;
  }

  thread handleincomingstinger();
}

handleincomingstinger(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("stinger_fired", var_1, var_2);

    if(!maps\mp\_stingerm7::anystingermissilelockedon(var_2, self)) {
      continue;
    }
    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_0)) {
      level thread[[var_0]](var_2, var_1, var_1.team);
      continue;
    }

    level thread watchmissileproximity(var_2, var_1, var_1.team);
  }
}

watchmissileproximity(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 thread missilewatchproximity(var_1, var_2, var_4.lockedstingertarget);
  }
}

missilewatchproximity(var_0, var_1, var_2) {
  self endon("death");
  var_2 endon("death");
  var_3 = 5.0;
  var_4 = 4000;

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_5 = var_2 getpointinbounds(0, 0, 0);
    var_6 = distance(self.origin, var_5);

    if(isDefined(var_2.player)) {
      var_2.player thread doproximityalarm(self, var_2);
    }

    if(var_6 < var_4) {
      if(var_2.numflares > 0 || isDefined(var_2.flarestarget)) {
        if(isDefined(var_2.owner) && iswarbird(var_2)) {
          if(var_2.numflares == 2) {
            var_2.owner setclientomnvar("ui_warbird_flares", 1);
          } else if(var_2.numflares == 1) {
            var_2.owner setclientomnvar("ui_warbird_flares", 2);
          }

          var_2.owner playlocalsound("paladin_deploy_flares");
        }

        var_7 = var_2 deployflares(var_3);
        playFXOnTag(common_scripts\utility::getfx("flare"), var_7, "tag_origin");

        if(!isDefined(var_2.flarestarget)) {
          var_2.numflares--;
          level thread handleflarestimer(var_2, var_7, var_3);
        }

        self missile_settargetent(var_7);
        return;
      }
    }

    wait 0.05;
  }
}

deployflares(var_0) {
  var_1 = self gettagorigin("tag_origin") + (0, 0, -50);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin");
  var_2.angles = self.angles;

  if(!isDefined(self.flaresdeployedyaw)) {
    self.flaresdeployedyaw = randomfloatrange(-180, 180);
  } else {
    self.flaresdeployedyaw = self.flaresdeployedyaw + 90;
  }

  var_3 = anglesToForward((self.angles[0], self.flaresdeployedyaw, self.angles[2]));
  var_3 = vehiclemodifyflarevector(var_3);
  var_2 movegravity(var_3, var_0);
  var_2 thread deleteaftertime(var_0);
  return var_2;
}

vehiclemodifyflarevector(var_0) {
  if(self.vehicletype == "warbird") {
    return vectornormalize(var_0 + (0, 0, -0.2)) * 300;
  } else if(self.vehicletype == "paladin") {
    return vectornormalize(var_0 + (0, 0, -0.5)) * 2000;
  } else {
    return vectornormalize(var_0 + (0, 0, -0.4)) * 1000;
  }
}

handleflarestimer(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0.flarestarget = var_1;
  wait(var_2);
  var_0.flarestarget = undefined;

  if(isDefined(var_0.owner) && iswarbird(var_0)) {
    var_0.owner setclientomnvar("ui_warbird_flares", 0);
  }
}

hastag(var_0, var_1) {
  var_2 = getnumparts(var_0);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(tolower(getpartname(var_0, var_3)) == tolower(var_1)) {
      return 1;
    }
  }

  return 0;
}

iswarbird(var_0) {
  return isDefined(var_0.heli_type) && var_0.heli_type == "warbird";
}

doproximityalarm(var_0, var_1) {
  self endon("disconnect");

  if(shouldstopproximityalarm(var_0, var_1) || isDefined(var_1.incomingmissilesound)) {
    return;
  }
  if(iswarbird(var_1)) {
    self setclientomnvar("ui_warbird_flares", 3);
  }

  self playlocalsound("mp_aerial_enemy_locked");
  var_1.incomingmissilesound = 1;

  for(;;) {
    if(shouldstopproximityalarm(var_0, var_1)) {
      self stoplocalsound("mp_aerial_enemy_locked");
      var_1.incomingmissilesound = undefined;
      return;
    }

    waitframe();
  }
}

playerfakeshootpaintmissile(var_0) {
  var_1 = vectornormalize(anglesToForward(self getangles()));
  var_2 = vectornormalize(anglestoright(self getangles()));
  var_3 = self getEye() + var_1 * 100;
  var_4 = var_3 + var_1 * 20000;
  var_5 = bulletTrace(var_3, var_4, 0);

  if(var_5["fraction"] == 1) {
    return;
  }
  earthquake(0.1, 1, self getEye(), 500, self);
  var_3 = self getEye() + var_2 * -1 * 50;
  var_4 = var_5["position"];
  var_6 = magicbullet("paint_missile_killstreak_mp", var_3, var_4, self);
  var_6.owner = self;
  var_6 thread watchpaintgrenade();
  thread playerfiresounds(var_0, "paladin_threat_bomb_shot_2d", "paladin_threat_bomb_shot_3d");
}

playerfakeshootpaintgrenadeattarget(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 5000;
  earthquake(0.2, 1, self getvieworigin(), 300);
  var_6 = vectornormalize(var_2 - var_1);
  var_7 = var_6 * var_5;
  var_8 = magicgrenademanual("paint_grenade_killstreak_mp", var_1, var_7, 2, self);
  var_8.owner = self;
  var_8 thread watchpaintgrenade(var_3, var_4);
  thread playerfiresounds(var_0, "recon_drn_launcher_shot_plr", "recon_drn_launcher_shot_npc");
  self playrumbleonentity("damage_heavy");
}

playerfakeshootempgrenadeattarget(var_0, var_1, var_2) {
  var_3 = 5000;
  earthquake(0.2, 1, self getvieworigin(), 300);
  var_4 = vectornormalize(var_2 - var_1);
  var_5 = var_4 * var_3;
  var_6 = magicgrenademanual("emp_grenade_killstreak_mp", var_1, var_5, 2, self);
  var_6.owner = self;
  thread playerfiresounds(var_0, "recon_drn_launcher_shot_plr", "recon_drn_launcher_shot_npc");
  self playrumbleonentity("damage_heavy");
}

playerfiresounds(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_0 playsoundonmovingent(var_2);
  }

  if(isDefined(var_1)) {
    self playlocalsound(var_1);
  }
}

watchpaintgrenade(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_2 = self.owner;
  var_2 endon("disconnect");
  var_2 endon("death");
  self waittill("explode", var_3);

  if(var_2 maps\mp\_utility::isemped() && isDefined(level.empequipmentdisabled) && level.empequipmentdisabled) {
    return;
  }
  detectiongrenadethink(var_3, var_2, var_0, var_1);
}

detectiongrenadethink(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  foreach(var_5 in level.players) {
    if(!isDefined(var_5) || !maps\mp\_utility::isreallyalive(var_5) || !isalliedsentient(var_1, var_5)) {
      continue;
    }
    thread maps\mp\_threatdetection::detection_grenade_hud_effect(var_5, var_0, 1.0, 400);
    thread maps\mp\_threatdetection::detection_highlight_hud_effect(var_5, 5);
  }

  var_7 = getplayersonteam(var_1.team);

  foreach(var_5 in level.participants) {
    if(!isDefined(var_5) || !maps\mp\_utility::isreallyalive(var_5) || isalliedsentient(var_1, var_5) || var_5 maps\mp\_utility::_hasperk("specialty_coldblooded")) {
      continue;
    }
    if(distance(var_5.origin, var_0) < 400) {
      var_5 maps\mp\_threatdetection::addthreatevent(var_7, 5, "PAINT_GRENADE", 1, 0);
      var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("paint");
      var_5 thread detectiongrenadewatch(var_1, 5);
      var_5 notify("paint_marked_target", var_1);

      if(var_2) {
        maps\mp\gametypes\_weapons::flashbangplayer(var_5, var_0, var_1);
      }

      if(isDefined(var_3) && var_3.vehname == "recon_uav") {
        var_1 maps\mp\gametypes\_missions::processchallenge("ch_streak_recon");
      }
    }
  }
}

detectiongrenadewatch(var_0, var_1) {
  level endon("game_ended");
  self notify("detectionGrenadeWatch");
  self endon("detectionGrenadeWatch");

  if(!isDefined(self.tagmarkedby) || self.tagmarkedby != var_0) {
    if(!isDefined(level.ishorde)) {
      var_0 thread maps\mp\_events::killstreaktagevent();
    }

    var_0 playrumbleonentity("damage_heavy");
  }

  if(!isagent(self)) {
    self designatefoftarget(1);
  }

  self.tagmarkedby = var_0;
  common_scripts\utility::waittill_any_timeout(var_1, "death", "disconnect");

  if(isDefined(self)) {
    if(!isagent(self)) {
      self designatefoftarget(0);
    }

    self.tagmarkedby = undefined;
  }
}

getplayersonteam(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.hasspawned && isalive(var_3) && var_0 == var_3.team && (!isplayer(self) || var_3 != self)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

shouldstopproximityalarm(var_0, var_1) {
  return !isDefined(var_1) || !isDefined(var_1.player) || !isDefined(var_0) || isDefined(var_1.flarestarget) || !maps\mp\_utility::isreallyalive(self) || isDefined(var_1.crashed) || isDefined(var_1.iscrashing);
}

heli_staticdamage(var_0, var_1, var_2) {
  if(var_2 > 0 && isDefined(self.owner)) {
    self.owner thread playershowstreakstaticfordamage();
  }

  if(var_2 > 0 && isDefined(self.warbirdbuddyturret) && isDefined(self.warbirdbuddyturret.owner)) {
    self.warbirdbuddyturret.owner thread playershowstreakstaticfordamage();
  }
}

heli_monitoremp() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for(;;) {
    self waittill("emp_damage");
    thread heli_empgrenaded();
  }
}

heli_empgrenaded() {
  self notify("heli_EMPGrenaded");
  self endon("heli_EMPGrenaded");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.empgrenaded = 1;

  if(isDefined(self.mgturretleft)) {
    self.mgturretleft notify("stop_shooting");
  }

  if(isDefined(self.mgturretright)) {
    self.mgturretright notify("stop_shooting");
  }

  wait 3.5;
  self.empgrenaded = 0;

  if(isDefined(self.mgturretleft)) {
    self.mgturretleft notify("turretstatechange");
  }

  if(isDefined(self.mgturretright)) {
    self.mgturretright notify("turretstatechange");
  }
}

heli_existance() {
  var_0 = self getentitynumber();
  common_scripts\utility::waittill_any("death", "crashing", "leaving");
  removefromhelilist(var_0);
  self notify("helicopter_done");
}

heli_crash() {
  self notify("crashing");
  self playsoundonmovingent("orbital_pkg_self_destruct");
  self clearlookatent();
  self.iscrashing = 1;
  var_0 = heli_pick_fly_node(level.heli_crash_nodes);

  if(isDefined(self.mgturretleft)) {
    self.mgturretleft notify("stop_shooting");
  }

  if(isDefined(self.mgturretright)) {
    self.mgturretright notify("stop_shooting");
  }

  thread heli_spin(180);
  thread heli_secondary_explosions();
  self vehicle_setspeed(100, 45);

  if(isDefined(var_0.target)) {
    heli_fly_simple_path(var_0);
  } else {
    _setvehgoalpos(var_0.origin, 0);
    self waittillmatch("goal");
  }

  thread heli_explode();
}

heli_secondary_explosions() {
  var_0 = self.team;
  playFXOnTag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");

  if(isDefined(level.heli_sound[var_0]["hitsecondary"])) {
    self playSound(level.heli_sound[var_0]["hitsecondary"]);
  }

  wait 3.0;

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");

  if(isDefined(level.heli_sound[var_0]["hitsecondary"])) {
    self playSound(level.heli_sound[var_0]["hitsecondary"]);
  }
}

heli_spin(var_0) {
  self endon("death");
  var_1 = self.team;
  self playSound(level.heli_sound[var_1]["hit"]);
  thread spinsoundshortly();
  self setyawspeed(var_0, var_0, var_0);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.9);
    wait 1;
  }
}

spinsoundshortly() {
  self endon("death");
  wait 0.25;
  var_0 = self.team;
  self stoploopsound();
  wait 0.05;
  self playLoopSound(level.heli_sound[var_0]["spinloop"]);
  wait 0.05;

  if(isDefined(level.heli_sound[var_0]["spinstart"])) {
    self playLoopSound(level.heli_sound[var_0]["spinstart"]);
  }
}

heli_explode(var_0) {
  self notify("death");

  if(isDefined(var_0) && isDefined(level.chopper_fx["explode"]["air_death"][self.heli_type])) {
    var_1 = self gettagangles("tag_deathfx");
    playFX(level.chopper_fx["explode"]["air_death"][self.heli_type], self gettagorigin("tag_deathfx"), anglesToForward(var_1), anglestoup(var_1));
  } else {
    var_2 = self.origin;
    var_3 = self.origin + (0, 0, 1) - self.origin;
    playFX(level.chopper_fx["explode"]["death"][self.heli_type], var_2, var_3);
  }

  var_4 = self.team;
  self playSound(level.heli_sound[var_4]["crash"]);
  wait 0.05;

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  maps\mp\_utility::decrementfauxvehiclecount();
  self delete();
}

heli_fly_simple_path(var_0) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  var_1 = var_0;

  while(isDefined(var_1.target)) {
    var_2 = getentorstruct(var_1.target, "targetname");

    if(isDefined(var_1.script_airspeed) && isDefined(var_1.script_accel)) {
      var_3 = var_1.script_airspeed;
      var_4 = var_1.script_accel;
    } else {
      var_3 = 30 + randomint(20);
      var_4 = 15 + randomint(15);
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      wait 0.05;
      continue;
    }

    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait 0.05;
      continue;
    }

    self vehicle_setspeed(var_3, var_4);

    if(!isDefined(var_2.target)) {
      _setvehgoalpos(var_2.origin + self.zoffset, 0);
      self waittill("near_goal");
    } else {
      _setvehgoalpos(var_2.origin + self.zoffset, 0);
      self waittill("near_goal");
      self setgoalyaw(var_2.angles[1]);
      self waittillmatch("goal");
    }

    var_1 = var_2;
  }
}

handle_player_starting_aerial_view() {
  self notify("player_start_aerial_view");
}

handle_player_ending_aerial_view() {
  self notify("player_stop_aerial_view");
}

gethelianchor() {
  if(isDefined(level.helianchor)) {
    return level.helianchor;
  }

  var_0 = getentorstruct("warbird_anchor", "targetname");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = (0, 0, 2032);
    var_0.targetname = "warbird_anchor";
  }

  if(!isDefined(var_0.script_noteworthy)) {
    var_0.script_noteworthy = 3500;
  }

  level.helianchor = var_0;
  return level.helianchor;
}

playerhandleboundarystatic(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  var_3 = getEntArray("remote_heli_range", "targetname");

  if(!isDefined(var_0.vehicletype) || var_3.size == 0) {
    playerhandleboundarystaticradius(var_0, var_1, var_2);
    return;
  }

  for(;;) {
    var_4 = 0;

    if(isDefined(level.isoutofboundscustomfunc)) {
      var_4 = [[level.isoutofboundscustomfunc]](var_0, self, var_3);
    } else {
      var_4 = var_0 vehicletouchinganytrigger(var_3);
    }

    if(var_4) {
      thread playerstartoutofboundsstatic(var_0, var_1, var_2);

      for(;;) {
        waitframe();

        if(!isDefined(var_0.alwaysstaticout) || !var_0.alwaysstaticout) {
          var_4 = 0;

          if(isDefined(level.isoutofboundscustomfunc)) {
            var_4 = [
              }
              [level.isoutofboundscustomfunc]
          ](var_0, self, var_3);
          else {
            var_4 = var_0 vehicletouchinganytrigger(var_3);
          }

          if(!var_4) {
            var_0 notify("staticDone");
            thread playerstatictonormal(var_0, var_1, var_2);
            break;
          }
        }
      }
    }

    waitframe();
  }
}

vehicletouchinganytrigger(var_0) {
  foreach(var_2 in var_0) {
    if(self istouching(var_2)) {
      return 1;
    }
  }

  return 0;
}

playerstatictonormal(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  var_0 endon("staticStarting");

  for(var_0.staticlevel--; var_0.staticlevel > 0; var_0.staticlevel--) {
    playershowstreakstaticforrange(var_0.staticlevel);

    if(isDefined(var_0.buddy)) {
      var_0.buddy playershowstreakstaticforrange(var_0.staticlevel);
    }

    wait 0.5;
  }

  playershowstreakstaticforrange(0);

  if(isDefined(var_0.buddy)) {
    var_0.buddy playershowstreakstaticforrange(0);
  }
}

playerstartoutofboundsstatic(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  var_0 notify("staticStarting");
  var_0 endon("staticDone");

  if(!isDefined(var_0.staticlevel) || var_0.staticlevel == 0) {
    var_0.staticlevel = 1;
  }

  while(var_0.staticlevel < 4) {
    playershowstreakstaticforrange(var_0.staticlevel);

    if(isDefined(var_0.buddy)) {
      var_0.buddy playershowstreakstaticforrange(var_0.staticlevel);
    }

    if(isDefined(var_0.playerattachpoint)) {
      var_0.playerattachpoint playSound("mp_warbird_outofbounds_warning");
    }

    if(isDefined(var_0.staticlevelwaittime)) {
      wait(var_0.staticlevelwaittime);
    } else {
      wait 2;
    }

    var_0.staticlevel++;
  }

  var_0 notify("outOfBounds");
}

playerhandleboundarystaticradius(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  var_3 = gethelianchor();
  var_4 = int(var_3.script_noteworthy);

  for(;;) {
    var_5 = distance(var_3.origin, var_0.origin);

    if(var_5 < var_4) {
      playershowstreakstaticforrange(0);
    } else if(var_5 > var_4 && var_5 < var_4 + 500) {
      playershowstreakstaticforrange(1);

      if(isDefined(var_0.playerattachpoint)) {
        var_0.playerattachpoint playSound("mp_warbird_outofbounds_warning");
      }
    } else if(var_5 > var_4 + 500 && var_5 < var_4 + 1000) {
      playershowstreakstaticforrange(2);

      if(isDefined(var_0.playerattachpoint)) {
        var_0.playerattachpoint playSound("mp_warbird_outofbounds_warning");
      }
    } else if(var_5 > var_4 + 1000 && var_5 < var_4 + 1500) {
      playershowstreakstaticforrange(3);

      if(isDefined(var_0.playerattachpoint)) {
        var_0.playerattachpoint playSound("mp_warbird_outofbounds_warning");
      }
    } else {
      playershowstreakstaticforrange(4);
      var_0 notify("outOfBounds");
    }

    wait 0.5;
  }
}

playerenablestreakstatic() {
  self notify("playerUpdateStreakStatic");
  self setclientomnvar("ui_streak_overlay_state", 1);
}

playerdisablestreakstatic() {
  self notify("playerUpdateStreakStatic");
  self setclientomnvar("ui_streak_overlay_state", 0);
}

playershowfullstatic() {
  self notify("playerUpdateStreakStatic");
  self setclientomnvar("ui_streak_overlay_state", 7);
}

playershowstreakstaticfordamage() {
  self endon("disconnect");

  if(self getclientomnvar("ui_streak_overlay_state") != 1) {
    return;
  }
  self notify("playerUpdateStreakStatic");
  self endon("playerUpdateStreakStatic");
  self setclientomnvar("ui_streak_overlay_state", 2);
  wait 1;
  self setclientomnvar("ui_streak_overlay_state", 1);
}

playershowstreakstaticforrange(var_0) {
  var_1 = 1;

  switch (var_0) {
    case 0:
      var_1 = 1;
      break;
    case 1:
      var_1 = 3;
      break;
    case 2:
      var_1 = 4;
      break;
    case 3:
      var_1 = 5;
      break;
    case 4:
      var_1 = 6;
      break;
    default:
  }

  self notify("playerUpdateStreakStatic");
  self setclientomnvar("ui_streak_overlay_state", var_1);
}

getentorstruct(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  }

  return common_scripts\utility::getstruct(var_0, var_1);
}

getentorstructarray(var_0, var_1) {
  var_2 = common_scripts\utility::getstructarray(var_0, var_1);
  var_3 = getEntArray(var_0, var_1);

  if(var_3.size > 0) {
    var_2 = common_scripts\utility::array_combine(var_2, var_3);
  }

  return var_2;
}

playerhandlekillvehicle(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(!isDefined(level.vehicle_kill_triggers)) {
    return;
  }
  for(;;) {
    var_3 = var_0 vehicletouchinganytrigger(level.vehicle_kill_triggers);

    if(var_3) {
      var_0 notify("death");
    }

    waitframe();
  }
}

setup_kill_drone_trig(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    common_scripts\utility::array_thread(var_2, ::setup_kill_drone_trig_proc);
  } else if(isvehiclekilltrigger()) {
    setup_kill_drone_trig_proc();
  }
}

setup_kill_drone_trig_proc() {
  if(isvehiclekilltrigger()) {
    if(!isDefined(level.vehicle_kill_triggers)) {
      level.vehicle_kill_triggers = [];
    }

    level.vehicle_kill_triggers[level.vehicle_kill_triggers.size] = self;
  }
}

isvehiclekilltrigger() {
  if(isDefined(self.classname) && issubstr(self.classname, "trigger_multiple") && isDefined(self.spawnflags) && self.spawnflags & 16) {
    return 1;
  }

  return 0;
}

vehicleiscloaked() {
  return isDefined(self.cloakstate) && self.cloakstate < 1;
}

thermalvision(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon(var_0);
  var_7 = 0;
  disableorbitalthermal(self);
  self visionsetthermalforplayer("default", 0.25);
  self setclientomnvar("ui_killstreak_optic", 0);

  if(isbot(self)) {
    return;
  }
  self notifyonplayercommand("switch thermal", "+actionslot 1");
  thread playercleanupthermalvisioncommands(var_0);

  for(;;) {
    self waittill("switch thermal");

    if(!var_7) {
      enableorbitalthermal(self, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      self setclientomnvar("ui_killstreak_optic", 1);
      self playlocalsound("paladin_toggle_flir_plr");
    } else {
      disableorbitalthermal(self);
      self setclientomnvar("ui_killstreak_optic", 0);
      self playlocalsound("paladin_toggle_flir_plr");
    }

    var_7 = !var_7;
  }
}

playercleanupthermalvisioncommands(var_0) {
  self endon("disconnect");
  self waittill(var_0);
  self notifyonplayercommandremove("switch thermal", "+actionslot 1");
}

disableorbitalthermal(var_0) {
  var_0 thermalvisionoff();
  var_0 notify("thermal_vision_off");
  var_0 disablephysicaldepthoffieldscripting();
  var_0.orbitalthermalmode = 0;
}

enableorbitalthermal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("faux_spawn");
  var_0 endon(var_1);

  if(!isDefined(var_0.opticsthermalenabled)) {
    var_0.opticsthermalenabled = 0;
  }

  if(!isDefined(var_0.orbitalthermalmode)) {
    var_0.orbitalthermalmode = 0;
  }

  var_0.orbitalthermalmode = 1;

  while(var_0.opticsthermalenabled) {
    wait 0.05;
  }

  var_0 thermalvisionon();
  var_0 enablephysicaldepthoffieldscripting(3);
  var_0 thread setthermaldof(var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

setthermaldof(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon(var_0);
  self endon("disconnect");
  self endon("thermal_vision_off");

  for(;;) {
    var_7 = self playerads();
    var_8 = float_lerp(var_3, var_1, var_7);
    var_9 = float_lerp(var_4, var_2, var_7);
    self setphysicaldepthoffield(var_8, var_9, var_5, var_6);
    wait 0.1;
  }
}

float_lerp(var_0, var_1, var_2) {
  return var_0 + var_2 * (var_1 - var_0);
}

patchheliloopnode(var_0, var_1) {
  var_2 = [];
  var_3 = getentorstruct("heli_loop_start", "targetname");

  for(;;) {
    if(common_scripts\utility::array_contains(var_2, var_3)) {
      break;
    }

    if(var_3.origin == var_0) {
      var_3.origin = var_1;
      return;
    }

    var_2[var_2.size] = var_3;
    var_3 = getentorstruct(var_3.target, "targetname");
  }
}