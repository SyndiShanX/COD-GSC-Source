/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_sovereign_events.gsc
*******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

assembly_line() {
  assembly_line_animate();
}

assembly_line_precache() {
  level._effect["tank_part_explode"] = loadfx("vfx/moments/mp_sovereign/vfx_halon_exp");

  level._effect["tank_part_extinguish"] = LoadFX("vfx/ambient/steam/vfx_steam_escape");
}

#using_animtree("animated_props");
assembly_line_animate() {
  level.assembly_line_tank_notetracks = [];
  level.assembly_line_tank_notetracks["scn_factory_assembly_tank00_ss"] = 4;
  tank_anim = % mp_sovereign_assembly_line_front_piece;
  anim_length = GetAnimLength(tank_anim);
  for(i = 1; i <= 13; i++) {
    notetrack_prefix = "ps_";
    sound_name = "scn_factory_assembly_tank" + ter_op(i <= 9, "0", "") + i + "_ss";
    notetrack_times = GetNotetrackTimes(tank_anim, notetrack_prefix + sound_name);
    level.assembly_line_tank_notetracks[sound_name] = notetrack_times[0] * anim_length;
  }

  for(i = 1; i <= 5; i++) {
    sound_name = "scn_factory_assembly_tank_arm0" + i + "_ss";
    notetrack_name = "front_station_0" + i + "_start";
    notetrack_times = GetNotetrackTimes(tank_anim, notetrack_name);
    level.assembly_line_tank_notetracks[sound_name] = notetrack_times[0] * anim_length;
  }

  num_tanks = 2;
  time_between_tanks = 55;

  level.next_destructible_tank = RandomIntRange(4, 6);
  for(i = 0; i < num_tanks; i++) {
    collision_brush_bottom = GetEnt("tank_chassis_collision" + (i + 1), "targetname");
    collision_brush_top = GetEnt("tank_chassis_collision_top" + (i + 1), "targetname");
    collision_brush_center = GetEnt("tank_chassis_collision_center" + (i + 1), "targetname");
    if(!isDefined(collision_brush_bottom) || !isDefined(collision_brush_top) || !isDefined(collision_brush_center)) {
      continue;
    }
    collision_brush_bottom.invalid_gameobject_mover = true;
    collision_brush_top.invalid_gameobject_mover = true;
    collision_brush_center.invalid_gameobject_mover = true;

    collision_brush_top.angles = (90, 0, 0);
    level thread assembly_line_piece(collision_brush_bottom, collision_brush_top, collision_brush_center);
    wait(time_between_tanks);
  }
}

