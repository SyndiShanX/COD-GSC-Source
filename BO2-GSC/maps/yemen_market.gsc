/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_market.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_skipto;
#include maps\_anim;
#include maps\_dialog;
#include maps\yemen_utility;
#include maps\yemen_speech;
#include maps\yemen_anim;
#include maps\yemen;
#include maps\yemen_amb;
#include maps\createart\yemen_art;
#include maps\yemen_metal_storms;
#include maps\_spawner;
#include maps\_quadrotor;
#include maps\_colors;

init_flags() {
  flag_init("market_start");
  flag_init("market_friendly_respawn_hit");
  flag_init("player_attacked_yemeni");
  flag_init("player_attacked_terrorists");
  flag_init("player_killed_terrorists");
  flag_init("yemeni_attacked_player");
  flag_init("robot_attacked_player");
  flag_init("terrorist_attacked_player");
  flag_init("player_cover_blown");
  flag_init("yemenis_ahead");
  flag_init("kill_market_vo");
}

init_spawn_funcs() {
  a_spawners = getspawnerteamarray("allies");

  foreach(spawner in a_spawners) {
    if(isDefined(spawner.script_string) && spawner.script_string == "market_yemeni")
      spawner thread market_yemeni_spawner_think();
  }

  add_spawn_function_group("terrorist", "script_noteworthy", ::terrorist_teamswitch_spawnfunc);
  add_spawn_function_group("court_terrorists", "targetname", ::terrorist_teamswitch_spawnfunc);
  waittillframeend;
  add_spawn_function_group("melee_01_terrorist", "targetname", ::melee_01_terrorist);
  add_spawn_function_group("melee_01_yemeni", "targetname", ::melee_01_yemeni);
  add_spawn_function_group("rolling_door_01", "targetname", ::rolling_door_guy);
  add_spawn_function_group("rolling_door_02", "targetname", ::rolling_door_guy);
  add_spawn_function_group("rolling_door_2_01", "targetname", ::rolling_door_2_guy);
  add_spawn_function_group("rolling_door_2_02", "targetname", ::rolling_door_2_guy);

  add_spawn_function_group("terrorist", "script_noteworthy", ::terrorist_debug_spawnfunc);
}

market_yemeni_spawner_think() {
  self.script_fixednode = 0;
  self add_spawn_function(::yemeni_teamswitch_spawnfunc);
}

rolling_door_guy() {
  self.ignoreme = 1;
  self endon("death");
  scene_wait("rolling_door");
  self.ignoreme = 0;
}

rolling_door_2_guy() {
  self.ignoreme = 1;
  self endon("death");
  scene_wait("rolling_door2");
  self.ignoreme = 0;
}

market_drone_ambush_drone() {
  wait 3;
  self maps\_vehicle::defend(self.origin, 300);
}

skipto_market() {
  skipto_teleport("skipto_market_player");
  level thread maps\yemen_speech::speech_clean_up();
  trigger_use("speech_clean_up");
  exploder(10);
}

skipto_drone_crash() {
  load_gump("yemen_gump_speech");
  skipto_teleport("skipto_drone_crash");
  exploder(10);
  drone_crash_into_car();
}

main() {
  iprintln("Market");

  level thread yemen_market_setup();
  flag_set("market_start");
  flag_wait("player_turn");
  wait 1;
  trigger_use("courtyard_wounded");
  setsaveddvar("aim_target_ignore_team_checking", 1);
  exploder(3);
  level maps\yemen_anim::market_anims();
  level thread vo_after_speech();
  level thread vo_market();
  level thread speech_courtyard_ai();
  level thread speech_drone_runners();
  level thread speech_leave_stage();
  level thread drone_crash_into_car();
  level thread market_rolling_door();
  level thread market_friendly_handler();
  level thread yemen_market_clean_up();
  waittill_speech_anim_done();
  level thread maps\yemen::meet_menendez_objectives();
  level.friendlyfiredisabled = 1;
  level thread market_battle_flow();
  level thread market_vtol_crash();
  wait 5;
  stop_exploder(1000);
  exploder(1020);
  level notify("start_market_canopies");
  level thread maps\yemen_amb::yemen_drone_control_tones(1);
  trigger_wait("terrorist_hunt_start");
  autosave_by_name("yemen_market_complete");
}

