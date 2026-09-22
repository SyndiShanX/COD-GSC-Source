/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots.gsc
******************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  if(getdvarint("4017") == 1) {
    return;
  }
  if(getdvarint("233") == 1) {
    return;
  }
  if(_func_367()) {
    return;
  }
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  _id_87A7();
  maps\mp\bots\_bots_personality::_id_897D();
  level._id_14F6 = ::_badplace_cylinder;
  level._id_14F7 = ::_badplace_delete;

  if(isDefined(level._id_1A4F)) {
    [[level._id_1A4F]]();
  } else {
    maps\mp\bots\_bots_ks::_id_1A4E();
  }

  maps\mp\bots\_bots_loadout::init();
  level thread init();
}

_id_87A7() {
  level.bot_funcs = [];
  level.bot_funcs["bots_spawn"] = ::spawn_bots;
  level.bot_funcs["bots_add_scavenger_bag"] = ::bot_add_scavenger_bag;
  level.bot_funcs["bots_add_to_level_targets"] = maps\mp\bots\_bots_util::_id_1931;
  level.bot_funcs["bots_remove_from_level_targets"] = maps\mp\bots\_bots_util::_id_1AB4;
  level.bot_funcs["bots_make_entity_sentient"] = ::_id_1A70;
  level.bot_funcs["bots_free_entity_sentient"] = ::bot_free_entity_sentient;
  level.bot_funcs["think"] = ::_id_1AFD;
  level.bot_funcs["on_killed"] = ::_id_6A7A;
  level.bot_funcs["should_do_killcam"] = ::_id_1AE2;
  level.bot_funcs["get_attacker_ent"] = maps\mp\bots\_bots_util::_id_19F7;
  level.bot_funcs["should_pickup_weapons"] = ::_id_1AE3;
  level.bot_funcs["on_damaged"] = ::_id_1996;
  level.bot_funcs["gametype_think"] = ::_id_2B9C;
  level.bot_funcs["leader_dialog"] = maps\mp\bots\_bots_util::_id_1A59;
  level.bot_funcs["player_spawned"] = ::_id_1A9C;
  level.bot_funcs["should_start_cautious_approach"] = maps\mp\bots\_bots_strategy::_id_8B7A;
  level.bot_funcs["know_enemies_on_start"] = ::_id_1A52;
  level.bot_funcs["bot_get_rank_xp_and_prestige"] = ::_id_19FE;
  level.bot_funcs["bot_set_rank_options"] = ::_id_1AD6;
  level.bot_funcs["ai_3d_sighting_model"] = ::_id_192A;
  level.bot_funcs["dropped_weapon_think"] = ::_id_1B03;
  level.bot_funcs["dropped_weapon_cancel"] = ::_id_8B80;
  level.bot_funcs["crate_can_use"] = ::_id_2735;
  level.bot_funcs["post_teleport"] = ::_id_1A9E;
  level.bot_funcs["bot_set_difficulty"] = maps\mp\bots\_bots_util::bot_set_difficulty;
  level.bot_funcs["bot_set_personality"] = maps\mp\bots\_bots_util::_id_1AD5;
  level.bot_funcs["bot_think_watch_enemy"] = ::_id_1B06;
  level.bot_funcs["bot_think_tactical_goals"] = maps\mp\bots\_bots_strategy::_id_1B04;
  level.bot_funcs["bot_bots_enabled_or_added"] = maps\mp\bots\_bots_util::_id_194B;
  level._id_1AB0 = [];
  level._id_1AB0["allies"] = maps\mp\bots\_bots_personality::_id_1AAF;
  level._id_1AB0["axis"] = maps\mp\bots\_bots_personality::_id_1AAF;
  level._id_1AB0["hostile"] = maps\mp\bots\_bots_personality::_id_1AAF;
  level._id_1AB0["neutral"] = maps\mp\bots\_bots_personality::_id_1AAF;
  level._id_19CA["capture"] = maps\mp\bots\_bots_strategy::_id_3B6F;
  level._id_19CA["capture_zone"] = maps\mp\bots\_bots_strategy::_id_3B70;
  level._id_19CA["protect"] = maps\mp\bots\_bots_strategy::_id_3B72;
  level._id_19CA["protect_zone"] = maps\mp\bots\_bots_strategy::_id_3B73;
  level._id_19CA["bodyguard"] = maps\mp\bots\_bots_strategy::_id_3B6E;
  level._id_19CA["patrol"] = maps\mp\bots\_bots_strategy::_id_3B71;
  _id_87BF();
  maps\mp\bots\_bots_gametype_war::_id_87A7();
}

_id_87BF() {
  level.bot_funcs["crate_low_ammo_check"] = ::_id_273D;
  level.bot_funcs["crate_should_claim"] = ::_id_2741;
  level.bot_funcs["crate_wait_use"] = ::_id_2743;
  level.bot_funcs["crate_in_range"] = ::_id_2739;
  level._id_1962["deployable_vest"] = ::_id_1AE6;
  level._id_1962["deployable_ammo"] = ::_id_1AE5;
  level._id_1962["scavenger_bag"] = ::_id_1AE9;
  level._id_1962["deployable_grenades"] = ::_id_1AE7;
  level._id_1962["deployable_juicebox"] = ::_id_1AE8;
  level._id_1AA2["deployable_ammo"] = ::_id_1AA1;
  level._id_1AA0["deployable_ammo"] = ::_id_1A9F;
}

_id_0049(var_0, var_1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["leader_dialog"])) {
    self[[level.bot_funcs["leader_dialog"]]](var_0, var_1);
  }
}

init() {
  thread _id_6348();
  thread _id_1B07();
  _id_5299();

  if(!_id_8BA9()) {
    return;
  }
  _id_7B8D();
  var_0 = _botautoconnectenabled();

  if(var_0 == "enabled_fill_open" || var_0 == "enabled_fill_open_dev" || level._id_53C7) {
    setmatchdata("match_common", "has_bots", 1);
    level thread _id_197E();
  } else
    level thread _id_1A81();
}

_id_5299() {
  if(!isDefined(level._id_2751)) {
    level._id_2751 = 500;
  }

  if(!isDefined(level._id_274E)) {
    level._id_274E = 3000;
  }

  level._id_1A8C = 3000;
  level._id_1AB6["recruit"] = "iw5_maaws";
  level._id_1AB6["regular"] = "iw5_maaws";
  level._id_1AB6["hardened"] = "iw5_maaws";
  level._id_1AB6["veteran"] = "iw5_maaws";
  level._id_19C3 = "m1garand_mp";
  level._id_AC9C = _getzonecount();
  _id_529A();
}

_id_529A() {
  if(isDefined(level._id_98C4)) {
    var_0 = [[level._id_98C4]]();
  } else {
    var_0 = _getallnodes();
  }

  level._id_1A75 = 0;
  level._id_1A72 = 0;
  level._id_1A76 = 0;
  level._id_1A73 = 0;
  level._id_1A77 = 0;
  level._id_1A74 = 0;

  if(var_0.size > 1) {
    level._id_1A75 = var_0[0].origin[0];
    level._id_1A72 = var_0[0].origin[0];
    level._id_1A76 = var_0[0].origin[1];
    level._id_1A73 = var_0[0].origin[1];
    level._id_1A77 = var_0[0].origin[2];
    level._id_1A74 = var_0[0].origin[2];

    for(var_1 = 1; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1].origin;

      if(var_2[0] < level._id_1A75) {
        level._id_1A75 = var_2[0];
      }

      if(var_2[0] > level._id_1A72) {
        level._id_1A72 = var_2[0];
      }

      if(var_2[1] < level._id_1A76) {
        level._id_1A76 = var_2[1];
      }

      if(var_2[1] > level._id_1A73) {
        level._id_1A73 = var_2[1];
      }

      if(var_2[2] < level._id_1A77) {
        level._id_1A77 = var_2[2];
      }

      if(var_2[2] > level._id_1A74) {
        level._id_1A74 = var_2[2];
      }
    }
  }

  level._id_1A71 = ((level._id_1A75 + level._id_1A72) / 2, (level._id_1A76 + level._id_1A73) / 2, (level._id_1A77 + level._id_1A74) / 2);
  level._id_1B1B = 1;
}

