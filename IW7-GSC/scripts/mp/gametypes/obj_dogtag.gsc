/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dogtag.gsc
***********************************************/

init() {
  level.dogtags = [];
  level.dogtagallyonusecb = ::scripts\mp\gametypes\common::dogtagallyonusecb;
  level.dogtagenemyonusecb = ::scripts\mp\gametypes\common::dogtagenemyonusecb;
  level.conf_fx["vanish"] = loadfx("vfx\core\impacts\small_snowhit");
  level.numlifelimited = scripts\mp\utility::getgametypenumlives();
}

shouldspawntags(param_00) {
  if(isDefined(self.switching_teams)) {
    return 0;
  }

  if(isDefined(param_00) && param_00 == self) {
    return 0;
  }

  if(level.teambased && isDefined(param_00) && isDefined(param_00.team) && param_00.team == self.team) {
    return 0;
  }

  if(isDefined(param_00) && !isDefined(param_00.team) && param_00.classname == "trigger_hurt" || param_00.classname == "worldspawn") {
    return 0;
  }

  return 1;
}

spawndogtags(param_00, param_01, param_02) {
  var_03 = 1;
  if(scripts\mp\utility::istrue(level.numlifelimited)) {
    var_03 = param_00 shouldspawntags(param_01);
    if(var_03) {
      var_03 = var_03 && !scripts\mp\utility::isreallyalive(param_00);
    }

    if(var_03) {
      var_03 = var_03 && !param_00 scripts\mp\playerlogic::mayspawn();
    }
  }

  if(!var_03) {
    return;
  }

  if(isagent(param_00)) {
    return;
  }

  if(isagent(param_01)) {
    param_01 = param_01.triggerportableradarping;
  }

  var_04 = 14;
  var_05 = (0, 0, 0);
  var_06 = param_00.angles;
  if(param_00 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_06 = param_00 getworldupreferenceangles();
    var_05 = anglestoup(var_06);
    if(var_05[2] < 0) {
      var_04 = -14;
    }
  }

  if(isDefined(level.dogtags[param_00.guid])) {
    playFX(level.conf_fx["vanish"], level.dogtags[param_00.guid].curorigin);
    level.dogtags[param_00.guid] resettags();
    level.dogtags[param_00.guid].visuals[0].angles = (0, 0, 0);
    level.dogtags[param_00.guid].visuals[1].angles = (0, 0, 0);
  } else {
    var_07[0] = spawn("script_model", (0, 0, 0));
    var_07[0] setModel("dogtags_iw7_foe");
    var_07[1] = spawn("script_model", (0, 0, 0));
    var_07[1] setModel("dogtags_iw7_friend");
    if(level.numlifelimited) {
      var_07[0] setclientowner(param_00);
      var_07[1] setclientowner(param_00);
    }

    var_07[0] setasgametypeobjective();
    var_07[1] setasgametypeobjective();
    var_08 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    if(param_00 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
      if(var_05[2] < 0) {
        var_07[0].angles = var_06;
        var_07[1].angles = var_06;
      }
    }

    level.dogtags[param_00.guid] = scripts\mp\gameobjects::createuseobject("any", var_08, var_07, (0, 0, 16));
    level.dogtags[param_00.guid] scripts\mp\gameobjects::setusetime(0);
    level.dogtags[param_00.guid].onuse = ::onuse;
    level.dogtags[param_00.guid].victim = param_00;
    level.dogtags[param_00.guid].victimteam = param_00.team;
    level thread clearonvictimdisconnect(param_00);
    param_00 thread tagteamupdater(level.dogtags[param_00.guid]);
  }

  var_09 = param_00.origin + (0, 0, var_04);
  level.dogtags[param_00.guid].curorigin = var_09;
  level.dogtags[param_00.guid].trigger.origin = var_09;
  level.dogtags[param_00.guid].visuals[0].origin = var_09;
  level.dogtags[param_00.guid].visuals[1].origin = var_09;
  level.dogtags[param_00.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[param_00.guid] scripts\mp\gameobjects::allowuse("any");
  if(level.teambased) {
    level.dogtags[param_00.guid].visuals[0] thread showtoteam(level.dogtags[param_00.guid], param_01.team);
    level.dogtags[param_00.guid].visuals[1] thread showtoteam(level.dogtags[param_00.guid], param_00.team);
  } else {
    level.dogtags[param_00.guid] thread showtoffaattacker(level.dogtags[param_00.guid], param_01, param_00);
  }

  level.dogtags[param_00.guid].var_4F = param_01;
  level.dogtags[param_00.guid].attackerteam = param_01.team;
  if(level.dogtags[param_00.guid].teamobjids[param_00.team] != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(level.dogtags[param_00.guid].teamobjids[param_00.team], "active", var_09, "waypoint_dogtags_friendlys");
    if(level.numlifelimited) {
      scripts\mp\objidpoolmanager::minimap_objective_team(level.dogtags[param_00.guid].teamobjids[param_00.team], param_00.team);
    } else {
      scripts\mp\objidpoolmanager::minimap_objective_player(level.dogtags[param_00.guid].teamobjids[param_00.team], param_00 getentitynumber());
    }
  }

  if(level.dogtags[param_00.guid].teamobjids[param_01.team] != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(level.dogtags[param_00.guid].teamobjids[param_01.team], "active", var_09, "waypoint_dogtags");
    if(level.teambased) {
      scripts\mp\objidpoolmanager::minimap_objective_team(level.dogtags[param_00.guid].teamobjids[param_01.team], param_01.team);
    } else {
      scripts\mp\objidpoolmanager::minimap_objective_player(level.dogtags[param_00.guid].teamobjids[param_01.team], param_01 getentitynumber());
    }
  }

  playsoundatpos(var_09, "mp_killconfirm_tags_drop");
  level notify(param_02, level.dogtags[param_00.guid]);
  param_00.tagavailable = 1;
  level.dogtags[param_00.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  level.dogtags[param_00.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");
  if(level.numlifelimited) {
    param_00.getgrenadefusetime = "hud_status_dogtag";
  }
}

resettags() {
  self.var_4F = undefined;
  self notify("reset");
  self.visuals[0] hide();
  self.visuals[1] hide();
  self.visuals[0] dontinterpolate();
  self.visuals[1] dontinterpolate();
  self.curorigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  self.visuals[1].origin = (0, 0, 1000);
  scripts\mp\gameobjects::allowuse("none");
  if(self.teamobjids[self.victimteam] != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_state(self.teamobjids[self.victimteam], "invisible");
  }

  if(self.teamobjids[self.attackerteam] != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_state(self.teamobjids[self.attackerteam], "invisible");
  }
}

removetags(param_00, param_01) {
  if(isDefined(level.dogtags[param_00])) {
    level.dogtags[param_00] scripts\mp\gameobjects::allowuse("none");
    if(scripts\mp\utility::istrue(param_01) && isDefined(level.dogtags[param_00].var_4F)) {
      level.dogtags[param_00].var_4F thread scripts\mp\rank::scoreeventpopup("kill_denied");
    }

    playFX(level.conf_fx["vanish"], level.dogtags[param_00].curorigin);
    level.dogtags[param_00] notify("reset");
    wait(0.05);
    if(isDefined(level.dogtags[param_00])) {
      level.dogtags[param_00] notify("death");
      for(var_02 = 0; var_02 < level.dogtags[param_00].visuals.size; var_02++) {
        level.dogtags[param_00].visuals[var_02] delete();
      }

      level.dogtags[param_00] thread scripts\mp\gameobjects::deleteuseobject();
      level.dogtags[param_00] = undefined;
    }
  }
}

showtoteam(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("reset");
  self hide();
  foreach(var_03 in level.players) {
    if(var_03.team == param_01) {
      self showtoplayer(var_03);
    }

    if(var_03.team == "spectator" && param_01 == "allies") {
      self showtoplayer(var_03);
    }
  }

  for(;;) {
    level waittill("joined_team", var_03);
    if(var_03.team == param_01) {
      self showtoplayer(var_03);
    }

    if(var_03.team == "spectator" && param_01 == "allies") {
      self showtoplayer(var_03);
    }
  }
}

showtoffaattacker(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00 endon("reset");
  param_00.visuals[0] hide();
  param_00.visuals[1] hide();
  foreach(var_04 in level.players) {
    if(var_04 != param_02) {
      param_00.visuals[0] showtoplayer(var_04);
    } else {
      param_00.visuals[1] showtoplayer(var_04);
    }

    if(var_04.team == "spectator") {
      param_00.visuals[0] showtoplayer(var_04);
    }
  }

  for(;;) {
    level waittill("joined_team", var_04);
    param_00.visuals[0] showtoplayer(var_04);
  }
}

playercanusetags(param_00) {
  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    return 0;
  }

  return 1;
}

onuse(param_00) {
  if(!playercanusetags(param_00)) {
    return;
  }

  if(isDefined(param_00.triggerportableradarping)) {
    param_00 = param_00.triggerportableradarping;
  }

  if(level.gametype == "conf") {
    param_00 thread watchrapidtagpickup();
  }

  if(level.teambased) {
    if(param_00.pers["team"] == self.victimteam) {
      self.trigger playSound("mp_killconfirm_tags_deny");
      param_00 scripts\mp\utility::incperstat("denied", 1);
      param_00 scripts\mp\persistence::statsetchild("round", "denied", param_00.pers["denied"]);
      if(level.numlifelimited) {
        lifelimitedallyonuse(param_00);
      } else {
        allyonuse(param_00);
      }

      if(isDefined(level.dogtagallyonusecb) && !level.gameended) {
        self thread[[level.dogtagallyonusecb]](param_00);
      }
    } else {
      self.trigger playSound("mp_killconfirm_tags_pickup");
      if(level.gametype != "grind") {
        param_00 scripts\mp\utility::incperstat("confirmed", 1);
        param_00 scripts\mp\persistence::statsetchild("round", "confirmed", param_00.pers["confirmed"]);
      }

      if(level.numlifelimited) {
        lifelimitedenemyonuse(param_00);
      } else {
        enemyonuse(param_00);
      }

      if(isDefined(level.dogtagenemyonusecb) && !level.gameended) {
        self thread[[level.dogtagenemyonusecb]](param_00);
      }
    }
  } else {
    runffatagpickup(param_00);
  }

  self.victim notify("tag_removed");
  thread removetags(self.victim.guid);
}

runffatagpickup(param_00) {
  if(param_00 == self.victim) {
    self.trigger playSound("mp_killconfirm_tags_deny");
    allyonuse(param_00);
    if(isDefined(level.dogtagallyonusecb) && !level.gameended) {
      self thread[[level.dogtagallyonusecb]](param_00);
      return;
    }

    return;
  }

  self.trigger playSound("mp_killconfirm_tags_pickup");
  enemyonuse(param_00);
  if(isDefined(level.dogtagenemyonusecb) && !level.gameended) {
    self thread[[level.dogtagenemyonusecb]](param_00);
  }
}

watchrapidtagpickup() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("watchRapidTagPickup()");
  self endon("watchRapidTagPickup()");
  if(!isDefined(self.recenttagcount)) {
    self.recenttagcount = 1;
  } else {
    self.recenttagcount++;
    if(self.recenttagcount == 3) {
      thread scripts\mp\awards::givemidmatchaward("mode_kc_3_tags");
    }
  }

  wait(3);
  self.recenttagcount = 0;
}

tagteamupdater(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  param_00 endon("death");
  for(;;) {
    self waittill("joined_team");
    thread removetags(self.guid, 1);
  }
}

clearonvictimdisconnect(param_00) {
  param_00 notify("clearOnVictimDisconnect");
  param_00 endon("clearOnVictimDisconnect");
  param_00 endon("tag_removed");
  level endon("game_ended");
  var_01 = param_00.guid;
  param_00 waittill("disconnect");
  thread removetags(var_01, 1);
}

notifyteam(param_00, param_01, param_02) {
  var_03 = param_02.team;
  var_04 = scripts\mp\utility::getotherteam(var_03);
  foreach(var_06 in level.players) {
    if(var_06.team == var_03) {
      if(var_06 != param_02) {
        var_06 func_C16D(param_00);
      }

      continue;
    }

    if(var_06.team == var_04) {
      var_06 func_C16D(param_01);
    }
  }
}

func_C16D(param_00) {
  thread scripts\mp\hud_message::showsplash(param_00);
}

ontagpickupevent(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  while(!isDefined(self.pers)) {
    wait(0.05);
  }

  thread scripts\mp\utility::giveunifiedpoints(param_00);
}

lifelimitedallyonuse(param_00) {
  param_00.pers["rescues"]++;
  param_00 scripts\mp\persistence::statsetchild("round", "rescues", param_00.pers["rescues"]);
  notifyteam("sr_ally_respawned", "sr_enemy_respawned", self.victim);
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("sr_respawned");
    level notify("sr_player_respawned", self.victim);
    self.victim scripts\mp\utility::leaderdialogonplayer("revived");
    if(!level.gameended) {
      self.victim thread respawn();
    }

    self.victim.tagavailable = undefined;
    self.victim.getgrenadefusetime = "";
  }

  if(isDefined(self.var_4F)) {
    self.var_4F thread scripts\mp\rank::scoreeventpopup("kill_denied");
  }

  param_00 thread ontagpickupevent("kill_denied");
  param_00 scripts\mp\missions::processchallenge("ch_rescuer");
  if(!isDefined(param_00.rescuedplayers)) {
    param_00.rescuedplayers = [];
  }

  param_00.rescuedplayers[self.victim.guid] = 1;
  if(param_00.rescuedplayers.size == 4) {
    param_00 scripts\mp\missions::processchallenge("ch_helpme");
  }
}

