/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena_evo_tourney_loot.gsc
***********************************************************/

_id_985B() {
  scripts\mp\gametypes\br_weapons::_id_29FC();
  scripts\mp\gametypes\br_pickups::_id_2A96();
  scripts\mp\gametypes\br_lootcache::_id_2BE7();
  _id_07A1::_id_CECB(::_id_989B);
  _id_07A1::_id_CEC6(::_id_989B);
  level._id_CAB3 = "arena_evo_plunder_box";
  level._id_CAB5 = "scriptable_arena_evo_plunder_box";
  level.s4_armory_kiosk_scriptable_names = ["scriptable_arena_evo_plunder_box_support", "scriptable_arena_evo_plunder_box_weapons", "scriptable_arena_evo_plunder_box_equipment", "scriptable_arena_evo_plunder_box_perks"];
  level._id_CAB1 = scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2;
  level._id_1A93 = ["comm", "unco", "rare", "epic", "lege"];
  var_0 = [];

  if(isDefined(level.s4_armory_kiosk_scriptable_names)) {
    foreach(var_2 in level.s4_armory_kiosk_scriptable_names) {
      var_0 = scripts\engine\utility::array_combine(var_0, _func_03C0(var_2, "classname"));
    }
  } else
    var_0 = _func_03C0(level._id_CAB5, "classname");

  var_4 = 0;
  var_5 = [2, 3, 4, 5];

  foreach(var_7 in var_0) {
    var_7 setscriptablepartstate(level._id_CAB3, "visible");
    var_8 = var_5[var_4 % var_5.size];

    switch (var_7.classname) {
      case "scriptable_arena_evo_plunder_box_weapons":
        var_8 = 2;
        break;
      case "scriptable_arena_evo_plunder_box_equipment":
        var_8 = 3;
        break;
      case "scriptable_arena_evo_plunder_box_perks":
        var_8 = 4;
        break;
      case "scriptable_arena_evo_plunder_box_support":
        var_8 = 5;
        break;
      default:
        var_8 = 2;
        break;
    }

    if(isDefined(var_8)) {
      var_7._id_AC30 = var_8;
    }

    var_7._id_10417 = 1;
  }

  level._id_1A7D = [];

  foreach(var_7 in var_0) {
    var_11 = "v_ui_icon_championhill_buystations_equipment_01";

    if(isDefined(var_7._id_AC30)) {
      switch (var_7._id_AC30) {
        case 2:
          var_11 = "v_ui_icon_championhill_buystations_weapons_01";
          break;
        case 4:
          var_11 = "v_ui_icon_championhill_buystations_perk_01";
          break;
        case 5:
          var_11 = "v_ui_icon_championhill_buystations_killstreak_01";
          break;
        case 3:
        default:
          var_11 = "v_ui_icon_championhill_buystations_equipment_01";
          break;
      }
    }

    var_12 = var_7.origin + (0, 0, 50);
    var_13 = _id_07F9::_id_C57D(99);
    _id_07F9::_id_A867(var_13, "current", var_12, var_11);
    _func_0176(var_13, 0);
    _func_0178(var_13, 0);
    _func_017A(var_13, 1);
    _func_018E(var_13, 1);
    _func_018B(var_13);
    _func_018C(var_13);
    var_7._id_A908 = var_13;
    level._id_1A7D[level._id_1A7D.size] = var_13;
  }

  _id_8112();
  _id_38C5();
  _id_1A85("arena_evo_loot_extra_life", "groundLoot_special", ::_id_1ADC);
  _id_1A85("brloot_armor_plate_full", "groundLoot_special", ::_id_1ADF);
  _id_1A85("arena_evo_loot_armor", "groundLoot", ::_id_1AE0);
  _id_1A85("arena_evo_loot_cash", "groundLoot", ::_id_1AE1);
  _id_1A85("arena_evo_loot_cash_extra", "groundLoot_handicap", ::_id_1AE2);
  _id_1A85("arena_evo_loot_ammo", "groundLoot", ::_id_1ADE);
  arenatournament_initialize_weapon_loot();
  _id_1A85("equip_frag", "equipmentLoot");
  _id_1A85("equip_gammon_bomb", "equipmentLoot");
  _id_1A85("equip_throwing_knife", "equipmentLoot");
  _id_1A85("equip_gas_grenade", "tacticalLoot");
  _id_1A85("equip_at_mine_stun", "tacticalLoot");
  _id_1A85("equip_concussion", "tacticalLoot");
  _id_1A85("specialty_van_demolition", "perkLoot");
  _id_1A85("specialty_tracker", "perkLoot");
  _id_1A85("specialty_hustle", "perkLoot");
  _id_1A85("specialty_scout", "perkLoot");
  _id_1A85("specialty_tac_mask", "perkLoot");
  _id_1A85("specialty_surveillance", "perkLoot");
  _id_1A85("specialty_van_demolition", "perkLoot");
  _id_1A85("specialty_code_breaker", "perkLoot");
  _id_1A85("uav", "killstreak", ::_id_1AE8);
  _id_1A85("loadout", "killstreak", ::_id_1AE5);
  _id_1A85("s4_la_walpha2_mp", "killstreak", ::_id_1AE7);
  _id_1A85("flamethrower", "killstreak", ::_id_1AE4);
  _id_1A85("v2_rocket", "killstreak", ::_id_1AE3);
  _id_1A85("lmg_streak", "killstreak", ::arenatournament_loot_give_player_lmg_streak);
}

arenatournament_initialize_weapon_loot() {
  var_0 = "mp/arenaEvoKioskPurchases.csv";

  for(var_1 = 0; var_1 < tablelookupgetnumrows(var_0); var_1++) {
    var_2 = tablelookupbyrow(var_0, var_1, 1);

    if(!scripts\engine\utility::is_equal(var_2, "weapon")) {
      continue;
    }
    var_3 = tablelookupbyrow(var_0, var_1, 2);
    var_4 = scripts\mp\utility\script::_id_EA63(var_3, "_mp");
    _id_1A85(var_3, "weaponLoot", "chloot_weapon_" + var_4);
  }
}

_id_0EBF(var_0, var_1) {
  var_2 = level._id_1A7F[var_1]._id_989A;

  if(var_2 == "groundLoot" || var_2 == "killstreak" || var_2 == "groundLoot_handicap" || var_2 == "groundLoot_special") {
    [[level._id_1A7F[var_1]._id_FE73]](var_0);
  }

  if(var_2 == "weaponLoot") {
    var_0 _id_6F09(var_1);
  }

  if(var_2 == "equipmentLoot") {
    var_0 _id_D160(var_1, "arena_evo_loadout_override_equipment_primary");
    var_0 scripts\mp\equipment::giveequipment(var_1, "primary");
    var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_B61B(1);
  }

  if(var_2 == "tacticalLoot") {
    var_0 _id_D160(var_1, "arena_evo_loadout_override_equipment_secondary");
    var_0 scripts\mp\equipment::giveequipment(var_1, "secondary");
    var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_B61B(1);
  }

  if(var_2 == "perkLoot") {
    _id_1AE6(var_0, var_1);
    var_0 _id_10B0(::_id_1AE6, 1, var_1);
    var_0 setclientomnvar("ui_arena_evo_display_perk_info", gettime());
  }
}

_id_38B6() {
  var_0 = self;
  var_0 _id_D160("s4_me_fists", "arena_evo_loadout_override_primary");
  var_0 _id_D160("none", "arena_evo_loadout_override_secondary");
  var_0 _id_D160("none", "arena_evo_loadout_override_equipment_primary");
  var_0 _id_D160("none", "arena_evo_loadout_override_equipment_secondary");
}

