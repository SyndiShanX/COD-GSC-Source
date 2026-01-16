/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_friendlyfire.gsc
********************************/

main() {
  level.friendlyfire["min_participation"] = -200;
  level.friendlyfire["max_participation"] = 1000;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.friendlyfire["friend_kill_points"] = -650;
  level.friendlyfire["point_loss_interval"] = 1.25;
  level.player.participation = 0;
  level.friendlyfiredisabled = 0;
  level.friendlyfiredisabledfordestructible = 0;
  setdvarifuninitialized("friendlyfire_dev_disabled", "0");
  common_scripts\utility::flag_init("friendly_fire_warning");
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
  if(!isdefined(var_0)) {
    return;
  }
  if(!isdefined(var_0.team))
    var_0.team = "allies";

  if(isdefined(level.no_friendly_fire_penalty)) {
    return;
  }
  level endon("mission failed");
  level thread notifydamage(var_0);
  level thread notifydamagenotdone(var_0);
  level thread notifydeath(var_0);

  for (;;) {
    if(!isdefined(var_0)) {
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

    if(!isdefined(var_0)) {
      return;
    }
    if(!isdefined(var_2)) {
      continue;
    }
    if(isdefined(level.friendlyfire_damage_modifier)) {
      var_1 = var_1 * level.friendlyfire_damage_modifier;
      var_1 = int(var_1);
    }

    var_8 = 0;

    if(!isdefined(var_6))
      var_6 = var_0.damageweapon;

    if(isdefined(level.friendlyfire_destructible_attacker)) {
      if(isdefined(var_2.damageowner)) {
        var_7 = 1;
        var_2 = var_2.damageowner;
      }
    }

    if(isdefined(level.friendlyfire_enable_attacker_owner_check)) {
      if(isdefined(var_2) && isdefined(var_2.owner) && var_2.owner == level.player)
        var_8 = 1;
    }

    if(isplayer(var_2)) {
      var_8 = 1;

      if(isdefined(var_6) && var_6 == "none")
        var_8 = 0;

      if(var_2 isusingturret())
        var_8 = 1;

      if(isdefined(var_7))
        var_8 = 1;
    } else if(isdefined(var_2.code_classname) && var_2.code_classname == "script_vehicle") {
      var_9 = var_2 getvehicleowner();

      if(isdefined(var_9) && isplayer(var_9))
        var_8 = 1;
    }

    if(!var_8) {
      continue;
    }
    if(!isdefined(var_0.team)) {
      continue;
    }
    var_10 = var_0.team == level.player.team;
    var_11 = undefined;

    if(isdefined(var_0.type) && var_0.type == "civilian")
      var_11 = 1;
    else
      var_11 = issubstr(var_0.classname, "civilian");

    var_12 = var_1 == -1;

    if(!var_10 && !var_11) {
      if(var_12) {
        level.player.participation = level.player.participation + level.friendlyfire["enemy_kill_points"];
        participation_point_cap();
        return;
      }
    } else {
      if(isdefined(var_0.no_friendly_fire_penalty)) {
        continue;
      }
      if(var_5 == "MOD_PROJECTILE_SPLASH" && isdefined(level.no_friendly_fire_splash_damage)) {
        continue;
      }
      if(isdefined(var_6) && var_6 == "claymore") {
        if(isdefined(level.claymoreexplodethisframe_byplayer) && level.claymoreexplodethisframe_byplayer) {

        } else
          continue;
      }

      if(var_12) {
        if(isdefined(var_0.friend_kill_points))
          level.player.participation = level.player.participation + var_0.friend_kill_points;
        else
          level.player.participation = level.player.participation + level.friendlyfire["friend_kill_points"];
      } else
        level.player.participation = level.player.participation - var_1;

      participation_point_cap();

      if(check_grenade(var_0, var_5) && savecommit_aftergrenade()) {
        if(var_12)
          return;
        else
          continue;
      }

      if(isdefined(level.friendly_fire_fail_check)) {
        [
          [level.friendly_fire_fail_check]
        ](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
        continue;
      }

      friendly_fire_checkpoints(var_11);
    }
  }
}

friendly_fire_checkpoints(var_0) {
  if(isdefined(level.failonfriendlyfire) && level.failonfriendlyfire) {
    level thread missionfail(var_0);
    return;
  }

  var_1 = level.friendlyfiredisabledfordestructible;

  if(isdefined(level.friendlyfire_destructible_attacker) && var_0)
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
  if(!isdefined(var_0))
    return 0;

  var_2 = 0;

  if(isdefined(var_0.damageweapon) && var_0.damageweapon == "none")
    var_2 = 1;

  if(isdefined(var_1) && var_1 == "MOD_GRENADE_SPLASH")
    var_2 = 1;

  return var_2;
}

savecommit_aftergrenade() {
  var_0 = gettime();

  if(var_0 < 4500)
    return 1;
  else if(var_0 - level.lastautosavetime < 4500)
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

  for (;;) {
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
  if(!isdefined(var_0))
    var_0 = 0;

  if(getdvar("friendlyfire_dev_disabled") == "1") {
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
  setsaveddvar("hud_missionFailed", 1);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);

  if(isdefined(level.player.failingmission)) {
    return;
  }
  soundscripts\_snd::snd_message("friendly_fire_mission_failed");

  if(var_0)
    maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_CIVILIAN_KILLED");
  else if(isdefined(level.custom_friendly_fire_message))
    maps\_player_death::set_deadquote(level.custom_friendly_fire_message);
  else if(level.campaign == "british")
    maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");
  else if(level.campaign == "russian")
    maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
  else
    maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");

  if(isdefined(level.custom_friendly_fire_shader))
    thread maps\_player_death::set_death_icon(level.custom_friendly_fire_shader, 64, 64, 0);

  reconspatialevent(level.player.origin, "script_friendlyfire: civilian %d", var_0);
  maps\_utility::missionfailedwrapper();
}

notifydamage(var_0) {
  level endon("mission failed");
  var_0 endon("death");

  for (;;) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0 notify("friendlyfire_notify", var_1, var_2, var_3, var_4, var_5, var_10);
  }
}

notifydamagenotdone(var_0) {
  level endon("mission failed");
  var_0 waittill("damage_notdone", var_1, var_2, var_3, var_4, var_5);
  var_0 notify("friendlyfire_notify", -1, var_2, undefined, undefined, var_5);
}

notifydeath(var_0) {
  level endon("mission failed");
  var_0 waittill("death", var_1, var_2, var_3);
  var_0 notify("friendlyfire_notify", -1, var_1, undefined, undefined, var_2, var_3);
}

detectfriendlyfireonentity(var_0) {}