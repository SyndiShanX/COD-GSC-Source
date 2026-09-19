/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\hardcore\island_ee_hc.gsc
*************************************************************/

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

  foreach(var_1 in ["flag_monk_head_found", "flag_monk_head_placed", "flag_anointed_pest_head_placed", "flag_anointed_fol_head_placed", "flag_anointed_asn_head_placed", "flag_heads_complete", "zmb_hc_pest_destination", "zmb_hc_follower_destination", "zmb_hc_assassin_destination", "pomel room opened", "flag_pommel_given", "players_placed_statue_piece_1", "players_placed_statue_piece_2", "players_placed_statue_piece_3", "flag_hc_pest_paint_complete", "flag_sacrificed_sprinter_spine", "flag_sacrificed_follower_spine", "flag_sacrificed_assassin_spine", "flag_hc_asn_found_1", "flag_hc_asn_found_2", "flag_hc_asn_found_3", "flag_hc_asn_escort_complete"])
  _id_0557::_id_4BC9(var_1, undefined, undefined, 1);

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
  pommel_water_trigger(common_scripts\utility::_id_9D9F);
}

pommel_water_trigger(var_0) {
  var_1 = getEntArray("trigger_water", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(_id_0547::_id_5565(var_3.weaponlocktargettooclose, "zmi_pommel_water"))
      var_3[[var_0]]();
  }
}

jack_respawn() {
  level.jack_in_box_secret_handler = ::on_jack_landed_in_secret;
}

on_jack_landed_in_secret(var_0) {
  var_1 = 18;
  var_2 = 4;
  var_3 = common_scripts\utility::_id_46B5("zmi_hc_secret", "targetname");
  var_4 = var_3.origin + (0, 0, var_2);

  for(var_5 = 0; var_5 < 3; var_5++) {
    if(_distance2d(self.origin, var_4) < var_3.radius && _abs(self.origin[2] - var_4[2]) < var_1) {
      level.jack_in_box_secret_handler = undefined;
      level.players_sacrificed_jack = 1;
      var_0 delete();
      _id_0378::_id_8D74("tesla_hc_energy_lamp_destruct", var_3.origin);
      return 1;
    }

    waitframe();
  }

  return 0;
}

pomel_boss_fight_water_raise() {
  common_scripts\utility::_id_3C9F("flag_heads_complete");
  pomel_room_players_wait();
  maps\mp\zquests\casual\island_ee_util::clear_all_zombies();
  thread pomel_door_close();
  var_0 = common_scripts\utility::_id_46B5("pommel_room_soul_collection_struct", "targetname");
  var_1 = _getent("zmb_pomel_room_water", "targetname");
  var_1 thread raise_water_objective(var_0);
  level thread common_scripts\_exploder::_id_088E(217);
  level thread player_zombie_rush_kills_after_num_kills(_randomintrange(2, 4), var_0.origin);
  level thread player_zombie_rush_vo_after(_randomintrange(6, 9), var_0.origin);

  foreach(var_3 in level.players)
  var_3 maps\mp\_utility::_id_2CED(1.25, _id_0367::_id_8E3C, "pommelattack");

  common_scripts\utility::flag_set("anointed_zombies_done_spawning");
  common_scripts\utility::_id_3C9F("water_has_been_raised");
  pommel_water_trigger(common_scripts\utility::_id_9DA3);
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  level.maxed_zombies_sprint = 0;
  var_3 = maps\mp\mp_zombie_island_aud::get_closest_alive_player(var_0.origin);
  var_3 thread _id_0367::_id_8E3C("pommel", level.players);
  pomel_skull_destroy();
  level thread maps\mp\zombies\weapons\_zombie_aoe_grenade::spawn_pommel_special_pickup("secret_room_spawn", "flag_pommel_given");
  pomel_door_open();
}

pomel_skull_destroy() {
  level thread common_scripts\_exploder::_id_088E(213);
  var_0 = _getent("zmb_island_pomel_skull", "targetname");
  _id_0378::_id_8D74("pommel_skull_destroyed", var_0);
  var_0 ghost();
}

player_zombie_rush_vo_after(var_0, var_1) {
  wait(var_0);
  var_2 = maps\mp\mp_zombie_island_aud::get_closest_alive_player(var_1);
  var_2 thread _id_0367::_id_8E3C("buggersjustkeepcomin", level.players);
}

player_zombie_rush_kills_after_num_kills(var_0, var_1) {
  var_2 = 0;

  while(var_2 < var_0)
    level waittill("water_raised", var_2);

  var_3 = maps\mp\mp_zombie_island_aud::get_closest_alive_player(var_1);
  var_3 thread _id_0367::_id_8E3C("keepyereyeonthewater", level.players);
}

hc_init_monk_heads_setup() {
  level.zombie_forge_control_struct = common_scripts\utility::_id_46B5("zombie_forge_control", "targetname");
  var_0 = _getent("hc_quest_monk_head_pickup", "targetname");
  var_1 = common_scripts\utility::_id_44BE(level.zombie_forge_control_struct.target, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3._id_0165) {
      case "machine_trigger":
        level.zombie_forge_control_struct.controller_trig = var_3;
        break;
      case "machine_light":
        level.zombie_forge_control_struct.controller_light = var_3;
        break;
      case "freezer_head_model":
        level.zombie_forge_control_struct._id_00B9 = var_3;
        level.zombie_forge_control_struct._id_00B9 hide();
        break;
    }
  }

  var_5 = _getscriptablearray(level.zombie_forge_control_struct.target, "targetname");

  if(isDefined(var_5) && var_5.size > 0) {
    level.zombie_forge_control_struct.issighted = var_5[0];
    level.zombie_forge_control_struct.issighted setscriptablepartstate("light", "red");
    level.zombie_forge_control_struct common_scripts\utility::_id_3799("freezer_machine_working");
  }

  var_0 thread monk_head_find_think();
  level.zombie_forge_control_struct thread monk_head_control_think();
  level.zombie_forge_control_struct thread monk_head_place_think();
  level.zombie_forge_control_struct thread monk_head_operate_machine();
  waitframe();
  level.zombie_forge_control_struct thread head_retrieve_monk_head_from_freezer();
}

monk_head_control_think() {
  level endon("flag_monk_head_retrieved");
  common_scripts\utility::_id_3C9F("flag_monk_head_placed");
  self.issighted setscriptablepartstate("light", "green");

  for(;;) {
    common_scripts\utility::_id_379C("freezer_machine_working");
    self.issighted thread maps\mp\zquests\casual\island_ee_main::activate_machine();

    while(common_scripts\utility::_id_3794("freezer_machine_working")) {
      self.issighted setscriptablepartstate("light", "off");
      wait 0.5;
      self.issighted setscriptablepartstate("light", "green");
      wait 0.5;
    }

    var_0 = self.issighted _meth_866B("light");

    if(var_0 != "green")
      self.issighted setscriptablepartstate("light", "green");
  }
}

monk_head_find_think() {
  var_0 = self;
  var_0 waittill("trigger", var_1);
  var_2 = _getent(var_0.target, "targetname");
  var_2 delete();
  common_scripts\utility::flag_set("flag_monk_head_found");
}

monk_head_place_think() {
  var_0 = self.controller_trig;
  var_1 = self._id_00B9;

  while(!common_scripts\utility::_id_3C77("flag_monk_head_placed")) {
    var_0 waittill("trigger", var_2);

    if(!common_scripts\utility::_id_3C77("flag_monk_head_found")) {
      continue;
    }
    var_1 show();
    common_scripts\utility::flag_set("flag_monk_head_placed");
  }

  wait 0.75;
  maps\mp\zquests\casual\island_ee_util::monk_head_dialogue("zmb_isla_monk_sputteringgaspingsoundsof");
  wait 0.15;
  maps\mp\zquests\casual\island_ee_util::monk_head_dialogue("zmb_isla_monk_behindthedoorthemotherwai");
  wait 0.35;
  maps\mp\zquests\casual\island_ee_util::monk_head_dialogue("zmb_isla_monk_thefirstcaughtredandburie");
  wait 0.15;
  maps\mp\zquests\casual\island_ee_util::monk_head_dialogue("zmb_isla_monk_butthefinalladgonestillwi");
}

monk_head_operate_machine() {
  var_0 = self.controller_trig;
  var_1 = undefined;
  common_scripts\utility::_id_3C9F("flag_monk_head_placed");
  var_0 thread freezer_occupied_nag();

  while(!common_scripts\utility::_id_3C77("flag_monk_head_retrieved")) {
    var_0 waittill("trigger", var_2);
    var_3 = var_2 spine_get_type();

    if(!isDefined(var_3) || common_scripts\utility::_id_3C77("flag_crane_in_motion") || level.freezer_crane._id_931A == "request_retrieve") {
      continue;
    }
    switch (var_3) {
      case "pest_spine":
        if(common_scripts\utility::_id_3C77("flag_hc_escort_active") || common_scripts\utility::_id_3C77("flag_loader_zombie_unavailable")) {
          var_0 notify("occupied_nag");
          continue;
        }

        common_scripts\utility::flag_set("flag_sacrificed_sprinter_spine");
        var_1 = "hc_pest";
        break;
      case "wustling_spine":
        if(common_scripts\utility::_id_3C77("flag_hc_escort_active") || common_scripts\utility::_id_3C77("flag_loader_zombie_unavailable")) {
          var_0 notify("occupied_nag");
          continue;
        }

        common_scripts\utility::flag_set("flag_sacrificed_follower_spine");
        var_1 = "hc_follower";
        break;
      case "assassin_spine":
        if(common_scripts\utility::_id_3C77("flag_hc_escort_active") || common_scripts\utility::_id_3C77("flag_loader_zombie_unavailable")) {
          var_0 notify("occupied_nag");
          continue;
        }

        var_1 = "hc_assassin";
        common_scripts\utility::flag_set("flag_sacrificed_assassin_spine");
        break;
      case "zombie_spine":
        var_1 = "hc_zombie";
        break;
      default:
        break;
    }

    common_scripts\utility::_id_379A("freezer_machine_working");
    common_scripts\utility::flag_set("flag_loader_zombie_unavailable");
    var_2 maps\mp\zquests\casual\island_ee_util::spine_player_clear_data();
    level notify("freezeer_summon_zombie", var_1);
    level waittill("freezer_zombie_placed", var_4);
    common_scripts\utility::_id_3796("freezer_machine_working");
    level thread spine_perform_escort(var_1, var_4);
  }
}

spine_get_type() {
  var_0 = self;

  if(!isDefined(var_0.spine_flag)) {
    return;
  }
  switch (var_0.spine_flag) {
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
    wait 1;
  }
}

spine_perform_escort(var_0, var_1) {
  switch (var_0) {
    case "escort_bomber":
      break;
    case "hc_pest":
      if(common_scripts\utility::_id_3C77("flag_hc_escort_active")) {
        return;
      }
      if(common_scripts\utility::_id_3C77("zmb_hc_pest_destination")) {
        common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
        return;
      }

      common_scripts\utility::flag_set("flag_hc_escort_active");
      pest_escort_quest_main(var_1);
      break;
    case "hc_assassin":
      if(common_scripts\utility::_id_3C77("flag_hc_escort_active")) {
        return;
      }
      if(common_scripts\utility::_id_3C77("zmb_hc_assassin_destination")) {
        common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
        return;
      }

      common_scripts\utility::flag_set("flag_hc_escort_active");
      assassin_escort_quest_main(var_1);
      break;
    case "hc_follower":
      if(common_scripts\utility::_id_3C77("flag_hc_escort_active")) {
        return;
      }
      if(common_scripts\utility::_id_3C77("zmb_hc_follower_destination")) {
        common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
        return;
      }

      common_scripts\utility::flag_set("flag_hc_escort_active");
      wustling_escort_quest_main(var_1);
      break;
    case "hc_zombie":
      if(common_scripts\utility::_id_3C77("players_spawned_statue_piece_2")) {
        common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
        return;
      }

      common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
      fodder_escort_quest_main(var_1);
      break;
    default:
      break;
  }
}

freezer_occupied_nag() {
  var_0 = self;

  for(;;) {
    var_0 waittill("occupied_nag", var_1);

    if(!common_scripts\utility::_id_3C77("flag_hc_escort_active")) {
      continue;
    }
    wait 0.75;
    maps\mp\zquests\casual\island_ee_util::monk_head_dialogue("zmb_isla_monk_nochildnoyoumustfinishyou");
    wait 2;
  }
}

pest_escort_quest_main(var_0) {
  var_1 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_1_start_point");
  var_2 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_2_start_point");
  var_3 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_3_start_point");
  var_4 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_4_start_point");
  var_5 = pest_hc_zombie_get_path_chain("hc_color_rune_pest_path_5_start_point");
  level.hc_pest = var_0;
  level.hc_pest pest_hc_zombie_post_drop_setup();

  for(;;) {
    var_6 = 0;

    if(!common_scripts\utility::_id_3C77("flag_pest_painted_1")) {
      var_6 = pest_hc_main_do_challenge(var_1, 5, 10, 1, "flag_pest_painted_1", "hc_color_rune_pest_path_1_hit_loc");

      if(!common_scripts\utility::_id_562E(var_6)) {
        common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::_id_3C7B("flag_hc_escort_active");
        return;
      }
    }

    if(!common_scripts\utility::_id_3C77("flag_pest_painted_2")) {
      var_6 = pest_hc_main_do_challenge(var_2, 5, 7, 4, "flag_pest_painted_2", "hc_color_rune_pest_path_2_hit_loc");

      if(!common_scripts\utility::_id_562E(var_6)) {
        common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::_id_3C7B("flag_hc_escort_active");
        return;
      }
    }

    if(!common_scripts\utility::_id_3C77("flag_pest_painted_3")) {
      var_6 = pest_hc_main_do_challenge(var_3, 4, 6, 5, "flag_pest_painted_3", "hc_color_rune_pest_path_3_hit_loc");

      if(!common_scripts\utility::_id_562E(var_6)) {
        common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::_id_3C7B("flag_hc_escort_active");
        return;
      }
    }

    if(!common_scripts\utility::_id_3C77("flag_pest_painted_4")) {
      var_6 = pest_hc_main_do_challenge(var_4, 3, 5, 7, "flag_pest_painted_4", "hc_color_rune_pest_path_4_hit_loc");

      if(!common_scripts\utility::_id_562E(var_6)) {
        common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::_id_3C7B("flag_hc_escort_active");
        return;
      }
    }

    if(!common_scripts\utility::_id_3C77("flag_pest_painted_5")) {
      var_6 = pest_hc_main_do_challenge(var_5, 2, 4, 7, "flag_pest_painted_5", "hc_color_rune_pest_path_5_hit_loc", 1);

      if(!common_scripts\utility::_id_562E(var_6)) {
        common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
        common_scripts\utility::_id_3C7B("flag_hc_escort_active");
        return;
      }
    }

    level.hc_pest._id_2A9D = "scripted_soul_eat";
    level.hc_pest.anointed_fx delete();
    level.hc_pest.anointed_fx_model delete();
    thread maps\mp\zquests\casual\island_ee_util::escort_health_display_remove();
    level.hc_pest dodamage(level.hc_pest.health + 666, level.hc_pest.origin);
    break;
  }

  common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
  common_scripts\utility::flag_set("flag_hc_pest_paint_complete");
  pagan_room_pest_wait_for_rush();
}

