/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\hardcore\island_ee_hc.gsc
*****************************************************/

init() {
  level.perk_machine_should_open = ::perk_machine_open;
  common_scripts\utility::flag_init("anointed_zombies_done_spawning");
  common_scripts\utility::flag_init("flag_monk_head_found");
  common_scripts\utility::flag_init("flag_monk_head_placed");
  common_scripts\utility::flag_init("flag_anointed_pest_head_drop");
  common_scripts\utility::flag_init("flag_anointed_fol_head_drop");
  common_scripts\utility::flag_init("flag_anointed_asn_head_drop");
  common_scripts\utility::flag_init("flag_anointed_pest_head_get");
  common_scripts\utility::flag_init("flag_anointed_fol_head_get");
  common_scripts\utility::flag_init("flag_anointed_asn_head_get");
  common_scripts\utility::flag_init("flag_monk_head_retrieved");
  common_scripts\utility::flag_init("flag_anointed_pest_head_placed");
  common_scripts\utility::flag_init("flag_anointed_fol_head_placed");
  common_scripts\utility::flag_init("flag_anointed_asn_head_placed");
  common_scripts\utility::flag_init("flag_anointed_monk_head_placed");
  common_scripts\utility::flag_init("flag_heads_complete");
  common_scripts\utility::flag_init("zmb_hc_pest_spawned");
  common_scripts\utility::flag_init("zmb_hc_follower_spawned");
  common_scripts\utility::flag_init("zmb_hc_assassin_spawned");
  common_scripts\utility::flag_init("zmb_hc_pest_destination");
  common_scripts\utility::flag_init("zmb_hc_follower_destination");
  common_scripts\utility::flag_init("zmb_hc_assassin_destination");
  common_scripts\utility::flag_init("zmb_hc_pest_destination");
  common_scripts\utility::flag_init("zmb_hc_follower_destination");
  common_scripts\utility::flag_init("zmb_hc_assassin_destination");
  common_scripts\utility::flag_init("pomel room opened");
  common_scripts\utility::flag_init("water_has_been_raised");
  common_scripts\utility::flag_init("flag_pommel_given");
  common_scripts\utility::flag_init("players_spawned_statue_piece_1");
  common_scripts\utility::flag_init("players_spawned_statue_piece_2");
  common_scripts\utility::flag_init("players_spawned_statue_piece_3");
  common_scripts\utility::flag_init("players_placed_statue_piece_1");
  common_scripts\utility::flag_init("players_placed_statue_piece_2");
  common_scripts\utility::flag_init("players_placed_statue_piece_3");
  common_scripts\utility::flag_init("flag_pest_painted_1");
  common_scripts\utility::flag_init("flag_pest_painted_2");
  common_scripts\utility::flag_init("flag_pest_painted_3");
  common_scripts\utility::flag_init("flag_pest_painted_4");
  common_scripts\utility::flag_init("flag_pest_painted_5");
  common_scripts\utility::flag_init("flag_hc_pest_paint_complete");
  common_scripts\utility::flag_init("flag_sacrificed_sprinter_spine");
  common_scripts\utility::flag_init("flag_sacrificed_follower_spine");
  common_scripts\utility::flag_init("flag_sacrificed_assassin_spine");
  common_scripts\utility::flag_init("flag_hc_asn_found_1");
  common_scripts\utility::flag_init("flag_hc_asn_found_2");
  common_scripts\utility::flag_init("flag_hc_asn_found_3");
  common_scripts\utility::flag_init("flag_hc_asn_escort_complete");
  common_scripts\utility::flag_init("flag_hc_escort_active");
  common_scripts\utility::flag_init("flag_pomel_room_players_wait");
  common_scripts\utility::flag_init("ibeam_complete");
  common_scripts\utility::flag_init("ripsaw_punch_active");
  foreach(var_01 in ["flag_monk_head_found", "flag_monk_head_placed", "flag_anointed_pest_head_placed", "flag_anointed_fol_head_placed", "flag_anointed_asn_head_placed", "flag_heads_complete", "zmb_hc_pest_destination", "zmb_hc_follower_destination", "zmb_hc_assassin_destination", "pomel room opened", "flag_pommel_given", "players_placed_statue_piece_1", "players_placed_statue_piece_2", "players_placed_statue_piece_3", "flag_hc_pest_paint_complete", "flag_sacrificed_sprinter_spine", "flag_sacrificed_follower_spine", "flag_sacrificed_assassin_spine", "flag_hc_asn_found_1", "flag_hc_asn_found_2", "flag_hc_asn_found_3", "flag_hc_asn_escort_complete"]) {
    lib_0557::func_4BC9(var_01, undefined, undefined, 1);
  }

  level thread handle_pomel_door_interact(["players_spawned_statue_piece_1", "players_spawned_statue_piece_2", "players_spawned_statue_piece_3"], ["players_placed_statue_piece_1", "players_placed_statue_piece_2", "players_placed_statue_piece_3"]);
  level thread stone_collect_1_think();
  level thread stone_collect_2_think();
  level thread stone_collect_3_think();
  level thread hc_init_monk_heads_setup();
  level thread pest_hc_runes_init();
  level thread assassin_hc_hide_point_init();
  level thread head_hooks_setup();
  thread pagan_room_waterfall_vfx();
  level thread pomel_boss_fight_water_raise();
  thread i_beam();
  thread ee_rollers();
  thread ee_stuka_rpg();
  thread jack_respawn();
  pommel_water_trigger(::common_scripts\utility::func_9D9F);
}

pommel_water_trigger(param_00) {
  var_01 = getEntArray("trigger_water", "script_noteworthy");
  foreach(var_03 in var_01) {
    if(lib_0547::func_5565(var_03.var_82EC, "zmi_pommel_water")) {
      var_03[[param_00]]();
    }
  }
}

jack_respawn() {
  level.jack_in_box_secret_handler = ::on_jack_landed_in_secret;
}

on_jack_landed_in_secret(param_00) {
  var_01 = 18;
  var_02 = 4;
  var_03 = common_scripts\utility::func_46B5("zmi_hc_secret", "targetname");
  var_04 = var_03.origin + (0, 0, var_02);
  for(var_05 = 0; var_05 < 3; var_05++) {
    if(distance2d(self.origin, var_04) < var_03.radius && abs(self.origin[2] - var_04[2]) < var_01) {
      level.jack_in_box_secret_handler = undefined;
      level.players_sacrificed_jack = 1;
      param_00 delete();
      lib_0378::func_8D74("tesla_hc_energy_lamp_destruct", var_03.origin);
      return 1;
    }

    wait 0.05;
  }

  return 0;
}

pomel_boss_fight_water_raise() {
  common_scripts\utility::func_3C9F("flag_heads_complete");
  pomel_room_players_wait();
  maps / mp / zquests / casual / island_ee_util::clear_all_zombies();
  thread pomel_door_close();
  var_00 = common_scripts\utility::func_46B5("pommel_room_soul_collection_struct", "targetname");
  var_01 = getEnt("zmb_pomel_room_water", "targetname");
  var_01 thread raise_water_objective(var_00);
  level thread common_scripts\_exploder::func_88E(217);
  level thread player_zombie_rush_kills_after_num_kills(randomintrange(2, 4), var_00.origin);
  level thread player_zombie_rush_vo_after(randomintrange(6, 9), var_00.origin);
  foreach(var_03 in level.players) {
    var_03 maps\mp\_utility::func_2CED(1.25, ::lib_0367::func_8E3C, "pommelattack");
  }

  common_scripts\utility::flag_set("anointed_zombies_done_spawning");
  common_scripts\utility::func_3C9F("water_has_been_raised");
  pommel_water_trigger(::common_scripts\utility::func_9DA3);
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8607();
  level.maxed_zombies_sprint = 0;
  var_03 = maps / mp / mp_zombie_island_aud::get_closest_alive_player(var_00.origin);
  var_03 thread lib_0367::func_8E3C("pommel", level.players);
  pomel_skull_destroy();
  level thread maps / mp / zombies / weapons / _zombie_aoe_grenade::spawn_pommel_special_pickup("secret_room_spawn", "flag_pommel_given");
  pomel_door_open();
}

pomel_skull_destroy() {
  level thread common_scripts\_exploder::func_88E(213);
  var_00 = getEnt("zmb_island_pomel_skull", "targetname");
  lib_0378::func_8D74("pommel_skull_destroyed", var_00);
  var_00 method_8511();
}

player_zombie_rush_vo_after(param_00, param_01) {
  wait(param_00);
  var_02 = maps / mp / mp_zombie_island_aud::get_closest_alive_player(param_01);
  var_02 thread lib_0367::func_8E3C("buggersjustkeepcomin", level.players);
}

player_zombie_rush_kills_after_num_kills(param_00, param_01) {
  var_02 = 0;
  while(var_02 < param_00) {
    level waittill("water_raised", var_02);
  }

  var_03 = maps / mp / mp_zombie_island_aud::get_closest_alive_player(param_01);
  var_03 thread lib_0367::func_8E3C("keepyereyeonthewater", level.players);
}

hc_init_monk_heads_setup() {
  level.zombie_forge_control_struct = common_scripts\utility::func_46B5("zombie_forge_control", "targetname");
  var_00 = getEnt("hc_quest_monk_head_pickup", "targetname");
  var_01 = common_scripts\utility::func_44BE(level.zombie_forge_control_struct.target, "targetname");
  foreach(var_03 in var_01) {
    switch (var_03.script_noteworthy) {
      case "machine_trigger":
        level.zombie_forge_control_struct.controller_trig = var_03;
        break;

      case "machine_light":
        level.zombie_forge_control_struct.controller_light = var_03;
        break;

      case "freezer_head_model":
        level.zombie_forge_control_struct.var_B9 = var_03;
        level.zombie_forge_control_struct.var_B9 hide();
        break;
    }
  }

  var_05 = function_021F(level.zombie_forge_control_struct.target, "targetname");
  if(isDefined(var_05) && var_05.size > 0) {
    level.zombie_forge_control_struct.var_82EF = var_05[0];
    level.zombie_forge_control_struct.var_82EF setscriptablepartstate("light", "red");
    level.zombie_forge_control_struct common_scripts\utility::func_3799("freezer_machine_working");
  }

  var_00 thread monk_head_find_think();
  level.zombie_forge_control_struct thread monk_head_control_think();
  level.zombie_forge_control_struct thread monk_head_place_think();
  level.zombie_forge_control_struct thread monk_head_operate_machine();
  wait 0.05;
  level.zombie_forge_control_struct thread head_retrieve_monk_head_from_freezer();
}

monk_head_control_think() {
  level endon("flag_monk_head_retrieved");
  common_scripts\utility::func_3C9F("flag_monk_head_placed");
  self.var_82EF setscriptablepartstate("light", "green");
  for(;;) {
    common_scripts\utility::func_379C("freezer_machine_working");
    self.var_82EF thread maps / mp / zquests / casual / island_ee_main::activate_machine();
    while(common_scripts\utility::func_3794("freezer_machine_working")) {
      self.var_82EF setscriptablepartstate("light", "off");
      wait(0.5);
      self.var_82EF setscriptablepartstate("light", "green");
      wait(0.5);
    }

    var_00 = self.var_82EF getscriptablepartstate("light");
    if(var_00 != "green") {
      self.var_82EF setscriptablepartstate("light", "green");
    }
  }
}

monk_head_find_think() {
  var_00 = self;
  var_00 waittill("trigger", var_01);
  var_02 = getEnt(var_00.target, "targetname");
  var_02 delete();
  common_scripts\utility::flag_set("flag_monk_head_found");
}

monk_head_place_think() {
  var_00 = self.controller_trig;
  var_01 = self.var_B9;
  while(!common_scripts\utility::func_3C77("flag_monk_head_placed")) {
    var_00 waittill("trigger", var_02);
    if(!common_scripts\utility::func_3C77("flag_monk_head_found")) {
      continue;
    }

    var_01 show();
    common_scripts\utility::flag_set("flag_monk_head_placed");
  }

  wait(0.75);
  maps / mp / zquests / casual / island_ee_util::monk_head_dialogue("zmb_isla_monk_sputteringgaspingsoundsof");
  wait(0.15);
  maps / mp / zquests / casual / island_ee_util::monk_head_dialogue("zmb_isla_monk_behindthedoorthemotherwai");
  wait(0.35);
  maps / mp / zquests / casual / island_ee_util::monk_head_dialogue("zmb_isla_monk_thefirstcaughtredandburie");
  wait(0.15);
  maps / mp / zquests / casual / island_ee_util::monk_head_dialogue("zmb_isla_monk_butthefinalladgonestillwi");
}

monk_head_operate_machine() {
  var_00 = self.controller_trig;
  var_01 = undefined;
  common_scripts\utility::func_3C9F("flag_monk_head_placed");
  var_00 thread freezer_occupied_nag();
  while(!common_scripts\utility::func_3C77("flag_monk_head_retrieved")) {
    var_00 waittill("trigger", var_02);
    var_03 = var_02 spine_get_type();
    if(!isDefined(var_03) || common_scripts\utility::func_3C77("flag_crane_in_motion") || level.freezer_crane.var_931A == "request_retrieve") {
      continue;
    }

    switch (var_03) {
      case "pest_spine":
        if(common_scripts\utility::func_3C77("flag_hc_escort_active") || common_scripts\utility::func_3C77("flag_loader_zombie_unavailable")) {
          var_00 notify("occupied_nag");
          break;
        }

        common_scripts\utility::flag_set("flag_sacrificed_sprinter_spine");
        var_01 = "hc_pest";
        break;

      case "wustling_spine":
        if(common_scripts\utility::func_3C77("flag_hc_escort_active") || common_scripts\utility::func_3C77("flag_loader_zombie_unavailable")) {
          var_00 notify("occupied_nag");
          break;
        }

        common_scripts\utility::flag_set("flag_sacrificed_follower_spine");
        var_01 = "hc_follower";
        break;

      case "assassin_spine":
        if(common_scripts\utility::func_3C77("flag_hc_escort_active") || common_scripts\utility::func_3C77("flag_loader_zombie_unavailable")) {
          var_00 notify("occupied_nag");
          break;
        }

        var_01 = "hc_assassin";
        common_scripts\utility::flag_set("flag_sacrificed_assassin_spine");
        break;

      case "zombie_spine":
        var_01 = "hc_zombie";
        break;

      default:
        break;
    }

    common_scripts\utility::func_379A("freezer_machine_working");
    common_scripts\utility::flag_set("flag_loader_zombie_unavailable");
    var_02 maps / mp / zquests / casual / island_ee_util::spine_player_clear_data();
    level notify("freezeer_summon_zombie", var_01);
    level waittill("freezer_zombie_placed", var_04);
    common_scripts\utility::func_3796("freezer_machine_working");
    level thread spine_perform_escort(var_01, var_04);
  }
}

spine_get_type() {
  var_00 = self;
  if(!isDefined(var_00.spine_flag)) {
    return;
  }

  switch (var_00.spine_flag) {
    case "ent_flag_pest_spine_collected":
      return "pest_spine";

    case "ent_flag_follower_spine_collected":
      return "wustling_spine";

    case "ent_flag_assassin_spine_collected":
      return "assassin_spine";

    case "ent_flag_zombie_spine_collected":
      return "zombie_spine";

    default:
      break;
  }
}

loop_head_anim() {
  for(;;) {
    self scriptmodelplayanim("s2_zom_fireman_idle", "test_anim");
    wait(1);
  }
}

spine_perform_escort(param_00, param_01) {
  switch (param_00) {
    case "escort_bomber":
      break;

    case "hc_pest":
      if(common_scripts\utility::func_3C77("flag_hc_escort_active")) {
        return;
      }

      if(common_scripts\utility::func_3C77("zmb_hc_pest_destination")) {
        common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
        return;
      }

      common_scripts\utility::flag_set("flag_hc_escort_active");
      pest_escort_quest_main(param_01);
      break;

    case "hc_assassin":
      if(common_scripts\utility::func_3C77("flag_hc_escort_active")) {
        return;
      }

      if(common_scripts\utility::func_3C77("zmb_hc_assassin_destination")) {
        common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
        return;
      }

      common_scripts\utility::flag_set("flag_hc_escort_active");
      assassin_escort_quest_main(param_01);
      break;

    case "hc_follower":
      if(common_scripts\utility::func_3C77("flag_hc_escort_active")) {
        return;
      }

      if(common_scripts\utility::func_3C77("zmb_hc_follower_destination")) {
        common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
        return;
      }

      common_scripts\utility::flag_set("flag_hc_escort_active");
      wustling_escort_quest_main(param_01);
      break;

    case "hc_zombie":
      if(common_scripts\utility::func_3C77("players_spawned_statue_piece_2")) {
        common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
        return;
      }

      common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
      fodder_escort_quest_main(param_01);
      break;

    default:
      break;
  }
}

