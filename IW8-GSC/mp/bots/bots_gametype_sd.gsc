/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_sd.gsc
***********************************************/

main() {
  setup_callbacks();
  bot_sd_start();
}

setup_callbacks() {
  level.bot_funcs["_encstr_99EB0E12DB5279E596CEBBD2C11B30F8"] = ::crate_can_use;
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_sd_think;
  level.bot_funcs["_encstr_AA071F6E347B5DD832FA6E4716C9D1EB36B05D3A4BB7EAE6BE16070EE4DBB0D80D"] = ::should_start_cautious_approach_sd;
  level.bot_funcs["_encstr_952F16EAC5AAB7BE35F36850974D73AFF26D486EDBA24503"] = undefined;
  level.bot_funcs["_encstr_93391C9BEDA34B33F2AF5637565B5EEB4CDEA3B9AF4C7BD6267D5D6E2B91"] = ::notify_enemy_team_bomb_used;
}

bot_sd_start() {
  setup_bot_sd();
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype))
    return 0;

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype))
    return 0;

  if(!scripts\mp\utility\entity::isteamparticipant(self))
    return 1;

  if(!isDefined(self.role))
    return 0;

  switch (self.role) {
    case "_encstr_88201F9BB54BE34B54BF280BD39D0607229D05100DD2CFF33B97683897B258435A":
    case "_encstr_887B0891B2CCD59BB293":
    case "_encstr_86350B2290E7F9A3C8A97A753E":
      return 0;
  }

  return 1;
}

setup_bot_sd() {
  level.bots_disable_team_switching = 1;
  level.initial_pickup_wait_time = 3000;
  damage_multiplier();
  _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_setup_objective_bottargets();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  level.bot_sd_override_zone_targets = [];
  level.bot_sd_override_zone_targets["_encstr_8E8405EA382B2A"] = [];
  level.bot_sd_override_zone_targets["_encstr_9A8507BA4040188D08"] = [];
  level.bot_default_sd_role_behavior["_encstr_86350B2290E7F9A3C8A97A753E"] = ::atk_bomber_update;
  level.bot_default_sd_role_behavior["_encstr_AC6A1270DA82ABAA9F49964B4C77B309D24D739F"] = ::clear_target_zone_update;
  level.bot_default_sd_role_behavior["_encstr_853D1477C1580D826DE793FB83376B4530EE6E3D78D0"] = ::defend_planted_bomb_update;
  level.bot_default_sd_role_behavior["_encstr_887B0891B2CCD59BB293"] = ::bomb_defuser_update;
  level.bot_default_sd_role_behavior["_encstr_88201F9BB54BE34B54BF280BD39D0607229D05100DD2CFF33B97683897B258435A"] = ::investigate_someone_using_bomb_update;
  level.bot_default_sd_role_behavior["_encstr_937D0AC62CADC17D26DE5B13"] = ::camp_bomb_update;
  level.bot_default_sd_role_behavior["_encstr_8E460991ACCC59378C56C9"] = ::defender_update;
  level.bot_default_sd_role_behavior["_encstr_86E10C26B08DB5E68E0B4CC42B93"] = ::backstabber_update;
  level.bot_default_sd_role_behavior["_encstr_BA060E12A1F8EC72C9C7DFCFB9611A32"] = ::random_killer_update;
  var_0 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::debug_consoles(["_encstr_B20703DFCF", "_encstr_B40703E96D"]);

  if(var_0) {
    foreach(var_2 in level.objectives)
    var_2 thread _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::monitor_bombzone_control();

    thread bot_sd_ai_director_update();
    level.bot_gametype_precaching_done = 1;
  }
}

