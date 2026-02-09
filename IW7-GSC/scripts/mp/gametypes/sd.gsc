/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\sd.gsc
*********************************************/

main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 3, 0, 9);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 2.5);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 1);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 0);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 4);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 1);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    scripts\mp\utility::registerwinbytwoenableddvar(level.gametype, 1);
    scripts\mp\utility::registerwinbytwomaxroundsdvar(level.gametype, 4);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;
  level.gamemodemaydropweapon = scripts\mp\utility::isplayeroutsideofanybombsite;
  level.onobjectivecomplete = ::onbombexploded;
  level.allowlatecomers = 0;
  level.bombsplanted = 0;
  level.aplanted = 0;
  level.bplanted = 0;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "searchdestroy";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
  setomnvar("ui_bomb_timer_endtime_a", 0);
  setomnvar("ui_bomb_timer_endtime_b", 0);
  setomnvar("ui_bomb_planted_a", 0);
  setomnvar("ui_bomb_planted_b", 0);
  setomnvar("ui_allies_alive", 0);
  setomnvar("ui_axis_alive", 0);
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_sd_bombtimer", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("scr_sd_planttime", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("scr_sd_defusetime", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("scr_sd_multibomb", getmatchrulesdata("bombData", "multiBomb"));
  setdynamicdvar("scr_sd_silentPlant", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("scr_sd_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("sd", 0);
  setdynamicdvar("scr_sd_promode", 0);
}

onprecachegametype() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  setclientnamemode("manual_change");
  level._effect["bomb_explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_bombardment_strike_explosion");
  level._effect["vehicle_explosion"] = loadfx("vfx\core\expl\small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  scripts\mp\utility::setobjectivetext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
  scripts\mp\utility::setobjectivetext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
    scripts\mp\utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  } else {
    scripts\mp\utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE");
    scripts\mp\utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT");
  scripts\mp\utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT");
  initspawns();
  var_2[0] = "sd";
  var_2[1] = "bombzone";
  var_2[2] = "blocker";
  scripts\mp\gameobjects::main(var_2);
  setspecialloadout();
  thread bombs();
  scripts\mp\utility::func_98D3();
  level thread onplayerconnect();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = "mp_sd_spawn_defender";
  if(self.pers["team"] == game["attackers"]) {
    var_0 = "mp_sd_spawn_attacker";
  }

  var_1 = scripts\mp\spawnlogic::getspawnpointarray(var_0);
  var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  return var_2;
}

onspawnplayer() {
  if(scripts\mp\utility::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    self.laststanding = 0;
  }

  if(level.multibomb && self.pers["team"] == game["attackers"]) {
    self setclientomnvar("ui_carrying_bomb", 1);
  } else {
    self setclientomnvar("ui_carrying_bomb", 0);
    foreach(var_1 in level.bombzones) {
      var_1.trigger disableplayeruse(self);
    }
  }

  scripts\mp\utility::setextrascore0(0);
  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility::setextrascore0(self.pers["plants"]);
  }

  scripts\mp\utility::setextrascore1(0);
  if(isDefined(self.pers["defuses"])) {
    scripts\mp\utility::setextrascore1(self.pers["defuses"]);
  }

  func_12E58();
  level notify("spawned_player");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerdisconnected();
  }
}

onplayerdisconnected() {
  for(;;) {
    self waittill("disconnect");
    level func_12E58();
  }
}

func_12E58() {
  if(isDefined(level.alive_players["allies"])) {
    setomnvar("ui_allies_alive", level.alive_players["allies"].size);
  }

  if(isDefined(level.alive_players["axis"])) {
    setomnvar("ui_axis_alive", level.alive_players["axis"].size);
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("ui_carrying_bomb", 0);
  func_12E58();
  thread checkallowspectating();
}

checkallowspectating() {
  wait(0.05);
  var_0 = 0;
  if(!level.alivecount[game["attackers"]]) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!level.alivecount[game["defenders"]]) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0) {
    scripts\mp\spectating::updatespectatesettings();
  }
}

sd_endgame(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isai(var_3)) {
      var_3 setclientomnvar("ui_objective_state", 0);
    }
  }

  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

ondeadevent(var_0) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }

  if(var_0 == "all") {
    if(level.bombplanted) {
      sd_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
      return;
    }

    sd_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
    return;
  }

  if(var_0 == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }

    level thread sd_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
    return;
  }

  if(var_0 == game["defenders"]) {
    level thread sd_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
    return;
  }
}

