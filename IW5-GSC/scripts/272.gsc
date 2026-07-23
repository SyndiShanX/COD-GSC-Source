/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\272.gsc
**************************************/

init_loadout() {
  if(!isDefined(level.dodgeloadout)) {
    give_loadout();
  }
  level.loadoutcomplete = 1;
  level notify("loadout complete");
}

setdefaultactionslot() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "altMode");
  self setactionslot(4, "");
}

init_player() {
  setdefaultactionslot();
  self takeallweapons();
}

char_switcher() {
  level.coop_player1 = level.player;
  level.coop_player2 = level.player2;

  if(isDefined(level.character_switched) && level.character_switched) {
    if(maps\_utility::is_coop()) {
      foreach(var_1 in level.players) {}
      var_1 init_player();

      level.coop_player1 = level.player2;
      level.coop_player2 = level.player;
      level.character_switched = 1;
      return 1;
    } else {
      level.player init_player();
      level.coop_player1 = undefined;
      level.coop_player2 = level.player;
      level.character_switched = 1;
      return 1;
    }
  }

  return 0;
}

get_loadout() {
  if(isDefined(level.loadout)) {
    return level.loadout;
  }
  return level.script;
}

give_loadout(var_0) {
  var_1 = get_loadout();

  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  level.character_selected = var_0;
  var_2 = [];
  level.player setdefaultactionslot();

  if(maps\_utility::is_coop()) {
    level.player2 setdefaultactionslot();
  }
  if(!isDefined(game["expectedlevel"])) {
    game["expectedlevel"] = "";
  }
  if(!isDefined(level.campaign)) {
    level.campaign = "american";
  }
  if(common_scripts\utility::string_starts_with(level.script, "pmc_")) {
    level.player setviewmodel("viewmodel_base_viewhands");

    if(maps\_utility::is_coop()) {
      precachemodel("weapon_parabolic_knife");
      level.player maps\_utility::setmodelfunc(::so_body_player_ranger);
      level.player2 maps\_utility::setmodelfunc(::so_body_player_ranger);
      level.player2 setviewmodel("viewmodel_base_viewhands");
    }

    level.campaign = "american";
    return;
  }

  if(maps\_utility::is_specialop()) {
    give_loadout_specialops(var_0);
    return;
  }

  if(level.script == "background") {
    level.player takeallweapons();
    return;
  }

  if(level.script == "iw4_credits") {
    level.player takeallweapons();
    return;
  }

  if(var_1 == "london") {
    level.player giveweapon("mp5_silencer_eotech");
    level.player giveweapon("usp_silencer");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("mp5_silencer_eotech");
    level.player setviewmodel("viewhands_sas");
    level.campaign = "british";
    return;
  } else if(var_1 == "innocent") {
    level.player setviewmodel("viewhands_sas");
    level.campaign = "british";

    if(!isDefined(game["previous_map"])) {
      level.player giveweapon("mp5_silencer_eotech");
      level.player giveweapon("usp_silencer");
      level.player giveweapon("fraggrenade");
      level.player giveweapon("flash_grenade");
      level.player setoffhandsecondaryclass("flash");
      level.player switchtoweapon("mp5_silencer_eotech");
    } else {
      level.player setoffhandsecondaryclass("flash");
      restoreplayerweaponstatepersistent("london", 1);
    }

    return;
  } else if(var_1 == "hamburg") {
    level.player giveweapon("m4m203_acog_payback");
    level.player giveweapon("smaw_nolock");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("m4m203_acog_payback");
    level.player setviewmodel("viewhands_delta");
    level.campaign = "delta";
    return;
  } else if(var_1 == "prague") {
    level.default_weapon = "rsass_hybrid_silenced";
    level.player giveweapon(level.default_weapon);
    level.player giveweapon("usp_silencer");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level.default_weapon);
    level.player setviewmodel("viewhands_yuri_europe");
    level.campaign = "delta";
    return;
  } else if(var_1 == "warlord") {
    level.player giveweapon("m14ebr_scoped_silenced_warlord");
    level.player giveweapon("ak47_silencer_reflex");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("m14ebr_scoped_silenced_warlord");
    level.player setviewmodel("viewhands_yuri");
    level.campaign = "american";
    return;
  } else if(var_1 == "castle") {
    level.castle_main_weapon = "mp5_silencer_reflex_castle";
    level.castle_side_weapon = "p99_tactical_silencer";
    level.player giveweapon(level.castle_main_weapon);
    level.player giveweapon(level.castle_side_weapon);
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level.castle_main_weapon);
    level.player setviewmodel("viewhands_yuri_europe");
    level.campaign = "american";
    return;
  } else if(var_1 == "berlin") {
    level.player giveweapon("m14ebr_scope");
    level.player giveweapon("acr_hybrid_berlin");
    level.player giveweapon("fraggrenade");
    level.player setoffhandsecondaryclass("flash");
    level.player giveweapon("ninebang_grenade");
    level.player switchtoweapon("acr_hybrid_berlin");
    level.player setviewmodel("viewhands_delta");
    level.campaign = "delta";
    return;
  } else if(var_1 == "paris_a") {
    level.player giveweapon("scar_h_acog");
    level.player giveweapon("usp_no_knife");
    level.player giveweapon("fraggrenade");
    level.player setoffhandsecondaryclass("flash");
    level.player giveweapon("ninebang_grenade");
    level.player switchtoweapon("scar_h_acog");
    level.player setviewmodel("viewhands_delta");
    level.campaign = "delta";
    return;
  } else if(var_1 == "paris_b") {
    level.player giveweapon("scar_h_acog");
    level.player giveweapon("usp_no_knife");
    level.player giveweapon("fraggrenade");
    level.player setoffhandsecondaryclass("flash");
    level.player giveweapon("ninebang_grenade");
    level.player switchtoweapon("scar_h_acog");
    level.player setviewmodel("viewhands_delta");
    level.campaign = "delta";
    return;
  } else if(var_1 == "paris_ac130") {
    level.player setviewmodel("viewhands_delta");
    level.player giveweapon("m4m203_reflex");
    level.player givemaxammo("m4m203_reflex");
    level.player setoffhandprimaryclass("frag");
    level.player giveweapon("fraggrenade");
    level.player setoffhandsecondaryclass("flash");
    level.player giveweapon("flash_grenade");
    level.player switchtoweapon("m4m203_reflex");
    level.campaign = "delta";
    return;
  } else if(var_1 == "ny_manhattan") {
    level.player giveweapon("m4_hybrid_grunt_optim");
    level.player giveweapon("xm25");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("m4_hybrid_grunt_optim");
    level.player setviewmodel("viewhands_delta_shg");
    level.campaign = "delta";
    return;
  } else if(var_1 == "ny_harbor") {
    level.player giveweapon("mp5_silencer_reflex");
    level.player givemaxammo("mp5_silencer_reflex");
    level.player giveweapon("usp_no_knife");
    level.player givemaxammo("usp_no_knife");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("ninebang_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("mp5_silencer_reflex");
    level.player setviewmodel("viewhands_udt");
    level.campaign = "delta";
    return;
  } else if(var_1 == "dubai") {
    level.dubai_main_weapon = "pecheneg_fastreload";
    level.player giveweapon(level.dubai_main_weapon);
    level.player givemaxammo(level.dubai_main_weapon);
    level.player giveweapon("m4m203_acog");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level.dubai_main_weapon);
    level.player setviewmodel("viewhands_juggernaut_ally");
    level.campaign = "american";
    return;
  } else if(var_1 == "payback") {
    level.player giveweapon("m4m203_acog_payback");
    level.player giveweapon("deserteagle");
    level.player giveweapon("fraggrenade");
    level.player setoffhandsecondaryclass("flash");
    level.player giveweapon("flash_grenade");
    level.player switchtoweapon("m4m203_acog_payback");
    level.player setviewmodel("viewhands_yuri");
    level.campaign = "delta";
    return;
  } else if(var_1 == "hijack") {
    level.player giveweapon("fnfiveseven");
    level.player switchtoweapon("fnfiveseven");
    level.player setviewmodel("viewhands_fso");
    level.campaign = "american";
    return;
  } else if(var_1 == "prague_escape") {
    level.player giveweapon("deserteagle");
    level.player giveweapon("m4m203_reflex");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("m4m203_reflex");
    level.player setviewmodel("viewhands_yuri_europe");
    level.campaign = "delta";
    return;
  } else if(var_1 == "intro") {
    level.player giveweapon("ak47_reflex");
    level.player givemaxammo("ak47_reflex");
    level.player giveweapon("deserteagle");
    level.player givemaxammo("deserteagle");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandprimaryclass("frag");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("ak47_reflex");
    level.player setviewmodel("viewhands_yuri");
    level.campaign = "american";
    return;
  } else if(var_1 == "rescue") {
    level.default_weapon = "acr_hybrid_silenced";
    level.player giveweapon(level.default_weapon);
    level.player givemaxammo(level.default_weapon);
    level.player giveweapon("usp");
    level.player givemaxammo("usp");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandprimaryclass("frag");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level.default_weapon);
    level.player setviewmodel("viewmodel_base_viewhands");
    level.campaign = "american";
    return;
  } else if(var_1 == "rescue_2") {
    level.default_weapon = "g36c_reflex";
    level.player giveweapon(level.default_weapon);
    level.player givemaxammo(level.default_weapon);
    level.player giveweapon("m4_grunt_acog");
    level.player givemaxammo("m4_grunt_acog");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandprimaryclass("frag");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level.default_weapon);
    level.player setviewmodel("viewhands_yuri_europe");
    level.campaign = "american";
    return;
  } else if(var_1 == "innocent") {
    level.campaign = "british";
    return;
  }

  if(issubstr(var_1, "firingrange")) {
    return;
  }
  level.testmap = 1;
  give_default_loadout();
}

