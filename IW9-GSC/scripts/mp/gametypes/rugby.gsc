/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rugby.gsc
***********************************************/

main() {
  _id_584994FAB4A8712B = spawnStruct();
  level.rugby = _id_584994FAB4A8712B;
  _id_584994FAB4A8712B.endzones = [];
  _id_584994FAB4A8712B.endzones["allies"] = [];
  _id_584994FAB4A8712B.endzones["axis"] = [];
  _id_584994FAB4A8712B.juggcratesetups = [];
  _id_584994FAB4A8712B.goals = [];
  _id_584994FAB4A8712B.activejuggcrates = [];
  _id_584994FAB4A8712B.activejuggernauts = [];
  _id_584994FAB4A8712B.lastjuggpositions = [];
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);
  initrules();
  level.teambased = 1;
  level.objectivebased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onplayerdamaged = ::onplayerdamaged;
  level.modeonteamchangedeath = ::modeonteamchangedeath;
  level.onplayerconnect = ::onplayerconnect;
  level.ontimelimitot = ::ontimelimitot;
  level._id_5FEC67FA7F314C8A = ::_id_75D33AA666BA0A2E;
  game["canScoreOnTie"] = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_rgby_mode_uktl_rgt1";
  else
    game["dialog"]["gametype"] = "gametype_onslaught";

  game["dialog"]["boost"] = "boost_rugby";

  if(!isDefined(game["roundsPlayed"]))
    _id_126FE93C04FE16DF = "boost_rugby";
  else
    _id_126FE93C04FE16DF = "boost_rugby_short";

  game["dialog"]["offense_obj"] = _id_126FE93C04FE16DF;
  game["dialog"]["defense_obj"] = _id_126FE93C04FE16DF;
  game["dialog"]["rugby_enemy_close_goal"] = "rugby_enemy_close_goal";
  game["dialog"]["rugby_friendly_close_goal"] = "rugby_friendly_close_goal";
  game["dialog"]["rugby_lost_jugg"] = "rugby_lost_jugg";
  game["dialog"]["rugby_secured_jugg"] = "rugby_secured_jugg";
  game["dialog"]["rugby_securing_jugg"] = "rugby_securing_jugg";
  game["dialog"]["rugby_capture_jugg"] = "objective_new";
  game["dialog"]["rugby_new_jugg"] = "tjugg_new_player";
  game["dialog"]["rugby_team_jugg_nag"] = "tjugg_vip";
  game["dialog"]["rugby_order_attack"] = "order_attack";
  game["dialog"]["rugby_order_fallback"] = "order_fallback";
  game["dialog"]["rugby_round_lose"] = "overrun_enemy";
  game["dialog"]["rugby_round_win"] = "overrun_friendly";
  level._effect["rugby_score_explosion"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");
}

initrules() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 240);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.ontimelimitgraceperiod = _id_0D973247BB17FE16();
  level.currenttimelimitdelay = 0.0;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  jugghealth = getmatchrulesdata("rugbyData", "juggHealth");
  setdynamicdvar("dvar_916482A23F7DB002", jugghealth);
  _id_0DD0FA90150F8C05 = getmatchrulesdata("rugbyData", "juggSpeed");
  setdynamicdvar("dvar_FCA821906F4A663F", _id_0DD0FA90150F8C05);
  _id_F5DA6ADBE72C391E = getmatchrulesdata("rugbyData", "juggTeamSpeed");
  setdynamicdvar("dvar_64D4D28DC063BFF0", _id_F5DA6ADBE72C391E);
  _id_FF77A4BD0800F1E5 = getmatchrulesdata("rugbyData", "juggTimeout");
  setdynamicdvar("dvar_364DB51C6DE274CF", _id_FF77A4BD0800F1E5);
  _id_DBCC959D2812D7C5 = getmatchrulesdata("rugbyData", "helperMax");
  setdynamicdvar("dvar_F3F419EF3E285DE3", _id_DBCC959D2812D7C5);
  _id_542CFFF2233055B9 = getmatchrulesdata("rugbyData", "juggCaptureTime");
  setdynamicdvar("dvar_F96F8FF371DA9F0F", _id_542CFFF2233055B9);
}

getjuggmaxhealth() {
  return getdvarint("dvar_916482A23F7DB002");
}

getjuggspeedscalar(_id_16661CE060A7DA4D) {
  _id_76B81ED8D4161BBC = -0.3 + 0.1 * getdvarfloat("dvar_FCA821906F4A663F");
  _id_16661CE060A7DA4D = int(min(_id_16661CE060A7DA4D, getdvarint("dvar_F3F419EF3E285DE3")));
  _id_CAE04F4FF3AA680C = 0.08 * getdvarfloat("dvar_64D4D28DC063BFF0");
  return _id_76B81ED8D4161BBC + _id_16661CE060A7DA4D * _id_CAE04F4FF3AA680C;
}

getjuggtimeout() {
  return getdvarfloat("dvar_364DB51C6DE274CF");
}

_id_CCA61180D8FDF0EA() {
  return getdvarfloat("dvar_F96F8FF371DA9F0F");
}

_id_0D973247BB17FE16() {
  return getdvarfloat("dvar_0D2716123812605F", 45);
}

onstartgametype() {
  setclientnamemode("auto_change");

  foreach(_id_F90358454413407F in level.teamnamelist)
  scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"MP_MODE_RUGBY/INGAME_OBJECTIVE");

  setupwaypointicons();
  _id_D6E8F4EC9A310D75();
  thread initrugbyents();
  thread setupinitialstate();
  initspawns();
  initjugg();
  level thread _id_E2E13253FF7A00B1();
}

_id_E2E13253FF7A00B1() {
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 5;
  level thread scripts\mp\hud_message::notifyteam("jugg_capture", "jugg_capture", "allies");
}

initrugbyents() {
  level._id_0A4619C3C1CE4C58 = scripts\engine\utility::array_combine(level.outofboundstriggers, level.minetriggers, level.hurttriggers, level.radtriggers);
  initendzoneents();
  initjuggcratesetupents();
}

initendzoneents() {
  _id_584994FAB4A8712B = level.rugby;
  endzones = scripts\engine\utility::getStructArray("rugby_endzone", "targetname");

  foreach(_id_54B003CE5D016238 in endzones) {
    initendzoneent(_id_54B003CE5D016238);
    _id_584994FAB4A8712B.endzones[_id_54B003CE5D016238.team][_id_584994FAB4A8712B.endzones[_id_54B003CE5D016238.team].size] = _id_54B003CE5D016238;
  }
}

initendzoneent(_id_54B003CE5D016238) {
  _id_F19941E08F779517 = getEntArray(_id_54B003CE5D016238.target, "targetname");

  foreach(ent in _id_F19941E08F779517) {
    if(ent.classname == "trigger_multiple_mp_rugby_endzone")
      _id_54B003CE5D016238.trigger = ent;

    if(isDefined(ent.script_noteworthy) && getsubstr(ent.script_noteworthy, 0, 3) == "fx_")
      ent delete();
  }

  _id_BEDE361FC24CBFE1(_id_54B003CE5D016238);

  if(_id_54B003CE5D016238.spawnflags & 1) {
    _id_54B003CE5D016238.team = "allies";
    _id_54B003CE5D016238.trigger.objectivekey = "allies";
  } else if(_id_54B003CE5D016238.spawnflags & 2) {
    _id_54B003CE5D016238.team = "axis";
    _id_54B003CE5D016238.trigger.objectivekey = "axis";
  } else {
    _id_54B003CE5D016238.team = "allies";
    _id_54B003CE5D016238.trigger.objectivekey = "allies";
  }

  foreach(ent in _id_F19941E08F779517) {
    if(!isDefined(_id_54B003CE5D016238.chevrons))
      level thread _id_7C63D60BA6168AEA(_id_54B003CE5D016238);
  }
}

_id_BEDE361FC24CBFE1(_id_54B003CE5D016238) {
  if(level.mapname == "mp_crash2") {
    if(distance2d(_id_54B003CE5D016238.origin, (312, -1552, 216)) < 10)
      _id_54B003CE5D016238.spawnflags = 1;
  } else if(level.mapname == "mp_scrapyard") {
    if(distance2d(_id_54B003CE5D016238.origin, (-25223.3, -12439.2, 36.5)) < 10)
      _id_54B003CE5D016238.spawnflags = 2;
    else if(distance2d(_id_54B003CE5D016238.origin, (-26150.7, -8967.81, 144)) < 10)
      _id_54B003CE5D016238.spawnflags = 1;
  }
}

