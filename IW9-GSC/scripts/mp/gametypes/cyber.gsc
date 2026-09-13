/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cyber.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "blocker";
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
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 4);
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
  level.onexfilstarted = ::onexfilstarted;
  level.onmaprestart = ::_id_B47A96F58A61D923;
  level.resetuiomnvargamemode = _id_0780CA0FF5944FCE::resetuiomnvargamemode;
  level.emplightsoff = ::emplightsoff;
  level.allowlatecomers = 0;
  level.bombplanted = 0;
  level.bombplantedteam = undefined;
  level.bombexploded = 0;
  game["canScoreOnTie"] = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_cybr_mode_uktl_cyt1";
  else
    game["dialog"]["gametype"] = "iw9_cybr_mode_uktl_cynm";

  if(!isDefined(game["roundsPlayed"]))
    _id_126FE93C04FE16DF = "iw9_cybr_mode_uktl_cybo";
  else
    _id_126FE93C04FE16DF = "iw9_cybr_mode_uktl_cybs";

  game["dialog"]["offense_obj"] = _id_126FE93C04FE16DF;
  game["dialog"]["defense_obj"] = _id_126FE93C04FE16DF;
  game["dialog"]["emppickup_friendly"] = "iw9_cybr_mode_uktl_cyaa";
  game["dialog"]["emppickup_friendly_first"] = "iw9_cybr_mode_uktl_cyab";
  game["dialog"]["emppickup_enemy"] = "iw9_cybr_mode_uktl_cyac";
  game["dialog"]["empdefused_friendly"] = "iw9_cybr_mode_uktl_cyba";
  game["dialog"]["empdefused_final_friendly"] = "iw9_cybr_mode_uktl_cybb";
  game["dialog"]["empdefused_enemy"] = "iw9_cybr_mode_uktl_cybc";
  game["dialog"]["empdefused_final_enemy"] = "iw9_cybr_mode_uktl_cybd";
  game["dialog"]["empplanted_friendly"] = "iw9_cybr_mode_uktl_cyca";
  game["dialog"]["empplanted_enemy"] = "iw9_cybr_mode_uktl_cycb";
  game["dialog"]["lead_lost"] = "iw9_cybr_mode_uktl_cyla";
  game["dialog"]["lead_taken"] = "iw9_cybr_mode_uktl_cylb";
  setomnvar("ui_bomb_carrier", -1);
  setomnvar("ui_bomb_owner_team", -1);
  setomnvar("ui_bomb_interacting", 0);
  setomnvar("ui_bomb_timer_endtime_a", 0);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_cyber_empspawn", getmatchrulesdata("cyberData", "empSpawn"));
  setdynamicdvar("scr_cyber_radarpingtime", getmatchrulesdata("cyberData", "radarPingTime"));
  setdynamicdvar("scr_cyber_persbombtimer", getmatchrulesdata("cyberData", "persBombTimer"));
  setdynamicdvar("scr_cyber_detonatescore", getmatchrulesdata("cyberData", "detonateScore"));
  setdynamicdvar("scr_cyber_bombtimer", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("scr_cyber_planttime", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("scr_cyber_defusetime", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("scr_cyber_multibomb", getmatchrulesdata("bombData", "multiBomb"));
  setdynamicdvar("scr_cyber_showenemycarrier", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("scr_cyber_idleresettime", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("scr_cyber_pickuptime", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar("dvar_484E617D6F7B7FA7", getmatchrulesdata("carryData", "manualDropEnabled"));
  setdynamicdvar("dvar_4DF16047BC4718D5", 0);
  scripts\mp\utility\game::registerhalftimedvar("cyber", 0);
}

waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
}

onprecachegametype() {
  game["bomb_dropped_sound"] = "iw9_mp_ui_objective_lost";
  game["bomb_recovered_sound"] = "iw9_mp_ui_objective_taken";
}

onstartgametype() {
  setomnvar("ui_victory_condition_completed", 0);

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  setclientnamemode("manual_change");
  level._effect["emp_detonation"] = loadfx("vfx/iw9/gameplay/mp/vfx_cyber_emp_explode.vfx");
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
  cyberattack();
  initspawns();
  thread startmatchobjectiveicons();
  thread waittooverridegraceperiod();
  setupwaypointicons();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.empspawnindex = scripts\mp\utility\dvars::dvarintvalue("empSpawn", 0, 0, 4);
  level.radarpingtime = 4;
  level.persbombtimer = scripts\mp\utility\dvars::dvarintvalue("persBombTimer", 0, 0, 1);
  level.detonatescore = scripts\mp\utility\dvars::dvarintvalue("detonateScore", 1, 0, 5);
  level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue("bombtimer", 30, 1, 300);
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("planttime", 1, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("defusetime", 1, 0, 20);
  level.multibomb = scripts\mp\utility\dvars::dvarintvalue("multibomb", 0, 0, 1);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("idleResetTime", 0, 0, 60);
  level.pickuptime = scripts\mp\utility\dvars::dvarfloatvalue("pickupTime", 0, 0, 10);
  level._id_AE278016E96E91F8 = scripts\mp\utility\dvars::dvarintvalue("allowEMPWeapon", 0, 0, 1);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_cyber_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_cyber_spawn_axis");
  _id_66D22F456A85031A = scripts\engine\utility::_id_53C4C53197386572(level._id_998E6C3EEB879000, 0);
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_cyber_spawn_allies", _id_66D22F456A85031A);
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_cyber_spawn_axis", _id_66D22F456A85031A);
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_ctf_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_ctf_spawn", 1);

  if(scripts\mp\utility\game::getgametypenumlives() != 1) {
    assignteamspawns();
    level.cyberteamspawnsetids["allies"] = "allies";
    level.cyberteamspawnsetids["axis"] = "axis";
    scripts\mp\spawnlogic::registerspawnset("allies", level.teamspawnpoints["allies"]);
    scripts\mp\spawnlogic::registerspawnset("axis", level.teamspawnpoints["axis"]);
    scripts\mp\spawnlogic::registerspawnset("neutral", level.teamspawnpoints["neutral"]);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
  spawnteam = self.pers["team"];

  if(scripts\mp\utility\game::getgametypenumlives() != 1) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(spawnteam == game["attackers"]) {
        scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
      } else {
        scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
      }
    } else
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.cyberteamspawnsetids[spawnteam], "neutral");
  } else if(spawnteam == game["attackers"]) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
  }

  return spawnpoint;
}

_id_72118BFD9964EA0A(_id_FABF84450735DD93) {
  players = level.teamdata[_id_FABF84450735DD93]["players"];

  foreach(player in players) {
    if(scripts\mp\utility\player::isreallyalive(player))
      return 0;
  }

  return 1;
}

assignteamspawns() {
  level.spawnnodetype = "mp_ctf_spawn";
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  ispathdataavailable = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];

  if(level.objectives.size == 2) {
    _id_6D651A87C5A99DBB = level.objectives["axis"];
    _id_3E473A3D5740C130 = level.objectives["allies"];
    _id_D363BC9D0700ED97 = (_id_6D651A87C5A99DBB.curorigin[0], _id_6D651A87C5A99DBB.curorigin[1], 0);
    _id_59BDAAC880603126 = (_id_3E473A3D5740C130.curorigin[0], _id_3E473A3D5740C130.curorigin[1], 0);
    _id_E2D2B97130316270 = _id_59BDAAC880603126 - _id_D363BC9D0700ED97;
    _id_4DAC618CC1728FAA = length2d(_id_E2D2B97130316270);

    foreach(spawnpoint in spawnpoints) {
      _id_C982049EA3238D92 = (spawnpoint.origin[0], spawnpoint.origin[1], 0);
      _id_42EAEA0258074021 = _id_C982049EA3238D92 - _id_D363BC9D0700ED97;
      _id_4D2D882316198C95 = vectordot(_id_42EAEA0258074021, _id_E2D2B97130316270);
      _id_79D0930DF6523209 = _id_4D2D882316198C95 / (_id_4DAC618CC1728FAA * _id_4DAC618CC1728FAA);

      if(_id_79D0930DF6523209 < 0.33) {
        spawnpoint.teambase = _id_6D651A87C5A99DBB.ownerteam;
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      if(_id_79D0930DF6523209 > 0.67) {
        spawnpoint.teambase = _id_3E473A3D5740C130.ownerteam;
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      _id_1EA3FF868194391B = undefined;
      _id_F3417BE7C70940A0 = undefined;

      if(ispathdataavailable)
        _id_1EA3FF868194391B = getpathdist(spawnpoint.origin, _id_6D651A87C5A99DBB.curorigin, 999999);

      if(isDefined(_id_1EA3FF868194391B) && _id_1EA3FF868194391B != -1)
        _id_F3417BE7C70940A0 = getpathdist(spawnpoint.origin, _id_3E473A3D5740C130.curorigin, 999999);

      if(!isDefined(_id_F3417BE7C70940A0) || _id_F3417BE7C70940A0 == -1) {
        _id_1EA3FF868194391B = distance2d(_id_6D651A87C5A99DBB.curorigin, spawnpoint.origin);
        _id_F3417BE7C70940A0 = distance2d(_id_3E473A3D5740C130.curorigin, spawnpoint.origin);
      }

      _id_7C7809CDC3F571E5 = max(_id_1EA3FF868194391B, _id_F3417BE7C70940A0);
      _id_126715ED2B04D65F = min(_id_1EA3FF868194391B, _id_F3417BE7C70940A0);
      _id_882F07CD483EE4DA = _id_126715ED2B04D65F / _id_7C7809CDC3F571E5;

      if(_id_882F07CD483EE4DA > 0.5)
        level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = spawnpoint;
    }
  } else {
    foreach(spawnpoint in spawnpoints) {
      spawnpoint.teambase = getnearestbombsiteteam(spawnpoint);

      if(spawnpoint.teambase == "axis") {
        level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = spawnpoint;
        continue;
      }

      level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = spawnpoint;
    }
  }
}

getnearestbombsiteteam(spawnpoint) {
  ispathdataavailable = scripts\mp\spawnlogic::ispathdataavailable();
  _id_DA039F6E2E6A19D2 = undefined;
  _id_36213E24B6EA2351 = undefined;

  foreach(_id_B5111CD83B4A3176 in level.objectives) {
    dist = undefined;

    if(ispathdataavailable)
      dist = getpathdist(spawnpoint.origin, _id_B5111CD83B4A3176.curorigin, 999999);

    if(!isDefined(dist) || dist == -1)
      dist = distancesquared(_id_B5111CD83B4A3176.curorigin, spawnpoint.origin);

    if(!isDefined(_id_DA039F6E2E6A19D2) || dist < _id_36213E24B6EA2351) {
      _id_DA039F6E2E6A19D2 = _id_B5111CD83B4A3176;
      _id_36213E24B6EA2351 = dist;
    }
  }

  return scripts\mp\utility\game::getotherteam(_id_DA039F6E2E6A19D2.ownerteam)[0];
}

_id_5151FB129E5AAFDF(_id_A350DB35C646E0F9) {
  switch (level.mapname) {
    case "mp_skerries_v2":
      foreach(_id_128EDF2232D31C50 in _id_A350DB35C646E0F9) {
        if(distancesquared((9770, 11472, -82), _id_128EDF2232D31C50.origin) < 1)
          _id_A350DB35C646E0F9 = scripts\engine\utility::array_remove(_id_A350DB35C646E0F9, _id_128EDF2232D31C50);
      }

      break;
    default:
      break;
  }

  return _id_A350DB35C646E0F9;
}

cyberattack() {
  _id_8A65B17BA13A8FDD = getEntArray("cyber_emp", "targetname");

  foreach(cyberemp in _id_8A65B17BA13A8FDD)
  cyberemp delete();

  _id_92FC6D4F242A0F8D = scripts\engine\utility::_id_53C4C53197386572(scripts\engine\utility::getStructArray("cyber_emp_pickup_trig", "script_noteworthy"), []);

  if(_id_92FC6D4F242A0F8D.size > 0)
    level._id_998E6C3EEB879000 = 1;
  else {
    _id_92FC6D4F242A0F8D = getEntArray("cyber_emp_pickup_trig", "targetname");

    if(_id_92FC6D4F242A0F8D.size > 0)
      _id_92FC6D4F242A0F8D = _id_5151FB129E5AAFDF(_id_92FC6D4F242A0F8D);
    else
      return;
  }

  if(level.empspawnindex == 3) {
    if(isDefined(game["empSpawn"])) {
      _id_D2113414696571E3 = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_92FC6D4F242A0F8D.size; _id_AC0E594AC96AA3A8++)
        _id_D2113414696571E3[_id_D2113414696571E3.size] = _id_AC0E594AC96AA3A8;

      _id_D2113414696571E3 = scripts\engine\utility::array_remove(_id_D2113414696571E3, game["empSpawn"]);
      level.empspawnindex = scripts\engine\utility::random(_id_D2113414696571E3);
    } else
      level.empspawnindex = randomintrange(0, _id_92FC6D4F242A0F8D.size);

    game["empSpawn"] = level.empspawnindex;
  } else if(level.empspawnindex == 4) {
    if(isDefined(game["empSpawn"])) {
      level.empspawnindex = game["empSpawn"] + 1;

      if(level.empspawnindex == _id_92FC6D4F242A0F8D.size)
        level.empspawnindex = 0;
    } else
      level.empspawnindex = 0;

    game["empSpawn"] = level.empspawnindex;
  }

  _id_F583B91C1067E38F = _id_92FC6D4F242A0F8D[level.empspawnindex];

  if(!istrue(level._id_AE278016E96E91F8))
    _id_F583B91C1067E38F = spawn("trigger_radius", _id_F583B91C1067E38F.origin, 0, 32, 128);

  visuals[0] = spawn("script_model", _id_F583B91C1067E38F.origin);
  visuals[0] setModel("projectile_cyber_emp_v0");
  tracestart = visuals[0].origin + (0, 0, 32);
  _id_8B39E5984DA1FFAF = visuals[0].origin + (0, 0, -100);
  ignoreents = [visuals[0]];
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);

  if(trace["fraction"] < 1)
    visuals[0].origin = trace["position"] + (0, 0, 2);

  _id_F583B91C1067E38F enablelinkTo();
  _id_F583B91C1067E38F linkTo(visuals[0]);
  _id_F583B91C1067E38F.baseorigin = _id_F583B91C1067E38F.origin;
  _id_F583B91C1067E38F.no_moving_platfrom_unlink = 1;
  _id_F583B91C1067E38F.linktoenabledflag = 1;

  if(!level.multibomb) {
    level.cyberemp = scripts\mp\gameobjects::createcarryobject("neutral", _id_F583B91C1067E38F, visuals, (0, 0, 16), undefined, 1);
    level.cyberemp.cancontestclaim = 1;
    level.cyberemp.stalemate = 0;
    level.cyberemp.wasstalemate = 1;
    level.cyberemp scripts\mp\gameobjects::allowuse("any");
    level.cyberemp.curprogress = 0;
    level.cyberemp.usetime = 0.05;
    level.cyberemp.userate = 1;
    level.cyberemp.id = "";
    level.cyberemp.exclusiveuse = 0;
    level.cyberemp.skiptouching = 1;
    level.cyberemp.skipminimapids = 1;
    level.cyberemp.onuse = ::emptriggerholdonuse;

    if(level.cyberemp.triggertype == "use") {
      level.cyberemp.trigger setCursorHint("HINT_NOICON");
      level.cyberemp.trigger setHintString(&"MP/EMP_PICKUP_USE");
      level.cyberemp.trigger setusepriority(-4);
    }

    level.cyberemp scripts\mp\gameobjects::setusetime(level.cyberemp.usetime);
    level.cyberemp scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    level.cyberemp.allowweapons = 1;
    level.cyberemp.onpickup = ::onpickup;
    level.cyberemp.ondrop = ::ondrop;
    level.cyberemp.firstpickup = 1;
    level thread empsitewatcher();
    level.bombrespawnpoint = level.cyberemp.visuals[0].origin;
    level.bombrespawnangles = level.cyberemp.visuals[0].angles;
    level.cyberemp.visualgroundoffset = (0, 0, 2);

    if(getdvarint("dvar_484E617D6F7B7FA7") != 0)
      level.cyberemp scripts\mp\gameobjects::_id_316D9DA870E12A03([level.cyberemp.visuals[0]], level.cyberemp.trigger, 1.0, 80, 0, ::_id_BF60004CE7BDA1F8);
  } else {
    _id_F583B91C1067E38F delete();
    visuals[0] delete();
  }

  _id_999A5EA101DCF58E = scripts\engine\utility::_id_53C4C53197386572(getEnt("cyber_empzone_axis", "targetname"), undefined);

  if(isDefined(_id_999A5EA101DCF58E)) {
    _id_F9CBFF5134DA960B = scripts\engine\utility::getStruct("cyber_empzone_axis", "script_noteworthy");

    if(isDefined(_id_F9CBFF5134DA960B))
      _id_999A5EA101DCF58E.origin = scripts\engine\utility::drop_to_ground(_id_F9CBFF5134DA960B.origin, 10, -10);
  } else {
    _id_999A5EA101DCF58E = scripts\engine\utility::_id_CE51E08DCC037220(scripts\engine\utility::getStruct("cyber_empzone_axis", "script_noteworthy"), undefined, "No cyber_empzone_axis trigger found in map. Please bug this to the level designer");

    if(!isDefined(_id_999A5EA101DCF58E))
      return;
  }

  _id_16F4D27615F0D9B1 = scripts\engine\utility::_id_53C4C53197386572(getEnt("cyber_empzone_allies", "targetname"), undefined);

  if(isDefined(_id_16F4D27615F0D9B1)) {
    _id_F9CBFF5134DA960B = scripts\engine\utility::getStruct("cyber_empzone_allies", "script_noteworthy");

    if(isDefined(_id_F9CBFF5134DA960B))
      _id_16F4D27615F0D9B1.origin = scripts\engine\utility::drop_to_ground(_id_F9CBFF5134DA960B.origin, 10, -10);
  } else {
    _id_16F4D27615F0D9B1 = scripts\engine\utility::_id_CE51E08DCC037220(scripts\engine\utility::getStruct("cyber_empzone_allies", "script_noteworthy"), undefined, "No cyber_empzone_allies trigger found in map. Please bug this to the level designer");

    if(!isDefined(_id_16F4D27615F0D9B1))
      return;
  }

  _id_E42151CF313EC61E = scripts\engine\utility::_id_53C4C53197386572(getEnt("cyber_emp_defuse_axis", "targetname"), undefined);

  if(isDefined(_id_E42151CF313EC61E))
    _id_E42151CF313EC61E delete();

  _id_838D920AF3079BA1 = scripts\engine\utility::_id_53C4C53197386572(getEnt("cyber_emp_defuse_allies", "targetname"), undefined);

  if(isDefined(_id_838D920AF3079BA1))
    _id_838D920AF3079BA1 delete();

  if(game["switchedsides"]) {
    level.objectives["allies"] = createbombzone("allies", _id_999A5EA101DCF58E);
    level.objectives["axis"] = createbombzone("axis", _id_16F4D27615F0D9B1);
  } else {
    level.objectives["allies"] = createbombzone("allies", _id_16F4D27615F0D9B1);
    level.objectives["axis"] = createbombzone("axis", _id_999A5EA101DCF58E);
  }

  level notify("enable_player_usability");
  level.objectives["axis"] thread data_center_sfx_loop();
  level.objectives["allies"] thread data_center_sfx_loop();

  if("mp_hackney_yard" == level.mapname)
    thread destroytvs();
}

createbombzone(team, trigger) {
  _id_6668F4680F6B59BB = undefined;

  if(isDefined(trigger) && isDefined(trigger.target)) {
    _id_6668F4680F6B59BB = getEntArray(trigger.target, "targetname");

    foreach(_id_E921CD594EB1122A in _id_6668F4680F6B59BB)
    _id_E921CD594EB1122A delete();
  }

  visuals[0] = spawn("script_model", scripts\engine\utility::drop_to_ground(trigger.origin, 10, -10));
  visuals[0] setModel("misc_carepackage_friendly");

  if(istrue(level._id_998E6C3EEB879000)) {
    trigger = visuals[0];
    trigger.usetype = 1;
    trigger.isuseobject = 1;
    trigger.skiptouching = 1;
    trigger makeusable();
  }

  _id_EEF26A325310D3AF = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 64), undefined, 1);
  _id_EEF26A325310D3AF.onuse = ::onuse;
  _id_EEF26A325310D3AF.onbeginuse = ::onbeginuse;
  _id_EEF26A325310D3AF.onenduse = ::onenduse;
  _id_EEF26A325310D3AF.oncantuse = ::oncantuse;
  _id_EEF26A325310D3AF.useweapon = makeweapon("iw9_cyberemp_plant_mp");
  _id_EEF26A325310D3AF.id = "bomb_zone";
  _id_EEF26A325310D3AF.trigger setusepriority(-4);
  _id_EEF26A325310D3AF.trigger setuseholdduration("duration_none");
  _id_EEF26A325310D3AF.trigger setusehideprogressbar(1);
  _id_EEF26A325310D3AF.bombplanted = 0;
  _id_EEF26A325310D3AF.bombexploded = undefined;
  _id_EEF26A325310D3AF scripts\mp\gameobjects::setusetime(level.planttime);
  _id_EEF26A325310D3AF scripts\mp\gameobjects::setusetext(&"MP/PLANTING_EXPLOSIVE");
  _id_EEF26A325310D3AF scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  _id_EEF26A325310D3AF scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  _id_EEF26A325310D3AF.objectivekey = "_" + team;
  _id_EEF26A325310D3AF.label = _id_EEF26A325310D3AF.objectivekey;
  _id_EEF26A325310D3AF resetbombsite(1, undefined, 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < visuals.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(visuals[_id_AC0E594AC96AA3A8].script_exploder)) {
      _id_EEF26A325310D3AF.exploderindex = visuals[_id_AC0E594AC96AA3A8].script_exploder;
      visuals[_id_AC0E594AC96AA3A8] thread setupkillcament(_id_EEF26A325310D3AF);
      break;
    }
  }

  _id_EEF26A325310D3AF.noweapondropallowedtrigger = spawn("trigger_radius", _id_EEF26A325310D3AF.trigger.origin, 0, 140, 100);
  return _id_EEF26A325310D3AF;
}

