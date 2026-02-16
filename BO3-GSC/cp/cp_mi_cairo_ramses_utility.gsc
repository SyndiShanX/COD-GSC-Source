/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_cairo_ramses_utility.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_debug;
#using scripts\cp\_load;
#using scripts\cp\_objectives;
#using scripts\cp\_oed;
#using scripts\cp\_skipto;
#using scripts\cp\_spawn_manager;
#using scripts\cp\_util;
#using scripts\shared\ai\robot_phalanx;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\colors_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace ramses_util;

function autoexec __init__sytem__() {
  system::register("ramses_util", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "ramses_sun_color", 1, 1, "int");
  clientfield::register("toplayer", "dni_eye", 1, 1, "int");
  clientfield::register("scriptmover", "hide_graphic_content", 1, 1, "counter");
}

function is_demo() {
  return getdvarint("is_demo_build", 0);
}

function function_22e1a261() {
  exploder::exploder("transition");
  level set_lighting_state_time_shift_2();
  getent("lgt_shadow_block_trans", "targetname") show();
  level clientfield::set("alley_fog_banks", 1);
}

function prepare_players_for_demo_warp() {
  foreach(player in level.players) {
    if(player isinvehicle()) {
      vh_occupied = player getvehicleoccupied();
      n_seat = vh_occupied getoccupantseat(player);
      vh_occupied usevehicle(player, n_seat);
    }
  }
}

function set_low_ready_movement(b_enable = 1) {
  if(!isarray(self)) {
    a_e_players = array(self);
  } else {
    a_e_players = self;
  }
  foreach(e_player in a_e_players) {
    e_player util::set_low_ready(b_enable);
  }
}

function function_1903e7dc() {
  hidemiscmodels("arena_billboard_static2");
  hidemiscmodels("arena_billboard_02_static2");
  hidemiscmodels("cinema_collapse_static2");
  hidemiscmodels("quadtank_statue_static2");
  hidemiscmodels("rocket_static2");
  hidemiscmodels("glass_building_static2");
  hidemiscmodels("wall_collapse_static2");
  function_2f9e262a();
}