assembly_line_piece(collision_brush_bottom, collision_brush_top, collision_brush_center) {
  assembly_line_start_pos = getstruct("assembly_start_point", "targetname");

  assembly_piece = spawn("script_model", assembly_line_start_pos.origin);
  assembly_piece.angles = assembly_line_start_pos.angles;
  assembly_piece setModel("mp_sovereign_assembly_moving_front_piece");

  collision_brush_center.origin = assembly_piece.origin;
  collision_brush_center LinkTo(assembly_piece, "tag_origin");

  assembly_line_start_pos_collision = getstruct("assembly_start_point_collision", "targetname");

  assembly_piece_collision = spawn("script_model", assembly_line_start_pos_collision.origin);
  assembly_piece_collision.angles = assembly_line_start_pos_collision.angles;
  assembly_piece_collision setModel("generic_prop_raven");

  collision_brush_bottom.origin = assembly_line_start_pos_collision.origin;
  collision_brush_bottom LinkTo(assembly_piece_collision, "tag_origin");

  assembly_line_start_pos_collision_top = getstruct("assembly_start_point_collision_top", "targetname");

  assembly_piece_collision_top = spawn("script_model", assembly_line_start_pos_collision_top.origin);
  assembly_piece_collision_top.angles = assembly_line_start_pos_collision_top.angles;
  assembly_piece_collision_top setModel("generic_prop_raven");

  collision_brush_top.origin = assembly_line_start_pos_collision_top.origin;
  collision_brush_top LinkTo(assembly_piece_collision_top, "tag_origin");

  assembly_piece.parts = [];
  if(isDefined(assembly_line_start_pos.target)) {
    parts = getEntArray(assembly_line_start_pos.target, "targetname");
    foreach(part in parts) {
      part_copy = spawn("script_model", part.origin);
      part_copy.angles = part.angles;
      part_copy setModel(part.model);

      if(isDefined(part.target)) {
        collision = GetEnt(part.target, "targetname");
        if(isDefined(collision)) {}
      }

      part_copy LinkTo(assembly_piece, "tag_tank_chassis");
      part_copy assembly_line_tank_part_visible(false);
      part_copy.parent = assembly_piece;
      assembly_piece.parts[assembly_piece.parts.size] = part_copy;
    }
  }

  assembly_piece thread assembly_line_tank_damage_watch();
  while(1) {
    level.next_destructible_tank--;

    if(level.next_destructible_tank <= 0) {
      foreach(part in assembly_piece.parts) {
        part assembly_line_tank_part_visible(true);
      }
      level.next_destructible_tank = RandomIntRange(9, 12);
    }

    assembly_piece assembly_line_notetracks();
    assembly_piece ScriptModelPlayAnimDeltaMotion("mp_sovereign_assembly_line_front_piece");
    assembly_piece_collision ScriptModelPlayAnimDeltaMotion("mp_sovereign_assembly_line_front_piece_origin");
    assembly_piece_collision_top ScriptModelPlayAnimDeltaMotion("mp_sovereign_assembly_line_front_piece_origin_top");

    fullAnimLength = GetAnimLength( % mp_sovereign_assembly_line_front_piece);
    thread animate_arms(fullAnimLength);
    wait(fullAnimLength);

    assembly_piece ScriptModelClearAnim();
    assembly_piece.origin = assembly_line_start_pos.origin;
    assembly_piece.angles = assembly_line_start_pos.angles;

    assembly_piece_collision ScriptModelClearAnim();
    assembly_piece_collision.origin = assembly_line_start_pos_collision.origin;
    assembly_piece_collision.angles = assembly_line_start_pos_collision.angles;

    assembly_piece_collision_top ScriptModelClearAnim();
    assembly_piece_collision_top.origin = assembly_line_start_pos_collision_top.origin;
    assembly_piece_collision_top.angles = assembly_line_start_pos_collision_top.angles;

    foreach(part in assembly_piece.parts) {
      part assembly_line_tank_part_visible(false);
    }
  }
}

assembly_line_notetracks() {
  foreach(notetrack, time in level.assembly_line_tank_notetracks) {
    self delayThread(time, ::assembly_line_notetrack_sound, notetrack);
  }
}

assembly_line_notetrack_sound(sound_name) {
  self PlaySoundOnMovingEnt(sound_name);
}

assembly_line_tank_damage_watch() {
  while(1) {
    self waittill("part_destroyed", attacker);
    foreach(part in self.parts) {
      part thread assembly_line_tank_part_explode(attacker);
      part thread assembly_line_tank_part_visible(false);
    }

    wait 1;
    level notify("activate_halon_system");
    wait 4;

    foreach(part in self.parts) {
      part thread assembly_line_tank_part_extinguish();
    }

  }
}

assembly_line_tank_part_visible(visible) {
  if(isDefined(self.is_visable) && self.is_visable == visible) {
    return;
  }
  if(visible) {
    self setModel(self.visable_model);
    self SetContents(self.visable_contents);
    self thread assembly_line_tank_part_damage_watch();
  } else {
    self.visable_model = self.model;
    self setModel("tag_origin");
    self.visable_contents = self SetContents(0);
    self assembly_line_tank_part_damage_watch_end();
  }

  self.is_visable = visible;
}

assembly_line_tank_part_damage_watch() {
  self endon("stop_tank_part_damage_watch");
  self.health = 50;
  self setCanDamage(true);
  self.last_attacker = undefined;
  while(self.health > 0) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, dflags);
    self.last_attacker = attacker;
  }
  self waittill("death");
  self.parent notify("part_destroyed", self.last_attacker);
}

