/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_ambient_a10.gsc
****************************************/

a10_precache() {
  precacheitem("AGM_65_satfarm");
  precacheitem("a10_30mm_player_satfarm");
  precacherumble("ac130_25mm_fire");
  level._effect["a10_muzzle_flash"] = loadfx("fx/muzzleflashes/a10_muzzle_flash");
  level._effect["a10_shells"] = loadfx("fx/shellejects/a10_shell");
  level._effect["a10_impact"] = loadfx("fx/explosions/a10_explosion");
}

a10_spawn_funcs() {
  thread a10_gun_dives();
  thread mig29_gun_dives();
  thread a10_missile_dives();
  thread mig29_missile_dives();
}

a10_gun_dives() {
  maps\_utility::array_spawn_function_noteworthy("a10_gun", ::setup_a10_waits);
}

mig29_gun_dives() {}

a10_missile_dives() {
  maps\_utility::array_spawn_function_noteworthy("a10_missile", ::setup_a10_waits);
}

mig29_missile_dives() {
  maps\_utility::array_spawn_function_noteworthy("mig29_missile", ::setup_mig29_waits);
}

setup_a10_waits() {
  maps\_vehicle::godon();
  self setcontents(0);

  if(isDefined(self.script_noteworthy)) {
    thread wait_kill_me();

    if(self.script_noteworthy == "a10_gun") {
      thread a10_wait_start_firing();
      thread a10_wait_stop_firing();
    } else if(self.script_noteworthy == "a10_missile")
      thread a10_wait_fire_missile();
  }
}

setup_mig29_waits() {
  maps\_vehicle::godon();
  self setcontents(0);

  if(isDefined(self.script_noteworthy)) {
    thread wait_kill_me("mig29");

    if(self.script_noteworthy == "mig29_gun") {
      thread mig29_wait_start_firing();
      thread mig29_wait_stop_firing();
    } else if(self.script_noteworthy == "mig29_missile")
      thread mig29_wait_fire_missile();
  }
}

a10_wait_start_firing() {
  self endon("death");
  maps\_utility::ent_flag_init("start_firing");
  maps\_utility::ent_flag_wait("start_firing");
  maps\_utility::ent_flag_clear("start_firing");
  thread a10_30mm_fire();

  if(isDefined(self.script_parameters)) {
    switch (self.script_parameters) {
      case "bridge_enemy_a10_gun_dive_2":
        foreach(var_1 in level.enemytanks) {
          if(isDefined(var_1.script_noteworthy) && isalive(var_1) && var_1.script_noteworthy == "bridge_enemy_tank") {
            var_1 thread maps\satfarm_code::random_wait_and_kill(1.0, 2.0);
          }
        }
    }
  }
}

mig29_wait_start_firing() {
  self endon("death");
  maps\_utility::ent_flag_init("start_firing");
  maps\_utility::ent_flag_wait("start_firing");
  maps\_utility::ent_flag_clear("start_firing");
  thread mig29_fire();
}

a10_wait_stop_firing() {
  self endon("death");
  maps\_utility::ent_flag_init("stop_firing");
  maps\_utility::ent_flag_wait("stop_firing");
  self stoploopsound("satf_gatling_loop");
  self playSound("satf_gatling_tail");
  maps\_utility::ent_flag_clear("stop_firing");
}

mig29_wait_stop_firing() {
  self endon("death");
  maps\_utility::ent_flag_init("stop_firing");
  maps\_utility::ent_flag_wait("stop_firing");
  self stoploopsound("satf_gatling_loop");
  self playSound("satf_gatling_tail");
  maps\_utility::ent_flag_clear("stop_firing");
}

a10_wait_fire_missile() {
  self endon("death");
  maps\_utility::ent_flag_init("fire_missile");
  maps\_utility::ent_flag_wait("fire_missile");

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "sat_array_a10_missile_dive_1") {
      foreach(var_1 in level.enemytanks) {
        if(isDefined(var_1.script_noteworthy) && !var_1 maps\_vehicle_code::is_corpse() && var_1.script_noteworthy == "sat_array_enemy_01") {
          thread a10_fire_missiles(var_1, 1);
          wait 0.2;
        }
      }
    } else if(self.script_parameters == "crash_site_a10_missile_dive_1") {
      foreach(var_1 in level.crash_site_background_enemies) {
        if(isDefined(var_1.script_noteworthy) && !var_1 maps\_vehicle_code::is_corpse() && (var_1.script_noteworthy == "crash_site_background_enemy_01" || var_1.script_noteworthy == "crash_site_background_enemy_02")) {
          thread a10_fire_missiles(var_1, 1);
          wait 0.2;
        }
      }
    }
  } else
    thread a10_fire_missiles();

  maps\_utility::ent_flag_clear("fire_missile");
}

