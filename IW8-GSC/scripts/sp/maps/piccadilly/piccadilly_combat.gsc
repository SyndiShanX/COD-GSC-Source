/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\piccadilly\piccadilly_combat.gsc
************************************************************/

function start() {
  scripts\engine\utility::flag_set("combat_start");
  thread police_vignette();
  scripts\engine\utility::flag_wait("ally_setup_done");
  thread car_jumper();
  scripts\engine\sp\utility::set_start_location("combat_sas", scripts\engine\utility::array_add(level.sas, level.player));
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk51_post_bomb_street_10", 100);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk52_post_bomb_street_20", 100);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_gfc_post_bomb_street_30", 200);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk51_post_bomb_street_90", 300);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_gfc_post_bomb_street_100", 400);
}

function start_lillywhites() {
  setDvar("pic_intro", 0);
  scripts\engine\utility::flag_wait("ally_setup_done");
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_spawn_trig");
  scripts\engine\sp\utility::set_start_location("lillywhites_start", scripts\sp\maps\piccadilly\piccadilly_util::get_all_good_guys());
}

function start_sting() {
  setDvar("pic_intro", 0);
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\engine\utility::flag_wait("ally_setup_done");
  scripts\engine\sp\utility::set_start_location("sting_start", scripts\sp\maps\piccadilly\piccadilly_util::get_all_good_guys());
  scripts\engine\sp\utility::activate_trigger_with_targetname("sting_upstairs_hero_color");
  scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_spawn_trig");
}

function start_sting_rear() {
  setDvar("pic_intro", 0);
  scripts\engine\utility::flag_wait("ally_setup_done");
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\engine\sp\utility::set_start_location("string_rear_start", scripts\sp\maps\piccadilly\piccadilly_util::get_all_good_guys());
  scripts\engine\sp\utility::activate_trigger_with_targetname("sting_upstairs_hero_color");
  scripts\sp\spawner::killspawner(2);
  scripts\engine\sp\utility::activate_trigger_with_noteworthy("left_crash_trig_unlock");
}

function start_right_underground() {
  setDvar("pic_intro", 0);
  scripts\engine\utility::flag_set("stop_far_cars");
  scripts\engine\utility::flag_wait("ally_setup_done");
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\engine\sp\utility::set_start_location("right_underground_start", scripts\sp\maps\piccadilly\piccadilly_util::get_all_good_guys());
  scripts\sp\spawner::killspawner(2);
  scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_spawn_trig");
}

function catchup() {
  setsaveddvar("TSSONTORK", 0);
  scripts\engine\utility::exploder("spec");
  scripts\engine\utility::flag_set("combat_start");
  level.player.participation += 200;
}

function main() {
  setsaveddvar("TSSONTORK", 0);
  scripts\engine\utility::flag_wait("init_done");
  scripts\engine\sp\utility::array_spawn_function_targetname("middle_lotus_enemies", &lotus_decho_audio);
  scripts\engine\sp\utility::array_spawn_function_targetname("obj_frontline", &frontline_police_logic);
  scripts\engine\sp\utility::array_spawn_function_targetname("tanto_doorway_flood", &tanto_doorway_flood_logic);
  var0 = getspawner("left_underground_attacker", "script_noteworthy");
  var0 scripts\engine\sp\utility::add_spawn_function(&left_underground_attacker_awareness);
  scripts\sp\maps\piccadilly\piccadilly_util::spawn_sas_redshirts();
  setup_allies();
  scripts\engine\sp\utility::array_spawn_function_noteworthy("sting_window_guy", &sting_window_guy);
  thread scripts\engine\sp\utility::set_flag_on_targetname_trigger("gap_approach");
  scripts\engine\utility::flag_init("center_fallback");
  scripts\engine\sp\utility::flagwaitthread("sniper_player_going_up", &wake_snipers);
  scripts\engine\sp\utility::flagwaitthread("in_reading_place", &scripts\engine\utility::flag_set, "player_entered_reading_place");
  thread combat_objectives();
  thread rooftop_attackers();
  thread spawn_start_enemies();
  thread allies_respawn();
  level.combat_start = gettime();
  thread sniper_perch_setup();
  thread second_floor_player_watcher();
  thread retreat_to_gap_sniping();
  thread kill_locations_achievement_check();
  thread top_left_sight_checker();
  thread bus_entered();
  thread sting_sniping();
  thread left_side_street_runners();
  thread sting_inside_enemy_accuracy();
  thread sting_window_guys_retreat();
  thread right_corner_civs();
  thread right_side_combat();
  thread delete_center_guys();
  thread gap_right_combat();
  thread right_side_cleanup();
  thread spec_converge();
  thread middle_road_civ_runners();
  thread left_side_kill_squad();
  thread conditional_enemies();
  thread shoot_player_if_in_center();

  if(!scripts\sp\starts::is_after_start("combat")) {
    thread friendly_fire_combat_start();
    level thread scripts\sp\maps\piccadilly\piccadilly_civs::start_civ_struct_spawner("right_start");
    level scripts\engine\utility::delaythread(0.1, &scripts\sp\maps\piccadilly\piccadilly_civs::start_civ_struct_spawner, "combat_right");
    level scripts\engine\utility::delaythread(0.15, &scripts\sp\maps\piccadilly\piccadilly_civs::start_civ_struct_spawner, "combat_left", 3);
    level scripts\engine\utility::delaythread(0.25, &bus_animated_civs);
  }

  thread fake_civ_stream("back_store_fake_civs", "stop_storefront_drones");
  thread fake_civ_stream("close_fake_civs", "start_moveup_center");
  thread bg_cars();
  thread sniper_fodder();
  thread reading_place_friendlies_enter();
  thread lotus_bomber_logic();
  scripts\engine\sp\utility::flagwaitthread("player_did_sniping", &sting_upstairs_extras);
  scripts\engine\sp\utility::flagwaitthread("lilly_door_lookat", &lilly_entrance_draw);
  scripts\engine\sp\utility::flagwaitthread("going_right_side", &right_side_draw_civs);
  scripts\engine\utility::exploder("spec");
  scripts\engine\sp\utility::autosave_by_name("combat_start");
  level.player scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::set_ignoreme, 0);
  level.ctbuddy scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::set_ignoreme, 0);

  if(!scripts\sp\starts::is_after_start("lillywhites")) {
    thread vo_combat_start();
  }

  var1 = getEntArray("goalie_trig", "script_noteworthy");
  scripts\engine\utility::array_thread(var1, &no_rushin);
  thread scripts\sp\maps\piccadilly\piccadilly_gap::price_intro_debris_and_interact();
  scripts\engine\sp\utility::array_spawn_function_noteworthy("center_reinforce", &center_enemy_spawnfunc);
  var0 = getspawner("reading_pl_stairs_guy", "script_noteworthy");
  var0 scripts\engine\sp\utility::add_spawn_function(&reading_pl_stairs_guy_logic);
  scripts\engine\utility::delaythread(5, &spawn_snipers_early);
  scripts\engine\utility::flag_wait_all("inside_gap_flag", "gap_bomber_dead", "spec_price_intro_start");
  scripts\sp\maps\piccadilly\piccadilly_util::terminate_chatter();
}

function left_underground_attacker_awareness() {
  self endon("death");

  for(;;) {
    var0 = getaiarray("allies");

    foreach(var2 in var0) {
      var2 getenemyinfo(self);

      if(isDefined(var2.weapon) && !nullweapon(var2.weapon)) {
        self getenemyinfo(var2);
      }
    }

    wait 3;
  }
}

function kill_locations_achievement_check() {
  var0 = ["player_underground_right", "player_underground_left", "in_reading_place", "player_in_aural_chic"];

  while(var0.size) {
    var1 = level.player.stats["kills"];

    while(var1 == level.player.stats["kills"]) {
      waitframe();
    }

    foreach(var3 in var0) {
      if(scripts\engine\utility::flag(var3)) {
        var0 = scripts\engine\utility::array_remove(var0, var3);
        break;
      }
    }
  }

  scripts\sp\utility::giveachievement_wrapper("smokeout");
}

function lotus_decho_audio() {
  if(scripts\common\vehicle::isvehicle()) {
    self vehicle_turnengineoff();
    self playSound("scn_piccadilly_hummer_terry_drivein");
    wait 3;
    self playSound("scn_piccadilly_hummer_terry_doors");
    return;
  }
}

function friendly_fire_combat_start() {
  var0 = level.friendlyfire["civilians_killed"];
  var1 = level.friendlyfire["friend_kill_points"];
  level.friendlyfire["friend_kill_points"] = int(var1 * 0.33);
  wait 11;
  level.friendlyfire["civilians_killed"] = var0;
  level.friendlyfire["friend_kill_points"] = var1;
}

function spawn_snipers_early() {
  if(scripts\sp\starts::is_after_start("combat")) {
    return;
  }

  var0 = getEnt("goal_start", "targetname");

  while(var0 scripts\engine\sp\utility::get_ai_touching_volume("axis").size > 2) {
    wait 0.5;
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_spawn_trig");
}

function reading_place_friendlies_enter() {
  var0 = getEnt("reading_place_friendlies_enter", "targetname");
  var0 scripts\engine\utility::trigger_off();
  scripts\engine\utility::flag_wait_any("sting_window_guy_dead", "sting_window_guys_displace", "sniper_player_going_up");
  var0 scripts\engine\utility::trigger_on();
}

function no_rushin() {
  if(scripts\sp\starts::is_after_start("combat")) {
    return;
  }

  level endon("spec_price_intro_start");
  var0 = 20;

  for(;;) {
    self waittill("trigger");
    var1 = 0;
    var2 = gettime() - level.combat_start;
    var3 = istrue(level.player.stats["shots_hit"]);
    var4 = level.player.stats["shots_fired"] == 0;

    if(var2 < var0 * 1000) {
      var1 = 1;
    } else if(var4 || !var3) {
      var1 = 1;
    }

    if(var1) {
      break;
    }
  }

  if(istrue(level.spawned_goalie)) {
    return;
  }

  level.spawned_goalie = 1;
  var5 = getspawnerarray(self.target);

  if(var5.size > 1) {
    foreach(var7 in var5) {
      if(!level.player scripts\engine\trace::can_see_origin(var7.origin, 0)) {
        var7 scripts\engine\sp\utility::spawn_ai(1);
        return;
      }
    }

    return;
  }

  var9 = var5[0] scripts\engine\sp\utility::spawn_ai(1);
}

function conditional_enemies() {
  level endon("spec_price_intro_start");
  var0 = 0;
  var1 = 0;

  for(;;) {
    if(scripts\engine\utility::flag("extra_lotus_guys_check") && scripts\engine\utility::flag("player_entered_reading_place") && !var0) {
      var0 = 1;
      scripts\engine\sp\utility::activate_trigger_with_targetname("lotus_middle_enemy_trigger");
    }

    if(scripts\engine\utility::flag("reading_place_front") && !var1) {
      if(scripts\engine\utility::flag("spawn_sting_rescue") || scripts\engine\utility::flag("player_entered_reading_place")) {
        waitframe();
        continue;
      }

      var1 = 1;
      thread middle_reading_place_front_door_enemies();
    }

    if(var0 && var1) {
      return;
    }

    wait 0.5;
  }
}

function middle_reading_place_front_door_enemies() {
  if(!scripts\engine\utility::flag("cancel_sting_rescue")) {
    scripts\engine\utility::flag_set("cancel_sting_rescue");
  }

  var0 = getspawnerarray("reading_front_guys");

  foreach(var2 in var0) {
    for(;;) {
      if(getaiarray().size > 25) {
        scripts\sp\maps\piccadilly\piccadilly_util::make_room_for_ai();
      }

      var3 = var2 scripts\engine\sp\utility::spawn_ai(1);

      if(isalive(var3)) {
        var3 scripts\engine\utility::delaythread(20, &close_in_on_far_player);
        var3 scripts\engine\utility::set_movement_speed(200);
        break;
      }

      waitframe();
    }
  }
}

function right_corner_civs() {
  scripts\engine\utility::flag_wait("right_side_looking");

  if(level.player.origin[0] > -270) {
    var0 = scripts\engine\sp\utility::get_ai_group_ai("subway_right");

    if(var0.size) {
      scripts\engine\sp\utility::array_notify(var0, "stop_killing_civs");
    }

    return;
  }

  thread right_subway_bg_fake_civs();
  var1 = getspawnerarray("right_corner_civs");
  var2 = scripts\engine\sp\utility::get_average_origin(var1);
  var3 = distance(level.player.origin, var2);
  var4 = vectortoangles(var2 - level.player.origin);
  var5 = level.player.origin + anglesToForward(var4) * var3 * 0.5;
  thread scripts\sp\maps\piccadilly\piccadilly_util::crowd_screams(var5);
  var6 = [];

  for(var7 = 0; var7 < 6; var7++) {
    foreach(var9 in var1) {
      var10 = var9 scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random");
      var10.team = "allies";
      var10 setthreatbiasgroup("civilians");
      var10.attackeraccuracy = 5;
      var10.health = 50;
      var6 = var10;
      var10 thread scripts\sp\maps\piccadilly\piccadilly_civs::civ_struct_ai_go(var9.target);
      var10.ignoreme = 1;
      thread do_death_sound();
      var10 scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::set_ignoreme, 0);
      wait 0.05;
      LOC_0000013e:
    }

    wait randomfloatrange(0.5, 0.65);
  }
}

