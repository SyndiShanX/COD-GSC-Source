/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_village.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\angola_2_util;
#include maps\_anim;
#include maps\_music;
#include maps\_vehicle;
#include maps\createart\angola_art;
#include maps\angola_jungle_stealth;
#include maps\angola_2_anim;
#include maps\angola_jungle_escape;
#include maps\_audio;

skipto_village() {
  skipto_teleport_players("player_skipto_village");
  load_gump("angola_2_gump_village");
  level.ai_woods = init_hero("woods");
  level.ai_hudson = init_hero("hudson");
  level.ai_hudson detach("c_usa_angola_hudson_glasses");
  level.ai_hudson detach("c_usa_angola_hudson_hat");
  m_radio_tower = getent("radio_tower", "targetname");
  m_radio_tower ignorecheapentityflag(1);
  m_radio_tower setscale(1);
  level.player thread maps\createart\angola_art::village();
  level thread lock_breaker_perk();
  level notify("fxanim_vines_start");
  level thread fxanim_beach_grass_logic();
  level thread exploder_after_wait(250);
  battlechatter_off("axis");
  setmusicstate("ANGOLA_VILLAGE_APPROACH");
  flag_set("fxanim_grass_spawn");
  flag_init("player_failing_stealth");
  triggers = getentarray("player_escaping_village_trigger", "targetname");

  foreach(trigger in triggers)
  trigger trigger_off();
}

clean_up_beartrap_test() {
  a_enemies = getentarray("beartrap_enemy_test_ai", "targetname");

  foreach(ai_enemy in a_enemies)
  ai_enemy delete();
}

init_flags() {
  flag_init("mason_ready_to_enter_hud_window");
  flag_init("mason_ready_to_grab_menendez");
  flag_init("menendez_meatshield_starts");
  flag_init("player_knows_meatshield_controls");
  flag_init("player_completes_meatshield_movement");
  flag_init("meatshield_completed");
  flag_init("village_cleanup");
  flag_init("a_village_complete");
  flag_init("meatshield_enemy_passed_1");
  flag_init("meatshield_enemy_passed_2");
  flag_init("fxanim_grass_scene_claim");
  flag_init("hut_patroller_passed_window");
  flag_init("fake_stealth_spotted");
  flag_init("stop_village_ambient");
  flag_init("player_has_beartraps");
}

main() {
  init_flags();
  level.meatshield_v2 = 1;
  level thread spinning_fan();
  level thread village_spawn_funcs();
  level.ai_hudson set_force_color("r");
  level thread village_patrols_and_guards();
  level thread village_objectives();
  level thread radio_loop();
  level thread meatshield_event();
  flag_wait("a_village_complete");
  maps\angola_jungle_stealth::switch_on_angola_escape_trigges();
  cleanup_ents("meatshield_guys");
  flag_set("village_cleanup");
  wait 0.1;
}

village_spawn_funcs() {
  sp_fail_reinforcement = getentarray("enemy_fail_village", "targetname");
  array_thread(sp_fail_reinforcement, ::add_spawn_function, ::chase_after_target, level.player);
}

village_patrols_and_guards() {
  level thread village_fails();
  level thread playguardwalla();
  maps\angola_2_anim::custom_village_patrol_init();
  level thread run_scene("village_guard_inspect");
  level thread run_scene("village_guard_sitting");
  level thread village_hut_kill();

  for(i = 0; i < 2; i++) {
    ai_enemy = simple_spawn_single("village_guard");
    ai_enemy.anim_index = i;
    ai_enemy thread village_guard_idle_logic();
  }
}

playguardwalla() {
  level endon("stop_village_ambient");
  level endon("fake_stealth_spotted");
  level endon("stop_amb_convo");
  i = 1;
  ent = spawn("script_origin", (-19214, -2232, 698));

  while(true) {
    ent playsound("amb_guard_walla_" + i, "sounddone");
    ent waittill("sounddone");
    wait(randomfloatrange(1.5, 4));

    if(i > 5)
      i = 1;
  }
}

village_hut_kill() {
  level endon("mason_ready_to_enter_hud_window");
  trigger_wait("trigger_kill_player_with_hut");
  ai_array = simple_spawn("je_village_hut_kill_player", maps\angola_jungle_escape::kill_player_regular_logic, "je_village_hut_kill_player", undefined);
}

