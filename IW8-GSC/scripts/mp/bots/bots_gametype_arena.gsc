/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_arena.gsc
***************************************************/

function main() {
  level.bot_ignore_precalc_paths = 0;
  setup_callbacks();
  ref_131dc();
}

function setup_callbacks() {
  if(scripts\mp\gametypes\arena::ispickuploadouts()) {
    level.bot_funcs["dropped_weapon_think"] = &calloutmarkerping_playteamsoundfx;
    level.bot_funcs["dropped_weapon_cancel"] = &calloutmarkerping_removevehiclecalloutonspecialconditions;
  }

  level.bot_funcs["gametype_think"] = &currentsolsign;
}

function ref_131dc() {
  if(!scripts\mp\gametypes\arena::isnormalloadouts()) {
    level.bots_gametype_handles_class_choice = 1;
  }

  while(!isDefined(level.arenaflag)) {
    waitframe();
  }

  damage_multiplier();

  if(istrue(game["isLaunchChunk"])) {
    if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
      return;
    }
  }

  var_0 = scripts\engine\utility::ter_op(level.objmodifier == 1, 3, 1);
  scripts\mp\bots\bots_gametype_dom::setup_bot_dom(var_0, 3);
}

function currentsolsign() {
  self notify("bot_arena_think");
  self endon("bot_arena_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self.pers["bot_original_personality"])) {
    self.pers["bot_original_personality"] = self.personality;
  }

  wait 0.1;

  if(!scripts\mp\gametypes\arena::isnormalloadouts()) {
    if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0) {
      scripts\mp\bots\bots_gametype_gun::data_pickup_logic(self getcurrentweapon().basename, self.pers["bot_original_personality"]);
    }
  }

  self.select_woods_one_spawners = 0;

  for(;;) {
    if(isDefined(level.arenaflag) && level.arenaflag.visibleteam == "any") {
      self notify("bot_dom_think");

      if(!scripts\mp\bots\bots_util::bot_is_capturing() || !self.select_woods_one_spawners) {
        scripts\mp\bots\bots_strategy::bot_capture_zone(level.arenaflag.trigger.origin, level.arenaflag.nodes, level.arenaflag.trigger);
      }

      self.select_woods_one_spawners = 1;
    } else {
      self[[self.personality_update_function]]();
      thread bot_dom_think();
    }

    wait 0.05;
  }
}

function calloutmarkerping_playteamsoundfx() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = "throwingknife_mp";

  for(;;) {
    var_1 = 0;

    if(calloutmarkerping_islootquesttablet() || scripts\mp\bots\bots_util::damagestatedata(0.33)) {
      if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        var_2 = getEntArray("dropped_weapon", "targetname");
        var_3 = scripts\engine\utility::get_array_of_closest(self.origin, var_2);

        if(var_3.size > 0) {
          var_4 = var_3[0];
          level.moderestrictsarenakillstreaks = var_4;
          calloutmarkerping_navigationcancelproximity(var_4);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::bot_in_combat() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("strategyLevel") > 0) {
      var_5 = self hasweapon(var_0);
      var_6 = var_5 && self getammocount(var_0) == 0;

      if(var_6) {
        if(isDefined(self.going_for_knife)) {
          wait 5;
          continue;
        }

        var_7 = getEntArray("dropped_knife", "targetname");
        var_8 = scripts\engine\utility::get_array_of_closest(self.origin, var_7);

        foreach(var_10 in var_8) {
          if(!isDefined(var_10)) {
            continue;
          }

          if(!isDefined(var_10.calculated_closest_point)) {
            var_11 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", &scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, var_10.origin, 32, self);

            if(isDefined(var_10)) {
              var_10.closest_point_on_grid = var_11;
              var_10.calculated_closest_point = 1;
            } else {
              continue;
            }
          }

          if(isDefined(var_10.closest_point_on_grid)) {
            self.going_for_knife = 1;
            calloutmarkerping_navigationcancelproximity(var_10);
          }
        }
      } else if(var_5) {
        self.going_for_knife = undefined;
      }
    }

    wait randomfloatrange(0.25, 0.75);
  }
}

