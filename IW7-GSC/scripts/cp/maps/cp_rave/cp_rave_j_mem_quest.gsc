/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_j_mem_quest.gsc
***********************************************************/

j_mem_quest_init() {
  scripts\engine\utility::flag_init("photo_1_kev_given");
  scripts\engine\utility::flag_init("photo_2_kev_given");
  scripts\engine\utility::flag_init("photo_1_kev_vo_done");
  scripts\engine\utility::flag_init("photo_2_kev_vo_done");
  level._effect["arm_symbol_column"] = loadfx("vfx\iw7\_requests\coop\vfx_zmb_skel_arm_telgraph.vfx");
  level._effect["j_mem_start_symbol"] = loadfx("vfx\iw7\levels\cp_rave\vfx_rave_j_mem_start.vfx");
  level._effect["slasher_appear"] = loadfx("vfx\iw7\levels\cp_rave\slasher\vfx_rave_slasher_teleportation_appear.vfx");
  level thread init_j_mem_arms();
  scripts\cp\zombies\zombie_quest::register_quest_step("jmem", 0, ::blank, ::do_find_thing_1, ::blank, ::blank);
  scripts\cp\zombies\zombie_quest::register_quest_step("jmem", 1, ::blank, ::do_circle_fight_1, ::blank, ::blank);
  scripts\cp\zombies\zombie_quest::register_quest_step("jmem", 2, ::blank, ::do_give_thing_to_kev_1, ::blank, ::blank);
  scripts\cp\zombies\zombie_quest::register_quest_step("jmem", 3, ::blank, ::do_find_thing_2, ::blank, ::blank);
  scripts\cp\zombies\zombie_quest::register_quest_step("jmem", 4, ::blank, ::do_circle_fight_2, ::blank, ::blank);
  scripts\cp\zombies\zombie_quest::register_quest_step("jmem", 5, ::blank, ::do_give_thing_to_kev_2, ::blank, ::blank);
  scripts\cp\zombies\zombie_quest::register_quest_step("jmem", 6, ::blank, ::do_find_thing_3, ::blank, ::blank);
  scripts\cp\zombies\zombie_quest::register_quest_step("jmem", 7, ::blank, ::do_circle_fight_3, ::blank, ::blank);
  scripts\cp\zombies\zombie_quest::register_quest_step("jmem", 8, ::blank, ::do_give_thing_to_kev_3, ::blank, ::blank);
  level.slasher_fight = 0;
}

blank() {}

init_j_mem_arms() {
  level.j_mem_arms = getEntArray("j_mem_arm", "targetname");
  foreach(var_1 in level.j_mem_arms) {
    var_1 thread init_arm();
  }

  level.j_mem_legs = getEntArray("j_mem_leg", "targetname");
  foreach(var_1 in level.j_mem_legs) {
    var_1 thread init_arm();
  }

  level.j_mem_heads = getEntArray("j_mem_head", "targetname");
  foreach(var_1 in level.j_mem_heads) {
    var_1 thread init_arm();
  }

  level.circle_fight_done = [];
}

init_arm() {
  self.turned_angles = self.angles;
  self.high_point = self.origin + (0, 0, 6);
  self.low_point = self.origin + (0, 0, -20);
  self moveto(self.origin + (0, 0, -15), 1);
  self waittill("movedone");
  self.angles = (270, 180, 180);
  var_0 = randomintrange(-270, 270);
  self rotateyaw(var_0, 0.1);
  wait(0.1);
}

init_find_thing_1() {}

do_find_thing_1() {
  while(!scripts\engine\utility::istrue(level.met_kev)) {
    wait(0.1);
  }

  find_thing("j_mem_1", "cp_rave_quest_photo_03");
  give_thing_to_player("j_mem_1");
  level scripts\cp\utility::set_quest_icon(13);
}

do_find_thing_2() {
  find_thing("j_mem_2", "cp_rave_quest_photo_04");
  give_thing_to_player("j_mem_2");
  level scripts\cp\utility::set_quest_icon(14);
}

do_find_thing_3() {
  find_thing("j_mem_3", "p7_skulls_bones_head_01");
  give_thing_to_player("j_mem_3");
  level scripts\cp\utility::set_quest_icon(15);
}

