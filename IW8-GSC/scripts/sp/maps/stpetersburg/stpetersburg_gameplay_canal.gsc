/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_gameplay_canal.gsc
************************************************************************/

function canal_init() {
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

function canal_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("flag_canal_player_jump_down", "stpetersburg_intro_geo_tr", undefined);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("flag_canal_player_end_bridge", "stpetersburg_apartment_script_tr", "stpetersburg_cafe_script_tr");
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

function canal_enemy_handler() {
  thread canal_enemy_death_monitor();
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave1", &scripts\sp\maps\stpetersburg\stpetersburg_utility::setup_enemy_for_price_clean_up);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave1", &canal_enemy_setup);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave1", &canal_enemy_fallback, "flag_canal_player_mid_street", "canal_vol3");
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_aq_car_1_start", &canal_enemy_in_vehicle);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_aq_car_1_start", &canal_check_player_shoot_first);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_aq_car_1_start", &canal_enemy_setup);
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("canal_aq_car_1");
  scripts\engine\utility::flag_wait_any("flag_canal_player_end_bridge", "flag_canal_player_shoot_first");

  if(isalive(var0)) {
    var0 scripts\common\vehicle::vehicle_unload();
  }

  scripts\engine\utility::flag_wait("flag_canal_player_end_bridge");
  var1 = scripts\engine\sp\utility::array_spawn_targetname("canal_wave1");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_canal_aq_inbound();
  scripts\engine\utility::flag_wait("flag_canal_enforcer_finished_blindfire");
  thread canal_enemy_rpg_truck();
  scripts\engine\utility::flag_wait_any("flag_canal_player_mid_street", "flag_canal_wave1_dead", "flag_canal_rpg_dead");
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave2", &scripts\sp\maps\stpetersburg\stpetersburg_utility::setup_enemy_for_price_clean_up);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave2", &canal_enemy_setup);
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_wave2", &canal_enemy_fallback, "flag_canal_end", "acquire_vol1");
  var2 = scripts\engine\sp\utility::array_spawn_targetname("canal_wave2");
}

function canal_check_player_shoot_first() {
  level endon("flag_canal_player_shoot_first");
  level endon("flag_canal_player_end_bridge");
  scripts\engine\utility::waittill_any("damage", "death", "bulletwhizby");
  scripts\engine\utility::flag_set("flag_canal_player_shoot_first");
}

function canal_enemy_rpg_truck() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("canal_aq_car_2");
  waitframe();
  var0.godmode = 1;
  thread truck_driver_damage_handler();
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_rpg", &canal_rpg_handler);
  var1 = scripts\engine\sp\utility::spawn_targetname("canal_rpg");
  var2 = var0 gettagorigin("tag_bed2");
  var3 = var1.angles;
  var1 forceteleport(var2, var3);
  var1 linktomoveoffset(var0, "tag_bed2");
  var4 = getvehiclenode("canal_aq_car_2_start", "targetname");
  waitframe();
  var0 vehicle_setspeed(10, 10, 5);
  var0 scripts\common\vehicle::attach_vehicle_and_gopath(var4);
  scripts\engine\utility::flag_wait("flag_canal_aq_car_2_path_end");
  var0.godmode = 0;
}

function truck_driver_damage_handler() {
  level endon("flag_canal_aq_car_2_path_end");
  thread truck_driver_delayed_death_handler();
  scripts\common\ai::magic_bullet_shield();
  self waittill("damage");
  scripts\engine\utility::flag_set("flag_canal_truck_driver_damaged");
}

function truck_driver_delayed_death_handler() {
  scripts\engine\utility::flag_wait("flag_canal_aq_car_2_path_end");
  scripts\common\ai::stop_magic_bullet_shield();

  if(scripts\engine\utility::flag("flag_canal_truck_driver_damaged")) {
    self kill();
    return;
  }
}

function canal_enemy_in_vehicle() {
  self endon("death");
  scripts\engine\sp\utility::set_ignoreme(1);
  scripts\engine\sp\utility::set_ignoreall(1);
  self waittill("unload");
  wait 1;
  scripts\engine\sp\utility::set_ignoreme(0);
  scripts\engine\sp\utility::set_ignoreall(0);
}

function canal_enemy_death_monitor() {
  scripts\engine\utility::flag_wait_all("flag_canal_wave1_dead", "flag_canal_wave2_dead", "flag_canal_rpg_dead");
  scripts\engine\utility::flag_set("flag_canal_enemies_dead");
}

