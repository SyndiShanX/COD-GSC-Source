/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\elvira\behaviors.gsc
************************************************/

init(var_0) {
  setupbtstates();
  var_1 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  self.desiredaction = undefined;
  self.lastenemysighttime = 0;
  self.lastenemyengagetime = 0;
  self.lastenemytime = 0;
  self.myenemy = undefined;
  self.myenemystarttime = 0;
  self.last_health = self.health;
  self.return_home_time = gettime() + var_1.lifespan;
  return level.success;
}

setupbtstates() {
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("combat", ::combat_begin, ::combat_tick, ::combat_end);
  scripts\aitypes\dlc3\bt_state_api::btstate_setupstate("acquire", ::acquire_begin, ::acquire_tick, ::acquire_end);
  scripts\aitypes\dlc3\bt_state_api::btstate_setupstate("backpedal", ::backpedal_begin, ::backpedal_tick, ::backpedal_end);
  scripts\aitypes\dlc3\bt_state_api::btstate_setupstate("reload", ::reload_begin, ::reload_tick, ::reload_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("idle", ::idle_begin, ::idle_tick, ::idle_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("melee_attack", ::melee_begin, ::melee_tick, ::melee_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("revive_player", ::reviveplayer_begin, ::reviveplayer_tick, ::reviveplayer_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("rejoin_player", ::rejoinplayer_begin, ::rejoinplayer_tick, ::rejoinplayer_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("reveal_anomaly", ::revealanomaly_begin, ::revealanomaly_tick, ::revealanomaly_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("return_home", ::returnhome_begin, ::returnhome_tick, ::returnhome_end);
  scripts\aitypes\dlc3\bt_action_api::setupbtaction("cast_spell", ::castspell_begin, ::castspell_tick, ::castspell_end);
}

aimattarget() {
  self.doentitiessharehierarchy = undefined;
  if(!isDefined(self.fncustomtargetingfunc) || !isDefined(self.nexttargetchangetime) || gettime() > self.nexttargetchangetime) {
    self.fncustomtargetingfunc = scripts\mp\agents\elvira\elvira_agent::picktargetingfunction();
    self.nexttargetchangetime = gettime() + randomintrange(1500, 2500);
  }

  if(isDefined(self.fncustomtargetingfunc)) {
    var_0 = self[[self.fncustomtargetingfunc]]();
    if(!self canshoot(var_0)) {
      var_0 = scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos();
    }
  } else {
    var_0 = scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos();
  }

  self.setplayerignoreradiusdamage = var_0;
}

shootattarget() {
  var_0 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = self.bt.shootparams;
  var_1.objective = "normal";
  self.doentitiessharehierarchy = undefined;
  var_1.pos = self.setplayerignoreradiusdamage;
  var_1.ent = undefined;
  scripts\asm\asm_bb::bb_setshootparams(var_1, undefined);
  if(scripts\aitypes\combat::isaimedataimtarget()) {
    if(!scripts\engine\utility::istrue(self.bt.m_bfiring)) {
      scripts\aitypes\combat::resetmisstime_code();
      scripts\aitypes\combat::chooseshootstyle(var_1);
      scripts\aitypes\combat::choosenumshotsandbursts(var_1);
    }

    var_1.objective = "normal";
    self.bt.m_bfiring = 1;
  } else {
    self.bt.m_bfiring = 0;
  }

  if(!isDefined(var_1.pos) && !isDefined(var_1.ent)) {
    return 0;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return self.bt.m_bfiring;
}

stopshootingattarget() {
  self.bt.m_bfiring = 0;
  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
}

updateenemy() {
  return scripts\mp\agents\elvira\elvira_agent::getenemy();
}

checkforearlyteleport(var_0) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_1 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_2 = self pathdisttogoal();
  if(var_2 > var_1.max_teleport_lookahead_dist) {
    var_2 = var_1.max_teleport_lookahead_dist;
  }

  if(scripts\asm\asm::asm_isinstate("traverse_external")) {
    return 0;
  }

  var_3 = self _meth_84F9(var_2);
  if(!isDefined(var_3)) {
    return 0;
  }

  var_4 = var_3["node"];
  var_5 = var_3["position"];
  var_6 = var_4.opcode::OP_ScriptMethodCallPointer;
  if(!isDefined(var_6)) {
    return 0;
  }

  var_7 = self.asmname;
  var_8 = level.asm[var_7];
  var_9 = var_8.states[var_6];
  if(!isDefined(var_9)) {
    var_6 = "traverse_external";
  }

  if(var_6 == "traverse_external") {
    self.earlytraversalteleportpos = var_5;
    scripts\asm\asm::asm_setstate("traverse_external");
    return 1;
  }

  return 0;
}

updateeveryframe(var_0) {
  var_1 = updateenemy();
  if(isDefined(var_1)) {
    self.lastenemytime = gettime();
    if(self getpersstat(var_1)) {
      self.lastenemysighttime = gettime();
      self.setignoremegroup = var_1.origin;
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

decidemovetype(var_0, var_1) {
  var_2 = gettime();
  var_3 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(self.last_enemy_sight_time < 0 || var_2 - self.last_enemy_sight_time < var_3.maxtimetostrafewithoutlos) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
    return;
  }

  if(var_1 < var_3.strafeifwithindist) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
    return;
  }

  if(!var_0) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_facemotion();
    return;
  }

  scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
}

idle_begin(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.idle_start_time = gettime();
}

idle_tick(var_0) {
  self clearpath();
  if(trycastspell(var_0)) {
    return level.success;
  }

  if(tryrevealanomaly(var_0)) {
    return level.success;
  }

  if(tryreturnhome(var_0)) {
    return level.success;
  }

  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  if(tryreviveplayer(var_0)) {
    return level.success;
  }

  if(tryreturntoclosestplayer(var_0)) {
    return level.success;
  }

  var_1 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_1)) {
    var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
    if(gettime() > var_2.idle_start_time + 250) {
      if(self.bulletsinclip < weaponclipsize(self.var_394) * 0.75) {
        doreloadstate(var_0);
      }
    }

    return level.running;
  }

  if(shouldtrymeleeattack() && trymeleeattacks(var_1)) {
    return level.success;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_1, "combat");
  return level.running;
}

idle_end(var_0) {}

setgoaltoreviveplayer(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = anglestoright(var_0.angles);
  var_4 = var_0.origin + var_2 * var_1.revive_forward_offset + var_3 * var_1.revive_right_offset;
  var_5 = var_0.origin - var_4;
  var_6 = vectortoangles(var_5);
  var_6 = (0, var_6[1], 0);
  var_7 = getclosestpointonnavmesh(var_4, self);
  self ghostskulls_complete_status(var_7);
}

reviveplayer_begin(var_0, var_1) {
  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2.brevivedone = undefined;
  self.disablearrivals = 0;
  self.ignoreme = 1;
  self.bt.shootparams = spawnStruct();
  self.bt.shootparams.taskid = var_0;
  self.bt.shootparams.starttime = gettime();
}

reviveplayer_tick(var_0) {
  var_1 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_1) && gettime() - self.lastenemytime > 500) {
    checkforearlyteleport();
  }

  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  if(!isDefined(self.reviveplayer) || !scripts\engine\utility::istrue(self.reviveplayer.inlaststand)) {
    return level.success;
  }

  var_2 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  setgoaltoreviveplayer(self.reviveplayer, var_2);
  var_3 = distance2dsquared(self.reviveplayer.origin, self.origin);
  if(var_3 < var_2.max_dist_to_revive_player_sq) {
    stopshootingattarget();
    scripts\asm\elvira\elvira_asm::setaction("revive_player");
    scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "revive_player", "revive_player_intro", ::reviveplayer_revivedone, undefined, undefined, 8000);
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "revive_player");
  } else {
    var_1 = scripts\mp\agents\elvira\elvira_agent::getenemy();
    if(isDefined(var_1)) {
      var_4 = 1;
      var_5 = self getpersstat(var_1);
      if(var_5) {
        var_4 = self canshoot(scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos());
      }

      if(var_4) {
        scripts\asm\asm_bb::bb_setisincombat(1);
        scripts\asm\asm_bb::bb_requestmovetype("combat");
        self.bulletsinclip = weaponclipsize(self.var_394);
        aimattarget();
        shootattarget();
      } else {
        scripts\asm\asm_bb::bb_setisincombat(0);
        scripts\asm\asm_bb::bb_requestmovetype("run");
        stopshootingattarget();
      }
    } else {
      scripts\asm\asm_bb::bb_setisincombat(0);
      scripts\asm\asm_bb::bb_requestmovetype("run");
      stopshootingattarget();
    }
  }

  return level.running;
}

