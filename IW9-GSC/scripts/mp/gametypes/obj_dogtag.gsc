/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_dogtag.gsc
***********************************************/

init() {
  level.dogtags = [];
  level.dogtagallyonusecb = _id_0FD32F08E72B657F::dogtagcommonallyonusecb;
  level.dogtagenemyonusecb = _id_0FD32F08E72B657F::dogtagcommonenemyonusecb;
  level._id_50F07451CAEB4973 = getdvarint("dvar_77FB2F8819915F5C", 1) == 1;
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  level.conf_fx["vanish_gos"] = loadfx("vfx/iw8_mp/gamemode/vfx_gos_tag_pickup.vfx");

  if(istrue(level._id_DD7AF80C3EB2C1E0))
    level._id_5261F4479B04F834 = ::_id_C2A00A1D31F16522;

  level.numlifelimited = scripts\mp\utility\game::getgametypenumlives();
}

shouldspawntags(attacker) {
  if(isDefined(self.switching_teams))
    return 0;

  if(isDefined(attacker) && attacker == self)
    return 0;

  if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team)
    return 0;

  if(isDefined(attacker) && !isDefined(attacker.team) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn"))
    return 0;

  if(_id_2CEDCC356F1B9FC8::isplayeringulag())
    return 0;

  return 1;
}