village_stealth_hint() {
  level endon("stop_village_ambient");
  trigger_wait("trig_hut_patroller");

  if(!level.console && !level.player gamepadusedlast())
    level thread helper_message(&"ANGOLA_2_STEALTH_MASON_USE_GRASS_AS_COVER_PC", 3);
  else
    level thread helper_message(&"ANGOLA_2_STEALTH_MASON_USE_GRASS_AS_COVER", 3);
}

fake_stealth() {
  level endon("stop_village_ambient");
  self endon("death");
  e_foliage = getent("village_foliage", "targetname");
  wait 0.5;

  while(true) {
    n_dist = distance2d(self.origin, level.player.origin);
    str_stance = level.player getstance();

    if(str_stance == "stand" && !flag("hut_patroller_passed_window")) {
      if(n_dist < 512)
        flag_set("fake_stealth_spotted");
    } else if(level.player istouching(e_foliage)) {
      if(str_stance == "prone") {
        if(n_dist < 64)
          flag_set("fake_stealth_spotted");
      } else if(n_dist < 128)
        flag_set("fake_stealth_spotted");
    } else if(str_stance == "prone") {
      if(n_dist < 128)
        flag_set("fake_stealth_spotted");
    } else if(n_dist < 256) {
      if(self is_looking_at(level.player))
        flag_set("fake_stealth_spotted");
    }

    wait 0.05;
  }
}

village_runner_logic() {
  level endon("stop_village_ambient");
  self endon("death");
  self.script_no_threat_update_on_first_frame = 1;
  self.script_noenemyinfo = 1;
  self.script_no_threat_on_spawn = 1;
  self.goalradius = 16;
  self.ignoreall = 1;
  self thread fake_stealth();
  at_last_node = 0;
  nd_next = getnode("runner_start", "targetname");

  while(!at_last_node) {
    self setgoalnode(nd_next);
    wait 2.2;

    if(isDefined(nd_next.target))
      nd_next = getnode(nd_next.target, "targetname");
    else
      at_last_node = 1;

    wait 0.05;
  }

  self waittill("goal");
  self delete();
}

hut_patroller() {
  run_scene_first_frame("hut_patroller");
  ai_patroller = getent("hut_patroller_ai", "targetname");
  ai_patroller endon("death");
  trigger_wait("trig_hut_patroller");
  level thread fail_by_hut_patroller();
  ai_patroller thread fake_stealth();
  ai_patroller thread patroller_logic("hut_patroller_start");
  ai_patroller thread clear_fail_by_hut_patroller();
  ai_patroller.ignoreall = 1;
  run_scene("hut_patroller");
}

clear_fail_by_hut_patroller() {
  level endon("stop_village_ambient");
  self endon("death");
  t_fail = getent("trig_fail_by_hut_patroller", "targetname");

  while(isDefined(t_fail) && self istouching(t_fail))
    wait 0.05;

  flag_set("hut_patroller_passed_window");
  t_fail delete();
}

fail_by_hut_patroller() {
  level endon("hut_patroller_passed_window");
  level endon("stop_village_ambient");
  trigger_wait("trig_fail_by_hut_patroller");
  t_enter_hut = getent("objective_player_enter_hut_trigger", "targetname");

  if(isDefined(t_enter_hut))
    t_enter_hut delete();

  flag_set("fake_stealth_spotted");
}

village_guard_idle_logic(n_index) {
  level endon("stop_village_ambient");
  self endon("death");

  while(true) {
    switch (randomint(4)) {
      case 0:
        str_scene = "idle_bug";
        break;
      case 1:
        str_scene = "idle_smoke";
        break;
      case 2:
        str_scene = "idle_stretch";
        break;
      default:
        str_scene = "idle_normal";
        break;
    }

    add_scene_properties(str_scene, "anim_guard_" + self.anim_index);
    add_generic_ai_to_scene(self, str_scene);
    run_scene(str_scene);
  }
}

radio_loop() {
  radio_loop_sound = spawn("script_origin", (-18601, -3066, 673));
  radio_loop_sound playloopsound("amb_angola_radio_lp");
}

