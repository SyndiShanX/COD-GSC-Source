/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\elvira\behaviors.gsc
************************************************/

init(param_00) {
  setupbtstates();
  var_01 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  self.desiredaction = undefined;
  self.lastenemysighttime = 0;
  self.lastenemyengagetime = 0;
  self.lastenemytime = 0;
  self.myenemy = undefined;
  self.myenemystarttime = 0;
  self.last_health = self.health;
  self.return_home_time = gettime() + var_01.lifespan;
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
    var_00 = self[[self.fncustomtargetingfunc]]();
    if(!self canshoot(var_00)) {
      var_00 = scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos();
    }
  } else {
    var_00 = scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos();
  }

  self.setplayerignoreradiusdamage = var_00;
}

shootattarget() {
  var_00 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_00)) {
    return 0;
  }

  var_01 = self.var_3135.shootparams;
  var_01.objective = "normal";
  self.doentitiessharehierarchy = undefined;
  var_01.pos = self.setplayerignoreradiusdamage;
  var_01.ent = undefined;
  scripts\asm\asm_bb::bb_setshootparams(var_01, undefined);
  if(scripts\aitypes\combat::isaimedataimtarget()) {
    if(!scripts\engine\utility::istrue(self.var_3135.m_bfiring)) {
      scripts\aitypes\combat::resetmisstime_code();
      scripts\aitypes\combat::chooseshootstyle(var_01);
      scripts\aitypes\combat::choosenumshotsandbursts(var_01);
    }

    var_01.objective = "normal";
    self.var_3135.m_bfiring = 1;
  } else {
    self.var_3135.m_bfiring = 0;
  }

  if(!isDefined(var_01.pos) && !isDefined(var_01.ent)) {
    return 0;
  }

  scripts\asm\asm_bb::bb_requestfire(self.var_3135.m_bfiring);
  return self.var_3135.m_bfiring;
}

stopshootingattarget() {
  self.var_3135.m_bfiring = 0;
  scripts\asm\asm_bb::bb_requestfire(self.var_3135.m_bfiring);
}

updateenemy() {
  return scripts\mp\agents\elvira\elvira_agent::getenemy();
}

checkforearlyteleport(param_00) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_01 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_02 = self pathdisttogoal();
  if(var_02 > var_01.max_teleport_lookahead_dist) {
    var_02 = var_01.max_teleport_lookahead_dist;
  }

  if(scripts\asm\asm::asm_isinstate("traverse_external")) {
    return 0;
  }

  var_03 = self _meth_84F9(var_02);
  if(!isDefined(var_03)) {
    return 0;
  }

  var_04 = var_03["node"];
  var_05 = var_03["position"];
  var_06 = var_04.opcode::OP_ScriptMethodCallPointer;
  if(!isDefined(var_06)) {
    return 0;
  }

  var_07 = self.asmname;
  var_08 = level.asm[var_07];
  var_09 = var_08.states[var_06];
  if(!isDefined(var_09)) {
    var_06 = "traverse_external";
  }

  if(var_06 == "traverse_external") {
    self.earlytraversalteleportpos = var_05;
    scripts\asm\asm::asm_setstate("traverse_external");
    return 1;
  }

  return 0;
}

updateeveryframe(param_00) {
  var_01 = updateenemy();
  if(isDefined(var_01)) {
    self.lastenemytime = gettime();
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

decidemovetype(param_00, param_01) {
  var_02 = gettime();
  var_03 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(self.last_enemy_sight_time < 0 || var_02 - self.last_enemy_sight_time < var_03.maxtimetostrafewithoutlos) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
    return;
  }

  if(param_01 < var_03.strafeifwithindist) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
    return;
  }

  if(!param_00) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_facemotion();
    return;
  }

  scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
}

idle_begin(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.idle_start_time = gettime();
}

