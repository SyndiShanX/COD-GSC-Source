/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cyber.gsc
***********************************************/

#using script_4a6760982b403bad;
#using script_548072087c9fd504;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots_util;
#using scripts\mp\class;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\motiondetectors;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\usability;
#namespace cyber;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    allowed[0] = scripts\mp\utility\game::getbasegametype();
  } else {
    allowed[0] = getgametype();
  }

  allowed[1] = "blocker";
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 3, 0, 12);
    registertimelimitdvar(getgametype(), 150);
    registerscorelimitdvar(getgametype(), 1);
    registerroundlimitdvar(getgametype(), 0);
    registerwinlimitdvar(getgametype(), 4);
    registernumlivesdvar(getgametype(), 1);
    registerhalftimedvar(getgametype(), 0);
    registerwinbytwoenableddvar(getgametype(), 1);
    registerwinbytwomaxroundsdvar(getgametype(), 4);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  println("<dev string:x1c>" + gettime());
  level.nobuddyspawns = 1;
  level.onprecachegametype = &onprecachegametype;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerkilled = &onplayerkilled;
  level.ondeadevent = &ondeadevent;
  level.ononeleftevent = &ononeleftevent;
  level.ontimelimit = &ontimelimit;
  level.onnormaldeath = &onnormaldeath;
  level.gamemodemaydropweapon = &isplayeroutsideofanybombsite;
  level.onexfilstarted = &onexfilstarted;
  level.onmaprestart = &function_b47a96f58a61d923;
  level.resetuiomnvargamemode = &scripts\mp\gametypes\obj_bombzone::resetuiomnvargamemode;
  level.emplightsoff = &emplightsoff;
  level.allowlatecomers = 0;
  level.bombplanted = 0;
  level.bombplantedteam = undefined;
  level.bombexploded = 0;
  game["canScoreOnTie"] = 1;

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    game["dialog"]["gametype"] = "iw9_cybr_mode_uktl_cyt1";
  } else {
    game["dialog"]["gametype"] = "iw9_cybr_mode_uktl_cynm";
  }

  if(!isDefined(game["roundsPlayed"])) {
    boostvo = "iw9_cybr_mode_uktl_cybo";
  } else {
    boostvo = "iw9_cybr_mode_uktl_cybs";
  }

  game["dialog"]["offense_obj"] = boostvo;
  game["dialog"]["defense_obj"] = boostvo;
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

  if(getgametypenumlives() == 1) {
    setDvar(@ "scr_player_laststand", 2);
  }

  setdevdvarifuninitialized(@ "hash_3f3a15fb7e7c9b0", 0);
  thread function_8598880f9b913b55();
  thread function_847f04c317e266d();
  thread function_a60e39eb7d5bd5f4();
  thread function_4df61dc99c28632b();
  thread function_68dd1d69fdeeff68();
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_empspawn"), getmatchrulesdata("cyberData", "empSpawn"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_radarpingtime"), getmatchrulesdata("cyberData", "radarPingTime"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_persbombtimer"), getmatchrulesdata("cyberData", "persBombTimer"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_detonatescore"), getmatchrulesdata("cyberData", "detonateScore"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_bombtimer"), getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_planttime"), getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_defusetime"), getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_multibomb"), getmatchrulesdata("bombData", "multiBomb"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_showEnemyCarrier"), getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_idleResetTime"), getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_pickupTime"), getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_manualDropEnabled"), getmatchrulesdata("carryData", "manualDropEnabled"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_halftime"), 0);
  setdynamicdvar(@ "hash_72771711644c3f78", 0);
  registerhalftimedvar("cyber", 0);
}

function waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
}

function onprecachegametype() {
  game["bomb_dropped_sound"] = "iw9_mp_ui_objective_lost";
  game["bomb_recovered_sound"] = "iw9_mp_ui_objective_taken";
}

