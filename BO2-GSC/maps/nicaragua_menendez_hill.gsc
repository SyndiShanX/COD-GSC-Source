/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_menendez_hill.gsc
********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\nicaragua_menendez_rage;
#include maps\_music;
#include maps\_fxanim;

skipto_menendez_hill() {
  skipto_teleport_players("player_skipto_menendez_hill");
  exploder(20);
  exploder(101);
  exploder(320);
  menendez_hill_spawn_funcs();
  simple_spawn("mh_intro");
  level.player rage_high(1);
  level.player thread rage_high_logic("mh_intro", 1);
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
  maps\_fxanim::fxanim_reconstruct("fxanim_bridge_drop");
  model_restore_area("menendez_lower_village");
  model_convert("destructible_cocaine_bundles", "script_noteworthy");
  destructibles_in_area("menendez_lower_village");
}

menendez_hill_vo() {
  level thread menendez_hill_intro_vo();
  trigger_wait("trig_mh_ransack_3");
  n_array_counter = 0;
  a_mh_ents = getentarray("menendez_hill", "script_noteworthy");
  a_mh_vo = array("pdf2_hold_your_ground_0", "pdf2_it_s_menendez_he_l_0", "pdf3_stop_where_you_are_0");

  while(a_mh_ents.size > 0) {
    ai_enemy = get_closest_living(level.player.origin, a_mh_ents);

    if(isalive(ai_enemy)) {
      ai_enemy say_dialog(a_mh_vo[n_array_counter]);
      n_array_counter++;

      if(n_array_counter == a_mh_vo.size) {
        a_mh_vo = random_shuffle(a_mh_vo);
        n_array_counter = 0;
      }

      wait 55;
    }

    wait 0.05;
    a_mh_ents = getentarray("menendez_hill", "script_noteworthy");
  }
}

menendez_hill_intro_vo() {
  level endon("menendez_hill_compelete");
  n_pdf_line = 0;
  a_pdf_lines = array("pdf1_general_noriega_0", "pdf1_don_t_let_him_into_t_0", "pdf2_it_s_menendez_he_l_0");

  for(a_mh_intro = getentarray("mh_intro_ai", "targetname"); a_mh_intro.size; a_mh_intro = array_removedead(a_mh_intro)) {
    ai_mh_intro = get_closest_living(level.player.origin, a_mh_intro);
    ai_mh_intro say_dialog_and_waittill_death(a_pdf_lines[n_pdf_line]);
    n_pdf_line++;
  }

  ai_mh_intro = getent("mh_intro_brutality_ai", "targetname");

  if(isalive(ai_mh_intro))
    ai_mh_intro say_dialog("pdf3_stop_where_you_are_0");

  trigger_wait("trig_mh_move_to_front_door");
  ai_mh_intro = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_mh_intro say_dialog("pdf3_commander_menendez_0");
  autosave_by_name("menendez_in_lower_village");
}

skipto_dev_menendez_hill() {
  skipto_teleport_players("player_skipto_menendez_hill");
  level.str_rage_on = 0;
  exploder(101);
  exploder(320);
  menendez_hill_spawn_funcs();
  simple_spawn("mh_intro");
  level.player rage_high(1);
  level.player thread rage_high_logic("mh_intro", 1);
  level.player rage_disable();
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
}

init_flags() {
  flag_init("nicaragua_hill_complete");
}

