/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cmd.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = "cop";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 1200);

    if(1)
      scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 5);
    else
      scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 0);

    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::setovertimelimitdvar(300);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.disablebuddyspawn = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.ontimelimit = ::ontimelimit;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.lastcaptime = gettime();
  level.resetuiomnvargamemode = _id_0780CA0FF5944FCE::resetuiomnvargamemode;
  level.cmdattackingteam = "neutral";
  level.cmddefendingteam = "neutral";
  level.timerstoppedforgamemode = 0;
  level.extratime = 0;
  game["dialog"]["gametype"] = "intro_start";
  game["dialog"]["bomb_achieve"] = "bomb_achieve";
  game["dialog"]["bomb_taken"] = "bomb_taken";
  game["dialog"]["bomb_lost"] = "bomb_enemyowns";
  game["dialog"]["bomb_defusing"] = "bomb_enemydefusing";
  game["dialog"]["bomb_defused"] = "bomb_defused";
  game["dialog"]["bomb_planted"] = "bomb_planted";
  game["dialog"]["enemy_bomb_a"] = "bomb_enemy_a";
  game["dialog"]["enemy_bomb_b"] = "bomb_enemy_b";
  game["dialog"]["enemy_bomb_defused"] = "bomb_enemydefused";
  game["dialog"]["enemy_bomb_planted"] = "bomb_enemyplanted";
  game["dialog"]["offense_obj"] = "cop_obj_clock";
  game["dialog"]["defense_obj"] = "cop_obj_clock";
  game["dialog"]["cop_obj_0_mp_faridah"] = "obj_embassy";
  game["dialog"]["cop_obj_0_attack_mp_faridah"] = "embassy_attack";
  game["dialog"]["cop_obj_0_mp_euphrates"] = "obj_compound";
  game["dialog"]["cop_obj_0_attack_mp_euphrates"] = "compound_attack";
  game["dialog"]["cop_obj_1_mp_faridah"] = "obj_school";
  game["dialog"]["cop_obj_1_attack_mp_faridah"] = "school_attack";
  game["dialog"]["cop_obj_1_defend_mp_faridah"] = "school_defend";
  game["dialog"]["cop_obj_1_enemy_cap_mp_faridah"] = "school_enemycapture";
  game["dialog"]["cop_obj_1_enemy_hold_mp_faridah"] = "school_enemycaptured";
  game["dialog"]["cop_obj_1_mp_euphrates"] = "obj_buses";
  game["dialog"]["cop_obj_1_attack_mp_euphrates"] = "buses_attack";
  game["dialog"]["cop_obj_1_defend_mp_euphrates"] = "buses_defend";
  game["dialog"]["cop_obj_1_enemy_cap_mp_euphrates"] = "buses_enemycapture";
  game["dialog"]["cop_obj_1_enemy_hold_mp_euphrates"] = "buses_enemycaptured";
  game["dialog"]["cop_obj_2_mp_faridah"] = "obj_clock";
  game["dialog"]["cop_obj_2_attack_mp_faridah"] = "clock_attack";
  game["dialog"]["cop_obj_2_defend_mp_faridah"] = "clock_defend";
  game["dialog"]["cop_obj_2_mp_euphrates"] = "obj_underpass";
  game["dialog"]["cop_obj_2_attack_mp_euphrates"] = "underpass_attack";
  game["dialog"]["cop_obj_2_defend_mp_euphrates"] = "underpass_defend";
  game["dialog"]["cop_obj_2_enemy_cap_mp_euphrates"] = "underpass_enemycapture";
  game["dialog"]["cop_obj_2_enemy_hold_mp_euphrates"] = "underpass_enemycaptured";
  game["dialog"]["cop_obj_3_mp_faridah"] = "obj_warehouse";
  game["dialog"]["cop_obj_3_attack_mp_faridah"] = "warehouse_attack";
  game["dialog"]["cop_obj_3_defend_mp_faridah"] = "warehouse_defend";
  game["dialog"]["cop_obj_3_enemy_cap_mp_faridah"] = "warehouse_enemycapture";
  game["dialog"]["cop_obj_3_enemy_hold_mp_faridah"] = "warehouse_enemycaptured";
  game["dialog"]["cop_obj_3_mp_euphrates"] = "obj_construction";
  game["dialog"]["cop_obj_3_attack_mp_euphrates"] = "construction_attack";
  game["dialog"]["cop_obj_3_defend_mp_euphrates"] = "construction_defend";
  game["dialog"]["cop_obj_3_enemy_cap_mp_euphrates"] = "construction_enemycapture";
  game["dialog"]["cop_obj_3_enemy_hold_mp_euphrates"] = "construction_enemycaptured";
  game["dialog"]["cop_obj_4_mp_faridah"] = "obj_compound";
  game["dialog"]["cop_obj_4_defend_mp_faridah"] = "compound_defend";
  game["dialog"]["cop_obj_4_mp_euphrates"] = "obj_fob";
  game["dialog"]["cop_obj_4_attack_mp_euphrates"] = "fob_attack";
  game["dialog"]["cop_obj_4_defend_mp_euphrates"] = "fob_defend";
  game["dialog"]["cop_target_active"] = "gamestate_targetactive";
  game["dialog"]["cop_obj_contested"] = "obj_contested";
  game["dialog"]["cop_enemy_sec"] = "enemy_capturingneutral";
  game["dialog"]["cop_hold"] = "confirm_copsecurewait";
  game["dialog"]["cop_outpostcaptured"] = "confirm_copsecureyes";
  game["dialog"]["cop_bombplanted_atenemy"] = "bombplanted_atenemycop";
  game["dialog"]["cop_bombplanted_atfriendly"] = "bombplanted_atfriendlycop";
  game["dialog"]["cop_bombdefused"] = "compound_bombdefused";
  game["dialog"]["sitrep_0_mp_faridah"] = "sitrep_embspawn";
  game["dialog"]["sitrep_1_mp_faridah"] = "sitrep_schoolspawn";
  game["dialog"]["sitrep_2_mp_faridah"] = "sitrep_clockspawn";
  game["dialog"]["sitrep_3_mp_faridah"] = "sitrep_whspawn";
  game["dialog"]["sitrep_4_mp_faridah"] = "sitrep_comspawn";
  game["dialog"]["sitrep_0_mp_euphrates"] = "sitrep_comspawn";
  game["dialog"]["sitrep_1_mp_euphrates"] = "sitrep_busesspawn";
  game["dialog"]["sitrep_2_mp_euphrates"] = "sitrep_undspawn";
  game["dialog"]["sitrep_3_mp_euphrates"] = "sitrep_constspawn";
  game["dialog"]["sitrep_4_mp_euphrates"] = "sitrep_fobspawn";
  game["dialog"]["cop_order_attack"] = "order_attack";
  game["dialog"]["cop_order_fallback"] = "order_fallback";
  game["dialog"]["cop_killstreak_bradley"] = "killstreak_bradley";
  game["dialog"]["cop_enemy_bradley"] = "enemy_bradley";
  game["dialog"]["cop_hostage_located"] = "hostage_located";
  game["dialog"]["cop_hostage_extraction"] = "hostage_extraction";
  game["dialog"]["cop_breach_plant"] = "breach_plant";
  thread ongameended();
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_735778FFCB77229D", getmatchrulesdata("cmdData", "cmdRules"));
  setdynamicdvar("dvar_FD24789F16E89AD4", getmatchrulesdata("cmdData", "activationDelayCenter"));
  setdynamicdvar("dvar_95B89E8D583FC3F4", getmatchrulesdata("cmdData", "activationDelayHalf"));
  setdynamicdvar("dvar_0C6918FBABA545A8", getmatchrulesdata("cmdData", "activationDelayBase"));
  setdynamicdvar("dvar_C5CD0CCD8E5DCB79", getmatchrulesdata("cmdData", "captureDurationCenter"));
  setdynamicdvar("dvar_15912D8E8706D469", getmatchrulesdata("cmdData", "captureDurationHalf"));
  setdynamicdvar("dvar_70014A04D6BC8145", getmatchrulesdata("cmdData", "captureDurationBase"));
  setdynamicdvar("dvar_F25163981C3CC7A2", getmatchrulesdata("cmdData", "holdDurationCenter"));
  setdynamicdvar("dvar_1A413608E91A1BF2", getmatchrulesdata("cmdData", "holdDurationHalf"));
  setdynamicdvar("dvar_BF89FD9299156F12", getmatchrulesdata("cmdData", "holdDurationBase"));
  setdynamicdvar("dvar_ACBD6C796AA85052", getmatchrulesdata("cmdData", "juggSpawnBehavior"));
  setdynamicdvar("dvar_5460D7525025CD97", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("dvar_2B8BEA8D06E005C1", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("dvar_9FD736B486EFCB95", getmatchrulesdata("ctfData", "captureCondition"));
  setdynamicdvar("scr_dom_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("dom", 0);
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.cmdrules = scripts\mp\utility\dvars::dvarintvalue("cmdRules", 1, 1, 3);
  level.tieractivationdelay = [];
  level.tieractivationdelay[0] = scripts\mp\utility\dvars::dvarfloatvalue("activationDelayCenter", 15, 0, 60);
  level.tieractivationdelay[1] = scripts\mp\utility\dvars::dvarfloatvalue("activationDelayHalf", 15, 0, 60);
  level.tieractivationdelay[2] = scripts\mp\utility\dvars::dvarfloatvalue("activationDelayBase", 15, 0, 60);
  level.tiercapturetime = [];
  level.tiercapturetime[0] = scripts\mp\utility\dvars::dvarfloatvalue("captureDurationCenter", 10, 0, 60);
  level.tiercapturetime[1] = scripts\mp\utility\dvars::dvarfloatvalue("captureDurationHalf", 10, 0, 60);
  level.tiercapturetime[2] = scripts\mp\utility\dvars::dvarfloatvalue("captureDurationBase", 10, 0, 60);
  level.tierholdtime = [];
  level.tierholdtime[0] = scripts\mp\utility\dvars::dvarfloatvalue("holdDurationCenter", 30, 0, 60);
  level.tierholdtime[1] = scripts\mp\utility\dvars::dvarfloatvalue("holdDurationHalf", 30, 0, 60);
  level.tierholdtime[2] = scripts\mp\utility\dvars::dvarfloatvalue("holdDurationBase", 45, 0, 60);
  level.juggspawnbehavior = scripts\mp\utility\dvars::dvarintvalue("juggSpawnBehavior", 1, 0, 3);
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.hvtspawnpos = scripts\mp\utility\dvars::dvarintvalue("captureCondition", 1, 0, 2);
  level.overtime = scripts\mp\utility\dvars::dvarfloatvalue("overtimeLimit", 300, 0, 300);
  scripts\mp\utility\game::setovertimelimitdvar(level.overtime);
  level.persistentbombtimer = 0;
  level.persistentdomtimer = 1;

  if(istrue(level.persistentbombtimer))
    level.bombtimer = 60;
  else
    level.bombtimer = 30;

  if(level.cmdrules == 1) {
    level.planttime = 2;
    level.defusetime = 2;
  } else {
    level.planttime = level.tiercapturetime[2];
    level.defusetime = level.tiercapturetime[2];
    level.bombtimer = 3;
  }

  level.controltoprogress = 1;
  setDvar("cg_buttonHintNaturalDistance", 200.0);
  level.forcedobjectiveindex = getdvarint("dvar_1BEE917B434DDCA6", -1);

  if(level.forcedobjectiveindex != -1) {
    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_roundLimit"), 2);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_roundswitch"), 1);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
  }
}

ontimelimit() {
  if(level.cmdrules == 2) {
    if(level.cmddefendingteam != "neutral")
      cmd_endgame(level.cmddefendingteam, game["end_reason"]["outpost_defended"]);
    else
      level thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
  } else if(scripts\mp\utility\game::inovertime())
    level thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
  else
    level thread scripts\mp\gamelogic::endgame("overtime", game["end_reason"]["time_limit_reached"]);
}

