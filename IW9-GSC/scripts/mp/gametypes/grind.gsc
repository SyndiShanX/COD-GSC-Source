/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\grind.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "dom";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.dogtagsplayer = [];
  _id_4055DE5045BF885A::init();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  level.modeonsuicidedeath = ::onsuicidedeath;
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_grnd_mode_uktl_gnt1";
  else
    game["dialog"]["gametype"] = "iw9_grnd_mode_uktl_gdnm";

  game["dialog"]["boost"] = "iw9_grnd_mode_uktl_gdbo";
  game["dialog"]["offense_obj"] = "iw9_grnd_mode_uktl_gdbo";
  game["dialog"]["defense_obj"] = "iw9_grnd_mode_uktl_gdbo";
  game["dialog"]["grind_active_a"] = "iw9_grnd_mode_uktl_gdaa";
  game["dialog"]["grind_active_b"] = "iw9_grnd_mode_uktl_gdab";
  game["dialog"]["grind_inactive_a"] = "iw9_grnd_mode_uktl_gdia";
  game["dialog"]["grind_inactive_b"] = "iw9_grnd_mode_uktl_gdib";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_grind_banktime", getmatchrulesdata("grindData", "bankTime"));
  setdynamicdvar("scr_grind_bankrate", getmatchrulesdata("grindData", "bankRate"));
  setdynamicdvar("scr_grind_bankcapturetime", getmatchrulesdata("grindData", "bankCaptureTime"));
  setdynamicdvar("scr_grind_bankDisable", getmatchrulesdata("grindData", "bankDisable"));
  setdynamicdvar("scr_grind_bankDisableTags", getmatchrulesdata("grindData", "bankDisableTags"));
  setdynamicdvar("scr_grind_bankDisableTime", getmatchrulesdata("grindData", "bankDisableTime"));
  setdynamicdvar("scr_grind_megabanklimit", getmatchrulesdata("grindData", "megaBankLimit"));
  setdynamicdvar("scr_grind_megabankbonusks", getmatchrulesdata("grindData", "megaBankBonusKS"));
  setdynamicdvar("scr_grind_bankbonus", getmatchrulesdata("grindData", "megaBankBonus"));
  setdynamicdvar("dvar_044442340F98878C", 0);
  scripts\mp\utility\game::registerhalftimedvar("grind", 0);
  setdynamicdvar("scr_grind_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  scripts\mp\utility\game::setobjectivetext("allies", &"OBJECTIVES/WAR");
  scripts\mp\utility\game::setobjectivetext("axis", &"OBJECTIVES/WAR");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/WAR");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/WAR");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/WAR_SCORE");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/WAR_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext("allies", &"OBJECTIVES/WAR_HINT");
  scripts\mp\utility\game::setobjectivehinttext("axis", &"OBJECTIVES/WAR_HINT");
  initspawns();
  createtags();
  level.dogtagallyonusecb = ::dogtagallyonusecb;
  setupwaypointicons();
  thread createzones();
  level thread removetagsongameended();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.banktime = scripts\mp\utility\dvars::dvarfloatvalue("bankTime", 2, 0, 10);
  level.bankrate = scripts\mp\utility\dvars::dvarintvalue("bankRate", 1, 1, 10);
  level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue("bankCaptureTime", 0, 0, 10);
  level.bankdisable = scripts\mp\utility\dvars::dvarintvalue("bankDisable", 1, 0, 1);
  level.bankdisabletags = scripts\mp\utility\dvars::dvarintvalue("bankDisableTags", 0, 0, 50);
  level.bankdisabletime = scripts\mp\utility\dvars::dvarintvalue("bankDisableTime", 0, 0, 120);
  level.megabanklimit = scripts\mp\utility\dvars::dvarintvalue("megaBankLimit", 5, 5, 15);
  level.megabankbonusks = scripts\mp\utility\dvars::dvarintvalue("megaBankBonusKS", 1, 0, 10);
  level.megabankbonus = scripts\mp\utility\dvars::dvarintvalue("megaBankBonus", 150, 0, 750);
  scorelimit = scripts\mp\utility\dvars::getwatcheddvar("scorelimit");

  if(scorelimit == 0 && level.bankdisabletags == 0)
    level.bankdisable = 0;
  else if(level.bankdisabletags == 0 && scorelimit > 0)
    level.bankdisabletags = int(scorelimit);
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("bank_tags");

  if(isDefined(self.tagscarried))
    self setclientomnvar("ui_grind_tags", self.tagscarried);
}

