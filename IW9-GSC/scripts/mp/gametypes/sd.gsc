/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\sd.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "bombzone";
  _id_9BBACB179DEA3237[2] = "blocker";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 3, 0, 12);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 150);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 6);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;
  level.gamemodemaydropweapon = scripts\mp\utility\game::isplayeroutsideofanybombsite;
  level.onobjectivecomplete = ::onbombexploded;
  level.resetuiomnvargamemode = _id_0780CA0FF5944FCE::resetuiomnvargamemode;
  level.onmaprestart = ::onmaprestart;
  level._id_CA4E08767CBDAE12 = ::_id_AAA2901A47B8BEA9;
  level.allowlatecomers = 0;
  level.bombsplanted = 0;
  level.aplanted = 0;
  level.bplanted = 0;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    level._id_AEFA27A676322B3F = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_msnd_mode_uktl_sdt1";
  else
    game["dialog"]["gametype"] = "iw9_msnd_mode_uktl_name";

  game["dialog"]["offense_obj"] = "iw9_msnd_mode_uktl_sdbo";
  game["dialog"]["defense_obj"] = "iw9_msnd_mode_uktl_sdbd";
  game["dialog"]["bomb_achieve"] = "iw9_msnd_mode_uktl_sdba";
  game["dialog"]["bomb_pickup"] = "iw9_msnd_mode_uktl_sdbu";
  game["dialog"]["bomb_pickup_first"] = "iw9_msnd_mode_uktl_sdb1";
  game["dialog"]["bomb_taken"] = "iw9_msnd_mode_uktl_sdbt";
  game["dialog"]["bomb_lost"] = "iw9_msnd_mode_uktl_sdbl";
  game["dialog"]["bomb_defused"] = "iw9_msnd_mode_uktl_bmdf";
  game["dialog"]["bomb_planting"] = "iw9_msnd_mode_uktl_bmpl";
  game["dialog"]["bomb_planting_a"] = "iw9_msnd_mode_uktl_bmpa";
  game["dialog"]["bomb_planting_b"] = "iw9_msnd_mode_uktl_bmpb";
  game["dialog"]["bomb_planted"] = "iw9_msnd_mode_uktl_bmbp";
  game["dialog"]["enemy_bomb_a"] = "iw9_msnd_mode_uktl_bmea";
  game["dialog"]["enemy_bomb_b"] = "iw9_msnd_mode_uktl_bmeb";
  game["dialog"]["enemy_bomb_defused"] = "iw9_msnd_mode_uktl_bmde";
  game["dialog"]["enemy_bomb_planted"] = "iw9_msnd_mode_uktl_bmpe";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
  setomnvar("ui_bomb_timer_endtime_a", 0);
  setomnvar("ui_bomb_timer_endtime_b", 0);
  setomnvar("ui_bomb_planted_a", 0);
  setomnvar("ui_bomb_planted_b", 0);
  setomnvar("ui_bomb_interacting", 0);
  level.nosuspensemusic = 1;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_sd_bombtimer", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("scr_sd_planttime", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("scr_sd_defusetime", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("scr_sd_multibomb", getmatchrulesdata("bombData", "multiBomb"));
  setdynamicdvar("scr_sd_silentplant", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("scr_sd_resetProgress", getmatchrulesdata("bombData", "resetProgress"));
  setdynamicdvar("dvar_94706B5DC31F719B", getmatchrulesdata("carryData", "manualDropEnabled"));
  setdynamicdvar("scr_sd_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("sd", 0);
  setdynamicdvar("scr_sd_promode", 0);
}

waittooverridegraceperiod() {
  if(scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::islaststandenabled())
    game["dialog"]["gametype"] = "gametype_sandrescue";

  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
}

onprecachegametype() {
  game["bomb_dropped_sound"] = "iw9_mp_ui_objective_lost";
  game["bomb_recovered_sound"] = "iw9_mp_ui_objective_taken";
}

onstartgametype() {
  setomnvar("ui_victory_condition_completed", 0);
  _id_54EEF2B456BB1995 = getdvarint("dvar_7DFC9D99D9C1FF2F", 0);

  if(_id_54EEF2B456BB1995 && isDefined(game["gameStateRestore"]) && istrue(game["gameStateRestore"].enabled)) {
    level.roundlimit = scripts\mp\utility\dvars::getwatcheddvar("roundlimit");

    if(game["roundsPlayed"] >= level.roundlimit - 1) {
      _id_8613C2B22B0116A5 = game["defenders"];
      _id_D6FD8BE398B20F61 = game["attackers"];

      if(!isDefined(game["match_kills"])) {
        game["match_kills"][_id_8613C2B22B0116A5] = 0;
        game["match_kills"][_id_D6FD8BE398B20F61] = 0;
      }

      if(!isDefined(game["match_deaths"])) {
        game["match_deaths"][_id_8613C2B22B0116A5] = 0;
        game["match_deaths"][_id_D6FD8BE398B20F61] = 0;
      }

      _id_9F9016BD756FAB23 = "allies";

      if(game["match_kills"][_id_8613C2B22B0116A5] == game["match_kills"][_id_D6FD8BE398B20F61]) {
        if(game["match_deaths"][_id_8613C2B22B0116A5] == game["match_deaths"][_id_D6FD8BE398B20F61]) {
          _id_7BE710153F5D3671 = randomint(level.teamnamelist.size);
          _id_9F9016BD756FAB23 = level.teamnamelist[_id_7BE710153F5D3671];
        } else if(game["match_deaths"][_id_8613C2B22B0116A5] > game["match_deaths"][_id_D6FD8BE398B20F61])
          _id_9F9016BD756FAB23 = _id_8613C2B22B0116A5;
        else
          _id_9F9016BD756FAB23 = _id_D6FD8BE398B20F61;
      } else if(game["match_kills"][_id_8613C2B22B0116A5] > game["match_kills"][_id_D6FD8BE398B20F61])
        _id_9F9016BD756FAB23 = _id_8613C2B22B0116A5;
      else
        _id_9F9016BD756FAB23 = _id_D6FD8BE398B20F61;

      if(_id_9F9016BD756FAB23 != game["defenders"]) {
        game["switchedsides"] = 1;
        level.switchedsides = 1;
      } else
        level.switchedsides = undefined;
    }
  }

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  setclientnamemode("manual_change");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    level._effect["bomb_explosion"] = loadfx("vfx/mgl/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");
  else
    level._effect["bomb_explosion"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");

  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT");
  scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT");
  initspawns();
  thread waittooverridegraceperiod();
  setspecialloadout();

  if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
    setomnvarforallclients("ui_reset_joystick", 0);

  thread bombs();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_sd_spawn_attacker");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_sd_spawn_defender");

  if(level.mapname == "mp_m_speedball" || level.mapname == "mp_m_overunder" || level.mapname == "mp_m_overwinter") {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_defender");
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
  } else if(level.mapname == "mp_petrograd") {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_defender", 1);
  } else if(istrue(level._id_F1C340DAE77CA15D)) {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker", 1);
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_defender", 1);
  } else {
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_defender");
  }

  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(spawnteam == game["attackers"]) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
  }

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("hide_match_hint");

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    self.laststanding = 0;
  }

  if(level.multibomb && self.pers["team"] == game["attackers"])
    self setclientomnvar("ui_carrying_bomb", 1);
  else {
    self setclientomnvar("ui_carrying_bomb", 0);

    foreach(_id_EEF26A325310D3AF in level.objectives)
    _id_EEF26A325310D3AF.trigger disableplayeruse(self);
  }

  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["plants"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["plants"]);

  scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(self.pers["defuses"]))
    scripts\mp\utility\stats::setextrascore1(self.pers["defuses"]);

  level notify("spawned_player");
  thread updatematchstatushintonspawn();

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_26508F2DE04C7A52::_id_AFADC6882A95F376(_id_9156B53BCF7CE573);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  self setclientomnvar("ui_carrying_bomb", 0);

  if(!isDefined(level._id_B68731A6DC31A0CE)) {
    scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(7, 1);
    level._id_B68731A6DC31A0CE = 0;
  }

  if(isDefined(attacker.team) && attacker.team != self.team) {
    if(level._id_B68731A6DC31A0CE == 0)
      attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(4, 1);

    level._id_B68731A6DC31A0CE = level._id_B68731A6DC31A0CE + 1;
    _id_2A7EAC0B867AF187(attacker.team, 1);
  }

  thread checkallowspectating();
}

