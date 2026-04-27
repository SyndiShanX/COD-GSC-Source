/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\so_rooftop_contingency_code.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_specialops;
#include maps\_hud_util;
#include maps\_vehicle;

get_wave_count() {
  return level.wave_spawn_structs.size;
}

get_wave_ai_count(wave_num) {
  return level.wave_spawn_structs[wave_num].hostile_count;
}

get_wave_vehicles(wave_num) {
  return level.wave_spawn_structs[wave_num].vehicles;
}

get_vehicle_type_count(wave_num, type) {
  count = 0;

  vehicles = get_wave_vehicles(wave_num);
  foreach(vehicle in vehicles) {
    if(vehicle.type == type) {
      count++;
    }
  }

  return count;
}
uav_pickup_setup() {
  uav_pickup = GetEnt("uav_controller", "targetname");
  AssertEx(isDefined(uav_pickup), "Missing UAV controller pickup objective model in level.");

  uav_pickup Hide();

  wait_to_pickup_uav();

  thread pickup_uav_reminder();

  wait(1);

  while(1) {
    wait(2);
    uav_pickup Show();

    uav_pickup MakeUsable();
    uav_pickup SetCursorHint("HINT_NOICON");

    uav_pickup SetHintString(&"SO_ROOFTOP_CONTINGENCY_DRONE_PICKUP");
    uav_pickup waittill("trigger", player);

    uav_pickup playSound("detpack_pickup");

    level.so_uav_picked_up = true;
    level.so_uav_player = player;

    flag_set("uav_in_use");

    player maps\_remotemissile::give_remotemissile_weapon(level.remote_detonator_weapon);

    if(level.gameskill > 1 && !flag("wave_2_started") || !flag("wave_1_started")) {
      level.so_uav_player maps\_remotemissile::disable_uav(false, true);
    }

    uav_pickup MakeUnusable();
    uav_pickup Hide();

    if(!isDefined(player.already_displayed_hint)) {
      if(level.gameskill > 1 && !flag("wave_2_started")) {
        flag_wait("wave_2_started");
      } else if(!flag("wave_1_started")) {
        flag_wait("wave_1_started");
      }

      player.already_displayed_hint = 1;

      if(isDefined(player.remotemissile_actionslot)) {
        player display_hint("use_uav_" + player.remotemissile_actionslot);
      } else {
        player display_hint("use_uav_4");
      }
    }

    if(!level.UAV_pickup_respawn) {
      return;
    }

    flag_waitopen("uav_in_use");
    wait level.uav_spawn_delay;
  }
}

pickup_uav_reminder() {
  level endon("uav_in_use");

  while(1) {
    wait(RandomFloatRange(15, 20));

    if(flag("special_op_terminated")) {
      return;
    }

    radio_dialogue("so_pickup_uav_reminder");
  }
}

wait_to_pickup_uav() {
  wait_to_pickup = true;

  if(GetDvarInt("uav_now") > 0) {
    wait_to_pickup = false;
  }

  if(level.gameSkill < 2) {
    wait_to_pickup = false;
  }

  if(wait_to_pickup) {
    flag_wait("wave_wiped_out");
  } else {
    flag_wait("start_countdown");
  }
}

uav() {
  wait_to_pickup_uav();

  thread dialog_uav();

  level.uav = spawn_vehicle_from_targetname_and_drive("second_uav");

  level.uav playLoopSound("uav_engine_loop");
  level.uavRig = spawn("script_model", level.uav.origin);
  level.uavRig setModel("tag_origin");
  thread uav_rig_aiming();
}

dialog_uav() {
  radio_dialogue("cont_cmt_almostinpos");
}

uav_rig_aiming() {
  if(!isalive(level.uav)) {
    return;
  }

  if(isDefined(level.uav_is_destroyed)) {
    return;
  }

  focus_points = getEntArray("uav_focus_point", "targetname");

  level endon("uav_destroyed");
  level.uav endon("death");
  for(;;) {
    closest_focus = getClosest(level.player.origin, focus_points);
    targetPos = closest_focus.origin;
    angles = VectorToAngles(targetPos - level.uav.origin);
    level.uavRig MoveTo(level.uav.origin, 0.10, 0, 0);
    level.uavRig RotateTo(ANGLES, 0.10, 0, 0);
    wait(0.05);
  }
}
self endon("death");

