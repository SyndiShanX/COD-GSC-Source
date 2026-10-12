/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\xfire.gsc
***********************************************/

#using script_3bdadfff7554ceba;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\damage;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arena;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\pmc_missions;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spectating;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\teams;
#namespace xfire;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 600);
    registerscorelimitdvar(getgametype(), 75);
    registerroundlimitdvar(getgametype(), 1);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
    function_704789086c9ad943(getgametype(), 1);
  }

  updategametypedvars();
  level.ontimelimit = &ontimelimit;
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.onnormaldeath = &onnormaldeath;
  level.onplayerkilled = &onplayerkilled;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerconnect = &onplayerconnect;
  level.ontimelimitot = &ontimelimitot;
  level.checkforlaststandwipe = &function_cf32b8de85ca585a;
  level.objectivebased = 1;
  level.overridetimelimitclock = 15;

  if(!getdvarint(@ "hash_d398d397afae6d0", 0)) {
    level.allowlatecomers = 0;
  }

  game["dialog"]["gametype"] = "dx_mp_mcut_mode_t141_name";

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint(@ "camera_thirdperson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "iw9_mtdm_mode_uktl_bost";
  game["dialog"]["offense_obj"] = "iw9_mtdm_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_mtdm_mode_uktl_bost";
  game["dialog"]["team_eliminated"] = "dx_mp_mcut_mode_t141_telm";
  level.allieshealth = 0;
  level.alliesmaxhealth = 0;
  level.axishealth = 0;
  level.axismaxhealth = 0;
  level.var_20cde17a79b3e90e = 0;
  level.var_9d074c5a0f4e7d84 = 0;
  setomnvar("ui_arena_allies_health", 0);
  setomnvar("ui_arena_axis_health", 0);
  setomnvar("ui_arena_team_three_health", 0);
  setomnvar("ui_arena_allies_health_max", 100);
  setomnvar("ui_arena_axis_health_max", 100);
  setomnvar("ui_arena_team_three_health_max", 100);
  level.testtdmanywhere = getdvarint(@ "scr_tdmanywhere", 0);
  level.tdmanywhere_dropheight = getdvarfloat(@ "hash_c692d2a11dd6615", 1000);
  level.tdmanywhere_perpenoffset = getdvarfloat(@ "hash_631c58033f43c2dc", 2048);
  level.tdmanywhere_distoffset = getdvarfloat(@ "hash_f314048c87ae28aa", 4092);

  if(istrue(level.testtdmanywhere)) {
    scripts\cp_mp\parachute::initparachutedvars();
  }

  if(matchmakinggame()) {
    level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
  }

  level thread outlinemultiteam();

  level.reinitspawns = &reinitspawns;

  namespace_2c19af30dc7a566c::function_4a18dd73a966821e(3);
  namespace_2c19af30dc7a566c::function_6cce72ce8bb6af87(["allies", "axis", "team_three"]);
}

function onplayerconnect(player) {
  player thread onjoinedteam();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
}

function onplayerdisconnect(player) {
  setteamhealthhud(1);
}