checkallowspectating() {
  waitframe();
  update = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    update = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    update = 1;
  }

  if(update)
    scripts\mp\spectating::updatespectatesettings();
}

sd_endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9) {
  setomnvarforallclients("ui_objective_pinned_text_param", 0);
  setomnvar("ui_bomb_interacting", 0);

  if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
    setomnvarforallclients("ui_reset_joystick", 1);

  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9);
}

interruptbombplanting() {
  foreach(player in level.players) {
    if(istrue(player.isplanting) && isDefined(player.lastnonuseweapon)) {
      player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(player.lastnonuseweapon);
      break;
    }
  }
}

ondeadevent(team) {
  interruptbombplanting();

  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }
  if(team == "all") {
    if(level.bombplanted)
      sd_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
    else
      sd_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  } else if(team == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }
    level thread sd_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  } else if(team == game["defenders"])
    level thread sd_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

ononeleftevent(team) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }
  _id_B0DFD912BE32D040 = scripts\mp\utility\game::getlastlivingplayer(team);
  _id_B0DFD912BE32D040.laststanding = 1;
  _id_B0DFD912BE32D040 thread givelastonteamwarning();
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
  score = scripts\mp\rank::getscoreinfovalue("stat_EF9582D72160F199");
  team = victim.team;
  _id_AEC2E5E01F424119 = 0;

  if(isDefined(attacker.laststanding) && attacker.laststanding)
    attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_4BC4AED7D23221B3");

  if(victim.isplanting) {
    setomnvar("ui_bomb_interacting", 0);
    scripts\mp\utility\game::logannouncement(victim, attacker, "Bomb Carrier Killed", victim.origin, "was_planting_bomb");
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "planting");
    attacker scripts\mp\utility\stats::incpersstat("defends", 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_ABE3CC5116E269C2");
    _id_AEC2E5E01F424119 = 1;
  } else if(victim.isbombcarrier) {
    scripts\mp\utility\game::logannouncement(victim, attacker, "Bomb Carrier Killed", victim.origin);
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "carrying");
  } else if(victim.isdefusing) {
    setomnvar("ui_bomb_interacting", 0);
    scripts\mp\utility\game::logannouncement(victim, attacker, "Defuser Killed", victim.origin);
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "defusing");
    attacker scripts\mp\utility\stats::incpersstat("defends", 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_DFCD9B1F5926CB85");
    _id_AEC2E5E01F424119 = 1;
  }

  if(isDefined(level.sdbomb.carrier)) {
    if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != victim.pers["team"]) {
      if(attacker.pers["team"] == level.sdbomb.carrier.team && attacker != level.sdbomb.carrier) {
        _id_DB36F135F40E7940 = distancesquared(level.sdbomb.carrier.origin, attacker.origin);

        if(_id_DB36F135F40E7940 < 105625) {
          attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
          attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
          attacker scripts\mp\utility\stats::incpersstat("defends", 1);
          attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
          thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "defending");
          _id_AEC2E5E01F424119 = 1;
        }
      }
    }
  }

  if(!_id_AEC2E5E01F424119)
    _id_0780CA0FF5944FCE::bombzone_awardgenericbombzonemedals(attacker, victim);
}

givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_915F01BAA2419C9F");
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, otherteam);
  level notify("last_alive", self);
  _id_548072087C9FD504::_id_7D42D3F8DD68280C(3, self.team, self getentitynumber());
}

ontimelimit() {
  sd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);

  if(!isDefined(level._id_3D06DE480D9EF9C4)) {
    scripts\mp\codcasterclientmatchdata::_id_94C8F3722D550646();
    level._id_3D06DE480D9EF9C4 = 1;
  }

  foreach(player in level.players) {
    if(isDefined(player.bombplantweapon)) {
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.bombplantweapon);
      break;
    }
  }
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue("bombtimer", 45, 1, 240);
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("defusetime", 5, 0, 20);
  level.multibomb = scripts\mp\utility\dvars::dvarintvalue("multibomb", 0, 0, 1);
  level.silentplant = scripts\mp\utility\dvars::dvarintvalue("silentPlant", 0, 0, 1);
  level.resetprogress = scripts\mp\utility\dvars::dvarintvalue("resetProgress", 0, 0, 1);
}

removebombzonec(bombzones) {
  _id_256BBD69C5D59051 = [];
  _id_01CFF8A8AF69C74D = getEntArray("script_brushmodel", "classname");

  foreach(brushmodel in _id_01CFF8A8AF69C74D) {
    if(isDefined(brushmodel.script_gameobjectname) && brushmodel.script_gameobjectname == "bombzone") {
      foreach(_id_EEF26A325310D3AF in bombzones) {
        if(distance(brushmodel.origin, _id_EEF26A325310D3AF.origin) < 100 && issubstr(tolower(_id_EEF26A325310D3AF.script_label), "c")) {
          _id_EEF26A325310D3AF.relatedbrushmodel = brushmodel;
          _id_256BBD69C5D59051[_id_256BBD69C5D59051.size] = _id_EEF26A325310D3AF;
          break;
        }
      }
    }
  }

  foreach(_id_21144C898265C718 in _id_256BBD69C5D59051) {
    _id_21144C898265C718.relatedbrushmodel delete();
    visuals = getEntArray(_id_21144C898265C718.target, "targetname");

    foreach(visual in visuals)
    visual delete();

    _id_21144C898265C718 delete();
  }

  return scripts\engine\utility::array_removeundefined(bombzones);
}

