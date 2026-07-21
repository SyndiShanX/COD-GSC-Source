/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\friendlyfire.gsc
***********************************************/

main() {
  level.friendlyfire["min_participation"] = -200;
  level.friendlyfire["max_participation"] = 1000;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.friendlyfire["friend_kill_points"] = -650;
  level.friendlyfire["point_loss_interval"] = 1.25;
  level.friendlyfire["civilians_killed"] = 0;
  level.friendlyfire["strict_ff"] = 0;
  level.player.participation = 0;
  level.friendlyfiredisabled = 0;
  level.friendlyfiredisabledfordestructible = 0;
  setdvarifuninitialized("friendlyfire_dev_disabled", "0");
  setdvarifuninitialized("scr_disable_civ_kills", "0");
  setdvarifuninitialized("scr_strict_ff", "-1");
  scripts\engine\utility::flag_init("friendly_fire_warning");
  thread debug_friendlyfire();
  thread participation_point_flattenovertime();
}

debug_friendlyfire() {}

apply_friendly_fire_damage_modifier(var_0) {
  level.friendlyfire_damage_modifier = var_0;
}

remove_friendly_fire_damage_modifier(var_0) {
  level.friendlyfire_damage_modifier = undefined;
}

friendly_fire_think(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.team))
    var_0.team = "allies";

  level endon("mission failed");
  level thread notifydamage(var_0);
  level thread notifydamagenotdone(var_0);
  level thread notifydeath(var_0);

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    if(var_0.health <= 0) {
      return;
    }
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_0 waittill("friendlyfire_notify", var_1, var_2, var_3, var_4, var_5, var_6);

    if(!isDefined(var_0)) {
      return;
    }
    if(istrue(level.skip_friendly_fire_check) || istrue(var_0.skip_friendly_fire_check)) {
      continue;
    }
    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(level.friendlyfire_damage_modifier)) {
      var_1 = var_1 * level.friendlyfire_damage_modifier;
      var_1 = int(var_1);
    }

    var_8 = 0;

    if(!isDefined(var_6)) {
      var_9 = var_0.damageweapon;

      if(isDefined(var_9))
        var_6 = createheadicon(var_9);
    }

    if(isDefined(level.friendlyfire_destructible_attacker)) {
      if(isDefined(var_2.damageowner)) {
        var_7 = 1;
        var_2 = var_2.damageowner;
      }
    }

    if(isDefined(level.friendlyfire_enable_attacker_owner_check)) {
      if(isDefined(var_2) && isDefined(var_2.owner) && var_2.owner == level.player)
        var_8 = 1;
    }

    if(isPlayer(var_2)) {
      var_8 = 1;

      if(isDefined(var_6) && var_6 == "none")
        var_8 = 0;

      if(var_2 isusingturret())
        var_8 = 1;

      if(isDefined(var_7))
        var_8 = 1;
    } else if(isDefined(var_2.code_classname) && var_2.code_classname == "script_vehicle") {
      var_10 = var_2 getvehicleowner();

      if(isDefined(var_10) && isPlayer(var_10))
        var_8 = 1;
    }

    if(!var_8) {
      continue;
    }
    var_11 = var_1 == -1;
    var_12 = var_0 iscivilian();
    var_13 = var_12 && var_11;

    if(getDvar("scr_disable_civ_kills") == "1" && var_12) {
      continue;
    }
    if(var_13)
      level.friendlyfire["civilians_killed"] = level.friendlyfire["civilians_killed"] + 1;

    if(!isDefined(var_0.team)) {
      continue;
    }
    var_14 = var_0 isally();

    if(!var_14 && !var_13) {
      if(var_11) {
        level.player.participation = level.player.participation + level.friendlyfire["enemy_kill_points"];
        participation_point_cap();
        return;
      }
    } else {
      if(istrue(level.no_friendly_fire_fail) || istrue(var_0.no_friendly_fire_fail)) {
        continue;
      }
      if(isDefined(level.friendly_fire_skip_function) && [[level.friendly_fire_skip_function]]()) {
        continue;
      }
      if(isDefined(var_5) && var_5 == "MOD_PROJECTILE_SPLASH" && isDefined(level.no_friendly_fire_splash_damage)) {
        continue;
      }
      if(isDefined(var_5) && isexplosivedamagemod(var_5) && isDefined(level.no_friendly_fire_explosive_damage)) {
        continue;
      }
      if(isDefined(var_6) && (var_6 == "claymore" || var_6 == "iw8_projectile_hfoxtrot")) {
        continue;
      }
      if(isDefined(var_6) && var_6 == "semtex" && isDefined(var_0.semtexstuckto))
        var_1 = 9999;

      if(isDefined(var_6) && var_6 == "throwingknife")
        var_1 = 9999;

      if(isDefined(var_6) && var_6 == "molotov")
        var_1 = 9999;

      if(var_11) {
        var_15 = level.friendlyfire["strict_ff"];

        if(isDefined(self.strict_ff))
          var_15 = self.strict_ff;

        var_16 = getdvarint("scr_strict_ff", -1);

        if(var_16 > -1)
          var_15 = var_16;

        if(var_15 && !var_2 enemy_is_visible())
          level.player.participation = level.friendlyfire["min_participation"];
        else if(isDefined(var_0.friend_kill_points))
          level.player.participation = level.player.participation + var_0.friend_kill_points;
        else {
          waittillframeend;
          var_17 = var_2 get_adjusted_friendly_kill_points(level.friendlyfire["friend_kill_points"], var_5);
          level.player.participation = level.player.participation + var_17;
        }
      } else
        level.player.participation = level.player.participation - var_1;

      participation_point_cap();

      if(check_grenade(var_0, var_5) && savecommit_aftergrenade()) {
        if(var_11)
          return;
        else
          continue;
      }

      if(isDefined(level.friendly_fire_fail_check)) {
        [[level.friendly_fire_fail_check]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
        continue;
      }

      friendly_fire_checkpoints(var_13);
    }
  }
}

