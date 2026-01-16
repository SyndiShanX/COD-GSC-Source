/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dogtag.gsc
***********************************************/

init() {
  level.dogtags = [];
  level.dogtagallyonusecb = scripts\mp\gametypes\common::dogtagallyonusecb;
  level.dogtagenemyonusecb = scripts\mp\gametypes\common::dogtagenemyonusecb;
  level.conf_fx["vanish"] = loadfx("vfx\core\impacts\small_snowhit");
  level.numlifelimited = scripts\mp\utility::getgametypenumlives();
}

shouldspawntags(var_0) {
  if(isDefined(self.switching_teams)) {
    return 0;
  }

  if(isDefined(var_0) && var_0 == self) {
    return 0;
  }

  if(level.teambased && isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team) {
    return 0;
  }

  if(isDefined(var_0) && !isDefined(var_0.team) && var_0.classname == "trigger_hurt" || var_0.classname == "worldspawn") {
    return 0;
  }

  return 1;
}

spawndogtags(var_0, var_1, var_2) {
  var_3 = 1;
  if(scripts\mp\utility::istrue(level.numlifelimited)) {
    var_3 = var_0 shouldspawntags(var_1);
    if(var_3) {
      var_3 = var_3 && !scripts\mp\utility::isreallyalive(var_0);
    }

    if(var_3) {
      var_3 = var_3 && !var_0 scripts\mp\playerlogic::mayspawn();
    }
  }

  if(!var_3) {
    return;
  }

  if(isagent(var_0)) {
    return;
  }

  if(isagent(var_1)) {
    var_1 = var_1.owner;
  }

  var_4 = 14;
  var_5 = (0, 0, 0);
  var_6 = var_0.angles;
  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_6 = var_0 getworldupreferenceangles();
    var_5 = anglestoup(var_6);
    if(var_5[2] < 0) {
      var_4 = -14;
    }
  }

  if(isDefined(level.dogtags[var_0.guid])) {
    playFX(level.conf_fx["vanish"], level.dogtags[var_0.guid].curorigin);
    level.dogtags[var_0.guid] resettags();
    level.dogtags[var_0.guid].visuals[0].angles = (0, 0, 0);
    level.dogtags[var_0.guid].visuals[1].angles = (0, 0, 0);
  } else {
    var_7[0] = spawn("script_model", (0, 0, 0));
    var_7[0] setModel("dogtags_iw7_foe");
    var_7[1] = spawn("script_model", (0, 0, 0));
    var_7[1] setModel("dogtags_iw7_friend");
    if(level.numlifelimited) {
      var_7[0] setclientowner(var_0);
      var_7[1] setclientowner(var_0);
    }

    var_7[0] setasgametypeobjective();
    var_7[1] setasgametypeobjective();
    var_8 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
      if(var_5[2] < 0) {
        var_7[0].angles = var_6;
        var_7[1].angles = var_6;
      }
    }

    level.dogtags[var_0.guid] = ::scripts\mp\gameobjects::createuseobject("any", var_8, var_7, (0, 0, 16));
    level.dogtags[var_0.guid] scripts\mp\gameobjects::setusetime(0);
    level.dogtags[var_0.guid].onuse = ::onuse;
    level.dogtags[var_0.guid].victim = var_0;
    level.dogtags[var_0.guid].victimteam = var_0.team;
    level thread clearonvictimdisconnect(var_0);
    var_0 thread tagteamupdater(level.dogtags[var_0.guid]);
  }

  var_9 = var_0.origin + (0, 0, var_4);
  level.dogtags[var_0.guid].curorigin = var_9;
  level.dogtags[var_0.guid].trigger.origin = var_9;
  level.dogtags[var_0.guid].visuals[0].origin = var_9;
  level.dogtags[var_0.guid].visuals[1].origin = var_9;
  level.dogtags[var_0.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[var_0.guid] scripts\mp\gameobjects::allowuse("any");
  if(level.teambased) {
    level.dogtags[var_0.guid].visuals[0] thread showtoteam(level.dogtags[var_0.guid], var_1.team);
    level.dogtags[var_0.guid].visuals[1] thread showtoteam(level.dogtags[var_0.guid], var_0.team);
  } else {
    level.dogtags[var_0.guid] thread showtoffaattacker(level.dogtags[var_0.guid], var_1, var_0);
  }

  level.dogtags[var_0.guid].var_4F = var_1;
  level.dogtags[var_0.guid].attackerteam = var_1.team;
  if(level.dogtags[var_0.guid].teamobjids[var_0.team] != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(level.dogtags[var_0.guid].teamobjids[var_0.team], "active", var_9, "waypoint_dogtags_friendlys");
    if(level.numlifelimited) {
      scripts\mp\objidpoolmanager::minimap_objective_team(level.dogtags[var_0.guid].teamobjids[var_0.team], var_0.team);
    } else {
      scripts\mp\objidpoolmanager::minimap_objective_player(level.dogtags[var_0.guid].teamobjids[var_0.team], var_0 getentitynumber());
    }
  }

  if(level.dogtags[var_0.guid].teamobjids[var_1.team] != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(level.dogtags[var_0.guid].teamobjids[var_1.team], "active", var_9, "waypoint_dogtags");
    if(level.teambased) {
      scripts\mp\objidpoolmanager::minimap_objective_team(level.dogtags[var_0.guid].teamobjids[var_1.team], var_1.team);
    } else {
      scripts\mp\objidpoolmanager::minimap_objective_player(level.dogtags[var_0.guid].teamobjids[var_1.team], var_1 getentitynumber());
    }
  }

  playsoundatpos(var_9, "mp_killconfirm_tags_drop");
  level notify(var_2, level.dogtags[var_0.guid]);
  var_0.tagavailable = 1;
  level.dogtags[var_0.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  level.dogtags[var_0.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");
  if(level.numlifelimited) {
    var_0.getgrenadefusetime = "hud_status_dogtag";
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

removetags(var_0, var_1) {
  if(isDefined(level.dogtags[var_0])) {
    level.dogtags[var_0] scripts\mp\gameobjects::allowuse("none");
    if(scripts\mp\utility::istrue(var_1) && isDefined(level.dogtags[var_0].var_4F)) {
      level.dogtags[var_0].var_4F thread scripts\mp\rank::scoreeventpopup("kill_denied");
    }

    playFX(level.conf_fx["vanish"], level.dogtags[var_0].curorigin);
    level.dogtags[var_0] notify("reset");
    wait(0.05);
    if(isDefined(level.dogtags[var_0])) {
      level.dogtags[var_0] notify("death");
      for(var_2 = 0; var_2 < level.dogtags[var_0].visuals.size; var_2++) {
        level.dogtags[var_0].visuals[var_2] delete();
      }

      level.dogtags[var_0] thread scripts\mp\gameobjects::deleteuseobject();
      level.dogtags[var_0] = undefined;
    }
  }
}

showtoteam(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("reset");
  self hide();
  foreach(var_3 in level.players) {
    if(var_3.team == var_1) {
      self showtoplayer(var_3);
    }

    if(var_3.team == "spectator" && var_1 == "allies") {
      self showtoplayer(var_3);
    }
  }

  for(;;) {
    level waittill("joined_team", var_3);
    if(var_3.team == var_1) {
      self showtoplayer(var_3);
    }

    if(var_3.team == "spectator" && var_1 == "allies") {
      self showtoplayer(var_3);
    }
  }
}

showtoffaattacker(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("reset");
  var_0.visuals[0] hide();
  var_0.visuals[1] hide();
  foreach(var_4 in level.players) {
    if(var_4 != var_2) {
      var_0.visuals[0] showtoplayer(var_4);
    } else {
      var_0.visuals[1] showtoplayer(var_4);
    }

    if(var_4.team == "spectator") {
      var_0.visuals[0] showtoplayer(var_4);
    }
  }

  for(;;) {
    level waittill("joined_team", var_4);
    var_0.visuals[0] showtoplayer(var_4);
  }
}

playercanusetags(var_0) {
  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    return 0;
  }

  return 1;
}

onuse(var_0) {
  if(!playercanusetags(var_0)) {
    return;
  }

  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
  }

  if(level.gametype == "conf") {
    var_0 thread watchrapidtagpickup();
  }

  if(level.teambased) {
    if(var_0.pers["team"] == self.victimteam) {
      self.trigger playSound("mp_killconfirm_tags_deny");
      var_0 scripts\mp\utility::incperstat("denied", 1);
      var_0 scripts\mp\persistence::statsetchild("round", "denied", var_0.pers["denied"]);
      if(level.numlifelimited) {
        lifelimitedallyonuse(var_0);
      } else {
        allyonuse(var_0);
      }

      if(isDefined(level.dogtagallyonusecb) && !level.gameended) {
        self thread[[level.dogtagallyonusecb]](var_0);
      }
    } else {
      self.trigger playSound("mp_killconfirm_tags_pickup");
      if(level.gametype != "grind") {
        var_0 scripts\mp\utility::incperstat("confirmed", 1);
        var_0 scripts\mp\persistence::statsetchild("round", "confirmed", var_0.pers["confirmed"]);
      }

      if(level.numlifelimited) {
        lifelimitedenemyonuse(var_0);
      } else {
        enemyonuse(var_0);
      }

      if(isDefined(level.dogtagenemyonusecb) && !level.gameended) {
        self thread[[level.dogtagenemyonusecb]](var_0);
      }
    }
  } else {
    runffatagpickup(var_0);
  }

  self.victim notify("tag_removed");
  thread removetags(self.victim.guid);
}

runffatagpickup(var_0) {
  if(var_0 == self.victim) {
    self.trigger playSound("mp_killconfirm_tags_deny");
    allyonuse(var_0);
    if(isDefined(level.dogtagallyonusecb) && !level.gameended) {
      self thread[[level.dogtagallyonusecb]](var_0);
      return;
    }

    return;
  }

  self.trigger playSound("mp_killconfirm_tags_pickup");
  enemyonuse(var_0);
  if(isDefined(level.dogtagenemyonusecb) && !level.gameended) {
    self thread[[level.dogtagenemyonusecb]](var_0);
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

tagteamupdater(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  for(;;) {
    self waittill("joined_team");
    thread removetags(self.guid, 1);
  }
}

clearonvictimdisconnect(var_0) {
  var_0 notify("clearOnVictimDisconnect");
  var_0 endon("clearOnVictimDisconnect");
  var_0 endon("tag_removed");
  level endon("game_ended");
  var_1 = var_0.guid;
  var_0 waittill("disconnect");
  thread removetags(var_1, 1);
}

notifyteam(var_0, var_1, var_2) {
  var_3 = var_2.team;
  var_4 = scripts\mp\utility::getotherteam(var_3);
  foreach(var_6 in level.players) {
    if(var_6.team == var_3) {
      if(var_6 != var_2) {
        var_6 func_C16D(var_0);
      }

      continue;
    }

    if(var_6.team == var_4) {
      var_6 func_C16D(var_1);
    }
  }
}

func_C16D(var_0) {
  thread scripts\mp\hud_message::showsplash(var_0);
}

ontagpickupevent(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  while(!isDefined(self.pers)) {
    wait(0.05);
  }

  thread scripts\mp\utility::giveunifiedpoints(var_0);
}

lifelimitedallyonuse(var_0) {
  var_0.pers["rescues"]++;
  var_0 scripts\mp\persistence::statsetchild("round", "rescues", var_0.pers["rescues"]);
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

  var_0 thread ontagpickupevent("kill_denied");
  var_0 scripts\mp\missions::processchallenge("ch_rescuer");
  if(!isDefined(var_0.rescuedplayers)) {
    var_0.rescuedplayers = [];
  }

  var_0.rescuedplayers[self.victim.guid] = 1;
  if(var_0.rescuedplayers.size == 4) {
    var_0 scripts\mp\missions::processchallenge("ch_helpme");
  }
}

lifelimitedenemyonuse(var_0) {
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

  if(self.var_4F != var_0) {
    self.var_4F thread ontagpickupevent("kill_confirmed");
  }

  var_0 thread ontagpickupevent("kill_confirmed");
  var_0 scripts\mp\utility::leaderdialogonplayer("kill_confirmed");
  var_0 scripts\mp\missions::processchallenge("ch_hideandseek");
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

allyonuse(var_0) {
  if(self.victim == var_0) {
    var_0 thread scripts\mp\awards::givemidmatchaward("mode_kc_own_tags");
  } else if(level.gametype == "conf") {
    var_0 ontagpickupevent("kill_denied");
  } else {
    var_0 ontagpickupevent("tag_denied");
  }

  if(isDefined(self.var_4F)) {
    self.var_4F thread scripts\mp\rank::scoreeventpopup("tag_denied");
  }

  var_0 scripts\mp\missions::processchallenge("ch_denier");
}

enemyonuse(var_0) {
  if(level.gametype == "conf") {
    var_0 ontagpickupevent("kill_confirmed");
  } else {
    var_0 ontagpickupevent("tag_collected");
  }

  if(level.gametype == "grind") {
    var_0 playersettagcount(var_0.tagscarried + 1);
  }

  if(self.var_4F != var_0) {
    if(level.teambased) {
      self.var_4F thread ontagpickupevent("kc_friendly_pickup");
      if(isDefined(level.supportcranked) && level.supportcranked) {
        if(isDefined(self.var_4F.cranked) && self.var_4F.cranked) {
          var_0 scripts\mp\utility::setcrankedplayerbombtimer("kill");
        } else {
          self.var_4F scripts\mp\utility::oncranked(undefined, self.var_4F);
        }
      }
    } else {
      var_0 ontagpickupevent("kill_denied");
    }
  }

  var_0 scripts\mp\missions::processchallenge("ch_collector");
}

playersettagcount(var_0) {
  self.tagscarried = var_0;
  self.objective_additionalentity = var_0;
  if(var_0 > 999) {
    var_0 = 999;
  }

  self setclientomnvar("ui_grind_tags", var_0);
}