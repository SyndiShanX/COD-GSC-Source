/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\estate\estate_grounds.gsc
*****************************************************/

function estate_grounds_precache() {
  precachemodel("com_folding_chair");
  precachemodel("ee_electric_cattle_prod_01");
  precachemodel("zip_tie_handcuffs_wm");
  precachemodel("head_sc_m_kamalov_damage");
  precachemodel("head_sc_m_florian");
  precachemodel("head_sc_m_thompson");
  precachemodel("building_horse_stall_wood_beam_01");
  precachemodel("ee_manmade_wood_planks_worn_a_06");
  precachemodel("ee_wainscot_bottom_112_01");
}

function estate_grounds_flags() {
  scripts\engine\utility::flag_init("grounds_init_complete");
  scripts\engine\utility::flag_init("scriptables_init_complete");
  scripts\engine\utility::flag_init("player_has_overwatch");
  scripts\engine\utility::flag_init("player_in_combat");
  scripts\engine\utility::flag_init("player_gone_hot");
  scripts\engine\utility::flag_init("church_hvt_checked");
  scripts\engine\utility::flag_init("courtyard_hvt_checked");
  scripts\engine\utility::flag_init("pool_hvt_checked");
  scripts\engine\utility::flag_init("hvt_found");
  scripts\engine\utility::flag_init("technical_called");
  scripts\engine\utility::flag_init("technical_go");
  scripts\engine\utility::flag_init("technical_sfx_playing");
  scripts\engine\utility::flag_init("church_gone_hot");
  scripts\engine\utility::flag_init("courtyard_gone_hot");
  scripts\engine\utility::flag_init("pool_gone_hot");
  scripts\engine\utility::flag_init("church_under_attack");
  scripts\engine\utility::flag_init("church_backup_spawned");
  scripts\engine\utility::flag_init("courtyard_under_attack");
  scripts\engine\utility::flag_init("courtyard_backup_spawned");
  scripts\engine\utility::flag_init("mansion_under_attack");
  scripts\engine\utility::flag_init("mansion_backup_spawned");
  scripts\engine\utility::flag_init("pool_under_attack");
  scripts\engine\utility::flag_init("pool_backup_spawned");
  scripts\engine\utility::flag_init("floodlights_on");
  scripts\engine\utility::flag_init("thirdfloor_in_combat");
  scripts\engine\utility::flag_init("met_up_with_price");
  scripts\engine\utility::flag_init("door_opened");
}

function find_hvt_1_start() {
  scripts\engine\sp\utility::set_start_location("grounds_start", [level.player]);
}

function find_hvt_2_start() {
  var_0 = strtok(getDvar("scr_est_hvtsChecked"), " ");

  if(!var_0.size) {
    var_0 = [scripts\engine\utility::random(["church", "courtyard", "pool"])];
  } else if(var_0.size > 1) {
    var_0 = [var_0[0]];
  }

  thread find_hvt_jump_to_start(var_0);
}

function find_hvt_3_start() {
  var_0 = strtok(getDvar("scr_est_hvtsChecked"), " ");

  if(!var_0.size) {
    var_0 = scripts\engine\utility::array_remove_index(scripts\engine\utility::array_randomize(["church", "courtyard", "pool"]), 2);
  } else if(var_0.size > 2) {
    var_0 = [var_0[0], var_0[1]];
  }

  thread find_hvt_jump_to_start(var_0);
}

function find_hvt_jump_to_start(var_0) {
  scripts\engine\utility::flag_wait("grounds_init_complete");

  foreach(var_2 in var_0) {
    foreach(var_4 in level.stealth_areas[var_2].spawners) {
      if(var_10 == var_0.size - 1 && scripts\engine\utility::is_equal(var_4.script_noteworthy, "escalation_patroller")) {
        continue;
      }

      if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "interrogator")) {
        continue;
      }

      var_4.count = 0;
    }

    var_6 = scripts\engine\sp\utility::spawn_targetname(var_2 + "_interrogator_spawner", 1);
    level.hvts_seen++;
    var_7 = level.hvts[var_2];
    check_hvt(var_7);
    var_6 kill();
    thread hvt_death_post_interact();

    if(var_10 == var_0.size - 1) {
      var_8 = var_7.origin + anglesToForward(var_7.angles) * 60;
      var_9 = vectortoangles(var_7.origin - var_8);
      level.player setOrigin(var_8, 1);
      level.player setplayerangles(var_9);
      thread vo_identify_hvt();
      level.player scripts\engine\utility::delaythread(0.05, &scripts\engine\utility::send_notify, "identify_anim_complete");
    }
  }
}

function find_hvt_main() {
  scripts\sp\analytics::analytics_skip_start_point();
  scripts\engine\utility::delaythread(2, &scripts\engine\sp\utility::autosave_by_name, "grounds_start");
  init_grounds();
  thread gl_audio_hooks();

  if(!scripts\sp\starts::is_after_start("find_hvt_1")) {
    thread request_overwatch_vo("objective", "dx_vom_pri_rappel_danger_10", 1, 1, undefined, 2);
    thread scripts\engine\sp\utility::array_spawn_targetname("pool_east_spawner", 1);
    thread scripts\engine\sp\utility::array_spawn_targetname("courtyard_north_spawner", 1);
  }

  thread music_post_rappel_waiting();
  thread spawn_technical();
  scripts\engine\utility::flag_wait("hvt_found");
  overwatch_cleanup();
}

function music_post_rappel_waiting() {
  wait 0.1;
  setmusicstate("mx_tmp_estate_grounds_infil");
  thread music_post_rappel_stop_after_a_while();
}

function music_post_rappel_stop_after_a_while() {
  level.player endon("entered_combat");
  wait 45;
  setmusicstate("");
}

function find_hvt_catchup() {
  scripts\engine\utility::flag_set("hvt_found");
  scripts\engine\sp\objectives::objective_complete("church_hvt");
  scripts\engine\sp\objectives::objective_complete("courtyard_hvt");
  scripts\engine\sp\objectives::objective_complete("pool_hvt");
  var_0 = scripts\engine\utility::getStructArray("hvt", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::get_linked_ents()[0];

    if(isDefined(var_3)) {
      var_3 delete();
    }
  }
}

function open_door_start() {
  scripts\engine\sp\utility::set_start_location("grounds_start", [level.player]);
  scripts\engine\utility::flag_set("hvt_found");
  init_grounds();
  level.hvts_identified = 3;
  escalate_grounds_to_hunt();
  level scripts\engine\utility::delaythread(2, &scripts\engine\sp\utility::smart_radio_dialogue, "dx_vom_pri_hvt_correct_100");
}

function open_door_main() {
  scripts\engine\sp\objectives::objective_add("mansion", "current");
  thread delete_mansion_spawners();
  thread mansion_escalation_spawn_think();
  thread mansion_waypoint_think();
  thread floodlights_think();
  thread position_price();
  thread meet_price();
  scripts\engine\utility::flag_wait("player_on_stairs");
  var_0 = scripts\engine\utility::getStruct("obj_interact", "targetname");
  scripts\engine\sp\objectives::objective_set_position("mansion", var_0.origin + (0, 0, 10));
  scripts\engine\utility::flag_wait("player_on_third_floor");
  setmusicstate("");
  mansion_waypoint_cleanup();
  scripts\engine\sp\objectives::objective_set_label("mansion", &"ESTATE/OBJ_LBL_OPEN_DOOR");
}

function delete_mansion_spawners() {
  foreach(var_1 in getaiarray("axis")) {
    if(scripts\engine\utility::is_equal(var_1.area, "mansion") || scripts\engine\utility::is_equal(var_1.script_noteworthy, "escalation_patroller")) {
      var_1 delete();
    }
  }

  foreach(var_4 in ["mansion_south_spawner", "mansion_firstfloor_spawner", "mansion_secondfloor_spawner"]) {
    var_5 = getspawnerarray(var_4);

    foreach(var_7 in var_5) {
      var_7 delete();
    }

    var_9 = getEnt(var_4, "target");
    var_9 delete();
  }
}

function mansion_escalation_spawn_think() {
  var_0 = getspawnerarray("mansion_escalation_spawner");

  if(level.player istouching(level.interior_volumes["pool"])) {
    var_0 = scripts\engine\utility::array_combine(var_0, getspawnerarray("mansion_escalation_spawner_back"));
  } else {
    var_0 = scripts\engine\utility::array_combine(var_0, getspawnerarray("mansion_escalation_spawner_front"));
  }

  scripts\engine\utility::array_thread(var_0, &scripts\engine\sp\utility::add_spawn_function, &mansion_escalation_spawnfunc);
  var_1 = scripts\engine\utility::getclosest(level.player.origin, var_0);
  var_2 = scripts\engine\sp\utility::getfarthest(level.player.origin, var_0);
  var_3 = (var_1.origin + var_2.origin) / 2;

  for(var_4 = 0; var_0.size > 0; var_4 = 0) {
    if(var_0.size == 1) {
      var_5 = var_0[0];
    } else if(var_4 == 0) {
      var_5 = scripts\engine\utility::getclosest(level.player.origin, var_0);
    } else if(var_4 == 2) {
      var_5 = scripts\engine\sp\utility::getfarthest(level.player.origin, var_0);
    } else {
      var_5 = scripts\engine\utility::getclosest(var_3, var_0);
    }

    var_5 thread scripts\engine\sp\utility::spawn_ai();
    var_0 = scripts\engine\utility::array_remove(var_0, var_5);
    var_4++;

    if(var_4 > 2) {}
  }

  thread vo_mansion_escalation();
}

function mansion_escalation_spawnfunc() {
  self.reacttodynolightsinhunt = 1;
  scripts\sp\utility::enable_flashlight(0);

  if(!isDefined(level.mansion_escalation_guys)) {
    level.mansion_escalation_guys = [self];
    return;
  }

  level.mansion_escalation_guys[level.mansion_escalation_guys.size] = self;
}

function vo_mansion_escalation() {
  level endon("keypad_interact");
  level waittill("floodlights_active");

  if(scripts\engine\utility::flag("player_in_combat")) {
    return;
  }

  level endon("player_in_combat");

  for(;;) {
    waitframe();
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    level.mansion_escalation_guys = scripts\engine\utility::array_removedead_or_dying(level.mansion_escalation_guys);
    var_0 = scripts\engine\utility::get_array_of_closest(level.player.origin, level.mansion_escalation_guys, undefined, 4, 1000);

    if(var_0.size != 4) {
      continue;
    }

    foreach(var_2 in var_0) {
      var_2 endon("death");
      var_2 endon("stealth_combat");
      var_2 scripts\engine\utility::thread_on_notify("stealth_combat", &scripts\engine\sp\utility::set_battlechatter, 1);
    }

    scripts\engine\utility::array_thread(var_0, &scripts\engine\sp\utility::set_battlechatter, 0);

    foreach(var_5 in get_escalation_aliases("mansion", scripts\engine\utility::ter_op(scripts\engine\utility::flag("player_gone_hot"), "combat", "stealth"))) {
      if(isPlayer(var_5[0])) {
        var_6 = (0, 0, 0);

        foreach(var_2 in var_0) {
          var_6 += var_2.origin;
        }

        var_6 /= var_0.size;

        if(distance2dsquared(level.player.origin, var_6) < squared(800)) {
          level.player thread scripts\engine\sp\utility::smart_player_dialogue(var_5[1]);
        }

        continue;
      }

      var_9 = var_0[var_5[0]];
      var_9 thread scripts\engine\sp\utility::smart_dialogue_generic(var_5[1]);
      var_9 waittill("single dialogue");
      wait randomfloatrange(0.25, 0.5);
    }

    scripts\engine\utility::array_thread(var_0, &scripts\engine\sp\utility::set_battlechatter, 1);
    return;
  }
}

function mansion_waypoint_think() {
  level endon("player_on_stairs");
  scripts\sp\maps\estate\estate_util::make_alias_group("mansion_nags", ["dx_vom_pri_goto_obj_mansion_70", "dx_vom_pri_goto_obj_mansion_80", "dx_vom_pri_goto_obj_mansion_90"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("thirdfloor_nags", ["dx_vom_pri_goto_obj_mansion_40", "dx_vom_pri_goto_obj_mansion_50", "dx_vom_pri_goto_obj_mansion_60"]);
  var_0 = 0;

  for(;;) {
    scripts\engine\sp\objectives::objective_set_label("mansion", &"ESTATE/OBJ_LBL_ENTER_MANSION");
    var_1 = scripts\engine\utility::getStructArray("mansion_entry_waypoint", "targetname");
    var_2 = scripts\engine\utility::getclosest(level.player.origin, var_1);
    scripts\engine\sp\objectives::objective_set_position("mansion", var_2.origin);
    var_3 = gettime();

    while(!level.player istouching(level.interior_volumes["mansion"])) {
      if(!scripts\engine\utility::flag("floodlights_on") && !scripts\engine\utility::flag("stealth_spotted") && scripts\engine\utility::time_has_passed(var_3, 60)) {
        level.player scripts\engine\sp\utility::smart_radio_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("mansion_nags"));
        var_3 = gettime();
      }

      var_4 = scripts\engine\utility::getclosest(level.player.origin, var_1);

      if(var_2 != var_4) {
        scripts\engine\sp\objectives::objective_set_position("mansion", var_4.origin);
        var_2 = var_4;
      }

      waitframe();
    }

    scripts\engine\sp\objectives::objective_set_label("mansion", &"ESTATE/OBJ_LBL_THIRD_FLOOR");
    var_3 = gettime();
    var_5 = scripts\engine\utility::flag("stealth_spotted");

    while(level.player istouching(level.interior_volumes["mansion"])) {
      if(!var_0) {
        GscBinSkip4(0x35);
      }

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        if(var_5) {
          var_3 = gettime();
        } else if(scripts\engine\utility::time_has_passed(var_3, 20)) {
          level.player childthread scripts\engine\sp\utility::smart_radio_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("thirdfloor_nags"));
          var_3 = gettime();
        }
      }

      var_5 = scripts\engine\utility::flag("stealth_spotted");

      if(level.player.origin[2] < 240 && !scripts\engine\utility::flag("player_on_secondfloor_stairs")) {
        var_1 = scripts\engine\utility::getStructArray("mansion_secondfloor_waypoint", "targetname");
      } else {
        var_1 = scripts\engine\utility::getStructArray("mansion_thirdfloor_waypoint", "targetname");
      }

      var_4 = scripts\engine\utility::getclosest(level.player.origin, var_1);

      if(var_2 != var_4) {
        scripts\engine\sp\objectives::objective_set_position("mansion", var_4.origin);
        var_2 = var_4;
      }

      waitframe();
    }
  }
}

function vo_player_in_mansion() {
  level endon("player_on_stairs");

  if(scripts\engine\utility::flag("stealth_spotted")) {
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    level.player scripts\sp\maps\estate\estate_util::kyle_line("dx_vom_kyle_goto_obj_mansion_20");
  } else {
    level.player scripts\sp\maps\estate\estate_util::kyle_line("dx_vom_kyle_goto_obj_mansion_10");
  }

  level.player scripts\engine\sp\utility::smart_radio_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("thirdfloor_nags"));
}

function mansion_waypoint_cleanup() {
  scripts\sp\maps\estate\estate_util::clear_alias_group("mansion_nags");
  scripts\sp\maps\estate\estate_util::clear_alias_group("thirdfloor_nags");
}

function floodlights_think() {
  scripts\engine\utility::flag_wait("floodlights_start");
  var_0 = getscriptablearray("downstairs", "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3 getscriptablepartstate("onoff") == "on") {
      var_1 = 1;
      break;
    }
  }

  if(var_1) {
    wait 0.85;
    thread mansion_lights_off_audio();

    foreach(var_6 in getaiarray("axis")) {
      var_7 = undefined;

      if(isDefined(var_6.stealth.funcs) && isDefined(var_6.stealth.funcs["event_cover_blown"])) {
        var_7 = var_6.stealth.funcs["event_cover_blown"];
      }

      var_6 scripts\stealth\utility::set_stealth_func("event_cover_blown", &floodlights_stealth_filter);
      var_6 scripts\engine\utility::delaythread(0.1, &scripts\stealth\utility::set_stealth_func, "event_cover_blown", var_7);
    }

    turn_off_mansion_lights();
    wait 0.5;

    foreach(var_3 in var_0) {
      var_3 stopsounds();
    }

    waitframe();
  }

  var_11 = getscriptablearray("mansionfloodlights", "targetname");
  var_11 = scripts\engine\utility::array_combine(var_11, getscriptablearray("floodlight", "script_noteworthy"));
  var_12 = 0;

  foreach(var_3 in var_11) {
    if(var_3 getscriptablepartstate("onoff") == "off") {
      var_12 = 1;
      break;
    }
  }

  if(var_12) {
    wait 1.5;
    thread floodlights_on_audio();
    scripts\sp\maps\estate\estate_util::turn_on_floodlights();
    level notify("floodlights_active");
    wait 1;
    level.player thread scripts\engine\sp\utility::function_stack(&scripts\engine\sp\utility::smart_radio_dialogue, "dx_vom_pri_goto_obj_floodlights_10");
    level.player thread scripts\engine\sp\utility::function_stack(&scripts\sp\maps\estate\estate_util::kyle_line, "dx_vom_kyle_goto_obj_floodlights_30");
  }

  scripts\engine\utility::flag_set("floodlights_on");
  thread nvg_overblown_hint();
  thread floodlights_death_hint();
}

function mansion_lights_off_audio() {
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (965, 3597, 190));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (1048, 3415, 266));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (933, 2908, 113));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (380, 3016, 136));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (26, 3005, 136));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (-169, 2949, 170));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (-727, 3080, 145));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (-990, 3216, 113));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (-983, 3585, 154));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (-727, 3839, 101));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (-336, 3764, 101));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (372, 3665, 153));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_off", (752, 3728, 153));
  wait 0.05;
}

function floodlights_on_audio() {
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_on", (-952, 2197, 404));
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_on", (661, 2368, 404));
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_on", (1625, 4102, 404));
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_on", (974, 4118, 404));
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_on", (-236, 4292, 310));
  thread scripts\engine\utility::play_sound_in_space("estate_light_turn_on", (-1305, 4136, 340));
}

function floodlights_stealth_filter(var_0) {
  if(scripts\engine\utility::is_equal(var_0.typeorig, "light_killed")) {
    return 1;
  }

  return scripts\sp\maps\estate\estate_util::axis_stealth_filter(var_0);
}

function turn_off_mansion_lights() {
  foreach(var_1 in level.fuseboxes) {
    if(scripts\engine\utility::is_equal(var_1.target, "downstairs")) {
      if(var_1.script_light_switch_state) {
        var_1.noachievement = 1;
        var_1 scripts\sp\interactables\dynolight::lightswitch_toggle();
      }

      var_1 scripts\sp\interactables\dynolight::lightswitch_disable(1);
      return;
    }
  }
}

function floodlights_death_hint() {
  level endon("door_opened");
  level.player waittill("death");

  if(level.player.blowout > 0.5 && scripts\sp\nvg\nvg_player::is_nvg_on()) {
    scripts\sp\player_death::set_custom_death_quote(31);
    return;
  }
}

function nvg_overblown_hint() {
  level endon("window_spotlight_sweep_done");
  level.player endon("death");
  var_0 = 5;
  var_1 = 0;

  for(;;) {
    if(level.player.blowout > 0.5 && scripts\sp\nvg\nvg_player::is_nvg_on()) {
      var_1++;

      if(var_1 == var_0 * 20) {
        thread scripts\sp\nvg\nvg_player::nvg_off_hint(6);
        return;
      }
    } else {
      var_1 = 0;
    }

    waitframe();
  }
}

function position_price() {
  while(!level.player istouching(level.interior_volumes["mansion"])) {
    waitframe();
  }

  if(!isDefined(level.price)) {
    scripts\sp\maps\estate\estate_util::spawn_price();
  }

  level.price.pushable = 0;
  level.price scripts\engine\sp\utility::set_battlechatter(0);
  var_0 = getnode("price_at_door", "targetname");
  level.price forceteleport(var_0.origin, var_0.angles);
  level.price setgoalnode(var_0);
  level.price.goalradius = 32;
  level.price thread scripts\common\anim::anim_loop_solo(level.price, "obj_idle_no_nags", "stop_loop_price");
}

function meet_price() {
  level endon("keypad_interact");
  scripts\engine\utility::flag_wait("player_on_stairs");

  if(scripts\engine\utility::flag("stealth_spotted")) {
    level.player scripts\engine\sp\utility::player_dialogue_stop();
    level.player scripts\sp\maps\estate\estate_util::kyle_line("dx_vom_kyle_goto_obj_meetup_30");
    level.player scripts\engine\sp\utility::smart_radio_dialogue_interrupt("dx_vom_pri_goto_obj_meetup_40");
  } else {
    level.player scripts\engine\sp\utility::player_dialogue_stop();
    level.player scripts\sp\maps\estate\estate_util::kyle_line("dx_vom_kyle_goto_obj_meetup_10");
    level.player scripts\engine\sp\utility::smart_radio_dialogue_interrupt("dx_vom_pri_goto_obj_meetup_20");
  }

  scripts\engine\utility::flag_wait("player_on_third_floor");
  level.price scripts\common\utility::lookatentity(level.player);
  level.price scripts\engine\sp\utility::waittill_player_lookat(0.5, undefined, undefined, 5, level.price);

  if(!level.price scripts\sp\maps\estate\estate_util::can_i_see_an_enemy_or_can_enemies_see_me()) {
    scripts\engine\sp\utility::autosave_by_name("player_on_third_floor");
  } else {
    level.price scripts\common\utility::lookatentity();
    level.price notify("stop_loop_price");
    level.price scripts\engine\sp\utility::anim_stopanimScripted();
  }

  scripts\engine\utility::flag_set("met_up_with_price");
}

function open_door_catchup() {
  scripts\engine\utility::delaythread(0.1, &turn_off_mansion_lights);

  if(!scripts\sp\starts::is_after_start("obj_room")) {
    scripts\engine\utility::delaythread(0.2, &scripts\sp\maps\estate\estate_util::turn_on_floodlights);
    setup_keypad();
  }

  if(!scripts\sp\starts::is_after_start("heli_attack")) {
    setup_player_door_wedge();
  }

  thread scripts\sp\door::double_doors_init_targetname("courtyard_dbl");
  thread scripts\sp\door::double_doors_init_targetname("mansion_dbl");
  setup_tunnel();
  thread scriptables_init();
  var_0 = scripts\engine\utility::getStruct("obj_interact", "targetname");
  scripts\engine\sp\objectives::objective_add("mansion", "current", var_0.origin + (0, 0, 10), undefined, &"ESTATE/OBJ_LBL_OPEN_DOOR");
  scripts\engine\utility::flag_set("met_up_with_price");
}

function init_grounds() {
  scripts\engine\sp\utility::add_global_spawn_function("axis", &grounds_axis_spawnfunc);
  var_0 = scripts\engine\utility::getStructArray("landmark", "targetname");
  level.landmarks = [];

  foreach(var_2 in var_0) {
    var_2.location = var_2.script_noteworthy;
    var_2.volume = getEnt(var_2.target, "targetname");
    var_2.fusebox = scripts\engine\utility::getclosest(var_2.origin, level.fuseboxes);
    level.landmarks[var_2.location] = var_2;
  }

  foreach(var_5 in getEntArray("waypoint_volume", "targetname")) {
    level.landmarks[var_5.script_noteworthy].waypoint_volume = var_5;
  }

  foreach(var_8 in getEntArray("extra_patrol_spawn_trigger", "targetname")) {
    level.extra_patrol_triggers[var_8.script_noteworthy] = var_8;
    var_8 scripts\engine\utility::trigger_off();
    var_8 scripts\engine\sp\utility::add_trigger_function(&vo_extra_patrols);
  }

  thread checkpoints_think();
  thread indoor_sfx_think();
  thread indoor_event_dists();
  thread init_stealth_areas();
  thread stealth_event_propagator();
  thread player_gone_hot_think();
  thread molotovs_damage_hvts();
  thread obj_door_interact();
  thread nade_triggers_init();
  thread update_vfx_shadow_limit();
  init_escalation();
  thread scripts\sp\door::double_doors_init_targetname("courtyard_dbl");
  thread scripts\sp\door::double_doors_init_targetname("mansion_dbl");

  if(!scripts\engine\utility::flag("hvt_found")) {
    level.hvts_seen = 0;
    level.hvt_trace_contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1, 0, 1, 0);
    level.hvts_identified = 0;
    level.hvt_locations = ["church", "courtyard", "pool"];

    foreach(var_2 in scripts\engine\utility::getStructArray("hvt", "targetname")) {
      level.hvt_structs[var_2.script_noteworthy] = var_2;
    }

    scripts\engine\utility::array_thread(level.hvt_structs, &spawn_hvt);
  } else {
    level.hvts_identified = 3;
    level.hvt_locations = [];
  }

  scripts\sp\maps\estate\estate_util::make_alias_group("fusebox_call", ["dx_vom_aq1_aqmisc_fuse_10", "dx_vom_aq1_aqmisc_fuse_30", "dx_vom_aq1_aqmisc_fuse_50", "dx_vom_aq2_aqmisc_fuse_70"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("fusebox_response", ["dx_vom_aq2_aqmisc_fuse_20", "dx_vom_aq2_aqmisc_fuse_40", "dx_vom_aq2_aqmisc_fuse_60", "dx_vom_aq3_aqmisc_fuse_80"]);

  foreach(var_13 in level.fuseboxes) {
    if(isDefined(var_13.script_parameters)) {
      thread fusebox_switchoff_think();
    }
  }

  thread body_drag_door_scene();
  thread setup_grounds_dumpster_scene();
  thread car_rummage_scene("l");
  thread car_rummage_scene("r");
  var_15 = scripts\engine\utility::getStructArray("body_poke_scene", "targetname");

  foreach(var_2 in var_15) {
    thread body_poke_scene();
  }

  setup_search_anims();
  setup_keypad();
  setup_player_door_wedge();
  setup_tunnel();
  patch_mansion_holes();
  thread scriptables_init();
  thread scripts\sp\maps\estate\estate_util::ownthenight_achievement_think();

  if(!scripts\engine\utility::flag("hvt_found")) {
    init_overwatch(level.player);
  }

  scripts\engine\utility::flag_set("grounds_init_complete");
}

function player_gone_hot_think() {
  level endon("obj_scene_started");
  GscBinSkip4(0x35);
}

function callout_player_gone_hot() {
  if(scripts\engine\utility::flag("hvt_found")) {
    return;
  }

  level endon("hvt_found");
  scripts\engine\utility::flag_wait("player_gone_hot");
  scripts\sp\maps\estate\estate_util::waittill_player_hidden();
  thread request_overwatch_vo("escalation", "dx_vom_pri_hvt_combat1_60", 1, 1, undefined, 1);
}

function setup_keypad() {
  var_0 = getEnt("obj_door", "targetname");
  var_1 = var_0 scripts\engine\utility::get_linked_ent();
  var_1.fx = scripts\engine\utility::spawn_tag_origin(var_1.origin - rotatevector((0.5, 0, 0), var_1.angles) + (0, 0, 1.1), var_1.angles + (0, 180, 0));
  var_1.fx linkTo(var_1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_estate_keypad_light_red"), var_1.fx, "tag_origin");
}

function setup_player_door_wedge() {
  var_0 = getEnt("player_door_wedge", "targetname");
  var_0 notsolid();
}

function setup_tunnel() {
  var_0 = getEnt("tunnel_clip", "targetname");
  var_0 disconnectPaths();
  scripts\sp\maps\estate\estate_util::hide_ents("tunnel_destruction");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("gate_chain");
  var_1.targetname = "tunnel_chain";
  var_2 = scripts\engine\utility::getStruct("tunnel_animnode", "targetname");
  var_2 thread scripts\common\anim::anim_first_frame_solo(var_1, "tunnel_open");
}

function patch_mansion_holes() {
  var_0 = spawn("script_model", (-405.5, 3043.5, 241));
  var_0 setModel("building_horse_stall_wood_beam_01");
  var_0.angles = (270, 180, 90);
  var_0 = spawn("script_model", (-404, 3044, 245));
  var_0 setModel("ee_manmade_wood_planks_worn_a_06");
  var_0.angles = (0, 270, 90);
  var_0 = spawn("script_model", (-595.5, 3489.97, 249.48));
  var_0 setModel("ee_wainscot_bottom_112_01");
  var_0.angles = (90, 90, -90);
  var_0 = spawn("script_model", (-595.5, 3601.97, 249.48));
  var_0 setModel("ee_wainscot_bottom_112_01");
  var_0.angles = (90, 90, -90);
}

function scriptables_init() {
  wait 0.15;
  var_0 = getscriptablearray();
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_1++;

    if(var_1 % 10 == 0) {
      waitframe();
    }

    if(!isDefined(var_3)) {
      continue;
    }

    if(issubstr(var_3.classname, "veh8")) {
      if(!var_3 getscriptablehaspart("car_alarm")) {
        continue;
      }

      if(!isDefined(var_3.script_noteworthy) || var_3.script_noteworthy == "car_alarm") {
        var_3.script_noteworthy = "car_alarm";
        thread car_alarm_think();
      }

      continue;
    }

    if(var_3.classname == "scriptable_un_office_computer_monitor_03_ent") {
      setsaveddvar("MMRNLMPPLT", "0");
      cinematicingameloop("sp_estate_labvideo", 1);
      var_3 setscriptablepartstate("controller", "full");
      var_3.origin = (352, 3090.5, 489);
      var_3.angles = (0, 38.148, 0);
      continue;
    }

    if(isDefined(var_3.targetname) && isendstr(var_3.targetname, "fall_chandelier")) {
      var_3 hide();
      var_3 setCanDamage(0);
    }
  }

  scripts\common\rockable_vehicles::alarm_cars_init();
  scripts\engine\utility::flag_set("scriptables_init_complete");
}

function car_alarm_think() {
  self endon("death");

  for(;;) {
    if(self getscriptablepartstate("car_alarm") == "on") {
      break;
    }

    wait 0.1;
  }

  if(scripts\engine\utility::flag("stealth_enabled")) {
    scripts\stealth\event::event_broadcast_generic("cover_blown", self.origin, 1500);
  }

  level scripts\engine\utility::waittill_notify_or_timeout("tunnel_collapse", 15);
  self setscriptablepartstate("car_alarm", "off");
}

function gl_audio_hooks() {
  if(getdvarint("greenlight")) {
    thread player_enters_poolhouse();
    scripts\engine\utility::flag_wait("pool_patroller_go");
    var_0 = scripts\stealth\utility::get_group("pool_interior");
    var_1 = scripts\stealth\utility::get_group("pool_interrogator");
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
    scripts\engine\sp\utility::waittill_dead(var_2);
    return;
  }
}

function post_hvt_fadeout() {
  level.player endon("entered_combat");
  wait 35;
  setmusicstate("");
}

function player_enters_poolhouse() {}

function checkpoints_think() {
  level endon("door_opened");
  level.player endon("death");

  if(!isDefined(level.curautosave)) {
    level.curautosave = 1;
  }

  var_0 = 3;

  for(;;) {
    level scripts\engine\utility::waittill_notify_or_timeout("grounds_save", 15);
    var_1 = level.curautosave;

    while(var_1 == level.curautosave) {
      scripts\engine\sp\utility::autosave_or_timeout("estate_grounds", var_0);
      wait var_0;
    }
  }
}

function molotovs_damage_hvts() {
  level endon("obj_scene_started");

  for(;;) {
    level waittill("molotov_impact", var_0, var_1);

    if(!isDefined(level.hvts)) {
      continue;
    }

    foreach(var_3 in level.hvts) {
      if(distancesquared(var_3.origin, var_1) > squared(64)) {
        continue;
      }

      if(istrue(var_3.dead)) {
        var_3 setModel("burntbody_male");
        continue;
      }

      var_3.health -= 1000;
      var_3 notify("damage", 1000, var_0, undefined, var_1, "MOD_FIRE");
    }
  }
}

function indoor_sfx_think() {
  level.player endon("death");
  level endon("floodlights_start");
  GscBinSkip1(0x45, "footsteps", ["estate_rummaging_footsteps_fast", "estate_rummaging_footsteps_slow"]);
}

function indoor_event_dists() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("stealth_enabled");
  var_0 = level.stealth.ai_event;
  GscBinSkip1(0x45, "ai_eventDistFootstepSprint", "spotted", 200);
}

