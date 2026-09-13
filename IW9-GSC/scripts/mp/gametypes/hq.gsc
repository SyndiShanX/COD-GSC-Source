/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\hq.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = "hqloc";
  _id_9BBACB179DEA3237[1] = "hardpoint";
  _id_9BBACB179DEA3237[2] = "tdm";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 200);
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
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.modeonsuicidedeath = ::onsuicidedeath;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.modeonteamchangedeath = ::modeonteamchangedeath;
  level.canspawnontacinsert = ::canspawnontacinsert;
  level.onplayerjoinedteam = _id_1B18A05A284D55C2::onplayerjoinedteam;
  level.lastcaptime = gettime();
  level.usezonecapture = 1;
  level.lastcaptureteam = undefined;
  level.previousclosespawnent = undefined;
  setomnvar("ui_hq_num_alive", 0);
  setomnvar("ui_hq_ownerteam", -1);

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_mphq_mode_uktl_hqt1";
  else
    game["dialog"]["gametype"] = "iw9_mphq_mode_uktl_name";

  game["dialog"]["boost"] = "iw9_mphq_mode_uktl_bost";
  game["dialog"]["offense_obj"] = "iw9_mphq_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_mphq_mode_uktl_bost";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["hp_first"] = "iw9_mphq_mode_uktl_hqo1";
  game["dialog"]["hp_active"] = "iw9_mphq_mode_uktl_hqoa";
  game["dialog"]["hp_new_location"] = "iw9_mphq_mode_uktl_hqnl";
  game["dialog"]["hp_captured_enemy"] = "iw9_mphq_mode_uktl_hqec";
  game["dialog"]["hp_captured_friendly"] = "iw9_mphq_mode_uktl_hqfc";
  game["dialog"]["hp_contested"] = "iw9_mphq_mode_uktl_hqct";
  game["dialog"]["hp_move_soon"] = "iw9_mphq_mode_uktl_hqmv";
  game["dialog"]["hp_capturing_enemy"] = "iw9_mphq_mode_uktl_ecip";
  game["dialog"]["hp_capturing_friendly"] = "iw9_mphq_mode_uktl_fcip";
  game["dialog"]["hp_lost"] = "iw9_mphq_mode_uktl_hqls";
  game["dialog"]["hp_timeout"] = "iw9_mphq_mode_uktl_hqto";
  game["dialog"]["hp_secured_friendly"] = "iw9_mphq_mode_uktl_hqsc";
  game["dialog"]["hp_owned_lost"] = "iw9_mphq_mode_uktl_hqds";
  game["dialog"]["hp_disabling_enemy"] = "iw9_mphq_mode_uktl_hqed";
  game["dialog"]["hp_disabling_friendly"] = "iw9_mphq_mode_uktl_hqfd";
  game["dialog"]["hp_dead"] = "iw9_mphq_mode_uktl_hqde";
  thread writeplayerrotationscoretomatchdataongameend();
  level._effect["hq_explode"] = loadfx("vfx/iw8_mp/gamemode/vfx_hq_box_destroy.vfx");
  level.nosuspensemusic = 1;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_hq_zonetimeout", getmatchrulesdata("hqData", "zoneTimeout"));
  setdynamicdvar("scr_hq_zonelifetime", getmatchrulesdata("hqData", "zoneLifetime"));
  setdynamicdvar("scr_hq_zonecapturetime", getmatchrulesdata("hqData", "zoneCaptureTime"));
  setdynamicdvar("scr_hq_firstzoneactivationdelay", getmatchrulesdata("hqData", "firstZoneActivationDelay"));
  setdynamicdvar("scr_hq_zoneactivationdelay", getmatchrulesdata("hqData", "zoneActivationDelay"));
  setdynamicdvar("scr_hq_zoneselectiondelay", getmatchrulesdata("hqData", "zoneSelectionDelay"));
  setdynamicdvar("scr_hq_randomlocationorder", getmatchrulesdata("hqData", "randomLocationOrder"));
  setdynamicdvar("scr_hq_additivescoring", getmatchrulesdata("hqData", "additiveScoring"));
  setdynamicdvar("scr_hq_pausetime", getmatchrulesdata("hqData", "pauseTime"));
  setdynamicdvar("scr_hq_delayplayer", getmatchrulesdata("hqData", "delayPlayer"));
  setdynamicdvar("dvar_DE9A33B73874157D", 0);
  scripts\mp\utility\game::registerhalftimedvar("hq", 0);
}

