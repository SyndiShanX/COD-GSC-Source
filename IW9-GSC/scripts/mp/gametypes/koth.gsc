/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\koth.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
    _id_9BBACB179DEA3237 = _id_26508F2DE04C7A52::_id_7B7C572755736C13();
  else {
    _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
    _id_9BBACB179DEA3237[1] = "hardpoint";
    _id_9BBACB179DEA3237[2] = "tdm";
  }

  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.hpstarttime = 0;
  level.scoreperplayer = undefined;
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level._id_0952BD6E10104D8A = ::_id_0952BD6E10104D8A;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.lastcaptime = gettime();
  level.usezonecapture = 1;
  level.getkothzonedeadzonedist = ::getkothzonedeadzonedist;
  level.onplayerjoinedteam = _id_1B18A05A284D55C2::onplayerjoinedteam;

  if(scripts\mp\utility\game::isanymlgmatch())
    level.ontimelimit = ::_id_1134D3068749D68E;

  level.lastcaptureteam = undefined;
  level.previousclosespawnent = undefined;
  setomnvar("ui_hq_num_alive", 0);
  setomnvar("ui_hq_ownerteam", -1);

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_hdpt_mode_uktl_hpt1";
  else
    game["dialog"]["gametype"] = "iw9_hdpt_mode_uktl_name";

  game["dialog"]["boost"] = "iw9_hdpt_mode_uktl_bost";
  game["dialog"]["offense_obj"] = "iw9_hdpt_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_hdpt_mode_uktl_bost";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["hp_first"] = "iw9_hdpt_mode_uktl_hpo1";
  game["dialog"]["hp_new_location"] = "iw9_hdpt_mode_uktl_hpnl";
  game["dialog"]["hp_captured_enemy"] = "iw9_hdpt_mode_uktl_hpec";
  game["dialog"]["hp_captured_friendly"] = "iw9_hdpt_mode_uktl_hpfc";
  game["dialog"]["hp_contested"] = "iw9_hdpt_mode_uktl_hpct";
  game["dialog"]["hp_move_soon"] = "iw9_hdpt_mode_uktl_hpmv";
  game["dialog"]["hp_capturing_enemy"] = "iw9_hdpt_mode_uktl_ecip";
  game["dialog"]["hp_capturing_friendly"] = "iw9_hdpt_mode_uktl_fcip";
  level.nosuspensemusic = 1;
  thread writeplayerrotationscoretomatchdataongameend();

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_26508F2DE04C7A52::_id_29020E26E20049D9();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_koth_zonelifetime", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("scr_koth_zonecapturetime", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("scr_koth_firstzoneactivationdelay", getmatchrulesdata("kothData", "firstZoneActivationDelay"));
  setdynamicdvar("scr_koth_zoneactivationdelay", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("dvar_57D1F7940BD7A0E9", getmatchrulesdata("kothData", "nextZoneRevealTime"));
  setdynamicdvar("dvar_DA84027CB230209F", getmatchrulesdata("kothData", "zoneMajorityCapture"));
  setdynamicdvar("scr_koth_randomlocationorder", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("scr_koth_additivescoring", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("scr_koth_pausetime", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("dvar_063CB0E1CF600344", getmatchrulesdata("kothData", "spawnDelay"));
  setdynamicdvar("scr_koth_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("koth", 0);
}

onstartgametype() {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/KOTH");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/KOTH");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/KOTH_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/KOTH_HINT");
  }

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  setclientnamemode("auto_change");
  level thread setupzones();
  initspawns();
  setkothwaypoints();
  seticonnames();

  if(!level.zonerandomlocationorder)
    remaphardpointorder();

  level thread _id_FAB770BFE4B14E75();
  level thread hardpointmainloop();
}

_id_0952BD6E10104D8A() {
  if(level.scoremod["kill"] > 0)
    setDvar("dvar_CF1C084C7A6622F9", 2);
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.firstzoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("firstZoneActivationDelay", 30, 0, 60);
  level.zoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("zoneActivationDelay", 0, 0, 60);
  level._id_088EA071F9ABF23E = scripts\mp\utility\dvars::dvarfloatvalue("nextZoneRevealTime", 12, 0, 300);
  level._id_64C1863A9E80414E = scripts\mp\utility\dvars::dvarintvalue("zoneMajorityCapture", 0, 0, 1);
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("randomLocationOrder", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("additiveScoring", 0, 0, 1);
  level.pausemodetimer = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("spawnDelay", 0, 0, 10);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::isanymlgmatch() && getdvarint("dvar_56937A1BD450393D", 15) != 0)
    level.zoneactivationdelay = adjustzoneactivationdelayforlargemaps();

  if(level.zoneduration < level._id_088EA071F9ABF23E)
    level._id_088EA071F9ABF23E = level.zoneduration;
}

adjustzoneactivationdelayforlargemaps() {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_euphrates":
    case "mp_deadzone":
    case "mp_raid":
      return getdvarint("dvar_56937A1BD450393D", 15);
    case "mp_aniyah":
      return getdvarint("dvar_56937A1BD450393D", 15) + 15;
    default:
      return level.zoneactivationdelay;
  }
}

seticonnames() {
  level.icontarget = "koth_target";
  level.iconneutral = "koth_neutral";
  level.iconcapture = "koth_destroy";
  level.icondefend = "koth_defend";
  level.iconcontested = "koth_contested";
  level.icontaking = "koth_taking";
  level.iconlosing = "koth_losing";
  level.icondefending = "koth_defending";
  level._id_7520A0FC17909B95 = "koth_next";
}

hardpointmainloop() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  level.zone = getfirstzone();
  _id_2AFAF68657598B47 = 1;
  level._id_BF918FC5F938CD0C = 1;
  level.kothhillrotation = 0;

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone scripts\mp\gameobjects::setvisibleteam("any");
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  scripts\mp\utility\game::logannouncement(undefined, undefined, "New Hardpoint", level.zone.trigger.origin);
  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = level.zone;
  _id_7E2C53B0BCF117D9.eventname = "hill_moved";
  _id_7E2C53B0BCF117D9.position = level.zone.trigger.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  scripts\mp\flags::gameflagwait("prematch_done");

  if(level.pausemodetimer)
    level scripts\mp\gamelogic::pausetimer();

  setomnvar("ui_objective_timer_stopped", 0);
  _id_570BA02607C0425C = 0;

  if(level.firstzoneactivationdelay) {
    _id_570BA02607C0425C = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      level._id_A18063A06C258143 = int(gettime() + (level.firstzoneactivationdelay + level.zoneduration) * 1000);

    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 12);
    level.zoneislocked = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "koth_control", "koth_control");
    level thread waitthenplaynewobj();
    level.zone thread scripts\mp\gameobjects::_id_D36DCACAC1708708(level.firstzoneactivationdelay);
    wait(level.firstzoneactivationdelay);
    level.zoneislocked = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "koth_capture", "koth_capture");
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(5, "free");
  }

  level.zone _id_1B18A05A284D55C2::activatezone();
  level.zone notify("stop_watching_first_trigger");

  for(;;) {
    if(!isDefined(level.mapcalloutsready))
      level thread setupzonecallouts(_id_2AFAF68657598B47);

    level.objectivesetorder = 1;

    if(level.pausemodetimer)
      level scripts\mp\gamelogic::resumetimer();

    waittillframeend;
    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled)
      level.zone thread _id_1B18A05A284D55C2::trackgametypevips();

    scripts\mp\spawnlogic::clearlastteamspawns();
    _id_79CEF04E7BD8C4C7(_id_570BA02607C0425C, _id_2AFAF68657598B47);
    _id_2AFAF68657598B47 = 0;
    _id_570BA02607C0425C = 0;
    level._id_BF918FC5F938CD0C = 0;
    setomnvar("ui_hq_status", 10);
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();

    if(level.pausemodetimer)
      level scripts\mp\gamelogic::resumetimer();

    level.lastcaptureteam = undefined;
    level.zone killhardpointvfx();
    level.zone.active = 0;

    if(istrue(level.usehpzonebrushes)) {
      foreach(player in level.players)
      level.zone _id_1B18A05A284D55C2::hideplayerspecificbrushes(player);
    }

    level.zone scripts\mp\gameobjects::disableobject();
    level.zone scripts\mp\gameobjects::allowuse("none");
    level.zone scripts\mp\gameobjects::setownerteam("neutral");
    updateservericons("zone_shift", 0);
    level notify("zone_reset");
    setomnvar("ui_hq_status", -1);
    spawn_next_zone();

    if(scripts\mp\utility\game::getgametype() == "grnd" && level.kothhillrotation == 1) {}

    wait 1;
  }
}