yemen_market_setup() {
  trigger_use("market_friendlies_spawntrig", "script_noteworthy");
  maps\createart\yemen_art::market();
}

waittill_speech_anim_done() {
  if(!is_after_skipto("speech")) {
    if(level.is_defalco_alive)
      scene_wait("speech_walk_no_defalco_player");
    else
      scene_wait("speech_walk_no_defalco_player");
  }
}

speech_leave_stage() {
  level thread speech_drones_ignore_player();
  amb_vtol = spawn_vehicle_from_targetname_and_drive("speech_amb_vtol");
  amb_vtol setforcenocull();
}

speech_drones_ignore_player() {
  level.player set_ignoreme(1);
  level.player flag_wait_any("menendez_exited", "player_leaves_stage");
  level.player set_ignoreme(0);
}

speech_quads() {
  a_quads = [];
  qdrotor_struct = getstruct("speech_qdrotor_origin", "targetname");

  for(i = 0; i < 4; i++) {
    vh_quad = maps\_vehicle::spawn_vehicle_from_targetname("vtol_attack_drone");
    vh_quad.goalpos = qdrotor_struct.origin;
    vh_quad.goalradius = 1000;
    vh_quad.drivepath = 1;
    a_quads[a_quads.size] = vh_quad;
  }

  for(i = 0; i < 4; i++) {
    vh_quad = a_quads[i];
    wait 0.15;

    if(isalive(vh_quad)) {
      vh_quad setvehicleavoidance(0);
      vh_quad ent_flag_init("circling_stage");

      if(i % 3 == 0) {
        vh_quad thread circle_stage();
        vh_quad ent_flag_set("circling_stage");
        continue;
      }

      vh_quad thread circle_courtyard();
    }
  }

  wait 15;
  nd_start = getvehiclenode("quad_courtyard_exit_path", "targetname");
  speech_quads_exit_formation(a_quads, nd_start, 0);
  flag_wait("menendez_exited");
  level notify("stage_quads_exit");
  speech_quads_exit_formation(a_quads, nd_start, 1);
}

speech_quads_exit_formation(a_quads, nd_start, stage_quads) {
  if(!isDefined(stage_quads))
    stage_quads = 0;

  offset = (0, 0, 0);
  i = 0;

  foreach(vh_quad in a_quads) {
    if(!isDefined(vh_quad)) {
      continue;
    }
    if(vh_quad ent_flag("circling_stage") != stage_quads) {
      continue;
    }
    vh_quad thread exit_courtyard(nd_start, offset);
    offset = offset + vectorscale((1, 0, 0), 20.0);
    i++;

    if(i % 3 == 0) {
      offset = (0, 0, 0);
      wait 0.5;
    }
  }
}

exit_courtyard(nd_start, offset) {
  self endon("death");
  self notify("exit_speech");
  self pathvariableoffsetclear();
  self setvehicleavoidance(0);
  self.goalpos = nd_start.origin;
  self setvehgoalpos(nd_start.origin + offset, 1);
  self waittill("near_goal");
  self pathmove(nd_start, nd_start.origin + offset, nd_start.angles);
  self thread go_path(nd_start);
  self waittill("reached_end_node");
  self delete();
}

circle_stage() {
  self endon("death");
  level endon("stage_quads_exit");
  self pathvariableoffsetclear();
  self pathfixedoffsetclear();
  nd_start = getvehiclenode("quad_path_stage", "targetname");

  while(true) {
    maps\_vehicle::getonpath(nd_start);
    self pathvariableoffset(vectorscale((1, 1, 1), 30.0), 2);
    maps\_vehicle::gopath();
  }
}

