/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42839.gsc
**************************************/

watchtrackingdroneusage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  if(!isDefined(level.trackingdronesettings)) {
    trackingdroneinit();
  }

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "tracking_drone_mp") {
      var_0 thread destroy_tracking_drone_in_water();
      wait 0.5;

      if(!isremovedentity(var_0) && isDefined(var_0)) {
        self.trackingdronestartposition = var_0.origin;
        self.trackingdronestartangles = var_0.angles;
        var_0 deletetrackingdrone();

        if(!prevent_tracking_drone_in_water(self.trackingdronestartposition)) {
          tryusetrackingdrone(var_1);
        }
      }
    }
  }
}

trackingdroneinit() {
  level.trackingdronemaxperplayer = 1;
  level.trackingdronesettings = spawnStruct();
  level.trackingdronesettings.timeout = 20.0;
  level.trackingdronesettings.explosivetimeout = 30.0;
  level.trackingdronesettings.health = 999999;
  level.trackingdronesettings.maxhealth = 60;
  level.trackingdronesettings.vehicleinfo = "vehicle_tracking_drone_mp";
  level.trackingdronesettings.modelbase = "npc_drone_tracking";
  level.trackingdronesettings.fxid_sparks = loadfx("vfx/sparks/direct_hack_stun");
  level.trackingdronesettings.fxid_laser_glow = loadfx("vfx/lights/tracking_drone_laser_blue");
  level.trackingdronesettings.fxid_explode = loadfx("vfx/explosion/tracking_drone_explosion");
  level.trackingdronesettings.fxid_lethalexplode = loadfx("vfx/explosion/frag_grenade_default");
  level.trackingdronesettings.fxid_warning = loadfx("vfx/lights/light_tracking_drone_blink_warning");
  level.trackingdronesettings.fxid_enemy_light = loadfx("vfx/lights/light_tracking_drone_blink_enemy");
  level.trackingdronesettings.fxid_friendly_light = loadfx("vfx/lights/light_tracking_drone_blink_friendly");
  level.trackingdronesettings.fxid_thruster_down = loadfx("vfx/distortion/tracking_drone_distortion_down");
  level.trackingdronesettings.fxid_thruster_up = loadfx("vfx/distortion/tracking_drone_distortion_up");
  level.trackingdronesettings.fxid_engine_distort = loadfx("vfx/distortion/tracking_drone_distortion_hemi");
  level.trackingdronesettings.sound_explode = "veh_tracking_drone_explode";
  level.trackingdronesettings.sound_lock = "veh_tracking_drone_lock_lp";
  level.trackingdrones = [];

  foreach(var_1 in level.players) {
    var_1.is_being_tracked = 0;
  }

  level thread ontrackingplayerconnect();
  level.trackingdronetimeout = level.trackingdronesettings.timeout;
  level.explosivedronetimeout = level.trackingdronesettings.explosivetimeout;
  level.trackingdronedebugposition = 0;
  level.trackingdronedebugpositionforward = 65;
  level.trackingdronedebugpositionheight = 0;
}