seticonnames() {
  level.iconcapture = "icon_waypoint_capture";
  level.iconcontested = "icon_waypoint_contested";
  level.icondefend = "icon_waypoint_defend";
  level.icondefusing = "icon_waypoint_defusing";
  level.iconlosing = "icon_waypoint_losing";
  level.iconneutral = "icon_waypoint_neutral";
  level.iconplanting = "icon_waypoint_planting";
  level.icontaking = "icon_waypoint_taking";
  level.icontarget = "icon_waypoint_target";
}

onstartgametype() {
  setomnvar("ui_victory_condition_completed", 0);
  seticonnames();

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/DOM");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DOM");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DOM_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/DOM_HINT");
  }

  setclientnamemode("auto_change");
  initspecatatorcameras();
  thread loopspectatorlocations();
  setupobjectives();
  initspawns();
  setupdestructibledoors();

  if(level.mapname == "mp_faridah")
    init_mp_faridah();

  thread startgame();
  _id_641E4E9B12A99632::inittankspawns();
}

init_mp_faridah() {
  initschoolmgturret();
  thread initksbonuscrates();
  thread initpropaganda();
}

initpropaganda() {
  scripts\mp\flags::gameflagwait("prematch_done");
  spawnorigin = (435, 0, 625);
  spawnangles = (0, 0, 0);
  level.propagandaent = scripts\engine\utility::spawn_tag_origin(spawnorigin, spawnangles);
  level.propagandaent show();
  level.propagandaent playLoopSound("tmp_emt_mp_faridah_propaganda_lp");
}

initschoolmgturret() {
  spawnorigin = (260, -1415, 150);
  spawnangles = (0, 90, 0);
  org = scripts\engine\utility::spawn_tag_origin(spawnorigin, spawnangles);
  turret = spawnturret("misc_turret", org.origin, "tur_gun_faridah_mp", 0);
  turret.angles = org.angles;
  turret linkTo(org, "tag_origin", (0, 0, 16), (0, 0, 0));
  turret setModel("weapon_mg_bravo50_balcony");
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  objweapon = makeweapon("tur_gun_faridah_mp");
  turret.objweapon = objweapon;
  _id_861CB51E11728417 = turret gettagorigin("tag_turret_pitch");
  useobj = scripts\mp\gameobjects::createhintobject(_id_861CB51E11728417, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  useobj linkTo(turret, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  useobj thread turretthink(turret);
  turret.killcament = spawn("script_model", (255, -1425, 210));
}

turretthink(turret) {
  for(;;) {
    self waittill("trigger", player);
    self makeunusable();
    player.prevweapon = player getcurrentweapon();
    player.useweapon = "tur_gun_faridah_mp";
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(player.useweapon, undefined, undefined, 1);

    while(player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player.useweapon, 1) == 0)
      waitframe();

    player controlturreton(turret);
    thread endturretusewatch(player, turret);
    thread endturretonplayer(player);
    self waittill("end_turret_use");

    if(isDefined(player)) {
      player controlturretoff(turret);
      player switchtoweaponimmediate(player.prevweapon);
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.useweapon);
    }

    self makeusable();
  }
}

endturretusewatch(player, turret) {
  player endon("death_or_disconnect");

  while(player useButtonPressed())
    waitframe();

  for(;;) {
    if(player useButtonPressed()) {
      self notify("end_turret_use");
      break;
    }

    waitframe();
  }
}

endturretonplayer(player) {
  player waittill("death_or_disconnect");
  self notify("end_turret_use");
}

initksbonuscrates() {
  wait 2.0;
  pos = (1125, -1675, 100);
  givekscratetoteam("allies", pos, "cruise_predator");
  pos = (-1150, -575, 100);
  givekscratetoteam("allies", pos, "chopper_gunner");
}

initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "cop_2";
  _id_84286554864313CB = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(_id_48380029FBB1007A in _id_84286554864313CB) {
    _id_CA2C833762E5466C = _id_48380029FBB1007A.script_noteworthy;
    _id_84BD84DEB891A915 = scripts\engine\utility::getStructArray(_id_48380029FBB1007A.target, "targetname");

    foreach(_id_6A17713098332FE4 in _id_84BD84DEB891A915) {
      switch (_id_6A17713098332FE4.script_label) {
        case "to_allies_camera":
          setteammapposition(_id_CA2C833762E5466C, game["attackers"], _id_6A17713098332FE4);
          break;
        case "to_axis_camera":
          setteammapposition(_id_CA2C833762E5466C, game["defenders"], _id_6A17713098332FE4);
          break;
      }
    }
  }
}

setteammapposition(_id_CA2C833762E5466C, team, _id_20C18491AEB9A905) {
  if(!isDefined(level.spectatorcameras[_id_CA2C833762E5466C]))
    level.spectatorcameras[_id_CA2C833762E5466C] = [];

  level.spectatorcameras[_id_CA2C833762E5466C][team] = _id_20C18491AEB9A905;
}

loopspectatorlocations() {
  index = 0;

  for(;;) {
    if(getdvarint("dvar_4AC8D16CE8DD74FD", 0) == 1) {
      if(isalive(level.players[0]))
        level.players[0] suicide();

      _id_7940DCDE72827AF7 = getdvarint("dvar_885DEA990259DAFE", -1);

      if(_id_7940DCDE72827AF7 != -1)
        index = _id_7940DCDE72827AF7;

      updatespectatorcamera("cop_" + index);
      duration = getdvarfloat("dvar_7D3EA16C514F408D", 1.0);
      wait(duration);
      index++;

      if(index > 4)
        index = 0;

      if(getdvarint("dvar_4AC8D16CE8DD74FD", 0) == 0)
        level.players[0] notify("force_spawn");

      continue;
    }

    waitframe();
  }
}

setupdestructibledoors() {
  if(!isDefined(level.destructibles) || !isDefined(level.destructibles["destructible_door"])) {
    return;
  }
  foreach(door in level.destructibles["destructible_door"]) {
    owner = getdoorowner(door.ents[0].origin);
    door scripts\mp\destructible::assigninteractteam(scripts\mp\utility\teams::getenemyteams(owner));
  }
}

getdoorowner(position) {
  _id_114AB88507847C50 = undefined;
  _id_06B50C4622758CC3 = undefined;

  foreach(objective in level.objectives) {
    if(!isDefined(objective.defaultownerteam)) {
      continue;
    }
    dist = distance2dsquared(position, objective.curorigin);

    if(!isDefined(_id_114AB88507847C50) || dist < _id_06B50C4622758CC3) {
      _id_114AB88507847C50 = objective;
      _id_06B50C4622758CC3 = dist;
    }
  }

  return _id_114AB88507847C50.defaultownerteam;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_cmd_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_cmd_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_cmd_spawn_allies", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_cmd_spawn_axis", 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(objective in level.objectives) {
    objective.spawnpoints = [];
    objective.spawnpoints[game["attackers"]] = [];
    objective.spawnpoints[game["defenders"]] = [];
  }

  foreach(spawnpoint in level.spawnpoints) {
    if(isDefined(spawnpoint.script_noteworthy)) {
      index = spawnpoint.script_noteworthy;

      if(spawnpoint.classname == "mp_cmd_spawn_allies")
        level.objectives[index].spawnpoints[game["attackers"]][level.objectives[index].spawnpoints[game["attackers"]].size] = spawnpoint;
      else if(spawnpoint.classname == "mp_cmd_spawn_axis")
        level.objectives[index].spawnpoints[game["defenders"]][level.objectives[index].spawnpoints[game["defenders"]].size] = spawnpoint;
    }
  }

  foreach(objindex, objective in level.objectives) {
    objective.spawnsets = [];
    objective.spawnsets[game["attackers"]] = "objSpawn_allies_" + objindex;
    scripts\mp\spawnlogic::registerspawnset(objective.spawnsets[game["attackers"]], objective.spawnpoints[game["attackers"]]);
    objective.spawnsets[game["defenders"]] = "objSpawn_axis_" + objindex;
    scripts\mp\spawnlogic::registerspawnset(objective.spawnsets[game["defenders"]], objective.spawnpoints[game["defenders"]]);
  }
}

getspawnpoint() {
  spawnteam = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(game["switchedsides"])
      spawnteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];

    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_cmd_spawn_" + spawnteam + "_start");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    self.startspawnpoint = spawnpoint;
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.currentobjective.spawnsets[spawnteam]);

  return spawnpoint;
}

setupobjectives() {
  level.currentobjective = undefined;
  level.objectives = [];
  setupbombzones();
  setupflags();
  setupareabrushes();
  setupteamoobtriggers();
  validateobjectives();
  thread ui_updatecmdprogress();
  thread disableobjectiveongameended();
  thread setupcaptureflares();
}

