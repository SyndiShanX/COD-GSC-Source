/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_dd.gsc
***********************************************/

main() {
  setup_callbacks();
  damage_data();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::damage_empty_vehicles_infrontofme;
  level.bot_funcs["_encstr_93391C9BEDA34B33F2AF5637565B5EEB4CDEA3B9AF4C7BD6267D5D6E2B91"] = ::notify_enemy_team_bomb_used;
}

damage_data() {
  setup_bot_dd();
}

setup_bot_dd() {
  damage_multiplier();
  _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_setup_objective_bottargets();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_0 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::debug_consoles(["_encstr_B20703DFCF", "_encstr_B40703E96D"]);

  if(var_0) {
    foreach(var_2 in level.objectives)
    var_2 thread _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::monitor_bombzone_control();

    thread cypher_vo_hack_progress();
    level.bot_gametype_precaching_done = 1;
  }
}

damage_empty_vehicles_infrontofme() {
  self notify("_encstr_8C530D31DBA3BEC88CAF8E0DB4DCD6");
  self endon("_encstr_8C530D31DBA3BEC88CAF8E0DB4DCD6");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);
  self.current_bombzone = undefined;
  self.defuser_bad_path_counter = 0;

  for(;;) {
    wait 0.05;

    if(isDefined(self.current_bombzone) && !current_puddle_count(self.current_bombzone)) {
      self.current_bombzone = undefined;
      cypher_vo_intro();
    }

    if(scripts\mp\utility\game::inovertime())
      var_0 = level.objectives["_encstr_B20703DFCF"].ownerteam != self.team;
    else
      var_0 = self.team == game["_encstr_991C0AB9ED5B57161FE89B83"];

    if(var_0) {
      deafen_ai("_encstr_999A07C61338F9A23A");

      if(!isDefined(self.current_bombzone)) {
        continue;
      }
      debug_calculatecashonground();
      custom_helicopter_firendly_dmg_func();

      if(self.role == "_encstr_A9570BDCBB95AC1CFAA7BDE695") {
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(self.current_bombzone.curorigin)) {
          var_1["_encstr_A3350E30CAC5DF89D71141D0FC373063"] = 2;
          var_1["_encstr_82E20ED21780D944E75EF94F139CE05B"] = 4;
          var_1["_encstr_8D9715A8C35F281DB93F3107FF7268CA83581FF20F8F41"] = scripts\engine\utility::random(self.current_bombzone.bottargets);
          scripts\mp\bots\bots_strategy::bot_protect_point(self.current_bombzone.curorigin, level.protect_radius, var_1);
        }
      } else if(self.role == "_encstr_96760C13A849ED6A59389E7D9873") {
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.ddbombmodel[self.current_bombzone.objectivekey].origin)) {
          var_1["_encstr_91F90CB98DBD93B2F533B10BEC9B"] = "_encstr_AC5616B32065A5C39959113FE783FF6CE1E13AAA98319F7B";
          scripts\mp\bots\bots_strategy::bot_protect_point(level.ddbombmodel[self.current_bombzone.objectivekey].origin, level.protect_radius, var_1);
        }
      } else if(self.role == "_encstr_88201F9BB54BE34B54BF280BD39D0607229D05100DD2CFF33B97683897B258435A")
        trial_target_think();
      else if(self.role == "_encstr_86350B2290E7F9A3C8A97A753E")
        plant_bomb();

      continue;
    }

    deafen_ai("_encstr_A20C07ABF304625E08");

    if(!isDefined(self.current_bombzone)) {
      continue;
    }
    custom_putongroundfunc();

    if(self.role == "_encstr_96760C13A849ED6A59389E7D9873") {
      if(!scripts\mp\bots\bots_util::bot_is_defending_point(self.current_bombzone.curorigin)) {
        var_1["_encstr_91F90CB98DBD93B2F533B10BEC9B"] = "_encstr_850A0BF7D10EA25388CE05CD63";
        var_1["_encstr_8D9715A8C35F281DB93F3107FF7268CA83581FF20F8F41"] = scripts\engine\utility::random(self.current_bombzone.bottargets);
        scripts\mp\bots\bots_strategy::bot_protect_point(self.current_bombzone.curorigin, level.protect_radius, var_1);
      }

      continue;
    }

    if(self.role == "_encstr_88201F9BB54BE34B54BF280BD39D0607229D05100DD2CFF33B97683897B258435A") {
      trial_target_think();
      continue;
    }

    if(self.role == "_encstr_887B0891B2CCD59BB293")
      defuse_bomb();
  }
}

