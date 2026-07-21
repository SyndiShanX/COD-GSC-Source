/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_gameplay_escort.gsc
*****************************************************************/

escort_phase_init() {
  scripts\engine\utility::flag_init("flag_evade_begin");
  scripts\engine\utility::flag_init("flag_evade_down_stairs");
  scripts\engine\utility::flag_init("flag_evade_enter_cafe");
  scripts\engine\utility::flag_init("flag_evade_police_window_vig");
  scripts\engine\utility::flag_init("flag_evade_police_window_alerted");
  scripts\engine\utility::flag_init("flag_police_runby_retreating");
  scripts\engine\utility::flag_init("flag_evade_window_police_dead");
  scripts\engine\utility::flag_init("flag_evade_price_to_flashbang_room");
  scripts\engine\utility::flag_init("flag_evade_spawn_teargas");
  scripts\engine\utility::flag_init("flag_police_driveby_guys_dead");
  scripts\engine\utility::flag_init("flag_player_flashbanged");
  scripts\engine\utility::flag_init("flag_evade_enforcer_flee");
  scripts\engine\utility::flag_init("flag_send_enforcer_out_of_cafe");
  scripts\engine\utility::flag_init("flag_cafe_exit_open");
  scripts\engine\utility::flag_init("flag_enforcer_exited_cafe");
  scripts\engine\utility::flag_init("flag_police_leader_enter_cafe");
  scripts\engine\utility::flag_init("flag_evade_enforcer_left_cafe");
  scripts\engine\utility::flag_init("flag_cafe_price_trigs_deleted");
  scripts\engine\utility::flag_init("flag_evade_police_dead");
  scripts\engine\utility::flag_init("flag_evade_mid_cafe");
  scripts\engine\utility::flag_init("flag_evade_exit_cafe");
  scripts\engine\utility::flag_init("flag_evade_enforcer_clear");
  scripts\engine\utility::flag_init("flag_recover_start");
  scripts\engine\utility::flag_init("flag_recover_complete");
}

evade_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::transient_waittill("flag_evade_spawn_teargas", "stpetersburg_canal_script_tr", "stpetersburg_gauntlet_script_tr");
  waitframe();
  thread scripts\sp\analytics::analytics_kleenex_update("Cafe to van");
  scripts\engine\utility::flag_set("flag_start_escort_containment");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_evade_price_into_cafe();
  thread evade_autosave_in_cafe();
  thread evade_price_handler();
  thread evade_enforcer_handler();
  thread evade_police_handler();
  thread evade_spawn_flashbangs();
  thread evade_player_stray_fail();
  thread evade_player_extra_fire_damage();
  thread evade_player_kill();
  scripts\sp\player::player_movement_state("cqb");
  scripts\engine\utility::flag_wait("flag_evade_enforcer_flee");
  scripts\engine\utility::flag_wait("flag_evade_exit_cafe");
}

evade_enforcer_handler() {
  if(!isDefined(level.enforcer)) {
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer("enforcer_cafe_further_spawn_node");
    level.enforcer scripts\engine\sp\utility::set_goal_pos(level.enforcer.origin);
    level.enforcer scripts\engine\sp\utility::disable_ai_color();
  } else {
    var_0 = getnode("node_enforcer_cafe_room_two", "targetname");
    level.enforcer scripts\engine\sp\utility::teleport_ai(var_0);
    level.enforcer scripts\engine\sp\utility::set_goal_pos(level.enforcer.origin);
    level.enforcer scripts\engine\sp\utility::disable_ai_color();
  }

  waitframe();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_safe_run();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_evade_butcher_taunt();
  thread evade_enforcer_escape_goal();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_send_enforcer_out_of_cafe", 25);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_evade_cafe_pursuit_end", 35);
}

evade_player_stray_fail() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_enemies_spawn");
  var_0 = getEnt("evade_player_stray_trig", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("evade_player_stray_trig");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_pursuit_target_escaping_nag();
  wait 5;

  for(;;) {
    if(level.player istouching(var_0)) {
      scripts\engine\utility::flag_set("disable_autosaves");
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_pursuit_target_escaped_fail();
      wait 2;
      scripts\sp\player_death::set_custom_death_quote(76);
      thread scripts\sp\utility::missionfailedwrapper();
    }

    wait 0.2;
  }
}