complete_find_thing_1() {}

init_circle_fight_1() {}

do_circle_fight_1() {
  circle_fight_loop_check("j_mem_1_place", "circle_org_arm", "cp_rave_j_mem_arm", level.j_mem_arms, "cp_rave_quest_photo_01", "cp_rave_quest_photo_03");
}

do_circle_fight_2() {
  circle_fight_loop_check("j_mem_2_place", "circle_org_leg", "cp_rave_j_mem_arm", level.j_mem_legs, "cp_rave_quest_photo_02", "cp_rave_quest_photo_04");
}

do_circle_fight_3() {
  circle_fight_loop_check("j_mem_3_place", "circle_org_head", "cp_rave_j_mem_arm", level.j_mem_heads, "p7_skulls_bones_head_01", "p7_skulls_bones_head_01");
}

complete_circle_fight_1() {}

init_give_thing_to_kev_1() {}

do_give_thing_to_kev_1() {
  level scripts\cp\utility::set_quest_icon(20);
  give_thing_to_kev("j_mem_1_give");
  level thread play_ambient_kevin_smith_vo_jay_memory();
}

do_give_thing_to_kev_2() {
  level scripts\cp\utility::set_quest_icon(19);
  give_thing_to_kev("j_mem_2_give");
}

do_give_thing_to_kev_3() {
  scripts\engine\utility::flag_set("survivor_trapped");
  level scripts\cp\utility::set_quest_icon(15);
  level notify("third_quest_part_done");
}

find_thing(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel(var_1);
  if(var_0 == "j_mem_3") {
    var_2 moveto(var_2.origin + (0, 0, 15), 1);
  }

  var_2 makeusable();
  var_2 sethintstring(&"CP_RAVE_PICKUP_ITEM");
  var_2 waittill("trigger", var_4);
  var_2 makeunusable();
  level.player_picked_up_thing = var_4;
  var_3 delete();
  if(var_0 == "j_mem_1") {
    var_4 thread play_jay_memory_pickup("memento_1", "m10_jmewes_bff_1");
    return;
  }

  if(var_0 == "j_mem_2") {
    var_4 thread play_jay_memory_pickup("memento_2", "m11_jmewes_bff_1");
    return;
  }

  if(var_0 == "j_mem_3") {
    var_4 play_mem_3_vo();
    return;
  }
}

play_mem_3_vo() {
  play_jay_memory_pickup("memento_3", "m12_jmewes_bff_1");
  play_get_j_mem_vo_dialogue("j_mem_3");
  if(self.vo_prefix == "p5_") {
    thread scripts\cp\cp_vo::try_to_play_vo("totheisland", "rave_comment_vo");
  }
}

give_thing_to_player(var_0) {
  if(!isDefined(level.j_mem)) {
    level.j_mem = [];
  }

  level.j_mem[var_0] = 1;
}

play_get_j_mem_vo_dialogue(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = var_1[2];
  if(var_0 != "j_mem_3") {
    return;
  }

  if(!isDefined(level.player_picked_up_thing)) {
    return;
  }

  switch (level.player_picked_up_thing.vo_prefix) {
    case "p1_":
      level.player_picked_up_thing thread scripts\cp\cp_vo::try_to_play_vo("mem3_p1_42_1", "rave_dialogue_vo");
      break;

    case "p2_":
      level.player_picked_up_thing thread scripts\cp\cp_vo::try_to_play_vo("mem3_p2_45_1", "rave_dialogue_vo");
      break;

    case "p3_":
      level.player_picked_up_thing thread scripts\cp\cp_vo::try_to_play_vo("mem3_p3_43_1", "rave_dialogue_vo");
      break;

    case "p4_":
      level.player_picked_up_thing thread scripts\cp\cp_vo::try_to_play_vo("mem3_p4_44_1", "rave_dialogue_vo");
      break;

    default:
      break;
  }
}

unset_quest_icon(var_0) {
  setomnvarbit("zombie_quest_piece", var_0, 0);
  setclientmatchdata("questPieces", "quest_piece_" + var_0, 0);
}