mig29_wait_fire_missile() {
  self endon("death");
  maps\_utility::ent_flag_init("fire_missile");
  maps\_utility::ent_flag_wait("fire_missile");

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "crash_site_mig29_gun_dive_1") {
      foreach(var_1 in level.allytanks) {
        if(isDefined(var_1.script_friendname) && !var_1 maps\_vehicle_code::is_corpse() && (var_1.script_friendname == "Boa" || var_1.script_friendname == "Banshee" || var_1.script_friendname == "Bullfrog")) {
          thread mig29_fire_missiles(var_1);
          wait 0.2;
        }
      }
    } else if(self.script_parameters == "crash_site_mig29_gun_dive_2") {
      if(isDefined(level.crash_site_a10_missile_dive_1) && !level.crash_site_a10_missile_dive_1 maps\_vehicle_code::is_corpse()) {
        self.kill_target = 1;
        thread mig29_fire_missiles(level.crash_site_a10_missile_dive_1, 1);
      }
    } else if(self.script_parameters == "crash_site_mig29_gun_dive_3") {
      if(isDefined(level.crash_site_a10_gun_dive_1) && !level.crash_site_a10_gun_dive_1 maps\_vehicle_code::is_corpse()) {
        self.kill_target = 1;
        thread mig29_fire_missiles(level.crash_site_a10_gun_dive_1, 1);
      }
    } else if(self.script_parameters == "intro_mig29_missile_c17_01") {
      if(isDefined(level.crashedc17_missile_org)) {
        thread mig29_fire_missiles(level.crashedc17_missile_org, 1);
      }
    } else if(self.script_parameters == "intro_mig29_missile_c17_02") {
      foreach(var_1 in level.intro_allies_killed_by_mig) {
        thread mig29_fire_missiles(var_1);
        wait 0.2;
      }
    } else if(self.script_parameters == "air_strip_ambient_mig29_missile_dive_1") {
      if(isDefined(level.air_strip_ambient_a10_gun_dive_1) && !level.air_strip_ambient_a10_gun_dive_1 maps\_vehicle_code::is_corpse()) {
        self.kill_target = 1;
        thread mig29_fire_missiles(level.air_strip_ambient_a10_gun_dive_1, 1);
      }
    } else if(self.script_parameters == "air_strip_ambient_mig29_missile_dive_2") {
      if(isDefined(level.air_strip_ambient_a10_gun_dive_2) && !level.air_strip_ambient_a10_gun_dive_2 maps\_vehicle_code::is_corpse()) {
        self.kill_target = 1;
        thread mig29_fire_missiles(level.air_strip_ambient_a10_gun_dive_2, 1);
      }
    } else if(self.script_parameters == "air_strip_ambient_mig29_missile_dive_3") {
      if(isDefined(level.air_strip_ambient_a10_gun_dive_3) && !level.air_strip_ambient_a10_gun_dive_3 maps\_vehicle_code::is_corpse()) {
        self.kill_target = 1;
        thread mig29_fire_missiles(level.air_strip_ambient_a10_gun_dive_3, 1);
      }
    } else if(self.script_parameters == "base_array_ambient_mig29_missile_dive_1") {
      if(isDefined(level.base_array_ambient_a10_gun_dive_1) && !level.base_array_ambient_a10_gun_dive_1 maps\_vehicle_code::is_corpse()) {
        self.kill_target = 1;
        thread mig29_fire_missiles(level.base_array_ambient_a10_gun_dive_1, 1);
      }
    } else if(self.script_parameters == "base_array_ambient_mig29_missile_dive_2") {
      if(isDefined(level.base_array_ambient_a10_gun_dive_2) && !level.base_array_ambient_a10_gun_dive_2 maps\_vehicle_code::is_corpse()) {
        self.kill_target = 1;
        thread mig29_fire_missiles(level.base_array_ambient_a10_gun_dive_2, 1);
      }
    } else if(self.script_parameters == "base_array_ambient_mig29_missile_dive_3") {
      if(isDefined(level.base_array_ambient_a10_gun_dive_3) && !level.base_array_ambient_a10_gun_dive_3 maps\_vehicle_code::is_corpse()) {
        self.kill_target = 1;
        thread mig29_fire_missiles(level.base_array_ambient_a10_gun_dive_3, 1);
      }
    }
  } else
    thread mig29_fire_missiles();

  maps\_utility::ent_flag_clear("fire_missile");
}

a10_missile_set_target(var_0) {
  var_0 endon("death");
  wait 0.2;
  self missile_settargetent(var_0);

  if(!var_0 maps\satfarm_code::istank() && isDefined(var_0.godmode) && var_0.godmode == 1) {
    var_0 maps\_vehicle::godoff();
  }

  self waittill("death");

  if(isDefined(var_0) && var_0 maps\satfarm_code::istank()) {
    var_0 thread maps\satfarm_code::handle_tank_death();
  }
}

mig29_missile_set_target(var_0) {
  var_0 endon("death");
  wait 0.2;
  self missile_settargetent(var_0);

  if(!var_0 maps\satfarm_code::istank() && isDefined(var_0.godmode) && var_0.godmode == 1) {
    var_0 maps\_vehicle::godoff();
  }

  self waittill("death");

  if(isDefined(var_0) && var_0 maps\satfarm_code::istank()) {
    var_0 thread maps\satfarm_code::handle_tank_death();
  }
}