reviveplayer_end(var_0, var_1) {
  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2.brevivedone = undefined;
  stopshootingattarget();
  var_3 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  self.disablearrivals = 0;
  self.forcenextrevivetime = undefined;
  if(isDefined(self.reviveplayer)) {
    if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
      self.nextrevivetime = gettime() + var_3.min_time_between_revivals_solo;
    } else {
      self.nextrevivetime = gettime() + var_3.min_time_between_revivals;
    }
  } else {
    self.nextrevivetime = gettime() + var_3.min_time_between_revivals;
  }

  self.reviveplayer = undefined;
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(var_0);
  scripts\asm\elvira\elvira_asm::clearaction();
  self.bt.shootparams = undefined;
}

reviveplayer_revivedone(var_0, var_1) {}

findplayertorevive() {
  var_0 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_1 = sortbydistance(level.players, self.origin);
  foreach(var_3 in var_1) {
    var_4 = distancesquared(self.origin, var_3.origin);
    if(var_4 > var_0.max_revive_search_dist_sq) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.inlaststand) && !scripts\engine\utility::istrue(var_3.is_being_revived) && !scripts\engine\utility::istrue(var_3.in_afterlife_arcade)) {
      return var_3;
    }
  }

  return undefined;
}

reviveplayer(var_0, var_1) {
  self.reviveplayer = var_1;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "revive_player");
}