onstartgametype() {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/HQ");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/HQ");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/HQ_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/HQ_HINT");
  }

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  setclientnamemode("auto_change");
  level thread setupzones();
  _id_01D539DA0CAD6AC0();
  initspawns();
  seticonnames();

  if(!level.zonerandomlocationorder)
    remaphardpointorder();

  level thread hqmainloop();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.zonetimeout = scripts\mp\utility\dvars::dvarfloatvalue("zoneTimeout", 60, 0, 300);
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.firstzoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("firstZoneActivationDelay", 30, 0, 120);
  level.zoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("zoneActivationDelay", 30, 0, 120);
  level.zoneselectiondelay = scripts\mp\utility\dvars::dvarfloatvalue("zoneSelectionDelay", 15, 0, 120);
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("randomLocationOrder", 1, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("additiveScoring", 0, 0, 1);
  level.pausemodetimer = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 0, 0, 1);
}

hqmainloop() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  setomnvar("ui_hq_status", -1);
  level.zone = getfirstzone();
  _id_2AFAF68657598B47 = 1;
  level.kothhillrotation = 0;
  level.zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  level.zone _id_1B18A05A284D55C2::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone scripts\mp\gameobjects::setvisibleteam("any");
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
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
    level thread waitthenshowfirsthqsplash();
    _id_570BA02607C0425C = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 1);
    level thread waitthenplaynewobj();
    level.zone thread scripts\mp\gameobjects::_id_D36DCACAC1708708(level.firstzoneactivationdelay);
    wait(level.firstzoneactivationdelay);
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(7, "free");
  }

  setomnvar("ui_objective_timer_stopped", 0);

  for(;;) {
    if(!isDefined(level.mapcalloutsready))
      level thread setupzonecallouts();

    level.objectivesetorder = 1;
    waittillframeend;

    if(!_id_570BA02607C0425C) {
      foreach(player in level.players)
      scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, player);
    }

    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled)
      level.zone thread _id_1B18A05A284D55C2::trackgametypevips();

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(_id_570BA02607C0425C, _id_2AFAF68657598B47);
    _id_2AFAF68657598B47 = 0;
    _id_570BA02607C0425C = 0;
    setomnvar("ui_hq_status", 2);
    scripts\mp\spawnlogic::clearlastteamspawns();
    level.zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_open");
    level.zone.visuals[0] playLoopSound("mp_buy_station_attract_lp");
    hpcaptureloop();
    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
    setomnvar("ui_hq_ownerteam", 0);
    level.spectateoverride[game["attackers"]].allowenemyspectate = 0;
    level.spectateoverride[game["defenders"]].allowenemyspectate = 0;
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
    level.zone _id_1B18A05A284D55C2::deactivatezone();
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "hq_capture", "hq_capture");
    setomnvar("ui_hq_status", 5);
    zoneselectiondelay = int(gettime() + level.zoneselectiondelay * 1000 + 500);
    setomnvar("ui_hardpoint_timer", zoneselectiondelay);

    if(level.zoneselectiondelay > 0) {
      if(level.pausemodetimer)
        level scripts\mp\gamelogic::pausetimer();

      scripts\mp\spawnlogic::setactivespawnlogic("HQTDM", "Crit_Frontline", 1);
      level.usetdmspawns = 1;
    }

    thread forcespawnplayers();
    wait(level.zoneselectiondelay);

    if(!istrue(level.adjustshipmentspawns)) {
      scripts\mp\spawnlogic::deactivatespawnset("normal");
      level.usetdmspawns = undefined;
      scripts\mp\spawnlogic::setactivespawnlogic("Hardpoint", "Crit_Default");
    }

    spawn_next_zone();
    wait 0.5;
  }
}

waitthenplaynewobj() {
  if(istrue(level.infilvotiming))
    wait 8.5;
  else
    wait 6.0;

  foreach(_id_F90358454413407F in level.teamnamelist)
  scripts\mp\utility\dialog::statusdialog("hp_first", _id_F90358454413407F);
}

