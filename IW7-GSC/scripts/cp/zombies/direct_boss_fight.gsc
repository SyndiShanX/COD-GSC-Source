/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\direct_boss_fight.gsc
****************************************************/

init() {
  check_direct_boss_fight();
  level thread init_boss_fight_data();
  if(should_directly_go_to_boss_fight()) {
    level.disable_start_spawn_on_navmesh = 1;
    level.bosstimer = 0;
    level.getspawnpoint = ::get_direct_to_boss_spawn_point;
    level.calculate_time_survived_func = ::get_direct_boss_fight_time_survived;
    level.disableplayerdamage = 1;
    level.disable_consumables = 1;
    set_up_perk_purchase_board();
    set_up_weapon_purchase_board();
    level thread create_activation_interaction();
    level thread disable_things_in_afterlife_arcade();
    level thread level_specific_setup();
    level thread run_pre_match_timer();
    setnojiptime(1);
    setnojipscore(1);
  }
}

init_boss_fight_data() {
  wait(15);
  scripts\cp\zombies\zombie_analytics::log_using_boss_fight_playlist(0);
  scripts\cp\zombies\zombie_analytics::log_boss_fight_result(0);
  if(should_directly_go_to_boss_fight()) {
    scripts\cp\zombies\zombie_analytics::log_using_boss_fight_playlist(1);
  }
}

check_direct_boss_fight() {
  if(direct_boss_fight_activated()) {
    activate_direct_to_boss_fight();
  }
}

should_directly_go_to_boss_fight() {
  return scripts\engine\utility::istrue(level.direct_to_boss_fight);
}

activate_direct_to_boss_fight() {
  level.direct_to_boss_fight = 1;
}

get_direct_to_boss_fight_starting_currency() {
  return 20000;
}

get_direct_to_boss_spawn_point() {
  var_00 = self;
  var_01 = scripts\engine\utility::getstructarray("afterlife_arcade", "targetname");
  if(isDefined(level.additional_afterlife_arcade_start_point)) {
    var_01 = scripts\engine\utility::array_combine(var_01, level.additional_afterlife_arcade_start_point);
  }

  return var_01[var_00 getentitynumber()];
}

disable_things_in_afterlife_arcade() {
  level endon("game_ended");
  var_00 = 9;
  var_01 = ["afterlife_spectate_door", "afterlife_selfrevive_door", "basketball_game_afterlife", "laughingclown_afterlife", "clown_tooth_game_afterlife", "game_race", "bowling_for_planets_afterlife", "shooting_gallery_afterlife", "arcade_icehock", "arcade_hero", "arcade_seaques", "arcade_boxing", "arcade_oink", "arcade_crackpo", "arcade_plaque", "arcade_keyston", "arcade_spider", "arcade_robottank", "arcade_riverraid", "arcade_pitfall", "arcade_demon", "arcade_barnstorming", "arcade_starmaster", "arcade_cosmic"];
  wait(var_00);
  foreach(var_03 in var_01) {
    var_04 = scripts\engine\utility::getstructarray(var_03, "script_noteworthy");
    foreach(var_06 in var_04) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_06);
      if(var_03 == "shooting_gallery_afterlife") {
        var_06.var_13C2C hide();
      }
    }
  }
}

enable_things_in_afterlife_arcade() {
  var_00 = ["afterlife_spectate_door", "afterlife_selfrevive_door", "basketball_game_afterlife", "laughingclown_afterlife", "clown_tooth_game_afterlife", "game_race", "bowling_for_planets_afterlife", "shooting_gallery_afterlife", "arcade_icehock", "arcade_hero", "arcade_seaques", "arcade_boxing", "arcade_oink", "arcade_crackpo", "arcade_plaque", "arcade_keyston", "arcade_spider", "arcade_robottank", "arcade_riverraid", "arcade_pitfall", "arcade_demon", "arcade_barnstorming", "arcade_starmaster", "arcade_cosmic"];
  foreach(var_02 in var_00) {
    var_03 = scripts\engine\utility::getstructarray(var_02, "script_noteworthy");
    foreach(var_05 in var_03) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_05);
      if(var_02 == "shooting_gallery_afterlife") {
        var_05.var_13C2C show();
      }
    }
  }
}

direct_boss_fight_activated() {
  switch (level.script) {
    case "cp_zmb":
      if(getdvarint("scr_direct_to_grey", 0) != 0) {
        return 1;
      } else {
        return 0;
      }

      break;

    case "cp_rave":
      if(getdvarint("scr_direct_to_super_slasher", 0) != 0) {
        return 1;
      } else {
        return 0;
      }

      break;

    case "cp_disco":
      if(getdvarint("scr_direct_to_rat_king", 0) != 0) {
        return 1;
      } else {
        return 0;
      }

      break;

    case "cp_town":
      if(getdvarint("scr_direct_to_crab_boss", 0) != 0) {
        return 1;
      } else {
        return 0;
      }

      break;

    case "cp_final":
      if(getdvarint("scr_direct_to_rhino_fight", 0) != 0 || getdvarint("scr_direct_to_meph_fight", 0) != 0) {
        return 1;
      } else {
        return 0;
      }

      break;

    default:
      return 0;
  }
}

is_meph_fight() {
  return getdvarint("scr_direct_to_meph_fight", 0) != 0;
}

set_up_perk_purchase_board() {
  create_perk_purchase_board();
  create_perk_purchase_candy_boxes();
  level thread create_perk_purchase_interaction();
  level thread create_perk_purchase_light();
}

clean_up_perk_purchase_board() {
  level.perk_purchase_board delete();
  foreach(var_01 in level.perk_purchase_structs) {
    var_01.candy_box delete();
  }

  if(isDefined(level.perk_purchase_light_fx)) {
    level.perk_purchase_light_fx delete();
  }

  foreach(var_04 in level.perk_purchase_interactions) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_04);
  }
}

clean_up_weapon_purchase_board() {
  level notify("stop_weapon_purchase_board");
  foreach(var_01 in level.weapon_purchase_interactions) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_01);
  }

  foreach(var_04 in level.weapon_purchase_boards) {
    var_04 delete();
  }

  if(isDefined(level.weapon_board_light_vfx)) {
    foreach(var_07 in level.weapon_board_light_vfx) {
      var_07 delete();
    }
  }

  foreach(var_0A in level.weapon_purchase_models) {
    var_0A delete();
  }
}

clean_up_activation_interaction() {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.boss_fight_activation_interaction);
}

create_perk_purchase_candy_boxes() {
  level.perk_purchase_structs = [];
  var_00 = get_perk_list();
  var_01 = var_00.size;
  foreach(var_04, var_03 in var_00) {
    create_perk_purchase_candy_box(var_04, var_03, var_01);
  }
}

create_perk_purchase_candy_box(param_00, param_01, param_02) {
  var_03 = get_candy_box_struct_loc(param_00, param_02);
  var_04 = spawnStruct();
  var_04.origin = var_03;
  var_05 = spawn("script_model", get_candy_box_loc(var_03));
  var_05 setModel(get_perk_box_model(param_01));
  var_05.angles = vectortoangles(anglesToForward(level.perk_purchase_board.angles) * -1);
  var_05.var_C71F = var_05.angles;
  var_05.var_C725 = var_05.origin;
  var_05.perk = param_01;
  var_05 rotateroll(90, 0.1);
  var_04.candy_box = var_05;
  level.perk_purchase_structs[level.perk_purchase_structs.size] = var_04;
}

get_candy_box_loc(param_00) {
  var_01 = 0.25;
  var_02 = 3.1;
  var_03 = anglestoup(level.perk_purchase_board.angles);
  var_04 = anglestoright(level.perk_purchase_board.angles);
  var_05 = var_03 * -1 * var_01;
  var_06 = var_04 * var_02;
  return param_00 + var_05 + var_06;
}

get_candy_box_struct_loc(param_00, param_01) {
  var_02 = 2;
  var_03 = 20.25;
  var_04 = 5.1;
  var_05 = 11;
  var_06 = 0.8;
  var_07 = 40;
  var_08 = anglestoup(level.perk_purchase_board.angles);
  var_09 = anglestoright(level.perk_purchase_board.angles) * -1;
  var_0A = anglesToForward(level.perk_purchase_board.angles) * -1;
  var_0B = level.perk_purchase_board.origin + var_08 * var_03 + var_09 * var_04;
  var_0C = var_07 / ceil(param_01 / var_02 - 1);
  var_0D = floor(param_00 / var_02) * var_0C * var_08 * -1;
  var_0E = param_00 % var_02 * var_05 * var_09 * -1;
  var_0F = var_0A * var_06;
  return var_0B + var_0D + var_0E + var_0F;
}