tryreviveplayer(var_0) {
  if(!scripts\engine\utility::istrue(1)) {
    return 0;
  }

  if(isDefined(self.nextrevivetime)) {
    if(gettime() < self.nextrevivetime) {
      return 0;
    }
  }

  var_1 = findplayertorevive();
  if(!isDefined(var_1)) {
    return 0;
  }

  reviveplayer(var_0, var_1);
  return 1;
}

melee_begin(var_0) {
  self.curmeleetarget = scripts\mp\agents\elvira\elvira_agent::getenemy();
  scripts\asm\elvira\elvira_asm::setaction("melee");
  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "melee", "melee_attack");
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "melee");
}

melee_tick(var_0) {
  self clearpath();
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.failure;
}

melee_end(var_0) {
  self.curmeleetarget = undefined;
  self.bmovingmelee = undefined;
  scripts\asm\elvira\elvira_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(var_0);
  scripts\asm\asm_bb::bb_clearmeleerequest();
}

rejoinplayer_begin(var_0) {
  self.bt.shootparams = spawnStruct();
  self.bt.shootparams.taskid = var_0;
  self.bt.shootparams.starttime = gettime();
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.nextclosestplayerchecktime = gettime() + 1000;
}

rejoinplayer_tick(var_0) {
  var_1 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_1) && gettime() - self.lastenemytime > 500) {
    checkforearlyteleport();
  }

  if(!isDefined(self.rejoinplayer)) {
    return level.failure;
  }

  var_2 = gettime();
  var_3 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  if(var_2 > var_3.nextclosestplayerchecktime) {
    var_3.nextclosestplayerchecktime = var_2 + 1000;
    var_4 = getclosestplayer();
    if(isDefined(var_4)) {
      if(var_4 != self.rejoinplayer) {
        self.rejoinplayer = var_4;
      }
    }
  }

  var_5 = distancesquared(self.rejoinplayer.origin, self.origin);
  var_6 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_7 = var_6.return_to_closest_player_dist_in_combat_sq;
  var_1 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(isDefined(var_1)) {
    var_8 = 1;
    var_9 = self getpersstat(var_1);
    if(var_9) {
      var_8 = self canshoot(scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos());
    }

    if(var_8) {
      scripts\asm\asm_bb::bb_setisincombat(1);
      scripts\asm\asm_bb::bb_requestmovetype("combat");
      self.bulletsinclip = weaponclipsize(self.var_394);
      aimattarget();
      shootattarget();
    } else {
      scripts\asm\asm_bb::bb_setisincombat(0);
      scripts\asm\asm_bb::bb_requestmovetype("run");
      stopshootingattarget();
    }
  } else {
    var_7 = var_6.return_to_closest_player_dist_sq;
    stopshootingattarget();
    scripts\asm\asm_bb::bb_setisincombat(0);
    scripts\asm\asm_bb::bb_requestmovetype("run");
  }

  if(var_5 < var_7) {
    self clearpath();
    return level.success;
  }

  var_0A = getclosestpointonnavmesh(self.rejoinplayer.origin);
  self ghostskulls_complete_status(var_0A);
  return level.running;
}