circle_courtyard() {
  self endon("death");
  self endon("exit_speech");
  self pathvariableoffsetclear();
  self pathfixedoffsetclear();
  nd_start = undefined;

  if(cointoss())
    nd_start = getvehiclenode("quad_circle_path_1", "targetname");
  else
    nd_start = getvehiclenode("quad_circle_path_2", "targetname");

  while(true) {
    maps\_vehicle::getonpath(nd_start);
    self pathvariableoffset(vectorscale((1, 1, 1), 30.0), 2);
    maps\_vehicle::gopath();
  }
}

speech_drone_runners() {
  flag_wait("player_turn");
  wait 1;
  trigger_use("speech_running_drones", "script_noteworthy");
  flag_wait("player_turns_back");
  wait 3;
  trigger_use("speech_end_drones", "script_noteworthy");
}

speech_courtyard_ai() {
  sp_courtyard_spawner = getent("court_terrorists", "targetname");
  sp_courtyard_spawner add_spawn_function(::spawn_func_player_damage_only);
  flag_wait("player_turns_back");
  level thread run_scene_and_delete("shooting_drones_ter1");
  level thread run_scene_and_delete("shooting_drones_ter2");
  level thread run_scene_and_delete("shooting_drones_ter3");
  level thread run_scene_and_delete("shooting_drones_ter4");
  level thread run_scene_and_delete("shooting_drones_ter5");
  level thread run_scene_and_delete("shooting_drones_ter6");
  a_courtyard_spots = getstructarray("speech_court_ai_spot", "targetname");

  a_courtyard_spots = [];

  foreach(s_courtyard_spot in a_courtyard_spots) {
    ai_guy = simple_spawn_single(sp_courtyard_spawner);
    ai_guy maps\yemen_utility::teleport_ai_to_pos(s_courtyard_spot.origin);
    ai_guy.script_noteworthy = s_courtyard_spot.script_noteworthy;
  }

  array_delete(a_courtyard_spots, 1);
  spawn_quadrotors_at_structs("court_drone_spot", "court_drone");
  trigger_use("spawn_court_drones");
  flag_wait_or_timeout("player_leaves_stage", 10);
  ai_courtyard = getentarray("court_terrorists_ai", "targetname");

  foreach(ai in ai_courtyard)
  ai.overrideactordamage = undefined;

  a_ai = get_ai_array("courtyard_high_left", "script_noteworthy");
  nd_exit = getnode("high_left_exit_node", "targetname");

  foreach(ai in a_ai)
  ai thread run_to_goal_and_delete(nd_exit);

  a_ai = get_ai_array("courtyard_high_right", "script_noteworthy");
  nd_exit = getnode("high_right_exit_node", "targetname");

  foreach(ai in a_ai)
  ai thread run_to_goal_and_delete(nd_exit);

  a_ai = get_ai_array("courtyard_center", "script_noteworthy");
  nd_exit = getnode("center_exit_node", "targetname");

  foreach(ai in a_ai)
  ai thread run_to_goal_and_delete(nd_exit);

  a_quads = get_vehicle_array("court_drone", "script_noteworthy");

  foreach(vh_quad in a_quads) {
    if(isDefined(vh_quad)) {
      vh_quad dodamage(vh_quad.health, vh_quad.origin);
      wait(randomfloat(2));
    }

    flag_wait("menendez_exited");
  }
}

run_to_goal_and_delete(nd_exit) {
  self endon("death");
  self force_goal(nd_exit, 50);
  self delete();
}

autoexec market_gump_cleanup() {
  trigger_wait("trigger_market_unload");
  level thread cleanup("fxanim_vtol1_crash");
  level thread cleanup("market_vtol_crash");
  m_vtol = getent("market_vtol", "targetname");

  if(isDefined(m_vtol))
    m_vtol delete();

  if(isDefined(level.a_scenes["mvtol_pilot"]))
    delete_scene("mvtol_pilot");

  a_fans = getentarray("market_fan", "script_noteworthy");

  foreach(fan in a_fans)
  fan delete();
}