startmatchobjectiveicons() {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  level.objectives["allies"] scripts\mp\gameobjects::requestid(1, 1);
  level.objectives["allies"] scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
  level.objectives["allies"] scripts\mp\gameobjects::setvisibleteam("any");
  level.objectives["axis"] scripts\mp\gameobjects::requestid(1, 1);
  level.objectives["axis"] scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
  level.objectives["axis"] scripts\mp\gameobjects::setvisibleteam("any");
  level thread hidebombsitesaftermatchstart();
  level.cyberemp scripts\mp\gameobjects::requestid(1, 1);
  level.cyberemp scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_emp");
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("any");

  if(isDefined(level.cyberemp.visuals[0])) {
    level.cyberemp.visuals[0] _id_0780CA0FF5944FCE::setteaminhuddatafromteamname("neutral");
    level.cyberemp.visuals[0] setasgametypeobjective();
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(level.cyberemp.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.cyberemp.objidnum, 0);
  objective_setspecialobjectivedisplay(level.cyberemp.objidnum, 1);
  _id_220BE32C83520117 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  level.cyberemp.pingobjidnum = _id_220BE32C83520117;
  scripts\mp\objidpoolmanager::objective_add_objective(_id_220BE32C83520117, "done", level.cyberemp.origin);
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("none", _id_220BE32C83520117);
  objective_setownerteam(_id_220BE32C83520117, undefined);
  level.cyberemp scripts\mp\gameobjects::setobjectivestatusallicons("icon_waypoint_escort_emp", "waypoint_capture_kill", undefined, _id_220BE32C83520117);
  setcarriervisibility();
}

hidebombsitesaftermatchstart() {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level waittill("prematch_done");

  scripts\mp\objidpoolmanager::objective_set_play_intro(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["allies"].objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(level.objectives["axis"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.objectives["axis"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["axis"].objidnum, 1);
  level.objectives["allies"] scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives["axis"] scripts\mp\gameobjects::setvisibleteam("none");
}

emptriggerholdonuse(player) {}

setupkillcament(_id_EEF26A325310D3AF) {
  _id_027BA39CB4DA36C7 = spawn("script_origin", self.origin);
  _id_027BA39CB4DA36C7.angles = self.angles;
  _id_027BA39CB4DA36C7 rotateYaw(-45, 0.05);
  waitframe();
  _id_F69BA77714DAC6C2 = undefined;
  _id_B44CEFCF38B5DA97 = self.origin + (0, 0, 45);
  _id_DFDBE7C0C9DCA192 = self.origin + anglesToForward(_id_027BA39CB4DA36C7.angles) * 100 + (0, 0, 128);
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  result = scripts\engine\trace::ray_trace(_id_B44CEFCF38B5DA97, _id_DFDBE7C0C9DCA192, self, contentoverride);
  _id_F69BA77714DAC6C2 = result["position"];
  self.killcament = spawn("script_model", _id_F69BA77714DAC6C2);
  self.killcament setscriptmoverkillcam("explosive");
  _id_EEF26A325310D3AF.killcamentnum = self.killcament getentitynumber();
  _id_027BA39CB4DA36C7 delete();
}

empsitewatcher() {
  level endon("game_ended");

  for(;;) {
    level waittill("bomb_pickup");

    if(level.cyberemp.carrier.team == "allies")
      level.objectives["axis"] setupforplanting();
    else
      level.objectives["allies"] setupforplanting();

    waitframe();
  }
}

data_center_sfx_loop() {
  ent = scripts\engine\utility::spawn_script_origin(self.trigger.origin, self.trigger.angles);
  ent thread scripts\engine\utility::play_loop_sound_on_entity("data_center_cyber_lp");
  level waittill("emp_detonated");
  ent stopsounds("data_center_cyber_lp");
  waitframe();
  ent delete();
}

onbeginuse(player) {
  if(!scripts\mp\gameobjects::isfriendlyteam(player.pers["team"]) && !level.bombplanted) {
    player.isplanting = 1;
    setomnvar("ui_bomb_interacting", 1);
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_emp_planting");
  } else {
    player.isdefusing = 1;
    setomnvar("ui_bomb_interacting", 3);
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(2, player.team, player getentitynumber());
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite_nt", "icon_waypoint_emp_defusing");
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.radialtimeobjid, player.team);
  }

  player thread allowedwhileplanting(0);

  if(level.bombplanted && !scripts\mp\gameobjects::isfriendlyteam(player.pers["team"])) {
    player scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("defuse");
    player.isdefusing = 1;
    setomnvar("ui_bomb_interacting", 3);
    setomnvar("ui_bomb_defuser", player getentitynumber());

    if(isDefined(level.cyberemp.visuals[0]))
      level.cyberemp.visuals[0] hide();

    player thread startnpcbombusesound("briefcase_bomb_defuse_mp", "equip_suitcase_defuse_button");
  }
}

allowedwhileplanting(_id_BD138DE99B3B3507) {
  _id_3B64EB40368C1450::set("planting", "melee", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("planting", "allow_jump", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("planting", "gesture", _id_BD138DE99B3B3507);

  if(_id_BD138DE99B3B3507)
    self waittill("bomb_allow_offhands");

  _id_3B64EB40368C1450::set("planting", "melee", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("planting", "mantle", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("planting", "offhand_weapons", _id_BD138DE99B3B3507);

  if(_id_BD138DE99B3B3507)
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("planting");
}

onenduse(team, player, result) {
  objid = self.objidnum;
  scripts\mp\objidpoolmanager::objective_set_progress(objid, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(objid, 0);

  if(!result) {
    if(player.isdefusing)
      scripts\mp\gameobjects::setobjectivestatusallicons("icon_waypoint_defuse_empsite_nt", "icon_waypoint_defend_empsite_nt", "mlg_icon_waypoint_emp_planted");
    else
      scripts\mp\gameobjects::setobjectivestatusallicons("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite", undefined);

    if(isDefined(self.radialtimeobjid))
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.radialtimeobjid, player.team);

    if(player meleeButtonPressed())
      interruptbombplanting(player);
    else
      player scripts\mp\utility\inventory::switchtolastweapon();
  }

  if(istrue(player.isdefusing) || istrue(player.isplanting))
    setomnvar("ui_bomb_interacting", 0);

  player.isplanting = 0;
  player.isdefusing = 0;
  setomnvar("ui_bomb_defuser", -1);

  if(!isDefined(player)) {
    return;
  }
  player thread allowedwhileplanting(1);
  player.bombplantweapon = undefined;

  if(isPlayer(player)) {
    player setclientomnvar("ui_objective_pinned_text_param", 0);
    player.ui_bomb_planting_defusing = undefined;
  }

  if(!scripts\mp\gameobjects::isfriendlyteam(player.pers["team"])) {
    if(isDefined(level.cyberemp) && !result)
      level.cyberemp.visuals[0] show();
  }
}

startnpcbombusesound(weaponname, _id_CB3339ECE72DBDEB) {
  self endon("death");
  self endon("stopNpcBombSound");

  if(scripts\mp\utility\game::isanymlgmatch() || istrue(level.silentplant) || scripts\mp\utility\perk::_hasperk("specialty_engineer")) {
    self setentitysoundcontext("silent_plant", "on");
    return;
  }

  for(;;) {
    self waittill("weapon_change", _id_66B3DB972AC1531E);

    if(_id_66B3DB972AC1531E.basename == weaponname) {
      break;
    }
  }

  self playsoundtoteam(_id_CB3339ECE72DBDEB, self.team, self);
  enemyteam = scripts\mp\utility\game::getotherteam(self.team)[0];
  self playsoundtoteam(_id_CB3339ECE72DBDEB, enemyteam);
  self waittill("weapon_change");
  self notify("stopNpcBombSound");
}

onpickup(player, _id_5760E0F038D1BAA3, defused) {
  level notify("bomb_pickup");

  if(istrue(level._id_AE278016E96E91F8)) {
    _id_2869A3A20D48E6AD = player getcurrentprimaryweapon();

    if(isDefined(_id_2869A3A20D48E6AD.basename) && _id_2869A3A20D48E6AD.basename == "iw8_lm_dblmg_mp")
      player notify("switched_from_minigun");

    player scripts\cp_mp\utility\inventory_utility::_giveweapon("iw9_cyberemp_mp");

    if(!istrue(defused) && !player scripts\mp\utility\killstreak::isjuggernaut() && !isbot(player))
      player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw9_cyberemp_mp");
  }

  player thread empradarwatcher();
  setomnvar("ui_bomb_carrier", player getentitynumber());
  player setclientomnvar("ui_emp_carrier_hud", 1);
  _id_548072087C9FD504::_id_7D42D3F8DD68280C(16, player.team, player getentitynumber());

  if(self.firstpickup)
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_BB78056C283362A4");

  level.usestartspawns = 0;
  team = player.pers["team"];

  if(team == "allies")
    otherteam = "axis";
  else
    otherteam = "allies";

  player.isbombcarrier = 1;

  if(level.codcasterenabled)
    player setgametypevip(1);

  if(!isDefined(defused)) {
    if(self.firstpickup) {
      _id_0A675744864C65C1 = "emppickup_friendly_first";
      self.firstpickup = 0;
    } else
      _id_0A675744864C65C1 = "emppickup_friendly";

    scripts\mp\utility\dialog::leaderdialog(_id_0A675744864C65C1, team, "bomb");
    scripts\mp\utility\dialog::leaderdialog("emppickup_enemy", otherteam, "bomb");
    scripts\mp\utility\sound::playsoundonplayers(game["bomb_recovered_sound"], team);
    _id_4725E52B7C3AA25C = scripts\mp\utility\teams::getteamdata(player.team, "players");
    level thread scripts\mp\hud_message::notifyteam("emp_pickup", "emp_pickup_enemy", player.team, _id_4725E52B7C3AA25C);
    player thread scripts\mp\hud_message::showsplash("emp_pickup");
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_emppickup", player, player.team, undefined, 1);
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "cyber_carrier_defend", "cyber_data_defend", player, "cyber_emp_plant");
  self.offset3d = (0, 0, 85);
  scripts\mp\gameobjects::setownerteam(team);
  scripts\mp\gameobjects::allowuse("none");

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "done");
    } else {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "current");
      scripts\mp\gameobjects::updatecompassicon("enemy", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "icon_waypoint_kill");
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_escort_emp", "waypoint_capture_kill");
  level.objectives[team] scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives[otherteam] scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["axis"].objidnum, 0);
  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = player;
  _id_7E2C53B0BCF117D9.eventname = "pickup";
  _id_7E2C53B0BCF117D9.position = player.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
}

ondrop(player) {
  self notify("emp_dropped");
  setomnvar("ui_bomb_carrier", -1);

  if(level.bombplanted) {
    scripts\mp\gameobjects::setownerteam(player.team);
    scripts\mp\gameobjects::allowuse("none");
  } else {
    foreach(objective in level.objectives)
    objective resetbombsite(1);

    scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], scripts\mp\gameobjects::getownerteam());
    self.offset3d = (0, 0, 16);
    scripts\mp\gameobjects::allowuse("any");
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_emp", "icon_waypoint_emp");
    scripts\mp\gameobjects::setownerteam("neutral");
    scripts\mp\gameobjects::setvisibleteam("any");

    if(isDefined(player))
      scripts\mp\utility\print::printonteamarg(&"MP/EXPLOSIVES_DROPPED_BY", scripts\mp\gameobjects::getownerteam(), player);

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "cyber_emp_pickup", "cyber_emp_pickup");

    if(level.idleresettime > 0)
      thread returnaftertime();
  }

  if(istrue(level._id_AE278016E96E91F8)) {
    player scripts\cp_mp\utility\inventory_utility::_takeweapon("iw9_cyberemp_mp");
    player scripts\mp\utility\inventory::switchtolastweapon();
  }
}

returnaftertime() {
  level endon("bomb_pickup");
  _id_8E53D4CA3DE8531A = 0.0;

  while(_id_8E53D4CA3DE8531A < level.idleresettime) {
    waitframe();

    if(self.ownerteam == "neutral")
      _id_8E53D4CA3DE8531A = _id_8E53D4CA3DE8531A + level.framedurationseconds;
  }

  foreach(team in level.teamnamelist)
  scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], team);

  scripts\mp\gameobjects::returnhome();
}

