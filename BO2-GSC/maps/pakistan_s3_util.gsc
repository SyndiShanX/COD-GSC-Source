/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_s3_util.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_objectives;
#include maps\_turret;
#include maps\_vehicle;
#include maps\_scene;
#include maps\createart\pakistan_3_art;
#include maps\_vehicle_death;

is_player_in_drone() {
  if(level.player.vehicle_state == 1)
    return false;

  return true;
}

escape_setup(is_not_intro) {
  level.vh_player_soct = spawn_vehicle_from_targetname("player_soc_t");
  level.vh_player_soct.overridevehicledamage = ::player_soct_damage_override;
  level.vh_player_soct enable_turret(1);
  level.vh_player_soct set_turret_target_flags(9, 1);
  level.vh_player_soct.n_fail_speed = 29;
  level.vh_player_soct.n_intensity_min = 9;
  level.vh_player_soct thread player_soct_driving_rumble();
  level.vh_player_soct thread player_soct_monitor_tags_update();
  level.vh_player_soct thread player_soct_monitor_boost_tags_update();
  level.vh_player_soct set_turret_max_target_distance(48, 1);
  level.vh_player_soct thread player_soct_world_collision();
  level.vh_player_soct.z_target_offset_override = 40;

  if(level.player get_temp_stat(1)) {
    level.vh_player_soct setmodel("veh_t6_mil_super_soc_t");
    level.vh_player_soct.n_intensity_min = 6;
  }

  level.vh_salazar_soct = spawn_vehicle_from_targetname("salazar_soc_t");
  level.vh_salazar_soct veh_magic_bullet_shield(1);
  level.vh_salazar_soct enable_turret(1);
  level.vh_salazar_soct set_turret_target_flags(9, 1);
  level.vh_salazar_soct set_turret_max_target_distance(48, 1);
  level.vh_salazar_soct.z_target_offset_override = 40;
  level.vh_player_drone = spawn_vehicle_from_targetname("player_drone");
  level.vh_player_drone.overridevehicledamage = ::player_drone_damage_override;
  level.vh_player_drone set_turret_target_flags(9, 1);
  level.harper = init_hero("harper");
  level.harper enter_vehicle(level.vh_player_soct, "tag_gunner1");
  level.salazar = init_hero("salazar");
  level.salazar enter_vehicle(level.vh_salazar_soct, "tag_driver");
  level.salazar gun_remove();
  level.han = init_hero("han");
  level.han enter_vehicle(level.vh_salazar_soct);
  level.han gun_remove();
  luinotifyevent(&"hud_shrink_ammo", 0);
  level.player thread take_and_giveback_weapons("give_back_weapons");
  level.player.overrideplayerdamage = ::player_damage_override;
  level.player setclientdvar("phys_impact_intensity_limit", 1);
  setsaveddvar("vehicle_collision_prediction_time", 0.25);
  setsaveddvar("phys_vehicleDamageFroceScale", 0.01);

  if(isDefined(is_not_intro) && is_not_intro) {
    move_friendly_into_position();
    level.player.vehicle_state = 1;
    level.vh_player_soct useby(level.player);
    level.player clearclientflag(15);
    wait 1;
    level.vh_salazar_soct thread salazar_soct_speed_control();
    level.vh_player_drone thread player_drone_speed_control();
  }

  flag_set("section_3_started");
  level.player setclientdvar("cg_aggressiveCullRadius", 300);
}

player_soct_world_collision() {
  self endon("death");
  damage_scale = 28;

  if(isDefined(self.soct_world_collision_damage_scale))
    damage_scale = damage_scale * self.soct_world_collision_damage_scale;

  while(true) {
    self waittill("veh_collision", location, normal, intensity, type, ent);

    if(isDefined(ent))
      intensity = 0;

    if(isDefined(type) && type != "default")
      intensity = 0;

    if(isDefined(intensity) && intensity > 0) {
      damage = int(intensity * damage_scale);
      level.vh_player_soct dodamage(damage, level.vh_player_soct.origin);
    }
  }
}

player_soct_driving_rumble() {
  level endon("player_control_ends");

  while(!isDefined(level.player.vehicle_state))
    wait 0.01;

  max_speed = 70;

  while(true) {
    speed = self getspeedmph();

    if(speed > 5) {
      rval = randomint(1000);

      if(rval < 800)
        level.player playrumbleonentity("pullout_small");
      else
        level.player playrumbleonentity("anim_light");

      speed_frac = (max_speed - speed) / max_speed;
      delay = 0.5 * speed_frac;
      delay = delay + randomfloatrange(0.25, 0.6);
    } else
      delay = 0.1;

    if(delay <= 0.01)
      delay = 0.01;

    wait(delay);
  }
}

move_friendly_into_position(is_not_intro) {
  s_skipto = getstruct("skipto_" + level.skipto_point, "targetname");
  level.vh_player_soct.origin = s_skipto.origin;
  level.vh_player_soct.angles = s_skipto.angles;
  s_skipto = getstruct("skipto_" + level.skipto_point + "_salazar", "targetname");
  level.vh_salazar_soct.origin = s_skipto.origin;
  level.vh_salazar_soct.angles = s_skipto.angles;
  nd_start = getvehiclenode(level.skipto_point + "_salazar_start", "script_noteworthy");
  level.vh_salazar_soct thread go_path(nd_start);
  s_skipto = getstruct("skipto_" + level.skipto_point + "_drone", "targetname");
  level.vh_player_drone.origin = s_skipto.origin;
  level.vh_player_drone.angles = s_skipto.angles;
  nd_start = getvehiclenode(level.skipto_point + "_drone_start", "script_noteworthy");
  level.vh_player_drone thread go_path(nd_start);
}

get_player_on_soc_t() {
  s_skipto = getstruct("skipto_" + level.skipto_point, "targetname");
  self.origin = s_skipto.origin;
  self.angles = s_skipto.angles;
  self useby(level.player);
}

hide_harper(hide_him, delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  if(isDefined(level.harper)) {
    if(hide_him)
      level.harper hide();
    else
      level.harper show();
  }
}

vehicle_switch(nd_start) {
  level endon("end_vehicle_switch");
  level endon("missionfailed");
  level.player endon("death");
  level.player.vehicle_state = 0;
  wait 0.05;

  if(isDefined(level.player.viewlockedentity)) {
    if(level.player.viewlockedentity.vehicleclass == "boat") {
      level.vh_player_drone.follow_ent = level.vh_player_soct;
      level.vh_player_soct player_soct_switch_setup(nd_start);
    }

    if(level.player.viewlockedentity.vehicleclass == "helicopter") {
      level.player setclientflag(15);
      level.player.vehicle_state = 2;
      level.vh_player_soct.follow_ent = level.vh_player_drone;
      level.vh_player_soct notify("stop_turret_shoot");
    }
  }

  while(true) {
    level.player.viewlockedentity waittill("change_seat");

    if(flag("vehicle_can_switch")) {
      flag_clear("vehicle_switched");
      flag_clear("vehicle_switch_fade_in_started");

      if(isDefined(level.static_vehicle_switch_fadeout))
        screen_fade_out(0.5, "compass_static");
      else
        screen_fade_out(0.5);

      vh_current = level.player.viewlockedentity;
      vh_current useby(level.player);
      vh_current notify("switch_vehicle");
      wait 0.05;

      if(level.player.vehicle_state == 1) {
        soct_to_drone_setup(nd_start);
        level.player playsound("uin_fire_scout_transition");
      } else if(level.player.vehicle_state == 2) {
        drone_to_soct_setup(nd_start);
        level.player playsound("uin_fire_scout_transition_b");
      }

      flag_set("vehicle_switch_fade_in_started");

      if(isDefined(level.static_vehicle_switch_fadeout))
        screen_fade_in(0.25, "compass_static");
      else
        level thread vehicle_switch_fade_in();

      level.static_vehicle_switch_fadeout = undefined;
      flag_set("vehicle_switched");
    }
  }
}

vehicle_switch_fade_in() {
  if(isDefined(level.vehicle_switch_fadein_delay)) {
    wait(level.vehicle_switch_fadein_delay);
    level.vehicle_switch_fadein_delay = undefined;
  }

  screen_fade_in(0.5);
}

player_soct_switch_setup(nd_start) {
  clientnotify("enter_soct");
  level.player.vehicle_state = 1;

  if(isDefined(level.override_player_scot_node)) {
    nd_current = getvehiclenode(level.override_player_scot_node, "targetname");
    self.origin = nd_current.origin;
    self.angles = nd_current.angles;
  } else
    nd_current = isDefined(self.currentnode) ? self.currentnode : nd_start;

  self thread vehicle_paths(nd_current);
  self drivepath(nd_current, 1);
  self.driver = level.player;

  if(isDefined(level.override_player_scot_node)) {
    self launchvehicle(anglestoforward(self.angles) * 50 * 17.6);
    level.override_player_scot_node = undefined;
  }

  self notify("stop_turret_shoot");
}

drone_to_soct_setup(nd_start) {
  level.vh_player_soct hidepart("tag_gunner_turret1");
  rpc("clientscripts/pakistan_3", "take_off_oxygen_mask");
  level.vh_player_soct useby(level.player);
  level.vh_player_drone notify("remove_fx");
  level.vh_player_soct notify("remove_fx_cheap");
  level.vh_player_soct set_turret_max_target_distance(1536, 1);
  level.vh_salazar_soct set_turret_max_target_distance(2048, 1);
  wait 0.05;
  level.vh_player_drone play_fx("drone_spotlight_cheap", level.vh_player_drone gettagorigin("tag_spotlight"), level.vh_player_drone gettagangles("tag_spotlight"), "remove_fx_cheap", 1, "tag_spotlight");
  level.vh_player_soct play_fx("soct_spotlight", level.vh_player_soct gettagorigin("tag_headlights"), level.vh_player_soct gettagangles("tag_headlights"), "remove_fx", 1, "tag_headlights");
  level.vh_player_soct clearclientflag(1);
  level.vh_salazar_soct clearclientflag(1);
  level thread hide_harper(1, 0.5);
  level.vh_player_soct player_soct_switch_setup(nd_start);
  maps\createart\pakistan_3_art::soct_driving_visionset();
}

soct_to_drone_setup(nd_start) {
  level.vh_player_soct showpart("tag_gunner_turret1");
  rpc("clientscripts/pakistan_3", "put_on_oxygen_mask", 0);
  level notify("end_player_in_soct_fail");
  level.vh_player_drone clearvehgoalpos();
  level.vh_player_drone thread go_path(level.vh_player_drone get_correct_switch_node());
  level.vh_player_drone useby(level.player);
  level.vh_player_drone thread turret_shoot();
  level.player.vehicle_state = 2;
  level.player setclientflag(15);
  level.vh_player_drone thread firescout_fire_missiles();
  level.vh_player_soct attachpath(level.vh_player_soct get_vehiclenode_any_dynamic(level.vh_player_soct.currentnode.target));
  level.vh_player_soct startpath();
  level.vh_player_drone notify("remove_fx_cheap");
  level.vh_player_soct notify("remove_fx");
  level.vh_player_soct set_turret_max_target_distance(2048, 1);
  level.vh_salazar_soct set_turret_max_target_distance(2048, 1);
  wait 0.05;
  level.vh_player_drone play_fx("firescout_spotlight", level.vh_player_drone gettagorigin("tag_spotlight"), level.vh_player_drone gettagangles("tag_spotlight"), "remove_fx", 1, "tag_spotlight");
  level.vh_player_soct play_fx("soct_spotlight_cheap", level.vh_player_soct gettagorigin("tag_headlights"), level.vh_player_soct gettagangles("tag_headlights"), "remove_fx_cheap", 1, "tag_headlights");
  level.vh_player_drone thread turn_on_future_damage_overlay(0.1);
  level.vh_player_soct setclientflag(1);
  level.vh_salazar_soct setclientflag(1);
  level thread hide_harper(0, 0.5);
  level.vh_player_drone thread speed_up_drone();
}

turn_on_future_damage_overlay(delay, filter_id) {
  self endon("death");

  if(!isDefined(filter_id))
    filter_id = 3;

  wait(delay);

  while(true) {
    if(isDefined(level.player.vehicle_state)) {
      break;
    }

    wait 0.01;
  }

  if(is_player_in_drone())
    self thread maps\_vehicle_death::vehicle_damage_filter("firestorm_turret", 20, filter_id, 0);
}