onsuicidedeath(victim) {
  self setclientomnvar("ui_grind_tags", 0);
  level thread droptags(victim);
}

createtags() {
  level.dogtags = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
    visuals[0] = spawn("script_model", (0, 0, 0));
    visuals[1] = spawn("script_model", (0, 0, 0));
    visuals[0] setModel(_id_1CEA1B70A5AAD392::_id_C8A7BF223BAF8A6C());
    visuals[1] setModel(_id_1CEA1B70A5AAD392::_id_1E4C1C053EA20DD5());
    visuals[0] scriptmodelplayanim("mp_dogtag_spin");
    visuals[1] scriptmodelplayanim("mp_dogtag_spin");

    if(visuals[0] isscriptable())
      visuals[0] setscriptablepartstate("visibility", "hide", 0);
    else
      visuals[0] hide();

    if(visuals[1] isscriptable())
      visuals[1] setscriptablepartstate("visibility", "hide", 0);
    else
      visuals[1] hide();

    visuals[0] setasgametypeobjective();
    visuals[1] setasgametypeobjective();
    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    trigger.targetname = "trigger_dogtag";
    trigger hide();
    _id_34744859AD58739B = spawnStruct();
    _id_34744859AD58739B.type = "useObject";
    _id_34744859AD58739B.curorigin = trigger.origin;
    _id_34744859AD58739B.entnum = trigger getentitynumber();
    _id_34744859AD58739B.lastusedtime = 0;
    _id_34744859AD58739B.visuals = visuals;
    _id_34744859AD58739B.offset3d = (0, 0, 16);
    _id_34744859AD58739B.trigger = trigger;
    _id_34744859AD58739B.trigger enablelinkTo();
    _id_34744859AD58739B.triggertype = "proximity";
    _id_34744859AD58739B scripts\mp\gameobjects::allowuse("none");
    level.dogtags[level.dogtags.size] = _id_34744859AD58739B;
  }
}

gettag() {
  _id_5D32298B837DFF31 = level.dogtags[0];
  _id_3071102F98CBED33 = gettime();

  foreach(tag in level.dogtags) {
    if(!isDefined(tag.lastusedtime)) {
      continue;
    }
    if(istrue(tag._id_BCB19026623AF98B)) {
      continue;
    }
    if(tag.interactteam == "none") {
      _id_5D32298B837DFF31 = tag;
      break;
    }

    if(tag.lastusedtime < _id_3071102F98CBED33) {
      _id_3071102F98CBED33 = tag.lastusedtime;
      _id_5D32298B837DFF31 = tag;
    }
  }

  _id_5D32298B837DFF31 notify("reset");
  _id_5D32298B837DFF31 scripts\mp\gameobjects::initializetagpathvariables();
  _id_5D32298B837DFF31.lastusedtime = gettime();
  return _id_5D32298B837DFF31;
}

spawntag(victim) {
  _id_76A22C18960F72AF = victim.origin;
  _id_F835C152B2F0F136 = victim.team;
  startpos = _id_76A22C18960F72AF + (0, 0, 14);
  zoffset = 35;
  stance = victim getstance();

  if(stance == "prone")
    zoffset = 14;

  if(stance == "crouch")
    zoffset = 25;

  _id_9C19496CE8106E6B = _id_76A22C18960F72AF + _id_1CEA1B70A5AAD392::_id_4B5BF3A3091D471E();
  randomangle = (0, randomfloat(360), 0);
  _id_A76189155F382805 = anglesToForward(randomangle);
  _id_A73587155F07BD39 = randomfloatrange(30, 150);
  _id_57C87883AE437750 = 0.5;
  _id_90128D0639A1315D = startpos + _id_A73587155F07BD39 * _id_A76189155F382805;
  _id_B809B8F732448A84 = playerphysicstrace(startpos, _id_90128D0639A1315D);
  _id_34744859AD58739B = gettag();
  _id_34744859AD58739B.curorigin = _id_9C19496CE8106E6B;
  _id_34744859AD58739B.trigger.origin = _id_9C19496CE8106E6B;
  _id_34744859AD58739B.visuals[0].origin = _id_9C19496CE8106E6B;
  _id_34744859AD58739B.visuals[1].origin = _id_9C19496CE8106E6B;
  _id_34744859AD58739B.team = victim.team;
  _id_34744859AD58739B.interactteam = "any";
  _id_34744859AD58739B.trigger show();
  _id_34744859AD58739B.trigger linkTo(_id_34744859AD58739B.visuals[0], "tag_origin");
  _id_34744859AD58739B.trigger linkTo(_id_34744859AD58739B.visuals[1], "tag_origin");

  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
    playsoundatpos(startpos, "mp_grind_token_drop_hlwn");
  else
    playsoundatpos(startpos, "mp_grind_token_drop");

  _id_1CEA1B70A5AAD392::_id_F793A9FD32C1A72B(_id_34744859AD58739B);
  _id_34744859AD58739B thread tagmoveTo(_id_F835C152B2F0F136, _id_9C19496CE8106E6B, _id_B809B8F732448A84, _id_57C87883AE437750);
  return _id_34744859AD58739B;
}