create_perk_purchase_board() {
  var_00 = "p7_cafe_wall_menu_01";
  var_01 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_02 = anglesToForward(var_01.angles);
  var_03 = anglestoright(var_01.angles) * -1;
  var_04 = spawn("script_model", var_01.origin + var_02 * get_board_forward_dist() + var_03 * get_board_left_dist());
  var_04 setModel(var_00);
  var_04.angles = var_01.angles;
  var_04 thread player_use_monitor(var_04);
  level.perk_purchase_board = var_04;
}

player_use_monitor(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  wait(5);
  for(;;) {
    foreach(var_02 in level.players) {
      if(in_perk_purchase_range(param_00, var_02)) {
        check_candy_box_looking_at(var_02);
        continue;
      }

      clear_candy_box_looking_at(var_02);
    }

    scripts\engine\utility::waitframe();
  }
}

check_candy_box_looking_at(param_00) {
  var_01 = [];
  foreach(var_03 in level.perk_purchase_structs) {
    if(param_00 worldpointinreticle_circle(var_03.origin, 35, 75)) {
      var_01[var_01.size] = var_03.candy_box;
    }
  }

  if(var_01.size == 0) {
    clear_candy_box_looking_at(param_00);
    return;
  }

  var_05 = sortbydistance(var_01, param_00 getEye())[0];
  if(isDefined(param_00.candy_box_looking_at)) {
    if(var_05 == param_00.candy_box_looking_at) {
      return;
    }

    clear_candy_box_looking_at(param_00);
    mark_candy_box_looking_at(var_05, param_00);
    return;
  }

  mark_candy_box_looking_at(var_05, param_00);
}

mark_candy_box_looking_at(param_00, param_01) {
  param_00 hudoutlineenableforclient(param_01, 3, 1, 0);
  param_01.candy_box_looking_at = param_00;
  param_01 scripts\cp\cp_interaction::refresh_interaction();
  push_candy_box_forward(param_00);
}

push_candy_box_forward(param_00) {
  var_01 = 4;
  if(!isDefined(param_00.num_times_being_looked_at)) {
    param_00.num_times_being_looked_at = 0;
  }

  param_00.num_times_being_looked_at++;
  if(param_00.num_times_being_looked_at == 1) {
    var_02 = anglesToForward(level.perk_purchase_board.angles) * -1;
    param_00.origin = param_00.origin + var_02 * var_01;
  }
}

clear_candy_box_looking_at(param_00) {
  if(isDefined(param_00.candy_box_looking_at)) {
    push_candy_box_back(param_00.candy_box_looking_at);
    param_00.candy_box_looking_at hudoutlinedisableforclient(param_00);
    param_00.candy_box_looking_at = undefined;
    param_00 scripts\cp\cp_interaction::refresh_interaction();
  }
}

push_candy_box_back(param_00) {
  param_00.num_times_being_looked_at--;
  if(param_00.num_times_being_looked_at == 0) {
    param_00.origin = param_00.var_C725;
  }
}

in_perk_purchase_range(param_00, param_01) {
  return distance2dsquared(param_00.origin, param_01.origin) <= 8100;
}

create_perk_purchase_interaction() {
  level endon("game_ended");
  wait(5);
  level.perk_purchase_interactions = [];
  var_00 = anglesToForward(level.perk_purchase_board.angles) * -1;
  var_01 = anglestoright(level.perk_purchase_board.angles);
  set_up_perk_purchase_interaction_at(scripts\engine\utility::drop_to_ground(level.perk_purchase_board.origin + var_00 * 1, 0, -200));
}

set_up_perk_purchase_interaction_at(param_00) {
  var_01 = spawnStruct();
  var_01.name = "perk_purchase";
  var_01.script_noteworthy = "perk_purchase";
  var_01.origin = param_00;
  var_01.cost = 0;
  var_01.powered_on = 1;
  var_01.spend_type = undefined;
  var_01.script_parameters = "";
  var_01.requires_power = 0;
  var_01.hint_func = ::perk_purchase_hint_func;
  var_01.activation_func = ::try_perk_purchase;
  var_01.enabled = 1;
  var_01.disable_guided_interactions = 1;
  var_01.custom_search_dist = 100;
  level.interactions["perk_purchase"] = var_01;
  level.perk_purchase_interactions[level.perk_purchase_interactions.size] = var_01;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
}

perk_purchase_hint_func(param_00, param_01) {
  if(!isDefined(param_01.candy_box_looking_at)) {
    return "";
  }

  if(scripts\engine\utility::istrue(param_01.kung_fu_mode)) {
    return "";
  }

  var_02 = param_01.candy_box_looking_at.perk;
  if(param_01 scripts\cp\utility::has_zombie_perk(var_02)) {
    return & "COOP_PERK_MACHINES_REMOVE_PERK";
  }

  if(isDefined(param_01.zombies_perks) && param_01.zombies_perks.size > 20 && !scripts\engine\utility::istrue(param_01.have_gns_perk)) {
    return & "COOP_PERK_MACHINES_PERK_SLOTS_FULL";
  }

  var_03 = get_perk_cost(var_02);
  if(param_01 scripts\cp\cp_persistence::get_player_currency() < var_03) {
    return & "COOP_INTERACTIONS_NEED_MONEY";
  }

  if(var_02 == "perk_machine_revive" && scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return & "COOP_PERK_MACHINES_SELF_REVIVE";
  }

  return level.interaction_hintstrings[var_02];
}

try_perk_purchase(param_00, param_01) {
  if(!isDefined(param_01.candy_box_looking_at)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_01.kung_fu_mode)) {
    return;
  }

  param_01 thread perk_purchase_internal(param_01);
}

perk_purchase_internal(param_00) {
  param_00 endon("disconnect");
  if(is_meph_fight() && !scripts\engine\utility::istrue(param_00.have_permanent_perks)) {
    param_00.have_permanent_perks = 1;
  }

  var_01 = param_00.candy_box_looking_at.perk;
  var_02 = get_perk_cost(var_01);
  if(param_00 scripts\cp\utility::has_zombie_perk(var_01)) {
    if(soundexists("perk_machine_remove_perk")) {
      param_00 playlocalsound("perk_machine_remove_perk");
    }

    if(!isDefined(self.current_perk_list)) {
      self.current_perk_list = [];
    }

    self.current_perk_list = scripts\engine\utility::array_remove(self.current_perk_list, var_01);
    param_00 scripts\cp\zombies\zombies_perk_machines::take_zombies_perk(var_01);
    param_00 scripts\cp\cp_persistence::give_player_currency(var_02);
    param_00 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(isDefined(param_00.zombies_perks) && param_00.zombies_perks.size > 20 && !scripts\engine\utility::istrue(param_00.have_gns_perk)) {
    return;
  }

  var_02 = get_perk_cost(param_00.candy_box_looking_at.perk);
  if(param_00 scripts\cp\cp_persistence::get_player_currency() < var_02) {
    return;
  }

  param_00 scripts\cp\cp_persistence::take_player_currency(var_02, 1, "perk");
  made_direct_boss_fight_purchase(param_00);
  if(!isDefined(self.current_perk_list)) {
    self.current_perk_list = [];
  }

  self.current_perk_list = scripts\engine\utility::array_add_safe(self.current_perk_list, var_01);
  param_00 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_01, 0);
}

get_board_forward_dist() {
  var_00 = 170;
  var_01 = 158;
  switch (level.script) {
    case "cp_zmb":
      return var_00;

    default:
      return var_01;
  }
}

get_board_left_dist() {
  var_00 = 170;
  var_01 = 107;
  switch (level.script) {
    case "cp_zmb":
      return var_00;

    default:
      return var_01;
  }
}

get_perk_list() {
  var_00 = ["perk_machine_boom", "perk_machine_fwoosh", "perk_machine_flash", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_tough", "perk_machine_run", "perk_machine_revive", "perk_machine_zap"];
  switch (level.script) {
    case "cp_rave":
    case "cp_zmb":
      var_00 = scripts\engine\utility::array_add(var_00, "perk_machine_smack");
      break;

    case "cp_disco":
      var_00 = scripts\engine\utility::array_add(var_00, "perk_machine_deadeye");
      break;

    case "cp_final":
    case "cp_town":
      var_00 = scripts\engine\utility::array_add(var_00, "perk_machine_smack");
      var_00 = scripts\engine\utility::array_add(var_00, "perk_machine_change");
      var_00 = scripts\engine\utility::array_add(var_00, "perk_machine_deadeye");
      break;
  }

  return var_00;
}

get_perk_cost(param_00) {
  switch (param_00) {
    case "perk_machine_revive":
      if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
        return 500;
      } else {
        return 1500;
      }

      break;

    case "perk_machine_deadeye":
    case "perk_machine_zap":
    case "perk_machine_fwoosh":
    case "perk_machine_boom":
    case "perk_machine_change":
      return 1500;

    case "perk_machine_run":
    case "perk_machine_more":
    case "perk_machine_rat_a_tat":
    case "perk_machine_smack":
      return 2000;

    case "perk_machine_tough":
      return 2500;

    case "perk_machine_flash":
      return 3000;
  }
}