rejoinplayer_end(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.nextclosestplayerchecktime = undefined;
  self.rejoinplayer = undefined;
  stopshootingattarget();
  self.bt.shootparams = undefined;
}

returntoplayer(var_0, var_1) {
  self.rejoinplayer = var_1;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "rejoin_player");
}

getclosestplayer() {
  var_0 = sortbydistance(level.players, self.origin);
  if(var_0.size == 0) {
    return undefined;
  }

  return var_0[0];
}

tryreturntoclosestplayer(var_0) {
  var_1 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(!isDefined(self.nextplayerleashchecktime)) {
    self.nextplayerleashchecktime = gettime() + var_1.check_for_closest_player_interval_ms;
  }

  if(gettime() < self.nextplayerleashchecktime) {
    return 0;
  }

  var_2 = getclosestplayer();
  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = var_1.max_dist_from_closest_player_sq;
  if(isDefined(scripts\mp\agents\elvira\elvira_agent::getenemy())) {
    var_3 = var_1.max_dist_from_closest_player_in_combat_sq;
  }

  if(distancesquared(self.origin, var_2.origin) < var_3) {
    return 0;
  }

  returntoplayer(var_0, var_2);
  return 1;
}

reload_begin(var_0, var_1) {
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_begin(var_0, var_1);
  stopshootingattarget();
  scripts\asm\elvira\elvira_asm::setaction("reload");
  scripts\asm\asm_bb::bb_setshootparams(undefined, undefined);
  self clearpath();
}

reload_tick(var_0) {
  return scripts\aitypes\dlc3\bt_state_api::asm_wait_state_tick(var_0);
}

reload_end(var_0, var_1) {
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_end(var_0, var_1);
  scripts\asm\asm_bb::bb_requestreload(0);
  scripts\asm\elvira\elvira_asm::clearaction();
}

doreloadstate(var_0, var_1) {
  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2.endevent = "ASM_Finished";
  var_2.asmstate = "exposed_reload";
  var_2.fncallback = var_1;
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "reload");
}

acquire_begin(var_0, var_1) {
  scripts\asm\asm_bb::bb_requestcombatmovetype_facemotion();
  stopshootingattarget();
}