function onstartgametype() {
  setomnvar("ui_victory_condition_completed", 0);

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  setclientnamemode("manual_change");
  level._effect["emp_detonation"] = loadfx("vfx/iw9/gameplay/mp/vfx_cyber_emp_explode.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  setobjectivetext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
  setobjectivetext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");

  if(level.splitscreen) {
    setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
    setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");
  } else {
    setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE");
    setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE");
  }

  setobjectivehinttext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT");
  setobjectivehinttext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT");
  cyberattack();
  initspawns();
  thread startmatchobjectiveicons();
  thread waittooverridegraceperiod();
  setupwaypointicons();
}

function updategametypedvars() {
  updatecommongametypedvars();
  level.empspawnindex = dvarintvalue("empSpawn", 0, 0, 4);
  level.radarpingtime = 4;
  level.persbombtimer = dvarintvalue("persBombTimer", 0, 0, 1);
  level.detonatescore = dvarintvalue("detonateScore", 1, 0, 5);
  level.bombtimer = dvarfloatvalue("bombtimer", 30, 1, 300);
  level.planttime = dvarfloatvalue("planttime", 1, 0, 20);
  level.defusetime = dvarfloatvalue("defusetime", 1, 0, 20);
  level.multibomb = dvarintvalue("multibomb", 0, 0, 1);
  level.showenemycarrier = dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.idleresettime = dvarfloatvalue("idleResetTime", 0, 0, 60);
  level.pickuptime = dvarfloatvalue("pickupTime", 0, 0, 10);
  level.allowempweapon = dvarintvalue("allowEMPWeapon", 0, 0, 1);
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_cyber_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_cyber_spawn_axis");
  csspawn = default_to(level.scriptedsetup, 0);
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_cyber_spawn_allies", csspawn);
  defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_cyber_spawn_axis", csspawn);
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_ctf_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_ctf_spawn", 1);

  if(getgametypenumlives() != 1) {
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

function getspawnpoint() {
  if(spawnlogic::function_bff229a11ecd1e34()) {
    spawnlogic::setactivespawnlogic(#"start");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
  }

  spawnteam = self.pers["team"];

  if(getgametypenumlives() != 1) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(spawnteam == game["attackers"]) {
        scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
      } else {
        scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
      }
    } else {
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.cyberteamspawnsetids[spawnteam], "neutral");
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

function isenemyteameliminated(teamname) {
  players = level.teamdata[teamname]["players"];

  foreach(player in players) {
    if(scripts\mp\utility\player::isreallyalive(player)) {
      return false;
    }
  }

  return true;
}

function assignteamspawns() {
  level.spawnnodetype = "mp_ctf_spawn";
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  ispathdataavailable = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];

  if(level.objectives.size == 2) {
    axisbombsite = level.objectives["axis"];
    alliesbombsite = level.objectives["allies"];
    var_d363bc9d0700ed97 = (axisbombsite.curorigin[0], axisbombsite.curorigin[1], 0);
    var_59bdaac880603126 = (alliesbombsite.curorigin[0], alliesbombsite.curorigin[1], 0);
    bombsitedelta = var_59bdaac880603126 - var_d363bc9d0700ed97;
    bombsitedist = length2d(bombsitedelta);

    foreach(spawnpoint in spawnpoints) {
      var_c982049ea3238d92 = (spawnpoint.origin[0], spawnpoint.origin[1], 0);
      var_42eaea0258074021 = var_c982049ea3238d92 - var_d363bc9d0700ed97;
      dotvalue = vectordot(var_42eaea0258074021, bombsitedelta);
      var_79d0930df6523209 = dotvalue / bombsitedist * bombsitedist;

      if(var_79d0930df6523209 < 0.33) {
        spawnpoint.teambase = axisbombsite.ownerteam;
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      if(var_79d0930df6523209 > 0.67) {
        spawnpoint.teambase = alliesbombsite.ownerteam;
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      var_1ea3ff868194391b = undefined;
      var_f3417be7c70940a0 = undefined;

      if(ispathdataavailable) {
        var_1ea3ff868194391b = getpathdist(spawnpoint.origin, axisbombsite.curorigin, 999999);
      }

      if(isDefined(var_1ea3ff868194391b) && var_1ea3ff868194391b != -1) {
        var_f3417be7c70940a0 = getpathdist(spawnpoint.origin, alliesbombsite.curorigin, 999999);
      }

      if(!isDefined(var_f3417be7c70940a0) || var_f3417be7c70940a0 == -1) {
        var_1ea3ff868194391b = distance2d(axisbombsite.curorigin, spawnpoint.origin);
        var_f3417be7c70940a0 = distance2d(alliesbombsite.curorigin, spawnpoint.origin);
      }

      var_7c7809cdc3f571e5 = max(var_1ea3ff868194391b, var_f3417be7c70940a0);
      var_126715ed2b04d65f = min(var_1ea3ff868194391b, var_f3417be7c70940a0);
      distpercent = var_126715ed2b04d65f / var_7c7809cdc3f571e5;

      if(distpercent > 0.5) {
        level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = spawnpoint;
      }
    }

    return;
  }

  foreach(spawnpoint in spawnpoints) {
    spawnpoint.teambase = getnearestbombsiteteam(spawnpoint);

    if(spawnpoint.teambase == "axis") {
      level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = spawnpoint;
      continue;
    }

    level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = spawnpoint;
  }
}

function getnearestbombsiteteam(spawnpoint) {
  ispathdataavailable = scripts\mp\spawnlogic::ispathdataavailable();
  nearestbombsite = undefined;
  nearestdist = undefined;

  foreach(bombsite in level.objectives) {
    dist = undefined;

    if(ispathdataavailable) {
      dist = getpathdist(spawnpoint.origin, bombsite.curorigin, 999999);
    }

    if(!isDefined(dist) || dist == -1) {
      dist = distancesquared(bombsite.curorigin, spawnpoint.origin);
    }

    if(!isDefined(nearestbombsite) || dist < nearestdist) {
      nearestbombsite = bombsite;
      nearestdist = dist;
    }
  }

  return getotherteam(nearestbombsite.ownerteam)[0];
}

function private function_5151fb129e5aafdf(spawntriggers) {
  assertex(isDefined(spawntriggers) && spawntriggers.size > 0, "<dev string:x46>");

  switch (level.mapname) {
    case #"hash_b4040d028dc0782a":
      foreach(spawntrigger in spawntriggers) {
        if(distancesquared((9770, 11472, -82), spawntrigger.origin) < 1) {
          spawntriggers = scripts\engine\utility::array_remove(spawntriggers, spawntrigger);
        }
      }

      break;
    default:
      break;
  }

  return spawntriggers;
}

function cyberattack() {
  cyberemps = getEntArray("cyber_emp", "targetname");

  foreach(cyberemp in cyberemps) {
    cyberemp delete();
  }

  var_92fc6d4f242a0f8d = default_to(getStructArray("cyber_emp_pickup_trig", "script_noteworthy"), []);

  if(var_92fc6d4f242a0f8d.size > 0) {
    level.scriptedsetup = 1;
  } else {
    var_92fc6d4f242a0f8d = getEntArray("cyber_emp_pickup_trig", "targetname");

    if(var_92fc6d4f242a0f8d.size > 0) {
      var_92fc6d4f242a0f8d = function_5151fb129e5aafdf(var_92fc6d4f242a0f8d);
    } else {
      assertmsg("<dev string:x65>");
      return;
    }
  }

  if(level.empspawnindex == 3) {
    if(isDefined(game["empSpawn"])) {
      var_d2113414696571e3 = [];

      for(i = 0; i < var_92fc6d4f242a0f8d.size; i++) {
        var_d2113414696571e3[var_d2113414696571e3.size] = i;
      }

      var_d2113414696571e3 = array_remove(var_d2113414696571e3, game["empSpawn"]);
      level.empspawnindex = random(var_d2113414696571e3);
    } else {
      level.empspawnindex = randomintrange(0, var_92fc6d4f242a0f8d.size);
    }

    game["empSpawn"] = level.empspawnindex;
  } else if(level.empspawnindex == 4) {
    if(isDefined(game["empSpawn"])) {
      level.empspawnindex = game["empSpawn"] + 1;

      if(level.empspawnindex == var_92fc6d4f242a0f8d.size) {
        level.empspawnindex = 0;
      }
    } else {
      level.empspawnindex = 0;
    }

    game["empSpawn"] = level.empspawnindex;
  }

  emptrigger = var_92fc6d4f242a0f8d[level.empspawnindex];

  if(!istrue(level.allowempweapon)) {
    emptrigger = spawn("trigger_radius", emptrigger.origin, 0, 32, 128);
  }

  visuals[0] = spawn("script_model", emptrigger.origin);
  visuals[0] setModel("projectile_cyber_emp_v0");
  tracestart = visuals[0].origin + (0, 0, 32);
  traceend = visuals[0].origin + (0, 0, -100);
  ignoreents = [visuals[0]];
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);

  if(trace["fraction"] < 1) {
    visuals[0].origin = trace["position"] + (0, 0, 2);
  }

  emptrigger enablelinkTo();
  emptrigger linkTo(visuals[0]);
  emptrigger.baseorigin = emptrigger.origin;
  emptrigger.no_moving_platfrom_unlink = 1;
  emptrigger.linktoenabledflag = 1;

  if(!level.multibomb) {
    level.cyberemp = scripts\mp\gameobjects::createcarryobject("neutral", emptrigger, visuals, (0, 0, 16), undefined, 1);
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
    level.cyberemp.onuse = &emptriggerholdonuse;

    if(level.cyberemp.triggertype == "use") {
      level.cyberemp.trigger setCursorHint("HINT_NOICON");
      level.cyberemp.trigger setHintString(&"MP/EMP_PICKUP_USE");
      level.cyberemp.trigger setusepriority(-1 - 1 - 1 - 1);
    }

    level.cyberemp scripts\mp\gameobjects::setusetime(level.cyberemp.usetime);
    level.cyberemp scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    level.cyberemp.allowweapons = 1;
    level.cyberemp.onpickup = &onpickup;
    level.cyberemp.ondrop = &ondrop;
    level.cyberemp.firstpickup = 1;
    level thread empsitewatcher();
    level.bombrespawnpoint = level.cyberemp.visuals[0].origin;
    level.bombrespawnangles = level.cyberemp.visuals[0].angles;
    level.cyberemp.visualgroundoffset = (0, 0, 2);

    if(getdvarint(@ "hash_484e617d6f7b7fa7") != 0) {
      level.cyberemp scripts\mp\gameobjects::create_manual_drop_data_struct([level.cyberemp.visuals[0]], level.cyberemp.trigger, 1, 80, 0, &onempdropped);
    }
  } else {
    emptrigger delete();
    visuals[0] delete();
  }

  empzoneaxis = default_to(getEnt("cyber_empzone_axis", "targetname"), undefined);

  if(isDefined(empzoneaxis)) {
    originoverride = getStruct("cyber_empzone_axis", "script_noteworthy");

    if(isDefined(originoverride)) {
      empzoneaxis.origin = drop_to_ground(originoverride.origin, 10, -10);
    }
  } else {
    empzoneaxis = function_ce51e08dcc037220(getEnt("cyber_empzone_axis", "script_noteworthy"), undefined, "No cyber_empzone_axis trigger found in map. Please bug this to the level designer");

    if(!isDefined(empzoneaxis)) {
      return;
    }
  }

  empzoneallies = default_to(getEnt("cyber_empzone_allies", "targetname"), undefined);

  if(isDefined(empzoneallies)) {
    originoverride = getStruct("cyber_empzone_allies", "script_noteworthy");

    if(isDefined(originoverride)) {
      empzoneallies.origin = drop_to_ground(originoverride.origin, 10, -10);
    }
  } else {
    empzoneallies = function_ce51e08dcc037220(getEnt("cyber_empzone_allies", "script_noteworthy"), undefined, "No cyber_empzone_allies trigger found in map. Please bug this to the level designer");

    if(!isDefined(empzoneallies)) {
      return;
    }
  }

  var_e42151cf313ec61e = default_to(getEnt("cyber_emp_defuse_axis", "targetname"), undefined);

  if(isDefined(var_e42151cf313ec61e)) {
    var_e42151cf313ec61e delete();
  }

  var_838d920af3079ba1 = default_to(getEnt("cyber_emp_defuse_allies", "targetname"), undefined);

  if(isDefined(var_838d920af3079ba1)) {
    var_838d920af3079ba1 delete();
  }

  if(game["switchedsides"]) {
    level.objectives["allies"] = createbombzone("allies", empzoneaxis);
    level.objectives["axis"] = createbombzone("axis", empzoneallies);
  } else {
    level.objectives["allies"] = createbombzone("allies", empzoneallies);
    level.objectives["axis"] = createbombzone("axis", empzoneaxis);
  }

  level notify("enable_player_usability");
  level.objectives["axis"] thread data_center_sfx_loop();
  level.objectives["allies"] thread data_center_sfx_loop();

  if("mp_hackney_yard" == level.mapname) {
    thread destroytvs();
  }
}

function createbombzone(team, trigger) {
  var_6668f4680f6b59bb = undefined;

  if(isDefined(trigger) && isDefined(trigger.target)) {
    var_6668f4680f6b59bb = getEntArray(trigger.target, "targetname");

    foreach(cyberempzone in var_6668f4680f6b59bb) {
      cyberempzone delete();
    }
  }

  visuals[0] = spawn("script_model", drop_to_ground(trigger.origin, 10, -10));
  visuals[0] setModel("misc_carepackage_friendly");

  if(istrue(level.scriptedsetup)) {
    trigger = visuals[0];
    trigger.usetype = 1;
    trigger.isuseobject = 1;
    trigger.skiptouching = 1;
    trigger makeusable();
  }

  bombzone = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 64), undefined, 1);
  bombzone.onuse = &onuse;
  bombzone.onbeginuse = &onbeginuse;
  bombzone.onenduse = &onenduse;
  bombzone.oncantuse = &oncantuse;
  bombzone.useweapon = makeweapon("iw9_cyberemp_plant_mp");
  bombzone.id = "bomb_zone";
  bombzone.trigger setusepriority(-1 - 1 - 1 - 1);
  bombzone.trigger setuseholdduration("duration_none");
  bombzone.trigger setusehideprogressbar(1);
  bombzone.bombplanted = 0;
  bombzone.bombexploded = undefined;
  bombzone scripts\mp\gameobjects::setusetime(level.planttime);
  bombzone scripts\mp\gameobjects::setusetext(&"MP/PLANTING_EXPLOSIVE");
  bombzone scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  bombzone scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  bombzone.objectivekey = "_" + team;
  bombzone.label = bombzone.objectivekey;
  bombzone resetbombsite(1, undefined, 1);

  for(i = 0; i < visuals.size; i++) {
    if(isDefined(visuals[i].script_exploder)) {
      bombzone.exploderindex = visuals[i].script_exploder;
      visuals[i] thread setupkillcament(bombzone);
      break;
    }
  }

  bombzone.noweapondropallowedtrigger = spawn("trigger_radius", bombzone.trigger.origin, 0, 140, 100);
  return bombzone;
}

function startmatchobjectiveicons() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level waittill_any_2("prematch_done", "start_mode_setup");
  }

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
    level.cyberemp.visuals[0] scripts\mp\gametypes\obj_bombzone::setteaminhuddatafromteamname("neutral");
    level.cyberemp.visuals[0] setasgametypeobjective();
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(level.cyberemp.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.cyberemp.objidnum, 0);
  objective_setspecialobjectivedisplay(level.cyberemp.objidnum, 1);
  pingobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  level.cyberemp.pingobjidnum = pingobjid;
  scripts\mp\objidpoolmanager::objective_add_objective(pingobjid, "done", level.cyberemp.origin);
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("none", pingobjid);
  objective_setownerteam(pingobjid, undefined);
  level.cyberemp scripts\mp\gameobjects::setobjectivestatusallicons("icon_waypoint_escort_emp", "waypoint_capture_kill", undefined, pingobjid);
  setcarriervisibility();
}