_id_1A9E() {
  level._id_1B1B = undefined;
  level._id_1A22 = undefined;
  _id_529A();
  maps\mp\bots\_bots_ks_remote_vehicle::_id_7C63();
}

_id_8BA9() {
  return 1;
}

_id_7B8D() {
  wait 1;

  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      var_1._id_37F4 = 1;
      var_1._id_1AFA = var_1.team;
      var_1._id_1AEE = 1;
      var_1 thread[[level.bot_funcs["think"]]]();
    }
  }
}

_id_1A9C() {
  _id_1AD4();
}

_id_1AD4() {
  if(!isDefined(self.bot_class)) {
    if(!_id_19DC()) {
      while(!isDefined(level._id_1A6E)) {
        waitframe();
      }

      if(isDefined(self._id_6CB8)) {
        self.bot_class = [[self._id_6CB8]]();
      } else {
        self.bot_class = maps\mp\bots\_bots_personality::_id_1ADD();
      }
    } else
      self.bot_class = self.class;
  }
}

_id_A8DE() {
  for(;;) {
    level waittill("connected", var_0);

    if(!_isai(var_0) && level.players.size > 0) {
      level._id_744C = common_scripts\utility::_id_0F6F(level._id_744C, var_0);
      childthread _id_1B41(var_0);
      childthread _id_1B40(var_0);
      childthread _id_1B42(var_0);
    }
  }
}

_id_1B41(var_0) {
  var_0 endon("bots_human_disconnected");

  while(!common_scripts\utility::_id_0F79(level.players, var_0)) {
    waitframe();
  }

  var_0 notify("bots_human_spawned");
}

_id_1B40(var_0) {
  var_0 endon("bots_human_spawned");
  var_0 waittill("disconnect");
  var_0 notify("bots_human_disconnected");
}

_id_1B42(var_0) {
  var_0 common_scripts\utility::_id_A70A("bots_human_spawned", "bots_human_disconnected");
  level._id_744C = common_scripts\utility::_id_0F93(level._id_744C, var_0);
}

_id_632D() {
  level._id_744C = [];
  childthread _id_A8DE();

  for(;;) {
    if(level._id_744C.size > 0) {
      level._id_6F29 = 1;
    } else {
      level._id_6F29 = 0;
    }

    wait 0.5;
  }
}

_id_1958(var_0) {
  if(maps\mp\_utility::matchmakinggame()) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  if(_id_0510::_id_452D(var_0)) {
    return 1;
  }

  return 0;
}

_id_1935() {
  if(isDefined(level._id_1B3B) && level._id_1B3B) {
    return 0;
  }

  if(isDefined(level._id_6034) && level._id_6034) {
    return 0;
  }

  return 1;
}

_id_197E() {
  level endon("game_ended");
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");
  level._id_6F29 = 0;
  childthread _id_632D();
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_0 = 1.5;

  if(!isDefined(level._id_197A)) {
    level._id_197A = 0;
  }

  if(!isDefined(level._id_197B)) {
    level._id_197B = 0;
  }

  if(!isDefined(level._id_1979)) {
    level._id_1979 = 0;
  }

  for(;;) {
    if(level._id_6F29) {
      maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
      continue;
    }

    var_1 = isDefined(level._id_1B3F) || !level.teambased;
    var_2 = _botgetteamlimit(0);
    var_3 = _botgetteamlimit(1);

    if(level._id_53C7) {
      var_2 = level.setshader;
      var_3 = level.settargetent;
    }

    var_4 = _botgetteamdifficulty(0);
    var_5 = _botgetteamdifficulty(1);
    var_9 = "allies";

    if(isDefined(level._id_1A57)) {
      var_9 = level._id_1A57;
    }

    var_10 = "axis";

    if(isDefined(level._id_1A58)) {
      var_10 = level._id_1A58;
    }

    var_11 = _id_1978();
    var_12 = _id_2032(var_11, "humans");

    if(var_12 > 1) {
      var_13 = _id_19F5();

      if(!maps\mp\_utility::matchmakinggame() && isDefined(var_13) && var_13 != "spectator") {
        var_9 = var_13;
        var_10 = maps\mp\_utility::getotherteam(var_13);
      } else {
        var_14 = _id_2032(var_11, "humans_allies");
        var_15 = _id_2032(var_11, "humans_axis");

        if(var_15 > var_14) {
          var_9 = "axis";
          var_10 = "allies";
        }
      }
    } else {
      var_16 = _id_41D2();

      if(isDefined(var_16)) {
        var_17 = var_16 _id_19FD();

        if(isDefined(var_17) && var_17 != "spectator") {
          var_9 = var_17;
          var_10 = maps\mp\_utility::getotherteam(var_17);
        }
      }
    }

    level._id_1A57 = var_9;
    level._id_1A58 = var_10;
    var_18 = maps\mp\bots\_bots_util::_id_1A02();
    var_19 = maps\mp\bots\_bots_util::_id_1A02();
    var_20 = maps\mp\bots\_bots_util::_id_19EE();

    if(var_18 + var_19 < var_20) {
      if(var_18 < var_2) {
        var_18++;
      } else if(var_19 < var_3) {
        var_19++;
      }
    }

    var_21 = _id_2032(var_11, "humans_" + var_9);
    var_22 = _id_2032(var_11, "humans_" + var_10);
    var_23 = var_21 + var_22;
    var_24 = _id_2032(var_11, "spectator");
    var_25 = 0;

    for(var_26 = 0; var_24 > 0; var_24--) {
      var_27 = var_21 + var_25 + 1 <= var_18;
      var_28 = var_22 + var_26 + 1 <= var_19;

      if(var_27 && !var_28) {
        var_25++;
        continue;
      }

      if(!var_27 && var_28) {
        var_26++;
        continue;
      }

      if(var_27 && var_28) {
        if(var_24 % 2 == 1) {
          var_25++;
          continue;
        }

        var_26++;
      }
    }

    var_29 = _id_2032(var_11, "bots_" + var_9);
    var_30 = _id_2032(var_11, "bots_" + var_10);
    var_31 = var_29 + var_30;

    if(var_31 > 0) {
      level._id_197A = 1;
    }

    var_32 = 0;

    if(!level._id_1979) {
      var_32 = !_id_19F6();

      if(!var_32) {
        level._id_1979 = 1;
      }
    }

    if(var_32) {
      var_33 = !_isonlinegame();
      var_34 = var_3 != var_2;
      var_35 = !_id_19F6() && !var_1 && var_34 && !level._id_197A && (level._id_197B < 10 || !maps\mp\_utility::gameflag("prematch_done"));
      var_36 = 0;

      if(var_33 || var_35 || var_36) {
        level._id_197B = level._id_197B + var_0;
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
        continue;
      }
    }

    var_37 = int(_min(var_18 - var_21 - var_25, var_2));
    var_38 = int(_min(var_19 - var_22 - var_26, var_3));
    var_39 = 1;
    var_40 = var_37 + var_38 + var_12;
    var_41 = var_2 + var_3 + var_12;

    for(var_42 = [-1, -1]; var_40 < var_20 && var_40 < var_41; var_39 = !var_39) {
      if(var_39 && var_37 < var_2 && _id_1958(var_9)) {
        var_37++;
      } else if(!var_39 && var_38 < var_3 && _id_1958(var_10)) {
        var_38++;
      }

      var_40 = var_37 + var_38 + var_12;

      if(var_42[var_39] == var_40) {
        break;
      }

      var_42[var_39] = var_40;
    }

    level._id_1A79[var_9] = int(var_37 + var_21 + var_25);
    level._id_1A79[var_10] = int(var_38 + var_22 + var_26);
    _id_A0AF();

    if(var_2 == var_3 && !var_1 && var_25 == 1 && var_26 == 0 && var_38 > 0) {
      if(!isDefined(level._id_1AA3) && maps\mp\_utility::gameflag("prematch_done")) {
        level._id_1AA3 = gettime();
      }

      if(var_32 && (!isDefined(level._id_1AA3) || gettime() - level._id_1AA3 < 10000)) {
        var_38--;
      }
    }

    var_44 = var_37 - var_29;
    var_45 = var_38 - var_30;
    var_46 = 1;

    if(var_1) {
      var_47 = var_18 + var_19;
      var_48 = var_2 + var_3;
      var_49 = var_21 + var_22;
      var_50 = var_29 + var_30;
      var_51 = int(_min(var_47 - var_49, var_48));
      var_52 = var_51 - var_50;

      if(var_52 == 0) {
        var_46 = 0;
      } else if(var_52 > 0) {
        var_44 = int(var_52 / 2) + var_52 % 2;
        var_45 = int(var_52 / 2);
      } else if(var_52 < 0) {
        var_53 = var_52 * -1;
        var_44 = -1 * int(_min(var_53, var_29));
        var_45 = -1 * (var_53 + var_44);
      }
    } else if(!maps\mp\_utility::matchmakinggame() && (var_44 * var_45 < 0 && maps\mp\_utility::gameflag("prematch_done") && _id_1935())) {
      var_54 = int(_min(_abs(var_44), _abs(var_45)));

      if(var_44 > 0) {
        _id_6475(var_54, var_10, var_9, var_4);
      } else if(var_45 > 0) {
        _id_6475(var_54, var_9, var_10, var_5);
      }

      var_46 = 0;
    }

    if(var_46) {
      if(var_45 < 0) {
        _id_3447(var_45 * -1, var_10);
      }

      if(var_44 < 0) {
        _id_3447(var_44 * -1, var_9);
      }

      if(var_45 > 0) {
        level thread spawn_bots(var_45, var_10, undefined, undefined, "spawned_enemies", var_5);
      }

      if(var_44 > 0) {
        level thread spawn_bots(var_44, var_9, undefined, undefined, "spawned_allies", var_4);
      }

      if(var_45 > 0 && var_44 > 0) {
        level common_scripts\utility::_id_A746("spawned_enemies", "spawned_allies");
      } else if(var_45 > 0) {
        level waittill("spawned_enemies");
      } else if(var_44 > 0) {
        level waittill("spawned_allies");
      }
    }

    if(var_5 != var_4) {
      bots_update_difficulty(var_10, var_5);
      bots_update_difficulty(var_9, var_4);
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

_id_1A81() {
  level endon("game_ended");
  self notify("bot_monitor_team_limits");
  self endon("bot_monitor_team_limits");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_0 = 1.5;

  for(;;) {
    level._id_1A79["allies"] = 0;
    level._id_1A79["axis"] = 0;

    foreach(var_2 in level.players) {
      if(isDefined(var_2.team) && (var_2.team == "allies" || var_2.team == "axis")) {
        level._id_1A79[var_2.team]++;
      }
    }

    _id_A0AF();
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

_id_A0AF() {
  if(isDefined(level._id_0A4E)) {
    foreach(var_1 in level._id_0A4E) {
      if(isDefined(var_1._id_565F) && var_1._id_565F) {
        if(maps\mp\_utility::_id_5800(var_1) && isDefined(var_1.team) && (var_1.team == "allies" || var_1.team == "axis")) {
          level._id_1A79[var_1.team]++;
        }
      }
    }
  }
}

_id_19FD() {
  if(isDefined(self.team)) {
    return self.team;
  }

  if(isDefined(self.pers["team"])) {
    return self.pers["team"];
  }

  return undefined;
}

_id_19F5() {
  foreach(var_1 in level.players) {
    if(!_isai(var_1) && var_1 ishost()) {
      return var_1 _id_19FD();
    }
  }

  return "spectator";
}

_id_19F6() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!_isai(var_4)) {
      if(var_4 ishost()) {
        var_0 = 1;
      }

      if(_id_72FA(var_4)) {
        var_1 = 1;

        if(var_4 ishost()) {
          var_2 = 1;
        }
      }
    }
  }

  return var_2 || var_1 && !var_0;
}

_id_72FA(var_0) {
  if(isDefined(var_0.team) && var_0.team != "spectator") {
    return 1;
  }

  if(isDefined(var_0._id_90E3) && var_0._id_90E3) {
    return 1;
  }

  if(var_0 ismlgspectator()) {
    return 1;
  }

  return 0;
}

bot_get_human_picked_class() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!_isai(var_4)) {
      if(var_4 ishost()) {
        var_0 = 1;
      }

      if(isDefined(var_4.class)) {
        var_1 = 1;

        if(var_4 ishost()) {
          var_2 = 1;
        }
      }
    }
  }

  return var_2 || var_1 && !var_0;
}