notify_enemy_team_bomb_used(var_0) {
  var_1 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::find_closest_bombzone_to_player(self);
  var_2 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::prematchinitx1blueprintloadouts(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4.current_bombzone) && var_1 == var_4.current_bombzone)
      var_4 damage_area("_encstr_88201F9BB54BE34B54BF280BD39D0607229D05100DD2CFF33B97683897B258435A");
  }
}

plant_bomb() {
  self endon("_encstr_96400C3F90AE805C7F1193380A57");
  var_0 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::process_should_do_pain(self.current_bombzone, 0);
  self botsetscriptgoal(var_0.origin, 0, "_encstr_99CC09DA9020C4ECD149AD");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_96400C3F90AE805C7F1193380A57");

  if(var_1 == "_encstr_8B7205D9ED5958") {
    var_2 = scripts\mp\gamelogic::gettimeremaining();
    var_3 = var_2 - level.planttime * 2 * 1000;
    var_4 = gettime() + var_3;

    if(var_3 > 0)
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var_3);

    var_5 = var_4 > 0 && gettime() >= var_4;
    var_6 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::current_respawn_point_override(level.planttime + 2, "_encstr_AB3D0DE25FE81EF7B7188A42230553", var_5);
    self botclearscriptgoal();

    if(var_6)
      cypher_vo_intro();
  }
}

defuse_bomb() {
  self endon("_encstr_96400C3F90AE805C7F1193380A57");
  self botsetpathingstyle("_encstr_84DB09430E5B9A0B6D2001");
  var_0 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::process_players_inside_subway_car(self.current_bombzone).origin;
  self botsetscriptgoal(var_0, 20, "_encstr_99CC09DA9020C4ECD149AD");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_96400C3F90AE805C7F1193380A57");

  if(var_1 == "_encstr_86E5092BA829F7AB738DA4") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      for(;;) {
        var_2 = getnodesinradiussorted(var_0, 50, 0);
        var_3 = self.defuser_bad_path_counter - 4;

        if(var_2.size <= var_3) {
          var_4 = botgetclosestnavigablepoint(var_0, 50, self);

          if(isDefined(var_4))
            self botsetscriptgoal(var_4, 20, "_encstr_99CC09DA9020C4ECD149AD");
          else
            break;
        } else
          self botsetscriptgoal(var_2[var_3].origin, 20, "_encstr_99CC09DA9020C4ECD149AD");

        var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_96400C3F90AE805C7F1193380A57");

        if(var_1 == "_encstr_86E5092BA829F7AB738DA4") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(var_1 == "_encstr_8B7205D9ED5958") {
    var_5 = gettime() - self.current_bombzone.startbombtime;
    var_6 = level.bombtimer * 1000 - var_5;
    var_7 = var_6 - level.defusetime * 2 * 1000;
    var_8 = gettime() + var_7;

    if(var_7 > 0)
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var_7);

    var_9 = var_8 > 0 && gettime() >= var_8;
    var_10 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::current_respawn_point_override(level.defusetime + 2, "_encstr_ACA10DAE80E31A1FC960CB8FF8C11C", var_9);

    if(!var_10 && self.defuser_bad_path_counter >= 4)
      self.defuser_bad_path_counter++;

    self botclearscriptgoal();

    if(var_10)
      cypher_vo_intro();
  }
}

trial_target_think() {
  self endon("_encstr_96400C3F90AE805C7F1193380A57");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  self botsetscriptgoalnode(scripts\engine\utility::random(self.current_bombzone.bottargets), "_encstr_99CC09DA9020C4ECD149AD");
  var_0 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_0 == "_encstr_8B7205D9ED5958") {
    wait 2;
    cypher_vo_intro();
  }
}

quickdropitem(var_0) {
  var_1 = race_calculate_stars(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      if(var_3.isdefusing)
        return var_3;
    }
  }

  foreach(var_3 in var_1) {
    if(isai(var_3)) {
      if(isDefined(var_3.role) && var_3.role == "_encstr_887B0891B2CCD59BB293")
        return var_3;
    }
  }

  return undefined;
}

quickdropremovefrominventory(var_0) {
  var_1 = race_calculate_stars(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      if(var_3.isplanting)
        return var_3;
    }
  }

  foreach(var_3 in var_1) {
    if(isai(var_3)) {
      if(isDefined(var_3.role) && var_3.role == "_encstr_86350B2290E7F9A3C8A97A753E")
        return var_3;
    }
  }

  return undefined;
}

current_puddle_count(var_0) {
  if(var_0.visibleteam == "_encstr_9A19040BCDBC")
    return 1;

  return 0;
}