onuse(player) {
  team = player.pers["team"];
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];

  if(!scripts\mp\gameobjects::isfriendlyteam(player.pers["team"]) && !level.bombplanted) {
    level thread empjamandrumbleclients(0);
    setomnvar("ui_bomb_timer_endtime_a", int(scripts\mp\gamelogic::gettimeremaining()) + gettime());
    level notify("bomb_planted");
    player notify("bomb_planted");
    player notify("objective", "plant");
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(15, player.team, player getentitynumber());
    _id_4725E52B7C3AA25C = [];
    _id_4725E52B7C3AA25C[_id_4725E52B7C3AA25C.size] = player;
    level thread scripts\mp\hud_message::notifyteam("emp_planted", "emp_planted_enemy", player.team, _id_4725E52B7C3AA25C);
    player thread scripts\mp\hud_message::showsplash("emp_planted", scripts\mp\rank::getscoreinfovalue("stat_FD5E014E1660FC72"));
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_empplanted", player, undefined, undefined, 1);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "cyber_emp_defend", "cyber_emp_defsue");
    player setclientomnvar("ui_emp_carrier_hud", 0);
    scripts\mp\utility\dialog::leaderdialog("empplanted_friendly", team);
    player playsoundtoteam("mp_bombplaced_friendly", team);
    scripts\mp\utility\dialog::leaderdialog("empplanted_enemy", otherteam);
    player playsoundtoteam("mp_bombplaced_enemy", otherteam);
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FD5E014E1660FC72");
    player scripts\cp_mp\challenges::onplant();
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = player;
    _id_7E2C53B0BCF117D9.eventname = "plant";
    _id_7E2C53B0BCF117D9.position = player.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
    player.bombplantedtime = gettime();
    player scripts\mp\utility\stats::incpersstat("plants", 1);
    player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
    player scripts\mp\persistence::statsetchild("round", "plants", player.pers["plants"]);
    player scripts\mp\utility\stats::setextrascore0(player.pers["plants"]);
    player scripts\cp_mp\pet_watch::addplantingcharge();
    level.bombplanted = 1;
    level thread bombplanted(self, player.pers["team"]);
    level.bombowner = player;
    level.bombowner.isbombcarrier = 0;

    if(level.codcasterenabled)
      player setgametypevip(0);

    level.cyberemp scripts\mp\gameobjects::setdropped();
    level.cyberemp scripts\mp\gameobjects::allowuse("none");
    level.cyberemp scripts\mp\gameobjects::setvisibleteam("none");

    if(istrue(level._id_AE278016E96E91F8)) {
      player scripts\cp_mp\utility\inventory_utility::_takeweapon("iw9_cyberemp_mp");
      player scripts\mp\utility\inventory::switchtolastweapon();
    }

    self.useweapon = makeweapon("iw9_cyberemp_defuse_mp");
    setupfordefusing(self, player);
  } else {
    player notify("bomb_defused");
    player notify("objective", "defuse");
    _id_4555368557DC49AC = _id_72118BFD9964EA0A(otherteam);

    if(_id_4555368557DC49AC) {
      _id_EBBE93B2CF924047 = "empdefused_final_friendly";
      _id_AD194F060980B384 = "empdefused_final_enemy";
      level._id_1242A000845A4331 = 1;
    } else {
      _id_EBBE93B2CF924047 = "empdefused_friendly";
      _id_AD194F060980B384 = "empdefused_enemy";
    }

    scripts\mp\utility\dialog::leaderdialog(_id_EBBE93B2CF924047, team);
    scripts\mp\utility\dialog::leaderdialog(_id_AD194F060980B384, otherteam);
    _id_4725E52B7C3AA25C = [];
    _id_4725E52B7C3AA25C[_id_4725E52B7C3AA25C.size] = player;
    level thread scripts\mp\hud_message::notifyteam("emp_defuse", "emp_defuse_enemy", player.team, _id_4725E52B7C3AA25C);
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_empdefused", player, undefined, undefined, 1);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "cyber_carrier_defend", "cyber_data_defend", player, "cyber_emp_plant");

    if(isDefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && scripts\mp\utility\player::isreallyalive(level.bombowner)) {
      player thread scripts\mp\rank::scoreeventpopup("stat_83821E6F33D9A7B2");
      player thread scripts\mp\hud_message::showsplash("ninja_defuse", scripts\mp\rank::getscoreinfovalue("stat_F982730CA4AE79C7"));
    } else {
      player thread scripts\mp\rank::scoreeventpopup("stat_F982730CA4AE79C7");
      player thread scripts\mp\hud_message::showsplash("emp_defuse", scripts\mp\rank::getscoreinfovalue("stat_F982730CA4AE79C7"));
    }

    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D42F3A6D11E62127");
    player scripts\mp\utility\stats::incpersstat("defuses", 1);
    player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
    player scripts\mp\persistence::statsetchild("round", "defuses", player.pers["defuses"]);
    scripts\cp_mp\challenges::_id_C51330573171A1BE(player);
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = player;
    _id_7E2C53B0BCF117D9.eventname = "defuse";
    _id_7E2C53B0BCF117D9.position = player.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
    level.bombplanted = 0;
    level thread bombdefused(self);
    resetbombsite(1, player);

    if(_id_4555368557DC49AC)
      wait 3;

    level.cyberemp scripts\mp\gameobjects::allowuse("any");
    level.cyberemp scripts\mp\gameobjects::setpickedup(player, 0, 1);
  }
}