evade_price_handler() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::activate_trigger_with_targetname("node_evade_price_cafe_dining_1");
  scripts\engine\utility::flag_wait_either("flag_evade_price_to_flashbang_room", "flag_police_runby_retreating");
  scripts\engine\sp\utility::activate_trigger_with_targetname("price_cafe_fight_police_color");
  childthread trigger_array_wait_then_delete_cafe("price_cafe_sides_color", "targetname");
  scripts\engine\utility::flag_wait("flag_evade_spawn_teargas");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_off();
  scripts\engine\utility::flag_wait_either("flag_evade_exit_cafe", "flag_evade_police_dead");
  thread trigger_array_delete_cafe("price_cafe_sides_color", "targetname");
  waitframe();
  scripts\engine\sp\utility::activate_trigger_with_targetname("price_exit_cafe_stairs_color");
  level.price scripts\common\utility::demeanor_override("sprint");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
}

evade_price_molotov_react_anim() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_evade_exit_cafe");
  level endon("flag_police_leader_enter_cafe");
  var_0 = getnode("cafe_price_molotov_room_node", "targetname");
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::color_node_arrive(var_0);
  wait 0.5;

  if(!isDefined(level.moloachievementvictims))
    level.moloachievementvictims = 0;

  thread scripts\sp\equipment\molotov::molotovburnenemy(level.price, 0, level.price.origin + (0, 0, 8));
  playFXOnTag(level.g_effect["vfx_burn_sml_low"], level.price, "j_elbow_le");
  var_1 = scripts\engine\utility::getStruct("struct_price_molotov_react", "targetname");
  var_1 scripts\common\anim::anim_single_solo(level.price, "evade_price_react_1");
}

trigger_array_wait_then_delete_cafe(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  scripts\engine\utility::waittill_any_ents_array(var_2, "trigger");
  waitframe();
  scripts\engine\utility::array_delete(var_2);
  scripts\engine\utility::flag_set("flag_cafe_price_trigs_deleted");
}

trigger_array_delete_cafe(var_0, var_1) {
  level endon("flag_cafe_price_trigs_deleted");
  var_2 = getEntArray(var_0, var_1);
  scripts\engine\utility::array_delete(var_2);
}

evade_price_shoot_at_ent() {
  level endon("flag_evade_exit_cafe");
  level endon("flag_evade_police_dead");
  var_0 = getEnt("cafe_price_suppress", "targetname");
  level.price setentitytarget(var_0);
  level.price.no_pistol_switch = 1;
  level.price.disablepistol = 1;
  level.price.sidearm = isundefinedweapon();
  level.price.sidearm = "none";
  scripts\engine\utility::flag_wait_either("flag_evade_spawn_teargas", "flag_police_driveby_guys_dead");
  level.price clearentitytarget();
}

evade_police_handler() {
  scripts\engine\utility::flag_wait("flag_evade_police_window_vig");
  thread walla_cafe_reinforcements();
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_driveby", ::evade_police_driveby_handler);
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("evade_police_driveby_vehicle");
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_runby", ::evade_police_runby);
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("evade_police_runby");
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_window_shooter", ::evade_police_window_shooter);
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_window_shooter", ::evade_police_runby_exit);
  var_2 = scripts\engine\sp\utility::array_spawn_targetname("evade_police_window_shooter");
  thread runby_manager(var_1);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_evade_aq_runby();
  scripts\engine\utility::flag_wait("flag_enforcer_exited_cafe");
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_assault_leader", ::evade_police_enter_anim);
  var_3 = scripts\engine\sp\utility::array_spawn_targetname("evade_police_assault_leader");
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_assault", ::evade_police_assault);
  var_4 = scripts\engine\sp\utility::array_spawn_targetname("evade_police_assault");
  thread evade_police_assault_extra();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_evade_police_dead();
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  var_5 = scripts\engine\sp\utility::get_living_ai_array("evade_police", "script_noteworthy");
  scripts\engine\utility::array_delete(var_5);
}