village_objectives() {
  level endon("fake_stealth_spotted");
  wait 0.1;
  t_trigger = getent("objective_player_enter_hut_trigger", "targetname");
  str_struct_name = t_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_find_radio, s_struct, "");
  t_trigger waittill("trigger");
  set_objective(level.obj_find_radio, undefined, "delete");
  flag_set("mason_ready_to_enter_hud_window");
  t_trigger = getent("objective_locates_menendez_in_hut_trigger", "targetname");
  str_struct_name = t_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_mason_grab_menendez, s_struct, "");
  t_trigger waittill("trigger");
  set_objective(level.obj_mason_grab_menendez, undefined, "delete");
  flag_set("mason_ready_to_grab_menendez");
  flag_wait("menendez_meatshield_starts");
  flag_wait("meatshield_completed");
}

meatshield_event() {
  level endon("meatshield_failed");
  g_friendlyfiredist = getdvarint(#"g_friendlyfireDist");
  setsaveddvar("g_friendlyfireDist", 10000);
  level thread run_scene("menendez_radio_room_idle");
  wait 0.5;
  model = get_model_or_models_from_scene("menendez_radio_room_idle", "menendez");
  model.team = "allies";
  model setlookattext("", & "");
  player_enter_the_hut();
  level thread clean_up_village_guards();
  level thread clean_up_beartrap_test();
  level thread run_scene("menendez_meatshield_part_2");
  level thread run_scene("pistol_meatshield_part_2");
  level thread run_scene("grenade_meatshield_part_2");
  level thread run_scene("door_meatshield_part_2");
  level thread run_scene("soldier_meatshield_part_2");
  level thread run_scene("soldier2_meatshield_part_2");
  level thread run_scene("soldier3_meatshield_part_2");
  level thread run_scene("child1_meatshield_part_2");
  level thread run_scene("child2_meatshield_part_2");
  level thread run_scene("child3_meatshield_part_2");
  menendez_model = get_model_or_models_from_scene("menendez_meatshield_part_2", "menendez");
  menendez_model attach("t6_wpn_knife_sog_view", "TAG_WEAPON_RIGHT");
  level thread run_scene("player_meatshield_part_2");
  flag_wait("player_meatshield_part_2_done");
  setsaveddvar("g_friendlyfireDist", g_friendlyfiredist);
  autosave_by_name("meatsield_complete");
  player_restore_weapons();
  clientnotify("esc_alrm");
  setmusicstate("ANGOLA_JUNGLE_ESCAPE");
  flag_set("a_village_complete");
}

player_enter_the_hut() {
  flag_wait("mason_ready_to_enter_hud_window");

  while(isDefined(level.player.planting_beartrap_mortar) && level.player.planting_beartrap_mortar)
    wait 0.05;

  setmusicstate("ANGOLA_MEATSHIELD_APPROACH");
  level thread maps\_audio::switch_music_wait("ANGOLA_GUN_HEAD", 29);
  autosave_by_name("ready_to_enter_the_hut");
  level thread run_scene("player_climb_into_radio_room");
  level thread run_scene("pistol_meatshield_part_1");
  scene_wait("player_climb_into_radio_room");
}

meatshield_fail(n_enemy_encounter) {
  wait 2;

  if(!flag("meatshield_enemy_passed_" + n_enemy_encounter)) {
    level notify("meatshield_failed");
    screen_message_delete();
    level.player disableinvulnerability();
    level.player enablehealthshield(0);
    level.player.overrideplayerdamage = ::meatshield_player_damage_override;
    end_scene("meatshield_idle_" + n_enemy_encounter + "_enemy");
    ai_enemy = getent("meatshield_enemy_" + n_enemy_encounter + "_ai", "targetname");
    ai_enemy setgoalpos(ai_enemy.origin);
    ai_enemy.goalradius = 16;
    ai_enemy.dontmelee = 1;
    ai_enemy shoot_and_kill(level.player);
    missionfailedwrapper(&"ANGOLA_2_MEATSHIELD_FAILURE");
  }
}

meatshield_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  n_damage = level.player.health + 1;
  return n_damage;
}