give_loadout_specialops(var_0) {
  var_1 = get_loadout();

  if(var_1 == "so_nyse_ny_manhattan") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "m4_hybrid_grunt_optim";
      var_5 = "xm25";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_stealth_warlord") {
    level.so_campaign = "delta";
    level.coop_incap_weapon = level.so_warlord_secondary;

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      so_player_giveweapon(level.so_warlord_primary);
      so_player_giveweapon(level.so_warlord_secondary);
      so_player_set_switchtoweapon(level.so_warlord_primary);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_littlebird_payback") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      so_player_giveweapon(level.so_payback_primary);
      so_player_giveweapon(level.so_payback_secondary);
      so_player_set_switchtoweapon(level.so_payback_primary);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_ied_berlin") {
    level.so_campaign = "delta";

    if(maps\_utility::is_coop()) {
      if(getDvar("coop_start") == "so_char_host") {
        var_9 = 0;
        var_10 = 1;
      } else {
        var_9 = 1;
        var_10 = 0;
      }
    } else {
      var_9 = 0;
      var_10 = 1;
    }

    so_player_num(var_9);
    so_player_giveweapon("fraggrenade");
    so_player_giveweapon("flash_grenade");
    so_player_set_setoffhandsecondaryclass("flash");
    so_player_giveweapon("sa80lmg_fastreload_reflex");
    so_player_giveweapon("m320");
    so_player_set_switchtoweapon("sa80lmg_fastreload_reflex");
    so_player_setup_body(var_9);
    so_player_num(var_10);
    so_player_giveweapon("fraggrenade");
    so_player_giveweapon("semtex_grenade");
    so_player_set_setoffhandsecondaryclass("semtex_grenade");
    so_player_giveweapon("barrett");
    so_player_giveweapon("scar_h_thermal_silencer");
    so_player_set_switchtoweapon("barrett");
    so_player_setup_body(var_10);
    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_assault_rescue_2") {
    var_11 = "m4_grunt_acog";
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      so_player_giveweapon(var_11);
      so_player_set_maxammo(var_11);
      so_player_giveweapon("g36c_reflex");
      so_player_set_maxammo("g36c_reflex");
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_setup_body(var_6);
      so_player_set_switchtoweapon(var_11);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_heliswitch_berlin") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      so_player_giveweapon(level.primary_weapon);
      so_player_giveweapon(level.secondary_weapon);
      so_player_set_switchtoweapon(level.primary_weapon);
      so_player_giveweapon("fraggrenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_giveweapon("flash_grenade");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_killspree_paris_a") {
    level.so_campaign = "ranger";
    so_player_num(0);
    so_player_giveweapon("fraggrenade");
    so_player_giveweapon("flash_grenade");
    so_player_set_setoffhandsecondaryclass("flash");
    so_player_giveweapon("pecheneg_so_fastreload");
    so_player_giveweapon("m320");
    so_player_set_switchtoweapon("pecheneg_so_fastreload");
    so_player_setup_body(0);
    so_player_num(1);
    so_player_giveweapon("fraggrenade");
    so_player_giveweapon("flash_grenade");
    so_player_set_setoffhandsecondaryclass("flash");
    so_player_giveweapon("pecheneg_so_fastreload");
    so_player_giveweapon("m320");
    so_player_set_switchtoweapon("m320");
    so_player_setup_body(1);
    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_zodiac2_ny_harbor") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      so_player_giveweapon(level.primary_weapon);
      so_player_giveweapon(level.secondary_weapon);
      so_player_set_switchtoweapon(level.primary_weapon);
      so_player_giveweapon("fraggrenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_giveweapon("flash_grenade");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_jeep_paris_b") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "m320";
      var_5 = "scar_h_grenadier_reflex";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_ac130_paris_ac130") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "m4m203_reflex";
      var_5 = "fnfiveseven";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_stealth_prague") {
    level.so_campaign = "sas";
    level.so_stealth = 1;
    level.coop_incap_weapon = "usp_silencer";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "rsass_silenced";
      var_5 = "usp_silencer";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_stealth_london") {
    level.so_campaign = "sas";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "mp5_silencer_eotech";
      var_5 = "usp_silencer";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_timetrial_london") {
    level.so_campaign = "sas";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "mp5";
      var_5 = "spas12_silencer";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_assaultmine") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "rsass";
      var_5 = "acr_hybrid";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_deltacamp") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "acr";
      var_5 = "usp";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_trainer2_so_deltacamp") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "mp5";
      var_5 = "usp";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_milehigh_hijack") {
    level.so_campaign = "hijack";

    for(var_6 = 0; var_6 < level.players.size; var_6++) {
      so_player_num(var_6);
      so_player_giveweapon("flash_grenade");
      so_player_set_setoffhandsecondaryclass("flash");
      so_player_giveweapon("ak47");
      so_player_giveweapon("fnfiveseven");
      so_player_set_switchtoweapon("ak47");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_rescue_hijack") {
    level.so_campaign = "fso";
    level.coop_incap_weapon = "usp_silencer_so";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("usp_silencer_so");
      so_player_set_switchtoweapon("usp_silencer_so");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_javelin_hamburg") {
    level.so_campaign = "delta";

    foreach(var_6, var_3 in level.players) {
      so_player_num(var_6);
      var_4 = "javelin";
      var_5 = "scar_h_acog";
      so_player_giveweapon(var_4);
      so_player_giveweapon(var_5);
      so_player_set_switchtoweapon(var_4);
      so_player_giveweapon("fraggrenade");
      so_player_giveweapon("flash_grenade");
      so_player_setup_body(var_6);
    }

    so_players_give_loadout();
    return;
  }

  if(var_1 == "so_assassin_payback") {
    level.so_campaign = "delta";
    so_player_num(0);
    so_player_giveweapon(level.sniper_primary);
    so_player_giveweapon(level.sniper_secondary);
    so_player_set_switchtoweapon(level.sniper_primary);
    so_player_giveweapon("fraggrenade");
    so_player_giveweapon("flash_grenade");
    so_player_setup_body(0);
    so_player_num(1);
    so_player_giveweapon(level.heavy_primary);
    so_player_giveweapon(level.heavy_secondary);
    so_player_set_switchtoweapon(level.heavy_primary);
    so_player_giveweapon("fraggrenade");
    so_player_giveweapon("flash_grenade");
    so_player_setup_body(1);
    so_players_give_loadout();
    return;
  }

  if(maps\_utility::is_survival()) {
    level.so_campaign = "delta";
    level.coop_incap_weapon = "fnfiveseven_mp";
    give_default_loadout();
    return;
  }

  level.testmap = 1;
  level.so_campaign = "ranger";
  give_default_loadout();
}

possible_precache(var_0) {
  foreach(var_2 in var_0) {}
  precacheitem(var_2);
}

give_default_loadout() {
  if(maps\_utility::is_coop() || maps\_utility::is_survival()) {
    var_0 = char_switcher();

    foreach(var_3, var_2 in level.players) {}
    give_default_loadout_coop(var_3);

    so_players_give_loadout();
    return;
  }

  level.player giveweapon("fraggrenade");
  level.player setoffhandsecondaryclass("flash");
  level.player giveweapon("flash_grenade");

  if(maps\_utility::is_specialop()) {
    level.player giveweapon("m1014");
  }
  level.player giveweapon("mp5");
  level.player switchtoweapon("mp5");
  level.player setviewmodel("viewmodel_base_viewhands");
}

give_default_loadout_coop(var_0) {
  so_player_num(var_0);
  so_player_giveweapon("fraggrenade");
  so_player_giveweapon("flash_grenade");
  so_player_set_setoffhandsecondaryclass("flash");
  so_player_giveweapon("mp5");
  so_player_giveweapon("m1014");

  if(var_0 == 0) {
    so_player_set_switchtoweapon("mp5");
  } else {
    so_player_set_switchtoweapon("m1014");
  }
  so_player_setup_body(var_0);
}

saveplayerweaponstatepersistent(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  level.player endon("death");

  if(level.player.health == 0) {
    return;
  }
  var_2 = level.player getcurrentprimaryweapon();

  if(!isDefined(var_2) || var_2 == "none") {}

  game["weaponstates"][var_0]["current"] = var_2;
  var_3 = level.player getcurrentoffhand();
  game["weaponstates"][var_0]["offhand"] = var_3;
  game["weaponstates"][var_0]["list"] = [];
  var_4 = common_scripts\utility::array_combine(level.player getweaponslistprimaries(), level.player getweaponslistoffhands());

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    game["weaponstates"][var_0]["list"][var_5]["name"] = var_4[var_5];

    if(var_1) {
      game["weaponstates"][var_0]["list"][var_5]["clip"] = level.player getweaponammoclip(var_4[var_5]);
      game["weaponstates"][var_0]["list"][var_5]["stock"] = level.player getweaponammostock(var_4[var_5]);
    }
  }
}