_id_D160(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2._id_1A7E)) {
    var_2._id_1A7E = [];
  }

  var_2._id_1A7E[var_1] = var_0;
}

_id_6365(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_1A7E)) {
    return undefined;
  }

  if(!isDefined(var_1._id_1A7E[var_0])) {
    return undefined;
  }

  return var_1._id_1A7E[var_0];
}

_id_1A85(var_0, var_1, var_2) {
  if(!isDefined(level._id_1A7F)) {
    level._id_1A7F = [];
  }

  if(!isDefined(level._id_1A7F["groundLoot"])) {
    level._id_1A7F["groundLoot"] = [];
  }

  if(!isDefined(level._id_1A7F["groundLoot_handicap"])) {
    level._id_1A7F["groundLoot_handicap"] = [];
  }

  if(!isDefined(level._id_1A7F["weaponLoot"])) {
    level._id_1A7F["weaponLoot"] = [];
  }

  if(!_id_1AFE(var_0)) {
    return;
  }
  if(_id_8B09(var_1)) {
    if(!isDefined(level._id_10CE3)) {
      level._id_10CE3 = [];
    }

    level._id_10CE3[var_0] = var_2;
  }

  level._id_1A7F[var_0] = spawnStruct();
  level._id_1A7F[var_0]._id_CF25 = var_0;
  level._id_1A7F[var_0]._id_989A = var_1;

  if(!_id_8B09(var_1)) {
    level._id_1A7F[var_0]._id_FE73 = var_2;
  }

  if(scripts\engine\utility::is_equal(var_1, "groundLoot")) {
    level._id_1A7F["groundLoot"] = ::scripts\engine\utility::array_add(level._id_1A7F["groundLoot"], level._id_1A7F[var_0]);
  }

  if(scripts\engine\utility::is_equal(var_1, "groundLoot_handicap")) {
    level._id_1A7F["groundLoot_handicap"] = ::scripts\engine\utility::array_add(level._id_1A7F["groundLoot_handicap"], level._id_1A7F[var_0]);
  }

  if(scripts\engine\utility::is_equal(var_1, "weaponLoot")) {
    level._id_1A7F["weaponLoot"] = ::scripts\engine\utility::array_add(level._id_1A7F["weaponLoot"], level._id_1A7F[var_0]);
  }
}

_id_1AFE(var_0) {
  return !getdvarint(_func_0483("#x3a6cb326c2b1c3587", var_0), 0);
}

_id_989B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(_func_010D(var_1, "chloot_weapon")) {
    thread _id_0848::_id_DEF9(var_1, var_3);
  }

  if(!isDefined(level._id_1A7F[var_1])) {
    return;
  }
  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_3)) {
    return;
  }
  var_6 = level._id_1A7F[var_1];

  if(_id_8883(var_6._id_989A) || _id_88F2(var_6._id_989A) || var_6._id_989A == "groundLoot_handicap") {
    if(var_6._id_CF25 == "arena_evo_loot_cash" || var_6._id_CF25 == "arena_evo_loot") {
      var_3 playlocalsound("ui_mp_ch_money_pickup");
    } else if(var_6._id_CF25 == "arena_evo_loot_ammo") {
      var_3 playlocalsound("ui_mp_ch_ammo_pickup");
    } else {
      var_3 playlocalsound("ui_mp_ch_grenade_pickup");
    }
  }

  if(isDefined(var_6._id_FE73)) {
    level thread _id_0EBF(var_3, var_6._id_CF25);
  } else {
    var_3 scripts\mp\gametypes\arena_evo_tourney_util::_id_B61B();
  }

  if(!_func_0458(var_0) && isDefined(var_0._id_2C2C)) {
    var_0 scripts\mp\gametypes\br_pickups::_id_478B();
  }
}

_id_8883(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "groundLoot":
      var_1 = 1;
      break;
    default:
      break;
  }

  return var_1;
}

_id_88F2(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "killstreak":
      var_1 = 1;
      break;
    default:
      break;
  }

  return var_1;
}

_id_8B09(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "weaponLoot":
      var_1 = 1;
      break;
    default:
      break;
  }

  return var_1;
}

_id_0CEB(var_0, var_1) {
  var_2 = self;
  var_3 = -1;

  switch (var_0) {
    case "uav":
      var_3 = 0;
      break;
    case "s4_la_walpha2_mp":
      var_3 = 1;
      break;
    case "flamethrower":
      var_3 = 2;
      break;
    case "loadout":
      var_3 = 3;
      break;
    case "lmg_streak":
      var_3 = 4;
      break;
  }

  if(var_3 != -1) {
    var_2 _meth_82F8("ui_arena_evo_active_killstreak", var_3, var_1);
  }
}

_id_1ADD(var_0) {
  var_0 scripts\mp\utility\perk::_id_6FC2("specialty_tracker");
  var_0 thread scripts\mp\hud_message::showsplash("br_specialty_tracker");
}

_id_1AE8(var_0) {
  var_0 _id_10B0(::_id_1AEA, 0, "uav", 1);
  var_0 _id_0CEB("uav", 1);
  var_0 setclientomnvar("ui_arena_evo_killstreak_max_uavs", int(arenatournament_at_max_uavs(var_0.pers["team"])));
}

_id_1ADC(var_0) {
  var_1 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6714(var_0.pers["team"]);

  if(var_1 == getdvarint("#x32ae7460af7e83048", 12)) {
    var_2 = getdvarint("#x3820a0fdba3084df1", 750);
    _id_1AC6(var_0, var_2);
    thread _id_0848::snd_mp_champ_hill_money_get(var_0);
    return;
  }

  if(arenatournament_bring_back_teammate(var_0)) {
    thread _id_0848::snd_mp_champ_hill_1up_get(var_0, var_0.pers["team"]);
    return;
  }

  scripts\mp\gametypes\arena_evo_tourney_util::_id_C441(var_0.pers["team"], -1);

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(!isDefined(var_0._id_E75F)) {
      var_0._id_E75F = 1;
    } else {
      var_0._id_E75F = var_0._id_E75F + 1;
    }

    var_0 setclientomnvar("ui_arena_evo_stat_extra_lives", var_0._id_E75F);
    thread _id_0848::snd_mp_champ_hill_1up_get(var_0, var_0.pers["team"]);
  }
}

arenatournament_bring_back_teammate(var_0) {
  foreach(var_0 in scripts\engine\utility::array_randomize(scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_0.pers["team"]))) {
    if(!var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_8675()) {
      var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_5217();
      var_0 thread scripts\mp\playerlogic::_id_E285();
      return 1;
    }
  }

  return 0;
}

_id_1ADF(var_0) {
  var_0 _id_B3A0(3);

  if(!scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(var_0.pers["team"])) {
    var_0 setclientomnvar("ui_arena_armor_picked_up", gettime());
  }
}

_id_1AE0(var_0) {
  var_0 _id_B3A0(1);

  if(!scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(var_0.pers["team"])) {
    var_0 setclientomnvar("ui_arena_armor_picked_up", gettime());
  }
}

_id_1AE1(var_0) {
  var_1 = getdvarint("#x3280803994633f661", 100);
  _id_1AC6(var_0, var_1);
}

_id_1AE2(var_0) {
  var_1 = getdvarint("#x38a9922febd93a758", 500);
  _id_1AC6(var_0, var_1);
}

_id_1ADE(var_0) {
  var_0 scripts\mp\class::_id_C55D();
}

