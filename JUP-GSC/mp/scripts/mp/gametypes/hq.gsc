/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\hq.gsc
***********************************************/

#using script_4a6760982b403bad;
#using script_548072087c9fd504;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\callouts;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\escort_horde;
#using scripts\mp\gametypes\grnd;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace hq;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = "hqloc";
  allowed[1] = "hardpoint";
  allowed[2] = "tdm";
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registertimelimitdvar(getgametype(), 300);
    registerscorelimitdvar(getgametype(), 200);
    registerroundlimitdvar(getgametype(), 1);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
  }

  updategametypedvars();
  level.hpstarttime = 0;
  level.scoreperplayer = undefined;
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.getspawnpoint = &getspawnpoint;
  level.modeonspawnplayer = &onspawnplayer;
  level.modeonsuicidedeath = &onsuicidedeath;
  level.onplayerkilled = &onplayerkilled;
  level.onrespawndelay = &getrespawndelay;
  level.modeonteamchangedeath = &modeonteamchangedeath;
  level.canspawnontacinsert = &canspawnontacinsert;
  level.onplayerjoinedteam = &scripts\mp\gametypes\obj_zonecapture::onplayerjoinedteam;
  level.lastcaptime = gettime();
  level.usezonecapture = 1;
  level.lastcaptureteam = undefined;
  level.previousclosespawnent = undefined;
  setomnvar("ui_hq_num_alive", 0);
  setomnvar("ui_hq_ownerteam", -1);

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    game["dialog"]["gametype"] = "dx_mp_hqhc_mode_t141_name";
  } else {
    game["dialog"]["gametype"] = "dx_mp_head_game_uktl_name";
  }

  game["dialog"]["boost"] = "dx_mp_head_game_uktl_bost";
  game["dialog"]["offense_obj"] = "dx_mp_head_game_uktl_bost";
  game["dialog"]["defense_obj"] = "dx_mp_head_game_uktl_bost";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["hp_first"] = "dx_mp_head_game_uktl_hqo1";
  game["dialog"]["hp_active"] = "dx_mp_head_game_uktl_hqoa";
  game["dialog"]["hp_new_location"] = "dx_mp_head_game_uktl_hqnl";
  game["dialog"]["hp_captured_enemy"] = "dx_mp_head_game_uktl_hqec";
  game["dialog"]["hp_captured_friendly"] = "dx_mp_head_game_uktl_hqfc";
  game["dialog"]["hp_contested"] = "dx_mp_head_game_uktl_hqct";
  game["dialog"]["hp_move_soon"] = "dx_mp_head_game_uktl_hqmv";
  game["dialog"]["hp_capturing_enemy"] = "dx_mp_head_game_uktl_ecip";
  game["dialog"]["hp_capturing_friendly"] = "dx_mp_head_game_uktl_fcip";
  game["dialog"]["hp_lost"] = "dx_mp_head_game_uktl_hqls";
  game["dialog"]["hp_timeout"] = "dx_mp_head_game_uktl_hqto";
  game["dialog"]["hp_secured_friendly"] = "dx_mp_head_game_uktl_hqsc";
  game["dialog"]["hp_owned_lost"] = "dx_mp_head_game_uktl_hqds";
  game["dialog"]["hp_disabling_enemy"] = "dx_mp_head_game_uktl_hqed";
  game["dialog"]["hp_disabling_friendly"] = "dx_mp_head_game_uktl_hqfd";
  game["dialog"]["hp_dead"] = "dx_mp_head_game_uktl_hqde";
  thread writeplayerrotationscoretomatchdataongameend();
  level._effect["hq_explode"] = loadfx("vfx/iw8_mp/gamemode/vfx_hq_box_destroy.vfx");
  level.nosuspensemusic = 1;
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(function_3514ae5d09f47ed2("zoneTimeout"), getmatchrulesdata("hqData", "zoneTimeout"));
  setdynamicdvar(function_3514ae5d09f47ed2("zoneLifetime"), getmatchrulesdata("hqData", "zoneLifetime"));
  setdynamicdvar(function_3514ae5d09f47ed2("zoneCaptureTime"), getmatchrulesdata("hqData", "zoneCaptureTime"));
  setdynamicdvar(function_3514ae5d09f47ed2("firstZoneActivationDelay"), getmatchrulesdata("hqData", "firstZoneActivationDelay"));
  setdynamicdvar(function_3514ae5d09f47ed2("zoneActivationDelay"), getmatchrulesdata("hqData", "zoneActivationDelay"));
  setdynamicdvar(function_3514ae5d09f47ed2("zoneSelectionDelay"), getmatchrulesdata("hqData", "zoneSelectionDelay"));
  setdynamicdvar(function_3514ae5d09f47ed2("randomLocationOrder"), getmatchrulesdata("hqData", "randomLocationOrder"));
  setdynamicdvar(function_3514ae5d09f47ed2("additiveScoring"), getmatchrulesdata("hqData", "additiveScoring"));
  setdynamicdvar(function_3514ae5d09f47ed2("pauseTime"), getmatchrulesdata("hqData", "pauseTime"));
  setdynamicdvar(function_3514ae5d09f47ed2("delayPlayer"), getmatchrulesdata("hqData", "delayPlayer"));
  setdynamicdvar(function_3514ae5d09f47ed2("halftime"), 0);
  registerhalftimedvar(getgametype(), 0);
}

function onstartgametype() {
  if(ismutationgamemode()) {
    scripts\mp\gametypes\escort_horde::function_f9c27bb7f1c4fedc();
  }

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/HQ");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/HQ");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/HQ_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/HQ_HINT");
  }

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  setclientnamemode("auto_change");
  level thread setupzones();
  initspawns();
  seticonnames();

  if(!level.zonerandomlocationorder) {
    remaphardpointorder();
  }

  level thread hqmainloop();

  level thread function_1f98c5616d8b3d67();
  level thread function_bed0f399bee034f8();
  level thread function_ef4f5aa9c42838b2();
  level thread function_be67fb2ebcca86d1();
  level thread function_b4c2563f73b02c80();
}