restoreplayerweaponstatepersistent(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(!isDefined(game["weaponstates"])) {
    return 0;
  }
  if(!isDefined(game["weaponstates"][var_0])) {
    return 0;
  }
  level.player takeallweapons();

  for(var_2 = 0; var_2 < game["weaponstates"][var_0]["list"].size; var_2++) {
    var_3 = game["weaponstates"][var_0]["list"][var_2]["name"];

    if(isDefined(level.legit_weapons)) {
      if(!isDefined(level.legit_weapons[var_3])) {
        continue;
      }
    }

    if(var_3 == "c4") {
      continue;
    }
    if(var_3 == "claymore") {
      continue;
    }
    level.player giveweapon(var_3);
    level.player givemaxammo(var_3);

    if(var_1) {
      level.player setweaponammoclip(var_3, game["weaponstates"][var_0]["list"][var_2]["clip"]);
      level.player setweaponammostock(var_3, game["weaponstates"][var_0]["list"][var_2]["stock"]);
    }
  }

  if(isDefined(level.legit_weapons)) {
    var_3 = game["weaponstates"][var_0]["offhand"];

    if(isDefined(level.legit_weapons[var_3])) {
      level.player switchtooffhand(var_3);
    }
    var_3 = game["weaponstates"][var_0]["current"];

    if(isDefined(level.legit_weapons[var_3])) {
      level.player switchtoweapon(var_3);
    }
  } else {
    level.player switchtooffhand(game["weaponstates"][var_0]["offhand"]);
    level.player switchtoweapon(game["weaponstates"][var_0]["current"]);
  }

  return 1;
}

