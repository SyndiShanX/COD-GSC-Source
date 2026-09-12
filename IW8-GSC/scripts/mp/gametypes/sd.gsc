/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\sd.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_sd_bombtimer", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("scr_sd_planttime", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("scr_sd_defusetime", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("scr_sd_multibomb", getmatchrulesdata("bombData", "multiBomb"));
  setdynamicdvar("scr_sd_silentPlant", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("scr_sd_resetprogress", getmatchrulesdata("bombData", "resetProgress"));
  setdynamicdvar("scr_sd_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("sd", 0);
  setdynamicdvar("scr_sd_promode", 0);
}

function waittooverridegraceperiod() {
  if(scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::islaststandenabled()) {
    game["dialog"]["gametype"] = "gametype_sandrescue";
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
}

function onprecachegametype() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

function onstartgametype() {
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
  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
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
  thread bombs();
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_sd_spawn_attacker");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_sd_spawn_defender");

  if(level.mapname == "mp_m_speedball" || level.mapname == "mp_m_overunder" || level.mapname == "mp_m_overwinter") {
    var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_defender");
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
  } else if(level.mapname == "mp_petrograd") {
    var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_defender", 1);
  } else {
    var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_defender");
  }

  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
  var_0 = self.pers["team"];

  if(var_0 == game["attackers"]) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "start_defenders");
  }

  return var_1;
}

function onspawnplayer() {
  self setclientomnvar("ui_match_status_hint_text", -1);

  if(scripts\mp\utility\entity::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    self.laststanding = 0;
  }

  if(level.multibomb && self.pers["team"] == game["attackers"]) {
    self setclientomnvar("ui_carrying_bomb", 1);
  } else {
    self setclientomnvar("ui_carrying_bomb", 0);

    foreach(var_1 in level.objectives) {
      var_1.trigger disableplayeruse(self);
    }
  }

  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::setextrascore0(self.pers["plants"]);
  }

  scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(self.pers["defuses"])) {
    scripts\mp\utility\stats::setextrascore1(self.pers["defuses"]);
  }

  level notify("spawned_player");
  thread updatematchstatushintonspawn();
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("ui_carrying_bomb", 0);
  thread checkallowspectating();
}

function checkallowspectating() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0) {
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function sd_endgame(var_0, var_1) {
  setomnvarforallclients("ui_objective_state", 0);
  setomnvar("ui_bomb_interacting", 0);
  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

function trial_race_lap_total() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.isplanting) && isDefined(var_1.lastnonuseweapon)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1.lastnonuseweapon);
      break;
    }
  }
}

function ondeadevent(var_0) {
  trial_race_lap_total();

  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }

  if(var_0 == "all") {
    if(level.bombplanted) {
      sd_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
      return;
    }

    sd_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    return;
  }

  if(var_0 == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }

    thread sd_endgame(level, game["defenders"]);
    return;
  }

  if(var_0 == game["defenders"]) {
    thread sd_endgame(level, game["attackers"]);
    return;
  }
}

function ononeleftevent(var_0) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }

  var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);
  var_1.laststanding = 1;
  thread givelastonteamwarning();
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = scripts\mp\rank::getscoreinfovalue("kill");
  var_7 = var_0.team;
  var_8 = 0;

  if(isDefined(var_1.laststanding) && var_1.laststanding) {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("last_man_kill");
  }

  if(var_0.isplanting) {
    scripts\mp\utility\game::ref_119AC(var_0, var_1, "Bomb Carrier Killed", var_0.origin, "was_planting_bomb");
    thread scripts\common\utility::ref_13E0A(level.ref_11B30, var_2, "planting");
    var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    var_1 thread scripts\mp\awards::givemidmatchaward("mode_sd_plant_save");
    var_8 = 1;
  } else if(var_0.isbombcarrier) {
    scripts\mp\utility\game::ref_119AC(var_0, var_1, "Bomb Carrier Killed", var_0.origin);
    thread scripts\common\utility::ref_13E0A(level.ref_11B30, var_2, "carrying");
  } else if(var_0.isdefusing) {
    scripts\mp\utility\game::ref_119AC(var_0, var_1, "Defuser Killed", var_0.origin);
    thread scripts\common\utility::ref_13E0A(level.ref_11B30, var_2, "defusing");
    var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    var_1 thread scripts\mp\awards::givemidmatchaward("mode_sd_defuse_save");
    var_8 = 1;
  }

  if(isDefined(level.sdbomb.carrier)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != var_0.pers["team"]) {
      if(var_1.pers["team"] == level.sdbomb.carrier.team && var_1 != level.sdbomb.carrier) {
        var_9 = distancesquared(level.sdbomb.carrier.origin, var_1.origin);

        if(var_9 < 105625) {
          var_1 thread scripts\mp\rank::scoreeventpopup("defend");
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
          var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
          var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
          thread scripts\common\utility::ref_13E0A(level.ref_11B30, var_2, "defending");
          var_8 = 1;
        }
      }
    }
  }

  if(!var_8) {
    scripts\mp\gametypes\obj_bombzone::bombzone_awardgenericbombzonemedals(var_1, var_0);
    return;
  }
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "inform_last_one");
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
  scripts\mp\utility\game::setmlgannouncement(3, self.team, self getentitynumber());
}

function ontimelimit() {
  sd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);

  foreach(var_1 in level.players) {
    if(isDefined(var_1.bombplantweapon)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.bombplantweapon);
      break;
    }
  }

  scripts\mp\utility\game::ref_119AC(undefined, undefined, "Time Limit Reached");
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue("bombtimer", 45, 1, 240);
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("defusetime", 5, 0, 20);
  level.multibomb = scripts\mp\utility\dvars::dvarintvalue("multibomb", 0, 0, 1);
  level.silentplant = scripts\mp\utility\dvars::dvarintvalue("silentPlant", 0, 0, 1);
  level.resetprogress = scripts\mp\utility\dvars::dvarintvalue("resetProgress", 0, 0, 1);
}

