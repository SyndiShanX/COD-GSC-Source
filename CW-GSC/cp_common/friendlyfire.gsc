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
  level.friendlyfirepoints[#"min_participation"] = -5;
  level.friendlyfirepoints[#"max_participation"] = 1000;
  level.friendlyfirepoints[#"enemy_kill_points"] = 250;
  level.friendlyfirepoints[#"friend_kill_points"] = -5;
  level.friendlyfirepoints[#"civ_kill_points"] = -5;
  level.friendlyfirepoints[#"point_loss_interval"] = 0.75;
  level.friendlyfiredamagepercentage = 0.5;

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

function debug_log(msg) {
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
    self.var_d5b6872a.fullpts = level.friendlyfirepoints[#"max_participation"] - level.friendlyfirepoints[#"min_participation"];
    self.var_d5b6872a.lbound = 520;
    self.var_d5b6872a.rbound = 620;
    self.var_d5b6872a.ypos = 130;
    self.var_d5b6872a.bar_width = self.var_d5b6872a.rbound - self.var_d5b6872a.lbound;
  }

  if(!isDefined(self.var_d5b6872a.friendly_fire)) {
    self.var_d5b6872a.friendly_fire = newdebughudelem();
    self.var_d5b6872a.friendly_fire.fontscale = 3;
    self.var_d5b6872a.friendly_fire.alignx = "<dev string:x68>";
    self.var_d5b6872a.friendly_fire.aligny = "<dev string:x71>";
    self.var_d5b6872a.friendly_fire.x = self.var_d5b6872a.rbound - self.var_d5b6872a.bar_width * level.friendlyfirepoints[#"max_participation"] / self.var_d5b6872a.fullpts - log(self.participation) * self.var_d5b6872a.friendly_fire.fontscale;
    self.var_d5b6872a.friendly_fire.y = 100;
    self.var_d5b6872a.friendly_fire.alpha = 1;
  }

  if(!isDefined(self.var_d5b6872a.friendly_fire_lower_bound_label)) {
    self.var_d5b6872a.friendly_fire_lower_bound_label = newdebughudelem();
    self.var_d5b6872a.friendly_fire_lower_bound_label.fontscale = 1.5;
    self.var_d5b6872a.friendly_fire_lower_bound_label.alignx = "<dev string:x68>";
    self.var_d5b6872a.friendly_fire_lower_bound_label.aligny = "<dev string:x71>";
    self.var_d5b6872a.friendly_fire_lower_bound_label.x = self.var_d5b6872a.lbound - (ceil(max(log(abs(level.friendlyfirepoints[#"min_participation"])) / log(10), 0)) - 2 + (self.participation < 0)) * self.var_d5b6872a.friendly_fire.fontscale;
    self.var_d5b6872a.friendly_fire_lower_bound_label.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.friendly_fire_lower_bound_label.alpha = 1;
    self.var_d5b6872a.friendly_fire_lower_bound_label setvalue(level.friendlyfirepoints[#"min_participation"]);
  }

  if(!isDefined(self.var_d5b6872a.friendly_fire_upper_bound_label)) {
    self.var_d5b6872a.friendly_fire_upper_bound_label = newdebughudelem();
    self.var_d5b6872a.friendly_fire_upper_bound_label.fontscale = 1.5;
    self.var_d5b6872a.friendly_fire_upper_bound_label.alignx = "<dev string:x68>";
    self.var_d5b6872a.friendly_fire_upper_bound_label.aligny = "<dev string:x71>";
    self.var_d5b6872a.friendly_fire_upper_bound_label.x = self.var_d5b6872a.rbound + 2 * (ceil(max(log(abs(level.friendlyfirepoints[#"max_participation"])) / log(10), 0)) + 2.5 + (self.participation < 0)) * self.var_d5b6872a.friendly_fire.fontscale;
    self.var_d5b6872a.friendly_fire_upper_bound_label.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.friendly_fire_upper_bound_label.alpha = 1;
    self.var_d5b6872a.friendly_fire_upper_bound_label setvalue(level.friendlyfirepoints[#"max_participation"]);
  }

  if(!isDefined(self.var_d5b6872a.debug_health_bar_bg)) {
    self.var_d5b6872a.debug_health_bar_bg = newdebughudelem(self);
    self.var_d5b6872a.debug_health_bar_bg.alignx = "<dev string:x68>";
    self.var_d5b6872a.debug_health_bar_bg.aligny = "<dev string:x71>";
    self.var_d5b6872a.debug_health_bar_bg.x = self.var_d5b6872a.rbound;
    self.var_d5b6872a.debug_health_bar_bg.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.debug_health_bar_bg.sort = 1;
    self.var_d5b6872a.debug_health_bar_bg.alpha = 1;
    self.var_d5b6872a.debug_health_bar_bg.foreground = 1;
    self.var_d5b6872a.debug_health_bar_bg.color = (0.4, 0.4, 0.4);
    self.var_d5b6872a.debug_health_bar_bg setshader(#"white", self.var_d5b6872a.bar_width, 9);
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

  if(!isDefined(self.var_d5b6872a.debug_health_bar_left_bound)) {
    self.var_d5b6872a.debug_health_bar_left_bound = newdebughudelem(self);
    self.var_d5b6872a.debug_health_bar_left_bound.alignx = "<dev string:x68>";
    self.var_d5b6872a.debug_health_bar_left_bound.aligny = "<dev string:x71>";
    self.var_d5b6872a.debug_health_bar_left_bound.x = self.var_d5b6872a.lbound;
    self.var_d5b6872a.debug_health_bar_left_bound.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.debug_health_bar_left_bound.sort = 2;
    self.var_d5b6872a.debug_health_bar_left_bound.alpha = 1;
    self.var_d5b6872a.debug_health_bar_left_bound.foreground = 1;
    self.var_d5b6872a.debug_health_bar_left_bound setshader(#"black", 4, 21);
  }

  if(!isDefined(self.var_d5b6872a.debug_health_bar_right_bound)) {
    self.var_d5b6872a.debug_health_bar_right_bound = newdebughudelem(self);
    self.var_d5b6872a.debug_health_bar_right_bound.alignx = "<dev string:x68>";
    self.var_d5b6872a.debug_health_bar_right_bound.aligny = "<dev string:x71>";
    self.var_d5b6872a.debug_health_bar_right_bound.x = self.var_d5b6872a.rbound;
    self.var_d5b6872a.debug_health_bar_right_bound.y = self.var_d5b6872a.ypos;
    self.var_d5b6872a.debug_health_bar_right_bound.sort = 2;
    self.var_d5b6872a.debug_health_bar_right_bound.alpha = 1;
    self.var_d5b6872a.debug_health_bar_right_bound.foreground = 1;
    self.var_d5b6872a.debug_health_bar_right_bound setshader(#"black", 4, 21);
  }

  if(!isDefined(self.var_d5b6872a.debug_health_bar_0_top)) {
    self.var_d5b6872a.debug_health_bar_0_top = newdebughudelem(self);
    self.var_d5b6872a.debug_health_bar_0_top.alignx = "<dev string:x68>";
    self.var_d5b6872a.debug_health_bar_0_top.aligny = "<dev string:x71>";
    self.var_d5b6872a.debug_health_bar_0_top.x = self.var_d5b6872a.lbound + level.friendlyfirepoints[#"min_participation"] * -1 / self.var_d5b6872a.fullpts * self.var_d5b6872a.bar_width;
    self.var_d5b6872a.debug_health_bar_0_top.y = self.var_d5b6872a.ypos + 9;
    self.var_d5b6872a.debug_health_bar_0_top.sort = 2;
    self.var_d5b6872a.debug_health_bar_0_top.alpha = 1;
    self.var_d5b6872a.debug_health_bar_0_top.foreground = 1;
    self.var_d5b6872a.debug_health_bar_0_top setshader(#"black", 4, 4);
  }

  if(!isDefined(self.var_d5b6872a.debug_health_bar_0_bottom)) {
    self.var_d5b6872a.debug_health_bar_0_bottom = newdebughudelem(self);
    self.var_d5b6872a.debug_health_bar_0_bottom.alignx = "<dev string:x68>";
    self.var_d5b6872a.debug_health_bar_0_bottom.aligny = "<dev string:x71>";
    self.var_d5b6872a.debug_health_bar_0_bottom.x = self.var_d5b6872a.lbound + level.friendlyfirepoints[#"min_participation"] * -1 / self.var_d5b6872a.fullpts * self.var_d5b6872a.bar_width;
    self.var_d5b6872a.debug_health_bar_0_bottom.y = self.var_d5b6872a.ypos - 9;
    self.var_d5b6872a.debug_health_bar_0_bottom.sort = 2;
    self.var_d5b6872a.debug_health_bar_0_bottom.alpha = 1;
    self.var_d5b6872a.debug_health_bar_0_bottom.foreground = 1;
    self.var_d5b6872a.debug_health_bar_0_bottom setshader(#"black", 4, 4);
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
      self.var_d5b6872a.friendly_fire_lower_bound_label.alpha = 1;
      self.var_d5b6872a.friendly_fire_upper_bound_label.alpha = 1;
      self.var_d5b6872a.debug_health_bar_bg.alpha = 1;
      self.var_d5b6872a.debug_health_bar.alpha = 1;
      self.var_d5b6872a.debug_health_bar_left_bound.alpha = 1;
      self.var_d5b6872a.debug_health_bar_right_bound.alpha = 1;
      self.var_d5b6872a.debug_health_bar_0_top.alpha = 1;
      self.var_d5b6872a.debug_health_bar_0_bottom.alpha = 1;
    } else {
      self.var_d5b6872a.friendly_fire.alpha = 0;
      self.var_d5b6872a.friendly_fire_lower_bound_label.alpha = 0;
      self.var_d5b6872a.friendly_fire_upper_bound_label.alpha = 0;
      self.var_d5b6872a.debug_health_bar_bg.alpha = 0;
      self.var_d5b6872a.debug_health_bar.alpha = 0;
      self.var_d5b6872a.debug_health_bar_left_bound.alpha = 0;
      self.var_d5b6872a.debug_health_bar_right_bound.alpha = 0;
      self.var_d5b6872a.debug_health_bar_0_top.alpha = 0;
      self.var_d5b6872a.debug_health_bar_0_bottom.alpha = 0;
    }

    xpos = (level.friendlyfirepoints[#"max_participation"] - self.participation) / self.var_d5b6872a.fullpts * self.var_d5b6872a.bar_width;
    self.var_d5b6872a.debug_health_bar.x = self.var_d5b6872a.rbound - xpos;
    self.var_d5b6872a.friendly_fire setvalue(self.participation);
    self.var_d5b6872a.friendly_fire.x = self.var_d5b6872a.rbound - self.var_d5b6872a.bar_width * level.friendlyfirepoints[#"max_participation"] / self.var_d5b6872a.fullpts + (ceil(max(log(abs(self.participation)) / log(10), 0)) + 1 + (self.participation < 0)) * self.var_d5b6872a.friendly_fire.fontscale * 2;
    wait 0.25;
  }
}

function check_warlord_killed(entity) {
  if(entity.archetype === "warlord_soldier") {
    return (entity.shieldhealth <= 0);
  }

  return false;
}

function friendly_fire_callback(entity, damage, attacker, method, weapon, einflictor) {
  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(entity.team)) {
    entity.team = #"allies";
  }

  if(!isDefined(entity)) {
    return;
  }

  warlord_was_killed = check_warlord_killed(entity);

  if(entity.health <= 0) {
    if(!warlord_was_killed) {
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

  if(weapon.name === #"eq_flash_grenade" || weapon.name === #"land_mine_cp") {
    return;
  }

  if(isDefined(einflictor) && einflictor.classname === "grenade" && is_true(einflictor.var_ec078486)) {
    return;
  }

  bplayersdamage = 0;

  if(isPlayer(attacker)) {
    bplayersdamage = 1;
  } else if(isDefined(attacker.classname) && attacker.classname == "script_vehicle") {
    owner = attacker getvehicleowner();

    if(isDefined(owner)) {
      if(isPlayer(owner)) {
        if(!isDefined(owner.friendlyfire_attacker_not_vehicle_owner)) {
          bplayersdamage = 1;
          attacker = owner;
        }
      }
    }
  }

  if(!bplayersdamage) {
    return;
  }

  same_team = entity.team == attacker.team;

  if(attacker.team == #"allies") {
    if(entity.team == #"neutral" && !is_true(level.ignoreneutralfriendlyfire)) {
      same_team = 1;
    }
  }

  same_team |= util::function_9b7092ef(entity.team, attacker.team);

  if(entity.team != #"neutral" || entity.team == #"neutral" && !is_true(level.ignoreneutralfriendlyfire)) {
    attacker.last_hit_team = entity.team;
  }

  killed = damage >= entity.health || warlord_was_killed;

  if(!entity.allowdeath && !check_grenade(entity, method)) {
    killed = 0;
  }

  if(!same_team) {
    if(killed) {
      attacker.participation += level.friendlyfirepoints[#"enemy_kill_points"];
      attacker participation_point_cap();
      debug_log("Enemy killed: +" + level.friendlyfirepoints[#"enemy_kill_points"]);
    }

    return;
  }

  if(isDefined(entity.no_friendly_fire_penalty)) {
    return;
  }

  if((isDefined(attacker.participation) ? attacker.participation : 0) > 0) {
    attacker.participation = 0;
  }

  if(killed) {
    if(entity.archetype === #"civilian" || entity.team == #"neutral") {
      level notify(#"player_killed_civ");
      attacker.participation += level.friendlyfirepoints[#"civ_kill_points"];
      debug_log("Civilian killed: -" + 0 - level.friendlyfirepoints[#"civ_kill_points"]);
    } else if(isDefined(entity) && isDefined(entity.ff_kill_penalty)) {
      attacker.participation += entity.ff_kill_penalty;
      debug_log("Friendly killed with custom penalty: -" + 0 - entity.ff_kill_penalty);
    } else {
      attacker.participation += level.friendlyfirepoints[#"friend_kill_points"];
      debug_log("Friendly killed: -" + 0 - level.friendlyfirepoints[#"friend_kill_points"]);
    }
  } else {
    attacker.participation -= 1;
    debug_log("Friendly hurt: -" + damage);
  }

  attacker participation_point_cap();

  if(check_grenade(entity, method) && savecommit_aftergrenade()) {
    return;
  }

  attacker friendly_fire_checkpoints();
}

function friendly_fire_think(entity) {
  level endon(#"hash_fef7dac2cb38596");
  entity endon(#"no_friendly_fire");

  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(entity.team)) {
    entity.team = #"allies";
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

    bplayersdamage = 0;

    if(isPlayer(attacker)) {
      bplayersdamage = 1;
    } else if(isDefined(attacker.classname) && attacker.classname == "script_vehicle") {
      owner = attacker getvehicleowner();

      if(isDefined(owner)) {
        if(isPlayer(owner)) {
          if(!isDefined(owner.friendlyfire_attacker_not_vehicle_owner)) {
            bplayersdamage = 1;
            attacker = owner;
          }
        }
      }
    }

    if(!bplayersdamage) {
      continue;
    }

    same_team = entity.team == attacker.team;

    if(attacker.team == #"allies") {
      if(entity.team == #"neutral" && !is_true(level.ignoreneutralfriendlyfire)) {
        same_team = 1;
      }
    }

    same_team |= util::function_9b7092ef(entity.team, attacker.team);

    if(entity.team != #"neutral" || entity.team == #"neutral" && !is_true(level.ignoreneutralfriendlyfire)) {
      attacker.last_hit_team = entity.team;
    }

    killed = damage >= entity.health;

    if(!entity.allowdeath && !check_grenade(entity, method)) {
      killed = 0;
    }

    if(!same_team) {
      if(killed) {
        attacker.participation += level.friendlyfirepoints[#"enemy_kill_points"];
        attacker participation_point_cap();
        debug_log("Enemy killed: +" + level.friendlyfirepoints[#"enemy_kill_points"]);
      }

      return;
    }

    if(isDefined(entity.no_friendly_fire_penalty)) {
      continue;
    }

    if((isDefined(attacker.participation) ? attacker.participation : 0) > 0) {
      attacker.participation = 0;
    }

    if(killed) {
      if(entity.archetype === #"civilian" || entity.team == #"neutral") {
        level notify(#"player_killed_civ");

        if(attacker.participation <= 0) {
          attacker.participation += level.friendlyfirepoints[#"min_participation"];
          debug_log("Civilian killed with negative score, autofail!");
        } else {
          attacker.participation += level.friendlyfirepoints[#"civ_kill_points"];
          debug_log("Civilian killed: -" + 0 - level.friendlyfirepoints[#"civ_kill_points"]);
        }
      } else if(isDefined(entity) && isDefined(entity.ff_kill_penalty)) {
        attacker.participation += entity.ff_kill_penalty;
        debug_log("Friendly killed with custom penalty: -" + 0 - entity.ff_kill_penalty);
      } else {
        attacker.participation += level.friendlyfirepoints[#"friend_kill_points"];
        debug_log("Friendly killed: -" + 0 - level.friendlyfirepoints[#"friend_kill_points"]);
      }
    } else {
      attacker.participation -= 1;
      debug_log("Friendly hurt: -" + damage);
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
  if(self.participation <= level.friendlyfirepoints[#"min_participation"]) {
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

  if(self.participation > level.friendlyfirepoints[#"max_participation"]) {
    self.participation = level.friendlyfirepoints[#"max_participation"];
  }

  if(self.participation < level.friendlyfirepoints[#"min_participation"]) {
    self.participation = level.friendlyfirepoints[#"min_participation"];
  }
}

function participation_point_flattenovertime() {
  level endon(#"friendly_fire_terminate");
  self endon(#"disconnect");

  for(;;) {
    if(self.participation > 0) {
      self.participation--;
    }

    wait level.friendlyfirepoints[#"point_loss_interval"];
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

  if(self.last_hit_team === #"neutral") {
    util::missionfailedwrapper_nodeath(#"hash_293687c2ffb1b911", #"hash_7d45646726cd7f74");
    return;
  }

  util::missionfailedwrapper_nodeath(#"hash_23aab5a843404b78", #"hash_7d45646726cd7f74");
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