function update_event_dists(var_0, var_1) {
  level endon("stealth_enabled");

  for(;;) {
    level.player scripts\engine\utility::ent_flag_wait("indoors");
    scripts\stealth\manager::set_custom_distances(var_0);
    level.player scripts\engine\utility::ent_flag_waitopen("indoors");
    scripts\stealth\manager::set_custom_distances(var_1);
  }
}

function obj_door_interact() {
  if(scripts\engine\utility::flag("hvt_found")) {
    return;
  }

  var_0 = scripts\engine\utility::getStruct("obj_door_handle", "targetname");
  var_0 thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SCRIPT/DOOR_HINT_USE_NO_BASH");
  var_0 thread scripts\sp\maps\estate\estate_util::door_interact_presentation();
  level scripts\engine\utility::waittill_any("hvt_found", "player_tried_door");

  if(scripts\engine\utility::flag("hvt_found")) {
    var_0 scripts\sp\player\cursor_hint::remove_cursor_hint();
    return;
  }

  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_obj_room_earlydoor_10");
}

function nade_triggers_init() {
  level endon("obj_scene_started");
  var_0 = getEntArray("nade_closet", "targetname");
  var_1 = var_0;
  var_3 = getfirstarraykey(var_1);

  if(isDefined(var_3)) {
    var_2 = var_1[var_3];
    GscBinSkip4(0x6e, var_2);
  }

  var_1 = undefined;
  var_3 = undefined;
}

function nade_trigger_think() {
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  for(;;) {
    self waittill("trigger");
    var_1 = undefined;

    while(level.player istouching(self)) {
      waitframe();

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        var_1 = undefined;
        continue;
      }

      if(!isDefined(var_1)) {
        var_1 = gettime();
      }

      if(!scripts\engine\utility::time_has_passed(var_1, 10)) {
        continue;
      }

      if(level.player.numgrenadesinprogresstowardsplayer > 0) {
        continue;
      }

      if(!scripts\engine\utility::time_has_passed(level.player.lastfraggrenadetoplayerstart, 10) || !scripts\engine\utility::time_has_passed(level.player.lastgrenadelandednearplayertime, 5)) {
        continue;
      }

      var_2 = getaiarray("axis");
      var_3 = undefined;
      var_4 = undefined;
      var_5 = undefined;

      foreach(var_7 in var_0) {
        if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_7.origin, 0.766)) {
          waitframe();

          if(sighttracepassed(level.player getEye(), var_7.origin, 0, level.player)) {
            continue;
          }
        }

        var_8 = scripts\engine\utility::getStruct(var_7.target, "targetname");
        waitframe();

        if(!scripts\engine\trace::ray_trace_passed(var_7.origin, var_8.origin, level.player)) {
          continue;
        }

        var_2 = scripts\engine\utility::array_removedead_or_dying(var_2);

        foreach(var_10 in sortbydistance(var_2, var_7.origin)) {
          if(!isDefined(var_10) || !isalive(var_10)) {
            continue;
          }

          if(distancesquared(var_10.origin, var_7.origin) > 10000) {
            break;
          }

          if(!var_10[[var_10.fnisinstealthcombat]]()) {
            continue;
          }

          if(isDefined(var_10.a) && isDefined(var_10.a.lastshoottime) && !scripts\engine\utility::time_has_passed(var_10.a.lastshoottime, 2)) {
            continue;
          }

          if(istrue(self.ispreppinggrenade) || istrue(self.isholdinggrenade)) {
            continue;
          }

          if(!ispointinvolume(var_10 lastknownpos(level.player), self)) {
            continue;
          }

          var_5 = var_10;
          break;
        }

        if(!isDefined(var_5)) {
          continue;
        }

        var_3 = var_7.origin;
        var_4 = var_8.origin;
        break;
      }

      if(!isDefined(var_3)) {
        continue;
      }

      var_13 = magicgrenade("flash", var_3, var_4, 1);

      if(!isDefined(var_13)) {
        continue;
      }

      thread grenade_badplace_think(var_13);
      wait 10;
    }
  }
}

function grenade_badplace_think(var_0) {
  var_1 = createnavbadplacebyent(self, "axis");
  var_0 waittill("death");
  destroynavobstacle(var_1);
}

function update_vfx_shadow_limit() {
  var_0 = 2;

  while(!scripts\engine\utility::flag("grounds_cleared")) {
    var_1 = getdvarint("LKOLRONRNQ");
    var_2 = getaiarray("axis");
    var_3 = 0;

    foreach(var_5 in sortbydistance(var_2, level.player.origin)) {
      if(distancesquared(var_5.origin, level.player.origin) > var_1 * var_1) {
        break;
      }

      if(istrue(var_5.flashlight)) {
        var_3++;

        if(var_3 >= 6) {
          break;
        }
      }
    }

    var_3 = clamp(var_3, 2, 6);

    if(var_3 != var_0) {
      var_0 = var_3;
      setsaveddvar("LLNMKLQQP", var_0);
    }

    waitframe();
  }

  if(var_0 != 2) {
    setsaveddvar("LLNMKLQQP", 2);
    return;
  }
}

function init_stealth_areas() {
  level.stealth_areas = [];
  var_0 = ["courtyard", "church", "garden", "mansion", "pool", "service", "monument", "shed", "dock", "woods", "technical"];
  var_1 = getspawnerteamarray("axis");

  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.stealthgroups = [];
    var_4.spawners = [];

    foreach(var_6 in var_1) {
      if(!isDefined(var_6.script_stealthgroup)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_6);
        continue;
      }

      if(scripts\engine\utility::string_starts_with(var_6.script_stealthgroup, var_3)) {
        if(!scripts\engine\utility::array_contains(var_4.stealthgroups, var_6.script_stealthgroup)) {
          var_4.stealthgroups[var_4.stealthgroups.size] = var_6.script_stealthgroup;
        }

        var_4.spawners[var_4.spawners.size] = var_6;
        var_1 = scripts\engine\utility::array_remove(var_1, var_6);
      }
    }

    level.stealth_areas[var_3] = var_4;
    thread stealth_area_think();
  }
}

function stealth_area_think() {
  level endon("obj_scene_started");
  scripts\engine\utility::flag_wait("stealth_enabled");
  GscBinSkip4(0x35, self.name);
}

function get_area() {
  if(!isDefined(self.script_stealthgroup)) {
    return undefined;
  }

  return strtok(self.script_stealthgroup, "_")[0];
}

function area_gone_hot_think(var_0) {
  var_1 = 0;
  var_2 = 0;
  jumpiftrue(scripts\engine\utility::flag_exist(var_0 + "_gone_hot")) LOC_0000001f;
  level endon("player_gone_hot");

  for(;;) {
    level waittill(var_0 + "_hot_event", var_3);

    if(gettime() - var_2 > 5000) {
      var_1 = 0;
    }

    var_1++;
    var_2 = gettime();

    if(var_1 >= 3) {
      escalate_grounds_to_alert();

      if(scripts\engine\utility::flag_exist(var_0 + "_gone_hot") && !scripts\engine\utility::is_equal(var_3.script_noteworthy, "escalation_patroller")) {
        scripts\engine\utility::flag_set(var_0 + "_gone_hot");
      }

      if(!scripts\engine\utility::flag("player_gone_hot")) {
        scripts\engine\utility::flag_set("player_gone_hot");
      }

      return;
    }
  }
}

function grounds_axis_spawnfunc() {
  if(!isDefined(self.script_stealthgroup)) {
    return;
  }

  if(!isDefined(self.deathfunction)) {
    self.deathfunction = &grounds_axis_deathfunc;
  }

  self.area = get_area();
  self setengagementmindist(256, 0);
  self setengagementmaxdist(400, 600);

  if(level.hvts_identified == 3 || level.hvts_identified == 2 && self.area == level.hvt_locations[0]) {
    scripts\engine\sp\utility::set_grenadeweapon("molotov flash");
  } else {
    scripts\engine\sp\utility::set_grenadeweapon("molotov");
  }

  scripts\engine\sp\utility::set_grenadeammo(4);
  self.aggressivemode = 1;

  if(scripts\engine\utility::array_contains(["church", "courtyard", "mansion", "pool"], self.area)) {
    thread axis_attacked_think();
  }

  self endon("death");
  GscBinSkip4(0x35);
}

function grounds_axis_deathfunc() {
  if(isDefined(level.hvts) && level.hvts.size > 0) {
    var_0 = scripts\engine\utility::getclosest(self.origin, level.hvts, 80);

    if(isDefined(var_0) && distancesquared(self.origin, level.player.origin) > squared(120)) {
      self.dropweapon = 0;
    }
  }

  return false;
}

function axis_attacked_think() {
  self endon("sniped");
  var_0 = self.area;

  while(isalive(self)) {
    scripts\engine\utility::waittill_any("bulletwhizby", "bullethit", "flashed", "damage", "death");
    scripts\engine\utility::flag_set(var_0 + "_under_attack");
  }
}

function axis_shoot_think() {
  while(should_monitor_shooting()) {
    scripts\engine\utility::waittill_any("shooting", "grenade_fire");
    level notify(self.area + "_hot_event", self);
  }
}

function should_monitor_shooting() {
  if(scripts\engine\utility::flag_exist(self.area + "_gone_hot")) {
    return !scripts\engine\utility::flag(self.area + "_gone_hot");
  }

  return !scripts\engine\utility::flag("player_gone_hot");
}

function init_lone_patroller() {
  scripts\engine\utility::flag_set(self.script_stealthgroup + "_spawned");
  level endon("obj_scene_started");
  var_0 = self.spawner;
  self waittill("entitydeleted");

  if(isDefined(var_0.suspended_ai)) {
    scripts\engine\utility::flag_clear(self.script_stealthgroup + "_spawned");

    foreach(var_2 in level.stealth_areas[var_0.script_stealthgroup].spawners) {
      if(var_2 != var_0) {
        var_2.suspended_ai = var_0.suspended_ai;
        var_2.count = 0;
      }
    }

    return;
  }
}

function init_escalation() {
  level.escalation_state = "stealth";
  level.escalation_level = 0;
  init_escalation_battlechatter();
}

function init_escalation_battlechatter() {
  GscBinSkip1(0x45, "stealth0", 0, ["aqchat_idle_aql1r_10", "aqchat_idle_11"]);
}

function escalate_grounds(var_0) {
  if(!level.escalation_level) {
    scripts\engine\utility::flag_set("technical_called");
  }

  var_1 = level.landmarks[var_0].volume;

  while(level.player istouching(var_1)) {
    waitframe();
  }

  if(scripts\engine\utility::flag("player_gone_hot")) {
    level.escalation_state = "combat";
  }

  level.escalation_level++;

  switch (level.escalation_level) {
    case 1:
      if(level.escalation_state == "stealth") {
        escalate_grounds_to_alert();
      }

      break;
    case 2:
      var_2 = level.extra_patrol_triggers[level.hvt_locations[0]];
      var_2 scripts\engine\utility::trigger_on();

      if(isDefined(level.ownthenight_spawners) && !scripts\engine\utility::flag("courtyard_backup_spawned") && !scripts\engine\utility::flag("church_backup_spawned") && !scripts\engine\utility::flag("pool_backup_spawned")) {
        var_3 = getspawnerarray(var_2.target);
        scripts\engine\utility::array_thread(var_3, &scripts\sp\maps\estate\estate_util::ownthenight_spawner_think, ["backup_spawned", "obj_scene_started"]);
        level.ownthenight_spawners = scripts\engine\utility::array_combine(level.ownthenight_spawners, var_3);
      }

      level.extra_patrol_triggers = undefined;
      break;
    case 3:
      escalate_grounds_to_hunt();
      return;
  }

  scripts\anim\battlechatter::setcurrentcustombcevent(level.escalation_state + level.escalation_level, ["idle", "idle_alert"], 1);
}

function escalate_grounds_to_alert() {
  if(istrue(level.grounds_alerted)) {
    return;
  }

  escalate_grounds_with_func(&scripts\stealth\enemy::trigger_cover_blown);
  level.grounds_alerted = 1;
}

function escalate_grounds_to_hunt() {
  if(istrue(level.grounds_hunting)) {
    return;
  }

  escalate_grounds_with_func(&go_to_hunt);
  level.grounds_hunting = 1;
}

function escalate_grounds_with_func(var_0) {
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "escalation_patroller")) {
      continue;
    }

    var_3 thread[[var_0]]();
  }

  var_5 = getspawnerarray();

  foreach(var_7 in var_5) {
    if(!isDefined(var_7.script_stealthgroup)) {
      continue;
    }

    if(scripts\engine\utility::is_equal(var_7.script_noteworthy, "escalation_patroller")) {
      continue;
    }

    if(issubstr(var_7.script_stealthgroup, "_backup")) {
      continue;
    }

    if(var_7.count < 1 && !isDefined(var_7.suspended_ai)) {
      continue;
    }

    var_7 scripts\engine\sp\utility::add_spawn_function(var_0);
  }
}

function go_to_hunt() {
  self endon("death");
  scripts\engine\utility::ent_flag_wait("stealth_enabled");

  if(!scripts\engine\utility::is_equal(self.script_noteworthy, "go_to_hunt")) {
    while(distancesquared(self.origin, level.player.origin) < squared(1000)) {
      waitframe();
    }
  }

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
    return;
  }

  self[[self.fnsetstealthstate]]("hunt");
}

function escalation_patroller_init() {
  var_0 = get_area();
  self.flashlightoverride = 1;
  var_1 = getEntArray(var_0 + "_escalation_patrol_trig", "targetname");

  foreach(var_3 in var_1) {
    var_3 delete();
  }

  self endon("death");
  self endon("stealth_combat");
  GscBinSkip4(0x35);
}

function escalation_patroller_investigate_think() {
  self waittill("stealth_investigate");
  self.target = undefined;
  self.flashlightoverride = undefined;
}

function escalation_patroller_combat_filter(var_0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var_0)) {
    return true;
  }

  self.flashlightoverride = undefined;
  self.goalradius = 1024;
  self setgoalpos(var_0.origin);
  return false;
}

function vo_escalation_patrollers(var_0) {
  if(var_0 == "mansion") {
    var_1 = 4;
    var_2 = scripts\engine\utility::flag("player_gone_hot");
  } else {
    var_1 = 2;
    var_2 = scripts\engine\utility::flag(var_2 + "_gone_hot");
  }

  foreach(var_4 in level.escalation_patrollers[var_2]) {
    var_4 scripts\engine\sp\utility::set_battlechatter(0);

    if(var_2) {
      var_4.stealth.patrol_moveplaybackrate = 1;
    }

    var_4 endon("reached_path_end");
  }

  level endon(var_2 + "_escalation_patrollers_vo_interrupted");
  thread escalation_patrollers_interrupt_think(var_2);

  if(var_2 == "mansion") {
    scripts\engine\utility::flag_wait("floodlights_on");
    wait 1;
  }

  var_6 = undefined;

  if(var_2 != "mansion") {
    jumpiffalse(level.hvts_identified == 1) LOC_000000c7;
    thread escalation_patrollers_callout_think(var_2);

    for(;;) {
      waitframe();
      var_7 = (0, 0, 0);

      foreach(var_4 in level.escalation_patrollers[var_2]) {
        if(var_4 istouching(level.interior_volumes[var_2])) {
          return;
        }

        var_7 += var_4.origin;
      }

      var_7 /= level.escalation_patrollers[var_2].size;

      if(distance2dsquared(level.player.origin, var_7) < squared(800)) {
        break;
      }
    }

    var_10 = scripts\engine\utility::array_remove(["church", "courtyard", "pool"], var_2);

    foreach(var_12 in var_10) {
      if(isDefined(level.escalation_patrollers[var_12])) {
        var_6 = var_12;
        break;
      }
    }
  }

  if(isDefined(var_6)) {
    var_14 = var_6 + "_" + var_2;
  } else {
    var_14 = var_1;
  }

  if(var_3) {
    var_15 = "combat";
  } else {
    var_15 = "stealth";
  }

  foreach(var_17 in get_escalation_aliases(var_15, var_15)) {
    if(isPlayer(var_17[0])) {
      var_7 = (0, 0, 0);

      foreach(var_6 in level.escalation_patrollers[var_2]) {
        var_7 += var_6.origin;
      }

      var_7 /= level.escalation_patrollers[var_2].size;

      if(distance2dsquared(level.player.origin, var_7) < squared(800)) {
        level.player thread scripts\engine\sp\utility::smart_player_dialogue(var_17[1]);
      }

      continue;
    }

    var_20 = level.escalation_patrollers[var_2][var_17[0]];
    var_20 thread scripts\engine\sp\utility::smart_dialogue_generic(var_17[1]);
    var_20 waittill("single dialogue");
    wait randomfloatrange(0.25, 0.5);
  }

  foreach(var_6 in level.escalation_patrollers[var_2]) {
    var_6 scripts\engine\sp\utility::set_battlechatter(1);
  }

  level notify(var_2 + "_escalation_patrollers_vo_completed");
}

function get_escalation_aliases(var_0, var_1) {
  switch (var_0) {
    case "church":
      if(var_1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_chkchurch_10"], [1, "dx_vom_aq2_aqchat_chkchurch_20"], [0, "dx_vom_aq1_aqchat_chkchurch_30"], [1, "dx_vom_aq2_aqchat_chkchurch_40"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_hotchurch_10"], [1, "dx_vom_aq2_aqchat_hotchurch_20"], [0, "dx_vom_aq1_aqchat_hotchurch_30"]];
      }
    case "church_courtyard":
      if(var_1 == "stealth") {
        return [[0, "dx_vom_aq2_aqchat_crtchrch1_10"], [1, "dx_vom_aq3_aqchat_crtchrch1_20"], [0, "dx_vom_aq2_aqchat_crtchrch1_30"]];
      } else {
        return [[0, "dx_vom_aq2_aqchat_crtchrch2_10"], [1, "dx_vom_aq3_aqchat_crtchrch2_20"], [0, "dx_vom_aq2_aqchat_crtchrch2_30"]];
      }
    case "church_pool":
      if(var_1 == "stealth") {
        return [[0, "dx_vom_aq3_aqchat_spachrch1_10"], [1, "dx_vom_aq4_aqchat_spachrch1_20"], [0, "dx_vom_aq3_aqchat_spachrch1_30"]];
      } else {
        return [[0, "dx_vom_aq3_aqchat_spachrch2_10"], [1, "dx_vom_aq4_aqchat_spachrch2_20"], [0, "dx_vom_aq3_aqchat_spachrch2_30"]];
      }
    case "courtyard":
      if(var_1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_chkcourt_10"], [1, "dx_vom_aq2_aqchat_chkcourt_20"], [0, "dx_vom_aq1_aqchat_chkcourt_30"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_hotcourt_10"], [1, "dx_vom_aq2_aqchat_hotcourt_20"], [0, "dx_vom_aq1_aqchat_hotcourt_30"]];
      }
    case "courtyard_church":
      if(var_1 == "stealth") {
        return [[0, "dx_vom_aq3_aqchat_chrchcrt1_10"], [1, "dx_vom_aq4_aqchat_chrchcrt1_20"], [0, "dx_vom_aq3_aqchat_chrchcrt1_30"]];
      } else {
        return [[0, "dx_vom_aq3_aqchat_chrchcrt2_10"], [1, "dx_vom_aq4_aqchat_chrchcrt2_20"]];
      }
    case "courtyard_pool":
      if(var_1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_spacrt1_10"], [1, "dx_vom_aq2_aqchat_spacrt1_20"], [0, "dx_vom_aq1_aqchat_spacrt1_30"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_spacrt2_10"], [1, "dx_vom_aq2_aqchat_spacrt2_20"], [0, "dx_vom_aq1_aqchat_spacrt2_30"]];
      }
    case "pool":
      if(var_1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_chkspa_10"], [0, "dx_vom_aq1_aqchat_chkspa_20"], [1, "dx_vom_aq2_aqchat_chkspa_30"], [0, "dx_vom_aq1_aqchat_chkspa_40"], [1, "dx_vom_aq2_aqchat_chkspa_50"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_hotspa_10"], [1, "dx_vom_aq2_aqchat_hotspa_20"], [0, "dx_vom_aq1_aqchat_hotspa_30"]];
      }
    case "pool_church":
      if(var_1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_chrchspa1_10"], [1, "dx_vom_aq3_aqchat_chrchspa1_20"], [0, "dx_vom_aq1_aqchat_chrchspa1_30"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_chrchspa2_10"], [1, "dx_vom_aq3_aqchat_chrchspa2_20"], [0, "dx_vom_aq1_aqchat_chrchspa2_30"]];
      }
    case "pool_courtyard":
      if(var_1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_crtspa1_10"], [1, "dx_vom_aq2_aqchat_crtspa1_20"], [0, "dx_vom_aq1_aqchat_crtspa1_30"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_crtspa2_10"], [1, "dx_vom_aq2_aqchat_crtspa2_20"], [0, "dx_vom_aq1_aqchat_crtspa2_30"]];
      }
    case "mansion":
      return [[0, "dx_vom_aq1_goto_obj_floodlights_20"], [2, "dx_vom_aq3_goto_obj_floodlights_40"], [1, scripts\engine\utility::ter_op(var_1 == "stealth", "dx_vom_aq2_goto_obj_floodlights_50", "dx_vom_aq2_goto_obj_floodlights_60")], [0, scripts\engine\utility::ter_op(var_1 == "stealth", "dx_vom_aq1_goto_obj_patrol_10", "dx_vom_aq1_goto_obj_patrol_20")], [1, "dx_vom_aq2_goto_obj_patrol_30"], [2, "dx_vom_aq3_goto_obj_patrol_40"], [0, "dx_vom_aq1_goto_obj_patrol_50"], [1, "dx_vom_aq2_goto_obj_patrol_60"], [0, "dx_vom_aq1_goto_obj_patrol_70"], [level.player, "dx_vom_kyle_goto_obj_patrol_80"]];
  }
}

function escalation_patrollers_interrupt_think(var_0) {
  level endon(var_0 + "_escalation_patrollers_vo_completed");
  scripts\engine\utility::waittill_any_ents_array(level.escalation_patrollers[var_0], "stealth_investigate", "stealth_combat", "death");

  foreach(var_2 in level.escalation_patrollers[var_0]) {
    if(isalive(var_2)) {
      var_2 scripts\engine\sp\utility::set_battlechatter(1);
    }
  }

  level notify(var_0 + "_escalation_patrollers_vo_interrupted");
}

function escalation_patrollers_callout_think(var_0) {
  if(scripts\engine\utility::flag("player_gone_hot")) {
    return;
  }

  level endon("player_gone_hot");
  level endon("identify_anim_started");
  level scripts\engine\utility::waittill_any(var_0 + "_escalation_patrollers_vo_completed", var_0 + "_escalation_patrollers_vo_interrupted", "player_left_" + var_0);
  scripts\sp\maps\estate\estate_util::waittill_player_hidden();
  thread request_overwatch_vo("escalation", "dx_vom_pri_hvt_stealth1_100", 1, 1, undefined, undefined, "identify_anim_started");
}

function vo_extra_patrols(var_0) {
  request_overwatch_vo("escalation", "dx_vom_pri_backup_mansion_60", 0, 1, undefined, 2);
}

function stealth_event_propagator() {
  scripts\engine\utility::flag_wait("stealth_enabled");
  level endon("stealth_enabled");
  GscBinSkip1(0x45, "gunshot", getdvarint("ai_eventDistGunShot"));
}

function propagate_event_thread(var_0, var_1, var_2) {
  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(distancesquared(var_4.origin, var_0.origin) > var_1[var_0.typeorig] * var_1[var_0.typeorig]) {
      break;
    }

    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "lone_patroller") && scripts\engine\utility::flag(var_4.script_stealthgroup + "_spawned")) {
      continue;
    }

    if(!isDefined(var_4.suspended_ai)) {
      if(var_4.count < 1) {
        continue;
      }

      if(istrue(var_4.dont_propagate_events_prespawn)) {
        continue;
      }

      if(isstartstr(var_4.targetname, "mansion_escalation_spawner") && level.hvts_identified < 3) {
        continue;
      }
    }

    if(var_0.typeorig == "light_killed" && distancesquared(var_4.origin, var_0.origin) > 160000) {
      waitframe();

      if(!isDefined(var_4)) {
        continue;
      }

      if(!sighttracepassed(var_4.origin + (0, 0, 60), var_0.origin, 0, var_0.entity)) {
        continue;
      }
    }

    var_5 = undefined;

    if(getaiarray().size < 32 && !scripts\engine\utility::is_equal(var_4.script_parameters, "stealth_spawn_only")) {
      var_5 = var_4 scripts\engine\sp\utility::spawn_ai();
    }

    if(isDefined(var_5)) {
      var_5 aieventlistenerevent(var_0.typeorig, var_0.entity, var_0.origin);
      continue;
    }

    if(isDefined(var_4.suspended_ai)) {
      if(var_0.type == "combat") {
        var_4.suspended_ai.stealth.bsmstate = 3;
      } else {
        var_4.suspended_ai.stealth.bsmstate = max(1, var_4.suspended_ai.stealth.bsmstate);
        var_4.suspended_ai.stealth.investigateevent = var_0;
      }

      continue;
    }

    var_6 = spawnStruct();
    var_6.origin = var_4.origin;
    var_6.angles = var_4.angles;
    var_6.suspendtime = gettime();
    var_6.stealth = spawnStruct();

    if(var_0.type == "combat") {
      var_6.stealth.bsmstate = 3;
    } else {
      var_6.stealth.bsmstate = 1;
      var_6.stealth.investigateevent = var_0;
    }

    var_6.suspendvars = spawnStruct();
    var_4.suspended_ai = var_6;
    var_4.count = 0;
  }
}

function init_overwatch() {
  level.overwatch_requests = [];
  level.last_overwatch_vo_time = 0;
  level.overwatch_request_types = ["objective", "weapon", "escalation", "technical", "backup", "combat", "enemy", "sniper_followup", "aim", "kill", "locked_door", "visual_lost", "sniper_assist", "fusebox", "hvt", "landmark", "stance"];
  thread overwatch_radio_think();
}

function overwatch_radio_think() {
  level endon("hvt_found");
  level.player endon("death");
  thread overwatch_noteworthy_init();
  GscBinSkip4(0x6e, level.player);
}

function overwatch_noteworthy_init() {
  scripts\engine\utility::flag_wait("stealth_enabled");
  scripts\sp\stealth\player::stealth_noteworthy_init();
  level.stealth.noteworthy.priority_func = &overwatch_noteworthy_priority;
  level.stealth.noteworthy.callout_enabled["ahead"] = 1;
  level.stealth.noteworthy.callout_enabled["below"] = 0;
  level.stealth.noteworthy.callout_debounce_guy = 30000;
  level.stealth.noteworthy.callout_debounce_all = 5000;
  level.stealth.noteworthy.callout_radius = 1024;
  level.stealth.noteworthy.callout_proximity_radius = 500;
  level.stealth.noteworthy.callout_bunch_radius = 175;
  level.stealth.noteworthy.callout_func_validator = &can_callout_enemy;
  level.stealth.noteworthy.callout_trace_contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0, 1);
  level.stealth.noteworthy.callout_trace_contents += physics_createcontents(["physicscontents_foliage"]);
  level.stealth.noteworthy.callout_spotted = 1;
}

