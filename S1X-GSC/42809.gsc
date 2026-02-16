/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42809.gsc
**************************************/

watchexplosivedroneusage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  if(!isDefined(level.explosivedronesettings)) {
    explosivedroneinit();
  }

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "explosive_drone_mp") {
      var_0.team = self.team;

      if(!isDefined(var_0.owner)) {
        var_0.owner = self;
      }

      if(!isDefined(var_0.weaponname)) {
        var_0.weaponname = var_1;
      }

      var_0 thread explosivedronelink();
    }
  }
}

explosivedronelink() {
  thread watchforstick();
  wait 0.1;

  if(isDefined(self)) {
    self.explosivedrone = spawn("script_model", self.origin);
    self.explosivedrone.targetname = "explosive_drone_head_model";
    self.explosivedrone setModel(level.explosivedronesettings.modelbase);
    self.explosivedrone.oldcontents = self.explosivedrone setcontents(0);
    self.explosivedrone linkto(self, "tag_spike", (0, 0, 0), (0, 0, 0));
    self.explosivedrone.owner = self.owner;
    var_0 = self.explosivedrone;
    var_0 thread cleanup_on_grenade_death(self);
    thread monitorspikedestroy();
    thread monitorheaddestroy();
  }
}

cleanup_on_grenade_death(var_0) {
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

explosivegrenadedeath(var_0, var_1, var_2, var_3) {
  if(isDefined(self)) {
    self notify("death");

    if(isDefined(self.explosivedrone)) {
      self.explosivedrone deleteexplosivedrone();
    }

    self delete();
  }
}

explosiveheaddeath(var_0, var_1, var_2, var_3) {
  if(isDefined(self)) {
    self delete();
  }
}

explosivedroneinit() {
  level.explosivedronemaxperplayer = 1;
  level.explosivedronesettings = spawnStruct();
  level.explosivedronesettings.timeout = 20.0;
  level.explosivedronesettings.explosivetimeout = 30.0;
  level.explosivedronesettings.health = 60;
  level.explosivedronesettings.maxhealth = 60;
  level.explosivedronesettings.vehicleinfo = "vehicle_tracking_drone_mp";
  level.explosivedronesettings.modelbase = "npc_drone_explosive_main";
  level.explosivedronesettings.fxid_sparks = loadfx("vfx/sparks/direct_hack_stun");
  level.explosivedronesettings.fxid_laser_glow = loadfx("vfx/lights/tracking_drone_laser_blue");
  level.explosivedronesettings.fxid_explode = loadfx("vfx/explosion/explosive_drone_explosion");
  level.explosivedronesettings.fxid_lethalexplode = loadfx("vfx/explosion/explosive_drone_explosion");
  level.explosivedronesettings.fxid_enemy_light = loadfx("vfx/lights/light_explosive_drone_beacon_enemy");
  level.explosivedronesettings.fxid_friendly_light = loadfx("vfx/lights/light_explosive_drone_beacon_friendly");
  level.explosivedronesettings.fxid_engine_distort = loadfx("vfx/distortion/tracking_drone_distortion_hemi");
  level.explosivedronesettings.fxid_launch_thruster = loadfx("vfx/trail/explosive_drone_thruster_large");
  level.explosivedronesettings.fxid_position_thruster = loadfx("vfx/trail/explosive_drone_thruster_small");
  level.explosivedronesettings.sound_explode = "wpn_explosive_drone_exp";
  level.explosivedronesettings.sound_lock = "wpn_explosive_drone_lock";
  level.explosivedronesettings.sound_launch = "wpn_explosive_drone_open";

  foreach(var_1 in level.players) {
    var_1.is_being_tracked = 0;
  }

  level thread onexplosiveplayerconnect();
  level.explosivedronetimeout = level.explosivedronesettings.timeout;
  level.explosivedronetimeout = level.explosivedronesettings.explosivetimeout;
  level.explosivedronedebugposition = 0;
  level.explosivedronedebugpositionforward = 0;
  level.explosivedronedebugpositionheight = 0;
}

tryuseexplosivedrone(var_0) {
  var_1 = 1;

  if(maps\mp\_utility::isusingremote()) {
    return 0;
  } else if(exceededmaxexplosivedrones()) {
    self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_1 >= maps\mp\_utility::maxvehiclesallowed()) {
    self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(!isDefined(self.explosivedronearray)) {
    self.explosivedronearray = [];
  }

  if(self.explosivedronearray.size) {
    self.explosivedronearray = common_scripts\utility::array_removeundefined(self.explosivedronearray);

    if(self.explosivedronearray.size >= level.explosivedronemaxperplayer) {
      if(isDefined(self.explosivedronearray[0])) {
        self.explosivedronearray[0] thread explosivedrone_leave();
      }
    }
  }

  maps\mp\_utility::incrementfauxvehiclecount();
  var_2 = var_0 createexplosivedrone();

  if(!isDefined(var_2)) {
    maps\mp\_utility::decrementfauxvehiclecount();
    return 0;
  }

  self playSound(level.explosivedronesettings.sound_launch);
  self playSound(level.explosivedronesettings.sound_lock);
  self.explosivedronearray[self.explosivedronearray.size] = var_2;
  thread startexplosivedrone(var_2);
  playFXOnTag(level.explosivedronesettings.fxid_launch_thruster, var_2, "TAG_THRUSTER_BTM");
  var_0 notify("mine_selfdestruct");
  return var_2;
}

createexplosivedrone(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!var_0) {
    var_4 = self.angles;
    var_5 = anglesToForward(var_4);
    var_6 = anglestoright(var_4);
    var_7 = var_5 * 50;
    var_8 = var_6 * 0;
    var_9 = 80;

    if(isDefined(self.explosivedrone)) {
      var_11 = self.explosivedrone.origin;
      var_4 = self.explosivedrone.angles;
      self.explosivedrone deleteexplosivedrone();
      addtodeletespike();
    } else {
      var_11 = self.origin;
    }
  } else {
    var_11 = var_1;
    var_12 = var_1;
    var_4 = var_2;
  }

  var_13 = anglestoup(self.angles);
  var_11 = var_11 + var_13 * 10;
  var_14 = spawnhelicopter(self.owner, var_11, var_4, level.explosivedronesettings.vehicleinfo, level.explosivedronesettings.modelbase);

  if(!isDefined(var_14)) {
    return;
  }
  var_14.type = "explosive_drone";
  var_14 common_scripts\utility::make_entity_sentient_mp(self.owner.team);
  var_14 makevehiclenotcollidewithplayers(1);
  var_14 addtoexplosivedronelist();
  var_14 thread removefromexplosivedronelistondeath();
  var_14.health = level.explosivedronesettings.health;
  var_14.maxhealth = level.explosivedronesettings.maxhealth;
  var_14.damagetaken = 0;
  var_14.speed = 20;
  var_14.followspeed = 20;
  var_14.owner = self.owner;
  var_14.team = self.owner.team;
  var_14 vehicle_setspeed(var_14.speed, 10, 10);
  var_14 setyawspeed(120, 90);
  var_14 setneargoalnotifydist(64);
  var_14 sethoverparams(20, 5, 5);
  var_14.fx_tag0 = undefined;

  if(isDefined(var_14.type)) {
    if(var_14.type == "explosive_drone") {}
  }

  var_14.maxtrackingrange = 2000;
  var_14.maxlaserrange = 300;
  var_14.trackedplayer = undefined;
  var_15 = 45;
  var_16 = 45;
  var_14 setmaxpitchroll(var_15, var_16);
  var_14.targetpos = var_11;
  var_14.attract_strength = 10000;
  var_14.attract_range = 150;
  var_14.attractor = missile_createattractorent(var_14, var_14.attract_strength, var_14.attract_range);
  var_14.hasdodged = 0;
  var_14.stunned = 0;
  var_14.inactive = 0;
  var_14 thread maps\mp\gametypes\_damage::setentitydamagecallback(var_14.maxhealth, undefined, ::onexplosivedronedeath, undefined, 0);
  var_14 thread explosivedrone_watchdisable();
  var_14 thread explosivedrone_watchdeath();
  var_14 thread explosivedrone_watchtimeout();
  var_14 thread explosivedrone_watchownerloss();
  var_14 thread explosivedrone_watchownerdeath();
  var_14 thread explosivedrone_watchroundend();
  var_14 thread explosivedrone_watchhostmigration();
  var_14 thread explosivedrone_enemy_lightfx();
  var_14 thread explosivedrone_friendly_lightfx();
  var_14 thread drone_thrusterfxexplosive();
  return var_14;
}

addtodeletespike() {
  var_0 = 5;

  if(!isDefined(level.spikelist)) {
    level.spikelist = [];
    level.spikelistindex = 0;
  }

  if(level.spikelist.size >= var_0) {
    if(isDefined(level.spikelist[level.spikelistindex])) {
      level.spikelist[level.spikelistindex] delete();
    }
  }

  level.spikelist[level.spikelistindex] = self;
  level.spikelistindex = (level.spikelistindex + 1) % var_0;
}

idletargetmoverexplosive(var_0) {
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

explosivedrone_enemy_lightfx() {
  self endon("death");
  self.owner endon("faux_spawn");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && issentient(var_1) && issentient(self) && var_1.team != self.team) {
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
    }
  }
}

