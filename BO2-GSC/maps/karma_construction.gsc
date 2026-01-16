/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_construction.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\karma_util;
#include maps\_scene;
#include maps\_objectives;
#include maps\_dialog;
#include maps\_dynamic_nodes;
#include maps\_glasses;
#include maps\_music;
#include maps\karma_arrival;
#include maps\karma_anim;
#include maps\karma_crc;
#include maps\createart\karma_art;
#include maps\_audio;
#include maps\_fxanim;
#include maps\_rusher;

init_flags() {
  flag_init("crc_lights_out");
  flag_init("room_clear");
  flag_init("sal_in_elevator");
  flag_init("player_in_elevator");
  flag_init("escalator_open");
  flag_init("construction_elevator_salazar_open");
  flag_init("construction_elevator_salazar_close");
  flag_init("smoke_thrown");
  flag_init("construction_elevator_group_clear");
  flag_init("elevator_at_club");
}

init_spawn_funcs() {
  add_spawn_function_group("creepers", "script_string", ::anim_interrupt, "e5_guards_cover_fire");
  add_spawn_function_group("creepers", "script_string", ::enemy_goal_update_after_anim);
  add_spawn_function_group("construction_elevator_guys", "targetname", ::enemy_goal_update_after_anim);
  add_spawn_function_group("construction_elevator_guys", "targetname", ::anim_interrupt, "e5_elevator_guard_flash_exit");
  add_spawn_function_group("construction_elevator_guys", "targetname", ::elevator_guys_spawn_func);
  add_spawn_function_group("construction_midguard", "targetname", ::sprint_to_cover);
  getent("construction_rearguard_forward_left", "targetname") add_spawn_function(::rearguard_advance, "left");
  getent("construction_rearguard_forward_right", "targetname") add_spawn_function(::rearguard_advance, "right");
  getent("construction_rearguard_back_left", "targetname") add_spawn_function(::favor_blindfire);
  getent("construction_elevator_wave2_1", "targetname") add_spawn_function(::change_movemode, "cqb_run");
  getent("construction_elevator_wave2_2", "targetname") add_spawn_function(::change_movemode, "cqb_run");
}

skipto_construction() {
  iprintln("construction_site");

  cleanup_ents("cleanup_checkin");
  cleanup_ents("cleanup_tower");
  cleanup_ents("cleanup_dropdown");
  cleanup_ents("cleanup_spiderbot");
  cleanup_ents("cleanup_crc");
  maps\karma_arrival::deconstruct_fxanims();
  maps\karma_anim::construction_anims();
  maps\karma_crc::init_door_clip();
  maps\karma_crc::init_crc_glass_monster_clip();
  maps\karma_crc::init_tarp_clip();
  level.player maps\createart\karma_art::vision_set_change("sp_karma_crc");
  trigger_off("construction_battle_color_triggers", "script_noteworthy");
  trigger_off("crc_entrance_color_trigger", "targetname");
  add_global_spawn_function("axis", ::change_movemode, "cqb_run");
  level.ai_salazar = init_hero("salazar");
  skipto_teleport("skipto_construction", array(level.ai_salazar));
  level thread trespasser_perk();
  run_scene_and_delete("scene_sal_ready_crc_door");
  level thread run_scene_and_delete("scene_sal_loop_crc_door");
}

main() {
  clear_exit_victims_spawn_funcs();
  level thread contruction_objectives();
  crc_exit_event();
  level.ai_salazar thread sal_think();
  flag_set("draw_weapons");
  flag_wait("karma_gump_club");
  cleanup_ents("cleanup_construction");
}

contruction_objectives() {
  scene_wait("scene_sal_ready_crc_door");
  set_objective(level.obj_meet_karma, getstruct("crc_exit_obj", "targetname"), "breadcrumb");
  flag_wait("scene_sal_exit_crc_door_started");
  set_objective(level.obj_meet_karma, undefined, "remove");
  scene_wait("scene_victim2_exit_crc_door");
  set_objective(level.obj_meet_karma, getstruct("escalator_door_obj", "targetname"), "breadcrumb");
  flag_wait("room_clear");
  set_objective(level.obj_meet_karma, getstruct("club_elevator_obj", "targetname"), "breadcrumb");
  flag_wait("player_in_elevator");
  set_objective(level.obj_meet_karma, undefined, "remove");
}