self thread maps\_remotemissile::setup_remote_missile_target();
self thread unload_when_stuck();
self thread vehicle_death_paths();
self waittill("unloaded");

if(isDefined(self.has_target_shader)) {
  self.has_target_shader = undefined;
  Target_Remove(self);
}

level.remote_missile_targets = array_remove(level.remote_missile_targets, self);
}

vehicle_death_paths() {
  self endon("delete");

  self waittill("kill_badplace_forever");

  min_dist = 50 * 50;
  death_origin = self.origin;

  while(isDefined(self)) {
    if(DistanceSquared(self.origin, death_origin) > min_dist) {
      death_origin = self.origin;

      self ConnectPaths();

      while(1) {
        wait(0.05);
        if(!isDefined(self)) {
          return;
        }

        if(DistanceSquared(self.origin, death_origin) < 1) {
          break;
        }

        death_origin = self.origin;
      }

      self DisconnectPaths();
    }

    wait(0.05);
  }
}

unload_when_stuck() {
  self endon("unloaded");
  self endon("unloading");

  self endon("death");
  while(1) {
    wait(2);
    if(self Vehicle_GetSpeed() < 2) {
      self Vehicle_SetSpeed(0, 15);
      self thread maps\_vehicle::vehicle_unload();
      self notify("kill_badplace_forever");
      return;
    }
  }
}

spawn_vehicle_and_go(struct) {
  spawner = struct.ent;

  if(isDefined(struct.delay)) {
    wait(struct.delay);
  }

  if(isDefined(struct.alt_node)) {
    targetname = struct.alt_node.targetname;

    spawner.target = targetname;
  }

  vehicle = spawner spawn_vehicle();

  vehicle StartPath();

  so_debug_print("vehicle[" + spawner.targetname + "] spawned");
  vehicle waittill("unloading");
  so_debug_print("vehicle[" + spawner.targetname + "] unloading guys");
  vehicle waittill("unloaded");
  so_debug_print("vehicle[" + spawner.targetname + "] unloading complete");
}
while(1) {
  level waittill("new_wave_started");

  wait(1);

  hud_count = undefined;
  if(level.current_wave < get_wave_count()) {
    hud = so_create_hud_item(0, so_hud_ypos(), &"SPECIAL_OPS_WAVENUM", self);
    hud_count = so_create_hud_item(0, so_hud_ypos(), undefined, self);
    hud_count.alignx = "left";

    hud_count SetValue(level.current_wave);
  } else {
    hud = so_create_hud_item(0, so_hud_ypos(), &"SPECIAL_OPS_WAVEFINAL", self);
    hud.alignx = "center";
  }

  music_loop("so_rooftop_contingency_music", 291);

  flag_wait("wave_wiped_out");

  music_stop(1);

  hud thread so_remove_hud_item(true);

  if(isDefined(hud_count)) {
    hud_count thread so_remove_hud_item(true);
  }
}
}

hud_hostile_count() {
  hudelem_title = so_create_hud_item(2, so_hud_ypos(), &"SO_ROOFTOP_CONTINGENCY_HOSTILES", self);
  hudelem_count = so_create_hud_item(2, so_hud_ypos(), &"SPECIAL_OPS_DASHDASH", self);
  hudelem_count.alignx = "left";

  flag_wait("waves_start");

  max_count = level.hostile_count;

  while(!flag("challenge_success") || !flag("special_op_terminated")) {
    if(self == level.player) {
      thread so_dialog_counter_update(level.hostile_count, max_count);
    }

    curr_count = level.hostile_count;
    hudelem_count.label = "";
    hudelem_count Setvalue(level.hostile_count);

    if(curr_count <= 0) {
      hudelem_count so_remove_hud_item(true);
      hudelem_count = so_create_hud_item(2, so_hud_ypos(), &"SPECIAL_OPS_DASHDASH", self);
      hudelem_count.alignx = "left";

      hudelem_title thread so_hud_pulse_success();
      hudelem_count thread so_hud_pulse_success();
    } else if(curr_count <= 5) {
      hudelem_title thread so_hud_pulse_close();
      hudelem_count thread so_hud_pulse_close();
    }

    while(!flag("challenge_success") && (curr_count == level.hostile_count)) {
      wait(0.05);

      if(level.hostile_count > curr_count) {
        max_count = level.hostile_count;
        level.so_progress_goal_status = "none";
        hudelem_title thread so_hud_pulse_default();
        hudelem_count thread so_hud_pulse_default();
      }
    }
  }

  hudelem_count so_remove_hud_item(true);
  hudelem_count = so_create_hud_item(2, so_hud_ypos(), &"SPECIAL_OPS_DASHDASH", self);
  hudelem_count.alignx = "left";

  hudelem_title thread so_remove_hud_item();
  hudelem_count thread so_remove_hud_item();

  level notify("stop_fading_count");
}

