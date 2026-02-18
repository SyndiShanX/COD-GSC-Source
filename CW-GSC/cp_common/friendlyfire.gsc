/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\friendlyfire.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace friendlyfire;

function private autoexec __init__system__() {
  system::register(#"friendlyfire", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_911cdf6e[# "min_participation"] = -5;
  level.var_911cdf6e[# "max_participation"] = 1000;
  level.var_911cdf6e[# "hash_15f7f611338f7f22"] = 250;
  level.var_911cdf6e[# "friend_kill_points"] = -5;
  level.var_911cdf6e[# "hash_308b6e99638b7c04"] = -5;
  level.var_911cdf6e[# "hash_69a22a048631e673"] = 0.75;
  level.var_edbfa7b = 0.5;

  if(sessionmodeiscampaigngame() && level.gametype !== "coop") {
    level.friendlyfiredisabled = 0;
  }

  if(!isDefined(level.friendlyfiredisabled)) {
    level.friendlyfiredisabled = 0;
  }

  callback::on_connect(&init_player);
}

function init_player() {
  assert(isDefined(self), "<dev string:x38>");
  self.participation = 0;

  self thread debug_friendlyfire();

  self thread participation_point_flattenovertime();
}

function function_b943ac72(msg) {
  if(getdvarstring(#"debug_friendlyfire") == "<dev string:x4f>") {
    iprintlnbold(msg);
  }

  if(getdvarstring(#"hash_2d7cfd6663c775a7") == "<dev string:x4f>") {
    println("<dev string:x55>" + msg);
  }
}

function private function_25d6cf14() {
  if(!isDefined(self.var_d5b6872a)) {
    self.var_d5b6872a = spawnStruct();
    self.var_d5b6872a.var_987926ba = level.var_911cdf6e[# "max_participation"] - level.var_911cdf6e[# "min_participation"];
    self.var_d5b6872a.var_db612029 = 520;
    self.var_d5b6872a.var_40b5d571 = 620;
    self.var_d5b6872a.ypos = 130;
    self.var_d5b6872a.bar_width = self.var_d5b6872a.var_40b5d571 - self.var_d5b6872a.var_db612029;
  }

  if(!isDefined(self.var_d5b6872a.friendly_fire)) {
    self.var_d5b6872a.friendly_fire = newdebughudelem();
    self.var_d5b6872a.friendly_fire.fontscale = 3;
    self.var_d5b6872a.friendly_fire.alignx = "<dev string:x68>";
    self.var_d5b6872a.friendly_fire.aligny = "<dev string:x71>";
    self.var_d5b6872a.friendly_fire.x = self.var_d5b6872a.var_40b5d571 - self.var_d5b6872a.bar_width * level.var_911cdf6e[# "max_participation"] / self.var_d5b6872a.var_987926ba - log(self.participation) * self.var_d5b6872a.friendly_fire.fontscale;
    self.var_d5b6872a.friendly_fire.y = 100;
    self.var_d5b6872a.friendly_fire.alpha = 1;
  }

  if(!isDefined(self.var_d5b6872a.var_9a2c2205)) {
    self.var_d5b6872a.var_9a2c2205 = newdebughudelem();
    self.var_d5b6872a.var_9a2c2205.fontscale = 1.5;
    self.var_d5b6872a.var_9a2c2205.alignx = "<dev string:x68>";
    self.var_d5b6872a.var_9a2c2205.aligny = "<dev string:x71>";
    self.var_d5b6872a.var_9a2c2205.x = self.var_d5b6872a.var_db612029 - (ceil(max(log(abs(level.var_911cdf6e[# "min_participation"])) / log(10), 0)) - 2 + (self.participation < 0)) * self.var_d5b6872a.friendly_fire.fontscale;
    self.var_d5b6872a.var_9a2c2205.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.var_9a2c2205.alpha = 1;
    self.var_d5b6872a.var_9a2c2205 setvalue(level.var_911cdf6e[# "min_participation"]);
  }

  if(!isDefined(self.var_d5b6872a.var_67b2f7ad)) {
    self.var_d5b6872a.var_67b2f7ad = newdebughudelem();
    self.var_d5b6872a.var_67b2f7ad.fontscale = 1.5;
    self.var_d5b6872a.var_67b2f7ad.alignx = "<dev string:x68>";
    self.var_d5b6872a.var_67b2f7ad.aligny = "<dev string:x71>";
    self.var_d5b6872a.var_67b2f7ad.x = self.var_d5b6872a.var_40b5d571 + 2 * (ceil(max(log(abs(level.var_911cdf6e[# "max_participation"])) / log(10), 0)) + 2.5 + (self.participation < 0)) * self.var_d5b6872a.friendly_fire.fontscale;
    self.var_d5b6872a.var_67b2f7ad.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.var_67b2f7ad.alpha = 1;
    self.var_d5b6872a.var_67b2f7ad setvalue(level.var_911cdf6e[# "max_participation"]);
  }

  if(!isDefined(self.var_d5b6872a.var_ce0ada2c)) {
    self.var_d5b6872a.var_ce0ada2c = newdebughudelem(self);
    self.var_d5b6872a.var_ce0ada2c.alignx = "<dev string:x68>";
    self.var_d5b6872a.var_ce0ada2c.aligny = "<dev string:x71>";
    self.var_d5b6872a.var_ce0ada2c.x = self.var_d5b6872a.var_40b5d571;
    self.var_d5b6872a.var_ce0ada2c.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.var_ce0ada2c.sort = 1;
    self.var_d5b6872a.var_ce0ada2c.alpha = 1;
    self.var_d5b6872a.var_ce0ada2c.foreground = 1;
    self.var_d5b6872a.var_ce0ada2c.color = (0.4, 0.4, 0.4);
    self.var_d5b6872a.var_ce0ada2c setshader(#"white", self.var_d5b6872a.bar_width, 9);
  }

  if(!isDefined(self.var_d5b6872a.debug_health_bar)) {
    self.var_d5b6872a.debug_health_bar = newdebughudelem(self);
    self.var_d5b6872a.debug_health_bar.alignx = "<dev string:x68>";
    self.var_d5b6872a.debug_health_bar.aligny = "<dev string:x71>";
    self.var_d5b6872a.debug_health_bar.x = 620;
    self.var_d5b6872a.debug_health_bar.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.debug_health_bar.sort = 4;
    self.var_d5b6872a.debug_health_bar.alpha = 1;
    self.var_d5b6872a.debug_health_bar.foreground = 1;
    self.var_d5b6872a.debug_health_bar.color = (0, 0, 0.9);
    self.var_d5b6872a.debug_health_bar setshader(#"white", 4, 15);
  }

  if(!isDefined(self.var_d5b6872a.var_704a4d3b)) {
    self.var_d5b6872a.var_704a4d3b = newdebughudelem(self);
    self.var_d5b6872a.var_704a4d3b.alignx = "<dev string:x68>";
    self.var_d5b6872a.var_704a4d3b.aligny = "<dev string:x71>";
    self.var_d5b6872a.var_704a4d3b.x = self.var_d5b6872a.var_db612029;
    self.var_d5b6872a.var_704a4d3b.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.var_704a4d3b.sort = 2;
    self.var_d5b6872a.var_704a4d3b.alpha = 1;
    self.var_d5b6872a.var_704a4d3b.foreground = 1;
    self.var_d5b6872a.var_704a4d3b setshader(#"black", 4, 21);
  }

  if(!isDefined(self.var_d5b6872a.var_203309fa)) {
    self.var_d5b6872a.var_203309fa = newdebughudelem(self);
    self.var_d5b6872a.var_203309fa.alignx = "<dev string:x68>";
    self.var_d5b6872a.var_203309fa.aligny = "<dev string:x71>";
    self.var_d5b6872a.var_203309fa.x = self.var_d5b6872a.var_40b5d571;
    self.var_d5b6872a.var_203309fa.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.var_203309fa.sort = 2;
    self.var_d5b6872a.var_203309fa.alpha = 1;
    self.var_d5b6872a.var_203309fa.foreground = 1;
    self.var_d5b6872a.var_203309fa setshader(#"black", 4, 21);
  }

  if(!isDefined(self.var_d5b6872a.var_c16c1379)) {
    self.var_d5b6872a.var_c16c1379 = newdebughudelem(self);
    self.var_d5b6872a.var_c16c1379.alignx = "<dev string:x68>";
    self.var_d5b6872a.var_c16c1379.aligny = "<dev string:x71>";
    self.var_d5b6872a.var_c16c1379.x = self.var_d5b6872a.var_db612029 + level.var_911cdf6e[# "min_participation"] * -1 / self.var_d5b6872a.var_987926ba * self.var_d5b6872a.bar_width;
    self.var_d5b6872a.var_c16c1379.y = self.var_d5b6872a.ypos + 9;
    self.var_d5b6872a.var_c16c1379.sort = 2;
    self.var_d5b6872a.var_c16c1379.alpha = 1;
    self.var_d5b6872a.var_c16c1379.foreground = 1;
    self.var_d5b6872a.var_c16c1379 setshader(#"black", 4, 4);
  }

  if(!isDefined(self.var_d5b6872a.var_24736d8c)) {
    self.var_d5b6872a.var_24736d8c = newdebughudelem(self);
    self.var_d5b6872a.var_24736d8c.alignx = "<dev string:x68>";
    self.var_d5b6872a.var_24736d8c.aligny = "<dev string:x71>";
    self.var_d5b6872a.var_24736d8c.x = self.var_d5b6872a.var_db612029 + level.var_911cdf6e[# "min_participation"] * -1 / self.var_d5b6872a.var_987926ba * self.var_d5b6872a.bar_width;
    self.var_d5b6872a.var_24736d8c.y = self.var_d5b6872a.ypos - 9;
    self.var_d5b6872a.var_24736d8c.sort = 2;
    self.var_d5b6872a.var_24736d8c.alpha = 1;
    self.var_d5b6872a.var_24736d8c.foreground = 1;
    self.var_d5b6872a.var_24736d8c setshader(#"black", 4, 4);
  }
}

function debug_friendlyfire() {
  self endon(#"disconnect", #"hash_1ff2bf35392915");

  if(getdvarstring(#"debug_friendlyfire") == "<dev string:x7b>") {
    setDvar(#"debug_friendlyfire", "<dev string:x7f>");
  }

  if(getdvarstring(#"hash_2d7cfd6663c775a7") == "<dev string:x7b>") {
    setDvar(#"hash_2d7cfd6663c775a7", "<dev string:x7f>");
  }

  for(;;) {
    function_25d6cf14();

    if(getdvarstring(#"debug_friendlyfire") == "<dev string:x4f>") {
      self.var_d5b6872a.friendly_fire.alpha = 1;
      self.var_d5b6872a.var_9a2c2205.alpha = 1;
      self.var_d5b6872a.var_67b2f7ad.alpha = 1;
      self.var_d5b6872a.var_ce0ada2c.alpha = 1;
      self.var_d5b6872a.debug_health_bar.alpha = 1;
      self.var_d5b6872a.var_704a4d3b.alpha = 1;
      self.var_d5b6872a.var_203309fa.alpha = 1;
      self.var_d5b6872a.var_c16c1379.alpha = 1;
      self.var_d5b6872a.var_24736d8c.alpha = 1;
    } else {
      self.var_d5b6872a.friendly_fire.alpha = 0;
      self.var_d5b6872a.var_9a2c2205.alpha = 0;
      self.var_d5b6872a.var_67b2f7ad.alpha = 0;
      self.var_d5b6872a.var_ce0ada2c.alpha = 0;
      self.var_d5b6872a.debug_health_bar.alpha = 0;
      self.var_d5b6872a.var_704a4d3b.alpha = 0;
      self.var_d5b6872a.var_203309fa.alpha = 0;
      self.var_d5b6872a.var_c16c1379.alpha = 0;
      self.var_d5b6872a.var_24736d8c.alpha = 0;
    }

    xpos = (level.var_911cdf6e[# "max_participation"] - self.participation) / self.var_d5b6872a.var_987926ba * self.var_d5b6872a.bar_width;
    self.var_d5b6872a.debug_health_bar.x = self.var_d5b6872a.var_40b5d571 - xpos;
    self.var_d5b6872a.friendly_fire setvalue(self.participation);
    self.var_d5b6872a.friendly_fire.x = self.var_d5b6872a.var_40b5d571 - self.var_d5b6872a.bar_width * level.var_911cdf6e[# "max_participation"] / self.var_d5b6872a.var_987926ba + (ceil(max(log(abs(self.participation)) / log(10), 0)) + 1 + (self.participation < 0)) * self.var_d5b6872a.friendly_fire.fontscale * 2;
    wait 0.25;
  }
}

function function_9d79ae6f(entity) {
  if(entity.archetype === "warlord_soldier") {
    return (entity.shieldhealth <= 0);
  }

  return false;
}

function function_1ad87afd(entity, damage, attacker, method, weapon, einflictor) {
  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(entity.team)) {
    entity.team = # "allies";
  }

  if(!isDefined(entity)) {
    return;
  }

  var_bee3a418 = function_9d79ae6f(entity);

  if(entity.health <= 0) {
    if(!var_bee3a418) {
      return;
    }
  }

  if(level.friendlyfiredisabled) {
    return;
  }

  if(is_true(entity.nofriendlyfire)) {
    return;
  }

  if(!isDefined(attacker)) {
    return;
  }

  if(attacker.body_shield_grenade === einflictor) {
    return;
  }

  if(weapon.name === # "eq_flash_grenade" || weapon.name === # "land_mine_cp") {
    return;
  }

  if(isDefined(einflictor) && einflictor.classname === "grenade" && is_true(einflictor.var_ec078486)) {
    return;
  }

  var_f6cca883 = 0;

  if(isPlayer(attacker)) {
    var_f6cca883 = 1;
  } else if(isDefined(attacker.classname) && attacker.classname == "script_vehicle") {
    owner = attacker getvehicleowner();

    if(isDefined(owner)) {
      if(isPlayer(owner)) {
        if(!isDefined(owner.var_a4dee4fd)) {
          var_f6cca883 = 1;
          attacker = owner;
        }
      }
    }
  }

  if(!var_f6cca883) {
    return;
  }

  same_team = entity.team == attacker.team;

  if(attacker.team == # "allies") {
    if(entity.team == # "neutral" && !is_true(level.var_cd2635a5)) {
      same_team = 1;
    }
  }

  same_team |= util::function_9b7092ef(entity.team, attacker.team);

  if(entity.team != # "neutral" || entity.team == # "neutral" && !is_true(level.var_cd2635a5)) {
    attacker.var_97a2e324 = entity.team;
  }

  killed = damage >= entity.health || var_bee3a418;

  if(!entity.allowdeath && !check_grenade(entity, method)) {
    killed = 0;
  }

  if(!same_team) {
    if(killed) {
      attacker.participation += level.var_911cdf6e[# "hash_15f7f611338f7f22"];
      attacker participation_point_cap();
      function_b943ac72("Enemy killed: +" + level.var_911cdf6e[# "hash_15f7f611338f7f22"]);
    }

    return;
  }

  if(isDefined(entity.var_2609b537)) {
    return;
  }

  if((isDefined(attacker.participation) ? attacker.participation : 0) > 0) {
    attacker.participation = 0;
  }

  if(killed) {
    if(entity.archetype === # "civilian" || entity.team == # "neutral") {
      level notify(#"hash_3f3c07e5660a9695");
      attacker.participation += level.var_911cdf6e[# "hash_308b6e99638b7c04"];
      function_b943ac72("Civilian killed: -" + 0 - level.var_911cdf6e[# "hash_308b6e99638b7c04"]);
    } else if(isDefined(entity) && isDefined(entity.var_f9a443f6)) {
      attacker.participation += entity.var_f9a443f6;
      function_b943ac72("Friendly killed with custom penalty: -" + 0 - entity.var_f9a443f6);
    } else {
      attacker.participation += level.var_911cdf6e[# "friend_kill_points"];
      function_b943ac72("Friendly killed: -" + 0 - level.var_911cdf6e[# "friend_kill_points"]);
    }
  } else {
    attacker.participation -= 1;
    function_b943ac72("Friendly hurt: -" + damage);
  }

  attacker participation_point_cap();

  if(check_grenade(entity, method) && savecommit_aftergrenade()) {
    return;
  }

  attacker friendly_fire_checkpoints();
}

function friendly_fire_think(entity) {
  level endon(#"hash_fef7dac2cb38596");
  entity endon(#"hash_9cd363fce58b93d");

  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(entity.team)) {
    entity.team = # "allies";
  }

  for(;;) {
    if(!isDefined(entity)) {
      return;
    }

    waitresult = entity waittill(#"damage");
    attacker = waitresult.attacker;
    damage = waitresult.amount;
    method = waitresult.mod;

    if(level.friendlyfiredisabled) {
      continue;
    }

    if(!isDefined(entity)) {
      return;
    }

    if(is_true(entity.nofriendlyfire)) {
      continue;
    }

    if(!isDefined(attacker)) {
      continue;
    }

    var_f6cca883 = 0;

    if(isPlayer(attacker)) {
      var_f6cca883 = 1;
    } else if(isDefined(attacker.classname) && attacker.classname == "script_vehicle") {
      owner = attacker getvehicleowner();

      if(isDefined(owner)) {
        if(isPlayer(owner)) {
          if(!isDefined(owner.var_a4dee4fd)) {
            var_f6cca883 = 1;
            attacker = owner;
          }
        }
      }
    }

    if(!var_f6cca883) {
      continue;
    }

    same_team = entity.team == attacker.team;

    if(attacker.team == # "allies") {
      if(entity.team == # "neutral" && !is_true(level.var_cd2635a5)) {
        same_team = 1;
      }
    }

    same_team |= util::function_9b7092ef(entity.team, attacker.team);

    if(entity.team != # "neutral" || entity.team == # "neutral" && !is_true(level.var_cd2635a5)) {
      attacker.var_97a2e324 = entity.team;
    }

    killed = damage >= entity.health;

    if(!entity.allowdeath && !check_grenade(entity, method)) {
      killed = 0;
    }

    if(!same_team) {
      if(killed) {
        attacker.participation += level.var_911cdf6e[# "hash_15f7f611338f7f22"];
        attacker participation_point_cap();
        function_b943ac72("Enemy killed: +" + level.var_911cdf6e[# "hash_15f7f611338f7f22"]);
      }

      return;
    }

    if(isDefined(entity.var_2609b537)) {
      continue;
    }

    if((isDefined(attacker.participation) ? attacker.participation : 0) > 0) {
      attacker.participation = 0;
    }

    if(killed) {
      if(entity.archetype === # "civilian" || entity.team == # "neutral") {
        level notify(#"hash_3f3c07e5660a9695");

        if(attacker.participation <= 0) {
          attacker.participation += level.var_911cdf6e[# "min_participation"];
          function_b943ac72("Civilian killed with negative score, autofail!");
        } else {
          attacker.participation += level.var_911cdf6e[# "hash_308b6e99638b7c04"];
          function_b943ac72("Civilian killed: -" + 0 - level.var_911cdf6e[# "hash_308b6e99638b7c04"]);
        }
      } else if(isDefined(entity) && isDefined(entity.var_f9a443f6)) {
        attacker.participation += entity.var_f9a443f6;
        function_b943ac72("Friendly killed with custom penalty: -" + 0 - entity.var_f9a443f6);
      } else {
        attacker.participation += level.var_911cdf6e[# "friend_kill_points"];
        function_b943ac72("Friendly killed: -" + 0 - level.var_911cdf6e[# "friend_kill_points"]);
      }
    } else {
      attacker.participation -= 1;
      function_b943ac72("Friendly hurt: -" + damage);
    }

    attacker participation_point_cap();

    if(check_grenade(entity, method) && savecommit_aftergrenade()) {
      if(killed) {
        return;
      }

      continue;
    }

    attacker friendly_fire_checkpoints();
  }
}

function friendly_fire_checkpoints() {
  if(self.participation <= level.var_911cdf6e[# "min_participation"]) {
    self thread missionfail();
  }
}

function check_grenade(entity, method) {
  if(!isDefined(entity)) {
    return 0;
  }

  wasgrenade = 0;

  if(isDefined(entity.damageweapon) && entity.damageweapon.name == "none") {
    wasgrenade = 1;
  }

  if(isDefined(method) && method == "MOD_GRENADE_SPLASH") {
    wasgrenade = 1;
  }

  return wasgrenade;
}

function savecommit_aftergrenade() {
  currenttime = gettime();

  if(currenttime < 4500) {
    println("<dev string:x86>");
    return true;
  }

  return false;
}

function participation_point_cap() {
  if(!isDefined(self.participation)) {
    assertmsg("<dev string:xf2>");
    return;
  }

  if(self.participation > level.var_911cdf6e[# "max_participation"]) {
    self.participation = level.var_911cdf6e[# "max_participation"];
  }

  if(self.participation < level.var_911cdf6e[# "min_participation"]) {
    self.participation = level.var_911cdf6e[# "min_participation"];
  }
}

function participation_point_flattenovertime() {
  level endon(#"hash_7d1398df3ecfd3bf");
  self endon(#"disconnect");

  for(;;) {
    if(self.participation > 0) {
      self.participation--;
    }

    wait level.var_911cdf6e[# "hash_69a22a048631e673"];
  }
}

function turnbackon() {
  level.friendlyfiredisabled = 0;
}

function turnoff() {
  level.friendlyfiredisabled = 1;
}

function missionfail() {
  self endon(#"death");
  level endon(#"hash_2a5bc3aedd245590");
  self.participation = 0;
  self.lives = 0;

  if(self.var_97a2e324 === # "neutral") {
    util::function_2a8f4806(#"hash_293687c2ffb1b911", #"hash_7d45646726cd7f74");
    return;
  }

  util::function_2a8f4806(#"hash_23aab5a843404b78", #"hash_7d45646726cd7f74");
}

function function_708f45ad() {
  self endon(#"death");
  level endon(#"hash_2a5bc3aedd245590");
  self.participation = 0;
  wait 0.05;
  self.participation = 0;
}

function notifydamage(entity) {
  level endon(#"hash_fef7dac2cb38596");
  entity endon(#"death");

  for(;;) {
    entity notify(#"friendlyfire_notify", entity waittill(#"damage"));
  }
}

function notifydamagenotdone(entity) {
  level endon(#"hash_fef7dac2cb38596");
  waitresult = entity waittill(#"damage_notdone");
  waitresult.amount = -1;
  entity notify(#"friendlyfire_notify", waitresult);
}

function notifydeath(entity) {
  level endon(#"hash_fef7dac2cb38596");
  waitresult = entity waittill(#"death");
  waitresult.amount = -1;
  entity notify(#"friendlyfire_notify", waitresult);
}