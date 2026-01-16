/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_2_player_f35.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\la_utility;
#include maps\_anim;

main() {
  wait_for_first_player();
  f35_setup();
  flag_wait("player_flying");
  f35_lock_to_mesh();
  onsaverestored_callback(::save_restored_function);
}

f35_scripted_functionality() {
  level.f35 thread plane_damage_states();
  flag_wait("player_in_f35");
  flag_wait("player_flying");
  clientnotify_delay("plr_in_jet", 1);
  setsaveddvar("vehPlaneTurnAssistDecayRate", "0.3");
  level.f35 thread f35_health_regen();
  level.f35 thread f35_fire_guns();
  level.f35 thread f35_enable_ads();
  level.f35 thread f35_setup_visor();
  level.f35 thread f35_collision_detection();
  level.f35 thread f35_collision_watcher();
  level.f35 thread height_mesh_threshold_low();
  level.f35 thread height_mesh_threshold_high();
  level.f35 thread flyby_feedback_watcher();
  level.f35 thread f35_interior_damage_anims();
  level.f35 thread f35_switch_modes();
  flag_wait("convoy_at_dogfight");
  setsaveddvar("vehPlaneTurnAssistDecayRate", "0.65");
  level.f35 thread death_blossom_think();
  level.f35 thread missile_incoming_watcher();
  level.f35 thread missile_impact_watcher();
  level.f35 thread _watch_for_boost();
}

material_test() {
  self endon("death");

  while(true) {
    a_trace = bullettrace(level.player get_eye(), level.player getplayerangles() * 9000, 0, self);
    str_surface_type = "NONE";

    if(isDefined(a_trace["surfacetype"]))
      str_surface_type = a_trace["surfacetype"];

    iprintln(str_surface_type);
    wait 0.25;
  }
}

f35_health_regen() {
  self.health_regen = spawnstruct();

  switch (getdifficulty()) {
    case "easy":
      self.health_regen.health_max = 4500;
      self.health_regen.time_before_regen = 6;
      self.health_regen.percent_life_at_checkpoint = 1;
      break;
    case "medium":
      self.health_regen.health_max = 4000;
      self.health_regen.time_before_regen = 7;
      self.health_regen.percent_life_at_checkpoint = 1;
      break;
    case "hard":
      self.health_regen.health_max = 3500;
      self.health_regen.time_before_regen = 8;
      self.health_regen.percent_life_at_checkpoint = 1;
      break;
    case "fu":
      self.health_regen.health_max = 3000;
      self.health_regen.time_before_regen = 9;
      self.health_regen.percent_life_at_checkpoint = 1;
      break;
  }

  self.health_regen.health = self.health_regen.health_max;
  self.overridevehicledamage = ::f35_damage_callback;
  self.health_regen.health_regen_per_frame = int(self.health_regen.health_max / self.health_regen.time_before_regen / 20);
  self thread f35_health_regen_think();
  self thread f35_health_warning_audio(self.health_regen.health_max);
}

f35_health_warning_audio(max_health) {
  self endon("death");
  last_health = "max";

  while(true) {
    self waittill_any("damage", "health_at_max");
    ratio = self.health_regen.health / max_health;

    if(ratio >= 0.7) {
      if(last_health != "max") {
        last_health = "max";
        level clientnotify("f35_h_max");
      }
    } else if(ratio >= 0.4) {
      if(last_health != "mid") {
        last_health = "mid";
        level clientnotify("f35_h_mid");
      }
    } else if(last_health != "low") {
      last_health = "low";
      level clientnotify("f35_h_low");
    }
  }
}

f35_health_regen_think() {
  self endon("death");
  self.health_regen.time_since_last_damaged = 0;
  self thread f35_health_regen_update_last_damaged_timer();
  self thread f35_health_regen_wait_for_damage();
  self thread f35_hud_damage();

  while(true) {
    if(self.health_regen.time_since_last_damaged > self.health_regen.time_before_regen)
      self thread f35_health_regen_start();

    wait 0.05;
  }
}

f35_player_damage_watcher() {
  self endon("death");
  level endon("sam_success");

  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);
    self play_fx("f35_console_blinking", undefined, undefined, "health_at_max", 1, "tag_origin");
    self notify("stop_ambient_console_lights");
    earthquake(0.25, 0.1, self.origin, 512, self);
    time = gettime();

    if(time - level.n_last_damage_time > 500) {
      if(isDefined(level.f35_hud_damage_ent)) {
        level.n_hud_damage = 1;

        if(damage > 5)
          level.f35_hud_damage_ent setclientflag(6);
        else
          level.f35_hud_damage_ent setclientflag(5);

        level.f35_hud_damage_ent clearclientflag(3);
        level.n_last_damage_time = gettime();
      }
    }
  }
}

f35_ambient_console_lights() {
  self endon("death");

  while(true) {
    self play_fx("f35_console_ambient", undefined, undefined, "stop_ambient_console_lights", 1, "tag_origin");
    self waittill("health_at_max");
  }
}

f35_hud_damage() {
  self endon("death");

  if(!isDefined(level.f35_hud_damage_ent)) {
    level.f35_hud_damage_ent = spawn("script_model", level.player.origin);
    level.f35_hud_damage_ent setmodel("tag_origin");
  }

  level.n_last_damage_time = gettime();
  self thread f35_player_damage_watcher();

  while(flag("player_flying")) {
    if(is_true(level.n_hud_damage)) {
      time = gettime();

      if(time - level.n_last_damage_time > 500) {
        if(isDefined(level.f35_hud_damage_ent)) {
          level.f35_hud_damage_ent setclientflag(3);
          level.f35_hud_damage_ent clearclientflag(5);
          level.f35_hud_damage_ent clearclientflag(6);
          level.n_hud_damage = 0;
        }
      }
    }

    wait 0.05;
  }

  if(isDefined(level.f35_hud_damage_ent)) {
    level.f35_hud_damage_ent setclientflag(3);
    level.f35_hud_damage_ent clearclientflag(5);
    level.f35_hud_damage_ent clearclientflag(6);
  }

  wait 0.05;
  level.f35_hud_damage_ent delete();
}

f35_health_regen_update_last_damaged_timer() {
  self endon("death");

  while(true) {
    self.health_regen.time_since_last_damaged = self.health_regen.time_since_last_damaged + 0.05;
    wait 0.05;
  }
}

f35_health_regen_wait_for_damage() {
  self endon("death");

  while(true) {
    self waittill("damage");
    level thread f35_hud_damage_event();
    self.health_regen.time_since_last_damaged = 0;
  }
}

f35_health_regen_start() {
  self endon("damage");
  self endon("death");
  b_health_at_full = 0;

  while(!b_health_at_full) {
    self.health_regen.health = self.health_regen.health + self.health_regen.health_regen_per_frame;

    if(self.health_regen.health > self.health_regen.health_max)
      self.health_regen.health = self.health_regen.health_max;

    if(self.health_regen.health == self.health_regen.health_max)
      b_health_at_full = 1;

    wait 0.05;
  }

  self notify("health_at_max");
}

#using_animtree("vehicles");

save_restored_function() {
  level.f35 clearanim( % root, 0);
  level.f35 _restore_f35_health();
  level.f35 _restore_f35_hud();

  if(!flag("dogfights_story_done"))
    level.player setclientdvar("cg_fov", 70);
  else
    level.player setclientdvar("cg_fov", 90);

  if(flag("roadblock_done") && !flag("player_at_convoy_end")) {
    v_to_goal = vectortoangles(level.convoy.vh_potus.origin - level.f35.origin);
    level.f35 setphysangles((0, v_to_goal[1], 0));
  }

  if(flag("dogfights_story_done")) {
    start_spot = getstruct("checkpoint_restart_spot", "targetname");
    level.f35.origin = start_spot.origin;
    level.f35 setphysangles(start_spot.angles);
  }
}

_restore_f35_hud() {
  luinotifyevent(&"hud_update_vehicle");
}

f35_lock_to_mesh() {
  level.f35 setheliheightlock(1);
}

get_player_aim_pos(n_range, e_to_ignore) {
  v_start_pos = self geteye();
  v_dir = anglestoforward(self getplayerangles());
  v_end_pos = v_start_pos + v_dir * n_range;
  v_hit_pos = v_end_pos;
  return v_hit_pos;
}