function calloutmarkerping_navigationcancelproximity(var_0) {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_dropped_weapon", var_0) == 0) {
    if(istrue(level.ref_1343f)) {
      var_1 = self botfirstavailablegrenade("lethal");
      var_2 = self botfirstavailablegrenade("tactical");

      if(isDefined(var_1) && var_1.basename == "snowball_mp") {
        var_3 = scripts\mp\equipment::getcurrentequipment("primary");
        var_4 = scripts\mp\equipment::getequipmentammo(var_3);

        if(var_1.basename == "snowball_mp" && var_4 > 3) {
          return;
        }
      }

      if(isDefined(var_2) && var_2.basename == "pball_mp") {
        var_3 = scripts\mp\equipment::getcurrentequipment("secondary");
        var_4 = scripts\mp\equipment::getequipmentammo(var_3);

        if(var_2.basename == "pball_mp") {
          return;
        }
      }
    }

    var_5 = undefined;

    if(var_0.targetname == "dropped_weapon") {
      var_6 = 1;
      var_7 = self getweaponslistprimaries();

      foreach(var_9 in var_7) {
        if(var_0.model == getweaponmodel(var_9)) {
          var_6 = 0;
        }
      }

      if(var_6) {
        var_5 = &calloutmarkerping_ismunitionsbox;
      }
    }

    var_11 = spawnStruct();
    var_11.object = var_0;
    var_11.script_goal_radius = 12;
    var_11.should_abort = level.bot_funcs["dropped_weapon_cancel"];
    var_11.action_thread = var_5;
    var_12 = undefined;
    var_13 = var_0.origin;

    if(isDefined(var_0.deafen_ai_near_pa_for_duration)) {
      var_13 = var_0.deafen_ai_near_pa_for_duration;
    }

    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_dropped_weapon", var_13, 100, var_11);
    return;
  }
}

function calloutmarkerping_ismunitionsbox(var_0) {
  self botpressbutton("use", 0.5);
  thread ref_13fc6();
}

function ref_13fc6() {
  self notify("updateBotWeaponBehavior");
  self endon("updateBotWeaponBehavior");
  wait 2;

  if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0) {
    scripts\mp\bots\bots_gametype_gun::data_pickup_logic(self getcurrentweapon().basename, self.pers["bot_original_personality"]);
    return;
  }
}

function calloutmarkerping_removevehiclecalloutonspecialconditions(var_0) {
  if(calloutmarkerping_islethalequipment() > 0) {
    var_1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(isDefined(var_0.object)) {
      var_2 = var_0.object.classname;

      if(scripts\engine\utility::string_starts_with(var_2, "weapon_")) {
        var_2 = getsubstr(var_2, 7);
      }

      var_3 = scripts\mp\utility\weapon::getweapongroup(var_2);

      if(!bot_weapon_is_better_class(var_1, var_3)) {
        return true;
      }
    }
  }

  if(!isDefined(var_0.object)) {
    return true;
  }

  if(var_0.object.targetname == "dropped_weapon") {
    foreach(var_5 in self.weaponlist) {
      if(var_5.basename == "iw8_fists_mp") {
        return false;
      }
    }

    if(calloutmarkerping_islethalequipment() > 0) {
      return true;
    }
  } else if(var_0.object.targetname == "dropped_knife") {
    if(scripts\mp\bots\bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return true;
    }
  }

  return false;
}

function calloutmarkerping_islethalequipment() {
  var_0 = 0;
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_1 = self.weaponlist;
  } else {
    var_1 = self getweaponslistprimaries();
  }

  foreach(var_3 in var_1) {
    var_0 += self getweaponammoclip(var_3);
    var_0 += self getweaponammostock(var_3);
  }

  if(var_1.size == 1 && var_1[0].basename == "iw8_fists_mp") {
    var_0 = 0;
  }

  return var_0;
}

function calloutmarkerping_islootquesttablet() {
  var_0 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_0 = self.weaponlist;
  } else {
    var_0 = self getweaponslistprimaries();
  }

  if(var_0.size == 1 && var_0[0].basename == "iw8_fists_mp") {
    return true;
  }

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2) > 0) {
      return false;
    }

    if(self getweaponammostock(var_2) > 0) {
      return false;
    }
  }

  return true;
}

function bot_rank_weapon_class(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "weapon_other":
    case "weapon_projectile":
    case "weapon_explosive":
    case "weapon_grenade":
      break;
    case "weapon_pistol":
      var_1 = 1;
      break;
    case "weapon_dmr":
    case "weapon_sniper":
      var_1 = 2;
      break;
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_assault":
    case "weapon_smg":
    case "weapon_tactical":
      var_1 = 3;
      break;
  }

  return var_1;
}

function bot_weapon_is_better_class(var_0, var_1) {
  var_2 = bot_rank_weapon_class(var_0);
  var_3 = bot_rank_weapon_class(var_1);
  return var_3 > var_2;
}