crc_exit_event() {
  add_global_spawn_function("axis", ::ai_rush_spawn_func);
  autosave_by_name("crc_exit");
  level thread exit_breach_pmcs_dialog();
  bloody_tarp_init();
  scene_wait("scene_sal_ready_crc_door");
  trigger_on("construction_battle_color_triggers", "script_noteworthy");
  trigger_wait("t_sal_crc_door");
  level thread run_scene_and_delete("scene_player_exit_crc_door_loop");
  level.player queue_dialog("sect_open_the_crc_room_do_0");
  waittill_dialog_queue_finished();
  playsoundatposition("evt_crc_door_fast", (5370, -6546, -3519));
  level.ai_salazar disable_react();
  end_scene("scene_player_exit_crc_door_loop");
  level thread run_scene_and_delete("scene_sal_exit_crc_door");
  level thread run_scene_and_delete("scene_victim1_exit_crc_door");
  level thread run_scene_and_delete("scene_victim2_exit_crc_door");
  level thread run_scene_and_delete("scene_player_exit_crc_door");
  flag_wait("crc_lights_out");
  level thread maps\_audio::switch_music_wait("KARMA_POST_CRC", 4);
  crc_door = getent("crc_door", "targetname");
  crc_door movey(60, 2, 0.5, 0.5);
  wait 4.0;
  simple_spawn("ai_con_site_group_a");
  level thread construction_dialog();
  scene_wait("scene_victim2_exit_crc_door");
  level thread autosave_by_name("construction_site");
  level thread escalator_doors_open();
  level.ai_salazar waittill("goal");
  level.ai_salazar enable_react();
  level thread remove_tarp_blockers();
}

bloody_tarp_init() {
  if(is_mature())
    fxanim_delete("fxanim_bloody_tarp_clean");
  else
    fxanim_delete("fxanim_bloody_tarp_bloody");
}

clear_exit_victims_spawn_funcs() {
  getent("victim1", "targetname").spawn_funcs = [];
  getent("victim2", "targetname").spawn_funcs = [];
}

remove_tarp_blockers() {
  foreach(blocker in getentarray("tarp_blocker", "targetname"))
  blocker delete();

  bloody_tarp_blocker = getent("tarp_collision_bloody", "targetname");
  bloody_tarp_blocker notsolid();
  bloody_tarp_blocker connectpaths();
  bloody_tarp_blocker delete();
}

escalator_doors_open() {
  e_left_door = getent("escalator_door_left", "targetname");
  e_right_door = getent("escalator_door_right", "targetname");
  s_left_door_open = getstruct("escalator_door_left_open", "targetname");
  s_right_door_open = getstruct("escalator_door_right_open", "targetname");
  trigger_wait("escalator_door_proximity_trigger");

  foreach(e_trigger in getentarray("construction_battle_color_triggers", "script_noteworthy"))
  e_trigger delete();

  autosave_by_name("crc_exit_cleared");
  getent("crc_door", "targetname") movey(-63, 0.5);
  end_scene("it_mgr_body");
  simple_spawn("escalator_breachers");
  simple_spawn("ai_con_site_group_b");
  simple_spawn("construction_rearguard_forward_left");
  simple_spawn("construction_rearguard_forward_right");
  spawn_manager_enable("sm_rearguard_left");
  spawn_manager_enable("sm_rearguard_right");
  level thread creeper();
  level thread leaper_spawn();
  level thread mantler_spawn();
  level thread midguard_spawn_think();
  level thread elevator_spawn();
  level thread run_scene_and_delete("call_reinforcements");
  level thread run_scene_and_delete("escalator_door_kick");
  wait 0.15;
  e_left_door playsound("evt_door_kick");
  e_left_door rotateyaw(-120.0, 0.4);
  e_right_door rotateyaw(140.0, 0.25);
  flag_set("room_clear");
  wait 0.4;
  e_left_door connectpaths();
  e_right_door connectpaths();
  wait 1.0;
  level.ai_salazar set_goalradius(8);
  level.ai_salazar set_goal_node(getnode("escalator_door_salazar_pos", "targetname"));
}

midguard_spawn_think() {
  waittill_either_function(::trigger_wait, "spawn_rearmidguard", ::waittill_ai_group_cleared, "construction_group2");
  simple_spawn("construction_midguard");
}

