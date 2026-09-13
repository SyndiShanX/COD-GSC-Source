/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ko.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  level._id_904F766B5267E332 = 0;
  matchmakingmatch = getdvarint("onlinegame") && !getdvarint("xblive_privatematch");

  if(matchmakingmatch)
    level._id_904F766B5267E332 = getdvarint("dvar_02C1108728124DD3", 0);

  level.allowmodestructs = [];

  if(level._id_904F766B5267E332)
    level.allowmodestructs[level.allowmodestructs.size] = "arm";

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();

  if(istrue(level._id_904F766B5267E332))
    _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "arm";

  level._id_82BD227D5FB7E96F = [];

  if(istrue(level._id_904F766B5267E332)) {
    _id_6F0350C82FC94C38 = getEntArray("gw_fob_03", "targetname");
    level._id_82BD227D5FB7E96F = _id_6F0350C82FC94C38[0].origin;
  } else {
    _id_58553518A66CEBE9 = getEntArray("cyber_emp_pickup_trig", "targetname");

    foreach(trig in _id_58553518A66CEBE9)
    level._id_82BD227D5FB7E96F[level._id_82BD227D5FB7E96F.size] = trig.origin;

    if(level._id_82BD227D5FB7E96F.size == 0) {
      level._id_82BD227D5FB7E96F[0] = (0, 0, 0);
      primaryflags = getEntArray("flag_primary", "targetname");

      foreach(flag in primaryflags) {
        if(flag.script_label == "_b") {
          level._id_82BD227D5FB7E96F[0] = flag.origin;
          break;
        }
      }
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_82BD227D5FB7E96F.size; _id_AC0E594AC96AA3A8++)
    level._id_82BD227D5FB7E96F[_id_AC0E594AC96AA3A8] = _id_593BF7DDBFE1739F(level._id_82BD227D5FB7E96F[_id_AC0E594AC96AA3A8]);

  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 2, 0, 12);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 90);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 5);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerconnect = ::onplayerconnect;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;
  level.onobjectivecomplete = ::_id_0983348E55E3F3E5;
  level.onmaprestart = ::_id_BA7699D705FB8850;
  level._id_CA4E08767CBDAE12 = ::_id_BD59438EE37CCC48;
  level.allowlatecomers = 0;
  game["canScoreOnTie"] = 0;

  if(level._id_904F766B5267E332) {
    level.requiredplayercountoveride = 1;
    level.requiredplayercount["allies"] = 12;
    level.requiredplayercount["axis"] = 12;
    level.modecontrolledvehiclespawningonly = 1;
    level.maxhqtanks = 0;
    level.numnonrallyvehicles = getdvarint("dvar_F2200F106D1B98BE", 25);
    level.skipplaybodycountsound = 1;
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    switch (mapname) {
      case "mp_farms2":
      case "mp_riverside_gw":
      case "mp_promenade_gw":
      case "mp_layover_gw":
      case "mp_boneyard_gw":
      case "mp_port2_gw":
      case "mp_farms2_gw":
      case "mp_downtown_gw":
      case "mp_quarry2":
        scripts\cp_mp\parachute::initparachutedvars();
        break;
      default:
        break;
    }

    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (mapname) {
        case "mp_downtown_gw":
          setDvar("scr_localeID", 6);
          break;
        case "mp_quarry2":
          setDvar("scr_localeID", 5);
          break;
        case "mp_farms2":
        case "mp_farms2_gw":
          setDvar("scr_localeID", 9);
          break;
        case "mp_port2_gw":
          setDvar("scr_localeID", 3);
          break;
        case "mp_boneyard_gw":
          setDvar("scr_localeID", 4);
          break;
        case "mp_aniyah":
          setDvar("scr_localeID", 17);
          break;
        case "mp_promenade_gw":
          setDvar("scr_localeID", 18);
          break;
        case "mp_layover_gw":
          setDvar("scr_localeID", 10);
          break;
        case "mp_riverside_gw":
          setDvar("scr_localeID", 19);
          break;
        default:
          setDvar("scr_localeID", 0);
      }
    }
  }

  if(getdvarint("dvar_A317FBBCDE464162", 1) == 1) {
    if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
      game["dialog"]["gametype"] = "iw9_kout_mode_uktl_kot1";
    else
      game["dialog"]["gametype"] = "iw9_kout_mode_uktl_name";

    if(!isDefined(game["roundsPlayed"]))
      _id_126FE93C04FE16DF = "iw9_kout_mode_uktl_bost";
    else
      _id_126FE93C04FE16DF = "iw9_kout_mode_uktl_bosh";

    game["dialog"]["offense_obj"] = _id_126FE93C04FE16DF;
    game["dialog"]["defense_obj"] = _id_126FE93C04FE16DF;
  }

  game["dialog"]["ko_flag_returned"] = "iw9_kout_mode_uktl_kffr";
  game["dialog"]["ko_flag_get_nag"] = "iw9_kout_mode_uktl_kfgn";
  game["dialog"]["ko_we_got_flag"] = "iw9_kout_mode_uktl_kfft";
  game["dialog"]["ko_we_dropped_flag"] = "iw9_kout_mode_uktl_kffd";
  game["dialog"]["ko_you_got_flag"] = "iw9_kout_mode_uktl_kffy";
  game["dialog"]["ko_enemy_got_flag"] = "iw9_kout_mode_uktl_kfet";
  game["dialog"]["ko_enemy_dropped_flag"] = "iw9_kout_mode_uktl_kfed";
  setomnvar("ui_single_flag_loc", -3);
  _id_423B7147B1256ABD();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_265155622CFA46DA", getmatchrulesdata("koData", "flagHoldTimer"));
  setdynamicdvar("dvar_678896DF033B3202", getmatchrulesdata("koData", "flagHoldReward"));
  setdynamicdvar("dvar_A3FF29A46A657A08", getmatchrulesdata("koData", "flagForceTimer"));
  setdynamicdvar("dvar_C37DECC9E0687C6F", getmatchrulesdata("koData", "flagActivationDelay"));
  setdynamicdvar("dvar_EE5E8807905FA36B", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("dvar_BDCD309276A56476", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("dvar_25905F240AF754F6", getmatchrulesdata("carryData", "manualDropEnabled"));
  setdynamicdvar("dvar_E3D6CCC4D0424812", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("dvar_9E0793789DCB8C02", 0);
}

_id_593BF7DDBFE1739F(position) {
  switch (level.mapname) {
    case "mp_oilfield_6v6":
      if(distance(position, (-391, 6685, 310)) < 10)
        position = position + (0, 36, 0);
      else if(distance(position, (-387, 4569, 373)) < 10)
        position = position + (-7, -77, 0);
      else if(distance(position, (-356, 5432, 375)) < 10)
        position = position + (2, 65, 0);

      break;
    default:
      break;
  }

  return position;
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/WAR");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/WAR_HINT");
  }

  if(isDefined(level.initspawnsoverridefunc))
    [[level.initspawnsoverridefunc]]();
  else
    initspawns();

  setomnvar("ui_obj_timer_stopped", 1);
  setomnvar("ui_obj_timer", 0);
  setomnvar("ui_obj_progress", 0);

  if(level._id_904F766B5267E332) {
    thread adjustroundendtimer();
    thread _id_27C2DB69A21775A0::init_groundwarvehicles();
    thread initvehicles();
    _id_3BA4F32E41F63B36::emergency_cleanupents();
  }

  _id_E4CC1E6807CB2252();
  _id_641E4E9B12A99632::inittankspawns();
}

_id_4963C847FFC21A21(objective, waittime) {
  level endon("game_ended");
  objective endon("death");
  objective scripts\mp\objidpoolmanager::objective_set_pulsate(objective.objidnum, 1);
  wait(waittime);
  objective scripts\mp\objidpoolmanager::objective_set_pulsate(objective.objidnum, 0);
}

adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 8.0;
}

waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!level._id_904F766B5267E332)
    level.overrideingraceperiod = 1;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level._id_300E0902DDC99C1B = scripts\mp\utility\dvars::dvarfloatvalue("flagHoldTimer", 0, 0, 120);
  level._id_0053DDD5152672B5 = scripts\mp\utility\dvars::dvarfloatvalue("flagHoldReward", 0, 0, 1);
  level._id_2141E88A6472F3E7 = scripts\mp\utility\dvars::dvarfloatvalue("flagForceTimer", 0, 0, 120);
  level.flagactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("flagActivationDelay", 10, 0, 30);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("idleResetTime", 15, 0, 60);
  level._id_2E170E7CAC361C1F = scripts\mp\utility\dvars::dvarintvalue("drawsUntilBothScore", 3, 0, 5);
}

_id_423B7147B1256ABD() {
  _id_74B5B12BB6514385 = getdvarint("dvar_6E2A3ED599309FAA", 15);

  if(_id_74B5B12BB6514385 > 0) {
    level._id_423B7147B1256ABD = 1;
    level waittill("prematch_done");
    level endon("game_ended");
    wait(_id_74B5B12BB6514385);
    level._id_423B7147B1256ABD = 0;
  }
}

initspawns() {
  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    level.gamemodestartspawnpointnames = [];
    _id_48501209A3E177A7 = "mp_gw_spawn_allies_start";
    _id_AE7D0107AD485428 = "mp_gw_spawn_axis_start";
    level.gamemodestartspawnpointnames["allies"] = _id_48501209A3E177A7;
    level.gamemodestartspawnpointnames["axis"] = _id_AE7D0107AD485428;
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames["allies"] = "mp_tdm_spawn";
    level.gamemodespawnpointnames["axis"] = "mp_tdm_spawn";
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);

    if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_aniyah")
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWarTTLOS", "Crit_Default");
    else if(scripts\cp_mp\utility\game_utility::islargemap())
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWar", "Crit_Default");
    else
      scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");

    scripts\mp\spawnlogic::addstartspawnpoints("mp_gw_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_gw_spawn_axis_start");
    scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_gw_spawn_allies_start");
    scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_gw_spawn_axis_start");
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start");
    _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start");
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
  } else {
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
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
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  if(level._id_904F766B5267E332) {
    spawnteam = self.pers["team"];

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(spawnteam == game["attackers"]) {
        scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
      } else {
        scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
      }
    } else {
      scripts\mp\spawnlogic::activatespawnset("normal", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "fallback");
    }

    if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
      _id_279BB6642EC5E695 = self getspectatingplayer();

      if(isDefined(_id_279BB6642EC5E695) && isDefined(self._id_0FF97225579DE16A) && self.team == _id_279BB6642EC5E695.team && self._id_0FF97225579DE16A == _id_279BB6642EC5E695._id_0FF97225579DE16A)
        spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(_id_279BB6642EC5E695);
    }

    return spawnpoint;
  } else {
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
      } else {
        scripts\mp\spawnlogic::activatespawnset("normal", 1);
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "fallback");
      }
    } else if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }

    return spawnpoint;
  }
}

_id_E4CC1E6807CB2252() {
  level._effect["vfx_br_cashBag"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_vip_burst.vfx");
  level._id_59A1F917FB3131A6 = "neutral";
  level.flagmodel["allies"] = "parts_backpack_duffle_knockout_ground";
  level.flagbase["allies"] = "ctf_game_flag_base";
  level.carryflag["allies"] = "parts_backpack_duffle_knockout";
  level.flagmodel["axis"] = "parts_backpack_duffle_knockout_ground";
  level.flagbase["axis"] = "ctf_game_flag_base";
  level.carryflag["axis"] = "parts_backpack_duffle_knockout";
  setupwaypointicons();
  level.iconescort = "waypoint_escort_flag";
  level.iconkill = "waypoint_ctf_kill";
  level.iconcaptureflag = "waypoint_take_flag";
  level.icondefendflag = "waypoint_defend_flag";
  level.iconreturnflag = "waypoint_recover_flag";
  level.mlgiconemptyflag = "waypoint_mlg_empty_flag";
  level.mlgiconfullflag = "waypoint_mlg_full_flag";
  level.icontarget = "waypoint_target";
  createflagstart();
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_cash_bag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cash_bag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_cash_bag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cash_bag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0, undefined);
}

createflagstart() {
  if(level._id_82BD227D5FB7E96F.size > 1) {
    if(!isDefined(game["koFlagOrigins"]))
      game["koFlagOrigins"] = level._id_82BD227D5FB7E96F;

    _id_0956116F330BBEB2 = game["koFlagOrigins"][0];

    if(isDefined(game["koFlagSpawnOrigin"])) {
      if(game["koFlagOrigins"].size > 1) {
        game["koFlagOrigins"] = scripts\engine\utility::array_remove(game["koFlagOrigins"], game["koFlagSpawnOrigin"]);
        _id_0956116F330BBEB2 = scripts\engine\utility::random(game["koFlagOrigins"]);
        game["koFlagSpawnOrigin"] = _id_0956116F330BBEB2;
      } else
        game["koFlagSpawnOrigin"] = game["koFlagOrigins"][0];
    } else if(isDefined(game["koFlagLastOrigin"])) {
      game["koFlagOrigins"] = scripts\engine\utility::array_remove(game["koFlagOrigins"], game["koFlagLastOrigin"]);
      game["koFlagSpawnOrigin"] = scripts\engine\utility::random(game["koFlagOrigins"]);
      game["koFlagOrigins"] = scripts\engine\utility::array_add(game["koFlagOrigins"], game["koFlagLastOrigin"]);
      game["koFlagLastOrigin"] = undefined;
    } else {
      game["koFlagSpawnOrigin"] = scripts\engine\utility::random(game["koFlagOrigins"]);
      game["koFlagOrigins"] = scripts\engine\utility::array_remove(game["koFlagOrigins"], game["koFlagSpawnOrigin"]);
    }
  } else {
    game["koFlagOrigins"] = level._id_82BD227D5FB7E96F;
    game["koFlagSpawnOrigin"] = game["koFlagOrigins"][0];
  }

  level._id_3E4B06AD7CC2CC65 = game["koFlagSpawnOrigin"];
  tracestart = level._id_3E4B06AD7CC2CC65 + (0, 0, 64);
  _id_8B39E5984DA1FFAF = level._id_3E4B06AD7CC2CC65 + (0, 0, -64);
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
  level._id_3E4B06AD7CC2CC65 = trace["position"];
  level._id_D63F297A45DD1F87 = _id_E9D3ABCF077FB817("allies");
  level thread flaglockedtimer();

  if(game["koFlagOrigins"].size == 1) {
    game["koFlagLastOrigin"] = game["koFlagSpawnOrigin"];
    game["koFlagOrigins"] = undefined;
    game["koFlagSpawnOrigin"] = undefined;
  }
}

flaglockedtimer() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level._id_94E80E94B14782B0.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
    level._id_94E80E94B14782B0.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");
  }

  if(level.flagactivationdelay) {
    scripts\mp\flags::gameflagwait("prematch_done");
    _id_60BA653F45D3F4C8 = int(gettime() + level.flagactivationdelay * 1000);
    setomnvar("ui_obj_timer", _id_60BA653F45D3F4C8);
    setomnvar("ui_obj_progress", 1);
    setomnvar("ui_objective_timer_stopped", 0);
    setomnvar("ui_single_flag_loc", -2);
    level._id_94E80E94B14782B0.objectiveicon thread scripts\mp\gameobjects::_id_D36DCACAC1708708(level.flagactivationdelay);
    level._id_94E80E94B14782B0 thread _id_731AFF3C7FE66E9F(level.flagactivationdelay);
    wait(level.flagactivationdelay);
    setomnvar("ui_obj_timer_stopped", 1);
    setomnvar("ui_obj_timer", 0);
    setomnvar("ui_obj_progress", 0);
    setomnvar("ui_objective_timer_stopped", 1);
    setomnvar("ui_single_flag_loc", -1);
    level._id_94E80E94B14782B0.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag);
    level._id_94E80E94B14782B0.objectiveicon scripts\mp\objidpoolmanager::objective_show_progress(level._id_94E80E94B14782B0.objectiveicon.objidnum, 0);
    thread _id_4963C847FFC21A21(level._id_94E80E94B14782B0.objectiveicon, getdvarfloat("dvar_E23E7531523CD429", 3.0));
    level._id_D63F297A45DD1F87.trigger scripts\engine\utility::trigger_on();

    foreach(team in level.teamnamelist)
    scripts\mp\utility\dialog::leaderdialog("obj_generic_capture", team);
  }
}

