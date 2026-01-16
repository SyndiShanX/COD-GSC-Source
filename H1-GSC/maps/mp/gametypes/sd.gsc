/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\sd.gsc
********************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [
      [level.initializematchrules]
    ]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 1, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 2.5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 4);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
    setdynamicdvar("scr_killcount_persists", 0);
  }

  level.objectivebased = 1;
  level.teambased = 1;
  level.classicgamemode = 1;
  level.onprecachegametype = maps\mp\gametypes\common_sd_sr::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = maps\mp\gametypes\common_sd_sr::ondeadevent;
  level.ononeleftevent = maps\mp\gametypes\common_sd_sr::ononeleftevent;
  level.ontimelimit = maps\mp\gametypes\common_sd_sr::ontimelimit;
  level.onnormaldeath = maps\mp\gametypes\common_sd_sr::onnormaldeath;
  level.gamemodemaydropweapon = maps\mp\gametypes\common_sd_sr::isplayeroutsideofanybombsite;
  level.allowlatecomers = 0;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

  game["dialog"]["gametype"] = "searchdestroy";
  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  maps\mp\gametypes\common_sd_sr::setbombendtime(0, 0);
  maps\mp\gametypes\common_sd_sr::setbombendtime(0, 1);
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  var_0 = getmatchrulesdata("sdData", "roundLength");
  setdynamicdvar("scr_sd_timelimit", var_0);
  maps\mp\_utility::registertimelimitdvar("sd", var_0);
  var_1 = getmatchrulesdata("sdData", "roundSwitch");
  setdynamicdvar("scr_sd_roundswitch", var_1);
  maps\mp\_utility::registerroundswitchdvar("sd", var_1, 0, 9);
  var_2 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_sd_winlimit", var_2);
  maps\mp\_utility::registerwinlimitdvar("sd", var_2);
  setdynamicdvar("scr_sd_bombtimer", getmatchrulesdata("sdData", "bombTimer"));
  setdynamicdvar("scr_sd_planttime", getmatchrulesdata("sdData", "plantTime"));
  setdynamicdvar("scr_sd_defusetime", getmatchrulesdata("sdData", "defuseTime"));
  setdynamicdvar("scr_sd_multibomb", getmatchrulesdata("sdData", "multiBomb"));
  setdynamicdvar("scr_sd_silentplant", getmatchrulesdata("sdData", "silentPlant"));
  setdynamicdvar("scr_sd_roundlimit", 0);
  maps\mp\_utility::registerroundlimitdvar("sd", 0);
  setdynamicdvar("scr_sd_scorelimit", 1);
  maps\mp\_utility::registerscorelimitdvar("sd", 1);
  setdynamicdvar("scr_sd_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("sd", 0);
}

onstartgametype() {
  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  setclientnamemode("manual_change");
  maps\mp\gametypes\common_bomb_gameobject::loadbombfx();
  maps\mp\_utility::setobjectivetext(game["attackers"], & "OBJECTIVES_SD_ATTACKER");
  maps\mp\_utility::setobjectivetext(game["defenders"], & "OBJECTIVES_SD_DEFENDER");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], & "OBJECTIVES_SD_ATTACKER");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], & "OBJECTIVES_SD_DEFENDER");
  } else {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], & "OBJECTIVES_SD_ATTACKER_SCORE");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], & "OBJECTIVES_SD_DEFENDER_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext(game["attackers"], & "OBJECTIVES_SD_ATTACKER_HINT");
  maps\mp\_utility::setobjectivehinttext(game["defenders"], & "OBJECTIVES_SD_DEFENDER_HINT");
  initspawns();
  var_2[0] = "sd";
  var_2[1] = "bombzone";
  var_2[2] = "blocker";
  maps\mp\gametypes\_gameobjects::main(var_2);
  thread maps\mp\gametypes\common_sd_sr::updategametypedvars();
  maps\mp\_utility::setcarrierloadouts();
  thread maps\mp\gametypes\common_sd_sr::bombs();
  thread maps\mp\gametypes\_spectating::allowallyteamspectating();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = "mp_sd_spawn_defender";

  if(self.pers["team"] == game["attackers"])
    var_0 = "mp_sd_spawn_attacker";

  var_1 = maps\mp\gametypes\_spawnlogic::getbeststartspawn(var_0);
  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_1);
  return var_1;
}

onspawnplayer() {
  var_0 = maps\mp\_utility::is_true(self.isrespawningwithbombcarrierclass);

  if(maps\mp\_utility::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;

    if(!var_0) {
      self.isbombcarrier = 0;
      self.objective = 0;
    }
  }

  if(isplayer(self) && !var_0) {
    if(level.multibomb && self.pers["team"] == game["attackers"])
      self setclientomnvar("ui_carrying_bomb", 1);
    else
      self setclientomnvar("ui_carrying_bomb", 0);
  }

  maps\mp\_utility::setextrascore0(0);

  if(isdefined(self.pers["plants"]))
    maps\mp\_utility::setextrascore0(self.pers["plants"]);

  maps\mp\_utility::setextrascore1(0);

  if(isdefined(self.pers["defuses"]))
    maps\mp\_utility::setextrascore1(self.pers["defuses"]);

  self.isrespawningwithbombcarrierclass = undefined;
  level notify("spawned_player");
  thread maps\mp\gametypes\common_sd_sr::onplayerdisconnect();
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isplayer(self))
    self setclientomnvar("ui_carrying_bomb", 0);

  thread maps\mp\gametypes\common_sd_sr::checkallowspectating();
}