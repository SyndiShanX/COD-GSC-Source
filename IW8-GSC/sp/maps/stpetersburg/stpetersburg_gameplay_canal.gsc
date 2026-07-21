/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_gameplay_canal.gsc
****************************************************************/

canal_init() {
  scripts\engine\utility::flag_init("flag_canal_player_jump_down");
  scripts\engine\utility::flag_init("flag_canal_player_near_bridge");
  scripts\engine\utility::flag_init("flag_canal_player_on_bridge");
  scripts\engine\utility::flag_init("flag_canal_player_end_bridge");
  scripts\engine\utility::flag_init("flag_canal_player_enter_street");
  scripts\engine\utility::flag_init("flag_canal_player_mid_street");
  scripts\engine\utility::flag_init("flag_canal_player_end_street");
  scripts\engine\utility::flag_init("flag_canal_enforcer_on_bridge");
  scripts\engine\utility::flag_init("flag_canal_enforcer_mid_bridge");
  scripts\engine\utility::flag_init("flag_canal_enforcer_over_bridge");
  scripts\engine\utility::flag_init("flag_canal_enforcer_begin_blindfire");
  scripts\engine\utility::flag_init("flag_canal_enforcer_finished_blindfire");
  scripts\engine\utility::flag_init("flag_canal_enforcer_in_alley");
  scripts\engine\utility::flag_init("flag_canal_civs_start");
  scripts\engine\utility::flag_init("flag_canal_car_guy_spawn");
  scripts\engine\utility::flag_init("flag_canal_player_shoot_first");
  scripts\engine\utility::flag_init("flag_canal_wave1_dead");
  scripts\engine\utility::flag_init("flag_canal_wave2_dead");
  scripts\engine\utility::flag_init("flag_canal_rpg_dead");
  scripts\engine\utility::flag_init("flag_canal_enemies_dead");
  scripts\engine\utility::flag_init("flag_canal_truck_driver_damaged");
  scripts\engine\utility::flag_init("flag_canal_aq_car_2_path_end");
  scripts\engine\utility::flag_init("flag_canal_player_done_speaking");
  scripts\engine\utility::flag_init("flag_canal_end");
  scripts\engine\utility::flag_init("flag_canal_driveby_start");
  scripts\engine\utility::flag_init("flag_canal_driveby_far");
  scripts\engine\utility::flag_init("flag_canal_driveby_close");
  scripts\engine\utility::flag_init("flag_canal_driveby_end");
}

canal_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::transient_waittill("flag_canal_player_jump_down", "stpetersburg_intro_geo_tr", undefined);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::transient_waittill("flag_canal_player_end_bridge", "stpetersburg_apartment_script_tr", "stpetersburg_cafe_script_tr");
  thread scripts\sp\analytics::analytics_kleenex_update("Canal to cafe");
  thread canal_enforcer_handler();
  thread canal_pursuit_timer_handler();
  thread canal_price_handler();
  thread canal_car_alarms_off();
  thread canal_driveby_vignette();
  thread canal_enemy_handler();
  thread canal_civ_handler();
  thread canal_dead_bodies();
  thread canal_car_handler();
  thread canal_kill_rushing_player();
  scripts\engine\utility::flag_wait("flag_canal_player_jump_down");
  scripts\engine\utility::flag_set("flag_start_canal_containment");
  scripts\engine\utility::flag_wait("flag_canal_end");
}

canal_enemy_handler() {
  thread canal_enemy_death_monitor();
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave1", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_enemy_for_price_clean_up);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave1", ::canal_enemy_setup);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave1", ::canal_enemy_fallback, "flag_canal_player_mid_street", "canal_vol3");
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_aq_car_1_start", ::canal_enemy_in_vehicle);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_aq_car_1_start", ::canal_check_player_shoot_first);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_aq_car_1_start", ::canal_enemy_setup);
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("canal_aq_car_1");
  scripts\engine\utility::flag_wait_any("flag_canal_player_end_bridge", "flag_canal_player_shoot_first");

  if(isalive(var_0))
    var_0 scripts\common\vehicle::vehicle_unload();

  scripts\engine\utility::flag_wait("flag_canal_player_end_bridge");
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("canal_wave1");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_canal_aq_inbound();
  scripts\engine\utility::flag_wait("flag_canal_enforcer_finished_blindfire");
  thread canal_enemy_rpg_truck();
  scripts\engine\utility::flag_wait_any("flag_canal_player_mid_street", "flag_canal_wave1_dead", "flag_canal_rpg_dead");
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave2", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_enemy_for_price_clean_up);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave2", ::canal_enemy_setup);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave2", ::canal_enemy_fallback, "flag_canal_end", "acquire_vol1");
  var_2 = scripts\engine\sp\utility::array_spawn_targetname("canal_wave2");
}

