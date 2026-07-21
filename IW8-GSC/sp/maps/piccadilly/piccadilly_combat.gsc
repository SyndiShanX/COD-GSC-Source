/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\piccadilly\piccadilly_combat.gsc
****************************************************/

start() {
  scripts\engine\utility::flag_set("combat_start");
  thread police_vignette();
  scripts\engine\utility::flag_wait("ally_setup_done");
  level thread car_jumper();
  scripts\engine\sp\utility::set_start_location("combat_sas", scripts\engine\utility::array_add(level.sas, level.player));
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_post_bomb_street_10", 100);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk52_post_bomb_street_20", 100);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_post_bomb_street_30", 200);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_post_bomb_street_90", 300);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_post_bomb_street_100", 400);
}

start_lillywhites() {
  setDvar("pic_intro", 0);
  scripts\engine\utility::flag_wait("ally_setup_done");
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_spawn_trig");
  scripts\engine\sp\utility::set_start_location("lillywhites_start", scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_all_good_guys());
}

start_sting() {
  setDvar("pic_intro", 0);
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\engine\utility::flag_wait("ally_setup_done");
  scripts\engine\sp\utility::set_start_location("sting_start", scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_all_good_guys());
  scripts\engine\sp\utility::activate_trigger_with_targetname("sting_upstairs_hero_color");
  scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_spawn_trig");
}

start_sting_rear() {
  setDvar("pic_intro", 0);
  scripts\engine\utility::flag_wait("ally_setup_done");
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\engine\sp\utility::set_start_location("string_rear_start", scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_all_good_guys());
  scripts\engine\sp\utility::activate_trigger_with_targetname("sting_upstairs_hero_color");
  scripts\sp\spawner::killspawner(2);
  scripts\engine\sp\utility::activate_trigger_with_noteworthy("left_crash_trig_unlock");
}

start_right_underground() {
  setDvar("pic_intro", 0);
  scripts\engine\utility::flag_set("stop_far_cars");
  scripts\engine\utility::flag_wait("ally_setup_done");
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\engine\sp\utility::set_start_location("right_underground_start", scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_all_good_guys());
  scripts\sp\spawner::killspawner(2);
  scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_spawn_trig");
}

catchup() {
  setsaveddvar("TSSONTORK", 0);
  scripts\engine\utility::exploder("spec");
  scripts\engine\utility::flag_set("combat_start");
  level.player.participation = level.player.participation + 200;
}

main() {
  setsaveddvar("TSSONTORK", 0);
  scripts\engine\utility::flag_wait("init_done");
  scripts\engine\sp\utility::array_spawn_function_targetname("middle_lotus_enemies", ::lotus_decho_audio);
  scripts\engine\sp\utility::array_spawn_function_targetname("obj_frontline", ::frontline_police_logic);
  scripts\engine\sp\utility::array_spawn_function_targetname("tanto_doorway_flood", ::tanto_doorway_flood_logic);
  var_0 = getspawner("left_underground_attacker", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(::left_underground_attacker_awareness);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::spawn_sas_redshirts();
  setup_allies();
  scripts\engine\sp\utility::array_spawn_function_noteworthy("sting_window_guy", ::sting_window_guy);
  thread scripts\engine\sp\utility::set_flag_on_targetname_trigger("gap_approach");
  scripts\engine\utility::flag_init("center_fallback");
  scripts\engine\sp\utility::flagwaitthread("sniper_player_going_up", ::wake_snipers);
  scripts\engine\sp\utility::flagwaitthread("in_reading_place", scripts\engine\utility::flag_set, "player_entered_reading_place");
  thread combat_objectives();
  level thread rooftop_attackers();
  level thread spawn_start_enemies();
  level thread allies_respawn();
  level.combat_start = gettime();
  level thread sniper_perch_setup();
  level thread second_floor_player_watcher();
  level thread retreat_to_gap_sniping();
  level thread kill_locations_achievement_check();
  level thread top_left_sight_checker();
  level thread bus_entered();
  level.player thread sting_sniping();
  level thread left_side_street_runners();
  level thread sting_inside_enemy_accuracy();
  level thread sting_window_guys_retreat();
  level thread right_corner_civs();
  level thread right_side_combat();
  level thread delete_center_guys();
  level thread gap_right_combat();
  level thread right_side_cleanup();
  level thread spec_converge();
  thread middle_road_civ_runners();
  level thread left_side_kill_squad();
  thread conditional_enemies();
  level thread shoot_player_if_in_center();

  if(!scripts\sp\starts::is_after_start("combat")) {
    level thread friendly_fire_combat_start();
    level thread scripts\sp\maps\piccadilly\piccadilly_civs.gsc::start_civ_struct_spawner("right_start");
    level scripts\engine\utility::delaythread(0.1, scripts\sp\maps\piccadilly\piccadilly_civs.gsc::start_civ_struct_spawner, "combat_right");
    level scripts\engine\utility::delaythread(0.15, scripts\sp\maps\piccadilly\piccadilly_civs.gsc::start_civ_struct_spawner, "combat_left", 3);
    level scripts\engine\utility::delaythread(0.25, ::bus_animated_civs);
  }

  thread fake_civ_stream("back_store_fake_civs", "stop_storefront_drones");
  thread fake_civ_stream("close_fake_civs", "start_moveup_center");
  thread bg_cars();
  thread sniper_fodder();
  thread reading_place_friendlies_enter();
  thread lotus_bomber_logic();
  scripts\engine\sp\utility::flagwaitthread("player_did_sniping", ::sting_upstairs_extras);
  scripts\engine\sp\utility::flagwaitthread("lilly_door_lookat", ::lilly_entrance_draw);
  scripts\engine\sp\utility::flagwaitthread("going_right_side", ::right_side_draw_civs);
  scripts\engine\utility::exploder("spec");
  scripts\engine\sp\utility::autosave_by_name("combat_start");
  level.player scripts\engine\utility::delaythread(3.0, scripts\engine\sp\utility::set_ignoreme, 0);
  level.ctbuddy scripts\engine\utility::delaythread(3.0, scripts\engine\sp\utility::set_ignoreme, 0);

  if(!scripts\sp\starts::is_after_start("lillywhites"))
    thread vo_combat_start();

  var_1 = getEntArray("goalie_trig", "script_noteworthy");
  scripts\engine\utility::array_thread(var_1, ::no_rushin);
  thread scripts\sp\maps\piccadilly\piccadilly_gap.gsc::price_intro_debris_and_interact();
  scripts\engine\sp\utility::array_spawn_function_noteworthy("center_reinforce", ::center_enemy_spawnfunc);
  var_0 = getspawner("reading_pl_stairs_guy", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(::reading_pl_stairs_guy_logic);
  scripts\engine\utility::delaythread(5, ::spawn_snipers_early);
  scripts\engine\utility::flag_wait_all("inside_gap_flag", "gap_bomber_dead", "spec_price_intro_start");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::terminate_chatter();
}

left_underground_attacker_awareness() {
  self endon("death");

  for(;;) {
    var_0 = getaiarray("allies");

    foreach(var_2 in var_0) {
      var_2 getenemyinfo(self);

      if(isDefined(var_2.weapon) && !nullweapon(var_2.weapon))
        self getenemyinfo(var_2);
    }

    wait 3;
  }
}

kill_locations_achievement_check() {
  var_0 = ["player_underground_right", "player_underground_left", "in_reading_place", "player_in_aural_chic"];

  while(var_0.size) {
    var_1 = level.player.stats["kills"];

    while(var_1 == level.player.stats["kills"])
      waitframe();

    foreach(var_3 in var_0) {
      if(scripts\engine\utility::flag(var_3)) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_3);
        break;
      }
    }
  }

  scripts\sp\utility::giveachievement_wrapper("smokeout");
}

lotus_decho_audio() {
  if(scripts\common\vehicle::isvehicle()) {
    self vehicle_turnengineoff();
    self playSound("scn_piccadilly_hummer_terry_drivein");
    wait 3;
    self playSound("scn_piccadilly_hummer_terry_doors");
  }
}

friendly_fire_combat_start() {
  var_0 = level.friendlyfire["civilians_killed"];
  var_1 = level.friendlyfire["friend_kill_points"];
  level.friendlyfire["friend_kill_points"] = int(var_1 * 0.33);
  wait 11;
  level.friendlyfire["civilians_killed"] = var_0;
  level.friendlyfire["friend_kill_points"] = var_1;
}

spawn_snipers_early() {
  if(scripts\sp\starts::is_after_start("combat")) {
    return;
  }
  var_0 = getEnt("goal_start", "targetname");

  while(var_0 scripts\engine\sp\utility::get_ai_touching_volume("axis").size > 2)
    wait 0.5;

  scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_spawn_trig");
}

reading_place_friendlies_enter() {
  var_0 = getEnt("reading_place_friendlies_enter", "targetname");
  var_0 scripts\engine\utility::trigger_off();
  scripts\engine\utility::flag_wait_any("sting_window_guy_dead", "sting_window_guys_displace", "sniper_player_going_up");
  var_0 scripts\engine\utility::trigger_on();
}

no_rushin() {
  if(scripts\sp\starts::is_after_start("combat")) {
    return;
  }
  level endon("spec_price_intro_start");
  var_0 = 20;

  for(;;) {
    self waittill("trigger");
    var_1 = 0;
    var_2 = gettime() - level.combat_start;
    var_3 = istrue(level.player.stats["shots_hit"]);
    var_4 = level.player.stats["shots_fired"] == 0;

    if(var_2 < var_0 * 1000)
      var_1 = 1;
    else if(var_4 || !var_3)
      var_1 = 1;

    if(var_1) {
      break;
    }
  }

  if(istrue(level.spawned_goalie)) {
    return;
  }
  level.spawned_goalie = 1;
  var_5 = getspawnerarray(self.target);

  if(var_5.size > 1) {
    foreach(var_7 in var_5) {
      if(!level.player scripts\engine\trace::can_see_origin(var_7.origin, 0)) {
        var_7 scripts\engine\sp\utility::spawn_ai(1);
        return;
      }
    }
  } else
    var_9 = var_5[0] scripts\engine\sp\utility::spawn_ai(1);
}

conditional_enemies() {
  level endon("spec_price_intro_start");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    if(scripts\engine\utility::flag("extra_lotus_guys_check") && scripts\engine\utility::flag("player_entered_reading_place") && !var_0) {
      var_0 = 1;
      scripts\engine\sp\utility::activate_trigger_with_targetname("lotus_middle_enemy_trigger");
    }

    if(scripts\engine\utility::flag("reading_place_front") && !var_1) {
      if(scripts\engine\utility::flag("spawn_sting_rescue") || scripts\engine\utility::flag("player_entered_reading_place")) {
        waitframe();
        continue;
      }

      var_1 = 1;
      thread middle_reading_place_front_door_enemies();
    }

    if(var_0 && var_1) {
      return;
    }
    wait 0.5;
  }
}

middle_reading_place_front_door_enemies() {
  if(!scripts\engine\utility::flag("cancel_sting_rescue"))
    scripts\engine\utility::flag_set("cancel_sting_rescue");

  var_0 = getspawnerarray("reading_front_guys");

  foreach(var_2 in var_0) {
    for(;;) {
      if(getaiarray().size > 25)
        scripts\sp\maps\piccadilly\piccadilly_util.gsc::make_room_for_ai();

      var_3 = var_2 scripts\engine\sp\utility::spawn_ai(1);

      if(isalive(var_3)) {
        var_3 scripts\engine\utility::delaythread(20, ::close_in_on_far_player);
        var_3 scripts\engine\utility::set_movement_speed(200);
        break;
      }

      waitframe();
    }
  }
}

right_corner_civs() {
  scripts\engine\utility::flag_wait("right_side_looking");

  if(level.player.origin[0] > -270) {
    var_0 = scripts\engine\sp\utility::get_ai_group_ai("subway_right");

    if(var_0.size)
      scripts\engine\sp\utility::array_notify(var_0, "stop_killing_civs");

    return;
  }

  level thread right_subway_bg_fake_civs();
  var_1 = getspawnerarray("right_corner_civs");
  var_2 = scripts\engine\sp\utility::get_average_origin(var_1);
  var_3 = distance(level.player.origin, var_2);
  var_4 = vectortoangles(var_2 - level.player.origin);
  var_5 = level.player.origin + anglesToForward(var_4) * var_3 * 0.5;
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::crowd_screams(var_5);
  var_6 = [];

  for(var_7 = 0; var_7 < 6; var_7++) {
    foreach(var_9 in var_1) {
      var_10 = var_9 scripts\sp\maps\piccadilly\piccadilly_civs.gsc::spawn_civ("random");

      if(!isDefined(var_10)) {
        continue;
      }
      var_10.team = "allies";
      var_10 setthreatbiasgroup("civilians");
      var_10.attackeraccuracy = 5;
      var_10.health = 50;
      var_6[var_6.size] = var_10;
      var_10 thread scripts\sp\maps\piccadilly\piccadilly_civs.gsc::civ_struct_ai_go(var_9.target);
      var_10.ignoreme = 1;
      var_10 thread do_death_sound();
      var_10 scripts\engine\utility::delaythread(1, scripts\engine\sp\utility::set_ignoreme, 0);
      wait 0.05;
    }

    wait(randomfloatrange(0.5, 0.65));
  }
}

right_side_kill_squad_flags() {
  scripts\engine\utility::flag_wait_any("right_side_looking", "left_side_cleanup", "in_reading_place");

  if(!scripts\engine\utility::flag("right_side_looking"))
    scripts\engine\utility::flag_set("right_side_looking");
}

