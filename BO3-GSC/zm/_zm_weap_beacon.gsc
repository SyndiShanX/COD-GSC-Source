/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_beacon.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_clone;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using_animtree("zombie_beacon");
#namespace _zm_weap_beacon;

function init() {
  level.w_beacon = getweapon("beacon");
  clientfield::register("world", "play_launch_artillery_fx_robot_0", 21000, 1, "int");
  clientfield::register("world", "play_launch_artillery_fx_robot_1", 21000, 1, "int");
  clientfield::register("world", "play_launch_artillery_fx_robot_2", 21000, 1, "int");
  clientfield::register("scriptmover", "play_beacon_fx", 21000, 1, "int");
  clientfield::register("scriptmover", "play_artillery_barrage", 21000, 2, "int");
  level._effect["grenade_samantha_steal"] = "dlc5/zmhd/fx_zombie_couch_effect";
  level.beacons = [];
  level.zombie_weapons_callbacks[level.w_beacon] = & player_give_beacon;
  level thread function_45216da2();
}

function player_give_beacon() {
  self giveweapon(level.w_beacon);
  self zm_utility::set_player_tactical_grenade(level.w_beacon);
  self thread player_handle_beacon();
}

function player_handle_beacon() {
  self notify("starting_beacon_watch");
  self endon("disconnect");
  self endon("starting_beacon_watch");
  attract_dist_diff = level.beacon_attract_dist_diff;
  if(!isdefined(attract_dist_diff)) {
    attract_dist_diff = 45;
  }
  num_attractors = level.num_beacon_attractors;
  if(!isdefined(num_attractors)) {
    num_attractors = 96;
  }
  max_attract_dist = level.beacon_attract_dist;
  if(!isdefined(max_attract_dist)) {
    max_attract_dist = 1536;
  }
  while (true) {
    grenade = get_thrown_beacon();
    self thread player_throw_beacon(grenade, num_attractors, max_attract_dist, attract_dist_diff);
    wait(0.05);
  }
}

function watch_for_dud(model, actor) {
  self endon("death");
  self waittill("grenade_dud");
  model.dud = 1;
  self.monk_scream_vox = 1;
  wait(3);
  if(isdefined(model)) {
    model delete();
  }
  if(isdefined(actor)) {
    actor delete();
  }
  if(isdefined(self.damagearea)) {
    self.damagearea delete();
  }
  if(isdefined(self)) {
    self delete();
  }
}

function watch_for_emp(model, actor) {
  self endon("death");
  if(!zm_utility::should_watch_for_emp()) {
    return;
  }
  while (true) {
    level waittill("emp_detonate", origin, radius);
    if(distancesquared(origin, self.origin) < (radius * radius)) {
      break;
    }
  }
  self.stun_fx = 1;
  if(isdefined(level._equipment_emp_destroy_fx)) {
    playfx(level._equipment_emp_destroy_fx, self.origin + vectorscale((0, 0, 1), 5), (0, randomfloat(360), 0));
  }
  wait(0.15);
  self.attract_to_origin = 0;
  self zm_utility::deactivate_zombie_point_of_interest();
  wait(1);
  self detonate();
  wait(1);
  if(isdefined(model)) {
    model delete();
  }
  if(isdefined(actor)) {
    actor delete();
  }
  if(isdefined(self.damagearea)) {
    self.damagearea delete();
  }
  if(isdefined(self)) {
    self delete();
  }
}

function clone_player_angles(owner) {
  self endon("death");
  owner endon("bled_out");
  while (isdefined(self)) {
    self.angles = owner.angles;
    wait(0.05);
  }
}

function show_briefly(showtime) {
  self endon("show_owner");
  if(isdefined(self.show_for_time)) {
    self.show_for_time = showtime;
    return;
  }
  self.show_for_time = showtime;
  self setvisibletoall();
  while (self.show_for_time > 0) {
    self.show_for_time = self.show_for_time - 0.05;
    wait(0.05);
  }
  self setvisibletoallexceptteam(level.zombie_team);
  self.show_for_time = undefined;
}

