/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_ks.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\bots\_bots;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_ks_remote_vehicle;
#include maps\mp\bots\_bots_sentry;

bot_killstreak_setup() {
  if(!isDefined(level.killstreak_botfunc)) {
    bot_register_killstreak_func("ball_drone_backup", ::bot_killstreak_simple_use, ::bot_can_use_ball_drone);
    bot_register_killstreak_func("ball_drone_radar", ::bot_killstreak_simple_use, ::bot_can_use_ball_drone);
    bot_register_killstreak_func("guard_dog", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("recon_agent", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("agent", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("nuke", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("jammer", ::bot_killstreak_simple_use, ::bot_can_use_emp);
    bot_register_killstreak_func("air_superiority", ::bot_killstreak_simple_use, ::bot_can_use_air_superiority);
    bot_register_killstreak_func("helicopter", ::bot_killstreak_simple_use, ::aerial_vehicle_allowed);
    bot_register_killstreak_func("specialist", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("all_perks_bonus", ::bot_killstreak_simple_use);

    bot_register_killstreak_func("airdrop_juggernaut", ::bot_killstreak_drop_outside);
    bot_register_killstreak_func("airdrop_juggernaut_maniac", ::bot_killstreak_drop_outside);
    bot_register_killstreak_func("airdrop_juggernaut_recon", ::bot_killstreak_drop_outside);
    bot_register_killstreak_func("uav_3dping", ::bot_killstreak_drop_outside);
    bot_register_killstreak_func("deployable_vest", ::bot_killstreak_drop_anywhere);
    bot_register_killstreak_func("deployable_ammo", ::bot_killstreak_drop_anywhere);

    bot_register_killstreak_func("odin_assault", ::bot_killstreak_remote_control, ::aerial_vehicle_allowed, ::bot_control_odin_assault);
    bot_register_killstreak_func("odin_support", ::bot_killstreak_remote_control, ::aerial_vehicle_allowed, ::bot_control_odin_support);
    bot_register_killstreak_func("heli_pilot", ::bot_killstreak_remote_control, ::heli_pilot_allowed, ::bot_control_heli_pilot);
    bot_register_killstreak_func("heli_sniper", ::bot_killstreak_remote_control, ::heli_sniper_allowed, ::bot_control_heli_sniper);
    bot_register_killstreak_func("drone_hive", ::bot_killstreak_remote_control, undefined, ::bot_control_switchblade_cluster);
    bot_register_killstreak_func("vanguard", ::bot_killstreak_vanguard_start, ::vanguard_allowed, ::bot_control_vanguard);

    bot_register_killstreak_func("ims", ::bot_killstreak_sentry, undefined, "trap");
    bot_register_killstreak_func("sentry", ::bot_killstreak_sentry, undefined, "turret");
    bot_register_killstreak_func("uplink", ::bot_killstreak_sentry, undefined, "hide_nonlethal");
    bot_register_killstreak_func("uplink_support", ::bot_killstreak_sentry, undefined, "hide_nonlethal");

    bot_register_killstreak_func("aa_launcher", ::bot_killstreak_never_use, ::bot_can_use_aa_launcher);

    bot_register_killstreak_func("airdrop_assault", ::bot_killstreak_drop_outside);

    if(isDefined(level.mapCustomBotKillstreakFunc))
      [[level.mapCustomBotKillstreakFunc]]();

    if(!is_aliens()) {
      bot_validate_killstreak_funcs();
    }
  }

  thread remote_vehicle_setup();
}

bot_register_killstreak_func(name, func, can_use, optionalParam) {
  if(!isDefined(level.killstreak_botfunc))
    level.killstreak_botfunc = [];

  level.killstreak_botfunc[name] = func;

  if(!isDefined(level.killstreak_botcanuse))
    level.killstreak_botcanuse = [];

  level.killstreak_botcanuse[name] = can_use;

  if(!isDefined(level.killstreak_botparm))
    level.killstreak_botparm = [];

  level.killstreak_botparm[name] = optionalParam;

  if(!isDefined(level.bot_supported_killstreaks))
    level.bot_supported_killstreaks = [];
  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = name;
}

assert_streak_valid_for_bots_in_general(streak) {
  if(!bot_killstreak_valid_for_bots_in_general(streak)) {
    AssertMsg("Bots do not support killstreak <" + streak + ">");
  }
}

assert_streak_valid_for_specific_bot(streak, bot) {
  if(!bot_killstreak_valid_for_specific_bot(streak, bot)) {
    AssertMsg("Bot <" + bot.name + "> does not support killstreak <" + streak + ">");
  }
}

bot_validate_killstreak_funcs() {
  wait(1);

  errors = [];
  foreach(streakName in level.bot_supported_killstreaks) {
    if(!bot_killstreak_valid_for_humans(streakName)) {
      error("bot_validate_killstreak_funcs() invalid killstreak: " + streakName);
      errors[errors.size] = streakName;
    }
  }
  if(errors.size) {
    temp = level.killstreakFuncs;
    level.killStreakFuncs = [];
    foreach(streakName in temp) {
      if(!array_contains(errors, streakName))
        level.killStreakFuncs[streakName] = temp[streakName];
    }
  }
}

bot_killstreak_valid_for_humans(streakName) {
  return bot_killstreak_is_valid_internal(streakName, "humans");
}

bot_killstreak_valid_for_bots_in_general(streakName) {
  return bot_killstreak_is_valid_internal(streakName, "bots");
}

bot_killstreak_valid_for_specific_bot(streakName, bot) {
  return bot_killstreak_is_valid_internal(streakName, "bots", bot);
}

bot_killstreak_valid_for_specific_streakType(streakName, streakType, assertIt) {
  if(bot_is_fireteam_mode()) {
    return true;
  }

  if(bot_killstreak_is_valid_internal(streakName, "bots", undefined, streakType)) {
    return true;
  } else if(assertIt) {
    AssertMsg("Bots with streakType <" + streakType + "> do not support killstreak <" + streakName + ">");
  }

  return false;
}

bot_killstreak_is_valid_internal(streakName, who_to_check, optional_bot, optional_streak_type) {
  streakTypeSubStr = undefined;

  if(streakName == "specialist")
    return true;

  if(!bot_killstreak_is_valid_single(streakName, who_to_check)) {
    return false;
  }

  if(isDefined(optional_streak_type)) {
    streakTypeSubStr = GetSubStr(optional_streak_type, 11);

    switch (streakTypeSubStr) {
      case "assault":
        if(!isAssaultKillstreak(streakName))
          return false;
        break;
      case "support":
        if(!isSupportKillstreak(streakName))
          return false;
        break;
      case "specialist":
        if(!isSpecialistKillstreak(streakName))
          return false;
        break;
    }
  }

  return true;
}

bot_killstreak_is_valid_single(streakName, who_to_check) {
  if(who_to_check == "humans") {
    return (isDefined(level.killstreakFuncs[streakName]) && getKillstreakIndex(streakName) != -1);
  } else if(who_to_check == "bots") {
    return isDefined(level.killstreak_botfunc[streakName]);
  }

  AssertMsg("Unreachable");
}

bot_think_killstreak() {
  self notify("bot_think_killstreak");
  self endon("bot_think_killstreak");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.killstreak_botfunc))
    wait(0.05);

  self childthread bot_start_aa_launcher_tracking();

  for(;;) {
    if(self bot_allowed_to_use_killstreaks()) {
      killstreaks_array = self.pers["killstreaks"];
      if(isDefined(killstreaks_array)) {
        restart_loop = false;
        for(ksi = 0; ksi < killstreaks_array.size && !restart_loop; ksi++) {
          killstreak_info = killstreaks_array[ksi];

          if(isDefined(killstreak_info.streakName) && isDefined(self.bot_killstreak_wait) && isDefined(self.bot_killstreak_wait[killstreak_info.streakName]) && GetTime() < self.bot_killstreak_wait[killstreak_info.streakName]) {
            continue;
          }
          if(killstreak_info.available) {
            tableName = killstreak_info.streakName;

            if(killstreak_info.streakName == "all_perks_bonus") {
              continue;
            }
            if(isSpecialistKillstreak(killstreak_info.streakName)) {
              if(!killstreak_info.earned)
                tableName = "specialist";
              else
                continue;
            }

            killstreak_info.weapon = getKillstreakWeapon(killstreak_info.streakName);

            can_use_killstreak_function = level.killstreak_botcanuse[tableName];
            if(isDefined(can_use_killstreak_function) && !self[[can_use_killstreak_function]]()) {
              continue;
            }
            if(!self validateUseStreak(killstreak_info.streakName, true)) {
              continue;
            }
            bot_killstreak_func = level.killstreak_botfunc[tableName];

            if(isDefined(bot_killstreak_func)) {
              result = self[[bot_killstreak_func]](killstreak_info, killstreaks_array, can_use_killstreak_function, level.killstreak_botparm[killstreak_info.streakName]);
              if(!isDefined(result) || result == false) {
                if(!isDefined(self.bot_killstreak_wait))
                  self.bot_killstreak_wait = [];
                self.bot_killstreak_wait[killstreak_info.streakName] = GetTime() + 5000;
              }
            } else {
              AssertMsg("Bots do not know how to use killstreak <" + killstreak_info.streakName + ">");
              killstreak_info.available = false;
              self maps\mp\killstreaks\_killstreaks::updateKillstreaks(false);
            }

            restart_loop = true;
          }
        }
      }
    }

    wait(RandomFloatRange(1.0, 2.0));
  }
}

bot_can_use_aa_launcher() {
  return false;
}

bot_start_aa_launcher_tracking() {
  aaLauncherName = maps\mp\killstreaks\_AALauncher::getAALauncherName();
  while(1) {
    self waittill("aa_launcher_fire");
    ammo_left = self GetAmmoCount(aaLauncherName);
    if(ammo_left == 0) {
      self SwitchToWeapon(aaLauncherName);

      result = self waittill_any_return("LGM_player_allMissilesDestroyed", "enemy");

      wait(0.5);
      self SwitchToWeapon("none");
    }
  }
}

bot_killstreak_never_use() {
  AssertMsg("bot_killstreak_never_use() was somehow called");
}

bot_can_use_air_superiority() {
  if(!self aerial_vehicle_allowed())
    return false;

  possible_targets = maps\mp\killstreaks\_air_superiority::findAllTargets(self, self.team);
  cur_time = GetTime();
  foreach(target in possible_targets) {
    if(cur_time - target.birthtime > 5000)
      return true;
  }

  return false;
}

aerial_vehicle_allowed() {
  if(self isAirDenied())
    return false;

  if(vehicle_would_exceed_limit())
    return false;

  return true;
}

vehicle_would_exceed_limit() {
  return (currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + 1 >= maxVehiclesAllowed());
}

bot_can_use_emp() {
  if(isDefined(level.empPlayer))
    return false;

  otherTeam = level.otherTeam[self.team];
  if(isDefined(level.teamEMPed) && isDefined(level.teamEMPed[otherTeam]) && level.teamEMPed[otherTeam])
    return false;

  return true;
}

bot_can_use_ball_drone() {
  if(self isUsingRemote())
    return false;

  if(maps\mp\killstreaks\_ball_drone::exceededMaxBallDrones())
    return false;

  if(vehicle_would_exceed_limit())
    return false;

  if(isDefined(self.ballDrone))
    return false;

  return true;
}

bot_killstreak_simple_use(killstreak_info, killstreaks_array, canUseFunc, optional_param) {
  self endon("commander_took_over");

  wait(RandomIntRange(3, 5));

  if(!self bot_allowed_to_use_killstreaks()) {
    return true;
  }

  if(isDefined(canUseFunc) && !self[[canUseFunc]]())
    return false;

  bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);

  return true;
}

bot_killstreak_drop_anywhere(killstreak_info, killstreaks_array, canUseFunc, optional_param) {
  bot_killstreak_drop(killstreak_info, killstreaks_array, canUseFunc, optional_param, "anywhere");
}

bot_killstreak_drop_outside(killstreak_info, killstreaks_array, canUseFunc, optional_param) {
  bot_killstreak_drop(killstreak_info, killstreaks_array, canUseFunc, optional_param, "outside");
}

bot_killstreak_drop_hidden(killstreak_info, killstreaks_array, canUseFunc, optional_param) {
  bot_killstreak_drop(killstreak_info, killstreaks_array, canUseFunc, optional_param, "hidden");
}

bot_killstreak_drop(killstreak_info, killstreaks_array, canUseFunc, optional_param, drop_where) {
  self endon("commander_took_over");

  wait(RandomIntRange(2, 4));

  if(!isDefined(drop_where))
    drop_where = "anywhere";

  if(!self bot_allowed_to_use_killstreaks()) {
    return true;
  }

  if(isDefined(canUseFunc) && !self[[canUseFunc]]())
    return false;

  ammo = self GetWeaponAmmoClip(killstreak_info.weapon) + self GetWeaponAmmoStock(killstreak_info.weapon);
  if(ammo == 0) {
    foreach(streak in killstreaks_array) {
      if(isDefined(streak.streakName) && streak.streakName == killstreak_info.streakName)
        streak.available = 0;
    }
    self maps\mp\killstreaks\_killstreaks::updateKillstreaks(false);
    return true;
  }

  node_target = undefined;
  if(drop_where == "outside") {
    outside_nodes = [];
    nodes_in_cone = self bot_get_nodes_in_cone(750, 0.6, true);
    foreach(node in nodes_in_cone) {
      if(NodeExposedToSky(node))
        outside_nodes = array_add(outside_nodes, node);
    }

    if((nodes_in_cone.size > 5) && (outside_nodes.size > nodes_in_cone.size * 0.6)) {
      outside_nodes_sorted = get_array_of_closest(self.origin, outside_nodes, undefined, undefined, undefined, 150);
      if(outside_nodes_sorted.size > 0)
        node_target = random(outside_nodes_sorted);
      else
        node_target = random(outside_nodes);
    }
  } else if(drop_where == "hidden") {
    nodes_in_radius = GetNodesInRadius(self.origin, 256, 0, 40);
    node_nearest_bot = self GetNearestNode();
    if(isDefined(node_nearest_bot)) {
      visible_nodes_in_radius = [];
      foreach(node in nodes_in_radius) {
        if(NodesVisible(node_nearest_bot, node, true))
          visible_nodes_in_radius = array_add(visible_nodes_in_radius, node);
      }

      node_target = self BotNodePick(visible_nodes_in_radius, 1, "node_hide");
    }
  }

  if(isDefined(node_target) || drop_where == "anywhere") {
    self BotSetFlag("disable_movement", true);

    if(isDefined(node_target))
      self BotLookAtPoint(node_target.origin, 1.5 + 0.95, "script_forced");

    bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
    wait(2.0);
    self BotPressButton("attack");
    wait(1.5);
    self SwitchToWeapon("none");
    self BotSetFlag("disable_movement", false);
  }

  return true;
}

bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, weapon_name) {
  self bot_notify_streak_used(killstreak_info, killstreaks_array);
  wait(0.05);
  self SwitchToWeapon(weapon_name);
}

bot_notify_streak_used(killstreak_info, killstreaks_array) {
  if(isDefined(killstreak_info.isgimme) && killstreak_info.isgimme) {
    self notify("streakUsed1");
  } else {
    for(index = 0; index < 3; index++) {
      if(isDefined(killstreaks_array[index].streakName)) {
        if(killstreaks_array[index].streakName == killstreak_info.streakname) {
          break;
        }
      }
    }
    self notify("streakUsed" + (index + 1));
  }
}

bot_killstreak_choose_loc_enemies(killstreak_info, killstreaks_array, canUseFunc, optional_param) {
  self endon("commander_took_over");
  wait(RandomIntRange(3, 5));

  if(!self bot_allowed_to_use_killstreaks()) {
    return;
  }

  zone_nearest_bot = GetZoneNearest(self.origin);
  if(!isDefined(zone_nearest_bot)) {
    return;
  }
  self BotSetFlag("disable_movement", true);
  bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
  wait 2;

  zone_count = level.zoneCount;
  best_zone = -1;
  best_zone_count = 0;
  possible_fallback_zones = [];
  iterate_backwards = RandomFloat(100) > 50;
  for(z = 0; z < zone_count; z++) {
    if(iterate_backwards)
      zone = zone_count - 1 - z;
    else
      zone = z;

    if((zone != zone_nearest_bot) && (BotZoneGetIndoorPercent(zone) < 0.25)) {
      enemies_in_zone = BotZoneGetCount(zone, self.team, "enemy_predict");
      if(enemies_in_zone > best_zone_count) {
        best_zone = zone;
        best_zone_count = enemies_in_zone;
      }

      possible_fallback_zones = array_add(possible_fallback_zones, zone);
    }
  }

  if(best_zone >= 0)
    zoneCenter = GetZoneOrigin(best_zone);
  else if(possible_fallback_zones.size > 0)
    zoneCenter = GetZoneOrigin(random(possible_fallback_zones));
  else
    zoneCenter = GetZoneOrigin(RandomInt(level.zoneCount));

  randomOffset = (RandomFloatRange(-500, 500), RandomFloatRange(-500, 500), 0);

  self notify("confirm_location", zoneCenter + randomOffset, RandomIntRange(0, 360));

  wait(1.0);
  self BotSetFlag("disable_movement", false);
}

SCR_CONST_GLOBAL_BP_TIME_BETWEEN_PLACING_MS = 4000;
SCR_CONST_GLOBAL_BP_DURATION_S = 5.0;

bot_think_watch_aerial_killstreak() {
  self notify("bot_think_watch_aerial_killstreak");
  self endon("bot_think_watch_aerial_killstreak");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(level.last_global_badplace_time))
    level.last_global_badplace_time = -10000;

  level.killstreak_global_bp_exists_for["allies"] = [];
  level.killstreak_global_bp_exists_for["axis"] = [];

  currently_hiding = false;
  next_wait_time = RandomFloatRange(0.05, 4.0);
  while(1) {
    wait(next_wait_time);
    next_wait_time = RandomFloatRange(0.05, 4.0);

    Assert(!isDefined(level.remote_mortar));

    if(self bot_is_remote_or_linked()) {
      continue;
    }
    if(self BotGetDifficultySetting("strategyLevel") == 0) {
      continue;
    }
    needs_to_hide = false;

    if(isDefined(level.chopper) && level.chopper.team != self.team)
      needs_to_hide = true;

    if(isDefined(level.lbSniper) && level.lbSniper.team != self.team)
      needs_to_hide = true;

    if(isDefined(level.heli_pilot[get_enemy_team(self.team)]))
      needs_to_hide = true;

    if(enemy_mortar_strike_exists(self.team)) {
      needs_to_hide = true;
      self try_place_global_badplace("mortar_strike", ::enemy_mortar_strike_exists);
    }

    if(enemy_switchblade_exists(self.team)) {
      needs_to_hide = true;
      self try_place_global_badplace("switchblade", ::enemy_switchblade_exists);
    }

    if(enemy_odin_assault_exists(self.team)) {
      needs_to_hide = true;
      self try_place_global_badplace("odin_assault", ::enemy_odin_assault_exists);
    }

    enemy_vanguard = self get_enemy_vanguard();
    if(isDefined(enemy_vanguard)) {
      botEye = self getEye();
      if(within_fov(botEye, self GetPlayerAngles(), enemy_vanguard.attackArrow.origin, self BotGetFovDot())) {
        if(SightTracePassed(botEye, enemy_vanguard.attackArrow.origin, false, self, enemy_vanguard.attackArrow))
          BadPlace_Cylinder("vanguard_" + enemy_vanguard GetEntityNumber(), next_wait_time + 0.5, enemy_vanguard.attackArrow.origin, 200, 100, self.team);
      }
    }

    if(!currently_hiding && needs_to_hide) {
      currently_hiding = true;
      self BotSetFlag("hide_indoors", 1);
    }
    if(currently_hiding && !needs_to_hide) {
      currently_hiding = false;
      self BotSetFlag("hide_indoors", 0);
    }
  }
}