function updategametypedvars() {
  updatecommongametypedvars();
  level.zonetimeout = dvarfloatvalue("zoneTimeout", 60, 0, 300);
  level.zoneduration = dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.firstzoneactivationdelay = dvarfloatvalue("firstZoneActivationDelay", 30, 0, 120);
  level.zoneactivationdelay = dvarfloatvalue("zoneActivationDelay", 30, 0, 120);
  level.zoneselectiondelay = dvarfloatvalue("zoneSelectionDelay", 15, 0, 120);
  level.zonerandomlocationorder = dvarintvalue("randomLocationOrder", 1, 0, 1);
  level.zoneadditivescoring = dvarintvalue("additiveScoring", 0, 0, 1);
  level.pausemodetimer = dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = dvarintvalue("delayPlayer", 0, 0, 1);
}

function hqmainloop() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  setomnvar("ui_hq_status", -1);
  level.zone = getfirstzone();
  firstzone = 1;
  level.kothhillrotation = 0;
  level.zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level waittill_any_2("prematch_done", "start_mode_setup");
  }

  level.zone scripts\mp\gametypes\obj_zonecapture::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone scripts\mp\gameobjects::setvisibleteam("any");
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = level.zone;
  var_7e2c53b0bcf117d9.eventname = "hill_moved";
  var_7e2c53b0bcf117d9.position = level.zone.trigger.origin;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
  scripts\mp\flags::gameflagwait("prematch_done");

  if(level.pausemodetimer) {
    level scripts\mp\gamelogic::pausetimer();
  }

  setomnvar("ui_objective_timer_stopped", 0);
  var_570ba02607c0425c = 0;

  if(level.firstzoneactivationdelay) {
    level thread waitthenshowfirsthqsplash();
    var_570ba02607c0425c = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 1);
    level thread waitthenplaynewobj();
    level.zone thread scripts\mp\gameobjects::function_d36dcacac1708708(level.firstzoneactivationdelay);
    wait level.firstzoneactivationdelay;
    namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(7, "free");
  }

  setomnvar("ui_objective_timer_stopped", 0);

  while(true) {
    if(!isDefined(level.mapcalloutsready)) {
      level thread setupzonecallouts();
    }

    level.objectivesetorder = 1;
    waittillframeend();

    if(!var_570ba02607c0425c) {
      foreach(player in level.players) {
        scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, player);
      }
    }

    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled) {
      level.zone thread scripts\mp\gametypes\obj_zonecapture::trackgametypevips();
    }

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(var_570ba02607c0425c, firstzone);
    firstzone = 0;
    var_570ba02607c0425c = 0;
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
      foreach(player in level.players) {
        level.zone scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(player);
      }
    }

    level.zone scripts\mp\gameobjects::disableobject();
    level.zone scripts\mp\gameobjects::allowuse("none");
    level.zone scripts\mp\gameobjects::setownerteam("neutral");
    updateservericons("zone_shift", 0);
    level notify("zone_reset");
    level.zone scripts\mp\gametypes\obj_zonecapture::deactivatezone();
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "hq_capture", "hq_capture");
    setomnvar("ui_hq_status", 5);
    zoneselectiondelay = int(gettime() + level.zoneselectiondelay * 1000 + 500);
    setomnvar("ui_hardpoint_timer", zoneselectiondelay);

    if(level.zoneselectiondelay > 0) {
      if(level.pausemodetimer) {
        level scripts\mp\gamelogic::pausetimer();
      }
    }

    thread forcespawnplayers();
    wait level.zoneselectiondelay;
    spawn_next_zone();
    wait 0.5;
  }
}

function waitthenplaynewobj() {
  if(istrue(level.infilvotiming)) {
    wait 8.5;
  } else {
    wait 6;
  }

  foreach(entry in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_first", entry);
  }
}

function waitthenshowfirsthqsplash() {
  if(istrue(level.infilvotiming)) {
    wait 6.5;
  } else {
    wait 5.5;
  }

  level thread scripts\mp\hud_message::notifyteam("hq_located", "hq_located", "allies");
}

function killhardpointvfx() {
  foreach(player in level.players) {
    foreach(hpvfx in player._hardpointeffect) {
      player._hardpointeffect = array_remove(player._hardpointeffect, hpvfx);

      if(isDefined(hpvfx)) {
        hpvfx delete();
      }
    }
  }

  if(isDefined(self.neutralhardpointfx) && self.neutralhardpointfx.size > 0) {
    foreach(hpvfx in self.neutralhardpointfx) {
      hpvfx delete();
    }
  }

  self.neutralhardpointfx = [];
}

function remaphardpointorder() {
  switch (level.mapname) {
    case #"hash_a3aa6afd955c54d":
    case #"hash_8cd7282b2d63b917":
      level.remappedhpzoneorder = ["1", "4", "3", "9", "8"];
      break;
    case #"hash_be52fbd3b8746bc":
    case #"hash_d83171ba75f8b8fe":
      level.remappedhpzoneorder = ["5", "4", "3", "2", "6"];
      break;
    case #"hash_66ce5cdcd3b547f3":
    case #"hash_ff009e5fab42b778":
      level.remappedhpzoneorder = ["1", "5", "2", "3", "4"];
      break;
    case #"hash_1ab428ea9c0ee9e5":
      level.remappedhpzoneorder = ["1", "9", "4", "5", "2"];
      break;
    case #"hash_62c07791a2eda185":
      level.remappedhpzoneorder = ["12", "11", "3", "1", "2"];
      break;
    case #"hash_f09747c9feb47eb1":
      level.remappedhpzoneorder = ["20", "2", "8", "9", "5"];
      break;
    case #"hash_d8bbcfc499e70e6f":
      level.remappedhpzoneorder = ["1", "5", "7", "3", "8"];
      break;
    default:
      break;
  }
}

function getfirstzone() {
  if(isDefined(level.remappedhpzoneorder)) {
    zone = level.objectives[level.remappedhpzoneorder[0]];
    level.prevzoneindex = 0;
  } else {
    zone = level.objectives["1"];
    level.prevzoneindex = 1;
  }

  return zone;
}