function right_side_kill_squad_flags() {
  scripts\engine\utility::flag_wait_any("right_side_looking", "left_side_cleanup", "in_reading_place");

  if(!scripts\engine\utility::flag("right_side_looking")) {
    scripts\engine\utility::flag_set("right_side_looking");
    return;
  }
}

function right_kill_squad_logic() {
  self endon("death");
  thread scripts\sp\maps\piccadilly\piccadilly_util::kill_civs_til_player_sees_me();
  self.damage_functions[self.damage_functions.size] = &right_kill_squad_dmg_func;
  thread scripts\common\ai::magic_bullet_shield(1);
  self.attackeraccuracy = 0;
  var0 = scripts\engine\utility::flag_wait_any_return("right_side_looking", "spec_price_intro_start");

  if(var0 != "right_side_looking") {
    if(istrue(self.magic_bullet_shield)) {
      scripts\common\ai::stop_magic_bullet_shield();
    }

    self delete();
  }

  if(istrue(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

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

function right_kill_squad_dmg_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(scripts\engine\utility::is_equal(var1, level.player)) {
    if(istrue(self.magic_bullet_shield)) {
      scripts\common\ai::stop_magic_bullet_shield();
    }

    if(!scripts\engine\utility::flag("right_side_looking")) {
      scripts\engine\utility::flag_set("right_side_looking");
      return;
    }

    return;
  }
}

function lilly_entrance_draw() {
  var0 = getspawner("lilly_door_draw", "targetname") stalingradspawn();
  waitframe();

  if(isalive(var0)) {
    wait 1.3;

    if(!isalive(var0)) {
      return;
    }

    scripts\sp\maps\piccadilly\piccadilly_anim::squib_head(var0);
    var0 scripts\sp\utility::do_damage(200, var0 getEye(), undefined, undefined, "MOD_RIFLE_BULLET");
    return;
  }
}

function left_side_kill_squad() {
  var0 = getEnt("left_kill_squad_trigger", "targetname");
  scripts\engine\utility::waittill_any_ents(var0, "trigger", level, "left_kill_squad_lookat");
  scripts\engine\sp\utility::activate_trigger_with_targetname("left_kill_squad_spawn_trig");
  level thread scripts\sp\maps\piccadilly\piccadilly_civs::start_civ_struct_spawner("left_kill_squad_civ", 3);
}

function reading_pl_stairs_guy_logic() {
  self getenemyinfo(level.player);
}

function lotus_bomber_track() {
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

  scripts\sp\maps\piccadilly\piccadilly_util::get_closest_bomber_target();
}

function lotus_bomber_logic() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("spawn_lotus_bomber");
  var0 = scripts\engine\sp\utility::spawn_targetname("lotus_bomber", 1);
  var0.animname = "lotus_bomber";
  thread lotus_bomber_track();
  wait 0.5;

  if(!isalive(var0)) {
    return;
  }

  var1 = ["dx_vom_s151_sting_rear_bomber_20", "dx_vom_s152_sting_rear_bomber_30", "dx_vom_uk53_sting_rear_bomber_40", "dx_vom_uk54_sting_rear_bomber_50"];
  thread scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var1, 1, 0.5);
  var0 waittill("detonated");
  wait 0.35;
  var1 = ["dx_vom_s151_sting_rear_bomber_60", "dx_vom_s152_sting_rear_bomber_70", "dx_vom_uk53_sting_rear_bomber_80", "dx_vom_uk54_sting_rear_bomber_90"];
  var2 = scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var1, 1, 0.65);
  wait 0.3;
  scripts\sp\maps\piccadilly\piccadilly_util::wait_combat_cooldown(0.2, 0.65);
  level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_sting_rear_bomber_100", 1, 1);
  wait 0.2;
  var3 = ["dx_vom_s151_sting_rear_bomber_110", "dx_vom_s152_sting_rear_bomber_120", "dx_vom_uk53_sting_rear_bomber_130", "dx_vom_uk54_sting_rear_bomber_140"];

  if(isalive(var2)) {
    if(var2 == level.sas[0]) {
      level.sas[0] scripts\sp\maps\piccadilly\piccadilly_util::say(var3[0]);
      return;
    }

    if(var2 == level.sas[1]) {
      level.sas[1] scripts\sp\maps\piccadilly\piccadilly_util::say(var3[1]);
      return;
    }

    if(isDefined(var2.vo_index)) {
      var2 scripts\sp\maps\piccadilly\piccadilly_util::say(var3[var2.vo_index]);
      return;
    }

    return;
  }

  scripts\sp\maps\piccadilly\piccadilly_util::say_line_on_closest_ally(var3);
}

function sting_window_guy() {
  self.favoriteenemy = level.player;
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_baseaccuracy(0.65);
  self.attackeraccuracy = 0.1;
  waitframe();
  var0 = 0;

  for(;;) {
    if(!isalive(self)) {
      break;
    }

    if(distancesquared(self.origin, level.player.origin) <= 360000 && scripts\anim\utility_common::player_can_see_ai(level.player, self)) {
      var0++;

      if(var0 == 30) {
        break;
      }
    } else {
      var0 = 0;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("sting_window_guys_displace");
  scripts\engine\utility::flag_set("sting_window_guy_dead");
}

function sting_window_guys_retreat() {
  scripts\engine\utility::flag_wait("sting_window_guys_displace");
  var0 = getEntArray("sting_window_guy", "script_noteworthy");

  foreach(var2 in var0) {
    if(!isai(var2)) {
      continue;
    }

    if(istrue(var2.fixednode)) {
      var2.fixednode = 0;
    }

    var2 setgoalvolumeauto(level.goalvolumes["leftside_crash_volume"]);
    var2 scripts\common\ai::set_forcegoal();
    var2 scripts\engine\utility::delaythread(2, &scripts\common\ai::unset_forcegoal);
    var2 scripts\engine\utility::delaythread(5, &close_in_on_far_player);
  }
}

function right_side_draw_civs() {
  level endon("left_side_cleanup");
  level endon("obj_update");
  var0 = getspawner("right_corner_draw", "targetname");

  while(!scripts\engine\utility::flag("right_side_looking")) {
    var1 = var0 stalingradspawn();

    if(isalive(var1)) {
      var1.team = "allies";
      var1 setthreatbiasgroup("civilians");
      wait 3 + randomint(3);
    }

    wait 0.1;
  }
}

function center_enemy_spawnfunc() {
  self endon("death");

  if(!scripts\engine\utility::flag("spec_converge")) {
    self setgoalvolumeauto(getEnt("gap_street_front", "targetname"));
    scripts\engine\utility::flag_wait("spec_converge");
  }

  self setgoalvolumeauto(getEnt("goal_gap_defend", "targetname"));
}

function bg_cars() {
  thread car_stream("start_car", "start_moveup_center");
  scripts\engine\sp\utility::flagwaitthread("start_moveup_center", &car_stream, "car_stream_farside", "stop_far_cars");
  scripts\engine\sp\utility::flagwaitthread("player_did_sniping", &car_stream, "player_sniper_far_stream", "inside_sting_first_floor");
  thread stop_far_cars();
}

function stop_far_cars() {
  scripts\engine\utility::flag_wait_any("obj_update", "player_did_sniping", "music_transition", "player_upstairs_left", "sting_building_rescue_start");
  scripts\engine\utility::flag_set("stop_far_cars");
}

function car_stream(var0, var1) {
  waitframe();

  if(scripts\engine\utility::flag_exist(var1) && scripts\engine\utility::flag(var1)) {
    return;
  }

  level endon(var1);

  for(;;) {
    var2 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var0);
    var3 = ["veh8_civ_lnd_secho", "veh8_civ_lnd_ralfa_rhd_wet_blue", "veh8_civ_lnd_victor40_police", "veh8_civ_lnd_walfa_black"];
    var2 setModel(scripts\engine\utility::random(var3));
    var2 scripts\common\vehicle::vehicle_lights_on("headlights");
    var2 scripts\common\vehicle::vehicle_lights_on("brakelights");
    wait randomfloatrange(4, 7);
  }
}

function car_drive_control(var0) {
  self endon("death");
  wait 2;
  self.base_speed = 24 + randomint(2);
  self.lastnode = var0;
  self.phys_contents = scripts\engine\trace::create_contents(0, 0, 0, 0, 0, 1, 0, 0, 0);

  if(is_clear_in_front()) {
    GscBinSkip4(0x35);
  }

  GscBinSkip4(0x35);
}

function drive_normal() {
  var0 = randomfloatrange(0.8, 1.4);
  var1 = self.base_speed * randomfloatrange(0.25, 1.15);
  var2 = var1 / var0;
  self vehicle_setspeed(var1, var2 * 0.9, var2 * 0.1);
  var3 = gettime() + var0 * 1000;

  while(gettime() < var3) {
    if(!is_clear_in_front()) {
      break;
    }

    waitframe();
  }

  self notify("done");
}

function drive_or_slow_for_collision() {
  var0 = 2;
  var1 = 0.25;
  var2 = var0 / var1;
  self vehicle_setspeedimmediate(var0, var2 * 0.5, var2 * 0.5);

  while(!is_clear_in_front()) {
    waitframe();
  }

  self notify("done");
}

function is_clear_in_front() {
  var0 = self.origin + (0, 0, 20);
  var1 = 450;

  if(distance2dsquared(self.origin, self.lastnode.origin) <= var1 * var1) {
    return 1;
  }

  var2 = scripts\engine\trace::capsule_trace(var0, var0 + anglesToForward(self.angles) * var1, 30, 60, (0, 0, 0), self, self.phys_contents);

  if(var2["fraction"] != 1) {
    thread scripts\engine\trace::draw_trace(var2, (1, 0, 0), 0, 1);
    return 0;
  }

  return 1;
}

function car_jumper() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = scripts\engine\sp\utility::spawn_targetname("car_jumper_ai", 1);
  var0.animname = "car_jumper";
  var0.ignoreme = 1;
  level.carjumper = var0;
  var0 scripts\anim\shared::forceuseweapon(scripts\sp\utility::make_weapon("iw8_ar_falpha", ["rec_falpha|1", "front_falpha|1", "mag_falpha|1", "toprail_falpha|1", "triggrip_falpha|1"]), "primary");
  var1 = [];
  var2 = getscriptablearray("car_jumper_car", "targetname")[0];
  var2.animname = "car_jumper_car";
  var3 = spawnStruct();
  var3.angles = var2.angles;
  var3.origin = var2.origin;
  var4 = var2 scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("male", 1);
  var4.animname = "car_jumper_victim_r";
  var4 thread scripts\common\ai::magic_bullet_shield();
  var4.noragdoll = 1;
  var1 = var4;
  var2 thread scripts\common\anim::anim_loop_solo(var4, "idle");
  var5 = var2 scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("male", 1);
  var5.ignoreme = 1;
  var5 thread scripts\common\ai::magic_bullet_shield();
  var5.animname = "car_jumper_victim_l";
  var5.noragdoll = 1;
  var1 = var5;
  var2 thread scripts\common\anim::anim_loop_solo(var5, "idle");
  scripts\engine\utility::array_call(var1, &linkto, var2, "tag_body_animate");
  thread car_jumper_car_delete_civs(var2);
  thread jumper_dmg_detect();
  var6 = car_jumper_logic(var0, var3, var1, var2);

  if(!isDefined(var6)) {
    scriptable_clearanim(var2);
    var0 scripts\engine\utility::delaythread(1.6, &scripts\anim\shared::dropallaiweapons);
    var3 notify("stop_loop");
    var3 scripts\common\anim::anim_single_solo(var0, "car_jump_death");
    var0.a.nodeath = 1;
    var0 scripts\engine\sp\utility::set_allowdeath(1);
    var0 scripts\engine\sp\utility::die();
  }

  scripts\engine\utility::flag_set("car_jumper_done");

  foreach(var8 in var1) {
    var8.skipdeathanim = 1;
    var8 scripts\common\ai::stop_magic_bullet_shield();
    var8 scripts\engine\sp\utility::die();
  }
}

function car_jumper_car_delete_civs(var0) {
  level endon("spec_price_intro_start");
  self waittill("rocked");
  var0 delete();
}

function jumper_dmg_detect() {
  self endon("death");
  self endon("stop_jumper_dmg_detect");
  var0 = 0;

  for(;;) {
    self waittill("damage", var1, var2);

    if(scripts\engine\utility::is_equal(var2, level.player)) {
      var0 = 1;
    }

    if(isexplosivedamagemod(self.damagemod)) {
      var0 = 1;
    }

    if(var0) {
      self notify("car_jump_interupt");
    }
  }
}