function function_2f9e262a() {
  scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_bundle", &function_1c347e72, "init", "arena_billboard_static1");
  scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_bundle", &function_a72c2dda, "done", "arena_billboard_static2");
  scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_1c347e72, "init", "arena_billboard_02_static1");
  scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_a72c2dda, "done", "arena_billboard_02_static2");
  scene::add_scene_func("p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_1c347e72, "init", "cinema_collapse_static1");
  scene::add_scene_func("p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_a72c2dda, "done", "cinema_collapse_static2");
  scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_1c347e72, "init", "quadtank_statue_static1");
  scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_a72c2dda, "done", "quadtank_statue_static2");
  scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle", &function_1c347e72, "init", "rocket_static1");
  scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle", &function_a72c2dda, "done", "rocket_static2");
  scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &function_1c347e72, "init", "glass_building_static1");
  scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &function_a72c2dda, "done", "glass_building_static2");
  scene::add_scene_func("p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_1c347e72, "init", "wall_collapse_static1");
  scene::add_scene_func("p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_a72c2dda, "done", "wall_collapse_static2");
}

function function_1c347e72(a_ents, str_targetname) {
  hidemiscmodels(str_targetname);
}

function function_a72c2dda(a_ents, str_targetname) {
  showmiscmodels(str_targetname);
  foreach(ent in a_ents) {
    if(isDefined(ent) && !issentient(ent)) {
      ent delete();
    }
  }
}

function function_a0a9f927() {
  var_3ecc15f7 = getEntArray("recovery_fan", "targetname");
  foreach(var_76185ee4 in var_3ecc15f7) {
    var_76185ee4 thread rotate_fan(2);
    var_76185ee4 thread function_f81a38c8();
    wait(randomfloatrange(0.5, 1.5));
  }
}

function rotate_fan(var_5dbde88f) {
  self endon("hash_fb28e86c");
  while(true) {
    self rotateyaw(180, var_5dbde88f / 2);
    wait(var_5dbde88f / 2);
  }
}

function function_f81a38c8() {
  t_damage = getent(self.target, "targetname");
  t_damage waittill("trigger");
  self notify("hash_fb28e86c");
  self waittill("rotatedone");
  self rotateto(self.angles + vectorscale((0, 1, 0), 15), 1.25, 0.05, 0.75);
}

function function_e7ebe596(b_on = 1) {}

function delete_ent_array(str_value, str_key = "targetname") {
  level thread _delete_ent_array(str_value, str_key);
}

function _delete_ent_array(str_value, str_key) {
  a_ents = getEntArray(str_value, str_key);
  foreach(i, ent in a_ents) {
    if(i % 3) {
      wait(0.05);
    }
    if(isDefined(ent)) {
      ent delete();
    }
  }
}

function init_dead_turrets(b_fake_rs_turrets = 0) {
  level.a_e_dead_turrets_non_controllable = [];
  a_sp_turret_non_controllable = getEntArray("dead_turrets_non_controllable", "targetname");
  if(b_fake_rs_turrets) {
    foreach(sp_turret in a_sp_turret_non_controllable) {
      m_turret = spawn("script_model", sp_turret.origin);
      m_turret.angles = sp_turret.angles;
      m_turret setModel("veh_t7_turret_dead_system_ramses");
    }
  } else {
    foreach(sp_turret in a_sp_turret_non_controllable) {
      e_dead_turret = spawner::simple_spawn_single(sp_turret);
      level.a_e_dead_turrets_non_controllable[level.a_e_dead_turrets_non_controllable.size] = e_dead_turret;
      e_dead_turret.takedamage = 0;
    }
  }
  level.a_e_dead_turrets = [];
  a_sp_turret = getEntArray("dead_turrets", "script_noteworthy");
  foreach(sp_turret in a_sp_turret) {
    e_dead_turret = spawner::simple_spawn_single(sp_turret);
    level.a_e_dead_turrets[level.a_e_dead_turrets.size] = e_dead_turret;
    e_dead_turret.dead_turret_owned = 0;
    e_dead_turret.takedamage = 0;
    if(isDefined(sp_turret.script_int)) {
      assert(isDefined(e_dead_turret.script_int), "");
      e_dead_turret.script_int = sp_turret.script_int;
    }
  }
  level.a_e_all_dead_turrets = arraycombine(level.a_e_dead_turrets, level.a_e_dead_turrets_non_controllable, 1, 0);
  level flag::set("dead_turrets_initialized");
}

function delete_all_dead_turrets() {
  level notify("stop_rs_dead_turret_vignettes");
  if(isDefined(level.a_e_all_dead_turrets)) {
    foreach(e_turret in level.a_e_all_dead_turrets) {
      e_turret delete();
    }
  }
  level.a_e_dead_turrets_non_controllable = undefined;
  level.a_e_dead_turrets = undefined;
  level.a_e_all_dead_turrets = undefined;
}

function hide_ents(b_connect = 0) {
  foreach(e in self) {
    e hide();
  }
  if(b_connect) {
    foreach(e in self) {
      e connectpaths();
      wait(0.05);
    }
  }
}

function show_ents(b_disconnect = 0) {
  foreach(e in self) {
    e show();
  }
  if(b_disconnect) {
    foreach(e in self) {
      if(e.targetname !== "path_neutral") {
        if(isDefined(e.script_noteworthy) && e.script_noteworthy == "connect_paths") {
          e connectpaths();
        } else if(e.classname === "script_brushmodel" && e.script_noteworthy !== "do_not_disconnect" || (e.classname === "script_model" && (e.model == "p7_cai_stacking_cargo_crate" || e.model == "veh_t7_mil_vtol_dropship_troopcarrier"))) {
          e disconnectpaths();
        }
      }
      wait(0.05);
    }
  }
}

function spawn_from_structs() {
  n_count = 0;
  foreach(struct in self) {
    if(isDefined(struct.model)) {
      new_ent = spawn("script_model", struct.origin);
      new_ent.angles = struct.angles;
      new_ent setModel(struct.model);
      n_count++;
      if((n_count % 10) == 0) {
        util::wait_network_frame();
      }
    }
  }
}

function make_not_solid(b_moving) {
  if(isarray(self)) {
    a_e = self;
  } else {
    a_e = array(self);
  }
  foreach(e in a_e) {
    e notsolid();
  }
  if(isDefined(b_moving)) {
    foreach(e in a_e) {
      e setmovingplatformenabled(b_moving);
    }
  }
}

function make_solid(b_moving) {
  if(isarray(self)) {
    a_e = self;
  } else {
    a_e = array(self);
  }
  foreach(e in a_e) {
    e solid();
  }
  if(isDefined(b_moving)) {
    foreach(e in a_e) {
      e setmovingplatformenabled(b_moving);
    }
  }
}

function set_visible(str_ent, b_visible = 1) {
  a_e_invis = getEntArray(str_ent, "targetname");
  a_e_players = self;
  if(!isarray(self)) {
    a_e_players = array(self);
  }
  if(b_visible) {
    foreach(e_player in a_e_players) {
      foreach(e_invis in a_e_invis) {
        e_invis setvisibletoplayer(e_player);
      }
    }
  } else {
    foreach(e_player in a_e_players) {
      foreach(e_invis in a_e_invis) {
        e_invis setinvisibletoplayer(e_player);
      }
    }
  }
}

function give_spike_launcher(b_force_switch = 1, b_hint = 1) {
  if(flagsys::get("mobile_armory_in_use")) {
    return;
  }
  a_e_players = self;
  if(!isarray(a_e_players)) {
    a_e_players = array(a_e_players);
  }
  w_spike_launcher = getweapon("spike_launcher");
  foreach(e_player in a_e_players) {
    e_player giveweapon(w_spike_launcher);
    e_player setweaponammoclip(w_spike_launcher, w_spike_launcher.clipsize);
    e_player givemaxammo(w_spike_launcher);
    if(b_force_switch) {
      e_player switchtoweapon(w_spike_launcher);
    }
    if(b_hint) {
      e_player thread spike_launcher_tutorial_hint(w_spike_launcher);
    }
  }
}

function spike_launcher_tutorial_hint(w_spike_launcher) {
  self endon("death");
  w_current = self getcurrentweapon();
  while(!self flag::get("spike_launcher_tutorial_complete")) {
    if(w_current == w_spike_launcher) {
      self _wait_till_tutorial_complete(w_spike_launcher);
    } else {
      self waittill("weapon_change_complete", w_current);
    }
  }
}

function _wait_till_tutorial_complete(w_spike_launcher) {
  self endon("death");
  self endon("detonate");
  self endon("hash_f4dfb01b");
  self waittill("weapon_fired", w_current);
  if(w_current == w_spike_launcher) {
    wait(2);
    self thread wait_till_detonate_button_pressed();
    self util::waittill_any("detonate", "last_stand_detonate");
  }
}

function wait_till_detonate_button_pressed() {
  self endon("death");
  self notify("wait_till_detonate_button_pressed");
  self endon("wait_till_detonate_button_pressed");
  if(isDefined(self.var_f30613a1)) {
    self util::hide_hint_text();
    wait(0.05);
  }
  w_spike_launcher = getweapon("spike_launcher");
  self util::show_hint_text(&"CP_MI_CAIRO_RAMSES_SPIKE_LAUNCHER_DETONATE", 1, "spike_launcher_tutorial_complete", 20);
  self.var_99c7680e = 1;
  self util::waittill_any_timeout(20, "detonate", "last_stand_detonate");
  self flag::set("spike_launcher_tutorial_complete");
  self.var_f30613a1 = undefined;
}

function function_780e57a1() {
  level endon("all_weak_points_destroyed");
  self endon("detonate");
  self endon("hash_f4dfb01b");
  self endon("death");
  w_current = self getcurrentweapon();
  w_spike_launcher = getweapon("spike_launcher");
  while(!self flag::get("spike_launcher_tutorial_complete")) {
    self waittill("weapon_change_complete", w_current);
    if(w_current != w_spike_launcher) {
      self util::hide_hint_text();
    } else {
      self util::show_hint_text(&"CP_MI_CAIRO_RAMSES_SPIKE_LAUNCHER_DETONATE", 1, "spike_launcher_tutorial_complete", 20);
    }
  }
}

function take_spike_launcher() {
  a_e_players = self;
  if(!isarray(a_e_players)) {
    a_e_players = array(a_e_players);
  }
  w_spike_launcher = getweapon("spike_launcher");
  foreach(e_player in a_e_players) {
    if(e_player hasweapon(w_spike_launcher)) {
      e_player takeweapon(w_spike_launcher);
    }
  }
}

function scale_spawn_manager_by_player_count(n_count_per_player, n_active_max_per_player, n_active_min_per_player) {
  b_something_to_scale = isDefined(n_count_per_player) || isDefined(n_active_max_per_player) || isDefined(n_active_min_per_player);
  assert(isDefined(b_something_to_scale) && b_something_to_scale, (("" + self.targetname) + "") + self.origin);
  if(isDefined(n_count_per_player)) {
    self.count = get_num_scaled_by_player_count(self.count, n_count_per_player);
  }
  if(isDefined(n_active_max_per_player)) {
    self.sm_active_count_max = get_num_scaled_by_player_count(self.sm_active_count_max, n_active_max_per_player);
  }
  if(isDefined(n_active_min_per_player)) {
    self.sm_active_count_min = get_num_scaled_by_player_count(self.sm_active_count_min, n_active_min_per_player);
  }
}

function get_num_scaled_by_player_count(n_base, n_add_per_player) {
  n_num = n_base - n_add_per_player;
  foreach(e_player in level.players) {
    n_num = n_num + n_add_per_player;
  }
  return n_num;
}

function get_random_player() {
  e_player = self[0];
  if(self.size > 1) {
    e_player = self[randomint(self.size)];
  }
  return e_player;
}

function get_not_in_laststand() {
  a_e_players_up = [];
  for(i = 0; i < level.players.size; i++) {
    if(!level.players[i] laststand::player_is_in_laststand()) {
      if(!isDefined(a_e_players_up)) {
        a_e_players_up = [];
      } else if(!isarray(a_e_players_up)) {
        a_e_players_up = array(a_e_players_up);
      }
      a_e_players_up[a_e_players_up.size] = level.players[i];
    }
  }
  return a_e_players_up;
}

function kill_players(str_notify) {
  level endon(str_notify);
  while(true) {
    self waittill("trigger", e_toucher);
    for(i = 0; i < level.players.size; i++) {
      if(e_toucher == level.players[i] && !e_toucher laststand::player_is_in_laststand()) {
        e_toucher dodamage(e_toucher.health + 100, e_toucher.origin);
      }
    }
    wait(1);
  }
}

function wait_till_no_players_looking_at() {
  while(true) {
    n_look_count = 0;
    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] util::is_looking_at(self)) {
        n_look_count++;
      }
    }
    if(n_look_count == 0) {
      return;
    }
    wait(0.25);
  }
}

