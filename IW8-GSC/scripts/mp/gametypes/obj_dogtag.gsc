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
    level.ref_136cd = &ref_136cc;
  }

  level.numlifelimited = scripts\mp\utility\game::getgametypenumlives();
}

function shouldspawntags(var0) {
  if(isDefined(self.switching_teams)) {
    return false;
  }

  if(isDefined(var0) && var0 == self) {
    return false;
  }

  if(level.teambased && isDefined(var0) && isDefined(var0.team) && var0.team == self.team) {
    return false;
  }

  if(isDefined(var0) && !isDefined(var0.team) && (var0.classname == "trigger_hurt" || var0.classname == "worldspawn")) {
    return false;
  }

  return true;
}

function spawndogtags(var0, var1, var2, var3) {
  var4 = 1;

  if(istrue(level.numlifelimited)) {
    var4 = shouldspawntags(var0, var1);

    if(var4) {
      var4 = var4 && !scripts\mp\utility\player::isreallyalive(var0);
    }

    if(var4) {
      var4 = var4 && !var0 scripts\mp\playerlogic::mayspawn();
    }
  }

  if(!var4) {
    return;
  }

  if(isagent(var0)) {
    return;
  }

  if(isagent(var1)) {
    var1 = var1.owner;
  }

  var5 = 14;
  var6 = (0, 0, 0);
  var7 = var0.angles;

  if(var0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var7 = var0 getworldupreferenceangles();
    var6 = anglestoup(var7);

    if(var6[2] < 0) {
      var5 = -14;
    }
  }

  if(isDefined(level.dogtags[var0.guid])) {
    if(istrue(level.playinggulagbink)) {
      playFX(level.conf_fx["vanish_gos"], level.dogtags[var0.guid].curorigin);
    } else if(istrue(level.setplayerselfrevivingextrainfo)) {
      playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], level.dogtags[var0.guid].curorigin);
    } else {
      playFX(level.conf_fx["vanish"], level.dogtags[var0.guid].curorigin);
    }

    resettags(level.dogtags[var0.guid]);
    level.dogtags[var0.guid].visuals[0].angles = (0, 0, 0);
    level.dogtags[var0.guid].visuals[1].angles = (0, 0, 0);
  } else {
    if(istrue(level.setplayerselfrevivingextrainfo)) {
      GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)));
    }

    GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)));
  }

  var12 = var0.origin + (0, 0, var5);
  level.dogtags[var0.guid].curorigin = var12;
  level.dogtags[var0.guid].trigger.origin = var12;
  level.dogtags[var0.guid].visuals[0].origin = var12;
  level.dogtags[var0.guid].visuals[1].origin = var12;
  level.dogtags[var0.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[var0.guid] scripts\mp\gameobjects::allowuse("any");
  showtoteam(level.dogtags[var0.guid].visuals[0], level.dogtags[var0.guid], var1.team);
  showtoteam(level.dogtags[var0.guid].visuals[1], level.dogtags[var0.guid], var0.team);
  level.dogtags[var0.guid].attacker = var1;
  level.dogtags[var0.guid].attackerteam = var1.team;
  level.dogtags[var0.guid].ownerteam = var0.team;

  if(isDefined(level.dogtags[var0.guid].objidnum)) {
    if(level.dogtags[var0.guid].objidnum != -1) {
      var13 = level.dogtags[var0.guid].objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var13, "current");
      scripts\mp\objidpoolmanager::update_objective_position(var13, var0.origin + (0, 0, 36));
      scripts\mp\objidpoolmanager::update_objective_setbackground(var13, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(level.dogtags[var0.guid].objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(level.dogtags[var0.guid].objidnum, 0);

      if(istrue(level.setplayerselfrevivingextrainfo)) {
        level.dogtags[var0.guid] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_skull_fr", "waypoint_dogtags_skull");
      } else {
        level.dogtags[var0.guid] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
      }

      level.dogtags[var0.guid] scripts\mp\gameobjects::setvisibleteam("any");
    }
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    playsoundatpos(var12, "mp_killconfirm_tags_drop_hw");
  } else {
    playsoundatpos(var12, "mp_killconfirm_tags_drop");
  }

  level notify(var2, level.dogtags[var0.guid]);
  var0.tagavailable = 1;
  level.dogtags[var0.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  level.dogtags[var0.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");

  if(level.numlifelimited) {
    var0.statusicon = "hud_status_dogtag";
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

function removetags(var0, var1, var2) {
  if(isDefined(level.dogtags[var0])) {
    level.dogtags[var0] scripts\mp\gameobjects::allowuse("none");

    if(istrue(var1) && isDefined(level.dogtags[var0].attacker)) {
      level.dogtags[var0].attacker thread scripts\mp\rank::scoreeventpopup("kill_denied");
    }

    if(istrue(level.playinggulagbink)) {
      if(isDefined(level.ref_136cd)) {
        level[[level.ref_136cd]](level.dogtags[var0], var2);
      }
    } else if(istrue(level.setplayerselfrevivingextrainfo)) {
      if(isDefined(var2) && var2.team == level.dogtags[var0].ownerteam) {
        playFX(level.conf_fx["vanish"], level.dogtags[var0].curorigin);
        playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], level.dogtags[var0].curorigin + (0, 0, 45));
      } else {
        playFX(level.conf_fx["vanish"], level.dogtags[var0].curorigin);
        playFX(level.spawnoffsettacinsertmax["vanish_hw_en"], level.dogtags[var0].curorigin + (0, 0, 45));
      }
    } else {
      playFX(level.conf_fx["vanish"], level.dogtags[var0].curorigin);
    }

    level.dogtags[var0] notify("reset");
    waitframe();

    if(isDefined(level.dogtags[var0])) {
      level.dogtags[var0] notify("death");

      for(var3 = 0; var3 < level.dogtags[var0].visuals.size; var3++) {
        level.dogtags[var0].visuals[var3] delete();
      }

      if(!isDefined(level.dogtags[var0].skipminimapids)) {
        level.dogtags[var0] thread scripts\mp\gameobjects::deleteuseobject();
      }

      level.dogtags[var0] = undefined;
      return;
    }

    return;
  }
}

function ref_136cc(var0, var1) {
  var2 = 20;
  var3 = 600;
  var4 = var0.curorigin + (0, 0, var2);
  var5 = var0.curorigin + (0, 0, var3);
  var6 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var7 = [];
  GscBinSkip0(0x2e, var7.size, var0.visuals[0]);
}

function onplayerjoinedteam(var0) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  foreach(var2 in level.dogtags) {
    if(isDefined(var2.attackerteam)) {
      if(var0.team == var2.attackerteam) {
        var2.visuals[0] showtoplayer(var0);
      }

      if(var0.team == "spectator" && var2.attackerteam == "allies") {
        var2.visuals[0] showtoplayer(var0);
      }
    }

    if(isDefined(var2.ownerteam)) {
      if(var0.team == var2.ownerteam) {
        var2.visuals[1] showtoplayer(var0);
      }

      if(var0.team == "spectator" && var2.ownerteam == "allies") {
        var2.visuals[1] showtoplayer(var0);
      }
    }
  }
}

function showtoteam(var0, var1) {
  self hide();

  foreach(var3 in level.players) {
    if(var3.team == var1) {
      self showtoplayer(var3);
    }

    if(var3.team == "spectator" && var1 == "allies") {
      self showtoplayer(var3);
    }
  }
}

function playercanusetags(var0) {
  return true;
}

function onuse(var0) {
  if(!playercanusetags(var0)) {
    return;
  }

  if(isDefined(var0.owner)) {
    var0 = var0.owner;
  }

  if(scripts\mp\utility\game::getgametype() == "conf") {
    thread watchrapidtagpickup();
  }

  if(var0.pers["team"] == self.victimteam) {
    if(istrue(level.setplayerselfrevivingextrainfo)) {
      self.trigger playSound("mp_killconfirm_tags_deny_hw");
    } else {
      self.trigger playSound("mp_killconfirm_tags_deny");
    }

    var0 scripts\mp\utility\stats::incpersstat("denied", 1);
    var0 scripts\mp\persistence::statsetchild("round", "denied", var0.pers["denied"]);

    if(level.numlifelimited && scripts\mp\utility\game::getgametype() != "arena") {
      lifelimitedallyonuse(var0);
    } else {
      allyonuse(var0);
    }

    if(isDefined(level.dogtagallyonusecb) && !level.gameended) {
      self thread[[level.dogtagallyonusecb]](var0);
    }
  } else {
    if(istrue(level.setplayerselfrevivingextrainfo)) {
      self.trigger playSound("mp_killconfirm_tags_pickup_hw");
    } else {
      self.trigger playSound("mp_killconfirm_tags_pickup");
    }

    if(scripts\mp\utility\game::getgametype() != "grind" && scripts\mp\utility\game::getgametype() != "pill") {
      var0 scripts\mp\utility\stats::incpersstat("confirmed", 1);
      var0 scripts\mp\persistence::statsetchild("round", "confirmed", var0.pers["confirmed"]);
    }

    if(level.numlifelimited && scripts\mp\utility\game::getgametype() != "arena") {
      lifelimitedenemyonuse(var0);
    } else {
      enemyonuse(var0);
    }

    if(isDefined(level.dogtagenemyonusecb) && !level.gameended) {
      self thread[[level.dogtagenemyonusecb]](var0);
    }

    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
  }

  self.victim notify("tag_removed");
  thread removetags(self.victim.guid, undefined, var0);
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

function tagteamupdater(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var0 endon("death");

  for(;;) {
    self waittill("joined_team");
    thread removetags(self.guid, 1);
  }
}

function clearonvictimdisconnect(var0) {
  var0 notify("clearOnVictimDisconnect");
  var0 endon("clearOnVictimDisconnect");
  var0 endon("tag_removed");
  level endon("game_ended");
  var1 = var0.guid;
  var0 waittill("disconnect");
  thread removetags(var1, 1);
}

function ontagpickupevent(var0) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  thread scripts\mp\utility\points::giveunifiedpoints(var0);
}

function lifelimitedallyonuse(var0) {
  var0.pers["rescues"]++;
  var0 scripts\mp\persistence::statsetchild("round", "rescues", var0.pers["rescues"]);
  var1 = [];
  GscBinSkip0(0x2e, var1.size, self.victim);
}

function lifelimitedenemyonuse(var0) {
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("sr_eliminated");
    level notify("sr_player_eliminated", self.victim);
  }

  var1 = [];
  GscBinSkip0(0x2e, var1.size, self.victim);
}

function respawn() {
  scripts\mp\playerlogic::incrementalivecount(self.team);
  self.alreadyaddedtoalivecount = 1;
  thread scripts\mp\playerlogic::waittillcanspawnclient();
}

function allyonuse(var0) {
  if(self.victim == var0) {
    var0 thread scripts\mp\rank::scoreeventpopup("tag_retrieved");
    var0 thread scripts\mp\awards::givemidmatchaward("mode_kc_own_tags");
  } else if(issubstr(scripts\mp\utility\game::getgametype(), "conf")) {
    ontagpickupevent(var0, "kill_denied");
  } else if(scripts\mp\utility\game::getgametype() != "grind") {
    ontagpickupevent(var0, "tag_denied");
  } else {
    ontagpickupevent(var0, "tag_collected");
    playersettagcount(var0, var0.tagscarried + 1);
  }

  if(isDefined(self.attacker)) {
    self.attacker thread scripts\mp\rank::scoreeventpopup("tag_denied");
  }

  if(isDefined(level.supportcranked) && level.supportcranked) {
    if(isDefined(var0.cranked) && var0.cranked) {
      var0 scripts\mp\cranked::setcrankedplayerbombtimer("friendly_tag");
      return;
    }

    var0 scripts\mp\cranked::oncranked(undefined, var0);
    return;
  }
}

function enemyonuse(var0) {
  if(issubstr(scripts\mp\utility\game::getgametype(), "conf")) {
    ontagpickupevent(var0, "kill_confirmed");
  } else {
    ontagpickupevent(var0, "tag_collected");
  }

  if(scripts\mp\utility\game::getgametype() == "grind") {
    playersettagcount(var0, var0.tagscarried + 1);
  }

  if(self.attacker != var0) {
    if(scripts\mp\utility\game::getgametype() == "grind") {
      thread ontagpickupevent(self.attacker);
    } else {
      thread ontagpickupevent(self.attacker);
    }
  }

  if(isDefined(level.supportcranked) && level.supportcranked) {
    if(isDefined(var0.cranked) && var0.cranked) {
      var0 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
    } else {
      var0 scripts\mp\cranked::oncranked(undefined, var0);
    }

    if(var0 != self.attacker && isDefined(self.attacker.cranked) && self.attacker.cranked) {
      self.attacker scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      return;
    }

    return;
  }
}

function playersettagcount(var0) {
  self.tagscarried = var0;
  self.game_extrainfo = var0;

  if(var0 > 999) {
    var0 = 999;
  }

  self setclientomnvar("ui_grind_tags", var0);
}