_id_1978() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = level.players[var_1];

    if(isDefined(var_2) && isDefined(var_2.team)) {
      var_0 = _id_2031(var_0, "all");
      var_0 = _id_2031(var_0, var_2.team);

      if(isbot(var_2)) {
        var_0 = _id_2031(var_0, "bots");
        var_0 = _id_2031(var_0, "bots_" + var_2.team);
        continue;
      }

      var_0 = _id_2031(var_0, "humans");
      var_0 = _id_2031(var_0, "humans_" + var_2.team);
    }
  }

  return var_0;
}

_id_2031(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = [];
  }

  if(!isDefined(var_0[var_1])) {
    var_0[var_1] = 0;
  }

  var_0[var_1] = var_0[var_1] + 1;
  return var_0;
}

_id_2032(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0[var_1])) {
    return 0;
  }

  return var_0[var_1];
}

_id_6475(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.players) {
    if(!isDefined(var_5.team)) {
      continue;
    }
    if(isDefined(var_5.connected) && var_5.connected && isbot(var_5) && var_5.team == var_1) {
      var_5._id_1AFA = var_2;

      if(isDefined(var_3)) {
        var_5 maps\mp\bots\_bots_util::bot_set_difficulty(var_3);
      }

      var_5 notify("luinotifyserver", "team_select", _id_1A6F(var_2));
      waitframe();
      var_5 notify("luinotifyserver", "class_select", var_5.bot_class);
      var_0--;

      if(var_0 <= 0) {
        break;
      } else
        wait 0.1;
    }
  }
}

bots_update_difficulty(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(isDefined(var_3.connected) && var_3.connected && isbot(var_3) && var_3.team == var_0) {
      if(var_1 != var_3 botgetdifficulty()) {
        var_3 maps\mp\bots\_bots_util::bot_set_difficulty(var_1);
      }
    }
  }
}

bot_drop() {
  _kick(self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE");
  wait 0.1;
}

_id_3447(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isDefined(var_4.connected) && var_4.connected && isbot(var_4) && (!isDefined(var_1) || isDefined(var_4.team) && var_4.team == var_1)) {
      var_2[var_2.size] = var_4;
    }
  }

  for(var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    if(!maps\mp\_utility::isreallyalive(var_2[var_6])) {
      var_2[var_6] bot_drop();
      var_2 = common_scripts\utility::_id_0F93(var_2, var_2[var_6]);
      var_0--;
    }
  }

  for(var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    var_2[var_6] bot_drop();
    var_0--;
  }
}

_id_1A6F(var_0) {
  if(var_0 == "axis") {
    return 0;
  } else if(var_0 == "allies") {
    return 1;
  } else if(var_0 == "autoassign" || var_0 == "random") {
    return 2;
  } else {
    return 3;
  }
}

_id_8F87(var_0, var_1, var_2) {
  var_3 = gettime() + 60000;

  while(!self canspawntestclient()) {
    if(gettime() >= var_3) {
      _kick(self.entity_number, "EXE_PLAYERKICKED_BOT_BALANCE");
      var_2._id_0843 = 1;
      return;
    }

    waitframe();

    if(!isDefined(self)) {
      var_2._id_0843 = 1;
      return;
    }
  }

  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(_randomfloatrange(0.25, 2.0));

  if(!isDefined(self)) {
    var_2._id_0843 = 1;
    return;
  }

  self spawntestclient();
  self._id_37F4 = 1;
  self._id_1AFA = var_0;

  if(isDefined(var_2._id_2F05)) {
    maps\mp\bots\_bots_util::bot_set_difficulty(var_2._id_2F05);
  }

  if(isDefined(var_1)) {
    self[[var_1]]();
  }

  self thread[[level.bot_funcs["think"]]]();
  var_2._id_7ABD = 1;
}

