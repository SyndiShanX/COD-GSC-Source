/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_gameplay_acquire.gsc
**************************************************************************/

function acquire_init() {
  scripts\engine\utility::flag_init("flag_acquire_aq_driveby");
  scripts\engine\utility::flag_init("flag_acquire_price_in_alley");
  scripts\engine\utility::flag_init("flag_acquire_price_in_traversal_alley");
  scripts\engine\utility::flag_init("flag_acquire_enforcer_alley_1_run");
  scripts\engine\utility::flag_init("flag_acquire_enforcer_at_cover_2");
  scripts\engine\utility::flag_init("flag_acquire_door_open");
  scripts\engine\utility::flag_init("flag_acquire_enforcer_through_door");
  scripts\engine\utility::flag_init("flag_acquire_player_enter_alley");
  scripts\engine\utility::flag_init("flag_acquire_player_mid_alley");
  scripts\engine\utility::flag_init("flag_acquire_player_end_alley");
  scripts\engine\utility::flag_init("flag_acquire_enforcer_door_kick");
  scripts\engine\utility::flag_init("flag_acquire_spawn_aq");
  scripts\engine\utility::flag_init("flag_acquire_player_enter_traversal");
  scripts\engine\utility::flag_init("flag_acquire_player_duck_under");
  scripts\engine\utility::flag_init("flag_acquire_player_end_traversal");
  scripts\engine\utility::flag_init("flag_acquire_alley_ar_dead");
  scripts\engine\utility::flag_init("flag_acquire_complete");
}

function acquire_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("flag_acquire_complete", "stpetersburg_apartment_script_tr", "stpetersburg_cafe_script_tr");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::spawn_enforcer("start_petersburg_acquire_enforcer");
  thread acquire_enforcer_handler();
  thread acquire_price_handler();
  thread acquire_enemy_handler();
  thread acquire_birds_fly();
  thread acquire_pursuit_timer_handler();
  scripts\engine\utility::flag_wait("flag_acquire_complete");
}

function acquire_birds_fly() {
  scripts\engine\utility::flag_wait("flag_acquire_player_enter_traversal");
  scripts\engine\utility::exploder("birds_fly");
  scripts\engine\utility::flag_wait("flag_acquire_player_duck_under");
  scripts\engine\utility::exploder("birds_fly");
}

function acquire_enemy_handler() {
  scripts\engine\utility::flag_wait("flag_acquire_enforcer_alley_1_run");
  scripts\engine\sp\utility::array_spawn_function_targetname("acquire_alley_bodyguard", &acquire_alley_bodyguard);
  var0 = scripts\engine\sp\utility::spawn_targetname("acquire_alley_bodyguard", 1);
  scripts\engine\sp\utility::array_spawn_function_targetname("acquire_alley_sniper", &acquire_sniper_laser);
  var1 = scripts\engine\sp\utility::spawn_targetname("acquire_alley_sniper", 1);
  scripts\engine\utility::flag_wait("flag_acquire_spawn_aq");
  wait 0.5;
  scripts\engine\sp\utility::array_spawn_function_targetname("acquire_alley_ar", &acquire_alley_fence_guy);
  var2 = scripts\engine\sp\utility::spawn_targetname("acquire_alley_ar", 1);
}

function acquire_alley_bodyguard() {
  self endon("death");
  scripts\engine\sp\utility::set_goal_radius(36);
  scripts\engine\utility::flag_wait("flag_acquire_enforcer_at_cover_2");
  scripts\engine\sp\utility::set_goal_entity(level.player);
  scripts\engine\sp\utility::set_goal_radius(800);
}

function acquire_sniper_laser() {
  var0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["laser_bar"]);
  scripts\anim\shared::forceuseweapon(var0, "primary");
  self laserforceon();
}

function acquire_alley_fence_guy() {
  scripts\engine\sp\utility::set_goal_radius(36);
}

function acquire_pursuit_timer_handler() {
  scripts\engine\utility::flag_wait_all("flag_acquire_enforcer_alley_1_run", "flag_acquire_enforcer_at_cover_2");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_acquire_player_end_alley", 20, undefined, 1);
  scripts\engine\utility::flag_wait("flag_acquire_enforcer_through_door");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_acquire_complete", 20, undefined, 1);
}