waitthenshowfirsthqsplash() {
  if(istrue(level.infilvotiming))
    wait 6.5;
  else
    wait 5.5;

  level thread scripts\mp\hud_message::notifyteam("hq_located", "hq_located", "allies");
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
    default:
      break;
  }
}

getfirstzone() {
  if(isDefined(level.remappedhpzoneorder)) {
    zone = level.objectives[level.remappedhpzoneorder[0]];
    level.prevzoneindex = 0;
  } else {
    zone = level.objectives["1"];
    level.prevzoneindex = 1;
  }

  return zone;
}

getnextzone() {
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
  } else {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.objectives.size)
      level.prevzoneindex = 1;

    zone = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
  }

  return zone;
}

spawn_next_zone() {
  writecurrentrotationteamscore();
  level.zone = getnextzone();
  level.kothhillrotation++;
  level.zone resetzone();
  level.zone _id_1B18A05A284D55C2::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone.lastactivatetime = gettime();

  if(level.zoneactivationdelay > 0)
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  else
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = level.zone;
  _id_7E2C53B0BCF117D9.eventname = "hill_moved";
  _id_7E2C53B0BCF117D9.position = level.zone.trigger.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
}

resetzone() {
  self.lastclaimteam = "none";
  self.lastprogressteam = "none";
  self.ownerteam = "neutral";
  self.prevownerteam = "neutral";
  self.curprogress = 0;
  teams = getarraykeys(self.teamprogress);

  foreach(team in teams)
  self.teamprogress[team] = 0;

  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, undefined);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
}

hqactivatenextzone(_id_570BA02607C0425C, _id_2AFAF68657598B47) {
  if(!_id_2AFAF68657598B47 && level.zoneselectiondelay > 5 && level.zoneactivationdelay > 5) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("hp_new_location", _id_F90358454413407F);
  }

  if(isDefined(level.zone.curorigin))
    playsoundatpos(level.zone.curorigin, "mp_hq_activate_sfx");

  level.zone thread _id_1B18A05A284D55C2::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("none");

  if(istrue(_id_570BA02607C0425C)) {} else if(level.zoneactivationdelay) {
    level thread scripts\mp\hud_message::notifyteam("hq_located", "hq_located", "allies");
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("zone_activation_delay", 0);
    waitframe();
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 1);

    if(level.pausemodetimer)
      level scripts\mp\gamelogic::pausetimer();

    level.zone thread scripts\mp\gameobjects::_id_D36DCACAC1708708(level.zoneactivationdelay);
    wait(level.zoneactivationdelay);
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(7, "free");
  }

  foreach(_id_F90358454413407F in level.teamnamelist)
  scripts\mp\utility\dialog::statusdialog("hp_active", _id_F90358454413407F);

  level thread scripts\mp\hud_message::notifyteam("hq_capture", "hq_capture", "allies");

  if(level.pausemodetimer)
    level scripts\mp\gamelogic::resumetimer();

  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  updateservericons("neutral", 0);

  if(level.zoneduration) {
    updateservericons("neutral", 0);

    if(level.zonetimeout == 0)
      thread locktimeruntilcap();
    else {
      timeout = level.zonetimeout;
      thread movezoneaftertime(timeout);
      level.zoneendtime = int(gettime() + 1000 * timeout);
      setomnvar("ui_hardpoint_timer", level.zoneendtime);
    }
  } else
    level.zonedestroyedbytimer = 0;
}

locktimeruntilcap() {
  level endon("zone_captured");

  for(;;) {
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    waitframe();
  }
}