_id_E9D3ABCF077FB817(team) {
  level.pickuptime = 0;
  level.returntime = 0;
  radius = 32;
  trigger = spawn("trigger_radius", level._id_3E4B06AD7CC2CC65, 0, radius, 128);
  visuals = [];
  visuals[0] = spawn("script_model", level._id_3E4B06AD7CC2CC65 + (0, 0, 1));
  visuals[0] setModel(level.flagmodel[team]);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(team);
  _id_4E86579DC7E39505 = "neutral";
  _id_3BC2B88A59B6D062 = scripts\mp\gameobjects::createcarryobject(_id_4E86579DC7E39505, trigger, visuals, (0, 0, 16));
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::allowcarry("any");
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setvisibleteam("none");
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
  _id_3BC2B88A59B6D062 scripts\mp\objidpoolmanager::objective_set_play_intro(_id_3BC2B88A59B6D062.objidnum, 0);
  _id_3BC2B88A59B6D062 scripts\mp\objidpoolmanager::objective_set_play_outro(_id_3BC2B88A59B6D062.objidnum, 0);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::registercarryobjectpickupcheck(::flagpickupchecks);
  _id_3BC2B88A59B6D062.allowweapons = 1;
  _id_3BC2B88A59B6D062.requireslos = 1;
  _id_3BC2B88A59B6D062.firstpickup = 1;
  _id_3BC2B88A59B6D062.onpickup = ::onpickup;
  _id_3BC2B88A59B6D062.onpickupfailed = ::onpickupfailed;
  _id_3BC2B88A59B6D062.ondrop = ::ondrop;
  _id_3BC2B88A59B6D062.onreset = ::onreset;
  _id_3BC2B88A59B6D062.visualgroundoffset = (0, 0, 1);

  if(getdvarint("dvar_25905F240AF754F6") != 0)
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::_id_316D9DA870E12A03([visuals[0]], trigger, 1.0, 80, 0);

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 60.0;
        break;
      case 1:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 0.05;
        break;
      case 2:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 1.0;
        break;
      case 3:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 1.5;
        break;
      case 4:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 2.0;
        break;
      case 5:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 3.0;
        break;
      case 6:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 4.0;
        break;
    }

    _id_220BE32C83520117 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    _id_3BC2B88A59B6D062.pingobjidnum = _id_220BE32C83520117;
    scripts\mp\objidpoolmanager::objective_add_objective(_id_220BE32C83520117, "done", _id_3BC2B88A59B6D062.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(_id_220BE32C83520117, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(_id_220BE32C83520117, 0);
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setvisibleteam("none", _id_220BE32C83520117);
    objective_setownerteam(_id_220BE32C83520117, team);
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag, _id_220BE32C83520117);
  } else {
    _id_3BC2B88A59B6D062.objidpingfriendly = 1;
    _id_3BC2B88A59B6D062.objidpingenemy = 0;
    _id_3BC2B88A59B6D062.objpingdelay = 3.0;
  }

  level._id_94E80E94B14782B0 = createteamdefenderflagbase(team, _id_3BC2B88A59B6D062);
  return _id_3BC2B88A59B6D062;
}

createteamdefenderflagbase(team, _id_3BC2B88A59B6D062) {
  _id_D9CA1813B9DE5E20 = _id_3BC2B88A59B6D062.visuals[0].origin;
  _id_0FD8B4C619F5E9FF = spawn("script_model", _id_D9CA1813B9DE5E20);
  _id_0FD8B4C619F5E9FF.ownerteam = "neutral";
  _id_0FD8B4C619F5E9FF setasgametypeobjective();
  _id_0FD8B4C619F5E9FF setteaminhuddatafromteamname(team);
  _id_0FD8B4C619F5E9FF.objectiveicon = scripts\mp\gameobjects::createobjidobject(_id_D9CA1813B9DE5E20, "neutral", (0, 0, 16), undefined, "any", 0);
  _id_0FD8B4C619F5E9FF.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");

  if(level.flagactivationdelay) {
    _id_3BC2B88A59B6D062.trigger scripts\engine\utility::trigger_off();
    _id_0FD8B4C619F5E9FF.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.icontarget, level.icontarget, level.mlgiconfullflag);
  } else
    _id_0FD8B4C619F5E9FF.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag);

  return _id_0FD8B4C619F5E9FF;
}

setteaminhuddatafromteamname(_id_FABF84450735DD93) {
  if(_id_FABF84450735DD93 == "axis")
    self setteaminhuddata(1);
  else if(_id_FABF84450735DD93 == "allies")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}

flagpickupchecks(player) {
  return !player scripts\cp_mp\utility\player_utility::isinvehicle();
}

onpickupfailed(player) {
  return;
}

onpickup(player, _id_5760E0F038D1BAA3, defused) {
  self notify("picked_up");
  player notify("obj_picked_up");

  if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
    _id_FD8C34FA511407DF = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("ko_carry_music_classic");
    player setplayermusicstate(_id_FD8C34FA511407DF);
  } else {
    _id_FD8C34FA511407DF = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("ko_carry_music");
    player setplayermusicstate(_id_FD8C34FA511407DF);
  }

  self.offset3d = (0, 0, 85);
  level._id_94E80E94B14782B0.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
  level._id_D63F297A45DD1F87.currentcarrier = player;
  player thread awardobjtimeforcarrier();
  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(player.team);
  team = player.pers["team"];
  level._id_59A1F917FB3131A6 = team;

  if(team == "allies")
    otherteam = "axis";
  else
    otherteam = "allies";

  player attachflag();
  player scripts\mp\utility\stats::incpersstat("pickups", 1);

  if(self.ownerteam == "allies")
    setomnvar("ui_single_flag_loc", player getentitynumber());
  else
    setomnvar("ui_single_flag_loc", player getentitynumber());

  player setclientomnvar("ui_flag_player_hud_icon", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0)
      scripts\mp\gameobjects::setvisibleteam("none");
    else {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "current");
      scripts\mp\gameobjects::updatecompassicon("enemy", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "icon_waypoint_kill");
      objective_setbackground(self.pingobjidnum, 2);
      scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.pingobjidnum, 1);
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.pingobjidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.pingobjidnum, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
      objective_setownerteam(self.pingobjidnum, team);
      scripts\mp\objidpoolmanager::objective_set_pulsate(self.pingobjidnum, 1);
    }
  }

  scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
  scripts\mp\objidpoolmanager::objective_set_pulsate(self.objidnum, 1);
  player scripts\mp\utility\stats::incpersstat("captures", 1);
  player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
  player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
  player scripts\mp\utility\stats::setextrascore0(player.pers["captures"]);
  thread _id_7BC240FC69EA5205(player);
  thread scripts\mp\hud_util::_id_7B2653A588F28E29(player, "callout_ko_pickup_owner", "callout_ko_pickup_friendly", "callout_ko_pickup_enemy");
  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = player;
  _id_7E2C53B0BCF117D9.eventname = "pickup";
  _id_7E2C53B0BCF117D9.position = player.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  self.previouscarrier = player;

  if(level.codcasterenabled)
    player setgametypevip(1);

  thread _id_9962A01F46DD3B58(team);

  if(level._id_2141E88A6472F3E7 > 0)
    level thread _id_CF40F9E06E5439EE(team);
}

