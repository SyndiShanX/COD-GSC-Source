/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena_evo_tourney.gsc
******************************************************/

debugscripterrors() {}

init() {
  level.arena_evo_num_matches_until_buy_round = 3;
  level._id_2ACE = 1;
  level._id_DDC2 = 1;
  level._id_10D10 = scripts\mp\gametypes\arena_evo_tourney_loot::_id_AD46;
  level._id_2A9B = spawnStruct();
  level._id_2A9B._id_B967 = 9999;
  scripts\mp\gametypes\arena_evo_tourney_util::_id_1A8B("arena_evo_player_state_intermission");

  if(!getdvarint("#x34ebd08aa191d72d3", 1)) {
    level._id_10D10 = scripts\mp\gametypes\arena_evo_tourney_loot::_id_AD47;
  }

  if(!getdvarint("#x363e4e85c4dfa1392", 1)) {
    level._id_10D10 = undefined;
  }

  scripts\mp\gametypes\arena_evo_tourney_util::_id_D21F();
  level._id_1A91 = [];
  level._id_1A91[level._id_1A91.size] = level._id_1518;
  level._id_1A91[level._id_1A91.size] = level._id_1FEF;
  level._id_1A91[level._id_1A91.size] = "mp_dom_spawn";
  level._id_1A91[level._id_1A91.size] = "mp_tdm_spawn";
  var_0 = getent("arena_evo_spectate_zone", "targetname");

  if(isDefined(var_0)) {
    var_0 thread handle_spectating_players();
  }

  var_1 = getent("arena_evo_full_clip_ent", "targetname");

  if(isDefined(var_1)) {
    var_1 thread handle_solid_state();
  }
}

track_player_projectiles() {
  var_0 = self;
  var_0 thread track_player_projectiles_internal();
}

track_player_projectiles_internal() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 notify("track_player_projectiles_internal");
  var_0 endon("track_player_projectiles_internal");

  for(;;) {
    self waittill("missile_fire", var_1);
    var_0 thread arena_evo_projectile_tracking(var_1);
  }
}

arena_evo_projectile_tracking(var_0) {
  var_1 = self;
  var_0 endon("death");
  var_0 endon("explode");
  var_2 = getdvarint("#x39bbc810defdc99a4", 1);

  if(!var_2) {
    return;
  }
  if(!istrue(level._id_BB9D) || scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_1) || scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(var_1)) {
    return;
  }
  var_3 = 0.2;
  var_4 = getEntArray("arena_evo_grenade_volume", "targetname");
  var_5 = var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_6661();
  var_6 = var_5.arenavolume;

  while(isDefined(var_0)) {
    foreach(var_8 in var_4) {
      if(scripts\engine\utility::is_equal(var_8, var_6)) {
        continue;
      }
      if(_func_011A(var_0.origin, var_8) && !scripts\engine\utility::is_equal(var_1.arenavolume, var_8)) {
        var_0 delete();
        return;
      }
    }

    wait(var_3);
  }
}

handle_solid_state() {
  var_0 = getdvarint("#x31a346059478fef5c", 0);

  if(var_0) {
    self _meth_852B();
  } else {
    self notsolid();
  }
}

handle_spectating_players() {
  for(;;) {
    self waittill("trigger", var_0);

    if(istrue(var_0.isinspectatezone)) {
      continue;
    }
    var_0.isinspectatezone = 1;
    var_0 thread player_handle_spectate_zone(self);
  }
}

player_handle_spectate_zone(var_0) {
  var_1 = self;
  level endon("respawns_started");
  var_2 = getdvarint("#x31a355a61b168cced", 3);
  var_3 = scripts\mp\class::buildweapon("s4_me_fists", [], "none", "none", -1);
  var_1 disableweaponswitch();
  var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);
  var_4 = var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 1);

  while(var_1 istouching(var_0)) {
    for(var_5 = 0; var_5 < var_2; var_5++) {
      waitframe();
    }
  }

  var_6 = var_1 getweaponslistprimaries();
  var_1 enableweaponswitch();
  var_1 takeweapon(var_3);
  var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_6[0], 1);
  var_1.isinspectatezone = 0;
}

_id_1AD6() {
  _func_01B2("v_ui_icon_chapion_hill_weapon_waypoint");
  scripts\mp\gametypes\arena_evo_tourney_loot::_id_985B();
  scripts\mp\gametypes\arena_evo_tourney_util::_id_A44E(1);
  _func_01EA("ui_hide_minimap", !getdvarint("#x38913d7054b641361", 1));
  _id_0AA3::_id_C28D(::_id_1AEE);
  _id_0AA3::_id_C28D(scripts\mp\gametypes\arena_evo_tourney_util::_id_F3DC);
  _id_0AA3::_id_C28D(::track_player_projectiles);
  _id_0A8E::_id_C285(::_id_1AD4);
  scripts\mp\gametypes\arena_evo_tourney_util::_id_C1CC(scripts\mp\gametypes\arena_evo_tourney_util::_id_46F1);
  level._id_1ABF = [];
  scripts\mp\gametypes\arena_evo_tourney_util::_id_81C6("arena_2", 2, "palace", 3);
  scripts\mp\gametypes\arena_evo_tourney_util::_id_81C6("arena_4", 2, "train", 1);
  scripts\mp\gametypes\arena_evo_tourney_util::_id_81C6("arena_market", 2, "market", 4);
  scripts\mp\gametypes\arena_evo_tourney_util::_id_81C6("arena_train_2", 2, "train2", 2);
  scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_81CF();
  level thread _id_1AD7();
  level thread _id_1AF4();
  level thread scripts\mp\gametypes\arena_evo_tourney_util::_id_448B();
  level thread _id_AD41();
  level._id_2A95._id_2A42["brloot_armor_plate"] = "equip_armorplate";
  level._id_CAB6 = scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AF0;
  level._id_CAB2 = scripts\mp\gametypes\arena_evo_tourney_loot::_id_1ACF;
  scripts\mp\gametypes\s4_armory_kiosk::init();
}