pagan_room_pest_wait_for_rush() {
  maps\mp\_utility::_id_2CED(0.75, maps\mp\zquests\casual\island_ee_util::monk_head_dialogue, "zmb_isla_monk_gotonerthusthatblackheart", 1);
  pomel_room_players_wait();
  maps\mp\zquests\casual\island_ee_util::clear_all_zombies();
  thread pomel_door_close();
  _id_0547::_id_AAFB("isolated_room_close_to_pool_trig");
  var_0 = common_scripts\utility::_id_46B7("pagan_room_zombie_dropdown_top", "targetname");
  var_1 = common_scripts\utility::random(var_0);
  var_2 = _id_054D::_id_90BA("zombie_berserker", var_1, "anointed_pest", 0, 1, 0);
  var_2.ispassiveexempt = 1;
  var_2.is_anointed = 1;
  var_2 maps\mp\agents\_agent_common::_id_83FD(int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_escort_hc_pest_health_main")));
  var_2.pommel_room_boss = 1;

  if(_id_0547::_id_5565(level.zmb_anointed_pest_dies_to_ripsaw_gun, 0))
    var_2.ripsaw_hardened = 1;

  var_2._id_55AB = 1;
  var_2._id_0C29 = 0;
  var_2.isobjectiveexemptfromfog = 1;
  var_2._id_562B = 1;
  var_3 = 0.348889;
  var_2 scragentsetmaxturnspeed(var_3);
  var_4 = spawn("script_model", var_2.origin);
  var_4 setModel("tag_origin");
  var_4 linkto(var_2, "j_mainroot", (0, 0, 0), (0, 0, 0));
  var_2.anointed_fx_model = var_4;
  var_2.anointed_fx = _spawnlinkedfx(common_scripts\utility::_id_44F5(pest_hc_util_get_anointed_fx(7)), var_4, "tag_origin");
  _triggerfx(var_2.anointed_fx);
  var_2 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_2.anointed_fx);
  _id_0547::_id_7BA9(::anointed_zombie_death_listener);
  _id_0547::_id_7BA9(::pest_pagan_zombie_death_listener);
  pagan_room_do_pest_rush();
  common_scripts\utility::flag_set("anointed_zombies_done_spawning");
  wait_for_all_bosses_defeated();
  _id_0547::_id_2D8C(::anointed_zombie_death_listener);
  _id_0547::_id_2D8C(::pest_pagan_zombie_death_listener);
  common_scripts\utility::flag_set("zmb_hc_pest_destination");
  pomel_door_open();
  common_scripts\utility::_id_3C7B("flag_hc_escort_active");
}

wait_for_all_bosses_defeated() {
  var_0 = 1;

  while(var_0) {
    var_0 = 0;

    foreach(var_2 in _id_0547::_id_408F()) {
      if(common_scripts\utility::_id_562E(var_2.pommel_room_boss))
        var_0 = 1;
    }

    waitframe();
    waitframe();
  }

  maps\mp\zquests\casual\island_ee_util::clear_all_zombies();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  level.maxed_zombies_sprint = 0;
}

pagan_room_do_pest_rush() {
  level endon("flag_anointed_pest_head_placed");
  var_0 = common_scripts\utility::_id_46B7("pagan_room_zombie_dropdown_top", "targetname");
  var_1 = common_scripts\utility::_id_46B7("pagan_room_zombie_dropdown_bottom", "targetname");
  var_2 = common_scripts\utility::_id_0F73(var_1, var_0);
  level.hc_pest_pagan_zombies = [];
  var_3 = maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_escort_hc_pest_spawn_numbers");
  var_4 = 0;
  var_5 = 0;

  while(var_5 < var_3) {
    if(var_4 >= var_2.size)
      var_4 = 0;

    var_6 = undefined;
    var_6 = _id_054D::_id_90BA("zombie_berserker", var_2[var_4], "pagan_pest_rush", 0, 1, 0);
    var_6.ispassiveexempt = 1;
    var_7 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980 + 2);
    var_6 maps\mp\agents\_agent_common::_id_83FD(int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_escort_hc_pest_health_buddy")));
    var_6._id_55AB = 1;
    var_6._id_0C29 = 0;
    var_6.isobjectiveexemptfromfog = 1;
    var_6._id_562B = 1;
    var_6.pommel_room_boss = 1;
    var_8 = 0.348889;
    var_6 scragentsetmaxturnspeed(var_8);

    if(isDefined(var_6))
      level.hc_pest_pagan_zombies[level.hc_pest_pagan_zombies.size] = var_6;

    var_4++;
    var_5++;
    wait(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_escort_hc_pest_spawn_rate"));
  }
}

pest_pagan_zombie_death_listener(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(level.hc_pest_pagan_zombies)) {
    if(common_scripts\utility::_id_0F79(level.hc_pest_pagan_zombies, self))
      level.hc_pest_pagan_zombies = common_scripts\utility::_id_0F93(level.hc_pest_pagan_zombies, self);
  }
}

anointed_zombie_death_listener(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(common_scripts\utility::_id_562E(self.is_anointed)) {
    if(_id_0547::_id_5565(level.hc_wustling, self))
      level.hc_wustling = undefined;

    level notify("pommel boss defeated");
    var_11 = self._id_0A4B;
    var_12 = self.origin;
    var_13 = self.angles;
    head_spawn_type(var_11, var_12, var_13);
  }
}

wait_for_player_in_zone(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = 0;
  var_3 = 1;

  if(var_1)
    var_3 = level.players.size;

  for(;;) {
    foreach(var_5 in level.players) {
      if(var_5.sessionstate == "spectator") {
        var_2--;
        continue;
      }

      foreach(var_7 in var_0) {
        if(_id_055A::_id_7413(var_5, var_7))
          var_2++;
      }
    }

    if(var_2 >= var_3) {
      break;
    } else
      wait 1;
  }
}

pest_hc_runes_init() {
  level.hc_color_runes = common_scripts\utility::_id_46B7("hc_color_rune", "targetname");

  foreach(var_1 in level.hc_color_runes) {
    if(isDefined(var_1.setlookatent) && _func_30D(int(var_1.setlookatent)))
      var_1.coil_color = int(var_1.setlookatent);

    if(isDefined(var_1._id_81C7))
      var_1.open_type = var_1._id_81C7;

    var_1.exposed = 0;
    var_2 = common_scripts\utility::_id_44BE(var_1.target, "targetname");

    foreach(var_4 in var_2) {
      var_5 = var_4._id_0165;

      if(!isDefined(var_5)) {
        continue;
      }
      switch (var_5) {
        case "rune_panel":
          var_1.panel = var_4;
          var_1.panel setcandamage(1);
          break;
        case "rune_panel_open_dest":
          var_1.panel_open_dest = var_4;
          break;
        case "rune_missile_clip":
          var_1.missile_clip = var_4;
          var_1.missile_clip setcandamage(1);
          break;
        case "rune_coil":
          var_1.coil = var_4;
          break;
        case "rune_coil_origin":
          var_1.coil_origin = var_4;
          break;
        case "rune_sweet_spot":
          var_1.optimal_fire_area = var_4;
          break;
        case "rune_optimal_path":
          var_1._id_9267 = var_4;

          if(isDefined(var_1._id_9267.target))
            var_1.optimal_target = common_scripts\utility::_id_44BD(var_1._id_9267.target, "targetname");

          break;
      }
    }
  }

  foreach(var_1 in level.hc_color_runes) {
    if(_id_0547::_id_5565(var_1.coil_color, 0)) {
      if(isDefined(var_1.coil))
        var_1.coil delete();

      if(isDefined(var_1.panel))
        var_1.panel delete();

      var_1.exposed = 1;
      var_1.open_type = "open_no_panel";
    }

    if(_id_0547::_id_5565(var_1.open_type, "open") || _id_0547::_id_5565(var_1.open_type, "open_no_panel")) {
      if(isDefined(var_1.panel))
        var_1 thread pest_hc_runes_open_panel();

      var_1 thread pest_hc_runes_damage_listener();
      continue;
    }

    if(_id_0547::_id_5565(var_1.open_type, "damage")) {
      if(isDefined(var_1.panel))
        var_1 thread pest_hc_runes_panel_damage_listener();
    }
  }

  thread maps\mp\_utility::_id_6F74(::pest_hc_razergun_monitor);
}

pest_hc_runes_open_panel() {
  if(isDefined(self._id_3F3F))
    self._id_3F3F delete();

  var_0 = pest_hc_util_get_filament_fx(self.coil_color);

  if(isDefined(var_0)) {
    self._id_3F3F = _spawnfx(common_scripts\utility::_id_44F5(var_0), self.coil.origin, anglesToForward(self.coil.angles), anglestoup(self.coil.angles));
    _triggerfx(self._id_3F3F, 0.25);
  }

  if(isDefined(self.panel)) {
    if(_id_0547::_id_5565(self.open_type, "open_no_panel"))
      self.panel ghost();
    else
      self.panel.angles = self.panel_open_dest.angles;

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

  if(isDefined(self._id_3F3F))
    self._id_3F3F delete();
}

pest_hc_runes_blow_off_panel() {
  if(isDefined(self._id_3F3F))
    self._id_3F3F delete();

  var_0 = pest_hc_util_get_filament_fx(self.coil_color);

  if(isDefined(var_0)) {
    self._id_3F3F = _spawnfx(common_scripts\utility::_id_44F5(var_0), self.coil.origin, anglesToForward(self.coil.angles), anglestoup(self.coil.angles));
    _triggerfx(self._id_3F3F, 0.25);
  }

  if(isDefined(self.panel)) {
    self.panel setModel("zmi_obj_fuse_box_door_dmged_01");
    var_1 = anglesToForward(self.panel.angles);
    self.panel physicslaunchclient(self.coil_origin.origin, var_1 * -80000);
    self.panel common_scripts\utility::_id_2CBE(5, ::delete);
  }

  self.exposed = 1;
}

pest_hc_runes_panel_damage_listener() {
  childthread pest_hc_runes_panel_type3_listener();
  childthread pest_hc_runes_panel_type2_listener();
  childthread pest_hc_runes_panel_type1_listener();
  common_scripts\utility::_id_A70A("panel_hit_type_1", "panel_hit_type_2", "panel_hit_type_3", "panel_scripted_pop");
  self notify("panel_destroyed");
  thread pest_hc_runes_blow_off_panel();
  thread pest_hc_runes_damage_listener();
}

pest_hc_runes_panel_type3_listener() {
  self endon("panel_destroyed");
  var_0 = "";

  for(var_1 = ""; var_0 != "MOD_GRENADE_SPLASH" && var_0 != "MOD_EXPLOSIVE" && !issubstr(var_1, "flak38") && !issubstr(var_1, "fliegerfaust"); var_1 = var_11) {
    self.panel waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0 = var_6;
  }

  self notify("panel_hit_type_3");
}

pest_hc_runes_panel_type2_listener() {
  self endon("panel_destroyed");
  var_0 = 0;

  while(!var_0) {
    level waittill("follower swing", var_1, var_2);

    if(distance(self.panel.origin, var_1) < var_2)
      var_0 = 1;
  }

  self notify("panel_hit_type_2");
}

pest_hc_runes_panel_type1_listener() {
  self endon("panel_destroyed");
  var_0 = 0;

  while(!var_0) {
    level waittill("objective_zombie_exploder_detonation", var_1, var_2);

    if(distance(self.panel.origin, var_1) < var_2)
      var_0 = 1;
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
      self.missile_clip waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

      if(!isDefined(var_9) || !issubstr(var_9, "razergun_") || !self.exposed) {
        continue;
      }
      break;
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_10 = 0;

      if(isDefined(self.optimal_fire_area) && var_1 istouching(self.optimal_fire_area))
        var_10 = 1;

      var_1 notify("rune_hit", self, var_10, var_2, var_3);
    }

    waitframe();
  }
}

pest_hc_blade_update_color(var_0) {
  if(!isDefined(var_0.coil_color)) {
    return;
  }
  if(var_0.coil_color == 0) {
    return;
  }
  if(_id_0547::_id_5565(self.current_color, var_0.coil_color)) {
    return;
  }
  if(!isDefined(self.current_color)) {
    self.current_color = var_0.coil_color;

    if(isDefined(self.current_trail_fx))
      _killfxontag(common_scripts\utility::_id_44F5(self.current_trail_fx), self, "tag_origin");
  } else {
    if(isDefined(self.color_fx))
      self.color_fx delete();

    if(isDefined(self.current_trail_fx))
      _killfxontag(common_scripts\utility::_id_44F5(self.current_trail_fx), self, "tag_origin");

    if(isDefined(self.trail_fx))
      self.trail_fx delete();

    self.current_color = pest_hc_util_combine_colors(var_0.coil_color, self.current_color);
  }

  var_1 = pest_hc_util_get_trail_fx(self.current_color);
  var_2 = _id_055A::_id_4562(self.origin);

  if(_id_0547::_id_5565(var_2, "sub_pens_1_zone")) {
    if(isDefined(level._effect[var_1 + "_int"]))
      var_1 = var_1 + "_int";
  }

  _playfxontag(common_scripts\utility::_id_44F5(var_1), self, "tag_origin");
  self.current_trail_fx = var_1;
}

pest_hc_blade_runes_hit_watch(var_0) {
  self endon("end_explode");
  self endon("explode");
  self endon("remove");
  self endon("death");
  var_0 endon("death");
  childthread pest_hc_blade_paint_watch(var_0);

  if(!isDefined(level.hc_color_runes)) {
    return;
  }
  for(;;) {
    var_0 waittill("rune_hit", var_1, var_2, var_3, var_4);

    if(!isDefined(self)) {
      continue;
    }
    var_5 = distance(self.origin, var_1._id_9267.origin);

    if(var_5 <= 32) {
      if(common_scripts\utility::_id_562E(self.on_scripted_path) || common_scripts\utility::_id_562E(var_2)) {
        thread pest_hc_color_runes_launch(var_1, var_3, var_4, var_0, self.current_color);
        _id_0378::_id_8D74("ripsaw_charge");
        self delete();
        return;
      } else
        thread pest_hc_blade_update_color(var_1);

      continue;
    }

    continue;
  }
}

pest_hc_blade_paint_watch(var_0) {
  var_1 = 64;
  var_2 = _squared(var_1);

  while(isDefined(self)) {
    if(!isDefined(level.hc_pest) || isDefined(level.hc_pest) && !isalive(level.hc_pest)) {
      wait 1;
      continue;
    }

    if(!isDefined(self.current_color)) {
      wait 0.25;
      continue;
    }

    if(!isDefined(level.hc_pest.desired_color)) {
      wait 1;
      continue;
    }

    if(distancesquared(level.hc_pest.origin + (0, 0, 48), self.origin) < var_2) {
      if(_id_0547::_id_5565(level.hc_pest.desired_color, self.current_color))
        level.hc_pest notify("hc_pest_hit");

      waitframe();
      continue;
    }

    if(isDefined(level.hc_pest.optimal_trigger)) {
      if(self istouching(level.hc_pest.optimal_trigger) && level.hc_pest istouching(level.hc_pest.optimal_trigger)) {
        if(_id_0547::_id_5565(level.hc_pest.desired_color, self.current_color))
          level.hc_pest notify("hc_pest_hit");

        waitframe();
        continue;
      }
    }

    waitframe();
  }
}

pest_hc_razergun_monitor() {
  var_0 = maps\mp\zombies\weapons\_zombie_razer_gun::get_razorgun_gunname();

  for(;;) {
    self waittill("missile_fire", var_1, var_2);

    if(isDefined(var_2) && issubstr(var_2, var_0)) {
      if(!isDefined(var_1._id_9255))
        var_1._id_9255 = var_1.origin;

      if(!isDefined(var_1.on_scripted_path))
        var_1.on_scripted_path = 0;

      var_1 thread pest_hc_blade_runes_hit_watch(self);
    }
  }
}

pest_hc_util_get_filament_fx(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    return var_1;

  switch (var_0) {
    case 1:
      var_1 = "zmi_hc_rune_cyan_filament";
      break;
    case 2:
      var_1 = "zmi_hc_rune_magenta_filament";
      break;
    case 3:
      var_1 = "zmi_hc_rune_yellow_filament";
      break;
    case 4:
      var_1 = "zmi_hc_rune_red_filament";
      break;
  }

  return var_1;
}