function overwatch_noteworthy_priority(var_0) {
  if(!isDefined(var_0)) {
    return -1;
  }

  switch (var_0) {
    case "good_kill_double":
      return 60;
    case "good_kill_impressive":
      return 50;
    case "good_kill_bullet":
      return 40;
    case "good_kill":
      return 30;
    case "callout_behind":
    case "callout_ahead":
    case "callout_right":
    case "callout_left":
      return 100;
  }

  return 0;
}

function overwatch_cleanup() {
  scripts\sp\maps\estate\estate_util::clear_alias_group("left");
  scripts\sp\maps\estate\estate_util::clear_alias_group("left_multiple");
  scripts\sp\maps\estate\estate_util::clear_alias_group("left_technical");
  scripts\sp\maps\estate\estate_util::clear_alias_group("right");
  scripts\sp\maps\estate\estate_util::clear_alias_group("right_multiple");
  scripts\sp\maps\estate\estate_util::clear_alias_group("right_technical");
  scripts\sp\maps\estate\estate_util::clear_alias_group("ahead");
  scripts\sp\maps\estate\estate_util::clear_alias_group("ahead_multiple");
  scripts\sp\maps\estate\estate_util::clear_alias_group("behind");
  scripts\sp\maps\estate\estate_util::clear_alias_group("behind_multiple");
  scripts\sp\maps\estate\estate_util::clear_alias_group("behind_technical");
  scripts\sp\maps\estate\estate_util::clear_alias_group("proximitysolo");
  scripts\sp\maps\estate\estate_util::clear_alias_group("proximitymulti");
  scripts\sp\maps\estate\estate_util::clear_alias_group("sightsolo");
  scripts\sp\maps\estate\estate_util::clear_alias_group("sightmulti");
  scripts\sp\maps\estate\estate_util::clear_alias_group("warntechnical");
  scripts\sp\maps\estate\estate_util::clear_alias_group("melee_kill");
  scripts\sp\maps\estate\estate_util::clear_alias_group("bullet_kill");
  scripts\sp\maps\estate\estate_util::clear_alias_group("impressive_kill");
  scripts\sp\maps\estate\estate_util::clear_alias_group("obj_nags");
  scripts\sp\maps\estate\estate_util::clear_alias_group("kyle_locked");
  scripts\sp\maps\estate\estate_util::clear_alias_group("price_locked");
  scripts\sp\maps\estate\estate_util::clear_alias_group("price_snipe_ai");
  scripts\sp\maps\estate\estate_util::clear_alias_group("price_snipe_light");
  scripts\sp\maps\estate\estate_util::clear_alias_group("price_snipe_followup");
  scripts\sp\maps\estate\estate_util::clear_alias_group("price_snipe_nevermind");

  foreach(var_1 in ["church", "courtyard", "mansion", "pool"]) {
    if(scripts\sp\maps\estate\estate_util::alias_group_exists("backup_" + var_1)) {
      scripts\sp\maps\estate\estate_util::clear_alias_group("backup_" + var_1);
    }
  }

  if(scripts\sp\maps\estate\estate_util::alias_group_exists("price_backup")) {
    scripts\sp\maps\estate\estate_util::clear_alias_group("price_backup");
  }

  scripts\sp\maps\estate\estate_util::clear_alias_group("visual_lost");
  scripts\sp\maps\estate\estate_util::clear_alias_group("visual_gained");
  scripts\sp\maps\estate\estate_util::clear_alias_group("stance");
  level.current_overwatch_vo = undefined;
  level.overwatch_requests = undefined;
  level.overwatch_request_types = undefined;
  level.last_overwatch_vo_time = undefined;
}

function play_overwatch_vo(var_0) {
  level notify("overwatch_vo_response_" + var_0.type, 1);
  level.current_overwatch_vo = var_0.type;
  level.overwatch_requests[var_0.type] = undefined;
  internal_play_overwatch_vo(var_0);
  level notify("overwatch_vo_completed", var_0.type);
  level.last_overwatch_vo_time = gettime();
  level.current_overwatch_vo = undefined;
}

function internal_play_overwatch_vo(var_0) {
  if(isDefined(var_0.endon_str)) {
    level endon(var_0.endon_str);
  }

  var_1 = [];

  if(isDefined(var_0.delay_str)) {
    if(isDefined(var_0.delay_time)) {
      level scripts\engine\utility::waittill_notify_or_timeout(var_0.delay_str, var_0.delay_time);
    } else {
      level waittill(var_0.delay_str);
    }
  } else if(isDefined(var_0.delay_time)) {
    wait var_0.delay_time;
  }

  level.player scripts\engine\sp\utility::smart_radio_dialogue(var_0.alias);
}

function request_overwatch_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!scripts\engine\utility::string_starts_with(var_1, "dx_vom_")) {
    var_1 = "dx_vom_pri_" + var_1;
  }

  level notify("new_overwatch_request_" + var_0);
  level endon("new_overwatch_request_" + var_0);
  var_7 = spawnStruct();
  var_7.type = var_0;
  var_7.alias = var_1;
  var_7.ignore_cooldown = istrue(var_2);
  var_7.persistent = istrue(var_3);
  var_7.delay_str = var_4;
  var_7.delay_time = var_5;
  var_7.endon_str = var_6;
  level.overwatch_requests[var_0] = var_7;
  jumpiffalse(isDefined(var_6)) LOC_00000094;
  GscBinSkip4(0x6e, level, var_7);

  level waittill("overwatch_vo_response_" + var_0, var_8);
  return var_8;
}

function overwatch_request_end(var_0) {
  level endon("overwatch_vo_response_" + var_0.type);
  level waittill(var_0.endon_str);
  level.overwatch_requests[var_0.type] = undefined;
  level notify("overwatch_vo_response_" + var_0.type, 0);
}

function overwatch_disengage_think() {
  var_0 = ["dx_vom_pri_disengage_nags_10", "dx_vom_pri_disengage_nags_20"];

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(!isai(var_2)) {
      continue;
    }

    if(self getnormalhealth() > 0.25) {
      continue;
    }

    wait 2;

    if(!scripts\sp\maps\estate\estate_util::anyone_in_combat()) {
      continue;
    }

    if(request_overwatch_vo("combat", scripts\engine\utility::random(var_0))) {
      wait 15;
    }
  }
}

function overwatch_stance_think() {
  scripts\engine\utility::flag_wait("stealth_enabled");
  scripts\sp\maps\estate\estate_util::make_alias_group("stance", ["dx_vom_pri_fusebox_crouch_20", "dx_vom_pri_fusebox_crouch_30", "dx_vom_pri_fusebox_crouch_10"]);

  for(;;) {
    waitframe();

    if(!scripts\engine\utility::flag("player_has_overwatch")) {
      continue;
    }

    if(scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }

    if(scripts\engine\utility::flag("player_in_combat")) {
      continue;
    }

    if(self getstance() != "stand") {
      continue;
    }

    if(self isonladder()) {
      continue;
    }

    if(self islinked()) {
      continue;
    }

    var_0 = 1;

    foreach(var_2 in sortbydistance(getaiarray("axis"), self.origin)) {
      if(distancesquared(var_2 getEye(), self getEye()) > self.maxvisibledist * self.maxvisibledist) {
        break;
      }

      if(scripts\engine\utility::within_fov(var_2 getEye(), var_2.angles, self getEye(), var_2.fovcosineperiph) && var_2 hastacvis(self)) {
        var_0 = 0;
        break;
      }
    }

    if(var_0) {
      continue;
    }

    var_4 = gettime();

    while(!scripts\engine\utility::time_has_passed(var_4, 5)) {
      waitframe();

      if(self getstance() != "stand") {
        break;
      }
    }

    if(!scripts\engine\utility::time_has_passed(var_4, 5)) {
      continue;
    }

    if(request_overwatch_vo("stance", scripts\sp\maps\estate\estate_util::get_next_alias_in_group("stance", 1))) {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index("stance");
      wait 60;
    }
  }
}