function car_jumper_logic(var0, var1, var2) {
  self.car = var2;
  var0 thread scripts\common\anim::anim_loop_solo(self, "car_jump_idle");
  self.car thread scripts\sp\maps\piccadilly\piccadilly_ambient::scriptable_anim(level.scr_anim["car_jumper_car"]["car_jump_loop_shoot"][0]);
  waitframe();
  self linkTo(var2, "tag_body_animate");
  var3 = 1;
  var4 = scripts\engine\utility::waittill_any_ents_return(self, "car_jump_interupt", level, "combat_start");

  if(var4 == "combat_start") {
    var5 = 4;
    self endon("car_jump_interupt");
  } else {
    var4 = 0;
    var5 = 0.5;
  }

  var1 notify("stop_loop");
  var1 childthread scripts\common\anim::anim_loop_solo(self, "car_jump_loop_shoot");
  level scripts\engine\utility::delaythread(0.1, &car_civs_die, var1, var2, var3);
  car_jumper_shooting(var5, var2);
  var1 notify("stop_loop");

  if(!var4) {
    return undefined;
  }

  self.car thread scripts\sp\maps\piccadilly\piccadilly_ambient::scriptable_anim(self.car scripts\engine\utility::getanim("car_jump_exit_back"));
  self notify("stop_jumper_dmg_detect");
  scripts\common\ai::magic_bullet_shield();
  var1 scripts\common\anim::anim_single_solo(self, "car_jump_exit_back");
  scripts\common\ai::stop_magic_bullet_shield();
  self.bulletsinclip = weaponclipsize(self.weapon);
  scriptable_clearanim(self.car);
  self.goalradius = 1000;
  self unlink();
  self.ignoreme = 0;
  return 1;
}

function car_civs_die(var0, var1, var2) {
  if(level.start_point == "trailer_car_jumper") {
    return;
  }

  var2 notify("stop_loop");
  var2 scripts\common\anim::anim_single(var1, "car_death");
}

function car_jumper_shooting(var0, var1) {
  var2 = gettime();
  var3 = ["j_head", "j_neck", "j_helmet", "j_clavicle_le"];
  var4 = level.start_point == "trailer_car_jumper";
  var5 = level._effect["vfx_muz_ar_w_trailer"];

  while(gettime() < var2 + var0 * 1000) {
    playFX(var5, self gettagorigin("tag_flash"), anglesToForward(self gettagangles("tag_flash")));
    scripts\anim\notetracks::notetrackfire();

    if(!var4) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_imp_flesh_lrg"), var1[randomint(var1.size)], var3[randomint(var3.size)]);
    }

    wait 0.05 + randomfloatrange(0.05, 0.15);
  }
}

function left_side_street_runners() {
  level endon("going_right_side");
  level endon("inside_gap_flag");
  var0 = getspawnerarray("left_sidestreet_civs");

  for(;;) {
    scripts\engine\utility::flag_wait("left_side_runner_go");

    while(scripts\engine\utility::flag("left_side_runner_go")) {
      foreach(var2 in var0) {
        if(!isDefined(var2.count)) {
          var2.count = 100;
        }

        var3 = scripts\engine\sp\utility::fakeactorspawn(var2);
        thread fake_actor_think();
        wait 0.6;
      }

      wait 7;
    }
  }
}

function sting_inside_enemy_accuracy() {
  level.player endon("death");
  scripts\sp\maps\piccadilly\piccadilly_lighting::init_lights("exterior_bookstore");
  scripts\sp\maps\piccadilly\piccadilly_lighting::lights_off("exterior_bookstore");

  for(;;) {
    scripts\engine\utility::flag_wait("in_reading_place");
    scripts\sp\maps\piccadilly\piccadilly_lighting::lights_on("exterior_bookstore");
    scripts\engine\utility::array_thread(getaiarray("axis"), &set_accuracy_at_dist, 0.01, 500);
    scripts\engine\sp\utility::add_global_spawn_function("axis", &set_accuracy_at_dist, 0.01, 500);
    scripts\engine\utility::flag_waitopen("in_reading_place");
    scripts\sp\maps\piccadilly\piccadilly_lighting::lights_off("exterior_bookstore");
    scripts\engine\sp\utility::remove_global_spawn_function("axis", &set_accuracy_at_dist);
    scripts\engine\utility::array_thread(getaiarray("axis"), &disable_accuracy_at_dist);
  }
}

function set_accuracy_at_dist(var0, var1) {
  if(self.origin[0] < 1900) {
    return;
  }

  self endon("death");
  self endon("stop_accuracy_at_dist");
  var2 = var1 * var1;
  self.og_baseaccuracy = self.baseaccuracy;

  for(;;) {
    while(distance2dsquared(self.origin, level.player.origin) <= var2) {
      wait 1;
    }

    self.baseaccuracy = var0;

    while(distance2dsquared(self.origin, level.player.origin) >= var2) {
      wait 1;
    }

    self.baseaccuracy = self.og_baseaccuracy;
  }
}

function disable_accuracy_at_dist() {
  self notify("stop_accuracy_at_dist");

  if(isDefined(self.og_baseaccuracy)) {
    self.baseaccuracy = self.og_baseaccuracy;
    return;
  }
}

function vo_combat_start() {
  scripts\engine\utility::flag_wait("ally_setup_done");
  thread stop_chatter_in_left_tunnel();
  var0 = (-1795.57, -1984.46, 121);
  var1 = (377.362, -1427.07, 106);
  var2 = (-957.574, -2268.79, 136.486);
  var3 = (-2101.51, -425.873, 286);
  var4 = getEnt("car_jumper_ai", "targetname");

  if(!level.sas[0] iswaitingonsound() && !level.sas[1] iswaitingonsound() && !scripts\sp\maps\piccadilly\piccadilly_util::is_dead_or_dying(var4)) {
    level.sas[0] scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_s151_combat_ext_10", 1, 0.5);
  }

  thread vo_allies_moving_up();
  wait 3;
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_gfc_combat_tube_10", var0, ["tflag_left_underground", "going_right_side"]);
  var5 = ["dx_vom_s151_combat_tube_20", "dx_vom_s152_combat_tube_30", "dx_vom_uk53_combat_tube_40", "dx_vom_uk54_combat_tube_50"];
  scripts\sp\maps\piccadilly\piccadilly_util::add_say_on_closest_ally_to_chatter(var5, var0, ["tflag_left_underground", "going_right_side"]);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk52_sting_entrance_90", var3, ["snipers_engaged", "gap_approach", "gap_nag_started", "going_right_side"]);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk51_sting_entrance_100", var3, ["snipers_engaged", "gap_approach", "gap_nag_started", "going_right_side"]);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_gfc_sting_entrance_110", var3, ["snipers_engaged", "gap_approach", "gap_nag_started", "going_right_side"]);
  var5 = ["dx_vom_s151_sting_entrance_120", "dx_vom_s152_sting_entrance_130", "dx_vom_uk53_sting_entrance_140", "dx_vom_uk54_sting_entrance_150"];
  scripts\sp\maps\piccadilly\piccadilly_util::add_say_on_closest_ally_to_chatter(var5, var3, ["sting_building_rescue_start", "gap_approach", "gap_nag_started", "going_right_side"]);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_gfc_sting_entrance_10", [var2, var3], ["going_right_side", "sting_building_rescue_start", "gap_nag_started"]);
  var5 = ["dx_vom_s151_sting_entrance_20", "dx_vom_s152_sting_entrance_30", "dx_vom_uk53_sting_entrance_40", "dx_vom_uk54_sting_entrance_50"];
  scripts\sp\maps\piccadilly\piccadilly_util::add_say_on_closest_ally_to_chatter(var5, [var2, var3], ["going_right_side", "sting_building_rescue_start", "gap_nag_started"]);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk52_post_bomb_street_51", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk51_post_bomb_street_52", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk51_post_bomb_street_53", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk54_post_bomb_chatter_20", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_gfc_post_bomb_chatter_30", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk54_post_bomb_chatter_40", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk51_post_bomb_chatter_60", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk53_post_bomb_chatter_70", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_gfc_post_bomb_chatter_80", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk53_post_bomb_chatter_90", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk54_post_bomb_chatter_100", 400);
  scripts\sp\maps\piccadilly\piccadilly_util::add_to_chatter("dx_vom_uk51_post_bomb_chatter_130", 400);
  var6 = spawnStruct();
  vo_go_left_right_nags(level, var6);

  if(var6.times_nagged > 0) {
    level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_combat_fork_90", 1, 1);
    return;
  }
}

function stop_chatter_in_left_tunnel() {
  scripts\engine\utility::flag_wait("tflag_left_underground");
  scripts\sp\maps\piccadilly\piccadilly_util::pause_chatter();
  scripts\engine\utility::flag_wait_or_timeout("left_side_under_engaged", 8);
  wait 4;
  scripts\sp\maps\piccadilly\piccadilly_util::resume_chatter();
}

function vo_allies_moving_up() {
  wait 3;

  if(isalive(level.sas[0])) {
    level.sas[0] waittill("goal_changed");
    level.sas[0] scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_s151_combat_ext_40", 1, 0.5);
    level.sas[1] scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_s152_combat_ext_50", 1);
    return;
  }
}

function vo_go_left_right_nags(var0) {
  var1 = ["dx_vom_s151_combat_fork_10", "dx_vom_s152_combat_fork_30", "dx_vom_uk53_combat_fork_50", "dx_vom_uk54_combat_fork_70"];
  var2 = ["dx_vom_s151_combat_fork_20", "dx_vom_s152_combat_fork_40", "dx_vom_uk53_combat_fork_60", "dx_vom_uk54_combat_fork_80"];
  var3 = scripts\engine\sp\utility::create_deck([var1, var2], 0);
  var0.times_nagged = 0;
  var4 = 6;
  var5 = 1;
  level endon("left_starting_street");
  thread monitor_distance_from_starting_street();

  for(;;) {
    wait randomfloatrange(var4 - var5, var4 + var5);
    scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var3 scripts\engine\sp\utility::deck_draw());
    var0.times_nagged++;
    var4 = min(var4 * 2.25, 20);
    var5 = min(var5 * 2.5, 6);
  }
}

function monitor_distance_from_starting_street() {
  var0 = (-1412.33, -2577.08, 106.286);

  while(distance2dsquared(level.player.origin, var0) < 360000) {
    waitframe();
  }

  level notify("left_starting_street");
}

function combat_objectives() {
  if(scripts\engine\sp\objectives::objective_exists("piccadilly_objective")) {
    scripts\engine\sp\objectives::objective_remove_all_locations("piccadilly_objective");
    scripts\engine\sp\objectives::objective_update("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_NEUTRALIZE", "");
  } else {
    scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_NEUTRALIZE", "");
  }

  scripts\engine\utility::flag_wait_any("spec_converge", "obj_update");

  while(!should_show_obj()) {
    wait 1;
  }

  var0 = scripts\engine\utility::getStruct("spec_door_interact", "targetname");
  var1 = scripts\engine\utility::getStruct("combat_obj", "targetname");
  var1.origin = var0.origin + (0, 0, 8);
  scripts\engine\sp\objectives::objective_update("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_TANTO", &"PICCADILLY/CURSOR_TANTO");
  scripts\engine\sp\objectives::objective_add_location_position("piccadilly_objective", "tanto", var1.origin);
  thread gap_nag();
  thread display_obj_hint_if_needed();
}

function display_obj_hint_if_needed() {
  level.player endon("death");
  level endon("spec_price_intro_start");
  level.player.focus.uses = 0;
  GscBinSkip4(0x6e, level.player);
}

function should_show_obj() {
  if(isDefined(level.deathsdoor_sfx)) {
    return false;
  }

  if(level.player isfiring()) {
    return false;
  }

  if(istrue(level.player playerads())) {
    return false;
  }

  return true;
}

function player_focus_counter() {
  for(;;) {
    self waittill("focus_pressed");
    self waittill("focus_released");
    self.focus.uses++;
  }
}

function gap_nag() {
  level notify("gap_nag_started");
  level endon("spec_price_intro_start");

  if(!isDefined(level.vo_chatter)) {
    scripts\sp\maps\piccadilly\piccadilly_util::init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var0 = spawnStruct();
  var0.times_nagged = 1;
  var0.min_wait = 8;
  var0.max_wait = 12;
  wait_tanto_nag(var0);
  level.player thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_sting_rear_exit_10");
  level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_gfc_sting_rear_exit_20");
  level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_sting_snipers_180");

  for(;;) {
    wait_tanto_nag(var0);
    var1 = ["dx_vom_s151_sting_snipers_140", "dx_vom_s152_sting_snipers_150", "dx_vom_uk53_sting_snipers_160", "dx_vom_uk54_sting_snipers_170"];
    level scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var1);
    wait_tanto_nag(var0);
    level scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_gfc_sting_snipers_121");
    wait_tanto_nag(var0);
    var1 = ["dx_vom_s151_sting_snipers_190", "dx_vom_s152_sting_snipers_200", "dx_vom_uk53_sting_snipers_210", "dx_vom_uk54_sting_snipers_220"];
    level scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var1);
    wait_tanto_nag(var0);
    level scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_gfc_sting_rear_tanto_70");
    wait_tanto_nag(var0);
    level scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_gfc_sting_rear_tanto_80");
    wait_tanto_nag(var0);
    level scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_gfc_sting_rear_tanto_90");
  }
}

function wait_tanto_nag() {
  var0 = (208.254, 234.34, 120);
  self.times_nagged++;
  self.min_wait = min(self.min_wait * 1.2, 30);
  self.max_wait = min(self.max_wait * 1.2, 40);
  wait randomfloatrange(self.min_wait, self.max_wait);

  while(distance2dsquared(level.player.origin, var0) < 891136) {
    wait 0.3;
  }
}

