/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_dnk_code.gsc
**************************************************/

init_dnk_code() {
  while(!isDefined(level.players) || level.players.size < 1)
    waitframe();

  thread init_dnk_debug();
  thread ship_tilting_init();
  thread audio_log_init();
  thread escape_init();
}

init_dnk_debug() {}

___________________ship_tilting___________________() {}

ship_tilting_init() {
  common_scripts\utility::flag_init("flag_ship_tilting_enabled");
  common_scripts\utility::flag_set("flag_ship_tilting_enabled");
  level.groundrefent = spawn("script_model", (0, 0, 0));
  thread maps\mp\_utility::_id_6F74(::ship_tilting_camera_tilt_init);
  thread ship_tilting_tilt_timer();
  thread ship_tilting_object_setup();
  thread ship_tilting_tilt_controller();
  thread ship_tilting_water_tilt();
}

ship_tilting_tilt_timer() {
  var_0 = 40;
  var_1 = 60;
  var_2 = 20;
  var_3 = 40;
  level.shiptiltingtimermin = var_0;
  level.shiptiltingtimermax = var_1;
  level thread handle_forced_ship_tilt();

  for(;;) {
    level common_scripts\utility::_id_A70D(_randomintrange(level.shiptiltingtimermin, level.shiptiltingtimermax), level, "force_ship_to_tilt");

    if(common_scripts\utility::_id_3C77("flag_ship_tilting_enabled"))
      level notify("ship_tilting_change_direction");
  }
}

handle_forced_ship_tilt() {
  for(;;) {
    if(!common_scripts\utility::_id_562E(level.ship_is_tilting)) {
      wait 1;

      if(!common_scripts\utility::_id_562E(level.ship_is_tilting) && common_scripts\utility::_id_562E(level.trucks_are_port_locked))
        level notify("force_ship_to_tilt");
    }

    waitframe();
  }
}

ship_tilting_camera_tilt_init() {
  self waittill("zombie_player_spawn_finished");
  self playersetgroundreferenceent(level.groundrefent);
}

ship_tilting_object_setup() {
  var_0 = getEntArray("ship_tilting_org", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5.classname) {
        case "script_model":
          var_2.tiltermodel = var_5;
          var_5 linktosynchronizedparent(var_2);
          break;
        case "script_brushmodel":
          var_2.tilterclip = var_5;
          var_5 linktosynchronizedparent(var_2);
          break;
        case "script_origin":
          if(var_5._id_0165 == "ship_tilting_org_starboard")
            var_2.starboardorigin = var_5.origin;
          else if(var_5._id_0165 == "ship_tilting_org_port")
            var_2.portorigin = var_5.origin;

          break;
        case "trigger_multiple":
          var_2.safetytrigger = var_5;
          var_5 enablelinkto();
          var_5 linktosynchronizedparent(var_2);
          var_5 thread ship_tilting_collision_backup();
          break;
      }
    }

    var_2._id_6C55 = var_2.origin;
    var_2 thread ship_tilting_object_movement();
  }
}

ship_tilting_tilt_controller() {
  thread ship_tilting_camera_tilt();

  if(!isDefined(level.tiltdirection)) {
    var_0 = _randomintrange(0, 2);

    if(var_0 == 0)
      level.tiltdirection = "starboard";
    else
      level.tiltdirection = "port";
  }

  for(;;) {
    level waittill("ship_tilting_change_direction");

    if(common_scripts\utility::_id_562E(level.trucks_are_port_locked) && level.tiltdirection != "port") {
      continue;
    }
    level.ship_is_tilting = 1;
    thread ship_tilting_rumble();
    thread ship_tilting_zombie_stumble();

    if(level.tiltdirection == "port") {
      level.tiltdirection = "starboard";
      level notify("ship_tilting_starboard");
      continue;
    }

    if(level.tiltdirection == "starboard") {
      level.tiltdirection = "port";
      level notify("ship_tilting_port");
    }
  }
}

ship_tilting_object_movement() {
  for(;;) {
    var_0 = _randomfloatrange(6, 7);
    var_1 = var_0 * 0.3;
    var_2 = var_0 * 0.05;
    var_3 = level common_scripts\utility::waittill_any_return("ship_tilting_starboard", "ship_tilting_port");
    wait(var_0 * 0.2);
    self.tilterclip connectpaths();
    var_4 = _getnodearray("ship_tilting_collision_nodes", "targetname");

    if(isDefined(level._id_9068._id_9090) && _isarray(level._id_9068._id_9090))
      var_4 = common_scripts\utility::_id_0F73(var_4, level._id_9068._id_9090);

    self.tilterclip._id_A048 = var_4;
    self.tilterclip._id_A045 = ::ship_tilting_unresolved_collision_func;

    switch (var_3) {
      case "ship_tilting_starboard":
        if(isDefined(self.starboardorigin)) {
          self moveto(self.starboardorigin, var_0, var_1, var_2);
          _id_0378::_id_8D74("start_vehicle_slide", var_0, "ship_tilting_starboard");
        } else {
          self moveto(self._id_6C55, var_0, var_1, var_2);
          _id_0378::_id_8D74("start_vehicle_slide", var_0, "ship_tilting_original");
        }

        break;
      case "ship_tilting_port":
        if(isDefined(self.portorigin)) {
          self moveto(self.portorigin, var_0, var_1, var_2);
          _id_0378::_id_8D74("start_vehicle_slide", var_0, "ship_tilting_port");
        } else {
          self moveto(self._id_6C55, var_0, var_1, var_2);
          _id_0378::_id_8D74("start_vehicle_slide", var_0, "ship_tilting_original");
        }

        break;
    }

    thread ship_tilting_update_object_navmesh();
    wait(var_0);
    self notify("ship_tilting_object_movement_stop");
    self.tilterclip disconnectpaths();
  }
}

ship_tilting_update_object_navmesh() {
  self endon("ship_tilting_object_movement_stop");

  for(;;) {
    self.tilterclip disconnectpaths();
    wait 0.5;
  }
}

ship_tilting_collision_backup() {
  var_0 = _getnodearray("ship_tilting_collision_nodes", "targetname");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(isPlayer(var_1)) {
      _id_0488::_id_A047(var_1, 0);
      var_1 down_player();
    } else if(_isagent(var_1))
      var_1 _id_0547::_id_5A85(var_1.origin + (0, 0, 30), (var_1.origin - self.origin) * 2);

    waitframe();
  }
}

ship_tilting_unresolved_collision_func(var_0) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    _id_0488::_id_A047(var_0, 0);
    var_0 down_player();
  } else if(isDefined(var_0) && _isagent(var_0))
    var_0 _id_056D::_id_5A86();
}

ship_tilting_zombie_stumble() {
  var_0 = 0.5;
  var_1 = _id_0547::_id_4090("zombie_generic");

  foreach(var_3 in var_1) {
    if(_id_0547::_id_5565(var_3._id_0BA4, "traverse")) {
      continue;
    }
    var_4 = _randomfloat(1);

    if(var_4 > var_0) {
      var_5 = spawnStruct();
      var_5._id_959C = level.groundrefent;
      var_6 = _randomintrange(0, 2);
      var_7 = 4;

      switch (var_6) {
        case 0:
          var_5._id_9598 = "close";
          var_7 = 3;
          break;
        case 1:
          var_5._id_9598 = "medium";
          var_7 = 2;
          break;
      }

      if(!isDefined(var_5._id_9598))
        var_5._id_9598 = "close";

      var_8 = _randomfloatrange(0.25, 1.5);
      var_3 maps\mp\_utility::_id_2CED(var_8, ::ship_tilting_zombie_stumble_execute, var_5);
      var_3 maps\mp\_utility::_id_2CED(var_8 + var_7, ::ship_tilting_zombie_stumble_cleanup, var_5);
    }
  }
}

ship_tilting_zombie_stumble_execute(var_0) {
  if(isalive(self) && self._id_0BA4 != "traverse") {
    self.was_ship_tilt_tackled = 1;
    _id_0547::_id_959B(var_0);
  }
}

ship_tilting_zombie_stumble_cleanup(var_0) {
  if(isalive(self) && common_scripts\utility::_id_562E(self.was_ship_tilt_tackled)) {
    self.was_ship_tilt_tackled = 0;
    _id_0547::_id_959A(var_0);
  }
}

ship_tilting_water_tilt() {
  var_0 = getEntArray("ship_tilting_water_plane", "script_noteworthy");
  var_1 = _randomfloatrange(6, 7);
  var_2 = var_1 * 0.3;
  var_3 = var_1 * 0.05;

  for(;;) {
    var_4 = level common_scripts\utility::waittill_any_return("ship_tilting_starboard", "ship_tilting_port");
    wait(var_1 * 0.2);

    switch (var_4) {
      case "ship_tilting_starboard":
        thread fx_water_tilt_1();

        foreach(var_6 in var_0)
        var_6 rotateto((1, 0, 0), var_1, var_2, var_3);

        break;
      case "ship_tilting_port":
        thread fx_water_tilt_2();

        foreach(var_6 in var_0)
        var_6 rotateto((-1, 0, 0), var_1, var_2, var_3);

        break;
    }
  }
}

fx_water_tilt_1() {
  var_0 = _randomfloatrange(3, 5);
  level thread common_scripts\_exploder::_id_088E(207);
  wait(var_0);
  level thread common_scripts\_exploder::_id_088E(205);
}

fx_water_tilt_2() {
  var_0 = _randomfloatrange(3, 5);
  level thread common_scripts\_exploder::_id_088E(206);
  wait(var_0);
  level thread common_scripts\_exploder::_id_088E(204);
}

ship_tilting_camera_tilt() {
  for(;;) {
    var_0 = _randomfloatrange(5, 7);
    var_1 = level common_scripts\utility::waittill_any_return("ship_tilting_starboard", "ship_tilting_port");
    _id_0378::_id_8D74("zmb_dnk_ship_tilt", var_1);

    if(var_1 == "ship_tilting_starboard") {
      level.groundrefent rotateto((8, 0, 0), var_0, var_0 * 0.5, var_0 * 0.5);
      wait(var_0);
      level.groundrefent rotateto((5, 0, 0), var_0, var_0 * 0.5, var_0 * 0.5);
    } else if(var_1 == "ship_tilting_port") {
      level.groundrefent rotateto((-8, 0, 0), var_0, var_0 * 0.5, var_0 * 0.5);
      wait(var_0);
      level.groundrefent rotateto((-5, 0, 0), var_0, var_0 * 0.5, var_0 * 0.5);
    }

    foreach(var_3 in level.players)
    var_3 stoprumble("slide_loop");
  }
}

ship_tilting_rumble() {
  foreach(var_1 in level.players)
  var_1 playrumblelooponentity("slide_loop");
}

debug_ship_tilting_tilt_ship() {
  level notify("ship_tilting_change_direction");
}

debug_ship_tilting_disable() {
  common_scripts\utility::_id_3C7B("flag_ship_tilting_enabled");
}

______trap______() {}

water_trap_init() {
  level._id_9CFB = 1;
  level._id_62B5 = 1;
  level._effect["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_small");
  level._effect["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink_small");
  level._id_9CD1["ready_to_active"] = undefined;
  level._id_9CD1["active_to_cooldown"] = undefined;
  level._id_9CD1["cooldown_to_active"] = undefined;
  var_0 = common_scripts\utility::_id_46B5("trap_ship_tilting_water", "script_noteworthy");
  var_0.damagetrigger = _getent("ship_tilting_trap_damage_trig", "targetname");
  var_0.vfxplane = _getent("ship_tilting_trap_vfx_plane", "targetname");
  var_0.vfxplane hide();
  var_0 thread water_trap_movement();
  thread _id_0546::_id_9CC6("trap_ship_tilting_water", "active", ::water_trap);
}

water_trap(var_0) {
  level.trapwater = var_0 common_scripts\utility::_id_8FFC();
  level.trapwater._id_9CBB = "trap_ship_tilting_water";
  level.trapwater._id_9C92 = var_0;
  _id_0378::_id_8D74("start_water_trap", var_0);
  var_1 = undefined;

  if(isDefined(var_0.target)) {
    var_2 = common_scripts\utility::_id_46B7(var_0.target, "targetname");

    foreach(var_4 in var_2) {
      if(_id_0547::_id_5565(var_4._id_0165, "activate_model_dest"))
        var_1 = var_4;
    }
  }

  var_6 = var_0._id_6298.angles;
  var_0 thread water_trap_rotate_lever(var_6, var_1);
  var_0 thread water_trap_damage();
}

water_trap_rotate_lever(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  self._id_6298 rotateto(var_1.angles, 0.35, 0.1, 0.1);
  wait 2;
  self._id_6298 rotateto(var_0, 0.35, 0.1, 0.1);
}

