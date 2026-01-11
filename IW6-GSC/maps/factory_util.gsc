/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_util.gsc
*****************************************************/

move_player_to_start_point(var_0) {
  var_1 = getent(var_0, "targetname");
  self setorigin(var_1.origin);
  var_2 = undefined;

  if(isDefined(var_1.target)) {
    var_2 = getent(var_1.target, "targetname");
  }

  if(isDefined(var_2)) {
    self setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  } else {
    self setplayerangles(var_1.angles);
  }
}

actor_teleport(var_0, var_1) {
  var_2 = getent(var_1, "targetname");

  if(isplayer(var_0)) {
    var_0 setplayerangles(var_2.angles);
    var_0 setorigin(var_2.origin);
  } else if(isai(var_0))
    var_0 forceteleport(var_2.origin, var_2.angles);
}

squad_add_ally(var_0, var_1, var_2) {
  if(!isDefined(level.squad)) {
    level.squad = [];
  }

  var_3 = getent(var_1, "targetname");
  var_4 = var_3 maps\_utility::spawn_ai();
  var_4.animname = var_2;
  var_4 thread maps\_utility::deletable_magic_bullet_shield();
  var_4.hero = 1;
  var_4 maps\_utility::make_hero();
  var_4.disable_sniper_glint = 1;
  var_4.awareness = 1;
  var_4.has_no_ir = 1;

  if(isDefined(var_3.script_parameters)) {}

  level.squad[var_0] = var_4;
  return var_4;
}

safe_trigger_by_targetname(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 notify("trigger");
}

safe_trigger_by_noteworthy(var_0) {
  var_1 = getent(var_0, "script_noteworthy");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 notify("trigger");
}

break_glass(var_0, var_1) {
  var_2 = getglassarray(var_0);

  foreach(var_4 in var_2) {
    destroyglass(var_4, var_1);
  }
}

disable_awareness() {
  if(!isDefined(self.awareness)) {
    self.awareness = 0;
  }

  self.awareness = 0;
  self.ignoreall = 1;
  self.ignoresuppression = 1;
  maps\_utility::disable_surprise();
  self.ignorerandombulletdamage = 1;
  maps\_utility::disable_bulletwhizbyreaction();
  maps\_utility::disable_pain();
  self.grenadeawareness = 0;
  maps\_utility::enable_dontevershoot();
}

has_awareness() {
  return self.awareness;
}

enable_awareness() {
  if(!isDefined(self.awareness)) {
    self.awareness = 1;
  }

  self.awareness = 1;
  self.ignoreall = 0;
  self.dontmelee = undefined;
  self.ignoresuppression = 0;
  maps\_utility::enable_surprise();
  self.ignorerandombulletdamage = 0;
  maps\_utility::enable_bulletwhizbyreaction();
  maps\_utility::enable_pain();
  self.grenadeawareness = 1;
  maps\_utility::disable_dontevershoot();
}

check_trigger_flagset(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");

  if(isDefined(var_1.script_flag_set)) {
    common_scripts\utility::flag_set(var_1.script_flag_set);
  }
}

playerseek() {
  self cleargoalvolume();
  self setgoalentity(level.player);
  self.aggressivemode = 1;
}

factory_set_ignoreme(var_0) {
  if(isDefined(self) && isalive(self) && issentient(self)) {
    self.ignoreme = var_0;
  }
}

safe_set_goal_volume(var_0, var_1) {
  var_2 = getent(var_1, "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_4 in var_0) {
    if(isDefined(var_4) && isalive(var_4)) {
      var_4 thread safe_set_goal_volume_single(var_2);
    }
  }
}

safe_set_goal_volume_single(var_0) {
  self endon("death");
  self waittill("goal");
  self setgoalvolumeauto(var_0);
}

safe_delete_targetname(var_0) {
  safe_delete_array(getEntArray(var_0, "targetname"));
}