function removebombzonec(var_0) {
  var_1 = [];
  var_2 = getEntArray("script_brushmodel", "classname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_gameobjectname) && var_4.script_gameobjectname == "bombzone") {
      foreach(var_6 in var_0) {
        if(distance(var_4.origin, var_6.origin) < 100 && issubstr(tolower(var_6.script_label), "c")) {
          var_6.relatedbrushmodel = var_4;
          var_1 = var_6;
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

function bombs() {
  scripts\mp\gametypes\obj_bombzone::bombzone_setupbombcase("sd_bomb");
  var_0 = getEntArray("bombzone", "targetname");
  var_0 = removebombzonec(var_0);
  level.objectives = [];

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\gametypes\obj_bombzone::setupobjective(var_2, 1, 1);
    var_3.onbeginuse = &onbeginuse;
    var_3.onenduse = &onenduse;
    var_3.onuse = &onuseplantobject;
    level.objectives[var_3.objectivekey] = var_3;
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143A5("prematch_done", "start_mode_setup");
  }

  level.sdbomb scripts\mp\gameobjects::requestid(1, 1, 2);
  level.sdbomb scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb");
  level.sdbomb scripts\mp\gameobjects::setvisibleteam("friendly");
  level.sdbombmodel = level.sdbomb.visuals[0];
  level.sdbombmodel scripts\mp\gametypes\obj_bombzone::setteaminhuddatafromteamname(game["attackers"]);
  level.sdbombmodel setasgametypeobjective();
  hastacvis(level.sdbomb.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(level.sdbomb.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.sdbomb.objidnum, 0);

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    wait 0.5;
  }

  foreach(var_3 in level.objectives) {
    var_6 = scripts\mp\gametypes\obj_bombzone::getreservedobjid(var_3.objectivekey);
    var_3 scripts\mp\gameobjects::requestid(1, 1, var_6);
    var_3 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    var_3 scripts\mp\gameobjects::setvisibleteam("any");
  }
}

function onbeginuse(var_0) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse(var_0);

  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"])) {
    if(level.multibomb) {
      if(self.objectivekey == "_a") {
        level.objectives["_b"] scripts\mp\gameobjects::allowuse("none");
        level.objectives["_b"] scripts\mp\gameobjects::setvisibleteam("friendly");
        return;
      }

      level.objectives["_a"] scripts\mp\gameobjects::allowuse("none");
      level.objectives["_a"] scripts\mp\gameobjects::setvisibleteam("friendly");
      return;
    }

    return;
  }
}

function onenduse(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onenduse(var_0, var_1, var_2);

  if(isDefined(var_1) && !scripts\mp\gameobjects::isfriendlyteam(var_1.pers["team"])) {
    if(level.multibomb && !var_2) {
      if(self.objectivekey == "_a") {
        level.objectives["_b"] scripts\mp\gameobjects::allowuse("enemy");
        level.objectives["_b"] scripts\mp\gameobjects::setvisibleteam("any");
        return;
      }

      level.objectives["_a"] scripts\mp\gameobjects::allowuse("enemy");
      level.objectives["_a"] scripts\mp\gameobjects::setvisibleteam("any");
      return;
    }

    return;
  }
}

function onuseplantobject(var_0) {
  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"])) {
    foreach(var_2 in level.objectives) {
      if(var_2 == self) {
        continue;
      }

      var_2 scripts\mp\gameobjects::disableobject();
    }
  }

  scripts\mp\gametypes\obj_bombzone::bombzone_onuseplantobject(var_0);
  scripts\mp\utility\game::ref_119AC(var_0, undefined, "Bomb Planted", var_0.origin);
  thread scripts\mp\music_and_dialog::bombplanted_music();
}

function setspecialloadout() {
  if(isusingmatchrulesdata() && scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", game["attackers"], 5, "class", "inUse")) {
    level.sd_loadout[game["attackers"]] = scripts\mp\utility\game::getmatchrulesspecialclass(game["attackers"], 5);
    return;
  }
}

function onbombexploded(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level.nukeincoming)) {
    return;
  }

  if(var_3 == game["attackers"]) {
    setgameendtime(0);
    wait 3;
    scripts\mp\utility\game::ref_119AC(undefined, undefined, "Target Destroyed");
    sd_endgame(game["attackers"], game["end_reason"]["target_destroyed"]);
    return;
  }

  wait 1.5;
  setgameendtime(0);
  sd_endgame(game["defenders"], game["end_reason"]["bomb_defused"]);
}

function updatematchstatushintonspawn() {
  if(level.bombplanted) {
    if(game["attackers"] == self.team) {
      self setclientomnvar("ui_match_status_hint_text", 22);
      return;
    }

    self setclientomnvar("ui_match_status_hint_text", 23);
    return;
  }

  if(isDefined(level.sdbomb)) {
    if(isDefined(level.sdbomb.carrier)) {
      if(level.sdbomb.carrier.team == self.team) {
        if(level.sdbomb.carrier == self) {
          self setclientomnvar("ui_match_status_hint_text", 21);
          return;
        }

        self setclientomnvar("ui_match_status_hint_text", 25);
        return;
      }

      self setclientomnvar("ui_match_status_hint_text", 26);
      return;
    }

    if(game["attackers"] == self.team) {
      self setclientomnvar("ui_match_status_hint_text", 24);
      return;
    }

    self setclientomnvar("ui_match_status_hint_text", 26);
    return;
  }

  self setclientomnvar("ui_match_status_hint_text", -1);
}