water_trap_movement() {
  var_0 = _randomfloatrange(6, 7);
  var_1 = var_0 * 0.3;
  var_2 = var_0 * 0.05;
  var_3 = _getent("ship_tilting_trap_org", "targetname");
  self.damagetrigger enablelinkto();
  self.damagetrigger linktosynchronizedparent(var_3);

  for(;;) {
    var_4 = level common_scripts\utility::waittill_any_return("ship_tilting_starboard", "ship_tilting_port");
    wait(var_0 * 0.2);

    switch (var_4) {
      case "ship_tilting_starboard":
        var_3 moveto((-216, 1968, -296), var_0, var_1, var_2);
        break;
      case "ship_tilting_port":
        var_3 moveto((312, 1968, -296), var_0, var_1, var_2);
        break;
    }
  }
}

water_trap_damage() {
  self._id_565F = 1;
  self.vfxplane show();
  level thread common_scripts\_exploder::_id_088E(210);
  thread water_trap_damage_zombies();
  thread water_trap_damage_players();
  common_scripts\utility::_id_A70A("cooldown", "no_power", "ready", "deactivate");
  self.vfxplane hide();
  self._id_565F = 0;
  level thread common_scripts\_exploder::_id_2A6D(210, undefined, 1);
}

water_trap_damage_zombies() {
  while(self._id_565F) {
    var_0 = _id_0547::_id_408F();

    foreach(var_2 in var_0) {
      if(var_2 istouching(self.damagetrigger)) {
        var_3 = gettime();

        if(isalive(var_2) && var_2._id_0BA4 != "traverse") {
          if(!isDefined(var_2.waszappedlast) || isDefined(var_2.waszappedlast) && var_3 > var_2.waszappedlast + 500) {
            if(var_2 _id_0547::_id_580A())
              var_2 dodamage(var_2.health * 0.1, self.origin, level.trapwater, level.trapwater, "MOD_ENERGY", "trap_zm_mp");
            else {
              var_2 thread _id_0546::mark_electrified();
              var_2 dodamage(var_2.maxhealth * 0.25, self.origin, level.trapwater, level.trapwater, "MOD_ENERGY", "trap_zm_mp");

              if(!isDefined(var_2.hitbytrap)) {
                foreach(var_5 in level.players) {
                  var_5 maps\mp\gametypes\zombies::_id_47C7("kill_trap");
                  var_2.hitbytrap = 1;
                }
              }
            }

            if(isalive(var_2))
              var_2.waszappedlast = gettime();
          }

          waitframe();
        }
      }
    }

    wait 0.15;
  }
}

water_trap_damage_players() {
  while(self._id_565F) {
    foreach(var_1 in level.players) {
      if(!isalive(var_1)) {
        continue;
      }
      if(_id_0547::_id_577E(var_1)) {
        continue;
      }
      var_2 = gettime();

      if(!isDefined(var_1.waszappedlast))
        var_1.waszappedlast = gettime();

      if(var_1 istouching(self.damagetrigger)) {
        if(isalive(var_1) && !_id_0547::_id_577E(var_1) && var_2 > var_1.waszappedlast + 500) {
          var_1 _id_0378::_id_8D74("water_trap_damage_player");
          var_1 dodamage(5, self.origin, undefined, undefined, "MOD_ENERGY");
          var_1.waszappedlast = gettime();
          waitframe();
        }
      }
    }

    wait 0.15;
  }
}

___________________sinking___________________() {}

sinking_init() {
  level.kpishouldchain = 1;
  thread sinking_vo();
  level.keypointinteractholdtime = 4;
  var_0 = common_scripts\utility::_id_46B7("sinking_vfx_struct", "targetname");
  var_1 = getEntArray("keypoint_interact_trigger", "targetname");

  foreach(var_3 in var_0) {
    var_3.interacttrigger = common_scripts\utility::_id_4461(var_3.origin, var_1);
    var_3.interacttrigger._id_3F76 = spawn("script_model", var_3.origin);
    var_3.interacttrigger._id_3F76 setModel("tag_origin");
    var_3.interacttrigger._id_3F76.angles = var_3.angles;
    var_3.interacttrigger thread sinking_init_leak_vfx();
    var_3.interacttrigger _id_0378::_id_8D74("aud_repair_leaking_water");
    var_3.interacttrigger thread sinking_waitfor_interact_complete();
  }
}

sinking_init_leak_vfx() {
  while(!isDefined(self._id_565F) || !self._id_565F)
    wait 1;

  switch (self.setlookatent) {
    case "sinking_vfx_water":
      _playfxontag(level._effect["zmb_dnk_water_busted_pipe"], self._id_3F76, "tag_origin");
      break;
    case "sinking_vfx_metal":
      _playfxontag(level._effect["zmb_dnk_water_busted_pipe_metal"], self._id_3F76, "tag_origin");
      break;
    default:
      break;
  }
}

sinking_waitfor_interact_complete() {
  level endon("sg_obj_timeout");
  self waittill("interact_completed");
  _killfxontag(level._effect["water_jet"], self._id_3F76, "tag_origin");

  if(isDefined(self._id_3F76))
    self._id_3F76 delete();
}

___________________visions____________________() {}

visions_init() {
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("visions", ::visions_run, 120, 1, 0);
}

visions_run(var_0) {
  thread maps\mp\_utility::_id_6F74(::visions_state_apply, undefined, "kill_visions_threads");
  thread maps\mp\_utility::_id_6F74(::visions_end, undefined, "kill_visions_threads");
  thread visions_vo();
  thread visions_fake_zombie_spawn();
  thread visions_footprints_logic(1);
  var_1 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("dnk_ext_visions_count");
  var_2 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_player_level_extension");
  var_1 = int(var_1 * var_2);
  _id_0547::_id_7BA9(maps\mp\zombies\sg_events_v1\extermination::exterminationkillcounter);
  level thread maps\mp\zombies\sg_events_v1\extermination::notify_on_extermination_kill_requirement(var_1);
  [var_4, var_5] = common_scripts\utility::_id_A70E(level, "sg_obj_timeout", level, "round complete", level, "extermination complete");
  _id_0547::_id_2D8C(maps\mp\zombies\sg_events_v1\extermination::exterminationkillcounter);

  if(var_4 == "sg_obj_timeout")
    return 0;
  else
    return 1;
}

visions_fake_zombie_spawn(var_0, var_1, var_2) {
  level endon("stop_fake_zombie_spawning");

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_0))
    var_0 = 100;

  if(common_scripts\utility::_id_562E(var_1)) {
    level endon("round complete");
    level endon("sg_obj_end");
    level endon("sg_obj_timeout");
  }

  if(isDefined(var_2))
    level endon(var_2);

  for(;;) {
    level waittill("spawned_agent", var_3);

    if(isDefined(var_3) && _isagent(var_3)) {
      if(var_3._id_0A4B == "zombie_generic" || var_3._id_0A4B == "zombie_berserker") {
        var_4 = randomint(100);

        if(var_4 < var_0)
          var_3 visions_fake_zombie_setup();
      }
    }
  }
}

visions_fake_zombie_setup() {
  var_0 = self;
  var_0 thread visions_fake_zombie_visibility_cycle();
}

visions_fake_zombie_poof_radius_think() {
  self endon("death");
  var_0 = self;

  for(;;) {
    foreach(var_2 in level.players) {
      var_3 = distancesquared(var_0.origin, var_2.origin);

      if(var_3 < 30000 && common_scripts\utility::within_fov(var_2 getEye(), var_2 _meth_8566(), var_0.origin, _cos(80))) {
        var_0._id_1DEB = 1;
        var_0 thread hallucination_poof_fx();
        wait 0.25;
        var_0 _id_056D::_id_5A86();
      }
    }

    waitframe();
  }
}

visions_fake_zombie_visibility_cycle() {
  self endon("death");
  var_0 = self;
  var_1 = 1;
  var_2 = 3;
  var_3 = 2;
  var_4 = 5;

  for(;;) {
    foreach(var_6 in level.players) {
      var_7 = distancesquared(var_0.origin, var_6.origin);

      if(var_7 > 30000) {
        var_0 thread hallucination_poof_fx();
        wait 0.1;
        var_0 hide();
        var_0.hiddenbyvisions = 1;
        var_0.isinvisiblevisionzombie = 1;
        wait(_randomfloatrange(var_1, var_2));
        var_0 show();
        waitframe();
        var_0 thread hallucination_poof_fx();
        var_0.hiddenbyvisions = 0;
        var_0.isinvisiblevisionzombie = 0;
        wait(_randomfloatrange(var_3, var_4));
      }
    }

    waitframe();
  }
}

visions_footprints_logic(var_0) {
  if(common_scripts\utility::_id_562E(var_0)) {
    level endon("round complete");
    level endon("sg_obj_end");
    level endon("sg_obj_timeout");
  } else
    level endon("stop_fake_zombie_spawning");

  var_1 = _getent("ship_tilting_trap_damage_trig", "targetname");
  var_2 = getEntArray("footsteps_trigger", "targetname");
  var_2 = common_scripts\utility::_id_0F6F(var_2, var_1);

  for(;;) {
    var_3 = _id_0547::_id_408F();

    foreach(var_5 in var_3) {
      if(isalive(var_5) && var_5._id_0BA4 != "traverse" && common_scripts\utility::_id_562E(var_5.hiddenbyvisions)) {
        foreach(var_7 in var_2) {
          if(var_5 istouching(var_7)) {
            var_8 = common_scripts\utility::_id_348B(var_5.origin);

            switch (var_7._id_0165) {
              case "snow":
                playFX(level._effect["snow_chunk_impact"], var_8);
                break;
              case "water":
                playFX(level._effect["water_splash_small"], var_8);
                break;
            }

            break;
          }
        }
      }
    }

    waitframe();
  }
}

visions_state_apply() {
  thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::altered_state_apply(1);
}

visions_end() {
  level common_scripts\utility::_id_A70A("sg_obj_end", "sg_obj_timeout");
  self notify("altered_state_end");
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::altered_state_end_overlay(1);
  level notify("kill_visions_threads");
}

______floating_objects______() {}

floating_object_run() {
  level endon("altered_state_end");
  var_0 = common_scripts\utility::_id_46B7("floating_object_struct", "script_noteworthy");
  var_1 = ["whale", "rideauSwim", "rideauEmote", "jackHead", "brennerHead", "monkHead", "truck", "raft", "body"];
  var_2 = _randomintrange(6, 14);

  for(;;) {
    var_3 = spawnStruct();
    var_3._id_0186 = common_scripts\utility::random(var_0);
    var_4 = var_3._id_0186.origin[0] + _randomintrange(-50, 50);
    var_5 = var_3._id_0186.origin[1] + _randomintrange(-50, 50);
    var_6 = var_3._id_0186.origin[2] + _randomintrange(-150, 150);
    var_3._id_9087 = (var_4, var_5, var_6);
    var_3.objectname = common_scripts\utility::random(var_1);
    thread floating_object_spawn_object(var_3);
    wait(var_2);
  }
}