function track_player(str_endon, n_radius = 256) {
  self endon("death");
  if(isDefined(str_endon)) {
    level endon(str_endon);
  }
  self.goalradius = n_radius;
  while(true) {
    a_e_players_up = get_not_in_laststand();
    e_prey = a_e_players_up get_random_player();
    while(isDefined(e_prey) && !e_prey laststand::player_is_in_laststand()) {
      self setgoal(e_prey getorigin());
      wait(randomfloatrange(2, 4));
    }
    wait(0.15);
  }
}

function ambient_spawns(str_spawners, str_key = "targetname", n_spawners = a_spawners.size, t_cleanup, str_endon, n_next_wave_timeout) {
  level endon(str_endon);
  a_e_ambients = [];
  a_spawners = getEntArray(str_spawners, str_key);
  t_cleanup thread ambient_spawns_cleanup(str_endon);
  while(true) {
    a_spawners = array::randomize(a_spawners);
    for(i = 0; i < n_spawners; i++) {
      e_ambient = a_spawners[i] spawner::spawn();
      wait(0.05);
      if(isalive(e_ambient)) {
        if(isai(e_ambient)) {
          if(!isDefined(a_e_ambients)) {
            a_e_ambients = [];
          } else if(!isarray(a_e_ambients)) {
            a_e_ambients = array(a_e_ambients);
          }
          a_e_ambients[a_e_ambients.size] = e_ambient;
          e_ambient ai::set_ignoreall(1);
          e_ambient.goalradius = 8;
          continue;
        }
        if(isvehicle(e_ambient)) {
          nd_spline = getvehiclenode(e_ambient.target, "targetname");
          e_ambient thread vehicle::get_on_and_go_path(nd_spline);
        }
      }
    }
    array::wait_till(a_e_ambients, "death", n_next_wave_timeout);
  }
}