function getnextzone() {
  if(level.zonerandomlocationorder) {
    var_bcadda10e825a297 = [];

    foreach(entry in level.teamnamelist) {
      var_bcadda10e825a297[entry] = (0, 0, 0);
    }

    livingplayers = getpotentiallivingplayers();

    foreach(player in livingplayers) {
      if(player.team == "spectator") {
        continue;
      }

      var_bcadda10e825a297[player.team] += player.origin;
    }

    avgpos = [];

    foreach(entry in level.teamnamelist) {
      players = getteamdata(entry, "players");
      teamsize = max(players.size, 1);
      avgpos[entry] = var_bcadda10e825a297[entry] / teamsize;
    }

    if(!isDefined(level.prevzonelist) || isDefined(level.prevzonelist) && level.prevzonelist.size == level.objectives.size - 1) {
      level.prevzonelist = [];
    }

    level.prevzonelist[level.prevzonelist.size] = level.prevzoneindex;
    playerweight = 0.7;
    zoneweight = 0.3;
    bestzoneindex = undefined;
    bestcost = undefined;

    foreach(objective in level.objectives) {
      skip = 0;

      foreach(zoneindex in level.prevzonelist) {
        if(objective.objectivekey == string(zoneindex)) {
          skip = 1;
          break;
        }
      }

      if(skip) {
        continue;
      }

      zone = objective;
      playercost = 0;

      foreach(entry in level.teamnamelist) {
        playercost += distance2dsquared(zone.curorigin, avgpos[entry]);
      }

      zonecost = distance2dsquared(zone.curorigin, level.zone.curorigin);
      totalcost = playercost * playerweight + zonecost * zoneweight;

      if(!isDefined(bestcost) || totalcost > bestcost) {
        bestcost = totalcost;
        bestzoneindex = objective.objectivekey;
      }
    }

    zone = level.objectives[bestzoneindex];
    level.prevzoneindex = bestzoneindex;
  } else if(isDefined(level.remappedhpzoneorder)) {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.remappedhpzoneorder.size - 1) {
      level.prevzoneindex = 0;
    }

    zone = level.objectives[level.remappedhpzoneorder[level.prevzoneindex]];
  } else {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.objectives.size) {
      level.prevzoneindex = 1;
    }

    zone = level.objectives[string(level.prevzoneindex)];
  }

  return zone;
}

function spawn_next_zone() {
  writecurrentrotationteamscore();
  level.zone = getnextzone();
  level.kothhillrotation++;
  level.zone resetzone();
  level.zone scripts\mp\gametypes\obj_zonecapture::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone.lastactivatetime = gettime();

  if(level.zoneactivationdelay > 0) {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  } else {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  }

  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = level.zone;
  var_7e2c53b0bcf117d9.eventname = "hill_moved";
  var_7e2c53b0bcf117d9.position = level.zone.trigger.origin;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
}

function resetzone() {
  self.lastclaimteam = "none";
  self.lastprogressteam = "none";
  self.ownerteam = "neutral";
  self.prevownerteam = "neutral";
  self.curprogress = 0;
  teams = getarraykeys(self.teamprogress);

  foreach(team in teams) {
    self.teamprogress[team] = 0;
  }

  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, undefined);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
}

function hqactivatenextzone(var_570ba02607c0425c, firstzone) {
  if(!firstzone && level.zoneselectiondelay > 5 && level.zoneactivationdelay > 5) {
    foreach(entry in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("hp_new_location", entry);
    }
  }

  if(isDefined(level.zone.curorigin)) {
    playsoundatpos(level.zone.curorigin, "mp_hq_activate_sfx");
  }

  level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("none");

  if(istrue(var_570ba02607c0425c)) {} else if(level.zoneactivationdelay) {
    level thread scripts\mp\hud_message::notifyteam("hq_located", "hq_located", "allies");
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("zone_activation_delay", 0);
    waitframe();
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 1);

    if(level.pausemodetimer) {
      level scripts\mp\gamelogic::pausetimer();
    }

    level.zone thread scripts\mp\gameobjects::function_d36dcacac1708708(level.zoneactivationdelay);
    wait level.zoneactivationdelay;
    namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(7, "free");
  }

  foreach(entry in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_active", entry);
  }

  level thread scripts\mp\hud_message::notifyteam("hq_capture", "hq_capture", "allies");

  if(level.pausemodetimer) {
    level scripts\mp\gamelogic::resumetimer();
  }

  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  updateservericons("neutral", 0);

  if(level.zoneduration) {
    updateservericons("neutral", 0);

    if(level.zonetimeout == 0) {
      thread locktimeruntilcap();
    } else {
      timeout = level.zonetimeout;
      thread movezoneaftertime(timeout);
      level.zoneendtime = int(gettime() + 1000 * timeout);
      setomnvar("ui_hardpoint_timer", level.zoneendtime);
    }

    return;
  }

  level.zonedestroyedbytimer = 0;
}

function locktimeruntilcap() {
  level endon("zone_captured");

  while(true) {
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    waitframe();
  }
}