pest_hc_util_get_blade_fx(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    return var_1;

  switch (var_0) {
    case 1:
      var_1 = "zmi_hc_rune_cyan";
      break;
    case 2:
      var_1 = "zmi_hc_rune_magenta";
      break;
    case 3:
      var_1 = "zmi_hc_rune_yellow";
      break;
    case 4:
      var_1 = "zmi_hc_rune_red";
      break;
    case 5:
      var_1 = "zmi_hc_rune_green";
      break;
    case 6:
      var_1 = "zmi_hc_rune_blue";
      break;
    case 7:
      var_1 = "zmi_hc_rune_black";
      break;
  }

  return var_1;
}

pest_hc_util_get_anointed_fx(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    return var_1;

  switch (var_0) {
    case 1:
      var_1 = "zmi_hc_pest_anointed_cyan";
      break;
    case 4:
      var_1 = "zmi_hc_pest_anointed";
      break;
    case 5:
      var_1 = "zmi_hc_pest_anointed_green";
      break;
    case 7:
      var_1 = "zmi_hc_pest_anointed_black";
      break;
  }

  return var_1;
}

pest_hc_util_get_trail_fx(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    return var_1;

  switch (var_0) {
    case 1:
      var_1 = "zmb_razergun_cyan_trail";
      break;
    case 2:
      var_1 = "zmb_razergun_magenta_trail";
      break;
    case 3:
      var_1 = "zmb_razergun_yellow_trail";
      break;
    case 4:
      var_1 = "zmb_razergun_red_trail";
      break;
    case 5:
      var_1 = "zmb_razergun_green_trail";
      break;
    case 6:
      var_1 = "zmb_razergun_blue_trail";
      break;
    case 7:
      var_1 = "zmb_razergun_white_trail";
      break;
  }

  return var_1;
}

pest_hc_util_combine_colors(var_0, var_1) {
  if(var_0 == var_1)
    return var_0;

  switch (var_0) {
    case 1:
      if(var_1 == 2)
        return 6;
      else if(var_1 == 3)
        return 5;
      else if(var_1 == 4)
        return 7;
      else if(var_1 == 5)
        return 5;
      else if(var_1 == 6)
        return 6;
      else if(var_1 == 7)
        return 7;

      break;
    case 2:
      if(var_1 == 3)
        return 4;
      else if(var_1 == 1)
        return 6;
      else if(var_1 == 4)
        return 4;
      else if(var_1 == 5)
        return 7;
      else if(var_1 == 6)
        return 6;
      else if(var_1 == 7)
        return 7;

      break;
    case 3:
      if(var_1 == 2)
        return 4;
      else if(var_1 == 1)
        return 5;
      else if(var_1 == 4)
        return 7;
      else if(var_1 == 5)
        return 5;
      else if(var_1 == 6)
        return 7;
      else if(var_1 == 7)
        return 7;

      break;
    default:
      break;
  }
}

pest_hc_util_get_impact_fx(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    return var_1;

  switch (var_0) {
    case 1:
      var_1 = "zmi_hc_pest_impact_cyan";
      break;
    case 2:
      var_1 = "zmi_hc_pest_impact_magenta";
      break;
    case 3:
      var_1 = "zmi_hc_pest_impact_yellow";
      break;
    case 4:
      var_1 = "zmi_hc_pest_impact_red";
      break;
    case 5:
      var_1 = "zmi_hc_pest_impact_green";
      break;
    case 6:
      var_1 = "zmi_hc_pest_impact_blue";
      break;
    case 7:
      var_1 = "zmi_hc_pest_impact_black";
      break;
  }

  return var_1;
}

pest_hc_color_runes_launch(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0.rune_current_target)) {
    var_5 = _magicbullet("razergun_zm", var_2, var_0.rune_current_target.origin, var_3);
    var_5.on_scripted_path = 1;

    if(isDefined(var_4))
      var_5.current_color = var_4;

    var_5 thread pest_hc_blade_update_color(var_0);
    var_5 thread pest_hc_blade_runes_hit_watch(var_3);
  }
}

pest_hc_main_do_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_5)) {
    var_7 = _getent(var_5, "targetname");

    if(isDefined(var_7))
      level.hc_pest.optimal_trigger = var_7;
  }

  level.hc_pest.desired_color = var_3;
  level.hc_pest thread pest_hc_zombie_wander(var_0, var_1, var_2, var_4);
  var_8 = level.hc_pest common_scripts\utility::waittill_any_return("escort_goal_reached", "death");

  if(_id_0547::_id_5565(var_8, "death")) {
    common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
    common_scripts\utility::_id_3C7B("flag_hc_escort_active");
    return 0;
  }

  var_8 = level.hc_pest common_scripts\utility::waittill_any_return("hc_pest_hit", "death");

  if(_id_0547::_id_5565(var_8, "death")) {
    common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
    common_scripts\utility::_id_3C7B("flag_hc_escort_active");
    return 0;
  } else if(_id_0547::_id_5565(var_8, "hc_pest_hit")) {
    common_scripts\utility::flag_set(var_4);
    level.hc_pest _id_0378::_id_8D74("charged_ripsaw_hit_pest");
    playFX(common_scripts\utility::_id_44F5(pest_hc_util_get_impact_fx(var_3)), level.hc_pest.origin + (0, 0, 32));
    level.hc_pest thread pest_hc_zombie_stun_burst();

    if(level.hc_pest.health < level.hc_pest.maxhealth) {
      if(level.hc_pest.health + int(level.hc_pest.maxhealth * 0.25) > level.hc_pest.maxhealth) {
        level.hc_pest.health = level.hc_pest.maxhealth;
        level.hc_pest._id_0008 = level.hc_pest.maxhealth;
      } else {
        level.hc_pest._id_0008 = level.hc_pest._id_0008 + int(level.hc_pest.maxhealth * 0.25);
        level.hc_pest.health = level.hc_pest.health + int(level.hc_pest.maxhealth * 0.25);
      }

      level.hc_pest notify("escort_heal");
    }

    level.hc_pest notify("hc_pest_stop_wander");

    if(common_scripts\utility::_id_562E(level.hc_pest.is_idling))
      level.hc_pest pest_hc_zombie_awakenidle();

    if(!common_scripts\utility::_id_562E(var_6)) {
      level.hc_pest maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(level.hc_pest.origin, level.hc_pest.angles, "s2_scripted_shock", 0, 0, undefined, 1);
      level.hc_pest.anointed_fx delete();
      level.hc_pest.anointed_fx = _spawnlinkedfx(common_scripts\utility::_id_44F5(pest_hc_util_get_anointed_fx(var_3)), level.hc_pest.anointed_fx_model, "tag_origin");
      _triggerfx(level.hc_pest.anointed_fx);
    }

    return 1;
  }
}

pest_hc_zombie_setup() {
  self.escort_zombie = 1;
  self.isobjectiveexemptfromfog = 1;
  self._id_6816 = 1;
  self._id_0C29 = 0;
  self.shouldnotpreventlaststand = 1;
  self.ispassiveexempt = 1;
  self._id_55AB = 1;
  self._id_562B = 1;
  self._id_00CE = 1;
  _id_0547::_id_8A6D(1);
  self.on_damage_override = ::pest_hc_zombie_on_damage;
  self._id_297D = ::pest_hc_zombie_custom_movemode;
  maps\mp\agents\_agent_common::_id_83FD(5000);
  maps\mp\agents\_agent_utility::hudoutlineenable(level._id_746E);
  self._id_6701 = 1;
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("tag_origin");
  var_0 linkto(self, "j_mainroot", (0, 0, 0), (0, 0, 0));
  self.anointed_fx_model = var_0;
  self.anointed_fx = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmi_hc_pest_anointed"), var_0, "tag_origin");
  _triggerfx(self.anointed_fx);
  thread setup_escort_pest_failsafe();
}

setup_escort_pest_failsafe() {
  self endon("death");

  for(;;) {
    var_0 = common_scripts\utility::_id_A74D("hc_pest_hit", 600);

    if(_id_0547::_id_5565(var_0, "timeout")) {
      break;
    }
  }

  if(isDefined(self))
    self suicide();
}

pest_hc_zombie_post_drop_setup() {
  self._id_0009 = &"zombie_island_sacrifice_name";
  self._id_00CE = 0;
  _id_0547::_id_8A6D(0);
  self._id_6701 = 0;
  var_0 = 0.348889;
  self _meth_85DE(var_0);
  thread maps\mp\zquests\casual\island_ee_util::escort_health_display_start(self, -40);
  thread maps\mp\zquests\casual\island_ee_util::escort_health_display_death_listener();
  thread maps\mp\zquests\casual\island_ee_util::escort_health_display_damage_listener();
  thread maps\mp\zquests\casual\island_ee_util::escort_health_display_heal_listener();
}

pest_hc_zombie_on_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(self._id_0117)) {
    var_11 = isDefined(var_1) && self._id_0117 == var_1;
    var_12 = maps\mp\_utility::_id_118D(self._id_0117, var_1) || var_11;
  } else {
    var_11 = 0;
    var_12 = maps\mp\_utility::_id_118D(self, var_1);
  }

  if(isDefined(var_1) && _isagent(var_1)) {
    if(isDefined(var_1._id_0A4B)) {
      switch (var_1._id_0A4B) {
        case "zombie_generic":
          var_2 = var_2 * 0.25;
          break;
        case "zombie_berserker":
          var_2 = var_2 * 0.35;
          break;
        case "zombie_exploder":
          var_2 = var_2 * 0.5;
          break;
        case "zombie_heavy":
          var_2 = var_2 * 0.75;
          break;
        case "zombie_assassin":
          var_2 = var_2 * 0.9;
          break;
        default:
          var_2 = var_2 * 0.5;
          break;
      }
    }
  }

  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

pest_hc_zombie_wander(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("hc_pest_stop_wander");
  level endon(var_3);

  if(!isDefined(var_1) || !isDefined(var_2)) {
    if(isDefined(var_1))
      var_2 = var_1;
    else if(isDefined(var_2))
      var_1 = var_2;
    else {
      var_1 = 5;
      var_2 = 10;
    }
  }

  if(var_1 > var_2)
    var_1 = var_2;

  var_4 = _randomintrange(0, var_0.size);
  var_5 = common_scripts\utility::_id_24A6();

  for(;;) {
    if(common_scripts\utility::_id_3C77(var_3)) {
      break;
    }

    if(!isDefined(var_0[var_4])) {
      return;
    }
    var_6 = var_0[var_4];
    self._id_1928 = var_6;
    childthread maps\mp\zquests\casual\island_ee_util::waittill_at_waypoint(var_6);
    self waittill("escort_goal_reached");
    pest_hc_zombie_forceidle();

    if(var_1 == var_2)
      wait(var_1);
    else
      wait(_randomintrange(var_1, var_2));

    pest_hc_zombie_awakenidle();

    if(!var_5) {
      if(var_4 + 1 < var_0.size)
        var_4++;
      else
        var_4 = 0;

      continue;
    }

    if(var_4 - 1 < 0) {
      var_4 = var_0.size - 1;
      continue;
    }

    var_4--;
  }
}

pest_hc_zombie_forceidle(var_0) {
  self scragentsetscripted(1);
  self._id_00CA = 1;
  self.is_idling = 1;
  var_1 = "passive_idle_berserker";
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_1, var_0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "hc_pest_idle");
  self._id_509A = 1;
}

pest_hc_zombie_awakenidle() {
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "hc_pest_idle");
  self scragentsetscripted(0);
  self._id_509A = 0;
  self._id_00CA = 0;
  self.is_idling = 0;
}

pest_hc_zombie_custom_movemode() {
  self._id_64C2 = 0.75 * _id_054D::_id_4440();
  return "sprint";
}

pest_hc_zombie_stun_burst() {
  self endon("death");
  _id_0378::_id_8D74("aud_stunning_burst_use");
  _id_053A::mini_stunning_burst_execute(self.origin, undefined, 480, 5, undefined, self, undefined, undefined);
}

pest_hc_zombie_get_path_chain(var_0) {
  var_1 = [];
  var_2 = common_scripts\utility::_id_46B5(var_0, "targetname");
  var_1[0] = var_2;
  var_3 = var_2;

  for(;;) {
    if(isDefined(var_3.target)) {
      var_4 = common_scripts\utility::_id_46B5(var_3.target, "targetname");
      var_1[var_1.size] = var_4;
      var_3 = var_4;
      continue;
    }

    break;
  }

  return var_1;
}

wustling_hc_zombie_setup() {
  self.escort_zombie = 1;
  self.isobjectiveexemptfromfog = 1;
  self._id_6816 = 1;
  self._id_0C29 = 0;
  self.shouldnotpreventlaststand = 1;
  self.ispassiveexempt = 1;
  self._id_55AB = 1;
  self._id_562B = 1;
  self.escort_player_distance = 147456;
  self.escort_player_too_close = 5184;
  self.escort_follow_track_time = 4;
  self.escort_blitz_distance = 65536;
  self.escort_blitz_attack_time = 4;
  self.escort_follow_track_time = 4;
  self._id_297D = ::wustling_zombie_custom_movemode;
  maps\mp\agents\_agent_common::_id_83FD(4000);
  self.hc_escort_blitz_buffs = [];
  self.hc_escort_blitz_buffs_attack_mod = 1;
  self.elec_cherry_cooldown = 16;
  self._id_6701 = 1;
  self._id_00CE = 1;
  _id_0547::_id_8A6D(1);
  maps\mp\agents\_agent_utility::hudoutlineenable(level._id_746E);
  wustling_buff_manager_setup();
  self.custom_think_mode = ::wustling_hc_think;
  self.escort_hit_track_time = 2;
  self.recently_hit_by_player = 0;
  self.recently_hit_player = undefined;
  self.escort_state = undefined;
  self.escort_state_previous = undefined;

  if(!isDefined(level._id_6BD2) || isDefined(level._id_6BD2) && !common_scripts\utility::_id_0F79(level._id_6BD2, ::wustling_hc_track_player_hit))
    _id_054D::_id_7BC6(::wustling_hc_track_player_hit);

  thread setup_escort_follower_failsafe();
}

setup_escort_follower_failsafe() {
  self endon("death");
  self endon("zmb_hc_follower_destination");

  for(;;) {
    var_0 = common_scripts\utility::_id_A74D("wustling_received_buff", 600);

    if(_id_0547::_id_5565(var_0, "timeout")) {
      break;
    }
  }

  if(isDefined(self))
    self suicide();
}

wustling_hc_think() {
  if(_id_053C::_id_4F9B(1)) {
    return;
  }
  _id_053C::_id_0647();
}

wustling_zombie_custom_movemode() {
  self._id_672D = self.hc_escort_blitz_buffs_attack_mod;

  if(isDefined(self.hc_escort_blitz_buffs) && common_scripts\utility::_id_0F79(self.hc_escort_blitz_buffs, "runperk"))
    return "sprint";
  else {
    var_0 = _id_0567::_id_ABC3();
    return var_0;
  }
}

wustling_hc_track_player_hit(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(common_scripts\utility::_id_562E(self._id_AC10) || !isDefined(self._id_0A4B) || !isDefined(var_1) || !common_scripts\utility::_id_562E(self.isfreezerzombie) || !isDefined(level.hc_wustling) || isDefined(level.hc_wustling) && self != level.hc_wustling) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(!maps\mp\_utility::_id_118D(self, var_1)) {
    return;
  }
  self notify("wustling_escort_hit_by_player");
  self endon("wustling_escort_hit_by_player");
  self.recently_hit_by_player = 1;
  self.recently_hit_player = var_1;
  wait(self.escort_hit_track_time);
  self.recently_hit_by_player = 0;
  self.recently_hit_player = undefined;
}