f35_fire_guns() {
  self endon("death");
  self endon("stop_f35_minigun");
  gunner_weapon_name = self seatgetweapon(1);
  n_fire_time = weaponfiretime(gunner_weapon_name);
  n_fov = getdvarfloat(#"cg_fov");
  v_offset = (0, 0, 0);
  n_radius = 32;
  n_distance_max_sq = 8000 * 8000;
  n_current_heat = 0;
  b_overheating = 0;

  while(isalive(self)) {
    b_do_damage = 0;
    v_aim_pos = level.player get_player_aim_pos(20000);
    a_axis_vehicles = getvehiclearray("axis");
    a_temp = [];
    b_has_target = 0;

    if(isDefined(self.vtol) && self.is_vtol)
      n_radius = 32;

    for(i = 0; i < a_axis_vehicles.size; i++) {
      if(target_isincircle(a_axis_vehicles[i], level.player, n_fov, n_radius))
        a_temp[a_temp.size] = a_axis_vehicles[i];
    }

    if(a_temp.size > 0) {
      if(isDefined(level.f35_lockon_target) && isinarray(a_temp, level.f35_lockon_target))
        e_target = level.f35_lockon_target;
      else
        e_target = get_closest_element(self.origin, a_temp);

      if(isDefined(e_target))
        b_has_target = 1;
    }

    if(b_has_target) {
      self setgunnertargetent(e_target, v_offset, 0);
      self setgunnertargetent(e_target, v_offset, 1);
    } else {
      self setgunnertargetvec(v_aim_pos, 0);
      self setgunnertargetvec(v_aim_pos, 1);
    }

    if(level.player attackbuttonpressed() && !b_overheating) {
      self firegunnerweapon(0);
      self firegunnerweapon(1);

      if(b_has_target) {
        n_distance_to_target = distancesquared(e_target.origin, self.origin);

        if(self _can_bullet_hit_target(self.origin, e_target))
          b_do_damage = 1;

        if(b_do_damage) {
          n_damage = f35_guns_get_damage(e_target);
          e_target dodamage(n_damage, e_target.origin, level.player, level.player, "riflebullet", "", gunner_weapon_name);
        }
      }

      n_current_heat = n_current_heat + 100 / 5 * n_fire_time;

      if(n_current_heat > 100) {
        n_current_heat = 100;
        b_overheating = 1;
      }

      luinotifyevent(&"hud_weapon_heat", 1, int(n_current_heat));
      wait(n_fire_time);
    } else {
      if(n_current_heat > 0) {
        n_current_heat = n_current_heat - 100 / 2 * 0.05;

        if(n_current_heat <= 0) {
          n_current_heat = 0;
          b_overheating = 0;
        }

        luinotifyevent(&"hud_weapon_heat", 1, int(n_current_heat));
      }

      wait 0.05;
    }
  }
}

get_closest_element(v_reference, a_elements) {
  assert(isDefined(v_reference), "v_reference is a required parameter for get_closest_element");
  assert(isDefined(a_elements), "a_elements is a required parameter for get_closest_element");
  assert(a_elements.size > 0, "get_closest_elements was passed a zero sized array");
  e_closest = a_elements[0];
  n_dist_lowest = 99999;

  for(i = 0; i < a_elements.size; i++) {
    n_dist_current = distancesquared(v_reference, a_elements[i].origin);

    if(n_dist_current < n_dist_lowest) {
      n_dist_lowest = n_dist_current;
      e_closest = a_elements[i];
    }
  }

  return e_closest;
}

f35_guns_get_damage(e_target) {
  n_distance = distance(self.origin, e_target.origin);
  n_damage = 0;

  if(is_alive(e_target)) {
    if(n_distance < 3000)
      n_damage = 125;
    else if(n_distance > 3000 && n_distance < 13000)
      n_damage = linear_map(n_distance, 3000, 13000, 100, 125);
    else if(n_distance > 13000 && n_distance < 20000)
      n_damage = linear_map(n_distance, 13000, 20000, 50, 75);
    else if(n_distance > 20000 && n_distance < 30000)
      n_damage = linear_map(n_distance, 20000, 30000, 0, 50);
    else
      n_damage = 0;
  }

  return int(n_damage);
}

f35_setup_visor() {
  if(flag("player_flying"))
    level.player visionsetnaked("helmet_f35_low", 0.5);
}

f35_remove_visor() {
  level.player clearclientflag(0);
  level.player visionsetnaked("default", 0);
}

player_boards_f35() {
  level.player startcameratween(0.5);
  level.f35 makevehicleusable();
  level.f35 useby(level.player);
  level.f35 makevehicleunusable();
  level.f35 hidepart("tag_gear");
  attach_model = spawn_model("veh_t6_air_fa38_low", (0, 0, 0), (0, 0, 0));
  attach_model setforcenocull();
  attach_model linkto(level.f35, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.player setclientdvar("cg_fov", 70);
  level.player setclientdvar("compass", 0);
  level.player setclientdvar("cg_tracerSpeed", 25000);
  level.player setclientdvar("cg_objectiveIndicatorFarFadeDist", 400000);
  level.player setclientdvar("cg_objectiveIndicatorNearFadeDist", 16);
  level.player.overrideplayerdamage = ::f35_player_damage_callback;
  setsaveddvar("waypointOffscreenPadLeft", 120);
  setsaveddvar("waypointOffscreenPadRight", 120);
  setsaveddvar("waypointOffscreenPadTop", 20);
  setsaveddvar("waypointOffscreenPadBottom", 140);
  level.f35 _f35_set_vtol_mode(1);
  level.enable_cover_warning = 0;
  luinotifyevent(&"hud_update_vehicle");
}

update_ember_fx(str_fx_name) {
  if(isDefined(self.e_temp_fx)) {
    self.e_temp_fx unlink();
    self.e_temp_fx delete();
  }

  if(isDefined(str_fx_name) && getdvarint(#"_id_13510208") != 1) {
    self.e_temp_fx = spawn("script_model", self.origin);
    self.e_temp_fx.angles = self.angles;
    self.e_temp_fx linkto(self);
    self.e_temp_fx setmodel("tag_origin");
    playfxontag(level._effect[str_fx_name], self.e_temp_fx, "tag_origin");
  }
}

f35_player_damage_callback(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(eattacker != level.f35)
    idamage = 0;

  if(self.health - idamage < 1) {
    if(self.health > 1)
      idamage = self.health - 1;
    else
      idamage = 0;
  }

  return idamage;
}

player_exits_f35() {
  setheliheightpatchenabled("air_section_height_mesh", 0);
  setheliheightpatchenabled("ground_section_height_mesh", 0);
  level clientnotify("player_turn_off_sonar");
  level.f35 setheliheightlock(0);
  level.player notify("exit_f35");
  level.player setclientdvar("compass", 1);
  level.player setclientdvar("cg_tracerSpeed", 7500);
  level.player setclientdvar("cg_objectiveIndicatorFarFadeDist", 8192);
  level.player setclientdvar("cg_objectiveIndicatorNearFadeDist", 64);
  level.player update_ember_fx();
  level.player allowmelee(1);
}

f35_setup() {
  wait_for_first_player();
  level.f35 = get_ent("F35", "targetname", 1);
  level.f35 makevehicleunusable();
  level.f35 setheliheightlock(0);
  level.f35 setvehicleavoidance(1);
  level.f35 setvehicleavoidance(1);
  level.f35 veh_toggle_tread_fx(0);
  level.f35 setup_approach_points();
  level.f35.max_speed_vtol = level.f35 getmaxspeed() / 17.6;
  level.f35.speed_plane_min = 125;
  level.f35.speed_plane_max = 350;
  level.f35 setvehicletype("plane_f35_player_vtol_fast");
  level.f35.speed_plane_max = level.f35 getmaxspeed() / 17.6;
  level.f35.speed_plane_min = 100;
  level.f35 setvehicletype("plane_f35_player_vtol");
  level.f35.speed_drone_min = 300;
  level.f35.speed_drone_max = 375;
  level.f35 ent_flag_init("playing_bink_now");
  level thread f35_scripted_functionality();
  f35_init_console();
  level.player.missile_turret_lock_lost_time = 2000;
}

missile_impact_watcher() {
  self endon("death");
  n_earthquake_scale_catastrophic = 0.6;
  n_earthquake_duration_catastrophic = 3;
  n_rumble_count_catastrophic = 5;
  n_rumble_delay_catastrophic = 0.1;
  str_rumble_catastrophic = "damage_heavy";

  while(true) {
    self waittill("missile_hit_player");
    self notify("f35_destroy_panels");
    earthquake(n_earthquake_scale_catastrophic, n_earthquake_duration_catastrophic, level.player.origin, 2000, level.player);
    level.player thread rumble_loop(n_rumble_count_catastrophic, n_rumble_delay_catastrophic, str_rumble_catastrophic);
    level.player playsound("prj_missile_impact_f35");
  }
}

missile_incoming_watcher() {
  self endon("death");
  e_harper = level.convoy.vh_van;
  e_player = level.player;

  while(true) {
    flag_wait("missile_event_started");
    n_index = randomint(4);

    if(n_index == 0)
      self thread say_dialog("missile_warning_028");
    else if(n_index == 1)
      self thread say_dialog("incoming_missile_029");
    else if(n_index == 2)
      e_harper thread say_dialog("dammit_septic__th_011");
    else
      e_harper thread say_dialog("missiles_on_your_013");

    level.player playsound("wpn_sam_warning");
    flag_waitopen("missile_event_started");
  }
}

setup_approach_points() {
  n_distance_side = 1000;
  n_distance_side_bottom_addition = 1500;
  n_distance_goal = 4500;
  n_distance_behind = -20000;
  v_origin = self.origin;
  v_angles = self.angles;
  v_forward = anglestoforward(v_angles);
  v_right = anglestoright(v_angles);
  v_up = anglestoup(v_angles);
  v_back = v_forward * -1;
  v_left = v_right * -1;
  v_down = v_up * -1;
  v_forward_scaled = v_forward * n_distance_side;
  v_right_scaled = v_right * n_distance_side;
  v_up_scaled = v_up * n_distance_side;
  v_back_scaled = v_back * n_distance_side;
  v_left_scaled = v_left * n_distance_side;
  v_down_scaled = v_down * n_distance_side;
  a_base_grid = [];
  a_base_grid["left"] = [];
  v_grid_left_top = v_origin + v_up_scaled + v_left_scaled;
  a_base_grid["left"]["top"] = v_grid_left_top;
  v_grid_center_top = v_origin + v_up_scaled;
  a_base_grid["center"]["top"] = v_grid_center_top;
  v_grid_right_top = v_origin + v_up_scaled + v_right_scaled;
  a_base_grid["right"]["top"] = v_grid_right_top;
  v_grid_left_center = v_origin + v_left_scaled;
  a_base_grid["left"]["center"] = v_grid_left_center;
  v_grid_center_center = v_origin;
  a_base_grid["center"]["center"] = v_grid_center_center;
  v_grid_right_center = v_origin + v_right_scaled;
  a_base_grid["right"]["center"] = v_grid_right_center;
  v_grid_left_bottom = v_origin + v_down_scaled + v_left_scaled + v_left * n_distance_side_bottom_addition;
  a_base_grid["left"]["bottom"] = v_grid_left_bottom;
  v_grid_center_bottom = v_origin + v_down_scaled;
  a_base_grid["center"]["bottom"] = v_grid_center_bottom;
  v_grid_right_bottom = v_origin + v_right_scaled + v_down_scaled + v_right * n_distance_side_bottom_addition;
  a_base_grid["right"]["bottom"] = v_grid_right_bottom;
  a_approach_ents = [];
  a_approach_ents["left"] = [];
  a_goal_ents = [];
  a_goal_ents["left"] = [];
  a_approach_ents_index = [];
  a_keys_row = getarraykeys(a_base_grid);
  a_keys_col = getarraykeys(a_base_grid[a_keys_row[0]]);

  for(i = 0; i < a_keys_row.size; i++) {
    for(j = 0; j < a_keys_col.size; j++) {
      v_temp_approach_point = a_base_grid[a_keys_row[i]][a_keys_col[j]] + v_forward * n_distance_behind;
      e_temp_approach = spawn("script_origin", v_temp_approach_point);
      e_temp_approach.angles = level.f35.angles;
      e_temp_approach linkto(self);
      a_approach_ents[a_keys_row[i]][a_keys_col[j]] = e_temp_approach;
      a_approach_ents_index[i + j] = e_temp_approach;
      v_temp_goal_point = a_base_grid[a_keys_row[i]][a_keys_col[j]] + v_forward * n_distance_goal;
      e_temp_goal = spawn("script_origin", v_temp_goal_point);
      e_temp_goal.angles = level.f35.angles;
      e_temp_goal linkto(self);
      a_goal_ents[a_keys_row[i]][a_keys_col[j]] = e_temp_goal;
    }
  }

  self.a_approach_ents = a_approach_ents;
  self.a_goal_ents = a_goal_ents;
  self.a_approach_ents_index = a_approach_ents_index;
  a_goal_index = [];
  a_goal_index[0] = 0;
  a_goal_index[1] = 0;
  a_goal_index[2] = 0;
  a_goal_index[3] = 0;
  a_goal_index[4] = 1;
  a_goal_index[5] = 0;
  a_goal_index[6] = 0;
  a_goal_index[7] = 0;
  a_goal_index[8] = 0;
  a_flyby_index = [];
  a_flyby_index[0] = getvehiclenode("flyby_grid_top_left", "targetname");
  a_flyby_index[1] = getvehiclenode("flyby_grid_center_top", "targetname");
  a_flyby_index[2] = getvehiclenode("flyby_grid_top_right", "targetname");
  a_flyby_index[3] = getvehiclenode("flyby_grid_left_center", "targetname");
  a_flyby_index[4] = undefined;
  a_flyby_index[5] = getvehiclenode("flyby_grid_right_center", "targetname");
  a_flyby_index[6] = getvehiclenode("flyby_grid_left_bottom", "targetname");
  a_flyby_index[7] = getvehiclenode("flyby_grid_center_bottom", "targetname");
  a_flyby_index[8] = getvehiclenode("flyby_grid_right_bottom", "targetname");
  level.f35.a_goal_index = a_goal_index;
  level.f35.a_flyby_index = a_flyby_index;
  level.f35.n_goal_ents_occupied = 0;
  level.f35.n_max_flyby_count = 8;
}

approach_point_debug() {
  a_keys_row = getarraykeys(self.a_goal_ents);
  a_keys_col = getarraykeys(self.a_goal_ents[a_keys_row[0]]);

  while(true) {
    for(i = 0; i < a_keys_row.size; i++) {
      for(j = 0; j < a_keys_col.size; j++)
        level thread draw_line_for_time(self.origin, self.a_goal_ents[a_keys_row[i]][a_keys_col[j]].origin, 1, 1, 1, 1);
    }

    wait 1;
  }

}

f35_get_available_approach_point() {
  n_max_occupants = level.f35.n_max_flyby_count;

  if(level.f35.n_goal_ents_occupied >= n_max_occupants)
    n_available_index = 20;
  else {
    a_temp = level.f35.a_goal_index;
    a_pool = [];

    for(i = 0; i < level.f35.a_goal_index.size; i++) {
      if(isDefined(a_temp[i]) && !a_temp[i])
        a_pool[a_pool.size] = i;
    }

    n_available_index = random(a_pool);
  }

  return n_available_index;
}

f35_get_approach_point(str_row, str_col) {
  e_temp = self.a_approach_ents[str_row][str_col];
  return e_temp;
}

f35_get_goal_point(str_row, str_col) {
  e_temp = level.f35.a_goal_ents[str_row][str_col];
  return e_temp;
}

height_mesh_threshold_low() {
  self endon("death");

  while(isalive(self)) {
    self waittill("veh_heightmesh_min");
    wait 0.05;
  }
}

height_mesh_threshold_high() {
  self endon("death");

  while(isalive(self)) {
    self waittill("veh_heightmesh_max");
    wait 0.05;
  }
}

f35_collision_detection() {
  self endon("death");
  level endon("eject_done");
  self endon("midair_collision");
  n_update_time = 0.25;
  n_scale_forward = 9000;

  if(!isDefined(self.is_vtol))
    self.is_vtol = 1;

  while(isalive(self)) {
    b_is_vtol = self.is_vtol;
    b_collision_imminent = 0;
    v_forward_normalized = anglestoforward(level.player getplayerangles());
    v_forward_scaled = v_forward_normalized * n_scale_forward;
    v_end_pos = self.origin + v_forward_scaled;
    a_trace = bullettrace(level.player.origin, v_end_pos, 0, self);

    if(a_trace["surfacetype"] != "none" && !isDefined(a_trace["entity"]))
      b_collision_imminent = 1;

    if(b_collision_imminent) {
    }

    self.is_collision_imminent = b_collision_imminent;
    wait(n_update_time);
  }
}

f35_collision_watcher() {
  self endon("death");
  level endon("eject_sequence_started");
  n_impact_major = 1500;
  n_impact_catastrophic = 5000;
  n_earthquake_scale_minor = 0.1;
  n_earthquake_scale_major = 0.4;
  n_earthquake_scale_catastrophic = 0.7;
  n_earthquake_duration_minor = 0.5;
  n_earthquake_duration_major = 1;
  n_earthquake_duration_catastrophic = 2;
  str_rumble_minor = "damage_light";
  str_rumble_major = "tank_damage_light_mp";
  str_rumble_catastrophic = "tank_damage_heavy_mp";
  n_rumble_count_minor = 1;
  n_rumble_count_major = 1;
  n_rumble_count_catastrophic = 1;
  n_rumble_delay_minor = 0.05;
  n_rumble_delay_major = 1;
  n_rumble_delay_catastrophic = 1;
  n_feedback_delay_minor = n_rumble_count_minor * n_rumble_delay_minor;
  n_feedback_delay_major = n_rumble_count_major * n_rumble_delay_major;
  n_feedback_delay_catastrophic = n_rumble_count_catastrophic * n_rumble_delay_catastrophic;
  self.collision_feedback_time_last = 0;
  self.collision_feedback_ready = 1;

  while(true) {
    self waittill("veh_collision", v_impact_velocity, v_normal);
    b_impact_major = _f35_collision_magnitude_test(v_impact_velocity, n_impact_major);
    b_impact_catastrophic = _f35_collision_magnitude_test(v_impact_velocity, n_impact_catastrophic);
    n_time = gettime();

    if(b_impact_major && !b_impact_catastrophic) {
      if(self.collision_feedback_ready) {
        earthquake(n_earthquake_scale_major, n_earthquake_duration_major, level.player.origin, 512, level.player);
        level.player thread rumble_loop(n_rumble_count_major, n_rumble_delay_major, str_rumble_major);
        self thread _f35_collision_feedback_watcher(n_feedback_delay_major);
        self dodamage(100, self.origin);
      }
    } else if(b_impact_catastrophic) {
      if(self.collision_feedback_ready) {
        earthquake(n_earthquake_scale_catastrophic, n_earthquake_duration_catastrophic, level.player.origin, 512, level.player);
        level.player thread rumble_loop(n_rumble_count_catastrophic, n_rumble_delay_catastrophic, str_rumble_catastrophic);
        self thread _f35_collision_feedback_watcher(n_feedback_delay_catastrophic);
        self dodamage(1000, self.origin);
      }
    } else if(self.collision_feedback_ready) {
      earthquake(n_earthquake_scale_minor, n_earthquake_duration_minor, level.player.origin, 512, level.player);
      level.player thread rumble_loop(n_rumble_count_minor, n_rumble_delay_minor, str_rumble_minor);
      self thread _f35_collision_feedback_watcher(n_feedback_delay_minor);
      self dodamage(100, self.origin);
    }
  }
}

_f35_collision_magnitude_test(v_impact_velocity, n_threshold) {
  b_passed_threshold = 0;

  for(i = 0; i < 2; i++) {
    if(abs(v_impact_velocity[i]) > n_threshold)
      b_passed_threshold = 1;
  }

  return b_passed_threshold;
}

_f35_collision_feedback_watcher(n_delay) {
  self endon("death");
  self.collision_feedback_ready = 0;
  wait(n_delay);
  self.collision_feedback_ready = 1;
}

f35_enable_ads() {
  self endon("death");
  level endon("eject_sequence_started");
  level endon("start_dogfight_event");
  n_fov_zoomed = 40;
  n_fov_normal = getdvarint(#"cg_fov");
  b_using_ads = 0;
  e_player = level.player;
  b_pressed_last_frame = 0;

  while(isalive(self)) {
    if(e_player meleebuttonpressed()) {
      b_is_vtol_mode = 1;
      b_can_toggle_ads = !b_pressed_last_frame && b_is_vtol_mode;
      n_fov = n_fov_zoomed;

      if(b_using_ads || !b_is_vtol_mode)
        n_fov = n_fov_normal;

      if(b_can_toggle_ads) {
        e_player setclientdvar("cg_fov", n_fov);
        b_using_ads = !b_using_ads;
      }

      b_pressed_last_frame = 1;
    } else
      b_pressed_last_frame = 0;

    wait 0.05;
  }
}

f35_restore_fov(default_fov) {
  self endon("death");
  level waittill("start_dogfight_event");
  n_fov = getdvarint(#"cg_fov");

  if(n_fov != default_fov)
    level.player setclientdvar("cg_fov", default_fov);
}

f35_hit_object_switch_to_vtol() {
  if(!isDefined(self.vtol_mode_collision))
    self.vtol_mode_collision = 0;

  if(self.vtol_mode_collision) {
    return;
  }
  level.f35 thread _f35_stop_from_collision();
  self.vtol_mode_collision = 1;
  self _f35_set_vtol_mode();
  level.f35 f35_wait_until_path_clear(0);
  self.vtol_mode_collision = 0;
  n_speed_current = self getspeedmph();
  n_speed_clamped = clamp(n_speed_current, level.f35.max_speed_vtol, level.f35.speed_plane_max);
  self.plane_mode_speed = n_speed_clamped;
  level.player playsound("evt_dogfight_blast");
  self _f35_set_conventional_flight_mode();
  self setspeed(self.plane_mode_speed, 150, 150);
  f35_scale_speed_to_max();
}

f35_wait_until_path_clear(b_require_push_forward) {
  n_frame_counter_collision = 0;
  n_frame_counter_collision_threshold = 20;
  n_update_time = 0.05;
  b_has_clear_path = 0;
  b_jet_mode_ready = 0;
  n_frame_counter_forward = 0;
  n_frame_counter_forward_threshold = 5;

  if(!isDefined(b_require_push_forward))
    b_require_push_forward = 1;

  while(!b_jet_mode_ready) {
    if(!self.is_collision_imminent)
      n_frame_counter_collision++;
    else
      n_frame_counter_collision = 0;

    b_has_clear_path = n_frame_counter_collision > n_frame_counter_collision_threshold;

    if(player_pressing_forward_on_throttle())
      n_frame_counter_forward++;
    else
      n_frame_counter_forward = 0;

    b_player_pushing_forward = n_frame_counter_forward > n_frame_counter_forward_threshold;

    if(!b_require_push_forward)
      b_player_pushing_forward = 1;

    if(b_has_clear_path && b_player_pushing_forward)
      b_jet_mode_ready = 1;

    wait(n_update_time);
  }
}

_f35_stop_from_collision() {
  e_temp = spawn("script_origin", self.origin);
  e_temp.angles = self.angles;
  self linkto(e_temp);
  self waittill("f35_switch_modes_now");
  self unlink();
  e_temp delete();
}

death_blossom_think() {
  self endon("death");
  self endon("stop_turret_shoot");

  if(!flag("F35_pilot_saved") || flag("trenchrun_done")) {
    return;
  }
  luinotifyevent(&"hud_f35_death_blossom");
  f35_show_console("tag_display_skybuster");
  e_player = level.player;
  self.death_blossom_active = 0;
  n_death_blossom_time_last = 0;
  n_death_blossom_cooldown = 5;
  n_death_blossom_cooldown_ms = n_death_blossom_cooldown * 1000;

  if(!isDefined(level.death_blossom_kills))
    level.death_blossom_kills = 0;

  level.player thread f35_death_blossom_watcher();
  death_blossom_cooldown_notification();

  while(isalive(self)) {
    self.death_blossom_active = 0;

    if(isDefined(e_player.missileturrettarget) && isDefined(e_player.missileturrettarget.locked_on) && e_player.missileturrettarget.locked_on && e_player secondaryoffhandbuttonpressed()) {
      n_current_time = gettime();
      b_cooldown_ok = n_current_time - n_death_blossom_time_last > n_death_blossom_cooldown_ms;

      if(b_cooldown_ok) {
        self.death_blossom_active = 1;
        n_death_blossom_time_last = n_current_time;
        self fireweapon();
        delay_thread(n_death_blossom_cooldown, ::death_blossom_cooldown_notification);
        wait 0.5;
      }
    }

    wait 0.05;
  }
}

death_blossom_cooldown_notification() {
  level.player playsound("wpn_skybuster_notify");
}

f35_death_blossom_watcher() {
  self endon("death");
  self endon("stop_turret_shoot");

  while(true) {
    self waittill("missile_fire", e_missile, str_weapon_name, e_target);

    if(str_weapon_name == "f35_missile_turret_player" && isDefined(e_target) && level.f35.death_blossom_active)
      e_missile thread f35_death_blossom(e_target);
  }
}

f35_death_blossom(target) {
  self waittill("death");
  vehicles = getvehiclearray("axis");
  excluded = [];
  excluded[0] = target;
  level.death_blossom_kills = 0;
  target thread death_blossom_track_3x();
  blossom_radius = 100000;

  if(isDefined(self) && isDefined(self.origin))
    v_origin = self.origin;
  else
    v_origin = target.origin;

  sort_vehicles = get_array_of_closest(v_origin, vehicles, excluded, 3, blossom_radius);

  for(i = 0; i < sort_vehicles.size; i++) {
    magicbullet("f35_death_blossom", self.origin, sort_vehicles[i].origin, level.player, sort_vehicles[i], (0, 0, 0));
    sort_vehicles[i] thread death_blossom_track_3x();
  }

  self delete();
}

death_blossom_track_3x() {
  level endon("fire_death_blossom");
  self waittill("death");
  level.death_blossom_kills++;

  if(level.death_blossom_kills == 3)
    level notify("skybuster_kill_3x");
}

f35_damage_callback(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  n_heavy_threshold = 100;

  if(isplayer(eattacker))
    idamage = 0;
  else if(isDefined(type) && type == "MOD_CRUSH")
    idamage = 0;
  else if(isai(eattacker)) {
    str_team = eattacker.team;

    if(str_team == "allies")
      return 0;
    else if(str_team == "axis") {
      idamage = 1;

      if(issubstr(sweapon, "rpg")) {
        level.player playsound("prj_missile_impact_f35");
        idamage = 150;
      }
    }
  } else if(eattacker == level.convoy.vh_van)
    idamage = 0;
  else if(isDefined(eattacker.classname) && eattacker.classname == "script_vehicle") {
    if(eattacker.vteam == "allies")
      idamage = 0;
    else if(sweapon == "pegasus_missile_turret_doublesize") {
      idamage = 0;

      if(flag("missile_can_damage_player")) {
        idamage = 2500;
        level.f35 notify("missile_hit_player");
      }
    } else if(eattacker.vehicletype == "drone_pegasus_fast_la2" || eattacker.vehicletype == "drone_pegasus_fast_la2_2x") {
    } else if(eattacker.vehicletype == "drone_avenger_fast_la2" || eattacker.vehicletype == "drone_avenger_fast_la2_2x" || eattacker.vehicletype == "drone_avenger") {
    } else if(eattacker.vehicletype == "civ_pickup_red_wturret_la2")
      idamage = 10;
    else {
      println("unhandled vehicle type on F35" + self.vehicletype);

    }
  } else {
    str_weapon = "UNKNOWN";

    if(isDefined(sweapon))
      str_weapon = sweapon;

    println("unhandled damage source on F35: " + eattacker.classname + " weapon = " + str_weapon);

  }

  str_rumble = "damage_light";
  n_earthquake_magnitude = 0.05;
  n_earthquake_duration = 0.3;

  if(idamage > n_heavy_threshold) {
    str_rumble = "damage_heavy";
    n_earthquake_magnitude = 0.3;
    n_earthquake_duration = 0.5;
  }

  if(idamage > 0) {
    level.player playrumbleonentity(str_rumble);
    earthquake(n_earthquake_magnitude, n_earthquake_duration, level.player.origin, 512, level.player);
    self f35_try_to_play_damage_bink();
  }

  if(!isgodmode(level.player))
    self.health_regen.health = self.health_regen.health - idamage;

  if(idamage > 0 && flag("convoy_at_dogfight"))
    idamage = 1;

  if(isDefined(level.f35_damage_shader)) {
    time = gettime();

    if(time - level.n_last_damage_time > 1000) {
      level.f35_damage_shader.alpha = 0.1;
      level.f35_damage_shader fadeovertime(0.1);
      level.n_last_damage_time = gettime();
    }
  }

  if(type == "MOD_UNKNOWN")
    level.player playsound("evt_collision_alarm");
  else if(idamage > 0 && !issubstr(sweapon, "rpg") && sweapon != "pegasus_missile_turret_doublesize")
    level.player playsound("prj_bullet_impact_f35");

  if(self.health_regen.health - idamage <= 0 || self.health - idamage <= 0) {
    if(!flag("eject_sequence_started")) {
      if(!level.sndf35_death_sound) {
        level.player playlocalsound("evt_player_death");
        level.sndf35_death_sound = 1;
      }

      if(!maps\la_utility::is_greenlight_build()) {
        playfxontag(level._effect["fa38_exp_interior"], level.f35, "tag_origin");
        missionfailed();
      }
    } else
      idamage = self.health;
  }

  idamage = 1;

  if(randomint(100) < 10)
    level.player finishplayerdamage(einflictor, level.f35, 1, idflags, type, sweapon, vpoint, vdir, "none", 0, psoffsettime);

  return idamage;
}

f35_hud_damage_event() {
  if(flag("missile_event_started")) {
    if(isDefined(level.f35_damage_shader)) {
      level.f35_damage_shader.alpha = 0.0;
      level.f35_damage_shader fadeovertime(0.5);
    }

    return;
  }

  luinotifyevent(&"hud_damage", 1, 1);

  while(true) {
    wait 0.5;
    time = gettime();

    if(time - level.n_last_damage_time > 1000) {
      if(!flag("missile_event_started"))
        luinotifyevent(&"hud_damage", 1, -1);

      if(isDefined(level.f35_damage_shader)) {
        level.f35_damage_shader.alpha = 0.0;
        level.f35_damage_shader fadeovertime(0.5);
      }

      return;
    }
  }
}

f35_scale_speed_to_max() {
  assert(isDefined(self.speed_change_per_frame), ".speed_change_per_frame is missing on F35! can't use f35_scale_speed_to_max!");
  assert(isDefined(level.f35.speed_plane_max), "level.f35.speed_plane_max is missing! can't use f35_scale_speed_to_max!");

  while(self.plane_mode_speed < level.f35.speed_plane_max) {
    f35_scale_speed_up(self.speed_change_per_frame);
    wait 0.05;
  }
}

f35_scale_speed_to_min() {
  assert(isDefined(self.speed_change_per_frame), ".speed_change_per_frame is missing on F35! can't use f35_scale_speed_to_min!");
  assert(isDefined(level.f35.speed_plane_min), "level.f35.speed_plane_min is missing! can't use f35_scale_speed_to_min!");

  while(self.plane_mode_speed > level.f35.speed_plane_min) {
    f35_scale_speed_down(self.speed_change_per_frame);
    wait 0.05;
  }
}

flyby_feedback_watcher() {
  t_flyby = get_ent("flyby_feedback_trigger", "targetname", 1);
  t_flyby enablelinkto();
  n_z_offset = t_flyby.height * 0.5;
  v_link_offset = (0, 0, n_z_offset);
  t_flyby.origin = self.origin - v_link_offset;
  t_flyby linkto(self);

  while(true) {
    t_flyby waittill("trigger", e_triggered);

    if(e_triggered != self && e_triggered.vehicleclass == "plane")
      e_triggered thread flyby_feedback(t_flyby);
  }
}

flyby_feedback(t_flyby) {
  self endon("death");

  if(!isDefined(self.flyby_feedback_active))
    self.flyby_feedback_active = 0;

  if(!self.flyby_feedback_active) {
    self.flyby_feedback_active = 1;
    n_earthquake_magnitude = 0.1;
    n_earthquake_duration = 0.6;
    str_rumble = "tank_damage_light_mp";
    n_rumble_delay = 0.5;
    n_rumble_count = 2;
    earthquake(n_earthquake_magnitude, n_earthquake_duration, level.player.origin, 512, level.player);
    level.player thread rumble_loop(n_rumble_count, n_rumble_delay, str_rumble);

    while(self istouching(t_flyby))
      wait 0.5;

    self.flyby_feedback_active = 0;
  }
}

f35_switch_modes() {
  self endon("death");
  e_player = level.player;
  n_throttle_threshold_forward = 0.7;
  n_throttle_threshold_reverse = -0.7;
  n_speed_max = level.f35.speed_plane_max;
  n_idle_to_max_time = 2.5;
  n_idle_to_max_frames = n_idle_to_max_time * 20;
  n_speed_change_per_frame = n_speed_max / n_idle_to_max_frames;
  self.speed_change_per_frame = n_speed_change_per_frame;
  n_speed_current = self getspeedmph();
  n_speed_clamped = clamp(n_speed_current, level.f35.max_speed_vtol, level.f35.speed_plane_max);
  self.plane_mode_speed = n_speed_clamped;
  flag_wait("dogfights_story_done");

  if(!flag("dogfight_done")) {
    level.player playsound("evt_dogfight_blast");
    self thread _f35_set_vtol_mode_v2();
    level.player thread f35_tutorial(0, 0, 0, 0, 1, 1);
  }

  flag_wait("dogfight_done");

  if(!flag("trenchruns_start")) {
    f35_scale_speed_to_min();
    b_player_within_range = 0;
    n_distance = 16000;
    n_distance_sq = n_distance * n_distance;

    while(!b_player_within_range) {
      n_distance_current_sq = distancesquared(level.convoy.vh_potus.origin, level.player.origin);

      if(n_distance_sq > n_distance_current_sq)
        b_player_within_range = 1;

      wait 0.1;
    }

    if(!self.is_vtol)
      self _f35_set_vtol_mode(undefined, 1);
  }
}

_f35_set_vtol_fast_mode() {
  n_airspeed_max = 300;
  n_acceleration = 150;
  n_decceleration = 150;
  n_aim_assist_distance = 100000;
  n_height_mesh_max_dist = 7000;
  n_height_mesh_min_dist = -2300;
  level.f35 thread anim_f35_mode_switch();
  level.f35 waittill("f35_switch_modes_now");
  self setvehicletype("plane_f35_player_vtol_fast");
  level.player visionsetnaked("helmet_f35", 0.5);
  setsaveddvar("vehicle_sounds_cutoff", 30000);
  level.player setclientdvar("aim_assist_min_target_distance", n_aim_assist_distance);
  self setheliheightlock(0);
  level.player setclientdvar("vehHelicopterMaxHeightLockOffset", n_height_mesh_max_dist);
  level.player setclientdvar("vehHelicopterMinHeightLockOffset", n_height_mesh_min_dist);
  self playsound("veh_vtol_disengage_c");
  self.is_vtol = 0;
  level.player update_ember_fx("embers_on_player_in_f35_plane");
}

f35_zoom_fov() {
  self endon("death");
  n_fov = getdvarfloat(#"cg_fov");

  while(n_fov < 90) {
    n_fov = n_fov + 1.25;

    if(n_fov > 90)
      n_fov = 90;

    level.player setclientdvar("cg_fov", n_fov);
    wait 0.05;
  }
}

f35_scale_speed_up(n_change, n_manual) {
  n_speed_max = level.f35.speed_plane_max;
  n_speed_current = self.plane_mode_speed;
  n_speed_new = n_speed_current + n_change;
  n_acceleration = 150;
  n_decceleration = 150;
  b_use_manual = isDefined(n_manual);

  if(b_use_manual) {
    self.plane_mode_speed = n_manual;
    self setspeed(n_manual, n_acceleration, n_decceleration);
  } else if(n_speed_new < n_speed_max) {
    self.plane_mode_speed = n_speed_new;
    self setspeed(n_speed_new, n_acceleration, n_decceleration);
  } else if(n_speed_new >= n_speed_max) {
    self.plane_mode_speed = n_speed_max;
    self setspeed(n_speed_max, n_acceleration, n_decceleration);
  }
}

f35_scale_speed_down(n_change, n_manual) {
  n_speed_current = self.plane_mode_speed;
  n_speed_new = n_speed_current - n_change;
  n_speed_min = level.f35.speed_plane_min;
  n_acceleration = 150;
  n_decceleration = 150;
  b_use_manual = isDefined(n_manual);

  if(b_use_manual) {
    self.plane_mode_speed = n_manual;
    self setspeed(n_manual, n_acceleration, n_decceleration);
  } else if(n_speed_new > n_speed_min) {
    self.plane_mode_speed = n_speed_new;
    self setspeed(n_speed_new, n_acceleration, n_decceleration);
  } else if(n_speed_new <= n_speed_min) {
    self.plane_mode_speed = n_speed_min;
    self setspeed(n_speed_min, n_acceleration, n_decceleration);
  }
}

get_throttle_position() {
  v_stick_position = self getnormalizedmovement();
  n_throttle_forward = v_stick_position[0];
  return n_throttle_forward;
}

_f35_set_conventional_flight_mode() {
  n_airspeed_max = 300;
  n_acceleration = 150;
  n_decceleration = 150;
  n_aim_assist_distance = 100000;
  n_height_mesh_max_dist = 7000;
  n_height_mesh_min_dist = -2300;
  level.f35 thread anim_f35_mode_switch();
  level.f35 waittill("f35_switch_modes_now");
  self setvehicletype("plane_f35_player");
  setsaveddvar("vehicle_sounds_cutoff", 30000);
  level.player setclientdvar("cg_fov", 90);
  level.player setclientdvar("aim_assist_min_target_distance", n_aim_assist_distance);
  self setheliheightlock(0);
  setheliheightpatchenabled("air_section_height_mesh", 1);
  setheliheightpatchenabled("ground_section_height_mesh", 0);
  self setheliheightlock(1);
  level.player setclientdvar("vehHelicopterMaxHeightLockOffset", n_height_mesh_max_dist);
  level.player setclientdvar("vehHelicopterMinHeightLockOffset", n_height_mesh_min_dist);
  self playsound("veh_vtol_disengage_c");
  self.is_vtol = 0;
  level.player update_ember_fx("embers_on_player_in_f35_plane");
}

f35_startup_console(e_player_rig) {
  if(!isDefined(level.f35.base_console))
    level.f35.base_console = "tag_display_flight";

  level.f35 showpart(level.f35.base_console);
  f35_show_console();
}

f35_init_console() {
  if(level.f35.model == "veh_t6_air_fa38") {
    level.f35 hidepart("tag_display_flight");
    level.f35 hidepart("tag_display_standby");
    level.f35 hidepart("tag_display_message");
    level.f35 hidepart("tag_display_damage");
    level.f35 hidepart("tag_display_eject");
    level.f35 hidepart("tag_display_skybuster");
    level.f35 hidepart("tag_display_malfunction");
    level.f35 hidepart("tag_display_missiles_agm");
    level.f35 hidepart("tag_display_missiles_aam");
    level.f35.base_console = "tag_display_flight";
    level.f35.current_console = undefined;
    f35_show_console("tag_display_standby");
  }
}

f35_show_console(console) {
  self endon("death");

  if(level.f35.model == "veh_t6_air_fa38") {
    if(isDefined(level.f35.current_console))
      level.f35 hidepart(level.f35.current_console);

    level.f35.current_console = console;

    if(isDefined(console)) {
      if(console == "tag_display_damage")
        level.f35 hidepart(level.f35.base_console);

      level.f35 showpart(level.f35.current_console);
    }
  }
}

f35_show_base_console() {
  level.f35 showpart(level.f35.base_console);
}

f35_try_to_play_damage_bink() {
  if(!isDefined(self.current_console) || self.current_console != "tag_display_damage")
    level.f35 thread f35_damage_bink();
}

f35_damage_bink() {
  level.player playsound("prj_bullet_impact_f35_static");
  f35_show_console("tag_display_damage");
  wait 0.4;
  f35_show_console();
  f35_show_base_console();
}

anim_f35_mode_switch() {
  level.player.body = spawn_anim_model("player_body", level.player.origin);
  level.player.body.angles = level.player.angles;
  level.player.body linkto(level.f35, "tag_driver");
  level.player.body maps\_anim::anim_single(level.player.body, "F35_mode_switch");

  if(isDefined(level.player.body))
    level.player.body delete();
}

_f35_conventional_flight_mode_throttle() {
  self endon("F35_mode_switch_vtol");
  n_mode_switch_time = 1;
  n_mode_switch_frames = n_mode_switch_time * 20;
  b_using_throttle = 0;
  n_counter = 0;

  while(!b_using_throttle) {
    if(player_pressing_forward_on_throttle())
      n_counter++;
    else
      n_counter = 0;

    if(n_counter > n_mode_switch_frames)
      b_using_throttle = 1;

    wait 0.05;
  }

  self playsound("veh_vtol_disengage_c");
  self setvehicletype("plane_f35_player");
}

player_pressing_forward_on_throttle() {
  n_threshold = 0.7;
  b_pressing_forward = 0;
  v_movement = level.player getnormalizedmovement();

  if(v_movement[0] > n_threshold)
    b_pressing_forward = 1;

  return b_pressing_forward;
}

_f35_set_vtol_mode(b_is_first_time, b_use_force_protection_vo) {
  n_airspeed_max = 120;
  n_acceleration = 200;
  n_decceleration = 200;
  n_aim_assist_distance = 100000;
  n_height_mesh_max_dist = 120;
  n_height_mesh_min_dist = -120;
  b_set_speed = 1;

  if(!isDefined(b_is_first_time))
    b_is_first_time = 0;

  if(b_is_first_time)
    b_set_speed = 0;

  if(!isDefined(b_use_force_protection_vo))
    b_use_force_protection_vo = 0;

  if(!b_is_first_time) {
    level.f35 thread anim_f35_mode_switch();
    level.f35 waittill("f35_switch_modes_now");
    level.player visionsetnaked("helmet_f35_low", 0.5);

    if(b_use_force_protection_vo)
      level.f35 thread say_dialog("switching_to_vtol_071");
    else
      self thread say_dialog("vtol_flight_mode_e_033");
  }

  self playsound("veh_vtol_engage_c");
  self setvehicletype("plane_f35_player_vtol");

  if(b_set_speed) {
    n_speed_current = self getspeedmph();
    n_speed_final = clamp(n_speed_current, 0, level.f35.max_speed_vtol);
    self.plane_mode_speed = n_speed_final;
    self setspeed(n_speed_final, n_acceleration, n_decceleration);
  }

  self setheliheightlock(0);
  setheliheightpatchenabled("air_section_height_mesh", 0);
  setheliheightpatchenabled("ground_section_height_mesh", 1);
  self setheliheightlock(1);

  if(flag("convoy_at_dogfight") && !flag("dogfight_done")) {
  }

  level.player setclientdvar("vehHelicopterMaxHeightLockOffset", n_height_mesh_max_dist);
  level.player setclientdvar("vehHelicopterMinHeightLockOffset", n_height_mesh_min_dist);
  self.is_vtol = 1;
  level.player update_ember_fx("embers_on_player_in_f35_vtol");
}

_f35_set_vtol_mode_v2() {
  level endon("dogfight_done");
  level.f35 endon("death");
  setheliheightpatchenabled("ground_section_height_mesh", 0);
  setheliheightpatchenabled("air_section_height_mesh", 1);
  self setheliheightlock(0);
  current_mode = 1;
  n_time_strafing = 0;
  level.f35.max_speed_vtol_dogfight = level.f35 getmaxspeed() / 17.6;
  level.f35 thread plane_rumble();
  level.player thread lerp_fov_overtime(1, 90);
  self clientnotify("snd_jet_start");
  current_mode = 0;
  level.player update_ember_fx("embers_on_player_in_f35_plane");
  self waittill("player_go");
  self setvehicletype("plane_f35_player_vtol_fast");
}

_f35_should_be_flying() {
  if(length(self.velocity) == 0)
    return false;

  plane_speed = vectordot(self.velocity, anglestoforward(self.angles)) / 17.6;
  plane_dot = plane_speed / length(self.velocity) * 17.6;

  if(plane_speed > 150 && plane_dot > 0.6)
    return true;

  return false;
}

_f35_flying_upwards() {
  if(!(self.angles[0] <= 180 && self.angles[0] >= 0))
    return true;

  return false;
}

_restore_f35_health() {
  if(isDefined(self.health_regen)) {
    n_health_restored = int(self.health_regen.health_max * self.health_regen.percent_life_at_checkpoint);
    self.health_regen.health = n_health_restored;
  }
}

approach_point_claim(n_index) {
  level.f35.a_goal_index[n_index] = 1;
  level.f35.n_goal_ents_occupied++;
  self thread approach_point_unclaim(n_index);
}

approach_point_unclaim(n_index) {
  self waittill_either("death", "free_approach_point");
  level.f35.a_goal_index[n_index] = 0;
  level.f35.n_goal_ents_occupied--;
}

_can_bullet_hit_target(v_start_pos, e_target) {
  assert(isDefined(v_start_pos), "v_start_pos is a required parameter for _can_bullet_hit_target");
  assert(isDefined(e_target), "e_target is a required parameter for _can_bullet_hit_target");
  v_start_current = v_start_pos;
  v_end_pos = e_target.origin;
  b_trace_done = 0;
  b_hit_target = 0;
  n_distance_to_target = distancesquared(v_start_pos, e_target.origin);

  while(!b_trace_done) {
    a_trace = bullettrace(v_start_current, v_end_pos, 0, self);
    b_hit_surface = a_trace["surfacetype"] != "none";
    b_hit_ent = isDefined(a_trace["entity"]);

    if(b_hit_surface || b_hit_ent) {
      b_trace_done = 1;

      if(b_hit_ent && e_target == a_trace["entity"])
        b_hit_target = 1;
    } else {
      v_start_current = a_trace["position"];
      n_distance_current = distancesquared(v_start_pos, v_start_current);

      if(n_distance_current >= n_distance_to_target)
        b_trace_done = 1;
    }
  }

  return b_hit_target;
}

f35_tutorial(b_show_move_prompt, b_show_hover_prompt, b_show_weapon_prompt, b_show_ads_prompt, b_show_death_blossom_prompt, b_show_speed_boost_prompt) {
  if(!isDefined(b_show_move_prompt))
    b_show_move_prompt = 1;

  if(!isDefined(b_show_hover_prompt))
    b_show_hover_prompt = 1;

  if(!isDefined(b_show_weapon_prompt))
    b_show_weapon_prompt = 1;

  if(!isDefined(b_show_ads_prompt))
    b_show_ads_prompt = 1;

  if(!isDefined(b_show_death_blossom_prompt))
    b_show_death_blossom_prompt = 0;

  if(!isDefined(b_show_speed_boost_prompt))
    b_show_speed_boost_prompt = 0;

  if(b_show_move_prompt) {
    stick_layout = getlocalprofileint("gpad_sticksConfig");

    if(stick_layout == 2 || stick_layout == 3)
      self f35_tutorial_func(&"LA_2_FLIGHT_CONTROL_MOVE_LEGACY", & "LA_2_FLIGHT_CONTROL_LOOK_LEGACY", ::f35_control_check_movement);
    else
      self f35_tutorial_func(&"LA_2_FLIGHT_CONTROL_MOVE", & "LA_2_FLIGHT_CONTROL_LOOK", ::f35_control_check_movement);
  }

  if(b_show_hover_prompt)
    self f35_tutorial_func(&"LA_2_FLIGHT_CONTROL_HOVER_UP", & "LA_2_FLIGHT_CONTROL_HOVER_DOWN", ::f35_control_check_hover);

  if(b_show_weapon_prompt)
    self f35_tutorial_func(&"LA_2_FLIGHT_CONTROL_GUN", & "LA_2_FLIGHT_CONTROL_MISSILE", ::f35_control_check_weapons);

  if(b_show_ads_prompt) {
  }

  if(b_show_speed_boost_prompt) {
    wait 2;
    self f35_tutorial_func(&"LA_2_HINT_SPEED_BOOST", undefined, ::f35_control_check_boost, undefined, -30);
  }

  if(b_show_death_blossom_prompt) {
    if(flag("F35_pilot_saved"))
      self f35_tutorial_func(&"LA_2_HINT_DEATHBLOSSOM", undefined, ::f35_control_check_deathblossom, undefined, -30);
  }

  flag_set("tutorial_done");
}

f35_tutorial_func(str_message_1, str_message_2, func_button_check, str_flag, n_offset_y) {
  if(!isDefined(n_offset_y))
    n_offset_y = -60;

  n_polling_delay = 0.05;
  n_hint_remove_delay = 2;
  n_timeout_length = 5;
  n_timeout_frames = n_timeout_length * 20;
  n_frame_counter = 0;
  b_timeout_hit = 0;
  screen_message_create(str_message_1, str_message_2, undefined, n_offset_y);

  while(!self[[func_button_check]]() && !b_timeout_hit) {
    wait(n_polling_delay);
    n_frame_counter++;

    if(n_frame_counter >= n_timeout_frames)
      b_timeout_hit = 1;
  }

  wait(n_hint_remove_delay);
  screen_message_delete();
}

f35_control_check_hover() {
  b_is_pressing_button = level.player fragbuttonpressed() || level.player secondaryoffhandbuttonpressed();
  return b_is_pressing_button;
}

f35_control_check_deathblossom() {
  b_is_pressing_button = level.player jumpbuttonpressed();
  return b_is_pressing_button;
}

f35_control_check_mode() {
  b_is_pressing_button = level.player usebuttonpressed();
  return b_is_pressing_button;
}

f35_control_check_movement() {
  n_threshold = 0.4;
  n_look_stick_strength = length(level.player getnormalizedcameramovement());
  n_move_stick_strength = length(level.player getnormalizedmovement());
  b_is_using_look = n_threshold < n_look_stick_strength;
  b_is_using_move = n_threshold < n_move_stick_strength;
  b_is_pressing_button = b_is_using_look || b_is_using_move;
  return b_is_pressing_button;
}

f35_control_check_weapons() {
  b_is_pressing_button = level.player attackbuttonpressed() || level.player throwbuttonpressed();
  return b_is_pressing_button;
}

f35_control_check_ads() {
  b_is_pressing_button = level.player meleebuttonpressed();
  return b_is_pressing_button;
}

f35_control_check_boost() {
  b_is_pressing_button = level.player sprintbuttonpressed();

  if(b_is_pressing_button)
    wait 2;

  return b_is_pressing_button;
}

#using_animtree("fxanim_props");

f35_interior_damage_anims() {
  self waittill("f35_destroy_panels");
  self useanimtree(#animtree);
  self anim_single(self, "f35_panels_break", "fxanim_props");
  n_loop_time = getanimlength( % fxanim_la_cockpit_panels_loop_anim);

  while(!flag("eject_sequence_started")) {
    self setanimknoball( % fxanim_la_cockpit_panels_loop_anim, % root, 1, n_loop_time, 1);
    wait(n_loop_time);
  }
}

_watch_for_boost() {
  self endon("death");
  self endon("no_driver");
  self.max_speed = 400;
  self.max_sprint_speed = self.max_speed * 1.5;
  self.min_sprint_speed = self.max_speed * 0.75;
  self.sprint_meter = 100;
  self.sprint_meter_max = 100;
  self.sprint_meter_min = self.sprint_meter_max * 0.25;
  self.sprint_time = 3;
  self.sprint_recover_time = 10;
  bpressingsprint = 0;
  bmeterempty = 0;
  sprint_drain_rate = 0;
  sprint_recover_rate = self.sprint_meter_max / self.sprint_recover_time;
  boost_effect_active = 0;
  notplayedboost = 1;
  self.boosting = 0;

  while(true) {
    speed = self getspeedmph();
    forward = anglestoforward(self.angles);
    bcansprint = bmeterempty == 0 && speed > self.min_sprint_speed;
    bpressingsprint = level.player sprintbuttonpressed();

    if(bcansprint && bpressingsprint) {
      self.sprint_meter = self.sprint_meter - sprint_drain_rate * 0.05;

      if(self.sprint_meter < 0) {
        self.sprint_meter = 0;
        bmeterempty = 1;
      } else {
        self setvehmaxspeed(self.max_sprint_speed);

        if(speed < self.max_sprint_speed) {
          self launchvehicle(forward * 400 * 0.05);

          if(notplayedboost) {
            self clientnotify("snd_boost_start");
            notplayedboost = 0;
          }
        }

        if(!boost_effect_active) {
          level.player update_ember_fx("boost_fx");
          boost_effect_active = 1;
        }

        level.player playrumbleonentity("damage_heavy");
        earthquake(0.15, 0.5, level.player.origin, 1000, level.player);
        self.boosting = 1;
      }
    } else {
      self.sprint_meter = self.sprint_meter + sprint_recover_rate * 0.05;

      if(bmeterempty) {
        if(self.sprint_meter > self.sprint_meter_min)
          bmeterempty = 0;
      }

      if(self.sprint_meter > self.sprint_meter_max)
        self.sprint_meter = self.sprint_meter_max;

      self setvehmaxspeed(self.max_speed);

      if(!notplayedboost) {
        self clientnotify("snd_boost_end");
        notplayedboost = 1;
      }

      if(int(speed) > self.max_speed && is_false(self.isassistedflying)) {
        self launchvehicle(forward * -200 * 0.05);
        iprintlnbold("Sprint: Slowing you down");
      }

      if(boost_effect_active) {
        level.player update_ember_fx("embers_on_player_in_f35_plane");
        boost_effect_active = 0;
      }

      self.boosting = 0;
    }

    wait 0.05;
  }
}

do_flight_feedback() {
  self endon("death");
  level endon("dogfight_done");

  while(true) {
    level.player playrumbleonentity("damage_light");
    earthquake(0.1, 0.15, level.player.origin, 1000, level.player);
    wait 0.15;
  }
}

do_very_damaged_feedback() {
  self endon("death");
  level endon("eject_sequence_started");
  vel = 0;
  max_vel = 30.0;
  spin = 0;
  spin_time = 4.0;
  self setviewclamp(level.player, 0, 0, 15, 20);

  while(true) {
    r_stick = level.player getnormalizedcameramovement();

    if(spin) {
      spin_time = spin_time - 0.05;

      if(spin_time < 2.0 && spin_time > 0.0) {
        if(r_stick[1] < 0.0)
          spin = 0;
      } else if(spin_time <= 0.0)
        spin = 0;
    } else {
      desired_vel = max_vel * r_stick[1];
      vel = difftrack(desired_vel, vel, 0.5, 0.05);
    }

    angular_vel = self getangularvelocity();
    angular_vel = (angular_vel[0], angular_vel[1] - vel, angular_vel[2]);
    self setangularvelocity(angular_vel);
    earthquake(0.1, 1, self.origin, 512);
    wait 0.05;
  }
}

plane_rumble() {
  self endon("death");
  self endon("exit_vehicle");

  while(true) {
    vr = abs(self getspeed() / self getmaxspeed());

    if(vr < 0.1) {
      level.player playrumbleonentity("pullout_small");
      wait 0.3;
    } else if(vr > 0.01 && vr < 0.8 || abs(self getsteering()) > 0.5) {
      earthquake(0.15, 0.25, self.origin, 200);
      level.player playrumbleonentity("pullout_small");
      wait 0.1;
    } else if(vr > 0.8) {
      time = randomfloatrange(0.1, 0.15);
      earthquake(0.35, time, self.origin, 200);
      level.player playrumbleonentity("pullout_small");
      wait(time);
    } else
      wait 0.1;
  }
}

plane_damage_states() {
  self endon("death");

  for(damage_state = 1; 1; damage_state++) {
    self waittill("update_plane_damage_state");
    playfxontag(level._effect["f38_console_dmg_" + damage_state], self, "tag_origin");
  }
}