freezer_occupied_nag() {
  var_00 = self;
  for(;;) {
    var_00 waittill("occupied_nag", var_01);
    if(!common_scripts\utility::func_3C77("flag_hc_escort_active")) {
      continue;
    }

    wait(0.75);
    maps / mp / zquests / casual / island_ee_util::monk_head_dialogue("zmb_isla_monk_nochildnoyoumustfinishyou");
    wait(2);
  }
}

pest_escort_quest_main(param_00) {
  var_01 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_1_start_point");
  var_02 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_2_start_point");
  var_03 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_3_start_point");
  var_04 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_4_start_point");
  var_05 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_5_start_point");
  level.hc_pest = param_00;
  level.hc_pest pest_hc_zombie_post_drop_setup();
  for(;;) {
    var_06 = 0;
    if(!common_scripts\utility::func_3C77("flag_pest_painted_1")) {
      var_06 = pest_hc_main_do_challenge(var_01, 5, 10, 1, "flag_pest_painted_1", "hc_color_rune_pest_path_1_hit_loc");
      if(!common_scripts\utility::func_562E(var_06)) {
        common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::func_3C7B("flag_hc_escort_active");
        return;
      }
    }

    if(!common_scripts\utility::func_3C77("flag_pest_painted_2")) {
      var_06 = pest_hc_main_do_challenge(var_02, 5, 7, 4, "flag_pest_painted_2", "hc_color_rune_pest_path_2_hit_loc");
      if(!common_scripts\utility::func_562E(var_06)) {
        common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::func_3C7B("flag_hc_escort_active");
        return;
      }
    }

    if(!common_scripts\utility::func_3C77("flag_pest_painted_3")) {
      var_06 = pest_hc_main_do_challenge(var_03, 4, 6, 5, "flag_pest_painted_3", "hc_color_rune_pest_path_3_hit_loc");
      if(!common_scripts\utility::func_562E(var_06)) {
        common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::func_3C7B("flag_hc_escort_active");
        return;
      }
    }

    if(!common_scripts\utility::func_3C77("flag_pest_painted_4")) {
      var_06 = pest_hc_main_do_challenge(var_04, 3, 5, 7, "flag_pest_painted_4", "hc_color_rune_pest_path_4_hit_loc");
      if(!common_scripts\utility::func_562E(var_06)) {
        common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::func_3C7B("flag_hc_escort_active");
        return;
      }
    }

    if(!common_scripts\utility::func_3C77("flag_pest_painted_5")) {
      var_06 = pest_hc_main_do_challenge(var_05, 2, 4, 7, "flag_pest_painted_5", "hc_color_rune_pest_path_5_hit_loc", 1);
      if(!common_scripts\utility::func_562E(var_06)) {
        common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::func_3C7B("flag_hc_escort_active");
        return;
      }
    }

    level.hc_pest.var_2A9D = "scripted_soul_eat";
    level.hc_pest.anointed_fx delete();
    level.hc_pest.anointed_fx_model delete();
    thread maps / mp / zquests / casual / island_ee_util::escort_health_display_remove();
    level.hc_pest dodamage(level.hc_pest.health + 666, level.hc_pest.origin);
    break;
  }

  common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
  common_scripts\utility::flag_set("flag_hc_pest_paint_complete");
  pagan_room_pest_wait_for_rush();
}

pagan_room_pest_wait_for_rush() {
  maps\mp\_utility::func_2CED(0.75, ::maps / mp / zquests / casual / island_ee_util::monk_head_dialogue, "zmb_isla_monk_gotonerthusthatblackheart", 1);
  pomel_room_players_wait();
  maps / mp / zquests / casual / island_ee_util::clear_all_zombies();
  thread pomel_door_close();
  lib_0547::func_AAFB("isolated_room_close_to_pool_trig");
  var_00 = common_scripts\utility::func_46B7("pagan_room_zombie_dropdown_top", "targetname");
  var_01 = common_scripts\utility::random(var_00);
  var_02 = lib_054D::func_90BA("zombie_berserker", var_01, "anointed_pest", 0, 1, 0);
  var_02.ispassiveexempt = 1;
  var_02.is_anointed = 1;
  var_02 maps / mp / agents / _agent_common::func_83FD(int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_escort_hc_pest_health_main")));
  var_02.pommel_room_boss = 1;
  if(lib_0547::func_5565(level.zmb_anointed_pest_dies_to_ripsaw_gun, 0)) {
    var_02.ripsaw_hardened = 1;
  }

  var_02.var_55AB = 1;
  var_02.var_C29 = 0;
  var_02.isobjectiveexemptfromfog = 1;
  var_02.var_562B = 1;
  var_03 = 0.3488889;
  var_02 method_839F(var_03);
  var_04 = spawn("script_model", var_02.origin);
  var_04 setModel("tag_origin");
  var_04 linkTo(var_02, "j_mainroot", (0, 0, 0), (0, 0, 0));
  var_02.anointed_fx_model = var_04;
  var_02.anointed_fx = spawnlinkedfx(common_scripts\utility::func_44F5(pest_hc_util_get_anointed_fx(7)), var_04, "tag_origin");
  triggerfx(var_02.anointed_fx);
  var_02 maps / mp / agents / _agent_utility::deleteentonagentdeath(var_02.anointed_fx);
  lib_0547::func_7BA9(::anointed_zombie_death_listener);
  lib_0547::func_7BA9(::pest_pagan_zombie_death_listener);
  pagan_room_do_pest_rush();
  common_scripts\utility::flag_set("anointed_zombies_done_spawning");
  wait_for_all_bosses_defeated();
  lib_0547::func_2D8C(::anointed_zombie_death_listener);
  lib_0547::func_2D8C(::pest_pagan_zombie_death_listener);
  common_scripts\utility::flag_set("zmb_hc_pest_destination");
  pomel_door_open();
  common_scripts\utility::func_3C7B("flag_hc_escort_active");
}

wait_for_all_bosses_defeated() {
  var_00 = 1;
  while(var_00) {
    var_00 = 0;
    foreach(var_02 in lib_0547::func_408F()) {
      if(common_scripts\utility::func_562E(var_02.pommel_room_boss)) {
        var_00 = 1;
      }
    }

    wait 0.05;
    wait 0.05;
  }

  maps / mp / zquests / casual / island_ee_util::clear_all_zombies();
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8607();
  level.maxed_zombies_sprint = 0;
}

pagan_room_do_pest_rush() {
  level endon("flag_anointed_pest_head_placed");
  var_00 = common_scripts\utility::func_46B7("pagan_room_zombie_dropdown_top", "targetname");
  var_01 = common_scripts\utility::func_46B7("pagan_room_zombie_dropdown_bottom", "targetname");
  var_02 = common_scripts\utility::func_F73(var_01, var_00);
  level.hc_pest_pagan_zombies = [];
  var_03 = maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_escort_hc_pest_spawn_numbers");
  var_04 = 0;
  var_05 = 0;
  while(var_05 < var_03) {
    if(var_04 >= var_02.size) {
      var_04 = 0;
    }

    var_06 = undefined;
    var_06 = lib_054D::func_90BA("zombie_berserker", var_02[var_04], "pagan_pest_rush", 0, 1, 0);
    var_06.ispassiveexempt = 1;
    var_07 = maps / mp / gametypes / zombies::func_1E59(lib_0547::func_A51("zombie_generic"), level.var_A980 + 2);
    var_06 maps / mp / agents / _agent_common::func_83FD(int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_escort_hc_pest_health_buddy")));
    var_06.var_55AB = 1;
    var_06.var_C29 = 0;
    var_06.isobjectiveexemptfromfog = 1;
    var_06.var_562B = 1;
    var_06.pommel_room_boss = 1;
    var_08 = 0.3488889;
    var_06 method_839F(var_08);
    if(isDefined(var_06)) {
      level.hc_pest_pagan_zombies[level.hc_pest_pagan_zombies.size] = var_06;
    }

    var_04++;
    var_05++;
    wait(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_escort_hc_pest_spawn_rate"));
  }
}

pest_pagan_zombie_death_listener(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(level.hc_pest_pagan_zombies)) {
    if(common_scripts\utility::func_F79(level.hc_pest_pagan_zombies, self)) {
      level.hc_pest_pagan_zombies = common_scripts\utility::func_F93(level.hc_pest_pagan_zombies, self);
    }
  }
}

anointed_zombie_death_listener(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(common_scripts\utility::func_562E(self.is_anointed)) {
    if(lib_0547::func_5565(level.hc_wustling, self)) {
      level.hc_wustling = undefined;
    }

    level notify("pommel boss defeated");
    var_0B = self.var_A4B;
    var_0C = self.origin;
    var_0D = self.angles;
    head_spawn_type(var_0B, var_0C, var_0D);
  }
}

wait_for_player_in_zone(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = 0;
  var_03 = 1;
  if(param_01) {
    var_03 = level.players.size;
  }

  for(;;) {
    foreach(var_05 in level.players) {
      if(var_05.sessionstate == "spectator") {
        var_02--;
        continue;
      }

      foreach(var_07 in param_00) {
        if(lib_055A::func_7413(var_05, var_07)) {
          var_02++;
        }
      }
    }

    if(var_02 >= var_03) {
      break;
    } else {
      wait(1);
    }
  }
}

pest_hc_runes_init() {
  level.hc_color_runes = common_scripts\utility::func_46B7("hc_color_rune", "targetname");
  foreach(var_01 in level.hc_color_runes) {
    if(isDefined(var_01.var_8260) && function_030D(int(var_01.var_8260))) {
      var_01.coil_color = int(var_01.var_8260);
    }

    if(isDefined(var_01.var_81C7)) {
      var_01.open_type = var_01.var_81C7;
    }

    var_01.exposed = 0;
    var_02 = common_scripts\utility::func_44BE(var_01.target, "targetname");
    foreach(var_04 in var_02) {
      var_05 = var_04.script_noteworthy;
      if(!isDefined(var_05)) {
        continue;
      }

      switch (var_05) {
        case "rune_panel":
          var_01.panel = var_04;
          var_01.panel setCanDamage(1);
          break;

        case "rune_panel_open_dest":
          var_01.panel_open_dest = var_04;
          break;

        case "rune_missile_clip":
          var_01.missile_clip = var_04;
          var_01.missile_clip setCanDamage(1);
          break;

        case "rune_coil":
          var_01.coil = var_04;
          break;

        case "rune_coil_origin":
          var_01.coil_origin = var_04;
          break;

        case "rune_sweet_spot":
          var_01.optimal_fire_area = var_04;
          break;

        case "rune_optimal_path":
          var_01.var_9267 = var_04;
          if(isDefined(var_01.var_9267.target)) {
            var_01.optimal_target = common_scripts\utility::func_44BD(var_01.var_9267.target, "targetname");
          }
          break;
      }
    }
  }

  foreach(var_01 in level.hc_color_runes) {
    if(lib_0547::func_5565(var_01.coil_color, 0)) {
      if(isDefined(var_01.coil)) {
        var_01.coil delete();
      }

      if(isDefined(var_01.panel)) {
        var_01.panel delete();
      }

      var_01.exposed = 1;
      var_01.open_type = "open_no_panel";
    }

    if(lib_0547::func_5565(var_01.open_type, "open") || lib_0547::func_5565(var_01.open_type, "open_no_panel")) {
      if(isDefined(var_01.panel)) {
        var_01 thread pest_hc_runes_open_panel();
      }

      var_01 thread pest_hc_runes_damage_listener();
      continue;
    }

    if(lib_0547::func_5565(var_01.open_type, "damage")) {
      if(isDefined(var_01.panel)) {
        var_01 thread pest_hc_runes_panel_damage_listener();
      }
    }
  }

  thread maps\mp\_utility::func_6F74(::pest_hc_razergun_monitor);
}

pest_hc_runes_open_panel() {
  if(isDefined(self.var_3F3F)) {
    self.var_3F3F delete();
  }

  var_00 = pest_hc_util_get_filament_fx(self.coil_color);
  if(isDefined(var_00)) {
    self.var_3F3F = spawnfx(common_scripts\utility::func_44F5(var_00), self.coil.origin, anglesToForward(self.coil.angles), anglestoup(self.coil.angles));
    triggerfx(self.var_3F3F, 0.25);
  }

  if(isDefined(self.panel)) {
    if(lib_0547::func_5565(self.open_type, "open_no_panel")) {
      self.panel method_8511();
    } else {
      self.panel.angles = self.panel_open_dest.angles;
    }

    self.panel notsolid();
  }

  self.exposed = 1;
}

pest_hc_runes_close_panel() {
  if(isDefined(self.panel)) {
    self.panel show();
    self.panel solid();
  }

  self.exposed = 0;
  if(isDefined(self.var_3F3F)) {
    self.var_3F3F delete();
  }
}

pest_hc_runes_blow_off_panel() {
  if(isDefined(self.var_3F3F)) {
    self.var_3F3F delete();
  }

  var_00 = pest_hc_util_get_filament_fx(self.coil_color);
  if(isDefined(var_00)) {
    self.var_3F3F = spawnfx(common_scripts\utility::func_44F5(var_00), self.coil.origin, anglesToForward(self.coil.angles), anglestoup(self.coil.angles));
    triggerfx(self.var_3F3F, 0.25);
  }

  if(isDefined(self.panel)) {
    self.panel setModel("zmi_obj_fuse_box_door_dmged_01");
    var_01 = anglesToForward(self.panel.angles);
    self.panel method_82C5(self.coil_origin.origin, var_01 * -80000);
    self.panel common_scripts\utility::func_2CBE(5, ::delete);
  }

  self.exposed = 1;
}

pest_hc_runes_panel_damage_listener() {
  childthread pest_hc_runes_panel_type3_listener();
  childthread pest_hc_runes_panel_type2_listener();
  childthread pest_hc_runes_panel_type1_listener();
  common_scripts\utility::waittill_any("panel_hit_type_1", "panel_hit_type_2", "panel_hit_type_3", "panel_scripted_pop");
  self notify("panel_destroyed");
  thread pest_hc_runes_blow_off_panel();
  thread pest_hc_runes_damage_listener();
}

pest_hc_runes_panel_type3_listener() {
  self endon("panel_destroyed");
  var_00 = "";
  for(var_01 = ""; var_00 != "MOD_GRENADE_SPLASH" && var_00 != "MOD_EXPLOSIVE" && !issubstr(var_01, "flak38") && !issubstr(var_01, "fliegerfaust"); var_01 = var_0B) {
    self.panel waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    var_00 = var_06;
  }

  self notify("panel_hit_type_3");
}

pest_hc_runes_panel_type2_listener() {
  self endon("panel_destroyed");
  var_00 = 0;
  while(!var_00) {
    level waittill("follower swing", var_01, var_02);
    if(distance(self.panel.origin, var_01) < var_02) {
      var_00 = 1;
    }
  }

  self notify("panel_hit_type_2");
}

pest_hc_runes_panel_type1_listener() {
  self endon("panel_destroyed");
  var_00 = 0;
  while(!var_00) {
    level waittill("objective_zombie_exploder_detonation", var_01, var_02);
    if(distance(self.panel.origin, var_01) < var_02) {
      var_00 = 1;
    }
  }

  self notify("panel_hit_type_1");
}

pest_hc_runes_damage_listener() {
  self.rune_current_target = self.optimal_target;
  for(;;) {
    for(;;) {
      if(!isDefined(self.missile_clip)) {
        return;
      }

      self.missile_clip waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
      if(!isDefined(var_09) || !issubstr(var_09, "razergun_") || !self.exposed) {
        continue;
      }

      break;
    }

    if(isDefined(var_01) && isPlayer(var_01)) {
      var_0A = 0;
      if(isDefined(self.optimal_fire_area) && var_01 istouching(self.optimal_fire_area)) {
        var_0A = 1;
      }

      var_01 notify("rune_hit", self, var_0A, var_02, var_03);
    }

    wait 0.05;
  }
}

pest_hc_blade_update_color(param_00) {
  if(!isDefined(param_00.coil_color)) {
    return;
  }

  if(param_00.coil_color == 0) {
    return;
  }

  if(lib_0547::func_5565(self.current_color, param_00.coil_color)) {
    return;
  }

  if(!isDefined(self.current_color)) {
    self.current_color = param_00.coil_color;
    if(isDefined(self.current_trail_fx)) {
      killfxontag(common_scripts\utility::func_44F5(self.current_trail_fx), self, "tag_origin");
    }
  } else {
    if(isDefined(self.color_fx)) {
      self.color_fx delete();
    }

    if(isDefined(self.current_trail_fx)) {
      killfxontag(common_scripts\utility::func_44F5(self.current_trail_fx), self, "tag_origin");
    }

    if(isDefined(self.trail_fx)) {
      self.trail_fx delete();
    }

    self.current_color = pest_hc_util_combine_colors(param_00.coil_color, self.current_color);
  }

  var_01 = pest_hc_util_get_trail_fx(self.current_color);
  var_02 = lib_055A::func_4562(self.origin);
  if(lib_0547::func_5565(var_02, "sub_pens_1_zone")) {
    if(isDefined(level._effect[var_01 + "_int"])) {
      var_01 = var_01 + "_int";
    }
  }

  playFXOnTag(common_scripts\utility::func_44F5(var_01), self, "tag_origin");
  self.current_trail_fx = var_01;
}

pest_hc_blade_runes_hit_watch(param_00) {
  self endon("end_explode");
  self endon("explode");
  self endon("remove");
  self endon("death");
  param_00 endon("death");
  childthread pest_hc_blade_paint_watch(param_00);
  if(!isDefined(level.hc_color_runes)) {
    return;
  }

  for(;;) {
    param_00 waittill("rune_hit", var_01, var_02, var_03, var_04);
    if(!isDefined(self)) {
      continue;
    }

    var_05 = distance(self.origin, var_01.var_9267.origin);
    if(var_05 <= 32) {
      if(common_scripts\utility::func_562E(self.on_scripted_path) || common_scripts\utility::func_562E(var_02)) {
        thread pest_hc_color_runes_launch(var_01, var_03, var_04, param_00, self.current_color);
        lib_0378::func_8D74("ripsaw_charge");
        self delete();
        return;
      } else {
        thread pest_hc_blade_update_color(var_01);
      }

      continue;
    }

    continue;
  }
}

pest_hc_blade_paint_watch(param_00) {
  var_01 = 64;
  var_02 = squared(var_01);
  while(isDefined(self)) {
    if(!isDefined(level.hc_pest) || isDefined(level.hc_pest) && !isalive(level.hc_pest)) {
      wait(1);
      continue;
    }

    if(!isDefined(self.current_color)) {
      wait(0.25);
      continue;
    }

    if(!isDefined(level.hc_pest.desired_color)) {
      wait(1);
      continue;
    }

    if(distancesquared(level.hc_pest.origin + (0, 0, 48), self.origin) < var_02) {
      if(lib_0547::func_5565(level.hc_pest.desired_color, self.current_color)) {
        level.hc_pest notify("hc_pest_hit");
      }

      wait 0.05;
      continue;
    }

    if(isDefined(level.hc_pest.optimal_trigger)) {
      if(self istouching(level.hc_pest.optimal_trigger) && level.hc_pest istouching(level.hc_pest.optimal_trigger)) {
        if(lib_0547::func_5565(level.hc_pest.desired_color, self.current_color)) {
          level.hc_pest notify("hc_pest_hit");
        }

        wait 0.05;
        continue;
      }
    }

    wait 0.05;
  }
}

pest_hc_razergun_monitor() {
  var_00 = maps / mp / zombies / weapons / _zombie_razer_gun::get_razorgun_gunname();
  for(;;) {
    self waittill("missile_fire", var_01, var_02);
    if(isDefined(var_02) && issubstr(var_02, var_00)) {
      if(!isDefined(var_01.var_9255)) {
        var_01.var_9255 = var_01.origin;
      }

      if(!isDefined(var_01.on_scripted_path)) {
        var_01.on_scripted_path = 0;
      }

      var_01 thread pest_hc_blade_runes_hit_watch(self);
    }
  }
}

pest_hc_util_get_filament_fx(param_00) {
  var_01 = undefined;
  if(!isDefined(param_00)) {
    return var_01;
  }

  switch (param_00) {
    case 1:
      var_01 = "zmi_hc_rune_cyan_filament";
      break;

    case 2:
      var_01 = "zmi_hc_rune_magenta_filament";
      break;

    case 3:
      var_01 = "zmi_hc_rune_yellow_filament";
      break;

    case 4:
      var_01 = "zmi_hc_rune_red_filament";
      break;
  }

  return var_01;
}

pest_hc_util_get_blade_fx(param_00) {
  var_01 = undefined;
  if(!isDefined(param_00)) {
    return var_01;
  }

  switch (param_00) {
    case 1:
      var_01 = "zmi_hc_rune_cyan";
      break;

    case 2:
      var_01 = "zmi_hc_rune_magenta";
      break;

    case 3:
      var_01 = "zmi_hc_rune_yellow";
      break;

    case 4:
      var_01 = "zmi_hc_rune_red";
      break;

    case 5:
      var_01 = "zmi_hc_rune_green";
      break;

    case 6:
      var_01 = "zmi_hc_rune_blue";
      break;

    case 7:
      var_01 = "zmi_hc_rune_black";
      break;
  }

  return var_01;
}

pest_hc_util_get_anointed_fx(param_00) {
  var_01 = undefined;
  if(!isDefined(param_00)) {
    return var_01;
  }

  switch (param_00) {
    case 1:
      var_01 = "zmi_hc_pest_anointed_cyan";
      break;

    case 4:
      var_01 = "zmi_hc_pest_anointed";
      break;

    case 5:
      var_01 = "zmi_hc_pest_anointed_green";
      break;

    case 7:
      var_01 = "zmi_hc_pest_anointed_black";
      break;
  }

  return var_01;
}

pest_hc_util_get_trail_fx(param_00) {
  var_01 = undefined;
  if(!isDefined(param_00)) {
    return var_01;
  }

  switch (param_00) {
    case 1:
      var_01 = "zmb_razergun_cyan_trail";
      break;

    case 2:
      var_01 = "zmb_razergun_magenta_trail";
      break;

    case 3:
      var_01 = "zmb_razergun_yellow_trail";
      break;

    case 4:
      var_01 = "zmb_razergun_red_trail";
      break;

    case 5:
      var_01 = "zmb_razergun_green_trail";
      break;

    case 6:
      var_01 = "zmb_razergun_blue_trail";
      break;

    case 7:
      var_01 = "zmb_razergun_white_trail";
      break;
  }

  return var_01;
}

pest_hc_util_combine_colors(param_00, param_01) {
  if(param_00 == param_01) {
    return param_00;
  }

  switch (param_00) {
    case 1:
      if(param_01 == 2) {
        return 6;
      } else if(param_01 == 3) {
        return 5;
      } else if(param_01 == 4) {
        return 7;
      } else if(param_01 == 5) {
        return 5;
      } else if(param_01 == 6) {
        return 6;
      } else if(param_01 == 7) {
        return 7;
      }
      break;

    case 2:
      if(param_01 == 3) {
        return 4;
      } else if(param_01 == 1) {
        return 6;
      } else if(param_01 == 4) {
        return 4;
      } else if(param_01 == 5) {
        return 7;
      } else if(param_01 == 6) {
        return 6;
      } else if(param_01 == 7) {
        return 7;
      }
      break;

    case 3:
      if(param_01 == 2) {
        return 4;
      } else if(param_01 == 1) {
        return 5;
      } else if(param_01 == 4) {
        return 7;
      } else if(param_01 == 5) {
        return 5;
      } else if(param_01 == 6) {
        return 7;
      } else if(param_01 == 7) {
        return 7;
      }
      break;

    default:
      break;
  }
}

pest_hc_util_get_impact_fx(param_00) {
  var_01 = undefined;
  if(!isDefined(param_00)) {
    return var_01;
  }

  switch (param_00) {
    case 1:
      var_01 = "zmi_hc_pest_impact_cyan";
      break;

    case 2:
      var_01 = "zmi_hc_pest_impact_magenta";
      break;

    case 3:
      var_01 = "zmi_hc_pest_impact_yellow";
      break;

    case 4:
      var_01 = "zmi_hc_pest_impact_red";
      break;

    case 5:
      var_01 = "zmi_hc_pest_impact_green";
      break;

    case 6:
      var_01 = "zmi_hc_pest_impact_blue";
      break;

    case 7:
      var_01 = "zmi_hc_pest_impact_black";
      break;
  }

  return var_01;
}

pest_hc_color_runes_launch(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_00.rune_current_target)) {
    var_05 = magicbullet("razergun_zm", param_02, param_00.rune_current_target.origin, param_03);
    var_05.on_scripted_path = 1;
    if(isDefined(param_04)) {
      var_05.current_color = param_04;
    }

    var_05 thread pest_hc_blade_update_color(param_00);
    var_05 thread pest_hc_blade_runes_hit_watch(param_03);
  }
}