sniper_escape_initial_secondary_weapon_loadout() {
  level.player giveweapon("claymore");
  level.player giveweapon("c4");

  if(level.gameskill >= 2) {
    level.player setweaponammoclip("claymore", 10);
    level.player setweaponammoclip("c4", 6);
  } else {
    level.player setweaponammoclip("claymore", 8);
    level.player setweaponammoclip("c4", 3);
  }

  level.player setactionslot(4, "weapon", "claymore");
  level.player setactionslot(2, "weapon", "c4");
  level.player giveweapon("fraggrenade");
  level.player giveweapon("flash_grenade");
  level.player setoffhandsecondaryclass("flash");
  level.player setviewmodel("viewhands_marine_sniper");
}

set_legit_weapons_for_sniper_escape() {
  var_0 = [];
  var_0 = [];
  var_0["mp5"] = 1;
  var_0["usp_silencer"] = 1;
  var_0["ak47"] = 1;
  var_0["g3"] = 1;
  var_0["usp"] = 1;
  var_0[level.sniperescape_main_weapon] = 1;
  var_0["dragunov"] = 1;
  var_0["winchester1200"] = 1;
  var_0["beretta"] = 1;
  var_0["rpd"] = 1;
  var_0["rpg"] = 1;
  level.legit_weapons = var_0;
}