explosivedrone_friendly_lightfx() {
  self endon("death");
  self.owner endon("faux_spawn");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && issentient(var_1) && issentient(self) && var_1.team == self.team) {
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_1);
    }
  }

  thread watchconnectedplayfxexplosive();
  thread watchjoinedteamplayfxexplosive();
}

drone_thrusterfxexplosive() {
  self endon("death");
  self endon("disconnect");
  self.owner endon("faux_spawn");

  for(;;) {
    foreach(var_1 in level.players) {
      thread drone_thrusterfx_bottom_threaded(var_1);
      thread drone_thrusterfx_side_threaded(var_1);
    }

    wait 1.1;
  }
}

drone_thrusterfx_side_threaded(var_0) {
  self endon("death");
  self endon("disconnect");
  self.owner endon("faux_spawn");
  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_X_nY_Z", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_X_nY_nZ", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_nX_nY_Z", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_nX_nY_nZ", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_nX_Y_nZ", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_nX_Y_Z", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_X_Y_Z", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUST_SIDE_X_Y_nZ", var_0);
  }
}

drone_thrusterfx_bottom_threaded(var_0) {
  self endon("death");
  self endon("disconnect");
  self.owner endon("faux_spawn");
  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_engine_distort)) {
    playfxontagforclients(level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_engine_distort)) {
    playfxontagforclients(level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_engine_distort)) {
    playfxontagforclients(level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_engine_distort)) {
    playfxontagforclients(level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_engine_distort)) {
    playfxontagforclients(level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_position_thruster)) {
    playfxontagforclients(level.explosivedronesettings.fxid_position_thruster, self, "TAG_THRUSTER_BTM", var_0);
  }

  wait 0.1;

  if(isDefined(var_0) && isDefined(self) && isDefined(level.explosivedronesettings.fxid_engine_distort)) {
    playfxontagforclients(level.explosivedronesettings.fxid_engine_distort, self, "TAG_THRUSTER_BTM", var_0);
  }
}