market_rolling_door() {
  level endon("market_fallback_01");
  trigger_wait("market_rolling_door", "targetname");
  run_scene_and_delete("rolling_door");
}

market_friendly_handler() {
}

market_heroes_shot() {
  level endon("stage_quads_exit");

  while(true) {
    self waittill("damage", num_damage, e_attacker);

    if(e_attacker == level.player) {
      num_damage++;

      if(num_damage > 50)
        missionfailedwrapper(&"SCRIPT_COMPROMISE_FAIL");
    }
  }
}

market_battle_flow() {
  level.spawn_manager_max_ai = 27;
  spawn_manager_enable("market_spawn_manager_01");
  spawn_quadrotors_at_structs("market_qr_01", "market_drones");
  flag_wait("market_friendly_respawn_hit");
  a_terrorist_spawners = getentarray("market_friendly_terrorist", "targetname");

  foreach(sp_terrorist in a_terrorist_spawners)
  sp_terrorist maps\yemen_metal_storms::streets_spawn_full_count(1);

  flag_wait("player_leaves_stage");
  trigger_use("market_friendly_moveup_01");
  level thread yemen_aigroup_fallback("yemeni_market_group_center", "yemeni_market_center_10", 5, "market_fallback_01", "market_fallback_01", "market_fallback_01");
  level thread yemen_aigroup_fallback("yemeni_market_group_left", "yemeni_market_left_10", 0, "market_fallback_01", "market_fallback_01", "market_fallback_01");
  level thread yemen_aigroup_fallback("yemeni_market_group_right", "yemeni_market_right_10", 0, "market_fallback_01", "market_fallback_01", "market_fallback_01");
  level waittill("market_fallback_01");
  spawn_manager_kill("market_spawn_manager_01");
  market_update_spawner_aigroup("10");
  spawn_manager_enable("market_spawn_manager_10");
  wait 3.0;
  autosave_by_name("market_moveup_10");
  trigger_use("market_friendly_moveup_10");
  simple_spawn_single(getspawnerarray("market_dome_guy01", "script_noteworthy")[0], ::market_dome_guy_spawnfunc, undefined, undefined, undefined, undefined, undefined, 1);
  level thread yemen_aigroup_fallback("yemeni_market_group_center", "yemeni_market_center_20", 5, "market_fallback_10", "market_fallback_10", "market_fallback_10");
  level thread yemen_aigroup_fallback("yemeni_market_group_left", "yemeni_market_left_20", 0, "market_fallback_10", "market_fallback_10", "market_fallback_10");
  level thread yemen_aigroup_fallback("yemeni_market_group_right", "yemeni_market_right_20", 0, "market_fallback_10", "market_fallback_10", "market_fallback_10");
  spawn_vehicle_from_targetname_and_drive("market_vtol_20");
  level thread market_vtol_exploder();
  level waittill("market_fallback_10");
  spawn_manager_kill("market_spawn_manager_10");
  market_update_spawner_aigroup("20");
  spawn_manager_enable("market_spawn_manager_20");
  wait 3.0;
  trigger_use("market_friendly_moveup_20");
  level thread yemen_aigroup_fallback("yemeni_market_group_center", "yemeni_market_center_30", 5, "market_fallback_20", "market_fallback_20", "market_fallback_20");
  level thread yemen_aigroup_fallback("yemeni_market_group_left", "yemeni_market_left_30", 0, "market_fallback_20", "market_fallback_20", "market_fallback_20");
  level thread yemen_aigroup_fallback("yemeni_market_group_right", "yemeni_market_right_30", 1, "market_fallback_20", "market_fallback_20", "market_fallback_20");
  level waittill("market_fallback_20");
  spawn_manager_kill("market_spawn_manager_20");
  market_update_spawner_aigroup("30");
  spawn_manager_enable("market_spawn_manager_30");
  wait 3.0;
  autosave_by_name("market_moveup_30");
  trigger_use("market_friendly_moveup_30");
  trigger_wait("market_end");
  spawn_manager_kill("market_spawn_manager_30");
}