floating_object_spawn_object(var_0) {
  level endon("altered_state_end");
  var_0.modelorigin = spawn("script_origin", var_0._id_9087);
  var_1 = common_scripts\utility::_id_46B5(var_0._id_0186.target, "targetname");
  var_2 = undefined;

  switch (var_0.objectname) {
    case "whale":
      var_0.objectmodel = spawn("script_model", var_0._id_9087);
      var_0.objectmodel setModel("zmi_dead_whale_01");
      var_2 = 1;
      break;
    case "rideauSwim":
      var_0.objectmodel = spawn("script_model", var_0._id_9087);
      var_0.objectmodel setModel("zom_rideau_wholebody");
      var_0.objectmodel scriptmodelplayanim("mp_swimming_f", "rideauAnim");
      var_2 = 0;
      var_3 = vectortoangles(var_1.origin - var_0._id_9087);
      var_0.objectmodel.angles = var_3;
      break;
    case "rideauEmote":
      var_0.objectmodel = spawn("script_model", var_0._id_9087);
      var_0.objectmodel setModel("zom_rideau_wholebody");
      var_4 = ["mp_emote_jumpingjacks_loop"];
      var_5 = common_scripts\utility::random(var_4);
      var_0.objectmodel scriptmodelplayanim(var_5, "rideauAnim");
      var_2 = 1;
      break;
    case "jackHead":
      var_0.objectmodel = spawn("script_model", var_0._id_9087);
      var_0.objectmodel setModel("zmb_jack_in_the_box_part_01");
      var_2 = 1;
      break;
    case "brennerHead":
      var_0.objectmodel = spawn("script_model", var_0._id_9087);
      var_0.objectmodel setModel("jfull_npc_zom_fireman_head");
      var_2 = 1;
      break;
    case "monkHead":
      var_0.objectmodel = spawn("script_model", var_0._id_9087);
      var_0.objectmodel setModel("jp_npc_zom_monkhead");
      var_2 = 1;
      break;
    case "truck":
      var_0.objectmodel = spawn("script_model", var_0._id_9087);
      var_0.objectmodel setModel("rblg_usa_trans_cckw_static_04_snow");
      var_2 = 1;
      break;
    case "raft":
      var_0.objectmodel = spawn("script_model", var_0._id_9087);
      var_0.objectmodel setModel("bsh_life_raft_01_snow");
      var_2 = 1;
      break;
    case "body":
      var_0.objectmodel = spawn("script_model", var_0._id_9087);
      var_0.objectmodel setModel("zbr_dead_soldier_bat_01");
      var_2 = 1;
      break;
  }

  var_6 = 25;
  var_7 = 30;
  var_8 = _randomintrange(var_6, var_7);

  if(isDefined(var_0.objectmodel)) {
    var_0.objectmodel linktosynchronizedparent(var_0.modelorigin);

    if(common_scripts\utility::_id_562E(var_2)) {
      var_9 = _randomintrange(0, 360);
      var_10 = _randomintrange(0, 360);
      var_11 = _randomintrange(0, 360);
      var_0.objectmodel rotateto((var_9, var_10, var_11), 0.05);
      var_9 = _randomintrange(0, 360);
      var_10 = _randomintrange(0, 360);
      var_11 = _randomintrange(0, 360);
      var_0.modelorigin rotateto((var_9, var_10, var_11), var_8);
    }

    var_0.modelorigin moveto(var_1.origin, var_8);
    level common_scripts\utility::waittill_notify_or_timeout("altered_state_end", var_8);
    var_0.objectmodel thread floating_object_cleanup();
  }

  _iprintlnbold(var_0.objectname);
}

floating_object_cleanup() {
  hallucination_poof_fx();
  self delete();
}

___________________bomb_disposal___________________() {}

bomb_disposal_init() {
  level.keypointinteracttool = "search_dstry_bomb_defuse_mp";
  level.keypointinteracthint = &"ZOMBIE_DLC3_KEYPOINT_INTERACT_DEFUSE";
  level.keypointinteractholdtime = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("keypoint_interact_bomb_defuse_time");
  level.kpishouldchain = 1;
  thread bomb_disposal_bomb_setup();
  thread bomb_disposal_care_package_listen();
}

bomb_disposal_bomb_setup() {
  var_0 = getEntArray("bomb_diposal_bomb", "script_noteworthy");
  var_1 = getEntArray("keypoint_interact_trigger", "targetname");

  foreach(var_3 in var_0) {
    var_3.interacttrigger = common_scripts\utility::_id_4461(var_3.origin, var_1);
    var_3 thread bomb_disposal_bomb_waitfor_interact_complete();
  }
}

bomb_disposal_bomb_waitfor_interact_complete() {
  level endon("sg_obj_timeout");
  self.interacttrigger waittill("interact_completed");
  self delete();
}

bomb_disposal_care_package_listen() {
  level endon("sg_obj_timeout");
  level endon("sg_obj_end");
  var_0 = 0;

  for(;;) {
    foreach(var_2 in level.players)
    var_2.hasdisposalkit = 0;

    thread bomb_disposal_care_package_drop();
    level waittill("sg_keypoint_interact_completed");
    var_0++;

    if(var_0 >= level.keypointinteractkeypoints) {
      break;
    }
  }
}

bomb_disposal_care_package_drop() {
  level endon("sg_obj_timeout");
  level endon("sg_obj_end");
  var_0 = common_scripts\utility::_id_46B5("carepackage_dz", "targetname");
  level.mark_next_package_as_objective_package = 1;
  maps\mp\zombies\zombie_carepackage::zm_care_spawn(common_scripts\utility::random(level.players), var_0);
  var_1 = level common_scripts\utility::_id_A74D("zombies_crate_captured", 100);

  if(isDefined(var_1) && var_1 == "timeout")
    bomb_disposal_care_package_drop();
  else
    var_0 bomb_disposal_kit_spawn();
}

bomb_disposal_kit_spawn() {
  var_0 = spawn("script_model", _func_2E1(self.origin) + (0, 0, 4));
  var_0 setModel("npc_gen_s_and_d_bomb");
  var_0 hudoutlineenable(0, 0);
  var_0 _id_0547::_id_AC41(&"ZOMBIE_DLC3_BOMB_DISPOSAL_BOMB_PICKUP", (0, 0, 16));
  var_0 thread bomb_disposal_kit_listen_for_pickup();
}

bomb_disposal_kit_listen_for_pickup() {
  level endon("sg_keypoint_interact_completed");
  var_0 = self;
  var_0 waittill("player_used", var_1);
  level notify("sg_keypoint_interact_bomb_pickup");
  var_0 _id_0547::_id_AC40();
  var_0 delete();
  var_1.bombdisposaloldweapon = var_1 getcurrentprimaryweapon();
  var_1 _id_0586::_id_078C("sg_disposal_kit_zm");
  var_1 bomb_disposal_kit_pickup();
}

bomb_disposal_kit_pickup() {
  var_0 = self;
  var_0.hasdisposalkit = 1;
  var_0 _id_0586::_id_078E("sg_disposal_kit_zm");
  var_0 disableweaponswitch();
  var_0 allowcrouch(0);
  var_0 allowjump(0);
  var_0 waittill("weapon_change");

  while(var_0 isswitchingweapon())
    waitframe();

  var_0 enableweaponswitch();
  var_0 thread bomb_disposal_kit_waitfor_weapon_switch();
  var_0 thread bomb_disposal_kit_waitfor_defuse();
}

bomb_disposal_kit_waitfor_weapon_switch() {
  var_0 = self;
  level endon("sg_keypoint_interact_start");
  level endon("sg_keypoint_interact_incompleted");
  level endon("sg_keypoint_interact_completed");

  while(!var_0 isswitchingweapon())
    waitframe();

  var_0 notify("sg_bomb_disposal_weapon_switch");
  var_0 _id_0586::_id_0790("sg_disposal_kit_zm");
  var_0.hasdisposalkit = 0;
  var_0 _id_0586::_id_078E(var_0.bombdisposaloldweapon);
  var_0 allowcrouch(1);
  var_0 allowjump(1);

  while(var_0 isswitchingweapon())
    waitframe();

  var_0 bomb_disposal_kit_spawn();
}

bomb_disposal_kit_waitfor_defuse() {
  var_0 = self;
  var_0 endon("sg_bomb_disposal_weapon_switch");
  var_1 = level common_scripts\utility::waittill_any_return("sg_keypoint_interact_completed", "sg_keypoint_interact_incompleted");

  if(var_1 == "sg_keypoint_interact_incompleted") {
    waitframe();
    var_0 thread bomb_disposal_kit_pickup();
  } else if(var_1 == "sg_keypoint_interact_completed") {
    var_0 _id_0586::_id_0790("sg_disposal_kit_zm");
    var_0 _id_0586::_id_078E(var_0.bombdisposaloldweapon);
    var_0 allowcrouch(1);
    var_0 allowjump(1);
  }
}

___________________escape___________________() {}

escape_init() {
  var_0 = getEntArray("escape_boat_cleats", "script_noteworthy");
  var_1 = _getent("escape_boat", "targetname");

  foreach(var_3 in var_0)
  var_3 linkto(var_1);

  var_5 = _getent("escape_boat_rack", "targetname");
  var_1 linktosynchronizedparent(var_5, "rope_01", (0, -80, 0), (0, 0, 0));
  var_5 scriptmodelplayanimdeltamotion("s2_zdu_ship_boat_rack_idle_down");
}

escape_extra_run() {
  thread escape_higgins_raise();
}

#using_animtree("animated_props_zombies_DLC3_dnk");

escape_higgins_raise() {
  var_0 = getEntArray("escape_boat_cleats", "script_noteworthy");
  var_1 = _getent("escape_boat", "targetname");
  var_2 = _getent("escape_boat_rack", "targetname");
  var_2 scriptmodelplayanimdeltamotion("s2_zdu_ship_boat_rack_up");
  _playfxontag(level._effect["zmb_dnk_boat_water_pull"], var_1, "tag_origin");
  var_3 = _getanimlength(%s2_zdu_ship_boat_rack_up);
  var_1 _id_0378::_id_8D74("escape_boat_rise", var_3);
  wait(_getanimlength(%s2_zdu_ship_boat_rack_up));
  var_2 scriptmodelplayanimdeltamotion("s2_zdu_ship_boat_rack_idle_up");
  level notify("escape_ready");
}

escape_higgins_boat_think() {}

___________________defense___________________() {}

defense_extra_run() {
  thread defense_spawner_toggle();
}

defense_spawner_toggle() {
  common_scripts\utility::_id_3C7B("dnk_defense_drop_spawner_enabled");
  level waittill("sg_obj_end");
  common_scripts\utility::flag_set("dnk_defense_drop_spawner_enabled");
}

___________________audio_log___________________() {}

audio_log_init() {
  var_0 = _getent("lore_primary", "script_noteworthy");
  var_0._id_9D5E = _getent(var_0.target, "targetname");
  var_0 hide();
  var_0._id_9D5E common_scripts\utility::_id_9D9F();
  audio_log_listen(var_0);
}

audio_log_listen(var_0) {
  var_1 = _getent("audio_log_hanging_model", "targetname");
  var_1 setcandamage(1);
  var_1 waittill("damage");
  var_2 = var_0.origin - var_1.origin;
  var_3 = _sqrt(_abs(var_2[2] * 2 / 800));
  var_4 = 1 / var_3;
  var_5 = var_2 * (var_4, var_4, 0);
  var_1 movegravity(var_5, var_3);
  var_1 rotateto(var_0.angles, var_3);
  wait(var_3);
  var_1.origin = var_0.origin;
  var_1 delete();
  var_0 show();
  var_0._id_9D5E common_scripts\utility::_id_9DA3();
}

___________________quest_fish___________________() {}

ee_init() {
  thread ee_vision_state_intensity_controller();
  thread ee_follow_fish_uber_wall_setup();
  thread ee_conquer_fish_setup();
  thread ee_follow_fish_uber_receiver_setup();
  thread ee_get_part_setup();
  ee_init_flags();
  _id_0557::_id_786C();
  _id_0557::_id_7846("quest_fish", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_fish", "step_activate_gas", ::ee_activate_gas, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_fish", "step_summon_fish", ::ee_summon_fish, maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_small, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_fish", "step_follow_fish", ::ee_follow_fish, maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_small, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_fish", "step_conquer_fish", ::ee_conquer_fish, maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_smallish, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_fish", "step_get_part", ::ee_get_part, ::dnk_completion_rewards, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("quest_fish");
}

dnk_completion_rewards() {
  maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_med();

  foreach(var_1 in level.players) {
    var_1 _id_056A::_id_4772(1);
    var_1 thread maps\mp\gametypes\_hud_message::_id_9102("zm_dlc3_ee_2_complete");

    if(_isonlinegame()) {
      var_1 _meth_8697(43, [5, 6]);
      var_1 thread maps\mp\gametypes\_hud_message::_id_9102("zm_camo_unlocked", 0);
    }
  }
}

ee_init_flags() {
  common_scripts\utility::flag_init("ee_activate_gas_gas_activated");
  common_scripts\utility::flag_init("ee_activate_gas_all_players_in_visions");
  common_scripts\utility::flag_init("ee_activate_gas_round_waited");
  common_scripts\utility::flag_init("ee_summon_fish_all_fish_destroyed");
  common_scripts\utility::flag_init("ee_summon_fish_round_waited");
  common_scripts\utility::flag_init("ee_follow_fish_all_ubers_destroyed");
  common_scripts\utility::flag_init("ship_to_void");
  common_scripts\utility::flag_init("ee_conquer_fish_entered_void");
  common_scripts\utility::flag_init("ee_conquer_fish_straub_complete");
  common_scripts\utility::flag_init("flag_ee_altered_state_finished");
  common_scripts\utility::flag_init("ee_get_part_sword_part_picked_up");
}

ee_vision_state_intensity_controller() {
  level endon("stop_fake_zombie_spawning");
  level waittill("ee_hallucination_intensity_increase");
  thread visions_fake_zombie_spawn(100, 0, "ee_hallucination_intensity_increase");
  level waittill("ee_hallucination_intensity_increase");
  thread visions_fake_zombie_spawn(75, 0, "ee_hallucination_intensity_increase");
  level waittill("ee_hallucination_intensity_increase");
  thread visions_fake_zombie_spawn(100, 0, "ee_hallucination_intensity_increase");
  level waittill("ee_hallucination_intensity_increase");
}

debug_increase_vision_state() {
  level notify("ee_hallucination_intensity_increase");
}

___________________step_activate_gas___________________() {}

ee_activate_gas() {
  thread ee_activate_gas_uber_think();
  common_scripts\utility::_id_3C9F("ee_activate_gas_gas_activated");
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_banned_objective("dnk_ext_visions");
  thread ee_activate_gas_all_players_wait_for_visions();
  common_scripts\utility::_id_3C9F("ee_activate_gas_all_players_in_visions");
  level.zmb_sg_banned_objectives = common_scripts\utility::_id_0F6F(level.zmb_sg_banned_objectives, "dnk_ext_visions");
  level notify("ee_hallucination_intensity_increase");
  thread wait_for_round_end("ee_activate_gas_round_waited");
  common_scripts\utility::_id_3C9F("ee_activate_gas_round_waited");
  _id_0557::_id_782D("quest_fish", "step_activate_gas");
}

ee_activate_gas_uber_think() {
  var_0 = _getent("ee_uberschnell_intact", "script_noteworthy");
  var_1 = _getent("ee_trig_dmg_uberschnell", "script_noteworthy");

  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(var_6 == "MELEE" || var_6 == "MOD_MELEE") {
      playFX(common_scripts\utility::_id_44F5("zmb_dnk_uber_explode"), var_1.origin);
      var_0 setModel("zdu_damaged_uber_01");
      playFX(common_scripts\utility::_id_44F5("zmb_dnk_uber_leak"), var_1.origin);
      _id_0378::_id_8D74("zmb_dnk_uber_leak_start", var_1.origin);
      common_scripts\utility::flag_set("ee_activate_gas_gas_activated");
      break;
    }
  }

  thread maps\mp\_utility::_id_6F74(::ee_activate_gas_player_grant_visions, undefined, "ee_activate_gas_all_players_in_visions");
}