function canal_kill_rushing_player() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_canal_enforcer_in_alley");
  level.enforcer endon("death");

  while(!isDefined(level.enforcer)) {
    waitframe();
  }

  var0 = getEnt("player_canal_kill_trig", "targetname");

  for(;;) {
    if(level.player istouching(var0)) {
      var1 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
      magicbullet("iw8_ar_akilo47", var1, level.player getEye(), level.enforcer);
      level.player kill();
      break;
    }

    wait 0.2;
  }
}

function canal_enemy_setup() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::set_attackeraccuracy_handler(0.5, 1, "flag_canal_player_mid_street", 5);
  self.grenadeammo = 0;
  scripts\engine\sp\utility::disable_long_death();
  scripts\engine\sp\utility::set_battlechatter(1);
  scripts\engine\sp\utility::set_goal_entity(level.player);
  scripts\engine\sp\utility::set_goal_radius(512);
  scripts\engine\utility::flag_wait("flag_acquire_player_duck_under");
  self delete();
}

function canal_car_jumper_setup() {
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

function canal_enemy_fallback(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  var2 = getEnt(var1, "targetname");
  scripts\engine\utility::flag_wait(var0);
  scripts\engine\sp\utility::set_goal_entity(var2);
}

function canal_dead_bodies() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility::setup_dead_bodies("canal_dead_bodies", "flag_acquire_player_end_traversal");
}

function canal_car_alarms_off() {
  var0 = getscriptablearray("canal_no_alarm_vehicles", "script_noteworthy");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("car_alarm", "off");
  }
}

function canal_enforcer_handler() {
  level.enforcer endon("death");

  if(!isDefined(level.enforcer)) {
    return;
  }

  waitframe();
  level.enforcer.animname = "enforcer";
  level.enforcer scripts\engine\sp\utility::enable_dontevershoot();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_safe_run();
  level.enforcer scripts\engine\utility::set_movement_speed(300);
  level.enforcer scripts\engine\sp\utility::set_goal_radius(16);
  level.enforcer scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("canal_enforcer_turn_org", "targetname"));
  var0 = scripts\engine\utility::getStruct("canal_enforcer_run1_org", "targetname");
  var0 scripts\sp\anim::anim_reach_solo(level.enforcer, "bar_street_run_2");
  scripts\engine\utility::flag_set("flag_canal_enforcer_begin_blindfire");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_canal_enforcer_shoot_them();
  thread canal_enforcer_mb();
  var0 scripts\common\anim::anim_single_solo_run(level.enforcer, "bar_street_run_2");
  scripts\engine\utility::flag_set("flag_canal_enforcer_finished_blindfire");
  var1 = scripts\engine\utility::getStruct("canal_enforcer_run2_org", "targetname");
  var1 scripts\sp\anim::anim_reach_solo(level.enforcer, "bar_street_run_4");
  var1 scripts\common\anim::anim_single_solo_run(level.enforcer, "bar_street_run_4");
  var2 = getnode("acquire_enforcer_cover_initial", "targetname");
  level.enforcer scripts\engine\sp\utility::set_goal_node(var2);
  level.enforcer scripts\engine\sp\utility::set_goal_radius(32);
  level.enforcer waittill("goal");
  level.enforcer scripts\common\utility::clear_movement_speed();
  scripts\engine\utility::flag_set("flag_canal_enforcer_in_alley");
  var3 = getnode("acquire_enforcer_cover", "targetname");
  level.enforcer scripts\engine\sp\utility::teleport_ai(var3);
}

