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
  var0 = strtok(getDvar("scr_est_hvtsChecked"), " ");

  if(!var0.size) {
    var0 = [scripts\engine\utility::random(["church", "courtyard", "pool"])];
  } else if(var0.size > 1) {
    var0 = [var0[0]];
  }

  thread find_hvt_jump_to_start(var0);
}

function find_hvt_3_start() {
  var0 = strtok(getDvar("scr_est_hvtsChecked"), " ");

  if(!var0.size) {
    var0 = scripts\engine\utility::array_remove_index(scripts\engine\utility::array_randomize(["church", "courtyard", "pool"]), 2);
  } else if(var0.size > 2) {
    var0 = [var0[0], var0[1]];
  }

  thread find_hvt_jump_to_start(var0);
}

function find_hvt_jump_to_start(var0) {
  scripts\engine\utility::flag_wait("grounds_init_complete");

  foreach(var2 in var0) {
    foreach(var4 in level.stealth_areas[var2].spawners) {
      if(var10 == var0.size - 1 && scripts\engine\utility::is_equal(var4.script_noteworthy, "escalation_patroller")) {
        continue;
      }

      if(scripts\engine\utility::is_equal(var4.script_noteworthy, "interrogator")) {
        continue;
      }

      var4.count = 0;
    }

    var6 = scripts\engine\sp\utility::spawn_targetname(var2 + "_interrogator_spawner", 1);
    level.hvts_seen++;
    var7 = level.hvts[var2];
    check_hvt(var7);
    var6 kill();
    thread hvt_death_post_interact();

    if(var10 == var0.size - 1) {
      var8 = var7.origin + anglesToForward(var7.angles) * 60;
      var9 = vectortoangles(var7.origin - var8);
      level.player setOrigin(var8, 1);
      level.player setplayerangles(var9);
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
  var0 = scripts\engine\utility::getStructArray("hvt", "targetname");

  foreach(var2 in var0) {
    var3 = var2 scripts\engine\utility::get_linked_ents()[0];

    if(isDefined(var3)) {
      var3 delete();
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
  var0 = scripts\engine\utility::getStruct("obj_interact", "targetname");
  scripts\engine\sp\objectives::objective_set_position("mansion", var0.origin + (0, 0, 10));
  scripts\engine\utility::flag_wait("player_on_third_floor");
  setmusicstate("");
  mansion_waypoint_cleanup();
  scripts\engine\sp\objectives::objective_set_label("mansion", &"ESTATE/OBJ_LBL_OPEN_DOOR");
}

function delete_mansion_spawners() {
  foreach(var1 in getaiarray("axis")) {
    if(scripts\engine\utility::is_equal(var1.area, "mansion") || scripts\engine\utility::is_equal(var1.script_noteworthy, "escalation_patroller")) {
      var1 delete();
    }
  }

  foreach(var4 in ["mansion_south_spawner", "mansion_firstfloor_spawner", "mansion_secondfloor_spawner"]) {
    var5 = getspawnerarray(var4);

    foreach(var7 in var5) {
      var7 delete();
    }

    var9 = getEnt(var4, "target");
    var9 delete();
  }
}

function mansion_escalation_spawn_think() {
  var0 = getspawnerarray("mansion_escalation_spawner");

  if(level.player istouching(level.interior_volumes["pool"])) {
    var0 = scripts\engine\utility::array_combine(var0, getspawnerarray("mansion_escalation_spawner_back"));
  } else {
    var0 = scripts\engine\utility::array_combine(var0, getspawnerarray("mansion_escalation_spawner_front"));
  }

  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::add_spawn_function, &mansion_escalation_spawnfunc);
  var1 = scripts\engine\utility::getclosest(level.player.origin, var0);
  var2 = scripts\engine\sp\utility::getfarthest(level.player.origin, var0);
  var3 = (var1.origin + var2.origin) / 2;

  for(var4 = 0; var0.size > 0; var4 = 0) {
    if(var0.size == 1) {
      var5 = var0[0];
    } else if(var4 == 0) {
      var5 = scripts\engine\utility::getclosest(level.player.origin, var0);
    } else if(var4 == 2) {
      var5 = scripts\engine\sp\utility::getfarthest(level.player.origin, var0);
    } else {
      var5 = scripts\engine\utility::getclosest(var3, var0);
    }

    var5 thread scripts\engine\sp\utility::spawn_ai();
    var0 = scripts\engine\utility::array_remove(var0, var5);
    var4++;

    if(var4 > 2) {}
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
    var0 = scripts\engine\utility::get_array_of_closest(level.player.origin, level.mansion_escalation_guys, undefined, 4, 1000);

    if(var0.size != 4) {
      continue;
    }

    foreach(var2 in var0) {
      var2 endon("death");
      var2 endon("stealth_combat");
      var2 scripts\engine\utility::thread_on_notify("stealth_combat", &scripts\engine\sp\utility::set_battlechatter, 1);
    }

    scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::set_battlechatter, 0);

    foreach(var5 in get_escalation_aliases("mansion", scripts\engine\utility::ter_op(scripts\engine\utility::flag("player_gone_hot"), "combat", "stealth"))) {
      if(isPlayer(var5[0])) {
        var6 = (0, 0, 0);

        foreach(var2 in var0) {
          var6 += var2.origin;
        }

        var6 /= var0.size;

        if(distance2dsquared(level.player.origin, var6) < squared(800)) {
          level.player thread scripts\engine\sp\utility::smart_player_dialogue(var5[1]);
        }

        continue;
      }

      var9 = var0[var5[0]];
      var9 thread scripts\engine\sp\utility::smart_dialogue_generic(var5[1]);
      var9 waittill("single dialogue");
      wait randomfloatrange(0.25, 0.5);
    }

    scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::set_battlechatter, 1);
    return;
  }
}

function mansion_waypoint_think() {
  level endon("player_on_stairs");
  scripts\sp\maps\estate\estate_util::make_alias_group("mansion_nags", ["dx_vom_pri_goto_obj_mansion_70", "dx_vom_pri_goto_obj_mansion_80", "dx_vom_pri_goto_obj_mansion_90"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("thirdfloor_nags", ["dx_vom_pri_goto_obj_mansion_40", "dx_vom_pri_goto_obj_mansion_50", "dx_vom_pri_goto_obj_mansion_60"]);
  var0 = 0;

  for(;;) {
    scripts\engine\sp\objectives::objective_set_label("mansion", &"ESTATE/OBJ_LBL_ENTER_MANSION");
    var1 = scripts\engine\utility::getStructArray("mansion_entry_waypoint", "targetname");
    var2 = scripts\engine\utility::getclosest(level.player.origin, var1);
    scripts\engine\sp\objectives::objective_set_position("mansion", var2.origin);
    var3 = gettime();

    while(!level.player istouching(level.interior_volumes["mansion"])) {
      if(!scripts\engine\utility::flag("floodlights_on") && !scripts\engine\utility::flag("stealth_spotted") && scripts\engine\utility::time_has_passed(var3, 60)) {
        level.player scripts\engine\sp\utility::smart_radio_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("mansion_nags"));
        var3 = gettime();
      }

      var4 = scripts\engine\utility::getclosest(level.player.origin, var1);

      if(var2 != var4) {
        scripts\engine\sp\objectives::objective_set_position("mansion", var4.origin);
        var2 = var4;
      }

      waitframe();
    }

    scripts\engine\sp\objectives::objective_set_label("mansion", &"ESTATE/OBJ_LBL_THIRD_FLOOR");
    var3 = gettime();
    var5 = scripts\engine\utility::flag("stealth_spotted");

    while(level.player istouching(level.interior_volumes["mansion"])) {
      if(!var0) {
        GscBinSkip4(0x35);
      }

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        if(var5) {
          var3 = gettime();
        } else if(scripts\engine\utility::time_has_passed(var3, 20)) {
          level.player childthread scripts\engine\sp\utility::smart_radio_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("thirdfloor_nags"));
          var3 = gettime();
        }
      }

      var5 = scripts\engine\utility::flag("stealth_spotted");

      if(level.player.origin[2] < 240 && !scripts\engine\utility::flag("player_on_secondfloor_stairs")) {
        var1 = scripts\engine\utility::getStructArray("mansion_secondfloor_waypoint", "targetname");
      } else {
        var1 = scripts\engine\utility::getStructArray("mansion_thirdfloor_waypoint", "targetname");
      }

      var4 = scripts\engine\utility::getclosest(level.player.origin, var1);

      if(var2 != var4) {
        scripts\engine\sp\objectives::objective_set_position("mansion", var4.origin);
        var2 = var4;
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
  var0 = getscriptablearray("downstairs", "targetname");
  var1 = 0;

  foreach(var3 in var0) {
    if(var3 getscriptablepartstate("onoff") == "on") {
      var1 = 1;
      break;
    }
  }

  if(var1) {
    wait 0.85;
    thread mansion_lights_off_audio();

    foreach(var6 in getaiarray("axis")) {
      var7 = undefined;

      if(isDefined(var6.stealth.funcs) && isDefined(var6.stealth.funcs["event_cover_blown"])) {
        var7 = var6.stealth.funcs["event_cover_blown"];
      }

      var6 scripts\stealth\utility::set_stealth_func("event_cover_blown", &floodlights_stealth_filter);
      var6 scripts\engine\utility::delaythread(0.1, &scripts\stealth\utility::set_stealth_func, "event_cover_blown", var7);
    }

    turn_off_mansion_lights();
    wait 0.5;

    foreach(var3 in var0) {
      var3 stopsounds();
    }

    waitframe();
  }

  var11 = getscriptablearray("mansionfloodlights", "targetname");
  var11 = scripts\engine\utility::array_combine(var11, getscriptablearray("floodlight", "script_noteworthy"));
  var12 = 0;

  foreach(var3 in var11) {
    if(var3 getscriptablepartstate("onoff") == "off") {
      var12 = 1;
      break;
    }
  }

  if(var12) {
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

function floodlights_stealth_filter(var0) {
  if(scripts\engine\utility::is_equal(var0.typeorig, "light_killed")) {
    return 1;
  }

  return scripts\sp\maps\estate\estate_util::axis_stealth_filter(var0);
}

function turn_off_mansion_lights() {
  foreach(var1 in level.fuseboxes) {
    if(scripts\engine\utility::is_equal(var1.target, "downstairs")) {
      if(var1.script_light_switch_state) {
        var1.noachievement = 1;
        var1 scripts\sp\interactables\dynolight::lightswitch_toggle();
      }

      var1 scripts\sp\interactables\dynolight::lightswitch_disable(1);
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
  var0 = 5;
  var1 = 0;

  for(;;) {
    if(level.player.blowout > 0.5 && scripts\sp\nvg\nvg_player::is_nvg_on()) {
      var1++;

      if(var1 == var0 * 20) {
        thread scripts\sp\nvg\nvg_player::nvg_off_hint(6);
        return;
      }
    } else {
      var1 = 0;
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
  var0 = getnode("price_at_door", "targetname");
  level.price forceteleport(var0.origin, var0.angles);
  level.price setgoalnode(var0);
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
  var0 = scripts\engine\utility::getStruct("obj_interact", "targetname");
  scripts\engine\sp\objectives::objective_add("mansion", "current", var0.origin + (0, 0, 10), undefined, &"ESTATE/OBJ_LBL_OPEN_DOOR");
  scripts\engine\utility::flag_set("met_up_with_price");
}

function init_grounds() {
  scripts\engine\sp\utility::add_global_spawn_function("axis", &grounds_axis_spawnfunc);
  var0 = scripts\engine\utility::getStructArray("landmark", "targetname");
  level.landmarks = [];

  foreach(var2 in var0) {
    var2.location = var2.script_noteworthy;
    var2.volume = getEnt(var2.target, "targetname");
    var2.fusebox = scripts\engine\utility::getclosest(var2.origin, level.fuseboxes);
    level.landmarks[var2.location] = var2;
  }

  foreach(var5 in getEntArray("waypoint_volume", "targetname")) {
    level.landmarks[var5.script_noteworthy].waypoint_volume = var5;
  }

  foreach(var8 in getEntArray("extra_patrol_spawn_trigger", "targetname")) {
    level.extra_patrol_triggers[var8.script_noteworthy] = var8;
    var8 scripts\engine\utility::trigger_off();
    var8 scripts\engine\sp\utility::add_trigger_function(&vo_extra_patrols);
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

    foreach(var2 in scripts\engine\utility::getStructArray("hvt", "targetname")) {
      level.hvt_structs[var2.script_noteworthy] = var2;
    }

    scripts\engine\utility::array_thread(level.hvt_structs, &spawn_hvt);
  } else {
    level.hvts_identified = 3;
    level.hvt_locations = [];
  }

  scripts\sp\maps\estate\estate_util::make_alias_group("fusebox_call", ["dx_vom_aq1_aqmisc_fuse_10", "dx_vom_aq1_aqmisc_fuse_30", "dx_vom_aq1_aqmisc_fuse_50", "dx_vom_aq2_aqmisc_fuse_70"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("fusebox_response", ["dx_vom_aq2_aqmisc_fuse_20", "dx_vom_aq2_aqmisc_fuse_40", "dx_vom_aq2_aqmisc_fuse_60", "dx_vom_aq3_aqmisc_fuse_80"]);

  foreach(var13 in level.fuseboxes) {
    if(isDefined(var13.script_parameters)) {
      thread fusebox_switchoff_think();
    }
  }

  thread body_drag_door_scene();
  thread setup_grounds_dumpster_scene();
  thread car_rummage_scene("l");
  thread car_rummage_scene("r");
  var15 = scripts\engine\utility::getStructArray("body_poke_scene", "targetname");

  foreach(var2 in var15) {
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
  var0 = getEnt("obj_door", "targetname");
  var1 = var0 scripts\engine\utility::get_linked_ent();
  var1.fx = scripts\engine\utility::spawn_tag_origin(var1.origin - rotatevector((0.5, 0, 0), var1.angles) + (0, 0, 1.1), var1.angles + (0, 180, 0));
  var1.fx linkTo(var1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_estate_keypad_light_red"), var1.fx, "tag_origin");
}

function setup_player_door_wedge() {
  var0 = getEnt("player_door_wedge", "targetname");
  var0 notsolid();
}

function setup_tunnel() {
  var0 = getEnt("tunnel_clip", "targetname");
  var0 disconnectPaths();
  scripts\sp\maps\estate\estate_util::hide_ents("tunnel_destruction");
  var1 = scripts\engine\sp\utility::spawn_anim_model("gate_chain");
  var1.targetname = "tunnel_chain";
  var2 = scripts\engine\utility::getStruct("tunnel_animnode", "targetname");
  var2 thread scripts\common\anim::anim_first_frame_solo(var1, "tunnel_open");
}

function patch_mansion_holes() {
  var0 = spawn("script_model", (-405.5, 3043.5, 241));
  var0 setModel("building_horse_stall_wood_beam_01");
  var0.angles = (270, 180, 90);
  var0 = spawn("script_model", (-404, 3044, 245));
  var0 setModel("ee_manmade_wood_planks_worn_a_06");
  var0.angles = (0, 270, 90);
  var0 = spawn("script_model", (-595.5, 3489.97, 249.48));
  var0 setModel("ee_wainscot_bottom_112_01");
  var0.angles = (90, 90, -90);
  var0 = spawn("script_model", (-595.5, 3601.97, 249.48));
  var0 setModel("ee_wainscot_bottom_112_01");
  var0.angles = (90, 90, -90);
}

function scriptables_init() {
  wait 0.15;
  var0 = getscriptablearray();
  var1 = 0;

  foreach(var3 in var0) {
    var1++;

    if(var1 % 10 == 0) {
      waitframe();
    }

    if(!isDefined(var3)) {
      continue;
    }

    if(issubstr(var3.classname, "veh8")) {
      if(!var3 getscriptablehaspart("car_alarm")) {
        continue;
      }

      if(!isDefined(var3.script_noteworthy) || var3.script_noteworthy == "car_alarm") {
        var3.script_noteworthy = "car_alarm";
        thread car_alarm_think();
      }

      continue;
    }

    if(var3.classname == "scriptable_un_office_computer_monitor_03_ent") {
      setsaveddvar("MMRNLMPPLT", "0");
      cinematicingameloop("sp_estate_labvideo", 1);
      var3 setscriptablepartstate("controller", "full");
      var3.origin = (352, 3090.5, 489);
      var3.angles = (0, 38.148, 0);
      continue;
    }

    if(isDefined(var3.targetname) && isendstr(var3.targetname, "fall_chandelier")) {
      var3 hide();
      var3 setCanDamage(0);
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
    var0 = scripts\stealth\utility::get_group("pool_interior");
    var1 = scripts\stealth\utility::get_group("pool_interrogator");
    var2 = scripts\engine\utility::array_combine(var0, var1);
    scripts\engine\sp\utility::waittill_dead(var2);
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

  var0 = 3;

  for(;;) {
    level scripts\engine\utility::waittill_notify_or_timeout("grounds_save", 15);
    var1 = level.curautosave;

    while(var1 == level.curautosave) {
      scripts\engine\sp\utility::autosave_or_timeout("estate_grounds", var0);
      wait var0;
    }
  }
}

function molotovs_damage_hvts() {
  level endon("obj_scene_started");

  for(;;) {
    level waittill("molotov_impact", var0, var1);

    if(!isDefined(level.hvts)) {
      continue;
    }

    foreach(var3 in level.hvts) {
      if(distancesquared(var3.origin, var1) > squared(64)) {
        continue;
      }

      if(istrue(var3.dead)) {
        var3 setModel("burntbody_male");
        continue;
      }

      var3.health -= 1000;
      var3 notify("damage", 1000, var0, undefined, var1, "MOD_FIRE");
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
  var0 = level.stealth.ai_event;
  GscBinSkip1(0x45, "ai_eventDistFootstepSprint", "spotted", 200);
}

function update_event_dists(var0, var1) {
  level endon("stealth_enabled");

  for(;;) {
    level.player scripts\engine\utility::ent_flag_wait("indoors");
    scripts\stealth\manager::set_custom_distances(var0);
    level.player scripts\engine\utility::ent_flag_waitopen("indoors");
    scripts\stealth\manager::set_custom_distances(var1);
  }
}

function obj_door_interact() {
  if(scripts\engine\utility::flag("hvt_found")) {
    return;
  }

  var0 = scripts\engine\utility::getStruct("obj_door_handle", "targetname");
  var0 thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SCRIPT/DOOR_HINT_USE_NO_BASH");
  var0 thread scripts\sp\maps\estate\estate_util::door_interact_presentation();
  level scripts\engine\utility::waittill_any("hvt_found", "player_tried_door");

  if(scripts\engine\utility::flag("hvt_found")) {
    var0 scripts\sp\player\cursor_hint::remove_cursor_hint();
    return;
  }

  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_obj_room_earlydoor_10");
}

function nade_triggers_init() {
  level endon("obj_scene_started");
  var0 = getEntArray("nade_closet", "targetname");
  var1 = var0;
  var3 = getfirstarraykey(var1);

  if(isDefined(var3)) {
    var2 = var1[var3];
    GscBinSkip4(0x6e, var2);
  }

  var1 = undefined;
  var3 = undefined;
}

function nade_trigger_think() {
  var0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  for(;;) {
    self waittill("trigger");
    var1 = undefined;

    while(level.player istouching(self)) {
      waitframe();

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        var1 = undefined;
        continue;
      }

      if(!isDefined(var1)) {
        var1 = gettime();
      }

      if(!scripts\engine\utility::time_has_passed(var1, 10)) {
        continue;
      }

      if(level.player.numgrenadesinprogresstowardsplayer > 0) {
        continue;
      }

      if(!scripts\engine\utility::time_has_passed(level.player.lastfraggrenadetoplayerstart, 10) || !scripts\engine\utility::time_has_passed(level.player.lastgrenadelandednearplayertime, 5)) {
        continue;
      }

      var2 = getaiarray("axis");
      var3 = undefined;
      var4 = undefined;
      var5 = undefined;

      foreach(var7 in var0) {
        if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var7.origin, 0.766)) {
          waitframe();

          if(sighttracepassed(level.player getEye(), var7.origin, 0, level.player)) {
            continue;
          }
        }

        var8 = scripts\engine\utility::getStruct(var7.target, "targetname");
        waitframe();

        if(!scripts\engine\trace::ray_trace_passed(var7.origin, var8.origin, level.player)) {
          continue;
        }

        var2 = scripts\engine\utility::array_removedead_or_dying(var2);

        foreach(var10 in sortbydistance(var2, var7.origin)) {
          if(!isDefined(var10) || !isalive(var10)) {
            continue;
          }

          if(distancesquared(var10.origin, var7.origin) > 10000) {
            break;
          }

          if(!var10[[var10.fnisinstealthcombat]]()) {
            continue;
          }

          if(isDefined(var10.a) && isDefined(var10.a.lastshoottime) && !scripts\engine\utility::time_has_passed(var10.a.lastshoottime, 2)) {
            continue;
          }

          if(istrue(self.ispreppinggrenade) || istrue(self.isholdinggrenade)) {
            continue;
          }

          if(!ispointinvolume(var10 lastknownpos(level.player), self)) {
            continue;
          }

          var5 = var10;
          break;
        }

        if(!isDefined(var5)) {
          continue;
        }

        var3 = var7.origin;
        var4 = var8.origin;
        break;
      }

      if(!isDefined(var3)) {
        continue;
      }

      var13 = magicgrenade("flash", var3, var4, 1);

      if(!isDefined(var13)) {
        continue;
      }

      thread grenade_badplace_think(var13);
      wait 10;
    }
  }
}

function grenade_badplace_think(var0) {
  var1 = createnavbadplacebyent(self, "axis");
  var0 waittill("death");
  destroynavobstacle(var1);
}

function update_vfx_shadow_limit() {
  var0 = 2;

  while(!scripts\engine\utility::flag("grounds_cleared")) {
    var1 = getdvarint("LKOLRONRNQ");
    var2 = getaiarray("axis");
    var3 = 0;

    foreach(var5 in sortbydistance(var2, level.player.origin)) {
      if(distancesquared(var5.origin, level.player.origin) > var1 * var1) {
        break;
      }

      if(istrue(var5.flashlight)) {
        var3++;

        if(var3 >= 6) {
          break;
        }
      }
    }

    var3 = clamp(var3, 2, 6);

    if(var3 != var0) {
      var0 = var3;
      setsaveddvar("LLNMKLQQP", var0);
    }

    waitframe();
  }

  if(var0 != 2) {
    setsaveddvar("LLNMKLQQP", 2);
    return;
  }
}

function init_stealth_areas() {
  level.stealth_areas = [];
  var0 = ["courtyard", "church", "garden", "mansion", "pool", "service", "monument", "shed", "dock", "woods", "technical"];
  var1 = getspawnerteamarray("axis");

  foreach(var3 in var0) {
    var4 = spawnStruct();
    var4.name = var3;
    var4.stealthgroups = [];
    var4.spawners = [];

    foreach(var6 in var1) {
      if(!isDefined(var6.script_stealthgroup)) {
        var1 = scripts\engine\utility::array_remove(var1, var6);
        continue;
      }

      if(scripts\engine\utility::string_starts_with(var6.script_stealthgroup, var3)) {
        if(!scripts\engine\utility::array_contains(var4.stealthgroups, var6.script_stealthgroup)) {
          var4.stealthgroups[var4.stealthgroups.size] = var6.script_stealthgroup;
        }

        var4.spawners[var4.spawners.size] = var6;
        var1 = scripts\engine\utility::array_remove(var1, var6);
      }
    }

    level.stealth_areas[var3] = var4;
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

function area_gone_hot_think(var0) {
  var1 = 0;
  var2 = 0;
  jumpiftrue(scripts\engine\utility::flag_exist(var0 + "_gone_hot")) LOC_0000001f;
  level endon("player_gone_hot");

  for(;;) {
    level waittill(var0 + "_hot_event", var3);

    if(gettime() - var2 > 5000) {
      var1 = 0;
    }

    var1++;
    var2 = gettime();

    if(var1 >= 3) {
      escalate_grounds_to_alert();

      if(scripts\engine\utility::flag_exist(var0 + "_gone_hot") && !scripts\engine\utility::is_equal(var3.script_noteworthy, "escalation_patroller")) {
        scripts\engine\utility::flag_set(var0 + "_gone_hot");
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
    var0 = scripts\engine\utility::getclosest(self.origin, level.hvts, 80);

    if(isDefined(var0) && distancesquared(self.origin, level.player.origin) > squared(120)) {
      self.dropweapon = 0;
    }
  }

  return false;
}

function axis_attacked_think() {
  self endon("sniped");
  var0 = self.area;

  while(isalive(self)) {
    scripts\engine\utility::waittill_any("bulletwhizby", "bullethit", "flashed", "damage", "death");
    scripts\engine\utility::flag_set(var0 + "_under_attack");
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
  var0 = self.spawner;
  self waittill("entitydeleted");

  if(isDefined(var0.suspended_ai)) {
    scripts\engine\utility::flag_clear(self.script_stealthgroup + "_spawned");

    foreach(var2 in level.stealth_areas[var0.script_stealthgroup].spawners) {
      if(var2 != var0) {
        var2.suspended_ai = var0.suspended_ai;
        var2.count = 0;
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

function escalate_grounds(var0) {
  if(!level.escalation_level) {
    scripts\engine\utility::flag_set("technical_called");
  }

  var1 = level.landmarks[var0].volume;

  while(level.player istouching(var1)) {
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
      var2 = level.extra_patrol_triggers[level.hvt_locations[0]];
      var2 scripts\engine\utility::trigger_on();

      if(isDefined(level.ownthenight_spawners) && !scripts\engine\utility::flag("courtyard_backup_spawned") && !scripts\engine\utility::flag("church_backup_spawned") && !scripts\engine\utility::flag("pool_backup_spawned")) {
        var3 = getspawnerarray(var2.target);
        scripts\engine\utility::array_thread(var3, &scripts\sp\maps\estate\estate_util::ownthenight_spawner_think, ["backup_spawned", "obj_scene_started"]);
        level.ownthenight_spawners = scripts\engine\utility::array_combine(level.ownthenight_spawners, var3);
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

function escalate_grounds_with_func(var0) {
  var1 = getaiarray("axis");

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.script_noteworthy, "escalation_patroller")) {
      continue;
    }

    var3 thread[[var0]]();
  }

  var5 = getspawnerarray();

  foreach(var7 in var5) {
    if(!isDefined(var7.script_stealthgroup)) {
      continue;
    }

    if(scripts\engine\utility::is_equal(var7.script_noteworthy, "escalation_patroller")) {
      continue;
    }

    if(issubstr(var7.script_stealthgroup, "_backup")) {
      continue;
    }

    if(var7.count < 1 && !isDefined(var7.suspended_ai)) {
      continue;
    }

    var7 scripts\engine\sp\utility::add_spawn_function(var0);
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
  var0 = get_area();
  self.flashlightoverride = 1;
  var1 = getEntArray(var0 + "_escalation_patrol_trig", "targetname");

  foreach(var3 in var1) {
    var3 delete();
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

function escalation_patroller_combat_filter(var0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var0)) {
    return true;
  }

  self.flashlightoverride = undefined;
  self.goalradius = 1024;
  self setgoalpos(var0.origin);
  return false;
}

function vo_escalation_patrollers(var0) {
  if(var0 == "mansion") {
    var1 = 4;
    var2 = scripts\engine\utility::flag("player_gone_hot");
  } else {
    var1 = 2;
    var2 = scripts\engine\utility::flag(var2 + "_gone_hot");
  }

  foreach(var4 in level.escalation_patrollers[var2]) {
    var4 scripts\engine\sp\utility::set_battlechatter(0);

    if(var2) {
      var4.stealth.patrol_moveplaybackrate = 1;
    }

    var4 endon("reached_path_end");
  }

  level endon(var2 + "_escalation_patrollers_vo_interrupted");
  thread escalation_patrollers_interrupt_think(var2);

  if(var2 == "mansion") {
    scripts\engine\utility::flag_wait("floodlights_on");
    wait 1;
  }

  var6 = undefined;

  if(var2 != "mansion") {
    jumpiffalse(level.hvts_identified == 1) LOC_000000c7;
    thread escalation_patrollers_callout_think(var2);

    for(;;) {
      waitframe();
      var7 = (0, 0, 0);

      foreach(var4 in level.escalation_patrollers[var2]) {
        if(var4 istouching(level.interior_volumes[var2])) {
          return;
        }

        var7 += var4.origin;
      }

      var7 /= level.escalation_patrollers[var2].size;

      if(distance2dsquared(level.player.origin, var7) < squared(800)) {
        break;
      }
    }

    var10 = scripts\engine\utility::array_remove(["church", "courtyard", "pool"], var2);

    foreach(var12 in var10) {
      if(isDefined(level.escalation_patrollers[var12])) {
        var6 = var12;
        break;
      }
    }
  }

  if(isDefined(var6)) {
    var14 = var6 + "_" + var2;
  } else {
    var14 = var1;
  }

  if(var3) {
    var15 = "combat";
  } else {
    var15 = "stealth";
  }

  foreach(var17 in get_escalation_aliases(var15, var15)) {
    if(isPlayer(var17[0])) {
      var7 = (0, 0, 0);

      foreach(var6 in level.escalation_patrollers[var2]) {
        var7 += var6.origin;
      }

      var7 /= level.escalation_patrollers[var2].size;

      if(distance2dsquared(level.player.origin, var7) < squared(800)) {
        level.player thread scripts\engine\sp\utility::smart_player_dialogue(var17[1]);
      }

      continue;
    }

    var20 = level.escalation_patrollers[var2][var17[0]];
    var20 thread scripts\engine\sp\utility::smart_dialogue_generic(var17[1]);
    var20 waittill("single dialogue");
    wait randomfloatrange(0.25, 0.5);
  }

  foreach(var6 in level.escalation_patrollers[var2]) {
    var6 scripts\engine\sp\utility::set_battlechatter(1);
  }

  level notify(var2 + "_escalation_patrollers_vo_completed");
}

function get_escalation_aliases(var0, var1) {
  switch (var0) {
    case "church":
      if(var1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_chkchurch_10"], [1, "dx_vom_aq2_aqchat_chkchurch_20"], [0, "dx_vom_aq1_aqchat_chkchurch_30"], [1, "dx_vom_aq2_aqchat_chkchurch_40"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_hotchurch_10"], [1, "dx_vom_aq2_aqchat_hotchurch_20"], [0, "dx_vom_aq1_aqchat_hotchurch_30"]];
      }
    case "church_courtyard":
      if(var1 == "stealth") {
        return [[0, "dx_vom_aq2_aqchat_crtchrch1_10"], [1, "dx_vom_aq3_aqchat_crtchrch1_20"], [0, "dx_vom_aq2_aqchat_crtchrch1_30"]];
      } else {
        return [[0, "dx_vom_aq2_aqchat_crtchrch2_10"], [1, "dx_vom_aq3_aqchat_crtchrch2_20"], [0, "dx_vom_aq2_aqchat_crtchrch2_30"]];
      }
    case "church_pool":
      if(var1 == "stealth") {
        return [[0, "dx_vom_aq3_aqchat_spachrch1_10"], [1, "dx_vom_aq4_aqchat_spachrch1_20"], [0, "dx_vom_aq3_aqchat_spachrch1_30"]];
      } else {
        return [[0, "dx_vom_aq3_aqchat_spachrch2_10"], [1, "dx_vom_aq4_aqchat_spachrch2_20"], [0, "dx_vom_aq3_aqchat_spachrch2_30"]];
      }
    case "courtyard":
      if(var1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_chkcourt_10"], [1, "dx_vom_aq2_aqchat_chkcourt_20"], [0, "dx_vom_aq1_aqchat_chkcourt_30"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_hotcourt_10"], [1, "dx_vom_aq2_aqchat_hotcourt_20"], [0, "dx_vom_aq1_aqchat_hotcourt_30"]];
      }
    case "courtyard_church":
      if(var1 == "stealth") {
        return [[0, "dx_vom_aq3_aqchat_chrchcrt1_10"], [1, "dx_vom_aq4_aqchat_chrchcrt1_20"], [0, "dx_vom_aq3_aqchat_chrchcrt1_30"]];
      } else {
        return [[0, "dx_vom_aq3_aqchat_chrchcrt2_10"], [1, "dx_vom_aq4_aqchat_chrchcrt2_20"]];
      }
    case "courtyard_pool":
      if(var1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_spacrt1_10"], [1, "dx_vom_aq2_aqchat_spacrt1_20"], [0, "dx_vom_aq1_aqchat_spacrt1_30"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_spacrt2_10"], [1, "dx_vom_aq2_aqchat_spacrt2_20"], [0, "dx_vom_aq1_aqchat_spacrt2_30"]];
      }
    case "pool":
      if(var1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_chkspa_10"], [0, "dx_vom_aq1_aqchat_chkspa_20"], [1, "dx_vom_aq2_aqchat_chkspa_30"], [0, "dx_vom_aq1_aqchat_chkspa_40"], [1, "dx_vom_aq2_aqchat_chkspa_50"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_hotspa_10"], [1, "dx_vom_aq2_aqchat_hotspa_20"], [0, "dx_vom_aq1_aqchat_hotspa_30"]];
      }
    case "pool_church":
      if(var1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_chrchspa1_10"], [1, "dx_vom_aq3_aqchat_chrchspa1_20"], [0, "dx_vom_aq1_aqchat_chrchspa1_30"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_chrchspa2_10"], [1, "dx_vom_aq3_aqchat_chrchspa2_20"], [0, "dx_vom_aq1_aqchat_chrchspa2_30"]];
      }
    case "pool_courtyard":
      if(var1 == "stealth") {
        return [[0, "dx_vom_aq1_aqchat_crtspa1_10"], [1, "dx_vom_aq2_aqchat_crtspa1_20"], [0, "dx_vom_aq1_aqchat_crtspa1_30"]];
      } else {
        return [[0, "dx_vom_aq1_aqchat_crtspa2_10"], [1, "dx_vom_aq2_aqchat_crtspa2_20"], [0, "dx_vom_aq1_aqchat_crtspa2_30"]];
      }
    case "mansion":
      return [[0, "dx_vom_aq1_goto_obj_floodlights_20"], [2, "dx_vom_aq3_goto_obj_floodlights_40"], [1, scripts\engine\utility::ter_op(var1 == "stealth", "dx_vom_aq2_goto_obj_floodlights_50", "dx_vom_aq2_goto_obj_floodlights_60")], [0, scripts\engine\utility::ter_op(var1 == "stealth", "dx_vom_aq1_goto_obj_patrol_10", "dx_vom_aq1_goto_obj_patrol_20")], [1, "dx_vom_aq2_goto_obj_patrol_30"], [2, "dx_vom_aq3_goto_obj_patrol_40"], [0, "dx_vom_aq1_goto_obj_patrol_50"], [1, "dx_vom_aq2_goto_obj_patrol_60"], [0, "dx_vom_aq1_goto_obj_patrol_70"], [level.player, "dx_vom_kyle_goto_obj_patrol_80"]];
  }
}

function escalation_patrollers_interrupt_think(var0) {
  level endon(var0 + "_escalation_patrollers_vo_completed");
  scripts\engine\utility::waittill_any_ents_array(level.escalation_patrollers[var0], "stealth_investigate", "stealth_combat", "death");

  foreach(var2 in level.escalation_patrollers[var0]) {
    if(isalive(var2)) {
      var2 scripts\engine\sp\utility::set_battlechatter(1);
    }
  }

  level notify(var0 + "_escalation_patrollers_vo_interrupted");
}

function escalation_patrollers_callout_think(var0) {
  if(scripts\engine\utility::flag("player_gone_hot")) {
    return;
  }

  level endon("player_gone_hot");
  level endon("identify_anim_started");
  level scripts\engine\utility::waittill_any(var0 + "_escalation_patrollers_vo_completed", var0 + "_escalation_patrollers_vo_interrupted", "player_left_" + var0);
  scripts\sp\maps\estate\estate_util::waittill_player_hidden();
  thread request_overwatch_vo("escalation", "dx_vom_pri_hvt_stealth1_100", 1, 1, undefined, undefined, "identify_anim_started");
}

function vo_extra_patrols(var0) {
  request_overwatch_vo("escalation", "dx_vom_pri_backup_mansion_60", 0, 1, undefined, 2);
}

function stealth_event_propagator() {
  scripts\engine\utility::flag_wait("stealth_enabled");
  level endon("stealth_enabled");
  GscBinSkip1(0x45, "gunshot", getdvarint("ai_eventDistGunShot"));
}

function propagate_event_thread(var0, var1, var2) {
  foreach(var4 in var2) {
    if(!isDefined(var4)) {
      continue;
    }

    if(distancesquared(var4.origin, var0.origin) > var1[var0.typeorig] * var1[var0.typeorig]) {
      break;
    }

    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "lone_patroller") && scripts\engine\utility::flag(var4.script_stealthgroup + "_spawned")) {
      continue;
    }

    if(!isDefined(var4.suspended_ai)) {
      if(var4.count < 1) {
        continue;
      }

      if(istrue(var4.dont_propagate_events_prespawn)) {
        continue;
      }

      if(isstartstr(var4.targetname, "mansion_escalation_spawner") && level.hvts_identified < 3) {
        continue;
      }
    }

    if(var0.typeorig == "light_killed" && distancesquared(var4.origin, var0.origin) > 160000) {
      waitframe();

      if(!isDefined(var4)) {
        continue;
      }

      if(!sighttracepassed(var4.origin + (0, 0, 60), var0.origin, 0, var0.entity)) {
        continue;
      }
    }

    var5 = undefined;

    if(getaiarray().size < 32 && !scripts\engine\utility::is_equal(var4.script_parameters, "stealth_spawn_only")) {
      var5 = var4 scripts\engine\sp\utility::spawn_ai();
    }

    if(isDefined(var5)) {
      var5 aieventlistenerevent(var0.typeorig, var0.entity, var0.origin);
      continue;
    }

    if(isDefined(var4.suspended_ai)) {
      if(var0.type == "combat") {
        var4.suspended_ai.stealth.bsmstate = 3;
      } else {
        var4.suspended_ai.stealth.bsmstate = max(1, var4.suspended_ai.stealth.bsmstate);
        var4.suspended_ai.stealth.investigateevent = var0;
      }

      continue;
    }

    var6 = spawnStruct();
    var6.origin = var4.origin;
    var6.angles = var4.angles;
    var6.suspendtime = gettime();
    var6.stealth = spawnStruct();

    if(var0.type == "combat") {
      var6.stealth.bsmstate = 3;
    } else {
      var6.stealth.bsmstate = 1;
      var6.stealth.investigateevent = var0;
    }

    var6.suspendvars = spawnStruct();
    var4.suspended_ai = var6;
    var4.count = 0;
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

function overwatch_noteworthy_priority(var0) {
  if(!isDefined(var0)) {
    return -1;
  }

  switch (var0) {
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

  foreach(var1 in ["church", "courtyard", "mansion", "pool"]) {
    if(scripts\sp\maps\estate\estate_util::alias_group_exists("backup_" + var1)) {
      scripts\sp\maps\estate\estate_util::clear_alias_group("backup_" + var1);
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

function play_overwatch_vo(var0) {
  level notify("overwatch_vo_response_" + var0.type, 1);
  level.current_overwatch_vo = var0.type;
  level.overwatch_requests[var0.type] = undefined;
  internal_play_overwatch_vo(var0);
  level notify("overwatch_vo_completed", var0.type);
  level.last_overwatch_vo_time = gettime();
  level.current_overwatch_vo = undefined;
}

function internal_play_overwatch_vo(var0) {
  if(isDefined(var0.endon_str)) {
    level endon(var0.endon_str);
  }

  var1 = [];

  if(isDefined(var0.delay_str)) {
    if(isDefined(var0.delay_time)) {
      level scripts\engine\utility::waittill_notify_or_timeout(var0.delay_str, var0.delay_time);
    } else {
      level waittill(var0.delay_str);
    }
  } else if(isDefined(var0.delay_time)) {
    wait var0.delay_time;
  }

  level.player scripts\engine\sp\utility::smart_radio_dialogue(var0.alias);
}

function request_overwatch_vo(var0, var1, var2, var3, var4, var5, var6) {
  if(!scripts\engine\utility::string_starts_with(var1, "dx_vom_")) {
    var1 = "dx_vom_pri_" + var1;
  }

  level notify("new_overwatch_request_" + var0);
  level endon("new_overwatch_request_" + var0);
  var7 = spawnStruct();
  var7.type = var0;
  var7.alias = var1;
  var7.ignore_cooldown = istrue(var2);
  var7.persistent = istrue(var3);
  var7.delay_str = var4;
  var7.delay_time = var5;
  var7.endon_str = var6;
  level.overwatch_requests[var0] = var7;
  jumpiffalse(isDefined(var6)) LOC_00000094;
  GscBinSkip4(0x6e, level, var7);

  level waittill("overwatch_vo_response_" + var0, var8);
  return var8;
}

function overwatch_request_end(var0) {
  level endon("overwatch_vo_response_" + var0.type);
  level waittill(var0.endon_str);
  level.overwatch_requests[var0.type] = undefined;
  level notify("overwatch_vo_response_" + var0.type, 0);
}

function overwatch_disengage_think() {
  var0 = ["dx_vom_pri_disengage_nags_10", "dx_vom_pri_disengage_nags_20"];

  for(;;) {
    self waittill("damage", var1, var2);

    if(!isai(var2)) {
      continue;
    }

    if(self getnormalhealth() > 0.25) {
      continue;
    }

    wait 2;

    if(!scripts\sp\maps\estate\estate_util::anyone_in_combat()) {
      continue;
    }

    if(request_overwatch_vo("combat", scripts\engine\utility::random(var0))) {
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

    var0 = 1;

    foreach(var2 in sortbydistance(getaiarray("axis"), self.origin)) {
      if(distancesquared(var2 getEye(), self getEye()) > self.maxvisibledist * self.maxvisibledist) {
        break;
      }

      if(scripts\engine\utility::within_fov(var2 getEye(), var2.angles, self getEye(), var2.fovcosineperiph) && var2 hastacvis(self)) {
        var0 = 0;
        break;
      }
    }

    if(var0) {
      continue;
    }

    var4 = gettime();

    while(!scripts\engine\utility::time_has_passed(var4, 5)) {
      waitframe();

      if(self getstance() != "stand") {
        break;
      }
    }

    if(!scripts\engine\utility::time_has_passed(var4, 5)) {
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
  var0 = level scripts\engine\utility::waittill_notify_or_timeout_return("player_has_overwatch", 1);

  if(var0 == "player_has_overwatch") {
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
  var0 = level scripts\engine\utility::waittill_notify_or_timeout_return("player_has_overwatch", 15);

  if(var0 == "player_has_overwatch") {
    return;
  }

  for(;;) {
    level waittill("player_has_overwatch");
    var0 = level scripts\engine\utility::waittill_notify_or_timeout_return("player_has_overwatch", 1);

    if(var0 == "timeout") {
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
  var0 = ["dx_vom_pri_estate_stealth_00", "dx_vom_pri_estate_stealth_07"];
  scripts\engine\utility::flag_wait("stealth_enabled");
  waittillframeend();
  childthread scripts\sp\stealth\player::stealth_noteworthy_callouts(1);
  var1 = 1;
  var2 = [];

  for(;;) {
    if(!var1) {
      level.stealth.noteworthy.callout_next -= 5000;

      if(var2.size) {
        foreach(var4 in var2) {
          var4.stealth.callout_next -= 30000;
        }
      }
    }

    self waittill("stealth_noteworthy", var6, var2);

    if(!isstartstr(var6, "callout")) {
      var1 = 1;
      continue;
    }

    var1 = 0;
    var9 = strtok(var6, "_")[1];
    var10 = 0;

    foreach(var4 in var2) {
      if(is_technical_rider(var4)) {
        if(var9 == "ahead") {
          var2 = scripts\engine\utility::array_remove(var2, var4);
          var4.stealth.callout_next -= 30000;
          continue;
        }

        var10 = 1;
      }
    }

    if(var2.size == 0) {
      continue;
    }

    if(var10) {
      foreach(var14 in level.technical.riders) {
        if(!scripts\engine\utility::array_contains(var2, var14)) {
          var2 = var14;
          var14.stealth.callout_next = var2[0].stealth.callout_next;
        }
      }
    }

    var16 = "";

    if(var10) {
      var16 = "_technical";
    } else if(var2.size > 1) {
      var16 = "_multiple";
    }

    for(var17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var9 + var16, 1); scripts\engine\utility::array_contains(var0, var17) && scripts\engine\utility::flag("stealth_spotted"); var17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var9 + var16, 1)) {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index(var9 + var16);
    }

    if(!request_overwatch_vo("enemy", var17)) {
      continue;
    }

    scripts\sp\maps\estate\estate_util::increment_alias_group_index(var9 + var16);
    var1 = 1;
  }
}

function can_callout_enemy(var0) {
  if(!scripts\engine\utility::flag("player_has_overwatch")) {
    return false;
  }

  if(abs(self getnormalizedcameramovement()[1]) > 0.1) {
    return false;
  }

  if(length2dsquared(self getvelocity()) > squared(150)) {
    return false;
  }

  if(abs((var0.origin - self.origin)[2]) > 128) {
    return false;
  }

  if(var0 scripts\engine\utility::doinglongdeath()) {
    return false;
  }

  if(var0 scripts\engine\sp\utility::is_touching_any(level.interior_volumes)) {
    return false;
  }

  if(distancesquared(self.origin, var0.origin) <= level.stealth.noteworthy.callout_proximity_radius * level.stealth.noteworthy.callout_proximity_radius) {
    var1 = self getEye();
    var2 = var0 getapproxeyepos();
    scripts\sp\stealth\player::stealth_noteworthy_trace_safety_check();
    var3 = scripts\engine\trace::ray_trace(var1, var2, [self, var0], level.stealth.noteworthy.callout_trace_contents);

    if(is_point_in_any_volume(var3["position"], level.interior_volumes)) {
      return false;
    }

    if(distancesquared(var3["position"], var2) <= 16384) {
      return true;
    }

    scripts\sp\stealth\player::stealth_noteworthy_trace_safety_check();
    var4 = scripts\engine\trace::ray_trace(var2, var1, [self, var0], level.stealth.noteworthy.callout_trace_contents);

    if(is_point_in_any_volume(var4["position"], level.interior_volumes)) {
      return false;
    }

    if(distancesquared(var4["position"], var1) <= 16384) {
      return true;
    }

    if(distancesquared(var3["position"], var4["position"]) > 16384) {
      return false;
    }
  }

  return true;
}

function is_point_in_any_volume(var0, var1) {
  foreach(var3 in var1) {
    if(ispointinvolume(var0, var3)) {
      return true;
    }
  }

  return false;
}

function overwatch_aim_callout_think() {
  var0 = create_aim_contents();
  scripts\sp\maps\estate\estate_util::make_alias_group("proximitysolo", ["dx_vom_pri_stealth_wait_40", "dx_vom_pri_stealth_wait_50", "dx_vom_pri_stealth_wait_60"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("proximitymulti", ["dx_vom_pri_stealth_waitgroup_40", "dx_vom_pri_stealth_waitgroup_50", "dx_vom_pri_stealth_waitgroup_60"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("sightsolo", ["dx_vom_pri_stealth_soloeye_10", "dx_vom_pri_stealth_soloeye_20", "dx_vom_pri_stealth_soloeye_30"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("sightmulti", ["dx_vom_pri_stealth_multieye_10", "dx_vom_pri_stealth_multieye_20", "dx_vom_pri_stealth_multieye_30"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("warntechnical", ["dx_vom_pri_technical_warn_10", "dx_vom_pri_technical_warn_20", "dx_vom_pri_technical_warn_30"]);
  var1 = [];
  var2 = -99999;

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

    var3 = -1;
    var4 = undefined;
    var5 = self getEye();
    var6 = vectorNormalize(anglesToForward(self getplayerangles()));
    var7 = getaiarray();

    foreach(var9 in var7) {
      var10 = var9 getapproxeyepos();
      var11 = distancesquared(var5, var10);

      if(var11 > squared(500)) {
        var12 = sqrt(var11);
        var13 = var5 + (var12 - 500) * var6;
        var14 = vectorNormalize(var10 - var13);
      } else {
        var14 = vectorNormalize(var10 - var5);
      }

      var15 = vectordot(var6, var14);

      if(var15 < 0.99 || var15 < var3) {
        continue;
      }

      if(scripts\engine\trace::ray_trace_passed(var10, var5, undefined, var0)) {
        var3 = var15;
        var4 = var9;
      }
    }

    if(isDefined(var4)) {
      if(var4 scripts\engine\sp\utility::is_touching_any(level.interior_volumes)) {
        continue;
      }

      if(isDefined(var4.aim_status) && gettime() - var4.last_aim_callout_time < 30000) {
        continue;
      }

      if(var4.script_stealthgroup == "technical" && isDefined(var4.ridingvehicle)) {
        var17 = "warntechnical";
      } else if(!scripts\sp\maps\estate\estate_util::player_has_silencer()) {
        var17 = undefined;

        if(scripts\engine\utility::time_has_passed(var2, 30)) {
          var17 = "nonsuppressed";
        }
      } else {
        var17 = get_target_intel(var4);
      }

      if(!isDefined(var17)) {
        continue;
      }

      var18 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var17, 1);

      if(request_overwatch_vo("aim", var18, 1)) {
        scripts\sp\maps\estate\estate_util::increment_alias_group_index(var17);
        var4.aim_status = var17;
        var4.last_aim_callout_time = gettime();

        if(var17 == "nonsuppressed") {
          var2 = gettime();
        }

        wait 5;
      }
    }
  }
}

function get_target_intel(var0) {
  var1 = [];
  var2 = [];
  var3 = getaiarray(var0.team);
  var4 = "proximity";
  var5 = scripts\engine\utility::get_array_of_closest(var0.origin, var3, [var0], undefined, level.stealth.damage_auto_range);

  if(var5.size == 0) {
    var4 = "sight";
    var5 = scripts\engine\utility::get_array_of_closest(var0.origin, var3, [var0], undefined, level.stealth.damage_sight_range);

    foreach(var7 in var5) {
      if(!var7 scripts\engine\math::point_in_fov(var0.origin, 0) || !var7 cansee(var0)) {
        var5 = scripts\engine\utility::array_remove(var5, var7);
      }
    }

    if(var5.size == 0) {
      return undefined;
    }
  }

  if(var5.size > 1) {
    var4 += "multi";
  } else {
    var4 += "solo";
  }

  foreach(var7 in var5) {
    if(!level.player scripts\engine\math::point_in_fov(var7.origin, 0.8)) {
      continue;
    }

    if(!sighttracepassed(level.player getEye(), var7 getapproxeyepos(), 0, [level.player, var7])) {
      continue;
    }

    var5 = scripts\engine\utility::array_remove(var5, var7);
  }

  if(var5.size == 0) {
    return undefined;
  }

  return var4;
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
    self waittill("stealth_noteworthy", var0, var1);

    if(!isstartstr(var0, "good_kill")) {
      continue;
    }

    if(!scripts\engine\utility::flag("player_has_overwatch")) {
      continue;
    }

    if(isDefined(level.sniper_assist_target)) {
      continue;
    }

    var2 = 0;

    foreach(var4 in var1) {
      if(!isDefined(var4)) {
        continue;
      }

      if(var4 scripts\engine\sp\utility::is_touching_any(level.interior_volumes)) {
        var1 = scripts\engine\utility::array_remove(var1, var4);
      }

      if(isDefined(var4.aim_status) && scripts\stealth\enemy::shotisbadidea(var4)) {
        var2 = 1;
      }
    }

    if(var1.size == 0) {
      continue;
    }

    var6 = undefined;
    var7 = undefined;

    if(var2) {
      var6 = "dx_vom_pri_stealth_doublekill_30";
    } else {
      switch (var0) {
        case "good_kill":
          var7 = "melee_kill";
        case "good_kill_bullet":
          var7 = "bullet_kill";
          break;
        case "good_kill_impressive":
        case "good_kill_double":
          var7 = "impressive_kill";
          break;
      }
    }

    if(!isDefined(var6)) {
      if(!isDefined(var7)) {
        continue;
      }

      var6 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var7, 1);
    }

    if(!request_overwatch_vo("kill", var6, 1, 0, undefined, 0.75)) {
      continue;
    }

    if(isDefined(var7)) {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index(var7);
    }
  }
}

function overwatch_landmark_callout_think() {
  var0 = level.landmarks;

  foreach(var2 in var0) {
    var2.last_callout_time = -90000;
  }

  GscBinSkip1(0x45, "courtyard", "ahead", "dx_vom_pri_hvt_landmark_10");
}

function overwatch_hvt_callout_think(var0) {
  var0 waittill("hvt_spawned", var1);
  var2 = undefined;

  switch (var1.location) {
    case "church":
      var2 = ["dx_vom_pri_hvt_churchint_10", "dx_vom_pri_hvt_churchint_20", "dx_vom_pri_hvt_churchint_30"];
      break;
    case "courtyard":
      var2 = ["dx_vom_pri_hvt_courtyardint_10", "dx_vom_pri_hvt_courtyardint_20", "dx_vom_pri_hvt_courtyardint_30"];
      break;
    case "pool":
      var2 = ["dx_vom_pri_hvt_poolint_20", "dx_vom_pri_hvt_poolint_10", "dx_vom_pri_hvt_poolint_30"];
      break;
  }

  scripts\sp\maps\estate\estate_util::make_alias_group("overwatch_hvt_" + var1.location, var2);

  switch (var1.location) {
    case "church":
      var2 = ["dx_vom_pri_hvt_lastloc_10", "dx_vom_pri_hvt_lastloc_20"];
      break;
    case "courtyard":
      var2 = ["dx_vom_pri_hvt_lastloc_30", "dx_vom_pri_hvt_lastloc_40"];
      break;
    case "pool":
      var2 = ["dx_vom_pri_hvt_lastloc_50", "dx_vom_pri_hvt_lastloc_60"];
      break;
  }

  scripts\sp\maps\estate\estate_util::make_alias_group("overwatch_hvt_final_" + var1.location, var2);
  var1 endon("identified");
  GscBinSkip4(0x35, var1);
}

function waittill_interrogation_dialogue_or_timeout() {
  self endon("single dialogue");
  self.interrogator endon("single dialogue");
  wait 4;
}

function overwatch_hvt_sight_callout_think(var0) {
  var0 endon("interact");
  var1 = 0;
  var2 = 0;
  var3 = level.hvt_trace_contents;
  jumpiffalse(var0.location == "courtyard") LOC_00000034;
  var3 += physics_createcontents(["physicscontents_foliage"]);

  for(;;) {
    if(var2 <= var1) {
      var2 = 0;
    }

    var1 = var2;
    waitframe();
    var4 = self.origin;
    var5 = var0.origin;

    if(distancesquared(var4, var5) > squared(1000)) {
      continue;
    }

    if(distancesquared(var4, var5) > squared(64)) {
      var4 = self getEye();
      var5 += (0, 0, 50);

      if(!scripts\engine\utility::within_fov(var4, self getgunangles(), var5, 0.77)) {
        continue;
      }

      var6 = [level.player];

      if(isDefined(var0.chair)) {
        GscBinSkip0(0x2e, var6.size, var0.chair);
      }

      if(!scripts\engine\trace::ray_trace_passed(var4, var5, var6, var3)) {
        continue;
      }

      var2++;

      if(var2 < 20) {
        continue;
      }
    }

    var0 notify("seen");
    level.hvts_seen++;

    switch (var0.location) {
      case "church":
        var0.animnode.description = &"ESTATE/OBJ_DESC_CHURCH_HVT";
        break;
      case "courtyard":
        var0.animnode.description = &"ESTATE/OBJ_DESC_COURTYARD_HVT";
        break;
      case "pool":
        var0.animnode.description = &"ESTATE/OBJ_DESC_POOL_HVT";
        break;
    }

    scripts\engine\sp\objectives::objective_set_description("estate", var0.animnode.description);

    if(isDefined(level.overwatch_requests["objective"])) {
      level waittillmatch("overwatch_vo_completed", "objective");
    }

    var7 = undefined;
    var8 = undefined;

    switch (level.hvts_seen) {
      case 1:
        if(scripts\engine\utility::flag("player_in_combat")) {
          var7 = "dx_vom_kyle_pool_approach1_60";
          var8 = "dx_vom_pri_pool_approach1_90";
        } else {
          var7 = "dx_vom_kyle_pool_approach1_50";
          var8 = "dx_vom_pri_pool_approach1_100";
        }

        break;
      case 2:
        if(scripts\engine\utility::flag("player_in_combat")) {
          var7 = "dx_vom_kyle_hvt_approach2_20";
          var8 = "dx_vom_pri_hvt_approach2_40";
        } else {
          var7 = "dx_vom_kyle_hvt_approach2_10";
          var8 = "dx_vom_pri_hvt_approach2_30";
        }

        break;
      case 3:
        if(scripts\engine\utility::flag("player_in_combat")) {
          var7 = "dx_vom_kyle_hvt_approach3_20";
          var8 = "dx_vom_pri_hvt_approach3_40";
        } else {
          var7 = "dx_vom_kyle_hvt_approach3_10";
          var8 = "dx_vom_pri_hvt_approach3_30";
        }

        break;
    }

    var9 = request_overwatch_vo("objective", var8, 1, 1, "hvt_seen", undefined, "identify_anim_started");

    if(istrue(var9)) {
      scripts\sp\maps\estate\estate_util::kyle_line(var7);
      level notify("hvt_seen");
    }

    return;
  }
}

function overwatch_hvt_nag_think(var0) {
  if(scripts\engine\utility::flag("did_hvt_nag")) {
    return;
  }

  level endon("did_hvt_nag");
  var0 waittill("seen");

  if(isalive(var0.interrogator)) {
    var0.interrogator waittill("death");
  }

  wait 20;

  for(;;) {
    wait 2;

    if(scripts\engine\utility::flag("player_in_combat")) {
      continue;
    }

    if(!level.player istouching(level.interior_volumes[var0.location])) {
      continue;
    }

    if(istrue(var0.identify_anim_playing)) {
      while(istrue(var0.identify_anim_playing)) {
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
  var0 = gettime();
  var1 = [];

  foreach(var3 in level.landmarks) {
    if(!scripts\engine\utility::is_equal(var3.location, "mansion")) {
      var1 = var3.volume;
    }
  }

  var5 = 0;
  scripts\sp\maps\estate\estate_util::make_alias_group("obj_nags", ["dx_vom_pri_hvt_allnag_10", "dx_vom_pri_hvt_allnag_20", "dx_vom_pri_hvt_allnag_30", "dx_vom_pri_hvt_allnag_40"]);

  for(;;) {
    if(scripts\engine\utility::flag("player_in_combat")) {
      scripts\engine\utility::flag_waitopen("player_in_combat");
      wait 15;
      continue;
    }

    waitframe();

    if(level.hvts_identified > var5) {
      foreach(var8, var7 in var1) {
        if(!scripts\engine\utility::array_contains(level.hvt_locations, var8)) {
          while(level.player istouching(var7)) {
            waitframe();
          }

          level notify("player_left_" + var8);
          var1 = scripts\engine\utility::array_remove_key(var1, var8);
          var0 = gettime();
        }
      }

      scripts\sp\maps\estate\estate_util::clear_alias_group("obj_nags");
      var9 = [];

      if(level.hvt_locations.size > 1) {
        if(!scripts\engine\utility::array_contains(level.hvt_locations, "church")) {
          var9 = ["dx_vom_pri_hvt_pcnag_20", "dx_vom_pri_hvt_pcnag_30", "dx_vom_pri_hvt_pcnag_40", "dx_vom_pri_hvt_pcnag_50"];
        } else if(!scripts\engine\utility::array_contains(level.hvt_locations, "courtyard")) {
          var9 = ["dx_vom_pri_hvt_cpnag_10", "dx_vom_pri_hvt_cpnag_20", "dx_vom_pri_hvt_cpnag_30", "dx_vom_pri_hvt_cpnag_50"];
        } else {
          var9 = ["dx_vom_pri_hvt_ccnag_10", "dx_vom_pri_hvt_ccnag_20", "dx_vom_pri_hvt_ccnag_30", "dx_vom_pri_hvt_ccnag_50"];
        }
      } else {
        switch (level.hvt_locations[0]) {
          case "church":
            var9 = ["dx_vom_pri_hvt_churchnag_10", "dx_vom_pri_hvt_churchnag_20", "dx_vom_pri_hvt_churchnag_30", "dx_vom_pri_hvt_churchnag_40"];
            break;
          case "courtyard":
            var9 = ["dx_vom_pri_hvt_courtnag_10", "dx_vom_pri_hvt_courtnag_20", "dx_vom_pri_hvt_courtnag_30", "dx_vom_pri_hvt_courtnag_50"];
            break;
          case "pool":
            var9 = ["dx_vom_pri_hvt_poolnag_10", "dx_vom_pri_hvt_poolnag_20", "dx_vom_pri_hvt_poolnag_30", "dx_vom_pri_hvt_poolnag_40"];
            break;
        }
      }

      scripts\sp\maps\estate\estate_util::make_alias_group("obj_nags", var9);
      var5 = level.hvts_identified;
    }

    if(!level.player scripts\engine\sp\utility::is_touching_any(var1)) {
      if(!scripts\engine\utility::time_has_passed(var0, 60)) {
        continue;
      }

      if(!request_overwatch_vo("hvt", scripts\sp\maps\estate\estate_util::get_next_alias_in_group("obj_nags", 1))) {
        continue;
      }

      scripts\sp\maps\estate\estate_util::increment_alias_group_index("obj_nags");
    }

    var0 = gettime();
  }
}

function overwatch_fusebox_callout_think() {
  var0 = 0;
  var1 = level.landmarks;
  var2 = level.fuseboxes;

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

    if(!var0) {
      var3 = scripts\engine\utility::getclosest(self.origin, var1);

      if(!scripts\engine\utility::array_contains(level.hvt_locations, var3.location)) {
        var1 = scripts\engine\utility::array_remove(var1, var3);
        continue;
      }

      if(!var3.fusebox.script_light_switch_state) {
        continue;
      }

      if(distance2dsquared(var3.origin, self.origin) > squared(1000)) {
        continue;
      }

      if(request_overwatch_vo("fusebox", "dx_vom_pri_hint_fuse_10")) {
        var0 = 1;
      }

      continue;
    }

    if(var2.size == 0) {
      return;
    }

    var4 = scripts\engine\utility::getclosest(self.origin, var2);

    if(!var4.script_light_switch_state || isDefined(var4.location) && !scripts\engine\utility::array_contains(level.hvt_locations, var4.location)) {
      var2 = scripts\engine\utility::array_remove(var2, var4);
      continue;
    }

    if(self.origin[2] > var4.origin[2]) {
      continue;
    }

    var5 = distance2dsquared(var4.origin, self.origin);

    if(var5 > squared(500)) {
      continue;
    }

    var6 = self getEye();

    if(!sighttracepassed(var6, var4.origin, 0, self)) {
      continue;
    }

    var7 = undefined;

    if(scripts\engine\utility::within_fov(var6, self getgunangles(), var4.origin, 0.8) || var5 < 16384) {
      var7 = "dx_vom_pri_infil_fuse_10";
    } else {
      var8 = scripts\anim\battlechatter::getdirectioncompass(self.origin, var4.origin);

      switch (var8) {
        case "north":
          var7 = "dx_vom_pri_fusebox_hints_10";
          break;
        case "south":
          var7 = "dx_vom_pri_fusebox_hints_40";
          break;
        case "east":
          var7 = "dx_vom_pri_fusebox_hints_30";
          break;
        case "west":
          var7 = "dx_vom_pri_fusebox_hints_20";
          break;
      }
    }

    if(!isDefined(var7)) {
      continue;
    }

    if(request_overwatch_vo("fusebox", var7)) {
      wait 30;
    }
  }
}

function overwatch_door_locked_think(var0) {
  var0 endon("first_interact");
  var0 endon("ai_opened");
  var0 endon("bashed");

  for(;;) {
    scripts\engine\utility::flag_waitopen("player_in_combat");
    var0 waittill("trigger");

    if(isDefined(var0.doubledoors) && var0 != var0.doubledoors[0]) {
      return;
    }

    if(scripts\engine\utility::flag("player_in_combat")) {
      continue;
    }

    if(!var0.locked) {
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
  var0 = scripts\sp\utility::make_weapon("iw8_ar_falima_notracer", ["silencer_west01"]);
  var1 = scripts\engine\utility::getStructArray("overwatch_struct", "targetname");
  var2 = level.dynolights;

  for(;;) {
    waitframe();

    if(getdvarint("scr_est_priceDontSnipe")) {
      continue;
    }

    if(!scripts\engine\utility::flag("player_has_overwatch")) {
      continue;
    }

    scripts\sp\maps\estate\estate_util::waittill_player_stops_rotating();
    var3 = getaiarray("axis");
    var4 = sortbydistance(var3, self.origin);
    var5 = undefined;

    foreach(var20, var7 in var4) {
      var8 = undefined;

      if(!isalive(var7)) {
        continue;
      }

      if(var7 scripts\engine\utility::doinglongdeath()) {
        continue;
      }

      if(distancesquared(var7.origin, self.origin) > 640000) {
        break;
      }

      if(isDefined(var7.next_snipe_try_time) && gettime() < var7.next_snipe_try_time) {
        continue;
      }

      var7.next_snipe_try_time = gettime() + 2000;

      if(scripts\engine\utility::is_equal(var7.script_stealthgroup, "technical")) {
        continue;
      }

      if(scripts\engine\utility::is_equal(var7.script, "pain")) {
        continue;
      }

      var8 = var7 getapproxeyepos();

      if(!scripts\engine\math::point_in_fov(var8, 0.8)) {
        continue;
      }

      if(!var7 hastacvis(self)) {
        continue;
      }

      var9 = 0;

      foreach(var12, var11 in level.interior_volumes) {
        if(ispointinvolume(var7.origin, var11)) {
          var9 = 1;
          break;
        }
      }

      if(var9) {
        break;
      }

      if(scripts\engine\sp\utility::isads() && scripts\engine\math::point_in_fov(var8, 0.99)) {
        continue;
      }

      if(scripts\engine\utility::is_equal(level.player.context_melee_victim, var7)) {
        continue;
      }

      if(distancesquared(level.player.origin, var7.origin) < squared(150)) {
        var13 = vectorNormalize(level.player.origin - var7.origin);
        var14 = anglesToForward(var7.angles);

        if(vectordot(var13, var14) <= -0.5) {
          continue;
        }
      }

      if(!scripts\engine\utility::flag("player_in_combat")) {
        var3 = getaiarray("axis");
        var15 = 0;

        foreach(var19, var17 in sortbydistance(var3, var7.origin)) {
          if(var17 == var7) {
            continue;
          }

          var18 = distancesquared(var17.origin, var7.origin);

          if(var18 > 562500) {
            break;
          }

          if(var18 <= 105625) {
            var15 = 1;
            break;
          }

          if(var17 hastacvis(var7)) {
            var15 = 1;
            break;
          }
        }

        if(var15) {
          continue;
        }
      }

      waitframe();

      if(!scripts\engine\trace::ray_trace_passed(self getEye(), var8, [self, var7])) {
        continue;
      }

      var5 = var7;
      break;
    }

    if(!isDefined(var5) && var2.size > 0 && !scripts\engine\utility::flag("player_in_combat")) {
      var4 = sortbydistance(var2, self.origin);

      foreach(var7 in var4) {
        if(distancesquared(var7.origin, self.origin) > 640000) {
          break;
        }

        if(var7.model == "dynlt_fusebox_light_01_on" || var7.model == "dynlt_fusebox_light_led_01_on") {
          var2 = scripts\engine\utility::array_remove(var2, var7);
          continue;
        }

        if(scripts\engine\sp\utility::isads()) {
          continue;
        }

        if(var7 getscriptablepartstate("onoff") != "on") {
          var2 = scripts\engine\utility::array_remove(var2, var7);
          continue;
        }

        var9 = 0;

        foreach(var11 in level.interior_volumes) {
          if(ispointinvolume(var7.origin, var11)) {
            var9 = 1;
            break;
          }
        }

        if(var9) {
          var2 = scripts\engine\utility::array_remove(var2, var7);
          break;
        }

        var8 = var7.lightpos;

        if(!scripts\engine\math::point_in_fov(var8, 0.8)) {
          continue;
        }

        var3 = getaiarray("axis");
        var24 = sortbydistance(var3, var8)[0];

        if(isDefined(var24)) {
          var18 = distancesquared(var24.origin, var8);

          if(var18 < 202500) {
            continue;
          }

          if(var18 < 722500) {
            if(var24 hastacvis(var8, 0)) {
              continue;
            }

            waitframe();

            if(sighttracepassed(var24 getapproxeyepos(), var8, 0, var7)) {
              continue;
            }
          }
        }

        waitframe();

        if(!scripts\engine\trace::ray_trace_passed(self getEye(), var8, [self, var7])) {
          continue;
        }

        var5 = var7;
        break;
      }
    }

    if(!isDefined(var5)) {
      continue;
    }

    var26 = 0;
    var8 = undefined;

    while(var26 < 3) {
      waitframe();

      if(!isDefined(var5)) {
        break;
      }

      if(isai(var5)) {
        if(!isalive(var5)) {
          break;
        }

        if(var5 scripts\engine\utility::doinglongdeath()) {
          break;
        }

        if(scripts\engine\utility::is_equal(var5.script, "pain")) {
          break;
        }

        var9 = 0;

        foreach(var11 in level.interior_volumes) {
          if(ispointinvolume(var5.origin, var11)) {
            var9 = 1;
            break;
          }
        }

        if(var9) {
          break;
        }

        var6 = var3 getapproxeyepos();

        if(!scripts\engine\math::point_in_fov(var6, 0.8)) {
          break;
        }

        if(scripts\engine\sp\utility::isads() && scripts\engine\math::point_in_fov(var4, 0.99)) {
          break;
        }

        if(scripts\engine\utility::is_equal(level.player.context_melee_victim, < error > )) {
          break;
        }

        if(distancesquared(level.player.origin, < error > .origin) < squared(200)) {
          var5 = vectorNormalize(level.player.origin - < error > .origin);
          var6 = anglesToForward( < error > .angles);

          if(vectordot(var5, var6) <= -0.5) {
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

      var11++;
    }

    if(var11 < 3) {
      continue;
    }

    var12 = undefined;
    var13 = sortbydistance( < error > , < error > );

    foreach(var16, var15 in var13) {
      waitframe();

      if(isai( < error > )) {
        <
        error > = < error > getEye() + < error > .velocity;
      }

      if(scripts\engine\trace::ray_trace_passed(var15.origin, < error > , [ < error > ])) {
        var12 = var15.origin;
        break;
      }
    }

    if(!isDefined(var12)) {
      if(!isai( < error > )) {
        <
        error > = scripts\engine\utility::array_remove( < error > , < error > );
      }

      continue;
    }

    if(isai( < error > )) {
      var17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_ai", 1);
    } else {
      var17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_light", 1);
    }

    var18 = undefined;

    if(!isai( < error > )) {
      var18 = "price_shot_light";
    }

    var19 = request_overwatch_vo("sniper_assist", var17, 0, 0, var18);

    if(!var19) {
      continue;
    }

    level.sniper_assist_target = < error > ;

    if(isai( < error > )) {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index("price_snipe_ai");
      level waittill("overwatch_vo_completed", var20);
      var26 = 0;

      if(!isDefined( < error > )) {
        var26 = 1;
      } else if(!isalive( < error > )) {
        var26 = 1;
      } else if(istrue(level.player.in_melee_death) && scripts\engine\utility::is_equal(level.player.context_melee_victim, < error > )) {
        var26 = 1;
      }

      if(var26) {
        if(!isDefined(level.current_overwatch_vo)) {
          var17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_nevermind");
          thread request_overwatch_vo("sniper_followup", var17, 1);
        }

        level.sniper_assist_target = undefined;
        continue;
      }

      <
      error > notify("sniped");
      var39 = < error > getEye();
      thread snipe_whiz_sfx(var12, var39);
      magicbullet( < error > , var12, var39);
      waitframe();

      if(isalive( < error > )) {
        <
        error > kill(var12);
      }
    } else {
      scripts\sp\maps\estate\estate_util::increment_alias_group_index("price_snipe_light");
      thread snipe_whiz_sfx(var12, < error > .lightpos);
      magicbullet( < error > , var12, < error > .lightpos);
      waitframe();

      if( < error > getscriptablepartstate("onoff") != "death") {
        <
        error > scripts\sp\utility::do_damage(100, var12);
      }

      wait 0.75;
      level notify(var18);
    }

    level.sniper_assist_target = undefined;

    if(isai( < error > )) {
      wait 1.5;

      if(!isDefined(level.current_overwatch_vo)) {
        var17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_followup");

        if(var17 == "dx_vom_pri_estate_stealth_29" && scripts\engine\utility::flag("stealth_spotted")) {
          var17 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("price_snipe_followup");
        }

        thread request_overwatch_vo("sniper_followup", var17, 1);
      }
    }

    wait 15;
  }
}

function snipe_whiz_sfx(var0, var1) {
  var2 = spawn("script_origin", var1);
  waitframe();
  var3 = "_far";
  var4 = "_med";
  var5 = distance(var0, var1);

  if(var5 < 1900) {
    var3 = "_med";
  }

  var6 = distance(var1, level.player.origin);

  if(var6 < 500) {
    var4 = "_near";
  }

  var7 = "sniper_whiz" + var3 + var4 + "_in";
  var2 playSound(var7);
  wait var5 / 7500;
  var2 stopsounds();
  var2 delete();
}

function spawn_hvt() {
  thread hvt_waypoint_think();
  var0 = scripts\engine\sp\utility::get_spawner_array("interrogator", "script_noteworthy");
  var1 = scripts\engine\utility::getclosest(self.origin, var0);
  var2 = self.script_noteworthy + "_interrogator";
  var1 waittill("spawned", var3);
  var4 = scripts\engine\sp\utility::fakeactorspawn(getspawner(self.target, "targetname"));
  var4.fakeactor_face_anim = 1;
  var4.interrogator = var3;
  var4.location = self.script_noteworthy;
  var4.is_target = 0;
  level.hvts[self.script_noteworthy] = var4;
  var4 detach(var4.headmodel, "");

  switch (self.script_noteworthy) {
    case "pool":
      scripts\sp\maps\estate\estate_util::make_alias_group("pool_playernear", ["dx_vom_hvt_hvt_bag_20", "dx_vom_hvt_hvt_bag_30"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("pool_gunshots", ["dx_vom_hvt_hvt_bag_80", "dx_vom_hvt_hvt_bag_90", "dx_vom_hvt_hvt_bag_110", "dx_vom_hvt_hvt_bag_130"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("pool_yelling", ["dx_vom_hvt_hvt_bag_85", "dx_vom_hvt_hvt_bag_95", "dx_vom_hvt_hvt_bag_100", "dx_vom_hvt_hvt_bag_120", "dx_vom_hvt_hvt_bag_140", "dx_vom_hvt_hvt_bag_150", "dx_vom_hvt_hvt_bag_160", "dx_vom_hvt_hvt_bag_170", "dx_vom_hvt_hvt_bag_180", "dx_vom_hvt_hvt_bag_190"]);
      var4.incorrect_alias = "dx_vom_hvt1_hvt_incorrect_51";
      var4.correct_alias = "dx_vom_hvt_hvt_correct_01";
      var4.ko_alias = "dx_vom_hvt_hvt_ko_10";
      var4.headmodel = "head_sc_m_kamalov_damage";
      break;
    case "courtyard":
      scripts\sp\maps\estate\estate_util::make_alias_group("courtyard_playernear", ["dx_vom_hvt2_hvt_bag_20", "dx_vom_hvt2_hvt_bag_30"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("courtyard_gunshots", ["dx_vom_hvt2_hvt_bag_80", "dx_vom_hvt2_hvt_bag_90", "dx_vom_hvt2_hvt_bag_110", "dx_vom_hvt2_hvt_bag_130"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("courtyard_yelling", ["dx_vom_hvt2_hvt_bag_85", "dx_vom_hvt2_hvt_bag_95", "dx_vom_hvt2_hvt_bag_100", "dx_vom_hvt2_hvt_bag_120", "dx_vom_hvt2_hvt_bag_140", "dx_vom_hvt2_hvt_bag_150", "dx_vom_hvt2_hvt_bag_160", "dx_vom_hvt2_hvt_bag_170", "dx_vom_hvt2_hvt_bag_180", "dx_vom_hvt2_hvt_bag_190"]);
      var4.incorrect_alias = "dx_vom_hvt2_hvt_incorrect_41";
      var4.correct_alias = "dx_vom_hvt2_hvt_correct_01";
      var4.ko_alias = "dx_vom_hvt2_hvt_ko_10";
      var4.headmodel = "head_sc_m_thompson";
      var4 attach("zip_tie_handcuffs_wm", "tag_accessory_right");
      break;
    case "church":
      scripts\sp\maps\estate\estate_util::make_alias_group("church_playernear", ["dx_vom_hvt3_hvt_bag_20", "dx_vom_hvt3_hvt_bag_30"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("church_gunshots", ["dx_vom_hvt3_hvt_bag_80", "dx_vom_hvt3_hvt_bag_90", "dx_vom_hvt3_hvt_bag_110", "dx_vom_hvt3_hvt_bag_130"]);
      scripts\sp\maps\estate\estate_util::make_alias_group("church_yelling", ["dx_vom_hvt3_hvt_bag_85", "dx_vom_hvt3_hvt_bag_95", "dx_vom_hvt3_hvt_bag_100", "dx_vom_hvt3_hvt_bag_120", "dx_vom_hvt3_hvt_bag_140", "dx_vom_hvt3_hvt_bag_150", "dx_vom_hvt3_hvt_bag_160", "dx_vom_hvt3_hvt_bag_170", "dx_vom_hvt3_hvt_bag_180", "dx_vom_hvt3_hvt_bag_190"]);
      var4.incorrect_alias = "dx_vom_hvt3_hvt_incorrect_52";
      var4.correct_alias = "dx_vom_hvt3_hvt_correct_01";
      var4.ko_alias = "dx_vom_hvt3_hvt_ko_10";
      var4.headmodel = "head_sc_m_florian";
      var4 attach("zip_tie_handcuffs_wm", "tag_accessory_right");
      break;
  }

  var4 attach(var4.headmodel, "");
  var4.obstacle_id = createnavobstaclebyent(var4);
  var4.animnode = self;
  scripts\common\anim::addnotetrack_customfunction("hvt", "incorrect", &vo_check_hvt, var4.location + "_interact");
  scripts\common\anim::addnotetrack_customfunction("hvt", "correct", &vo_check_hvt_final, var4.location + "_interact_final");
  thread hvt_interact_think();
  thread hvt_death_pre_interact();
  thread hvt_anim_think();
  thread no_grenades_near_hvt();
  var4.no_friendly_fire_fail = 1;
  thread scripts\sp\friendlyfire::friendly_fire_think(var4);
  var5 = scripts\engine\utility::get_linked_ents()[0];

  if(isDefined(var5)) {
    thread hvt_delete_clip_on_death(var4);
  }

  self notify("hvt_spawned", var4);
}

function hvt_delete_clip_on_death(var0) {
  scripts\engine\utility::waittill_any("dying", "death", "knockout");
  var0 delete();
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

    foreach(var1 in level.hvt_locations) {
      if(var1 != self.location) {
        scripts\engine\sp\objectives::objective_set_state(var1 + "_hvt", "invisible");
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

  foreach(var4 in level.hvt_locations) {
    scripts\engine\sp\objectives::objective_set_state(var4 + "_hvt", "current");
  }

  scripts\engine\sp\objectives::objective_complete(self.location + "_hvt");
  scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_FIND_HVT");
  self.identified = 1;
  self notify("identified");
  scripts\sp\analytics::analytics_fake_start_point("HVT_" + self.location);
}

function vo_check_hvt(var0) {
  var0 playSound(var0.incorrect_alias);
}

function vo_check_hvt_final(var0) {
  var0 playSound(var0.correct_alias);
}

function hvt_waypoint_think() {
  level endon("hvt_found");
  level endon(self.script_noteworthy + "_identified");
  var0 = level.landmarks[self.script_noteworthy].waypoint_volume;

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
    while(!level.player istouching(var0)) {
      waitframe();
    }

    scripts\engine\sp\objectives::objective_set_description("estate", self.description);

    foreach(var2 in level.hvt_locations) {
      scripts\engine\sp\objectives::objective_set_state(var2 + "_hvt", "active");
    }

    while(level.player istouching(var0)) {
      waitframe();
    }

    scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_FIND_HVT");

    foreach(var2 in level.hvt_locations) {
      scripts\engine\sp\objectives::objective_set_state(var2 + "_hvt", "current");
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
      var0 = scripts\engine\utility::waittill_any_return("breakout_end", "resume_interrogation");

      if(var0 == "resume_interrogation") {
        continue;
      }
    }

    hvt_enable_interact();

    for(;;) {
      var0 = scripts\engine\utility::waittill_any_return("trigger", "resume_interrogation");
      self stopsounds();

      if(var0 == "trigger" && level.player isscriptedmeleeactive()) {
        waittillframeend();
        scripts\sp\player\cursor_hint::create_cursor_hint("j_head", undefined, undefined, 45, undefined, 80, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 75);
        continue;
      }

      if(isDefined(level.player.near_hvt)) {
        level.player scripts\common\utility::allow_weapon_pickup(1, "hvt");
        level.player.near_hvt = undefined;
      }

      if(var0 == "resume_interrogation") {
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
    var0 = scripts\engine\utility::waittill_any_return("identified", "interact_interrupted");

    if(var0 == "identified") {
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
  var0 = [self];
  var1 = self.location + "_interrogation";
  var2 = self.location + "_idle";
  level.scr_goaltime["hvt"][var2] = 1;

  if(self.location == "courtyard") {
    foreach(var5, var4 in getEntArray("hvt_chair", "targetname")) {
      if(scripts\engine\utility::is_equal(var4.script_noteworthy, "chair")) {
        self.chair = var4;
        break;
      }
    }

    var6 = self.chair scripts\engine\utility::get_linked_ent();
    var6 linkTo(self.chair, "j_origin_animate");
    self.chair.animname = "chair";
    self.chair scripts\engine\sp\utility::assign_animtree();
    self.chair scripts\engine\sp\utility::assign_model();
    scripts\common\anim::addnotetrack_notify("hvt", "begin_settle", "courtyard_hvt_down", "courtyard_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "end_settle", "courtyard_hvt_up", "courtyard_interrogation");
    GscBinSkip1(0x45, "courtyard_hvt_down", "courtyard_interrogation_getup");
  }

  if(self.location == "church") {
    var8 = "tag_accessory_right";
    var9 = spawn("script_model", self.interrogator gettagorigin(var8));
    var9.angles = self.interrogator gettagangles(var8);
    var9 setModel("ee_electric_cattle_prod_01");
    var9 linkTo(self.interrogator, var8, (0, 0, 0), (0, 0, 0));
    self.interrogator.cattleprod = var9;
    self.interrogator.deathfunction = &delete_cattleprod;
    thread cattleprod_think();
    scripts\common\anim::addnotetrack_notify("hvt", "down_start", "church_hvt_down", "church_interrogation");
    scripts\common\anim::addnotetrack_notify("hvt", "down_end", "church_breakout_end", "church_interrogation");
    var10 = "church_interrogation_getup";
    thread hvt_breakout_think(["church_hvt_down"], "church_breakout_end", var10, var6);
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

  var12 = undefined;

  for(;;) {
    self.interrogating = 1;
    self.animnode thread scripts\common\anim::anim_loop(var4, var5, "stop_loop_hvt");
    self.animnode thread scripts\common\anim::anim_loop_solo(self.interrogator, var5, "stop_loop_interrogator");

    if(self.location == "pool") {
      var12 = createnavobstaclebybounds(self.animnode.origin, (60, 60, 60), self.animnode.angles);
    }

    self.interrogator scripts\engine\utility::waittill_any("stealth_investigate", "stealth_combat", "death");
    self.interrogating = undefined;

    if(isDefined(var12)) {
      destroynavobstacle(var12);
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
      self.animnode thread scripts\common\anim::anim_loop_solo(self, var6, "stop_loop_hvt");

      if(isDefined(self.chair)) {
        self.animnode scripts\common\anim::anim_first_frame_solo(self.chair, var5);
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
      self.animnode thread scripts\sp\anim::anim_reach_and_approach_solo(self.interrogator, var5);
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

function hvt_breakout_think(var0, var1, var2, var3, var4) {
  level endon("obj_scene_started");

  for(;;) {
    var5 = level scripts\engine\utility::waittill_any_in_array_return(var0);
    self.breakout = 1;
    self.breakout_wait = isDefined(var4) && isDefined(var4[var5]);
    var6 = scripts\engine\utility::waittill_any_ents_return(level, var1, self, "stop_interrogation");

    if(var6 == "stop_interrogation") {
      var7 = var2[var5];

      if(self.breakout_wait) {
        level waittill(var1);
        self.animnode notify("stop_loop_hvt");
        scripts\engine\sp\utility::anim_stopanimScripted();
      }

      if(isDefined(self.chair)) {
        self.animnode thread scripts\common\anim::anim_single_solo(self.chair, var7);
      }

      self.animnode scripts\common\anim::anim_single_solo(self, var7);
      self.animnode thread scripts\common\anim::anim_loop_solo(self, var3, "stop_loop_hvt");
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
  var0 = scripts\engine\utility::getfx("vfx_estate_cattleprod_sparks_01");

  while(isalive(self)) {
    scripts\engine\utility::waittill_any_ents(level, "church_cattleprod_start", self, "death");

    if(!isalive(self)) {
      break;
    }

    playFXOnTag(var0, self.cattleprod, "tag_fx_prod");
    self.cattleprod playSound("cattleprod_start");
    self.cattleprod playLoopSound("cattleprod_lp");
    scripts\engine\utility::waittill_any_ents(level, "church_cattleprod_end", self, "stealth_investigate", self, "stealth_combat", self, "death");

    if(isDefined(self.cattleprod)) {
      killfxontag(var0, self.cattleprod, "tag_fx_prod");
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
  var0 = getEnt(self.location + "_hvt_damage_trig", "targetname");
  var1 = 5;
  var2 = [];
  var3 = 500;
  var4 = 0;

  while(!istrue(self.dead)) {
    if(!var4 && istrue(self.is_yelling)) {
      var4 = 1;
      var5 = "start_yelling";
    } else {
      var5 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var1, var0, "trigger", self, "start_yelling", level.player, "weapon_fired");
    }

    if(istrue(self.dead)) {
      return;
    }

    if(var5 == "timeout" || var5 == "start_yelling") {
      if(istrue(self.identify_anim_playing)) {
        continue;
      }

      var6 = 0;

      foreach(var8 in scripts\engine\utility::get_array_of_closest(self.origin, getaiarray("axis"), undefined, undefined, 500)) {
        if(var8[[var8.fnisinstealthcombat]]()) {
          var6 = 1;
          break;
        }
      }

      if(var6) {
        continue;
      }

      if(istrue(self.is_yelling)) {
        scripts\engine\sp\utility::smart_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group(self.location + "_yelling"));
        var10 = scripts\engine\utility::get_array_of_closest(self.origin, getaiarray("axis"), var2, undefined, var3);

        foreach(var8 in var10) {
          if(!var8[[var8.fnisinstealthcombat]]()) {
            var8 aieventlistenerevent("cover_blown", self, self.origin);
          }

          var2 = var8;
        }

        if(var3 < 1500) {
          var3 = min(var3 + 500, 1500);
        }

        var1 = randomfloatrange(0.5, 1.5);
      } else if(distancesquared(level.player.origin, self.origin) > squared(1000)) {
        continue;
      } else if(istrue(self.is_target)) {
        scripts\engine\sp\utility::smart_dialogue(self.correct_alias);
        var1 = randomfloatrange(0, 1);
      } else {
        scripts\engine\sp\utility::smart_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group(self.location + "_playernear"));
        var1 = randomfloatrange(2, 5);
      }

      continue;
    }

    if(var5 == "weapon_fired" && !level.player istouching(var0)) {
      continue;
    }

    self stopsounds();
    waitframe();
    scripts\engine\sp\utility::smart_dialogue(scripts\sp\maps\estate\estate_util::get_next_alias_in_group(self.location + "_gunshots"));
    wait randomfloatrange(0.5, 1.5);

    if(level.hvt_locations.size == 1 && !istrue(self.identified) || getdvarint("greenlight")) {
      var1 = 0.5;
      continue;
    }

    var1 = 5;
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
    self waittill("damage", var0, var1, var0, var2);

    if(self.in_combat) {
      continue;
    }

    self aieventlistenerevent("attack", var1, var2);
  }
}

function resume_interrogation() {
  self.in_combat = 0;
}

function interrogator_stealth_filter(var0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var0)) {
    return true;
  }

  if(var0.type == "combat") {
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
  var0 = self.location + "_idle";
  var1 = self.location + "_interact";

  if(level.hvts_identified == 2) {
    var1 += "_final";
  }

  scripts\sp\utility::context_melee_enable(0);
  self.animnode scripts\sp\player_rig::link_player_to_rig(var1, "crouch", 1, 0.5, 0, 15, 15, 15, 15, 1, undefined, 1);
  thread identify_anim_unlink_player_on_damage(level.player_rig);
  self.animnode notify("stop_loop_hvt");
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.identify_anim_playing = 1;
  self stopsounds();
  scripts\engine\sp\utility::player_dialogue_stop();
  scripts\engine\sp\utility::radio_dialogue_stop();
  self.animnode thread scripts\common\anim::anim_single([self, level.player_rig], var1);
  level.player_rig thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "end_interact");
  var2 = scripts\engine\utility::waittill_any_ents_return(level.player_rig, "end_interact", level, "hvt_interact_interrupted");

  if(var2 == "hvt_interact_interrupted") {
    self notify("interact_interrupted");
    self stopsounds();
    self.identify_anim_playing = undefined;
    scripts\sp\anim_notetrack::mayhem_end(scripts\engine\utility::getanim(var1 + "_mayhem"));
    scripts\engine\sp\utility::anim_stopanimScripted();
    self.animnode thread scripts\common\anim::anim_loop_solo(self, var0, "stop_loop_hvt");
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
  self.animnode thread scripts\common\anim::anim_loop_solo(self, var0, "stop_loop_hvt");

  if(level.hvts_identified == 2) {
    thread hvt_yelling_anim_think();
    return;
  }
}

function vo_identify_hvt() {
  var0 = undefined;
  var1 = undefined;

  if(self.is_target) {
    if(scripts\engine\utility::flag("player_in_combat")) {
      var1 = "dx_vom_kyle_hvt_correct_05";
    } else {
      var1 = "dx_vom_kyle_hvt_correct_04";
    }

    var0 = "dx_vom_pri_hvt_correct_100";
    level.player scripts\sp\maps\estate\estate_util::kyle_line(var1);
    level.player scripts\engine\sp\utility::smart_radio_dialogue(var0);
  } else {
    level notify("objectives_updated");

    if(level.hvts_identified == 1) {
      if(scripts\engine\utility::flag("player_in_combat")) {
        var1 = "dx_vom_kyle_hvt_notfound_171";
      } else {
        var1 = "mansion_kyle_itsnothim";
      }
    } else if(scripts\engine\utility::flag("player_in_combat")) {
      var1 = "dx_vom_kyle_hvt_notfound_191";
    } else {
      var1 = "dx_vom_kyle_hvt_notfound_190";
    }

    thread post_hvt_fadeout();

    if(level.hvts_identified == 1) {
      switch (self.location) {
        case "church":
          var0 = "dx_vom_pri_hvt_incorrect_30";
          break;
        case "courtyard":
          var0 = "dx_vom_pri_hvt_incorrect_10";
          break;
        case "pool":
          var0 = "dx_vom_pri_hvt_incorrect_20";
          break;
      }
    } else {
      switch (get_final_hvt_location()) {
        case "church":
          var0 = "dx_vom_pri_hvt_final_10";
          break;
        case "courtyard":
          var0 = "dx_vom_pri_hvt_final_20";
          break;
        case "pool":
          var0 = "dx_vom_pri_hvt_final_30";
          break;
      }
    }

    var2 = request_overwatch_vo("objective", var0, 1, 1, "identify_hvt_vo");
    level.player scripts\sp\maps\estate\estate_util::kyle_line(var1);

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

function identify_anim_unlink_player_on_damage(var0) {
  level.player endon("identify_anim_complete");
  level.player waittill("damage", var1, var2, var3);
  scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  scripts\sp\utility::context_melee_enable(1);
  earthquake(1, 0.3, level.player.origin, 100);
  level.player playRumbleOnEntity("light_1s");
  var4 = vectorNormalize(var3) * var1 * 2;
  level.player setvelocity(var4);
  level notify("hvt_interact_interrupted");
}

function hvt_death_pre_interact() {
  self endon("identified");
  self setCanDamage(1);
  self.health = 1300;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var5, var5, var5, var6);

    if(var1 != level.player || isDefined(var6) && scripts\engine\utility::is_equal(var6.basename, "flash")) {
      self.health += var0;
      continue;
    }

    if(self.health <= 1000 || issubstr(var4, "MOD_GRENADE")) {
      thread hvt_die(var1, var2, var3, var4);
      scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::random([54, 436, 437]));
      scripts\sp\utility::missionfailedwrapper();
      return;
    }

    playFX(scripts\engine\utility::getfx("flesh_hit"), var3, var2 * -1);
  }
}

function hvt_death_post_interact() {
  level endon("obj_scene_started");
  self.health = 1025;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4);

    if(istrue(self.identify_anim_playing) && var1 != level.player) {
      self.health += var0;
      continue;
    }

    if(var4 == "MOD_MELEE") {
      self.health += var0;

      if(istrue(self.knocked_out)) {
        continue;
      }

      self.is_yelling = undefined;
      self.knocked_out = 1;
      self notify("knockout");
      self stopsounds();
      hvt_death_anim(var2);
      thread hvt_snore_think();
      continue;
    }

    if(self.health <= 1000) {
      thread hvt_die(var1, var2, var3, var4);

      if(var1 == level.player && !istrue(self.is_yelling)) {
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

function hvt_die(var0, var1, var2, var3) {
  if(istrue(self.dead)) {
    return;
  }

  self notify("dying");
  self.dead = 1;
  self stopsounds();

  if(var3 == "MOD_GRENADE_SPLASH" || var3 == "MOD_GRENADE") {
    scripts\asm\soldier\death::dogib();
    self hide();
  } else if(var3 == "MOD_FIRE") {
    self setModel("burntbody_male");
    self detach(self.headmodel, "");
    self playSound("generic_flamedeath_enemy_" + randomint(8) + 1);
    thread scripts\sp\equipment\molotov::molotov_burn_sfx(1);

    if(!istrue(self.breakout) && !istrue(self.interrogating) && !istrue(self.knocked_out)) {
      var4 = self.location + "_yelling";
      self.animnode notify("stop_loop_hvt");
      scripts\engine\sp\utility::anim_stopanimScripted();
      scripts\common\anim::addnotetrack_notify("hvt", "burn_end", "hvt_burn_end", var4);
      self.animnode thread scripts\common\anim::anim_loop_solo(self, var4, "stop_loop_hvt");
      level waittill("hvt_burn_end");
      self setanimrate(scripts\engine\utility::getanim(var4)[0], 0);
      self.animnode notify("stop_loop_hvt");
      scripts\asm\shared\utility::setfacialindexfornonai("none");
    }
  } else {
    playFX(scripts\engine\utility::getfx("flesh_hit"), var2, var1 * -1);
    self playSound("generic_death_enemy_" + randomint(8) + 1);

    if(!istrue(self.knocked_out)) {
      thread hvt_death_anim(var1);
    } else {
      self startragdoll();
    }
  }

  scripts\stealth\event::event_broadcast_axis_by_sight("ally_killed", self, self gettagorigin("tag_eye"), 512, 1);
  self notify("death", var0);
}

function hvt_death_anim(var0) {
  var1 = [self];
  var2 = anglesToForward(self.angles);
  var3 = vectordot(var2, var0);
  var4 = self.location + "_death_";

  if(var3 < 0) {
    var4 += "backward";
  } else {
    var4 += "forward";
  }

  if(isDefined(self.chair) && var3 < 0) {
    var1 = self.chair;
  }

  self.animnode notify("stop_loop_hvt");
  scripts\engine\sp\utility::anim_stopanimScripted();

  if(!istrue(self.knocked_out)) {
    scripts\asm\shared\utility::setfacialindexfornonai("none");
  }

  self scriptmoverdistancefade();
  self.animnode scripts\common\anim::anim_single(var1, var4);
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

function greenlight_fadeout(var0) {
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

function try_spawn_backup(var0, var1) {
  level.player endon("death");
  level endon(var0 + "_lost_player");
  var2 = gettime();

  if(getdvarint("greenlight")) {
    return;
  }

  if(scripts\engine\utility::flag("hvt_found")) {
    return;
  }

  if(!backup_technical_check_passed(var0)) {
    return;
  }

  if(getspawnerarray(var0 + "_backup_spawner").size == 0) {
    return;
  }

  if(scripts\engine\utility::flag(var0 + "_backup_spawned")) {
    return;
  }

  wait 3;
  scripts\engine\utility::flag_wait(var0 + "_under_attack");
  scripts\engine\utility::flag_wait("player_gone_hot");

  if(!scripts\sp\maps\estate\estate_util::anyone_has_known_player_since_time(var2, var1)) {
    while(!scripts\sp\maps\estate\estate_util::anyone_has_known_player_since_time(var2, var1)) {
      waitframe();
    }

    wait 1;
  }

  var3 = get_guys_in_stealthgroups(var1);
  var4 = undefined;

  for(;;) {
    if(scripts\engine\utility::flag("hvt_found")) {
      return;
    }

    if(!backup_technical_check_passed(var0)) {
      return;
    }

    if(!scripts\sp\maps\estate\estate_util::alias_group_exists("backup_" + var0)) {
      var5 = [];

      switch (var0) {
        case "mansion":
          var5 = ["dx_vom_aq1_backup_call_40"];
          break;
        case "church":
          var5 = ["dx_vom_aq1_backup_call_50", "dx_vom_aq2_backup_call_80", "dx_vom_aq3_backup_call_110"];
          break;
        case "courtyard":
          var5 = ["dx_vom_aq1_backup_call_60", "dx_vom_aq2_backup_call_90", "dx_vom_aq3_backup_call_120"];
          break;
        case "pool":
          var5 = ["dx_vom_aq1_backup_call_70", "dx_vom_aq2_backup_call_100", "dx_vom_aq3_backup_call_130"];
          break;
      }

      scripts\sp\maps\estate\estate_util::make_alias_group("backup_" + var0, var5);
    }

    var3 = scripts\engine\utility::array_removedead_or_dying(var3);

    if(!var3.size) {
      return;
    }

    var4 = scripts\engine\utility::getclosest(level.player.origin, var3);
    var6 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("backup_" + var0);
    var7 = gettime();
    var4 thread scripts\engine\sp\utility::smart_dialogue_generic(var6);
    var4 scripts\engine\utility::waittill_any("single dialogue", "death", "start_context_melee");

    if(!isalive(var4) || istrue(level.player.in_melee_death) && scripts\engine\utility::is_equal(level.player.context_melee_victim, var4)) {
      var4 stopsounds();

      if(gettime() - var7 < 1000) {
        wait 5;
        continue;
      }
    }

    break;
  }

  thread spawn_backup(var0, var4);
}

function backup_technical_check_passed(var0) {
  if(isDefined(level.technical)) {
    level.technical.should_intercept = 1;

    if(var0 == "mansion") {
      return false;
    }
  }

  return true;
}

function spawn_backup(var0, var1) {
  level.player endon("death");

  if(!isDefined(level.spawning_backup)) {
    level.spawning_backup = 0;
  }

  level.spawning_backup++;
  scripts\engine\utility::flag_set(var0 + "_backup_spawned");
  level notify("backup_spawned");
  var2 = level.player.origin;
  var3 = undefined;

  switch (var0) {
    case "mansion":
      var3 = "dx_vom_aq2_backup_conf_10";
      break;
    case "church":
      var3 = "dx_vom_aq2_backup_conf_20";
      break;
    case "courtyard":
      var3 = "dx_vom_aq2_backup_conf_30";
      break;
    case "pool":
      var3 = "dx_vom_aq2_backup_conf_40";
      break;
  }

  var4 = scripts\engine\utility::spawn_script_origin();
  var4 linkTo(var1, "tag_eye", (0, 0, 0), (0, 0, 0));
  wait 0.5;
  var4 playSound(var3, var0 + "_backup_confirmed");
  var4 thread scripts\engine\utility::delete_on_notify(var0 + "_backup_confirmed");
  wait 2;
  jumpiffalse(var0 == "mansion") LOC_0000017b;
  thread request_overwatch_vo("backup", "dx_vom_pri_backup_vehicle_10", 1, 1);
  var5 = "mansion_backup_vehicle";

  if(getdvarint("use_physics_techo")) {
    var5 += "_physics";
  }

  var6 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var5);
  waittillframeend();

  foreach(var8 in var6.riders) {
    var8 scripts\engine\utility::delaycall(0.05, &aieventlistenerevent, "combat", level.player, var2);
    thread backup_guy_think();
  }

  goto LOC_000002e4;
}

function get_guys_in_stealthgroups(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var4 = level.stealth.groupdata.groups[var3];

    if(isDefined(var4)) {
      var1 = scripts\engine\utility::array_combine(var1, var4.members);
    }
  }

  var1 = scripts\engine\utility::array_removedead_or_dying(var1);
  return var1;
}

function backup_guy_think() {
  self endon("death");
  var0 = level.stealth.hunt_volumes[self.script_stealthgroup];
  var0 endon("death");

  if(level.player istouching(var0)) {
    self.goalradius = 512;
    self cleargoalvolume();
    self setgoalpos(level.player.origin);
  } else {
    self setgoalvolumeauto(var0);
  }

  self waittill("goal");
  level notify(self.script_stealthgroup + "_arrived", self);
  self setgoalvolumeauto(var0);
}

function ambush_guy_think() {
  self endon("death");
  var0 = level.stealth.hunt_volumes[self.script_stealthgroup];
  var0 endon("death");
  self.goalradius = 32;
  self cleargoalvolume();
  var1 = getnode(self.target, "targetname");
  self setgoalnode(var1);

  while(!self cansee(level.player)) {
    wait 0.1;
  }

  wait 4;
  self setgoalvolumeauto(var0);
}

function fusebox_switchoff_think() {
  level endon("obj_scene_started");
  self waittill("lightswitch_toggle");

  if(istrue(self.destroyed)) {
    return;
  }

  var0 = [];

  foreach(var2 in strtok(self.script_parameters, " ")) {
    var3 = scripts\stealth\group::getgroup(var2);

    if(isDefined(var3)) {
      var0 = scripts\engine\utility::array_combine(var0, var3.members);
    }
  }

  var0 = scripts\engine\utility::array_removeundefined(var0);

  if(!var0.size) {
    return;
  }

  var5 = [];

  foreach(var7 in var0) {
    if(scripts\engine\utility::is_equal(var7.script_noteworthy, "interrogator")) {
      continue;
    }

    if(var7[[var7.fnisinstealthhunt]]() || var7[[var7.fnisinstealthcombat]]()) {
      continue;
    }

    var5 = var7;
  }

  var9 = self.origin + anglesToForward(self.angles) * 64;
  var10 = scripts\sp\maps\estate\estate_util::get_closest_guy_by_path(var9, var5);

  if(!isDefined(var10)) {
    return;
  }

  var9 = getclosestpointonnavmesh(var9, var10);

  if(isDefined(var9)) {
    thread investigate_fusebox(var10, self);
    return;
  }
}

function investigate_fusebox(var0, var1) {
  self endon("death");
  scripts\engine\sp\utility::set_battlechatter(0);
  scripts\stealth\enemy::trigger_cover_blown();
  waitframe();
  self aieventlistenerevent("reset", self, self.origin);
  wait 0.75;
  thread scripts\engine\sp\utility::smart_dialogue_generic("mansion_aq2_lightsout");
  var0.runner = self;
  self.fusebox = var0;
  self.og_goalradius = self.goalradius;
  self.goalradius = 32;
  self.stealth.funcs["event_investigate"] = &fusebox_runner_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &fusebox_runner_stealth_filter;
  self notify("stop_going_to_node");
  scripts\engine\sp\utility::set_goal_pos(var1);

  for(;;) {
    var2 = scripts\engine\utility::waittill_any_return("goal", "stop_turn_on_fusebox", "stealth_combat");

    if(var2 == "goal") {
      if(distance2dsquared(self.origin, var1) > squared(self.goalradius)) {
        continue;
      }

      self.patrol_custom_face_angle = var0.angles[1] - 180;
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

function fusebox_runner_stealth_filter(var0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var0)) {
    return true;
  }

  var1 = ["sight", "grenade danger", "projectile_impact", "bulletwhizby", "explode", "gunshot", "gunshot_teammate"];

  if(self.fusebox.script_light_switch_state || isDefined(var0.typeorig) && scripts\engine\utility::array_contains(var1, var0.typeorig)) {
    self notify("stop_turn_on_fusebox");
    return false;
  }

  if(scripts\engine\utility::is_equal(var0.typeorig, "saw_corpse")) {
    scripts\stealth\corpse::corpse_clear();
  }

  return true;
}

function body_drag_door_scene() {
  level endon("obj_scene_started");
  var0 = scripts\engine\utility::getStruct("body_drag_door_scene", "targetname");
  var1 = getspawner("body_drag_door_actor", "script_noteworthy");
  var1 waittill("spawned", var2);

  if(scripts\engine\utility::flag("player_gone_hot")) {
    return;
  }

  thread vignette_actor_init(var2);
  var3 = var0 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var4 = var0 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var5 = sortbydistance(getEntArray("interactive_door", "script_noteworthy"), var0.origin)[0];
  var5 scripts\sp\door::create_navobstacle();
  var2.animname = "alq1";
  var3.animname = "body1";
  var4.animname = "body2";
  var5.animname = "door";
  var3 scripts\engine\sp\utility::assign_animtree();
  var4 scripts\engine\sp\utility::assign_animtree();
  var5 scripts\engine\sp\utility::assign_animtree();
  var0.actor = var2;
  var0.body1 = var3;
  var0.body2 = var4;
  var0.door = var5;
  scripts\common\anim::addnotetrack_notify("body1", "body_up", "body_drag_door_body1_up", "body_drag_door");
  scripts\common\anim::addnotetrack_notify("body1", "body_down", "body_drag_door_body1_down", "body_drag_door");
  scripts\common\anim::addnotetrack_notify("body2", "body_up", "body_drag_door_body2_up", "body_drag_door");
  scripts\common\anim::addnotetrack_notify("body2", "body_down", "body_drag_door_body2_down", "body_drag_door");
  scripts\common\anim::addnotetrack_flag("door", "door_open", "body_drag_door_open_start", "body_drag_door");
  scripts\common\anim::addnotetrack_flag("door", "door_open_first", "body_drag_door_open_end", "body_drag_door");
  body_drag_door_scene_think(var0);
  level notify("body_drag_door_scene_cleanup");
  var5 scripts\sp\door::clear_navobstacle();

  if(isalive(var2)) {
    vignette_actor_cleanup(var2);
    return;
  }
}

function body_drag_door_scene_think() {
  level endon("obj_scene_started");
  var0 = self.actor;
  var1 = self.body1;
  var2 = self.body2;
  var3 = self.door;
  var4 = 1;

  for(;;) {
    var0.flashlightoverride = 0;
    var0 scripts\sp\utility::enable_flashlight(0);
    thread scripts\common\anim::anim_first_frame_solo(var2, "body_drag_door");

    if(!var4) {
      var0.deathanim = undefined;
      var0.noragdoll = undefined;
      thread scripts\common\anim::anim_single_solo(var0, "body_drag_door_idle_enter");
      thread scripts\common\anim::anim_first_frame_solo(var1, "body_drag_door_idle");
      var0 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "begin_idle");
      var0 scripts\engine\utility::waittill_any("begin_idle", "stealth_investigate", "stealth_combat", "death");

      if(!isalive(var0)) {
        return;
      }

      if(!var0[[var0.fnisinstealthidle]]()) {
        var0 scripts\engine\sp\utility::anim_stopanimScripted();

        if(var0[[var0.fnisinstealthcombat]]()) {
          return;
        }

        var0.flashlightoverride = undefined;
        var5 = try_resume_vignette(var0, "body_drag_door_idle_enter");

        if(istrue(var5) && !var3.bashed && !var3.ajar) {
          continue;
        } else {
          return;
        }
      } else if(var3.bashed || var3.ajar) {
        var0 aieventlistenerevent("cover_blown", level.player, var3.origin);
        thread scripts\common\anim::anim_single_solo(var0, "body_drag_door_react_investigate");
        return;
      }
    }

    var4 = 0;
    var0.deathanim = level.scr_anim["alq1"]["body_drag_door_death"];
    var0.noragdoll = 1;
    thread scripts\common\anim::anim_loop([var0, var1], "body_drag_door_idle");
    scripts\engine\utility::waittill_any_ents(level, "body_drag_door_go", var0, "stealth_investigate", var0, "stealth_combat", var0, "death");
    self notify("stop_loop");
    var1 scripts\engine\sp\utility::anim_stopanimScripted();

    if(!isalive(var0)) {
      thread scripts\common\anim::anim_single_solo(var1, "body_drag_door_death");
      return;
    }

    var0.deathanim = undefined;
    var0.noragdoll = undefined;
    var0 scripts\engine\sp\utility::anim_stopanimScripted();

    if(scripts\engine\utility::flag("body_drag_door_go")) {
      break;
    }

    thread scripts\common\anim::anim_first_frame_solo(var1, "body_drag_door_idle");

    if(var0[[var0.fnisinstealthcombat]]()) {
      thread scripts\common\anim::anim_single_solo(var0, "body_drag_door_react_combat");
      return;
    }

    var0.flashlightoverride = undefined;

    if(var0.should_combat_react) {
      thread scripts\common\anim::anim_single_solo(var0, "body_drag_door_react_combat");
    } else {
      thread scripts\common\anim::anim_single_solo(var0, "body_drag_door_react_investigate");
    }

    var5 = try_resume_vignette(var0, "body_drag_door_idle_enter");

    if(istrue(var5) && !var3.bashed && !var3.ajar) {
      continue;
    }

    return;
  }

  thread body_drag_door_bodies_think();
  thread body_drag_door_door_think();
  thread vo_body_drag_door();
  thread scripts\common\anim::anim_single([var0, var1, var2, var3], "body_drag_door");
  var6 = waittill_anim_finish_or_interrupted(var0);

  if(!isDefined(var6)) {
    if(isDefined(var0)) {
      var0 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(!scripts\engine\utility::flag("body_drag_door_open_start")) {
      var3 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(!isDefined(self.body2_dropped)) {
      if(isDefined(self.current_body)) {
        self.current_body scripts\engine\sp\utility::anim_stopanimScripted();
        self.current_body startragdoll();

        if(self.current_body == var1) {
          thread scripts\common\anim::anim_first_frame_solo(var2, "body_drag_door");
          return;
        }

        return;
      }

      if(isDefined(self.body1_dropped)) {
        thread scripts\common\anim::anim_first_frame_solo(var2, "body_drag_door");
        return;
      }

      thread scripts\common\anim::anim_first_frame([var1, var2], "body_drag_door");
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
  var0 = scripts\engine\utility::getStruct("body_drag_dumpster_scene", "targetname");
  var1 = getspawner("body_drag_dumpster_actor1", "script_noteworthy");
  var1 waittill("spawned", var2);
  var1 = getspawner("body_drag_dumpster_actor2", "script_noteworthy");
  var1 waittill("spawned", var3);

  if(scripts\engine\utility::flag("player_gone_hot")) {
    return;
  }

  var0.actor1 = var2;
  var0.actor2 = var3;
  var0.body1 = var0 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var0.body2 = var0 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var0.actor1.animname = "alq1";
  var0.actor2.animname = "alq2";
  var0.body1.animname = "body1";
  var0.body2.animname = "body2";
  var0.body1 scripts\engine\sp\utility::assign_animtree();
  var0.body2 scripts\engine\sp\utility::assign_animtree();
  thread vo_body_drag_dumpster(var2, var3);
  thread body_drag_dumpster_scene(var0);
}

function body_drag_dumpster_scene(var0) {
  thread vignette_actor_init(var0.actor1);
  thread vignette_actor_init(var0.actor2);
  scripts\common\anim::addnotetrack_notify("body1", "body_up", "body_drag_dumpster_body1_up", "body_drag_dumpster");
  scripts\common\anim::addnotetrack_notify("body1", "body_down", "body_drag_dumpster_body1_down", "body_drag_dumpster");
  scripts\common\anim::addnotetrack_notify("body2", "body_up", "body_drag_dumpster_body2_up", "body_drag_dumpster");
  scripts\common\anim::addnotetrack_notify("body2", "body_down", "body_drag_dumpster_body2_down", "body_drag_dumpster");
  scripts\common\anim::addnotetrack_customfunction("alq1", "stand_up", &dumpster_guy_stand_up, "body_drag_dumpster");
  body_drag_dumpster_scene_think(var0);
  level notify("body_drag_dumpster_scene_cleanup");
  scripts\engine\utility::flag_clear("body_drag_dumpster_go");

  foreach(var2 in [var0.actor1, var0.actor2]) {
    if(isalive(var2)) {
      vignette_actor_cleanup(var2);
    }
  }
}

function dumpster_guy_stand_up(var0) {
  var0.is_standing = 1;
}

function body_drag_dumpster_scene_think() {
  level endon("obj_scene_started");
  var0 = self.actor1;
  var1 = self.actor2;
  var2 = self.body1;
  var3 = self.body2;
  var0.deathanim = level.scr_anim["alq1"]["body_drag_dumpster_death"];
  var0.noragdoll = 1;
  var1.deathanim = level.scr_anim["alq2"]["body_drag_dumpster_death"];
  var1.noragdoll = 1;
  var4 = 0;

  for(;;) {
    thread scripts\common\anim::anim_loop([var0, var1, var2], "body_drag_dumpster_idle");
    thread scripts\common\anim::anim_first_frame_solo(var3, "body_drag_dumpster");
    scripts\engine\utility::waittill_any_ents(level, "body_drag_dumpster_go", var0, "stealth_investigate", var0, "stealth_combat", var0, "death", var1, "stealth_investigate", var1, "stealth_combat", var1, "death");
    self notify("stop_loop");

    if(isDefined(var0)) {
      var0 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(isDefined(var1)) {
      var1 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    var2 scripts\engine\sp\utility::anim_stopanimScripted();

    if(!isalive(var0) || !isalive(var1)) {
      level notify("dumpster_vignette_interupted");

      if(isalive(var0)) {
        if(var0.health < var0.maxhealth) {
          thread scripts\common\anim::anim_single([var0, var2], "body_drag_dumpster_react_pain");
        } else {
          thread scripts\common\anim::anim_single([var0, var2], "body_drag_dumpster_react_combat");
        }
      } else {
        thread scripts\common\anim::anim_single_solo(var2, "body_drag_dumpster_death");
      }

      if(isalive(var1)) {
        if(var1.health < var1.maxhealth) {
          thread scripts\common\anim::anim_single_solo(var1, "body_drag_dumpster_react_pain");
          return;
        }

        thread scripts\common\anim::anim_single_solo(var1, "body_drag_dumpster_react_combat");
      }

      return;
    }

    if(scripts\engine\utility::flag("body_drag_dumpster_go")) {
      break;
    }

    if(var0[[var0.fnisinstealthcombat]]() || var1[[var1.fnisinstealthcombat]]()) {
      var4 = 1;

      if(var0.health < var0.maxhealth) {
        thread scripts\common\anim::anim_single([var0, var2], "body_drag_dumpster_react_pain");
      } else {
        thread scripts\common\anim::anim_single([var0, var2], "body_drag_dumpster_react_combat");
      }

      if(var1.health < var1.maxhealth) {
        thread scripts\common\anim::anim_single_solo(var1, "body_drag_dumpster_react_pain");
      } else {
        thread scripts\common\anim::anim_single_solo(var1, "body_drag_dumpster_react_combat");
      }
    } else {
      var4 = 1;

      if(var0.should_combat_react || var1.should_combat_react) {
        thread scripts\common\anim::anim_single([var0, var1, var2], "body_drag_dumpster_react_combat");
      } else {
        thread scripts\common\anim::anim_single([var0, var1, var2], "body_drag_dumpster_react_investigate");
      }
    }

    if(var4) {
      level notify("dumpster_vignette_interupted");
    }

    return;
  }

  var0.deathanim = undefined;
  var0.noragdoll = undefined;
  var1.deathanim = undefined;
  var1.noragdoll = undefined;
  thread body_drag_dumpster_bodies_think();
  thread scripts\common\anim::anim_single([var0, var1, var2, var3], "body_drag_dumpster");
  var0 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "end_scene");
  scripts\engine\utility::waittill_any_ents(var0, "end_scene", var0, "stealth_investigate", var0, "stealth_combat", var0, "death", var1, "stealth_investigate", var1, "stealth_combat", var1, "death");

  if(vignette_interrupted([var0, var1])) {
    level notify("dumpster_vignette_interupted");

    if(isalive(var0)) {
      var0 scripts\engine\sp\utility::anim_stopanimScripted();

      if(!istrue(var0.is_standing)) {
        if(var0.health < var0.maxhealth) {
          thread scripts\common\anim::anim_single([var0, var2], "body_drag_dumpster_react_pain");
        } else if(var0[[var0.fnisinstealthcombat]]() || var0.should_combat_react) {
          thread scripts\common\anim::anim_single([var0, var2], "body_drag_dumpster_react_combat");
        } else {
          thread scripts\common\anim::anim_single([var0, var2], "body_drag_dumpster_react_investigate");
        }
      }

      var0.is_standing = undefined;
    }

    if(isalive(var1)) {
      var1 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(!isDefined(self.body2_dropped)) {
      if(isDefined(self.current_body)) {
        self.current_body scripts\engine\sp\utility::anim_stopanimScripted();
        self.current_body stopsounds();
        self.current_body startragdoll();

        if(self.current_body == var2) {
          thread scripts\common\anim::anim_first_frame_solo(var3, "body_drag_dumpster");
          return;
        }

        return;
      }

      if(isDefined(self.body1_dropped)) {
        thread scripts\common\anim::anim_first_frame_solo(var3, "body_drag_dumpster");
        return;
      }

      thread scripts\common\anim::anim_first_frame([var2, var3], "body_drag_dumpster");
      return;
    }

    return;
  }
}

function vo_body_drag_dumpster(var0, var1) {
  foreach(var3 in [var0, var1]) {
    var3 endon("death");
    var3 endon("stealth_investigate");
    var3 endon("stealth_combat");
    var3 scripts\engine\sp\utility::set_battlechatter(0);
  }

  thread vo_body_drag_dumpster_interrupt_think(var0, var1);
  level waittill("body_drag_dumpster_go");
  var5 = ["dx_vom_aq3_aqmisc_dumpster_20", "dx_vom_aq3_aqmisc_dumpster_40", "dx_vom_aq3_dumpster_liftcorpse1", "dx_vom_aq3_aqmisc_dumpster_100", "dx_vom_aq3_aqmisc_dumpster_140", "dx_vom_aq3_aqmisc_dumpster_160", "dx_vom_aq3_aqmisc_dumpster_180", "dx_vom_aq3_aqmisc_dumpster_220", "dx_vom_aq3_dumpster_liftcorpse2", "dx_vom_aq3_aqmisc_dumpster_60", "dx_vom_aq3_aqmisc_dumpster_240"];
  var6 = ["dx_vom_aq2_aqmisc_dumpster_10", "dx_vom_aq2_aqmisc_dumpster_30", "dx_vom_aq2_aqmisc_dumpster_70", "dx_vom_aq2_aqmisc_dumpster_90", "dx_vom_aq2_aqmisc_dumpster_110", "dx_vom_aq2_aqmisc_dumpster_130", "dx_vom_aq2_aqmisc_dumpster_150", "dx_vom_aq2_dumpster_dragcorpse", "dx_vom_aq2_aqmisc_dumpster_210", "dx_vom_aq2_aqmisc_dumpster_50", "dx_vom_aq2_dumpster_liftcorpse2", "dx_vom_aq2_dumpster_liftcorpse3", "dx_vom_aq2_aqmisc_dumpster_230"];
  GscBinSkip4(0x6e, var0, var5);
}

function vo_body_drag_dumpster_actor(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    self waittillmatch("single anim", "pool_vo");
    thread scripts\engine\sp\utility::smart_dialogue_generic(var0[var1]);
  }

  level notify(self.animname + "_pool_vo_completed");
}

function vo_body_drag_dumpster_interrupt_think(var0, var1) {
  var2 = scripts\engine\utility::waittill_any_ents_return(level, "pool_vo_completed", var0, "death", var0, "stealth_investigate", var0, "stealth_combat", var1, "death", var1, "stealth_investigate", var1, "stealth_combat");

  if(var2 != "pool_vo_completed") {
    if(isalive(var0)) {
      var0 stopsounds();
    }

    if(isalive(var1)) {
      var1 stopsounds();
    }
  }

  waitframe();

  if(isalive(var0)) {
    var0 scripts\engine\sp\utility::set_battlechatter(1);
  }

  if(isalive(var1)) {
    var1 scripts\engine\sp\utility::set_battlechatter(1);
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

function car_rummage_scene(var0) {
  level endon("obj_scene_started");
  var1 = "car_rummage_" + var0;
  var2 = scripts\engine\utility::getStruct(var1 + "_scene", "targetname");
  var3 = var2 scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var4 = undefined;

  foreach(var6 in getEntArray(var1 + "_car", "targetname")) {
    if(var6.script_noteworthy == "car") {
      var4 = var6;
      break;
    }
  }

  var3 scripts\engine\sp\utility::assign_animtree("body1");
  var4 scripts\engine\sp\utility::assign_animtree("car");
  var2 thread scripts\common\anim::anim_first_frame([var3, var4], var1 + "_intro");
  var8 = getspawner(var1 + "_actor", "script_noteworthy");
  var8 waittill("spawned", var9);
  waittillframeend();

  if(scripts\engine\utility::flag("player_gone_hot")) {
    return;
  }

  thread vignette_actor_init();

  foreach(var11 in var4 scripts\engine\utility::get_linked_ents()) {
    var11 linkTo(var4, "tag_door_front_" + var11.script_noteworthy);

    if(isstartstr(var11.script_noteworthy, var0)) {
      var2.door = var11;
    }
  }

  var9.animname = "alq1";
  var2.actor = var9;
  var2.body1 = var3;
  var2.car = var4;
  scripts\common\anim::addnotetrack_flag("body1", "body_up", var1 + "_body_up", var1 + "_intro");
  car_rummage_scene_think(var2, var1);

  if(isalive(var9)) {
    vignette_actor_cleanup(var9);
    return;
  }
}

function car_rummage_scene_think(var0) {
  level endon("obj_scene_started");
  var1 = self.actor;
  var2 = self.body1;
  var3 = self.car;

  for(;;) {
    if(scripts\engine\utility::flag(var0 + "_go")) {
      break;
    }

    scripts\engine\utility::waittill_any_ents(level, var0 + "_go", var1, "stealth_investigate", var1, "stealth_combat", var1, "death");

    if(!isalive(var1) || var1[[var1.fnisinstealthcombat]]()) {
      return;
    } else if(var1[[var1.fnisinstealthinvestigate]]()) {
      var1 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

      if(!isalive(var1) || !var1[[var1.fnisinstealthidle]]()) {
        return;
      }

      continue;
    }

    break;
  }

  for(;;) {
    thread scripts\sp\anim::anim_reach_solo(var1, var0 + "_intro");
    var1 scripts\engine\utility::waittill_any("anim_reach_complete", "stealth_investigate", "stealth_combat", "death");

    if(isalive(var1) && var1[[var1.fnisinstealthidle]]()) {
      break;
    }

    scripts\sp\anim::anim_reach_cleanup_solo(var1);

    if(!isalive(var1) || var1[[var1.fnisinstealthcombat]]()) {
      return;
    }

    var1 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

    if(!isalive(var1) || var1[[var1.fnisinstealthcombat]]()) {
      return;
    }
  }

  var1[[var1.fnstealthflashlightdetach]]();
  thread scripts\common\anim::anim_single([var1, var2, var3], var0 + "_intro");
  var4 = waittill_anim_finish_or_interrupted(var1);
  self.door disconnectPaths();

  if(!isDefined(var4)) {
    if(isalive(var1)) {
      var1 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    if(scripts\engine\utility::flag(var0 + "_body_up")) {
      var2 startragdoll();
      scripts\engine\utility::flag_clear(var0 + "_body_up");
    } else {
      var2 setanimrate(level.scr_anim["body1"][var0 + "_intro"], 0);
    }

    var3 setanimrate(level.scr_anim["car"][var0 + "_intro"], 0);
    return;
  }

  var1.deathanimmode = "noclip";
  var1.disabledeathorient = 1;
  var1.deathanim = var1 scripts\engine\utility::getanim(var0 + "_death");
  var1.stealth.cantracetoaiignoreents = [var3, self.door, var2];
  var5 = ["dx_vom_aq1_aqmisc_lootcarloop_10", "dx_vom_aq2_aqmisc_lootcarloop_30", "dx_vom_aq3_aqmisc_lootcarloop_20"];
  var1 thread scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(var5));
  thread scripts\common\anim::anim_loop([var1, var2, var3], var0 + "_idle");
  var1 scripts\engine\utility::waittill_any("stealth_investigate", "stealth_combat", "death", "move_for_technical");
  self notify("stop_loop");
  var2 scripts\engine\sp\utility::anim_stopanimScripted();
  var3 scripts\engine\sp\utility::anim_stopanimScripted();

  if(isalive(var1)) {
    var1.deathanim = undefined;
    var1.disabledeathorient = 0;
    var1.deathanimmode = undefined;
    var1.stealth.cantracetoaiignoreents = undefined;
    var1 scripts\engine\sp\utility::anim_stopanimScripted();
    thread scripts\common\anim::anim_single([var1, var2, var3], var0 + "_react");
    var1 setanimrate(var1 scripts\engine\utility::getanim(var0 + "_react"), 2);
    return;
  }

  if(isDefined(var1)) {
    var1 stopsounds();
  }

  thread scripts\common\anim::anim_single([var2, var3], var0 + "_death");
}

function body_poke_scene() {
  level endon("obj_scene_started");
  var0 = self.script_parameters;
  var1 = scripts\sp\maps\estate\estate_util::spawn_dead_body();
  var1.animname = "body1";
  var1 scripts\engine\sp\utility::assign_animtree();
  scripts\common\anim::anim_first_frame_solo(var1, var0);
  var2 = scripts\engine\utility::getStruct(self.target, "targetname");
  var2 waittill("trigger", var3);

  if(isDefined(var3.context_melee_anim)) {
    return;
  }

  thread vignette_actor_init();
  var3.animname = "alq1";
  var3 notify("stop_going_to_node");
  var3.target = var2.targetname;
  self.body = var1;
  self.actor = var3;
  body_poke_scene_think(var0, var2);

  if(isalive(var3)) {
    vignette_actor_cleanup(var3);
    return;
  }
}

function body_poke_scene_think(var0, var1) {
  level endon("obj_scene_started");
  var2 = self.actor;
  var3 = self.body;

  if(isDefined(var1.script_flag_wait)) {
    for(;;) {
      if(scripts\engine\utility::flag(var1.script_flag_wait)) {
        break;
      }

      scripts\engine\utility::waittill_any_ents(level, var1.script_flag_wait, var2, "stealth_investigate", var2, "stealth_combat", var2, "death");

      if(!isalive(var2) || var2[[var2.fnisinstealthcombat]]()) {
        return;
      } else if(var2[[var2.fnisinstealthinvestigate]]()) {
        var2 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

        if(!isalive(var2) || var2[[var2.fnisinstealthcombat]]()) {
          return;
        }

        continue;
      }

      break;
    }
  }

  for(;;) {
    thread scripts\sp\anim::anim_reach_and_approach_solo(var2, var0);
    var2 scripts\engine\utility::waittill_any("anim_reach_complete", "stealth_investigate", "stealth_combat", "death");

    if(isalive(var2) && var2[[var2.fnisinstealthidle]]()) {
      break;
    }

    scripts\sp\anim::anim_reach_cleanup_solo(var2);

    if(!isalive(var2) || var2[[var2.fnisinstealthcombat]]()) {
      return;
    }

    var2 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

    if(!isalive(var2) || var2[[var2.fnisinstealthcombat]]()) {
      return;
    }
  }

  var2[[var2.fnstealthflashlightdetach]]();
  thread scripts\common\anim::anim_single([var2, var3], var0);
  var2 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "scene_end");
  var2 scripts\engine\utility::waittill_any("scene_end", "stealth_investigate", "stealth_combat", "death");

  if(!isalive(var2) || !var2[[var2.fnisinstealthidle]]()) {
    var3 scripts\engine\sp\utility::anim_stopanimScripted();
    var3 startragdoll();

    if(!isalive(var2)) {
      return;
    }

    var2 scripts\engine\sp\utility::anim_stopanimScripted();
    return;
  }

  thread vo_body_poke();

  if(isDefined(var1.target)) {
    var2.target = var1.target;
    return;
  }
}

function vo_body_poke() {
  if(getdvarint("greenlight")) {
    return;
  }

  var0 = self;
  var0 endon("death");
  var0 endon("stealth_investigate");
  var0 endon("stealth_combat");
  var1 = scripts\engine\utility::array_remove(getaiarray("axis"), var0);
  var2 = scripts\engine\utility::getclosest(var0.origin, var1, 120);

  if(isDefined(var2)) {
    var2 endon("death");
    var2 endon("stealth_investigate");
    var2 endon("stealth_combat");
    var2 scripts\engine\sp\utility::set_battlechatter(0);
    var2 scripts\engine\sp\utility::waittillthread("stealth_investigate", &scripts\engine\sp\utility::set_battlechatter, 1);
    var2 scripts\engine\sp\utility::waittillthread("stealth_combat", &scripts\engine\sp\utility::set_battlechatter, 1);
    var3 = randomint(3);

    switch (var3) {
      case 0:
        var2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse_10");
        wait randomfloatrange(0.25, 0.5);
        var0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse_20");
        wait randomfloatrange(0.25, 0.5);
        var2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse_30");
        break;
      case 1:
        var2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse2_10");
        wait randomfloatrange(0.25, 0.5);
        var0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse2_20");
        wait randomfloatrange(0.25, 0.5);
        var2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse2_30");
        wait randomfloatrange(0.25, 0.5);
        var0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse2_40");
        break;
      case 2:
        var0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse3_10");
        wait randomfloatrange(0.25, 0.5);
        var2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse3_20");
        wait randomfloatrange(0.25, 0.5);
        var0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_aqmisc_corpse3_30");
        wait randomfloatrange(0.25, 0.5);
        var2 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_aqmisc_corpse3_40");
        break;
    }

    var2 scripts\engine\sp\utility::set_battlechatter(1);
    return;
  }

  var4 = ["dx_vom_aq1_aqmisc_corpsesolo_10", "dx_vom_aq1_aqmisc_corpsesolo_40", "dx_vom_aq2_aqmisc_corpsesolo_20", "dx_vom_aq3_aqmisc_corpsesolo_30"];
  var0 scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(var4));
}

function setup_search_anims() {
  var0 = scripts\engine\utility::getStructArray("search_animnode", "targetname");
  scripts\engine\utility::array_thread(var0, &search_anim_think);
}

function search_anim_think() {
  level endon("obj_scene_started");
  var0 = "search_" + self.script_noteworthy;
  var1 = scripts\engine\utility::getclosest(self.origin, getEntArray("search_prop", "targetname"), 100);

  if(isDefined(var1)) {
    var1 scripts\engine\sp\utility::assign_animtree(var1.script_animname);

    if(isDefined(level.scr_anim[var1.script_animname][var0 + "_intro"])) {
      thread scripts\common\anim::anim_first_frame_solo(var1, var0 + "_intro");
    } else {
      thread scripts\common\anim::anim_first_frame_solo(var1, var0 + "_loop");
    }
  }

  var2 = scripts\engine\utility::getStruct(self.target, "targetname");
  var2 waittill("trigger", var3);

  if(isDefined(var3.context_melee_anim)) {
    return;
  }

  var3.animname = "alq1";
  thread vignette_actor_init();

  if(isDefined(var1)) {
    var3.animents = [var1];
  }

  var3 notify("stop_going_to_node");
  var3.target = var2.targetname;
  var3 endon("stealth_combat");
  var3 endon("death");

  if(isDefined(var2.script_flag_wait)) {
    patrol_flag_wait(var3, var2.script_flag_wait);
  }

  var3 endon("stealth_investigate");
  var3 scripts\engine\utility::thread_on_notify("stealth_investigate", &scripts\sp\anim::anim_reach_cleanup_solo, var3, undefined, undefined, var3, "anim_reach_complete");
  var3 scripts\engine\utility::thread_on_notify("stealth_combat", &scripts\sp\anim::anim_reach_cleanup_solo, var3, undefined, undefined, var3, "anim_reach_complete");
  scripts\sp\anim::anim_reach_solo(var3, var0 + "_intro");
  var3[[var3.fnstealthflashlightdetach]]();
  scripts\sp\anim::anim_single_with_props(var3, var0 + "_intro");
  var3.noragdoll = 1;
  thread search_anim_react(var3, "stealth_investigate", self);
  thread search_anim_react(var3, "stealth_combat", self);

  if(self.script_noteworthy == "desk") {
    var4 = [var0 + "_death_front", var0 + "_death_back"];
  } else {
    var4 = var1 + "_death";
  }

  thread search_anim_pain_or_death(var4, self, var1 + "_pain");
  thread scripts\sp\anim::anim_loop_with_props(var4, var1 + "_loop");

  if(isDefined(self.script_flag_wait)) {
    scripts\engine\utility::flag_wait(self.script_flag_wait);
  }

  if(isDefined(self.script_wait)) {
    if(self.script_wait < 0) {
      GscBinSkip4(0x6e, var4, 1, var4, var0 + "_react_combat", var0 + "_react_combat", var3);
    }

    wait self.script_wait;
  }

  var4 waittillmatch("looping anim", "end");
  self notify("stop_search_anim_loop");
  self notify("stop_loop");
  var4 scripts\engine\sp\utility::anim_stopanimScripted();

  if(isDefined(var2)) {
    var2 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var4.noragdoll = undefined;
  GscBinSkip4(0x6e, var4, var4, var0 + "_react_combat", var0 + "_react_combat", var3);
}

function search_anim_react(var0, var1, var2) {
  var1 endon("stop_search_anim_loop");
  self waittill(var0);
  var1 notify("stop_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();

  foreach(var4 in self.animents) {
    var4 setanimrate(level.scr_anim[var4.animname]["search_" + var1.script_noteworthy + "_loop"][0], 0);
  }

  var1 thread scripts\common\anim::anim_single_solo(self, var2);
  vignette_actor_cleanup();
  var1 notify("stop_search_anim_loop");
}

function search_anim_pain_or_death(var0, var1, var2) {
  var0 endon("stop_search_anim_loop");
  self waittill("damage", var3, var3, var4);
  var0 notify("stop_loop");

  if(scripts\engine\utility::is_equal(level.player.context_melee_victim, self)) {
    foreach(var6 in self.animents) {
      var6 setanimrate(level.scr_anim[var6.animname]["search_" + var0.script_noteworthy + "_loop"][0], 0);
    }
  } else if(isalive(self)) {
    scripts\engine\sp\utility::anim_stopanimScripted();
    var0 thread scripts\sp\anim::anim_single_with_props(self, var1);
    vignette_actor_cleanup();
  } else {
    if(isarray(var2)) {
      var8 = anglesToForward(self.angles);
      var9 = vectordot(var8, var4);

      if(var9 < 0) {
        var2 = var2[0];
      } else {
        var2 = var2[1];
      }
    }

    self.deathanim = level.scr_anim[self.animname][var2];
  }

  var0 notify("stop_search_anim_loop");
}

function vo_searching(var0) {
  var1 = ["dx_vom_aq1_goto_obj_aqsearch_10", "dx_vom_aq1_goto_obj_aqsearch_20", "dx_vom_aq1_goto_obj_aqsearch_30", "dx_vom_aq2_goto_obj_aqsearch_40", "dx_vom_aq2_goto_obj_aqsearch_50", "dx_vom_aq3_goto_obj_aqsearch_70", "dx_vom_aq3_goto_obj_aqsearch_80", "dx_vom_aq3_goto_obj_aqsearch_90"];

  if(istrue(var0)) {
    for(var2 = 0;; var2++) {
      wait randomfloatrange(5, 7);
      scripts\engine\sp\utility::smart_dialogue_generic(var1[scripts\sp\maps\estate\estate_util::abs_int(var2 % var1.size)]);
    }

    return;
  }

  scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(var1));
}

function patrol_flag_wait(var0) {
  self endon("stealth_combat");
  self endon("death");
  scripts\engine\utility::flag_wait(var0);

  if(self[[self.fnisinstealthinvestigate]]()) {
    self waittill("stealth_idle");
    return;
  }
}

function vignette_actor_init(var0) {
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
  self.flashlightoverride = var0;
}

function vignette_actor_stealth_filter(var0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var0)) {
    return true;
  }

  var1 = ["unresponsive_teammate", "seek_backup"];

  if(scripts\engine\utility::array_contains(var1, var0.typeorig)) {
    return true;
  }

  self.should_combat_react = 0;

  if(var0.type == "cover_blown" && !scripts\engine\utility::array_contains(["light_killed", "glass_destroyed"], var0.typeorig)) {
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

function try_resume_vignette(var0, var1) {
  var2 = undefined;

  for(;;) {
    var0 scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

    if(!isalive(var0) || var0[[var0.fnisinstealthcombat]]()) {
      break;
    }

    thread scripts\sp\anim::anim_reach_and_approach_solo(var0, var1);
    var0 scripts\engine\utility::waittill_any("anim_reach_complete", "stealth_investigate", "stealth_combat", "death");

    if(isalive(var0) && var0[[var0.fnisinstealthidle]]()) {
      var2 = 1;
      break;
    }

    scripts\sp\anim::anim_reach_cleanup_solo(var0);

    if(!isalive(var0) || var0[[var0.fnisinstealthcombat]]()) {
      break;
    }
  }

  return var2;
}

function vignette_interrupted(var0) {
  foreach(var2 in var0) {
    if(!isalive(var2)) {
      return true;
    }

    if(var2[[var2.fnisinstealthinvestigate]]()) {
      return true;
    }

    if(var2[[var2.fnisinstealthcombat]]()) {
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
  var0 = "technical";

  if(getdvarint("use_physics_decho")) {
    var0 += "_physics";
  }

  level.technical = scripts\common\vehicle::spawn_vehicle_from_targetname(var0);
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
  var1 = 0;

  if(var1) {
    level.technical.mgturret[0] delete();
    waitframe();
    get_gunner(level.technical) delete();
  } else {
    thread technical_gunner_think();
    thread technical_turret_think();
  }

  var2 = getEnt("technical_roof_trig_pointer", "targetname");
  var3 = getEnt(var2.target, "targetname");
  var3 enablelinkTo();
  var3 linkTo(var2);
  var2.origin = level.technical gettagorigin("tag_turret");
  var2.angles = level.technical.angles;
  var2 linkTo(level.technical, "tag_turret");
  thread technical_roof_trig_think(level.technical);
  thread delete_technical_roof_trig(level.technical, var2);
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

function technical_roof_trig_think(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("trigger");
    var1 = gettime();

    while(!scripts\engine\utility::time_has_passed(var1, 0.5) && level.player istouching(var0)) {
      waitframe();
    }

    if(!level.player istouching(var0)) {
      continue;
    }

    var2 = undefined;

    while(level.player istouching(var0)) {
      var3 = level.player getEye();
      var4 = self.gunner getEye();
      var2 = magicgrenade("frag", var4, var3, 1, 0);

      if(isDefined(var2)) {
        break;
      }

      waitframe();
    }

    if(!isDefined(var2)) {
      continue;
    }

    var2 waittill("death");
    earthquake(1, 0.3, level.player.origin, 100);
    level.player playRumbleOnEntity("light_1s");
    var5 = vectorNormalize(level.player.origin - self.origin) * 500;
    level.player setvelocity(var5);
  }
}

function delete_technical_roof_trig(var0, var1) {
  while(!isDefined(self.gunner)) {
    waitframe();
  }

  scripts\engine\utility::waittill_any_ents(self, "death", self.gunner, "death");
  var0 delete();
  var1 delete();
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
    foreach(var1 in level.technical.riders) {
      var1 aieventlistenerevent("ally_killed", level.player, self.origin);
    }
  }

  return grounds_axis_deathfunc();
}

function technical_rider_stealth_filter(var0) {
  if(scripts\sp\maps\estate\estate_util::axis_stealth_filter(var0)) {
    return true;
  }

  if(!isalive(level.technical.gunner)) {
    return false;
  }

  switch (var0.type) {
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

function technical_rider_damage_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(self.ridingvehicle) && var1 != level.player && var4 != "MOD_EXPLOSIVE") {
    self.health += var0;
    return;
  }

  if(self.health <= 20000) {
    self kill(var3, var1, var1, var4);
    return;
  }
}

function technical_rider_combat_think() {
  self endon("death");

  for(;;) {
    var0 = undefined;

    while(self[[self.fnisinstealthcombat]]()) {
      if(gettime() - self lastknowntime(level.player) < 10000) {
        var1 = self lastknownpos(level.player);

        if(!scripts\engine\utility::is_equal(var1, var0)) {
          self.goalradius = 512;
          self setgoalpos(var1);
          var0 = var1;
        }
      }

      waitframe();
    }

    waitframe();
  }
}

function technical_rider_unload(var0) {
  self.deathfunction = &grounds_axis_deathfunc;
  self.noragdoll = undefined;
  self.noflashlight = 0;
  scripts\sp\nvg\nvg_ai::flashlight_on(1);
  self.stealth.funcs["event_investigate"] = undefined;
  self.stealth.funcs["event_cover_blown"] = undefined;
  self.stealth.funcs["event_combat"] = undefined;
  self.damage_functions = scripts\engine\utility::array_remove(self.damage_functions, &technical_rider_damage_func);
  self.health -= 20000;

  if(isDefined(var0)) {
    self aieventlistenerevent(var0.type, var0.ent, var0.origin);
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

function technical_damage_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1) && isai(var1)) {
    return;
  }

  var10 = 0;

  if(isexplosivedamagemod(var4)) {
    var10 = 0.5;
  } else if(var4 == "MOD_RIFLE_BULLET" || var4 == "MOD_PISTOL_BULLET") {
    var10 = 0.025;
  }

  self.actualhealth -= int(level.max_technical_health * var10);

  if(self.actualhealth <= 0) {
    if(isDefined(self.spotlight)) {
      self.spotlight.tag delete();
      self.spotlight delete();
    }

    thread technical_turret_death();
    self.godmode = 0;
    self notify("death", var1, var4, var9, var3);
    return;
  }

  foreach(var12 in self.riders) {
    var12 aieventlistenerevent("attack", var1, var3);
  }
}

function technical_turret_death() {
  if(isalive(self.gunner)) {
    self.gunner delete();
  }

  var0 = self.mgturret[0].angles - self gettagangles("tag_turret");
  self.mgturret[0] delete();
  waitframe();
  self.turret_dst = spawn("script_model", self gettagorigin("tag_turret_dst"));
  self.turret_dst setModel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue_dst");
  self.turret_dst linkTo(self, "tag_turret_dst", (0, 0, 0), var0);
}

function technical_path_think() {
  self endon("death");
  self endon("gunner_defeated");
  level endon("obj_scene_started");
  self.dontunloadonend = 1;
  var0 = getvehiclenodearray("technical_path_start", "targetname");
  var1 = scripts\engine\sp\utility::getfarthest(level.player.origin, var0);
  scripts\common\vehicle::attach_vehicle_and_gopath(var1);
  var2 = undefined;
  self.should_intercept = 1;
  self.current_speed = 0;
  self.current_lookahead = 0;
  self.speed_scale = 1;
  var3 = 0;

  for(;;) {
    waitframe();
    var4 = distance2dsquared(self.origin, level.player.origin);

    if(var4 <= squared(500) && !level.player scripts\engine\utility::ent_flag("indoors")) {
      self.should_intercept = 0;
    }

    if(self.stopped_for_allies || istrue(self.unloading_passengers)) {
      continue;
    }

    if(isalive(self.gunner) && !self.combating && !self.is_ramming) {
      if(var4 <= squared(1000)) {
        if(!var3) {
          update_technical_speed_scale(0.6, 1, 1);
          var3 = 1;
        }
      } else if(var3) {
        var3 = 0;

        if(isalive(self.gunner)) {
          update_technical_speed_scale(1, 1, 1);
        }
      }
    }

    if(!scripts\engine\utility::is_equal(var2, self.currentnode)) {
      var2 = self.currentnode;
      self notify("new_node");
      var5 = getvehiclenode(var2.target, "targetname");
      self.next_node = var5;
      scale_speed(var5);

      if(isDefined(var5.target)) {
        continue;
      }

      var6 = var5 scripts\engine\sp\utility::get_linked_vehicle_nodes();
      var7 = get_best_node_at_fork(var6);
      scripts\common\vehicle::vehicle_switch_paths(var5, var7);
      self.next_node = var7;
      scale_speed(var7);
      self.should_intercept = 1;
    }
  }
}

function get_best_node_at_fork(var0) {
  var1 = undefined;
  var2 = -1;
  var3 = self.should_intercept || self.combating || self.is_ramming;

  if(!var3) {
    var2 = 1;
  }

  foreach(var5 in var0) {
    var6 = (0, float(var5.script_wtf), 0);
    var7 = scripts\engine\math::get_dot(var5.origin, var6, level.player.origin);

    if(var3) {
      if(var7 > var2) {
        var2 = var7;
        var1 = var5;
      }

      continue;
    }

    if(var7 < var2) {
      var2 = var7;
      var1 = var5;
    }
  }

  return var1;
}

function scale_speed(var0) {
  var1 = get_mph_speed(var0);

  if(!scripts\engine\utility::is_equal(self.current_speed, var1)) {
    self.current_speed = var1;

    if(!is_technical_stopped()) {
      self vehicle_setspeed(self.current_speed * self.speed_scale, 15, 15);
      return;
    }

    return;
  }
}

function get_mph_speed(var0) {
  return var0.speed * 3600 / 63360;
}

function update_technical_speed_scale(var0, var1, var2) {
  if(self.speed_scale == var0) {
    return;
  }

  self.speed_scale = var0;
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 15);
  var2 = scripts\engine\utility::ter_op(isDefined(var2), var2, 15);

  if(!is_technical_stopped()) {
    self vehicle_setspeed(self.current_speed * self.speed_scale, var1, var2);
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

  var0 = scripts\engine\trace::create_contents(1, 1, 1, 0, 0, 1, 1, 1);

  for(;;) {
    if(!isDefined(self.driver)) {
      return;
    }

    for(var1 = 0; var1 < 20; var1++) {
      waitframe();
      var2 = distance2dsquared(self.origin, level.player.origin);

      if(var2 > squared(2000)) {
        break;
      }

      var3 = anglesToForward(level.player.angles);
      var4 = vectorNormalize(self.origin - level.player.origin);
      var5 = vectordot(var3, var4);

      if(var5 < 0.77) {
        break;
      }

      var6 = scripts\engine\utility::array_combine([self, level.player], self.riders);

      if(!scripts\engine\trace::ray_trace_passed(level.player getEye(), self.origin + (0, 0, 50), var6, var0)) {
        break;
      }
    }

    if(var1 >= 20) {
      if(request_overwatch_vo("technical", "dx_vom_pri_tech_reveal_10", 1)) {
        foreach(var8 in self.riders) {
          var8.callout_next = gettime() + level.stealth.noteworthy.callout_debounce_guy;
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
  var0 = self.mgturret[0];
  var0 makeunusable();
  technical_spotlight_on();
  self.gunner.vehicle = self;
  self.gunner scripts\asm\asm_sp::asm_animcustom(&technical_gunner_anim_think, undefined);
  self.gunner waittill("death");

  if(isDefined(var0)) {
    var0 cleartargetentity();
    var0 makeusable();
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
      foreach(var2 in self.stops) {
        resume_technical(var3);
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
  var4 = spawnStruct();
  var4.type = "ally_killed";
  var4.ent = level.player;
  var4.origin = self.origin;
  var5 = scripts\common\vehicle::vehicle_unload("all");

  foreach(var7 in var5) {
    technical_rider_unload(var7, var4);
  }

  scripts\common\vehicle::vehicle_lights_off();
  technical_destroy_badplaces();
}

function get_gunner() {
  foreach(var1 in self.riders) {
    if(var1.vehicle_position == 6) {
      return var1;
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
  var0 = self.vehicle;
  var1 = % reb_com_veh8_decho_turret_aim_5;
  var2 = $reb_com_veh8_decho_turret_idle;
  var3 = % reb_com_veh8_decho_turret_driveidle;
  var4 = % reb_com_veh8_decho_turret_aim_8;
  var5 = % reb_com_veh8_decho_turret_aim_2;
  var6 = % reb_com_veh8_decho_turret_aim_4_add;
  var7 = % reb_com_veh8_decho_turret_aim_6_add;
  var8 = % additive_decho_reb_aim_left;
  var9 = % additive_decho_reb_aim_right;
  self clearanim(scripts\asm\asm::asm_getinnerrootknob(), 0.2);
  self setanimlimited(var6, 1);
  self setanimlimited(var7, 1);
  var10 = var0.mgturret[0];
  self setanim(var1, 1);
  var11 = var3;
  var12 = undefined;
  var13 = undefined;
  self setanimknob(var11, 1);

  for(var14 = 0;; var14 = var17) {
    waitframe();
    var15 = scripts\engine\utility::ter_op(var0 vehicle_getspeed() > 1, var3, var2);

    if(var15 != var11) {
      self setanimknob(var15, 1);
      var11 = var15;
    }

    var16 = var10 getturretcurrentpitch();
    var12 = technical_gunner_set_aim(var16, 25, -25, var12, var5, var4, 0.2);
    var17 = var10 getturretcurrentyaw();
    var18 = (var17 - var14) / 0.05;
    var13 = technical_gunner_set_aim(var18, 40, -40, var13, var8, var9, 0.2);
  }
}

function technical_gunner_set_aim(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var6)) {
    var6 = 0.05;
  }

  if(var0 == 0) {
    if(isDefined(var3)) {
      self setanim(var3, 0, var6);
      return undefined;
    }

    return;
  }

  if(var0 > 0) {
    if(isDefined(var3) && var3 != var4) {
      self setanim(var3, 0, var6);
    }

    var7 = clamp(var0 / var1, 0, 1);
    self setanim(var4, var7, var6);
    return var4;
  }

  if(isDefined(var4) && var4 != var6) {
    self setanim(var4, 0, var7);
  }

  var7 = clamp(var1 / var3, 0, 1);
  self setanim(var6, var7, var7);
  return var6;
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
  var0 = self.mgturret[0];
  var0 setmode("manual");
  var0 setModel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue");
  var0 endon("death");
  var0 settoparc(25);
  var0 setbottomarc(25);
  self.spotlight = spawn("script_model", var0 gettagorigin("tag_aim_animated"));
  self.spotlight setModel("ee_electronics_mg_searchlight");
  self.spotlight linkTo(var0, "tag_aim_animated", (0, 0, 0), (0, 0, 0));
  self.spotlight.tag = scripts\engine\utility::spawn_tag_origin(self.spotlight.origin, self.spotlight.angles);
  self.spotlight.tag linkTo(self.spotlight, "tag_origin", (7.5, -3.5, 2.5), (0, 0, 0));
  self.turret_pointer = scripts\engine\utility::spawn_script_origin(self.origin - 500 * anglesToForward(self.angles));
  var0 settargetentity(self.turret_pointer);
  level.technical_spotlight_targets = scripts\engine\utility::getStructArray("technical_spotlight_target", "targetname");
  var1 = 1;
  scripts\sp\maps\estate\estate_util::make_alias_group("turret_shoot_warning", ["dx_vom_aq4_technical_spotted_10", "dx_vom_aq4_technical_spotted_20", "dx_vom_aq4_technical_spotted_30"]);
  GscBinSkip4(0x35);
}

function update_turret_pointer(var0) {
  var1 = scripts\engine\utility::spawn_script_origin(var0);
  self.mgturret[0] settargetentity(var1);

  if(isDefined(self.turret_pointer)) {
    self.turret_pointer delete();
  }

  self.turret_pointer = var1;
}

function turret_aim_think() {
  self.gunner endon("stealth_hunt");
  self.gunner endon("death");
  var0 = undefined;
  var1 = 0;
  var2 = (0, 0, 0);
  var3 = [self.mgturret[0], self.gunner, level.player];

  for(;;) {
    waitframe();

    if(!scripts\engine\utility::is_equal(self.gunner.enemy, level.player)) {
      continue;
    }

    if(gettime() - self.gunner lastknowntime(level.player) > 10000) {
      continue;
    }

    if(scripts\engine\utility::is_equal(self.gunner lastknownpos(level.player), var0)) {
      continue;
    }

    var0 = self.gunner lastknownpos(level.player);

    if(gettime() > var1) {
      var4 = self.mgturret[0] gettagorigin("tag_aim");
      var5 = level.player getEye() - level.player.origin - (0, 0, 10);

      if(scripts\engine\trace::ray_trace_passed(var4, var0, var3)) {
        var2 = (0, 0, 0);
      } else if(scripts\engine\trace::ray_trace_passed(var4, var0 + var5, var3)) {
        var2 = var5;
      } else if(scripts\engine\trace::ray_trace_passed(var4, var0 + var5 / 2, var3)) {
        var2 = var5 / 2;
      }

      var1 = gettime() + 1000;
    }

    var6 = var0 + var2;

    if(distancesquared(var6, self.origin) < 40000 && !self.mgturret[0] turretcantarget(var6)) {
      var7 = self.origin;
      var8 = scripts\engine\utility::flatten_vector(var6 - var7);
      var6 = var7 + var8 * 500;
    }

    update_turret_pointer(var6);
  }
}

function turret_shoot_think() {
  self notify("stop_turret_shoot_think");
  self endon("stop_turret_shoot_think");
  var0 = self.ownervehicle.gunner;

  while(!gunner_can_shoot_player(var0)) {
    waitframe();
  }

  var0 scripts\engine\sp\utility::smart_dialogue_generic(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("turret_shoot_warning"));

  for(;;) {
    waitframe();

    if(!scripts\engine\utility::is_equal(var0.enemy, level.player)) {
      continue;
    }

    if(gettime() - var0 lastknowntime(level.player) > 10000) {
      continue;
    }

    if(!self turretcantarget(self.ownervehicle.turret_pointer.origin)) {
      continue;
    }

    var1 = self gettagorigin("tag_flash");
    var2 = self gettagangles("tag_flash");
    var3 = var0 lastknownpos(level.player);

    if(!turret_aimed_at_last_known(var1, var2, var3)) {
      continue;
    }

    if(distance2dsquared(self.origin, var3) > squared(3000)) {
      continue;
    }

    var4 = scripts\engine\trace::ray_trace(var1, var1 + anglesToForward(var2) * 3000, self);
    var5 = var4["entity"];

    if(isDefined(var5) && (var5 == self.ownervehicle || scripts\engine\utility::is_equal(var5.team, "axis"))) {
      continue;
    }

    for(var6 = 0; var6 < 20; var6++) {
      self shootturret("tag_flash");
      level notify("technical_hot_event", var0);
      var7 = scripts\engine\utility::get_array_of_closest(var1, getaiarray("axis"), [var0], undefined, 1500);

      foreach(var9 in var7) {
        if(!var9[[var9.fnisinstealthcombat]]()) {
          var9 aieventlistenerevent("gunshot_teammate", self, var1);
        }
      }

      wait 0.1;
    }

    wait 0.5;

    while(!gunner_can_shoot_player(var0)) {
      waitframe();
    }
  }
}

function gunner_can_shoot_player(var0) {
  if(var0 cansee(level.player)) {
    return true;
  }

  var1 = var0 lastknowntime(level.player);

  if(!isDefined(var1)) {
    return false;
  }

  if(gettime() - var1 > 10000) {
    return false;
  }

  var2 = var0 lastknownpos(level.player);

  if(!isDefined(var2)) {
    return false;
  }

  if(!turret_aimed_at_last_known(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), var2)) {
    return false;
  }

  if(distancesquared(var2, level.player.origin) > 16384) {
    return false;
  }

  return true;
}

function turret_aimed_at_last_known(var0, var1, var2) {
  if(scripts\engine\utility::within_fov(var0, var1, var2, 0.7)) {
    return true;
  }

  var3 = level.player getEye() - level.player.origin;

  if(scripts\engine\utility::within_fov(var0, var1, var2 + var3, 0.7)) {
    return true;
  }

  if(scripts\engine\utility::within_fov(var0, var1, var2 + var3 / 2, 0.7)) {
    return true;
  }

  return false;
}

function turret_corpse_monitor() {
  var0 = [];

  for(;;) {
    waitframe();

    if(!isalive(self.gunner)) {
      continue;
    }

    var1 = (gettime() - self.gunner lastknowntime(level.player)) / 1000;
    var0 = scripts\engine\utility::array_removeundefined(var0);
    var2 = getcorpsearray();
    var2 = scripts\engine\utility::array_remove_array(var2, var0);

    foreach(var4 in var2) {
      if(!istrue(var4.found)) {
        var0 = scripts\engine\utility::array_add(var0, var4);

        if(!scripts\stealth\group::group_anyoneincombat("technical")) {
          GscBinSkip4(0x35, var4);
        }
      }
    }

    foreach(var4 in var0) {
      if(istrue(var4.found)) {
        var4 notify("stop_turret_spotted_ent_think");
      }
    }
  }
}

function turret_spotted_ent_think(var0) {
  var0 endon("stop_turret_spotted_ent_think");
  var1 = 0;

  for(;;) {
    if(!isDefined(var0)) {
      return;
    }

    while(isalive(self.gunner) && turret_is_on_ent(var0, 10)) {
      var1++;

      if(var1 >= 3) {
        if(isPlayer(var0)) {
          if(!scripts\engine\utility::is_equal(self.turret_investigate_pos, var0.origin)) {
            update_turret_investigate_pos(var0.origin);
          }
        } else {
          update_turret_investigate_pos(var0 scripts\engine\sp\utility::get_corpse_origin());
          self.gunner aieventlistenerevent("saw_corpse", var0, var0 scripts\engine\sp\utility::get_corpse_origin());
          return;
        }
      }

      waitframe();
    }

    if(var1 > 0) {
      var1 = 0;
    }

    waitframe();
  }
}

function turret_is_on_ent(var0, var1) {
  if(distance2dsquared(self.origin, var0.origin) > 4000000) {
    return false;
  }

  var2 = var0.origin;

  if(isPlayer(var0)) {
    var2 = var0 getEye();
  } else {
    var2 = var0 scripts\engine\sp\utility::get_corpse_origin();
  }

  var3 = self.mgturret[0];
  var4 = var3 gettagorigin("tag_flash");
  var5 = var3 gettagangles("tag_flash");

  if(scripts\engine\utility::within_fov(var4, var5, var2, cos(var1))) {
    if(self.gunner cansee(var0)) {
      return true;
    }
  }

  return false;
}

function update_turret_investigate_pos(var0) {
  scripts\engine\utility::ent_flag_set("turret_investigate_pos_updated");
  self.turret_investigate_pos = var0;
  self.turret_investigate_pos_time = gettime();
}

function turret_sweep(var0, var1, var2) {
  self endon("death");
  self endon("turret_investigate_pos_updated");
  self.gunner endon("death");
  self.gunner endon("stealth_combat");
  var0 setconvergencetime(var2, "yaw");
  var0 setconvergencetime(var2, "pitch");
  var0 setleftarc(180);
  var0 setrightarc(180);
  var3 = scripts\engine\utility::get_array_of_closest(self.origin, level.technical_spotlight_targets, undefined, undefined, 500);
  var4 = scripts\engine\utility::get_array_of_closest(self.origin, getcorpsearray(), undefined, undefined, 500);

  foreach(var6 in var4) {
    if(!istrue(var6.found)) {
      var3 = var6;
    }
  }

  var8 = [];
  var9 = anglestoright(self.angles);
  var10 = scripts\engine\utility::getclosest(self.origin, level.landmarks, 1500);

  if(isDefined(var10) && scripts\engine\utility::array_contains(level.hvt_locations, var10.location) && level.player istouching(level.interior_volumes[var10.location])) {
    var11 = vectorNormalize(var10.origin - self.origin);
    var12 = vectordot(var9, var11);
    var1 = var12;
  }

  foreach(var14 in var3) {
    var11 = vectorNormalize(var14.origin - self.origin);
    var12 = vectordot(var9, var11);

    if(var12 * var1 <= 0) {
      continue;
    }

    if(!var0 turretcantarget(var14.origin)) {
      continue;
    }

    var8 = var14;
  }

  var11 = vectorNormalize(level.player.origin - self.origin);
  var12 = vectordot(var9, var11);

  if(var12 * var1 > 0) {
    var16 = scripts\engine\utility::getclosest(level.player.origin, var8);
  } else {
    var16 = scripts\engine\sp\utility::getfarthest(level.player.origin, var9);
  }

  if(!isDefined(var16)) {
    return false;
  }

  update_turret_pointer(var16.origin);
  waittill_technical_turns_or_timeout(var3 + 2);
  return true;
}

function waittill_technical_turns_or_timeout(var0) {
  var1 = anglesToForward(self.angles);
  var2 = gettime() + var0 * 1000;

  while(gettime() < var2) {
    waitframe();
    var3 = anglesToForward(self.angles);
    var4 = vectordot(var1, var3);

    if(var4 < 0.5) {
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

function technical_create_badplaces_along_path(var0) {
  if(self.badplaces.size) {
    technical_destroy_badplaces();
  }

  var1 = self.origin - anglesToForward(self.angles) * 112;
  var2 = self.currentnode;
  var3 = 0;

  while(var3 < var0) {
    if(var3 == 0 && isDefined(var2.script_linkname)) {
      var4 = var2;
    } else if(isDefined(var2.target)) {
      var4 = getvehiclenode(var2.target, "targetname");
    } else {
      var4 = get_best_node_at_fork(var2 scripts\engine\sp\utility::get_linked_vehicle_nodes());
    }

    while(!isDefined(var4.ground_pos)) {
      waitframe();
    }

    var5 = var4.ground_pos;
    var6 = distance(var1, var5);
    var7 = vectortoangles(var5 - var1);

    if(var6 > var0 - var3) {
      var6 = var0 - var3;
      var5 = var1 + anglesToForward(var7) * var6;
    }

    var8 = (var1 + var5) / 2;
    var9 = createnavbadplacebybounds(var8, (var6 / 2 + 20, 80, 60), var7);
    self.badplaces[self.badplaces.size] = var9;
    var3 += var6;
    var1 = var5;
    var2 = var4;
  }
}

function technical_destroy_badplaces() {
  if(!self.badplaces.size) {
    return;
  }

  foreach(var1 in self.badplaces) {
    destroynavobstacle(var1);
  }

  self.badplaces = [];
}

function technical_stop_for_allies_think() {
  self endon("death");
  self endon("gunner_defeated");
  self endon("driver_died");
  level endon("obj_scene_started");
  var0 = 0;
  self.stopped_for_allies = 0;

  for(;;) {
    waitframe();

    if(self.stopped_for_allies && !var0) {
      resume_technical("allies");
      self.stopped_for_allies = 0;
      self notify("resume_stop_for_allies");
    }

    if(!isDefined(self.next_node)) {
      continue;
    }

    var0 = 0;
    var1 = scripts\engine\utility::get_array_of_closest(self.origin, getaiarray("axis"), self.riders, undefined, 500);

    if(var1.size == 0) {
      continue;
    }

    foreach(var3 in var1) {
      if(var3 scripts\engine\sp\utility::is_touching_any(level.interior_volumes)) {
        continue;
      }

      if(is_on_technical_path(var3, 500)) {
        var0 = 1;
        var3 notify("move_for_technical");
      }
    }

    if(!var0) {
      continue;
    }

    if(!self.stopped_for_allies) {
      self.stopped_for_allies = 1;
      stop_technical("allies", 15, 15);
    }

    wait 1;
  }
}

function is_on_technical_path(var0) {
  var1 = level.technical.origin;
  var2 = level.technical.currentnode;
  var3 = 0;

  while(var3 < var0) {
    if(isDefined(var2.target)) {
      var4 = getvehiclenode(var2.target, "targetname");
    } else {
      var4 = get_best_node_at_fork(level.technical, var2 scripts\engine\sp\utility::get_linked_vehicle_nodes());
    }

    var5 = var4.ground_pos;

    if(scripts\engine\math::get_dot(var1, vectortoangles(var5 - var1), self.origin) > 0 && scripts\engine\math::get_dot(var5, vectortoangles(var1 - var5), self.origin) > 0) {
      var6 = vectorfromlinetopoint(var1, var5, self.origin);

      if(length2dsquared(var6) <= squared(60)) {
        return (distancesquared(self.origin - var6, var1) <= squared(var0 - var3));
      }
    }

    var3 += distance(var1, var5);
    var1 = var5;
    var2 = var4;
  }

  return false;
}

function technical_investigate_think(var0) {
  self endon("death");
  var1 = ["footstep", "footstep_sprint", "footstep_walk", "unresponsive_teammate", "found_corpse", "seek_backup", "silenced_shot", "sight"];

  if(scripts\engine\utility::array_contains(var1, var0.typeorig)) {
    return 1;
  }

  if(var0.typeorig == "bulletwhizby") {
    var2 = self.gunner getEye();
    var3 = vectorNormalize(var0.origin - var2);
    var0.origin = var2 + var3 * 200;
  }

  update_turret_investigate_pos(var0.origin);

  if(scripts\engine\utility::is_equal(var0.typeorig, "saw_corpse")) {
    var0.entity.found = 1;
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
    foreach(var5 in self.riders) {
      var5 aieventlistenerevent("reset", self, self.origin);
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
  var0 = self.mgturret[0];
  self.combating = 1;
  var1 = 0;
  var2 = gettime();
  waittillframeend();

  while(isalive(self.gunner) && self.gunner[[self.gunner.fnisinstealthcombat]]()) {
    if(!self.is_ramming && !self.stopped_for_allies && isDefined(self.gunner.enemy)) {
      var3 = 0;
      var4 = level.player getistouchingentities(self.circle_volumes)[0];

      if(isDefined(var4) && scripts\engine\utility::is_equal(self.next_node.script_noteworthy, var4.script_noteworthy)) {
        var3 = 1;
      }

      if(var1) {
        var5 = !turret_can_shoot_player(var0) || !self.gunner seerecently(level.player, 5) && (var3 || istrue(technical_can_reacquire_player()));

        if(var5) {
          resume_technical("combat");
          var1 = 0;
        }
      } else {
        var6 = 0;

        if(!istrue(self.unloaded_passengers) && gettime() >= var2) {
          var6 = technical_can_unload("passengers");
          var2 = gettime() + 1000;
        }

        var7 = var6 || anyone_can_see(self.riders, level.player) && turret_can_shoot_player(var0) || !var3 && !istrue(technical_can_reacquire_player());

        if(var7) {
          stop_technical("combat", 15, 15);
          var1 = 1;

          if(var6) {
            self.unloading_passengers = 1;
            technical_waittill_stopped();
            var8 = scripts\common\vehicle::vehicle_unload("passengers");

            foreach(var10 in var8) {
              var10 scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittill_any, "jumpedout", "death", "long_death");
              technical_rider_unload(var10);
            }

            scripts\engine\sp\utility::do_wait();
            self.unloading_passengers = 0;
            self.unloaded_passengers = 1;
          }
        }
      }
    }

    if(self.is_ramming && var1) {
      var1 = 0;
    }

    wait 1;
  }

  if(var1 && isalive(self.gunner)) {
    resume_technical("combat");
  }

  self.combating = 0;
}

function anyone_can_see(var0, var1) {
  foreach(var3 in var0) {
    if(var3 cansee(var1)) {
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
  var0 = self.gunner lastknowntime(level.player) + 10000;
  var1 = (var0 - gettime()) / 1000;
  var2 = self.gunner getEye() - self.origin;
  var3 = 0;
  var4 = self.origin;
  var5 = self.currentnode;
  var6 = scripts\engine\trace::create_ainosight_contents();
  var7 = level.player getEye();

  while(var3 < var1) {
    if(isDefined(var5.target)) {
      var8 = getvehiclenode(var5.target, "targetname");
    } else {
      var8 = get_best_node_at_fork(var5 scripts\engine\sp\utility::get_linked_vehicle_nodes());
    }

    var9 = var8.ground_pos;
    var10 = distance(var9, var4);
    var11 = vectorNormalize(var9 - var4);
    var12 = 0;

    while(var12 < var10) {
      var12 = min(var12 + 10, var10);
      var13 = var4 + var11 * var12 + var2;
      var14 = max(level.player.maxvisibledist, 750);

      if(distancesquared(var13, var7) > var14 * var14) {
        continue;
      }

      if(self.gunner scripts\engine\sp\utility::can_trace_to_player(var13, self, var6)) {
        return true;
      }

      waitframe();
      var7 = level.player getEye();
    }

    var15 = get_mph_speed(var5) * self.speed_scale;
    var3 += scripts\engine\sp\utility::mph_travel_time(var15, var10);
    var4 = var9;
    var5 = var8;
  }

  return false;
}

function technical_can_unload(var0) {
  var0 = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()][var0];
  var1 = scripts\engine\utility::array_combine(self.riders, [self, self.mgturret[0]]);
  var2 = (0 - self vehicle_getspeed()) / -15;
  var3 = self vehicle_getspeed() * var2 + -7.5 * var2 * var2;
  var3 *= 17.6;
  var4 = scripts\engine\utility::array_reverse(self.riders);

  foreach(var6 in var4) {
    if(!isalive(var6)) {
      continue;
    }

    if(!scripts\engine\utility::array_contains(var0, var6.vehicle_position)) {
      continue;
    }

    var7 = var6.origin;
    var8 = undefined;

    switch (var6.vehicle_position) {
      case 0:
        var8 = var7 - anglestoright(self.angles) * 45;
        break;
      case 1:
        var8 = var7 + anglestoright(self.angles) * 45;
        break;
      case 5:
      case 4:
        var8 = var7 - anglesToForward(self.angles) * 75;
        break;
    }

    var9 = getclosestpointonnavmesh(var8, var6);
    var10 = 96;

    if(distance2dsquared(var8, var9) > var10 * var10) {
      return false;
    }

    var7 += anglesToForward(self.angles) * var3;
    var8 += anglesToForward(self.angles) * var3;
    var11 = scripts\engine\trace::capsule_trace(var7, var8, 16, 60, self.angles, var1);

    if(var11["hittype"] != "hittype_none") {
      return false;
    }

    var7 = undefined;
    var8 = undefined;

    switch (var6.vehicle_position) {
      case 0:
        var7 = self gettagorigin("tag_door_front_left");
        var8 = var7 - anglestoright(self.angles) * 45;
        break;
      case 1:
        var7 = self gettagorigin("tag_door_front_right");
        var8 = var7 + anglestoright(self.angles) * 45;
        break;
    }

    if(isDefined(var7)) {
      var7 += anglesToForward(self.angles) * var3;
      var8 += anglesToForward(self.angles) * var3;

      if(!scripts\engine\trace::ray_trace_passed(var7, var8, var1)) {
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
  var0 = 0;
  self.is_ramming = 0;

  for(;;) {
    wait 0.15;

    if(self.stopped_for_allies) {
      var0 = 0;
      continue;
    }

    if(!var0 && self.is_ramming) {
      update_technical_speed_scale(1, 15, 15);
      self.is_ramming = 0;
    }

    var0 = 0;

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

    var0 = 1;

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
    level.player waittill("damage", var0, var1, var2, var3);

    if(scripts\engine\utility::is_equal(var1, self)) {
      var4 = self vehicle_getspeed() * 75 * vectorNormalize(var2);
      level.player setvelocity(var4);
      level.player playSound("sp_lvl_estate_technical_impact_01");

      if(self vehicle_getspeed() > 10) {
        stop_technical("player_dead", 15, 15);
        level.player kill(var3, self);
      }

      foreach(var6 in self.riders) {
        var6 aieventlistenerevent("proximity", level.player, level.player.origin);
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
    var0 = distancesquared(self.origin, level.player.origin);

    if(self.gunner[[self.gunner.fnisinstealthcombat]]()) {
      if(var0 < 40000) {
        self.gunner getenemyinfo(level.player);
      }
    } else if(var0 < 22500 && level.player getstance() != "prone") {
      self.gunner aieventlistenerevent("proximity", level.player, level.player.origin);
    }

    wait 0.1;
  }
}

function technical_death_hint_think() {
  self endon("death");
  self endon("gunner_defeated");
  level endon("obj_scene_started");
  level.player waittill("death", var0, var1, var2, var3, var4);

  if(var0 == self || var0 == self.mgturret[0]) {
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
      var0 = spawnStruct();
      var0.type = "ally_killed";
      var0.ent = level.player;
      var0.origin = self.origin;

      if(!technical_can_unload("passengers")) {
        update_technical_speed_scale(0.5, 15, 15);

        if(is_technical_stopped()) {
          foreach(var2 in self.stops) {
            if(var3 == "investigate") {
              continue;
            }

            resume_technical(var3);
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
      var4 = scripts\common\vehicle::vehicle_unload("passengers");

      foreach(var6 in var4) {
        technical_rider_unload(var6, var0);
      }
    } else {
      stop_technical("death", 15, 15);
    }
  } else {
    stop_technical("death", 15, 15);
  }

  technical_destroy_badplaces();
}

function stop_technical(var0, var1, var2) {
  if(isDefined(self.stops[var0])) {
    return;
  }

  self.stops[var0] = 1;

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

function resume_technical(var0) {
  self.stops[var0] = undefined;
  self.stops = scripts\engine\utility::array_remove_key(self.stops, var0);

  if(!self.stops.size) {
    if(!scripts\engine\utility::flag("technical_sfx_playing")) {
      thread sfx_technical_resume();
    }

    self vehicle_setspeed(self.current_speed * self.speed_scale, 15, 15);
    scripts\common\vehicle_code::vehicle_badplace();

    if(isDefined(self.cover_nodes)) {
      foreach(var2 in self.cover_nodes) {
        despawncovernode(var2);
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

function vehicle_spawncovernodes(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var4 *= -1;
  var6 *= -1;
  var9 = anglesToForward(var1);
  var10 = anglestoright(var1);
  var11 = (0, 0, 1);
  var12 = vectortoangles(var9);
  var13 = vectortoangles(var9 * -1);
  var14 = vectortoangles(var10);
  var15 = vectortoangles(var10 * -1);
  var16 = [];
  var16 = vehicle_addcovernodetemplate(var16, "Cover Left", var2 - 16, var6, var14);
  var16 = vehicle_addcovernodetemplate(var16, "Cover Right", var2 + var3, var6 + 16, var13);
  var16 = vehicle_addcovernodetemplate(var16, "Cover Left", var2 + var3, var7 - 16, var13);
  var16 = vehicle_addcovernodetemplate(var16, "Cover Right", var2 - 16, var7, var15);
  var16 = vehicle_addcovernodetemplate(var16, "Cover Left", var4 + 16, var7, var15);
  var16 = vehicle_addcovernodetemplate(var16, "Cover Right", var4 - var5, var7 - 16, var12);
  var16 = vehicle_addcovernodetemplate(var16, "Cover Left", var4 - var5, var6 + 16, var12);
  var16 = vehicle_addcovernodetemplate(var16, "Cover Right", var4 + 16, var6, var14);
  var17 = [];

  foreach(var19 in var16) {
    var20 = var0 + var9 * var19.forwarddistance + var10 * var19.rightdistance + var11 * 32;
    var20 += anglesToForward(var19.angles) * 16 * -1;
    var21 = spawncovernode(var20, var19.angles, var19.type, 4, var8);

    if(isDefined(var21)) {
      var17 = scripts\engine\utility::array_add(var17, var21);
    }
  }

  return var17;
}

function vehicle_addcovernodetemplate(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.type = var0;
  var4.forwarddistance = var1;
  var4.rightdistance = var2;
  var4.angles = var3;
  return scripts\engine\utility::array_add(self, var4);
}