/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_gameplay_escort.gsc
*************************************************************************/

function escort_phase_init() {
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

function evade_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("flag_evade_spawn_teargas", "stpetersburg_canal_script_tr", "stpetersburg_gauntlet_script_tr");
  waitframe();
  thread scripts\sp\analytics::analytics_kleenex_update("Cafe to van");
  scripts\engine\utility::flag_set("flag_start_escort_containment");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_evade_price_into_cafe();
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

function evade_enforcer_handler() {
  if(!isDefined(level.enforcer)) {
    scripts\sp\maps\stpetersburg\stpetersburg_utility::spawn_enforcer("enforcer_cafe_further_spawn_node");
    level.enforcer scripts\engine\sp\utility::set_goal_pos(level.enforcer.origin);
    level.enforcer scripts\engine\sp\utility::disable_ai_color();
  } else {
    var0 = getnode("node_enforcer_cafe_room_two", "targetname");
    level.enforcer scripts\engine\sp\utility::teleport_ai(var0);
    level.enforcer scripts\engine\sp\utility::set_goal_pos(level.enforcer.origin);
    level.enforcer scripts\engine\sp\utility::disable_ai_color();
  }

  waitframe();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_safe_run();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_evade_butcher_taunt();
  thread evade_enforcer_escape_goal();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_send_enforcer_out_of_cafe", 25);
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_evade_cafe_pursuit_end", 35);
}

function evade_player_stray_fail() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_enemies_spawn");
  var0 = getEnt("evade_player_stray_trig", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("evade_player_stray_trig");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_pursuit_target_escaping_nag();
  wait 5;

  for(;;) {
    if(level.player istouching(var0)) {
      scripts\engine\utility::flag_set("disable_autosaves");
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_pursuit_target_escaped_fail();
      wait 2;
      scripts\sp\player_death::set_custom_death_quote(76);
      thread scripts\sp\utility::missionfailedwrapper();
    }

    wait 0.2;
  }
}

function evade_price_handler() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::activate_trigger_with_targetname("node_evade_price_cafe_dining_1");
  scripts\engine\utility::flag_wait_either("flag_evade_price_to_flashbang_room", "flag_police_runby_retreating");
  scripts\engine\sp\utility::activate_trigger_with_targetname("price_cafe_fight_police_color");
  GscBinSkip4(0x35, "price_cafe_sides_color", "targetname");
}

function evade_price_molotov_react_anim() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_evade_exit_cafe");
  level endon("flag_police_leader_enter_cafe");
  var0 = getnode("cafe_price_molotov_room_node", "targetname");
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility::color_node_arrive(var0);
  wait 0.5;

  if(!isDefined(level.moloachievementvictims)) {
    level.moloachievementvictims = 0;
  }

  thread scripts\sp\equipment\molotov::molotovburnenemy(level.price, 0, level.price.origin + (0, 0, 8));
  playFXOnTag(level.g_effect["vfx_burn_sml_low"], level.price, "j_elbow_le");
  var1 = scripts\engine\utility::getStruct("struct_price_molotov_react", "targetname");
  var1 scripts\common\anim::anim_single_solo(level.price, "evade_price_react_1");
}

function trigger_array_wait_then_delete_cafe(var0, var1) {
  var2 = getEntArray(var0, var1);
  scripts\engine\utility::waittill_any_ents_array(var2, "trigger");
  waitframe();
  scripts\engine\utility::array_delete(var2);
  scripts\engine\utility::flag_set("flag_cafe_price_trigs_deleted");
}

function trigger_array_delete_cafe(var0, var1) {
  level endon("flag_cafe_price_trigs_deleted");
  var2 = getEntArray(var0, var1);
  scripts\engine\utility::array_delete(var2);
}

function evade_price_shoot_at_ent() {
  level endon("flag_evade_exit_cafe");
  level endon("flag_evade_police_dead");
  var0 = getEnt("cafe_price_suppress", "targetname");
  level.price setentitytarget(var0);
  level.price.no_pistol_switch = 1;
  level.price.disablepistol = 1;
  level.price.sidearm = isundefinedweapon();
  level.price.sidearm = "none";
  scripts\engine\utility::flag_wait_either("flag_evade_spawn_teargas", "flag_police_driveby_guys_dead");
  level.price clearentitytarget();
}