hud_new_wave() {
  current_wave = level.current_wave + 1;

  if(current_wave > get_wave_count()) {
    return;
  }

  wave_msg = &"SO_ROOFTOP_CONTINGENCY_WAVE_STARTS";
  wave_delay = 0.75;
  if(current_wave == get_wave_count()) {
    wave_msg = &"SO_ROOFTOP_CONTINGENCY_WAVE_FINAL_STARTS";
  } else {
    if(current_wave == 2) {
      wave_msg = &"SO_ROOFTOP_CONTINGENCY_WAVE_SECOND_STARTS";
    }

    if(current_wave == 3) {
      wave_msg = &"SO_ROOFTOP_CONTINGENCY_WAVE_THIRD_STARTS";
    }

    if(current_wave == 4) {
      wave_msg = &"SO_ROOFTOP_CONTINGENCY_WAVE_FOURTH_STARTS";
    }
  }

  thread enable_countdown_timer(level.wave_delay, false, wave_msg, wave_delay);
  wait 2;
  hud_wave_splash(current_wave, level.wave_delay - 2);
}
hud_get_wave_list(wave_num) {
  list = [];

  list[0] = spawnStruct();

  if(wave_num < get_wave_count()) {
    list[0].text = &"SPECIAL_OPS_INTERMISSION_WAVENUM";
    list[0].count = wave_num;
  } else {
    list[0].text = &"SPECIAL_OPS_INTERMISSION_WAVEFINAL";
  }

  list[1] = spawnStruct();

  list[1].text = &"SO_ROOFTOP_CONTINGENCY_HOSTILES_COUNT";
  list[1].count = get_wave_ai_count(wave_num);

  index = 2;

  uaz_count = get_vehicle_type_count(wave_num, "uaz");

  list[1].count += (uaz_count * 4);

  if(uaz_count > 0) {
    if(uaz_count == 1) {
      str = &"SO_ROOFTOP_CONTINGENCY_UAZ_COUNT_SINGLE";
    } else {
      str = &"SO_ROOFTOP_CONTINGENCY_UAZ_COUNT";
    }

    list[index] = spawnStruct();
    list[index].text = str;
    list[index].count = uaz_count;
    index++;
  }

  bm21_count = get_vehicle_type_count(wave_num, "bm21");

  list[1].count += (bm21_count * 6);

  if(bm21_count > 0) {
    if(bm21_count == 1) {
      str = &"SO_ROOFTOP_CONTINGENCY_BM21_COUNT_SINGLE";
    } else {
      str = &"SO_ROOFTOP_CONTINGENCY_BM21_COUNT";
    }

    list[index] = spawnStruct();
    list[index].text = str;
    list[index].count = bm21_count;
  }

  return list;
}

hud_create_wave_splash(yLine, message) {
  hudelem = so_create_hud_item(yLine, 0, message);
  hudelem.alignX = "center";
  hudelem.horzAlign = "center";

  return hudelem;
}

hud_wave_splash(wave_num, timer) {
  hudelems = [];
  list = hud_get_wave_list(wave_num);
  for(i = 0; i < list.size; i++) {
    hudelems[i] = hud_create_wave_splash(i, list[i].text);

    if(isDefined(list[i].count)) {
      hudelems[i] SetValue(list[i].count);
    }

    hudelems[i] SetPulseFX(60, ((timer - 1) * 1000) - (i * 1000), 1000);

    wait(1);
  }

  wait(timer - (list.size * 1));

  foreach(hudelem in hudelems) {
    hudelem Destroy();
  }
}
message = "> " + msg;

if(isDefined(delay)) {
  wait delay;
  message = "+>" + message;
} else {
  message = ">>" + message;
}

if(getDvar("specialops_debug") == "1")
  IPrintLn(message);
}

distance2d_squared(pos1, pos2) {
  pos1 = (pos1[0], pos1[1], 0);
  pos2 = (pos2[0], pos2[1], 0);

  return DistanceSquared(pos1, pos2);
}