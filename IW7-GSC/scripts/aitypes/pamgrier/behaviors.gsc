/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\pamgrier\behaviors.gsc
**************************************************/

init(param_00) {
  setupbtstates();
  self.desiredaction = undefined;
  self.lastenemysighttime = 0;
  self.lastenemyengagetime = 0;
  self.myenemy = undefined;
  self.myenemystarttime = 0;
  self.last_health = self.health;
  self.needtochilltime = undefined;
  self.numteleportattacks = 0;
  var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  self.nextattacktime = gettime() + var_01.max_time_between_attacks;
  self.nextrevivetime = gettime() + var_01.min_time_between_revivals;
  return level.success;
}

setupaction(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.fnbegin = param_01;
  var_04.fntick = param_02;
  var_04.fnend = param_03;
  if(!isDefined(self.actions)) {
    self.actions = [];
  }

  self.actions[param_00] = var_04;
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

updateeveryframe(param_00) {
  var_01 = updateenemy();
  if(isDefined(var_01)) {
    if(self getpersstat(var_01)) {
      self.lastenemysighttime = gettime();
      self.setignoremegroup = var_01.origin;
      if(!isDefined(self.enemyreacquiredtime)) {
        self.enemyreacquiredtime = self.lastenemysighttime;
      }
    } else {
      self.enemyreacquiredtime = undefined;
    }
  } else {
    self.lastenemysighttime = 0;
    self.setignoremegroup = undefined;
    self.enemyreacquiredtime = undefined;
  }

  return level.failure;
}

getcurrentdesiredaction(param_00) {
  return self.var_3135.instancedata[param_00].desiredaction;
}

findnearbypamtarget() {
  var_00 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_01 = [];
  foreach(var_03 in var_00.target_agent_types) {
    var_04 = scripts\mp\mp_agent::getactiveagentsoftype(var_03);
    var_01 = scripts\engine\utility::array_combine(var_01, var_04);
  }

  if(!isDefined(var_01) || var_01.size == 0) {
    return undefined;
  }

  var_06 = undefined;
  var_07 = 0;
  foreach(var_09 in var_01) {
    var_0A = distancesquared(var_09.origin, self.origin);
    if(var_0A > var_00.melee_attack_range_sq) {
      continue;
    }

    if(!isalive(var_09)) {
      continue;
    }

    if(!isDefined(var_06)) {
      var_06 = var_09;
      var_07 = var_0A;
      continue;
    }

    if(var_0A < var_07) {
      var_06 = var_09;
      var_07 = var_0A;
    }
  }

  if(!isDefined(var_06)) {
    return undefined;
  }

  return var_06;
}

teleporttargetcompare(param_00, param_01) {
  var_02 = distance2dsquared(self.origin, param_00.origin);
  var_03 = distance2dsquared(self.origin, param_01.origin);
  return var_02 < var_03;
}

shoultryteleportattack() {
  return level.pam_grier_toggles["teleport_attack"];
}

findpamteleporttarget(param_00) {
  var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_02 = [];
  foreach(var_04 in var_01.target_agent_types) {
    var_05 = scripts\mp\mp_agent::getactiveagentsoftype(var_04);
    var_02 = scripts\engine\utility::array_combine(var_02, var_05);
  }

  if(!isDefined(var_02) || var_02.size == 0) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00)) {
    var_02 = scripts\engine\utility::array_randomize(var_02);
  } else {
    var_02 = scripts\engine\utility::array_sort_with_func(var_02, ::teleporttargetcompare);
  }

  foreach(var_08 in var_02) {
    if(!isalive(var_08)) {
      continue;
    }

    if(scripts\engine\utility::istrue(param_00) && isDefined(var_08.vehicle_getspawnerarray)) {
      if(scripts\engine\utility::istrue(var_08.bneedtoenterplayspace)) {
        continue;
      }

      var_09 = var_08 pathdisttogoal();
      if(var_09 < var_01.min_target_path_dist_to_goal) {
        continue;
      }

      var_0A = var_08 getposonpath(var_01.teleport_attack_dist_to_target);
    } else {
      var_0B = vectornormalize(var_09.origin - self.origin);
      var_0A = var_08.origin - var_0B * var_01.teleport_attack_dist_to_target;
    }

    var_08.bdisableteleport = 1;
    self.pamenemy = var_08;
    self.teleportpos = var_0A;
    self.teleportangles = vectortoangles(var_08.origin - var_0A);
    self.teleportfromchillin = scripts\engine\utility::istrue(param_00);
    return 1;
  }

  return 0;
}