hpcaptureloop() {
  level endon("game_ended");
  level endon("zone_moved");
  level.hpstarttime = gettime();

  for(;;) {
    level.zone scripts\mp\gameobjects::allowuse("enemy");
    level.zone scripts\mp\gameobjects::setvisibleteam("any");
    level.zone scripts\mp\gameobjects::setusetext(&"MP/SECURING_POSITION");

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime)
      level thread _id_0C5CC3D0D9E62A6D::randomdrops();

    msg = level scripts\engine\utility::waittill_any_return_2("zone_captured", "zone_destroyed");

    if(msg == "zone_destroyed")
      continue;
    else {
      level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
      setomnvar("ui_hardpoint_timer", level.zoneendtime);
      setomnvar("ui_hq_status", 3);
    }

    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
    thread updaterespawntimer();

    if(level.zoneduration > 0)
      thread movezoneaftertime(level.zoneduration);

    if(level.zonecapturetime > 0) {
      _id_4725E52B7C3AA25C = scripts\mp\utility\teams::getteamdata(ownerteam, "players");
      player = scripts\mp\utility\teams::getfriendlyplayers(ownerteam, 0)[0];
      level thread scripts\mp\hud_message::notifyteam("hq_captured", "hq_destroy", ownerteam, _id_4725E52B7C3AA25C, undefined, undefined, player);
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(ownerteam, "hq_defend", "hq_detroy");
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(8, ownerteam);
    level waittill("zone_destroyed", _id_35216C18F7998623);
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(9, "free");

    if(level.zonecapturetime > 0) {
      enemyteam = scripts\mp\utility\game::getotherteam(ownerteam)[0];
      player = scripts\mp\utility\teams::getfriendlyplayers(enemyteam, 0)[0];
      level thread scripts\mp\hud_message::notifyteam("hq_destroyed", "hq_destroyed", enemyteam, undefined, undefined, undefined, player);
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "hq_capture", "hq_capture");
    level.spawndelay = undefined;

    if(isDefined(_id_35216C18F7998623))
      level.zone scripts\mp\gameobjects::setownerteam(_id_35216C18F7998623);
    else
      level.zone scripts\mp\gameobjects::setownerteam("none");

    setomnvar("ui_hardpoint_timer", 0);
    setomnvar("ui_hq_status", -1);
    break;
  }
}

updaterespawntimer() {
  level endon("game_ended");
  level endon("zone_moved");
  level endon("zone_destroyed");
  starttime = gettime();

  if(level.zoneduration > 0)
    endtime = starttime + level.zoneduration * 1000;
  else
    endtime = starttime + scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();

  currenttime = starttime;

  while(currenttime < endtime) {
    currenttime = gettime();
    level.spawndelay = (endtime - currenttime) / 1000 + 0.1;
    waitframe();
  }
}