_id_1AE5(var_0) {
  var_0 scripts\mp\class::_id_6FB1(var_0.pers["team"], "custom" + (randomint(10) + 1));
  var_0 _id_0CEB("loadout", 1);
}

_id_1AE7(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056("warmachine", var_0);
  var_0 _id_10B0(::_id_1AEB, 0, "s4_la_walpha2_mp");
  var_0 _id_0CEB("s4_la_walpha2_mp", 1);
  var_0 thread _id_0A66::_id_F7A7(var_1);
}

arenatournament_loot_give_player_lmg_streak(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056("lmg_streak", var_0);
  var_0 _id_10B0(::arenatournament_loot_run_lmg_streak, 0, "lmg_streak");
  var_0 _id_0CEB("lmg_streak", 1);
  var_0 thread _id_0A52::_id_F790(var_1);
}

_id_1AE4(var_0) {
  var_0 _id_09B8::_id_F78E(1);
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056("juggernaut", var_0);
  var_0 _id_10B0(::_id_1AE9, 0, "flamethrower");
  var_0 _id_0CEB("flamethrower", 1);
  setomnvar("ui_arena_evo_killstreak_max_flamethrowers", int(arenatournament_at_max_flamenauts()));
}

_id_1AE3(var_0) {
  scripts\mp\gametypes\arena_evo_tourney_util::freezetimers();
  var_0 _id_0A56::_id_F795();
}

_id_1AEA(var_0, var_1) {
  var_0 _id_CA47("uav");
  level thread scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_CA16(var_0.pers["team"]);
  var_2 = 0;

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(1) == 0) {
    var_2 = int(_func_0142(game["dialog"]["champion_hill_start"]) / 1000) + 2.5;
  }

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(1) == 1) {
    var_2 = int(_func_0142(game["dialog"]["arena_evo_matchup_2"]) / 1000) + 2.5;
  }

  var_3 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(var_0.pers["team"]));

  if(var_3.size > 0) {
    scripts\engine\utility::delaythread(var_2, _id_0A8D::_id_9139, "enemy_activated_uav", var_3);
  }
}

_id_1AE9(var_0, var_1) {
  var_0 _id_CA47("juggernaut");
  var_0 _id_09B8::_id_F78E(1);
}

_id_1AEB(var_0, var_1, var_2) {
  var_0 _id_CA47("warmachine");
  var_0.pers["wmStreakAmmo"] = var_2;
  var_3 = var_0 scripts\cp_mp\utility\killstreak_utility::_id_4056("warmachine", var_0);
  var_0 _id_0A66::_id_F7A7(var_3);
}

arenatournament_loot_run_lmg_streak(var_0, var_1, var_2) {
  var_0 _id_CA47("lmg_streak");
  var_0.pers["mgStreakAmmo"] = var_2;
  var_3 = var_0 scripts\cp_mp\utility\killstreak_utility::_id_4056("lmg_streak", var_0);
  var_0 _id_0A52::_id_F790(var_3);
}

_setperkuiomnvars() {
  var_0 = self;

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0 setclientomnvar("ui_spawn_perk_" + var_1, -1);
  }

  if(isDefined(var_0.arena_evo_perks)) {
    var_2 = 0;

    foreach(var_4 in var_0.arena_evo_perks) {
      var_5 = scripts\mp\perks\perks::_id_6C26(var_4);
      var_0 setclientomnvar("ui_spawn_perk_" + var_2, var_5);
      var_2++;
    }
  }
}

_id_1AE6(var_0, var_1) {
  if(!var_0 scripts\mp\utility\perk::_hasperk(var_1)) {
    var_0 scripts\mp\utility\perk::_id_6FC2(var_1);
  }

  if(!isDefined(var_0.arena_evo_perks)) {
    var_0.arena_evo_perks = [var_1];
  }

  if(!scripts\engine\utility::array_contains(var_0.arena_evo_perks, var_1)) {
    var_0.arena_evo_perks = scripts\engine\utility::array_add(var_0.arena_evo_perks, var_1);
  }

  var_0 _setperkuiomnvars();

  if(scripts\engine\utility::is_equal(var_1, "specialty_van_demolition")) {
    var_0 _id_0A6B::_id_D8D6();
  }
}

_id_CA47(var_0) {
  var_1 = self;
  var_1 thread scripts\mp\hud_message::showsplash(var_0);
}

_id_10B0(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(!isDefined(var_4._id_A4AC)) {
    var_4._id_A4AC = [];
  }

  if(!isDefined(var_4._id_60B8)) {
    var_4._id_60B8 = [];
  }

  var_5 = spawnStruct();
  var_5._id_6016 = var_0;
  var_5._id_AE40 = var_2;

  if(istrue(var_3)) {
    add_to_team_activate_func(var_4.pers["team"], var_5, var_2);
  } else {
    if(istrue(var_1)) {
      var_4._id_60B8 = scripts\engine\utility::array_add(var_4._id_60B8, var_5);
      return;
    }

    var_4._id_A4AC = scripts\engine\utility::array_add(var_4._id_A4AC, var_5);
  }
}

add_to_team_activate_func(var_0, var_1, var_2) {
  if(!isDefined(level.arena_evo_team_activate_funcs)) {
    level.arena_evo_team_activate_funcs = [];
  }

  if(!isDefined(level.arena_evo_team_activate_funcs[var_0])) {
    level.arena_evo_team_activate_funcs[var_0] = spawnStruct();
  }

  if(!isDefined(level.arena_evo_team_activate_funcs[var_0]._id_A4AC)) {
    level.arena_evo_team_activate_funcs[var_0]._id_A4AC = [];
  }

  if(!isDefined(level.arena_evo_team_activate_funcs[var_0]._id_A4AC[var_2])) {
    level.arena_evo_team_activate_funcs[var_0]._id_A4AC[var_2] = var_1;
    level.arena_evo_team_activate_funcs[var_0]._id_A4AC[var_2]._id_011A = 1;
  } else
    level.arena_evo_team_activate_funcs[var_0]._id_A4AC[var_2]._id_011A++;
}

_id_C4EA() {
  var_0 = self;
  var_0 _id_0CEB("uav", 0);
  var_0 _id_0CEB("s4_la_walpha2_mp", 0);
  var_0 _id_0CEB("flamethrower", 0);
  var_0 _id_0CEB("loadout", 0);
  var_0 _id_0CEB("lmg_streak", 0);
  var_0._id_A4AC = [];
}