watchconnectedplayfxexplosive() {
  self endon("death");
  self.owner endon("faux_spawn");

  for(;;) {
    level waittill("connected", var_0);
    var_0 waittill("spawned_player");

    if(isDefined(var_0) && var_0.team == self.team) {
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0);
    }
  }
}

watchjoinedteamplayfxexplosive() {
  self endon("death");
  self.owner endon("faux_spawn");

  for(;;) {
    level waittill("joined_team", var_0);
    var_0 waittill("spawned_player");

    if(isDefined(var_0) && var_0.team == self.team) {
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_friendly_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0);
      wait 0.15;
      playfxontagforclients(level.explosivedronesettings.fxid_enemy_light, self, "TAG_BEACON", var_0);
    }
  }
}

startexplosivedrone(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 thread explosivedrone_followtarget();
  var_0 thread createkillcamentity();

  if(isDefined(var_0.type)) {
    if(var_0.type == "explosive_drone") {
      var_0 thread checkforexplosivegoalexplosive();
    }
  }
}

checkforexplosivegoalexplosive() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");
  var_0 = gettime();
  thread blowupatendoftrackingtime(var_0);
}

blowupatendoftrackingtime(var_0) {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");

  while(gettime() - var_0 < 3000) {
    waitframe();
  }

  if(isDefined(self)) {
    self notify("exploding");
    thread blowupdronesequenceexplosive();
  }
}