pregeneratespawnpoints() {
  var_0 = [];

  foreach(var_2 in level.objectives) {
    if(current_puddle_count(var_2))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

race_calculate_stars(var_0, var_1) {
  var_2 = [];
  var_3 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::get_living_players_on_team(var_1);

  foreach(var_5 in var_3) {
    if(isai(var_5)) {
      if(isDefined(var_5.current_bombzone) && var_5.current_bombzone == var_0)
        var_2 = scripts\engine\utility::array_add(var_2, var_5);

      continue;
    }

    if(distancesquared(var_5.origin, var_0.curorigin) < level.protect_radius * level.protect_radius)
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
  }

  return var_2;
}

deadred(var_0, var_1) {
  var_2[0] = race_calculate_stars(var_0[0], game["_encstr_B6A70A23CA6659DC91CAE4DC"]).size;
  var_2[1] = race_calculate_stars(var_0[1], game["_encstr_B6A70A23CA6659DC91CAE4DC"]).size;

  if(var_2[0] > var_2[1] + var_1)
    return var_0[1];
  else if(var_2[0] + var_1 < var_2[1])
    return var_0[0];
}

deafen_ai(var_0) {
  var_1 = undefined;

  if(var_0 == "_encstr_999A07C61338F9A23A")
    var_1 = custom_loadout_index();
  else if(var_0 == "_encstr_A20C07ABF304625E08")
    var_1 = custom_shouldtakedamage();

  if(isDefined(var_1) && (!isDefined(self.current_bombzone) || self.current_bombzone != var_1)) {
    self.current_bombzone = var_1;
    cypher_vo_intro();
  }
}

custom_shouldtakedamage() {
  var_0 = pregeneratespawnpoints();
  var_1 = undefined;

  if(var_0.size == 1)
    var_1 = var_0[0];
  else if(var_0.size == 2) {
    var_2[0] = race_calculate_stars(var_0[0], game["_encstr_B6A70A23CA6659DC91CAE4DC"]).size;
    var_2[1] = race_calculate_stars(var_0[1], game["_encstr_B6A70A23CA6659DC91CAE4DC"]).size;
    var_3[0] = is_bomb_planted_on(var_0[0]);
    var_3[1] = is_bomb_planted_on(var_0[1]);

    if(var_3[0] && var_3[1] || !var_3[0] && !var_3[1]) {
      var_4 = 0;

      if(isDefined(self.current_bombzone))
        var_4 = 1;

      var_1 = deadred(var_0, var_4);

      if(!isDefined(var_1) && !isDefined(self.current_bombzone))
        var_1 = scripts\engine\utility::random(var_0);
    } else if(var_3[0] || var_3[1]) {
      var_5 = scripts\engine\utility::ter_op(var_3[0], 0, 1);
      var_6 = scripts\engine\utility::ter_op(!var_3[0], 0, 1);

      if(var_2[var_5] > var_2[var_6] + 2)
        var_1 = var_0[var_6];
      else if(var_2[var_5] <= var_2[var_6])
        var_1 = var_0[var_5];
      else if(!isDefined(self.current_bombzone)) {
        if(var_2[var_5] >= var_2[var_6] + 2)
          var_1 = var_0[var_6];
        else if(var_2[var_5] < var_2[var_6] + 2)
          var_1 = var_0[var_5];
      }
    }
  }

  return var_1;
}

quickdropaddtocache(var_0) {
  var_1 = pregeneratespawnpoints();

  foreach(var_3 in var_1) {
    if(var_3 != var_0)
      return var_3;
  }
}

custom_loadout_index() {
  if(isDefined(self.current_bombzone)) {
    return;
  }
  if(!isDefined(level.current_zone_target) || !current_puddle_count(level.current_zone_target) || gettime() > level.next_target_switch_time) {
    level.next_target_switch_time = gettime() + 1000 * randomintrange(30, 45);
    level.current_zone_target = scripts\engine\utility::random(pregeneratespawnpoints());
  }

  if(!isDefined(level.current_zone_target)) {
    return;
  }
  var_0 = level.current_zone_target;
  var_1 = quickdropaddtocache(var_0);
  self.current_bombzone = undefined;

  if(isDefined(var_1)) {
    if(randomfloat(1.0) < 0.25)
      return var_1;
  }

  return var_0;
}

debug_calculatecashonground() {
  var_0 = quickdropaddtocache(self.current_bombzone);

  if(isDefined(var_0)) {
    var_1 = distance(self.origin, self.current_bombzone.curorigin);
    var_2 = distance(self.origin, var_0.curorigin);

    if(var_2 < var_1 * 0.6)
      self.current_bombzone = var_0;
  }
}

custom_helicopter_firendly_dmg_func() {
  if(isDefined(self.role)) {
    if(self.role == "_encstr_88201F9BB54BE34B54BF280BD39D0607229D05100DD2CFF33B97683897B258435A")
      return;
  }

  var_0 = undefined;

  if(is_bomb_planted_on(self.current_bombzone))
    var_0 = "_encstr_96760C13A849ED6A59389E7D9873";
  else {
    var_1 = quickdropremovefrominventory(self.current_bombzone);

    if(!isDefined(var_1) || var_1 == self)
      var_0 = "_encstr_86350B2290E7F9A3C8A97A753E";
    else if(isai(var_1)) {
      var_2 = distance(self.origin, self.current_bombzone.curorigin);
      var_3 = distance(var_1.origin, self.current_bombzone.curorigin);

      if(var_2 < var_3 * 0.9) {
        var_0 = "_encstr_86350B2290E7F9A3C8A97A753E";
        var_1 cypher_vo_intro();
      }
    }
  }

  if(!isDefined(var_0))
    var_0 = "_encstr_A9570BDCBB95AC1CFAA7BDE695";

  damage_area(var_0);
}

custom_putongroundfunc() {
  if(isDefined(self.role)) {
    if(self.role == "_encstr_88201F9BB54BE34B54BF280BD39D0607229D05100DD2CFF33B97683897B258435A")
      return;
  }

  var_0 = undefined;

  if(is_bomb_planted_on(self.current_bombzone)) {
    var_1 = quickdropitem(self.current_bombzone);

    if(!isDefined(var_1) || var_1 == self)
      var_0 = "_encstr_887B0891B2CCD59BB293";
    else if(isai(var_1)) {
      var_2 = distance(self.origin, self.current_bombzone.curorigin);
      var_3 = distance(var_1.origin, self.current_bombzone.curorigin);

      if(var_2 < var_3 * 0.9) {
        var_0 = "_encstr_887B0891B2CCD59BB293";
        var_1 cypher_vo_intro();
      }
    }
  }

  if(!isDefined(var_0))
    var_0 = "_encstr_96760C13A849ED6A59389E7D9873";

  damage_area(var_0);
}

damage_area(var_0) {
  if(!isDefined(self.role) || self.role != var_0) {
    cypher_vo_intro();
    self.role = var_0;
  }
}

cypher_vo_intro() {
  self.role = undefined;
  self botclearscriptgoal();
  self botsetpathingstyle(undefined);
  scripts\mp\bots\bots_strategy::bot_defend_stop();
  self notify("_encstr_96400C3F90AE805C7F1193380A57");
  self.defuser_bad_path_counter = 0;
}

cypher_vo_hack_progress() {
  level notify("_encstr_B8CA1A9BCF35F96C2016AEB40EF8B9E3056F4B379DC803300839E3BF");
  level endon("_encstr_B8CA1A9BCF35F96C2016AEB40EF8B9E3056F4B379DC803300839E3BF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.protect_radius = 725;

  for(;;) {
    foreach(var_1 in level.objectives) {
      foreach(var_3 in level.players) {
        if(isDefined(var_3.role) && isDefined(var_3.current_bombzone) && var_3.current_bombzone == var_1) {
          if(!current_puddle_count(var_1)) {
            if(var_3.role == "_encstr_86350B2290E7F9A3C8A97A753E" || var_3.role == "_encstr_887B0891B2CCD59BB293")
              var_3 cypher_vo_intro();

            continue;
          }

          if(is_bomb_planted_on(var_1)) {
            if(var_3.role == "_encstr_86350B2290E7F9A3C8A97A753E")
              var_3 cypher_vo_intro();
          }
        }
      }
    }

    wait 0.5;
  }
}

is_bomb_planted_on(var_0) {
  return istrue(var_0.bombplanted);
}

vehicle_compass_br_shouldbevisibletoplayer(var_0) {
  var_1 = spawncovernode(var_0, (0, randomint(360), 0), "_encstr_AFFF0C6E8FE899DDE6174B068510");
}

damage_multiplier() {
  switch (level.mapname) {
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
      var_0 = (67, 1916, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (7, 1877, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (-35, 1925, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (-28, 1878, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (69, 1879, 22);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    case "_encstr_B6EE0A72AB0863F3C065A5BA":
      var_0 = (196, -1338, 257);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (920, 821, 260);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (1005, 707, 260);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (-53, -411, 262);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    case "_encstr_82670A6D9FF7A9AAD022B0CA":
      var_0 = (-226, -791, 100);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    default:
      break;
  }
}