bot_sd_think() {
  self notify("_encstr_8B6E0D284024879F44F9808AFBFED7");
  self endon("_encstr_8B6E0D284024879F44F9808AFBFED7");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.has_started_thinking = undefined;

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);
  self botsetflag("_encstr_8D1813AECD95D7B731A9BE83C21D0DAF9B8EBC6395", 1);
  var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
  var_1 = 1;

  if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && level.sdbomb.carrier == self && isDefined(self.role) && self.role == "_encstr_86350B2290E7F9A3C8A97A753E")
    var_1 = 0;

  if(var_1) {
    self.role = undefined;

    if(isDefined(level.atk_bomber) && level.atk_bomber == self)
      level.atk_bomber = undefined;
  }

  self.suspend_sd_role = undefined;
  self.has_started_thinking = 0;
  self.atk_bomber_no_path_to_bomb_count = 0;
  self.scripted_path_style = undefined;
  self.defender_set_script_pathstyle = undefined;
  self.defuser_bad_path_counter = 0;

  if(!isDefined(level.initial_bomb_location) && !level.multibomb) {
    level.initial_bomb_location = level.sdbomb.curorigin;
    level.initial_bomb_location_nearest_node = getclosestnodeinsight(level.sdbomb.curorigin);
  }

  if(self.team == var_0 && !isDefined(level.can_pickup_bomb_time)) {
    var_2 = 0;

    if(!level.multibomb) {
      var_3 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::get_living_players_on_team(var_0);

      foreach(var_5 in var_3) {
        if(!isai(var_5))
          var_2 = 1;
      }
    }

    if(var_2) {
      var_7 = 6000;
      level.can_pickup_bomb_time = gettime() + var_7;
      badplace_cylinder("_encstr_999B050670F0FA", var_7 / 1000, level.sdbomb.curorigin, 75, 300, var_0);
    }
  }

  for(;;) {
    wait(randomintrange(1, 3) * 0.05);

    if(self.health <= 0) {
      continue;
    }
    self.has_started_thinking = 1;

    if(!isDefined(self.role))
      initialize_sd_role();

    if(isDefined(self.suspend_sd_role)) {
      continue;
    }
    if(self.team == var_0) {
      if(!level.multibomb && isDefined(level.can_pickup_bomb_time) && gettime() < level.can_pickup_bomb_time && !isDefined(level.sdbomb.carrier)) {
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbomb.curorigin)) {
          var_8 = getclosestnodeinsight(level.sdbomb.curorigin);

          if(isDefined(var_8)) {
            var_9["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"] = var_8;
            scripts\mp\bots\bots_strategy::bot_protect_point(level.sdbomb.curorigin, 900, var_9);
          } else
            level.can_pickup_bomb_time = gettime();
        }
      } else
        self[[level.bot_default_sd_role_behavior[self.role]]]();

      continue;
    }

    if(level.bombplanted) {
      if(isDefined(level.sdbombmodel) && distancesquared(self.origin, level.sdbombmodel.origin) > squared(level.protect_radius * 2)) {
        if(!isDefined(self.defender_set_script_pathstyle)) {
          self.defender_set_script_pathstyle = 1;
          self botsetpathingstyle("_encstr_84DB09430E5B9A0B6D2001");
        }
      } else if(isDefined(self.defender_set_script_pathstyle) && !isDefined(self.scripted_path_style)) {
        self.defender_set_script_pathstyle = undefined;
        self botsetpathingstyle(undefined);
      }
    }

    if(level.bombplanted && isDefined(level.sdbombmodel) && isDefined(level.bomb_defuser) && self.role != "_encstr_887B0891B2CCD59BB293") {
      if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbombmodel.origin)) {
        self botclearscriptgoal();
        scripts\mp\bots\bots_strategy::bot_protect_point(level.sdbombmodel.origin, level.protect_radius);
      }

      continue;
    }

    self[[level.bot_default_sd_role_behavior[self.role]]]();
  }
}

create_player_rig_laser_panel(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 1);
  self botsetstance("_encstr_A5AD069B231F0BAF");
  wait(var_0);
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
  self botsetstance("_encstr_8BBA05185F8B99");
}