spawn_bots(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime() + 10000;
  var_7 = [];
  var_8 = var_7.size;

  while(level.players.size < maps\mp\bots\_bots_util::_id_19EE() && var_7.size < var_0 && gettime() < var_6) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    var_9 = _addbot("", var_1);

    if(!isDefined(var_9)) {
      if(isDefined(var_3) && var_3) {
        if(isDefined(var_4)) {
          self notify(var_4);
        }

        return;
      }

      maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    } else {
      var_10 = spawnStruct();
      var_10._id_1929 = var_9;
      var_10._id_7ABD = 0;
      var_10._id_0843 = 0;
      var_10._id_00D4 = var_8;
      var_10._id_2F05 = var_5;
      var_7[var_7.size] = var_10;
      var_10._id_1929 thread _id_8F87(var_1, var_2, var_10);
      var_8++;
    }
  }

  var_11 = 0;
  var_6 = gettime() + 60000;

  while(var_11 < var_7.size && gettime() < var_6) {
    var_11 = 0;

    foreach(var_10 in var_7) {
      if(var_10._id_7ABD || var_10._id_0843) {
        var_11++;
      }
    }

    waitframe();
  }

  if(isDefined(var_4)) {
    self notify(var_4);
  }
}

_id_19DD() {
  if(maps\mp\_utility::matchmakinggame() && self._id_0179 != "none") {
    var_0 = 0;
  } else if(!maps\mp\_utility::matchmakinggame() && maps\mp\_utility::_id_0C2D()) {
    var_0 = 1;
  } else {
    var_0 = 0;
  }

  return !var_0;
}

_id_19DC() {
  return isDefined(level._id_1B3D) && level._id_1B3D;
}

_id_1AFD() {
  self notify("bot_think");
  self endon("bot_think");
  self endon("disconnect");

  while(!isDefined(self.pers["team"])) {
    waitframe();
  }

  level._id_4B58 = 1;

  if(_id_19DD()) {
    self._id_1AFA = self.pers["team"];
  }

  var_0 = self._id_1AFA;

  if(!isDefined(var_0)) {
    var_0 = self.pers["team"];
  }

  self.entity_number = self getentitynumber();
  var_1 = 0;

  if(!isDefined(self._id_1AEE)) {
    var_1 = 1;
    self._id_1AEE = 1;

    if(!_id_19DD()) {
      var_2 = self.pers["team"] != "spectator" && !isDefined(self._id_1AFA);

      if(!var_2) {
        self notify("luinotifyserver", "team_select", _id_1A6F(var_0));
        wait 0.5;

        if(self.pers["team"] == "spectator") {
          bot_drop();
          return;
        }
      }
    }
  }

  for(;;) {
    maps\mp\bots\_bots_util::bot_set_difficulty(self botgetdifficulty());
    self._id_2F05 = self botgetdifficulty();
    var_3 = self botgetdifficultysetting("advancedPersonality");

    if(var_1 && isDefined(var_3) && var_3 != 0) {
      maps\mp\bots\_bots_personality::_id_193F();
    }

    maps\mp\bots\_bots_personality::_id_1939();

    if(var_1) {
      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["class_select_override"])) {
        self[[level.bot_funcs["class_select_override"]]]();
      } else {
        _id_1AD4();

        if(!_id_19DC()) {
          if(isDefined(self._id_2589) && self._id_2589 == gettime()) {
            waittillframeend;
            waittillframeend;
          }

          if(maps\mp\_utility::isprophuntgametype() && var_0 == game["attackers"] && game["roundsPlayed"] > 0) {
            wait 0.5;
          }

          self notify("luinotifyserver", "class_select", self.bot_class);
        }
      }

      if(self.health == 0) {
        self waittill("spawned_player");
      }

      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["know_enemies_on_start"])) {
        self thread[[level.bot_funcs["know_enemies_on_start"]]]();
      }

      var_1 = 0;
    }

    maps\mp\bots\_bots_loadout::_id_1A7E();
    _id_1A7F();
    _id_1AB7();
    wait 0.1;
    self waittill("death");

    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["post_death_func"])) {
      self[[level.bot_funcs["post_death_func"]]]();
    }

    _id_7DB1();
    self waittill("spawned_player");
  }
}

_id_1AD6() {}

_id_1A7F() {
  if(_id_0511::_id_46F7("game", "onlyheadshots")) {
    self botsetflag("only_headshots", 1);
  }
}

_id_7DB1() {
  self endon("started_spawnPlayer");

  while(!self._id_A6F0) {
    waitframe();
  }

  if(maps\mp\gametypes\_playerlogic::_id_664E()) {
    while(self._id_A6F0) {
      if(self.sessionstate == "spectator") {
        if(getdvarint("numlives") == 0 || self.pers["lives"] > 0) {
          self botpressbutton("use", 0.5);
        }
      }

      wait 1.0;
    }
  }
}

_id_1A39() {
  return self botisrandomized();
}

_id_19FE() {
  var_0 = spawnStruct();

  if(!_id_1A39()) {
    if(!isDefined(self.pers["rankxp"])) {
      self.pers["rankxp"] = 0;
    }

    if(!isDefined(self.pers["prestige"])) {
      self.pers["prestige"] = 0;
    }

    var_0._id_7A6D = self.pers["rankxp"];
    var_0._id_76B0 = self.pers["prestige"];
    return var_0;
  }

  var_1 = self botgetdifficulty();
  var_2 = "bot_rank_" + var_1;
  var_3 = "bot_prestige_" + var_1;
  var_4 = self.pers[var_2];
  var_5 = self.pers[var_3];
  var_6 = undefined;

  if(isDefined(var_4)) {
    var_0._id_7A6D = var_4;
  } else {
    if(!isDefined(var_6)) {
      var_6 = _id_1AB1(var_1);
    }

    var_7 = var_6["rank"];
    var_8 = maps\mp\gametypes\_rank::getrankinfominxp(var_7);
    var_9 = maps\mp\gametypes\_rank::getrankinfomaxxp(var_7);
    var_10 = _randomintrange(var_8, var_9);
    self.pers[var_2] = var_10;
    var_0._id_7A6D = var_10;
  }

  if(isDefined(var_5)) {
    var_0._id_76B0 = var_5;
  } else {
    if(!isDefined(var_6)) {
      var_6 = _id_1AB1(var_1);
    }

    var_11 = var_6["prestige"];
    self.pers[var_3] = var_11;
    var_0._id_76B0 = var_11;
  }

  return var_0;
}

_id_192A(var_0) {
  thread _id_192B(var_0);
}

_id_192B(var_0) {
  var_0 endon("disconnect");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(isalive(self) && !self botcanseeentity(var_0) && common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self botgetfovdot())) {
      self botgetimperfectenemyinfo(var_0, var_0.origin);
    }

    wait 0.1;
  }
}

_id_1AB1(var_0) {
  var_1 = [];
  var_1["rank"] = 0;
  var_1["prestige"] = 0;

  if(var_0 == "default") {
    return var_1;
  }

  if(!isDefined(level._id_1ABA)) {
    level._id_1ABA = [];
    level._id_1ABA["recruit"][0] = 0;
    level._id_1ABA["recruit"][1] = 1;
    level._id_1ABA["regular"][0] = 20;
    level._id_1ABA["regular"][1] = 28;
    level._id_1ABA["hardened"][0] = 40;
    level._id_1ABA["hardened"][1] = 48;
    level._id_1ABA["veteran"][0] = 50;
    level._id_1ABA["veteran"][1] = 54;
  }

  if(!isDefined(level._id_1AB9)) {
    level._id_1AB9 = [];
    level._id_1AB9["recruit"][0] = 0;
    level._id_1AB9["recruit"][1] = 0;
    level._id_1AB9["regular"][0] = 0;
    level._id_1AB9["regular"][1] = 0;
    level._id_1AB9["hardened"][0] = 0;
    level._id_1AB9["hardened"][1] = 0;
    level._id_1AB9["veteran"][0] = 0;
    level._id_1AB9["veteran"][1] = 9;
  }

  var_1["rank"] = _randomintrange(level._id_1ABA[var_0][0], level._id_1ABA[var_0][1] + 1);
  var_1["prestige"] = _randomintrange(level._id_1AB9[var_0][0], level._id_1AB9[var_0][1] + 1);
  return var_1;
}