function overwatch_interior_think() {
  level.last_interior_callout_time = 0;
  scripts\sp\maps\estate\estate_util::make_alias_group("visual_lost", ["dx_vom_pri_overwatch_handoff_40", "dx_vom_pri_overwatch_handoff_41", "dx_vom_pri_overwatch_handoff_42"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("visual_gained", ["dx_vom_pri_overwatch_handoff_50", "dx_vom_pri_overwatch_handoff_51", "dx_vom_pri_overwatch_handoff_52"]);
  scripts\engine\utility::flag_set("player_has_overwatch");

  for(;;) {
    level.player scripts\engine\utility::ent_flag_wait("indoors");
    scripts\engine\utility::flag_clear("player_has_overwatch");
    thread try_interior_callout();
    level.player scripts\engine\utility::ent_flag_waitopen("indoors");
    scripts\engine\utility::flag_set("player_has_overwatch");
  }
}

function try_interior_callout() {
  var_0 = level scripts\engine\utility::waittill_notify_or_timeout_return("player_has_overwatch", 1);

  if(var_0 == "player_has_overwatch") {
    return;
  }

  if(gettime() - level.last_interior_callout_time < 15000) {
    return;
  }

  if(scripts\engine\utility::flag("player_in_combat")) {
    return;
  }

  if(request_overwatch_vo("visual_lost", scripts\sp\maps\estate\estate_util::get_next_alias_in_group("visual_lost", 1))) {
    level.last_interior_callout_time = gettime();
  } else {
    return;
  }

  scripts\sp\maps\estate\estate_util::increment_alias_group_index("visual_lost");
  var_0 = level scripts\engine\utility::waittill_notify_or_timeout_return("player_has_overwatch", 15);

  if(var_0 == "player_has_overwatch") {
    return;
  }

  for(;;) {
    level waittill("player_has_overwatch");
    var_0 = level scripts\engine\utility::waittill_notify_or_timeout_return("player_has_overwatch", 1);

    if(var_0 == "timeout") {
      break;
    }

    level.last_interior_callout_time = gettime();
  }

  if(scripts\engine\utility::flag("player_in_combat")) {
    return;
  }

  if(request_overwatch_vo("visual_lost", scripts\sp\maps\estate\estate_util::get_next_alias_in_group("visual_gained", 1))) {
    level.last_interior_callout_time = gettime();
    scripts\sp\maps\estate\estate_util::increment_alias_group_index("visual_gained");
    return;
  }
}

function overwatch_enemy_callout_think() {
  scripts\sp\maps\estate\estate_util::make_alias_group("left", ["dx_vom_pri_estate_stealth_00", "dx_vom_pri_estate_stealth_01", "dx_vom_pri_estate_stealth_02"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("left_multiple", ["dx_vom_pri_estate_stealth_03", "dx_vom_pri_estate_stealth_04"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("left_technical", ["dx_vom_pri_technical_dir_30", "dx_vom_pri_technical_dir_40"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("right", ["dx_vom_pri_estate_stealth_08", "dx_vom_pri_estate_stealth_06", "dx_vom_pri_estate_stealth_07"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("right_multiple", ["dx_vom_pri_estate_stealth_05", "dx_vom_pri_estate_stealth_09"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("right_technical", ["dx_vom_pri_technical_dir_50", "dx_vom_pri_technical_dir_60"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("ahead", ["dx_vom_pri_estate_stealth_15", "dx_vom_pri_estate_stealth_16", "dx_vom_pri_estate_stealth_17"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("ahead_multiple", ["dx_vom_pri_estate_stealth_18", "dx_vom_pri_estate_stealth_19"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("behind", ["dx_vom_pri_estate_stealth_10", "dx_vom_pri_estate_stealth_11", "dx_vom_pri_estate_stealth_12", "dx_vom_pri_estate_stealth_13"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("behind_multiple", ["dx_vom_pri_estate_stealth_14"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("behind_technical", ["dx_vom_pri_technical_dir_10", "dx_vom_pri_technical_dir_20"]);
  var_0 = ["dx_vom_pri_estate_stealth_00", "dx_vom_pri_estate_stealth_07"];
  scripts\engine\utility::flag_wait("stealth_enabled");
  waittillframeend();
  childthread scripts\sp\stealth\player::stealth_noteworthy_callouts(1);
  var_1 = 1;
  var_2 = [];

  for(;;) {
    if(!var_1) {
      level.stealth.noteworthy.callout_next -= 5000;

      if(var_2.size) {
        foreach(var_4 in var_2) {
          var_4.stealth.callout_next -= 30000;
        }
      }
    }

    self waittill("stealth_noteworthy", var_6, var_2);

    if(!isstartstr(var_6, "callout")) {
      var_1 = 1;
      continue;
    }

    var_1 = 0;
    var_9 = strtok(var_6, "_")[1];
    var_10 = 0;

    foreach(var_4 in var_2) {
      if(is_technical_rider(var_4)) {
        if(var_9 == "ahead") {
          var_2 = scripts\engine\utility::array_remove(var_2, var_4);
          var_4.stealth.callout_next -= 30000;
          continue;
        }

        var_10 = 1;
      }
    }

    if(var_2.size == 0) {
      continue;
    }

    if(var_10) {
      foreach(var_14 in level.technical.riders) {
        if(!scripts\engine\utility::array_contains(var_2, var_14)) {
          var_2 = var_14;
          var_14.stealth.callout_next = var_2[0].stealth.callout_next;
        }
      }
    }

    var_16 = "";

    if(var_10) {
      var_16 = "_technical";
    } else if(var_2.size > 1) {
      var_16 = "_multiple";
    }

    for(var_17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var_9 + var_16, 1); scripts\engine\utility::array_contains(var_0, var_17) && scripts\engine\utility::flag("stealth_spotted"); var_17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var_9 + var_16, 1)) {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index(var_9 + var_16);
    }

    if(!request_overwatch_vo("enemy", var_17)) {
      continue;
    }

    scripts\sp\maps\estate\estate_util::increment_alias_group_index(var_9 + var_16);
    var_1 = 1;
  }
}

function can_callout_enemy(var_0) {
  if(!scripts\engine\utility::flag("player_has_overwatch")) {
    return false;
  }

  if(abs(self getnormalizedcameramovement()[1]) > 0.1) {
    return false;
  }

  if(length2dsquared(self getvelocity()) > squared(150)) {
    return false;
  }

  if(abs((var_0.origin - self.origin)[2]) > 128) {
    return false;
  }

  if(var_0 scripts\engine\utility::doinglongdeath()) {
    return false;
  }

  if(var_0 scripts\engine\sp\utility::is_touching_any(level.interior_volumes)) {
    return false;
  }

  if(distancesquared(self.origin, var_0.origin) <= level.stealth.noteworthy.callout_proximity_radius * level.stealth.noteworthy.callout_proximity_radius) {
    var_1 = self getEye();
    var_2 = var_0 getapproxeyepos();
    scripts\sp\stealth\player::stealth_noteworthy_trace_safety_check();
    var_3 = scripts\engine\trace::ray_trace(var_1, var_2, [self, var_0], level.stealth.noteworthy.callout_trace_contents);

    if(is_point_in_any_volume(var_3["position"], level.interior_volumes)) {
      return false;
    }

    if(distancesquared(var_3["position"], var_2) <= 16384) {
      return true;
    }

    scripts\sp\stealth\player::stealth_noteworthy_trace_safety_check();
    var_4 = scripts\engine\trace::ray_trace(var_2, var_1, [self, var_0], level.stealth.noteworthy.callout_trace_contents);

    if(is_point_in_any_volume(var_4["position"], level.interior_volumes)) {
      return false;
    }

    if(distancesquared(var_4["position"], var_1) <= 16384) {
      return true;
    }

    if(distancesquared(var_3["position"], var_4["position"]) > 16384) {
      return false;
    }
  }

  return true;
}

function is_point_in_any_volume(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3)) {
      return true;
    }
  }

  return false;
}

function overwatch_aim_callout_think() {
  var_0 = create_aim_contents();
  scripts\sp\maps\estate\estate_util::make_alias_group("proximitysolo", ["dx_vom_pri_stealth_wait_40", "dx_vom_pri_stealth_wait_50", "dx_vom_pri_stealth_wait_60"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("proximitymulti", ["dx_vom_pri_stealth_waitgroup_40", "dx_vom_pri_stealth_waitgroup_50", "dx_vom_pri_stealth_waitgroup_60"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("sightsolo", ["dx_vom_pri_stealth_soloeye_10", "dx_vom_pri_stealth_soloeye_20", "dx_vom_pri_stealth_soloeye_30"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("sightmulti", ["dx_vom_pri_stealth_multieye_10", "dx_vom_pri_stealth_multieye_20", "dx_vom_pri_stealth_multieye_30"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("warntechnical", ["dx_vom_pri_technical_warn_10", "dx_vom_pri_technical_warn_20", "dx_vom_pri_technical_warn_30"]);
  var_1 = [];
  var_2 = -99999;

  for(;;) {
    waitframe();
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("player_in_combat");

    if(!scripts\engine\utility::flag("player_has_overwatch")) {
      continue;
    }

    if(self playerads() < 1) {
      continue;
    }

    if(self isfiring()) {
      continue;
    }

    if(isDefined(level.sniper_assist_target)) {
      continue;
    }

    var_3 = -1;
    var_4 = undefined;
    var_5 = self getEye();
    var_6 = vectorNormalize(anglesToForward(self getplayerangles()));
    var_7 = getaiarray();

    foreach(var_9 in var_7) {
      var_10 = var_9 getapproxeyepos();
      var_11 = distancesquared(var_5, var_10);

      if(var_11 > squared(500)) {
        var_12 = sqrt(var_11);
        var_13 = var_5 + (var_12 - 500) * var_6;
        var_14 = vectorNormalize(var_10 - var_13);
      } else {
        var_14 = vectorNormalize(var_10 - var_5);
      }

      var_15 = vectordot(var_6, var_14);

      if(var_15 < 0.99 || var_15 < var_3) {
        continue;
      }

      if(scripts\engine\trace::ray_trace_passed(var_10, var_5, undefined, var_0)) {
        var_3 = var_15;
        var_4 = var_9;
      }
    }

    if(isDefined(var_4)) {
      if(var_4 scripts\engine\sp\utility::is_touching_any(level.interior_volumes)) {
        continue;
      }

      if(isDefined(var_4.aim_status) && gettime() - var_4.last_aim_callout_time < 30000) {
        continue;
      }

      if(var_4.script_stealthgroup == "technical" && isDefined(var_4.ridingvehicle)) {
        var_17 = "warntechnical";
      } else if(!scripts\sp\maps\estate\estate_util::player_has_silencer()) {
        var_17 = undefined;

        if(scripts\engine\utility::time_has_passed(var_2, 30)) {
          var_17 = "nonsuppressed";
        }
      } else {
        var_17 = get_target_intel(var_4);
      }

      if(!isDefined(var_17)) {
        continue;
      }

      var_18 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var_17, 1);

      if(request_overwatch_vo("aim", var_18, 1)) {
        scripts\sp\maps\estate\estate_util::increment_alias_group_index(var_17);
        var_4.aim_status = var_17;
        var_4.last_aim_callout_time = gettime();

        if(var_17 == "nonsuppressed") {
          var_2 = gettime();
        }

        wait 5;
      }
    }
  }
}

function get_target_intel(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = getaiarray(var_0.team);
  var_4 = "proximity";
  var_5 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, [var_0], undefined, level.stealth.damage_auto_range);

  if(var_5.size == 0) {
    var_4 = "sight";
    var_5 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, [var_0], undefined, level.stealth.damage_sight_range);

    foreach(var_7 in var_5) {
      if(!var_7 scripts\engine\math::point_in_fov(var_0.origin, 0) || !var_7 cansee(var_0)) {
        var_5 = scripts\engine\utility::array_remove(var_5, var_7);
      }
    }

    if(var_5.size == 0) {
      return undefined;
    }
  }

  if(var_5.size > 1) {
    var_4 += "multi";
  } else {
    var_4 += "solo";
  }

  foreach(var_7 in var_5) {
    if(!level.player scripts\engine\math::point_in_fov(var_7.origin, 0.8)) {
      continue;
    }

    if(!sighttracepassed(level.player getEye(), var_7 getapproxeyepos(), 0, [level.player, var_7])) {
      continue;
    }

    var_5 = scripts\engine\utility::array_remove(var_5, var_7);
  }

  if(var_5.size == 0) {
    return undefined;
  }

  return var_4;
}

function create_aim_contents() {
  return scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1);
}

function overwatch_kill_callout_think() {
  scripts\sp\maps\estate\estate_util::make_alias_group("melee_kill", ["dx_vom_pri_stealth_kill_10", "dx_vom_pri_stealth_kill_20", "dx_vom_pri_stealth_kill_30"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("bullet_kill", ["dx_vom_pri_stealth_kill_10", "dx_vom_pri_stealth_kill_20", "dx_vom_pri_stealth_kill_30", "dx_vom_pri_stealth_kill_40", "dx_vom_pri_stealth_kill_50", "dx_vom_pri_stealth_kill_70"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("impressive_kill", ["dx_vom_pri_stealth_doublekill_10", "dx_vom_pri_stealth_doublekill_20", "dx_vom_pri_stealth_doublekill_40", "dx_vom_pri_stealth_doublekill_50"]);
  childthread scripts\sp\stealth\player::stealth_noteworthy_kill_monitor();

  for(;;) {
    self waittill("stealth_noteworthy", var_0, var_1);

    if(!isstartstr(var_0, "good_kill")) {
      continue;
    }

    if(!scripts\engine\utility::flag("player_has_overwatch")) {
      continue;
    }

    if(isDefined(level.sniper_assist_target)) {
      continue;
    }

    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!isDefined(var_4)) {
        continue;
      }

      if(var_4 scripts\engine\sp\utility::is_touching_any(level.interior_volumes)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_4);
      }

      if(isDefined(var_4.aim_status) && scripts\stealth\enemy::shotisbadidea(var_4)) {
        var_2 = 1;
      }
    }

    if(var_1.size == 0) {
      continue;
    }

    var_6 = undefined;
    var_7 = undefined;

    if(var_2) {
      var_6 = "dx_vom_pri_stealth_doublekill_30";
    } else {
      switch (var_0) {
        case "good_kill":
          var_7 = "melee_kill";
        case "good_kill_bullet":
          var_7 = "bullet_kill";
          break;
        case "good_kill_impressive":
        case "good_kill_double":
          var_7 = "impressive_kill";
          break;
      }
    }

    if(!isDefined(var_6)) {
      if(!isDefined(var_7)) {
        continue;
      }

      var_6 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var_7, 1);
    }

    if(!request_overwatch_vo("kill", var_6, 1, 0, undefined, 0.75)) {
      continue;
    }

    if(isDefined(var_7)) {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index(var_7);
    }
  }
}

function overwatch_landmark_callout_think() {
  var_0 = level.landmarks;

  foreach(var_2 in var_0) {
    var_2.last_callout_time = -90000;
  }

  GscBinSkip1(0x45, "courtyard", "ahead", "dx_vom_pri_hvt_landmark_10");
}

function overwatch_hvt_callout_think(var_0) {
  var_0 waittill("hvt_spawned", var_1);
  var_2 = undefined;

  switch (var_1.location) {
    case "church":
      var_2 = ["dx_vom_pri_hvt_churchint_10", "dx_vom_pri_hvt_churchint_20", "dx_vom_pri_hvt_churchint_30"];
      break;
    case "courtyard":
      var_2 = ["dx_vom_pri_hvt_courtyardint_10", "dx_vom_pri_hvt_courtyardint_20", "dx_vom_pri_hvt_courtyardint_30"];
      break;
    case "pool":
      var_2 = ["dx_vom_pri_hvt_poolint_20", "dx_vom_pri_hvt_poolint_10", "dx_vom_pri_hvt_poolint_30"];
      break;
  }

  scripts\sp\maps\estate\estate_util::make_alias_group("overwatch_hvt_" + var_1.location, var_2);

  switch (var_1.location) {
    case "church":
      var_2 = ["dx_vom_pri_hvt_lastloc_10", "dx_vom_pri_hvt_lastloc_20"];
      break;
    case "courtyard":
      var_2 = ["dx_vom_pri_hvt_lastloc_30", "dx_vom_pri_hvt_lastloc_40"];
      break;
    case "pool":
      var_2 = ["dx_vom_pri_hvt_lastloc_50", "dx_vom_pri_hvt_lastloc_60"];
      break;
  }

  scripts\sp\maps\estate\estate_util::make_alias_group("overwatch_hvt_final_" + var_1.location, var_2);
  var_1 endon("identified");
  GscBinSkip4(0x35, var_1);
}

function waittill_interrogation_dialogue_or_timeout() {
  self endon("single dialogue");
  self.interrogator endon("single dialogue");
  wait 4;
}

function overwatch_hvt_sight_callout_think(var_0) {
  var_0 endon("interact");
  var_1 = 0;
  var_2 = 0;
  var_3 = level.hvt_trace_contents;
  jumpiffalse(var_0.location == "courtyard") LOC_00000034;
  var_3 += physics_createcontents(["physicscontents_foliage"]);

  for(;;) {
    if(var_2 <= var_1) {
      var_2 = 0;
    }

    var_1 = var_2;
    waitframe();
    var_4 = self.origin;
    var_5 = var_0.origin;

    if(distancesquared(var_4, var_5) > squared(1000)) {
      continue;
    }

    if(distancesquared(var_4, var_5) > squared(64)) {
      var_4 = self getEye();
      var_5 += (0, 0, 50);

      if(!scripts\engine\utility::within_fov(var_4, self getgunangles(), var_5, 0.77)) {
        continue;
      }

      var_6 = [level.player];

      if(isDefined(var_0.chair)) {
        GscBinSkip0(0x2e, var_6.size, var_0.chair);
      }

      if(!scripts\engine\trace::ray_trace_passed(var_4, var_5, var_6, var_3)) {
        continue;
      }

      var_2++;

      if(var_2 < 20) {
        continue;
      }
    }

    var_0 notify("seen");
    level.hvts_seen++;

    switch (var_0.location) {
      case "church":
        var_0.animnode.description = &"ESTATE/OBJ_DESC_CHURCH_HVT";
        break;
      case "courtyard":
        var_0.animnode.description = &"ESTATE/OBJ_DESC_COURTYARD_HVT";
        break;
      case "pool":
        var_0.animnode.description = &"ESTATE/OBJ_DESC_POOL_HVT";
        break;
    }

    scripts\engine\sp\objectives::objective_set_description("estate", var_0.animnode.description);

    if(isDefined(level.overwatch_requests["objective"])) {
      level waittillmatch("overwatch_vo_completed", "objective");
    }

    var_7 = undefined;
    var_8 = undefined;

    switch (level.hvts_seen) {
      case 1:
        if(scripts\engine\utility::flag("player_in_combat")) {
          var_7 = "dx_vom_kyle_pool_approach1_60";
          var_8 = "dx_vom_pri_pool_approach1_90";
        } else {
          var_7 = "dx_vom_kyle_pool_approach1_50";
          var_8 = "dx_vom_pri_pool_approach1_100";
        }

        break;
      case 2:
        if(scripts\engine\utility::flag("player_in_combat")) {
          var_7 = "dx_vom_kyle_hvt_approach2_20";
          var_8 = "dx_vom_pri_hvt_approach2_40";
        } else {
          var_7 = "dx_vom_kyle_hvt_approach2_10";
          var_8 = "dx_vom_pri_hvt_approach2_30";
        }

        break;
      case 3:
        if(scripts\engine\utility::flag("player_in_combat")) {
          var_7 = "dx_vom_kyle_hvt_approach3_20";
          var_8 = "dx_vom_pri_hvt_approach3_40";
        } else {
          var_7 = "dx_vom_kyle_hvt_approach3_10";
          var_8 = "dx_vom_pri_hvt_approach3_30";
        }

        break;
    }

    var_9 = request_overwatch_vo("objective", var_8, 1, 1, "hvt_seen", undefined, "identify_anim_started");

    if(istrue(var_9)) {
      scripts\sp\maps\estate\estate_util::kyle_line(var_7);
      level notify("hvt_seen");
    }

    return;
  }
}

function overwatch_hvt_nag_think(var_0) {
  if(scripts\engine\utility::flag("did_hvt_nag")) {
    return;
  }

  level endon("did_hvt_nag");
  var_0 waittill("seen");

  if(isalive(var_0.interrogator)) {
    var_0.interrogator waittill("death");
  }

  wait 20;

  for(;;) {
    wait 2;

    if(scripts\engine\utility::flag("player_in_combat")) {
      continue;
    }

    if(!level.player istouching(level.interior_volumes[var_0.location])) {
      continue;
    }

    if(istrue(var_0.identify_anim_playing)) {
      while(istrue(var_0.identify_anim_playing)) {
        waitframe();
      }

      wait 20;
      continue;
    }

    if(request_overwatch_vo("hvt", "dx_vom_pri_pool_hvtcheck_10", 0, 1)) {
      scripts\engine\utility::flag_set("did_hvt_nag");
    }

    wait 15;
  }
}

function overwatch_obj_nag_think() {
  var_0 = gettime();
  var_1 = [];

  foreach(var_3 in level.landmarks) {
    if(!scripts\engine\utility::is_equal(var_3.location, "mansion")) {
      var_1 = var_3.volume;
    }
  }

  var_5 = 0;
  scripts\sp\maps\estate\estate_util::make_alias_group("obj_nags", ["dx_vom_pri_hvt_allnag_10", "dx_vom_pri_hvt_allnag_20", "dx_vom_pri_hvt_allnag_30", "dx_vom_pri_hvt_allnag_40"]);

  for(;;) {
    if(scripts\engine\utility::flag("player_in_combat")) {
      scripts\engine\utility::flag_waitopen("player_in_combat");
      wait 15;
      continue;
    }

    waitframe();

    if(level.hvts_identified > var_5) {
      foreach(var_8, var_7 in var_1) {
        if(!scripts\engine\utility::array_contains(level.hvt_locations, var_8)) {
          while(level.player istouching(var_7)) {
            waitframe();
          }

          level notify("player_left_" + var_8);
          var_1 = scripts\engine\utility::array_remove_key(var_1, var_8);
          var_0 = gettime();
        }
      }

      scripts\sp\maps\estate\estate_util::clear_alias_group("obj_nags");
      var_9 = [];

      if(level.hvt_locations.size > 1) {
        if(!scripts\engine\utility::array_contains(level.hvt_locations, "church")) {
          var_9 = ["dx_vom_pri_hvt_pcnag_20", "dx_vom_pri_hvt_pcnag_30", "dx_vom_pri_hvt_pcnag_40", "dx_vom_pri_hvt_pcnag_50"];
        } else if(!scripts\engine\utility::array_contains(level.hvt_locations, "courtyard")) {
          var_9 = ["dx_vom_pri_hvt_cpnag_10", "dx_vom_pri_hvt_cpnag_20", "dx_vom_pri_hvt_cpnag_30", "dx_vom_pri_hvt_cpnag_50"];
        } else {
          var_9 = ["dx_vom_pri_hvt_ccnag_10", "dx_vom_pri_hvt_ccnag_20", "dx_vom_pri_hvt_ccnag_30", "dx_vom_pri_hvt_ccnag_50"];
        }
      } else {
        switch (level.hvt_locations[0]) {
          case "church":
            var_9 = ["dx_vom_pri_hvt_churchnag_10", "dx_vom_pri_hvt_churchnag_20", "dx_vom_pri_hvt_churchnag_30", "dx_vom_pri_hvt_churchnag_40"];
            break;
          case "courtyard":
            var_9 = ["dx_vom_pri_hvt_courtnag_10", "dx_vom_pri_hvt_courtnag_20", "dx_vom_pri_hvt_courtnag_30", "dx_vom_pri_hvt_courtnag_50"];
            break;
          case "pool":
            var_9 = ["dx_vom_pri_hvt_poolnag_10", "dx_vom_pri_hvt_poolnag_20", "dx_vom_pri_hvt_poolnag_30", "dx_vom_pri_hvt_poolnag_40"];
            break;
        }
      }

      scripts\sp\maps\estate\estate_util::make_alias_group("obj_nags", var_9);
      var_5 = level.hvts_identified;
    }

    if(!level.player scripts\engine\sp\utility::is_touching_any(var_1)) {
      if(!scripts\engine\utility::time_has_passed(var_0, 60)) {
        continue;
      }

      if(!request_overwatch_vo("hvt", scripts\sp\maps\estate\estate_util::get_next_alias_in_group("obj_nags", 1))) {
        continue;
      }

      scripts\sp\maps\estate\estate_util::increment_alias_group_index("obj_nags");
    }

    var_0 = gettime();
  }
}

function overwatch_fusebox_callout_think() {
  var_0 = 0;
  var_1 = level.landmarks;
  var_2 = level.fuseboxes;

  for(;;) {
    waitframe();
    scripts\engine\utility::flag_waitopen("player_in_combat");

    if(scripts\engine\utility::flag("stealth_spotted")) {
      continue;
    }

    if(scripts\engine\utility::ent_flag("indoors")) {
      continue;
    }

    if(isDefined(self.fusebox)) {
      continue;
    }

    if(!var_0) {
      var_3 = scripts\engine\utility::getclosest(self.origin, var_1);

      if(!scripts\engine\utility::array_contains(level.hvt_locations, var_3.location)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
        continue;
      }

      if(!var_3.fusebox.script_light_switch_state) {
        continue;
      }

      if(distance2dsquared(var_3.origin, self.origin) > squared(1000)) {
        continue;
      }

      if(request_overwatch_vo("fusebox", "dx_vom_pri_hint_fuse_10")) {
        var_0 = 1;
      }

      continue;
    }

    if(var_2.size == 0) {
      return;
    }

    var_4 = scripts\engine\utility::getclosest(self.origin, var_2);

    if(!var_4.script_light_switch_state || isDefined(var_4.location) && !scripts\engine\utility::array_contains(level.hvt_locations, var_4.location)) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
      continue;
    }

    if(self.origin[2] > var_4.origin[2]) {
      continue;
    }

    var_5 = distance2dsquared(var_4.origin, self.origin);

    if(var_5 > squared(500)) {
      continue;
    }

    var_6 = self getEye();

    if(!sighttracepassed(var_6, var_4.origin, 0, self)) {
      continue;
    }

    var_7 = undefined;

    if(scripts\engine\utility::within_fov(var_6, self getgunangles(), var_4.origin, 0.8) || var_5 < 16384) {
      var_7 = "dx_vom_pri_infil_fuse_10";
    } else {
      var_8 = scripts\anim\battlechatter::getdirectioncompass(self.origin, var_4.origin);

      switch (var_8) {
        case "north":
          var_7 = "dx_vom_pri_fusebox_hints_10";
          break;
        case "south":
          var_7 = "dx_vom_pri_fusebox_hints_40";
          break;
        case "east":
          var_7 = "dx_vom_pri_fusebox_hints_30";
          break;
        case "west":
          var_7 = "dx_vom_pri_fusebox_hints_20";
          break;
      }
    }

    if(!isDefined(var_7)) {
      continue;
    }

    if(request_overwatch_vo("fusebox", var_7)) {
      wait 30;
    }
  }
}

function overwatch_door_locked_think(var_0) {
  var_0 endon("first_interact");
  var_0 endon("ai_opened");
  var_0 endon("bashed");

  for(;;) {
    scripts\engine\utility::flag_waitopen("player_in_combat");
    var_0 waittill("trigger");

    if(isDefined(var_0.doubledoors) && var_0 != var_0.doubledoors[0]) {
      return;
    }

    if(scripts\engine\utility::flag("player_in_combat")) {
      continue;
    }

    if(!var_0.locked) {
      continue;
    }

    if(request_overwatch_vo("locked_door", scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_locked", 1), 1, 0, "price_locked")) {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index("price_locked");
      scripts\sp\maps\estate\estate_util::kyle_line(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("kyle_locked"));
      level notify("price_locked");
    }

    wait 2;
  }
}

function overwatch_sniper_assist_think() {
  scripts\sp\maps\estate\estate_util::make_alias_group("price_snipe_ai", ["dx_vom_pri_estate_stealth_25", "dx_vom_pri_estate_stealth_26", "dx_vom_pri_estate_stealth_27"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("price_snipe_light", ["dx_vom_pri_grounds_light_10", "dx_vom_pri_grounds_light_20", "dx_vom_pri_grounds_light_30"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("price_snipe_followup", ["dx_vom_pri_estate_stealth_28", "dx_vom_pri_estate_stealth_29", "dx_vom_pri_estate_stealth_30", "dx_vom_pri_estate_stealth_31", "dx_vom_pri_estate_stealth_32"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("price_snipe_nevermind", ["dx_vom_pri_estate_stealth_50", "dx_vom_pri_estate_stealth_60", "dx_vom_pri_estate_stealth_70"]);
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_falima_notracer", ["silencer_west01"]);
  var_1 = scripts\engine\utility::getStructArray("overwatch_struct", "targetname");
  var_2 = level.dynolights;

  for(;;) {
    waitframe();

    if(getdvarint("scr_est_priceDontSnipe")) {
      continue;
    }

    if(!scripts\engine\utility::flag("player_has_overwatch")) {
      continue;
    }

    scripts\sp\maps\estate\estate_util::waittill_player_stops_rotating();
    var_3 = getaiarray("axis");
    var_4 = sortbydistance(var_3, self.origin);
    var_5 = undefined;

    foreach(var_20, var_7 in var_4) {
      var_8 = undefined;

      if(!isalive(var_7)) {
        continue;
      }

      if(var_7 scripts\engine\utility::doinglongdeath()) {
        continue;
      }

      if(distancesquared(var_7.origin, self.origin) > 640000) {
        break;
      }

      if(isDefined(var_7.next_snipe_try_time) && gettime() < var_7.next_snipe_try_time) {
        continue;
      }

      var_7.next_snipe_try_time = gettime() + 2000;

      if(scripts\engine\utility::is_equal(var_7.script_stealthgroup, "technical")) {
        continue;
      }

      if(scripts\engine\utility::is_equal(var_7.script, "pain")) {
        continue;
      }

      var_8 = var_7 getapproxeyepos();

      if(!scripts\engine\math::point_in_fov(var_8, 0.8)) {
        continue;
      }

      if(!var_7 hastacvis(self)) {
        continue;
      }

      var_9 = 0;

      foreach(var_12, var_11 in level.interior_volumes) {
        if(ispointinvolume(var_7.origin, var_11)) {
          var_9 = 1;
          break;
        }
      }

      if(var_9) {
        break;
      }

      if(scripts\engine\sp\utility::isads() && scripts\engine\math::point_in_fov(var_8, 0.99)) {
        continue;
      }

      if(scripts\engine\utility::is_equal(level.player.context_melee_victim, var_7)) {
        continue;
      }

      if(distancesquared(level.player.origin, var_7.origin) < squared(150)) {
        var_13 = vectorNormalize(level.player.origin - var_7.origin);
        var_14 = anglesToForward(var_7.angles);

        if(vectordot(var_13, var_14) <= -0.5) {
          continue;
        }
      }

      if(!scripts\engine\utility::flag("player_in_combat")) {
        var_3 = getaiarray("axis");
        var_15 = 0;

        foreach(var_19, var_17 in sortbydistance(var_3, var_7.origin)) {
          if(var_17 == var_7) {
            continue;
          }

          var_18 = distancesquared(var_17.origin, var_7.origin);

          if(var_18 > 562500) {
            break;
          }

          if(var_18 <= 105625) {
            var_15 = 1;
            break;
          }

          if(var_17 hastacvis(var_7)) {
            var_15 = 1;
            break;
          }
        }

        if(var_15) {
          continue;
        }
      }

      waitframe();

      if(!scripts\engine\trace::ray_trace_passed(self getEye(), var_8, [self, var_7])) {
        continue;
      }

      var_5 = var_7;
      break;
    }

    if(!isDefined(var_5) && var_2.size > 0 && !scripts\engine\utility::flag("player_in_combat")) {
      var_4 = sortbydistance(var_2, self.origin);

      foreach(var_7 in var_4) {
        if(distancesquared(var_7.origin, self.origin) > 640000) {
          break;
        }

        if(var_7.model == "dynlt_fusebox_light_01_on" || var_7.model == "dynlt_fusebox_light_led_01_on") {
          var_2 = scripts\engine\utility::array_remove(var_2, var_7);
          continue;
        }

        if(scripts\engine\sp\utility::isads()) {
          continue;
        }

        if(var_7 getscriptablepartstate("onoff") != "on") {
          var_2 = scripts\engine\utility::array_remove(var_2, var_7);
          continue;
        }

        var_9 = 0;

        foreach(var_11 in level.interior_volumes) {
          if(ispointinvolume(var_7.origin, var_11)) {
            var_9 = 1;
            break;
          }
        }

        if(var_9) {
          var_2 = scripts\engine\utility::array_remove(var_2, var_7);
          break;
        }

        var_8 = var_7.lightpos;

        if(!scripts\engine\math::point_in_fov(var_8, 0.8)) {
          continue;
        }

        var_3 = getaiarray("axis");
        var_24 = sortbydistance(var_3, var_8)[0];

        if(isDefined(var_24)) {
          var_18 = distancesquared(var_24.origin, var_8);

          if(var_18 < 202500) {
            continue;
          }

          if(var_18 < 722500) {
            if(var_24 hastacvis(var_8, 0)) {
              continue;
            }

            waitframe();

            if(sighttracepassed(var_24 getapproxeyepos(), var_8, 0, var_7)) {
              continue;
            }
          }
        }

        waitframe();

        if(!scripts\engine\trace::ray_trace_passed(self getEye(), var_8, [self, var_7])) {
          continue;
        }

        var_5 = var_7;
        break;
      }
    }

    if(!isDefined(var_5)) {
      continue;
    }

    var_26 = 0;
    var_8 = undefined;

    while(var_26 < 3) {
      waitframe();

      if(!isDefined(var_5)) {
        break;
      }

      if(isai(var_5)) {
        if(!isalive(var_5)) {
          break;
        }

        if(var_5 scripts\engine\utility::doinglongdeath()) {
          break;
        }

        if(scripts\engine\utility::is_equal(var_5.script, "pain")) {
          break;
        }

        var_9 = 0;

        foreach(var_11 in level.interior_volumes) {
          if(ispointinvolume(var_5.origin, var_11)) {
            var_9 = 1;
            break;
          }
        }

        if(var_9) {
          break;
        }

        var_6 = var_3 getapproxeyepos();

        if(!scripts\engine\math::point_in_fov(var_6, 0.8)) {
          break;
        }

        if(scripts\engine\sp\utility::isads() && scripts\engine\math::point_in_fov(var_4, 0.99)) {
          break;
        }

        if(scripts\engine\utility::is_equal(level.player.context_melee_victim, < error > )) {
          break;
        }

        if(distancesquared(level.player.origin, < error > .origin) < squared(200)) {
          var_5 = vectorNormalize(level.player.origin - < error > .origin);
          var_6 = anglesToForward( < error > .angles);

          if(vectordot(var_5, var_6) <= -0.5) {
            break;
          }
        }
      } else {
        <
        error > = < error > .lightpos;

        if(!scripts\engine\math::point_in_fov( < error > , 0.8)) {
          break;
        }

        if( < error > getscriptablepartstate("onoff") != "on") {
          <
          error > = scripts\engine\utility::array_remove( < error > , < error > );
          break;
        }

        if(scripts\engine\sp\utility::isads()) {
          break;
        }
      }

      if(!scripts\engine\trace::ray_trace_passed(self getEye(), < error > , [self, < error > ])) {
        break;
      }

      var_11++;
    }

    if(var_11 < 3) {
      continue;
    }

    var_12 = undefined;
    var_13 = sortbydistance( < error > , < error > );

    foreach(var_16, var_15 in var_13) {
      waitframe();

      if(isai( < error > )) {
        <
        error > = < error > getEye() + < error > .velocity;
      }

      if(scripts\engine\trace::ray_trace_passed(var_15.origin, < error > , [ < error > ])) {
        var_12 = var_15.origin;
        break;
      }
    }

    if(!isDefined(var_12)) {
      if(!isai( < error > )) {
        <
        error > = scripts\engine\utility::array_remove( < error > , < error > );
      }

      continue;
    }

    if(isai( < error > )) {
      var_17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_ai", 1);
    } else {
      var_17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_light", 1);
    }

    var_18 = undefined;

    if(!isai( < error > )) {
      var_18 = "price_shot_light";
    }

    var_19 = request_overwatch_vo("sniper_assist", var_17, 0, 0, var_18);

    if(!var_19) {
      continue;
    }

    level.sniper_assist_target = < error > ;

    if(isai( < error > )) {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index("price_snipe_ai");
      level waittill("overwatch_vo_completed", var_20);
      var_26 = 0;

      if(!isDefined( < error > )) {
        var_26 = 1;
      } else if(!isalive( < error > )) {
        var_26 = 1;
      } else if(istrue(level.player.in_melee_death) && scripts\engine\utility::is_equal(level.player.context_melee_victim, < error > )) {
        var_26 = 1;
      }

      if(var_26) {
        if(!isDefined(level.current_overwatch_vo)) {
          var_17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_nevermind");
          thread request_overwatch_vo("sniper_followup", var_17, 1);
        }

        level.sniper_assist_target = undefined;
        continue;
      }

      <
      error > notify("sniped");
      var_39 = < error > getEye();
      thread snipe_whiz_sfx(var_12, var_39);
      magicbullet( < error > , var_12, var_39);
      waitframe();

      if(isalive( < error > )) {
        <
        error > kill(var_12);
      }
    } else {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index("price_snipe_light");
      thread snipe_whiz_sfx(var_12, < error > .lightpos);
      magicbullet( < error > , var_12, < error > .lightpos);
      waitframe();

      if( < error > getscriptablepartstate("onoff") != "death") {
        <
        error > scripts\sp\utility::do_damage(100, var_12);
      }

      wait 0.75;
      level notify(var_18);
    }

    level.sniper_assist_target = undefined;

    if(isai( < error > )) {
      wait 1.5;

      if(!isDefined(level.current_overwatch_vo)) {
        var_17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_followup");

        if(var_17 == "dx_vom_pri_estate_stealth_29" && scripts\engine\utility::flag("stealth_spotted")) {
          var_17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_followup");
        }

        thread request_overwatch_vo("sniper_followup", var_17, 1);
      }
    }

    wait 15;
  }
}

function snipe_whiz_sfx(var_0, var_1) {
  var_2 = spawn("script_origin", var_1);
  waitframe();
  var_3 = "_far";
  var_4 = "_med";
  var_5 = distance(var_0, var_1);

  if(var_5 < 1900) {
    var_3 = "_med";
  }

  var_6 = distance(var_1, level.player.origin);

  if(var_6 < 500) {
    var_4 = "_near";
  }

  var_7 = "sniper_whiz" + var_3 + var_4 + "_in";
  var_2 playSound(var_7);
  wait var_5 / 7500;
  var_2 stopsounds();
  var_2 delete();
}

function spawn_hvt() {
  thread hvt_waypoint_think();
  var_0 = scripts\engine\sp\utility::get_spawner_array("interrogator", "script_noteworthy");
  var_1 = scripts\engine\utility::getclosest(self.origin, var_0);
  var_2 = self.script_noteworthy + "_interrogator";
  var_1 waittill("spawned", var_3);
  var_4 = scripts\engine\sp\utility::fakeactorspawn(getspawner(self.target, "targetname"));
  var_4.fakeactor_face_anim = 1;
  var_4.interrogator = var_3;
  var_4.location = self.script_noteworthy;
  var_4.is_target = 0;
  level.hvts[self.script_noteworthy] = var_4;
  var_4 detach(var_4.headmodel, "");

  switch (self.script_noteworthy) {
    case "pool":
      scripts\sp\maps\estate\estate_util::make_alias_group("pool_playernear", ["dx_vom_hvt_hvt_bag_20", "dx_vom_hvt_hvt_bag_30"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("pool_gunshots", ["dx_vom_hvt_hvt_bag_80", "dx_vom_hvt_hvt_bag_90", "dx_vom_hvt_hvt_bag_110", "dx_vom_hvt_hvt_bag_130"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("pool_yelling", ["dx_vom_hvt_hvt_bag_85", "dx_vom_hvt_hvt_bag_95", "dx_vom_hvt_hvt_bag_100", "dx_vom_hvt_hvt_bag_120", "dx_vom_hvt_hvt_bag_140", "dx_vom_hvt_hvt_bag_150", "dx_vom_hvt_hvt_bag_160", "dx_vom_hvt_hvt_bag_170", "dx_vom_hvt_hvt_bag_180", "dx_vom_hvt_hvt_bag_190"]);
      var_4.incorrect_alias = "dx_vom_hvt1_hvt_incorrect_51";
      var_4.correct_alias = "dx_vom_hvt_hvt_correct_01";
      var_4.ko_alias = "dx_vom_hvt_hvt_ko_10";
      var_4.headmodel = "head_sc_m_kamalov_damage";
      break;
    case "courtyard":
      scripts\sp\maps\estate\estate_util::make_alias_group("courtyard_playernear", ["dx_vom_hvt2_hvt_bag_20", "dx_vom_hvt2_hvt_bag_30"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("courtyard_gunshots", ["dx_vom_hvt2_hvt_bag_80", "dx_vom_hvt2_hvt_bag_90", "dx_vom_hvt2_hvt_bag_110", "dx_vom_hvt2_hvt_bag_130"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("courtyard_yelling", ["dx_vom_hvt2_hvt_bag_85", "dx_vom_hvt2_hvt_bag_95", "dx_vom_hvt2_hvt_bag_100", "dx_vom_hvt2_hvt_bag_120", "dx_vom_hvt2_hvt_bag_140", "dx_vom_hvt2_hvt_bag_150", "dx_vom_hvt2_hvt_bag_160", "dx_vom_hvt2_hvt_bag_170", "dx_vom_hvt2_hvt_bag_180", "dx_vom_hvt2_hvt_bag_190"]);
      var_4.incorrect_alias = "dx_vom_hvt2_hvt_incorrect_41";
      var_4.correct_alias = "dx_vom_hvt2_hvt_correct_01";
      var_4.ko_alias = "dx_vom_hvt2_hvt_ko_10";
      var_4.headmodel = "head_sc_m_thompson";
      var_4 attach("zip_tie_handcuffs_wm", "tag_accessory_right");
      break;
    case "church":
      scripts\sp\maps\estate\estate_util::make_alias_group("church_playernear", ["dx_vom_hvt3_hvt_bag_20", "dx_vom_hvt3_hvt_bag_30"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("church_gunshots", ["dx_vom_hvt3_hvt_bag_80", "dx_vom_hvt3_hvt_bag_90", "dx_vom_hvt3_hvt_bag_110", "dx_vom_hvt3_hvt_bag_130"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("church_yelling", ["dx_vom_hvt3_hvt_bag_85", "dx_vom_hvt3_hvt_bag_95", "dx_vom_hvt3_hvt_bag_100", "dx_vom_hvt3_hvt_bag_120", "dx_vom_hvt3_hvt_bag_140", "dx_vom_hvt3_hvt_bag_150", "dx_vom_hvt3_hvt_bag_160", "dx_vom_hvt3_hvt_bag_170", "dx_vom_hvt3_hvt_bag_180", "dx_vom_hvt3_hvt_bag_190"]);
      var_4.incorrect_alias = "dx_vom_hvt3_hvt_incorrect_52";
      var_4.correct_alias = "dx_vom_hvt3_hvt_correct_01";
      var_4.ko_alias = "dx_vom_hvt3_hvt_ko_10";
      var_4.headmodel = "head_sc_m_florian";
      var_4 attach("zip_tie_handcuffs_wm", "tag_accessory_right");
      break;
  }

  var_4 attach(var_4.headmodel, "");
  var_4.obstacle_id = createnavobstaclebyent(var_4);
  var_4.animnode = self;
  scripts\common\anim::addnotetrack_customfunction("hvt", "incorrect", &vo_check_hvt, var_4.location + "_interact");
  scripts\common\anim::addnotetrack_customfunction("hvt", "correct", &vo_check_hvt_final, var_4.location + "_interact_final");
  thread hvt_interact_think();
  thread hvt_death_pre_interact();
  thread hvt_anim_think();
  thread no_grenades_near_hvt();
  var_4.no_friendly_fire_fail = 1;
  thread scripts\sp\friendlyfire::friendly_fire_think(var_4);
  var_5 = scripts\engine\utility::get_linked_ents()[0];

  if(isDefined(var_5)) {
    thread hvt_delete_clip_on_death(var_4);
  }

  self notify("hvt_spawned", var_4);
}

function hvt_delete_clip_on_death(var_0) {
  scripts\engine\utility::waittill_any("dying", "death", "knockout");
  var_0 delete();
}

function check_hvt() {
  level notify(self.location + "_identified");
  thread scripts\sp\analytics::analytics_kleenex_update("reached HVT " + self.location);
  level.hvt_locations = scripts\engine\utility::array_remove(level.hvt_locations, self.location);
  level.hvts_identified++;

  if(getdvarint("greenlight")) {
    thread estate_gl_endtag_delay_music_change();
    level.hvts_identified = 3;
    thread greenlight_fadeout(self);

    foreach(var_1 in level.hvt_locations) {
      if(var_1 != self.location) {
        scripts\engine\sp\objectives::objective_set_state(var_1 + "_hvt", "invisible");
      }
    }
  }

  if(level.hvts_identified < 3) {
    scripts\engine\utility::flag_set(self.location + "_hvt_checked");
  } else {
    self.is_target = 1;
    scripts\engine\utility::flag_set("hvt_found");
  }

  thread escalate_grounds(self.location);

  foreach(var_4 in level.hvt_locations) {
    scripts\engine\sp\objectives::objective_set_state(var_4 + "_hvt", "current");
  }

  scripts\engine\sp\objectives::objective_complete(self.location + "_hvt");
  scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_FIND_HVT");
  self.identified = 1;
  self notify("identified");
  scripts\sp\analytics::analytics_fake_start_point("HVT_" + self.location);
}

function vo_check_hvt(var_0) {
  var_0 playSound(var_0.incorrect_alias);
}

function vo_check_hvt_final(var_0) {
  var_0 playSound(var_0.correct_alias);
}

function hvt_waypoint_think() {
  level endon("hvt_found");
  level endon(self.script_noteworthy + "_identified");
  var_0 = level.landmarks[self.script_noteworthy].waypoint_volume;

  switch (self.script_noteworthy) {
    case "church":
      self.description = &"ESTATE/OBJ_DESC_CHURCH";
      break;
    case "courtyard":
      self.description = &"ESTATE/OBJ_DESC_COURTYARD";
      break;
    case "pool":
      self.description = &"ESTATE/OBJ_DESC_POOL";
      break;
  }

  for(;;) {
    while(!level.player istouching(var_0)) {
      waitframe();
    }

    scripts\engine\sp\objectives::objective_set_description("estate", self.description);

    foreach(var_2 in level.hvt_locations) {
      scripts\engine\sp\objectives::objective_set_state(var_2 + "_hvt", "active");
    }

    while(level.player istouching(var_0)) {
      waitframe();
    }

    scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_FIND_HVT");

    foreach(var_2 in level.hvt_locations) {
      scripts\engine\sp\objectives::objective_set_state(var_2 + "_hvt", "current");
    }
  }
}

function hvt_interact_think() {
  level endon("hvt_found");
  self endon("identified");
  self endon("death");

  for(;;) {
    self.interrogator scripts\engine\utility::waittill_any("stealth_investigate", "stealth_combat", "death");

    if(istrue(self.breakout)) {
      var_0 = scripts\engine\utility::waittill_any_return("breakout_end", "resume_interrogation");

      if(var_0 == "resume_interrogation") {
        continue;
      }
    }

    hvt_enable_interact();

    for(;;) {
      var_0 = scripts\engine\utility::waittill_any_return("trigger", "resume_interrogation");
      self stopsounds();

      if(var_0 == "trigger" && level.player isscriptedmeleeactive()) {
        waittillframeend();
        scripts\sp\player\cursor_hint::create_cursor_hint("j_head", undefined, undefined, 45, undefined, 80, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 75);
        continue;
      }

      if(isDefined(level.player.near_hvt)) {
        level.player scripts\common\utility::allow_weapon_pickup(1, "hvt");
        level.player.near_hvt = undefined;
      }

      if(var_0 == "resume_interrogation") {
        break;
      }

      self notify("interact");
      self waittill("interact_interrupted");
      hvt_enable_interact();
    }
  }
}

function hvt_enable_interact() {
  scripts\sp\player\cursor_hint::create_cursor_hint("j_head", undefined, undefined, 45, undefined, 80, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 75);
  thread disable_weapon_pickup_near_hvt();

  if(isalive(self.interrogator)) {
    thread hvt_disable_interact_on_interrogation();
    return;
  }
}

function disable_weapon_pickup_near_hvt() {
  self endon("interact");
  self endon("death");
  self endon("resume_interrogation");

  for(;;) {
    while(distancesquared(level.player.origin, self.origin) > squared(80)) {
      waitframe();
    }

    level.player scripts\common\utility::allow_weapon_pickup(0, "hvt");
    level.player.near_hvt = 1;

    while(distancesquared(level.player.origin, self.origin) <= squared(80)) {
      waitframe();
    }

    level.player scripts\common\utility::allow_weapon_pickup(1, "hvt");
    level.player.near_hvt = undefined;
  }
}

function hvt_disable_interact_on_interrogation() {
  level endon("hvt_found");
  self.interrogator endon("death");
  self endon("interact");
  self waittill("resume_interrogation");
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function no_grenades_near_hvt() {
  self endon("death");

  while(!istrue(self.identified)) {
    while(distancesquared(level.player.origin, self.origin) > squared(128)) {
      waitframe();
    }

    if(istrue(self.identified)) {
      break;
    }

    level.player.dontgrenademe = 1;

    while(distancesquared(level.player.origin, self.origin) <= squared(128)) {
      waitframe();
    }

    level.player.dontgrenademe = undefined;
  }
}

function hvt_anim_think() {
  thread interrogation_anim_think();
  level.player endon("death");

  for(;;) {
    self waittill("interact");
    thread identify_anim_think();
    var_0 = scripts\engine\utility::waittill_any_return("identified", "interact_interrupted");

    if(var_0 == "identified") {
      return;
    }
  }
}

function interrogation_anim_think() {
  level endon("obj_scene_started");
  self endon("interact");
  self.animname = "hvt";
  scripts\engine\sp\utility::assign_animtree();
  self.interrogator.animname = "interrogator";
  self.interrogator scripts\engine\sp\utility::set_allowdeath(1);
  var_0 = [self];
  var_1 = self.location + "_interrogation";
  var_2 = self.location + "_idle";
  level.scr_goaltime["hvt"][var_2] = 1;

  if(self.location == "courtyard") {
    foreach(var_5, var_4 in getEntArray("hvt_chair", "targetname")) {
      if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "chair")) {
        self.chair = var_4;
        break;
      }
    }

    var_6 = self.chair scripts\engine\utility::get_linked_ent();
    var_6 linkTo(self.chair, "j_origin_animate");
    self.chair.animname = "chair";
    self.chair scripts\engine\sp\utility::assign_animtree();
    self.chair scripts\engine\sp\utility::assign_model();
    scripts\common\anim::addnotetrack_notify("hvt", "begin_settle", "courtyard_hvt_down", "courtyard_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "end_settle", "courtyard_hvt_up", "courtyard_interrogation");
    GscBinSkip1(0x45, "courtyard_hvt_down", "courtyard_interrogation_getup");
  }

  if(self.location == "church") {
    var_8 = "tag_accessory_right";
    var_9 = spawn("script_model", self.interrogator gettagorigin(var_8));
    var_9.angles = self.interrogator gettagangles(var_8);
    var_9 setModel("ee_electric_cattle_prod_01");
    var_9 linkTo(self.interrogator, var_8, (0, 0, 0), (0, 0, 0));
    self.interrogator.cattleprod = var_9;
    self.interrogator.deathfunction = &delete_cattleprod;
    thread cattleprod_think();
    scripts\common\anim::addnotetrack_notify("hvt", "down_start", "church_hvt_down", "church_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "down_end", "church_breakout_end", "church_interrogation");
    var_10 = "church_interrogation_getup";
    thread hvt_breakout_think(["church_hvt_down"], "church_breakout_end", var_10, var_6);
  } else {
    scripts\common\anim::addnotetrack_notify("hvt", "down_start", "pool_hvt_down", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "down_end", "pool_breakout_end", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "cower_start", "pool_hvt_cower", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "cower_end", "pool_breakout_end", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_1_wait_start", "pool_breakout_1_wait", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_1_start", "pool_breakout_1", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_2_start", "pool_breakout_2", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_3_wait_start", "pool_breakout_3_wait", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_3_start", "pool_breakout_3", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_4_wait_start", "pool_breakout_4_wait", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_4_start", "pool_breakout_4", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_5_start", "pool_breakout_5", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_6_wait_start", "pool_breakout_6_wait", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_6_start", "pool_breakout_6", "pool_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "breakout_end", "pool_breakout_end", "pool_interrogation");
    GscBinSkip1(0x45, "pool_hvt_down", "pool_interrogation_getup", self.interrogator);
  }

  var_12 = undefined;

  for(;;) {
    self.interrogating = 1;
    self.animnode thread scripts\common\anim::anim_loop(var_4, var_5, "stop_loop_hvt");
    self.animnode thread scripts\common\anim::anim_loop_solo(self.interrogator, var_5, "stop_loop_interrogator");

    if(self.location == "pool") {
      var_12 = createnavobstaclebybounds(self.animnode.origin, (60, 60, 60), self.animnode.angles);
    }

    self.interrogator scripts\engine\utility::waittill_any("stealth_investigate", "stealth_combat", "death");
    self.interrogating = undefined;

    if(isDefined(var_12)) {
      destroynavobstacle(var_12);
    }

    self.animnode notify("stop_loop_interrogator");

    if(!istrue(self.breakout_wait)) {
      self.animnode notify("stop_loop_hvt");
      scripts\engine\sp\utility::anim_stopanimScripted();

      if(isDefined(self.chair)) {
        self.chair scripts\engine\sp\utility::anim_stopanimScripted();
      }
    }

    if(isalive(self.interrogator)) {
      self.interrogator scripts\engine\sp\utility::anim_stopanimScripted();

      if(isDefined(self.interrogator.cattleprod)) {
        self.interrogator.cattleprod hide();
      }
    }

    if(!istrue(self.breakout)) {
      self.animnode thread scripts\common\anim::anim_loop_solo(self, var_6, "stop_loop_hvt");

      if(isDefined(self.chair)) {
        self.animnode scripts\common\anim::anim_first_frame_solo(self.chair, var_5);
      }
    }

    self notify("stop_interrogation");
    self stopsounds();
    thread vo_hvt_think();

    if(!isalive(self.interrogator)) {
      return;
    }

    for(;;) {
      self.interrogator scripts\engine\utility::waittill_any("stealth_idle", "death");
      self.animnode thread scripts\sp\anim::anim_reach_and_approach_solo(self.interrogator, var_5);
      self.interrogator scripts\engine\utility::waittill_any("anim_reach_complete", "stealth_investigate", "stealth_combat", "death");

      if(!isalive(self.interrogator) || self.interrogator[[self.interrogator.fnisinstealthidle]]()) {
        if(istrue(self.breakout) && isalive(self.interrogator)) {
          self.interrogator scripts\engine\utility::waittill_any("breakout_end", "stealth_investigate", "stealth_combat", "death");

          if(isalive(self.interrogator) && !self.interrogator[[self.interrogator.fnisinstealthidle]]()) {
            continue;
          }
        }

        break;
      }

      scripts\sp\anim::anim_reach_cleanup_solo(self.interrogator);
    }

    LOC_000006ee:
      if(!isalive(self.interrogator)) {
        return;
      }

    self notify("resume_interrogation");
    self.animnode notify("stop_loop_hvt");
    scripts\engine\sp\utility::anim_stopanimScripted();
    self.interrogator scripts\sp\nvg\nvg_ai::flashlight_off(0);
    self.interrogator[[self.interrogator.fnstealthflashlightdetach]]();

    if(isDefined(self.interrogator.cattleprod)) {
      self.interrogator.cattleprod show();
    }

    self stopsounds();
  }
}

function delete_cattleprod() {
  self.cattleprod delete();
  return grounds_axis_deathfunc();
}

function hvt_breakout_think(var_0, var_1, var_2, var_3, var_4) {
  level endon("obj_scene_started");

  for(;;) {
    var_5 = level scripts\engine\utility::waittill_any_in_array_return(var_0);
    self.breakout = 1;
    self.breakout_wait = isDefined(var_4) && isDefined(var_4[var_5]);
    var_6 = scripts\engine\utility::waittill_any_ents_return(level, var_1, self, "stop_interrogation");

    if(var_6 == "stop_interrogation") {
      var_7 = var_2[var_5];

      if(self.breakout_wait) {
        level waittill(var_1);
        self.animnode notify("stop_loop_hvt");
        scripts\engine\sp\utility::anim_stopanimScripted();
      }

      if(isDefined(self.chair)) {
        self.animnode thread scripts\common\anim::anim_single_solo(self.chair, var_7);
      }

      self.animnode scripts\common\anim::anim_single_solo(self, var_7);
      self.animnode thread scripts\common\anim::anim_loop_solo(self, var_3, "stop_loop_hvt");
    }

    self.breakout = undefined;
    self.breakout_wait = undefined;
    self notify("breakout_end");

    if(!isalive(self.interrogator)) {
      return;
    }

    self.interrogator notify("breakout_end");
  }
}

function cattleprod_think() {
  level endon("hvt_found");
  scripts\common\anim::addnotetrack_notify("interrogator", "prod_start", "church_cattleprod_start", "church_interrogation");
  scripts\common\anim::addnotetrack_notify("interrogator", "prod_end", "church_cattleprod_end", "church_interrogation");
  var_0 = scripts\engine\utility::getfx("vfx_estate_cattleprod_sparks_01");

  while(isalive(self)) {
    scripts\engine\utility::waittill_any_ents(level, "church_cattleprod_start", self, "death");

    if(!isalive(self)) {
      break;
    }

    playFXOnTag(var_0, self.cattleprod, "tag_fx_prod");
    self.cattleprod playSound("cattleprod_start");
    self.cattleprod playLoopSound("cattleprod_lp");
    scripts\engine\utility::waittill_any_ents(level, "church_cattleprod_end", self, "stealth_investigate", self, "stealth_combat", self, "death");

    if(isDefined(self.cattleprod)) {
      killfxontag(var_0, self.cattleprod, "tag_fx_prod");
      self.cattleprod stoploopsound();
      self.cattleprod playSound("cattleprod_stop");
    }
  }
}

function vo_hvt_think() {
  self endon("dying");
  self endon("death");
  self endon("knockout");
  self endon("resume_interrogation");
  var_0 = getEnt(self.location + "_hvt_damage_trig", "targetname");
  var_1 = 5;
  var_2 = [];
  var_3 = 500;
  var_4 = 0;

  while(!istrue(self.dead)) {
    if(!var_4 && istrue(self.is_yelling)) {
      var_4 = 1;
      var_5 = "start_yelling";
    } else {
      var_5 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var_1, var_0, "trigger", self, "start_yelling", level.player, "weapon_fired");
    }

    if(istrue(self.dead)) {
      return;
    }

    if(var_5 == "timeout" || var_5 == "start_yelling") {
      if(istrue(self.identify_anim_playing)) {
        continue;
      }

      var_6 = 0;

      foreach(var_8 in scripts\engine\utility::get_array_of_closest(self.origin, getaiarray("axis"), undefined, undefined, 500)) {
        if(var_8[[var_8.fnisinstealthcombat]]()) {
          var_6 = 1;
          break;
        }
      }

      if(var_6) {
        continue;
      }

      if(istrue(self.is_yelling)) {
        scripts\engine\sp\utility::smart_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group(self.location + "_yelling"));
        var_10 = scripts\engine\utility::get_array_of_closest(self.origin, getaiarray("axis"), var_2, undefined, var_3);

        foreach(var_8 in var_10) {
          if(!var_8[[var_8.fnisinstealthcombat]]()) {
            var_8 aieventlistenerevent("cover_blown", self, self.origin);
          }

          var_2 = var_8;
        }

        if(var_3 < 1500) {
          var_3 = min(var_3 + 500, 1500);
        }

        var_1 = randomfloatrange(0.5, 1.5);
      } else if(distancesquared(level.player.origin, self.origin) > squared(1000)) {
        continue;
      } else if(istrue(self.is_target)) {
        scripts\engine\sp\utility::smart_dialogue(self.correct_alias);
        var_1 = randomfloatrange(0, 1);
      } else {
        scripts\engine\sp\utility::smart_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group(self.location + "_playernear"));
        var_1 = randomfloatrange(2, 5);
      }

      continue;
    }

    if(var_5 == "weapon_fired" && !level.player istouching(var_0)) {
      continue;
    }

    self stopsounds();
    waitframe();
    scripts\engine\sp\utility::smart_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group(self.location + "_gunshots"));
    wait randomfloatrange(0.5, 1.5);

    if(level.hvt_locations.size == 1 && !istrue(self.identified) || getdvarint("greenlight")) {
      var_1 = 0.5;
      continue;
    }

    var_1 = 5;
  }
}

function hvt_yelling_anim_think() {
  level endon("obj_scene_started");
  self endon("death");
  self endon("knockout");

  while(level.player scripts\engine\math::point_in_fov(self.origin, 0)) {
    waitframe();
  }

  if(istrue(self.dead)) {
    return;
  }

  self.animnode notify("stop_loop_hvt");
  self.animnode thread scripts\common\anim::anim_loop_solo(self, self.location + "_yelling", "stop_loop_hvt");
  self.is_yelling = 1;
  self notify("start_yelling");
}

function init_interrogator() {
  self endon("death");
  self.stealth.investigatemintime = 10;
  self.stealth.investigatemaxtime = 15;
  self.stealth.funcs["event_investigate"] = &interrogator_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &interrogator_stealth_filter;
  self.stealth.funcs["event_combat"] = &interrogator_stealth_filter;
  self.stealth.funcs["should_hunt"] = &interrogator_should_hunt;
  self.stealth.funcs["hidden"] = &resume_interrogation;
  self.in_combat = 0;
  self.anglelerprate = 90;
  thread interrogator_dmg_think();
}

function interrogator_dmg_think() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_0, var_2);

    if(self.in_combat) {
      continue;
    }

    self aieventlistenerevent("attack", var_1, var_2);
  }
}

function resume_interrogation() {
  self.in_combat = 0;
}

function interrogator_stealth_filter(var_0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var_0)) {
    return true;
  }

  if(var_0.type == "combat") {
    self.in_combat = 1;
  }

  self stopsounds();
  return false;
}

function interrogator_should_hunt() {
  return false;
}

function identify_anim_think() {
  level notify("identify_anim_started");
  level notify("grounds_save");
  var_0 = self.location + "_idle";
  var_1 = self.location + "_interact";

  if(level.hvts_identified == 2) {
    var_1 += "_final";
  }

  scripts\sp\utility::context_melee_enable(0);
  self.animnode scripts\sp\player_rig::link_player_to_rig(var_1, "crouch", 1, 0.5, 0, 15, 15, 15, 15, 1, undefined, 1);
  thread identify_anim_unlink_player_on_damage(level.player_rig);
  self.animnode notify("stop_loop_hvt");
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.identify_anim_playing = 1;
  self stopsounds();
  scripts\engine\sp\utility::player_dialogue_stop();
  scripts\engine\sp\utility::radio_dialogue_stop();
  self.animnode thread scripts\common\anim::anim_single([self, level.player_rig], var_1);
  level.player_rig thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "end_interact");
  var_2 = scripts\engine\utility::waittill_any_ents_return(level.player_rig, "end_interact", level, "hvt_interact_interrupted");

  if(var_2 == "hvt_interact_interrupted") {
    self notify("interact_interrupted");
    self stopsounds();
    self.identify_anim_playing = undefined;
    scripts\sp\anim_notetrack::mayhem_end(scripts\engine\utility::getanim(var_1 + "_mayhem"));
    scripts\engine\sp\utility::anim_stopanimScripted();
    self.animnode thread scripts\common\anim::anim_loop_solo(self, var_0, "stop_loop_hvt");
    return;
  }

  check_hvt();
  thread vo_identify_hvt();
  scripts\sp\player_rig::unlink_player_from_rig(1);
  scripts\sp\utility::context_melee_enable(1);
  level.player notify("identify_anim_complete");
  level notify("grounds_save");
  thread hvt_death_post_interact();
  self endon("death");
  self endon("dying");
  self endon("knockout");
  self waittillmatch("single anim", "end");
  self.identify_anim_playing = undefined;
  self.animnode thread scripts\common\anim::anim_loop_solo(self, var_0, "stop_loop_hvt");

  if(level.hvts_identified == 2) {
    thread hvt_yelling_anim_think();
    return;
  }
}

function vo_identify_hvt() {
  var_0 = undefined;
  var_1 = undefined;

  if(self.is_target) {
    if(scripts\engine\utility::flag("player_in_combat")) {
      var_1 = "dx_vom_kyle_hvt_correct_05";
    } else {
      var_1 = "dx_vom_kyle_hvt_correct_04";
    }

    var_0 = "dx_vom_pri_hvt_correct_100";
    level.player scripts\sp\maps\estate\estate_util::kyle_line(var_1);
    level.player scripts\engine\sp\utility::smart_radio_dialogue(var_0);
  } else {
    level notify("objectives_updated");

    if(level.hvts_identified == 1) {
      if(scripts\engine\utility::flag("player_in_combat")) {
        var_1 = "dx_vom_kyle_hvt_notfound_171";
      } else {
        var_1 = "mansion_kyle_itsnothim";
      }
    } else if(scripts\engine\utility::flag("player_in_combat")) {
      var_1 = "dx_vom_kyle_hvt_notfound_191";
    } else {
      var_1 = "dx_vom_kyle_hvt_notfound_190";
    }

    thread post_hvt_fadeout();

    if(level.hvts_identified == 1) {
      switch (self.location) {
        case "church":
          var_0 = "dx_vom_pri_hvt_incorrect_30";
          break;
        case "courtyard":
          var_0 = "dx_vom_pri_hvt_incorrect_10";
          break;
        case "pool":
          var_0 = "dx_vom_pri_hvt_incorrect_20";
          break;
      }
    } else {
      switch (get_final_hvt_location()) {
        case "church":
          var_0 = "dx_vom_pri_hvt_final_10";
          break;
        case "courtyard":
          var_0 = "dx_vom_pri_hvt_final_20";
          break;
        case "pool":
          var_0 = "dx_vom_pri_hvt_final_30";
          break;
      }
    }

    var_2 = request_overwatch_vo("objective", var_0, 1, 1, "identify_hvt_vo");
    level.player scripts\sp\maps\estate\estate_util::kyle_line(var_1);

    if(level.hvts_identified == 2) {
      level.player scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_hvt_notfound_220");
    }

    level notify("identify_hvt_vo");
    level waittill("overwatch_vo_completed");
  }

  if(level.hvts_identified != 2) {
    level.player thread scripts\sp\player::focus_display_hint(0, 7);
    return;
  }
}

function estate_gl_endtag_delay_music_change() {}

function identify_anim_unlink_player_on_damage(var_0) {
  level.player endon("identify_anim_complete");
  level.player waittill("damage", var_1, var_2, var_3);
  scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  scripts\sp\utility::context_melee_enable(1);
  earthquake(1, 0.3, level.player.origin, 100);
  level.player playRumbleOnEntity("light_1s");
  var_4 = vectorNormalize(var_3) * var_1 * 2;
  level.player setvelocity(var_4);
  level notify("hvt_interact_interrupted");
}

function hvt_death_pre_interact() {
  self endon("identified");
  self setCanDamage(1);
  self.health = 1300;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_5, var_5, var_5, var_6);

    if(var_1 != level.player || isDefined(var_6) && scripts\engine\utility::is_equal(var_6.basename, "flash")) {
      self.health += var_0;
      continue;
    }

    if(self.health <= 1000 || issubstr(var_4, "MOD_GRENADE")) {
      thread hvt_die(var_1, var_2, var_3, var_4);
      scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::random([54, 436, 437]));
      scripts\sp\utility::missionfailedwrapper();
      return;
    }

    playFX(scripts\engine\utility::getfx("flesh_hit"), var_3, var_2 * -1);
  }
}

function hvt_death_post_interact() {
  level endon("obj_scene_started");
  self.health = 1025;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(istrue(self.identify_anim_playing) && var_1 != level.player) {
      self.health += var_0;
      continue;
    }

    if(var_4 == "MOD_MELEE") {
      self.health += var_0;

      if(istrue(self.knocked_out)) {
        continue;
      }

      self.is_yelling = undefined;
      self.knocked_out = 1;
      self notify("knockout");
      self stopsounds();
      hvt_death_anim(var_2);
      thread hvt_snore_think();
      continue;
    }

    if(self.health <= 1000) {
      thread hvt_die(var_1, var_2, var_3, var_4);

      if(var_1 == level.player && !istrue(self.is_yelling)) {
        wait 1;

        if(gettime() - level.player scripts\sp\friendlyfire::get_most_recent_dmg_or_death_time() > 2000) {
          scripts\sp\player_death::set_custom_death_quote(55);
          scripts\sp\utility::missionfailedwrapper();
          return;
        }
      }

      level notify("grounds_save");
      return;
    }
  }
}

function hvt_die(var_0, var_1, var_2, var_3) {
  if(istrue(self.dead)) {
    return;
  }

  self notify("dying");
  self.dead = 1;
  self stopsounds();

  if(var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_GRENADE") {
    scripts\asm\soldier\death::dogib();
    self hide();
  } else if(var_3 == "MOD_FIRE") {
    self setModel("burntbody_male");
    self detach(self.headmodel, "");
    self playSound("generic_flamedeath_enemy_" + randomint(8) + 1);
    thread scripts\sp\equipment\molotov::molotov_burn_sfx(1);

    if(!istrue(self.breakout) && !istrue(self.interrogating) && !istrue(self.knocked_out)) {
      var_4 = self.location + "_yelling";
      self.animnode notify("stop_loop_hvt");
      scripts\engine\sp\utility::anim_stopanimScripted();
      scripts\common\anim::addnotetrack_notify("hvt", "burn_end", "hvt_burn_end", var_4);
      self.animnode thread scripts\common\anim::anim_loop_solo(self, var_4, "stop_loop_hvt");
      level waittill("hvt_burn_end");
      self setanimrate(scripts\engine\utility::getanim(var_4)[0], 0);
      self.animnode notify("stop_loop_hvt");
      scripts\asm\shared\utility::setfacialindexfornonai("none");
    }
  } else {
    playFX(scripts\engine\utility::getfx("flesh_hit"), var_2, var_1 * -1);
    self playSound("generic_death_enemy_" + randomint(8) + 1);

    if(!istrue(self.knocked_out)) {
      thread hvt_death_anim(var_1);
    } else {
      self startragdoll();
    }
  }

  scripts\stealth\event::event_broadcast_axis_by_sight("ally_killed", self, self gettagorigin("tag_eye"), 512, 1);
  self notify("death", var_0);
}

function hvt_death_anim(var_0) {
  var_1 = [self];
  var_2 = anglesToForward(self.angles);
  var_3 = vectordot(var_2, var_0);
  var_4 = self.location + "_death_";

  if(var_3 < 0) {
    var_4 += "backward";
  } else {
    var_4 += "forward";
  }

  if(isDefined(self.chair) && var_3 < 0) {
    var_1 = self.chair;
  }

  self.animnode notify("stop_loop_hvt");
  scripts\engine\sp\utility::anim_stopanimScripted();

  if(!istrue(self.knocked_out)) {
    scripts\asm\shared\utility::setfacialindexfornonai("none");
  }

  self scriptmoverdistancefade();
  self.animnode scripts\common\anim::anim_single(var_1, var_4);
}

function hvt_snore_think() {
  self endon("death");
  level endon("obj_scene_started");

  while(!istrue(self.dead)) {
    thread scripts\engine\sp\utility::play_sound_on_tag(self.ko_alias, "tag_eye", 1, "sounddone");
    self waittill("sounddone");
    wait 0.1;
  }
}

function get_final_hvt_location() {
  return level.hvt_locations[0];
}

function greenlight_fadeout(var_0) {
  wait 9.95;
  level.player scripts\common\utility::allow_death(0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_hud", 1);
  setomnvar("ui_hide_weapon_info", 1);
  scripts\sp\hud_util::fade_out(0.05);
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 0.05);
  wait 9;
  scripts\engine\sp\utility::nextmission();
}

function try_spawn_backup(var_0, var_1) {
  level.player endon("death");
  level endon(var_0 + "_lost_player");
  var_2 = gettime();

  if(getdvarint("greenlight")) {
    return;
  }

  if(scripts\engine\utility::flag("hvt_found")) {
    return;
  }

  if(!backup_technical_check_passed(var_0)) {
    return;
  }

  if(getspawnerarray(var_0 + "_backup_spawner").size == 0) {
    return;
  }

  if(scripts\engine\utility::flag(var_0 + "_backup_spawned")) {
    return;
  }

  wait 3;
  scripts\engine\utility::flag_wait(var_0 + "_under_attack");
  scripts\engine\utility::flag_wait("player_gone_hot");

  if(!scripts\sp\maps\estate\estate_util::anyone_has_known_player_since_time(var_2, var_1)) {
    while(!scripts\sp\maps\estate\estate_util::anyone_has_known_player_since_time(var_2, var_1)) {
      waitframe();
    }

    wait 1;
  }

  var_3 = get_guys_in_stealthgroups(var_1);
  var_4 = undefined;

  for(;;) {
    if(scripts\engine\utility::flag("hvt_found")) {
      return;
    }

    if(!backup_technical_check_passed(var_0)) {
      return;
    }

    if(!scripts\sp\maps\estate\estate_util::alias_group_exists("backup_" + var_0)) {
      var_5 = [];

      switch (var_0) {
        case "mansion":
          var_5 = ["dx_vom_aq1_backup_call_40"];
          break;
        case "church":
          var_5 = ["dx_vom_aq1_backup_call_50", "dx_vom_aq2_backup_call_80", "dx_vom_aq3_backup_call_110"];
          break;
        case "courtyard":
          var_5 = ["dx_vom_aq1_backup_call_60", "dx_vom_aq2_backup_call_90", "dx_vom_aq3_backup_call_120"];
          break;
        case "pool":
          var_5 = ["dx_vom_aq1_backup_call_70", "dx_vom_aq2_backup_call_100", "dx_vom_aq3_backup_call_130"];
          break;
      }

      scripts\sp\maps\estate\estate_util::make_alias_group("backup_" + var_0, var_5);
    }

    var_3 = scripts\engine\utility::array_removedead_or_dying(var_3);

    if(!var_3.size) {
      return;
    }

    var_4 = scripts\engine\utility::getclosest(level.player.origin, var_3);
    var_6 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("backup_" + var_0);
    var_7 = gettime();
    var_4 thread scripts\engine\sp\utility::smart_dialogue_generic(var_6);
    var_4 scripts\engine\utility::waittill_any("single dialogue", "death", "start_context_melee");

    if(!isalive(var_4) || istrue(level.player.in_melee_death) && scripts\engine\utility::is_equal(level.player.context_melee_victim, var_4)) {
      var_4 stopsounds();

      if(gettime() - var_7 < 1000) {
        wait 5;
        continue;
      }
    }

    break;
  }

  thread spawn_backup(var_0, var_4);
}

function backup_technical_check_passed(var_0) {
  if(isDefined(level.technical)) {
    level.technical.should_intercept = 1;

    if(var_0 == "mansion") {
      return false;
    }
  }

  return true;
}

function spawn_backup(var_0, var_1) {
  level.player endon("death");

  if(!isDefined(level.spawning_backup)) {
    level.spawning_backup = 0;
  }

  level.spawning_backup++;
  scripts\engine\utility::flag_set(var_0 + "_backup_spawned");
  level notify("backup_spawned");
  var_2 = level.player.origin;
  var_3 = undefined;

  switch (var_0) {
    case "mansion":
      var_3 = "dx_vom_aq2_backup_conf_10";
      break;
    case "church":
      var_3 = "dx_vom_aq2_backup_conf_20";
      break;
    case "courtyard":
      var_3 = "dx_vom_aq2_backup_conf_30";
      break;
    case "pool":
      var_3 = "dx_vom_aq2_backup_conf_40";
      break;
  }

  var_4 = scripts\engine\utility::spawn_script_origin();
  var_4 linkTo(var_1, "tag_eye", (0, 0, 0), (0, 0, 0));
  wait 0.5;
  var_4 playSound(var_3, var_0 + "_backup_confirmed");
  var_4 thread scripts\engine\utility::delete_on_notify(var_0 + "_backup_confirmed");
  wait 2;
  jumpiffalse(var_0 == "mansion") LOC_0000017b;
  thread request_overwatch_vo("backup", "dx_vom_pri_backup_vehicle_10", 1, 1);
  var_5 = "mansion_backup_vehicle";

  if(getdvarint("use_physics_techo")) {
    var_5 += "_physics";
  }

  var_6 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var_5);
  waittillframeend();

  foreach(var_8 in var_6.riders) {
    var_8 scripts\engine\utility::delaycall(0.05, &aieventlistenerevent, "combat", level.player, var_2);
    thread backup_guy_think();
  }

  goto LOC_000002e4;
}

function get_guys_in_stealthgroups(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = level.stealth.groupdata.groups[var_3];

    if(isDefined(var_4)) {
      var_1 = scripts\engine\utility::array_combine(var_1, var_4.members);
    }
  }

  var_1 = scripts\engine\utility::array_removedead_or_dying(var_1);
  return var_1;
}

function backup_guy_think() {
  self endon("death");
  var_0 = level.stealth.hunt_volumes[self.script_stealthgroup];
  var_0 endon("death");

  if(level.player istouching(var_0)) {
    self.goalradius = 512;
    self cleargoalvolume();
    self setgoalpos(level.player.origin);
  } else {
    self setgoalvolumeauto(var_0);
  }

  self waittill("goal");
  level notify(self.script_stealthgroup + "_arrived", self);
  self setgoalvolumeauto(var_0);
}

function ambush_guy_think() {
  self endon("death");
  var_0 = level.stealth.hunt_volumes[self.script_stealthgroup];
  var_0 endon("death");
  self.goalradius = 32;
  self cleargoalvolume();
  var_1 = getnode(self.target, "targetname");
  self setgoalnode(var_1);

  while(!self cansee(level.player)) {
    wait 0.1;
  }

  wait 4;
  self setgoalvolumeauto(var_0);
}

function fusebox_switchoff_think() {
  level endon("obj_scene_started");
  self waittill("lightswitch_toggle");

  if(istrue(self.destroyed)) {
    return;
  }

  var_0 = [];

  foreach(var_2 in strtok(self.script_parameters, " ")) {
    var_3 = scripts\stealth\group::getgroup(var_2);

    if(isDefined(var_3)) {
      var_0 = scripts\engine\utility::array_combine(var_0, var_3.members);
    }
  }

  var_0 = scripts\engine\utility::array_removeundefined(var_0);

  if(!var_0.size) {
    return;
  }

  var_5 = [];

  foreach(var_7 in var_0) {
    if(scripts\engine\utility::is_equal(var_7.script_noteworthy, "interrogator")) {
      continue;
    }

    if(var_7[[var_7.fnisinstealthhunt]]() || var_7[[var_7.fnisinstealthcombat]]()) {
      continue;
    }

    var_5 = var_7;
  }

  var_9 = self.origin + anglesToForward(self.angles) * 64;
  var_10 = scripts\sp\maps\estate\estate_util::get_closest_guy_by_path(var_9, var_5);

  if(!isDefined(var_10)) {
    return;
  }

  var_9 = getclosestpointonnavmesh(var_9, var_10);

  if(isDefined(var_9)) {
    thread investigate_fusebox(var_10, self);
    return;
  }
}

function investigate_fusebox(var_0, var_1) {
  self endon("death");
  scripts\engine\sp\utility::set_battlechatter(0);
  scripts\stealth\enemy::trigger_cover_blown();
  waitframe();
  self aieventlistenerevent("reset", self, self.origin);
  wait 0.75;
  thread scripts\engine\sp\utility::smart_dialogue_generic("mansion_aq2_lightsout");
  var_0.runner = self;
  self.fusebox = var_0;
  self.og_goalradius = self.goalradius;
  self.goalradius = 32;
  self.stealth.funcs["event_investigate"] = &fusebox_runner_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &fusebox_runner_stealth_filter;
  self notify("stop_going_to_node");
  scripts\engine\sp\utility::set_goal_pos(var_1);

  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_return("goal", "stop_turn_on_fusebox", "stealth_combat");

    if(var_2 == "goal") {
      if(distance2dsquared(self.origin, var_1) > squared(self.goalradius)) {
        continue;
      }

      self.patrol_custom_face_angle = var_0.angles[1] - 180;
      wait 1.5;
      self.patrol_custom_face_angle = undefined;

      if(!getdvarint("greenlight")) {
        scripts\engine\sp\utility::smart_dialogue_generic(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("fusebox_call"));
        self playsoundatviewheight(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("fusebox_response"));
      }

      scripts\engine\utility::delaycall(0.05, &aieventlistenerevent, "cover_blown", self, self.origin);
      self.goalradius = self.og_goalradius;
    }

    self.fusebox = undefined;
    self.stealth.funcs["event_investigate"] = undefined;
    self.stealth.funcs["event_cover_blown"] = undefined;
    scripts\engine\sp\utility::set_battlechatter(1);
    return;
  }
}

function fusebox_runner_stealth_filter(var_0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var_0)) {
    return true;
  }

  var_1 = ["sight", "grenade danger", "projectile_impact", "bulletwhizby", "explode", "gunshot", "gunshot_teammate"];

  if(self.fusebox.script_light_switch_state || isDefined(var_0.typeorig) && scripts\engine\utility::array_contains(var_1, var_0.typeorig)) {
    self notify("stop_turn_on_fusebox");
    return false;
  }

  if(scripts\engine\utility::is_equal(var_0.typeorig, "saw_corpse")) {
    scripts\stealth\corpse::corpse_clear();
  }

  return true;
}

function body_drag_door_scene() {
  level endon("obj_scene_started");
  var_0 = scripts\engine\utility::getStruct("body_drag_door_scene", "targetname");
  var_1 = getspawner("body_drag_door_actor", "script_noteworthy");
  var_1 waittill("spawned", var_2);

  if(scripts\engine\utility::flag("player_gone_hot")) {
    return;
  }

  thread vignette_actor_init(var_2);
  var_3 = var_0 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var_4 = var_0 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var_5 = sortbydistance(getEntArray("interactive_door", "script_noteworthy"), var_0.origin)[0];
  var_5 scripts\sp\door::create_navobstacle();
  var_2.animname = "alq1";
  var_3.animname = "body1";
  var_4.animname = "body2";
  var_5.animname = "door";
  var_3 scripts\engine\sp\utility::assign_animtree();
  var_4 scripts\engine\sp\utility::assign_animtree();
  var_5 scripts\engine\sp\utility::assign_animtree();
  var_0.actor = var_2;
  var_0.body1 = var_3;
  var_0.body2 = var_4;
  var_0.door = var_5;
  scripts\common\anim::addnotetrack_notify("body1", "body_up", "body_drag_door_body1_up", "body_drag_door");
  scripts\common\anim::addnotetrack_notify("body1", "body_down", "body_drag_door_body1_down", "body_drag_door");
  scripts\common\anim::addnotetrack_notify("body2", "body_up", "body_drag_door_body2_up", "body_drag_door");
  scripts\common\anim::addnotetrack_notify("body2", "body_down", "body_drag_door_body2_down", "body_drag_door");
  scripts\common\anim::addnotetrack_flag("door", "door_open", "body_drag_door_open_start", "body_drag_door");
  scripts\common\anim::addnotetrack_flag("door", "door_open_first", "body_drag_door_open_end", "body_drag_door");
  body_drag_door_scene_think(var_0);
  level notify("body_drag_door_scene_cleanup");
  var_5 scripts\sp\door::clear_navobstacle();

  if(isalive(var_2)) {
    vignette_actor_cleanup(var_2);
    return;
  }
}

function body_drag_door_scene_think() {
  level endon("obj_scene_started");
  var_0 = self.actor;
  var_1 = self.body1;
  var_2 = self.body2;
  var_3 = self.door;
  var_4 = 1;

  for(;;) {
    var_0.flashlightoverride = 0;
    var_0 scripts\sp\utility::enable_flashlight(0);
    thread scripts\common\anim::anim_first_frame_solo(var_2, "body_drag_door");

    if(!var_4) {
      var_0.deathanim = undefined;
      var_0.noragdoll = undefined;
      thread scripts\common\anim::anim_single_solo(var_0, "body_drag_door_idle_enter");
      thread scripts\common\anim::anim_first_frame_solo(var_1, "body_drag_door_idle");
      var_0 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "begin_idle");
      var_0 scripts\engine\utility::waittill_any("begin_idle", "stealth_investigate", "stealth_combat", "death");

      if(!isalive(var_0)) {
        return;
      }

      if(!var_0[[var_0.fnisinstealthidle]]()) {
        var_0 scripts\engine\sp\utility::anim_stopanimScripted();

        if(var_0[[var_0.fnisinstealthcombat]]()) {
          return;
        }

        var_0.flashlightoverride = undefined;
        var_5 = try_resume_vignette(var_0, "body_drag_door_idle_enter");

        if(istrue(var_5) && !var_3.bashed && !var_3.ajar) {
          continue;
        } else {
          return;
        }
      } else if(var_3.bashed || var_3.ajar) {
        var_0 aieventlistenerevent("cover_blown", level.player, var_3.origin);
        thread scripts\common\anim::anim_single_solo(var_0, "body_drag_door_react_investigate");
        return;
      }
    }

    var_4 = 0;
    var_0.deathanim = level.scr_anim["alq1"]["body_drag_door_death"];
    var_0.noragdoll = 1;
    thread scripts\common\anim::anim_loop([var_0, var_1], "body_drag_door_idle");
    scripts\engine\utility::waittill_any_ents(level, "body_drag_door_go", var_0, "stealth_investigate", var_0, "stealth_combat", var_0, "death");
    self notify("stop_loop");
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();

    if(!isalive(var_0)) {
      thread scripts\common\anim::anim_single_solo(var_1, "body_drag_door_death");
      return;
    }

    var_0.deathanim = undefined;
    var_0.noragdoll = undefined;
    var_0 scripts\engine\sp\utility::anim_stopanimScripted();

    if(scripts\engine\utility::flag("body_drag_door_go")) {
      break;
    }

    thread scripts\common\anim::anim_first_frame_solo(var_1, "body_drag_door_idle");

    if(var_0[[var_0.fnisinstealthcombat]]()) {
      thread scripts\common\anim::anim_single_solo(var_0, "body_drag_door_react_combat");
      return;
    }

    var_0.flashlightoverride = undefined;

    if(var_0.should_combat_react) {
      thread scripts\common\anim::anim_single_solo(var_0, "body_drag_door_react_combat");
    } else {
      thread scripts\common\anim::anim_single_solo(var_0, "body_drag_door_react_investigate");
    }

    var_5 = try_resume_vignette(var_0, "body_drag_door_idle_enter");

    if(istrue(var_5) && !var_3.bashed && !var_3.ajar) {
      continue;
    }

    return;
  }

  thread body_drag_door_bodies_think();
  thread body_drag_door_door_think();
  thread vo_body_drag_door();
  thread scripts\common\anim::anim_single([var_0, var_1, var_2, var_3], "body_drag_door");
  var_6 = waittill_anim_finish_or_interrupted(var_0);

  if(!isDefined(var_6)) {
    if(isDefined(var_0)) {
      var_0 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(!scripts\engine\utility::flag("body_drag_door_open_start")) {
      var_3 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(!isDefined(self.body2_dropped)) {
      if(isDefined(self.current_body)) {
        self.current_body scripts\engine\sp\utility::anim_stopanimScripted();
        self.current_body startragdoll();

        if(self.current_body == var_1) {
          thread scripts\common\anim::anim_first_frame_solo(var_2, "body_drag_door");
          return;
        }

        return;
      }

      if(isDefined(self.body1_dropped)) {
        thread scripts\common\anim::anim_first_frame_solo(var_2, "body_drag_door");
        return;
      }

      thread scripts\common\anim::anim_first_frame([var_1, var_2], "body_drag_door");
      return;
    }

    return;
  }
}

function vo_body_drag_door() {
  self endon("death");
  self endon("start_context_melee");
  self endon("stealth_investigate");
  self endon("stealth_combat");
  level waittill("body_drag_door_body1_up");
  wait 2;
  scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_bodydrag_10");
  level waittill("body_drag_door_body2_up");
  wait 2;
  scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_bodydrag_20");
}

function body_drag_door_bodies_think() {
  level endon("body_drag_door_scene_cleanup");
  level waittill("body_drag_door_body1_up");
  self.current_body = self.body1;
  level waittill("body_drag_door_body1_down");
  self.current_body = undefined;
  self.body1_dropped = 1;
  level waittill("body_drag_door_body2_up");
  self.current_body = self.body2;
  level waittill("body_drag_door_body2_down");
  self.current_body = undefined;
  self.body2_dropped = 1;
}

function body_drag_door_door_think() {
  level endon("body_drag_door_scene_cleanup");
  scripts\engine\utility::waittill_any_ents(level, "body_drag_door_open_start", self.door, "first_interact", self.door, "bashed");

  if(scripts\engine\utility::flag("body_drag_door_open_start")) {
    self.door thread scripts\sp\door::remove_open_ability();
    self.door.open_completely = 1;
    self.door scripts\engine\sp\utility::flagwaitthread("body_drag_door_open_end", &scripts\engine\sp\utility::anim_stopanimscripted);
    return;
  }

  self.door scripts\engine\sp\utility::anim_stopanimScripted();
  self.actor aieventlistenerevent("cover_blown", level.player, self.door.origin);
}

function setup_grounds_dumpster_scene() {
  level endon("obj_scene_started");
  var_0 = scripts\engine\utility::getStruct("body_drag_dumpster_scene", "targetname");
  var_1 = getspawner("body_drag_dumpster_actor1", "script_noteworthy");
  var_1 waittill("spawned", var_2);
  var_1 = getspawner("body_drag_dumpster_actor2", "script_noteworthy");
  var_1 waittill("spawned", var_3);

  if(scripts\engine\utility::flag("player_gone_hot")) {
    return;
  }

  var_0.actor1 = var_2;
  var_0.actor2 = var_3;
  var_0.body1 = var_0 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var_0.body2 = var_0 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var_0.actor1.animname = "alq1";
  var_0.actor2.animname = "alq2";
  var_0.body1.animname = "body1";
  var_0.body2.animname = "body2";
  var_0.body1 scripts\engine\sp\utility::assign_animtree();
  var_0.body2 scripts\engine\sp\utility::assign_animtree();
  thread vo_body_drag_dumpster(var_2, var_3);
  thread body_drag_dumpster_scene(var_0);
}

function body_drag_dumpster_scene(var_0) {
  thread vignette_actor_init(var_0.actor1);
  thread vignette_actor_init(var_0.actor2);
  scripts\common\anim::addnotetrack_notify("body1", "body_up", "body_drag_dumpster_body1_up", "body_drag_dumpster");
  scripts\common\anim::addnotetrack_notify("body1", "body_down", "body_drag_dumpster_body1_down", "body_drag_dumpster");
  scripts\common\anim::addnotetrack_notify("body2", "body_up", "body_drag_dumpster_body2_up", "body_drag_dumpster");
  scripts\common\anim::addnotetrack_notify("body2", "body_down", "body_drag_dumpster_body2_down", "body_drag_dumpster");
  scripts\common\anim::addnotetrack_customfunction("alq1", "stand_up", &dumpster_guy_stand_up, "body_drag_dumpster");
  body_drag_dumpster_scene_think(var_0);
  level notify("body_drag_dumpster_scene_cleanup");
  scripts\engine\utility::flag_clear("body_drag_dumpster_go");

  foreach(var_2 in [var_0.actor1, var_0.actor2]) {
    if(isalive(var_2)) {
      vignette_actor_cleanup(var_2);
    }
  }
}

function dumpster_guy_stand_up(var_0) {
  var_0.is_standing = 1;
}

function body_drag_dumpster_scene_think() {
  level endon("obj_scene_started");
  var_0 = self.actor1;
  var_1 = self.actor2;
  var_2 = self.body1;
  var_3 = self.body2;
  var_0.deathanim = level.scr_anim["alq1"]["body_drag_dumpster_death"];
  var_0.noragdoll = 1;
  var_1.deathanim = level.scr_anim["alq2"]["body_drag_dumpster_death"];
  var_1.noragdoll = 1;
  var_4 = 0;

  for(;;) {
    thread scripts\common\anim::anim_loop([var_0, var_1, var_2], "body_drag_dumpster_idle");
    thread scripts\common\anim::anim_first_frame_solo(var_3, "body_drag_dumpster");
    scripts\engine\utility::waittill_any_ents(level, "body_drag_dumpster_go", var_0, "stealth_investigate", var_0, "stealth_combat", var_0, "death", var_1, "stealth_investigate", var_1, "stealth_combat", var_1, "death");
    self notify("stop_loop");

    if(isDefined(var_0)) {
      var_0 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(isDefined(var_1)) {
      var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    var_2 scripts\engine\sp\utility::anim_stopanimScripted();

    if(!isalive(var_0) || !isalive(var_1)) {
      level notify("dumpster_vignette_interupted");

      if(isalive(var_0)) {
        if(var_0.health < var_0.maxhealth) {
          thread scripts\common\anim::anim_single([var_0, var_2], "body_drag_dumpster_react_pain");
        } else {
          thread scripts\common\anim::anim_single([var_0, var_2], "body_drag_dumpster_react_combat");
        }
      } else {
        thread scripts\common\anim::anim_single_solo(var_2, "body_drag_dumpster_death");
      }

      if(isalive(var_1)) {
        if(var_1.health < var_1.maxhealth) {
          thread scripts\common\anim::anim_single_solo(var_1, "body_drag_dumpster_react_pain");
          return;
        }

        thread scripts\common\anim::anim_single_solo(var_1, "body_drag_dumpster_react_combat");
      }

      return;
    }

    if(scripts\engine\utility::flag("body_drag_dumpster_go")) {
      break;
    }

    if(var_0[[var_0.fnisinstealthcombat]]() || var_1[[var_1.fnisinstealthcombat]]()) {
      var_4 = 1;

      if(var_0.health < var_0.maxhealth) {
        thread scripts\common\anim::anim_single([var_0, var_2], "body_drag_dumpster_react_pain");
      } else {
        thread scripts\common\anim::anim_single([var_0, var_2], "body_drag_dumpster_react_combat");
      }

      if(var_1.health < var_1.maxhealth) {
        thread scripts\common\anim::anim_single_solo(var_1, "body_drag_dumpster_react_pain");
      } else {
        thread scripts\common\anim::anim_single_solo(var_1, "body_drag_dumpster_react_combat");
      }
    } else {
      var_4 = 1;

      if(var_0.should_combat_react || var_1.should_combat_react) {
        thread scripts\common\anim::anim_single([var_0, var_1, var_2], "body_drag_dumpster_react_combat");
      } else {
        thread scripts\common\anim::anim_single([var_0, var_1, var_2], "body_drag_dumpster_react_investigate");
      }
    }

    if(var_4) {
      level notify("dumpster_vignette_interupted");
    }

    return;
  }

  var_0.deathanim = undefined;
  var_0.noragdoll = undefined;
  var_1.deathanim = undefined;
  var_1.noragdoll = undefined;
  thread body_drag_dumpster_bodies_think();
  thread scripts\common\anim::anim_single([var_0, var_1, var_2, var_3], "body_drag_dumpster");
  var_0 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "end_scene");
  scripts\engine\utility::waittill_any_ents(var_0, "end_scene", var_0, "stealth_investigate", var_0, "stealth_combat", var_0, "death", var_1, "stealth_investigate", var_1, "stealth_combat", var_1, "death");

  if(vignette_interrupted([var_0, var_1])) {
    level notify("dumpster_vignette_interupted");

    if(isalive(var_0)) {
      var_0 scripts\engine\sp\utility::anim_stopanimScripted();

      if(!istrue(var_0.is_standing)) {
        if(var_0.health < var_0.maxhealth) {
          thread scripts\common\anim::anim_single([var_0, var_2], "body_drag_dumpster_react_pain");
        } else if(var_0[[var_0.fnisinstealthcombat]]() || var_0.should_combat_react) {
          thread scripts\common\anim::anim_single([var_0, var_2], "body_drag_dumpster_react_combat");
        } else {
          thread scripts\common\anim::anim_single([var_0, var_2], "body_drag_dumpster_react_investigate");
        }
      }

      var_0.is_standing = undefined;
    }

    if(isalive(var_1)) {
      var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(!isDefined(self.body2_dropped)) {
      if(isDefined(self.current_body)) {
        self.current_body scripts\engine\sp\utility::anim_stopanimScripted();
        self.current_body stopsounds();
        self.current_body startragdoll();

        if(self.current_body == var_2) {
          thread scripts\common\anim::anim_first_frame_solo(var_3, "body_drag_dumpster");
          return;
        }

        return;
      }

      if(isDefined(self.body1_dropped)) {
        thread scripts\common\anim::anim_first_frame_solo(var_3, "body_drag_dumpster");
        return;
      }

      thread scripts\common\anim::anim_first_frame([var_2, var_3], "body_drag_dumpster");
      return;
    }

    return;
  }
}

function vo_body_drag_dumpster(var_0, var_1) {
  foreach(var_3 in [var_0, var_1]) {
    var_3 endon("death");
    var_3 endon("stealth_investigate");
    var_3 endon("stealth_combat");
    var_3 scripts\engine\sp\utility::set_battlechatter(0);
  }

  thread vo_body_drag_dumpster_interrupt_think(var_0, var_1);
  level waittill("body_drag_dumpster_go");
  var_5 = ["dx_vom_aq3_aqmisc_dumpster_20", "dx_vom_aq3_aqmisc_dumpster_40", "dx_vom_aq3_dumpster_liftcorpse1", "dx_vom_aq3_aqmisc_dumpster_100", "dx_vom_aq3_aqmisc_dumpster_140", "dx_vom_aq3_aqmisc_dumpster_160", "dx_vom_aq3_aqmisc_dumpster_180", "dx_vom_aq3_aqmisc_dumpster_220", "dx_vom_aq3_dumpster_liftcorpse2", "dx_vom_aq3_aqmisc_dumpster_60", "dx_vom_aq3_aqmisc_dumpster_240"];
  var_6 = ["dx_vom_aq2_aqmisc_dumpster_10", "dx_vom_aq2_aqmisc_dumpster_30", "dx_vom_aq2_aqmisc_dumpster_70", "dx_vom_aq2_aqmisc_dumpster_90", "dx_vom_aq2_aqmisc_dumpster_110", "dx_vom_aq2_aqmisc_dumpster_130", "dx_vom_aq2_aqmisc_dumpster_150", "dx_vom_aq2_dumpster_dragcorpse", "dx_vom_aq2_aqmisc_dumpster_210", "dx_vom_aq2_aqmisc_dumpster_50", "dx_vom_aq2_dumpster_liftcorpse2", "dx_vom_aq2_dumpster_liftcorpse3", "dx_vom_aq2_aqmisc_dumpster_230"];
  GscBinSkip4(0x6e, var_0, var_5);
}

function vo_body_drag_dumpster_actor(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    self waittillmatch("single anim", "pool_vo");
    thread scripts\engine\sp\utility::smart_dialogue_generic(var_0[var_1]);
  }

  level notify(self.animname + "_pool_vo_completed");
}

function vo_body_drag_dumpster_interrupt_think(var_0, var_1) {
  var_2 = scripts\engine\utility::waittill_any_ents_return(level, "pool_vo_completed", var_0, "death", var_0, "stealth_investigate", var_0, "stealth_combat", var_1, "death", var_1, "stealth_investigate", var_1, "stealth_combat");

  if(var_2 != "pool_vo_completed") {
    if(isalive(var_0)) {
      var_0 stopsounds();
    }

    if(isalive(var_1)) {
      var_1 stopsounds();
    }
  }

  waitframe();

  if(isalive(var_0)) {
    var_0 scripts\engine\sp\utility::set_battlechatter(1);
  }

  if(isalive(var_1)) {
    var_1 scripts\engine\sp\utility::set_battlechatter(1);
    return;
  }
}

function body_drag_dumpster_bodies_think() {
  level endon("body_drag_dumpster_scene_cleanup");
  level waittill("body_drag_dumpster_body1_up");
  self.current_body = self.body1;
  level waittill("body_drag_dumpster_body1_down");
  self.current_body = undefined;
  self.body1_dropped = 1;
  level waittill("body_drag_dumpster_body2_up");
  self.current_body = self.body2;
  level waittill("body_drag_dumpster_body2_down");
  self.current_body = undefined;
  self.body2_dropped = 1;
}

function car_rummage_scene(var_0) {
  level endon("obj_scene_started");
  var_1 = "car_rummage_" + var_0;
  var_2 = scripts\engine\utility::getStruct(var_1 + "_scene", "targetname");
  var_3 = var_2 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var_4 = undefined;

  foreach(var_6 in getEntArray(var_1 + "_car", "targetname")) {
    if(var_6.script_noteworthy == "car") {
      var_4 = var_6;
      break;
    }
  }

  var_3 scripts\engine\sp\utility::assign_animtree("body1");
  var_4 scripts\engine\sp\utility::assign_animtree("car");
  var_2 thread scripts\common\anim::anim_first_frame([var_3, var_4], var_1 + "_intro");
  var_8 = getspawner(var_1 + "_actor", "script_noteworthy");
  var_8 waittill("spawned", var_9);
  waittillframeend();

  if(scripts\engine\utility::flag("player_gone_hot")) {
    return;
  }

  thread vignette_actor_init();

  foreach(var_11 in var_4 scripts\engine\utility::get_linked_ents()) {
    var_11 linkTo(var_4, "tag_door_front_" + var_11.script_noteworthy);

    if(isstartstr(var_11.script_noteworthy, var_0)) {
      var_2.door = var_11;
    }
  }

  var_9.animname = "alq1";
  var_2.actor = var_9;
  var_2.body1 = var_3;
  var_2.car = var_4;
  scripts\common\anim::addnotetrack_flag("body1", "body_up", var_1 + "_body_up", var_1 + "_intro");
  car_rummage_scene_think(var_2, var_1);

  if(isalive(var_9)) {
    vignette_actor_cleanup(var_9);
    return;
  }
}

function car_rummage_scene_think(var_0) {
  level endon("obj_scene_started");
  var_1 = self.actor;
  var_2 = self.body1;
  var_3 = self.car;

  for(;;) {
    if(scripts\engine\utility::flag(var_0 + "_go")) {
      break;
    }

    scripts\engine\utility::waittill_any_ents(level, var_0 + "_go", var_1, "stealth_investigate", var_1, "stealth_combat", var_1, "death");

    if(!isalive(var_1) || var_1[[var_1.fnisinstealthcombat]]()) {
      return;
    } else if(var_1[[var_1.fnisinstealthinvestigate]]()) {
      var_1 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

      if(!isalive(var_1) || !var_1[[var_1.fnisinstealthidle]]()) {
        return;
      }

      continue;
    }

    break;
  }

  for(;;) {
    thread scripts\sp\anim::anim_reach_solo(var_1, var_0 + "_intro");
    var_1 scripts\engine\utility::waittill_any("anim_reach_complete", "stealth_investigate", "stealth_combat", "death");

    if(isalive(var_1) && var_1[[var_1.fnisinstealthidle]]()) {
      break;
    }

    scripts\sp\anim::anim_reach_cleanup_solo(var_1);

    if(!isalive(var_1) || var_1[[var_1.fnisinstealthcombat]]()) {
      return;
    }

    var_1 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

    if(!isalive(var_1) || var_1[[var_1.fnisinstealthcombat]]()) {
      return;
    }
  }

  var_1[[var_1.fnstealthflashlightdetach]]();
  thread scripts\common\anim::anim_single([var_1, var_2, var_3], var_0 + "_intro");
  var_4 = waittill_anim_finish_or_interrupted(var_1);
  self.door disconnectPaths();

  if(!isDefined(var_4)) {
    if(isalive(var_1)) {
      var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(scripts\engine\utility::flag(var_0 + "_body_up")) {
      var_2 startragdoll();
      scripts\engine\utility::flag_clear(var_0 + "_body_up");
    } else {
      var_2 setanimrate(level.scr_anim["body1"][var_0 + "_intro"], 0);
    }

    var_3 setanimrate(level.scr_anim["car"][var_0 + "_intro"], 0);
    return;
  }

  var_1.deathanimmode = "noclip";
  var_1.disabledeathorient = 1;
  var_1.deathanim = var_1 scripts\engine\utility::getanim(var_0 + "_death");
  var_1.stealth.cantracetoaiignoreents = [var_3, self.door, var_2];
  var_5 = ["dx_vom_aq1_aqmisc_lootcarloop_10", "dx_vom_aq2_aqmisc_lootcarloop_30", "dx_vom_aq3_aqmisc_lootcarloop_20"];
  var_1 thread scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(var_5));
  thread scripts\common\anim::anim_loop([var_1, var_2, var_3], var_0 + "_idle");
  var_1 scripts\engine\utility::waittill_any("stealth_investigate", "stealth_combat", "death", "move_for_technical");
  self notify("stop_loop");
  var_2 scripts\engine\sp\utility::anim_stopanimScripted();
  var_3 scripts\engine\sp\utility::anim_stopanimScripted();

  if(isalive(var_1)) {
    var_1.deathanim = undefined;
    var_1.disabledeathorient = 0;
    var_1.deathanimmode = undefined;
    var_1.stealth.cantracetoaiignoreents = undefined;
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    thread scripts\common\anim::anim_single([var_1, var_2, var_3], var_0 + "_react");
    var_1 setanimrate(var_1 scripts\engine\utility::getanim(var_0 + "_react"), 2);
    return;
  }

  if(isDefined(var_1)) {
    var_1 stopsounds();
  }

  thread scripts\common\anim::anim_single([var_2, var_3], var_0 + "_death");
}

function body_poke_scene() {
  level endon("obj_scene_started");
  var_0 = self.script_parameters;
  var_1 = scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var_1.animname = "body1";
  var_1 scripts\engine\sp\utility::assign_animtree();
  scripts\common\anim::anim_first_frame_solo(var_1, var_0);
  var_2 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_2 waittill("trigger", var_3);

  if(isDefined(var_3.context_melee_anim)) {
    return;
  }

  thread vignette_actor_init();
  var_3.animname = "alq1";
  var_3 notify("stop_going_to_node");
  var_3.target = var_2.targetname;
  self.body = var_1;
  self.actor = var_3;
  body_poke_scene_think(var_0, var_2);

  if(isalive(var_3)) {
    vignette_actor_cleanup(var_3);
    return;
  }
}

function body_poke_scene_think(var_0, var_1) {
  level endon("obj_scene_started");
  var_2 = self.actor;
  var_3 = self.body;

  if(isDefined(var_1.script_flag_wait)) {
    for(;;) {
      if(scripts\engine\utility::flag(var_1.script_flag_wait)) {
        break;
      }

      scripts\engine\utility::waittill_any_ents(level, var_1.script_flag_wait, var_2, "stealth_investigate", var_2, "stealth_combat", var_2, "death");

      if(!isalive(var_2) || var_2[[var_2.fnisinstealthcombat]]()) {
        return;
      } else if(var_2[[var_2.fnisinstealthinvestigate]]()) {
        var_2 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

        if(!isalive(var_2) || var_2[[var_2.fnisinstealthcombat]]()) {
          return;
        }

        continue;
      }

      break;
    }
  }

  for(;;) {
    thread scripts\sp\anim::anim_reach_and_approach_solo(var_2, var_0);
    var_2 scripts\engine\utility::waittill_any("anim_reach_complete", "stealth_investigate", "stealth_combat", "death");

    if(isalive(var_2) && var_2[[var_2.fnisinstealthidle]]()) {
      break;
    }

    scripts\sp\anim::anim_reach_cleanup_solo(var_2);

    if(!isalive(var_2) || var_2[[var_2.fnisinstealthcombat]]()) {
      return;
    }

    var_2 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

    if(!isalive(var_2) || var_2[[var_2.fnisinstealthcombat]]()) {
      return;
    }
  }

  var_2[[var_2.fnstealthflashlightdetach]]();
  thread scripts\common\anim::anim_single([var_2, var_3], var_0);
  var_2 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "scene_end");
  var_2 scripts\engine\utility::waittill_any("scene_end", "stealth_investigate", "stealth_combat", "death");

  if(!isalive(var_2) || !var_2[[var_2.fnisinstealthidle]]()) {
    var_3 scripts\engine\sp\utility::anim_stopanimScripted();
    var_3 startragdoll();

    if(!isalive(var_2)) {
      return;
    }

    var_2 scripts\engine\sp\utility::anim_stopanimScripted();
    return;
  }

  thread vo_body_poke();

  if(isDefined(var_1.target)) {
    var_2.target = var_1.target;
    return;
  }
}

function vo_body_poke() {
  if(getdvarint("greenlight")) {
    return;
  }

  var_0 = self;
  var_0 endon("death");
  var_0 endon("stealth_investigate");
  var_0 endon("stealth_combat");
  var_1 = scripts\engine\utility::array_remove(getaiarray("axis"), var_0);
  var_2 = scripts\engine\utility::getclosest(var_0.origin, var_1, 120);

  if(isDefined(var_2)) {
    var_2 endon("death");
    var_2 endon("stealth_investigate");
    var_2 endon("stealth_combat");
    var_2 scripts\engine\sp\utility::set_battlechatter(0);
    var_2 scripts\engine\sp\utility::waittillthread("stealth_investigate", &scripts\engine\sp\utility::set_battlechatter, 1);
    var_2 scripts\engine\sp\utility::waittillthread("stealth_combat", &scripts\engine\sp\utility::set_battlechatter, 1);
    var_3 = randomint(3);

    switch (var_3) {
      case 0:
        var_2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse_10");
        wait randomfloatrange(0.25, 0.5);
        var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse_20");
        wait randomfloatrange(0.25, 0.5);
        var_2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse_30");
        break;
      case 1:
        var_2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse2_10");
        wait randomfloatrange(0.25, 0.5);
        var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse2_20");
        wait randomfloatrange(0.25, 0.5);
        var_2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse2_30");
        wait randomfloatrange(0.25, 0.5);
        var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse2_40");
        break;
      case 2:
        var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse3_10");
        wait randomfloatrange(0.25, 0.5);
        var_2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse3_20");
        wait randomfloatrange(0.25, 0.5);
        var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse3_30");
        wait randomfloatrange(0.25, 0.5);
        var_2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse3_40");
        break;
    }

    var_2 scripts\engine\sp\utility::set_battlechatter(1);
    return;
  }

  var_4 = ["dx_vom_aq1_aqmisc_corpsesolo_10", "dx_vom_aq1_aqmisc_corpsesolo_40", "dx_vom_aq2_aqmisc_corpsesolo_20", "dx_vom_aq3_aqmisc_corpsesolo_30"];
  var_0 scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(var_4));
}

function setup_search_anims() {
  var_0 = scripts\engine\utility::getStructArray("search_animnode", "targetname");
  scripts\engine\utility::array_thread(var_0, &search_anim_think);
}

function search_anim_think() {
  level endon("obj_scene_started");
  var_0 = "search_" + self.script_noteworthy;
  var_1 = scripts\engine\utility::getclosest(self.origin, getEntArray("search_prop", "targetname"), 100);

  if(isDefined(var_1)) {
    var_1 scripts\engine\sp\utility::assign_animtree(var_1.script_animname);

    if(isDefined(level.scr_anim[var_1.script_animname][var_0 + "_intro"])) {
      thread scripts\common\anim::anim_first_frame_solo(var_1, var_0 + "_intro");
    } else {
      thread scripts\common\anim::anim_first_frame_solo(var_1, var_0 + "_loop");
    }
  }

  var_2 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_2 waittill("trigger", var_3);

  if(isDefined(var_3.context_melee_anim)) {
    return;
  }

  var_3.animname = "alq1";
  thread vignette_actor_init();

  if(isDefined(var_1)) {
    var_3.animents = [var_1];
  }

  var_3 notify("stop_going_to_node");
  var_3.target = var_2.targetname;
  var_3 endon("stealth_combat");
  var_3 endon("death");

  if(isDefined(var_2.script_flag_wait)) {
    patrol_flag_wait(var_3, var_2.script_flag_wait);
  }

  var_3 endon("stealth_investigate");
  var_3 scripts\engine\utility::thread_on_notify("stealth_investigate", &scripts\sp\anim::anim_reach_cleanup_solo, var_3, undefined, undefined, var_3, "anim_reach_complete");
  var_3 scripts\engine\utility::thread_on_notify("stealth_combat", &scripts\sp\anim::anim_reach_cleanup_solo, var_3, undefined, undefined, var_3, "anim_reach_complete");
  scripts\sp\anim::anim_reach_solo(var_3, var_0 + "_intro");
  var_3[[var_3.fnstealthflashlightdetach]]();
  scripts\sp\anim::anim_single_with_props(var_3, var_0 + "_intro");
  var_3.noragdoll = 1;
  thread search_anim_react(var_3, "stealth_investigate", self);
  thread search_anim_react(var_3, "stealth_combat", self);

  if(self.script_noteworthy == "desk") {
    var_4 = [var_0 + "_death_front", var_0 + "_death_back"];
  } else {
    var_4 = var_1 + "_death";
  }

  thread search_anim_pain_or_death(var_4, self, var_1 + "_pain");
  thread scripts\sp\anim::anim_loop_with_props(var_4, var_1 + "_loop");

  if(isDefined(self.script_flag_wait)) {
    scripts\engine\utility::flag_wait(self.script_flag_wait);
  }

  if(isDefined(self.script_wait)) {
    if(self.script_wait < 0) {
      GscBinSkip4(0x6e, var_4, 1, var_4, var_0 + "_react_combat", var_0 + "_react_combat", var_3);
    }

    wait self.script_wait;
  }

  var_4 waittillmatch("looping anim", "end");
  self notify("stop_search_anim_loop");
  self notify("stop_loop");
  var_4 scripts\engine\sp\utility::anim_stopanimScripted();

  if(isDefined(var_2)) {
    var_2 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var_4.noragdoll = undefined;
  GscBinSkip4(0x6e, var_4, var_4, var_0 + "_react_combat", var_0 + "_react_combat", var_3);
}

function search_anim_react(var_0, var_1, var_2) {
  var_1 endon("stop_search_anim_loop");
  self waittill(var_0);
  var_1 notify("stop_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();

  foreach(var_4 in self.animents) {
    var_4 setanimrate(level.scr_anim[var_4.animname]["search_" + var_1.script_noteworthy + "_loop"][0], 0);
  }

  var_1 thread scripts\common\anim::anim_single_solo(self, var_2);
  vignette_actor_cleanup();
  var_1 notify("stop_search_anim_loop");
}

function search_anim_pain_or_death(var_0, var_1, var_2) {
  var_0 endon("stop_search_anim_loop");
  self waittill("damage", var_3, var_3, var_4);
  var_0 notify("stop_loop");

  if(scripts\engine\utility::is_equal(level.player.context_melee_victim, self)) {
    foreach(var_6 in self.animents) {
      var_6 setanimrate(level.scr_anim[var_6.animname]["search_" + var_0.script_noteworthy + "_loop"][0], 0);
    }
  } else if(isalive(self)) {
    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 thread scripts\sp\anim::anim_single_with_props(self, var_1);
    vignette_actor_cleanup();
  } else {
    if(isarray(var_2)) {
      var_8 = anglesToForward(self.angles);
      var_9 = vectordot(var_8, var_4);

      if(var_9 < 0) {
        var_2 = var_2[0];
      } else {
        var_2 = var_2[1];
      }
    }

    self.deathanim = level.scr_anim[self.animname][var_2];
  }

  var_0 notify("stop_search_anim_loop");
}

function vo_searching(var_0) {
  var_1 = ["dx_vom_aq1_goto_obj_aqsearch_10", "dx_vom_aq1_goto_obj_aqsearch_20", "dx_vom_aq1_goto_obj_aqsearch_30", "dx_vom_aq2_goto_obj_aqsearch_40", "dx_vom_aq2_goto_obj_aqsearch_50", "dx_vom_aq3_goto_obj_aqsearch_70", "dx_vom_aq3_goto_obj_aqsearch_80", "dx_vom_aq3_goto_obj_aqsearch_90"];

  if(istrue(var_0)) {
    for(var_2 = 0;; var_2++) {
      wait randomfloatrange(5, 7);
      scripts\engine\sp\utility::smart_dialogue_generic(var_1[scripts\sp\maps\estate\estate_util::abs_int(var_2 % var_1.size)]);
    }

    return;
  }

  scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(var_1));
}

function patrol_flag_wait(var_0) {
  self endon("stealth_combat");
  self endon("death");
  scripts\engine\utility::flag_wait(var_0);

  if(self[[self.fnisinstealthinvestigate]]()) {
    self waittill("stealth_idle");
    return;
  }
}

function vignette_actor_init(var_0) {
  scripts\engine\sp\utility::set_allowdeath(1);

  while(!isDefined(self.stealth)) {
    waitframe();
  }

  self.should_combat_react = 0;
  self.og_stealth_funcs["event_investigate"] = self.stealth.funcs["event_investigate"];
  self.og_stealth_funcs["event_cover_blown"] = self.stealth.funcs["event_cover_blown"];
  self.og_stealth_funcs["event_combat"] = self.stealth.funcs["event_combat"];
  self.stealth.funcs["event_investigate"] = &vignette_actor_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &vignette_actor_stealth_filter;
  self.stealth.funcs["event_combat"] = &vignette_actor_stealth_filter;
  self.flashlightoverride = var_0;
}

function vignette_actor_stealth_filter(var_0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var_0)) {
    return true;
  }

  var_1 = ["unresponsive_teammate", "seek_backup"];

  if(scripts\engine\utility::array_contains(var_1, var_0.typeorig)) {
    return true;
  }

  self.should_combat_react = 0;

  if(var_0.type == "cover_blown" && !scripts\engine\utility::array_contains(["light_killed", "glass_destroyed"], var_0.typeorig)) {
    self.should_combat_react = 1;
  }

  return false;
}

function vignette_actor_cleanup() {
  self.noragdoll = undefined;
  self.deathanim = undefined;
  self.deathfunction = &grounds_axis_deathfunc;
  self.flashlightoverride = undefined;
  self.should_combat_react = undefined;

  if(isDefined(self.og_stealth_funcs)) {
    self.stealth.funcs["event_investigate"] = self.og_stealth_funcs["event_investigate"];
    self.stealth.funcs["event_cover_blown"] = self.og_stealth_funcs["event_cover_blown"];
    self.stealth.funcs["event_combat"] = self.og_stealth_funcs["event_combat"];
    return;
  }
}

function try_resume_vignette(var_0, var_1) {
  var_2 = undefined;

  for(;;) {
    var_0 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

    if(!isalive(var_0) || var_0[[var_0.fnisinstealthcombat]]()) {
      break;
    }

    thread scripts\sp\anim::anim_reach_and_approach_solo(var_0, var_1);
    var_0 scripts\engine\utility::waittill_any("anim_reach_complete", "stealth_investigate", "stealth_combat", "death");

    if(isalive(var_0) && var_0[[var_0.fnisinstealthidle]]()) {
      var_2 = 1;
      break;
    }

    scripts\sp\anim::anim_reach_cleanup_solo(var_0);

    if(!isalive(var_0) || var_0[[var_0.fnisinstealthcombat]]()) {
      break;
    }
  }

  return var_2;
}

function vignette_interrupted(var_0) {
  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      return true;
    }

    if(var_2[[var_2.fnisinstealthinvestigate]]()) {
      return true;
    }

    if(var_2[[var_2.fnisinstealthcombat]]()) {
      return true;
    }
  }

  return false;
}

function waittill_anim_finish_or_interrupted() {
  self endon("death");
  self endon("start_context_melee");
  self endon("stealth_combat");
  self endon("stealth_investigate");
  self endon("move_for_technical");
  self waittillmatch("single anim", "end");
  return true;
}

function spawn_technical() {
  scripts\engine\utility::flag_wait("technical_called");

  if(isDefined(level.player_rig)) {
    level.player waittill("identify_anim_complete");
  }

  scripts\engine\sp\utility::array_spawn_function_targetname("technical_spawner", &technical_rider_spawnfunc);
  var_0 = "technical";

  if(getdvarint("use_physics_decho")) {
    var_0 += "_physics";
  }

  level.technical = scripts\common\vehicle::spawn_vehicle_from_targetname(var_0);
  level.technical scripts\common\vehicle::vehicle_lights_on();
  level.technical scripts\engine\utility::ent_flag_wait("loaded");
  level.technical.donotunloadondriverdeath = 1;
  level.technical.stops = [];
  level.technical.investigating = 0;
  level.technical.combating = 0;
  level.max_technical_health = level.technical.maxhealth - level.technical.healthbuffer;
  level.technical.godmode = 1;
  level.technical.actualhealth = level.max_technical_health;
  level.technical.damage_functions = scripts\engine\utility::array_add_safe(level.technical.damage_functions, &technical_damage_func);
  level.technical.circle_volumes = getEntArray("technical_circle_volume", "targetname");
  thread technical_path_think();
  thread technical_callout_think();
  var_1 = 0;

  if(var_1) {
    level.technical.mgturret[0] delete();
    waitframe();
    get_gunner(level.technical) delete();
  } else {
    thread technical_gunner_think();
    thread technical_turret_think();
  }

  var_2 = getEnt("technical_roof_trig_pointer", "targetname");
  var_3 = getEnt(var_2.target, "targetname");
  var_3 enablelinkTo();
  var_3 linkTo(var_2);
  var_2.origin = level.technical gettagorigin("tag_turret");
  var_2.angles = level.technical.angles;
  var_2 linkTo(level.technical, "tag_turret");
  thread technical_roof_trig_think(level.technical);
  thread delete_technical_roof_trig(level.technical, var_2);
  thread technical_impact_think();
  thread technical_proximity_think();
  thread technical_ram_think();
  thread technical_badplace_think();
  thread technical_stop_for_allies_think();
  thread technical_stop_on_death_or_no_driver();
  thread technical_death_hint_think();
  level.technical playLoopSound("scn_estate_technical_dist_drive_lp");
  scripts\engine\utility::flag_set("technical_sfx_playing");
}

function technical_roof_trig_think(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger");
    var_1 = gettime();

    while(!scripts\engine\utility::time_has_passed(var_1, 0.5) && level.player istouching(var_0)) {
      waitframe();
    }

    if(!level.player istouching(var_0)) {
      continue;
    }

    var_2 = undefined;

    while(level.player istouching(var_0)) {
      var_3 = level.player getEye();
      var_4 = self.gunner getEye();
      var_2 = magicgrenade("frag", var_4, var_3, 1, 0);

      if(isDefined(var_2)) {
        break;
      }

      waitframe();
    }

    if(!isDefined(var_2)) {
      continue;
    }

    var_2 waittill("death");
    earthquake(1, 0.3, level.player.origin, 100);
    level.player playRumbleOnEntity("light_1s");
    var_5 = vectorNormalize(level.player.origin - self.origin) * 500;
    level.player setvelocity(var_5);
  }
}

function delete_technical_roof_trig(var_0, var_1) {
  while(!isDefined(self.gunner)) {
    waitframe();
  }

  scripts\engine\utility::waittill_any_ents(self, "death", self.gunner, "death");
  var_0 delete();
  var_1 delete();
}

function technical_rider_spawnfunc() {
  self.stealth.funcs["event_investigate"] = &technical_rider_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &technical_rider_stealth_filter;
  self.stealth.funcs["event_combat"] = &technical_rider_stealth_filter;
  self.deathfunction = &technical_rider_deathfunc;
  self.noragdoll = 1;
  self.noflashlight = 1;
  scripts\sp\nvg\nvg_ai::flashlight_off(1);
  self.health += 20000;
  self.damage_functions[self.damage_functions.size] = &technical_rider_damage_func;
}

function technical_rider_deathfunc() {
  if(isDefined(level.technical)) {
    foreach(var_1 in level.technical.riders) {
      var_1 aieventlistenerevent("ally_killed", level.player, self.origin);
    }
  }

  return grounds_axis_deathfunc();
}

function technical_rider_stealth_filter(var_0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var_0)) {
    return true;
  }

  if(!isalive(level.technical.gunner)) {
    return false;
  }

  switch (var_0.type) {
    case "cover_blown":
    case "investigate":
      thread technical_investigate_think(level.technical);
      break;
    case "combat":
      if(self == level.technical.gunner && !level.technical.combating && isalive(level.technical.driver)) {
        thread technical_combat_think();
      }

      break;
  }

  return false;
}

function technical_rider_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.ridingvehicle) && var_1 != level.player && var_4 != "MOD_EXPLOSIVE") {
    self.health += var_0;
    return;
  }

  if(self.health <= 20000) {
    self kill(var_3, var_1, var_1, var_4);
    return;
  }
}

function technical_rider_combat_think() {
  self endon("death");

  for(;;) {
    var_0 = undefined;

    while(self[[self.fnisinstealthcombat]]()) {
      if(gettime() - self lastknowntime(level.player) < 10000) {
        var_1 = self lastknownpos(level.player);

        if(!scripts\engine\utility::is_equal(var_1, var_0)) {
          self.goalradius = 512;
          self setgoalpos(var_1);
          var_0 = var_1;
        }
      }

      waitframe();
    }

    waitframe();
  }
}

function technical_rider_unload(var_0) {
  self.deathfunction = &grounds_axis_deathfunc;
  self.noragdoll = undefined;
  self.noflashlight = 0;
  scripts\sp\nvg\nvg_ai::flashlight_on(1);
  self.stealth.funcs["event_investigate"] = undefined;
  self.stealth.funcs["event_cover_blown"] = undefined;
  self.stealth.funcs["event_combat"] = undefined;
  self.damage_functions = scripts\engine\utility::array_remove(self.damage_functions, &technical_rider_damage_func);
  self.health -= 20000;

  if(isDefined(var_0)) {
    self aieventlistenerevent(var_0.type, var_0.ent, var_0.origin);
  }

  thread technical_rider_combat_think();
}

function is_technical_rider() {
  if(!isDefined(level.technical)) {
    return false;
  }

  if(!scripts\engine\utility::is_equal(self.script_stealthgroup, "technical")) {
    return false;
  }

  if(!scripts\engine\utility::array_contains(level.technical.riders, self)) {
    return false;
  }

  return true;
}

function technical_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isai(var_1)) {
    return;
  }

  var_10 = 0;

  if(isexplosivedamagemod(var_4)) {
    var_10 = 0.5;
  } else if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
    var_10 = 0.025;
  }

  self.actualhealth -= int(level.max_technical_health * var_10);

  if(self.actualhealth <= 0) {
    if(isDefined(self.spotlight)) {
      self.spotlight.tag delete();
      self.spotlight delete();
    }

    thread technical_turret_death();
    self.godmode = 0;
    self notify("death", var_1, var_4, var_9, var_3);
    return;
  }

  foreach(var_12 in self.riders) {
    var_12 aieventlistenerevent("attack", var_1, var_3);
  }
}

function technical_turret_death() {
  if(isalive(self.gunner)) {
    self.gunner delete();
  }

  var_0 = self.mgturret[0].angles - self gettagangles("tag_turret");
  self.mgturret[0] delete();
  waitframe();
  self.turret_dst = spawn("script_model", self gettagorigin("tag_turret_dst"));
  self.turret_dst setModel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue_dst");
  self.turret_dst linkTo(self, "tag_turret_dst", (0, 0, 0), var_0);
}

function technical_path_think() {
  self endon("death");
  self endon("gunner_defeated");
  level endon("obj_scene_started");
  self.dontunloadonend = 1;
  var_0 = getvehiclenodearray("technical_path_start", "targetname");
  var_1 = scripts\engine\sp\utility::getfarthest(level.player.origin, var_0);
  scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  var_2 = undefined;
  self.should_intercept = 1;
  self.current_speed = 0;
  self.current_lookahead = 0;
  self.speed_scale = 1;
  var_3 = 0;

  for(;;) {
    waitframe();
    var_4 = distance2dsquared(self.origin, level.player.origin);

    if(var_4 <= squared(500) && !level.player scripts\engine\utility::ent_flag("indoors")) {
      self.should_intercept = 0;
    }

    if(self.stopped_for_allies || istrue(self.unloading_passengers)) {
      continue;
    }

    if(isalive(self.gunner) && !self.combating && !self.is_ramming) {
      if(var_4 <= squared(1000)) {
        if(!var_3) {
          update_technical_speed_scale(0.6, 1, 1);
          var_3 = 1;
        }
      } else if(var_3) {
        var_3 = 0;

        if(isalive(self.gunner)) {
          update_technical_speed_scale(1, 1, 1);
        }
      }
    }

    if(!scripts\engine\utility::is_equal(var_2, self.currentnode)) {
      var_2 = self.currentnode;
      self notify("new_node");
      var_5 = getvehiclenode(var_2.target, "targetname");
      self.next_node = var_5;
      scale_speed(var_5);

      if(isDefined(var_5.target)) {
        continue;
      }

      var_6 = var_5 scripts\engine\sp\utility::get_linked_vehicle_nodes();
      var_7 = get_best_node_at_fork(var_6);
      scripts\common\vehicle::vehicle_switch_paths(var_5, var_7);
      self.next_node = var_7;
      scale_speed(var_7);
      self.should_intercept = 1;
    }
  }
}

function get_best_node_at_fork(var_0) {
  var_1 = undefined;
  var_2 = -1;
  var_3 = self.should_intercept || self.combating || self.is_ramming;

  if(!var_3) {
    var_2 = 1;
  }

  foreach(var_5 in var_0) {
    var_6 = (0, float(var_5.script_wtf), 0);
    var_7 = scripts\engine\math::get_dot(var_5.origin, var_6, level.player.origin);

    if(var_3) {
      if(var_7 > var_2) {
        var_2 = var_7;
        var_1 = var_5;
      }

      continue;
    }

    if(var_7 < var_2) {
      var_2 = var_7;
      var_1 = var_5;
    }
  }

  return var_1;
}

function scale_speed(var_0) {
  var_1 = get_mph_speed(var_0);

  if(!scripts\engine\utility::is_equal(self.current_speed, var_1)) {
    self.current_speed = var_1;

    if(!is_technical_stopped()) {
      self vehicle_setspeed(self.current_speed * self.speed_scale, 15, 15);
      return;
    }

    return;
  }
}

function get_mph_speed(var_0) {
  return var_0.speed * 3600 / 63360;
}

function update_technical_speed_scale(var_0, var_1, var_2) {
  if(self.speed_scale == var_0) {
    return;
  }

  self.speed_scale = var_0;
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 15);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 15);

  if(!is_technical_stopped()) {
    self vehicle_setspeed(self.current_speed * self.speed_scale, var_1, var_2);
    return;
  }
}

function technical_callout_think() {
  self endon("death");
  self endon("combat_begun");
  self endon("gunner_defeated");
  level.player endon("death");
  level endon("hvt_found");

  if(!scripts\sp\starts::is_after_start("find_hvt_2")) {
    wait 7;
    request_overwatch_vo("technical", "dx_vom_pri_technical_intro_10", 0, 1);
    level waittillmatch("overwatch_vo_completed", "technical");
  }

  var_0 = scripts\engine\trace::create_contents(1, 1, 1, 0, 0, 1, 1, 1);

  for(;;) {
    if(!isDefined(self.driver)) {
      return;
    }

    for(var_1 = 0; var_1 < 20; var_1++) {
      waitframe();
      var_2 = distance2dsquared(self.origin, level.player.origin);

      if(var_2 > squared(2000)) {
        break;
      }

      var_3 = anglesToForward(level.player.angles);
      var_4 = vectorNormalize(self.origin - level.player.origin);
      var_5 = vectordot(var_3, var_4);

      if(var_5 < 0.77) {
        break;
      }

      var_6 = scripts\engine\utility::array_combine([self, level.player], self.riders);

      if(!scripts\engine\trace::ray_trace_passed(level.player getEye(), self.origin + (0, 0, 50), var_6, var_0)) {
        break;
      }
    }

    if(var_1 >= 20) {
      if(request_overwatch_vo("technical", "dx_vom_pri_tech_reveal_10", 1)) {
        foreach(var_8 in self.riders) {
          var_8.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
        }

        return;
      }
    }
  }
}

function technical_gunner_think() {
  self endon("death");
  level endon("obj_scene_started");
  waitframe();
  self.gunner = get_gunner();
  self.gunner actoraimassistoff();
  var_0 = self.mgturret[0];
  var_0 makeunusable();
  technical_spotlight_on();
  self.gunner.vehicle = self;
  self.gunner scripts\asm\asm_sp::asm_animcustom(&technical_gunner_anim_think, undefined);
  self.gunner waittill("death");

  if(isDefined(var_0)) {
    var_0 cleartargetentity();
    var_0 makeusable();
  }

  if(isDefined(self.turret_pointer)) {
    self.turret_pointer delete();
  }

  technical_spotlight_off();
  scripts\sp\maps\estate\estate_util::clear_alias_group("turret_shoot_warning");
  wait 0.75;

  if(isalive(self.driver)) {
    self.driver thread scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_tech_kill_10");
    self.driver waittill("single dialogue");
  }

  self notify("gunner_defeated");

  if(!technical_can_unload("all")) {
    update_technical_speed_scale(0.5, 15, 15);

    if(is_technical_stopped()) {
      foreach(var_2 in self.stops) {
        resume_technical(var_3);
      }
    }

    for(;;) {
      wait 1;

      if(technical_can_unload("all")) {
        break;
      }
    }
  }

  stop_technical("gunner_killed", 15, 15);
  technical_waittill_stopped();
  var_4 = spawnStruct();
  var_4.type = "ally_killed";
  var_4.ent = level.player;
  var_4.origin = self.origin;
  var_5 = scripts\common\vehicle::vehicle_unload("all");

  foreach(var_7 in var_5) {
    technical_rider_unload(var_7, var_4);
  }

  scripts\common\vehicle::vehicle_lights_off();
  technical_destroy_badplaces();
}

function get_gunner() {
  foreach(var_1 in self.riders) {
    if(var_1.vehicle_position == 6) {
      return var_1;
    }
  }

  return undefined;
}

function technical_gunner_custom_death() {
  self.deathfunction = undefined;
  scripts\asm\soldier\vehicle::playanim_vehicledeath(self.asmname, "vehicle_death");
  return true;
}

#using_animtree("");

function technical_gunner_anim_think() {
  self.vehicle endon("death");
  self endon("death");
  self.deathfunction = &technical_gunner_custom_death;
  var_0 = self.vehicle;
  var_1 = % reb_com_veh8_decho_turret_aim_5;
  var_2 = $reb_com_veh8_decho_turret_idle;
  var_3 = % reb_com_veh8_decho_turret_driveidle;
  var_4 = % reb_com_veh8_decho_turret_aim_8;
  var_5 = % reb_com_veh8_decho_turret_aim_2;
  var_6 = % reb_com_veh8_decho_turret_aim_4_add;
  var_7 = % reb_com_veh8_decho_turret_aim_6_add;
  var_8 = % additive_decho_reb_aim_left;
  var_9 = % additive_decho_reb_aim_right;
  self clearanim(scripts\asm\asm::asm_getinnerrootknob(), 0.2);
  self setanimlimited(var_6, 1);
  self setanimlimited(var_7, 1);
  var_10 = var_0.mgturret[0];
  self setanim(var_1, 1);
  var_11 = var_3;
  var_12 = undefined;
  var_13 = undefined;
  self setanimknob(var_11, 1);

  for(var_14 = 0;; var_14 = var_17) {
    waitframe();
    var_15 = scripts\engine\utility::ter_op(var_0 vehicle_getspeed() > 1, var_3, var_2);

    if(var_15 != var_11) {
      self setanimknob(var_15, 1);
      var_11 = var_15;
    }

    var_16 = var_10 getturretcurrentpitch();
    var_12 = technical_gunner_set_aim(var_16, 25, -25, var_12, var_5, var_4, 0.2);
    var_17 = var_10 getturretcurrentyaw();
    var_18 = (var_17 - var_14) / 0.05;
    var_13 = technical_gunner_set_aim(var_18, 40, -40, var_13, var_8, var_9, 0.2);
  }
}

function technical_gunner_set_aim(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = 0.05;
  }

  if(var_0 == 0) {
    if(isDefined(var_3)) {
      self setanim(var_3, 0, var_6);
      return undefined;
    }

    return;
  }

  if(var_0 > 0) {
    if(isDefined(var_3) && var_3 != var_4) {
      self setanim(var_3, 0, var_6);
    }

    var_7 = clamp(var_0 / var_1, 0, 1);
    self setanim(var_4, var_7, var_6);
    return var_4;
  }

  if(isDefined(var_4) && var_4 != var_6) {
    self setanim(var_4, 0, var_7);
  }

  var_7 = clamp(var_1 / var_3, 0, 1);
  self setanim(var_6, var_7, var_7);
  return var_6;
}

function technical_spotlight_on() {
  if(isDefined(level.technical_spotlight_on)) {
    return;
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_estate_technical_searchlight"), level.technical.spotlight.tag, "tag_origin");
  level.technical_spotlight_on = 1;
}

function technical_spotlight_off() {
  if(!isDefined(level.technical_spotlight_on)) {
    return;
  }

  if(!isDefined(level.technical.spotlight)) {
    level.technical_spotlight_on = undefined;
    return;
  }

  killfxontag(scripts\engine\utility::getfx("vfx_estate_technical_searchlight"), level.technical.spotlight.tag, "tag_origin");
  level.technical_spotlight_on = undefined;
}

function technical_turret_think() {
  self endon("death");
  self endon("gunner_defeated");
  level endon("obj_scene_started");
  scripts\engine\utility::ent_flag_init("turret_investigate_pos_updated");
  var_0 = self.mgturret[0];
  var_0 setmode("manual");
  var_0 setModel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue");
  var_0 endon("death");
  var_0 settoparc(25);
  var_0 setbottomarc(25);
  self.spotlight = spawn("script_model", var_0 gettagorigin("tag_aim_animated"));
  self.spotlight setModel("ee_electronics_mg_searchlight");
  self.spotlight linkTo(var_0, "tag_aim_animated", (0, 0, 0), (0, 0, 0));
  self.spotlight.tag = scripts\engine\utility::spawn_tag_origin(self.spotlight.origin, self.spotlight.angles);
  self.spotlight.tag linkTo(self.spotlight, "tag_origin", (7.5, -3.5, 2.5), (0, 0, 0));
  self.turret_pointer = scripts\engine\utility::spawn_script_origin(self.origin - 500 * anglesToForward(self.angles));
  var_0 settargetentity(self.turret_pointer);
  level.technical_spotlight_targets = scripts\engine\utility::getStructArray("technical_spotlight_target", "targetname");
  var_1 = 1;
  scripts\sp\maps\estate\estate_util::make_alias_group("turret_shoot_warning", ["dx_vom_aq4_technical_spotted_10", "dx_vom_aq4_technical_spotted_20", "dx_vom_aq4_technical_spotted_30"]);
  GscBinSkip4(0x35);
}

function update_turret_pointer(var_0) {
  var_1 = scripts\engine\utility::spawn_script_origin(var_0);
  self.mgturret[0] settargetentity(var_1);

  if(isDefined(self.turret_pointer)) {
    self.turret_pointer delete();
  }

  self.turret_pointer = var_1;
}

function turret_aim_think() {
  self.gunner endon("stealth_hunt");
  self.gunner endon("death");
  var_0 = undefined;
  var_1 = 0;
  var_2 = (0, 0, 0);
  var_3 = [self.mgturret[0], self.gunner, level.player];

  for(;;) {
    waitframe();

    if(!scripts\engine\utility::is_equal(self.gunner.enemy, level.player)) {
      continue;
    }

    if(gettime() - self.gunner lastknowntime(level.player) > 10000) {
      continue;
    }

    if(scripts\engine\utility::is_equal(self.gunner lastknownpos(level.player), var_0)) {
      continue;
    }

    var_0 = self.gunner lastknownpos(level.player);

    if(gettime() > var_1) {
      var_4 = self.mgturret[0] gettagorigin("tag_aim");
      var_5 = level.player getEye() - level.player.origin - (0, 0, 10);

      if(scripts\engine\trace::ray_trace_passed(var_4, var_0, var_3)) {
        var_2 = (0, 0, 0);
      } else if(scripts\engine\trace::ray_trace_passed(var_4, var_0 + var_5, var_3)) {
        var_2 = var_5;
      } else if(scripts\engine\trace::ray_trace_passed(var_4, var_0 + var_5 / 2, var_3)) {
        var_2 = var_5 / 2;
      }

      var_1 = gettime() + 1000;
    }

    var_6 = var_0 + var_2;

    if(distancesquared(var_6, self.origin) < 40000 && !self.mgturret[0] turretcantarget(var_6)) {
      var_7 = self.origin;
      var_8 = scripts\engine\utility::flatten_vector(var_6 - var_7);
      var_6 = var_7 + var_8 * 500;
    }

    update_turret_pointer(var_6);
  }
}

function turret_shoot_think() {
  self notify("stop_turret_shoot_think");
  self endon("stop_turret_shoot_think");
  var_0 = self.ownervehicle.gunner;

  while(!gunner_can_shoot_player(var_0)) {
    waitframe();
  }

  var_0 scripts\engine\sp\utility::smart_dialogue_generic(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("turret_shoot_warning"));

  for(;;) {
    waitframe();

    if(!scripts\engine\utility::is_equal(var_0.enemy, level.player)) {
      continue;
    }

    if(gettime() - var_0 lastknowntime(level.player) > 10000) {
      continue;
    }

    if(!self turretcantarget(self.ownervehicle.turret_pointer.origin)) {
      continue;
    }

    var_1 = self gettagorigin("tag_flash");
    var_2 = self gettagangles("tag_flash");
    var_3 = var_0 lastknownpos(level.player);

    if(!turret_aimed_at_last_known(var_1, var_2, var_3)) {
      continue;
    }

    if(distance2dsquared(self.origin, var_3) > squared(3000)) {
      continue;
    }

    var_4 = scripts\engine\trace::ray_trace(var_1, var_1 + anglesToForward(var_2) * 3000, self);
    var_5 = var_4["entity"];

    if(isDefined(var_5) && (var_5 == self.ownervehicle || scripts\engine\utility::is_equal(var_5.team, "axis"))) {
      continue;
    }

    for(var_6 = 0; var_6 < 20; var_6++) {
      self shootturret("tag_flash");
      level notify("technical_hot_event", var_0);
      var_7 = scripts\engine\utility::get_array_of_closest(var_1, getaiarray("axis"), [var_0], undefined, 1500);

      foreach(var_9 in var_7) {
        if(!var_9[[var_9.fnisinstealthcombat]]()) {
          var_9 aieventlistenerevent("gunshot_teammate", self, var_1);
        }
      }

      wait 0.1;
    }

    wait 0.5;

    while(!gunner_can_shoot_player(var_0)) {
      waitframe();
    }
  }
}

function gunner_can_shoot_player(var_0) {
  if(var_0 cansee(level.player)) {
    return true;
  }

  var_1 = var_0 lastknowntime(level.player);

  if(!isDefined(var_1)) {
    return false;
  }

  if(gettime() - var_1 > 10000) {
    return false;
  }

  var_2 = var_0 lastknownpos(level.player);

  if(!isDefined(var_2)) {
    return false;
  }

  if(!turret_aimed_at_last_known(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), var_2)) {
    return false;
  }

  if(distancesquared(var_2, level.player.origin) > 16384) {
    return false;
  }

  return true;
}

function turret_aimed_at_last_known(var_0, var_1, var_2) {
  if(scripts\engine\utility::within_fov(var_0, var_1, var_2, 0.7)) {
    return true;
  }

  var_3 = level.player getEye() - level.player.origin;

  if(scripts\engine\utility::within_fov(var_0, var_1, var_2 + var_3, 0.7)) {
    return true;
  }

  if(scripts\engine\utility::within_fov(var_0, var_1, var_2 + var_3 / 2, 0.7)) {
    return true;
  }

  return false;
}

function turret_corpse_monitor() {
  var_0 = [];

  for(;;) {
    waitframe();

    if(!isalive(self.gunner)) {
      continue;
    }

    var_1 = (gettime() - self.gunner lastknowntime(level.player)) / 1000;
    var_0 = scripts\engine\utility::array_removeundefined(var_0);
    var_2 = getcorpsearray();
    var_2 = scripts\engine\utility::array_remove_array(var_2, var_0);

    foreach(var_4 in var_2) {
      if(!istrue(var_4.found)) {
        var_0 = scripts\engine\utility::array_add(var_0, var_4);

        if(!scripts\stealth\group::group_anyoneincombat("technical")) {
          GscBinSkip4(0x35, var_4);
        }
      }
    }

    foreach(var_4 in var_0) {
      if(istrue(var_4.found)) {
        var_4 notify("stop_turret_spotted_ent_think");
      }
    }
  }
}

function turret_spotted_ent_think(var_0) {
  var_0 endon("stop_turret_spotted_ent_think");
  var_1 = 0;

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }

    while(isalive(self.gunner) && turret_is_on_ent(var_0, 10)) {
      var_1++;

      if(var_1 >= 3) {
        if(isPlayer(var_0)) {
          if(!scripts\engine\utility::is_equal(self.turret_investigate_pos, var_0.origin)) {
            update_turret_investigate_pos(var_0.origin);
          }
        } else {
          update_turret_investigate_pos(var_0 scripts\engine\sp\utility::get_corpse_origin());
          self.gunner aieventlistenerevent("saw_corpse", var_0, var_0 scripts\engine\sp\utility::get_corpse_origin());
          return;
        }
      }

      waitframe();
    }

    if(var_1 > 0) {
      var_1 = 0;
    }

    waitframe();
  }
}

function turret_is_on_ent(var_0, var_1) {
  if(distance2dsquared(self.origin, var_0.origin) > 4000000) {
    return false;
  }

  var_2 = var_0.origin;

  if(isPlayer(var_0)) {
    var_2 = var_0 getEye();
  } else {
    var_2 = var_0 scripts\engine\sp\utility::get_corpse_origin();
  }

  var_3 = self.mgturret[0];
  var_4 = var_3 gettagorigin("tag_flash");
  var_5 = var_3 gettagangles("tag_flash");

  if(scripts\engine\utility::within_fov(var_4, var_5, var_2, cos(var_1))) {
    if(self.gunner cansee(var_0)) {
      return true;
    }
  }

  return false;
}

function update_turret_investigate_pos(var_0) {
  scripts\engine\utility::ent_flag_set("turret_investigate_pos_updated");
  self.turret_investigate_pos = var_0;
  self.turret_investigate_pos_time = gettime();
}

function turret_sweep(var_0, var_1, var_2) {
  self endon("death");
  self endon("turret_investigate_pos_updated");
  self.gunner endon("death");
  self.gunner endon("stealth_combat");
  var_0 setconvergencetime(var_2, "yaw");
  var_0 setconvergencetime(var_2, "pitch");
  var_0 setleftarc(180);
  var_0 setrightarc(180);
  var_3 = scripts\engine\utility::get_array_of_closest(self.origin, level.technical_spotlight_targets, undefined, undefined, 500);
  var_4 = scripts\engine\utility::get_array_of_closest(self.origin, getcorpsearray(), undefined, undefined, 500);

  foreach(var_6 in var_4) {
    if(!istrue(var_6.found)) {
      var_3 = var_6;
    }
  }

  var_8 = [];
  var_9 = anglestoright(self.angles);
  var_10 = scripts\engine\utility::getclosest(self.origin, level.landmarks, 1500);

  if(isDefined(var_10) && scripts\engine\utility::array_contains(level.hvt_locations, var_10.location) && level.player istouching(level.interior_volumes[var_10.location])) {
    var_11 = vectorNormalize(var_10.origin - self.origin);
    var_12 = vectordot(var_9, var_11);
    var_1 = var_12;
  }

  foreach(var_14 in var_3) {
    var_11 = vectorNormalize(var_14.origin - self.origin);
    var_12 = vectordot(var_9, var_11);

    if(var_12 * var_1 <= 0) {
      continue;
    }

    if(!var_0 turretcantarget(var_14.origin)) {
      continue;
    }

    var_8 = var_14;
  }

  var_11 = vectorNormalize(level.player.origin - self.origin);
  var_12 = vectordot(var_9, var_11);

  if(var_12 * var_1 > 0) {
    var_16 = scripts\engine\utility::getclosest(level.player.origin, var_8);
  } else {
    var_16 = scripts\engine\sp\utility::getfarthest(level.player.origin, var_9);
  }

  if(!isDefined(var_16)) {
    return false;
  }

  update_turret_pointer(var_16.origin);
  waittill_technical_turns_or_timeout(var_3 + 2);
  return true;
}

function waittill_technical_turns_or_timeout(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    waitframe();
    var_3 = anglesToForward(self.angles);
    var_4 = vectordot(var_1, var_3);

    if(var_4 < 0.5) {
      break;
    }
  }
}

function technical_badplace_think() {
  self endon("death");
  self endon("driver_died");
  self endon("gunner_defeated");
  self waittill("new_node");
  self.badplaces = [];

  for(;;) {
    while(self vehicle_getspeed() > 1 || self.stopped_for_allies) {
      technical_create_badplaces_along_path(750);
      scripts\engine\utility::waittill_notify_or_timeout("new_node", 1);

      if(self.stopped_for_allies) {
        self waittill("resume_stop_for_allies");
      }
    }

    technical_destroy_badplaces();

    while(self vehicle_getspeed() <= 1) {
      waitframe();
    }
  }
}

function technical_create_badplaces_along_path(var_0) {
  if(self.badplaces.size) {
    technical_destroy_badplaces();
  }

  var_1 = self.origin - anglesToForward(self.angles) * 112;
  var_2 = self.currentnode;
  var_3 = 0;

  while(var_3 < var_0) {
    if(var_3 == 0 && isDefined(var_2.script_linkname)) {
      var_4 = var_2;
    } else if(isDefined(var_2.target)) {
      var_4 = getvehiclenode(var_2.target, "targetname");
    } else {
      var_4 = get_best_node_at_fork(var_2 scripts\engine\sp\utility::get_linked_vehicle_nodes());
    }

    while(!isDefined(var_4.ground_pos)) {
      waitframe();
    }

    var_5 = var_4.ground_pos;
    var_6 = distance(var_1, var_5);
    var_7 = vectortoangles(var_5 - var_1);

    if(var_6 > var_0 - var_3) {
      var_6 = var_0 - var_3;
      var_5 = var_1 + anglesToForward(var_7) * var_6;
    }

    var_8 = (var_1 + var_5) / 2;
    var_9 = createnavbadplacebybounds(var_8, (var_6 / 2 + 20, 80, 60), var_7);
    self.badplaces[self.badplaces.size] = var_9;
    var_3 += var_6;
    var_1 = var_5;
    var_2 = var_4;
  }
}

function technical_destroy_badplaces() {
  if(!self.badplaces.size) {
    return;
  }

  foreach(var_1 in self.badplaces) {
    destroynavobstacle(var_1);
  }

  self.badplaces = [];
}

function technical_stop_for_allies_think() {
  self endon("death");
  self endon("gunner_defeated");
  self endon("driver_died");
  level endon("obj_scene_started");
  var_0 = 0;
  self.stopped_for_allies = 0;

  for(;;) {
    waitframe();

    if(self.stopped_for_allies && !var_0) {
      resume_technical("allies");
      self.stopped_for_allies = 0;
      self notify("resume_stop_for_allies");
    }

    if(!isDefined(self.next_node)) {
      continue;
    }

    var_0 = 0;
    var_1 = scripts\engine\utility::get_array_of_closest(self.origin, getaiarray("axis"), self.riders, undefined, 500);

    if(var_1.size == 0) {
      continue;
    }

    foreach(var_3 in var_1) {
      if(var_3 scripts\engine\sp\utility::is_touching_any(level.interior_volumes)) {
        continue;
      }

      if(is_on_technical_path(var_3, 500)) {
        var_0 = 1;
        var_3 notify("move_for_technical");
      }
    }

    if(!var_0) {
      continue;
    }

    if(!self.stopped_for_allies) {
      self.stopped_for_allies = 1;
      stop_technical("allies", 15, 15);
    }

    wait 1;
  }
}

function is_on_technical_path(var_0) {
  var_1 = level.technical.origin;
  var_2 = level.technical.currentnode;
  var_3 = 0;

  while(var_3 < var_0) {
    if(isDefined(var_2.target)) {
      var_4 = getvehiclenode(var_2.target, "targetname");
    } else {
      var_4 = get_best_node_at_fork(level.technical, var_2 scripts\engine\sp\utility::get_linked_vehicle_nodes());
    }

    var_5 = var_4.ground_pos;

    if(scripts\engine\math::get_dot(var_1, vectortoangles(var_5 - var_1), self.origin) > 0 && scripts\engine\math::get_dot(var_5, vectortoangles(var_1 - var_5), self.origin) > 0) {
      var_6 = vectorfromlinetopoint(var_1, var_5, self.origin);

      if(length2dsquared(var_6) <= squared(60)) {
        return (distancesquared(self.origin - var_6, var_1) <= squared(var_0 - var_3));
      }
    }

    var_3 += distance(var_1, var_5);
    var_1 = var_5;
    var_2 = var_4;
  }

  return false;
}

function technical_investigate_think(var_0) {
  self endon("death");
  var_1 = ["footstep", "footstep_sprint", "footstep_walk", "unresponsive_teammate", "found_corpse", "seek_backup", "silenced_shot", "sight"];

  if(scripts\engine\utility::array_contains(var_1, var_0.typeorig)) {
    return 1;
  }

  if(var_0.typeorig == "bulletwhizby") {
    var_2 = self.gunner getEye();
    var_3 = vectorNormalize(var_0.origin - var_2);
    var_0.origin = var_2 + var_3 * 200;
  }

  update_turret_investigate_pos(var_0.origin);

  if(scripts\engine\utility::is_equal(var_0.typeorig, "saw_corpse")) {
    var_0.entity.found = 1;
  }

  if(self.investigating) {
    return;
  }

  if(self.combating) {
    return;
  }

  self.investigating = 1;
  stop_technical("investigate", 15, 15);
  self.gunner scripts\engine\utility::delaythread(5, &scripts\engine\utility::send_notify, "investigate_timeout_" + gettime());
  self.gunner scripts\engine\utility::waittill_any("investigate_timeout_" + gettime(), "stealth_combat", "death");

  if(isalive(self.gunner) && !self.gunner[[self.gunner.fnisinstealthcombat]]()) {
    foreach(var_5 in self.riders) {
      var_5 aieventlistenerevent("reset", self, self.origin);
    }
  }

  self.investigating = 0;

  if(!isalive(self.gunner)) {
    return;
  }

  resume_technical("investigate");
}

function technical_combat_think() {
  self endon("death");
  self endon("driver_died");
  self notify("combat_begun");
  var_0 = self.mgturret[0];
  self.combating = 1;
  var_1 = 0;
  var_2 = gettime();
  waittillframeend();

  while(isalive(self.gunner) && self.gunner[[self.gunner.fnisinstealthcombat]]()) {
    if(!self.is_ramming && !self.stopped_for_allies && isDefined(self.gunner.enemy)) {
      var_3 = 0;
      var_4 = level.player getistouchingentities(self.circle_volumes)[0];

      if(isDefined(var_4) && scripts\engine\utility::is_equal(self.next_node.script_noteworthy, var_4.script_noteworthy)) {
        var_3 = 1;
      }

      if(var_1) {
        var_5 = !turret_can_shoot_player(var_0) || !self.gunner seerecently(level.player, 5) && (var_3 || istrue(technical_can_reacquire_player()));

        if(var_5) {
          resume_technical("combat");
          var_1 = 0;
        }
      } else {
        var_6 = 0;

        if(!istrue(self.unloaded_passengers) && gettime() >= var_2) {
          var_6 = technical_can_unload("passengers");
          var_2 = gettime() + 1000;
        }

        var_7 = var_6 || anyone_can_see(self.riders, level.player) && turret_can_shoot_player(var_0) || !var_3 && !istrue(technical_can_reacquire_player());

        if(var_7) {
          stop_technical("combat", 15, 15);
          var_1 = 1;

          if(var_6) {
            self.unloading_passengers = 1;
            technical_waittill_stopped();
            var_8 = scripts\common\vehicle::vehicle_unload("passengers");

            foreach(var_10 in var_8) {
              var_10 scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittill_any, "jumpedout", "death", "long_death");
              technical_rider_unload(var_10);
            }

            scripts\engine\sp\utility::do_wait();
            self.unloading_passengers = 0;
            self.unloaded_passengers = 1;
          }
        }
      }
    }

    if(self.is_ramming && var_1) {
      var_1 = 0;
    }

    wait 1;
  }

  if(var_1 && isalive(self.gunner)) {
    resume_technical("combat");
  }

  self.combating = 0;
}

function anyone_can_see(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 cansee(var_1)) {
      return true;
    }
  }

  return false;
}

function turret_can_shoot_player() {
  if(self turretcantarget(level.player.origin)) {
    return true;
  }

  return false;
}

function technical_can_reacquire_player() {
  self.gunner endon("death");
  self.gunner endon("stealth_hunt");
  var_0 = self.gunner lastknowntime(level.player) + 10000;
  var_1 = (var_0 - gettime()) / 1000;
  var_2 = self.gunner getEye() - self.origin;
  var_3 = 0;
  var_4 = self.origin;
  var_5 = self.currentnode;
  var_6 = scripts\engine\trace::create_ainosight_contents();
  var_7 = level.player getEye();

  while(var_3 < var_1) {
    if(isDefined(var_5.target)) {
      var_8 = getvehiclenode(var_5.target, "targetname");
    } else {
      var_8 = get_best_node_at_fork(var_5 scripts\engine\sp\utility::get_linked_vehicle_nodes());
    }

    var_9 = var_8.ground_pos;
    var_10 = distance(var_9, var_4);
    var_11 = vectorNormalize(var_9 - var_4);
    var_12 = 0;

    while(var_12 < var_10) {
      var_12 = min(var_12 + 10, var_10);
      var_13 = var_4 + var_11 * var_12 + var_2;
      var_14 = max(level.player.maxvisibledist, 750);

      if(distancesquared(var_13, var_7) > var_14 * var_14) {
        continue;
      }

      if(self.gunner scripts\engine\sp\utility::can_trace_to_player(var_13, self, var_6)) {
        return true;
      }

      waitframe();
      var_7 = level.player getEye();
    }

    var_15 = get_mph_speed(var_5) * self.speed_scale;
    var_3 += scripts\engine\sp\utility::mph_travel_time(var_15, var_10);
    var_4 = var_9;
    var_5 = var_8;
  }

  return false;
}

function technical_can_unload(var_0) {
  var_0 = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()][var_0];
  var_1 = scripts\engine\utility::array_combine(self.riders, [self, self.mgturret[0]]);
  var_2 = (0 - self vehicle_getspeed()) / -15;
  var_3 = self vehicle_getspeed() * var_2 + -7.5 * var_2 * var_2;
  var_3 *= 17.6;
  var_4 = scripts\engine\utility::array_reverse(self.riders);

  foreach(var_6 in var_4) {
    if(!isalive(var_6)) {
      continue;
    }

    if(!scripts\engine\utility::array_contains(var_0, var_6.vehicle_position)) {
      continue;
    }

    var_7 = var_6.origin;
    var_8 = undefined;

    switch (var_6.vehicle_position) {
      case 0:
        var_8 = var_7 - anglestoright(self.angles) * 45;
        break;
      case 1:
        var_8 = var_7 + anglestoright(self.angles) * 45;
        break;
      case 5:
      case 4:
        var_8 = var_7 - anglesToForward(self.angles) * 75;
        break;
    }

    var_9 = getclosestpointonnavmesh(var_8, var_6);
    var_10 = 96;

    if(distance2dsquared(var_8, var_9) > var_10 * var_10) {
      return false;
    }

    var_7 += anglesToForward(self.angles) * var_3;
    var_8 += anglesToForward(self.angles) * var_3;
    var_11 = scripts\engine\trace::capsule_trace(var_7, var_8, 16, 60, self.angles, var_1);

    if(var_11["hittype"] != "hittype_none") {
      return false;
    }

    var_7 = undefined;
    var_8 = undefined;

    switch (var_6.vehicle_position) {
      case 0:
        var_7 = self gettagorigin("tag_door_front_left");
        var_8 = var_7 - anglestoright(self.angles) * 45;
        break;
      case 1:
        var_7 = self gettagorigin("tag_door_front_right");
        var_8 = var_7 + anglestoright(self.angles) * 45;
        break;
    }

    if(isDefined(var_7)) {
      var_7 += anglesToForward(self.angles) * var_3;
      var_8 += anglesToForward(self.angles) * var_3;

      if(!scripts\engine\trace::ray_trace_passed(var_7, var_8, var_1)) {
        return false;
      }
    }
  }

  return true;
}

