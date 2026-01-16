/**************************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\pamgrier\behaviors.gsc
**************************************************/

init(var_0) {
  setupbtstates();
  self.desiredaction = undefined;
  self.lastenemysighttime = 0;
  self.lastenemyengagetime = 0;
  self.myenemy = undefined;
  self.myenemystarttime = 0;
  self.last_health = self.health;
  self.needtochilltime = undefined;
  self.numteleportattacks = 0;
  var_1 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  self.nextattacktime = gettime() + var_1.max_time_between_attacks;
  self.nextrevivetime = gettime() + var_1.min_time_between_revivals;
  return anim.success;
}

setupaction(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.fnbegin = var_1;
  var_4.fntick = var_2;
  var_4.fnend = var_3;

  if(!isDefined(self.actions)) {
    self.actions = [];
  }

  self.actions[var_0] = var_4;
}

setupbtstates() {
  setupaction("chillin", ::chillin_begin, ::chillin_tick, ::chillin_end);
  setupaction("revive_player", ::reviveplayer_begin, ::reviveplayer_tick, ::reviveplayer_end);
  setupaction("teleport_attack", ::teleportattack_begin, ::teleportattack_tick, ::teleportattack_end);
  setupaction("melee_attack", ::melee_begin, ::melee_tick, ::melee_end);
  setupaction("return_home", ::returnhome_begin, ::returnhome_tick, ::returnhome_end);
  setupaction("wait", ::wait_begin, ::wait_tick, ::wait_end);
}

updateenemy() {
  return scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
}

updateeveryframe(var_0) {
  var_1 = updateenemy();

  if(isDefined(var_1)) {
    if(self cansee(var_1)) {
      self.lastenemysighttime = gettime();
      self.lastenemysightpos = var_1.origin;

      if(!isDefined(self.enemyreacquiredtime)) {
        self.enemyreacquiredtime = self.lastenemysighttime;
      }
    } else {
      self.enemyreacquiredtime = undefined;
    }
  } else {
    self.lastenemysighttime = 0;
    self.lastenemysightpos = undefined;
    self.enemyreacquiredtime = undefined;
  }

  return anim.failure;
}

getcurrentdesiredaction(var_0) {
  return self.bt.instancedata[var_0].desiredaction;
}

findnearbypamtarget() {
  var_0 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_1 = [];

  foreach(var_3 in var_0.target_agent_types) {
    var_4 = scripts\mp\mp_agent::getactiveagentsoftype(var_3);
    var_1 = scripts\engine\utility::array_combine(var_1, var_4);
  }

  if(!isDefined(var_1) || var_1.size == 0) {
    return undefined;
  }

  var_6 = undefined;
  var_7 = 0;

  foreach(var_9 in var_1) {
    var_10 = distancesquared(var_9.origin, self.origin);

    if(var_10 > var_0.melee_attack_range_sq) {
      continue;
    }
    if(!isalive(var_9)) {
      continue;
    }
    if(!isDefined(var_6)) {
      var_6 = var_9;
      var_7 = var_10;
      continue;
    }

    if(var_10 < var_7) {
      var_6 = var_9;
      var_7 = var_10;
    }
  }

  if(!isDefined(var_6)) {
    return undefined;
  }

  return var_6;
}

teleporttargetcompare(var_0, var_1) {
  var_2 = distance2dsquared(self.origin, var_0.origin);
  var_3 = distance2dsquared(self.origin, var_1.origin);
  return var_2 < var_3;
}

shoultryteleportattack() {
  return level.pam_grier_toggles["teleport_attack"];
}