_id_1AF5() {
  _id_46F3();
  var_0 = spawnStruct();

  for(var_1 = 0; var_1 < 10; var_1++) {
    var_0 _id_1013(var_1 + 1);
  }

  if(!isDefined(level._id_984B)) {
    level._id_984B = spawnStruct();
    level._id_984B._id_9843 = [6, 7, 8, 9, 10];
    level._id_984B.index = 0;
  }

  var_2 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(1);
  var_3 = var_2 + 1;
  var_3 = getdvarint("#x34d0d2c25c39bf451", var_3);

  if(var_3 > var_0._id_7E9E.size) {
    var_4 = var_0._id_7E9E[level._id_984B._id_9843[level._id_984B.index]];
    level._id_984B.index++;

    if(level._id_984B.index >= level._id_984B._id_9843.size) {
      level._id_984B.index = 0;
    }
  } else
    var_4 = var_0._id_7E9E[var_3];

  var_5 = scripts\engine\utility::getStructArray("arena_evo_weapon_drop_struct", "targetname");

  foreach(var_7 in var_5) {
    if(getdvarint("#x38812fec46d9df98f", 0) && scripts\mp\gametypes\arena_evo_tourney_util::_id_88CF() && scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(1) > 0) {
      foreach(var_9 in scripts\engine\utility::getStructArray(var_7.target, "targetname")) {
        _id_E184("arena_evo_loot_cash", var_9.origin);
      }

      continue;
    } else if(scripts\engine\utility::is_equal(var_7.target, "weapon_drops_catwalk")) {
      if(!getdvarint("#x3a0ab70072600d2cb", 0)) {
        continue;
      }
    }

    if(scripts\engine\utility::is_equal(var_7._id_039B, "spawn_all_weapons")) {
      [var_12, var_13] = var_7 _id_E24C();
    } else {
      var_14 = _id_6856(var_4);
      [var_12, var_13] = var_7 _id_E250(var_14, var_2);
      var_13 = "_" + var_13;
    }

    foreach(var_9 in var_12) {
      var_17 = getdvarint("#x3155fb9d88899f0df", 3);

      if(var_17 > 0) {
        if(istrue(var_9._id_87A9)) {
          _id_E184("arena_evo_loot_extra_life", var_9.origin + (0, 0, 10));

          for(var_1 = 0; var_1 < 2; var_1++) {
            if(randomint(100) < getdvarint("#x3d57c609cb03a473", 0)) {
              var_18 = var_9.origin + (64 * cos(randomint(360)), 64 * sin(randomint(360)), 2);
              var_19 = scripts\engine\utility::random(level._id_1A7F["weaponLoot"])._id_CF25;
              var_19 = scripts\mp\utility\script::_id_EA63(var_19, "_mp");
              _id_E184(_id_6739(var_19, ["comm", "unco"]), var_18, (0, randomint(360), 0));
            }
          }
        } else {
          for(var_1 = 0; var_1 < randomint(var_17) + 1; var_1++) {
            [var_21, var_22, var_23] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(2 * var_1, var_9.origin, var_9.angles, undefined, undefined, randomint(32) + 32);
            _id_E184("arena_evo_loot_cash", var_21);
          }
        }
      }

      if(!isDefined(var_9._id_039B)) {
        continue;
      }
      if(istrue(var_9._id_87A9)) {
        var_24 = 1;
      } else {
        var_24 = 1;
      }

      for(var_1 = 0; var_1 < var_24; var_1++) {
        if(!istrue(var_9._id_87A9)) {
          var_18 = var_9.origin + (32 * cos(randomint(360)), 32 * sin(randomint(360)), 0);
        } else {
          var_18 = var_9.origin;
        }

        var_25 = (0, randomint(360), 0);

        if(getdvarint("#x3a0ab70072600d2cb", 0)) {
          var_25 = (0, 0, 0);
          var_18 = var_9.origin;
        }

        if(!getdvarint("#x3498de0b07ec94c17", 0)) {
          var_26 = _id_E184(var_9._id_039B + var_13, var_18, var_25);
        }
      }
    }
  }
}

_id_46F3() {
  foreach(var_1 in level._id_2A95._id_CF26) {
    if(isDefined(var_1)) {
      var_1 scripts\mp\gametypes\br_pickups::_id_478B();
    }
  }
}

_id_B3A0(var_0) {
  var_1 = self;
  var_0 = var_0 * 25;

  if(!isDefined(var_1._id_9457) || var_1._id_9457 == 0) {
    _id_07EA::_id_9453(var_1, var_0, 0);
    self setclientomnvar("ui_light_armor_state", 1);
    thread _id_0A15::_id_E806();
  } else {
    var_2 = var_1._id_9457 + var_0;

    if(var_2 > 75) {
      var_2 = 75;
    }

    _id_07EA::_id_9453(var_1, var_2, 0);
  }
}

_id_E250(var_0, var_1) {
  var_2 = self;
  var_3 = _func_0204(scripts\engine\utility::getStructArray(var_2.target, "targetname"), var_2.origin);
  var_3[0]._id_87A9 = 1;

  foreach(var_5 in var_3) {
    var_5._id_039B = _id_683A(var_2, var_0);
  }

  var_7 = "comm";

  if(var_1 > getdvarint("#x3d596fa23a7397e91", 0)) {
    var_7 = "unco";
  }

  if(var_1 > getdvarint("#x3f96acd98eab150e4", 3)) {
    var_7 = "rare";
  }

  if(var_1 > getdvarint("#x32b1b1ad8a5a04037", 5)) {
    var_7 = "epic";
  }

  var_8 = getDvar("#x3cdd4fed5face016a", "");

  if(var_8 != "") {
    var_7 = "_" + var_8;
  }

  var_9 = var_7;
  return [var_3, var_9];
}

_id_E24C() {
  var_0 = self;

  if(!isDefined(var_0._id_E436)) {
    var_0._id_E436 = [];
    var_1 = 64;
    var_2 = var_1 / 2 * level._id_10CE3.size;
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in level._id_10CE3) {
      var_3++;

      foreach(var_4, var_8 in level._id_1A93) {
        var_9 = getDvar("#x3cdd4fed5face016a", "");

        if(var_9 != "") {
          var_8 = var_9;
        }

        var_10 = spawnStruct();
        var_10.origin = var_0.origin + (var_3 * var_1 - var_2, var_4 * var_1 - var_2, 0);
        var_0._id_E436[var_0._id_E436.size] = var_10;
        var_10._id_039B = var_6 + "_" + var_8;
      }
    }

    var_3++;
    var_4 = 0;
    var_12 = scripts\engine\utility::array_combine(level._id_1A7F["groundLoot"], level._id_1A7F["groundLoot_handicap"]);
    var_12 = scripts\engine\utility::array_add(var_12, level._id_1A7F["arena_evo_loot_extra_life"]);

    foreach(var_14 in var_12) {
      var_4++;
      var_10 = spawnStruct();
      var_10.origin = var_0.origin + (var_3 * var_1 - var_2, var_4 * var_1 - var_2, 0);
      var_0._id_E436[var_0._id_E436.size] = var_10;
      var_10._id_039B = var_14._id_CF25;
    }
  }

  var_16 = var_0._id_E436;
  var_17 = "";
  return [var_16, var_17];
}

_id_8112() {
  var_0 = "mp/upgradetable_arena_evo.csv";
  var_1 = 1;
  var_2 = 1;

  if(!_func_0221(var_0)) {
    return;
  }
  if(!isDefined(level._id_1A8F)) {
    level._id_1A8F = [];
    level._id_1A92 = [];
    level._id_1A90 = [];

    for(var_3 = var_1; var_3 < _func_0225(var_0); var_3 = var_3 + 2) {
      var_4 = tablelookupbyrow(var_0, 0, var_3);
      var_5 = tablelookupbyrow(var_0, 0, var_3 + 1);

      if(!isDefined(level._id_1A8F[var_4])) {
        level._id_1A8F[var_4] = [var_4];
      }

      if(!isDefined(level._id_1A92[var_4])) {
        level._id_1A92[var_4] = [var_4];
      }

      level._id_1A92[var_4] = tablelookupbyrow(var_0, 1, var_3);

      for(var_6 = var_2; var_6 < tablelookupgetnumrows(var_0); var_6++) {
        if(!isDefined(level._id_1A90[var_4])) {
          level._id_1A90[var_4] = [];
        }

        var_7 = tablelookupbyrow(var_0, var_6, var_3);

        if(scripts\engine\utility::is_equal(var_7, "none")) {
          break;
        }

        level._id_1A8F[var_4][level._id_1A8F[var_4].size] = var_7;
        var_8 = int(tablelookupbyrow(var_0, var_6, var_3 + 1));

        if(!isDefined(level._id_1A90[var_4][var_7])) {
          level._id_1A90[var_4][var_7] = var_8;
        }

        level._id_1A90[var_4]["weapon_level_" + var_6] = level._id_1A93[var_8 - 1];
      }
    }
  }
}