get_perk_box_model(param_00) {
  switch (param_00) {
    case "perk_machine_boom":
      return "zmb_candybox_bomb_closed";

    case "perk_machine_flash":
      return "zmb_candybox_quickies_closed";

    case "perk_machine_fwoosh":
      return "zmb_candybox_trail_closed";

    case "perk_machine_more":
      return "zmb_candybox_mule_closed";

    case "perk_machine_rat_a_tat":
      return "zmb_candybox_bang_closed";

    case "perk_machine_revive":
      return "zmb_candybox_up_closed";

    case "perk_machine_run":
      return "zmb_candybox_racin_closed";

    case "perk_machine_deadeye":
      return "cp_disco_candybox_closed";

    case "perk_machine_tough":
      return "zmb_candybox_tuff_closed";

    case "perk_machine_change":
      return "cp_town_candybox_change_closed";

    case "perk_machine_zap":
      return "zmb_candybox_blue_closed";

    case "perk_machine_smack":
      return "zmb_candybox_slappy_closed";
  }
}

create_perk_purchase_light() {
  if(level.script == "cp_town") {
    return;
  }

  wait(5);
  var_00 = anglesToForward(level.perk_purchase_board.angles) * -1;
  var_01 = spawn("script_model", level.perk_purchase_board.origin + var_00 * 20);
  var_01 setModel("direct_boss_fight_origin");
  var_01 setscriptablepartstate("perk_board_light", "on");
  level.perk_purchase_light_fx = var_01;
}

set_up_weapon_purchase_board() {
  create_weapon_purchase_boards();
  level thread create_weapon_purchase_interaction();
  level thread create_weapon_purchase_models();
  level thread create_weapon_board_lights();
  level thread player_weapon_purchase_monitor();
}

player_weapon_purchase_monitor() {
  level endon("game_ended");
  level endon("stop_weapon_purchase_board");
  wait(5);
  var_00 = get_weapon_purchase_range_edge_x_value();
  for(;;) {
    foreach(var_02 in level.players) {
      if(in_weapon_purchase_range(var_02, var_00)) {
        check_weapon_looking_at(var_02);
        continue;
      }

      clear_weapon_looking_at(var_02);
    }

    scripts\engine\utility::waitframe();
  }
}

check_weapon_looking_at(param_00) {
  var_01 = [];
  foreach(var_03 in level.weapon_purchase_structs) {
    if(param_00 worldpointinreticle_circle(var_03.origin, 35, 135)) {
      var_01[var_01.size] = var_03.var_13C2C;
    }
  }

  if(var_01.size == 0) {
    clear_weapon_looking_at(param_00);
    return;
  }

  var_05 = sortbydistance(var_01, param_00 getEye())[0];
  if(isDefined(param_00.weapon_purchase_looking_at)) {
    if(var_05 == param_00.weapon_purchase_looking_at) {
      return;
    }

    clear_weapon_looking_at(param_00);
    mark_weapon_looking_at(var_05, param_00);
    return;
  }

  mark_weapon_looking_at(var_05, param_00);
}

mark_weapon_looking_at(param_00, param_01) {
  param_00 hudoutlineenableforclient(param_01, 3, 1, 0);
  param_01.weapon_purchase_looking_at = param_00;
  param_01 scripts\cp\cp_interaction::refresh_interaction();
  push_weapon_forward(param_00);
}

clear_weapon_looking_at(param_00) {
  if(isDefined(param_00.weapon_purchase_looking_at)) {
    push_weapon_back(param_00.weapon_purchase_looking_at);
    param_00.weapon_purchase_looking_at hudoutlinedisableforclient(param_00);
    param_00.weapon_purchase_looking_at = undefined;
    param_00 scripts\cp\cp_interaction::refresh_interaction();
  }
}

push_weapon_forward(param_00) {
  var_01 = 4;
  if(!isDefined(param_00.num_times_being_looked_at)) {
    param_00.num_times_being_looked_at = 0;
  }

  param_00.num_times_being_looked_at++;
  if(param_00.num_times_being_looked_at == 1) {
    var_02 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
    var_03 = anglestoright(var_02.angles);
    param_00.origin = param_00.origin + var_03 * var_01;
  }
}

push_weapon_back(param_00) {
  param_00.num_times_being_looked_at--;
  if(param_00.num_times_being_looked_at == 0) {
    param_00.origin = param_00.var_C725;
  }
}

get_weapon_purchase_range_edge_x_value() {
  var_00 = 249;
  var_01 = 186;
  var_02 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_03 = anglestoright(var_02.angles) * -1;
  if(level.script == "cp_zmb") {
    var_04 = var_02.origin + var_03 * var_00;
  } else {
    var_04 = var_03.origin + var_04 * var_02;
  }

  return var_04[0];
}

in_weapon_purchase_range(param_00, param_01) {
  return param_00.origin[0] <= param_01;
}

create_weapon_purchase_boards() {
  var_00 = "ch_corkboard_metaltrim_4x8";
  var_01 = 96;
  var_02 = 48;
  var_03 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_04 = anglesToForward(var_03.angles);
  var_05 = anglestoup(var_03.angles);
  level.weapon_purchase_boards = [];
  var_06 = get_weapon_purchase_board_start_pos();
  for(var_07 = 0; var_07 < 2; var_07++) {
    for(var_08 = 0; var_08 < 4; var_08++) {
      var_09 = spawn("script_model", var_06 + var_08 * var_04 * var_01 + var_07 * var_05 * var_02);
      var_09 setModel(var_00);
      var_09.angles = var_03.angles;
      level.weapon_purchase_boards[level.weapon_purchase_boards.size] = var_09;
    }
  }
}

get_weapon_purchase_board_start_pos() {
  var_00 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_01 = anglesToForward(var_00.angles) * -1;
  var_02 = anglestoright(var_00.angles) * -1;
  var_03 = anglestoup(var_00.angles);
  var_04 = get_weapon_purchase_board_back_start_offset();
  var_05 = get_weapon_purchase_board_left_start_offset();
  var_06 = get_weapon_purchase_board_up_start_offset();
  return var_00.origin + var_01 * var_04 + var_02 * var_05 + var_03 * var_06;
}

get_weapon_purchase_board_up_start_offset() {
  var_00 = 10;
  var_01 = 11;
  switch (level.script) {
    case "cp_zmb":
      return var_00;

    default:
      return var_01;
  }
}

get_weapon_purchase_board_back_start_offset() {
  var_00 = 327;
  var_01 = 338;
  switch (level.script) {
    case "cp_zmb":
      return var_00;

    default:
      return var_01;
  }
}

get_weapon_purchase_board_left_start_offset() {
  var_00 = 380;
  var_01 = 317;
  switch (level.script) {
    case "cp_zmb":
      return var_00;

    default:
      return var_01;
  }
}

create_weapon_board_lights() {
  if(level.script == "cp_rave") {
    return;
  }

  wait(5);
  level.weapon_board_light_vfx = [];
  var_00 = 30;
  var_01 = 35;
  var_02 = 96;
  var_03 = 48;
  var_04 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_05 = anglesToForward(var_04.angles);
  var_06 = anglestoright(var_04.angles);
  var_07 = anglestoup(var_04.angles);
  var_08 = get_weapon_purchase_board_start_pos() + var_06 * var_01;
  for(var_09 = 0; var_09 < 2; var_09++) {
    for(var_0A = 0; var_0A < 4; var_0A++) {
      var_0B = var_08 + var_05 * var_02 * var_0A + var_07 * var_03 * var_09;
      if(var_0A == 0) {
        var_0B = var_0B + var_05 * var_00;
      }

      var_0B = spawn("script_model", var_0B);
      var_0B setModel("direct_boss_fight_origin");
      var_0B setscriptablepartstate("weapon_board_light", "on");
      level.weapon_board_light_vfx[level.weapon_board_light_vfx.size] = var_0B;
    }
  }
}

create_weapon_purchase_models() {
  level endon("game_ended");
  wait(3);
  level.weapon_purchase_structs = [];
  level.weapon_purchase_models = [];
  var_00 = get_weapon_list();
  var_01 = get_weapon_model_start_pos();
  var_02 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_03 = anglesToForward(var_02.angles);
  var_04 = anglestoup(var_02.angles);
  var_05 = 0;
  foreach(var_07 in var_00) {
    create_weapon_purchase_model(var_07, get_weapon_model_pos(var_01, var_03, var_04, var_05), var_02.angles);
    var_05++;
    if(var_05 == 30) {
      return;
    }

    wait(0.2);
  }
}