market_update_spawner_aigroup(str_append) {
  a_zones = array("center", "right", "left");

  foreach(str_zone in a_zones) {
    a_spawners = getspawnerarray("yemeni_market_" + str_zone + "_" + str_append, "script_noteworthy");

    foreach(spawner in a_spawners) {
      spawner.script_aigroup = "yemeni_market_group_" + str_zone;
      maps\_spawner::aigroup_init(spawner.script_aigroup, spawner);
    }
  }
}

yemen_aigroup_fallback(str_aigroup, str_new_goalvolume, n_fallback_num, str_fallback_notify, str_fallback_flag, str_notify_on_fallback) {
  if(isDefined(n_fallback_num))
    level thread yemen_aigroup_fallback_count_watch(str_aigroup, n_fallback_num);

  if(!flag(str_fallback_flag))
    waittill_any(str_aigroup + "fallback_num", str_fallback_notify, str_fallback_flag);

  level notify(str_aigroup + "fallback_ready");
  a_ai = get_ai_group_ai(str_aigroup);

  if(a_ai.size > n_fallback_num + 1) {
    n_to_kill = a_ai.size - (n_fallback_num + 1);
    a_ai = array_randomize(a_ai);

    for(i = 0; i < n_to_kill; i++)
      a_ai[i] thread yemen_fallback_delay_bloodydeath();
  }

  vol_goal = getent(str_new_goalvolume, "targetname");

  foreach(ai_guy in a_ai)
  ai_guy thread yemen_fallback_move(vol_goal);

  if(isDefined(str_notify_on_fallback))
    level notify(str_notify_on_fallback);
}

yemen_aigroup_fallback_count_watch(str_aigroup, n_fallback_num) {
  level endon(str_aigroup + "fallback_ready");
  waittill_ai_group_count(str_aigroup, n_fallback_num);
  n_count = get_ai_group_count(str_aigroup);
  level notify(str_aigroup + "fallback_num");
}

yemen_fallback_move(vol_goal) {
  self endon("death");

  if(randomint(2))
    wait(randomfloatrange(1.0, 3.0));
  else
    wait(randomfloatrange(0.0, 1.0));

  self cleargoalvolume();
  self setgoalvolumeauto(vol_goal);
  self waittill("goal");
  self setgoalpos(self.origin);
  self set_goalradius(2048);
}

yemen_fallback_delay_bloodydeath() {
  self endon("death");
  self bloody_death(undefined, 1.0);
}

market_dome_guy_spawnfunc() {
  self set_ignoreme(1);
  self.overrideactordamage = ::market_dome_guy_callback;
}

market_dome_guy_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(eattacker != level.player)
    idamage = 0;

  return idamage;
}

drone_crash_into_car() {
  flag_wait("drone_crash_into_car");
  vh_drone = spawn_vehicle_from_targetname("market_drone_car");
  vh_drone.drivepath = undefined;
  vh_drone maps\_quadrotor::death_fx();
  vh_drone lights_off();
  vh_drone.takedamage = 0;
  vh_drone go_path(getvehiclenode(vh_drone.target, "targetname"));
  v_damage = vh_drone.origin + vectorscale((0, 0, 1), 20.0);

  if(isDefined(vh_drone)) {
    vh_drone.takedamage = 1;
    vh_drone.delete_on_death = 1;
    vh_drone notify("death");

    if(!isalive(vh_drone))
      vh_drone delete();

    radiusdamage(v_damage, 200, 2800, 2650);
    playfx(level._effect["quadrotor_crash"], v_damage, (1, 0, 0), (0, 0, 1));
  }
}

setup_scenes() {
}

melee_01_terrorist(ai) {
  self endon("death");
  self.overrideactordamage = ::take_player_damage_only;
  self thread melee_01_terrorist_cancel();
  self.ignoreme = 1;
  self.ignoreall = 1;
  self waittill("goal");
  scene_wait("melee_01");
  self.ignoreme = 0;
  self.ignoreall = 0;
}

melee_01_terrorist_cancel() {
  self waittill("death");
  end_scene("melee_01");
}