tagmoveTo(_id_F835C152B2F0F136, _id_9C19496CE8106E6B, _id_B809B8F732448A84, time) {
  scripts\mp\gameobjects::allowuse("any");
  self.visuals[0] showtoteam(self, scripts\mp\utility\game::getotherteam(_id_F835C152B2F0F136)[0]);
  self.visuals[1] showtoteam(self, _id_F835C152B2F0F136);
  self.visuals[0] setasgametypeobjective();
  self.visuals[1] setasgametypeobjective();
  gravity = getdvarint("bg_gravity");
  dist = distance(_id_9C19496CE8106E6B, _id_B809B8F732448A84);
  _id_3777ECE6A73EADA5 = _id_B809B8F732448A84 - _id_9C19496CE8106E6B;
  _id_920F4173513EB6B8 = 0.5 * gravity * squared(time) * -1;
  vel = (_id_3777ECE6A73EADA5[0] / time, _id_3777ECE6A73EADA5[1] / time, (_id_3777ECE6A73EADA5[2] - _id_920F4173513EB6B8) / time);
  self._id_7454869824E72AAE = 1;
  self.visuals[0] movegravity(vel, time);
  self.visuals[1] movegravity(vel, time);
  wait 1;
  self.curorigin = _id_B809B8F732448A84;
  self._id_7454869824E72AAE = undefined;
}

showtoteam(gameobject, team) {
  gameobject endon("death");
  gameobject endon("reset");

  if(self isscriptable())
    self setscriptablepartstate("visibility", "show", 0);
  else
    self show();
}

monitortaguse(tag) {
  level endon("game_ended");
  tag endon("deleted");
  tag endon("reset");

  for(;;) {
    tag.trigger waittill("trigger", player);

    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(player scripts\mp\utility\player::isusingremote() || isDefined(player.spawningafterremotedeath)) {
      continue;
    }
    if(isDefined(player.classname) && player.classname == "script_vehicle") {
      continue;
    }
    if(isagent(player) && isDefined(player.owner))
      player = player.owner;

    if(tag.visuals[0] isscriptable())
      tag.visuals[0] setscriptablepartstate("visibility", "hide", 0);
    else
      tag.visuals[0] hide();

    if(tag.visuals[1] isscriptable())
      tag.visuals[1] setscriptablepartstate("visibility", "hide", 0);
    else
      tag.visuals[1] hide();

    tag.trigger hide();
    tag.curorigin = (0, 0, 1000);
    tag.trigger.origin = (0, 0, 1000);
    tag.visuals[0].origin = (0, 0, 1000);
    tag.visuals[1].origin = (0, 0, 1000);
    tag scripts\mp\gameobjects::allowuse("none");
    player playersettagcount(player.tagscarried + 1);
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B89E7559B23A1287");

    if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
      player playSound("mp_grind_token_pickup_hlwn");
    else
      player playSound("mp_grind_token_pickup");

    if(scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(player)) {
      if(isDefined(player.cranked) && player.cranked)
        player scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      else
        player scripts\mp\cranked::oncranked(undefined, player);
    }

    break;
  }
}

onplayerconnect(player) {
  player.isscoring = 0;
  player thread monitorjointeam();
}