ee_activate_gas_all_players_wait_for_visions() {
  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(common_scripts\utility::_id_562E(var_2.invisionstate))
        var_0++;
    }

    if(var_0 >= level.players.size) {
      break;
    }

    waitframe();
  }

  thread visions_footprints_logic();
  thread maps\mp\_utility::_id_6F74(::maintain_player_vision_state, undefined, "bucket_shuffle_complete");
  common_scripts\utility::flag_set("ee_activate_gas_all_players_in_visions");
  level notify("ee_activate_gas_all_players_in_visions");
}

ee_activate_gas_player_grant_visions() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = _getent("ee_trig_dmg_uberschnell", "script_noteworthy");

  while(!common_scripts\utility::_id_3C77("ee_activate_gas_all_players_in_visions")) {
    if(!common_scripts\utility::_id_562E(var_0.invisionstate)) {
      var_2 = distancesquared(var_0.origin, var_1.origin);

      if(var_2 < 20000) {
        var_0.invisionstate = 1;
        var_0 thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::altered_state_apply(1);
        var_0 thread ee_activate_gas_player_visions_timeout();
        var_0 thread ee_activate_gas_player_visions_end();
      }
    }

    wait 0.25;
  }
}

ee_activate_gas_player_visions_timeout() {
  self endon("disconnect");
  var_0 = level common_scripts\utility::_id_A74D("ee_activate_gas_all_players_in_visions", 60);

  if(isDefined(var_0) && var_0 == "timeout")
    self notify("ee_fish_visions_timeout");
}

ee_activate_gas_player_visions_end() {
  self endon("disconnect");
  self waittill("ee_fish_visions_timeout");
  self notify("altered_state_end");

  if(isDefined(self.invisionstate))
    self.invisionstate = 0;
}

all_players_set_visions() {
  foreach(var_1 in level.players) {
    var_1.invisionstate = 1;
    var_1 thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::altered_state_apply(1);
    var_1 thread ee_activate_gas_player_visions_end();
  }
}

maintain_player_vision_state() {
  level endon("bucket_shuffle_complete");
  self endon("disconnect");

  for(;;) {
    level waittill("player_spawned");

    if(common_scripts\utility::_id_3C77("flag_ee_altered_state_finished")) {
      break;
    }

    if(!common_scripts\utility::_id_562E(self.invisionstate)) {
      self.invisionstate = 1;
      thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::altered_state_apply(1);
    }
  }
}

warp_gas_activated() {
  thread all_players_set_visions();
  common_scripts\utility::flag_set("ee_activate_gas_gas_activated");
  common_scripts\utility::flag_set("ee_activate_gas_all_players_in_visions");
  common_scripts\utility::flag_set("ee_activate_gas_round_waited");
}

___________________step_summon_fish___________________() {}

ee_summon_fish() {
  level.fishdestroyed = 0;
  thread ee_summon_fish_setup_fish();
  thread ee_summon_fish_wait_for_all_fish();
  common_scripts\utility::_id_3C9F("ee_summon_fish_all_fish_destroyed");
  thread wait_for_round_end("ee_summon_fish_round_waited");
  common_scripts\utility::_id_3C9F("ee_summon_fish_round_waited");
  ee_summon_fish_special_fish_spawn();
  _id_0557::_id_782D("quest_fish", "step_summon_fish");
}

ee_summon_fish_setup_fish() {
  var_0 = common_scripts\utility::_id_46B7("ee_vfx_flopping_fish", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2.damagetrigger = _getent(var_2.target, "targetname");
    var_2._id_3F76 = spawn("script_model", var_2.origin);
    var_2._id_3F76 setModel("tag_origin");
    var_2._id_3F76.angles = var_2.angles;
    var_2 thread ee_summon_fish_play_fx();
    var_2 thread ee_summon_fish_wait_for_damage();
  }
}

ee_summon_fish_wait_for_damage() {
  for(;;) {
    self.damagetrigger waittill("damage", var_0, var_1);

    if(isPlayer(var_1)) {
      break;
    }

    waitframe();
  }

  level.fishdestroyed++;
  self notify("Poof!");
  self._id_3F76 thread hallucination_poof_fx();
  _killfxontag(level._effect["fish_flop"], self._id_3F76, "tag_origin");
}

ee_summon_fish_play_fx() {
  self endon("Poof!");

  for(;;) {
    _playfxontag(level._effect["fish_flop"], self._id_3F76, "tag_origin");
    _id_0378::_id_8D74("zmb_fish_jump", self._id_3F76);
    wait 1.1;
  }
}

ee_summon_fish_wait_for_all_fish() {
  var_0 = common_scripts\utility::_id_46B7("ee_vfx_flopping_fish", "script_noteworthy");

  while(level.fishdestroyed < var_0.size)
    wait 1;

  common_scripts\utility::flag_set("ee_summon_fish_all_fish_destroyed");
}

ee_summon_fish_special_fish_spawn() {
  var_0 = common_scripts\utility::_id_46B5("ee_special_fish_start", "script_noteworthy");
  level.specialfish = spawn("script_model", var_0.origin);
  level.specialfish setModel("zdu_red_herring_obj_01");
  level.specialfish.angles = var_0.angles;
  level.specialfish scriptmodelplayanim("zmb_follow_the_fish_loop", undefined, 0, 0.75);
  _playfxontag(level._effect["fish_energy"], level.specialfish, "tag_origin");
}

warp_fish_summoned() {
  thread all_players_set_visions();
  common_scripts\utility::flag_set("ee_summon_fish_all_fish_destroyed");
  common_scripts\utility::flag_set("ee_summon_fish_round_waited");
}

___________________step_follow_fish___________________() {}

ee_follow_fish() {
  level.fishchargerequirement = 15;

  if(isDefined(level.specialfish))
    level.specialfish thread ee_follow_fish_fish_think();

  common_scripts\utility::_id_3C9F("ee_follow_fish_all_ubers_destroyed");
  _id_0557::_id_782D("quest_fish", "step_follow_fish");
}

ee_follow_fish_fish_think() {
  var_0 = common_scripts\utility::_id_46B5("ee_special_fish_start", "script_noteworthy");
  var_1 = common_scripts\utility::_id_46B5(var_0.target, "targetname");

  for(;;) {
    if(isDefined(var_1)) {
      if(isDefined(var_1._id_0165) && var_1._id_0165 == "ee_follow_fish_channeling_spot") {
        var_2 = common_scripts\utility::_id_46B7("ee_fish_uber_receiver_struct", "targetname");
        var_1.uberreceiverstruct = common_scripts\utility::_id_4461(var_1.origin, var_2);
        var_1.uberreceiverstruct thread ee_follow_fish_uber_give_to_fish();
        ee_follow_fish_teleport_to_destination(var_1);
        level notify("ee_follow_fish_channel_spot_reached");
        ee_follow_fish_uber_wall_spawn();
        level waittill("ee_follow_fish_uber_given");
      } else
        ee_follow_fish_move_to_destination(var_1);

      if(isDefined(var_1.target))
        var_1 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
      else {
        self hide();
        common_scripts\utility::flag_set("ee_follow_fish_all_ubers_destroyed");
        break;
      }

      var_3 = 0;

      while(!var_3) {
        foreach(var_5 in level.players) {
          var_6 = distancesquared(self.origin, var_5.origin);

          if(var_6 <= 90000)
            var_3 = 1;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

ee_follow_fish_move_to_destination(var_0) {
  var_1 = 75;
  var_2 = distance(self.origin, var_0.origin);
  var_3 = var_2 / var_1;
  self moveto(var_0.origin, var_3);
  self rotateto(var_0.angles, var_3);
  wait(var_3);
}

ee_follow_fish_teleport_to_destination(var_0) {
  thread hallucination_poof_fx();
  waitframe();
  self hide();
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  wait 2;
  self show();
  var_0 thread hallucination_poof_fx();
  wait 2;
  var_0.uberreceiverstruct thread hallucination_poof_fx();
  var_0.uberreceiverstruct.receivermodel show();
  var_0.uberreceiverstruct._id_241F solid();
}

ee_follow_fish_uber_receiver_setup() {
  var_0 = common_scripts\utility::_id_46B7("ee_fish_uber_receiver_struct", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");
    var_2.failsafe_nodes = [];

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "ee_fish_uber_use_trig":
          var_2.usetrigger = var_5;
          break;
        case "ee_fish_receiver_clip":
          var_2._id_241F = var_5;
          var_2._id_241F._id_A045 = ::ee_uber_reciever_unresolved_collide;
          var_5 notsolid();
          break;
        case "ee_fish_uber_receiver":
          var_2.receivermodel = var_5;
          var_5 hide();
          break;
        case "ee_fish_uber":
          var_2._id_9FE1 = var_5;
          var_5 hide();
          break;
        case "ee_fish_receiver_failsafe_node":
          var_2.failsafe_nodes = common_scripts\utility::_id_0F6F(var_2.failsafe_nodes, var_5);
          break;
      }
    }

    if(isDefined(var_2._id_241F) && isDefined(var_2.failsafe_nodes) && var_2.failsafe_nodes.size > 0)
      var_2._id_241F.my_uber_struct = var_2;
  }
}

ee_uber_reciever_unresolved_collide(var_0) {
  self._id_A048 = ee_uber_reciever_get_unresolved_collision_locs(self.my_uber_struct, var_0);
  _id_0488::_id_A047(var_0, 0);
}

ee_uber_reciever_get_unresolved_collision_locs(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0.failsafe_nodes) && _isarray(var_0.failsafe_nodes))
    var_2 = common_scripts\utility::_id_0F73(var_2, var_0.failsafe_nodes);

  if(isDefined(level._id_9068._id_9090) && _isarray(level._id_9068._id_9090))
    var_2 = common_scripts\utility::_id_0F73(var_2, level._id_9068._id_9090);

  return var_2;
}

ee_follow_fish_uber_wall_setup() {
  level.uberbuys = common_scripts\utility::_id_46B7("ee_uber_wall_buy_struct", "targetname");

  foreach(var_1 in level.uberbuys) {
    var_2 = getEntArray(var_1.target, "targetname");

    foreach(var_4 in var_2) {
      var_4 hide();

      if(var_4._id_0165 == "ee_uber_wall_buy_box")
        var_4 notsolid();
    }

    var_1 thread ee_follow_fish_uber_wall_used();
  }
}

ee_follow_fish_uber_wall_used() {
  self waittill("ee_follow_fish_uber_purchased");
  thread hallucination_poof_fx();
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0)
  var_2 delete();
}