function hidebombsitesaftermatchstart() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level waittill("prematch_done");
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["allies"].objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(level.objectives["axis"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.objectives["axis"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["axis"].objidnum, 1);
  level.objectives["allies"] scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives["axis"] scripts\mp\gameobjects::setvisibleteam("none");
}

function emptriggerholdonuse(player) {}

function setupkillcament(bombzone) {
  temporg = spawn("script_origin", self.origin);
  temporg.angles = self.angles;
  temporg rotateYaw(-45, 0.05);
  waitframe();
  campos = undefined;
  bulletstart = self.origin + (0, 0, 45);
  bulletend = self.origin + anglesToForward(temporg.angles) * 100 + (0, 0, 128);
  content = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(content);
  result = scripts\engine\trace::ray_trace(bulletstart, bulletend, self, contentoverride);
  campos = result["position"];
  self.killcament = spawn("script_model", campos);
  self.killcament setscriptmoverkillcam("explosive");
  bombzone.killcamentnum = self.killcament getentitynumber();
  temporg delete();

  self.killcament thread debugkillcament(self);
}

function debugkillcament(visual) {
  self endon("<dev string:xbf>");
  level endon("<dev string:xc8>");
  visual endon("<dev string:xbf>");

  while(true) {
    if(getdvarint(@ "hash_3f3a15fb7e7c9b0") > 0) {
      line(self.origin, self.origin + anglesToForward(self.angles) * 10, (1, 0, 0));
      line(self.origin, self.origin + anglestoright(self.angles) * 10, (0, 1, 0));
      line(self.origin, self.origin + anglestoup(self.angles) * 10, (0, 0, 1));
      line(visual.origin + (0, 0, 5), self.origin, (0, 0, 1));
      line(visual.origin, visual.origin + anglesToForward(visual.angles) * 10, (1, 0, 0));
      line(visual.origin, visual.origin + anglestoright(visual.angles) * 10, (0, 1, 0));
      line(visual.origin, visual.origin + anglestoup(visual.angles) * 10, (0, 0, 1));
    }

    waitframe();
  }
}

function empsitewatcher() {
  level endon("game_ended");

  while(true) {
    level waittill("bomb_pickup");

    if(level.cyberemp.carrier.team == "allies") {
      level.objectives["axis"] setupforplanting();
    } else {
      level.objectives["allies"] setupforplanting();
    }

    waitframe();
  }
}

function data_center_sfx_loop() {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("overtime_ended");
  ent = spawn_script_origin(self.trigger.origin + (0, 0, 15), self.trigger.angles);
  ent thread play_loop_sound_on_entity("jup_mode_cyber_idle_lp");
  level waittill("bomb_planted");
  ent stoploopsound();
  waitframe();
  ent playLoopSound("jup_mode_cyber_arrmed_idle_lp");
  level waittill("bomb_preexp");
  ent stoploopsound();
  waitframe();
  ent playLoopSound("jup_mode_cyber_armed_stress_lp");
  level waittill("emp_detonated");
  ent stoploopsound();
  waitframe();
  ent delete();
}

function onbeginuse(player) {
  if(!scripts\mp\gameobjects::isfriendlyteam(player.pers["team"]) && !level.bombplanted) {
    player.isplanting = 1;
    setomnvar("ui_bomb_interacting", 1);
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_emp_planting");
  } else {
    player.isdefusing = 1;
    setomnvar("ui_bomb_interacting", 3);
    namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(2, player.team, player getentitynumber());
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite_nt", "icon_waypoint_emp_defusing");
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.radialtimeobjid, player.team);
  }

  player thread allowedwhileplanting(0);

  if(level.bombplanted && !scripts\mp\gameobjects::isfriendlyteam(player.pers["team"])) {
    player scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("defuse");
    player.isdefusing = 1;
    setomnvar("ui_bomb_interacting", 3);
    setomnvar("ui_bomb_defuser", player getentitynumber());

    if(isDefined(level.cyberemp.visuals[0])) {
      level.cyberemp.visuals[0] hide();
    }

    player thread startnpcbombusesound("briefcase_bomb_defuse_mp", "equip_suitcase_defuse_button");
  }
}