isvalidteleportposition(param_00) {
  if(!isDefined(level.pamvalidteleportpositioncenter)) {
    return 1;
  }

  var_01 = distance2dsquared(level.pamvalidteleportpositioncenter, param_00);
  if(var_01 > level.pamvalidteleportradius * level.pamvalidteleportradius) {
    return 0;
  }

  return 1;
}

shouldtryplayerrevive() {
  return level.pam_grier_toggles["revive_player"];
}

findplayertorevive() {
  var_00 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_01 = sortbydistance(level.players, self.origin);
  foreach(var_03 in var_01) {
    if(!isvalidteleportposition(var_03.origin)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.inlaststand) && !scripts\engine\utility::istrue(var_03.is_being_revived) && !scripts\engine\utility::istrue(var_03.in_afterlife_arcade)) {
      var_04 = anglesToForward(var_03.angles);
      var_05 = anglestoright(var_03.angles);
      var_06 = var_03.origin + var_04 * var_00.revive_forward_offset + var_05 * var_00.revive_right_offset;
      var_07 = var_03.origin - var_06;
      var_08 = vectortoangles(var_07);
      var_08 = (0, var_08[1], 0);
      var_09 = getclosestpointonnavmesh(var_06, self);
      if(abs(var_09[2] - var_06[2]) > var_00.max_revive_snap_z_dist) {
        continue;
      }

      var_0A = distance2dsquared(var_06, var_09);
      if(var_0A > var_00.max_revive_snapp_2d_dist_sq) {
        continue;
      }

      self.reviveplayer = var_03;
      self.revivepos = var_09;
      return 1;
    }
  }

  return 0;
}

wait_begin(param_00) {
  var_01 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
  var_02 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_01.teleporttime = gettime() + var_02.min_wait_time_before_teleport;
  var_01.waitendtime = gettime() + randomintrange(var_02.min_wait_time, var_02.max_wait_time);
}

wait_tick(param_00) {
  var_01 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
  var_02 = gettime();
  self clearpath();
  var_03 = 0;
  if(!isDefined(self.forcenextrevivetime) || var_02 < self.forcenextrevivetime) {
    self.pamenemy = findnearbypamtarget();
    if(isDefined(self.pamenemy)) {
      if(shouldtrymeleeattack() && trymeleeattacks()) {
        return level.failure;
      }

      self.pamenemy = undefined;
    }
  } else {
    self.pamenemy = undefined;
    var_03 = 1;
  }

  if(scripts\engine\utility::istrue(var_03) || var_02 > self.nextrevivetime) {
    if(shouldtryplayerrevive() && findplayertorevive()) {
      self.desiredaction = "revive_player";
      return level.failure;
    } else {
      self.nextrevivetime = var_02 + 1000;
      self.forcenextrevivetime = undefined;
    }
  }

  if(var_02 < var_01.teleporttime) {
    return level.running;
  }

  if(isDefined(self.needtochilltime) && var_02 > self.needtochilltime) {
    self.desiredaction = "return_home";
    return level.failure;
  }

  var_04 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  if(self.numteleportattacks >= var_04.max_teleports_per_chill) {
    self.desiredaction = "return_home";
    return level.failure;
  }

  if(shoultryteleportattack() && findpamteleporttarget()) {
    self.desiredaction = "teleport_attack";
    self.numteleportattacks = self.numteleportattacks + 1;
    var_05 = vectortoangles(self.teleportpos - self.origin);
    self.desiredyaw = var_05[1];
    return level.failure;
  }

  if(var_03 > var_02.waitendtime) {
    self.desiredaction = "return_home";
    return level.failure;
  }

  return level.running;
}