lifelimitedenemyonuse(param_00) {
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("sr_eliminated");
    level notify("sr_player_eliminated", self.victim);
  }

  notifyteam("sr_ally_eliminated", "sr_enemy_eliminated", self.victim);
  if(isDefined(self.victim)) {
    if(!level.gameended) {
      self.victim scripts\mp\utility::setlowermessage("spawn_info", game["strings"]["spawn_next_round"]);
      self.victim thread scripts\mp\playerlogic::removespawnmessageshortly(3);
    }

    self.victim.tagavailable = undefined;
    self.victim.getgrenadefusetime = "hud_status_dead";
  }

  if(self.var_4F != param_00) {
    self.var_4F thread ontagpickupevent("kill_confirmed");
  }

  param_00 thread ontagpickupevent("kill_confirmed");
  param_00 scripts\mp\utility::leaderdialogonplayer("kill_confirmed");
  param_00 scripts\mp\missions::processchallenge("ch_hideandseek");
}

respawn() {
  scripts\mp\playerlogic::incrementalivecount(self.team);
  self.alreadyaddedtoalivecount = 1;
  thread func_136F9();
  func_12E58();
}

func_136F9() {
  for(;;) {
    wait(0.05);
    if(isDefined(self) && self.sessionstate == "spectator" || !scripts\mp\utility::isreallyalive(self)) {
      self.pers["lives"] = 1;
      scripts\mp\playerlogic::spawnclient();
      continue;
    }
  }
}

