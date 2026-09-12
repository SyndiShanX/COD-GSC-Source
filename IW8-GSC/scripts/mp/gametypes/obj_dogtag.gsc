/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dogtag.gsc
***********************************************/

function init() {
  level.dogtags = [];
  level.dogtagallyonusecb = &scripts\mp\gametypes\common::dogtagcommonallyonusecb;
  level.dogtagenemyonusecb = &scripts\mp\gametypes\common::dogtagcommonenemyonusecb;
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  level.conf_fx["vanish_gos"] = loadfx("vfx/iw8_mp/gamemode/vfx_gos_tag_pickup.vfx");
  level.spawnoffsettacinsertmax["vanish_hw_fr"] = loadfx("vfx/iw8_mp/gamemode/vfx_halloween_kc_capture_friendly.vfx");
  level.spawnoffsettacinsertmax["vanish_hw_en"] = loadfx("vfx/iw8_mp/gamemode/vfx_halloween_kc_capture_enemy.vfx");

  if(istrue(level.playinggulagbink)) {
    level.ref_136CD = &ref_136CC;
  }

  level.numlifelimited = scripts\mp\utility\game::getgametypenumlives();
}

function shouldspawntags(var_0) {
  if(isDefined(self.switching_teams)) {
    return false;
  }

  if(isDefined(var_0) && var_0 == self) {
    return false;
  }

  if(level.teambased && isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team) {
    return false;
  }

  if(isDefined(var_0) && !isDefined(var_0.team) && (var_0.classname == "trigger_hurt" || var_0.classname == "worldspawn")) {
    return false;
  }

  return true;
}

function spawndogtags(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(istrue(level.numlifelimited)) {
    var_4 = shouldspawntags(var_0, var_1);

    if(var_4) {
      var_4 = var_4 && !scripts\mp\utility\player::isreallyalive(var_0);
    }

    if(var_4) {
      var_4 = var_4 && !var_0 scripts\mp\playerlogic::mayspawn();
    }
  }

  if(!var_4) {
    return;
  }

  if(isagent(var_0)) {
    return;
  }

  if(isagent(var_1)) {
    var_1 = var_1.owner;
  }

  var_5 = 14;
  var_6 = (0, 0, 0);
  var_7 = var_0.angles;

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_7 = var_0 getworldupreferenceangles();
    var_6 = anglestoup(var_7);

    if(var_6[2] < 0) {
      var_5 = -14;
    }
  }

  if(isDefined(level.dogtags[var_0.guid])) {
    if(istrue(level.playinggulagbink)) {
      playFX(level.conf_fx["vanish_gos"], level.dogtags[var_0.guid].curorigin);
    } else if(istrue(level.setplayerselfrevivingextrainfo)) {
      playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], level.dogtags[var_0.guid].curorigin);
    } else {
      playFX(level.conf_fx["vanish"], level.dogtags[var_0.guid].curorigin);
    }

    resettags(level.dogtags[var_0.guid]);
    level.dogtags[var_0.guid].visuals[0].angles = (0, 0, 0);
    level.dogtags[var_0.guid].visuals[1].angles = (0, 0, 0);
  } else {
    if(istrue(level.setplayerselfrevivingextrainfo)) {
      GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)));
    }

    GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)));
  }

  var_12 = var_0.origin + (0, 0, var_5);
  level.dogtags[var_0.guid].curorigin = var_12;
  level.dogtags[var_0.guid].trigger.origin = var_12;
  level.dogtags[var_0.guid].visuals[0].origin = var_12;
  level.dogtags[var_0.guid].visuals[1].origin = var_12;
  level.dogtags[var_0.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[var_0.guid] scripts\mp\gameobjects::allowuse("any");
  showtoteam(level.dogtags[var_0.guid].visuals[0], level.dogtags[var_0.guid], var_1.team);
  showtoteam(level.dogtags[var_0.guid].visuals[1], level.dogtags[var_0.guid], var_0.team);
  level.dogtags[var_0.guid].attacker = var_1;
  level.dogtags[var_0.guid].attackerteam = var_1.team;
  level.dogtags[var_0.guid].ownerteam = var_0.team;

  if(isDefined(level.dogtags[var_0.guid].objidnum)) {
    if(level.dogtags[var_0.guid].objidnum != -1) {
      var_13 = level.dogtags[var_0.guid].objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var_13, "current");
      scripts\mp\objidpoolmanager::update_objective_position(var_13, var_0.origin + (0, 0, 36));
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_13, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(level.dogtags[var_0.guid].objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(level.dogtags[var_0.guid].objidnum, 0);

      if(istrue(level.setplayerselfrevivingextrainfo)) {
        level.dogtags[var_0.guid] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_skull_fr", "waypoint_dogtags_skull");
      } else {
        level.dogtags[var_0.guid] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
      }

      level.dogtags[var_0.guid] scripts\mp\gameobjects::setvisibleteam("any");
    }
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    playsoundatpos(var_12, "mp_killconfirm_tags_drop_hw");
  } else {
    playsoundatpos(var_12, "mp_killconfirm_tags_drop");
  }

  level notify(var_2, level.dogtags[var_0.guid]);
  var_0.tagavailable = 1;
  level.dogtags[var_0.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  level.dogtags[var_0.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");

  if(level.numlifelimited) {
    var_0.statusicon = "hud_status_dogtag";
    return;
  }
}

function resettags() {
  self.attacker = undefined;
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

  if(self.objidnum != -1) {
    scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, "done");
    return;
  }
}

function removetags(var_0, var_1, var_2) {
  if(isDefined(level.dogtags[var_0])) {
    level.dogtags[var_0] scripts\mp\gameobjects::allowuse("none");

    if(istrue(var_1) && isDefined(level.dogtags[var_0].attacker)) {
      level.dogtags[var_0].attacker thread scripts\mp\rank::scoreeventpopup("kill_denied");
    }

    if(istrue(level.playinggulagbink)) {
      if(isDefined(level.ref_136CD)) {
        level[[level.ref_136CD]](level.dogtags[var_0], var_2);
      }
    } else if(istrue(level.setplayerselfrevivingextrainfo)) {
      if(isDefined(var_2) && var_2.team == level.dogtags[var_0].ownerteam) {
        playFX(level.conf_fx["vanish"], level.dogtags[var_0].curorigin);
        playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], level.dogtags[var_0].curorigin + (0, 0, 45));
      } else {
        playFX(level.conf_fx["vanish"], level.dogtags[var_0].curorigin);
        playFX(level.spawnoffsettacinsertmax["vanish_hw_en"], level.dogtags[var_0].curorigin + (0, 0, 45));
      }
    } else {
      playFX(level.conf_fx["vanish"], level.dogtags[var_0].curorigin);
    }

    level.dogtags[var_0] notify("reset");
    waitframe();

    if(isDefined(level.dogtags[var_0])) {
      level.dogtags[var_0] notify("death");

      for(var_3 = 0; var_3 < level.dogtags[var_0].visuals.size; var_3++) {
        level.dogtags[var_0].visuals[var_3] delete();
      }

      if(!isDefined(level.dogtags[var_0].skipminimapids)) {
        level.dogtags[var_0] thread scripts\mp\gameobjects::deleteuseobject();
      }

      level.dogtags[var_0] = undefined;
      return;
    }

    return;
  }
}