findpamteleporttarget(var_0) {
  var_1 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_2 = [];

  foreach(var_4 in var_1.target_agent_types) {
    var_5 = scripts\mp\mp_agent::getactiveagentsoftype(var_4);
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  if(!isDefined(var_2) || var_2.size == 0) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_0)) {
    var_2 = scripts\engine\utility::array_randomize(var_2);
  } else {
    var_2 = scripts\engine\utility::array_sort_with_func(var_2, ::teleporttargetcompare);
  }

  foreach(var_8 in var_2) {
    if(!isalive(var_8)) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_0) && isDefined(var_8.pathgoalpos)) {
      if(scripts\engine\utility::is_true(var_8.bneedtoenterplayspace)) {
        continue;
      }
      var_9 = var_8 pathdisttogoal();

      if(var_9 < var_1.min_target_path_dist_to_goal) {
        continue;
      }
      var_10 = var_8 getposonpath(var_1.teleport_attack_dist_to_target);
    } else {
      var_11 = vectornormalize(var_8.origin - self.origin);
      var_10 = var_8.origin - var_11 * var_1.teleport_attack_dist_to_target;
    }

    var_8.bdisableteleport = 1;
    self.pamenemy = var_8;
    self.teleportpos = var_10;
    self.teleportangles = vectortoangles(var_8.origin - var_10);
    self.teleportfromchillin = scripts\engine\utility::is_true(var_0);
    return 1;
  }

  return 0;
}

isvalidteleportposition(var_0) {
  if(!isDefined(level.pamvalidteleportpositioncenter)) {
    return 1;
  }

  var_1 = distance2dsquared(level.pamvalidteleportpositioncenter, var_0);

  if(var_1 > level.pamvalidteleportradius * level.pamvalidteleportradius) {
    return 0;
  }

  return 1;
}

shouldtryplayerrevive() {
  return level.pam_grier_toggles["revive_player"];
}

findplayertorevive() {
  var_0 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_1 = sortbydistance(level.players, self.origin);

  foreach(var_3 in var_1) {
    if(!isvalidteleportposition(var_3.origin)) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_3.inlaststand) && !scripts\engine\utility::is_true(var_3.is_being_revived) && !scripts\engine\utility::is_true(var_3.in_afterlife_arcade)) {
      var_4 = anglesToForward(var_3.angles);
      var_5 = anglestoright(var_3.angles);
      var_6 = var_3.origin + var_4 * var_0.revive_forward_offset + var_5 * var_0.revive_right_offset;
      var_7 = var_3.origin - var_6;
      var_8 = vectortoangles(var_7);
      var_8 = (0, var_8[1], 0);
      var_9 = getclosestpointonnavmesh(var_6, self);

      if(abs(var_9[2] - var_6[2]) > var_0.max_revive_snap_z_dist) {
        continue;
      }
      var_10 = distance2dsquared(var_6, var_9);

      if(var_10 > var_0.max_revive_snapp_2d_dist_sq) {
        continue;
      }
      self.reviveplayer = var_3;
      self.revivepos = var_9;
      return 1;
    }
  }

  return 0;
}

wait_begin(var_0) {
  var_1 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(var_0);
  var_2 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_1.teleporttime = gettime() + var_2.min_wait_time_before_teleport;
  var_1.waitendtime = gettime() + randomintrange(var_2.min_wait_time, var_2.max_wait_time);
}

wait_tick(var_0) {
  var_1 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(var_0);
  var_2 = gettime();
  self clearpath();
  var_3 = 0;

  if(!isDefined(self.forcenextrevivetime) || var_2 < self.forcenextrevivetime) {
    self.pamenemy = findnearbypamtarget();

    if(isDefined(self.pamenemy)) {
      if(shouldtrymeleeattack() && trymeleeattacks()) {
        return anim.failure;
      }

      self.pamenemy = undefined;
    }
  } else {
    self.pamenemy = undefined;
    var_3 = 1;
  }

  if(scripts\engine\utility::is_true(var_3) || var_2 > self.nextrevivetime) {
    if(shouldtryplayerrevive() && findplayertorevive()) {
      self.desiredaction = "revive_player";
      return anim.failure;
    } else {
      self.nextrevivetime = var_2 + 1000;
      self.forcenextrevivetime = undefined;
    }
  }

  if(var_2 < var_1.teleporttime) {
    return anim.running;
  }

  if(isDefined(self.needtochilltime) && var_2 > self.needtochilltime) {
    self.desiredaction = "return_home";
    return anim.failure;
  }

  var_4 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();

  if(self.numteleportattacks >= var_4.max_teleports_per_chill) {
    self.desiredaction = "return_home";
    return anim.failure;
  }

  if(shoultryteleportattack() && findpamteleporttarget()) {
    self.desiredaction = "teleport_attack";
    self.numteleportattacks = self.numteleportattacks + 1;
    var_5 = vectortoangles(self.teleportpos - self.origin);
    self.desiredyaw = var_5[1];
    return anim.failure;
  }

  if(var_2 > var_1.waitendtime) {
    self.desiredaction = "return_home";
    return anim.failure;
  }

  return anim.running;
}