melee_01_yemeni() {
  self endon("death");
  self thread take_player_damage_only_for_scene("melee_01");
  self thread melee_01_yemeni_cancel();
  self.ignoreme = 1;
  self.ignoreall = 1;
  self waittill("goal");
  scene_wait("melee_01");
  self.ignoreme = 0;
  self.ignoreall = 0;
}

melee_01_yemeni_cancel() {
  self waittill("death");
  end_scene("melee_01");
  ai_terrorist = getent("melee_01_terrorist", "targetname");

  if(isalive(ai_terrorist))
    ai_terrorist ragdoll_death();
}

car_flip_guy01(ai) {
  ai endon("death");
  ai thread take_player_damage_only_for_time(5);
}

car_flip_guy02(ai) {
  car_flip_guy01(ai);
}

car_flip_car(car) {
  scene_wait("car_flip");
  clip = getent("car_flip_clip", "targetname");
  clip trigger_off();
  clip connectpaths();
  clip delete();
}

rolling_door1_01(ai) {
  ai thread take_player_damage_only_for_time(7);
}

rolling_door1_02(ai) {
  rolling_door1_01(ai);
}

rolling_door_2_01(ai) {
  ai thread take_player_damage_only_for_time(7);
}

rolling_door_2_02(ai) {
  rolling_door_2_01(ai);
}

die_behind_player(s_market_exit) {
  if(!isDefined(level.market_ai))
    level.market_ai = [];

  self.market_position = distance2dsquared(self.origin, s_market_exit.origin);
  n_index = 0;

  for(i = 0; i < level.market_ai.size; i++) {
    n_index = i;

    if(self.market_position >= level.market_ai[i].market_position) {
      break;
    }
  }

  arrayinsert(level.market_ai, self, n_index);
  self waittill("death");

  if(isDefined(self))
    arrayremovevalue(level.market_ai, self);
  else {
    __new = [];

    foreach(__key, __value in level.market_ai) {
      if(isDefined(__value)) {
        if(isstring(__key)) {
          __new[__key] = __value;
          continue;
        }

        __new[__new.size] = __value;
      }
    }

    level.market_ai = __new;
  }
}

kill_behind_player() {
  max_market_ai = 24;

  max_market_ai = 15;

  level endon("out_of_market");

  while(true) {
    wait 0.05;
    n_ai = getaicount();
    n_kill = clamp(n_ai - max_market_ai, 0, level.market_ai.size);

    if(n_kill > 0) {
      v_eye = level.player geteye();
      i = 0;

      while(n_kill > 0 && i < level.market_ai.size) {
        ai = level.market_ai[i];

        if(isalive(ai) && ai.takedamage && !isDefined(ai.overrideactordamage)) {
          if(ai sightconetrace(v_eye, level.player) < 0.1)
            ai delete();
          else
            ai thread bloody_death();

          n_kill--;
          arrayremoveindex(level.market_ai, i);
        } else
          i++;
      }
    }
  }
}

yemen_market_clean_up() {
  flag_wait("market_fallback_01");
  cleanup("courtyard_wounded", "script_noteworthy");
  flag_wait("out_of_market");
  maps\_colors::kill_color_replacements();
  a_ai = get_ai_array("market_yemeni", "script_string");
  array_delete(a_ai);
  a_ai = get_ai_array("market_terrorist", "script_string");
  array_delete(a_ai);
  a_ai = get_ai_array("court_terrorists_ai", "targetname");
  array_delete(a_ai);
  cleanup("market_drones", "script_noteworthy");
  cleanup("market_vtol", "targetname");
  cleanup("market_wounded", "script_noteworthy");
  cleanup("courtyard_wounded", "script_noteworthy");
  level thread maps\yemen_amb::yemen_drone_control_tones(0);
}