spawndogtags(victim, attacker, _id_1202C39784B176E2, meansofdeath) {
  shouldspawntags = 1;

  if(istrue(level.numlifelimited)) {
    shouldspawntags = victim shouldspawntags(attacker);

    if(shouldspawntags)
      shouldspawntags = shouldspawntags && !scripts\mp\utility\player::isreallyalive(victim);

    if(shouldspawntags)
      shouldspawntags = shouldspawntags && !victim scripts\mp\playerlogic::mayspawn();
  }

  if(!shouldspawntags) {
    return;
  }
  if(isagent(victim)) {
    return;
  }
  if(isagent(attacker))
    attacker = attacker.owner;

  tagoffset = _id_4B5BF3A3091D471E()[2];
  upangles = (0, 0, 0);
  _id_650440C6A1642E7E = victim.angles;

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    _id_650440C6A1642E7E = victim getworldupreferenceangles();
    upangles = anglestoup(_id_650440C6A1642E7E);

    if(upangles[2] < 0)
      tagoffset = tagoffset * -1;
  }

  if(isDefined(level.dogtags[victim.guid])) {
    if(istrue(level._id_DD7AF80C3EB2C1E0))
      playFX(level.conf_fx["vanish_gos"], level.dogtags[victim.guid].curorigin);
    else
      playFX(level.conf_fx["vanish"], level.dogtags[victim.guid].curorigin);

    level.dogtags[victim.guid] resettags();
    level.dogtags[victim.guid].visuals[0].angles = (0, 0, 0);
    level.dogtags[victim.guid].visuals[1].angles = (0, 0, 0);
  } else {
    visuals[0] = spawn("script_model", (0, 0, 0));
    visuals[1] = spawn("script_model", (0, 0, 0));
    visuals[0] setModel(_id_C8A7BF223BAF8A6C());
    visuals[1] setModel(_id_1E4C1C053EA20DD5());

    if(level.numlifelimited) {
      visuals[0] setclientowner(victim);
      visuals[1] setclientowner(victim);
    }

    visuals[0] setasgametypeobjective();
    visuals[1] setasgametypeobjective();
    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);

    if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
      if(upangles[2] < 0) {
        visuals[0].angles = _id_650440C6A1642E7E;
        visuals[1].angles = _id_650440C6A1642E7E;
      }
    }

    useteam = "any";
    usetime = 0;
    level.dogtags[victim.guid] = scripts\mp\gameobjects::createuseobject(useteam, trigger, visuals, (0, 0, 16));
    level.dogtags[victim.guid].onuse = ::onuse;
    level.dogtags[victim.guid] scripts\mp\gameobjects::setusetime(usetime);
    level.dogtags[victim.guid].victim = victim;
    level.dogtags[victim.guid].victimteam = victim.team;
    level.dogtags[victim.guid].offset3d = (0, 0, 24);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(level.dogtags[victim.guid].objidnum, level.dogtags[victim.guid].offset3d[2]);
    level thread clearonvictimdisconnect(victim);
    victim thread tagteamupdater(level.dogtags[victim.guid]);
  }

  pos = victim.origin + (0, 0, tagoffset);
  level.dogtags[victim.guid].curorigin = pos;
  level.dogtags[victim.guid].trigger.origin = pos;
  level.dogtags[victim.guid].visuals[0].origin = pos;
  level.dogtags[victim.guid].visuals[1].origin = pos;
  level.dogtags[victim.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[victim.guid] scripts\mp\gameobjects::allowuse("any");
  level.dogtags[victim.guid].visuals[0] showtoteam(level.dogtags[victim.guid], attacker.team);
  level.dogtags[victim.guid].visuals[1] showtoteam(level.dogtags[victim.guid], victim.team);
  level.dogtags[victim.guid].attacker = attacker;
  level.dogtags[victim.guid].attackerteam = attacker.team;
  level.dogtags[victim.guid].ownerteam = victim.team;

  if(isDefined(level.dogtags[victim.guid].objidnum)) {
    if(level.dogtags[victim.guid].objidnum != -1) {
      objid = level.dogtags[victim.guid].objidnum;
      state = "current";

      if(!istrue(level._id_50F07451CAEB4973))
        state = "active";

      scripts\mp\objidpoolmanager::update_objective_state(objid, state);
      scripts\mp\objidpoolmanager::update_objective_position(objid, victim.origin + (0, 0, 36));
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(level.dogtags[victim.guid].objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(level.dogtags[victim.guid].objidnum, 0);
      scripts\mp\objidpoolmanager::_id_098BA077848896A3(level.dogtags[victim.guid].objidnum, 0);
      scripts\mp\objidpoolmanager::_id_F21E9B2E78DE984B(level.dogtags[victim.guid].objidnum, 800, 1600);
      level.dogtags[victim.guid] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
      level.dogtags[victim.guid] scripts\mp\gameobjects::setvisibleteam("any");
    }
  }

  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    playsoundatpos(pos, "mp_killconfirm_tags_drop_hlwn");
  else
    playsoundatpos(pos, "mp_killconfirm_tags_drop");

  level notify(_id_1202C39784B176E2, level.dogtags[victim.guid]);
  victim.tagavailable = 1;
  level.dogtags[victim.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  level.dogtags[victim.guid].visuals[1] scriptmodelplayanim("mp_dogtag_spin");
  _id_F793A9FD32C1A72B(level.dogtags[victim.guid]);

  if(level.numlifelimited)
    victim.statusicon = "hud_status_dogtag";
}

resettags() {
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

  if(self.objidnum != -1)
    scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, "done");
}

removetags(guid, _id_3737240CEFE2C793, _id_3B7F2500E2C4760C) {
  if(istrue(self._id_BCB19026623AF98B)) {
    foreach(key, tag in level.dogtags) {
      if(tag == self) {
        guid = key;
        break;
      }
    }
  }

  if(isDefined(level.dogtags[guid])) {
    level.dogtags[guid] scripts\mp\gameobjects::allowuse("none");

    if(istrue(_id_3737240CEFE2C793) && isDefined(level.dogtags[guid].attacker))
      level.dogtags[guid].attacker thread scripts\mp\rank::scoreeventpopup("stat_31C5E73863EE8289");

    if(istrue(level._id_DD7AF80C3EB2C1E0)) {
      if(isDefined(level._id_5261F4479B04F834))
        level[[level._id_5261F4479B04F834]](level.dogtags[guid], _id_3B7F2500E2C4760C);
    } else
      playFX(level.conf_fx["vanish"], level.dogtags[guid].curorigin);

    level.dogtags[guid] notify("reset");
    waitframe();

    if(!isDefined(level.dogtags[guid])) {
      return;
    }
    if(!istrue(level.dogtags[guid]._id_BCB19026623AF98B)) {
      level.dogtags[guid] notify("death");

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.dogtags[guid].visuals.size; _id_AC0E594AC96AA3A8++)
        level.dogtags[guid].visuals[_id_AC0E594AC96AA3A8] delete();

      if(!isDefined(level.dogtags[guid].skipminimapids))
        level.dogtags[guid] thread scripts\mp\gameobjects::deleteuseobject();

      level.dogtags[guid] = undefined;
    } else {
      level.dogtags[guid] scripts\mp\gameobjects::disableobject();
      level.dogtags[guid].visuals[0] hide();
      level.dogtags[guid].visuals[1] hide();
    }
  }
}