function ref_136CC(var_0, var_1) {
  var_2 = 20;
  var_3 = 600;
  var_4 = var_0.curorigin + (0, 0, var_2);
  var_5 = var_0.curorigin + (0, 0, var_3);
  var_6 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_7 = [];
  GscBinSkip0(0x2e, var_7.size, var_0.visuals[0]);
}

function onplayerjoinedteam(var_0) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  foreach(var_2 in level.dogtags) {
    if(isDefined(var_2.attackerteam)) {
      if(var_0.team == var_2.attackerteam) {
        var_2.visuals[0] showtoplayer(var_0);
      }

      if(var_0.team == "spectator" && var_2.attackerteam == "allies") {
        var_2.visuals[0] showtoplayer(var_0);
      }
    }

    if(isDefined(var_2.ownerteam)) {
      if(var_0.team == var_2.ownerteam) {
        var_2.visuals[1] showtoplayer(var_0);
      }

      if(var_0.team == "spectator" && var_2.ownerteam == "allies") {
        var_2.visuals[1] showtoplayer(var_0);
      }
    }
  }
}

function showtoteam(var_0, var_1) {
  self hide();

  foreach(var_3 in level.players) {
    if(var_3.team == var_1) {
      self showtoplayer(var_3);
    }

    if(var_3.team == "spectator" && var_1 == "allies") {
      self showtoplayer(var_3);
    }
  }
}

function playercanusetags(var_0) {
  return true;
}