_id_AD41() {
  while(level._id_E278.size <= 0) {
    waitframe();
  }

  var_0 = getEntArray("mp_global_intermission", "classname");

  foreach(var_6, var_2 in level._id_E278) {
    foreach(var_5, var_4 in var_2) {
      level._id_E278[var_6][var_5].origin = var_0[0].origin;
      level._id_E278[var_6][var_5].angles = var_0[0].angles;
    }
  }
}

_id_1AEE() {
  var_0 = self;

  if(game["state"] == "postgame") {
    return;
  }
  if(!isDefined(var_0._id_B956)) {
    var_0._id_B956 = 0;
  }

  if(!istrue(var_0._id_75A0)) {
    var_0._id_75A0 = 1;
    var_1 = getdvarint("#x361131db4865b8780", 500);
    scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AC6(var_0, var_1, undefined, 1);
  }

  foreach(var_3 in level._id_2A09) {
    var_0._id_29F9[var_3] = 30;
  }

  if(isbot(var_0)) {
    var_0 thread scripts\mp\gametypes\arena_evo_tourney_util::_id_5E45();
  }

  if(istrue(var_0.isspectating)) {
    var_0 notify("exit_spectate_listener");
    var_0.isspectating = 0;
  }

  var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_1A8A(level._id_1A6B);

  if(!istrue(level._id_BB9D)) {
    var_0._id_0480 = 1;
  }

  var_0._id_AC8A = var_0 getplayerangles();
  var_0 setclientomnvar("ui_hide_minimap", !getdvarint("#x38913d7054b641361", 1));
  var_0 thread scripts\mp\gametypes\arena_evo_tourney_util::_id_F70A();
}

_id_1AEF(var_0) {
  var_1 = self;
  var_1._id_10843 = 0;

  if(isDefined(var_1._id_9458)) {
    _id_07EA::_id_9453(var_1, var_1._id_9458, 0);
    var_1._id_9458 = undefined;
  }

  if(isDefined(var_1._id_E277)) {
    var_1 thread _id_0815::_id_4790();
  }

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_1)) {
    level thread arenatournament_listen_spectate(var_1);
    var_1 thread arenatournament_wait_for_allow_spectate();
    return;
  } else if(scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(var_1))
    var_1 thread arenatournament_wait_for_allow_spectate();
  else {
    var_1 notify("ArenaTournament_Wait_For_Allow_Spectate");
    var_1 setclientomnvar("ui_arena_evo_can_enter_spectate", 0);
  }

  var_1 setclientomnvar("ui_match_start_countdown", -1);
  var_1 setclientomnvar("ui_match_in_progress", 1);
  var_1 setclientomnvar("ui_arena_evo_unscheduled_buy", 0);
  var_1 setclientomnvar("ui_arena_evo_bye", 0);

  if(istrue(var_0)) {
    foreach(var_3 in level._id_EF89) {
      var_4 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67BF(var_3) + 1;
      setomnvar("ui_arena_match_score_team" + var_4, 0);
    }
  } else {
    var_6 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6714(var_1.pers["team"]);
    _id_B277(var_1, var_6, 3);
  }

  if(istrue(var_1._id_DC94)) {
    var_1 setclientomnvar("ui_arena_mod_card", level._id_4168._id_7C8C);
    var_1._id_DC94 = 0;

    if(!scripts\engine\utility::is_equal(level._id_4168._id_C189, "none")) {
      scripts\engine\utility::delaythread(1, _id_0A8D::_id_9139, "mod_card_activated", [var_1]);
    }
  } else if(!istrue(var_1._id_756E) && scripts\mp\gametypes\arena_evo_tourney_util::_id_1A97(var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_6661())) {
    level thread _id_0A8D::_id_9139("keep_fighting", [var_1]);
    var_1._id_756E = 1;
  }

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_88CF() || scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(var_1)) {
    var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_1A8A("arena_evo_player_state_loot_round");
    level thread _id_0A8D::_id_9139("mid_match_buy", [var_1]);
  } else
    var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_1A8A("arena_evo_player_state_playing");

  var_1 thread _id_1ADB();

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(var_1)) {
    level thread arenatournament_listen_spectate(var_1);
    var_1 thread scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_1ACA();

    if(istrue(var_0)) {
      if(!scripts\mp\gametypes\arena_evo_tourney_util::_id_88CF()) {
        var_1 thread scripts\mp\gametypes\arena_evo_tourney_util::_id_CA17();
      }

      foreach(var_8 in level._id_1A7D) {
        _func_0185(var_8, var_1);
      }
    }

    var_1._id_C941 = "spectated_this_round";
  } else {
    foreach(var_8 in level._id_1A7D) {
      _func_0189(var_8, var_1);
    }

    if(!scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_433C()) {
      var_1 thread scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_1AC5();
    }
  }

  var_3 = var_1.pers["team"];

  if(!scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(var_3)) {
    var_1 scripts\mp\gametypes\arena_evo_tourney_loot::run_match_start_funcs();
  }
}