function allowedwhileplanting(isallowed) {
  val::set("planting", "melee", isallowed);
  val::set("planting", "allow_jump", isallowed);
  val::set("planting", "gesture", isallowed);

  if(isallowed) {
    self waittill("bomb_allow_offhands");
  }

  val::set("planting", "melee", isallowed);
  val::set("planting", "mantle", isallowed);
  val::set("planting", "offhand_weapons", isallowed);

  if(isallowed) {
    val::reset_all("planting");
  }
}

function onenduse(team, player, result) {
  objid = self.objidnum;
  scripts\mp\objidpoolmanager::objective_set_progress(objid, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(objid, 0);

  if(!result) {
    if(player.isdefusing) {
      scripts\mp\gameobjects::setobjectivestatusallicons("icon_waypoint_defuse_empsite_nt", "icon_waypoint_defend_empsite_nt", "mlg_icon_waypoint_emp_planted");
    } else {
      scripts\mp\gameobjects::setobjectivestatusallicons("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite", undefined);
    }

    if(isDefined(self.radialtimeobjid)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.radialtimeobjid, player.team);
    }

    if(player meleeButtonPressed()) {
      interruptbombplanting(player);
    } else {
      player switchtolastweapon();
    }
  }

  if(istrue(player.isdefusing) || istrue(player.isplanting)) {
    setomnvar("ui_bomb_interacting", 0);
  }

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
    if(isDefined(level.cyberemp) && !result) {
      level.cyberemp.visuals[0] show();
    }
  }
}

function startnpcbombusesound(weaponname, soundname) {
  self endon("death");
  self endon("stopNpcBombSound");

  if(isanymlgmatch() || istrue(level.silentplant) || _hasperk("specialty_engineer")) {
    self setentitysoundcontext("silent_plant", "on");
    return;
  }

  while(true) {
    self waittill("weapon_change", newweaponobj);

    if(newweaponobj.basename == weaponname) {
      break;
    }
  }

  self playsoundtoteam(soundname, self.team, self);
  enemyteam = getotherteam(self.team)[0];
  self playsoundtoteam(soundname, enemyteam);
  self waittill("weapon_change");
  self notify("stopNpcBombSound");
}

