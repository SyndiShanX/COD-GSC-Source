/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\272.gsc
**************************************/

_id_1C5B() {
  if(!isDefined(level._id_1C5C)) {
    _id_1C65();

  }
  level._id_0A82 = 1;
  level notify("loadout complete");
}

_id_1C5D() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "altMode");
  self setactionslot(4, "");
}

_id_1C5E() {
  _id_1C5D();
  self takeallweapons();
}

_id_1C5F() {
  level._id_1C60 = level.player;
  level._id_1C61 = level._id_1337;

  if(isDefined(level._id_1C62) && level._id_1C62) {
    if(maps\_utility::_id_12C1()) {
      foreach(var_1 in level.players) {}
      var_1 _id_1C5E();

      level._id_1C60 = level._id_1337;
      level._id_1C61 = level.player;
      level._id_1C62 = 1;
      return 1;
    } else {
      level.player _id_1C5E();
      level._id_1C60 = undefined;
      level._id_1C61 = level.player;
      level._id_1C62 = 1;
      return 1;
    }
  }

  return 0;
}

_id_1C63() {
  if(isDefined(level._id_1C64)) {
    return level._id_1C64;

  }
  return level.script;
}

_id_1C65(var_0) {
  var_1 = _id_1C63();

  if(!isDefined(var_0)) {
    var_0 = 0;

  }
  level._id_1C66 = var_0;
  var_2 = [];
  level.player _id_1C5D();

  if(maps\_utility::_id_12C1()) {
    level._id_1337 _id_1C5D();

  }
  if(!isDefined(game["expectedlevel"])) {
    game["expectedlevel"] = "";

  }
  if(!isDefined(level._id_0BA2)) {
    level._id_0BA2 = "american";

  }
  if(common_scripts\utility::string_starts_with(level.script, "pmc_")) {
    level.player setviewmodel("viewmodel_base_viewhands");

    if(maps\_utility::_id_12C1()) {
      precachemodel("weapon_parabolic_knife");
      level.player maps\_utility::_id_1C67(::_id_1CA0);
      level._id_1337 maps\_utility::_id_1C67(::_id_1CA0);
      level._id_1337 setviewmodel("viewmodel_base_viewhands");
    }

    level._id_0BA2 = "american";
    return;
  }

  if(maps\_utility::_id_0A36()) {
    _id_1C6D(var_0);
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
    level._id_0BA2 = "british";
    return;
  } else if(var_1 == "innocent") {
    level.player setviewmodel("viewhands_sas");
    level._id_0BA2 = "british";

    if(!isDefined(game["previous_map"])) {
      level.player giveweapon("mp5_silencer_eotech");
      level.player giveweapon("usp_silencer");
      level.player giveweapon("fraggrenade");
      level.player giveweapon("flash_grenade");
      level.player setoffhandsecondaryclass("flash");
      level.player switchtoweapon("mp5_silencer_eotech");
    } else {
      level.player setoffhandsecondaryclass("flash");
      _id_1C7C("london", 1);
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
    level._id_0BA2 = "delta";
    return;
  } else if(var_1 == "prague") {
    level._id_1C68 = "rsass_hybrid_silenced";
    level.player giveweapon(level._id_1C68);
    level.player giveweapon("usp_silencer");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level._id_1C68);
    level.player setviewmodel("viewhands_yuri_europe");
    level._id_0BA2 = "delta";
    return;
  } else if(var_1 == "warlord") {
    level.player giveweapon("m14ebr_scoped_silenced_warlord");
    level.player giveweapon("ak47_silencer_reflex");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("m14ebr_scoped_silenced_warlord");
    level.player setviewmodel("viewhands_yuri");
    level._id_0BA2 = "american";
    return;
  } else if(var_1 == "castle") {
    level._id_1C69 = "mp5_silencer_reflex_castle";
    level._id_1C6A = "p99_tactical_silencer";
    level.player giveweapon(level._id_1C69);
    level.player giveweapon(level._id_1C6A);
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level._id_1C69);
    level.player setviewmodel("viewhands_yuri_europe");
    level._id_0BA2 = "american";
    return;
  } else if(var_1 == "berlin") {
    level.player giveweapon("m14ebr_scope");
    level.player giveweapon("acr_hybrid_berlin");
    level.player giveweapon("fraggrenade");
    level.player setoffhandsecondaryclass("flash");
    level.player giveweapon("ninebang_grenade");
    level.player switchtoweapon("acr_hybrid_berlin");
    level.player setviewmodel("viewhands_delta");
    level._id_0BA2 = "delta";
    return;
  } else if(var_1 == "paris_a") {
    level.player giveweapon("scar_h_acog");
    level.player giveweapon("usp_no_knife");
    level.player giveweapon("fraggrenade");
    level.player setoffhandsecondaryclass("flash");
    level.player giveweapon("ninebang_grenade");
    level.player switchtoweapon("scar_h_acog");
    level.player setviewmodel("viewhands_delta");
    level._id_0BA2 = "delta";
    return;
  } else if(var_1 == "paris_b") {
    level.player giveweapon("scar_h_acog");
    level.player giveweapon("usp_no_knife");
    level.player giveweapon("fraggrenade");
    level.player setoffhandsecondaryclass("flash");
    level.player giveweapon("ninebang_grenade");
    level.player switchtoweapon("scar_h_acog");
    level.player setviewmodel("viewhands_delta");
    level._id_0BA2 = "delta";
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
    level._id_0BA2 = "delta";
    return;
  } else if(var_1 == "ny_manhattan") {
    level.player giveweapon("m4_hybrid_grunt_optim");
    level.player giveweapon("xm25");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("m4_hybrid_grunt_optim");
    level.player setviewmodel("viewhands_delta_shg");
    level._id_0BA2 = "delta";
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
    level._id_0BA2 = "delta";
    return;
  } else if(var_1 == "dubai") {
    level._id_1C6B = "pecheneg_fastreload";
    level.player giveweapon(level._id_1C6B);
    level.player givemaxammo(level._id_1C6B);
    level.player giveweapon("m4m203_acog");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level._id_1C6B);
    level.player setviewmodel("viewhands_juggernaut_ally");
    level._id_0BA2 = "american";
    return;
  } else if(var_1 == "payback") {
    level.player giveweapon("m4m203_acog_payback");
    level.player giveweapon("deserteagle");
    level.player giveweapon("fraggrenade");
    level.player setoffhandsecondaryclass("flash");
    level.player giveweapon("flash_grenade");
    level.player switchtoweapon("m4m203_acog_payback");
    level.player setviewmodel("viewhands_yuri");
    level._id_0BA2 = "delta";
    return;
  } else if(var_1 == "hijack") {
    level.player giveweapon("fnfiveseven");
    level.player switchtoweapon("fnfiveseven");
    level.player setviewmodel("viewhands_fso");
    level._id_0BA2 = "american";
    return;
  } else if(var_1 == "prague_escape") {
    level.player giveweapon("deserteagle");
    level.player giveweapon("m4m203_reflex");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon("m4m203_reflex");
    level.player setviewmodel("viewhands_yuri_europe");
    level._id_0BA2 = "delta";
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
    level._id_0BA2 = "american";
    return;
  } else if(var_1 == "rescue") {
    level._id_1C68 = "acr_hybrid_silenced";
    level.player giveweapon(level._id_1C68);
    level.player givemaxammo(level._id_1C68);
    level.player giveweapon("usp");
    level.player givemaxammo("usp");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandprimaryclass("frag");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level._id_1C68);
    level.player setviewmodel("viewmodel_base_viewhands");
    level._id_0BA2 = "american";
    return;
  } else if(var_1 == "rescue_2") {
    level._id_1C68 = "g36c_reflex";
    level.player giveweapon(level._id_1C68);
    level.player givemaxammo(level._id_1C68);
    level.player giveweapon("m4_grunt_acog");
    level.player givemaxammo("m4_grunt_acog");
    level.player giveweapon("fraggrenade");
    level.player giveweapon("flash_grenade");
    level.player setoffhandprimaryclass("frag");
    level.player setoffhandsecondaryclass("flash");
    level.player switchtoweapon(level._id_1C68);
    level.player setviewmodel("viewhands_yuri_europe");
    level._id_0BA2 = "american";
    return;
  } else if(var_1 == "innocent") {
    level._id_0BA2 = "british";
    return;
  }

  if(issubstr(var_1, "firingrange")) {
    return;
  }
  level._id_1C6C = 1;
  _id_1C79();
}