_id_7BC240FC69EA5205(player) {
  self notify("ko_trigger_pickup_sound");
  self endon("ko_trigger_pickup_sound");
  self endon("ko_trigger_drop_sound");
  level endon("game_ended");

  if(isDefined(player)) {
    team = player.pers["team"];
    otherteam = scripts\mp\utility\game::getotherteam(team)[0];
    scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player);
    waittime = getdvarfloat("dvar_C07D9C63C722352B", 0.5);

    if(waittime > 0)
      wait(waittime);

    if(!istrue(level.gameended)) {
      _id_21D6D994B0F4FAF1 = [];

      if(isDefined(player)) {
        _id_21D6D994B0F4FAF1 = [player];
        player scripts\mp\utility\dialog::leaderdialogonplayer("ko_you_got_flag", "status");
      }

      if(isDefined(team))
        scripts\mp\utility\dialog::leaderdialog("ko_we_got_flag", team, "status", _id_21D6D994B0F4FAF1);

      if(isDefined(otherteam))
        scripts\mp\utility\dialog::leaderdialog("ko_enemy_got_flag", otherteam);
    }
  }
}

returnflag() {
  self.offset3d = (0, 0, 16);
  scripts\mp\gameobjects::returnhome();
}

ondrop(player) {
  if(isDefined(player) && isDefined(player.leaving_team)) {
    self.droppedteam = player.leaving_team;
    player.leaving_team = undefined;
  } else if(!isDefined(player))
    self.droppedteam = self.ownerteam;
  else
    self.droppedteam = player.team;

  self.offset3d = (0, 0, 16);
  level._id_D63F297A45DD1F87.currentcarrier = undefined;
  level._id_59A1F917FB3131A6 = "neutral";
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "ko_obj_capture", "ko_obj_capture");
  scripts\mp\gameobjects::setownerteam("neutral");
  team = self.droppedteam;
  otherteam = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(self.pingobjidnum, "done");

  if(level.returntime >= 0)
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
  else {
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
    scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.objidnum, 1);
  }

  thread _id_4963C847FFC21A21(self, 2.0);

  if(self.ownerteam == "allies")
    setomnvar("ui_single_flag_loc", -1);
  else
    setomnvar("ui_single_flag_loc", -1);

  if(isDefined(player)) {
    player setplayermusicstate("");
    player setclientomnvar("ui_flag_player_hud_icon", 0);

    if(!scripts\mp\utility\player::isreallyalive(player))
      player.carryobject.previouscarrier = undefined;

    if(isDefined(player.carryflag))
      player detachflag();

    if(level.codcasterenabled)
      player setgametypevip(0);
  }

  thread _id_8D6269BB8E0916DE(player);
  setomnvar("ui_obj_timer_stopped", 1);
  setomnvar("ui_obj_timer", 0);
  setomnvar("ui_obj_progress", 0);
}

_id_8D6269BB8E0916DE(player) {
  self notify("ko_trigger_drop_sound");
  self endon("ko_trigger_drop_sound");
  self endon("ko_trigger_pickup_sound");
  level endon("game_ended");
  team = self.droppedteam;
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];

  if(isDefined(player))
    scripts\mp\utility\print::printandsoundoneveryone(otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player);
  else
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);

  waittime = getdvarfloat("dvar_C07D9C63C722352B", 0.5);

  if(waittime > 0)
    wait(waittime);

  if(!istrue(level.gameended)) {
    if(isDefined(team))
      scripts\mp\utility\dialog::leaderdialog("ko_we_dropped_flag", team, "status");

    if(isDefined(otherteam))
      scripts\mp\utility\dialog::leaderdialog("ko_enemy_dropped_flag", otherteam, "status");
  }
}

returnaftertime() {
  self endon("picked_up");
  _id_8E53D4CA3DE8531A = 0.0;

  while(_id_8E53D4CA3DE8531A < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none")
      _id_8E53D4CA3DE8531A = _id_8E53D4CA3DE8531A + level.framedurationseconds;
  }

  foreach(team in level.teamnamelist)
  scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", team);

  scripts\mp\gameobjects::returnhome();
}

onreset() {
  level._id_D63F297A45DD1F87.currentcarrier = undefined;

  if(isDefined(level._id_D63F297A45DD1F87.portable_radar)) {
    level._id_D63F297A45DD1F87.portable_radar clearportableradar();
    level._id_D63F297A45DD1F87.portable_radar delete();
  }

  scripts\mp\gameobjects::setownerteam("neutral");
  team = self.droppedteam;
  otherteam = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(self.pingobjidnum, "done");

  if(level.returntime >= 0)
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
  else {
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
    scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.objidnum, 1);
  }

  thread _id_4963C847FFC21A21(self, 2.0);

  if(!level.gameended) {
    foreach(team in level.teamnamelist)
    scripts\mp\utility\dialog::leaderdialog("ko_flag_returned", team, "status");
  }

  self.droppedteam = undefined;

  if(self.ownerteam == "allies")
    setomnvar("ui_single_flag_loc", -1);
  else
    setomnvar("ui_single_flag_loc", -1);

  self.previouscarrier = undefined;
}

attachflag() {
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.team, "ko_obj_hold", "ko_obj_kill");
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];

  if(_id_0F6B7B661E990152(self))
    self attach(level.carryflag[otherteam], "tag_stowed_back3", 1);

  self.carryflag = level.carryflag[otherteam];

  if(self tagexists("j_bag_left"))
    playFXOnTag(level._effect["vfx_br_cashBag"], self, "j_bag_left");
}

detachflag() {
  if(self tagexists("j_bag_left"))
    stopFXOnTag(level._effect["vfx_br_cashBag"], self, "j_bag_left");

  if(_id_0F6B7B661E990152(self))
    self detach(self.carryflag, "tag_stowed_back3");

  self.carryflag = undefined;
}

_id_0F6B7B661E990152(player) {
  _id_56E17BFA53B63A40 = 1;

  if(player scripts\mp\utility\killstreak::isjuggernaut())
    _id_56E17BFA53B63A40 = 0;

  return _id_56E17BFA53B63A40;
}

awardobjtimeforcarrier(team) {
  level endon("game_ended");
  level._id_D63F297A45DD1F87 endon("dropped");
  level._id_D63F297A45DD1F87 endon("reset");
  level notify("objTimePointsRunning");
  level endon("objTimePointsRunning");

  while(!level.gameended) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!level.gameended)
      level._id_D63F297A45DD1F87.carrier scripts\mp\gamescore::giveplayerscore("stat_98BFD8D29C56BC08", 10);
  }
}

_id_9962A01F46DD3B58(team) {
  level._id_3A00BB035DBCF5AD = (scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed()) / 1000;

  if(level._id_300E0902DDC99C1B > 0 && level._id_300E0902DDC99C1B <= level._id_3A00BB035DBCF5AD)
    level._id_3A00BB035DBCF5AD = level._id_300E0902DDC99C1B;

  if(scripts\mp\utility\game::gettimelimit() == 0 && level._id_3A00BB035DBCF5AD <= 0) {
    return;
  }
  _id_300E0902DDC99C1B = int(gettime() + level._id_3A00BB035DBCF5AD * 1000);
  setomnvar("ui_obj_timer", _id_300E0902DDC99C1B);
  setomnvar("ui_obj_progress", 1);
  setomnvar("ui_objective_timer_stopped", 0);

  if(_id_A64D63A207ACDFE7())
    level thread scripts\mp\hud_message::notifyteam("ko_force_hold_fr", "ko_force_hold_en", team);

  thread _id_731AFF3C7FE66E9F(level._id_3A00BB035DBCF5AD);

  if(_id_A64D63A207ACDFE7())
    thread _id_8028646F3CC80AC4();
  else if(_id_4D9DBF9E2AA4C0A6())
    thread _id_020C16DDEF8CE58E();
}