right_kill_squad_logic() {
  self endon("death");
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::kill_civs_til_player_sees_me();
  self.damage_functions[self.damage_functions.size] = ::right_kill_squad_dmg_func;
  thread scripts\common\ai::magic_bullet_shield(1);
  self.attackeraccuracy = 0;
  var_0 = scripts\engine\utility::flag_wait_any_return("right_side_looking", "spec_price_intro_start");

  if(var_0 != "right_side_looking") {
    if(istrue(self.magic_bullet_shield))
      scripts\common\ai::stop_magic_bullet_shield();

    self delete();
  }

  if(istrue(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self.attackeraccuracy = 0.6;
  scripts\engine\utility::waittill_any("civ_killer_end", "stop_killing_civs");

  for(;;) {
    if(distance2dsquared(self.origin, level.player.origin) > 2250000) {
      break;
    }

    if(istrue(self._blackboard.shootparams_starttime) && gettime() - self._blackboard.shootparams_starttime >= 5000) {
      break;
    }

    wait 1;
  }

  level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 500);
}

right_kill_squad_dmg_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\engine\utility::is_equal(var_1, level.player)) {
    if(istrue(self.magic_bullet_shield))
      scripts\common\ai::stop_magic_bullet_shield();

    if(!scripts\engine\utility::flag("right_side_looking"))
      scripts\engine\utility::flag_set("right_side_looking");
  }
}

lilly_entrance_draw() {
  var_0 = getspawner("lilly_door_draw", "targetname") stalingradspawn();
  waitframe();

  if(isalive(var_0)) {
    wait 1.3;

    if(!isalive(var_0)) {
      return;
    }
    scripts\sp\maps\piccadilly\piccadilly_anim.gsc::squib_head(var_0);
    var_0 scripts\sp\utility::do_damage(200, var_0 getEye(), undefined, undefined, "MOD_RIFLE_BULLET");
  }
}

left_side_kill_squad() {
  var_0 = getEnt("left_kill_squad_trigger", "targetname");
  scripts\engine\utility::waittill_any_ents(var_0, "trigger", level, "left_kill_squad_lookat");
  scripts\engine\sp\utility::activate_trigger_with_targetname("left_kill_squad_spawn_trig");
  level thread scripts\sp\maps\piccadilly\piccadilly_civs.gsc::start_civ_struct_spawner("left_kill_squad_civ", 3);
}

reading_pl_stairs_guy_logic() {
  self getenemyinfo(level.player);
}

lotus_bomber_track() {
  self endon("detonated");
  level.player endon("death");

  for(;;) {
    if(level.player.origin[0] > -400) {
      break;
    }

    if(level.player.origin[1] < 0) {
      break;
    }

    waitframe();
  }

  scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_closest_bomber_target();
}

lotus_bomber_logic() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("spawn_lotus_bomber");
  var_0 = scripts\engine\sp\utility::spawn_targetname("lotus_bomber", 1);
  var_0.animname = "lotus_bomber";
  var_0 thread lotus_bomber_track();
  wait 0.5;

  if(!isalive(var_0)) {
    return;
  }
  var_1 = ["dx_vom_s151_sting_rear_bomber_20", "dx_vom_s152_sting_rear_bomber_30", "dx_vom_uk53_sting_rear_bomber_40", "dx_vom_uk54_sting_rear_bomber_50"];
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_1, 1, 0.5);
  var_0 waittill("detonated");
  wait 0.35;
  var_1 = ["dx_vom_s151_sting_rear_bomber_60", "dx_vom_s152_sting_rear_bomber_70", "dx_vom_uk53_sting_rear_bomber_80", "dx_vom_uk54_sting_rear_bomber_90"];
  var_2 = scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_1, 1, 0.65);
  wait 0.3;
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::wait_combat_cooldown(0.2, 0.65);
  level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_kyle_sting_rear_bomber_100", 1, 1);
  wait 0.2;
  var_3 = ["dx_vom_s151_sting_rear_bomber_110", "dx_vom_s152_sting_rear_bomber_120", "dx_vom_uk53_sting_rear_bomber_130", "dx_vom_uk54_sting_rear_bomber_140"];

  if(isalive(var_2)) {
    if(var_2 == level.sas[0])
      level.sas[0] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say(var_3[0]);
    else if(var_2 == level.sas[1])
      level.sas[1] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say(var_3[1]);
    else if(isDefined(var_2.vo_index))
      var_2 scripts\sp\maps\piccadilly\piccadilly_util.gsc::say(var_3[var_2.vo_index]);
  } else
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_on_closest_ally(var_3);
}

sting_window_guy() {
  self.favoriteenemy = level.player;
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_baseaccuracy(0.65);
  self.attackeraccuracy = 0.1;
  waitframe();
  var_0 = 0;

  for(;;) {
    if(!isalive(self)) {
      break;
    }

    if(distancesquared(self.origin, level.player.origin) <= 360000 && scripts\anim\utility_common.gsc::player_can_see_ai(level.player, self)) {
      var_0++;

      if(var_0 == 30) {
        break;
      }
    } else
      var_0 = 0;

    waitframe();
  }

  scripts\engine\utility::flag_set("sting_window_guys_displace");
  scripts\engine\utility::flag_set("sting_window_guy_dead");
}

sting_window_guys_retreat() {
  scripts\engine\utility::flag_wait("sting_window_guys_displace");
  var_0 = getEntArray("sting_window_guy", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(!isai(var_2)) {
      continue;
    }
    if(istrue(var_2.fixednode))
      var_2.fixednode = 0;

    var_2 setgoalvolumeauto(level.goalvolumes["leftside_crash_volume"]);
    var_2 scripts\common\ai::set_forcegoal();
    var_2 scripts\engine\utility::delaythread(2, scripts\common\ai::unset_forcegoal);
    var_2 scripts\engine\utility::delaythread(5, ::close_in_on_far_player);
  }
}

right_side_draw_civs() {
  level endon("left_side_cleanup");
  level endon("obj_update");
  var_0 = getspawner("right_corner_draw", "targetname");

  while(!scripts\engine\utility::flag("right_side_looking")) {
    var_1 = var_0 stalingradspawn();

    if(isalive(var_1)) {
      var_1.team = "allies";
      var_1 setthreatbiasgroup("civilians");
      wait(3 + randomint(3));
    }

    wait 0.1;
  }
}

center_enemy_spawnfunc() {
  self endon("death");

  if(!scripts\engine\utility::flag("spec_converge")) {
    self setgoalvolumeauto(getEnt("gap_street_front", "targetname"));
    scripts\engine\utility::flag_wait("spec_converge");
  }

  self setgoalvolumeauto(getEnt("goal_gap_defend", "targetname"));
}

bg_cars() {
  thread car_stream("start_car", "start_moveup_center");
  scripts\engine\sp\utility::flagwaitthread("start_moveup_center", ::car_stream, "car_stream_farside", "stop_far_cars");
  scripts\engine\sp\utility::flagwaitthread("player_did_sniping", ::car_stream, "player_sniper_far_stream", "inside_sting_first_floor");
  thread stop_far_cars();
}

stop_far_cars() {
  scripts\engine\utility::flag_wait_any("obj_update", "player_did_sniping", "music_transition", "player_upstairs_left", "sting_building_rescue_start");
  scripts\engine\utility::flag_set("stop_far_cars");
}

car_stream(var_0, var_1) {
  waitframe();

  if(scripts\engine\utility::flag_exist(var_1) && scripts\engine\utility::flag(var_1)) {
    return;
  }
  level endon(var_1);

  for(;;) {
    var_2 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
    var_3 = ["veh8_civ_lnd_secho", "veh8_civ_lnd_ralfa_rhd_wet_blue", "veh8_civ_lnd_victor40_police", "veh8_civ_lnd_walfa_black"];
    var_2 setModel(scripts\engine\utility::random(var_3));
    var_2 scripts\common\vehicle::vehicle_lights_on("headlights");
    var_2 scripts\common\vehicle::vehicle_lights_on("brakelights");
    wait(randomfloatrange(4, 7));
  }
}

car_drive_control(var_0) {
  self endon("death");
  wait 2;
  self.base_speed = 24 + randomint(2);
  self.lastnode = var_0;
  self.phys_contents = scripts\engine\trace::create_contents(0, 0, 0, 0, 0, 1, 0, 0, 0);

  for(;;) {
    if(is_clear_in_front())
      childthread drive_normal();
    else
      childthread drive_or_slow_for_collision();

    self waittill("done");
  }
}

drive_normal() {
  var_0 = randomfloatrange(0.8, 1.4);
  var_1 = self.base_speed * randomfloatrange(0.25, 1.15);
  var_2 = var_1 / var_0;
  self vehicle_setspeed(var_1, var_2 * 0.9, var_2 * 0.1);
  var_3 = gettime() + var_0 * 1000;

  while(gettime() < var_3) {
    if(!is_clear_in_front()) {
      break;
    }

    waitframe();
  }

  self notify("done");
}

drive_or_slow_for_collision() {
  var_0 = 2;
  var_1 = 0.25;
  var_2 = var_0 / var_1;
  self vehicle_setspeedimmediate(var_0, var_2 * 0.5, var_2 * 0.5);

  while(!is_clear_in_front())
    waitframe();

  self notify("done");
}

is_clear_in_front() {
  var_0 = self.origin + (0, 0, 20);
  var_1 = 450;

  if(distance2dsquared(self.origin, self.lastnode.origin) <= var_1 * var_1)
    return 1;

  var_2 = scripts\engine\trace::capsule_trace(var_0, var_0 + anglesToForward(self.angles) * var_1, 30, 60, (0, 0, 0), self, self.phys_contents);

  if(var_2["fraction"] != 1) {
    thread scripts\engine\trace::draw_trace(var_2, (1, 0, 0), 0, 1);
    return 0;
  } else
    return 1;
}

car_jumper() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = scripts\engine\sp\utility::spawn_targetname("car_jumper_ai", 1);
  var_0.animname = "car_jumper";
  var_0.ignoreme = 1;
  level.carjumper = var_0;
  var_0 scripts\anim\shared.gsc::forceuseweapon(scripts\sp\utility::make_weapon("iw8_ar_falpha", ["rec_falpha|1", "front_falpha|1", "mag_falpha|1", "toprail_falpha|1", "triggrip_falpha|1"]), "primary");
  var_1 = [];
  var_2 = getscriptablearray("car_jumper_car", "targetname")[0];
  var_2.animname = "car_jumper_car";
  var_3 = spawnStruct();
  var_3.angles = var_2.angles;
  var_3.origin = var_2.origin;
  var_4 = var_2 scripts\sp\maps\piccadilly\piccadilly_civs.gsc::spawn_civ("male", 1);
  var_4.animname = "car_jumper_victim_r";
  var_4 thread scripts\common\ai::magic_bullet_shield();
  var_4.noragdoll = 1;
  var_1[var_1.size] = var_4;
  var_2 thread scripts\common\anim::anim_loop_solo(var_4, "idle");
  var_5 = var_2 scripts\sp\maps\piccadilly\piccadilly_civs.gsc::spawn_civ("male", 1);
  var_5.ignoreme = 1;
  var_5 thread scripts\common\ai::magic_bullet_shield();
  var_5.animname = "car_jumper_victim_l";
  var_5.noragdoll = 1;
  var_1[var_1.size] = var_5;
  var_2 thread scripts\common\anim::anim_loop_solo(var_5, "idle");
  scripts\engine\utility::array_call(var_1, ::linkto, var_2, "tag_body_animate");
  var_2 thread car_jumper_car_delete_civs(var_4);
  var_0 thread jumper_dmg_detect();
  var_6 = var_0 car_jumper_logic(var_3, var_1, var_2);

  if(!isDefined(var_6)) {
    var_2 scriptable_clearanim();
    var_0 scripts\engine\utility::delaythread(1.6, scripts\anim\shared.gsc::dropallaiweapons);
    var_3 notify("stop_loop");
    var_3 scripts\common\anim::anim_single_solo(var_0, "car_jump_death");
    var_0.a.nodeath = 1;
    var_0 scripts\engine\sp\utility::set_allowdeath(1);
    var_0 scripts\engine\sp\utility::die();
  }

  scripts\engine\utility::flag_set("car_jumper_done");

  foreach(var_8 in var_1) {
    var_8.skipdeathanim = 1;
    var_8 scripts\common\ai::stop_magic_bullet_shield();
    var_8 scripts\engine\sp\utility::die();
  }
}

car_jumper_car_delete_civs(var_0) {
  level endon("spec_price_intro_start");
  self waittill("rocked");
  var_0 delete();
}

jumper_dmg_detect() {
  self endon("death");
  self endon("stop_jumper_dmg_detect");
  var_0 = 0;

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(scripts\engine\utility::is_equal(var_2, level.player))
      var_0 = 1;

    if(isexplosivedamagemod(self.damagemod))
      var_0 = 1;

    if(var_0)
      self notify("car_jump_interupt");
  }
}