market_vtol_crash() {
  level thread run_scene_and_delete("market_vtol_loop");
  flag_wait("player_leaves_stage");
  m_vtol = getent("market_vtol", "targetname");
  m_vtol setforcenocull();
  trigger_wait("market_vtol_crash");
  level thread market_vtol_crash_damage();
  queue_dialog_ally("cd0_vtol_overhead_bring_0");
  queue_dialog_ally("cd1_fire_the_rpg_0");
  s_stinger_start = getstruct("vtol_crash_stinger_start", "targetname");
  magicbullet("usrpg_magic_bullet_sp", s_stinger_start.origin, m_vtol.origin - vectorscale((0, 0, 1), 32.0));
  wait 0.8;
  m_vtol vehicle_toggle_sounds(0);
  level thread run_scene("mvtol_pilot");
  run_scene_and_delete("market_vtol_crash");
  trigger_use("market_friendly_moveup_40");
}

market_vtol_crash_callback(veh) {
  level notify("fxanim_vtol1_crash_start");
  level thread market_vtol_crash_shake(veh.origin);
}

market_vtol_crash_shake(v_org) {
  earthquake(0.3, 0.5, v_org, 2000);
  playrumbleonposition("artillery_rumble", level.player.origin);
  queue_dialog_ally("cd2_got_it_it_s_coming_0");
  queue_dialog_ally("cd1_look_out_0");
  wait 3;
  earthquake(0.5, 4, v_org, 2000);
  level.player rumble_loop(3, 1, "crash_heli_rumble");
  queue_dialog_ally("cd0_walla_cheering_at_0");
  level thread vo_market_end();
}

market_vtol_crash_damage() {
  enemies = getaiarray("axis");

  foreach(guy in enemies) {
    if(isDefined(guy))
      guy.health = 1;
  }

  level waittill("fxanim_vtol1_crash_start");
  crash_struct = getstruct("vtol_crash_damage", "targetname");
  wait 5;
  radiusdamage(crash_struct.origin, 256, 200, 100);
}

vtol_shooter_damage_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(isDefined(eattacker) && isplayer(eattacker))
    return idamage;
  else
    return 0;
}

market_drones_think(str_drone_scene) {
  trigger_wait(str_drone_scene);
  run_scene_and_delete(str_drone_scene);
}

market_wounded_anims_think(str_wounded_anim) {
  trigger_wait(str_wounded_anim);
  run_scene_and_delete(str_wounded_anim);
}

vo_after_speech() {
  flag_wait("speech_end");
  queue_dialog_ally("cd1_protect_menendez_0");
  wait 1;
  queue_dialog_ally("cd2_get_him_out_of_here_0");
  wait 1;
  dialog_start_convo();
  level.player priority_dialog("fari_i_m_here_0");
  level.player priority_dialog("fari_menendez_knows_i_m_0");
  level.player priority_dialog("harp_you_can_t_be_sure_0");
  level.player priority_dialog("fari_it_is_okay_i_am_to_0");
  level.player priority_dialog("harp_we_can_t_give_him_th_0");
  level.player priority_dialog("harp_head_south_through_t_0");
  dialog_end_convo();
}

vo_market() {
  trigger_wait("vo_market", "targetname");
  dialog_start_convo();
  level.player priority_dialog("harp_the_yemeni_forces_wi_0");
  level.player priority_dialog("harp_remember_to_the_ye_0");
  level.player priority_dialog("harp_engage_only_if_you_h_0");
  dialog_end_convo();
}

vo_market_end() {
  if(!flag("kill_rocket_hall_vo")) {
    dialog_start_convo();
    level.player priority_dialog("harp_egghead_listen_to_0");
    level.player priority_dialog("harp_stay_strong_and_i_p_0");
    level.player priority_dialog("fari_yes_1");
    dialog_end_convo();
  }
}