safe_delete_noteworthy(var_0) {
  safe_delete_array(getEntArray(var_0, "script_noteworthy"));
}

safe_delete_linkname(var_0) {
  safe_delete_array(getEntArray(var_0, "script_linkname"));
}

safe_delete(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  } else {}
}

safe_delete_array(var_0) {
  foreach(var_2 in var_0) {
    safe_delete(var_2);
  }
}

notify_targetname_on_goal(var_0) {
  if(isDefined(var_0) && isDefined(var_0.targetname)) {
    self notify(var_0.targetname);
  }
}

thermal_vision() {
  self endon("end_thermal");
  level endon("missionfailed");
  level.player endon("death");
  self notifyonplayercommand("use_thermal", "+actionslot 4");
  self setweaponhudiconoverride("actionslot4", "hud_icon_nvg");
  self.thermal = 0;
  self.active_anim = 0;
  self.thermal_anim_active = 0;
  level.show_thermal_hint = 1;
  level.show_thermal_off_hint = 1;

  for(;;) {
    wait 0.05;
    self waittill("use_thermal");
    toggle_thermal_vision();
  }
}

toggle_thermal_vision() {
  if(self.active_anim || common_scripts\utility::flag("player_using_camera") || self isthrowinggrenade() || self ismeleeing()) {
    return;
  }
  if(self.thermal == 0) {
    turn_on_thermal_vision();
  } else {
    turn_off_thermal_vision();
  }
}

turn_on_thermal_vision() {
  if(self isthrowinggrenade()) {
    return;
  }
  self disableweaponpickup();
  self.thermal_anim_active = 1;
  var_0 = level.player getcurrentweapon();
  self forceviewmodelanimation(var_0, "nvg_down");
  wait 0.6;
  self.thermal = 1;
  maps\_load::thermal_effectson();

  if(!isDefined(self.gasmask_hud_elem)) {
    self.gasmask_hud_elem = newclienthudelem(self);
    self.gasmask_hud_elem.x = 0;
    self.gasmask_hud_elem.y = 0;
    self.gasmask_hud_elem.alignx = "left";
    self.gasmask_hud_elem.aligny = "top";
    self.gasmask_hud_elem.horzalign = "fullscreen";
    self.gasmask_hud_elem.vertalign = "fullscreen";
    self.gasmask_hud_elem.foreground = 0;
    self.gasmask_hud_elem.sort = -10;
    self.gasmask_hud_elem setshader("nightvision_overlay_goggles", 650, 490);
    self.gasmask_hud_elem.archived = 1;
    self.gasmask_hud_elem.hidein3rdperson = 1;
    self.gasmask_hud_elem.alpha = 1.0;
  }

  self thermalvisiononshadowoff();
  self visionsetthermalforplayer("factory_flir2", 0);
  self playSound("item_thermalvision_on");
  maps\_utility::ui_action_slot_force_active_on(4);
  level.show_thermal_hint = 0;
  wait 1.0;
  self enableweaponpickup();
  self.thermal_anim_active = 0;
}

turn_off_thermal_vision() {
  if(self isthrowinggrenade()) {
    return;
  }
  self disableweaponpickup();
  level.show_thermal_off_hint = 0;
  self.thermal_anim_active = 1;
  var_0 = level.player getcurrentweapon();
  self forceviewmodelanimation(var_0, "nvg_up");
  wait 0.7;
  self.thermal = 0;
  level.show_thermal = 1;
  maps\_load::thermal_effectsoff();
  self thermalvisionoff();
  self playSound("item_thermalvision_off");
  maps\_utility::ui_action_slot_force_active_off(4);

  if(isDefined(self.gasmask_hud_elem)) {
    self.gasmask_hud_elem destroy();
    self.gasmask_hud_elem = undefined;
  }

  wait 1.1;
  self enableweaponpickup();
  self.thermal_anim_active = 0;
}