car_jumper_logic(var_0, var_1, var_2) {
  self.car = var_2;
  var_0 thread scripts\common\anim::anim_loop_solo(self, "car_jump_idle");
  self.car thread scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::scriptable_anim(level.scr_anim["car_jumper_car"]["car_jump_loop_shoot"][0]);
  waitframe();
  self linkTo(var_2, "tag_body_animate");
  var_3 = 1;
  var_4 = scripts\engine\utility::waittill_any_ents_return(self, "car_jump_interupt", level, "combat_start");

  if(var_4 == "combat_start") {
    var_5 = 4;
    self endon("car_jump_interupt");
  } else {
    var_3 = 0;
    var_5 = 0.5;
  }

  var_0 notify("stop_loop");
  var_0 childthread scripts\common\anim::anim_loop_solo(self, "car_jump_loop_shoot");
  level scripts\engine\utility::delaythread(0.1, ::car_civs_die, var_0, var_1, var_2);
  car_jumper_shooting(var_5, var_1);
  var_0 notify("stop_loop");

  if(!var_3)
    return undefined;

  self.car thread scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::scriptable_anim(self.car scripts\engine\utility::getanim("car_jump_exit_back"));
  self notify("stop_jumper_dmg_detect");
  scripts\common\ai::magic_bullet_shield();
  var_0 scripts\common\anim::anim_single_solo(self, "car_jump_exit_back");
  scripts\common\ai::stop_magic_bullet_shield();
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.car scriptable_clearanim();
  self.goalradius = 1000;
  self unlink();
  self.ignoreme = 0;
  return 1;
}

car_civs_die(var_0, var_1, var_2) {
  if(level.start_point == "trailer_car_jumper") {
    return;
  }
  var_2 notify("stop_loop");
  var_2 scripts\common\anim::anim_single(var_1, "car_death");
}

car_jumper_shooting(var_0, var_1) {
  var_2 = gettime();
  var_3 = ["j_head", "j_neck", "j_helmet", "j_clavicle_le"];
  var_4 = level.start_point == "trailer_car_jumper";
  var_5 = level._effect["vfx_muz_ar_w_trailer"];

  while(gettime() < var_2 + var_0 * 1000) {
    playFX(var_5, self gettagorigin("tag_flash"), anglesToForward(self gettagangles("tag_flash")));
    scripts\anim\notetracks.gsc::notetrackfire();

    if(!var_4)
      playFXOnTag(scripts\engine\utility::getfx("vfx_imp_flesh_lrg"), var_1[randomint(var_1.size)], var_3[randomint(var_3.size)]);

    wait(0.05 + randomfloatrange(0.05, 0.15));
  }
}

left_side_street_runners() {
  level endon("going_right_side");
  level endon("inside_gap_flag");
  var_0 = getspawnerarray("left_sidestreet_civs");

  for(;;) {
    scripts\engine\utility::flag_wait("left_side_runner_go");

    while(scripts\engine\utility::flag("left_side_runner_go")) {
      foreach(var_2 in var_0) {
        if(!isDefined(var_2.count))
          var_2.count = 100;

        var_3 = scripts\engine\sp\utility::fakeactorspawn(var_2);
        var_3 thread fake_actor_think();
        wait 0.6;
      }

      wait 7;
    }
  }
}

sting_inside_enemy_accuracy() {
  level.player endon("death");
  scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::init_lights("exterior_bookstore");
  scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::lights_off("exterior_bookstore");

  for(;;) {
    scripts\engine\utility::flag_wait("in_reading_place");
    scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::lights_on("exterior_bookstore");
    scripts\engine\utility::array_thread(getaiarray("axis"), ::set_accuracy_at_dist, 0.01, 500);
    scripts\engine\sp\utility::add_global_spawn_function("axis", ::set_accuracy_at_dist, 0.01, 500);
    scripts\engine\utility::flag_waitopen("in_reading_place");
    scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::lights_off("exterior_bookstore");
    scripts\engine\sp\utility::remove_global_spawn_function("axis", ::set_accuracy_at_dist);
    scripts\engine\utility::array_thread(getaiarray("axis"), ::disable_accuracy_at_dist);
  }
}

set_accuracy_at_dist(var_0, var_1) {
  if(self.origin[0] < 1900) {
    return;
  }
  self endon("death");
  self endon("stop_accuracy_at_dist");
  var_2 = var_1 * var_1;
  self.og_baseaccuracy = self.baseaccuracy;

  for(;;) {
    while(distance2dsquared(self.origin, level.player.origin) <= var_2)
      wait 1;

    self.baseaccuracy = var_0;

    while(distance2dsquared(self.origin, level.player.origin) >= var_2)
      wait 1;

    self.baseaccuracy = self.og_baseaccuracy;
  }
}

disable_accuracy_at_dist() {
  self notify("stop_accuracy_at_dist");

  if(isDefined(self.og_baseaccuracy))
    self.baseaccuracy = self.og_baseaccuracy;
}

vo_combat_start() {
  scripts\engine\utility::flag_wait("ally_setup_done");
  thread stop_chatter_in_left_tunnel();
  var_0 = (-1795.57, -1984.46, 121);
  var_1 = (377.362, -1427.07, 106);
  var_2 = (-957.574, -2268.79, 136.486);
  var_3 = (-2101.51, -425.873, 286);
  var_4 = getEnt("car_jumper_ai", "targetname");

  if(!level.sas[0] iswaitingonsound() && !level.sas[1] iswaitingonsound() && !scripts\sp\maps\piccadilly\piccadilly_util.gsc::is_dead_or_dying(var_4))
    level.sas[0] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_s151_combat_ext_10", 1, 0.5);

  thread vo_allies_moving_up();
  wait 3;
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_combat_tube_10", var_0, ["tflag_left_underground", "going_right_side"]);
  var_5 = ["dx_vom_s151_combat_tube_20", "dx_vom_s152_combat_tube_30", "dx_vom_uk53_combat_tube_40", "dx_vom_uk54_combat_tube_50"];
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_say_on_closest_ally_to_chatter(var_5, var_0, ["tflag_left_underground", "going_right_side"]);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk52_sting_entrance_90", var_3, ["snipers_engaged", "gap_approach", "gap_nag_started", "going_right_side"]);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_sting_entrance_100", var_3, ["snipers_engaged", "gap_approach", "gap_nag_started", "going_right_side"]);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_sting_entrance_110", var_3, ["snipers_engaged", "gap_approach", "gap_nag_started", "going_right_side"]);
  var_5 = ["dx_vom_s151_sting_entrance_120", "dx_vom_s152_sting_entrance_130", "dx_vom_uk53_sting_entrance_140", "dx_vom_uk54_sting_entrance_150"];
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_say_on_closest_ally_to_chatter(var_5, var_3, ["sting_building_rescue_start", "gap_approach", "gap_nag_started", "going_right_side"]);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_sting_entrance_10", [var_2, var_3], ["going_right_side", "sting_building_rescue_start", "gap_nag_started"]);
  var_5 = ["dx_vom_s151_sting_entrance_20", "dx_vom_s152_sting_entrance_30", "dx_vom_uk53_sting_entrance_40", "dx_vom_uk54_sting_entrance_50"];
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_say_on_closest_ally_to_chatter(var_5, [var_2, var_3], ["going_right_side", "sting_building_rescue_start", "gap_nag_started"]);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk52_post_bomb_street_51", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_post_bomb_street_52", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_post_bomb_street_53", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk54_post_bomb_chatter_20", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_post_bomb_chatter_30", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk54_post_bomb_chatter_40", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_post_bomb_chatter_60", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk53_post_bomb_chatter_70", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_post_bomb_chatter_80", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk53_post_bomb_chatter_90", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk54_post_bomb_chatter_100", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_post_bomb_chatter_130", 400);
  var_6 = spawnStruct();
  level vo_go_left_right_nags(var_6);

  if(var_6.times_nagged > 0)
    level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_kyle_combat_fork_90", 1, 1);
}

stop_chatter_in_left_tunnel() {
  scripts\engine\utility::flag_wait("tflag_left_underground");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::pause_chatter();
  scripts\engine\utility::flag_wait_or_timeout("left_side_under_engaged", 8);
  wait 4;
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::resume_chatter();
}

vo_allies_moving_up() {
  wait 3;

  if(isalive(level.sas[0])) {
    level.sas[0] waittill("goal_changed");
    level.sas[0] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_s151_combat_ext_40", 1, 0.5);
    level.sas[1] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_s152_combat_ext_50", 1);
  }
}

vo_go_left_right_nags(var_0) {
  var_1 = ["dx_vom_s151_combat_fork_10", "dx_vom_s152_combat_fork_30", "dx_vom_uk53_combat_fork_50", "dx_vom_uk54_combat_fork_70"];
  var_2 = ["dx_vom_s151_combat_fork_20", "dx_vom_s152_combat_fork_40", "dx_vom_uk53_combat_fork_60", "dx_vom_uk54_combat_fork_80"];
  var_3 = scripts\engine\sp\utility::create_deck([var_1, var_2], 0);
  var_0.times_nagged = 0;
  var_4 = 6;
  var_5 = 1;
  level endon("left_starting_street");
  thread monitor_distance_from_starting_street();

  for(;;) {
    wait(randomfloatrange(var_4 - var_5, var_4 + var_5));
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_3 scripts\engine\sp\utility::deck_draw());
    var_0.times_nagged++;
    var_4 = min(var_4 * 2.25, 20);
    var_5 = min(var_5 * 2.5, 6);
  }
}

monitor_distance_from_starting_street() {
  var_0 = (-1412.33, -2577.08, 106.286);

  while(distance2dsquared(level.player.origin, var_0) < 360000)
    waitframe();

  level notify("left_starting_street");
}

combat_objectives() {
  if(scripts\engine\sp\objectives::objective_exists("piccadilly_objective")) {
    scripts\engine\sp\objectives::objective_remove_all_locations("piccadilly_objective");
    scripts\engine\sp\objectives::objective_update("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_NEUTRALIZE", "");
  } else
    scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_NEUTRALIZE", "");

  scripts\engine\utility::flag_wait_any("spec_converge", "obj_update");

  while(!should_show_obj())
    wait 1;

  var_0 = scripts\engine\utility::getStruct("spec_door_interact", "targetname");
  var_1 = scripts\engine\utility::getStruct("combat_obj", "targetname");
  var_1.origin = var_0.origin + (0, 0, 8);
  scripts\engine\sp\objectives::objective_update("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_TANTO", &"PICCADILLY/CURSOR_TANTO");
  scripts\engine\sp\objectives::objective_add_location_position("piccadilly_objective", "tanto", var_1.origin);
  thread gap_nag();
  thread display_obj_hint_if_needed();
}

display_obj_hint_if_needed() {
  level.player endon("death");
  level endon("spec_price_intro_start");
  level.player.focus.uses = 0;
  level.player childthread player_focus_counter();

  if(level.gameskill)
    scripts\engine\utility::flag_wait("gap_approach");

  if(level.player.focus.uses) {
    return;
  }
  scripts\engine\sp\utility::display_hint_forced("focus_hint", 4, 5);
  wait 45;
  var_0 = scripts\engine\utility::getStruct("combat_obj", "targetname");
  var_1 = cos(50);
  var_2 = distance(var_0.origin, level.player.origin);

  for(;;) {
    if(level.player.focus.uses >= 1) {
      return;
    }
    var_3 = distance2d(level.player.origin, var_0.origin);

    if(var_3 <= 500) {
      wait 1;
      continue;
    }

    var_4 = var_2 - var_3;

    if(var_4 < -200 || !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, var_1)) {
      while(!should_show_obj())
        wait 1;

      scripts\engine\sp\utility::display_hint_forced("focus_hint", 4, 7);
      level.player scripts\engine\utility::ent_flag_wait("global_hint_in_use");
      level.player scripts\engine\utility::ent_flag_waitopen("global_hint_in_use");

      if(!level.gameskill)
        wait 60;

      if(level.gameskill == 1)
        wait 120;

      if(level.gameskill > 1)
        wait 180;

      continue;
    }

    wait 2;
  }
}

should_show_obj() {
  if(isDefined(level.deathsdoor_sfx))
    return 0;

  if(level.player isfiring())
    return 0;

  if(istrue(level.player playerads()))
    return 0;

  return 1;
}

player_focus_counter() {
  for(;;) {
    self waittill("focus_pressed");
    self waittill("focus_released");
    self.focus.uses++;
  }
}

gap_nag() {
  level notify("gap_nag_started");
  level endon("spec_price_intro_start");

  if(!isDefined(level.vo_chatter))
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::init_chatter();

  level.vo_chatter endon("terminate_chatter");
  var_0 = spawnStruct();
  var_0.times_nagged = 1;
  var_0.min_wait = 8;
  var_0.max_wait = 12;
  var_0 wait_tanto_nag();
  level.player thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_kyle_sting_rear_exit_10");
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_gfc_sting_rear_exit_20");
  level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_kyle_sting_snipers_180");

  for(;;) {
    var_0 wait_tanto_nag();
    var_1 = ["dx_vom_s151_sting_snipers_140", "dx_vom_s152_sting_snipers_150", "dx_vom_uk53_sting_snipers_160", "dx_vom_uk54_sting_snipers_170"];
    level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_1);
    var_0 wait_tanto_nag();
    level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_gfc_sting_snipers_121");
    var_0 wait_tanto_nag();
    var_1 = ["dx_vom_s151_sting_snipers_190", "dx_vom_s152_sting_snipers_200", "dx_vom_uk53_sting_snipers_210", "dx_vom_uk54_sting_snipers_220"];
    level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_1);
    var_0 wait_tanto_nag();
    level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_gfc_sting_rear_tanto_70");
    var_0 wait_tanto_nag();
    level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_gfc_sting_rear_tanto_80");
    var_0 wait_tanto_nag();
    level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_gfc_sting_rear_tanto_90");
  }
}