wustling_hc_cleanup_org(var_0) {
  self waittill("death");
  level.hc_wustling = undefined;
  var_0 delete();
}

wustling_hc_zombie_post_drop_setup() {
  self._id_0009 = &"zombie_island_sacrifice_name";
  var_0 = 0.348889;
  self _meth_85DE(var_0);
  self._id_6701 = 0;
  self._id_00CE = 0;
  _id_0547::_id_8A6D(0);
  thread maps\mp\zquests\casual\island_ee_util::escort_health_display_start(self, -40);
  thread maps\mp\zquests\casual\island_ee_util::escort_health_display_death_listener();
  thread maps\mp\zquests\casual\island_ee_util::escort_health_display_damage_listener();
  thread maps\mp\zquests\casual\island_ee_util::escort_health_display_heal_listener();
  self.player_track_org = common_scripts\utility::_id_8FFC();
  self.player_track_org linkto(self, "tag_origin");
  thread wustling_hc_cleanup_org(self.player_track_org);
}

wustling_escort_quest_main(var_0) {
  level.hc_wustling = var_0;
  level.hc_wustling endon("death");
  level.hc_wustling wustling_hc_zombie_post_drop_setup();
  level.hc_wustling thread wustling_hc_freezer_reset();
  var_1 = common_scripts\utility::_id_46B5("wustling_hc_waypoint_start", "script_noteworthy");
  var_2 = common_scripts\utility::_id_46B5("wustling_hc_waypoint_reloadspeed", "script_noteworthy");
  var_3 = common_scripts\utility::_id_46B5("wustling_hc_waypoint_shootspeed", "script_noteworthy");
  var_4 = common_scripts\utility::_id_46B5("wustling_hc_waypoint_meleedamage", "script_noteworthy");
  var_5 = common_scripts\utility::_id_46B5("wustling_hc_waypoint_runspeed", "script_noteworthy");
  var_6 = common_scripts\utility::_id_46B5("wustling_hc_waypoint_shock", "script_noteworthy");
  var_7 = common_scripts\utility::_id_46B5("wustling_hc_waypoint_revive", "script_noteworthy");
  var_8 = common_scripts\utility::_id_46B5("wustling_hc_waypoint_end", "script_noteworthy");
  level.hc_wustling.wps_wander_sequence = [var_2, var_6, var_3, var_5, var_4, var_7];
  var_9 = ["doubletap", "punchperk", "runperk", "quickrevive"];
  level.hc_wustling._id_1928 = var_1;
  level.hc_wustling._id_11AB = 0;

  while(distance(var_1.origin, level.hc_wustling.origin) > 64)
    waitframe();

  while(!common_scripts\utility::_id_3C77("zmb_hc_follower_destination")) {
    var_10 = level.hc_wustling wustling_escort_get_state();
    var_11 = undefined;

    switch (level.hc_wustling.escort_state) {
      case "track_hit":
        var_11 = ::wustling_track_player;
        break;
      case "close_blitz":
        var_11 = ::wustling_attack_blitz;
        break;
      case "track_player":
        var_11 = ::wustling_track_player;
        break;
      default:
        break;
    }

    if(isDefined(var_11))
      level.hc_wustling[[var_11]](var_10);
    else
      level.hc_wustling wustling_wander_wp_walkto(var_10);

    wait 0.1;
    var_10 = undefined;
    var_11 = undefined;

    if(common_scripts\utility::_id_0F78(level.hc_wustling.hc_escort_blitz_buffs, var_9)) {
      break;
    }
  }

  level.hc_wustling._id_1928 = var_8;

  while(distance(var_8.origin, level.hc_wustling.origin) > 64)
    waitframe();

  maps\mp\_utility::_id_2CED(0.75, maps\mp\zquests\casual\island_ee_util::monk_head_dialogue, "zmb_isla_monk_ripthestrengthfromthemigh", 1);
  common_scripts\utility::flag_set("zmb_hc_follower_destination");
  thread wustling_boss_fight_wait();
  common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
  level.hc_wustling suicide();
}

wustling_hc_freezer_reset() {
  self waittill("death");
  waitframe();

  if(!common_scripts\utility::_id_3C77("zmb_hc_follower_destination")) {
    common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
    common_scripts\utility::_id_3C7B("flag_hc_escort_active");
  }
}

wustling_boss_fight_wait() {
  pomel_room_players_wait();
  maps\mp\zquests\casual\island_ee_util::clear_all_zombies();
  thread pomel_door_close();
  _id_0547::_id_AAFB("isolated_room_close_to_pool_trig");
  pagan_room_do_wustling_rush();
  pomel_door_open();
}

wustling_escort_get_state() {
  if(self.recently_hit_by_player) {
    self.escort_state = "track_hit";
    return self.recently_hit_player;
  }

  foreach(var_1 in self.wps_wander_sequence) {
    if(distancesquared(self.origin, var_1.origin) > self.escort_blitz_distance) {
      continue;
    }
    self.escort_state = "close_blitz";
    return var_1;
  }

  foreach(var_4 in level.players) {
    if(distancesquared(self.origin, var_4.origin) > self.escort_player_distance) {
      continue;
    }
    self.escort_state = "track_player";
    return var_4;
  }

  self.escort_state = "wander_to_blitz";

  if(!isDefined(self.escort_state_previous) || self.escort_state != self.escort_state_previous) {
    self.escort_state_previous = self.escort_state;
    self.wps_wander_sequence = _sortbydistance(self.wps_wander_sequence, self.origin);
  }

  return self.wps_wander_sequence[0];
}

wustling_track_player(var_0) {
  self notify("wustling_begin_tracking_player");
  self endon("wustling_begin_tracking_player");
  self endon("wustling_player_track_failed");
  self endon("wustling_received_buff");
  childthread wustling_track_player_link_think(self.player_track_org, var_0);
  wait(self.escort_follow_track_time);
  self notify("wustling_player_track_timeout");
}

wustling_track_player_link_think(var_0, var_1) {
  var_2 = 0;
  level.hc_wustling._id_1928 = self.player_track_org;

  for(;;) {
    if(!common_scripts\utility::_id_562E(var_2) && distancesquared(var_1.origin, self.origin) > self.escort_player_too_close) {
      thread hc_safe_linkTo(var_0, var_1);
      wustling_disable_idle();
      waitframe();
      var_2 = 1;
    } else if(common_scripts\utility::_id_562E(var_2) && !common_scripts\utility::_id_562E(self.hc_force_disable_idle) && distancesquared(var_1.origin, self.origin) <= self.escort_player_too_close) {
      wustling_enable_idle();
      var_2 = 0;
      var_1 notify("wustling_break_safelink");
    } else {}

    waitframe();
  }
}

hc_safe_linkTo(var_0, var_1) {
  self notify("wustling_begin_safelinkto");
  self endon("wustling_begin_safelinkto");
  self endon("wustling_begin_tracking_player");
  self endon("wustling_player_track_timeout");
  self endon("wustling_break_safelink");
  var_0.origin = var_1 gettagorigin("TAG_ORIGIN");
  var_0 linktosynchronizedparent(var_1, "TAG_ORIGIN");
  var_1 common_scripts\utility::_id_A70A("death", "disconnect", "wustling_break_safelink");
  var_0.origin = self gettagorigin("TAG_ORIGIN");
  var_0 linktosynchronizedparent(self, "TAG_ORIGIN");
  self notify("wustling_player_track_failed");
}

perk_machine_open(var_0) {
  var_1 = 0;

  if(isDefined(level.hc_wustling) && !common_scripts\utility::_id_3C77("zmb_hc_follower_destination")) {
    if(isDefined(level.hc_wustling.hc_escort_blitz_buffs) && !common_scripts\utility::_id_0F79(level.hc_wustling.hc_escort_blitz_buffs, var_0._id_6F63))
      var_1 = distancesquared(level.hc_wustling.origin, var_0.origin) < 25600;
  }

  return var_1;
}

wustling_attack_blitz(var_0) {
  var_1 = 0;
  self.hc_force_disable_idle = 1;
  wustling_disable_idle();
  level.hc_wustling._id_1928 = var_0;

  while(_distance2d(level.hc_wustling.origin, level.hc_wustling._id_1928.origin) > 24) {
    if(common_scripts\utility::_id_562E(self.recently_hit_by_player)) {
      self.hc_force_disable_idle = 0;
      return;
    }

    waitframe();
  }

  var_2 = "scripted_enhance";
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_2);
  self setOrigin(var_0.origin, 0);
  thread maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(var_0.origin, var_0.angles, var_3, 0, 0, undefined, 1, 0);
  wait 2;

  if(self.hc_escort_blitz_buffs.size >= 4) {
    _playfxontag(common_scripts\utility::_id_44F5("zmb_pm_blood_use"), self, "J_SpineUpper");
    self suicide();
  }

  level.hc_wustling wustling_get_buff(var_0);
  level.hc_wustling.wps_wander_sequence = common_scripts\utility::_id_0F93(level.hc_wustling.wps_wander_sequence, var_0);
  self.hc_force_disable_idle = 0;
}

wustling_get_buff(var_0) {
  if(_isstring(var_0))
    var_1 = var_0;
  else
    var_1 = var_0._id_0165;

  self notify("wustling_received_buff");
  var_2 = undefined;

  switch (var_1) {
    case "wustling_hc_waypoint_reloadspeed":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "fastreload";
      thread wustling_reload_buff_handle(var_2, "fastreload");
      break;
    case "wustling_hc_waypoint_shootspeed":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "doubletap";
      thread wustling_shootspeed_buff_handle(var_2, "doubletap");
      break;
    case "wustling_hc_waypoint_meleedamage":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "punchperk";
      thread wustling_meleedamage_buff_handle(var_2, "punchperk");
      break;
    case "wustling_hc_waypoint_runspeed":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "runperk";
      thread wustling_runspeed_buff_handle(var_2, "runperk");
      break;
    case "wustling_hc_waypoint_shock":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "electriccherry";
      thread wustling_shock_buff_handle(var_2, "electriccherry");
      break;
    case "wustling_hc_waypoint_revive":
      self.hc_escort_blitz_buffs[self.hc_escort_blitz_buffs.size] = "quickrevive";
      thread wustling_revive_buff_handle(var_2, "quickrevive");
      break;
    default:
      break;
  }
}

wustling_reload_buff_handle(var_0, var_1) {
  self.hc_escort_blitz_buffs_attack_mod = self.hc_escort_blitz_buffs_attack_mod + 0.1;
  wustling_buff_manager_add(var_1);
}

wustling_shootspeed_buff_handle(var_0, var_1) {
  self.hc_escort_blitz_buffs_attack_mod = self.hc_escort_blitz_buffs_attack_mod + 0.1;
  wustling_buff_manager_add(var_1);
}

wustling_meleedamage_buff_handle(var_0, var_1) {
  self._id_60E2 = self._id_60E2 * 1.25;
  wustling_buff_manager_add(var_1);
}

wustling_runspeed_buff_handle(var_0, var_1) {
  wustling_buff_manager_add(var_1);
}

wustling_shock_buff_handle(var_0, var_1) {
  thread wustling_electriccherry_think();
  wustling_buff_manager_add(var_1);
}

wustling_buff_manager_setup() {
  self.buff_slot_4 = spawn("script_model", self.origin);
  self.buff_slot_4 setModel("tag_origin");
  self.buff_slot_4 linkto(self, "J_Neck", (0, 5, 0), (60, 30, -90));
  self.buff_slot_4._id_3F44 = "zmb_electroschnelle_off_blood";
  self.buff_slot_4.sort_id = 4;
  self.buff_slot_4._id_3F3F = _spawnlinkedfx(level._effect[self.buff_slot_4._id_3F44], self.buff_slot_4, "TAG_ORIGIN");
  _triggerfx(self.buff_slot_4._id_3F3F);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.buff_slot_4);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.buff_slot_4._id_3F3F);
  self.buff_slot_3 = spawn("script_model", self.origin);
  self.buff_slot_3 setModel("tag_origin");
  self.buff_slot_3 linkto(self, "J_Spine4", (4, 6, 0), (50, 30, -90));
  self.buff_slot_3.sort_id = 3;
  self.buff_slot_3._id_3F44 = "zmb_electroschnelle_off_blood";
  self.buff_slot_3._id_3F3F = _spawnlinkedfx(level._effect[self.buff_slot_3._id_3F44], self.buff_slot_3, "TAG_ORIGIN");
  _triggerfx(self.buff_slot_3._id_3F3F);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.buff_slot_3);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.buff_slot_3._id_3F3F);
  self.buff_slot_2 = spawn("script_model", self.origin);
  self.buff_slot_2 setModel("tag_origin");
  self.buff_slot_2 linkto(self, "J_SpineUpper", (4, 6, 0), (40, 45, -90));
  self.buff_slot_2.sort_id = 2;
  self.buff_slot_2._id_3F44 = "zmb_electroschnelle_off_blood";
  self.buff_slot_2._id_3F3F = _spawnlinkedfx(level._effect[self.buff_slot_2._id_3F44], self.buff_slot_2, "TAG_ORIGIN");
  _triggerfx(self.buff_slot_2._id_3F3F);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.buff_slot_2);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.buff_slot_2._id_3F3F);
  self.buff_slot_1 = spawn("script_model", self.origin);
  self.buff_slot_1 setModel("tag_origin");
  self.buff_slot_1 linkto(self, "J_SpineLower", (4, 5, 0), (30, 30, -90));
  self.buff_slot_1.sort_id = 1;
  self.buff_slot_1._id_3F44 = "zmb_electroschnelle_off_blood";
  self.buff_slot_1._id_3F3F = _spawnlinkedfx(level._effect[self.buff_slot_1._id_3F44], self.buff_slot_1, "TAG_ORIGIN");
  _triggerfx(self.buff_slot_1._id_3F3F);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.buff_slot_1);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.buff_slot_1._id_3F3F);
  self.buff_slots = [self.buff_slot_1, self.buff_slot_2, self.buff_slot_3, self.buff_slot_4];
  self.buff_empty_slots = [self.buff_slot_1, self.buff_slot_2, self.buff_slot_3, self.buff_slot_4];
  self.active_buff_slots = [];
}

wustling_buff_manager_add(var_0) {
  var_1 = self.buff_empty_slots[0];
  var_1.buff_id = var_0;
  self.buff_empty_slots = common_scripts\utility::_id_0F9A(self.buff_empty_slots, 0);
  var_1._id_3F3F delete();
  self.active_buff_slots[self.active_buff_slots.size] = var_1;
  var_1._id_3F44 = wustling_buff_manager_get_buff_id(var_0);
  var_1._id_3F3F = _spawnlinkedfx(level._effect[var_1._id_3F44], var_1, "TAG_ORIGIN");
  _triggerfx(var_1._id_3F3F);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(var_1._id_3F3F);
}

wustling_buff_manager_remove(var_0) {
  var_1 = get_active_buff_slot(var_0);
  var_1.buff_id = undefined;
  self.hc_escort_blitz_buffs = common_scripts\utility::_id_0F93(self.hc_escort_blitz_buffs, var_0);
  self.active_buff_slots = common_scripts\utility::_id_0F93(self.active_buff_slots, var_1);
  self.buff_empty_slots = common_scripts\utility::_id_0F6F(self.buff_empty_slots, var_1);
  self.buff_empty_slots = common_scripts\utility::_id_0FA4(self.buff_empty_slots, ::sort_empty_slots);
  var_1._id_3F3F delete();
  var_1._id_3F44 = "zmb_electroschnelle_off_blood";
  var_1._id_3F3F = _spawnlinkedfx(level._effect[var_1._id_3F44], var_1, "TAG_ORIGIN");
  _triggerfx(var_1._id_3F3F);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(var_1._id_3F3F);
}