assembly_line_tank_part_explode(attacker) {
  self playSound("barrel_mtl_explode");

  playFXOnTag(level._effect["tank_part_explode"], self, "tag_origin");

  playFXOnTag(level._effect["tank_part_burn"], self, "tag_origin");
  if(!isDefined(attacker))
    attacker = self;
  RadiusDamage(self.origin, 400, 300, 50, attacker, "MOD_EXPLOSIVE");
}

assembly_line_tank_part_extinguish() {
  stopFXOnTag(level._effect["tank_part_burn"], self, "tag_origin");

  playFXOnTag(level._effect["tank_part_extinguish"], self, "tag_origin");
}

assembly_line_tank_part_damage_watch_end() {
  self notify("stop_tank_part_damage_watch");
  self setCanDamage(false);
}

animate_arms(fullAnimLength) {
  front_station_01_times = GetNotetrackTimes( % mp_sovereign_assembly_line_front_piece, "front_station_01_start");
  front_station_02_times = GetNotetrackTimes( % mp_sovereign_assembly_line_front_piece, "front_station_02_start");
  front_station_03_times = GetNotetrackTimes( % mp_sovereign_assembly_line_front_piece, "front_station_03_start");
  front_station_04_times = GetNotetrackTimes( % mp_sovereign_assembly_line_front_piece, "front_station_04_start");
  front_station_05_times = GetNotetrackTimes( % mp_sovereign_assembly_line_front_piece, "front_station_05_start");

  delayThread(front_station_01_times[0] * fullAnimLength, ::animate_front_station_01);
  delayThread(front_station_02_times[0] * fullAnimLength, ::animate_front_station_02);
  delayThread(front_station_03_times[0] * fullAnimLength, ::animate_front_station_03);
  delayThread(front_station_04_times[0] * fullAnimLength, ::animate_front_station_04);
  delayThread(front_station_05_times[0] * fullAnimLength, ::animate_front_station_05);
}

animate_front_station_and_return_to_idle(arm, arm_anim) {
  arm SetScriptablePartState("arm", "animate");
  wait GetAnimLength(arm_anim);
  arm SetScriptablePartState("arm", "idle");
}

animate_front_station_01_watcher(arm_anim) {
  wait(GetAnimLength(arm_anim) - 1.5);

  damageLoc = (895.608, 1640, 92);
  damageRadius = 400;
  damageRadiusHeight = 100;

  kill_all(damageLoc, damageRadius, damageRadiusHeight);
}

kill_all(damageLoc, damageRadius, damageRadiusHeight) {
  damage_zone = spawn("trigger_radius", damageLoc, 0, damageRadius, damageRadiusHeight);

  kill_players(damage_zone);
  kill_boxes(damage_zone);
  damage_zone delete();
}

kill_players(zone) {
  foreach(player in level.participants) {
    if(player IsTouching(zone))
      player DoDamage(1000, player.origin, undefined, undefined, "MOD_CRUSH");
  }
}

kill_boxes(zone) {
  script_models = getEntArray("script_model", "classname");
  foreach(mod in script_models) {
    if(isDefined(mod.boxtype) && mod IsTouching(zone))
      mod notify("death");
  }
}

animate_front_station_01() {
  arm1a = GetScriptableArray("factory_assembly_line_front_station01_arm_a", "targetname")[0];
  arm1b = GetScriptableArray("factory_assembly_line_front_station01_arm_b", "targetname")[0];
  level thread animate_front_station_and_return_to_idle(arm1a, % mp_sovereign_assembly_line_station01_arm_A);
  level thread animate_front_station_and_return_to_idle(arm1b, % mp_sovereign_assembly_line_station01_arm_B);
  level thread animate_front_station_01_watcher( % mp_sovereign_assembly_line_station01_arm_A);
}

animate_front_station_02() {
  arm2a = GetScriptableArray("factory_assembly_line_front_station02_arm_a", "targetname")[0];
  arm2b = GetScriptableArray("factory_assembly_line_front_station02_arm_b", "targetname")[0];
  arm2c = GetScriptableArray("factory_assembly_line_front_station02_arm_c", "targetname")[0];
  arm2d = GetScriptableArray("factory_assembly_line_front_station02_arm_d", "targetname")[0];
  level thread animate_front_station_and_return_to_idle(arm2a, % mp_sovereign_assembly_line_station02_arm_A);
  level thread animate_front_station_and_return_to_idle(arm2b, % mp_sovereign_assembly_line_station02_arm_B);
  level thread animate_front_station_and_return_to_idle(arm2c, % mp_sovereign_assembly_line_station02_arm_C);
  level thread animate_front_station_and_return_to_idle(arm2d, % mp_sovereign_assembly_line_station02_arm_D);
}