function onjoinedteam() {
  level endon("game_ended");

  for(;;) {
    waittill_any_2("joined_team", "joined_spectators");
    setteamhealthhud();
  }
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_6e7da31aae47b8e0", 0);
  registerhalftimedvar(getgametype(), 0);
  setdynamicdvar(@ "hash_bb6e8f8d9be104f4", 0);
  setdynamicdvar(@ "hash_54b0839b770554b3", getmatchrulesdata("arenaData", "blastShieldMod"));
  setdynamicdvar(@ "hash_928b4e51b473632c", getmatchrulesdata("arenaData", "blastShieldClamp"));
  setdynamicdvar(@ "hash_9ad50234c5ffaf1d", getmatchrulesdata("arenaData", "winCondition"));
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/WAR_HINT");
  }

  if(isDefined(level.initspawnsoverridefunc)) {
    [[level.initspawnsoverridefunc]]();
  } else {
    initspawns();
  }

  if(game["roundsPlayed"] == 0) {
    level thread scripts\mp\gametypes\arena::setroundwinstreakarray();
  }

  setupwaypointicons();
  seticonnames();
  thread scripts\mp\gametypes\arena::waittooverridegraceperiod();
  scripts\mp\gametypes\bradley_spawner::inittankspawns();

  if(getdvarint(@ "hash_cd7a289c3a33ceda", 0) != 0) {
    thread monitorhotfoot();
  }

  level thread spawngameendflagzone(1);

  thread function_8469a5927d069db7();

  if(false) {
    function_bf2918399f1800b1();
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.overtimeflag = dvarfloatvalue("overtimeFlag", 10, 0, 30);

  if(level.overtimeflag > 0) {
    level.ontimelimitgraceperiod = level.overtimeflag;
    level.currenttimelimitdelay = 0;
    level.canprocessot = 1;
  }

  level.wincondition = dvarintvalue("winCondition", 1, 0, 2);
  setomnvar("ui_wincondition", level.wincondition);
  level.objmodifier = dvarintvalue("objModifier", 0, 0, 4);
  level.flagcapturetime = dvarfloatvalue("flagCaptureTime", 3, 0, 30);
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else if(getdvarint(@ "t10", 0) > 0) {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  } else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", spawns);
  scripts\mp\spawnlogic::registerspawnset("fallback", spawnssecondary);

  if(istrue(level.testtdmanywhere)) {
    x = getdvarfloat(@ "hash_b6294c84c04e377b", randomfloatrange(-4096, 4096));
    y = getdvarfloat(@ "hash_b6294b84c04e3548", randomfloatrange(-4096, 4096));
    z = getdvarfloat(@ "hash_b6294e84c04e3be1", randomfloatrange(0, 512));
    level.mapcenter = (x, y, z);
    tdmanywhere_debugshowlocs();
    return;
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function reinitspawns() {
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x1c>");
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x26>");
  spawns = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x32>");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x42>");
  scripts\mp\spawnlogic::registerspawnset("<dev string:x1c>", spawns);
  scripts\mp\spawnlogic::registerspawnset("<dev string:x26>", spawnssecondary);
}

function getspawnpoint() {
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(!isDefined(level.var_63daaf90ccfeb639)) {
    level.var_63daaf90ccfeb639 = [];
  }

  if(!isDefined(level.var_63daaf90ccfeb639[spawnteam])) {
    level.var_63daaf90ccfeb639[spawnteam] = [];
  }

  var_cafc02fbf308d35b = level.teamnamelist;

  for(i = 0; i < game["roundsPlayed"]; i++) {
    var_cafc02fbf308d35b = array_add(var_cafc02fbf308d35b, var_cafc02fbf308d35b[0]);
    var_cafc02fbf308d35b = array_slice(var_cafc02fbf308d35b, 1, level.teamnamelist.size + 1);
  }

  teams_key = [];

  foreach(index, team in level.teamnamelist) {
    teams_key[team] = var_cafc02fbf308d35b[index];
  }

  spawns = getspawnarray("mp_xfire_spawn_" + teams_key[spawnteam] + "_start");

  foreach(spawner in spawns) {
    if(isDefined(level.mapname) && level.mapname == "mp_jup_karachi") {
      if(isDefined(spawner.classname) && spawner.classname == "mp_xfire_spawn_allies_start") {
        if(isDefined(spawner.origin)) {
          if(spawner.origin[0] == 288 && spawner.origin[1] == 2416) {
            continue;
          }
        }
      }
    }

    if(isDefined(level.var_63daaf90ccfeb639[spawnteam][spawner.index])) {
      continue;
    }

    level.var_63daaf90ccfeb639[spawnteam][spawner.index] = spawner;
    return spawner;
  }

  return random(spawns);
}

function spawngameendflagzone(ispreview) {
  arenaflag = getEntArray("flag_xfire", "targetname");

  if(arenaflag.size == 0) {
    assertmsg("<dev string:x5c>");
    return;
  }

  var_43ff7da364738b0a = randomint(arenaflag.size);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_ot", 0, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0);
  level.arenaflag = arenaflag[var_43ff7da364738b0a];
  trigger = arenaflag[var_43ff7da364738b0a];

  if(isDefined(trigger.target)) {
    visuals[0] = getEnt(trigger.target, "targetname");
  } else {
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0].angles = trigger.angles;
  }

  trigger.objectivekey = "_a";
  trigger.iconname = "_a";
  arenaflag = scripts\mp\gametypes\obj_dom::setupobjective(trigger, "neutral", undefined, 1);
  arenaflag.iconname = "";
  arenaflag.onuse = &function_865ee3863054db0a;
  arenaflag.onbeginuse = &scripts\mp\gametypes\arena::arenaflag_onusebegin;
  arenaflag.onenduse = &scripts\mp\gametypes\arena::arenaflag_onuseend;
  arenaflag.onuseupdate = &scripts\mp\gametypes\arena::arenaflag_onuseupdate;
  arenaflag.oncontested = &scripts\mp\gametypes\arena::arenaflag_oncontested;
  arenaflag.onuncontested = &scripts\mp\gametypes\arena::arenaflag_onuncontested;
  arenaflag.isarena = 1;
  arenaflag scripts\mp\gameobjects::pinobjiconontriggertouch();
  arenaflag.id = "domFlag";
  arenaflag.scriptable delete();
  arenaflag scripts\mp\gameobjects::setcapturebehavior("persistent");
  arenaflag.ignorestomp = 1;
  level.objectives[arenaflag.objectivekey] = arenaflag;
  level.arenaflag = arenaflag;
  level thread function_439c040e29fb9b3d();

  if(istrue(ispreview)) {
    wait 0.1;
    level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
    level.arenaflag.visibleteam = "any";
    level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_locked");
    level.arenaflag scripts\mp\gameobjects::enableobject();
    level.arenaflag scripts\mp\gameobjects::allowuse("none");
    level.arenaflag.flagmodel show();
    return;
  }

  level.arenaflag scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
  level.arenaflag scripts\mp\gametypes\arena::disableotflag();
}