get_adjusted_friendly_kill_points(var_0, var_1) {
  if(isDefined(var_1) && isexplosivedamagemod(var_1))
    return var_0;

  if(!self.lastenemykilltime && !self.lastenemydmgtime)
    return var_0;

  var_2 = get_most_recent_dmg_or_death_time();
  var_3 = gettime() - var_2;

  if(var_3 > 1500)
    return var_0;

  var_4 = 1 - scripts\engine\math::normalize_value(0, 1500, var_3);
  var_5 = scripts\engine\math::factor_value(var_0, 0, var_4);
  var_5 = int(var_5);
  return var_5;
}

get_most_recent_dmg_or_death_time() {
  if(!self.lastenemykilltime)
    return self.lastenemydmgtime;

  if(!self.lastenemydmgtime)
    return self.lastenemykilltime;

  if(self.lastenemydmgtime >= self.lastenemykilltime)
    return self.lastenemydmgtime;
  else
    return self.lastenemykilltime;
}

iscivilian() {
  if(isDefined(self.setciviliankillcount))
    return self.setciviliankillcount;

  if(isDefined(self.unittype) && self.unittype == "civilian")
    return 1;
  else if(isDefined(self.asmname) && self.asmname == "civilian")
    return 1;
  else
    return 0;
}

isally() {
  if(self.team == level.player.team)
    return 1;
  else
    return 0;
}

friendly_fire_checkpoints(var_0) {
  if(isDefined(level.failonfriendlyfire) && level.failonfriendlyfire) {
    level thread missionfail(var_0);
    return;
  }

  var_1 = level.friendlyfiredisabledfordestructible;

  if(isDefined(level.friendlyfire_destructible_attacker) && var_0)
    var_1 = 0;

  if(var_1) {
    return;
  }
  if(level.friendlyfiredisabled == 1) {
    return;
  }
  if(level.player.participation <= level.friendlyfire["min_participation"])
    level thread missionfail(var_0);
}

check_grenade(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  var_2 = 0;
  var_3 = var_0.damageweapon;

  if(isDefined(var_3) && nullweapon(var_3))
    var_2 = 1;

  if(isDefined(var_1) && var_1 == "MOD_GRENADE_SPLASH")
    var_2 = 1;

  if(isDefined(var_3) && var_3.basename == "throwingknife")
    var_2 = 1;

  if(isDefined(var_3) && var_3.basename == "molotov")
    var_2 = 1;

  return var_2;
}