set_legit_weapons_for_favela_escape() {
  var_0 = [];
  var_0[level.favela_escape_main_weapon] = 1;
  var_0["beretta"] = 1;
  var_0["glock"] = 1;
  var_0["uzi"] = 1;
  var_0["mp5"] = 1;
  var_0["ump45"] = 1;
  var_0["ump45_acog"] = 1;
  var_0["ump45_reflex"] = 1;
  var_0["ranger"] = 1;
  var_0["model1887"] = 1;
  var_0["m4m203_reflex"] = 1;
  var_0["m4m203_eotech"] = 1;
  var_0["m4_grenadier"] = 1;
  var_0["m4_grunt"] = 1;
  var_0["tavor_mars"] = 1;
  var_0["tavor_acog"] = 1;
  var_0["masada"] = 1;
  var_0["masada_acog"] = 1;
  var_0["masada_reflex"] = 1;
  var_0["scar_h"] = 1;
  var_0["scar_h_acog"] = 1;
  var_0["scar_h_reflex"] = 1;
  var_0["scar_h_shotgun"] = 1;
  var_0["ak47"] = 1;
  var_0["ak47_acog"] = 1;
  var_0["ak47_reflex"] = 1;
  var_0["dragunov"] = 1;
  var_0["rpd"] = 1;
  var_0["m240_reflex"] = 1;
  var_0["rpg"] = 1;
  var_0["m79"] = 1;
  level.legit_weapons = var_0;
}

set_legit_weapons_for_dc_whitehouse() {
  var_0 = [];
  var_0[level.dc_whitehouse_main_weapon] = 1;
  var_0["beretta"] = 1;
  var_0["glock"] = 1;
  var_0["uzi"] = 1;
  var_0["mp5"] = 1;
  var_0["ump45"] = 1;
  var_0["ump45_acog"] = 1;
  var_0["ump45_reflex"] = 1;
  var_0["ranger"] = 1;
  var_0["model1887"] = 1;
  var_0["m4m203_reflex"] = 1;
  var_0["m4m203_eotech"] = 1;
  var_0["m4_grenadier"] = 1;
  var_0["m4_grunt"] = 1;
  var_0["tavor_mars"] = 1;
  var_0["tavor_acog"] = 1;
  var_0["masada"] = 1;
  var_0["masada_acog"] = 1;
  var_0["masada_reflex"] = 1;
  var_0["scar_h"] = 1;
  var_0["scar_h_acog"] = 1;
  var_0["scar_h_reflex"] = 1;
  var_0["scar_h_shotgun"] = 1;
  var_0["ak47"] = 1;
  var_0["ak47_acog"] = 1;
  var_0["ak47_reflex"] = 1;
  var_0["dragunov"] = 1;
  var_0["rpd"] = 1;
  var_0["m240_reflex"] = 1;
  var_0["rpg"] = 1;
  var_0["m79"] = 1;
  level.legit_weapons = var_0;
}