idle_tick(param_00) {
  self clearpath();
  if(trycastspell(param_00)) {
    return level.success;
  }

  if(tryrevealanomaly(param_00)) {
    return level.success;
  }

  if(tryreturnhome(param_00)) {
    return level.success;
  }

  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  if(tryreviveplayer(param_00)) {
    return level.success;
  }

  if(tryreturntoclosestplayer(param_00)) {
    return level.success;
  }

  var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_01)) {
    var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
    if(gettime() > var_02.idle_start_time + 250) {
      if(self.bulletsinclip < weaponclipsize(self.var_394) * 0.75) {
        doreloadstate(param_00);
      }
    }

    return level.running;
  }

  if(shouldtrymeleeattack() && trymeleeattacks(var_01)) {
    return level.success;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_01, "combat");
  return level.running;
}

idle_end(param_00) {}

setgoaltoreviveplayer(param_00, param_01) {
  var_02 = anglesToForward(param_00.angles);
  var_03 = anglestoright(param_00.angles);
  var_04 = param_00.origin + var_02 * param_01.revive_forward_offset + var_03 * param_01.revive_right_offset;
  var_05 = param_00.origin - var_04;
  var_06 = vectortoangles(var_05);
  var_06 = (0, var_06[1], 0);
  var_07 = getclosestpointonnavmesh(var_04, self);
  self ghostskulls_complete_status(var_07);
}

reviveplayer_begin(param_00, param_01) {
  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02.brevivedone = undefined;
  self.disablearrivals = 0;
  self.ignoreme = 1;
  self.var_3135.shootparams = spawnStruct();
  self.var_3135.shootparams.taskid = param_00;
  self.var_3135.shootparams.starttime = gettime();
}

reviveplayer_tick(param_00) {
  var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_01) && gettime() - self.lastenemytime > 500) {
    checkforearlyteleport();
  }

  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  if(!isDefined(self.reviveplayer) || !scripts\engine\utility::istrue(self.reviveplayer.inlaststand)) {
    return level.success;
  }

  var_02 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  setgoaltoreviveplayer(self.reviveplayer, var_02);
  var_03 = distance2dsquared(self.reviveplayer.origin, self.origin);
  if(var_03 < var_02.max_dist_to_revive_player_sq) {
    stopshootingattarget();
    scripts\asm\elvira\elvira_asm::setaction("revive_player");
    scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "revive_player", "revive_player_intro", ::reviveplayer_revivedone, undefined, undefined, 8000);
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "revive_player");
  } else {
    var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
    if(isDefined(var_01)) {
      var_04 = 1;
      var_05 = self getpersstat(var_01);
      if(var_05) {
        var_04 = self canshoot(scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos());
      }

      if(var_04) {
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

reviveplayer_end(param_00, param_01) {
  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02.brevivedone = undefined;
  stopshootingattarget();
  var_03 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  self.disablearrivals = 0;
  self.forcenextrevivetime = undefined;
  if(isDefined(self.reviveplayer)) {
    if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
      self.nextrevivetime = gettime() + var_03.min_time_between_revivals_solo;
    } else {
      self.nextrevivetime = gettime() + var_03.min_time_between_revivals;
    }
  } else {
    self.nextrevivetime = gettime() + var_03.min_time_between_revivals;
  }

  self.reviveplayer = undefined;
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(param_00);
  scripts\asm\elvira\elvira_asm::clearaction();
  self.var_3135.shootparams = undefined;
}

reviveplayer_revivedone(param_00, param_01) {}

findplayertorevive() {
  var_00 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_01 = sortbydistance(level.players, self.origin);
  foreach(var_03 in var_01) {
    var_04 = distancesquared(self.origin, var_03.origin);
    if(var_04 > var_00.max_revive_search_dist_sq) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.inlaststand) && !scripts\engine\utility::istrue(var_03.is_being_revived) && !scripts\engine\utility::istrue(var_03.in_afterlife_arcade)) {
      return var_03;
    }
  }

  return undefined;
}

reviveplayer(param_00, param_01) {
  self.reviveplayer = param_01;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "revive_player");
}