walla_cafe_reinforcements() {
  var_0 = spawn("script_origin", (-4549, 6, 100));
  var_0 playSound("stp_walla_restaurant_reinforcements_01", "sounddone");
  var_0 moveTo((-4575, 581, 100), 3.5);
  var_0 waittill("sounddone");
  var_0 delete();
}

evade_police_driveby_handler() {
  scripts\engine\sp\utility::set_ignoreme(1);
  self.no_pistol_switch = 1;
  self.sidearm = isundefinedweapon();
  self.sidearm = "none";
  scripts\engine\sp\utility::set_goal_radius(16);

  if(isDefined(self.script_noteworthy)) {
    var_0 = getnode("driver_exit_node", "targetname");
    self setgoalnode(var_0);
    self waittill("goal");

    if(isalive(self))
      self delete();
  } else {
    var_0 = getnode("passenger_window_node", "targetname");
    self setgoalnode(var_0);
    scripts\engine\utility::flag_wait("flag_evade_spawn_teargas");
    var_0 = getnode("passenger_delete_node", "targetname");
    self setgoalnode(var_0);
    self waittill("goal");

    if(isalive(self))
      self delete();
  }
}

evade_police_runby() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_goal_radius(16);
  self.baseaccuracy = 0.5;
  scripts\common\utility::setflashbangimmunity(1);
  self.balwayscoverexposed = 1;
  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\sp\utility::set_ignoreme(1);
  self.health = 50;
  scripts\common\utility::demeanor_override("sprint");
  self waittill("goal");

  if(isalive(self))
    self delete();
}

evade_police_window_shooter() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::aq_override_ar_lasersight();
  scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\sp\utility::set_goal_radius(16);
  scripts\common\utility::setflashbangimmunity(1);
  self.balwayscoverexposed = 1;
  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\sp\utility::set_ignoreme(1);
  self.no_pistol_switch = 1;
  self.sidearm = isundefinedweapon();
  self.sidearm = "none";

  if(scripts\engine\utility::cointoss())
    scripts\common\utility::demeanor_override("sprint");

  if(isDefined(self.script_noteworthy)) {
    var_0 = getnode("runby_right_node", "targetname");
    self setgoalnode(var_0);
  } else {
    var_0 = getnode("runby_left_node", "targetname");
    self setgoalnode(var_0);
    thread evade_window_shoot_at();
  }

  self waittill("goal");
  scripts\engine\sp\utility::set_ignoreall(0);
  scripts\engine\sp\utility::set_ignoreme(0);
  self allowedstances("crouch");
}

evade_window_shoot_at() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("window_shooter_start_point", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = scripts\engine\utility::spawn_script_origin(var_0.origin, var_0.angles);
  scripts\engine\sp\utility::set_ignoreme(1);
  self waittill("goal");
  var_2 moveTo(var_1.origin, 3.0, 0.05, 0.05);
  self setentitytarget(var_2);
  wait 4;
  self clearentitytarget();
  self getenemyinfo(level.player);
  wait 4;
  scripts\engine\sp\utility::set_ignoreme(0);
}

evade_police_runby_exit() {
  level endon("flag_evade_exit_cafe");
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("flag_player_flashbanged");

  if(isDefined(self.script_noteworthy)) {
    scripts\engine\sp\utility::set_ignoreall(1);
    scripts\engine\sp\utility::set_ignoreme(1);
    scripts\engine\sp\utility::set_goal_radius(16);
    self.health = 1;
    waitframe();
    scripts\common\utility::demeanor_override("sprint");
    var_0 = getnode("runby_right_delete_node", "targetname");
    self setgoalnode(var_0);
    self waittill("goal");
    self delete();
  } else {
    scripts\engine\sp\utility::set_ignoreall(1);
    scripts\engine\sp\utility::set_ignoreme(1);
    scripts\engine\sp\utility::set_goal_radius(16);
    self.health = 1;
    waitframe();
    scripts\common\utility::demeanor_override("sprint");
    var_0 = getnode("runby_left_delete_node", "targetname");
    self setgoalnode(var_0);
    self waittill("goal");
    self delete();
  }
}