waitthenplaynewobj() {
  if(istrue(level.infilvotiming))
    wait 9.5;
  else
    wait 7.0;

  foreach(_id_F90358454413407F in level.teamnamelist)
  scripts\mp\utility\dialog::statusdialog("hp_first", _id_F90358454413407F);
}

killhardpointvfx() {
  foreach(player in level.players) {
    foreach(_id_25AC26FAC33AC6F3 in player._hardpointeffect) {
      player._hardpointeffect = scripts\engine\utility::array_remove(player._hardpointeffect, _id_25AC26FAC33AC6F3);

      if(isDefined(_id_25AC26FAC33AC6F3))
        _id_25AC26FAC33AC6F3 delete();
    }
  }

  if(isDefined(self.neutralhardpointfx) && self.neutralhardpointfx.size > 0) {
    foreach(_id_25AC26FAC33AC6F3 in self.neutralhardpointfx)
    _id_25AC26FAC33AC6F3 delete();
  }

  self.neutralhardpointfx = [];
}

remaphardpointorder() {
  switch (level.mapname) {
    case "mp_hackney_yard":
    case "mp_hackney_am":
      level.remappedhpzoneorder = ["1", "4", "3", "9", "8"];
      break;
    case "mp_spear":
    case "mp_spear_pm":
      level.remappedhpzoneorder = ["5", "4", "3", "2", "6"];
      break;
    case "mp_cave":
    case "mp_cave_am":
      level.remappedhpzoneorder = ["1", "5", "2", "3", "4"];
      break;
    case "mp_petrograd":
      level.remappedhpzoneorder = ["1", "9", "4", "5", "2"];
      break;
    case "mp_deadzone":
      level.remappedhpzoneorder = ["12", "11", "3", "1", "2"];
      break;
    case "mp_raid":
      level.remappedhpzoneorder = ["20", "2", "8", "9", "5"];
      break;
    case "mp_piccadilly":
      level.remappedhpzoneorder = ["1", "5", "7", "3", "8"];
      break;
    case "mp_crash2_pm":
    case "mp_crash2":
      level.remappedhpzoneorder = ["1", "20", "5", "4", "19"];
      break;
    case "mp_emporium":
      level.remappedhpzoneorder = ["1", "2", "3", "4", "5"];
      break;
    case "mp_broadcast2":
      level.remappedhpzoneorder = ["1", "2", "3", "4", "5"];
      break;
    default:
      break;
  }
}