get_active_buff_slot(var_0) {
  foreach(var_2 in self.active_buff_slots) {
    if(isDefined(var_2.buff_id) && var_2.buff_id == var_0)
      return var_2;
  }
}

sort_empty_slots() {
  return self.sort_id;
}

wustling_buff_manager_get_buff_id(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "fastreload":
      var_1 = "zmb_electroschnelle_on_blood";
      break;
    case "doubletap":
      var_1 = "zmb_electroschnelle_on_storm";
      break;
    case "punchperk":
      var_1 = "zmb_electroschnelle_on_storm";
      break;
    case "runperk":
      var_1 = "zmb_electroschnelle_on_blood";
      break;
    case "electriccherry":
      var_1 = "zmb_electroschnelle_on_death";
      break;
    case "quickrevive":
      var_1 = "zmb_electroschnelle_on_moon";
      break;
    default:
      break;
  }

  return var_1;
}

wustling_electriccherry_think() {
  self notify("activate_shock_buff");
  self endon("activate_shock_buff");
  self endon("death");
  var_0 = common_scripts\utility::_id_5D92(0.15, 0, 1, 1, 1045);
  var_1 = common_scripts\utility::_id_5D92(0.75, 0, 1, 32, 128);
  wait(self.elec_cherry_cooldown);

  while(isalive(self)) {
    playFX(common_scripts\utility::_id_44F5("zmb_elec_cherry_wv"), self.origin);
    _id_0378::_id_8D74("electric_cherry_vfx");
    _playfxontagforclients(common_scripts\utility::_id_44F5("zmb_elec_cherry_player"), self, "J_Spine4", self);
    var_2 = maps\mp\agents\_agent_utility::_id_43FD("all");
    var_2 = common_scripts\utility::_id_40B0(self.origin, var_2, undefined, undefined, var_1);
    var_3 = common_scripts\utility::_id_40B0(self.origin, level.players, undefined, undefined, var_1);

    foreach(var_5 in var_2) {
      if(var_5 == self) {
        continue;
      }
      var_5 dodamage(var_0, var_5.origin, self, self, undefined, "electric_cherry_zm");
      playFX(common_scripts\utility::_id_44F5("zmb_elec_cherry_zombie"), var_5.origin + (0, 0, 40));
    }

    foreach(var_8 in var_3) {
      var_8 dodamage(var_0 / 5, self.origin, undefined, undefined, undefined, "electric_cherry_zm");
      playFX(common_scripts\utility::_id_44F5("zmb_elec_cherry_zombie"), var_8.origin + (0, 0, 40));
    }

    wait(self.elec_cherry_cooldown);
  }
}

wustling_revive_buff_handle(var_0, var_1) {
  thread wustling_revive_think();
  wustling_buff_manager_add(var_1);
}

wustling_revive_think() {
  self notify("activate_revive_buff");
  self endon("activate_revive_buff");

  if(!isDefined(level._id_6BD2) || isDefined(level._id_6BD2) && !common_scripts\utility::_id_0F79(level._id_6BD2, ::wustling_revive_listener))
    _id_054D::_id_7BC6(::wustling_revive_listener);

  common_scripts\utility::_id_A70A("death", "consume_revive_buff");
}

wustling_revive_listener(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(self.hc_escort_blitz_buffs) || !common_scripts\utility::_id_0F79(self.hc_escort_blitz_buffs, "quickrevive") || self.health - var_2 > 0) {
    return;
  }
  self notify("consume_revive_buff");
  wustling_buff_manager_remove("quickrevive");
  self._id_480F = 1;
  self._id_00CE = 1;
  self.health = self.maxhealth;

  if(!common_scripts\utility::_id_562E(self._id_561D))
    thread _id_0547::_id_7D1A("nuke_stun", [var_1.origin]);

  _killfxontag(common_scripts\utility::_id_44F5("zmi_hc_rune_green"), self, "J_SpineUpper");
  _playfxontag(common_scripts\utility::_id_44F5("zmi_hc_pest_anointed_green"), self, "J_SpineUpper");
  wait 4;
  _killfxontag(common_scripts\utility::_id_44F5("zmi_hc_pest_anointed_green"), self, "J_SpineUpper");
  self._id_480F = 0;
}

wustling_wander_wp_walkto(var_0) {
  wustling_disable_idle();

  if(_distance2d(level.hc_wustling.origin, var_0.origin) < 64) {
    self.wps_wander_sequence = common_scripts\utility::_id_0F93(level.hc_wustling.wps_wander_sequence, var_0);
    return;
  }

  level.hc_wustling._id_1928 = var_0;
}

pagan_room_do_wustling_rush() {
  var_0 = "top";
  var_1 = common_scripts\utility::_id_46B5("hc_wustling_boss_spawn", "targetname");
  var_2 = common_scripts\utility::_id_46B7("hc_wustling_buddy_spawn", "targetname");
  var_3 = ["wustling_hc_waypoint_shootspeed", "wustling_hc_waypoint_meleedamage", "wustling_hc_waypoint_runspeed", "wustling_hc_waypoint_revive"];
  var_4 = 0;
  var_5 = "zombie_heavy";
  _id_0547::_id_7BA9(::anointed_zombie_death_listener);

  if(level.players.size >= 1)
    var_2 = common_scripts\utility::_id_0F9A(var_2, var_2.size);

  if(level.players.size >= 2)
    var_2 = common_scripts\utility::_id_0F9A(var_2, var_2.size);

  var_6 = int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_escort_hc_follower_spawn_numbers"));
  var_7 = 0;
  var_8 = 0;

  while(var_8 < var_6) {
    if(var_7 >= var_2.size)
      var_7 = 0;

    var_2[var_7]._id_8C95 = 1;
    var_2[var_7].ignorehidingskyspawner = 1;
    var_9 = _id_054D::_id_90BA(var_5, var_2[var_7], "beach_rush_intro", 0, 1, 0);
    var_9 wustling_miniboss_setup();
    var_9 maps\mp\agents\_agent_common::_id_83FD(int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_escort_hc_follower_health_buddy")));
    var_9.pommel_room_boss = 1;
    var_10 = common_scripts\utility::random(var_3);
    var_3 = common_scripts\utility::_id_0F93(var_3, var_10);
    var_7++;
    var_8++;
    waitframe();
    var_9 wustling_get_buff(var_10);
    wait 0.75;
  }

  var_1._id_8C95 = 1;
  var_1.ignorehidingskyspawner = 1;
  var_11 = _id_054D::_id_90BA(var_5, var_1, "beach_rush_intro", 0, 1, 0);
  var_11.pommel_room_boss = 1;
  var_11 maps\mp\agents\_agent_common::_id_83FD(int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_escort_hc_follower_health_main")));
  var_11 wustling_miniboss_setup();
  var_11.is_anointed = 1;
  level.hc_wustling = var_11;
  waitframe();
  wustling_give_correct_buffs();
  common_scripts\utility::flag_set("anointed_zombies_done_spawning");
  wait_for_all_bosses_defeated();
  _id_054D::_id_2D8D(::wustling_revive_listener);
  _id_0547::_id_2D8C(::anointed_zombie_death_listener);
  common_scripts\utility::flag_set("zmb_hc_follower_destination");
  common_scripts\utility::_id_3C7B("flag_hc_escort_active");
}

wustling_miniboss_setup() {
  self.isobjectiveexemptfromfog = 1;
  self._id_6816 = 0;
  self._id_0C29 = 0;
  self._id_562B = 1;
  self._id_55AB = 1;
  self._id_297D = ::wustling_zombie_custom_movemode;
  maps\mp\agents\_agent_common::_id_83FD(maps\mp\zquests\casual\island_ee_util::get_health_of_zombies_at_round(level._id_A980, 2.5, "zombie_heavy"));
  self.hc_escort_blitz_buffs = [];
  self.hc_escort_blitz_buffs_attack_mod = 1;
  self.elec_cherry_cooldown = 12;
  _id_0547::disableoffhandsecondaryweapons();
  wustling_buff_manager_setup();
}

wustling_give_correct_buffs() {
  level notify("give_hc_wustling_full_buffs");
  level endon("give_hc_wustling_full_buffs");

  while(!isDefined(level.hc_wustling))
    waitframe();

  level.hc_wustling wustling_get_buff("wustling_hc_waypoint_shootspeed");
  level.hc_wustling wustling_get_buff("wustling_hc_waypoint_meleedamage");
  level.hc_wustling wustling_get_buff("wustling_hc_waypoint_runspeed");
  level.hc_wustling wustling_get_buff("wustling_hc_waypoint_revive");
}

wustling_enable_idle() {
  if(!common_scripts\utility::_id_562E(self.hc_forced_idle)) {
    wustling_hc_zombie_forceidle();
    self.hc_forced_idle = 1;
  }
}

wustling_disable_idle() {
  if(common_scripts\utility::_id_562E(self.hc_forced_idle)) {
    wustling_hc_zombie_awakenidle();
    self.hc_forced_idle = undefined;
  }
}

wustling_hc_zombie_forceidle(var_0) {
  self scragentsetscripted(1);
  self._id_00CA = 1;
  self.is_idling = 1;
  var_1 = "passive_idle_fol";
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_1, var_0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "hc_heavy_idle");
  self._id_509A = 1;
}

wustling_hc_zombie_awakenidle() {
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "hc_heavy_idle");
  self scragentsetscripted(0);
  self._id_509A = 0;
  self._id_00CA = 0;
  self.is_idling = 0;
}

assassin_escort_quest_main(var_0) {
  level.hc_assassin = var_0;
  level.hc_assassin assassin_hc_zombie_post_drop_setup();
  var_1 = common_scripts\utility::_id_46B5("hc_asn_first_exit", "targetname");
  level.hc_assassin._id_1928 = var_1;
  level.hc_assassin childthread maps\mp\zquests\casual\island_ee_util::waittill_at_waypoint(var_1, 96, 1);
  level.hc_assassin waittill("escort_goal_reached");

  if(isalive(level.hc_assassin)) {
    level.hc_assassin._id_1DEB = 1;
    level.hc_assassin suicide();
  }

  if(!(isDefined(level.current_fog_flag) && maps\mp\mp_zombie_island_ee_fog_manager::get_is_fog_active()))
    maps\mp\mp_zombie_island_ee_fog_manager::wait_till_fog_active();

  maps\mp\mp_zombie_island_fog_behavior::set_foggy_passive_behavior(0);
  level thread maps\mp\mp_zombie_island_ee_fog_manager::set_fog_locked_to_on();
  common_scripts\utility::_id_3C7B("flag_hc_asn_found_1");
  common_scripts\utility::_id_3C7B("flag_hc_asn_found_2");
  common_scripts\utility::_id_3C7B("flag_hc_asn_found_3");
  assassin_hc_hide_point_reset();

  foreach(var_3 in ["flag_hc_asn_found_1", "flag_hc_asn_found_2", "flag_hc_asn_found_3"]) {
    var_4 = assassin_hc_main_do_hide_and_seek(var_3);

    if(!common_scripts\utility::_id_562E(var_4)) {
      common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
      common_scripts\utility::_id_3C7B("flag_hc_escort_active");
      return;
    }
  }

  maps\mp\mp_zombie_island_fog_behavior::set_foggy_passive_behavior(1);
  maps\mp\mp_zombie_island_ee_fog_manager::unlock_fog_from_lock();
  maps\mp\mp_zombie_island_ee_fog_manager::toggle_next_fog_state();
  common_scripts\utility::_id_3C7B("flag_loader_zombie_unavailable");
  common_scripts\utility::flag_set("flag_hc_asn_escort_complete");
  run_assassin_escort_battle();
}

run_assassin_escort_battle() {
  maps\mp\_utility::_id_2CED(0.75, maps\mp\zquests\casual\island_ee_util::monk_head_dialogue, "zmb_isla_monk_nerthushaschosenafavoredo", 1);
  pomel_room_players_wait();
  maps\mp\zquests\casual\island_ee_util::clear_all_zombies();
  thread pomel_door_close();
  _id_0547::_id_AAFB("isolated_room_close_to_pool_trig");
  _id_0547::_id_7BA9(::anointed_zombie_death_listener);
  var_0 = common_scripts\utility::_id_46B5("zombie_hc_assassin_pagan_room_spawner", "targetname");
  var_1 = common_scripts\utility::_id_46B5("hc_assassin_cower_point", "targetname");
  var_2 = maps\mp\zombies\zombie_assassin_spawner_logic::spawn_an_assassin(undefined, undefined, var_0, 0, "Phase 2: IDLE TRANSITION", 1, 1, undefined, get_worship_alarm_rules(), undefined, ["isolated_room_zone"]);
  var_2._id_6816 = 0;
  var_2._id_480F = 1;
  var_2.additional_anim = [::walk_a_bit, "walk_2_crouch"];
  var_2.must_gib_head = 1;
  var_2 maps\mp\agents\_agent_common::_id_83FD(int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_escort_hc_assassin_health_main")));
  var_2.is_anointed = 1;
  var_2.skipped_straight_to_idle = 1;
  var_2.pommel_room_boss = 1;
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("tag_origin");
  var_3 linkto(var_2, "j_mainroot", (0, 0, 0), (0, 0, 0));
  var_2.anointed_fx_model = var_3;
  var_2.anointed_fx = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_dlc1_assn_hc_int"), var_3, "tag_origin");
  var_3 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_2);
  var_2.anointed_fx maps\mp\agents\_agent_utility::deleteentonagentdeath(var_2);
  _triggerfx(var_2.anointed_fx);
  common_scripts\utility::flag_set("anointed_zombies_done_spawning");
  wait_for_all_bosses_defeated();
  pomel_door_open();
  _id_0547::_id_2D8C(::anointed_zombie_death_listener);
  common_scripts\utility::flag_set("zmb_hc_assassin_destination");
  common_scripts\utility::_id_3C7B("flag_hc_escort_active");
}

walk_a_bit() {
  self endon("death");
  thread maps\mp\agents\_scripted_agent_anim_util::_id_71FA("walk_asn_slow", 0, 1.0, "stop_walk", "stop_now");
  wait 2.5;
  self._id_480F = 0;
}

assassin_hc_zombie_setup() {
  self.escort_zombie = 1;
  self.isobjectiveexemptfromfog = 1;
  self._id_6816 = 1;
  self._id_0C29 = 0;
  self._id_00CE = 1;
  _id_0547::_id_8A6D(1);
  self.shouldnotpreventlaststand = 1;
  self.ispassiveexempt = 1;
  self.failsafe_exempt = 1;
  self._id_55AB = 1;
  self._id_562B = 1;
  self.optionaldisablefogsensitivity = 1;
  self._id_6701 = 1;

  if(isDefined(level.last_hc_assassin_health))
    maps\mp\agents\_agent_common::_id_83FD(level.last_hc_assassin_health);
  else
    maps\mp\agents\_agent_common::_id_83FD(2000);

  maps\mp\agents\_agent_utility::hudoutlineenable(level._id_746E);
  self.custom_think_mode = ::assassin_hc_zombie_think;
  self._id_297D = ::assassin_hc_zombie_custom_move_mode;
  self.on_damage_override = ::assassin_hc_zombie_on_damage;
  self.assassin_modifier = "zombie_assassin_hc";
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("tag_origin");
  var_0 linkto(self, "j_mainroot", (0, 0, 0), (0, 0, 0));
  self.anointed_fx_model = var_0;
  self.anointed_fx = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_dlc1_assn_hc_int"), var_0, "tag_origin");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.anointed_fx);
  _triggerfx(self.anointed_fx);
  var_1 = spawnStruct();
  var_1._id_3F11 = [];
  self.aggrofuncsoverride = var_1;
  thread setup_escort_assassin_failsafe();
}

