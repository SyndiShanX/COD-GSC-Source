/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\friendlyfire.gsc
***********************************************/

#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\player_death;
#using scripts\sp\utility;
#namespace friendlyfire;

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
  setdvarifuninitialized(@ "hash_55eae984217fc9b6", "0");
  setdvarifuninitialized(@ "hash_d8275bff94773942", "0");
  setdvarifuninitialized(@ "hash_3cb172760816c3bb", "-1");
  scripts\engine\utility::flag_init("friendly_fire_warning");
  thread debug_friendlyfire();
  thread participation_point_flattenovertime();
}

function debug_friendlyfire() {
  setdvarifuninitialized(@ "debug_friendlyfire", "<dev string:x1c>");
  x = 0;
  y = 72;
  friendly_fire = newhudelem();
  friendly_fire.x = x;
  friendly_fire.y = y - 15;
  friendly_fire.alignx = "<dev string:x1e>";
  friendly_fire.aligny = "<dev string:x23>";
  friendly_fire.font = "<dev string:x27>";
  friendly_fire.fontscale = 1;
  friendly_fire.alpha = 0;
  civcount = newhudelem();
  civcount.x = x + 95;
  civcount.y = y;
  civcount.alignx = "<dev string:x1e>";
  civcount.aligny = "<dev string:x23>";
  civcount.font = "<dev string:x27>";
  civcount.fontscale = 1;
  civcount.alpha = 0;
  civilians = newhudelem();
  civilians.x = x;
  civilians.y = y;
  civilians.alignx = "<dev string:x1e>";
  civilians.aligny = "<dev string:x23>";
  civilians.font = "<dev string:x27>";
  civilians.fontscale = 1;
  civilians.alpha = 0;
  civilians.showtext = 0;

  for(;;) {
    if(getDvar(@ "debug_friendlyfire") == "<dev string:x30>") {
      if(!civilians.showtext) {
        civilians.showtext = 1;
        civilians settext("<dev string:x32>");
      }

      civcount.alpha = 1;
      civilians.alpha = 1;
      friendly_fire.alpha = 1;
    } else {
      civcount.alpha = 0;
      civilians.alpha = 0;
      friendly_fire.alpha = 0;
    }

    civcount setvalue(level.friendlyfire["<dev string:x46>"]);
    friendly_fire setvalue(level.player.participation);
    wait 0.25;
  }
}

function apply_friendly_fire_damage_modifier(value) {
  assert(isDefined(value));
  level.friendlyfire_damage_modifier = value;
}

function remove_friendly_fire_damage_modifier(value) {
  level.friendlyfire_damage_modifier = undefined;
}