salazar_soct_speed_control() {
  self endon("death");
  self endon("end_salazar_speed_control");
  self.n_speed_max = 71;

  while(true) {
    v_player_forward = anglestoforward(level.vh_player_soct.angles);
    v_salazar_pos = (self.origin[0], self.origin[1], level.vh_player_soct.origin[2]);
    n_dot_to_player = vectordot(v_player_forward, vectornormalize(v_salazar_pos - level.vh_player_soct.origin));

    if(n_dot_to_player > 0.25) {
      n_speed_new = level.vh_player_soct getspeedmph();
      n_dist = distance2d(level.vh_player_soct.origin, self.origin);

      if(n_dist > 1500)
        n_speed_new = n_speed_new - 3 * floor(n_dist / 1500);
      else if(n_dist < 512)
        n_speed_new = self.n_speed_max;

      if(n_speed_new < 0)
        n_speed_new = 0;
    } else
      n_speed_new = self.n_speed_max;

    n_speed_new = max(0, n_speed_new);

    if(isDefined(level.player_too_far_behind_salazar) && level.player_too_far_behind_salazar)
      n_speed_new = 0;

    level.salazar_soct_speed = n_speed_new;
    self setspeed(n_speed_new, 26, 12);
    wait 0.05;
  }
}

player_drone_speed_control() {
  self endon("death");

  while(true) {
    if(isDefined(level.player.viewlockedentity) && level.player.viewlockedentity == self)
      self player_in_drone();
    else
      self player_in_soct();

    wait 0.05;
  }
}

player_in_soct() {
  self endon("death");

  if(flag("player_drone_death_collision")) {
    return;
  }
  v_player_forward = anglestoforward(level.vh_player_soct.angles);
  v_heli_pos = (self.origin[0], self.origin[1], level.vh_player_soct.origin[2]);
  n_dot_to_heli = vectordot(v_player_forward, vectornormalize(v_heli_pos - level.vh_player_soct.origin));

  if(n_dot_to_heli > 0.4)
    n_speed_new = self _normal_speed_control();
  else if(n_dot_to_heli < -0.4) {
    v_heli_forward = anglestoforward(self.angles);
    n_dot_directions = vectordot(v_player_forward, v_heli_forward);

    if(n_dot_directions > 0)
      n_speed_new = 86;
    else
      n_speed_new = 0;
  } else
    n_speed_new = 86;

  n_speed_new = max(0, n_speed_new);
  self setspeed(n_speed_new, 26, 12);

  if(n_speed_new == 0)
    self _back_on_track_wait();
}

_normal_speed_control() {
  self endon("death");
  n_dist = clamp(distance2d(self.origin, level.vh_player_soct.origin), 0, 1500);
  n_dist_frac = n_dist / 1500;

  if(n_dist_frac < 0.95)
    n_speed_new = 86;
  else {
    n_dist_percent = 1 - n_dist_frac;
    n_speed_new = linear_map(n_dist_percent, 0, 1, 0, 86);
  }

  return n_speed_new;
}

_back_on_track_wait() {
  self endon("death");
  n_dot_to_player = self _drone_dot_to_player();

  for(n_dist = distance2d(self.origin, level.vh_player_soct.origin); n_dot_to_player < -0.4 && n_dist > 1500; n_dist = distance2d(self.origin, level.vh_player_soct.origin)) {
    wait 0.05;
    n_dot_to_player = self _drone_dot_to_player();
  }
}

_drone_dot_to_player() {
  self endon("death");
  v_drone_forward = anglestoforward(self.angles);
  v_heli_pos = (self.origin[0], self.origin[1], level.vh_player_soct.origin[2]);
  n_dot_to_player = vectordot(v_drone_forward, vectornormalize(level.vh_player_soct.origin - v_heli_pos));
  return n_dot_to_player;
}

player_in_drone() {
  self endon("death");
  n_soct_speed = level.vh_player_soct getspeedmph();

  if(n_soct_speed >= 0 && !flag("stop_drone_speed_control")) {
    n_dot_to_player = self _drone_dot_to_player();

    if(n_dot_to_player < 0.25) {
      n_dist = clamp(distance2d(self.origin, level.vh_player_soct.origin), 0, 1500);
      n_dist_frac = n_dist / 1500;

      if(n_dist_frac < 0.95) {
        self set_player_drone_speed(n_soct_speed, 26, 12);
        level.vh_player_soct setspeed(62, 26, 12);
      } else {
        n_dist_percent = 1 - n_dist_frac;
        n_speed_new = linear_map(n_dist_percent, 0, 1, 45, 62);
        self set_player_drone_speed(n_speed_new, 26, 12);
        level.vh_player_soct setspeed(63, 26, 12);
      }
    } else {
      self set_player_drone_speed(n_soct_speed, 26, 12);

      for(n_dist = distance2d(self.origin, level.vh_player_soct.origin); n_dist > 2305; n_dist = distance2d(self.origin, level.vh_player_soct.origin)) {
        level.vh_player_soct setspeed(3, 26, 12);
        wait 0.05;
      }

      level.vh_player_soct setspeed(62, 26, 12);
    }
  }
}

set_player_drone_speed(n_speed, n_acc, n_dec) {
  if(isDefined(level.player_drone_speed_scale))
    n_speed = n_speed * level.player_drone_speed_scale;

  self setspeed(n_speed, n_acc, n_dec);
}

watch_for_boost() {
  self endon("death");
  self endon("end_boost");
  level endon("player_control_ends");
  level.player.watch_for_boost = 1;
  self.max_speed = self getmaxspeed() / 17.6;
  self.min_sprint_speed = self.max_speed * 0.75;
  self.sprint_meter = 100;
  self.sprint_meter_max = 100;
  self.sprint_meter_min = self.sprint_meter_max * 0.25;

  if(level.player get_temp_stat(1)) {
    self.max_sprint_speed = self.max_speed * 1.16;
    self.sprint_time = 3;
    self.sprint_recover_time = 9;
  } else {
    self.max_sprint_speed = self.max_speed * 1.07;
    self.sprint_time = 1.9;
    self.sprint_recover_time = 12;
  }

  bpressingsprint = 0;
  bmeterempty = 0;
  level.player_soct_sprint_fx_active = 0;
  sprint_drain_rate = self.sprint_meter_max / self.sprint_time;
  sprint_recover_rate = self.sprint_meter_max / self.sprint_recover_time;
  boost_min_start_speed = 25;

  while(true) {
    speed = self getspeedmph();
    forward = anglestoforward(self.angles);
    bcansprint = bmeterempty == 0 && speed >= boost_min_start_speed && (isDefined(self.driver) && self.driver == level.player);
    bpressingsprint = level.player jumpbuttonpressed();

    if(bcansprint && bpressingsprint && level.player.vehicle_state == 1) {
      self.sprint_meter = self.sprint_meter - sprint_drain_rate * 0.05;

      if(self.sprint_meter < 0) {
        self.sprint_meter = 0;
        bmeterempty = 1;
      } else {
        self setvehmaxspeed(self.max_sprint_speed);

        if(speed < self.max_sprint_speed) {
          self launchvehicle(forward * 400 * 0.05);
          self playsound("veh_soct_boost");
        }

        if(!level.player_soct_sprint_fx_active) {
          self thread boost_fx_loop();
          level.player_soct_sprint_fx_active = 1;
          rpc("clientscripts/_boat_soct_ride", "set_soct_boost", 1);
          self notify("soct_boost");
          level.player shellshock("soct_boost", 1.25);
          level.player thread boost_rumble(1.5);
        }
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

      if(speed > self.max_speed)
        self launchvehicle(forward * -200 * 0.05);

      if(level.player_soct_sprint_fx_active) {
        self notify("done_boosting");
        level.player_soct_sprint_fx_active = 0;
        rpc("clientscripts/_boat_soct_ride", "set_soct_boost", 0);
      }
    }

    wait 0.05;
  }
}

boost_rumble(time_left) {
  self endon("death");
  dt = 0.2;

  while(time_left > 0) {
    self playrumbleonentity("damage_light");
    wait(dt);
    time_left = time_left - dt;
  }
}

kill_boost_if_active() {
  self notify("done_boosting");

  if(isDefined(level.player_soct_sprint_fx_active) && level.player_soct_sprint_fx_active == 1) {
    level.player_soct_sprint_fx_active = 0;
    rpc("clientscripts/_boat_soct_ride", "set_soct_boost", 0);
    self setvehmaxspeed(self.max_speed);
  }
}

boost_fx_loop() {
  self endon("death");
  self endon("done_boosting");

  while(true) {
    playfxontag(level._effect["soct_boost_fx"], self, "tag_origin");
    wait 0.2;
  }
}

speed_up_drone() {
  flag_set("stop_drone_speed_control");
  self setspeed(63, 1000, 1000);

  while(self getspeedmph() < 63 - 1)
    wait 0.05;

  flag_clear("stop_drone_speed_control");
}

enemy_soct_shoot_logic() {
  wait_network_frame();
  self enable_turret(1);
  self set_turret_target_flags(8, 1);
}

enemy_soct_must_shoot_logic(e_priority_target) {
  wait_network_frame();

  if(isDefined(e_priority_target))
    self add_turret_priority_target(e_priority_target, 1);

  self set_turret_burst_parameters(6, 6, 0, 0, 1);
  self enable_turret(1);
  self set_turret_target_flags(8, 1);
}

random_friendly_target() {
  if(randomint(2) == 0)
    vh_friendly = level.vh_player_soct;
  else if(randomint(2) == 1)
    vh_friendly = level.vh_salazar_soct;
  else
    vh_friendly = level.vh_player_soct;

  return vh_friendly;
}

friendly_drone_shoot_logic() {
  self endon("death");

  while(true) {
    if(isDefined(level.player.vehicle_state)) {
      if(level.player.vehicle_state == 2)
        self disable_turret(0);
      else if(level.player.vehicle_state == 1)
        self enable_turret(0);
    }

    wait 0.05;
  }
}

enemy_drone_setup(b_only_turret) {
  self endon("death");
  self play_fx("drone_spotlight_cheap", self gettagorigin("tag_spotlight"), self gettagangles("tag_spotlight"), "remove_fx_cheap", 1, "tag_spotlight");
  self thread set_lock_on_target(vectorscale((0, 0, -1), 32.0));
  self enable_turret(0);
  self thread drone_kill_count();

  if(!(isDefined(b_only_turret) && b_only_turret)) {
    self enable_turret(1);
    self enable_turret(2);
  }
}

enemy_soct_setup(b_consistent_shooting, e_priority_target, b_powerfull_weapons, override_max_speed_ahead) {
  self endon("death");
  self.dontfreeme = 1;
  self.overridevehicledamage = ::enemy_soct_damage_override;
  self.good_old_style_turret_tracing = 1;
  self.z_target_offset_override = 40;

  if(self.targetname != "heli_crash_soct") {
    self thread vehicle_collision_watcher();
    self thread set_lock_on_target(vectorscale((0, 0, 1), 32.0));
    self thread drone_kill_count();
    self thread enemy_soct_speed_control(override_max_speed_ahead);
    self thread add_scripted_damage_state(0.5, ::soct_damaged_fx);
  }

  if(isDefined(b_consistent_shooting) && b_consistent_shooting)
    self thread enemy_soct_must_shoot_logic(e_priority_target);
  else
    self thread enemy_soct_shoot_logic();

  if(isDefined(b_powerfull_weapons))
    self.b_powerfull_weapons = 1;

  if(isDefined(override_max_speed_ahead))
    self setspeed(override_max_speed_ahead, 100, 100);

  self thread soct_blowup_on_script_noteworthy("blowup_soct");
  self thread soct_stop_shooting_on_script_noteworthy("soct_stop_shooting");
  self thread enemy_soct_attach_wheel();
  self.dontunloadonend = 1;
  self set_turret_max_target_distance(4096, 1);
  level notify("update_enemy_soct_list");
}

enemy_soct_attach_wheel() {
  v_origin = self gettagorigin("tag_steeringwheel");
  v_angles = self gettagangles("tag_steeringwheel");
  e_wheel = spawn_model("veh_t6_mil_soc_t_steeringwheel", v_origin, v_angles);
  e_wheel linkto(self, "tag_steeringwheel");
  self.steering_wheel = e_wheel;
}

soct_blowup_on_script_noteworthy(str_noteworthy) {
  self endon("death");
  self waittill(str_noteworthy);
  self dodamage(10000, self.origin);
}

soct_stop_shooting_on_script_noteworthy(str_noteworthy) {
  self endon("death");
  self waittill(str_noteworthy);
  self set_turret_target_flags(0, 1);
  self disable_turret(1);
  self notify("terminate_all_turrets_firing");
}

enemy_soct_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  if(self.targetname == "heli_crash_soct")
    n_damage = 0;
  else if(isDefined(e_attacker.vehicletype) && e_attacker.vehicletype == "boat_soct_axis")
    n_damage = 0;
  else if(str_weapon == "boat_gun_turret")
    n_damage = int(ceil(n_damage / 6));

  return n_damage;
}