getfirstzone() {
  if(isDefined(level.remappedhpzoneorder)) {
    zone = level.objectives[level.remappedhpzoneorder[0]];
    level.prevzoneindex = 0;
    level._id_FBB04FF4FFA6D364 = level.objectives[level.remappedhpzoneorder[1]];
  } else {
    zone = level.objectives["1"];
    level.prevzoneindex = 1;
    level._id_FBB04FF4FFA6D364 = level.objectives["2"];
  }

  zone.trigger scripts\engine\utility::trigger_on();
  return zone;
}

getnextzone() {
  level notify("stop_watching_trigger");

  if(level.zonerandomlocationorder) {
    _id_BCADDA10E825A297 = [];

    foreach(_id_F90358454413407F in level.teamnamelist)
    _id_BCADDA10E825A297[_id_F90358454413407F] = (0, 0, 0);

    _id_CFD9FB898B8A8FDE = scripts\mp\utility\game::getpotentiallivingplayers();

    foreach(player in _id_CFD9FB898B8A8FDE) {
      if(player.team == "spectator") {
        continue;
      }
      _id_BCADDA10E825A297[player.team] = _id_BCADDA10E825A297[player.team] + player.origin;
    }

    _id_F95FEB63C772E28F = [];

    foreach(_id_F90358454413407F in level.teamnamelist) {
      players = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players");
      _id_0774C9CA5D1D6221 = max(players.size, 1);
      _id_F95FEB63C772E28F[_id_F90358454413407F] = _id_BCADDA10E825A297[_id_F90358454413407F] / _id_0774C9CA5D1D6221;
    }

    if(!isDefined(level.prevzonelist) || isDefined(level.prevzonelist) && level.prevzonelist.size == level.objectives.size - 1)
      level.prevzonelist = [];

    level.prevzonelist[level.prevzonelist.size] = level.prevzoneindex;
    _id_C5746701A936226C = 0.7;
    _id_1062B157C642E6B7 = 0.3;
    _id_36710543FBAA2AAF = undefined;
    _id_094CCBA012B7736A = undefined;

    foreach(objective in level.objectives) {
      _id_887D42B1410C39FE = 0;

      foreach(_id_FE02B20F9AC0BD11 in level.prevzonelist) {
        if(objective.objectivekey == scripts\engine\utility::string(_id_FE02B20F9AC0BD11)) {
          _id_887D42B1410C39FE = 1;
          break;
        }
      }

      if(_id_887D42B1410C39FE) {
        continue;
      }
      zone = objective;
      _id_4E58252555A3ACA1 = 0;

      foreach(_id_F90358454413407F in level.teamnamelist)
      _id_4E58252555A3ACA1 = _id_4E58252555A3ACA1 + distance2dsquared(zone.curorigin, _id_F95FEB63C772E28F[_id_F90358454413407F]);

      _id_5A8B9D38B749DAE2 = distance2dsquared(zone.curorigin, level.zone.curorigin);
      _id_D552C16ABF741BF4 = _id_4E58252555A3ACA1 * _id_C5746701A936226C + _id_5A8B9D38B749DAE2 * _id_1062B157C642E6B7;

      if(!isDefined(_id_094CCBA012B7736A) || _id_D552C16ABF741BF4 > _id_094CCBA012B7736A) {
        _id_094CCBA012B7736A = _id_D552C16ABF741BF4;
        _id_36710543FBAA2AAF = objective.objectivekey;
      }
    }

    zone = level.objectives[_id_36710543FBAA2AAF];
    level.prevzoneindex = _id_36710543FBAA2AAF;
  } else if(isDefined(level.remappedhpzoneorder)) {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.remappedhpzoneorder.size - 1)
      level.prevzoneindex = 0;

    zone = level.objectives[level.remappedhpzoneorder[level.prevzoneindex]];
    _id_FBB04FF4FFA6D364 = level.prevzoneindex + 1;

    if(_id_FBB04FF4FFA6D364 > level.remappedhpzoneorder.size - 1)
      _id_FBB04FF4FFA6D364 = 0;

    level._id_FBB04FF4FFA6D364 = level.objectives[level.remappedhpzoneorder[_id_FBB04FF4FFA6D364]];
  } else {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.objectives.size)
      level.prevzoneindex = 1;

    zone = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
    _id_FBB04FF4FFA6D364 = level.prevzoneindex + 1;

    if(_id_FBB04FF4FFA6D364 > level.objectives.size)
      _id_FBB04FF4FFA6D364 = 1;

    level._id_FBB04FF4FFA6D364 = level.objectives[scripts\engine\utility::string(_id_FBB04FF4FFA6D364)];
  }

  return zone;
}

spawn_next_zone() {
  writecurrentrotationteamscore();
  level.zone _id_1B18A05A284D55C2::deactivatezone();
  level.zone = getnextzone();
  level.kothhillrotation++;
  level.zone _id_1B18A05A284D55C2::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone.lastactivatetime = gettime();

  if(level.zoneactivationdelay > 0)
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  else
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

  scripts\mp\utility\game::logannouncement(undefined, undefined, "New Hardpoint", level.zone.trigger.origin);
  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = level.zone;
  _id_7E2C53B0BCF117D9.eventname = "hill_moved";
  _id_7E2C53B0BCF117D9.position = level.zone.trigger.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
}

