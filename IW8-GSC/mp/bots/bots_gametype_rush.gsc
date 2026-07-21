/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_rush.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_hardpoint();
}

setup_hardpoint() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  thread bot_hardpoint_ai_director_update();
  level.protect_radius = 128;
  level.patrol_radius = 800;
  level.bot_gametype_precaching_done = 1;
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_hardpoint_think;
}

initialize_role() {
  var_0 = get_allied_attackers_for_team(self.team);
  var_1 = get_allied_defenders_for_team(self.team);
  var_2 = bot_attacker_limit_for_team(self.team);
  var_3 = bot_defender_limit_for_team(self.team);
  var_4 = level.bot_personality_type[self.personality];

  if(var_4 == "_encstr_930B07BB1B6B3854FF") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(isai(var_7) && level.bot_personality_type[var_7.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
          var_7.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        bot_set_role("_encstr_AA7B09475984AF0F6F0F0B");
        return;
      }

      bot_set_role("_encstr_8E460991ACCC59378C56C9");
      return;
    } else
      bot_set_role("_encstr_AA7B09475984AF0F6F0F0B");
  } else if(var_4 == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(isai(var_10) && level.bot_personality_type[var_10.personality] == "_encstr_930B07BB1B6B3854FF") {
          var_10.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        bot_set_role("_encstr_8E460991ACCC59378C56C9");
        return;
      }

      bot_set_role("_encstr_AA7B09475984AF0F6F0F0B");
      return;
    } else
      bot_set_role("_encstr_8E460991ACCC59378C56C9");
  }
}

bot_hardpoint_think() {
  self notify("_encstr_9A990F5B7F5B199F72F84C8753116A08BB");
  self endon("_encstr_9A990F5B7F5B199F72F84C8753116A08BB");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self botclearscriptgoal();

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(level.currentobjective)) {
      continue;
    }
    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      continue;
    }
    if(!isDefined(self.role))
      initialize_role();

    if(!istrue(self.bot_defending)) {
      var_0 = undefined;
      var_1 = undefined;
    }

    if(self.role == "_encstr_AA7B09475984AF0F6F0F0B") {
      var_2 = 0;
      var_1 = undefined;

      if(!isDefined(var_0))
        var_2 = 1;
      else if(isDefined(level.currentobjective.trigger)) {
        if(var_0 != level.currentobjective.trigger)
          var_2 = 1;
      }

      if(var_2) {
        var_3 = getclosestpointonnavmesh(level.currentobjective.trigger.origin, self);
        var_4["_encstr_A3350E30CAC5DF89D71141D0FC373063"] = 1;
        var_4["_encstr_82E20ED21780D944E75EF94F139CE05B"] = 4;
        scripts\mp\bots\bots_strategy::bot_patrol_area(var_3, level.patrol_radius, var_4);
        var_0 = level.currentobjective.trigger;
      }

      continue;
    }

    if(self.role == "_encstr_8E460991ACCC59378C56C9") {
      var_0 = undefined;
      var_5 = 0;

      if(!isDefined(var_1))
        var_5 = 1;
      else if(isDefined(level.currentobjective.trigger)) {
        if(var_1 != level.currentobjective.trigger)
          var_5 = 1;
      }

      if(var_5) {
        var_6 = getnodesintrigger(level.currentobjective.trigger);

        if(var_6.size > 0) {
          var_4["_encstr_A3350E30CAC5DF89D71141D0FC373063"] = 3;
          var_4["_encstr_82E20ED21780D944E75EF94F139CE05B"] = 6;
          scripts\mp\bots\bots_strategy::bot_capture_zone(level.currentobjective.trigger.origin, var_6, level.currentobjective.trigger, var_4);
          var_1 = level.currentobjective.trigger;
        }
      }
    }
  }
}

bot_attacker_limit_for_team(var_0) {
  var_1 = get_num_players_on_team(var_0);
  return int(int(var_1) / 2) + 1 + int(var_1) % 2;
}

bot_defender_limit_for_team(var_0) {
  var_1 = get_num_players_on_team(var_0);
  return max(int(int(var_1) / 2) - 1, 0);
}

get_num_players_on_team(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var_3) && isDefined(var_3.team) && var_3.team == var_0)
      var_1++;
  }

  return var_1;
}

get_allied_attackers_for_team(var_0) {
  var_1 = get_players_by_role("_encstr_AA7B09475984AF0F6F0F0B", var_0);

  if(isDefined(level.currentobjective.trigger)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(!var_3 istouching(level.currentobjective.trigger))
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }
  }

  return var_1;
}