_id_731AFF3C7FE66E9F(_id_300E0902DDC99C1B) {
  level._id_D63F297A45DD1F87 endon("dropped");
  _id_4335B4D453C6E781 = _id_300E0902DDC99C1B;

  while(!level.gameended && _id_4335B4D453C6E781 > 0) {
    setomnvar("ui_obj_progress", _id_4335B4D453C6E781 / _id_300E0902DDC99C1B);
    _id_4335B4D453C6E781 = _id_4335B4D453C6E781 - level.framedurationseconds;
    wait(level.framedurationseconds);
  }

  setomnvar("ui_obj_timer", 0);
  setomnvar("ui_obj_progress", 0);
}

_id_8028646F3CC80AC4() {
  level endon("game_ended");
  self endon("dropped");
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level._id_3A00BB035DBCF5AD);
  level _id_EF6C12412261AF73(level._id_D63F297A45DD1F87 scripts\mp\gameobjects::getownerteam(), game["end_reason"]["ko_flag_hold_win"], game["end_reason"]["ko_flag_hold_loss"]);
}

_id_020C16DDEF8CE58E() {
  level endon("game_ended");
  self endon("dropped");
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level._id_3A00BB035DBCF5AD);
  teamrespawn(level._id_D63F297A45DD1F87 scripts\mp\gameobjects::getownerteam(), level._id_D63F297A45DD1F87.currentcarrier);
}

_id_A64D63A207ACDFE7() {
  return level._id_300E0902DDC99C1B != 0 && level._id_0053DDD5152672B5 == 0;
}

_id_4D9DBF9E2AA4C0A6() {
  return level._id_300E0902DDC99C1B != 0 && level._id_0053DDD5152672B5 == 1;
}

teamrespawn(team, _id_22282E7D48CA3400) {
  _id_0774C9CA5D1D6221 = scripts\mp\utility\teams::getteamdata(_id_22282E7D48CA3400.team, "teamCount");

  if(!isDefined(_id_22282E7D48CA3400.rescuedplayers))
    _id_22282E7D48CA3400.rescuedplayers = [];

  foreach(player in level.participants) {
    if(isDefined(player) && player.team == team && !scripts\mp\utility\player::isreallyalive(player) && !scripts\engine\utility::array_contains(scripts\mp\utility\teams::getfriendlyplayers(player.team, 1), player) && (!isDefined(player.waitingtoselectclass) || !player.waitingtoselectclass)) {
      if(isDefined(player.siegelatecomer) && player.siegelatecomer)
        player.siegelatecomer = 0;

      if(!istrue(player.pers["teamKillPunish"])) {
        if(istrue(player.wasflagspawned)) {
          continue;
        }
        player.wasflagspawned = 1;

        if(isDefined(level.revivetriggers[player.guid]))
          level.revivetriggers[player.guid] scripts\mp\teamrevive::revivetriggerholdonuse(_id_22282E7D48CA3400);
        else {
          player thread scripts\mp\playerlogic::waittillcanspawnclient(0);
          player thread scripts\mp\rank::scoreeventpopup("stat_AB2FB342759B6ABC");
          level notify("player_respawned", player);
          player scripts\mp\utility\dialog::leaderdialogonplayer("revived");
        }
      }

      _id_22282E7D48CA3400.rescuedplayers[player.guid] = 1;
    }
  }

  self.playersrevived = _id_22282E7D48CA3400.rescuedplayers.size;
}

_id_CF40F9E06E5439EE(team) {
  level notify("flagForceTimer");
  level endon("flagForceTimer");
  level endon("game_ended");
  level thread scripts\mp\hud_message::notifyteam("ko_force_timer", "ko_force_timer", team);
  level.timelimitoverride = 1;
  _id_E132900CA2C350BE();
}

_id_E132900CA2C350BE() {
  level endon("flagForceTimer");
  level endon("game_ended");
  _id_468D05F737005458 = int(gettime() + level._id_2141E88A6472F3E7 * 1000);
  setgameendtime(_id_468D05F737005458);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level._id_2141E88A6472F3E7);

  if(isDefined(level.onobjectivecomplete))
    [[level.onobjectivecomplete]]("koFlag");
}

_id_0983348E55E3F3E5(_id_3985F515E9F06D2C) {
  if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
    return;
  }
  setgameendtime(0);
  winner = level._id_59A1F917FB3131A6;

  if(winner != "neutral")
    _id_EF6C12412261AF73(winner, game["end_reason"]["ko_flag_win"], game["end_reason"]["ko_flag_loss"]);
  else if(!_id_4D3C24C0DF4B612A())
    _id_EF6C12412261AF73("tie", game["end_reason"]["tie"]);
}