function setup_allies() {
  scripts\engine\utility::flag_wait("ally_setup_done");
  var0 = scripts\engine\sp\utility::get_spawner_array("sas_replace", "script_noteworthy");

  foreach(var2 in level.sas) {
    var2.ignoreall = 0;
    var2.ignoreme = 0;
    thread replace_sas_with_police();
    var2.colornode_func = &scripts\sp\maps\piccadilly\piccadilly_util::colornode_arrived_func;
  }
}

function replace_sas_with_police() {
  level endon("kill_color_replacements");
  self waittill("death");
  var0 = undefined;
  var0 = scripts\sp\colors::spawn_hidden_reinforcement("actor_ally_london_police_hivis", "y");
  var0 scripts\engine\sp\utility::set_maxsightdistsquared(3610000);
  var0.colornode_func = &scripts\sp\maps\piccadilly\piccadilly_util::colornode_arrived_func;
  thread replace_sas_with_police();
}

function allies_respawn() {
  level.respawn_friendlies_force_vision_check = 1;
  var0 = getspawnerarray("police_redshirts");
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::add_spawn_function, &scripts\engine\sp\utility::replace_on_death);
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::add_spawn_function, &scripts\engine\sp\utility::set_maxsightdistsquared, 3610000);
  scripts\engine\utility::flag_wait("start_moveup_center");
  scripts\engine\sp\utility::activate_trigger_with_targetname("police_redshirts_trig");
}

function spawn_start_enemies() {
  var0 = getspawnerarray("enemies_start");
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::add_spawn_function, &start_enemies_logic);
  thread vo_stairs_balcony_guy();
  var0 = getspawnerarray("bus_spawners");
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::add_spawn_function, &left_side_kill_squad_terry);
  scripts\engine\sp\utility::activate_trigger_with_targetname("trg_enemies_start");
}

function start_enemies_logic() {
  self endon("death");
  self.attackeraccuracy = 0.25;
  self.disablepain = 1;
  wait 4;
  self.disablepain = 0;
}

function vo_stairs_balcony_guy() {
  scripts\engine\sp\utility::trigger_wait_targetname("spawn_balcony_guy");
  wait 2.5;
  var0 = getEnt("pf2_auto2416", "targetname");
  var1 = ["dx_vom_s151_sting_snipers_10", "dx_vom_s152_sting_snipers_20", "dx_vom_uk53_sting_snipers_30", "dx_vom_uk54_sting_snipers_40"];
  scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var1, 1, 1);

  if(scripts\engine\utility::flag("gap_approach")) {
    return;
  }

  if(isalive(var0)) {
    var0 waittill("death");
  }

  wait 0.45;

  if(level.player.origin[2] < 230) {
    level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_sting_snipers_50", 1, 0.35);
    return;
  }
}

function check_player_attacker() {
  wait 3.5;
  var0 = scripts\engine\sp\utility::get_ai_group_ai("casual_killers_start");
  var1 = undefined;

  if(var0.size) {
    foreach(var3 in var0) {
      if(scripts\engine\utility::is_equal(var3.enemy, level.player)) {
        var1 = var3;
        break;
      }
    }

    if(!isDefined(var1)) {
      var5 = scripts\engine\sp\utility::get_closest_to_player_view(var0, level.player, 1);
      thread enemy_favor_player();
      return;
    }

    return;
  }
}

function enemy_favor_player() {
  self endon("death");
  self.ignoreme = 1;
  self clearenemy();
  self.favoriteenemy = level.player;
  self getenemyinfo(level.player);
  wait 2;
  self.ignoreme = 0;
}

function rooftop_attackers() {
  level.player endon("death");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("rpg", &rpg_ai);

  while(level.player.origin[1] < -1888) {
    wait 0.5;
  }

  var0 = getspawner("rpg", "script_noteworthy");

  for(;;) {
    var1 = var0 scripts\engine\sp\utility::spawn_ai();

    if(!scripts\common\ai::spawn_failed(var1)) {
      return;
    }

    wait 1;
  }
}

function rpg_ai() {
  self endon("death");
  self.homepos = self.origin;
  self.goalradius = 50;
  self.health = 10;
  self.dontevershoot = 1;
  self.fixednode = 1;
  self.canmove = 1;
  self.dropweapon = 0;
  var0 = getnode("rpg_guy_start", "script_noteworthy");
  thread scripts\sp\spawner::go_to_node(var0, &can_move_to_next_node);
  thread rpg_guy_scripted();
  scripts\engine\utility::flag_wait_any("right_to_ripleys", "center_guys_pull_up");
  self notify("player_attacked_me");
}

function can_move_to_next_node(var0) {
  self endon("death");

  while(!self.canmove) {
    wait 0.25;
  }
}

#using_animtree("generic_human");

function rpg_guy_scripted() {
  thread rpg_guy_retreat();
  self endon("death");
  self endon("retreating");
  level endon("inside_gap_flag");
  self.used_destructible_targets = [];
  self.damage_functions[self.damage_functions.size] = &rpg_guy_damage_func;
  self.deathfunction = &rpg_guy_death_func;
  var0 = spawn("script_origin", level.player.origin);
  self.ignoreme = 1;
  self setentitytarget(var0);
  var0 dontinterpolate();
  var1 = 1;
  var2 = 0;
  self.lastshoottime = gettime() - 3000;
  level.scr_anim["generic"]["rpg_reload"] = % sdr_com_exposed_stand_rpg_reload;
  wait 5;

  for(;;) {
    while(!rpg_guy_can_shoot()) {
      wait 0.5;
    }

    self.canmove = 0;
    var3 = undefined;
    var4 = get_rpg_guy_target();

    if(isDefined(var4) && !isalive(var4)) {
      self.used_destructible_targets[self.used_destructible_targets.size] = var4;
      var3 = var4.origin;
    } else if(scripts\engine\utility::is_equal(var4, level.player)) {
      var3 = var4.origin;
    } else {
      var3 = level.player.origin + anglesToForward(level.player.angles) * 800;
    }

    var5 = 0;

    if(!scripts\engine\utility::is_equal(var4, level.player)) {
      foreach(var7 in getaiarray("axis")) {
        if(var7 scripts\engine\utility::doinglongdeath()) {
          continue;
        }

        var8 = distancesquared(var7.origin, var3);

        if(var8 <= 122500 || istrue(level.suicide_bombers_alive)) {
          var5 = 1;
          break;
        }
      }

      if(var5) {
        wait 1;

        if(isDefined(var4)) {
          self.used_destructible_targets = scripts\engine\utility::array_remove(self.used_destructible_targets, var4);
        }

        continue;
      }
    }

    var10 = vectortoangles(var3 - self getEye());
    var0.origin = self.origin + anglesToForward(var10) * 500;
    var11 = self.origin + (0, 0, 45) + anglesToForward(self.node.angles) * 35;
    wait 0.75;
    self.lastshoottime = gettime();
    var12 = magicbullet("iw8_la_rpapa7_ai_picc", var11, var3);
    thread rpg_impact(var12);
    var13 = 2;
    wait var13 * 0.5;
    scripts\common\anim::anim_generic(self, "rpg_reload");
    self.canmove = 1;
    wait var13 * 0.5;

    if(scripts\engine\utility::is_equal(var4, level.player)) {
      var14 = ["dx_vom_s151_sting_rear_exit_70", "dx_vom_s152_sting_rear_exit_80", "dx_vom_uk53_sting_rear_exit_90", "dx_vom_uk54_sting_rear_exit_100"];
      thread scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var14, 1, 0.3);
    }

    if(var1) {
      thread vo_rpg_guy();
      var1 = 0;
    }

    wait 2;

    if(!var2) {
      var15 = waittill_player_sees_me_or_timeout(randomintrange(5, 8));
      var2 = 1;
      continue;
    }

    wait randomintrange(5, 8);
    var2 = 0;
  }
}

function rpg_guy_damage_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(scripts\engine\utility::is_equal(var1, level.player)) {
    if(self isinscriptedstate()) {
      scripts\engine\sp\utility::anim_stopanimScripted();
    }

    self notify("player_attacked_me");
    return;
  }
}

function rpg_guy_death_func() {
  scripts\common\ai::gun_remove();
  var0 = vectorNormalize(level.player.origin - self.origin);
  self startragdollfromimpact("torso_upper", var0 * 3000);
  return true;
}

function rpg_guy_retreat() {
  self endon("death");
  GscBinSkip4(0x35);
}

function notify_whizby_from_player() {
  for(;;) {
    self waittill("bulletwhizby", var0);

    if(scripts\engine\utility::is_equal(var0, level.player)) {
      self notify("player_attacked_me");
    }
  }
}

function waittill_player_sees_me_or_timeout(var0) {
  self endon("death");
  self endon("timeout");
  thread scripts\engine\sp\utility::notify_delay("timeout", var0);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.98)) {
      return 1;
    }

    waitframe();
  }
}

function rpg_impact(var0) {
  var0 waittill("explode", var1);

  if(isDefined(var1)) {
    thread scripts\engine\sp\utility::earthquake_and_rumble(var1);
    return;
  }
}

function vo_rpg_guy() {
  level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk51_sting_rear_exit_30");
  level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk52_sting_rear_exit_40");
  level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk51_sting_rear_exit_50");
}

function get_rpg_guy_target() {
  if(scripts\engine\utility::flag("player_in_center")) {
    return level.player;
  }

  var0 = getscriptablearray();
  var1 = [];
  var2 = undefined;

  foreach(var4 in var0) {
    if(isDefined(var4.model) && issubstr(var4.model, "veh") && var4.health > -250 && !scriptable_should_be_ignored(var4)) {
      var1 = var4;
    }
  }

  var1 = sortbydistance(var1, level.player.origin);
  var6 = scripts\engine\utility::getStructArray("rpg_target", "targetname");
  var7 = scripts\engine\utility::array_combine(var1, var6);
  var7 = scripts\engine\utility::array_combine(var7, getaiarray("allies"));
  var8 = cos(40);

  if(var7.size) {
    foreach(var10 in var7) {
      var11 = distancesquared(var10.origin, level.player.origin);

      if(!scripts\engine\utility::array_contains(self.used_destructible_targets, var10) && var11 <= squared(1500) && var11 >= squared(500) && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var10.origin, var8)) {
        return var10;
      }
    }
  }

  return undefined;
}

function scriptable_should_be_ignored() {
  return scripts\engine\utility::is_equal(self.script_noteworthy, "ignore");
}

function rpg_guy_can_shoot() {
  if(isDefined(self.currentpose) && self.currentpose != "stand") {
    return false;
  }

  if(isDefined(self.pathgoalpos)) {
    return false;
  }

  if(!isDefined(self.node)) {
    return false;
  }

  if(level.player scripts\sp\maps\piccadilly\piccadilly_util::has_ceiling()) {
    return false;
  }

  return true;
}

function allies_same_color() {
  scripts\engine\utility::flag_wait("start_moveup_center");
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::set_force_color("r");
  }
}

function left_side_kill_squad_terry() {
  self endon("death");
  self waittill("civ_killer_end");

  if(scripts\engine\utility::is_equal(self.lastattacker, level.player)) {
    return;
  }

  if(!scripts\anim\utility_common::player_can_see_ai(level.player, self)) {
    var0 = getEnt("goal_gap_defend", "targetname");
    self setgoalvolumeauto(var0);
    return;
  }

  thread close_in_on_far_player();
}

function left_crash_kill_squad_terry() {}

function police_vignette() {
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(getdvarint("pic_intro") == 0) {
    return;
  }

  var0 = [];
  var1 = scripts\engine\utility::getStruct("police_scripted_node", "targetname");
  var2 = scripts\sp\maps\piccadilly\piccadilly_util::picc_spawn_ai("bobby_dr", 0);
  var2.animname = "police01";
  var0 = var2;
  var2 = scripts\sp\maps\piccadilly\piccadilly_util::picc_spawn_ai("bobby_pass", 0);
  var2.animname = "police02";
  var0 = var2;
  var3 = getscriptablearray("police_arrive_scriptable_car", "targetname")[0];
  thread police_arrive_car_firstframe(var3);
  var1 thread scripts\common\anim::anim_single(var0, "police_arrive");
  waitframe();
  police_car_set_animtime(var3, 0.1);
  police_car_set_animrate(var3, 0);

  foreach(var5 in var0) {
    var5 setanimtime(level.scr_anim[var5.animname]["police_arrive"], 0.1);
    var5 setanimrate(level.scr_anim[var5.animname]["police_arrive"], 0);
  }

  scripts\engine\utility::flag_wait("combat_start");
  police_car_set_animrate(var3, 1);

  foreach(var5 in var0) {
    var5 setanimrate(level.scr_anim[var5.animname]["police_arrive"], 1);
  }

  wait 3;
}