animate_front_station_03() {
  arm3a = GetScriptableArray("factory_assembly_line_front_station03_arm_a", "targetname")[0];
  arm3b = GetScriptableArray("factory_assembly_line_front_station03_arm_b", "targetname")[0];
  arm3c = GetScriptableArray("factory_assembly_line_front_station03_arm_c", "targetname")[0];
  arm3d = GetScriptableArray("factory_assembly_line_front_station03_arm_d", "targetname")[0];
  level thread animate_front_station_and_return_to_idle(arm3a, % mp_sovereign_assembly_line_station03_arm_A);
  level thread animate_front_station_and_return_to_idle(arm3b, % mp_sovereign_assembly_line_station03_arm_B);
  level thread animate_front_station_and_return_to_idle(arm3c, % mp_sovereign_assembly_line_station03_arm_C);
  level thread animate_front_station_and_return_to_idle(arm3d, % mp_sovereign_assembly_line_station03_arm_D);
}

animate_front_station_04() {
  arm4a = GetScriptableArray("factory_assembly_line_front_station04_arm_a", "targetname")[0];
  arm4b = GetScriptableArray("factory_assembly_line_front_station04_arm_b", "targetname")[0];
  arm4c = GetScriptableArray("factory_assembly_line_front_station04_arm_c", "targetname")[0];
  level thread animate_front_station_and_return_to_idle(arm4a, % mp_sovereign_assembly_line_station04_arm_A);
  level thread animate_front_station_and_return_to_idle(arm4b, % mp_sovereign_assembly_line_station04_arm_B);
  level thread animate_front_station_and_return_to_idle(arm4c, % mp_sovereign_assembly_line_station04_arm_C);
}

animate_front_station_05() {
  arm5a = GetScriptableArray("factory_assembly_line_front_station05_arm_a", "targetname")[0];
  arm5b = GetScriptableArray("factory_assembly_line_front_station05_arm_b", "targetname")[0];
  arm5c = GetScriptableArray("factory_assembly_line_front_station05_arm_c", "targetname")[0];
  level thread animate_front_station_and_return_to_idle(arm5a, % mp_sovereign_assembly_line_station05_arm_A);
  level thread animate_front_station_and_return_to_idle(arm5b, % mp_sovereign_assembly_line_station05_arm_B);
  level thread animate_front_station_and_return_to_idle(arm5c, % mp_sovereign_assembly_line_station05_arm_C);
}

halon_system() {
  level.halon_fade_in_time = 2;
  level.halon_fade_out_time = 10;
  level.vision_set_stage = 0;
  level.halon_fog_on = false;
  level thread halon_system_spawn_watch();

  level thread halon_system_killstreak();

  level thread halon_system_test();
  level thread halon_fog_only();

  while(1) {
    level waittill("activate_halon_system", killstreak_player);

    level thread halon_system_run(killstreak_player);

  }
}

halon_system_killstreak() {
  while(1) {
    level waittill("sovereign_gas_killstreak", player);
    wait 2;

    start = getstruct("killstreak_explosive", "targetname");
    if(!isDefined(start)) {
      return;
    }
    explosives = [];

    explosives[explosives.size] = start;
    start.explosive_dist = 0;

    total_dist = 0;

    prev = start;
    while(isDefined(prev.target) && isDefined(getStruct(prev.target, "targetname"))) {
      next = getStruct(prev.target, "targetname");
      total_dist += Distance2d(prev.origin, next.origin);
      explosives[explosives.size] = next;
      next.explosive_dist = total_dist;
      prev = next;
    }

    explosive_time_total = 3;
    foreach(explosive in explosives) {
      time = explosive_time_total * (explosive.explosive_dist / total_dist);
      explosive delayThread(time, ::halon_system_killstreak_explode, player);
    }

    wait explosive_time_total - 1;

    if(!flag("walkway_collasped"))
      level notify("activate_walkway", player);

    level notify("activate_halon_system", player);
  }
}