ee_follow_fish_uber_wall_spawn() {
  var_0 = common_scripts\utility::random(level.uberbuys);
  level.uberbuys = common_scripts\utility::_id_0F93(level.uberbuys, var_0);
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 show();

    switch (var_3._id_0165) {
      case "ee_uber_wall_use_trig":
        var_0.usetrigger = var_3;
        var_0 thread ee_follow_fish_uber_wall_think();
        break;
      case "ee_uber_wall_buy_box":
        var_0.wallbox = var_3;
        break;
      case "ee_uber_wall_buy_uber":
        var_0._id_9FE1 = var_3;
        break;
      default:
        break;
    }
  }

  if(isDefined(var_0.usetrigger)) {
    var_5 = _id_0552::_id_7BE1(undefined, var_0.usetrigger);
    var_5._id_4028 = _id_0552::_id_44FF("dnk_uber_interact");
    var_5._id_401E = 3000;
  }
}

ee_follow_fish_uber_wall_think() {
  var_0 = self.usetrigger;

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1._id_62D6 >= 3000) {
      var_1 maps\mp\gametypes\zombies::_id_90F5(3000);
      var_1 _id_0585::_id_8555(undefined);
      self notify("ee_follow_fish_uber_purchased");
      break;
    }
  }
}

ee_follow_fish_uber_pickup() {
  var_0 = self;
  var_0.uberwalloldweapon = var_0 getcurrentprimaryweapon();

  if(!var_0 hasweapon("blimp_battery_zm"))
    var_0 _id_0586::_id_078C("blimp_battery_zm");

  var_0 _id_0586::_id_078E("blimp_battery_zm");
  var_0 disableweaponswitch();
  var_0 allowcrouch(0);
  var_0 allowjump(0);
  var_0 waittill("weapon_change");

  while(var_0 isswitchingweapon())
    waitframe();

  var_0 enableweaponswitch();
  var_0.hasuber = 1;
  var_0 thread ee_follow_fish_uber_drop();
}

ee_follow_fish_uber_drop(var_0) {
  level endon("ee_follow_fish_uber_given_start");

  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = self;

  while(!var_1 isswitchingweapon())
    waitframe();

  var_1 _id_0586::_id_0790("blimp_battery_zm");
  var_1 _id_0586::_id_078E(var_1.uberwalloldweapon);
  var_1 allowcrouch(1);
  var_1 allowjump(1);
  var_1.hasuber = 0;

  if(var_0)
    var_1 ee_follow_fish_uber_ground_spawn();
}

ee_follow_fish_uber_ground_spawn() {
  var_0 = spawn("script_model", _func_2E1(self.origin) + (0, 0, 4));
  var_0 setModel("npc_zom_uber_01");
  var_0 hudoutlineenable(0, 0);
  var_0 _id_0547::_id_AC41(&"ZOMBIE_DLC3_UBER_WALL_BUY_PICKUP", (0, 0, 16));
  var_0 waittill("player_used", var_1);
  var_0 _id_0547::_id_AC40();
  var_0 delete();
  var_1 ee_follow_fish_uber_pickup();
}

ee_follow_fish_uber_give_to_fish() {
  var_0 = self.usetrigger;

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_1 _id_0585::_id_9E12();

    if(var_2) {
      ee_follow_fish_uber_given(var_1);
      break;
    }

    waitframe();
  }
}

ee_follow_fish_uber_given(var_0) {
  level notify("ee_follow_fish_uber_given_start");
  self._id_9FE1 show();
  ee_follow_fish_uber_charge();
  wait 2;
  ee_follow_fish_uber_completed();
}

ee_follow_fish_uber_charge() {
  var_0 = spawn("script_model", self._id_9FE1.origin);
  var_0 setModel("tag_origin");
  var_0 maps\mp\mp_zombies_soul_collection::_id_170B(level.fishchargerequirement, 180, 100, "zombie_fish_uber_killed", undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 64));
  level.fishchargerequirement = level.fishchargerequirement + 5;
}

ee_follow_fish_uber_completed() {
  var_0 = _randomfloatrange(2, 4);
  var_1 = common_scripts\utility::random(level.players);

  if(isDefined(var_1))
    level thread ee_follow_fish_earthquake(var_0, var_1);

  wait 2;
  playFX(common_scripts\utility::_id_44F5("zmb_dnk_uber_leak"), self._id_9FE1.origin);
  level notify("ee_hallucination_intensity_increase");
  wait 2;
  level notify("ee_follow_fish_uber_given");
}

ee_follow_fish_earthquake(var_0, var_1) {
  _earthquake(0.4, var_0, var_1.origin, 850);
  _playrumblelooponposition("tank_rumble", var_1.origin);
  _id_0378::_id_8D74("ee_follow_fish_earthquake", var_0);
  wait(var_0);
  _stopallrumbles();
}

debug_give_uber() {
  ee_follow_fish_uber_completed();
}

warp_fish_followed() {
  thread all_players_set_visions();
}

___________________step_conquer_fish___________________() {}

ee_conquer_fish() {
  while(!common_scripts\utility::_id_562E(level._id_AC11))
    wait 0.5;

  if(level._id_A980 >= 9) {
    return;
  }
  while(level._id_A980 % 3 == 0)
    wait 0.5;

  while(!common_scripts\utility::_id_562E(level._id_AC11))
    wait 0.5;

  _id_056D::_id_8A6E(1);
  level.zmb_is_endless_wave = 1;
  wait 3;
  thread ee_conquer_fish_void_enter();
  common_scripts\utility::_id_3C9F("ee_conquer_fish_entered_void");
  thread ee_conquer_fish_void_setup();
  common_scripts\utility::_id_3C9F("ee_conquer_fish_straub_complete");
  thread ee_conquer_fish_bucket_shuffle_init();
  ee_conquer_fish_bucket_shuffle_completion();
  _id_0557::_id_782D("quest_fish", "step_conquer_fish");
}

ee_conquer_fish_setup() {
  var_0 = _getent("ee_conquer_fish_water_plane", "script_noteworthy");
  var_0 hide();
  level.numbucketshuffleassassins = 0;
}

ee_conquer_fish_void_enter() {
  if(common_scripts\utility::_id_3C77("ee_conquer_fish_entered_void")) {
    return;
  }
  _id_0378::_id_8D74("ctf_void_enter");

  foreach(var_1 in level.players) {
    thread _id_0547::_id_09E9(var_1, "void_fading");
    var_1 thread ee_conquer_fish_void_enter_fade();
  }

  level waittill("ee_conquer_fish_enter_void_fading");
  level notify("stop_fake_zombie_spawning");

  if(isDefined(level.all_drop_crates) && level.all_drop_crates.size > 0) {
    foreach(var_4 in level.all_drop_crates)
    var_4 hudoutlinedisableforclients(level.players);
  }

  level.groundrefent rotateto((0, 0, 0), 0.05);
  common_scripts\utility::_id_3C7B("flag_ship_tilting_enabled");
  var_6 = common_scripts\utility::_id_46B7("ee_bucket_shuffle_tp_to_void", "targetname");

  for(var_7 = 0; var_7 < level.players.size; var_7++) {
    level.players[var_7] setOrigin(var_6[var_7].origin);
    level.players[var_7] setplayerangles(var_6[var_7].angles);
    thread _id_0547::_id_7CF8(level.players[var_7], "void_fading");
  }

  var_8 = _id_0547::_id_408F();

  foreach(var_10 in var_8)
  var_10 _id_056D::_id_5A86();

  level._id_ABD3 = -10000;
  common_scripts\utility::flag_set("ship_to_void");
  level.zmb_locked_spawn_zones = ["zone_the_void"];
  common_scripts\utility::flag_set("ee_conquer_fish_entered_void");
}

ee_conquer_fish_void_enter_fade() {
  var_0 = self;

  if(!isDefined(var_0.entervoidoverlayfade))
    var_0.entervoidoverlayfade = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::altered_state_create_client_overlay("black", 0, var_0);

  var_1 = 4;
  var_2 = 1;
  var_0.entervoidoverlayfade.alpha = 0;
  var_0.entervoidoverlayfade fadeovertime(var_1);
  var_0.entervoidoverlayfade.alpha = 1;
  var_0 shellshock("zm_dnk_void_fade", var_1);
  wait(var_1);
  level notify("ee_conquer_fish_enter_void_fading");
  var_0.entervoidoverlayfade.alpha = 1;
  var_0.entervoidoverlayfade fadeovertime(var_2);
  var_0.entervoidoverlayfade.alpha = 0;
  _id_0378::_id_8D74("zmb_dnk_uber_leak_stop");
}

ee_conquer_fish_void_setup() {
  var_0 = getEntArray("ee_conquer_fish_platform", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 common_scripts\utility::_id_4CEB();

  var_4 = getEntArray("ee_conquer_fish_vignette_prop", "targetname");

  foreach(var_6 in var_4) {
    var_6 hide();
    var_6 notsolid();
  }

  var_8 = getEntArray("ee_conquer_fish_straub_clip", "targetname");

  foreach(var_10 in var_8)
  var_10 notsolid();

  var_12 = getEntArray("trig_ee_conquer_fish_spawn_platform", "targetname");

  foreach(var_14 in var_12)
  var_14 thread ee_conquer_fish_void_platform_think();

  thread ee_conquer_fish_void_platform_vignette_think();
  var_16 = getEntArray("vol_ee_conquer_fish_straub_platform", "targetname");

  foreach(var_18 in var_16)
  var_18 thread ee_conquer_fish_void_straub_vignette_init();

  level.voidfallteleportlocations = common_scripts\utility::_id_46B7("void_tp_platform_start", "targetname");
  thread ee_conquer_fish_void_fall_teleport();
}

ee_conquer_fish_void_fall_teleport() {
  var_0 = _getent("void_falling_teleport_trigger", "targetname");
  var_1 = 0;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2) && isalive(var_2)) {
      var_2 setOrigin(level.voidfallteleportlocations[var_1].origin);
      var_1++;

      if(var_1 >= level.voidfallteleportlocations.size)
        var_1 = 0;

      var_2 thread ee_conquer_fish_void_fall_damage();
    }
  }
}

ee_conquer_fish_void_fall_damage() {
  while(!self isonground())
    waitframe();

  down_player();
}

ee_conquer_fish_void_platform_think() {
  var_0 = self;
  var_1 = getEntArray(var_0.target, "targetname");
  var_0 waittill("trigger");

  foreach(var_3 in var_1) {
    var_3 thread hallucination_poof_fx();
    var_3 thread platform_fog_fx();
    var_3 common_scripts\utility::_id_8BE0();
  }
}

platform_fog_fx() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("tag_origin");
  var_0.angles = var_0.angles + (-90, 0, 0);
  _playfxontag(level._effect["zmb_dnk_altered_platform_mist"], var_0, "tag_origin");
}

ee_conquer_fish_void_platform_vignette_think() {
  common_scripts\utility::flag_init("flag_nest_platform_complete");
  common_scripts\utility::flag_init("flag_island_platform_complete");
  common_scripts\utility::flag_init("flag_berlin_platform_complete");
  var_0 = getEntArray("ee_conquer_fish_post_straub_platform_one", "targetname");
  var_1 = getEntArray("ee_conquer_fish_post_straub_platform_two", "targetname");
  var_2 = getEntArray("ee_conquer_fish_post_straub_platform_three", "targetname");
  level waittill("ee_conquer_fish_vignette_complete");
  common_scripts\utility::flag_set("flag_nest_platform_complete");

  foreach(var_4 in var_0) {
    var_4 thread hallucination_poof_fx();
    var_4 common_scripts\utility::_id_8BE0();
  }

  level waittill("ee_conquer_fish_vignette_complete");
  common_scripts\utility::flag_set("flag_island_platform_complete");

  foreach(var_4 in var_1) {
    var_4 thread hallucination_poof_fx();
    var_4 common_scripts\utility::_id_8BE0();
  }

  level waittill("ee_conquer_fish_vignette_complete");
  common_scripts\utility::flag_set("flag_berlin_platform_complete");

  foreach(var_4 in var_2) {
    var_4 thread hallucination_poof_fx();
    var_4 common_scripts\utility::_id_8BE0();
  }
}

_id_3D34() {
  level endon("bucket_shuffle_complete");

  for(;;) {
    _id_0378::_id_8D74("flare_fx");
    wait 0.75;
    level thread common_scripts\_exploder::_id_088E(240);
    wait(_randomintrange(5, 20));
  }
}