empjamandrumbleclients(rumble, endgame) {
  foreach(player in level.players) {
    player setempjammed(1);

    if(istrue(rumble))
      player playrumbleonpositionforclient("artillery_rumble", player.origin);
  }

  if(!istrue(endgame)) {
    wait 1;

    foreach(player in level.players)
    player setempjammed(0);
  }
}

resetbombsite(defused, player, _id_0A9E157E4D5311B2) {
  if(!defused) {
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_planted_empsite", "icon_waypoint_target_empsite");
    scripts\mp\gameobjects::setvisibleteam("any");
  } else {
    if(istrue(_id_0A9E157E4D5311B2)) {
      return;
    }
    if(isDefined(player))
      self.ownerteam = player.team;

    self.id = "bomb_zone";
    scripts\mp\gameobjects::allowuse("none");
    scripts\mp\gameobjects::setvisibleteam("none");
    scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["allies"].objidnum, 1);
    scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["axis"].objidnum, 1);
    return;
  }
}

setupforplanting() {
  self.trigger enableplayeruse(level.cyberemp.carrier);
  scripts\mp\gameobjects::allowuse("enemy");
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setusetext(&"MP/PLANTING_EXPLOSIVE");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EMP");
  scripts\mp\gameobjects::setkeyobject(level.cyberemp);
  self.useweapon = makeweapon("iw9_cyberemp_plant_mp");
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
  self.bombplanted = 0;
}