function ambient_spawns_cleanup(str_endon) {
  level endon(str_endon);
  while(true) {
    self waittill("trigger", e_ambient);
    if(isDefined(e_ambient)) {
      if(isai(e_ambient)) {
        e_ambient delete();
      } else {
        e_ambient.delete_on_death = 1;
        e_ambient notify("death");
        if(!isalive(e_ambient)) {
          e_ambient delete();
        }
      }
    }
  }
}

function spawn_phalanx(str_phalanx, str_formation, n_remaining_to_disperse, b_scatter = 0, n_timeout_scatter = 0, str_notify_scatter, b_rush_on_scatter = 0, str_rusher_key, str_rusher_value, var_42e6f5b4) {
  v_start = struct::get(str_phalanx + "_start").origin;
  v_end = struct::get(str_phalanx + "_end").origin;
  o_phalanx = new robotphalanx();
  [[o_phalanx]] - > initialize(str_formation, v_start, v_end, n_remaining_to_disperse, var_42e6f5b4);
  if(isDefined(str_notify_scatter)) {
    level waittill(str_notify_scatter);
  }
  wait(n_timeout_scatter);
  if(b_scatter && o_phalanx.scattered_ == 0) {
    o_phalanx robotphalanx::scatterphalanx();
  }
  if(b_rush_on_scatter) {
    while(isDefined(o_phalanx) && o_phalanx.scattered_ == 0) {
      wait(0.25);
    }
    make_rushers(str_rusher_key, str_rusher_value, get_num_scaled_by_player_count(3, 1));
  }
}

function make_rushers(str_key, str_value = "targetname", n_max, n_min) {
  a_ai_robots = getEntArray(str_key, str_value);
  a_ai_robots = array::randomize(a_ai_robots);
  n_rushers = a_ai_robots.size;
  if(isDefined(n_max)) {
    n_rushers = n_max;
  }
  if(isDefined(n_min)) {
    n_rushers = randomintrange(n_min, n_rushers + 1);
  }
  for(i = 0; i < n_rushers; i++) {
    if(isalive(a_ai_robots[i])) {
      a_ai_robots[i] ai::set_behavior_attribute("move_mode", "rusher");
    }
  }
}

function flag_then_func(str_flag, func) {
  self flag::wait_till(str_flag);
  self thread[[func]]();
}

function delete_all_non_hero_ai() {
  a_friendly = getaiteamarray("allies");
  foreach(ai in a_friendly) {
    if(!isinarray(level.heroes, ai)) {
      ai delete();
    }
  }
  a_enemy = getaiteamarray("axis");
  foreach(ai in a_enemy) {
    ai delete();
  }
}

function wait_till_flag_then_play(str_flag, str_scene, n_delay = 0, n_wait = 0, str_flag_cleanup, str_endon) {
  if(isDefined(str_endon)) {
    level endon(str_endon);
  }
  level flag::wait_till(str_flag);
  wait(n_delay);
  level thread scene::play(str_scene, "targetname");
  if(n_wait > 0 || isDefined(str_flag_cleanup)) {
    if(isDefined(str_flag_cleanup)) {
      level flag::wait_till(str_flag_cleanup);
    }
    wait(n_wait);
    level scene::stop(str_scene, "targetname", 1);
  }
}

function play_scene_on_notify(str_scene, str_notify) {
  assert(isDefined(str_scene), "");
  assert(isDefined(str_notify), "");
  self waittill(str_notify);
  self scene::play(str_scene);
}

function skipto_notetrack_time_in_animation(anim_name, str_scene, str_notetrack) {
  a_notetracks = getnotetracktimes(anim_name, str_notetrack);
  assert(a_notetracks.size, ((("" + str_scene) + "") + str_notetrack) + "");
  n_time = a_notetracks[0];
  self thread scene::skipto_end(str_scene, undefined, undefined, n_time);
}