acquire_tick(var_0) {
  var_1 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = 1;
  var_3 = self getpersstat(var_1);
  var_4 = distance2d(self.origin, var_1.origin);
  if(var_3) {
    if(trymeleeattacks(var_0, var_4 * var_4)) {
      return 0;
    }

    var_2 = self canshoot(scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos());
  } else {
    var_2 = 0;
  }

  var_5 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_6 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(var_2) {
    if(isDefined(var_5.targetacquiredtime)) {
      if(gettime() - var_5.targetacquiredtime > 500 || var_4 < var_6.desiredenemydistmin + 50) {
        self clearpath();
        return 0;
      } else {
        aimattarget();
        shootattarget();
      }
    } else {
      var_5.targetacquiredtime = gettime();
    }
  } else {
    stopshootingattarget();
    var_5.targetacquiredtime = undefined;
  }

  var_7 = getclosestpointonnavmesh(var_1.origin);
  self ghostskulls_complete_status(var_7);
  return 1;
}

acquire_end(var_0, var_1) {
  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2.targetacquiredtime = undefined;
}

backpedal_begin(var_0, var_1) {
  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2.nextcalculatetime = gettime() + 50;
}

backpedal_tick(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  if(gettime() > var_1.nextcalculatetime) {
    var_2 = self pathdisttogoal();
    if(var_2 <= 4) {
      return 0;
    }
  }

  var_3 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  var_4 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(isDefined(var_3)) {
    if(distance(self.origin, self.isnodeoccupied.origin) < var_4.backupdist * 1.2) {
      var_5 = getbackpedalspot();
      if(isDefined(var_5)) {
        var_1.backpedalspot = var_5;
        var_1.nextcalculatetime = gettime() + 50;
      }
    }
  }

  aimattarget();
  shootattarget();
  if(!scripts\aitypes\combat::hasammoinclip()) {
    doreloadstate(var_0);
    return 1;
  }

  self ghostskulls_complete_status(var_1.backpedalspot);
  scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
  return 1;
}

backpedal_end(var_0, var_1) {
  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2.backpedalspot = undefined;
  var_2.nextcalculatetime = undefined;
  self clearpath();
}

getbackpedalspot() {
  if(!isDefined(self.isnodeoccupied)) {
    return undefined;
  }

  var_0 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_1 = vectornormalize(self.origin - self.isnodeoccupied.origin);
  var_2 = var_0.backupdist;
  var_3 = self.origin + var_1 * var_2;
  var_3 = getclosestpointonnavmesh(var_3, self);
  var_4 = var_3 - self.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = vectornormalize(var_4);
  var_6 = vectordot(var_5, var_1);
  if(var_6 > 0) {
    return var_3;
  }

  return undefined;
}

dobackpedal(var_0) {
  var_1 = getbackpedalspot();
  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2.backpedalspot = var_1;
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "backpedal");
  return 1;
}

combat_begin(var_0) {
  scripts\asm\asm_bb::bb_setisincombat(1);
  scripts\asm\asm_bb::bb_requestmovetype("combat");
  self.bt.shootparams = spawnStruct();
  self.bt.shootparams.taskid = var_0;
  self.bt.shootparams.starttime = gettime();
  self.bt.m_bfiring = 0;
}