_id_C2A00A1D31F16522(dogtags, _id_3B7F2500E2C4760C) {
  _id_869E9FD0CDBD405A = 20;
  _id_12F59CD9E8D7E077 = 600;
  _id_16C9AD20A2797135 = dogtags.curorigin + (0, 0, _id_869E9FD0CDBD405A);
  _id_812238F6F1F6728C = dogtags.curorigin + (0, 0, _id_12F59CD9E8D7E077);
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  ignoreents[ignoreents.size] = dogtags.visuals[0];
  ignoreents[ignoreents.size] = dogtags.visuals[1];

  if(isPlayer(_id_3B7F2500E2C4760C))
    ignoreents[ignoreents.size] = _id_3B7F2500E2C4760C;

  trace = scripts\engine\trace::ray_trace(_id_16C9AD20A2797135, _id_812238F6F1F6728C, ignoreents, contentoverride, 0);

  if(isPlayer(trace["entity"]))
    trace["entity"] = undefined;

  if(isDefined(trace["entity"]) && isDefined(trace["entity"].code_classname) && trace["entity"].code_classname == "script_vehicle") {
    ignoreents[ignoreents.size] = trace["entity"];
    trace = scripts\engine\trace::ray_trace(_id_16C9AD20A2797135, _id_812238F6F1F6728C, ignoreents, contentoverride, 0);
  }

  if(trace["fraction"] != 1)
    playFX(level.conf_fx["vanish_gos"], dogtags.curorigin);
  else {
    playFX(level.conf_fx["vanish_gos"], dogtags.curorigin);
    playFX(level._id_B6E1C0B3C715B0DF["gos_fireworks"], dogtags.curorigin);
    level thread _id_0FD32F08E72B657F::_id_2C3362A9F434FD8D(dogtags.curorigin);
  }
}

onplayerjoinedteam(player) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  foreach(tags in level.dogtags) {
    if(isDefined(tags.attackerteam)) {
      if(player.team == tags.attackerteam)
        tags.visuals[0] showtoplayer(player);

      if(player.team == "spectator" && tags.attackerteam == "allies")
        tags.visuals[0] showtoplayer(player);
    }

    if(isDefined(tags.ownerteam)) {
      if(player.team == tags.ownerteam)
        tags.visuals[1] showtoplayer(player);

      if(player.team == "spectator" && tags.ownerteam == "allies")
        tags.visuals[1] showtoplayer(player);
    }
  }
}

showtoteam(gameobject, team) {
  self hide();

  foreach(player in level.players) {
    if(player.team == team)
      self showtoplayer(player);

    if(player.team == "spectator" && team == "allies")
      self showtoplayer(player);

    if(player.team == "codcaster")
      self showtoplayer(player);
  }
}

playercanusetags(player) {
  return 1;
}

onuse(player) {
  if(!playercanusetags(player)) {
    return;
  }
  if(isDefined(player.owner))
    player = player.owner;

  if(scripts\mp\utility\game::getgametype() == "conf")
    player thread watchrapidtagpickup();

  if(player.pers["team"] == self.victimteam) {
    if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
      self.trigger playSound("mp_killconfirm_tags_deny_hlwn");
    else
      self.trigger playSound("mp_killconfirm_tags_deny");

    player scripts\mp\utility\stats::incpersstat("denied", 1);
    player scripts\mp\persistence::statsetchild("round", "denied", player.pers["denied"]);

    if(level.numlifelimited && scripts\mp\utility\game::getgametype() != "arena")
      lifelimitedallyonuse(player);
    else
      allyonuse(player);

    if(isDefined(level.dogtagallyonusecb) && !level.gameended)
      self thread[[level.dogtagallyonusecb]](player);
  } else {
    if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
      self.trigger playSound("mp_killconfirm_tags_pickup_hlwn");
    else
      self.trigger playSound("mp_killconfirm_tags_pickup");

    if(scripts\mp\utility\game::getgametype() != "grind" && scripts\mp\utility\game::getgametype() != "pill") {
      player scripts\mp\utility\stats::incpersstat("confirmed", 1);
      player scripts\mp\persistence::statsetchild("round", "confirmed", player.pers["confirmed"]);
    }

    if(level.numlifelimited && scripts\mp\utility\game::getgametype() != "arena")
      lifelimitedenemyonuse(player);
    else
      enemyonuse(player);

    if(isDefined(level.dogtagenemyonusecb) && !level.gameended)
      self thread[[level.dogtagenemyonusecb]](player);

    player scripts\cp_mp\challenges::oncapture();
  }

  self.victim notify("tag_removed");
  thread removetags(self.victim.guid, undefined, player);
}

watchrapidtagpickup() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("watchRapidTagPickup()");
  self endon("watchRapidTagPickup()");

  if(!isDefined(self.recenttagcount))
    self.recenttagcount = 1;
  else {
    self.recenttagcount++;

    if(self.recenttagcount == 3)
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_538A87430E9CF381");
  }

  wait 3.0;
  self.recenttagcount = 0;
}