function hpcaptureloop() {
  level endon("game_ended");
  level endon("zone_moved");
  level.hpstarttime = gettime();

  while(true) {
    level.zone scripts\mp\gameobjects::allowuse("enemy");
    level.zone scripts\mp\gameobjects::setvisibleteam("any");
    level.zone scripts\mp\gameobjects::setusetext(&"MP/SECURING_POSITION");

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime) {
      level thread scripts\mp\gametypes\grnd::randomdrops();
    }

    msg = level waittill_any_return_2("zone_captured", "zone_destroyed");

    if(msg == "zone_destroyed") {
      continue;
    } else {
      level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
      setomnvar("ui_hardpoint_timer", level.zoneendtime);
      setomnvar("ui_hq_status", 3);
    }

    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
    thread updaterespawntimer();

    if(level.zoneduration > 0) {
      thread movezoneaftertime(level.zoneduration);
    }

    if(level.zonecapturetime > 0) {
      skipplayers = getteamdata(ownerteam, "players");
      player = getfriendlyplayers(ownerteam, 0)[0];
      level thread scripts\mp\hud_message::notifyteam("hq_captured", "hq_destroy", ownerteam, skipplayers, undefined, undefined, player);
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(ownerteam, "hq_defend", "hq_detroy");
    namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(8, ownerteam);
    level waittill("zone_destroyed", destroy_team);
    namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(9, "free");

    if(level.zonecapturetime > 0) {
      enemyteam = getotherteam(ownerteam)[0];
      player = getfriendlyplayers(enemyteam, 0)[0];
      level thread scripts\mp\hud_message::notifyteam("hq_destroyed", "hq_destroyed", enemyteam, undefined, undefined, undefined, player);
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "hq_capture", "hq_capture");
    level.spawndelay = undefined;

    if(isDefined(destroy_team)) {
      level.zone scripts\mp\gameobjects::setownerteam(destroy_team);
    } else {
      level.zone scripts\mp\gameobjects::setownerteam("none");
    }

    setomnvar("ui_hardpoint_timer", 0);
    setomnvar("ui_hq_status", -1);
    break;
  }
}

function updaterespawntimer() {
  level endon("game_ended");
  level endon("zone_moved");
  level endon("zone_destroyed");
  starttime = gettime();

  if(level.zoneduration > 0) {
    endtime = starttime + level.zoneduration * 1000;
  } else {
    endtime = starttime + gettimelimit() * 1000 - gettimepassed();
  }

  currenttime = starttime;

  while(currenttime < endtime) {
    currenttime = gettime();
    level.spawndelay = (endtime - currenttime) / 1000 + 0.1;
    waitframe();
  }
}

function initspawns() {
  if(!spawnlogic::function_bff229a11ecd1e34()) {
    spawnlogic::setactivespawnlogic("Default", "Crit_Frontline", 1);
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  spawnkey = "koth";

  if(spawnlogic::function_b17bf43316b9fb08(spawnkey)) {
    spawnlogic::function_afe4709b818e7c9e(spawnkey);
  } else {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_koth_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_koth_spawn_axis_start");
    scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_koth_spawn_allies_start");
    scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_koth_spawn_axis_start");
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
    defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");
    scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
    scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn", 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn", 1);
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_koth_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_koth_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::registerspawnset("primary", scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn"));
    scripts\mp\spawnlogic::registerspawnset("fallback", scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_secondary"));
    spawnlogic::function_48ed29b53fd72775();
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(zone in level.objectives) {
    zone.furthestspawndistsq = 0;
    zone.spawnpoints = [];
    zone.spawnpoints[0] = [];
    zone.spawnpoints[2] = [];
  }

  obj_zonecapture::function_4265173fd3869f34(0, "primary", spawnkey);
  obj_zonecapture::function_4265173fd3869f34(2, "fallback", spawnkey);

  foreach(objid, zone in level.objectives) {
    zone.spawnset = "koth_" + objid;
    spawnlogic::registerspawnset(zone.spawnset, zone.spawnpoints[0]);
    zone.fallbackspawnset = "koth_fallback_" + objid;
    spawnlogic::registerspawnset(zone.fallbackspawnset, zone.spawnpoints[2]);
  }
}

function comparezoneindexes(zone_a, zone_b) {
  script_index_a = int(zone_a.objectivekey);
  script_index_b = int(zone_b.objectivekey);

  if(!isDefined(script_index_a) && !isDefined(script_index_b)) {
    println("<dev string:x1c>" + zone_a.origin + "<dev string:x4c>" + zone_b.origin);
    return false;
  }

  if(!isDefined(script_index_a) && isDefined(script_index_b)) {
    println("<dev string:x1c>" + zone_a.origin);
    return true;
  }

  if(isDefined(script_index_a) && !isDefined(script_index_b)) {
    println("<dev string:x1c>" + zone_b.origin);
    return false;
  }

  if(script_index_a > script_index_b) {
    return true;
  }

  return false;
}

function getzonearray(targetname) {
  zones = getEntArray(targetname, "targetname");

  foreach(z in zones) {
    z.objectivekey = z.script_label;
  }

  if(!isDefined(zones) || zones.size == 0) {
    return undefined;
  }

  swapped = 1;

  for(n = zones.size; swapped; n--) {
    swapped = 0;

    for(i = 0; i < n - 1; i++) {
      if(comparezoneindexes(zones[i], zones[i + 1])) {
        temp = zones[i];
        zones[i] = zones[i + 1];
        zones[i + 1] = temp;
        swapped = 1;
      }
    }
  }

  return zones;
}

function setupzones() {
  trigs = getzonearray("hq_zone");

  if(!isDefined(trigs)) {
    trigs = getzonearray("hardpoint_zone");
  }

  assert(isDefined(trigs) && trigs.size > 3);
  maperrors = [];
  errored = 0;
  radios = getEntArray("hqloc", "targetname");
  visuals = [];

  if(trigs.size != radios.size) {
    maperrors[maperrors.size] = "Number of hqloc Radios and hardpoint_zone triggers are not equal";
    errored = 1;

    foreach(trig in trigs) {
      var_ad440e7908375fd4 = 0;

      foreach(radio in radios) {
        if(radio istouching(trig)) {
          var_ad440e7908375fd4 = 1;
          break;
        }
      }

      if(!var_ad440e7908375fd4) {
        maperrors[maperrors.size] = "hardpoint_zone: " + trig.script_label + " has no hqloc radio inside it";
      }
    }
  }

  level.objectives = [];

  for(i = 0; i < radios.size; i++) {
    radio = radios[i];
    trig = undefined;

    for(j = 0; j < trigs.size; j++) {
      if(radio istouching(trigs[j])) {
        if(isDefined(trig)) {
          maperrors[maperrors.size] = "Radio at " + radio.origin + " is touching more than one \"hardpoint_zone\" trigger";
          errored = 1;
          break;
        }

        trig = trigs[j];
        break;
      }
    }

    if(!isDefined(trig) && getdvarint(@ "hash_b6e38e5a0db26c74", 0)) {
      trig = getclosest(radio.origin, trigs);

      level thread function_46cdb774ca022e52(trig.origin, radio.origin);
    }

    if(!isDefined(trig)) {
      if(!errored) {
        maperrors[maperrors.size] = "Radio at " + radio.origin + " is not inside any \"hardpoint_zone\" trigger";
        errored = 1;
        continue;
      }
    }

    assert(!errored);
    visuals = [];
    visuals[0] = radio;
    othervisuals = getEntArray(radio.target, "targetname");

    for(k = 0; k < othervisuals.size; k++) {
      visuals[visuals.size] = othervisuals[k];
    }

    if(isDefined(trig)) {
      zone = scripts\mp\gametypes\obj_zonecapture::setupobjective(trig, visuals);
      level.objectives[zone.objectivekey] = zone;
    }
  }

  if(maperrors.size > 0) {
    println("<dev string:x51>");

    for(i = 0; i < maperrors.size; i++) {
      println(maperrors[i]);
    }

    println("<dev string:x7b>");

    assertmsg("<dev string:xa5>");
    return;
  }

  return 1;
}

function function_46cdb774ca022e52(origin1, origin2) {
  while(true) {
    line(origin1, origin2, (1, 0, 0), 1, 0, 1);
    box(origin1, 0, (1, 0, 0), 0, 1);
    waitframe();
  }
}

function setupzonecallouts() {
  areaid = undefined;
  zonetrigger = level.zone.visuals[0];

  if(isDefined(zonetrigger.script_noteworthy)) {
    areaid = level.calloutglobals.areaidmap[zonetrigger.script_noteworthy];
  }

  if(!isDefined(areaid)) {
    areaid = scripts\mp\callouts::function_45d5ee5f369ad604(zonetrigger);
  }

  if(isDefined(areaid)) {
    setomnvar("ui_hp_callout_id", areaid);
  }

  namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(6, "free");
  assertex(isDefined(areaid), "<dev string:xbe>" + zonetrigger.targetname + "<dev string:xcf>");
}

function forcespawnplayers() {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isDefined(player) || istrue(player.fauxdead) && player isusingremote() || isalive(player) && !istrue(player.fauxdead)) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, player);
    player notify("force_spawn");
    waitframe();
  }

  thread function_7f5bcc4009c143bd();
}