_id_79CEF04E7BD8C4C7(_id_570BA02607C0425C, _id_2AFAF68657598B47) {
  if(_id_2AFAF68657598B47) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("obj_generic_capture", _id_F90358454413407F);
  } else {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("hp_new_location", _id_F90358454413407F);
  }

  if(isDefined(level.zone.curorigin))
    playsoundatpos(level.zone.curorigin, "mp_hq_activate_sfx");

  thread scripts\mp\music_and_dialog::headquarters_newhq_music();
  level.zone thread _id_1B18A05A284D55C2::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("none");

  if(istrue(_id_570BA02607C0425C)) {} else if(level.zoneactivationdelay) {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("zone_activation_delay", 0);
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 12);

    if(level.pausemodetimer)
      level scripts\mp\gamelogic::pausetimer();

    level.zoneislocked = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "koth_control", "koth_control");
    level.zone thread scripts\mp\gameobjects::_id_D36DCACAC1708708(level.zoneactivationdelay);
    wait(level.zoneactivationdelay);
    level.zoneislocked = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "koth_capture", "koth_capture");
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(5, "free");
  }

  level._id_FBB04FF4FFA6D364 scripts\mp\gameobjects::setvisibleteam("none", 1);
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  updateservericons("neutral", 0);

  if(level.zoneduration) {
    updateservericons("neutral", 0);
    thread movezoneaftertime(level.zoneduration);
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      level._id_A18063A06C258143 = int(gettime() + (level.zoneactivationdelay + level.zoneduration) * 1000);
  } else
    level.zonedestroyedbytimer = 0;
}

hpcaptureloop() {
  level endon("game_ended");
  level endon("zone_moved");
  level.hpstarttime = gettime();

  for(;;) {
    level.zone scripts\mp\gameobjects::allowuse("enemy");
    level.zone scripts\mp\gameobjects::setvisibleteam("any");
    level.zone scripts\mp\gameobjects::setusetext(&"MP/SECURING_POSITION");
    level.zone thread _id_1B18A05A284D55C2::hardpoint_setneutral();
    level.zone scripts\mp\gameobjects::cancontestclaim(1);

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime)
      level thread _id_0C5CC3D0D9E62A6D::randomdrops();

    msg = level scripts\engine\utility::waittill_any_return_2("zone_captured", "zone_destroyed");

    if(msg == "zone_destroyed") {
      continue;
    }
    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
    scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_positive", ownerteam);
    scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_negative", scripts\mp\utility\game::getotherteam(ownerteam)[0]);
    level waittill("zone_destroyed", _id_35216C18F7998623);

    if(isDefined(_id_35216C18F7998623)) {
      level.zone scripts\mp\gameobjects::setownerteam(_id_35216C18F7998623);
      continue;
    }

    level.zone scripts\mp\gameobjects::setownerteam("none");
  }
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default", 1);
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_koth_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_koth_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_koth_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_koth_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn_secondary", 1, 1);

  if(!isDefined(level.spawnpoints) || istrue(level.adjustshipmentspawns)) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    _id_3C9C79460E7AEE38 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    _id_3D83BC62B320D11A = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    scripts\mp\spawnlogic::registerspawnset("normal", _id_3C9C79460E7AEE38);
    scripts\mp\spawnlogic::registerspawnset("fallback", _id_3D83BC62B320D11A);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  if(istrue(level.adjustshipmentspawns)) {
    return;
  }
  foreach(zone in level.objectives) {
    zone.furthestspawndistsq = 0;
    zone.spawnpoints = [];
    zone.fallbackspawnpoints = [];
  }

  _id_6E51138D961D7DDD = scripts\cp_mp\utility\game_utility::_id_A0148D3A4A97BBB1();

  foreach(spawnpoint in level.spawnpoints) {
    _id_47D8F0FD833CA536 = spawnpoint.classname == "mp_koth_spawn_allies_start" || spawnpoint.classname == "mp_koth_spawn_axis_start";
    _id_BA992CB19CB03B0C = 0;
    _id_E07D09F62CC34AC2 = spawnpoint.classname == "mp_koth_spawn";
    _id_F87FC0E5455ED600 = spawnpoint.classname == "mp_koth_spawn_secondary";
    _id_AA5C00F4CC732317 = [];

    if(_id_47D8F0FD833CA536) {
      continue;
    }
    if(_id_E07D09F62CC34AC2 || _id_F87FC0E5455ED600) {
      if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "") {
        _id_BA992CB19CB03B0C = 1;

        if(_id_6E51138D961D7DDD)
          _id_AA5C00F4CC732317 = strtok(spawnpoint.target, " ");
        else
          _id_AA5C00F4CC732317 = strtok(spawnpoint.script_noteworthy, " ");

        foreach(_id_FE02B20F9AC0BD11 in _id_AA5C00F4CC732317) {
          if(_id_FE02B20F9AC0BD11 == "6v6" || _id_FE02B20F9AC0BD11 == "10v10") {
            continue;
          }
          if(!postshipmodifiedzones(_id_FE02B20F9AC0BD11)) {
            zone = level.objectives[_id_FE02B20F9AC0BD11];

            if(_id_E07D09F62CC34AC2) {
              zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
              continue;
            }

            zone.fallbackspawnpoints[zone.fallbackspawnpoints.size] = spawnpoint;
          }
        }
      }
    }

    calculatespawndisttozones(spawnpoint, _id_AA5C00F4CC732317);
    _id_F2D96DD81CF63446 = scripts\mp\spawnlogic::getoriginidentifierstring(spawnpoint);

    if(isDefined(level.kothextraprimaryspawnpoints) && isDefined(level.kothextraprimaryspawnpoints[_id_F2D96DD81CF63446])) {
      foreach(_id_FE02B20F9AC0BD11 in level.kothextraprimaryspawnpoints[_id_F2D96DD81CF63446]) {
        zone = level.objectives[_id_FE02B20F9AC0BD11];
        zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
      }
    }

    if(!_id_BA992CB19CB03B0C) {
      foreach(zone in level.objectives) {
        if(_id_E07D09F62CC34AC2) {
          zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
          continue;
        }

        zone.fallbackspawnpoints[zone.fallbackspawnpoints.size] = spawnpoint;
      }
    }
  }

  foreach(objid, zone in level.objectives) {
    zone.spawnset = "koth_" + objid;
    scripts\mp\spawnlogic::registerspawnset(zone.spawnset, zone.spawnpoints);
    zone.fallbackspawnset = "koth_fallback_" + objid;
    scripts\mp\spawnlogic::registerspawnset(zone.fallbackspawnset, zone.fallbackspawnpoints);
  }
}