function spec_converge() {
  scripts\engine\utility::flag_wait_any("obj_update", "spec_converge");
  thread police_corpse_manager();
  scripts\sp\spawner::killspawner(2);

  if(!scripts\engine\utility::flag("spec_converge")) {
    scripts\engine\utility::flag_set("spec_converge");
  }

  scripts\engine\sp\utility::autosave_by_name("spec_converge");
  thread center_guys_to_volume("goal_gap_defend");
  var0 = getspawnerarray("obj_frontline");
  var1 = [];
  var2 = [];

  foreach(var4 in var0) {
    if(var5 <= 2) {
      var1 = var4;
      continue;
    }

    var2 = var4;
  }

  var6 = getspawner("tanto_doorway_flood", "targetname");
  var1 = scripts\engine\utility::array_add(var1, var6);

  if(!scripts\sp\starts::is_after_start("lillywhites")) {
    wait 10;
  }

  thread scripts\sp\spawner::flood_spawner_scripted(var1);
  scripts\engine\utility::flag_wait("gap_approach");
  var0 = scripts\engine\utility::array_remove(var0, var6);

  if(isDefined(var6)) {
    var6 delete();
  }

  thread scripts\sp\spawner::flood_spawner_scripted(var2);
  scripts\engine\utility::flag_wait("final_bomber");
  scripts\engine\sp\utility::autosave_by_name("gap_bomber");
  scripts\engine\sp\utility::array_notify(var0, "stop current floodspawner");
  level notify("kill_color_replacements");
}

function tanto_doorway_flood_logic() {
  self waittill("death", var0);

  if(scripts\engine\utility::is_equal(var0, level.player)) {
    var1 = getspawner("tanto_doorway_flood", "targetname");

    if(isDefined(var1)) {
      var1 delete();
      return;
    }

    return;
  }
}

function police_corpse_manager() {
  level endon("spec_price_intro_start");
  var0 = (123, -292, 111.5);
  var1 = (245.5, 252, 140);
  GscBinSkip4(0x35, var0, 350);
}

function delete_corpses_around_pos(var0, var1, var2) {
  if(!isDefined(var2)) {
    var3 = 55;
  } else {
    var3 = var3;
  }

  var4 = cos(var3);

  for(;;) {
    wait 5;

    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var1, var4)) {
      wait 0.25;
    }

    var5 = getcorpsearrayinradius(var1, var2);

    if(var5.size > 1) {
      delete_corpses(var5);
    }
  }
}

function delete_corpses(var0) {
  var1 = cos(65);
  var2 = 360000;
  var3 = 0;

  while(var0.size) {
    foreach(var5 in var0) {
      if(isDefined(var5) && distancesquared(var5.origin, level.player.origin) > var2) {
        var5 delete();
        continue;
      }

      if(isDefined(var5) && !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var5.origin, var1)) {
        var5 delete();
        var3++;

        if(var3 == 3) {
          var3 = 0;
          wait 0.1;
          continue;
        }
      }

      var0 = scripts\engine\utility::array_removeundefined(var0);
    }

    waitframe();
  }
}

function frontline_police_logic() {
  self endon("death");
  self.balwayscoverexposed = 1;
  self.goalradius = 50;
  self.maxsightdistsqrd = 3610000;
  self.targetname = "obj_frontline_ai";
  scripts\engine\utility::flag_wait("spawn_gap_bomber");
  self.dontevershoot = 1;
  wait 2 + randomfloat(1);
  self.dontevershoot = 0;
}

function bus_animated_civs() {
  if(getdvarint("pic_intro") == 0) {
    return;
  }

  var0 = [];
  var1 = scripts\engine\utility::getStruct("bus_scripted_node", "targetname");

  for(var2 = 1; var2 < 6; var2++) {
    var3 = var1 scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random");
    var3.animname = "bus_death_civ0" + var2;
    var3.dontmelee = 1;
    var3.team = "allies";
    var3.ignoreme = 1;
    var3 thread scripts\sp\maps\piccadilly\piccadilly_civs::ignoreme_til_player_sees();
    var3 setthreatbiasgroup("civilians");
    var3.attackeraccuracy = 10;

    if(var2 == 5) {
      var3 thread scripts\sp\maps\piccadilly\piccadilly_util::ragdoll_death_after_anim();
    }

    var0 = var3;
  }

  scripts\engine\utility::array_thread(var0, &civ_think_vignette, var1, "bus_death", "bus_exit_node");
  thread scripts\sp\maps\piccadilly\piccadilly_util::crowd_screams(var0[0].origin);
}

function civ_think_vignette(var0, var1, var2) {
  self endon("death");
  var0 scripts\common\anim::anim_single_solo(self, var1);

  if(!isai(self)) {
    var3 = self.animname;
    scripts\sp\maps\piccadilly\piccadilly_util::make_room_for_ai();
    var4 = scripts\sp\maps\piccadilly\piccadilly_civs::spawner_makerealai(self);
    level.piccadilly.civilians = scripts\engine\utility::array_add(level.piccadilly.civilians, var4);
    var4.animname = var3;
  } else {
    var4 = self;
  }

  var4 thread scripts\sp\maps\piccadilly\piccadilly_civs::civ_think_run(var4);
}

function fake_civ_stream(var0, var1, var2, var3) {
  level endon(var1);

  if(scripts\engine\utility::flag_exist(var1) && scripts\engine\utility::flag(var1)) {
    return;
  }

  var4 = getspawnerarray(var0);
  var2 = scripts\engine\utility::ter_op(isDefined(var2), var2, 2);

  for(;;) {
    foreach(var6 in var4) {
      if(!isDefined(var6.count)) {
        var6.count = 100;
      }

      var7 = scripts\engine\sp\utility::fakeactorspawn(var6);
      thread fake_actor_think();

      if(istrue(var3)) {
        var7 thread scripts\sp\maps\piccadilly\piccadilly_util::check_player_psycho();
      }

      wait randomfloatrange(0.2, 1);
    }

    wait var2;
  }
}

function fake_actor_think(var0) {
  self endon("death");
  self.ignoreme = 1;
  thread scripts\sp\maps\piccadilly\piccadilly_util::acievement_monitor();
  self freeentitysentient();
  self waittill("reached_path_end");
  self delete();
}

function bus_entered() {
  scripts\engine\utility::flag_wait("bus_window");
  var0 = scripts\engine\utility::getStruct("bus_bullets", "targetname");
  scripts\engine\utility::delaythread(2, &magicbullets_at_window, var0, 0.6);
  scripts\engine\sp\utility::array_spawn_targetname("player_bus_enemies");
}

function magicbullets_at_window(var0, var1) {
  var2 = var0;
  var3 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var4 = var1;
  var5 = var3 scripts\engine\utility::spawn_script_origin();

  if(isDefined(var3.target)) {
    var6 = scripts\engine\utility::getStruct(var3.target, "targetname");
    var5 moveTo(var6.origin, var4);
  }

  var7 = gettime();

  while(gettime() - var7 < var4 * 1000) {
    magicbullet("iw8_ar_akilo47", var2.origin, var5.origin);
    wait randomfloatrange(0.1, 0.2);
  }

  var5 delete();
}

function sniper_perch_setup() {
  level.snipers = [];
  var0 = getspawnerarray("sniper_perch_guys");
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::add_spawn_function, &sniper_logic);
  level waittill("snipers_engaged");
  scripts\engine\sp\utility::waittill_dead_or_dying(level.snipers);
  thread check_sting_is_clear();
}

function sting_sniping() {
  self endon("death");
  createthreatbiasgroup("player");
  setthreatbias("axis", "player", -10000);
  setthreatbias("player", "axis", -10000);
  var0 = 1;

  for(;;) {
    if(player_is_sniping("player_did_sniping")) {
      if(var0) {
        var0 = 0;
        thread vo_player_sniping();
        thread sniper_bus_rescue();
        thread sting_sniping_extras();
        waitframe();
      }

      foreach(var2 in getaiarray("axis")) {
        if(scripts\engine\utility::is_equal(var2.targetname, "rooftop") || var2 isinscriptedstate() || scripts\engine\utility::is_equal(var2.targetname, "sniper_perch_guys")) {
          continue;
        }

        var2 setthreatbiasgroup("kill_civs");
      }

      thread player_sniping_threatbisas();

      while(player_is_sniping("player_did_sniping")) {
        wait 1;
      }

      foreach(var2 in getaiarray("axis")) {
        var2 setthreatbiasgroup("axis");
      }
    }

    wait 1;
  }
}

function player_sniping_threatbisas() {
  level endon("player_did_sniping");

  for(;;) {
    level.player waittill("weapon_fired");
    var0 = scripts\engine\utility::get_array_of_closest(level.player.origin, getaiarray("axis"), undefined, undefined, 1100);

    foreach(var2 in var0) {
      var2 setthreatbiasgroup("axis");
    }
  }
}

function vo_player_sniping() {
  level.player waittill("weapon_fired");
  level.player waittill("weapon_fired");
  wait randomfloatrange(0.2, 0.8);

  if(!player_is_sniping("player_did_sniping")) {
    return;
  }

  var0 = ["dx_vom_s151_sting_snipers_80", "dx_vom_s152_sting_snipers_90", "dx_vom_uk53_sting_snipers_100", "dx_vom_uk54_sting_snipers_110"];
  level thread scripts\sp\maps\piccadilly\piccadilly_util::say_sequence_as_chatter(["dx_vom_uk51_sting_snipers_70", [ &scripts\sp\maps\piccadilly\piccadilly_util::say_line_on_closest_ally, [var0]]], 0, 5);
}

#using_animtree("");

function sniper_bus_rescue() {
  level endon("sniper_bus_rescue_abort");
  level.player scripts\sp\utility::set_player_attacker_accuracy(0);
  var0 = scripts\engine\utility::getStruct("sniping_bus_scene", "targetname");
  var1 = ["civ1", "civ3", "civ4", "civ7", "civ8"];
  var0.civs = [];
  var2 = [];
  var0.idle_guys = 0;

  foreach(var4 in var1) {
    var5 = var0 scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1);
    var5.animname = var4;
    var0 scripts\common\anim::anim_first_frame_solo(var5, "bus_rescue_start");
    var5 childthread scripts\sp\maps\piccadilly\piccadilly_ambient::vignette_drone_give_soul();
    var5 thread scripts\common\ai::magic_bullet_shield(1);
    var0.civs[var0.civs.size] = var5;
    var2 = var5;
    waitframe();
    var5 thread scripts\sp\utility::civilianfailwrapper();
  }

  while(getaiarray().size > 26) {
    waitframe();
  }

  var7 = getstartorigin(var0.origin, var0.angles, %lon_pic_ctr_030_bus_sniper_terry2_enter);
  var8 = scripts\engine\sp\utility::spawn_targetname("sniper_bus_scene_terry", 1);
  var8.ignoreme = 1;
  var8.ignoreall = 1;
  var8.animname = "terry";
  var0.terry = var8;
  var8 thread scripts\common\ai::magic_bullet_shield(1);
  var0 scripts\common\anim::anim_first_frame_solo(var8, "bus_rescue_start");
  GscBinSkip4(0x6e, var8, var0);
}

function sniper_recue_abort(var0) {
  level endon("bus_rescue_complete");
  scripts\engine\utility::flag_waitopen("player_upstairs_left");
  level notify("sniper_bus_rescue_abort");
  scripts\engine\utility::array_delete(var0);
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
}

function sniper_bus_civ1_down(var0) {
  self waittillmatch("single anim", "shot");
  magicbullet("iw8_ar_akilo47", var0.terry gettagorigin("tag_flash"), self gettagorigin("j_chest"));
  thread scripts\sp\maps\piccadilly\piccadilly_anim::squib_chest(self);
}

function sniper_bus_civ_enter(var0) {
  self endon("death");

  if(self.animname == "civ1") {
    thread sniper_bus_civ1_down(var0);
  }

  var0 scripts\common\anim::anim_single_solo(self, "bus_rescue_start");
  var0.idle_guys++;
  var0 thread scripts\common\anim::anim_loop_solo(self, "bus_rescue_idle", "stop_idle_" + self getentitynumber());
}

function sniper_bus_civ_outcome(var0) {
  self endon("death");
  var1 = scripts\engine\utility::ter_op(self.animname == "civ1", "bus_scene_kill_civ1", "bus_scene_kill_civs");
  scripts\engine\utility::waittill_any_ents(level, var1, var0, "terry_shot");

  if(!scripts\engine\utility::flag("bus_rescue_over")) {
    scripts\engine\utility::flag_set("bus_rescue_over");
  }

  if(self.animname != "civ1") {
    var0 notify("stop_idle_" + self getentitynumber());
  }

  if(!isDefined(var0.interupted)) {
    var0 scripts\common\anim::anim_single_solo(self, "bus_rescue_death");

    if(!isai(self)) {
      scripts\common\ai::stop_magic_bullet_shield();
      self freeentitysentient();
      self startragdoll();
      self notsolid();
      self kill();
      return;
    }

    return;
  }

  if(self.animname != "civ1") {
    scripts\common\ai::stop_magic_bullet_shield();
    var0 scripts\common\anim::anim_single_solo(self, "bus_rescued_enter");
    var0 thread scripts\common\anim::anim_loop_solo(self, "bus_rescued_idle");
  } else {
    wait 5;
    var0 notify("stop_idle_" + self getentitynumber());
    var0 scripts\common\anim::anim_single_solo(self, "bus_rescue_death");
  }

  scripts\engine\utility::flag_waitopen("player_upstairs_left");
  self delete();
}