onspawnplayer(_id_9156B53BCF7CE573) {
  thread updatematchstatushintonspawn();
  self setclientomnvar("ui_flag_player_hud_icon", 0);

  if(isDefined(self.pers["captures"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);

  if(isDefined(self.pers["rescues"]))
    scripts\mp\utility\stats::setextrascore1(self.pers["rescues"]);
}

updatematchstatushintonspawn() {
  if(isDefined(level._id_D63F297A45DD1F87.currentcarrier)) {
    if(level._id_D63F297A45DD1F87.currentcarrier.team == self.team)
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("ko_obj_hold");
    else
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("ko_obj_kill");
  } else
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("ko_obj_capture");
}

onplayerconnect(player) {}

ondeadevent(team) {
  if(team == "all")
    _id_EF6C12412261AF73("tie", game["end_reason"]["tie"]);
  else if(team == game["attackers"])
    level _id_EF6C12412261AF73(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  else
    level _id_EF6C12412261AF73(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

ononeleftevent(team) {
  _id_B0DFD912BE32D040 = scripts\mp\utility\game::getlastlivingplayer(team);

  if(isDefined(_id_B0DFD912BE32D040)) {
    _id_B0DFD912BE32D040.laststanding = 1;
    _id_B0DFD912BE32D040 thread givelastonteamwarning();
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(!isPlayer(attacker) || attacker == self) {
    if(isDefined(self.carryflag))
      detachflag();

    return;
  }

  if(isDefined(level._id_D63F297A45DD1F87) && level._id_D63F297A45DD1F87 scripts\mp\gameobjects::getownerteam() == attacker.pers["team"]) {} else if(isDefined(self.carryflag)) {}

  _id_AEC2E5E01F424119 = 0;
  _id_86C1C8628B1D55F8 = attacker.origin;
  attackerisinflictor = 0;

  if(isDefined(einflictor)) {
    _id_86C1C8628B1D55F8 = einflictor.origin;
    attackerisinflictor = einflictor == attacker;
  }

  if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
    if(isDefined(attacker.carryflag) && attackerisinflictor) {
      attacker thread scripts\mp\rank::scoreeventpopup("stat_EBCC9C019C3B6818");
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F735B92839C5A687");
      _id_AEC2E5E01F424119 = 1;
    }

    if(isDefined(self.carryflag)) {
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5311F153A7FEE40C");
      attacker scripts\mp\utility\stats::incpersstat("carrierKills", 1);
      attacker thread scripts\mp\hud_message::showsplash("ko_killed_carrier");
      attacker scripts\mp\utility\stats::incpersstat("defends", 1);
      attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "carrying");
      _id_548072087C9FD504::_id_7D42D3F8DD68280C(20, attacker.team, attacker getentitynumber());
      _id_AEC2E5E01F424119 = 1;
    }

    if(!_id_AEC2E5E01F424119) {
      _id_3CD1AF2851F12AB5 = 0;
      _id_C3F9FED5999C974E = 0;
      _id_D4D1706F5BCA5ABD = distsquaredcheck(_id_86C1C8628B1D55F8, self.origin, level._id_D63F297A45DD1F87.curorigin);

      if(_id_D4D1706F5BCA5ABD) {
        if(level._id_D63F297A45DD1F87.ownerteam == self.team)
          _id_3CD1AF2851F12AB5 = 1;
        else
          _id_C3F9FED5999C974E = 1;
      }

      if(_id_3CD1AF2851F12AB5) {
        attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
        thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "defending");
        attacker scripts\mp\utility\stats::incpersstat("assaults", 1);
      } else if(_id_C3F9FED5999C974E) {
        attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
        attacker scripts\mp\utility\stats::incpersstat("defends", 1);
        attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag))
    detachflag();
}

distsquaredcheck(_id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D, _id_76227CD0036993E3) {
  _id_AAE76E7732B9A9DA = distancesquared(_id_76227CD0036993E3, _id_86C1C8628B1D55F8);
  _id_3D29A24F32F790B1 = distancesquared(_id_76227CD0036993E3, _id_F7DED1FDB02A123D);

  if(_id_AAE76E7732B9A9DA < 90000 || _id_3D29A24F32F790B1 < 90000)
    return 1;
  else
    return 0;
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
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
  winner = level._id_59A1F917FB3131A6;

  if(winner != "neutral")
    _id_EF6C12412261AF73(winner, game["end_reason"]["ko_flag_win"], game["end_reason"]["ko_flag_loss"]);
  else if(!_id_4D3C24C0DF4B612A())
    _id_EF6C12412261AF73("tie", game["end_reason"]["time_limit_reached"]);
}

_id_EF6C12412261AF73(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B) {
  if(winner == "tie") {
    if(!isDefined(game["roundsTied"]))
      game["roundsTied"] = 0;

    game["roundsTied"]++;

    if(game["roundsTied"] > level._id_2E170E7CAC361C1F)
      game["canScoreOnTie"] = 1;

    if(istrue(game["canScoreOnTie"]))
      _id_F0500919D8C387B9 = game["end_reason"]["ko_draw_award_point"];
  }

  thread scripts\mp\gamelogic::endgame(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B);
}

_id_4D3C24C0DF4B612A() {
  _id_738A90B5F9B44834 = 0;
  _id_85AF2A607D7C31E1 = 0;

  foreach(player in level.teamdata["allies"]["players"]) {
    if(scripts\mp\utility\player::isreallyalive(player))
      _id_738A90B5F9B44834++;
  }

  foreach(player in level.teamdata["axis"]["players"]) {
    if(scripts\mp\utility\player::isreallyalive(player))
      _id_85AF2A607D7C31E1++;
  }

  if(_id_738A90B5F9B44834 > _id_85AF2A607D7C31E1) {
    _id_EF6C12412261AF73("allies", game["end_reason"]["ko_alive_count_win"], game["end_reason"]["ko_alive_count_loss"]);
    return 1;
  } else if(_id_738A90B5F9B44834 < _id_85AF2A607D7C31E1) {
    _id_EF6C12412261AF73("axis", game["end_reason"]["ko_alive_count_win"], game["end_reason"]["ko_alive_count_loss"]);
    return 1;
  }

  return 0;
}

vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

registervehicletype(refname, _id_E4015CFE956F4F3F) {
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = _id_E4015CFE956F4F3F;
  vehicleinfo.vehiclespawns = scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F(refname);
  level.vehicleinfo[refname] = vehicleinfo;
}

initvehicles() {
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;

  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  registervehicletype("little_bird", ::vehiclespawn_littlebird);
  registervehicletype("atv", ::vehiclespawn_atv);
  registervehicletype("tac_rover", ::vehiclespawn_tacrover);
  level.vehiclespawnlocs = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    switch (vehicleinfo.refname) {
      case "little_bird":
        vehicleinfo.vehiclespawns = getvehiclespawns("little_bird", "veh9_mil_air_heli_medium_physics_mp");
        break;
      case "atv":
        vehicleinfo.vehiclespawns = getvehiclespawns("atv", "veh9_mil_lnd_atv_physics_mp");
        break;
      case "tac_rover":
        vehicleinfo.vehiclespawns = getvehiclespawns("tac_rover", "tromeo_physics_mp");
        break;
    }

    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      index = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[index] = spawnpoint;
      level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
    }
  }

  if(0) {
    foreach(loc in level.vehiclespawnlocs)
    thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  _id_FC617751F654A141 = level.numnonrallyvehicles;

  if(!isDefined(level.numnonrallyvehicles))
    _id_FC617751F654A141 = 25;

  if(0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
      loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];
      thread scripts\mp\utility\debug::drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];

    if(isDefined(loc)) {
      vehicleinfo = level.vehicleinfo[loc.refname];
      [[vehicleinfo.spawncallback]](loc);
    }
  }
}

getvehiclespawns(_id_7731ADEF63E19B0C, vehicletype) {
  _id_29D9D2428185616D = [];
  mapname = scripts\cp_mp\utility\game_utility::getmapname();
  atvoriginsarray = [];
  atvanglesarray = [];
  _id_380B98510B5D0765 = [];
  _id_FB7E5F19EFD9D046 = [];

  switch (mapname) {
    case "mp_downtown_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (21843.8, -4640.11, -476.961);
        atvoriginsarray[atvoriginsarray.size] = (20375.9, -3612.78, -454);
        atvoriginsarray[atvoriginsarray.size] = (20728.8, -3309.36, -456);
        atvanglesarray[atvanglesarray.size] = (0, 255, 0);
        atvanglesarray[atvanglesarray.size] = (0, 330, 0);
        atvanglesarray[atvanglesarray.size] = (0, 292, 0);
        atvoriginsarray[atvoriginsarray.size] = (20937.2, -9029.28, -379.674);
        atvoriginsarray[atvoriginsarray.size] = (23097.1, -9966.89, -344);
        atvanglesarray[atvanglesarray.size] = (356.825, 240, 0);
        atvanglesarray[atvanglesarray.size] = (0, 0, 0);
        atvoriginsarray[atvoriginsarray.size] = (17471, -23211.4, -204);
        atvoriginsarray[atvoriginsarray.size] = (15960.1, -22768.1, -204);
        atvoriginsarray[atvoriginsarray.size] = (15821.3, -23568, -208.461);
        atvanglesarray[atvanglesarray.size] = (0, 90, 0);
        atvanglesarray[atvanglesarray.size] = (0, 45, 0);
        atvanglesarray[atvanglesarray.size] = (0, 90, 0);
        atvoriginsarray[atvoriginsarray.size] = (22994.3, -15304.5, -216);
        atvanglesarray[atvanglesarray.size] = (0, 105, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (20120.2, -3287.71, -456);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (21339.9, -4787.55, -450.176);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 345, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (357.831, 255.032, -1.25312);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (17449, -22190.1, -208.116);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (16651.1, -22178.2, -207.908);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 60, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 60, 0);
      }

      break;
    case "mp_quarry2":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (26335.7, 30412.6, 655.471);
        atvoriginsarray[atvoriginsarray.size] = (27099.5, 30567.5, 639.236);
        atvoriginsarray[atvoriginsarray.size] = (27315.5, 30525.5, 639.236);
        atvanglesarray[atvanglesarray.size] = (0.0728273, 119, 0.843973);
        atvanglesarray[atvanglesarray.size] = (2.67817, 77.0718, 1.59551);
        atvanglesarray[atvanglesarray.size] = (2.67817, 77.0718, 1.59551);
        atvoriginsarray[atvoriginsarray.size] = (29610.4, 38228.5, 698.883);
        atvoriginsarray[atvoriginsarray.size] = (29465.5, 38973.6, 701);
        atvanglesarray[atvanglesarray.size] = (0, 315, 0);
        atvanglesarray[atvanglesarray.size] = (0, 88.9989, 0);
        atvoriginsarray[atvoriginsarray.size] = (39153, 46431.8, 932.749);
        atvoriginsarray[atvoriginsarray.size] = (38876.4, 46106.9, 925.771);
        atvoriginsarray[atvoriginsarray.size] = (37923.7, 47136.4, 949.247);
        atvanglesarray[atvanglesarray.size] = (1.88064, 180.047, 0.333796);
        atvanglesarray[atvanglesarray.size] = (1.47639, 180.039, 1.17305);
        atvanglesarray[atvanglesarray.size] = (359.077, 185.712, 7.76991);
        atvoriginsarray[atvoriginsarray.size] = (33628.2, 40971.6, 653.047);
        atvoriginsarray[atvoriginsarray.size] = (32104.4, 41719.8, 708.773);
        atvanglesarray[atvanglesarray.size] = (349.991, 186.286, -2.23687);
        atvanglesarray[atvanglesarray.size] = (3.95499, 211.371, 4.41818);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (26310.8, 30168.4, 659.426);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (26954, 29794.1, 651.013);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (358.195, 118.006, -2.71651);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 89.9998, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (38573.2, 47052.8, 950.28);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (39660.3, 45949.9, 952.362);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (359.669, 194.507, -0.439539);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (11.7511, 162.518, 0.102679);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (33138.2, 41498.6, 707.349);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (357.81, 284.768, 1.14713);
      }

      break;
    case "mp_farms2":
    case "mp_farms2_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (49063.3, -22654.9, -385.662);
        atvoriginsarray[atvoriginsarray.size] = (47332.9, -23070.6, -374.497);
        atvoriginsarray[atvoriginsarray.size] = (48281.3, -22202.5, -371.375);
        atvanglesarray[atvanglesarray.size] = (0.0275984, 103.998, 0.280605);
        atvanglesarray[atvanglesarray.size] = (357.226, 88.8435, 4.3294);
        atvanglesarray[atvanglesarray.size] = (3.93534, 89.3527, 4.34541);
        atvoriginsarray[atvoriginsarray.size] = (49720, -18492, -387.562);
        atvoriginsarray[atvoriginsarray.size] = (48107.4, -18052.3, -312.859);
        atvanglesarray[atvanglesarray.size] = (0, 73.9972, 0);
        atvanglesarray[atvanglesarray.size] = (352.657, 118.56, -10.3306);
        atvoriginsarray[atvoriginsarray.size] = (46431.3, -92.3425, -52.4549);
        atvoriginsarray[atvoriginsarray.size] = (47471, -192.634, -43.7394);
        atvoriginsarray[atvoriginsarray.size] = (48085.6, -358.42, 9.73944);
        atvanglesarray[atvanglesarray.size] = (359.802, 240.821, -3.32839);
        atvanglesarray[atvanglesarray.size] = (0.975088, 240.828, 0.322594);
        atvanglesarray[atvanglesarray.size] = (6.15886, 241.028, 2.20885);
        atvoriginsarray[atvoriginsarray.size] = (44528.7, -5376.79, 283.824);
        atvoriginsarray[atvoriginsarray.size] = (43628, -5846.41, 346.636);
        atvanglesarray[atvanglesarray.size] = (357.74, 256.16, -1.56165);
        atvanglesarray[atvanglesarray.size] = (0.506229, 241.181, 0.438595);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (47872.6, -22645.4, -385.49);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (48501.7, -22505, -382.243);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (1.68464, 109.9, -3.26246);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (359.897, 89.9842, 8.71393);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (46034.5, -59.925, -29.8834);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (47108.8, -498.535, -35.0573);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (2.33612, 243.444, -0.141863);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (355.135, 243.112, 2.65064);
      }

      break;
    case "mp_port2_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (31381.3, -35260.4, -566.754);
        atvoriginsarray[atvoriginsarray.size] = (31087.5, -35307.9, -566.206);
        atvanglesarray[atvanglesarray.size] = (0, 106, 0);
        atvanglesarray[atvanglesarray.size] = (0, 91, 0);
        atvoriginsarray[atvoriginsarray.size] = (37273.8, -22647.6, -566);
        atvoriginsarray[atvoriginsarray.size] = (38224.6, -23864.4, -566);
        atvanglesarray[atvanglesarray.size] = (0, 225, 0);
        atvanglesarray[atvanglesarray.size] = (0, 225, 0);
        atvoriginsarray[atvoriginsarray.size] = (37183.4, -15816, -558.929);
        atvoriginsarray[atvoriginsarray.size] = (36704.9, -15941.1, -558);
        atvoriginsarray[atvoriginsarray.size] = (37630.9, -15950.5, -564);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvoriginsarray[atvoriginsarray.size] = (34323.3, -25831.8, -566);
        atvanglesarray[atvanglesarray.size] = (0, 45, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (31412.5, -34658.3, -564.862);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (31042.3, -16171.6, -565.383);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 105, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 75, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (36937.6, -15836.1, -559.8);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (37369.7, -16171.6, -562);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 270, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 270, 0);
      }

      break;
    case "mp_boneyard_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (-28937.7, -17197.8, -246.637);
        atvoriginsarray[atvoriginsarray.size] = (-29175.8, -17121.9, -247.909);
        atvoriginsarray[atvoriginsarray.size] = (-28096.5, -16918.8, -246.085);
        atvanglesarray[atvanglesarray.size] = (1.203, 90, 0.12);
        atvanglesarray[atvanglesarray.size] = (0.597, 90, 0.15);
        atvanglesarray[atvanglesarray.size] = (358.68, 90.0277, -0.8);
        atvoriginsarray[atvoriginsarray.size] = (-25926, -12688.6, -89.5073);
        atvoriginsarray[atvoriginsarray.size] = (-24872.9, -12661.3, -65.0808);
        atvanglesarray[atvanglesarray.size] = (5.13576, 104.619, 0.240957);
        atvanglesarray[atvanglesarray.size] = (358.169, 15, -3.49767);
        atvoriginsarray[atvoriginsarray.size] = (-28315.5, -3152.67, -311.293);
        atvoriginsarray[atvoriginsarray.size] = (-28107.5, -3152.67, -311.293);
        atvoriginsarray[atvoriginsarray.size] = (-27778.8, -3591.73, -310.621);
        atvanglesarray[atvanglesarray.size] = (0.061, 270, 7.355);
        atvanglesarray[atvanglesarray.size] = (0.061, 270, 7.355);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvoriginsarray[atvoriginsarray.size] = (-25666, -8411.14, -47.9997);
        atvoriginsarray[atvoriginsarray.size] = (-26998.2, -9004.54, -40);
        atvanglesarray[atvanglesarray.size] = (358.715, 15.233, -10.279);
        atvanglesarray[atvanglesarray.size] = (0, 285, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-28683.3, -16741.2, -249.16);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-29128.7, -16577.6, -229.266);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (359.734, 90.0021, -0.454);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (353.195, 90.3463, -3.01942);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-27985.4, -3613.97, -315.978);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-28449.8, -3645.92, -312.247);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 270.003, 5.684);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 270.004, -3.208);
      }

      break;
    case "mp_aniyah":
      break;
    case "mp_promenade_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (-9606.95, -21527.2, -279.043);
        atvoriginsarray[atvoriginsarray.size] = (-10288.2, -20891.9, -356.989);
        atvoriginsarray[atvoriginsarray.size] = (-11011.4, -19877, -368.358);
        atvanglesarray[atvanglesarray.size] = (0, 200, 0);
        atvanglesarray[atvanglesarray.size] = (0, 222, 0);
        atvanglesarray[atvanglesarray.size] = (359.526, 210.007, -0.952);
        atvoriginsarray[atvoriginsarray.size] = (-13835.9, -23127.9, -278.639);
        atvoriginsarray[atvoriginsarray.size] = (-14327.9, -22160.8, -266.586);
        atvanglesarray[atvanglesarray.size] = (2.373, 210, 0);
        atvanglesarray[atvanglesarray.size] = (0.806, 194.929, 2.603);
        atvoriginsarray[atvoriginsarray.size] = (-21725.2, -26511, -152);
        atvoriginsarray[atvoriginsarray.size] = (-21577.7, -26755.1, -151.997);
        atvoriginsarray[atvoriginsarray.size] = (-21065.3, -27199.1, -148.746);
        atvanglesarray[atvanglesarray.size] = (0, 30, 0);
        atvanglesarray[atvanglesarray.size] = (0, 60, 0);
        atvanglesarray[atvanglesarray.size] = (5.079, 0.128, 1.453);
        atvoriginsarray[atvoriginsarray.size] = (-18873.3, -25796.5, -199.784);
        atvanglesarray[atvanglesarray.size] = (0, 30, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-10912.6, -20079.6, -367);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-10108.5, -21861.4, -287.271);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 196.996, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (7.93172, 180.719, 4.15911);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-22036.5, -25881.6, -147.198);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-21144.5, -27447.1, -151.145);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 345, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 30, 0);
      }

      break;
    case "mp_layover_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (-3749, 16980, -262);
        atvoriginsarray[atvoriginsarray.size] = (-2971.9, 18898, -262);
        atvoriginsarray[atvoriginsarray.size] = (-2735.8, 16203, -262);
        atvanglesarray[atvanglesarray.size] = (0, 218, 0);
        atvanglesarray[atvanglesarray.size] = (0, 174, 0);
        atvanglesarray[atvanglesarray.size] = (0, 208, 0);
        atvoriginsarray[atvoriginsarray.size] = (-11894, 16161, -266);
        atvoriginsarray[atvoriginsarray.size] = (-11841, 15884, -266);
        atvanglesarray[atvanglesarray.size] = (0, 162, 0);
        atvanglesarray[atvanglesarray.size] = (0, 248, 0);
        atvoriginsarray[atvoriginsarray.size] = (-29137, 12868, -244);
        atvoriginsarray[atvoriginsarray.size] = (-29539, 12883, -252);
        atvoriginsarray[atvoriginsarray.size] = (-29040, 13706, -497);
        atvanglesarray[atvanglesarray.size] = (0, 0, 0);
        atvanglesarray[atvanglesarray.size] = (0, 0, 0);
        atvanglesarray[atvanglesarray.size] = (0, 5, 0);
        atvoriginsarray[atvoriginsarray.size] = (-19181, 16384, -263);
        atvoriginsarray[atvoriginsarray.size] = (-19650, 17253, 54);
        atvoriginsarray[atvoriginsarray.size] = (-19937, 16123, -261);
        atvanglesarray[atvanglesarray.size] = (0, 310, 0);
        atvanglesarray[atvanglesarray.size] = (0, 357, 0);
        atvanglesarray[atvanglesarray.size] = (0, 35, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-3520, 17805, -262);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-3892, 18566, -262);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 165, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 194, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-29131, 13010, -244);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-28676, 13724, -518);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 0, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 355, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-19622, 17422, 54);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 357, 0);
      }

      break;
    case "mp_riverside_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (4103, 26076, 57);
        atvoriginsarray[atvoriginsarray.size] = (4247, 25021, -38);
        atvoriginsarray[atvoriginsarray.size] = (3517, 25981, 47);
        atvanglesarray[atvanglesarray.size] = (0, 143, 0);
        atvanglesarray[atvanglesarray.size] = (0, 189, 0);
        atvanglesarray[atvanglesarray.size] = (0, 103, 0);
        atvoriginsarray[atvoriginsarray.size] = (4989, 29842, 253);
        atvoriginsarray[atvoriginsarray.size] = (1725, 28703, 51);
        atvanglesarray[atvanglesarray.size] = (0, 162, 0);
        atvanglesarray[atvanglesarray.size] = (0, 141, 0);
        atvoriginsarray[atvoriginsarray.size] = (-6826, 33623, -46);
        atvoriginsarray[atvoriginsarray.size] = (-7642, 32168, -188);
        atvoriginsarray[atvoriginsarray.size] = (-6589, 32564, -82);
        atvanglesarray[atvanglesarray.size] = (3, 337, 0);
        atvanglesarray[atvanglesarray.size] = (0, 357, 0);
        atvanglesarray[atvanglesarray.size] = (0, 320, 0);
        atvoriginsarray[atvoriginsarray.size] = (-3326, 32657, 238);
        atvoriginsarray[atvoriginsarray.size] = (-2149, 33264, 253);
        atvanglesarray[atvanglesarray.size] = (0, 325, 0);
        atvanglesarray[atvanglesarray.size] = (0, 287, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (4157, 26465, 65);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (4628, 26545, 63);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 143, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 63, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-7337, 32683, -77);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-6671, 32948, -67);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 320, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 36, 0);
      }

      break;
    default:
      break;
  }

  level.atvoriginsarray = atvoriginsarray;
  level.atvanglesarray = atvanglesarray;

  if(_id_7731ADEF63E19B0C == "atv") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < atvoriginsarray.size; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 <= atvoriginsarray.size - 1) {
        _id_76239E3CB66A8278 = atvoriginsarray[_id_AC0E594AC96AA3A8];
        _id_79BDB2F0B2F0C692 = atvanglesarray[_id_AC0E594AC96AA3A8];
        vehicle = spawnStruct();
        vehicle.origin = _id_76239E3CB66A8278;
        vehicle.angles = _id_79BDB2F0B2F0C692;
        vehicle.targetname = _id_7731ADEF63E19B0C;
        vehicle.vehicletype = vehicletype;
        _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      }
    }
  } else if(_id_7731ADEF63E19B0C == "tac_rover") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380B98510B5D0765.size; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 <= _id_380B98510B5D0765.size - 1) {
        _id_D82A9436EEE389CB = _id_380B98510B5D0765[_id_AC0E594AC96AA3A8];
        _id_17085FD4C01A3645 = _id_FB7E5F19EFD9D046[_id_AC0E594AC96AA3A8];
        vehicle = spawnStruct();
        vehicle.origin = _id_D82A9436EEE389CB;
        vehicle.angles = _id_17085FD4C01A3645;
        vehicle.targetname = _id_7731ADEF63E19B0C;
        vehicle.vehicletype = vehicletype;
        _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      }
    }
  }

  _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF("dvar_AD95D7262A11119E", _id_7731ADEF63E19B0C);
  index = 0;

  for(;;) {
    _id_F826F0378F17AE2F = _func_2EF675C13CA1C4AF(_id_CEFFD5A372961F55, "_origin_", index);
    _id_0D9C6C3C1205D844 = _func_2EF675C13CA1C4AF(_id_CEFFD5A372961F55, "_angles_", index);
    _id_08A4EA3A3BAA22E4 = (0, 0, 0);
    origin = getdvarvector(_id_F826F0378F17AE2F, _id_08A4EA3A3BAA22E4);

    if(origin == (0, 0, 0)) {
      break;
    }

    vehicle = spawnStruct();
    vehicle.origin = origin;
    _id_7224BACAB3F8EE26 = (0, 0, 0);
    vehicle.angles = getdvarvector(_id_0D9C6C3C1205D844, _id_7224BACAB3F8EE26);
    vehicle.targetname = _id_7731ADEF63E19B0C;
    vehicle.vehicletype = vehicletype;
    _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
    index++;
  }

  return _id_29D9D2428185616D;
}