is_valid_loadout_weapon(var_0) {
  var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");
  return isDefined(level._id_1A8F[var_0]);
}

_id_38C5() {
  foreach(var_14, var_1 in level._id_2A77) {
    if(isDefined(level._id_1A8F[var_1._id_232D])) {
      var_2 = var_1._id_5FFA;
      var_3 = level._id_2A95._id_2A65[var_14];
      var_4 = strtok(var_2, "+");
      var_5 = [];

      foreach(var_7 in level._id_1A8F[var_1._id_232D]) {
        if(var_7 == var_1._id_232D) {
          continue;
        }
        var_8 = level._id_1A90[var_1._id_232D][var_7] - 1;

        if(var_8 > var_3 && scripts\engine\utility::array_contains(var_4, var_7)) {
          var_5[var_5.size] = var_7;
        }
      }

      var_10 = var_1._id_5FFB;

      foreach(var_12 in var_5) {
        var_10 = var_10 _meth_866A(var_12);
      }

      level._id_2A77[var_14]._id_5FFB = var_10;
      level._id_2A77[var_14]._id_5FFA = getcompleteweaponname(var_10);
    }
  }
}

_id_6F09(var_0) {
  var_1 = self;
  var_2 = makeweapon(var_0);
  var_3 = var_1 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_0);
  var_4 = var_1 _id_1AD3(var_2, 0, var_3);

  foreach(var_6 in var_1 getweaponslistprimaries()) {
    if(!is_valid_loadout_weapon(var_6.basename)) {
      var_1 takeweapon(var_6);
    }
  }

  if(var_1 getweaponslistprimaries().size >= 2) {
    var_1 takeweapon(var_1 getcurrentprimaryweapon());
  }

  var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_4);
  var_8 = var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_4, 1);
  var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_B61B();

  if(!var_1 _id_1AD5(var_0)) {
    var_1 _id_1AF6(var_0, 0);
    var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_1AF7(var_0);
  }
}

_id_683A(var_0, var_1) {
  var_2 = getDvar("#x39a37f9ec09d582cc", "");

  if(var_2 != "" && isDefined(level._id_10CE3[var_2])) {
    return level._id_10CE3[var_2];
  }

  if(isDefined(var_1)) {
    if(!isDefined(var_1.weapons) || var_1.weapons.size == 0) {
      return undefined;
    }

    if(isDefined(var_1._id_338E) && var_1._id_338E != "") {
      var_3 = var_1._id_338E;
      var_1._id_338E = undefined;
      return level._id_10CE3[var_3];
    }

    if(isDefined(var_1.weapons)) {
      var_1._id_10DD8++;

      if(isDefined(var_1._id_9C5F) && var_1._id_9C5F != -1 && var_1._id_10DD8 >= var_1._id_9C5F) {
        return undefined;
      }

      var_4 = var_1.weapons[var_1._id_10DD0];
      var_1._id_10DD0++;

      if(var_1._id_10DD0 >= var_1.weapons.size) {
        var_1._id_10DD0 = 0;
      }

      return level._id_10CE3[var_4];
    }
  }

  return scripts\engine\utility::random(level._id_10CE3);
}

_id_1013(var_0) {
  if(!isDefined(self._id_7E9E)) {
    self._id_7E9E = [];
  }

  var_1 = 0;
  var_2 = [];

  for(var_3 = 0; var_3 < 8; var_3++) {
    var_4 = getDvar(_func_0483("#x3d23c6d036872110a", scripts\engine\utility::_id_EA52(var_0), "_", scripts\engine\utility::_id_EA52(var_3 + 1)), "");

    if(var_4 != "") {
      if(!var_1) {
        var_2 = [];
        var_1 = 1;
      }

      var_2[var_2.size] = var_4;
    }
  }

  var_5 = getdvarint(_func_0483("#x3d23c6d036872110a", scripts\engine\utility::_id_EA52(var_0), "_count"), -1);
  var_6 = getDvar(_func_0483("#x3d23c6d036872110a", scripts\engine\utility::_id_EA52(var_0), "_center"), "");
  self._id_7E9E[var_0] = spawnStruct();
  self._id_7E9E[var_0].weapons = var_2;
  self._id_7E9E[var_0]._id_9C5F = var_5;
  self._id_7E9E[var_0]._id_338E = var_6;
  self._id_7E9E[var_0]._id_10DD8 = 0;
  self._id_7E9E[var_0]._id_10DD0 = 0;
}

_id_6856(var_0) {
  var_1 = spawnStruct();
  var_1.weapons = var_0.weapons;
  var_1._id_9C5F = var_0._id_9C5F;
  var_1._id_338E = var_0._id_338E;
  var_1._id_10DD8 = 0;
  var_1._id_10DD0 = 0;
  return var_1;
}

_id_B3F5() {
  var_0 = self;
  var_0 setclientomnvar("ui_base_purchase_menu_response", 2);
  var_0 setclientomnvar("ui_base_open_purchase_menu", 0);
}

_id_E1C0(var_0, var_1) {
  var_2 = self;
  var_3 = getgroundposition(var_2.origin + (0, 0, 12), 4) + (0, 0, 12);
  var_4 = 0;
  var_5 = [];
  var_6 = 32;
  var_7 = randomint(360);

  if(level._id_1A7F["groundLoot"].size == 0) {
    return;
  }
  var_8 = var_2 _id_6565(var_0);
  var_9 = 6;
  var_10 = 0;
  var_11 = [];

  for(var_12 = 0; var_12 < var_8.size; var_12++) {
    if(!isDefined(var_11[var_10])) {
      var_11[var_10] = [];
    }

    var_11[var_10][var_11[var_10].size] = var_8[var_12];

    if(var_11[var_10].size >= var_9) {
      var_10++;
    }
  }

  if(var_8.size > 0) {
    for(var_13 = 0; var_13 < var_11.size; var_13++) {
      var_14 = 360 / var_11[var_13].size;
      var_4 = var_13 * 32;

      foreach(var_12, var_16 in scripts\engine\utility::array_randomize(var_11[var_13])) {
        var_17 = (var_6 + var_4) * cos(var_14 * var_12 + var_7);
        var_18 = (var_6 + var_4) * sin(var_14 * var_12 + var_7);
        var_19 = 0;
        var_20 = var_3 + (var_17, var_18, var_19);

        if(var_16._id_989A == "weaponLoot") {
          _id_E184(_id_6739(var_16._id_CF25, scripts\mp\gametypes\arena_evo_tourney_weapon_util::arenatournament_get_weapon_rarity_from_level(var_16._id_CF25, var_16.weaponlevel)), var_20, (0, randomint(360), 0), undefined, var_2, var_12);
          continue;
        }

        var_21 = undefined;

        if(!isDefined(var_1) || var_1 == self) {
          var_21 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(var_2.pers["team"]);
        } else {
          var_21 = var_1.pers["team"];
        }

        _id_E184(var_16._id_CF25, var_20, (0, randomint(360), 0), var_21, var_2, var_12);
      }
    }
  }
}