pest_hc_main_do_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_05)) {
    var_07 = getEnt(param_05, "targetname");
    if(isDefined(var_07)) {
      level.hc_pest.optimal_trigger = var_07;
    }
  }

  level.hc_pest.desired_color = param_03;
  level.hc_pest thread pest_hc_zombie_wander(param_00, param_01, param_02, param_04);
  var_08 = level.hc_pest common_scripts\utility::waittill_any_return("escort_goal_reached", "death");
  if(lib_0547::func_5565(var_08, "death")) {
    common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
    common_scripts\utility::func_3C7B("flag_hc_escort_active");
    return 0;
  }

  var_08 = level.hc_pest common_scripts\utility::waittill_any_return("hc_pest_hit", "death");
  if(lib_0547::func_5565(var_08, "death")) {
    common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
    common_scripts\utility::func_3C7B("flag_hc_escort_active");
    return 0;
  }

  if(lib_0547::func_5565(var_08, "hc_pest_hit")) {
    common_scripts\utility::flag_set(param_04);
    level.hc_pest lib_0378::func_8D74("charged_ripsaw_hit_pest");
    playFX(common_scripts\utility::func_44F5(pest_hc_util_get_impact_fx(param_03)), level.hc_pest.origin + (0, 0, 32));
    level.hc_pest thread pest_hc_zombie_stun_burst();
    if(level.hc_pest.health < level.hc_pest.maxhealth) {
      if(level.hc_pest.health + int(level.hc_pest.maxhealth * 0.25) > level.hc_pest.maxhealth) {
        level.hc_pest.health = level.hc_pest.maxhealth;
        level.hc_pest.agenthealth = level.hc_pest.maxhealth;
      } else {
        level.hc_pest.agenthealth = level.hc_pest.agenthealth + int(level.hc_pest.maxhealth * 0.25);
        level.hc_pest.health = level.hc_pest.health + int(level.hc_pest.maxhealth * 0.25);
      }

      level.hc_pest notify("escort_heal");
    }

    level.hc_pest notify("hc_pest_stop_wander");
    if(common_scripts\utility::func_562E(level.hc_pest.is_idling)) {
      level.hc_pest pest_hc_zombie_awakenidle();
    }

    if(!common_scripts\utility::func_562E(param_06)) {
      level.hc_pest maps / mp / agents / humanoid / _humanoid_util::func_8318(level.hc_pest.origin, level.hc_pest.angles, "s2_scripted_shock", 0, 0, undefined, 1);
      level.hc_pest.anointed_fx delete();
      level.hc_pest.anointed_fx = spawnlinkedfx(common_scripts\utility::func_44F5(pest_hc_util_get_anointed_fx(param_03)), level.hc_pest.anointed_fx_model, "tag_origin");
      triggerfx(level.hc_pest.anointed_fx);
    }

    return 1;
  }
}

pest_hc_zombie_setup() {
  self.escort_zombie = 1;
  self.isobjectiveexemptfromfog = 1;
  self.var_6816 = 1;
  self.var_C29 = 0;
  self.shouldnotpreventlaststand = 1;
  self.ispassiveexempt = 1;
  self.var_55AB = 1;
  self.var_562B = 1;
  self.ignoreme = 1;
  lib_0547::func_8A6D(1);
  self.on_damage_override = ::pest_hc_zombie_on_damage;
  self.var_297D = ::pest_hc_zombie_custom_movemode;
  maps / mp / agents / _agent_common::func_83FD(5000);
  maps / mp / agents / _agent_utility::func_83FE(level.var_746E);
  self.var_6701 = 1;
  var_00 = spawn("script_model", self.origin);
  var_00 setModel("tag_origin");
  var_00 linkTo(self, "j_mainroot", (0, 0, 0), (0, 0, 0));
  self.anointed_fx_model = var_00;
  self.anointed_fx = spawnlinkedfx(common_scripts\utility::func_44F5("zmi_hc_pest_anointed"), var_00, "tag_origin");
  triggerfx(self.anointed_fx);
  thread setup_escort_pest_failsafe();
}

setup_escort_pest_failsafe() {
  self endon("death");
  for(;;) {
    var_00 = common_scripts\utility::func_A74D("hc_pest_hit", 600);
    if(lib_0547::func_5565(var_00, "timeout")) {
      break;
    }
  }

  if(isDefined(self)) {
    self suicide();
  }
}

pest_hc_zombie_post_drop_setup() {
  self.agentname = &"zombie_island_sacrifice_name";
  self.ignoreme = 0;
  lib_0547::func_8A6D(0);
  self.var_6701 = 0;
  var_00 = 0.3488889;
  self method_85DE(var_00);
  thread maps / mp / zquests / casual / island_ee_util::escort_health_display_start(self, -40);
  thread maps / mp / zquests / casual / island_ee_util::escort_health_display_death_listener();
  thread maps / mp / zquests / casual / island_ee_util::escort_health_display_damage_listener();
  thread maps / mp / zquests / casual / island_ee_util::escort_health_display_heal_listener();
}

pest_hc_zombie_on_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(self.owner)) {
    var_0B = isDefined(param_01) && self.owner == param_01;
    var_0C = maps\mp\_utility::func_118D(self.owner, param_01) || var_0B;
  } else {
    var_0B = 0;
    var_0C = maps\mp\_utility::func_118D(self, param_02);
  }

  if(isDefined(param_01) && function_01EF(param_01)) {
    if(isDefined(param_01.var_A4B)) {
      switch (param_01.var_A4B) {
        case "zombie_generic":
          param_02 = param_02 * 0.25;
          break;

        case "zombie_berserker":
          param_02 = param_02 * 0.35;
          break;

        case "zombie_exploder":
          param_02 = param_02 * 0.5;
          break;

        case "zombie_heavy":
          param_02 = param_02 * 0.75;
          break;

        case "zombie_assassin":
          param_02 = param_02 * 0.9;
          break;

        default:
          param_02 = param_02 * 0.5;
          break;
      }
    }
  }

  lib_054D::func_6BD1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

pest_hc_zombie_wander(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("hc_pest_stop_wander");
  level endon(param_03);
  if(!isDefined(param_01) || !isDefined(param_02)) {
    if(isDefined(param_01)) {
      param_02 = param_01;
    } else if(isDefined(param_02)) {
      param_01 = param_02;
    } else {
      param_01 = 5;
      param_02 = 10;
    }
  }

  if(param_01 > param_02) {
    param_01 = param_02;
  }

  var_04 = randomintrange(0, param_00.size);
  var_05 = common_scripts\utility::func_24A6();
  for(;;) {
    if(common_scripts\utility::func_3C77(param_03)) {
      break;
    }

    if(!isDefined(param_00[var_04])) {
      return;
    }

    var_06 = param_00[var_04];
    self.var_1928 = var_06;
    childthread maps / mp / zquests / casual / island_ee_util::waittill_at_waypoint(var_06);
    self waittill("escort_goal_reached");
    pest_hc_zombie_forceidle();
    if(param_01 == param_02) {
      wait(param_01);
    } else {
      wait(randomintrange(param_01, param_02));
    }

    pest_hc_zombie_awakenidle();
    if(!var_05) {
      if(var_04 + 1 < param_00.size) {
        var_04++;
      } else {
        var_04 = 0;
      }

      continue;
    }

    if(var_04 - 1 < 0) {
      var_04 = param_00.size - 1;
      continue;
    }

    var_04--;
  }
}

pest_hc_zombie_forceidle(param_00) {
  self scragentsetscripted(1);
  self.ignoreall = 1;
  self.is_idling = 1;
  var_01 = "passive_idle_berserker";
  maps / mp / agents / _scripted_agent_anim_util::func_8415(var_01, param_00);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(1, "hc_pest_idle");
  self.var_509A = 1;
}

pest_hc_zombie_awakenidle() {
  maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "hc_pest_idle");
  self scragentsetscripted(0);
  self.var_509A = 0;
  self.ignoreall = 0;
  self.is_idling = 0;
}

pest_hc_zombie_custom_movemode() {
  self.var_64C2 = 0.75 * lib_054D::func_4440();
  return "sprint";
}

pest_hc_zombie_stun_burst() {
  self endon("death");
  lib_0378::func_8D74("aud_stunning_burst_use");
  lib_053A::mini_stunning_burst_execute(self.origin, undefined, 480, 5, undefined, self, undefined, undefined);
}

pest_hc_zombie_get_path_chain(param_00) {
  var_01 = [];
  var_02 = common_scripts\utility::func_46B5(param_00, "targetname");
  var_01[0] = var_02;
  var_03 = var_02;
  for(;;) {
    if(isDefined(var_03.target)) {
      var_04 = common_scripts\utility::func_46B5(var_03.target, "targetname");
      var_01[var_01.size] = var_04;
      var_03 = var_04;
      continue;
    }

    break;
  }

  return var_01;
}