function show_owner_on_attack(owner) {
  owner endon("hide_owner");
  owner endon("show_owner");
  self endon("explode");
  self endon("death");
  self endon("grenade_dud");
  owner.show_for_time = undefined;
  for (;;) {
    owner waittill("weapon_fired");
    owner thread show_briefly(0.5);
  }
}

function hide_owner(owner) {
  self notify("hide_owner");
  owner notify("hide_owner");
  owner endon("hide_owner");
  owner setperk("specialty_immunemms");
  owner.no_burning_sfx = 1;
  owner notify("stop_flame_sounds");
  owner setvisibletoallexceptteam(level.zombie_team);
  owner.hide_owner = 1;
  if(isdefined(level._effect["human_disappears"])) {
    playfx(level._effect["human_disappears"], owner.origin);
  }
  self thread show_owner_on_attack(owner);
  evt = self util::waittill_any_return("explode", "death", "grenade_dud", "hide_owner");
  println("" + evt);
  owner notify("show_owner");
  owner unsetperk("specialty_immunemms");
  if(isdefined(level._effect["human_disappears"])) {
    playfx(level._effect["human_disappears"], owner.origin);
  }
  owner.no_burning_sfx = undefined;
  owner setvisibletoall();
  owner.hide_owner = undefined;
  owner show();
}

function proximity_detonate(owner) {
  wait(1.5);
  if(!isdefined(self)) {
    return;
  }
  detonateradius = 96;
  explosionradius = detonateradius * 2;
  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - detonateradius), 4, detonateradius, detonateradius * 1.5);
  damagearea setexcludeteamfortrigger(owner.team);
  damagearea enablelinkto();
  damagearea linkto(self);
  self.damagearea = damagearea;
  while (isdefined(self)) {
    damagearea waittill("trigger", ent);
    if(isdefined(owner) && ent == owner) {
      continue;
    }
    if(isdefined(ent.team) && ent.team == owner.team) {
      continue;
    }
    self playsound("wpn_claymore_alert");
    dist = distance(self.origin, ent.origin);
    radiusdamage(self.origin + vectorscale((0, 0, 1), 12), explosionradius, 1, 1, owner, "MOD_GRENADE_SPLASH", level.w_beacon);
    if(isdefined(owner)) {
      self detonate(owner);
    } else {
      self detonate(undefined);
    }
    break;
  }
  if(isdefined(damagearea)) {
    damagearea delete();
  }
}