setupbombzones() {
  triggers = getEntArray("cop_bombzone", "targetname");

  if(triggers.size == 0) {
    return;
  }
  level._effect["bomb_explosion"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["faridah_bomb_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion_large_2.vfx");
  level.ddbombmodel = [];
  level.multibomb = 1;
  level.bombsplanted = 0;
  level.bombexploded = 0;
  level.bombplanted = 0;
  level.aplanted = 0;
  level.bplanted = 0;

  foreach(trigger in triggers) {
    objectiveindex = trigger.script_noteworthy;

    if(objectiveindex == "5")
      objectiveindex = "_b";
    else
      objectiveindex = "_a";

    trigger.objectivekey = objectiveindex;
    trigger mapobjectiveicon();
    _id_EEF26A325310D3AF = _id_0780CA0FF5944FCE::setupobjective(trigger);
    _id_EEF26A325310D3AF bombzone_ondisableobjective();
    _id_EEF26A325310D3AF scripts\mp\gameobjects::releaseid();
    level.objectives[_id_EEF26A325310D3AF.objectivekey] = _id_EEF26A325310D3AF;
    _id_EEF26A325310D3AF.onbeginuse = ::bombzone_onbeginuse;
    _id_EEF26A325310D3AF.onenduse = ::bombzone_onenduse;
    _id_EEF26A325310D3AF.onuse = ::bombzone_onuseplantobject;
    _id_EEF26A325310D3AF.ondisableobjective = ::bombzone_ondisableobjective;
    _id_EEF26A325310D3AF.onenableobjective = ::bombzone_onenableobjective;
    _id_EEF26A325310D3AF.onactivateobjective = ::bombzone_onactivateobjective;

    if(objectiveindex == "_a") {
      _id_EEF26A325310D3AF scripts\mp\gameobjects::setownerteam(game["attackers"]);
      continue;
    }

    _id_EEF26A325310D3AF scripts\mp\gameobjects::setownerteam(game["defenders"]);
  }
}

setupflags() {
  primaryflags = getEntArray("cop_flag", "targetname");
  _id_A9232BFE0BB02C00 = getEntArray("cop_flag_override", "targetname");

  if(primaryflags.size == 0) {
    return;
  }
  triggers = [];

  for(index = 0; index < primaryflags.size; index++)
    triggers[triggers.size] = primaryflags[index];

  _id_1DC2B3DBB108241C = [];

  if(_id_A9232BFE0BB02C00.size > 0) {
    foreach(trigger in _id_A9232BFE0BB02C00) {
      objectiveindex = trigger.script_noteworthy;
      _id_1DC2B3DBB108241C[objectiveindex] = trigger;
    }
  }

  foreach(trigger in triggers) {
    objectiveindex = trigger.script_noteworthy;

    if(isDefined(_id_1DC2B3DBB108241C[objectiveindex]))
      trigger = _id_1DC2B3DBB108241C[objectiveindex];

    trigger.objectivekey = objectiveindex;
    trigger mapobjectiveicon(objectiveindex);
    domflag = _id_6663215F917210AE::setupobjective(trigger);
    domflag.flagmodel delete();
    domflag.flagmodel = undefined;
    domflag.outlineent = undefined;
    domflag dompoint_ondisableobjective();
    level.objectives[domflag.objectivekey] = domflag;
    domflag.onbeginuse = ::dompoint_onbeginuse;
    domflag.onuse = ::dompoint_onuse;
    domflag.onenduse = ::dompoint_onenduse;
    domflag.oncontested = ::dompoint_oncontested;
    domflag.onuncontested = ::dompoint_onuncontested;
    domflag.ondisableobjective = ::dompoint_ondisableobjective;
    domflag.onenableobjective = ::dompoint_onenableobjective;
    domflag.onactivateobjective = ::dompoint_onactivateobjective;
    domflag thread _id_6663215F917210AE::updateflagstate("off", 0);
  }
}

disabledomflagscriptable() {
  thread _id_6663215F917210AE::updateflagstate("off", 0);
}

setupareabrushes() {
  _id_3AFEA31199696620 = getEntArray("cop_zone_visual", "targetname");
  _id_C4E3DB398AA8C45A = getEntArray("cop_zone_visual_contest", "targetname");
  _id_7319DB7C192615C2 = getEntArray("cop_zone_visual_friend", "targetname");
  _id_A318ECA969071E51 = getEntArray("cop_zone_visual_enemy", "targetname");
  _id_6591CECB9458082D = getEntArray("cop_zone_visual_friend_pulse", "targetname");
  _id_651B51771BBBE69C = getEntArray("cop_zone_visual_enemy_pulse", "targetname");

  foreach(objective in level.objectives) {
    if(isDefined(objective.scriptable)) {
      objective.scriptable delete();
      objective.scriptable = undefined;
    }
  }

  if(isDefined(_id_3AFEA31199696620)) {
    foreach(brush in _id_3AFEA31199696620) {
      _id_378BA18D7497D6D9 = brush.script_noteworthy;

      if(!isDefined(level.objectives[_id_378BA18D7497D6D9].neutralbrush))
        level.objectives[_id_378BA18D7497D6D9].neutralbrush = [];

      level.objectives[_id_378BA18D7497D6D9].neutralbrush[level.objectives[_id_378BA18D7497D6D9].neutralbrush.size] = brush;
      brush hide();
    }

    foreach(brush in _id_C4E3DB398AA8C45A) {
      _id_378BA18D7497D6D9 = brush.script_noteworthy;

      if(!isDefined(level.objectives[_id_378BA18D7497D6D9].contestedbrush))
        level.objectives[_id_378BA18D7497D6D9].contestedbrush = [];

      level.objectives[_id_378BA18D7497D6D9].contestedbrush[level.objectives[_id_378BA18D7497D6D9].contestedbrush.size] = brush;
      brush hide();
    }

    foreach(brush in _id_7319DB7C192615C2) {
      _id_378BA18D7497D6D9 = brush.script_noteworthy;

      if(!isDefined(level.objectives[_id_378BA18D7497D6D9].friendlybrush))
        level.objectives[_id_378BA18D7497D6D9].friendlybrush = [];

      level.objectives[_id_378BA18D7497D6D9].friendlybrush[level.objectives[_id_378BA18D7497D6D9].friendlybrush.size] = brush;
      brush hide();
    }

    foreach(brush in _id_A318ECA969071E51) {
      _id_378BA18D7497D6D9 = brush.script_noteworthy;

      if(!isDefined(level.objectives[_id_378BA18D7497D6D9].enemybrush))
        level.objectives[_id_378BA18D7497D6D9].enemybrush = [];

      level.objectives[_id_378BA18D7497D6D9].enemybrush[level.objectives[_id_378BA18D7497D6D9].enemybrush.size] = brush;
      brush hide();
    }

    foreach(brush in _id_6591CECB9458082D) {
      _id_378BA18D7497D6D9 = brush.script_noteworthy;

      if(!isDefined(level.objectives[_id_378BA18D7497D6D9].friendlypulsebrush))
        level.objectives[_id_378BA18D7497D6D9].friendlypulsebrush = [];

      level.objectives[_id_378BA18D7497D6D9].friendlypulsebrush[level.objectives[_id_378BA18D7497D6D9].friendlypulsebrush.size] = brush;
      brush hide();
    }

    foreach(brush in _id_651B51771BBBE69C) {
      _id_378BA18D7497D6D9 = brush.script_noteworthy;

      if(!isDefined(level.objectives[_id_378BA18D7497D6D9].enemypulsebrush))
        level.objectives[_id_378BA18D7497D6D9].enemypulsebrush = [];

      level.objectives[_id_378BA18D7497D6D9].enemypulsebrush[level.objectives[_id_378BA18D7497D6D9].enemypulsebrush.size] = brush;
      brush hide();
    }
  }
}

setupteamoobtriggers() {
  oobtriggers = getEntArray("cop_outofbounds", "targetname");

  if(!isDefined(oobtriggers)) {
    return;
  }
  foreach(trigger in oobtriggers) {
    _id_378BA18D7497D6D9 = trigger.script_noteworthy;

    if(!isDefined(level.objectives[_id_378BA18D7497D6D9].oobtriggers))
      level.objectives[_id_378BA18D7497D6D9].oobtriggers = [];

    if(isDefined(trigger.target)) {
      _id_C236336A4B27E7DA = getscriptablearray(trigger.target, "targetname");
      visuals = [];

      foreach(visual in _id_C236336A4B27E7DA) {
        index = visuals.size;
        visuals[index] = visual;

        if(isDefined(visual.script_noteworthy)) {
          visuals[index].drawcount = int(visual.script_noteworthy);
          continue;
        }

        visuals[index].drawcount = 1;
      }

      trigger.visuals = visuals;
      trigger thread updateoobvisuals("off");
    }

    level.objectives[_id_378BA18D7497D6D9].oobtriggers[trigger.script_label] = trigger;
  }
}

validateobjectives() {
  if(level.objectives.size == 0) {} else if((level.objectives.size - 2) % 2 == 0) {}

  level.midpointobjectiveindex = int(floor((level.objectives.size - 2) / 2));
  level.currentobjectiveindex = level.midpointobjectiveindex;
  level.previousobjectiveindex = level.currentobjectiveindex;

  foreach(objective in level.objectives) {
    if(level.cmdrules == 1) {
      if(objective.objectivekey == "_a" || objective.objectivekey == "_b")
        continue;
    }

    index = int(objective.objectivekey);
    tierindex = int(clamp(floor(abs(index - 2)), 0, 2));
    objective.tierindex = tierindex;
    objective.activationdelay = level.tieractivationdelay[tierindex];
    objective.captureduration = level.tiercapturetime[tierindex];
    objective.holdtime = level.tierholdtime[tierindex];
    objective scripts\mp\gameobjects::disableobject();
    objective.firsttime = 1;

    if(level.cmdrules == 1) {
      switch (tierindex) {
        case 1:
        case 0:
          objective scripts\mp\gameobjects::setcapturebehavior("persistent");
          objective.ignorestomp = 1;
          break;
        case 2:
          if(index < level.midpointobjectiveindex)
            objective.defaultownerteam = game["defenders"];
          else
            objective.defaultownerteam = game["attackers"];

          break;
      }

      continue;
    }

    objective.firsttime = 1;
    objective scripts\mp\gameobjects::setcapturebehavior("normal");

    if(index == level.midpointobjectiveindex) {
      continue;
    }
    if(index < level.midpointobjectiveindex) {
      objective.defaultownerteam = game["defenders"];
      continue;
    }

    objective.defaultownerteam = game["attackers"];
  }
}

startgame() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  updateteamscores();
  setomnvar("ui_objective_timer_stopped", 0);

  if(level.cmdrules == 2)
    level scripts\mp\gamelogic::pausetimer();

  updatecurrentobjective(level.currentobjectiveindex);
}

updatecurrentobjective(_id_DC6CBFDA5CAFD043) {
  if(level.forcedobjectiveindex != -1)
    _id_DC6CBFDA5CAFD043 = level.forcedobjectiveindex;

  if(!isDefined(level.objectives[scripts\engine\utility::string(_id_DC6CBFDA5CAFD043)])) {
    return;
  }
  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective))
    level.currentobjective[[level.currentobjective.ondisableobjective]]();

  level.previousobjectiveindex = level.currentobjectiveindex;
  level.currentobjectiveindex = _id_DC6CBFDA5CAFD043;
  updatespectatorcamera("cop_" + level.currentobjectiveindex);
  level.currentobjective = level.objectives[scripts\engine\utility::string(_id_DC6CBFDA5CAFD043)];
  setomnvar("ui_cmd_current_obj", _id_DC6CBFDA5CAFD043);
  updateoobtriggers();

  if(isDefined(level.currentobjective.onenableobjective))
    level.currentobjective[[level.currentobjective.onenableobjective]]();

  thread ui_updatecmdholdprogress();
  updateteamscores();

  if(level.currentobjective.activationdelay > 0) {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex)
      level scripts\mp\gamelogic::pausetimer();

    level.activationdelaystarttime = gettime();
    activationdelay = level.currentobjective.activationdelay;
    ui_updatezonetimer(activationdelay);
    ui_updatezonetimerpausedness(0);
    ui_updatecmdownerteam("zone_activation_delay");
    ui_updatecmdcapturestatus("zone_activation_delay", 0);
    wait 3.0;
    scripts\mp\hud_util::showsplashtoteam("all", "cop_target");
    scripts\mp\utility\dialog::statusdialog(getvoforobjective("allies", "next"), "allies", 1);
    scripts\mp\utility\dialog::statusdialog(getvoforobjective("axis", "next"), "axis", 1);
    level.currentobjective.firsttime = 0;
    currenttime = gettime();

    foreach(player in level.players)
    player.lastsitreptime = currenttime;

    wait(activationdelay - 3.0);
    level.activationdelaystarttime = undefined;
  }

  if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex)
    level scripts\mp\gamelogic::resumetimer();

  if(isDefined(level.currentobjective.onactivateobjective))
    level.currentobjective[[level.currentobjective.onactivateobjective]]();

  scripts\mp\hud_util::showsplashtoteam("all", "cop_activate");
  spawndelay = 0;

  switch (level.currentobjective.tierindex) {
    case 0:
      spawndelay = 0;
      break;
    case 1:
      spawndelay = 5;
      break;
    case 2:
      spawndelay = 10;
      break;
  }

  scripts\mp\gamelogic::updatewavespawndelay(spawndelay);
  scripts\mp\utility\dialog::statusdialog("cop_target_active", "allies", 0);
  scripts\mp\utility\dialog::statusdialog("cop_target_active", "axis", 0);
}

getfirsttimevoforobjective(team) {
  dialog = "cop_obj_" + level.currentobjectiveindex + "_" + level.mapname;
  return dialog;
}

getvoforobjective(team, type) {
  dialog = "";
  _id_3164B69C41644155 = 0;
  _id_F575332E106D8432 = team == "allies" && level.previousobjectiveindex > level.currentobjectiveindex || team == "axis" && level.previousobjectiveindex < level.currentobjectiveindex;

  if(type == "next" && level.currentobjective.firsttime)
    dialog = getfirsttimevoforobjective(team);
  else {
    switch (level.currentobjectiveindex) {
      case 4:
      case 0:
        _id_3164B69C41644155 = 0;

        switch (type) {
          case "next":
            dialog = "cop_obj_" + level.currentobjectiveindex + scripts\engine\utility::ter_op(_id_F575332E106D8432, "_attack_", "_defend_") + level.mapname;
            break;
          case "bomb_planted":
            if(level.currentobjectiveindex == 0)
              dialog = "cop_bombplanted" + scripts\engine\utility::ter_op(team == "allies", "_atenemy", "_atfriendly");
            else
              dialog = "cop_bombplanted" + scripts\engine\utility::ter_op(team == "axis", "_atenemy", "_atfriendly");

            break;
          case "bomb_defused":
            _id_3164B69C41644155 = 1;
            break;
        }

        break;
      case 3:
      case 2:
      case 1:
        switch (type) {
          case "next":
            dialog = "cop_obj_" + level.currentobjectiveindex + scripts\engine\utility::ter_op(_id_F575332E106D8432, "_attack_", "_defend_") + level.mapname;
            break;
          case "hold_confirmed":
          case "enemy_sec":
          case "hold":
            _id_3164B69C41644155 = 1;
            break;
        }

        break;
    }

    if(dialog == "") {
      if(_id_3164B69C41644155)
        dialog = "cop_" + type;
      else
        dialog = "cop_obj_" + level.currentobjectiveindex + "_" + type + "_" + level.mapname;
    }
  }

  return dialog;
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  if(isDefined(objweapon) && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename)) {
    return;
  }
  switch (level.currentobjective.id) {
    case "domFlag":
      _id_6663215F917210AE::awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);
      break;
    case "bomb_zone":
      _id_0780CA0FF5944FCE::bombzone_awardgenericbombzonemedals(attacker, self);
      break;
  }
}