wait_end(var_0) {
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(var_0);
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

chillin_begin(var_0) {
  self.bchillin = 1;
  scripts\mp\agents\pamgrier\pamgrier_agent::clearpassive();
  var_1 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_2 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(var_0);
  var_2.endchilltime = gettime() + randomintrange(var_1.min_chillin_time, var_1.max_chillin_time);
  self.numteleportattacks = 0;
}

chillin_tick(var_0) {
  var_1 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(var_0);
  var_2 = gettime();

  if(var_2 < var_1.endchilltime) {
    return anim.running;
  }

  if(var_2 > self.nextrevivetime) {
    if(findplayertorevive()) {
      self.desiredaction = "revive_player";
      return anim.success;
    } else {
      self.nextrevivetime = var_2 + 1000;
    }
  }

  if(var_2 > self.nextattacktime) {
    if(shoultryteleportattack() && findpamteleporttarget(1)) {
      self.desiredaction = "teleport_attack";
      return anim.success;
    } else {
      self.nextattacktime = var_2 + 500;
    }
  }

  return anim.running;
}

chillin_end(var_0) {
  self.bchillin = 0;
  self.needtochilltime = gettime() + scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata().max_non_chillin_time;
}

teleportattack_begin(var_0) {
  requestteleport(self.teleportpos, self.teleportangles, "teleport_attack");
  self clearpath();
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "teleport", "teleport_out", ::teleportattack_teleportdone, undefined, undefined, 8000);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "teleport");
}

teleportattack_teleportdone(var_0, var_1) {
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

teleportattack_tick(var_0) {
  self clearpath();

  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  self.desiredaction = "wait";
  return anim.failure;
  return anim.failure;
}

teleportattack_end(var_0) {
  var_1 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  self.nextattacktime = gettime() + randomintrange(var_1.min_time_between_attacks, var_1.max_time_between_attacks);
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(var_0);
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
  self.desiredyaw = undefined;
}

reviveplayer_begin(var_0) {
  var_1 = distancesquared(self.reviveplayer.origin, self.origin);
  var_2 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();

  if(var_1 > var_2.max_dist_to_revive_player_sq) {
    var_3 = self.reviveplayer.origin - self.revivepos;
    var_4 = vectortoangles(var_3);
    var_4 = (0, var_4[1], 0);
    requestteleport(self.revivepos, var_4, "revive_player");
    scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "teleport", "teleport_out", ::reviveplayer_teleportdone, undefined, undefined, 8000);
    scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "teleport");
  } else {
    scripts\asm\pamgrier\pamgrier_asm::setaction("revive_player");
    scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "revive_player", "revive_player_outro", ::reviveplayer_revivedone, undefined, undefined, 8000);
    scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "revive_player");
  }
}

reviveplayer_tick(var_0) {
  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

reviveplayer_teleportdone(var_0, var_1) {
  if(isDefined(self.forcenextrevivetime) && gettime() > self.forcenextrevivetime) {
    self.pamenemy = undefined;
    self.forcenextrevivetime = undefined;
  } else {
    self.pamenemy = findnearbypamtarget();

    if(isDefined(self.pamenemy)) {
      if(trymeleeattacks()) {
        return;
      }
    }
  }

  scripts\asm\pamgrier\pamgrier_asm::setaction("revive_player");
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "revive_player", "revive_player_outro", ::reviveplayer_revivedone, undefined, undefined, 8000);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "revive_player");
}

reviveplayer_revivedone(var_0, var_1) {}

reviveplayer_end(var_0) {
  var_1 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  self.disablearrivals = 0;
  self.forcenextrevivetime = undefined;

  if(isDefined(self.reviveplayer)) {
    if(!scripts\engine\utility::is_true(self.reviveplayer.inlaststand)) {
      if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::is_true(level.only_one_player)) {
        self.nextrevivetime = gettime() + var_1.min_time_between_revivals_solo;
      } else {
        self.nextrevivetime = gettime() + var_1.min_time_between_revivals;
      }
    } else {
      self.forcenextrevivetime = gettime() + var_1.max_time_to_attack_targets_when_player_needs_revive_ms;
    }
  } else {
    self.nextrevivetime = gettime() + var_1.min_time_between_revivals;
  }

  self.reviveplayer = undefined;
  self.reviveanimindex = undefined;
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(var_0);
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