tryusetrackingdrone(var_0) {
  var_1 = 1;

  if(maps\mp\_utility::isusingremote()) {
    return 0;
  } else if(exceededmaxtrackingdrones()) {
    self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_1 >= maps\mp\_utility::maxvehiclesallowed()) {
    self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(!isDefined(self.trackingdronearray)) {
    self.trackingdronearray = [];
  }

  if(self.trackingdronearray.size) {
    self.trackingdronearray = common_scripts\utility::array_removeundefined(self.trackingdronearray);

    if(self.trackingdronearray.size >= level.trackingdronemaxperplayer) {
      if(isDefined(self.trackingdronearray[0])) {
        self.trackingdronearray[0] thread trackingdrone_leave();
      }
    }
  }

  maps\mp\_utility::incrementfauxvehiclecount();
  var_2 = createtrackingdrone(var_0);

  if(!isDefined(var_2)) {
    maps\mp\_utility::decrementfauxvehiclecount();
    return 0;
  }

  var_2.weaponname = var_0;
  self.trackingdronearray[self.trackingdronearray.size] = var_2;
  level.trackingdrones = common_scripts\utility::array_removeundefined(level.trackingdrones);
  level.trackingdrones[level.trackingdrones.size] = var_2;
  thread starttrackingdrone(var_2);
  return 1;
}

createtrackingdrone(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!var_1) {
    var_5 = self getEye();
    var_6 = anglesToForward(self getangles());
    var_7 = self getangles();
    var_6 = anglesToForward(var_7);
    var_8 = anglestoright(var_7);
    var_9 = var_6 * 50;
    var_10 = var_8 * 0;
    var_11 = 80;

    switch (self getstance()) {
      case "stand":
        var_11 = 80;
        break;
      case "crouch":
        var_11 = 65;
        break;
      case "prone":
        var_11 = 37;
        break;
    }

    var_12 = (0, 0, var_11);
    var_12 = var_12 + var_10;
    var_12 = var_12 + var_9;

    if(isDefined(self.trackingdronestartposition) && isDefined(self.trackingdronestartangles)) {
      var_13 = self.trackingdronestartposition;
      var_7 = self.trackingdronestartangles;
    } else {
      var_13 = self.origin + var_12;
    }
  } else {
    var_13 = var_2;
    var_14 = var_2;
    var_7 = var_3;
  }

  var_15 = self;

  if(isDefined(level.ishorde) && level.ishorde) {
    var_15 = level.player;
  }

  var_16 = spawnhelicopter(var_15, var_13, var_7, level.trackingdronesettings.vehicleinfo, level.trackingdronesettings.modelbase);

  if(!isDefined(var_16)) {
    return;
  }
  if(isDefined(var_4)) {
    var_16.type = "explosive_drone";
    var_16 setModel("vehicle_pdrone");
  } else {
    var_16.type = "tracking_drone";
  }

  var_16 common_scripts\utility::make_entity_sentient_mp(self.team);
  var_16 makevehiclenotcollidewithplayers(1);
  var_16 addtotrackingdronelist();
  var_16 thread removefromtrackingdronelistondeath();
  var_16.health = level.trackingdronesettings.health;
  var_16.maxhealth = level.trackingdronesettings.maxhealth;
  var_16.damagetaken = 0;
  var_16.speed = 20;
  var_16.followspeed = 20;
  var_16.owner = self;
  var_16.team = self.team;
  var_16 vehicle_setspeed(var_16.speed, 10, 10);
  var_16 setyawspeed(120, 90);
  var_16 setneargoalnotifydist(64);
  var_16 sethoverparams(4, 5, 5);
  var_16.fx_tag0 = undefined;

  if(isDefined(var_16.type)) {
    if(var_16.type == "tracking_drone") {
      var_16.fx_tag0 = "fx_joint_0";
    } else if(var_16.type == "explosive_drone") {
      var_16.fx_tag0 = "TAG_EYE";
    }
  }

  if(level.teambased) {
    var_16 maps\mp\_entityheadicons::setteamheadicon(self.team, (0, 0, 25), var_16.fx_tag0);
  } else {
    var_16 maps\mp\_entityheadicons::setplayerheadicon(self.owner, (0, 0, 25), var_16.fx_tag0);
  }

  var_16.maxtrackingrange = 2000;
  var_16.maxlaserrange = 300;
  var_16.trackedplayer = undefined;
  var_17 = 45;
  var_18 = 45;
  var_16 setmaxpitchroll(var_17, var_18);
  var_16.targetpos = var_13;
  var_16.attract_strength = 10000;
  var_16.attract_range = 150;
  var_16.attractor = missile_createattractorent(var_16, var_16.attract_strength, var_16.attract_range);
  var_16.hasdodged = 0;
  var_16.stunned = 0;
  var_16.inactive = 0;
  var_16 thread maps\mp\gametypes\_damage::setentitydamagecallback(var_16.maxhealth, undefined, ::ontrackingdronedeath, undefined, 0);
  var_16 thread trackingdrone_watchdisable();
  var_16 thread trackingdrone_watchdeath();
  var_16 thread trackingdrone_watchownerloss();
  var_16 thread trackingdrone_watchownerdeath();
  var_16 thread trackingdrone_watchroundend();
  var_16 thread trackingdrone_watchhostmigration();

  if(!isDefined(level.ishorde)) {
    var_16 thread trackingdrone_watchtimeout();
  }

  if(var_16.type == "tracking_drone") {
    var_16 thread trackingdrone_enemy_lightfx();
    var_16 thread trackingdrone_friendly_lightfx();
    var_16 thread drone_thrusterfx();
  }

  return var_16;
}