onplayerconnect(player) {
  foreach(objective in level.objectives) {
    if(isDefined(objective.neutralbrush))
      objective hidebrushes(player);
  }

  player thread updatefloorbrushwaitforjoined();
}

decayholdtime(team) {
  self endon("domPoint_HoldTimer");

  for(;;) {
    if(isDefined(team)) {
      self.teamholdtimers[team] = self.teamholdtimers[team] - level.framedurationseconds;

      if(self.teamholdtimers[team] <= 0.0) {
        self.teamholdtimers[team] = 0.0;
        break;
      }
    }

    waitframe();
  }
}

dompoint_holdtimer(team, _id_22282E7D48CA3400) {
  level endon("gameEnded");
  self notify("domPoint_HoldTimer");
  self endon("domPoint_HoldTimer");
  level.inobjectiveot = 0;
  ui_updatecmdownerteam(team);

  if(istrue(level.persistentdomtimer)) {
    holdtime = self.teamholdtimers[team];
    self.holdteam = team;
  } else
    holdtime = level.currentobjective.holdtime;

  otherteam = scripts\mp\utility\game::getotherteam(team)[0];

  if(holdtime > 0) {
    thread decayholdtime(team);
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(otherteam, "enemy_hold"), otherteam, 1);
    _id_5C8DF3B9E5303FF8 = 0;

    if(level.currentobjectiveindex != 2 && holdtime > 5.0) {
      closestplayer = getclosestplayeronteam(level.currentobjective.trigger.origin, team);

      if(isDefined(closestplayer))
        _id_5C8DF3B9E5303FF8 = _id_5C8DF3B9E5303FF8 + closestplayer getselfobjcaptureddialog("captured");
    }

    if(_id_5C8DF3B9E5303FF8 > 0)
      wait(_id_5C8DF3B9E5303FF8);

    _id_1DEA067D4174D3CB = 0;
    closestplayer = getclosestplayeronteam(level.currentobjective.trigger.origin, team);

    if(isDefined(closestplayer) && holdtime > 5.0 + _id_5C8DF3B9E5303FF8)
      _id_1DEA067D4174D3CB = 0;

    _id_5C8DF3B9E5303FF8 = _id_5C8DF3B9E5303FF8 + _id_1DEA067D4174D3CB;
    wait(_id_1DEA067D4174D3CB);

    if(holdtime > 5.0 + _id_5C8DF3B9E5303FF8)
      scripts\mp\utility\dialog::statusdialog(getvoforobjective(team, "hold"), team, 1);

    if(holdtime - _id_5C8DF3B9E5303FF8 > 0)
      wait(holdtime - _id_5C8DF3B9E5303FF8);
    else
      wait(holdtime);

    otherteam = scripts\mp\utility\game::getotherteam(team)[0];

    if(istrue(level.controltoprogress) && level.currentobjective.touchlist[otherteam].size > 0) {
      level.inobjectiveot = 1;
      ui_updatecmdcapturestatus("overtime", level.currentobjective.stalemate);

      for(;;) {
        if(level.currentobjective.touchlist[otherteam].size == 0) {
          break;
        }

        waitframe();
      }

      level.inobjectiveot = 0;
    }
  }

  _id_A7F928303DA7CDD2 = 0;
  _id_DC6CBFDA5CAFD043 = level.currentobjectiveindex;

  if(team == game["attackers"]) {
    _id_DC6CBFDA5CAFD043--;

    if(level.currentobjectiveindex <= level.midpointobjectiveindex) {
      _id_A7F928303DA7CDD2 = 1;

      if(level.currentobjective.tierindex == 1) {
        spawnjuggcate(team, "attacker");
        spawnjuggcate(scripts\mp\utility\game::getotherteam(team)[0], "defender");
      } else if(level.currentobjective.tierindex == 0) {
        if(isDefined(level.propagandaent))
          level.propagandaent stoploopsound();
      }
    }
  } else {
    _id_DC6CBFDA5CAFD043++;

    if(level.currentobjectiveindex >= level.midpointobjectiveindex) {
      _id_A7F928303DA7CDD2 = 1;

      if(level.currentobjective.tierindex == 1) {
        spawnjuggcate(team, "attacker");
        spawnjuggcate(scripts\mp\utility\game::getotherteam(team)[0], "defender");
      } else if(level.currentobjective.tierindex == 0) {
        if(isDefined(level.propagandaent))
          level.propagandaent playLoopSound("tmp_emt_mp_faridah_propaganda_lp");
      }
    }
  }

  if(0 && _id_A7F928303DA7CDD2)
    scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 0);

  if(self.tierindex == 0) {
    if(isDefined(_id_22282E7D48CA3400))
      _id_22282E7D48CA3400 thread givekillstreak("uav", 1);
    else {
      closestplayer = getclosestplayeronteam(level.currentobjective.trigger.origin, team);
      closestplayer thread givekillstreak("uav", 1);
    }
  }

  updateteamscores();

  if(holdtime > 0)
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(team, "hold_confirmed"), team, 1);

  scripts\mp\hud_util::showsplashtoteam(team, "cop_captured_friendly");
  scripts\mp\hud_util::showsplashtoteam(otherteam, "cop_captured_enemy");

  if(level.forcedobjectiveindex != -1) {
    scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 0);
    cmd_endgame(team, game["end_reason"]["target_destroyed"]);
  } else if(scripts\mp\utility\game::inovertime())
    scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 0);
  else {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
      level.extratime = level.extratime + 90;
      _id_8DD9F2EB8215A139 = scripts\mp\gamelogic::gettimeremaining();
      setgameendtime(gettime() + int(_id_8DD9F2EB8215A139));
      level scripts\mp\gamelogic::resumetimer();
    }

    updatecurrentobjective(_id_DC6CBFDA5CAFD043);
  }
}

dompoint_cancelholdtimer() {
  if(!istrue(level.persistentdomtimer)) {
    return;
  }
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(isDefined(self.holdteam) && self.holdteam == ownerteam) {
    ui_updatezonetimerpausedness(1);
    self notify("domPoint_HoldTimer");
    self.holdteam = undefined;
  }
}

givekscratetoteam(team, pos, streakname) {}

createkscrate(team, pos, streakname) {}

cratethink(team, streakname) {
  self endon("restarting_physics");
  self endon("death");
  pos = scripts\engine\utility::drop_to_ground(self.origin + (7, 9, 0), 50, -200, (0, 0, 1));
  _id_4E0D9C78FA04CDD4 = spawn("script_model", pos + (0, 0, 0));
  _id_4E0D9C78FA04CDD4 setModel("offhand_wm_grenade_smoke");
  _id_4E0D9C78FA04CDD4.angles = self.angles + (-80, 120, 90);
  vfxent = spawn("script_model", _id_4E0D9C78FA04CDD4.origin);
  vfxent setModel("tag_origin");
  vfxent.angles = self.angles + (0, 30, 0);
  vfxent playLoopSound("mp_flare_burn_lp");
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], vfxent, "tag_origin");
  hintstring = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  _id_EFE526BF6A23D275 = undefined;

  switch (streakname) {
    case "juggernaut":
      hintstring = &"KILLSTREAKS_HINTS/JUGGERNAUT_PICKUP_GL";
      _id_EFE526BF6A23D275 = "icon_ks_jugg";
      break;
    case "cruise_predator":
      hintstring = &"KILLSTREAKS_HINTS/CRUISE_PREDATOR_PICKUP_GL";
      _id_EFE526BF6A23D275 = "hud_icon_killstreak_cruise_missile";
      break;
    case "chopper_gunner":
      hintstring = &"KILLSTREAKS_HINTS/CHOPPER_GUNNER_PICKUP_GL";
      _id_EFE526BF6A23D275 = "hud_icon_killstreak_apache";
      break;
  }

  self.useobj = scripts\mp\gameobjects::createhintobject(self.origin + anglestoup(self.angles) * 24, "HINT_BUTTON", _id_EFE526BF6A23D275, hintstring, -1, undefined, "show", 250, 360, 100, 360);
  self.useobj linkTo(self);

  if(streakname == "juggernaut") {
    thread gainedjuggupdater(team);
    thread removedjuggupdater(team);
  }

  for(;;) {
    self waittill("captured", player);

    if(isPlayer(player)) {
      player setclientomnvar("ui_securing", 0);
      player.ui_securing = undefined;
    }

    switch (streakname) {
      case "juggernaut":
        if(!player thread givejuggernaut()) {
          continue;
        }
        break;
      case "cruise_predator":
        player thread givekillstreak("cruise_predator", 1);
        wait 3.0;
        break;
      case "chopper_gunner":
        player thread givekillstreak("chopper_gunner", 1);
        wait 3.0;
        break;
    }

    player playlocalsound("ammo_crate_use", undefined, undefined, 1);
    stopFXOnTag(level._effect["vfx_smk_signal"], vfxent, "tag_origin");
    vfxent stoploopsound();
    vfxent delete();
    vfxent = undefined;
    _id_4E0D9C78FA04CDD4 delete();
    _id_4E0D9C78FA04CDD4 = undefined;
    scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

gainedjuggupdater(team) {
  self endon("death");

  foreach(player in level.players) {
    if(player.team == team && istrue(player.isjuggernaut))
      self disableplayeruse(player);
  }

  for(;;) {
    level waittill("gained_juggernaut", player);

    if(player.team == team)
      self disableplayeruse(player);
  }
}

removedjuggupdater(team) {
  self endon("death");

  for(;;) {
    level waittill("removed_juggernaut", player);

    if(player.team == team)
      self enableplayeruse(player);
  }
}

givekillstreak(streakname, _id_44632FF01DF0AADD) {
  _id_16EFCF27E6EFCBE8 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(streakname);
  scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(_id_16EFCF27E6EFCBE8, "other");

  if(istrue(_id_44632FF01DF0AADD)) {
    wait 0.1;
    self notify("ks_action_4");
  }
}

bombzone_warningklaxon() {
  level endon("game_ended");
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  _id_EA070AB75FE8C094 = game["music"]["cop_finalpush"].size;
  _id_88E74978A3823F5F = randomint(_id_EA070AB75FE8C094);

  foreach(player in level.players)
  player setplayermusicstate(game["music"]["cop_finalpush"][_id_88E74978A3823F5F]);

  wait 2.0;
  wait 16.0;
}

bombzone_holdtimer(endtime) {
  if(!isDefined(level.currentobjective)) {
    return;
  }
  level endon("gameEnded");
  level endon("bomb_planted");
  self notify("bombZone_HoldTimer");
  self endon("bombZone_HoldTimer");
  ownerteam = level.currentobjective.defaultownerteam;
  otherteam = scripts\mp\utility\game::getotherteam(level.currentobjective.defaultownerteam)[0];
  scripts\mp\objidpoolmanager::objective_show_team_progress(level.currentobjective.objidnum, otherteam);
  level.timelimitoverride = 0;

  if(endtime > 0) {
    ui_updatezonetimer(endtime);
    wait(endtime);

    if(istrue(level.controltoprogress)) {
      otherteam = scripts\mp\utility\game::getotherteam(level.currentobjective.defaultownerteam)[0];
      _id_652AA048043C4946 = 0;

      for(;;) {
        if(!_id_652AA048043C4946) {
          _id_652AA048043C4946 = 1;
          ui_updatecmdcapturestatus("overtime", level.currentobjective.stalemate);
        }

        if(level.currentobjective.touchlist[otherteam].size == 0) {
          break;
        }

        waitframe();
      }
    }
  }

  foreach(player in level.players)
  player setplayermusicstate("mus_mp_cop_bombplant_end");

  thread scripts\mp\music_and_dialog::suspensemusic();
  _id_DC6CBFDA5CAFD043 = level.currentobjectiveindex;
  team = level.currentobjective scripts\mp\gameobjects::getownerteam();

  if(team == game["attackers"])
    _id_DC6CBFDA5CAFD043--;
  else
    _id_DC6CBFDA5CAFD043++;

  updatecurrentobjective(_id_DC6CBFDA5CAFD043);
}

bombhandler(player, _id_68B7E26F25CA1151, playerteam) {
  if(level.gameended) {
    return;
  }
  if(_id_68B7E26F25CA1151 == "explode") {
    self.bombexploded = 1;
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
    scripts\mp\gamescore::giveteamscoreforobjective(playerteam, 1, 0);
    cmd_endgame(playerteam, game["end_reason"]["target_destroyed"]);
  } else {}
}

resetbombzone() {
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setvisibleteam("none");
  self.id = "bomb_zone";
  self.useweapon = makeweapon("briefcase_bomb_mp");
  self.bombexploded = undefined;
}

cmd_endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9) {
  level.docmdoutro = 1;
  _id_1F1C8D335BF8F19F = undefined;

  if(level.mapname == "mp_faridah") {
    _id_1F1C8D335BF8F19F = spawnStruct();

    if(_id_EC15CE3E7A9D1D86 == "allies") {
      _id_1F1C8D335BF8F19F.origin = (-207, -4711, 211);
      _id_1F1C8D335BF8F19F.angles = (7, 64, 0);
    } else if(_id_EC15CE3E7A9D1D86 == "axis") {
      _id_1F1C8D335BF8F19F.origin = (1945, 4423, 670);
      _id_1F1C8D335BF8F19F.angles = (15, 244, 0);
    } else {}
  }

  foreach(player in level.players) {
    if(!isai(player))
      player setclientomnvar("ui_objective_pinned_text_param", 0);

    player thread playendofmatchtransition(_id_1F1C8D335BF8F19F);
  }

  _id_FFC68F01A119EBE8 = game["teamScores"][_id_EC15CE3E7A9D1D86];
  _id_32F7F463542E9AB0 = game["teamScores"][scripts\mp\utility\game::getotherteam(_id_EC15CE3E7A9D1D86)[0]];

  if(_id_32F7F463542E9AB0 > _id_FFC68F01A119EBE8) {
    _id_36F3228E1D630F1B = _id_32F7F463542E9AB0 - _id_FFC68F01A119EBE8 + 1;
    scripts\mp\gamescore::giveteamscoreforobjective(_id_EC15CE3E7A9D1D86, _id_36F3228E1D630F1B, 0);
  }

  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9);
  wait 0.65;
  level notify("allow_bomb_explosion");
  wait 5.0;
  level notify("cmd_continue_game_end");
}