wait_tanto_nag() {
  var_0 = (208.254, 234.34, 120);
  self.times_nagged++;
  self.min_wait = min(self.min_wait * 1.2, 30);
  self.max_wait = min(self.max_wait * 1.2, 40);
  wait(randomfloatrange(self.min_wait, self.max_wait));

  while(distance2dsquared(level.player.origin, var_0) < 891136)
    wait 0.3;
}

setup_allies() {
  scripts\engine\utility::flag_wait("ally_setup_done");
  var_0 = scripts\engine\sp\utility::get_spawner_array("sas_replace", "script_noteworthy");

  foreach(var_3, var_2 in level.sas) {
    var_2.ignoreall = 0;
    var_2.ignoreme = 0;
    var_2 thread replace_sas_with_police();
    var_2.colornode_func = scripts\sp\maps\piccadilly\piccadilly_util.gsc::colornode_arrived_func;
  }
}

replace_sas_with_police() {
  level endon("kill_color_replacements");
  self waittill("death");
  var_0 = undefined;
  var_0 = scripts\sp\colors::spawn_hidden_reinforcement("actor_ally_london_police_hivis", "y");
  var_0 scripts\engine\sp\utility::set_maxsightdistsquared(3610000);
  var_0.colornode_func = scripts\sp\maps\piccadilly\piccadilly_util.gsc::colornode_arrived_func;
  var_0 thread replace_sas_with_police();
}

allies_respawn() {
  level.respawn_friendlies_force_vision_check = 1;
  var_0 = getspawnerarray("police_redshirts");
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::add_spawn_function, scripts\engine\sp\utility::replace_on_death);
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::add_spawn_function, scripts\engine\sp\utility::set_maxsightdistsquared, 3610000);
  scripts\engine\utility::flag_wait("start_moveup_center");
  scripts\engine\sp\utility::activate_trigger_with_targetname("police_redshirts_trig");
}

spawn_start_enemies() {
  var_0 = getspawnerarray("enemies_start");
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::add_spawn_function, ::start_enemies_logic);
  thread vo_stairs_balcony_guy();
  var_0 = getspawnerarray("bus_spawners");
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::add_spawn_function, ::left_side_kill_squad_terry);
  scripts\engine\sp\utility::activate_trigger_with_targetname("trg_enemies_start");
}

start_enemies_logic() {
  self endon("death");
  self.attackeraccuracy = 0.25;
  self.disablepain = 1;
  wait 4;
  self.disablepain = 0;
}

vo_stairs_balcony_guy() {
  scripts\engine\sp\utility::trigger_wait_targetname("spawn_balcony_guy");
  wait 2.5;
  var_0 = getEnt("pf2_auto2416", "targetname");
  var_1 = ["dx_vom_s151_sting_snipers_10", "dx_vom_s152_sting_snipers_20", "dx_vom_uk53_sting_snipers_30", "dx_vom_uk54_sting_snipers_40"];
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_1, 1, 1);

  if(scripts\engine\utility::flag("gap_approach")) {
    return;
  }
  if(isalive(var_0))
    var_0 waittill("death");

  wait 0.45;

  if(level.player.origin[2] < 230)
    level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_kyle_sting_snipers_50", 1, 0.35);
}

check_player_attacker() {
  wait 3.5;
  var_0 = scripts\engine\sp\utility::get_ai_group_ai("casual_killers_start");
  var_1 = undefined;

  if(var_0.size) {
    foreach(var_3 in var_0) {
      if(scripts\engine\utility::is_equal(var_3.enemy, level.player)) {
        var_1 = var_3;
        break;
      }
    }

    if(!isDefined(var_1)) {
      var_5 = scripts\engine\sp\utility::get_closest_to_player_view(var_0, level.player, 1);
      var_5 thread enemy_favor_player();
      return;
    }
  }
}

enemy_favor_player() {
  self endon("death");
  self.ignoreme = 1;
  self clearenemy();
  self.favoriteenemy = level.player;
  self getenemyinfo(level.player);
  wait 2;
  self.ignoreme = 0;
}

rooftop_attackers() {
  level.player endon("death");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("rpg", ::rpg_ai);

  while(level.player.origin[1] < -1888)
    wait 0.5;

  var_0 = getspawner("rpg", "script_noteworthy");

  for(;;) {
    var_1 = var_0 scripts\engine\sp\utility::spawn_ai();

    if(!scripts\common\ai::spawn_failed(var_1)) {
      return;
    }
    wait 1;
  }
}

rpg_ai() {
  self endon("death");
  self.homepos = self.origin;
  self.goalradius = 50;
  self.health = 10;
  self.dontevershoot = 1;
  self.fixednode = 1;
  self.canmove = 1;
  self.dropweapon = 0;
  var_0 = getnode("rpg_guy_start", "script_noteworthy");
  thread scripts\sp\spawner::go_to_node(var_0, ::can_move_to_next_node);
  thread rpg_guy_scripted();
  scripts\engine\utility::flag_wait_any("right_to_ripleys", "center_guys_pull_up");
  self notify("player_attacked_me");
}

can_move_to_next_node(var_0) {
  self endon("death");

  while(!self.canmove)
    wait 0.25;
}

#using_animtree("generic_human");

rpg_guy_scripted() {
  thread rpg_guy_retreat();
  self endon("death");
  self endon("retreating");
  level endon("inside_gap_flag");
  self.used_destructible_targets = [];
  self.damage_functions[self.damage_functions.size] = ::rpg_guy_damage_func;
  self.deathfunction = ::rpg_guy_death_func;
  var_0 = spawn("script_origin", level.player.origin);
  self.ignoreme = 1;
  self setentitytarget(var_0);
  var_0 dontinterpolate();
  var_1 = 1;
  var_2 = 0;
  self.lastshoottime = gettime() - 3000;
  level.scr_anim["generic"]["rpg_reload"] = % sdr_com_exposed_stand_rpg_reload;
  wait 5;

  for(;;) {
    while(!rpg_guy_can_shoot())
      wait 0.5;

    self.canmove = 0;
    var_3 = undefined;
    var_4 = get_rpg_guy_target();

    if(isDefined(var_4) && !isalive(var_4)) {
      self.used_destructible_targets[self.used_destructible_targets.size] = var_4;
      var_3 = var_4.origin;
    } else if(scripts\engine\utility::is_equal(var_4, level.player))
      var_3 = var_4.origin;
    else
      var_3 = level.player.origin + anglesToForward(level.player.angles) * 800;

    var_5 = 0;

    if(!scripts\engine\utility::is_equal(var_4, level.player)) {
      foreach(var_7 in getaiarray("axis")) {
        if(var_7 scripts\engine\utility::doinglongdeath()) {
          continue;
        }
        var_8 = distancesquared(var_7.origin, var_3);

        if(var_8 <= 122500 || istrue(level.suicide_bombers_alive)) {
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        wait 1;

        if(isDefined(var_4))
          self.used_destructible_targets = scripts\engine\utility::array_remove(self.used_destructible_targets, var_4);

        continue;
      }
    }

    var_10 = vectortoangles(var_3 - self getEye());
    var_0.origin = self.origin + anglesToForward(var_10) * 500;
    var_11 = self.origin + (0, 0, 45) + anglesToForward(self.node.angles) * 35;
    wait 0.75;
    self.lastshoottime = gettime();
    var_12 = magicbullet("iw8_la_rpapa7_ai_picc", var_11, var_3);
    thread rpg_impact(var_12);
    var_13 = 2;
    wait(var_13 * 0.5);
    scripts\common\anim::anim_generic(self, "rpg_reload");
    self.canmove = 1;
    wait(var_13 * 0.5);

    if(scripts\engine\utility::is_equal(var_4, level.player)) {
      var_14 = ["dx_vom_s151_sting_rear_exit_70", "dx_vom_s152_sting_rear_exit_80", "dx_vom_uk53_sting_rear_exit_90", "dx_vom_uk54_sting_rear_exit_100"];
      thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_14, 1, 0.3);
    }

    if(var_1) {
      thread vo_rpg_guy();
      var_1 = 0;
    }

    wait 2;

    if(!var_2) {
      var_15 = waittill_player_sees_me_or_timeout(randomintrange(5, 8));
      var_2 = 1;
      continue;
    }

    wait(randomintrange(5, 8));
    var_2 = 0;
  }
}

rpg_guy_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\engine\utility::is_equal(var_1, level.player)) {
    if(self isinscriptedstate())
      scripts\engine\sp\utility::anim_stopanimScripted();

    self notify("player_attacked_me");
  }
}

rpg_guy_death_func() {
  scripts\common\ai::gun_remove();
  var_0 = vectorNormalize(level.player.origin - self.origin);
  self startragdollfromimpact("torso_upper", var_0 * 3000);
  return 1;
}

rpg_guy_retreat() {
  self endon("death");
  childthread notify_whizby_from_player();
  self waittill("player_attacked_me");
  self notify("retreating");
  self notify("stop_going_to_node");
  self.goalradius = 50;
  var_0 = getclosestpointonnavmesh(self.homepos);
  scripts\engine\sp\utility::set_goal_pos(var_0);
  wait 1;
  self waittill("goal");
  scripts\engine\sp\utility::die();
}

notify_whizby_from_player() {
  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(scripts\engine\utility::is_equal(var_0, level.player))
      self notify("player_attacked_me");
  }
}

waittill_player_sees_me_or_timeout(var_0) {
  self endon("death");
  self endon("timeout");
  thread scripts\engine\sp\utility::notify_delay("timeout", var_0);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.98))
      return 1;

    waitframe();
  }
}

rpg_impact(var_0) {
  var_0 waittill("explode", var_1);

  if(isDefined(var_1))
    thread scripts\engine\sp\utility::earthquake_and_rumble(var_1);
}

vo_rpg_guy() {
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk51_sting_rear_exit_30");
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk52_sting_rear_exit_40");
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk51_sting_rear_exit_50");
}

get_rpg_guy_target() {
  if(scripts\engine\utility::flag("player_in_center"))
    return level.player;

  var_0 = getscriptablearray();
  var_1 = [];
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(isDefined(var_4.model) && issubstr(var_4.model, "veh") && var_4.health > -250 && !var_4 scriptable_should_be_ignored())
      var_1[var_1.size] = var_4;
  }

  var_1 = sortbydistance(var_1, level.player.origin);
  var_6 = scripts\engine\utility::getStructArray("rpg_target", "targetname");
  var_7 = scripts\engine\utility::array_combine(var_1, var_6);
  var_7 = scripts\engine\utility::array_combine(var_7, getaiarray("allies"));
  var_8 = cos(40);

  if(var_7.size) {
    foreach(var_10 in var_7) {
      var_11 = distancesquared(var_10.origin, level.player.origin);

      if(!scripts\engine\utility::array_contains(self.used_destructible_targets, var_10) && var_11 <= squared(1500) && var_11 >= squared(500) && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_10.origin, var_8))
        return var_10;
    }
  }

  return undefined;
}

scriptable_should_be_ignored() {
  return scripts\engine\utility::is_equal(self.script_noteworthy, "ignore");
}

rpg_guy_can_shoot() {
  if(isDefined(self.currentpose) && self.currentpose != "stand")
    return 0;

  if(isDefined(self.pathgoalpos))
    return 0;

  if(!isDefined(self.node))
    return 0;

  if(level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::has_ceiling())
    return 0;

  return 1;
}

allies_same_color() {
  scripts\engine\utility::flag_wait("start_moveup_center");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0)
  var_2 scripts\engine\sp\utility::set_force_color("r");
}

left_side_kill_squad_terry() {
  self endon("death");
  self waittill("civ_killer_end");

  if(scripts\engine\utility::is_equal(self.lastattacker, level.player)) {
    return;
  }
  if(!scripts\anim\utility_common.gsc::player_can_see_ai(level.player, self)) {
    var_0 = getEnt("goal_gap_defend", "targetname");
    self setgoalvolumeauto(var_0);
  } else
    thread close_in_on_far_player();
}

left_crash_kill_squad_terry() {}

police_vignette() {
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(getdvarint("pic_intro") == 0) {
    return;
  }
  var_0 = [];
  var_1 = scripts\engine\utility::getStruct("police_scripted_node", "targetname");
  var_2 = scripts\sp\maps\piccadilly\piccadilly_util.gsc::picc_spawn_ai("bobby_dr", 0);
  var_2.animname = "police01";
  var_0[var_0.size] = var_2;
  var_2 = scripts\sp\maps\piccadilly\piccadilly_util.gsc::picc_spawn_ai("bobby_pass", 0);
  var_2.animname = "police02";
  var_0[var_0.size] = var_2;
  var_3 = getscriptablearray("police_arrive_scriptable_car", "targetname")[0];
  var_3 thread police_arrive_car_firstframe(var_1);
  var_1 thread scripts\common\anim::anim_single(var_0, "police_arrive");
  waitframe();
  var_3 police_car_set_animtime(0.1);
  var_3 police_car_set_animrate(0);

  foreach(var_5 in var_0) {
    var_5 setanimtime(level.scr_anim[var_5.animname]["police_arrive"], 0.1);
    var_5 setanimrate(level.scr_anim[var_5.animname]["police_arrive"], 0);
  }

  scripts\engine\utility::flag_wait("combat_start");
  var_3 police_car_set_animrate(1);

  foreach(var_5 in var_0)
  var_5 setanimrate(level.scr_anim[var_5.animname]["police_arrive"], 1);

  wait 3;
}