canal_check_player_shoot_first() {
  level endon("flag_canal_player_shoot_first");
  level endon("flag_canal_player_end_bridge");
  scripts\engine\utility::waittill_any("damage", "death", "bulletwhizby");
  scripts\engine\utility::flag_set("flag_canal_player_shoot_first");
}

canal_enemy_rpg_truck() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("canal_aq_car_2");
  waitframe();
  var_0.godmode = 1;
  var_0.riders[0] thread truck_driver_damage_handler();
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_rpg", ::canal_rpg_handler);
  var_1 = scripts\engine\sp\utility::spawn_targetname("canal_rpg");
  var_2 = var_0 gettagorigin("tag_bed2");
  var_3 = var_1.angles;
  var_1 forceteleport(var_2, var_3);
  var_1 linktomoveoffset(var_0, "tag_bed2");
  var_4 = getvehiclenode("canal_aq_car_2_start", "targetname");
  waitframe();
  var_0 vehicle_setspeed(10, 10, 5);
  var_0 scripts\common\vehicle::attach_vehicle_and_gopath(var_4);
  scripts\engine\utility::flag_wait("flag_canal_aq_car_2_path_end");
  var_0.godmode = 0;
}

truck_driver_damage_handler() {
  level endon("flag_canal_aq_car_2_path_end");
  thread truck_driver_delayed_death_handler();
  scripts\common\ai::magic_bullet_shield();
  self waittill("damage");
  scripts\engine\utility::flag_set("flag_canal_truck_driver_damaged");
}

truck_driver_delayed_death_handler() {
  scripts\engine\utility::flag_wait("flag_canal_aq_car_2_path_end");
  scripts\common\ai::stop_magic_bullet_shield();

  if(scripts\engine\utility::flag("flag_canal_truck_driver_damaged"))
    self kill();
}

canal_enemy_in_vehicle() {
  self endon("death");
  scripts\engine\sp\utility::set_ignoreme(1);
  scripts\engine\sp\utility::set_ignoreall(1);
  self waittill("unload");
  wait 1;
  scripts\engine\sp\utility::set_ignoreme(0);
  scripts\engine\sp\utility::set_ignoreall(0);
}

canal_enemy_death_monitor() {
  scripts\engine\utility::flag_wait_all("flag_canal_wave1_dead", "flag_canal_wave2_dead", "flag_canal_rpg_dead");
  scripts\engine\utility::flag_set("flag_canal_enemies_dead");
}

canal_kill_rushing_player() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_canal_enforcer_in_alley");
  level.enforcer endon("death");

  while(!isDefined(level.enforcer))
    waitframe();

  var_0 = getEnt("player_canal_kill_trig", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      var_1 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
      magicbullet("iw8_ar_akilo47", var_1, level.player getEye(), level.enforcer);
      level.player kill();
      break;
    }

    wait 0.2;
  }
}

canal_enemy_setup() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_attackeraccuracy_handler(0.5, 1.0, "flag_canal_player_mid_street", 5.0);
  self.grenadeammo = 0;
  scripts\engine\sp\utility::disable_long_death();
  scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\sp\utility::set_goal_entity(level.player);
  scripts\engine\sp\utility::set_goal_radius(512);
  scripts\engine\utility::flag_wait("flag_acquire_player_duck_under");
  self delete();
}

canal_car_jumper_setup() {
  self endon("death");
  self endon("entitydeleted");
  level endon("flag_canal_end");
  self.grenadeammo = 0;
  self.animname = "canal_car_jumper";
  scripts\engine\sp\utility::disable_long_death();
  scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\sp\utility::set_goal_radius(16);
  scripts\engine\sp\utility::set_allowdeath(1);
}

canal_enemy_fallback(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  var_2 = getEnt(var_1, "targetname");
  scripts\engine\utility::flag_wait(var_0);
  scripts\engine\sp\utility::set_goal_entity(var_2);
}