vehiclespawn_littlebird(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_atv(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_tacrover(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata, _id_EE8DA5624236DC89);
}

filtervehiclespawnstructs(_id_9E4E1482CB40C9C5) {
  _id_7CB19F95DBC68942 = [];

  if(getdvarint("dvar_0ADB05B8132EC13B", level.brtdm_config.locale_defaults["scr_brtdm_disable_radiant_vehicles"]) == 1)
    return _id_7CB19F95DBC68942;

  foreach(struct in _id_9E4E1482CB40C9C5) {
    if(distance2dsquared(struct.origin, level.brtdm_config.circlecenter) < level.brtdm_config.circleradius * level.brtdm_config.circleradius)
      _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = struct;
  }

  return _id_7CB19F95DBC68942;
}

_id_BA7699D705FB8850() {
  scripts\mp\codcasterclientmatchdata::_id_0EDBA1EE7C2375A5();
}

_id_BD59438EE37CCC48(point) {
  if(isDefined(level._id_D63F297A45DD1F87)) {
    if(isDefined(point)) {
      if(scripts\engine\utility::ispointinsidecircle(point, level._id_D63F297A45DD1F87.curorigin, 40))
        return 0;
    } else if(self istouching(level._id_D63F297A45DD1F87.trigger))
      return 0;
  }

  return 1;
}