halon_system_killstreak_explode(attacker) {
  visuals = [];
  if(isDefined(self.target)) {
    visuals = getEntArray(self.target, "targetname");
  }

  PlaySoundAtPos(self.origin, "barrel_mtl_explode");

  playFX(level._effect["tank_part_explode"], self.origin, anglesToForward(self.angles), AnglesToUp(self.angles));

  inflictor = visuals[0];
  if(!isDefined(inflictor))
    inflictor = attacker;
  inflictor RadiusDamage(self.origin, 400, 1200, 1000, attacker, "MOD_EXPLOSIVE", "sovereign_gas_mp");
  foreach(visual in visuals)
  visual Delete();
}

halon_system_run(killstreak_player) {
  alarm_sound_ents = getEntArray("halon_alarm_sound", "targetname");
  fan_sound_ents = getEntArray("halon_fan_sound", "targetname");

  foreach(ent in alarm_sound_ents) {
    ent playSound("halon_fire_alarm");
  }

  wait 2;

  thread exploder_with_connect_watch(1, 40);

  foreach(player in level.players) {
    player PlayLocalSound("halon_gas_amb");
  }

  halon_system_fog_on();

  wait 5;
  foreach(ent in alarm_sound_ents) {
    ent StopLoopSound();
  }

  wait 35;

  foreach(ent in fan_sound_ents) {
    ent playSound("halon_exhaust_fan");
  }

  halon_system_fog_off();

  wait level.halon_fade_out_time;
}

exploder_with_connect_watch(num, max_time) {
  exploder(num);

  s = spawnStruct();

  startTime = GetTime();
  s thread exploder_connect_watch(num, startTime);

  wait max_time;
  s notify("end_exploder_connect_watch");
}

exploder_connect_watch(num, startTime) {
  self endon("end_exploder_connect_watch");
  while(1) {
    level waittill("connected", player);

    exploder(num, player, startTime / 1000);
  }
}

halon_system_fog_on() {
  level.halon_fog_on = true;
  level.vision_set_stage = 1;
  foreach(player in level.players) {
    player VisionSetStage(level.vision_set_stage, level.halon_fade_in_time);
  }
}

halon_system_fog_off() {
  level.halon_fog_on = false;
  level.vision_set_stage = 0;
  foreach(player in level.players) {
    player VisionSetStage(level.vision_set_stage, level.halon_fade_out_time);
  }
}

halon_system_spawn_watch() {
  while(1) {
    level waittill("player_spawned", player);
    if(isDefined(level.vision_set_stage))
      player VisionSetStage(level.vision_set_stage, .1);
  }
}

bot_clear_of_gas() {
  if(!flag("walkway_collasped")) {
    if(!isDefined(level.halon_dangerzone)) {
      level.halon_dangerzone = GetEnt("halon_dangerzone", "targetname");
    }

    if(isDefined(level.halon_dangerzone)) {
      if(self IsTouching(level.halon_dangerzone))
        return false;
    }
  }

  if(!isDefined(level.explosives_dangerzone)) {
    level.explosives_dangerzone = GetEnt("explosives_dangerzone", "targetname");
  }

  if(isDefined(level.explosives_dangerzone)) {
    if(self IsTouching(level.explosives_dangerzone))
      return false;
  }

  return true;
}

halon_system_test() {
  dvar_name = "trigger_halon";
  default_value = 0;
  SetDevDvarIfUninitialized(dvar_name, default_value);
  while(1) {
    value = GetDvarInt(dvar_name, default_value);
    if(!value) {
      waitframe();
    } else {
      level notify("activate_halon_system");
      SetDvar(dvar_name, default_value);
    }
  }
}

halon_fog_only() {
  dvar_name = "trigger_halon_fog_only";
  default_value = 0;
  SetDevDvarIfUninitialized(dvar_name, default_value);

  while(1) {
    while(!GetDvarInt(dvar_name, default_value))
      waitframe();

    halon_system_fog_on();

    while(GetDvarInt(dvar_name, default_value))
      waitframe();

    halon_system_fog_off();
  }

}
# /