calculatespawndisttozones(spawnpoint, _id_AA5C00F4CC732317) {
  _id_BF703C3B74E3EC0A = 0;
  spawnpoint.scriptdata.distsqtokothzones = [];

  foreach(zone in level.objectives) {
    if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy == "")
      _id_BF703C3B74E3EC0A = 1;
    else {
      foreach(_id_FE02B20F9AC0BD11 in _id_AA5C00F4CC732317) {
        if(_id_FE02B20F9AC0BD11 == zone.trigger.objectivekey) {
          _id_BF703C3B74E3EC0A = 1;
          break;
        }
      }
    }

    if(!_id_BF703C3B74E3EC0A) {
      continue;
    }
    dist = getpathdist(spawnpoint.origin, zone.trigger.baseorigin, 5000);

    if(dist < 0)
      dist = scripts\engine\utility::distance_2d_squared(spawnpoint.origin, zone.trigger.baseorigin);
    else
      dist = dist * dist;

    spawnpoint.scriptdata.distsqtokothzones[zone.trigger getentitynumber()] = dist;

    if(dist > zone.furthestspawndistsq)
      zone.furthestspawndistsq = dist;
  }
}

comparezoneindexes(_id_5DB62A28BB57C137, _id_5DB62B28BB57C36A) {
  _id_DED9A2A5BE6D47D9 = int(_id_5DB62A28BB57C137.objectivekey);
  _id_DED99FA5BE6D4140 = int(_id_5DB62B28BB57C36A.objectivekey);

  if(!isDefined(_id_DED9A2A5BE6D47D9) && !isDefined(_id_DED99FA5BE6D4140))
    return 0;

  if(!isDefined(_id_DED9A2A5BE6D47D9) && isDefined(_id_DED99FA5BE6D4140))
    return 1;

  if(isDefined(_id_DED9A2A5BE6D47D9) && !isDefined(_id_DED99FA5BE6D4140))
    return 0;

  if(_id_DED9A2A5BE6D47D9 > _id_DED99FA5BE6D4140)
    return 1;

  return 0;
}

getzonearray(targetname) {
  zones = getEntArray(targetname, "targetname");

  foreach(z in zones)
  z.objectivekey = z.script_label;

  if(!isDefined(zones) || zones.size == 0)
    return undefined;

  _id_FCB8575B464D3877 = 1;

  for(n = zones.size; _id_FCB8575B464D3877; n--) {
    _id_FCB8575B464D3877 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < n - 1; _id_AC0E594AC96AA3A8++) {
      if(comparezoneindexes(zones[_id_AC0E594AC96AA3A8], zones[_id_AC0E594AC96AA3A8 + 1])) {
        temp = zones[_id_AC0E594AC96AA3A8];
        zones[_id_AC0E594AC96AA3A8] = zones[_id_AC0E594AC96AA3A8 + 1];
        zones[_id_AC0E594AC96AA3A8 + 1] = temp;
        _id_FCB8575B464D3877 = 1;
      }
    }
  }

  return zones;
}

setupzones() {
  _id_B38C97B95E246DEC = getzonearray("hardpoint_zone");
  triggers = [];

  for(index = 0; index < _id_B38C97B95E246DEC.size; index++)
    triggers[triggers.size] = _id_B38C97B95E246DEC[index];

  level.objectives = [];

  foreach(trigger in triggers) {
    zone = _id_1B18A05A284D55C2::setupobjective(trigger);

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      zone._id_B8CC16DCAF5A0746 = _id_26508F2DE04C7A52::_id_D91924619AE46B1F();

    level.objectives[zone.objectivekey] = zone;
  }

  _id_7FC4B3DB1868930F = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
  _id_99A20728731AC0B0 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
  level.startpos["allies"] = _id_99A20728731AC0B0[0].origin;
  level.startpos["axis"] = _id_7FC4B3DB1868930F[0].origin;
  scripts\mp\objidpoolmanager::requestreservedid(1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(1, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(1, 0);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    scripts\mp\objidpoolmanager::objective_add_objective(1, "done", (0, 0, 0), undefined, "icon_medium");
  else
    scripts\mp\objidpoolmanager::objective_add_objective(1, "done", (0, 0, 0));

  scripts\mp\objidpoolmanager::objective_playermask_showtoall(1);
  return 1;
}

setupzonecallouts(_id_2AFAF68657598B47) {
  _id_49996EBEBBBBF375 = undefined;
  _id_CA8C1EF349B1092F = undefined;
  _id_E73FCC890C2D1002 = undefined;
  zonetrigger = level.zone.visuals[0];

  foreach(_id_C1E5E178D5D956E4 in level.calloutglobals.areatriggers) {
    _id_CA8C1EF349B1092F = ispointinvolume(zonetrigger.baseorigin, _id_C1E5E178D5D956E4);
    _id_E73FCC890C2D1002 = isDefined(zonetrigger.script_noteworthy) && isDefined(_id_C1E5E178D5D956E4.script_noteworthy) && zonetrigger.script_noteworthy == _id_C1E5E178D5D956E4.script_noteworthy;

    if(_id_CA8C1EF349B1092F || _id_E73FCC890C2D1002) {
      _id_49996EBEBBBBF375 = level.calloutglobals.areaidmap[_id_C1E5E178D5D956E4.script_noteworthy];

      foreach(player in level.players) {
        if(isDefined(_id_49996EBEBBBBF375))
          player setclientomnvar("ui_hp_callout_id", _id_49996EBEBBBBF375);
      }

      break;
    }
  }

  if(!istrue(_id_2AFAF68657598B47))
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(4, "free");
}

forcespawnplayers() {
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(!isDefined(player) || isalive(player)) {
      continue;
    }
    player notify("force_spawn");
    waitframe();
  }
}

getspawnpoint() {
  spawnteam = self.pers["team"];
  _id_2FA17BAEFE0FA286 = getkothzonedeadzonedist();
  _id_BA0A9FD614A3F6EE = [];
  _id_BA0A9FD614A3F6EE["activeKOTHZoneNumber"] = level.zone.trigger getentitynumber();
  _id_BA0A9FD614A3F6EE["maxSquaredDistToObjective"] = level.zone.furthestspawndistsq;
  _id_BA0A9FD614A3F6EE["kothZoneDeadzoneDistSq"] = _id_2FA17BAEFE0FA286 * _id_2FA17BAEFE0FA286;
  _id_BA0A9FD614A3F6EE["closestEnemyInfluenceDistSq"] = 12250000;

  if(istrue(level.adjustshipmentspawns)) {
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
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers", undefined, _id_BA0A9FD614A3F6EE);
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders", undefined, _id_BA0A9FD614A3F6EE);
    }
  } else {
    if(!isDefined(level.switchedtohardpointspawnlogic)) {
      level.switchedtohardpointspawnlogic = 1;
      scripts\mp\spawnlogic::setactivespawnlogic("Hardpoint", "Crit_Default");
    }

    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.zone.spawnset, level.zone.fallbackspawnset, "bad", _id_BA0A9FD614A3F6EE);
  }

  return spawnpoint;
}