canal_dead_bodies() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_dead_bodies("canal_dead_bodies", "flag_acquire_player_end_traversal");
}

canal_car_alarms_off() {
  var_0 = getscriptablearray("canal_no_alarm_vehicles", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("car_alarm", "off");
}

canal_enforcer_handler() {
  level.enforcer endon("death");

  if(!isDefined(level.enforcer)) {
    return;
  }
  waitframe();
  level.enforcer.animname = "enforcer";
  level.enforcer scripts\engine\sp\utility::enable_dontevershoot();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_safe_run();
  level.enforcer scripts\engine\utility::set_movement_speed(300);
  level.enforcer scripts\engine\sp\utility::set_goal_radius(16);
  level.enforcer scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("canal_enforcer_turn_org", "targetname"));
  var_0 = scripts\engine\utility::getStruct("canal_enforcer_run1_org", "targetname");
  var_0 scripts\sp\anim::anim_reach_solo(level.enforcer, "bar_street_run_2");
  scripts\engine\utility::flag_set("flag_canal_enforcer_begin_blindfire");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_canal_enforcer_shoot_them();
  thread canal_enforcer_mb();
  var_0 scripts\common\anim::anim_single_solo_run(level.enforcer, "bar_street_run_2");
  scripts\engine\utility::flag_set("flag_canal_enforcer_finished_blindfire");
  var_1 = scripts\engine\utility::getStruct("canal_enforcer_run2_org", "targetname");
  var_1 scripts\sp\anim::anim_reach_solo(level.enforcer, "bar_street_run_4");
  var_1 scripts\common\anim::anim_single_solo_run(level.enforcer, "bar_street_run_4");
  var_2 = getnode("acquire_enforcer_cover_initial", "targetname");
  level.enforcer scripts\engine\sp\utility::set_goal_node(var_2);
  level.enforcer scripts\engine\sp\utility::set_goal_radius(32);
  level.enforcer waittill("goal");
  level.enforcer scripts\common\utility::clear_movement_speed();
  scripts\engine\utility::flag_set("flag_canal_enforcer_in_alley");
  var_3 = getnode("acquire_enforcer_cover", "targetname");
  level.enforcer scripts\engine\sp\utility::teleport_ai(var_3);
}

canal_enforcer_mb() {
  level.enforcer endon("death");
  level.enforcer endon("stop_shooting");
  var_0 = getanimlength(level.enforcer scripts\engine\utility::getanim("bar_street_run_2")) - 0.5;
  level.enforcer thread scripts\engine\sp\utility::notify_delay("stop_shooting", var_0);
  wait 0.2;
  var_1 = getcompleteweaponname("iw8_ar_akilo47");
  var_2 = weaponfiretime(var_1);
  var_3 = weaponclipsize(var_1);

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = level.enforcer gettagorigin(getweaponflashtagname(var_1));
    var_6 = level.enforcer gettagangles(getweaponflashtagname(var_1));

    if(distance2dsquared(level.enforcer.origin, level.player.origin) < 10000)
      var_7 = level.player getEye();
    else
      var_7 = var_5 + anglesToForward(var_6) * 100;

    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_ar_w"), level.enforcer, getweaponflashtagname(var_1));
    magicbullet("iw8_ar_akilo47", var_5, var_7 + scripts\engine\utility::randomvectorrange(0, 10), level.enforcer);
    wait(var_2);
  }
}

canal_pursuit_timer_handler() {
  scripts\engine\utility::flag_wait("flag_canal_enforcer_in_alley");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_canal_player_end_bridge", 20, undefined, 0);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_canal_end", 60, undefined, 0, "flag_canal_enemies_dead");
}