_id_6565(var_0) {
  var_1 = self;

  if(istrue(var_0)) {
    if(getdvarint("#x3fc7767e7be41b7c2", 1)) {
      var_2 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_1.pers["team"]);
      var_3 = [];

      foreach(var_5 in var_2) {
        foreach(var_7 in var_5._id_1A7E) {
          var_8 = var_7 + "_mp";

          if(isDefined(level._id_1A7F[var_8])) {
            var_9 = level._id_1A7F[var_8];
            var_9.weaponlevel = var_5 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_8);
            var_3 = scripts\engine\utility::array_add(var_3, var_9);
          }
        }
      }

      var_12 = 0;

      foreach(var_5 in var_2) {
        var_12 = var_12 + var_5._id_8D70;
      }

      var_15 = int(var_12 / 100);
      var_15 = min(10, var_15);

      for(var_16 = 0; var_16 < var_15; var_16++) {
        var_3 = scripts\engine\utility::array_add(var_3, level._id_1A7F["arena_evo_loot_cash"]);
      }

      var_17 = 0;

      foreach(var_5 in var_2) {
        if(isDefined(var_5._id_9457)) {
          var_17 = var_17 + var_5._id_9457;
        }
      }

      var_20 = int(var_17 / 25);

      for(var_16 = 0; var_16 < var_20; var_16++) {
        var_3 = scripts\engine\utility::array_add(var_3, level._id_1A7F["arena_evo_loot_armor"]);
      }
    } else {
      var_3 = [];

      for(var_16 = 0; var_16 < 3; var_16++) {
        var_21 = scripts\engine\utility::array_randomize(level._id_1A7F["weaponLoot"]);
        var_21 = scripts\engine\utility::_id_1BD4(var_21, 0, 3);
        var_22 = scripts\engine\utility::array_randomize(level._id_1A7F["groundLoot"]);
        var_23 = scripts\engine\utility::array_combine(var_22, var_21);
        var_3 = scripts\engine\utility::array_combine(var_3, var_23);
      }
    }
  } else {
    var_3 = scripts\engine\utility::_id_1BD4(scripts\engine\utility::array_randomize(level._id_1A7F["groundLoot"]), 0, randomint(level._id_1A7F["groundLoot"].size + 1));

    if(var_3.size == 0) {
      var_3 = [scripts\engine\utility::random(level._id_1A7F["groundLoot"])];
    }

    var_24 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(var_1.pers["team"]);

    if(_id_DB33(var_24)) {
      var_3 = scripts\engine\utility::array_add(var_3, scripts\engine\utility::random(level._id_1A7F["groundLoot_handicap"]));
    }
  }

  return var_3;
}

_id_DB33(var_0) {
  var_1 = _id_64D9(var_0);
  return randomfloat(1) < var_1;
}

_id_64D9(var_0) {
  var_1 = -1;
  var_2 = undefined;
  var_3 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6714(var_0);

  foreach(var_5 in scripts\mp\gametypes\arena_evo_tourney_util::_id_67CA()) {
    var_6 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6714(var_5);

    if(var_6 > var_1) {
      var_1 = var_6;
      var_2 = var_5;
    }
  }

  if(scripts\engine\utility::is_equal(var_0, var_2)) {
    return 0;
  }

  var_8 = var_1 - var_3;

  if(var_8 > getdvarint("#x327b1e43915afabcf", 10)) {
    return getdvarfloat("#x355ca0d8cf969abd1", 0.9);
  }

  if(var_8 > getdvarint("#x327b1e53915afae02", 5)) {
    return getdvarfloat("#x355ca0a8cf969a538", 0.5);
  }

  if(var_8 > getdvarint("#x327b1e63915afb035", 3)) {
    return getdvarfloat("#x355ca0b8cf969a76b", 0.3);
  }

  return 0.0;
}

_id_6739(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = ["epic", "lege"];
  }

  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  }

  var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");
  var_0 = "chloot_weapon_" + var_0 + "_" + scripts\engine\utility::random(var_1);
  return var_0;
}

_id_E184(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = (0, randomint(360), 0);
  }

  if(isDefined(var_3)) {
    var_6 = _func_0200(var_3) + 1;
  } else {
    var_6 = undefined;
  }

  if(isDefined(var_4)) {
    var_1 = var_4.origin;
    var_2 = scripts\engine\utility::_id_5CD9(var_4 getplayerangles());
  }

  if(should_adjust_drop_origin(var_0)) {
    if(isDefined(var_5)) {
      [var_1, var_2, var_8] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_5, var_1, var_2, var_4);
    } else {
      var_1 = scripts\engine\utility::_id_5000(var_1 + (0, 0, 8), 50, -200, (0, 0, 1)) + (0, 0, 12);
    }
  }

  var_9 = scripts\mp\gametypes\br_pickups::_id_E336(var_0, var_1, var_2, 0, 1, var_6);
  level thread scripts\mp\gametypes\arena_evo_tourney_util::disablescriptableforalleliminatedplayers(var_9);

  if(isDefined(var_3)) {
    var_9 thread scripts\mp\gametypes\arena_evo_tourney_util::disablescriptableforotherteam(var_3);
  }

  return var_9;
}

should_adjust_drop_origin(var_0) {
  if(scripts\engine\utility::is_equal(var_0, "arena_evo_loot_extra_life")) {
    return 0;
  }

  return 1;
}

_id_0C30(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_1AA4)) {
    var_1._id_1AA4 = [];
  }

  if(!isDefined(var_1._id_1AA4[var_0])) {
    var_1._id_1AA4[var_0] = 0;
  }
}

_id_1AD5(var_0) {
  var_1 = self;

  if(!isDefined(var_1.arenaevousedweapons)) {
    return 0;
  }

  return isDefined(var_1.arenaevousedweapons[var_0]);
}

_id_1AF6(var_0, var_1) {
  var_2 = self;
  var_2 _id_0C30(var_0);
  var_2._id_1AA4[var_0] = var_1;
  var_2.arenaevousedweapons[var_0] = 1;
}

_id_7DC6(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(var_1)) {
    var_3 _id_1AF6(var_0, var_1);
  } else {
    var_3 _id_1AF6(var_0, var_3 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_0) + 1);
  }

  if(istrue(var_2)) {
    var_3 _id_1AF6(var_0, 9);
  }

  var_3 scripts\mp\gametypes\arena_evo_tourney_util::_id_1AF7(var_0);
}

_id_1AFB(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = getweaponbasename(var_0);
  var_5 = 0;

  foreach(var_7 in var_3 getweaponslistprimaries()) {
    if(scripts\engine\utility::is_equal(getweaponbasename(var_7), var_4)) {
      var_3 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_7);
      var_5 = 1;
    }
  }

  var_3 _id_7DC6(var_4, var_1);

  if(var_5) {
    var_3 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
    var_9 = var_3 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);
  }

  var_3 scripts\mp\gametypes\arena_evo_tourney_util::_id_B61B();

  if(isDefined(var_2) && var_2 == 1) {
    var_10 = _func_00D6(var_4, 0, var_4.size - 3);
    var_11 = var_3 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_4);
    var_12 = level._id_1A8F[var_10][var_11];
    var_13 = level._id_1A90[var_10][var_12];
    thread _id_0848::snd_mp_champ_hill_weapon_upgrade_sound(var_13, var_3);
  }
}