_id_2735(var_0) {
  if(_isagent(self) && !isDefined(var_0._id_1B7B)) {
    return 0;
  }

  return 1;
}

_id_41D2() {
  var_0 = undefined;
  var_1 = getEntArray("player", "classname");

  if(isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2]) && isDefined(var_1[var_2].connected) && var_1[var_2].connected && !_isai(var_1[var_2]) && (!isDefined(var_0) || var_0.team == "spectator")) {
        var_0 = var_1[var_2];
      }
    }
  }

  return var_0;
}

_id_1996(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(var_2 == "MOD_FALLING" || var_2 == "MOD_SUICIDE") {
    return;
  }
  if(var_1 <= 0) {
    return;
  }
  if(!isDefined(var_4)) {
    if(!isDefined(var_0)) {
      return;
    }
    var_4 = var_0;
  }

  if(isDefined(var_4)) {
    if(level.teambased) {
      if(isDefined(var_4.team) && var_4.team == self.team) {
        return;
      } else if(isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team) {
        return;
      }
    }

    var_6 = maps\mp\bots\_bots_util::_id_19F7(var_0, var_4);

    if(isDefined(var_6)) {
      self botsetattacker(var_6);
    }
  }

  if(_isagent(self)) {
    self notify("agentDamage");
  }
}

_id_6A7A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self botclearscriptenemy();
  self botclearscriptgoal();
  var_10 = maps\mp\bots\_bots_util::_id_19F7(var_1, var_0);

  if(isDefined(var_10) && var_10.classname == "misc_turret" && isDefined(var_10._id_2210)) {
    var_10 = var_10._id_2210;
  }

  if(isDefined(var_10) && (var_10.classname == "script_vehicle" || var_10.classname == "script_model") && isDefined(var_10._id_4C9E)) {
    var_11 = self botgetdifficultysetting("launcherRespawnChance");

    if(_randomfloat(1.0) < var_11) {
      self._id_7DB2 = 1;
    }
  }
}

_id_1AE2() {
  var_5 = 0.0;
  var_6 = self botgetdifficulty();

  if(var_6 == "recruit") {
    var_5 = 0.1;
  } else if(var_6 == "regular") {
    var_5 = 0.4;
  } else if(var_6 == "hardened") {
    var_5 = 0.7;
  } else if(var_6 == "veteran") {
    var_5 = 1.0;
  }

  return _randomfloat(1.0) < 1.0 - var_5;
}

_id_1AE3() {
  return 1;
}

_id_1AB7() {
  self thread[[level.bot_funcs["bot_think_watch_enemy"]]]();
  self thread[[level.bot_funcs["bot_think_tactical_goals"]]]();
  self thread[[level.bot_funcs["dropped_weapon_think"]]]();

  if(!level._id_53C7) {
    thread _id_1AFE();
    thread _id_1AFF();
  }

  if(maps\mp\_utility::_id_0F5C()) {
    thread maps\mp\bots\_bots_ks::_id_1B01();
    thread maps\mp\bots\_bots_ks::_id_1B05();
  }

  thread _id_1B00();
}

_id_1B06(var_0) {
  var_1 = "spawned_player";

  if(isDefined(var_0) && var_0) {
    var_1 = "death";
  }

  self notify("bot_think_watch_enemy");
  self endon("bot_think_watch_enemy");
  self endon(var_1);
  self endon("disconnect");
  level endon("game_ended");
  self._id_5B21 = 0;

  for(;;) {
    if(isDefined(self._id_0088)) {
      if(self botcanseeentity(self._id_0088)) {
        self._id_5B21 = gettime();
      }
    }

    waitframe();
  }
}

_id_1B03() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = 0;

    if(maps\mp\bots\_bots_util::_id_1A8B()) {
      if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !maps\mp\bots\_bots_util::_id_1A36()) {
        var_1 = getEntArray("dropped_weapon", "targetname");
        var_2 = common_scripts\utility::_id_40B0(self.origin, var_1);

        if(var_2.size > 0) {
          var_3 = var_2[0];
          _id_1AC1(var_3);
        }
      }
    }

    wait(_randomfloatrange(0.25, 0.75));
  }
}

_id_1AC1(var_0) {
  if(maps\mp\bots\_bots_strategy::_id_1A14("seek_dropped_weapon", var_0) == 0) {
    var_1 = undefined;

    if(var_0.targetname == "dropped_weapon") {
      var_2 = 1;
      var_3 = self getweaponlistprimaries();

      foreach(var_5 in var_3) {
        if(var_0.model == _getweaponmodel(var_5)) {
          var_2 = 0;
        }
      }

      if(var_2) {
        var_1 = ::_id_1A9B;
      }
    }

    var_7 = spawnStruct();
    var_7._id_68FB = var_0;
    var_7._id_81C8 = 12;
    var_7._id_8B3E = level.bot_funcs["dropped_weapon_cancel"];
    var_7._id_087F = var_1;
    maps\mp\bots\_bots_strategy::_id_1A85("seek_dropped_weapon", var_0.origin, 100, var_7);
  }
}

_id_1A9B(var_0) {
  self botpressbutton("use", 2);
  wait 2;
}

_id_8B80(var_0) {
  if(!isDefined(var_0._id_68FB)) {
    return 1;
  }

  if(var_0._id_68FB.targetname == "dropped_weapon") {
    if(maps\mp\bots\_bots_util::_id_1A07() > 0) {
      return 1;
    }
  } else if(var_0._id_68FB.targetname == "dropped_knife") {
    if(maps\mp\bots\_bots_util::_id_1A1C()) {
      self._id_4813 = undefined;
      return 1;
    }
  }

  return 0;
}

_id_2739(var_0) {
  if(!isDefined(var_0._id_0117) || var_0._id_0117 != self) {
    if(distancesquared(self.origin, var_0.origin) > 4194304) {
      return 0;
    }
  }

  return 1;
}

_id_1982(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!self[[level.bot_funcs["crate_can_use"]]](var_0)) {
    return 0;
  }

  if(!_id_273B(var_0)) {
    return 0;
  }

  if(level.teambased && isDefined(var_0._id_18B3) && isDefined(var_0.team) && var_0.team == self.team) {
    return 0;
  }

  if(!self[[level.bot_funcs["crate_in_range"]]](var_0)) {
    return 0;
  }

  if(isDefined(var_0._id_1B7B)) {
    if(isDefined(level._id_1B79) && isDefined(level._id_1B79[var_0._id_1B7B]) && ![[level._id_1B79[var_0._id_1B7B]._id_1F7A]]()) {
      return 0;
    }

    if(isDefined(var_0._id_2F75) && isDefined(var_0._id_2F75[self getentitynumber()]) && var_0._id_2F75[self getentitynumber()]) {
      return 0;
    }

    if(!self[[level._id_1962[var_0._id_1B7B]]](var_0)) {
      return 0;
    }
  } else if(_id_1A13(var_0))
    return 0;

  return isDefined(var_0);
}

_id_1A13(var_0) {
  if(isDefined(var_0._id_944E) && isDefined(self.pers["killstreaks"])) {
    foreach(var_2 in self.pers["killstreaks"]) {
      if(common_scripts\utility::_id_562E(var_2._id_5703) && isDefined(var_2._id_944C) && var_2._id_944C == var_0._id_944E) {
        return 1;
      }
    }
  }

  return 0;
}

_id_273B(var_0) {
  if(!_id_2738(var_0)) {
    return 0;
  }

  if(!_id_273A(var_0)) {
    return 0;
  }

  return isDefined(var_0);
}

_id_2738(var_0) {
  if(isDefined(var_0._id_1B7B)) {
    return gettime() > var_0._id_002B + 1000;
  } else {
    return isDefined(var_0._id_34A3) && !var_0._id_34A3;
  }
}

_id_273A(var_0) {
  if(!isDefined(var_0._id_6AA9)) {
    _id_2733(var_0);
  }

  return isDefined(var_0) && var_0._id_6AA9;
}