get_weapon_list() {
  switch (level.script) {
    case "cp_zmb":
      return ["iw7_kbs_zm", "iw7_dischord_zm", "iw7_facemelter_zm", "iw7_headcutter_zm", "iw7_shredder_zm", "iw7_m8_zm", "iw7_longshot_zm", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_sdflmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_ake_zml", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_ump45c_zm", "iw7_sdfshotty_zm", "iw7_spas_zmr", "iw7_devastator_zm", "iw7_g18_zmr"];

    case "cp_rave":
      return ["iw7_kbs_zm", "iw7_harpoon1_zm", "iw7_harpoon2_zm", "iw7_harpoon3_zm+akimbo", "iw7_harpoon4_zm", "iw7_m8_zm", "iw7_longshot_zm", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_sdflmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_ake_zml", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_ump45c_zm", "iw7_sdfshotty_zm", "iw7_spas_zmr", "iw7_devastator_zm", "iw7_g18_zmr"];

    case "cp_disco":
      return ["iw7_katana_zm_pap1", "crane", "snake", "dragon", "tiger", "iw7_nunchucks_zm_pap2", "iw7_longshot_zm", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_sdflmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_ake_zml", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_ump45c_zm", "iw7_sdfshotty_zm", "iw7_spas_zmr", "iw7_devastator_zm", "iw7_g18_zmr"];

    case "cp_town":
      return ["iw7_kbs_zm", "iw7_longshot_zm", "iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger", "iw7_gauss_zm", "iw7_cheytac_zmr", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_sdfshotty_zm", "iw7_devastator_zm", "iw7_g18_zmr"];

    case "cp_final":
      return ["iw7_kbs_zm", "iw7_longshot_zm", "iw7_venomx_zm_pap2", "iw7_gauss_zm", "iw7_cheytac_zmr", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_sdfshotty_zm", "iw7_devastator_zm", "iw7_g18_zmr"];
  }
}

get_weapon_model_pos(param_00, param_01, param_02, param_03) {
  var_04 = 55;
  var_05 = 6;
  var_06 = param_03 % var_05;
  var_07 = floor(param_03 / var_05);
  return param_00 + var_06 * var_04 * param_01 + var_07 * get_vertical_space() * param_02;
}

get_vertical_space() {
  switch (level.script) {
    case "cp_final":
    case "cp_town":
      return 22;

    default:
      return 18;
  }
}

get_weapon_model_start_pos() {
  var_00 = 3;
  var_01 = 32;
  var_02 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_03 = anglesToForward(var_02.angles);
  var_04 = anglestoright(var_02.angles);
  var_05 = anglestoup(var_02.angles) * -1;
  var_06 = get_start_down_offset();
  var_07 = get_weapon_purchase_board_start_pos();
  return var_07 + var_04 * var_00 + var_03 * var_01 + var_05 * var_06;
}

get_start_down_offset() {
  switch (level.script) {
    case "cp_final":
    case "cp_town":
      return 7;

    default:
      return 10;
  }
}

create_weapon_purchase_model(param_00, param_01, param_02) {
  if(is_kung_fu(param_00)) {
    var_03 = spawn("script_model", param_01);
    var_03 setModel(get_gourd_model(param_00));
    var_04 = vectortoangles(anglestoright(param_02) * -1);
    var_03.angles = var_04;
    var_03.var_C725 = var_03.origin;
    var_03.var_39C = param_00;
    var_03.weapontogive = param_00;
  } else {
    var_05 = scripts\cp\utility::getrawbaseweaponname(param_01);
    var_06 = "none";
    var_07 = undefined;
    var_08 = 0;
    var_09 = param_00;
    var_0A = level.players[0];
    var_07 = level.pap_2_camo;
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_05)) {
      var_07 = undefined;
    }

    if(isDefined(var_05)) {
      switch (var_05) {
        case "dischord":
          param_00 = "iw7_dischord_zm";
          var_07 = undefined;
          break;

        case "facemelter":
          param_00 = "iw7_facemelter_zm";
          var_07 = undefined;
          break;

        case "headcutter":
          param_00 = "iw7_headcutter_zm";
          var_07 = undefined;
          break;

        case "shredder":
          param_00 = "iw7_shredder_zm";
          var_07 = undefined;
          break;

        case "harpoon1":
          param_00 = "iw7_harpoon1_zm";
          var_07 = undefined;
          break;

        case "harpoon2":
          param_00 = "iw7_harpoon2_zm";
          var_07 = undefined;
          break;

        case "harpoon3":
          param_00 = "iw7_harpoon3_zm+akimbo";
          var_07 = undefined;
          break;

        case "harpoon4":
          param_00 = "iw7_harpoon4_zm";
          var_07 = undefined;
          break;

        default:
          break;
      }
    }

    if(var_05 == "axe") {
      param_00 = "iw7_axe_zm_pap2";
      var_08 = 1;
    }

    if(var_05 == "nunchucks") {
      param_00 = "iw7_nunchucks_zm_pap2";
      var_08 = 1;
    }

    if(var_05 == "katana") {
      param_00 = "iw7_katana_zm_pap1";
      var_07 = "camo222";
      var_0B = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
      var_0C = anglesToForward(var_0B.angles);
      var_0D = var_0C * -1;
      param_01 = param_01 + var_0D * 10;
      var_08 = 1;
    }

    if(var_05 == "venomx") {
      param_00 = "iw7_venomx_zm_pap2";
      var_08 = 1;
    }

    if(var_05 == "forgefreeze") {
      param_00 = "iw7_forgefreeze_zm_pap2";
      var_08 = 1;
    }

    if(var_05 == "cutie") {
      param_00 = "iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger";
      var_07 = undefined;
      var_08 = 1;
    }

    var_06 = return_pap_attachment(var_05);
    if(isDefined(var_06) && var_06 == "replace_me") {
      var_06 = undefined;
    }

    var_0E = getweaponattachments(param_00);
    if(issubstr(param_00, "g18_z")) {
      foreach(var_10 in var_0E) {
        if(issubstr(var_10, "akimbo")) {
          var_0E = scripts\engine\utility::array_remove(var_0E, var_10);
        }
      }
    }

    var_12 = var_0E;
    foreach(var_10 in var_12) {
      if(issubstr(var_10, "silencer") || issubstr(var_10, "arcane") || issubstr(var_10, "ark")) {
        var_12 = scripts\engine\utility::array_remove(var_12, var_10);
      }
    }

    if(is_wonder_weapon(param_00)) {
      var_15 = param_00;
      var_16 = param_00;
      if(isDefined(var_07)) {
        var_15 = var_15 + "+" + var_07;
        var_16 = var_16 + "+" + var_07;
      }
    } else {
      param_02 = var_12 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(param_02, undefined, var_10);
      var_15 = var_12 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(param_02, var_08, var_10, undefined, var_09);
      var_16 = var_0E scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(param_01, var_07, var_12, undefined, var_08);
    }

    if(var_08) {
      var_03 = spawn("script_weapon", param_01, 0, 0, var_09);
    } else {
      var_03 = spawn("script_weapon", param_01, 0, 0, param_00);
    }

    var_03.angles = get_weapon_model_angles(param_00, param_02);
    var_03 setmoverweapon(var_15);
    var_03.var_C725 = var_03.origin;
    var_03.var_39C = param_00;
    var_03.weapontogive = var_16;
    var_03.camotogive = var_07;
  }

  var_17 = spawnStruct();
  var_17.origin = param_01;
  var_17.var_39C = param_00;
  var_17.var_13C2C = var_03;
  level.weapon_purchase_structs[level.weapon_purchase_structs.size] = var_17;
  level.weapon_purchase_models[level.weapon_purchase_models.size] = var_03;
}

get_weapon_model_angles(param_00, param_01) {
  if(issubstr(param_00, "nunchuck")) {
    return (0, 0, 90);
  }

  if(issubstr(param_00, "katana")) {
    return (90, 0, -90);
  }

  return param_01;
}

is_kung_fu(param_00) {
  switch (param_00) {
    case "tiger":
    case "snake":
    case "crane":
    case "dragon":
      return 1;

    default:
      return 0;
  }
}

get_kung_fu_string(param_00) {
  switch (param_00) {
    case "snake":
      return & "CP_DISCO_CHALLENGES_SNAKE";

    case "tiger":
      return & "CP_DISCO_CHALLENGES_TIGER";

    case "crane":
      return & "CP_DISCO_CHALLENGES_CRANE";

    case "dragon":
      return & "CP_DISCO_CHALLENGES_DRAGON";
  }
}