_id_1AC6(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = getdvarint("#x33610b465ad259ffa", 100);
  }

  if(!isDefined(var_0._id_8D70)) {
    var_0._id_8D70 = 0;
  }

  if(!isDefined(var_0._id_E772)) {
    var_0._id_E772 = 0;
  }

  var_0._id_8D70 = var_0._id_8D70 + var_1;
  var_0._id_E772 = var_0._id_E772 + var_1;

  if(!istrue(var_3)) {
    var_0 _id_1AED();
  }

  if(istrue(var_4)) {
    var_0._id_8D70 = var_1;
  }

  if(isDefined(var_2)) {
    var_5 = 0;

    if(var_2 == "firstblood") {
      var_5 = 1;
      var_0 thread scripts\mp\hud_message::showsplash("firstblood");
    }

    var_0 thread _id_07CE::_id_8D83(var_2, var_5);
  }

  var_0 thread scripts\mp\rank::_id_CC13(var_1, 0);
  var_0 setclientomnvar("ui_base_current_cash", var_0._id_8D70);
  var_0 setclientomnvar("ui_arena_evo_stat_total_cash", var_0._id_E772);
}

_id_871F(var_0, var_1) {
  var_2 = getweaponbasename(var_1);
  var_3 = _func_00D6(var_2, 0, var_2.size - 3);

  if(!isDefined(level._id_1A8F[var_3])) {
    return 1;
  }

  var_4 = scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_2);

  if(var_4 >= level._id_1A8F[var_3].size - 1 || isDefined(level._id_1A8F[var_3][var_4 + 1]) && level._id_1A8F[var_3][var_4 + 1] == "none") {
    return 1;
  }

  return 0;
}

_id_AD46(var_0, var_1, var_2) {
  var_0 = self;
  var_3 = getweaponbasename(var_1);
  var_4 = var_0 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1A9D(var_1);

  if(getdvarint("#x34ebd08aa191d72d3", 1)) {
    var_5 = scripts\mp\gametypes\arena_evo_tourney_weapon_util::arenatournament_get_weapon_level_from_object(var_1);
    var_6 = 1;

    if(var_0 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_3) < var_5) {
      var_7 = var_0 _id_1AD3(var_1, var_2, var_5);
    } else if(var_4 && !_id_871F(var_0, var_1)) {
      var_7 = var_0 _id_1AD3(var_1, var_2);
      var_5 = undefined;
    } else {
      var_7 = var_0 _id_1AD1(var_1, var_2);
      var_6 = 0;
    }

    if(var_6) {
      if(isDefined(var_5)) {
        var_0 _id_1AFB(var_7, var_5);
      } else {
        var_0 _id_1AFB(var_7);
      }

      var_0._id_DCE5 = 1;
    } else
      var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_1AF7(var_3);
  } else
    var_7 = var_0 _id_1AD1(var_1, var_2);

  var_0._id_1A88 = 1;
  return var_7;
}

_id_AD47(var_0, var_1) {
  var_0 = self;
  return _id_AD46(var_0, var_1, 1);
}

_id_1AF9(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_8D70)) {
    var_0._id_8D70 = 0;
  }

  var_1 = var_0 getcurrentprimaryweapon();
  var_2 = getweaponbasename(var_1);

  if(!isDefined(var_0._id_1AA4[var_2])) {
    return;
  }
  var_3 = var_0 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_2);
  var_4 = getdvarint("#x38e01883363ed7787", 100) * (var_3 + 1);

  if(var_0._id_8D70 < var_4) {
    return;
  }
  var_5 = var_0 _id_1AD3(var_1, 0);

  if(!isDefined(var_5)) {
    return;
  }
  var_0 _id_1AFB(var_5, undefined, 1);
  var_0 _id_1AF0(var_4);
  var_0 _id_1AED();
  var_6 = var_0 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_2);

  if(isDefined(var_6)) {
    var_0 scripts\mp\hud_message::showsplash("weapon_upgrade", var_6);
    scripts\mp\gametypes\arena_evo_tourney_util::arenatournament_dlog_record_purchase_event(var_0, var_2, var_4, var_6, 1);
  }
}

_id_1AEC(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();
  var_2 = getweaponbasename(var_1);
  var_3 = _func_00D6(var_2, 0, var_2.size - 3);

  if(!isDefined(level._id_1A8F) || !isDefined(level._id_1A8F[var_3])) {
    return 0;
  }

  var_4 = var_0 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_2);
  var_5 = getdvarint("#x38e01883363ed7787", 100) * (var_4 + 1);
  return var_4 < level._id_1A8F[var_3].size - 1 && var_0._id_8D70 >= var_5;
}

_id_1AED() {
  var_0 = self;

  if(isbot(var_0)) {
    return;
  }
  if(!istrue(level._id_BB9D)) {
    return;
  }
  var_1 = _id_1AEC(var_0);

  if(!istrue(var_0._id_C330) && var_1) {
    var_0._id_C330 = 1;
    var_0 thread scripts\mp\gametypes\arena_evo_tourney::_id_1AFC();
  } else if(istrue(var_0._id_C330) && !var_1) {
    var_0._id_C330 = 0;
    var_0 setclientomnvar("ui_arena_remind_upgrades", 0);
    var_0 notify("noLongerAffordUpgrade");
  }
}

_id_1AF0(var_0) {
  var_1 = self;
  var_1._id_8D70 = var_1._id_8D70 - var_0;
  var_1 setclientomnvar("ui_base_current_cash", var_1._id_8D70);
}

_id_1ACF() {
  var_0 = self;

  if(!isDefined(var_0._id_8D70)) {
    var_0._id_8D70 = 0;
  }

  return var_0._id_8D70;
}

_id_1AD1(var_0, var_1) {
  var_2 = self;
  var_3 = getweaponbasename(var_0);
  var_4 = _func_00D6(var_3, 0, var_3.size - 3);
  var_5 = [];

  if(!istrue(var_1)) {
    var_6 = level._id_1A8F[var_4].size;

    if(var_2 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_3) > var_6) {
      var_2 _id_1AF6(var_3, var_6);
    }

    for(var_7 = 0; var_7 < var_2 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_3); var_7++) {
      var_8 = level._id_1A8F[var_4][var_7 + 1];

      if(!isDefined(var_8) || var_8 == "none") {
        break;
      }

      var_5[var_5.size] = var_8;
    }
  }

  var_9 = scripts\mp\class::buildweapon(var_4, var_5, "none", "none", -1);
  return var_9;
}

_id_1AD3(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = getweaponbasename(var_0);
  var_5 = scripts\mp\utility\script::_id_EA63(var_4, "_mp");

  if(!isDefined(level._id_1A8F[var_5])) {
    return;
  }
  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = var_3 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_4) + 1;
  }

  if(_id_871F(var_3, var_0) && !istrue(level._id_5BB5)) {
    level._id_5BB5 = 1;
    var_3 thread _id_0A8D::_id_9137("first_legendary");
  }

  if(var_6 > level._id_1A8F[var_5].size) {
    var_6 = level._id_1A8F[var_5].size;
  }

  var_7 = [];

  if(!istrue(var_1)) {
    for(var_8 = 0; var_8 < var_6; var_8++) {
      var_9 = level._id_1A8F[var_5][var_8 + 1];

      if(!isDefined(var_9) || var_9 == "none") {
        return undefined;
      }

      var_7[var_7.size] = var_9;
    }
  }

  var_10 = scripts\mp\class::buildweapon(var_5, var_7, "none", "none", -1);
  return var_10;
}