function function_439c040e29fb9b3d() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.arenaflag thread scripts\mp\gameobjects::function_d36dcacac1708708(getwatcheddvar("timeLimit"));
}

function function_59176f33753f0b5b() {
  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  level.arenaflag.iconname = "_a";
  level thread scripts\mp\gametypes\arena::shouldplayerovertimedialog();
  level thread scripts\mp\gametypes\arena::showflagoutline();
  level.arenaflag scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  level.arenaflag scripts\mp\gameobjects::allowuse("enemy");
  level notify("ot_enabled");
  level.arenaflag.flagmodel playSound("jup_shared_zone_spawned");
  scripts\mp\music_and_dialog::function_6c71c8bc6495a0df("generic");
}

function function_865ee3863054db0a(credit_player) {
  level.canprocessot = 1;
  team = credit_player.pers["team"];
  oldteam = scripts\mp\gameobjects::getownerteam();
  otherteam1 = getotherteam(team)[0];
  otherteam2 = getotherteam(team)[1];
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  self.capturetime = gettime();
  self.neutralized = 0;
  scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam1);
  scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam2);
  scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, team);
  thread printandsoundoneveryone(team, otherteam1, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player);
  thread printandsoundoneveryone(team, otherteam2, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player);
  scripts\mp\gametypes\obj_dom::dompoint_setcaptured(team, credit_player);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, credit_player, team, oldteam, self);
    }

    self.firstcapture = 0;
  }

  game["dialog"]["round_success"] = "dx_mp_gunf_game_t141_gfsd";
  game["dialog"]["round_failure"] = "dx_mp_gunf_game_t141_gflt";
  level thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["arena_otflag_completed"], game["end_reason"]["arena_otflag_failed"]);
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");
  thread onspawnfinished();

  if(getdvarint(@ "hash_d398d397afae6d0", 0) && game["roundsPlayed"] == 0) {
    level thread function_d2e1978421f560a8(self.pers["team"]);
  }

  if(!istrue(level.testtdmanywhere)) {
    return;
  }

  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

function onspawnfinished() {
  self endon("death_or_disconnect");
  thread damagewatcher();
  thread scripts\mp\gametypes\arena::modifyblastshieldperk();
  wait 0.1;
  self.hasarenaspawned = 1;
  wait 0.15;

  if(!scripts\mp\flags::gameflag("prematch_done") && game["roundsPlayed"] == 0) {
    if(level.overtimeflag > 0 && isDefined(level.matchcountdowntime) && level.matchcountdowntime > 5) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        scripts\mp\utility\dialog::leaderdialogonplayer("obj_indepth", "introboost");
      }
    }

    level waittill_any_2("prematch_done", "removeArenaOutlines");
  }

  self setclientomnvar("ui_player_notify_loadout", gettime());
}