function function_3bc57aa8(a_ents, b_enable = 1) {
  if(isDefined(level.ai_khalil)) {
    level.ai_khalil sethighdetail(b_enable);
  }
  if(isDefined(level.ai_hendricks)) {
    level.ai_hendricks sethighdetail(b_enable);
  }
  if(isDefined(level.ai_rachel)) {
    level.ai_rachel sethighdetail(b_enable);
  }
}

function enable_nodes(str_key, str_val = "targetname", b_enable = 1) {
  a_nodes = getnodearray(str_key, str_val);
  foreach(nd_node in a_nodes) {
    setenablenode(nd_node, b_enable);
  }
}

function link_traversals(str_key, str_val, b_link = 1) {
  a_nd = getnodearray(str_key, str_val);
  if(b_link) {
    foreach(nd in a_nd) {
      linktraversal(nd);
    }
  } else {
    foreach(nd in a_nd) {
      unlinktraversal(nd);
    }
  }
}

function function_508a129e(str_notify, n_time, var_45778f27 = 1) {
  self notify("hash_5a334c0f");
  self endon("death");
  self endon("hash_5a334c0f");
  level flag::wait_till("intro_igc_done");
  w_spike_launcher = getweapon("spike_launcher");
  while(self getcurrentweapon() == w_spike_launcher) {
    wait(0.2);
  }
  self util::show_hint_text(&"COOP_EQUIP_SPIKE_LAUNCHER", 0, str_notify, n_time);
  while(var_45778f27 == 0) {
    self util::waittill_any("wp_01_destroyed", "weapon_change_complete");
    if(self getcurrentweapon() == w_spike_launcher || level flag::get("wp_01_destroyed")) {
      self notify(str_notify);
      var_45778f27 = 1;
    } else {
      wait(0.1);
    }
  }
}

function has_weapon(w_has) {
  a_w_weapons = self getweaponslist();
  foreach(w in a_w_weapons) {
    if(w == w_has) {
      return true;
    }
  }
  return false;
}

function is_using_weapon(str_weapon) {
  return self getcurrentweapon() == getweapon(str_weapon);
}

function debug_linked(e) {
  self endon("death");
  e endon("death");
  while(true) {
    line(e.origin, self.origin, (1, 0, 0), 0.1);
    debug::drawarrow(self.origin, self.angles);
    wait(0.05);
  }
}

function draw_line_to_target(target, n_timer, str_start_tag) {
  self endon("death");
  target endon("death");
  n_timer = gettime() + (n_timer * 1000);
  while(gettime() < n_timer) {
    v_start_point = self.origin;
    if(isDefined(str_start_tag)) {
      v_start_point = self gettagorigin(str_start_tag);
    }
    line(v_start_point, target.origin, (1, 0, 0), 0.1);
    debug::drawarrow(target.origin, target.angles);
    wait(0.05);
  }
}

function debug_link_probe(e_probe) {
  while(isDefined(e_probe) && isDefined(self)) {
    line(e_probe.origin, self.origin, (1, 0, 0), 0.1);
    debug::debug_sphere(e_probe.origin, 16, (1, 0, 0), 0.5, 1);
    debug::drawarrow(self.origin, self.angles);
    debug::drawarrow(e_probe.origin, e_probe.angles);
    wait(0.05);
  }
}

function arena_defend_flak_exploders() {
  exploder::exploder("exploder_flak_arena_defend");
  level flag::wait_till("flak_arena_defend_stop");
  exploder::exploder_stop("exploder_flak_arena_defend");
}

function alley_flak_exploder() {
  exploder::exploder("exploder_flak_alley");
  level flag::wait_till("flak_alley_stop");
  exploder::exploder_stop("exploder_flak_alley");
}

function ambient_walk_fx_exploder(b_on = 1) {
  if(b_on) {
    exploder::exploder("fx_exploder_station_ambient_pre_collapse");
  } else {
    exploder::exploder_stop("fx_exploder_station_ambient_pre_collapse");
  }
}

function arena_defend_sinkhole_exploders() {
  exploder::exploder("fx_exploder_turn_off_collapse");
  level flag::wait_till("sinkhole_charges_detonated");
  wait(1.5);
  exploder::exploder_stop("fx_exploder_turn_off_collapse");
}

function set_lighting_state_on_spawn() {
  util::wait_network_frame();
  if(isDefined(level.lighting_state_ramses)) {
    switch (level.lighting_state_ramses) {
      case 1: {
        self set_lighting_state_time_shift_1();
        break;
      }
      case 2: {
        self set_lighting_state_time_shift_2();
        break;
      }
      case 3: {
        self set_lighting_state_start();
        break;
      }
    }
  }
}

function set_lighting_state_time_shift_1() {
  level.lighting_state_ramses = 1;
  self util::set_lighting_state(0);
  self set_sun_color(1);
}

function set_lighting_state_time_shift_2() {
  level.lighting_state_ramses = 2;
  self util::set_lighting_state(2);
  self set_sun_color(0);
}

function set_lighting_state_start() {
  level.lighting_state_ramses = 3;
  self util::set_lighting_state(3);
  self set_sun_color(0);
}

function set_sun_color(n_value) {
  if(self == level) {
    foreach(player in level.players) {
      player set_sun_color(n_value);
    }
  } else {
    if(isPlayer(self)) {
      self clientfield::set_to_player("ramses_sun_color", n_value);
    } else {
      assertmsg("");
    }
  }
}