function canal_enforcer_mb() {
  level.enforcer endon("death");
  level.enforcer endon("stop_shooting");
  var0 = getanimlength(level.enforcer scripts\engine\utility::getanim("bar_street_run_2")) - 0.5;
  level.enforcer thread scripts\engine\sp\utility::notify_delay("stop_shooting", var0);
  wait 0.2;
  var1 = getcompleteweaponname("iw8_ar_akilo47");
  var2 = weaponfiretime(var1);
  var3 = weaponclipsize(var1);

  for(var4 = 0; var4 < var3; var4++) {
    var5 = level.enforcer gettagorigin(getweaponflashtagname(var1));
    var6 = level.enforcer gettagangles(getweaponflashtagname(var1));

    if(distance2dsquared(level.enforcer.origin, level.player.origin) < 10000) {
      var7 = level.player getEye();
    } else {
      var7 = var5 + anglesToForward(var6) * 100;
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_ar_w"), level.enforcer, getweaponflashtagname(var1));
    magicbullet("iw8_ar_akilo47", var5, var7 + scripts\engine\utility::randomvectorrange(0, 10), level.enforcer);
    wait var2;
  }
}

function canal_pursuit_timer_handler() {
  scripts\engine\utility::flag_wait("flag_canal_enforcer_in_alley");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_canal_player_end_bridge", 20, undefined, 0);
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_canal_end", 60, undefined, 0, "flag_canal_enemies_dead");
}

function canal_price_handler() {
  level endon("missionfailed");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_set_accuracy_average();
  level.price scripts\common\utility::demeanor_override("sprint");
  level.price scripts\engine\sp\utility::set_goal_radius(32);
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  level.price scripts\engine\sp\utility::set_ignoreall(1);
  level.price scripts\engine\sp\utility::disable_ai_color();
  var0 = getnode("price_canal_bridge_start", "targetname");
  level.price scripts\engine\sp\utility::set_goal_node(var0);
  scripts\engine\utility::flag_wait_or_timeout("flag_canal_player_jump_down", 2);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_canal_enforcer_on_bridge();
  level.price scripts\engine\sp\utility::disable_dontevershoot();
  level.price scripts\engine\sp\utility::set_ignoreall(0);
  scripts\engine\utility::flag_wait("flag_canal_player_near_bridge");
  var1 = getnode("price_canal_bridge_end", "targetname");
  level.price scripts\engine\sp\utility::set_goal_node(var1);
  scripts\engine\utility::flag_wait("flag_canal_player_on_bridge");
  scripts\engine\sp\utility::autosave_by_name("canal_on_bridge");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_off();
  level.price scripts\engine\sp\utility::enable_ai_color();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::trigger_safe_function("stpetersburg_canal_price_to_bridge_end", "targetname", "activate");
  level.price.grenadeawareness = 1;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::price_adjust_accuracy_over_time("flag_canal_enemies_dead");
  scripts\engine\utility::flag_wait("flag_canal_player_on_bridge");
  level.price scripts\common\utility::clear_demeanor_override();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_canal_price_into_alley();
  scripts\engine\utility::flag_wait_any("flag_canal_end", "flag_canal_enemies_dead");
  var2 = scripts\engine\sp\utility::get_living_ai_array("canal_aq", "script_noteworthy");
  var2 = scripts\engine\utility::array_removedead_or_dying(var2);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::price_clean_up_last_enemy(var2, randomfloatrange(4, 6));
  scripts\sp\maps\stpetersburg\stpetersburg_utility::trigger_safe_function("stpetersburg_canal_price_to_street_end", "targetname", "activate");
  waitframe();
  disable_canal_trigs();
}

function canal_driveby_vignette() {
  scripts\engine\utility::flag_wait("flag_canal_player_jump_down");
  scripts\engine\utility::flag_set("flag_canal_driveby_start");
  scripts\engine\utility::flag_wait("flag_canal_driveby_close");

  if(level.player istouching(getEnt("canal_driveby_splash_zone", "targetname"))) {
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_canal_civilian_driveby_warning();
    return;
  }
}

function walla_canal_civs_01() {
  var0 = spawn("script_origin", (-339, 466, 114));
  var0 playSound("stp_walla_bridge_civs_grp_01", "sounddone");
  wait 1;
  var0 moveTo((-833, 1218, 114), 7);
  var0 waittill("sounddone");
  var0 delete();
}

function walla_canal_civs_02() {
  var0 = spawn("script_origin", (-1927, 368, 114));
  var0 playSound("stp_walla_bridge_civs_grp_02", "sounddone");
  var0 moveTo((-2620, 1256, 114), 5);
  wait 1;
  var1 = spawn("script_origin", (-1826, -316, 114));
  var1 playSound("stp_walla_bridge_civs_man_01");
  var1 moveTo((-1762, 315, 114), 4);
  var0 waittill("sounddone");
  var0 delete();
  var1 delete();
}

function canal_rpg_handler() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::set_attackeraccuracy_handler(0.25, 0.75, "flag_canal_player_mid_street", 1);
  scripts\engine\sp\utility::enable_dontevershoot();
  scripts\engine\sp\utility::set_ignoreme(1);
  self allowedstances("crouch");
  self.animname = "generic";
  thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
  scripts\engine\sp\utility::set_ignoresuppression(1);
  scripts\engine\utility::disable_pain();
  var0 = scripts\sp\utility::make_weapon("iw8_la_rpapa7_straight_ai");
  scripts\anim\shared::forceuseweapon(var0, "primary");
  scripts\engine\utility::flag_wait("flag_canal_aq_car_2_path_end");
  var1 = scripts\engine\utility::getStructArray("rpg_scripted_shot", "targetname");
  var2 = scripts\engine\utility::getclosest(level.player.origin, var1);
  var3 = scripts\engine\utility::spawn_tag_origin(var2.origin, var2.angles);
  self setentitytarget(var3);
  self shoot();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_canal_price_rpg();
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

function canal_rpg_earthquake_handler() {
  self waittill("death");
  earthquake(0.5, 0.5, self.origin, 500);
}

function canal_rpg_firing_loop() {
  self endon("death");
  self endon("entitydeleted");
  level.player endon("death");
  var0 = 0;
  var1 = scripts\common\utility::getdifficulty();
  var2 = 40;

  if(var1 == "easy") {
    var2 = 80;
    goto LOC_00000046;
  }

  jumpiffalse(var1 == "medium") LOC_00000046;
  var2 = 60;

  while(!var0) {
    waitframe();
    self waittill("missile_fire");
    scripts\engine\sp\utility::enable_dontevershoot();
    var3 = 0;
    var4 = 0;

    while(var3 == 0 && var4 < var2) {
      var3 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(10));
      var4++;
      wait 0.1;
    }

    wait 1;
    scripts\engine\sp\utility::disable_dontevershoot();
    var0 = scripts\engine\sp\utility::players_within_distance(600, self.origin);
  }
}