savecommit_aftergrenade() {
  var_0 = gettime();

  if(var_0 < 4500)
    return 1;
  else if(var_0 - level.autosave.lastautosavetime < 4500)
    return 1;

  return 0;
}

participation_point_cap() {
  if(level.player.participation > level.friendlyfire["max_participation"])
    level.player.participation = level.friendlyfire["max_participation"];

  if(level.player.participation < level.friendlyfire["min_participation"])
    level.player.participation = level.friendlyfire["min_participation"];
}

participation_point_flattenovertime() {
  level endon("mission failed");

  for(;;) {
    if(level.player.participation > 0)
      level.player.participation--;
    else if(level.player.participation < 0)
      level.player.participation++;

    wait(level.friendlyfire["point_loss_interval"]);
  }
}

turnbackon() {
  level.friendlyfiredisabled = 0;
}

turnoff() {
  level.friendlyfiredisabled = 1;
}

missionfail(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(getDvar("friendlyfire_dev_disabled") == "1") {
    return;
  }
  if(getdvarint("exec_review") > 0) {
    return;
  }
  level.player endon("death");

  if(!isalive(level.player)) {
    return;
  }
  level endon("mine death");
  level notify("mission failed");
  level notify("friendlyfire_mission_fail");
  waittillframeend;
  setsaveddvar("LPROPSMNKS", 1);
  setomnvar("ui_hide_weapon_info", 1);
  setsaveddvar("MPNNTKMQTS", 0);
  setsaveddvar("MNRKKQLQPQ", 1);

  if(isDefined(level.player.failingmission)) {
    return;
  }
  if(var_0)
    scripts\sp\player_death::set_custom_death_quote(30);
  else if(isDefined(level.custom_friendly_fire_message))
    scripts\sp\player_death::set_custom_death_quote(level.custom_friendly_fire_message);
  else
    scripts\sp\player_death::set_custom_death_quote(12);

  if(isDefined(level.custom_friendly_fire_shader))
    thread scripts\sp\player_death::set_death_icon(level.custom_friendly_fire_shader, 64, 64, 0);

  scripts\sp\utility::missionfailedwrapper();
}

ally_turn_on_player() {
  level.player endon("death");
  self endon("death");
  self stopanimScripted();
  scripts\engine\sp\utility::clear_force_color();
  scripts\engine\sp\utility::set_ignoresuppression(1);
  scripts\engine\sp\utility::clearthreatbias("axis", "allies");

  for(;;) {
    self.team = "axis";
    self.favoritenemy = level.player;
    wait 0.05;
  }
}

notifydamage(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_6, var_6, var_6, var_7);
    var_8 = undefined;

    if(isDefined(var_7))
      var_8 = createheadicon(var_7);

    var_0 notify("friendlyfire_notify", var_1, var_2, var_3, var_4, var_5, var_8);
  }
}

notifydamagenotdone(var_0) {
  var_0 waittill("damage_notdone", var_1, var_2, var_3, var_4);
  var_0 notify("friendlyfire_notify", -1, var_2, undefined, undefined, var_4);
}

notifydeath(var_0) {
  var_0 waittill("death", var_1, var_2, var_3);
  var_4 = undefined;

  if(isDefined(var_3))
    var_4 = createheadicon(var_3);

  var_0 notify("friendlyfire_notify", -1, var_1, undefined, undefined, var_2, var_4);
}

detectfriendlyfireonentity(var_0) {}

reset_friendlyfire_participation() {
  level.player.participation = 0;
}

enemy_is_visible() {
  var_0 = get_most_recent_dmg_or_death_time();
  var_1 = gettime() - var_0;

  if(var_1 < 600)
    return 1;

  var_2 = 0.866025;

  foreach(var_4 in getaiarray("axis")) {
    var_5 = scripts\engine\math::within_fov_2d(level.player.origin, level.player.angles, var_4.origin, var_2);
    var_5 = var_5 &var_4 seerecently(level.player, 2.0);

    if(var_5)
      return 1;
  }

  return 0;
}

strict_ff_enable() {
  level.friendlyfire["strict_ff"] = 1;
}

strict_ff_disable() {
  level.friendlyfire["strict_ff"] = 0;
}

set_strict_ff(var_0) {
  self.strict_ff = var_0;
}