playersettagcount(_id_D86673173E8641BE) {
  self.tagscarried = _id_D86673173E8641BE;
  self.game_extrainfo = _id_D86673173E8641BE;

  if(_id_D86673173E8641BE > 999)
    _id_D86673173E8641BE = 999;

  self setclientomnvar("ui_grind_tags", _id_D86673173E8641BE);
}

monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
    playersettagcount(0);
  }
}

hidehudelementongameend(_id_6B53A43E91B3D1A2) {
  level waittill("game_ended");

  if(isDefined(_id_6B53A43E91B3D1A2))
    _id_6B53A43E91B3D1A2.alpha = 0;
}

createzones() {
  if(isDefined(level._id_6E31FB115404C96D))
    [[level._id_6E31FB115404C96D]]();

  triggers = getEntArray("grind_location", "targetname");

  foreach(trigger in triggers) {
    zone = _id_4055DE5045BF885A::setupobjective(trigger, 1, 1);
    zone thread runzonethink();
    level.objectives[zone.objectivekey] = zone;
  }

  if(level.mapname == "mp_deadzone") {
    _id_91E3043C367E21F8 = spawnStruct();
    _id_91E3043C367E21F8.origin = (1416, 1368, 300);
    _id_91E3043C367E21F8.angles = (0, 0, 0);
    _id_91E3043C367E21F8.script_label = "b";
    zone = _id_4055DE5045BF885A::setupobjective(_id_91E3043C367E21F8, 1, 1);
    zone thread runzonethink();
    level.objectives[zone.objectivekey] = zone;
  }

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  foreach(zone in level.objectives) {
    _id_3C2389BA69E5822B = _id_4055DE5045BF885A::getreservedobjid(zone.objectivekey);
    zone scripts\mp\gameobjects::requestid(1, 1, _id_3C2389BA69E5822B);
    zone scripts\mp\gameobjects::setvisibleteam("any");
    zone _id_4055DE5045BF885A::setobjectivecallbacks();
    zone _id_4055DE5045BF885A::setneutral();
  }
}

isinzone(player, zone) {
  if(scripts\mp\utility\player::isreallyalive(player) && player istouching(zone.trigger) && zone.ownerteam == player.team)
    return 1;

  return 0;
}

runzonethink() {
  level endon("game_ended");
  self endon("stop_trigger" + self.objectivekey);

  for(;;) {
    self.trigger waittill("trigger", player);

    if(self.disabled) {
      continue;
    }
    if(self.stalemate) {
      continue;
    }
    if(isagent(player)) {
      continue;
    }
    if(!isPlayer(player)) {
      continue;
    }
    if(player.isscoring) {
      continue;
    }
    player.isscoring = 1;
    level thread processscoring(player, self);
  }
}

removetagsongameended() {
  level waittill("game_ended");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.tagscarried)) {
      continue;
    }
    player.tagscarried = 0;
  }
}

processscoring(player, zone) {
  while(player.tagscarried && isinzone(player, zone) && !zone.stalemate && !zone.disabled) {
    if(player.tagscarried >= level.megabanklimit) {
      if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
        player playsoundtoplayer("mp_grind_token_banked_large_hlwn", player);
      else
        player playsoundtoplayer("mp_grind_token_banked_large", player);

      scoreamount(player, level.megabanklimit, zone);
      points = scripts\mp\rank::getscoreinfovalue("stat_BC82BD9CAA5693CE");
      points = points * level.megabanklimit;

      if(!player scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak"))
        player scripts\mp\killstreaks\killstreaks::givestreakpoints("stat_F4CD65EB4AA3FD61", level.megabankbonusks);

      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_32D643F803437AAA", undefined, points + level.megabankbonus);
      player scripts\mp\utility\stats::incpersstat("tagsMegaBanked", 1);
    } else {
      if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
        player playsoundtoplayer("mp_grind_token_banked_hlwn", player);
      else
        player playsoundtoplayer("mp_grind_token_banked", player);

      _id_1B445873B17EAA71 = level.bankrate;

      if(_id_1B445873B17EAA71 > player.tagscarried)
        _id_1B445873B17EAA71 = player.tagscarried;

      scoreamount(player, _id_1B445873B17EAA71, zone);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1B445873B17EAA71; _id_AC0E594AC96AA3A8++)
        player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_BC82BD9CAA5693CE");
    }

    if((scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(player)) && isDefined(player.cranked) && player.cranked)
      player scripts\mp\cranked::setcrankedplayerbombtimer("kill");

    wait(level.banktime);
  }

  zone _id_4055DE5045BF885A::setneutralicons();
  player.isscoring = 0;
}