function light_shift_think(str_trigger_targetname, str_level_endon, func_on_trigger) {
  assert(isDefined(str_trigger_targetname), "");
  assert(isDefined(str_level_endon), "");
  assert(isDefined(func_on_trigger), "");
  level endon(str_level_endon);
  t_light_shift = getent(str_trigger_targetname, "targetname");
  assert(isDefined(t_light_shift), ("" + str_trigger_targetname) + "");
  while(true) {
    t_light_shift waittill("trigger", e_player);
    if(isDefined(e_player) && isPlayer(e_player)) {
      e_player[[func_on_trigger]]();
    }
  }
}

function function_eabc6e2f() {
  level clientfield::set("turn_on_rotating_fxanim_lights", 1);
  exploder::exploder("lgt_emergency");
  a_lighting_ents = getEntArray("lgt_tent_probe", "script_noteworthy");
  foreach(ent in a_lighting_ents) {
    if(ent.classname == "reflection_probe") {
      ent.origin = ent.origin - vectorscale((0, 0, 1), 5000);
      continue;
    }
    ent delete();
  }
}

function turret_pickup_think(s_obj) {
  self endon("death");
  waittillframeend();
  w_hero = getweapon("lmg_light");
  t_pickup = spawn("trigger_radius", self.origin + vectorscale((0, 0, 1), 24), 0, s_obj.radius, 128);
  t_pickup.targetname = "turret_pickup_trig";
  t_pickup.script_objective = "vtol_ride";
  t_pickup triggerignoreteam();
  self thread turret_pickup_hint(t_pickup, w_hero);
  while(true) {
    t_pickup waittill("trigger", e_player);
    if(isalive(e_player)) {
      if(e_player turret_pickup_button_pressed() && !e_player has_weapon(w_hero)) {
        var_73a38d53 = self getseatoccupant(0);
        if(isDefined(var_73a38d53)) {
          if(var_73a38d53 == e_player) {
            self usevehicle(e_player, 0);
          } else {
            continue;
          }
        }
        e_player giveweapon(w_hero);
        e_player switchtoweapon(w_hero);
        level notify("turret_picked_up");
        break;
      }
    }
  }
  self.delete_on_death = 1;
  self notify("death");
  if(!isalive(self)) {
    self delete();
  }
  t_pickup delete();
}

function turret_pickup_hint(t_pickup, w_hero) {
  t_pickup endon("death");
  while(true) {
    t_pickup waittill("trigger", e_player);
    if(!isalive(self)) {
      return;
    }
    var_73a38d53 = self getseatoccupant(0);
    if(isDefined(var_73a38d53) && var_73a38d53 != e_player) {
      continue;
    }
    if(isalive(e_player) && !e_player has_weapon(w_hero)) {
      hint = e_player openluimenu("TurretTakeTutorial");
      while(isDefined(self) && !e_player laststand::player_is_in_laststand() && !e_player turret_pickup_button_pressed() && e_player istouching(t_pickup)) {
        wait(0.05);
      }
      e_player closeluimenu(hint);
    }
  }
}

function turret_pickup_button_pressed() {
  return self meleeButtonPressed();
}

function turret_exit_button_pressed() {
  return self useButtonPressed();
}

function remove_inventory_turret() {
  w_hero = getweapon("lmg_light");
  if(self hasweapon(w_hero)) {
    self takeweapon(w_hero);
  }
}

function magic_bullet_shield_till_notify(str_kill_mbs, b_disable_w_player_shot, str_phalanx_scatter_notify) {
  self endon("death");
  self.cybercomtargetstatusoverride = 1;
  util::magic_bullet_shield(self);
  if(b_disable_w_player_shot) {
    self thread stop_magic_bullet_shield_on_player_damage(str_kill_mbs, str_phalanx_scatter_notify);
  }
  util::waittill_any_ents(level, str_kill_mbs, self, str_kill_mbs, self, "ram_kill_mb", self, "ccom_locked_on", self, "cybercom_action");
  util::stop_magic_bullet_shield(self);
  self.cybercomtargetstatusoverride = undefined;
}

function stop_magic_bullet_shield_on_player_damage(str_kill_mbs, str_phalanx_scatter_notify) {
  self endon("ram_kill_mb");
  self endon(str_kill_mbs);
  level endon(str_kill_mbs);
  while(true) {
    self waittill("damage", amount, attacker);
    if(isPlayer(attacker)) {
      if(isDefined(str_phalanx_scatter_notify)) {
        level notify(str_phalanx_scatter_notify);
        wait(0.05);
        level notify(str_kill_mbs);
      }
      self notify(str_kill_mbs);
    }
  }
}

function function_f08afb37(b_on = 1, var_eebad467 = 0.1) {
  self endon("death");
  if(isalive(self) && issentient(self)) {
    if(b_on) {
      self.attackeraccuracy = var_eebad467;
      self.overrideactordamage = &function_74e97bfe;
      self notify("hash_4ef4ba2d");
    } else {
      self.attackeraccuracy = var_eebad467;
      self.overrideactordamage = undefined;
      self notify("hash_cb188399");
    }
  }
}