a10_fire_missiles(var_0, var_1) {
  var_0 endon("death");
  self playSound("satf_missile_launch");
  var_2 = self gettagorigin("tag_origin");
  var_3 = var_2 + anglesToForward(self gettagangles("tag_origin") + (0, 0, 30)) * 100;
  var_4 = magicbullet("AGM_65_satfarm", var_2, var_3);
  var_4.angles = self gettagangles("tag_origin");
  var_5 = self;

  if(isDefined(var_0)) {
    var_4 thread a10_missile_set_target(var_0);

    if(isDefined(var_1)) {
      var_4 thread monitor_missile_distance(14400, var_0, var_5);
    }
  }
}

mig29_fire_missiles(var_0, var_1) {
  var_0 endon("death");
  self playSound("satf_missile_launch");
  var_2 = self gettagorigin("tag_origin");
  var_3 = var_2 + anglesToForward(self gettagangles("tag_origin") + (0, 0, 30)) * 100;
  var_4 = magicbullet("AGM_65_satfarm", var_2, var_3);
  var_4.angles = self gettagangles("tag_origin");
  var_5 = self;

  if(isDefined(var_0)) {
    var_4 thread mig29_missile_set_target(var_0);

    if(isDefined(var_1)) {
      var_4 thread monitor_missile_distance(14400, var_0, var_5);
    }
  }
}

monitor_missile_distance(var_0, var_1, var_2) {
  var_1 endon("death");

  while(isDefined(self) && isDefined(var_1) && distancesquared(self.origin, var_1.origin) > var_0) {
    wait 0.05;
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(self)) {
    playFX(level._effect["vfx_exp_sraam_no_missiles"], self.origin, anglesToForward(self.angles));
    self delete();
    wait 0.1;
  }

  if(isDefined(var_2.kill_target) && var_2.kill_target == 1) {
    if(!isDefined(var_1)) {
      return;
    }
    var_1 playSound("satf_agm65_impact");

    if(var_1 maps\_vehicle::isvehicle()) {
      var_1 maps\_vehicle::godoff();

      if(var_1 maps\satfarm_code::istank()) {
        var_1 thread maps\satfarm_code::handle_tank_death();
      } else {
        var_1 kill();
      }
    }

    wait 0.25;

    if(isDefined(var_1)) {
      var_1 delete();
    }
  } else {
    if(!isDefined(var_1)) {
      return;
    }
    if(isDefined(level.crashedc17_missile_org) && var_1 == level.crashedc17_missile_org) {
      return;
    }
    return;
  }
}

a10_30mm_fire() {
  self endon("death");
  self endon("stop_firing");

  if(isDefined(self.script_parameters) && self.script_parameters == "no_magic_bullet") {
    self.no_magic_bullet = 1;
  }

  self playLoopSound("satf_gatling_loop");

  for(;;) {
    var_0 = anglesToForward(self.angles);
    var_1 = self gettagorigin("tag_gun");
    var_2 = var_1 + var_0 * 999999999;

    if(!isDefined(self.no_magic_bullet)) {
      magicbullet("a10_30mm_player_satfarm", var_1 + var_0, var_2);
    }

    playFXOnTag(level._effect["a10_muzzle_flash"], self, "tag_gun");
    earthquake(0.2, 0.05, self.origin, 1000);
    wait 0.1;
  }
}

mig29_fire() {
  self endon("death");
  self endon("stop_firing");
  self playLoopSound("satf_gatling_loop");

  if(isDefined(self.script_parameters) && self.script_parameters == "no_magic_bullet") {
    self.no_magic_bullet = 1;
  }

  for(;;) {
    var_0 = anglesToForward(self.angles);
    var_1 = self gettagorigin("tag_flash");
    var_2 = var_1 + var_0 * 999999999;

    if(!isDefined(self.no_magic_bullet)) {
      magicbullet("a10_30mm_player_satfarm", var_1 + var_0, var_2);
    }

    playFXOnTag(level._effect["a10_muzzle_flash"], self, "tag_flash");
    earthquake(0.2, 0.05, self.origin, 1000);
    wait 0.1;
  }
}

mig29_afterburners_node_wait() {
  self endon("death");
  maps\_utility::ent_flag_init("start_afterburners");
  maps\_utility::ent_flag_wait("start_afterburners");
  thread common_scripts\utility::play_sound_in_space("satf_mig29_sonic_boom", self.origin);
  thread vehicle_scripts\_mig29::playafterburner();
}

wait_kill_me(var_0) {
  maps\_utility::ent_flag_init("kill_me");
  maps\_utility::ent_flag_wait("kill_me");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0) && var_0 == "mig29") {
    stopFXOnTag(level._effect["contrail"], self, "tag_right_wingtip");
    stopFXOnTag(level._effect["contrail"], self, "tag_left_wingtip");
  }

  if(!isDefined(self)) {
    return;
  }
  self playSound("satf_agm65_impact");

  if(maps\_vehicle::isvehicle()) {
    maps\_vehicle::godoff();
    self kill();
  }

  wait 0.05;

  if(isDefined(self)) {
    self delete();
  }
}