_id_B277(var_0, var_1, var_2) {
  var_3 = getdvarint("#x32ae7460af7e83048", 12);

  if(var_3 >= 15) {
    if(var_1 < 15 && var_1 > 10) {
      scripts\engine\utility::delaythread(var_2, _id_0A8D::_id_9139, "large_amount_lives_remaining", [var_0]);
    }
  }

  if(var_3 >= 10) {
    if(var_1 < 10 && var_1 > 5) {
      scripts\engine\utility::delaythread(var_2, _id_0A8D::_id_9139, "medium_amount_lives_remaining", [var_0]);
    }
  }

  if(var_1 < 6 && var_1 > 0) {
    scripts\engine\utility::delaythread(var_2, _id_0A8D::_id_9139, "ch_" + var_1 + "_lives_left", [var_0]);
  }
}

_id_1AFA(var_0) {
  setomnvar("ui_arena_round_index", var_0);
  setomnvar("ui_arena_match_display_index", scripts\mp\gametypes\arena_evo_tourney_util::_id_6583());
  setomnvar("ui_arena_matches_until_buy_round", scripts\mp\gametypes\arena_evo_tourney_util::_id_6586());

  foreach(var_2 in scripts\mp\gametypes\arena_evo_tourney_util::_id_633A()) {
    var_3 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_2);

    foreach(var_5 in var_3) {
      scripts\mp\gametypes\arena_evo_tourney_util::_id_D354(var_5, var_2);
    }
  }
}

_id_1ACD() {
  var_0 = self;
  var_0 endon("disconnect");
  level endon("game_ended");

  if(istrue(level.gameended)) {
    return;
  }
  var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_1A8A("arena_evo_player_state_intermission");

  if(!istrue(level._id_CA43)) {
    wait 1.5;
  }

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_0)) {
    if(istrue(var_0._id_DC9B)) {
      arenatournament_enter_eliminated_screen(var_0);
      var_0._id_DC9B = 0;
    }
  }

  level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_0, 1, 0.5);
  wait 0.5;
  level._id_91E0 = 5;
  var_0.pers["wmStreakAmmo"] = undefined;
  var_0.pers["mgStreakAmmo"] = undefined;
  var_0.isinspectatezone = 0;
  level notify("respawns_started");

  if(getdvarint("#x3672cd078efc01130", 0)) {
    self._id_A5BA = 1;
    self._id_C6C0 = 1;

    if(istrue(level._id_CA43)) {
      var_0._id_DDA8 = 1;
    }

    var_0 _meth_81FA();
    wait 0.1;

    if(istrue(level._id_CA43)) {
      var_0._id_DDA8 = 0;
    }

    if(scripts\mp\utility\player::isreallyalive(var_0)) {
      var_0._id_1643 = 1;
    }

    var_0 scripts\mp\playerlogic::_id_E337();
    var_0._id_C6C0 = 0;
  } else if(scripts\mp\utility\player::isreallyalive(var_0)) {
    var_0 _id_07E6::jugg_forceend();
    waitframe();
    var_1 = var_0 scripts\mp\playerlogic::_id_6D4A();
    var_0 _id_0817::_id_5AA0(var_1._id_E342);
    var_0 _meth_8063();
    var_0 setorigin(var_1._id_E332, 1);
    var_0 thread delayedsetplayerangles(var_1._id_E267);
    var_0 setstance("stand");
    var_0 _id_0A11::_id_A046();
    var_0.health = self.maxhealth;
    var_0 scripts\mp\healthoverlay::_id_AADF(1);
    var_0 scripts\mp\class::_id_BB98(self.class, 1);
    var_0 scripts\mp\class::_id_6FB1(self.team, self.class);
    var_0 _id_1AEE();
  } else
    var_0 scripts\mp\playerlogic::_id_E337();

  level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_0, 0, 0.5);

  if(istrue(var_0._id_C6A5)) {
    var_0 _id_0A99::_id_D5EA(77, undefined, 3);
    var_0._id_C6A5 = undefined;
  }
}

delayedsetplayerangles(var_0) {
  wait 1;
  self setplayerangles(var_0);
}

_id_1AF4() {
  scripts\mp\gametypes\arena_evo_tourney_util::_id_106F1();

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(1) == 0) {
    level thread _id_0A8D::_id_9139("champion_hill_start", level.players);
  }

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(1) == 1) {
    level thread _id_0A8D::_id_9139("arena_evo_matchup_2", level.players);
  }

  level._id_5E62 = 1;
  scripts\mp\gametypes\arena_evo_tourney_util::_id_D676();
  scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AF5();
  scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_1AC4();
  scripts\mp\gametypes\arena_evo_tourney_util::_id_CB53();
  level._id_7D76 = scripts\mp\gametypes\arena_evo_tourney_util::_id_88CF();

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_88CF()) {
    level.arena_evo_last_buy_round = scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(1);
  } else {}

  scripts\mp\gametypes\arena_evo_tourney_util::arenatournament_save_last_bye_round_team();
  scripts\mp\gametypes\arena_evo_tourney_util::_id_C9B2();

  if(attempt_to_end_game_due_to_match_limit()) {
    return;
  }
  level thread _id_078A::_id_2FA5(1);
  scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_1AC9();

  if(!_id_1AD8()) {
    scripts\mp\gametypes\arena_evo_tourney_util::_id_7409();
  }
}