idletargetmover(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_1 = anglesToForward(self.angles);

  for(;;) {
    if(maps\mp\_utility::isreallyalive(self) && !maps\mp\_utility::isusingremote() && anglesToForward(self.angles) != var_1) {
      var_1 = anglesToForward(self.angles);
      var_2 = self.origin + var_1 * -100 + (0, 0, 40);
      var_0 moveto(var_2, 0.5);
    }

    wait 0.5;
  }
}

trackingdrone_lightfx(var_0, var_1) {
  var_1 endon("disconnect");
  playfxontagforclients(var_0, self, "fx_light_1", var_1);
  wait 0.05;
  playfxontagforclients(var_0, self, "fx_light_2", var_1);
  wait 0.05;
  playfxontagforclients(var_0, self, "fx_light_3", var_1);
  wait 0.05;
  playfxontagforclients(var_0, self, "fx_light_4", var_1);
}

trackingdrone_enemy_lightfx() {
  self endon("death");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && issentient(var_1) && issentient(self) && var_1.team != self.team) {
      childthread trackingdrone_lightfx(level.trackingdronesettings.fxid_enemy_light, var_1);
      wait 0.2;
    }
  }
}

trackingdrone_friendly_lightfx() {
  self endon("death");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && issentient(var_1) && issentient(self) && var_1.team == self.team) {
      childthread trackingdrone_lightfx(level.trackingdronesettings.fxid_friendly_light, var_1);
      wait 0.2;
    }
  }

  thread watchconnectedplayFX();
  thread watchjoinedteamplayFX();
}

drone_thrusterfx() {
  self endon("death");

  foreach(var_1 in level.players) {
    wait 0.1;

    if(isDefined(var_1) && isDefined(self) && isDefined(level.trackingdronesettings.fxid_thruster_down)) {
      playfxontagforclients(level.trackingdronesettings.fxid_thruster_down, self, "fx_thruster_down_F", var_1);
    }

    wait 0.1;

    if(isDefined(var_1) && isDefined(self) && isDefined(level.trackingdronesettings.fxid_thruster_down)) {
      playfxontagforclients(level.trackingdronesettings.fxid_thruster_down, self, "fx_thruster_down_K", var_1);
    }

    wait 0.1;

    if(isDefined(var_1) && isDefined(self) && isDefined(level.trackingdronesettings.fxid_thruster_down)) {
      playfxontagforclients(level.trackingdronesettings.fxid_thruster_down, self, "fx_thruster_down_L", var_1);
    }

    wait 0.1;

    if(isDefined(var_1) && isDefined(self) && isDefined(level.trackingdronesettings.fxid_thruster_down)) {
      playfxontagforclients(level.trackingdronesettings.fxid_thruster_down, self, "fx_thruster_down_R", var_1);
    }

    wait 0.1;

    if(isDefined(var_1) && isDefined(self) && isDefined(level.trackingdronesettings.fxid_engine_distort)) {
      playfxontagforclients(level.trackingdronesettings.fxid_engine_distort, self, "TAG_WEAPON", var_1);
    }

    wait 0.25;
  }

  for(;;) {
    level waittill("connected", var_1);
    var_1 waittill("spawned_player");
    wait 0.1;

    if(isDefined(var_1) && isDefined(self) && isDefined(level.trackingdronesettings.fxid_thruster_down)) {
      playfxontagforclients(level.trackingdronesettings.fxid_thruster_down, self, "fx_thruster_down_F", var_1);
    }

    wait 0.1;

    if(isDefined(var_1) && isDefined(self) && isDefined(level.trackingdronesettings.fxid_thruster_down)) {
      playfxontagforclients(level.trackingdronesettings.fxid_thruster_down, self, "fx_thruster_down_K", var_1);
    }

    wait 0.1;

    if(isDefined(var_1) && isDefined(self) && isDefined(level.trackingdronesettings.fxid_thruster_down)) {
      playfxontagforclients(level.trackingdronesettings.fxid_thruster_down, self, "fx_thruster_down_L", var_1);
    }

    wait 0.1;

    if(isDefined(var_1) && isDefined(self) && isDefined(level.trackingdronesettings.fxid_thruster_down)) {
      playfxontagforclients(level.trackingdronesettings.fxid_thruster_down, self, "fx_thruster_down_R", var_1);
    }

    wait 0.1;
    playfxontagforclients(level.trackingdronesettings.fxid_engine_distort, self, "TAG_WEAPON", var_1);
    wait 0.25;
  }
}