function onpickup(player, playervo, defused) {
  level notify("bomb_pickup");

  if(istrue(level.allowempweapon)) {
    curweapon = player getcurrentprimaryweapon();

    if(isDefined(curweapon.basename) && curweapon.basename == "iw8_lm_dblmg_mp") {
      player notify("switched_from_minigun");
    }

    player _giveweapon("iw9_cyberemp_mp");

    if(!istrue(defused) && !player scripts\mp\utility\killstreak::isjuggernaut() && !isbot(player)) {
      player _switchtoweaponimmediate("iw9_cyberemp_mp");
    }
  }

  player thread empradarwatcher();
  setomnvar("ui_bomb_carrier", player getentitynumber());
  player setclientomnvar("ui_emp_carrier_hud", 1);
  namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(16, player.team, player getentitynumber());

  if(self.firstpickup) {
    player thread doscoreevent(#"emp_grab");
  }

  level.usestartspawns = 0;
  team = player.pers["team"];

  if(team == "allies") {
    otherteam = "axis";
  } else {
    otherteam = "allies";
  }

  player.isbombcarrier = 1;

  if(level.codcasterenabled) {
    player setgametypevip(1);
  }

  if(!isDefined(defused)) {
    if(self.firstpickup) {
      var_a675744864c65c1 = "emppickup_friendly_first";
      self.firstpickup = 0;
    } else {
      var_a675744864c65c1 = "emppickup_friendly";
    }

    leaderdialog(var_a675744864c65c1, team, "bomb");
    leaderdialog("emppickup_enemy", otherteam, "bomb");
    player playsoundtoteam(game["bomb_recovered_sound"], player.team, player);
    player playsoundtoplayer("jup_mode_cyber_pickup_fly_plr", player);
    skipplayers = getteamdata(player.team, "players");
    level thread scripts\mp\hud_message::notifyteam("emp_pickup", "emp_pickup_enemy", player.team, skipplayers);
    player thread scripts\mp\hud_message::showsplash("emp_pickup");
    level thread teamplayercardsplash("callout_emppickup", player, player.team, undefined, 1);
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
  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = player;
  var_7e2c53b0bcf117d9.eventname = "pickup";
  var_7e2c53b0bcf117d9.position = player.origin;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
}

function ondrop(player) {
  self notify("emp_dropped");
  setomnvar("ui_bomb_carrier", -1);

  if(level.bombplanted) {
    scripts\mp\gameobjects::setownerteam(player.team);
    scripts\mp\gameobjects::allowuse("none");
  } else {
    foreach(objective in level.objectives) {
      objective resetbombsite(1);
    }

    playsoundonplayers(game["bomb_dropped_sound"], scripts\mp\gameobjects::getownerteam());
    self.offset3d = (0, 0, 16);
    scripts\mp\gameobjects::allowuse("any");
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_emp", "icon_waypoint_emp");
    scripts\mp\gameobjects::setownerteam("neutral");
    scripts\mp\gameobjects::setvisibleteam("any");

    if(isDefined(player)) {
      printonteamarg(&"MP/EXPLOSIVES_DROPPED_BY", scripts\mp\gameobjects::getownerteam(), player);
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "cyber_emp_pickup", "cyber_emp_pickup");

    if(level.idleresettime > 0) {
      thread returnaftertime();
    }
  }

  if(istrue(level.allowempweapon)) {
    player _takeweapon("iw9_cyberemp_mp");
    player switchtolastweapon();
  }
}

function returnaftertime() {
  level endon("bomb_pickup");
  currentwaittime = 0;

  while(currentwaittime < level.idleresettime) {
    waitframe();

    if(self.ownerteam == "neutral") {
      currentwaittime += level.framedurationseconds;
    }
  }

  foreach(team in level.teamnamelist) {
    playsoundonplayers(game["bomb_dropped_sound"], team);
  }

  scripts\mp\gameobjects::returnhome();
}

function onuse(player) {
  team = player.pers["team"];
  otherteam = getotherteam(team)[0];

  if(!scripts\mp\gameobjects::isfriendlyteam(player.pers["team"]) && !level.bombplanted) {
    level thread empjamandrumbleclients(0);
    setomnvar("ui_bomb_timer_endtime_a", int(scripts\mp\gamelogic::gettimeremaining()) + gettime());
    level notify("bomb_planted");
    player notify("bomb_planted");
    player notify("objective", "plant");
    namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(15, player.team, player getentitynumber());
    skipplayers = [];
    skipplayers[skipplayers.size] = player;
    level thread scripts\mp\hud_message::notifyteam("emp_planted", "emp_planted_enemy", player.team, skipplayers);
    player thread scripts\mp\hud_message::showsplash("emp_planted", scripts\mp\rank::getscoreinfovalue(#"plant"));
    level thread teamplayercardsplash("callout_empplanted", player, undefined, undefined, 1);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "cyber_emp_defend", "cyber_emp_defsue");
    player setclientomnvar("ui_emp_carrier_hud", 0);
    leaderdialog("empplanted_friendly", team);
    player playsoundtoteam("mp_bombplaced_friendly", team);
    leaderdialog("empplanted_enemy", otherteam);
    player playsoundtoteam("mp_bombplaced_enemy", otherteam);
    player thread doscoreevent(#"plant");
    player scripts\cp_mp\challenges::onplant();
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = player;
    var_7e2c53b0bcf117d9.eventname = "plant";
    var_7e2c53b0bcf117d9.position = player.origin;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
    player.bombplantedtime = gettime();
    player incpersstat("plants", 1);
    player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
    player scripts\mp\persistence::statsetchild("round", "plants", player.pers["plants"]);
    player setextrascore0(player.pers["plants"]);
    player scripts\cp_mp\pet_watch::addplantingcharge();
    level.bombplanted = 1;
    level thread bombplanted(self, player.pers["team"]);
    level.bombowner = player;
    level.bombowner.isbombcarrier = 0;

    if(level.codcasterenabled) {
      player setgametypevip(0);
    }

    level.cyberemp scripts\mp\gameobjects::setdropped();
    level.cyberemp scripts\mp\gameobjects::allowuse("none");
    level.cyberemp scripts\mp\gameobjects::setvisibleteam("none");

    if(istrue(level.allowempweapon)) {
      player _takeweapon("iw9_cyberemp_mp");
      player switchtolastweapon();
    }

    self.useweapon = makeweapon("iw9_cyberemp_defuse_mp");
    setupfordefusing(self, player);
    return;
  }

  player notify("bomb_defused");
  player notify("objective", "defuse");
  defusedgameend = isenemyteameliminated(otherteam);

  if(defusedgameend) {
    var_ebbe93b2cf924047 = "empdefused_final_friendly";
    var_ad194f060980b384 = "empdefused_final_enemy";
    level.var_1242a000845a4331 = 1;
  } else {
    var_ebbe93b2cf924047 = "empdefused_friendly";
    var_ad194f060980b384 = "empdefused_enemy";
  }

  leaderdialog(var_ebbe93b2cf924047, team);
  leaderdialog(var_ad194f060980b384, otherteam);
  skipplayers = [];
  skipplayers[skipplayers.size] = player;
  level thread scripts\mp\hud_message::notifyteam("emp_defuse", "emp_defuse_enemy", player.team, skipplayers);
  level thread teamplayercardsplash("callout_empdefused", player, undefined, undefined, 1);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "cyber_carrier_defend", "cyber_data_defend", player, "cyber_emp_plant");

  if(isDefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && isreallyalive(level.bombowner)) {
    player thread scripts\mp\rank::scoreeventpopup(#"ninja_defuse");
    player thread scripts\mp\hud_message::showsplash("ninja_defuse", scripts\mp\rank::getscoreinfovalue(#"defuse"));
  } else {
    player thread scripts\mp\rank::scoreeventpopup(#"defuse");
    player thread scripts\mp\hud_message::showsplash("emp_defuse", scripts\mp\rank::getscoreinfovalue(#"defuse"));
  }

  player thread scripts\mp\utility\points::doscoreevent(#"mode_sd_defuse");
  player incpersstat("defuses", 1);
  player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
  player scripts\mp\persistence::statsetchild("round", "defuses", player.pers["defuses"]);
  scripts\cp_mp\challenges::function_c51330573171a1be(player);
  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = player;
  var_7e2c53b0bcf117d9.eventname = "defuse";
  var_7e2c53b0bcf117d9.position = player.origin;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
  level.bombplanted = 0;
  level thread bombdefused(self);
  resetbombsite(1, player);

  if(defusedgameend) {
    wait 3;
  }

  level.cyberemp scripts\mp\gameobjects::allowuse("any");
  level.cyberemp scripts\mp\gameobjects::setpickedup(player, 0, 1);
}

function empjamandrumbleclients(rumble, endgame) {
  foreach(player in level.players) {
    player setempjammed(1);

    if(istrue(rumble)) {
      player playrumbleonpositionforclient("artillery_rumble", player.origin);
    }
  }

  if(!istrue(endgame)) {
    wait 1;

    foreach(player in level.players) {
      player setempjammed(0);
    }
  }
}

function resetbombsite(defused, player, matchstart) {
  if(!defused) {
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_planted_empsite", "icon_waypoint_target_empsite");
    scripts\mp\gameobjects::setvisibleteam("any");
    return;
  }

  if(istrue(matchstart)) {
    return;
  }

  if(isDefined(player)) {
    self.ownerteam = player.team;
  }

  self.id = "bomb_zone";
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["allies"].objidnum, 1);
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["axis"].objidnum, 1);
}

function setupforplanting() {
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

function setupfordefusing(defuseobject, player) {
  self.trigger setusepriority(-1 - 1 - 1 - 1);
  self.ownerteam = player.team;
  scripts\mp\gameobjects::allowuse("enemy");
  scripts\mp\gameobjects::setusetime(level.defusetime);
  scripts\mp\gameobjects::setusetext(&"MP/DEFUSING_EXPLOSIVE");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_DEFUSE_EMP");
  scripts\mp\gameobjects::setkeyobject(undefined);
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite_nt", "icon_waypoint_defuse_empsite_nt");
  thread scripts\mp\gametypes\obj_bombzone::bombradialfill(player.team, "icon_waypoint_planted_empsite", "icon_waypoint_defuse_empsite");
  scripts\mp\gameobjects::setvisibleteam("any", self.radialtimeobjid);
  self.id = "defuse_object";
  self.bombplanted = 1;
  [defuseownerteam] = getenemyteams(player.team);

  foreach(p in getteamdata(defuseownerteam, "players")) {
    self.trigger enableplayeruse(p);
  }

  if(istrue(level.scriptedsetup)) {
    teammates = getsquadmates(player.team);

    foreach(mate in teammates) {
      self.trigger disableplayeruse(mate);
    }
  }
}

function bombdefused(object) {
  scripts\mp\gamelogic::resumetimer();
  level.timelimitoverride = 0;
  level.scorelimitoverride = 0;
  object.bombplanted = 0;
  setomnvar("ui_bomb_owner_team", -1);
  level thread[[level.updategameevents]]();
  object.visuals[0] scripts\mp\gamelogic::stoptickingsound();
  level notify("bomb_defused");
}

function oncantuse(player) {}

function bombplanted(destroyedobj, team) {
  level endon("overtime");
  scripts\mp\gamelogic::pausetimer();
  setomnvar("ui_match_timer_stopped", 0);
  level.bombplantedteam = team;
  level.timelimitoverride = 1;
  level.scorelimitoverride = 1;

  if(isDefined(team)) {
    if(team == "allies") {
      setomnvar("ui_bomb_owner_team", 2);
    } else {
      setomnvar("ui_bomb_owner_team", 1);
    }
  }

  setgameendtime(int(gettime() + level.bombtimer * 1000));
  destroyedobj.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  destroyedobj.visuals[0] thread function_52d311b859da823c();
  starttime = gettime();
  thread bomb_pre_exp_music();
  thread bomb_pre_exp_sfx_wait(destroyedobj.visuals[0].origin);
  bombtimerwait();
  destroyedobj.visuals[0] scripts\mp\gamelogic::stoptickingsound();

  if(!level.bombplanted) {
    if(level.persbombtimer) {
      timepassed = (gettime() - starttime) / 1000;
      level.bombtimer -= timepassed;
    }

    return;
  }

  explosionorigin = destroyedobj.visuals[0].origin;
  level.bombexploded = 1;
  setDvar(@ "hash_a19c6a194a53f076", "BombExploded");

  if(isDefined(level.bombowner)) {
    destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, 1, 1, level.bombowner, "MOD_EXPLOSIVE", "bomb_site_mp");
    level.bombowner incpersstat("destructions", 1);
    level.bombowner scripts\mp\persistence::statsetchild("round", "destructions", level.bombowner.pers["destructions"]);
  } else {
    destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, 1, 1, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  playsoundatpos(explosionorigin + (0, 0, 15), "jup_mode_cyber_explode");
  vfxorigin = destroyedobj.visuals[0] gettagorigin("tag_origin");
  explosioneffect = spawnfx(level._effect["emp_detonation"], vfxorigin);
  triggerfx(explosioneffect);
  earthquake(0.6, 1.5, explosionorigin, 10000);
  destroyedobj.visuals[0] setModel("misc_carepackage_friendly_dmg");
  level thread empjamandrumbleclients(1, 1);
  level notify("emp_detonated");

  foreach(objective in level.objectives) {
    objective notify("disabled");
    objective.trigger setallunusable();
  }

  if(game["switchedsides"]) {
    destroyedobj.exploderindex = 200;
  } else {
    destroyedobj.exploderindex = 201;
  }

  if(isDefined(destroyedobj.exploderindex)) {
    exploder(destroyedobj.exploderindex);
  }

  destroyedobj.bombplanted = 0;
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives["allies"] scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives["axis"] scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.objectives["axis"].objidnum, 0);
  setgameendtime(0);
  level.scorelimitoverride = 1;

  if(isDefined(level.bombowner)) {
    level thread teamplayercardsplash("callout_destroyed_cyberbombsite", level.bombowner);
  }

  destroyedobj scripts\mp\gameobjects::releaseid();

  if(istrue(level.nukeinfo.incoming)) {
    return;
  }

  wait 3;
  thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["target_destroyed"], undefined, undefined, level.detonatescore);
}

function bombtimerwait() {
  level endon("bomb_defused");
  level endon("overtime_ended");
  var_4dfaa92e2bce1194 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime", var_4dfaa92e2bce1194);
  level thread handlehostmigration(var_4dfaa92e2bce1194);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

function bomb_pre_exp_music() {
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  thread scripts\mp\music_and_dialog::bombplanted_music();
}

function bomb_pre_exp_sfx_wait(sfx_org) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  wait max(level.bombtimer - 2, 0.1);
  level notify("bomb_preexp");
  playsoundatpos(sfx_org + (0, 0, 15), "jup_mode_cyber_charge");
}

function function_52d311b859da823c() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  time = level.bombtimer;
  timeoffset = 2;
  playsoundatpos(self.origin + (0, 0, 15), "jup_mode_cyber_armed_start");
  time -= timeoffset;
  wait timeoffset;

  while(true) {
    if(time <= level.bombtimer / 2) {
      playsoundatpos(self.origin + (0, 0, 15), "jup_mode_cyber_armed_half");

      if(time <= 10 && time > 5) {
        playsoundatpos(self.origin + (0, 0, 24), "jup_mode_cyber_armed_beep_10");
      } else if(time <= 5 && time > 1) {
        playsoundatpos(self.origin + (0, 0, 24), "jup_mode_cyber_armed_beep_5");
      } else if(time <= 1) {
        playsoundatpos(self.origin + (0, 0, 24), "jup_mode_cyber_armed_beep_1");
      }

      time -= 1;
      wait 1;
      continue;
    }

    playsoundatpos(self.origin + (0, 0, 15), "jup_mode_cyber_armed_init");
    time -= 2;
    wait 2;
  }
}

function handlehostmigration(var_4dfaa92e2bce1194) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  timepassed = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(timepassed > 0) {
    setomnvar("ui_bomb_timer_endtime", var_4dfaa92e2bce1194 + timepassed);
  }
}

function overtimethread(time) {
  level endon("game_ended");
  level.inovertime = 1;
  wait 5;
  level.disablespawning = 1;
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_inform_last_one");
  otherteam = getotherteam(self.pers["team"])[0];
  level thread teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread teamplayercardsplash("callout_lastenemyalive", self, otherteam);
  level notify("last_alive", self);
}

function ontimelimit() {
  if(level.bombexploded) {
    return;
  }

  function_f0f967947c6a7ec8();
  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["cyber_tie"]);
}

function onspawnplayer(revivespawn) {
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);
  scripts\mp\hud_message::function_f004ef4606b9efdc("hide_match_hint");

  if(level.multibomb) {
    self setclientomnvar("ui_emp_carrier_hud", 1);
  } else {
    self setclientomnvar("ui_emp_carrier_hud", 0);
    thread updatebombsiteusability();
  }

  self.isplanting = 0;
  self.isdefusing = 0;
  self.isbombcarrier = 0;

  if(inovertime() && !isDefined(self.otspawned)) {
    thread printothint();
  }

  if(isDefined(self.pers["plants"])) {
    setextrascore0(self.pers["plants"]);
  }

  if(isDefined(self.pers["rescues"])) {
    setextrascore1(self.pers["rescues"]);
  }

  thread updatematchstatushintonspawn();
}

function updatebombsiteusability() {
  if(!isDefined(level.objectives)) {
    level waittill("enable_player_usability");
  }

  foreach(bombzone in level.objectives) {
    if(bombzone.bombplanted == 0) {
      bombzone.trigger disableplayeruse(self);
    }
  }
}

function updatematchstatushintonspawn() {
  if(level.bombplanted) {
    if(isDefined(level.bombplantedteam) && level.bombplantedteam == self.team) {
      scripts\mp\hud_message::function_f004ef4606b9efdc("cyber_emp_defend");
    } else {
      scripts\mp\hud_message::function_f004ef4606b9efdc("cyber_emp_defsue");
    }

    return;
  }

  if(isDefined(level.cyberemp) && isDefined(level.cyberemp.carrier)) {
    if(level.cyberemp.carrier.team == self.team) {
      if(level.cyberemp.carrier == self) {
        scripts\mp\hud_message::function_f004ef4606b9efdc("cyber_emp_plant");
      } else {
        scripts\mp\hud_message::function_f004ef4606b9efdc("cyber_carrier_defend");
      }
    } else {
      scripts\mp\hud_message::function_f004ef4606b9efdc("cyber_data_defend");
    }

    return;
  }

  scripts\mp\hud_message::function_f004ef4606b9efdc("cyber_emp_pickup");
}

function function_f0f967947c6a7ec8() {
  foreach(player in level.players) {
    if(interruptbombplanting(player)) {
      break;
    }
  }
}

function interruptbombplanting(player) {
  if(istrue(player.isplanting) && isDefined(player.lastnonuseweapon)) {
    player _switchtoweaponimmediate(player.lastnonuseweapon);
    return true;
  }

  return false;
}

function ondeadevent(team) {
  function_f0f967947c6a7ec8();

  if(level.bombexploded > 0 && !level.postgameexfil) {
    return;
  }

  if(team == "all") {
    if(level.bombplanted) {
      otherteam = getotherteam(level.bombplantedteam)[0];
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["end_reason"][tolower(game[otherteam]) + "_eliminated"], undefined, undefined, level.detonatescore);
    } else {
      thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["tie"]);
    }

    return;
  }

  if(level.bombplanted) {
    if(team != level.bombplantedteam) {
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["end_reason"][tolower(game[team]) + "_eliminated"], undefined, undefined, level.detonatescore);
    } else {
      return;
    }

    return;
  }

  if(team == game["attackers"]) {
    level thread scripts\mp\gamelogic::endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    return;
  }

  if(team == game["defenders"]) {
    level thread scripts\mp\gamelogic::endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
  }
}