canal_price_handler() {
  level endon("missionfailed");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_set_accuracy_average();
  level.price scripts\common\utility::demeanor_override("sprint");
  level.price scripts\engine\sp\utility::set_goal_radius(32);
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  level.price scripts\engine\sp\utility::set_ignoreall(1);
  level.price scripts\engine\sp\utility::disable_ai_color();
  var_0 = getnode("price_canal_bridge_start", "targetname");
  level.price scripts\engine\sp\utility::set_goal_node(var_0);
  scripts\engine\utility::flag_wait_or_timeout("flag_canal_player_jump_down", 2.0);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_canal_enforcer_on_bridge();
  level.price scripts\engine\sp\utility::disable_dontevershoot();
  level.price scripts\engine\sp\utility::set_ignoreall(0);
  scripts\engine\utility::flag_wait("flag_canal_player_near_bridge");
  var_1 = getnode("price_canal_bridge_end", "targetname");
  level.price scripts\engine\sp\utility::set_goal_node(var_1);
  scripts\engine\utility::flag_wait("flag_canal_player_on_bridge");
  scripts\engine\sp\utility::autosave_by_name("canal_on_bridge");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_off();
  level.price scripts\engine\sp\utility::enable_ai_color();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("stpetersburg_canal_price_to_bridge_end", "targetname", "activate");
  level.price.grenadeawareness = 1;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_adjust_accuracy_over_time("flag_canal_enemies_dead");
  scripts\engine\utility::flag_wait("flag_canal_player_on_bridge");
  level.price scripts\common\utility::clear_demeanor_override();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_canal_price_into_alley();
  scripts\engine\utility::flag_wait_any("flag_canal_end", "flag_canal_enemies_dead");
  var_2 = scripts\engine\sp\utility::get_living_ai_array("canal_aq", "script_noteworthy");
  var_2 = scripts\engine\utility::array_removedead_or_dying(var_2);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_clean_up_last_enemy(var_2, randomfloatrange(4.0, 6.0));
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("stpetersburg_canal_price_to_street_end", "targetname", "activate");
  waitframe();
  disable_canal_trigs();
}

canal_driveby_vignette() {
  scripts\engine\utility::flag_wait("flag_canal_player_jump_down");
  scripts\engine\utility::flag_set("flag_canal_driveby_start");
  scripts\engine\utility::flag_wait("flag_canal_driveby_close");

  if(level.player istouching(getEnt("canal_driveby_splash_zone", "targetname")))
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_canal_civilian_driveby_warning();
}

walla_canal_civs_01() {
  var_0 = spawn("script_origin", (-339, 466, 114));
  var_0 playSound("stp_walla_bridge_civs_grp_01", "sounddone");
  wait 1;
  var_0 moveTo((-833, 1218, 114), 7);
  var_0 waittill("sounddone");
  var_0 delete();
}

walla_canal_civs_02() {
  var_0 = spawn("script_origin", (-1927, 368, 114));
  var_0 playSound("stp_walla_bridge_civs_grp_02", "sounddone");
  var_0 moveTo((-2620, 1256, 114), 5);
  wait 1;
  var_1 = spawn("script_origin", (-1826, -316, 114));
  var_1 playSound("stp_walla_bridge_civs_man_01");
  var_1 moveTo((-1762, 315, 114), 4);
  var_0 waittill("sounddone");
  var_0 delete();
  var_1 delete();
}

canal_rpg_handler() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_attackeraccuracy_handler(0.25, 0.75, "flag_canal_player_mid_street", 1.0);
  scripts\engine\sp\utility::enable_dontevershoot();
  scripts\engine\sp\utility::set_ignoreme(1);
  self allowedstances("crouch");
  self.animname = "generic";
  thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
  scripts\engine\sp\utility::set_ignoresuppression(1);
  scripts\engine\utility::disable_pain();
  var_0 = scripts\sp\utility::make_weapon("iw8_la_rpapa7_straight_ai");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  scripts\engine\utility::flag_wait("flag_canal_aq_car_2_path_end");
  var_1 = scripts\engine\utility::getStructArray("rpg_scripted_shot", "targetname");
  var_2 = scripts\engine\utility::getclosest(level.player.origin, var_1);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  self setentitytarget(var_3);
  self shoot();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_canal_price_rpg();
  scripts\common\ai::stop_magic_bullet_shield();
  scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\utility::enable_pain();
  scripts\engine\sp\utility::set_ignoresuppression(0);
  scripts\common\anim::anim_single_solo(self, "rpg_reload");
  self clearentitytarget();
  self allowedstances("crouch", "stand");
  scripts\engine\sp\utility::disable_dontevershoot();
  thread canal_rpg_firing_loop();
  scripts\engine\utility::flag_wait("flag_canal_player_mid_street");
  scripts\engine\sp\utility::set_ignoreme(0);
}

canal_rpg_earthquake_handler() {
  self waittill("death");
  earthquake(0.5, 0.5, self.origin, 500);
}