sprint_to_cover() {
  self endon("death");
  self change_movemode("cqb_sprint");
  self waittill("goal");
  self reset_movemode();
}

rearguard_advance(str_side) {
  nd_target = getnode(self.target, "targetname");
  self waittill("death");
  ai_back = getent("construction_rearguard_back_" + str_side + "_ai", "targetname");

  if(isalive(ai_back))
    ai_back setgoalnode(nd_target);
}

sal_think() {
  waittill_either_function(::trigger_wait, "construction_color_trigger1", ::waittill_ai_group_cleared, "construction_group2");
  trigger_use("construction_color_trigger1");
  flag_wait("construction_elevator_group_clear");
  setmusicstate("KARMA_ELEVATOR");
  level thread play_elevator_03_anim();
  level.ai_salazar set_goalradius(8);
  level.ai_salazar setgoalnode(getnode("salazar_elevator_wait_position", "targetname"));
  trigger_wait("t_elevator_3_anims");
  level.ai_salazar setmodel("c_usa_unioninsp_salazar_cin_highlod_fb");
  level.ai_salazar setforcenocull();
  level thread run_scene("scene_sal_elevator_enter");
  flag_wait("construction_elevator_salazar_open");
  s_club_elevator_left_open = getstruct("salazar_elevator_left_side_open", "targetname");
  s_club_elevator_right_open = getstruct("salazar_elevator_right_side_open", "targetname");
  s_club_elevator_left_close = getstruct("salazar_elevator_left_side_close", "targetname");
  s_club_elevator_right_close = getstruct("salazar_elevator_right_side_close", "targetname");
  e_club_elevator_left_door = getent("salaazar_left_side", "targetname");
  e_club_elevator_right_door = getent("salaazar_right_side", "targetname");
  level thread run_scene_and_delete("salazar_elevator_open");
  e_club_elevator_left_door moveto((s_club_elevator_left_open.origin[0], s_club_elevator_left_open.origin[1], e_club_elevator_left_door.origin[2]), 1.5);
  e_club_elevator_right_door moveto((s_club_elevator_right_open.origin[0], s_club_elevator_right_open.origin[1], e_club_elevator_right_door.origin[2]), 1.5);
  flag_wait("construction_elevator_salazar_close");
  level thread run_scene_and_delete("salazar_elevator_close");
  e_club_elevator_left_door moveto((s_club_elevator_left_close.origin[0], s_club_elevator_left_close.origin[1], e_club_elevator_left_door.origin[2]), 1.5);
  e_club_elevator_right_door moveto((s_club_elevator_right_close.origin[0], s_club_elevator_right_close.origin[1], e_club_elevator_right_door.origin[2]), 1.5);
}

creeper() {
  flag_wait("spawn_creepers");
  level thread run_scene_and_delete("e5_guards_cover_fire");
}

anim_interrupt(str_scene) {
  level endon("interrupt_" + str_scene);
  self endon("death");

  while(!flag(str_scene + "_done")) {
    if(distance2dsquared(self.origin, level.player.origin) <= 65536) {
      end_scene(str_scene);
      level notify("interrupt_" + str_scene);
    }

    wait 0.05;
  }
}

enemy_goal_update_after_anim() {
  self endon("death");
  self waittill("goal");
  set_goal_node(getnode(self.target, "targetname"));
}

leaper_spawn() {
  e_leaper_target = getent("leaper_target", "targetname");
  nd_leaper_goal = getnode("leaper_goal", "targetname");
  nd_leaper_cover = getnode("leaper_cover", "targetname");
  ai_leaper = simple_spawn_single("leaper");
  ai_leaper endon("death");
  ai_leaper shoot_at_target(e_leaper_target);
  ai_leaper change_movemode("cqb_sprint");
  ai_leaper thread force_goal(nd_leaper_goal, 8);
  ai_leaper waittill("goal");
  ai_leaper thread force_goal(nd_leaper_cover, 8);
  ai_leaper waittill("goal");
  ai_leaper change_movemode("cqb_run");
}