function technical_ram_think() {
  self endon("death");
  self endon("gunner_defeated");
  self endon("driver_died");
  level endon("obj_scene_started");
  level.player endon("death");
  var_0 = 0;
  self.is_ramming = 0;

  for(;;) {
    wait 0.15;

    if(self.stopped_for_allies) {
      var_0 = 0;
      continue;
    }

    if(!var_0 && self.is_ramming) {
      update_technical_speed_scale(1, 15, 15);
      self.is_ramming = 0;
    }

    var_0 = 0;

    if(!isalive(self.gunner)) {
      continue;
    }

    if(!scripts\stealth\group::group_anyoneincombat("technical")) {
      continue;
    }

    if(istrue(self.unloading_passengers)) {
      continue;
    }

    if(distancesquared(self.origin, level.player.origin) > squared(1000)) {
      continue;
    }

    if(scripts\engine\math::get_dot(self gettagorigin("tag_grill"), self gettagangles("tag_grill"), level.player.origin) < 0) {
      continue;
    }

    if(!is_on_technical_path(level.player, 1000)) {
      continue;
    }

    if(is_technical_stopped()) {
      if(self.stops.size > 1 || !scripts\engine\utility::array_contains_key(self.stops, "combat")) {
        continue;
      }

      resume_technical("combat");
    }

    var_0 = 1;

    if(!self.is_ramming) {
      self.is_ramming = 1;
      self.gunner scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(["dx_vom_aq4_technical_ram_10", "dx_vom_aq4_technical_ram_20", "dx_vom_aq4_technical_ram_30"]));
      self playSound("sp_lvl_estate_technical_charge_close_01");
      wait 0.75;
      update_technical_speed_scale(2, 30, 30);
      wait 2;
    }
  }
}

