/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_to_dd.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_dd();
}

setup_callbacks() {
  level.bot_funcs["_encstr_99EB0E12DB5279E596CEBBD2C11B30F8"] = ::crate_can_use;
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_demolition_think;
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype))
    return 0;

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype))
    return 0;

  return is_protecting_zone();
}

iw7_ship_hack_add_bombzone_node(var_0, var_1) {
  if(var_0 == 0)
    var_0 = "_encstr_B20703DFCF";
  else
    var_0 = "_encstr_B40703E96D";

  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.angles = (0, randomint(360), 0);
  level.objectives[var_0].bottargets[level.objectives[var_0].bottargets.size] = var_2;
}

bot_fixup_bombzone_issues() {
  if(level.mapname == "_encstr_B87F0EB06AB7C53DD5F36F98A0A86C33") {
    if(scripts\mp\utility\game::inovertime() && level.objectives["_encstr_B20703DFCF"].bottargets.size == 0) {
      var_0 = (-505, -361, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
      var_0 = (-582, -311, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
      var_0 = (-583, -387, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
      var_0 = (-583, -387, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
      var_0 = (-497, -326, 68);
      iw7_ship_hack_add_bombzone_node(0, var_0);
    }
  }
}

setup_bot_dd() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_0 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::debug_consoles(["_encstr_B20703DFCF", "_encstr_B40703E96D"]);

  if(var_0) {
    foreach(var_2 in level.objectives)
    var_2 thread _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::monitor_bombzone_control();

    level.bot_gametype_precaching_done = 1;
  }
}

getovertimebombzone() {
  return level.objectives["_encstr_B20703DFCF"];
}

isattacker() {
  if(!scripts\mp\utility\game::inovertime()) {
    if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
      return 1;

    return 0;
  }

  var_0 = getovertimebombzone();

  if(var_0.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63")
    return 1;

  if(var_0.ownerteam == self.team)
    return 0;

  return 1;
}

isdefender() {
  if(!scripts\mp\utility\game::inovertime()) {
    if(self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
      return 1;

    return 0;
  }

  var_0 = getovertimebombzone();

  if(var_0.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63")
    return 0;

  if(var_0.ownerteam == self.team)
    return 1;

  return 0;
}

bot_demolition_think() {
  self notify("_encstr_A5550E4C7B3A7D23CA5BAFD1A12DE66D");
  self endon("_encstr_A5550E4C7B3A7D23CA5BAFD1A12DE66D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  init_bot_game_demolition();
  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);
  self botsetflag("_encstr_8D1813AECD95D7B731A9BE83C21D0DAF9B8EBC6395", 1);
  self.is_defusing = 0;
  self.is_planting = 0;
  self.current_bombzone = undefined;

  if(!isDefined(level.next_game_update_time))
    level.next_game_update_time = gettime() - 100;

  for(;;) {
    wait 0.05;

    if(gettime() >= level.next_game_update_time) {
      update_game_demolition();
      level.next_game_update_time = gettime() + 100;
    }

    if(self.health <= 0) {
      continue;
    }
    if(scripts\mp\utility\game::inovertime() && !isDefined(self.current_bombzone))
      self.current_bombzone = getovertimebombzone();

    if(isattacker()) {
      if(self.is_planting)
        plant_bomb();
      else {
        if(!isDefined(self.current_bombzone))
          self.current_bombzone = find_best_bombzone("_encstr_991C0AB9ED5B57161FE89B83");

        if(isDefined(self.current_bombzone)) {
          if(is_bomb_planted_on(self.current_bombzone) && !is_protecting_zone())
            scripts\mp\bots\bots_strategy::bot_protect_point(self.current_bombzone.bottarget.origin, 600);
          else if(!is_bomb_planted_on(self.current_bombzone) && !is_capturing_zone()) {
            var_0["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = "_encstr_836105A5EFB2E5" + self.current_bombzone.label;
            scripts\mp\bots\bots_strategy::bot_capture_point(self.current_bombzone.bottarget.origin, 350, var_0);
          }
        }
      }

      continue;
    }

    if(self.is_defusing) {
      if(!isDefined(level.ddbombmodel[self.current_bombzone.label]))
        self.is_defusing = 0;
    }

    if(self.is_defusing) {
      defuse_bomb();
      continue;
    }

    if(!isDefined(self.current_bombzone))
      self.current_bombzone = find_best_bombzone("_encstr_B6A70A23CA6659DC91CAE4DC");

    if(isDefined(self.current_bombzone)) {
      if(is_bomb_planted_on(self.current_bombzone) && !is_capturing_zone()) {
        var_0["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = "_encstr_836105A5EFB2E5" + self.current_bombzone.label;
        scripts\mp\bots\bots_strategy::bot_capture_point(self.current_bombzone.bottarget.origin, 350, var_0);
        continue;
      }

      if(!is_bomb_planted_on(self.current_bombzone) && !is_protecting_zone())
        scripts\mp\bots\bots_strategy::bot_protect_point(self.current_bombzone.bottarget.origin, 600);
    }
  }
}

plant_bomb() {
  goto_bomb_and_use(1);
}

defuse_bomb() {
  goto_bomb_and_use(0);
}

goto_bomb_and_use(var_0) {
  scripts\mp\bots\bots_strategy::bot_defend_stop();

  if(var_0)
    self botsetscriptgoal(self.current_bombzone.bottarget.origin, 20, "_encstr_99CC09DA9020C4ECD149AD", self.current_bombzone.bottarget.angles[1]);
  else {
    var_1 = level.ddbombmodel[self.current_bombzone.label].origin;
    self botsetscriptgoal(var_1, 20, "_encstr_99CC09DA9020C4ECD149AD");
  }

  var_2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_996B122B0722419118FBAE010B3BB3D830F33DF5", "_encstr_889117E6F6BE63DBB99D9539D74C7BDA13AFC82BCCEA9BAC9C");

  if(var_2 == "_encstr_8B7205D9ED5958") {
    self botpressbutton("_encstr_AB19049D0FC0", level.defusetime + 2);
    waittill_usebutton_released_or_time(level.defusetime + 2, var_0);

    if(var_0)
      self.is_planting = 0;
    else
      self.is_defusing = 0;
  }
}

waittill_usebutton_released_or_time(var_0, var_1) {
  var_2 = gettime();
  var_3 = var_2 + var_0 * 1000;
  wait 0.05;

  while(self useButtonPressed() && gettime() < var_3 && isDefined(self.current_bombzone) && var_1 != is_bomb_planted_on(self.current_bombzone))
    wait 0.05;
}

is_protecting_zone() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

is_capturing_zone() {
  return scripts\mp\bots\bots_util::bot_is_capturing();
}

get_bots_using_zone(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(var_1 == "_encstr_991C0AB9ED5B57161FE89B83" && !var_4 isattacker()) {
      continue;
    }
    if(var_1 == "_encstr_B6A70A23CA6659DC91CAE4DC" && !var_4 isdefender()) {
      continue;
    }
    if(isalive(var_4) && scripts\mp\utility\entity::isteamparticipant(var_4) && isDefined(var_4.current_bombzone) && var_4.current_bombzone == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

get_bot_defusing_zone(var_0) {
  var_1 = get_bots_using_zone(var_0, "_encstr_B6A70A23CA6659DC91CAE4DC");

  foreach(var_3 in var_1) {
    if(var_3.is_defusing)
      return var_3;
  }

  return undefined;
}

get_bot_planting_zone(var_0) {
  var_1 = get_bots_using_zone(var_0, "_encstr_991C0AB9ED5B57161FE89B83");

  foreach(var_3 in var_1) {
    if(var_3.is_planting)
      return var_3;
  }

  return undefined;
}

find_best_bombzone(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    if(!istrue(var_3.bombexploded)) {
      var_4 = 0;

      if(var_0 == "_encstr_B6A70A23CA6659DC91CAE4DC")
        var_4 = var_3.bots_defending_wanted > get_bots_using_zone(var_3, "_encstr_B6A70A23CA6659DC91CAE4DC").size;
      else if(var_0 == "_encstr_991C0AB9ED5B57161FE89B83")
        var_4 = var_3.bots_attacking_wanted > get_bots_using_zone(var_3, "_encstr_991C0AB9ED5B57161FE89B83").size;

      if(var_4)
        var_1[var_1.size] = var_3;
    }
  }

  var_6 = undefined;

  if(var_1.size > 0) {
    var_7 = 999999999;

    foreach(var_3 in var_1) {
      var_9 = distancesquared(var_3.bottarget.origin, self.origin);

      if(var_9 < var_7) {
        var_6 = var_3;
        var_7 = var_9;
      }
    }
  }

  return var_6;
}

update_game_demolition() {
  var_0 = [];

  foreach(var_2 in level.objectives) {
    if(!istrue(var_2.bombexploded))
      var_0[var_0.size] = var_2;
  }

  if(level.prev_num_active_zones == 2 && var_0.size == 1) {
    foreach(var_5 in level.participants) {
      if(scripts\mp\utility\entity::isteamparticipant(var_5) && isDefined(var_5.current_bombzone) && var_5.current_bombzone != var_0[0]) {
        var_5.current_bombzone = undefined;
        var_5 scripts\mp\bots\bots_strategy::bot_defend_stop();
        var_5 notify("_encstr_996B122B0722419118FBAE010B3BB3D830F33DF5");
        var_5.is_defusing = 0;
        var_5.is_planting = 0;
      }
    }

    level.prev_num_active_zones = 1;
  }

  update_demolition_attackers(var_0);
  update_demolition_defenders(var_0);
}

update_demolition_attackers(var_0) {
  if(gettime() > level.next_target_switch_time) {
    level.current_zone_target = 1 - level.current_zone_target;
    level.next_target_switch_time = gettime() + 90000;
  }

  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isaiteamparticipant(var_3) && isalive(var_3) && var_3 isattacker())
      var_1++;
  }

  if(var_0.size == 2) {
    if(var_1 >= 2)
      var_0[1 - level.current_zone_target].bots_attacking_wanted = 1;
    else
      var_0[1 - level.current_zone_target].bots_attacking_wanted = 0;

    var_0[level.current_zone_target].bots_attacking_wanted = var_1 - var_0[1 - level.current_zone_target].bots_attacking_wanted;
  } else if(var_0.size == 1)
    var_0[0].bots_attacking_wanted = var_1;

  foreach(var_6 in var_0) {
    var_7 = get_bots_using_zone(var_6, "_encstr_991C0AB9ED5B57161FE89B83");

    if(var_7.size > var_6.bots_attacking_wanted) {
      var_7 = scripts\engine\utility::array_randomize(var_7);

      foreach(var_9 in var_7) {
        if(!var_9.is_planting) {
          var_9.current_bombzone = undefined;
          var_9 scripts\mp\bots\bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var_6 in var_0) {
    if(!is_bomb_planted_on(var_6) && !isDefined(get_bot_planting_zone(var_6))) {
      var_7 = get_bots_using_zone(var_6, "_encstr_991C0AB9ED5B57161FE89B83");

      if(var_7.size > 0) {
        var_13 = scripts\engine\utility::get_array_of_closest(var_6.bottarget.origin, var_7);
        var_13[0].is_planting = 1;
        var_13[0] scripts\mp\bots\bots_strategy::bot_defend_stop();
      }
    }
  }
}

update_demolition_defenders(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isaiteamparticipant(var_3) && isalive(var_3) && var_3 isdefender())
      var_1++;
  }

  if(var_0.size == 2) {
    var_0[0].bots_defending_wanted = int(var_1 / 2);
    var_0[1].bots_defending_wanted = int(var_1 / 2);
    var_0[level.more_populated_bombzone].bots_defending_wanted = var_0[level.more_populated_bombzone].bots_defending_wanted + var_1 % 2;

    for(var_5 = 0; var_5 < var_0.size; var_5++) {
      if(is_bomb_planted_on(var_0[var_5])) {
        var_0[var_5].bots_defending_wanted++;
        var_0[1 - var_5].bots_defending_wanted--;
      }
    }
  } else if(var_0.size == 1)
    var_0[0].bots_defending_wanted = var_1;

  foreach(var_7 in var_0) {
    var_8 = get_bots_using_zone(var_7, "_encstr_B6A70A23CA6659DC91CAE4DC");

    if(var_8.size > var_7.bots_defending_wanted) {
      var_8 = scripts\engine\utility::array_randomize(var_8);

      foreach(var_10 in var_8) {
        if(!var_10.is_defusing) {
          var_10.current_bombzone = undefined;
          var_10 scripts\mp\bots\bots_strategy::bot_defend_stop();
          break;
        }
      }
    }
  }

  foreach(var_7 in var_0) {
    if(is_bomb_planted_on(var_7)) {
      var_14 = get_bot_defusing_zone(var_7);

      if(!isDefined(var_14) || gettime() > level.next_time_switch_defusers) {
        var_8 = get_bots_using_zone(var_7, "_encstr_B6A70A23CA6659DC91CAE4DC");

        if(var_8.size > 0) {
          var_15 = scripts\engine\utility::get_array_of_closest(var_7.bottarget.origin, var_8);

          if(!isDefined(var_14) || var_15[0] != var_14) {
            var_15[0].is_defusing = 1;
            var_15[0] scripts\mp\bots\bots_strategy::bot_defend_stop();

            if(isDefined(var_14)) {
              var_14.is_defusing = 0;
              var_14 notify("_encstr_889117E6F6BE63DBB99D9539D74C7BDA13AFC82BCCEA9BAC9C");
            }
          }
        }

        level.next_time_switch_defusers = gettime() + 2500;
      }
    }
  }
}

is_bomb_planted_on(var_0) {
  return isDefined(var_0.bombplanted) && var_0.bombplanted == 1;
}

init_bot_game_demolition() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }
  level.bots_gametype_initialized = 1;
  level.more_populated_bombzone = randomint(2);
  level.prev_num_active_zones = 2;
  level.current_zone_target = randomint(2);
  level.next_target_switch_time = gettime() + 90000;
  level.next_time_switch_defusers = 0;
}