menendez_hill_spawn_funcs() {
  sp_pdf = getent("mh_front_door_pdf", "targetname");
  sp_pdf add_spawn_function(::menendez_hill_door_front_logic, "mh_door_clip", "mh_door", 90);
  sp_pdf = getent("mh_back_door_pdf", "targetname");
  sp_pdf add_spawn_function(::menendez_hill_door_back_logic, "mh_door_clip", "mh_door", -90);
  sp_pdf = getent("mh_coke_dest_pdf", "targetname");
  sp_pdf add_spawn_function(::fall_destruction);
  sp_pdf add_spawn_function(::trigger_mh_coke_destruction);
  add_spawn_function_group("mh_2nd_floor_left", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mh_2nd_floor_right", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mh_coke_0", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mh_coke_1", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mh_coke_2", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mh_middle_0", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mh_stair_0", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mh_stair_1", "targetname", ::force_goal, undefined, 16);
  add_spawn_function_group("mh_house_0", "targetname", ::menendez_hill_stair_ai_logic);
  global_ai_cleanup_category_set("menendez_hill");
  level clientnotify("fr_on");
}

fall_destruction() {
  while(isDefined(self))
    wait 0.05;

  s_dyn_ents_center = getstruct("struct_mh_coke_dest", "targetname");
  radiusdamage(s_dyn_ents_center.origin, 32, 1, 1);
}

trigger_mh_coke_destruction() {
  self endon("death");
  self allowedstances("stand");
  self.b_not_part_of_rage = 1;
  trigger_wait("trig_mh_coke_dest");
  self bloody_death();
}

main() {
  init_flags();
  level.skip_hill_spawning = 0;
  debug_print_line("nicaragua_menendez_hill");
  level thread nicaragua_hill_objectives();
  level thread menendez_hill_animations();
  level thread nicaragua_hill_spawning();
  level thread menendez_hill_ai_behaviors();
  setmusicstate("NIC_RAGE");
  level thread menendez_hill_brutality_scene();
  level thread menendez_hill_vo();
  battlechatter_on("axis");
  flag_wait("pdf_stop_ignoring_menendez");
  model_restore_area("menendez_execution");
  destructibles_in_area("menendez_execution");
  trigger_wait("trig_execution_scene_setup");
  level notify("menendez_hill_compelete");
}

menendez_hill_ai_behaviors() {
  level thread menendez_hill_ai_vs_ai();
  level thread menendez_hill_retreat_intro();
  level thread menendez_hill_stair_trigger();
}

menendez_hill_stair_trigger() {
  trigger_off("trig_stair");
  level waittill("door_death_front_started");
  trigger_on("trig_stair");
}

menendez_hill_stair_ai_logic() {
  self.maxfaceenemydist = 2048;
  self force_goal(undefined, 16);
}

menendez_hill_retreat_2nd_floor() {
  trigger_wait("objective_hill_trigger");
  nd_coke_2nd_floor = getnode("mh_coke_2nd_open", "script_noteworthy");
  ai_2nd_floor = getnodeowner(nd_coke_2nd_floor);

  if(isalive(ai_2nd_floor))
    ai_2nd_floor fake_rush();
}

menendez_hill_retreat_intro() {
  trigger_wait("trig_mh_intro_brutality_start");
  ai_cartel = simple_spawn_single("mh_cartel_0");
  ai_cartel magic_bullet_shield();
  ai_cartel disable_tactical_walk();
  ai_cartel thread force_goal(undefined, 32);
  level thread pdf_chase_after_cartel(ai_cartel);
  ai_cartel waittill("goal");
  ai_cartel enable_tactical_walk();
  ai_cartel stop_magic_bullet_shield();
}

pdf_chase_after_cartel(ai_cartel) {
  wait 0.15;
  ai_pdf = simple_spawn_single("mh_pdf_0");
  ai_pdf.b_not_part_of_rage = 1;
  ai_pdf.meleealwayswin = 1;
  ai_pdf magic_bullet_shield();
  ai_pdf thread waittill_cartel_died(ai_cartel);
  ai_pdf.a.neversprintforvariation = 1;
  ai_pdf.aggressivemode = 1;
  ai_pdf.disablearrivals = 1;
  ai_pdf.disableexits = 1;
  ai_pdf.favoriteenemy = ai_cartel;
  ai_pdf.goalradius = 16;
  ai_pdf.ignoresuppression = 1;
  ai_pdf.noheatanims = 1;
  ai_pdf.pathenemyfightdist = 16;
  nd_cartel_target = getnode(ai_cartel.target, "targetname");
  ai_pdf setgoalpos(nd_cartel_target.origin);
}

waittill_cartel_died(ai_cartel) {
  self endon("death");
  ai_cartel waittill("death");
  self stop_magic_bullet_shield();
  self.b_not_part_of_rage = 0;
}

menendez_hill_slide_to_cover() {
  trigger_wait("trig_mh_intro_brutality_start");
  run_scene_first_frame("slide_to_cover_no_reach");
  trigger_wait("objective_hill_trigger");
  level thread run_scene("slide_to_cover_no_reach");
}

menendez_hill_ai_vs_ai() {
  trigger_wait("objective_hill_trigger");
  ai_pdf = simple_spawn_single("melee_pdf");
  ai_pdf.goalradius = 32;
  ai_pdf.meleealwayswin = 1;
  ai_pdf.b_not_part_of_rage = 1;
  ai_pdf thread melee_wrestle_logic();
  wait 0.15;
  ai_cartel = simple_spawn_single("mh_cartel_2");
  ai_cartel disable_ai_color();
  ai_cartel thread melee_wrestle_logic();
  ai_cartel waittill("death");

  if(isalive(ai_pdf))
    ai_pdf.b_not_part_of_rage = 0;
}

melee_wrestle_logic() {
  self endon("death");
  self.ignoreall = 1;
  self.a.allow_shooting = 0;
  wait 1;
  self.ignoreall = 0;
  self.a.allow_shooting = 1;
}

menendez_hill_brutality_scene() {
  level thread brutality_scene(2, "anim_brutality_mh_intro", "generic_civ_female", "mh_intro_brutality", undefined, "trig_mh_intro_brutality_start", "vol_hill_civ");
  level thread brutality_scene(1, "anim_brutality_mh_coke", "generic_civ_male", "generic_pdf", "trig_mh_intro_brutality_start", "trig_mh_coke_brutality_start", "vol_hill_civ", 1);
  level thread brutality_scene(2, "anim_brutality_mh_house", "generic_civ_female", "generic_pdf", "trig_mh_house_brutality_idle", "trig_mh_house_brutality_start", "vol_hill_civ");
}

menendez_hill_door_back_logic(str_door_clip, m_door, n_rotate_angle) {
  level endon("door_death_front_started");
  level endon("nicaragua_gump_menendez");
  m_door_clip = getent(str_door_clip, "targetname");

  if(isDefined(m_door_clip)) {
    self door_death_ai_setup();
    self.overrideactordamage = ::door_ai_damage_override;
    level.player thread mh_door_guy_hide_and_show(m_door_clip);
    self waittill("door_death_started");
    level notify("door_death_back_started");
    ai_pdf = getent("mh_front_door_pdf_ai", "targetname");

    if(isalive(ai_pdf))
      ai_pdf delete();

    door_death_path_connect(str_door_clip, m_door, n_rotate_angle);
  }
}

mh_door_guy_hide_and_show(m_door_clip) {
  level endon("door_death_front_started");
  level endon("door_death_back_started");
  level endon("nicaragua_gump_menendez");
  b_is_back_hiding = 0;
  t_hide_and_show = getent("trig_door_guy_show_hide", "targetname");
  ai_back = getent("mh_back_door_pdf_ai", "targetname");
  ai_front = getent("mh_front_door_pdf_ai", "targetname");

  while(isDefined(m_door_clip)) {
    if(self istouching(t_hide_and_show) && (isDefined(b_is_back_hiding) && !b_is_back_hiding)) {
      ai_back show();
      ai_front hide();
      b_is_back_hiding = 1;
    } else if(!self istouching(t_hide_and_show) && (isDefined(b_is_back_hiding) && b_is_back_hiding)) {
      ai_back hide();
      ai_front show();
      b_is_back_hiding = 0;
    }

    wait 0.05;
  }
}

menendez_hill_door_front_logic(str_door_clip, m_door, n_rotate_angle) {
  level endon("door_death_back_started");
  level endon("nicaragua_gump_menendez");
  m_door_clip = getent(str_door_clip, "targetname");

  if(isDefined(m_door_clip)) {
    self door_death_ai_setup();
    self magic_bullet_shield();
    nd_pillar = getnode("pillar_wait", "targetname");
    self setgoalnode(nd_pillar);
    trigger_wait("trig_mh_move_to_front_door");
    m_door_block = getent("mh_door_front_block", "targetname");
    m_door_block connectpaths();
    wait 0.15;
    m_door_block delete();
    nd_front_door = getnode("front_door_wait", "targetname");
    self setgoalnode(nd_front_door);
    self waittill("goal");
    self.overrideactordamage = ::door_ai_damage_override;
    self stop_magic_bullet_shield();
    self waittill("door_death_started");
    level notify("door_death_front_started");
    t_back_door_pdf = getent("trig_mh_back_door_pdf", "targetname");

    if(isDefined(t_back_door_pdf))
      t_back_door_pdf delete();

    ai_pdf = getent("mh_back_door_pdf_ai", "targetname");

    if(isalive(ai_pdf))
      ai_pdf delete();

    door_death_path_connect(str_door_clip, m_door, n_rotate_angle);
  }
}

door_death_ai_setup() {
  self.a.deathforceragdoll = 1;
  self.dontmelee = 1;
  self.grenadeawareness = 0;
  self.maxfaceenemydist = 2048;
  self disable_pain();
  self disable_react();
  self set_ignoreme(1);
  self change_movemode("cqb_walk");
  self.goalradius = 16;
  self.b_not_part_of_rage = 1;
}

door_death_path_connect(str_door_clip, m_door, n_rotate_angle) {
  m_door_clip = getent(str_door_clip, "targetname");
  m_door_clip connectpaths();
  m_door = getent(m_door, "targetname");
  m_door rotateroll(n_rotate_angle, 0.25);
  wait 0.15;
  m_door_clip delete();
}

door_ai_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  n_possible_damage = self.health - n_damage;

  if(n_possible_damage < 1 && !(isDefined(self.b_door_death) && self.b_door_death)) {
    n_damage = 0;
    self thread door_death();
    self.b_door_death = 1;
  }

  return n_damage;
}