function player_throw_beacon(grenade, num_attractors, max_attract_dist, attract_dist_diff) {
  self endon("disconnect");
  self endon("starting_beacon_watch");
  if(isdefined(grenade)) {
    grenade endon("death");
    if(self laststand::player_is_in_laststand()) {
      if(isdefined(grenade.damagearea)) {
        grenade.damagearea delete();
      }
      grenade delete();
      return;
    }
    var_65f5946c = vectorscale((0, 0, 1), 8);
    grenade ghost();
    model = spawn("script_model", grenade.origin + var_65f5946c);
    model endon("weapon_beacon_timeout");
    model setmodel("wpn_t7_zmb_hd_g_strike_world");
    model useanimtree($zombie_beacon);
    model linkto(grenade, "", var_65f5946c);
    model.angles = grenade.angles;
    model thread beacon_cleanup(grenade);
    model.owner = self;
    clone = undefined;
    if(isdefined(level.beacon_dual_view) && level.beacon_dual_view) {
      model setvisibletoallexceptteam(level.zombie_team);
      clone = zm_clone::spawn_player_clone(self, vectorscale((0, 0, -1), 999), level.beacon_clone_weapon, undefined);
      model.simulacrum = clone;
      clone zm_clone::clone_animate("idle");
      clone thread clone_player_angles(self);
      clone notsolid();
      clone ghost();
    }
    grenade thread watch_for_dud(model, clone);
    info = spawnstruct();
    info.sound_attractors = [];
    grenade waittill("stationary");
    if(isdefined(level.grenade_planted)) {
      self thread[[level.grenade_planted]](grenade, model);
    }
    if(isdefined(grenade)) {
      if(isdefined(model)) {
        if(!(isdefined(grenade.backlinked) && grenade.backlinked)) {
          model unlink();
          model.origin = grenade.origin + var_65f5946c;
          model.angles = grenade.angles;
        }
      }
      if(isdefined(clone)) {
        clone forceteleport(grenade.origin, grenade.angles);
        clone thread hide_owner(self);
        grenade thread proximity_detonate(self);
        clone show();
        clone setinvisibletoall();
        clone setvisibletoteam(level.zombie_team);
      }
      grenade resetmissiledetonationtime();
      model clientfield::set("play_beacon_fx", 1);
      valid_poi = zm_utility::check_point_in_enabled_zone(grenade.origin, undefined, undefined);
      if(isdefined(level.check_valid_poi)) {
        valid_poi = grenade[[level.check_valid_poi]](valid_poi);
      }
      if(valid_poi) {
        grenade zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
        grenade.attract_to_origin = 1;
        grenade thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, attract_dist_diff);
        grenade thread zm_utility::wait_for_attractor_positions_complete();
        grenade thread do_beacon_sound(model, info);
        model thread wait_and_explode(grenade);
        model thread weapon_beacon_anims();
        model.time_thrown = gettime();
        while (isdefined(level.weapon_beacon_busy) && level.weapon_beacon_busy) {
          wait(0.1);
          continue;
        }
        if(level flag::get("three_robot_round") && level flag::get("fire_link_enabled")) {
          model thread start_artillery_launch_ee(grenade);
        } else {
          model thread start_artillery_launch_normal(grenade);
        }
        level.beacons[level.beacons.size] = grenade;
      } else {
        grenade.script_noteworthy = undefined;
        level thread grenade_stolen_by_sam(grenade, model, clone);
      }
    } else {
      grenade.script_noteworthy = undefined;
      level thread grenade_stolen_by_sam(grenade, model, clone);
    }
  }
}

function weapon_beacon_anims() {
  n_time = getanimlength( % zombie_beacon::o_zm_dlc5_zombie_homing_deploy);
  self animscripted("beacon_deploy", self.origin, self.angles, % zombie_beacon::o_zm_dlc5_zombie_homing_deploy);
  wait(n_time);
  if(isdefined(self)) {
    self animscripted("beacon_spin", self.origin, self.angles, % zombie_beacon::o_zm_dlc5_zombie_homing_spin);
  }
}

function grenade_stolen_by_sam(ent_grenade, ent_model, ent_actor) {
  if(!isdefined(ent_model)) {
    return;
  }
  direction = ent_model.origin;
  direction = (direction[1], direction[0], 0);
  if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0)) {
    direction = (direction[0], direction[1] * -1, 0);
  } else if(direction[0] < 0) {
    direction = (direction[0] * -1, direction[1], 0);
  }
  for (i = 0; i < level.players.size; i++) {
    if(isalive(level.players[i])) {
      level.players[i] playlocalsound(level.zmb_laugh_alias);
    }
  }
  playfxontag(level._effect["grenade_samantha_steal"], ent_model, "tag_origin");
  ent_model movez(60, 1, 0.25, 0.25);
  ent_model vibrate(direction, 1.5, 2.5, 1);
  ent_model waittill("movedone");
  if(isdefined(self.damagearea)) {
    self.damagearea delete();
  }
  ent_model delete();
  if(isdefined(ent_actor)) {
    ent_actor delete();
  }
  if(isdefined(ent_grenade)) {
    if(isdefined(ent_grenade.damagearea)) {
      ent_grenade.damagearea delete();
    }
    ent_grenade delete();
  }
}

function wait_for_attractor_positions_complete() {
  self waittill("attractor_positions_generated");
  self.attract_to_origin = 0;
}