function vehicle_compass_br_shouldbevisibletoplayer(var_0) {
  var_1 = spawncovernode(var_0, (0, randomint(360), 0), "Cover Stand");

  if(!isDefined(level.arenaflag.nodes)) {
    level.arenaflag.nodes = [];
  }

  level.arenaflag.nodes[level.arenaflag.nodes.size] = var_1;

  if(!isDefined(level.objectives["_a"].bottargets)) {
    level.objectives["_a"].bottargets = [];
  }

  level.objectives["_a"].bottargets[level.objectives["_a"].bottargets.size] = var_1;
}

function damage_multiplier() {
  if(level.mapname == "mp_m_pine") {
    var_0 = (22, 12, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-4, 1, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (0, -33, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (35, -23, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    return;
  }
}

function bot_dom_think() {
  self notify("bot_dom_think");
  self endon("bot_dom_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self.force_new_goal = 0;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    scripts\mp\bots\bots_util::bot_update_camp_assassin();
    var_0 = gettime();

    if(var_0 > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("strategyLevel");
    }

    if(var_0 > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision()) {
        self.new_goal_time = var_0 + 5000;
      } else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = var_0 + randomintrange(30000, 45000);
      }
    }

    scripts\engine\utility::waittill_notify_or_timeout("needs_new_flag_goal", 1);
  }
}

function should_delay_flag_decision() {
  if(self.force_new_goal) {
    return false;
  }

  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return false;
  }

  if(self.current_flag scripts\mp\gametypes\dom::getflagteam() == self.team) {
    return false;
  }

  var_0 = get_flag_capture_radius();

  if(isDefined(self.current_flag.trigger) && distancesquared(self.origin, self.current_flag.trigger.origin) < var_0 * 2 * var_0 * 2) {
    var_1 = get_ally_flags(self.team);

    if(var_1.size == 2 && !scripts\engine\utility::array_contains(var_1, self.current_flag) && !bot_allowed_to_3_cap()) {
      return false;
    }

    return true;
  }

  return false;
}

function get_override_flag_targets() {
  return level.bot_dom_override_flag_targets[self.team];
}

function has_override_flag_targets() {
  var_0 = get_override_flag_targets();
  return var_0.size > 0;
}

function flag_has_been_captured_before(var_0) {
  return !flag_has_never_been_captured(var_0);
}

function flag_has_never_been_captured(var_0) {
  return var_0.firstcapture;
}

function bot_choose_flag() {
  var_0 = undefined;
  var_1 = [];
  var_2 = [];
  var_3 = get_override_flag_targets();

  if(var_3.size > 0) {
    var_4 = var_3;
  } else {
    var_4 = level.objectives;
  }

  foreach(var_1 in var_4) {
    if(var_1.objectivekey == "_a") {
      continue;
    }

    var_6 = var_1 scripts\mp\gametypes\dom::getflagteam();

    if(flag_has_been_captured_before(var_1)) {
      var_7 = 0;
    }

    if(var_6 != self.team) {
      var_2 = var_1;
      continue;
    }

    var_3 = var_1;
  }

  var_9 = undefined;

  if(var_3.size == 1) {
    if(!bot_should_defend_flag(var_3[0], 1)) {
      var_9 = 1;
    } else {
      var_9 = !bot_should_defend(0.34);
    }
  } else {
    return;
  }

  if(var_9) {
    var_10 = var_2;

    if(var_10.size == 1) {
      var_1 = var_10[0];
    }
  } else {
    var_11 = var_3;

    foreach(var_13 in var_11) {
      if(bot_should_defend_flag(var_13, var_3.size)) {
        var_1 = var_13;
        break;
      }
    }
  }

  if(var_9) {
    capture_flag(var_1);
    return;
  }

  defend_flag(var_1);
}

function bot_allowed_to_3_cap() {
  return true;
}

function bot_should_defend(var_0) {
  if(randomfloat(1) < var_0) {
    return 1;
  }

  var_1 = level.bot_personality_type[self.personality];

  if(var_1 == "stationary") {
    return 1;
  }

  if(var_1 == "active") {
    return 0;
  }
}

function capture_flag(var_0, var_1, var_2) {
  self.current_flag = var_0;

  if(isDefined(var_0.trigger)) {
    if(bot_dom_debug_should_protect_all()) {
      GscBinSkip1(0x45, "override_goal_type", var_1);
    }

    GscBinSkip1(0x45, "override_goal_type", var_1);
  }
}