display_symbols(var_0, var_1) {
  var_2 = [];
  var_3 = level.players.size;
  var_4 = 0;
  foreach(var_6 in var_0) {
    if(var_4 < var_3) {
      playFX(level._effect["j_mem_start_symbol"], var_6.origin);
      var_4++;
      wait(0.05);
    }
  }

  wait(var_1);
}

circle_fight_loop_check(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.circle_fight_done[var_1])) {
    level.circle_fight_done[var_1] = 0;
  }

  var_6 = 1000000;
  var_7 = scripts\engine\utility::getstruct(var_1, "targetname");
  if(!isDefined(level.photo)) {
    level.photo = spawn("script_model", var_7.origin);
    level.photo setModel("tag_origin");
    var_8 = getgroundposition(level.photo.origin, 2);
    level.photo.origin = var_8 + (0, 0, 1);
  }

  while(!level.circle_fight_done[var_1]) {
    wait_for_start_trigger(var_0, var_1);
    level.slasher_fight = 1;
    scripts\engine\utility::flag_clear("can_drop_coins");
    var_9 = get_model_name(var_1);
    level.photo setModel(var_9);
    level.no_slasher = 1;
    if(isDefined(level.slasher)) {
      level.slasher setscriptablepartstate("teleport", "hide");
      wait(0.1);
      level.slasher hide();
      level.slasher suicide();
      wait(0.1);
    }

    level.forceravemode = 1;
    foreach(var_11 in level.players) {
      if(distancesquared(var_11.origin, var_7.origin) < var_6) {
        var_11.unlimited_rave = 1;
        level thread scripts\cp\maps\cp_rave\cp_rave::enter_rave_mode(var_11);
      }
    }

    start_circle_fight_fx(var_3, var_2);
    level thread spawn_guys_to_fight(var_7, var_2, var_3, var_0);
    var_13 = 0;
    var_14 = level scripts\engine\utility::waittill_any_return("speaker_defense_failed", "speaker_defense_completed");
    if(var_14 == "speaker_defense_completed") {
      for(var_15 = 0; var_15 < var_3.size; var_15++) {
        var_10 = var_3[var_15];
        if(var_15 == var_3.size - 1) {
          level.photo_soul = zombie_limb_soul_fly_to_photo(var_10.origin + (0, 0, 10), var_10, 1);
          continue;
        }

        zombie_limb_soul_fly_to_photo(var_10.origin + (0, 0, 10), var_10);
      }

      end_circle_fight_fx(var_3, var_2);
      level.no_slasher = 1;
      level thread pick_up_charged_photo(var_1, var_4);
      level thread time_out_charged_photo(30);
      var_14 = level scripts\engine\utility::waittill_any_return("slasher_photo_timeout", "slasher_photo_taken");
      if(var_14 == "slasher_photo_timeout") {
        level.photo_soul delete();
        level.forceravemode = 0;
        foreach(var_11 in level.players) {
          var_11.unlimited_rave = 0;
          level thread scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_11);
          level thread slash_a_perk(var_11);
        }

        show_kev();
        var_13 = 1;
      } else {
        level thread slasher_fight(var_1, var_4, var_5);
        level.forceravemode = 0;
        var_14 = level scripts\engine\utility::waittill_any_return("slasher_timeout", "slasher_killed");
        if(var_14 == "slasher_timeout") {
          show_kev();
          var_13 = 1;
          level.slasher setscriptablepartstate("teleport", "hide");
          wait(0.1);
          level.slasher suicide();
        } else {
          if(scripts\engine\utility::flag("photo_1_kev_vo_done") && scripts\engine\utility::flag("photo_2_kev_vo_done")) {} else {
            show_kev();
          }

          level.slasher setscriptablepartstate("teleport", "hide");
          wait(0.1);
          level.slasher hide();
          wait(0.1);
          level.slasher suicide();
          level.slasher_visible_in_normal_mode = 0;
          var_7 = scripts\engine\utility::getstruct(var_1, "targetname");
          nuke_fx_kill_everyone();
          level drop_photo_from_slasher(level.slasher_drop, var_5, var_1);
        }
      }
    } else {
      lower_arm_array(var_3, var_2);
      foreach(var_11 in level.players) {
        var_11.unlimited_rave = 0;
        level thread scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_11);
        level thread slash_a_perk(var_11);
      }

      var_13 = 1;
    }

    if(var_13) {
      level.forceravemode = 0;
      end_circle_fight_fx(var_3, var_2);
      level.no_slasher = 0;
      level.photo show();
      nuke_fx_kill_everyone();
    }

    level.slasher_fight = 0;
    scripts\engine\utility::flag_set("can_drop_coins");
    clear_defense_sequence_active_flag();
    wait(1);
  }

  foreach(var_10 in var_3) {
    var_10 hide();
  }

  if(isDefined(level.photo)) {
    level.photo delete();
  }

  if(isDefined(level.photo_soul)) {
    level.photo_soul delete();
  }

  wait(2);
}