combat_tick(var_0) {
  self endon("newaction");
  if(tryreviveplayer(var_0)) {
    return level.failure;
  }

  if(trycastspell(var_0)) {
    return level.failure;
  }

  if(tryreturntoclosestplayer(var_0)) {
    return level.failure;
  }

  var_1 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_2 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_2)) {
    return level.success;
  }

  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  var_3 = 1;
  var_4 = self getpersstat(self.isnodeoccupied);
  var_5 = distance2d(self.origin, self.isnodeoccupied.origin);
  if(var_4) {
    var_3 = self canshoot(scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos());
  } else {
    var_3 = 0;
  }

  if(!var_3) {
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "acquire");
    return level.running;
  }

  if(trymeleeattacks(var_0, var_5 * var_5)) {
    return level.failure;
  }

  if(!scripts\aitypes\combat::hasammoinclip()) {
    doreloadstate(var_0);
    return level.running;
  }

  self.last_enemy_sight_time = gettime();
  self.last_enemy_seen = self.isnodeoccupied;
  if(var_5 > var_1.desiredenemydistmax) {
    if(self.bulletsinclip < weaponclipsize(self.var_394) * 0.4) {
      doreloadstate(var_0);
      return level.running;
    }

    decidemovetype(1, var_5);
    self ghostskulls_complete_status(self.isnodeoccupied.origin);
    return level.running;
  }

  if(var_5 < var_1.backawayenemydist) {
    dobackpedal(var_0);
  } else if(var_5 < var_1.desiredenemydistmin) {
    self clearpath();
  }

  aimattarget();
  shootattarget();
  return level.running;
}

combat_end(var_0) {
  scripts\asm\asm_bb::bb_setisincombat(0);
  stopshootingattarget();
  self clearpath();
  self.bt.shootparams = undefined;
  self.bt.m_bfiring = 0;
}

revealanomaly_begin(var_0) {
  self ghostskulls_complete_status(self.reveal_anomaly_origin);
  self.og_goalradius = self.objective_playermask_showto;
  self ghostskulls_total_waves(108);
  self.reveal_dialogue_spoken = undefined;
  self.started_reveal_dialogue = undefined;
  thread elvira_reveal_vo();
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.breveal_started = 0;
}

elvira_reveal_vo() {
  self.started_reveal_dialogue = 1;
  if(!scripts\cp\cp_vo::is_vo_system_busy()) {
    scripts\cp\cp_vo::set_vo_system_busy(1);
    scripts\engine\utility::play_sound_in_space("el_pap_energy_pap_restore", level.elvira.origin, 0, level.elvira);
    var_0 = scripts\cp\cp_vo::get_sound_length("el_pap_energy_pap_restore");
    wait(var_0);
    scripts\cp\cp_vo::set_vo_system_busy(0);
  }

  self.reveal_dialogue_spoken = 1;
}

revealanomaly_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  if(isDefined(self.reveal_anomaly_origin) && !scripts\engine\utility::istrue(var_1.breveal_started)) {
    if(distance2dsquared(self.reveal_anomaly_origin, self.origin) <= 16384 && scripts\engine\utility::istrue(self.reveal_dialogue_spoken)) {
      stopshootingattarget();
      scripts\asm\elvira\elvira_asm::setaction("cast_reveal_spell");
      scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "cast_reveal_spell", "cast_reveal_spell", ::revealanomaly_revealdone, undefined, undefined, 8000);
      scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "cast_reveal_spell");
      var_1.breveal_started = 1;
      return level.running;
    } else {
      if(distance2dsquared(self.reveal_anomaly_origin, self.origin) <= 16384 && !scripts\engine\utility::istrue(self.started_reveal_dialogue)) {
        self ghostskulls_complete_status(self.origin);
      } else {
        self ghostskulls_complete_status(self.reveal_anomaly_origin);
      }

      return level.running;
    }
  }

  return level.success;
}

revealanomaly_end(var_0) {
  self ghostskulls_total_waves(self.og_goalradius);
  self.og_goalradius = undefined;
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.breveal_started = undefined;
  self.reveal_anomaly_origin = undefined;
  scripts\asm\elvira\elvira_asm::clearaction();
}