blowupdronesequenceexplosive() {
  var_0 = undefined;

  if(isDefined(self)) {
    if(isDefined(self.owner)) {
      var_0 = self.owner;
    }

    self playSound(level.explosivedronesettings.sound_lock);
    wait 0.5;
  }

  if(isDefined(self)) {
    self playSound("wpn_explosive_drone_exp");
    var_1 = anglestoup(self.angles);
    var_2 = anglesToForward(self.angles);
    playFX(level.explosivedronesettings.fxid_lethalexplode, self.origin, var_2, var_1);

    if(isDefined(var_0)) {
      self radiusdamage(self.origin, 256, 130, 55, var_0, "MOD_EXPLOSIVE", "explosive_drone_mp");
    } else {
      self radiusdamage(self.origin, 256, 130, 55, undefined, "MOD_EXPLOSIVE", "explosive_drone_mp");
    }

    self notify("death");
  }
}

turnondangerlightsexplosive() {
  if(isDefined(self)) {}

  wait 0.05;

  if(isDefined(self)) {}

  wait 0.15;

  if(isDefined(self)) {
    return;
  }
}

explosivedrone_followtarget() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");
  self endon("exploding");

  if(!isDefined(self.owner)) {
    thread explosivedrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");
  self vehicle_setspeed(self.followspeed, 10, 10);
  self.previoustrackedplayer = self.owner;
  self.trackedplayer = undefined;

  for(;;) {
    if(isDefined(self.stunned) && self.stunned) {
      wait 0.5;
      continue;
    }

    if(isDefined(self.owner) && isalive(self.owner)) {
      var_0 = self.maxtrackingrange * self.maxtrackingrange;
      var_1 = var_0;

      if(!isDefined(self.trackedplayer) || self.trackedplayer == self.owner) {
        foreach(var_3 in level.players) {
          if(isDefined(var_3) && isalive(var_3) && var_3 != self.owner && (!level.teambased || var_3.team != self.team) && !var_3 maps\mp\_utility::_hasperk("specialty_blindeye")) {
            var_4 = distancesquared(self.origin, var_3.origin);

            if(var_4 < var_1) {
              var_1 = var_4;
              self.trackedplayer = var_3;
              thread watchplayerdeathdisconnectexplosive(var_3);
            }
          }
        }
      }

      if(!isDefined(self.trackedplayer)) {
        thread explosivedroneexplode();
      }

      if(isDefined(self.trackedplayer)) {
        explosivedrone_movetoplayer(self.trackedplayer);
      }

      if(self.trackedplayer != self.previoustrackedplayer) {
        stophighlightingplayerexplosive(self.previoustrackedplayer);
        self.previoustrackedplayer = self.trackedplayer;
      }
    }

    wait 1;
  }
}

watchplayerdeathdisconnectexplosive(var_0) {
  var_0 common_scripts\utility::waittill_any("death", "disconnect", "faux_spawn", "joined_team");

  if(var_0.is_being_tracked == 1) {
    thread explosivedrone_leave();
  } else {
    self.trackedplayer = undefined;
  }
}

explosivedrone_movetoplayer(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self notify("explosiveDrone_moveToPlayer");
  self endon("explosiveDrone_moveToPlayer");
  var_1 = 0;
  var_2 = 0;
  var_3 = 65;

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

  var_4 = (var_2, var_1, var_3);
  self setdronegoalpos(var_0, var_4);
  self.intransit = 1;
  thread explosivedrone_watchforgoal();
  thread explosivedrone_watchtargetdisconnect();
}