tryreviveplayer(param_00) {
  if(!scripts\engine\utility::istrue(1)) {
    return 0;
  }

  if(isDefined(self.nextrevivetime)) {
    if(gettime() < self.nextrevivetime) {
      return 0;
    }
  }

  var_01 = findplayertorevive();
  if(!isDefined(var_01)) {
    return 0;
  }

  reviveplayer(param_00, var_01);
  return 1;
}

melee_begin(param_00) {
  self.curmeleetarget = scripts\mp\agents\elvira\elvira_agent::getenemy();
  scripts\asm\elvira\elvira_asm::setaction("melee");
  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "melee", "melee_attack");
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "melee");
}

melee_tick(param_00) {
  self clearpath();
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.failure;
}

melee_end(param_00) {
  self.curmeleetarget = undefined;
  self.bmovingmelee = undefined;
  scripts\asm\elvira\elvira_asm::clearaction();
  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(param_00);
  scripts\asm\asm_bb::bb_clearmeleerequest();
}

rejoinplayer_begin(param_00) {
  self.var_3135.shootparams = spawnStruct();
  self.var_3135.shootparams.taskid = param_00;
  self.var_3135.shootparams.starttime = gettime();
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.nextclosestplayerchecktime = gettime() + 1000;
}

rejoinplayer_tick(param_00) {
  var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_01) && gettime() - self.lastenemytime > 500) {
    checkforearlyteleport();
  }

  if(!isDefined(self.rejoinplayer)) {
    return level.failure;
  }

  var_02 = gettime();
  var_03 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  if(var_02 > var_03.nextclosestplayerchecktime) {
    var_03.nextclosestplayerchecktime = var_02 + 1000;
    var_04 = getclosestplayer();
    if(isDefined(var_04)) {
      if(var_04 != self.rejoinplayer) {
        self.rejoinplayer = var_04;
      }
    }
  }

  var_05 = distancesquared(self.rejoinplayer.origin, self.origin);
  var_06 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_07 = var_06.return_to_closest_player_dist_in_combat_sq;
  var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(isDefined(var_01)) {
    var_08 = 1;
    var_09 = self getpersstat(var_01);
    if(var_09) {
      var_08 = self canshoot(scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos());
    }

    if(var_08) {
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
    var_07 = var_06.return_to_closest_player_dist_sq;
    stopshootingattarget();
    scripts\asm\asm_bb::bb_setisincombat(0);
    scripts\asm\asm_bb::bb_requestmovetype("run");
  }

  if(var_05 < var_07) {
    self clearpath();
    return level.success;
  }

  var_0A = getclosestpointonnavmesh(self.rejoinplayer.origin);
  self ghostskulls_complete_status(var_0A);
  return level.running;
}

rejoinplayer_end(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.nextclosestplayerchecktime = undefined;
  self.rejoinplayer = undefined;
  stopshootingattarget();
  self.var_3135.shootparams = undefined;
}

returntoplayer(param_00, param_01) {
  self.rejoinplayer = param_01;
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "rejoin_player");
}

getclosestplayer() {
  var_00 = sortbydistance(level.players, self.origin);
  if(var_00.size == 0) {
    return undefined;
  }

  return var_00[0];
}

tryreturntoclosestplayer(param_00) {
  var_01 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(!isDefined(self.nextplayerleashchecktime)) {
    self.nextplayerleashchecktime = gettime() + var_01.check_for_closest_player_interval_ms;
  }

  if(gettime() < self.nextplayerleashchecktime) {
    return 0;
  }

  var_02 = getclosestplayer();
  if(!isDefined(var_02)) {
    return 0;
  }

  var_03 = var_01.max_dist_from_closest_player_sq;
  if(isDefined(scripts\mp\agents\elvira\elvira_agent::getenemy())) {
    var_03 = var_01.max_dist_from_closest_player_in_combat_sq;
  }

  if(distancesquared(self.origin, var_02.origin) < var_03) {
    return 0;
  }

  returntoplayer(param_00, var_02);
  return 1;
}