tryrevealanomaly(var_0) {
  if(scripts\engine\utility::istrue(level.anomaly_revealed)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.started_reveal_dialogue)) {
    return 0;
  }

  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  if(isDefined(level.secretpapstructs) && level.secretpapstructs.size > 0 && !scripts\engine\utility::istrue(var_1.breveal_started)) {
    var_2 = sortbydistance(level.secretpapstructs, self.origin);
    if(distance2dsquared(self.origin, var_2[0].origin) < 65536) {
      self.reveal_anomaly_origin = var_2[0].origin;
      scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "reveal_anomaly");
      return 1;
    } else {
      var_3 = scripts\cp\utility::get_array_of_valid_players(1, self.origin);
      var_4 = scripts\engine\utility::getclosest(self.origin, var_3);
      if(isDefined(var_4)) {
        if(distancesquared(var_4.origin, var_2[0].origin) < 65536) {
          self.reveal_anomaly_origin = var_2[0].origin;
          scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "reveal_anomaly");
          return 1;
        }
      }
    }
  }

  return 0;
}

revealanomaly_revealdone(var_0, var_1) {
  level.anomaly_revealed = 1;
  var_2 = scripts\engine\utility::getclosest(self.origin, level.secretpapstructs);
  var_2.revealed = 1;
  var_2.teleporter_active = 1;
  level.active_pap_teleporter = var_2;
  level thread elvirarevealdialogue();
  return 0;
}

elvirarevealdialogue() {
  if(scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    var_0 = scripts\engine\utility::random(level.players);
    if(isDefined(var_0.vo_prefix)) {
      switch (var_0.vo_prefix) {
        case "p1_":
          level thread scripts\cp\cp_vo::try_to_play_vo("sally_pap_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          break;

        case "p2_":
          level thread scripts\cp\cp_vo::try_to_play_vo("pdex_pap_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          break;

        case "p3_":
          level thread scripts\cp\cp_vo::try_to_play_vo("andre_pap_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          break;

        case "p4_":
          level thread scripts\cp\cp_vo::try_to_play_vo("aj_pap_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          break;

        default:
          break;
      }
    }
  } else {
    scripts\cp\cp_vo::try_to_play_vo_on_all_players("pap_quest_success", 0);
  }

  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\cp_vo::add_to_nag_vo("nag_find_pap", "town_comment_vo", 120, 120, 4, 1);
  }
}

tryreturnhome(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  if(scripts\engine\utility::istrue(var_1.breturn_started)) {
    return 0;
  }

  if(gettime() < self.return_home_time) {
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "return_home");
  return 1;
}

returnhome_begin(var_0) {}

returnhome_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  if(!scripts\engine\utility::istrue(var_1.breturn_started)) {
    stopshootingattarget();
    scripts\asm\elvira\elvira_asm::setaction("cast_return_spell");
    scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "cast_return_spell", "cast_return_spell", ::returnhome_done, undefined, undefined, 8000);
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "cast_return_spell");
    var_1.breturn_started = 1;
    level.elvira_returned_to_couch = 1;
    return level.running;
  }

  return level.success;
}

returnhome_end(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.breturn_started = undefined;
  self.return_time = undefined;
  scripts\asm\elvira\elvira_asm::clearaction();
}

returnhome_done(var_0, var_1) {
  thread return_elvira_to_couch();
  return 0;
}

return_elvira_to_couch() {
  playFX(level._effect["elvira_stand_smoke"], self.origin);
  playsoundatpos(self.origin, "town_elvira_vanish");
  wait(0.1);
  self.nocorpse = 1;
  self.noragdoll = 1;
  var_0 = self.origin;
  self setCanDamage(1);
  self suicide();
  level.elvira_ai = undefined;
  level.elvira_available_again = gettime() + 300000;
  var_1 = scripts\engine\utility::random(["ammo_max", "instakill_30", "cash_2", "instakill_30", "cash_2", "instakill_30", "cash_2"]);
  wait(2);
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
  level scripts\cp\loot::drop_loot(var_0, undefined, var_1);
  wait(10);
  if(scripts\engine\utility::flag("spellbook_placed") && !scripts\engine\utility::flag("spellbook_page1_found") && !scripts\engine\utility::flag("boss_fight_active")) {
    level thread elvira_spellbook_pages();
  }

  wait(290);
  scripts\engine\utility::flag_clear("elvira_summoned");
  playFX(level._effect["elvira_couch_smoke"], level.elvira.origin);
  playsoundatpos(level.elvira.origin, "town_elvira_appear");
  level.elvira show();
  level thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_idle_loop();
  foreach(var_3 in level.players) {
    if(isDefined(var_3.last_interaction_point) && isDefined(var_3.last_interaction_point.script_noteworthy == "elvira_talk")) {
      var_3 notify("stop_interaction_logic");
      var_3.interaction_trigger makeunusable();
      var_3.last_interaction_point = undefined;
    }
  }
}