function function_7f5bcc4009c143bd() {
  wait 3;
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(player isinkillcam()) {
      player thread function_2fb169121f027ccc();
      continue;
    } else if(!isDefined(player) || istrue(player.fauxdead) && player isusingremote() || isalive(player) && !istrue(player.fauxdead)) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, player);
    player notify("force_spawn");
    waitframe();
  }
}

function function_2fb169121f027ccc() {
  level endon("game_ended");
  self endon("spawned");

  while(isinkillcam()) {
    wait 0.1;
  }

  wait 1;
  self notify("force_spawn");
}

function getspawnpoint() {
  var_2fa17baefe0fa286 = getkothzonedeadzonedist();
  spawnparams = scripts\mp\spawnfactor::function_75c03ed937b75b22(level.zone.trigger getentitynumber(), level.zone.furthestspawndistsq, var_2fa17baefe0fa286 * var_2fa17baefe0fa286, 12250000);
  usingstartspawns = spawnlogic::shoulduseteamstartspawn();

  if(spawnlogic::function_bff229a11ecd1e34()) {
    factor_set = #"default";

    if(usingstartspawns) {
      factor_set = #"start";
    }

    if(!spawnlogic::isactivespawnlogic(factor_set)) {
      spawnlogic::setactivespawnlogic(factor_set);
    }
  }

  if(usingstartspawns) {
    return spawnlogic::function_8be1c339876506b9(self, "start", self.pers["team"], spawnparams);
  } else if(istrue(level.var_307162ed6f880997)) {
    return spawnlogic::function_8be1c339876506b9(self, "default", self.pers["team"], spawnparams);
  }

  return scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], level.zone.spawnset, level.zone.fallbackspawnset, 2, spawnparams);
}

function getkothzonedeadzonedist() {
  if(!istrue(level.zone.active)) {
    return 2000;
  }

  return 1000;
}

function onspawnplayer(revivespawn) {
  self setclientomnvar("ui_hq_norespawn", 0);

  if(isDefined(level.zone) && isDefined(level.zone.ownerteam) && level.zone.ownerteam != "neutral") {
    setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(level.zone.ownerteam, "aliveCount"));
  }

  self.forcespawnnearteammates = undefined;
  self.skipspawncamera = undefined;
  thread updatematchstatushintonspawn();
}

function movezoneaftertime(time) {
  level notify("startMoveTimer");
  level endon("startMoveTimer");
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level.zonemovetime = time;
  level.zonedestroyedbytimer = 0;
  scripts\mp\gametypes\obj_zonecapture::zonetimerwait();
  level.zonedestroyedbytimer = 1;

  if(level.zoneselectiondelay + level.zoneactivationdelay > 5) {
    foreach(entry in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("hp_timeout", entry);
    }
  }

  namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(9, "free");
  level notify("zone_moved");
  level notify("zone_destroyed");
}

function onsuicidedeath(victim) {
  setomnvar("ui_hq_num_alive", getteamdata(victim.team, "aliveCount"));
}

function modeonteamchangedeath(player) {
  setomnvar("ui_hq_num_alive", getteamdata(player.leaving_team, "aliveCount"));
}