reload_begin(param_00, param_01) {
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_begin(param_00, param_01);
  stopshootingattarget();
  scripts\asm\elvira\elvira_asm::setaction("reload");
  scripts\asm\asm_bb::bb_setshootparams(undefined, undefined);
  self clearpath();
}

reload_tick(param_00) {
  return scripts\aitypes\dlc3\bt_state_api::asm_wait_state_tick(param_00);
}

reload_end(param_00, param_01) {
  scripts\aitypes\dlc3\bt_state_api::asm_wait_state_end(param_00, param_01);
  scripts\asm\asm_bb::bb_requestreload(0);
  scripts\asm\elvira\elvira_asm::clearaction();
}

doreloadstate(param_00, param_01) {
  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02.endevent = "ASM_Finished";
  var_02.asmstate = "exposed_reload";
  var_02.fncallback = param_01;
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "reload");
}

acquire_begin(param_00, param_01) {
  scripts\asm\asm_bb::bb_requestcombatmovetype_facemotion();
  stopshootingattarget();
}

acquire_tick(param_00) {
  var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_01)) {
    return 0;
  }

  var_02 = 1;
  var_03 = self getpersstat(var_01);
  var_04 = distance2d(self.origin, var_01.origin);
  if(var_03) {
    if(trymeleeattacks(param_00, var_04 * var_04)) {
      return 0;
    }

    var_02 = self canshoot(scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos());
  } else {
    var_02 = 0;
  }

  var_05 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_06 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(var_02) {
    if(isDefined(var_05.targetacquiredtime)) {
      if(gettime() - var_05.targetacquiredtime > 500 || var_04 < var_06.desiredenemydistmin + 50) {
        self clearpath();
        return 0;
      } else {
        aimattarget();
        shootattarget();
      }
    } else {
      var_05.targetacquiredtime = gettime();
    }
  } else {
    stopshootingattarget();
    var_05.targetacquiredtime = undefined;
  }

  var_07 = getclosestpointonnavmesh(var_01.origin);
  self ghostskulls_complete_status(var_07);
  return 1;
}

acquire_end(param_00, param_01) {
  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02.targetacquiredtime = undefined;
}

backpedal_begin(param_00, param_01) {
  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02.nextcalculatetime = gettime() + 50;
}

backpedal_tick(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  if(gettime() > var_01.nextcalculatetime) {
    var_02 = self pathdisttogoal();
    if(var_02 <= 4) {
      return 0;
    }
  }

  var_03 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  var_04 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(isDefined(var_03)) {
    if(distance(self.origin, self.isnodeoccupied.origin) < var_04.backupdist * 1.2) {
      var_05 = getbackpedalspot();
      if(isDefined(var_05)) {
        var_01.backpedalspot = var_05;
        var_01.nextcalculatetime = gettime() + 50;
      }
    }
  }

  aimattarget();
  shootattarget();
  if(!scripts\aitypes\combat::hasammoinclip()) {
    doreloadstate(param_00);
    return 1;
  }

  self ghostskulls_complete_status(var_01.backpedalspot);
  scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
  return 1;
}

backpedal_end(param_00, param_01) {
  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02.backpedalspot = undefined;
  var_02.nextcalculatetime = undefined;
  self clearpath();
}

getbackpedalspot() {
  if(!isDefined(self.isnodeoccupied)) {
    return undefined;
  }

  var_00 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_01 = vectornormalize(self.origin - self.isnodeoccupied.origin);
  var_02 = var_00.backupdist;
  var_03 = self.origin + var_01 * var_02;
  var_03 = getclosestpointonnavmesh(var_03, self);
  var_04 = var_03 - self.origin;
  var_04 = (var_04[0], var_04[1], 0);
  var_05 = vectornormalize(var_04);
  var_06 = vectordot(var_05, var_01);
  if(var_06 > 0) {
    return var_03;
  }

  return undefined;
}