ee_conquer_fish_void_straub_vignette_init() {
  var_0 = self;
  wait_until_all_players_in_volume(var_0);
  wait 1;
  var_1 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_1 thread hallucination_poof_fx();
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("zom_straub_wholebody_dlc");
  var_2._id_00B9 = spawn("script_model", var_1.origin);
  var_2._id_00B9 setModel("zom_head_kier_dirt_org1_dlc");
  var_2._id_00B9 linkto(var_2, "j_spineupper", (0, 0, 0), (0, 0, 0));
  var_3 = undefined;

  switch (var_1._id_0165) {
    case "ee_conquer_fish_straub_vignette_one":
      level.voidfallteleportlocations = common_scripts\utility::_id_46B7("void_tp_platform_one", "targetname");
      var_1._id_5055 = "s2_zom_straub_table_cleaver_idle";
      var_1.idleanimlength = _getanimlength(%s2_zom_straub_table_cleaver_idle);
      var_1._id_9A8E = "npc_zom_med_knife_02";
      var_1._id_778F = getEntArray("ee_conquer_fish_tfr_prop", "script_noteworthy");
      var_1.straubvo = "zmb_dnk_stra_youmustbeklausfriendsthea2";
      var_1.straubclip = _getent("ee_conquer_fish_straub_clip_one", "script_noteworthy");
      var_1.straubclip solid();
      var_1 thread ee_conquer_fish_void_straub_vignette_play(var_2);
      var_4 = common_scripts\utility::_id_46B7("ee_conquer_fish_tfr_zombie_spawner", "targetname");
      var_1 ee_conquer_fish_void_straub_event(var_2, var_4, 15, "zombie_heavy");
      break;
    case "ee_conquer_fish_straub_vignette_two":
      level.voidfallteleportlocations = common_scripts\utility::_id_46B7("void_tp_platform_two", "targetname");
      level thread common_scripts\_exploder::_id_088E(203);
      var_1._id_5055 = "s2_zom_straub_window_gaze_idle";
      var_1.idleanimlength = _getanimlength(%s2_zom_straub_window_gaze_idle);
      var_1._id_9A8E = undefined;
      var_1._id_778F = undefined;
      var_1.straubvo = "zmb_dnk_stra_soyousurvivedthehellofmit_delay";
      var_1.straubclip = _getent("ee_conquer_fish_straub_clip_two", "script_noteworthy");
      var_1.straubclip solid();
      var_1 thread ee_conquer_fish_void_straub_vignette_play(var_2);
      var_4 = common_scripts\utility::_id_46B7("ee_conquer_fish_tds_zombie_spawner", "targetname");
      var_1 ee_conquer_fish_void_straub_event(var_2, var_4, 20, "zombie_assassin");
      maps\mp\gametypes\zombies::_id_0DB9(level.players[0], 1);
      break;
    case "ee_conquer_fish_straub_vignette_three":
      level.voidfallteleportlocations = common_scripts\utility::_id_46B7("void_tp_platform_three", "targetname");
      level thread common_scripts\_exploder::_id_088E(220);
      thread _id_3D34();
      var_1._id_5055 = "s2_zom_straub_death_straub";
      var_1.idleanimlength = _getanimlength(%s2_zom_straub_death_straub);
      var_1.exitanim = "s2_zom_straub_window_gaze_exit_2";
      var_1.exitanimlength = _getanimlength(%s2_zom_straub_window_gaze_exit_2);
      var_1._id_9A8E = undefined;
      var_1._id_778F = getEntArray("ee_conquer_fish_vignette_three_prop", "script_noteworthy");
      var_1.straubvo = "zmb_dnk_stra_vidlog_straubdeath1";
      var_1.straubvotwo = "zmb_dnk_stra_vidlog_straubdeath2";
      var_1.straubclip = _getent("ee_conquer_fish_straub_clip_three", "script_noteworthy");
      var_1.straubclip solid();
      var_1.straubclip linktosynchronizedparent(var_2);
      var_1 thread ee_conquer_fish_void_straub_vignette_play(var_2, 1);
      var_4 = common_scripts\utility::_id_46B7("ee_conquer_fish_tst_zombie_spawner", "targetname");
      var_1 ee_conquer_fish_void_straub_event(var_2, var_4, 25, "zombie_sizzler");
      common_scripts\utility::flag_set("ee_conquer_fish_straub_complete");
      break;
  }

  level notify("ee_conquer_fish_vignette_complete");
}

ee_conquer_fish_void_straub_vignette_play(var_0, var_1) {
  level endon("ee_conquer_fish_straub_vignette_intro_complete");
  var_2 = self;

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_2._id_9A8E)) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel(var_2._id_9A8E);
    var_3 linkto(var_0, "TAG_WEAPON_RIGHT", (0, 0, 0), (0, 0, 0));
    var_2._id_9A8E = var_3;
  }

  if(isDefined(var_2._id_778F)) {
    foreach(var_5 in var_2._id_778F) {
      var_5 thread hallucination_poof_fx();
      var_5 show();
    }
  }

  if(var_1)
    var_2 thread ee_conquer_fish_void_straub_final_vignette_zombies();

  var_0 scriptmodelplayanimdeltamotionfrompos(var_2._id_5055, var_2.origin, var_2.angles);
  var_0._id_00B9 scriptmodelplayanimdeltamotionfrompos(var_2._id_5055, var_2.origin, var_2.angles);
  var_2 ee_conquer_fish_void_straub_vignette_vo(var_0);

  if(var_1) {
    foreach(var_8 in level.straub_vignette_zombie) {
      if(isDefined(var_8)) {
        var_8 thread hallucination_poof_fx();
        var_8 delete();
      }
    }

    var_2 ee_conquer_fish_void_straub_final_vignette(var_0);
  }

  if(isDefined(var_2.straubclip))
    var_2.straubclip notsolid();

  level notify("ee_conquer_fish_straub_vignette_intro_complete");
}

ee_conquer_fish_void_straub_vignette_vo(var_0) {
  level endon("ee_conquer_fish_straub_vignette_intro_complete");
  var_1 = spawn("script_model", var_0.origin);

  if(isDefined(self.straubvo))
    maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players(self.straubvo, "interior", 0, var_1);

  if(isDefined(self.straubvotwo))
    maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players(self.straubvotwo, "interior", 0, var_1);
}

ee_conquer_fish_void_straub_event(var_0, var_1, var_2, var_3) {
  level endon("ee_conquer_fish_straub_event_complete");
  var_4 = 1;
  var_5 = 3;
  var_6 = 0;
  var_7 = undefined;
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Straub Combat Spawn Rate Max", "ee_conquer_fish_spawn_rate_max", var_5, var_5 / 2, 1, 1);
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::add_difficulty_setting("Straub Combat Total Zombies", "ee_conquer_fish_total_zombies", var_2, var_2 * 2, 1, 1);
  var_5 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("ee_conquer_fish_spawn_rate_max");
  var_2 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("ee_conquer_fish_total_zombies");
  level waittill("ee_conquer_fish_straub_vignette_intro_complete");
  var_0 thread hallucination_poof_fx();
  var_0 delete();
  var_0._id_00B9 delete();

  if(isDefined(self._id_9A8E))
    self._id_9A8E delete();

  if(isDefined(self._id_778F)) {
    foreach(var_9 in self._id_778F) {
      var_9 thread hallucination_poof_fx();
      var_9 delete();
    }
  }

  var_11 = undefined;

  if(_id_0547::_id_5565(var_3, "zombie_assassin")) {
    self.asssassinspawn = 1;
    var_12 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_health");
    var_11 = maps\mp\zombies\zombie_assassin_basic::spawn_an_assassin(undefined, var_12, self);
    var_11.assassinmustneverleave = 1;
    var_11.optionaldisablefogsensitivity = 1;
    var_11.optionaldisablecrouchedambush = 1;
    var_11.optionaldisableexits = 1;
  } else {
    self.asssassinspawn = 0;
    var_11 = _id_054D::_id_90BA(var_3, self, "straub_void_event_straub", 0, 0, 0);
  }

  var_11 thread hallucination_poof_fx();
  var_11 _id_0547::disableoffhandsecondaryweapons();

  while(var_6 < var_2) {
    var_13 = var_4;

    if(var_5 > var_4)
      var_13 = _randomfloatrange(var_4, var_5);

    wait(var_13);

    for(;;) {
      var_14 = common_scripts\utility::random(var_1);

      if(isDefined(var_7) && var_14 == var_7)
        continue;
      else
        break;
    }

    var_7 = var_14;
    var_15 = "zombie_generic";
    var_16 = _id_054D::_id_90BA(var_15, var_14, "straub_void_event", 0, 1, 0);
    var_16 thread hallucination_poof_fx();
    var_16 _id_0547::disableoffhandsecondaryweapons();
    var_6++;
  }

  for(;;) {
    var_17 = _id_0547::_id_408F();

    if(var_17.size < 1) {
      break;
    }

    waitframe();
  }

  level notify("ee_conquer_fish_straub_event_complete");
}

ee_conquer_fish_void_straub_final_vignette(var_0) {
  var_1 = self;

  foreach(var_3 in level.players)
  _id_0378::_id_8D74("straub_laugh_hallucination", var_3);

  var_0 thread ee_conquer_fish_void_straub_final_vignette_flicker();

  foreach(var_3 in level.players) {
    var_3 thread _id_055B::_id_598A();
    var_3 shellshock("zm_dig_altered", var_1.exitanimlength);
    var_3 lerpfovscale(1.5, 1);
    var_3 common_scripts\utility::_id_2CBE(var_1.exitanimlength, ::lerpfovscale, 1.2, 1);
  }

  var_0 scriptmodelclearanim();
  var_0._id_00B9 scriptmodelclearanim();
  var_0 scriptmodelplayanimdeltamotionfrompos(var_1.exitanim, var_1.origin, var_1.angles + (0, -90, 0));
  var_0._id_00B9 scriptmodelplayanimdeltamotionfrompos(var_1.exitanim, var_1.origin, var_1.angles + (0, -90, 0));
  wait(var_1.exitanimlength);
  level notify("straub_flicker_stop");
}

ee_conquer_fish_void_straub_final_vignette_zombies() {
  var_0 = self;

  for(var_1 = 0; var_1 < 8; var_1++) {
    level.straub_vignette_zombie[var_1] = spawn("script_model", var_0.origin);
    level.straub_vignette_zombie[var_1] setModel("zom_infantrya_bodywhole");
    level.straub_vignette_zombie[var_1].animation_name = "s2_zom_straub_death_zom_0" + common_scripts\utility::_id_9AAD(var_1 + 1);
    level.straub_vignette_zombie[var_1].idle_anim_name = "s2_zom_straub_death_end_zom_0" + common_scripts\utility::_id_9AAD(var_1 + 1);
    level.straub_vignette_zombie[var_1]._id_00B9 = spawn("script_model", var_0.origin);
    level.straub_vignette_zombie[var_1]._id_00B9 setModel(common_scripts\utility::random(["zom_head_fdr02_org1", "zom_head_fdr03_org1", "zom_head_fdr04_org1"]));
    level.straub_vignette_zombie[var_1]._id_00B9 linkto(level.straub_vignette_zombie[var_1], "j_spineupper", (0, 0, 0), (0, 0, 0));
    level.straub_vignette_zombie[var_1] scriptmodelplayanimdeltamotionfrompos(level.straub_vignette_zombie[var_1].animation_name, var_0.origin, var_0.angles);
    level.straub_vignette_zombie[var_1]._id_00B9 scriptmodelplayanimdeltamotionfrompos(level.straub_vignette_zombie[var_1].animation_name, var_0.origin, var_0.angles);
  }
}

ee_conquer_fish_void_straub_final_vignette_flicker() {
  level endon("straub_flicker_stop");

  for(;;) {
    wait(_randomfloatrange(0.01, 0.05));

    if(isDefined(self))
      self hide();

    if(isDefined(self._id_00B9))
      self._id_00B9 hide();

    wait(_randomfloatrange(0.01, 0.05));

    if(isDefined(self))
      self show();

    if(isDefined(self._id_00B9))
      self._id_00B9 show();
  }
}

ee_conquer_fish_bucket_shuffle_init() {
  level endon("bucket_shuffle_complete");
  level.bucketfish = _getent("ee_bucket_shuffle_fish", "targetname");
  level.bucketfish scriptmodelplayanim("zmb_follow_the_fish_loop", undefined, 0, 0.75);
  thread ee_conquer_fish_bucket_shuffle_fish_float();
  var_0 = _getent("vol_ee_conquer_fish_bucket_shuffle_platform", "targetname");
  wait_until_all_players_in_volume(var_0);
  level.voidfallteleportlocations = common_scripts\utility::_id_46B7("void_tp_platform_final", "targetname");
  wait 1;
  level.allbuckets = [];
  level thread maps\mp\_utility::_id_6F74(::ee_conquer_fish_bucket_missile_listen, undefined, "bucket_shuffle_complete");
  var_1 = 1;

  for(;;) {
    var_2 = ee_conquer_fish_bucket_shuffle_setup_buckets(var_1);
    var_3 = ee_conquer_fish_bucket_shuffle_run(var_1, var_2);

    if(common_scripts\utility::_id_562E(var_3))
      var_1++;

    wait 3;
  }
}

ee_conquer_fish_bucket_shuffle_fish_float() {
  level endon("ee_bucket_shuffle_start");

  for(;;) {
    level.bucketfish movez(8, 2);
    wait 2;
    level.bucketfish movez(-8, 2);
    wait 2;
  }
}

