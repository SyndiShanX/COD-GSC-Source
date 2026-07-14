/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\friendlyfire.gsc
***************************************/

#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\player_death;
#using scripts\sp\utility;
#namespace friendlyfire;

function main() {
  level.friendlyfire["\x17PW\x82\x88\xcb\xc9\x11\x8cq\x90Pw\xb5t\xc1 "] = -200;
  level.friendlyfire["I\x12\xb3%\x16\xe5I\xa4\xaa\x8f%\xd6r\x19\xfd\xa4\xad"] = 1000;
  level.friendlyfire["Dn\xdd\x9a\xe3:\xab\x89\x1e\xc5\xb5\xe7\xfe/<\xee{"] = 250;
  level.friendlyfire["\x95#v\xed\xa7\f\xb8\vd\xf9\xb3\xa4\xe8\xf3\x82I\x89\xee"] = -650;
  level.friendlyfire["Weg\x89bg\x15\f\xc9\xa4\\\x8b2\x12\xf39\xde\xa8Z"] = -500;
  level.friendlyfire["E;\x89,.c$\xbe\xf9\re\x98Pt\xdb\xd8\x95\xe8\xc2"] = 1.25;
  level.friendlyfire["\x81\x94\xd0\xcc\x86=\x19\x06\xc8]\xfd`\x8f-\x12\a"] = 0;
  level.friendlyfire["\x9c\xad\x9c\xd2^\xc7\a\xed'"] = 0;
  level.player.participation = 0;
  level.friendlyfiredisabled = 0;
  level.friendlyfiredisabledfordestructible = 0;
  setdvarifuninitialized(@ "hash_55eae984217fc9b6", "\xfe");
  setdvarifuninitialized(@ "hash_d8275bff94773942", "\xfe");
  setdvarifuninitialized(@ "hash_3cb172760816c3bb", "Bf");
  utility::flag_init("\xcb\x90\xa1\x86\x12N\xf2\\\x8c\x7f\x130\xc5\x83\xfdO\xc7[\x93C\xa8");
  thread debug_friendlyfire();
  thread participation_point_flattenovertime();
}