village_meatshield_events(str_category) {
  level.meatshield_fails = 0;
  level thread run_scene("menendez_radio_room_idle");
  flag_wait("mason_ready_to_enter_hud_window");
  autosave_by_name("ready_to_enter_the_hut");
  str_scene = "player_climb_into_radio_room";
  level thread player_lower_weapons(str_scene);
  run_scene(str_scene);
  flag_wait("mason_ready_to_grab_menendez");
  str_scene_enemy_attack = "meatshield_enemy_attack";
  level thread enemy_enter_meatshield_room(str_scene_enemy_attack);
  player_grabs_menendez_in_meatshield_hold();
  player_speed = 1.62;
  e_menendez = getent("menendez_drone", "targetname");
  level.player thread player_meatshield_move_and_rotate(e_menendez, player_speed);

  while(flag("meatshield_completed") == 0) {
    if(level.meatshield_fails == 1) {
      return;
    }
    wait 0.01;
  }

  delete_scene(str_scene_enemy_attack);
  level thread grenade_explosion_effect();
  level thread run_scene("meatshield_enemy_retreat_guy4");
  run_scene("meatshield_enemy_retreat");
  clientnotify("esc_alrm");
  level notify("stop_amb_convo");
  setmusicstate("ANGOLA_JUNGLE_ESCAPE");
  autosave_by_name("meatsield_complete");
  level.mason_meatshield_weapon delete();
  player_restore_weapons();
  flag_set("a_village_complete");
}

hut_fxanim_notify() {
  wait 19.6;
  level notify("fxanim_hostage_hut_start");
}

enemy_enter_meatshield_room(str_scene_enemy_attack) {
  if(!isDefined(level.meatshield_random_attacker_index)) {
    rval = randomint(999);

    if(rval < 500)
      level.meatshield_random_attacker_index = 0;
    else
      level.meatshield_random_attacker_index = 1;
  } else {
    level.meatshield_random_attacker_index++;

    if(level.meatshield_random_attacker_index > 1)
      level.meatshield_random_attacker_index = 0;
  }

  level thread run_scene(str_scene_enemy_attack);

  if(level.meatshield_random_attacker_index == 0) {
    level thread meatshield_ai_attacker("meatshield_enemy_attack_ai2", "guy_soldier2_ai");
    level thread meatshield_ai_attacker("meatshield_enemy_attack_ai4", "guy_soldier4_ai");
  } else {
    level thread meatshield_ai_attacker("meatshield_enemy_attack_ai2_variation", "guy_soldier2_ai");
    level thread meatshield_ai_attacker("meatshield_enemy_attack_ai4_variation", "guy_soldier4_ai");
  }
}

meatshield_attacker_attack_target(e_target) {
  self.ignoreall = 1;
  self.favoriteenemy = e_target;
  self.script_ignore_suppression = 1;
  self thread aim_at_target(e_target);
  self thread shoot_at_target(e_target, undefined, 0.2, 3);
}

player_grabs_menendez_in_meatshield_hold() {
  str_scene_name = "player_grabs_menendez";
  level thread run_scene(str_scene_name);
  wait 0.1;
  a_rigs = getentarray("player_body", "targetname");
  m_player_rig = a_rigs[0];
  level.m_player_rig = m_player_rig;
  level.mason_meatshield_weapon = spawn_model("t6_wpn_pistol_browninghp_prop_view", level.m_player_rig gettagorigin("tag_weapon1"), level.m_player_rig gettagangles("tag_weapon1"));
  level.mason_meatshield_weapon linkto(level.m_player_rig, "tag_weapon1");
  scene_wait(str_scene_name);
}

player_lower_weapons(str_scene) {
  level.player allowads(0);
  level.player disableweaponcycling();
  level thread switch_to_pistol();
  level.player setlowready(1);
}