explosivedrone_stopmovement() {
  self setvehgoalpos(self.origin, 1);
  self.intransit = 0;
  self.inactive = 1;
}

explosivedrone_changeowner(var_0) {
  maps\mp\_utility::incrementfauxvehiclecount();
  var_1 = var_0 createexplosivedrone(1, self.origin, self.angles);

  if(!isDefined(var_1)) {
    maps\mp\_utility::decrementfauxvehiclecount();
    return 0;
  }

  if(!isDefined(var_0.explosivedronearray)) {
    var_0.explosivedronearray = [];
  }

  var_0.explosivedronearray[var_0.explosivedronearray.size] = var_1;
  var_0 thread startexplosivedrone(var_1);

  if(isDefined(level.explosivedronesettings.fxid_sparks)) {}

  removeexplosivedrone();
  return 1;
}

explosivedrone_highlighttarget() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner)) {
    thread explosivedrone_leave();
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
        starthighlightingplayerexplosive(self.trackedplayer);
      }
    } else if(isDefined(self.trackedplayer) && self.trackedplayer.is_being_tracked == 1) {
      stophighlightingplayerexplosive(self.trackedplayer);
    }

    wait 0.05;
  }
}

starthighlightingplayerexplosive(var_0) {
  self.lasertag laseron("explosive_drone_laser");
  playFXOnTag(level.explosivedronesettings.fxid_laser_glow, self.lasertag, "tag_laser");

  if(isDefined(level.explosivedronesettings.sound_lock)) {
    self playSound(level.explosivedronesettings.sound_lock);
  }

  var_0 setperk("specialty_radararrow", 1, 0);

  if(var_0.is_being_tracked == 0) {
    var_0.is_being_tracked = 1;
    var_0.trackedbyplayer = self.owner;
  }
}

stophighlightingplayerexplosive(var_0) {
  if(isDefined(self.lasertag)) {
    self.lasertag laseroff();
    stopFXOnTag(level.explosivedronesettings.fxid_laser_glow, self.lasertag, "tag_laser");
  }

  if(isDefined(var_0)) {
    if(isDefined(level.explosivedronesettings.sound_lock)) {
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

onexplosiveplayerconnect() {
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

explosivedrone_watchforgoal() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self notify("explosiveDrone_watchForGoal");
  self endon("explosiveDrone_watchForGoal");
  var_0 = common_scripts\utility::waittill_any_return("goal", "near_goal", "hit_goal");
  self.intransit = 0;
  self.inactive = 0;
  self notify("hit_goal");
}

explosivedrone_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");
  thread explosivedronedestroyed();
}

explosivedrone_watchtimeout() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  var_0 = level.explosivedronetimeout;

  if(self.type == "explosive_drone") {
    var_0 = level.explosivedronetimeout;
  }

  wait(var_0);
  thread explosivedrone_leave();
}

explosivedrone_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  self notify("owner_gone");
  thread explosivedrone_leave();
}

explosivedrone_watchownerdeath() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  for(;;) {
    self.owner waittill("death");
    thread explosivedrone_leave();
  }
}

explosivedrone_watchtargetdisconnect() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self notify("explosiveDrone_watchTargetDisconnect");
  self endon("explosiveDrone_watchTargetDisconnect");
  self.trackedplayer waittill("disconnect");
  stophighlightingplayerexplosive(self.trackedplayer);
  explosivedrone_movetoplayer(self.owner);
}

explosivedrone_watchroundend() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level common_scripts\utility::waittill_any("round_end_finished", "game_ended");
  thread explosivedrone_leave();
}

explosivedrone_watchhostmigration() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level waittill("host_migration_begin");
  stophighlightingplayerexplosive(self.trackedplayer);
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  thread explosivedrone_changeowner(self.owner);
}

explosivedrone_leave() {
  self endon("death");
  self notify("leaving");
  stophighlightingplayerexplosive(self.trackedplayer);
  explosivedroneexplode();
}

onexplosivedronedeath(var_0, var_1, var_2, var_3) {
  self notify("death");
}