function acquire_enforcer_handler() {
  level.enforcer endon("death");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_safe_run();
  level.enforcer scripts\engine\utility::set_movement_speed(300);
  level.enforcer.disablearrivals = 1;
  level.enforcer scripts\engine\sp\utility::disable_ai_color();
  var0 = getnode("acquire_enforcer_cover", "targetname");
  level.enforcer scripts\engine\sp\utility::set_goal_node(var0);
  level.enforcer scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\utility::flag_wait("flag_acquire_enforcer_alley_1_run");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_acquire_price_nowhere_left_to_run();
  var1 = getnode("acquire_enforcer_cover_2", "targetname");
  level.enforcer scripts\engine\sp\utility::set_goal_node(var1);
  level.enforcer scripts\engine\sp\utility::set_goal_radius(16);
  level.enforcer waittill("goal");
  scripts\engine\utility::flag_set("flag_acquire_enforcer_at_cover_2");
  var2 = getnode("acquire_enforcer_cover_3", "targetname");
  level.enforcer scripts\engine\sp\utility::teleport_ai(var2);
  var3 = scripts\engine\utility::getStruct("struct_enforcer_acquire_alley_fence_jump", "targetname");
  var3 scripts\common\anim::anim_first_frame_solo(level.enforcer, "fence_jump");
  scripts\engine\utility::flag_wait("flag_acquire_enforcer_door_kick");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_acquire_price_beyond_the_fence();
  var3 scripts\common\anim::anim_single_solo(level.enforcer, "fence_jump", undefined, 0.6);
  var4 = scripts\engine\utility::getStruct("struct_enforcer_acquire_alley_door_kick", "targetname");
  var4 scripts\sp\anim::anim_reach_solo(level.enforcer, "alley_door_kick");
  thread acquire_door_handler(1);
  var4 scripts\common\anim::anim_single_solo_run(level.enforcer, "alley_door_kick");
  scripts\engine\utility::flag_set("flag_acquire_enforcer_through_door");
  var5 = scripts\engine\utility::getStruct("struct_enforcer_acquire_goal", "targetname");
  level.enforcer scripts\engine\sp\utility::set_goal_pos(var5.origin);
  level.enforcer waittill("goal");
  level.enforcer scripts\engine\sp\utility::enable_ai_color();
}

function acquire_price_handler() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_off();
  scripts\engine\utility::flag_wait("flag_acquire_player_enter_alley");

  if(!scripts\engine\utility::flag("flag_acquire_price_in_alley")) {
    var0 = getnode("node_acquire_price_teleport", "targetname");
    level.price scripts\engine\sp\utility::teleport_ai(var0);
  }

  level.price scripts\engine\sp\utility::enable_ai_color();
  scripts\engine\utility::flag_wait("flag_acquire_player_enter_traversal");

  if(!scripts\engine\utility::flag("flag_acquire_price_in_traversal_alley")) {
    var1 = getnode("node_acquire_price_teleport_2", "targetname");
    level.price scripts\engine\sp\utility::teleport_ai(var1);
  }

  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
  level.price scripts\engine\sp\utility::set_goal_radius(16);
  var2 = scripts\engine\utility::getStruct("acquire_price_fence_duck_struct", "targetname");
  var2 scripts\sp\anim::anim_reach_solo(level.price, "fence_duck");
  var2 scripts\common\anim::anim_single_solo_run(level.price, "fence_duck");
  level.price scripts\engine\sp\utility::enable_ai_color();
  scripts\engine\utility::flag_wait("flag_acquire_enforcer_through_door");
  level.price scripts\engine\sp\utility::disable_ai_color();
  level.price scripts\engine\sp\utility::set_goal_radius(32);
  level.price scripts\common\utility::demeanor_override("sprint");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_acquire_price_keep_on_him();

  if(!scripts\engine\utility::flag("flag_acquire_player_end_traversal")) {
    var3 = getnode("node_acquire_price_at_corner", "targetname");
    level.price scripts\engine\sp\utility::set_goal_node(var3);
  }

  scripts\engine\utility::flag_wait("flag_acquire_player_end_traversal");
  var4 = getnode("node_acquire_price_inside", "targetname");
  level.price scripts\engine\sp\utility::set_goal_node(var4);
}

function acquire_door_handler(var0) {
  if(var0 == 1) {
    wait 0.25;
  }

  scripts\engine\utility::flag_set("flag_acquire_door_open");
  var1 = getEnt("escort_bash_door_clip", "targetname");
  var2 = getEnt("escort_bash_door_r", "targetname");
  var3 = getEnt("escort_bash_door_l", "targetname");
  wait 1.3;
  scripts\engine\utility::exploder("door_fx");
  earthquake(0.2, 0.2, level.player.origin, 300);
  level.player playRumbleOnEntity("light_1s");
  var1 connectpaths();
  var1 delete();
  var2 rotateYaw(-85, 0.25, 0.05, 0.05);
  var3 rotateYaw(85, 0.25, 0.05, 0.05);
}

function acquire_autosave_before_cafe() {
  level endon("missionfailed");
  scripts\engine\utility::flag_wait_all("flag_acquire_alley_ar_dead", "flag_acquire_complete");
  thread scripts\engine\sp\utility::autosave_now();
}