getkothzonedeadzonedist() {
  return 1000;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  self.forcespawnnearteammates = undefined;
  thread updatematchstatushintonspawn();

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    thread _id_26508F2DE04C7A52::_id_F9AE07213A0AF3DE();
}

movezoneaftertime(time) {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level.zonemovetime = time;
  level.zonedestroyedbytimer = 0;
  _id_1B18A05A284D55C2::zonetimerwait();
  level scripts\mp\objidpoolmanager::returnreservedobjectiveid(1, 0);
  level scripts\mp\objidpoolmanager::update_objective_state(1, "done");
  level scripts\mp\objidpoolmanager::update_objective_position(1, level._id_FBB04FF4FFA6D364.visuals[0].origin + level._id_FBB04FF4FFA6D364.offset3d);
  level.zonedestroyedbytimer = 1;
  level notify("zone_moved");
  level notify("zone_destroyed");
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  if(attacker == self) {
    return;
  }
  if(!isDefined(level.zone)) {
    return;
  }
  ownerteam = level.zone.ownerteam;

  if(!isDefined(ownerteam)) {
    return;
  }
  if(isDefined(objweapon) && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename)) {
    return;
  }
  victim = self;
  _id_9FF9376383F4BC58 = 0;
  attackerteam = attacker.team;
  _id_229449CFD54FDC5B = attacker istouching(level.zone.trigger);
  _id_9D0123AF024E86AC = victim istouching(level.zone.trigger);

  if(attackerteam != ownerteam) {
    if(level.zonecapturetime > 0 && _id_229449CFD54FDC5B) {
      attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_470103FDE6A5E1AE");
      attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(11, 1);
    } else if(_id_9D0123AF024E86AC) {
      attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
      attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(11, 1);
      thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "defending");
    }
  } else if(_id_229449CFD54FDC5B) {
    attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
    attacker scripts\mp\utility\stats::incpersstat("defends", 1);
    attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(11, 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
    attacker scripts\mp\utility\stats::setextrascore1(attacker.pers["defends"]);
  }
}