dompoint_onbeginuse(player) {
  dompoint_cancelholdtimer();
  _id_6663215F917210AE::dompoint_onusebegin(player);
  self.didstatusnotify = 1;
  thread updateflares(player.team);
  ui_updatecmdcapturestatus(player.team, self.stalemate);

  if(player.team == game["attackers"]) {
    if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4) {
      _id_13050A26E9E3095A = scripts\mp\gameobjects::getownerteam();

      if(player.team != _id_13050A26E9E3095A)
        player getselfobjcaptureddialog("planting");
      else
        player getselfobjcaptureddialog("defusing");
    } else {}
  }

  otherteam = scripts\mp\utility\game::getotherteam(player.team)[0];

  if(otherteam == scripts\mp\gameobjects::getownerteam())
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(player.team, "enemy_cap"), otherteam, 0);
  else
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(player.team, "enemy_sec"), otherteam, 0);

  foreach(player in level.players)
  updatefloorbrush(player);
}

dompoint_onuse(_id_22282E7D48CA3400) {
  if(istrue(level.persistentdomtimer)) {
    ui_updatezonetimerpausedness(0);
    self.lastcaptime = gettime();
    self.firstcapture = 0;
  }

  _id_6663215F917210AE::dompoint_onuse(_id_22282E7D48CA3400);
  team = scripts\mp\gameobjects::getownerteam();
  thread updateflares(team);

  foreach(player in level.players)
  updatefloorbrush(player);

  level.usestartspawns = 0;
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", _id_22282E7D48CA3400);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      level.cmdattackingteam = team;
      level.cmddefendingteam = otherteam;
      level scripts\mp\gamelogic::pausetimer();
    } else {
      level.extratime = level.extratime + 90;
      _id_8DD9F2EB8215A139 = scripts\mp\gamelogic::gettimeremaining();
      setgameendtime(gettime() + int(_id_8DD9F2EB8215A139));
    }
  }

  if(level.currentobjectiveindex == 0) {
    _id_13050A26E9E3095A = level.objectives["_b"] scripts\mp\gameobjects::getownerteam();

    if(team != _id_13050A26E9E3095A)
      level.objectives["_b"] bombzone_onuseplantobject(_id_22282E7D48CA3400);
    else
      level.objectives["_b"] bombzone_onusedefuseobject(_id_22282E7D48CA3400);
  } else if(level.currentobjectiveindex == 4) {
    _id_13050A26E9E3095A = level.objectives["_a"] scripts\mp\gameobjects::getownerteam();

    if(team != _id_13050A26E9E3095A)
      level.objectives["_a"] bombzone_onuseplantobject(_id_22282E7D48CA3400);
    else
      level.objectives["_a"] bombzone_onusedefuseobject(_id_22282E7D48CA3400);
  } else {
    thread dompoint_holdtimer(team, _id_22282E7D48CA3400);
    scripts\mp\hud_util::showsplashtoteam(team, "cop_hold_friendly");
    scripts\mp\hud_util::showsplashtoteam(otherteam, "cop_hold_enemy");
  }

  if(self == level.currentobjective)
    ui_updatecmdcapturestatus("neutral", 0);
}

dompoint_onenduse(team, player, success) {
  if(self != level.currentobjective) {
    return;
  }
  _id_6663215F917210AE::dompoint_onuseend(team, player, success);
  ownerteam = scripts\mp\gameobjects::getownerteam();
  state = scripts\engine\utility::ter_op(ownerteam == "neutral", "idle", ownerteam);
  thread updateflares(state);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      ownerteam = scripts\mp\gameobjects::getownerteam();
      ui_updatecmdcapturestatus("neutral", 0);

      if(istrue(level.persistentdomtimer) && self.objectivekey != "0" && self.objectivekey != "4") {
        if(ownerteam != "neutral") {
          ui_updatezonetimerpausedness(0);
          self.lastcaptime = gettime();
          thread dompoint_holdtimer(ownerteam);
        }
      }
    }
  } else if(!success) {
    ownerteam = scripts\mp\gameobjects::getownerteam();
    ui_updatecmdcapturestatus("neutral", 0);

    if(istrue(level.persistentdomtimer) && self.objectivekey != "0" && self.objectivekey != "4") {
      if(ownerteam != "neutral") {
        ui_updatezonetimerpausedness(0);
        self.lastcaptime = gettime();
        thread dompoint_holdtimer(ownerteam);
      }
    }
  }

  foreach(player in level.players)
  updatefloorbrush(player);
}

dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }
  dompoint_cancelholdtimer();
  _id_6663215F917210AE::dompoint_oncontested();
  thread updateflares("contested");
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex)
      level scripts\mp\gamelogic::resumetimer();
  }

  ui_updatecmdcapturestatus(ownerteam, 1);
  notifyteam = ownerteam;

  if(ownerteam == "neutral")
    notifyteam = self.claimteam;

  if(notifyteam != "none")
    scripts\mp\utility\dialog::statusdialog("cop_obj_contested", notifyteam, 0);

  foreach(player in level.players)
  updatefloorbrush(player);
}

dompoint_onuncontested(lastclaimteam) {
  if(self != level.currentobjective) {
    return;
  }
  _id_6663215F917210AE::dompoint_onuncontested(lastclaimteam);
  self.didstatusnotify = 1;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex)
      level scripts\mp\gamelogic::resumetimer();
  }

  state = scripts\engine\utility::ter_op(ownerteam == "neutral", "idle", ownerteam);
  thread updateflares(state);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      if(ownerteam != "neutral" && self.touchlist[scripts\mp\utility\game::getotherteam(ownerteam)[0]].size == 0) {
        ui_updatezonetimerpausedness(0);
        self.lastcaptime = gettime();
        thread dompoint_holdtimer(ownerteam);
      }
    }
  } else if(istrue(level.persistentdomtimer) && level.currentobjectiveindex != 0 && level.currentobjectiveindex != 4) {
    if(ownerteam != "neutral" && self.touchlist[scripts\mp\utility\game::getotherteam(ownerteam)[0]].size == 0) {
      ui_updatezonetimerpausedness(0);
      self.lastcaptime = gettime();
      thread dompoint_holdtimer(ownerteam);
    }
  }

  ui_updatecmdcapturestatus("neutral", 0);

  foreach(player in level.players)
  updatefloorbrush(player);
}

dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  scripts\engine\utility::delaythread(0.1, ::disabledomflagscriptable);
  thread updateflares("off");

  foreach(player in level.players)
  updatefloorbrush(player, 1);
}

dompoint_onenableobjective() {
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, 1);
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);

  if(istrue(level.persistentdomtimer)) {
    if(!isDefined(self.teamholdtimers))
      self.teamholdtimers = [];

    self.teamholdtimers["allies"] = self.holdtime;
    self.teamholdtimers["axis"] = self.holdtime;
    self.firstcapture = 1;
    self.holdteam = undefined;
  }

  if(isDefined(self.defaultownerteam)) {
    scripts\mp\gameobjects::setownerteam(self.defaultownerteam);
    thread _id_6663215F917210AE::updateflagstate(self.defaultownerteam, 0);
    thread updateflares(self.defaultownerteam);
  } else {
    scripts\mp\gameobjects::setownerteam("neutral");
    thread _id_6663215F917210AE::updateflagstate("idle", 0);
    thread updateflares("idle");
  }

  if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4)
    thread bombzone_warningklaxon();

  if(getdvarint("scr_bradley_spawner", 0) != 0)
    _id_641E4E9B12A99632::tryspawnneutralbradleycmd(level.currentobjectiveindex);

  foreach(player in level.players)
  updatefloorbrush(player);
}

dompoint_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("mp_combat_outpost_activateobj");
  ownerteam = scripts\mp\gameobjects::getownerteam();
  ui_updatecmdownerteam(ownerteam);
  ui_updatecmdcapturestatus("neutral", 0);
  scripts\mp\gameobjects::allowuse("enemy");
  thread awardcapturepoints();
  level.flagcapturetime = self.captureduration;

  if(self.tierindex == 2) {
    if(level.cmdrules == 1)
      level.flagcapturetime = 5.0;

    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

  if(level.cmdrules == 1) {
    if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4)
      thread bombzone_holdtimer(self.holdtime);
  }
}

bombzone_onbeginuse(player) {
  _id_0780CA0FF5944FCE::bombzone_onbeginuse(player);
}

bombzone_onenduse(team, player, result) {
  _id_0780CA0FF5944FCE::bombzone_onenduse(team, player, result);
}