setupfordefusing(_id_FF7F197ECB7A2B90, player) {
  self.trigger setusepriority(-4);
  self.ownerteam = player.team;
  scripts\mp\gameobjects::allowuse("enemy");
  scripts\mp\gameobjects::setusetime(level.defusetime);
  scripts\mp\gameobjects::setusetext(&"MP/DEFUSING_EXPLOSIVE");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_DEFUSE_EMP");
  scripts\mp\gameobjects::setkeyobject(undefined);
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite_nt", "icon_waypoint_defuse_empsite_nt");
  thread _id_0780CA0FF5944FCE::bombradialfill(player.team, "icon_waypoint_planted_empsite", "icon_waypoint_defuse_empsite");
  scripts\mp\gameobjects::setvisibleteam("any", self.radialtimeobjid);
  self.id = "defuse_object";
  self.bombplanted = 1;
  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(player.team);
  _id_3AAA5FB58A6C2EB7 = _id_B0C33D224B825287[0];

  foreach(_id_AC0E424AC96A7113 in scripts\mp\utility\teams::getteamdata(_id_3AAA5FB58A6C2EB7, "players"))
  self.trigger enableplayeruse(_id_AC0E424AC96A7113);

  if(istrue(level._id_998E6C3EEB879000)) {
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::_id_3D0F2343793D709B(player.team);

    foreach(_id_C98AAC0E8E6EAF8C in _id_6D5ED003AF1F9612)
    self.trigger disableplayeruse(_id_C98AAC0E8E6EAF8C);
  }
}