ee_conquer_fish_bucket_shuffle_setup_buckets(var_0) {
  level notify("ee_bucket_shuffle_start");
  var_1 = common_scripts\utility::_id_46B7("ee_bucket_shuffle_bucket", "targetname");
  var_2 = 3;

  if(var_0 >= 1)
    var_2 = 3;

  if(var_0 >= 2)
    var_2 = 5;

  if(var_0 >= 3)
    var_2 = 8;

  var_3 = [];
  var_4 = var_1;
  level.allbuckets = [];

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = common_scripts\utility::random(var_4);
    var_4 = common_scripts\utility::_id_0F93(var_4, var_6);
    var_7 = spawn("script_model", var_6.origin);
    var_7 setModel("zdu_water_bucket_01");
    var_7 thread hallucination_poof_fx(0);
    _playfxontag(common_scripts\utility::_id_44F5("zmb_dnk_bucket_sparks"), var_7, "tag_origin");
    var_7 setcandamage(1);
    var_3 = common_scripts\utility::_id_0F6F(var_3, var_7);
    level.allbuckets = common_scripts\utility::_id_0F6F(level.allbuckets, var_7);
    wait 0.75;
  }

  level.chosenbucket = common_scripts\utility::random(var_3);
  level.chosenbucket.ischosenbucket = 1;

  if(var_0 == 1) {
    level.bucketfish thread hallucination_poof_fx(0);
    level.bucketfish hide();
  }

  level.bucketfish moveto(level.chosenbucket.origin + (0, 6, 72), 0.1);
  level.bucketfish rotateto((0, 0, 90), 0.1);
  wait 1.5;
  level.bucketfish thread hallucination_poof_fx(0);
  level.bucketfish show();
  wait 0.5;
  level.bucketfish movez(5, 0.2, 0.1, 0.1);
  wait 0.3;
  level.bucketfish movez(-64, 1, 0.2, 0.2);
  wait 1;
  level.bucketfish thread hallucination_poof_fx(0);
  level.bucketfish hide();
  wait 1;
  return var_3;
}

ee_conquer_fish_bucket_missile_listen() {
  self endon("spawned_player");
  self endon("faux_spawn");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(!isDefined(var_0)) {
      continue;
    }
    if(isDefined(var_1)) {
      if(issubstr(var_1, "c4") || issubstr(var_1, "bouncing_betty") || issubstr(var_1, "semtex") || issubstr(var_1, "throwingknife") || issubstr(var_1, "claymore")) {
        var_2 = 1;

        if(issubstr(var_1, "throwingknife"))
          var_2 = 0;

        var_0 thread ee_conquer_fish_bucket_watch_stuck(var_2);
      }
    }
  }
}

ee_conquer_fish_bucket_watch_stuck(var_0) {
  self endon("death");
  self waittill("missile_stuck", var_1);

  if(isDefined(var_1) && isDefined(level.allbuckets) && common_scripts\utility::_id_0F79(level.allbuckets, var_1)) {
    waitframe();

    if(!_isremovedentity(self)) {
      if(common_scripts\utility::_id_562E(var_0))
        self detonate();
      else
        self delete();
    }
  }
}

ee_conquer_fish_bucket_shuffle_run(var_0, var_1) {
  level endon("bucket_shuffle_complete");
  var_2 = 1.5;
  var_3 = 1.5;
  var_4 = 6;
  var_5 = 0;

  switch (var_0) {
    case 1:
      var_2 = 0.7;
      var_3 = 0.8;
      var_4 = 8;
      break;
    case 2:
      var_2 = 0.5;
      var_3 = 0.6;
      var_4 = 12;
      break;
    case 3:
      var_2 = 0.4;
      var_3 = 0.5;
      var_4 = 16;
      var_5 = 1;
      break;
  }

  var_6 = common_scripts\utility::_id_46B7("ee_bucket_shuffle_bucket", "targetname");
  var_7 = 0;

  while(var_7 < var_4) {
    var_8 = var_6;

    foreach(var_10 in var_1) {
      var_11 = common_scripts\utility::random(var_8);
      var_8 = common_scripts\utility::_id_0F93(var_8, var_11);
      _id_0378::_id_8D74("ctf_bucket_move", var_10, var_2);
      var_10 moveto(var_11.origin, var_2);
      var_10 thread ee_conquer_fish_bucket_wait_for_damage();
    }

    var_7++;
    wait(var_3);
  }

  level notify("buckets_shuffled");
  var_13 = level common_scripts\utility::waittill_any_return("bucket_shuffle_success", "bucket_shuffle_fail");
  wait 0.25;
  level.damagedbucket movez(64, 3);
  wait 3;
  level.damagedbucket rotatepitch(180, 0.5, 0.2, 0.1);
  wait 0.5;

  if(var_13 == "bucket_shuffle_success") {
    level.bucketfish moveto(level.damagedbucket.origin - (0, -6, 24), 0.05);
    level.bucketfish rotateto((0, 0, 90), 0.05);
    wait 0.1;
    level.bucketfish show();
    level.bucketfish movez(-12, 0.5);
    wait 0.25;
    level.bucketfish rotateto((0, 0, 0), 0.5);
    wait 1;
    var_14 = 0.25;
    var_15 = 10;

    for(var_16 = 0; var_16 < var_15; var_16++) {
      _id_0378::_id_8D74("ctf_fish_360", level.bucketfish.origin, var_14);
      level.bucketfish rotateyaw(360, var_14);
      wait(var_14);
    }

    level.bucketfish thread hallucination_poof_fx(0);
    level.bucketfish hide();

    foreach(var_10 in var_1) {
      var_10 thread hallucination_poof_fx(0);
      var_10 delete();
    }

    if(common_scripts\utility::_id_562E(var_5))
      level notify("bucket_shuffle_complete");

    return 1;
  } else if(var_13 == "bucket_shuffle_fail") {
    wait 2;
    level.bucketfish moveto(level.chosenbucket.origin + (0, -6, 8), 0.05);
    level.bucketfish rotateto((0, 0, -90), 0.05);
    wait 0.1;
    level.bucketfish show();
    level.bucketfish movez(72, 0.6, 0, 0.5);
    wait 0.6;
    level.bucketfish movez(-96, 0.6, 0.5, 0);
    wait 1;
    level.bucketfish hide();

    foreach(var_10 in var_1) {
      var_10 thread hallucination_poof_fx(0);
      var_10 delete();
    }

    level.numbucketshuffleassassins++;
    var_21 = common_scripts\utility::_id_46B7("ee_conquer_fish_bucket_shuffle_assassin_spawner", "targetname");
    var_22 = ["zombie_assassin", "zombie_heavy"];

    for(var_16 = 0; var_16 < level.numbucketshuffleassassins; var_16++) {
      if(isDefined(var_21[var_16])) {
        var_23 = common_scripts\utility::random(var_22);
        var_24 = undefined;

        if(var_23 == "zombie_assassin") {
          var_21[var_16].asssassinspawn = 1;
          var_25 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_health");
          var_24 = maps\mp\zombies\zombie_assassin_basic::spawn_an_assassin(undefined, var_25, var_21[var_16]);
          var_24.assassinmustneverleave = 1;
          var_24.optionaldisablefogsensitivity = 1;
          var_24.optionaldisablecrouchedambush = 1;
          var_24.optionaldisableexits = 1;
        } else {
          var_21[var_16].asssassinspawn = 0;
          var_24 = _id_054D::_id_90BA(var_23, var_21[var_16], "bucket_shuffle_fail", 0, 1, 0);
        }

        var_24 thread hallucination_poof_fx();
        var_24 _id_0547::disableoffhandsecondaryweapons();
      }
    }

    for(;;) {
      var_26 = _id_0547::_id_408F();

      if(var_26.size < 1) {
        break;
      }

      waitframe();
    }

    wait 4;
    _clearallcorpses();
    return 0;
  }
}

ee_conquer_fish_bucket_wait_for_damage() {
  level endon("bucket_shuffle_success");
  level endon("bucket_shuffle_fail");
  level waittill("buckets_shuffled");

  for(;;) {
    self waittill("damage");
    level.damagedbucket = self;

    if(isDefined(self.ischosenbucket) && self.ischosenbucket) {
      level notify("bucket_shuffle_success");
      continue;
    }

    level notify("bucket_shuffle_fail");
  }
}

ee_conquer_fish_bucket_shuffle_completion() {
  level waittill("bucket_shuffle_complete");
  _id_0378::_id_8D74("ctf_void_exit");
  level thread ee_conquer_fish_exit_void();
}

ee_conquer_fish_exit_void() {
  foreach(var_1 in level.players) {
    if(_id_0547::_id_577E(var_1))
      var_1 notify("revive_trigger");

    var_1 thread ee_conquer_fish_void_enter_fade();
  }

  level waittill("ee_conquer_fish_enter_void_fading");
  common_scripts\utility::flag_set("flag_ship_tilting_enabled");
  common_scripts\utility::flag_set("flag_ee_altered_state_finished");
  var_3 = common_scripts\utility::_id_46B7("ee_bucket_shuffle_tp_to_ship", "targetname");

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    level.players[var_4] setOrigin(var_3[var_4].origin);
    level.players[var_4] setplayerangles(var_3[var_4].angles);
    level.players[var_4] notify("altered_state_end");
    level.players[var_4] maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::altered_state_end_overlay(1);
  }

  if(isDefined(level.all_drop_crates) && level.all_drop_crates.size > 0) {
    foreach(var_6 in level.all_drop_crates)
    var_6 hudoutlineenableforclients(level.players, 2, 0);
  }

  level.zmb_sg_banned_objectives = common_scripts\utility::_id_0F93(level.zmb_sg_banned_objectives, "dnk_ext_visions");
  _id_056D::_id_8A6E(0);
  level.zmb_is_endless_wave = 0;
  level.zmb_locked_spawn_zones = undefined;
  level thread ee_conquer_fish_exit_void_failsafe();
}

ee_conquer_fish_exit_void_failsafe() {
  wait 5;

  for(var_0 = _id_055A::_id_5780("zone_the_void"); common_scripts\utility::_id_562E(var_0); var_0 = _id_055A::_id_5780("zone_the_void")) {
    foreach(var_2 in level.players) {
      if(_id_055A::_id_7413(var_2, "zone_the_void")) {
        var_3 = common_scripts\utility::_id_46B7("ee_bucket_shuffle_tp_to_ship", "targetname");
        var_4 = common_scripts\utility::random(var_3);
        var_2 setOrigin(var_4.origin);
        var_2 setplayerangles(var_4.angles);
      }
    }

    wait 5;
  }
}

debug_complete_vignette() {
  level notify("ee_conquer_fish_straub_event_complete");
}

debug_highlight_bucket() {
  if(isDefined(level.chosenbucket))
    level.chosenbucket hudoutlineenable(0);
}

warp_start_bucket_shuffle() {
  common_scripts\utility::flag_set("ee_conquer_fish_entered_void");
  common_scripts\utility::flag_set("ee_conquer_fish_straub_complete");
  thread all_players_set_visions();
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0)
  var_2 _id_056D::_id_5A86();

  level._id_ABE2 = 1;
  level._id_ABD3 = -10000;
  common_scripts\utility::flag_set("ship_to_void");
  common_scripts\utility::_id_3C7B("flag_ship_tilting_enabled");
  level.zmb_locked_spawn_zones = ["zone_the_void"];
}

___________________step_get_part___________________() {}

ee_get_part() {
  thread ee_get_part_think();
  common_scripts\utility::_id_3C9F("ee_get_part_sword_part_picked_up");
  level.shattered_ee_complete = 1;
  common_scripts\utility::flag_set("zmb_objectives_quest_end");
  _id_0557::_id_782D("quest_fish", "step_get_part");
}

ee_get_part_setup() {
  var_0 = getEntArray("ee_get_part_parts", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();
}

ee_get_part_think() {
  var_0 = getEntArray("ee_get_part_parts", "targetname");

  foreach(var_2 in var_0)
  var_2 show();

  var_4 = _getent("ee_get_part_sword_part", "script_noteworthy");
  level thread maps\mp\zombies\weapons\_zombie_dlc3_melee::sword_post_ee_complete_handler();
  var_5 = _getent("ee_trig_get_part_sword_part", "targetname");
  var_5 sethintstring(&"ZOMBIE_DLC3_PICKUP_PART_3");
  var_5 waittill("trigger", var_6);

  if(!common_scripts\utility::_id_0F79(var_6 getweaponlistall(), "island_grenade_hc_zm"))
    level thread _id_0548::_id_A7D5(var_6, "island_grenade_hc_zm", undefined);

  thread ee_get_part_grant_pomel_grenade();
  common_scripts\utility::flag_set("ee_get_part_sword_part_picked_up");
}

ee_get_part_grant_pomel_grenade() {
  var_0 = _getent("ee_trig_get_part_sword_part", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!common_scripts\utility::_id_0F79(var_1 getweaponlistall(), "island_grenade_hc_zm")) {
      level thread _id_0548::_id_A7D5(var_1, "island_grenade_hc_zm", undefined);
      var_1 thread _id_0367::_id_8E3C("pommelpickup", level.players);
    }
  }
}