tagteamupdater(tags) {
  level endon("game_ended");
  self endon("disconnect");
  tags endon("death");

  for(;;) {
    self waittill("joined_team");
    thread removetags(self.guid, 1);
  }
}

clearonvictimdisconnect(victim) {
  victim notify("clearOnVictimDisconnect");
  victim endon("clearOnVictimDisconnect");
  victim endon("tag_removed");
  level endon("game_ended");
  guid = victim.guid;
  victim waittill("disconnect");
  thread removetags(guid, 1);
}

ontagpickupevent(event) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers))
    waitframe();

  thread scripts\mp\utility\points::_id_0366980B6A8796AE(event);
}

lifelimitedallyonuse(player) {
  player.pers["rescues"]++;
  player scripts\mp\persistence::statsetchild("round", "rescues", player.pers["rescues"]);
  _id_4725E52B7C3AA25C = [];
  _id_4725E52B7C3AA25C[_id_4725E52B7C3AA25C.size] = self.victim;
  scripts\mp\hud_message::notifyteam("sr_ally_respawned", "sr_enemy_respawned", self.victim);

  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("sr_respawned");
    level notify("sr_player_respawned", self.victim);
    self.victim scripts\mp\utility\dialog::leaderdialogonplayer("revived");

    if(!level.gameended)
      self.victim thread respawn();

    self.victim.tagavailable = undefined;
    self.victim.statusicon = "";
  }

  if(isDefined(self.attacker))
    self.attacker thread scripts\mp\rank::scoreeventpopup("stat_31C5E73863EE8289");

  player thread ontagpickupevent("stat_31C5E73863EE8289");

  if(!isDefined(player.rescuedplayers))
    player.rescuedplayers = [];

  player.rescuedplayers[self.victim.guid] = 1;
  self.victim scripts\mp\killstreaks\killstreaks::_id_B7492842AAD6FE82();
}

lifelimitedenemyonuse(player) {
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("sr_eliminated");
    level notify("sr_player_eliminated", self.victim);
  }

  _id_4725E52B7C3AA25C = [];
  _id_4725E52B7C3AA25C[_id_4725E52B7C3AA25C.size] = self.victim;
  scripts\mp\hud_message::notifyteam("sr_ally_eliminated", "sr_enemy_eliminated", self.victim);

  if(isDefined(self.victim)) {
    if(!level.gameended) {
      self.victim scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_next_round");
      self.victim thread scripts\mp\playerlogic::removespawnmessageshortly(3.0);
    }

    self.victim.tagavailable = undefined;
    self.victim.statusicon = "hud_status_dead";
  }

  if(self.attacker != player)
    self.attacker thread ontagpickupevent("stat_E24741BA71BBB56B");

  player thread ontagpickupevent("stat_E24741BA71BBB56B");
  player scripts\mp\utility\dialog::leaderdialogonplayer("kill_confirmed");
}

respawn() {
  scripts\mp\playerlogic::incrementalivecount(self.team);
  self.alreadyaddedtoalivecount = 1;
  thread scripts\mp\playerlogic::waittillcanspawnclient();
}

allyonuse(player) {
  if(self.victim == player) {
    player thread scripts\mp\rank::scoreeventpopup("stat_8567CA81F8C59D3C");
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_E4042D7EF2CD089E");
  } else if(issubstr(scripts\mp\utility\game::getgametype(), "conf"))
    player ontagpickupevent("stat_31C5E73863EE8289");
  else if(scripts\mp\utility\game::getgametype() != "grind")
    player ontagpickupevent("stat_C164717864E640FF");
  else {
    player ontagpickupevent("stat_B89E7559B23A1287");
    player playersettagcount(player.tagscarried + 1);
  }

  if(isDefined(self.attacker))
    self.attacker thread scripts\mp\rank::scoreeventpopup("stat_C164717864E640FF");

  if(scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(player)) {
    if(isDefined(player.cranked) && player.cranked)
      player scripts\mp\cranked::setcrankedplayerbombtimer("friendly_tag");
    else
      player scripts\mp\cranked::oncranked(undefined, player);
  }
}