wustling_hc_zombie_setup() {
  self.escort_zombie = 1;
  self.isobjectiveexemptfromfog = 1;
  self.var_6816 = 1;
  self.var_C29 = 0;
  self.shouldnotpreventlaststand = 1;
  self.ispassiveexempt = 1;
  self.var_55AB = 1;
  self.var_562B = 1;
  self.escort_player_distance = 147456;
  self.escort_player_too_close = 5184;
  self.escort_follow_track_time = 4;
  self.escort_blitz_distance = 65536;
  self.escort_blitz_attack_time = 4;
  self.escort_follow_track_time = 4;
  self.var_297D = ::wustling_zombie_custom_movemode;
  maps / mp / agents / _agent_common::func_83FD(4000);
  self.hc_escort_blitz_buffs = [];
  self.hc_escort_blitz_buffs_attack_mod = 1;
  self.elec_cherry_cooldown = 16;
  self.var_6701 = 1;
  self.ignoreme = 1;
  lib_0547::func_8A6D(1);
  maps / mp / agents / _agent_utility::func_83FE(level.var_746E);
  wustling_buff_manager_setup();
  self.custom_think_mode = ::wustling_hc_think;
  self.escort_hit_track_time = 2;
  self.recently_hit_by_player = 0;
  self.recently_hit_player = undefined;
  self.escort_state = undefined;
  self.escort_state_previous = undefined;
  if(!isDefined(level.var_6BD2) || isDefined(level.var_6BD2) && !common_scripts\utility::func_F79(level.var_6BD2, ::wustling_hc_track_player_hit)) {
    lib_054D::func_7BC6(::wustling_hc_track_player_hit);
  }

  thread setup_escort_follower_failsafe();
}

setup_escort_follower_failsafe() {
  self endon("death");
  self endon("zmb_hc_follower_destination");
  for(;;) {
    var_00 = common_scripts\utility::func_A74D("wustling_received_buff", 600);
    if(lib_0547::func_5565(var_00, "timeout")) {
      break;
    }
  }

  if(isDefined(self)) {
    self suicide();
  }
}

wustling_hc_think() {
  if(lib_053C::func_4F9B(1)) {
    return;
  }

  lib_053C::func_647();
}

wustling_zombie_custom_movemode() {
  self.var_672D = self.hc_escort_blitz_buffs_attack_mod;
  if(isDefined(self.hc_escort_blitz_buffs) && common_scripts\utility::func_F79(self.hc_escort_blitz_buffs, "runperk")) {
    return "sprint";
  }

  var_00 = lib_0567::func_ABC3();
  return var_00;
}

wustling_hc_track_player_hit(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(common_scripts\utility::func_562E(self.var_AC10) || !isDefined(self.var_A4B) || !isDefined(param_01) || !common_scripts\utility::func_562E(self.isfreezerzombie) || !isDefined(level.hc_wustling) || isDefined(level.hc_wustling) && self != level.hc_wustling) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(!maps\mp\_utility::func_118D(self, param_01)) {
    return;
  }

  self notify("wustling_escort_hit_by_player");
  self endon("wustling_escort_hit_by_player");
  self.recently_hit_by_player = 1;
  self.recently_hit_player = param_01;
  wait(self.escort_hit_track_time);
  self.recently_hit_by_player = 0;
  self.recently_hit_player = undefined;
}

wustling_hc_cleanup_org(param_00) {
  self waittill("death");
  level.hc_wustling = undefined;
  param_00 delete();
}

wustling_hc_zombie_post_drop_setup() {
  self.agentname = &"zombie_island_sacrifice_name";
  var_00 = 0.3488889;
  self method_85DE(var_00);
  self.var_6701 = 0;
  self.ignoreme = 0;
  lib_0547::func_8A6D(0);
  thread maps / mp / zquests / casual / island_ee_util::escort_health_display_start(self, -40);
  thread maps / mp / zquests / casual / island_ee_util::escort_health_display_death_listener();
  thread maps / mp / zquests / casual / island_ee_util::escort_health_display_damage_listener();
  thread maps / mp / zquests / casual / island_ee_util::escort_health_display_heal_listener();
  self.player_track_org = common_scripts\utility::func_8FFC();
  self.player_track_org linkTo(self, "tag_origin");
  thread wustling_hc_cleanup_org(self.player_track_org);
}

wustling_escort_quest_main(param_00) {
  level.hc_wustling = param_00;
  level.hc_wustling endon("death");
  level.hc_wustling wustling_hc_zombie_post_drop_setup();
  level.hc_wustling thread wustling_hc_freezer_reset();
  var_01 = common_scripts\utility::func_46B5("wustling_hc_waypoint_start", "script_noteworthy");
  var_02 = common_scripts\utility::func_46B5("wustling_hc_waypoint_reloadspeed", "script_noteworthy");
  var_03 = common_scripts\utility::func_46B5("wustling_hc_waypoint_shootspeed", "script_noteworthy");
  var_04 = common_scripts\utility::func_46B5("wustling_hc_waypoint_meleedamage", "script_noteworthy");
  var_05 = common_scripts\utility::func_46B5("wustling_hc_waypoint_runspeed", "script_noteworthy");
  var_06 = common_scripts\utility::func_46B5("wustling_hc_waypoint_shock", "script_noteworthy");
  var_07 = common_scripts\utility::func_46B5("wustling_hc_waypoint_revive", "script_noteworthy");
  var_08 = common_scripts\utility::func_46B5("wustling_hc_waypoint_end", "script_noteworthy");
  level.hc_wustling.wps_wander_sequence = [var_02, var_06, var_03, var_05, var_04, var_07];
  var_09 = ["doubletap", "punchperk", "runperk", "quickrevive"];
  level.hc_wustling.var_1928 = var_01;
  level.hc_wustling.var_11AB = 0;
  while(distance(var_01.origin, level.hc_wustling.origin) > 64) {
    wait 0.05;
  }

  while(!common_scripts\utility::func_3C77("zmb_hc_follower_destination")) {
    var_0A = level.hc_wustling wustling_escort_get_state();
    var_0B = undefined;
    switch (level.hc_wustling.escort_state) {
      case "track_hit":
        var_0B = ::wustling_track_player;
        break;

      case "close_blitz":
        var_0B = ::wustling_attack_blitz;
        break;

      case "track_player":
        var_0B = ::wustling_track_player;
        break;

      default:
        break;
    }

    if(isDefined(var_0B)) {
      level.hc_wustling[[var_0B]](var_0A);
    } else {
      level.hc_wustling wustling_wander_wp_walkto(var_0A);
    }

    wait(0.1);
    var_0A = undefined;
    var_0B = undefined;
    if(common_scripts\utility::func_F78(level.hc_wustling.hc_escort_blitz_buffs, var_09)) {
      break;
    }
  }

  level.hc_wustling.var_1928 = var_08;
  while(distance(var_08.origin, level.hc_wustling.origin) > 64) {
    wait 0.05;
  }

  maps\mp\_utility::func_2CED(0.75, ::maps / mp / zquests / casual / island_ee_util::monk_head_dialogue, "zmb_isla_monk_ripthestrengthfromthemigh", 1);
  common_scripts\utility::flag_set("zmb_hc_follower_destination");
  thread wustling_boss_fight_wait();
  common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
  level.hc_wustling suicide();
}

wustling_hc_freezer_reset() {
  self waittill("death");
  wait 0.05;
  if(!common_scripts\utility::func_3C77("zmb_hc_follower_destination")) {
    common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
    common_scripts\utility::func_3C7B("flag_hc_escort_active");
  }
}

wustling_boss_fight_wait() {
  pomel_room_players_wait();
  maps / mp / zquests / casual / island_ee_util::clear_all_zombies();
  thread pomel_door_close();
  lib_0547::func_AAFB("isolated_room_close_to_pool_trig");
  pagan_room_do_wustling_rush();
  pomel_door_open();
}

wustling_escort_get_state() {
  if(self.recently_hit_by_player) {
    self.escort_state = "track_hit";
    return self.recently_hit_player;
  }

  foreach(var_01 in self.wps_wander_sequence) {
    if(distancesquared(self.origin, var_01.origin) > self.escort_blitz_distance) {
      continue;
    }

    self.escort_state = "close_blitz";
    return var_01;
  }

  foreach(var_04 in level.players) {
    if(distancesquared(self.origin, var_04.origin) > self.escort_player_distance) {
      continue;
    }

    self.escort_state = "track_player";
    return var_04;
  }

  self.escort_state = "wander_to_blitz";
  if(!isDefined(self.escort_state_previous) || self.escort_state != self.escort_state_previous) {
    self.escort_state_previous = self.escort_state;
    self.wps_wander_sequence = function_01AC(self.wps_wander_sequence, self.origin);
  }

  return self.wps_wander_sequence[0];
}

wustling_track_player(param_00) {
  self notify("wustling_begin_tracking_player");
  self endon("wustling_begin_tracking_player");
  self endon("wustling_player_track_failed");
  self endon("wustling_received_buff");
  childthread wustling_track_player_link_think(self.player_track_org, param_00);
  wait(self.escort_follow_track_time);
  self notify("wustling_player_track_timeout");
}

wustling_track_player_link_think(param_00, param_01) {
  var_02 = 0;
  level.hc_wustling.var_1928 = self.player_track_org;
  for(;;) {
    if(!common_scripts\utility::func_562E(var_02) && distancesquared(param_01.origin, self.origin) > self.escort_player_too_close) {
      thread hc_safe_linkTo(param_00, param_01);
      wustling_disable_idle();
      wait 0.05;
      var_02 = 1;
    } else if(common_scripts\utility::func_562E(var_02) && !common_scripts\utility::func_562E(self.hc_force_disable_idle) && distancesquared(param_01.origin, self.origin) <= self.escort_player_too_close) {
      wustling_enable_idle();
      var_02 = 0;
      param_01 notify("wustling_break_safelink");
    } else {}

    wait 0.05;
  }
}

hc_safe_linkTo(param_00, param_01) {
  self notify("wustling_begin_safelinkto");
  self endon("wustling_begin_safelinkto");
  self endon("wustling_begin_tracking_player");
  self endon("wustling_player_track_timeout");
  self endon("wustling_break_safelink");
  param_00.origin = param_01 gettagorigin("TAG_ORIGIN");
  param_00 linktosynchronizedparent(param_01, "TAG_ORIGIN");
  param_01 common_scripts\utility::waittill_any("death", "disconnect", "wustling_break_safelink");
  param_00.origin = self gettagorigin("TAG_ORIGIN");
  param_00 linktosynchronizedparent(self, "TAG_ORIGIN");
  self notify("wustling_player_track_failed");
}

perk_machine_open(param_00) {
  var_01 = 0;
  if(isDefined(level.hc_wustling) && !common_scripts\utility::func_3C77("zmb_hc_follower_destination")) {
    if(isDefined(level.hc_wustling.hc_escort_blitz_buffs) && !common_scripts\utility::func_F79(level.hc_wustling.hc_escort_blitz_buffs, param_00.var_6F63)) {
      var_01 = distancesquared(level.hc_wustling.origin, param_00.origin) < 25600;
    }
  }

  return var_01;
}

wustling_attack_blitz(param_00) {
  var_01 = 0;
  self.hc_force_disable_idle = 1;
  wustling_disable_idle();
  level.hc_wustling.var_1928 = param_00;
  while(distance2d(level.hc_wustling.origin, level.hc_wustling.var_1928.origin) > 24) {
    if(common_scripts\utility::func_562E(self.recently_hit_by_player)) {
      self.hc_force_disable_idle = 0;
      return;
    }

    wait 0.05;
  }

  var_02 = "scripted_enhance";
  var_03 = maps / mp / agents / _scripted_agent_anim_util::func_434D(var_02);
  self setOrigin(param_00.origin, 0);
  thread maps / mp / agents / humanoid / _humanoid_util::func_8318(param_00.origin, param_00.angles, var_03, 0, 0, undefined, 1, 0);
  wait(2);
  if(self.hc_escort_blitz_buffs.size >= 4) {
    playFXOnTag(common_scripts\utility::func_44F5("zmb_pm_blood_use"), self, "J_SpineUpper");
    self suicide();
  }

  level.hc_wustling wustling_get_buff(param_00);
  level.hc_wustling.wps_wander_sequence = common_scripts\utility::func_F93(level.hc_wustling.wps_wander_sequence, param_00);
  self.hc_force_disable_idle = 0;
}

wustling_get_buff(param_00) {
  if(isstring(param_00)) {
    var_01 = param_00;
  } else {
    var_01 = var_01.script_noteworthy;
  }

  self notify("wustling_received_buff");
  var_02 = undefined;
  switch (var_01) {
    case "wustling_hc_waypoint_reloadspeed":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "fastreload";
      thread wustling_reload_buff_handle(var_02, "fastreload");
      break;

    case "wustling_hc_waypoint_shootspeed":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "doubletap";
      thread wustling_shootspeed_buff_handle(var_02, "doubletap");
      break;

    case "wustling_hc_waypoint_meleedamage":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "punchperk";
      thread wustling_meleedamage_buff_handle(var_02, "punchperk");
      break;

    case "wustling_hc_waypoint_runspeed":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "runperk";
      thread wustling_runspeed_buff_handle(var_02, "runperk");
      break;

    case "wustling_hc_waypoint_shock":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "electriccherry";
      thread wustling_shock_buff_handle(var_02, "electriccherry");
      break;

    case "wustling_hc_waypoint_revive":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "quickrevive";
      thread wustling_revive_buff_handle(var_02, "quickrevive");
      break;

    default:
      break;
  }
}

wustling_reload_buff_handle(param_00, param_01) {
  self.hc_escort_blitz_buffs_attack_mod = self.hc_escort_blitz_buffs_attack_mod + 0.1;
  wustling_buff_manager_add(param_01);
}

wustling_shootspeed_buff_handle(param_00, param_01) {
  self.hc_escort_blitz_buffs_attack_mod = self.hc_escort_blitz_buffs_attack_mod + 0.1;
  wustling_buff_manager_add(param_01);
}

wustling_meleedamage_buff_handle(param_00, param_01) {
  self.var_60E2 = self.var_60E2 * 1.25;
  wustling_buff_manager_add(param_01);
}

wustling_runspeed_buff_handle(param_00, param_01) {
  wustling_buff_manager_add(param_01);
}

wustling_shock_buff_handle(param_00, param_01) {
  thread wustling_electriccherry_think();
  wustling_buff_manager_add(param_01);
}

wustling_buff_manager_setup() {
  self.buff_slot_4 = spawn("script_model", self.origin);
  self.buff_slot_4 setModel("tag_origin");
  self.buff_slot_4 linkTo(self, "J_Neck", (0, 5, 0), (60, 30, -90));
  self.buff_slot_4.var_3F44 = "zmb_electroschnelle_off_blood";
  self.buff_slot_4.sort_id = 4;
  self.buff_slot_4.var_3F3F = spawnlinkedfx(level._effect[self.buff_slot_4.var_3F44], self.buff_slot_4, "TAG_ORIGIN");
  triggerfx(self.buff_slot_4.var_3F3F);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.buff_slot_4);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.buff_slot_4.var_3F3F);
  self.buff_slot_3 = spawn("script_model", self.origin);
  self.buff_slot_3 setModel("tag_origin");
  self.buff_slot_3 linkTo(self, "J_Spine4", (4, 6, 0), (50, 30, -90));
  self.buff_slot_3.sort_id = 3;
  self.buff_slot_3.var_3F44 = "zmb_electroschnelle_off_blood";
  self.buff_slot_3.var_3F3F = spawnlinkedfx(level._effect[self.buff_slot_3.var_3F44], self.buff_slot_3, "TAG_ORIGIN");
  triggerfx(self.buff_slot_3.var_3F3F);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.buff_slot_3);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.buff_slot_3.var_3F3F);
  self.buff_slot_2 = spawn("script_model", self.origin);
  self.buff_slot_2 setModel("tag_origin");
  self.buff_slot_2 linkTo(self, "J_SpineUpper", (4, 6, 0), (40, 45, -90));
  self.buff_slot_2.sort_id = 2;
  self.buff_slot_2.var_3F44 = "zmb_electroschnelle_off_blood";
  self.buff_slot_2.var_3F3F = spawnlinkedfx(level._effect[self.buff_slot_2.var_3F44], self.buff_slot_2, "TAG_ORIGIN");
  triggerfx(self.buff_slot_2.var_3F3F);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.buff_slot_2);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.buff_slot_2.var_3F3F);
  self.buff_slot_1 = spawn("script_model", self.origin);
  self.buff_slot_1 setModel("tag_origin");
  self.buff_slot_1 linkTo(self, "J_SpineLower", (4, 5, 0), (30, 30, -90));
  self.buff_slot_1.sort_id = 1;
  self.buff_slot_1.var_3F44 = "zmb_electroschnelle_off_blood";
  self.buff_slot_1.var_3F3F = spawnlinkedfx(level._effect[self.buff_slot_1.var_3F44], self.buff_slot_1, "TAG_ORIGIN");
  triggerfx(self.buff_slot_1.var_3F3F);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.buff_slot_1);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.buff_slot_1.var_3F3F);
  self.buff_slots = [self.buff_slot_1, self.buff_slot_2, self.buff_slot_3, self.buff_slot_4];
  self.buff_empty_slots = [self.buff_slot_1, self.buff_slot_2, self.buff_slot_3, self.buff_slot_4];
  self.active_buff_slots = [];
}