function friendly_fire_think(entity) {
  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(entity.team)) {
    entity.team = "allies";
  }

  level endon("mission failed");
  level thread notifydamage(entity);
  level thread notifydamagenotdone(entity);
  level thread notifydeath(entity);

  entity thread function_a54d84c849bd008b();

  for(;;) {
    if(!isDefined(entity)) {
      return;
    }

    if(entity.health <= 0) {
      return;
    }

    damage = undefined;
    attacker = undefined;
    direction = undefined;
    point = undefined;
    method = undefined;
    weaponname = undefined;
    var_d23f02852fed23f = undefined;
    entity waittill("friendlyfire_notify", damage, attacker, direction, point, method, objweapon);

    if(!isDefined(entity)) {
      return;
    }

    if(istrue(level.skip_friendly_fire_check) || istrue(entity.skip_friendly_fire_check)) {
      continue;
    }

    if(!isDefined(attacker)) {
      continue;
    }

    if(isDefined(level.friendlyfire_damage_modifier)) {
      damage *= level.friendlyfire_damage_modifier;
      damage = int(damage);
    }

    var_54c4c82bfa9fee40 = 0;

    if(!isDefined(objweapon)) {
      objweapon = entity.damageweapon;
    }

    if(isPlayer(attacker)) {
      var_54c4c82bfa9fee40 = 1;

      if(isDefined(objweapon) && isnullweapon(objweapon)) {
        var_54c4c82bfa9fee40 = 0;
      }

      if(attacker isusingturret()) {
        var_54c4c82bfa9fee40 = 1;
      }

      if(isDefined(var_d23f02852fed23f)) {
        var_54c4c82bfa9fee40 = 1;
      }
    } else if(isDefined(attacker.code_classname) && attacker.code_classname == "script_vehicle") {
      owner = attacker getvehicleowner();

      if(isDefined(owner) && isPlayer(owner)) {
        attacker = owner;
        var_54c4c82bfa9fee40 = 1;
      }
    }

    if(!var_54c4c82bfa9fee40) {
      continue;
    }

    killed = damage == -1;
    iscivilian = entity iscivilian();
    civiliankilled = iscivilian && killed;

    if(getDvar(@ "hash_d8275bff94773942") == "1" && iscivilian) {
      continue;
    }

    if(getDvar(@ "debug_friendlyfire") == "<dev string:x30>") {
      if(iscivilian) {
        print3d(entity.origin + (0, 0, 50), entity.health, (1, 0, 0), 1, 0.5, 50);
      }
    }

    if(civiliankilled) {
      level.friendlyfire["civilians_killed"] = level.friendlyfire["civilians_killed"] + 1;
    }

    if(!isDefined(entity.team)) {
      continue;
    }

    same_team = entity isally();

    if(!same_team && !civiliankilled) {
      if(killed) {
        level.player.participation += level.friendlyfire["enemy_kill_points"];
        participation_point_cap();
        return;
      }

      continue;
    }

    if(!iscivilian && !killed) {
      function_216c67ab6749137a(entity, undefined, "friendly_fire");
    }

    if(istrue(level.no_friendly_fire_fail) || istrue(entity.no_friendly_fire_fail)) {
      continue;
    }

    if(isDefined(level.friendly_fire_skip_function) && [[level.friendly_fire_skip_function]]()) {
      continue;
    }

    if(isDefined(method) && istrue(level.no_friendly_fire_splash_damage)) {
      if(method == "MOD_PROJECTILE_SPLASH") {
        continue;
      }

      if(isexplosivedamagemod(method)) {
        continue;
      }
    }

    if(isDefined(objweapon)) {
      basename = objweapon.basename;

      if(basename == "claymore") {
        continue;
      }

      if(basename == "flash") {
        continue;
      }

      if(basename == "semtex" && isDefined(entity.semtexstuckto)) {
        damage = 9999;
      }

      if(basename == "throwingknife") {
        damage = 9999;
      }

      if(basename == "molotov") {
        damage = 9999;
      }
    }

    if(killed) {
      var_55d426dd45a49e09 = level.friendlyfire["strict_ff"];

      if(isDefined(self.strict_ff)) {
        var_55d426dd45a49e09 = self.strict_ff;
      }

      var_c9999b7f48063a7b = getdvarint(@ "hash_3cb172760816c3bb", -1);

      if(var_c9999b7f48063a7b > -1) {
        var_55d426dd45a49e09 = var_c9999b7f48063a7b;
      }

      if(var_55d426dd45a49e09 && !attacker enemy_is_visible()) {
        level.player.participation = level.friendlyfire["min_participation"];
      } else if(isDefined(entity.friend_kill_points)) {
        level.player.participation += entity.friend_kill_points;
      } else {
        waittillframeend();
        penalty = attacker get_adjusted_friendly_kill_points(level.friendlyfire["friend_kill_points"], method);
        level.player.participation += penalty;

        if(getdvarint(@ "debug_friendlyfire")) {
          thread function_21e5e1027cea1a1d(penalty, entity.origin + (0, 0, 60), (1, 0, 0.1));
        }
      }
    } else {
      level.player.participation -= damage;
    }

    participation_point_cap();

    if(check_grenade(entity, method) && savecommit_aftergrenade()) {
      if(killed) {
        return;
      } else {
        continue;
      }
    }

    if(isDefined(level.friendly_fire_fail_check)) {
      [[level.friendly_fire_fail_check]](entity, damage, attacker, direction, point, method, weaponname);
      continue;
    }

    friendly_fire_checkpoints(civiliankilled);
  }
}