spec_converge() {
  scripts\engine\utility::flag_wait_any("obj_update", "spec_converge");
  thread police_corpse_manager();
  scripts\sp\spawner::killspawner(2);

  if(!scripts\engine\utility::flag("spec_converge"))
    scripts\engine\utility::flag_set("spec_converge");

  scripts\engine\sp\utility::autosave_by_name("spec_converge");
  thread center_guys_to_volume("goal_gap_defend");
  var_0 = getspawnerarray("obj_frontline");
  var_1 = [];
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(var_5 <= 2) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  var_6 = getspawner("tanto_doorway_flood", "targetname");
  var_1 = scripts\engine\utility::array_add(var_1, var_6);

  if(!scripts\sp\starts::is_after_start("lillywhites"))
    wait 10;

  thread scripts\sp\spawner::flood_spawner_scripted(var_1);
  scripts\engine\utility::flag_wait("gap_approach");
  var_0 = scripts\engine\utility::array_remove(var_0, var_6);

  if(isDefined(var_6))
    var_6 delete();

  thread scripts\sp\spawner::flood_spawner_scripted(var_2);
  scripts\engine\utility::flag_wait("final_bomber");
  scripts\engine\sp\utility::autosave_by_name("gap_bomber");
  scripts\engine\sp\utility::array_notify(var_0, "stop current floodspawner");
  level notify("kill_color_replacements");
}

tanto_doorway_flood_logic() {
  self waittill("death", var_0);

  if(scripts\engine\utility::is_equal(var_0, level.player)) {
    var_1 = getspawner("tanto_doorway_flood", "targetname");

    if(isDefined(var_1))
      var_1 delete();
  }
}

police_corpse_manager() {
  level endon("spec_price_intro_start");
  var_0 = (123, -292, 111.5);
  var_1 = (245.5, 252, 140);
  childthread delete_corpses_around_pos(var_0, 350);
  childthread delete_corpses_around_pos((-513, -1103, 145), 550, 70);
  childthread delete_corpses_around_pos(var_1, 150);
}

delete_corpses_around_pos(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_3 = 55;
  else
    var_3 = var_2;

  var_4 = cos(var_3);

  for(;;) {
    wait 5;

    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_0, var_4))
      wait 0.25;

    var_5 = getcorpsearrayinradius(var_0, var_1);

    if(var_5.size > 1)
      delete_corpses(var_5);
  }
}

delete_corpses(var_0) {
  var_1 = cos(65);
  var_2 = 360000;
  var_3 = 0;

  while(var_0.size) {
    foreach(var_5 in var_0) {
      if(isDefined(var_5) && distancesquared(var_5.origin, level.player.origin) > var_2) {
        var_5 delete();
        continue;
      }

      if(isDefined(var_5) && !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_5.origin, var_1)) {
        var_5 delete();
        var_3++;

        if(var_3 == 3) {
          var_3 = 0;
          wait 0.1;
          continue;
        }
      }

      var_0 = scripts\engine\utility::array_removeundefined(var_0);
    }

    waitframe();
  }
}

frontline_police_logic() {
  self endon("death");
  self.balwayscoverexposed = 1;
  self.goalradius = 50;
  self.maxsightdistsqrd = 3610000;
  self.targetname = "obj_frontline_ai";
  scripts\engine\utility::flag_wait("spawn_gap_bomber");
  self.dontevershoot = 1;
  wait(2 + randomfloat(1));
  self.dontevershoot = 0;
}

bus_animated_civs() {
  if(getdvarint("pic_intro") == 0) {
    return;
  }
  var_0 = [];
  var_1 = scripts\engine\utility::getStruct("bus_scripted_node", "targetname");

  for(var_2 = 1; var_2 < 6; var_2++) {
    var_3 = var_1 scripts\sp\maps\piccadilly\piccadilly_civs.gsc::spawn_civ("random");
    var_3.animname = "bus_death_civ0" + var_2;
    var_3.dontmelee = 1;
    var_3.team = "allies";
    var_3.ignoreme = 1;
    var_3 thread scripts\sp\maps\piccadilly\piccadilly_civs.gsc::ignoreme_til_player_sees();
    var_3 setthreatbiasgroup("civilians");
    var_3.attackeraccuracy = 10;

    if(var_2 == 5)
      var_3 thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::ragdoll_death_after_anim();

    var_0[var_0.size] = var_3;
  }

  scripts\engine\utility::array_thread(var_0, ::civ_think_vignette, var_1, "bus_death", "bus_exit_node");
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::crowd_screams(var_0[0].origin);
}

civ_think_vignette(var_0, var_1, var_2) {
  self endon("death");
  var_0 scripts\common\anim::anim_single_solo(self, var_1);

  if(!isai(self)) {
    var_3 = self.animname;
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::make_room_for_ai();
    var_4 = scripts\sp\maps\piccadilly\piccadilly_civs.gsc::spawner_makerealai(self);
    level.piccadilly.civilians = scripts\engine\utility::array_add(level.piccadilly.civilians, var_4);
    var_4.animname = var_3;
  } else
    var_4 = self;

  var_4 thread scripts\sp\maps\piccadilly\piccadilly_civs.gsc::civ_think_run(var_2);
}

fake_civ_stream(var_0, var_1, var_2, var_3) {
  level endon(var_1);

  if(scripts\engine\utility::flag_exist(var_1) && scripts\engine\utility::flag(var_1)) {
    return;
  }
  var_4 = getspawnerarray(var_0);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 2);

  for(;;) {
    foreach(var_6 in var_4) {
      if(!isDefined(var_6.count))
        var_6.count = 100;

      var_7 = scripts\engine\sp\utility::fakeactorspawn(var_6);
      var_7 thread fake_actor_think();

      if(istrue(var_3))
        var_7 thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::check_player_psycho();

      wait(randomfloatrange(0.2, 1));
    }

    wait(var_2);
  }
}

fake_actor_think(var_0) {
  self endon("death");
  self.ignoreme = 1;
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::acievement_monitor();
  self freeentitysentient();
  self waittill("reached_path_end");
  self delete();
}

bus_entered() {
  scripts\engine\utility::flag_wait("bus_window");
  var_0 = scripts\engine\utility::getStruct("bus_bullets", "targetname");
  scripts\engine\utility::delaythread(2, ::magicbullets_at_window, var_0, 0.6);
  scripts\engine\sp\utility::array_spawn_targetname("player_bus_enemies");
}

magicbullets_at_window(var_0, var_1) {
  var_2 = var_0;
  var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_4 = var_1;
  var_5 = var_3 scripts\engine\utility::spawn_script_origin();

  if(isDefined(var_3.target)) {
    var_6 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_5 moveTo(var_6.origin, var_4);
  }

  var_7 = gettime();

  while(gettime() - var_7 < var_4 * 1000) {
    magicbullet("iw8_ar_akilo47", var_2.origin, var_5.origin);
    wait(randomfloatrange(0.1, 0.2));
  }

  var_5 delete();
}

sniper_perch_setup() {
  level.snipers = [];
  var_0 = getspawnerarray("sniper_perch_guys");
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::add_spawn_function, ::sniper_logic);
  level waittill("snipers_engaged");
  scripts\engine\sp\utility::waittill_dead_or_dying(level.snipers);
  thread check_sting_is_clear();
}

sting_sniping() {
  self endon("death");
  createthreatbiasgroup("player");
  setthreatbias("axis", "player", -10000);
  setthreatbias("player", "axis", -10000);
  var_0 = 1;

  for(;;) {
    if(player_is_sniping("player_did_sniping")) {
      if(var_0) {
        var_0 = 0;
        thread vo_player_sniping();
        thread sniper_bus_rescue();
        thread sting_sniping_extras();
        waitframe();
      }

      foreach(var_2 in getaiarray("axis")) {
        if(scripts\engine\utility::is_equal(var_2.targetname, "rooftop") || var_2 isinscriptedstate() || scripts\engine\utility::is_equal(var_2.targetname, "sniper_perch_guys")) {
          continue;
        }
        var_2 setthreatbiasgroup("kill_civs");
      }

      thread player_sniping_threatbisas();

      while(player_is_sniping("player_did_sniping"))
        wait 1;

      foreach(var_2 in getaiarray("axis"))
      var_2 setthreatbiasgroup("axis");
    }

    wait 1;
  }
}

player_sniping_threatbisas() {
  level endon("player_did_sniping");

  for(;;) {
    level.player waittill("weapon_fired");
    var_0 = scripts\engine\utility::get_array_of_closest(level.player.origin, getaiarray("axis"), undefined, undefined, 1100);

    foreach(var_2 in var_0)
    var_2 setthreatbiasgroup("axis");
  }
}

vo_player_sniping() {
  level.player waittill("weapon_fired");
  level.player waittill("weapon_fired");
  wait(randomfloatrange(0.2, 0.8));

  if(!player_is_sniping("player_did_sniping")) {
    return;
  }
  var_0 = ["dx_vom_s151_sting_snipers_80", "dx_vom_s152_sting_snipers_90", "dx_vom_uk53_sting_snipers_100", "dx_vom_uk54_sting_snipers_110"];
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_sequence_as_chatter(["dx_vom_uk51_sting_snipers_70", [scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_on_closest_ally, [var_0]]], 0, 5);
}

sniper_bus_rescue() {
  level endon("sniper_bus_rescue_abort");
  level.player scripts\sp\utility::set_player_attacker_accuracy(0);
  var_0 = scripts\engine\utility::getStruct("sniping_bus_scene", "targetname");
  var_1 = ["civ1", "civ3", "civ4", "civ7", "civ8"];
  var_0.civs = [];
  var_2 = [];
  var_0.idle_guys = 0;

  foreach(var_4 in var_1) {
    var_5 = var_0 scripts\sp\maps\piccadilly\piccadilly_civs.gsc::spawn_civ("random", 1);
    var_5.animname = var_4;
    var_0 scripts\common\anim::anim_first_frame_solo(var_5, "bus_rescue_start");
    var_5 childthread scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::vignette_drone_give_soul();
    var_5 thread scripts\common\ai::magic_bullet_shield(1);
    var_0.civs[var_0.civs.size] = var_5;
    var_2[var_2.size] = var_5;
    waitframe();
    var_5 thread scripts\sp\utility::civilianfailwrapper();
  }

  while(getaiarray().size > 26)
    waitframe();

  var_7 = getstartorigin(var_0.origin, var_0.angles, %lon_pic_ctr_030_bus_sniper_terry2_enter);
  var_8 = scripts\engine\sp\utility::spawn_targetname("sniper_bus_scene_terry", 1);
  var_8.ignoreme = 1;
  var_8.ignoreall = 1;
  var_8.animname = "terry";
  var_0.terry = var_8;
  var_8 thread scripts\common\ai::magic_bullet_shield(1);
  var_0 scripts\common\anim::anim_first_frame_solo(var_8, "bus_rescue_start");
  var_8 childthread sniper_bus_terry_logic(var_0);
  var_2[var_2.size] = var_8;
  level thread sniper_recue_abort(var_2);
  level childthread vo_sniper_bus_scene(var_0);
  scripts\engine\utility::array_thread(var_0.civs, ::sniper_bus_civ_enter, var_0);
  var_9 = (-595, -485.8, 132.6);
  magicgrenade("frag", var_9 + (0, 0, 20), var_9, 0);

  while(var_0.idle_guys != 5)
    waitframe();

  waittill_player_aims_at_bus_scene(10);
  level notify("player_aimed_at_bus_scene");
  var_8 childthread bus_terry_killing_logic(var_0);
  scripts\engine\utility::array_thread(var_0.civs, ::sniper_bus_civ_outcome, var_0);
  var_0 scripts\engine\utility::waittill_any("bus_rescue_complete", "terry_shot");
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
}

sniper_recue_abort(var_0) {
  level endon("bus_rescue_complete");
  scripts\engine\utility::flag_waitopen("player_upstairs_left");
  level notify("sniper_bus_rescue_abort");
  scripts\engine\utility::array_delete(var_0);
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
}

sniper_bus_civ1_down(var_0) {
  self waittillmatch("single anim", "shot");
  magicbullet("iw8_ar_akilo47", var_0.terry gettagorigin("tag_flash"), self gettagorigin("j_chest"));
  thread scripts\sp\maps\piccadilly\piccadilly_anim.gsc::squib_chest(self);
}

sniper_bus_civ_enter(var_0) {
  self endon("death");

  if(self.animname == "civ1")
    thread sniper_bus_civ1_down(var_0);

  var_0 scripts\common\anim::anim_single_solo(self, "bus_rescue_start");
  var_0.idle_guys++;
  var_0 thread scripts\common\anim::anim_loop_solo(self, "bus_rescue_idle", "stop_idle_" + self getentitynumber());
}

sniper_bus_civ_outcome(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::ter_op(self.animname == "civ1", "bus_scene_kill_civ1", "bus_scene_kill_civs");
  scripts\engine\utility::waittill_any_ents(level, var_1, var_0, "terry_shot");

  if(!scripts\engine\utility::flag("bus_rescue_over"))
    scripts\engine\utility::flag_set("bus_rescue_over");

  if(self.animname != "civ1")
    var_0 notify("stop_idle_" + self getentitynumber());

  if(!isDefined(var_0.interupted)) {
    var_0 scripts\common\anim::anim_single_solo(self, "bus_rescue_death");

    if(!isai(self)) {
      scripts\common\ai::stop_magic_bullet_shield();
      self freeentitysentient();
      self startragdoll();
      self notsolid();
      self kill();
    }
  } else {
    if(self.animname != "civ1") {
      scripts\common\ai::stop_magic_bullet_shield();
      var_0 scripts\common\anim::anim_single_solo(self, "bus_rescued_enter");
      var_0 thread scripts\common\anim::anim_loop_solo(self, "bus_rescued_idle");
    } else {
      wait 5;
      var_0 notify("stop_idle_" + self getentitynumber());
      var_0 scripts\common\anim::anim_single_solo(self, "bus_rescue_death");
    }

    scripts\engine\utility::flag_waitopen("player_upstairs_left");
    self delete();
  }
}