thermal_disable() {
  if(self.thermal == 1) {
    self notify("use_thermal");
    turn_off_thermal_vision();
  }

  self notify("end_thermal");
  self setweaponhudiconoverride("actionslot4", "none");
}

nag_line_generator(var_0, var_1, var_2, var_3) {
  level endon("stop_nag");
  level endon(var_1);

  if(isDefined(var_3)) {
    wait(var_3);
  }

  var_4 = 8;
  var_5 = 20;
  var_6 = 0.5;
  var_7 = 1.5;

  if(!isDefined(var_0)) {
    var_0 = randomizer_create(["factory_bkr_whatreyoudoing", "factory_bkr_letsgo", "factory_bkr_letsgo2"]);
  } else {
    var_0 = randomizer_create(var_0);
  }

  for(;;) {
    var_8 = var_0 randomizer_get_no_repeat();

    if(isDefined(var_2)) {
      maps\_utility::smart_radio_dialogue(var_8);
    } else {
      thread maps\_utility::smart_dialogue(var_8);
    }

    if(var_4 < var_5) {
      var_4 = var_4 + randomfloatrange(var_6, var_7);
    }

    wait(var_4 + randomfloatrange(-2.0, 2.0));
  }
}

randomizer_create(var_0) {
  var_1 = spawnStruct();
  var_1.array = var_0;
  return var_1;
}

randomizer_get_no_repeat() {
  var_0 = undefined;

  if(self.array.size > 1 && isDefined(self.last_index)) {
    var_0 = randomint(self.array.size - 1);

    if(var_0 >= self.last_index) {
      var_0++;
    }
  } else
    var_0 = randomint(self.array.size);

  self.last_index = var_0;
  return self.array[var_0];
}

nag_line_generator_text(var_0, var_1, var_2, var_3) {
  level endon("stop_nag");
  self endon(var_1);
  var_4 = 10;
  var_5 = 20;
  var_6 = 0.5;
  var_7 = 1.5;
  var_0 = randomizer_create(var_0);

  for(;;) {
    wait(var_4 + randomfloatrange(-2.0, 2.0));
    var_8 = var_0 randomizer_get_no_repeat();
    thread add_debug_dialogue(var_2, var_8, var_3);

    if(var_4 < var_5) {
      var_4 = var_4 + randomfloatrange(var_6, var_7);
    }
  }
}

create_door(var_0, var_1) {
  if(!isDefined(level.doors)) {
    level.doors = [];
  }

  if(isDefined(level.doors[var_0])) {
    return level.doors[var_0];
  }

  var_2 = getent(var_0, "targetname");
  level.doors[var_0] = var_2;
  level.doors[var_0].path_connectors = [];
  var_3 = getEntArray(var_2.target, "targetname");

  foreach(var_5 in var_3) {
    var_5 linkto(var_2);

    if(isDefined(var_5.script_parameters) && var_5.script_parameters == "path_connector") {
      level.doors[var_0].path_connectors[level.doors[var_0].path_connectors.size] = var_5;
    }
  }

  return var_2;
}

open_door(var_0, var_1, var_2, var_3) {
  var_4 = create_door(var_0, var_1);

  if(!isDefined(var_4)) {
    return;
  }
  if(isDefined(var_3) && var_3 == 1) {
    foreach(var_6 in var_4.path_connectors) {
      var_6 connectpaths();
    }
  }

  wait 0.01;
  var_4 rotateyaw(var_1, var_2, 0.1, 0.1);

  if(isDefined(var_3) && var_3 == 1) {
    var_4 waittill("rotatedone");

    foreach(var_6 in var_4.path_connectors) {
      var_6 disconnectpaths();
    }
  }
}