attempt_to_end_game_due_to_match_limit() {
  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_88CF()) {
    return 0;
  }

  var_0 = getdvarint("#x3710ba0e8be72af7e", 20);

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_6603(0, 1) >= var_0 - 1) {
    var_1 = get_teams_with_most_lives();

    if(var_1.size > 0) {
      _id_F729("tie", 1);
    } else {
      _id_F729(var_1[0], 1);
    }

    return 1;
  }

  return 0;
}

get_teams_with_most_lives() {
  var_0 = -1;

  foreach(var_2 in scripts\mp\gametypes\arena_evo_tourney_util::_id_67CA()) {
    var_3 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6714(var_2);

    if(var_3 > var_0) {
      var_0 = var_3;
    }
  }

  var_5 = [];

  foreach(var_2 in scripts\mp\gametypes\arena_evo_tourney_util::_id_67CA()) {
    var_3 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6714(var_2);

    if(var_3 == var_0) {
      var_5[var_5.size] = var_2;
    }
  }

  return var_5;
}

_id_1AC7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;
  _id_1AD4(var_10, var_1, 0);
}

_id_1ADA(var_0) {
  var_0 endon("disconnect");

  if(isbot(var_0)) {
    return;
  }
  if(!getdvarint("#x34ebd08aa191d72d3", 1)) {
    return;
  }
  level endon("game_ended");
  var_0 notifyonplayercommand("spend_kill_credit_command", "-actionslot 4");
  var_0 notifyonplayercommand("spend_kill_credit_command", "killstreak2");

  for(;;) {
    var_0 waittill("spend_kill_credit_command");

    if(!var_0 scripts\mp\gametypes\arena_evo_tourney_util::is_in_weapon_upgrade_state()) {
      continue;
    }
    scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AF9(var_0);
  }
}

_id_1AFC() {
  var_0 = self;
  self endon("disconnect");
  self endon("noLongerAffordUpgrade");
  var_0 setclientomnvar("ui_arena_upgrade_ready", gettime());

  while(var_0._id_C330) {
    wait 20;

    if(!var_0 _meth_876E("ui_arena_remind_upgrades", 0)) {
      var_0 setclientomnvar("ui_arena_remind_upgrades", 1);
    }

    var_0 setclientomnvar("ui_arena_remind_upgrades_notify", gettime());
  }
}

arenatournament_wait_for_allow_spectate() {
  var_0 = self;
  var_0 endon("death_or_disconnect");
  var_0 notify("ArenaTournament_Wait_For_Allow_Spectate");
  var_0 endon("ArenaTournament_Wait_For_Allow_Spectate");
  var_1 = 0;

  for(;;) {
    var_2 = scripts\mp\gametypes\arena_evo_tourney_util::isspectateactivationallowed(var_0);

    if(var_2 != var_1) {
      var_1 = var_2;
      var_0 setclientomnvar("ui_arena_evo_can_enter_spectate", var_1);
    }

    waitframe();
  }
}

_id_1ADB() {
  var_0 = self;
  var_0 endon("death_or_disconnect");
  var_0 notify("ArenaTournament_Listen_Weapon_Change");
  var_0 endon("ArenaTournament_Listen_Weapon_Change");

  if(isbot(var_0)) {
    return;
  }
  for(;;) {
    var_1 = var_0 getcurrentprimaryweapon();
    var_2 = var_0 scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AD3(var_1, 0);
    var_3 = getweaponbasename(var_1);
    var_4 = isDefined(var_2);

    if(var_4) {
      if(!var_0 scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AD5(var_3)) {
        var_0 scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AF6(var_3, 0);
      }
    } else
      var_0 setclientomnvar("ui_player_current_weapon_upgrade_cost", -1);

    if(var_0 scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AD5(var_3)) {
      var_5 = var_0 scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_3);

      if(var_4) {
        var_6 = (var_5 + 1) * getdvarint("#x38e01883363ed7787", 100);
      } else {
        var_6 = -1;
      }

      var_0 setclientomnvar("ui_arena_current_weapon_rank", var_5);
      var_0 setclientomnvar("ui_player_current_weapon_upgrade_cost", var_6);
      var_0 scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AED();

      if(istrue(var_0._id_DCE5) && var_5 > 0) {
        var_0._id_DCE5 = undefined;
        var_0 scripts\mp\hud_message::showsplash("weapon_upgrade", var_5 + 1);
      }
    }

    if(istrue(var_0._id_1A88)) {
      var_0._id_1A88 = 0;
      var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_B61B();
    }

    var_0 scripts\engine\utility::_id_108C5("weapon_change", "giveLoadout");
  }
}

arenatournament_listen_report(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("exit_spectate_listener");
  var_1 notifyonplayercommand("report_player", "+melee_zoom");
  var_1 notifyonplayercommand("report_player", "+frag");

  if(!istrue(var_0)) {
    var_1 notifyonplayercommand("dpad_up_release", "-actionslot 1");
  }

  for(;;) {
    var_2 = var_1 scripts\engine\utility::_id_10896("report_player", "dpad_up_release");

    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2 == "report_player") {
      var_1 setclientomnvar("ui_arena_report_player_spectating", gettime());
      continue;
    }

    return;
  }
}