try_place_global_badplace(killstreak_unique_name, killstreak_exists_func) {
  if(!isDefined(level.killstreak_global_bp_exists_for[self.team][killstreak_unique_name]))
    level.killstreak_global_bp_exists_for[self.team][killstreak_unique_name] = false;

  if(!level.killstreak_global_bp_exists_for[self.team][killstreak_unique_name]) {
    level.killstreak_global_bp_exists_for[self.team][killstreak_unique_name] = true;
    level thread monitor_enemy_dangerous_killstreak(self.team, killstreak_unique_name, killstreak_exists_func);
  }
}

monitor_enemy_dangerous_killstreak(my_team, killstreak_unique_name, killstreak_exists_func) {
  Assert(SCR_CONST_GLOBAL_BP_DURATION_S > (SCR_CONST_GLOBAL_BP_TIME_BETWEEN_PLACING_MS / 1000));
  wait_time = (SCR_CONST_GLOBAL_BP_DURATION_S - (SCR_CONST_GLOBAL_BP_TIME_BETWEEN_PLACING_MS / 1000)) * 0.5;
  while([[killstreak_exists_func]](my_team)) {
    if(GetTime() > level.last_global_badplace_time + SCR_CONST_GLOBAL_BP_TIME_BETWEEN_PLACING_MS) {
      BadPlace_Global("", SCR_CONST_GLOBAL_BP_DURATION_S, my_team, "only_sky");
      level.last_global_badplace_time = GetTime();
    }

    wait(wait_time);
  }

  level.killstreak_global_bp_exists_for[my_team][killstreak_unique_name] = false;
}