nuke_fx_kill_everyone() {
  var_0 = level.spawned_enemies;
  foreach(var_2 in var_0) {
    if(isalive(var_2) && isDefined(var_2.agent_type) && var_2.agent_type == "generic_zombie") {
      var_2.died_poorly = 1;
    }
  }

  var_4 = spawn("script_model", level.players[0].origin);
  var_4 setModel("tag_origin");
  var_4.team = "allies";
  level.forced_nuke = 1;
  scripts\cp\loot::process_loot_content(level.players[0], "kill_50", var_4, 0);
}

get_model_name(var_0) {
  switch (var_0) {
    case "circle_org_arm":
      return "cp_rave_quest_photo_03";

    case "circle_org_leg":
      return "cp_rave_quest_photo_04";

    case "circle_org_head":
      return "p7_skulls_bones_head_01";
  }
}

slash_a_perk(var_0) {
  var_0 setclientomnvar("zombie_coaster_ticket_earned", 1);
  if(isDefined(var_0.zombies_perks) && var_0.zombies_perks.size > 0) {
    var_1 = randomint(var_0.zombies_perks.size);
    var_2 = getarraykeys(var_0.zombies_perks);
    var_3 = scripts\engine\utility::random(var_2);
    var_0 scripts\cp\zombies\zombies_perk_machines::take_zombies_perk(var_3);
  }

  wait(3);
  var_0 setclientomnvar("zombie_coaster_ticket_earned", -1);
}

wait_for_start_trigger(var_0, var_1) {
  var_2 = 1000000;
  level.photo makeusable();
  level.photo sethintstring(&"CP_RAVE_PLACE_ITEM");
  for(;;) {
    level.photo waittill("trigger", var_3);
    var_4 = 0;
    foreach(var_6 in level.players) {
      if(distancesquared(var_6.origin, level.photo.origin) > var_2) {
        var_4 = 1;
        continue;
      }

      if(scripts\engine\utility::istrue(var_6.rave_mode)) {
        var_4 = 1;
      }
    }

    if(var_4) {
      var_8 = scripts\engine\utility::getStructArray(var_1 + "_symbol", "targetname");
      display_symbols(var_8, 2);
      continue;
    }

    break;
  }

  level.photo makeunusable();
  var_9 = get_quest_icon_num(var_1);
  unset_quest_icon(var_9);
  hide_kev();
}

hide_kev() {
  level.survivor hide();
  var_0 = scripts\engine\utility::getStructArray("survivor_interaction", "script_noteworthy");
  scripts\cp\cp_interaction::disable_like_interactions(var_0[0]);
}

show_kev() {
  level.survivor show();
  var_0 = scripts\engine\utility::getStructArray("survivor_interaction", "script_noteworthy");
  scripts\cp\cp_interaction::enable_like_interactions(var_0[0]);
}

get_quest_icon_num(var_0) {
  switch (var_0) {
    case "circle_org_arm":
      return 13;

    case "circle_org_leg":
      return 14;

    case "circle_org_head":
      return 15;
  }
}

start_circle_fight_fx(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    add_to_and_play_arm_fx_array(var_0[var_2].origin);
    var_0[var_2] thread raise_arm(var_1);
    wait(0.1);
  }
}

end_circle_fight_fx(var_0, var_1) {
  if(isDefined(level.arm_fx)) {
    foreach(var_3 in level.arm_fx) {
      if(isDefined(var_3)) {
        var_3 delete();
      }
    }
  }
}