arenatournament_listen_spectate(var_0) {
  var_0 notify("exit_spectate_listener");
  var_0 endon("disconnect");
  var_0 endon("exit_spectate_listener");

  if(isbot(var_0)) {
    return;
  }
  if(!getdvarint("#x39d0db0cbd592d9d1", 1)) {
    return;
  }
  level endon("game_ended");
  var_0 notifyonplayercommand("dpad_up_release", "-actionslot 1");
  var_0 notifyonplayercommand("special_pressed", "+special");

  for(;;) {
    if(istrue(var_0.isspectating)) {
      if(istrue(var_0.isspectatingarena)) {
        var_0 thread arenatournament_listen_report();
        var_0 scripts\engine\utility::_id_108C5("dpad_up_release", "special_pressed");
        var_0 arenatournament_enter_spectate_overview();
      } else {
        var_0 waittill("luinotifyserver", var_1, var_2);

        if(scripts\engine\utility::is_equal(var_1, "arena_evo_close_spectate_overview")) {
          var_0 _id_1ACE();
        } else if(scripts\engine\utility::is_equal(var_1, "arena_evo_spectate_arena")) {
          var_0 arenatournament_enter_spectate_arena(var_2);
        }
      }

      continue;
    }

    var_0 scripts\engine\utility::_id_108C5("dpad_up_release", "special_pressed");

    if(scripts\mp\gametypes\arena_evo_tourney_util::isspectateactivationallowed(var_0)) {
      var_0 arenatournament_enter_spectate_overview();
    }
  }
}

_id_1AD4(var_0, var_1, var_2) {
  var_3 = gettime();

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    if(isDefined(var_0._id_2FF7)) {
      var_0._id_2FF7 delete();
    }

    if(scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_0.pers["team"])) {
      return;
    }
  }

  if(_id_1AD8()) {
    return;
  }
  if(istrue(var_0._id_C6C0)) {
    var_0._id_C6C0 = undefined;
    return;
  }

  if(isDefined(var_1) && istrue(var_1._id_1A63)) {
    var_1 thread scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_D336();
  }

  if(istrue(var_0._id_1AA1)) {
    return;
  }
  var_4 = var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_6661();
  var_5 = var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_6364();
  var_6 = var_5["opponents"];

  if(isDefined(var_1) && isDefined(var_1.pers)) {
    var_7 = var_1.pers["team"];
  } else {
    var_7 = undefined;
  }

  if(!var_2 && isDefined(var_7)) {
    var_0 scripts\mp\gametypes\arena_evo_tourney_loot::_id_E1C0(0, var_1);
  }

  var_8 = var_5["teammates"];
  var_9 = var_0.pers["team"];
  thread _id_0848::_id_DEF8(scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_9));

  if(var_2) {
    var_10 = scripts\engine\utility::array_remove(var_8, var_0);

    if(var_10.size > 0) {
      var_11 = var_0 scripts\mp\gametypes\arena_evo_tourney_loot::_id_1ACF();
      var_12 = int(var_11 / var_10.size);
      var_13 = getdvarint("#x3c5e4b3dce67baa4f", 1500);
      var_14 = int(min(var_12, var_13));

      foreach(var_16 in var_10) {
        scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AC6(var_16, var_14, "arena_evo_teammate_left");
      }
    }
  }

  var_18 = _id_64DC(var_0.pers["team"]);

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_DAA4(var_0.pers["team"], var_2)) {
    var_19 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6714(var_0.pers["team"]);
    scripts\mp\gametypes\arena_evo_tourney_util::_id_C441(var_0.pers["team"], var_19, 1);
  } else {
    var_20 = var_0 scripts\mp\gametypes\arena_evo_tourney_util::arenatournament_get_player_allow_state();
    var_21 = var_20 == "arena_evo_player_state_intermission";

    if(!var_21) {
      var_22 = var_18 == 9999;
      var_23 = var_0.pers["team"];
      var_24 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6714(var_23);
      scripts\mp\gametypes\arena_evo_tourney_util::_id_C441(var_23, var_18, var_22);
      var_25 = var_24 > 0;
      var_0 scripts\mp\gametypes\arena_evo_tourney_util::set_player_respawn(var_25);
    }
  }

  if(isDefined(var_7)) {
    if(scripts\engine\utility::is_equal(var_9, var_7)) {
      var_26 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(var_7);
    } else {
      var_26 = var_7;
    }

    var_27 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67BF(var_26) + 1;
    var_28 = _func_00BE("ui_arena_match_score_team" + var_27);
    var_28 = var_28 + 1;
    setomnvar("ui_arena_match_score_team" + var_27, var_28);
  }

  if(!scripts\engine\utility::is_equal(var_9, var_7)) {
    if(!scripts\mp\gametypes\arena_evo_tourney_util::_id_1A97(var_4)) {
      scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AC6(var_1, getdvarint("#x3b83b1b9b76307d0a", 500), "firstblood");

      if(isDefined(var_4)) {
        var_4._id_5BD4 = var_1;
      }
    } else
      scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AC6(var_1);
  }

  if(isDefined(var_1) && isPlayer(var_1) && !scripts\engine\utility::is_equal(var_9, var_7)) {
    if(!isDefined(var_1._id_E773)) {
      var_1._id_E773 = 1;
    } else {
      var_1._id_E773 = var_1._id_E773 + 1;
    }

    var_1 setclientomnvar("ui_arena_evo_stat_kills", var_1._id_E773);
  }

  _id_F728(var_9, var_0);
  scripts\mp\gametypes\arena_evo_tourney_util::_id_FB86(var_9);
}