get_gourd_model(param_00) {
  switch (param_00) {
    case "crane":
      return "weapon_zmb_gourd_crane_wm";

    case "snake":
      return "weapon_zmb_gourd_snake_wm";

    case "dragon":
      return "weapon_zmb_gourd_dragon_wm";

    case "tiger":
      return "weapon_zmb_gourd_tiger_wm";
  }
}

is_wonder_weapon(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  switch (param_00) {
    case "iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger":
    case "iw7_harpoon4_zm":
    case "iw7_harpoon3_zm+akimbo":
    case "iw7_harpoon2_zm":
    case "iw7_harpoon1_zm":
    case "iw7_venomx_zm_pap2":
    case "iw7_headcutter_zm":
    case "iw7_facemelter_zm":
    case "iw7_dischord_zm":
    case "iw7_shredder_zm":
      return 1;

    default:
      return 0;
  }
}

return_pap_attachment(param_00) {
  var_01 = undefined;
  if(isDefined(param_00)) {
    switch (param_00) {
      case "spiked":
      case "golf":
      case "two":
      case "machete":
      case "katana":
      case "nunchucks":
        return "replace_me";

      default:
        return "pap2";
    }
  }

  return var_01;
}

create_weapon_purchase_interaction() {
  level endon("game_ended");
  var_00 = 55;
  var_01 = 78;
  var_02 = 75;
  wait(5);
  level.weapon_purchase_interactions = [];
  var_03 = get_weapon_purchase_board_start_pos();
  var_04 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_05 = anglesToForward(var_04.angles);
  var_06 = anglestoright(var_04.angles);
  var_07 = var_03 + var_05 * var_00 + var_06 * var_01;
  var_07 = scripts\engine\utility::drop_to_ground(var_07, 0, -200);
  for(var_08 = 0; var_08 < 5; var_08++) {
    set_up_weapon_purchase_interaction_at(var_07 + var_08 * var_05 * var_02);
  }
}

set_up_weapon_purchase_interaction_at(param_00) {
  var_01 = spawnStruct();
  var_01.name = "weapon_purchase";
  var_01.script_noteworthy = "weapon_purchase";
  var_01.origin = param_00;
  var_01.cost = 0;
  var_01.powered_on = 1;
  var_01.spend_type = undefined;
  var_01.script_parameters = "";
  var_01.requires_power = 0;
  var_01.hint_func = ::weapon_purchase_hint_func;
  var_01.activation_func = ::try_weapon_purchase;
  var_01.enabled = 1;
  var_01.disable_guided_interactions = 1;
  var_01.custom_search_dist = 400;
  level.interactions["weapon_purchase"] = var_01;
  level.weapon_purchase_interactions[level.weapon_purchase_interactions.size] = var_01;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
}

weapon_purchase_hint_func(param_00, param_01) {
  if(!isDefined(param_01.weapon_purchase_looking_at)) {
    return "";
  }

  if(scripts\engine\utility::istrue(param_01.kung_fu_mode)) {
    return "";
  }

  if(is_kung_fu(param_01.weapon_purchase_looking_at.var_39C)) {
    var_02 = [[level.direct_boss_get_kung_fu_func]](param_01);
    if(isDefined(var_02) && var_02 == param_01.weapon_purchase_looking_at.var_39C) {
      return "";
    }

    return & "CP_DISCO_CHALLENGES_DRINK_GOURD";
  }

  if(!have_weapon(param_01, param_01.weapon_purchase_looking_at.weapontogive)) {
    if(param_01 scripts\cp\cp_persistence::get_player_currency() < get_weapon_cost(param_01.weapon_purchase_looking_at.weapontogive)) {
      return & "COOP_INTERACTIONS_NEED_MONEY";
    }

    switch (level.script) {
      case "cp_zmb":
        return & "CP_ZMB_INTERACTIONS_BUY_WEAPON";

      case "cp_rave":
        return & "CP_RAVE_BUY_WEAPON";

      case "cp_disco":
        return & "CP_DISCO_INTERACTIONS_BUY_WEAPON";

      case "cp_town":
        return & "CP_TOWN_INTERACTIONS_BUY_WEAPON";

      case "cp_final":
        return & "CP_TOWN_INTERACTIONS_BUY_WEAPON";
    }

    return;
  }

  return & "DIRECT_BOSS_FIGHT_WEAPON_REFUND";
}

have_weapon(param_00, param_01, param_02) {
  var_03 = scripts\cp\utility::getbaseweaponname(param_01);
  if(isDefined(param_00.default_starting_pistol) && getweaponbasename(param_00.default_starting_pistol) == var_03) {
    if(!scripts\engine\utility::istrue(param_00.has_replaced_starting_pistol)) {
      return 0;
    }
  }

  var_04 = param_00 getweaponslistall();
  foreach(var_06 in var_04) {
    if(var_03 == scripts\cp\utility::getbaseweaponname(var_06)) {
      return 1;
    }
  }

  return 0;
}

try_weapon_purchase(param_00, param_01) {
  if(!isDefined(param_01.weapon_purchase_looking_at)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_01.kung_fu_mode)) {
    return "";
  }

  if(is_kung_fu(param_01.weapon_purchase_looking_at.weapontogive)) {
    var_02 = [[level.direct_boss_get_kung_fu_func]](param_01);
    if(isDefined(var_02) && var_02 == param_01.weapon_purchase_looking_at.var_39C) {
      return;
    }

    [[level.direct_boss_give_kung_fu_func]](param_01.weapon_purchase_looking_at.weapontogive, param_01);
    return;
  }

  if(have_weapon(param_01, param_01.weapon_purchase_looking_at.weapontogive, 1)) {
    direct_boss_refund_weapon(param_01);
    return;
  }

  direct_boss_purchase_weapon(param_01);
}

direct_boss_purchase_weapon(param_00) {
  if(param_00 scripts\cp\cp_persistence::get_player_currency() < get_weapon_cost(param_00.weapon_purchase_looking_at.weapontogive)) {
    return;
  }

  made_direct_boss_fight_purchase(param_00);
  param_00 scripts\cp\cp_persistence::take_player_currency(get_weapon_cost(param_00.weapon_purchase_looking_at.weapontogive), 1, "weapon");
  take_fists_weapon(param_00);
  var_01 = param_00.weapon_purchase_looking_at.weapontogive;
  if(param_00 scripts\cp\cp_weapon::has_weapon_variation(var_01)) {
    var_02 = scripts\cp\utility::getrawbaseweaponname(var_01);
    foreach(var_04 in param_00 getweaponslistall()) {
      var_05 = scripts\cp\utility::getrawbaseweaponname(var_04);
      if(var_02 == var_05) {
        param_00 takeweapon(var_04);
      }
    }
  }

  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(param_00)) {
    var_07 = param_00 getcurrentweapon();
    var_08 = scripts\cp\utility::getrawbaseweaponname(var_07);
    param_00 takeweapon(var_07);
  }

  param_00 notify("weapon_taken");
  if(isDefined(param_00.default_starting_pistol) && getweaponbasename(param_00.default_starting_pistol) == getweaponbasename(var_01)) {
    if(!scripts\engine\utility::istrue(param_00.has_replaced_starting_pistol)) {
      param_00.has_replaced_starting_pistol = 1;
    }
  }

  var_01 = apply_weapon_build_kit_options(var_01, param_00.weapon_purchase_looking_at.camotogive, param_00);
  var_01 = param_00 scripts\cp\utility::_giveweapon(var_01, undefined, undefined, 0);
  param_00 givemaxammo(var_01);
  var_09 = param_00 getweaponslistprimaries();
  foreach(var_04 in var_09) {
    if(issubstr(var_04, var_01)) {
      if(scripts\cp\utility::isaltmodeweapon(var_04)) {
        var_02 = getweaponbasename(var_04);
        if(isDefined(level.mode_weapons_allowed) && scripts\engine\utility::array_contains(level.mode_weapons_allowed, var_02)) {
          var_0B = "alt_" + var_01;
          break;
        }
      }
    }
  }

  param_00 switchtoweapon(var_01);
  var_02 = scripts\cp\utility::getrawbaseweaponname(var_01);
  if(!isDefined(param_00.pap[var_02])) {
    param_00.pap[var_02] = spawnStruct();
  }

  param_00.pap[var_02].lvl = 3;
  param_00 notify("weapon_level_changed");
}

take_fists_weapon(param_00) {
  foreach(var_02 in param_00 getweaponslistall()) {
    if(issubstr(var_02, "iw7_fists")) {
      param_00 takeweapon(var_02);
    }
  }
}