function canspawnontacinsert(player) {
  var_a3036ebee981194e = level.zone.ownerteam == player.team;
  return !var_a3036ebee981194e;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  ownerteam = level.zone.ownerteam;

  if(!isPlayer(attacker) || attacker.team == self.team) {
    if(ownerteam != "neutral") {
      self.skipspawncamera = 1;
    }

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

  if(isDefined(objweapon) && iskillstreakweapon(objweapon.basename)) {
    return;
  }

  victim = self;
  var_9ff9376383f4bc58 = 0;
  attackerteam = attacker.team;

  if(ownerteam != "neutral") {
    level updatehqaliveomnvars(ownerteam);
  }

  if(ownerteam == victim.team) {
    victim.skipspawncamera = 1;
  }

  if(level.zone.active) {
    if(level.zonecapturetime > 0 && attacker istouching(level.zone.trigger)) {
      if(ownerteam != attackerteam) {
        var_9ff9376383f4bc58 = 1;
      }
    }

    if(attackerteam != ownerteam) {
      if(var_9ff9376383f4bc58) {
        attacker thread function_e3e3e81453fd788b(#"capture_kill");
      } else if(victim istouching(level.zone.trigger)) {
        attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
        attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
        thread utility::trycall(level.matchdata_logvictimkillevent, killid, "defending");
      }
    } else if(attacker istouching(level.zone.trigger)) {
      attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
      attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
      attacker incpersstat("defends", 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      attacker setextrascore1(attacker.pers["defends"]);
    }
  }

  thread checkallowspectating();
}

function checkallowspectating() {
  if(level.zone.ownerteam == "neutral") {
    return;
  }

  if(!getteamdata(level.zone.ownerteam, "aliveCount")) {
    level.spectateoverride[level.zone.ownerteam].allowenemyspectate = 1;
    scripts\mp\spectating::updatespectatesettings();
  }
}

function updatehqaliveomnvars(ownerteam) {
  setomnvar("ui_hq_num_alive", getteamdata(ownerteam, "aliveCount"));
}

function give_capture_credit(touchlist, capturetime, capture_team, lastcaptureteam, credit_player, hqgameobject) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  first_player = undefined;
  var_eeb573d717f07f64 = 0;

  if(isDefined(credit_player)) {
    var_7f98a969b68d5171 = touchlist[credit_player.guid];

    if(isDefined(var_7f98a969b68d5171)) {
      var_eeb573d717f07f64 = var_7f98a969b68d5171.var_d96989d14549fd76;

      if(var_eeb573d717f07f64) {
        if(isDefined(var_7f98a969b68d5171.owner)) {
          first_player = var_7f98a969b68d5171.owner;
        }
      } else {
        first_player = var_7f98a969b68d5171.player;
      }
    }
  }

  if(isDefined(first_player)) {
    if(!isscoreboosting(first_player)) {
      var_7e2c53b0bcf117d9 = spawnStruct();
      var_7e2c53b0bcf117d9.player = first_player;
      var_7e2c53b0bcf117d9.eventname = "capture";
      var_7e2c53b0bcf117d9.position = first_player.origin;
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
      first_player thread scripts\mp\rank::scoreeventpopup(#"hash_cbcb83b1a39c5c8e");

      if(var_eeb573d717f07f64) {
        first_player thread scripts\mp\utility\points::doscoreevent(#"hash_36af03684ac64eb8");
      } else {
        first_player thread scripts\mp\utility\points::doscoreevent(#"hash_194ad9a7fdb13341");
      }

      if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100) {
        if(var_eeb573d717f07f64) {
          first_player thread scripts\mp\utility\points::doscoreevent(#"hash_14ca5d321828d5c5");
        } else {
          first_player thread scripts\mp\utility\points::doscoreevent(#"hash_4d98aed9e6ebbf28");
        }
      }

      if(first_player.lastkilltime + 500 > gettime()) {} else {
        first_player scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(first_player);
      }
    }
  }

  players = getarraykeys(touchlist);

  for(i = 0; i < players.size; i++) {
    touchliststruct = touchlist[players[i]];
    var_8a11b26acefd3594 = touchliststruct.var_d96989d14549fd76;

    if(var_8a11b26acefd3594) {
      if(isDefined(touchliststruct.owner)) {
        player = touchliststruct.owner;
      } else {
        player = undefined;
      }
    } else {
      player = touchliststruct.player;
    }

    if(isDefined(player)) {
      player updatecapsperminute(lastcaptureteam);

      if(!isscoreboosting(player)) {
        player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
        player incpersstat("captures", 1);
        player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
        player setextrascore0(player.pers["captures"]);
      } else {
        player iprintlnbold("<dev string:x144>");
      }
    }

    wait 0.05;
  }

  if(isDefined(hqgameobject.assisttouchlist)) {
    if(hqgameobject.assisttouchlist[capture_team].size > 0) {
      var_9eb80458ef362367 = getarraykeys(hqgameobject.assisttouchlist[capture_team]);

      foreach(id in players) {
        foreach(assistid in var_9eb80458ef362367) {
          if(assistid == id) {
            hqgameobject.assisttouchlist[capture_team][assistid] = undefined;
          }
        }
      }
    }

    if(hqgameobject.assisttouchlist[capture_team].size > 0) {
      hqgameobject thread function_11ce247555fb7a20(capture_team);
    }
  }
}

function function_11ce247555fb7a20(team) {
  level endon("game_ended");
  var_9eb80458ef362367 = getarraykeys(self.assisttouchlist[team]);

  if(var_9eb80458ef362367.size > 0) {
    for(index = 0; index < var_9eb80458ef362367.size; index++) {
      var_6c7881393d098340 = self.assisttouchlist[team][var_9eb80458ef362367[index]];
      var_8a11b26acefd3594 = var_6c7881393d098340.var_d96989d14549fd76;

      if(var_8a11b26acefd3594) {
        if(isDefined(var_6c7881393d098340.owner)) {
          player = var_6c7881393d098340.owner;
        } else {
          player = undefined;
        }
      } else {
        player = var_6c7881393d098340.player;
      }

      if(isDefined(player)) {
        player incpersstat("captures", 1);
        player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
        player setextrascore0(player.pers["captures"]);

        if(isDefined(var_8a11b26acefd3594)) {
          player thread scripts\mp\utility\points::doscoreevent(#"hash_70c24ce7e0579e7a");
        } else {
          player thread scripts\mp\rank::scoreeventpopup(#"capture_assist");
          player thread scripts\mp\utility\points::doscoreevent(#"hash_7a10d07e9cc5745b");
        }

        scripts\cp_mp\challenges::function_90d26b6dc5331196(player);
        player scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(player);
      }

      self.assisttouchlist[team][var_9eb80458ef362367[index]] = undefined;
      wait 0.05;
    }
  }
}

function awardcapturepoints() {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("zone_moved");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  seconds = 1;
  score = 1;

  while(!level.gameended) {
    waittime = 0;

    while(waittime < seconds) {
      wait level.framedurationseconds;
      scripts\mp\hostmigration::waittillhostmigrationdone();
      waittime += level.framedurationseconds;
    }

    team = level.zone scripts\mp\gameobjects::getownerteam();

    if(team == "neutral") {
      continue;
    }

    if(level.zoneadditivescoring) {
      score = level.zone.touchlist[team].size;
    }

    scripts\mp\gamescore::giveteamscoreforobjective(team, score, 0);

    if(!istrue(level.scoreleadchanged)) {
      adjustmatchtimerpausedstatefromleadchange(team);
    }
  }
}

function adjustmatchtimerpausedstatefromleadchange(team) {
  if(!level.pausemodetimer) {
    return;
  }

  ownerteamscore = scripts\mp\gamescore::_getteamscore(team);
  otherteamscore = scripts\mp\gamescore::_getteamscore(getotherteam(team)[0]);

  if(ownerteamscore > otherteamscore) {
    level.scoreleadchanged = 1;
    level scripts\mp\gamelogic::resumetimer();
    return;
  }

  level scripts\mp\gamelogic::pausetimer();
}

function updatecapsperminute(lastownerteam) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(lastownerteam) || lastownerteam == "neutral") {
    return;
  }

  self.numcaps++;
  minutespassed = gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["total"])) {
    minutespassed = self.timeplayed["total"] / 60;
  }

  self.capsperminute = self.numcaps / minutespassed;

  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
  }
}

function isscoreboosting(player) {
  return isDefined(player.capsperminute) && player.capsperminute > 3;
}

function onplayerconnect(player) {
  player setclientomnvar("ui_hq_norespawn", 0);
  player._hardpointeffect = [];
  player.numcaps = 0;
  player.capsperminute = 0;
  player.timebyrotation = [];
  player setextrascore0(0);

  if(isDefined(player.pers["captures"])) {
    player setextrascore0(player.pers["captures"]);
  }

  player setextrascore1(0);

  if(isDefined(player.pers["defends"])) {
    player setextrascore1(player.pers["defends"]);
  }

  thread onplayerspawned(player);

  foreach(zone in level.objectives) {
    if(istrue(level.usehpzonebrushes)) {
      zone scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes(player);
    }
  }

  player thread refreshfreecamhardpointfx();
}

function onplayerspawned(player) {
  while(true) {
    player waittill("spawned");

    foreach(zone in level.objectives) {
      if(istrue(zone.active)) {
        if(zone.ownerteam == "neutral") {
          zone scripts\mp\gametypes\obj_zonecapture::playhardpointneutralfx();
          continue;
        }

        zone scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer(zone.ownerteam, player);
      }
    }
  }
}

function gethqownerteamvalue(ownerteam) {
  if(ownerteam == "allies") {
    omnvarval = 2;
  } else if(ownerteam == "axis") {
    omnvarval = 1;
  } else {
    omnvarval = 0;
  }

  return omnvarval;
}

function updateservericons(state, contested) {
  omnvarval = -1;

  if(contested) {
    omnvarval = -2;
  } else if(isgameplayteam(state)) {
    player = thread getownerteamplayer(state);

    if(isDefined(player)) {
      omnvarval = player getentitynumber();
    }
  } else {
    switch (state) {
      case #"hash_3bf8ec5fe1d42da8":
        omnvarval = -3;
        break;
      case #"hash_c312107e6bce703c":
      default:
        break;
    }
  }

  setomnvar("ui_hardpoint", omnvarval);
}

function getownerteamplayer(ownerteam) {
  ownerplayer = undefined;

  foreach(player in level.players) {
    if(player.team == ownerteam) {
      ownerplayer = player;
      break;
    }
  }

  return ownerplayer;
}

function refreshfreecamhardpointfx() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("luinotifyserver", channel, view);

    if(channel == "mlg_view_change") {
      foreach(zone in level.objectives) {
        if(zone.ownerteam != "neutral") {
          zone scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer(zone.ownerteam, self);
        }
      }
    }
  }
}

function getrespawndelay() {
  if(!istrue(level.delayplayer)) {
    return undefined;
  }

  ownerteam = level.zone.ownerteam;

  if(isDefined(ownerteam)) {
    if(self.pers["team"] == ownerteam) {
      if(!level.spawndelay) {
        return undefined;
      }

      return level.spawndelay;
    }
  }
}

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(isDefined(level.zone)) {
    if(isDefined(level.zone.ownerteam)) {
      if(level.zone.ownerteam == "neutral") {
        scripts\mp\hud_message::function_f004ef4606b9efdc("hq_capture");
        return;
      }

      if(level.zone.ownerteam == self.team) {
        scripts\mp\hud_message::function_f004ef4606b9efdc("hq_defend");
        return;
      }

      scripts\mp\hud_message::function_f004ef4606b9efdc("hq_detroy");
    }
  }
}

function showrespawnwarningmessage() {
  self endon("death_or_disconnect");
  self setclientomnvar("ui_hq_norespawn", 1);
  scripts\mp\utility\sound::playsoundonplayers("mp_hq_respawn_disabled");
  wait 5;
  self setclientomnvar("ui_hq_norespawn", 0);
}

function seticonnames() {
  level.icontarget = "hq_target";
  level.iconneutral = "hq_neutral";
  level.iconcapture = "hq_destroy";
  level.icondefend = "hq_defend";
  level.iconcontested = "hq_contested";
  level.icontaking = "hq_taking";
  level.iconlosing = "hq_losing";
  level.icondefending = "hq_defending";
}

function writeplayerrotationscoretomatchdataongameend() {
  level waittill("game_ended");
  writecurrentrotationteamscore();
}

function writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("alliesRoundScore", level.kothhillrotation, getteamscore("allies"));
    setmatchdata("axisRoundScore", level.kothhillrotation, getteamscore("axis"));
  }
}