door_death() {
  if(self.targetname == "mh_front_door_pdf_ai")
    add_scene_properties("door_death", "anim_mh_door_death_front");
  else
    add_scene_properties("door_death", "anim_mh_door_death_back");

  add_generic_ai_to_scene(self, "door_death");
  level thread run_scene("door_death", 0.15);
}

event_cleanup() {
  global_ai_cleanup_category_clear("menendez_hill");
  spawn_manager_cleanup("menendez_hill_spawn_managers");
  kill_spawnernum(1);
  cleanup_ents("menendez_hill", 5, 10);
}

nicaragua_hill_objectives() {
  level thread objective_breadcrumb(level.obj_menendez_save_josefina, "objective_hill_trigger");
  trigger_wait("objective_hill_trigger");
  autosave_by_name("player_enters_village");
  trigger_wait("objective_middle_village_trigger", "script_noteworthy");
  set_objective(level.obj_menendez_save_josefina, undefined, "remove");
  flag_set("nicaragua_hill_complete");
}

menendez_hill_animations() {
  if(level.skip_hill_spawning == 0)
    level thread mh_ransack_pdf_anims();
}

cartel_react_to_menendez_arrival() {
  self endon("death");
  assert(isDefined(self.script_int), "script_int missing from cartel " + self.targetname + ". This is required for cartel reaction scenes");
  flag_wait("pdf_stop_ignoring_menendez");
  wait(self.script_int * 0.1);
  debug_print_line("playing cartel reactions to Menendez: " + self.script_int);
  run_scene("menendez_intro_cartel_react_" + self.script_int);
}