wait_end(param_00) {
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

chillin_begin(param_00) {
  self.bchillin = 1;
  scripts\mp\agents\pamgrier\pamgrier_agent::clearpassive();
  var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  var_02 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
  var_02.endchilltime = gettime() + randomintrange(var_01.min_chillin_time, var_01.max_chillin_time);
  self.numteleportattacks = 0;
}

chillin_tick(param_00) {
  var_01 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
  var_02 = gettime();
  if(var_02 < var_01.endchilltime) {
    return level.running;
  }

  if(var_02 > self.nextrevivetime) {
    if(findplayertorevive()) {
      self.desiredaction = "revive_player";
      return level.success;
    } else {
      self.nextrevivetime = var_02 + 1000;
    }
  }

  if(var_02 > self.nextattacktime) {
    if(shoultryteleportattack() && findpamteleporttarget(1)) {
      self.desiredaction = "teleport_attack";
      return level.success;
    } else {
      self.nextattacktime = var_02 + 500;
    }
  }

  return level.running;
}

chillin_end(param_00) {
  self.bchillin = 0;
  self.needtochilltime = gettime() + scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata().max_non_chillin_time;
}

teleportattack_begin(param_00) {
  requestteleport(self.teleportpos, self.teleportangles, "teleport_attack");
  self clearpath();
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00, "teleport", "teleport_out", ::teleportattack_teleportdone, undefined, undefined, 8000);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00, "teleport");
}

teleportattack_teleportdone(param_00, param_01) {
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

teleportattack_tick(param_00) {
  self clearpath();
  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  self.desiredaction = "wait";
  return level.failure;
  return level.failure;
}

teleportattack_end(param_00) {
  var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  self.nextattacktime = gettime() + randomintrange(var_01.min_time_between_attacks, var_01.max_time_between_attacks);
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
  self.desiredyaw = undefined;
}

reviveplayer_begin(param_00) {
  var_01 = distancesquared(self.reviveplayer.origin, self.origin);
  var_02 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  if(var_01 > var_02.max_dist_to_revive_player_sq) {
    var_03 = self.reviveplayer.origin - self.revivepos;
    var_04 = vectortoangles(var_03);
    var_04 = (0, var_04[1], 0);
    requestteleport(self.revivepos, var_04, "revive_player");
    scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00, "teleport", "teleport_out", ::reviveplayer_teleportdone, undefined, undefined, 8000);
    scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00, "teleport");
    return;
  }

  scripts\asm\pamgrier\pamgrier_asm::setaction("revive_player");
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00, "revive_player", "revive_player_outro", ::reviveplayer_revivedone, undefined, undefined, 8000);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00, "revive_player");
}

reviveplayer_tick(param_00) {
  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

reviveplayer_teleportdone(param_00, param_01) {
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
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00, "revive_player", "revive_player_outro", ::reviveplayer_revivedone, undefined, undefined, 8000);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00, "revive_player");
}

reviveplayer_revivedone(param_00, param_01) {}

reviveplayer_end(param_00) {
  var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  self.disablearrivals = 0;
  self.forcenextrevivetime = undefined;
  if(isDefined(self.reviveplayer)) {
    if(!scripts\engine\utility::istrue(self.reviveplayer.inlaststand)) {
      if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
        self.nextrevivetime = gettime() + var_01.min_time_between_revivals_solo;
      } else {
        self.nextrevivetime = gettime() + var_01.min_time_between_revivals;
      }
    } else {
      self.forcenextrevivetime = gettime() + var_01.max_time_to_attack_targets_when_player_needs_revive_ms;
    }
  } else {
    self.nextrevivetime = gettime() + var_01.min_time_between_revivals;
  }

  self.reviveplayer = undefined;
  self.reviveanimindex = undefined;
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