canal_rpg_firing_loop() {
  self endon("death");
  self endon("entitydeleted");
  level.player endon("death");
  var_0 = 0;
  var_1 = scripts\common\utility::getdifficulty();
  var_2 = 40;

  if(var_1 == "easy")
    var_2 = 80;
  else if(var_1 == "medium")
    var_2 = 60;

  while(!var_0) {
    waitframe();
    self waittill("missile_fire");
    scripts\engine\sp\utility::enable_dontevershoot();
    var_3 = 0;
    var_4 = 0;

    while(var_3 == 0 && var_4 < var_2) {
      var_3 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(10));
      var_4++;
      wait 0.1;
    }

    wait 1.0;
    scripts\engine\sp\utility::disable_dontevershoot();
    var_0 = scripts\engine\sp\utility::players_within_distance(600, self.origin);
  }
}

canal_car_handler() {
  wait 1;
  var_0 = getscriptablearray("canal_car", "targetname");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("body", "no_process");
    var_2 thread canal_car_damage_check();
    var_2 thread canal_car_death_check();
  }
}

canal_car_damage_check() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && var_1 == level.player && var_0 > 100)
      self setscriptablepartstate("body", "light_smoke");

    if(var_0 > 1000) {
      if(isDefined(var_9) && (getweaponbasename(var_9) == "iw8_la_rpapa7_ai" || getweaponbasename(var_9) == "iw8_la_rpapa7_straight_ai")) {
        var_10 = distance2dsquared(var_3, self.origin);

        if(var_10 < squared(80))
          self setscriptablepartstate("body", "flareup");
        else if(var_10 < squared(120))
          self setscriptablepartstate("body", "heavy_smoke");
        else
          self setscriptablepartstate("body", "light_smoke");

        wait 0.1;
        break;
      }
    }

    waitframe();
  }
}

canal_car_death_check() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    var_0 = self getscriptablepartstate("body");

    if(isDefined(var_0)) {
      if(var_0 == "dead") {
        var_1 = getcorpsearrayinradius(self.origin, 40);
        scripts\engine\utility::array_delete(var_1);
        return;
      }
    }

    wait 0.1;
  }
}

canal_civ_handler() {
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_civ", ::canal_civ_panic);
  wait 1;
  scripts\engine\utility::flag_wait("flag_canal_player_jump_down");
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("canal_civ");
  thread walla_canal_civs_01();
  var_1 = scripts\engine\utility::getStructArray("canal_car_civ_struct", "targetname");

  foreach(var_3 in var_1) {
    var_3 thread canal_civ_car_setup();
    waitframe();
  }

  scripts\engine\utility::flag_wait("flag_evade_begin");
  scripts\engine\utility::array_delete(var_0);
}

canal_civ_panic() {
  self endon("death");
  self endon("entitydeleted");
  scripts\common\utility::demeanor_override("sprint");
  self.ignoreme = 1;

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "canal_civA_stumble") {
      var_0 = getnode("civA_stumble_goal_node", "targetname");
      var_1 = scripts\engine\utility::getStruct("canal_civA_stumble_2_org", "targetname");
      var_2 = scripts\engine\utility::getStruct("canal_civA_stumble_3_org", "targetname");
      self.animname = "generic";
      self.allowdeath = 1;
      self.diequietly = 1;
      scripts\engine\utility::flag_wait("flag_canal_car_guy_spawn");
      var_1 scripts\sp\anim::anim_reach_solo(self, var_1.animation);
      thread scripts\engine\utility::playsoundonentity("stp_walla_bridge_civs_woman_01");
      var_1 scripts\common\anim::anim_single_solo_run(self, var_1.animation);
      var_2 scripts\sp\anim::anim_reach_solo(self, var_2.animation);
      var_2 scripts\common\anim::anim_single_solo_run(self, var_2.animation);
      scripts\engine\sp\utility::set_goal_node(var_0);
    }

    if(self.script_noteworthy == "canal_civB_stumble") {
      var_3 = getnode("civB_stumble_goal_node", "targetname");
      var_4 = scripts\engine\utility::getStruct("canal_civB_stumble_1_org", "targetname");
      var_5 = scripts\engine\utility::getStruct("canal_civB_stumble_2_org", "targetname");
      self.animname = "generic";
      self.allowdeath = 1;
      self.diequietly = 1;
      scripts\engine\utility::flag_wait("flag_canal_player_on_bridge");
      thread walla_canal_civs_02();
      var_4 scripts\sp\anim::anim_reach_solo(self, var_4.animation);
      var_4 scripts\common\anim::anim_single_solo_run(self, var_4.animation);
      var_5 scripts\sp\anim::anim_reach_solo(self, var_5.animation);
      var_5 scripts\common\anim::anim_single_solo_run(self, var_5.animation);
      scripts\engine\sp\utility::set_goal_node(var_3);
    }
  }
}