initspawns() {
  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0)
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default", 1);
  else
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline", 1);

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
  _id_3C9C79460E7AEE38 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn");
  _id_3D83BC62B320D11A = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_3C9C79460E7AEE38);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3D83BC62B320D11A);
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

  foreach(spawnpoint in level.spawnpoints) {
    _id_F2D96DD81CF63446 = scripts\mp\spawnlogic::getoriginidentifierstring(spawnpoint);

    if(isDefined(level.kothextraprimaryspawnpoints) && isDefined(level.kothextraprimaryspawnpoints[_id_F2D96DD81CF63446])) {
      foreach(_id_FE02B20F9AC0BD11 in level.kothextraprimaryspawnpoints[_id_F2D96DD81CF63446]) {
        zone = level.objectives[_id_FE02B20F9AC0BD11];
        zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
      }
    }

    _id_BA992CB19CB03B0C = 0;
    _id_47D8F0FD833CA536 = spawnpoint.classname == "mp_koth_spawn_allies_start" || spawnpoint.classname == "mp_koth_spawn_axis_start";
    _id_E07D09F62CC34AC2 = spawnpoint.classname == "mp_koth_spawn";
    _id_F87FC0E5455ED600 = spawnpoint.classname == "mp_koth_spawn_secondary";
    _id_A666D6DB6A2D192B = spawnpoint.classname == "mp_tdm_spawn";
    _id_0F319D19AC241195 = spawnpoint.classname == "mp_tdm_spawn_secondary";
    _id_AA5C00F4CC732317 = [];

    if(_id_47D8F0FD833CA536) {
      continue;
    }
    if(_id_E07D09F62CC34AC2 || _id_F87FC0E5455ED600) {
      if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "") {
        _id_BA992CB19CB03B0C = 1;
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

    if(!_id_BA992CB19CB03B0C && !_id_A666D6DB6A2D192B && !_id_0F319D19AC241195) {
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

postshipmodifiedzones(_id_FE02B20F9AC0BD11) {
  if(level.mapname == "mp_fallen" && _id_FE02B20F9AC0BD11 == "5")
    return 1;

  return 0;
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
    dist = getpathdist(spawnpoint.origin, zone.trigger.origin, 5000);

    if(dist < 0)
      dist = scripts\engine\utility::distance_2d_squared(spawnpoint.origin, zone.trigger.origin);
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
  _id_261D73DEE9F7F35C = getzonearray("hardpoint_zone");
  _id_261D73DEE9F7F35C = fixuptrigspostship(_id_261D73DEE9F7F35C);
  _id_46CE466CCA5FCAFE = [];
  _id_28DB8BB739011E7C = 0;
  radios = getEntArray("hqloc", "targetname");
  visuals = [];

  if(_id_261D73DEE9F7F35C.size != radios.size) {
    _id_46CE466CCA5FCAFE[_id_46CE466CCA5FCAFE.size] = "Number of hqloc Radios and hardpoint_zone triggers are not equal";
    _id_28DB8BB739011E7C = 1;

    foreach(trig in _id_261D73DEE9F7F35C) {
      _id_AD440E7908375FD4 = 0;

      foreach(radio in radios) {
        if(_id_42779A4DC0BB2A33(radio, trig)) {
          _id_AD440E7908375FD4 = 1;
          break;
        }
      }

      if(!_id_AD440E7908375FD4)
        _id_46CE466CCA5FCAFE[_id_46CE466CCA5FCAFE.size] = "hardpoint_zone: " + trig.script_label + " has no hqloc radio inside it";
    }
  }

  level.objectives = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < radios.size; _id_AC0E594AC96AA3A8++) {
    radio = radios[_id_AC0E594AC96AA3A8];
    trig = undefined;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_261D73DEE9F7F35C.size; _id_AC0E5C4AC96AAA41++) {
      if(_id_42779A4DC0BB2A33(radio, _id_261D73DEE9F7F35C[_id_AC0E5C4AC96AAA41])) {
        if(isDefined(trig)) {
          _id_46CE466CCA5FCAFE[_id_46CE466CCA5FCAFE.size] = "Radio at " + radio.origin + " is touching more than one \"hardpoint_zone\" trigger";
          _id_28DB8BB739011E7C = 1;
          break;
        }

        trig = _id_261D73DEE9F7F35C[_id_AC0E5C4AC96AAA41];
        break;
      }
    }

    if(!isDefined(trig)) {
      if(!_id_28DB8BB739011E7C) {
        _id_46CE466CCA5FCAFE[_id_46CE466CCA5FCAFE.size] = "Radio at " + radio.origin + " is not inside any \"hardpoint_zone\" trigger";
        _id_28DB8BB739011E7C = 1;
        continue;
      }
    }

    visuals = [];
    visuals[0] = radio;
    _id_C236336A4B27E7DA = getEntArray(radio.target, "targetname");

    for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < _id_C236336A4B27E7DA.size; _id_AC0E5B4AC96AA80E++)
      visuals[visuals.size] = _id_C236336A4B27E7DA[_id_AC0E5B4AC96AA80E];

    zone = _id_1B18A05A284D55C2::setupobjective(trig, visuals);
    level.objectives[zone.objectivekey] = zone;
  }

  if(_id_46CE466CCA5FCAFE.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_46CE466CCA5FCAFE.size; _id_AC0E594AC96AA3A8++) {}
  } else {
    _id_7FC4B3DB1868930F = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
    _id_99A20728731AC0B0 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
    level.startpos["allies"] = _id_99A20728731AC0B0[0].origin;
    level.startpos["axis"] = _id_7FC4B3DB1868930F[0].origin;
  }
}

fixuptrigspostship(triggers) {
  mapname = getDvar("ui_mapname");

  if(mapname == "mp_m_cornfield") {
    foreach(trig in triggers) {
      trig.origin = trig.origin - (0, 0, 9);

      if(isDefined(trig.script_label) && trig.script_label == "2") {
        trig.origin = trig.origin - (0, 0, 9);
        continue;
      }

      if(isDefined(trig.script_label) && trig.script_label == "3")
        trig.origin = trig.origin - (0, 0, 9);
    }
  }

  return triggers;
}

_id_01D539DA0CAD6AC0(triggers) {
  mapname = getDvar("ui_mapname");

  if(mapname == "mp_harbor") {
    level.objectives["5"].visuals[0].origin = level.objectives["5"].visuals[0].origin - (0, 0, 8);
    level.objectives["5"].visuals[1].origin = level.objectives["5"].visuals[1].origin - (0, 0, 8);
  }
}