bombdefused(object) {
  scripts\mp\gamelogic::resumetimer();
  level.timelimitoverride = 0;
  level.scorelimitoverride = 0;
  object.bombplanted = 0;
  setomnvar("ui_bomb_owner_team", -1);
  level thread[[level.updategameevents]]();
  object.visuals[0] scripts\mp\gamelogic::stoptickingsound();
  level notify("bomb_defused");
}

oncantuse(player) {}

bombplanted(_id_2810BD61A09D19F5, team) {
  level endon("overtime");
  scripts\mp\gamelogic::pausetimer();
  setomnvar("ui_match_timer_stopped", 0);
  level.bombplantedteam = team;
  level.timelimitoverride = 1;
  level.scorelimitoverride = 1;

  if(isDefined(team)) {
    if(team == "allies")
      setomnvar("ui_bomb_owner_team", 2);
    else
      setomnvar("ui_bomb_owner_team", 1);
  }

  setgameendtime(int(gettime() + level.bombtimer * 1000));
  _id_2810BD61A09D19F5.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  starttime = gettime();
  thread bomb_pre_exp_music();
  thread bomb_pre_exp_sfx_wait(_id_2810BD61A09D19F5.visuals[0].origin);
  bombtimerwait();
  _id_2810BD61A09D19F5.visuals[0] scripts\mp\gamelogic::stoptickingsound();

  if(!level.bombplanted) {
    if(level.persbombtimer) {
      _id_3B5803E733581858 = (gettime() - starttime) / 1000;
      level.bombtimer = level.bombtimer - _id_3B5803E733581858;
    }

    return;
  }

  _id_B085E4DE6D22E286 = _id_2810BD61A09D19F5.visuals[0].origin;
  level.bombexploded = 1;
  setDvar("ui_danger_team", "BombExploded");

  if(isDefined(level.bombowner)) {
    _id_2810BD61A09D19F5.visuals[0] radiusdamage(_id_B085E4DE6D22E286, 512, 1, 1, level.bombowner, "MOD_EXPLOSIVE", "bomb_site_mp");
    level.bombowner scripts\mp\utility\stats::incpersstat("destructions", 1);
    level.bombowner scripts\mp\persistence::statsetchild("round", "destructions", level.bombowner.pers["destructions"]);
  } else
    _id_2810BD61A09D19F5.visuals[0] radiusdamage(_id_B085E4DE6D22E286, 512, 1, 1, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

  playsoundatpos(_id_B085E4DE6D22E286, "iw9_exp_cyber_emp_close");
  _id_9AF72BBDFDEACE5D = _id_2810BD61A09D19F5.visuals[0] gettagorigin("tag_origin");
  _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["emp_detonation"], _id_9AF72BBDFDEACE5D);
  triggerfx(_id_EFDFC6EBE7A152C5);
  earthquake(0.6, 1.5, _id_B085E4DE6D22E286, 10000);
  _id_2810BD61A09D19F5.visuals[0] setModel("misc_carepackage_friendly_dmg");
  level thread empjamandrumbleclients(1, 1);
  level notify("emp_detonated");

  foreach(objective in level.objectives) {
    objective notify("disabled");
    objective.trigger scripts\mp\utility\usability::setallunusable();
  }

  if(game["switchedsides"])
    _id_2810BD61A09D19F5.exploderindex = 200;
  else
    _id_2810BD61A09D19F5.exploderindex = 201;

  if(isDefined(_id_2810BD61A09D19F5.exploderindex))
    scripts\engine\utility::exploder(_id_2810BD61A09D19F5.exploderindex);

  _id_2810BD61A09D19F5.bombplanted = 0;
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives["allies"] scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives["axis"] scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["axis"].objidnum, 0);
  setgameendtime(0);
  level.scorelimitoverride = 1;

  if(isDefined(level.bombowner))
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_destroyed_cyberbombsite", level.bombowner);

  _id_2810BD61A09D19F5 scripts\mp\gameobjects::releaseid();

  if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
    return;
  }
  wait 3;
  thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["target_destroyed"], undefined, undefined, level.detonatescore);
}