temp_magic_bullet_shield(n_seconds_to_wait) {
  self endon("death");

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    level notify("update_enemy_soct_list");
    self.dontfreeme = 1;
    self veh_magic_bullet_shield(1);
    self thread enemy_soct_shoot_logic();
    self thread vehicle_collision_watcher();
    self thread set_lock_on_target(vectorscale((0, 0, 1), 32.0));
    self thread soct_death_launch();
    self thread drone_kill_count();
    self thread enemy_soct_speed_control(undefined);
    self thread add_scripted_damage_state(0.5, ::soct_damaged_fx);
  } else
    self magic_bullet_shield();

  if(isDefined(n_seconds_to_wait))
    wait(n_seconds_to_wait);
  else if(isDefined(self.classname) && self.classname == "script_vehicle")
    self waittill("stop_magic_bullet");

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    self veh_magic_bullet_shield(0);
    self.overridevehicledamage = ::enemy_soct_damage_override;
  } else
    self stop_magic_bullet_shield();
}

enemy_respawn() {
  a_respawn_triggers = getentarray("enemy_soct_respawn", "targetname");
  array_thread(a_respawn_triggers, ::enemy_respawn_listener);
}

enemy_respawn_listener() {
  self waittill("trigger");

  while(level.player istouching(self)) {
    a_soct = getentarray("generic_enemy_soct", "script_noteworthy");
    a_soct = array_removedead(a_soct);

    if(a_soct.size < 3 && !is_lane_occupied(self.script_noteworthy)) {
      vh_soct = spawn_vehicle_from_targetname("soct_respawner");
      nd_start = getvehiclenode(self.target, "targetname");
      vh_soct thread go_path(nd_start);
      sp_driver = getent("driver_respawner", "targetname");
      ai_driver = sp_driver spawn_drone();
      ai_driver enter_vehicle(vh_soct, "tag_driver");
      sp_shooter = getent("driver_respawner", "targetname");
      ai_shooter = sp_shooter spawn_drone();
      ai_shooter enter_vehicle(vh_soct);
      vh_soct thread enemy_soct_setup();
      vh_soct thread clear_lane(self.script_noteworthy);
      level.a_lanes[self.script_noteworthy] = "occupied";
      break;
    }

    wait 0.05;
  }
}

is_lane_occupied(str_lane) {
  b_lane_occupied = 0;

  if(level.a_lanes[str_lane] == "occupied")
    b_lane_occupied = 1;

  return b_lane_occupied;
}

clear_lane(str_lane) {
  self waittill("death");
  level.a_lanes[str_lane] = "unoccupied";
}

vehicle_collision_watcher() {
  self endon("death");
  level endon("end_veh_collision_watcher");
  self.num_hits = 0;

  while(true) {
    self waittill("veh_collision", location, normal, intensity, type, ent);

    if(isDefined(intensity)) {
      if(isDefined(ent) && isDefined(ent.vehicletype)) {
        if(intensity >= level.vh_player_soct.n_intensity_min || can_player_takedown(intensity))
          self.num_hits++;

        if(self.num_hits > 0) {
          if(ent == level.vh_player_soct)
            level notify("takedown");

          self setmodel("veh_t6_mil_soc_t_dead");
          self clearvehgoalpos();
          self.dontfreeme = 1;
          level.vh_player_soct dodamage(200, level.vh_player_soct.origin);
          self launchvehicle(vectornormalize(level.vh_player_soct.velocity) * 75, location, 0, 1);
          earthquake(0.75, 1.0, self.origin, 512, level.player);
          self playsound("evt_soct_vehicle_hit");

          if(isDefined(self.impact_slows_player_scale))
            level thread vehicle_collision_slows_down_player(self.impact_slows_player_scale);

          wait 1.2;
          self thread vehicle_free();
          self dodamage(10000, location, level.player, undefined, "projectile");
        }
      } else
        wait 0.15;
    }

    wait 0.05;
  }
}

vehicle_collision_slows_down_player(mag_scale) {
  mag = -30.0;
  mag = mag * mag_scale;
  level notify("player_soct_slowdown_collision");

  for(i = 0; i < 5; i++) {
    level.vh_player_soct launchvehicle(vectornormalize(level.vh_player_soct.velocity) * -30.0);
    wait 0.01;
  }
}

can_player_takedown(n_intensity) {
  can_takedown = 0;

  if(level.player sprintbuttonpressed())
    can_takedown = 1;

  return can_takedown;
}

vehicle_free() {
  wait 3;

  if(isDefined(self))
    self.dontfreeme = 0;
}

drone_kill_count() {
  self waittill("death", e_attacker, damagefromunderneath, weaponname, point, dir);

  if(isDefined(e_attacker) && e_attacker == level.player) {
    if(level.player.vehicle_state == 2) {
      if(isDefined(weaponname) && weaponname == "firescout_missile_turret") {
        if(!isDefined(level.num_drone_missile_kills))
          level.num_drone_missile_kills = 1;
        else
          level.num_drone_missile_kills++;
      }

      level notify("player_drone_vehicle_kill");
    }
  }
}

set_lock_on_target(v_offset) {
  if(isDefined(v_offset))
    target_set(self, v_offset);
  else
    target_set(self);

  self waittill_either("death", "end_lock_on");

  if(isDefined(self)) {
    if(target_istarget(self))
      target_remove(self);
  }
}

soct_death_launch() {
  self endon("soct_player_collision");
  self waittill("death", attacker, damagefromunderneath, weaponname, point, dir);

  if(isDefined(attacker)) {
    self.dontfreeme = 1;
    self getoffpath();
    self launchvehicle(vectornormalize(self.velocity) * 100 + vectorscale((0, 0, 1), 50.0), point, 0, 1);
    self playsound("evt_enemy_soct_flip");
    wait 1.5;
    self.dontfreeme = 0;
  }
}