scoreamount(player, _id_C1B3D6B48E668752, zone) {
  player playersettagcount(player.tagscarried - _id_C1B3D6B48E668752);
  scripts\mp\gamescore::giveteamscoreforobjective(player.team, _id_C1B3D6B48E668752, 0);
  player scripts\mp\utility\stats::incpersstat("confirmed", _id_C1B3D6B48E668752);
  player scripts\mp\persistence::statsetchild("round", "confirmed", player.pers["confirmed"]);
  player scripts\mp\utility\stats::setextrascore0(player.pers["confirmed"]);

  if(level.bankdisable) {
    zone.tagsdeposited = zone.tagsdeposited + _id_C1B3D6B48E668752;

    if(zone.tagsdeposited >= level.bankdisabletags) {
      zone scripts\mp\gameobjects::allowuse("none");
      zone thread waitthensetvisibleteam();
      zone.disabled = 1;
      zone.scriptable setscriptablepartstate("flag", "off");
      zone.scriptable setscriptablepartstate("pulse", "off");

      if(isDefined(zone.objectivekey)) {
        foreach(_id_F90358454413407F in level.teamnamelist)
        scripts\mp\utility\dialog::statusdialog("grind_disable_" + zone.objectivekey, _id_F90358454413407F);
      }

      if(level.bankdisabletime == 0) {
        return;
      }
      zone thread waitthenenablezone();
      return;
    }
  }
}

waitthensetvisibleteam() {
  foreach(player in level.players)
  scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);

  waitframe();
  scripts\mp\gameobjects::setvisibleteam("none");
}

waitthenenablezone() {
  level endon("game_ended");
  wait(level.bankdisabletime);
  self.disabled = 0;
  self.scriptable setscriptablepartstate("flag", "idle");
  scripts\mp\gameobjects::allowuse("any");
  scripts\mp\gameobjects::setvisibleteam("any");

  if(isDefined(self.objectivekey)) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("grind_enable_" + self.objectivekey, _id_F90358454413407F);
  }
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  spawnteam = self.pers["team"];

  if(game["switchedsides"])
    spawnteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + spawnteam + "_start");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "normal", "fallback");

  return spawnpoint;
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
  level thread droptags(victim, attacker);
}

droptags(victim, attacker) {
  if(isagent(victim)) {
    return;
  }
  if(victim.tagscarried > 49)
    _id_A28B6FB6A6902689 = 49;
  else if(victim.tagscarried > 0)
    _id_A28B6FB6A6902689 = victim.tagscarried;
  else
    _id_A28B6FB6A6902689 = 0;

  for(counter = 0; counter < _id_A28B6FB6A6902689; counter++) {
    _id_34744859AD58739B = spawntag(victim);
    _id_34744859AD58739B.team = victim.team;
    _id_34744859AD58739B.victim = victim;
    _id_34744859AD58739B.attacker = attacker;
    level notify("new_tag_spawned", _id_34744859AD58739B);
    level thread monitortaguse(_id_34744859AD58739B);
  }

  _id_70BD2C443105990A = victim.tagscarried - _id_A28B6FB6A6902689;
  _id_70BD2C443105990A = int(max(0, _id_70BD2C443105990A));
  victim playersettagcount(_id_70BD2C443105990A);
}

dogtagallyonusecb(player) {
  if(isPlayer(player))
    player scripts\mp\utility\stats::setextrascore1(player.pers["denied"]);
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bank_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_BANK_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bank_b", 0, "neutral", "MP_INGAME_ONLY/OBJ_BANK_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_scoring_foe_a", 2, "enemy", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_scoring_foe_b", 2, "enemy", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_scoring_friend_a", 2, "friendly", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_scoring_friend_b", 2, "friendly", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_b", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1);
  _id_8586A09E62C831F5 = &"MP_INGAME_ONLY/OBJ_BANK_CAPS";
  _id_8586A09E62C831F5 = &"MP_INGAME_ONLY/OBJ_SCORING_CAPS";
  _id_8586A09E62C831F5 = &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS";
}

removepoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devremovedomflag", "") != "") {
      _id_45360A7A32781F43 = getDvar("scr_devremovedomflag", "");

      foreach(zone in level.objectives) {
        if(isDefined(zone.objectivekey) && zone.objectivekey == _id_45360A7A32781F43) {
          zone notify("stop_trigger" + zone.objectivekey);
          zone scripts\mp\gameobjects::allowuse("none");
          zone.trigger = undefined;
          zone notify("deleted");
          zone.visibleteam = "none";
          zone scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
          _id_3DABCE211C987A42 = [];

          foreach(objective in level.objectives) {
            if(objective.objectivekey != _id_45360A7A32781F43)
              _id_3DABCE211C987A42[objective.objectivekey] = objective;
          }

          level.objectives = _id_3DABCE211C987A42;
          break;
        }
      }

      setdynamicdvar("scr_devremovedomflag", "");
    }

    wait 1;
  }
}

placepoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devplacedomflag", "") != "") {
      _id_45360A7A32781F43 = getDvar("scr_devplacedomflag", "");
      trigger = undefined;
      _id_FD3C4AA0CF99AF2C = getEntArray("grind_location", "targetname");

      foreach(_id_ED25D2268D25175B in _id_FD3C4AA0CF99AF2C) {
        if("_" + _id_ED25D2268D25175B.script_label == _id_45360A7A32781F43)
          trigger = _id_ED25D2268D25175B;
      }

      trigger.origin = level.players[0].origin;
      trigger.ownerteam = "neutral";
      tracestart = trigger.origin + (0, 0, 32);
      _id_8B39E5984DA1FFAF = trigger.origin + (0, 0, -32);
      trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
      trigger.origin = trace["position"];
      trigger.upangles = vectortoangles(trace["normal"]);
      trigger.forward = anglesToForward(trigger.upangles);
      trigger.right = anglestoright(trigger.upangles);
      visuals[0] = spawn("script_model", trigger.origin);
      visuals[0].angles = trigger.angles;
      _id_25D213B4714288CE = spawn("trigger_radius", trigger.origin, 0, 90, 128);
      _id_25D213B4714288CE.script_label = trigger.script_label;
      trigger = _id_25D213B4714288CE;
      zone = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, (0, 0, 100));

      if(isDefined(trigger.objectivekey))
        zone.objectivekey = trigger.objectivekey;
      else
        zone.objectivekey = zone scripts\mp\gameobjects::getlabel();

      if(isDefined(trigger.iconname))
        zone.iconname = trigger.iconname;
      else
        zone.iconname = zone scripts\mp\gameobjects::getlabel();

      zone thread runzonethink();
      zone scripts\mp\gameobjects::allowuse("enemy");
      zone scripts\mp\gameobjects::setusetime(level.bankcapturetime);
      zone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_bank");
      zone scripts\mp\gameobjects::setvisibleteam("any");
      zone scripts\mp\gameobjects::cancontestclaim(1);
      zone.onuse = _id_4055DE5045BF885A::zone_onuse;
      zone.onbeginuse = _id_4055DE5045BF885A::zone_onusebegin;
      zone.onunoccupied = _id_4055DE5045BF885A::zone_onunoccupied;
      zone.oncontested = _id_4055DE5045BF885A::zone_oncontested;
      zone.onuncontested = _id_4055DE5045BF885A::zone_onuncontested;
      zone.claimgracetime = level.bankcapturetime * 1000;
      tracestart = zone.visuals[0].origin + (0, 0, 32);
      _id_8B39E5984DA1FFAF = zone.visuals[0].origin + (0, 0, -32);
      contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      ignoreents = [];
      trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
      zone.baseeffectpos = trace["position"];
      upangles = vectortoangles(trace["normal"]);
      upangles = -1 * upangles;
      zone.baseeffectforward = anglesToForward(upangles);
      zone _id_4055DE5045BF885A::setneutral();
      level.objectives[zone.objectivekey] = zone;
      setdynamicdvar("scr_devplacedomflag", "");
    }

    wait 1;
  }
}

_id_6E31FB115404C96D(_id_6830BAF45D9BF3CC, _id_A9F94D266B961E6F) {
  _id_5D8560BD09196D7E = getEntArray("grind_location", "targetname");

  foreach(obj in _id_5D8560BD09196D7E) {
    if(obj.script_label == _id_6830BAF45D9BF3CC)
      obj.origin = _id_A9F94D266B961E6F;
  }
}