function bus_terry_killing_logic(var0) {
  self endon("death");
  var0 thread scripts\common\anim::anim_single_solo(self, "bus_rescue_start");
  scripts\engine\utility::flag_wait("bus_scene_kill_civ1");
  self shoot();
  wait 0.15;
  self shoot();
  scripts\engine\utility::flag_wait("bus_scene_kill_civs");
  level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk52_sting_civbus_130", 1, 1);
  var1 = ["dx_vom_s151_sting_civbus_140", "dx_vom_s152_sting_civbus_150", "dx_vom_uk53_sting_civbus_160", "dx_vom_uk54_sting_civbus_170"];
  thread scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var1);
  thread sniper_bus_terry_bullets();
  self waittillmatch("single anim", "end");
  var0 notify("bus_rescue_complete");
  scripts\common\ai::stop_magic_bullet_shield();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.goalradius = 2048;
  scripts\aitypes\cover::requestcoverfind(0, 0, undefined);
  scripts\engine\utility::flag_waitopen("player_upstairs_left");
  self delete();
}

function waittill_player_aims_at_bus_scene(var0) {
  self endon("death");
  var1 = gettime();
  var2 = var1 + var0 * 1000;

  while(gettime() < var2) {
    if(player_is_aiming_at_bus_scene()) {
      return 1;
    }

    wait 0.1;
  }
}

function player_is_aiming_at_bus_scene() {
  var0 = (-426.6, -678.2, 200);

  if(level.player playerads() < 1) {
    return false;
  }

  if(!scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var0, 0.98)) {
    return false;
  }

  return true;
}

function player_using_sniper_rifle() {
  var0 = level.player getcurrentweapon();

  if(isstring(var0)) {
    var1 = weaponclass(var0);
  } else {
    var1 = var1.classname;
  }

  return var1 == "sniper";
}

function nag_look_at_bus_scene() {
  level endon("player_aimed_at_bus_scene");
  level scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk52_sting_civbus_10", 1, 2);
  level scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk52_sting_civbus_20");
  var0 = ["dx_vom_s151_sting_civbus_50", "dx_vom_s152_sting_civbus_70", "dx_vom_uk53_sting_civbus_90", "dx_vom_uk54_sting_civbus_110"];
  scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var0);
  var0 = ["dx_vom_s151_sting_civbus_60", "dx_vom_s152_sting_civbus_80", "dx_vom_uk53_sting_civbus_100", "dx_vom_uk54_sting_civbus_120"];
  scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var0);
  level waittill("forever");
}

function vo_sniper_bus_scene(var0) {
  var0 endon("terry_shot");
  var0 endon("bus_rescue_complete");
  level endon("bus_scene_kill_civs");
  scripts\sp\maps\piccadilly\piccadilly_util::pause_chatter();
  var0 thread scripts\engine\utility::thread_on_notify("bus_rescue_complete", &scripts\sp\maps\piccadilly\piccadilly_util::resume_chatter);
  wait 1;
  nag_look_at_bus_scene();
  wait 2;
  level scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk52_sting_civbus_30", 1);
}

function sniper_bus_terry_logic(var0) {
  var0 endon("bus_rescue_complete");

  for(;;) {
    self waittill("damage", var1, var2);

    if(isDefined(var2)) {
      if(isPlayer(var2) || isai(var2)) {
        var0.interupted = 1;
        var0 notify("terry_shot");

        if(!scripts\engine\utility::flag("bus_scene_kill_civs")) {
          level scripts\engine\utility::delaythread(1, &scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter, "dx_vom_uk52_sting_civbus_180", 1, 3);
          var3 = ["dx_vom_s151_sting_civbus_190", "dx_vom_s152_sting_civbus_200", "dx_vom_uk53_sting_civbus_210", "dx_vom_uk54_sting_civbus_220"];
          level scripts\engine\utility::delaythread(1.1, &scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally, var3);
        }

        scripts\engine\sp\utility::anim_stopanimScripted();
        thread scripts\anim\shared::dropallaiweapons();
        scripts\common\ai::stop_magic_bullet_shield();
        self.a.nodeath = 0;
        self.allowdeath = 1;
        scripts\engine\sp\utility::die();
        return;
      }
    }
  }
}

function sniper_bus_terry_bullets() {
  var0 = 1;
  var1 = gettime();

  while(gettime() < var1 + var0 * 1500) {
    scripts\anim\notetracks::notetrackfire();
    wait randomfloatrange(0.05, 0.15);
  }
}

function sting_upstairs_extras() {
  scripts\engine\sp\utility::array_spawn_function_targetname("upstairs_right_civ_ai_runners", &upstairs_right_civ_ai_runners_logic);
  thread fake_civ_stream("sting_sniping_fake_civs", "inside_sting_first_floor", 5, 1);
  var0 = getspawnerarray("upstairs_right_civ_ai_runners");
  thread scripts\sp\spawner::flood_spawner_scripted(var0);
  thread sting_upstairs_extras_cleanup();
}

function sting_upstairs_extras_cleanup() {
  scripts\engine\utility::flag_wait("inside_sting_first_floor");
  var0 = getspawnerarray("upstairs_right_civ_ai_runners");
  scripts\engine\utility::array_delete(var0);
}

function sting_sniping_extras() {
  var0 = scripts\engine\sp\utility::array_spawn_targetname("player_snipe_popo", 1);

  foreach(var2 in var0) {
    var2.fixednode = 0;
  }

  var4 = scripts\engine\sp\utility::array_spawn_targetname("player_snipe_terry", 1);
  level.sniping_specific_ai = scripts\engine\utility::array_combine(var0, var4);
  scripts\engine\utility::flag_wait("inside_sting_first_floor");
  level.sniping_specific_ai = scripts\engine\utility::array_removedead(level.sniping_specific_ai);
  scripts\engine\utility::array_call(level.sniping_specific_ai, &delete);
}

function upstairs_right_civ_ai_runners_logic() {
  self.ignoreme = 1;
  scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::set_ignoreme, 0);
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util::get_random_civilian_speed());
  self setthreatbiasgroup("civilians");
  self.attackeraccuracy = 1.3;
  thread scripts\sp\maps\piccadilly\piccadilly_util::check_player_psycho();
}

function middle_road_civ_runners() {
  level endon("spec_price_intro_start");
  var0 = getspawnerarray("middle_road_runner");
  scripts\engine\sp\utility::array_spawn_function_targetname("middle_road_runner", &middle_road_civ_runner);
  scripts\engine\sp\utility::array_spawn_function_targetname("middle_breadcrumb_guys", &middle_breadcrumb_guy);
  var1 = 1;

  for(;;) {
    scripts\engine\utility::flag_wait("middle_road");

    foreach(var3 in var0) {
      var3 stalingradspawn();
    }

    wait 6 + randomint(3);
  }
}

function middle_road_civ_runner() {
  self endon("death");
  self.team = "allies";
  self setthreatbiasgroup("civilians");
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util::get_random_civilian_speed());
  GscBinSkip4(0x35);
}

function player_glance() {
  for(;;) {
    if(distancesquared(self.origin, level.player.origin) <= 62500 && level.player scripts\engine\trace::can_see_origin(self getEye(), 0)) {
      self glanceatpos(level.player getEye(), 1000);
      return;
    }

    wait 1;
  }
}

function middle_breadcrumb_guy() {
  self endon("death");

  if(self.team != "axis") {
    self.team = "allies";
    self.ignoreme = 1;
    scripts\engine\utility::delaythread(2, &scripts\engine\sp\utility::set_ignoreme, 0);
    self setthreatbiasgroup("civilians");
    scripts\asm\asm_bb::bb_setcivilianstate("panic");
    scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util::get_random_civilian_speed());
    self.attackeraccuracy = 10;
    self.dontmeleeme = 1;
    return;
  }

  self.grenadeammo = 0;
  self setthreatbiasgroup("kill_civs");
  thread kill_me_on_gap_approach();
  scripts\engine\utility::flag_wait_or_timeout("middle_breadcrumb_civs_dead", 7);
  self setthreatbiasgroup("axis");
}

function player_is_sniping(var0) {
  if(!scripts\engine\utility::flag("snipers_dead")) {
    return 0;
  }

  if(scripts\engine\utility::flag("bus_rescue_over")) {
    return 0;
  }

  return scripts\engine\utility::flag(var0);
}

function sniper_logic() {
  thread check_dropped_weapon();
  self.sniper_target = scripts\engine\utility::spawn_tag_origin((-513, -1103, 145), (0, 0, 0));
  self.sniper_target dontinterpolate();
  thread sniper_shoot_logic();
  self.goalheight = 150;
  self.attackeraccuracy = 0;
  self setthreatbiasgroup("sniper");
  self.ignoresuppression = 1;
  level.snipers[level.snipers.size] = self;

  if(!scripts\engine\utility::is_equal(self.combatmode, "cover_lmg")) {
    scripts\anim\shared::forceuseweapon(make_picc_sniper_weapon(), "primary");
  }

  self.sniper_rifle_name = createheadicon(self.primaryweapon);
}

function make_picc_sniper_weapon() {
  var0 = ["snprscope_delta", "laserads_bar_bright", "mag_delta", "back_delta", "front_delta", "rec_delta"];
  return scripts\sp\utility::make_weapon("iw8_sn_delta", var0);
}

function sniper_whizby() {
  level endon("snipers_engaged");
  self endon("death");

  for(;;) {
    self waittill("bulletwhizby", var0);

    if(isDefined(var0) && var0 == level.player) {
      self notify("player_attacked_me");

      if(!scripts\engine\utility::flag("snipers_engaged")) {
        scripts\engine\utility::flag_set("snipers_engaged");
      }
    }
  }
}