create_automatic_sliding_door(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "script_noteworthy");

  if(!isDefined(var_5) || var_5.size == 0) {
    iprintln("create_automatic_sliding_door failed. No parts");
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;

    foreach(var_12 in var_5) {
      if(var_12.classname == "script_origin") {
        if(isDefined(var_12.targetname)) {
          if(var_12.targetname == "door_node") {
            var_6 = var_12;
            continue;
          }

          if(var_12.targetname == "right_door_node") {
            var_9 = var_12;
            continue;
          }

          if(var_12.targetname == "left_door_node") {
            var_7 = var_12;
            continue;
          }

          if(var_12.targetname == "right_open_node") {
            var_10 = var_12;
            continue;
          }

          if(var_12.targetname == "left_open_node") {
            var_8 = var_12;
          }
        }
      }
    }

    var_6.left = var_7;
    var_6.left_open = var_8;
    var_6.right = var_9;
    var_6.right_open = var_10;
    var_6.time = var_1;
    var_6.accel = var_2;
    var_6.lock_notify = var_3;
    var_6.unlock_flag = var_4;
    var_6.door_name = var_0;
    var_14 = getEntArray(var_6.right.target, "targetname");

    foreach(var_12 in var_14) {
      var_12 linkto(var_6.right);
      var_12 connectpaths();
    }

    var_17 = getEntArray(var_6.left.target, "targetname");

    foreach(var_12 in var_17) {
      var_12 linkto(var_6.left);
      var_12 connectpaths();
    }

    var_6.trigger = spawn("trigger_radius", var_6.origin, 3, 128, 64);
    var_6.trigger common_scripts\utility::trigger_on();
    var_6 thread automatic_sliding_door_logic();
    var_6 thread automatic_sliding_door_lock();
  }
}

automatic_sliding_door_logic() {
  self endon("death");
  level endon(self.lock_notify);
  self.state = "open";
  self.trigger.triggered = 0;
  self.trigger thread automatic_sliding_door_detector(self.lock_notify);

  for(;;) {
    if(self.trigger.triggered) {
      if(isDefined(self.unlock_flag) && !common_scripts\utility::flag(self.unlock_flag)) {
        wait 0.5;
        continue;
      }

      if(self.state == "closing" || self.state == "closed") {
        common_scripts\utility::flag_set("presat_synctransients");
        self.state = "open";
        self.left moveto(self.left_open.origin, self.time, self.accel);
        self.right moveto(self.right_open.origin, self.time, self.accel);

        if(self.door_name == "sliding_door_sat_enter_02" || self.door_name == "sliding_door_sat_exit_01") {
          thread maps\factory_audio::sfx_metal_door_open(self);
        } else {
          thread maps\factory_audio::sfx_glass_door_open(self);
        }

        if(self.door_name == "sliding_door_sat_enter_02") {
          thread maps\factory_audio::sfx_sat_door_mix_open();
        }
      }
    } else if(self.state == "opening" || self.state == "open") {
      self.state = "closed";
      self.left moveto(self.origin, self.time, self.accel);
      self.right moveto(self.origin, self.time, self.accel);

      if(self.door_name == "sliding_door_sat_enter_02" || self.door_name == "sliding_door_sat_exit_01") {
        thread maps\factory_audio::sfx_metal_door_close(self);
      } else {
        thread maps\factory_audio::sfx_glass_door_close(self);
      }

      if(self.door_name == "sliding_door_sat_enter_02") {
        thread maps\factory_audio::sfx_sat_door_mix_close();
      }
    }

    wait 0.1;
  }
}

automatic_sliding_door_detector(var_0) {
  self endon("death");
  level endon(var_0);

  for(;;) {
    self.triggered = 0;
    self waittill("trigger");
    self.triggered = 1;
    wait 0.5;
  }
}

automatic_sliding_door_lock() {
  self endon("death");
  level waittill(self.lock_notify);
  self.state = "closed";
  self.left moveto(self.origin, self.time, self.accel);
  self.right moveto(self.origin, self.time, self.accel);
  thread maps\factory_audio::sfx_glass_door_close(self);
  self.trigger common_scripts\utility::trigger_off();
  self.trigger delete();
}