mantler_spawn() {
  e_mantler_target = getent("mantler_target", "targetname");
  nd_mantler_goal = getnode("mantler_goal", "targetname");
  nd_mantler_cover = getnode("mantler_cover", "targetname");
  ai_mantler = simple_spawn_single("mantler");
  ai_mantler endon("death");
  ai_mantler shoot_at_target(e_mantler_target, undefined, 0.0, 0.25);
  ai_mantler change_movemode("cqb_sprint");
  ai_mantler thread force_goal(nd_mantler_goal, 8);
  ai_mantler waittill("goal");
  ai_mantler thread force_goal(nd_mantler_cover, 8);
  ai_mantler waittill("goal");
  ai_mantler change_movemode("cqb_run");
}

favor_blindfire() {
  self.a.favorblindfire = 1;
}

elevator_spawn() {
  trigger_wait("construction_elevator_spawn_trigger");
  remove_global_spawn_function("axis", ::ai_rush_spawn_func);
  level notify("stop_rushers");
  queue_dialog_enemy("pmc2_throw_smoke_0");
  flag_set("smoke_thrown");
  level clientnotify("club_music_duck");
  s_e3_left_open = getstruct("e3_left_side_open", "targetname");
  s_e3_right_open = getstruct("e3_right_side_open", "targetname");
  e_e3_left_door = getent("e3_left_side_top", "targetname");
  e_e3_right_door = getent("e3_right_side_top", "targetname");
  e_elevator_door = getent("club_elevator_door", "targetname");
  m_elevator = getent("club_elevator_model", "targetname");
  m_elevator thread play_fx("elevator_light", undefined, undefined, "elevator_flashlight_off", 1, "tag_flashlight");
  m_elevator thread play_fx("elevator_lights", m_elevator gettagorigin("tag_origin") + (37.5, 27.5, 141), (0, 0, 0), "elevator_flashlight_off", 1);
  m_elevator thread play_fx("elevator_lights", m_elevator gettagorigin("tag_origin") + (-37.5, 27.5, 141), (0, 0, 0), "elevator_flashlight_off", 1);
  m_elevator thread play_fx("elevator_lights", m_elevator gettagorigin("tag_origin") + (37.5, -27.5, 141), (0, 0, 0), "elevator_flashlight_off", 1);
  m_elevator thread play_fx("elevator_lights", m_elevator gettagorigin("tag_origin") + (-37.5, -27.5, 141), (0, 0, 0), "elevator_flashlight_off", 1);
  m_elevator add_cleanup_ent("outer_solar");
  playsoundatposition("amb_elevator_pmc_bell", (3398, -4304, -3615));
  wait 0.5;
  playsoundatposition("amb_elevator_pmc_open", (3398, -4304, -3615));
  level thread run_scene("club_elevator_open");
  e_elevator_door notsolid();
  e_e3_left_door moveto((e_e3_left_door.origin[0], s_e3_left_open.origin[1], e_e3_left_door.origin[2]), 1.5);
  e_e3_right_door moveto((e_e3_right_door.origin[0], s_e3_right_open.origin[1], e_e3_right_door.origin[2]), 1.5);
  wait 0.45;
  playsoundatposition("evt_karma_smoke_grenade", (3537, -4648, -3596));
  wait 0.55;
  exploder(550);
  wait 3.0;
  e_elevator_door connectpaths();
  getent(e_e3_left_door.target, "targetname") connectpaths();
  getent(e_e3_right_door.target, "targetname") connectpaths();
  level thread run_scene_and_delete("e5_elevator_guard_flash_exit");
  wait 2.0;
  ai_guard = simple_spawn_single("construction_elevator_wave2_1");

  if(isalive(ai_guard))
    ai_guard thread force_goal(getnode(ai_guard.target, "targetname"));

  wait 1.0;
  ai_guard = simple_spawn_single("construction_elevator_wave2_2");

  if(isalive(ai_guard))
    ai_guard thread force_goal(getnode(ai_guard.target, "targetname"));

  waittill_ai_group_ai_count("construction_elevator_group", 0);
  flag_set("construction_elevator_group_clear");
}

elevator_guys_spawn_func() {
  self endon("death");
  self change_movemode("sprint");
  self waittill("goal");
  self reset_movemode();
}