setup_escort_assassin_failsafe() {
  self endon("death");

  for(;;) {
    var_0 = level common_scripts\utility::_id_A74D("hc_assassin_found", 600);

    if(_id_0547::_id_5565(var_0, "timeout")) {
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
  self._id_00CF = 1;
  self.assassinmustleave = 1;
  self.assassinkillonexit = 1;
  self.looking_for_exit = 1;
  self._id_6701 = 0;
}

assassin_hc_zombie_spawn_at_nearest_point(var_0) {
  var_1 = var_0;
  var_2 = 0;
  var_3 = 1;

  foreach(var_5 in level.players) {
    var_6 = common_scripts\utility::within_fov(var_5 getEye(), var_5 _meth_8566(), var_0.origin + (0, 0, 32), _cos(32.5));
    var_7 = _bullettracepassed(var_5 getEye(), var_0.origin + (0, 0, 32), 0);

    if(var_6 || var_7) {
      var_2 = 1;
      break;
    }
  }

  if(var_2) {
    var_1 = maps\mp\zombies\zombie_assassin_spawner_logic::get_valid_assassin_spawner(var_0.origin);
    var_3 = 0;
  }

  var_9 = _id_054D::_id_90BA("zombie_assassin", var_1, "hc assassin spawn", 0, 1, 0);
  var_9 assassin_hc_zombie_setup();
  var_9._id_6701 = 0;
  var_9._id_00CE = 0;
  var_9 _id_0547::_id_8A6D(0);
  return [var_9, var_3];
}

assassin_hc_main_do_hide_and_seek(var_0) {
  _id_0547::register_allykilledfunc(::assassin_hc_zombie_death_listener);
  var_1 = undefined;

  for(;;) {
    thread assassin_hc_zombie_hide();
    var_1 = level common_scripts\utility::waittill_any_return("hc_assassin_killed", "hc_assassin_found", "hc_assassin_recycled");

    if(_id_0547::_id_5565(var_1, "hc_assassin_recycled"))
      continue;
    else
      break;
  }

  _id_0547::deregister_allykilledfunc(::assassin_hc_zombie_death_listener);

  if(_id_0547::_id_5565(var_1, "hc_assassin_found")) {
    common_scripts\utility::flag_set(var_0);
    level.hc_assassin assassin_hc_zombie_retreat_and_suicide(1);
    return 1;
  } else if(_id_0547::_id_5565(var_1, "hc_assassin_killed"))
    return 0;
}

assassin_hc_zombie_retreat_and_suicide(var_0) {
  if(common_scripts\utility::_id_562E(var_0))
    level.last_hc_assassin_health = self.health;
  else
    level.last_hc_assassin_health = undefined;

  self._id_00CE = 1;
  assassin_hc_zombie_clear_attract();
  self.readytosprint = 1;
  var_1 = "scripted_idle_to_vul";
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1);
  maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_2, 0, 0, undefined, 1, 0);
  self._id_1928 = maps\mp\zombies\zombie_assassin_spawner_logic::seek_exit_that_maintains_momentum(1);
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "hc_assassin_crouch");
  thread maps\mp\zquests\casual\island_ee_util::waittill_at_waypoint(self._id_1928, 96, 1);
  common_scripts\utility::waittill_notify_or_timeout("escort_goal_reached", 15);
  self._id_1DEB = 1;
  self suicide();
}

assassin_hc_zombie_clear_attract() {
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0) {
    if(_id_0547::_id_5565(var_2._id_3043, self))
      var_2._id_3043 = undefined;

    if(_id_0547::_id_5565(var_2._id_1927, self))
      var_2._id_1927 = undefined;
  }
}

assassin_hc_zombie_hide() {
  var_0 = assassin_hc_hide_point_select_optimal();
  [level.hc_assassin, var_2] = assassin_hc_zombie_spawn_at_nearest_point(var_0);
  level.hc_assassin endon("death");
  level endon("hc_assassin_killed");
  level.hc_assassin._id_1928 = var_0;

  if(!var_2) {
    level.hc_assassin childthread maps\mp\zquests\casual\island_ee_util::waittill_at_waypoint(var_0, 32, 1);
    level.hc_assassin waittill("escort_goal_reached");
    level.hc_assassin.skip_blendin = 0;
  } else
    level.hc_assassin.skip_blendin = 1;

  level.hc_assassin thread _id_0547::_id_7D1A("hc_assassin_crouch");
  level.hc_assassin childthread assassin_hc_zombie_cry();
  level.hc_assassin.squatting = 1;
  level.hc_assassin.is_hiding = 1;
  level common_scripts\utility::_id_A70A("hc_assassin_found");
  level.hc_assassin notify("hc_assassin_force_exit");
}

assassin_hc_zombie_cry() {
  self endon("death");
  self endon("hc_assassin_force_exit");
  var_0 = 500;
  var_1 = undefined;
  var_2 = 0;
  var_3 = 3;

  for(;;) {
    wait(_randomintrange(10, 20));

    if(isalive(self)) {
      _id_0378::_id_8D74("assassin_hc_cry");
      var_2++;

      if(var_2 < var_3) {
        continue;
      }
      var_4 = _id_0547::_id_408F();

      foreach(var_6 in var_4) {
        if(isDefined(var_1)) {
          if(distancesquared(self.origin, var_6.origin) > var_1)
            continue;
        }

        var_6 maps\mp\agents\humanoid\_humanoid_util::_id_867E(self);
        var_6._id_1927 = self;
      }
    }
  }
}

assassin_hc_zombie_think() {
  if(_id_053C::_id_4F9B()) {
    wait 0.2;
    return;
  }

  _id_053C::_id_0647();
  wait 0.2;
}

assassin_hc_zombie_custom_move_mode() {
  self._id_64C2 = 1.15 * _id_054D::_id_4440();
  self._id_672D = 1.15 * _id_054D::_id_4440();
  self._id_9D0D = 1.15;
  self._id_4013 = 1.15;
  return "sprint";
}

assassin_hc_zombie_death_listener(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(self, level.hc_assassin)) {
    if(common_scripts\utility::_id_562E(self._id_AC10))
      level notify("hc_assassin_recycled");
    else {
      level notify("hc_assassin_killed");
      maps\mp\mp_zombie_island_ee_fog_manager::unlock_fog_from_lock();
    }

    level.hc_assassin.is_hiding = 0;
    level.hc_assassin assassin_hc_zombie_clear_attract();
    level.hc_assassin = undefined;
  }
}

assassin_hc_zombie_on_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(self._id_0117)) {
    var_11 = isDefined(var_1) && self._id_0117 == var_1;
    var_12 = maps\mp\_utility::_id_118D(self._id_0117, var_1) || var_11;
  } else {
    var_11 = 0;
    var_12 = maps\mp\_utility::_id_118D(self, var_1);
  }

  if(var_12) {
    var_2 = 0;

    if(common_scripts\utility::_id_562E(self.is_hiding)) {
      self.found_by_players = 1;
      self.is_hiding = 0;
      level notify("hc_assassin_found");
    }
  } else {}

  if(isDefined(var_1) && _isagent(var_1)) {
    if(isDefined(var_1._id_0A4B)) {
      switch (var_1._id_0A4B) {
        case "zombie_generic":
          var_2 = var_2 * 0.35;
          break;
        case "zombie_berserker":
          var_2 = var_2 * 0.75;
          break;
        case "zombie_exploder":
          var_2 = var_2 * 0.9;
          break;
        case "zombie_heavy":
          var_2 = var_2 * 0.5;
          break;
        case "zombie_assassin":
          var_2 = var_2 * 0.9;
          break;
        default:
          var_2 = var_2 * 0.5;
          break;
      }
    }
  }

  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

assassin_hc_zombie_wake_players_are_too_close() {
  var_0 = undefined;

  while(!isDefined(var_0) || distance(self.origin, var_0.origin) > 128) {
    if(isDefined(level.players) && level.players.size > 0)
      var_0 = common_scripts\utility::_id_4461(self.origin, level.players);

    waitframe();
  }

  return "Assassin Alarmed! PLAYERS TOO CLOSE";
}

assassin_hc_hide_point_init() {
  var_0 = common_scripts\utility::_id_46B7("hc_asn_hide_pnt", "targetname");
  level.hc_asn_hide_pnts = spawnStruct();
  level.hc_asn_hide_pnts.seeded = 0;
  level.hc_asn_hide_pnts.pnts = [];

  foreach(var_2 in var_0) {
    var_2._id_AC8A = _id_055A::_id_4562(var_2.origin);
    var_2.selected_recently = 0;
  }

  level.hc_asn_hide_pnts.pnts = var_0;
  _id_0547::_id_7BD0("hc_assassin_crouch", ::assassin_hc_crouch_state, ::assassin_hc_crouch_state_interrupt, 4.75, ::assassin_hc_crouch_state_cleanup);
}

assassin_hc_hide_point_reset() {
  level.hc_asn_hide_pnts.seeded = 0;

  foreach(var_1 in level.hc_asn_hide_pnts.pnts)
  var_1.selected_recently = 0;
}

assassin_hc_crouch_state() {
  if(!common_scripts\utility::_id_562E(self.skip_blendin)) {
    var_0 = "walk_2_crouch";
    var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0);
    self scragentsetscripted(1);
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "hc_assassin_crouch");
    self scragentsetanimmode("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    self setOrigin(self._id_1928.origin);
    self.angles = self._id_1928.angles;

    if(isDefined(self._id_1928))
      maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self._id_1928.origin, self._id_1928.angles, var_1, 0, 0, undefined, 1, 0);
    else
      maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_1, 0, 0, undefined, 1, 0);
  }

  if(!common_scripts\utility::_id_562E(self.found_by_players)) {
    var_2 = "idle_stalk_player";
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_2);
    self setOrigin(self._id_1928.origin);
    self.angles = self._id_1928.angles;

    if(isDefined(self._id_1928))
      maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self._id_1928.origin, self._id_1928.angles, var_3, 0, 0, undefined, 1, 1, "hc_assassin_force_exit");
    else
      maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_3, 0, 0, undefined, 1, 1, "hc_assassin_force_exit");
  }

  assassin_hc_crouch_state_cleanup();
}

assassin_hc_crouch_state_interrupt() {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "hc_assassin_interrupt");
}

assassin_hc_crouch_state_cleanup() {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "hc_assassin_interrupt");
}