forklift_run_over_monitor(var_0) {
  self endon("death");
  level endon("presat_locked");
  var_1 = 0;
  var_2 = 4.5;
  var_3 = cos(35);

  while(isalive(self)) {
    wait 0.1;
    var_4 = maps\_utility::get_closest_ai(self.origin);
    var_5 = distance(var_4.origin, self.origin);
    var_6 = distance(level.player.origin, self.origin);
    var_7 = 9999;
    var_8 = vehicle_getarray();

    foreach(var_10 in var_8) {
      if(var_10 == self) {
        continue;
      }
      if(isDefined(var_0)) {
        var_11 = maps\_utility::get_vehicle(var_0, "targetname");

        if(isDefined(var_11) && var_11 == var_10) {
          continue;
        }
      }

      var_7 = distance(var_10.origin, self.origin);

      if(var_7 < var_5) {
        var_5 = var_7;
        var_4 = var_10;
      }
    }

    if(!isDefined(var_5) || !isDefined(var_6)) {
      iprintln("Error: forklift_run_over_monitor couldn't get valid distances");
      return;
    }

    if(var_6 < var_5) {
      var_5 = var_6;
      var_4 = level.player;
    }

    if(var_5 > 145) {
      if(var_1) {
        self vehicle_setspeed(var_2);
        var_1 = 0;
      } else
        continue;
    } else if(var_5 < 95)
      var_1 = 1;
    else {
      var_13 = common_scripts\utility::within_fov(self.origin, self.angles, var_4.origin, var_3);

      if(!var_13) {
        if(var_1) {
          self vehicle_setspeed(var_2);
          var_1 = 0;
        } else
          continue;
      } else
        var_1 = 1;
    }

    if(var_1) {
      self vehicle_setspeed(0, 10);
      wait 2;
    }
  }
}

make_it_rain(var_0, var_1) {
  level endon(var_1);

  for(;;) {
    playFX(common_scripts\utility::getfx(var_0), level.player.origin);
    wait 0.1;
  }
}

quick_kill(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  common_scripts\utility::array_thread(var_0, maps\_utility::cqb_aim, var_1);

  if(isDefined(var_3)) {
    [[var_3]](var_0, var_1);
  }

  if(!isDefined(var_1) || !isalive(var_1)) {
    common_scripts\utility::array_thread(var_0, maps\_utility::cqb_aim, undefined);
    return;
  }

  var_1.dontattackme = undefined;

  if(var_2 == 1) {
    var_1.health = 1;
  }

  var_4 = var_0[0] gettagorigin("tag_flash");
  var_5 = var_1 gettagorigin("j_head");
  var_6 = bulletTrace(var_4, var_5, 1);

  if(var_0.size > 1) {
    if(isDefined(var_6["entity"]) && var_6["entity"] == level.player) {
      var_0 = common_scripts\utility::array_reverse(var_0);
    }
  }

  var_7 = randomint(var_0[0].a.array["single"].size);
  var_8 = var_0[0].a.array["single"][var_7];
  var_9 = 0.1 / weaponfiretime(var_0[0].weapon);

  if(!isalive(var_1)) {
    common_scripts\utility::array_thread(var_0, maps\_utility::cqb_aim, undefined);
    return;
  }

  for(var_10 = 0; var_10 < var_2; var_10++) {
    if(isalive(var_1)) {
      var_5 = var_1 gettagorigin("j_head");

      if(var_2 - var_10 == 1) {
        var_1.health = 1;
      }
    }

    var_11 = (0, 0, 0);

    if(var_2 - var_10 > 1) {
      var_11 = (0, 0, randomfloatrange(5, 15) * -1);
    }

    var_0[0] setflaggedanimknobrestart("fire_notify", var_8, 1, 0.2, var_9);
    var_0[0] waittillmatch_or_timeout("fire_notify", "fire", 0.2);
    var_4 = var_0[0] gettagorigin("tag_flash");
    var_0[0] maps\factory_intro::safe_magic_bullet(var_4, var_5 + var_11);

    if(var_2 - var_10 > 1) {
      wait(0.15 + randomfloat(0.1));
    }
  }

  if(isalive(var_1)) {
    if(isDefined(var_1.magic_bullet_shield)) {
      var_1 maps\_utility::stop_magic_bullet_shield();
    }

    var_1 kill();
  }

  common_scripts\utility::array_thread(var_0, maps\_utility::cqb_aim, undefined);
}