melee_begin(param_00) {
  var_01 = getcurrentdesiredaction(param_00);
  scripts\asm\pamgrier\pamgrier_asm::setaction(var_01);
  var_02 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
  if(var_01 == "melee_attack") {
    var_03 = var_02 getvelocity();
    var_04 = length2dsquared(var_03);
    if(var_04 < 144) {
      self clearpath();
    } else {
      self.bmovingmelee = 1;
    }
  } else {
    self clearpath();
  }

  self.curmeleetarget = var_02;
  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00, var_01, var_01);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00, var_01);
}

melee_tick(param_00) {
  self clearpath();
  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

melee_end(param_00) {
  self.curmeleetarget = undefined;
  self.bmovingmelee = undefined;
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
  scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
}

requestteleport(param_00, param_01, param_02) {
  self.teleportpos = param_00;
  self.teleportangles = param_01;
  self.teleporttype = param_02;
  scripts\asm\pamgrier\pamgrier_asm::setaction("teleport");
}

returnhome_begin(param_00) {
  if(!isDefined(level.pam_grier_chillin_origins) || level.pam_grier_chillin_origins.size == 0) {
    requestteleport(self.chillinpos, self.chillinangles, "return_home");
  } else {
    var_01 = randomint(level.pam_grier_chillin_origins.size);
    var_02 = vectortoangles(level.pam_grier_chillin_origins[var_01] - self.origin);
    self.desiredyaw = var_02[1];
    requestteleport(level.pam_grier_chillin_origins[var_01], level.pam_grier_chillin_angles[var_01], "return_home");
  }

  scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00, "return_home", "teleport_out", undefined, undefined, undefined, 8000);
  scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00, "return_home");
}

returnhome_tick(param_00) {
  self clearpath();
  if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  self.desiredaction = "chillin";
  return level.failure;
}

returnhome_end(param_00) {
  self.desiredyaw = undefined;
  scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

shouldtrymeleeattack() {
  return level.pam_grier_toggles["melee_attack"];
}

trymeleeattacks(param_00) {
  var_01 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
  if(!isDefined(param_00)) {
    param_00 = distancesquared(self.origin, var_01.origin);
  }

  if(!ispointonnavmesh(var_01.origin)) {
    if(param_00 > self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh) {
      return 0;
    }
  } else if(param_00 > self.meleeradiusbasesq) {
    return 0;
  }

  self.desiredaction = "melee_attack";
  return 1;
}

decideaction(param_00) {
  if(!isDefined(self.needtochilltime)) {
    self.desiredaction = "return_home";
  } else {
    self.desiredaction = "wait";
  }

  return level.success;
}

doaction_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
  self.var_3135.instancedata[param_00].desiredaction = self.desiredaction;
  var_01 = self.actions[self.desiredaction].fnbegin;
  self.desiredaction = undefined;
  if(isDefined(var_01)) {
    [[var_01]](param_00);
  }
}

doaction_tick(param_00) {
  var_01 = getcurrentdesiredaction(param_00);
  var_02 = self.actions[var_01].fntick;
  if(isDefined(var_02)) {
    var_03 = [[var_02]](param_00);
    if(!isDefined(self.desiredaction)) {
      return var_03;
    }
  }

  if(isDefined(self.desiredaction)) {
    doaction_end(param_00);
    doaction_begin(param_00);
    return level.running;
  }

  return level.failure;
}

doaction_end(param_00) {
  var_01 = getcurrentdesiredaction(param_00);
  var_02 = self.actions[var_01].fnend;
  if(isDefined(var_02)) {
    [[var_02]](param_00);
  }

  scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
  self.var_3135.instancedata[param_00] = undefined;
}

followenemy_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
}

followenemy_tick(param_00) {
  return level.success;
}

followenemy_end(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
}