_id_6717(var_0, var_1) {
  if(isDefined(var_1._id_1B7B) && var_1._id_1B7B == "scavenger_bag") {
    return _abs(var_0.origin[0] - var_1.origin[0]) < 36 && _abs(var_0.origin[0] - var_1.origin[0]) < 36 && _abs(var_0.origin[0] - var_1.origin[0]) < 18;
  } else {
    var_2 = getdvarfloat("2098");
    var_3 = distancesquared(var_1.origin, var_0.origin + (0, 0, 40));
    return var_3 <= var_2 * var_2;
  }
}

_id_2733(var_0) {
  var_0 thread _id_273E();
  var_0._id_6AA9 = 0;
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(var_0._id_3E18)) {
    var_1 = var_0._id_3E18;
    var_2 = gettime() + 30000;
    var_0._id_3E18 = var_2;
    var_0 notify("path_disconnect");
  }

  waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  var_3 = [];
  var_3 = _id_2737(var_0);

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_3) && var_3.size > 0) {
    var_0._id_663A = var_3;
    var_0._id_6AA9 = 1;
  } else {
    var_4 = getdvarfloat("2098");
    var_5 = _getnodesinradiussorted(var_0.origin, var_4 * 2, 0)[0];
    var_6 = var_0 getpointinbounds(0, 0, -1);
    var_7 = undefined;

    if(isDefined(var_0._id_1B7B) && var_0._id_1B7B == "scavenger_bag") {
      if(maps\mp\bots\_bots_util::_id_1A9D(var_0.origin)) {
        var_7 = var_0.origin;
      }
    } else
      var_7 = _botgetclosestnavigablepoint(var_0.origin, var_4);

    if(isDefined(var_5) && !var_5 nodeisdisconnected() && isDefined(var_7) && _abs(var_5.origin[2] - var_6[2]) < 30) {
      var_0._id_663B = [var_7];
      var_0._id_663A = [var_5];
      var_0._id_6AA9 = 1;
    }
  }

  if(isDefined(var_0._id_3E18)) {
    if(var_0._id_3E18 == var_2) {
      var_0._id_3E18 = var_1;
    }
  }
}

_id_2737(var_0) {
  var_1 = _getnodesinradiussorted(var_0.origin, 256, 0);

  for(var_2 = var_1.size; var_2 > 0; var_2--) {
    var_1[var_2] = var_1[var_2 - 1];
  }

  var_1[0] = _getclosestnodeinsight(var_0.origin);
  var_3 = undefined;

  if(isDefined(var_0._id_3E18)) {
    var_3 = _getallnodes();
  }

  var_4 = [];
  var_5 = 1;

  if(!isDefined(var_0._id_1B7B)) {
    var_5 = 2;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_6 = var_1[var_2];

    if(!isDefined(var_6) || !isDefined(var_0)) {
      continue;
    }
    if(var_6 nodeisdisconnected()) {
      continue;
    }
    if(!_id_6717(var_6, var_0)) {
      if(var_2 == 0) {
        continue;
      } else {
        break;
      }
    }

    waitframe();

    if(!isDefined(var_0)) {
      break;
    }

    if(_sighttracepassed(var_0.origin, var_6.origin + (0, 0, 55), 0, var_0)) {
      waitframe();

      if(!isDefined(var_0)) {
        break;
      }

      if(!isDefined(var_0._id_3E18)) {
        var_4[var_4.size] = var_6;

        if(var_4.size == var_5) {
          return var_4;
        } else {
          continue;
        }
      }

      var_7 = undefined;
      var_8 = 0;

      while(!isDefined(var_7) && var_8 < 100) {
        var_8++;
        var_9 = common_scripts\utility::random(var_3);

        if(distancesquared(var_6.origin, var_9.origin) > 250000) {
          var_7 = var_9;
        }
      }

      if(isDefined(var_7)) {
        var_10 = maps\mp\bots\_bots_util::_id_1AA8("GetNodesOnPathCrate", maps\mp\bots\_bots_util::_id_3F07, var_6.origin, var_7.origin);

        if(isDefined(var_10)) {
          var_4[var_4.size] = var_6;

          if(var_4.size == var_5) {
            return var_4;
          } else {
            continue;
          }
        }
      }
    }
  }

  return undefined;
}

_id_2736(var_0) {
  if(isDefined(var_0._id_663B)) {
    return var_0._id_663B[0];
  }

  if(isDefined(var_0._id_663A) && var_0._id_663A.size > 0) {
    var_1 = common_scripts\utility::_id_0FA2(self botnodescoremultiple(var_0._id_663A, "node_exposed"));
    return common_scripts\utility::_id_7A46(var_1).origin;
  }
}

_id_1AFE() {
  self notify("bot_think_crate");
  self endon("bot_think_crate");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = getdvarfloat("2098");

  for(;;) {
    var_1 = _randomfloatrange(2, 4);
    common_scripts\utility::waittill_notify_or_timeout("new_crate_to_take", var_1);

    if(isDefined(self._id_1B75) && self._id_1B75.size == 0) {
      self._id_1B75 = undefined;
    }

    var_2 = level._id_1FFD;

    if(!maps\mp\bots\_bots_util::_id_1A1C() && isDefined(self._id_1B75)) {
      var_2 = common_scripts\utility::_id_0F73(var_2, self._id_1B75);
    }

    if(isDefined(level._id_1ABB) && maps\mp\_utility::_hasperk("specialty_scavenger")) {
      var_2 = common_scripts\utility::_id_0F73(var_2, level._id_1ABB);
    }

    var_2 = common_scripts\utility::_id_0FA0(var_2);

    if(var_2.size == 0) {
      continue;
    }
    if(maps\mp\bots\_bots_strategy::_id_1A14("airdrop_crate") || self botgetscriptgoaltype() == "tactical" || maps\mp\bots\_bots_util::_id_1A36()) {
      continue;
    }
    var_3 = [];

    foreach(var_5 in var_2) {
      if(_id_1982(var_5)) {
        var_3[var_3.size] = var_5;
      }
    }

    var_3 = common_scripts\utility::_id_0F97(var_3);

    if(var_3.size == 0) {
      continue;
    }
    var_3 = common_scripts\utility::_id_40B0(self.origin, var_3);
    var_7 = self getnearestnode();

    if(!isDefined(var_7)) {
      continue;
    }
    var_8 = self[[level.bot_funcs["crate_low_ammo_check"]]]();
    var_9 = (var_8 || randomint(100) < 50) && !maps\mp\_utility::_id_56D7();
    var_10 = undefined;

    foreach(var_5 in var_3) {
      var_12 = 0;

      if((!isDefined(var_5._id_0117) || var_5._id_0117 != self) && !isDefined(var_5._id_1B7B)) {
        var_13 = [];

        foreach(var_15 in level.players) {
          if(!isDefined(var_15.team)) {
            continue;
          }
          if(!_isai(var_15) && level.teambased && var_15.team == self.team) {
            if(distancesquared(var_15.origin, var_5.origin) < 490000) {
              var_13[var_13.size] = var_15;
            }
          }
        }

        if(var_13.size > 0) {
          var_17 = var_13[0] getnearestnode();

          if(isDefined(var_17)) {
            var_12 = 0;

            foreach(var_19 in var_5._id_663A) {
              var_12 = var_12 | _nodesvisible(var_17, var_19, 1);
            }
          }
        }
      }

      if(!var_12) {
        var_21 = isDefined(var_5._id_1B39) && isDefined(var_5._id_1B39[self.team]) && var_5._id_1B39[self.team] > 0;
        var_22 = 0;

        foreach(var_19 in var_5._id_663A) {
          var_22 = var_22 | _nodesvisible(var_7, var_19, 1);
        }

        if(var_22 || var_9 && !var_21) {
          var_10 = var_5;
          break;
        }
      }
    }

    if(isDefined(var_10)) {
      if(self[[level.bot_funcs["crate_should_claim"]]]()) {
        if(!isDefined(var_10._id_1B7B)) {
          if(!isDefined(var_10._id_1B39)) {
            var_10._id_1B39 = [];
          }

          var_10._id_1B39[self.team] = 1;
        }
      }

      var_26 = spawnStruct();
      var_26._id_68FB = var_10;
      var_26._id_9296 = ::_id_A87F;
      var_26._id_8B3E = ::_id_2740;
      var_27 = undefined;

      if(isDefined(var_10._id_1B7B)) {
        if(isDefined(var_10._id_1B7A) && var_10._id_1B7A) {
          var_26._id_81C8 = 16;
          var_26._id_087F = undefined;
          var_27 = var_10.origin;
        } else {
          var_26._id_81C8 = 50;
          var_26._id_087F = ::_id_A1D8;
          var_28 = _id_2736(var_10) - var_10.origin;
          var_29 = length(var_28) * _randomfloat(1.0);
          var_27 = var_10.origin + vectorNormalize(var_28) * var_29 + (0, 0, 12);
        }
      } else {
        var_26._id_087F = ::_id_A1DC;
        var_26._id_36AC = ::_id_93F1;
        var_27 = _id_2736(var_10);
        var_26._id_81C8 = var_0 - distance(var_10.origin, var_27 + (0, 0, 40));
        var_27 = var_27 + (0, 0, 24);
      }

      if(isDefined(var_26._id_81C8)) {}

      var_10 notify("path_disconnect");
      waitframe();

      if(!isDefined(var_10)) {
        continue;
      }
      maps\mp\bots\_bots_strategy::_id_1A85("airdrop_crate", var_27, 30, var_26);
    }
  }
}