_id_42779A4DC0BB2A33(_id_CE363C78F58A54DE, trigger) {
  mapname = getDvar("ui_mapname");

  if(mapname == "mp_shoothouse2")
    return _id_CE363C78F58A54DE istouching(trigger) || ispointinvolume(_id_CE363C78F58A54DE.origin + (0, 0, 14), trigger);

  return _id_CE363C78F58A54DE istouching(trigger);
}

setupzonecallouts() {
  _id_49996EBEBBBBF375 = undefined;
  _id_CA8C1EF349B1092F = undefined;
  _id_E73FCC890C2D1002 = undefined;
  zonetrigger = level.zone.visuals[0];

  foreach(_id_C1E5E178D5D956E4 in level.calloutglobals.areatriggers) {
    _id_CA8C1EF349B1092F = ispointinvolume(zonetrigger.baseorigin, _id_C1E5E178D5D956E4);
    _id_E73FCC890C2D1002 = isDefined(zonetrigger.script_noteworthy) && isDefined(_id_C1E5E178D5D956E4.script_noteworthy) && zonetrigger.script_noteworthy == _id_C1E5E178D5D956E4.script_noteworthy;

    if(_id_CA8C1EF349B1092F || _id_E73FCC890C2D1002) {
      _id_49996EBEBBBBF375 = level.calloutglobals.areaidmap[_id_C1E5E178D5D956E4.script_noteworthy];
      setomnvar("ui_hp_callout_id", _id_49996EBEBBBBF375);
      break;
    }
  }

  _id_548072087C9FD504::_id_7D42D3F8DD68280C(6, "free");
}

forcespawnplayers() {
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(!isDefined(player) || istrue(player.fauxdead) && player scripts\mp\utility\player::isusingremote() || isalive(player) && !istrue(player.fauxdead)) {
      continue;
    }
    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, player);
    player notify("force_spawn");
    waitframe();
  }

  thread _id_7F5BCC4009C143BD();
}

_id_7F5BCC4009C143BD() {
  wait 3;
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(player scripts\mp\utility\player::isinkillcam()) {
      player thread _id_2FB169121F027CCC();
      continue;
    } else if(!isDefined(player) || istrue(player.fauxdead) && player scripts\mp\utility\player::isusingremote() || isalive(player) && !istrue(player.fauxdead)) {
      continue;
    }
    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, player);
    player notify("force_spawn");
    waitframe();
  }
}

_id_2FB169121F027CCC() {
  level endon("game_ended");
  self endon("spawned");

  while(scripts\mp\utility\player::isinkillcam())
    wait 0.1;

  wait 1;
  self notify("force_spawn");
}

getspawnpoint() {
  spawnteam = self.pers["team"];
  _id_2FA17BAEFE0FA286 = getkothzonedeadzonedist();
  _id_BA0A9FD614A3F6EE = [];
  _id_BA0A9FD614A3F6EE["activeKOTHZoneNumber"] = level.zone.trigger getentitynumber();
  _id_BA0A9FD614A3F6EE["maxSquaredDistToObjective"] = level.zone.furthestspawndistsq;
  _id_BA0A9FD614A3F6EE["kothZoneDeadzoneDistSq"] = _id_2FA17BAEFE0FA286 * _id_2FA17BAEFE0FA286;
  _id_BA0A9FD614A3F6EE["closestEnemyInfluenceDistSq"] = 12250000;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else if(istrue(level.usetdmspawns)) {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "fallback");
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.zone.spawnset, level.zone.fallbackspawnset, "bad", _id_BA0A9FD614A3F6EE);

  return spawnpoint;
}

getkothzonedeadzonedist() {
  if(!istrue(level.zone.active))
    return 2000;
  else
    return 1000;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  self setclientomnvar("ui_hq_norespawn", 0);

  if(isDefined(level.zone) && isDefined(level.zone.ownerteam) && level.zone.ownerteam != "neutral")
    setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(level.zone.ownerteam, "aliveCount"));

  self.forcespawnnearteammates = undefined;
  self.skipspawncamera = undefined;
  thread updatematchstatushintonspawn();
}