function onuse(var_0) {
  if(!playercanusetags(var_0)) {
    return;
  }

  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
  }

  if(scripts\mp\utility\game::getgametype() == "conf") {
    thread watchrapidtagpickup();
  }

  if(var_0.pers["team"] == self.victimteam) {
    if(istrue(level.setplayerselfrevivingextrainfo)) {
      self.trigger playSound("mp_killconfirm_tags_deny_hw");
    } else {
      self.trigger playSound("mp_killconfirm_tags_deny");
    }

    var_0 scripts\mp\utility\stats::incpersstat("denied", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "denied", var_0.pers["denied"]);

    if(level.numlifelimited && scripts\mp\utility\game::getgametype() != "arena") {
      lifelimitedallyonuse(var_0);
    } else {
      allyonuse(var_0);
    }

    if(isDefined(level.dogtagallyonusecb) && !level.gameended) {
      self thread[[level.dogtagallyonusecb]](var_0);
    }
  } else {
    if(istrue(level.setplayerselfrevivingextrainfo)) {
      self.trigger playSound("mp_killconfirm_tags_pickup_hw");
    } else {
      self.trigger playSound("mp_killconfirm_tags_pickup");
    }

    if(scripts\mp\utility\game::getgametype() != "grind" && scripts\mp\utility\game::getgametype() != "pill") {
      var_0 scripts\mp\utility\stats::incpersstat("confirmed", 1);
      var_0 scripts\mp\persistence::statsetchild("round", "confirmed", var_0.pers["confirmed"]);
    }

    if(level.numlifelimited && scripts\mp\utility\game::getgametype() != "arena") {
      lifelimitedenemyonuse(var_0);
    } else {
      enemyonuse(var_0);
    }

    if(isDefined(level.dogtagenemyonusecb) && !level.gameended) {
      self thread[[level.dogtagenemyonusecb]](var_0);
    }

    var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
  }

  self.victim notify("tag_removed");
  thread removetags(self.victim.guid, undefined, var_0);
}

function watchrapidtagpickup() {
  level endon("game_ended");
  self endon("death_or_disconnect");
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

  wait 3;
  self.recenttagcount = 0;
}

function tagteamupdater(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");

  for(;;) {
    self waittill("joined_team");
    thread removetags(self.guid, 1);
  }
}

function clearonvictimdisconnect(var_0) {
  var_0 notify("clearOnVictimDisconnect");
  var_0 endon("clearOnVictimDisconnect");
  var_0 endon("tag_removed");
  level endon("game_ended");
  var_1 = var_0.guid;
  var_0 waittill("disconnect");
  thread removetags(var_1, 1);
}

function ontagpickupevent(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  thread scripts\mp\utility\points::giveunifiedpoints(var_0);
}

function lifelimitedallyonuse(var_0) {
  var_0.pers["rescues"]++;
  var_0 scripts\mp\persistence::statsetchild("round", "rescues", var_0.pers["rescues"]);
  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, self.victim);
}

function lifelimitedenemyonuse(var_0) {
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("sr_eliminated");
    level notify("sr_player_eliminated", self.victim);
  }

  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, self.victim);
}

function respawn() {
  scripts\mp\playerlogic::incrementalivecount(self.team);
  self.alreadyaddedtoalivecount = 1;
  thread scripts\mp\playerlogic::waittillcanspawnclient();
}

function allyonuse(var_0) {
  if(self.victim == var_0) {
    var_0 thread scripts\mp\rank::scoreeventpopup("tag_retrieved");
    var_0 thread scripts\mp\awards::givemidmatchaward("mode_kc_own_tags");
  } else if(issubstr(scripts\mp\utility\game::getgametype(), "conf")) {
    ontagpickupevent(var_0, "kill_denied");
  } else if(scripts\mp\utility\game::getgametype() != "grind") {
    ontagpickupevent(var_0, "tag_denied");
  } else {
    ontagpickupevent(var_0, "tag_collected");
    playersettagcount(var_0, var_0.tagscarried + 1);
  }

  if(isDefined(self.attacker)) {
    self.attacker thread scripts\mp\rank::scoreeventpopup("tag_denied");
  }

  if(isDefined(level.supportcranked) && level.supportcranked) {
    if(isDefined(var_0.cranked) && var_0.cranked) {
      var_0 scripts\mp\cranked::setcrankedplayerbombtimer("friendly_tag");
      return;
    }

    var_0 scripts\mp\cranked::oncranked(undefined, var_0);
    return;
  }
}

function enemyonuse(var_0) {
  if(issubstr(scripts\mp\utility\game::getgametype(), "conf")) {
    ontagpickupevent(var_0, "kill_confirmed");
  } else {
    ontagpickupevent(var_0, "tag_collected");
  }

  if(scripts\mp\utility\game::getgametype() == "grind") {
    playersettagcount(var_0, var_0.tagscarried + 1);
  }

  if(self.attacker != var_0) {
    if(scripts\mp\utility\game::getgametype() == "grind") {
      thread ontagpickupevent(self.attacker);
    } else {
      thread ontagpickupevent(self.attacker);
    }
  }

  if(isDefined(level.supportcranked) && level.supportcranked) {
    if(isDefined(var_0.cranked) && var_0.cranked) {
      var_0 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
    } else {
      var_0 scripts\mp\cranked::oncranked(undefined, var_0);
    }

    if(var_0 != self.attacker && isDefined(self.attacker.cranked) && self.attacker.cranked) {
      self.attacker scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      return;
    }

    return;
  }
}

function playersettagcount(var_0) {
  self.tagscarried = var_0;
  self.game_extrainfo = var_0;

  if(var_0 > 999) {
    var_0 = 999;
  }

  self setclientomnvar("ui_grind_tags", var_0);
}