function evade_police_handler() {
  scripts\engine\utility::flag_wait("flag_evade_police_window_vig");
  thread walla_cafe_reinforcements();
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_driveby", &evade_police_driveby_handler);
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("evade_police_driveby_vehicle");
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_runby", &evade_police_runby);
  var1 = scripts\engine\sp\utility::array_spawn_targetname("evade_police_runby");
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_window_shooter", &evade_police_window_shooter);
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_window_shooter", &evade_police_runby_exit);
  var2 = scripts\engine\sp\utility::array_spawn_targetname("evade_police_window_shooter");
  thread runby_manager(var1);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_evade_aq_runby();
  scripts\engine\utility::flag_wait("flag_enforcer_exited_cafe");
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_assault_leader", &evade_police_enter_anim);
  var3 = scripts\engine\sp\utility::array_spawn_targetname("evade_police_assault_leader");
  scripts\engine\sp\utility::array_spawn_function_targetname("evade_police_assault", &evade_police_assault);
  var4 = scripts\engine\sp\utility::array_spawn_targetname("evade_police_assault");
  thread evade_police_assault_extra();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_evade_police_dead();
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  var5 = scripts\engine\sp\utility::get_living_ai_array("evade_police", "script_noteworthy");
  scripts\engine\utility::array_delete(var5);
}

function walla_cafe_reinforcements() {
  var0 = spawn("script_origin", (-4549, 6, 100));
  var0 playSound("stp_walla_restaurant_reinforcements_01", "sounddone");
  var0 moveTo((-4575, 581, 100), 3.5);
  var0 waittill("sounddone");
  var0 delete();
}

function evade_police_driveby_handler() {
  scripts\engine\sp\utility::set_ignoreme(1);
  self.no_pistol_switch = 1;
  self.sidearm = isundefinedweapon();
  self.sidearm = "none";
  scripts\engine\sp\utility::set_goal_radius(16);

  if(isDefined(self.script_noteworthy)) {
    var0 = getnode("driver_exit_node", "targetname");
    self setgoalnode(var0);
    self waittill("goal");

    if(isalive(self)) {
      self delete();
      return;
    }

    return;
  }

  var0 = getnode("passenger_window_node", "targetname");
  self setgoalnode(var0);
  scripts\engine\utility::flag_wait("flag_evade_spawn_teargas");
  var0 = getnode("passenger_delete_node", "targetname");
  self setgoalnode(var0);
  self waittill("goal");

  if(isalive(self)) {
    self delete();
    return;
  }
}

function evade_police_runby() {
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

  if(isalive(self)) {
    self delete();
    return;
  }
}

function evade_police_window_shooter() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::aq_override_ar_lasersight();
  scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\sp\utility::set_goal_radius(16);
  scripts\common\utility::setflashbangimmunity(1);
  self.balwayscoverexposed = 1;
  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\sp\utility::set_ignoreme(1);
  self.no_pistol_switch = 1;
  self.sidearm = isundefinedweapon();
  self.sidearm = "none";

  if(scripts\engine\utility::cointoss()) {
    scripts\common\utility::demeanor_override("sprint");
  }

  if(isDefined(self.script_noteworthy)) {
    var0 = getnode("runby_right_node", "targetname");
    self setgoalnode(var0);
  } else {
    var0 = getnode("runby_left_node", "targetname");
    self setgoalnode(var0);
    thread evade_window_shoot_at();
  }

  self waittill("goal");
  scripts\engine\sp\utility::set_ignoreall(0);
  scripts\engine\sp\utility::set_ignoreme(0);
  self allowedstances("crouch");
}

function evade_window_shoot_at() {
  self endon("death");
  var0 = scripts\engine\utility::getStruct("window_shooter_start_point", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = scripts\engine\utility::spawn_script_origin(var0.origin, var0.angles);
  scripts\engine\sp\utility::set_ignoreme(1);
  self waittill("goal");
  var2 moveTo(var1.origin, 3, 0.05, 0.05);
  self setentitytarget(var2);
  wait 4;
  self clearentitytarget();
  self getenemyinfo(level.player);
  wait 4;
  scripts\engine\sp\utility::set_ignoreme(0);
}

function evade_police_runby_exit() {
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
    var0 = getnode("runby_right_delete_node", "targetname");
    self setgoalnode(var0);
    self waittill("goal");
    self delete();
    return;
  }

  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\sp\utility::set_ignoreme(1);
  scripts\engine\sp\utility::set_goal_radius(16);
  self.health = 1;
  waitframe();
  scripts\common\utility::demeanor_override("sprint");
  var0 = getnode("runby_left_delete_node", "targetname");
  self setgoalnode(var0);
  self waittill("goal");
  self delete();
}