initjuggcratesetupents() {
  _id_584994FAB4A8712B = level.rugby;
  juggcratesetups = scripts\engine\utility::getStructArray("rugby_jugg_crate", "targetname");

  foreach(_id_115F6563192F74EA in juggcratesetups) {
    _id_115F6563192F74EA = _id_10F430E91C6C8BE3(_id_115F6563192F74EA);
    _id_584994FAB4A8712B.juggcratesetups[_id_584994FAB4A8712B.juggcratesetups.size] = _id_115F6563192F74EA;
  }

  level.rugby = _id_584994FAB4A8712B;
}

_id_10F430E91C6C8BE3(_id_115F6563192F74EA) {
  switch (level.mapname) {
    case "mp_aniyah_tac":
      if(distance(_id_115F6563192F74EA.origin, (3113.65, -1118.5, 378.5)) < 10)
        _id_115F6563192F74EA.origin = (2751, -1028, 376.5);

      break;
    default:
      break;
  }

  return _id_115F6563192F74EA;
}

initoverheadcameras() {
  level.spectatorcameras = [];
  level.spectatorcameras[0]["allies"] = spawnStruct();
  level.spectatorcameras[0]["axis"] = spawnStruct();
  scripts\mp\spawncamera::setgamemodecamera("allies", level.spectatorcameras[0]["allies"]);
  scripts\mp\spawncamera::setgamemodecamera("axis", level.spectatorcameras[0]["axis"]);
  updateoverheadcamerapos("allies");
  updateoverheadcamerapos("axis");
  level.updategamemodecamera = ::updateoverheadcamerapos;
  level.spectatorcameratime = 1.25;
}

initjugg() {
  juggconfig = scripts\mp\juggernaut::jugg_createconfig();
  level.rugby.juggconfig = juggconfig;
  maxhealth = getjuggmaxhealth();
  juggconfig.maxhealth = maxhealth;
  juggconfig.startinghealth = maxhealth;
  juggconfig.suit = "iw9_juggernaut_mp";
  juggconfig.clothtype = "vestheavy";
  juggconfig._id_400EF51562606E7A = "milhvygr";
  juggconfig.forcetostand = 0;
  juggconfig.allows["sprint"] = 1;
  juggconfig.allows["weapon_switch"] = undefined;
  juggconfig.classstruct.loadoutprimary = "iw8_lm_dblmg";
}

initspawns() {
  _id_584994FAB4A8712B = level.rugby;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Rugby", "Crit_Default");
  _id_584994FAB4A8712B.startspawnclassname = "mp_rugby_spawn";
  scripts\mp\spawnlogic::addstartspawnpoints(_id_584994FAB4A8712B.startspawnclassname + "_allies_start", 1, "allies");
  scripts\mp\spawnlogic::addstartspawnpoints(_id_584994FAB4A8712B.startspawnclassname + "_axis_start", 1, "axis");

  if(!isDefined(level.teamstartspawnpoints)) {
    _id_584994FAB4A8712B.startspawnclassname = "mp_tdm_spawn";
    scripts\mp\spawnlogic::addstartspawnpoints(_id_584994FAB4A8712B.startspawnclassname + "_allies_start", 1, "allies");
    scripts\mp\spawnlogic::addstartspawnpoints(_id_584994FAB4A8712B.startspawnclassname + "_axis_start", 1, "axis");
  }

  _id_7D38B2B1ADC3E7D1 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_allies");
  _id_91EBF7FB8E7D58CC = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_axis");

  if(_id_7D38B2B1ADC3E7D1.size <= 0 || _id_91EBF7FB8E7D58CC.size <= 0) {
    _id_BCDA489AA10D2D1E = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

    foreach(spawnpoint in _id_BCDA489AA10D2D1E) {
      if(distancesquared(spawnpoint.origin, _id_584994FAB4A8712B.goals["allies"].origin) < distancesquared(spawnpoint.origin, _id_584994FAB4A8712B.goals["axis"].origin)) {
        _id_7D38B2B1ADC3E7D1[_id_7D38B2B1ADC3E7D1.size] = spawnpoint;
        continue;
      }

      _id_91EBF7FB8E7D58CC[_id_91EBF7FB8E7D58CC.size] = spawnpoint;
    }
  }

  _id_9B921D9972EA01FB = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_allies_secondary");
  _id_C88A41AA013294D6 = scripts\mp\spawnlogic::getspawnpointarray("mp_rugby_spawn_axis_secondary");
  scripts\mp\spawnlogic::registerspawnpoints("allies", _id_7D38B2B1ADC3E7D1);
  scripts\mp\spawnlogic::registerspawnpoints("axis", _id_91EBF7FB8E7D58CC);
  scripts\mp\spawnlogic::registerspawnpoints("allies", _id_9B921D9972EA01FB);
  scripts\mp\spawnlogic::registerspawnpoints("axis", _id_C88A41AA013294D6);
  scripts\mp\spawnlogic::registerspawnset("rugby_allies", _id_7D38B2B1ADC3E7D1);
  scripts\mp\spawnlogic::registerspawnset("rugby_axis", _id_91EBF7FB8E7D58CC);
  scripts\mp\spawnlogic::registerspawnset("rugby_allies_base", _id_9B921D9972EA01FB);
  scripts\mp\spawnlogic::registerspawnset("rugby_axis_base", _id_C88A41AA013294D6);
  _id_584994FAB4A8712B.spawnsets = [];
  _id_584994FAB4A8712B.spawnsets["allies"] = "rugby_allies";
  _id_584994FAB4A8712B.spawnsets["axis"] = "rugby_axis";
  _id_584994FAB4A8712B.fallbackspawnsets = [];
  _id_584994FAB4A8712B.fallbackspawnsets["allies"] = "rugby_allies_base";
  _id_584994FAB4A8712B.fallbackspawnsets["axis"] = "rugby_axis_base";
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  _id_584994FAB4A8712B = level.rugby;
  _id_21AF6C045D6DDF93 = self.pers["team"];

  if(istrue(game["switchedsides"]))
    _id_21AF6C045D6DDF93 = scripts\engine\utility::ter_op(_id_21AF6C045D6DDF93 == "allies", "axis", "allies");

  _id_DCABAFC0CC1B60ED = scripts\engine\utility::ter_op(_id_21AF6C045D6DDF93 == "allies", "axis", "allies");

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(_id_584994FAB4A8712B.startspawnclassname + "_" + _id_21AF6C045D6DDF93 + "_start");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
  } else {
    _id_D55A5C273C69F3C8 = getjuggorcratepos();
    _id_629E5FE2F6B337FA = [];
    _id_629E5FE2F6B337FA["singlePointPos"] = _id_D55A5C273C69F3C8;
    _id_629E5FE2F6B337FA["minDistToSinglePointSq"] = 562500;
    _id_629E5FE2F6B337FA["maxDistToSinglePointSq"] = 36000000;
    _id_629E5FE2F6B337FA["distRangeToSinglePointSq"] = 35437500;
    _id_629E5FE2F6B337FA["juggPos"] = _id_D55A5C273C69F3C8;
    _id_629E5FE2F6B337FA["rugbyFieldDir2D"] = _id_584994FAB4A8712B.goals[_id_DCABAFC0CC1B60ED].origin - _id_584994FAB4A8712B.goals[_id_21AF6C045D6DDF93].origin;
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, _id_584994FAB4A8712B.spawnsets[_id_21AF6C045D6DDF93], _id_584994FAB4A8712B.fallbackspawnsets[_id_21AF6C045D6DDF93], undefined, _id_629E5FE2F6B337FA);
  }

  return spawnpoint;
}

modeonteamchangedeath(player) {
  if(isDefined(level._id_9A453437A59C7A57))
    player setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(player.team == level._id_9A453437A59C7A57.team, 0, 1));
}