function get_adjusted_friendly_kill_points(penaltypoints, method) {
  if(isDefined(method) && isexplosivedamagemod(method)) {
    return penaltypoints;
  }

  if(!self.lastenemykilltime && !self.lastenemydmgtime) {
    return penaltypoints;
  }

  mostrecent = get_most_recent_dmg_or_death_time();
  var_9a3457c4a803b506 = gettime() - mostrecent;

  if(var_9a3457c4a803b506 > 1500) {
    return penaltypoints;
  }

  factor = 1 - math::normalize_value(0, 1500, var_9a3457c4a803b506);
  var_a1aabf92e937bff0 = math::factor_value(penaltypoints, 0, factor);
  var_a1aabf92e937bff0 = int(var_a1aabf92e937bff0);
  return var_a1aabf92e937bff0;
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

function function_21e5e1027cea1a1d(value, origin, color) {
  frames = 40;
  zdiff = 1;
  alpha = 1;

  if(isDefined(color)) {
    txtcolor = color;
  } else {
    txtcolor = (1, 1, 1);
  }

  size = 0.8;
  alphaminus = 1 / frames;
  toggle = 1;

  for(i = 0; i < frames; i++) {
    print3d(origin, value, txtcolor, alpha, size, 1, 1);
    alpha -= alphaminus;

    if(toggle) {
      origin += (0, 0, zdiff);
      toggle = 0;
    } else {
      toggle = 1;
    }

    waitframe();
  }
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

function function_a54d84c849bd008b() {
  self endon("<dev string:x57>");

  while(true) {
    if(getDvar(@ "debug_friendlyfire") == "<dev string:x30>") {
      text = undefined;
      color = undefined;
      scale = undefined;
      alpha = undefined;

      if(!istrue(level.skip_friendly_fire_check) && !istrue(self.skip_friendly_fire_check)) {
        if(iscivilian()) {
          text = "<dev string:x5d>";
          color = (1, 0, 0);
          scale = 0.5;

          if(getDvar(@ "hash_d8275bff94773942") == "<dev string:x30>") {
            alpha = 0;
          } else {
            alpha = 1;
          }
        } else if(isally()) {
          text = "<dev string:x66>";
          color = (0, 1, 0);
          scale = 0.6;
          alpha = 1;
        }

        if(isDefined(text)) {
          print3d(self.origin + (0, 0, 40), text, color, alpha, scale, 1);
        }
      }
    }

    waitframe();
  }
}

function friendly_fire_checkpoints(civiliankilled) {
  if(isDefined(level.failonfriendlyfire) && level.failonfriendlyfire) {
    level thread missionfail(civiliankilled);
    return;
  }

  var_a5c198fa345b5cac = level.friendlyfiredisabledfordestructible;

  if(isDefined(level.friendlyfire_destructible_attacker) && civiliankilled) {
    var_a5c198fa345b5cac = 0;
  }

  if(var_a5c198fa345b5cac) {
    return;
  }

  if(level.friendlyfiredisabled == 1) {
    return;
  }

  if(level.player.participation <= level.friendlyfire["min_participation"]) {
    level thread missionfail(civiliankilled);
  }
}

function check_grenade(entity, method) {
  if(!isDefined(entity)) {
    return 0;
  }

  wasgrenade = 0;
  objweapon = entity.damageweapon;

  if(isDefined(objweapon) && isnullweapon(objweapon)) {
    wasgrenade = 1;
  }

  if(isDefined(method) && method == "MOD_GRENADE_SPLASH") {
    wasgrenade = 1;
  }

  if(isDefined(objweapon) && objweapon.basename == "throwingknife") {
    wasgrenade = 1;
  }

  if(isDefined(objweapon) && objweapon.basename == "molotov") {
    wasgrenade = 1;
  }

  return wasgrenade;
}

function savecommit_aftergrenade() {
  currenttime = gettime();

  if(currenttime < 4500) {
    println("<dev string:x6b>");
    return true;
  } else if(currenttime - level.autosave.lastautosavetime < 4500) {
    println("<dev string:xd4>");
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

function missionfail(civiliankilled) {
  if(!isDefined(civiliankilled)) {
    civiliankilled = 0;
  }

  if(getDvar(@ "hash_55eae984217fc9b6") == "1") {
    return;
  }

  if(getdvarint(@ "exec_review") > 0) {
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
  setsaveddvar(@ "hud_missionfailed", 1);
  setomnvar("ui_hide_weapon_info", 1);
  setsaveddvar(@ "hash_4e8225c28298a6ad", 0);
  setsaveddvar(@ "hash_9d7a2fa032e463d5", 1);

  if(isDefined(level.player.failingmission)) {
    return;
  }

  if(civiliankilled) {
    if(isDefined(level.var_eed0b997e799ad2e)) {
      scripts\sp\player_death::set_custom_death_quote(level.var_eed0b997e799ad2e);
    } else {
      scripts\sp\player_death::set_custom_death_quote(499);
    }
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
  clear_force_color();
  val::set("ai_turn_on_player", "ignoresuppression", 1);
  clearthreatbias("axis", "allies");

  while(true) {
    self.team = "axis";
    self.favoritenemy = level.player;
    wait 0.05;
  }
}

function notifydamage(entity) {
  entity endon("death");

  for(;;) {
    entity waittill("damage", damage, attacker, direction, point, method, unused, unused, unused, unused, objweapon);
    entity notify("friendlyfire_notify", damage, attacker, direction, point, method, objweapon);
  }
}

function notifydamagenotdone(entity) {
  entity waittill("damage_notdone", damage, attacker, unused, unused, method);
  entity notify("friendlyfire_notify", -1, attacker, undefined, undefined, method);
}

function notifydeath(entity) {
  entity waittill("death", attacker, method, objweapon);
  entity notify("friendlyfire_notify", -1, attacker, undefined, undefined, method, objweapon);
}

function detectfriendlyfireonentity(entity) {}

function reset_friendlyfire_participation() {
  level.player.participation = 0;
}

function enemy_is_visible() {
  mostrecent = get_most_recent_dmg_or_death_time();
  var_9a3457c4a803b506 = gettime() - mostrecent;

  if(var_9a3457c4a803b506 < 600) {
    return true;
  }

  cos30 = 0.866025;

  foreach(enemy in getaiarray("axis")) {
    enemyvisible = math::within_fov_2d(level.player.origin, level.player.angles, enemy.origin, cos30);
    enemyvisible &= enemy seerecently(level.player, 2);

    if(enemyvisible) {
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

function set_strict_ff(bool) {
  assertex(isDefined(self), "Cannot set strict ff as ent is undefined");
  self.strict_ff = bool;
}