_id_AD3D(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_3._id_1A7E)) {
    var_4 = arena_evo_get_weapon_set_array();
    var_5 = scripts\mp\utility\script::_id_EA63(var_4[0], "_mp");
    var_6 = scripts\mp\utility\script::_id_EA63(var_4[1], "_mp");
    var_3 _id_D160(var_5, "arena_evo_loadout_override_primary");
    var_3 _id_D160(var_6, "arena_evo_loadout_override_secondary");
    var_3 _id_D160("equip_frag", "arena_evo_loadout_override_equipment_primary");
    var_3 _id_D160("equip_concussion", "arena_evo_loadout_override_equipment_secondary");
  }

  var_0._id_9683 = _id_6365("arena_evo_loadout_override_primary");
  var_0._id_9692 = _id_6365("arena_evo_loadout_override_secondary");
  var_0._id_9685 = [];
  var_0._id_9694 = [];

  if(var_0._id_9683 != "none") {
    var_0._id_9685 = var_3 _id_656E(var_0._id_9683);
  }

  if(var_0._id_9692 != "none") {
    var_0._id_9694 = var_3 _id_656E(var_0._id_9692);
  }

  var_0._id_966A = _id_6365("arena_evo_loadout_override_equipment_primary");
  var_0._id_966B = _id_6365("arena_evo_loadout_override_equipment_secondary");

  if(istrue(var_2)) {
    var_3 scripts\mp\class::_id_964E(var_0);
  }

  var_3 _id_9641(var_0);
}

get_default_equipment() {
  return ["equip_frag", "equip_concussion"];
}

arena_evo_get_weapon_set_array() {
  var_0 = undefined;

  if(scripts\mp\utility\game::privatematch()) {
    var_0 = getmatchrulesdata("arenaEvoData", "weaponSet");
  } else {
    var_0 = _func_00BE("ui_arena_evo_loadout_select");
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = getDvar(_func_0483("#x351135a76ec19122f", scripts\engine\utility::_id_EA52(var_0)), "");
  var_2 = strtok(var_1, ",");
  return var_2;
}

_id_9641(var_0) {
  var_0._id_968A = scripts\mp\class::buildweapon(var_0._id_9683, var_0._id_9685, "none", "none");
  var_0._id_9688 = getcompleteweaponname(var_0._id_968A);

  if(var_0._id_9692 == "none") {
    var_0._id_9699 = undefined;
    var_0._id_9697 = "none";
  } else {
    var_0._id_9699 = scripts\mp\class::buildweapon(var_0._id_9692, var_0._id_9694, "none", "none");
    var_0._id_9697 = getcompleteweaponname(var_0._id_9699);
  }

  if(var_0._id_967D != "none") {
    self giveweapon(var_0._id_967D);
    self _meth_8514(var_0._id_967D);
  }
}

_id_656E(var_0) {
  var_1 = self;

  if(!isDefined(level._id_1A8F[var_0])) {
    return [];
  }

  var_2 = scripts\mp\class::buildweapon(var_0, [], "none", "none");
  var_3 = var_1 _id_1AD1(var_2);
  return getweaponattachments(var_3);
}

_id_8629(var_0) {
  return scripts\engine\utility::is_equal(var_0, "loadout") || scripts\engine\utility::is_equal(var_0, "s4_la_walpha2_mp") || scripts\engine\utility::is_equal(var_0, "flamethrower") || scripts\engine\utility::is_equal(var_0, "lmg_streak");
}

_id_314F(var_0) {
  var_1 = self;

  if(var_0._id_C189 == "flamethrower" && !var_1 _id_0A50::jugg_arena_evo_canpurchasejuggernaut()) {
    return 0;
  }

  if(var_0._id_C189 == "uav" && !var_1 arenatournament_player_can_purchase_uav()) {
    return 0;
  }

  if(!isDefined(var_1._id_A4AC)) {
    return 1;
  }

  foreach(var_3 in var_1._id_A4AC) {
    var_4 = level._id_1A7F[var_3._id_AE40];

    if(_id_8629(var_4._id_CF25) && _id_8629(var_0._id_C189)) {
      return 0;
    }
  }

  return 1;
}

playerhasitem(var_0) {
  var_1 = self;
  var_2 = var_1._id_A4AC;
  var_3 = var_1._id_60B8;

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  if(!isDefined(var_3)) {
    var_3 = [];
  }

  var_4 = scripts\engine\utility::array_combine(var_2, var_3);

  foreach(var_6 in var_4) {
    if(scripts\engine\utility::is_equal(var_6._id_AE40, var_0)) {
      return 1;
    }
  }

  return 0;
}

run_match_start_funcs() {
  var_0 = self;

  if(isDefined(var_0._id_A4AC)) {
    foreach(var_2 in var_0._id_A4AC) {
      if(isDefined(var_2._id_AE40)) {
        level thread[[var_2._id_6016]](var_0, var_2._id_AE40);
        continue;
      }

      level thread[[var_2._id_6016]](var_0);
    }

    foreach(var_2 in var_0._id_60B8) {
      if(isDefined(var_2._id_AE40)) {
        level thread[[var_2._id_6016]](var_0, var_2._id_AE40);
        continue;
      }

      level thread[[var_2._id_6016]](var_0);
    }

    var_0 _id_C4EA();
  }

  if(isDefined(level.arena_evo_team_activate_funcs) && isDefined(level.arena_evo_team_activate_funcs[var_0.pers["team"]])) {
    foreach(var_2 in level.arena_evo_team_activate_funcs[var_0.pers["team"]]._id_A4AC) {
      if(var_2._id_011A <= 0) {
        continue;
      }
      if(isDefined(var_2.activateonround) && var_2.activateonround == scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(1)) {
        continue;
      }
      var_2._id_011A--;

      if(var_2._id_011A < 0) {
        var_2._id_011A = 0;
      }

      var_2.activateonround = scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(1);

      if(isDefined(var_2._id_AE40)) {
        level thread[[var_2._id_6016]](var_0, var_2._id_AE40);
        continue;
      }

      level thread[[var_2._id_6016]](var_0);
    }
  }

  if(isDefined(var_0.pers["wmStreakAmmo"]) && var_0.pers["wmStreakAmmo"] > 0) {
    _id_1AEB(var_0, 0, var_0.pers["wmStreakAmmo"]);
  }

  if(isDefined(var_0.pers["mgStreakAmmo"]) && var_0.pers["mgStreakAmmo"] > 0) {
    arenatournament_loot_run_lmg_streak(var_0, 0, var_0.pers["mgStreakAmmo"]);
  }
}

arenatournament_at_max_flamenauts() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 playerhasitem("flamethrower")) {
      var_0++;
    }
  }

  return var_0 >= arenatournament_max_flamethrowers();
}

arenatournament_at_max_uavs(var_0) {
  var_1 = arenatournament_get_item_count_for_team(var_0, "uav");
  return var_1 >= arenatournament_max_uavs();
}

arenatournament_max_flamethrowers() {
  return getdvarint("#x390835dfcfcb38ff3", 4);
}

arenatournament_max_uavs() {
  return getdvarint("#x3f9e2bd771234f476", 3);
}

arenatournament_player_can_purchase_uav() {
  return !arenatournament_at_max_uavs(self.pers["team"]);
}

arenatournament_get_item_count_for_team(var_0, var_1) {
  if(!isDefined(level.arena_evo_team_activate_funcs)) {
    return 0;
  }

  if(!isDefined(level.arena_evo_team_activate_funcs[var_0])) {
    return 0;
  }

  if(!isDefined(level.arena_evo_team_activate_funcs[var_0]._id_A4AC)) {
    return 0;
  }

  if(!isDefined(level.arena_evo_team_activate_funcs[var_0]._id_A4AC[var_1])) {
    return 0;
  }

  return level.arena_evo_team_activate_funcs[var_0]._id_A4AC[var_1]._id_011A;
}