function beacon_cleanup(parent) {
  while (true) {
    if(!isdefined(parent)) {
      if(isdefined(self) && (isdefined(self.dud) && self.dud)) {
        wait(6);
      }
      if(isdefined(self.simulacrum)) {
        self.simulacrum delete();
      }
      zm_utility::self_delete();
      return;
    }
    wait(0.05);
  }
}

function do_beacon_sound(model, info) {
  self.monk_scream_vox = 0;
  if(isdefined(level.grenade_safe_to_bounce)) {
    if(![
        [level.grenade_safe_to_bounce]
      ](self.owner, level.w_beacon)) {
      self.monk_scream_vox = 1;
    }
  }
  if(!self.monk_scream_vox && (!(isdefined(level.music_override) && level.music_override))) {
    if(isdefined(level.beacon_dual_view) && level.beacon_dual_view) {
      self playsoundtoteam("null", "allies");
    } else {
      self playsound("null");
    }
  }
  if(!self.monk_scream_vox) {
    self thread play_delayed_explode_vox();
  }
  self waittill("robot_artillery_barrage", position);
  level notify("grenade_exploded", position, 100, 5000, 450);
  beacon_index = -1;
  for (i = 0; i < level.beacons.size; i++) {
    if(!isdefined(level.beacons[i])) {
      beacon_index = i;
      break;
    }
  }
  if(beacon_index >= 0) {
    arrayremoveindex(level.beacons, beacon_index);
  }
  for (i = 0; i < info.sound_attractors.size; i++) {
    if(isdefined(info.sound_attractors[i])) {
      info.sound_attractors[i] notify("beacon_blown_up");
    }
  }
  self delete();
}

function play_delayed_explode_vox() {
  wait(6.5);
}

function get_thrown_beacon() {
  self endon("disconnect");
  self endon("starting_beacon_watch");
  while (true) {
    self waittill("grenade_fire", grenade, weapon);
    if(weapon == level.w_beacon) {
      grenade.use_grenade_special_long_bookmark = 1;
      grenade.grenade_multiattack_bookmark_count = 1;
      return grenade;
    }
    wait(0.05);
  }
}

function wait_and_explode(grenade) {
  self endon("beacon_missile_launch");
  grenade waittill("explode", position);
  self notify("weapon_beacon_timeout");
  if(isdefined(grenade)) {
    grenade notify("robot_artillery_barrage", self.origin);
  }
}

function start_artillery_launch_normal(grenade) {
  self endon("weapon_beacon_timeout");
  sp_giant_robot = undefined;
  while (!isdefined(sp_giant_robot)) {
    for (i = 0; i < 3; i++) {
      if(isdefined(level.a_giant_robots[i].is_walking) && level.a_giant_robots[i].is_walking) {
        if(!(isdefined(level.a_giant_robots[i].weap_beacon_firing) && level.a_giant_robots[i].weap_beacon_firing)) {
          sp_giant_robot = level.a_giant_robots[i];
          self thread artillery_fx_logic(sp_giant_robot, grenade);
          self notify("beacon_missile_launch");
          level.weapon_beacon_busy = 1;
          grenade.fuse_reset = 1;
          grenade.fuse_time = 100;
          grenade resetmissiledetonationtime(100);
          break;
        }
      }
    }
    wait(0.1);
  }
}