dobackpedal(param_00) {
  var_01 = getbackpedalspot();
  if(!isDefined(var_01)) {
    return 0;
  }

  var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02.backpedalspot = var_01;
  scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "backpedal");
  return 1;
}

combat_begin(param_00) {
  scripts\asm\asm_bb::bb_setisincombat(1);
  scripts\asm\asm_bb::bb_requestmovetype("combat");
  self.var_3135.shootparams = spawnStruct();
  self.var_3135.shootparams.taskid = param_00;
  self.var_3135.shootparams.starttime = gettime();
  self.var_3135.m_bfiring = 0;
}

combat_tick(param_00) {
  self endon("newaction");
  if(tryreviveplayer(param_00)) {
    return level.failure;
  }

  if(trycastspell(param_00)) {
    return level.failure;
  }

  if(tryreturntoclosestplayer(param_00)) {
    return level.failure;
  }

  var_01 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_02 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  if(!isDefined(var_02)) {
    return level.success;
  }

  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  var_03 = 1;
  var_04 = self getpersstat(self.isnodeoccupied);
  var_05 = distance2d(self.origin, self.isnodeoccupied.origin);
  if(var_04) {
    var_03 = self canshoot(scripts\mp\agents\elvira\elvira_agent::getdefaultenemychestpos());
  } else {
    var_03 = 0;
  }

  if(!var_03) {
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "acquire");
    return level.running;
  }

  if(trymeleeattacks(param_00, var_05 * var_05)) {
    return level.failure;
  }

  if(!scripts\aitypes\combat::hasammoinclip()) {
    doreloadstate(param_00);
    return level.running;
  }

  self.last_enemy_sight_time = gettime();
  self.last_enemy_seen = self.isnodeoccupied;
  if(var_05 > var_01.desiredenemydistmax) {
    if(self.bulletsinclip < weaponclipsize(self.var_394) * 0.4) {
      doreloadstate(param_00);
      return level.running;
    }

    decidemovetype(1, var_05);
    self ghostskulls_complete_status(self.isnodeoccupied.origin);
    return level.running;
  }

  if(var_05 < var_01.backawayenemydist) {
    dobackpedal(param_00);
  } else if(var_05 < var_01.desiredenemydistmin) {
    self clearpath();
  }

  aimattarget();
  shootattarget();
  return level.running;
}

combat_end(param_00) {
  scripts\asm\asm_bb::bb_setisincombat(0);
  stopshootingattarget();
  self clearpath();
  self.var_3135.shootparams = undefined;
  self.var_3135.m_bfiring = 0;
}

revealanomaly_begin(param_00) {
  self ghostskulls_complete_status(self.reveal_anomaly_origin);
  self.og_goalradius = self.objective_playermask_showto;
  self ghostskulls_total_waves(108);
  self.reveal_dialogue_spoken = undefined;
  self.started_reveal_dialogue = undefined;
  thread elvira_reveal_vo();
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.breveal_started = 0;
}

elvira_reveal_vo() {
  self.started_reveal_dialogue = 1;
  if(!scripts\cp\cp_vo::is_vo_system_busy()) {
    scripts\cp\cp_vo::set_vo_system_busy(1);
    scripts\engine\utility::play_sound_in_space("el_pap_energy_pap_restore", level.elvira.origin, 0, level.elvira);
    var_00 = scripts\cp\cp_vo::get_sound_length("el_pap_energy_pap_restore");
    wait(var_00);
    scripts\cp\cp_vo::set_vo_system_busy(0);
  }

  self.reveal_dialogue_spoken = 1;
}

revealanomaly_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  if(isDefined(self.reveal_anomaly_origin) && !scripts\engine\utility::istrue(var_01.breveal_started)) {
    if(distance2dsquared(self.reveal_anomaly_origin, self.origin) <= 16384 && scripts\engine\utility::istrue(self.reveal_dialogue_spoken)) {
      stopshootingattarget();
      scripts\asm\elvira\elvira_asm::setaction("cast_reveal_spell");
      scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "cast_reveal_spell", "cast_reveal_spell", ::revealanomaly_revealdone, undefined, undefined, 8000);
      scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "cast_reveal_spell");
      var_01.breveal_started = 1;
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