_id_1C6D(var_0) {
  var_1 = _id_1C63();

  if(var_1 == "so_nyse_ny_manhattan") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "m4_hybrid_grunt_optim";
      var_5 = "xm25";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_stealth_warlord") {
    level._id_1338 = "delta";
    level._id_1AB1 = level._id_1C6E;

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      _id_1C94(level._id_1C6F);
      _id_1C94(level._id_1C6E);
      _id_1C90(level._id_1C6F);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_littlebird_payback") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      _id_1C94(level._id_1C70);
      _id_1C94(level._id_1C71);
      _id_1C90(level._id_1C70);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_ied_berlin") {
    level._id_1338 = "delta";

    if(maps\_utility::_id_12C1()) {
      if(getdvar("coop_start") == "so_char_host") {
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

    _id_1C8B(var_9);
    _id_1C94("fraggrenade");
    _id_1C94("flash_grenade");
    _id_1C8F("flash");
    _id_1C94("sa80lmg_fastreload_reflex");
    _id_1C94("m320");
    _id_1C90("sa80lmg_fastreload_reflex");
    _id_1C9C(var_9);
    _id_1C8B(var_10);
    _id_1C94("fraggrenade");
    _id_1C94("semtex_grenade");
    _id_1C8F("semtex_grenade");
    _id_1C94("barrett");
    _id_1C94("scar_h_thermal_silencer");
    _id_1C90("barrett");
    _id_1C9C(var_10);
    _id_1C99();
    return;
  }

  if(var_1 == "so_assault_rescue_2") {
    var_11 = "m4_grunt_acog";
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      _id_1C94(var_11);
      _id_1C8D(var_11);
      _id_1C94("g36c_reflex");
      _id_1C8D("g36c_reflex");
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C9C(var_6);
      _id_1C90(var_11);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_heliswitch_berlin") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      _id_1C94(level._id_1C72);
      _id_1C94(level._id_1C73);
      _id_1C90(level._id_1C72);
      _id_1C94("fraggrenade");
      _id_1C8F("flash");
      _id_1C94("flash_grenade");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_killspree_paris_a") {
    level._id_1338 = "ranger";
    _id_1C8B(0);
    _id_1C94("fraggrenade");
    _id_1C94("flash_grenade");
    _id_1C8F("flash");
    _id_1C94("pecheneg_so_fastreload");
    _id_1C94("m320");
    _id_1C90("pecheneg_so_fastreload");
    _id_1C9C(0);
    _id_1C8B(1);
    _id_1C94("fraggrenade");
    _id_1C94("flash_grenade");
    _id_1C8F("flash");
    _id_1C94("pecheneg_so_fastreload");
    _id_1C94("m320");
    _id_1C90("m320");
    _id_1C9C(1);
    _id_1C99();
    return;
  }

  if(var_1 == "so_zodiac2_ny_harbor") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      _id_1C94(level._id_1C72);
      _id_1C94(level._id_1C73);
      _id_1C90(level._id_1C72);
      _id_1C94("fraggrenade");
      _id_1C8F("flash");
      _id_1C94("flash_grenade");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_jeep_paris_b") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "m320";
      var_5 = "scar_h_grenadier_reflex";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_ac130_paris_ac130") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "m4m203_reflex";
      var_5 = "fnfiveseven";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_stealth_prague") {
    level._id_1338 = "sas";
    level._id_1336 = 1;
    level._id_1AB1 = "usp_silencer";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "rsass_silenced";
      var_5 = "usp_silencer";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_stealth_london") {
    level._id_1338 = "sas";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "mp5_silencer_eotech";
      var_5 = "usp_silencer";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_timetrial_london") {
    level._id_1338 = "sas";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "mp5";
      var_5 = "spas12_silencer";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_assaultmine") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "rsass";
      var_5 = "acr_hybrid";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_deltacamp") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "acr";
      var_5 = "usp";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_trainer2_so_deltacamp") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "mp5";
      var_5 = "usp";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_milehigh_hijack") {
    level._id_1338 = "hijack";

    for(var_6 = 0; var_6 < level.players.size; var_6++) {
      _id_1C8B(var_6);
      _id_1C94("flash_grenade");
      _id_1C8F("flash");
      _id_1C94("ak47");
      _id_1C94("fnfiveseven");
      _id_1C90("ak47");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_rescue_hijack") {
    level._id_1338 = "fso";
    level._id_1AB1 = "usp_silencer_so";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      _id_1C94("fraggrenade");
      _id_1C94("usp_silencer_so");
      _id_1C90("usp_silencer_so");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_javelin_hamburg") {
    level._id_1338 = "delta";

    foreach(var_6, var_3 in level.players) {
      _id_1C8B(var_6);
      var_4 = "javelin";
      var_5 = "scar_h_acog";
      _id_1C94(var_4);
      _id_1C94(var_5);
      _id_1C90(var_4);
      _id_1C94("fraggrenade");
      _id_1C94("flash_grenade");
      _id_1C9C(var_6);
    }

    _id_1C99();
    return;
  }

  if(var_1 == "so_assassin_payback") {
    level._id_1338 = "delta";
    _id_1C8B(0);
    _id_1C94(level._id_1C74);
    _id_1C94(level._id_1C75);
    _id_1C90(level._id_1C74);
    _id_1C94("fraggrenade");
    _id_1C94("flash_grenade");
    _id_1C9C(0);
    _id_1C8B(1);
    _id_1C94(level._id_1C76);
    _id_1C94(level._id_1C77);
    _id_1C90(level._id_1C76);
    _id_1C94("fraggrenade");
    _id_1C94("flash_grenade");
    _id_1C9C(1);
    _id_1C99();
    return;
  }

  if(maps\_utility::_id_12DC()) {
    level._id_1338 = "delta";
    level._id_1AB1 = "fnfiveseven_mp";
    _id_1C79();
    return;
  }

  level._id_1C6C = 1;
  level._id_1338 = "ranger";
  _id_1C79();
}

_id_1C78(var_0) {
  foreach(var_2 in var_0) {}
  precacheitem(var_2);
}

_id_1C79() {
  if(maps\_utility::_id_12C1() || maps\_utility::_id_12DC()) {
    var_0 = _id_1C5F();

    foreach(var_3, var_2 in level.players) {}
    _id_1C7A(var_3);

    _id_1C99();
    return;
  }

  level.player giveweapon("fraggrenade");
  level.player setoffhandsecondaryclass("flash");
  level.player giveweapon("flash_grenade");

  if(maps\_utility::_id_0A36()) {
    level.player giveweapon("m1014");

  }
  level.player giveweapon("mp5");
  level.player switchtoweapon("mp5");
  level.player setviewmodel("viewmodel_base_viewhands");
}

_id_1C7A(var_0) {
  _id_1C8B(var_0);
  _id_1C94("fraggrenade");
  _id_1C94("flash_grenade");
  _id_1C8F("flash");
  _id_1C94("mp5");
  _id_1C94("m1014");

  if(var_0 == 0) {
    _id_1C90("mp5");
  } else {
    _id_1C90("m1014");

  }
  _id_1C9C(var_0);
}

_id_1C7B(var_0, var_1) {
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

_id_1C7C(var_0, var_1) {
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

    if(isDefined(level._id_1C7D)) {
      if(!isDefined(level._id_1C7D[var_3])) {
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

  if(isDefined(level._id_1C7D)) {
    var_3 = game["weaponstates"][var_0]["offhand"];

    if(isDefined(level._id_1C7D[var_3])) {
      level.player switchtooffhand(var_3);

    }
    var_3 = game["weaponstates"][var_0]["current"];

    if(isDefined(level._id_1C7D[var_3])) {
      level.player switchtoweapon(var_3);
    }
  } else {
    level.player switchtooffhand(game["weaponstates"][var_0]["offhand"]);
    level.player switchtoweapon(game["weaponstates"][var_0]["current"]);
  }

  return 1;
}

_id_1C7E() {
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

_id_1C7F() {
  var_0 = [];
  var_0 = [];
  var_0["mp5"] = 1;
  var_0["usp_silencer"] = 1;
  var_0["ak47"] = 1;
  var_0["g3"] = 1;
  var_0["usp"] = 1;
  var_0[level._id_1C80] = 1;
  var_0["dragunov"] = 1;
  var_0["winchester1200"] = 1;
  var_0["beretta"] = 1;
  var_0["rpd"] = 1;
  var_0["rpg"] = 1;
  level._id_1C7D = var_0;
}

_id_1C81() {
  var_0 = [];
  var_0[level._id_1C82] = 1;
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
  level._id_1C7D = var_0;
}

_id_1C83() {
  var_0 = [];
  var_0[level._id_1C84] = 1;
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
  level._id_1C7D = var_0;
}

_id_1C85() {
  var_0 = level.player getweaponslistall();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level._id_1C7D[var_2])) {
      continue;
    }
    if(var_2 == "rpg") {
      continue;
    }
    level.player givemaxammo(var_2);
  }
}

_id_1C86() {
  var_0 = level.player getweaponslistall();
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_1[var_4] = 1;

    if(isDefined(level._id_1C7D[var_4])) {
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

  if(!isDefined(var_1[level._id_1C80]) && !isDefined(var_1["dragunov"])) {
    level.player giveweapon(level._id_1C80);
    level.player switchtoweapon(level._id_1C80);
  }
}

_id_1C87() {
  maps\_gameskill::_id_17D1();

  foreach(var_2, var_1 in level.players) {}
  var_1 maps\_gameskill::_id_17D2();

  level._id_1C62 = 0;
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
    if(maps\_utility::_id_12C1() && var_6 == level.script) {
      var_11 = getdvar("ui_ac130_pilot_num");

      if(isDefined(var_11) && var_11 != "0") {
        level._id_1C62 = 1;

      }
      common_scripts\utility::flag_set("character_selected");
    }
  }
}

_id_1C88() {
  if(level._id_1C89 == "so_char_host") {
    return level.players[0];

  }
  if(level._id_1C89 == "so_char_client") {
    return level.players[1];

  }
  return level.players[0];
}

_id_1C8A() {
  foreach(var_2, var_1 in level.players) {
    _id_1C8B(var_2);
    _id_1C94("fraggrenade");
    _id_1C94("flash_grenade");
    _id_1C8F("flash");
    _id_1C94("mp5");
    _id_1C94("m1014");
    _id_1C90("mp5");
    _id_1C9C(var_2);
  }

  _id_1C99();
}

_id_1C8B(var_0) {
  level._id_1C8B = var_0;
  level._id_1C8C[var_0] = [];

  if(!isDefined(level._id_1C8D)) {
    level._id_1C8D = [];

  }
  if(!isDefined(level._id_1C8E)) {
    level._id_1C8E = [];

  }
  if(!isDefined(level._id_1C8C)) {
    level._id_1C8C = [];

  }
  if(!isDefined(level._id_1C8F)) {
    level._id_1C8F = [];

  }
  if(!isDefined(level._id_1C90)) {
    level._id_1C90 = [];

  }
  if(!isDefined(level._id_1C91)) {
    level._id_1C91 = [];

  }
  if(!isDefined(level._id_1C92)) {
    level._id_1C92 = [];

  }
  if(!isDefined(level._id_1C93)) {
    level._id_1C93 = [];

  }
  level._id_1C8D[var_0] = [];
  level._id_1C8F[var_0] = [];
  level._id_1C8C[var_0] = [];
}

_id_1C94(var_0) {
  var_1 = level._id_1C8B;

  if(!level._id_1C66) {
    precacheitem(var_0);

  }
  level._id_1C8C[var_1][var_0] = 1;
}

_id_1C8D(var_0) {
  var_1 = level._id_1C8B;
  level._id_1C8D[var_1][var_0] = 1;
}

_id_1C8F(var_0) {
  var_1 = level._id_1C8B;
  level._id_1C8F[var_1] = var_0;
}

_id_1C90(var_0) {
  var_1 = level._id_1C8B;
  level._id_1C90[var_1] = var_0;
}

_id_1C8E(var_0) {
  var_1 = level._id_1C8B;

  if(!level._id_1C66) {
    precachemodel(var_0);

  }
  level._id_1C8E[var_1] = var_0;
}

_id_1C91(var_0, var_1) {
  var_2 = level._id_1C8B;
  level._id_1C91[var_2] = var_0;

  if(!level._id_1C66) {
    [[var_1]]();
  }
}

_id_1C93(var_0, var_1, var_2) {
  var_3 = level._id_1C8B;
  var_4 = spawnStruct();
  var_4.slot = var_0;
  var_4._id_1C95 = var_1;

  if(isDefined(var_2)) {
    var_4._id_1C96 = var_2;

  }
  if(isDefined(level._id_1C93[var_3])) {
    var_5 = level._id_1C93[var_3].size;
  } else {
    var_5 = 0;

  }
  level._id_1C93[var_3][var_5] = var_4;
}

#using_animtree("multiplayer");

_id_1C97(var_0) {
  var_1 = self;

  if(isDefined(level._id_1C91[var_0])) {
    var_1 maps\_utility::_id_1C67(level._id_1C91[var_0]);
    var_1 setanim( % code, 1, 0);
  }

  var_2 = getarraykeys(level._id_1C8C[var_0]);

  foreach(var_4 in var_2) {
    var_1 giveweapon(var_4);

    if(isDefined(level._id_1C8D[var_0][var_4])) {
      var_1 givemaxammo(var_4);
    }
  }

  if(isDefined(level._id_1C8F[var_0])) {
    var_1 setoffhandsecondaryclass("flash");

  }
  if(isDefined(level._id_1C93[var_0])) {
    var_1 _id_1C98(var_0);

  }
  if(isDefined(level._id_1C90[var_0])) {
    var_1 switchtoweapon(level._id_1C90[var_0]);

  }
  if(isDefined(level._id_1C8E[var_0])) {
    var_1 setviewmodel(level._id_1C8E[var_0]);
  }
}

_id_1C98(var_0) {
  var_1 = self;

  foreach(var_3 in level._id_1C93[var_0]) {
    if(isDefined(var_3._id_1C96)) {
      var_1 setactionslot(var_3.slot, var_3._id_1C95, var_3._id_1C96);
      continue;
    }

    var_1 setactionslot(var_3.slot, var_3._id_1C95);
  }
}

_id_1C99() {
  foreach(var_2, var_1 in level.players) {}
  var_1 _id_1C97(var_2);
}

_id_1C9A(var_0) {
  self notify("newupdatemodel");

  if(!isDefined(var_0)) {
    self detachall();
    self setModel("");
    return;
  }

  self._id_1C9B = var_0;

  if(isDefined(self._id_1B7C) && self._id_1B7C) {
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

_id_1C9C(var_0) {
  _id_1C8E(_id_1C9F());

  if(maps\_utility::_id_12C1() || maps\_utility::_id_12DC()) {
    _id_1C91(_id_1C9D(var_0), _id_1C9E(var_0));
  }
}

_id_1C9D(var_0) {
  switch (level._id_1338) {
    case "ranger":
      return::_id_1CA0;
    case "seal":
      return::_id_1CA1;
    case "arctic":
      return::_id_1CA2;
    case "woodland":
      return::_id_1CA3;
    case "desert":
      return::_id_1CA4;
    case "ghillie":
      return::_id_1CA5;
    case "delta":
      return::_id_1CA6;
    case "sas":
      return::_id_1CA7;
    case "hijack":
      if(var_0 == 0) {
        return::_id_1CA8;
      } else {
        return::_id_1CA9;
      }
    case "fso":
      if(var_0 == 0) {
        return::_id_1CAA;
      } else {
        return::_id_1CAB;
      }
    default:
  }

  return;
}

_id_1C9E(var_0) {
  switch (level._id_1338) {
    case "ranger":
      return::_id_1CAC;
    case "seal":
      return::_id_1CAD;
    case "arctic":
      return::_id_1CAE;
    case "woodland":
      return::_id_1CAF;
    case "desert":
      return::_id_1CB0;
    case "ghillie":
      return::_id_1CB1;
    case "delta":
      return::_id_1CB2;
    case "sas":
      return::_id_1CB3;
    case "hijack":
      if(var_0 == 0) {
        return::_id_1CB4;
      } else {
        return::_id_1CB5;
      }
    case "fso":
      if(var_0 == 0) {
        return::_id_1CB6;
      } else {
        return::_id_1CB7;
      }
  }

  return;
}

_id_1C9F() {
  switch (level._id_1338) {
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

_id_1CA0() {
  self setModel("coop_body_us_army");
  self attach("coop_head_us_army", "", 1);
}

_id_1CA1() {
  self setModel("coop_body_seal_udt");
  self attach("coop_head_seal_udt", "", 1);
}

_id_1CA2() {
  self setModel("coop_body_tf141_arctic");
  self attach("coop_head_tf141_arctic", "", 1);
}

_id_1CA3() {
  self setModel("coop_body_tf141_forest");
  self attach("coop_head_tf141_forest", "", 1);
}

_id_1CA4() {
  self setModel("coop_body_tf141_desert");
  self attach("coop_head_tf141_desert", "", 1);
}

_id_1CA5() {
  self setModel("coop_body_ghillie_forest");
  self attach("coop_head_ghillie_forest", "", 1);
}

_id_1CA6() {
  self setModel("mp_body_delta_elite_assault_bb");
  self attach("head_delta_elite_a", "", 1);
}

_id_1CA7() {
  self setModel("body_mp_sas_urban_specops");
}

_id_1CA8() {
  self setModel("mp_body_henchmen_assault_d");
  self attach("head_henchmen_a", "", 1);
}

_id_1CA9() {
  self setModel("mp_body_henchmen_shotgun_a");
  self attach("head_henchmen_c", "", 1);
}

_id_1CAA() {
  self setModel("mp_body_fso_vest_c_dirty");
  self attach("head_fso_e_dirty", "", 1);
}

_id_1CAB() {
  self setModel("mp_body_fso_vest_d_dirty");
  self attach("head_fso_d_dirty", "", 1);
}

_id_1CAC() {
  precachemodel("coop_body_us_army");
  precachemodel("coop_head_us_army");
}

_id_1CAD() {
  precachemodel("coop_body_seal_udt");
  precachemodel("coop_head_seal_udt");
}

_id_1CAE() {
  precachemodel("coop_body_tf141_arctic");
  precachemodel("coop_head_tf141_arctic");
}

_id_1CAF() {
  precachemodel("coop_body_tf141_forest");
  precachemodel("coop_head_tf141_forest");
}

_id_1CB0() {
  precachemodel("coop_body_tf141_desert");
  precachemodel("coop_head_tf141_desert");
}

_id_1CB1() {
  precachemodel("coop_body_ghillie_forest");
  precachemodel("coop_head_ghillie_forest");
}

_id_1CB2() {
  precachemodel("mp_body_delta_elite_assault_bb");
  precachemodel("head_delta_elite_a");
}

_id_1CB3() {
  precachemodel("body_mp_sas_urban_specops");
}

_id_1CB4() {
  precachemodel("mp_body_henchmen_assault_d");
  precachemodel("head_henchmen_a");
}

_id_1CB5() {
  precachemodel("mp_body_henchmen_shotgun_a");
  precachemodel("head_henchmen_c");
}

_id_1CB6() {
  precachemodel("mp_body_fso_vest_c_dirty");
  precachemodel("head_fso_e_dirty");
}

_id_1CB7() {
  precachemodel("mp_body_fso_vest_d_dirty");
  precachemodel("head_fso_d_dirty");
}