explosivedrone_grenade_watchdisable() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.stunned = 0;

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    thread explosivedrone_grenade_stunned();
  }
}

explosivedrone_watchdisable() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    thread explosivedrone_stunned();
  }
}

explosivedrone_grenade_stunned() {
  self notify("explosiveDrone_stunned");
  self endon("explosiveDrone_stunned");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  explosivedrone_grenade_stunbegin();
  wait 10.0;
  explosivedrone_grenade_stunend();
}

explosivedrone_stunned() {
  self notify("explosiveDrone_stunned");
  self endon("explosiveDrone_stunned");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  explosivedrone_stunbegin();
  wait 10.0;
  explosivedrone_stunend();
}

explosivedrone_grenade_stunbegin() {
  if(self.stunned) {
    return;
  }
  self.stunned = 1;

  if(isDefined(level.explosivedronesettings.fxid_sparks)) {
    playFXOnTag(level.explosivedronesettings.fxid_sparks, self, "TAG_BEACON");
  }
}

explosivedrone_stunbegin() {
  if(self.stunned) {
    return;
  }
  self.stunned = 1;

  if(isDefined(level.explosivedronesettings.fxid_sparks)) {
    playFXOnTag(level.explosivedronesettings.fxid_sparks, self, "TAG_BEACON");
  }

  thread stophighlightingplayerexplosive(self.trackedplayer);
  self.trackedplayer = undefined;
  self.previoustrackedplayer = self.owner;
  thread explosivedrone_stopmovement();
}

explosivedrone_grenade_stunend() {
  if(isDefined(level.explosivedronesettings.fxid_sparks)) {
    killfxontag(level.explosivedronesettings.fxid_sparks, self, "TAG_BEACON");
  }

  self.stunned = 0;
  self.inactive = 0;
}

explosivedrone_stunend() {
  if(isDefined(level.explosivedronesettings.fxid_sparks)) {
    killfxontag(level.explosivedronesettings.fxid_sparks, self, "TAG_BEACON");
  }

  self.stunned = 0;
  self.inactive = 0;
}

explosivedronedestroyed() {
  if(!isDefined(self)) {
    return;
  }
  stophighlightingplayerexplosive(self.trackedplayer);
  explosivedrone_stunend();
  explosivedroneexplode();
}

explosivedroneexplode() {
  if(isDefined(level.explosivedronesettings.fxid_explode)) {
    playFX(level.explosivedronesettings.fxid_explode, self.origin);
  }

  if(isDefined(level.explosivedronesettings.sound_explode)) {
    self playSound(level.explosivedronesettings.sound_explode);
  }

  self notify("exploding");
  removeexplosivedrone();
}

deleteexplosivedrone() {
  if(isDefined(self.attractor)) {
    missile_deleteattractor(self.attractor);
  }

  removekillcamentity();
  self delete();
}

removeexplosivedrone() {
  maps\mp\_utility::decrementfauxvehiclecount();

  if(isDefined(self.owner) && isDefined(self.owner.explosivedrone)) {
    self.owner.explosivedrone = undefined;
  }

  deleteexplosivedrone();
}

addtoexplosivedronelist() {
  level.explosivedrones[self getentitynumber()] = self;
}

removefromexplosivedronelistondeath() {
  var_0 = self getentitynumber();
  self waittill("death");
  level.explosivedrones[var_0] = undefined;
  level.explosivedrones = common_scripts\utility::array_removeundefined(level.explosivedrones);
}

exceededmaxexplosivedrones() {
  if(isDefined(level.explosivedrones) && level.explosivedrones.size >= maps\mp\_utility::maxvehiclesallowed()) {
    return 1;
  } else {
    return 0;
  }
}