function drawpoint(org, size, color) {
  for(i = 0; i < 10; i++) {
    a1 = i / 10 * 360;
    a2 = (i + 1) / 10 * 360;
    pt1 = org + (cos(a1), sin(a1), 0) * size;
    pt2 = org + (cos(a2), sin(a2), 0) * size;
    line(pt1, pt2, color);
  }
}

function kothdebug() {
  while(true) {
    if(getDvar(@ "hash_657c47f657a0023c") != "<dev string:x18c>") {
      wait 2;
      continue;
    }

    while(true) {
      if(getDvar(@ "hash_657c47f657a0023c") != "<dev string:x18c>") {
        break;
      }

      if(!isDefined(level.players) || level.players.size <= 0) {
        wait 0.05;
        continue;
      }

      bestdistsq = 999999999;
      bestradio = level.radios[0];

      foreach(radio in level.radios) {
        distsq = distancesquared(radio.origin, level.players[0].origin);

        if(distsq < bestdistsq) {
          bestdistsq = distsq;
          bestradio = radio;
        }
      }

      foreach(radio in level.radios) {
        if(radio != bestradio) {
          drawpoint(radio.origin, 50, (0.5, 0.5, 0.5));
        }
      }

      radio = bestradio;
      drawpoint(radio.origin, 100, (1, 1, 1));

      foreach(spawnpoint in radio.outerspawns) {
        line(radio.origin, spawnpoint.origin, (1, 0.5, 0.5));
        drawpoint(spawnpoint.origin, 20, (1, 0.5, 0.5));
      }

      foreach(spawnpoint in radio.nearspawns) {
        line(radio.origin + (0, 0, 10), spawnpoint.origin + (0, 0, 10), (0.5, 1, 0.5));
        drawpoint(spawnpoint.origin, 30, (0.5, 1, 0.5));
      }

      wait 0.05;
    }
  }
}