wustling_buff_manager_add(param_00) {
  var_01 = self.buff_empty_slots[0];
  var_01.buff_id = param_00;
  self.buff_empty_slots = common_scripts\utility::func_F9A(self.buff_empty_slots, 0);
  var_01.var_3F3F delete();
  self.active_buff_slots[self.active_buff_slots.size] = var_01;
  var_01.var_3F44 = wustling_buff_manager_get_buff_id(param_00);
  var_01.var_3F3F = spawnlinkedfx(level._effect[var_01.var_3F44], var_01, "TAG_ORIGIN");
  triggerfx(var_01.var_3F3F);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(var_01.var_3F3F);
}

wustling_buff_manager_remove(param_00) {
  var_01 = get_active_buff_slot(param_00);
  var_01.buff_id = undefined;
  self.hc_escort_blitz_buffs = common_scripts\utility::func_F93(self.hc_escort_blitz_buffs, param_00);
  self.active_buff_slots = common_scripts\utility::func_F93(self.active_buff_slots, var_01);
  self.buff_empty_slots = common_scripts\utility::func_F6F(self.buff_empty_slots, var_01);
  self.buff_empty_slots = common_scripts\utility::func_FA4(self.buff_empty_slots, ::sort_empty_slots);
  var_01.var_3F3F delete();
  var_01.var_3F44 = "zmb_electroschnelle_off_blood";
  var_01.var_3F3F = spawnlinkedfx(level._effect[var_01.var_3F44], var_01, "TAG_ORIGIN");
  triggerfx(var_01.var_3F3F);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(var_01.var_3F3F);
}

get_active_buff_slot(param_00) {
  foreach(var_02 in self.active_buff_slots) {
    if(isDefined(var_02.buff_id) && var_02.buff_id == param_00) {
      return var_02;
    }
  }
}

sort_empty_slots() {
  return self.sort_id;
}

wustling_buff_manager_get_buff_id(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "fastreload":
      var_01 = "zmb_electroschnelle_on_blood";
      break;

    case "doubletap":
      var_01 = "zmb_electroschnelle_on_storm";
      break;

    case "punchperk":
      var_01 = "zmb_electroschnelle_on_storm";
      break;

    case "runperk":
      var_01 = "zmb_electroschnelle_on_blood";
      break;

    case "electriccherry":
      var_01 = "zmb_electroschnelle_on_death";
      break;

    case "quickrevive":
      var_01 = "zmb_electroschnelle_on_moon";
      break;

    default:
      break;
  }

  return var_01;
}

wustling_electriccherry_think() {
  self notify("activate_shock_buff");
  self endon("activate_shock_buff");
  self endon("death");
  var_00 = common_scripts\utility::func_5D92(0.15, 0, 1, 1, 1045);
  var_01 = common_scripts\utility::func_5D92(0.75, 0, 1, 32, 128);
  wait(self.elec_cherry_cooldown);
  while(isalive(self)) {
    playFX(common_scripts\utility::func_44F5("zmb_elec_cherry_wv"), self.origin);
    lib_0378::func_8D74("electric_cherry_vfx");
    playfxontagforclients(common_scripts\utility::func_44F5("zmb_elec_cherry_player"), self, "J_Spine4", self);
    var_02 = maps / mp / agents / _agent_utility::func_43FD("all");
    var_02 = common_scripts\utility::func_40B0(self.origin, var_02, undefined, undefined, var_01);
    var_03 = common_scripts\utility::func_40B0(self.origin, level.players, undefined, undefined, var_01);
    foreach(var_05 in var_02) {
      if(var_05 == self) {
        continue;
      }

      var_05 dodamage(var_00, var_05.origin, self, self, undefined, "electric_cherry_zm");
      playFX(common_scripts\utility::func_44F5("zmb_elec_cherry_zombie"), var_05.origin + (0, 0, 40));
    }

    foreach(var_08 in var_03) {
      var_08 dodamage(var_00 / 5, self.origin, undefined, undefined, undefined, "electric_cherry_zm");
      playFX(common_scripts\utility::func_44F5("zmb_elec_cherry_zombie"), var_08.origin + (0, 0, 40));
    }

    wait(self.elec_cherry_cooldown);
  }
}

wustling_revive_buff_handle(param_00, param_01) {
  thread wustling_revive_think();
  wustling_buff_manager_add(param_01);
}

wustling_revive_think() {
  self notify("activate_revive_buff");
  self endon("activate_revive_buff");
  if(!isDefined(level.var_6BD2) || isDefined(level.var_6BD2) && !common_scripts\utility::func_F79(level.var_6BD2, ::wustling_revive_listener)) {
    lib_054D::func_7BC6(::wustling_revive_listener);
  }

  common_scripts\utility::waittill_any("death", "consume_revive_buff");
}

wustling_revive_listener(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(self.hc_escort_blitz_buffs) || !common_scripts\utility::func_F79(self.hc_escort_blitz_buffs, "quickrevive") || self.health - param_02 > 0) {
    return;
  }

  self notify("consume_revive_buff");
  wustling_buff_manager_remove("quickrevive");
  self.var_480F = 1;
  self.ignoreme = 1;
  self.health = self.maxhealth;
  if(!common_scripts\utility::func_562E(self.var_561D)) {
    thread lib_0547::func_7D1A("nuke_stun", [param_01.origin]);
  }

  killfxontag(common_scripts\utility::func_44F5("zmi_hc_rune_green"), self, "J_SpineUpper");
  playFXOnTag(common_scripts\utility::func_44F5("zmi_hc_pest_anointed_green"), self, "J_SpineUpper");
  wait(4);
  killfxontag(common_scripts\utility::func_44F5("zmi_hc_pest_anointed_green"), self, "J_SpineUpper");
  self.var_480F = 0;
}

wustling_wander_wp_walkto(param_00) {
  wustling_disable_idle();
  if(distance2d(level.hc_wustling.origin, param_00.origin) < 64) {
    self.wps_wander_sequence = common_scripts\utility::func_F93(level.hc_wustling.wps_wander_sequence, param_00);
    return;
  }

  level.hc_wustling.var_1928 = param_00;
}

pagan_room_do_wustling_rush() {
  var_00 = "top";
  var_01 = common_scripts\utility::func_46B5("hc_wustling_boss_spawn", "targetname");
  var_02 = common_scripts\utility::func_46B7("hc_wustling_buddy_spawn", "targetname");
  var_03 = ["wustling_hc_waypoint_shootspeed", "wustling_hc_waypoint_meleedamage", "wustling_hc_waypoint_runspeed", "wustling_hc_waypoint_revive"];
  var_04 = 0;
  var_05 = "zombie_heavy";
  lib_0547::func_7BA9(::anointed_zombie_death_listener);
  if(level.players.size >= 1) {
    var_02 = common_scripts\utility::func_F9A(var_02, var_02.size);
  }

  if(level.players.size >= 2) {
    var_02 = common_scripts\utility::func_F9A(var_02, var_02.size);
  }

  var_06 = int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_escort_hc_follower_spawn_numbers"));
  var_07 = 0;
  var_08 = 0;
  while(var_08 < var_06) {
    if(var_07 >= var_02.size) {
      var_07 = 0;
    }

    var_02[var_07].var_8C95 = 1;
    var_02[var_07].ignorehidingskyspawner = 1;
    var_09 = lib_054D::func_90BA(var_05, var_02[var_07], "beach_rush_intro", 0, 1, 0);
    var_09 wustling_miniboss_setup();
    var_09 maps / mp / agents / _agent_common::func_83FD(int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_escort_hc_follower_health_buddy")));
    var_09.pommel_room_boss = 1;
    var_0A = common_scripts\utility::random(var_03);
    var_03 = common_scripts\utility::func_F93(var_03, var_0A);
    var_07++;
    var_08++;
    wait 0.05;
    var_09 wustling_get_buff(var_0A);
    wait(0.75);
  }

  var_01.var_8C95 = 1;
  var_01.ignorehidingskyspawner = 1;
  var_0B = lib_054D::func_90BA(var_05, var_01, "beach_rush_intro", 0, 1, 0);
  var_0B.pommel_room_boss = 1;
  var_0B maps / mp / agents / _agent_common::func_83FD(int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_escort_hc_follower_health_main")));
  var_0B wustling_miniboss_setup();
  var_0B.is_anointed = 1;
  level.hc_wustling = var_0B;
  wait 0.05;
  wustling_give_correct_buffs();
  common_scripts\utility::flag_set("anointed_zombies_done_spawning");
  wait_for_all_bosses_defeated();
  lib_054D::func_2D8D(::wustling_revive_listener);
  lib_0547::func_2D8C(::anointed_zombie_death_listener);
  common_scripts\utility::flag_set("zmb_hc_follower_destination");
  common_scripts\utility::func_3C7B("flag_hc_escort_active");
}

wustling_miniboss_setup() {
  self.isobjectiveexemptfromfog = 1;
  self.var_6816 = 0;
  self.var_C29 = 0;
  self.var_562B = 1;
  self.var_55AB = 1;
  self.var_297D = ::wustling_zombie_custom_movemode;
  maps / mp / agents / _agent_common::func_83FD(maps / mp / zquests / casual / island_ee_util::get_health_of_zombies_at_round(level.var_A980, 2.5, "zombie_heavy"));
  self.hc_escort_blitz_buffs = [];
  self.hc_escort_blitz_buffs_attack_mod = 1;
  self.elec_cherry_cooldown = 12;
  lib_0547::func_84CB();
  wustling_buff_manager_setup();
}

wustling_give_correct_buffs() {
  level notify("give_hc_wustling_full_buffs");
  level endon("give_hc_wustling_full_buffs");
  while(!isDefined(level.hc_wustling)) {
    wait 0.05;
  }

  level.hc_wustling wustling_get_buff("wustling_hc_waypoint_shootspeed");
  level.hc_wustling wustling_get_buff("wustling_hc_waypoint_meleedamage");
  level.hc_wustling wustling_get_buff("wustling_hc_waypoint_runspeed");
  level.hc_wustling wustling_get_buff("wustling_hc_waypoint_revive");
}

wustling_enable_idle() {
  if(!common_scripts\utility::func_562E(self.hc_forced_idle)) {
    wustling_hc_zombie_forceidle();
    self.hc_forced_idle = 1;
  }
}

wustling_disable_idle() {
  if(common_scripts\utility::func_562E(self.hc_forced_idle)) {
    wustling_hc_zombie_awakenidle();
    self.hc_forced_idle = undefined;
  }
}

wustling_hc_zombie_forceidle(param_00) {
  self scragentsetscripted(1);
  self.ignoreall = 1;
  self.is_idling = 1;
  var_01 = "passive_idle_fol";
  maps / mp / agents / _scripted_agent_anim_util::func_8415(var_01, param_00);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(1, "hc_heavy_idle");
  self.var_509A = 1;
}

wustling_hc_zombie_awakenidle() {
  maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "hc_heavy_idle");
  self scragentsetscripted(0);
  self.var_509A = 0;
  self.ignoreall = 0;
  self.is_idling = 0;
}

assassin_escort_quest_main(param_00) {
  level.hc_assassin = param_00;
  level.hc_assassin assassin_hc_zombie_post_drop_setup();
  var_01 = common_scripts\utility::func_46B5("hc_asn_first_exit", "targetname");
  level.hc_assassin.var_1928 = var_01;
  level.hc_assassin childthread maps / mp / zquests / casual / island_ee_util::waittill_at_waypoint(var_01, 96, 1);
  level.hc_assassin waittill("escort_goal_reached");
  if(isalive(level.hc_assassin)) {
    level.hc_assassin.var_1DEB = 1;
    level.hc_assassin suicide();
  }

  if(!isDefined(level.current_fog_flag) && maps / mp / mp_zombie_island_ee_fog_manager::get_is_fog_active()) {
    maps / mp / mp_zombie_island_ee_fog_manager::wait_till_fog_active();
  }

  maps / mp / mp_zombie_island_fog_behavior::set_foggy_passive_behavior(0);
  level thread maps / mp / mp_zombie_island_ee_fog_manager::set_fog_locked_to_on();
  common_scripts\utility::func_3C7B("flag_hc_asn_found_1");
  common_scripts\utility::func_3C7B("flag_hc_asn_found_2");
  common_scripts\utility::func_3C7B("flag_hc_asn_found_3");
  assassin_hc_hide_point_reset();
  foreach(var_03 in ["flag_hc_asn_found_1", "flag_hc_asn_found_2", "flag_hc_asn_found_3"]) {
    var_04 = assassin_hc_main_do_hide_and_seek(var_03);
    if(!common_scripts\utility::func_562E(var_04)) {
      common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
      common_scripts\utility::func_3C7B("flag_hc_escort_active");
      return;
    }
  }

  maps / mp / mp_zombie_island_fog_behavior::set_foggy_passive_behavior(1);
  maps / mp / mp_zombie_island_ee_fog_manager::unlock_fog_from_lock();
  maps / mp / mp_zombie_island_ee_fog_manager::toggle_next_fog_state();
  common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
  common_scripts\utility::flag_set("flag_hc_asn_escort_complete");
  run_assassin_escort_battle();
}

run_assassin_escort_battle() {
  maps\mp\_utility::func_2CED(0.75, ::maps / mp / zquests / casual / island_ee_util::monk_head_dialogue, "zmb_isla_monk_nerthushaschosenafavoredo", 1);
  pomel_room_players_wait();
  maps / mp / zquests / casual / island_ee_util::clear_all_zombies();
  thread pomel_door_close();
  lib_0547::func_AAFB("isolated_room_close_to_pool_trig");
  lib_0547::func_7BA9(::anointed_zombie_death_listener);
  var_00 = common_scripts\utility::func_46B5("zombie_hc_assassin_pagan_room_spawner", "targetname");
  var_01 = common_scripts\utility::func_46B5("hc_assassin_cower_point", "targetname");
  var_02 = maps / mp / zombies / zombie_assassin_spawner_logic::spawn_an_assassin(undefined, undefined, var_00, 0, "Phase 2: IDLE TRANSITION", 1, 1, undefined, get_worship_alarm_rules(), undefined, ["isolated_room_zone"]);
  var_02.var_6816 = 0;
  var_02.var_480F = 1;
  var_02.additional_anim = [::walk_a_bit, "walk_2_crouch"];
  var_02.must_gib_head = 1;
  var_02 maps / mp / agents / _agent_common::func_83FD(int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_escort_hc_assassin_health_main")));
  var_02.is_anointed = 1;
  var_02.skipped_straight_to_idle = 1;
  var_02.pommel_room_boss = 1;
  var_03 = spawn("script_model", var_02.origin);
  var_03 setModel("tag_origin");
  var_03 linkTo(var_02, "j_mainroot", (0, 0, 0), (0, 0, 0));
  var_02.anointed_fx_model = var_03;
  var_02.anointed_fx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_dlc1_assn_hc_int"), var_03, "tag_origin");
  var_03 maps / mp / agents / _agent_utility::deleteentonagentdeath(var_02);
  var_02.anointed_fx maps / mp / agents / _agent_utility::deleteentonagentdeath(var_02);
  triggerfx(var_02.anointed_fx);
  common_scripts\utility::flag_set("anointed_zombies_done_spawning");
  wait_for_all_bosses_defeated();
  pomel_door_open();
  lib_0547::func_2D8C(::anointed_zombie_death_listener);
  common_scripts\utility::flag_set("zmb_hc_assassin_destination");
  common_scripts\utility::func_3C7B("flag_hc_escort_active");
}

walk_a_bit() {
  self endon("death");
  thread maps / mp / agents / _scripted_agent_anim_util::func_71FA("walk_asn_slow", 0, 1, "stop_walk", "stop_now");
  wait(2.5);
  self.var_480F = 0;
}

assassin_hc_zombie_setup() {
  self.escort_zombie = 1;
  self.isobjectiveexemptfromfog = 1;
  self.var_6816 = 1;
  self.var_C29 = 0;
  self.ignoreme = 1;
  lib_0547::func_8A6D(1);
  self.shouldnotpreventlaststand = 1;
  self.ispassiveexempt = 1;
  self.failsafe_exempt = 1;
  self.var_55AB = 1;
  self.var_562B = 1;
  self.optionaldisablefogsensitivity = 1;
  self.var_6701 = 1;
  if(isDefined(level.last_hc_assassin_health)) {
    maps / mp / agents / _agent_common::func_83FD(level.last_hc_assassin_health);
  } else {
    maps / mp / agents / _agent_common::func_83FD(2000);
  }

  maps / mp / agents / _agent_utility::func_83FE(level.var_746E);
  self.custom_think_mode = ::assassin_hc_zombie_think;
  self.var_297D = ::assassin_hc_zombie_custom_move_mode;
  self.on_damage_override = ::assassin_hc_zombie_on_damage;
  self.assassin_modifier = "zombie_assassin_hc";
  var_00 = spawn("script_model", self.origin);
  var_00 setModel("tag_origin");
  var_00 linkTo(self, "j_mainroot", (0, 0, 0), (0, 0, 0));
  self.anointed_fx_model = var_00;
  self.anointed_fx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_dlc1_assn_hc_int"), var_00, "tag_origin");
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.anointed_fx);
  triggerfx(self.anointed_fx);
  var_01 = spawnStruct();
  var_01.var_3F11 = [];
  self.aggrofuncsoverride = var_01;
  thread setup_escort_assassin_failsafe();
}

setup_escort_assassin_failsafe() {
  self endon("death");
  for(;;) {
    var_00 = level common_scripts\utility::func_A74D("hc_assassin_found", 600);
    if(lib_0547::func_5565(var_00, "timeout")) {
      break;
    }
  }

  if(isDefined(self)) {
    level notify("hc_assassin_killed");
    self suicide();
  }
}

assassin_hc_zombie_post_drop_setup() {
  self.optionalinitialstate = "Phase 4: EXITING";
  self.ignorenpcs = 1;
  self.assassinmustleave = 1;
  self.assassinkillonexit = 1;
  self.looking_for_exit = 1;
  self.var_6701 = 0;
}

assassin_hc_zombie_spawn_at_nearest_point(param_00) {
  var_01 = param_00;
  var_02 = 0;
  var_03 = 1;
  foreach(var_05 in level.players) {
    var_06 = common_scripts\utility::within_fov(var_05 getEye(), var_05 geteyeangles(), param_00.origin + (0, 0, 32), cos(32.5));
    var_07 = bullettracepassed(var_05 getEye(), param_00.origin + (0, 0, 32), 0);
    if(var_06 || var_07) {
      var_02 = 1;
      break;
    }
  }

  if(var_02) {
    var_01 = maps / mp / zombies / zombie_assassin_spawner_logic::get_valid_assassin_spawner(param_00.origin);
    var_03 = 0;
  }

  var_09 = lib_054D::func_90BA("zombie_assassin", var_01, "hc assassin spawn", 0, 1, 0);
  var_09 assassin_hc_zombie_setup();
  var_09.var_6701 = 0;
  var_09.ignoreme = 0;
  var_09 lib_0547::func_8A6D(0);
  return [var_09, var_03];
}

assassin_hc_main_do_hide_and_seek(param_00) {
  lib_0547::register_allykilledfunc(::assassin_hc_zombie_death_listener);
  var_01 = undefined;
  for(;;) {
    thread assassin_hc_zombie_hide();
    var_01 = level common_scripts\utility::waittill_any_return("hc_assassin_killed", "hc_assassin_found", "hc_assassin_recycled");
    if(lib_0547::func_5565(var_01, "hc_assassin_recycled")) {
      continue;
    } else {
      break;
    }
  }

  lib_0547::deregister_allykilledfunc(::assassin_hc_zombie_death_listener);
  if(lib_0547::func_5565(var_01, "hc_assassin_found")) {
    common_scripts\utility::flag_set(param_00);
    level.hc_assassin assassin_hc_zombie_retreat_and_suicide(1);
    return 1;
  }

  if(lib_0547::func_5565(var_01, "hc_assassin_killed")) {
    return 0;
  }
}

assassin_hc_zombie_retreat_and_suicide(param_00) {
  if(common_scripts\utility::func_562E(param_00)) {
    level.last_hc_assassin_health = self.health;
  } else {
    level.last_hc_assassin_health = undefined;
  }

  self.ignoreme = 1;
  assassin_hc_zombie_clear_attract();
  self.readytosprint = 1;
  var_01 = "scripted_idle_to_vul";
  var_02 = maps / mp / agents / _scripted_agent_anim_util::func_434D(var_01);
  maps / mp / agents / humanoid / _humanoid_util::func_8318(self.origin, self.angles, var_02, 0, 0, undefined, 1, 0);
  self.var_1928 = maps / mp / zombies / zombie_assassin_spawner_logic::seek_exit_that_maintains_momentum(1);
  self scragentsetscripted(0);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "hc_assassin_crouch");
  thread maps / mp / zquests / casual / island_ee_util::waittill_at_waypoint(self.var_1928, 96, 1);
  common_scripts\utility::waittill_notify_or_timeout("escort_goal_reached", 15);
  self.var_1DEB = 1;
  self suicide();
}

