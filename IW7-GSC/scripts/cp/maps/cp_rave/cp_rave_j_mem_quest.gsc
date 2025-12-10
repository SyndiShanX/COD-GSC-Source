/***********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  foreach(var_01 in level.j_mem_arms) {
    var_01 thread init_arm();
  }

  level.j_mem_legs = getEntArray("j_mem_leg", "targetname");
  foreach(var_01 in level.j_mem_legs) {
    var_01 thread init_arm();
  }

  level.j_mem_heads = getEntArray("j_mem_head", "targetname");
  foreach(var_01 in level.j_mem_heads) {
    var_01 thread init_arm();
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
  var_00 = randomintrange(-270, 270);
  self rotateyaw(var_00, 0.1);
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

find_thing(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_03 = spawn("script_model", var_02.origin);
  var_03 setModel(param_01);
  if(param_00 == "j_mem_3") {
    var_02 moveto(var_02.origin + (0, 0, 15), 1);
  }

  var_02 makeusable();
  var_02 sethintstring(&"CP_RAVE_PICKUP_ITEM");
  var_02 waittill("trigger", var_04);
  var_02 makeunusable();
  level.player_picked_up_thing = var_04;
  var_03 delete();
  if(param_00 == "j_mem_1") {
    var_04 thread play_jay_memory_pickup("memento_1", "m10_jmewes_bff_1");
    return;
  }

  if(param_00 == "j_mem_2") {
    var_04 thread play_jay_memory_pickup("memento_2", "m11_jmewes_bff_1");
    return;
  }

  if(param_00 == "j_mem_3") {
    var_04 play_mem_3_vo();
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

give_thing_to_player(param_00) {
  if(!isDefined(level.j_mem)) {
    level.j_mem = [];
  }

  level.j_mem[param_00] = 1;
}

play_get_j_mem_vo_dialogue(param_00) {
  var_01 = strtok(param_00, "_");
  var_02 = var_01[2];
  if(param_00 != "j_mem_3") {
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

unset_quest_icon(param_00) {
  setomnvarbit("zombie_quest_piece", param_00, 0);
  setclientmatchdata("questPieces", "quest_piece_" + param_00, 0);
}

display_symbols(param_00, param_01) {
  var_02 = [];
  var_03 = level.players.size;
  var_04 = 0;
  foreach(var_06 in param_00) {
    if(var_04 < var_03) {
      playFX(level._effect["j_mem_start_symbol"], var_06.origin);
      var_04++;
      wait(0.05);
    }
  }

  wait(param_01);
}

circle_fight_loop_check(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.circle_fight_done[param_01])) {
    level.circle_fight_done[param_01] = 0;
  }

  var_06 = 1000000;
  var_07 = scripts\engine\utility::getstruct(param_01, "targetname");
  if(!isDefined(level.photo)) {
    level.photo = spawn("script_model", var_07.origin);
    level.photo setModel("tag_origin");
    var_08 = getgroundposition(level.photo.origin, 2);
    level.photo.origin = var_08 + (0, 0, 1);
  }

  while(!level.circle_fight_done[param_01]) {
    wait_for_start_trigger(param_00, param_01);
    level.slasher_fight = 1;
    scripts\engine\utility::flag_clear("can_drop_coins");
    var_09 = get_model_name(param_01);
    level.photo setModel(var_09);
    level.no_slasher = 1;
    if(isDefined(level.slasher)) {
      level.slasher setscriptablepartstate("teleport", "hide");
      wait(0.1);
      level.slasher hide();
      level.slasher suicide();
      wait(0.1);
    }

    level.forceravemode = 1;
    foreach(var_0B in level.players) {
      if(distancesquared(var_0B.origin, var_07.origin) < var_06) {
        var_0B.unlimited_rave = 1;
        level thread scripts\cp\maps\cp_rave\cp_rave::enter_rave_mode(var_0B);
      }
    }

    start_circle_fight_fx(param_03, param_02);
    level thread spawn_guys_to_fight(var_07, param_02, param_03, param_00);
    var_0D = 0;
    var_0E = level scripts\engine\utility::waittill_any_return("speaker_defense_failed", "speaker_defense_completed");
    if(var_0E == "speaker_defense_completed") {
      for(var_0F = 0; var_0F < param_03.size; var_0F++) {
        var_10 = param_03[var_0F];
        if(var_0F == param_03.size - 1) {
          level.photo_soul = zombie_limb_soul_fly_to_photo(var_10.origin + (0, 0, 10), var_10, 1);
          continue;
        }

        zombie_limb_soul_fly_to_photo(var_10.origin + (0, 0, 10), var_10);
      }

      end_circle_fight_fx(param_03, param_02);
      level.no_slasher = 1;
      level thread pick_up_charged_photo(param_01, param_04);
      level thread time_out_charged_photo(30);
      var_0E = level scripts\engine\utility::waittill_any_return("slasher_photo_timeout", "slasher_photo_taken");
      if(var_0E == "slasher_photo_timeout") {
        level.photo_soul delete();
        level.forceravemode = 0;
        foreach(var_0B in level.players) {
          var_0B.unlimited_rave = 0;
          level thread scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_0B);
          level thread slash_a_perk(var_0B);
        }

        show_kev();
        var_0D = 1;
      } else {
        level thread slasher_fight(param_01, param_04, param_05);
        level.forceravemode = 0;
        var_0E = level scripts\engine\utility::waittill_any_return("slasher_timeout", "slasher_killed");
        if(var_0E == "slasher_timeout") {
          show_kev();
          var_0D = 1;
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
          var_07 = scripts\engine\utility::getstruct(param_01, "targetname");
          nuke_fx_kill_everyone();
          level drop_photo_from_slasher(level.slasher_drop, param_05, param_01);
        }
      }
    } else {
      lower_arm_array(param_03, param_02);
      foreach(var_0B in level.players) {
        var_0B.unlimited_rave = 0;
        level thread scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_0B);
        level thread slash_a_perk(var_0B);
      }

      var_0D = 1;
    }

    if(var_0D) {
      level.forceravemode = 0;
      end_circle_fight_fx(param_03, param_02);
      level.no_slasher = 0;
      level.photo show();
      nuke_fx_kill_everyone();
    }

    level.slasher_fight = 0;
    scripts\engine\utility::flag_set("can_drop_coins");
    clear_defense_sequence_active_flag();
    wait(1);
  }

  foreach(var_10 in param_03) {
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
  var_00 = level.spawned_enemies;
  foreach(var_02 in var_00) {
    if(isalive(var_02) && isDefined(var_02.agent_type) && var_02.agent_type == "generic_zombie") {
      var_02.died_poorly = 1;
    }
  }

  var_04 = spawn("script_model", level.players[0].origin);
  var_04 setModel("tag_origin");
  var_04.team = "allies";
  level.forced_nuke = 1;
  scripts\cp\loot::process_loot_content(level.players[0], "kill_50", var_04, 0);
}

get_model_name(param_00) {
  switch (param_00) {
    case "circle_org_arm":
      return "cp_rave_quest_photo_03";

    case "circle_org_leg":
      return "cp_rave_quest_photo_04";

    case "circle_org_head":
      return "p7_skulls_bones_head_01";
  }
}

slash_a_perk(param_00) {
  param_00 setclientomnvar("zombie_coaster_ticket_earned", 1);
  if(isDefined(param_00.zombies_perks) && param_00.zombies_perks.size > 0) {
    var_01 = randomint(param_00.zombies_perks.size);
    var_02 = getarraykeys(param_00.zombies_perks);
    var_03 = scripts\engine\utility::random(var_02);
    param_00 scripts\cp\zombies\zombies_perk_machines::take_zombies_perk(var_03);
  } else {}

  wait(3);
  param_00 setclientomnvar("zombie_coaster_ticket_earned", -1);
}

wait_for_start_trigger(param_00, param_01) {
  var_02 = 1000000;
  level.photo makeusable();
  level.photo sethintstring(&"CP_RAVE_PLACE_ITEM");
  for(;;) {
    level.photo waittill("trigger", var_03);
    var_04 = 0;
    foreach(var_06 in level.players) {
      if(distancesquared(var_06.origin, level.photo.origin) > var_02) {
        var_04 = 1;
        continue;
      }

      if(scripts\engine\utility::istrue(var_06.rave_mode)) {
        var_04 = 1;
      }
    }

    if(var_04) {
      var_08 = scripts\engine\utility::getstructarray(param_01 + "_symbol", "targetname");
      display_symbols(var_08, 2);
      continue;
    }

    break;
  }

  level.photo makeunusable();
  var_09 = get_quest_icon_num(param_01);
  unset_quest_icon(var_09);
  hide_kev();
}

hide_kev() {
  level.survivor hide();
  var_00 = scripts\engine\utility::getstructarray("survivor_interaction", "script_noteworthy");
  scripts\cp\cp_interaction::disable_like_interactions(var_00[0]);
}

show_kev() {
  level.survivor show();
  var_00 = scripts\engine\utility::getstructarray("survivor_interaction", "script_noteworthy");
  scripts\cp\cp_interaction::enable_like_interactions(var_00[0]);
}

get_quest_icon_num(param_00) {
  switch (param_00) {
    case "circle_org_arm":
      return 13;

    case "circle_org_leg":
      return 14;

    case "circle_org_head":
      return 15;
  }
}

start_circle_fight_fx(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    add_to_and_play_arm_fx_array(param_00[var_02].origin);
    param_00[var_02] thread raise_arm(param_01);
    wait(0.1);
  }
}

end_circle_fight_fx(param_00, param_01) {
  if(isDefined(level.arm_fx)) {
    foreach(var_03 in level.arm_fx) {
      if(isDefined(var_03)) {
        var_03 delete();
      }
    }
  }
}

lower_arm_array(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    wait(0.1);
    param_00[var_02] lower_arm(param_01);
    wait(0.1);
  }
}

add_to_and_play_arm_fx_array(param_00) {
  if(!isDefined(level.arm_fx)) {
    level.arm_fx = [];
  }

  var_01 = spawnfx(level._effect["arm_symbol_column"], param_00);
  level.arm_fx[level.arm_fx.size] = var_01;
  wait(0.1);
  triggerfx(var_01);
}

raise_arm(param_00) {
  self setModel(param_00);
  if(isDefined(self.high_point)) {
    self moveto(self.high_point, 0.2);
  } else {
    self moveto(self.origin + (0, 0, 10), 0.2);
  }

  self waittill("movedone");
}

lower_arm(param_00) {
  if(isDefined(self.low_point)) {
    self moveto(self.low_point, 0.2);
  } else {
    self moveto(self.origin - (0, 0, 10), 0.2);
  }

  self waittill("movedone");
}

spawn_guys_to_fight(param_00, param_01, param_02, param_03) {
  set_defense_sequence_active_flag();
  level thread stopwavefromprogressing(param_00);
  thread startspeakereventspawning(param_00);
  level thread fight_timer(60);
  level thread listen_for_circle_kills(param_01, param_02, param_03);
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

stopwavefromprogressing(param_00) {
  var_01 = level.cop_spawn_percent;
  var_02 = level.current_enemy_deaths;
  var_03 = level.max_static_spawned_enemies;
  var_04 = level.desired_enemy_deaths_this_wave;
  var_05 = level.wave_num;
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
  var_06 = level scripts\engine\utility::waittill_any_return("speaker_defense_failed", "slasher_photo_timeout", "slasher_timeout", "slasher_killed");
  level.spawndelayoverride = undefined;
  level.wave_num_override = undefined;
  level.special_event = undefined;
  turn_despawn_back_on();
  wait(2);
  wait(3);
  scripts\engine\utility::flag_clear("pause_wave_progression");
  if(level.wave_num == var_05) {
    level.current_enemy_deaths = var_02;
    level.max_static_spawned_enemies = var_03;
    level.desired_enemy_deaths_this_wave = var_04;
    return;
  }

  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = scripts\cp\zombies\zombies_spawning::get_max_static_enemies(level.wave_num);
  level.desired_enemy_deaths_this_wave = scripts\cp\zombies\zombies_spawning::get_total_spawned_enemies(level.wave_num);
}

startspeakereventspawning(param_00) {
  var_01 = level.active_spawn_volumes;
  var_02 = undefined;
  var_03 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_04 = scripts\engine\utility::get_array_of_closest(param_00.origin, level.players, undefined, 4, 1000);
  foreach(var_06 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    var_06 thread adjustmovespeed(var_06);
  }

  foreach(var_09 in var_01) {
    if(ispointinvolume(param_00.origin, var_09)) {
      var_02 = var_09;
      break;
    }
  }

  if(isDefined(var_02)) {
    if(isDefined(var_02.spawners)) {
      var_0B = scripts\engine\utility::get_array_of_closest(param_00.origin, var_02.spawners, undefined, 100, 400);
      foreach(var_0D in var_0B) {
        var_0D scripts\cp\zombies\zombies_spawning::make_spawner_inactive();
      }
    }

    foreach(var_10 in var_01) {
      if(var_10 == var_02) {
        continue;
      }

      var_10 scripts\cp\zombies\zombies_spawning::make_volume_inactive();
    }
  }

  level scripts\engine\utility::waittill_any_return("speaker_defense_failed", "speaker_defense_completed");
  foreach(var_13 in var_01) {
    var_13 scripts\cp\zombies\zombies_spawning::make_volume_active();
  }
}

turn_despawn_back_on() {
  foreach(var_01 in level.spawned_enemies) {
    var_01.dont_cleanup = undefined;
  }
}

adjustmovespeed(param_00, param_01) {
  param_00 endon("death");
  if(scripts\engine\utility::istrue(param_01)) {
    wait(0.5);
  }

  param_00.synctransients = "sprint";
  param_00 scripts\asm\asm_bb::bb_requestmovetype("sprint");
}

fight_timer(param_00) {
  wait(param_00);
  level notify("speaker_defense_failed");
  deactivate_dismember_circle_logic();
}

listen_for_circle_kills(param_00, param_01, param_02) {
  level endon("speaker_defense_failed");
  level.circle_arms = 0;
  switch (param_02) {
    case "j_mem_1_place":
      activate_dismember_arm();
      level thread arm_counter(param_00, "add_arm", param_01);
      break;

    case "j_mem_2_place":
      activate_dismember_leg();
      level thread arm_counter(param_00, "add_leg", param_01);
      break;

    case "j_mem_3_place":
      activate_dismember_head();
      level thread arm_counter(param_00, "add_head", param_01);
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

dismember_circle_logic(param_00) {
  level endon("stop_circle_dismember_logic");
  for(;;) {
    level waittill("dismember", var_01, var_02);
    switch (var_02) {
      case 2:
      case 1:
        if(param_00 == "arm") {
          level notify("add_arm", var_01);
        }
        break;

      case 8:
      case 4:
        if(param_00 == "leg") {
          level notify("add_leg", var_01);
        }
        break;

      case 16:
        if(param_00 == "head") {
          level notify("add_head", var_01);
        }
        break;
    }
  }
}

deactivate_dismember_circle_logic() {
  level notify("stop_circle_dismember_logic");
}

arm_counter(param_00, param_01, param_02) {
  level endon("stop_circle_dismember_logic");
  foreach(var_04 in param_02) {
    var_04 thread raise_arm(param_00);
    wait(0.25);
  }

  wait(1);
  foreach(var_04 in param_02) {
    var_04 thread lower_arm(param_00);
    wait(0.25);
  }

  wait(2);
  var_08 = 5;
  var_09 = 5;
  for(;;) {
    level waittill(param_01, var_0A);
    if(level.circle_arms < 10) {
      level.circle_arms++;
      level thread play_fx_and_raise_arm(var_0A, param_02, param_00);
    }

    if(level.circle_arms > 9) {
      break;
    }
  }
}

play_fx_and_raise_arm(param_00, param_01, param_02) {
  zombie_limb_soul_fly_to_arm(param_00.origin, param_01[level.circle_arms - 1]);
  param_01[level.circle_arms - 1] raise_arm(param_02);
}

zombie_limb_soul_fly_to_arm(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  var_02 setModel("tag_origin_soultrail");
  var_03 = level.photo.origin + (0, 0, 20);
  var_04 = var_02.origin;
  var_05 = distance(var_04, var_03);
  var_06 = var_05 / 450;
  if(var_06 < 0.05) {
    var_06 = 0.05;
  }

  var_02 moveto(var_03, var_06);
  var_02 waittill("movedone");
  var_03 = param_01.origin;
  var_04 = var_02.origin;
  var_05 = distance(var_04, var_03);
  var_06 = var_05 / 450;
  if(var_06 < 0.05) {
    var_06 = 0.05;
  }

  var_02 moveto(var_03, var_06);
  var_02 waittill("movedone");
  var_02 delete();
}

zombie_limb_soul_fly_to_photo(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_00);
  var_03 setModel("tag_origin_soultrail");
  var_04 = level.photo.origin;
  var_05 = var_03.origin;
  var_06 = distance(var_05, var_04);
  var_07 = var_06 / 450;
  if(var_07 < 0.05) {
    var_07 = 0.05;
  }

  var_03 moveto(var_04, var_07);
  var_03 waittill("movedone");
  var_08 = "unused";
  param_01 thread lower_arm(var_08);
  if(isDefined(param_02)) {
    return var_03;
  }

  var_03 delete();
}

pick_up_charged_photo(param_00, param_01) {
  level.photo show();
  var_02 = level.photo;
  var_02 setModel(param_01);
  var_02 makeusable();
  var_02 sethintstring(&"CP_RAVE_INSPECT_ITEM");
  var_02 waittill("trigger", var_03);
  var_02 makeunusable();
  if(isDefined(level.photo_soul)) {
    level.photo_soul delete();
  }

  var_02 hide();
  level notify("slasher_photo_taken");
}

time_out_charged_photo(param_00) {
  wait(param_00);
  level notify("slasher_photo_timeout");
}

slasher_fight(param_00, param_01, param_02) {
  var_03 = 1000000;
  var_04 = scripts\engine\utility::getstruct(param_00, "targetname");
  var_05 = spawnfx(level._effect["memory_trap_loop"], var_04.origin + (0, 0, -22));
  playFX(level._effect["slasher_appear"], var_04.origin);
  if(isDefined(level.photo_soul)) {
    level.photo_soul delete();
  }

  level.no_slasher = 0;
  scripts\cp\maps\cp_rave\cp_rave::spawn_slasher_after_timer(0.1, var_04.origin);
  if(isDefined(level.slasher)) {
    level.slasher.precacheleaderboards = 1;
    wait(2);
    playsoundatpos(var_04.origin, "slasher_rave_mode_exit_portal_fx");
    triggerfx(var_05);
    wait(2);
    level.slasher setethereal(0);
    foreach(var_07 in level.players) {
      var_07.unlimited_rave = 0;
      level thread scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(var_07);
    }

    wait(2);
    level.slasher.precacheleaderboards = 0;
    var_05 delete();
    level.slasher_visible_in_normal_mode = 1;
    level.slasher thread get_slasher_death_loc();
    level.slasher thread time_out_slasher_fight(60);
  }
}

time_out_slasher_fight(param_00) {
  wait(param_00);
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

drop_photo_from_slasher(param_00, param_01, param_02) {
  level.photo setModel(param_01);
  level.photo show();
  level thread scripts\cp\loot::drop_loot(level.slasher_drop, undefined, "ammo_max");
  var_03 = spawn("script_model", level.photo.origin);
  var_03 setModel("tag_origin_soultrail");
  level.photo makeusable();
  level.photo sethintstring(&"CP_RAVE_INSPECT_ITEM");
  level.photo waittill("trigger", var_04);
  level.photo hide();
  var_03 delete();
  if(param_01 == "cp_rave_quest_photo_03") {
    scripts\engine\utility::flag_set("photo_1_kev_given");
    if(level.slasher_level < 2) {
      level.slasher_level = 2;
    }

    play_jay_memory_after_slasher_fight("m10_jmewes_bff_2");
  } else if(param_01 == "cp_rave_quest_photo_04") {
    scripts\engine\utility::flag_set("photo_2_kev_given");
    if(level.slasher_level < 3) {
      level.slasher_level = 3;
    }

    play_jay_memory_after_slasher_fight("m11_jmewes_bff_2");
  } else {
    play_jay_memory_after_slasher_fight("m12_jmewes_bff_2");
  }

  level.circle_fight_done[param_02] = 1;
}

give_thing_to_kev(param_00) {
  if(param_00 == "j_mem_1_give") {
    scripts\engine\utility::flag_wait("photo_1_kev_vo_done");
  } else if(param_00 == "j_mem_2_give") {
    scripts\engine\utility::flag_wait("photo_2_kev_vo_done");
  }

  if(!isDefined(level.j_mem_complete)) {
    level.j_mem_complete = [];
  }

  level.j_mem_complete[param_00] = self;
}

play_j_mem_vo(param_00, param_01) {
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("m" + param_00 + "_jmewes_bff_" + param_01);
  wait(scripts\cp\cp_vo::get_sound_length("m" + param_00 + "_jmewes_bff_" + param_01));
}

play_jay_memory_pickup(param_00, param_01) {
  thread scripts\cp\cp_vo::try_to_play_vo(param_00, "rave_comment_vo");
  wait(scripts\cp\cp_vo::get_sound_length(self.vo_prefix + param_00));
  wait(1);
  foreach(var_03 in level.players) {
    var_03 thread scripts\cp\cp_vo::try_to_play_vo(param_01, "rave_memory_vo");
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

play_jay_memory_after_slasher_fight(param_00) {
  foreach(var_02 in level.players) {
    var_02 thread scripts\cp\cp_vo::try_to_play_vo(param_00, "rave_memory_vo");
  }
}

play_jay_memory_to_kev(param_00) {
  var_01 = 1;
  if(scripts\engine\utility::flag("photo_2_kev_vo_done")) {
    var_01 = 3;
  } else if(scripts\engine\utility::flag("photo_1_kev_vo_done")) {
    var_01 = 2;
  }

  var_02 = "memento_";
  thread scripts\cp\cp_vo::try_to_play_vo(var_02 + var_01 + 3, "rave_comment_vo");
  wait(scripts\cp\cp_vo::get_sound_length(self.vo_prefix + var_02 + var_01 + 3));
  thread scripts\cp\cp_vo::try_to_play_vo("ks_" + var_02 + "quest_" + var_01, "rave_ks_vo");
  wait(scripts\cp\cp_vo::get_sound_length("ks_" + var_02 + "quest_" + var_01));
  wait(2);
  thread scripts\cp\cp_vo::try_to_play_vo("ks_" + var_02 + var_01, "rave_ks_vo");
  wait(scripts\cp\cp_vo::get_sound_length("ks_" + var_02 + var_01));
  level thread scripts\cp\maps\cp_rave\cp_rave_interactions::add_back_to_interaction_system(param_00, "");
}