watchconnectedplayFX() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_0);
    var_0 waittill("spawned_player");

    if(isDefined(var_0) && var_0.team == self.team) {
      childthread trackingdrone_lightfx(level.trackingdronesettings.fxid_friendly_light, var_0);
      wait 0.2;
    }
  }
}

watchjoinedteamplayFX() {
  self endon("death");

  for(;;) {
    level waittill("joined_team", var_0);
    var_0 waittill("spawned_player");

    if(isDefined(var_0) && var_0.team == self.team) {
      childthread trackingdrone_lightfx(level.trackingdronesettings.fxid_friendly_light, var_0);
      wait 0.2;
    }
  }
}

starttrackingdrone(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 thread trackingdrone_followtarget();
  var_0 thread aud_drone_start_jets();

  if(isDefined(var_0.type)) {
    if(var_0.type == "explosive_drone") {
      var_0 thread checkforexplosivegoal();
    } else if(var_0.type == "tracking_drone" && !isDefined(level.ishorde)) {
      var_0 thread trackingdrone_highlighttarget();
    }
  }
}

checkforexplosivegoal() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");

  for(;;) {
    common_scripts\utility::waittill_any("goal", "near_goal", "hit_goal");

    if(self.trackedplayer != self.owner && maps\mp\_utility::isreallyalive(self.trackedplayer)) {
      var_0 = distancesquared(self.trackedplayer.origin, self.origin);

      if(var_0 <= 16384) {
        self notify("exploding");
        thread blowupdronesequence();
        break;
      }
    }
  }
}

blowupdronesequence() {
  var_0 = 2;
  var_1 = undefined;

  if(isDefined(self.owner)) {
    var_1 = self.owner;
  }

  if(isDefined(self)) {
    thread turnondangerlights();
    self playSound("drone_warning_beap");
  }

  wait(var_0);

  if(isDefined(self)) {
    self playSound("drone_bomb_explosion");
    var_2 = anglestoup(self.angles);
    var_3 = anglesToForward(self.angles);
    playFX(level.trackingdronesettings.fxid_lethalexplode, self.origin, var_3, var_2);

    if(isDefined(var_1)) {
      self radiusdamage(self.origin, 256, 1000, 25, var_1, "MOD_EXPLOSIVE", "killstreak_missile_strike_mp");
    } else {
      self radiusdamage(self.origin, 256, 1000, 25, undefined, "MOD_EXPLOSIVE", "killstreak_missile_strike_mp");
    }

    self notify("death");
  }
}

turnondangerlights() {
  if(isDefined(self)) {
    stopFXOnTag(level.trackingdronesettings.fxid_enemy_light, self, "tag_fx_beacon_0");
    stopFXOnTag(level.trackingdronesettings.fxid_enemy_light, self, "tag_fx_beacon_1");
    stopFXOnTag(level.trackingdronesettings.fxid_enemy_light, self, "tag_fx_beacon_2");
    stopFXOnTag(level.trackingdronesettings.fxid_friendly_light, self, "tag_fx_beacon_0");
    stopFXOnTag(level.trackingdronesettings.fxid_friendly_light, self, "tag_fx_beacon_1");
    stopFXOnTag(level.trackingdronesettings.fxid_friendly_light, self, "tag_fx_beacon_2");
  }

  wait 0.05;

  if(isDefined(self)) {
    playFXOnTag(level.trackingdronesettings.fxid_warning, self, "tag_fx_beacon_0");
    playFXOnTag(level.trackingdronesettings.fxid_warning, self, "tag_fx_beacon_1");
  }

  wait 0.15;

  if(isDefined(self)) {
    playFXOnTag(level.trackingdronesettings.fxid_warning, self, "tag_fx_beacon_2");
  }
}