waittillmatch_or_timeout(var_0, var_1, var_2) {
  self notify("waittillmatch_timeout");
  thread waittillmatch_timeout(var_2);
  self endon("waittillmatch_timeout");
  self endon("death");
  self waittillmatch(var_0, var_1);
  self notify("waittillmatch_timeout");
}

waittillmatch_timeout(var_0) {
  self endon("waittillmatch_timeout");
  wait(var_0);
  self notify("waittillmatch_timeout");
}

#using_animtree("vehicles");

animate_vehicle_from_path(var_0, var_1, var_2, var_3) {
  self useanimtree(#animtree);
  var_4 = maps\_utility::getanim(var_0);
  var_5 = getvehiclenode(var_1, "script_noteworthy");
  var_6 = getent(var_2, "script_noteworthy");
  var_7 = spawnStruct();
  var_7.origin = getstartorigin(var_6.origin, var_6.angles, var_4);
  var_7.angles = getstartangles(var_6.origin, var_6.angles, var_4);
  var_5 waittill("trigger");
  self vehicle_orientto(var_7.origin, var_7.angles, var_3, 0.0);
  self waittill("orientto_complete");
  thread animated_script_model(self, var_6, #animtree, var_4);
  self animscripted("vehicle_animation", var_6.origin, var_6.angles, var_4);
  wait(getanimlength(var_4));
}

animated_script_model(var_0, var_1, var_2, var_3) {
  if(getdvarint("show_script_model") == 0) {
    return;
  }
  var_4 = (0, -300, 0);
  var_5 = spawn("script_model", var_1.origin);
  var_5 setModel(var_0.model);
  var_5 useanimtree(var_2);
  var_5 animscripted("blah", var_1.origin + var_4, var_1.angles, var_3);
  var_0 waittill("death");
  wait 1;
  var_5 delete();
}

veh_origin_angles_printout() {
  for(;;) {
    iprintln("origin = " + self.origin);
    iprintln("angles = " + self.angles);
    wait 0.25;
  }
}

debug_kill_counter_enable() {
  level.ally_kill_count = 0;
  level.player_kill_count = 0;
  level.auto_kill_count = 0;
  var_0 = getspawnerarray();
  maps\_utility::array_spawn_function(var_0, ::debug_who_killed_me);
  iprintlnbold("Tracking kills for " + var_0.size + " enemies");
}

debug_who_killed_me() {
  self waittill("death", var_0, var_1);

  if(isDefined(var_0)) {
    if(var_0.classname == "worldspawn") {
      level.auto_kill_count++;
      iprintlnbold("Auto kill +1 (" + level.player_kill_count + ") / (" + level.ally_kill_count + ") / (" + level.auto_kill_count + ")");
    } else if(var_0 == level.player) {
      level.player_kill_count++;
      iprintlnbold("Player kill +1 (" + level.player_kill_count + ") / (" + level.ally_kill_count + ") / (" + level.auto_kill_count + ")");
    } else if(isDefined(var_0.hero) && var_0.hero == 1) {
      level.ally_kill_count++;
      iprintlnbold("Ally kill +1 (" + level.player_kill_count + ") / (" + level.ally_kill_count + ") / (" + level.auto_kill_count + ")");
    }
  }
}

add_debug_dialogue(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level.debug_dialogue_huds)) {
    level.debug_dialogue_huds = [];
  }

  var_3 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_3 = "^1";
        break;
      case "green":
      case "g":
        var_3 = "^2";
        break;
      case "yellow":
      case "y":
        var_3 = "^3";
        break;
      case "blue":
      case "b":
        var_3 = "^4";
        break;
      case "cyan":
      case "c":
        var_3 = "^5";
        break;
      case "purple":
      case "p":
        var_3 = "^6";
        break;
      case "white":
      case "w":
        var_3 = "^7";
        break;
      case "black":
      case "bl":
        var_3 = "^8";
        break;
    }
  }

  var_4 = maps\_hud_util::createfontstring("default", 1.5);
  var_4.location = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.foreground = 1;
  var_4.sort = 20;
  var_4.alpha = 0;
  var_4 fadeovertime(0.5);
  var_4.alpha = 1;
  var_4.x = 40;
  var_4.y = 325;
  var_4.label = " " + var_3 + "< " + var_0 + " > ^7" + var_1;
  var_4.color = (1, 1, 1);
  level.debug_dialogue_huds = common_scripts\utility::array_insert(level.debug_dialogue_huds, var_4, 0);

  foreach(var_7, var_6 in level.debug_dialogue_huds) {
    if(var_7 == 0) {
      continue;
    }
    if(isDefined(var_6)) {
      var_6.y = 325 - var_7 * 18;
    }
  }

  wait 2;
  var_8 = 40;
  var_4 fadeovertime(6);
  var_4.alpha = 0;

  for(var_7 = 0; var_7 < var_8; var_7++) {
    var_4.color = (1, 1, 0 / (var_8 - var_7));
    wait 0.05;
  }

  wait 4;
  var_4 destroy();
  common_scripts\utility::array_removeundefined(level.debug_dialogue_huds);
}