give_capture_credit(touchlist, capturetime, _id_8C4EC3E8ADAFD3FF, lastcaptureteam, _id_22282E7D48CA3400, gameobject) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  scripts\mp\utility\game::logannouncement(_id_22282E7D48CA3400, undefined, "Hardpoint Captured", _id_22282E7D48CA3400.origin);
  _id_0666D6B1872868D7 = _id_22282E7D48CA3400;

  if(isDefined(_id_0666D6B1872868D7.owner))
    _id_0666D6B1872868D7 = _id_0666D6B1872868D7.owner;

  if(isPlayer(_id_0666D6B1872868D7)) {
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = _id_0666D6B1872868D7;
    _id_7E2C53B0BCF117D9.eventname = "capture";
    _id_7E2C53B0BCF117D9.position = _id_0666D6B1872868D7.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);

    if(isexcessivescoreboosting(_id_0666D6B1872868D7) && !scripts\mp\utility\game::isanymlgmatch()) {} else if(!isscoreboosting(_id_0666D6B1872868D7)) {
      _id_0666D6B1872868D7 thread scripts\mp\rank::scoreeventpopup("stat_E53F3D793ABCEBD3");
      _id_0666D6B1872868D7 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_194AD9A7FDB13341");
    } else {
      _id_0666D6B1872868D7 thread scripts\mp\rank::scoreeventpopup("stat_E53F3D793ABCEBD3");
      _id_0666D6B1872868D7 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2FE2061528D49F0C");
    }

    if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100) {
      _id_0666D6B1872868D7 thread scripts\mp\rank::scoreeventpopup("stat_2E7DF47FE2D0BA3A");
      _id_0666D6B1872868D7 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_4D98AED9E6EBBF28");
    }

    if(_id_0666D6B1872868D7.lastkilltime + 500 > gettime()) {} else
      _id_0666D6B1872868D7 _id_1B18A05A284D55C2::setcrankedtimerzonecap(_id_0666D6B1872868D7);
  }

  players = getarraykeys(touchlist);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = touchlist[players[_id_AC0E594AC96AA3A8]].player;
    player updatecapsperminute(lastcaptureteam);

    if(!isscoreboosting(player)) {
      player scripts\mp\utility\stats::incpersstat("captures", 1);
      player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    } else {}

    if(_id_0666D6B1872868D7 != player) {
      player thread scripts\mp\rank::scoreeventpopup("stat_971A82E17E683215");
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_7A10D07E9CC5745B");
      player _id_1B18A05A284D55C2::setcrankedtimerzonecap(player);
    }

    wait 0.05;
  }

  if(isDefined(gameobject.assisttouchlist)) {
    if(gameobject.assisttouchlist[_id_8C4EC3E8ADAFD3FF].size > 0) {
      _id_9EB80458EF362367 = getarraykeys(gameobject.assisttouchlist[_id_8C4EC3E8ADAFD3FF]);

      foreach(id in players) {
        foreach(_id_2C6D54A195121E5F in _id_9EB80458EF362367) {
          if(_id_2C6D54A195121E5F == id)
            gameobject.assisttouchlist[_id_8C4EC3E8ADAFD3FF][_id_2C6D54A195121E5F] = undefined;
        }
      }
    }

    if(gameobject.assisttouchlist[_id_8C4EC3E8ADAFD3FF].size > 0)
      gameobject thread _id_9C5C0E02B3615275(_id_8C4EC3E8ADAFD3FF);
  }
}

_id_9C5C0E02B3615275(team) {
  level endon("game_ended");
  _id_9EB80458EF362367 = getarraykeys(self.assisttouchlist[team]);

  if(_id_9EB80458EF362367.size > 0) {
    for(index = 0; index < _id_9EB80458EF362367.size; index++) {
      player = self.assisttouchlist[team][_id_9EB80458EF362367[index]].player;

      if(isDefined(player.owner))
        player = player.owner;

      if(!isPlayer(player)) {
        continue;
      }
      player scripts\mp\utility\stats::incpersstat("captures", 1);
      player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
      player thread scripts\mp\rank::scoreeventpopup("stat_971A82E17E683215");
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_7A10D07E9CC5745B");
      player _id_1B18A05A284D55C2::setcrankedtimerzonecap(player);
      self.assisttouchlist[team][_id_9EB80458EF362367[index]] = undefined;
      wait 0.05;
    }
  }
}

awardcapturepoints() {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("zone_moved");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  _id_CC748B6D457627FE = 1;
  score = 1;

  while(!level.gameended) {
    waittime = 0.0;

    while(waittime < _id_CC748B6D457627FE && !level.gameended) {
      wait(level.framedurationseconds);
      scripts\mp\hostmigration::waittillhostmigrationdone();
      waittime = waittime + level.framedurationseconds;

      if(level.zone.stalemate)
        waittime = 0.0;
    }

    team = level.zone scripts\mp\gameobjects::getownerteam();

    if(team == "neutral") {
      continue;
    }
    if(level.gameended) {
      break;
    }

    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring)
        score = level.zone.touchlist[team].size;

      scripts\mp\gamescore::giveteamscoreforobjective(team, score, 0);

      foreach(object in level.zone.touchlist[team]) {
        object.player scripts\mp\utility\stats::incpersstat("objTime", 1);
        object.player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(0, 1);
        _id_7C01E84EF860CCBD = "obj" + level.zone.trigger.script_label + "Time";

        if(isDefined(object.player.pers[_id_7C01E84EF860CCBD]))
          object.player scripts\mp\utility\stats::incpersstat(_id_7C01E84EF860CCBD, 1);

        if(isDefined(object.player.timebyrotation[level.kothhillrotation]))
          object.player.timebyrotation[level.kothhillrotation]++;
        else
          object.player.timebyrotation[level.kothhillrotation] = 1;

        object.player scripts\mp\persistence::statsetchild("round", "objTime", object.player.pers["objTime"]);
        object.player scripts\mp\utility\stats::setextrascore0(object.player.pers["objTime"]);

        if(isDefined(object.player._id_BD0FEB635EED5B60) && object.player._id_BD0FEB635EED5B60 > 3) {
          object.player._id_BD0FEB635EED5B60 = 0;

          if(scripts\mp\utility\game::getgametype() == "koth")
            object.player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_61E7451E5D97D089");
          else if(scripts\mp\utility\game::getgametype() == "grnd")
            object.player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_7E236756FB6F7C1A", undefined, 15);

          continue;
        }

        if(!isDefined(object.player._id_BD0FEB635EED5B60))
          object.player._id_BD0FEB635EED5B60 = 0;
        else
          object.player._id_BD0FEB635EED5B60++;

        object.player scripts\mp\gamescore::giveplayerscore("stat_61E7451E5D97D089", 10);
      }
    }

    if(istrue(level._id_09028202FB295D21))
      scripts\mp\gamelogic::default_ontimelimit();
  }
}

updatecapsperminute(_id_331B4141F14DF535) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(_id_331B4141F14DF535) || _id_331B4141F14DF535 == "neutral") {
    return;
  }
  self.numcaps++;
  _id_F40250902CCEBE1A = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["total"]))
    _id_F40250902CCEBE1A = self.timeplayed["total"] / 60;

  self.capsperminute = self.numcaps / _id_F40250902CCEBE1A;

  if(self.capsperminute > self.numcaps)
    self.capsperminute = self.numcaps;
}