apply_weapon_build_kit_options(param_00, param_01, param_02) {
  var_03 = scripts\cp\utility::getrawbaseweaponname(param_00);
  if(isDefined(param_02.weapon_build_models[var_03])) {
    var_04 = param_02.weapon_build_models[var_03];
    var_05 = getweaponattachments(var_04);
    var_06 = scripts\engine\utility::array_combine(["pap2"], var_05);
    param_00 = param_02 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(getweaponbasename(param_00), undefined, var_06, 1, param_01);
  }

  return param_00;
}

weapon_to_take_for_refund(param_00) {
  var_01 = scripts\cp\utility::getrawbaseweaponname(param_00.weapon_purchase_looking_at.weapontogive);
  var_02 = param_00 getweaponslistall();
  foreach(var_04 in var_02) {
    if(issubstr(var_04, var_01)) {
      return var_04;
    }
  }
}

direct_boss_refund_weapon(param_00) {
  var_01 = weapon_to_take_for_refund(param_00);
  param_00 takeweapon(var_01);
  if(should_issue_refund(param_00, var_01)) {
    param_00 scripts\cp\cp_persistence::give_player_currency(get_weapon_cost(param_00.weapon_purchase_looking_at.weapontogive));
  }

  var_02 = param_00 directbossgetvalidtakeweapon();
  if(var_02 != "super_default_zm") {
    param_00 switchtoweapon(var_02);
  }
}

should_issue_refund(param_00, param_01) {
  var_02 = getweaponbasename(param_01);
  if(isDefined(param_00.default_starting_pistol) && getweaponbasename(param_00.default_starting_pistol) == var_02) {
    if(!scripts\engine\utility::istrue(param_00.has_replaced_starting_pistol)) {
      return 0;
    }

    return 1;
  }

  return 1;
}

directbossgetvalidtakeweapon() {
  var_00 = self getcurrentweapon();
  var_01 = 0;
  var_02 = level.additional_laststand_weapon_exclusion;
  if(var_00 == "none") {
    var_01 = 1;
  } else if(scripts\engine\utility::array_contains(var_02, var_00)) {
    var_01 = 1;
  } else if(scripts\engine\utility::array_contains(var_02, getweaponbasename(var_00))) {
    var_01 = 1;
  } else if(scripts\cp\utility::is_melee_weapon(var_00, 1)) {
    var_01 = 1;
  }

  if(isDefined(self.last_valid_weapon) && self hasweapon(self.last_valid_weapon) && var_01) {
    var_00 = self.last_valid_weapon;
    if(var_00 == "none") {
      var_01 = 1;
    } else if(scripts\engine\utility::array_contains(var_02, var_00)) {
      var_01 = 1;
    } else if(scripts\engine\utility::array_contains(var_02, getweaponbasename(var_00))) {
      var_01 = 1;
    } else if(scripts\cp\utility::is_melee_weapon(var_00, 1)) {
      var_01 = 1;
    } else {
      var_01 = 0;
    }
  }

  if(var_01) {
    var_03 = self getweaponslistall();
    for(var_04 = 0; var_04 < var_03.size; var_04++) {
      if(var_03[var_04] == "none") {
        continue;
      } else if(scripts\engine\utility::array_contains(var_02, var_03[var_04])) {
        continue;
      } else if(scripts\engine\utility::array_contains(var_02, getweaponbasename(var_03[var_04]))) {
        continue;
      } else if(scripts\cp\utility::is_melee_weapon(var_03[var_04], 1)) {
        continue;
      } else if(var_03[var_04] == "super_default_zm") {
        continue;
      } else if(var_03[var_04] == "frag_grenade_zm") {
        continue;
      } else {
        var_01 = 0;
        var_00 = var_03[var_04];
        break;
      }
    }
  }

  return var_00;
}

create_activation_interaction() {
  level endon("game_ended");
  wait(5);
  var_00 = 130;
  var_01 = 125;
  var_02 = 165;
  var_03 = 228;
  var_04 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_05 = anglesToForward(var_04.angles);
  var_06 = anglestoright(var_04.angles);
  if(level.script == "cp_zmb") {
    var_07 = var_04.origin + var_05 * var_00 + var_06 * var_02;
  } else {
    var_07 = var_05.origin + var_06 * var_02 + var_07 * var_04;
  }

  var_07 = scripts\engine\utility::drop_to_ground(var_07, 0, -300);
  set_up_boss_fight_activation_interaction_at(var_07);
}

set_up_boss_fight_activation_interaction_at(param_00) {
  var_01 = 100;
  var_02 = spawnStruct();
  var_02.name = "boss_fight_activation";
  var_02.script_noteworthy = "boss_fight_activation";
  var_02.origin = param_00;
  var_02.cost = 0;
  var_02.powered_on = 1;
  var_02.spend_type = undefined;
  var_02.script_parameters = "";
  var_02.requires_power = 0;
  var_02.hint_func = ::activate_boss_fight_hint_func;
  var_02.activation_func = ::try_activate_boss_fight;
  var_02.enabled = 1;
  var_02.disable_guided_interactions = 0;
  var_02.custom_search_dist = var_01;
  level.interactions["boss_fight_activation"] = var_02;
  level.boss_fight_activation_interaction = var_02;
  level thread wait_to_activate(param_00, var_02);
}

activate_boss_fight_hint_func(param_00, param_01) {
  if(scripts\engine\utility::flag_exist("boss_fight_ready_soon") && scripts\engine\utility::flag("boss_fight_ready_soon")) {
    return & "CP_TOWN_BOSS_FIGHT_READY_SOON";
  }

  return & "DIRECT_BOSS_FIGHT_ACTIVATION";
}

try_activate_boss_fight(param_00, param_01) {}

made_direct_boss_fight_purchase(param_00) {
  param_00.made_direct_boss_fight_purchase = 1;
  foreach(var_02 in level.players) {
    if(!scripts\engine\utility::istrue(var_02.made_direct_boss_fight_purchase)) {
      return;
    }
  }

  level notify("start_boss_fight_activation");
}

wait_to_activate(param_00, param_01) {
  level endon("game_ended");
  level waittill("start_boss_fight_activation");
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_01);
  if(isDefined(level.direct_boss_fight_flag_wait)) {
    scripts\engine\utility::flag_init("boss_fight_ready_soon");
    scripts\engine\utility::flag_set("boss_fight_ready_soon");
    scripts\engine\utility::flag_wait(level.direct_boss_fight_flag_wait);
    scripts\engine\utility::flag_clear("boss_fight_ready_soon");
    foreach(var_03 in level.players) {
      var_03 scripts\cp\cp_interaction::refresh_interaction();
    }
  }

  level thread wait_all_players_press_use(param_00);
}

wait_all_players_press_use(param_00) {
  level endon("game_ended");
  level endon("start_direct_boss_fight");
  var_01 = 13225;
  for(;;) {
    var_02 = 1;
    foreach(var_04 in level.players) {
      if(scripts\engine\utility::istrue(var_04.inlaststand)) {
        var_02 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_04.iscarrying)) {
        var_02 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_04.isusingsupercard)) {
        var_02 = 0;
        break;
      }

      if(distance2dsquared(var_04.origin, param_00) > var_01) {
        var_02 = 0;
        break;
      }

      if(!var_04 usebuttonpressed()) {
        var_02 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_02) {
      var_02 = 1;
      foreach(var_04 in level.players) {
        if(scripts\engine\utility::istrue(var_04.inlaststand)) {
          var_02 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_04.iscarrying)) {
          var_02 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_04.isusingsupercard)) {
          var_02 = 0;
          break;
        }

        if(distance2dsquared(var_04.origin, param_00) > var_01) {
          var_02 = 0;
          break;
        }

        if(!var_04 usebuttonpressed()) {
          var_02 = 0;
          break;
        }
      }
    }

    if(var_02) {
      level thread start_direct_boss_fight();
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

start_direct_boss_fight() {
  level notify("start_direct_boss_fight");
  level.disableplayerdamage = undefined;
  level.disable_consumables = undefined;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.boss_fight_activation_interaction);
  level thread delay_restore_afterlife_arcade();
  if(isDefined(level.start_direct_boss_fight_func)) {
    level thread[[level.start_direct_boss_fight_func]]();
  }

  teleport_players_to_boss_fight();
}

delay_restore_afterlife_arcade() {
  level endon("game_ended");
  wait(1);
  enable_things_in_afterlife_arcade();
  clean_up_perk_purchase_board();
  clean_up_weapon_purchase_board();
}

teleport_players_to_boss_fight() {
  var_00 = get_start_look_at_loc();
  var_01 = get_start_stand_loc_list();
  foreach(var_05, var_03 in level.players) {
    var_04 = spawnStruct();
    var_04.origin = var_01[var_05];
    var_04.angles = vectortoangles(var_00 - var_01[var_05]);
    level thread get_players_best_times();
    level thread move_player_through_portal_tube(var_03, [var_04]);
  }
}