max_ammo_on_legit_sniper_escape_weapon() {
  var_0 = level.player getweaponslistall();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level.legit_weapons[var_2])) {
      continue;
    }
    if(var_2 == "rpg") {
      continue;
    }
    level.player givemaxammo(var_2);
  }
}

force_player_to_use_legit_sniper_escape_weapon() {
  var_0 = level.player getweaponslistall();
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_1[var_4] = 1;

    if(isDefined(level.legit_weapons[var_4])) {
      var_2++;
      continue;
    }

    level.player takeweapon(var_4);
  }

  if(var_2 == 2) {
    return;
  }
  if(var_2 == 0) {
    level.player giveweapon("ak47");
    level.player switchtoweapon("ak47");
  }

  if(!isDefined(var_1[level.sniperescape_main_weapon]) && !isDefined(var_1["dragunov"])) {
    level.player giveweapon(level.sniperescape_main_weapon);
    level.player switchtoweapon(level.sniperescape_main_weapon);
  }
}

coop_gamesetup_menu() {
  maps\_gameskill::setglobaldifficulty();

  foreach(var_2, var_1 in level.players) {}
  var_1 maps\_gameskill::setdifficulty();

  level.character_switched = 0;
  common_scripts\utility::flag_init("character_selected");
  var_3 = "";
  var_4 = [];
  var_4 = strtok(var_3, " ");

  foreach(var_6 in var_4) {
    if(var_6 == level.script) {
      common_scripts\utility::flag_set("character_selected");
    }
  }

  var_8 = "so_ac130_co_hunted co_hunted co_ac130";
  var_9 = [];
  var_9 = strtok(var_8, " ");

  foreach(var_6 in var_9) {
    if(maps\_utility::is_coop() && var_6 == level.script) {
      var_11 = getDvar("ui_ac130_pilot_num");

      if(isDefined(var_11) && var_11 != "0") {
        level.character_switched = 1;
      }
      common_scripts\utility::flag_set("character_selected");
    }
  }
}

coop_gamesetup_ac130() {
  if(level.specops_character_selector == "so_char_host") {
    return level.players[0];
  }
  if(level.specops_character_selector == "so_char_client") {
    return level.players[1];
  }
  return level.players[0];
}

give_default_loadout_specialops() {
  foreach(var_2, var_1 in level.players) {
    so_player_num(var_2);
    so_player_giveweapon("fraggrenade");
    so_player_giveweapon("flash_grenade");
    so_player_set_setoffhandsecondaryclass("flash");
    so_player_giveweapon("mp5");
    so_player_giveweapon("m1014");
    so_player_set_switchtoweapon("mp5");
    so_player_setup_body(var_2);
  }

  so_players_give_loadout();
}

so_player_num(var_0) {
  level.so_player_num = var_0;
  level.so_player_add_player_giveweapon[var_0] = [];

  if(!isDefined(level.so_player_set_maxammo)) {
    level.so_player_set_maxammo = [];
  }
  if(!isDefined(level.so_player_set_setviewmodel)) {
    level.so_player_set_setviewmodel = [];
  }
  if(!isDefined(level.so_player_add_player_giveweapon)) {
    level.so_player_add_player_giveweapon = [];
  }
  if(!isDefined(level.so_player_set_setoffhandsecondaryclass)) {
    level.so_player_set_setoffhandsecondaryclass = [];
  }
  if(!isDefined(level.so_player_set_switchtoweapon)) {
    level.so_player_set_switchtoweapon = [];
  }
  if(!isDefined(level.so_player_setmodelfunc)) {
    level.so_player_setmodelfunc = [];
  }
  if(!isDefined(level.so_player_setmodelfunc_precache)) {
    level.so_player_setmodelfunc_precache = [];
  }
  if(!isDefined(level.so_player_setactionslot)) {
    level.so_player_setactionslot = [];
  }
  level.so_player_set_maxammo[var_0] = [];
  level.so_player_set_setoffhandsecondaryclass[var_0] = [];
  level.so_player_add_player_giveweapon[var_0] = [];
}

so_player_giveweapon(var_0) {
  var_1 = level.so_player_num;

  if(!level.character_selected) {
    precacheitem(var_0);
  }
  level.so_player_add_player_giveweapon[var_1][var_0] = 1;
}

so_player_set_maxammo(var_0) {
  var_1 = level.so_player_num;
  level.so_player_set_maxammo[var_1][var_0] = 1;
}