bus_terry_killing_logic(var_0) {
  self endon("death");
  var_0 thread scripts\common\anim::anim_single_solo(self, "bus_rescue_start");
  scripts\engine\utility::flag_wait("bus_scene_kill_civ1");
  self shoot();
  wait 0.15;
  self shoot();
  scripts\engine\utility::flag_wait("bus_scene_kill_civs");
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk52_sting_civbus_130", 1, 1);
  var_1 = ["dx_vom_s151_sting_civbus_140", "dx_vom_s152_sting_civbus_150", "dx_vom_uk53_sting_civbus_160", "dx_vom_uk54_sting_civbus_170"];
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_1);
  thread sniper_bus_terry_bullets();
  self waittillmatch("single anim", "end");
  var_0 notify("bus_rescue_complete");
  scripts\common\ai::stop_magic_bullet_shield();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.goalradius = 2048;
  scripts\aitypes\cover::requestcoverfind(0, 0, undefined);
  scripts\engine\utility::flag_waitopen("player_upstairs_left");
  self delete();
}

waittill_player_aims_at_bus_scene(var_0) {
  self endon("death");
  var_1 = gettime();
  var_2 = var_1 + var_0 * 1000;

  while(gettime() < var_2) {
    if(player_is_aiming_at_bus_scene())
      return 1;

    wait 0.1;
  }
}

player_is_aiming_at_bus_scene() {
  var_0 = (-426.6, -678.2, 200);

  if(level.player playerads() < 1)
    return 0;

  if(!scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_0, 0.98))
    return 0;

  return 1;
}

player_using_sniper_rifle() {
  var_0 = level.player getcurrentweapon();

  if(isstring(var_0))
    var_1 = weaponclass(var_0);
  else
    var_1 = var_0.classname;

  return var_1 == "sniper";
}

nag_look_at_bus_scene() {
  level endon("player_aimed_at_bus_scene");
  level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk52_sting_civbus_10", 1, 2);
  level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk52_sting_civbus_20");
  var_0 = ["dx_vom_s151_sting_civbus_50", "dx_vom_s152_sting_civbus_70", "dx_vom_uk53_sting_civbus_90", "dx_vom_uk54_sting_civbus_110"];
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_0);
  var_0 = ["dx_vom_s151_sting_civbus_60", "dx_vom_s152_sting_civbus_80", "dx_vom_uk53_sting_civbus_100", "dx_vom_uk54_sting_civbus_120"];
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_0);
  level waittill("forever");
}

vo_sniper_bus_scene(var_0) {
  var_0 endon("terry_shot");
  var_0 endon("bus_rescue_complete");
  level endon("bus_scene_kill_civs");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::pause_chatter();
  var_0 thread scripts\engine\utility::thread_on_notify("bus_rescue_complete", scripts\sp\maps\piccadilly\piccadilly_util.gsc::resume_chatter);
  wait 1;
  nag_look_at_bus_scene();
  wait 2;
  level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk52_sting_civbus_30", 1);
}

sniper_bus_terry_logic(var_0) {
  var_0 endon("bus_rescue_complete");

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(isDefined(var_2)) {
      if(isPlayer(var_2) || isai(var_2)) {
        var_0.interupted = 1;
        var_0 notify("terry_shot");

        if(!scripts\engine\utility::flag("bus_scene_kill_civs")) {
          level scripts\engine\utility::delaythread(1, scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter, "dx_vom_uk52_sting_civbus_180", 1, 3);
          var_3 = ["dx_vom_s151_sting_civbus_190", "dx_vom_s152_sting_civbus_200", "dx_vom_uk53_sting_civbus_210", "dx_vom_uk54_sting_civbus_220"];
          level scripts\engine\utility::delaythread(1.1, scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally, var_3);
        }

        scripts\engine\sp\utility::anim_stopanimScripted();
        thread scripts\anim\shared.gsc::dropallaiweapons();
        scripts\common\ai::stop_magic_bullet_shield();
        self.a.nodeath = 0;
        self.allowdeath = 1;
        scripts\engine\sp\utility::die();
        return;
      }
    }
  }
}

sniper_bus_terry_bullets() {
  var_0 = 1;
  var_1 = gettime();

  while(gettime() < var_1 + var_0 * 1500) {
    scripts\anim\notetracks.gsc::notetrackfire();
    wait(randomfloatrange(0.05, 0.15));
  }
}

sting_upstairs_extras() {
  scripts\engine\sp\utility::array_spawn_function_targetname("upstairs_right_civ_ai_runners", ::upstairs_right_civ_ai_runners_logic);
  thread fake_civ_stream("sting_sniping_fake_civs", "inside_sting_first_floor", 5, 1);
  var_0 = getspawnerarray("upstairs_right_civ_ai_runners");
  thread scripts\sp\spawner::flood_spawner_scripted(var_0);
  level thread sting_upstairs_extras_cleanup();
}

sting_upstairs_extras_cleanup() {
  scripts\engine\utility::flag_wait("inside_sting_first_floor");
  var_0 = getspawnerarray("upstairs_right_civ_ai_runners");
  scripts\engine\utility::array_delete(var_0);
}

sting_sniping_extras() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("player_snipe_popo", 1);

  foreach(var_2 in var_0)
  var_2.fixednode = 0;

  var_4 = scripts\engine\sp\utility::array_spawn_targetname("player_snipe_terry", 1);
  level.sniping_specific_ai = scripts\engine\utility::array_combine(var_0, var_4);
  scripts\engine\utility::flag_wait("inside_sting_first_floor");
  level.sniping_specific_ai = scripts\engine\utility::array_removedead(level.sniping_specific_ai);
  scripts\engine\utility::array_call(level.sniping_specific_ai, ::delete);
}

upstairs_right_civ_ai_runners_logic() {
  self.ignoreme = 1;
  scripts\engine\utility::delaythread(3, scripts\engine\sp\utility::set_ignoreme, 0);
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_random_civilian_speed());
  self setthreatbiasgroup("civilians");
  self.attackeraccuracy = 1.3;
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::check_player_psycho();
}

middle_road_civ_runners() {
  level endon("spec_price_intro_start");
  var_0 = getspawnerarray("middle_road_runner");
  scripts\engine\sp\utility::array_spawn_function_targetname("middle_road_runner", ::middle_road_civ_runner);
  scripts\engine\sp\utility::array_spawn_function_targetname("middle_breadcrumb_guys", ::middle_breadcrumb_guy);
  var_1 = 1;

  for(;;) {
    scripts\engine\utility::flag_wait("middle_road");

    foreach(var_3 in var_0)
    var_3 stalingradspawn();

    wait(6 + randomint(3));
  }
}

middle_road_civ_runner() {
  self endon("death");
  self.team = "allies";
  self setthreatbiasgroup("civilians");
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_random_civilian_speed());
  childthread player_glance();

  if(randomint(100) < 41) {
    wait(randomfloatrange(5, 7));

    if(!scripts\engine\utility::flag("cancel_sting_rescue"))
      scripts\engine\utility::flag_set("cancel_sting_rescue");

    if(scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::can_fake_snipe())
      scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::snipe_me(1);
  }
}

player_glance() {
  for(;;) {
    if(distancesquared(self.origin, level.player.origin) <= 62500 && level.player scripts\engine\trace::can_see_origin(self getEye(), 0)) {
      self glanceatpos(level.player getEye(), 1000);
      return;
    }

    wait 1;
  }
}

middle_breadcrumb_guy() {
  self endon("death");

  if(self.team != "axis") {
    self.team = "allies";
    self.ignoreme = 1;
    scripts\engine\utility::delaythread(2, scripts\engine\sp\utility::set_ignoreme, 0);
    self setthreatbiasgroup("civilians");
    scripts\asm\asm_bb::bb_setcivilianstate("panic");
    scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_random_civilian_speed());
    self.attackeraccuracy = 10;
    self.dontmeleeme = 1;
  } else {
    self.grenadeammo = 0;
    self setthreatbiasgroup("kill_civs");
    thread kill_me_on_gap_approach();
    scripts\engine\utility::flag_wait_or_timeout("middle_breadcrumb_civs_dead", 7);
    self setthreatbiasgroup("axis");
  }
}

player_is_sniping(var_0) {
  if(!scripts\engine\utility::flag("snipers_dead"))
    return 0;

  if(scripts\engine\utility::flag("bus_rescue_over"))
    return 0;

  return scripts\engine\utility::flag(var_0);
}

sniper_logic() {
  thread check_dropped_weapon();
  self.sniper_target = scripts\engine\utility::spawn_tag_origin((-513, -1103, 145), (0, 0, 0));
  self.sniper_target dontinterpolate();
  thread sniper_shoot_logic();
  self.goalheight = 150;
  self.attackeraccuracy = 0;
  self setthreatbiasgroup("sniper");
  self.ignoresuppression = 1;
  level.snipers[level.snipers.size] = self;

  if(!scripts\engine\utility::is_equal(self.combatmode, "cover_lmg"))
    scripts\anim\shared.gsc::forceuseweapon(make_picc_sniper_weapon(), "primary");

  self.sniper_rifle_name = createheadicon(self.primaryweapon);
}

make_picc_sniper_weapon() {
  var_0 = ["snprscope_delta", "laserads_bar_bright", "mag_delta", "back_delta", "front_delta", "rec_delta"];
  return scripts\sp\utility::make_weapon("iw8_sn_delta", var_0);
}

sniper_whizby() {
  level endon("snipers_engaged");
  self endon("death");

  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(isDefined(var_0) && var_0 == level.player) {
      self notify("player_attacked_me");

      if(!scripts\engine\utility::flag("snipers_engaged"))
        scripts\engine\utility::flag_set("snipers_engaged");
    }
  }
}

sniper_shoot_logic() {
  level endon("snipers_engaged");
  self endon("death");
  self setentitytarget(self.sniper_target);
  self.og_baseaccuracy = self.baseaccuracy;
  self.forcesuppressai = 1;
  wait 1;
  var_0 = cos(40);

  for(;;) {
    var_1 = scripts\engine\sp\utility::get_ai_group_ai("sniper_fodder");
    var_2 = var_1;
    var_3 = undefined;

    foreach(var_5 in var_2) {
      if(self cansee(var_5)) {
        var_3 = var_5;
        break;
      }
    }

    self clearentitytarget();

    if(isDefined(var_3))
      sniper_shoot_target_internal(var_3);
    else if(!isDefined(var_3)) {
      self.favoriteenemy = undefined;

      if(scripts\engine\utility::flag("player_upstairs_left")) {
        self.sniper_target.origin = (-513, -1103, 145);
        self setentitytarget(self.sniper_target);
        self.lastenemysightpos = (-513, -1103, 145);
        scripts\engine\utility::flag_wait_or_timeout("player_in_center", 5);
        self clearentitytarget();
      } else {
        var_7 = scripts\engine\utility::array_removeundefined(level.injured_actors);
        var_8 = undefined;
        var_9 = undefined;
        var_10 = self gettagorigin("tag_flash");
        var_11 = self getapproxeyepos();

        foreach(var_13 in var_7) {
          var_9 = var_13 gettagorigin("j_spine4");

          if(istrue(var_13.script_index) && scripts\engine\utility::within_fov(self.origin, self.angles, var_9, var_0) && distance2dsquared(self.origin, var_13.origin) > 810000) {
            var_14 = var_11 + 128 * vectorNormalize(var_9 - var_11);

            if(sighttracepassed(var_11, var_14, 0, self)) {
              var_8 = var_13;
              break;
            }
          }
        }

        if(isDefined(var_8)) {
          var_16 = vectorNormalize(var_9 - var_10);
          var_17 = distance(var_10, var_9);
          self.sniper_target.origin = var_10 + var_16 * min(var_17 - 400, 500);
          waitframe();
          self setentitytarget(self.sniper_target);
          self.lastenemysightpos = var_8.origin;
          scripts\engine\utility::flag_wait_or_timeout("player_in_center", 5);
          self clearentitytarget();
        }
      }
    }

    if(scripts\engine\utility::flag("player_in_center")) {
      scripts\engine\utility::flag_set("cancel_sting_rescue");
      scripts\engine\sp\utility::set_favoriteenemy(level.player);
      self.neverforcesnipermissenemy = 1;
      scripts\engine\utility::flag_waitopen("player_in_center");
      self.neverforcesnipermissenemy = undefined;
    }

    waitframe();
  }
}

sniper_shoot_target_internal(var_0) {
  if(scripts\engine\utility::flag("player_in_center")) {
    return;
  }
  level endon("player_in_center");
  level endon("player_upstairs_left");
  scripts\engine\sp\utility::set_favoriteenemy(var_0);
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", 5);
}

wake_snipers() {
  var_0 = scripts\engine\utility::array_removedead(level.snipers);

  if(!var_0.size) {
    scripts\engine\utility::flag_set("snipers_engaged");
    return;
  }

  foreach(var_2 in var_0) {
    var_2 thread sniper_whizby();
    var_2.damage_functions[var_2.damage_functions.size] = ::sniper_damage_func;
    var_2.deathfunc = ::sniper_deathfunc;
    var_2 thread proximity_trig();
  }

  scripts\engine\utility::flag_wait("snipers_engaged");
  var_4 = 1;
  var_0 = scripts\engine\utility::array_removedead(var_0);

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      if(!isDefined(var_2.lastattacker)) {
        var_2 thread sniper_breakout_behavior(var_4);
        var_4 = 0;
        continue;
      }

      var_2 thread sniper_breakout_behavior(0);
    }
  }
}