movezoneaftertime(time) {
  level notify("startMoveTimer");
  level endon("startMoveTimer");
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level.zonemovetime = time;
  level.zonedestroyedbytimer = 0;
  _id_1B18A05A284D55C2::zonetimerwait();
  level.zonedestroyedbytimer = 1;

  if(level.zoneselectiondelay + level.zoneactivationdelay > 5) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("hp_timeout", _id_F90358454413407F);
  }

  _id_548072087C9FD504::_id_7D42D3F8DD68280C(9, "free");
  level notify("zone_moved");
  level notify("zone_destroyed");
}

onsuicidedeath(victim) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(victim.team, "aliveCount"));
}

modeonteamchangedeath(player) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(player.leaving_team, "aliveCount"));
}

canspawnontacinsert(player) {
  _id_A3036EBEE981194E = level.zone.ownerteam == player.team;
  return !_id_A3036EBEE981194E;
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  ownerteam = level.zone.ownerteam;

  if(!isPlayer(attacker) || attacker.team == self.team) {
    if(ownerteam != "neutral")
      self.skipspawncamera = 1;

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

  if(ownerteam != "neutral")
    level updatehqaliveomnvars(ownerteam);

  if(ownerteam == victim.team)
    victim.skipspawncamera = 1;

  if(level.zone.active) {
    if(level.zonecapturetime > 0 && attacker istouching(level.zone.trigger)) {
      if(ownerteam != attackerteam)
        _id_9FF9376383F4BC58 = 1;
    }

    if(attackerteam != ownerteam) {
      if(_id_9FF9376383F4BC58)
        attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_470103FDE6A5E1AE");
      else if(victim istouching(level.zone.trigger)) {
        attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
        thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "defending");
      }
    } else if(attacker istouching(level.zone.trigger)) {
      attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
      attacker scripts\mp\utility\stats::incpersstat("defends", 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      attacker scripts\mp\utility\stats::setextrascore1(attacker.pers["defends"]);
    }
  }

  thread checkallowspectating();
}

checkallowspectating() {
  if(level.zone.ownerteam == "neutral") {
    return;
  }
  if(!scripts\mp\utility\teams::getteamdata(level.zone.ownerteam, "aliveCount")) {
    level.spectateoverride[level.zone.ownerteam].allowenemyspectate = 1;
    scripts\mp\spectating::updatespectatesettings();
  }
}

updatehqaliveomnvars(ownerteam) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(ownerteam, "aliveCount"));
}

give_capture_credit(touchlist, capturetime, _id_8C4EC3E8ADAFD3FF, lastcaptureteam, _id_22282E7D48CA3400, _id_886CDE1EF52223C3) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  _id_0666D6B1872868D7 = _id_22282E7D48CA3400;

  if(isDefined(_id_0666D6B1872868D7.owner))
    _id_0666D6B1872868D7 = _id_0666D6B1872868D7.owner;

  if(isPlayer(_id_0666D6B1872868D7)) {
    if(!isscoreboosting(_id_0666D6B1872868D7)) {
      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9.player = _id_0666D6B1872868D7;
      _id_7E2C53B0BCF117D9.eventname = "capture";
      _id_7E2C53B0BCF117D9.position = _id_0666D6B1872868D7.origin;
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
      _id_0666D6B1872868D7 thread scripts\mp\rank::scoreeventpopup("stat_CBCB83B1A39C5C8E");
      _id_0666D6B1872868D7 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_194AD9A7FDB13341");

      if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100)
        _id_0666D6B1872868D7 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_4D98AED9E6EBBF28");

      if(_id_0666D6B1872868D7.lastkilltime + 500 > gettime()) {} else
        _id_0666D6B1872868D7 _id_1B18A05A284D55C2::setcrankedtimerzonecap(_id_0666D6B1872868D7);
    }
  }

  players = getarraykeys(touchlist);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = touchlist[players[_id_AC0E594AC96AA3A8]].player;
    player updatecapsperminute(lastcaptureteam);

    if(!isscoreboosting(player)) {
      player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
      player scripts\mp\utility\stats::incpersstat("captures", 1);
      player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
      player scripts\mp\utility\stats::setextrascore0(player.pers["captures"]);
    } else {}

    wait 0.05;
  }

  if(isDefined(_id_886CDE1EF52223C3.assisttouchlist)) {
    if(_id_886CDE1EF52223C3.assisttouchlist[_id_8C4EC3E8ADAFD3FF].size > 0) {
      _id_9EB80458EF362367 = getarraykeys(_id_886CDE1EF52223C3.assisttouchlist[_id_8C4EC3E8ADAFD3FF]);

      foreach(id in players) {
        foreach(_id_2C6D54A195121E5F in _id_9EB80458EF362367) {
          if(_id_2C6D54A195121E5F == id)
            _id_886CDE1EF52223C3.assisttouchlist[_id_8C4EC3E8ADAFD3FF][_id_2C6D54A195121E5F] = undefined;
        }
      }
    }

    if(_id_886CDE1EF52223C3.assisttouchlist[_id_8C4EC3E8ADAFD3FF].size > 0)
      _id_886CDE1EF52223C3 thread _id_11CE247555FB7A20(_id_8C4EC3E8ADAFD3FF);
  }
}