so_player_set_setoffhandsecondaryclass(var_0) {
  var_1 = level.so_player_num;
  level.so_player_set_setoffhandsecondaryclass[var_1] = var_0;
}

so_player_set_switchtoweapon(var_0) {
  var_1 = level.so_player_num;
  level.so_player_set_switchtoweapon[var_1] = var_0;
}

so_player_set_setviewmodel(var_0) {
  var_1 = level.so_player_num;

  if(!level.character_selected) {
    precachemodel(var_0);
  }
  level.so_player_set_setviewmodel[var_1] = var_0;
}

so_player_setmodelfunc(var_0, var_1) {
  var_2 = level.so_player_num;
  level.so_player_setmodelfunc[var_2] = var_0;

  if(!level.character_selected) {
    [[var_1]]();
  }
}

so_player_setactionslot(var_0, var_1, var_2) {
  var_3 = level.so_player_num;
  var_4 = spawnStruct();
  var_4.slot = var_0;
  var_4.parm1 = var_1;

  if(isDefined(var_2)) {
    var_4.parm2 = var_2;
  }
  if(isDefined(level.so_player_setactionslot[var_3])) {
    var_5 = level.so_player_setactionslot[var_3].size;
  } else {
    var_5 = 0;
  }
  level.so_player_setactionslot[var_3][var_5] = var_4;
}

#using_animtree("multiplayer");

so_player_give_loadout(var_0) {
  var_1 = self;

  if(isDefined(level.so_player_setmodelfunc[var_0])) {
    var_1 maps\_utility::setmodelfunc(level.so_player_setmodelfunc[var_0]);
    var_1 setanim(%code, 1, 0);
  }

  var_2 = getarraykeys(level.so_player_add_player_giveweapon[var_0]);

  foreach(var_4 in var_2) {
    var_1 giveweapon(var_4);

    if(isDefined(level.so_player_set_maxammo[var_0][var_4])) {
      var_1 givemaxammo(var_4);
    }
  }

  if(isDefined(level.so_player_set_setoffhandsecondaryclass[var_0])) {
    var_1 setoffhandsecondaryclass("flash");
  }
  if(isDefined(level.so_player_setactionslot[var_0])) {
    var_1 so_players_give_action(var_0);
  }
  if(isDefined(level.so_player_set_switchtoweapon[var_0])) {
    var_1 switchtoweapon(level.so_player_set_switchtoweapon[var_0]);
  }
  if(isDefined(level.so_player_set_setviewmodel[var_0])) {
    var_1 setviewmodel(level.so_player_set_setviewmodel[var_0]);
  }
}

so_players_give_action(var_0) {
  var_1 = self;

  foreach(var_3 in level.so_player_setactionslot[var_0]) {
    if(isDefined(var_3.parm2)) {
      var_1 setactionslot(var_3.slot, var_3.parm1, var_3.parm2);
      continue;
    }

    var_1 setactionslot(var_3.slot, var_3.parm1);
  }
}

so_players_give_loadout() {
  foreach(var_2, var_1 in level.players) {}
  var_1 so_player_give_loadout(var_2);
}

updatemodel(var_0) {
  self notify("newupdatemodel");

  if(!isDefined(var_0)) {
    self detachall();
    self setModel("");
    return;
  }

  self.last_modelfunc = var_0;

  if(isDefined(self.is_hidden) && self.is_hidden) {
    return;
  }
  self endon("newupdatemodel");

  for(;;) {
    self detachall();
    [[var_0]]();
    self updateplayermodelwithweapons();
    common_scripts\utility::waittill_any_return("weapon_change", "weaponchange", "player_update_model", "player_downed", "not_in_last_stand");
  }
}

so_player_setup_body(var_0) {
  so_player_set_setviewmodel(so_player_get_hands());

  if(maps\_utility::is_coop() || maps\_utility::is_survival()) {
    so_player_setmodelfunc(so_player_get_bodyfunc(var_0), so_player_get_bodyfunc_precache(var_0));
  }
}

so_player_get_bodyfunc(var_0) {
  switch (level.so_campaign) {
    case "ranger":
      return::so_body_player_ranger;
    case "seal":
      return::so_body_player_seal;
    case "arctic":
      return::so_body_player_arctic;
    case "woodland":
      return::so_body_player_woodland;
    case "desert":
      return::so_body_player_desert;
    case "ghillie":
      return::so_body_player_ghillie;
    case "delta":
      return::so_body_player_delta;
    case "sas":
      return::so_body_player_sas;
    case "hijack":
      if(var_0 == 0) {
        return::so_body_player_hijack_1;
      } else {
        return::so_body_player_hijack_2;
      }
    case "fso":
      if(var_0 == 0) {
        return::so_body_player_fso_1;
      } else {
        return::so_body_player_fso_2;
      }
    default:
  }

  return;
}