haycart_enter_village_anim() {
  run_scene_first_frame("village_heycart_scene");
  e_trigger = getent("moving_cart_trigger", "targetname");
  e_trigger waittill("trigger");
  run_scene("village_heycart_scene");
}

mh_ransack_pdf_anims() {
  level thread mh_shot_in_the_back_civs();
}

mh_ransack_pdf_2() {
  run_scene_first_frame("mh_ransack_pdf_2");
  trigger_wait("trig_mh_ransack_2");
  run_scene("mh_ransack_pdf_2");
}

mh_ransack_pdf_3() {
  trigger_wait("trig_mh_ransack_3");
  level thread run_scene("mh_ransack_pdf_3");
}

mh_shot_in_the_back_civs() {
  trigger_wait("trig_mh_intro_brutality_start");
  level thread run_scene("mh_shot_in_the_back_civs");
  wait 3;
  level thread run_scene("mh_civ_carries_civ");
  scene_wait("mh_shot_in_the_back_civs");
  ai_pdf = get_ais_from_scene("mh_shot_in_the_back_civs", "mh_shot_in_the_back_pdf_1");

  if(isalive(ai_pdf))
    ai_pdf setgoalpos(ai_pdf.origin);
}

nicaragua_hill_spawning() {
  if(level.skipto_point == "menendez_hill")
    wait 1;

  kill_spawnernum(0);

  if(level.skip_hill_spawning == 0)
    level thread ladder_ai_drop();
}

shoot_at_targets_ahead_of_me(str_target_names, total_time) {
  self endon("death");
  start_time = gettime();

  while(true) {
    time = gettime();
    dt = (time - start_time) / 1000;

    if(dt >= total_time) {
      break;
    }

    a_ai = getentarray(str_target_names, "targetname");

    if(isDefined(a_ai)) {
      closest_dist = 999999;
      closest_target = a_ai[0];

      for(i = 0; i < a_ai.size; i++) {
        dist = distance(self.origin, a_ai[i].origin);

        if(dist < closest_dist) {
          closest_dist = dist;
          closest_target = a_ai[i];
        }
      }

      fire_delay = 0.3;
      duration = 3;
      self thread shoot_at_target(closest_target, undefined, fire_delay, duration);
      wait(duration);
    }

    wait 0.01;
  }
}

ladder_ai_drop() {
  trigger_wait("trig_mh_move_to_front_door");
  ai_ladder = simple_spawn_single("mh_ladder_guy");
  ai_ladder.ignoreall = 1;
  ai_ladder force_goal(undefined, 16);
  s_ladder = getstruct("ladder_look_at_org", "targetname");
  level.player waittill_player_looking_at(s_ladder.origin, 60, 0);
  level notify("fxanim_bridge_drop_start");
  wait 1;

  if(isalive(ai_ladder)) {
    ai_ladder endon("death");
    ai_ladder.ignoreall = 0;
    ai_ladder.goalradius = 16;
    nd_shack_center = getnode("shack_center", "targetname");
    wait 0.05;
    ai_ladder force_goal(nd_shack_center, 16);
    ai_ladder.goalradius = 2048;
  }
}

ignore_player_as_he_runs_down_the_hill() {
  self waittill_any("grenade_fire", "weapon_fired");
  flag_set("pdf_stop_ignoring_menendez");
}

respawn_cartel_after_intro_spawners_die() {
  level endon("nicaragua_hill_complete");
  waittill_ai_group_count("cartel_village_defenders", 1);
  debug_print_line("starting cartel respawners");
  trigger_use("sm_village_cartel");
}