atk_bomber_update() {
  self endon("_encstr_854209CE6B1871631838EA");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && isalive(level.sdbomb.carrier) && level.sdbomb.carrier != self)
    wait 0.7;

  if(!self.isbombcarrier && !level.multibomb) {
    if(level.bombplanted) {
      level.atk_bomber = undefined;
      scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
      bot_set_role("_encstr_853D1477C1580D826DE793FB83376B4530EE6E3D78D0");
      return;
    }

    if(isDefined(level.sdbomb)) {
      if(!isDefined(self.last_bomb_location))
        self.last_bomb_location = level.sdbomb.curorigin;

      if(distancesquared(self.last_bomb_location, level.sdbomb.curorigin) > 4) {
        self botclearscriptgoal();
        self.last_bomb_location = level.sdbomb.curorigin;
      }
    }

    if(self.atk_bomber_no_path_to_bomb_count >= 2) {
      var_1 = getnodesinradiussorted(level.sdbomb.curorigin, 512, 0);
      var_2 = undefined;

      foreach(var_4 in var_1) {
        if(!var_4 nodeisdisconnected()) {
          var_2 = var_4;
          break;
        }
      }

      if(isDefined(var_2)) {
        self botsetscriptgoal(var_2.origin, 20, "_encstr_99CC09DA9020C4ECD149AD");
        scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier))
          level.sdbomb scripts\mp\gameobjects::setpickedup(self);
      } else {}

      return;
    }

    if(!self bothasscriptgoal()) {
      var_6 = 15;
      var_7 = 32;
      var_8 = scripts\mp\bots\bots_util::bot_queued_process("_encstr_B8D91C321703FF17891F78A2525B18637DC74BF027E6D2C1F94B8FC170A3", scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, var_6 + var_7, self);

      if(isDefined(var_8)) {
        var_9 = self botsetscriptgoal(level.sdbomb.curorigin, 0, "_encstr_99CC09DA9020C4ECD149AD");

        if(var_9) {
          childthread bomber_monitor_no_path();
          return;
        }
      } else {
        var_1 = getnodesinradiussorted(level.sdbomb.curorigin, 512, 0);

        if(var_1.size > 0) {
          self botsetscriptgoal(var_1[0].origin, 0, "_encstr_99CC09DA9020C4ECD149AD");
          scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
        }

        if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier)) {
          var_8 = scripts\mp\bots\bots_util::bot_queued_process("_encstr_B8D91C321703FF17891F78A2525B18637DC74BF027E6D2C1F94B8FC170A3", scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, var_6 + var_7, self);

          if(!isDefined(var_8))
            level.sdbomb scripts\mp\gameobjects::setpickedup(self);
        }
      }
    }
  } else {
    if(isDefined(self.dont_plant_until_time) && gettime() < self.dont_plant_until_time) {
      return;
    }
    if(!isDefined(level.bomb_zone_assaulting))
      level.bomb_zone_assaulting = scripts\engine\utility::random(level.objectives);

    var_10 = level.bomb_zone_assaulting;
    self.bombzonegoal = var_10;

    if(!isDefined(level.initial_bomb_pickup_time) || gettime() - level.initial_bomb_pickup_time < level.initial_pickup_wait_time) {
      level.initial_bomb_pickup_time = gettime() + level.initial_pickup_wait_time;
      thread create_player_rig_laser_panel(level.initial_pickup_wait_time / 1000);
      wait(level.initial_pickup_wait_time / 1000);
    }

    self botclearscriptgoal();

    if(level.attack_behavior == "_encstr_A61F054B28EBE0") {
      self botsetpathingstyle("_encstr_84DB09430E5B9A0B6D2001");
      var_11 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::process_should_do_pain(var_10, 1);
      self botsetscriptgoal(var_11.origin, 0, "_encstr_99CC09DA9020C4ECD149AD");
    }

    var_12 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

    if(var_12 == "_encstr_8B7205D9ED5958") {
      var_13 = get_round_end_time() - gettime();
      var_14 = var_13 - level.planttime * 2 * 1000;
      var_15 = gettime() + var_14;

      if(var_14 > 0)
        scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var_14);

      var_16 = gettime() >= var_15;
      var_17 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::current_respawn_point_override(level.planttime + 2, "_encstr_AB3D0DE25FE81EF7B7188A42230553", var_16);
      self botclearscriptgoal();

      if(var_17) {
        scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
        bot_set_role("_encstr_853D1477C1580D826DE793FB83376B4530EE6E3D78D0");
      } else if(var_14 > 5000)
        self.dont_plant_until_time = gettime() + 5000;
    }
  }
}

get_round_end_time() {
  if(level.bombplanted)
    return level.defuseendtime;
  else
    return gettime() + scripts\mp\gamelogic::gettimeremaining();
}

bomber_monitor_no_path() {
  self notify("_encstr_8B601789F6B613CAE4D7B5B7E6D2D1B727EB9BBDF50E58D10D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8B7205D9ED5958");
  self endon("_encstr_8B601789F6B613CAE4D7B5B7E6D2D1B727EB9BBDF50E58D10D");
  level.sdbomb endon("_encstr_AD740E37543ADFAB708788F84BBDA129");

  for(;;) {
    self waittill("_encstr_866D08B0C561870B03FB");
    self.atk_bomber_no_path_to_bomb_count++;
  }
}

clear_target_zone_update() {
  self endon("_encstr_854209CE6B1871631838EA");

  if(isDefined(level.atk_bomber)) {
    if(level.attack_behavior == "_encstr_A61F054B28EBE0") {
      if(!isDefined(self.set_initial_rush_goal)) {
        if(!level.multibomb) {
          var_0["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"] = level.initial_bomb_location_nearest_node;
          scripts\mp\bots\bots_strategy::bot_protect_point(level.initial_bomb_location, 900, var_0);
          wait(randomfloatrange(0.0, 4.0));
          scripts\mp\bots\bots_strategy::bot_defend_stop();
        }

        self.set_initial_rush_goal = 1;
      }

      if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0)
        set_force_sprint();

      if(isai(level.atk_bomber) && isDefined(level.atk_bomber.bombzonegoal))
        var_1 = level.atk_bomber.bombzonegoal;
      else if(isDefined(level.bomb_zone_assaulting))
        var_1 = level.bomb_zone_assaulting;
      else
        var_1 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::find_closest_bombzone_to_player(level.atk_bomber);

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(var_1.curorigin)) {
        var_0["_encstr_A3350E30CAC5DF89D71141D0FC373063"] = 2;
        var_0["_encstr_82E20ED21780D944E75EF94F139CE05B"] = 4;
        var_0["_encstr_8D9715A8C35F281DB93F3107FF7268CA83581FF20F8F41"] = scripts\engine\utility::random(var_1.bottargets);
        scripts\mp\bots\bots_strategy::bot_protect_point(var_1.curorigin, level.protect_radius, var_0);
      }
    }
  }
}