lower_arm_array(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    wait(0.1);
    var_0[var_2] lower_arm(var_1);
    wait(0.1);
  }
}

add_to_and_play_arm_fx_array(var_0) {
  if(!isDefined(level.arm_fx)) {
    level.arm_fx = [];
  }

  var_1 = spawnfx(level._effect["arm_symbol_column"], var_0);
  level.arm_fx[level.arm_fx.size] = var_1;
  wait(0.1);
  triggerfx(var_1);
}

raise_arm(var_0) {
  self setModel(var_0);
  if(isDefined(self.high_point)) {
    self moveto(self.high_point, 0.2);
  } else {
    self moveto(self.origin + (0, 0, 10), 0.2);
  }

  self waittill("movedone");
}

lower_arm(var_0) {
  if(isDefined(self.low_point)) {
    self moveto(self.low_point, 0.2);
  } else {
    self moveto(self.origin - (0, 0, 10), 0.2);
  }

  self waittill("movedone");
}

spawn_guys_to_fight(var_0, var_1, var_2, var_3) {
  set_defense_sequence_active_flag();
  level thread stopwavefromprogressing(var_0);
  thread startspeakereventspawning(var_0);
  level thread fight_timer(60);
  level thread listen_for_circle_kills(var_1, var_2, var_3);
}

set_defense_sequence_active_flag() {
  if(!scripts\engine\utility::flag_exist("defense_sequence_active")) {
    scripts\engine\utility::flag_init("defense_sequence_active");
  }

  scripts\engine\utility::flag_set("defense_sequence_active");
}

clear_defense_sequence_active_flag() {
  if(!scripts\engine\utility::flag_exist("defense_sequence_active")) {
    scripts\engine\utility::flag_init("defense_sequence_active");
  }

  scripts\engine\utility::flag_clear("defense_sequence_active");
}

stopwavefromprogressing(var_0) {
  var_1 = level.cop_spawn_percent;
  var_2 = level.current_enemy_deaths;
  var_3 = level.max_static_spawned_enemies;
  var_4 = level.desired_enemy_deaths_this_wave;
  var_5 = level.wave_num;
  while(level.current_enemy_deaths == level.desired_enemy_deaths_this_wave) {
    wait(0.05);
  }

  level.current_enemy_deaths = 0;
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    level.max_static_spawned_enemies = 16;
  } else {
    level.max_static_spawned_enemies = 24;
  }

  level.desired_enemy_deaths_this_wave = 24;
  level.special_event = 1;
  scripts\engine\utility::flag_set("pause_wave_progression");
  var_6 = level scripts\engine\utility::waittill_any_return("speaker_defense_failed", "slasher_photo_timeout", "slasher_timeout", "slasher_killed");
  level.spawndelayoverride = undefined;
  level.wave_num_override = undefined;
  level.special_event = undefined;
  turn_despawn_back_on();
  wait(2);
  wait(3);
  scripts\engine\utility::flag_clear("pause_wave_progression");
  if(level.wave_num == var_5) {
    level.current_enemy_deaths = var_2;
    level.max_static_spawned_enemies = var_3;
    level.desired_enemy_deaths_this_wave = var_4;
    return;
  }

  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = scripts\cp\zombies\zombies_spawning::get_max_static_enemies(level.wave_num);
  level.desired_enemy_deaths_this_wave = scripts\cp\zombies\zombies_spawning::get_total_spawned_enemies(level.wave_num);
}

startspeakereventspawning(var_0) {
  var_1 = level.active_spawn_volumes;
  var_2 = undefined;
  var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, undefined, 4, 1000);
  foreach(var_6 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    var_6 thread adjustmovespeed(var_6);
  }

  foreach(var_9 in var_1) {
    if(ispointinvolume(var_0.origin, var_9)) {
      var_2 = var_9;
      break;
    }
  }

  if(isDefined(var_2)) {
    if(isDefined(var_2.spawners)) {
      var_11 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2.spawners, undefined, 100, 400);
      foreach(var_13 in var_11) {
        var_13 scripts\cp\zombies\zombies_spawning::make_spawner_inactive();
      }
    }

    foreach(var_10 in var_1) {
      if(var_10 == var_2) {
        continue;
      }

      var_10 scripts\cp\zombies\zombies_spawning::make_volume_inactive();
    }
  }

  level scripts\engine\utility::waittill_any_return("speaker_defense_failed", "speaker_defense_completed");
  foreach(var_13 in var_1) {
    var_13 scripts\cp\zombies\zombies_spawning::make_volume_active();
  }
}