so_player_get_bodyfunc_precache(var_0) {
  switch (level.so_campaign) {
    case "ranger":
      return::so_body_player_ranger_precache;
    case "seal":
      return::so_body_player_seal_precache;
    case "arctic":
      return::so_body_player_arctic_precache;
    case "woodland":
      return::so_body_player_woodland_precache;
    case "desert":
      return::so_body_player_desert_precache;
    case "ghillie":
      return::so_body_player_ghillie_precache;
    case "delta":
      return::so_body_player_delta_precache;
    case "sas":
      return::so_body_player_sas_precache;
    case "hijack":
      if(var_0 == 0) {
        return::so_body_player_hijack_precache_1;
      } else {
        return::so_body_player_hijack_precache_2;
      }
    case "fso":
      if(var_0 == 0) {
        return::so_body_player_fso_precache_1;
      } else {
        return::so_body_player_fso_precache_2;
      }
  }

  return;
}

so_player_get_hands() {
  switch (level.so_campaign) {
    case "ranger":
      return "viewmodel_base_viewhands";
    case "seal":
      return "viewhands_udt";
    case "arctic":
      return "viewhands_arctic";
    case "woodland":
      return "viewhands_sas_woodland";
    case "desert":
      return "viewhands_tf141";
    case "ghillie":
      return "viewhands_marine_sniper";
    case "delta":
      return "viewhands_delta";
    case "sas":
      return "viewhands_sas";
    case "hijack":
      return "viewhands_henchmen";
    case "fso":
      return "viewhands_fso";
  }
}

so_body_player_ranger() {
  self setModel("coop_body_us_army");
  self attach("coop_head_us_army", "", 1);
}

so_body_player_seal() {
  self setModel("coop_body_seal_udt");
  self attach("coop_head_seal_udt", "", 1);
}

so_body_player_arctic() {
  self setModel("coop_body_tf141_arctic");
  self attach("coop_head_tf141_arctic", "", 1);
}

so_body_player_woodland() {
  self setModel("coop_body_tf141_forest");
  self attach("coop_head_tf141_forest", "", 1);
}

so_body_player_desert() {
  self setModel("coop_body_tf141_desert");
  self attach("coop_head_tf141_desert", "", 1);
}

so_body_player_ghillie() {
  self setModel("coop_body_ghillie_forest");
  self attach("coop_head_ghillie_forest", "", 1);
}

so_body_player_delta() {
  self setModel("mp_body_delta_elite_assault_bb");
  self attach("head_delta_elite_a", "", 1);
}

so_body_player_sas() {
  self setModel("body_mp_sas_urban_specops");
}

so_body_player_hijack_1() {
  self setModel("mp_body_henchmen_assault_d");
  self attach("head_henchmen_a", "", 1);
}

so_body_player_hijack_2() {
  self setModel("mp_body_henchmen_shotgun_a");
  self attach("head_henchmen_c", "", 1);
}

so_body_player_fso_1() {
  self setModel("mp_body_fso_vest_c_dirty");
  self attach("head_fso_e_dirty", "", 1);
}

so_body_player_fso_2() {
  self setModel("mp_body_fso_vest_d_dirty");
  self attach("head_fso_d_dirty", "", 1);
}

so_body_player_ranger_precache() {
  precachemodel("coop_body_us_army");
  precachemodel("coop_head_us_army");
}

so_body_player_seal_precache() {
  precachemodel("coop_body_seal_udt");
  precachemodel("coop_head_seal_udt");
}

so_body_player_arctic_precache() {
  precachemodel("coop_body_tf141_arctic");
  precachemodel("coop_head_tf141_arctic");
}

so_body_player_woodland_precache() {
  precachemodel("coop_body_tf141_forest");
  precachemodel("coop_head_tf141_forest");
}

so_body_player_desert_precache() {
  precachemodel("coop_body_tf141_desert");
  precachemodel("coop_head_tf141_desert");
}

so_body_player_ghillie_precache() {
  precachemodel("coop_body_ghillie_forest");
  precachemodel("coop_head_ghillie_forest");
}

so_body_player_delta_precache() {
  precachemodel("mp_body_delta_elite_assault_bb");
  precachemodel("head_delta_elite_a");
}

so_body_player_sas_precache() {
  precachemodel("body_mp_sas_urban_specops");
}

so_body_player_hijack_precache_1() {
  precachemodel("mp_body_henchmen_assault_d");
  precachemodel("head_henchmen_a");
}

so_body_player_hijack_precache_2() {
  precachemodel("mp_body_henchmen_shotgun_a");
  precachemodel("head_henchmen_c");
}

so_body_player_fso_precache_1() {
  precachemodel("mp_body_fso_vest_c_dirty");
  precachemodel("head_fso_e_dirty");
}

so_body_player_fso_precache_2() {
  precachemodel("mp_body_fso_vest_d_dirty");
  precachemodel("head_fso_d_dirty");
}