trackingdrone_followtarget() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");
  self endon("exploding");

  if(!isDefined(self.owner)) {
    thread trackingdrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");
  self vehicle_setspeed(self.followspeed, 10, 10);
  self.previoustrackedplayer = self.owner;
  self.trackedplayer = undefined;

  if(isDefined(level.ishorde) && level.ishorde) {
    self.trackedplayer = self.owner;
  }

  for(;;) {
    if(isDefined(self.stunned) && self.stunned) {
      wait 0.5;
      continue;
    }

    if(isDefined(self.owner) && isalive(self.owner)) {
      var_0 = self.maxtrackingrange * self.maxtrackingrange;
      var_1 = var_0;

      if(!isDefined(level.ishorde)) {
        if(!isDefined(self.trackedplayer) || self.trackedplayer == self.owner) {
          foreach(var_3 in level.players) {
            if(isDefined(var_3) && isalive(var_3) && var_3.team != self.team && !var_3 maps\mp\_utility::_hasperk("specialty_blindeye")) {
              var_4 = distancesquared(self.origin, var_3.origin);

              if(var_4 < var_1) {
                var_1 = var_4;
                self.trackedplayer = var_3;
                thread watchplayerdeathdisconnect(var_3);
              }
            }
          }
        }
      }

      if(!isDefined(self.trackedplayer)) {
        self.trackedplayer = self.owner;
      }

      if(isDefined(self.trackedplayer)) {
        trackingdrone_movetoplayer(self.trackedplayer);
      }

      if(self.trackedplayer != self.previoustrackedplayer) {
        stophighlightingplayer(self.previoustrackedplayer);
        self.previoustrackedplayer = self.trackedplayer;
      }
    }

    wait 1;
  }
}

watchplayerdeathdisconnect(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("exploding");
  var_0 common_scripts\utility::waittill_any("death", "disconnect", "faux_spawn", "joined_team");

  if(isDefined(var_0)) {
    if(var_0.is_being_tracked == 1) {
      if(!isalive(var_0)) {
        var_0.died_being_tracked = 1;
      }

      thread trackingdrone_leave();
    } else {
      self.trackedplayer = undefined;
    }
  }
}

trackingdrone_movetoplayer(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self notify("trackingDrone_moveToPlayer");
  self endon("trackingDrone_moveToPlayer");
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(isDefined(level.ishorde) && level.ishorde) {
    var_1 = 0;
    var_2 = 30;

    switch (var_0 getstance()) {
      case "stand":
        var_3 = 105;
        break;
      case "crouch":
        var_3 = 75;
        break;
      case "prone":
        var_3 = 45;
        break;
    }
  } else {
    var_1 = -65;
    var_2 = 0;

    switch (var_0 getstance()) {
      case "stand":
        var_3 = 65;
        break;
      case "crouch":
        var_3 = 50;
        break;
      case "prone":
        var_3 = 22;
        break;
    }
  }

  var_4 = (var_2, var_1, var_3);
  self setdronegoalpos(var_0, var_4);
  self.intransit = 1;
  thread trackingdrone_watchforgoal();
  thread trackingdrone_watchtargetdisconnect();
}

trackingdrone_stopmovement() {
  self setvehgoalpos(self.origin, 1);
  self.intransit = 0;
  self.inactive = 1;
}

trackingdrone_changeowner(var_0) {
  maps\mp\_utility::incrementfauxvehiclecount();
  var_1 = var_0 createtrackingdrone(self.weaponname, 1, self.origin, self.angles);

  if(!isDefined(var_1)) {
    maps\mp\_utility::decrementfauxvehiclecount();
    return 0;
  }

  if(!isDefined(var_0.trackingdronearray)) {
    var_0.trackingdronearray = [];
  }

  var_0.trackingdronearray[var_0.trackingdronearray.size] = var_1;
  level.trackingdrones = common_scripts\utility::array_removeundefined(level.trackingdrones);
  level.trackingdrones[level.trackingdrones.size] = var_1;
  var_0 thread starttrackingdrone(var_1);

  if(isDefined(level.trackingdronesettings.fxid_sparks)) {
    stopFXOnTag(level.trackingdronesettings.fxid_sparks, self, self.fx_tag0);
  }

  removetrackingdrone();
  return 1;
}