defend_planted_bomb_update() {
  self endon("_encstr_854209CE6B1871631838EA");

  if(level.bombplanted && isDefined(level.sdbombmodel)) {
    if(level.attack_behavior == "_encstr_A61F054B28EBE0")
      disable_force_sprint();

    if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbombmodel.origin)) {
      var_0["_encstr_91F90CB98DBD93B2F533B10BEC9B"] = "_encstr_AC5616B32065A5C39959113FE783FF6CE1E13AAA98319F7B";
      scripts\mp\bots\bots_strategy::bot_protect_point(level.sdbombmodel.origin, level.protect_radius, var_0);
    }
  }
}

bomb_defuser_update() {
  self endon("_encstr_854209CE6B1871631838EA");

  if(level.bombdefused || !isDefined(level.sdbombmodel)) {
    return;
  }
  var_0 = find_ticking_bomb();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, var_0.bottargets);
  var_2 = (level.sdbombmodel.origin[0], level.sdbombmodel.origin[1], var_1[0].origin[2]);

  if(self.defuser_bad_path_counter <= 1)
    var_3 = cautious_approach_till_close(var_2, undefined);
  else {
    self botclearscriptgoal();
    var_3 = self botsetscriptgoal(var_2, 20, "_encstr_99CC09DA9020C4ECD149AD");
  }

  if(!var_3) {
    return;
  }
  var_4 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_4 == "_encstr_86E5092BA829F7AB738DA4") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      for(;;) {
        var_5 = getnodesinradiussorted(var_2, 50, 0);
        var_6 = self.defuser_bad_path_counter - 4;

        if(var_5.size <= var_6) {
          var_7 = botgetclosestnavigablepoint(var_2, 50, self);

          if(isDefined(var_7))
            self botsetscriptgoal(var_7, 20, "_encstr_99CC09DA9020C4ECD149AD");
          else
            break;
        } else
          self botsetscriptgoal(var_5[var_6].origin, 20, "_encstr_99CC09DA9020C4ECD149AD");

        var_4 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(var_4 == "_encstr_86E5092BA829F7AB738DA4") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(var_4 == "_encstr_8B7205D9ED5958") {
    var_8 = get_round_end_time() - gettime();
    var_9 = var_8 - level.defusetime * 2 * 1000;
    var_10 = gettime() + var_9;

    if(var_9 > 0)
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var_9);

    var_11 = gettime() >= var_10;
    var_12 = level.sdbombmodel.origin[2] - self.origin[2];
    var_13 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::current_respawn_point_override(level.defusetime + 2, "_encstr_ACA10DAE80E31A1FC960CB8FF8C11C", var_11, var_12 > 40);

    if(!var_13 && self.defuser_bad_path_counter >= 4)
      self.defuser_bad_path_counter++;

    self botclearscriptgoal();
    scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
  }
}

investigate_someone_using_bomb_update() {
  self endon("_encstr_854209CE6B1871631838EA");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  var_0 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::find_closest_bombzone_to_player(self);
  self botsetscriptgoalnode(scripts\engine\utility::random(var_0.bottargets), "_encstr_99CC09DA9020C4ECD149AD");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_1 == "_encstr_8B7205D9ED5958") {
    wait 2;
    bot_set_role(self.prev_role);
  }
}

camp_bomb_update() {
  self endon("_encstr_854209CE6B1871631838EA");

  if(isDefined(level.sdbomb.carrier)) {
    if(self.prev_role == "_encstr_8E460991ACCC59378C56C9")
      self.defend_zone = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::find_closest_bombzone_to_player(self);

    bot_set_role(self.prev_role);
  } else if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbomb.curorigin)) {
    var_0["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"] = level.sdbomb.nearest_node_for_camping;
    scripts\mp\bots\bots_strategy::bot_protect_point(level.sdbomb.curorigin, level.protect_radius, var_0);
  }
}

defender_update() {
  self endon("_encstr_854209CE6B1871631838EA");

  if(!scripts\mp\bots\bots_util::bot_is_defending_point(self.defend_zone.curorigin)) {
    var_0["_encstr_91F90CB98DBD93B2F533B10BEC9B"] = "_encstr_850A0BF7D10EA25388CE05CD63";
    var_0["_encstr_8D9715A8C35F281DB93F3107FF7268CA83581FF20F8F41"] = scripts\engine\utility::random(self.defend_zone.bottargets);
    scripts\mp\bots\bots_strategy::bot_protect_point(self.defend_zone.curorigin, level.protect_radius, var_0);
  }
}