_id_F729(var_0, var_1) {
  if(istrue(var_1) || _id_1AF8()) {
    scripts\mp\gametypes\arena_evo_tourney_util::arenatournament_dlog_record_end_of_game();
    _id_1ACB(var_0);
    return 1;
  } else
    return 0;
}

_id_F728(var_0, var_1) {
  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_0)) {
    return;
  }
  if(isDefined(var_1)) {
    var_2 = var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_6661();
    var_3 = var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_6364();
  } else {
    var_2 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67B9(var_0);
    var_3 = undefined;
  }

  var_4 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(var_0);
  var_5 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_0);
  var_6 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_4);
  var_7 = scripts\mp\gametypes\arena_evo_tourney_util::_id_6714(var_0);

  if(var_7 == 0 || var_7 == -1) {
    var_8 = 1;

    if(var_7 == 0 && getdvarint("#x33ad69175e1f60fa6", 1)) {
      if(isDefined(var_1)) {
        if(!istrue(var_1._id_9CCD)) {
          var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_4A36();
        }

        if(scripts\mp\gametypes\arena_evo_tourney_util::_id_6605(var_1.pers["team"]) > 0) {
          var_8 = 0;

          if(scripts\mp\gametypes\arena_evo_tourney_util::_id_6605(var_1.pers["team"]) == 1) {
            foreach(var_10 in var_5) {
              if(var_10 scripts\mp\gametypes\arena_evo_tourney_util::_id_8675()) {
                var_10 thread _id_0A8D::_id_9137("last_man_standing");
              }
            }
          }
        }
      }
    }

    if(var_8) {
      scripts\mp\gametypes\arena_evo_tourney_util::_id_D3DF([var_0], 0, var_4);
      var_12 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67BF(var_0) + 1;
      level thread _id_0A8D::_id_9139("eliminated_team_" + var_12, var_6);
      level thread _id_0A8D::_id_9139("buy_round_reminder", var_6);
      var_13 = level._id_EF89.size - level._id_1A6D.size;

      if(var_13 < 3) {
        if(!isDefined(level._id_1AA5)) {
          level._id_1AA5 = [];
        }

        level._id_1AA5[level._id_1AA5.size] = var_0;
      }

      foreach(var_10 in var_5) {
        var_10._id_DC9B = 1;
        var_10 scripts\mp\gamelogic::_id_FCFA();
        scripts\mp\gamelogic::_id_BD74(var_10);
        var_10 _meth_87B0();
        var_10 setclientdvar("#x32add9cc9e0c920a1", 1);
      }

      _func_01CD();
      var_16 = getdvarint("#x314321e96678a6d1a", 0);
      var_17 = getdvarint("#x3e58e3a657f2d82d9", 10);

      if(scripts\mp\gametypes\arena_evo_tourney_util::_id_67CA().size == 2 && var_16) {
        var_18 = scripts\mp\gametypes\arena_evo_tourney_util::_id_64B9() - var_17;

        if(level._id_1A87 < var_18) {
          level._id_1A87 = var_18;
        }
      }

      foreach(var_20 in var_6) {
        var_21 = getdvarint("#x313d7629999c02871", 500);
        scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AC6(var_20, var_21, "arena_evo_team_eliminated");
        var_20 _id_07E6::jugg_forceend();

        if(isDefined(var_20) && isPlayer(var_20)) {
          if(!isDefined(var_20._id_E75B)) {
            var_20._id_E75B = 1;
          } else {
            var_20._id_E75B = var_20._id_E75B + 1;
          }

          var_20 setclientomnvar("ui_arena_evo_stat_eliminations", var_20._id_E75B);
        }
      }

      thread _id_0848::_id_DEF7(var_1);
      var_1 scripts\mp\gametypes\arena_evo_tourney_loot::_id_E1C0(1);

      if(isDefined(var_1._id_026E)) {
        var_1._id_026E thread _id_0A8D::_id_9137("finished_off");
      }

      var_2 = var_1 scripts\mp\gametypes\arena_evo_tourney_util::_id_6661();
      scripts\mp\gametypes\arena_evo_tourney_util::_id_B22F(var_2);
    }
  }

  var_23 = _id_F729(var_4);

  if(var_23) {
    return;
  }
  if(!scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_0)) {
    if(!isDefined(var_1)) {
      return;
    }
    if(getdvarint("#x3afbc23f3e3741c2e", 1)) {
      var_1._id_1AA2 = 1;
      return;
    }

    if(isDefined(var_3) && !scripts\mp\gametypes\arena_evo_tourney_util::_id_1A95(var_3)) {
      return;
    }
  }
}

_id_1AF3(var_0, var_1) {
  scripts\mp\gametypes\arena_evo_tourney_util::_id_C002(var_1);

  foreach(var_3 in var_0) {
    var_3._id_C6A5 = 1;
    var_3 _id_1AF2();
  }
}

_id_1AF8() {
  var_0 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67CA();
  var_1 = 1;
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(!scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_4)) {
      var_2++;
    }
  }

  return var_2 <= 1;
}

_id_1ACB(var_0) {
  level._id_1A71 = 1;
  scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_1AC8();
  level thread scripts\mp\gametypes\arena_evo::_id_1A6F(var_0);
}

_id_1AD8() {
  return istrue(level._id_1A71);
}