get_start_look_at_loc() {
  switch (level.script) {
    case "cp_zmb":
      return (652, 795, 115);

    case "cp_rave":
      return (-5365, 4834, 34);

    case "cp_disco":
      return (-628.8, 1422.4, 178);

    case "cp_town":
      return (3035, 2829, -141);

    case "cp_final":
      if(is_meph_fight()) {
        return (-13314, -337, -48);
      }
      return (2874, 2424, -116);
  }
}

get_start_stand_loc_list() {
  switch (level.script) {
    case "cp_zmb":
      return [(918, 1411, 11), (768, 1414, 11), (501, 1390, 11), (358, 1416, 11)];

    case "cp_rave":
      return [(-4037.4, 4094.5, -83.1), (-3968.5, 4113.5, -95.6), (-4089.8, 4176.5, -45.7), (-4020.8, 4195.6, -58.2)];

    case "cp_disco":
      return [(-1082, 1638.6, 170), (-600.2, 1834.6, 170), (-793.3, 1863.8, 178), (-962.8, 1770.4, 178)];

    case "cp_town":
      return [(1654, -1472, 304), (1812, -1366, 239), (1914, -1174, 187), (2185, -1170, 185)];

    case "cp_final":
      if(is_meph_fight()) {
        return [(-12819, -327, -106), (-12822, -397, -106), (-12769, -287, -106), (-12776, -361, -106)];
      }
      return [(2946, 2918, -68), (2846, 2918, -68), (2946, 2818, -68), (2846, 2818, -68)];
  }
}

level_specific_setup() {
  level endon("game_ended");
  wait(10);
  open_sesame();
  disable_weapon_upgrade_interaction();
  if(isDefined(level.setup_direct_boss_fight_func)) {
    level thread[[level.setup_direct_boss_fight_func]]();
  }
}

disable_weapon_upgrade_interaction() {
  var_00 = scripts\engine\utility::getstructarray("interaction", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.script_noteworthy) && var_03.script_noteworthy == "weapon_upgrade") {
      var_01[var_01.size] = var_03;
    }
  }

  foreach(var_06 in var_01) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_06);
  }
}

open_sesame() {
  if(isDefined(level.open_sesame_func)) {
    thread[[level.open_sesame_func]]();
  } else {
    if(scripts\engine\utility::istrue(level.open_sesame)) {
      level.open_sesame = undefined;
      return;
    } else {
      level.open_sesame = 1;
    }

    level start_all_generators();
    var_00 = getEntArray("door_buy", "targetname");
    foreach(var_02 in var_00) {
      var_02 notify("trigger", "open_sesame");
      wait(0.1);
    }

    var_04 = getEntArray("chi_door", "targetname");
    foreach(var_02 in var_04) {
      var_02.physics_capsulecast notify("damage", undefined, "open_sesame");
      wait(0.1);
    }

    level.moon_donations = 3;
    level.kepler_donations = 3;
    level.triton_donations = 3;
    if(isDefined(level.team_killdoors)) {
      foreach(var_08 in level.team_killdoors) {
        var_08 scripts\cp\zombies\zombie_doors::open_team_killdoor(level.players[0]);
      }
    }

    var_0A = scripts\engine\utility::getstructarray("interaction", "targetname");
    foreach(var_0C in var_0A) {
      var_0D = scripts\engine\utility::getstructarray(var_0C.script_noteworthy, "script_noteworthy");
      foreach(var_0F in var_0D) {
        if(isDefined(var_0F.target) && isDefined(var_0C.target)) {
          if(var_0F.target == var_0C.target && var_0F != var_0C) {
            if(scripts\engine\utility::array_contains(var_0A, var_0F)) {
              var_0A = scripts\engine\utility::array_remove(var_0A, var_0F);
            }
          }
        }
      }

      if(scripts\cp\cp_interaction::interaction_is_door_buy(var_0C)) {
        if(!isDefined(var_0C.script_noteworthy)) {
          continue;
        }

        if(var_0C.script_noteworthy == "team_door_switch") {
          scripts\cp\zombies\interaction_openareas::use_team_door_switch(var_0C, level.players[0]);
        }
      }
    }
  }

  if(scripts\engine\utility::flag_exist("restorepower_step1")) {
    scripts\engine\utility::flag_set("restorepower_step1");
  }
}

start_all_generators() {
  foreach(var_01 in level.generators) {
    thread scripts\cp\zombies\zombie_power::generic_generator(var_01);
    wait(0.1);
  }
}

get_players_best_times() {
  setomnvar("zm_boss_splash", 4);
  level notify("enter_fast_travel");
  wait(0.85);
  for(var_00 = 0; var_00 < level.players.size; var_00++) {
    if(var_00 == 0) {
      var_01 = get_player_best_time(level.players[var_00]);
      setomnvar("zm_boss_time_p1", var_01);
    }

    if(var_00 == 1) {
      var_01 = get_player_best_time(level.players[var_00]);
      setomnvar("zm_boss_time_p2", var_01);
    }

    if(var_00 == 2) {
      var_01 = get_player_best_time(level.players[var_00]);
      setomnvar("zm_boss_time_p3", var_01);
    }

    if(var_00 == 3) {
      var_01 = get_player_best_time(level.players[var_00]);
      setomnvar("zm_boss_time_p4", var_01);
    }
  }

  boss_fight_splash();
}

get_player_best_time(param_00) {
  if(level.script == "cp_final" && is_meph_fight()) {
    return param_00 getplayerdata("cp", "alienPlayerStats", "bestscore");
  }

  return param_00 getplayerdata("cp", "duration", level.script);
}

set_player_best_time(param_00, param_01) {
  if(level.script == "cp_final" && is_meph_fight()) {
    param_00 setplayerdata("cp", "alienPlayerStats", "bestscore", param_01);
    return;
  }

  param_00 setplayerdata("cp", "duration", level.script, param_01);
}

boss_fight_splash() {
  if(is_meph_fight()) {
    setomnvar("zm_boss_id", 6);
  }

  setomnvar("zm_boss_splash", 1);
  wait(5);
  setomnvar("zm_boss_splash", 0);
  wait(1);
  setomnvar("zm_boss_id", -1);
  level thread run_boss_timer();
}

run_boss_timer() {
  level endon("game_ended");
  level endon("boss_beat");
  setomnvar("zm_boss_splash", 2);
  var_00 = 0;
  var_01 = gettime();
  for(;;) {
    var_02 = gettime();
    level.bosstimer = var_02 - var_01;
    setomnvar("zm_boss_timer", level.bosstimer);
    wait(1);
  }
}

run_pre_match_timer() {
  level endon("game_ended");
  level endon("enter_fast_travel");
  wait(13);
  setomnvar("zm_boss_splash", 3);
  level.prebossfighttime = 180000;
  var_00 = gettime();
  while(level.prebossfighttime >= 0) {
    var_01 = gettime();
    setomnvar("zm_boss_timer", level.prebossfighttime);
    level.prebossfighttime = 180000 - var_01 - var_00;
    wait(1);
  }

  level thread start_direct_boss_fight();
}

