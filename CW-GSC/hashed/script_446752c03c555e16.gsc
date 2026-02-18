/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_446752c03c555e16.gsc
***********************************************/

#using script_155b17ff7c8b315c;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_2977687d;

function init() {
  level thread function_8d310e6c();
  level thread function_e19a72c1();
  animation::add_notetrack_func("amerika_util::set_flag_from_scene", &namespace_fc3e8cb::function_e9f3f20);
  animation::add_notetrack_func("amerika_util::clear_flag_from_scene", &namespace_fc3e8cb::function_cafa23ec);
}

function function_95dc818f(str_scene_name, var_2b490ed3, var_53f71e6a, var_4e21c010, n_wait_min = 10, n_wait_max = 15) {
  assert(isstring(str_scene_name));
  assert(isstring(var_2b490ed3));
  assert(isarray(var_53f71e6a));
  assert(isstring(var_4e21c010) || ishash(var_4e21c010));

  while(var_53f71e6a.size > 0 && !level flag::get(var_4e21c010)) {
    s_event = level waittilltimeout(randomfloatrange(n_wait_min, n_wait_max), var_4e21c010);

    if(s_event._notify === # "timeout") {
      level scene::play(str_scene_name, var_53f71e6a[0]);
      arrayremoveindex(var_53f71e6a, 0);

      if(level flag::get(var_4e21c010)) {
        break;
      }

      level thread scene::play(str_scene_name, var_2b490ed3);
      continue;
    }

    break;
  }

  level flag::wait_till(var_4e21c010);
}

function scene_amk_1030_per_reveal() {
  var_4e21c010 = # "hash_4660b6aada428755";

  if(level flag::get(var_4e21c010) == 1) {
    level flag::set("woods_at_reveal");
    level scene::play("scene_amk_1030_per_reveal", "fast_woods_enter");
  } else {
    level scene::play("scene_amk_1030_per_reveal", "woods_enter");
    level thread scene::play("scene_amk_1030_per_reveal", "woods_loop");
    var_6d62b495 = array("woods_nags1", "woods_nags2");
    level function_95dc818f("scene_amk_1030_per_reveal", "woods_loop", var_6d62b495, var_4e21c010);
    level flag::set("woods_at_reveal");
    level scene::stop("scene_amk_1030_per_reveal");
    level scene::play("scene_amk_1030_per_reveal", "woods_exit");
  }

  level scene::play("scene_amk_1030_per_reveal", "to_idle_woods");
  level scene::play("scene_amk_1030_per_reveal", "woods_idle_nags4");
  level function_504c79a0();
}