load_transient(var_0) {
  unloadalltransients();
  loadtransient(var_0);
}

sync_transients() {
  while(!synctransients()) {
    wait 0.05;
  }
}

god_rays_from_world_location(var_0, var_1, var_2, var_3, var_4) {
  if(maps\_utility::is_gen4()) {
    if(isDefined(var_1)) {
      common_scripts\utility::flag_wait(var_1);
    }

    var_5 = 0;
    var_6 = 0;

    if(isDefined(var_3)) {
      maps\_utility::vision_set_fog_changes(var_3, 5);
    }

    var_7 = maps\_utility::create_sunflare_setting("default");

    for(;;) {
      var_5 = atan((level.player.origin[2] - var_0[2]) / sqrt(squared(level.player.origin[0] - var_0[0]) + squared(level.player.origin[1] - var_0[1])));

      if(level.player.origin[0] < var_0[0]) {
        var_6 = atan((level.player.origin[1] - var_0[1]) / (level.player.origin[0] - var_0[0]));
      } else {
        var_6 = 180 + atan((level.player.origin[1] - var_0[1]) / (level.player.origin[0] - var_0[0]));
      }

      var_7.position = (var_5, var_6, 0);
      maps\_art::sunflare_changes("default", 0);
      wait 0.05;

      if(isDefined(var_2)) {
        if(common_scripts\utility::flag(var_2)) {
          break;
        }
      }
    }

    if(isDefined(var_4)) {
      maps\_utility::vision_set_fog_changes(var_4, 5);
      wait 5;
      maps\_utility::vision_set_fog_changes("", 1);
    }
  }
}