bombzone_onuseplantobject(_id_22282E7D48CA3400) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(ownerteam)[0];
  scripts\mp\objidpoolmanager::objective_show_team_progress(level.currentobjective.objidnum, ownerteam);
  scripts\mp\hud_util::showsplashtoteam("all", "cop_planted");
  level.flagcapturetime = 15.0;

  if(istrue(level.persistentbombtimer)) {
    if(!isDefined(level.basefusetimers)) {
      level.basefusetimers = [];
      level.basefusetimers["allies"] = level.bombtimer;
      level.basefusetimers["axis"] = level.bombtimer;
    }

    level.bombtimer = level.basefusetimers[ownerteam];
    level.lastbombplanttime = gettime();
  }

  _id_0780CA0FF5944FCE::bombzone_onuseplantobject(_id_22282E7D48CA3400);
  _id_6C7470A87C232EC5 = game["music"]["cop_bombplant"].size;
  _id_59DCF2637FAE66AE = randomint(_id_6C7470A87C232EC5);

  foreach(player in level.players)
  player setplayermusicstate(game["music"]["cop_bombplant"][_id_59DCF2637FAE66AE]);

  if(0)
    scripts\mp\gamescore::giveteamscoreforobjective(_id_22282E7D48CA3400.team, 1, 0);

  scripts\mp\utility\dialog::statusdialog(getvoforobjective(ownerteam, "bomb_planted"), ownerteam, 1);
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(otherteam, "bomb_planted"), otherteam, 1);

  if(isDefined(level.zoneendtime))
    level.zoneendtime = int(level.zoneendtime - gettime());

  if(level.cmdrules == 1)
    ui_updatebombtimer();

  ui_updatecmdownerteam(_id_22282E7D48CA3400.team);
}

bombzone_onusedefuseobject(player) {
  if(!level.bombplanted) {
    return;
  }
  scripts\mp\hud_util::showsplashtoteam("all", "cop_defused");
  ownerteam = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(ownerteam)[0];
  level.flagcapturetime = 5.0;

  if(istrue(level.persistentbombtimer))
    level.basefusetimers[ownerteam] = level.basefusetimers[ownerteam] - (gettime() - level.lastbombplanttime) / 1000;

  level.bombsplanted = level.bombsplanted - 1;

  if(self.objectivekey == "_a")
    level.aplanted = 0;
  else
    level.bplanted = 0;

  _id_0780CA0FF5944FCE::bombzone_onusedefuseobject(player);

  if(scripts\mp\utility\game::getotherteam(player.team)[0] == "allies") {}

  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(ownerteam, "bomb_defused"), ownerteam, 1);
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(otherteam, "bomb_defused"), otherteam, 1);
  player notify("bomb_defused" + self.objectivekey);
  self notify("defused");
  resetbombzone();

  if(isDefined(level.zoneendtime))
    thread bombzone_holdtimer(level.zoneendtime / 1000);

  ui_updatecmdownerteam(player.team);
}

bombzone_ondisableobjective() {
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::allowuse("none");
}

bombzone_onenableobjective() {
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
}

bombzone_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("mp_combat_outpost_activateobj");
  ui_updatecmdownerteam("neutral");
  ui_updatecmdcapturestatus("neutral", 0);
  level.planttime = self.captureduration;
  level.defusetime = self.captureduration;
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  scripts\mp\gameobjects::allowuse("enemy");
  thread bombzone_holdtimer(self.holdtime);
}

ui_updatezonetimer(_id_CC748B6D457627FE) {
  level.zoneendtime = int(gettime() + 1000 * _id_CC748B6D457627FE);
  setomnvar("ui_hardpoint_timer", level.zoneendtime);
}

ui_updatebombtimer() {
  _id_F28399727742EB23 = int(gettime() + 1000 * level.bombtimer);
  setomnvar("ui_hardpoint_timer", _id_F28399727742EB23);
}

ui_updatezonetimerpausedness(_id_EC45F849CE9A05CF) {
  setomnvar("ui_objective_timer_stopped", _id_EC45F849CE9A05CF);
}

getownerteamplayer(ownerteam) {
  _id_A3010F9814A40C8D = undefined;

  foreach(player in level.players) {
    if(player.team == ownerteam)
      return player;
  }

  return _id_A3010F9814A40C8D;
}

ui_updatecmdcapturestatus(status, contested) {
  _id_CABC886D846DD979 = -1;

  if(istrue(level.inobjectiveot)) {
    if(contested)
      _id_CABC886D846DD979 = -4;
    else
      _id_CABC886D846DD979 = -5;
  } else if(contested)
    _id_CABC886D846DD979 = -2;
  else {
    switch (status) {
      case "allies":
        _id_CABC886D846DD979 = 2;
        break;
      case "axis":
        _id_CABC886D846DD979 = 1;
        break;
      case "zone_activation_delay":
        _id_CABC886D846DD979 = -3;
        break;
      case "overtime":
        _id_CABC886D846DD979 = -4;
        break;
      case "zone_shift":
      default:
        break;
    }
  }

  setomnvar("ui_cmd_capture_team", _id_CABC886D846DD979);
}

ui_updatecmdownerteam(ownerteam) {
  _id_CABC886D846DD979 = -1;

  switch (ownerteam) {
    case "allies":
      _id_CABC886D846DD979 = 2;
      break;
    case "axis":
      _id_CABC886D846DD979 = 1;
      break;
    case "zone_activation_delay":
      _id_CABC886D846DD979 = -3;
      break;
    case "zone_shift":
    default:
      break;
  }

  setomnvar("ui_cmd_owner_team", _id_CABC886D846DD979);
}

ui_updatecmdprogress() {
  for(;;) {
    if(isDefined(level.currentobjective))
      setomnvar("ui_cmd_capture_progress", level.currentobjective scripts\mp\gameobjects::getcaptureprogress());
    else
      setomnvar("ui_cmd_capture_progress", 0);

    waitframe();
  }
}

ui_updatecmdholdprogress() {
  self notify("ui_updateCMDHoldProgress");
  self endon("ui_updateCMDHoldProgress");

  for(;;) {
    if(isDefined(level.currentobjective) && isDefined(level.currentobjective.teamholdtimers) && isDefined(level.currentobjective.holdtime) && level.currentobjective.holdtime > 0) {
      setomnvar("ui_cmd_owner_progress_allies", 1.0 - level.currentobjective.teamholdtimers["allies"] / level.currentobjective.holdtime);
      setomnvar("ui_cmd_owner_progress_axis", 1.0 - level.currentobjective.teamholdtimers["axis"] / level.currentobjective.holdtime);
    } else {
      setomnvar("ui_cmd_owner_progress_allies", 0);
      setomnvar("ui_cmd_owner_progress_axis", 0);
    }

    waitframe();
  }
}

getcurrentvalue() {
  if(!isDefined(level.currentobjective))
    return 0.5;

  _id_3BA14998C431FF5A = getcenterfrac(level.currentobjectiveindex);
  _id_D53F69B9843525D5 = 0.0;
  ownerteam = level.currentobjective scripts\mp\gameobjects::getownerteam();
  _id_F5576FB178AF593E = 0.0;
  _id_787C1CAFFFF51C2B = 0.03;
  _id_FE62E581AEF8117F = 0.0;

  if(isDefined(level.activationdelaystarttime) && level.previousobjectiveindex != level.currentobjectiveindex) {
    if(isDefined(level.currentobjective.defaultownerteam)) {
      _id_D53F69B9843525D5 = _id_787C1CAFFFF51C2B;

      if(ownerteam == "allies")
        _id_D53F69B9843525D5 = _id_D53F69B9843525D5 * -1.0;

      _id_787C1CAFFFF51C2B = _id_787C1CAFFFF51C2B * 2;
    }

    _id_F5576FB178AF593E = 1.0;
    currenttime = gettime();
    _id_5E8DBD8520D11362 = (currenttime - level.activationdelaystarttime) / (level.currentobjective.activationdelay * 1000);
    _id_FE62E581AEF8117F = (abs(getcenterfrac(level.previousobjectiveindex) - _id_3BA14998C431FF5A) - _id_787C1CAFFFF51C2B) * _id_5E8DBD8520D11362;

    if(level.currentobjectiveindex < level.previousobjectiveindex) {
      _id_FE62E581AEF8117F = _id_FE62E581AEF8117F * -1.0;
      _id_787C1CAFFFF51C2B = _id_787C1CAFFFF51C2B * -1.0;
    }

    _id_3BA14998C431FF5A = getcenterfrac(level.previousobjectiveindex);
  } else {
    ownerteam = level.currentobjective scripts\mp\gameobjects::getownerteam();

    if(ownerteam != "neutral") {
      _id_D53F69B9843525D5 = _id_787C1CAFFFF51C2B;

      if(ownerteam == "allies")
        _id_D53F69B9843525D5 = _id_D53F69B9843525D5 * -1.0;

      if(isDefined(level.currentobjective.claimteam) && level.currentobjective.claimteam != "none") {
        if(level.currentobjective.claimteam != ownerteam) {
          _id_787C1CAFFFF51C2B = _id_787C1CAFFFF51C2B * 2;
          _id_F5576FB178AF593E = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();

          if(level.currentobjective.claimteam == "allies")
            _id_F5576FB178AF593E = _id_F5576FB178AF593E * -1.0;
        }
      }
    } else {
      _id_F5576FB178AF593E = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();

      if(isDefined(level.currentobjective.claimteam) && level.currentobjective.claimteam != "none") {
        if(level.currentobjective.claimteam == "allies")
          _id_F5576FB178AF593E = _id_F5576FB178AF593E * -1.0;
      } else if(isDefined(level.currentobjective.lastclaimteam)) {
        if(level.currentobjective.lastclaimteam == "allies")
          _id_F5576FB178AF593E = _id_F5576FB178AF593E * -1.0;
      }
    }
  }

  return _id_3BA14998C431FF5A + _id_D53F69B9843525D5 + _id_F5576FB178AF593E * _id_787C1CAFFFF51C2B + _id_FE62E581AEF8117F;
}

getcenterfrac(index) {
  _id_3BA14998C431FF5A = 0.0;

  switch (index) {
    case 0:
      _id_3BA14998C431FF5A = 0.0;
      break;
    case 1:
      _id_3BA14998C431FF5A = 0.25;
      break;
    case 2:
      _id_3BA14998C431FF5A = 0.5;
      break;
    case 3:
      _id_3BA14998C431FF5A = 0.75;
      break;
    case 4:
      _id_3BA14998C431FF5A = 1.0;
      break;
  }

  return _id_3BA14998C431FF5A;
}

updateteamscores() {
  if(1) {
    scripts\mp\gamescore::_setteamscore("allies", 0, 0);
    scripts\mp\gamescore::_setteamscore("axis", 0, 0);
  }
}

spawnjuggcate(team, role) {
  _id_33A4ECC6B9F0FA5E = level.juggspawnbehavior;

  if(role == "attacker" && _id_33A4ECC6B9F0FA5E != 1 && _id_33A4ECC6B9F0FA5E != 3) {
    return;
  }
  if(role == "defender" && _id_33A4ECC6B9F0FA5E != 2 && _id_33A4ECC6B9F0FA5E != 3) {
    return;
  }
  if(!isDefined(level.juggcrates)) {
    level.juggcrates = [];
    level.juggcrates["allies"] = [];
    level.juggcrates["axis"] = [];
  }

  if(isDefined(level.juggcrates[team][role])) {
    return;
  }
  pos = undefined;

  switch (level.mapname) {
    case "mp_faridah":
      if(role == "attacker") {
        if(team == "allies")
          pos = (250, -2040, 215);
        else
          pos = (786, 2413, 260);
      } else if(role == "defender") {
        if(team == "allies")
          pos = (25, -4630, 10);
        else
          pos = (1480, 4375, -40);
      }

      break;
    case "mp_anvil":
      if(role == "attacker") {
        if(team == "allies")
          pos = (2775, 2375, 360);
        else
          pos = (-60, -260, 450);
      } else if(role == "defender") {
        if(team == "allies")
          pos = (-2680, -855, 250);
        else
          pos = (2365, 4360, 360);
      }

      break;
  }

  if(isDefined(pos)) {
    level.juggcrates[team][role] = givekscratetoteam(team, pos, "juggernaut");
    level.juggcrates[team][role] thread removeondeath(team, role);
  }
}

removeondeath(team, role) {
  level endon("game_ended");
  self waittill("death");
  level.juggcrates[team][role] = undefined;
}