function setteamhealthhud(isdisconnect) {
  var_586dc9dc0cf668ad = getdvarint(@ "scr_player_maxhealth", 100);
  alliesplayers = getteamdata("allies", "teamCount");

  if(alliesplayers) {
    level.alliesmaxhealth = getteamdata("allies", "teamCount") * var_586dc9dc0cf668ad;
    setomnvar("ui_arena_allies_health_max", level.alliesmaxhealth);

    if(!istrue(isdisconnect) && !isreallyalive(self) && scripts\mp\playerlogic::mayspawn()) {
      self waittill("spawned_player");
    }

    allieshealth = 0;

    foreach(player in getteamdata("allies", "players")) {
      allieshealth += player.health;
    }

    level.allieshealth = allieshealth;

    if(level.allieshealth < 0) {
      level.allieshealth = 0;
    }

    setomnvar("ui_arena_allies_health", level.allieshealth);
  } else {
    setomnvar("ui_arena_allies_health", 0);
  }

  axisplayers = getteamdata("axis", "teamCount");

  if(axisplayers) {
    level.axismaxhealth = getteamdata("axis", "teamCount") * var_586dc9dc0cf668ad;
    setomnvar("ui_arena_axis_health_max", level.axismaxhealth);

    if(!istrue(isdisconnect) && !isreallyalive(self) && scripts\mp\playerlogic::mayspawn()) {
      self waittill("spawned_player");
    }

    axishealth = 0;

    foreach(player in getteamdata("axis", "players")) {
      axishealth += player.health;
    }

    level.axishealth = axishealth;

    if(level.axishealth < 0) {
      level.axishealth = 0;
    }

    setomnvar("ui_arena_axis_health", level.axishealth);
  } else {
    setomnvar("ui_arena_axis_health", 0);
  }

  var_8d5953d1ee8e59fa = getteamdata("team_three", "teamCount");

  if(var_8d5953d1ee8e59fa) {
    level.var_9d074c5a0f4e7d84 = getteamdata("team_three", "teamCount") * var_586dc9dc0cf668ad;
    setomnvar("ui_arena_team_three_health_max", level.var_9d074c5a0f4e7d84);

    if(!istrue(isdisconnect) && !isreallyalive(self) && scripts\mp\playerlogic::mayspawn()) {
      self waittill("spawned_player");
    }

    var_20cde17a79b3e90e = 0;

    foreach(player in getteamdata("team_three", "players")) {
      var_20cde17a79b3e90e += player.health;
    }

    level.var_20cde17a79b3e90e = var_20cde17a79b3e90e;

    if(level.var_20cde17a79b3e90e < 0) {
      level.var_20cde17a79b3e90e = 0;
    }

    setomnvar("ui_arena_team_three_health", level.var_20cde17a79b3e90e);
    return;
  }

  setomnvar("ui_arena_team_three_health", 0);
}

function damagewatcher() {
  self notify("startDamageWatcher");
  self endon("startDamageWatcher");
  level endon("game_ended");
  self endon("disconnect");
  self.totaldamagetaken = 0;

  while(true) {
    waittill_any_7("damage", "force_regeneration", "removeAdrenaline", "healed", "naturalHealthRegen", "vampirism", "spawned_player");

    if(self.team == "allies") {
      allieshealth = 0;

      foreach(player in getteamdata("allies", "players")) {
        allieshealth += player.health;
      }

      level.allieshealth = allieshealth;

      if(level.allieshealth < 0) {
        level.allieshealth = 0;
      }

      setomnvar("ui_arena_allies_health", level.allieshealth);
    } else if(self.team == "axis") {
      axishealth = 0;

      foreach(player in getteamdata("axis", "players")) {
        axishealth += player.health;
      }

      level.axishealth = axishealth;

      if(level.axishealth < 0) {
        level.axishealth = 0;
      }

      setomnvar("ui_arena_axis_health", level.axishealth);
    } else if(self.team == "team_three") {
      var_20cde17a79b3e90e = 0;

      foreach(player in getteamdata("team_three", "players")) {
        var_20cde17a79b3e90e += player.health;
      }

      level.var_20cde17a79b3e90e = var_20cde17a79b3e90e;

      if(level.var_20cde17a79b3e90e < 0) {
        level.var_20cde17a79b3e90e = 0;
      }

      setomnvar("ui_arena_team_three_health", level.var_20cde17a79b3e90e);
    }

    if(istrue(self.iscapturing)) {
      objflag = undefined;
    }
  }
}