isscoreboosting(player) {
  return isDefined(player.capsperminute) && player.capsperminute > 3;
}

isexcessivescoreboosting(player) {
  return isDefined(player.capsperminute) && player.capsperminute > 6;
}

onplayerconnect(player) {
  player._hardpointeffect = [];
  player.numcaps = 0;
  player.capsperminute = 0;
  player.timebyrotation = [];
  player scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(player.pers["objTime"]))
    player scripts\mp\utility\stats::setextrascore0(player.pers["objTime"]);

  player scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(player.pers["defends"]))
    player scripts\mp\utility\stats::setextrascore1(player.pers["defends"]);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    player thread _id_26508F2DE04C7A52::_id_8BB13AA2A5D32576(player, "mp_gametype_koth_mgl_match_introduction");

  thread onplayerspawned(player);

  foreach(zone in level.objectives) {
    if(istrue(level.usehpzonebrushes))
      zone _id_1B18A05A284D55C2::hideplayerspecificbrushes(player);
  }

  player thread refreshfreecamhardpointfx();
}

onplayerspawned(player) {
  for(;;) {
    player waittill("spawned");

    foreach(zone in level.objectives) {
      if(istrue(zone.active)) {
        if(zone.ownerteam == "neutral") {
          zone _id_1B18A05A284D55C2::playhardpointneutralfx();
          continue;
        }

        zone _id_1B18A05A284D55C2::showcapturedhardpointeffecttoplayer(zone.ownerteam, player);
      }
    }
  }
}

updateservericons(state, contested) {
  _id_CABC886D846DD979 = -1;

  if(contested)
    _id_CABC886D846DD979 = -2;
  else if(scripts\mp\utility\teams::isgameplayteam(state)) {
    player = thread getownerteamplayer(state);

    if(isDefined(player))
      _id_CABC886D846DD979 = player getentitynumber();
  } else {
    switch (state) {
      case "zone_activation_delay":
        _id_CABC886D846DD979 = -3;
        break;
      case "zone_shift":
      default:
        break;
    }
  }

  setomnvar("ui_hardpoint", _id_CABC886D846DD979);
}

getownerteamplayer(ownerteam) {
  _id_A3010F9814A40C8D = undefined;

  foreach(player in level.players) {
    if(player.team == ownerteam) {
      _id_A3010F9814A40C8D = player;
      break;
    }
  }

  return _id_A3010F9814A40C8D;
}

refreshfreecamhardpointfx() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, _id_451EE4263845EBEC);

    if(_id_7148C1A6F25491F8 == "mlg_view_change") {
      foreach(zone in level.objectives) {
        if(zone.ownerteam != "neutral")
          zone _id_1B18A05A284D55C2::showcapturedhardpointeffecttoplayer(zone.ownerteam, self);
      }
    }
  }
}

getrespawndelay() {
  if(!istrue(level.delayplayer))
    return undefined;

  if(isDefined(level.spawndelay) && level.spawndelay > 0) {
    if(isDefined(level.zone.ownerteam) && self.pers["team"] == level.zone.ownerteam)
      return level.spawndelay;
  }

  return undefined;
}

postshipmodifiedzones(_id_FE02B20F9AC0BD11) {
  if(level.mapname == "mp_fallen" && _id_FE02B20F9AC0BD11 == "5")
    return 1;

  return 0;
}

writeplayerrotationscoretomatchdataongameend() {
  level waittill("game_ended");
  writecurrentrotationteamscore();
}

writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("alliesRoundScore", level.kothhillrotation, getteamscore("allies"));
    setmatchdata("axisRoundScore", level.kothhillrotation, getteamscore("axis"));
  }
}

setkothwaypoints() {
  scripts\mp\gamelogic::setwaypointiconinfo("koth_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0, 1);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_koth", 0, 1);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_koth", 0, 1);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0, 1);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_koth", 0, 1);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_koth", 0, 1);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_next", 0, "neutral", "MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_locked", 0, 2);
  scripts\mp\gamelogic::setwaypointiconinfo("koth_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_koth", 1, 1);
}

updatematchstatushintonspawn() {
  level endon("game_ended");

  if(istrue(level.zoneislocked))
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("koth_control");
  else
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("koth_capture");
}

_id_FAB770BFE4B14E75() {
  level endon("game_ended");

  for(;;) {
    level waittill("zone_moved");
    _id_94AE9BF19D8942D9();
  }
}

_id_94AE9BF19D8942D9() {
  foreach(player in level.players)
  player scripts\mp\codcasterclientmatchdata::_id_1882F80B14421089(3, 1);
}

_id_69C581621849DF52() {
  level endon("game_ended");
  level endon("stop_contested_stats_thread");
  level endon("zone_moved");
  level endon("zone_destroyed");
  _id_413561A0123AAA35 = level.framedurationseconds;
  zone = self;

  for(;;) {
    waitframe();

    foreach(team in level.teamnamelist) {
      foreach(object in zone.touchlist[team])
      object.player scripts\mp\codcasterclientmatchdata::_id_1882F80B14421089(5, _id_413561A0123AAA35);
    }
  }
}

_id_1134D3068749D68E() {
  if(istrue(level._id_09028202FB295D21)) {
    return;
  }
  winner = scripts\mp\gamescore::gethighestscoringteam();

  if(winner != "tie") {
    scripts\mp\gamelogic::default_ontimelimit();
    return;
  }

  scripts\mp\hud_message::showerrormessagetoallplayers("MP_INGAME_ONLY/KOTH_OVERTIME_WARNING");
  level._id_09028202FB295D21 = 1;
}