trackingdrone_highlighttarget() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner)) {
    thread trackingdrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.lasertag = spawn("script_model", self.origin);
  self.lasertag setModel("tag_laser");

  for(;;) {
    if(isDefined(self.trackedplayer)) {
      self.lasertag.origin = self gettagorigin("tag_weapon");
      var_0 = 20;
      var_1 = (randomfloat(var_0), randomfloat(var_0), randomfloat(var_0)) - (10, 10, 10);
      var_2 = 65;

      switch (self.trackedplayer getstance()) {
        case "stand":
          var_2 = 65;
          break;
        case "crouch":
          var_2 = 50;
          break;
        case "prone":
          var_2 = 22;
          break;
      }

      self.lasertag.angles = vectortoangles(self.trackedplayer.origin + (0, 0, var_2 - 20) + var_1 - self.origin);
    }

    if(isDefined(self.stunned) && self.stunned) {
      wait 0.5;
      continue;
    }

    var_3 = undefined;

    if(isDefined(self.trackedplayer)) {
      var_4 = bulletTrace(self.origin, self.trackedplayer.origin, 1, self);
      var_3 = var_4["entity"];
    }

    if(isDefined(self.trackedplayer) && self.trackedplayer != self.owner && isDefined(var_3) && var_3 == self.trackedplayer && distancesquared(self.origin, self.trackedplayer.origin) < self.maxlaserrange * self.maxlaserrange) {
      if(self.trackedplayer.is_being_tracked == 0) {
        starthighlightingplayer(self.trackedplayer);
      }
    } else if(isDefined(self.trackedplayer) && self.trackedplayer.is_being_tracked == 1) {
      stophighlightingplayer(self.trackedplayer);
    }

    wait 0.05;
  }
}

starthighlightingplayer(var_0) {
  self.lasertag laseron("tracking_drone_laser");
  playFXOnTag(level.trackingdronesettings.fxid_laser_glow, self.lasertag, "tag_laser");

  if(isDefined(level.trackingdronesettings.sound_lock)) {
    self playLoopSound(level.trackingdronesettings.sound_lock);
  }

  var_0 setperk("specialty_radararrow", 1, 0);

  if(var_0.is_being_tracked == 0) {
    var_0.is_being_tracked = 1;
    var_0.trackedbyplayer = self.owner;
  }
}

stophighlightingplayer(var_0) {
  if(isDefined(self.lasertag)) {
    self.lasertag laseroff();
    stopFXOnTag(level.trackingdronesettings.fxid_laser_glow, self.lasertag, "tag_laser");
  }

  if(isDefined(var_0)) {
    if(isDefined(level.trackingdronesettings.sound_lock)) {
      self stoploopsound();
    }

    if(var_0 hasperk("specialty_radararrow", 1)) {
      var_0 unsetperk("specialty_radararrow", 1);
    }

    var_0 notify("player_not_tracked");
    var_0.is_being_tracked = 0;
    var_0.trackedbyplayer = undefined;
  }
}

ontrackingplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0.is_being_tracked = 0;

    foreach(var_0 in level.players) {
      if(!isDefined(var_0.is_being_tracked)) {
        var_0.is_being_tracked = 0;
      }
    }
  }
}

trackingdrone_watchforgoal() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self notify("trackingDrone_watchForGoal");
  self endon("trackingDrone_watchForGoal");
  var_0 = common_scripts\utility::waittill_any_return("goal", "near_goal", "hit_goal");
  self.intransit = 0;
  self.inactive = 0;
  self notify("hit_goal");
}

trackingdrone_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");
  thread trackingdronedestroyed();
}

trackingdrone_watchtimeout() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  var_0 = level.trackingdronetimeout;

  if(self.type == "explosive_drone") {
    var_0 = level.explosivedronetimeout;
  }

  wait(var_0);
  thread trackingdrone_leave();
}

trackingdrone_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  self notify("owner_gone");
  thread trackingdrone_leave();
}

trackingdrone_watchownerdeath() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  for(;;) {
    self.owner waittill("death");
    thread trackingdrone_leave();
  }
}

trackingdrone_watchtargetdisconnect() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self notify("trackingDrone_watchTargetDisconnect");
  self endon("trackingDrone_watchTargetDisconnect");
  self.trackedplayer waittill("disconnect");
  stophighlightingplayer(self.trackedplayer);
  trackingdrone_movetoplayer(self.owner);
}

trackingdrone_watchroundend() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level common_scripts\utility::waittill_any("round_end_finished", "game_ended");
  thread trackingdrone_leave();
}