_id_64DC(var_0) {
  if(getdvarint("#x329e06b5d85aca5dc", 0) && scripts\engine\utility::array_contains(scripts\mp\gametypes\arena_evo_tourney_util::_id_6328(), var_0)) {
    return 9999;
  }

  if(getdvarint("#x336ae42bc6096fa20", 0) && !scripts\engine\utility::array_contains(scripts\mp\gametypes\arena_evo_tourney_util::_id_6328(), var_0)) {
    return 9999;
  }

  return getdvarint("#x328ad91907b2275e6", 1);
}

_id_1AF2() {
  if(self _meth_876E("post_game_state") == 2) {
    return;
  }
  thread _id_1ACD();
}

arenatournament_enter_eliminated_screen(var_0) {
  var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_FD43();
  var_0 setclientomnvar("post_game_state", 2);
  var_1 = game["round_end"]["round_win"];
  var_2 = game["round_end"]["defeat"];
  var_0 thread scripts\mp\hud_message::_id_EF8B("", 0, var_1, var_2);
  var_0._id_C941 = "";
  wait(level._id_C93E);
  level thread arenatournament_listen_eliminated_choice(var_0);
}

arenatournament_listen_eliminated_choice(var_0) {
  var_0 notify("exit_eliminated_listener");
  var_0 endon("disconnect");
  var_0 endon("exit_eliminated_listener");

  if(isbot(var_0)) {
    return;
  }
  level endon("game_ended");

  for(;;) {
    var_0 waittill("luinotifyserver", var_1, var_2);

    if(scripts\engine\utility::is_equal(var_1, "arena_evo_eliminated_enter_spectate")) {
      var_0 arenatournament_enter_octagon();
    }
  }
}

arenatournament_enter_octagon() {
  var_0 = self;
  var_0 setclientomnvar("post_game_state", 0);
}

_startcameraspectateoverview() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 endon("force_stop_camera_spectate");
  level endon("game_ended");

  for(;;) {
    var_0 _meth_8060();
    var_0 cameralinkto(level._id_1A7A, "tag_origin", 1, 1);

    if(0) {
      foreach(var_2 in level.players) {
        var_2 _meth_81B1(var_0, "outline_nodepth_orange");
      }
    }

    waitframe();
  }
}

_endcameraspectateoverview() {
  var_0 = self;
  var_0 notify("force_stop_camera_spectate");
  var_0 _meth_8060();
  var_0.isspectatingoverview = 0;
  var_0 setclientomnvar("ui_options_menu", 0);

  if(0) {
    foreach(var_2 in level.players) {
      var_2 _meth_81AE(var_0);
    }
  }

  var_0 setorigin(var_0 get_spectate_ended_origin());

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_0)) {
    var_0 scripts\mp\gametypes\arena_evo_tourney_util::_id_D358();
  }
}

_endspectatearena() {
  var_0 = self;
  var_0.spectatingarenaindex = undefined;
  var_0 _id_081A::_id_D6E2();
  var_0 setclientomnvar("ui_arena_evo_spectating_arena", 0);
  var_0 scripts\mp\utility\player::_id_FD26("playing");
  var_0 setorigin(var_0 get_spectate_ended_origin());
}

get_spectate_ended_origin() {
  var_0 = 5;
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1 = _id_6B7D("mp_arena_spawn").origin;

    foreach(var_4 in level.players) {
      if(!scripts\engine\utility::is_equal(var_4, self)) {
        continue;
      }
      if(!scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(var_4) && !scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_4)) {
        continue;
      }
      if(distance(var_4.origin, self.origin) < 80) {
        continue;
      }
      return var_1;
    }
  }

  return var_1;
}

arenatournament_enter_spectate_overview() {
  var_0 = self;

  if(istrue(var_0.isspectating) && istrue(var_0.isspectatingarena)) {
    var_0 _endspectatearena();
    var_0.isspectatingarena = 0;
    var_0.isspectating = 0;
  }

  if(!istrue(var_0.isspectating)) {
    var_0.isspectating = 1;
    var_0.isspectatingoverview = 1;
    var_0 setclientomnvar("ui_options_menu", 4);
    var_0 thread _startcameraspectateoverview();
  }
}

arenatournament_enter_spectate_arena(var_0) {
  var_1 = self;

  if(!istrue(var_1.isspectating)) {
    var_1.isspectating = 1;
  } else if(istrue(var_1.isspectatingoverview)) {
    var_1 _endcameraspectateoverview();
    var_1.isspectatingoverview = 0;
  }

  if(!istrue(var_1.isspectatingarena) || var_1.spectatingarenaindex != var_0) {
    var_1.isspectatingarena = 1;
    var_1.spectatingarenaindex = var_0;
    var_2 = 0;
    var_1 _meth_8013("freelook", 0);
    var_1 _meth_8013("none", 0);

    foreach(var_4 in scripts\mp\gametypes\arena_evo_tourney_util::_id_633A()) {
      var_5 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67B9(var_4);
      var_6 = isDefined(var_5) && scripts\engine\utility::is_equal(var_5.arena_index, var_0);
      var_1 _meth_8013(var_4, var_6);
      var_2 = var_2 || var_6;
    }

    if(!var_2) {
      var_1 _id_1ACE();
    } else {
      var_1 setclientomnvar("ui_arena_evo_spectating_arena", 1);
      var_1 scripts\mp\utility\player::_id_FD26("spectator");
    }
  }
}