turn_despawn_back_on() {
  foreach(var_1 in level.spawned_enemies) {
    var_1.dont_cleanup = undefined;
  }
}

adjustmovespeed(var_0, var_1) {
  var_0 endon("death");
  if(scripts\engine\utility::istrue(var_1)) {
    wait(0.5);
  }

  var_0.synctransients = "sprint";
  var_0 scripts\asm\asm_bb::bb_requestmovetype("sprint");
}

fight_timer(var_0) {
  wait(var_0);
  level notify("speaker_defense_failed");
  deactivate_dismember_circle_logic();
}

listen_for_circle_kills(var_0, var_1, var_2) {
  level endon("speaker_defense_failed");
  level.circle_arms = 0;
  switch (var_2) {
    case "j_mem_1_place":
      activate_dismember_arm();
      level thread arm_counter(var_0, "add_arm", var_1);
      break;

    case "j_mem_2_place":
      activate_dismember_leg();
      level thread arm_counter(var_0, "add_leg", var_1);
      break;

    case "j_mem_3_place":
      activate_dismember_head();
      level thread arm_counter(var_0, "add_head", var_1);
      break;

    default:
      break;
  }

  while(level.circle_arms < 10) {
    wait(0.1);
  }

  deactivate_dismember_circle_logic();
  level notify("speaker_defense_completed");
}

activate_dismember_arm() {
  level thread dismember_circle_logic("arm");
}

activate_dismember_leg() {
  level thread dismember_circle_logic("leg");
}

activate_dismember_head() {
  level thread dismember_circle_logic("head");
}

dismember_circle_logic(var_0) {
  level endon("stop_circle_dismember_logic");
  for(;;) {
    level waittill("dismember", var_1, var_2);
    switch (var_2) {
      case 2:
      case 1:
        if(var_0 == "arm") {
          level notify("add_arm", var_1);
        }
        break;

      case 8:
      case 4:
        if(var_0 == "leg") {
          level notify("add_leg", var_1);
        }
        break;

      case 16:
        if(var_0 == "head") {
          level notify("add_head", var_1);
        }
        break;
    }
  }
}

deactivate_dismember_circle_logic() {
  level notify("stop_circle_dismember_logic");
}

arm_counter(var_0, var_1, var_2) {
  level endon("stop_circle_dismember_logic");
  foreach(var_4 in var_2) {
    var_4 thread raise_arm(var_0);
    wait(0.25);
  }

  wait(1);
  foreach(var_4 in var_2) {
    var_4 thread lower_arm(var_0);
    wait(0.25);
  }

  wait(2);
  var_8 = 5;
  var_9 = 5;
  for(;;) {
    level waittill(var_1, var_10);
    if(level.circle_arms < 10) {
      level.circle_arms++;
      level thread play_fx_and_raise_arm(var_10, var_2, var_0);
    }

    if(level.circle_arms > 9) {
      break;
    }
  }
}

play_fx_and_raise_arm(var_0, var_1, var_2) {
  zombie_limb_soul_fly_to_arm(var_0.origin, var_1[level.circle_arms - 1]);
  var_1[level.circle_arms - 1] raise_arm(var_2);
}

zombie_limb_soul_fly_to_arm(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin_soultrail");
  var_3 = level.photo.origin + (0, 0, 20);
  var_4 = var_2.origin;
  var_5 = distance(var_4, var_3);
  var_6 = var_5 / 450;
  if(var_6 < 0.05) {
    var_6 = 0.05;
  }

  var_2 moveto(var_3, var_6);
  var_2 waittill("movedone");
  var_3 = var_1.origin;
  var_4 = var_2.origin;
  var_5 = distance(var_4, var_3);
  var_6 = var_5 / 450;
  if(var_6 < 0.05) {
    var_6 = 0.05;
  }

  var_2 moveto(var_3, var_6);
  var_2 waittill("movedone");
  var_2 delete();
}