enemy_mortar_strike_exists(my_team) {
  if(isDefined(level.air_raid_active) && level.air_raid_active) {
    if(my_team != level.air_raid_team_called)
      return true;
  }

  return false;
}

enemy_switchblade_exists(my_team) {
  if(isDefined(level.remoteMissileInProgress)) {
    foreach(rocket in level.rockets) {
      if(isDefined(rocket.type) && rocket.type == "remote" && rocket.team != my_team)
        return true;
    }
  }

  return false;
}

enemy_odin_assault_exists(my_team) {
  foreach(player in level.players) {
    if(!level.teamBased || (isDefined(player.team) && my_team != player.team)) {
      if(isDefined(player.odin) && player.odin.odinType == "odin_assault" && GetTime() - player.odin.birthtime > 3000)
        return true;
    }
  }

  return false;
}

get_enemy_vanguard() {
  foreach(player in level.players) {
    if(!level.teamBased || (isDefined(player.team) && self.team != player.team)) {
      if(isDefined(player.remoteUAV) && player.remoteUAV.helitype == "remote_uav")
        return player.remoteUAV;
    }
  }

  return undefined;
}

isKillstreakBlockedForBots(ksName) {
  return (isDefined(level.botBlockedKillstreaks) && isDefined(level.botBlockedKillstreaks[ksName]) && level.botBlockedKillstreaks[ksName]);
}

blockKillstreakForBots(ksName) {
  level.botBlockedKillstreaks[ksName] = true;
}