onplayerconnect(player) {
  player scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(player.pers["damage"]))
    player scripts\mp\utility\stats::setextrascore0(player.pers["damage"]);

  player scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(player.pers["defends"]))
    player scripts\mp\utility\stats::setextrascore1(player.pers["defends"]);

  thread onplayerspawned(player);
}

onplayerspawned(player) {
  player waittill("spawned");

  if(isDefined(level._id_9A453437A59C7A57) && isDefined(level._id_9A453437A59C7A57.team) && isDefined(player.team))
    player setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(player.team == level._id_9A453437A59C7A57.team, 0, 1));
}

onplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(isDefined(eattacker) && eattacker != victim && isPlayer(eattacker)) {
    if(idamage >= _id_FCDF19E3CDD29669)
      idamage = _id_FCDF19E3CDD29669;

    eattacker scripts\mp\persistence::statsetchild("round", "damage", eattacker.pers["damage"]);
    eattacker scripts\mp\utility\stats::setextrascore0(eattacker.pers["damage"]);
  }
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  self.overrideweaponspeed_speedscale = undefined;

  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);
}

awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_8363BEB01B537D3E = 0;
  _id_88F4967A49A22ED7 = 0;
  victim = self;
  _id_F7DED1FDB02A123D = victim.origin;
  _id_86C1C8628B1D55F8 = attacker.origin;
  attackerisinflictor = 0;

  if(isDefined(einflictor)) {
    _id_86C1C8628B1D55F8 = einflictor.origin;
    attackerisinflictor = einflictor == attacker;
  }

  if(isDefined(level._id_9A453437A59C7A57)) {
    if(isDefined(attacker) && isPlayer(attacker) && attacker.team != victim.team) {
      if(attacker == level._id_9A453437A59C7A57)
        attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_670456684D1AC92F");
      else if(victim == level._id_9A453437A59C7A57)
        attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_FD0C8FBAC1063EAA");
      else if(attacker.team == level._id_9A453437A59C7A57.team && attacker != level._id_9A453437A59C7A57) {
        _id_9B65EAC5EC48EB9B = distancesquared(level._id_9A453437A59C7A57.origin, _id_86C1C8628B1D55F8);

        if(_id_9B65EAC5EC48EB9B < 105625) {
          attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
          attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
          attacker scripts\mp\utility\stats::incpersstat("defends", 1);
          attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
          attacker scripts\mp\utility\stats::setextrascore1(attacker.pers["defends"]);
          thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "defending");
          return;
        }
      } else if(attacker.team != level._id_9A453437A59C7A57.team && victim.team == level._id_9A453437A59C7A57.team) {
        _id_9B65EAC5EC48EB9B = distancesquared(level._id_9A453437A59C7A57.origin, _id_F7DED1FDB02A123D);

        if(_id_9B65EAC5EC48EB9B < 105625) {
          attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
          attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
          thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "assaulting");
        }
      }
    }
  }
}

ontimelimit() {
  if(level.gameended) {
    return;
  }
  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["cyber_tie"]);
}

ontimelimitot() {
  if(level.rugby.activejuggernauts.size > 0) {
    if(!istrue(level.rugby.inot)) {
      setomnvar("ui_overtime_time", gettime() + _id_0D973247BB17FE16() * 1000);
      level.rugby.inot = 1;
      level.canprocessot = 1;
      _id_1D7E98E21E22F61A();
      level thread _id_AECDD5E4B8140008();
    }
  } else {
    level.canprocessot = 1;
    level.currenttimelimitdelay = level.ontimelimitgraceperiod;
  }
}

_id_AECDD5E4B8140008() {
  level endon("game_ended");

  for(;;) {
    if(level.rugby.activejuggernauts.size > 0) {
      wait 0.05;
      continue;
    }

    level.currenttimelimitdelay = level.ontimelimitgraceperiod;
    break;
  }
}

_id_DA84ED466CCFC207() {
  time = getdvarfloat("dvar_364DB51C6DE274CF");
  time = int(time * 1000 + gettime());
  setomnvar("ui_obj_timer", time);
  setomnvar("ui_obj_progress", 1);
  return time;
}

_id_1D7E98E21E22F61A() {
  level notify("stop_rugby_timeout");
  setomnvar("ui_obj_timer", 0);
  setomnvar("ui_obj_progress", 0);
}

getjuggorcratepos() {
  _id_584994FAB4A8712B = level.rugby;

  if(isDefined(level._id_9A453437A59C7A57))
    return level._id_9A453437A59C7A57.origin;
  else if(_id_584994FAB4A8712B.activejuggernauts.size > 0) {
    foreach(_id_E21279FA90BDF012 in _id_584994FAB4A8712B.activejuggernauts)
    return _id_E21279FA90BDF012.origin;
  } else {
    foreach(crate in _id_584994FAB4A8712B.activejuggcrates)
    return crate.origin;
  }

  return undefined;
}

doesteamhaveactivejugg(team) {
  _id_584994FAB4A8712B = level.rugby;

  if(_id_584994FAB4A8712B.activejuggernauts.size > 0) {
    foreach(_id_E21279FA90BDF012 in _id_584994FAB4A8712B.activejuggernauts) {
      if(_id_E21279FA90BDF012.team == team)
        return 1;
    }
  }

  return 0;
}

onjuggproximityscore(_id_72837284FE79DFAB) {
  level endon("game_ended");
  playsoundatpos(_id_72837284FE79DFAB.origin, "exp_bombsite_lr");
  playFX(scripts\engine\utility::getfx("rugby_score_explosion"), _id_72837284FE79DFAB.origin);
  players = scripts\mp\utility\player::getplayersinradius(_id_72837284FE79DFAB.origin, 800);

  foreach(player in players) {
    if(player != _id_72837284FE79DFAB && player.team != _id_72837284FE79DFAB.team)
      player dodamage(5000, _id_72837284FE79DFAB.origin, player, undefined, "MOD_EXPLOSIVE");
  }

  thread scripts\mp\gamelogic::endgame(_id_72837284FE79DFAB.team, game["end_reason"]["target_destroyed"]);
}

setupinitialstate() {
  _id_584994FAB4A8712B = level.rugby;

  if(!activateendzone(_id_584994FAB4A8712B.endzones["allies"][0], "allies")) {
    return;
  }
  if(!activateendzone(_id_584994FAB4A8712B.endzones["axis"][0], "axis")) {
    return;
  }
  if(!activatenewjuggcrate())
    return;
}

activatenewjuggcrate() {
  _id_4FDABB9630366776 = randomint(level.rugby.juggcratesetups.size);
  _id_A851CC05483290A7 = level.rugby.juggcratesetups[_id_4FDABB9630366776];

  if(!isDefined(_id_A851CC05483290A7))
    return 0;

  return activatejuggcrate(_id_A851CC05483290A7.origin, scripts\engine\utility::ter_op(isDefined(_id_A851CC05483290A7.angles), _id_A851CC05483290A7.angles, (0, 0, 0)), 1);
}

activateendzone(_id_AAB41EEEDEC2662D, team) {
  _id_584994FAB4A8712B = level.rugby;

  if(istrue(game["switchedsides"]))
    team = scripts\engine\utility::ter_op(team == "allies", "axis", "allies");

  if(!isDefined(_id_AAB41EEEDEC2662D))
    return 0;

  if(isDefined(_id_584994FAB4A8712B.goals[team]))
    deactivateendzone(_id_584994FAB4A8712B.goals[team]);

  _id_584994FAB4A8712B.goals[team] = _id_AAB41EEEDEC2662D;
  _id_AAB41EEEDEC2662D thread watchforjuggproximityscore(team);
  return 1;
}

deactivateendzone(_id_54B003CE5D016238) {
  _id_54B003CE5D016238 notify("endzone_deactivate");
}

_id_7C63D60BA6168AEA(_id_54B003CE5D016238) {
  if(level.mapname == "mp_shipment" || level.mapname == "mp_euphrates" || level.mapname == "mp_rust" || level.mapname == "mp_crash2" || level.mapname == "mp_malyshev") {
    if(_id_54B003CE5D016238.trigger.objectivekey == "allies")
      target = "allies_endzone_vis";
    else
      target = "axis_endzone_vis";
  } else if(level.mapname == "mp_backlot2") {
    if(_id_54B003CE5D016238.trigger.targetname == "allies_endzone")
      target = "axis_endzone_vis";
    else
      target = "allies_endzone_vis";
  } else if(_id_54B003CE5D016238.trigger.targetname == "allies_endzone")
    target = "allies_endzone_vis";
  else
    target = "axis_endzone_vis";

  _id_54B003CE5D016238 thread _id_8FA98F8A53842866(target, _id_54B003CE5D016238.trigger.targetname);
  _id_54B003CE5D016238 thread updatechevrons("idle");
}