function function_504c79a0() {
  level thread scene::play("scene_amk_1030_per_reveal", "idle_woods_loop");
  wait 1;
  level flag::wait_till_any(["flg_perimeter_obj_take_vista_photo_complete", "flg_perimeter_tower_enemies_alerted"]);
  wait 3;
  level scene::stop(#"scene_amk_1030_per_reveal");
  level scene::stop(#"hash_20c92577942d1dee");
  level scene::play("scene_amk_1030_per_reveal", "idle_woods_exit");
  level.woods setgoal(level.woods.origin);
}

function function_4c27ed84() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  vol_forest_branch_reveal = getent("vol_forest_branch_reveal", "targetname");
  s_forest_branch_reveal = struct::get("s_forest_branch_reveal", "targetname");
  var_2b8afaa2 = 0;

  while(true) {
    if(istouching(level.player.origin, vol_forest_branch_reveal)) {
      if(!var_2b8afaa2) {
        level.player val::set(#"hash_22754d9885e308f0", "disable_weapons", 1);
        var_2b8afaa2 = 1;
      }

      var_a1b6be13 = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), s_forest_branch_reveal.origin, cos(40));
      var_d57a6732 = distance2d(level.player getplayercamerapos(), s_forest_branch_reveal.origin);

      if(var_a1b6be13 == 1 && var_d57a6732 <= 95 && level flag::get("flg_forest_woods_past_branch")) {
        if(level.player getstance() == "crouch") {
          level.player setstance("stand");
        }

        break;
      }
    } else if(is_true(var_2b8afaa2)) {
      level.player val::reset(#"hash_22754d9885e308f0", "disable_weapons");
      var_2b8afaa2 = 0;
    }

    waitframe(1);
  }

  level.player util::delay(0.25, undefined, &util::function_749362d7, 0);
  level scene::play("scene_amk_1030_per_reveal", "player_start");
  level.player val::reset_all(#"hash_22754d9885e308f0");
  level flag::set("flg_forest_player_past_branch");
}

function function_54afad46() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"flg_perimeter_obj_take_vista_photo_complete", #"flg_perimeter_tower_enemies_alerted");
  var_98c1db83 = array("react1", "react2", "react3");
  var_fc46a079 = array("react4", "react5", "react6");
  var_9060dfc9 = array("react7", "react8", "react9");
  var_2503a21f = 0;

  while(!flag::get("flg_perimeter_obj_take_vista_photo_complete") && !flag::get("flg_perimeter_tower_enemies_alerted")) {
    if(var_98c1db83.size == 0 && var_fc46a079.size == 0 && var_9060dfc9.size == 0) {
      break;
    }

    if(var_9060dfc9.size != 0) {
      level thread function_19534163();
    }

    if(var_98c1db83.size != 0 || var_fc46a079.size != 0) {
      level thread function_bc29dab9(var_2503a21f);
    }

    level thread function_bc29dab9(var_2503a21f);
    s_waitresult = level waittill(#"hash_1c978bceb82ac69e");
    var_2503a21f = 1;

    if(s_waitresult.event == # "timeout" && var_98c1db83.size != 0) {
      level scene::play(#"hash_20c92577942d1dee", var_98c1db83[0]);
      arrayremoveindex(var_98c1db83, 0);
    } else if(s_waitresult.event == # "take_picture" && var_fc46a079.size != 0) {
      wait 0.25;
      level scene::play(#"hash_20c92577942d1dee", var_fc46a079[0]);
      arrayremoveindex(var_fc46a079, 0);
    } else if(s_waitresult.event == # "hash_43d27ac2611ccdc2" && var_9060dfc9.size != 0) {
      wait 0.25;
      level scene::play(#"hash_20c92577942d1dee", var_9060dfc9[0]);
      arrayremoveindex(var_9060dfc9, 0);
    }

    level thread scene::play(#"hash_20c92577942d1dee", "react_loop");
  }
}

function private function_19534163() {
  level endon(#"hash_1c978bceb82ac69e");
  level.woods waittillmatch({
    #var_aad36d51: 0, #fieldvalue: 1
  }, #"hash_72a5fe161eb7a0ce");
  level notify(#"hash_1c978bceb82ac69e", {
    #event: # "hash_43d27ac2611ccdc2"});
}

function private function_bc29dab9(var_2503a21f) {
  level endon(#"hash_1c978bceb82ac69e");
  n_wait_time = randomfloatrange(6, 8);

  if(!is_true(var_2503a21f)) {
    n_wait_time += 10;
  }

  s_result = level.player waittilltimeout(n_wait_time, #"take_picture");
  wait 0.2;

  if(is_true(var_2503a21f) && s_result._notify == # "timeout" && level.player getcurrentweapon() == level.var_e3f5eafc) {
    n_wait_time = randomfloatrange(6, 8);
    s_result = level.player waittilltimeout(n_wait_time, #"take_picture");
  }

  level notify(#"hash_1c978bceb82ac69e", {
    #event: s_result._notify
  });
}

function scene_amk_3010_arc_enter() {
  assert(isDefined(level.woods));
  a_scene_ents[# "woods"] = level.woods;
  a_scene_ents[# "arc_door"] = getent("arc_door", "targetname");
  e_door = a_scene_ents[# "arc_door"];
  level thread function_6fe3f44f(e_door);
  level.woods flag::set("flg_pause_photo_react");
  level thread scene::init("scene_amk_3010_arc_enter");
  snd::client_msg("audio_muffled_arcade_music");
  level.woods notify(#"amk_woods_new_goal");
  level.woods clearforcedgoal();
  level scene::play("scene_amk_3005_arc_approach", "arcade_approach");
  level thread scene::play("scene_amk_3005_arc_approach", "arcade_door_idle");
  level flag::set("flg_tunnels_woods_at_arcade_entrance");
  var_164ab092 = array("arcade_door_nag01", "arcade_door_nag02");
  var_4e21c010 = # "hash_106670b812548c9e";
  level function_95dc818f("scene_amk_3005_arc_approach", "arcade_door_idle", var_164ab092, var_4e21c010);
  level scene::stop("scene_amk_3005_arc_approach");
  level scene::play("scene_amk_3010_arc_enter", "arcade_enter");
  level scene_amk_3020_arc_window();
}

function function_6fe3f44f(e_door) {
  level flag::wait_till("flg_arcade_street_photo_taken");
  e_door delete();
  level scene::init("scene_amk_3050_arc_door");
  e_clip = getent("e_arcade_entrance_door_clip", "targetname");
  e_clip movey(128, 0.1, 0.05, 0.05);
  e_clip disconnectpaths();
  snd::client_msg("flg_audio_tunnel_generator_off");
}

function scene_amk_3020_arc_window() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level scene::play("scene_amk_3020_arc_window", "arcade_window_enter");
  level thread scene::play("scene_amk_3020_arc_window", "arcade_window_loop");
  level namespace_4bd68414::function_33d3327a();
  level.woods flag::set(#"flg_arcade_nags_begin");
  var_7fc195f4 = array("arcade_window_nag01", "arcade_window_nag02", "arcade_window_nag03", "arcade_window_nag04");
  var_f7db8da1 = array("arcade_window_nag05", "arcade_window_nag06", "arcade_window_nag07", "arcade_window_nag08");
  var_4e21c010 = # "flg_arcade_street_photo_taken";
  str_scene_name = "scene_amk_3020_arc_window";

  while((var_7fc195f4.size > 0 || var_f7db8da1.size > 0) && !level flag::get(var_4e21c010)) {
    s_event = level waittilltimeout(randomfloatrange(6, 8), var_4e21c010);

    if(s_event._notify === # "timeout") {
      if(level.player flag::get("playing_arcade_game") == 1) {
        level.player flag::wait_till_clear("playing_arcade_game");
        wait 5;
        continue;
      }

      if(level.woods namespace_fc3e8cb::function_5b19aae2()) {
        continue;
      }

      str_shot_name = undefined;

      if(level.player getcurrentweapon() == level.var_e3f5eafc && var_7fc195f4.size > 0) {
        str_shot_name = var_7fc195f4[0];
        arrayremoveindex(var_7fc195f4, 0);
      } else if(level.player getcurrentweapon() != level.var_e3f5eafc && var_f7db8da1.size > 0) {
        str_shot_name = var_f7db8da1[0];
        arrayremoveindex(var_f7db8da1, 0);
      }

      if(isDefined(str_shot_name)) {
        level.woods flag::set(#"hash_ef3856d6deed76");
        level scene::play(str_scene_name, str_shot_name);
        level thread scene::play(str_scene_name, "arcade_window_loop");
        level.woods flag::clear(#"hash_ef3856d6deed76");
      }

      continue;
    }

    break;
  }

  level flag::wait_till(var_4e21c010);
  level.woods flag::clear(#"flg_arcade_nags_begin");
  level thread namespace_4bd68414::function_e960ffea();
  level.woods flag::wait_till("flg_arcade_woods_move_to_exit");
  level scene::stop("scene_amk_3020_arc_window");
  level scene_amk_3025_arc_exit();
}

function scene_amk_3025_arc_exit() {
  level scene::play("scene_amk_3025_arc_exit", "arcade_exit");
  level.woods flag::set("flg_arcade_scenes_complete");
  level flag::set("flg_arcade_scenes_complete");
  level.woods flag::clear("flg_pause_photo_react");
}

function scene_amk_6010_tml_computer() {
  level thread scene_amk_6010_tml_server();
  level thread function_cca144e3();
  level flag::wait_till(#"flg_terminal_player_interact");
  wait 1.2;
  level scene::play(#"scene_amk_6010_tml_computer", "interact_enter");
  level thread scene::play(#"scene_amk_6010_tml_computer", "interact_loop");
  level flag::wait_till(#"hash_10227bcd8df77658");
  level scene::play(#"scene_amk_6010_tml_computer", "move_to_tapes");
  level thread scene::play(#"scene_amk_6010_tml_computer", "tapes_loop");
  level flag::wait_till(#"hash_24f6f7540d220ba6");
  a_scene_ents = [];
  var_da03c083 = doors::get_doors("e_terminal_exit_door_animated", "targetname");

  foreach(door in var_da03c083) {
    if(door.script_noteworthy === "left_door") {
      a_scene_ents[# "left_door"] = door.c_door.m_e_door;
      continue;
    }

    if(door.script_noteworthy === "right_door") {
      a_scene_ents[# "right_door"] = door.c_door.m_e_door;
    }
  }

  level scene::play("scene_amk_6010_tml_computer", "exit", a_scene_ents);
}

function private function_cca144e3() {
  var_273fba42 = array("nag1", "nag2", "nag3");
  var_4e21c010 = # "flg_terminal_player_interact";
  level endon(var_4e21c010);
  level scene::play("scene_amk_6010_tml_computer", "room_enter2");

  if(!level flag::get(var_4e21c010)) {
    level thread scene::play("scene_amk_6010_tml_computer", "room_loop");

    while(!level flag::get(var_4e21c010)) {
      level function_95dc818f("scene_amk_6010_tml_computer", "room_loop", var_273fba42, var_4e21c010, 8, 12);
    }
  }
}

function scene_amk_6010_tml_server() {
  level flag::wait_till("flg_terminal_tapes_trigger");
  snd::client_msg("flg_audio_servers_spool_up");
  level scene::play("scene_amk_6010_tml_server", "server_enter");
  level thread scene::play("scene_amk_6010_tml_server", "server_loop");
  level flag::wait_till("flg_terminal_player_exit");
  snd::client_msg("flg_audio_servers_stop");
  level scene::play("scene_amk_6010_tml_server", "server_exit");
}

function scene_amk_6090_stg_garage() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level.player val::set(#"hash_3d42f95a13edad88", "disable_weapons", 1);
  level.player val::set(#"hash_3d42f95a13edad88", "freezecontrols_allowlook", 1);
  wait 0.5;
  s_scene = struct::get("s_scene_amk_6090_stg_garage", "targetname");
  s_scene scene::play("scene_amk_6090_stg_garage");
  level.player val::reset_all(#"hash_3d42f95a13edad88");
}

function function_8d310e6c() {
  level flag::wait_till("flg_elevator_end");
  level scene::function_27f5972e("p9_fxanim_cp_amerika_tree_01_bundle");
  var_9b9c8b37 = getEntArray("tree_01_trigger", "targetname");

  foreach(trigger in var_9b9c8b37) {
    trigger.scene = struct::get(trigger.target, "targetname");
    trigger thread function_947e6526();
  }
}

function function_947e6526() {
  level flag::wait_till("flg_terminal_end");
  self.scene scene::init("p9_fxanim_cp_amerika_tree_01_bundle");
  level flag::wait_till("flg_escape_apc_interact_triggered");
  damage_amount = 0;

  while(damage_amount < 5) {
    self trigger::wait_till();
    self.scene thread scene::play("p9_fxanim_cp_amerika_tree_01_bundle", "play");
    wait 0.05;
    damage_amount += 1;
  }

  self.scene scene::play("p9_fxanim_cp_amerika_tree_01_bundle", "destroy");
}

function function_e19a72c1() {
  level flag::wait_till("flg_escape_apc_interact_triggered");
  level flag::wait_till("flg_apc_ride_town_square_enter");
  var_4baf0b18 = 0;
  var_6de6260d = getent("gazebo_trigger", "targetname");
  level scene::function_27f5972e("p9_fxanim_cp_amerika_gazebo_destruction_bundle");

  while(var_4baf0b18 <= 6) {
    var_6de6260d trigger::wait_till();

    if(level flag::get("flg_apc_ride_town_square_steps") == 0) {
      var_4baf0b18 += 1;
      continue;
    }

    var_4baf0b18 += 3;
  }

  level flag::set("flg_apc_ride_gazebo_destroyed");
  physicsexplosionsphere(var_6de6260d.origin, 1000, 1, 100, 100, 100);
  level thread namespace_fc3e8cb::function_38b40877(var_6de6260d.origin, 200, 1.5);
  level scene::play_from_time("p9_fxanim_cp_amerika_gazebo_destruction_bundle", "play_01");
  level flag::wait_till("flg_apc_ride_mall_transition_end");
  var_6de6260d delete();
  level scene::function_f81475ae("p9_fxanim_cp_amerika_gazebo_destruction_bundle");
}