function canal_car_handler() {
  wait 1;
  var0 = getscriptablearray("canal_car", "targetname");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("body", "no_process");
    thread canal_car_damage_check();
    thread canal_car_death_check();
  }
}

function canal_car_damage_check() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var1) && var1 == level.player && var0 > 100) {
      self setscriptablepartstate("body", "light_smoke");
    }

    if(var0 > 1000) {
      if(isDefined(var9) && (getweaponbasename(var9) == "iw8_la_rpapa7_ai" || getweaponbasename(var9) == "iw8_la_rpapa7_straight_ai")) {
        var10 = distance2dsquared(var3, self.origin);

        if(var10 < squared(80)) {
          self setscriptablepartstate("body", "flareup");
        } else if(var10 < squared(120)) {
          self setscriptablepartstate("body", "heavy_smoke");
        } else {
          self setscriptablepartstate("body", "light_smoke");
        }

        wait 0.1;
        break;
      }
    }

    waitframe();
  }
}

function canal_car_death_check() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    var0 = self getscriptablepartstate("body");

    if(isDefined(var0)) {
      if(var0 == "dead") {
        var1 = getcorpsearrayinradius(self.origin, 40);
        scripts\engine\utility::array_delete(var1);
        return;
      }
    }

    wait 0.1;
  }
}

function canal_civ_handler() {
  scripts\engine\sp\utility::array_spawn_function_targetname("canal_civ", &canal_civ_panic);
  wait 1;
  scripts\engine\utility::flag_wait("flag_canal_player_jump_down");
  var0 = scripts\engine\sp\utility::array_spawn_targetname("canal_civ");
  thread walla_canal_civs_01();
  var1 = scripts\engine\utility::getStructArray("canal_car_civ_struct", "targetname");

  foreach(var3 in var1) {
    thread canal_civ_car_setup();
    waitframe();
  }

  scripts\engine\utility::flag_wait("flag_evade_begin");
  scripts\engine\utility::array_delete(var0);
}

function canal_civ_panic() {
  self endon("death");
  self endon("entitydeleted");
  scripts\common\utility::demeanor_override("sprint");
  self.ignoreme = 1;

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "canal_civA_stumble") {
      var0 = getnode("civA_stumble_goal_node", "targetname");
      var1 = scripts\engine\utility::getStruct("canal_civA_stumble_2_org", "targetname");
      var2 = scripts\engine\utility::getStruct("canal_civA_stumble_3_org", "targetname");
      self.animname = "generic";
      self.allowdeath = 1;
      self.diequietly = 1;
      scripts\engine\utility::flag_wait("flag_canal_car_guy_spawn");
      var1 scripts\sp\anim::anim_reach_solo(self, var1.animation);
      thread scripts\engine\utility::playsoundonentity("stp_walla_bridge_civs_woman_01");
      var1 scripts\common\anim::anim_single_solo_run(self, var1.animation);
      var2 scripts\sp\anim::anim_reach_solo(self, var2.animation);
      var2 scripts\common\anim::anim_single_solo_run(self, var2.animation);
      scripts\engine\sp\utility::set_goal_node(var0);
    }

    if(self.script_noteworthy == "canal_civB_stumble") {
      var3 = getnode("civB_stumble_goal_node", "targetname");
      var4 = scripts\engine\utility::getStruct("canal_civB_stumble_1_org", "targetname");
      var5 = scripts\engine\utility::getStruct("canal_civB_stumble_2_org", "targetname");
      self.animname = "generic";
      self.allowdeath = 1;
      self.diequietly = 1;
      scripts\engine\utility::flag_wait("flag_canal_player_on_bridge");
      thread walla_canal_civs_02();
      var4 scripts\sp\anim::anim_reach_solo(self, var4.animation);
      var4 scripts\common\anim::anim_single_solo_run(self, var4.animation);
      var5 scripts\sp\anim::anim_reach_solo(self, var5.animation);
      var5 scripts\common\anim::anim_single_solo_run(self, var5.animation);
      scripts\engine\sp\utility::set_goal_node(var3);
      return;
    }

    return;
  }
}