firescout_fire_missiles() {
  self endon("death");
  self endon("stop_firescout_missiles");
  self endon("exit_vehicle");
  n_fire_time = 0.8;
  n_fire_count_down = 0;
  n_fov = getdvarfloat(#"cg_fov");
  v_offset = (0, 0, 0);
  n_radius = 20;
  n_distance_max_sq = 8000 * 8000;
  missiles_fired = 0;
  hud_fire_wait_scale = 0.4;

  while(isalive(self)) {
    if(isDefined(level.player.missileturrettarget)) {
      self setgunnertargetent(level.player.missileturrettarget, (0, 0, 0), 0);
      self setgunnertargetent(level.player.missileturrettarget, (0, 0, 0), 1);
    } else {
      v_aim_pos = self get_player_aim_pos(20000);
      self setgunnertargetvec(v_aim_pos, 0);
      self setgunnertargetvec(v_aim_pos, 1);
    }

    if(level.player throwbuttonpressed() && n_fire_count_down <= 0) {
      self firegunnerweapon(0);
      self firegunnerweapon(1);
      luinotifyevent(&"hud_gunner_missile_fire", 2, 1, int(n_fire_time * hud_fire_wait_scale * 1000));
      missiles_fired = 1;
      n_fire_count_down = n_fire_time;
    }

    wait 0.05;

    if(missiles_fired) {
      while(level.player throwbuttonpressed())
        wait 0.05;

      missiles_fired = 0;
    }

    n_fire_count_down = n_fire_count_down - 0.15;
  }
}

get_player_aim_pos(n_range, e_to_ignore) {
  v_start_pos = level.player geteye();
  v_dir = anglestoforward(self gettagangles("tag_flash"));
  v_end_pos = v_start_pos + v_dir * n_range;
  v_hit_pos = v_end_pos;
  return v_hit_pos;
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

run_over() {
  self endon("death");
  self.overrideactordamage = ::run_over_override;
  self shoot_at_target_untill_dead(level.player);
}

run_over_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(str_means_of_death == "MOD_CRUSH") {
    if(!isDefined(self.alreadylaunched)) {
      level.player playsound("evt_soct_ai_hit");
      self.alreadylaunched = 1;
      self startragdoll(1);
      v_launch = vectorscale((0, 0, 1), 100.0);
      v_up = (0, 0, 1);
      v_dir = anglestoforward(e_inflictor.angles);
      dp = vectordot(v_up, v_dir);

      if(dp < 0) {
        rval = randomfloatrange(3, 20);
        x_val = randomfloatrange(-0.35, 0.35);
        v_up = (x_val, 0, 1) * rval;
      } else
        v_up = undefined;

      if(randomint(100) < 40)
        v_launch = v_launch + anglestoforward(e_inflictor.angles) * 300;

      if(isDefined(v_up))
        v_launch = v_launch + v_up;

      self launchragdoll(v_launch, "J_SpineUpper");
    }
  }

  return n_damage;
}

heli_shoot_logic(b_hind) {
  self endon("death");
  self.can_shoot = 0;
  self thread _can_heli_shoot();

  while(true) {
    if(self.can_shoot) {
      if(isDefined(b_hind) && b_hind)
        self fireweapon(level.vh_salazar_soct);
      else
        self fire_turret(0);
    }

    wait 0.05;
  }
}

_can_heli_shoot() {
  self endon("death");

  while(true) {
    self waittill("shoot");
    self.can_shoot = 1;
    self waittill("stop_shooting");
    self.can_shoot = 0;
  }
}

lerp_vehicle_speed(n_current_speed, n_goal_speed, n_time, b_set_max_speed) {
  self endon("death");
  s_timer = new_timer();
  n_speed = n_current_speed;

  if(n_speed < 0) {
    n_speed = abs(n_speed);
    return;
  }

  do {
    wait 0.05;
    n_current_time = s_timer get_time_in_seconds();
    n_speed = lerpfloat(n_current_speed, n_goal_speed, n_current_time / n_time);

    if(isDefined(b_set_max_speed) && b_set_max_speed) {
      self setvehmaxspeed(n_speed);
      continue;
    }

    self setspeed(n_speed, 1000);
  }
  while(n_speed != n_goal_speed);
}

enemy_clean_up(n_lowest_unit, n_origin_index, b_less_than, b_clean_vehicles) {
  a_enemies = getaiarray("axis");

  foreach(ai_enemy in a_enemies) {
    if(isDefined(b_less_than) && b_less_than) {
      if(ai_enemy.origin[n_origin_index] < n_lowest_unit)
        ai_enemy delete();

      continue;
    }

    if(ai_enemy.origin[n_origin_index] > n_lowest_unit)
      ai_enemy delete();
  }

  if(isDefined(b_clean_vehicles) && b_clean_vehicles) {
    a_vehicles = getvehiclearray("axis");

    foreach(vh_enemy in a_vehicles) {
      if(isDefined(b_less_than) && b_less_than) {
        if(vh_enemy.origin[n_origin_index] < n_lowest_unit) {
          if(!(isDefined(vh_enemy.crashing) && vh_enemy.crashing))
            pak3_kill_vehicle(vh_enemy);
        }

        continue;
      }

      if(vh_enemy.origin[n_origin_index] > n_lowest_unit) {
        if(!(isDefined(vh_enemy.crashing) && vh_enemy.crashing))
          pak3_kill_vehicle(vh_enemy);
      }
    }
  }
}

hide_player_hud() {
  if(!isDefined(self.is_hud_hidden) || isDefined(self.is_hud_hidden) && !self.is_hud_hidden) {
    self setclientdvars("cg_drawfriendlynames", 0);
    self setclientuivisibilityflag("hud_visible", 0);
    self.is_hud_hidden = 1;
  }
}

show_player_hud() {
  if(isDefined(self.is_hud_hidden) && self.is_hud_hidden) {
    self setclientdvars("cg_drawfriendlynames", 1);
    self setclientuivisibilityflag("hud_visible", 1);
    self.is_hud_hidden = 0;
  }
}

get_correct_switch_node() {
  if(isDefined(level.switchto_drone_override_node)) {
    nd_current = getvehiclenode(level.switchto_drone_override_node, "targetname");
    level.switchto_drone_override_node = undefined;
    return nd_current;
  }

  if(isDefined(self.nd_previous_x3))
    return self.nd_previous_x3;

  if(isDefined(self.nd_previous_x2))
    return self.nd_previous_x2;

  if(isDefined(self.nd_previous))
    return self.nd_previous;

  return self.currentnode;
}

store_previous_veh_nodes() {
  self endon("death");

  while(true) {
    self waittill("reached_node", currentpoint);
    self.nd_previous_x3 = self.nd_previous_x2;
    self.nd_previous_x2 = self.nd_previous;
    self.nd_previous = self.currentnode;
  }
}

apache_setup() {
  self endon("death");
  level.vh_apache = self;
  self veh_magic_bullet_shield(1);
  self play_fx("apache_spotlight_cheap", self gettagorigin("tag_barrel"), self gettagangles("tag_barrel"), undefined, 1, "tag_barrel");
  self thread heli_shoot_logic();
}

purple_smoke() {
  s_purple_smoke = getstruct("purple_smoke", "targetname");
  play_fx("fx_pak_smk_signal_dist", s_purple_smoke.origin, s_purple_smoke.angles);
}

rubberband_potential_soct() {
  self endon("death");
  self.vh_target_current = undefined;
  level thread generate_potential_enemy_soct_list();

  while(true) {
    if(level.player.vehicle_state == 1) {
      if(isDefined(level.a_socts_to_ram)) {
        a_potential_soct_to_ram = undefined;
        a_soct_behind_the_player = undefined;

        foreach(vh_enemy in level.a_socts_to_ram) {
          if(isDefined(vh_enemy)) {
            if(vh_enemy is_soct_in_front_of_player() && is_player_looking_at_soct(vh_enemy)) {
              a_potential_soct_to_ram = add_to_array(a_potential_soct_to_ram, vh_enemy, 0);
              continue;
            }

            if(vh_enemy is_soct_behind_the_player()) {
              a_soct_behind_the_player = add_to_array(a_soct_behind_the_player, vh_enemy, 0);
              continue;
            }

            vh_enemy resumespeed(26);
          }
        }

        if(isDefined(a_potential_soct_to_ram))
          self thread soct_in_front_of_player_logic(a_potential_soct_to_ram);

        if(isDefined(a_soct_behind_the_player))
          self thread soct_behind_the_player_logic(a_soct_behind_the_player);
      }
    }

    wait 0.05;
  }
}

soct_in_front_of_player_logic(a_potential_soct_to_ram) {
  vh_soct_to_bump = getclosest(level.player.origin, a_potential_soct_to_ram);

  if(!isDefined(self.vh_target_current) || vh_soct_to_bump != self.vh_target_current) {
    if(!is_soct_dead(self.vh_target_current)) {
      self.vh_target_current resumespeed(26);
      self.vh_target_current clear_turret_target_ent_array(1);
    }

    self.vh_target_current = vh_soct_to_bump;
    vh_soct_to_bump setspeed(55);
    vh_soct_to_bump add_turret_priority_target(level.player, 1);
  }
}

soct_behind_the_player_logic(a_soct_behind_the_player) {
  foreach(vh_enemy in a_soct_behind_the_player) {
    if(isalive(vh_enemy)) {
      if(level.player can_intersect_player(vh_enemy)) {
        vh_enemy setspeed(1);
        continue;
      }

      vh_enemy setspeed(111);
    }
  }
}

can_intersect_player(vh_enemy) {
  n_player_start = self.origin - anglestoforward(self.angles) * 2048;
  n_player_end = self.origin + anglestoforward(self.angles) * 2048;
  n_enemy_start = vh_enemy.origin - anglestoforward(vh_enemy.angles) * 2048;
  n_enemy_end = vh_enemy.origin + anglestoforward(vh_enemy.angles) * 2048;
  n_denominator = (n_enemy_end[1] - n_enemy_start[1]) * (n_player_end[0] - n_player_start[0]) - (n_enemy_end[0] - n_enemy_start[0]) * (n_player_end[1] - n_player_start[1]);

  if(n_denominator != 0) {
    n_player_numerator = (n_enemy_end[0] - n_enemy_start[0]) * (n_player_start[1] - n_enemy_start[1]) - (n_enemy_end[1] - n_enemy_start[1]) * (n_player_start[0] - n_enemy_start[0]);
    n_player_t = n_player_numerator / n_denominator;
    n_enemy_numerator = (n_player_end[0] - n_player_start[0]) * (n_player_start[1] - n_enemy_start[1]) - (n_player_end[1] - n_player_start[1]) * (n_player_start[0] - n_enemy_start[0]);
    n_enemy_t = n_enemy_numerator / n_denominator;

    if(0 <= n_player_t && n_player_t <= 1 && 0 <= n_enemy_t && n_enemy_t <= 1)
      return true;
  }

  return false;
}

is_soct_in_front_of_player() {
  v_player_forward = anglestoforward(level.player.angles);
  v_enemy_pos = (self.origin[0], self.origin[1], level.player.origin[2]);
  n_dot_to_player = vectordot(v_player_forward, vectornormalize(v_enemy_pos - level.player.origin));

  if(n_dot_to_player > 0.15)
    return true;

  return false;
}

is_soct_behind_the_player() {
  v_player_forward = anglestoforward(level.player.angles);
  v_enemy_pos = (self.origin[0], self.origin[1], level.player.origin[2]);
  n_dot_to_player = vectordot(v_player_forward, vectornormalize(v_enemy_pos - level.player.origin));

  if(n_dot_to_player < 0)
    return true;

  return false;
}

is_player_looking_at_soct(vh_soct) {
  v_eye = level.player get_eye();
  v_origin = vh_soct.origin + vectorscale((0, 0, 1), 32.0);
  v_delta = anglestoforward(vectortoangles(v_origin - v_eye));
  v_view = anglestoforward(level.player getplayerangles());
  n_dot = vectordot(v_delta, v_view);

  if(n_dot >= 0.95) {
    a_bullet_trace_info = bullettrace(v_eye, v_origin, 0, level.vh_player_soct, 1, 1);

    if(isDefined(a_bullet_trace_info["entity"]) && vh_soct == a_bullet_trace_info["entity"])
      return true;
  }

  return false;
}

generate_potential_enemy_soct_list() {
  while(true) {
    level waittill_notify_or_timeout("update_enemy_soct_list", 0.15);
    a_enemy_vehicles = getvehiclearray("axis");
    a_enemy_socts = undefined;

    foreach(vh_enemy in a_enemy_vehicles) {
      if(vh_enemy.vehicletype == "boat_soct_axis" && !is_soct_dead(vh_enemy)) {
        if(isDefined(vh_enemy.targetname) && vh_enemy.targetname != "heli_crash_soct" && vh_enemy.targetname != "hwy_soct_3")
          a_enemy_socts = add_to_array(a_enemy_socts, vh_enemy, 0);
      }
    }

    level.a_socts_to_ram = a_enemy_socts;
    a_enemy_vehicles = undefined;
    a_enemy_socts = undefined;
  }
}

is_soct_dead(vh_soct) {
  if(!isDefined(vh_soct) || vh_soct.model == "veh_t6_mil_soc_t_dead")
    return true;

  return false;
}

enemy_soct_speed_control(override_max_speed_ahead) {
  self endon("death");
  self endon("kill_enemy_scot_speed_control");
  self.n_speed_max = self getmaxspeed() / 17.6;
  speed_dec = randomfloatrange(0, 16);
  self.n_speed_max = self.n_speed_max - speed_dec;
  self.start_time = gettime();
  start_slowing_soct_time = 10;
  distance_ahead_start_slowing = 600;
  distance_ahead_stop_slowing = 300;

  if(!isDefined(self.player_rammed_time_delay))
    self.player_rammed_time_delay = 4.0;

  last_player_rammed_time = 0;
  self.wait_for_the_player_speed = undefined;
  self.slowing_down_speed = undefined;

  while(true) {
    time = gettime();

    if(level.player.vehicle_state != 2) {
      dist = distance(level.player.origin, self.origin);
      v_dir = vectornormalize(level.player.origin - self.origin);
      v_forward = anglestoforward(self.angles);
      dp = vectordot(v_dir, v_forward);
    }

    if(isDefined(level.salazar_soct_speed) && level.salazar_soct_speed < 10) {
      alive_time = (time - self.start_time) / 1000;

      if(alive_time > 5) {
        self.wait_for_the_player_speed = level.salazar_soct_speed;
      }
    } else if(isDefined(self.wait_for_the_player_speed)) {
      self.wait_for_the_player_speed = undefined;

    }

    if(level.player.vehicle_state != 2) {
      dt = (time - self.start_time) / 1000;

      if(dt > start_slowing_soct_time) {
        if(dist > distance_ahead_start_slowing && dp < 0) {
          if(!isDefined(self.slowing_down_speed)) {
            self.slowing_down_speed = randomfloatrange(20, 35);

          }
        } else if(isDefined(self.slowing_down_speed)) {
          if(dist < distance_ahead_stop_slowing || dp > 0) {
            self.slowing_down_speed = undefined;
          }
        }
      }
    }

    if(level.player.vehicle_state != 2) {
      dt = (time - last_player_rammed_time) / 1000;

      if(dt > self.player_rammed_time_delay) {
        his_speed = self getspeedmph();

        if(his_speed > 15) {
          if(dist < 336) {
            if(dp > 0.22) {
              level thread npc_soct_rams_player_soct(level.vh_player_soct);
              last_player_rammed_time = time;

            }
          }
        }
      }
    }

    if(level.player.vehicle_state == 2 || isDefined(override_max_speed_ahead)) {
      v_player_forward = anglestoforward(level.player.angles);
      v_enemy_pos = (self.origin[0], self.origin[1], level.player.origin[2]);
      n_dot_to_player = vectordot(v_player_forward, vectornormalize(v_enemy_pos - level.player.origin));

      if(isDefined(self.wait_for_the_player_speed))
        n_speed_new = self.wait_for_the_player_speed;
      else if(isDefined(self.slowing_down_speed))
        n_speed_new = self.slowing_down_speed;
      else if(n_dot_to_player < 0.14) {
        n_speed_new = 83;
        self setspeedimmediate(n_speed_new, 26, 12);
      } else if(isDefined(override_max_speed_ahead))
        n_speed_new = override_max_speed_ahead;
      else
        n_speed_new = self.n_speed_max;

      self setspeed(n_speed_new, 26, 12);
    }

    wait 0.05;
  }
}

npc_soct_rams_player_soct(player_soct) {
  player_soct endon("death");
  self endon("death");
  power = 0.65;
  time = 0.8;
  earthquake(power, time, level.player.origin, 1500);
  player_soct dodamage(700, player_soct.origin);
  up = (0, 0, 1);

  for(i = 0; i < 3; i++) {
    level.player playrumbleonentity("damage_heavy");
    level.player playsound("exp_veh_large");
    player_soct launchvehicle(vectornormalize(player_soct.velocity) * 30.0);
    player_soct launchvehicle(up * 100.0);
    wait 0.1;
  }
}

soct_damaged_fx() {
  self endon("death");
  self play_fx("soct_damaged", undefined, undefined, -1, 1, "body_animate_jnt");
}

add_scripted_damage_state(n_percentage_to_change_state, func_on_state_change) {
  assert(isDefined(n_percentage_to_change_state), "n_percentage_to_change_state is a required argument for add_scripted_damage_state!");
  assert(n_percentage_to_change_state > 0 && n_percentage_to_change_state < 1, "add_scripted_damage_state was passed an invalue percentage to change state. Passed " + n_percentage_to_change_state + ", but valid range is between 0 and 1.");
  assert(isDefined(func_on_state_change), "func_on_state_change is a required argument for add_scripted_damage_state!");
  assert(isDefined(self.health) || isDefined(self.armor), "no .health or .armor parameter found on entitiy" + self getentitynumber() + " at position " + self.origin);
  b_use_custom_health = isDefined(self.armor);
  n_health_max = self.health;

  if(b_use_custom_health)
    n_health_max = self.armor;

  b_state_changed = 0;
  n_damage_to_change_state = n_health_max * n_percentage_to_change_state;

  while(!b_state_changed) {
    self waittill("damage", n_damage);
    n_current_health = self.health;

    if(b_use_custom_health)
      n_current_health = self.armor;

    if(n_current_health < n_damage_to_change_state)
      b_state_changed = 1;
  }

  self[[func_on_state_change]]();
}

waittill_vo_done() {
  while(true) {
    if(isDefined(level.harper.is_talking) && level.harper.is_talking)
      wait 0.01;
    else if(isDefined(level.disable_harper_background_vo))
      wait 0.01;
    else
      break;
  }
}

general_ram_vo() {
  level endon("escape_bosses_started");
  n_dist_max_sq = 456976;
  n_array_counter = 0;
  a_ram_vo = array("harp_ram_them_0", "harp_do_it_man_0", "harp_hit_em_again_0");

  while(true) {
    if(level.player.vehicle_state == 1) {
      if(isDefined(self.vh_target_current) && !is_soct_dead(self.vh_target_current)) {
        if(distance2dsquared(self.vh_target_current.origin, self.origin) < n_dist_max_sq) {
          waittill_vo_done();
          level.harper say_dialog(a_ram_vo[n_array_counter]);
          n_array_counter++;

          if(n_array_counter == a_ram_vo.size) {
            a_ram_vo = random_shuffle(a_ram_vo);
            n_array_counter = 0;
          }

          wait 9;
        }
      }
    }

    wait 0.05;
  }
}

general_help_vo() {
  level endon("slanted_building_started");
  n_array_counter = 0;
  a_help_vo = array("harp_they_re_right_on_us_2", "harp_they_re_closing_fast_0", "harp_gotta_shake_em_sec_0", "harp_one_thing_at_a_time_0", "harp_they_re_all_over_us_0", "harp_eyes_on_the_road_0");

  while(true) {
    n_veh_near_counter = 0;
    a_enemy_vehicles = getvehiclearray("axis");

    foreach(vh_enemy in a_enemy_vehicles) {
      if(distance2dsquared(level.vh_player_soct.origin, vh_enemy.origin) < 262144)
        n_veh_near_counter++;
    }

    if(n_veh_near_counter > 1) {
      waittill_vo_done();

      if(a_help_vo[n_array_counter] == "harp_eyes_on_the_road_0" && level.player.vehicle_state == 2)
        level.harper say_dialog(a_help_vo[n_array_counter]);
      else
        level.harper say_dialog(a_help_vo[n_array_counter]);

      n_array_counter++;

      if(n_array_counter == a_help_vo.size) {
        a_help_vo = random_shuffle(a_help_vo);
        n_array_counter = 0;
      }

      wait 9;
    }

    wait 0.05;
  }
}

general_congrats_vo() {
  level endon("escape_bosses_started");
  n_array_counter = 0;
  a_congrats_vo = array("harp_oh_yeah_0", "harp_that_s_it_0", "harp_way_to_fucking_go_0");

  while(true) {
    level waittill("takedown");
    waittill_vo_done();
    level.harper say_dialog(a_congrats_vo[n_array_counter]);
    n_array_counter++;

    if(n_array_counter == a_congrats_vo.size) {
      a_congrats_vo = random_shuffle(a_congrats_vo);
      n_array_counter = 0;
    }

    wait 0.05;
  }
}

random_shuffle(a_items) {
  b_done_shuffling = undefined;
  item = a_items[a_items.size - 1];

  while(!(isDefined(b_done_shuffling) && b_done_shuffling)) {
    a_items = array_randomize(a_items);

    if(a_items[0] != item)
      b_done_shuffling = 1;

    wait 0.05;
  }

  return a_items;
}

print_speed_in_mph() {
  self endon("death");

  while(true) {
    iprintlnbold(self getspeedmph());
    wait 0.05;
  }
}

print_number_respawners() {
  while(true) {
    a_soct = getentarray("generic_enemy_soct", "script_noteworthy");
    a_soct = array_removedead(a_soct);
    iprintlnbold(a_soct.size);
    wait 0.05;
  }
}

checkpoint_save_restored() {
  if(isDefined(level.player.vehicle_state) && level.player.vehicle_state == 1) {
    nd_start = level.vh_player_soct get_restored_checkpoint_start_node();
    level.vh_player_soct.origin = nd_start.origin;
    level.vh_player_soct thread wait_restore_player_soct(nd_start);
    nd_start = level.vh_salazar_soct get_restored_checkpoint_start_node();
    level.vh_salazar_soct.origin = nd_start.origin;
    level.vh_salazar_soct thread wait_restore_salazar_soct(nd_start);
    level.n_distance_fail_checkpoint_helper = 1;
  }

  if(isDefined(level.player.vehicle_state) && level.player.vehicle_state == 2)
    level.vh_player_drone thread turn_on_future_damage_overlay(0.1);

  if(isDefined(level.player.vehicle_state)) {
    if(level.player.vehicle_state == 2) {
      health_frac = level.vh_player_drone.vehicle_health / level.vh_player_drone.max_vehicle_health;

      if(health_frac < level._percent_life_at_checkpoint)
        level.vh_player_drone.vehicle_health = level._percent_life_at_checkpoint * level.vh_player_drone.max_vehicle_health;

      level.vh_player_drone thread player_drone_damage_ignore(1);
    } else if(level.player.vehicle_state == 1) {
      health_frac = level.vh_player_soct.vehicle_health / level.vh_player_soct.max_vehicle_health;

      if(health_frac < level._percent_life_at_checkpoint)
        level.vh_player_soct.vehicle_health = level._percent_life_at_checkpoint * level.vh_player_soct.max_vehicle_health;

      level.vh_player_soct thread player_soct_damage_ignore(1);
    }
  }
}

get_restored_checkpoint_start_node() {
  if(isDefined(self.currentnode.target))
    nd_start = getvehiclenode(self.currentnode.target, "targetname");
  else
    nd_start = self.currentnode;

  return nd_start;
}

wait_restore_player_soct(nd_start) {
  wait 0.15;
  self clearvehgoalpos();

  if(isDefined(nd_start))
    level.vh_player_soct drivepath(nd_start, 1);

  wait 0.05;

  if(isDefined(level.player.watch_for_boost))
    level.vh_player_soct launchvehicle(anglestoforward(level.vh_player_soct.angles) * 22 * 17.6);

  clientnotify("enter_soct");
}

wait_restore_salazar_soct(nd_start) {
  wait 0.15;
  self clearvehgoalpos();
  self go_path(nd_start);
}

wait_restore_npc_soct() {
  wait 0.15;
  self clearvehgoalpos();
  self go_path(self.currentnode);
}

run_scene_clear_goal(str_scene) {
  level thread run_scene(str_scene);
  wait 0.1;
  a_ai = get_ais_from_scene(str_scene);
  scene_wait(str_scene);

  if(isDefined(a_ai)) {
    for(i = 0; i < a_ai.size; i++) {
      e_ent = a_ai[i];

      if(isalive(e_ent))
        e_ent setgoalpos(e_ent.origin);
    }
  }
}

vehicle_health_overlay(max_alpha) {
  self endon("death");
  level.player endon("death");
  self.vehicle_health = self.max_vehicle_health;
  wait 0.1;
  red_edge_overlay = newclienthudelem(level.player);
  red_edge_overlay setshader("overlay_low_health", 640, 480);
  red_edge_overlay.x = 0;
  red_edge_overlay.y = 0;
  red_edge_overlay.splatter = 1;
  red_edge_overlay.alignx = "left";
  red_edge_overlay.aligny = "top";
  red_edge_overlay.sort = 1;
  red_edge_overlay.foreground = 0;
  red_edge_overlay.horzalign = "fullscreen";
  red_edge_overlay.vertalign = "fullscreen";
  red_edge_overlay.alpha = 0;
  blood_splats_overlay = newclienthudelem(level.player);
  blood_splats_overlay setshader("overlay_low_health_splat", 640, 480);
  blood_splats_overlay.x = 0;
  blood_splats_overlay.y = 0;
  blood_splats_overlay.splatter = 1;
  blood_splats_overlay.alignx = "left";
  blood_splats_overlay.aligny = "top";
  blood_splats_overlay.sort = 1;
  blood_splats_overlay.foreground = 0;
  blood_splats_overlay.horzalign = "fullscreen";
  blood_splats_overlay.vertalign = "fullscreen";
  blood_splats_overlay.alpha = 0;
  hud_display = newhudelem();
  hud_display.horizalign = "center";
  hud_display.vertalign = "middle";
  hud_display.x = 300;
  hud_display.y = 150;
  hud_display.font_scale = 6;
  hud_display.color = (1, 1, 1);
  hud_display.font = "big";
  hud_display.alpha = 1.0;
  max_hp = self.max_vehicle_health;
  frac = 1.0;
  last_frac = 1.0;

  if(isDefined(level.vh_player_drone) && self == level.vh_player_drone)
    i_am_the_drone = 1;
  else
    i_am_the_drone = 0;

  while(true) {
    current_health = self.vehicle_health;
    frac = current_health / max_hp;

    if(frac <= 0.0) {
      frac = 0.0;
      return;
    } else if(frac > 1.0)
      frac = 1.0;

    hp_alpha = 1.0;

    if(i_am_the_drone && is_player_in_drone())
      alpha = 1.0 - frac;
    else if(!i_am_the_drone && !is_player_in_drone())
      alpha = 1.0 - frac;
    else
      alpha = 0.0;

    hp_alpha = 0.0;

    if(alpha < 0.0)
      alpha = 0.0;
    else if(alpha > 1.0)
      alpha = 1.0;

    alpha = max_alpha * alpha;
    red_edge_overlay.alpha = alpha;
    blood_splats_overlay.alpha = alpha;
    hud_display.alpha = hp_alpha;

    message = "Health" + current_health;
    hud_display settext(current_health);

    wait 0.01;
    last_frac = frac;
  }

  red_edge_overlay destroy();
  blood_splats_overlay destroy();

  hud_display destroy();

  self.vehicle_overlay = undefined;
}

setup_vehicle_regen() {
  level._percent_life_at_checkpoint = 1.0;
  self set_player_vehicle_difficulty();
  self.vehicle_health = self.max_vehicle_health;
  self thread monitor_player_vehicle_difficulty();
  self thread regen_vehicle_health();

  if(self == level.vh_player_soct) {
    self thread vehicle_health_overlay(0.4);
    self thread player_soct_damage_states();
    self thread soct_animated_damage_states_think();
  } else
    self thread player_drone_damage_states();
}

set_player_vehicle_difficulty() {
  n_difficulty = get_difficulty();

  if(isDefined(level.vh_player_drone) && self == level.vh_player_drone) {
    switch (n_difficulty) {
      case 3:
        self.max_vehicle_health = 3000;
        self.regen_start_delay = 3.2;
        self.hp_regen_per_frame = 20;
        self.drone_soct_damage_scale = 0.5;
        self.drone_chopper_damage_scale = 1.6;
        break;
      case 2:
        self.max_vehicle_health = 3000;
        self.regen_start_delay = 2.75;
        self.hp_regen_per_frame = 35;
        self.drone_soct_damage_scale = 0.35;
        self.drone_chopper_damage_scale = 1.4;
        break;
      case 1:
        self.max_vehicle_health = 3500;
        self.regen_start_delay = 2.5;
        self.hp_regen_per_frame = 55;
        self.drone_soct_damage_scale = 0.28;
        self.drone_chopper_damage_scale = 1.2;
        break;
      default:
        self.max_vehicle_health = 4000;
        self.regen_start_delay = 1.75;
        self.hp_regen_per_frame = 90;
        self.drone_soct_damage_scale = 0.15;
        self.drone_chopper_damage_scale = 1.0;
        break;
    }
  } else {
    switch (n_difficulty) {
      case 3:
        self.max_vehicle_health = 3000;
        self.regen_start_delay = 2.6;
        self.hp_regen_per_frame = 20;
        self.soct_world_collision_damage_scale = 1.5;
        self.player_rammed_time_delay = 1.5;
        break;
      case 2:
        self.max_vehicle_health = 3000;
        self.regen_start_delay = 2.5;
        self.hp_regen_per_frame = 32;
        self.soct_world_collision_damage_scale = 1.3;
        self.player_rammed_time_delay = 2.0;
        break;
      case 1:
        self.max_vehicle_health = 3600;
        self.regen_start_delay = 2.3;
        self.hp_regen_per_frame = 40;
        self.soct_world_collision_damage_scale = 0.95;
        self.player_rammed_time_delay = 4.0;
        break;
      default:
        self.max_vehicle_health = 4000;
        self.regen_start_delay = 1.75;
        self.hp_regen_per_frame = 70;
        self.soct_world_collision_damage_scale = 1.0;
        self.player_rammed_time_delay = 4.0;
        break;
    }
  }
}

monitor_player_vehicle_difficulty() {
  self endon("death");

  while(true) {
    level waittill("difficulty_change");
    self set_player_vehicle_difficulty();
  }
}

regen_vehicle_health() {
  self endon("death");
  self endon("vehicle_destroyed");
  self.time_since_last_damage = 0;
  self thread update_vehicle_damage_timer();
  self thread wait_for_vehicle_damage_events();

  while(true) {
    regen_start_delay = self.regen_start_delay;

    if(isDefined(level.health_regen_restart_scale))
      regen_start_delay = regen_start_delay * level.health_regen_restart_scale;

    if(self.time_since_last_damage > regen_start_delay) {
      self thread begin_armor_regen();
      self waittill_either("armor_full", "vehicle_regen_damage");
    }

    wait 0.05;
  }
}

update_vehicle_damage_timer() {
  self endon("death");

  while(true) {
    self.time_since_last_damage = self.time_since_last_damage + 0.05;

    if(self.vehicle_health <= 0) {
      self notify("vehicle_destroyed");
      playsoundatposition("evt_soct_explo", (0, 0, 0));

      if(is_player_in_drone()) {
        playsoundatposition("evt_drone_plr_explo", (0, 0, 0));
        wait 1;
        missionfailedwrapper();
      } else {
        soct_swap_to_dead_version();
        playfxontag(level._effect["soct_player_exp"], level.vh_player_soct, "body_animate_jnt");
        playsoundatposition("evt_soct_explo_long", (0, 0, 0));
        wait 2.0;
        missionfailedwrapper();
      }

      return;
    }

    wait 0.05;
  }
}

wait_for_vehicle_damage_events() {
  self endon("death");
  self endon("vehicle_destroyed");

  while(true) {
    self waittill("vehicle_regen_damage");
    self.time_since_last_damage = 0;
    wait 0.05;
  }
}

begin_armor_regen() {
  self endon("vehicle_regen_damage");
  self endon("death");
  self endon("vehicle_destroyed");

  while(true) {
    if(self.vehicle_health > self.max_vehicle_health) {
      self.vehicle_health = self.max_vehicle_health;
      break;
    }

    if(self.vehicle_health == self.max_vehicle_health) {
      break;
    }

    hp_inc = self.hp_regen_per_frame;

    if(isDefined(level.health_regen_hp_scale))
      hp_inc = hp_inc * level.health_regen_hp_scale;

    self.vehicle_health = self.vehicle_health + hp_inc;
    wait 0.05;
  }

  self notify("armor_full");
}

fx_exp_model_triggered(str_model_name, v_origin, fx_name, fx_dir, player_collision, str_play_sound, a_str_more_models_to_delete, exploder_id) {
  a_ents = getentarray(str_model_name, "targetname");

  for(i = 0; i < a_ents.size; i++)
    a_ents[i] delete();

  if(!isDefined(fx_dir))
    fx_dir = vectornormalize(v_origin - level.player.origin);

  if(isDefined(exploder_id) && exploder_id != -1) {
    exploder(exploder_id);

    if(exploder_id == 725)
      exploder(726);

    if(exploder_id == 732)
      exploder(733);
  } else if(isDefined(fx_name))
    playfx(level._effect[fx_name], v_origin, fx_dir);

  if(!isDefined(str_play_sound))
    str_play_sound = "evt_soct_window_explode_2";

  playsoundatposition(str_play_sound, v_origin);

  if(isDefined(player_collision)) {
    earthquake(0.65, 1.0, level.player.origin, 512);
    damage_player_vehicle(250, "damage_light");
  }

  if(isDefined(a_str_more_models_to_delete)) {
    for(i = 0; i < a_str_more_models_to_delete.size; i++) {
      e_ent = getent(a_str_more_models_to_delete[i], "targetname");
      e_ent delete();
    }
  }
}

vehicle_target_player(weapon_index, delay, enable_turret) {
  self endon("death");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  if(isDefined(enable_turret))
    self enable_turret(weapon_index);

  wait 0.1;
  self maps\_turret::set_turret_target_flags(2, weapon_index);
}

spawner_run_to_node(e_spawner) {
  if(isDefined(e_spawner.script_delay) && e_spawner.script_delay > 0)
    wait(e_spawner.script_delay);

  e_ent = simple_spawn_single(e_spawner);
  e_ent endon("death");
  e_ent.ignoreall = 1;
  e_ent.goalradius = 48;
  e_ent waittill("goal");
}

shoot_or_collide_triggers_creates_fx(str_collide_trigger, str_damage_trigger, str_model_to_delete, str_fx_name, str_vehicle_info_volume, a_str_more_models_to_delete) {
  level endon(str_model_to_delete);

  if(isDefined(str_collide_trigger))
    e_collide_trigger = getent(str_collide_trigger, "targetname");

  e_damage_trigger = getent(str_damage_trigger, "targetname");
  s_struct = getstruct(e_damage_trigger.target, "targetname");
  v_position = s_struct.origin;
  exploder_id = -1;

  if(isDefined(s_struct.script_int)) {
    str_fx_name = undefined;
    exploder_id = s_struct.script_int;
  }

  e_damage_trigger thread damage_trigger_shoot_or_collide(str_model_to_delete, v_position, str_fx_name, a_str_more_models_to_delete, exploder_id);

  if(isDefined(str_vehicle_info_volume)) {
    e_info_volume = getent(str_vehicle_info_volume, "targetname");
    e_info_volume thread info_volume_vehicle_collide(str_model_to_delete, v_position, str_fx_name, a_str_more_models_to_delete, exploder_id);
  }

  if(isDefined(str_collide_trigger)) {
    e_collide_trigger waittill("trigger");
    str_sound = "evt_soct_window_explode_" + randomintrange(0, 2);
    fx_exp_model_triggered(str_model_to_delete, v_position, str_fx_name, undefined, 1, str_sound, a_str_more_models_to_delete, exploder_id);
    level notify(str_model_to_delete);
  }
}

damage_trigger_shoot_or_collide(str_model_to_delete, v_position, str_fx_name, a_str_more_models_to_delete, exploder_id) {
  level endon(str_model_to_delete);

  while(true) {
    self waittill("damage", n_damage, e_attacker, direction_vec, point, damagetype);

    if(isDefined(e_attacker) && e_attacker == level.player) {
      fx_exp_model_triggered(str_model_to_delete, v_position, str_fx_name, undefined, undefined, undefined, a_str_more_models_to_delete, exploder_id);
      level notify(str_model_to_delete);
      break;
    }
  }
}

info_volume_vehicle_collide(str_model_to_delete, v_position, str_fx_name, a_str_more_models_to_delete, exploder_id) {
  level endon(str_model_to_delete);

  while(true) {
    if(isDefined(self.script_string))
      a_vehicles = getvehiclearray(self.script_string);
    else
      a_vehicles = getvehiclearray("axis", "allies");

    if(isDefined(a_vehicles)) {
      for(i = 0; i < a_vehicles.size; i++) {
        e_vehicle = a_vehicles[i];

        if(e_vehicle istouching(self)) {
          earthquake(0.5, 1.0, v_position, 2048);
          fx_exp_model_triggered(str_model_to_delete, v_position, str_fx_name, undefined, undefined, undefined, a_str_more_models_to_delete, exploder_id);
          level notify(str_model_to_delete);
          break;
        }
      }
    }

    wait 0.05;
  }

  self delete();
}

shoot_or_collide_triggers_calls_fxanim_notify(str_collide_trigger, str_damage_trigger, str_fxanim_notify) {
  level endon(str_fxanim_notify);

  if(isDefined(str_collide_trigger))
    e_collide_trigger = getent(str_collide_trigger, "targetname");

  e_damage_trigger = getent(str_damage_trigger, "targetname");
  e_damage_trigger thread fxanim_damage_trigger_shoot(str_fxanim_notify);

  if(isDefined(str_collide_trigger)) {
    e_collide_trigger waittill("trigger");
    earthquake(0.65, 1.0, level.player.origin, 512);
    damage_player_vehicle(250, "damage_light");
    level notify(str_fxanim_notify);
  }
}

fxanim_damage_trigger_shoot(str_fxanim_notify) {
  level endon(str_fxanim_notify);

  while(true) {
    self waittill("damage", n_damage, e_attacker, direction_vec, point, damagetype);

    if(isDefined(e_attacker) && e_attacker == level.player) {
      level notify(str_fxanim_notify);
      break;
    }
  }
}

ai_explosive_death(height, radius, delay) {
  self endon("death");

  if(!isDefined(self.alreadylaunched)) {
    if(target_istarget(self))
      target_remove(self);

    if(isDefined(delay))
      wait(delay);

    if(!isDefined(height))
      height = 100;

    if(!isDefined(radius))
      radius = 30;

    self.a.nodeath = 1;
    self.alreadylaunched = 1;
    self startragdoll(1);
    x = randomintrange(radius * -1, radius);
    y = randomintrange(radius * -1, radius);
    v_launch = (x, y, height);
    vectornormalize(v_launch);
    v_launch = v_launch * 1.5;
    self launchragdoll(v_launch, "J_SpineUpper");
    wait 2;
    self dodamage(self.health, self.origin, level.player, -1, "explosive");
  }
}

cleanup_ai_on_level_notify(str_level_notify) {
  self endon("death");
  level waittill(str_level_notify);
  self dodamage(self.health + 100, self.origin);
}

drone_follow_linked_structs(str_struct, start_speed, use_near_goal, only_use_turret, look_at_ent, target_player) {
  self endon("death");
  self thread enemy_drone_setup(only_use_turret);
  s_struct = getstruct(str_struct, "targetname");

  if(isDefined(s_struct.script_delay) && s_struct.script_delay > 0)
    wait(s_struct.script_delay);

  self.origin = s_struct.origin;
  self setphysangles(s_struct.angles);

  if(isDefined(look_at_ent))
    self setlookatent(level.player);

  if(isDefined(target_player) && target_player == 1)
    self thread vehicle_target_player(0);

  self.drivepath = 1;
  self setspeed(start_speed);
  self setneargoalnotifydist(512);

  while(true) {
    s_next = getstruct(s_struct.target, "targetname");
    self setvehgoalpos(s_next.origin);

    if(isDefined(use_near_goal))
      self waittill("near_goal");
    else
      self waittill("goal");

    if(!isDefined(s_next.target)) {
      break;
    }

    s_struct = s_next;
  }

  if(!(isDefined(self.crashing) && self.crashing)) {
    self.delete_on_death = 1;
    self notify("death");

    if(!isalive(self))
      self delete();
  }
}

multiple_trigger_waits(str_trigger_name, str_trigger_notify) {
  a_triggers = getentarray(str_trigger_name, "targetname");

  for(i = 0; i < a_triggers.size; i++)
    a_triggers[i] thread multiple_trigger_wait(str_trigger_notify);
}

multiple_trigger_wait(str_trigger_notify) {
  level endon(str_trigger_notify);
  self waittill("trigger");
  level notify(str_trigger_notify);
}

player_in_soct_keep_up_with_salazar_fail() {
  level endon("escape_done");
  level endon("end_player_in_soct_fail");
  wait 2;
  level.player_too_far_behind_salazar = 0;
  n_dist_warning = 9000;
  n_distance_warning_start_time = undefined;
  n_distance_2nd_warning_time = 15;
  n_distance_2nd_warning_message = 0;
  n_distance_3rd_warning_time = 28;
  n_distance_3rd_warning_message = 0;
  n_distance_recover_time_allowed = 38;
  level.objective_follow_salazar_active = undefined;

  while(true) {
    if(!isgodmode(level.player)) {
      n_dist = distance(self.origin, level.vh_salazar_soct.origin);

      if(isDefined(level.n_distance_fail_checkpoint_helper) || is_soct_speed_warning_active()) {
        level.player_too_far_behind_salazar = 0;
        level.n_distance_fail_checkpoint_helper = undefined;
        n_distance_warning_start_time = undefined;
        n_distance_2nd_warning_message = 0;
        n_distance_3rd_warning_message = 0;
      }

      if(n_dist > n_dist_warning) {
        level.player_too_far_behind_salazar = 1;
        time = gettime();

        if(!isDefined(n_distance_warning_start_time)) {
          n_distance_warning_start_time = time;
          level.harper thread say_dialog("harp_follow_salazar_0");

          if(!isDefined(level.objective_follow_salazar_active)) {
            set_objective(level.obj_follow_salazars_soct, level.salazar, "follow");
            level.objective_follow_salazar_active = 1;
          } else if(level.objective_follow_salazar_active == 0) {
            objective_state(level.obj_follow_salazars_soct, "active");
            level.objective_follow_salazar_active = 1;
          }
        }

        time_out_of_range = (time - n_distance_warning_start_time) / 1000;

        if(!n_distance_2nd_warning_message) {
          if(time_out_of_range > n_distance_2nd_warning_time) {
            level.harper thread say_dialog("harp_we_re_falling_too_fa_0");
            n_distance_2nd_warning_message = 1;
          }
        }

        if(!n_distance_3rd_warning_message) {
          if(time_out_of_range > n_distance_3rd_warning_time) {
            level.harper thread say_dialog("harp_we_gotta_keep_up_wit_0");
            n_distance_3rd_warning_message = 1;
          }
        }

        if(time_out_of_range >= n_distance_recover_time_allowed) {
          missionfailedwrapper(&"PAKISTAN_SHARED_SOCT_DISTANCE_FAIL");
          return;
        }
      } else {
        level.player_too_far_behind_salazar = 0;
        n_distance_warning_start_time = undefined;
        n_distance_2nd_warning_message = 0;
        n_distance_3rd_warning_message = 0;

        if(isDefined(level.objective_follow_salazar_active) && level.objective_follow_salazar_active == 1) {
          objective_state(level.obj_follow_salazars_soct, "invisible");
          level.objective_follow_salazar_active = 0;
        }
      }
    }

    wait 0.2;
  }
}

cleanup_follow_salazar_objective() {
  if(isDefined(level.objective_follow_salazar_active)) {
    set_objective(level.obj_follow_salazars_soct, undefined, "delete");
    level.objective_follow_salazar_active = undefined;
  }
}

player_in_soct_keep_moving_fail() {
  level endon("escape_done");
  level endon("end_player_in_soct_fail");
  wait 2;
  level.zero_speed_start_time = undefined;
  n_zero_1st_warning_time = 12;
  n_zero_1st_warning_message = 0;
  n_zero_2nd_warning_time = 24;
  n_zero_2nd_warning_message = 0;
  n_zero_speed_max_time_allowed = 38;

  while(true) {
    if(!isgodmode(level.player)) {
      zero_speed_warning_reset = 0;

      if(is_soct_salazar_distance_warning_active()) {
        wait 2;
        zero_speed_warning_reset = 1;
      } else {
        n_speed = self getspeedmph();

        if(abs(n_speed) <= 0.2) {
          time = gettime();

          if(!isDefined(level.zero_speed_start_time))
            level.zero_speed_start_time = time;

          total_zero_speed_time = (time - level.zero_speed_start_time) / 1000;

          if(!n_zero_1st_warning_message) {
            if(total_zero_speed_time > n_zero_1st_warning_time) {
              level.harper thread say_dialog("harp_floor_it_section_0");
              n_zero_1st_warning_message = 1;
            }
          }

          if(!n_zero_2nd_warning_message) {
            if(total_zero_speed_time > n_zero_2nd_warning_time) {
              level.harper thread say_dialog("harp_fuck_man_we_need_0");
              n_zero_2nd_warning_message = 1;
            }
          }

          if(total_zero_speed_time >= n_zero_speed_max_time_allowed) {
            missionfailedwrapper(&"PAKISTAN_SHARED_SOCT_SPEED_FAIL");
            return;
          }
        } else
          zero_speed_warning_reset = 1;
      }

      if(zero_speed_warning_reset) {
        level.zero_speed_start_time = undefined;
        n_zero_1st_warning_message = 0;
        n_zero_2nd_warning_message = 0;
      }
    }

    wait 0.2;
  }
}

is_soct_speed_warning_active() {
  if(isDefined(level.zero_speed_start_time) && level.zero_speed_start_time > 0)
    return true;

  return false;
}

is_soct_salazar_distance_warning_active() {
  if(isDefined(level.player_too_far_behind_salazar) && level.player_too_far_behind_salazar == 1)
    return true;

  return false;
}

soct_warning_message(str_message, display_time) {
  screen_message_create(str_message);
  wait(display_time);
  screen_message_delete();
}

pak3_kill_vehicle(e_vehicle) {
  if(isDefined(e_vehicle.steering_wheel)) {
    e_vehicle.steering_wheel delete();
    e_vehicle.steering_wheel = undefined;
  }

  e_vehicle notify("nodeath_thread");
  e_vehicle lights_off();
  e_vehicle maps\_vehicle_death::death_cleanup_level_variables();
  e_vehicle maps\_vehicle_death::death_cleanup_riders();
  e_vehicle delete();
}

ai_run_to_goal_wait_kill_flag(str_killoff_flag) {
  self endon("death");
  self thread run_over();
  self set_goalradius(48);
  self set_ignoreme(1);
  self waittill("goal");
  self set_goalradius(2048);
  self set_ignoreme(0);

  while(true) {
    if(flag(str_killoff_flag)) {
      break;
    }

    wait 0.01;
  }

  iprintlnbold("Killing AI");
  self delete();
}

kill_vehicle_on_flag(str_flag) {
  self endon("death");
  flag_wait(str_flag);
  pak3_kill_vehicle(self);
}

force_trigger(str_trigger_name) {
  e_trigger = getent(str_trigger_name, "targetname");

  if(isDefined(e_trigger))
    e_trigger activate_trigger();
}

pak3_timescale(start_delay, ts_total_time) {
  if(isDefined(start_delay) && start_delay > 0)
    wait(start_delay);

  ts_start = 0.5;
  ts_end = 0.4;
  total_time = 100;
  delay = undefined;
  step_time = 0.1;
  level thread timescale_tween(ts_start, ts_end, total_time, delay, step_time);
  wait(ts_total_time);
  level thread timescale_tween(1, 1, 0);
}

get_difficulty() {
  str_difficulty = getdifficulty();

  switch (str_difficulty) {
    case "fu":
      return 3;
      break;
    case "hard":
      return 2;
      break;
    case "medium":
      return 1;
      break;
    default:
      return 0;
      break;
  }
}

pak3_water_sheeting(bounce_player_on_impact_frac, delay, sheeting_time, drops_time) {
  if(isDefined(bounce_player_on_impact_frac) && bounce_player_on_impact_frac > 0) {
    if(!is_player_in_drone())
      level.vh_player_soct thread bounce_player_after_water_sheeting(bounce_player_on_impact_frac);
  }

  if(isDefined(delay) && delay > 0)
    wait(delay);

  level thread water_sheeting_rumble();
  level.player setwatersheeting(1, sheeting_time);
  level.player setwaterdrops(40);
  wait(drops_time);
  level.player setwaterdrops(0);
}

water_sheeting_rumble() {
  earthquake(0.65, 1.0, level.player.origin, 512);

  for(i = 0; i < 4; i++) {
    level.player playrumbleonentity("damage_heavy");
    wait 0.1;
  }
}

bounce_player_after_water_sheeting(bounce_scale) {
  if(!isDefined(bounce_scale))
    bounce_scale = 1.0;

  v_dir = vectornormalize(anglestoforward(level.vh_player_soct.angles));
  v_down = (0, 0, -1);
  dp = vectordot(v_dir, v_down);

  if(dp > 0.5)
    directional_impact_scale = 0.7;
  else if(dp > 0.4)
    directional_impact_scale = 0.8;
  else if(dp > 0.3)
    directional_impact_scale = 0.9;
  else
    directional_impact_scale = 1.0;

  bounce_scale = bounce_scale * directional_impact_scale;

  for(i = 0; i < 10; i++) {
    dir_size = vectornormalize(level.vh_player_soct.velocity);
    up_size = (0, 0, 1);
    r0 = 40;
    r1 = 150;
    v_dir = (dir_size * r0 + up_size * r1) * bounce_scale;
    self launchvehicle(v_dir);
    wait 0.01;
  }
}

player_soct_monitor_tags_update() {
  self endon("death");
  self hidepart("tag_monitor_healthy");
  self hidepart("tag_monitor_healthy_water");
  self hidepart("tag_monitor_damaged_1");
  self hidepart("tag_monitor_damaged_2");
  water_delta = 48;

  while(!isDefined(level.player.vehicle_state))
    wait 0.01;

  while(true) {
    if(!is_player_in_drone()) {
      if(level.player_soct_test_for_water == 0)
        in_water = "0";
      else {
        in_water = getdvar(#"_id_56879D89");
        water_height = getwaterheight(self.origin);

        if(in_water == "0") {
          if(abs(self.origin[2] - water_height) < water_delta)
            in_water = "1";
        } else if(abs(self.origin[2] - water_height) > water_delta)
          in_water = "0";
      }

      if(in_water == "1") {
        self hidepart("tag_monitor_healthy");
        self showpart("tag_monitor_healthy_water");
      } else {
        self showpart("tag_monitor_healthy");
        self hidepart("tag_monitor_healthy_water");
      }

      show_monitor1 = 0;
      show_monitor2 = 0;

      if(isDefined(level.player_soct_damaged_frac)) {
        if(level.player_soct_damaged_frac < 0.5) {
          show_monitor1 = 1;
          show_monitor2 = 1;
        } else if(level.player_soct_damaged_frac < 0.8) {
          show_monitor1 = 1;
          show_monitor2 = 0;
        }
      }

      if(show_monitor1)
        self showpart("tag_monitor_damaged_1");
      else
        self hidepart("tag_monitor_damaged_1");

      if(show_monitor2)
        self showpart("tag_monitor_damaged_2");
      else
        self hidepart("tag_monitor_damaged_2");
    }

    wait 0.05;
  }
}

player_soct_monitor_boost_tags_update() {
  self endon("death");
  self hidepart("tag_monitor_boost_orange");
  self hidepart("tag_monitor_boost_red");

  while(true) {
    self waittill("soct_boost");
    self showpart("tag_monitor_boost_red");
    self showpart("tag_monitor_boost_orange");
    wait 2.0;
    self hidepart("tag_monitor_boost_red");
    wait 1.0;
    self hidepart("tag_monitor_boost_orange");
  }
}

player_drone_damage_states() {
  self endon("death");
  loop_time = 2.0;
  self thread oxygen_mask_crack_watcher();
  damage = [];
  damage[1] = spawnstruct();
  damage[1].frac = 0.9;
  damage[1].start_time = undefined;
  damage[1].client_effect_on_id = 5;
  damage[2] = spawnstruct();
  damage[2].frac = 0.65;
  damage[2].start_time = undefined;
  damage[2].client_effect_on_id = 7;
  damage[3] = spawnstruct();
  damage[3].frac = 0.4;
  damage[3].start_time = undefined;
  damage[3].client_effect_on_id = 9;

  while(true) {
    time = gettime();
    damage_frac = self.vehicle_health / self.max_vehicle_health;
    all_modes_active = 0;
    max_damage_state = 3;
    min_damage_state = 1;

    for(i = max_damage_state; i >= min_damage_state; i--) {
      state = damage[i];

      if(all_modes_active || state.frac >= damage_frac) {
        if(!isDefined(state.start_time))
          self setclientflag(state.client_effect_on_id);

        state.start_time = time;
        all_modes_active = 1;
        continue;
      }

      if(isDefined(state.start_time)) {
        dt = (time - state.start_time) / 1000;

        if(dt >= loop_time) {
          self clearclientflag(state.client_effect_on_id);
          state.start_time = undefined;

          if(i > min_damage_state)
            damage[i - 1].start_time = time;
        }
      }
    }

    wait 0.01;
  }
}

player_soct_damage_states() {
  self endon("death");
  loop_time = 4.0;
  damage = [];
  damage[1] = spawnstruct();
  damage[1].frac = 0.8;
  damage[1].start_time = undefined;
  damage[1].client_effect_on_id = 13;
  damage[2] = spawnstruct();
  damage[2].frac = 0.65;
  damage[2].start_time = undefined;
  damage[2].client_effect_on_id = 14;
  damage[3] = spawnstruct();
  damage[3].frac = 0.35;
  damage[3].start_time = undefined;
  damage[3].client_effect_on_id = 15;

  while(true) {
    time = gettime();
    damage_frac = self.vehicle_health / self.max_vehicle_health;
    level.player_soct_damaged_frac = damage_frac;
    all_modes_active = 0;
    max_damage_state = 3;
    min_damage_state = 1;

    for(i = max_damage_state; i >= min_damage_state; i--) {
      state = damage[i];

      if(all_modes_active || state.frac >= damage_frac) {
        if(!isDefined(state.start_time)) {
          self setclientflag(state.client_effect_on_id);

          if(state.client_effect_on_id == 14)
            self thread soct_swap_to_damged_version();
        }

        state.start_time = time;
        all_modes_active = 1;
        continue;
      }

      if(isDefined(state.start_time)) {
        dt = (time - state.start_time) / 1000;

        if(dt >= loop_time) {
          self clearclientflag(state.client_effect_on_id);
          state.start_time = undefined;

          if(i > min_damage_state)
            damage[i - 1].start_time = time;
        }
      }
    }

    wait 0.01;
  }
}

oxygen_mask_crack_watcher() {
  self endon("death");
  waiting_for_damage_to_repair = 0;
  crack_time_delay = 20;
  last_crack_time = 0;
  emergency_crack_time_delay = 2;
  last_emergency_crack_time = 0;
  damage_frac = 0.7;
  dangerous_damage_frac = 0.2;

  while(true) {
    self waittill("damage");
    time = gettime();
    create_a_crack = 0;
    frac = self.vehicle_health / self.max_vehicle_health;
    time_since_last_crack = (time - last_crack_time) / 1000;

    if(frac <= damage_frac && !waiting_for_damage_to_repair) {
      if(time_since_last_crack > crack_time_delay)
        create_a_crack = 1;
    }

    if(!create_a_crack) {
      if(frac <= dangerous_damage_frac) {
        if(time_since_last_crack > emergency_crack_time_delay) {
          dt = (time - last_emergency_crack_time) / 1000;

          if(dt > emergency_crack_time_delay) {
            create_a_crack = 1;
            last_emergency_crack_time = time;
          }
        }
      }
    }

    if(create_a_crack) {
      rpc("clientscripts/pakistan_3", "oxygen_mask_crack");
      waiting_for_damage_to_repair = 1;
      last_crack_time = time;
    }

    if(waiting_for_damage_to_repair && frac > damage_frac)
      waiting_for_damage_to_repair = 0;
  }
}

player_soct_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(isDefined(self.delay_soct_damage)) {
    idamage = 0;
    return idamage;
  }

  if(isDefined(eattacker)) {
    if(isDefined(eattacker.vteam) && eattacker.vteam == "allies") {
      idamage = 0;
      return idamage;
    }
  }

  if(isDefined(sweapon) && sweapon == "boat_gun_turret") {
    if(idamage > 10)
      idamage = 10;
  }

  if(isDefined(sweapon) && sweapon == "firescout_missile_turret") {
    if(idamage > 40)
      idamage = 40;
  }

  if(isDefined(sweapon) && sweapon == "firescout_gun_turret") {
    if(idamage > 7)
      idamage = 7;
  }

  if(isDefined(sweapon) && sweapon == "future_minigun_enemy_pilot") {
    if(idamage > 15)
      idamage = 15;
  }

  if(isDefined(sweapon) && sweapon == "tar21_sp") {
    if(idamage > 15)
      idamage = 15;
  }

  if(isDefined(eattacker)) {
    if(isDefined(sweapon) && sweapon == "boat_gun_turret") {
      reject_dot = 0.32;
      reject_dist = 336;
    } else {
      reject_dot = 0.2;
      reject_dist = 336;
    }

    v_dir = vectornormalize(eattacker.origin - self.origin);
    v_forward = anglestoforward(self.angles);
    dot = vectordot(v_dir, v_forward);

    if(dot < reject_dot) {
      dist = distance(self.origin, eattacker.origin);

      if(dist > reject_dist) {
        if(idamage != 100 && idamage != 150 && idamage != 360) {
          idamage = 0;
          return idamage;
        }
      }
    }
  }

  if(isgodmode(level.player))
    idamage = 0;

  if(idamage > 30) {
  }

  self.vehicle_health = self.vehicle_health - idamage;

  if(idamage > 0) {
    self notify("vehicle_regen_damage");
    idamage = 0;
  }

  return idamage;
}

player_soct_damage_ignore(damage_delay) {
  self endon("death");
  self.delay_soct_damage = damage_delay;

  while(damage_delay > 0) {
    wait 0.1;
    damage_delay = damage_delay - 0.1;
  }

  self.delay_soct_damage = undefined;
}

player_drone_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(is_player_in_drone()) {
    if(isDefined(self.delay_drone_damage)) {
      idamage = 0;
      return idamage;
    }

    if(isDefined(sweapon) && sweapon == "firescout_missile_turret") {
      idamage = 0;
      return idamage;
    }

    if(isDefined(eattacker)) {
      if(idamage == 37) {
        reject_dot = -11111;
        reject_dist = 466662;
      } else if(isDefined(sweapon) && sweapon == "boat_gun_turret") {
        reject_dot = 0.33;
        reject_dist = 336;
      } else {
        reject_dot = 0.1;
        reject_dist = 336;
      }

      v_dir = vectornormalize(eattacker.origin - self.origin);
      v_forward = anglestoforward(self.angles);
      dot = vectordot(v_dir, v_forward);

      if(dot < reject_dot) {
        dist = distance(self.origin, eattacker.origin);

        if(dist > reject_dist) {
          idamage = 0;
          return idamage;
        }
      }
    }

    if(isDefined(sweapon) && sweapon == "firescout_gun_turret")
      idamage = int(idamage * 1.45 * self.drone_chopper_damage_scale);

    if(isDefined(sweapon) && sweapon == "future_minigun_enemy_pilot") {
      if(idamage > 25)
        idamage = 25;
    }

    if(isgodmode(level.player))
      idamage = 0;

    if(isDefined(einflictor)) {
      if(isplayer(eattacker))
        idamage = 0;
    }

    if(isDefined(sweapon) && sweapon == "boat_gun_turret") {
      if(isDefined(eattacker.b_powerfull_weapons))
        reduced_damage = 3 * idamage / 4;
      else
        reduced_damage = idamage * self.drone_soct_damage_scale;

      idamage = int(reduced_damage);

      if(idamage <= 0)
        idamage = 1;
    }

    if(idamage > 0 && idamage < 100 && isDefined(level.health_regen_damage_multiplier))
      idamage = idamage * level.health_regen_damage_multiplier;

    self.vehicle_health = self.vehicle_health - idamage;
    self notify("vehicle_regen_damage");
    idamage = 1;

    if(!isDefined(level.last_hit_time))
      level.last_hit_time = -1000;

    time = gettime();
    dt = (time - level.last_hit_time) / 1000;

    if(dt > 2) {
      level.player finishplayerdamage(einflictor, eattacker, 1, idflags, smeansofdeath, sweapon, vpoint, vdir, "none", 0, psoffsettime);
      level.last_hit_time = time;
    }

    self thread fix_health_in_a_frame(idamage);
  } else
    idamage = 0;

  return idamage;
}