revealanomaly_end(param_00) {
  self ghostskulls_total_waves(self.og_goalradius);
  self.og_goalradius = undefined;
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.breveal_started = undefined;
  self.reveal_anomaly_origin = undefined;
  scripts\asm\elvira\elvira_asm::clearaction();
}

tryrevealanomaly(param_00) {
  if(scripts\engine\utility::istrue(level.anomaly_revealed)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.started_reveal_dialogue)) {
    return 0;
  }

  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  if(isDefined(level.secretpapstructs) && level.secretpapstructs.size > 0 && !scripts\engine\utility::istrue(var_01.breveal_started)) {
    var_02 = sortbydistance(level.secretpapstructs, self.origin);
    if(distance2dsquared(self.origin, var_02[0].origin) < 65536) {
      self.reveal_anomaly_origin = var_02[0].origin;
      scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "reveal_anomaly");
      return 1;
    } else {
      var_03 = scripts\cp\utility::get_array_of_valid_players(1, self.origin);
      var_04 = scripts\engine\utility::getclosest(self.origin, var_03);
      if(isDefined(var_04)) {
        if(distancesquared(var_04.origin, var_02[0].origin) < 65536) {
          self.reveal_anomaly_origin = var_02[0].origin;
          scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "reveal_anomaly");
          return 1;
        }
      }
    }
  }

  return 0;
}

revealanomaly_revealdone(param_00, param_01) {
  level.anomaly_revealed = 1;
  var_02 = scripts\engine\utility::getclosest(self.origin, level.secretpapstructs);
  var_02.revealed = 1;
  var_02.teleporter_active = 1;
  level.active_pap_teleporter = var_02;
  level thread elvirarevealdialogue();
  return 0;
}

elvirarevealdialogue() {
  if(scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    var_00 = scripts\engine\utility::random(level.players);
    if(isDefined(var_00.vo_prefix)) {
      switch (var_00.vo_prefix) {
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

  foreach(var_02 in level.players) {
    var_02 thread scripts\cp\cp_vo::add_to_nag_vo("nag_find_pap", "town_comment_vo", 120, 120, 4, 1);
  }
}

tryreturnhome(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  if(scripts\engine\utility::istrue(var_01.breturn_started)) {
    return 0;
  }

  if(gettime() < self.return_home_time) {
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "return_home");
  return 1;
}

returnhome_begin(param_00) {}

returnhome_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  if(!scripts\engine\utility::istrue(var_01.breturn_started)) {
    stopshootingattarget();
    scripts\asm\elvira\elvira_asm::setaction("cast_return_spell");
    scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "cast_return_spell", "cast_return_spell", ::returnhome_done, undefined, undefined, 8000);
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "cast_return_spell");
    var_01.breturn_started = 1;
    level.elvira_returned_to_couch = 1;
    return level.running;
  }

  return level.success;
}

returnhome_end(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.breturn_started = undefined;
  self.return_time = undefined;
  scripts\asm\elvira\elvira_asm::clearaction();
}

returnhome_done(param_00, param_01) {
  thread return_elvira_to_couch();
  return 0;
}

return_elvira_to_couch() {
  playFX(level._effect["elvira_stand_smoke"], self.origin);
  playsoundatpos(self.origin, "town_elvira_vanish");
  wait(0.1);
  self.nocorpse = 1;
  self.noragdoll = 1;
  var_00 = self.origin;
  self setCanDamage(1);
  self suicide();
  level.elvira_ai = undefined;
  level.elvira_available_again = gettime() + 300000;
  var_01 = scripts\engine\utility::random(["ammo_max", "instakill_30", "cash_2", "instakill_30", "cash_2", "instakill_30", "cash_2"]);
  wait(2);
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
  level scripts\cp\loot::drop_loot(var_00, undefined, var_01);
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
  foreach(var_03 in level.players) {
    if(isDefined(var_03.last_interaction_point) && isDefined(var_03.last_interaction_point.script_noteworthy == "elvira_talk")) {
      var_03 notify("stop_interaction_logic");
      var_03.interaction_trigger makeunusable();
      var_03.last_interaction_point = undefined;
    }
  }
}