function sniper_shoot_logic() {
  level endon("snipers_engaged");
  self endon("death");
  self setentitytarget(self.sniper_target);
  self.og_baseaccuracy = self.baseaccuracy;
  self.forcesuppressai = 1;
  wait 1;
  var0 = cos(40);

  for(;;) {
    var1 = scripts\engine\sp\utility::get_ai_group_ai("sniper_fodder");
    var2 = var1;
    var3 = undefined;

    foreach(var5 in var2) {
      if(self cansee(var5)) {
        var3 = var5;
        break;
      }
    }

    self clearentitytarget();

    if(isDefined(var3)) {
      sniper_shoot_target_internal(var3);
    } else if(!isDefined(var3)) {
      self.favoriteenemy = undefined;

      if(scripts\engine\utility::flag("player_upstairs_left")) {
        self.sniper_target.origin = (-513, -1103, 145);
        self setentitytarget(self.sniper_target);
        self.lastenemysightpos = (-513, -1103, 145);
        scripts\engine\utility::flag_wait_or_timeout("player_in_center", 5);
        self clearentitytarget();
      } else {
        var7 = scripts\engine\utility::array_removeundefined(level.injured_actors);
        var8 = undefined;
        var9 = undefined;
        var10 = self gettagorigin("tag_flash");
        var11 = self getapproxeyepos();

        foreach(var13 in var7) {
          var9 = var13 gettagorigin("j_spine4");

          if(istrue(var13.script_index) && scripts\engine\utility::within_fov(self.origin, self.angles, var9, var0) && distance2dsquared(self.origin, var13.origin) > 810000) {
            var14 = var11 + 128 * vectorNormalize(var9 - var11);

            if(sighttracepassed(var11, var14, 0, self)) {
              var8 = var13;
              break;
            }
          }
        }

        var11 = undefined;
        var13 = undefined;

        if(isDefined(var7)) {
          var16 = vectorNormalize(var8 - var9);
          var17 = distance(var9, var8);
          self.sniper_target.origin = var9 + var16 * min(var17 - 400, 500);
          waitframe();
          self setentitytarget(self.sniper_target);
          self.lastenemysightpos = var7.origin;
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

function sniper_shoot_target_internal(var0) {
  if(scripts\engine\utility::flag("player_in_center")) {
    return;
  }

  level endon("player_in_center");
  level endon("player_upstairs_left");
  scripts\engine\sp\utility::set_favoriteenemy(var0);
  var0 scripts\engine\utility::waittill_notify_or_timeout("death", 5);
}

function wake_snipers() {
  var0 = scripts\engine\utility::array_removedead(level.snipers);

  if(!var0.size) {
    scripts\engine\utility::flag_set("snipers_engaged");
    return;
  }

  foreach(var2 in var0) {
    thread sniper_whizby();
    var2.damage_functions[var2.damage_functions.size] = &sniper_damage_func;
    var2.deathfunc = &sniper_deathfunc;
    thread proximity_trig();
  }

  scripts\engine\utility::flag_wait("snipers_engaged");
  var4 = 1;
  var0 = scripts\engine\utility::array_removedead(var0);

  foreach(var2 in var0) {
    if(isalive(var2)) {
      if(!isDefined(var2.lastattacker)) {
        thread sniper_breakout_behavior(var2);
        var4 = 0;
        continue;
      }

      thread sniper_breakout_behavior(var2);
    }
  }
}

function sniper_breakout_behavior(var0) {
  self endon("death");
  self clearentitytarget();
  self.fixednode = 0;
  self.attackeraccuracy = 10;
  self setthreatbiasgroup("axis");
  self clearenemy();
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  self getenemyinfo(level.player);

  if(self.weapon != self.sidearm) {
    scripts\anim\shared::forceuseweapon(self.sidearm, "primary");
  }

  self forcethreatupdate();
  self.newenemyreactiontime = gettime();

  if(!isDefined(self.lastattacker)) {
    self.forcenewenemyreaction = 1;
  }

  self.goalheight = 32;

  while(isalive(self.enemy) && self.enemy != self.favoriteenemy) {
    waitframe();
  }

  if(!isalive(self.enemy)) {
    return;
  }

  if(var0) {
    self.meleeignorefinalzdiff = 1;
    self.maxfaceenemydist = 512;
    scripts\sp\maps\piccadilly\piccadilly_util::charge_enemy(10);
    self.goalradius = 1000;
  } else {
    waitframe();
    var1 = self findbestcovernode(undefined, 1);

    if(isDefined(var1)) {
      var2 = self.keepclaimednodeifvalid;
      var3 = self.keepclaimednode;
      self.keepclaimednodeifvalid = 0;
      self.keepclaimednode = 0;
      self usecovernode(var1, 0);
      self.keepclaimednodeifvalid = var2;
      self.keepclaimednode = var3;
    }

    wait 4;
  }

  self.forcenewenemyreaction = undefined;
}

function sniper_fodder() {
  scripts\engine\sp\utility::array_spawn_function_targetname("sniper_fodder", &scripts\engine\sp\utility::set_attackeraccuracy, 3);
  scripts\engine\sp\utility::trigger_wait_targetname("sniper_spawn_trig");
  var0 = getspawnerarray("sniper_fodder");
  thread scripts\sp\spawner::flood_spawner_scripted(var0);
  scripts\engine\utility::flag_wait("snipers_engaged");
  scripts\engine\utility::array_delete(var0);
  var1 = [];

  foreach(var3 in getaiarray("allies")) {
    if(scripts\engine\utility::is_equal(var3.targetname, "sniper_fodder")) {
      var1 = var3;
    }
  }

  if(var1.size) {
    if(level.player.origin[2] > 200) {
      scripts\engine\utility::array_delete(var1);
      return;
    }

    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var1, 400);
    return;
  }
}

function proximity_trig() {
  self endon("player_attacked_me");
  self endon("death");
  self.trig = spawn("trigger_radius", self.origin, 0, 85, 60);
  thread scripts\engine\utility::delete_on_death(self.trig);
  var0 = 1.6;

  for(;;) {
    self.trig waittill("trigger", var1);

    if(scripts\engine\utility::is_equal(var1, level.player)) {
      if(!scripts\engine\utility::flag("snipers_engaged")) {
        scripts\engine\utility::flag_set("snipers_engaged");
      }

      wait var0;
      self notify("player_attacked_me");
    }
  }
}

function kill_me_on_gap_approach() {
  self endon("death");
  scripts\engine\utility::flag_wait("gap_approach");
  thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 500);
}

function check_dropped_weapon() {
  self endon("entitydeleted");
  self waittill("death");
  var0 = wait_for_dropped_weapon_or_timeout();
  var1 = 0;

  if(isDefined(var0) && !issubstr(var0.classname, "_sn_")) {
    var1 = 1;
  }

  if(!isDefined(var0)) {
    var1 = 1;
  }

  if(var1) {
    var2 = spawn("weapon_" + self.sniper_rifle_name, self.origin + (0, 0, 15), 0);
    return;
  }
}

function wait_for_dropped_weapon_or_timeout() {
  self endon("abort_wait_for_dropped_weapon");
  thread scripts\engine\sp\utility::notify_delay("abort_wait_for_dropped_weapon", 0.1);
  self waittill("weapon_dropped", var0);
  return var0;
}

function sniper_damage_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(scripts\engine\utility::is_equal(var1, level.player)) {
    self notify("player_attacked_me");

    if(!scripts\engine\utility::flag("snipers_engaged")) {
      scripts\engine\utility::flag_set("snipers_engaged");
      return;
    }

    return;
  }
}

function sniper_deathfunc() {
  if(scripts\engine\utility::is_equal(self.lastattacker, level.player)) {
    self notify("player_attacked_me");

    if(!scripts\engine\utility::flag("snipers_engaged")) {
      scripts\engine\utility::flag_set("snipers_engaged");
    }
  }

  return false;
}

function shoot_player_if_in_center() {
  for(;;) {
    scripts\engine\utility::flag_wait("player_in_center");
    level.player setthreatbiasgroup("player_focus");
    thread vo_player_in_center_nags();
    scripts\engine\utility::flag_waitopen("player_in_center");
    level.player setthreatbiasgroup("allies");
  }
}

function vo_player_in_center_nags() {
  if(getaiarray("axis").size < 3) {
    return;
  }

  level endon("player_in_center");
  wait 1;

  for(;;) {
    var0 = ["dx_vom_s151_shops_fountain_10", "dx_vom_s152_shops_fountain_20", "dx_vom_uk53_shops_fountain_30", "dx_vom_uk54_shops_fountain_40"];

    if(isDefined(level.vo_chatter) && isDefined(level.vo_chatter.last_center_nagged) && !scripts\engine\utility::time_has_passed(level.vo_chatter.last_center_nagged, 10)) {
      wait 10 - (gettime() - level.vo_chatter.last_center_nagged) / 1000;
    }

    scripts\sp\maps\piccadilly\piccadilly_util::say_line_on_closest_ally(var0);

    if(isDefined(level.vo_chatter)) {
      level.vo_chatter.last_center_nagged = gettime();
    }

    wait randomfloatrange(15, 20);
  }
}

function nag_get_downstairs(var0) {
  if(!scripts\engine\utility::flag("player_upstairs_left")) {
    return;
  }

  level endon("player_upstairs_left");

  for(;;) {
    wait randomfloatrange(8, 12);

    if(isDefined(level.vo_chatter) && level.vo_chatter.stopped) {
      continue;
    }

    if(var0 scripts\engine\sp\utility::deck_is_empty()) {
      var0 scripts\sp\maps\piccadilly\piccadilly_util::array_deck_shuffle();
    }

    var1 = var0 scripts\engine\sp\utility::deck_draw();
    scripts\sp\maps\piccadilly\piccadilly_util::say_line_as_chatter_on_closest_ally(var1);
  }
}

function second_floor_player_watcher() {
  level endon("top left sniping done");
  var0 = ["dx_vom_s151_sting_exit_10", "dx_vom_s152_sting_exit_50", "dx_vom_uk53_sting_exit_90", "dx_vom_uk54_sting_exit_130"];
  var1 = ["dx_vom_s151_sting_exit_20", "dx_vom_s152_sting_exit_60", "dx_vom_uk53_sting_exit_100", "dx_vom_uk54_sting_exit_140"];
  var2 = ["dx_vom_s151_sting_exit_30", "dx_vom_s152_sting_exit_70", "dx_vom_uk53_sting_exit_110", "dx_vom_uk54_sting_exit_150"];
  var3 = ["dx_vom_s151_sting_exit_40", "dx_vom_s152_sting_exit_80", "dx_vom_uk53_sting_exit_120", "dx_vom_uk54_sting_exit_160"];
  var4 = [var0, var1, var2, var3];
  var5 = scripts\engine\sp\utility::create_deck(var4);

  for(;;) {
    scripts\engine\utility::flag_wait("player_upstairs_left");

    if(!scripts\engine\utility::flag("player_went_upstairs")) {
      scripts\engine\utility::flag_set("player_went_upstairs");
    }

    thread nag_get_downstairs(var5);
    scripts\engine\utility::flag_waitopen("player_upstairs_left");

    if(!isDefined(level.lastsavetime) || gettime() - level.lastsavetime > 5000) {
      scripts\engine\sp\utility::autosave_by_name("Downstairs");
    }
  }
}

function check_sting_is_clear() {
  scripts\engine\utility::flag_wait("player_upstairs_left");
  wait 1;
  var0 = undefined;

  foreach(var2 in getEntArray()) {
    if(isDefined(var2.script_flag) && var2.script_flag == "inside_sting_first_floor") {
      var0 = var2;
    }
  }

  var4 = 0;

  while(var4 < 0.8) {
    var5 = 0;

    foreach(var7 in getaiarray("axis")) {
      if(var7 istouching(var0)) {
        var4 = -0.5;
        break;
      }
    }

    var4 += 0.5;
    waitframe();
  }

  scripts\sp\maps\piccadilly\piccadilly_util::wait_combat_cooldown(0.8, 2);
  level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_sting_snipers_60", 1, 3);
}

function retreat_to_gap_sniping() {
  level endon("gap_bomber_dead");
  scripts\engine\utility::flag_wait("player_did_sniping");
  scripts\engine\utility::flag_wait("bus_rescue_over");
  var0 = gettime();
  var1 = level.player.stats["kills"];

  while(scripts\engine\utility::flag("player_did_sniping")) {
    if(gettime() - var0 > 7000) {
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

function center_guys_to_volume(var0, var1) {
  var2 = scripts\engine\sp\utility::get_ai_group_ai("center_defend");
  var3 = scripts\engine\sp\utility::get_ai_group_ai("center_reinforce");
  var2 = scripts\engine\utility::array_combine(var2, var3);
  var4 = getEnt(var0, "targetname");

  foreach(var6 in var2) {
    var6 setgoalvolumeauto(var4);
  }

  if(istrue(var1)) {
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var2, 600);
    return;
  }
}

function top_left_sight_checker() {
  scripts\engine\utility::flag_wait("top_left_sight_check");
  scripts\engine\sp\utility::activate_trigger_with_noteworthy("top_left_flood");
}

function sniper_backup_spawners() {
  scripts\engine\utility::flag_wait("player_upstairs_left");
  var0 = scripts\engine\sp\utility::get_ai_group_death_count("center_defend") + scripts\engine\sp\utility::get_ai_group_death_count("center_reinforce");
  var0 *= 0.75;
  var0 = int(var0);
  var1 = getspawnerarray("sniper_backup_guys");
  var2 = getEnt("center_left_fallback_vol", "targetname");
  var3 = var1.size;

  for(var4 = 0; var4 < var0; var4++) {
    var3--;

    if(var3 < 0) {
      var3 = var1.size - 1;
    }

    var5 = var1[var3] stalingradspawn();
    waitframe();
    var5 setgoalvolumeauto(var2);
  }
}

function left_side_cleanup() {
  level endon("right_side_cleanup");
  scripts\engine\utility::flag_wait("left_side_cleanup");
  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_targetname("right_to_ripleys_trig");
  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_targetname("subway_right_wave1_trig");
  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_targetname("right_bomber_1_trig");
  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_targetname("gap_bombers");
}

function right_side_combat() {
  level endon("spec_price_intro_start");
  scripts\engine\utility::flag_wait("right_side_looking");
  var0 = getspawnerarray("subway_right_wave1");
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::spawn_ai, 1);
  var1 = (317.5, -1614.5, 98.75);
  magicgrenademanual("frag", var1 + (0, 0, 10), var1, 0);
  var2 = (21.75, -1754.25, 133.4);
  var3 = (-513, -1103, 145);
  scripts\engine\utility::delaythread(0.6, &magicbullet_burst, var2, var3);
  scripts\engine\utility::delaythread(1, &magicbullet_burst, var2, var3);
  scripts\engine\sp\utility::waittill_ai_group_dead("subway_right");
  scripts\engine\utility::flag_wait("right_side_looking");

  if(level.player.origin[0] > -1100) {
    var4 = getspawner("right_side_bomber", "targetname");

    if(distance2d(level.player.origin, var4.origin) > 500) {
      var5 = 0;

      while(var5 < 3) {
        var6 = scripts\engine\sp\utility::spawn_targetname("right_side_bomber", 1);

        if(scripts\common\ai::spawn_failed(var6)) {
          var5++;
          scripts\sp\maps\piccadilly\piccadilly_util::make_room_for_ai();
          waitframe();
          continue;
        }

        thread right_side_bomber_track();
        thread vo_right_bomber_reaction(level);
        scripts\engine\sp\utility::waittill_dead_or_dying([var6]);
        break;
      }
    }
  }

  scripts\engine\utility::flag_wait("right_side_looking");
  var7 = scripts\engine\sp\utility::array_spawn_targetname("subway_right_wave2");

  if(isDefined(var7)) {
    scripts\engine\utility::array_thread(var7, &subway_right_wave2_logic);
    scripts\engine\sp\utility::waittill_dead_or_dying(var7);
  }

  if(scripts\engine\utility::flag("right_side_looking")) {
    thread cops_lead_to_underground_right();
    return;
  }
}

function subway_right_wave2_logic() {
  self endon("death");
  var0 = 0;

  while(istrue(self.using_goto_node)) {
    if(distance2dsquared(self.origin, level.player.origin) <= 250000) {
      var0 = 1;
    }

    if(scripts\engine\utility::is_equal(self.lastattacker, level.player)) {
      var0 = 1;
    }

    if(var0) {
      break;
    }

    wait 0.2;
  }

  if(!istrue(self.using_goto_node)) {
    return;
  }

  if(var0) {
    self notify("stop_going_to_node");
    self cleargoalvolume();

    if(scripts\engine\utility::is_equal(self.enemy, level.player)) {
      scripts\sp\maps\piccadilly\piccadilly_util::charge_enemy(4);
      return;
    }

    self setgoalpos(self.origin);
    self.goalradius = 500;
    return;
  }
}

function close_in_on_far_player() {
  self endon("death");
  wait 1;

  while(isalive(level.player) && distance2dsquared(self.origin, level.player.origin) < 810000) {
    wait 2;
  }

  self.goalradius = 800;
  self cleargoalvolume();

  for(;;) {
    if(self.goalradius > 350) {
      self.goalradius -= 50;
    }

    self setgoalpos(level.player.origin);
    wait 6 + randomint(3);
  }
}

function right_side_bomber_track() {
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

  scripts\sp\maps\piccadilly\piccadilly_util::get_closest_bomber_target();
}

function vo_right_bomber_reaction(var0) {
  wait 1;

  if(!isDefined(var0)) {
    return;
  }

  level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk51_sting_entrance_70", 1, 0.5);
  var0 waittill("detonated");
  wait 0.5;
  level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk51_sting_entrance_80", 1, 0.5);
}

function cops_lead_to_underground_right() {
  if(level.player.origin[0] < -10000 || level.player.origin[1] < -8400) {
    return;
  }

  var0 = [];
  var1 = spawn_cop_from_behind_player();

  if(isDefined(var1)) {
    var1.target = "underground_right_leader";
    var1.goalradius = 32;
    var1 thread scripts\sp\spawner::go_to_node();
    var0 = var1;
    waitframe();
  }

  var2 = spawn_cop_from_behind_player();

  if(isDefined(var2)) {
    var2.target = "police_leader2";
    var2.goalradius = 32;
    var2 thread scripts\sp\spawner::go_to_node();
    var0 = var2;
  }

  wait 15;
  var0 = scripts\engine\utility::array_removedead(var0);

  if(var0.size) {
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var0, 500);
    return;
  }
}

function spawn_cop_from_behind_player(var0) {
  var1 = getspawnerarray("obj_frontline");
  var2 = undefined;
  var3 = 0;
  var4 = undefined;

  for(;;) {
    foreach(var6 in var1) {
      if(!level.player scripts\engine\trace::can_see_origin(var6.origin, 0)) {
        var2 = var6;
        break;
      }
    }

    if(!isDefined(var2)) {
      wait 0.5;
      continue;
    }

    var4 = level.player.origin + anglesToForward(level.player.angles) * -60;
    var3 = scripts\engine\trace::capsule_trace_passed(level.player.origin, var4, 20, 60, level.player.angles, level.player);

    if(var3) {
      break;
    } else {
      wait 0.5;
      continue;
    }

    waitframe();
  }

  var8 = var2 stalingradspawn();

  if(!scripts\common\ai::spawn_failed(var8)) {
    var8.targetname = "";
    var8 scripts\engine\sp\utility::disable_ai_color();
    var8 forceteleport(var4, level.player.angles);
    return var8;
  }

  return undefined;
}

function do_death_sound() {
  self waittill("death");
  scripts\sp\maps\piccadilly\piccadilly_util::death_vo();
}

function right_subway_bg_fake_civs() {
  scripts\engine\utility::flag_wait("start_right_corner_civs");
  wait 3;
  var0 = getspawnerarray("right_subway_civs");

  for(var1 = 0; var1 < 2; var1++) {
    foreach(var3 in var0) {
      var4 = scripts\engine\sp\utility::fakeactorspawn(var3);
      thread fake_actor_think();
      wait randomfloatrange(0.2, 0.35);
    }

    wait randomfloatrange(0.5, 0.65);
  }
}

function fake_actor_think_kill(var0) {
  self endon("death");

  if(!isDefined(var0)) {
    self.ignoreme = 1;
    self freeentitysentient();
  }

  self waittill("reached_path_end");
  thread shot_in_back();
}

function fake_actor_random_death() {
  self endon("death");
  wait randomfloatrange(2.25, 5);
  thread shot_in_back();
}

function right_underground_bomber_runner_logic() {
  self endon("death");
  self.dontchatter = 1;
  wait 0.2;

  if(self.target == "pf2_auto2604") {
    scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm1_post_bomb_civ_bombers_20");
    scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm1_post_bomb_civ_bombers_10");
    return;
  }

  if(self.target == "pf2_auto2605") {
    wait 0.65;
    scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm2_post_bomb_civ_bombers_30");
    return;
  }
}

function delete_center_guys() {
  scripts\engine\utility::flag_wait("going_up_right");
  var0 = getaiarray("axis");
  var1 = getEnt("goal_center_left", "targetname");

  foreach(var3 in var0) {
    if(var3 istouching(var1)) {
      var3 kill();
    }
  }
}

function gap_right_combat() {
  scripts\engine\utility::flag_wait("final_bomber");
  waittill_player_look_bomber();
  var0 = getspawner("gap_bomber", "targetname");

  for(;;) {
    if(getaiarray().size > 25) {
      scripts\sp\maps\piccadilly\piccadilly_util::make_room_for_ai();
    }

    var1 = var0 scripts\engine\sp\utility::spawn_ai(1);

    if(isalive(var1)) {
      thread gap_bomber_logic();
      level.gap_bomber = var1;
      scripts\engine\utility::flag_set("spawn_gap_bomber");
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("spawn_gap_bomber");
  wait 1;
  level scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk52_sting_rear_tanto_20", 1);
}

function waittill_player_look_bomber() {
  level.player endon("death");
  var0 = 435600;

  while(distance2dsquared(level.player.origin, (170.5, 133.5, 174.75)) >= var0) {
    wait 0.25;
  }

  var1 = cos(45);
  var2 = 0;
  var3 = 20;

  for(;;) {
    if(distance2dsquared(level.player.origin, (170.5, 133.5, 174.75)) < 90000) {
      return;
    }

    if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), (170.5, 133.5, 174.75), var1)) {
      var2++;

      if(var2 == var3) {
        return;
      }
    } else {
      var2 = 0;
    }

    waitframe();
  }
}

function gap_bomber_logic() {
  self.ignoreme = 1;
  thread scripts\common\ai::magic_bullet_shield(1);
  self.dmg_from_player = 0;
  level.suicide_bomber_explode_func = &stop_bulletshield_wrapper;
  self.damage_functions[self.damage_functions.size] = &gap_bomber_dmg;
  scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::set_ignoreme, 0);
  scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::set_attackeraccuracy, 0);
  var0 = scripts\engine\utility::array_remove(getaiarray("axis"), self);

  if(var0.size) {
    var1 = sortbydistance(var0, self.origin)[0];

    if(distance2d(var1.origin, self.origin) < 70 && isalive(var1) && !scripts\anim\utility_common::player_can_see_ai(level.player, var1)) {
      if(isDefined(var1.magic_bullet_shield)) {
        var1 scripts\common\ai::stop_magic_bullet_shield();
      }

      var1 scripts\sp\utility::do_damage(var1.health + 10, var1 getEye());
    }
  }

  gap_bomber_internal();
  scripts\engine\utility::flag_set("gap_bomber_dead");
  scripts\engine\utility::delaythread(3, &scripts\engine\utility::exploder, "police_cars_fx");
  var2 = scripts\engine\sp\utility::get_ai_group_ai("left_snipers");

  if(var2.size) {
    foreach(var4 in var2) {
      if(scripts\engine\utility::is_equal(var4.combatmode, "cover_lmg")) {
        var4 scripts\engine\sp\utility::die();
      }
    }
  }

  wait 2.5;
  scripts\engine\sp\utility::activate_trigger_with_targetname("gap_stackup");
}