player_restore_weapons() {
  level.player enableweaponcycling();
  level.player setlowready(0);
  level.player allowads(1);
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

player_meatshield_move_and_rotate(e_menendez, player_speed) {
  flag_set("menendez_meatshield_starts");
  v_offset = e_menendez.origin - level.m_player_rig.origin;
  v_ang_offset = e_menendez.angles - level.m_player_rig.angles;
  level.meatshield_rot = 0.0;
  level thread meatshield_check_for_player_rotation(1.5);
  s_start = getent("village_meatshield_start_struct", "targetname");
  level.player playerlinktoabsolute(level.m_player_rig, "tag_player");
  level.m_player_rig setanim(level.scr_anim["player_body"]["mason_move_loop"][0], 1, 0, 1);
  e_menendez linkto(level.m_player_rig, "tag_origin", v_offset, v_ang_offset);
  e_menendez setanim(level.scr_anim["menendez"]["walk"][0], 1, 0, 1);
  level thread meatshield_screen_message(3);
  level thread meatshield_player_movement(player_speed);
  meatshield_blend = 0.3;
  rotate_threshold = 20.0;
  back_right_threshold = 40.0;
  back_left_threshold = -40.0;
  n_facing_diff = 0.0;
  e_end = getent("village_meatshield_end_struct", "targetname");
  level thread player_meatshield_facing_rumble(1.0);

  while(flag("player_completes_meatshield_movement") == 0) {
    if(isDefined(level.meatshield_v2) && level.meatshield_v2 == 1) {
      v_end = (e_end.origin[0], e_end.origin[1], 0);
      v_start = (level.m_player_rig.origin[0], level.m_player_rig.origin[1], 0);
      v_norm_vec = vectornormalize(v_end - v_start);
      v_norm_vec = v_norm_vec * -1;
      v_angles = anglestoforward(level.m_player_rig.angles);
      v_angles = vectornormalize(v_angles);
      n_dot = vectordot(v_norm_vec, v_angles);
      n_facing_diff = acos(n_dot);
      v_cross = vectorcross(v_norm_vec, v_angles);

      if(v_cross[2] > 0)
        n_facing_diff = n_facing_diff * -1;

      if(abs(level.meatshield_rot) > rotate_threshold) {
        if(level.meatshield_rot < 0.0) {
          time = 0.0;

          if(n_facing_diff > back_right_threshold) {
            level.m_player_rig setanimknoball( % int_meatshield_angola_player_backright_to_back, % root, 1, meatshield_blend, 1);
            e_menendez setflaggedanimknoball("meatshield_transition", % ai_meatshield_angola_hostage_backright_to_back, % body);
            time = getanimlength( % ai_meatshield_angola_hostage_backright_to_back);
          } else if(n_facing_diff > back_left_threshold) {
            level.m_player_rig setanimknoball( % int_meatshield_angola_player_back_to_backleft, % root, 1, meatshield_blend, 1);
            e_menendez setflaggedanimknoball("meatshield_transition", % ai_meatshield_angola_hostage_back_to_backleft, % body);
            time = getanimlength( % ai_meatshield_angola_hostage_back_to_backleft);
          }
        } else if(n_facing_diff < back_left_threshold) {
          level.m_player_rig setanimknoball( % int_meatshield_angola_player_backleft_to_back, % root, 1, meatshield_blend, 1);
          e_menendez setflaggedanimknoball("meatshield_transition", % ai_meatshield_angola_hostage_backleft_to_back, % body);
          time = getanimlength( % ai_meatshield_angola_hostage_backleft_to_back);
        } else if(n_facing_diff < back_right_threshold) {
          level.m_player_rig setanimknoball( % int_meatshield_angola_player_back_to_backright, % root, 1, meatshield_blend, 1);
          e_menendez setflaggedanimknoball("meatshield_transition", % ai_meatshield_angola_hostage_back_to_backright, % body);
          time = getanimlength( % ai_meatshield_angola_hostage_back_to_backright);
        }

        if(time > 0.0) {
          level.player playrumbleonentity("damage_light");
          wait(time);
        }
      }

      if(n_facing_diff < back_left_threshold) {
        level.player notify("ms_rumble");
        level.m_player_rig setanimknoball( % int_meatshield_angola_player_backleft, % root, 1, meatshield_blend, 1);
        e_menendez setanimknoball( % ai_meatshield_angola_hostage_backleft, % body, 1, meatshield_blend, 1);
      } else if(n_facing_diff > back_right_threshold) {
        level.player notify("ms_rumble");
        level.m_player_rig setanimknoball( % int_meatshield_angola_player_backright, % root, 1, meatshield_blend, 1);
        e_menendez setanimknoball( % ai_meatshield_angola_hostage_backright, % body, 1, meatshield_blend, 1);
      } else {
        level.player notify("ms_rumble");
        level.m_player_rig setanimknoball( % int_meatshield_angola_player_back, % root, 1, meatshield_blend, 1);
        e_menendez setanimknoball( % ai_meatshield_angola_hostage_back, % body, 1, meatshield_blend, 1);
      }
    }

    wait 0.01;
  }

  e_menendez unlink();
  flag_set("meatshield_completed");
}

meatshield_player_movement(player_speed) {
  level endon("meatshield_grenade_explosion");
  e_end = getent("village_meatshield_end_struct", "targetname");
  flag_wait("player_knows_meatshield_controls");

  while(true) {
    v_end = (e_end.origin[0], e_end.origin[1], level.m_player_rig.origin[2]);
    v_dir = vectornormalize(v_end - level.m_player_rig.origin);
    level.m_player_rig.origin = level.m_player_rig.origin + v_dir * player_speed;
    dist = distance(level.m_player_rig.origin, v_end);

    if(dist < player_speed * 3) {
      break;
    }

    wait 0.01;
  }

  flag_set("player_completes_meatshield_movement");
}

meatshield_check_for_player_rotation(rot_scale) {
  level endon("meatshield_grenade_explosion");

  while(flag("player_completes_meatshield_movement") == 0) {
    v_rstick = level.player getnormalizedcameramovement();
    dead_zone = 0.02;
    left_right = v_rstick[1];

    if(left_right < dead_zone && left_right > dead_zone * -1)
      left_right = 0.0;

    level.meatshield_rot = left_right * rot_scale;
    level.meatshield_rot = level.meatshield_rot * -1.0;

    if(level.meatshield_rot != 0.0) {
      v_rot = (0, level.meatshield_rot, 0);
      v_rot = v_rot + level.m_player_rig.angles;
      level.m_player_rig rotateto(v_rot, 0.05);
    }

    wait 0.01;
  }
}

player_meatshield_facing_rumble(min_gap) {
  last_time = 0;

  while(true) {
    level.player waittill("ms_rumble");
    time = gettime();
    dt = (time - last_time) / 1000;

    if(dt > min_gap) {
      last_time = time;
      level.player playrumbleonentity("damage_light");
    }
  }
}

meatshield_screen_message(display_time) {
  screen_message_create(&"ANGOLA_2_RSTICK_MEATSHIELD");
  start_time = gettime();
  rstick_has_moved = 0;

  while(true) {
    time = gettime();
    dt = (time - start_time) / 1000;

    if(dt >= display_time || rstick_has_moved) {
      break;
    }

    wait 0.01;
  }

  screen_message_delete();
  flag_set("player_knows_meatshield_controls");
}

grenade_explosion_effect() {
  level waittill("meatshield_grenade_explosion");
  e_grenade = getent("nada", "targetname");
  playfx(level._effect["def_explosion"], e_grenade.origin);
  clientnotify("grn_dgs");
}

meatshield_ai_attacker(str_enemy_scene, str_enemy_ai_name) {
  level endon("meatshield_failed");
  level thread run_scene(str_enemy_scene);
  start_time = gettime();
  wait 0.1;
  ai_enemy = getent(str_enemy_ai_name, "targetname");
  ai_enemy endon("death");
  ai_enemy.ignoreall = 1;
  ai_enemy.ignoreme = 1;
  ai_enemy.dontmelee = 1;

  while(!isDefined(ai_enemy.meatshield_threat))
    wait 0.01;

  shoot_thread = 0;

  while(true) {
    if(ai_enemy.meatshield_threat == 1 && shoot_thread == 0) {
      shoot_thread = 1;
      ai_enemy thread meatshild_ai_try_and_shoot_target(str_enemy_scene, level.player, 999, 0.5);
    }

    if(ai_enemy.meatshield_threat == 0 && shoot_thread == 1) {
      shoot_thread = 0;
      ai_enemy notify("kill_shoot_thread");
    }

    if(flag("meatshield_completed")) {
      ai_enemy notify("kill_shoot_thread");
      return;
    }

    wait 0.01;
  }
}

meatshild_ai_try_and_shoot_target(str_enemy_scene, e_target, attack_time, player_initial_prep_time) {
  self endon("death");
  level endon("meatshield_failed");
  self endon("kill_shoot_thread");
  min_dot = 0.8;
  max_allowed_missed_frames = 2;
  num_missed = 0;
  start_time = gettime();

  while(true) {
    time = gettime();
    dt = (time - start_time) / 1000;

    if(dt >= player_initial_prep_time) {
      v_dir = vectornormalize(self.origin - e_target.origin);
      v_forward = anglestoforward(e_target.angles);
      dot = vectordot(v_dir, v_forward);

      if(dot < min_dot) {
        num_missed++;

        if(num_missed >= max_allowed_missed_frames) {
          level thread meatshield_attacker_scene_fails();
          wait 5;
          return;
        }
      }
    }

    if(self.meatshield_threat == 0) {
      break;
    }

    if(flag("meatshield_completed")) {
      break;
    }

    if(dt >= attack_time) {
      break;
    }

    wait 0.01;
  }
}

meatshield_attacker_scene_fails() {
  level.meatshield_fails = 1;
  level notify("meatshield_failed");
  e_soldier = getent("guy_soldier_ai", "targetname");
  e_soldier2 = getent("guy_soldier2_ai", "targetname");
  e_soldier4 = getent("guy_soldier4_ai", "targetname");
  end_scene("meatshield_enemy_attack");
  end_scene("meatshield_enemy_attack_ai2");
  end_scene("meatshield_enemy_attack_ai4");
  wait 0.01;
  e_soldier.ignoreall = 1;
  e_soldier2 meatshield_attacker_attack_target(level.player);
  e_soldier4 meatshield_attacker_attack_target(level.player);
  wait 1.75;
  missionfailedwrapper(&"ANGOLA_2_MEATSHIELD_FAILURE");
}

spinning_fan() {
  e_fan = getent("fan_spin", "targetname");
  yaw_angle = -360;
  rotate_time = 2.0;

  while(true) {
    e_fan rotateyaw(yaw_angle, rotate_time);
    e_fan waittill("rotatedone");

    if(flag("village_cleanup")) {
      break;
    }
  }
}

clean_up_village_guards() {
  t_sm_village_fail = getent("sm_fail_village", "targetname");
  t_sm_village_fail delete();
  a_enemies = getentarray("village_guards", "script_noteworthy");

  foreach(e_enemy in a_enemies)
  e_enemy delete();

  flag_set("stop_village_ambient");
}

village_fails() {
  level.player thread fail_by_firing();
  level.player thread fail_by_grenade_throw();
  level thread fail_by_spotted();
  level thread fail_by_fake_spotted();
  level thread fail_left();
  level thread fail_right();
}

village_fail_general_logic() {
  flag_set("stop_village_ambient");
  flag_set("fake_stealth_spotted");
  t_enter_hut = getent("objective_player_enter_hut_trigger", "targetname");

  if(!isDefined(t_enter_hut)) {
    missionfailedwrapper(&"ANGOLA_2_STEALTH_FAIL_VILLAGE");
    return;
  }

  t_enter_hut delete();
  end_scene("hut_patroller");
  end_scene("village_guard_inspect");
  end_scene("village_guard_sitting");
  end_scene("idle_normal");
  end_scene("idle_bug");
  end_scene("idle_smoke");
  end_scene("idle_stretch");
  a_enemies = getentarray("village_guards", "script_noteworthy");

  foreach(e_enemy in a_enemies) {
    if(isalive(e_enemy)) {
      e_enemy.ignoreall = 0;
      e_enemy anim_stopanimscripted();
      e_enemy thread chase_after_target(level.player);
    }
  }

  trigger_use("sm_fail_village");
  set_objective(level.obj_find_radio, undefined, "delete");
  level.player s3_player_fail("village");
}

fail_by_firing() {
  level endon("stop_village_ambient");

  while(true) {
    self waittill("weapon_fired", weapon);

    if(isDefined(weapon) && issubstr(weapon, "bear"))
      continue;
    else
      break;
  }

  level thread village_fail_general_logic();
}

fail_by_grenade_throw() {
  level endon("stop_village_ambient");

  while(true) {
    self waittill("grenade_fire", grenade, grenade_name);

    if(isDefined(grenade_name) && issubstr(grenade_name, "bear"))
      continue;
    else
      break;
  }

  level thread village_fail_general_logic();
}

fail_by_spotted() {
  level endon("stop_village_ambient");
  flag_wait("_stealth_spotted");
  level thread village_fail_general_logic();
}

fail_by_fake_spotted() {
  level endon("stop_village_ambient");
  flag_wait("fake_stealth_spotted");
  level thread village_fail_general_logic();
}

fail_left() {
  level endon("stop_village_ambient");
  trigger_wait("trig_alert_village_left");
  level thread village_fail_general_logic();
}

fail_right() {
  level endon("stop_village_ambient");
  trigger_wait("trig_alert_village_right");
  level thread village_fail_general_logic();
}