elvira_spellbook_pages() {
  if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
    scripts\cp\cp_vo::set_vo_system_busy(1);
    if(!scripts\engine\utility::istrue(level.has_nagged_for_pages)) {
      scripts\engine\utility::play_sound_in_space("el_nag_spellbook_pages", level.elvira.origin, 0, level.elvira);
      var_00 = scripts\cp\cp_vo::get_sound_length("el_nag_spellbook_pages");
      wait(var_00);
    } else {
      var_01 = scripts\engine\utility::random(["el_nag_spellbook_pages_2", "el_nag_spellbook_pages_3"]);
      scripts\engine\utility::play_sound_in_space(var_01, level.elvira.origin, 0, level.elvira);
      var_00 = scripts\cp\cp_vo::get_sound_length(var_01);
      wait(var_00);
    }

    scripts\cp\cp_vo::set_vo_system_busy(0);
  }

  level.has_nagged_for_pages = 1;
}

castspell_begin(param_00) {}

castspell_tick(param_00) {
  if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  if(!scripts\engine\utility::istrue(var_01.spellcast_started)) {
    stopshootingattarget();
    scripts\asm\elvira\elvira_asm::setaction("cast_spell");
    scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00, "cast_spell", "cast_spell", ::castspell_castdone, undefined, undefined, 8000);
    scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00, "cast_spell");
    var_01.spellcast_started = 1;
    return level.running;
  }

  return level.success;
}

castspell_end(param_00) {
  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_01.spellcast_started = undefined;
  scripts\asm\elvira\elvira_asm::clearaction();
}

trycastspell(param_00) {
  if(!scripts\engine\utility::flag("spellbook_page1_placed")) {
    return 0;
  }

  var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
  var_02 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  var_03 = 0;
  if(!isDefined(self.next_spellcast_time)) {
    self.next_spellcast_time = gettime() + var_02.init_spellcast_delay;
    return 0;
  } else if(gettime() < self.next_spellcast_time) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) < var_02.max_dist_for_spell_cast_sq) {
    var_04 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
    var_05 = 0;
    foreach(var_07 in var_04) {
      if(!sighttracepassed(self.origin + (0, 0, 40), var_07.origin + (0, 0, 40), 0, self)) {
        continue;
      }

      if(distancesquared(var_07.origin, self.isnodeoccupied.origin) < var_02.max_enemy_spell_radius_sq) {
        var_05++;
      }
    }

    if(var_05 < var_02.min_enemies_for_spellcast) {
      return 0;
    }

    self.next_spellcast_time = gettime() + var_02.spellcast_interval;
    scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "cast_spell");
    return 1;
  }

  return 0;
}

castspell_castdone(param_00, param_01) {
  return 0;
}

shouldtrymeleeattack() {
  return 1;
}

trymeleeattacks(param_00, param_01) {
  var_02 = scripts\mp\agents\elvira\elvira_agent::getenemy();
  var_03 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
  if(abs(var_02.origin[2] - self.origin[2]) > var_03.melee_max_z_diff) {
    return 0;
  }

  if(!isDefined(param_01)) {
    param_01 = distancesquared(self.origin, var_02.origin);
  }

  if(!ispointonnavmesh(var_02.origin)) {
    if(param_01 > self.meleeradiuswhentargetnotonnavmesh * self.meleeradiuswhentargetnotonnavmesh) {
      return 0;
    }
  } else if(param_01 > self.meleeradiusbasesq) {
    return 0;
  }

  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "melee_attack");
  return 1;
}

decideaction(param_00) {
  scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00, "idle");
  return level.success;
}