function debug_friendlyfire() {
  setdvarifuninitialized(@ "debug_friendlyfire", "<dev string:x24>");
  x = 0;
  y = 72;
  friendly_fire = newhudelem();
  friendly_fire.x = x;
  friendly_fire.y = y - 15;
  friendly_fire.alignx = "<dev string:x29>";
  friendly_fire.aligny = "<dev string:x31>";
  friendly_fire.font = "<dev string:x38>";
  friendly_fire.fontscale = 1;
  friendly_fire.alpha = 0;
  civcount = newhudelem();
  civcount.x = x + 95;
  civcount.y = y;
  civcount.alignx = "<dev string:x29>";
  civcount.aligny = "<dev string:x31>";
  civcount.font = "<dev string:x38>";
  civcount.fontscale = 1;
  civcount.alpha = 0;
  civilians = newhudelem();
  civilians.x = x;
  civilians.y = y;
  civilians.alignx = "<dev string:x29>";
  civilians.aligny = "<dev string:x31>";
  civilians.font = "<dev string:x38>";
  civilians.fontscale = 1;
  civilians.alpha = 0;
  civilians.showtext = 0;

  for(;;) {
    if(getDvar(@ "debug_friendlyfire") == "<dev string:x44>") {
      if(!civilians.showtext) {
        civilians.showtext = 1;
        civilians settext("<dev string:x49>");
      }

      civcount.alpha = 1;
      civilians.alpha = 1;
      friendly_fire.alpha = 1;
    } else {
      civcount.alpha = 0;
      civilians.alpha = 0;
      friendly_fire.alpha = 0;
    }

    civcount setvalue(level.friendlyfire["<dev string:x60>"]);
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
    entity.team = "O\x15\x1b\xad\x9ff";
  }

  level endon("\xd3[\x0f\xbdT\xfb\x02\xbf\xf6\x16\x02\xa9\xb2\x12");
  level thread notifydamage(entity);
  level thread notifydamagenotdone(entity);
  level thread notifydeath(entity);

  entity thread function_add2f5e3b74e428a();

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
    var_207472366842942a = undefined;
    entity waittill("\xa7n\x7f\xe7]j\xbe\x93\x1aJ\x83\xef\x8c\xbc\xdf\xa64\xd4\x1f", damage, attacker, direction, point, method, objweapon);

    if(!isDefined(entity)) {
      return;
    }

    if(istrue(level.skip_friendly_fire_check) || istrue(entity.skip_friendly_fire_check)) {
      continue;
    }

    if(!isDefined(attacker)) {
      continue;
    }

    if(isDefined(level.friendlyfire_damage_modifier) && damage != -1) {
      damage *= level.friendlyfire_damage_modifier;
      damage = int(damage);
    }

    var_f0eaed77223490a5 = 0;

    if(!isDefined(objweapon)) {
      objweapon = entity.damageweapon;
    }

    if(isPlayer(attacker)) {
      var_f0eaed77223490a5 = 1;

      if(isDefined(objweapon) && isnullweapon(objweapon)) {
        var_f0eaed77223490a5 = 0;
      }

      if(attacker isusingturret()) {
        var_f0eaed77223490a5 = 1;
      }

      if(isDefined(var_207472366842942a)) {
        var_f0eaed77223490a5 = 1;
      }
    } else if(isDefined(attacker.code_classname) && attacker.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
      owner = attacker getvehicleowner();

      if(isDefined(owner) && isPlayer(owner)) {
        attacker = owner;
        var_f0eaed77223490a5 = 1;
      }
    }

    if(!var_f0eaed77223490a5) {
      continue;
    }

    killed = damage == -1;
    iscivilian = entity iscivilian();
    civiliankilled = iscivilian && killed;

    if(getDvar(@ "hash_d8275bff94773942") == "\x87" && iscivilian) {
      continue;
    }

    if(getDvar(@ "debug_friendlyfire") == "<dev string:x44>") {
      if(iscivilian) {
        print3d(entity.origin + (0, 0, 50), entity.health, (1, 0, 0), 1, 0.5, 50);
      }
    }

    if(civiliankilled) {
      level.friendlyfire["\x81\x94\xd0\xcc\x86=\x19\x06\xc8]\xfd`\x8f-\x12\a"] = level.friendlyfire["\x81\x94\xd0\xcc\x86=\x19\x06\xc8]\xfd`\x8f-\x12\a"] + 1;
    }

    if(!isDefined(entity.team)) {
      continue;
    }

    same_team = entity isally();

    if(!same_team && !civiliankilled) {
      if(killed) {
        level.player.participation += level.friendlyfire["Dn\xdd\x9a\xe3:\xab\x89\x1e\xc5\xb5\xe7\xfe/<\xee{"];
        participation_point_cap();
        return;
      }

      continue;
    }

    if(isDefined(level.battlechatter) && !iscivilian && !killed) {
      function_99e8e66d1969d7cb(entity, undefined, "\xe0\xc6\a\xe0\b\x0fC\x1f\x19X\xfe\x97\xda");
    }

    if(istrue(level.no_friendly_fire_fail) || istrue(entity.no_friendly_fire_fail)) {
      continue;
    }

    if(isDefined(level.friendly_fire_skip_function) && [[level.friendly_fire_skip_function]]()) {
      continue;
    }

    if(isDefined(method) && istrue(level.no_friendly_fire_splash_damage)) {
      if(method == "j\xa7\x11\xfa\x14J\xe9\x92\xa8\xd0*I\xc4\x8a\xd75\x05\x89\x05S\x90") {
        continue;
      }

      if(isexplosivedamagemod(method)) {
        continue;
      }
    }

    if(isDefined(objweapon)) {
      basename = objweapon.basename;

      if(basename == "\xb3\xcb\xf0\xc8\xea\x86|>") {
        continue;
      }

      if(basename == "\xef\xd8\x94\x8d\xba") {
        continue;
      }

      if(basename == ":$qJ\x10h" && isDefined(entity.semtexstuckto)) {
        damage = 9999;
      }

      if(basename == "VK\n\xdb\xd0(O'T]\x12K\x8e") {
        damage = 9999;
      }

      if(basename == "\xb6\xbdc\xf6Gov") {
        damage = 9999;
      }
    }

    if(killed) {
      var_d42b2ed03503c604 = level.friendlyfire["\x9c\xad\x9c\xd2^\xc7\a\xed'"];

      if(isDefined(self.strict_ff)) {
        var_d42b2ed03503c604 = self.strict_ff;
      }

      var_e9b53007274938b2 = getdvarint(@ "hash_3cb172760816c3bb", -1);

      if(var_e9b53007274938b2 > -1) {
        var_d42b2ed03503c604 = var_e9b53007274938b2;
      }

      if(var_d42b2ed03503c604 && !attacker enemy_is_visible()) {
        level.player.participation = level.friendlyfire["\x17PW\x82\x88\xcb\xc9\x11\x8cq\x90Pw\xb5t\xc1 "];
      } else if(isDefined(entity.friend_kill_points)) {
        level.player.participation += entity.friend_kill_points;
      } else {
        waittillframeend();
        penalty = attacker get_adjusted_friendly_kill_points(level.friendlyfire["\x95#v\xed\xa7\f\xb8\vd\xf9\xb3\xa4\xe8\xf3\x82I\x89\xee"], method);
        level.player.participation += penalty;

        if(getdvarint(@ "debug_friendlyfire")) {
          thread function_ff5893c48d886afc(penalty, entity.origin + (0, 0, 60), (1, 0, 0.1));
        }
      }
    } else if(method == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
      level.player.participation += level.friendlyfire["Weg\x89bg\x15\f\xc9\xa4\\\x8b2\x12\xf39\xde\xa8Z"];
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
  var_8bd7d90139a918a7 = gettime() - mostrecent;

  if(var_8bd7d90139a918a7 > 1500) {
    return penaltypoints;
  }

  factor = 1 - math::normalize_value(0, 1500, var_8bd7d90139a918a7);
  var_c2cbf0c080ca9b51 = math::factor_value(penaltypoints, 0, factor);
  var_c2cbf0c080ca9b51 = int(var_c2cbf0c080ca9b51);
  return var_c2cbf0c080ca9b51;
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

function function_ff5893c48d886afc(value, origin, color) {
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

  if(isDefined(self.unittype) && self.unittype == "75\xffQ\x95\xfe`\x9a") {
    return 1;
  }

  if(isDefined(self.asmname) && self.asmname == "75\xffQ\x95\xfe`\x9a") {
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

function function_add2f5e3b74e428a() {
  self endon("<dev string:x74>");

  while(true) {
    if(getDvar(@ "debug_friendlyfire") == "<dev string:x44>") {
      text = undefined;
      color = undefined;
      scale = undefined;
      alpha = undefined;

      if(!istrue(level.skip_friendly_fire_check) && !istrue(self.skip_friendly_fire_check)) {
        if(iscivilian()) {
          text = "<dev string:x7d>";
          color = (1, 0, 0);
          scale = 0.5;

          if(getDvar(@ "hash_d8275bff94773942") == "<dev string:x44>") {
            alpha = 0;
          } else {
            alpha = 1;
          }
        } else if(isally()) {
          text = "<dev string:x89>";
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

  var_abda668caecaf779 = level.friendlyfiredisabledfordestructible;

  if(isDefined(level.friendlyfire_destructible_attacker) && civiliankilled) {
    var_abda668caecaf779 = 0;
  }

  if(var_abda668caecaf779) {
    return;
  }

  if(level.friendlyfiredisabled == 1) {
    return;
  }

  if(level.player.participation <= level.friendlyfire["\x17PW\x82\x88\xcb\xc9\x11\x8cq\x90Pw\xb5t\xc1 "]) {
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

  if(isDefined(method) && method == "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a") {
    wasgrenade = 1;
  }

  if(isDefined(objweapon) && objweapon.basename == "VK\n\xdb\xd0(O'T]\x12K\x8e") {
    wasgrenade = 1;
  }

  if(isDefined(objweapon) && objweapon.basename == "\xb6\xbdc\xf6Gov") {
    wasgrenade = 1;
  }

  return wasgrenade;
}

function savecommit_aftergrenade() {
  currenttime = gettime();

  if(currenttime < 4500) {
    println("<dev string:x91>");
    return true;
  } else if(currenttime - level.autosave.lastautosavetime < 4500) {
    println("<dev string:xfd>");
    return true;
  }

  return false;
}

function participation_point_cap() {
  if(level.player.participation > level.friendlyfire["I\x12\xb3%\x16\xe5I\xa4\xaa\x8f%\xd6r\x19\xfd\xa4\xad"]) {
    level.player.participation = level.friendlyfire["I\x12\xb3%\x16\xe5I\xa4\xaa\x8f%\xd6r\x19\xfd\xa4\xad"];
  }

  if(level.player.participation < level.friendlyfire["\x17PW\x82\x88\xcb\xc9\x11\x8cq\x90Pw\xb5t\xc1 "]) {
    level.player.participation = level.friendlyfire["\x17PW\x82\x88\xcb\xc9\x11\x8cq\x90Pw\xb5t\xc1 "];
  }
}

function participation_point_flattenovertime() {
  level endon("\xd3[\x0f\xbdT\xfb\x02\xbf\xf6\x16\x02\xa9\xb2\x12");

  for(;;) {
    if(level.player.participation > 0) {
      level.player.participation--;
    } else if(level.player.participation < 0) {
      level.player.participation++;
    }

    wait level.friendlyfire["E;\x89,.c$\xbe\xf9\re\x98Pt\xdb\xd8\x95\xe8\xc2"];
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

  if(getDvar(@ "hash_55eae984217fc9b6") == "\x87") {
    return;
  }

  if(getdvarint(@ "exec_review") > 0) {
    return;
  }

  level.player endon("\x1e\xfd\xd1\xa2\a");

  if(!isalive(level.player)) {
    return;
  }

  level endon("$\xa4P\a\xad\xad4\xb5\xa8\x7f");
  level notify("\xd3[\x0f\xbdT\xfb\x02\xbf\xf6\x16\x02\xa9\xb2\x12");
  level notify("\xc9\x95c\x92\xe0d\xf6C2t3(\xa4^\t{\xe2\xf6\x9d\xcfO\x80\x9b\"\x02");
  waittillframeend();
  setsaveddvar(@ "hud_missionfailed", 1);
  setomnvar("\xfb\nX{\x88\b\x89\x9cV~m\xefg\xe8g\xfc-\xfc\xef", 1);
  setsaveddvar(@ "hash_4e8225c28298a6ad", 0);
  setsaveddvar(@ "hash_9d7a2fa032e463d5", 1);

  if(isDefined(level.player.failingmission)) {
    return;
  }

  if(civiliankilled) {
    if(isDefined(level.var_be75b18374b277b7)) {
      player_death::set_custom_death_quote(level.var_be75b18374b277b7);
    } else {
      player_death::set_custom_death_quote(%"hash_749bfa4b5858fd6e");
    }
  } else if(isDefined(level.custom_friendly_fire_message)) {
    player_death::set_custom_death_quote(level.custom_friendly_fire_message);
  } else {
    player_death::set_custom_death_quote(%"hash_2260733407b3fc5d");
  }

  if(isDefined(level.custom_friendly_fire_shader)) {
    thread player_death::set_death_icon(level.custom_friendly_fire_shader, 64, 64, 0);
  }

  utility_sp::missionfailedwrapper("\a\x11\xc0*X\x0fFC\xfa\xe7k\x14\x17\xacFd");
}

function ally_turn_on_player() {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x1e\xfd\xd1\xa2\a");
  self stopanimScripted();
  utility_sp::clear_force_color();
  val::set("\xdei\xe3\xa5\x8b0\xe2\t\xfe$6\x19\x04\xe06*\a", "\"\xbf\x1b\x86K\x8b\xdde%L\xf7\xaa\rnE\xc38", 1);
  utility_sp::clearthreatbias("?\xb1\xc0\x9a", "O\x15\x1b\xad\x9ff");

  while(true) {
    self.team = "?\xb1\xc0\x9a";
    self.favoritenemy = level.player;
    wait 0.05;
  }
}

function notifydamage(entity) {
  entity endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    entity waittill("\fU`\xc0y\x95", damage, attacker, direction, point, method, unused, unused, unused, unused, objweapon);
    entity notify("\xa7n\x7f\xe7]j\xbe\x93\x1aJ\x83\xef\x8c\xbc\xdf\xa64\xd4\x1f", damage, attacker, direction, point, method, objweapon);
  }
}

function notifydamagenotdone(entity) {
  entity waittill("\xc4\xf5\x16;r\xce\x81\xf3\xbe\xda\xe6\xff\xef\xcd", damage, attacker, unused, unused, method);
  entity notify("\xa7n\x7f\xe7]j\xbe\x93\x1aJ\x83\xef\x8c\xbc\xdf\xa64\xd4\x1f", -1, attacker, undefined, undefined, method);
}

function notifydeath(entity) {
  entity waittill("\x1e\xfd\xd1\xa2\a", attacker, method, objweapon);
  entity notify("\xa7n\x7f\xe7]j\xbe\x93\x1aJ\x83\xef\x8c\xbc\xdf\xa64\xd4\x1f", -1, attacker, undefined, undefined, method, objweapon);
}

function detectfriendlyfireonentity(entity) {}

function reset_friendlyfire_participation() {
  level.player.participation = 0;
}

function enemy_is_visible() {
  mostrecent = get_most_recent_dmg_or_death_time();
  var_8bd7d90139a918a7 = gettime() - mostrecent;

  if(var_8bd7d90139a918a7 < 600) {
    return true;
  }

  cos30 = 0.866025;

  foreach(enemy in getaiarray("?\xb1\xc0\x9a")) {
    enemyvisible = math::within_fov_2d(level.player.origin, level.player.angles, enemy.origin, cos30);
    enemyvisible &= enemy seerecently(level.player, 2);

    if(enemyvisible) {
      return true;
    }
  }

  return false;
}

function strict_ff_enable() {
  level.friendlyfire["\x9c\xad\x9c\xd2^\xc7\a\xed'"] = 1;
}

function strict_ff_disable() {
  level.friendlyfire["\x9c\xad\x9c\xd2^\xc7\a\xed'"] = 0;
}

function set_strict_ff(bool) {
  assert(isDefined(self), "<dev string:x150>");
  self.strict_ff = bool;
}

function function_8796e6a8ffa6ea24() {
  assert(isDefined(self), "<dev string:x17c>");
  self.friend_kill_points = level.friendlyfire["\x17PW\x82\x88\xcb\xc9\x11\x8cq\x90Pw\xb5t\xc1 "] * 2 - level.friendlyfire["I\x12\xb3%\x16\xe5I\xa4\xaa\x8f%\xd6r\x19\xfd\xa4\xad"];
}