_id_1AE6(var_0) {
  return 1;
}

_id_2741() {
  return 1;
}

_id_273D() {
  return 0;
}

_id_1AE5(var_0) {
  if(self getcurrentweapon() == level._id_1B79[var_0._id_1B7B]._id_6209) {
    return 0;
  }

  return 1;
}

_id_1AA1(var_0) {
  self switchtoweapon(self.botclearscriptenemy);
  wait 1.0;
}

_id_1A9F(var_0) {
  self switchtoweapon("none");
  self.botclearscriptenemy = self getcurrentweapon();
}

_id_1AE9(var_0) {
  if(maps\mp\bots\_bots_util::_id_19F8(0.66)) {
    var_1 = self getnearestnode();

    if(isDefined(var_0._id_663A) && isDefined(var_0._id_663A[0]) && isDefined(var_1)) {
      if(_nodesvisible(var_1, var_0._id_663A[0], 1)) {
        if(common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self botgetfovdot())) {
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_1AE7(var_0) {
  var_1 = self getweaponslistoffhands();

  foreach(var_3 in var_1) {
    if(self getweaponammostock(var_3) == 0) {
      return 1;
    }
  }

  return 0;
}

_id_1AE8(var_0) {
  return 1;
}

_id_273E() {
  self notify("crate_monitor_position");
  self endon("crate_monitor_position");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var_0 = self.origin;
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
    if(!maps\mp\bots\_bots_util::_id_1B1C(self.origin, var_0)) {
      self._id_6AA9 = undefined;
      self._id_663A = undefined;
      self._id_663B = undefined;
    }
  }
}

_id_2743() {}

_id_2740(var_0) {
  if(!isDefined(var_0._id_68FB)) {
    return 1;
  }

  return 0;
}

_id_A1DC(var_0) {
  if(_isagent(self)) {
    common_scripts\utility::_id_0615();
    var_0._id_68FB enableplayeruse(self);
    waitframe();
  }

  self[[level.bot_funcs["crate_wait_use"]]]();

  if(isDefined(var_0._id_68FB._id_0117) && var_0._id_68FB._id_0117 == self) {
    var_1 = level._id_2751 / 1000 + 0.5;
  } else {
    var_1 = level._id_274E / 1000 + 1.0;
  }

  self botpressbutton("use", var_1);

  while(var_1 > 0 && isDefined(var_0._id_68FB)) {
    waitframe();
    var_1 = var_1 - 0.05;
  }

  if(var_1 > 0) {
    wait(_randomfloatrange(0.05, 0.5));
  }

  if(_isagent(self)) {
    common_scripts\utility::_id_0601();

    if(isDefined(var_0._id_68FB)) {
      var_0._id_68FB disableplayeruse(self);
    }
  }

  if(isDefined(var_0._id_68FB)) {
    if(!isDefined(var_0._id_68FB._id_1B44)) {
      var_0._id_68FB._id_1B44 = [];
    }

    var_0._id_68FB._id_1B44[var_0._id_68FB._id_1B44.size] = self;
  }
}

_id_A1D8(var_0) {
  if(_isagent(self)) {
    common_scripts\utility::_id_0615();
    var_0._id_68FB enableplayeruse(self);
    waitframe();
  }

  if(isDefined(var_0._id_68FB) && isDefined(var_0._id_68FB._id_1B7B)) {
    var_1 = var_0._id_68FB._id_1B7B;

    if(isDefined(level._id_1AA2[var_1])) {
      self[[level._id_1AA2[var_1]]](var_0._id_68FB);
    }

    if(isDefined(var_0._id_68FB)) {
      var_2 = level._id_1B79[var_0._id_68FB._id_1B7B]._id_A23F / 1000 + 0.5;
      self botpressbutton("use", var_2);
      wait(var_2);

      if(isDefined(level._id_1AA0[var_1])) {
        self[[level._id_1AA0[var_1]]](var_0._id_68FB);
      }
    }
  }

  if(_isagent(self)) {
    common_scripts\utility::_id_0601();

    if(isDefined(var_0._id_68FB)) {
      var_0._id_68FB disableplayeruse(self);
    }
  }
}

_id_A87F(var_0) {
  thread _id_1B28(var_0._id_68FB);
}

_id_93F1(var_0) {
  if(isDefined(var_0._id_A861) && var_0._id_A861) {
    self botsetstance("none");
    self botlookatpoint(undefined);
  }

  if(isDefined(var_0._id_68FB)) {
    var_0._id_68FB._id_1B39[self.team] = 0;
  }
}

_id_1B28(var_0) {
  var_0 endon("death");
  var_0 endon("revived");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = self.team;
  common_scripts\utility::_id_A70A("death", "disconnect");

  if(isDefined(var_0)) {
    var_0._id_1B39[var_1] = 0;
  }
}

_id_1AFF() {
  self notify("bot_think_crate_blocking_path");
  self endon("bot_think_crate_blocking_path");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = getdvarfloat("2098");

  for(;;) {
    wait 3;

    if(self useButtonPressed()) {
      continue;
    }
    if(maps\mp\_utility::isusingremote()) {
      continue;
    }
    var_1 = level._id_1FFD;

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(!isDefined(var_3)) {
        continue;
      }
      var_4 = self playergetuseent();

      if(!isDefined(var_4) || var_4 != var_3) {
        continue;
      }
      if(distancesquared(self.origin, var_3.origin) < var_0 * var_0) {
        if(!_id_1A13(var_3)) {
          if(isDefined(var_3._id_0117) && var_3._id_0117 == self) {
            self botpressbutton("use", level._id_2751 / 1000 + 0.5);
            continue;
          }

          self botpressbutton("use", level._id_274E / 1000 + 0.5);
        }
      }
    }
  }
}

_id_1B02() {
  self notify("bot_think_revive");
  self endon("bot_think_revive");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  for(;;) {
    var_0 = 2.0;
    var_1 = getEntArray("revive_trigger", "targetname");

    if(var_1.size > 0) {
      var_0 = 0.05;
    }

    level common_scripts\utility::waittill_notify_or_timeout("player_last_stand", var_0);

    if(!_id_1959()) {
      continue;
    }
    var_1 = getEntArray("revive_trigger", "targetname");

    if(var_1.size > 1) {
      var_1 = _sortbydistance(var_1, self.origin);

      if(isDefined(self._id_0117)) {
        for(var_2 = 0; var_2 < var_1.size; var_2++) {
          if(var_1[var_2]._id_0117 != self._id_0117) {
            continue;
          }
          if(var_2 == 0) {
            break;
          }

          var_3 = var_1[var_2];
          var_1[var_2] = var_1[0];
          var_1[0] = var_3;
          break;
        }
      }
    }

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_4 = var_1[var_2];
      var_5 = var_4._id_0117;

      if(!isDefined(var_5)) {
        continue;
      }
      if(var_5 == self) {
        continue;
      }
      if(!isalive(var_5)) {
        continue;
      }
      if(var_5.team != self.team) {
        continue;
      }
      if(!isDefined(var_5.inlaststand) || !var_5.inlaststand) {
        continue;
      }
      if(isDefined(var_5._id_1B39) && isDefined(var_5._id_1B39[self.team]) && var_5._id_1B39[self.team] > 0) {
        continue;
      }
      if(distancesquared(self.origin, var_5.origin) < 4194304) {
        var_6 = spawnStruct();
        var_6._id_68FB = var_4;
        var_6._id_81C8 = 64;

        if(isDefined(self._id_5B44) && gettime() - self._id_5B44 < 1000) {
          var_6._id_81C8 = 32;
        }

        var_6._id_9296 = ::_id_A880;
        var_6._id_36AC = ::_id_93E6;
        var_6._id_8B3E = ::_id_7311;
        var_6._id_087F = ::_id_7E52;
        maps\mp\bots\_bots_strategy::_id_1A85("revive", var_5.origin, 60, var_6);
        break;
      }
    }
  }
}

_id_A880(var_0) {
  thread _id_1B28(var_0._id_68FB._id_0117);
}

_id_93E6(var_0) {
  if(isDefined(var_0._id_68FB._id_0117)) {
    var_0._id_68FB._id_0117._id_1B39[self.team] = 0;
  }
}

_id_7311(var_0) {
  if(!isDefined(var_0._id_68FB._id_0117) || var_0._id_68FB._id_0117.health <= 0) {
    return 1;
  }

  if(!isDefined(var_0._id_68FB._id_0117.inlaststand) || !var_0._id_68FB._id_0117.inlaststand) {
    return 1;
  }

  return 0;
}

_id_7E52(var_0) {
  if(distancesquared(self.origin, var_0._id_68FB._id_0117.origin) > 4096) {
    self._id_5B44 = gettime();
    return;
  }

  if(_isagent(self)) {
    common_scripts\utility::_id_0615();
    var_0._id_68FB enableplayeruse(self);
    waitframe();
  }

  var_1 = self.team;
  self botpressbutton("use", level._id_5BFA / 1000 + 0.5);
  wait(level._id_5BFA / 1000 + 1.5);

  if(isDefined(var_0._id_68FB._id_0117)) {
    var_0._id_68FB._id_1B39[var_1] = 0;
  }

  if(_isagent(self)) {
    common_scripts\utility::_id_0601();

    if(isDefined(var_0._id_68FB)) {
      var_0._id_68FB disableplayeruse(self);
    }
  }
}

_id_1959() {
  if(isDefined(self._id_00E8) && self._id_00E8 == 1) {
    return 0;
  }

  if(maps\mp\bots\_bots_strategy::_id_1A14("revive")) {
    return 0;
  }

  if(maps\mp\bots\_bots_util::_id_1A36()) {
    return 0;
  }

  if(maps\mp\bots\_bots_util::_id_1A27()) {
    return 1;
  }

  var_0 = self botgetscriptgoaltype();

  if(var_0 == "none" || var_0 == "hunt" || var_0 == "guard") {
    return 1;
  }

  return 0;
}

_id_7E53(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("bad_path");
  self endon("goal");
  var_0 common_scripts\utility::_id_A70A("death", "revived");
  self notify("bad_path");
}

_id_1A52() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(gettime() > 15000) {
    return;
  }
  while(!maps\mp\_utility::gamehasstarted() || !maps\mp\_utility::gameflag("prematch_done")) {
    waitframe();
  }

  var_0 = undefined;
  var_1 = undefined;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isDefined(var_3) && isDefined(self.team) && isDefined(var_3.team) && !_isalliedsentient(self, var_3)) {
      if(!isDefined(var_3._id_1AF2)) {
        var_0 = var_3;
      }

      if(_isai(var_3) && !isDefined(var_3._id_1AF1)) {
        var_1 = var_3;
      }
    }
  }

  if(isDefined(var_0)) {
    self._id_1AF1 = 1;
    var_0._id_1AF2 = 1;
    self getenemyinfo(var_0);
  }

  if(isDefined(var_1)) {
    var_1._id_1AF1 = 1;
    self._id_1AF2 = 1;
    var_1 getenemyinfo(self);
  }
}