function technical_impact_think() {
  self endon("death");
  self endon("gunner_defeated");
  level endon("obj_scene_started");
  level.player endon("death");

  for(;;) {
    level.player waittill("damage", var_0, var_1, var_2, var_3);

    if(scripts\engine\utility::is_equal(var_1, self)) {
      var_4 = self vehicle_getspeed() * 75 * vectorNormalize(var_2);
      level.player setvelocity(var_4);
      level.player playSound("sp_lvl_estate_technical_impact_01");

      if(self vehicle_getspeed() > 10) {
        stop_technical("player_dead", 15, 15);
        level.player kill(var_3, self);
      }

      foreach(var_6 in self.riders) {
        var_6 aieventlistenerevent("proximity", level.player, level.player.origin);
      }
    }
  }
}

function technical_proximity_think() {
  self endon("death");

  for(;;) {
    jumpiftrue(isDefined(self.gunner)) LOC_00000015;
    waitframe();
  }

  while(isalive(self.gunner)) {
    var_0 = distancesquared(self.origin, level.player.origin);

    if(self.gunner[[self.gunner.fnisinstealthcombat]]()) {
      if(var_0 < 40000) {
        self.gunner getenemyinfo(level.player);
      }
    } else if(var_0 < 22500 && level.player getstance() != "prone") {
      self.gunner aieventlistenerevent("proximity", level.player, level.player.origin);
    }

    wait 0.1;
  }
}