backstabber_update() {
  self endon("_encstr_854209CE6B1871631838EA");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  if(!isDefined(self.backstabber_stage))
    self.backstabber_stage = "_encstr_ACAE13A61795DFC845B1E347489D2C982AAFE0751B";

  if(self.backstabber_stage == "_encstr_ACAE13A61795DFC845B1E347489D2C982AAFE0751B") {
    var_0 = level.objectives["_encstr_B20703DFCF"].curorigin;
    var_1 = level.objectives["_encstr_B40703E96D"].curorigin;
    var_2 = ((var_0[0] + var_1[0]) * 0.5, (var_0[1] + var_1[1]) * 0.5, (var_0[2] + var_1[2]) * 0.5);
    var_3 = getnodesinradiussorted(var_2, 512, 0);

    if(var_3.size == 0) {
      bot_set_role("_encstr_BA060E12A1F8EC72C9C7DFCFB9611A32");
      return;
    }

    var_4 = undefined;
    var_5 = int(var_3.size * (var_3.size + 1) * 0.5);
    var_6 = randomint(var_5);

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      var_8 = var_3.size - var_7;

      if(var_6 < var_8) {
        var_4 = var_3[var_7];
        break;
      }

      var_6 = var_6 - var_8;
    }

    self botsetpathingstyle("_encstr_84DB09430E5B9A0B6D2001");
    var_9 = self botsetscriptgoalnode(var_4, "_encstr_AF2206AF7DE90BA7");

    if(var_9) {
      var_10 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var_10 == "_encstr_8B7205D9ED5958") {
        wait(randomfloatrange(1.0, 4.0));
        self.backstabber_stage = "_encstr_B27616C278454FD53161FBE7D16185EBE20B513B639F17E0";
      }
    }
  }

  if(self.backstabber_stage == "_encstr_B27616C278454FD53161FBE7D16185EBE20B513B639F17E0") {
    var_11 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39");
    var_12 = scripts\engine\utility::random(var_11);
    self botsetpathingstyle("_encstr_84DB09430E5B9A0B6D2001");
    var_9 = self botsetscriptgoal(var_12.origin, 250, "_encstr_AF2206AF7DE90BA7");

    if(var_9) {
      var_10 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var_10 == "_encstr_8B7205D9ED5958")
        self.backstabber_stage = "_encstr_9B47137EF1E257BEEFE10DAF59F558C51A7827E6F1";
    }
  }

  if(self.backstabber_stage == "_encstr_9B47137EF1E257BEEFE10DAF59F558C51A7827E6F1") {
    if(!isDefined(self.current_respawn_point))
      self.current_respawn_point = scripts\engine\utility::random(level.objectives);

    self botsetpathingstyle(undefined);
    var_9 = self botsetscriptgoal(scripts\engine\utility::random(self.current_respawn_point.bottargets).origin, 160, "_encstr_9A2B0A12F03587575B7BBEA5");

    if(var_9) {
      var_10 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var_10 == "_encstr_8B7205D9ED5958") {
        self botclearscriptgoal();
        self.backstabber_stage = "_encstr_B27616C278454FD53161FBE7D16185EBE20B513B639F17E0";

        foreach(var_14 in level.objectives) {
          if(var_14 != self.current_respawn_point) {
            self.current_respawn_point = var_14;
            break;
          }
        }
      }
    }
  }
}

random_killer_update() {
  self endon("_encstr_854209CE6B1871631838EA");

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  self[[self.personality_update_function]]();
}

set_force_sprint() {
  if(!isDefined(self.always_sprint)) {
    self botsetflag("_encstr_A61A0D20256398C157E3632EF4B38B", 1);
    self.always_sprint = 1;
  }
}

disable_force_sprint() {
  if(isDefined(self.always_sprint)) {
    self botsetflag("_encstr_A61A0D20256398C157E3632EF4B38B", 0);
    self.always_sprint = undefined;
  }
}

set_scripted_pathing_style() {
  if(!isDefined(self.scripted_path_style)) {
    self botsetpathingstyle("_encstr_84DB09430E5B9A0B6D2001");
    self.scripted_path_style = 1;
  }
}

cautious_approach_till_close(var_0, var_1) {
  var_2 = level.capture_radius;
  var_3["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = var_1;
  scripts\mp\bots\bots_strategy::bot_capture_point(var_0, var_2, var_3);
  wait 0.05;

  while(distancesquared(self.origin, var_0) > var_2 * var_2 && scripts\mp\bots\bots_util::bot_is_defending()) {
    if(get_round_end_time() - gettime() < 20000) {
      set_scripted_pathing_style();
      set_force_sprint();
      break;
    }

    wait 0.05;
  }

  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  return self botsetscriptgoal(var_0, 20, "_encstr_99CC09DA9020C4ECD149AD");
}

notify_enemy_team_bomb_used(var_0) {
  var_1 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::prematchinitx1blueprintloadouts(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.role))
      var_3 bot_set_role("_encstr_88201F9BB54BE34B54BF280BD39D0607229D05100DD2CFF33B97683897B258435A");
  }
}