function canal_civ_car_setup() {
  if(!isDefined(self.script_namenumber)) {
    scripts\engine\utility::cointoss();

    if(scripts\sp\maps\stpetersburg\stpetersburg_utility::cointoss_variable(75)) {
      return;
    }
  }

  var0 = getspawnerarray("canal_car_fakeciv");
  var1 = scripts\engine\utility::random(var0);
  var2 = var1 scripts\engine\sp\utility::spawn_ai(1);
  var2.animname = "generic";
  var2.animnode = self;
  var2.current_state = "idle";
  var2.ignoreme = 1;
  var2.no_breath_fx = 1;
  var2.diequietly = 1;
  var2 endon("death");
  var2 endon("entitydeleted");
  var2.friend_kill_points = int(level.friendlyfire["friend_kill_points"] * 0.5);
  wait 1;
  var2 notify("stop_civilian_fail_wrapper");
  thread scripts\common\anim::anim_loop_solo(var2, self.animation, "end_loop");
  var2 scripts\engine\sp\utility::set_allowdeath(0);
  var2.noragdoll = 1;
  var2.skipdeathanim = 1;
  thread canal_civ_car_damage_handler(var2);
  thread canal_civ_car_mb();

  if(isDefined(self.script_noteworthy)) {
    var3 = getscriptablearray(self.script_noteworthy, "script_noteworthy");

    while(isDefined(var3[0])) {
      var4 = var3[0] getscriptablepartstate("body");

      if(isDefined(var4)) {
        if(var4 == "flareup" && isalive(var2)) {
          var2 notify("fake_death");
        }
      }

      wait 0.1;
    }

    return;
  }
}

function canal_civ_car_damage_handler(var0) {
  self endon("entitydeleted");
  scripts\engine\utility::waittill_any("bullethit", "fake_death");
  var0 notify("end_loop");
  var0 scripts\common\anim::anim_single_solo(self, var0.script_parameters);
  var0 scripts\common\anim::anim_last_frame_solo(self, var0.script_parameters);
  wait 0.1;
  scripts\engine\sp\utility::die();
}

function canal_civ_car_mb() {
  self endon("death");
  self endon("entitydeleted");
  level.enforcer endon("death");

  while(!scripts\engine\utility::flag("flag_canal_player_end_street")) {
    var0 = scripts\engine\sp\utility::players_within_distance(200, self.origin);
    var1 = scripts\engine\sp\utility::players_within_distance(300, self.origin);
    var2 = scripts\engine\sp\utility::players_within_distance(600, self.origin);
    var3 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(15));
    var4 = scripts\engine\sp\utility::within_fov_of_players(self getEye(), cos(45));

    if(var0) {
      break;
    }

    if(var4 && var1) {
      break;
    }

    if(var3 && var2) {
      break;
    }

    wait 0.1;
  }

  var5 = scripts\engine\utility::getStruct("canal_civ_mb_source", "targetname");
  var6 = vectortoangles(self getEye() - var5.origin);
  var7 = self getEye() + var6 * 100;
  magicbullet("iw8_ar_akilo47", var7, self getEye(), level.enforcer);
  playFXOnTag(scripts\engine\utility::getfx("vfx_blood_hit_01"), self, "j_head");
  self notify("fake_death");
}

function disable_canal_trigs() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility::trigger_safe_function("stpetersburg_canal_trig", "script_noteworthy", "disable");
}

function canal_extra_police_car() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("canal_police_car");
  var0.godmode = 1;
  wait 1;
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var1 linkTo(var0, "tag_origin", (0, 0, 32.25), (0, 0, 0));
  var1 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
  scripts\engine\utility::flag_wait("flag_evade_enter_cafe");
  var1 scripts\engine\sp\utility::fx_stopontag_safe("vfx_stpburg_police_lights", "tag_origin");
  var1 delete();
  var0 delete();
}