function defend_flag(var_0) {
  self.current_flag = var_0;

  if(isDefined(var_0.trigger)) {
    if(bot_dom_debug_should_capture_all()) {
      GscBinSkip1(0x45, "entrance_points_index", get_flag_label(var_0));
    }

    GscBinSkip1(0x45, "entrance_points_index", get_flag_label(var_0));
  }
}

function get_flag_capture_radius() {
  if(!isDefined(level.capture_radius)) {
    level.capture_radius = 158;
  }

  return level.capture_radius;
}

function get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level.protect_radius = min(1000, var_1 / 3.5);
  }

  return level.protect_radius;
}

function bot_dom_leader_dialog(var_0, var_1) {
  if(issubstr(var_0, "losing") && var_0 != "losing_score" && var_0 != "losing_time" && var_0 != "gamestate_domlosing") {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_3 = get_specific_flag_by_label(var_2);

    if(isDefined(var_3) && bot_allow_to_capture_flag(var_3)) {
      self botmemoryevent("known_enemy", undefined, var_3.trigger.origin);

      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\bots_util::bot_is_protecting()) {
          var_4 = distancesquared(self.origin, var_3.trigger.origin) < 490000;
          var_5 = bot_is_protecting_flag(var_3);

          if(var_4 || var_5) {
            capture_flag(var_3);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  } else if(issubstr(var_0, "secured")) {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_6 = get_specific_flag_by_label(var_2);
    var_6.last_time_secured[self.team] = gettime();
  }

  scripts\mp\bots\bots_util::bot_leader_dialog(var_0, var_1);
}

function bot_allow_to_capture_flag(var_0) {
  var_1 = get_override_flag_targets();

  if(var_1.size == 0) {
    return true;
  }

  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return true;
  }

  return false;
}

function monitor_flag_status(var_0) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("bot_dom_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_1 = get_num_ally_flags(self.team);
  var_2 = get_flag_capture_radius() * get_flag_capture_radius();
  var_3 = get_flag_capture_radius() * 3 * get_flag_capture_radius() * 3;
  var_4 = 1;

  while(var_4) {
    var_5 = 0;
    var_6 = var_0 scripts\mp\gametypes\dom::getflagteam();
    var_7 = get_num_ally_flags(self.team);
    var_8 = get_enemy_flags(self.team);

    if(scripts\mp\bots\bots_util::bot_is_capturing()) {
      if(var_6 == self.team && var_0.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all()) {
          var_5 = 1;
        }
      }

      if(var_7 == 2 && var_6 != self.team && !bot_allowed_to_3_cap()) {
        if(isDefined(var_0.trigger) && distancesquared(self.origin, var_0.trigger.origin) > var_2) {
          var_5 = 1;
        }
      }

      foreach(var_10 in var_8) {
        if(isDefined(var_10.trigger) && var_10 != var_0 && bot_allow_to_capture_flag(var_10)) {
          if(distancesquared(self.origin, var_10.trigger.origin) < var_3) {
            var_5 = 1;
          }
        }
      }

      if(isDefined(var_0.trigger) && self istouching(var_0.trigger) && var_0.userate <= 0) {
        if(self bothasscriptgoal()) {
          var_12 = self botgetscriptgoal();
          var_13 = self botgetscriptgoalRadius();

          if(distancesquared(self.origin, var_12) < squared(var_13)) {
            var_14 = self getnearestnode();

            if(isDefined(var_14)) {
              var_15 = undefined;

              foreach(var_17 in var_0.nodes) {
                if(!nodesvisible(var_17, var_14, 1)) {
                  var_15 = var_17.origin;
                  break;
                }
              }

              if(isDefined(var_15)) {
                self.defense_investigate_specific_point = var_15;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\bots_util::bot_is_protecting()) {
      if(var_6 != self.team) {
        if(!bot_dom_debug_should_protect_all()) {
          var_5 = 1;
        }
      } else if(var_7 == 1 && var_1 > 1) {
        var_5 = 1;
      }
    }

    var_1 = var_7;

    if(var_5) {
      self.force_new_goal = 1;
      var_4 = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    var_19 = level scripts\engine\utility::waittill_notify_or_timeout_return("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    var_20 = isDefined(var_19) && var_19 == "timeout";

    if(!var_20) {
      var_21 = max((3 - self.strategy_level) * 1 + randomfloatrange(-0.5, 0.5), 0);
      wait var_21;
    }
  }
}

function bot_dom_get_node_chance(var_0) {
  if(var_0 == self.node_closest_to_defend_center) {
    return 1;
  }

  if(!isDefined(self.current_flag)) {
    return 1;
  }

  var_1 = 0;
  var_2 = get_flag_label(self.current_flag);
  var_3 = get_ally_flags(self.team);

  foreach(var_5 in var_3) {
    if(var_5 != self.current_flag) {
      var_1 = var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_5));

      if(var_1) {
        var_6 = get_other_flag(self.current_flag, var_5);
        var_7 = var_6 scripts\mp\gametypes\dom::getflagteam();

        if(var_7 != self.team) {
          if(var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_6))) {
            var_1 = 0;
          }
        }
      }
    }
  }

  if(var_1) {
    return 0.2;
  }

  return 1;
}

function get_flag_label(var_0) {
  var_1 = "";

  if(isDefined(var_0.teleport_zone)) {
    var_1 += var_0.teleport_zone + "_";
  }

  var_1 += "flag" + var_0.objectivekey;
  return var_1;
}

function get_other_flag(var_0, var_1) {
  foreach(var_3 in level.objectives) {
    if(var_3 != var_0 && var_3 != var_1) {
      return var_3;
    }
  }
}

function get_specific_flag_by_letter(var_0) {
  var_1 = "_" + tolower(var_0);
  return get_specific_flag_by_label(var_1);
}

function get_specific_flag_by_label(var_0) {
  foreach(var_2 in level.objectives) {
    if(var_2.objectivekey == var_0) {
      return var_2;
    }
  }
}

function get_closest_flag(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.objectives) {
    var_5 = distancesquared(var_4.trigger.origin, var_0);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

function get_num_allies_capturing_flag(var_0, var_1) {
  var_2 = 0;
  var_3 = get_flag_capture_radius();

  foreach(var_5 in level.participants) {
    if(!isDefined(var_5.team)) {
      continue;
    }

    if(var_5.team == self.team && var_5 != self && scripts\mp\utility\entity::isteamparticipant(var_5)) {
      if(isai(var_5)) {
        if(bot_is_capturing_flag(var_5, var_0)) {
          var_2++;
        }

        continue;
      }

      if(!isDefined(var_1) || !var_1) {
        if(var_5 istouching(var_0)) {
          var_2++;
        }
      }
    }
  }

  return var_2;
}

function bot_is_capturing_flag(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return 0;
  }

  return bot_target_is_flag(var_0);
}

function bot_is_protecting_flag(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting()) {
    return 0;
  }

  return bot_target_is_flag(var_0);
}

function bot_target_is_flag(var_0) {
  return self.current_flag == var_0;
}

function get_num_ally_flags(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    var_4 = var_3 scripts\mp\gametypes\dom::getflagteam();

    if(var_4 == var_0) {
      var_1++;
    }
  }

  return var_1;
}

function get_enemy_flags(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_4 = var_3 scripts\mp\gametypes\dom::getflagteam();

    if(var_4 == scripts\engine\utility::get_enemy_team(var_0)) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

function get_ally_flags(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_4 = var_3 scripts\mp\gametypes\dom::getflagteam();

    if(var_4 == var_0) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

function bot_should_defend_flag(var_0, var_1) {
  var_2 = get_max_num_defenders_wanted_per_flag(var_1);
  var_3 = get_players_defending_flag(var_0);
  return var_3.size < var_2;
}

function get_max_num_defenders_wanted_per_flag(var_0) {
  var_1 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);

  if(var_0 == 1) {
    return ceil(var_1 / 6);
  }

  return ceil(var_1 / 3);
}

function get_players_defending_flag(var_0) {
  var_1 = get_flag_protect_radius();
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }

    if(var_4.team == self.team && var_4 != self && scripts\mp\utility\entity::isteamparticipant(var_4)) {
      if(isai(var_4)) {
        if(bot_is_protecting_flag(var_4, var_0)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_4);
        }

        continue;
      }

      var_5 = gettime() - var_0.last_time_secured[self.team];

      if(var_5 < 10000) {
        continue;
      }

      if(isDefined(var_0.trigger) && distancesquared(var_0.trigger.origin, var_4.origin) < var_1 * var_1) {
        var_2 = scripts\engine\utility::array_add(var_2, var_4);
      }
    }
  }

  return var_2;
}

function bot_dom_debug_should_capture_all() {
  return false;
}

function bot_dom_debug_should_protect_all() {
  return false;
}