function evade_police_runby_retreat() {
  level endon("flag_evade_exit_cafe");
  var0 = scripts\engine\sp\utility::get_living_ai_array("evade_police_window_shooter", "targetname");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::waittill_alive_count(var0, 1);
  scripts\engine\utility::flag_set("flag_police_runby_retreating");
  var0 = scripts\engine\sp\utility::get_living_ai_array("evade_police_window_shooter", "targetname");

  foreach(var2 in var0) {
    if(isalive(var2)) {
      var2 scripts\common\utility::demeanor_override("sprint");
      var2 scripts\engine\sp\utility::set_ignoreall(1);
      var2 scripts\engine\sp\utility::set_ignoreme(1);
      var2 scripts\engine\sp\utility::set_goal_pos(var2.origin);
      waitframe();
      var3 = getnode("runby_retreat_node", "targetname");
      var2 setgoalnode(var3);
      var2 allowedstances("stand");
    }

    scripts\engine\utility::flag_wait("flag_player_flashbanged");

    foreach(var2 in var0) {
      if(isalive(var2)) {
        var2 delete();
      }
    }
  }
}

function runby_manager(var0) {
  var1 = 1;
  var2 = getEnt("evade_police_cafe_windows", "targetname");

  foreach(var4 in var0) {
    thread go_to_targetname(var4, "runby_struct_" + var1);
    var1++;
  }
}

function go_to_targetname(var0, var1) {
  var2 = getnode(var0, "targetname");

  if(!isDefined(var2)) {
    var2 = scripts\engine\utility::getStruct(var0, "targetname");
  }

  thread scripts\sp\spawner::go_to_node(var2);
  self waittill("reached_path_end");
  scripts\engine\sp\utility::set_ignoreall(0);
  self allowedstances("crouch");
  self delete();
}

function evade_police_enter_anim() {
  scripts\engine\utility::flag_wait("flag_player_flashbanged");
  var0 = getEnt("evade_police_assault_goal", "targetname");
  scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\sp\utility::set_allowdeath(1);
  var1 = scripts\engine\utility::getStruct("cafe_police_enter_anim_org", "targetname");
  thread evade_animate_door("cafe_police_enter_door01_anim_org", "evade_cafe_door01", "evade_cafe_door01", 0);
  thread evade_animate_door("cafe_police_enter_door02_anim_org", "evade_cafe_door02", "evade_cafe_door02", 0);
  var1 scripts\common\anim::anim_single_solo(self, "evade_cafe_police_enter");
  self stopanimScripted();
  scripts\engine\utility::flag_set("flag_police_leader_enter_cafe");
  scripts\engine\sp\utility::set_goal_radius(80);
  self setgoalvolumeauto(var0);
  scripts\engine\sp\utility::set_ignoreme(1);
  self.allowstrafe = 1;
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_ignoresuppression(1);
  wait randomfloatrange(7, 9);

  if(isalive(self)) {
    scripts\engine\sp\utility::set_ignoreme(0);
    return;
  }
}

function evade_police_assault() {
  self endon("death");
  self endon("entitydeleted");
  var0 = getEnt("evade_police_assault_goal", "targetname");
  self setgoalpos(self.origin);
  scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\sp\utility::set_ignoreme(1);
  self.allowstrafe = 1;
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_ignoresuppression(1);
  scripts\engine\utility::flag_wait("flag_police_leader_enter_cafe");
  scripts\engine\sp\utility::set_goal_radius(80);
  self setgoalvolumeauto(var0);
  wait randomfloatrange(7, 9);

  if(isalive(self)) {
    scripts\engine\sp\utility::set_ignoreme(0);
  }

  scripts\engine\utility::flag_wait("flag_evade_exit_cafe");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_set_accuracy_max();
  scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");

  if(isalive(self)) {
    self delete();
    return;
  }
}