player_drone_damage_ignore(damage_delay) {
  self endon("death");
  self.delay_drone_damage = damage_delay;

  while(damage_delay > 0) {
    wait 0.1;
    damage_delay = damage_delay - 0.1;
  }

  self.delay_drone_damage = undefined;
}

fix_health_in_a_frame(idamage) {
  self endon("death");
  wait 0.1;
  self.health = self.health + idamage;
}

player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  if(flag("player_cannot_get_hurt"))
    n_damage = 0;

  if(level.player.vehicle_state == 2) {
    self cleardamageindicator();
    n_damage = 0;
  }

  if(level.player.vehicle_state == 1) {
    self cleardamageindicator();
    n_damage = 0;
  }

  n_health_after_damage = self.health - n_damage;

  if(n_health_after_damage < 1)
    n_damage = 0;

  return n_damage;
}

damage_player_vehicle(n_damage, str_rumble) {
  e_vehilce = undefined;

  if(level.player.vehicle_state == 2)
    e_vehicle = level.vh_player_drone;
  else if(level.player.vehicle_state == 1)
    e_vehicle = level.vh_player_soct;

  if(isDefined(e_vehicle))
    e_vehicle dodamage(n_damage, level.player.origin);

  if(isDefined(str_rumble))
    level.player playrumbleonentity(str_rumble);
}