_id_1BA24A5F29969BAE() {
  if(isDefined(level._id_D27F667E6320D465)) {
    _id_2544A7D11B569E17 = scripts\engine\utility::getStruct(level._id_D27F667E6320D465._id_0B6C7DDACAF25D01, "script_noteworthy");
    _id_2544A8D11B56A04A = scripts\engine\utility::getStruct(level._id_D27F667E6320D465._id_0B6C7ADACAF25668, "script_noteworthy");
  } else {
    _id_2544A7D11B569E17 = scripts\engine\utility::getStruct("sd_bombzone_a", "script_noteworthy");
    _id_2544A8D11B56A04A = scripts\engine\utility::getStruct("sd_bombzone_b", "script_noteworthy");
  }

  if(isDefined(_id_2544A7D11B569E17) && isDefined(_id_2544A8D11B56A04A))
    return [[scripts\engine\utility::drop_to_ground(_id_2544A7D11B569E17.origin, 10, -100), _id_2544A7D11B569E17.angles], [scripts\engine\utility::drop_to_ground(_id_2544A8D11B56A04A.origin, 10, -100), _id_2544A8D11B56A04A.angles]];
}

bombs() {
  _id_0780CA0FF5944FCE::bombzone_setupbombcase("sd_bomb");
  triggers = getEntArray("bombzone", "targetname");
  triggers = removebombzonec(triggers);
  level._id_826175089E4669D6 = 0;

  if(triggers.size == 0) {
    level._id_826175089E4669D6 = 1;
    _id_C741548E94B54227 = scripts\engine\utility::getStruct("sd_bombzone_a", "script_noteworthy");

    if(isDefined(_id_C741548E94B54227)) {
      trigger = spawn("script_model", scripts\engine\utility::drop_to_ground(_id_C741548E94B54227.origin, 10, -100));
      trigger setModel("sd_equipment_bombsite_crate");
      trigger.angles = _id_C741548E94B54227.angles;
      trigger.objectivekey = "_a";
      trigger.iconname = "_a";
      trigger.usetype = 1;
      trigger.isuseobject = 1;
      triggers[triggers.size] = trigger;
    }

    _id_C741558E94B5445A = scripts\engine\utility::getStruct("sd_bombzone_b", "script_noteworthy");

    if(isDefined(_id_C741558E94B5445A)) {
      trigger = spawn("script_model", scripts\engine\utility::drop_to_ground(_id_C741558E94B5445A.origin, 10, -100));
      trigger setModel("sd_equipment_bombsite_crate");
      trigger.angles = _id_C741558E94B5445A.angles;
      trigger.objectivekey = "_b";
      trigger.iconname = "_b";
      trigger.usetype = 1;
      trigger.isuseobject = 1;
      triggers[triggers.size] = trigger;
    }
  }

  level.objectives = [];
  _id_0A65297A455514E0 = undefined;

  if(!istrue(level._id_826175089E4669D6))
    _id_0A65297A455514E0 = _id_1BA24A5F29969BAE();

  foreach(count, trigger in triggers) {
    if(isDefined(_id_0A65297A455514E0)) {
      trigger.origin = _id_0A65297A455514E0[count][0];
      trigger.angles = _id_0A65297A455514E0[count][1];
    }

    _id_EEF26A325310D3AF = _id_0780CA0FF5944FCE::setupobjective(trigger, 1, 1);
    _id_EEF26A325310D3AF.onbeginuse = ::onbeginuse;
    _id_EEF26A325310D3AF.onenduse = ::onenduse;
    _id_EEF26A325310D3AF.onuse = ::onuseplantobject;

    if(isDefined(_id_0A65297A455514E0)) {
      foreach(visual in _id_EEF26A325310D3AF.visuals) {
        visual.origin = _id_0A65297A455514E0[count][0];
        visual.angles = _id_0A65297A455514E0[count][1];
      }
    }

    level.objectives[_id_EEF26A325310D3AF.objectivekey] = _id_EEF26A325310D3AF;
  }

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  if(getdvarint("dvar_9CF963B64E1223E7", 0) == 1) {} else {
    level.sdbomb scripts\mp\gameobjects::requestid(1, 1, 2);
    level.sdbomb scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("friendly");
  }

  level.sdbombmodel = level.sdbomb.visuals[0];
  level.sdbombmodel _id_0780CA0FF5944FCE::setteaminhuddatafromteamname(game["attackers"]);
  level.sdbombmodel setasgametypeobjective();

  if(getdvarint("dvar_9CF963B64E1223E7") == 1) {} else {
    objective_setspecialobjectivedisplay(level.sdbomb.objidnum, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(level.sdbomb.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(level.sdbomb.objidnum, 0);
  }

  if(getdvarint("dvar_94706B5DC31F719B") != 0)
    level.sdbomb scripts\mp\gameobjects::_id_316D9DA870E12A03([level.sdbomb.visuals[0]], level.sdbomb.trigger, 1.0, 80, 0, ::_id_745C1786B3409D7A);

  if(!scripts\mp\flags::gameflag("prematch_done"))
    wait 0.5;

  foreach(_id_EEF26A325310D3AF in level.objectives) {
    _id_3C2389BA69E5822B = _id_0780CA0FF5944FCE::getreservedobjid(_id_EEF26A325310D3AF.objectivekey);

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      _id_EEF26A325310D3AF scripts\mp\gameobjects::requestid(1, 1, _id_3C2389BA69E5822B, 1, undefined, "icon_medium");
    else
      _id_EEF26A325310D3AF scripts\mp\gameobjects::requestid(1, 1, _id_3C2389BA69E5822B);

    _id_EEF26A325310D3AF scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    _id_EEF26A325310D3AF scripts\mp\gameobjects::setvisibleteam("any");
  }
}

onbeginuse(player) {
  _id_0780CA0FF5944FCE::bombzone_onbeginuse(player);

  if(!scripts\mp\gameobjects::isfriendlyteam(player.pers["team"])) {
    if(level.multibomb) {
      if(self.objectivekey == "_a") {
        level.objectives["_b"] scripts\mp\gameobjects::allowuse("none");
        level.objectives["_b"] scripts\mp\gameobjects::setvisibleteam("friendly");
      } else {
        level.objectives["_a"] scripts\mp\gameobjects::allowuse("none");
        level.objectives["_a"] scripts\mp\gameobjects::setvisibleteam("friendly");
      }
    }
  }
}

onenduse(team, player, result) {
  _id_0780CA0FF5944FCE::bombzone_onenduse(team, player, result);

  if(isDefined(player) && !scripts\mp\gameobjects::isfriendlyteam(player.pers["team"])) {
    if(level.multibomb && !result) {
      if(self.objectivekey == "_a") {
        level.objectives["_b"] scripts\mp\gameobjects::allowuse("enemy");
        level.objectives["_b"] scripts\mp\gameobjects::setvisibleteam("any");
      } else {
        level.objectives["_a"] scripts\mp\gameobjects::allowuse("enemy");
        level.objectives["_a"] scripts\mp\gameobjects::setvisibleteam("any");
      }
    }
  }
}

onuseplantobject(player) {
  if(!scripts\mp\gameobjects::isfriendlyteam(player.pers["team"])) {
    foreach(zone in level.objectives) {
      if(zone == self) {
        continue;
      }
      zone scripts\mp\gameobjects::disableobject();
    }
  }

  _id_0780CA0FF5944FCE::bombzone_onuseplantobject(player);
  scripts\mp\utility\game::logannouncement(player, undefined, "Bomb Planted", player.origin);
  thread scripts\mp\music_and_dialog::bombplanted_music();
}

setspecialloadout() {
  if(isusingmatchrulesdata() && scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", game["attackers"], 5, "class", "inUse"))
    level.sd_loadout[game["attackers"]] = scripts\mp\utility\game::getmatchrulesspecialclass(game["attackers"], 5);
}

onbombexploded(_id_3985F515E9F06D2C, _id_F6383793BA324EE5, player, team, _id_ADCE5B7BC256C5DD) {
  if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
    return;
  }
  if(team == game["attackers"]) {
    setgameendtime(0);
    wait 3;
    scripts\mp\utility\game::logannouncement(undefined, undefined, "Target Destroyed", self.trigger.origin);
    sd_endgame(game["attackers"], game["end_reason"]["target_destroyed"]);
  } else {
    setgameendtime(0);
    wait 1.5;
    sd_endgame(game["defenders"], game["end_reason"]["bomb_defused"]);
  }

  scripts\mp\codcasterclientmatchdata::_id_94C8F3722D550646();
}

updatematchstatushintonspawn() {
  if(level.bombplanted) {
    if(game["attackers"] == self.team)
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("bomb_defend");
    else
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("bomb_defuse");
  } else if(isDefined(level.sdbomb)) {
    if(isDefined(level.sdbomb.carrier)) {
      if(level.sdbomb.carrier.team == self.team) {
        if(level.sdbomb.carrier == self)
          scripts\mp\hud_message::_id_F004EF4606B9EFDC("bomb_plant");
        else
          scripts\mp\hud_message::_id_F004EF4606B9EFDC("bomb_escort");
      } else
        scripts\mp\hud_message::_id_F004EF4606B9EFDC("bombsite_defend");
    } else if(game["attackers"] == self.team)
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("bomb_pickup");
    else
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("bombsite_defend");
  } else
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("hide_match_hint");
}

_id_AAA2901A47B8BEA9(point) {
  if(isDefined(level.sdbomb)) {
    if(isDefined(point)) {
      if(scripts\engine\utility::ispointinsidecircle(point, level.sdbomb.curorigin, 40))
        return 0;
    } else if(self istouching(level.sdbomb.trigger))
      return 0;
  }

  return 1;
}

onmaprestart() {
  level._id_B68731A6DC31A0CE = undefined;
  scripts\mp\codcasterclientmatchdata::_id_0EDBA1EE7C2375A5();
}

_id_2A7EAC0B867AF187(team, _id_2F977E27FA739602) {
  if(!isDefined(team)) {
    return;
  }
  if(!isDefined(game["gameKillCounts"]))
    game["gameKillCounts"] = [];

  if(!isDefined(game["gameKillCounts"][team]))
    game["gameKillCounts"][team] = 0;

  game["gameKillCounts"][team] = game["gameKillCounts"][team] + _id_2F977E27FA739602;
  _id_548072087C9FD504::_id_0216B35CA5806EC6(game["gameKillCounts"][team], team);
}

_id_745C1786B3409D7A(player) {
  player setclientomnvar("ui_carrying_bomb", 0);
}