function start_artillery_launch_ee(grenade) {
  self endon("weapon_beacon_timeout");
  sp_giant_robot = undefined;
  n_index = 0;
  a_robot_index = [];
  a_robot_index[0] = 1;
  a_robot_index[1] = 0;
  a_robot_index[2] = 2;
  while (n_index < a_robot_index.size) {
    n_robot_num = a_robot_index[n_index];
    if(isdefined(level.a_giant_robots[n_robot_num].is_walking) && level.a_giant_robots[n_robot_num].is_walking) {
      if(!(isdefined(level.a_giant_robots[n_robot_num].weap_beacon_firing) && level.a_giant_robots[n_robot_num].weap_beacon_firing)) {
        sp_giant_robot = level.a_giant_robots[n_robot_num];
        self thread artillery_fx_logic_ee(sp_giant_robot, grenade);
        self notify("beacon_missile_launch");
        level.weapon_beacon_busy = 1;
        grenade.fuse_reset = 1;
        grenade.fuse_time = 100;
        grenade resetmissiledetonationtime(100);
        wait(2);
        n_index++;
      }
    } else {
      if(n_index == 0) {
        if(!level flag::get("three_robot_round")) {
          self thread start_artillery_launch_normal(grenade);
          break;
        }
      } else if(n_index > 0) {
        break;
      }
    }
    wait(0.1);
  }
  self thread artillery_barrage_logic(grenade, 1);
}

function artillery_fx_logic(sp_giant_robot, grenade) {
  sp_giant_robot.weap_beacon_firing = 1;
  level clientfield::set("play_launch_artillery_fx_robot_" + sp_giant_robot.giant_robot_id, 1);
  self thread homing_beacon_vo();
  wait(0.5);
  if(isdefined(sp_giant_robot)) {
    level clientfield::set("play_launch_artillery_fx_robot_" + sp_giant_robot.giant_robot_id, 0);
    wait(3);
    self thread artillery_barrage_logic(grenade);
    wait(1);
    sp_giant_robot.weap_beacon_firing = 0;
  }
}

function artillery_fx_logic_ee(sp_giant_robot, grenade) {
  sp_giant_robot.weap_beacon_firing = 1;
  sp_giant_robot playsound("zmb_homingbeacon_missiile_alarm");
  level clientfield::set("play_launch_artillery_fx_robot_" + sp_giant_robot.giant_robot_id, 1);
  self thread homing_beacon_vo();
  wait(0.5);
  if(isdefined(sp_giant_robot)) {
    level clientfield::set("play_launch_artillery_fx_robot_" + sp_giant_robot.giant_robot_id, 0);
  }
  wait(1);
  sp_giant_robot.weap_beacon_firing = 0;
}

function homing_beacon_vo() {
  if(isdefined(self.owner) && isplayer(self.owner)) {
    n_time = gettime();
    if(isdefined(self.time_thrown)) {
      if(n_time < (self.time_thrown + 3000)) {
        self.owner zm_audio::create_and_play_dialog("general", "use_beacon");
      }
    }
  }
}

function artillery_barrage_logic(grenade, b_ee = 0) {
  if(isdefined(b_ee) && b_ee) {
    a_v_land_offsets = self build_weap_beacon_landing_offsets_ee();
    a_v_start_offsets = self build_weap_beacon_start_offsets_ee();
    n_num_missiles = 15;
    n_clientfield = 2;
  } else {
    a_v_land_offsets = self build_weap_beacon_landing_offsets();
    a_v_start_offsets = self build_weap_beacon_start_offsets();
    n_num_missiles = 5;
    n_clientfield = 1;
  }
  self.a_v_land_spots = [];
  self.a_v_start_spots = [];
  for (i = 0; i < n_num_missiles; i++) {
    self.a_v_start_spots[i] = self.origin + a_v_start_offsets[i];
    self.a_v_land_spots[i] = self.origin + a_v_land_offsets[i];
    v_start_trace = self.a_v_start_spots[i] - vectorscale((0, 0, 1), 5000);
    trace = bullettrace(v_start_trace, self.a_v_land_spots[i], 0, undefined);
    self.a_v_land_spots[i] = trace["position"];
    wait(0.05);
  }
  for (i = 0; i < n_num_missiles; i++) {
    self clientfield::set("play_artillery_barrage", n_clientfield);
    self thread wait_and_do_weapon_beacon_damage(i);
    util::wait_network_frame();
    self clientfield::set("play_artillery_barrage", 0);
    if(i == 0) {
      wait(1);
      continue;
    }
    wait(0.25);
  }
  level thread allow_beacons_to_be_targeted_by_giant_robot();
  wait(6);
  grenade notify("robot_artillery_barrage", self.origin);
}