god_rays_from_moving_source(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(maps\_utility::is_gen4()) {
    if(isDefined(var_2)) {
      common_scripts\utility::flag_wait(var_2);
    }

    var_6 = 0;
    var_7 = 0;

    if(isDefined(var_4)) {
      maps\_utility::vision_set_fog_changes(var_4, 1);
    }

    var_8 = maps\_utility::create_sunflare_setting("default");

    for(;;) {
      if(isDefined(var_1)) {
        var_9 = var_0 gettagorigin("tag_flash");
      } else {
        var_9 = var_0.origin;
      }

      var_6 = atan((level.player.origin[2] - var_9[2]) / sqrt(squared(level.player.origin[0] - var_9[0]) + squared(level.player.origin[1] - var_9[1])));

      if(level.player.origin[0] < var_9[0]) {
        var_7 = atan((level.player.origin[1] - var_9[1]) / (level.player.origin[0] - var_9[0]));
      } else {
        var_7 = 180 + atan((level.player.origin[1] - var_9[1]) / (level.player.origin[0] - var_9[0]));
      }

      var_8.position = (var_6, var_7, 0);
      maps\_art::sunflare_changes("default", 0);
      wait 0.05;

      if(isDefined(var_3)) {
        if(common_scripts\utility::flag(var_3)) {
          break;
        }
      }
    }

    if(isDefined(var_5)) {
      maps\_utility::vision_set_fog_changes(var_5, 1);
      wait 1;
      maps\_utility::vision_set_fog_changes("", 1);
    }
  }
}

god_rays_intro() {
  if(maps\_utility::is_gen4()) {
    maps\_utility::vision_set_fog_changes("factory_intro_godray", 0);
    var_0 = maps\_utility::create_sunflare_setting("default");
    var_0.position = (-26.4928, 7.46195, 0);
    maps\_art::sunflare_changes("default", 0);
    wait 1.5;
    maps\_utility::vision_set_fog_changes("factory_intro", 5);
    wait 5;
    maps\_utility::vision_set_fog_changes("", 0);
    var_0 = maps\_utility::create_sunflare_setting("default");
    var_0.position = (-1.80725, -89.6621, 0);
    maps\_art::sunflare_changes("default", 0);
  }
}

god_rays_trainyard() {
  if(maps\_utility::is_gen4()) {
    god_rays_from_world_location((4078, 3541, 1321), undefined, "factory_exterior_reveal", "factory_godray", "factory_ingress");
  }
}

god_rays_factory_awning() {
  if(maps\_utility::is_gen4()) {
    god_rays_from_world_location((4208, 4299, 263), "factory_exterior_reveal_between_trains", "player_entered_awning", undefined, undefined);
  }
}

god_rays_factory_open() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-1.24146, -65.8795, 0);
  maps\_art::sunflare_changes("default", 0);
  level.player visionsetstage(1, 1);
  wait 3.0;
  level.player visionsetstage(0, 2);
  wait 1.0;
}

god_rays_round_door_open() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-15.2415, -80.8795, 0);
  maps\_art::sunflare_changes("default", 0);
  maps\_utility::vision_set_fog_changes("factory_interior_godray_2", 3);
  wait 7;
  maps\_utility::vision_set_fog_changes("", 4);
}

god_rays_car_chase_01() {
  if(maps\_utility::is_gen4()) {
    iprintlnbold("god_rays_car_chase_01");
    var_0 = maps\_utility::create_sunflare_setting("default");
    var_0.position = (-1.71387, 1.49415, 0);
    maps\_art::sunflare_changes("default", 0);
  }
}

god_rays_car_chase_02() {
  if(maps\_utility::is_gen4()) {
    iprintlnbold("god_rays_car_chase_02");
    var_0 = maps\_utility::create_sunflare_setting("default");
    var_0.position = (-1.90063, -58.1012, 0);
    maps\_art::sunflare_changes("default", 0);
  }
}

god_rays_car_chase_03() {
  if(maps\_utility::is_gen4()) {
    iprintlnbold("god_rays_car_chase_03");
    var_0 = maps\_utility::create_sunflare_setting("default");
    var_0.position = (-1.90063, -58.1012, 0);
    maps\_art::sunflare_changes("default", 0);
  }
}

factory_black_zone_achievement() {
  level endon("stealth_broken");
  level endon("trainyard_enemy_alerted");
  level endon("presat_revolving_door_dialog_done");

  for(;;) {
    if(level.player.stats["kills"] >= 5) {
      break;
    }

    wait 0.25;
  }

  level.player maps\_utility::player_giveachievement_wrapper("LEVEL_13A");
}