canal_civ_car_setup() {
  if(!isDefined(self.script_namenumber)) {
    scripts\engine\utility::cointoss();

    if(scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::cointoss_variable(75))
      return;
  }

  var_0 = getspawnerarray("canal_car_fakeciv");
  var_1 = scripts\engine\utility::random(var_0);
  var_2 = var_1 scripts\engine\sp\utility::spawn_ai(1);
  var_2.animname = "generic";
  var_2.animnode = self;
  var_2.current_state = "idle";
  var_2.ignoreme = 1;
  var_2.no_breath_fx = 1;
  var_2.diequietly = 1;
  var_2 endon("death");
  var_2 endon("entitydeleted");
  var_2.friend_kill_points = int(level.friendlyfire["friend_kill_points"] * 0.5);
  wait 1.0;
  var_2 notify("stop_civilian_fail_wrapper");
  thread scripts\common\anim::anim_loop_solo(var_2, self.animation, "end_loop");
  var_2 scripts\engine\sp\utility::set_allowdeath(0);
  var_2.noragdoll = 1;
  var_2.skipdeathanim = 1;
  var_2 thread canal_civ_car_damage_handler(self);
  var_2 thread canal_civ_car_mb();

  if(isDefined(self.script_noteworthy)) {
    var_3 = getscriptablearray(self.script_noteworthy, "script_noteworthy");

    while(isDefined(var_3[0])) {
      var_4 = var_3[0] getscriptablepartstate("body");

      if(isDefined(var_4)) {
        if(var_4 == "flareup" && isalive(var_2))
          var_2 notify("fake_death");
      }

      wait 0.1;
    }
  }
}

canal_civ_car_damage_handler(var_0) {
  self endon("entitydeleted");
  scripts\engine\utility::waittill_any("bullethit", "fake_death");
  var_0 notify("end_loop");
  var_0 scripts\common\anim::anim_single_solo(self, var_0.script_parameters);
  var_0 scripts\common\anim::anim_last_frame_solo(self, var_0.script_parameters);
  wait 0.1;
  scripts\engine\sp\utility::die();
}

canal_civ_car_mb() {
  self endon("death");
  self endon("entitydeleted");
  level.enforcer endon("death");

  while(!scripts\engine\utility::flag("flag_canal_player_end_street")) {
    var_0 = scripts\engine\sp\utility::players_within_distance(200, self.origin);
    var_1 = scripts\engine\sp\utility::players_within_distance(300, self.origin);
    var_2 = scripts\engine\sp\utility::players_within_distance(600, self.origin);
    var_3 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(15));
    var_4 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(45));

    if(var_0) {
      break;
    }

    if(var_4 && var_1) {
      break;
    }

    if(var_3 && var_2) {
      break;
    }

    wait 0.1;
  }

  var_5 = scripts\engine\utility::getStruct("canal_civ_mb_source", "targetname");
  var_6 = vectortoangles(self getEye() - var_5.origin);
  var_7 = self getEye() + var_6 * 100;
  magicbullet("iw8_ar_akilo47", var_7, self getEye(), level.enforcer);
  playFXOnTag(scripts\engine\utility::getfx("vfx_blood_hit_01"), self, "j_head");
  self notify("fake_death");
}

disable_canal_trigs() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("stpetersburg_canal_trig", "script_noteworthy", "disable");
}

canal_extra_police_car() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("canal_police_car");
  var_0.godmode = 1;
  wait 1;
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1 linkTo(var_0, "tag_origin", (0, 0, 32.25), (0, 0, 0));
  var_1 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
  scripts\engine\utility::flag_wait("flag_evade_enter_cafe");
  var_1 scripts\engine\sp\utility::fx_stopontag_safe("vfx_stpburg_police_lights", "tag_origin");
  var_1 delete();
  var_0 delete();
}