enemyonuse(player) {
  if(issubstr(scripts\mp\utility\game::getgametype(), "conf"))
    player ontagpickupevent("stat_E24741BA71BBB56B");
  else
    player ontagpickupevent("stat_B89E7559B23A1287");

  if(scripts\mp\utility\game::getgametype() == "grind")
    player playersettagcount(player.tagscarried + 1);

  if(self.attacker != player) {
    if(scripts\mp\utility\game::getgametype() == "grind")
      self.attacker thread ontagpickupevent("stat_FEC13AD5EA891DCE");
    else
      self.attacker thread ontagpickupevent("stat_BE03C8D7051ADFA8");
  }

  if(scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(player)) {
    if(isDefined(player.cranked) && player.cranked)
      player scripts\mp\cranked::setcrankedplayerbombtimer("kill");
    else
      player scripts\mp\cranked::oncranked(undefined, player);

    if(player != self.attacker && isDefined(self.attacker.cranked) && self.attacker.cranked)
      self.attacker scripts\mp\cranked::setcrankedplayerbombtimer("kill");
  }
}

playersettagcount(_id_D86673173E8641BE) {
  self.tagscarried = _id_D86673173E8641BE;
  self.game_extrainfo = _id_D86673173E8641BE;

  if(_id_D86673173E8641BE > 999)
    _id_D86673173E8641BE = 999;

  self setclientomnvar("ui_grind_tags", _id_D86673173E8641BE);
}

_id_4B5BF3A3091D471E() {
  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    return (0, 0, 36);

  return (0, 0, 14);
}

_id_C8A7BF223BAF8A6C() {
  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    return "military_dogtags_iw9_red_hlwn";

  return "military_dogtags_iw9_red";
}

_id_1E4C1C053EA20DD5() {
  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    return "military_dogtags_iw9_blue_hlwn";

  return "military_dogtags_iw9_blue";
}

_id_BB30BF75EAFD434C() {
  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    return "hud_icon_minimap_misc_haunting_skull";

  return "hud_icon_minimap_misc_dog_tag";
}

_id_F793A9FD32C1A72B(tag) {
  if(!_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2()) {
    return;
  }
  if(isDefined(tag)) {
    thread _id_15B31CDCE9502371(tag);
    thread _id_3CB2D6C46A560C73(tag);
  }
}

_id_15B31CDCE9502371(tag) {
  tag notify("rotate_halloween_event_tag");
  level endon("game_ended");
  tag endon("reset");
  tag endon("death");
  tag endon("rotate_halloween_event_tag");

  for(;;) {
    tag.visuals[0] rotateYaw(360.0, 2.0);
    tag.visuals[1] rotateYaw(360.0, 2.0);
    wait 2.0;
  }
}

_id_3CB2D6C46A560C73(tag) {
  tag notify("bob_halloween_event_tag");
  level endon("game_ended");
  tag endon("reset");
  tag endon("death");
  tag endon("bob_halloween_event_tag");
  _id_D1C2F2174BAAE4D6 = 9.0;
  frequency = 1.0;
  _id_1D5DB5EEFD5BE7C6 = frequency * 0.4;
  _id_B6689F84DACEB617 = frequency * 0.4;
  tag.visuals[0] moveTo(tag.visuals[0].origin + (0.0, 0.0, _id_D1C2F2174BAAE4D6 * 0.5), frequency * 0.5, _id_1D5DB5EEFD5BE7C6 * 0.5, _id_B6689F84DACEB617 * 0.5);
  tag.visuals[1] moveTo(tag.visuals[1].origin + (0.0, 0.0, _id_D1C2F2174BAAE4D6 * 0.5), frequency * 0.5, _id_1D5DB5EEFD5BE7C6 * 0.5, _id_B6689F84DACEB617 * 0.5);

  for(;;) {
    tag.visuals[0] moveTo(tag.visuals[0].origin - (0.0, 0.0, _id_D1C2F2174BAAE4D6), frequency, _id_1D5DB5EEFD5BE7C6, _id_B6689F84DACEB617);
    tag.visuals[1] moveTo(tag.visuals[1].origin - (0.0, 0.0, _id_D1C2F2174BAAE4D6), frequency, _id_1D5DB5EEFD5BE7C6, _id_B6689F84DACEB617);
    wait(frequency);
    tag.visuals[0] moveTo(tag.visuals[0].origin + (0.0, 0.0, _id_D1C2F2174BAAE4D6), frequency, _id_1D5DB5EEFD5BE7C6, _id_B6689F84DACEB617);
    tag.visuals[1] moveTo(tag.visuals[1].origin + (0.0, 0.0, _id_D1C2F2174BAAE4D6), frequency, _id_1D5DB5EEFD5BE7C6, _id_B6689F84DACEB617);
    wait(frequency);
  }
}