warp_get_part() {
  common_scripts\utility::flag_set("ee_conquer_fish_entered_void");
}

___________________dnk_util___________________() {}

hallucination_poof_fx(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");

  if(var_0)
    _playfxontag(level._effect["geistkraft_poof"], var_1, "tag_origin");
  else
    _playfxontag(level._effect["zmb_dnk_geistkraftexplode"], var_1, "tag_origin");

  _id_0378::_id_8D74("dlc3_magic_poof", self.origin);
  wait 6;
  var_1 delete();
}

wait_for_round_end(var_0) {
  level waittill("round complete");
  common_scripts\utility::flag_set(var_0);
}

wait_until_all_players_in_volume(var_0) {
  for(;;) {
    var_1 = 0;
    var_2 = [];

    foreach(var_4 in level.players) {
      if(isalive(var_4))
        var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);

      if(var_4 istouching(var_0))
        var_1++;
    }

    if(var_1 >= var_2.size) {
      break;
    }

    waitframe();
  }
}

down_player() {
  _id_0547::_id_73AC(3);
  _id_0547::_id_7442(3);
  self dodamage(self.health, self.origin);
}

debug_kill_and_pause_zombies() {
  _id_056D::_id_8A6E(1);
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0)
  var_2 _id_056D::_id_5A86();
}

debug_unpause_zombies() {
  _id_056D::_id_8A6E(0);
}

______________________vo______________________() {}

wave_story_wave_1() {
  var_0 = get_all_alive_player_character_names();
  var_1 = spawnStruct();
  var_1.aliasarray = [];
  var_1.requiredcharacters = [];
  var_1.isvalid = 0;

  if(level.players.size > 1) {
    wait 2;

    if(common_scripts\utility::_id_0F79(var_0, "survivalist") && common_scripts\utility::_id_0F79(var_0, "batelite")) {
      var_1.aliasarray = common_scripts\utility::_id_0F6F(var_1.aliasarray, "zmb_bp_ship_surv_whatiftheothershipsareabl");
      var_1.requiredcharacters = common_scripts\utility::_id_0F6F(var_1.requiredcharacters, "survivalist");
    }

    if(common_scripts\utility::_id_0F79(var_0, "batelite")) {
      var_1.aliasarray = common_scripts\utility::_id_0F6F(var_1.aliasarray, "zmb_bp_ship_ride_ivedividedtheartifactsamo");
      var_1.requiredcharacters = common_scripts\utility::_id_0F6F(var_1.requiredcharacters, "batelite");
    }

    if(common_scripts\utility::_id_0F79(var_0, "batagent") && common_scripts\utility::_id_0F79(var_0, "batelite")) {
      var_1.aliasarray = common_scripts\utility::_id_0F6F(var_1.aliasarray, "zmb_bp_ship_bata_butdoesntthatleaveusvulne");
      var_1.requiredcharacters = common_scripts\utility::_id_0F6F(var_1.requiredcharacters, "batagent");
    }

    if(common_scripts\utility::_id_0F79(var_0, "batelite") && common_scripts\utility::_id_0F79(var_0, "batagent"))
      var_1.aliasarray = common_scripts\utility::_id_0F6F(var_1.aliasarray, "zmb_bp_ship_ride_itdoesbutitalsomeansthatt");

    play_conversation(var_1.requiredcharacters, var_1.aliasarray);
  }
}

wave_story_wave_4() {
  var_0 = get_all_alive_player_character_names();

  if(level.players.size > 1) {
    if(common_scripts\utility::_id_0F79(var_0, "survivalist")) {
      wait 2;
      var_1 = spawnStruct();
      var_1.aliasarray = [];
      var_1.requiredcharacters = [];
      var_1.isvalid = 0;
      var_1.aliasarray = common_scripts\utility::_id_0F6F(var_1.aliasarray, "zmb_bp_ship_surv_thisdamnweathermakesithar");
      var_1.requiredcharacters = common_scripts\utility::_id_0F6F(var_1.requiredcharacters, "survivalist");

      if(common_scripts\utility::_id_0F79(var_0, "batelite")) {
        var_1.aliasarray = common_scripts\utility::_id_0F6F(var_1.aliasarray, "zmb_bp_ship_ride_youshouldtalkwithdrostanw");
        var_1.requiredcharacters = common_scripts\utility::_id_0F6F(var_1.requiredcharacters, "batelite");
      }

      play_conversation(var_1.requiredcharacters, var_1.aliasarray);
    }
  }
}

wave_story_pre_boss() {
  var_0 = ["slayer", "survivalist", "batelite"];
  var_1 = ["zmb_bp_ship_surv_wevegottheshipsystemsfire", "zmb_bp_ship_ride_arewesurethevesselisclear", "zmb_bp_ship_slay_thelightsjustbeyondthefog", "zmb_bp_ship_ride_lookslikemikhailanddeltor", "zmb_bp_ship_surv_holdupsirtheressomethingw"];
  play_conversation(var_0, var_1);
}

wave_story_post_boss() {
  var_0 = ["survivalist", "batelite"];
  var_1 = ["zmb_bp_ship_ride_wellthatshoulddoitensignd", "zmb_bp_ship_surv_permissiontospeakfreelysi", "zmb_bp_ship_ride_ofcourseensign", "zmb_bp_ship_surv_iwantnothingmorethantoget", "zmb_bp_ship_ride_watchyourlanguagecaptainn"];
  wait 2;
  play_conversation(var_0, var_1);
}

level_intro_vo() {
  for(;;) {
    if(level._id_A980 >= 1) {
      break;
    }

    waitframe();
  }

  var_0 = get_all_alive_player_character_names();
  var_1 = [];
  var_2 = [];

  if(level.players.size > 1) {
    if(common_scripts\utility::_id_0F79(var_0, "batagent") && common_scripts\utility::_id_0F79(var_0, "batelite")) {
      var_1 = common_scripts\utility::_id_0F6F(var_1, "zmb_bp_ship_bata_sirtheothershipshaveallgo");
      var_2 = common_scripts\utility::_id_0F6F(var_2, "batagent");
    }

    if(common_scripts\utility::_id_0F79(var_0, "batelite")) {
      var_1 = common_scripts\utility::_id_0F6F(var_1, "zmb_bp_ship_ride_weareunderattackarmyourse");
      var_2 = common_scripts\utility::_id_0F6F(var_2, "batelite");
    }

    if(common_scripts\utility::_id_0F79(var_0, "slayer") && common_scripts\utility::_id_0F79(var_0, "batelite")) {
      var_1 = common_scripts\utility::_id_0F6F(var_1, "zmb_bp_ship_slay_canyouhearthemthedeadthes");
      var_2 = common_scripts\utility::_id_0F6F(var_2, "slayer");
    }

    if(!isDefined(var_1)) {
      return;
    }
    play_conversation(var_2, var_1);
  }

  level notify("intro_VO_complete");
}

visions_vo() {
  var_0 = ["batagent", "batelite"];
  var_1 = ["zmb_bp_ship_bata_iidontfeelwell", "zmb_bp_ship_ride_seasickharris", "zmb_bp_ship_bata_nosirivebeenonshipssincei"];
  wait 2;
  play_conversation(var_0, var_1);
}

sinking_vo() {
  var_0 = [];
  var_1 = get_all_alive_player_character_names();
  var_2 = [];

  if(common_scripts\utility::_id_0F79(var_1, "survivalist")) {
    var_2 = common_scripts\utility::_id_0F6F(var_2, "zmb_bp_ship_surv_wearetakingonwater");
    var_0 = common_scripts\utility::_id_0F6F(var_0, "survivalist");
  }

  if(common_scripts\utility::_id_0F79(var_1, "batelite")) {
    var_2 = common_scripts\utility::_id_0F6F(var_2, "zmb_bp_ship_ride_thebastardscantdrownthena");
    var_0 = common_scripts\utility::_id_0F6F(var_0, "batelite");
  }

  if(common_scripts\utility::_id_0F79(var_1, "batagent")) {
    var_2 = common_scripts\utility::_id_0F6F(var_2, "zmb_bp_ship_bata_letsgettheseholesrepaired");
    var_0 = common_scripts\utility::_id_0F6F(var_0, "batagent");
  }

  if(!isDefined(var_2) || var_2.size < 1) {
    return;
  }
  var_3 = common_scripts\utility::random(var_2);
  wait 2;
  play_conversation(var_0, var_3);
}

get_all_alive_player_character_names() {
  var_0 = [];

  foreach(var_2 in level.players) {
    var_3 = "";

    switch (var_2._id_20D8) {
      case 34:
      case 29:
      case 18:
      case 17:
      case 16:
      case 6:
        var_3 = "survivalist";
        break;
      case 7:
        var_3 = "batagent";
        break;
      case 40:
      case 8:
        var_3 = "batelite";
        break;
      case 35:
      case 31:
      case 21:
      case 20:
      case 19:
      case 9:
        var_3 = "slayer";
        break;
    }

    var_0 = common_scripts\utility::_id_0F6F(var_0, var_3);
  }

  if(common_scripts\utility::_id_3C77("flag_debug_single_speaker"))
    var_0 = ["survivalist", "batagent", "batelite", "slayer"];

  return var_0;
}

update_expected_characters() {
  level.playercharactersurvivalists = [];
  level.playercharacterbatagents = [];
  level.playercharacterbatelites = [];
  level.playercharacterslayers = [];

  foreach(var_1 in level.players) {
    var_2 = var_1._id_20D8;

    switch (var_2) {
      case 34:
      case 29:
      case 18:
      case 17:
      case 16:
      case 6:
        level.playercharactersurvivalists = common_scripts\utility::_id_0F6F(level.playercharactersurvivalists, var_1);
        break;
      case 7:
        level.playercharacterbatagents = common_scripts\utility::_id_0F6F(level.playercharacterbatagents, var_1);
        break;
      case 40:
      case 8:
        level.playercharacterbatelites = common_scripts\utility::_id_0F6F(level.playercharacterbatelites, var_1);
        break;
      case 35:
      case 31:
      case 21:
      case 20:
      case 19:
      case 9:
        level.playercharacterslayers = common_scripts\utility::_id_0F6F(level.playercharacterslayers, var_1);
        break;
    }
  }
}

play_conversation(var_0, var_1) {
  if(_isarray(var_1))
    var_2 = var_1;
  else
    var_2 = [var_1];

  update_expected_characters();
  var_6 = get_all_alive_player_character_names();

  foreach(var_8 in var_0) {
    if(!common_scripts\utility::_id_0F79(var_6, var_8))
      return;
  }

  for(var_10 = 0; var_10 < var_2.size; var_10++) {
    if(isDefined(var_2[var_10])) {
      var_11 = determine_conversation_speaker(var_2[var_10]);
      var_12 = check_if_speaker_valid(var_11);

      if(var_12) {
        if(var_2[var_10] == "zmb_bp_ship_ride_lookslikemikhailanddeltor") {
          var_11 _id_0378::_id_307E(var_2[var_10], level.players, undefined, 1, "interrupted");
          wait 3.5;
        } else
          var_11 _id_0378::_id_307E(var_2[var_10], level.players, undefined, 1);
      } else
        break;

      wait 0.5;
    }
  }
}

check_if_speaker_valid(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(_id_0547::_id_5565(var_0.sessionstate, "spectator") || _id_0547::_id_5565(var_0.sessionstate, "dead"))
    return 0;

  return 1;
}

determine_conversation_speaker_candidates(var_0) {
  var_1 = _func_36D(var_0, "zmb_bp_ship_");

  if(common_scripts\utility::_id_9467(var_1, "surv"))
    var_2 = level.playercharactersurvivalists;
  else if(common_scripts\utility::_id_9467(var_1, "bata"))
    var_2 = level.playercharacterbatagents;
  else if(common_scripts\utility::_id_9467(var_1, "ride"))
    var_2 = level.playercharacterbatelites;
  else if(common_scripts\utility::_id_9467(var_1, "slay"))
    var_2 = level.playercharacterslayers;
  else
    var_2 = [];

  return var_2;
}

determine_conversation_speaker(var_0) {
  var_1 = determine_conversation_speaker_candidates(var_0);
  var_2 = undefined;

  if(var_1.size > 0)
    var_2 = common_scripts\utility::random(var_1);

  return var_2;
}