melee_begin(var_0) {
  var_1 = getcurrentdesiredaction(var_0);
  scripts\asm\pamgrier\pamgrier_asm::setaction(var_1);
  var_2 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();

  if(var_1 == "melee_attack") {
    var_3 = var_2 getvelocity();
    var_4 = length2dsquared(var_3);

    if(var_4 < 144) {
      self clearpath();
    } else {
      self.bmovingmelee = 1;
    }
  } else {
    self clearpath();
  }

  self.curmeleetarget = var_2;
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, var_1, var_1);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, var_1);
}

melee_tick(var_0) {
  self clearpath();

  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  return anim.failure;
}

melee_end(var_0) {
  self.curmeleetarget = undefined;
  self.bmovingmelee = undefined;
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(var_0);
}

requestteleport(var_0, var_1, var_2) {
  self.teleportpos = var_0;
  self.teleportangles = var_1;
  self.teleporttype = var_2;
  scripts\asm\pamgrier\pamgrier_asm::setaction("teleport");
}

returnhome_begin(var_0) {
  if(!isDefined(level.pam_grier_chillin_origins) || level.pam_grier_chillin_origins.size == 0) {
    requestteleport(self.chillinpos, self.chillinangles, "return_home");
  } else {
    var_1 = randomint(level.pam_grier_chillin_origins.size);
    var_2 = vectortoangles(level.pam_grier_chillin_origins[var_1] - self.origin);
    self.desiredyaw = var_2[1];
    requestteleport(level.pam_grier_chillin_origins[var_1], level.pam_grier_chillin_angles[var_1], "return_home");
  }

  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(var_0, "return_home", "teleport_out", undefined, undefined, undefined, 8000);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(var_0, "return_home");
}

returnhome_tick(var_0) {
  self clearpath();

  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(var_0)) {
    return anim.running;
  }

  self.desiredaction = "chillin";
  return anim.failure;
}

returnhome_end(var_0) {
  self.desiredyaw = undefined;
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

shouldtrymeleeattack() {
  return level.pam_grier_toggles["melee_attack"];
}

trymeleeattacks(var_0) {
  var_1 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();

  if(!isDefined(var_0)) {
    var_0 = distancesquared(self.origin, var_1.origin);
  }

  if(!ispointonnavmesh(var_1.origin)) {
    if(var_0 > self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh) {
      return 0;
    }
  } else if(var_0 > self.meleeradiusbasesq) {
    return 0;
  }

  self.desiredaction = "melee_attack";
  return 1;
}

decideaction(var_0) {
  if(!isDefined(self.needtochilltime)) {
    self.desiredaction = "return_home";
  } else {
    self.desiredaction = "wait";
  }

  return anim.success;
}

doaction_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].desiredaction = self.desiredaction;
  var_1 = self.actions[self.desiredaction].fnbegin;
  self.desiredaction = undefined;

  if(isDefined(var_1)) {
    [[var_1]](var_0);
  }
}

doaction_tick(var_0) {
  var_1 = getcurrentdesiredaction(var_0);
  var_2 = self.actions[var_1].fntick;

  if(isDefined(var_2)) {
    var_3 = [[var_2]](var_0);

    if(!isDefined(self.desiredaction)) {
      return var_3;
    }
  }

  if(isDefined(self.desiredaction)) {
    doaction_end(var_0);
    doaction_begin(var_0);
    return anim.running;
  }

  return anim.failure;
}

doaction_end(var_0) {
  var_1 = getcurrentdesiredaction(var_0);
  var_2 = self.actions[var_1].fnend;

  if(isDefined(var_2)) {
    [[var_2]](var_0);
  }

  scripts\aitypes\ratking\bt_state_api::btstate_endstates(var_0);
  self.bt.instancedata[var_0] = undefined;
}

followenemy_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
}

followenemy_tick(var_0) {
  return anim.success;
}

followenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}