_id_1ACE() {
  var_0 = self;

  if(istrue(var_0.isspectating)) {
    if(istrue(var_0.isspectatingoverview)) {
      var_0 _endcameraspectateoverview();
      var_0.isspectating = 0;
      var_0.isspectatingoverview = 0;
    } else if(istrue(var_0.isspectatingarena)) {
      var_0 _endspectatearena();
      var_0.isspectating = 0;
      var_0.isspectatingarena = 0;
    }
  }
}

_id_1AD0() {
  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_88CF() || scripts\mp\gametypes\arena_evo_tourney_util::_id_DBCA()) {
    return _id_6B7D("mp_dom_spawn");
  }

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(self.pers["team"])) {
    return _id_6B7D("mp_dom_spawn");
  }

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(self)) {
    return _id_6B7D("mp_arena_spawn");
  }

  var_0 = scripts\mp\gametypes\arena_evo_tourney_util::_id_65D9(self.pers["team"]);
  var_1 = var_0._id_03E9;
  var_2 = var_0._id_1A5C;
  scripts\mp\gametypes\arena_evo_tourney_util::_id_D330(var_2);

  if(!scripts\engine\utility::array_contains(var_2.players, self)) {
    var_2.players[var_2.players.size] = self;
  }

  return var_1;
}

_id_6B7D(var_0) {
  if(!isDefined(level._id_1A8C)) {
    level._id_1A8C = [];
  }

  if(!isDefined(level._id_1A8C[var_0])) {
    level._id_1A8C[var_0] = 0;
  }

  if(!isDefined(level._id_1A67)) {
    level._id_1A67 = [];
  }

  if(!isDefined(level._id_1A67[var_0])) {
    level._id_1A67[var_0] = ::scripts\engine\utility::_id_1BC1(scripts\engine\utility::array_randomize(_func_00CB(var_0)));
  }

  var_1 = level._id_1A67[var_0][level._id_1A8C[var_0]];
  level._id_1A8C[var_0]++;

  if(level._id_1A8C[var_0] >= level._id_1A67[var_0].size) {
    level._id_1A8C[var_0] = 0;
  }

  return var_1;
}

_id_1AD7() {
  level endon("game_ended");

  for(;;) {
    level waittill("run_intermission");

    if(level._id_CA43) {
      _func_01EA("ui_arena_ui_state", 4);
      setomnvar("ui_match_start_text", "waiting_for_players");
      level thread scripts\mp\gametypes\arena_evo_tourney_util::_id_10A42();

      while(!istrue(level._id_1A70)) {
        waitframe();
      }

      scripts\mp\gametypes\arena_evo_tourney_util::_id_D3EC();
      level._id_E703 = gettime();

      if(scripts\mp\gametypes\arena_evo_tourney_util::_id_DBCA()) {
        scripts\mp\gametypes\arena_evo_tourney_util::_id_C9F0();
      }

      if(isDefined(game["flags"]["ch_tutorial_done"])) {
        _id_07D1::_id_60C1("ch_tutorial_done");
      }

      scripts\mp\gametypes\arena_evo_tourney_util::_id_10753();
      level._id_CA43 = 0;
    }
  }
}

arenatournament_afk_check(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = scripts\mp\gametypes\arena_evo_tourney_util::arena_evo_getafkchecktime();
  var_6 = scripts\mp\utility\game::matchmakinggame() && !_func_0394() && !getdvarint("#x3156d8b13d11c9bb3", 0);
  var_7 = 0;

  if(!var_6) {
    return;
  }
  if(getdvarint("#x3d1c9984568884f80", 0) == 1) {
    return;
  }
  var_4 notify("ArenaTournament_AFK_Check");
  var_4 endon("ArenaTournament_AFK_Check");
  var_4 endon("disconnect");
  var_4 endon("death");
  var_8 = var_0;
  var_9 = 0;
  var_10 = 1;

  if(isDefined(var_1)) {
    var_9 = var_1;
  }

  var_11 = 0;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  for(;;) {
    if(var_4 scripts\mp\gametypes\arena_evo_tourney_util::is_in_combat_state()) {
      var_11 = var_11 + distance(var_8, var_4.origin);
      var_11 = int(var_11);
      var_8 = var_4.origin;
      var_12 = self.pers["kills"];
      var_13 = self.pers["assists"];
      var_14 = var_12 + var_13 - var_3;
      var_15 = var_14 == 0;
      var_16 = isDefined(self._id_9055) && gettime() - self._id_9055 < 11000;
      var_17 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(var_4.pers["team"]);

      if(isDefined(var_17) && !scripts\engine\utility::is_equal(var_4.pers["team"], var_17)) {
        var_18 = scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_17);
      } else {
        var_18 = 0;
      }

      if(var_9 >= var_5) {
        if(var_15 && !var_16 && !var_18 && var_11 < 50) {
          level thread scripts\mp\teams::_id_8CE0(var_4);
          return;
        } else {
          var_9 = 0;
          var_11 = 0;
        }
      }
    } else {
      var_9 = 0;
      var_11 = 0;

      if(isDefined(var_1)) {
        var_9 = var_1;
      }

      if(isDefined(var_2)) {
        var_11 = var_2;
      }
    }

    var_1 = undefined;
    var_2 = undefined;
    var_4.arenaevoafk_elapsedtime = var_9;
    var_4.arenaevoafk_distancetraveled = var_11;
    wait(var_10);
    var_9 = var_9 + var_10;
  }
}