function technical_death_hint_think() {
  self endon("death");
  self endon("gunner_defeated");
  level endon("obj_scene_started");
  level.player waittill("death", var_0, var_1, var_2, var_3, var_4);

  if(var_0 == self || var_0 == self.mgturret[0]) {
    scripts\sp\player_death::set_custom_death_quote(59);
    return;
  }
}

function technical_stop_on_death_or_no_driver() {
  self endon("gunner_defeated");
  level endon("obj_scene_started");
  waitframe();
  scripts\engine\utility::waittill_any_ents(self, "death", self.driver, "death");

  if(isalive(self)) {
    self notify("driver_died");
    scripts\common\vehicle::vehicle_lights_off();

    if(!istrue(self.unloading_passengers) && !istrue(self.unloaded_passengers)) {
      var_0 = spawnStruct();
      var_0.type = "ally_killed";
      var_0.ent = level.player;
      var_0.origin = self.origin;

      if(!technical_can_unload("passengers")) {
        update_technical_speed_scale(0.5, 15, 15);

        if(is_technical_stopped()) {
          foreach(var_2 in self.stops) {
            if(var_3 == "investigate") {
              continue;
            }

            resume_technical(var_3);
          }
        }

        for(;;) {
          wait 1;

          if(technical_can_unload("passengers")) {
            break;
          }
        }
      }

      stop_technical("death", 15, 15);
      technical_waittill_stopped();
      var_4 = scripts\common\vehicle::vehicle_unload("passengers");

      foreach(var_6 in var_4) {
        technical_rider_unload(var_6, var_0);
      }
    } else {
      stop_technical("death", 15, 15);
    }
  } else {
    stop_technical("death", 15, 15);
  }

  technical_destroy_badplaces();
}