play_elevator_03_anim() {
  e_e3_left_door = getent("e3_left_side_top", "targetname");
  e_e3_right_door = getent("e3_right_side_top", "targetname");
  s_e3_left_close = getstruct("e3_left_side_close", "targetname");
  s_e3_right_close = getstruct("e3_right_side_close", "targetname");
  s_club_elevator_left_open = getstruct("club_elevator_left_side_open", "targetname");
  s_club_elevator_right_open = getstruct("club_elevator_right_side_open", "targetname");
  s_club_elevator_left_close = getstruct("club_elevator_left_side_close", "targetname");
  s_club_elevator_right_close = getstruct("club_elevator_right_side_close", "targetname");
  e_club_elevator_left_door = getent("e3_left_side", "targetname");
  e_club_elevator_right_door = getent("e3_right_side", "targetname");
  e_p_align = getent("align_elevator_last", "targetname");
  e_elevator = getent("club_elevator", "targetname");
  e_elevator_door = getent("club_elevator_door", "targetname");
  nd_elevator_exit_node = getnode("elevator_exit_node", "targetname");
  level.sound_elevator2_ent_1 = spawn("script_origin", level.player.origin);
  e_elevator_door linkto(e_elevator);
  s_club_origin = getstruct("club_floor_origin", "targetname");
  m_tag_origin = spawn("script_model", e_p_align.origin);
  m_tag_origin setmodel("tag_origin");
  m_tag_origin.angles = e_p_align.angles;
  m_tag_origin linkto(e_elevator);
  e_elevator setmovingplatformenabled(1);
  trigger_wait("t_elevator_3_anims");
  flag_set("player_in_elevator");
  flag_set("holster_weapons");
  level notify("offices_cleared");
  e_elevator_door solid();
  setsaveddvar("g_speed", 110);
  wait 5.0;
  level.player playsound("amb_elevator_2_button");
  level.player playsound("amb_elevator_2_close");
  level.player playloopsound("amb_elevator_2_loop", 3);
  level thread run_scene("club_elevator_close");
  e_e3_left_door moveto((e_e3_left_door.origin[0], s_e3_left_close.origin[1], e_e3_left_door.origin[2]), 1.5);
  e_e3_right_door moveto((e_e3_right_door.origin[0], s_e3_right_close.origin[1], e_e3_right_door.origin[2]), 1.5);
  e_elevator disconnectpaths();
  getent(e_e3_left_door.target, "targetname") disconnectpaths();
  getent(e_e3_right_door.target, "targetname") disconnectpaths();
  e_e3_left_door waittill("movedone");
  end_scene("scene_sal_elevator_enter");
  wait 0.05;
  level clientnotify("sndDuckSolarOff");
  level clientnotify("club_music_duck_off");
  e_p_align linkto(e_elevator);
  e_elevator_model = getent("club_elevator_model", "targetname");
  e_elevator_model linkto(e_elevator);
  e_elevator moveto(s_club_origin.origin, 10.0);
  level thread load_gump("karma_gump_club");
  e_elevator waittill("movedone");
  level.player playsound("amb_elevator_2_stop");
  level.player playsound("amb_elevator_2_bell");
  level.player stoploopsound(1);
  e_elevator_model unlink();
  flag_wait("karma_gump_club");
  e_club_elevator_left_door moveto((e_club_elevator_left_door.origin[0], s_club_elevator_left_open.origin[1], e_club_elevator_left_door.origin[2]), 1.5);
  e_club_elevator_right_door moveto((e_club_elevator_right_door.origin[0], s_club_elevator_right_open.origin[1], e_club_elevator_right_door.origin[2]), 1.5);
  run_scene_and_delete("club_elevator_open");
  flag_set("elevator_at_club");
  level thread maps\_fxanim::fxanim_delete("fxanim_construction");
  level.player unlink();
  m_tag_origin delete();
  e_elevator_door notsolid();
  trigger_wait("club_elevator_door_close_trigger");
  e_elevator_door solid();
  e_club_elevator_left_door moveto((e_club_elevator_left_door.origin[0], s_club_elevator_left_close.origin[1], e_club_elevator_left_door.origin[2]), 1.5);
  e_club_elevator_right_door moveto((e_club_elevator_right_door.origin[0], s_club_elevator_right_close.origin[1], e_club_elevator_right_door.origin[2]), 1.5);
  run_scene_and_delete("club_elevator_close");
  getent("club_elevator_model", "targetname") notify("elevator_flashlight_off");
  wait 8;

  if(isDefined(level.sound_elevator_ent_1))
    level.sound_elevator2_ent_1 delete();
}