success_sequence(param_00, param_01) {
  level notify("boss_beat");
  if(!isDefined(param_00)) {
    param_00 = 3;
  }

  switch (param_01) {
    case 1:
      var_02 = "boss_spaceland";
      break;

    case 2:
      var_02 = "boss_rave";
      break;

    case 3:
      var_02 = "boss_disco";
      break;

    case 4:
      var_02 = "boss_town";
      break;

    case 5:
      var_02 = "boss_final";
      break;

    case 6:
      var_02 = "boss_dc";
      break;

    default:
      var_02 = "boss_spaceland";
      break;
  }

  if(param_00 > 3) {
    wait(param_00 - 3);
  }

  foreach(var_04 in level.players) {
    var_04.ignoreme = 1;
    var_04 thread scripts\cp\cp_hud_message::showsplash(var_02);
    var_04 scripts\cp\cp_persistence::give_player_xp(int(1000), 1);
  }

  wait(3);
  foreach(var_04 in level.players) {
    try_set_personal_best_time(var_04);
  }

  scripts\cp\zombies\zombie_analytics::log_boss_fight_result(1);
  scripts\cp\zombies\zombie_analytics::log_wave_dur_boss_fight(int(level.bosstimer / 1000));
  setomnvar("zm_boss_splash", 5);
  setomnvar("zm_boss_id", param_01);
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

try_set_personal_best_time(param_00) {
  var_01 = get_player_best_time(param_00);
  var_02 = int(level.bosstimer);
  if(should_set_personal_best_time(var_01, var_02)) {
    set_player_best_time(param_00, var_02);
  }
}

should_set_personal_best_time(param_00, param_01) {
  if(param_00 == 0) {
    return 1;
  }

  if(param_01 < param_00) {
    return 1;
  }

  return 0;
}

get_direct_boss_fight_time_survived() {
  return int(level.bosstimer / 1000);
}

move_player_through_portal_tube(param_00, param_01) {
  var_02 = 30;
  param_00 endon("disconnect");
  param_00 scripts\cp\powers\coop_powers::power_disablepower();
  param_00.disable_consumables = 1;
  param_00.isfasttravelling = 1;
  param_00 getrigindexfromarchetyperef();
  param_00 notify("delete_equipment");
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_03 = move_through_tube(param_00, "fast_travel_tube_start", "fast_travel_tube_end");
  if(isDefined(self.cooldown)) {
    self.cooldown = self.cooldown + var_02;
  }

  teleport_to_portal_safe_spot(param_00, param_01);
  if(isDefined(level.boss_fight_post_portal_tube_func)) {
    param_00 thread[[level.boss_fight_post_portal_tube_func]](param_00);
  }

  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_03 delete();
  param_00 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  param_00.is_off_grid = undefined;
  param_00.kicked_out = undefined;
  param_00.isfasttravelling = undefined;
  param_00.disable_consumables = undefined;
  param_00 notify("fast_travel_complete");
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  if(param_00.vo_prefix == "p5_") {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("fasttravel_exit", "town_comment_vo");
  }
}

move_through_tube(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("move_through_tube");
  param_00 earthquakeforplayer(0.3, 0.2, param_00.origin, 200);
  var_03 = getent(param_01, "targetname");
  var_04 = getent(param_02, "targetname");
  param_00 cancelmantle();
  param_00.no_outline = 1;
  param_00.no_team_outlines = 1;
  var_05 = var_03.origin + (0, 0, -45);
  var_06 = var_04.origin + (0, 0, -45);
  param_00.is_fast_traveling = 1;
  param_00 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  param_00 scripts\cp\utility::allow_player_ignore_me(1);
  param_00 dontinterpolate();
  param_00 setorigin(var_05);
  param_00 setplayerangles(var_03.angles);
  param_00 playlocalsound("zmb_portal_travel_lr");
  var_07 = spawn("script_origin", var_05);
  param_00 playerlinkto(var_07);
  param_00 getweaponrankxpmultiplier();
  wait(0.1);
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_07 moveto(var_06, 1);
  wait(1);
  param_00.is_fast_traveling = undefined;
  param_00 scripts\cp\utility::removedamagemodifier("fast_travel", 0);
  if(param_00 scripts\cp\utility::isignoremeenabled()) {
    param_00 scripts\cp\utility::allow_player_ignore_me(0);
  }

  param_00.is_fast_traveling = undefined;
  param_00.no_outline = 0;
  param_00.no_team_outlines = 0;
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  return var_07;
}

unlinkplayerafterduration() {
  while(scripts\engine\utility::istrue(self.isrewinding) || isDefined(self.rewindmover)) {
    scripts\engine\utility::waitframe();
  }

  self unlink();
}

teleport_to_portal_safe_spot(param_00, param_01) {
  if(isDefined(param_01)) {
    var_02 = param_01;
  } else {
    var_02 = self.teleport_spots;
  }

  var_03 = undefined;
  while(!isDefined(var_03)) {
    foreach(var_05 in var_02) {
      if(!positionwouldtelefrag(var_05.origin)) {
        var_03 = var_05;
      }
    }

    if(!isDefined(var_03)) {
      if(!isDefined(var_02[0].angles)) {
        var_02[0].angles = (0, 0, 0);
      }

      var_07 = scripts\cp\utility::vec_multiply(anglesToForward(var_02[0].angles), 64);
      var_03 = spawnStruct();
      var_03.origin = var_02[0].origin + var_07;
      var_03.angles = var_02[0].angles;
    }

    wait(0.1);
  }

  param_00 playershow();
  if(scripts\engine\utility::istrue(param_00.isrewinding) || isDefined(self.rewindmover)) {
    param_00 thread unlinkplayerafterduration();
  } else {
    param_00 unlink();
  }

  param_00 dontinterpolate();
  param_00 setorigin(var_03.origin);
  param_00 setplayerangles(var_03.angles);
  param_00.disable_consumables = undefined;
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00.portal_end_origin = var_03.origin;
}

adjust_wave_num(param_00) {
  if(should_directly_go_to_boss_fight()) {
    foreach(var_02 in level.players) {
      var_02.wave_num_when_joined = undefined;
    }

    if(param_00 == "all_escape") {
      level.wave_num = get_victory_wave_num();
    } else {
      level.wave_num = get_fail_wave_num();
    }

    foreach(var_02 in level.players) {
      var_02 setclientomnvar("zombie_wave_number", level.wave_num);
    }
  }
}

get_victory_wave_num() {
  var_00 = 30000;
  var_01 = int(level.bosstimer);
  var_02 = get_best_time_for_player_count();
  if(var_01 <= var_02) {
    return 16;
  }

  if(var_01 <= var_02 + var_00 * 1) {
    return 15;
  }

  if(var_01 <= var_02 + var_00 * 2) {
    return 13;
  }

  if(var_01 <= var_02 + var_00 * 3) {
    return 12;
  }

  return 11;
}

get_fail_wave_num() {
  var_00 = int(level.bosstimer);
  if(var_00 < 1000) {
    return 1;
  }

  if(var_00 < 120000) {
    return 2;
  }

  if(var_00 >= 120000 && var_00 < 300000) {
    return 3;
  }

  if(var_00 >= 300000 && var_00 < 480000) {
    return 4;
  }

  if(var_00 >= 480000 && var_00 < 600000) {
    return 5;
  }

  return 6;
}

get_best_time() {
  switch (level.script) {
    case "cp_zmb":
      return 149000;

    case "cp_rave":
      return 913000;

    case "cp_disco":
      return 231000;

    case "cp_town":
      return 361000;

    case "cp_final":
      if(is_meph_fight()) {
        return 1032000;
      }
      return 1324000;
  }
}

get_best_time_for_player_count() {
  switch (level.script) {
    case "cp_zmb":
      switch (level.players.size) {
        case 1:
          return 240000;

        case 2:
          return 271000;

        case 3:
          return 302000;

        case 4:
          return 334000;

        default:
          return 240000;
      }

      break;

    case "cp_rave":
      switch (level.players.size) {
        case 1:
          return 705000;

        case 2:
          return 774000;

        case 3:
          return 843000;

        case 4:
          return 913000;

        default:
          return 705000;
      }

      break;

    case "cp_disco":
      switch (level.players.size) {
        case 1:
          return 285000;

        case 2:
          return 267000;

        case 3:
          return 249000;

        case 4:
          return 231000;

        default:
          return 285000;
      }

      break;

    case "cp_town":
      switch (level.players.size) {
        case 1:
          return 310000;

        case 2:
          return 327000;

        case 3:
          return 344000;

        case 4:
          return 361000;

        default:
          return 310000;
      }

      break;

    case "cp_final":
      if(is_meph_fight()) {
        switch (level.players.size) {
          case 1:
            return 939000;

          case 2:
            return 970000;

          case 3:
            return 1001000;

          case 4:
            return 1032000;

          default:
            return 939000;
        }

        return;
      }

      switch (level.players.size) {
        case 1:
          return 799000;

        case 2:
          return 974000;

        case 3:
          return 1149000;

        case 4:
          return 1324000;

        default:
          return 799000;
      }

      break;
  }
}

get_weapon_cost(param_00) {
  var_01 = scripts\cp\utility::getrawbaseweaponname(param_00);
  switch (var_01) {
    case "g18":
    case "crdb":
    case "fhr":
    case "mauler":
    case "minilmg":
    case "unsalmg":
    case "shredder":
    case "headcutter":
    case "facemelter":
    case "dischord":
    case "cutie":
    case "harpoon4":
    case "harpoon3":
    case "harpoon2":
    case "harpoon1":
    case "katana":
    case "nunchucks":
    case "venomx":
      return 5000;

    case "gauss":
    case "sdfar":
    case "devastator":
    case "sdfshotty":
    case "ump45c":
    case "tacburst":
    case "mp28":
    case "ump45":
    case "fmg":
    case "vr":
    case "m4":
    case "lmg03":
    case "sdflmg":
    case "arclassic":
    case "ar57":
    case "ripper":
    case "kbs":
      return 3500;

    case "spas":
    case "ake":
    case "longshot":
    case "erad":
    case "m8":
    case "cheytac":
      return 2500;
  }
}