assassin_hc_zombie_clear_attract() {
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    if(lib_0547::func_5565(var_02.var_3043, self)) {
      var_02.var_3043 = undefined;
    }

    if(lib_0547::func_5565(var_02.var_1927, self)) {
      var_02.var_1927 = undefined;
    }
  }
}

assassin_hc_zombie_hide() {
  var_00 = assassin_hc_hide_point_select_optimal();
  var_01 = assassin_hc_zombie_spawn_at_nearest_point(var_00);
  level.hc_assassin = var_01[0];
  var_02 = var_01[1];
  level.hc_assassin endon("death");
  level endon("hc_assassin_killed");
  level.hc_assassin.var_1928 = var_00;
  if(!var_02) {
    level.hc_assassin childthread maps / mp / zquests / casual / island_ee_util::waittill_at_waypoint(var_00, 32, 1);
    level.hc_assassin waittill("escort_goal_reached");
    level.hc_assassin.skip_blendin = 0;
  } else {
    level.hc_assassin.skip_blendin = 1;
  }

  level.hc_assassin thread lib_0547::func_7D1A("hc_assassin_crouch");
  level.hc_assassin childthread assassin_hc_zombie_cry();
  level.hc_assassin.squatting = 1;
  level.hc_assassin.is_hiding = 1;
  level common_scripts\utility::waittill_any("hc_assassin_found");
  level.hc_assassin notify("hc_assassin_force_exit");
}

assassin_hc_zombie_cry() {
  self endon("death");
  self endon("hc_assassin_force_exit");
  var_00 = 500;
  var_01 = undefined;
  var_02 = 0;
  var_03 = 3;
  for(;;) {
    wait(randomintrange(10, 20));
    if(isalive(self)) {
      lib_0378::func_8D74("assassin_hc_cry");
      var_02++;
      if(var_02 < var_03) {
        continue;
      }

      var_04 = lib_0547::func_408F();
      foreach(var_06 in var_04) {
        if(isDefined(var_01)) {
          if(distancesquared(self.origin, var_06.origin) > var_01) {
            continue;
          }
        }

        var_06 maps / mp / agents / humanoid / _humanoid_util::func_867E(self);
        var_06.var_1927 = self;
      }
    }
  }
}

assassin_hc_zombie_think() {
  if(lib_053C::func_4F9B()) {
    wait(0.2);
    return;
  }

  lib_053C::func_647();
  wait(0.2);
}

assassin_hc_zombie_custom_move_mode() {
  self.var_64C2 = 1.15 * lib_054D::func_4440();
  self.var_672D = 1.15 * lib_054D::func_4440();
  self.var_9D0D = 1.15;
  self.var_4013 = 1.15;
  return "sprint";
}

assassin_hc_zombie_death_listener(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(self, level.hc_assassin)) {
    if(common_scripts\utility::func_562E(self.var_AC10)) {
      level notify("hc_assassin_recycled");
    } else {
      level notify("hc_assassin_killed");
      maps / mp / mp_zombie_island_ee_fog_manager::unlock_fog_from_lock();
    }

    level.hc_assassin.is_hiding = 0;
    level.hc_assassin assassin_hc_zombie_clear_attract();
    level.hc_assassin = undefined;
  }
}

assassin_hc_zombie_on_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(self.owner)) {
    var_0B = isDefined(param_01) && self.owner == param_01;
    var_0C = maps\mp\_utility::func_118D(self.owner, param_01) || var_0B;
  } else {
    var_0B = 0;
    var_0C = maps\mp\_utility::func_118D(self, param_02);
  }

  if(var_0C) {
    param_02 = 0;
    if(common_scripts\utility::func_562E(self.is_hiding)) {
      self.found_by_players = 1;
      self.is_hiding = 0;
      level notify("hc_assassin_found");
    }
  } else {}

  if(isDefined(param_01) && function_01EF(param_01)) {
    if(isDefined(param_01.var_A4B)) {
      switch (param_01.var_A4B) {
        case "zombie_generic":
          param_02 = param_02 * 0.35;
          break;

        case "zombie_berserker":
          param_02 = param_02 * 0.75;
          break;

        case "zombie_exploder":
          param_02 = param_02 * 0.9;
          break;

        case "zombie_heavy":
          param_02 = param_02 * 0.5;
          break;

        case "zombie_assassin":
          param_02 = param_02 * 0.9;
          break;

        default:
          param_02 = param_02 * 0.5;
          break;
      }
    }
  }

  lib_054D::func_6BD1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

assassin_hc_zombie_wake_players_are_too_close() {
  var_00 = undefined;
  while(!isDefined(var_00) || distance(self.origin, var_00.origin) > 128) {
    if(isDefined(level.players) && level.players.size > 0) {
      var_00 = common_scripts\utility::func_4461(self.origin, level.players);
    }

    wait 0.05;
  }

  return "Assassin Alarmed! PLAYERS TOO CLOSE";
}

assassin_hc_hide_point_init() {
  var_00 = common_scripts\utility::func_46B7("hc_asn_hide_pnt", "targetname");
  level.hc_asn_hide_pnts = spawnStruct();
  level.hc_asn_hide_pnts.seeded = 0;
  level.hc_asn_hide_pnts.pnts = [];
  foreach(var_02 in var_00) {
    var_02.var_AC8A = lib_055A::func_4562(var_02.origin);
    var_02.selected_recently = 0;
  }

  level.hc_asn_hide_pnts.pnts = var_00;
  lib_0547::func_7BD0("hc_assassin_crouch", ::assassin_hc_crouch_state, ::assassin_hc_crouch_state_interrupt, 4.75, ::assassin_hc_crouch_state_cleanup);
}

assassin_hc_hide_point_reset() {
  level.hc_asn_hide_pnts.seeded = 0;
  foreach(var_01 in level.hc_asn_hide_pnts.pnts) {
    var_01.selected_recently = 0;
  }
}

assassin_hc_crouch_state() {
  if(!common_scripts\utility::func_562E(self.skip_blendin)) {
    var_00 = "walk_2_crouch";
    var_01 = maps / mp / agents / _scripted_agent_anim_util::func_434D(var_00);
    self scragentsetscripted(1);
    maps / mp / agents / _scripted_agent_anim_util::func_8732(1, "hc_assassin_crouch");
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    self setOrigin(self.var_1928.origin);
    self.angles = self.var_1928.angles;
    if(isDefined(self.var_1928)) {
      maps / mp / agents / humanoid / _humanoid_util::func_8318(self.var_1928.origin, self.var_1928.angles, var_01, 0, 0, undefined, 1, 0);
    } else {
      maps / mp / agents / humanoid / _humanoid_util::func_8318(self.origin, self.angles, var_01, 0, 0, undefined, 1, 0);
    }
  }

  if(!common_scripts\utility::func_562E(self.found_by_players)) {
    var_02 = "idle_stalk_player";
    var_03 = maps / mp / agents / _scripted_agent_anim_util::func_434D(var_02);
    self setOrigin(self.var_1928.origin);
    self.angles = self.var_1928.angles;
    if(isDefined(self.var_1928)) {
      maps / mp / agents / humanoid / _humanoid_util::func_8318(self.var_1928.origin, self.var_1928.angles, var_03, 0, 0, undefined, 1, 1, "hc_assassin_force_exit");
    } else {
      maps / mp / agents / humanoid / _humanoid_util::func_8318(self.origin, self.angles, var_03, 0, 0, undefined, 1, 1, "hc_assassin_force_exit");
    }
  }

  assassin_hc_crouch_state_cleanup();
}

assassin_hc_crouch_state_interrupt() {
  self scragentsetscripted(0);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "hc_assassin_interrupt");
}

assassin_hc_crouch_state_cleanup() {
  self scragentsetscripted(0);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "hc_assassin_interrupt");
}