_id_8FA98F8A53842866(target, label) {
  wait 1.0;
  _id_C236336A4B27E7DA = getentitylessscriptablearray(target, "targetname");
  _id_C236336A4B27E7DA = _id_D94E76F45911EFA5(_id_C236336A4B27E7DA, label);
  chevrons = [];

  foreach(visual in _id_C236336A4B27E7DA) {
    index = chevrons.size;
    chevrons[index] = visual;
    chevrons[index].numchevrons = 1;

    if(isDefined(visual.script_noteworthy)) {
      if(visual.script_noteworthy == "2") {
        chevrons[index].numchevrons = 2;
        continue;
      }

      if(visual.script_noteworthy == "3") {
        chevrons[index].numchevrons = 3;
        continue;
      }

      if(visual.script_noteworthy == "4")
        chevrons[index].numchevrons = 4;
    }
  }

  self.chevrons = chevrons;
}

updatechevrons(state) {
  self notify("updateChevrons");
  self endon("updateChevrons");

  while(!isDefined(self.chevrons))
    waitframe();

  foreach(_id_0EAE85273686F4F4 in self.chevrons) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0EAE85273686F4F4.numchevrons; _id_AC0E594AC96AA3A8++)
      _id_0EAE85273686F4F4 setscriptablepartstate("chevron_" + _id_AC0E594AC96AA3A8, state);
  }
}

_id_182E902215D205B5(_id_C236336A4B27E7DA, label) {
  _id_C081A38873B1D5E3 = [];
  _id_D23F6234846F86A6 = [];

  switch (level.mapname) {
    case "mp_m_speed":
      _id_D23F6234846F86A6["1"] = [(-564, 1848, 24)];
      _id_D23F6234846F86A6["2"] = [(-1314, 440, 24), (-1362, 816, 24)];
      break;
    case "mp_cave":
    case "mp_cave_am":
      _id_D23F6234846F86A6["3"] = [(-692, 1828, 42), (-300, 1548, 76)];
      break;
    case "mp_raid":
      _id_D23F6234846F86A6["8"] = [(688, 256, 280)];
      _id_D23F6234846F86A6["20"] = [(212, 1436, 338)];
      break;
    default:
      break;
  }

  if(isDefined(_id_D23F6234846F86A6[label])) {
    foreach(visual in _id_C236336A4B27E7DA) {
      foreach(_id_F90358454413407F in _id_D23F6234846F86A6[label]) {
        if(distance(visual.origin, _id_F90358454413407F) < 10) {
          _id_C081A38873B1D5E3[_id_C081A38873B1D5E3.size] = visual;
          break;
        }
      }
    }
  }

  _id_C236336A4B27E7DA = scripts\engine\utility::array_remove_array(_id_C236336A4B27E7DA, _id_C081A38873B1D5E3);
  return _id_C236336A4B27E7DA;
}