function function_1f98c5616d8b3d67() {
  self endon("<dev string:x191>");

  while(true) {
    if(getdvarint(@ "hash_4806172df45de691") != 0) {
      level notify("<dev string:x19f>");
      level.zoneduration = 10000;
      break;
    }

    wait 1;
  }

  thread movezoneaftertime(level.zoneduration);
  level.var_2db03438253fa6e2 = 1;
  setdevdvar(@ "hash_4806172df45de691", 0);
  thread function_1f98c5616d8b3d67();
}

function function_bed0f399bee034f8() {
  self endon("<dev string:x191>");

  while(true) {
    if(getdvarint(@ "hash_796deaab0da995a1") != 0) {
      level notify("<dev string:x19f>");
      level.zoneduration = 1;
      break;
    }

    wait 1;
  }

  thread movezoneaftertime(level.zoneduration);
  setdevdvar(@ "hash_796deaab0da995a1", 0);

  if(isDefined(level.var_2db03438253fa6e2) && level.var_2db03438253fa6e2) {
    level.zoneduration = 10000;
  } else {
    level.zoneduration = getdvarint(@ "hash_cb81f537c99c9657");
  }

  thread function_bed0f399bee034f8();
  self notify("<dev string:x1b1>");
}

function function_ef4f5aa9c42838b2() {
  self endon("<dev string:x191>");

  while(true) {
    if(getdvarint(@ "hash_4c260c16d548430f") != 0) {
      level notify("<dev string:x19f>");
      level.zoneduration = getdvarint(@ "hash_cb81f537c99c9657");
      break;
    }

    wait 1;
  }

  thread movezoneaftertime(level.zoneduration);
  level.var_2db03438253fa6e2 = 0;
  setdevdvar(@ "hash_4c260c16d548430f", 0);
  thread function_ef4f5aa9c42838b2();
}

function function_be67fb2ebcca86d1() {
  self endon("<dev string:x191>");

  while(true) {
    if(getdvarint(@ "hash_c000ec9a5a2f4b6c") != 0) {
      setdevdvar(@ "hash_4806172df45de691", 1);
      level.zoneduration = 10000;
      level.var_2db03438253fa6e2 = 1;
      thread movezoneaftertime(level.zoneduration);
      level notify("<dev string:x1c9>");

      foreach(zone in level.objectives) {
        if(isDefined(zone.neutralhardpointfx) && zone.neutralhardpointfx.size > 0) {
          foreach(hpvfx in zone.neutralhardpointfx) {
            zone.neutralhardpointfx = array_remove(zone.neutralhardpointfx, hpvfx);

            if(isDefined(hpvfx)) {
              hpvfx delete();
            }
          }
        }

        zone.neutralhardpointfx = [];

        for(i = 1; i < zone.visuals.size; i++) {
          fxfwd = anglesToForward(zone.visuals[i].angles);
          zone.neutralhardpointfx[zone.neutralhardpointfx.size] = spawnfx(level.hardpointfxid["<dev string:x1de>"], zone.visuals[i].baseorigin, fxfwd);
          zone.neutralhardpointfx[zone.neutralhardpointfx.size - 1] setfxkilldefondelete();
          triggerfx(zone.neutralhardpointfx[zone.neutralhardpointfx.size - 1]);
        }

        zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
        zone scripts\mp\gameobjects::setvisibleteam("<dev string:x1e9>");
      }
    }

    setdevdvar(@ "hash_c000ec9a5a2f4b6c", 0);
    wait 1;
  }
}

function function_b4c2563f73b02c80() {
  self endon("<dev string:x191>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x1f0>", getdvarint(@ "hash_46a6b424af6acbc2"), 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x1fa>", getdvarint(@ "hash_86e14326e43c0115"), 0);
      break;
    }

    wait 1;
  }

  setdevdvar(@ "hash_46a6b424af6acbc2", 0);
  setdevdvar(@ "hash_86e14326e43c0115", 0);
  thread function_b4c2563f73b02c80();
}

# /