get_allied_defenders_for_team(var_0) {
  var_1 = get_players_by_role("_encstr_8E460991ACCC59378C56C9", var_0);

  if(isDefined(level.currentobjective.trigger)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(var_3 istouching(level.currentobjective.trigger))
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }
  }

  return var_1;
}

get_players_by_role(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(isalive(var_4) && scripts\mp\utility\entity::isteamparticipant(var_4) && var_4.team == var_1 && isDefined(var_4.role) && var_4.role == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

bot_set_role(var_0) {
  self.role = var_0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

is_b_better_defender(var_0, var_1) {
  var_2 = var_0 istouching(level.currentobjective.trigger);
  var_3 = var_1 istouching(level.currentobjective.trigger);

  if(var_2 != var_3) {
    if(var_2)
      return 0;

    return 1;
  }

  if(var_2) {
    if(var_0.role != var_1.role) {
      if(var_1.role == "_encstr_8E460991ACCC59378C56C9")
        return 1;

      return 0;
    }
  }

  var_4 = distance2dsquared(var_0.origin, level.currentobjective.trigger.origin);
  var_5 = distance2dsquared(var_1.origin, level.currentobjective.trigger.origin);

  if(var_4 < var_5)
    return 1;

  return 0;
}

bot_hardpoint_ai_director_update() {
  level notify("_encstr_BD3A2158BA53EF58DF1255571727407171A28829A2ACEDB1BF3CE84ECF7FCB29A65B10");
  level endon("_encstr_BD3A2158BA53EF58DF1255571727407171A28829A2ACEDB1BF3CE84ECF7FCB29A65B10");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0[0] = "_encstr_9A8507BA4040188D08";
  var_0[1] = "_encstr_8E8405EA382B2A";
  var_1["_encstr_9A8507BA4040188D08"] = 0;
  var_1["_encstr_8E8405EA382B2A"] = 0;

  for(;;) {
    var_2 = "_encstr_A7A408B9CA5D1D4E2C63";

    if(!isDefined(level.currentobjective)) {
      wait 1.0;
      continue;
    }

    if(isDefined(level.currentobjective.trigger))
      var_2 = level.currentobjective scripts\mp\gameobjects::getownerteam();

    foreach(var_4 in var_0) {
      var_5 = [];
      var_6 = [];

      if(var_4 != var_2) {
        var_1[var_4] = 0;

        foreach(var_8 in level.participants) {
          if(scripts\mp\utility\entity::isteamparticipant(var_8) && isDefined(var_8.team) && var_8.team == var_4) {
            if(isbot(var_8) && (!isDefined(var_8.role) || var_8.role != "_encstr_8E460991ACCC59378C56C9"))
              var_8 bot_set_role("_encstr_8E460991ACCC59378C56C9");
          }
        }

        continue;
      }

      var_10 = bot_attacker_limit_for_team(var_4);
      var_11 = bot_defender_limit_for_team(var_4);

      if(!var_1[var_4]) {
        var_1[var_4] = 1;
        var_12 = [];

        foreach(var_8 in level.participants) {
          if(scripts\mp\utility\entity::isteamparticipant(var_8) && isDefined(var_8.team) && var_8.team == var_4) {
            if(isbot(var_8))
              var_12[var_12.size] = var_8;
          }
        }

        var_15 = scripts\engine\utility::array_sort_with_func(var_12, ::is_b_better_defender);

        if(var_12.size < var_11)
          var_11 = var_12.size;

        var_11 = int(var_11);

        for(var_16 = 0; var_16 < var_11; var_16++)
          var_12[var_16] bot_set_role("_encstr_8E460991ACCC59378C56C9");

        for(var_16 = var_11; var_16 < var_12.size; var_16++)
          var_12[var_16] bot_set_role("_encstr_AA7B09475984AF0F6F0F0B");

        wait 1;
        continue;
      }

      var_17 = get_allied_attackers_for_team(var_4);
      var_18 = get_allied_defenders_for_team(var_4);

      if(var_17.size > var_10) {
        var_19 = 0;

        foreach(var_21 in var_17) {
          if(isai(var_21)) {
            if(level.bot_personality_type[var_21.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
              var_21 bot_set_role("_encstr_8E460991ACCC59378C56C9");
              var_19 = 1;
              break;
            } else
              var_5 = scripts\engine\utility::array_add(var_5, var_21);
          }
        }

        if(!var_19 && var_5.size > 0)
          scripts\engine\utility::random(var_5) bot_set_role("_encstr_8E460991ACCC59378C56C9");
      }

      if(var_18.size > var_11) {
        var_23 = 0;

        foreach(var_25 in var_18) {
          if(isai(var_25)) {
            if(level.bot_personality_type[var_25.personality] == "_encstr_930B07BB1B6B3854FF") {
              var_25 bot_set_role("_encstr_AA7B09475984AF0F6F0F0B");
              var_23 = 1;
              break;
            } else
              var_6 = scripts\engine\utility::array_add(var_6, var_25);
          }
        }

        if(!var_23 && var_6.size > 0)
          scripts\engine\utility::random(var_6) bot_set_role("_encstr_AA7B09475984AF0F6F0F0B");
      }

      if(var_18.size == 0) {
        var_27 = get_players_by_role("_encstr_AA7B09475984AF0F6F0F0B", var_4);

        if(var_27.size > 0)
          scripts\engine\utility::random(var_27) bot_set_role("_encstr_8E460991ACCC59378C56C9");
      }
    }

    wait 1.0;
  }
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype))
    return 0;

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype))
    return 0;

  return !scripts\mp\bots\bots_util::bot_is_defending() || scripts\mp\bots\bots_util::bot_is_protecting();
}