assassin_hc_hide_point_get_filtered_list() {
  var_00 = [];
  foreach(var_02 in level.hc_asn_hide_pnts.pnts) {
    if(!lib_055A::func_586A(var_02.var_AC8A)) {
      continue;
    } else {
      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

assassin_hc_hide_point_select_optimal() {
  var_00 = undefined;
  var_01 = lib_055A::func_4482();
  var_02 = assassin_hc_hide_point_get_filtered_list();
  var_03 = [];
  foreach(var_05 in var_02) {
    if(common_scripts\utility::func_F79(var_01, var_05.var_AC8A)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_05.selected_recently)) {
      continue;
    }

    var_03[var_03.size] = var_05;
  }

  if(var_03.size > 0) {
    if(var_03.size == 1) {
      var_00 = var_03[0];
    } else {
      var_07 = 1;
      if(common_scripts\utility::func_562E(level.hc_asn_hide_pnts.seeded)) {
        var_07 = 2;
      } else {
        level.hc_asn_hide_pnts.seeded = 1;
      }

      var_08 = maps\mp\_utility::getaverageorigin(level.players);
      var_09 = common_scripts\utility::func_44D6(var_08, var_03);
      switch (var_07) {
        case 1:
          var_00 = common_scripts\utility::random(var_03);
          break;

        case 2:
          var_00 = var_09;
          break;

        case 3:
          var_0A = var_09.var_AC8A;
          var_0B = [];
          foreach(var_0D in var_03) {
            if(var_0D.var_AC8A == var_0A) {
              var_0B[var_0B.size] = var_0D;
            }
          }

          var_00 = common_scripts\utility::random(var_0B);
          break;
      }
    }
  }

  if(!isDefined(var_00)) {
    var_00 = common_scripts\utility::random(var_02);
  }

  var_00.selected_recently = 1;
  return var_00;
}

fodder_escort_quest_main(param_00) {
  param_00 waittill("death");
}

handle_pomel_door_interact(param_00, param_01) {
  var_02 = common_scripts\utility::func_46B5("pomel_room_door_struct", "targetname");
  var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
  var_02.door_pieces = [];
  var_04 = function_021F(var_02.target, "targetname");
  foreach(var_06 in var_03) {
    var_07 = var_06.script_noteworthy;
    if(!isDefined(var_07)) {
      continue;
    }

    switch (var_07) {
      case "statue_piece_1":
        var_02.door_pieces["statue_piece_1"] = var_06;
        var_02.door_pieces["statue_piece_1"] thread show_statue_piece_after("players_placed_statue_piece_1");
        var_02.door_pieces["statue_piece_1"] hide();
        break;

      case "statue_piece_2":
        var_02.door_pieces["statue_piece_2"] = var_06;
        var_02.door_pieces["statue_piece_2"] thread show_statue_piece_after("players_placed_statue_piece_2");
        var_02.door_pieces["statue_piece_2"] hide();
        break;

      case "statue_piece_3":
        var_02.door_pieces["statue_piece_3"] = var_06;
        var_02.door_pieces["statue_piece_3"] thread show_statue_piece_after("players_placed_statue_piece_3");
        var_02.door_pieces["statue_piece_3"] hide();
        break;

      case "pomel_room_door_trigger":
        var_02.door_trigger = var_06;
        break;

      case "pomel_room_door_blocker":
        var_02.door_blocker = var_06;
        break;

      case "pomel_room_door_model":
        var_02.var_326B = var_06;
        break;
    }
  }

  var_09 = function_021F("zmi_pagan_room_door", "targetname");
  var_0A = var_09[0];
  var_02.door_scriptable = var_0A;
  var_02 thread wait_for_door_opened(param_01);
  for(;;) {
    var_02.door_trigger waittill("trigger", var_0B);
    if(var_0B getcurrentprimaryweapon() != "stone_baby_zm") {
      continue;
    }

    if(var_0B hasweapon("stone_baby_zm")) {
      var_0B notify("baby_deposited");
    }

    var_0B lib_0586::func_78E(var_0B lib_0547::func_AB2B());
    for(var_0C = 0; var_0C < param_00.size; var_0C++) {
      if(common_scripts\utility::func_3C77(param_00[var_0C]) && !common_scripts\utility::func_3C77(param_01[var_0C])) {
        common_scripts\utility::flag_set(param_01[var_0C]);
        var_02.door_pieces["statue_piece_" + var_0C + 1] show();
        break;
      }
    }
  }
}

show_statue_piece_after(param_00) {
  common_scripts\utility::func_3C9F(param_00);
  self show();
  lib_0378::func_8D74("pagen_door_place_stone");
  self moveTo(common_scripts\utility::func_46B5(self.target, "targetname").origin, 1);
  wait(1);
}

wait_for_door_opened(param_00) {
  foreach(var_02 in param_00) {
    common_scripts\utility::func_3C9F(var_02);
  }

  common_scripts\utility::flag_set("pomel room opened");
  wait(2.5);
  thread pagan_room_open_zombie_cooldown();
  thread pagan_room_open_logic();
  foreach(var_05 in level.players) {
    var_05 thread pagan_room_statue_lookat();
  }

  wait(0.5);
  self.door_pieces["statue_piece_1"] linkTo(self.door_scriptable, "TAG_ATTACH_1");
  self.door_pieces["statue_piece_2"] linkTo(self.door_scriptable, "TAG_ATTACH_2");
  self.door_pieces["statue_piece_3"] linkTo(self.door_scriptable, "TAG_ATTACH_3");
  self.door_blocker linkTo(self.door_scriptable, "TAG_ANIMATE");
  pomel_door_open(1);
}

pagan_room_open_zombie_cooldown() {
  level thread maps / mp / gametypes / zombies::func_8B2((0, 0, 0));
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8608();
  wait(15);
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8607();
}

pagan_room_statue_lookat() {
  level endon("statue_seen");
  level endon("statue_seen");
  var_00 = self;
  var_01 = getEnt("vol_statue_lookat", "targetname");
  var_02 = common_scripts\utility::func_46B5(var_01.target, "targetname");
  for(;;) {
    if(!var_00 istouching(var_01)) {
      wait 0.05;
      continue;
    }

    var_03 = var_02.origin;
    var_04 = self getEye();
    var_05 = vectorNormalize(var_03 - var_04);
    var_06 = vectorNormalize(anglesToForward(self geteyeangles()));
    var_07 = vectordot(var_05, var_06);
    wait 0.05;
    var_08 = acos(clamp(var_07, -1, 1));
    if(var_08 < 25 && distance(var_03, var_04) < 420) {
      var_00 lib_0367::func_8E3C("paganstatue", level.players);
      wait(3);
      level notify("statue_seen");
    }
  }
}

pomel_door_open(param_00) {
  level.disable_assassin_pushers = 0;
  var_01 = common_scripts\utility::func_46B5("pomel_room_door_struct", "targetname");
  var_01.door_scriptable setscriptablepartstate("gate", "opening");
  common_scripts\utility::flag_set("isolated_entry_to_isolated");
  var_02 = getEnt("pomel_room_door_instant_blocker", "script_noteworthy");
  if(isDefined(var_02)) {
    var_02 notsolid();
  }

  var_02 connectpaths();
  var_01.door_blocker connectpaths();
  level thread common_scripts\_exploder::func_88E(214);
  wait(5);
  if(common_scripts\utility::func_562E(param_00)) {
    foreach(var_04 in level.players) {
      var_04 lib_0367::func_8E3C("paganassassin");
    }
  }

  var_01.door_scriptable lib_0378::func_8D74("pagen_door_opened");
  wait(1.533333);
  var_01.door_scriptable setscriptablepartstate("gate", "opened");
  level.zmb_locked_spawn_zones = undefined;
  wait(3);
}

pomel_room_players_wait() {
  var_00 = getEnt("vol_isolated_room_player_check", "targetname");
  for(;;) {
    var_01 = 1;
    foreach(var_03 in level.players) {
      if(!var_03 istouching(var_00)) {
        var_01 = 0;
        break;
      }
    }

    if(var_01) {
      break;
    } else {
      wait 0.05;
    }
  }

  var_05 = getEnt("pomel_room_door_instant_blocker", "script_noteworthy");
  if(isDefined(var_05)) {
    var_05 solid();
  }
}

set_pommel_room_zombies_maxed() {
  level endon("pommel boss defeated");
  level.zmb_locked_spawn_zones = ["isolated_room_zone"];
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8608();
  common_scripts\utility::func_3C9F("anointed_zombies_done_spawning");
  common_scripts\utility::func_3C7B("anointed_zombies_done_spawning");
  wait(level.pommel_room_boss_peacetime);
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8606();
  level.maxed_zombies_sprint = 1;
}

pomel_door_close() {
  level thread set_pommel_room_zombies_maxed();
  level.disable_assassin_pushers = 1;
  var_00 = common_scripts\utility::func_46B5("pomel_room_door_struct", "targetname");
  var_01 = getEnt("pomel_room_door_instant_blocker", "script_noteworthy");
  var_00.door_scriptable setscriptablepartstate("gate", "closing");
  var_00.door_scriptable lib_0378::func_8D74("pagen_door_closing");
  var_00.door_blocker notsolid();
  common_scripts\utility::func_3C7B("isolated_entry_to_isolated");
  wait(4.2);
  var_00.door_blocker saved_actionslotdata();
  var_01 saved_actionslotdata();
  wait(2.333333);
  var_00.door_scriptable setscriptablepartstate("gate", "closed");
  var_01 notsolid();
  var_00.door_blocker thread wait_to_turn_solid();
}

wait_to_turn_solid() {
  for(;;) {
    wait 0.05;
    foreach(var_01 in level.players) {
      if(distance2d(var_01.origin, self.origin) < 70) {
        continue;
      }
    }

    break;
  }

  self solid();
}

stone_collect_1_think() {
  var_00 = getEnt("trig_hc_stone_1", "targetname");
  var_01 = getEnt("mdl_hc_mossy_boulder", "script_noteworthy");
  var_02 = common_scripts\utility::func_46B5("struct_hc_stone_spawn", "script_noteworthy");
  var_03 = common_scripts\utility::func_46B5("struct_hc_stone_land", "script_noteworthy");
  for(;;) {
    var_00 waittill("damage", var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    if(lib_0547::func_5565(var_0D, "turretweapon_ger_btry_flak38_mp_zombie")) {
      break;
    }
  }

  common_scripts\utility::flag_set("players_spawned_statue_piece_1");
  playFX(common_scripts\utility::func_44F5("zmb_flak_rock_explosion"), var_01.origin);
  var_01 delete();
  wait 0.05;
  var_0E = magicartillery("zmi_stone_drop", var_02.origin, var_03.origin, 1.2, var_02.origin[2] + 50);
  var_0E waittill("explode", var_0F);
  maps / mp / zombies / weapons / _zombie_stone_baby_weapon::spawn_a_stone_baby_pickup(var_03.origin, undefined, undefined, undefined, "players_spawned_statue_piece_1");
}

stone_collect_2_think() {
  var_00 = common_scripts\utility::func_46B5("zombie_stone_waypoint_set1_1", "script_noteworthy") maps / mp / zquests / casual / island_ee_util::make_array_from_struct_chain();
  var_01 = common_scripts\utility::func_46B5("zombie_stone_waypoint_set2_1", "script_noteworthy") maps / mp / zquests / casual / island_ee_util::make_array_from_struct_chain();
  var_02 = common_scripts\utility::func_46B5("zombie_stone_waypoint_set3_1", "script_noteworthy") maps / mp / zquests / casual / island_ee_util::make_array_from_struct_chain();
  var_03 = common_scripts\utility::func_46B5("zombie_stone_waypoint_set5_1", "script_noteworthy") maps / mp / zquests / casual / island_ee_util::make_array_from_struct_chain();
  while(!common_scripts\utility::func_3C77("players_spawned_statue_piece_2")) {
    level waittill("freezer_zombie_placed", var_04);
    if(!lib_0547::func_5565(var_04.var_A4B, "zombie_generic")) {
      continue;
    }

    var_04 zombie_hc_zombie_post_drop_setup();
    var_04 stone_2_begin_escort(var_00, var_01, var_02, var_03);
    if(isDefined(var_04)) {
      var_04.var_1928 = undefined;
      var_04 stone_2_revert_to_enemy();
    }
  }
}

zombie_hc_zombie_setup() {
  var_00 = self;
  var_00.escort_zombie = 1;
  var_00.isobjectiveexemptfromfog = 1;
  var_00.var_6816 = 1;
  var_00.var_C29 = 0;
  var_00.shouldnotpreventlaststand = 1;
  var_00.ispassiveexempt = 1;
  var_00.var_55AB = 1;
  var_00.var_562B = 1;
  var_00.var_297D = ::maps / mp / zquests / casual / island_ee_util::escort_custom_movemode;
  var_00 maps / mp / agents / _agent_common::func_83FD(1000);
  var_00.var_6701 = 1;
  var_00.custom_think_mode = ::wustling_hc_think;
  var_00.escort_hit_track_time = 2;
  var_00.recently_hit_by_player = 0;
  var_00.recently_hit_player = undefined;
  var_00.health_at_spawn = var_00.health;
  var_00.action_param_override_func = ::zombie_hc_param_actions;
}

zombie_hc_zombie_post_drop_setup() {
  var_00 = self;
  var_00 maps / mp / agents / _agent_utility::func_83FE(level.var_746E);
  return var_00;
}

zombie_hc_param_actions() {
  var_00 = lib_054D::func_AC22();
  if(common_scripts\utility::func_562E(self.is_scripted_monent)) {
    var_00["script_var"] = "scripted_stone_carry";
    var_00["move_style"] = "athletic";
    var_00["source_project"] = "t7";
  } else {}

  return var_00;
}

zombie_hc_zombie_forceidle() {
  self scragentsetscripted(1);
  self.ignoreall = 1;
  self.is_idling = 1;
  self.var_480F = 1;
  var_00 = "passive_idle";
  maps / mp / agents / _scripted_agent_anim_util::func_8415(var_00, 0);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(1, "passive_idle");
  self.var_509A = 1;
}

zombie_hc_zombie_awakenidle() {
  maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "passive_idle");
  self scragentsetscripted(0);
  self.var_509A = 0;
  self.ignoreall = 0;
  self.is_idling = 0;
}

stone_2_revert_to_enemy() {
  var_00 = self;
  if(!isDefined(var_00)) {
    return;
  }

  var_00.escort_zombie = undefined;
  var_00.isobjectiveexemptfromfog = 0;
  var_00 maps / mp / agents / _agent_utility::func_83FE("axis");
}

stone_2_begin_escort(param_00, param_01, param_02, param_03) {
  var_04 = self;
  var_04 endon("death");
  var_04 maps / mp / zquests / casual / island_ee_util::escort_waypoints_linear(param_00);
  var_04 maps / mp / zquests / casual / island_ee_util::escort_waypoints_linear(param_01);
  var_04 maps / mp / zquests / casual / island_ee_util::escort_waypoints_linear(param_02);
  var_04 zombie_hc_zombie_forceidle();
  var_04.is_scripted_monent = 1;
  var_05 = 12;
  wait(var_05);
  var_04 zombie_hc_zombie_awakenidle();
  var_04 thread stone_2_handle_baby_statue();
  var_04 maps / mp / zquests / casual / island_ee_util::escort_waypoints_linear(param_03, 1);
  var_04.is_scripted_monent = undefined;
  var_04 notify("drop_stone");
  wait 0.05;
  var_04 suicide();
}

stone_2_handle_baby_statue() {
  var_00 = self;
  var_01 = spawn("script_model", var_00.origin);
  var_01 setModel("npc_zom_baby_statue_01");
  var_01.origin = var_00 gettagorigin("TAG_WEAPON_RIGHT");
  var_01.angles = var_00 gettagangles("TAG_WEAPON_RIGHT");
  var_01 linkTo(var_00, "TAG_WEAPON_RIGHT");
  var_00 common_scripts\utility::waittill_any("death", "drop_stone");
  var_00.var_480F = 0;
  var_01 unlink(var_00, "TAG_WEAPON_RIGHT");
  var_01 delete();
  var_00 stone_2_spawn_baby_statue();
}

stone_2_spawn_baby_statue() {
  if(isDefined(self.origin)) {
    var_00 = self.origin + (0, 0, 20);
  } else {
    var_00 = undefined;
  }

  maps / mp / zombies / weapons / _zombie_stone_baby_weapon::spawn_a_stone_baby_pickup(var_00, undefined, undefined, undefined, "players_spawned_statue_piece_2");
  common_scripts\utility::flag_set("players_spawned_statue_piece_2");
}

stone_collect_3_think() {
  var_00 = stone_setup_roots_object();
  stone_choose_stone_root(var_00);
  foreach(var_02 in var_00) {
    var_02 thread stone_roots_roots_think();
  }

  common_scripts\utility::func_3C9F("players_spawned_statue_piece_2");
}

stone_setup_roots_object() {
  var_00 = getEntArray("clip_hc_root_object", "targetname");
  foreach(var_02 in var_00) {
    var_03 = getEntArray(var_02.target, "targetname");
    var_04 = common_scripts\utility::func_46B7(var_02.target, "targetname");
    foreach(var_06 in var_03) {
      switch (var_06.script_noteworthy) {
        case "mdl_roots_dead":
          var_02.model_dead = var_06;
          var_02.model_dead hide();
          break;

        case "mdl_roots_alive":
          var_02.model_alive = var_06;
          break;

        default:
          break;
      }
    }

    foreach(var_06 in var_04) {
      switch (var_06.script_noteworthy) {
        case "struct_hc_statue_end_point":
          var_09 = bulletTrace(var_06.origin, var_06.origin - (0, 0, 1000), 0, undefined, 1, 0, 0, 1, 0, 0, 0);
          var_06.origin = var_09["position"];
          var_02.statue_end_loc = var_06;
          break;

        case "struct_hc_statue_start_point":
          var_02.statue_start_loc = var_06;
          break;

        case "struct_hc_root_vfx":
          var_02.vfx_struct = var_06;
          break;

        default:
          break;
      }
    }
  }

  return var_00;
}

stone_choose_stone_root(param_00) {
  var_01 = common_scripts\utility::random(param_00);
  var_01.hc_chosen_roots = 1;
}

stone_roots_roots_think() {
  self setCanDamage(1);
  var_00 = undefined;
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(isDefined(var_0A) && issubstr(var_0A, "razer")) {
      break;
    }
  }

  if(isDefined(self.hc_chosen_roots) && self.hc_chosen_roots == 1) {
    var_00 = 1;
  }

  self notsolid();
  self.model_alive delete();
  playFX(common_scripts\utility::func_44F5("zmb_root_dirt_impact_a"), self.vfx_struct.origin);
  self.model_dead show();
  if(!isDefined(var_00) || var_00 != 1) {
    return;
  }

  common_scripts\utility::flag_set("players_spawned_statue_piece_3");
  wait 0.05;
  var_0B = magicartillery("zmi_stone_drop", self.statue_start_loc.origin, self.statue_end_loc.origin, 1.5, self.statue_start_loc.origin[2] + 100);
  playFX(common_scripts\utility::func_44F5("zmb_geiskraft_spark_poof"), self.statue_start_loc.origin);
  var_0B waittill("explode", var_0C);
  maps / mp / zombies / weapons / _zombie_stone_baby_weapon::spawn_a_stone_baby_pickup(self.statue_end_loc.origin, undefined, undefined, undefined, "players_spawned_statue_piece_3");
}

debug_arrow() {
  while(isDefined(self)) {
    common_scripts\utility::func_339F(self.origin + (0, 0, 200), self.origin, (1, 0, 0));
    wait 0.05;
  }
}

pagan_room_open_logic() {
  var_00 = common_scripts\utility::func_46B7("assassin_pommel_spawner", "targetname");
  var_01 = [];
  for(var_02 = 0; var_02 < 3; var_02++) {
    var_03 = spawnStruct();
    var_03.phase_flag = "Phase 2: IDLE";
    var_03.override_action = "assassin_worship_" + randomintrange(1, 4);
    var_04 = get_worship_alarm_rules();
    var_05 = maps / mp / zombies / zombie_assassin_spawner_logic::spawn_an_assassin(undefined, undefined, var_00[var_02], 1, "Phase 2: IDLE", 1, 1, [var_03], var_04);
    var_05.var_9024 = "isolated_room_zone";
  }
}

get_worship_alarm_rules() {
  var_00 = spawnStruct();
  var_00.var_3F11 = [];
  var_00.var_3F11[var_00.var_3F11.size] = ::assassin_damaged_crouch;
  return var_00;
}

assassin_damaged_crouch() {
  wait(5);
  for(;;) {
    common_scripts\utility::waittill_any("damage", "assassin_gunshot_wakup");
    if(common_scripts\utility::func_562E(self.is_anointed)) {
      while(common_scripts\utility::func_3C77("isolated_entry_to_isolated")) {
        wait 0.05;
      }
    } else {
      common_scripts\utility::func_3C9F("isolated_entry_to_isolated");
    }

    if(!common_scripts\utility::func_3794("Phase 2: IDLE TRANSITION")) {
      break;
    }
  }
}

func_ABB1(param_00) {
  self scragentsetscripted(1);
  self.var_57C0 = 1;
  self.ignoreall = 1;
  if(!lib_0547::func_5565(self.var_A4B, "zombie_assassin")) {
    maps / mp / agents / _scripted_agent_anim_util::func_8415("passive_idle", param_00);
  } else {
    self.skipsquatsearch = 1;
  }

  maps / mp / agents / _scripted_agent_anim_util::func_8732(1, "training");
  self.var_509A = 1;
}

func_AB50() {
  maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "training");
  self scragentsetscripted(0);
  self.var_57C0 = 0;
  self.var_509A = 0;
  self.ignoreall = 0;
}