function allow_beacons_to_be_targeted_by_giant_robot() {
  wait(3);
  level.weapon_beacon_busy = 0;
}

function build_weap_beacon_landing_offsets() {
  a_offsets = [];
  a_offsets[0] = (0, 0, 0);
  a_offsets[1] = vectorscale((-1, 1, 0), 72);
  a_offsets[2] = vectorscale((1, 1, 0), 72);
  a_offsets[3] = vectorscale((1, -1, 0), 72);
  a_offsets[4] = vectorscale((-1, -1, 0), 72);
  return a_offsets;
}

function build_weap_beacon_start_offsets() {
  a_offsets = [];
  a_offsets[0] = vectorscale((0, 0, 1), 8500);
  a_offsets[1] = (-6500, 6500, 8500);
  a_offsets[2] = (6500, 6500, 8500);
  a_offsets[3] = (6500, -6500, 8500);
  a_offsets[4] = (-6500, -6500, 8500);
  return a_offsets;
}

function build_weap_beacon_landing_offsets_ee() {
  a_offsets = [];
  a_offsets[0] = (0, 0, 0);
  a_offsets[1] = vectorscale((-1, 1, 0), 72);
  a_offsets[2] = vectorscale((1, 1, 0), 72);
  a_offsets[3] = vectorscale((1, -1, 0), 72);
  a_offsets[4] = vectorscale((-1, -1, 0), 72);
  a_offsets[5] = vectorscale((-1, 1, 0), 72);
  a_offsets[6] = vectorscale((1, 1, 0), 72);
  a_offsets[7] = vectorscale((1, -1, 0), 72);
  a_offsets[8] = vectorscale((-1, -1, 0), 72);
  a_offsets[9] = vectorscale((-1, 1, 0), 72);
  a_offsets[10] = vectorscale((1, 1, 0), 72);
  a_offsets[11] = vectorscale((1, -1, 0), 72);
  a_offsets[12] = vectorscale((-1, -1, 0), 72);
  a_offsets[13] = vectorscale((-1, 1, 0), 72);
  a_offsets[14] = vectorscale((1, 1, 0), 72);
  return a_offsets;
}

function build_weap_beacon_start_offsets_ee() {
  a_offsets = [];
  a_offsets[0] = vectorscale((0, 0, 1), 8500);
  a_offsets[1] = (-6500, 6500, 8500);
  a_offsets[2] = (6500, 6500, 8500);
  a_offsets[3] = (6500, -6500, 8500);
  a_offsets[4] = (-6500, -6500, 8500);
  a_offsets[5] = (-6500, 6500, 8500);
  a_offsets[6] = (6500, 6500, 8500);
  a_offsets[7] = (6500, -6500, 8500);
  a_offsets[8] = (-6500, -6500, 8500);
  a_offsets[9] = (-6500, 6500, 8500);
  a_offsets[10] = (6500, 6500, 8500);
  a_offsets[11] = (6500, -6500, 8500);
  a_offsets[12] = (-6500, -6500, 8500);
  a_offsets[13] = (-6500, 6500, 8500);
  a_offsets[14] = (6500, 6500, 8500);
  return a_offsets;
}

function wait_and_do_weapon_beacon_damage(index) {
  wait(3);
  v_damage_origin = self.a_v_land_spots[index];
  level.n_weap_beacon_zombie_thrown_count = 0;
  a_zombies_to_kill = [];
  a_zombies = getaispeciesarray("axis", "all");
  foreach(zombie in a_zombies) {
    n_distance = distance(zombie.origin, v_damage_origin);
    if(n_distance <= 200) {
      n_damage = math::linear_map(n_distance, 200, 0, 7000, 8000);
      if(n_damage >= zombie.health) {
        a_zombies_to_kill[a_zombies_to_kill.size] = zombie;
        continue;
      }
      zombie thread set_beacon_damage();
      zombie dodamage(n_damage, zombie.origin, self.owner, self.owner, "none", "MOD_GRENADE_SPLASH", 0, level.w_beacon);
    }
  }
  if(index == 0) {
    radiusdamage(self.origin + vectorscale((0, 0, 1), 12), 10, 1, 1, self.owner, "MOD_GRENADE_SPLASH", level.w_beacon);
    self ghost();
    self stopanimscripted(0);
  }
  level thread weap_beacon_zombie_death(self, a_zombies_to_kill);
  self thread weap_beacon_rumble();
}