setup_bot_koth() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();

  while(!isDefined(level.objectives))
    wait 0.05;

  _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_setup_objective_bottargets();

  foreach(var_1 in level.objectives)
  var_1 thread _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::monitor_zone_control();

  _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_cache_entrances_to_gametype_array(level.objectives, "_encstr_AF1106BEE91BA04F", level.bot_ignore_precalc_paths);
  level.bot_gametype_precaching_done = 1;
}

bot_headquarters_think() {
  self notify("_encstr_86540DF61D837FB0C9CF08E03FFEE8");
  self endon("_encstr_86540DF61D837FB0C9CF08E03FFEE8");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);
  init_bot_game_headquarters();

  for(;;) {
    var_0 = randomintrange(1, 11) * 0.05;
    wait(var_0);

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level.radioobject)) {
      if(scripts\mp\bots\bots_util::bot_is_defending())
        scripts\mp\bots\bots_strategy::bot_defend_stop();

      var_1 = 1;

      if(self botgetscriptgoaltype() != "_encstr_8BBA05185F8B99") {
        var_2 = distancesquared(self botgetscriptgoal(), self.origin);
        var_3 = self botgetscriptgoalRadius();

        if(var_2 > var_3 * var_3)
          var_1 = 0;
      }

      if(var_1) {
        var_4 = self botfindrandomgoal();

        if(isDefined(var_4))
          self botsetscriptgoal(var_4, 128, "_encstr_9ACC05B4156DF3");
      }

      continue;
    }

    var_5 = level.radioobject scripts\mp\gameobjects::getownerteam();

    if(self.team != var_5) {
      if(!is_capturing_current_headquarters()) {
        var_6 = get_num_ai_capturing_headquarters();
        var_7 = find_current_radio().bot_nodes.size;

        if(var_6 < var_7)
          capture_current_headquarters();
        else if(!is_protecting_current_headquarters())
          protect_current_headquarters();
      }
    } else if(!is_protecting_current_headquarters()) {
      wait(randomfloat(2));

      if(isDefined(level.radioobject))
        protect_current_headquarters();
    }
  }
}

find_current_radio() {
  foreach(var_1 in level.radios) {
    if(var_1.trig == level.radioobject.trigger)
      return var_1;
  }
}

is_capturing_current_headquarters() {
  return scripts\mp\bots\bots_util::bot_is_capturing();
}

get_num_ai_capturing_headquarters() {
  var_0 = 0;

  foreach(var_2 in level.participants) {
    if(isai(var_2) && var_2.health > 0 && var_2.team == self.team && var_2 is_capturing_current_headquarters())
      var_0++;
  }

  return var_0;
}

capture_current_headquarters() {
  var_0 = find_current_radio();
  var_1["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = "_encstr_AF1106BEE91BA04F" + var_0.objectivekey;
  scripts\mp\bots\bots_strategy::bot_capture_zone(var_0.origin, var_0.bot_nodes, undefined, var_1);
}

is_protecting_current_headquarters() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

protect_current_headquarters() {
  var_0 = self botgetworldsize();
  var_1 = (var_0[0] + var_0[1]) / 2;
  var_2 = min(1000, var_1 / 4);
  scripts\mp\bots\bots_strategy::bot_protect_point(find_current_radio().origin, var_2);
}

init_bot_game_headquarters() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }
  level.bots_gametype_initialized = 1;

  foreach(var_1 in level.radios)
  var_1.bot_nodes = getnodesintrigger(var_1.trig);
}