zombie_limb_soul_fly_to_photo(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3 setModel("tag_origin_soultrail");
  var_4 = level.photo.origin;
  var_5 = var_3.origin;
  var_6 = distance(var_5, var_4);
  var_7 = var_6 / 450;
  if(var_7 < 0.05) {
    var_7 = 0.05;
  }

  var_3 moveto(var_4, var_7);
  var_3 waittill("movedone");
  var_8 = "unused";
  var_1 thread lower_arm(var_8);
  if(isDefined(var_2)) {
    return var_3;
  }

  var_3 delete();
}

pick_up_charged_photo(var_0, var_1) {
  level.photo show();
  var_2 = level.photo;
  var_2 setModel(var_1);
  var_2 makeusable();
  var_2 sethintstring(&"CP_RAVE_INSPECT_ITEM");
  var_2 waittill("trigger", var_3);
  var_2 makeunusable();
  if(isDefined(level.photo_soul)) {
    level.photo_soul delete();
  }

  var_2 hide();
  level notify("slasher_photo_taken");
}

time_out_charged_photo(var_0) {
  wait(var_0);
  level notify("slasher_photo_timeout");
}

slasher_fight(var_0, var_1, var_2) {
  var_3 = 1000000;
  var_4 = scripts\engine\utility::getstruct(var_0, "targetname");
  var_5 = spawnfx(level._effect["memory_trap_loop"], var_4.origin + (0, 0, -22));
  playFX(level._effect["slasher_appear"], var_4.origin);
  if(isDefined(level.photo_soul)) {
    level.photo_soul delete();
  }

  level.no_slasher = 0;
  scripts\cp\maps\cp_rave\cp_rave::spawn_slasher_after_timer(0.1, var_4.origin);
  if(isDefined(level.slasher)) {
    level.slasher.precacheleaderboards = 1;
    wait(2);
    playsoundatpos(var_4.origin, "slasher_rave_mode_exit_portal_fx");
    triggerfx(var_5);
    wait(2);
    level.slasher setethereal(0);
    foreach(var_7 in level.players) {
      var_7.unlimited_rave = 0;
      level thread scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_7);
    }

    wait(2);
    level.slasher.precacheleaderboards = 0;
    var_5 delete();
    level.slasher_visible_in_normal_mode = 1;
    level.slasher thread get_slasher_death_loc();
    level.slasher thread time_out_slasher_fight(60);
  }
}

time_out_slasher_fight(var_0) {
  wait(var_0);
  level notify("slasher_timeout");
}

get_slasher_death_loc() {
  self waittill("fake_death");
  level.slasher setscriptablepartstate("teleport", "hide");
  wait(0.1);
  level.slasher hide();
  level notify("slasher_killed");
  level.slasher_drop = self.origin;
}

drop_photo_from_slasher(var_0, var_1, var_2) {
  level.photo setModel(var_1);
  level.photo show();
  level thread scripts\cp\loot::drop_loot(level.slasher_drop, undefined, "ammo_max");
  var_3 = spawn("script_model", level.photo.origin);
  var_3 setModel("tag_origin_soultrail");
  level.photo makeusable();
  level.photo sethintstring(&"CP_RAVE_INSPECT_ITEM");
  level.photo waittill("trigger", var_4);
  level.photo hide();
  var_3 delete();
  if(var_1 == "cp_rave_quest_photo_03") {
    scripts\engine\utility::flag_set("photo_1_kev_given");
    if(level.slasher_level < 2) {
      level.slasher_level = 2;
    }

    play_jay_memory_after_slasher_fight("m10_jmewes_bff_2");
  } else if(var_1 == "cp_rave_quest_photo_04") {
    scripts\engine\utility::flag_set("photo_2_kev_given");
    if(level.slasher_level < 3) {
      level.slasher_level = 3;
    }

    play_jay_memory_after_slasher_fight("m11_jmewes_bff_2");
  } else {
    play_jay_memory_after_slasher_fight("m12_jmewes_bff_2");
  }

  level.circle_fight_done[var_2] = 1;
}