explosivedroneproximitytrigger() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("faux_spawn");
  wait 3;

  if(isDefined(self) && isDefined(self.explosivedrone)) {
    var_0 = self.explosivedrone gettagorigin("TAG_BEACON") - self gettagorigin("TAG_BEACON") + (0, 0, 10);

    if(level.teambased) {
      maps\mp\_entityheadicons::setteamheadicon(self.owner.team, var_0, "TAG_BEACON");
    } else {
      maps\mp\_entityheadicons::setplayerheadicon(self.owner, var_0, "TAG_BEACON");
    }

    var_1 = spawn("trigger_radius", self.origin + (0, 0, -96), 0, 192, 192);
    var_1.owner = self;
    thread explosivedronedeletetrigger(var_1);
    thread watchforpickup(var_1);
    var_2 = undefined;

    while(isDefined(self) && isDefined(self.explosivedrone)) {
      var_1 waittill("trigger", var_2);

      if(!isDefined(var_2)) {
        wait 0.1;
        continue;
      }

      if(var_2 maps\mp\_utility::_hasperk("specialty_blindeye")) {
        wait 0.1;
        continue;
      }

      if(isDefined(self.explosivedrone) && !var_2 sightconetrace(self.explosivedrone gettagorigin("TAG_BEACON"), self.explosivedrone)) {
        wait 0.1;
        continue;
      }

      if(isDefined(self.explosivedrone)) {
        var_3 = self.explosivedrone gettagorigin("TAG_BEACON");
        var_4 = var_2 getEye();

        if(!bullettracepassed(var_3, var_4, 0, self.explosivedrone)) {
          wait 0.1;
          continue;
        }
      }

      if(maps\mp\_utility::isreallyalive(var_2) && var_2 != self.owner && (!level.teambased || var_2.team != self.owner.team) && !self.stunned) {
        var_2 tryuseexplosivedrone(self);
      }
    }
  }
}

explosivedronedeletetrigger(var_0) {
  common_scripts\utility::waittill_any("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(self.entityheadicon)) {
    self notify("kill_entity_headicon_thread");
    self.entityheadicon destroy();
  }

  var_0 delete();
}

showdebugradius(var_0) {
  var_1 = spawnfx(level.explosivedronesettings.dome, var_0.origin);
  triggerfx(var_1);
  self waittill("death");
  var_1 delete();
}

endonplayerspawn() {
  self.owner common_scripts\utility::waittill_any("spawned_player", "faux_spawn", "delete_explosive_drones");
  explosivegrenadedeath();
}

monitorspikedestroy() {
  self.owner endon("death");
  self.owner endon("disconnect");
  self.owner endon("faux_spawn");
  common_scripts\utility::waittill_any("mine_selfdestruct");
  explosivegrenadedeath();
}

monitorheaddestroy() {
  self.owner endon("death");
  self.owner endon("disconnect");
  self.owner endon("faux_spawn");

  while(isDefined(self.explosivedrone)) {
    wait 0.15;
  }

  if(isDefined(self)) {
    self playSound("wpn_explosive_drone_exp");
    var_0 = anglestoup(self.angles);
    var_1 = anglesToForward(self.angles);
    playFX(level.explosivedronesettings.fxid_lethalexplode, self.origin, var_1, var_0);
    self radiusdamage(self.origin, 256, 130, 55, self.owner, "MOD_EXPLOSIVE", "explosive_drone_mp");
    self notify("death");
  }

  explosivegrenadedeath();
}

startgrenadelightfx() {
  self endon("death");
  self.owner endon("death");
  self.owner endon("disconnect");
  var_0 = 0.6;

  while(isDefined(self.explosivedrone)) {
    foreach(var_2 in level.players) {
      if(isDefined(var_2) && issentient(var_2) && var_2.team == self.team && isDefined(self.explosivedrone)) {
        thread fxblink(level.explosivedronesettings.fxid_friendly_light, self.explosivedrone, "TAG_BEACON", var_2);
      }

      if(isDefined(var_2) && issentient(var_2) && var_2.team != self.team && isDefined(self.explosivedrone)) {
        thread fxblink(level.explosivedronesettings.fxid_enemy_light, self.explosivedrone, "TAG_BEACON", var_2);
      }
    }

    wait(var_0);
  }
}

fxblink(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 <= 4 && isDefined(var_1); var_4++) {
    if(isDefined(var_3) && isDefined(var_1) && isDefined(self.stunned) && !self.stunned) {
      playfxontagforclients(var_0, var_1, var_2, var_3);
      wait 0.15;
    }
  }
}