ononeleftevent(var_0) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }

  var_1 = scripts\mp\utility::getlastlivingplayer(var_0);
  var_1.laststanding = 1;
  var_1 thread givelastonteamwarning();
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::onnormaldeath(var_0, var_1, var_2, var_3, var_4);
  var_5 = scripts\mp\rank::getscoreinfovalue("kill");
  var_6 = var_0.team;
  var_7 = 0;
  if(isDefined(var_1.laststanding) && var_1.laststanding) {
    var_1 thread scripts\mp\utility::giveunifiedpoints("last_man_kill");
  }

  if(var_0.isplanting) {
    thread scripts\mp\matchdata::loginitialstats(var_2, "planting");
    var_1 scripts\mp\utility::incperstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    var_1 thread scripts\mp\awards::givemidmatchaward("mode_sd_plant_save");
    var_7 = 1;
  } else if(var_0.isbombcarrier) {
    thread scripts\mp\matchdata::loginitialstats(var_2, "carrying");
  } else if(var_0.isdefusing) {
    thread scripts\mp\matchdata::loginitialstats(var_2, "defusing");
    scripts\mp\utility::setmlgannouncement(13, var_1.team, var_1 getentitynumber());
    var_1 scripts\mp\utility::incperstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    var_1 thread scripts\mp\awards::givemidmatchaward("mode_sd_defuse_save");
    var_7 = 1;
  }

  if(!var_7) {
    scripts\mp\gametypes\obj_bombzone::bombzone_awardgenericbombzonemedals(var_1, var_0);
  }
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility::waittillrecoveredhealth(3);
  var_0 = scripts\mp\utility::getotherteam(self.pers["team"]);
  level thread scripts\mp\utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\utility::teamplayercardsplash("callout_lastenemyalive", self, var_0);
  scripts\mp\music_and_dialog::func_C54B(self);
  scripts\mp\utility::setmlgannouncement(16, self.team, self getentitynumber());
  scripts\mp\missions::lastmansd();
}

ontimelimit() {
  sd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
  foreach(var_1 in level.players) {
    if(isDefined(var_1.bombplantweapon)) {
      var_1 scripts\mp\utility::_takeweapon(var_1.bombplantweapon);
      break;
    }
  }
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.bombtimer = scripts\mp\utility::dvarfloatvalue("bombtimer", 45, 1, 300);
  level.planttime = scripts\mp\utility::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = scripts\mp\utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level.multibomb = scripts\mp\utility::dvarintvalue("multibomb", 0, 0, 1);
  level.silentplant = scripts\mp\utility::dvarintvalue("silentPlant", 0, 0, 1);
}

removebombzonec(var_0) {
  var_1 = [];
  var_2 = getEntArray("script_brushmodel", "classname");
  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_gameobjectname) && var_4.script_gameobjectname == "bombzone") {
      foreach(var_6 in var_0) {
        if(distance(var_4.origin, var_6.origin) < 100 && issubstr(tolower(var_6.script_label), "c")) {
          var_6.relatedbrushmodel = var_4;
          var_1[var_1.size] = var_6;
          break;
        }
      }
    }
  }

  foreach(var_10 in var_1) {
    var_10.relatedbrushmodel delete();
    var_11 = getEntArray(var_10.target, "targetname");
    foreach(var_13 in var_11) {
      var_13 delete();
    }

    var_10 delete();
  }

  return scripts\engine\utility::array_removeundefined(var_0);
}

bombs() {
  scripts\mp\gametypes\obj_bombzone::bombzone_setupbombcase("sd_bomb");
  level.bombzones = [];
  var_0 = getEntArray("bombzone", "targetname");
  var_0 = removebombzonec(var_0);
  level.objectives = var_0;
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = scripts\mp\gametypes\obj_bombzone::bombzone_setupobjective(var_1);
    var_2.onbeginuse = ::onbeginuse;
    var_2.onenduse = ::onenduse;
    var_2.onuse = ::onuseplantobject;
    level.bombzones[level.bombzones.size] = var_2;
  }

  for(var_1 = 0; var_1 < level.bombzones.size; var_1++) {
    var_3 = [];
    for(var_4 = 0; var_4 < level.bombzones.size; var_4++) {
      if(var_4 != var_1) {
        var_3[var_3.size] = level.bombzones[var_4];
      }
    }

    level.bombzones[var_1].otherbombzones = var_3;
  }
}

onbeginuse(var_0) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse(var_0);
  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"])) {
    if(level.multibomb) {
      for(var_1 = 0; var_1 < self.otherbombzones.size; var_1++) {
        self.otherbombzones[var_1] scripts\mp\gameobjects::allowuse("none");
        self.otherbombzones[var_1] scripts\mp\gameobjects::setvisibleteam("friendly");
      }
    }
  }
}

onenduse(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onenduse(var_0, var_1, var_2);
  if(isDefined(var_1) && !scripts\mp\gameobjects::isfriendlyteam(var_1.pers["team"])) {
    if(level.multibomb && !var_2) {
      for(var_3 = 0; var_3 < self.otherbombzones.size; var_3++) {
        self.otherbombzones[var_3] scripts\mp\gameobjects::allowuse("enemy");
        self.otherbombzones[var_3] scripts\mp\gameobjects::setvisibleteam("any");
      }
    }
  }
}

onuseplantobject(var_0) {
  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"])) {
    for(var_1 = 0; var_1 < level.bombzones.size; var_1++) {
      if(level.bombzones[var_1] == self) {
        continue;
      }

      level.bombzones[var_1] scripts\mp\gameobjects::disableobject();
    }
  }

  scripts\mp\gametypes\obj_bombzone::bombzone_onuseplantobject(var_0);
}

setspecialloadout() {
  if(isusingmatchrulesdata() && scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", game["attackers"], 5, "class", "inUse")) {
    level.sd_loadout[game["attackers"]] = ::scripts\mp\utility::getmatchrulesspecialclass(game["attackers"], 5);
  }
}

onbombexploded(var_0, var_1, var_2, var_3, var_4) {
  if(var_3 == game["attackers"]) {
    setgameendtime(0);
    wait(3);
    sd_endgame(game["attackers"], game["end_reason"]["target_destroyed"]);
    return;
  }

  wait(1.5);
  setgameendtime(0);
  sd_endgame(game["defenders"], game["end_reason"]["bomb_defused"]);
}