function function_74e97bfe(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(isPlayer(e_attacker)) {
    function_f08afb37(0);
    return n_damage;
  }
  if(str_means_of_death == "MOD_EXPLOSIVE" || str_means_of_death == "MOD_GRENADE" || str_means_of_death == "MOD_MELEE" || str_means_of_death == "MOD_MELEE_WEAPON_BUTT") {
    return n_damage;
  }
  n_damage = 1;
  self.health = self.health + 1;
  return n_damage;
}

function staged_battle_outcomes(str_robot_sm, str_human_sm) {
  level thread complete_staged_fight_become_rusher(str_robot_sm, str_human_sm);
  level thread complete_staged_fight_enlarge_goal_radius(str_robot_sm, str_human_sm);
}

function complete_staged_fight_become_rusher(str_robot_sm, str_human_sm) {
  do {
    wait(0.5);
    a_human_ais = spawn_manager::get_ai(str_human_sm);
  }
  while(a_human_ais.size > 0 || spawn_manager::is_enabled(str_human_sm));
  a_robot_ais = spawn_manager::get_ai(str_robot_sm);
  foreach(e_robot in a_robot_ais) {
    e_robot cleargoalvolume();
    e_robot ai::set_behavior_attribute("move_mode", "rusher");
  }
}

function complete_staged_fight_enlarge_goal_radius(str_robot_sm, str_human_sm) {
  do {
    wait(0.5);
    a_robot_ais = spawn_manager::get_ai(str_robot_sm);
  }
  while(a_robot_ais.size > 0 || spawn_manager::is_enabled(str_robot_sm));
  a_human_ais = spawn_manager::get_ai(str_human_sm);
  foreach(e_human in a_human_ais) {
    e_human.goalradius = 1024;
  }
}

function player_walk_speed_adjustment(e_rubber_band_to, str_endon, n_dist_min, n_dist_max, n_speed_scale_min = 0, n_speed_scale_max = 1, var_d04843e1 = 20) {
  assert(isPlayer(self), "");
  assert(isDefined(e_rubber_band_to), "");
  assert(isDefined(n_dist_min), "");
  assert(isDefined(n_dist_max), "");
  self endon(str_endon);
  self endon("death");
  self endon("disconnect");
  self thread _player_walk_speed_reset(str_endon);
  if(!isarray(e_rubber_band_to)) {
    var_2328c0bb = array(e_rubber_band_to);
  } else {
    var_2328c0bb = e_rubber_band_to;
  }
  var_6987b601 = function_36bdd3e9(var_2328c0bb);
  n_prev_speed = 1;
  n_speed_new = 1;
  n_height_diff = 0;
  var_6996430b = math::linear_map(var_d04843e1, 0, 190, 0, 1);
  var_c0a77ece = distance2d(self.origin, function_36bdd3e9(var_2328c0bb));
  b_first_frame = 1;
  var_d1c1929b = 0;
  var_3e7026da = 0;
  var_b054adb3 = 0;
  var_857f3b54 = 0;
  var_36d81334 = 0;
  if(isDefined(self.var_1e462286)) {
    b_first_frame = 0;
    n_prev_speed = self.var_1e462286;
    self setmovespeedscale(self.var_1e462286);
  }
  if(isDefined(self.var_622d06be)) {
    n_height_diff = self.var_622d06be;
  }
  while(true) {
    var_856fe6c6 = function_36bdd3e9(var_2328c0bb);
    var_e730dd94 = distance(var_6987b601, var_856fe6c6);
    var_6987b601 = var_856fe6c6;
    var_8b261109 = var_e730dd94 * 20;
    if(var_2328c0bb.size > 1) {
      var_8aab3fca = arraycopy(var_2328c0bb);
      arrayremoveindex(var_8aab3fca, 0, 0);
      var_5db32273 = var_2328c0bb[0].origin - function_36bdd3e9(var_8aab3fca);
    } else {
      var_5db32273 = anglesToForward((0, var_2328c0bb[0].angles[1], 0));
    }
    v_player_forward = anglesToForward(self.angles);
    var_b054adb3 = var_3e7026da;
    var_3e7026da = 0;
    foreach(entity in var_2328c0bb) {
      var_e71cd44d = distance2d(self.origin, entity.origin);
      var_671d9784 = vectordot(vectornormalize(var_5db32273), vectornormalize(self.origin - entity.origin));
      if(var_e71cd44d <= 24 && var_671d9784 <= -0.25) {
        var_3e7026da = 1;
        continue;
      }
      if(var_e71cd44d <= 32 && var_671d9784 <= -0.5) {
        var_3e7026da = 1;
        continue;
      }
      if(var_e71cd44d <= 40 && var_671d9784 <= -0.75) {
        var_3e7026da = 1;
      }
    }
    if(n_prev_speed <= var_6996430b && !var_3e7026da) {
      var_857f3b54++;
      if(var_857f3b54 > 10) {
        var_36d81334 = 1;
      }
    } else {
      var_857f3b54 = 0;
    }
    var_8c034a31 = distance2d(self.origin, var_856fe6c6);
    if(!var_36d81334 && (abs(var_8c034a31 - var_c0a77ece)) < 12 && (!(var_3e7026da || var_b054adb3))) {
      wait(0.05);
      continue;
    }
    var_c0a77ece = var_8c034a31;
    var_16d9beb6 = vectordot(vectornormalize(var_5db32273), self.origin - var_2328c0bb[0].origin);
    if(var_16d9beb6 <= 0) {
      var_d3fe8f49 = math::linear_map(var_8b261109, var_d04843e1, 190, 0, 1);
      n_height_diff = abs(var_856fe6c6[2] - self.origin[2]);
      self.var_622d06be = n_height_diff;
      if(var_8c034a31 > n_dist_max || n_height_diff > 160) {
        n_speed_new = 1;
      } else {
        if(var_8c034a31 <= n_dist_min) {
          n_speed_new = var_d3fe8f49;
        } else {
          n_dist_frac = math::linear_map(var_8c034a31, n_dist_min, n_dist_max, 0.5, 1);
          n_speed_new = n_dist_frac;
        }
      }
      if(n_speed_new < var_6996430b) {
        n_speed_new = var_6996430b;
      }
      if(var_3e7026da) {
        var_d1c1929b++;
        n_speed_new = var_6996430b - (0.05 * var_d1c1929b);
        if(n_speed_new < 0.05) {
          n_speed_new = 0.05;
        }
      } else if(var_d1c1929b > 0) {
        var_d1c1929b = 0;
      }
    } else if(n_height_diff <= 160) {
      n_speed_new = var_6996430b;
    }
    if(!b_first_frame) {
      if((abs(n_speed_new - n_prev_speed)) < 0.1) {
        n_speed_new = n_prev_speed;
      } else {
        if(n_prev_speed > (n_speed_new + 0.1)) {
          n_speed_new = n_prev_speed - 0.1;
        } else if(n_prev_speed < (n_speed_new - 0.1) && n_height_diff <= 100) {
          n_speed_new = n_prev_speed + 0.1;
        }
      }
    }
    var_36d81334 = 0;
    b_first_frame = 0;
    n_prev_speed = n_speed_new;
    self setmovespeedscale(n_speed_new);
    self.var_1e462286 = n_speed_new;
    wait(0.05);
  }
}