exit_breach_pmcs_dialog() {
  s_pmc = getent("spiderbot_pmc_speaker", "targetname");
  s_pmc say_dialog("pa_access_denied_0", 0);
  s_pmc say_dialog("pmc3_open_damn_it_0", 0.5);
  level.ai_salazar thread queue_dialog("sala_section_you_hear_t_0", 0);
  level.player thread queue_dialog("sect_farid_we_have_enem_0");
  s_pmc say_dialog("pa_access_denied_1", 0);
  s_pmc say_dialog("pmc3_son_of_a_bitch_0", 0.5);
}

construction_dialog() {
  queue_dialog_enemy("pmc1_here_they_come_2");
  queue_dialog_enemy("pmc2_return_fire_0", 3);
  level.player queue_dialog("sect_harper_karma_is_no_0", 1.0);
  queue_dialog_enemy("pmc3_keep_them_pinned_dow_0");
  level.player queue_dialog("harp_got_it_nice_0", 0.5);
  level.player queue_dialog("sect_she_s_in_club_solar_0", 0.5);
  level.player queue_dialog("harp_i_m_on_it_0", 0.5);
  queue_dialog_enemy("pmc3_keep_them_pinned_dow_0");
  wait(randomfloatrange(3, 10));
  queue_dialog_enemy("pmc4_don_t_let_them_off_t_0");
  wait(randomfloatrange(3, 10));
  queue_dialog_enemy("pmc3_how_many_0");
  queue_dialog_enemy("pmc4_i_count_two_stay_o_0", 2);
  wait(randomfloatrange(3, 10));
  queue_dialog_enemy("pmc1_hold_the_line_0");
  wait(randomfloatrange(3, 10));
  queue_dialog_enemy("pmc4_spread_out_0");
  wait(randomfloatrange(3, 10));
  queue_dialog_enemy("pmc1_draw_them_into_the_c_0");
  flag_wait("smoke_thrown");
  queue_dialog_enemy("pmc1_get_word_to_defalco_0");
  wait(randomfloatrange(3, 10));
  queue_dialog_enemy("pmc2_warn_him_us_military_0");
  wait(randomfloatrange(3, 10));
  queue_dialog_enemy("pmc3_keep_moving_0");
  wait(randomfloatrange(3, 10));
  queue_dialog_enemy("pmc4_fall_back_0");
  wait(randomfloatrange(3, 10));
  queue_dialog_enemy("pmc3_don_t_let_them_reach_0");
}

elevator_vo_mason(ent) {
  level.player say_dialog("sect_salazar_find_anoth_0");
  flag_wait("elevator_vo_mason2");
  level.player say_dialog("sect_i_ll_regroup_with_ha_0");
}

ai_rush_spawn_func() {
  level endon("stop_rushers");
  self endon("death");
  self thread ai_rush_stop();

  if(!isDefined(level.n_ai_rushing))
    level.n_ai_rushing = 0;

  self.canflank = 1;
  self.aggressivemode = 1;
  self.a.disablewoundedset = 1;

  while(true) {
    wait(randomintrange(5, 10));

    if(randomint(100) < 25 && level.n_ai_rushing < 2) {
      level.n_ai_rushing++;
      self.deathfunction = ::ai_rush_death_func;
      self maps\_rusher::rush("stop_rushing");
    }
  }
}

ai_rush_death_func() {
  level thread ai_rush_cooldown();
  return false;
}

ai_rush_cooldown() {
  level endon("stop_rushers");
  wait(randomintrange(15, 20));

  if(level.n_ai_rushing > 0)
    level.n_ai_rushing--;
}

ai_rush_stop() {
  self endon("death");
  level waittill("stop_rushers");
  self.canflank = 0;
  self.aggressivemode = 0;
  self.a.disablewoundedset = 0;
  self.deathfunction = undefined;
  self notify("stop_rushing");
  wait 0.25;
  a_fallbacks = getnodearray("rusher_fallbacks", "targetname");
  nd_fallback = a_fallbacks[0];

  foreach(nd_node in a_fallbacks) {
    if(distance2dsquared(self.origin, nd_node.origin) < distance2dsquared(self.origin, nd_fallback.origin))
      nd_fallback = nd_node;
  }

  self set_goalradius(128);
  self setgoalnode(nd_fallback);
}