assassin_hc_hide_point_get_filtered_list() {
  var_0 = [];

  foreach(var_2 in level.hc_asn_hide_pnts.pnts) {
    if(!_id_055A::_id_586A(var_2._id_AC8A))
      continue;
    else
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

assassin_hc_hide_point_select_optimal() {
  var_0 = undefined;
  var_1 = _id_055A::_id_4482();
  var_2 = assassin_hc_hide_point_get_filtered_list();
  var_3 = [];

  foreach(var_5 in var_2) {
    if(common_scripts\utility::_id_0F79(var_1, var_5._id_AC8A)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_5.selected_recently)) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  if(var_3.size > 0) {
    if(var_3.size == 1)
      var_0 = var_3[0];
    else {
      var_7 = 1;

      if(common_scripts\utility::_id_562E(level.hc_asn_hide_pnts.seeded))
        var_7 = 2;
      else
        level.hc_asn_hide_pnts.seeded = 1;

      var_8 = maps\mp\_utility::getaverageorigin(level.players);
      var_9 = common_scripts\utility::_id_44D6(var_8, var_3);

      switch (var_7) {
        case 1:
          var_0 = common_scripts\utility::random(var_3);
          break;
        case 2:
          var_0 = var_9;
          break;
        case 3:
          var_10 = var_9._id_AC8A;
          var_11 = [];

          foreach(var_13 in var_3) {
            if(var_13._id_AC8A == var_10)
              var_11[var_11.size] = var_13;
          }

          var_0 = common_scripts\utility::random(var_11);
          break;
      }
    }
  }

  if(!isDefined(var_0))
    var_0 = common_scripts\utility::random(var_2);

  var_0.selected_recently = 1;
  return var_0;
}

fodder_escort_quest_main(var_0) {
  var_0 waittill("death");
}

handle_pomel_door_interact(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46B5("pomel_room_door_struct", "targetname");
  var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");
  var_2.door_pieces = [];
  var_4 = _getscriptablearray(var_2.target, "targetname");

  foreach(var_6 in var_3) {
    var_7 = var_6._id_0165;

    if(!isDefined(var_7)) {
      continue;
    }
    switch (var_7) {
      case "statue_piece_1":
        var_2.door_pieces["statue_piece_1"] = var_6;
        var_2.door_pieces["statue_piece_1"] thread show_statue_piece_after("players_placed_statue_piece_1");
        var_2.door_pieces["statue_piece_1"] hide();
        break;
      case "statue_piece_2":
        var_2.door_pieces["statue_piece_2"] = var_6;
        var_2.door_pieces["statue_piece_2"] thread show_statue_piece_after("players_placed_statue_piece_2");
        var_2.door_pieces["statue_piece_2"] hide();
        break;
      case "statue_piece_3":
        var_2.door_pieces["statue_piece_3"] = var_6;
        var_2.door_pieces["statue_piece_3"] thread show_statue_piece_after("players_placed_statue_piece_3");
        var_2.door_pieces["statue_piece_3"] hide();
        break;
      case "pomel_room_door_trigger":
        var_2.door_trigger = var_6;
        break;
      case "pomel_room_door_blocker":
        var_2.door_blocker = var_6;
        break;
      case "pomel_room_door_model":
        var_2._id_326B = var_6;
        break;
    }
  }

  var_9 = _getscriptablearray("zmi_pagan_room_door", "targetname");
  var_10 = var_9[0];
  var_2.door_scriptable = var_10;
  var_2 thread wait_for_door_opened(var_1);

  for(;;) {
    var_2.door_trigger waittill("trigger", var_11);

    if(var_11 getcurrentprimaryweapon() != "stone_baby_zm") {
      continue;
    }
    if(var_11 hasweapon("stone_baby_zm"))
      var_11 notify("baby_deposited");

    var_11 _id_0586::_id_078E(var_11 _id_0547::_id_AB2B());

    for(var_12 = 0; var_12 < var_0.size; var_12++) {
      if(common_scripts\utility::_id_3C77(var_0[var_12]) && !common_scripts\utility::_id_3C77(var_1[var_12])) {
        common_scripts\utility::flag_set(var_1[var_12]);
        var_2.door_pieces["statue_piece_" + (var_12 + 1)] show();
        break;
      }
    }
  }
}

show_statue_piece_after(var_0) {
  common_scripts\utility::_id_3C9F(var_0);
  self show();
  _id_0378::_id_8D74("pagen_door_place_stone");
  self moveto(common_scripts\utility::_id_46B5(self.target, "targetname").origin, 1);
  wait 1;
}

wait_for_door_opened(var_0) {
  foreach(var_2 in var_0)
  common_scripts\utility::_id_3C9F(var_2);

  common_scripts\utility::flag_set("pomel room opened");
  wait 2.5;
  thread pagan_room_open_zombie_cooldown();
  thread pagan_room_open_logic();

  foreach(var_5 in level.players)
  var_5 thread pagan_room_statue_lookat();

  wait 0.5;
  self.door_pieces["statue_piece_1"] linkto(self.door_scriptable, "TAG_ATTACH_1");
  self.door_pieces["statue_piece_2"] linkto(self.door_scriptable, "TAG_ATTACH_2");
  self.door_pieces["statue_piece_3"] linkto(self.door_scriptable, "TAG_ATTACH_3");
  self.door_blocker linkto(self.door_scriptable, "TAG_ANIMATE");
  pomel_door_open(1);
}

pagan_room_open_zombie_cooldown() {
  level thread maps\mp\gametypes\zombies::_id_08B2((0, 0, 0));
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  wait 15;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
}

pagan_room_statue_lookat() {
  level endon("statue_seen");
  level endon("statue_seen");
  var_0 = self;
  var_1 = _getent("vol_statue_lookat", "targetname");
  var_2 = common_scripts\utility::_id_46B5(var_1.target, "targetname");

  for(;;) {
    if(!var_0 istouching(var_1)) {
      waitframe();
      continue;
    }

    var_3 = var_2.origin;
    var_4 = self getEye();
    var_5 = vectorNormalize(var_3 - var_4);
    var_6 = vectorNormalize(anglesToForward(self _meth_8566()));
    var_7 = vectordot(var_5, var_6);
    waitframe();
    var_8 = _acos(clamp(var_7, -1, 1));

    if(var_8 < 25 && distance(var_3, var_4) < 420) {
      var_0 _id_0367::_id_8E3C("paganstatue", level.players);
      wait 3;
      level notify("statue_seen");
    }
  }
}

pomel_door_open(var_0) {
  level.disable_assassin_pushers = 0;
  var_1 = common_scripts\utility::_id_46B5("pomel_room_door_struct", "targetname");
  var_1.door_scriptable setscriptablepartstate("gate", "opening");
  common_scripts\utility::flag_set("isolated_entry_to_isolated");
  var_2 = _getent("pomel_room_door_instant_blocker", "script_noteworthy");

  if(isDefined(var_2))
    var_2 notsolid();

  var_2 connectpaths();
  var_1.door_blocker connectpaths();
  level thread common_scripts\_exploder::_id_088E(214);
  wait 5.0;

  if(common_scripts\utility::_id_562E(var_0)) {
    foreach(var_4 in level.players)
    var_4 _id_0367::_id_8E3C("paganassassin");
  }

  var_1.door_scriptable _id_0378::_id_8D74("pagen_door_opened");
  wait 1.53333;
  var_1.door_scriptable setscriptablepartstate("gate", "opened");
  level.zmb_locked_spawn_zones = undefined;
  wait 3;
}

pomel_room_players_wait() {
  var_0 = _getent("vol_isolated_room_player_check", "targetname");

  for(;;) {
    var_1 = 1;

    foreach(var_3 in level.players) {
      if(!var_3 istouching(var_0)) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      break;
    } else
      waitframe();
  }

  var_5 = _getent("pomel_room_door_instant_blocker", "script_noteworthy");

  if(isDefined(var_5))
    var_5 solid();
}

set_pommel_room_zombies_maxed() {
  level endon("pommel boss defeated");
  level.zmb_locked_spawn_zones = ["isolated_room_zone"];
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  common_scripts\utility::_id_3C9F("anointed_zombies_done_spawning");
  common_scripts\utility::_id_3C7B("anointed_zombies_done_spawning");
  wait(level.pommel_room_boss_peacetime);
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
  level.maxed_zombies_sprint = 1;
}

pomel_door_close() {
  level thread set_pommel_room_zombies_maxed();
  level.disable_assassin_pushers = 1;
  var_0 = common_scripts\utility::_id_46B5("pomel_room_door_struct", "targetname");
  var_1 = _getent("pomel_room_door_instant_blocker", "script_noteworthy");
  var_0.door_scriptable setscriptablepartstate("gate", "closing");
  var_0.door_scriptable _id_0378::_id_8D74("pagen_door_closing");
  var_0.door_blocker notsolid();
  common_scripts\utility::_id_3C7B("isolated_entry_to_isolated");
  wait 4.2;
  var_0.door_blocker disconnectpaths();
  var_1 disconnectpaths();
  wait 2.33333;
  var_0.door_scriptable setscriptablepartstate("gate", "closed");
  var_1 notsolid();
  var_0.door_blocker thread wait_to_turn_solid();
}

wait_to_turn_solid() {
  for(;;) {
    waitframe();

    foreach(var_1 in level.players) {
      if(_distance2d(var_1.origin, self.origin) < 70)
        continue;
    }

    break;
  }

  self solid();
}

stone_collect_1_think() {
  var_0 = _getent("trig_hc_stone_1", "targetname");
  var_1 = _getent("mdl_hc_mossy_boulder", "script_noteworthy");
  var_2 = common_scripts\utility::_id_46B5("struct_hc_stone_spawn", "script_noteworthy");
  var_3 = common_scripts\utility::_id_46B5("struct_hc_stone_land", "script_noteworthy");

  for(;;) {
    var_0 waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(_id_0547::_id_5565(var_13, "turretweapon_ger_btry_flak38_mp_zombie")) {
      break;
    }
  }

  common_scripts\utility::flag_set("players_spawned_statue_piece_1");
  playFX(common_scripts\utility::_id_44F5("zmb_flak_rock_explosion"), var_1.origin);
  var_1 delete();
  waitframe();
  var_14 = _func_1B6("zmi_stone_drop", var_2.origin, var_3.origin, 1.2, var_2.origin[2] + 50);
  var_14 waittill("explode", var_15);
  maps\mp\zombies\weapons\_zombie_stone_baby_weapon::spawn_a_stone_baby_pickup(var_3.origin, undefined, undefined, undefined, "players_spawned_statue_piece_1");
}

stone_collect_2_think() {
  var_0 = common_scripts\utility::_id_46B5("zombie_stone_waypoint_set1_1", "script_noteworthy") maps\mp\zquests\casual\island_ee_util::make_array_from_struct_chain();
  var_1 = common_scripts\utility::_id_46B5("zombie_stone_waypoint_set2_1", "script_noteworthy") maps\mp\zquests\casual\island_ee_util::make_array_from_struct_chain();
  var_2 = common_scripts\utility::_id_46B5("zombie_stone_waypoint_set3_1", "script_noteworthy") maps\mp\zquests\casual\island_ee_util::make_array_from_struct_chain();
  var_3 = common_scripts\utility::_id_46B5("zombie_stone_waypoint_set5_1", "script_noteworthy") maps\mp\zquests\casual\island_ee_util::make_array_from_struct_chain();

  while(!common_scripts\utility::_id_3C77("players_spawned_statue_piece_2")) {
    level waittill("freezer_zombie_placed", var_4);

    if(!_id_0547::_id_5565(var_4._id_0A4B, "zombie_generic")) {
      continue;
    }
    var_4 zombie_hc_zombie_post_drop_setup();
    var_4 stone_2_begin_escort(var_0, var_1, var_2, var_3);

    if(isDefined(var_4)) {
      var_4._id_1928 = undefined;
      var_4 stone_2_revert_to_enemy();
    }
  }
}

zombie_hc_zombie_setup() {
  var_0 = self;
  var_0.escort_zombie = 1;
  var_0.isobjectiveexemptfromfog = 1;
  var_0._id_6816 = 1;
  var_0._id_0C29 = 0;
  var_0.shouldnotpreventlaststand = 1;
  var_0.ispassiveexempt = 1;
  var_0._id_55AB = 1;
  var_0._id_562B = 1;
  var_0._id_297D = maps\mp\zquests\casual\island_ee_util::escort_custom_movemode;
  var_0 maps\mp\agents\_agent_common::_id_83FD(1000);
  var_0._id_6701 = 1;
  var_0.custom_think_mode = ::wustling_hc_think;
  var_0.escort_hit_track_time = 2;
  var_0.recently_hit_by_player = 0;
  var_0.recently_hit_player = undefined;
  var_0.health_at_spawn = var_0.health;
  var_0.action_param_override_func = ::zombie_hc_param_actions;
}

zombie_hc_zombie_post_drop_setup() {
  var_0 = self;
  var_0 maps\mp\agents\_agent_utility::hudoutlineenable(level._id_746E);
  return var_0;
}

zombie_hc_param_actions() {
  var_0 = _id_054D::_id_AC22();

  if(common_scripts\utility::_id_562E(self.is_scripted_monent)) {
    var_0["script_var"] = "scripted_stone_carry";
    var_0["move_style"] = "athletic";
    var_0["source_project"] = "t7";
  } else {}

  return var_0;
}

zombie_hc_zombie_forceidle() {
  self scragentsetscripted(1);
  self._id_00CA = 1;
  self.is_idling = 1;
  self._id_480F = 1;
  var_0 = "passive_idle";
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_0, 0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "passive_idle");
  self._id_509A = 1;
}

zombie_hc_zombie_awakenidle() {
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "passive_idle");
  self scragentsetscripted(0);
  self._id_509A = 0;
  self._id_00CA = 0;
  self.is_idling = 0;
}

stone_2_revert_to_enemy() {
  var_0 = self;

  if(!isDefined(var_0)) {
    return;
  }
  var_0.escort_zombie = undefined;
  var_0.isobjectiveexemptfromfog = 0;
  var_0 maps\mp\agents\_agent_utility::hudoutlineenable("axis");
}

stone_2_begin_escort(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4 endon("death");
  var_4 maps\mp\zquests\casual\island_ee_util::escort_waypoints_linear(var_0);
  var_4 maps\mp\zquests\casual\island_ee_util::escort_waypoints_linear(var_1);
  var_4 maps\mp\zquests\casual\island_ee_util::escort_waypoints_linear(var_2);
  var_4 zombie_hc_zombie_forceidle();
  var_4.is_scripted_monent = 1;
  var_5 = 12;
  wait(var_5);
  var_4 zombie_hc_zombie_awakenidle();
  var_4 thread stone_2_handle_baby_statue();
  var_4 maps\mp\zquests\casual\island_ee_util::escort_waypoints_linear(var_3, 1);
  var_4.is_scripted_monent = undefined;
  var_4 notify("drop_stone");
  waitframe();
  var_4 suicide();
}

stone_2_handle_baby_statue() {
  var_0 = self;
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("npc_zom_baby_statue_01");
  var_1.origin = var_0 gettagorigin("TAG_WEAPON_RIGHT");
  var_1.angles = var_0 gettagangles("TAG_WEAPON_RIGHT");
  var_1 linkto(var_0, "TAG_WEAPON_RIGHT");
  var_0 common_scripts\utility::_id_A70A("death", "drop_stone");
  var_0._id_480F = 0;
  var_1 unlink(var_0, "TAG_WEAPON_RIGHT");
  var_1 delete();
  var_0 stone_2_spawn_baby_statue();
}

stone_2_spawn_baby_statue() {
  if(isDefined(self.origin))
    var_0 = self.origin + (0, 0, 20);
  else
    var_0 = undefined;

  maps\mp\zombies\weapons\_zombie_stone_baby_weapon::spawn_a_stone_baby_pickup(var_0, undefined, undefined, undefined, "players_spawned_statue_piece_2");
  common_scripts\utility::flag_set("players_spawned_statue_piece_2");
}

stone_collect_3_think() {
  var_0 = stone_setup_roots_object();
  stone_choose_stone_root(var_0);

  foreach(var_2 in var_0)
  var_2 thread stone_roots_roots_think();

  common_scripts\utility::_id_3C9F("players_spawned_statue_piece_2");
}

stone_setup_roots_object() {
  var_0 = getEntArray("clip_hc_root_object", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");
    var_4 = common_scripts\utility::_id_46B7(var_2.target, "targetname");

    foreach(var_6 in var_3) {
      switch (var_6._id_0165) {
        case "mdl_roots_dead":
          var_2.model_dead = var_6;
          var_2.model_dead hide();
          break;
        case "mdl_roots_alive":
          var_2.model_alive = var_6;
          break;
        default:
          break;
      }
    }

    foreach(var_6 in var_4) {
      switch (var_6._id_0165) {
        case "struct_hc_statue_end_point":
          var_9 = bulletTrace(var_6.origin, var_6.origin - (0, 0, 1000), 0, undefined, 1, 0, 0, 1, 0, 0, 0);
          var_6.origin = var_9["position"];
          var_2.statue_end_loc = var_6;
          break;
        case "struct_hc_statue_start_point":
          var_2.statue_start_loc = var_6;
          break;
        case "struct_hc_root_vfx":
          var_2.vfx_struct = var_6;
          break;
        default:
          break;
      }
    }
  }

  return var_0;
}

stone_choose_stone_root(var_0) {
  var_1 = common_scripts\utility::random(var_0);
  var_1.hc_chosen_roots = 1;
}

stone_roots_roots_think() {
  self setcandamage(1);
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_10) && issubstr(var_10, "razer")) {
      break;
    }
  }

  if(isDefined(self.hc_chosen_roots) && self.hc_chosen_roots == 1)
    var_0 = 1;

  self notsolid();
  self.model_alive delete();
  playFX(common_scripts\utility::_id_44F5("zmb_root_dirt_impact_a"), self.vfx_struct.origin);
  self.model_dead show();

  if(!isDefined(var_0) || var_0 != 1) {
    return;
  }
  common_scripts\utility::flag_set("players_spawned_statue_piece_3");
  waitframe();
  var_11 = _func_1B6("zmi_stone_drop", self.statue_start_loc.origin, self.statue_end_loc.origin, 1.5, self.statue_start_loc.origin[2] + 100);
  playFX(common_scripts\utility::_id_44F5("zmb_geiskraft_spark_poof"), self.statue_start_loc.origin);
  var_11 waittill("explode", var_12);
  maps\mp\zombies\weapons\_zombie_stone_baby_weapon::spawn_a_stone_baby_pickup(self.statue_end_loc.origin, undefined, undefined, undefined, "players_spawned_statue_piece_3");
}

debug_arrow() {
  while(isDefined(self)) {
    common_scripts\utility::_id_339F(self.origin + (0, 0, 200), self.origin, (1, 0, 0));
    waitframe();
  }
}

pagan_room_open_logic() {
  var_0 = common_scripts\utility::_id_46B7("assassin_pommel_spawner", "targetname");
  var_1 = [];

  for(var_2 = 0; var_2 < 3; var_2++) {
    var_3 = spawnStruct();
    var_3.phase_flag = "Phase 2: IDLE";
    var_3.override_action = "assassin_worship_" + _randomintrange(1, 4);
    var_4 = get_worship_alarm_rules();
    var_5 = maps\mp\zombies\zombie_assassin_spawner_logic::spawn_an_assassin(undefined, undefined, var_0[var_2], 1, "Phase 2: IDLE", 1, 1, [var_3], var_4);
    var_5._id_9024 = "isolated_room_zone";
  }
}

get_worship_alarm_rules() {
  var_0 = spawnStruct();
  var_0._id_3F11 = [];
  var_0._id_3F11[var_0._id_3F11.size] = ::assassin_damaged_crouch;
  return var_0;
}

assassin_damaged_crouch() {
  wait 5;

  for(;;) {
    common_scripts\utility::_id_A70A("damage", "assassin_gunshot_wakup");

    if(common_scripts\utility::_id_562E(self.is_anointed)) {
      while(common_scripts\utility::_id_3C77("isolated_entry_to_isolated"))
        waitframe();
    } else
      common_scripts\utility::_id_3C9F("isolated_entry_to_isolated");

    if(!common_scripts\utility::_id_3794("Phase 2: IDLE TRANSITION")) {
      break;
    }
  }
}

_id_ABB1(var_0) {
  self scragentsetscripted(1);
  self._id_57C0 = 1;
  self._id_00CA = 1;

  if(!_id_0547::_id_5565(self._id_0A4B, "zombie_assassin"))
    maps\mp\agents\_scripted_agent_anim_util::isenemyaware("passive_idle", var_0);
  else
    self.skipsquatsearch = 1;

  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "training");
  self._id_509A = 1;
}

_id_AB50() {
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "training");
  self scragentsetscripted(0);
  self._id_57C0 = 0;
  self._id_509A = 0;
  self._id_00CA = 0;
}

play_custom_dropdown() {
  _iprintln("dropping down");
  thread dropdown_intro_center();
  thread dropdown_intro_left();
  thread dropdown_intro_right();
}

dropdown_intro_center() {
  var_0 = common_scripts\utility::_id_46B5("zombie_intro_dropdown_center", "targetname");
  var_1 = _id_054D::_id_90BA("zombie_generic", var_0, "beach_rush_intro", 0, 0, 0);
}