should_start_cautious_approach_sd(var_0) {
  var_1 = 2000;
  var_2 = var_1 * var_1;

  if(var_0) {
    if(get_round_end_time() - gettime() < 15000)
      return 0;

    var_3 = 0;
    var_4 = scripts\engine\utility::get_enemy_team(self.team);

    foreach(var_6 in level.players) {
      if(!isDefined(var_6.team)) {
        continue;
      }
      if(isalive(var_6) && var_6.team == var_4)
        var_3 = 1;
    }

    return var_3;
  } else
    return distancesquared(self.origin, self.bot_defending_center) <= var_2 && self botpursuingscriptgoal();
}

get_players_defending_zone(var_0) {
  var_1 = [];
  var_2 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::get_living_players_on_team(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

  foreach(var_4 in var_2) {
    if(isai(var_4) && isDefined(var_4.role) && var_4.role == "_encstr_8E460991ACCC59378C56C9") {
      if(isDefined(var_4.defend_zone) && var_4.defend_zone == var_0)
        var_1 = scripts\engine\utility::array_add(var_1, var_4);

      continue;
    }

    if(distancesquared(var_4.origin, var_0.curorigin) < level.protect_radius * level.protect_radius)
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

find_ticking_bomb() {
  if(isDefined(level.tickingobject)) {
    foreach(var_1 in level.objectives) {
      if(distancesquared(level.tickingobject.origin, var_1.curorigin) < 90000)
        return var_1;
    }
  }

  return undefined;
}

get_specific_zone(var_0) {
  var_0 = "_encstr_BA4C02DF" + tolower(var_0);
  return level.objectives[var_0];
}

bomber_wait_for_death() {
  self endon("_encstr_84421BE7D3F23F88750FF669775130FCA9E3A75313590ED89A623881DA");
  self endon("_encstr_854209CE6B1871631838EA");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level.atk_bomber = undefined;
  level.last_atk_bomber_death_time = gettime();

  if(isDefined(self))
    self.role = undefined;

  var_0 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::get_living_players_on_team(game["_encstr_991C0AB9ED5B57161FE89B83"], 1);
  force_all_players_to_role(var_0, undefined);
}

bomber_wait_for_bomb_reset() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_84421BE7D3F23F88750FF669775130FCA9E3A75313590ED89A623881DA");
  level.sdbomb endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  level.sdbomb waittill("_encstr_88F20627959BCAE8");

  if(scripts\mp\utility\entity::isaiteamparticipant(self))
    self botclearscriptgoal();

  bot_set_role("_encstr_86350B2290E7F9A3C8A97A753E");
}

set_new_bomber() {
  level.atk_bomber = self;
  bot_set_role("_encstr_86350B2290E7F9A3C8A97A753E");
  thread bomber_wait_for_death();

  if(!level.multibomb)
    thread bomber_wait_for_bomb_reset();

  if(isai(self)) {
    scripts\mp\bots\bots_strategy::bot_disable_tactical_goals();

    if(level.attack_behavior == "_encstr_A61F054B28EBE0" && self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0)
      set_force_sprint();
  }
}

initialize_sd_role() {
  if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    if(level.bombplanted)
      bot_set_role("_encstr_853D1477C1580D826DE793FB83376B4530EE6E3D78D0");
    else if(!isDefined(level.atk_bomber))
      set_new_bomber();
    else if(level.attack_behavior == "_encstr_A61F054B28EBE0")
      bot_set_role("_encstr_AC6A1270DA82ABAA9F49964B4C77B309D24D739F");
  } else {
    var_0 = get_players_by_role("_encstr_86E10C26B08DB5E68E0B4CC42B93");
    var_1 = get_players_by_role("_encstr_8E460991ACCC59378C56C9");
    var_2 = level.bot_personality_type[self.personality];
    var_3 = self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592");

    if(var_2 == "_encstr_930B07BB1B6B3854FF") {
      if(!isDefined(self.role) && level.allow_backstabbers && var_3 > 0) {
        if(var_0.size == 0)
          bot_set_role("_encstr_86E10C26B08DB5E68E0B4CC42B93");
        else {
          var_4 = 1;

          foreach(var_6 in var_0) {
            var_7 = level.bot_personality_type[var_6.personality];

            if(var_7 == "_encstr_930B07BB1B6B3854FF") {
              var_4 = 0;
              break;
            }
          }

          if(var_4) {
            bot_set_role("_encstr_86E10C26B08DB5E68E0B4CC42B93");
            var_0[0] bot_set_role(undefined);
          }
        }
      }

      if(!isDefined(self.role)) {
        if(var_1.size < 4)
          bot_set_role("_encstr_8E460991ACCC59378C56C9");
      }

      if(!isDefined(self.role)) {
        var_9 = randomint(4);

        if(var_9 == 3 && level.allow_random_killers && var_3 > 0)
          bot_set_role("_encstr_BA060E12A1F8EC72C9C7DFCFB9611A32");
        else if(var_9 == 2 && level.allow_backstabbers && var_3 > 0)
          bot_set_role("_encstr_86E10C26B08DB5E68E0B4CC42B93");
        else
          bot_set_role("_encstr_8E460991ACCC59378C56C9");
      }
    } else if(var_2 == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
      if(!isDefined(self.role)) {
        if(var_1.size < 4)
          bot_set_role("_encstr_8E460991ACCC59378C56C9");
        else {
          foreach(var_11 in var_1) {
            var_12 = level.bot_personality_type[var_11.personality];

            if(var_12 == "_encstr_930B07BB1B6B3854FF") {
              bot_set_role("_encstr_8E460991ACCC59378C56C9");
              var_11 bot_set_role(undefined);
              break;
            }
          }
        }
      }

      if(!isDefined(self.role) && level.allow_backstabbers && var_3 > 0) {
        if(var_0.size == 0)
          bot_set_role("_encstr_86E10C26B08DB5E68E0B4CC42B93");
      }

      if(!isDefined(self.role))
        bot_set_role("_encstr_8E460991ACCC59378C56C9");
    }

    if(self.role == "_encstr_8E460991ACCC59378C56C9") {
      var_14 = level.objectives;

      if(has_override_zone_targets(self.team))
        var_14 = get_override_zone_targets(self.team);

      if(var_14.size == 1)
        self.defend_zone = var_14["_encstr_B20703DFCF"];
      else {
        var_15 = get_players_defending_zone(var_14["_encstr_B20703DFCF"]);
        var_16 = get_players_defending_zone(var_14["_encstr_B40703E96D"]);

        if(var_15.size < var_16.size)
          self.defend_zone = var_14["_encstr_B20703DFCF"];
        else if(var_16.size < var_15.size)
          self.defend_zone = var_14["_encstr_B40703E96D"];
        else
          self.defend_zone = scripts\engine\utility::random(var_14);
      }
    }
  }
}

bot_set_role(var_0) {
  if(isai(self)) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
    self botsetpathingstyle(undefined);
  }

  self.prev_role = self.role;
  self.role = var_0;
  self notify("_encstr_854209CE6B1871631838EA");
}

