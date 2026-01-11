/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_util.gsc
*****************************************************/

move_player_to_start_point(var_0) {
  var_1 = getent(var_0, "targetname");
  level.player setorigin(var_1.origin);
  var_2 = undefined;

  if(isDefined(var_1.target)) {
    var_2 = getent(var_1.target, "targetname");
  }

  if(isDefined(var_2)) {
    level.player setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  }
  else {
    level.player setplayerangles(var_1.angles);
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

safe_trigger_by_targetname(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 notify("trigger");

  if(var_1.classname == "trigger_once" || isDefined(var_1.spawnflags) && var_1.spawnflags & 64) {
    var_1 delete();
  }
}

safe_trigger_by_noteworthy(var_0) {
  var_1 = getent(var_0, "script_noteworthy");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 notify("trigger");

  if(var_1.classname == "trigger_once" || isDefined(var_1.spawnflags) && var_1.spawnflags & 64) {
    var_1 delete();
  }
}

teleport_squad(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_2 = ["ALLY_ALPHA", "ALLY_BRAVO", "ALLY_CHARLIE", "ALLY_DELTA", "ALLY_ECHO"];
  }
  else {
    var_2 = ["ALLY_ALPHA", "ALLY_BRAVO", "ALLY_CHARLIE"];
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    actor_teleport(level.squad[var_2[var_3]], var_2[var_3] + "_" + var_0 + "_teleport");
    var_4 = getnode(var_2[var_3] + "_" + var_0 + "_node", "targetname");
    level.squad[var_2[var_3]] setgoalnode(var_4);
  }
}

teleport_squadmember(var_0, var_1) {
  actor_teleport(level.squad[var_1], var_1 + "_" + var_0 + "_teleport");
  var_2 = getnode(var_1 + "_" + var_0 + "_node", "targetname");
  level.squad[var_1] setgoalnode(var_2);
}

safe_delete_targetname(var_0) {
  safe_delete_array(getEntArray(var_0, "targetname"));
}

safe_delete_noteworthy(var_0) {
  safe_delete_array(getEntArray(var_0, "script_noteworthy"));
}

safe_delete(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
  else {}
}

safe_delete_array(var_0) {
  foreach(var_2 in var_0) {
  safe_delete(var_2);
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
  var_4 fadeovertime(3);
  var_4.alpha = 0;

  for(var_7 = 0; var_7 < var_8; var_7++) {
    var_4.color = (1, 1, 0 / (var_8 - var_7));
    wait 0.05;
  }

  wait 4;
  var_4 destroy();
  common_scripts\utility::array_removeundefined(level.debug_dialogue_huds);
}

teleport_to_target() {
  var_0 = common_scripts\utility::get_target_ent();

  if(!isDefined(var_0.angles)) {
    var_0.angles = self.angles;
  }

  self forceteleport(var_0.origin, var_0.angles);
}

spawn_odin_actor_array(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
  var_3[var_3.size] = var_5 spawn_odin_actor_internal(var_1);
  }

  return var_3;
}

spawn_odin_actor_single(var_0, var_1) {
  var_2 = getent(var_0, "targetname");

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = var_2 spawn_odin_actor_internal(var_1);
  return var_3;
}

spawn_odin_actor_internal(var_0, var_1) {
  if(!isDefined(self)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = maps\_utility::spawn_ai(var_1);

  if(maps\_utility::spawn_failed(var_2)) {
    return;
  }
  var_2 thread maps\_space_ai::enable_space();
  var_3 = common_scripts\utility::get_target_ent();

  if(isDefined(var_3)) {
    if(!isDefined(var_3.angles)) {
      var_3.angles = self.angles;
    }

    var_2 forceteleport(var_3.origin, var_3.angles);
  }

  if(isDefined(var_3.target)) {
    var_2.default_node = getnode(var_3.target, "targetname");

    if(isDefined(var_2.default_node)) {
      var_2 setgoalnode(var_2.default_node);
      var_2.goalradius = 4;
    }
  }

  return var_2;
}

add_light_to_actor(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = self gettagorigin("tag_eye");
  var_1.origin = var_2 + (-9, 0, 2);
  var_1 linkto(self, "tag_eye");
  var_3 = common_scripts\utility::getfx("light_blue_steady_FX");

  if(var_0 == "ally") {
    var_3 = common_scripts\utility::getfx("light_blue_steady_FX");
  }

  if(var_0 == "axis") {
    var_3 = common_scripts\utility::getfx("amber_light_45_beacon_nolight_glow");
  }

  while(isalive(self)) {
    playFXOnTag(var_3, var_1, "tag_origin");
    wait 0.2;
    stopFXOnTag(var_3, var_1, "tag_origin");
    wait 0.8;
  }

  var_1 delete();
}

set_mission_view_tweaks() {
  setsaveddvar("cg_fov", level.odin_fov);

  if(!common_scripts\utility::flag("spin_start_exterior_dialogue")) {
    maps\_utility::lerp_fov_overtime(0.05, level.odin_fov);
  }

  common_scripts\utility::flag_wait("ally_gun_struggle_FOV_change");
  maps\_utility::lerp_fov_overtime(1, level.odin_fov + 10);
  common_scripts\utility::flag_wait("saved_ally");
  maps\_utility::lerp_fov_overtime(3, level.odin_fov);
  common_scripts\utility::flag_wait("start_transition_to_youngblood");
  maps\_utility::lerp_fov_overtime(5, 65);
}

player_physics_pulse() {
  level endon("kickoff_player_finale");

  if(isDefined(level.player.physics_pulse_on) && level.player.physics_pulse_on) {
    return;
  }
  level.player.physics_pulse_on = 1;
  var_0 = 0.15;
  var_1 = 64;

  for(;;) {
    if(common_scripts\utility::flag("player_spin_decomp_anim_done")) {
      var_0 = 0.2;
      var_1 = 96;
    }

    physicsexplosionsphere(level.player.origin, var_1, 1, var_0);
    wait 0.05;
  }
}

ally_physics_pulse() {
  level endon("kickoff_player_finale");

  if(isDefined(level.ally.physics_pulse_on) && level.ally.physics_pulse_on) {
    return;
  }
  level.ally.physics_pulse_on = 1;

  for(;;) {
    physicsexplosionsphere(level.ally.origin, 45, 32, 0.15);
    wait 0.05;
  }
}

npc_physics_pulse() {
  self endon("death");

  if(isDefined(self.physics_pulse_on) && self.physics_pulse_on) {
    return;
  }
  self.physics_pulse_on = 1;

  for(;;) {
    physicsexplosionsphere(self.origin, 45, 32, 0.15);
    wait 0.05;
  }
}

floating_corpses(var_0, var_1) {
  var_2 = spawn_odin_actor_array(var_0, 1);

  foreach(var_4 in var_2) {
    var_4.no_ai = 1;
    var_4.ignoreall = 1;
    var_4.ignoreme = 1;
    var_4.dontevershoot = 1;
    var_4.team = "neutral";
    var_4.diequietly = 1;
    var_4.no_pain_sound = 1;
    var_4.nocorpsedelete = 1;
    var_4.forceragdollimmediate = 1;
    var_4.skipdeathanim = 1;
  }

  wait 1.0;

  if(isDefined(var_1)) {
    common_scripts\utility::flag_wait(var_1);
  }

  foreach(var_4 in var_2) {
  var_4 kill();
  }
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

moving_objects_handler(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = getEntArray(var_0, "script_noteworthy");

  foreach(var_6 in var_4) {
    if(var_6.script_parameters == "moving_object_origin") {
      var_3 = var_6;
    }
  }

  foreach(var_6 in var_4) {
    if(var_6.script_parameters == "moving_object") {
      var_6 linkto(var_3);
    }

    if(var_6.script_parameters == "path_connector") {
      var_6 linkto(var_3);
      var_3.connector = var_6;
    }

    if(var_6.script_parameters == "path_disconnector") {
      var_6 linkto(var_3);
      var_3.disconnector = var_6;
    }
  }

  thread path_disconnector(var_3.disconnector, var_3.connector);
  return var_3;
}

path_disconnector(var_0, var_1) {
  self endon("death");
  self endon("stop_scripts");
  var_2 = getEntArray("moving_platform_path_trigger", "targetname");
  var_3 = getEntArray("path_connector", "script_noteworthy");
  var_4 = getEntArray("path_disconnector", "script_noteworthy");

  for(;;) {
    var_0 solid();
    var_1 solid();
    var_0 disconnectpaths();
    var_1 connectpaths();
    var_0 notsolid();
    var_1 notsolid();
    wait 0.2;
  }
}

create_sliding_space_door(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getEntArray(var_0, "script_noteworthy");

  if(!isDefined(var_7) || var_7.size == 0) {
    iprintln("create_sliding_space_door failed. No parts");
  }
  else {
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;

    foreach(var_12 in var_7) {
      if(var_12.classname == "script_origin") {
        if(isDefined(var_12.targetname)) {
          if(var_12.targetname == "door_closed_node") {
            var_8 = var_12;
            continue;
          }

          if(var_12.targetname == "door_node") {
            var_9 = var_12;
            continue;
          }

          if(var_12.targetname == "door_open_node") {
            var_10 = var_12;
          }
        }
      }
    }

    var_8.door = var_9;
    var_8.door_open = var_10;
    var_8.time = var_1;
    var_8.accel = var_2;
    var_8.delay = var_3;
    var_8.automatic = var_4;
    var_8.lock_notify = var_5;
    var_8.unlock_flag = var_6;
    var_8.door_name = var_0;
    var_14 = getEntArray(var_8.door.target, "targetname");
    var_8.parts = var_14;

    foreach(var_12 in var_14) {
    var_12 linkto(var_8.door);
    }

    var_8.trigger = spawn("trigger_radius", var_8.origin, 3, var_8.radius, 64);

    if(isDefined(var_4) && var_4 == 1) {
      var_8.trigger common_scripts\utility::trigger_on();
      var_8 thread automatic_sliding_door_logic();
    } else
      var_8 thread sliding_door_logic();

    var_8 thread sliding_door_lock();
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
        self.state = "open";

        if(self.delay > 0) {
          wait(self.delay);
        }

        self.door moveto(self.door_open.origin, self.time, self.accel);
        thread maps\odin_audio::sfx_interior_door_open(self);
      }
    } else if(self.state == "opening" || self.state == "open") {
      self.state = "closed";

      if(self.delay > 0) {
        wait(self.delay);
      }

      self.door moveto(self.origin, self.time, self.accel);
      thread maps\odin_audio::sfx_interior_door_close(self);
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

sliding_door_logic() {
  self endon("death");
  level endon(self.lock_notify);

  if(isDefined(self.unlock_flag) && !common_scripts\utility::flag(self.unlock_flag)) {
    self.state = "closed";
    self.door moveto(self.origin, 0.1, self.accel);
    common_scripts\utility::flag_wait(self.unlock_flag);

    if(self.state == "closing" || self.state == "closed") {
      self.state = "open";

      if(self.delay > 0) {
        wait(self.delay);
      }

      self.door moveto(self.door_open.origin, self.time, self.accel);

      if(self.door_name == "post_z_door" || self.door_name == "escape_door_blocker") {
        thread maps\odin_audio::sfx_escape_door_open();
      }
      else if(self.door_name == "spin_decomp_door") {
        thread maps\odin_audio::sfx_decomp_door();
      }
      else {
        thread maps\odin_audio::sfx_interior_door_open(self);
      }
    }
  }
}

sliding_door_lock() {
  level endon("start_transition_to_youngblood");
  self endon("death");
  level waittill(self.lock_notify);
  self.state = "closed";

  if(self.delay > 0) {
    wait(self.delay);
  }

  self.door moveto(self.origin, self.time, self.accel);
  thread maps\odin_audio::sfx_interior_door_close(self);

  if(isDefined(self.trigger)) {
    self.trigger common_scripts\utility::trigger_off();
    self.trigger delete();
  }
}

normalize_value(var_0, var_1, var_2) {
  if(var_2 > var_1) {
    return 1.0;
  }
  else if(var_2 < var_0) {
    return 0.0;
  }

  return (var_2 - var_0) / (var_1 - var_0);
}

factor_value_min_max(var_0, var_1, var_2) {
  return var_1 * var_2 + var_0 * (1 - var_2);
}

check_anim_time(var_0, var_1, var_2) {
  var_3 = self getanimtime(level.scr_anim[var_0][var_1]);

  if(var_3 >= var_2) {
    return 1;
  }

  return 0;
}

god_rays_from_moving_source(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = maps\_utility::create_sunflare_setting("default");

  while(!common_scripts\utility::flag(var_2)) {
    var_6 = var_0.origin;
    var_3 = atan((level.player.origin[2] - var_6[2]) / sqrt(squared(level.player.origin[0] - var_6[0]) + squared(level.player.origin[1] - var_6[1])));

    if(level.player.origin[0] < var_6[0]) {
      var_4 = atan((level.player.origin[1] - var_6[1]) / (level.player.origin[0] - var_6[0]));
    }
    else {
      var_4 = 180 + atan((level.player.origin[1] - var_6[1]) / (level.player.origin[0] - var_6[0]));
    }

    var_5.position = (var_3, var_4, 0);
    maps\_art::sunflare_changes("default", 0);
    wait 0.05;
  }
}

initial_satellite_placement() {
  var_0 = satellite_get_script_mover();
  var_1 = getent("sat_intro_initial_position", "targetname");
  var_0 moveto(var_1.origin, 0.1);
  var_0 rotateto(var_1.angles, 0.1);
  var_0 waittill("movedone");
  wait 4;
  var_2 = [];
  var_2["odin_sat_section_04_pod_doorL_01"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_01"];
  var_2["odin_sat_section_04_pod_doorL_02"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_02"];
  var_2["odin_sat_section_04_pod_doorL_03"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_03"];
  var_2["odin_sat_section_04_pod_doorL_04"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_04"];
  var_2["odin_sat_section_04_pod_doorR_01"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_01"];
  var_2["odin_sat_section_04_pod_doorR_02"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_02"];
  var_2["odin_sat_section_04_pod_doorR_03"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_03"];
  var_2["odin_sat_section_04_pod_doorR_04"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_04"];
  level thread maps\odin_fx::fx_sat_doors_close(var_2);
  level.odin_animnode thread maps\_anim::anim_single(level.animated_sat_part, "sat_blossom_close");
}

nag_line_generator(var_0, var_1, var_2) {
  level endon("stop_nag");
  level endon(var_1);
  var_3 = 8;
  var_4 = 20;
  var_5 = 0.5;
  var_6 = 1.5;

  if(!isDefined(var_0)) {
    var_0 = randomizer_create(["factory_bkr_hurryuprook", "factory_bkr_comeon", "factory_bkr_theholdup"]);
  }
  else {
    var_0 = randomizer_create(var_0);
  }

  for(;;) {
    wait(var_3 + randomfloatrange(-2.0, 2.0));
    var_7 = var_0 randomizer_get_no_repeat();

    if(isDefined(var_2)) {
      maps\_utility::smart_radio_dialogue(var_7);
    }
    else {
      thread maps\_utility::smart_dialogue(var_7);
    }

    if(var_3 < var_4) {
      var_3 = var_3 + randomfloatrange(var_5, var_6);
    }
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

flashlight() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linktoplayerview(self, "tag_flash", (0, 0, 0), (0, 0, 0), 1);
  playFXOnTag(level._effect["flashlight"], var_0, "tag_origin");
}

struggle_flashlight(var_0) {
  playFXOnTag(level._effect["flashlight"], var_0, "tag_light");
  common_scripts\utility::flag_wait("teleport_player_to_z_trans");
  wait 1;
  stopFXOnTag(level._effect["flashlight"], var_0, "tag_light");
}

satellite_get_script_mover() {
  if(!isDefined(level.satellite_script_mover)) {
    var_0 = getent("satellite_link_org", "targetname");
    level.satellite_script_mover = var_0;
    spawn_and_assemble_animated_satellite(var_0);
    var_1 = getEntArray("spacejump_sat", "targetname");

    foreach(var_3 in var_1) {
      var_3 linkto(var_0);
      level.sat_ent_del[level.sat_ent_del.size] = var_3;
    }

    maps\odin_fx::fx_setup_sat_lights();
  }

  return level.satellite_script_mover;
}

spawn_and_assemble_animated_satellite(var_0) {
  level.odin_animnode = var_0;
  var_1 = getEntArray("odin_satellite_animated", "targetname");
  level.odin_rotator = getent("odin_sat_section_03_rot", "script_noteworthy");
  level.sat_ent_del[level.sat_ent_del.size] = level.odin_rotator;
  level.odin_rotator.animname = "odin_sat_section_03_rot";
  level.odin_rotator maps\_utility::assign_animtree("odin_sat_section_03_rot");
  level.animated_sat_part = [];

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy != "odin_sat_section_03_rot") {
      var_3.animname = var_3.script_noteworthy;
      level.animated_sat_part[var_3.script_noteworthy] = var_3;
      level.animated_sat_part[var_3.script_noteworthy] maps\_utility::assign_animtree(var_3.script_noteworthy);
      var_3 linkto(level.odin_animnode);
      level.sat_ent_del[level.sat_ent_del.size] = var_3;
    }
  }

  level.odin_animnode maps\_anim::anim_first_frame(level.animated_sat_part, "sat_blossom_close");
  level.odin_rotator linkto(level.odin_animnode);

  foreach(var_6 in level.animated_sat_part) {
  var_6 linkto(level.odin_animnode);
  }

  level.odin_animnode thread maps\_anim::anim_loop_solo(level.odin_rotator, "odin_sat_blossom_close_spin", "stop_sat_loops");

  foreach(var_6 in level.animated_sat_part) {
  var_6 stopanimscripted();
  }
}

satellite_move_to(var_0, var_1, var_2, var_3) {
  var_4 = satellite_get_script_mover();
  var_5 = getent(var_0, "targetname");

  if(isDefined(var_2)) {
    var_4 moveto(var_5.origin, var_1, var_2, var_3);
  }
  else {
    var_4 moveto(var_5.origin, var_1);
  }
}

earth_get_script_mover() {
  if(!isDefined(level.earth_script_mover)) {
    var_0 = getEntArray("spin_earth", "targetname");
    var_1 = undefined;
    var_2 = undefined;

    foreach(var_4 in var_0) {
      if(var_4.classname == "script_origin") {
        var_1 = var_4;
        continue;
      }

      if(var_4.classname == "script_model") {
        var_2 = var_4;
      }
    }

    if(!isDefined(var_1)) {
      return;
    }
    var_0 = common_scripts\utility::array_remove(var_0, var_1);

    if(isDefined(var_1.target)) {
      foreach(var_4 in var_0) {
      var_4 linkto(var_1);
      }
    }

    level.earth_script_mover = var_1;
    level.earth_script_mover.earth_model = var_2;
  }

  return level.earth_script_mover;
}

odin_control_player_speed() {
  var_0 = 0;

  if(level.start_point != "default") {
    var_0 = 1;
  }

  switch (level.start_point) {
    case "odin_intro":
    case "default":
      level.space_friction = 15;
      level.space_speed = 80;
      level.space_accel = 75;
      level.space_vertical_speed = 65;
      level.space_vertical_accel = 85;
      odin_refresh_player_speed();
      common_scripts\utility::flag_wait("open_airlock_door");
    case "odin_ally":
      common_scripts\utility::flag_set("prologue_ready_for_thrusters");
      level.space_friction = 15;
      level.space_speed = 46.66;
      level.space_accel = 75;
      level.space_vertical_speed = 60;
      level.space_vertical_accel = 75;
      odin_refresh_player_speed();
    case "odin_escape":
      common_scripts\utility::flag_set("prologue_ready_for_thrusters");
      level.space_friction = 15;
      level.space_speed = 46.66;
      level.space_accel = 75;
      level.space_vertical_speed = 60;
      level.space_vertical_accel = 75;
      odin_refresh_player_speed();
      common_scripts\utility::flag_wait("ally_console_scene_done");
      level.space_speed = 58;
      odin_refresh_player_speed();
      common_scripts\utility::flag_wait("player_in_outside_spin");
    case "odin_spin":
      common_scripts\utility::flag_set("prologue_ready_for_thrusters");
      level.space_friction = 15;
      level.space_speed = 70;
      level.space_accel = 75;
      level.space_vertical_speed = 60;
      level.space_vertical_accel = 75;
      odin_refresh_player_speed();
      common_scripts\utility::flag_wait("spin_clear");
    case "odin_spacejump":
      common_scripts\utility::flag_set("prologue_ready_for_thrusters");
      level.space_friction = 15;
      level.space_speed = 70;
      level.space_accel = 75;
      level.space_vertical_speed = 60;
      level.space_vertical_accel = 75;
      odin_refresh_player_speed();
      common_scripts\utility::flag_wait("spacejump_clear");
    case "odin_satellite":
      common_scripts\utility::flag_set("prologue_ready_for_thrusters");
      level.space_friction = 15;
      level.space_speed = 70;
      level.space_accel = 65;
      level.space_vertical_speed = 55;
      level.space_vertical_accel = 65;
      common_scripts\utility::flag_wait("triggered_finale");
    default:
  }
}

odin_refresh_player_speed() {
  setsaveddvar("player_swimFriction", level.space_friction);
  setsaveddvar("player_swimAcceleration", level.space_accel);
  setsaveddvar("player_swimVerticalSpeed", level.space_vertical_speed);
  setsaveddvar("player_swimVerticalAcceleration", level.space_vertical_accel);
  setsaveddvar("player_swimSpeed", level.space_speed);
}

push_out_of_doorway(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "X":
    case "x":
      var_0 = 0;
      break;
    case "Y":
    case "y":
      var_0 = 1;
      break;
    default:
      break;
  }

  switch (var_1) {
    case ">":
      while(level.player.origin[var_0] - 32 >= level.ally.origin[var_0]) {
        setsaveddvar("player_swimSpeed", 0);
        level.ally pushplayer(0);
        setsaveddvar("player_swimWaterCurrent", (var_2, var_3, 0));
        wait 0.01;
      }

      break;
    case "<":
      while(level.player.origin[var_0] - 32 <= level.ally.origin[var_0]) {
        setsaveddvar("player_swimSpeed", 0);
        level.ally pushplayer(0);
        setsaveddvar("player_swimWaterCurrent", (var_2, var_3, 0));
        wait 0.01;
      }

      break;
    default:
      break;
  }

  setsaveddvar("player_swimSpeed", level.space_speed);
  level.ally pushplayer(1);
  wait 0.5;
  setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
}

finale_anim_loop_killer(var_0, var_1) {
  common_scripts\utility::flag_wait("end_ally_loop_anims");

  if(isDefined(var_0)) {
    var_0 notify("ender");
  }
}

entity_counter() {
  common_scripts\utility::create_dvar("entity_counter", 1);

  for(var_0 = getdvarint("entity_counter"); var_0; var_0 = getdvarint("entity_counter")) {
    iprintln("ENTS: " + getEntArray().size);
    wait 1;
  }
}

player_speed_check() {
  wait 4;
  var_0 = level.player.origin;
  var_1 = level.player.origin;
  var_2 = 0;

  for(;;) {
    var_0 = level.player.origin;
    var_3 = distance(var_0, var_1);
    var_3 = var_3 * 3600;
    var_3 = var_3 / 12;
    var_3 = var_3 / 5280;

    if(var_2 < var_3) {
      var_2 = var_3;
    }

    iprintlnbold("MPH:" + var_3 + " Top:" + var_2);
    var_1 = level.player.origin;
    wait 1;
  }
}

odin_drop_weapon() {
  level endon("stop_weapon_drop_scripts");

  if(!isDefined(level.odin_custom_weap_splash)) {
    level.odin_dropped_weapons = [];
    thread custom_weap_splash();
  }

  level.odin_custom_weap_splash = 1;
  var_0 = self.a.weaponpos["right"];

  if(var_0 != "none") {
    self.nodrop = 1;
    var_1 = create_world_model_from_ent_weapon(var_0);
    var_1 hide();
    var_1.origin = self gettagorigin("tag_weapon");
    var_1.angles = self gettagangles("tag_weapon");
    var_1 linkto(self, "tag_weapon");
    self waittill("death");
    var_2 = create_drop_weapon_trigger(var_1);
    var_1 show();
    animscripts\shared::placeweaponon(var_0, "none");

    if(common_scripts\utility::cointoss()) {
      var_3 = randomintrange(-400, -100);
    }
    else {
      var_3 = randomintrange(100, 400);
    }

    if(common_scripts\utility::cointoss()) {
      var_4 = randomintrange(-400, -100);
    }
    else {
      var_4 = randomintrange(100, 400);
    }

    var_1 physicslaunchserver(var_1.origin + (0, 0, 10), (var_3, 0, 0));
    var_1 thread odin_drop_weapon_cleanup(var_2);
  }
}

custom_weap_splash() {
  thread display_splash_func();
  level endon("player_has_shroud_now");

  for(;;) {
    common_scripts\utility::flag_wait("show_custom_weap_splash");
    create_qte_prompt(&"ODIN_SHROUD_PICKUP", "hud_icon_microtar_space", 1.25);
    common_scripts\utility::flag_waitopen("show_custom_weap_splash");
    destroy_qte_prompt();
  }
}

display_splash_func() {
  level endon("player_has_shroud_now");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.odin_dropped_weapons) {
      if(isDefined(var_2)) {
        var_3 = distance(level.player.origin, var_2.origin);

        if(var_3 <= 60) {
          var_0 = 1;
        }
      }
    }

    if(var_0 == 1) {
      common_scripts\utility::flag_set("show_custom_weap_splash");
    }
    else {
      common_scripts\utility::flag_clear("show_custom_weap_splash");
    }

    wait 0.1;
  }
}

create_drop_weapon_trigger(var_0) {
  var_0 makeusable();
  thread wait_for_use_trigger_stop(var_0);
  thread odin_drop_weapon_trigger_use(var_0);
  level.odin_dropped_weapons[level.odin_dropped_weapons.size] = var_0;
}

wait_for_use_trigger_stop(var_0) {
  common_scripts\utility::flag_wait("player_has_shroud");
  level notify("player_has_shroud_now");

  if(!isDefined(var_0)) {
    return;
  }
  destroy_qte_prompt();
  var_0 makeunusable();
  var_1 = spawn("trigger_radius", var_0.origin, 0, 20, 20);
  var_1 enablelinkto();
  var_1 linkto(var_0);
  var_1 thread odin_drop_weapon_trigger(var_0);
  return var_1;
}

odin_drop_weapon_trigger_use(var_0) {
  level endon("start_transition_to_youngblood");
  level endon("player_has_shroud_now");
  var_0 waittill("trigger");
  level.player takeallweapons();

  if(common_scripts\utility::flag("odin_start_spin_decomp_real")) {
    level.player giveweapon("microtar_space+acogsmg_sp+spaceshroud_sp");
    level.player switchtoweapon("microtar_space+acogsmg_sp+spaceshroud_sp");
  } else {
    level.player giveweapon("microtar_space_interior+acogsmg_sp+spaceshroud_sp");
    level.player switchtoweapon("microtar_space_interior+acogsmg_sp+spaceshroud_sp");
  }

  level.player.weapon_interior = "microtar_space_interior+acogsmg_sp+spaceshroud_sp";
  level.player.weapon_exterior = "microtar_space+acogsmg_sp+spaceshroud_sp";
  var_1 = level.player getcurrentprimaryweapon();
  var_2 = level.player getweaponammostock(var_1);
  level.player playSound("weap_pickup_large_plr");
  level.player setweaponammostock(var_1, var_2 + randomintrange(30, 60));
  var_0 hidepart("tag_clip");
  var_0 hidepart("tag_silencer");
  level thread create_pushed_dropped_weapon(var_0.origin, var_0.angles, var_0.model, var_0.attachments, 1);
  var_0 delete();
  common_scripts\utility::flag_set("player_has_shroud");
}

create_pushed_dropped_weapon(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_0);
  var_5.angles = var_1;
  var_5 setModel(var_2);
  var_5 hidepart("tag_clip");
  var_5.attachments = var_3;
  var_5 create_world_model_from_ent_weapon();

  if(isDefined(var_4)) {
    var_5 hidepart("tag_silencer");
  }

  var_5 physicslaunchserver(var_5.origin, anglesToForward(level.player.angles) * 2500, 500000, 5);
  wait 0.5;

  if(!isDefined(var_5)) {
    return;
  }
  var_5 thread odin_drop_weapon_cleanup(undefined, 10);
}

odin_drop_weapon_trigger(var_0) {
  level endon("start_transition_to_youngblood");
  self waittill("trigger");
  var_1 = level.player getcurrentprimaryweapon();
  var_2 = level.player getweaponammostock(var_1);
  level.player playSound("weap_pickup_large_plr");
  level.player setweaponammostock(var_1, var_2 + randomintrange(30, 60));
  var_0 hidepart("tag_clip");
  thread destroy_qte_prompt();
  level thread create_pushed_dropped_weapon(var_0.origin, var_0.angles, var_0.model, var_0.attachments);
  var_0 delete();
  self delete();
}

odin_drop_weapon_cleanup(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 45;
  }

  wait(var_1);

  while(maps\_utility::player_looking_at(self.origin, 0.4, 1)) {
    common_scripts\utility::waitframe();
  }

  if(isDefined(var_0) && isalive(var_0)) {
    var_0 delete();
  }

  self delete();
}

create_world_model_from_ent_weapon(var_0) {
  if(isDefined(var_0)) {
    var_1 = getweaponmodel(var_0);
    var_2 = spawn("script_model", (0, 0, -10000));
    var_2 setModel(var_1);
    var_2.attachments = getweaponattachments(var_0);
  } else {
    var_2 = self;
    var_1 = self.model;
    var_2.attachments = self.attachments;
  }

  var_2 hidepart("tag_sight_on", var_1);
  var_2 attach("weapon_acog_iw6", "tag_acog_2", 1);
  var_2 attach("weapon_barrel_shroud_iw6", "tag_silencer", 1);
  return var_2;
}

view_control_lerp(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = maps\_utility::spawn_anim_model("player_rig");
  var_7.origin = level.player.origin - (0, 0, 60);
  var_7.angles = level.player getplayerangles();
  wait 0.05;
  level.player playerlinktodelta(var_7, "tag_player", 1, var_0, var_0, var_0, var_0, 1);

  if(!isDefined(var_4) || var_4 > var_3) {
    var_4 = 0;
  }

  if(!isDefined(var_5) || var_5 > var_3) {
    var_5 = 0;
  }

  var_7 moveto(var_1, var_3, var_4, var_5);
  var_7 rotateto(var_2, var_3, var_4, var_5);
  wait(var_3);
  level.player playerlinktodelta(var_6, "tag_player", 1, var_0, var_0, var_0, var_0, 1);
  var_7 delete();
}

dynamic_object_pusher() {
  var_0 = [];
  var_0[0] = getent("odin_escape_ally_tp", "targetname");
  var_0[1] = getent("player_escape_door_blocker_origin", "targetname");
  var_0[2] = getent("final_dyn_push_dest", "script_noteworthy");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0[0].origin;
  thread pusher_pulses(var_1);
  thread dynamic_repulsor(var_0[1]);
  var_1 moveto(var_0[1].origin, 3, 0, 0);
  wait 3;
  var_1 notify("stop_pushing");
  common_scripts\utility::flag_wait("esc_combat_done");
  var_1 moveto(var_0[2].origin, 3, 0, 0);
  wait 2;
  thread pusher_pulses(var_1);
  wait 1;
  var_1 notify("stop_pushing");
  wait 1;
  var_1 delete();
}

pusher_pulses(var_0) {
  var_0 endon("stop_pushing");

  for(;;) {
    physicsexplosionsphere(var_0.origin, 96, 1, 0.03);
    wait 0.05;
  }
}

dynamic_repulsor(var_0) {
  var_1 = var_0.origin;

  while(!common_scripts\utility::flag("escape_blocker_door_trig")) {
    physicsexplosionsphere(var_1, 32, 1, 0.03);
    wait 0.05;
  }
}

fx_odin_monitor_bink_init() {
  setsaveddvar("cg_cinematicFullScreen", "0");

  if(maps\_utility::is_gen4()) {
    cinematicingameloopresident("prologue_odin_monitor_ng");
  }
  else {
    cinematicingameloopresident("prologue_odin_monitor");
  }

  thread fx_odin_monitor_bink_shutdown();
}

fx_odin_monitor_bink_shutdown() {
  if(level.start_point == "odin_escape") {
    stopcinematicingame();
  }
  else {
    common_scripts\utility::flag_wait("player_second_z_turn");
    stopcinematicingame();
  }

  common_scripts\utility::flag_wait("kyra_push_bag_anim");
  setsaveddvar("cg_cinematicFullScreen", "0");

  if(maps\_utility::is_gen4()) {
    cinematicingameloopresident("prologue_odin_monitor_ng");
  }
  else {
    cinematicingameloopresident("prologue_odin_monitor");
  }

  common_scripts\utility::flag_wait("decomp_done");
  stopcinematicingame();
}

odin_breathing_func(var_0) {
  switch (var_0) {
    case "breathing_better":
      self playlocalsound("breathing_better_space");
      break;
    case "breathing_hurt":
      self playlocalsound("breathing_hurt_space");
      break;
    default:
      break;
  }
}

create_qte_prompt(var_0, var_1, var_2, var_3) {
  var_4 = -3;

  if(!isDefined(var_3)) {
    var_3 = 100;
  }

  var_5 = var_2;
  var_6 = 3;
  var_7 = 130;
  var_8 = [];
  var_9 = level.player maps\_hud_util::createclientfontstring("default", var_5);
  var_9.x = var_4 * -1;
  var_9.y = var_3;
  var_9.horzalign = "right";
  var_9.alignx = "right";
  var_9.alignx = "center";
  var_9.aligny = "middle";
  var_9.horzalign = "center";
  var_9.vertalign = "middle";
  var_9.hidewhendead = 1;
  var_9.hidewheninmenu = 1;
  var_9.sort = 205;
  var_9.foreground = 1;
  var_9.alpha = 1;
  var_9 settext(var_0);
  var_8["text"] = var_9;

  if(isDefined(var_1)) {
    var_10 = maps\_hud_util::createicon(var_1, 100, 40);
    var_10.x = var_6;
    var_10.y = var_7;
    var_10.alignx = "center";
    var_10.aligny = "middle";
    var_10.horzalign = "center";
    var_10.vertalign = "middle";
    var_10.hidewhendead = 1;
    var_10.hidewheninmenu = 1;
    var_10.sort = 205;
    var_10.foreground = 1;
    var_10.alpha = 1;
    var_8["icon"] = var_10;
  }

  level.qte_prompt = var_8;
}

destroy_qte_prompt() {
  if(!isDefined(level.qte_prompt)) {
    return;
  }
  level notify("stop_blink");

  foreach(var_1 in level.qte_prompt) {
    if(isDefined(var_1)) {
      var_1 destroy();
    }
  }
}

dialogue_facial(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  maps\_utility_code::add_to_radio(var_0);
  self playSound(var_0);
  maps\_utility::bcs_scripted_dialogue_start();
  maps\_anim::anim_single_queue(self, var_1);
}