play_custom_dropdown() {
  iprintln("dropping down");
  thread dropdown_intro_center();
  thread dropdown_intro_left();
  thread dropdown_intro_right();
}

dropdown_intro_center() {
  var_00 = common_scripts\utility::func_46B5("zombie_intro_dropdown_center", "targetname");
  var_01 = lib_054D::func_90BA("zombie_generic", var_00, "beach_rush_intro", 0, 0, 0);
}

dropdown_intro_left() {
  var_00 = common_scripts\utility::func_46B5("zombie_intro_dropdown_left", "targetname");
  var_01 = lib_054D::func_90BA("zombie_generic", var_00, "beach_rush_intro", 0, 0, 0);
}

dropdown_intro_right() {
  var_00 = common_scripts\utility::func_46B5("zombie_intro_dropdown_right", "targetname");
  var_01 = lib_054D::func_90BA("zombie_generic", var_00, "beach_rush_intro", 0, 0, 0);
}

func_ABAD(param_00) {
  self scragentsetscripted(1);
  self.var_57C0 = 1;
  maps / mp / agents / _scripted_agent_anim_util::func_8415("passive_idle", param_00);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(1, "training");
}

assassinwasdamaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(self.var_A4B == "zombie_assassin") {
    if(isDefined(param_01)) {
      if(isPlayer(param_01)) {
        if(param_02 >= 1) {
          level notify("pommel_room_assassins_activated");
          return;
        }

        return;
      }
    }
  }
}

head_hooks_setup() {
  var_00 = getEnt("hc_head_handler", "targetname");
  var_01 = getEntArray(var_00.target, "targetname");
  var_02 = common_scripts\utility::func_46B7(var_00.target, "targetname");
  foreach(var_04 in var_01) {
    switch (var_04.script_noteworthy) {
      case "pest_head":
        var_00.pest_head = var_04;
        var_00.pest_head hide();
        var_00.pest_head.exploder_num = 223;
        break;

      case "trig_pest_head_place":
        var_00.pest_trig = var_04;
        break;

      case "follower_head":
        var_00.follower_head = var_04;
        var_00.follower_head hide();
        var_00.follower_head.exploder_num = 225;
        break;

      case "trig_follower_head_place":
        var_00.follower_trig = var_04;
        break;

      case "assassin_head":
        var_00.assassin_head = var_04;
        var_00.assassin_head hide();
        var_00.assassin_head.exploder_num = 226;
        break;

      case "trig_assassin_head_place":
        var_00.assassin_trig = var_04;
        break;

      case "monk_pommel_room_head":
        var_00.monk_head = var_04;
        var_00.monk_head hide();
        var_00.monk_head.exploder_num = 224;
        break;

      case "trig_monk_head_place":
        var_00.monk_trig = var_04;
        break;

      default:
        break;
    }
  }

  var_00.pest_trig thread head_hooks_attach_head(var_00.pest_head, "flag_anointed_pest_head_get", "flag_anointed_pest_head_placed");
  var_00.follower_trig thread head_hooks_attach_head(var_00.follower_head, "flag_anointed_fol_head_get", "flag_anointed_fol_head_placed");
  var_00.assassin_trig thread head_hooks_attach_head(var_00.assassin_head, "flag_anointed_asn_head_get", "flag_anointed_asn_head_placed");
  var_00.monk_trig thread head_hooks_attach_head(var_00.monk_head, "flag_monk_head_retrieved", "flag_anointed_monk_head_placed");
  common_scripts\utility::func_3CA0("flag_anointed_pest_head_get", "flag_anointed_fol_head_get", "flag_anointed_asn_head_get");
  maps\mp\_utility::func_2CED(1.25, ::monk_head_final_fight_dialogue);
  common_scripts\utility::func_3C9F("flag_monk_head_retrieved");
  common_scripts\utility::func_3CA0("flag_anointed_pest_head_get", "flag_anointed_fol_head_get", "flag_anointed_asn_head_get", "flag_anointed_monk_head_placed");
  common_scripts\utility::flag_set("flag_heads_complete");
}

monk_head_final_fight_dialogue() {
  maps / mp / zquests / casual / island_ee_util::monk_head_dialogue("zmb_isla_monk_bringmetonerthustowitness", 1);
  wait(0.75);
  maps / mp / zquests / casual / island_ee_util::monk_head_dialogue("themoonhasrisenontheblack");
}

head_spawn_type(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  if(!isDefined(param_02)) {
    param_02 = (0, 0, 0);
  }

  switch (param_00) {
    case "zombie_berserker":
      var_03 = &"zombie_island_pick_head_pest";
      var_04 = "flag_anointed_pest_head_drop";
      var_05 = "flag_anointed_pest_head_get";
      var_06 = "zom_ger_head_spr_01_gib";
      break;

    case "zombie_heavy":
      var_03 = &"zombie_island_pick_head_follower";
      var_04 = "flag_anointed_fol_head_drop";
      var_05 = "flag_anointed_fol_head_get";
      var_06 = "zmi_follower_severed_head_gp";
      break;

    case "zombie_assassin":
      var_03 = &"zombie_island_pick_head_assassin";
      var_04 = "flag_anointed_asn_head_drop";
      var_05 = "flag_anointed_asn_head_get";
      var_06 = "zmi_assassin_ee_head_01";
      break;

    default:
      break;
  }

  common_scripts\utility::flag_set(var_04);
  var_07 = spawn("script_model", param_01 + (0, 0, 20));
  var_07.angles = param_02;
  var_07 setModel(var_06);
  playFXOnTag(common_scripts\utility::func_44F5("zmb_isl_med_trap_gib_rnr"), var_07, "tag_origin");
  var_07 lib_0547::func_AC41(var_03, (0, 0, 20));
  var_07 waittill("player_used", var_08);
  var_07 lib_0547::func_AC40();
  var_07 delete();
  common_scripts\utility::flag_set(var_05);
}

head_hooks_spawn_temp_heads() {
  thread head_spawn_type("zombie_berserker", common_scripts\utility::func_46B5("struct_pest_head_temp_spot", "script_noteworthy").origin);
  thread head_spawn_type("zombie_heavy", common_scripts\utility::func_46B5("struct_follower_head_temp_spot", "script_noteworthy").origin);
  thread head_spawn_type("zombie_assassin", common_scripts\utility::func_46B5("struct_assassin_head_temp_spot", "script_noteworthy").origin);
}

head_hooks_attach_head(param_00, param_01, param_02) {
  while(!common_scripts\utility::func_3C77(param_02)) {
    self waittill("trigger", var_03);
    if(!common_scripts\utility::func_3C77(param_01)) {
      wait 0.05;
      continue;
    }

    param_00 show();
    level childthread common_scripts\_exploder::func_88E(param_00.exploder_num);
    thread head_hooks_attach_head_quake(var_03, param_00.origin);
    lib_0378::func_8D74("pagan_head_place", param_00, param_02);
    common_scripts\utility::flag_set(param_02);
    self delete();
  }
}

head_hooks_attach_head_quake(param_00, param_01) {
  var_02 = randomfloatrange(3, 6);
  var_03 = randomfloatrange(4, 8);
  lib_0378::func_8D74("pommel_earthquake", "rumble", var_02, param_01);
  wait(var_02);
  lib_0378::func_8D74("pommel_earthquake", "earthquake", var_03, param_01);
  var_04 = param_00;
  if(isDefined(var_04)) {
    level thread func_3254(var_03, var_04);
  }

  wait(var_03);
}

func_3254(param_00, param_01) {
  earthquake(0.3, param_00, param_01.origin, 850, param_01);
  function_01BC("tank_rumble", param_01.origin);
  wait(param_00);
  function_01BD();
}

head_retrieve_monk_head_from_freezer() {
  common_scripts\utility::func_3CA0("flag_anointed_pest_head_get", "flag_anointed_fol_head_get", "flag_anointed_asn_head_get");
  self.controller_trig waittill("trigger", var_00);
  common_scripts\utility::flag_set("flag_monk_head_retrieved");
  self.var_82EF setscriptablepartstate("light", "red");
  self.var_B9 hide();
}

______________pommel_____________() {}

raise_water_objective(param_00) {
  common_scripts\utility::flag_init(self.var_819A);
  self.my_dest = getEnt(self.target, "targetname");
  if(!isDefined(self.my_dest)) {
    return;
  }

  var_01 = spawn("script_model", param_00.origin);
  var_01 setModel("tag_origin");
  thread func_8C16(var_01);
  var_01.disable_end_sound = 1;
  var_01 maps / mp / mp_zombies_soul_collection::func_170B(int(maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_pommel_room_sacrifice_requirements")), param_00.radius, 64, self.var_819A, undefined, "tag_origin", undefined, "tag_origin", undefined, self, (0, 0, 64), undefined, 1, 1);
  common_scripts\utility::flag_set("water_has_been_raised");
}

func_8C16(param_00) {
  self endon("water_raised");
  while(!isDefined(param_00.var_695B)) {
    wait 0.05;
  }

  self.var_6C4E = self.origin;
  for(;;) {
    level waittill(param_00.var_695B);
    level notify("water_raised", param_00.var_AC2C);
    self moveTo(vectorlerp(self.var_6C4E, self.my_dest.origin, param_00.var_AC2C / param_00.var_AC2D), 1);
    if(param_00.var_AC2C >= param_00.var_AC2D) {
      level notify("water_raised");
    }
  }
}

pagan_room_waterfall_vfx() {
  var_00 = getEnt("vol_pagan_room_waterfall", "targetname");
  for(;;) {
    var_01 = lib_0547::func_4090("zombie_generic");
    foreach(var_03 in var_01) {
      if(var_03 istouching(var_00)) {
        playFXOnTag(common_scripts\utility::func_44F5("zmb_isl_pomel_body_splashes"), var_03, "j_head");
      }
    }

    wait(0.1);
  }
}

monk_head_found_xp_reward() {
  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("monkhead");
    var_01 lib_0378::func_8D74("objective_complete", "monkhead");
  }
}

stone_baby_xp_reward() {
  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("stonebaby");
    var_01 lib_0378::func_8D74("objective_complete", "stonebaby");
  }
}

pagan_pool_xp_reward() {
  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("paganpool");
    var_01 lib_0378::func_8D74("objective_complete", "paganpool");
  }
}

zombie_heads_xp_reward() {
  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("zombieheads");
    var_01 lib_0378::func_8D74("objective_complete", "zombieheads");
  }
}

pagan_pool_boss_xp_reward() {
  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("paganbpoolboss");
    var_01 lib_0378::func_8D74("objective_complete", "paganbpoolboss");
  }
}

i_beam() {
  var_00 = getEnt("hibeam", "targetname");
  var_00.var_6C48 = var_00.angles;
  var_00 setCanDamage(1);
  var_01 = 0;
  var_02 = 7;
  while(!common_scripts\utility::func_3C77("ibeam_complete")) {
    var_00 waittill("damage");
    var_01++;
    var_00 rotateTo(combineangles(var_00.var_6C48, (0, 0, var_01 * 11.25)), 0.15);
    var_00 lib_0378::func_8D74("aud_ibeam_squeak");
    wait(0.15);
    if(var_01 > var_02) {
      common_scripts\utility::flag_set("ibeam_complete");
    }
  }

  var_00 lib_0378::func_8D74("aud_ibeam_complete");
  foreach(var_04 in level.players) {
    var_04 maps / mp / gametypes / zombies::func_4798(1);
  }
}

ee_rollers() {
  level.ee_rollers = spawnStruct();
  level.ee_rollers.sets = getEntArray("ee_roller_sets", "script_noteworthy");
  level.ee_rollers.sets = common_scripts\utility::array_randomize(level.ee_rollers.sets);
  level.ee_rollers.n1 = randomintrange(-5, 15);
  level.ee_rollers.n2 = 5 * randomint(11);
  if(common_scripts\utility::func_24A6()) {
    level.ee_rollers.n2 = level.ee_rollers.n2 * -1;
  }

  for(var_00 = 0; var_00 < 6; var_00++) {
    level.ee_rollers.sets[var_00].roller_elems = getEntArray(level.ee_rollers.sets[var_00].target, "targetname");
    foreach(var_02 in level.ee_rollers.sets[var_00].roller_elems) {
      var_02.var_6C48 = var_02.angles;
      if(var_00 + 1 != lib_0547::func_9470(var_02.var_8260)) {
        var_02 delete();
        continue;
      }

      switch (lib_0547::func_9470(var_02.var_8260)) {
        case 1:
          level.ee_rollers.slot1 = var_02;
          var_03 = 9;
          if(level.ee_rollers.n1 >= 0) {
            var_03 = 0;
          }

          level.ee_rollers.slot1 maps / mp / zquests / casual / island_ee_util::display_set_digit(var_03);
          break;

        case 2:
          var_03 = int(level.ee_rollers.n1 / 10);
          level.ee_rollers.slot2 = var_02;
          level.ee_rollers.slot2 maps / mp / zquests / casual / island_ee_util::display_set_digit(var_03);
          break;

        case 3:
          var_03 = level.ee_rollers.n1 % 10;
          level.ee_rollers.slot3 = var_02;
          level.ee_rollers.slot3 maps / mp / zquests / casual / island_ee_util::display_set_digit(var_03);
          break;

        case 4:
          level.ee_rollers.slot4 = var_02;
          var_03 = 9;
          if(level.ee_rollers.n2 >= 0) {
            var_03 = 0;
          }

          level.ee_rollers.slot4 maps / mp / zquests / casual / island_ee_util::display_set_digit(var_03);
          break;

        case 5:
          var_03 = int(level.ee_rollers.n2 / 10);
          level.ee_rollers.slot5 = var_02;
          level.ee_rollers.slot5 maps / mp / zquests / casual / island_ee_util::display_set_digit(var_03);
          break;

        case 6:
          var_03 = level.ee_rollers.n2 % 10;
          level.ee_rollers.slot6 = var_02;
          level.ee_rollers.slot6 maps / mp / zquests / casual / island_ee_util::display_set_digit(var_03);
          break;

        default:
          break;
      }
    }
  }

  level.ee_rollers.elek = getEnt("ee_roller_elek", "script_noteworthy");
  level.ee_rollers.elek hide();
  level.ee_rollers.elek.dest = common_scripts\utility::func_46B5(level.ee_rollers.elek.target, "targetname");
  level.ee_rollers.elek.var_9D5E = getEnt(level.ee_rollers.elek.target, "targetname");
  level.ee_rollers.elek.var_9D5E makeunusable();
  level.ee_rollers waittill("code_accepted");
  level.ee_rollers.elek show();
  level.ee_rollers.elek moveTo(level.ee_rollers.elek.dest.origin, 0.7);
  wait(0.9);
  level.ee_rollers.elek lib_0378::func_8D74("aud_ibeam_complete");
  level.ee_rollers.elek.var_9D5E makeusable();
  level.ee_rollers.elek.var_9D5E waittill("trigger");
  level.ee_rollers.elek delete();
  level.ee_rollers.elek.var_9D5E delete();
  common_scripts\utility::flag_set("ripsaw_punch_active");
}

ee_rollers_check(param_00, param_01) {
  if(param_00 != level.ee_rollers.n1 || param_01 != level.ee_rollers.n2) {
    return;
  }

  level.ee_rollers notify("code_accepted");
}

ee_stuka_rpg() {
  level thread maps\mp\_utility::func_6F74(::player_fliegerfaust_test);
}

player_fliegerfaust_test() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("missile_fire", var_01, var_02);
    if(var_02 != "fliegerfaust_zm") {
      continue;
    }

    var_03 = var_01 rpg_fliegerfaust_test(var_00);
    if(common_scripts\utility::func_562E(var_03)) {
      var_00 notify("assassin_blood_1_complete");
    }
  }
}

rpg_fliegerfaust_test(param_00) {
  param_00 endon("disconnect");
  var_01 = self;
  var_02 = 160000;
  var_03 = 0;
  var_04 = 0;
  var_05 = var_01.origin;
  while(isDefined(var_01)) {
    foreach(var_07 in level.active_planes) {
      if(!isDefined(var_07)) {
        continue;
      }

      var_08 = distancesquared(var_01.origin, var_07.origin);
      var_04 = distancesquared(var_01.origin, var_05) / var_02;
      if(var_04 > 1) {
        var_04 = 1;
      }

      var_03 = var_02 * var_04;
      if(isDefined(var_07) && isDefined(var_01) && var_03 > var_08) {
        var_01 detonateusingweapon("fliegerfaust_zm", param_00);
        var_07 dodamage(1000, param_00.origin, param_00, param_00, "MOD_EXPLOSIVE", "fliegerfaust_zm");
        return 1;
      }
    }

    wait(0.25);
  }

  return 0;
}