sniper_breakout_behavior(var_0) {
  self endon("death");
  self clearentitytarget();
  self.fixednode = 0;
  self.attackeraccuracy = 10;
  self setthreatbiasgroup("axis");
  self clearenemy();
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  self getenemyinfo(level.player);

  if(self.weapon != self.sidearm)
    scripts\anim\shared.gsc::forceuseweapon(self.sidearm, "primary");

  self forcethreatupdate();
  self.newenemyreactiontime = gettime();

  if(!isDefined(self.lastattacker))
    self.forcenewenemyreaction = 1;

  self.goalheight = 32;

  while(isalive(self.enemy) && self.enemy != self.favoriteenemy)
    waitframe();

  if(!isalive(self.enemy)) {
    return;
  }
  if(var_0) {
    self.meleeignorefinalzdiff = 1;
    self.maxfaceenemydist = 512;
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::charge_enemy(10);
    self.goalradius = 1000;
  } else {
    waitframe();
    var_1 = self findbestcovernode(undefined, 1);

    if(isDefined(var_1)) {
      var_2 = self.keepclaimednodeifvalid;
      var_3 = self.keepclaimednode;
      self.keepclaimednodeifvalid = 0;
      self.keepclaimednode = 0;
      self usecovernode(var_1, 0);
      self.keepclaimednodeifvalid = var_2;
      self.keepclaimednode = var_3;
    }

    wait 4;
  }

  self.forcenewenemyreaction = undefined;
}

sniper_fodder() {
  scripts\engine\sp\utility::array_spawn_function_targetname("sniper_fodder", scripts\engine\sp\utility::set_attackeraccuracy, 3);
  scripts\engine\sp\utility::trigger_wait_targetname("sniper_spawn_trig");
  var_0 = getspawnerarray("sniper_fodder");
  thread scripts\sp\spawner::flood_spawner_scripted(var_0);
  scripts\engine\utility::flag_wait("snipers_engaged");
  scripts\engine\utility::array_delete(var_0);
  var_1 = [];

  foreach(var_3 in getaiarray("allies")) {
    if(scripts\engine\utility::is_equal(var_3.targetname, "sniper_fodder"))
      var_1[var_1.size] = var_3;
  }

  if(var_1.size) {
    if(level.player.origin[2] > 200)
      scripts\engine\utility::array_delete(var_1);
    else
      thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var_1, 400);
  }
}

proximity_trig() {
  self endon("player_attacked_me");
  self endon("death");
  self.trig = spawn("trigger_radius", self.origin, 0, 85, 60);
  thread scripts\engine\utility::delete_on_death(self.trig);
  var_0 = 1.6;

  for(;;) {
    self.trig waittill("trigger", var_1);

    if(scripts\engine\utility::is_equal(var_1, level.player)) {
      if(!scripts\engine\utility::flag("snipers_engaged"))
        scripts\engine\utility::flag_set("snipers_engaged");

      wait(var_0);
      self notify("player_attacked_me");
    }
  }
}

kill_me_on_gap_approach() {
  self endon("death");
  scripts\engine\utility::flag_wait("gap_approach");
  thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 500);
}

check_dropped_weapon() {
  self endon("entitydeleted");
  self waittill("death");
  var_0 = wait_for_dropped_weapon_or_timeout();
  var_1 = 0;

  if(isDefined(var_0) && !issubstr(var_0.classname, "_sn_"))
    var_1 = 1;

  if(!isDefined(var_0))
    var_1 = 1;

  if(var_1)
    var_2 = spawn("weapon_" + self.sniper_rifle_name, self.origin + (0, 0, 15), 0);
}

wait_for_dropped_weapon_or_timeout() {
  self endon("abort_wait_for_dropped_weapon");
  thread scripts\engine\sp\utility::notify_delay("abort_wait_for_dropped_weapon", 0.1);
  self waittill("weapon_dropped", var_0);
  return var_0;
}

sniper_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\engine\utility::is_equal(var_1, level.player)) {
    self notify("player_attacked_me");

    if(!scripts\engine\utility::flag("snipers_engaged"))
      scripts\engine\utility::flag_set("snipers_engaged");
  }
}

sniper_deathfunc() {
  if(scripts\engine\utility::is_equal(self.lastattacker, level.player)) {
    self notify("player_attacked_me");

    if(!scripts\engine\utility::flag("snipers_engaged"))
      scripts\engine\utility::flag_set("snipers_engaged");
  }

  return 0;
}

shoot_player_if_in_center() {
  for(;;) {
    scripts\engine\utility::flag_wait("player_in_center");
    level.player setthreatbiasgroup("player_focus");
    thread vo_player_in_center_nags();
    scripts\engine\utility::flag_waitopen("player_in_center");
    level.player setthreatbiasgroup("allies");
  }
}

vo_player_in_center_nags() {
  if(getaiarray("axis").size < 3) {
    return;
  }
  level endon("player_in_center");
  wait 1;

  for(;;) {
    var_0 = ["dx_vom_s151_shops_fountain_10", "dx_vom_s152_shops_fountain_20", "dx_vom_uk53_shops_fountain_30", "dx_vom_uk54_shops_fountain_40"];

    if(isDefined(level.vo_chatter) && isDefined(level.vo_chatter.last_center_nagged) && !scripts\engine\utility::time_has_passed(level.vo_chatter.last_center_nagged, 10))
      wait(10 - (gettime() - level.vo_chatter.last_center_nagged) / 1000);

    scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_on_closest_ally(var_0);

    if(isDefined(level.vo_chatter))
      level.vo_chatter.last_center_nagged = gettime();

    wait(randomfloatrange(15, 20));
  }
}

nag_get_downstairs(var_0) {
  if(!scripts\engine\utility::flag("player_upstairs_left")) {
    return;
  }
  level endon("player_upstairs_left");

  for(;;) {
    wait(randomfloatrange(8, 12));

    if(isDefined(level.vo_chatter) && level.vo_chatter.stopped) {
      continue;
    }
    if(var_0 scripts\engine\sp\utility::deck_is_empty())
      var_0 scripts\sp\maps\piccadilly\piccadilly_util.gsc::array_deck_shuffle();

    var_1 = var_0 scripts\engine\sp\utility::deck_draw();
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_as_chatter_on_closest_ally(var_1);
  }
}

second_floor_player_watcher() {
  level endon("top left sniping done");
  var_0 = ["dx_vom_s151_sting_exit_10", "dx_vom_s152_sting_exit_50", "dx_vom_uk53_sting_exit_90", "dx_vom_uk54_sting_exit_130"];
  var_1 = ["dx_vom_s151_sting_exit_20", "dx_vom_s152_sting_exit_60", "dx_vom_uk53_sting_exit_100", "dx_vom_uk54_sting_exit_140"];
  var_2 = ["dx_vom_s151_sting_exit_30", "dx_vom_s152_sting_exit_70", "dx_vom_uk53_sting_exit_110", "dx_vom_uk54_sting_exit_150"];
  var_3 = ["dx_vom_s151_sting_exit_40", "dx_vom_s152_sting_exit_80", "dx_vom_uk53_sting_exit_120", "dx_vom_uk54_sting_exit_160"];
  var_4 = [var_0, var_1, var_2, var_3];
  var_5 = scripts\engine\sp\utility::create_deck(var_4);

  for(;;) {
    scripts\engine\utility::flag_wait("player_upstairs_left");

    if(!scripts\engine\utility::flag("player_went_upstairs"))
      scripts\engine\utility::flag_set("player_went_upstairs");

    thread nag_get_downstairs(var_5);
    scripts\engine\utility::flag_waitopen("player_upstairs_left");

    if(!isDefined(level.lastsavetime) || gettime() - level.lastsavetime > 5000)
      scripts\engine\sp\utility::autosave_by_name("Downstairs");
  }
}

check_sting_is_clear() {
  scripts\engine\utility::flag_wait("player_upstairs_left");
  wait 1;
  var_0 = undefined;

  foreach(var_2 in getEntArray()) {
    if(isDefined(var_2.script_flag) && var_2.script_flag == "inside_sting_first_floor")
      var_0 = var_2;
  }

  var_4 = 0;

  while(var_4 < 0.8) {
    var_5 = 0;

    foreach(var_7 in getaiarray("axis")) {
      if(var_7 istouching(var_0)) {
        var_4 = -0.5;
        break;
      }
    }

    var_4 = var_4 + 0.5;
    waitframe();
  }

  scripts\sp\maps\piccadilly\piccadilly_util.gsc::wait_combat_cooldown(0.8, 2);
  level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_kyle_sting_snipers_60", 1, 3);
}

retreat_to_gap_sniping() {
  level endon("gap_bomber_dead");
  scripts\engine\utility::flag_wait("player_did_sniping");
  scripts\engine\utility::flag_wait("bus_rescue_over");
  var_0 = gettime();
  var_1 = level.player.stats["kills"];

  while(scripts\engine\utility::flag("player_did_sniping")) {
    if(gettime() - var_0 > 7000) {
      break;
    }

    wait 0.5;
  }

  level notify("top left sniping done");
  scripts\engine\sp\utility::activate_trigger_with_noteworthy("enemies_to_upstairs");
  scripts\engine\utility::flag_set("spec_converge");
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
  scripts\engine\utility::flag_waitopen("player_did_sniping");
  scripts\sp\spawner::killspawner(21);
}

center_guys_to_volume(var_0, var_1) {
  var_2 = scripts\engine\sp\utility::get_ai_group_ai("center_defend");
  var_3 = scripts\engine\sp\utility::get_ai_group_ai("center_reinforce");
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  var_4 = getEnt(var_0, "targetname");

  foreach(var_6 in var_2)
  var_6 setgoalvolumeauto(var_4);

  if(istrue(var_1))
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var_2, 600);
}

top_left_sight_checker() {
  scripts\engine\utility::flag_wait("top_left_sight_check");
  scripts\engine\sp\utility::activate_trigger_with_noteworthy("top_left_flood");
}

sniper_backup_spawners() {
  scripts\engine\utility::flag_wait("player_upstairs_left");
  var_0 = scripts\engine\sp\utility::get_ai_group_death_count("center_defend") + scripts\engine\sp\utility::get_ai_group_death_count("center_reinforce");
  var_0 = var_0 * 0.75;
  var_0 = int(var_0);
  var_1 = getspawnerarray("sniper_backup_guys");
  var_2 = getEnt("center_left_fallback_vol", "targetname");
  var_3 = var_1.size;

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_3--;

    if(var_3 < 0)
      var_3 = var_1.size - 1;

    var_5 = var_1[var_3] stalingradspawn();
    waitframe();
    var_5 setgoalvolumeauto(var_2);
  }
}

left_side_cleanup() {
  level endon("right_side_cleanup");
  scripts\engine\utility::flag_wait("left_side_cleanup");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_targetname("right_to_ripleys_trig");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_targetname("subway_right_wave1_trig");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_targetname("right_bomber_1_trig");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_targetname("gap_bombers");
}

right_side_combat() {
  level endon("spec_price_intro_start");
  scripts\engine\utility::flag_wait("right_side_looking");
  var_0 = getspawnerarray("subway_right_wave1");
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::spawn_ai, 1);
  var_1 = (317.5, -1614.5, 98.75);
  magicgrenademanual("frag", var_1 + (0, 0, 10), var_1, 0);
  var_2 = (21.75, -1754.25, 133.4);
  var_3 = (-513, -1103, 145);
  scripts\engine\utility::delaythread(0.6, ::magicbullet_burst, var_2, var_3);
  scripts\engine\utility::delaythread(1, ::magicbullet_burst, var_2, var_3);
  scripts\engine\sp\utility::waittill_ai_group_dead("subway_right");
  scripts\engine\utility::flag_wait("right_side_looking");

  if(level.player.origin[0] > -1100) {
    var_4 = getspawner("right_side_bomber", "targetname");

    if(distance2d(level.player.origin, var_4.origin) > 500) {
      var_5 = 0;

      while(var_5 < 3) {
        var_6 = scripts\engine\sp\utility::spawn_targetname("right_side_bomber", 1);

        if(scripts\common\ai::spawn_failed(var_6)) {
          var_5++;
          scripts\sp\maps\piccadilly\piccadilly_util.gsc::make_room_for_ai();
          waitframe();
          continue;
        }

        var_6 thread right_side_bomber_track();
        level thread vo_right_bomber_reaction(var_6);
        scripts\engine\sp\utility::waittill_dead_or_dying([var_6]);
        break;
      }
    }
  }

  scripts\engine\utility::flag_wait("right_side_looking");
  var_7 = scripts\engine\sp\utility::array_spawn_targetname("subway_right_wave2");

  if(isDefined(var_7)) {
    scripts\engine\utility::array_thread(var_7, ::subway_right_wave2_logic);
    scripts\engine\sp\utility::waittill_dead_or_dying(var_7);
  }

  if(scripts\engine\utility::flag("right_side_looking"))
    thread cops_lead_to_underground_right();
}