give_thing_to_kev(var_0) {
  if(var_0 == "j_mem_1_give") {
    scripts\engine\utility::flag_wait("photo_1_kev_vo_done");
  } else if(var_0 == "j_mem_2_give") {
    scripts\engine\utility::flag_wait("photo_2_kev_vo_done");
  }

  if(!isDefined(level.j_mem_complete)) {
    level.j_mem_complete = [];
  }

  level.j_mem_complete[var_0] = self;
}

play_j_mem_vo(var_0, var_1) {
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("m" + var_0 + "_jmewes_bff_" + var_1);
  wait(scripts\cp\cp_vo::get_sound_length("m" + var_0 + "_jmewes_bff_" + var_1));
}

play_jay_memory_pickup(var_0, var_1) {
  thread scripts\cp\cp_vo::try_to_play_vo(var_0, "rave_comment_vo");
  wait(scripts\cp\cp_vo::get_sound_length(self.vo_prefix + var_0));
  wait(1);
  foreach(var_3 in level.players) {
    var_3 thread scripts\cp\cp_vo::try_to_play_vo(var_1, "rave_memory_vo");
  }
}

play_ambient_kevin_smith_vo_jay_memory() {
  level endon("game_ended");
  level endon("third_quest_part_done");
  if(!isDefined(level.times_played_mem_1)) {
    level.times_played_mem_1 = 0;
  }

  if(!isDefined(level.times_played_mem_2)) {
    level.times_played_mem_2 = 0;
  }

  wait(randomintrange(30, 50));
  for(;;) {
    if(scripts\engine\utility::istrue(level.j_mem["j_mem_1"])) {
      if(level.times_played_mem_1 == 0) {
        scripts\cp\utility::playsoundinspace("ks_examine_memento_4", level.survivor.origin, 1);
        wait(randomfloatrange(1, 2));
        scripts\cp\utility::playsoundinspace("ks_examine_memento_2", level.survivor.origin, 1);
        wait(randomfloatrange(1, 2));
        scripts\cp\utility::playsoundinspace("ks_examine_memento_3", level.survivor.origin, 1);
        wait(randomfloatrange(1, 2));
      } else {
        return;
      }

      level.times_played_mem_1 = 1;
    } else if(scripts\engine\utility::istrue(level.j_mem["j_mem_2"])) {
      if(level.times_played_mem_2 == 0) {
        scripts\cp\utility::playsoundinspace("ks_examine_memento_6", level.survivor.origin, 1);
        wait(randomfloatrange(1, 2));
        scripts\cp\utility::playsoundinspace("ks_examine_memento_5", level.survivor.origin, 1);
        wait(randomfloatrange(1, 2));
        scripts\cp\utility::playsoundinspace("ks_examine_memento_3", level.survivor.origin, 1);
        wait(randomfloatrange(1, 2));
        level.times_played_mem_2 = 1;
      } else {
        return;
      }
    }

    wait(randomintrange(30, 50));
  }
}

play_jay_memory_after_slasher_fight(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\cp_vo::try_to_play_vo(var_0, "rave_memory_vo");
  }
}

play_jay_memory_to_kev(var_0) {
  var_1 = 1;
  if(scripts\engine\utility::flag("photo_2_kev_vo_done")) {
    var_1 = 3;
  } else if(scripts\engine\utility::flag("photo_1_kev_vo_done")) {
    var_1 = 2;
  }

  var_2 = "memento_";
  thread scripts\cp\cp_vo::try_to_play_vo(var_2 + var_1 + 3, "rave_comment_vo");
  wait(scripts\cp\cp_vo::get_sound_length(self.vo_prefix + var_2 + var_1 + 3));
  thread scripts\cp\cp_vo::try_to_play_vo("ks_" + var_2 + "quest_" + var_1, "rave_ks_vo");
  wait(scripts\cp\cp_vo::get_sound_length("ks_" + var_2 + "quest_" + var_1));
  wait(2);
  thread scripts\cp\cp_vo::try_to_play_vo("ks_" + var_2 + var_1, "rave_ks_vo");
  wait(scripts\cp\cp_vo::get_sound_length("ks_" + var_2 + var_1));
  level thread scripts\cp\maps\cp_rave\cp_rave_interactions::add_back_to_interaction_system(var_0, "");
}