function evade_police_assault_extra() {
  level.player endon("death");
  level endon("missionfailed");
  var0 = getEnt("evade_police_assault_goal", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("evade_police_assault_extra");
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 scripts\engine\sp\utility::set_goal_pos(var1.origin);
  var1 scripts\engine\sp\utility::set_goal_radius(16);
  var1 allowedstances("crouch");
  var1 scripts\engine\sp\utility::set_ignoreme(1);
  var1 scripts\engine\sp\utility::set_ignoreall(1);
  var1 scripts\engine\sp\utility::enable_dontevershoot();
  scripts\engine\utility::flag_wait("flag_evade_enforcer_left_cafe");
  var1 getenemyinfo(level.player);
  var1 allowedstances("crouch", "stand");
  var1 scripts\engine\sp\utility::set_ignoreme(0);
  var1 scripts\engine\sp\utility::set_ignoreall(0);
  var1 scripts\engine\sp\utility::disable_dontevershoot();
  var1 scripts\engine\sp\utility::set_battlechatter(1);
  var1 scripts\engine\sp\utility::set_attackeraccuracy(0.25);
  var1.allowstrafe = 1;
  var1.dontshootwhilemoving = 0;
  var1 scripts\engine\sp\utility::set_ignoresuppression(1);
  var1 scripts\engine\sp\utility::set_goal_radius(80);
  var1 setgoalvolumeauto(var0);
  wait randomfloatrange(7, 9);

  if(isalive(var1)) {
    var1 scripts\engine\sp\utility::set_attackeraccuracy(1);
    return;
  }
}

#using_animtree("script_model");

function evade_animate_door(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  var5 = scripts\engine\utility::getStruct(var0, "targetname");
  var6 = getEnt(var1, "targetname");
  var7 = getEnt(var1 + "_clip", "targetname");

  if(var7 islinked() == 0) {
    var7 linkTo(var6);
  }

  var6.animname = "door";
  var6 useanimtree(#animtree);

  if(var4 == 1) {
    var5 scripts\common\anim::anim_first_frame_solo(var6, var2);
  } else if(var1 == "cafe_evade_exit_door04") {
    var6 rotateYaw(-90, 0.35, 0, 0);
    wait 0.35;
    var6 rotateYaw(170, 2, 0, 2);
    wait 1;
  } else {
    var5 thread scripts\common\anim::anim_single_solo(var6, var2);
  }

  if(var3 == 0) {
    var7 connectpaths();
    return;
  }

  var7 disconnectPaths();
}

function evade_spawn_flashbangs() {
  scripts\engine\utility::flag_wait("flag_evade_spawn_teargas");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_evade_police_deploy_flashbangs();
  thread evade_cafe_molotov_handler();
  wait 0.5;
  scripts\engine\utility::flag_set("flag_player_flashbanged");
  thread evade_player_gesture();
  thread evade_sprinklers_triggered();
  level thread scripts\sp\utility::context_melee_enable(0);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_monitor_health_handler(100);
  scripts\sp\player::player_movement_state("default");
}

function evade_player_gesture() {
  var0 = getEnt("evade_player_near_molotov_vol", "targetname");
  var1 = 0;

  while(var1 < 100) {
    if(level.player istouching(var0)) {
      break;
    }

    var1++;
    waitframe();
  }

  wait 0.3;

  if(!level.player isreloading()) {
    level.player scripts\engine\sp\utility::player_gesture_force("ges_window_break_far");
    return;
  }
}

function evade_sprinklers_triggered() {
  wait 2.5;
  var0 = scripts\engine\utility::getStruct("evade_sprinkler_impulse_1", "targetname");
  radiusdamage(var0.origin, 35, 100, 95, undefined, undefined, undefined, 0, 0);
  var1 = scripts\engine\utility::getStruct("evade_sprinkler_impulse_2", "targetname");
  radiusdamage(var1.origin, 35, 100, 95, undefined, undefined, undefined, 0, 0);
  var2 = scripts\engine\utility::getStruct("evade_sprinkler_impulse_3", "targetname");
  radiusdamage(var2.origin, 35, 100, 95, undefined, undefined, undefined, 0, 0);
  var3 = scripts\engine\utility::getStruct("evade_sprinkler_impulse_4", "targetname");
  radiusdamage(var3.origin, 35, 100, 95, undefined, undefined, undefined, 0, 0);
}

function evade_enforcer_escape_goal() {
  level.enforcer endon("death");
  level endon("flag_gauntlet_enforcer_hit_vig");
  scripts\engine\utility::flag_wait("flag_send_enforcer_out_of_cafe");
  scripts\engine\utility::flag_set("flag_evade_enforcer_flee");
  scripts\engine\utility::flag_set("flag_enforcer_exited_cafe");
  level.enforcer scripts\common\utility::clear_demeanor_override();
  var0 = scripts\engine\utility::getStruct("cafe_butcher_escape_anim_org", "targetname");
  var0 scripts\sp\anim::anim_reach_solo(level.enforcer, "evade_cafe_enforcer_exits");
  thread evade_enforcer_exit_door_bash();
  var0 scripts\common\anim::anim_single_solo_run(level.enforcer, "evade_cafe_enforcer_exits");
  scripts\engine\utility::flag_set("flag_cafe_exit_open");
  var1 = getnode("evade_enforcer_flee_node", "targetname");
  level.enforcer stopanimScripted();
  level.enforcer scripts\engine\sp\utility::set_goal_node(var1);
  level.enforcer scripts\engine\sp\utility::set_goal_radius(32);
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  level.enforcer waittill("goal");
  scripts\engine\utility::flag_set("flag_evade_enforcer_clear");
  var2 = getEnt("car_hit_enforcer_org", "targetname");
  var2 scripts\common\anim::anim_first_frame_solo(level.enforcer, "stp_street_car_hit");
}

function evade_enforcer_exit_door_bash() {
  wait 1.1;
  thread evade_animate_door("cafe_evade_exit_door03_anim_org", "cafe_evade_exit_door03", "evade_cafe_door03", 0);
  thread evade_animate_door("cafe_evade_exit_door04_anim_org", "cafe_evade_exit_door04", "evade_cafe_door04", 0);
}

function evade_cafe_molotov_handler() {
  if(level.player issprinting()) {
    var0 = scripts\engine\utility::getStruct("glass_smash_fx_1", "targetname");
    thread scripts\engine\utility::play_sound_in_space("stp_window_glass_break", var0.origin);
    var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
    var1 scripts\engine\sp\utility::fx_playontag_safe("vfx_pic_expl_window_glass", "tag_origin");
    wait 0.1;
    var2 = scripts\engine\utility::getStruct("glass_smash_fx_2", "targetname");
    thread scripts\engine\utility::play_sound_in_space("stp_window_glass_break", var2.origin);
    var3 = scripts\engine\utility::spawn_tag_origin(var2.origin, var2.angles);
    var3 scripts\engine\sp\utility::fx_playontag_safe("vfx_pic_expl_window_glass", "tag_origin");
    evade_molotov_throw("magic_molotov_start_3", "magic_molotov_end_3");
    wait 0.1;
    evade_molotov_throw("magic_molotov_start_1", "magic_molotov_end_1");
    wait 0.1;
    evade_molotov_throw("magic_molotov_start_2", "magic_molotov_end_2");
    thread evade_price_molotov_react_anim();
    return;
  }

  wait 0.5;
  var0 = scripts\engine\utility::getStruct("glass_smash_fx_1", "targetname");
  thread scripts\engine\utility::play_sound_in_space("stp_window_glass_break", var0.origin);
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var1 scripts\engine\sp\utility::fx_playontag_safe("vfx_pic_expl_window_glass", "tag_origin");
  wait 0.1;
  var2 = scripts\engine\utility::getStruct("glass_smash_fx_2", "targetname");
  thread scripts\engine\utility::play_sound_in_space("stp_window_glass_break", var2.origin);
  var3 = scripts\engine\utility::spawn_tag_origin(var2.origin, var2.angles);
  var3 scripts\engine\sp\utility::fx_playontag_safe("vfx_pic_expl_window_glass", "tag_origin");
  evade_molotov_throw("magic_molotov_start_3", "magic_molotov_end_3");
  wait 0.1;
  evade_molotov_throw("magic_molotov_start_1", "magic_molotov_end_1");
  wait 0.1;
  evade_molotov_throw("magic_molotov_start_2", "magic_molotov_end_2");
  thread evade_price_molotov_react_anim();
}

function evade_molotov_throw(var0, var1) {
  var2 = scripts\engine\utility::getStruct(var0, "targetname");
  var3 = scripts\engine\utility::getStruct(var1, "targetname");
  var4 = magicgrenade("molotov", var2.origin, var3.origin);
  thread magic_molotov_fake_think(var4);
}

function magic_molotov_fake_think(var0) {
  var0 endon("entitydeleted");
  var1 = getmissileowner(var0);
  var0 waittill("missile_stuck", var2, var3, var4, var5, var6, var7);
  thread fake_molotov_explode(var0, var6, var7, var5, var2);
  scripts\engine\utility::exploder("mtov_fx");
  playrumbleonposition("grenade_rumble", var6);
  earthquake(0.3, 1, var6, 400);
  var0 delete();
}

function fake_molotov_explode(var0, var1, var2, var3, var4) {
  if(isDefined(var3) && isai(var3)) {
    var5 = scripts\engine\utility::array_add(getaiarray(), level.player);
    var0 = var3.origin;
    var6 = anglestoup(var3.angles);
    var7 = var3 getEye();
    var8 = var7 + var6 * -1000;
    var9 = scripts\engine\trace::ray_trace(var7, var8, var5)["normal"];

    if(isDefined(var9)) {
      var1 = var9;
    } else {
      var1 = var6;
    }
  }

  var10 = scripts\engine\math::vector_project_onto_plane(var2, var1);
  var11 = spawnfx(level._effect["vfx_stpburg_molotov_explosion"], var0, var1, var10);
  triggerfx(var11);
  playworldsound("weap_molotov_bottle", var0);
  thread molotov_fire_sfx(var0, 10);
  var12 = spawn("trigger_radius_fire", var0, 0, 45, 30);
  var12.script_multiplier = 2;
  var12.script_radius = 45;
  thread scripts\sp\trigger::trigger_fire(var12);
  var13 = createnavbadplacebybounds(var0, (55, 55, 100), (0, 0, 0));
  level notify("molotov_fire_trigger", var12);
  level.cancel_fake_molotov = 0;
  var14 = 10;
  var15 = gettime();

  while(var14 > 0) {
    if(istrue(level.cancel_fake_molotov)) {
      var16 = var11.origin;
      var11 delete();
      level.cancel_fake_molotov = 0;
      break;
    }

    var14 -= 0.05;
    wait 0.05;
  }

  var11 delete();

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function molotov_fire_ab_light_on() {
  thread molotov_fire_ab_light_flicker();
}

function molotov_fire_ab_light_off() {
  level.molotov_fake_light notify("kill_molotov");
  level.molotov_fake_light setlightintensity(0);
}

function molotov_fire_ab_light_flicker() {
  level.molotov_fake_light endon("kill_molotov");
  var0 = 80;

  for(;;) {
    var1 = 0.75 * var0;
    var2 = 1 * var0;
    var0 = randomfloatrange(var1, var2);
    level.molotov_fake_light setlightintensity(var0);
    wait randomfloatrange(0.2, 0.4);
  }
}

function molotov_fire_sfx(var0, var1) {
  wait 0.1;
  var2 = spawn("script_origin", var0 + (0, 0, 15));
  var2 playLoopSound("weap_molotov_fire_lp");
  wait var1;
  thread scripts\engine\utility::play_sound_in_space("weap_molotov_fire_end", var2.origin);
  var2 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

function evade_player_extra_fire_damage() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_evade_exit_cafe");

  while(!scripts\engine\utility::flag("flag_evade_exit_cafe")) {
    level.player waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var4) && var4 == "MOD_FIRE") {
      var10 = scripts\common\utility::getdifficulty();

      if(var10 == "medium") {
        level.player scripts\sp\utility::do_damage(var0 * 5, var3, var1);
      } else if(var10 == "hard") {
        level.player scripts\sp\utility::do_damage(var0 * 7, var3, var1);
      } else if(var10 == "fu") {
        level.player scripts\sp\utility::do_damage(var0 * 9, var3, var1);
      }
    }

    wait 0.1;
  }
}

function evade_autosave_in_cafe() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_evade_down_stairs");
  thread scripts\engine\sp\utility::autosave_now();
}

function evade_player_kill() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_evade_enforcer_clear");

  while(!isDefined(level.enforcer)) {
    waitframe();
  }

  level.enforcer endon("death");
  scripts\engine\sp\utility::trigger_wait_targetname("evade_player_kill_trig");

  if(!scripts\engine\utility::flag("flag_evade_police_dead") && !scripts\engine\utility::flag("flag_evade_enforcer_clear")) {
    var0 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
    magicbullet("iw8_ar_akilo47", var0, level.player getEye(), level.enforcer);
    level.player kill();
    return;
  }
}