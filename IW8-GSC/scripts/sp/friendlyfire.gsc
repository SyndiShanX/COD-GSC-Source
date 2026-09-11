/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\friendlyfire.gsc
***********************************************/

function main() {
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

function debug_friendlyfire() {}

function apply_friendly_fire_damage_modifier(var0) {
  level.friendlyfire_damage_modifier = var0;
}

function remove_friendly_fire_damage_modifier(var0) {
  level.friendlyfire_damage_modifier = undefined;
}

function friendly_fire_think(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.team)) {
    var0.team = "allies";
  }

  level endon("mission failed");
  thread notifydamage(level);
  thread notifydamagenotdone(level);
  thread notifydeath(level);

  for(;;) {
    if(!isDefined(var0)) {
      return;
    }

    if(var0.health <= 0) {
      return;
    }

    var1 = undefined;
    var2 = undefined;
    var3 = undefined;
    var4 = undefined;
    var5 = undefined;
    var6 = undefined;
    var7 = undefined;
    var0 waittill("friendlyfire_notify", var1, var2, var3, var4, var5, var6);

    if(!isDefined(var0)) {
      return;
    }

    if(isDefined(level.friendlyfire_damage_modifier)) {
      var1 *= level.friendlyfire_damage_modifier;
      var1 = int(var1);
    }

    var8 = 0;

    if(!isDefined(var6)) {
      var9 = var0.damageweapon;

      if(isDefined(var9)) {
        var6 = createheadicon(var9);
      }
    }

    if(isDefined(level.friendlyfire_destructible_attacker)) {
      if(isDefined(var2.damageowner)) {
        var7 = 1;
        var2 = var2.damageowner;
      }
    }

    if(isDefined(level.friendlyfire_enable_attacker_owner_check)) {
      if(isDefined(var2) && isDefined(var2.owner) && var2.owner == level.player) {
        var8 = 1;
      }
    }

    if(isPlayer(var2)) {
      var8 = 1;

      if(isDefined(var6) && var6 == "none") {
        var8 = 0;
      }

      if(var2 isusingturret()) {
        var8 = 1;
      }

      if(isDefined(var7)) {
        var8 = 1;
      }
    } else if(isDefined(var2.code_classname) && var2.code_classname == "script_vehicle") {
      var10 = var2 getvehicleowner();

      if(isDefined(var10) && isPlayer(var10)) {
        var8 = 1;
      }
    }

    var11 = var1 == -1;
    var12 = iscivilian(var0);
    var13 = var12 && var11;

    if(getDvar("scr_disable_civ_kills") == "1" && var12) {
      continue;
    }

    if(var13) {
      level.friendlyfire["civilians_killed"] = level.friendlyfire["civilians_killed"] + 1;
    }

    if(!isDefined(var0.team)) {
      continue;
    }

    var14 = isally(var0);

    if(!var14 && !var13) {
      if(var11) {
        level.player.participation += level.friendlyfire["enemy_kill_points"];
        participation_point_cap();
        return;
      }

      continue;
    }

    if(istrue(level.no_friendly_fire_fail) || istrue(var0.no_friendly_fire_fail)) {
      continue;
    }

    if(isDefined(level.friendly_fire_skip_function) && [[level.friendly_fire_skip_function]]()) {
      continue;
    }

    if(isDefined(var5) && var5 == "MOD_PROJECTILE_SPLASH" && isDefined(level.no_friendly_fire_splash_damage)) {
      continue;
    }

    if(isDefined(var5) && isexplosivedamagemod(var5) && isDefined(level.no_friendly_fire_explosive_damage)) {
      continue;
    }

    if(isDefined(var6) && (var6 == "claymore" || var6 == "iw8_projectile_hfoxtrot")) {
      continue;
    }

    if(isDefined(var6) && var6 == "semtex" && isDefined(var0.semtexstuckto)) {
      var1 = 9999;
    }

    if(isDefined(var6) && var6 == "throwingknife") {
      var1 = 9999;
    }

    if(isDefined(var6) && var6 == "molotov") {
      var1 = 9999;
    }

    if(var11) {
      var15 = level.friendlyfire["strict_ff"];

      if(isDefined(self.strict_ff)) {
        var15 = self.strict_ff;
      }

      var16 = getdvarint("scr_strict_ff", -1);

      if(var16 > -1) {
        var15 = var16;
      }

      if(var15 && !enemy_is_visible(var2)) {
        level.player.participation = level.friendlyfire["min_participation"];
      } else if(isDefined(var0.friend_kill_points)) {
        level.player.participation += var0.friend_kill_points;
      } else {
        waittillframeend();
        var17 = get_adjusted_friendly_kill_points(var2, level.friendlyfire["friend_kill_points"], var5);
        level.player.participation += var17;
      }
    } else {
      level.player.participation -= var1;
    }

    participation_point_cap();

    if(check_grenade(var0, var5) && savecommit_aftergrenade()) {
      if(var11) {
        return;
      } else {
        continue;
      }
    }

    if(isDefined(level.friendly_fire_fail_check)) {
      [[level.friendly_fire_fail_check]](var0, var1, var2, var3, var4, var5, var6);
      continue;
    }

    friendly_fire_checkpoints(var13);
    LOC_0000047c:
  }
}

function get_adjusted_friendly_kill_points(var0, var1) {
  if(isDefined(var1) && isexplosivedamagemod(var1)) {
    return var0;
  }

  if(!self.lastenemykilltime && !self.lastenemydmgtime) {
    return var0;
  }

  var2 = get_most_recent_dmg_or_death_time();
  var3 = gettime() - var2;

  if(var3 > 1500) {
    return var0;
  }

  var4 = 1 - scripts\engine\math::normalize_value(0, 1500, var3);
  var5 = scripts\engine\math::factor_value(var0, 0, var4);
  var5 = int(var5);
  return var5;
}