evade_police_runby_retreat() {
  level endon("flag_evade_exit_cafe");
  var_0 = scripts\engine\sp\utility::get_living_ai_array("evade_police_window_shooter", "targetname");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::waittill_alive_count(var_0, 1);
  scripts\engine\utility::flag_set("flag_police_runby_retreating");
  var_0 = scripts\engine\sp\utility::get_living_ai_array("evade_police_window_shooter", "targetname");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 scripts\common\utility::demeanor_override("sprint");
      var_2 scripts\engine\sp\utility::set_ignoreall(1);
      var_2 scripts\engine\sp\utility::set_ignoreme(1);
      var_2 scripts\engine\sp\utility::set_goal_pos(var_2.origin);
      waitframe();
      var_3 = getnode("runby_retreat_node", "targetname");
      var_2 setgoalnode(var_3);
      var_2 allowedstances("stand");
    }

    scripts\engine\utility::flag_wait("flag_player_flashbanged");

    foreach(var_2 in var_0) {
      if(isalive(var_2))
        var_2 delete();
    }
  }
}

runby_manager(var_0) {
  var_1 = 1;
  var_2 = getEnt("evade_police_cafe_windows", "targetname");

  foreach(var_4 in var_0) {
    var_4 thread go_to_targetname("runby_struct_" + var_1, var_2);
    var_1++;
  }
}

go_to_targetname(var_0, var_1) {
  var_2 = getnode(var_0, "targetname");

  if(!isDefined(var_2))
    var_2 = scripts\engine\utility::getStruct(var_0, "targetname");

  thread scripts\sp\spawner::go_to_node(var_2);
  self waittill("reached_path_end");
  scripts\engine\sp\utility::set_ignoreall(0);
  self allowedstances("crouch");
  self delete();
}

evade_police_enter_anim() {
  scripts\engine\utility::flag_wait("flag_player_flashbanged");
  var_0 = getEnt("evade_police_assault_goal", "targetname");
  scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\sp\utility::set_allowdeath(1);
  var_1 = scripts\engine\utility::getStruct("cafe_police_enter_anim_org", "targetname");
  thread evade_animate_door("cafe_police_enter_door01_anim_org", "evade_cafe_door01", "evade_cafe_door01", 0);
  thread evade_animate_door("cafe_police_enter_door02_anim_org", "evade_cafe_door02", "evade_cafe_door02", 0);
  var_1 scripts\common\anim::anim_single_solo(self, "evade_cafe_police_enter");
  self stopanimScripted();
  scripts\engine\utility::flag_set("flag_police_leader_enter_cafe");
  scripts\engine\sp\utility::set_goal_radius(80);
  self setgoalvolumeauto(var_0);
  scripts\engine\sp\utility::set_ignoreme(1);
  self.allowstrafe = 1;
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_ignoresuppression(1);
  wait(randomfloatrange(7.0, 9.0));

  if(isalive(self))
    scripts\engine\sp\utility::set_ignoreme(0);
}

evade_police_assault() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = getEnt("evade_police_assault_goal", "targetname");
  self setgoalpos(self.origin);
  scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\sp\utility::set_ignoreme(1);
  self.allowstrafe = 1;
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_ignoresuppression(1);
  scripts\engine\utility::flag_wait("flag_police_leader_enter_cafe");
  scripts\engine\sp\utility::set_goal_radius(80);
  self setgoalvolumeauto(var_0);
  wait(randomfloatrange(7.0, 9.0));

  if(isalive(self))
    scripts\engine\sp\utility::set_ignoreme(0);

  scripts\engine\utility::flag_wait("flag_evade_exit_cafe");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_set_accuracy_max();
  scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");

  if(isalive(self))
    self delete();
}