vo_yemenis_fire_at_player() {
  level endon("kill_market_vo");
  dialog_start_convo("yemeni_attacked_player");
  level.player priority_dialog("fari_harper_the_yemeni_0", 1);
  level.player priority_dialog("harp_to_them_you_re_just_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("yemeni_attacked_player");
  level.player priority_dialog("fari_harper_the_yemeni_f_0", 1);
  level.player priority_dialog("harp_stay_outta_their_way_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("yemeni_attacked_player");
  level.player priority_dialog("fari_you_have_to_get_me_o_0", 1);
  level.player priority_dialog("harp_we_can_t_extract_you_0");
  dialog_end_convo();
}

vo_terrorists_fire_at_player() {
  level endon("kill_market_vo");
  dialog_start_convo("player_cover_blown");
  priority_dialog_enemy("enem_traitor_0");
  level.player priority_dialog("fari_harper_they_re_on_0", 1);
  level.player priority_dialog("harp_dammit_farid_i_to_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_cover_blown");
  priority_dialog_enemy("enem_what_are_you_doing_0");
  level.player priority_dialog("fari_they_know_i_m_a_trai_0", 1);
  level.player priority_dialog("harp_fight_your_way_out_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_cover_blown");
  priority_dialog_enemy("enem_get_him_0");
  level.player priority_dialog("fari_they_know_i_m_not_on_0", 1);
  level.player priority_dialog("harp_lose_them_any_way_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_cover_blown");
  priority_dialog_enemy("enem_he_s_turned_against_0");
  level.player priority_dialog("harp_farid_they_re_on_t_0", 1);
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_cover_blown");
  priority_dialog_enemy("enem_he_s_crazy_0");
  level.player priority_dialog("harp_watch_your_fire_far_0", 1);
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_cover_blown");
  priority_dialog_enemy("enem_he_s_fighting_for_th_0");
  level.player priority_dialog("harp_you_got_trouble_far_0", 1);
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_cover_blown");
  priority_dialog_enemy("enem_kill_him_0");
  level.player priority_dialog("harp_get_the_hell_out_of_0", 1);
  dialog_end_convo();
}

vo_kill_terrorists() {
  level endon("kill_market_vo");
  dialog_start_convo("player_killed_terrorists", "player_cover_blown");
  level.player priority_dialog("harp_stay_on_mission_far_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_killed_terrorists", "player_cover_blown");
  level.player priority_dialog("harp_be_careful_farid_0");
  level.player priority_dialog("fari_it_s_okay_no_one_s_0");
  dialog_end_convo();
}

vo_shoot_drones() {
  level endon("kill_market_vo");
  dialog_start_convo("robot_attacked_player", "yemeni_attacked_player");
  level.player priority_dialog("fari_i_m_taking_fire_from_0", 1);
  level.player priority_dialog("harp_return_fire_you_ha_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("robot_attacked_player", "yemeni_attacked_player");
  level.player priority_dialog("fari_i_have_to_engage_the_0", 1);
  level.player priority_dialog("harp_fuck_em_they_re_0");
  dialog_end_convo();
}

vo_fire_at_yemeni() {
  level endon("kill_market_vo");
  dialog_start_convo("player_attacked_yemeni", "yemeni_attacked_player");
  level.player priority_dialog("harp_return_fire_only_if_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_attacked_yemeni", "yemeni_attacked_player");
  level.player priority_dialog("harp_the_yemeni_s_are_on_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_attacked_yemeni", "yemeni_attacked_player");
  level.player priority_dialog("harp_farid_what_the_hel_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_attacked_yemeni", "yemeni_attacked_player");
  level.player priority_dialog("harp_do_not_fire_on_the_y_0");
  dialog_end_convo();
  wait 10;
  dialog_start_convo("player_attacked_yemeni", "yemeni_attacked_player");
  level.player priority_dialog("harp_dammit_farid_do_n_0");
  dialog_end_convo();
}

vo_yemeni_warning() {
  level endon("kill_market_vo");
  dialog_start_convo("yemenis_ahead");
  level.player priority_dialog("harp_yemeni_troops_dead_a_0");
  dialog_end_convo();
  dialog_start_convo("window_explosion_01_started");
  level.player priority_dialog("harp_you_re_walking_strai_0");
  dialog_end_convo();
}

market_vtol_exploder() {
  wait 3;
  exploder(100);
  wait 15;
  stop_exploder(100);
}