function gap_bomber_internal() {
  var0 = gap_bomber_detoantes();

  if(!isDefined(var0)) {
    return;
  }

  var1 = getscriptablearray("obj_frontline_cover", "targetname");
  var1 = sortbydistance(var1, var0);

  foreach(var3 in var1) {
    if(var4 == 0) {
      var3 setscriptablepartstate("body", "dead");
      waitframe();
      var3 setscriptablepartstate("Anim_Explosion", "rock", 1);
      continue;
    }

    wait 0.1;
    var3 setscriptablepartstate("Window_Blast", "destroyed");
    var3 setscriptablepartstate("body", "flareup");
  }

  var5 = getaiarray();

  foreach(var7 in var5) {
    if(isalive(var7) && distance2d(var7.origin, var0) < 300) {
      var7 scripts\sp\utility::do_damage(1000, var7.origin, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }
}

function gap_bomber_detoantes() {
  var0 = undefined;
  var1 = [];

  while(!isDefined(var0)) {
    var2 = getaiarray("allies");

    foreach(var4 in var2) {
      if(var4 istouching(level.goalvolumes["gap_street_front"])) {
        var1 = var4;
      }
    }

    if(!isalive(self)) {
      break;
    }

    if(var1.size) {
      var0 = sortbydistance(var1, self.origin)[0];
    }

    waitframe();
  }

  if(isalive(self) && !istrue(self.hasexploded)) {
    scripts\sp\maps\piccadilly\piccadilly_util::bomber_set_target(var0);
    self waittill("detonated");
  }

  if(isDefined(self.origin)) {
    return self.origin;
  }
}

function cops_die(var0) {
  wait 0.2;

  if(var0.size) {
    foreach(var2 in var0) {
      if(isalive(var2)) {
        var2 scripts\engine\sp\utility::die();
      }
    }

    return;
  }
}

function stop_bulletshield_wrapper(var0) {
  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
    return;
  }
}

function gap_bomber_dmg(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(istrue(self.hasexploded)) {
    return;
  }

  if(isDefined(var4) && isexplosivedamagemod(var4)) {
    return;
  }

  if(scripts\engine\utility::is_equal(var1, level.player)) {
    if(isDefined(var0)) {
      self.dmg_from_player += var0;

      if(self.dmg_from_player >= 400) {
        scripts\common\ai::stop_magic_bullet_shield();

        if(isalive(self)) {
          scripts\engine\sp\utility::die();
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function right_side_cleanup() {
  level endon("left_side_cleanup");
  scripts\engine\utility::flag_wait("right_side_cleanup");
  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_targetname("left_rear_flag");

  foreach(var1 in getEntArray("trigger_multiple_unlock", "classname")) {
    if(scripts\engine\utility::is_equal(var1.script_noteworthy, "left_store_guy_trig_unlock")) {
      var1 delete();
      break;
    }
  }

  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_targetname("store_guy_trig");
  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_targetname("sniper_spawn_trig");
  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_noteworthy("left_main_trig");
  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_noteworthy("top_left_flood");
}

function flag_waitopen_either(var0, var1) {
  for(;;) {
    if(!scripts\engine\utility::flag(var0)) {
      return;
    }

    if(!scripts\engine\utility::flag(var1)) {
      return;
    }

    level scripts\engine\utility::waittill_either(var0, var1);
  }
}

function shot_in_back(var0, var1) {
  self endon("death");
  var2 = self.origin + (0, 0, 40) + anglesToForward(self.angles) * -300;
  var3 = self.origin + (0, 0, 40) + anglesToForward(self.angles) * 300;
  thread magicbullet_burst(var2, var3, var0, var1);

  if(isDefined(var0)) {
    wait randomfloatrange(var0 + 0.25, var1 + 0.25);
  } else {
    wait 0.35;
  }

  if(isalive(self)) {
    self kill();
    return;
  }
}

function magicbullet_burst(var0, var1, var2, var3) {
  if(isDefined(var2)) {
    wait randomfloatrange(var2, var3);
  }

  var4 = randomintrange(6, 9);
  var5 = "iw8_ar_akilo47";

  for(var6 = 0; var6 < var4; var6++) {
    wait randomfloatrange(0.05, 0.15);
    var7 = scripts\sp\player\bullet_feedback::get_whizby_fx_from_weapon(var5);
    var1 += scripts\engine\utility::randomvector(5);
    magicbullet(var5, var0, var1);
    var8 = vectortoangles(var1 - var0);
    playFX(level._effect[var7], var1, anglesToForward(var8));
  }
}

function police_arrive_car_firstframe(var0) {
  scripts\sp\maps\piccadilly\piccadilly_util::use_scriptables_animtree();
  var1 = getstartorigin(var0.origin, var0.angles, %lon_pic_020_cops_arrive_veh01);
  var2 = getstartangles(var0.origin, var0.angles, $lon_pic_020_cops_arrive_veh01);
  self.origin = var1;
  self.angles = var2;
}

function police_car_set_animrate(var0) {
  self setflaggedanimknoball("single anim", %lon_pic_020_cops_arrive_veh01, %root, 1, 0, var0);
}

function police_car_set_animtime(var0) {
  self setflaggedanimknoball("single anim", %lon_pic_020_cops_arrive_veh01, %root, 1, 0, 10);

  while(self getanimtime(%lon_pic_020_cops_arrive_veh01) < var0) {
    waitframe();
  }

  self setflaggedanimknoball("single anim", %lon_pic_020_cops_arrive_veh01, %root, 1, 0, 1);
}

function scriptable_clearanim(var0) {
  if(isDefined(var0)) {
    self clearanim(var0, 0);
    return;
  }

  self clearanim(%root, 0);
}