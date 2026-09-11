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

  var0 = scripts\engine\utility::ter_op(level.objmodifier == 1, 3, 1);
  scripts\mp\bots\bots_gametype_dom::setup_bot_dom(var0, 3);
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
  var0 = "throwingknife_mp";

  for(;;) {
    var1 = 0;

    if(calloutmarkerping_islootquesttablet() || scripts\mp\bots\bots_util::damagestatedata(0.33)) {
      if(self[[level.bot_funcs["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
        var2 = getEntArray("dropped_weapon", "targetname");
        var3 = scripts\engine\utility::get_array_of_closest(self.origin, var2);

        if(var3.size > 0) {
          var4 = var3[0];
          level.moderestrictsarenakillstreaks = var4;
          calloutmarkerping_navigationcancelproximity(var4);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::bot_in_combat() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting("strategyLevel") > 0) {
      var5 = self hasweapon(var0);
      var6 = var5 && self getammocount(var0) == 0;

      if(var6) {
        if(isDefined(self.going_for_knife)) {
          wait 5;
          continue;
        }

        var7 = getEntArray("dropped_knife", "targetname");
        var8 = scripts\engine\utility::get_array_of_closest(self.origin, var7);

        foreach(var10 in var8) {
          if(!isDefined(var10)) {
            continue;
          }

          if(!isDefined(var10.calculated_closest_point)) {
            var11 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", &scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, var10.origin, 32, self);

            if(isDefined(var10)) {
              var10.closest_point_on_grid = var11;
              var10.calculated_closest_point = 1;
            } else {
              continue;
            }
          }

          if(isDefined(var10.closest_point_on_grid)) {
            self.going_for_knife = 1;
            calloutmarkerping_navigationcancelproximity(var10);
          }
        }
      } else if(var5) {
        self.going_for_knife = undefined;
      }
    }

    wait randomfloatrange(0.25, 0.75);
  }
}

function calloutmarkerping_navigationcancelproximity(var0) {
  if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("seek_dropped_weapon", var0) == 0) {
    if(istrue(level.ref_1343f)) {
      var1 = self botfirstavailablegrenade("lethal");
      var2 = self botfirstavailablegrenade("tactical");

      if(isDefined(var1) && var1.basename == "snowball_mp") {
        var3 = scripts\mp\equipment::getcurrentequipment("primary");
        var4 = scripts\mp\equipment::getequipmentammo(var3);

        if(var1.basename == "snowball_mp" && var4 > 3) {
          return;
        }
      }

      if(isDefined(var2) && var2.basename == "pball_mp") {
        var3 = scripts\mp\equipment::getcurrentequipment("secondary");
        var4 = scripts\mp\equipment::getequipmentammo(var3);

        if(var2.basename == "pball_mp") {
          return;
        }
      }
    }

    var5 = undefined;

    if(var0.targetname == "dropped_weapon") {
      var6 = 1;
      var7 = self getweaponslistprimaries();

      foreach(var9 in var7) {
        if(var0.model == getweaponmodel(var9)) {
          var6 = 0;
        }
      }

      if(var6) {
        var5 = &calloutmarkerping_ismunitionsbox;
      }
    }

    var11 = spawnStruct();
    var11.object = var0;
    var11.script_goal_radius = 12;
    var11.should_abort = level.bot_funcs["dropped_weapon_cancel"];
    var11.action_thread = var5;
    var12 = undefined;
    var13 = var0.origin;

    if(isDefined(var0.deafen_ai_near_pa_for_duration)) {
      var13 = var0.deafen_ai_near_pa_for_duration;
    }

    scripts\mp\bots\bots_strategy::bot_new_tactical_goal("seek_dropped_weapon", var13, 100, var11);
    return;
  }
}

function calloutmarkerping_ismunitionsbox(var0) {
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

function calloutmarkerping_removevehiclecalloutonspecialconditions(var0) {
  if(calloutmarkerping_islethalequipment() > 0) {
    var1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(isDefined(var0.object)) {
      var2 = var0.object.classname;

      if(scripts\engine\utility::string_starts_with(var2, "weapon_")) {
        var2 = getsubstr(var2, 7);
      }

      var3 = scripts\mp\utility\weapon::getweapongroup(var2);

      if(!bot_weapon_is_better_class(var1, var3)) {
        return true;
      }
    }
  }

  if(!isDefined(var0.object)) {
    return true;
  }

  if(var0.object.targetname == "dropped_weapon") {
    foreach(var5 in self.weaponlist) {
      if(var5.basename == "iw8_fists_mp") {
        return false;
      }
    }

    if(calloutmarkerping_islethalequipment() > 0) {
      return true;
    }
  } else if(var0.object.targetname == "dropped_knife") {
    if(scripts\mp\bots\bots_util::bot_in_combat()) {
      self.going_for_knife = undefined;
      return true;
    }
  }

  return false;
}

function calloutmarkerping_islethalequipment() {
  var0 = 0;
  var1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var1 = self.weaponlist;
  } else {
    var1 = self getweaponslistprimaries();
  }

  foreach(var3 in var1) {
    var0 += self getweaponammoclip(var3);
    var0 += self getweaponammostock(var3);
  }

  if(var1.size == 1 && var1[0].basename == "iw8_fists_mp") {
    var0 = 0;
  }

  return var0;
}

function calloutmarkerping_islootquesttablet() {
  var0 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var0 = self.weaponlist;
  } else {
    var0 = self getweaponslistprimaries();
  }

  if(var0.size == 1 && var0[0].basename == "iw8_fists_mp") {
    return true;
  }

  foreach(var2 in var0) {
    if(self getweaponammoclip(var2) > 0) {
      return false;
    }

    if(self getweaponammostock(var2) > 0) {
      return false;
    }
  }

  return true;
}

function bot_rank_weapon_class(var0) {
  var1 = 0;

  switch (var0) {
    case "weapon_other":
    case "weapon_projectile":
    case "weapon_explosive":
    case "weapon_grenade":
      break;
    case "weapon_pistol":
      var1 = 1;
      break;
    case "weapon_dmr":
    case "weapon_sniper":
      var1 = 2;
      break;
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_assault":
    case "weapon_smg":
    case "weapon_tactical":
      var1 = 3;
      break;
  }

  return var1;
}

function bot_weapon_is_better_class(var0, var1) {
  var2 = bot_rank_weapon_class(var0);
  var3 = bot_rank_weapon_class(var1);
  return var3 > var2;
}

function vehicle_compass_br_shouldbevisibletoplayer(var0) {
  var1 = spawncovernode(var0, (0, randomint(360), 0), "Cover Stand");

  if(!isDefined(level.arenaflag.nodes)) {
    level.arenaflag.nodes = [];
  }

  level.arenaflag.nodes[level.arenaflag.nodes.size] = var1;

  if(!isDefined(level.objectives["_a"].bottargets)) {
    level.objectives["_a"].bottargets = [];
  }

  level.objectives["_a"].bottargets[level.objectives["_a"].bottargets.size] = var1;
}

function damage_multiplier() {
  if(level.mapname == "mp_m_pine") {
    var0 = (22, 12, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
    var0 = (-4, 1, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
    var0 = (0, -33, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
    var0 = (35, -23, 0);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
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
    var0 = gettime();

    if(var0 > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("strategyLevel");
    }

    if(var0 > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision()) {
        self.new_goal_time = var0 + 5000;
      } else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = var0 + randomintrange(30000, 45000);
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

  var0 = get_flag_capture_radius();

  if(isDefined(self.current_flag.trigger) && distancesquared(self.origin, self.current_flag.trigger.origin) < var0 * 2 * var0 * 2) {
    var1 = get_ally_flags(self.team);

    if(var1.size == 2 && !scripts\engine\utility::array_contains(var1, self.current_flag) && !bot_allowed_to_3_cap()) {
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
  var0 = get_override_flag_targets();
  return var0.size > 0;
}

function flag_has_been_captured_before(var0) {
  return !flag_has_never_been_captured(var0);
}

function flag_has_never_been_captured(var0) {
  return var0.firstcapture;
}

function bot_choose_flag() {
  var0 = undefined;
  var1 = [];
  var2 = [];
  var3 = get_override_flag_targets();

  if(var3.size > 0) {
    var4 = var3;
  } else {
    var4 = level.objectives;
  }

  foreach(var1 in var4) {
    if(var1.objectivekey == "_a") {
      continue;
    }

    var6 = var1 scripts\mp\gametypes\dom::getflagteam();

    if(flag_has_been_captured_before(var1)) {
      var7 = 0;
    }

    if(var6 != self.team) {
      var2 = var1;
      continue;
    }

    var3 = var1;
  }

  var9 = undefined;

  if(var3.size == 1) {
    if(!bot_should_defend_flag(var3[0], 1)) {
      var9 = 1;
    } else {
      var9 = !bot_should_defend(0.34);
    }
  } else {
    return;
  }

  if(var9) {
    var10 = var2;

    if(var10.size == 1) {
      var1 = var10[0];
    }
  } else {
    var11 = var3;

    foreach(var13 in var11) {
      if(bot_should_defend_flag(var13, var3.size)) {
        var1 = var13;
        break;
      }
    }
  }

  if(var9) {
    capture_flag(var1);
    return;
  }

  defend_flag(var1);
}

function bot_allowed_to_3_cap() {
  return true;
}

function bot_should_defend(var0) {
  if(randomfloat(1) < var0) {
    return 1;
  }

  var1 = level.bot_personality_type[self.personality];

  if(var1 == "stationary") {
    return 1;
  }

  if(var1 == "active") {
    return 0;
  }
}

function capture_flag(var0, var1, var2) {
  self.current_flag = var0;

  if(isDefined(var0.trigger)) {
    if(bot_dom_debug_should_protect_all()) {
      GscBinSkip1(0x45, "override_goal_type", var1);
    }

    GscBinSkip1(0x45, "override_goal_type", var1);
  }
}

function defend_flag(var0) {
  self.current_flag = var0;

  if(isDefined(var0.trigger)) {
    if(bot_dom_debug_should_capture_all()) {
      GscBinSkip1(0x45, "entrance_points_index", get_flag_label(var0));
    }

    GscBinSkip1(0x45, "entrance_points_index", get_flag_label(var0));
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
    var0 = self botgetworldsize();
    var1 = (var0[0] + var0[1]) / 2;
    level.protect_radius = min(1000, var1 / 3.5);
  }

  return level.protect_radius;
}

function bot_dom_leader_dialog(var0, var1) {
  if(issubstr(var0, "losing") && var0 != "losing_score" && var0 != "losing_time" && var0 != "gamestate_domlosing") {
    var2 = getsubstr(var0, var0.size - 2);
    var3 = get_specific_flag_by_label(var2);

    if(isDefined(var3) && bot_allow_to_capture_flag(var3)) {
      self botmemoryevent("known_enemy", undefined, var3.trigger.origin);

      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\bots_util::bot_is_protecting()) {
          var4 = distancesquared(self.origin, var3.trigger.origin) < 490000;
          var5 = bot_is_protecting_flag(var3);

          if(var4 || var5) {
            capture_flag(var3);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  } else if(issubstr(var0, "secured")) {
    var2 = getsubstr(var0, var0.size - 2);
    var6 = get_specific_flag_by_label(var2);
    var6.last_time_secured[self.team] = gettime();
  }

  scripts\mp\bots\bots_util::bot_leader_dialog(var0, var1);
}

function bot_allow_to_capture_flag(var0) {
  var1 = get_override_flag_targets();

  if(var1.size == 0) {
    return true;
  }

  if(scripts\engine\utility::array_contains(var1, var0)) {
    return true;
  }

  return false;
}

function monitor_flag_status(var0) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("bot_dom_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var1 = get_num_ally_flags(self.team);
  var2 = get_flag_capture_radius() * get_flag_capture_radius();
  var3 = get_flag_capture_radius() * 3 * get_flag_capture_radius() * 3;
  var4 = 1;

  while(var4) {
    var5 = 0;
    var6 = var0 scripts\mp\gametypes\dom::getflagteam();
    var7 = get_num_ally_flags(self.team);
    var8 = get_enemy_flags(self.team);

    if(scripts\mp\bots\bots_util::bot_is_capturing()) {
      if(var6 == self.team && var0.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all()) {
          var5 = 1;
        }
      }

      if(var7 == 2 && var6 != self.team && !bot_allowed_to_3_cap()) {
        if(isDefined(var0.trigger) && distancesquared(self.origin, var0.trigger.origin) > var2) {
          var5 = 1;
        }
      }

      foreach(var10 in var8) {
        if(isDefined(var10.trigger) && var10 != var0 && bot_allow_to_capture_flag(var10)) {
          if(distancesquared(self.origin, var10.trigger.origin) < var3) {
            var5 = 1;
          }
        }
      }

      if(isDefined(var0.trigger) && self istouching(var0.trigger) && var0.userate <= 0) {
        if(self bothasscriptgoal()) {
          var12 = self botgetscriptgoal();
          var13 = self botgetscriptgoalRadius();

          if(distancesquared(self.origin, var12) < squared(var13)) {
            var14 = self getnearestnode();

            if(isDefined(var14)) {
              var15 = undefined;

              foreach(var17 in var0.nodes) {
                if(!nodesvisible(var17, var14, 1)) {
                  var15 = var17.origin;
                  break;
                }
              }

              if(isDefined(var15)) {
                self.defense_investigate_specific_point = var15;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\bots_util::bot_is_protecting()) {
      if(var6 != self.team) {
        if(!bot_dom_debug_should_protect_all()) {
          var5 = 1;
        }
      } else if(var7 == 1 && var1 > 1) {
        var5 = 1;
      }
    }

    var1 = var7;

    if(var5) {
      self.force_new_goal = 1;
      var4 = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    var19 = level scripts\engine\utility::waittill_notify_or_timeout_return("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    var20 = isDefined(var19) && var19 == "timeout";

    if(!var20) {
      var21 = max((3 - self.strategy_level) * 1 + randomfloatrange(-0.5, 0.5), 0);
      wait var21;
    }
  }
}

function bot_dom_get_node_chance(var0) {
  if(var0 == self.node_closest_to_defend_center) {
    return 1;
  }

  if(!isDefined(self.current_flag)) {
    return 1;
  }

  var1 = 0;
  var2 = get_flag_label(self.current_flag);
  var3 = get_ally_flags(self.team);

  foreach(var5 in var3) {
    if(var5 != self.current_flag) {
      var1 = var0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var2, get_flag_label(var5));

      if(var1) {
        var6 = get_other_flag(self.current_flag, var5);
        var7 = var6 scripts\mp\gametypes\dom::getflagteam();

        if(var7 != self.team) {
          if(var0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var2, get_flag_label(var6))) {
            var1 = 0;
          }
        }
      }
    }
  }

  if(var1) {
    return 0.2;
  }

  return 1;
}

function get_flag_label(var0) {
  var1 = "";

  if(isDefined(var0.teleport_zone)) {
    var1 += var0.teleport_zone + "_";
  }

  var1 += "flag" + var0.objectivekey;
  return var1;
}

function get_other_flag(var0, var1) {
  foreach(var3 in level.objectives) {
    if(var3 != var0 && var3 != var1) {
      return var3;
    }
  }
}

function get_specific_flag_by_letter(var0) {
  var1 = "_" + tolower(var0);
  return get_specific_flag_by_label(var1);
}

function get_specific_flag_by_label(var0) {
  foreach(var2 in level.objectives) {
    if(var2.objectivekey == var0) {
      return var2;
    }
  }
}

function get_closest_flag(var0) {
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in level.objectives) {
    var5 = distancesquared(var4.trigger.origin, var0);

    if(!isDefined(var2) || var5 < var2) {
      var1 = var4;
      var2 = var5;
    }
  }

  return var1;
}

function get_num_allies_capturing_flag(var0, var1) {
  var2 = 0;
  var3 = get_flag_capture_radius();

  foreach(var5 in level.participants) {
    if(!isDefined(var5.team)) {
      continue;
    }

    if(var5.team == self.team && var5 != self && scripts\mp\utility\entity::isteamparticipant(var5)) {
      if(isai(var5)) {
        if(bot_is_capturing_flag(var5, var0)) {
          var2++;
        }

        continue;
      }

      if(!isDefined(var1) || !var1) {
        if(var5 istouching(var0)) {
          var2++;
        }
      }
    }
  }

  return var2;
}

function bot_is_capturing_flag(var0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return 0;
  }

  return bot_target_is_flag(var0);
}

function bot_is_protecting_flag(var0) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting()) {
    return 0;
  }

  return bot_target_is_flag(var0);
}

function bot_target_is_flag(var0) {
  return self.current_flag == var0;
}

function get_num_ally_flags(var0) {
  var1 = 0;

  foreach(var3 in level.objectives) {
    var4 = var3 scripts\mp\gametypes\dom::getflagteam();

    if(var4 == var0) {
      var1++;
    }
  }

  return var1;
}

function get_enemy_flags(var0) {
  var1 = [];

  foreach(var3 in level.objectives) {
    var4 = var3 scripts\mp\gametypes\dom::getflagteam();

    if(var4 == scripts\engine\utility::get_enemy_team(var0)) {
      var1 = scripts\engine\utility::array_add(var1, var3);
    }
  }

  return var1;
}

function get_ally_flags(var0) {
  var1 = [];

  foreach(var3 in level.objectives) {
    var4 = var3 scripts\mp\gametypes\dom::getflagteam();

    if(var4 == var0) {
      var1 = scripts\engine\utility::array_add(var1, var3);
    }
  }

  return var1;
}

function bot_should_defend_flag(var0, var1) {
  var2 = get_max_num_defenders_wanted_per_flag(var1);
  var3 = get_players_defending_flag(var0);
  return var3.size < var2;
}

function get_max_num_defenders_wanted_per_flag(var0) {
  var1 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);

  if(var0 == 1) {
    return ceil(var1 / 6);
  }

  return ceil(var1 / 3);
}

function get_players_defending_flag(var0) {
  var1 = get_flag_protect_radius();
  var2 = [];

  foreach(var4 in level.participants) {
    if(!isDefined(var4.team)) {
      continue;
    }

    if(var4.team == self.team && var4 != self && scripts\mp\utility\entity::isteamparticipant(var4)) {
      if(isai(var4)) {
        if(bot_is_protecting_flag(var4, var0)) {
          var2 = scripts\engine\utility::array_add(var2, var4);
        }

        continue;
      }

      var5 = gettime() - var0.last_time_secured[self.team];

      if(var5 < 10000) {
        continue;
      }

      if(isDefined(var0.trigger) && distancesquared(var0.trigger.origin, var4.origin) < var1 * var1) {
        var2 = scripts\engine\utility::array_add(var2, var4);
      }
    }
  }

  return var2;
}

function bot_dom_debug_should_capture_all() {
  return false;
}

function bot_dom_debug_should_protect_all() {
  return false;
}