function ononeleftevent(team) {
  if(level.bombexploded > 0) {
    return;
  }

  lastplayer = getlastlivingplayer(team);

  if(isDefined(lastplayer)) {
    lastplayer.laststanding = 1;
    lastplayer thread givelastonteamwarning();
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  self setclientomnvar("ui_emp_carrier_hud", 0);
  thread checkallowspectating();

  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }

  if(self.isbombcarrier && level.codcasterenabled) {
    self setgametypevip(0);
  }

  awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid);
}

function checkallowspectating() {
  waitframe();
  update = 0;

  if(!getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    update = 1;
  }

  if(!getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    update = 1;
  }

  if(update) {
    scripts\mp\spectating::updatespectatesettings();
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  victim notify("faux_dead");
  oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(victim.isplanting) {
    thread utility::trycall(level.matchdata_logvictimkillevent, lifeid, "planting");
    attacker incpersstat("defends", 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
    return;
  }

  if(victim.isbombcarrier) {
    thread utility::trycall(level.matchdata_logvictimkillevent, lifeid, "carrying");
    return;
  }

  if(victim.isdefusing) {
    thread utility::trycall(level.matchdata_logvictimkillevent, lifeid, "defusing");
  }
}

function printothint() {
  self endon("disconnect");
  wait 0.25;
  self.otspawned = 1;
}

function awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  var_9ff9376383f4bc58 = 0;
  var_8363beb01b537d3e = 0;
  awardeddefend = 0;
  victim = self;
  victimpos = victim.origin;
  attackerpos = attacker.origin;
  attackerisinflictor = 0;

  if(isDefined(einflictor)) {
    attackerpos = einflictor.origin;
    attackerisinflictor = einflictor == attacker;
  }

  if(isDefined(level.cyberemp.carrier)) {
    if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != victim.pers["team"]) {
      if(isDefined(attacker.isbombcarrier) && attackerisinflictor && isDefined(objweapon) && objweapon.basename == "iw9_cyberemp_mp") {
        attacker thread scripts\mp\rank::scoreeventpopup(#"hash_381f16dd2b01c743");
        attacker thread scripts\mp\utility\points::doscoreevent(#"hash_8f7ff4d5395b6ac3");
      } else if(istrue(victim.isbombcarrier)) {
        victim.isbombcarrier = 0;

        if(istrue(victim.showempminimap)) {
          victim hideminimap();
        }

        attacker thread scripts\mp\rank::scoreeventpopup(#"hash_a019ba6fda76386");
        attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2e0245db0447f036");
        thread utility::trycall(level.matchdata_logvictimkillevent, killid, "carrying");
      }

      if(attacker.pers["team"] == level.cyberemp.ownerteam && attacker != level.cyberemp.carrier) {
        var_db36f135f40e7940 = distancesquared(level.cyberemp.carrier.origin, attackerpos);

        if(var_db36f135f40e7940 < 105625) {
          attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
          attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
          attacker incpersstat("defends", 1);
          attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
          thread utility::trycall(level.matchdata_logvictimkillevent, killid, "defending");
        }
      }
    }
  }

  foreach(bombzone in level.objectives) {
    if(istrue(bombzone.trigger.trigger_off)) {
      continue;
    }

    ownerteam = bombzone scripts\mp\gameobjects::getownerteam();

    if(ownerteam != attacker.team) {
      var_a3a2ce8b8e74ebef = distsquaredcheck(bombzone.trigger, attackerpos, victimpos);

      if(var_a3a2ce8b8e74ebef) {
        var_8363beb01b537d3e = 1;
        attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
        attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
        bombzone notify("assault", attacker);
        thread utility::trycall(level.matchdata_logattackerkillevent, killid, "assaulting");
        continue;
      }

      continue;
    }

    givedefend = distsquaredcheck(bombzone.trigger, attackerpos, victimpos);

    if(givedefend) {
      awardeddefend = 1;
      attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
      attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
      bombzone notify("defend", attacker);
      attacker incpersstat("defends", 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      thread utility::trycall(level.matchdata_logattackerkillevent, killid, "defending");
    }
  }
}

function distsquaredcheck(trigger, attackerpos, victimpos) {
  var_9ae8b00a8e8f64fa = distancesquared(trigger.origin, attackerpos);
  var_1881a89c6f1e8775 = distancesquared(trigger.origin, victimpos);

  if(var_9ae8b00a8e8f64fa < 105625 || var_1881a89c6f1e8775 < 105625) {
    if(!isDefined(trigger.modifieddefendcheck)) {
      return 1;
    } else if(attackerpos[2] - trigger.origin[2] < 100 || victimpos[2] - trigger.origin[2] < 100) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function function_b47a96f58a61d923() {
  scripts\mp\codcasterclientmatchdata::function_edba1ee7c2375a5();
}

function empradarwatcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self endon("last_stand_start");
  self endon("emp_dropped");

  if(istrue(level.allowempweapon)) {
    thread weaponswapwatcher();
  }

  while(isDefined(level.cyberemp.carrier) && self == level.cyberemp.carrier) {
    waitframe();

    if(istrue(level.allowempweapon) && self.currentprimaryweapon.basename != "iw9_cyberemp_mp") {
      continue;
    }

    if(!isDefined(self.nextradarpingtime) || gettime() > self.nextradarpingtime) {
      if(istrue(level.allowempweapon)) {
        triggeroneoffradarsweep(self);
      } else {
        triggerportableradarping(self.origin, self, 1000);
      }

      self.nextradarpingtime = gettime() + level.radarpingtime * 1000;
    }
  }
}

function weaponswapwatcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self.showempminimap = 0;

  while(true) {
    if(self.currentprimaryweapon.basename == "iw9_cyberemp_mp") {
      if(!istrue(self.showempminimap)) {
        showminimap();
        self.showempminimap = 1;
      }
    } else if(istrue(self.showempminimap)) {
      hideminimap();
      self.showempminimap = 0;
    }

    waitframe();
  }
}

function applybombcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level.cyber_loadouts[self.team];
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self.gamemode_chosenclass = self.class;
  scripts\mp\class::function_a16868d4dcd81a4b();
  self notify("faux_spawn");
  self.gameobject_fauxspawn = 1;
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

function removebombcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self notify("lost_juggernaut");
  waitframe();
  self.pers["gamemodeLoadout"] = undefined;
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

function setcarriervisibility() {
  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 0;
        break;
      case 1:
        level.cyberemp.objidpingfriendly = 0;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 0.05;
        break;
      case 2:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 1;
        break;
      case 3:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 1.5;
        break;
      case 4:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 2;
        break;
      case 5:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 3;
        break;
      case 6:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 4;
        break;
    }

    return;
  }

  level.cyberemp.objidpingfriendly = 1;
  level.cyberemp.objidpingenemy = 0;
  level.cyberemp.objpingdelay = 3;
}

function onexfilstarted() {
  level.cyberemp scripts\mp\gameobjects::releaseid();

  if(isDefined(level.cyberemp.carrier)) {
    foreach(empsite in level.objectives) {
      if(empsite.bombplanted == 0) {
        empsite.trigger disableplayeruse(level.cyberemp.carrier);
      }
    }
  }

  level.cyberemp.trigger delete();
  level.cyberemp.visuals[0] delete();
}

function emplightsoff() {
  level endon("game_ended");
  level waittill("emp_detonated");

  while(true) {
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

function destroytvs() {
  level endon("game_ended");
  level waittill("emp_detonated");
  tvs = getEntArray("destructibleTVs", "script_noteworthy");

  foreach(tv in tvs) {
    var_fa10ca1040abb07 = getscriptablearray(tv.target, "targetname");

    foreach(stv in var_fa10ca1040abb07) {
      stv setscriptablepartstate("tv", "dead");
      waitframe();
    }
  }
}

function handleemponoff(struct, timeoverride) {
  timedelay = 0.2;

  if(isDefined(timeoverride)) {
    timedelay = timeoverride;
  }

  if(struct.switchstatus == "on") {
    self notify("masterSwitch_on");

    if(!struct.lightson) {
      foreach(light in struct.lights) {
        light thread scripts\mp\motiondetectors::lightonroutine(randomfloat(timedelay));
      }

      thread scripts\mp\motiondetectors::onoffmodelswap(struct.models, "on");
      struct.lightson = 1;
    }

    return;
  }

  if(struct.switchstatus == "off") {
    if(struct.lightson) {
      level scripts\mp\motiondetectors::lightoffroutine(struct.lights);
      thread scripts\mp\motiondetectors::onoffmodelswap(struct.models, "off");
      struct.lightson = 0;
    }

    if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
      struct.switchstatus = "motion";
    }

    self notify("lights_off");
  }
}

function onempdropped(player) {
  player setclientomnvar("ui_emp_carrier_hud", 0);
}

function setupwaypointicons() {
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

function function_8598880f9b913b55() {
  level endon("<dev string:xc8>");
  self notify("<dev string:xd6>");
  self endon("<dev string:xd6>");
  self endon("<dev string:xe4>");
  wait 5;

  while(!level.bombplanted) {
    if(getdvarint(@ "hash_28d1831203c6967b", 0) == 1) {
      if(isDefined(level.cyberemp.carrier)) {
        level.cyberemp.carrier.carryobject thread scripts\mp\gameobjects::setdropped();
        setdevdvar(@ "hash_28d1831203c6967b", 0);
        break;
      }
    }

    wait 1;
  }

  if(level.bombplanted) {
    level waittill("<dev string:xf2>");
  }

  thread function_8598880f9b913b55();
}

function function_847f04c317e266d() {
  level endon("<dev string:xc8>");
  self notify("<dev string:x102>");
  self endon("<dev string:x102>");
  self endon("<dev string:xe4>");
  wait 5;

  while(!level.bombplanted) {
    if(getdvarint(@ "hash_31674c76da07f46f", 0) == 1) {
      foreach(p in level.players) {
        if(isreallyalive(p) && p.team == "<dev string:x113>") {
          level.cyberemp.safeorigin = level.cyberemp.trigger.origin;
          level.cyberemp.carrier = p;
          level.objectives["<dev string:x11d>"][[level.objectives["<dev string:x11d>"].onuse]](p);
          setdevdvar(@ "hash_31674c76da07f46f", 0);
          break;
        }
      }
    }

    if(getdvarint(@ "hash_c65dbfe96fb1f3c4", 0) == 1) {
      foreach(p in level.players) {
        if(isreallyalive(p) && p.team == "<dev string:x11d>") {
          level.cyberemp.safeorigin = level.cyberemp.trigger.origin;
          level.cyberemp.carrier = p;
          level.objectives["<dev string:x113>"][[level.objectives["<dev string:x113>"].onuse]](p);
          setdevdvar(@ "hash_c65dbfe96fb1f3c4", 0);
          break;
        }
      }
    }

    wait 1;
  }

  level waittill("<dev string:xf2>");
  thread function_847f04c317e266d();
}

function function_a60e39eb7d5bd5f4() {
  level endon("<dev string:xc8>");
  self notify("<dev string:x125>");
  self endon("<dev string:x125>");
  self endon("<dev string:xe4>");
  wait 5;

  while(level.bombplanted) {
    if(getdvarint(@ "hash_18728111915eef48", 0) == 1) {
      foreach(p in level.players) {
        if(isreallyalive(p) && p.team == "<dev string:x113>") {
          level.objectives["<dev string:x113>"][[level.objectives["<dev string:x113>"].onuse]](p);
          setdevdvar(@ "hash_18728111915eef48", 0);
          break;
        }
      }
    }

    if(getdvarint(@ "hash_af011dbf40cf4773", 0) == 1) {
      foreach(p in level.players) {
        if(isreallyalive(p) && p.team == "<dev string:x11d>") {
          level.objectives["<dev string:x11d>"][[level.objectives["<dev string:x11d>"].onuse]](p);
          setdevdvar(@ "hash_af011dbf40cf4773", 0);
          break;
        }
      }
    }

    wait 1;
  }

  level waittill("<dev string:x137>");
  thread function_a60e39eb7d5bd5f4();
}

function function_4df61dc99c28632b() {
  level endon("<dev string:xc8>");
  wait 1;
  team = "<dev string:x113>";

  while(getdvarint(@ "hash_d51785ab78729b60", 0) == 1) {
    explosionorigin = level.objectives[team].visuals[0] gettagorigin("<dev string:x147>");
    level.objectives[team].visuals[0] radiusdamage(explosionorigin, 512, 1, 1, undefined, "<dev string:x155>", "<dev string:x166>");
    playsoundatpos(explosionorigin, "<dev string:x176>");
    rot = randomfloat(360);
    explosioneffect = spawnfx(level._effect["<dev string:x190>"], explosionorigin + (0, 0, 50), (0, 0, 1), (cos(rot), sin(rot), 0));
    triggerfx(explosioneffect);
    playrumbleonposition("<dev string:x1a2>", explosionorigin);
    earthquake(0.6, 1.5, explosionorigin, 10000);
    level thread empjamandrumbleclients(1);

    if(game["<dev string:x1b6>"]) {
      exploderindex = 200;
    } else {
      exploderindex = 201;
    }

    if(isDefined(exploderindex)) {
      exploder(exploderindex);
    }

    wait 5;
  }

  wait 1;
  thread function_4df61dc99c28632b();
}

function function_68dd1d69fdeeff68() {
  level endon("<dev string:xc8>");
  wait 1;
  team = "<dev string:x11d>";

  while(getdvarint(@ "hash_4d5720fef87ec87b", 0) == 1) {
    explosionorigin = level.objectives[team].visuals[0] gettagorigin("<dev string:x147>");
    level.objectives[team].visuals[0] radiusdamage(explosionorigin, 512, 1, 1, undefined, "<dev string:x155>", "<dev string:x166>");
    playsoundatpos(explosionorigin, "<dev string:x176>");
    rot = randomfloat(360);
    explosioneffect = spawnfx(level._effect["<dev string:x190>"], explosionorigin + (0, 0, 50), (0, 0, 1), (cos(rot), sin(rot), 0));
    triggerfx(explosioneffect);
    playrumbleonposition("<dev string:x1a2>", explosionorigin);
    earthquake(0.6, 1.5, explosionorigin, 10000);
    level thread empjamandrumbleclients(1);

    if(game["<dev string:x1b6>"]) {
      exploderindex = 201;
    } else {
      exploderindex = 200;
    }

    if(isDefined(exploderindex)) {
      exploder(exploderindex);
    }

    wait 5;
  }

  wait 1;
  thread function_68dd1d69fdeeff68();
}

# /