givejuggernaut() {
  if(!isPlayer(self))
    return 0;

  if(istrue(self.isjuggernaut))
    return 0;

  if(isDefined(self.lightarmorhp))
    scripts\mp\perks\perkfunctions::unsetlightarmor();

  scripts\mp\lightarmor::setlightarmorvalue(self, 500, 1, 0);
  scripts\mp\weapons::setplantedequipmentuse(0);
  _id_3B64EB40368C1450::set("juggernaut", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("juggernaut", "weapon_pickup", 0);

  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets"))
    scripts\mp\utility\perk::removeperk("specialty_explosivebullets");

  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweapon);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.secondaryweapon);
  primaryweapon = "iw8_lm_kilo121_mp";
  scripts\cp_mp\utility\inventory_utility::_giveweapon(primaryweapon);
  self givemaxammo(primaryweapon);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(primaryweapon);
  self.juggoverlay = newclienthudelem(self);
  self.juggoverlay.x = 0;
  self.juggoverlay.y = 0;
  self.juggoverlay.alignx = "left";
  self.juggoverlay.aligny = "top";
  self.juggoverlay.horzalign = "fullscreen";
  self.juggoverlay.vertalign = "fullscreen";
  self.juggoverlay setshader("gasmask_overlay_delta", 640, 480);
  self.juggoverlay.sort = -10;
  self.juggoverlay.archived = 1;
  self.juggoverlay.alpha = 1.0;
  self.health = self.maxhealth;
  self.isjuggernaut = 1;
  self.movespeedscaler = 0.75;
  scripts\mp\utility\perk::giveperk("specialty_scavenger");
  scripts\mp\utility\perk::giveperk("specialty_quickdraw");
  scripts\mp\utility\perk::giveperk("specialty_sharp_focus");
  thread juggernautsounds();
  thread juggremover();
  level notify("gained_juggernaut", self);
  return 1;
}

juggernautsounds() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("jugg_removed");

  for(;;)
    wait 3.0;
}

juggremover() {
  self endon("disconnect");
  thread removejuggongameended();
  thread removejuggonteamchangeordeath();
  self waittill("should_remove_jugg");

  if(isDefined(self.lightarmorhp))
    scripts\mp\perks\perkfunctions::unsetlightarmor();

  scripts\mp\weapons::setplantedequipmentuse(1);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("juggernaut");
  self.juggoverlay destroy();
  scripts\cp_mp\utility\inventory_utility::_takeweapon("iw8_lm_kilo121_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweapon);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweapon);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.primaryweapon);
  self.movespeedscaler = 1.0;
  scripts\mp\utility\perk::removeperk("specialty_scavenger");
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  scripts\mp\utility\perk::removeperk("specialty_sharp_focus");
  self.isjuggernaut = 0;
  level notify("removed_juggernaut", self);
  self notify("jugg_removed");
}

removejuggongameended() {
  self endon("disconnect");
  self endon("jugg_removed");
  level waittill("game_ended");
  self notify("should_remove_jugg");
}

removejuggonteamchangeordeath() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("jugg_removed");
  scripts\engine\utility::waittill_any_4("death", "joined_team", "joined_spectators", "lost_juggernaut");
  self notify("should_remove_jugg");
}

updatefloorbrush(player, disabled) {
  if(!isDefined(self.neutralbrush)) {
    return;
  }
  ownerteam = self.ownerteam;
  claimteam = self.claimteam;
  _id_8E879FAF3052E0D2 = player.team;
  _id_8420670EAFC8D391 = player _meth_8420670EAFC8D391();

  if(_id_8420670EAFC8D391)
    _id_8E879FAF3052E0D2 = player _meth_638EEBEFF841E16A();

  if(istrue(disabled))
    hidebrushes(player);
  else if(istrue(self.stalemate))
    showcontestedbrush(player);
  else if(ownerteam == "neutral") {
    if(claimteam != "none") {
      if(_id_8E879FAF3052E0D2 == claimteam)
        showfriendlybrush(player);
      else
        showenemybrush(player);
    } else
      showneutralbrush(player);
  } else if(_id_8E879FAF3052E0D2 == ownerteam)
    showfriendlybrush(player);
  else
    showenemybrush(player);

  updatecapturebrush(player);
}

updatecapturebrush(player) {
  if(1) {
    return;
  }
  if(!isDefined(self.neutralbrush)) {
    return;
  }
  _id_2E0BDB36F81A37E4 = scripts\mp\gameobjects::getclaimteam();
  _id_8E879FAF3052E0D2 = player.team;
  _id_8420670EAFC8D391 = player _meth_8420670EAFC8D391();

  if(_id_8420670EAFC8D391)
    _id_8E879FAF3052E0D2 = player _meth_638EEBEFF841E16A();

  if(istrue(self.stalemate))
    hidecapturebrush(player);
  else if(_id_2E0BDB36F81A37E4 == "none")
    hidecapturebrush(player);
  else if(_id_8E879FAF3052E0D2 == _id_2E0BDB36F81A37E4)
    showfriendlycapturebrush(player);
  else
    showenemycapturebrush(player);
}

showneutralbrush(player) {
  foreach(brush in self.friendlybrush)
  brush hidefromplayer(player);

  foreach(brush in self.enemybrush)
  brush hidefromplayer(player);

  foreach(brush in self.contestedbrush)
  brush hidefromplayer(player);

  foreach(brush in self.neutralbrush)
  brush showtoplayer(player);
}

showfriendlybrush(player) {
  foreach(brush in self.friendlybrush)
  brush showtoplayer(player);

  foreach(brush in self.enemybrush)
  brush hidefromplayer(player);

  foreach(brush in self.contestedbrush)
  brush hidefromplayer(player);

  foreach(brush in self.neutralbrush)
  brush hidefromplayer(player);
}

showenemybrush(player) {
  foreach(brush in self.friendlybrush)
  brush hidefromplayer(player);

  foreach(brush in self.enemybrush)
  brush showtoplayer(player);

  foreach(brush in self.contestedbrush)
  brush hidefromplayer(player);

  foreach(brush in self.neutralbrush)
  brush hidefromplayer(player);
}

showcontestedbrush(player) {
  foreach(brush in self.friendlybrush)
  brush hidefromplayer(player);

  foreach(brush in self.enemybrush)
  brush hidefromplayer(player);

  foreach(brush in self.contestedbrush)
  brush showtoplayer(player);

  foreach(brush in self.neutralbrush)
  brush hidefromplayer(player);
}

hidebrushes(player) {
  foreach(brush in self.friendlybrush)
  brush hidefromplayer(player);

  foreach(brush in self.enemybrush)
  brush hidefromplayer(player);

  foreach(brush in self.contestedbrush)
  brush hidefromplayer(player);

  foreach(brush in self.neutralbrush)
  brush hidefromplayer(player);
}

showfriendlycapturebrush(player) {
  foreach(brush in self.friendlypulsebrush)
  brush showtoplayer(player);

  foreach(brush in self.enemypulsebrush)
  brush hidefromplayer(player);
}

showenemycapturebrush(player) {
  foreach(brush in self.friendlypulsebrush)
  brush hidefromplayer(player);

  foreach(brush in self.enemypulsebrush)
  brush showtoplayer(player);
}

hidecapturebrush(player) {
  foreach(brush in self.friendlypulsebrush)
  brush hidefromplayer(player);

  foreach(brush in self.enemypulsebrush)
  brush hidefromplayer(player);
}

updatefloorbrushwaitforjoined() {}

applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

removethermal() {
  self thermalvisionoff();
}

startspectatorview() {
  waitframe();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  _id_025AC223966C5537 = level.spectatorcameras[level.currentspectatorcamref][self.team];
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
  thread runslamzoomonspawn();
}

updatespectatorcamera(_id_CA2C833762E5466C) {
  level.currentspectatorcamref = _id_CA2C833762E5466C;

  foreach(player in level.players) {
    if(isDefined(player.spectatorcament)) {
      team = player.team;
      _id_B5ECD32577A250AD = getdvarint("dvar_8BFD75900211E88B", -1);

      if(_id_B5ECD32577A250AD != -1)
        team = scripts\engine\utility::ter_op(_id_B5ECD32577A250AD == 0, "allies", "axis");

      _id_5940F376A254619D = level.spectatorcameras[level.currentspectatorcamref][team];
      player.spectatorcament movecameratomappos(player, _id_5940F376A254619D.origin, _id_5940F376A254619D.angles);
    }
  }
}

movecameratomappos(player, _id_9813182985677B23, finalangles) {
  player endon("spawned_player");
  movetime = 1.0;
  _id_CC5BC42930ABBC4F = 1.0;
  self moveTo(_id_9813182985677B23, 1.0, 0.5, 0.5);
  player playlocalsound("mp_cmd_camera_zoom_out");
  player setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(finalangles, 1.0, 0.5, 0.5);
  player thread startoperatorsound();
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
  currenttime = gettime();

  if(!isDefined(self.lastsitreptime) || currenttime < self.lastsitreptime + 30000 || currenttime < level.lastteamstatustime[self.team] + 5000) {
    return;
  }
  scripts\mp\utility\dialog::sitrepdialogonplayer(getsitreplocname());
  thread playselfbattlechatter(self, "plrresponse_affirm", "cop_affirm_2d", 2.5, 1);
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

startoperatorsound() {
  self endon("game_ended");
  self waittill("spawned_player");
  wait 0.5;
}

ongameended() {
  level waittill("game_ended");

  foreach(objective in level.objectives)
  objective scripts\mp\gameobjects::setvisibleteam("none");
}

playendofmatchtransition(_id_1F1C8D335BF8F19F) {
  self setclientomnvar("ui_total_fade", 0);
  waitframe();
  _id_64423461FE38ECB3 = 10;
  _id_DC7A4CA1FB2DB25A = _id_64423461FE38ECB3;

  for(_id_DC7A4CA1FB2DB25A = 1; _id_DC7A4CA1FB2DB25A <= _id_64423461FE38ECB3; _id_DC7A4CA1FB2DB25A++) {
    waitframe();
    self setclientomnvar("ui_total_fade", _id_DC7A4CA1FB2DB25A / _id_64423461FE38ECB3);
  }

  if(scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::isusingremote() && isDefined(_id_1F1C8D335BF8F19F)) {
    _id_58F345C26A2E8BE3 = distance2dsquared(self.origin, _id_1F1C8D335BF8F19F.origin);

    if(_id_58F345C26A2E8BE3 > 40000) {
      body = self cloneplayer(0);
      body startragdoll(1);
    }
  }

  thread scripts\mp\playerlogic::spawnintermission(_id_1F1C8D335BF8F19F, "spectator");
  waitframe();
  _id_64423461FE38ECB3 = 4;
  _id_DC7A4CA1FB2DB25A = _id_64423461FE38ECB3;

  for(_id_DC7A4CA1FB2DB25A = _id_64423461FE38ECB3 - 1; _id_DC7A4CA1FB2DB25A >= 0; _id_DC7A4CA1FB2DB25A--) {
    waitframe();
    self setclientomnvar("ui_total_fade", _id_DC7A4CA1FB2DB25A / _id_64423461FE38ECB3);
  }
}

getsitreplocname() {
  dialog = "sitrep_" + level.currentobjectiveindex + "_" + level.mapname;
  return dialog;
}

getcapturedialog(action) {
  dialog = "cop_obj_" + level.currentobjectiveindex + "_" + action + "_" + level.mapname;
  return dialog;
}

getselfobjcaptureddialog(action) {
  _id_CB3339ECE72DBDEB = "";
  dialog = "";
  _id_A7AF333D56EE650A = 0;

  switch (level.currentobjectiveindex) {
    case 0:
      if(action == "planting") {
        _id_CB3339ECE72DBDEB = "arming_bomb";
        dialog = "cop_arming_bomb_2d";
        _id_A7AF333D56EE650A = 1;
      } else if(action == "defusing") {
        _id_CB3339ECE72DBDEB = "bomb_defusing";
        dialog = "cop_bomb_defusing_2d";
        _id_A7AF333D56EE650A = 1;
      }

      break;
    case 1:
      if(action == "capturing")
        dialog = "";
      else if(action == "captured") {
        if(self.team == "axis") {
          _id_CB3339ECE72DBDEB = "objsecured_generic";
          dialog = "cop_generic_captured_2d";
        } else if(level.mapname == "mp_faridah") {
          _id_CB3339ECE72DBDEB = "objsecured_school";
          dialog = "cop_school_captured_2d";
        } else {
          _id_CB3339ECE72DBDEB = "objsecured_generic";
          dialog = "cop_generic_captured_2d";
        }
      }

      break;
    case 2:
      if(action == "capturing")
        dialog = "";
      else if(action == "captured") {
        _id_CB3339ECE72DBDEB = "objsecured_generic";
        dialog = "cop_generic_captured_2d";
      }

      break;
    case 3:
      if(action == "capturing")
        dialog = "";
      else if(action == "captured") {
        if(level.mapname == "mp_faridah") {
          _id_CB3339ECE72DBDEB = "objsecured_warehouse";
          dialog = "cop_warehouse_captured_2d";
        } else {
          _id_CB3339ECE72DBDEB = "objsecured_generic";
          dialog = "cop_generic_captured_2d";
        }
      }

      break;
    case 4:
      if(action == "planting") {
        _id_CB3339ECE72DBDEB = "arming_bomb";
        dialog = "cop_arming_bomb_2d";
        _id_A7AF333D56EE650A = 1;
      } else if(action == "defusing") {
        _id_CB3339ECE72DBDEB = "bomb_defusing";
        dialog = "cop_bomb_defusing_2d";
        _id_A7AF333D56EE650A = 1;
      }

      break;
  }

  _id_1499E7C2D69E0074 = 0;

  if(_id_A7AF333D56EE650A && !scripts\mp\battlechatter_mp::saidtoorecently(dialog)) {
    scripts\mp\battlechatter_mp::updatechatter(dialog);
    thread playselfbattlechatter(self, _id_CB3339ECE72DBDEB, dialog, 1.5);
  } else if(!_id_A7AF333D56EE650A)
    thread playselfbattlechatter(self, _id_CB3339ECE72DBDEB, dialog, 1.5);

  faction = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "abp1");

  if(level.mapname == "mp_faridah")
    faction = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "afp1");

  soundalias = "dx_mpp_" + faction + "_" + _id_CB3339ECE72DBDEB;
  return lookupsoundlength(soundalias) / 1000;
}