_id_1A70(var_0, var_1, var_2, var_3, var_4) {
  return self makeentitysentient(var_0, var_1, var_2, var_3, var_4);
}

bot_free_entity_sentient() {
  self freeentitysentient();
}

_id_1B00() {
  self notify("bot_think_gametype");
  self endon("bot_think_gametype");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::gameflagwait("prematch_done");
  self thread[[level.bot_funcs["gametype_think"]]]();
}

_id_2B9C() {}

_id_6348() {
  maps\mp\bots\_bots_util::_id_1B20();
  level._id_1AEC = _getEnt("smoke_grenade_sight_clip_small", "targetname");

  if(!isDefined(level._id_1AEC)) {
    return;
  }
  level._id_1AEB = _getEnt("smoke_grenade_sight_clip_medium", "targetname");

  if(!isDefined(level._id_1AEB)) {
    return;
  }
  level._id_1AEA = _getEnt("smoke_grenade_sight_clip_large", "targetname");

  if(!isDefined(level._id_1AEA)) {
    return;
  }
  for(;;) {
    level waittill("smoke", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "smoke_grenade_mp" || var_2 == "smoke_grenade_axis_mp" || var_2 == "smoke_grenade_expeditionary_mp" || var_2 == "smoke_grenade_axis_expeditionary_mp") {
      var_0 thread _id_4A5C();
    }
  }
}

_id_4A5C() {
  self waittill("explode", var_0);
  var_1 = common_scripts\utility::_id_8FFC();
  var_1 show();
  var_1 _meth_86AB(1);
  var_1.origin = var_0;
  var_2 = 0.3;
  wait(var_2);
  var_2 = 0.4;
  var_1 clonebrushmodeltoscriptmodel(level._id_1AEC);
  wait(var_2);
  var_2 = 0.45;
  var_1 clonebrushmodeltoscriptmodel(level._id_1AEB);
  wait(var_2);
  var_2 = 9.8;
  var_1 clonebrushmodeltoscriptmodel(level._id_1AEA);
  wait(var_2);
  var_2 = 1.0;
  var_1 clonebrushmodeltoscriptmodel(level._id_1AEB);
  wait(var_2);
  var_2 = 0.65;
  var_1 clonebrushmodeltoscriptmodel(level._id_1AEC);
  wait(var_2);
  var_1 delete();
}

bot_add_scavenger_bag(var_0) {
  var_1 = 0;
  var_0._id_1B7B = "scavenger_bag";
  var_0._id_1B7A = 1;

  if(!isDefined(level._id_1ABB)) {
    level._id_1ABB = [];
  }

  foreach(var_4, var_3 in level._id_1ABB) {
    if(!isDefined(var_3)) {
      var_1 = 1;
      level._id_1ABB[var_4] = var_0;
      break;
    }
  }

  if(!var_1) {
    level._id_1ABB[level._id_1ABB.size] = var_0;
  }

  foreach(var_6 in level._id_6E97) {
    if(_isai(var_6) && var_6 maps\mp\_utility::_hasperk("specialty_scavenger")) {
      var_6 notify("new_crate_to_take");
    }
  }
}

_id_1B07() {
  var_0 = getEntArray("bot_flag_set", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_0165)) {
      continue;
    }
    var_2 thread _id_19D2(var_2._id_0165);
  }
}

_id_19D2(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(maps\mp\_utility::_id_5666(var_1)) {
      var_1 notify("flag_trigger_set_" + var_0);
      var_1 botsetflag(var_0, 1);
      var_1 thread _id_19D3(var_0);
    }
  }
}

_id_19D3(var_0) {
  self endon("flag_trigger_set_" + var_0);
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  waitframe();
  waittillframeend;
  self botsetflag(var_0, 0);
}