elvira_spellbook_pages() {
  if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
    scripts\cp\cp_vo::set_vo_system_busy(1);
    if(!scripts\engine\utility::istrue(level.has_nagged_for_pages)) {
      scripts\engine\utility::play_sound_in_space("el_nag_spellbook_pages", level.elvira.origin, 0, level.elvira);
      var_0 = scripts\cp\cp_vo::get_sound_length("el_nag_spellbook_pages");
      wait(var_0);
    } else {
      var_1 = scripts\engine\utility::random(["el_nag_spellbook_pages_2", "el_nag_spellbook_pages_3"]);
      scripts\engine\utility::play_sound_in_space(var_1, level.elvira.origin, 0, level.elvira);
      var_0 = scripts\cp\cp_vo::get_sound_length(var_1);
      wait(var_0);
    }

    scripts\cp\cp_vo::set_vo_system_busy(0);
  }

  level.has_nagged_for_pages = 1;
}

castspell_begin(var_0) {}

castspell_tick(var_0) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  if(!scripts\engine\utility::istrue(var_1.spellcast_started)) {
    stopshootingattarget();
    scripts\asm\elvira\elvira_asm::setaction("cast_spell");
    scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(var_0, "cast_spell", "cast_spell", ::castspell_castdone, undefined, undefined, 8000);
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(var_0, "cast_spell");
    var_1.spellcast_started = 1;
    return level.running;
  }

  return level.success;
}

castspell_end(var_0) {
  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_1.spellcast_started = undefined;
  scripts\asm\elvira\elvira_asm::clearaction();
}

trycastspell(var_0) {
  if(!scripts\engine\utility::flag("spellbook_page1_placed")) {
    return 0;
  }

  var_1 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(var_0);
  var_2 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_3 = 0;
  if(!isDefined(self.next_spellcast_time)) {
    self.next_spellcast_time = gettime() + var_2.init_spellcast_delay;
    return 0;
  } else if(gettime() < self.next_spellcast_time) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) < var_2.max_dist_for_spell_cast_sq) {
    var_4 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
    var_5 = 0;
    foreach(var_7 in var_4) {
      if(!sighttracepassed(self.origin + (0, 0, 40), var_7.origin + (0, 0, 40), 0, self)) {
        continue;
      }

      if(distancesquared(var_7.origin, self.isnodeoccupied.origin) < var_2.max_enemy_spell_radius_sq) {
        var_5++;
      }
    }

    if(var_5 < var_2.min_enemies_for_spellcast) {
      return 0;
    }

    self.next_spellcast_time = gettime() + var_2.spellcast_interval;
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "cast_spell");
    return 1;
  }

  return 0;
}

castspell_castdone(var_0, var_1) {
  return 0;
}

shouldtrymeleeattack() {
  return 1;
}

trymeleeattacks(var_0, var_1) {
  var_2 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  var_3 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(abs(var_2.origin[2] - self.origin[2]) > var_3.melee_max_z_diff) {
    return 0;
  }

  if(!isDefined(var_1)) {
    var_1 = distancesquared(self.origin, var_2.origin);
  }

  if(!ispointonnavmesh(var_2.origin)) {
    if(var_1 > self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh) {
      return 0;
    }
  } else if(var_1 > self.meleeradiusbasesq) {
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "melee_attack");
  return 1;
}

decideaction(var_0) {
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_0, "idle");
  return level.success;
}