function get_most_recent_dmg_or_death_time() {
  if(!self.lastenemykilltime) {
    return self.lastenemydmgtime;
  }

  if(!self.lastenemydmgtime) {
    return self.lastenemykilltime;
  }

  if(self.lastenemydmgtime >= self.lastenemykilltime) {
    return self.lastenemydmgtime;
  }

  return self.lastenemykilltime;
}

function iscivilian() {
  if(isDefined(self.setciviliankillcount)) {
    return self.setciviliankillcount;
  }

  if(isDefined(self.unittype) && self.unittype == "civilian") {
    return 1;
  }

  if(isDefined(self.asmname) && self.asmname == "civilian") {
    return 1;
  }

  return 0;
}

function isally() {
  if(self.team == level.player.team) {
    return 1;
  }

  return 0;
}

function friendly_fire_checkpoints(var0) {
  if(isDefined(level.failonfriendlyfire) && level.failonfriendlyfire) {
    thread missionfail(level);
    return;
  }

  var1 = level.friendlyfiredisabledfordestructible;

  if(isDefined(level.friendlyfire_destructible_attacker) && var0) {
    var1 = 0;
  }

  if(var1) {
    return;
  }

  if(level.friendlyfiredisabled == 1) {
    return;
  }

  if(level.player.participation <= level.friendlyfire["min_participation"]) {
    thread missionfail(level);
    return;
  }
}

function check_grenade(var0, var1) {
  if(!isDefined(var0)) {
    return 0;
  }

  var2 = 0;
  var3 = var0.damageweapon;

  if(isDefined(var3) && nullweapon(var3)) {
    var2 = 1;
  }

  if(isDefined(var1) && var1 == "MOD_GRENADE_SPLASH") {
    var2 = 1;
  }

  if(isDefined(var3) && var3.basename == "throwingknife") {
    var2 = 1;
  }

  if(isDefined(var3) && var3.basename == "molotov") {
    var2 = 1;
  }

  return var2;
}

function savecommit_aftergrenade() {
  var0 = gettime();

  if(var0 < 4500) {
    return true;
  } else if(var0 - level.autosave.lastautosavetime < 4500) {
    return true;
  }

  return false;
}

function participation_point_cap() {
  if(level.player.participation > level.friendlyfire["max_participation"]) {
    level.player.participation = level.friendlyfire["max_participation"];
  }

  if(level.player.participation < level.friendlyfire["min_participation"]) {
    level.player.participation = level.friendlyfire["min_participation"];
    return;
  }
}

function participation_point_flattenovertime() {
  level endon("mission failed");

  for(;;) {
    if(level.player.participation > 0) {
      level.player.participation--;
    } else if(level.player.participation < 0) {
      level.player.participation++;
    }

    wait level.friendlyfire["point_loss_interval"];
  }
}

function turnbackon() {
  level.friendlyfiredisabled = 0;
}

function turnoff() {
  level.friendlyfiredisabled = 1;
}

function missionfail(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

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
  waittillframeend();
  setsaveddvar("LPROPSMNKS", 1);
  setomnvar("ui_hide_weapon_info", 1);
  setsaveddvar("MPNNTKMQTS", 0);
  setsaveddvar("MNRKKQLQPQ", 1);

  if(isDefined(level.player.failingmission)) {
    return;
  }

  if(var0) {
    scripts\sp\player_death::set_custom_death_quote(30);
  } else if(isDefined(level.custom_friendly_fire_message)) {
    scripts\sp\player_death::set_custom_death_quote(level.custom_friendly_fire_message);
  } else {
    scripts\sp\player_death::set_custom_death_quote(12);
  }

  if(isDefined(level.custom_friendly_fire_shader)) {
    thread scripts\sp\player_death::set_death_icon(level.custom_friendly_fire_shader, 64, 64, 0);
  }

  scripts\sp\utility::missionfailedwrapper();
}

function ally_turn_on_player() {
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

function notifydamage(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var6, var6, var6, var7);
    var8 = undefined;

    if(isDefined(var7)) {
      var8 = createheadicon(var7);
    }

    var0 notify("friendlyfire_notify", var1, var2, var3, var4, var5, var8);
  }
}

function notifydamagenotdone(var0) {
  var0 waittill("damage_notdone", var1, var2, var3, var3, var4);
  var0 notify("friendlyfire_notify", -1, var2, undefined, undefined, var4);
}

function notifydeath(var0) {
  var0 waittill("death", var1, var2, var3);
  var4 = undefined;

  if(isDefined(var3)) {
    var4 = createheadicon(var3);
  }

  var0 notify("friendlyfire_notify", -1, var1, undefined, undefined, var2, var4);
}

function detectfriendlyfireonentity(var0) {}

function reset_friendlyfire_participation() {
  level.player.participation = 0;
}

function enemy_is_visible() {
  var0 = get_most_recent_dmg_or_death_time();
  var1 = gettime() - var0;

  if(var1 < 600) {
    return true;
  }

  var2 = 0.866025;

  foreach(var4 in getaiarray("axis")) {
    var5 = scripts\engine\math::within_fov_2d(level.player.origin, level.player.angles, var4.origin, var2);
    var5 &= var4 seerecently(level.player, 2);

    if(var5) {
      return true;
    }
  }

  return false;
}

function strict_ff_enable() {
  level.friendlyfire["strict_ff"] = 1;
}

function strict_ff_disable() {
  level.friendlyfire["strict_ff"] = 0;
}

function set_strict_ff(var0) {
  self.strict_ff = var0;
}