_id_11CE247555FB7A20(team) {
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
      player scripts\mp\utility\stats::setextrascore0(player.pers["captures"]);
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
    for(waittime = 0.0; waittime < _id_CC748B6D457627FE; waittime = waittime + level.framedurationseconds) {
      wait(level.framedurationseconds);
      scripts\mp\hostmigration::waittillhostmigrationdone();
    }

    team = level.zone scripts\mp\gameobjects::getownerteam();

    if(team == "neutral") {
      continue;
    }
    if(level.zoneadditivescoring)
      score = level.zone.touchlist[team].size;

    scripts\mp\gamescore::giveteamscoreforobjective(team, score, 0);

    if(!istrue(level.scoreleadchanged))
      adjustmatchtimerpausedstatefromleadchange(team);
  }
}

adjustmatchtimerpausedstatefromleadchange(team) {
  if(!level.pausemodetimer) {
    return;
  }
  _id_E3F1A73A39054069 = scripts\mp\gamescore::_getteamscore(team);
  _id_AC865A705B3E1162 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(team)[0]);

  if(_id_E3F1A73A39054069 > _id_AC865A705B3E1162) {
    level.scoreleadchanged = 1;
    level scripts\mp\gamelogic::resumetimer();
  } else
    level scripts\mp\gamelogic::pausetimer();
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

onplayerconnect(player) {
  player setclientomnvar("ui_hq_norespawn", 0);
  player._hardpointeffect = [];
  player.numcaps = 0;
  player.capsperminute = 0;
  player.timebyrotation = [];
  player scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(player.pers["captures"]))
    player scripts\mp\utility\stats::setextrascore0(player.pers["captures"]);

  player scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(player.pers["defends"]))
    player scripts\mp\utility\stats::setextrascore1(player.pers["defends"]);

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

gethqownerteamvalue(ownerteam) {
  if(ownerteam == "allies")
    _id_CABC886D846DD979 = 2;
  else if(ownerteam == "axis")
    _id_CABC886D846DD979 = 1;
  else
    _id_CABC886D846DD979 = 0;

  return _id_CABC886D846DD979;
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

  ownerteam = level.zone.ownerteam;

  if(isDefined(ownerteam)) {
    if(self.pers["team"] == ownerteam) {
      if(!level.spawndelay)
        return undefined;

      return level.spawndelay;
    }
  }
}

updatematchstatushintonspawn() {
  level endon("game_ended");

  if(isDefined(level.zone)) {
    if(isDefined(level.zone.ownerteam)) {
      if(level.zone.ownerteam == "neutral")
        scripts\mp\hud_message::_id_F004EF4606B9EFDC("hq_capture");
      else if(level.zone.ownerteam == self.team)
        scripts\mp\hud_message::_id_F004EF4606B9EFDC("hq_defend");
      else
        scripts\mp\hud_message::_id_F004EF4606B9EFDC("hq_detroy");
    }
  }
}

showrespawnwarningmessage() {
  self endon("death_or_disconnect");
  self setclientomnvar("ui_hq_norespawn", 1);
  scripts\mp\utility\sound::playsoundonplayers("mp_hq_respawn_disabled");
  wait 5;
  self setclientomnvar("ui_hq_norespawn", 0);
}

seticonnames() {
  level.icontarget = "hq_target";
  level.iconneutral = "hq_neutral";
  level.iconcapture = "hq_destroy";
  level.icondefend = "hq_defend";
  level.iconcontested = "hq_contested";
  level.icontaking = "hq_taking";
  level.iconlosing = "hq_losing";
  level.icondefending = "hq_defending";
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