bombtimerwait() {
  level endon("bomb_defused");
  level endon("overtime_ended");
  _id_4DFAA92E2BCE1194 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime", _id_4DFAA92E2BCE1194);
  level thread handlehostmigration(_id_4DFAA92E2BCE1194);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

bomb_pre_exp_music() {
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  thread scripts\mp\music_and_dialog::bombplanted_music();
}

bomb_pre_exp_sfx_wait(_id_80B64A135EA82D49) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  wait(max(level.bombtimer - 2, 0.1));
  playsoundatpos(_id_80B64A135EA82D49, "iw9_exp_cyber_emp_preexplode");
}

handlehostmigration(_id_4DFAA92E2BCE1194) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  _id_3B5803E733581858 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(_id_3B5803E733581858 > 0)
    setomnvar("ui_bomb_timer_endtime", _id_4DFAA92E2BCE1194 + _id_3B5803E733581858);
}

overtimethread(time) {
  level endon("game_ended");
  level.inovertime = 1;
  wait 5.0;
  level.disablespawning = 1;
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
}

ontimelimit() {
  if(level.bombexploded) {
    return;
  }
  _id_F0F967947C6A7EC8();
  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["cyber_tie"]);
}

onspawnplayer(_id_9156B53BCF7CE573) {
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("hide_match_hint");

  if(level.multibomb)
    self setclientomnvar("ui_emp_carrier_hud", 1);
  else {
    self setclientomnvar("ui_emp_carrier_hud", 0);
    thread updatebombsiteusability();
  }

  self.isplanting = 0;
  self.isdefusing = 0;
  self.isbombcarrier = 0;

  if(scripts\mp\utility\game::inovertime() && !isDefined(self.otspawned))
    thread printothint();

  if(isDefined(self.pers["plants"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["plants"]);

  if(isDefined(self.pers["rescues"]))
    scripts\mp\utility\stats::setextrascore1(self.pers["rescues"]);

  thread updatematchstatushintonspawn();
}

updatebombsiteusability() {
  if(!isDefined(level.objectives))
    level waittill("enable_player_usability");

  foreach(_id_EEF26A325310D3AF in level.objectives) {
    if(_id_EEF26A325310D3AF.bombplanted == 0)
      _id_EEF26A325310D3AF.trigger disableplayeruse(self);
  }
}

updatematchstatushintonspawn() {
  if(level.bombplanted) {
    if(isDefined(level.bombplantedteam) && level.bombplantedteam == self.team)
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("cyber_emp_defend");
    else
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("cyber_emp_defsue");
  } else if(isDefined(level.cyberemp) && isDefined(level.cyberemp.carrier)) {
    if(level.cyberemp.carrier.team == self.team) {
      if(level.cyberemp.carrier == self)
        scripts\mp\hud_message::_id_F004EF4606B9EFDC("cyber_emp_plant");
      else
        scripts\mp\hud_message::_id_F004EF4606B9EFDC("cyber_carrier_defend");
    } else
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("cyber_data_defend");
  } else
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("cyber_emp_pickup");
}

_id_F0F967947C6A7EC8() {
  foreach(player in level.players) {
    if(interruptbombplanting(player)) {
      break;
    }
  }
}

interruptbombplanting(player) {
  if(istrue(player.isplanting) && isDefined(player.lastnonuseweapon)) {
    player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(player.lastnonuseweapon);
    return 1;
  }

  return 0;
}

ondeadevent(team) {
  _id_F0F967947C6A7EC8();

  if(level.bombexploded > 0 && !level.postgameexfil) {
    return;
  }
  if(team == "all") {
    if(level.bombplanted) {
      otherteam = scripts\mp\utility\game::getotherteam(level.bombplantedteam)[0];
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["end_reason"][tolower(game[otherteam]) + "_eliminated"], undefined, undefined, level.detonatescore);
    } else
      thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["tie"]);
  } else if(level.bombplanted) {
    if(team != level.bombplantedteam)
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["end_reason"][tolower(game[team]) + "_eliminated"], undefined, undefined, level.detonatescore);
    else
      return;
  } else if(team == game["attackers"])
    level thread scripts\mp\gamelogic::endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  else if(team == game["defenders"])
    level thread scripts\mp\gamelogic::endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

ononeleftevent(team) {
  if(level.bombexploded > 0) {
    return;
  }
  _id_B0DFD912BE32D040 = scripts\mp\utility\game::getlastlivingplayer(team);

  if(isDefined(_id_B0DFD912BE32D040)) {
    _id_B0DFD912BE32D040.laststanding = 1;
    _id_B0DFD912BE32D040 thread givelastonteamwarning();
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  self setclientomnvar("ui_emp_carrier_hud", 0);
  thread checkallowspectating();

  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  if(self.isbombcarrier && level.codcasterenabled)
    self setgametypevip(0);

  awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);
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

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(victim.isplanting) {
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "planting");
    attacker scripts\mp\utility\stats::incpersstat("defends", 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
  } else if(victim.isbombcarrier)
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "carrying");
  else if(victim.isdefusing)
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "defusing");
}

printothint() {
  self endon("disconnect");
  wait 0.25;
  self.otspawned = 1;
}

awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_9FF9376383F4BC58 = 0;
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

  if(isDefined(level.cyberemp.carrier)) {
    if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != victim.pers["team"]) {
      if(isDefined(attacker.isbombcarrier) && attackerisinflictor && isDefined(objweapon) && objweapon.basename == "iw9_cyberemp_mp") {
        attacker thread scripts\mp\rank::scoreeventpopup("stat_381F16DD2B01C743");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_8F7FF4D5395B6AC3");
      } else if(istrue(victim.isbombcarrier)) {
        victim.isbombcarrier = 0;

        if(istrue(victim.showempminimap))
          victim scripts\mp\utility\player::hideminimap();

        attacker thread scripts\mp\rank::scoreeventpopup("stat_0A019BA6FDA76386");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2E0245DB0447F036");
        thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "carrying");
      }

      if(attacker.pers["team"] == level.cyberemp.ownerteam && attacker != level.cyberemp.carrier) {
        _id_DB36F135F40E7940 = distancesquared(level.cyberemp.carrier.origin, _id_86C1C8628B1D55F8);

        if(_id_DB36F135F40E7940 < 105625) {
          attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
          attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
          attacker scripts\mp\utility\stats::incpersstat("defends", 1);
          attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
          thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "defending");
        }
      }
    }
  }

  foreach(_id_EEF26A325310D3AF in level.objectives) {
    if(istrue(_id_EEF26A325310D3AF.trigger.trigger_off)) {
      continue;
    }
    ownerteam = _id_EEF26A325310D3AF scripts\mp\gameobjects::getownerteam();

    if(ownerteam != attacker.team) {
      _id_A3A2CE8B8E74EBEF = distsquaredcheck(_id_EEF26A325310D3AF.trigger, _id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D);

      if(_id_A3A2CE8B8E74EBEF) {
        _id_8363BEB01B537D3E = 1;
        attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
        _id_EEF26A325310D3AF notify("assault", attacker);
        thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "assaulting");
        continue;
      }
    } else {
      _id_F6A091229A5E7B04 = distsquaredcheck(_id_EEF26A325310D3AF.trigger, _id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D);

      if(_id_F6A091229A5E7B04) {
        _id_88F4967A49A22ED7 = 1;
        attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
        _id_EEF26A325310D3AF notify("defend", attacker);
        attacker scripts\mp\utility\stats::incpersstat("defends", 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "defending");
        continue;
      }
    }
  }
}