evade_police_assault_extra() {
  level.player endon("death");
  level endon("missionfailed");
  var_0 = getEnt("evade_police_assault_goal", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("evade_police_assault_extra");
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 scripts\engine\sp\utility::set_goal_pos(var_1.origin);
  var_1 scripts\engine\sp\utility::set_goal_radius(16);
  var_1 allowedstances("crouch");
  var_1 scripts\engine\sp\utility::set_ignoreme(1);
  var_1 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 scripts\engine\sp\utility::enable_dontevershoot();
  scripts\engine\utility::flag_wait("flag_evade_enforcer_left_cafe");
  var_1 getenemyinfo(level.player);
  var_1 allowedstances("crouch", "stand");
  var_1 scripts\engine\sp\utility::set_ignoreme(0);
  var_1 scripts\engine\sp\utility::set_ignoreall(0);
  var_1 scripts\engine\sp\utility::disable_dontevershoot();
  var_1 scripts\engine\sp\utility::set_battlechatter(1);
  var_1 scripts\engine\sp\utility::set_attackeraccuracy(0.25);
  var_1.allowstrafe = 1;
  var_1.dontshootwhilemoving = 0;
  var_1 scripts\engine\sp\utility::set_ignoresuppression(1);
  var_1 scripts\engine\sp\utility::set_goal_radius(80);
  var_1 setgoalvolumeauto(var_0);
  wait(randomfloatrange(7.0, 9.0));

  if(isalive(var_1))
    var_1 scripts\engine\sp\utility::set_attackeraccuracy(1.0);
}

#using_animtree("script_model");

evade_animate_door(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  var_5 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_6 = getEnt(var_1, "targetname");
  var_7 = getEnt(var_1 + "_clip", "targetname");

  if(var_7 islinked() == 0)
    var_7 linkTo(var_6);

  var_6.animname = "door";
  var_6 useanimtree(#animtree);

  if(var_4 == 1)
    var_5 scripts\common\anim::anim_first_frame_solo(var_6, var_2);
  else if(var_1 == "cafe_evade_exit_door04") {
    var_6 rotateYaw(-90, 0.35, 0, 0);
    wait 0.35;
    var_6 rotateYaw(170, 2, 0, 2);
    wait 1;
  } else
    var_5 thread scripts\common\anim::anim_single_solo(var_6, var_2);

  if(var_3 == 0)
    var_7 connectpaths();
  else
    var_7 disconnectPaths();
}

evade_spawn_flashbangs() {
  scripts\engine\utility::flag_wait("flag_evade_spawn_teargas");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_evade_police_deploy_flashbangs();
  thread evade_cafe_molotov_handler();
  wait 0.5;
  scripts\engine\utility::flag_set("flag_player_flashbanged");
  thread evade_player_gesture();
  thread evade_sprinklers_triggered();
  level thread scripts\sp\utility::context_melee_enable(0);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_monitor_health_handler(100);
  scripts\sp\player::player_movement_state("default");
}

evade_player_gesture() {
  var_0 = getEnt("evade_player_near_molotov_vol", "targetname");
  var_1 = 0;

  while(var_1 < 100) {
    if(level.player istouching(var_0)) {
      break;
    }

    var_1++;
    waitframe();
  }

  wait 0.3;

  if(!level.player isreloading())
    level.player scripts\engine\sp\utility::player_gesture_force("ges_window_break_far");
}

evade_sprinklers_triggered() {
  wait 2.5;
  var_0 = scripts\engine\utility::getStruct("evade_sprinkler_impulse_1", "targetname");
  radiusdamage(var_0.origin, 35, 100, 95, undefined, undefined, undefined, 0, 0);
  var_1 = scripts\engine\utility::getStruct("evade_sprinkler_impulse_2", "targetname");
  radiusdamage(var_1.origin, 35, 100, 95, undefined, undefined, undefined, 0, 0);
  var_2 = scripts\engine\utility::getStruct("evade_sprinkler_impulse_3", "targetname");
  radiusdamage(var_2.origin, 35, 100, 95, undefined, undefined, undefined, 0, 0);
  var_3 = scripts\engine\utility::getStruct("evade_sprinkler_impulse_4", "targetname");
  radiusdamage(var_3.origin, 35, 100, 95, undefined, undefined, undefined, 0, 0);
}

evade_enforcer_escape_goal() {
  level.enforcer endon("death");
  level endon("flag_gauntlet_enforcer_hit_vig");
  scripts\engine\utility::flag_wait("flag_send_enforcer_out_of_cafe");
  scripts\engine\utility::flag_set("flag_evade_enforcer_flee");
  scripts\engine\utility::flag_set("flag_enforcer_exited_cafe");
  level.enforcer scripts\common\utility::clear_demeanor_override();
  var_0 = scripts\engine\utility::getStruct("cafe_butcher_escape_anim_org", "targetname");
  var_0 scripts\sp\anim::anim_reach_solo(level.enforcer, "evade_cafe_enforcer_exits");
  thread evade_enforcer_exit_door_bash();
  var_0 scripts\common\anim::anim_single_solo_run(level.enforcer, "evade_cafe_enforcer_exits");
  scripts\engine\utility::flag_set("flag_cafe_exit_open");
  var_1 = getnode("evade_enforcer_flee_node", "targetname");
  level.enforcer stopanimScripted();
  level.enforcer scripts\engine\sp\utility::set_goal_node(var_1);
  level.enforcer scripts\engine\sp\utility::set_goal_radius(32);
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  level.enforcer waittill("goal");
  scripts\engine\utility::flag_set("flag_evade_enforcer_clear");
  var_2 = getEnt("car_hit_enforcer_org", "targetname");
  var_2 scripts\common\anim::anim_first_frame_solo(level.enforcer, "stp_street_car_hit");
}

evade_enforcer_exit_door_bash() {
  wait 1.1;
  thread evade_animate_door("cafe_evade_exit_door03_anim_org", "cafe_evade_exit_door03", "evade_cafe_door03", 0);
  thread evade_animate_door("cafe_evade_exit_door04_anim_org", "cafe_evade_exit_door04", "evade_cafe_door04", 0);
}

evade_cafe_molotov_handler() {
  if(level.player issprinting()) {
    var_0 = scripts\engine\utility::getStruct("glass_smash_fx_1", "targetname");
    thread scripts\engine\utility::play_sound_in_space("stp_window_glass_break", var_0.origin);
    var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
    var_1 scripts\engine\sp\utility::fx_playontag_safe("vfx_pic_expl_window_glass", "tag_origin");
    wait 0.1;
    var_2 = scripts\engine\utility::getStruct("glass_smash_fx_2", "targetname");
    thread scripts\engine\utility::play_sound_in_space("stp_window_glass_break", var_2.origin);
    var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
    var_3 scripts\engine\sp\utility::fx_playontag_safe("vfx_pic_expl_window_glass", "tag_origin");
    evade_molotov_throw("magic_molotov_start_3", "magic_molotov_end_3");
    wait 0.1;
    evade_molotov_throw("magic_molotov_start_1", "magic_molotov_end_1");
    wait 0.1;
    evade_molotov_throw("magic_molotov_start_2", "magic_molotov_end_2");
    thread evade_price_molotov_react_anim();
  } else {
    wait 0.5;
    var_0 = scripts\engine\utility::getStruct("glass_smash_fx_1", "targetname");
    thread scripts\engine\utility::play_sound_in_space("stp_window_glass_break", var_0.origin);
    var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
    var_1 scripts\engine\sp\utility::fx_playontag_safe("vfx_pic_expl_window_glass", "tag_origin");
    wait 0.1;
    var_2 = scripts\engine\utility::getStruct("glass_smash_fx_2", "targetname");
    thread scripts\engine\utility::play_sound_in_space("stp_window_glass_break", var_2.origin);
    var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
    var_3 scripts\engine\sp\utility::fx_playontag_safe("vfx_pic_expl_window_glass", "tag_origin");
    evade_molotov_throw("magic_molotov_start_3", "magic_molotov_end_3");
    wait 0.1;
    evade_molotov_throw("magic_molotov_start_1", "magic_molotov_end_1");
    wait 0.1;
    evade_molotov_throw("magic_molotov_start_2", "magic_molotov_end_2");
    thread evade_price_molotov_react_anim();
  }
}

evade_molotov_throw(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_4 = magicgrenade("molotov", var_2.origin, var_3.origin);
  thread magic_molotov_fake_think(var_4);
}

magic_molotov_fake_think(var_0) {
  var_0 endon("entitydeleted");
  var_1 = getmissileowner(var_0);
  var_0 waittill("missile_stuck", var_2, var_3, var_4, var_5, var_6, var_7);
  var_0 thread fake_molotov_explode(var_6, var_7, var_5, var_2, var_1);
  scripts\engine\utility::exploder("mtov_fx");
  playrumbleonposition("grenade_rumble", var_6);
  earthquake(0.3, 1.0, var_6, 400);
  var_0 delete();
}

fake_molotov_explode(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && isai(var_3)) {
    var_5 = scripts\engine\utility::array_add(getaiarray(), level.player);
    var_0 = var_3.origin;
    var_6 = anglestoup(var_3.angles);
    var_7 = var_3 getEye();
    var_8 = var_7 + var_6 * -1000;
    var_9 = scripts\engine\trace::ray_trace(var_7, var_8, var_5)["normal"];

    if(isDefined(var_9))
      var_1 = var_9;
    else
      var_1 = var_6;
  }

  var_10 = scripts\engine\math::vector_project_onto_plane(var_2, var_1);
  var_11 = spawnfx(level._effect["vfx_stpburg_molotov_explosion"], var_0, var_1, var_10);
  triggerfx(var_11);
  playworldsound("weap_molotov_bottle", var_0);
  thread molotov_fire_sfx(var_0, 10);
  var_12 = spawn("trigger_radius_fire", var_0, 0, 45, 30);
  var_12.script_multiplier = 2;
  var_12.script_radius = 45;
  thread scripts\sp\trigger::trigger_fire(var_12);
  var_13 = createnavbadplacebybounds(var_0, (55, 55, 100), (0, 0, 0));
  level notify("molotov_fire_trigger", var_12);
  level.cancel_fake_molotov = 0;
  var_14 = 10;
  var_15 = gettime();

  while(var_14 > 0) {
    if(istrue(level.cancel_fake_molotov)) {
      var_16 = var_11.origin;
      var_11 delete();
      level.cancel_fake_molotov = 0;
      break;
    }

    var_14 = var_14 - 0.05;
    wait 0.05;
  }

  var_11 delete();

  if(isDefined(self))
    self delete();
}

molotov_fire_ab_light_on() {
  thread molotov_fire_ab_light_flicker();
}

molotov_fire_ab_light_off() {
  level.molotov_fake_light notify("kill_molotov");
  level.molotov_fake_light setlightintensity(0);
}

molotov_fire_ab_light_flicker() {
  level.molotov_fake_light endon("kill_molotov");
  var_0 = 80;

  for(;;) {
    var_1 = 0.75 * var_0;
    var_2 = 1 * var_0;
    var_0 = randomfloatrange(var_1, var_2);
    level.molotov_fake_light setlightintensity(var_0);
    wait(randomfloatrange(0.2, 0.4));
  }
}

molotov_fire_sfx(var_0, var_1) {
  wait 0.1;
  var_2 = spawn("script_origin", var_0 + (0, 0, 15));
  var_2 playLoopSound("weap_molotov_fire_lp");
  wait(var_1);
  thread scripts\engine\utility::play_sound_in_space("weap_molotov_fire_end", var_2.origin);
  var_2 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

evade_player_extra_fire_damage() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_evade_exit_cafe");

  while(!scripts\engine\utility::flag("flag_evade_exit_cafe")) {
    level.player waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_4) && var_4 == "MOD_FIRE") {
      var_10 = scripts\common\utility::getdifficulty();

      if(var_10 == "medium")
        level.player scripts\sp\utility::do_damage(var_0 * 5, var_3, var_1);
      else if(var_10 == "hard")
        level.player scripts\sp\utility::do_damage(var_0 * 7, var_3, var_1);
      else if(var_10 == "fu")
        level.player scripts\sp\utility::do_damage(var_0 * 9, var_3, var_1);
    }

    wait 0.1;
  }
}

evade_autosave_in_cafe() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_evade_down_stairs");
  thread scripts\engine\sp\utility::autosave_now();
}

evade_player_kill() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_evade_enforcer_clear");

  while(!isDefined(level.enforcer))
    waitframe();

  level.enforcer endon("death");
  scripts\engine\sp\utility::trigger_wait_targetname("evade_player_kill_trig");

  if(!scripts\engine\utility::flag("flag_evade_police_dead") && !scripts\engine\utility::flag("flag_evade_enforcer_clear")) {
    var_0 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
    magicbullet("iw8_ar_akilo47", var_0, level.player getEye(), level.enforcer);
    level.player kill();
  }
}