function stop_technical(var_0, var_1, var_2) {
  if(isDefined(self.stops[var_0])) {
    return;
  }

  self.stops[var_0] = 1;

  if(self.stops.size == 1) {
    if(scripts\engine\utility::flag("technical_sfx_playing")) {
      thread sfx_technical_stop();
    }

    self vehicle_setspeed(0, 15, 15);
    scripts\common\vehicle_code::vehicle_remove_badplace();
    thread technical_spawn_cover_nodes();
    self notify("stopping");
    return;
  }
}

function sfx_technical_stop() {
  self endon("moving");
  wait 0.1;
  scripts\engine\utility::flag_clear("technical_sfx_playing");
  self stoploopsound();
  self playSound("scn_estate_technical_dist_drive_stop");
}

function resume_technical(var_0) {
  self.stops[var_0] = undefined;
  self.stops = scripts\engine\utility::array_remove_key(self.stops, var_0);

  if(!self.stops.size) {
    if(!scripts\engine\utility::flag("technical_sfx_playing")) {
      thread sfx_technical_resume();
    }

    self vehicle_setspeed(self.current_speed * self.speed_scale, 15, 15);
    scripts\common\vehicle_code::vehicle_badplace();

    if(isDefined(self.cover_nodes)) {
      foreach(var_2 in self.cover_nodes) {
        despawncovernode(var_2);
      }

      self.cover_nodes = undefined;
    }

    self notify("moving");
    return;
  }
}

function sfx_technical_resume() {
  self endon("stopping");
  thread scripts\engine\utility::play_sound_in_space("scn_estate_technical_dist_drive_start", self.origin);
  wait 0.1;
  self playLoopSound("scn_estate_technical_dist_drive_lp");
  scripts\engine\utility::flag_set("technical_sfx_playing");
}

function is_technical_stopped() {
  return self.stops.size > 0;
}

function technical_waittill_stopped() {
  self endon("death");

  while(self vehicle_getspeed() > 1) {
    waitframe();
  }

  wait 1;
}

function technical_spawn_cover_nodes() {
  self endon("moving");
  technical_waittill_stopped();
  self.cover_nodes = vehicle_spawncovernodes(self.origin, self.angles, 104, 8, 104, 9, 43, 43, "technical_coverNode");
}

function vehicle_spawncovernodes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_4 *= -1;
  var_6 *= -1;
  var_9 = anglesToForward(var_1);
  var_10 = anglestoright(var_1);
  var_11 = (0, 0, 1);
  var_12 = vectortoangles(var_9);
  var_13 = vectortoangles(var_9 * -1);
  var_14 = vectortoangles(var_10);
  var_15 = vectortoangles(var_10 * -1);
  var_16 = [];
  var_16 = vehicle_addcovernodetemplate(var_16, "Cover Left", var_2 - 16, var_6, var_14);
  var_16 = vehicle_addcovernodetemplate(var_16, "Cover Right", var_2 + var_3, var_6 + 16, var_13);
  var_16 = vehicle_addcovernodetemplate(var_16, "Cover Left", var_2 + var_3, var_7 - 16, var_13);
  var_16 = vehicle_addcovernodetemplate(var_16, "Cover Right", var_2 - 16, var_7, var_15);
  var_16 = vehicle_addcovernodetemplate(var_16, "Cover Left", var_4 + 16, var_7, var_15);
  var_16 = vehicle_addcovernodetemplate(var_16, "Cover Right", var_4 - var_5, var_7 - 16, var_12);
  var_16 = vehicle_addcovernodetemplate(var_16, "Cover Left", var_4 - var_5, var_6 + 16, var_12);
  var_16 = vehicle_addcovernodetemplate(var_16, "Cover Right", var_4 + 16, var_6, var_14);
  var_17 = [];

  foreach(var_19 in var_16) {
    var_20 = var_0 + var_9 * var_19.forwarddistance + var_10 * var_19.rightdistance + var_11 * 32;
    var_20 += anglesToForward(var_19.angles) * 16 * -1;
    var_21 = spawncovernode(var_20, var_19.angles, var_19.type, 4, var_8);

    if(isDefined(var_21)) {
      var_17 = scripts\engine\utility::array_add(var_17, var_21);
    }
  }

  return var_17;
}

function vehicle_addcovernodetemplate(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4.forwarddistance = var_1;
  var_4.rightdistance = var_2;
  var_4.angles = var_3;
  return scripts\engine\utility::array_add(self, var_4);
}