function function_d2e1978421f560a8(playerteam) {
  if(istrue(level.var_bdeb0ef07db14d92)) {
    return;
  }

  level.var_bdeb0ef07db14d92 = 1;

  foreach(team in ["allies", "axis", "team_three"]) {
    count = 3;

    if(is_equal(team, playerteam)) {
      count = 2;
    }

    level thread scripts\mp\bots\bots::spawn_bots(count, team);
  }
}

function outlinemultiteam() {
  while(!isDefined(level.players)) {
    waitframe();
  }

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    foreach(player in level.players) {
      foreach(other in level.players) {
        if(is_equal(player.pers["team"], other.pers["team"])) {
          continue;
        }

        player hudoutlineenableforclient(other, "outline_nodepth_orange");
      }
    }

    wait 0.5;
  }

  foreach(player in level.players) {
    player hudoutlinedisable();
  }
}

function spawncompare(spawnpoint, spawnteam) {
  if(getdvarint(@ "hash_b5ceec3e3cb419be") != 0) {
    spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints(spawnteam);
    fallbackspawnpoints = [];
    scriptspawnpoint = scripts\mp\spawnscoring::getspawnpoint_legacy(spawnpoints, fallbackspawnpoints);

    if(!isDefined(level.var_3d292942d52b104a)) {
      level.var_3d292942d52b104a = 0;
      level.var_2dc7108159dc1da3 = 0;
      level.var_a065445ba781ddf6 = 0;
    }

    level.var_3d292942d52b104a++;
    println("<dev string:x7f>" + scriptspawnpoint.index + "<dev string:x9a>" + scriptspawnpoint.totalscore);

    if(scriptspawnpoint.index == spawnpoint.index) {
      level.var_2dc7108159dc1da3++;
      iprintlnbold("<dev string:xb0>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xcf>" + "<dev string:xdd>" + level.var_2dc7108159dc1da3 + "<dev string:xe2>" + level.var_3d292942d52b104a);
    } else {
      level.var_a065445ba781ddf6++;
      iprintlnbold("<dev string:xe7>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xcf>" + "<dev string:xdd>" + level.var_2dc7108159dc1da3 + "<dev string:xe2>" + level.var_3d292942d52b104a);
    }

    return scriptspawnpoint;
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
  attackerplayers = scripts\mp\utility\teams::getteamdata(attacker.pers["team"], "players");
  victimplayers = scripts\mp\utility\teams::getteamdata(self.pers["team"], "players");

  foreach(player in victimplayers) {
    if(is_equal(self, player)) {
      continue;
    }

    if(isreallyalive(player) && !istrue(player.inlaststand)) {
      return;
    }
  }

  thread checkallowspectating(self.pers["team"]);

  if(istrue(level.var_2f9531754ad48a56)) {
    return;
  }

  level.var_2f9531754ad48a56 = 1;

  foreach(player in attackerplayers) {
    player scripts\mp\utility\dialog::leaderdialogonplayer("team_eliminated");
  }
}

function checkallowspectating(eliminatedteam) {
  level.spectateoverride[eliminatedteam].allowenemyspectate = 1;
  scripts\mp\spectating::updatespectatesettings();
}

function function_cf32b8de85ca585a(victim, islaststanddeath) {
  if(isDefined(level.var_f44d8c2d0a8691a8)) {
    return 0;
  }

  level.var_f44d8c2d0a8691a8 = 1;
  var_f22fb09a173dcc1c = [];
  killedvictim = 0;
  var_6a9853a7ef309b8f = [];
  var_fa2dfb970d051f16 = [];

  foreach(entry in level.teamnamelist) {
    var_b1fd2c57a16c6e04 = 1;
    var_f22fb09a173dcc1c = [];
    var_7b618684adbe33f6 = 0;

    foreach(player in level.teamdata[entry]["alivePlayers"]) {
      if(istrue(islaststanddeath) && isDefined(victim) && victim == player) {
        var_7b618684adbe33f6 = 1;
        continue;
      }

      isinlaststand = istrue(player.inlaststand) || isDefined(victim) && victim == player;

      if(isinlaststand) {
        var_f22fb09a173dcc1c[var_f22fb09a173dcc1c.size] = player;
        continue;
      }

      var_b1fd2c57a16c6e04 = 0;
      break;
    }

    if(var_b1fd2c57a16c6e04 && (var_f22fb09a173dcc1c.size > 0 || istrue(islaststanddeath) && var_7b618684adbe33f6)) {
      attackers = [];

      foreach(var_e3d55abd84ad4ca9 in var_f22fb09a173dcc1c) {
        if(isDefined(var_e3d55abd84ad4ca9.laststandattacker) && !array_contains(attackers, var_e3d55abd84ad4ca9.laststandattacker)) {
          var_e3d55abd84ad4ca9.laststandattacker.wipeweapon = var_e3d55abd84ad4ca9.laststandweaponobj;
          attackers[attackers.size] = var_e3d55abd84ad4ca9.laststandattacker;
        }

        if(isDefined(victim) && victim == var_e3d55abd84ad4ca9) {
          killedvictim = 1;
        }

        var_e3d55abd84ad4ca9 notify("squad_wipe_death");
        var_e3d55abd84ad4ca9.squadwiped = 1;

        if(getdvarint(@ "hash_30ac4415ff58708e", 0)) {
          var_e3d55abd84ad4ca9.playergoingintols = 0;
        }

        var_e3d55abd84ad4ca9 scripts\mp\utility\damage::_suicide(0);
      }

      if(istrue(islaststanddeath) && isDefined(victim) && isDefined(victim.laststandattacker) && !array_contains(attackers, victim.laststandattacker)) {
        attackers[attackers.size] = victim.laststandattacker;
      }

      foreach(attacker in attackers) {
        if(isDefined(attacker.team) && !isDefined(var_fa2dfb970d051f16[attacker.team])) {
          var_fa2dfb970d051f16[attacker.team] = 1;
          attackerteammates = level.teamdata[attacker.team]["alivePlayers"];

          foreach(attackerteammate in attackerteammates) {
            attackerteammate thread scripts\mp\events::killeventtextpopup(#"team_wiped", 0);
            attackerteammate thread scripts\mp\utility\points::doscoreevent(#"team_wiped", attackerteammate.wipeweapon);
          }

          wipeweapon = self.laststandweaponobj;

          if(!isDefined(wipeweapon)) {
            if(isDefined(victim) && isDefined(victim.laststandattacker)) {
              wipeweapon = victim.laststandattacker.currentweapon;
            } else {
              wipeweapon = attacker.currentweapon;
            }
          }
        }

        attacker.wipeweapon = undefined;

        if(!isDefined(var_6a9853a7ef309b8f[attacker.team]) && !scripts\mp\damage::function_80ade967129c9845()) {}
      }

      scripts\mp\pmc_missions::onsquadwiped(attackers);
    }
  }

  level.var_f44d8c2d0a8691a8 = undefined;
  return killedvictim;
}

function ontimelimit() {
  if(level.gameended) {
    return;
  }

  updatetournamentroundtime(scripts\mp\gamelogic::gettimeremaining(), 3);

  if(function_2eda32f1d16ded2c()) {
    if(level.var_59a1f917fb3131a6 != "neutral") {
      level thread scripts\mp\gamelogic::endgame(level.var_59a1f917fb3131a6, game["end_reason"]["ko_flag_win"], game["end_reason"]["ko_flag_loss"]);
    } else if(level.wincondition == 1) {
      checkliveswinner();
    } else if(level.wincondition == 2) {
      checkhealthwinner();
    } else {
      checkhealthwinner();
    }

    return;
  }

  if(level.wincondition == 1) {
    checkliveswinner();
    return;
  }

  if(level.wincondition == 2) {
    checkhealthwinner();
    return;
  }

  checkhealthwinner();
}

function checkhealthwinner() {
  winningteam = getwinningteam();

  if(isDefined(winningteam)) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread arena_endgame(winningteam, game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
    return;
  }

  if(matchmakinggame()) {
    if(isintournament()) {
      game["canScoreOnTie"] = 1;

      if(game["finalRound"] == 1) {
        game["canScoreOnTie"] = 0;

        if(!isDefined(game["roundsTied"])) {
          game["roundsTied"] = 1;
        } else {
          game["roundsTied"]++;
        }

        if(game["roundsTied"] >= 2) {
          betterteam = scripts\mp\gamelogic::getbetterteam();
          thread scripts\mp\gamelogic::endgame(betterteam, game["end_reason"]["arena_tournament_tie_win"], game["end_reason"]["arena_tournament_tie_loss"]);
        } else {
          thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
        }
      } else {
        thread arena_endgame("tie", game["end_reason"]["cyber_tie"]);
      }
    } else {
      if(!isDefined(game["roundsTied"])) {
        game["roundsTied"] = 1;
      } else {
        game["roundsTied"]++;
      }

      game["canScoreOnTie"] = game["roundsTied"] >= 2;

      if(game["canScoreOnTie"]) {
        thread arena_endgame("tie", game["end_reason"]["cyber_tie"]);
      } else {
        thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
      }
    }

    return;
  }

  thread arena_endgame("tie", game["end_reason"]["time_limit_reached"]);
}

function getwinningteam() {
  teams = level.teamnamelist;
  teams = array_sort_with_func(teams, &function_857670a0af36d589);
  var_2ee2c5f98c074b1f = function_6fcd898faf41205d();

  if(is_equal(var_2ee2c5f98c074b1f[teams[0]], var_2ee2c5f98c074b1f[teams[1]])) {
    return undefined;
  }

  return teams[0];
}

function function_857670a0af36d589(left, right) {
  var_2ee2c5f98c074b1f = function_6fcd898faf41205d();
  return var_2ee2c5f98c074b1f[left] >= var_2ee2c5f98c074b1f[right];
}

function function_6fcd898faf41205d() {
  var_2ee2c5f98c074b1f = [];
  var_2ee2c5f98c074b1f["axis"] = level.axishealth;
  var_2ee2c5f98c074b1f["allies"] = level.allieshealth;
  var_2ee2c5f98c074b1f["team_three"] = level.var_20cde17a79b3e90e;
  return var_2ee2c5f98c074b1f;
}

function arena_endgame(winningteam, endreasontext, endreasontextloss, nukedetonated, var_8e4a26ed257a393b) {
  if(winningteam != "tie") {
    game["roundsTied"] = 0;
    game["previousWinningTeam"] = winningteam;

    foreach(entry in level.teamnamelist) {
      if(entry == winningteam) {
        game["roundWinStreak"][winningteam]++;
        continue;
      }

      game["roundWinStreak"][entry] = 0;
    }

    if(!iswinbytworulegametype()) {
      switch (game["roundWinStreak"][winningteam]) {
        case 2:
          game["dialog"]["round_success"] = "round_win_streak_2";
          break;
        case 3:
          game["dialog"]["round_success"] = "round_win_streak_3";
          break;
        case 4:
          game["dialog"]["round_success"] = "round_win_streak_4";
          break;
        case 5:
          roundswon = getroundswon(winningteam);
          winlimit = getwatcheddvar("winlimit");

          if(winlimit == 6 && roundswon != winlimit - 1) {
            game["dialog"]["round_success"] = "round_win_streak_5";
          }

          break;
        default:
          break;
      }
    }

    if(game["finalRound"] == 1) {
      if(game["roundWinStreak"][winningteam] > 3) {
        game["dialog"]["mission_success"] = "gamestate_win_comeback";
      }
    }
  } else {
    game["previousWinningTeam"] = "";
  }

  thread scripts\mp\gamelogic::endgame(winningteam, endreasontext, endreasontextloss, nukedetonated, var_8e4a26ed257a393b);
}

function ontimelimitot() {
  level thread function_59176f33753f0b5b();
}

function function_8469a5927d069db7() {
  self endon("<dev string:x117>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      points = getdvarint(@ "hash_46a6b424af6acbc2");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x125>", points, 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      points = getdvarint(@ "hash_86e14326e43c0115");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x12f>", points, 0);
      break;
    }

    wait 1;
  }

  setdevdvar(@ "hash_46a6b424af6acbc2", 0);
  setdevdvar(@ "hash_86e14326e43c0115", 0);
  thread function_8469a5927d069db7();
}

function function_bf2918399f1800b1() {
  wait 5;
  ents = getEntArray("<dev string:x137>", "<dev string:x145>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  ents = getEntArray("<dev string:x15a>", "<dev string:x145>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x137>", "<dev string:x145>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x15a>", "<dev string:x145>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }
}

function tdmanywhere_debugshowlocs() {
  thread scripts\mp\utility\debug::drawsphere(level.mapcenter, 128, 100, (0, 1, 0));

  if(!isDefined(level.tdmanywherefrontline)) {
    waitframe();
  }

  var_cc015915d647fbdf = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
  var_c1d9d45c8845eb82 = level.tdmanywherefrontline.anchorrt * level.tdmanywhere_perpenoffset;
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter + var_cc015915d647fbdf, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter - var_cc015915d647fbdf, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_cc015915d647fbdf, level.mapcenter + var_cc015915d647fbdf + var_c1d9d45c8845eb82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + var_cc015915d647fbdf, level.mapcenter + var_cc015915d647fbdf - var_c1d9d45c8845eb82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_cc015915d647fbdf, level.mapcenter - var_cc015915d647fbdf + var_c1d9d45c8845eb82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - var_cc015915d647fbdf, level.mapcenter - var_cc015915d647fbdf - var_c1d9d45c8845eb82, 1000, (0, 0, 1));
}

function monitorhotfoot() {
  level endon("game_ended");
  level.outlinedplayers = [];
  level.hotfootabsloops = 0;
  timepassed = 0;
  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player.hotfootlastposition)) {
        player.hotfootdisttraveledsq = 0;
        player.hotfootlastposition = player.origin;
        player.abshotfootlastposition = player.origin;
      }

      player.hotfootdisttraveledsq += distancesquared(player.hotfootlastposition, player.origin);
      player.hotfootlastposition = player.origin;
    }

    timepassed += level.framedurationseconds;

    if(timepassed > 3) {
      if(level.hotfootabsloops >= 2) {
        level.hotfootabsloops = 0;

        foreach(player in level.players) {
          if(!isDefined(player.abshotfootlastposition)) {
            player.abshotfootlastposition = player.origin;
          }

          player.forceabshotfoot = distancesquared(player.abshotfootlastposition, player.origin) < 4225;
          player.abshotfootlastposition = player.origin;
        }
      }

      foreach(player in level.players) {
        entnum = player getentitynumber();
        friendlyteam = player.pers["team"];

        if(friendlyteam == "allies") {
          enemyteam = "axis";
        } else {
          enemyteam = "allies";
        }

        if(isalive(player) && (istrue(player.forceabshotfoot) || player.hotfootdisttraveledsq < 4225 && !istrue(player.hotfootreset))) {
          if(istrue(player.forceabshotfoot)) {
            player iprintlnbold("<dev string:x170>");
          } else {
            player iprintlnbold("<dev string:x180>");
          }

          player.forceabshotfoot = 0;

          if(!isDefined(level.outlinedplayers[entnum])) {
            level.outlinedplayers[entnum] = player;
            player.outlineidfriend = outlineenableforteam(player, friendlyteam, "outline_nodepth_orange", "level_script");
            player.outlineidenemy = outlineenableforteam(player, enemyteam, "outline_nodepth_red", "level_script");
            player scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
          }
        } else {
          if(isalive(player)) {
            player.hotfootreset = 0;
          }

          player.forceabshotfoot = 0;

          if(isDefined(level.outlinedplayers[entnum])) {
            outlinedisable(player.outlineidfriend, player);
            outlinedisable(player.outlineidenemy, player);
            player scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
            player.outlineidfriend = undefined;
            player.outlineidenemy = undefined;
            level.outlinedplayers[entnum] = undefined;
          }
        }

        player.hotfootdisttraveledsq = 0;
      }

      timepassed = 0;
    }

    level.hotfootabsloops++;
    waitframe();
  }
}