bot_set_role_delayed(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_854209CE6B1871631838EA");
  wait(var_1);
  bot_set_role(var_0);
}

force_all_players_to_role(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isDefined(var_2)) {
      var_4 thread bot_set_role_delayed(var_1, randomfloatrange(0.0, var_2));
      continue;
    }

    var_4 thread bot_set_role(var_1);
  }
}

get_override_zone_targets(var_0) {
  return level.bot_sd_override_zone_targets[var_0];
}

has_override_zone_targets(var_0) {
  var_1 = get_override_zone_targets(var_0);
  return var_1.size > 0;
}

get_players_by_role(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(isalive(var_3) && scripts\mp\utility\entity::isteamparticipant(var_3) && isDefined(var_3.role) && var_3.role == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

bot_sd_ai_director_update() {
  level notify("_encstr_A7791AAAF061514FF1D81101F0D9EFA2FB3853F2605F937B293F0C05");
  level endon("_encstr_A7791AAAF061514FF1D81101F0D9EFA2FB3853F2605F937B293F0C05");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.allow_backstabbers = randomint(3) <= 1;
  level.allow_random_killers = randomint(3) <= 1;
  level.attack_behavior = "_encstr_A61F054B28EBE0";
  level.protect_radius = 725;
  level.capture_radius = 140;

  for(;;) {
    if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && !isai(level.sdbomb.carrier))
      level.bomb_zone_assaulting = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::find_closest_bombzone_to_player(level.sdbomb.carrier);

    var_0 = 0;

    if(!level.bombplanted) {
      var_1 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::get_living_players_on_team(game["_encstr_991C0AB9ED5B57161FE89B83"]);

      foreach(var_3 in var_1) {
        if(var_3.isbombcarrier) {
          level.can_pickup_bomb_time = gettime();

          if(!isDefined(level.atk_bomber) || var_3 != level.atk_bomber) {
            if(isDefined(level.atk_bomber) && isalive(level.atk_bomber)) {
              level.atk_bomber bot_set_role(undefined);
              level.atk_bomber notify("_encstr_84421BE7D3F23F88750FF669775130FCA9E3A75313590ED89A623881DA");
            }

            var_0 = 1;
            var_3 set_new_bomber();
          }
        }
      }

      if(!level.multibomb && !isDefined(level.sdbomb.carrier)) {
        var_5 = getclosestnodeinsight(level.sdbomb.curorigin);

        if(isDefined(var_5)) {
          level.sdbomb.nearest_node_for_camping = var_5;
          var_6 = 0;
          var_7 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::get_living_players_on_team(game["_encstr_B6A70A23CA6659DC91CAE4DC"], 1);

          foreach(var_9 in var_7) {
            var_10 = var_9 getnearestnode();
            var_11 = var_9 botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592");

            if(var_11 > 0 && var_9.role != "_encstr_937D0AC62CADC17D26DE5B13" && isDefined(var_10) && nodesvisible(var_5, var_10, 1)) {
              var_12 = var_9 botgetfovdot();

              if(scripts\engine\utility::within_fov(var_9.origin, var_9 getplayerangles(), level.sdbomb.curorigin, var_12)) {
                if(var_11 >= 2 || distancesquared(var_9.origin, level.sdbomb.curorigin) < squared(700)) {
                  var_6 = 1;
                  break;
                }
              }
            }
          }

          if(var_6) {
            foreach(var_9 in var_7) {
              if(var_9.role != "_encstr_937D0AC62CADC17D26DE5B13" && var_9 botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0)
                var_9 bot_set_role("_encstr_937D0AC62CADC17D26DE5B13");
            }
          }
        }
      }

      var_16 = level.objectives;

      if(has_override_zone_targets(game["_encstr_B6A70A23CA6659DC91CAE4DC"]))
        var_16 = get_override_zone_targets(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

      foreach(var_18 in var_16) {
        foreach(var_20 in var_16) {
          var_21 = get_players_defending_zone(var_18);
          var_22 = get_players_defending_zone(var_20);

          if(var_21.size > var_22.size + 1) {
            var_23 = [];

            foreach(var_3 in var_21) {
              if(isai(var_3))
                var_23 = scripts\engine\utility::array_add(var_23, var_3);
            }

            if(var_23.size > 0) {
              var_26 = scripts\engine\utility::random(var_23);
              var_26 scripts\mp\bots\bots_strategy::bot_defend_stop();
              var_26.defend_zone = var_20;
            }
          }
        }
      }
    } else {
      if(isDefined(level.atk_bomber))
        level.atk_bomber = undefined;

      if(!isDefined(level.bomb_defuser) || !isalive(level.bomb_defuser)) {
        var_29 = [];
        var_30 = get_players_by_role("_encstr_8E460991ACCC59378C56C9");
        var_31 = get_players_by_role("_encstr_86E10C26B08DB5E68E0B4CC42B93");
        var_32 = get_players_by_role("_encstr_BA060E12A1F8EC72C9C7DFCFB9611A32");

        if(var_30.size > 0)
          var_29 = var_30;
        else if(var_31.size > 0)
          var_29 = var_31;
        else if(var_32.size > 0)
          var_29 = var_32;

        if(var_29.size > 0 && isDefined(level.sdbombmodel)) {
          var_33 = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, var_29);
          level.bomb_defuser = var_33[0];
          level.bomb_defuser bot_set_role("_encstr_887B0891B2CCD59BB293");
          level.bomb_defuser scripts\mp\bots\bots_strategy::bot_disable_tactical_goals();
          level.bomb_defuser thread defuser_wait_for_death();
        }
      }

      if(!isDefined(level.sd_bomb_just_planted)) {
        level.sd_bomb_just_planted = 1;
        var_34 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::get_living_players_on_team(game["_encstr_991C0AB9ED5B57161FE89B83"]);

        foreach(var_3 in var_34) {
          if(isDefined(var_3.role)) {
            if(var_3.role == "_encstr_86350B2290E7F9A3C8A97A753E") {
              var_3 thread bot_set_role(undefined);
              continue;
            }

            if(var_3.role != "_encstr_853D1477C1580D826DE793FB83376B4530EE6E3D78D0")
              var_3 thread bot_set_role_delayed("_encstr_853D1477C1580D826DE793FB83376B4530EE6E3D78D0", randomfloatrange(0.0, 3.0));
          }
        }
      }
    }

    wait 0.5;
  }
}

defuser_wait_for_death() {
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level.bomb_defuser = undefined;
}

vehicle_compass_br_shouldbevisibletoplayer(var_0) {
  var_1 = spawncovernode(var_0, (0, randomint(360), 0), "_encstr_AFFF0C6E8FE899DDE6174B068510");
}

damage_multiplier() {
  if(level.mapname == "_encstr_82740C4F78166D12D1B3CA0495DD") {
    var_0 = (360, 2676, 16);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (319, 2772, 16);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-1499, 3395, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-1543, 3344, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-1456, 3343, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-1498, 3294, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  }
}