func_12E58() {
  if(isDefined(level.alive_players["allies"])) {
    setomnvar("ui_allies_alive", level.alive_players["allies"].size);
  }

  if(isDefined(level.alive_players["axis"])) {
    setomnvar("ui_axis_alive", level.alive_players["axis"].size);
  }
}

allyonuse(param_00) {
  if(self.victim == param_00) {
    param_00 thread scripts\mp\awards::givemidmatchaward("mode_kc_own_tags");
  } else if(level.gametype == "conf") {
    param_00 ontagpickupevent("kill_denied");
  } else {
    param_00 ontagpickupevent("tag_denied");
  }

  if(isDefined(self.var_4F)) {
    self.var_4F thread scripts\mp\rank::scoreeventpopup("tag_denied");
  }

  param_00 scripts\mp\missions::processchallenge("ch_denier");
}

enemyonuse(param_00) {
  if(level.gametype == "conf") {
    param_00 ontagpickupevent("kill_confirmed");
  } else {
    param_00 ontagpickupevent("tag_collected");
  }

  if(level.gametype == "grind") {
    param_00 playersettagcount(param_00.tagscarried + 1);
  }

  if(self.var_4F != param_00) {
    if(level.teambased) {
      self.var_4F thread ontagpickupevent("kc_friendly_pickup");
      if(isDefined(level.supportcranked) && level.supportcranked) {
        if(isDefined(self.var_4F.cranked) && self.var_4F.cranked) {
          param_00 scripts\mp\utility::setcrankedplayerbombtimer("kill");
        } else {
          self.var_4F scripts\mp\utility::oncranked(undefined, self.var_4F);
        }
      }
    } else {
      param_00 ontagpickupevent("kill_denied");
    }
  }

  param_00 scripts\mp\missions::processchallenge("ch_collector");
}

playersettagcount(param_00) {
  self.tagscarried = param_00;
  self.objective_additionalentity = param_00;
  if(param_00 > 999) {
    param_00 = 999;
  }

  self setclientomnvar("ui_grind_tags", param_00);
}