distsquaredcheck(trigger, _id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D) {
  _id_9AE8B00A8E8F64FA = distancesquared(trigger.origin, _id_86C1C8628B1D55F8);
  _id_1881A89C6F1E8775 = distancesquared(trigger.origin, _id_F7DED1FDB02A123D);

  if(_id_9AE8B00A8E8F64FA < 105625 || _id_1881A89C6F1E8775 < 105625) {
    if(!isDefined(trigger.modifieddefendcheck))
      return 1;
    else if(_id_86C1C8628B1D55F8[2] - trigger.origin[2] < 100 || _id_F7DED1FDB02A123D[2] - trigger.origin[2] < 100)
      return 1;
    else
      return 0;
  } else
    return 0;
}

_id_B47A96F58A61D923() {
  scripts\mp\codcasterclientmatchdata::_id_0EDBA1EE7C2375A5();
}

empradarwatcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self endon("last_stand_start");
  self endon("emp_dropped");

  if(istrue(level._id_AE278016E96E91F8))
    thread weaponswapwatcher();

  while(isDefined(level.cyberemp.carrier) && self == level.cyberemp.carrier) {
    waitframe();

    if(istrue(level._id_AE278016E96E91F8) && self.currentprimaryweapon.basename != "iw9_cyberemp_mp") {
      continue;
    }
    if(!isDefined(self.nextradarpingtime) || gettime() > self.nextradarpingtime) {
      if(istrue(level._id_AE278016E96E91F8))
        triggeroneoffradarsweep(self);
      else
        triggerportableradarping(self.origin, self, 1000);

      self.nextradarpingtime = gettime() + level.radarpingtime * 1000;
    }
  }
}

weaponswapwatcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self.showempminimap = 0;

  for(;;) {
    if(self.currentprimaryweapon.basename == "iw9_cyberemp_mp") {
      if(!istrue(self.showempminimap)) {
        scripts\mp\utility\player::showminimap();
        self.showempminimap = 1;
      }
    } else if(istrue(self.showempminimap)) {
      scripts\mp\utility\player::hideminimap();
      self.showempminimap = 0;
    }

    waitframe();
  }
}

applybombcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self.pers["gamemodeLoadout"] = level.cyber_loadouts[self.team];
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self.gamemode_chosenclass = self.class;
  scripts\mp\class::_id_A16868D4DCD81A4B();
  self notify("faux_spawn");
  self.gameobject_fauxspawn = 1;
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

removebombcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self notify("lost_juggernaut");
  waitframe();
  self.pers["gamemodeLoadout"] = undefined;
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

setcarriervisibility() {
  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 0.0;
        break;
      case 1:
        level.cyberemp.objidpingfriendly = 0;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 0.05;
        break;
      case 2:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 1.0;
        break;
      case 3:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 1.5;
        break;
      case 4:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 2.0;
        break;
      case 5:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 3.0;
        break;
      case 6:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 4.0;
        break;
    }
  } else {
    level.cyberemp.objidpingfriendly = 1;
    level.cyberemp.objidpingenemy = 0;
    level.cyberemp.objpingdelay = 3.0;
  }
}

onexfilstarted() {
  level.cyberemp scripts\mp\gameobjects::releaseid();

  if(isDefined(level.cyberemp.carrier)) {
    foreach(_id_AEDD764B7987A8B2 in level.objectives) {
      if(_id_AEDD764B7987A8B2.bombplanted == 0)
        _id_AEDD764B7987A8B2.trigger disableplayeruse(level.cyberemp.carrier);
    }
  }

  level.cyberemp.trigger delete();
  level.cyberemp.visuals[0] delete();
}

emplightsoff() {
  level endon("game_ended");
  level waittill("emp_detonated");

  for(;;) {
    foreach(struct in level.emplights) {
      struct.switchstatus = "off";
      handleemponoff(struct);
    }

    wait 0.1;

    foreach(struct in level.emplights) {
      struct.switchstatus = "on";
      handleemponoff(struct);
    }

    wait 0.15;

    foreach(struct in level.emplights) {
      struct.switchstatus = "off";
      handleemponoff(struct);
    }

    wait 0.1;

    foreach(struct in level.emplights) {
      struct.switchstatus = "on";
      handleemponoff(struct, 0.05);
    }

    wait 0.5;

    foreach(struct in level.emplights) {
      struct.switchstatus = "off";
      handleemponoff(struct);
    }

    wait 10;
  }
}

destroytvs() {
  level endon("game_ended");
  level waittill("emp_detonated");
  tvs = getEntArray("destructibleTVs", "script_noteworthy");

  foreach(_id_CDDE3F78F5298EAB in tvs) {
    _id_0FA10CA1040ABB07 = getscriptablearray(_id_CDDE3F78F5298EAB.target, "targetname");

    foreach(_id_BE61E7030B1F3B80 in _id_0FA10CA1040ABB07) {
      _id_BE61E7030B1F3B80 setscriptablepartstate("tv", "dead");
      waitframe();
    }
  }
}

handleemponoff(struct, _id_38A6B48A5F70C0B8) {
  _id_3702CBA57F844507 = 0.2;

  if(isDefined(_id_38A6B48A5F70C0B8))
    _id_3702CBA57F844507 = _id_38A6B48A5F70C0B8;

  if(struct.switchstatus == "on") {
    self notify("masterSwitch_on");

    if(!struct.lightson) {
      foreach(light in struct.lights)
      light thread scripts\mp\motiondetectors::lightonroutine(randomfloat(_id_3702CBA57F844507));

      thread scripts\mp\motiondetectors::onoffmodelswap(struct.models, "on");
      struct.lightson = 1;
    }
  } else if(struct.switchstatus == "off") {
    if(struct.lightson) {
      level scripts\mp\motiondetectors::lightoffroutine(struct.lights);
      thread scripts\mp\motiondetectors::onoffmodelswap(struct.models, "off");
      struct.lightson = 0;
    }

    if(isDefined(self.script_parameters) && self.script_parameters == "motion")
      struct.switchstatus = "motion";

    self notify("lights_off");
  }
}

_id_BF60004CE7BDA1F8(player) {
  player setclientomnvar("ui_emp_carrier_hud", 0);
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_emp", 2, "neutral", "MP_INGAME_ONLY/OBJ_EMP_CAPS", "hud_icon_cyber_bomb", 0, 10);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_escort_emp", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "hud_icon_cyber_bomb", 0, 10);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_defend_empsite", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cyber_bombsite", 0, 3);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_target_empsite", 0, "enemy", "MP_INGAME_ONLY/OBJ_ATTACK_CAPS", "icon_waypoint_cyber_bombsite", 0, 3);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_planted_empsite", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cyber_bombsite", 0, 4);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_defuse_empsite", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_cyber_bombsite", 0, 4);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_emp_planting", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_cyber_bombsite", 0, 3);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_emp_defusing", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_cyber_bombsite", 0, 4);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_defend_empsite_nt", 0, "friendly", "", "icon_waypoint_cyber_bombsite", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_defuse_empsite_nt", 0, "enemy", "", "icon_waypoint_cyber_bombsite", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("mlg_icon_waypoint_emp_planted", 0, "neutral", "", "icon_minimap_objective_codcaster_bomb", 0, undefined);
}