watchforstick() {
  self endon("death");
  self.owner endon("death");
  self.owner endon("disconnect");
  var_0 = undefined;
  var_0 = common_scripts\utility::waittill_any_return_parms("missile_stuck", "mp_exo_repulsor_repel");

  while(!isDefined(self.explosivedrone)) {
    waitframe();
  }

  if(isDefined(var_0[1])) {
    var_1 = var_0[1].script_stay_drone;

    if(var_0[1].classname == "script_model" && !(isDefined(var_1) && var_1 == 1)) {
      self playSound("wpn_explosive_drone_exp");
      var_2 = anglestoup(self.angles);
      var_3 = anglesToForward(self.angles);
      playFX(level.explosivedronesettings.fxid_lethalexplode, self.origin, var_3, var_2);
      self radiusdamage(self.origin, 256, 130, 55, self.owner, "MOD_EXPLOSIVE", "explosive_drone_mp");
      thread explosivegrenadedeath();
    }
  }

  if(isDefined(self)) {
    self.explosivedrone setcontents(self.explosivedrone.oldcontents);
    thread explosivedroneproximitytrigger();
    thread endonplayerspawn();
    thread explosivedrone_grenade_watchdisable();
    thread startgrenadelightfx();
    thread maps\mp\gametypes\_damage::setentitydamagecallback(100, undefined, ::explosivegrenadedeath, undefined, 0);
    self.explosivedrone thread maps\mp\gametypes\_damage::setentitydamagecallback(100, undefined, ::explosiveheaddeath, undefined, 0);
    thread maps\mp\gametypes\_weapons::stickyhandlemovers("mine_selfdestruct");
  }
}

createkillcamentity() {
  var_0 = (0, 0, 0);
  self.killcament = spawn("script_model", self.origin);
  self.killcament setscriptmoverkillcam("explosive");
  self.killcament linkto(self, "TAG_THRUSTER_BTM", var_0, (0, 0, 0));
  self.killcament setcontents(0);
  self.killcament.starttime = gettime();
}

removekillcamentity() {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }
}

watchforpickup(var_0) {
  self.owner endon("disconnect");
  self.owner endon("faux_spawn");
  level endon("game_ended");
  self endon("death");
  self.owner endon("death");
  self.explosivedrone makeusable();
  self.explosivedrone sethintstring(&"MP_PICKUP_EXPLOSIVE_DRONE");
  self.explosivedrone sethintstringvisibleonlytoowner(1);
  var_1 = getdvarfloat("player_useRadius", 128);
  var_1 = var_1 * var_1;

  for(;;) {
    if(!isDefined(self) || !isDefined(var_0)) {
      break;
    }

    var_2 = isDefined(self.explosivedrone) && distancesquared(self.owner getEye(), self.explosivedrone.origin) <= var_1;

    if(self.owner istouching(var_0) && var_2) {
      var_3 = 0;

      while(self.owner useButtonPressed()) {
        if(!maps\mp\_utility::isreallyalive(self.owner)) {
          break;
        }

        if(!self.owner istouching(var_0)) {
          break;
        }

        if(self.owner fragButtonPressed() || self.owner secondaryoffhandbuttonPressed() || isDefined(self.owner.throwinggrenade)) {
          break;
        }

        if(self.owner isusingturret() || self.owner maps\mp\_utility::isusingremote()) {
          break;
        }

        if(isDefined(self.owner.iscapturingcrate) && self.owner.iscapturingcrate) {
          break;
        }

        if(isDefined(self.owner.empgrenaded) && self.owner.empgrenaded) {
          break;
        }

        if(isDefined(self.owner.using_remote_turret) && self.owner.using_remote_turret) {
          break;
        }

        var_3 = var_3 + 0.05;

        if(var_3 > 0.75) {
          self.owner setweaponammostock(self.weaponname, self.owner getweaponammostock(self.weaponname) + 1);
          self.explosivedrone deleteexplosivedrone();
          self delete();
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}