function shouldgamelobbyremainintact() {
  axisscore = int(game["teamScores"]["axis"]);
  alliesscore = int(game["teamScores"]["allies"]);
  differential = axisscore - alliesscore;
  return differential < 10;
}

function seticonnames() {
  level.iconcaptureendzone = "waypoint_capture_endzone";
  level.icondefendendzone = "waypoint_defend_endzone";
  level.iconcontestendzone = "waypoint_contesting_endzone";
  level.icontakingendzone = "waypoint_taking_endzone";
  level.iconlosingendzone = "waypoint_losing_endzone";
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level.icondefending = "waypoint_defending";
  level.iconescort = "waypoint_escort_flag";
  level.iconkill = "waypoint_ctf_kill";
  level.iconcaptureflag = "waypoint_take_flag";
  level.icondefendflag = "waypoint_defend_flag";
  level.iconreturnflag = "waypoint_recover_flag";
  level.mlgiconemptyflag = "waypoint_mlg_empty_flag";
  level.mlgiconfullflag = "waypoint_mlg_full_flag";
  level.icontarget = "waypoint_target";
}

function setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contesting_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_dom_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defending_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_captureneutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dom_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_ot_a", 1, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", "hud_icon_minimap_misc_dog_tag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", "hud_icon_minimap_misc_dog_tag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0);
}