_id_D94E76F45911EFA5(_id_C236336A4B27E7DA, label) {
  _id_34DCE00DF63CFF91 = [];
  _id_C081A38873B1D5E3 = [];

  switch (level.mapname) {
    case "mp_piccadilly":
      _id_34DCE00DF63CFF91["allies_endzone"] = [];
      _id_34DCE00DF63CFF91["allies_endzone"][0] = [(-2376, -3322, 39), (0, -90, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"][1] = [(-2071, -3537, 0), (0, 180, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"][2] = [(-2071, -3653, 0), (0, 180, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"][3] = [(-2071, -3754, 3), (0, 180, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"] = [];
      _id_34DCE00DF63CFF91["axis_endzone"][0] = [(2137, 493, 124), (0, -85, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][1] = [(2302, 495, 128), (0, -90, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][2] = [(2390, 495, 134), (0, -90, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][3] = [(2457, 494, 134), (0, -90, 0)];
      break;
    case "mp_harbor":
      _id_34DCE00DF63CFF91["axis_endzone"] = [];
      _id_34DCE00DF63CFF91["axis_endzone"][0] = [(-722, -1428, 201), (0, 0, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][1] = [(-722, -1567, 200), (0, 0, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][2] = [(-721, -1496, 200), (0, 0, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][3] = [(-721, -1639, 200), (0, 0, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][4] = [(-720, -1711, 200), (0, 0, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][5] = [(-720, -1806, 200), (0, 0, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][6] = [(-719, -1896, 200), (0, 0, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][7] = [(-719, -1999, 200), (0, 0, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][8] = [(-483, -2074, 200), (0, -270, 0)];
      break;
    case "mp_vacant":
      _id_34DCE00DF63CFF91["allies_endzone"] = [];
      _id_34DCE00DF63CFF91["allies_endzone"][0] = [(4948, 1284, 9), (0, 45, 0)];
      break;
    case "mp_m_speed":
      _id_34DCE00DF63CFF91["axis_endzone"] = [];
      _id_34DCE00DF63CFF91["axis_endzone"][0] = [(-603, 3101, 33), (0, 155, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"] = [];
      _id_34DCE00DF63CFF91["allies_endzone"][0] = [(-1070, 600, 32), (0, -20, 0)];
      break;
    case "mp_hardhat":
      _id_34DCE00DF63CFF91["axis_endzone"] = [];
      _id_34DCE00DF63CFF91["axis_endzone"][0] = [(1773, -1148, 302), (0, -90, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][1] = [(2098, -1153, 292), (0, -90, 0)];
      break;
    case "mp_runner_pm":
    case "mp_runner":
      _id_34DCE00DF63CFF91["allies_endzone"] = [];
      _id_34DCE00DF63CFF91["allies_endzone"][0] = [(1648, 367, 291), (0, 0, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"][1] = [(1947, 859, 255), (0, 270, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"][2] = [(1691, 854, 291), (0, 270, 0)];
      break;
    case "mp_raid":
      _id_34DCE00DF63CFF91["allies_endzone"] = [];
      _id_34DCE00DF63CFF91["allies_endzone"][0] = [(-2404.94, -1457.67, 280), (0, 0, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"][1] = [(-849.814, -1158.33, 280), (0, 180, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"][2] = [(-1978.45, -341.57, 280), (0, 270, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"][3] = [(-1143, -975, 280), (0, 270, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"] = [];
      _id_34DCE00DF63CFF91["axis_endzone"][0] = [(-1300.9, 4861.72, 269), (0, 180, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][1] = [(-1300.9, 4947, 269), (0, 180, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][2] = [(-1300.9, 4759, 269), (0, 180, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][3] = [(-1293.48, 4459.81, 273), (0, 180, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][4] = [(-1293.48, 4392, 274), (0, 180, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][5] = [(-2300.19, 3725.48, 288), (0, 90, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][6] = [(-1700.19, 3725.48, 286), (0, 90, 0)];
      _id_34DCE00DF63CFF91["axis_endzone"][7] = [(-1598.19, 4348.83, 279), (0, 90, 0)];
      break;
    case "mp_hackney_yard":
    case "mp_hackney_am":
      _id_34DCE00DF63CFF91["allies_endzone"] = [];
      _id_34DCE00DF63CFF91["allies_endzone"][0] = [(765, -1883, 23), (0, 180, 0)];
      _id_34DCE00DF63CFF91["allies_endzone"][1] = [(762, -2006, 187), (0, 180, 0)];
      break;
    default:
      break;
  }

  if(isDefined(_id_34DCE00DF63CFF91[label])) {
    foreach(_id_F90358454413407F in _id_34DCE00DF63CFF91[label]) {
      origin = _id_F90358454413407F[0];
      angles = _id_F90358454413407F[1];
      scriptable = spawnscriptable("hardpoint_chevron", origin, angles);
      _id_C081A38873B1D5E3[_id_C081A38873B1D5E3.size] = scriptable;
    }
  }

  _id_C236336A4B27E7DA = scripts\engine\utility::array_combine(_id_C236336A4B27E7DA, _id_C081A38873B1D5E3);
  return _id_C236336A4B27E7DA;
}

createvisualsinfo(scriptable, origin, angles) {
  scriptable.origin = origin;
  scriptable.angles = angles;
  return scriptable;
}

setupgoalvisualsforjugg(_id_72837284FE79DFAB) {
  _id_AAF899A23248AC63 = _id_72837284FE79DFAB.team;
  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(_id_AAF899A23248AC63);
  _id_2E912ABC2C41E4DA = _id_B0C33D224B825287[0];
  _id_54B003CE5D016238 = level.rugby.goals[_id_2E912ABC2C41E4DA];
  _id_54B003CE5D016238 thread updatechevrons(_id_2E912ABC2C41E4DA);
  _id_52ECBED785600F78 = level.rugby.goals[_id_AAF899A23248AC63];
  _id_52ECBED785600F78 thread updatechevrons("off");
}

watchforjuggproximityscore(team) {
  level endon("game_ended");
  self endon("endzone_deactivate");

  for(;;) {
    self.trigger waittill("trigger", _id_67E70B397FB73ACC);

    if(isDefined(_id_67E70B397FB73ACC.rugbyjugginfo) && _id_67E70B397FB73ACC.team != team) {
      onjuggproximityscore(_id_67E70B397FB73ACC);
      return;
    }
  }
}

activatenewjuggernaut(_id_72837284FE79DFAB) {
  _id_584994FAB4A8712B = level.rugby;
  _id_7ECFA0327F684D3B = setupplayerasjugg(_id_72837284FE79DFAB);

  if(!_id_7ECFA0327F684D3B)
    return 0;

  _id_ECD37C93245B48EA = spawnStruct();
  _id_ECD37C93245B48EA.player = _id_72837284FE79DFAB;
  _id_FE94A717B75F319F = _id_72837284FE79DFAB getentitynumber();
  _id_ECD37C93245B48EA.id = _id_FE94A717B75F319F;
  _id_584994FAB4A8712B.activejuggernauts[_id_FE94A717B75F319F] = _id_72837284FE79DFAB;
  level._id_9A453437A59C7A57 = _id_72837284FE79DFAB;
  _id_72837284FE79DFAB.rugbyjugginfo = _id_ECD37C93245B48EA;
  createobjectiveiconsforactivejugg(_id_72837284FE79DFAB, _id_ECD37C93245B48EA);
  startjugghud(_id_72837284FE79DFAB);
  setupgoalvisualsforjugg(_id_72837284FE79DFAB);
  _id_72837284FE79DFAB thread watchjugghealth();
  _id_72837284FE79DFAB thread watchforjuggdeathdisconnect();
  _id_72837284FE79DFAB thread watchjuggprogress();
  _id_72837284FE79DFAB thread watchteammatesnearjugg();

  if(getjuggtimeout() > 0)
    _id_72837284FE79DFAB thread watchjuggtimeout();

  _id_72837284FE79DFAB scripts\mp\utility\dialog::leaderdialogonplayer("rugby_new_jugg", "obj");
  _id_72837284FE79DFAB thread scripts\mp\hud_message::showsplash("jugg_player");
  _id_21D6D994B0F4FAF1 = [_id_72837284FE79DFAB];
  otherteam = scripts\mp\utility\game::getotherteam(_id_72837284FE79DFAB.team)[0];
  scripts\mp\utility\dialog::statusdialog("rugby_secured_jugg", _id_72837284FE79DFAB.team, "obj", _id_21D6D994B0F4FAF1);
  scripts\mp\utility\dialog::statusdialog("rugby_lost_jugg", otherteam, "obj");
  level thread _id_64357CC14D714493(_id_72837284FE79DFAB.team, otherteam);

  foreach(player in level.players) {
    if(player.team == _id_72837284FE79DFAB.team) {
      if(player != _id_72837284FE79DFAB)
        player thread scripts\mp\hud_message::showsplash("jugg_captured");

      continue;
    }

    player thread scripts\mp\hud_message::showsplash("jugg_lost");
  }

  return 1;
}

_id_64357CC14D714493(_id_AAF899A23248AC63, otherteam) {
  wait 3;
  scripts\mp\utility\dialog::statusdialog("rugby_order_attack", _id_AAF899A23248AC63);
  scripts\mp\utility\dialog::statusdialog("rugby_order_fallback", otherteam);
}

deactivatejuggernaut(player) {
  _id_584994FAB4A8712B = level.rugby;
  _id_ECD37C93245B48EA = player.rugbyjugginfo;

  if(isDefined(player))
    player.rugbyjugginfo = undefined;

  _id_584994FAB4A8712B.activejuggernauts[_id_ECD37C93245B48EA.id] = undefined;
  level._id_9A453437A59C7A57 = undefined;
  cleanupobjectiveiconsforjugg(player, _id_ECD37C93245B48EA);
  clearjugghud();

  foreach(_id_54B003CE5D016238 in _id_584994FAB4A8712B.endzones)
  _id_54B003CE5D016238[0] thread updatechevrons("idle");

  level.rugby._id_06222195E9884820 = undefined;
  level.rugby._id_687D3E3E7CDF8208 = undefined;
  level.rugby._id_A3E08B16EA9DC56D = undefined;
  level.rugby._id_C6DD6EDC503E61A8 = undefined;

  if(isDefined(player) && isDefined(player.team))
    level thread scripts\mp\hud_message::notifyteam("jugg_down_fr", "jugg_down_en", player.team);
  else
    level thread scripts\mp\hud_message::notifyteam("jugg_capture", "jugg_capture", "allies");

  setomnvar("ui_obj_timer", 0);
  setomnvar("ui_obj_progress", 0);
  player notify("rugby_jugg_end");
}

startjugghud(_id_72837284FE79DFAB) {
  setomnvar("ui_rugby_jugg_client", _id_72837284FE79DFAB);
  setomnvar("ui_rugby_jugg_health", 1.0);

  foreach(player in level.players)
  player setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(player.team == _id_72837284FE79DFAB.team, 0, 1));
}

clearjugghud() {
  setomnvar("ui_rugby_jugg_client", undefined);

  foreach(player in level.players)
  player setclientomnvar("ui_rugby_jugg_friendly", -1);
}

watchjugghealth() {
  level endon("game_ended");
  self endon("rugby_jugg_end");

  for(;;) {
    self waittill("damage");
    setomnvar("ui_rugby_jugg_health", self.health / self.maxhealth);
  }
}

watchforjuggdeathdisconnect() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  self waittill("death_or_disconnect");
  _id_1925D24D0AE333E6 = undefined;

  if(!isDefined(self))
    _id_1925D24D0AE333E6 = level.lastjuggpositions[self.rugbyjugginfo.id];
  else
    _id_1925D24D0AE333E6 = self.origin;

  nodes = getnodesinradius(_id_1925D24D0AE333E6, 32, 0, 32);
  _id_5BF3E22BDB650432 = getclosestpointonnavmesh(_id_1925D24D0AE333E6);

  if(distance(_id_1925D24D0AE333E6, _id_5BF3E22BDB650432) > 50)
    _id_5BF3E22BDB650432 = _id_1925D24D0AE333E6;

  _id_5BF3E22BDB650432 = _id_1925D24D0AE333E6;
  activatejuggcrate(_id_5BF3E22BDB650432 + (0, 0, 0), (0, 0, 0));
  deactivatejuggernaut(self);
}

watchjuggprogress() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  _id_AAF899A23248AC63 = self.team;
  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(_id_AAF899A23248AC63);
  _id_2E912ABC2C41E4DA = _id_B0C33D224B825287[0];
  _id_E728AA816ECE6C6D = level.rugby.goals[_id_AAF899A23248AC63];
  _id_7693D852900723CF = level.rugby.goals[_id_2E912ABC2C41E4DA];
  _id_B1FCBB0F6C5D7C8A = _id_7693D852900723CF.origin - _id_E728AA816ECE6C6D.origin;
  _id_E56AE451D16A08B2 = vectordot(_id_B1FCBB0F6C5D7C8A, _id_B1FCBB0F6C5D7C8A);
  _id_D4BC622EE7721CAA = undefined;

  for(;;) {
    _id_84E914491011509C = self.origin * (1, 1, 0) - _id_E728AA816ECE6C6D.origin * (1, 1, 0);
    progress = vectordot(_id_B1FCBB0F6C5D7C8A, _id_84E914491011509C) / _id_E56AE451D16A08B2;
    progress = clamp(progress, 0.0, 1.0);
    _id_4A7B5A73817EAD7B = [];
    _id_4A7B5A73817EAD7B[_id_AAF899A23248AC63] = progress;
    _id_4A7B5A73817EAD7B[_id_2E912ABC2C41E4DA] = 1.0 - progress;

    foreach(player in level.players) {
      if(player.team == _id_AAF899A23248AC63 || player.team == _id_2E912ABC2C41E4DA)
        player setclientomnvar("ui_rugby_jugg_progress", _id_4A7B5A73817EAD7B[player.team]);
    }

    if(progress > 0.8)
      level thread _id_5FBDAD9F043BC253(progress, _id_AAF899A23248AC63, _id_2E912ABC2C41E4DA);

    if(isDefined(level._id_9A453437A59C7A57)) {
      if(!isDefined(_id_D4BC622EE7721CAA))
        _id_D4BC622EE7721CAA = progress;

      if(progress > _id_D4BC622EE7721CAA + 0.1) {
        _id_D4BC622EE7721CAA = progress;
        level._id_9A453437A59C7A57 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_9FDAD7CBA5AB8DDF");
      }
    }

    level.lastjuggpositions[self.rugbyjugginfo.id] = self.origin;
    wait 0.05;
  }
}

_id_5FBDAD9F043BC253(progress, _id_AAF899A23248AC63, _id_2E912ABC2C41E4DA) {
  if(!isDefined(level.rugby._id_06222195E9884820)) {
    level.rugby._id_06222195E9884820 = 1;
    level.rugby._id_687D3E3E7CDF8208 = gettime();
    level.rugby._id_A3E08B16EA9DC56D = progress;
    level.rugby._id_C6DD6EDC503E61A8 = progress;
  } else if(isDefined(level.rugby._id_687D3E3E7CDF8208) && level.rugby._id_687D3E3E7CDF8208 + 30000 < gettime()) {
    level.rugby._id_06222195E9884820 = 1;
    level.rugby._id_687D3E3E7CDF8208 = gettime();
    level.rugby._id_A3E08B16EA9DC56D = progress;
    level.rugby._id_C6DD6EDC503E61A8 = progress;
  }

  if(istrue(level.rugby._id_06222195E9884820)) {
    scripts\mp\utility\dialog::statusdialog("rugby_friendly_close_goal", _id_AAF899A23248AC63, "obj");
    scripts\mp\utility\dialog::statusdialog("rugby_enemy_close_goal", _id_2E912ABC2C41E4DA, "obj");
    thread scripts\mp\music_and_dialog::timelimitmusic(_id_AAF899A23248AC63);
  }

  level.rugby._id_06222195E9884820 = 0;
}

setupplayerasjugg(player) {
  juggconfig = level.rugby.juggconfig;
  result = player scripts\mp\juggernaut::jugg_makejuggernaut(juggconfig);

  if(!result)
    return 0;

  player.droppeddeathweapon = 1;
  player givemaxammo(player.classstruct.loadoutprimaryobject);
  player.playerstreakspeedscale = getjuggspeedscalar(0);
  player scripts\mp\weapons::updatemovespeedscale();
  player thread handlejuggjumpspam();
  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(player.team);
  _id_2E912ABC2C41E4DA = _id_B0C33D224B825287[0];
  return 1;
}

watchteammatesnearjugg() {
  level endon("game_ended");
  self endon("rugby_jugg_end");

  for(;;) {
    _id_ADE1A8EBC52F0903 = 0;

    foreach(player in level.players) {
      if(player.team != self.team || player == self) {
        continue;
      }
      if(distancesquared(player.origin, self.origin) < 122500)
        _id_ADE1A8EBC52F0903++;
    }

    self.playerstreakspeedscale = getjuggspeedscalar(_id_ADE1A8EBC52F0903);
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.1;
  }
}

watchjuggtimeout() {
  level endon("game_ended");
  level endon("stop_rugby_timeout");
  self endon("rugby_jugg_end");
  _id_DA84ED466CCFC207();
  level thread _id_56BDEEDC04731234(self);
  wait(getjuggtimeout());
  setomnvar("ui_obj_timer", 0);
  setomnvar("ui_obj_progress", 0);
  self suicide();
}

_id_56BDEEDC04731234(_id_E21279FA90BDF012) {
  level endon("stop_rugby_timeout");
  _id_E21279FA90BDF012 endon("rugby_jugg_end");
  timeoutduration = getdvarfloat("dvar_364DB51C6DE274CF");
  _id_4335B4D453C6E781 = timeoutduration;

  while(!istrue(level.canprocessot)) {
    setomnvar("ui_obj_progress", _id_4335B4D453C6E781 / timeoutduration);
    _id_4335B4D453C6E781 = _id_4335B4D453C6E781 - level.framedurationseconds;
    wait(level.framedurationseconds);
  }
}

handlejuggjumpspam() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  self notifyonplayercommand("jugg_jumped", "+goStand");

  for(;;) {
    self waittill("jugg_jumped");

    while(!self isonground())
      waitframe();

    _id_9DC430BC2F680645 = self getvelocity();
    _id_4E3D8F59BF0F7030 = (_id_9DC430BC2F680645[0] * 0.25, _id_9DC430BC2F680645[1] * 0.25, _id_9DC430BC2F680645[2]);
    self setvelocity(_id_4E3D8F59BF0F7030);
    self.overrideweaponspeed_speedscale = 0.2;
    scripts\mp\weapons::updatemovespeedscale();

    for(;;) {
      result = scripts\engine\utility::waittill_any_timeout_1(1, "jugg_jumped");

      if(result == "jugg_jumped") {
        while(!self isonground())
          waitframe();

        _id_9DC430BC2F680645 = self getvelocity();
        _id_4E3D8F59BF0F7030 = (_id_9DC430BC2F680645[0] * 0.25, _id_9DC430BC2F680645[1] * 0.25, _id_9DC430BC2F680645[2]);
        self setvelocity(_id_4E3D8F59BF0F7030);
        continue;
      }

      break;
    }

    self.overrideweaponspeed_speedscale = undefined;
  }
}

_id_D6E8F4EC9A310D75() {
  _id_3C2389BA69E5822B = 0;
  level._id_E536C17539F4E08A = spawnStruct();
  level._id_E536C17539F4E08A.objidnum = scripts\mp\objidpoolmanager::requestreservedid(_id_3C2389BA69E5822B);
}

createobjectiveiconsforactivejugg(_id_72837284FE79DFAB, _id_ECD37C93245B48EA) {
  createjuggobjective(_id_72837284FE79DFAB, _id_ECD37C93245B48EA);
  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(_id_72837284FE79DFAB.team);
  _id_2E912ABC2C41E4DA = _id_B0C33D224B825287[0];
  _id_54B003CE5D016238 = level.rugby.goals[_id_2E912ABC2C41E4DA];
  createendzoneobjective(_id_54B003CE5D016238, _id_2E912ABC2C41E4DA, _id_ECD37C93245B48EA);
}

cleanupobjectiveiconsforjugg(_id_72837284FE79DFAB, _id_ECD37C93245B48EA) {
  scripts\mp\objidpoolmanager::update_objective_state(0, "done");
  scripts\mp\objidpoolmanager::returnobjectiveid(_id_ECD37C93245B48EA.endzoneobjid);
}

createjuggobjective(_id_72837284FE79DFAB, _id_ECD37C93245B48EA) {
  objid = 0;
  _id_ECD37C93245B48EA.juggobjid = objid;
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", _id_72837284FE79DFAB.origin, "icon_waypoint_jugg");
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  scripts\mp\objidpoolmanager::update_objective_onentity(objid, _id_72837284FE79DFAB);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 90);
  objective_setownerteam(objid, _id_72837284FE79DFAB.team);
  objective_setfriendlylabel(objid, "MP_MODE_RUGBY/JUGG_ESCORT");
  objective_setenemylabel(objid, "MP_MODE_RUGBY/JUGG_KILL");
}

createendzoneobjective(_id_54B003CE5D016238, _id_2E912ABC2C41E4DA, _id_ECD37C93245B48EA) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  _id_ECD37C93245B48EA.endzoneobjid = objid;
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", _id_54B003CE5D016238.origin, "icon_waypoint_hq");
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  objective_setownerteam(objid, _id_2E912ABC2C41E4DA);
  objective_setfriendlylabel(objid, "MP_MODE_RUGBY/ENDZONE_DEFEND");
  objective_setenemylabel(objid, "MP_MODE_RUGBY/ENDZONE_ASSAULT");
}

activatejuggcrate(_id_5BF3E22BDB650432, angles, _id_63366D9D88CE51F8) {
  _id_584994FAB4A8712B = level.rugby;

  if(!_id_8B3285549EDC119A(_id_5BF3E22BDB650432)) {
    _id_5BF3E22BDB650432 = level._id_91544A9E7182ACC0;
    angles = level._id_3367385244B5B2B3;
  }

  _id_C307F792531B5FA8 = createjuggcrate(_id_5BF3E22BDB650432, angles, _id_63366D9D88CE51F8);
  _id_584994FAB4A8712B.activejuggcrates[0] = _id_C307F792531B5FA8;
  _id_584994FAB4A8712B.activejuggcrates[0].crateid = _id_C307F792531B5FA8;
  return 1;
}

_id_8B3285549EDC119A(_id_5BF3E22BDB650432) {
  _id_30A9783B0595242A = 1;

  foreach(trigger in level._id_0A4619C3C1CE4C58) {
    if(ispointinvolume(_id_5BF3E22BDB650432, trigger)) {
      _id_30A9783B0595242A = 0;
      break;
    }
  }

  return _id_30A9783B0595242A;
}

createjuggcrate(_id_5BF3E22BDB650432, angles, _id_63366D9D88CE51F8) {
  groundpos = getgroundposition(_id_5BF3E22BDB650432, 8, 2000, 32);
  groundpos = groundpos + (0, 0, 5);
  crate = spawn("script_model", groundpos);
  crate.angles = angles;
  crate.visuals = [crate];
  crate.trigger = crate;
  crate.trigger.origin = crate.origin;
  crate.curorigin = crate.trigger.origin;
  crate.safeorigin = crate.trigger.origin;
  crate.visuals[0] setModel("military_crate_large_stackable_01_jugg");
  crate thread juggcratemanageuse(crate);
  crate thread scripts\mp\gameobjects::setdropped(undefined, undefined, 1);
  crate.crateid = crate getentitynumber();

  if(istrue(_id_63366D9D88CE51F8)) {
    level._id_91544A9E7182ACC0 = _id_5BF3E22BDB650432;
    level._id_3367385244B5B2B3 = angles;

    foreach(team in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("rugby_capture_jugg", team, "obj");
  }

  return crate;
}

gunkillerhackthread() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    dropped_weapons = getweaponarray();

    foreach(_id_76F4143215683892 in dropped_weapons) {
      if(distance2dsquared(_id_76F4143215683892.origin, self.origin) < 40000)
        _id_76F4143215683892 delete();
    }

    wait 0.25;
  }
}

juggcratemanageuse(crate) {
  level endon("game_ended");
  self endon("death");
  _id_DBCE45A33308630D = spawn("script_model", self.origin + (0, 0, 30));
  _id_DBCE45A33308630D.usetype = 1;
  _id_DBCE45A33308630D.destination = self.origin + (0, 0, 30);
  _id_DBCE45A33308630D.isuseobject = 1;
  self._id_DBCE45A33308630D = scripts\mp\gameobjects::createholduseobject("neutral", _id_DBCE45A33308630D, self.visuals, (0, 0, 64));

  foreach(team in level.teamnamelist)
  self._id_DBCE45A33308630D.teamprogress = undefined;

  self._id_DBCE45A33308630D.trigger._id_B9ABE6BDF97E9A79 = 16900;
  self._id_DBCE45A33308630D.trigger makeusable();
  self._id_DBCE45A33308630D.trigger setuserange(130);
  self._id_DBCE45A33308630D.trigger setHintString(&"MP_MODE_RUGBY/CRATE_USE");
  self._id_DBCE45A33308630D.trigger setCursorHint("HINT_BUTTON");
  self._id_DBCE45A33308630D.trigger setuseholdduration("duration_none");
  self._id_DBCE45A33308630D.trigger setusehideprogressbar(1);
  self._id_DBCE45A33308630D.trigger setusepriority(-4);
  self._id_DBCE45A33308630D.trigger sethintonobstruction("hide");
  self._id_DBCE45A33308630D scripts\mp\gameobjects::setusetime(_id_CCA61180D8FDF0EA());
  self._id_DBCE45A33308630D.interactteam = "any";
  self._id_DBCE45A33308630D.curprogress = 0;
  self._id_DBCE45A33308630D.defaultusetime = self._id_DBCE45A33308630D._id_E88F93A281F8856E;
  self._id_DBCE45A33308630D.userate = 1;
  self._id_DBCE45A33308630D.id = "rugby_jugg";
  self._id_DBCE45A33308630D.exclusiveuse = 0;
  self._id_DBCE45A33308630D.exclusiveclaim = 0;
  self._id_DBCE45A33308630D.skiptouching = 1;
  self._id_DBCE45A33308630D.onbeginuse = ::_id_25A22A5801E9C215;
  self._id_DBCE45A33308630D.onuse = ::_id_60506C80CB5907F0;
  self._id_DBCE45A33308630D.onenduse = ::_id_D06091706A0B3695;
  self._id_DBCE45A33308630D.oncantuse = ::_id_D3025F84AA90109D;
  self._id_DBCE45A33308630D.inuse = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    self._id_DBCE45A33308630D.numtouching[_id_F90358454413407F] = 0;
    self._id_DBCE45A33308630D.touchlist[_id_F90358454413407F] = [];
  }

  self._id_DBCE45A33308630D.cancontestclaim = 0;
  self._id_DBCE45A33308630D.stalemate = 0;
  self._id_DBCE45A33308630D.wasstalemate = 0;
  self._id_DBCE45A33308630D.cancontestclaim = 0;
  self._id_DBCE45A33308630D.majoritycapprogress = 1;
  self._id_DBCE45A33308630D.wasmajoritycapprogress = 0;
  self._id_DBCE45A33308630D.resetprogress = 1;

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  self._id_DBCE45A33308630D.type = "useObject";
  self._id_DBCE45A33308630D.offset3d = (0, 0, 32);
  self._id_DBCE45A33308630D scripts\mp\gameobjects::requestid(1, 1);
  self._id_DBCE45A33308630D scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_jugg_crate");
  self._id_DBCE45A33308630D scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self._id_DBCE45A33308630D.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self._id_DBCE45A33308630D.objidnum, 0);
}

_id_25A22A5801E9C215(player) {
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_taking", "icon_waypoint_losing");
  scripts\mp\utility\dialog::statusdialog("rugby_securing_jugg", player.team, "obj");
  self.visuals[0] playLoopSound("mp_care_package_non_owner_cap");
}

_id_60506C80CB5907F0(player) {
  _id_8443573A84DF299A = activatenewjuggernaut(player);

  if(!_id_8443573A84DF299A) {
    return;
  }
  juggcratecleanup();
  level.rugby.activejuggcrates[0].crateid = undefined;
  level.rugby.activejuggcrates[0] = undefined;

  if(isDefined(self._id_DBCE45A33308630D))
    self._id_DBCE45A33308630D delete();

  if(isDefined(self.visuals)) {
    foreach(visual in self.visuals)
    visual delete();
  }

  if(isDefined(self.trigger))
    self.trigger delete();
}

_id_D06091706A0B3695(team, player, result) {
  self.visuals[0] stoploopsound("mp_care_package_non_owner_cap");

  if(!result)
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_jugg_crate");

  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, player.team);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);

  if(self.curprogress > 0)
    scripts\mp\objidpoolmanager::objective_show_team_progress(self.objidnum, player.team);
  else
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
}

_id_D3025F84AA90109D(player) {}

juggcratecleanup() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);
}

createjuggcrateobjective(crate) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  crate.objid = objid;
  pos = crate.origin + (0, 0, 32);
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", pos, "icon_waypoint_jugg");
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  objective_setneutrallabel(objid, "MP_MODE_RUGBY/CRATE_CAPTURE");
  objective_setfriendlylabel(objid, "MP_MODE_RUGBY/CRATE_CAPTURING");
  objective_setenemylabel(objid, "MP_MODE_RUGBY/CRATE_LOSING");
  updatejuggcrateobjectivestate(crate);
}

updatejuggcrateobjectivestate(crate) {
  objid = crate.objid;
  _id_769B15F773ADECB6 = istrue(crate.inuse);

  if(_id_769B15F773ADECB6) {
    objective_setownerteam(objid, crate.usingplayer.team);
    objective_sethot(objid, 1);
  } else {
    objective_setownerteam(objid, undefined);
    objective_sethot(objid, 0);
  }
}

_id_75D33AA666BA0A2E(player) {
  juggconfig = level.rugby.juggconfig;

  if(istrue(player.isjuggernaut)) {
    player scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
    return 0;
  }

  result = player scripts\mp\juggernaut::_id_A5AF0A72AC912A3D(juggconfig);

  if(!isDefined(result)) {
    player scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BECOME");
    return 0;
  }

  return 1;
}

updateoverheadcamerapos(_id_723C1C68CAF21FD9) {
  if(isDefined(_id_723C1C68CAF21FD9)) {
    team = _id_723C1C68CAF21FD9;
    _id_16C2B399CF8FAEE1 = level.spectatorcameras[0][team];
  } else {
    team = self.team;
    _id_16C2B399CF8FAEE1 = level.spectatorcameras[0][self.team];
  }

  _id_584994FAB4A8712B = level.rugby;
  _id_A66BA9B157533F5A = undefined;

  if(!istrue(game["switchedsides"]))
    _id_A66BA9B157533F5A = team;
  else
    _id_A66BA9B157533F5A = scripts\engine\utility::ter_op(team == "allies", "axis", "allies");

  _id_A5D5A7083729299A = scripts\engine\utility::ter_op(_id_A66BA9B157533F5A == "allies", "axis", "allies");
  _id_974C1A9E4FC7B421 = _id_584994FAB4A8712B.endzones[_id_A66BA9B157533F5A][0].origin;
  _id_1D743581D71E8A20 = _id_584994FAB4A8712B.endzones[_id_A5D5A7083729299A][0].origin;
  _id_01F621B6115D4567 = (_id_1D743581D71E8A20 - _id_974C1A9E4FC7B421) * (1, 1, 0);
  _id_05D88D0CA4A5CE25 = length2d(_id_01F621B6115D4567);
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(_id_5FA1E1697A302583))
    _id_9261F47CF5BDFEF3 = _id_5FA1E1697A302583.origin[2];
  else
    _id_9261F47CF5BDFEF3 = 5000;

  _id_F69BA77714DAC6C2 = undefined;
  _id_316B6C03A5F9548B = undefined;

  if(doesteamhaveactivejugg(team)) {
    _id_D55A5C273C69F3C8 = getjuggorcratepos();
    _id_F69BA77714DAC6C2 = _id_D55A5C273C69F3C8 + _id_01F621B6115D4567 * (-3000 / _id_05D88D0CA4A5CE25);
    _id_F69BA77714DAC6C2 = (_id_F69BA77714DAC6C2[0], _id_F69BA77714DAC6C2[1], _id_9261F47CF5BDFEF3);
    _id_316B6C03A5F9548B = _id_D55A5C273C69F3C8 + (_id_1D743581D71E8A20 - _id_D55A5C273C69F3C8) * 0.5;
  } else {
    _id_F69BA77714DAC6C2 = _id_974C1A9E4FC7B421 + _id_01F621B6115D4567 * (-2000 / _id_05D88D0CA4A5CE25);
    _id_F69BA77714DAC6C2 = (_id_F69BA77714DAC6C2[0], _id_F69BA77714DAC6C2[1], _id_9261F47CF5BDFEF3);
    _id_316B6C03A5F9548B = getjuggorcratepos();
  }

  _id_78DF64A2CC17F941 = _id_316B6C03A5F9548B - _id_F69BA77714DAC6C2;
  _id_EFB14E53541B5B48 = vectortoangles(_id_78DF64A2CC17F941);
  _id_16C2B399CF8FAEE1.origin = _id_F69BA77714DAC6C2;
  _id_16C2B399CF8FAEE1.angles = _id_EFB14E53541B5B48;
}

startspectatorview() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  waitframe();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  updateoverheadcamerapos();
  _id_025AC223966C5537 = level.spectatorcameras[0][self.team];
  _id_0DEAD2082432CECC = _id_025AC223966C5537.origin;
  _id_06788DC28320974A = _id_025AC223966C5537.angles;
  self.deathspectatepos = _id_0DEAD2082432CECC;
  self.deathspectateangles = _id_06788DC28320974A;
  cameraent = spawn("script_model", self getvieworigin());
  cameraent setModel("tag_origin");
  cameraent.angles = _id_06788DC28320974A;
  self.spectatorcament = cameraent;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(cameraent, "tag_origin", 1);
  thread dohalfwayflash();
  cameraent movecameratomappos(self, _id_0DEAD2082432CECC, _id_06788DC28320974A);
}

dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }
  removethermal();
  removeplayeroutlinesforoverheadcam();
  thread runslamzoomonspawn();
}

applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

removethermal() {
  self thermalvisionoff();
}

movecameratomappos(player, _id_9813182985677B23, finalangles) {
  player endon("spawned_player");
  movetime = 1.0;
  _id_CC5BC42930ABBC4F = 1.0;
  self moveTo(_id_9813182985677B23, 1.0, 0.5, 0.5);
  player playlocalsound("mp_cmd_camera_zoom_out");
  player setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(finalangles, 1.0, 0.5, 0.5);
  wait 1.1;
  _id_AE753108F3DFF053 = anglesToForward(finalangles) * 300;
  _id_AE753108F3DFF053 = _id_AE753108F3DFF053 * (1, 1, 0);

  if(isDefined(player) && isDefined(player.spectatorcament)) {
    self moveTo(_id_9813182985677B23 + _id_AE753108F3DFF053, 15.0, 1.0, 1.0);
    player earthquakeforplayer(0.03, 15.0, _id_9813182985677B23 + _id_AE753108F3DFF053, 1000);
  }
}

runslamzoomonspawn() {
  self waittill("spawned_player");
  targetpos = self getEye();
  targetangles = self.angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.spectatorcament, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.spectatorcament moveTo(targetpos, 0.5);
  self playlocalsound("mp_cmd_camera_zoom_in");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(targetangles, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("playing");
  self cameraunlink();
  self.spectatorcament delete();
  wait 1.0;
}

playslamzoomflash() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay.foreground = 1;
  overlay setshader("white", 640, 480);
  overlay fadeovertime(0.4);
  overlay.alpha = 0.0;
  wait 0.4;
  overlay destroy();
}

enableplayeroutlinesforoverheadcam() {
  self.rugbyoverheadoutlines = [];

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    hudoutlineasset = scripts\engine\utility::ter_op(player.team == self.team, "outlinefill_nodepth_cyan", "outlinefill_nodepth_orange");
    outlineid = scripts\mp\utility\outline::outlineenableforplayer(player, self, hudoutlineasset, "level_script");
    self.rugbyoverheadoutlines[outlineid] = player;
  }
}

removeplayeroutlinesforoverheadcam() {
  if(isDefined(self.rugbyoverheadoutlines)) {
    foreach(id, player in self.rugbyoverheadoutlines)
    scripts\mp\utility\outline::outlinedisable(id, player);

    self.rugbyoverheadoutlines = undefined;
  }
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_jugg_crate", 0, "neutral", "MP_MODE_RUGBY/CRATE_CAPTURE", "icon_waypoint_jugg", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_jugg", 1, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_jugg", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_jugg", 1, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_jugg", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_hq_defend", 0, "friendly", "MP_MODE_RUGBY/ENDZONE_DEFEND", "icon_waypoint_hq", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_hq_attack", 0, "enemy", "MP_MODE_RUGBY/ENDZONE_ASSAULT", "icon_waypoint_hq", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_jugg", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_jugg", 0);
}