function function_36bdd3e9(a_ents) {
  var_4ce0e4b7 = (0, 0, 0);
  foreach(ent in a_ents) {
    var_4ce0e4b7 = var_4ce0e4b7 + ent.origin;
  }
  return var_4ce0e4b7 / a_ents.size;
}

function _player_walk_speed_reset(str_endon) {
  level waittill(str_endon, b_reset);
  if(!isDefined(b_reset)) {
    b_reset = 1;
  }
  if(isDefined(b_reset) && b_reset) {
    self setmovespeedscale(1);
    self.var_1e462286 = 1;
  }
}

function scene_model_streamer_hint(a_ents) {
  n_hint_time = 5;
  foreach(ent in a_ents) {
    if(isDefined(ent.model)) {
      streamermodelhint(ent.model, n_hint_time);
    }
  }
  if(isDefined(self.scenes[0]._s.nextscenebundle)) {
    scene::add_scene_func(self.scenes[0]._s.nextscenebundle, &scene_model_streamer_hint, "play");
  }
}

function force_stream_1stpersonplayer(n_hint_time = 5) {
  streamermodelhint("c_hro_player_male_egypt_viewbody", n_hint_time);
}

function co_op_teleport_on_igc_end(str_scene, str_teleport_name) {
  assert(isDefined(str_scene), "");
  assert(isDefined(str_teleport_name), "");
  scene::add_scene_func(str_scene, &teleport_co_op_players_on_scene_done, "players_done");
  level thread wait_for_scene_done(str_scene, str_teleport_name);
}

function teleport_co_op_players_on_scene_done(a_ents) {
  if(isDefined(self.scenes[0]) && isDefined(self.scenes[0]._str_notify_name)) {
    level notify(self.scenes[0]._str_notify_name + "_level_done");
  } else {
    level notify(self.scriptbundlename + "_level_done");
  }
}

function wait_for_scene_done(str_scene, str_teleport_name) {
  level waittill(str_scene + "_level_done");
  foreach(player in level.players) {
    player ghost();
  }
  util::teleport_players_igc(str_teleport_name);
  wait(0.5);
  foreach(player in level.players) {
    player show();
  }
}

function function_7255e66(b_enable = 1, str_script_string) {
  var_335c4513 = getEntArray("mobile_armory", "script_noteworthy");
  foreach(var_a9960583 in var_335c4513) {
    if(isDefined(var_a9960583.gameobject) && (var_a9960583.script_string === str_script_string || !isDefined(str_script_string))) {
      if(!b_enable) {
        var_a9960583 oed::disable_thermal();
        var_a9960583 oed::disable_keyline();
        var_a9960583.gameobject gameobjects::disable_object();
        continue;
      }
      var_a9960583.gameobject gameobjects::enable_object();
      var_a9960583 oed::enable_thermal();
      var_a9960583 oed::enable_keyline();
    }
  }
}

function function_f2f98cfc() {
  var_3354e659 = getent("hotel_gate", "targetname");
  var_3354e659 ghost();
  var_3354e659 notsolid();
  umbragate_set("hotel", 1);
}

function function_1aeb2873() {
  getent("defend_street_gate", "targetname") delete();
  umbragate_set("defend_street", 1);
}

function function_fb967724() {
  getent("hotel_gate", "targetname") show();
  umbragate_set("hotel", 0);
}