trackingdrone_watchhostmigration() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level waittill("host_migration_begin");
  stophighlightingplayer(self.trackedplayer);
  trackingdrone_stopmovement();
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  thread trackingdrone_changeowner(self.owner);
}

trackingdrone_leave() {
  self endon("death");
  self notify("leaving");
  stophighlightingplayer(self.trackedplayer);
  trackingdroneexplode();
}

ontrackingdronedeath(var_0, var_1, var_2, var_3) {
  self notify("death");
}

trackingdrone_watchdisable() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    thread trackingdrone_stunned();
  }
}

trackingdrone_stunned() {
  self notify("trackingDrone_stunned");
  self endon("trackingDrone_stunned");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  trackingdrone_stunbegin();
  wait 10.0;
  trackingdrone_stunend();
}

trackingdrone_stunbegin() {
  if(self.stunned) {
    return;
  }
  self.stunned = 1;

  if(isDefined(level.trackingdronesettings.fxid_sparks)) {
    playFXOnTag(level.trackingdronesettings.fxid_sparks, self, self.fx_tag0);
  }

  thread stophighlightingplayer(self.trackedplayer);
  self.trackedplayer = undefined;
  self.previoustrackedplayer = self.owner;
  thread trackingdrone_stopmovement();
}

trackingdrone_stunend() {
  if(isDefined(level.trackingdronesettings.fxid_sparks)) {
    killfxontag(level.trackingdronesettings.fxid_sparks, self, self.fx_tag0);
  }

  self.stunned = 0;
  self.inactive = 0;
}

trackingdronedestroyed() {
  if(!isDefined(self)) {
    return;
  }
  stophighlightingplayer(self.trackedplayer);
  trackingdrone_stunend();
  trackingdroneexplode();
}

trackingdroneexplode() {
  if(isDefined(level.trackingdronesettings.fxid_explode)) {
    playFX(level.trackingdronesettings.fxid_explode, self.origin);
  }

  if(isDefined(level.trackingdronesettings.sound_explode)) {
    self playSound(level.trackingdronesettings.sound_explode);
  }

  self notify("explode");
  removetrackingdrone();
}

deletetrackingdrone() {
  if(!isremovedentity(self) && isDefined(self)) {
    if(isDefined(self.attractor)) {
      missile_deleteattractor(self.attractor);
    }

    self delete();
  }
}

removetrackingdrone() {
  maps\mp\_utility::decrementfauxvehiclecount();

  if(isDefined(self.owner) && isDefined(self.owner.trackingdrone)) {
    self.owner.trackingdrone = undefined;
  }

  if(isDefined(self.lasertag)) {
    self.lasertag delete();
  }

  deletetrackingdrone();
}

addtotrackingdronelist() {
  level.trackingdrones[self getentitynumber()] = self;
}

removefromtrackingdronelistondeath() {
  var_0 = self getentitynumber();
  self waittill("death");
  level.trackingdrones[var_0] = undefined;
  level.trackingdrones = common_scripts\utility::array_removeundefined(level.trackingdrones);
}

exceededmaxtrackingdrones() {
  if(level.trackingdrones.size >= maps\mp\_utility::maxvehiclesallowed()) {
    return 1;
  } else {
    return 0;
  }
}

aud_drone_start_jets() {
  self playLoopSound("veh_tracking_drone_jets_lp");
}

destroy_tracking_drone_in_water() {
  self endon("death");

  if(!isDefined(level.water_triggers)) {
    return;
  }
  for(;;) {
    foreach(var_1 in level.water_triggers) {
      if(self istouching(var_1)) {
        if(isDefined(level.trackingdronesettings.fxid_explode)) {
          playFX(level.trackingdronesettings.fxid_explode, self.origin);
        }

        if(isDefined(level.trackingdronesettings.sound_explode)) {
          self playSound(level.trackingdronesettings.sound_explode);
        }

        deletetrackingdrone();
      }
    }

    wait 0.05;
  }
}

prevent_tracking_drone_in_water(var_0) {
  if(!isDefined(level.water_triggers)) {
    return 0;
  }

  foreach(var_2 in level.water_triggers) {
    if(ispointinvolume(var_0, var_2)) {
      return 1;
    }
  }

  return 0;
}