dropdown_intro_left() {
  var_0 = common_scripts\utility::_id_46B5("zombie_intro_dropdown_left", "targetname");
  var_1 = _id_054D::_id_90BA("zombie_generic", var_0, "beach_rush_intro", 0, 0, 0);
}

dropdown_intro_right() {
  var_0 = common_scripts\utility::_id_46B5("zombie_intro_dropdown_right", "targetname");
  var_1 = _id_054D::_id_90BA("zombie_generic", var_0, "beach_rush_intro", 0, 0, 0);
}

_id_ABAD(var_0) {
  self scragentsetscripted(1);
  self._id_57C0 = 1;
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware("passive_idle", var_0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "training");
}

assassinwasdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(self._id_0A4B == "zombie_assassin") {
    if(isDefined(var_1)) {
      if(isPlayer(var_1)) {
        if(var_2 >= 1)
          level notify("pommel_room_assassins_activated");
      }
    }
  }
}

head_hooks_setup() {
  var_0 = _getent("hc_head_handler", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = common_scripts\utility::_id_46B7(var_0.target, "targetname");

  foreach(var_4 in var_1) {
    switch (var_4._id_0165) {
      case "pest_head":
        var_0.pest_head = var_4;
        var_0.pest_head hide();
        var_0.pest_head.exploder_num = 223;
        break;
      case "trig_pest_head_place":
        var_0.pest_trig = var_4;
        break;
      case "follower_head":
        var_0.follower_head = var_4;
        var_0.follower_head hide();
        var_0.follower_head.exploder_num = 225;
        break;
      case "trig_follower_head_place":
        var_0.follower_trig = var_4;
        break;
      case "assassin_head":
        var_0.assassin_head = var_4;
        var_0.assassin_head hide();
        var_0.assassin_head.exploder_num = 226;
        break;
      case "trig_assassin_head_place":
        var_0.assassin_trig = var_4;
        break;
      case "monk_pommel_room_head":
        var_0.monk_head = var_4;
        var_0.monk_head hide();
        var_0.monk_head.exploder_num = 224;
        break;
      case "trig_monk_head_place":
        var_0.monk_trig = var_4;
        break;
      default:
        break;
    }
  }

  var_0.pest_trig thread head_hooks_attach_head(var_0.pest_head, "flag_anointed_pest_head_get", "flag_anointed_pest_head_placed");
  var_0.follower_trig thread head_hooks_attach_head(var_0.follower_head, "flag_anointed_fol_head_get", "flag_anointed_fol_head_placed");
  var_0.assassin_trig thread head_hooks_attach_head(var_0.assassin_head, "flag_anointed_asn_head_get", "flag_anointed_asn_head_placed");
  var_0.monk_trig thread head_hooks_attach_head(var_0.monk_head, "flag_monk_head_retrieved", "flag_anointed_monk_head_placed");
  common_scripts\utility::_id_3CA0("flag_anointed_pest_head_get", "flag_anointed_fol_head_get", "flag_anointed_asn_head_get");
  maps\mp\_utility::_id_2CED(1.25, ::monk_head_final_fight_dialogue);
  common_scripts\utility::_id_3C9F("flag_monk_head_retrieved");
  common_scripts\utility::_id_3CA0("flag_anointed_pest_head_get", "flag_anointed_fol_head_get", "flag_anointed_asn_head_get", "flag_anointed_monk_head_placed");
  common_scripts\utility::flag_set("flag_heads_complete");
}

monk_head_final_fight_dialogue() {
  maps\mp\zquests\casual\island_ee_util::monk_head_dialogue("zmb_isla_monk_bringmetonerthustowitness", 1);
  wait 0.75;
  maps\mp\zquests\casual\island_ee_util::monk_head_dialogue("themoonhasrisenontheblack");
}

head_spawn_type(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  switch (var_0) {
    case "zombie_berserker":
      var_3 = &"zombie_island_pick_head_pest";
      var_4 = "flag_anointed_pest_head_drop";
      var_5 = "flag_anointed_pest_head_get";
      var_6 = "zom_ger_head_spr_01_gib";
      break;
    case "zombie_heavy":
      var_3 = &"zombie_island_pick_head_follower";
      var_4 = "flag_anointed_fol_head_drop";
      var_5 = "flag_anointed_fol_head_get";
      var_6 = "zmi_follower_severed_head_gp";
      break;
    case "zombie_assassin":
      var_3 = &"zombie_island_pick_head_assassin";
      var_4 = "flag_anointed_asn_head_drop";
      var_5 = "flag_anointed_asn_head_get";
      var_6 = "zmi_assassin_ee_head_01";
      break;
    default:
      break;
  }

  common_scripts\utility::flag_set(var_4);
  var_7 = spawn("script_model", var_1 + (0, 0, 20));
  var_7.angles = var_2;
  var_7 setModel(var_6);
  _playfxontag(common_scripts\utility::_id_44F5("zmb_isl_med_trap_gib_rnr"), var_7, "tag_origin");
  var_7 _id_0547::_id_AC41(var_3, (0, 0, 20));
  var_7 waittill("player_used", var_8);
  var_7 _id_0547::_id_AC40();
  var_7 delete();
  common_scripts\utility::flag_set(var_5);
}

head_hooks_spawn_temp_heads() {
  thread head_spawn_type("zombie_berserker", common_scripts\utility::_id_46B5("struct_pest_head_temp_spot", "script_noteworthy").origin);
  thread head_spawn_type("zombie_heavy", common_scripts\utility::_id_46B5("struct_follower_head_temp_spot", "script_noteworthy").origin);
  thread head_spawn_type("zombie_assassin", common_scripts\utility::_id_46B5("struct_assassin_head_temp_spot", "script_noteworthy").origin);
}

head_hooks_attach_head(var_0, var_1, var_2) {
  while(!common_scripts\utility::_id_3C77(var_2)) {
    self waittill("trigger", var_3);

    if(!common_scripts\utility::_id_3C77(var_1)) {
      waitframe();
      continue;
    }

    var_0 show();
    level childthread common_scripts\_exploder::_id_088E(var_0.exploder_num);
    thread head_hooks_attach_head_quake(var_3, var_0.origin);
    _id_0378::_id_8D74("pagan_head_place", var_0, var_2);
    common_scripts\utility::flag_set(var_2);
    self delete();
  }
}

head_hooks_attach_head_quake(var_0, var_1) {
  var_2 = _randomfloatrange(3, 6);
  var_3 = _randomfloatrange(4, 8);
  _id_0378::_id_8D74("pommel_earthquake", "rumble", var_2, var_1);
  wait(var_2);
  _id_0378::_id_8D74("pommel_earthquake", "earthquake", var_3, var_1);
  var_4 = var_0;

  if(isDefined(var_4))
    level thread _id_3254(var_3, var_4);

  wait(var_3);
}

_id_3254(var_0, var_1) {
  _earthquake(0.3, var_0, var_1.origin, 850, var_1);
  _playrumblelooponposition("tank_rumble", var_1.origin);
  wait(var_0);
  _stopallrumbles();
}

head_retrieve_monk_head_from_freezer() {
  common_scripts\utility::_id_3CA0("flag_anointed_pest_head_get", "flag_anointed_fol_head_get", "flag_anointed_asn_head_get");
  self.controller_trig waittill("trigger", var_0);
  common_scripts\utility::flag_set("flag_monk_head_retrieved");
  self.issighted setscriptablepartstate("light", "red");
  self._id_00B9 hide();
}

______________pommel_____________() {}

raise_water_objective(var_0) {
  common_scripts\utility::flag_init(self.getnegotiationnextnode);
  self.my_dest = _getent(self.target, "targetname");

  if(!isDefined(self.my_dest)) {
    return;
  }
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  thread _id_8C16(var_1);
  var_1.disable_end_sound = 1;
  var_1 maps\mp\mp_zombies_soul_collection::_id_170B(int(maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_pommel_room_sacrifice_requirements")), var_0.radius, 64, self.getnegotiationnextnode, undefined, "tag_origin", undefined, "tag_origin", undefined, self, (0, 0, 64), undefined, 1, 1);
  common_scripts\utility::flag_set("water_has_been_raised");
}

_id_8C16(var_0) {
  self endon("water_raised");

  while(!isDefined(var_0._id_695B))
    waitframe();

  self._id_6C4E = self.origin;

  for(;;) {
    level waittill(var_0._id_695B);
    level notify("water_raised", var_0._id_AC2C);
    self moveto(_vectorlerp(self._id_6C4E, self.my_dest.origin, var_0._id_AC2C / var_0._id_AC2D), 1);

    if(var_0._id_AC2C >= var_0._id_AC2D)
      level notify("water_raised");
  }
}

pagan_room_waterfall_vfx() {
  var_0 = _getent("vol_pagan_room_waterfall", "targetname");

  for(;;) {
    var_1 = _id_0547::_id_4090("zombie_generic");

    foreach(var_3 in var_1) {
      if(var_3 istouching(var_0))
        _playfxontag(common_scripts\utility::_id_44F5("zmb_isl_pomel_body_splashes"), var_3, "j_head");
    }

    wait 0.1;
  }
}

monk_head_found_xp_reward() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("monkhead");
    var_1 _id_0378::_id_8D74("objective_complete", "monkhead");
  }
}

stone_baby_xp_reward() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("stonebaby");
    var_1 _id_0378::_id_8D74("objective_complete", "stonebaby");
  }
}

pagan_pool_xp_reward() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("paganpool");
    var_1 _id_0378::_id_8D74("objective_complete", "paganpool");
  }
}

zombie_heads_xp_reward() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("zombieheads");
    var_1 _id_0378::_id_8D74("objective_complete", "zombieheads");
  }
}

pagan_pool_boss_xp_reward() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("paganbpoolboss");
    var_1 _id_0378::_id_8D74("objective_complete", "paganbpoolboss");
  }
}

i_beam() {
  var_0 = _getent("hibeam", "targetname");
  var_0._id_6C48 = var_0.angles;
  var_0 setcandamage(1);
  var_1 = 0;
  var_2 = 7;

  while(!common_scripts\utility::_id_3C77("ibeam_complete")) {
    var_0 waittill("damage");
    var_1++;
    var_0 rotateto(_combineangles(var_0._id_6C48, (0, 0, var_1 * 11.25)), 0.15);
    var_0 _id_0378::_id_8D74("aud_ibeam_squeak");
    wait 0.15;

    if(var_1 > var_2)
      common_scripts\utility::flag_set("ibeam_complete");
  }

  var_0 _id_0378::_id_8D74("aud_ibeam_complete");

  foreach(var_4 in level.players)
  var_4 maps\mp\gametypes\zombies::_id_4798(1);
}

ee_rollers() {
  level.ee_rollers = spawnStruct();
  level.ee_rollers.sets = getEntArray("ee_roller_sets", "script_noteworthy");
  level.ee_rollers.sets = common_scripts\utility::array_randomize(level.ee_rollers.sets);
  level.ee_rollers.n1 = _randomintrange(-5, 15);
  level.ee_rollers.n2 = 5 * randomint(11);

  if(common_scripts\utility::_id_24A6())
    level.ee_rollers.n2 = level.ee_rollers.n2 * -1;

  for(var_0 = 0; var_0 < 6; var_0++) {
    level.ee_rollers.sets[var_0].roller_elems = getEntArray(level.ee_rollers.sets[var_0].target, "targetname");

    foreach(var_2 in level.ee_rollers.sets[var_0].roller_elems) {
      var_2._id_6C48 = var_2.angles;

      if(var_0 + 1 != _id_0547::_id_9470(var_2.setlookatent)) {
        var_2 delete();
        continue;
      }

      switch (_id_0547::_id_9470(var_2.setlookatent)) {
        case 1:
          level.ee_rollers.slot1 = var_2;
          var_3 = 9;

          if(level.ee_rollers.n1 >= 0)
            var_3 = 0;

          level.ee_rollers.slot1 maps\mp\zquests\casual\island_ee_util::display_set_digit(var_3);
          break;
        case 2:
          var_3 = int(level.ee_rollers.n1 / 10);
          level.ee_rollers.slot2 = var_2;
          level.ee_rollers.slot2 maps\mp\zquests\casual\island_ee_util::display_set_digit(var_3);
          break;
        case 3:
          var_3 = level.ee_rollers.n1 % 10;
          level.ee_rollers.slot3 = var_2;
          level.ee_rollers.slot3 maps\mp\zquests\casual\island_ee_util::display_set_digit(var_3);
          break;
        case 4:
          level.ee_rollers.slot4 = var_2;
          var_3 = 9;

          if(level.ee_rollers.n2 >= 0)
            var_3 = 0;

          level.ee_rollers.slot4 maps\mp\zquests\casual\island_ee_util::display_set_digit(var_3);
          break;
        case 5:
          var_3 = int(level.ee_rollers.n2 / 10);
          level.ee_rollers.slot5 = var_2;
          level.ee_rollers.slot5 maps\mp\zquests\casual\island_ee_util::display_set_digit(var_3);
          break;
        case 6:
          var_3 = level.ee_rollers.n2 % 10;
          level.ee_rollers.slot6 = var_2;
          level.ee_rollers.slot6 maps\mp\zquests\casual\island_ee_util::display_set_digit(var_3);
          break;
        default:
          break;
      }
    }
  }

  level.ee_rollers.elek = _getent("ee_roller_elek", "script_noteworthy");
  level.ee_rollers.elek hide();
  level.ee_rollers.elek.dest = common_scripts\utility::_id_46B5(level.ee_rollers.elek.target, "targetname");
  level.ee_rollers.elek._id_9D5E = _getent(level.ee_rollers.elek.target, "targetname");
  level.ee_rollers.elek._id_9D5E makeunusable();
  level.ee_rollers waittill("code_accepted");
  level.ee_rollers.elek show();
  level.ee_rollers.elek moveto(level.ee_rollers.elek.dest.origin, 0.7);
  wait 0.9;
  level.ee_rollers.elek _id_0378::_id_8D74("aud_ibeam_complete");
  level.ee_rollers.elek._id_9D5E makeusable();
  level.ee_rollers.elek._id_9D5E waittill("trigger");
  level.ee_rollers.elek delete();
  level.ee_rollers.elek._id_9D5E delete();
  common_scripts\utility::flag_set("ripsaw_punch_active");
}

ee_rollers_check(var_0, var_1) {
  if(var_0 != level.ee_rollers.n1 || var_1 != level.ee_rollers.n2) {
    return;
  }
  level.ee_rollers notify("code_accepted");
}

ee_stuka_rpg() {
  level thread maps\mp\_utility::_id_6F74(::player_fliegerfaust_test);
}

player_fliegerfaust_test() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("missile_fire", var_1, var_2);

    if(var_2 != "fliegerfaust_zm") {
      continue;
    }
    var_3 = var_1 rpg_fliegerfaust_test(var_0);

    if(common_scripts\utility::_id_562E(var_3))
      var_0 notify("assassin_blood_1_complete");
  }
}

rpg_fliegerfaust_test(var_0) {
  var_0 endon("disconnect");
  var_1 = self;
  var_2 = 160000;
  var_3 = 0;
  var_4 = 0;
  var_5 = var_1.origin;

  while(isDefined(var_1)) {
    foreach(var_7 in level.active_planes) {
      if(!isDefined(var_7)) {
        continue;
      }
      var_8 = distancesquared(var_1.origin, var_7.origin);
      var_4 = distancesquared(var_1.origin, var_5) / var_2;

      if(var_4 > 1)
        var_4 = 1;

      var_3 = var_2 * var_4;

      if(isDefined(var_7) && isDefined(var_1) && var_3 > var_8) {
        var_1 _meth_8561("fliegerfaust_zm", var_0);
        var_7 dodamage(1000, var_0.origin, var_0, var_0, "MOD_EXPLOSIVE", "fliegerfaust_zm");
        return 1;
      }
    }

    wait 0.25;
  }

  return 0;
}