soct_player_attacker_damage_callback(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  if(isDefined(e_attacker) && e_attacker != level.player)
    n_damage = 0;

  return n_damage;
}

soct_swap_to_damged_version() {
  if(!isDefined(level.using_damaged_soct)) {
    level.using_damaged_soct = 1;

    if(level.player get_temp_stat(1))
      level.vh_player_soct setmodel("veh_t6_mil_super_soc_t_damaged");
    else
      level.vh_player_soct setmodel("veh_t6_mil_soc_t_damaged");

    level notify("player_soct_is_damaged");
  }

  self.bump_animated_damage_state = 1;
}

soct_swap_to_dead_version() {
  if(!isDefined(level.using_dead_soct)) {
    level.using_dead_soct = 1;

    if(level.player get_temp_stat(1))
      level.vh_player_soct setmodel("veh_t6_mil_super_soc_t_dead");
    else
      level.vh_player_soct setmodel("veh_t6_mil_soc_t_dead");
  }
}

#using_animtree("vehicles");

soct_animated_damage_states_think() {
  self endon("death");
  self.animname = "player_scot";
  self.animated_damage_state = 0;
  self.playing_damage_animation = 0;
  max_damage_state = 3;
  min_speed_for_animated_damage = 5;
  start_anims = [];
  start_anims[start_anims.size] = % fxanim_pak_soct_dmg_slow_start_anim;
  start_anims[start_anims.size] = % fxanim_pak_soct_dmg_med_start_anim;
  start_anims[start_anims.size] = % fxanim_pak_soct_dmg_fast_start_anim;
  stop_anims = [];
  stop_anims[stop_anims.size] = % fxanim_pak_soct_dmg_slow_stop_anim;
  stop_anims[stop_anims.size] = % fxanim_pak_soct_dmg_med_stop_anim;
  stop_anims[stop_anims.size] = % fxanim_pak_soct_dmg_fast_stop_anim;
  damage_anims = [];
  damage_anims[damage_anims.size] = % fxanim_pak_soct_dmg_slow_anim;
  damage_anims[damage_anims.size] = % fxanim_pak_soct_dmg_med_anim;
  damage_anims[damage_anims.size] = % fxanim_pak_soct_dmg_fast_anim;
  last_damage_state = 0;
  level waittill("player_soct_is_damaged");

  while(true) {
    if(self.animated_damage_state > 0) {
      speed = self getspeedmph();

      if(self.playing_damage_animation == 1 && abs(speed) < min_speed_for_animated_damage) {
        anim_def = damage_anims[self.playing_animation_index];
        self clearanim(anim_def, 0.1);
        anim_def = stop_anims[self.playing_animation_index];
        self setflaggedanim("stop_damage", anim_def, 1, 0.1, 1);
        wait 0.1;
        self.playing_damage_animation = 0;
      }

      if(self.playing_damage_animation == 0 && abs(speed) >= min_speed_for_animated_damage) {
        self.playing_animation_index = self.animated_damage_state - 1;
        anim_def = start_anims[self.playing_animation_index];
        self setflaggedanim("start_damage", anim_def, 1, 0.1, 1);
        self waittillmatch("start_damage", "end");
        self clearanim(anim_def, 0.1);
        anim_def = damage_anims[self.playing_animation_index];
        self setanim(anim_def, 1, 0.1, 1);
        wait 1;
        self.playing_damage_animation = 1;
      }

      if(self.playing_damage_animation == 1 && abs(speed) < min_speed_for_animated_damage && last_damage_state > 0 && self.animated_damage_state > last_damage_state) {
        anim_def = damage_anims[self.playing_animation_index];
        self clearanim(anim_def, 0.1);
        self.playing_animation_index = self.animated_damage_state - 1;
        anim_def = damage_anims[self.playing_animation_index];
        self setanim(anim_def, 1, 0.1, 1);
        wait 1;
      }
    }

    if(isDefined(self.bump_animated_damage_state)) {
      self.animated_damage_state++;

      if(self.animated_damage_state >= max_damage_state)
        self.animated_damage_state = max_damage_state;

      self.bump_animated_damage_state = undefined;
    }

    last_damage_state = self.animated_damage_state;
    wait 0.2;
  }
}

fire_magic_bullet_rpg_structs(s_start, v_fire_offset, s_target, v_target_offset) {
  if(!isDefined(v_fire_offset))
    v_fire_offset = (0, 0, 0);

  if(!isDefined(v_target_offset))
    v_target_offset = (0, 0, 0);

  magicbullet("usrpg_magic_bullet_sp", s_start.origin + v_fire_offset, s_target.origin + v_target_offset);
}

hint_missile_helper_check() {
  level.num_drone_missile_kills = undefined;
  no_kill_time_warning = 20;
  wait(no_kill_time_warning);

  if(!isDefined(level.num_drone_missile_kills)) {
    screen_message_create(&"PAKISTAN_SHARED_DRONE_MISSILE_LOCK_HELPER");
    wait 6;
    screen_message_delete();
  }
}