function weap_beacon_zombie_death(model, a_zombies_to_kill) {
  n_interval = 0;
  for (i = 0; i < a_zombies_to_kill.size; i++) {
    zombie = a_zombies_to_kill[i];
    if(!isdefined(zombie) || !isalive(zombie)) {
      continue;
    }
    zombie thread set_beacon_damage();
    zombie dodamage(zombie.health, zombie.origin, model.owner, model.owner, "none", "MOD_GRENADE_SPLASH", 0, level.w_beacon);
    n_interval++;
    zombie thread weapon_beacon_launch_ragdoll();
    if(n_interval >= 4) {
      util::wait_network_frame();
      n_interval = 0;
    }
  }
}

function weapon_beacon_launch_ragdoll() {
  if(isdefined(self.is_mechz) && self.is_mechz) {
    return;
  }
  if(isdefined(self.is_giant_robot) && self.is_giant_robot) {
    return;
  }
  if(level.n_weap_beacon_zombie_thrown_count >= 5) {
    return;
  }
  level.n_weap_beacon_zombie_thrown_count++;
  if(isdefined(level.ragdoll_limit_check) && ![
      [level.ragdoll_limit_check]
    ]()) {
    level thread weap_beacon_gib(self);
    return;
  }
  self startragdoll();
  n_x = randomintrange(50, 150);
  n_y = randomintrange(50, 150);
  if(math::cointoss()) {
    n_x = n_x * -1;
  }
  if(math::cointoss()) {
    n_y = n_y * -1;
  }
  v_launch = (n_x, n_y, randomintrange(75, 250));
  self launchragdoll(v_launch);
}

function weap_beacon_gib(ai_zombie) {
  a_gib_ref = [];
  a_gib_ref[0] = level._zombie_gib_piece_index_all;
  ai_zombie gib("normal", a_gib_ref);
}

function weap_beacon_rumble() {
  a_players = getplayers();
  foreach(player in a_players) {
    if(isalive(player) && isdefined(player)) {
      if(distance2dsquared(player.origin, self.origin) < 250000) {
        player thread execute_weap_beacon_rumble();
      }
    }
  }
}

function execute_weap_beacon_rumble() {
  self endon("death");
  self endon("disconnect");
  self clientfield::set_to_player("player_rumble_and_shake", 3);
  util::wait_network_frame();
  self clientfield::set_to_player("player_rumble_and_shake", 0);
}

function set_beacon_damage() {
  self endon("death");
  self.set_beacon_damage = 1;
  wait(0.05);
  self.set_beacon_damage = 0;
}

function function_45216da2() {
  level thread setup_devgui_func("ZM/Weapons/Offhand/Give Beacon", "give_beacon", 4, & function_eeb65596);
}

function private setup_devgui_func(str_devgui_path, str_dvar, n_value, func, n_base_value = -1) {
  setdvar(str_dvar, n_base_value);
  adddebugcommand(((((("devgui_cmd \"" + str_devgui_path) + "\" \"") + str_dvar) + " ") + n_value) + "\"\n");
  while (true) {
    n_dvar = getdvarint(str_dvar);
    if(n_dvar > n_base_value) {
      [
        [func]
      ](n_dvar);
      setdvar(str_dvar, n_base_value);
    }
    util::wait_network_frame();
  }
}

function function_eeb65596(n_player_index) {
  players = getplayers();
  foreach(player in players) {
    player takeweapon(level.w_beacon);
    player zm_weapons::weapon_give(level.w_beacon);
  }
}