subway_right_wave2_logic() {
  self endon("death");
  var_0 = 0;

  while(istrue(self.using_goto_node)) {
    if(distance2dsquared(self.origin, level.player.origin) <= 250000)
      var_0 = 1;

    if(scripts\engine\utility::is_equal(self.lastattacker, level.player))
      var_0 = 1;

    if(var_0) {
      break;
    }

    wait 0.2;
  }

  if(!istrue(self.using_goto_node)) {
    return;
  }
  if(var_0) {
    self notify("stop_going_to_node");
    self cleargoalvolume();

    if(scripts\engine\utility::is_equal(self.enemy, level.player))
      scripts\sp\maps\piccadilly\piccadilly_util.gsc::charge_enemy(4);
    else {
      self setgoalpos(self.origin);
      self.goalradius = 500;
    }
  }
}

close_in_on_far_player() {
  self endon("death");
  wait 1;

  while(isalive(level.player) && distance2dsquared(self.origin, level.player.origin) < 810000)
    wait 2;

  self.goalradius = 800;
  self cleargoalvolume();

  for(;;) {
    if(self.goalradius > 350)
      self.goalradius = self.goalradius - 50;

    self setgoalpos(level.player.origin);
    wait(6 + randomint(3));
  }
}

right_side_bomber_track() {
  self endon("detonated");
  level.player endon("death");

  while(isalive(self)) {
    if(level.player.origin[0] < -1800) {
      break;
    }

    if(level.player.origin[1] > -412) {
      break;
    }

    waitframe();
  }

  scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_closest_bomber_target();
}

vo_right_bomber_reaction(var_0) {
  wait 1;

  if(!isDefined(var_0)) {
    return;
  }
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk51_sting_entrance_70", 1, 0.5);
  var_0 waittill("detonated");
  wait 0.5;
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk51_sting_entrance_80", 1, 0.5);
}

cops_lead_to_underground_right() {
  if(level.player.origin[0] < -10000 || level.player.origin[1] < -8400) {
    return;
  }
  var_0 = [];
  var_1 = spawn_cop_from_behind_player();

  if(isDefined(var_1)) {
    var_1.target = "underground_right_leader";
    var_1.goalradius = 32;
    var_1 thread scripts\sp\spawner::go_to_node();
    var_0[var_0.size] = var_1;
    waitframe();
  }

  var_2 = spawn_cop_from_behind_player();

  if(isDefined(var_2)) {
    var_2.target = "police_leader2";
    var_2.goalradius = 32;
    var_2 thread scripts\sp\spawner::go_to_node();
    var_0[var_0.size] = var_2;
  }

  wait 15;
  var_0 = scripts\engine\utility::array_removedead(var_0);

  if(var_0.size)
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var_0, 500);
}

spawn_cop_from_behind_player(var_0) {
  var_1 = getspawnerarray("obj_frontline");
  var_2 = undefined;
  var_3 = 0;
  var_4 = undefined;

  for(;;) {
    foreach(var_6 in var_1) {
      if(!level.player scripts\engine\trace::can_see_origin(var_6.origin, 0)) {
        var_2 = var_6;
        break;
      }
    }

    if(!isDefined(var_2)) {
      wait 0.5;
      continue;
    }

    var_4 = level.player.origin + anglesToForward(level.player.angles) * -60;
    var_3 = scripts\engine\trace::capsule_trace_passed(level.player.origin, var_4, 20, 60, level.player.angles, level.player);

    if(var_3) {
      break;
    } else {
      wait 0.5;
      continue;
    }

    waitframe();
  }

  var_8 = var_2 stalingradspawn();

  if(!scripts\common\ai::spawn_failed(var_8)) {
    var_8.targetname = "";
    var_8 scripts\engine\sp\utility::disable_ai_color();
    var_8 forceteleport(var_4, level.player.angles);
    return var_8;
  } else
    return undefined;
}

do_death_sound() {
  self waittill("death");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::death_vo();
}

right_subway_bg_fake_civs() {
  scripts\engine\utility::flag_wait("start_right_corner_civs");
  wait 3;
  var_0 = getspawnerarray("right_subway_civs");

  for(var_1 = 0; var_1 < 2; var_1++) {
    foreach(var_3 in var_0) {
      var_4 = scripts\engine\sp\utility::fakeactorspawn(var_3);
      var_4 thread fake_actor_think();
      wait(randomfloatrange(0.2, 0.35));
    }

    wait(randomfloatrange(0.5, 0.65));
  }
}

fake_actor_think_kill(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    self.ignoreme = 1;
    self freeentitysentient();
  }

  self waittill("reached_path_end");
  thread shot_in_back();
}

fake_actor_random_death() {
  self endon("death");
  wait(randomfloatrange(2.25, 5));
  thread shot_in_back();
}

right_underground_bomber_runner_logic() {
  self endon("death");
  self.dontchatter = 1;
  wait 0.2;

  if(self.target == "pf2_auto2604") {
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_cvm1_post_bomb_civ_bombers_20");
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_cvm1_post_bomb_civ_bombers_10");
  } else if(self.target == "pf2_auto2605") {
    wait 0.65;
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_cvm2_post_bomb_civ_bombers_30");
  }
}

delete_center_guys() {
  scripts\engine\utility::flag_wait("going_up_right");
  var_0 = getaiarray("axis");
  var_1 = getEnt("goal_center_left", "targetname");

  foreach(var_3 in var_0) {
    if(var_3 istouching(var_1))
      var_3 kill();
  }
}

gap_right_combat() {
  scripts\engine\utility::flag_wait("final_bomber");
  waittill_player_look_bomber();
  var_0 = getspawner("gap_bomber", "targetname");

  for(;;) {
    if(getaiarray().size > 25)
      scripts\sp\maps\piccadilly\piccadilly_util.gsc::make_room_for_ai();

    var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);

    if(isalive(var_1)) {
      var_1 thread gap_bomber_logic();
      level.gap_bomber = var_1;
      scripts\engine\utility::flag_set("spawn_gap_bomber");
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("spawn_gap_bomber");
  wait 1;
  level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_uk52_sting_rear_tanto_20", 1);
}

waittill_player_look_bomber() {
  level.player endon("death");
  var_0 = 435600;

  while(distance2dsquared(level.player.origin, (170.5, 133.5, 174.75)) >= var_0)
    wait 0.25;

  var_1 = cos(45);
  var_2 = 0;
  var_3 = 20;

  for(;;) {
    if(distance2dsquared(level.player.origin, (170.5, 133.5, 174.75)) < 90000) {
      return;
    }
    if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), (170.5, 133.5, 174.75), var_1)) {
      var_2++;

      if(var_2 == var_3)
        return;
    } else
      var_2 = 0;

    waitframe();
  }
}

gap_bomber_logic() {
  self.ignoreme = 1;
  thread scripts\common\ai::magic_bullet_shield(1);
  self.dmg_from_player = 0;
  level.suicide_bomber_explode_func = ::stop_bulletshield_wrapper;
  self.damage_functions[self.damage_functions.size] = ::gap_bomber_dmg;
  scripts\engine\utility::delaythread(3, scripts\engine\sp\utility::set_ignoreme, 0);
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::set_attackeraccuracy, 0);
  var_0 = scripts\engine\utility::array_remove(getaiarray("axis"), self);

  if(var_0.size) {
    var_1 = sortbydistance(var_0, self.origin)[0];

    if(distance2d(var_1.origin, self.origin) < 70 && isalive(var_1) && !scripts\anim\utility_common.gsc::player_can_see_ai(level.player, var_1)) {
      if(isDefined(var_1.magic_bullet_shield))
        var_1 scripts\common\ai::stop_magic_bullet_shield();

      var_1 scripts\sp\utility::do_damage(var_1.health + 10, var_1 getEye());
    }
  }

  gap_bomber_internal();
  scripts\engine\utility::flag_set("gap_bomber_dead");
  scripts\engine\utility::delaythread(3, scripts\engine\utility::exploder, "police_cars_fx");
  var_2 = scripts\engine\sp\utility::get_ai_group_ai("left_snipers");

  if(var_2.size) {
    foreach(var_4 in var_2) {
      if(scripts\engine\utility::is_equal(var_4.combatmode, "cover_lmg"))
        var_4 scripts\engine\sp\utility::die();
    }
  }

  wait 2.5;
  scripts\engine\sp\utility::activate_trigger_with_targetname("gap_stackup");
}

gap_bomber_internal() {
  var_0 = gap_bomber_detoantes();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getscriptablearray("obj_frontline_cover", "targetname");
  var_1 = sortbydistance(var_1, var_0);

  foreach(var_4, var_3 in var_1) {
    if(var_4 == 0) {
      var_3 setscriptablepartstate("body", "dead");
      waitframe();
      var_3 setscriptablepartstate("Anim_Explosion", "rock", 1);
      continue;
    }

    wait 0.1;
    var_3 setscriptablepartstate("Window_Blast", "destroyed");
    var_3 setscriptablepartstate("body", "flareup");
  }

  var_5 = getaiarray();

  foreach(var_7 in var_5) {
    if(isalive(var_7) && distance2d(var_7.origin, var_0) < 300)
      var_7 scripts\sp\utility::do_damage(1000, var_7.origin, undefined, undefined, "MOD_EXPLOSIVE");
  }
}

gap_bomber_detoantes() {
  var_0 = undefined;
  var_1 = [];

  while(!isDefined(var_0)) {
    var_2 = getaiarray("allies");

    foreach(var_4 in var_2) {
      if(var_4 istouching(level.goalvolumes["gap_street_front"]))
        var_1[var_1.size] = var_4;
    }

    if(!isalive(self)) {
      break;
    }

    if(var_1.size)
      var_0 = sortbydistance(var_1, self.origin)[0];

    waitframe();
  }

  if(isalive(self) && !istrue(self.hasexploded)) {
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::bomber_set_target(var_0);
    self waittill("detonated");
  }

  if(isDefined(self.origin))
    return self.origin;
}

cops_die(var_0) {
  wait 0.2;

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(isalive(var_2))
        var_2 scripts\engine\sp\utility::die();
    }
  }
}

stop_bulletshield_wrapper(var_0) {
  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();
}

gap_bomber_dmg(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(istrue(self.hasexploded)) {
    return;
  }
  if(isDefined(var_4) && isexplosivedamagemod(var_4)) {
    return;
  }
  if(scripts\engine\utility::is_equal(var_1, level.player)) {
    if(isDefined(var_0)) {
      self.dmg_from_player = self.dmg_from_player + var_0;

      if(self.dmg_from_player >= 400) {
        scripts\common\ai::stop_magic_bullet_shield();

        if(isalive(self))
          scripts\engine\sp\utility::die();
      }
    }
  }
}

right_side_cleanup() {
  level endon("left_side_cleanup");
  scripts\engine\utility::flag_wait("right_side_cleanup");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_targetname("left_rear_flag");

  foreach(var_1 in getEntArray("trigger_multiple_unlock", "classname")) {
    if(scripts\engine\utility::is_equal(var_1.script_noteworthy, "left_store_guy_trig_unlock")) {
      var_1 delete();
      break;
    }
  }

  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_targetname("store_guy_trig");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_targetname("sniper_spawn_trig");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_noteworthy("left_main_trig");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_noteworthy("top_left_flood");
}

flag_waitopen_either(var_0, var_1) {
  for(;;) {
    if(!scripts\engine\utility::flag(var_0)) {
      return;
    }
    if(!scripts\engine\utility::flag(var_1)) {
      return;
    }
    level scripts\engine\utility::waittill_either(var_0, var_1);
  }
}

shot_in_back(var_0, var_1) {
  self endon("death");
  var_2 = self.origin + (0, 0, 40) + anglesToForward(self.angles) * -300;
  var_3 = self.origin + (0, 0, 40) + anglesToForward(self.angles) * 300;
  thread magicbullet_burst(var_2, var_3, var_0, var_1);

  if(isDefined(var_0))
    wait(randomfloatrange(var_0 + 0.25, var_1 + 0.25));
  else
    wait 0.35;

  if(isalive(self))
    self kill();
}

magicbullet_burst(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2))
    wait(randomfloatrange(var_2, var_3));

  var_4 = randomintrange(6, 9);
  var_5 = "iw8_ar_akilo47";

  for(var_6 = 0; var_6 < var_4; var_6++) {
    wait(randomfloatrange(0.05, 0.15));
    var_7 = scripts\sp\player\bullet_feedback::get_whizby_fx_from_weapon(var_5);
    var_1 = var_1 + scripts\engine\utility::randomvector(5);
    magicbullet(var_5, var_0, var_1);
    var_8 = vectortoangles(var_1 - var_0);
    playFX(level._effect[var_7], var_1, anglesToForward(var_8));
  }
}

#using_animtree("scriptables");

police_arrive_car_firstframe(var_0) {
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::use_scriptables_animtree();
  var_1 = getstartorigin(var_0.origin, var_0.angles, %lon_pic_020_cops_arrive_veh01);
  var_2 = getstartangles(var_0.origin, var_0.angles, %lon_pic_020_cops_arrive_veh01);
  self.origin = var_1;
  self.angles = var_2;
}

police_car_set_animrate(var_0) {
  self setflaggedanimknoball("single anim", %lon_pic_020_cops_arrive_veh01, %root, 1, 0, var_0);
}

police_car_set_animtime(var_0) {
  self setflaggedanimknoball("single anim", %lon_pic_020_cops_arrive_veh01, %root, 1, 0, 10);

  while(self getanimtime(%lon_pic_020_cops_arrive_veh01) < var_0)
    waitframe();

  self setflaggedanimknoball("single anim", %lon_pic_020_cops_arrive_veh01, %root, 1, 0, 1);
}

scriptable_clearanim(var_0) {
  if(isDefined(var_0))
    self clearanim(var_0, 0);
  else
    self clearanim(%root, 0);
}