playselfbattlechatter(player, _id_CB3339ECE72DBDEB, dialog, waittime, _id_263DF9880C0BB2B2) {
  if(isai(self)) {
    return;
  }
  level endon("game_ended");
  self endon("death");

  if(isDefined(waittime))
    wait(waittime);

  faction = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "abp1");

  if(level.mapname == "mp_faridah")
    faction = scripts\engine\utility::ter_op(player.team == "allies", "usp1", "afp1");

  soundalias = "dx_mpp_" + faction + "_" + _id_CB3339ECE72DBDEB;

  if(isDefined(_id_263DF9880C0BB2B2)) {
    _id_9373E8DA64267C1F = soundalias;

    if(soundexists(_id_9373E8DA64267C1F))
      soundalias = _id_9373E8DA64267C1F;
  }

  player queuedialogforplayer(soundalias, dialog, 2);
}

getclosestplayeronteam(org, team) {
  closestplayer = undefined;
  _id_42CA41C7DADAE0C0 = undefined;

  foreach(player in level.players) {
    if(player.team == team && scripts\mp\utility\player::isreallyalive(player)) {
      dist = distance2dsquared(player.origin, org);

      if(!isDefined(_id_42CA41C7DADAE0C0) || dist < _id_42CA41C7DADAE0C0) {
        closestplayer = player;
        _id_42CA41C7DADAE0C0 = dist;
      }
    }
  }

  return closestplayer;
}

disableobjectiveongameended() {
  level waittill("game_ended");

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective))
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
}

setupcaptureflares() {
  if(getdvarint("dvar_B7EE28D2BFBCD1ED", 0) != 1) {
    return;
  }
  wait 2.0;
  _id_F261B8826E6EB207 = [];
  _id_F261B8826E6EB207[_id_F261B8826E6EB207.size] = spawnflare((350, -3580, -35), (0, -151, 0));
  _id_F261B8826E6EB207[_id_F261B8826E6EB207.size] = spawnflare((345, -3650, -35), (0, 140, 0));
  _id_F261B8826E6EB207[_id_F261B8826E6EB207.size] = spawnflare((235, -3655, -35), (0, 50, 0));
  _id_F261B8826E6EB207[_id_F261B8826E6EB207.size] = spawnflare((230, -3575, -35), (0, -40, 0));
  level.objectives["0"].scriptables = _id_F261B8826E6EB207;
  _id_C6D814E0881AE02D = [];
  _id_C6D814E0881AE02D[_id_C6D814E0881AE02D.size] = spawnflare((-457, -2006, 204), (0, 331, 0), 0);
  _id_C6D814E0881AE02D[_id_C6D814E0881AE02D.size] = spawnflare((-31, -1915, 192), (45, 48, 0), 0);
  _id_C6D814E0881AE02D[_id_C6D814E0881AE02D.size] = spawnflare((-319, -1706, 209), (0, 130, 0), 0);
  _id_C6D814E0881AE02D[_id_C6D814E0881AE02D.size] = spawnflare((-545, -1805, 207), (0, 130, 0), 0);
  _id_C6D814E0881AE02D[_id_C6D814E0881AE02D.size] = spawnflare((-302, -2137, 152), (0, 234, 0));
  level.objectives["1"].scriptables = _id_C6D814E0881AE02D;
  _id_795B157300BAC466 = [];
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((420, -23, 17), (5, 208, 0));
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((458, 59, 109), (0, 342, 0), 0);
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((380, -267, 17), (0, 186, 0));
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((210, 126, 18), (5, 125, 0));
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((675, 118, 18), (0, 41, 0));
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((638, -180, 18), (5, 356, 0));
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((417, 105, 69), (75, 285, 0), 0);
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((426, -177, 17), (5, 73, 0), 0);
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((509, -116, 69), (55, 82, 0), 0);
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((331, 60, 63), (0, 309, 0), 0);
  _id_795B157300BAC466[_id_795B157300BAC466.size] = spawnflare((578, 65, 62), (40, 197, 0), 0);
  level.objectives["2"].scriptables = _id_795B157300BAC466;
  _id_30D3159BB07F7330 = [];
  _id_30D3159BB07F7330[_id_30D3159BB07F7330.size] = spawnflare((812, 2074, 222), (35, 326, 0), 0);
  _id_30D3159BB07F7330[_id_30D3159BB07F7330.size] = spawnflare((431, 1882, 241), (5, 86, 0), 0);
  _id_30D3159BB07F7330[_id_30D3159BB07F7330.size] = spawnflare((762, 2333, 226), (15, 345, 0), 0);
  _id_30D3159BB07F7330[_id_30D3159BB07F7330.size] = spawnflare((609, 1861, 223), (65, 339, 0), 0);
  _id_30D3159BB07F7330[_id_30D3159BB07F7330.size] = spawnflare((580, 2150, 212), (0, 272, 0), 0);
  level.objectives["3"].scriptables = _id_30D3159BB07F7330;
  _id_4A375F2E6D9448F8 = [];
  _id_4A375F2E6D9448F8[_id_4A375F2E6D9448F8.size] = spawnflare((1300, 3335, 12), (0, 40, 0));
  _id_4A375F2E6D9448F8[_id_4A375F2E6D9448F8.size] = spawnflare((1305, 3430, -2), (0, -47, 0));
  _id_4A375F2E6D9448F8[_id_4A375F2E6D9448F8.size] = spawnflare((1430, 3435, -3), (0, -135, 0));
  _id_4A375F2E6D9448F8[_id_4A375F2E6D9448F8.size] = spawnflare((1430, 3350, 3), (0, 140, 0));
  level.objectives["4"].scriptables = _id_4A375F2E6D9448F8;

  if(getdvarint("dvar_0424C014A94392D1", 0) == 1)
    thread debugcaptureflares();
}

spawnflare(org, angles, _id_920F4173513EB6B8) {
  spawnpos = org;

  if(!isDefined(_id_920F4173513EB6B8))
    _id_920F4173513EB6B8 = 1;

  if(_id_920F4173513EB6B8)
    spawnpos = scripts\engine\utility::drop_to_ground(org, 50, -200, (0, 0, 1));

  scriptable = spawn("script_model", spawnpos + (0, 0, 2));
  scriptable.angles = angles + (0, 180, 0);
  scriptable setModel("cop_marker_scriptable");
  return scriptable;
}

updateflares(state) {
  if(getdvarint("dvar_B7EE28D2BFBCD1ED", 0) != 1) {
    return;
  }
  self notify("updateFlares");
  self endon("updateFlares");

  while(!isDefined(self.scriptables))
    waitframe();

  foreach(scriptable in self.scriptables)
  scriptable setscriptablepartstate("marker", state);
}

debugcaptureflares() {
  _id_18639177DE723D3A = 0;

  for(;;) {
    state = 0;

    switch (_id_18639177DE723D3A) {
      case 0:
        state = "allies";
        break;
      case 1:
        state = "axis";
        break;
      case 2:
        state = "contested";
        break;
      case 3:
        state = "idle";
        break;
    }

    foreach(objective in level.objectives) {
      if(!isDefined(objective.scriptables)) {
        continue;
      }
      foreach(scriptable in objective.scriptables)
      scriptable setscriptablepartstate("marker", state);
    }

    _id_18639177DE723D3A++;

    if(_id_18639177DE723D3A > 3)
      _id_18639177DE723D3A = 0;

    wait 3.0;
  }
}

mapobjectiveicon(index) {
  switch (level.mapname) {
    case "mp_faridah":
      switch (self.objectivekey) {
        case "0":
          self.iconname = "_bombsite";
          break;
        case "1":
          self.iconname = "_school";
          break;
        case "2":
          self.iconname = "_clocktower";
          break;
        case "3":
          self.iconname = "_warehouse";
          break;
        case "4":
          self.iconname = "_bombsite";
          break;
        default:
          self.iconname = "";
          break;
      }

      break;
    default:
      switch (self.objectivekey) {
        case "0":
          self.iconname = "_generic";
          break;
        case "1":
          self.iconname = "_generic";
          break;
        case "2":
          self.iconname = "_generic";
          break;
        case "3":
          self.iconname = "_generic";
          break;
        case "4":
          self.iconname = "_generic";
          break;
        default:
          self.iconname = "";
          break;
      }

      break;
  }
}

updateoobtriggers() {
  if(!isDefined(level.currentobjective.oobtriggers)) {
    return;
  }
  level notify("updateOOBTriggers");

  foreach(player in level.players) {
    if(isDefined(level.currentobjective.oobtriggers["allies"]))
      level.currentobjective.oobtriggers["allies"] thread updateoobvisuals("axis");

    if(isDefined(level.currentobjective.oobtriggers["axis"]))
      level.currentobjective.oobtriggers["axis"] thread updateoobvisuals("allies");
  }
}

updateoobvisuals(state) {
  self notify("updateOOBVisuals");
  self endon("updateOOBVisuals");

  while(!isDefined(self.visuals))
    waitframe();

  foreach(visual in self.visuals) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < visual.drawcount; _id_AC0E594AC96AA3A8++)
      visual setscriptablepartstate("chevron_" + _id_AC0E594AC96AA3A8, state);
  }

  level waittill("updateOOBTriggers");

  foreach(visual in self.visuals) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < visual.drawcount; _id_AC0E594AC96AA3A8++)
      visual setscriptablepartstate("chevron_" + _id_AC0E594AC96AA3A8, "off");
  }
}

awardcapturepoints() {
  level endon("game_ended");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  _id_CC748B6D457627FE = 1;
  score = 1;

  while(!level.gameended) {
    waittime = 0.0;

    while(waittime < _id_CC748B6D457627FE) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      waittime = waittime + level.framedurationseconds;

      if(self.stalemate)
        waittime = 0.0;
    }

    team = self.claimteam;

    if(team == "none") {
      continue;
    }
    if(!self.stalemate) {
      foreach(object in self.touchlist[team])
      object.player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B70D7C404342B807");
    }
  }
}