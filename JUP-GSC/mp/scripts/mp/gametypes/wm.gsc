/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\wm.gsc
***********************************************/

#using script_57614a088fb41089;
#using script_7406801b4c228018;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\wm_ending;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\gametypes\wm_ui;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\menus;
#using scripts\mp\music_and_dialog;
#using scripts\mp\outofbounds;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#namespace wm;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);
  thread scripts\mp\gametypes\wm_ui::init();

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
  setDvar(@ "scr_starsystem", 0);
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.ontimelimit = &ontimelimit;
  level.ontimelimitot = &ontimelimitot;
  level.onrespawndelay = &getrespawndelay;
  level.onplayerkilled = &onplayerkilled;
  level.onplayerconnect = &onplayerconnect;
  level.onplayerdisconnect = &onplayerdisconnect;
  level.onmaprestart = &function_7c1a5a9812c74071;
  level.var_5d435d19e6cdf0b5 = &function_daceac3b2fb6c12e;
  level.var_29977dc303738053 = &function_fa0b69fcb7d0e9a4;
  level.var_ee1c5b2643a1c2f9 = &scripts\mp\gametypes\wm_ui::function_2ea2aacc5d66ae03;
  level.endgame = &wm_endgame;
  level.respawndelaytype = function_29227adb79acc568("respawnType", 0);
  level.attackersrespawndelay = function_ef4d323f56385843("attackersRespawnDelay", 0);
  level.defendersrespawndelay = function_ef4d323f56385843("defendersRespawnDelay", 0);
  level.ontimelimitgraceperiod = 5;
  level.currenttimelimitdelay = 0;
  level.canprocessot = 1;
  level.var_741f3529369c673c = getdvarint(@ "hash_a0c6fd49d30b098", 0);
  level.var_66e7e449b5f69bf1 = getdvarint(@ "hash_91620d978dec2e10", 3);
  level.var_4b2e36526d174471 = getdvarint(@ "hash_901cdd7d417bcf2", 5000);
  scripts\mp\gametypes\wm_ending::init();
  level.bombsplanted = 0;
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level.multibomb = 1;
  level.var_5c9a3961728ac52f = 1;
  level.flagreinforcement = 0;
  level.pausemodetimer = 0;
  level.disablemajoritycapprogress = 1;
  level.objectiveorder = ["zone_1", "zone_2", "zone_3"];
  level.ignorekdrstats = 1;
  level.var_c99eed54a2e150c7 = "war_mode_oob";
  level.var_e7cbc43f8f9aa5d3 = "war_mode_oob";
  function_95463f80d99928e4();
  level.testtdmanywhere = getdvarint(@ "scr_tdmanywhere", 0);
  level.tdmanywhere_dropheight = getdvarfloat(@ "hash_c692d2a11dd6615", 1000);
  level.tdmanywhere_perpenoffset = getdvarfloat(@ "hash_631c58033f43c2dc", 2048);
  level.tdmanywhere_distoffset = getdvarfloat(@ "hash_f314048c87ae28aa", 4092);
  level.var_aac427da0a1569e2 = 1;
  level.parachutecancutparachute = 1;
  level.var_b971bcaccc0cfef5 = getdvarint(@ "hash_d4e14ef4c5ddb12b", 1);
  level.var_13e68971bbe574e0 = getdvarint(@ "hash_24cf80f632d195ea", 1);

  if(istrue(level.testtdmanywhere)) {
    scripts\cp_mp\parachute::initparachutedvars();
  }

  if(matchmakinggame()) {
    level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
  }

  level thread function_87bb976295af0928();
  var_a33709d9b5ffa18e = getEntArray("wm_toggle_visual_ent", "script_noteworthy");

  foreach(ent in var_a33709d9b5ffa18e) {
    ent notsolid();
  }

  level.reinitspawns = &reinitspawns;
  level thread function_df0789ad547dd895();

  function_864a61284fa3b80e();
  scripts\mp\weapons::registerusedcallback("flare", &function_73e585e1743d7482);
}

function function_378462c9ade9c522() {
  function_ed47ea7234924c84();
  level thread scripts\mp\gametypes\wm_ui::function_e20cff3c3800c3a();
  level.defaulttimelimit = getwatcheddvar("timelimit");
  var_4c175651e89543cf = function_29227adb79acc568("stopWatchEnabled", 0);
  var_a56d40e76fdbc670 = undefined;

  foreach(i, objectivestr in level.objectiveorder) {
    level.zone = level.zones[objectivestr];

    if(!isDefined(level.zone)) {
      break;
    }

    if(!isDefined(level.zone.objectives)) {
      return;
    }

    level.zone.index = i;

    if(var_4c175651e89543cf && game["switchedsides"]) {
      timetobeat = game["wm_objective_complete_time_round_" + 1][level.zone.name];

      if(timetobeat == 0) {
        break;
      }
    }

    if(isDefined(var_a56d40e76fdbc670)) {
      level thread scripts\mp\gametypes\wm_ui::function_51bce80de8cbf370(var_a56d40e76fdbc670, level.zone.objectivetype);
    }

    level thread function_14cfba68197a456e(level.zone);
    scripts\mp\gametypes\wm_ui::function_a2b714e5d5977e3a(level.zone);
    function_7a34b3c99c2588ab(objectivestr);
    level thread run_wm_oob_logic(level.zone);
    function_e63a2606efcb8d2c(level.zone);
    function_32541bb322c181a0(level.zone);
    function_a2ee743c71ae199c(level.zone);
    level.ontimelimitot = &ontimelimitot;
    objcount = level.zone.objectives.size;

    if(function_c8a59a91c2a5ea39(objectivestr)) {
      level thread function_3f3ae4ca68128b9d(level.zone.objectives);
    }

    while(objcount > 0) {
      objcount = 0;

      foreach(obj in level.zone.objectives) {
        if(!istrue(level.objectives[obj].complete)) {
          objcount++;
        }
      }

      baseprogress = i / level.objectiveorder.size;
      objectiveprogress = (level.zone.objectives.size - objcount) / level.zone.objectives.size;

      if(level.zone.objective.objectivetype == 6 || level.zone.objective.objectivetype == 11) {
        if(isDefined(level.escortvehicles[0])) {
          objectiveprogress = level.escortvehicles[0].progress;
        }
      }

      totalprogress = baseprogress + objectiveprogress * 1 / level.objectiveorder.size;
      setomnvar("ui_wm_objective_progress_total", totalprogress);
      waitframe();
    }

    thread function_20981f58c35e2997(game["attackers"]);
    function_d977011dd596b7eb(level.zone);
    var_aaf69e9a30e4a16 = level.objectiveorder[i + 1];

    if(isDefined(var_aaf69e9a30e4a16)) {
      function_3c75b8db5739c0a6(level.zones[var_aaf69e9a30e4a16]);
    }

    function_3d2dfad8246b76f9(level.zone);
    function_fc3c787b555257ac(level.zone);
    function_26aeca31642d5751(objectivestr);
    delaythread(23, &function_ed47ea7234924c84);
    thread printandsoundoneveryone(game["attackers"], game["defenders"], undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost");
    var_a56d40e76fdbc670 = level.zone.objectivetype;
    waitframe();
  }

  if(isDefined(level.var_9e151dadd78097d1) && level.var_9e151dadd78097d1 > 0) {
    wait level.var_9e151dadd78097d1;
  }

  function_9196e05712b31624();
}

function wm_endgame(winner, endreasontext, nukedetonated) {
  level.var_2f006c7490fb7639 = 1;

  foreach(player in level.players) {
    function_f979eb22c4cee76d(player);
    player.operatorcustomization = undefined;
  }

  endgame_regularmp(winner, endreasontext, nukedetonated);
}

function ontimelimit() {
  if(istrue(level.var_2f006c7490fb7639)) {
    return;
  }

  function_3d2dfad8246b76f9(level.zone);
  scripts\mp\gametypes\wm_objectives::function_c4835bfede02aee0(level.zone.objectivetype);
  function_77b9d11c06b1fd84();
  scripts\mp\gametypes\wm_ui::function_f56dd59bba71b655(0);
  dlog_recordevent("dlog_event_wm_server_objective_end", ["match_guid", function_94c7ae7049488358(), "map_name", level.script, "objective_time", gettime() / 1000, "objective_type", "" + level.zone.objectivetype, "objective_id", level.zone.name, "round", "" + game["roundsPlayed"], "winner", "defenders"]);

  foreach(objstr in level.zone.objectives) {
    status = ter_op(istrue(level.objectives[objstr].complete), "Completed", "Failed");
    scripts\mp\gametypes\wm_objectives::function_8bce9c7e1a380040(objstr, status, 1);
  }
}

function function_14cfba68197a456e(zone) {
  objectivestr = level.var_58b44a84d306019c[zone.objectivetype];

  if(!isDefined(objectivestr) || level.defaulttimelimit == 0) {
    return;
  }

  rulename = objectivestr + "TimeLimit";

  if(isusingmatchrulesdata()) {
    if(getmatchrulesdata("wmData", rulename) != 0) {
      setdynamicdvar(hashcat(@ "hash_b56dd6b9b6093824", rulename), getmatchrulesdata("wmData", rulename));
    }
  }

  timelimit = getdvarfloat(hashcat(@ "hash_b56dd6b9b6093824", objectivestr, "TimeLimit"), level.defaulttimelimit);

  if(isDefined(zone.objective.params) && isDefined(zone.objective.params["timelimit"])) {
    timelimit = zone.objective.params["timelimit"];
  }

  if(function_29227adb79acc568("stopWatchEnabled", 0) && game["switchedsides"]) {
    timetobeat = game["wm_objective_complete_time_round_" + 1][zone.name];
    timelimit = timetobeat + level.var_bf720fce8107e20;
  }

  if(timelimit != getwatcheddvar("timelimit")) {
    setDvar(@ "hash_1466f43b92459194", timelimit);
  }

  if(!game["switchedsides"]) {
    game["wm_objective_time_limit"][zone.name] = timelimit;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  level.currentobjectivestarttime = gettime();
}

function function_3d2dfad8246b76f9(zone) {
  objectivetimepassed = (gettime() - level.currentobjectivestarttime) / 1000;

  if(function_29227adb79acc568("stopWatchEnabled", 0)) {
    if(!game["switchedsides"]) {
      objtimelimit = game["wm_objective_time_limit"][zone.name];

      if(objectivetimepassed > objtimelimit) {
        objectivetimepassed = objtimelimit;
      }
    } else {
      timetobeat = game["wm_objective_complete_time_round_" + 1][zone.name];

      if(objectivetimepassed < timetobeat) {
        level.var_bf720fce8107e20 = timetobeat - objectivetimepassed;
      } else {
        level.var_bf720fce8107e20 = 0;
        objectivetimepassed = timetobeat;
      }
    }
  }

  game["wm_objective_complete_time_round_" + game["roundsPlayed"] + 1][zone.name] = objectivetimepassed;
  setomnvar("ui_wm_objective_complete_time_" + zone.index, int(floor(objectivetimepassed * 1000)));
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  function_18581799c48cc262("domData", "flagCaptureTime");
  function_18581799c48cc262("wmData", "respawnType");
  function_18581799c48cc262("wmData", "attackersRespawnDelay");
  function_18581799c48cc262("wmData", "defendersRespawnDelay");
  function_18581799c48cc262("wmData", "stopWatchEnabled");
  function_18581799c48cc262("wmData", "buildableEnabled");
  function_18581799c48cc262("wmData", "zoneReversible");
  function_18581799c48cc262("wmData", "tankTurretUsable");
  function_18581799c48cc262("wmData", "IEDBombEnabled");
  function_18581799c48cc262("wmData", "RPGAgentsEnabled");
  function_18581799c48cc262("wmData", "tankMaxHealth");
  function_18581799c48cc262("wmData", "tankSpeed");
  function_18581799c48cc262("wmData", "tankRepair");
  function_18581799c48cc262("wmData", "tankContestable");
  function_18581799c48cc262("wmData", "tankReversible");
  function_18581799c48cc262("wmData", "hackUseTime");
  function_18581799c48cc262("wmData", "hackRestoreTime");
  function_18581799c48cc262("wmData", "hackUploadTime");
  function_18581799c48cc262("wmData", "escortCaptureTime");
  function_18581799c48cc262("wmData", "captureFlagZoneTime");
  function_18581799c48cc262("BombData", "defuseTime");
  function_18581799c48cc262("BombData", "plantTime");
  function_18581799c48cc262("BombData", "bombTimer");

  switch (getmapname()) {
    case #"hash_5f400f0334a4a47b":
      function_18581799c48cc262("wmData", "lfEscortTimeLimit");
      function_18581799c48cc262("wmData", "lfFlagCaptureTime");
      break;
    case #"hash_a57f5ebbc35a8c1f":
      function_18581799c48cc262("wmData", "sdHackUploadTime");
      function_18581799c48cc262("wmData", "sdVehicleSpeed");
      break;
    default:
      break;
  }
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  scripts\mp\gametypes\wm_ui::function_20c1029d048bbe3c(game["attackers"]);

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/WAR_HINT");
  }

  seticonnames();
  function_ae5b8605ffa85097();
  level thread scripts\mp\gametypes\wm_objectives::function_16d881992389f811();
  level thread function_e7a50bb1d94a4d43();
  scripts\cp_mp\parachute::initparachutedvars();

  thread function_8469a5927d069db7();

  if(false) {
    function_bf2918399f1800b1();
  }

  function_b01dbd7f1c170eb();
  level thread function_378462c9ade9c522();

  if(getdvarint(@ "hash_af6b97ac5aefbcab", 1) && scripts\mp\utility\game::matchmakinggame() && scripts\cp_mp\utility\game_utility::function_8b6131109e66d962()) {
    level.var_d37d95ac1717903c = &function_4ad04da1c6ca78;
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    level thread function_4fda5b98200abdcf();
  }

  level thread function_1f629022819f6f39();
}

function function_4fda5b98200abdcf() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  setnojiptime(0, 0);
  level.nojip = 0;
}

function function_b01dbd7f1c170eb() {
  level.var_bf720fce8107e20 = 0;

  if(!istrue(game["switchedsides"])) {
    foreach(objectivestr in level.objectiveorder) {
      game["wm_objective_complete_time_round_" + 1][objectivestr] = 0;
      game["wm_objective_complete_time_round_" + 2][objectivestr] = 0;
      game["wm_objective_time_limit"][objectivestr] = 0;
    }
  }
}

function function_87bb976295af0928() {
  while(!gameflagexists("infil_started")) {
    waitframe();
  }

  gameflagwait("infil_started");
  wait 1;
  scripts\mp\utility\dialog::leaderdialog("offense_infil", game["attackers"]);
  scripts\mp\utility\dialog::leaderdialog("defense_infil", game["defenders"]);
}

function ontimelimitot() {
  function_4b6345bd08cabf83();
  currentobjective = level.zone.objectivetype;
  level notify("obj_type_" + currentobjective + "_overtime_" + level.mapname);
}

function function_ae5b8605ffa85097() {
  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  scripts\mp\spawnlogic::addstartspawnpoints("mp_wm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_wm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_wm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_wm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_wm_spawn_allies_start");
  defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_wm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_wm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_wm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_wm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_wm_spawn_secondary", 1, 1);
  spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_wm_spawn");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("mp_wm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", spawns);
  scripts\mp\spawnlogic::registerspawnset("fallback", spawnssecondary);
  level.zones = [];
  volumes = [];
  var_5b4a497624dbf524 = [];

  foreach(i, objectivestr in level.objectiveorder) {
    zone = spawnStruct();
    zone.subzones = [];
    zone.subzones["attackers"] = getEnt(objectivestr + "_attackers", "targetname");
    zone.subzones["defenders"] = getEnt(objectivestr + "_defenders", "targetname");

    if(isDefined(zone.subzones["attackers"])) {
      zone.subzones["attackers"].side = "attackers";
    }

    if(isDefined(zone.subzones["defenders"])) {
      zone.subzones["defenders"].side = "defenders";
    }

    zone.var_8ef54cefbaf2498b = [];
    zone.var_8ef54cefbaf2498b["attackers_dyn"] = getEnt(objectivestr + "_attackers_dyn", "targetname");
    zone.var_8ef54cefbaf2498b["defenders_dyn"] = getEnt(objectivestr + "_defenders_dyn", "targetname");

    if(isDefined(zone.var_8ef54cefbaf2498b["attackers_dyn"])) {
      zone.var_8ef54cefbaf2498b["attackers_dyn"].side = "attackers";
      zone.var_8ef54cefbaf2498b["attackers_dyn"].var_f6b123401be81289 = 1;
    }

    if(isDefined(zone.var_8ef54cefbaf2498b["defenders_dyn"])) {
      zone.var_8ef54cefbaf2498b["defenders_dyn"].side = "defenders";
      zone.var_8ef54cefbaf2498b["defenders_dyn"].var_f6b123401be81289 = 1;
    }

    zone.name = objectivestr;
    level.zones[objectivestr] = zone;

    foreach(k, volume in zone.subzones) {
      volume.spawnset = "spawn_set_" + i + "_" + k;
      volume.fallbackspawnset = "spawn_set_fallback_" + i + "_" + k;
      volume.spawnpoints = [];
      volume.fallbackspawnpoints = [];

      if(!isDefined(volumes[volume.targetname])) {
        volumes[volume.targetname] = [];
      }

      size = volumes[volume.targetname].size;
      volumes[volume.targetname][size] = volume;
      var_5b4a497624dbf524[volume.spawnset] = [];
      var_5b4a497624dbf524[volume.fallbackspawnset] = [];
    }
  }

  spawnpoints = array_combine(getspawnarray("mp_wm_spawn"), getspawnarray("mp_wm_spawn_secondary"));

  foreach(spawnpoint in spawnpoints) {
    if(isDefined(spawnpoint.target) && spawnpoint.target != "") {
      if(isDefined(volumes[spawnpoint.target])) {
        foreach(volume in volumes[spawnpoint.target]) {
          key = undefined;

          if(spawnpoint.classname == "mp_wm_spawn") {
            key = volume.spawnset;
            size = volume.spawnpoints.size;
            volume.spawnpoints[size] = spawnpoint;
          } else if(spawnpoint.classname == "mp_wm_spawn_secondary") {
            key = volume.fallbackspawnset;
            size = volume.fallbackspawnset.size;
            volume.fallbackspawnpoints[size] = spawnpoint;
          }

          size = var_5b4a497624dbf524[key].size;
          var_5b4a497624dbf524[key][size] = spawnpoint;
        }
      }
    }

    if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "") {
      if(!isDefined(var_5b4a497624dbf524[spawnpoint.script_noteworthy])) {
        var_5b4a497624dbf524[spawnpoint.script_noteworthy] = [];
      }

      size = var_5b4a497624dbf524[spawnpoint.script_noteworthy].size;
      var_5b4a497624dbf524[spawnpoint.script_noteworthy][size] = spawnpoint;
    }
  }

  foreach(key, points in var_5b4a497624dbf524) {
    scripts\mp\spawnlogic::registerspawnset(key, points);
  }
}

function function_9fb7ca43ba3b6784(prefix, var_1fcc46cd747288e3) {
  level.zone.subzones["attackers"].spawnset = prefix + "_attackers_" + var_1fcc46cd747288e3;
  level.zone.subzones["defenders"].spawnset = prefix + "_defenders_" + var_1fcc46cd747288e3;
}

function getrespawndelay() {
  if(level.respawndelaytype == 0) {
    if(self.team == game["defenders"]) {
      return level.defendersrespawndelay;
    } else {
      return level.attackersrespawndelay;
    }

    return;
  }

  return 0;
}

function function_e7a50bb1d94a4d43() {
  canspawnvehicles = getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0;

  if(canspawnvehicles) {
    structarray = getStructArray("rhib_spawn", "targetname");

    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("veh9_rhib", spawndata);
    }

    structarray = getStructArray("patrol_boat_spawn", "targetname");

    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("veh9_patrol_boat", spawndata);
    }

    structarray = getStructArray("jup_atv_spawn", "targetname");

    foreach(struct in structarray) {
      spawndata = spawnStruct();
      spawndata.origin = struct.origin;
      spawndata.angles = struct.angles;
      vehicle = vehicle_spawn("atv", spawndata);
    }
  }
}

function function_fc3c787b555257ac(zone) {
  if(getwatcheddvar("timelimit") == 0) {
    return;
  }

  if(!isDefined(level.extratime)) {
    level.extratime = 0;
  }

  time = float(gettimepassed() / 1000);
  level.extratime = time;
  timeremaining = scripts\mp\gamelogic::gettimeremaining();

  if(isDefined(zone.objective.params["extraTimeGap"])) {
    pausetime = zone.objective.params["extraTimeGap"];
    scripts\mp\gamelogic::pausetimer();
    wait pausetime;
  }

  scripts\mp\gamelogic::resumetimer(timeremaining);
}

function function_3c75b8db5739c0a6(zone) {
  objectivestr = zone.name;

  if(objectivestr != "zone_1") {
    level thread function_5fe6e12feb6032f();
    var_353003858ac7dd3 = 0;

    foreach(player in level.players) {
      if(!isalive(player) || is_equal(player.pers["team"], game["attackers"])) {
        continue;
      }

      player thread function_e470aac29d4b9503(3, level.zone.objectives, objectivestr);
      var_353003858ac7dd3 = 1;
    }

    if(var_353003858ac7dd3) {
      level thread function_1a0bfc0468b2a1eb();
    }
  }
}

function function_1a0bfc0468b2a1eb() {
  level endon("game_ended");
  level.var_817d170f09af43fe = 1;
  var_27296e975adcf712 = 1;

  while(var_27296e975adcf712) {
    wait 1;
    var_27296e975adcf712 = 0;

    foreach(player in level.players) {
      if(!isalive(player) || is_equal(player.pers["team"], game["attackers"])) {
        continue;
      }

      if(istrue(player.var_d24048ab5fb37690)) {
        var_27296e975adcf712 = 1;
      }
    }
  }

  level.var_817d170f09af43fe = 0;
  level notify("wm_defender_fallback_end");
}

function function_5fe6e12feb6032f() {
  level endon("game_ended");
  level.var_2a28fcaf54b1ace2 = 1;
  scripts\mp\gametypes\wm_utility::function_134331ffde3c261a();
  wait 23;
  level.var_2a28fcaf54b1ace2 = 0;
  level notify("wm_fallback_end");
}

function function_e63a2606efcb8d2c(zone) {
  objectives = zone.objectives;

  var_2354bc413c2092db = ["<dev string:x1c>", "<dev string:x22>", "<dev string:x28>", "<dev string:x2e>", "<dev string:x34>", "<dev string:x3a>", "<dev string:x40>"];

  foreach(i, obj in objectives) {
    label = obj;

    if(istrue(level.var_f5c4d2c739170293)) {
      label = var_2354bc413c2092db[i];
    }

    objectivetype = level.objectives[obj].objectivetype;
    [[level.var_e357e71e1a77a8e[objectivetype]]](label);
  }
}

function function_a2ee743c71ae199c(zone) {
  if(isDefined(level.var_81e886c170a93ace[zone.objectivetype])) {
    struct = level.var_81e886c170a93ace[zone.objectivetype];
    var_b8e860f117afbf3 = 11;
    level thread function_8752b093985bf8e7(var_b8e860f117afbf3, 8, struct.attackerline, "attackers");
    level thread function_8752b093985bf8e7(var_b8e860f117afbf3, 8, struct.defenderline, "defenders");
  }

  if(isDefined(level.var_829a632ddd0e4e79[zone.objectivetype])) {
    level thread[[level.var_829a632ddd0e4e79[zone.objectivetype]]](zone);
  }

  if(istrue(level.var_d50739af5c160f54)) {
    level thread function_38f25a9137cdbd52();
  }
}

function function_32541bb322c181a0(zone) {
  [[level.var_b0c3857a6da91b6c[zone.objectivetype]]](zone);

  if(isDefined(level.players)) {
    foreach(player in level.players) {
      player scripts\mp\gametypes\wm_ui::function_d2ac05c6539c221e();
    }
  }

  scripts\mp\flags::gameflagset(zone.name + "_objective_start");
  dlog_recordevent("dlog_event_wm_server_objective_start", ["match_guid", function_94c7ae7049488358(), "map_name", level.script, "objective_time", gettime() / 1000, "objective_type", "" + zone.objectivetype, "objective_id", zone.name, "round", "" + game["roundsPlayed"] + 1]);
}

function function_d977011dd596b7eb(zone) {
  [[level.var_d23ba6208081aa8f[zone.objectivetype]]](zone);
  scripts\mp\gametypes\wm_ui::function_f56dd59bba71b655(1);
  scripts\mp\flags::gameflagset(zone.name + "_objective_end");
  dlog_recordevent("dlog_event_wm_server_objective_end", ["match_guid", function_94c7ae7049488358(), "map_name", level.script, "objective_time", gettime() / 1000, "objective_type", "" + zone.objectivetype, "objective_id", zone.name, "round", "" + game["roundsPlayed"] + 1, "winner", "attackers"]);
}

function function_7a34b3c99c2588ab(zone) {
  level.var_57c2ee5aaa8758ea = [];

  foreach(side in ["attackers", "defenders"]) {
    level.var_57c2ee5aaa8758ea[side] = getEntArray(zone + "_oob_line_" + side, "targetname");
  }

  temp = level.var_57c2ee5aaa8758ea["attackers"];
  level.var_57c2ee5aaa8758ea["attackers"] = level.var_57c2ee5aaa8758ea["defenders"];
  level.var_57c2ee5aaa8758ea["defenders"] = temp;
  function_9b0db85a39bb6e57();
}

function function_ed47ea7234924c84(zone) {
  level.var_2fd09dc91fe6b8a0["attackers"] = [];
  level.var_2fd09dc91fe6b8a0["defenders"] = [];
  function_9b0db85a39bb6e57();
}

function function_26aeca31642d5751(zone) {
  level.var_2fd09dc91fe6b8a0 = [];

  foreach(side in ["attackers", "defenders"]) {
    level.var_2fd09dc91fe6b8a0[side] = getEntArray(zone + "_fallback_lines", "targetname");
  }

  level.var_2fd09dc91fe6b8a0["attackers"] = [];
  function_9b0db85a39bb6e57();
}

function function_9b0db85a39bb6e57() {
  foreach(player in level.players) {
    function_708eab29b3ad59d9(player);
  }
}

function function_708eab29b3ad59d9(player) {
  allents = getEntArray("wm_toggle_visual_ent", "script_noteworthy");

  foreach(ent in allents) {
    ent hidefromplayer(player);
  }

  if(isDefined(level.var_2fd09dc91fe6b8a0)) {
    function_2402ec9e20c0a094(player, level.var_2fd09dc91fe6b8a0);
  }

  if(isDefined(level.var_57c2ee5aaa8758ea)) {
    function_2402ec9e20c0a094(player, level.var_57c2ee5aaa8758ea);
  }

  if(isDefined(level.var_b7a5235fd7e9f2f2)) {
    function_2402ec9e20c0a094(player, level.var_b7a5235fd7e9f2f2);
  }
}

function function_2402ec9e20c0a094(player, array) {
  var_633eb1ff932b47bf = [];
  var_ca91d0e6457d541a = [];

  foreach(side in ["attackers", "defenders"]) {
    if(is_equal(player.pers["team"], game[side])) {
      var_633eb1ff932b47bf = array[side];
      continue;
    }

    var_ca91d0e6457d541a = array[side];
  }

  foreach(ent in var_633eb1ff932b47bf) {
    ent showtoplayer(player);
  }

  foreach(ent in var_ca91d0e6457d541a) {
    ent hidefromplayer(player);
  }
}

function function_c8a59a91c2a5ea39(zone) {
  if(zone == "<dev string:x46>" && getdvarint(@ "hash_562d6f609676f102", 0)) {
    return 0;
  }

  if(getdvarint(@ "hash_562d6f609676f102", 0)) {
    return 1;
  }

  if(getdvarint(@ "hash_2251ec03b35920c4", 0)) {
    return 1;
  }

  return 0;
}

function function_3f3ae4ca68128b9d(objectives) {
  scripts\mp\flags::gameflagwait("<dev string:x50>");
  wait 5;

  foreach(obj in objectives) {
    level.objectives[obj].complete = 1;

    if(is_equal(level.objectives[obj].id, "<dev string:x61>")) {
      scripts\mp\gametypes\obj_dom::removeobjective(level.objectives[obj]);
      continue;
    }

    level.objectives[obj] scripts\mp\gameobjects::setvisibleteam("<dev string:x6c>");
    level.objectives[obj] scripts\mp\gameobjects::allowuse("<dev string:x6c>");
  }
}

function function_e470aac29d4b9503(delaytime, objectives, zone_name) {
  player = self;
  player endon("disconnect");
  player.var_d24048ab5fb37690 = 1;
  player function_a2d9ea22cacea5e9();

  if(isDefined(level.zone.objective) && isDefined(level.zone.objective.params["retreatTimeLimit"])) {
    oobtimelimit = level.zone.objective.params["retreatTimeLimit"];
  } else {
    oobtimelimit = 20;
  }

  wait delaytime;

  if(isreallyalive(player)) {
    player scripts\mp\gametypes\wm_ui::function_557efb699f50447b(oobtimelimit, 1);
    player thread function_114808366456147a(oobtimelimit);
    player function_8f1133ded9c88a9c(level.zones[zone_name]);
  }

  player notify("player_retreat_finished");
  player.var_d24048ab5fb37690 = undefined;
  player function_a2d9ea22cacea5e9();
  player.oobtimelimit = 5;
}

function function_8f1133ded9c88a9c(zone) {
  player = self;
  player endon("death_or_disconnect");
  trigger = getEnt("fallback_destination_trigger_" + zone.name, "targetname");

  if(!isDefined(trigger)) {
    return;
  }

  player thread function_df6b51b9e3783a0d();

  while(!player istouching(trigger) || isDefined(zone.subzones["attackers"]) && player istouching(zone.subzones["attackers"])) {
    waitframe();
  }

  player scripts\mp\utility\points::doscoreevent(#"hash_3a01ed4e57a4faa2");
}

function function_df6b51b9e3783a0d() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_retreat_finished");
  retreatstarttime = gettime();

  while(true) {
    if(!isDefined(self.var_d24048ab5fb37690)) {
      return;
    }

    self waittill("exit_oob");
    retreattimepassed = gettime();
    timeleft = max(floor(20 - (retreattimepassed - retreatstarttime) / 1000), 0);
    waitframe();

    if(timeleft > 0) {
      scripts\mp\gametypes\wm_ui::function_557efb699f50447b(timeleft, 1);
    }
  }
}

function function_48cad4789e694e53() {
  if(isDefined(level.zone)) {
    level.zone.var_5eede24b6ac5862d = 1;
  }
}

function run_wm_oob_logic(zone) {
  level endon("game_ended");
  level notify("run_wm_oob_logic");
  level endon("run_wm_oob_logic");
  volumes = zone.subzones;

  if(!isDefined(volumes)) {
    return;
  }

  if(getdvarint(@ "hash_9a49531827cbbaa5", 0)) {
    return;
  }

  level thread function_460a7a4604f2b0ad(volumes);

  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    if(isDefined(level.var_354c397f5458af46)) {
      volumes = level.var_354c397f5458af46;
    } else {
      volumes = zone.subzones;
    }

    if(istrue(zone.var_5eede24b6ac5862d) && isDefined(zone.var_8ef54cefbaf2498b)) {
      volumes = array_combine(volumes, zone.var_8ef54cefbaf2498b);
    }

    foreach(player in level.players) {
      if(!isDefined(player.oobtimelimit)) {
        player.oobtimelimit = 5;
        player.var_7fd12290e298a95b = 0;
        player.var_998a126afff171c3 = gettime();
      }

      foreach(volume in volumes) {
        if(function_2f3dba4fe40f039d(player, volume)) {
          if(!istrue(player.var_7fd12290e298a95b)) {
            player.oobstarttime = gettime();
            oobinterval = player.oobstarttime - player.var_998a126afff171c3;

            if(oobinterval > 5000) {
              if(istrue(volume.var_f6b123401be81289)) {
                player.oobtimelimit = 3;
              } else {
                player.oobtimelimit = 5;
              }
            }
          }

          player.var_7fd12290e298a95b = 1;
          player function_fc402cde7f63185();
          oobtimelimit = 0;

          if(isDefined(player.oobtimelimit)) {
            oobtimelimit = player.oobtimelimit;
          }

          if(oobtimelimit > 0) {
            player scripts\mp\gametypes\wm_ui::function_557efb699f50447b(oobtimelimit);
          }

          player thread function_95558d2ff334fd9(volume);

          if(istrue(player.var_7fd12290e298a95b)) {
            player thread function_114808366456147a(oobtimelimit);
          }
        }
      }
    }

    if(istrue(level.var_13e68971bbe574e0)) {
      foreach(player in level.players) {
        if(isDefined(player.recondronesuper)) {
          player.recondronesuper function_359ad11d5cba23a(volumes);
        }
      }
    }

    wait 0.25;
  }
}

function function_460a7a4604f2b0ad(volumes) {
  level endon("run_wm_oob_logic");

  if(!getdvarint(@ "hash_1de3e2898f5ab067", 0)) {
    return;
  }

  while(true) {
    foreach(volume in volumes) {
      botdebugdrawtrigger(1, volume, (1, 0, 0), 1);
    }

    wait 1;
  }
}

function function_44a7deabc6d77499() {
  volumes = [];
  current_zone = level.zone;

  if(isDefined(current_zone)) {
    if(isDefined(level.var_354c397f5458af46)) {
      volumes = level.var_354c397f5458af46;
    } else {
      volumes = current_zone.subzones;
    }

    if(istrue(current_zone.var_5eede24b6ac5862d)) {
      volumes = array_combine(volumes, current_zone.var_8ef54cefbaf2498b);
    }
  }

  return volumes;
}

function function_daceac3b2fb6c12e() {
  if(!istrue(level.var_b971bcaccc0cfef5)) {
    return 0;
  }

  entity_team = undefined;

  if(isPlayer(self)) {
    entity_team = self.pers["team"];
  } else if(isDefined(self.owner) && isPlayer(self.owner)) {
    entity_team = self.owner.pers["team"];
  }

  if(!isDefined(entity_team)) {
    return 0;
  }

  oob_volumes = function_44a7deabc6d77499();
  var_3772bbd994047cb6 = 0;

  foreach(volume in oob_volumes) {
    if(!self istouching(volume)) {
      continue;
    }

    volumeteam = game[volume.side];

    if(!is_equal(volumeteam, entity_team)) {
      var_3772bbd994047cb6 = 1;
      break;
    }
  }

  return var_3772bbd994047cb6;
}

function function_fa0b69fcb7d0e9a4(pointtocheck, teamtocheck) {
  if(!istrue(level.var_b971bcaccc0cfef5)) {
    return 0;
  }

  oob_volumes = function_44a7deabc6d77499();
  var_26d9c7e21efa1bdd = 0;

  foreach(volume in oob_volumes) {
    if(!ispointinvolume(pointtocheck, volume)) {
      continue;
    }

    volumeteam = game[volume.side];

    if(!is_equal(volumeteam, teamtocheck)) {
      var_26d9c7e21efa1bdd = 1;
      break;
    }
  }

  return var_26d9c7e21efa1bdd;
}

function function_73e585e1743d7482(grenade) {
  var_fd279f12b4aff449 = isDefined(self.var_d24048ab5fb37690) && istrue(self.var_d24048ab5fb37690) && is_equal(self.pers["team"], game["defenders"]);

  if(istrue(var_fd279f12b4aff449)) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread scripts\mp\equipment\tac_insert::function_3fd179c2e0859395();
    return;
  }

  if(istrue(self.var_8e61d4338428b3bd)) {
    self.var_8e61d4338428b3bd = 0;
    grenade delete();
    return;
  }

  scripts\mp\equipment\tac_insert::tacinsert_used(grenade);
}

function function_2f3dba4fe40f039d(player, volume) {
  if(getdvarint(@ "hash_2251ec03b35920c4", 0)) {
    return false;
  }

  if(istrue(player.var_7fd12290e298a95b)) {
    return false;
  }

  if(istrue(player.var_d24048ab5fb37690)) {
    return false;
  }

  if(!player istouching(volume)) {
    return false;
  }

  if(!player function_4e5c4b0545465079(volume)) {
    return false;
  }

  if(!isreallyalive(player)) {
    return false;
  }

  return true;
}

function function_4e5c4b0545465079(volume) {
  volumeteam = game[volume.side];
  playerteam = self.pers["team"];
  return !is_equal(volumeteam, playerteam);
}

function function_65487b37f7e5d4a7(volume) {
  volumeteam = game[volume.side];
  playerteam = self.pers["team"];
  return is_equal(volumeteam, playerteam);
}

function function_114808366456147a(time) {
  player = self;
  player endon("left_wmOOB");
  player endon("death_or_disconnect");

  if(time > 0) {
    wait time;
  }

  player.oobdeath = 1;
  player scripts\mp\utility\damage::_suicide(undefined, 1);
  player.oobdeath = undefined;
  player.var_7fd12290e298a95b = 0;
}

function function_95558d2ff334fd9(volume) {
  player = self;
  player endon("death_or_disconnect");
  player endon("start_retreat");

  while(player istouching(volume)) {
    waitframe();
  }

  if(istrue(player.var_7fd12290e298a95b)) {
    player function_a2d9ea22cacea5e9();
  }
}

function function_a2d9ea22cacea5e9(var_1734356c53952b48) {
  player = self;
  player.var_7fd12290e298a95b = 0;
  player.var_998a126afff171c3 = gettime();

  if(istrue(var_1734356c53952b48)) {
    player.oobtimelimit = 5;
  } else if(isDefined(player.oobtimelimit) && isDefined(player.oobstarttime)) {
    player.oobtimelimit = int(player.oobtimelimit - (player.var_998a126afff171c3 - player.oobstarttime) / 1000);
  }

  player notify("left_wmOOB");
  player setclientomnvar("ui_out_of_bounds_type", 0);
  player setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function function_d23c7c1add9fb181(origin) {
  array = [];

  foreach(element in level.objectives) {
    array[array.size] = element;
  }

  level.var_e628a8912ad74c62 = origin;
  objectives = array_sort_with_func(array, &function_ce8bbfe1d4422f48);
  return objectives[0];
}

function function_ce8bbfe1d4422f48(obj1, obj2) {
  return distance(obj1.curorigin, level.var_e628a8912ad74c62) < distance(obj2.curorigin, level.var_e628a8912ad74c62);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.bombtimer = dvarfloatvalue("bombtimer", 45, 1, 240);
  level.planttime = dvarfloatvalue("planttime", 10, 0, 20);
  level.defusetime = dvarfloatvalue("defusetime", 5, 0, 20);
  level.multibomb = dvarintvalue("multibomb", 1, 0, 1);
  level.silentplant = dvarintvalue("silentPlant", 0, 0, 1);
  level.resetprogress = dvarintvalue("resetProgress", 0, 0, 1);
  level.defenderscanseedroppedbomb = dvarintvalue("defendersCanSeeDroppedBomb", 0, 0, 1);
  level.defenderscanseeplantedbomb = dvarintvalue("defendersCanSeePlantedBomb", 0, 0, 1);
  level.assignbombzonechevrons = dvarintvalue("assignBombZoneChevrons", 0, 0, 1);
}

function reinitspawns() {
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x74>");
  scripts\mp\spawnlogic::function_8390bf8c3b74466a("<dev string:x7e>");
  spawns = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x8a>");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("<dev string:x9a>");
  scripts\mp\spawnlogic::registerspawnset("<dev string:x74>", spawns);
  scripts\mp\spawnlogic::registerspawnset("<dev string:x7e>", spawnssecondary);
}

function function_3a586a582f9648ca(spawnpoint) {
  classname = spawnpoint.classname;
  return issubstr(classname, "mp_wm_spawn");
}

function function_4ad0a56a9bd6a714(spawnpoints) {
  randomindex = randomint(spawnpoints.size);
  randompoint = spawnpoints[randomindex];
  return randompoint;
}

function getspawnpoint() {
  player = self;
  spawnteam = player.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers", 2);
      spawnset = "start_attackers";
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders", 2);
      spawnset = "start_defenders";
    }
  } else {
    if(is_equal(player.pers["team"], game["attackers"])) {
      side = "attackers";
    } else {
      side = "defenders";
    }

    var_113323c38760edff = getdvarint(@ "hash_3058503b6794e09b", 0) == 1;

    if(var_113323c38760edff && istrue(level.var_817d170f09af43fe) && isDefined(level.var_4a5cade1a0c8264)) {
      spawnpoint = [[level.var_4a5cade1a0c8264]](player, spawnteam, level.zone.subzones[side].spawnset, level.zone.subzones[side].fallbackspawnset, 2);
    } else {
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(player, spawnteam, level.zone.subzones[side].spawnset, level.zone.subzones[side].fallbackspawnset, 2);
    }

    spawnset = level.zone.subzones[side].spawnset;
  }

  if(!function_3a586a582f9648ca(spawnpoint)) {
    if(!isDefined(spawnpoint.damagemod)) {
      spawnpoint.damagemod = -1;
    }

    scripts\mp\utility\script::demoforcesre("Invalid Spawn Point: " + spawnpoint.classname + " spawn Set: " + spawnset + " index " + spawnpoint.index + " target " + spawnpoint.target + " CritFail: " + spawnpoint.damagemod);
    newspawnpointsarray = level.spawnglobals.spawnsets[spawnset];
    spawnpoint = function_4ad0a56a9bd6a714(newspawnpointsarray);
  }

  return spawnpoint;
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");
  function_708eab29b3ad59d9(self);
  self.var_ea02a8bfcfde7c4b = 1;
  self.var_7fd12290e298a95b = 0;
  self.var_d24048ab5fb37690 = undefined;
  function_a2d9ea22cacea5e9(1);

  if(isDefined(self.slidemodel)) {
    self.slidemodel delete();
    self.slidemodel = undefined;
  }

  if(!istrue(level.testtdmanywhere)) {
    return;
  }

  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

function logplayermatchstart(player, postgame) {
  player dlog_recordplayerevent("dlog_event_wm_player_match_start", ["team", player.sessionteam, "axis_team_count", scripts\mp\utility\teams::getteamdata("axis", "teamCount"), "allies_team_count", scripts\mp\utility\teams::getteamdata("allies", "teamCount"), "round", ter_op(!istrue(postgame), game["roundsPlayed"] + 1, -1), "match_time", gettime(), "current_objective", level.zone.objectivetype, "map", getmapname(), "name", player.name, "skill", player getskill(), "party_id", player getpartyid(), "playlist_id", ter_op(matchmakinggame(), getplaylistid(), 0), "is_hardcore", scripts\cp_mp\utility\game_utility::function_21322da268e71c19(), "kills", player getpersstat("kills"), "deaths", player getpersstat("deaths"), "score", player getpersstat("score")]);
}

function onplayerconnect(player) {
  if(game["state"] == "postgame" && scripts\mp\utility\game::matchmakinggame()) {
    if(game["switchedsides"]) {
      player function_4ad04da1c6ca78();
    }

    player thread scripts\mp\menus::addtoteam(player.sessionteam);
    logplayermatchstart(player, 1);
    return;
  }

  player waittill("spawned_player");
  scripts\mp\gametypes\wm_ui::function_353ca278babb871e(player);
  logplayermatchstart(player);
}

function onplayerdisconnect(player) {
  if(isDefined(game["cachedTeam"]) && isDefined(game["cachedTeam"][player.guid])) {
    game["cachedTeam"][player.guid] = undefined;
    player.pers["secondHalfInitialConnect"] = 0;
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  if(isDefined(level.wmonplayerkilled)) {
    self[[level.wmonplayerkilled]]();
  }

  if(!isPlayer(attacker) || attacker == self || attacker.team == self.team) {
    return;
  }

  if(isDefined(objweapon) && scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename)) {
    return;
  }

  if(!isDefined(level.zone) || !isDefined(level.zone.objective) || !isDefined(level.zone.objective.objectivetype)) {
    return;
  }

  victim = self;
  ownerteam = undefined;
  attackertouching = 0;
  victimtouching = 0;

  if(isDefined(level.zone.capture_zones)) {
    foreach(capture_zone in level.zone.capture_zones) {
      ownerteam = capture_zone.ownerteam;

      if(!isDefined(ownerteam)) {
        continue;
      }

      attackertouching = attacker istouching(capture_zone.trigger);
      victimtouching = victim istouching(capture_zone.trigger);

      if(attackertouching || victimtouching) {
        break;
      }
    }
  } else if(level.zone.objective.objectivetype == 6) {
    if(!isDefined(level.escortvehicles)) {
      return;
    }

    ownerteam = game["defenders"];

    foreach(vehicle in level.escortvehicles) {
      if(!isDefined(vehicle.tanknearbyrange)) {
        continue;
      }

      rangesq = squared(vehicle.tanknearbyrange);
      attackertouching = distancesquared(attacker.origin, vehicle.origin) <= rangesq;
      victimtouching = distancesquared(victim.origin, vehicle.origin) <= rangesq;

      if(attackertouching || victimtouching) {
        break;
      }
    }
  } else if(level.zone.objective.objectivetype == 11) {
    if(!isDefined(level.escortvehicles)) {
      return;
    }

    ownerteam = game["defenders"];

    if(isDefined(level.zone.var_ef87618c979077d1)) {
      capture_zone = level.zone.var_ef87618c979077d1;
      attackertouching = attacker istouching(capture_zone.trigger);
      victimtouching = victim istouching(capture_zone.trigger);
    } else {
      vehicle = level.escortvehicles[0];

      if(isDefined(vehicle.tanknearbyrange)) {
        rangesq = squared(vehicle.tanknearbyrange);
        attackertouching = distancesquared(attacker.origin, vehicle.origin) <= rangesq;
        victimtouching = distancesquared(victim.origin, vehicle.origin) <= rangesq;
      }
    }
  } else if(level.zone.objective.objectivetype == 12) {
    ownerteam = game["defenders"];
    capture_zone = level.zone.flag_capture_zone;

    if(isDefined(victim.carryingflag)) {
      victimtouching = 1;
    } else if(isDefined(attacker.carryingflag)) {
      attackertouching = 1;
    } else if(isDefined(capture_zone) && capture_zone.trigger istriggerenabled()) {
      attackertouching = attacker istouching(capture_zone.trigger);
      victimtouching = victim istouching(capture_zone.trigger);
    }
  } else {
    return;
  }

  if(!isDefined(ownerteam) || !attackertouching && !victimtouching) {
    return;
  }

  if(attacker.team != ownerteam) {
    if(attackertouching) {
      attacker thread scripts\mp\utility\points::function_e3e3e81453fd788b(#"capture_kill");
    } else if(victimtouching) {
      attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
      attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
      thread utility::trycall(level.matchdata_logvictimkillevent, killid, "defending");
    }

    return;
  }

  attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
  attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
  attacker scripts\mp\utility\stats::incpersstat("defends", 1);
  attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
  attacker scripts\mp\utility\stats::setextrascore1(attacker.pers["defends"]);
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
    println("<dev string:xb4>" + scriptspawnpoint.index + "<dev string:xcf>" + scriptspawnpoint.totalscore);

    if(scriptspawnpoint.index == spawnpoint.index) {
      level.var_2dc7108159dc1da3++;
      iprintlnbold("<dev string:xe5>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:x104>" + "<dev string:x112>" + level.var_2dc7108159dc1da3 + "<dev string:x117>" + level.var_3d292942d52b104a);
    } else {
      level.var_a065445ba781ddf6++;
      iprintlnbold("<dev string:x11c>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:x104>" + "<dev string:x112>" + level.var_2dc7108159dc1da3 + "<dev string:x117>" + level.var_3d292942d52b104a);
    }

    return scriptspawnpoint;
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

function function_8469a5927d069db7() {
  self endon("<dev string:x14c>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      points = getdvarint(@ "hash_46a6b424af6acbc2");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x15a>", points, 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      points = getdvarint(@ "hash_86e14326e43c0115");

      if(points == -1) {
        points = getdvarint(@ "scr_war_scorelimit") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x164>", points, 0);
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
  ents = getEntArray("<dev string:x16c>", "<dev string:x17a>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  ents = getEntArray("<dev string:x18f>", "<dev string:x17a>");

  foreach(ent in ents) {
    thread scripts\mp\utility\debug::drawsphere(ent.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x16c>", "<dev string:x17a>");

  foreach(struct in structs) {
    thread scripts\mp\utility\debug::drawsphere(struct.origin, 64, 1000, (0, 1, 0));
  }

  structs = getStructArray("<dev string:x18f>", "<dev string:x17a>");

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

function shouldgamelobbyremainintact() {
  axisscore = int(game["teamScores"]["axis"]);
  alliesscore = int(game["teamScores"]["allies"]);
  differential = axisscore - alliesscore;
  return differential < 10;
}

function seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.icondefending = "waypoint_defending";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level.iconclearing = "waypoint_clearing";
  level.var_a58e0495b821276 = "waypoint_reinforcing";
}

function function_7c1a5a9812c74071() {
  game["cachedTeam"] = [];

  foreach(player in level.players) {
    if(!isDefined(player) || !isDefined(player.team) || !scripts\mp\utility\teams::isgameplayteam(player.team)) {
      continue;
    }

    player.pers["secondHalfInitialConnect"] = 1;

    if(player.team == game["attackers"]) {
      game["cachedTeam"][player.guid] = game["defenders"];
      continue;
    }

    game["cachedTeam"][player.guid] = game["attackers"];
  }
}

function wmroundend(winnerteam, loserteam) {
  level callback::callback("on_wm_round_end");
  scripts\mp\gamescore::_setteamscore(winnerteam, 1);
  scripts\mp\gamescore::_setteamscore(loserteam, 0);
  scripts\mp\utility\points::function_2a66e9acc30896c(winnerteam, #"hash_75be82d8806d82e7");
  scripts\mp\utility\points::function_2a66e9acc30896c(loserteam, #"hash_d81fed35af5b5ed2");

  if(scripts\mp\utility\game::matchmakinggame()) {
    setnojiptime(1, 1);
    level.nojip = 1;

    if(waslastround()) {
      canceljoins();
    }
  }

  foreach(player in level.players) {
    resetafk(player);
  }
}

function function_4ad04da1c6ca78() {
  assert(game["<dev string:x1a5>"]);
  isprematch = !gameflagexists("prematch_done") || !gameflag("prematch_done");
  teamtofill = getotherteam(self.sessionteam)[0];
  attackercount = 0;
  defendercount = 0;

  if(isprematch) {
    foreach(team in game["cachedTeam"]) {
      if(!isDefined(team)) {
        continue;
      }

      if(team == game["attackers"]) {
        attackercount++;
        continue;
      }

      defendercount++;
    }
  } else {
    attackercount = scripts\mp\utility\teams::getteamdata(game["attackers"], "teamCount");
    defendercount = scripts\mp\utility\teams::getteamdata(game["defenders"], "teamCount");
  }

  if(attackercount > defendercount) {
    teamtofill = game["defenders"];
  } else if(attackercount < defendercount) {
    teamtofill = game["attackers"];
  }

  if(teamtofill != self.sessionteam) {
    function_5d197aea61131f9d(self, teamtofill);
  }

  game["cachedTeam"][self.guid] = teamtofill;
  logstring("WMForceTeamAssignmentOverride:\nisPrematch:" + isprematch + "\nattackers:" + attackercount + "\ndefenders:" + defendercount + "\nguid:" + self.guid + "\nteamToFill:" + teamtofill);
  return teamtofill;
}

function function_5d197aea61131f9d(player, team) {
  setDvar(@ "online_allowteamchange", 1);
  logstring("[War Mode] re-assign player team:" + "\nprevious team:" + player.sessionteam + "\nnew team:" + team + "\nplayer guid:" + player.guid);
  player scripts\mp\menus::setsessionteam(team);
  setDvar(@ "online_allowteamchange", 0);
}

function resetafk(player) {
  player scripts\mp\playerlogic::playerhasmoved();
  player.pers["distTrackingPassed"] = 0;
}

function function_9196e05712b31624() {
  wmroundend(game["attackers"], game["defenders"]);
  thread scripts\mp\gamelogic::endgame(game["attackers"], game["end_reason"]["score_limit_reached"]);
}

function function_77b9d11c06b1fd84() {
  wmroundend(game["defenders"], game["attackers"]);
  thread scripts\mp\gamelogic::endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
}

function function_ca18dc1a088a7245(timeleft, atkdialog, defdialog) {
  if(!isDefined(level.var_2ba88f27b3d43c02)) {
    level.var_2ba88f27b3d43c02 = [];
    level.var_d50739af5c160f54 = 1;
  }

  level.var_2ba88f27b3d43c02[timeleft] = [atkdialog, defdialog];
}

function function_38f25a9137cdbd52() {
  level endon("game_ended");
  level notify("stop_ending_soon_leader_dialog");
  level endon("stop_ending_soon_leader_dialog");
  clockobject = spawn("script_origin", (0, 0, 0));
  clockobject hide();
  var_9b8d8044ae6c26bf = [];
  var_e68e1d7ef2e2ffec = [];

  foreach(key, value in level.var_2ba88f27b3d43c02) {
    var_9b8d8044ae6c26bf[var_9b8d8044ae6c26bf.size] = key;
    var_e68e1d7ef2e2ffec[var_e68e1d7ef2e2ffec.size] = value;
  }

  var_1f91de433313a27f = 0;

  while(true) {
    timeleft = gettimeremaining() / 1000;
    timeleftint = int(timeleft + 0.5);

    if(var_1f91de433313a27f < var_9b8d8044ae6c26bf.size && timeleftint == var_9b8d8044ae6c26bf[var_1f91de433313a27f]) {
      var_4ee3929839847059 = var_e68e1d7ef2e2ffec[var_1f91de433313a27f][0];
      var_96ca919c7ea4fd25 = var_e68e1d7ef2e2ffec[var_1f91de433313a27f][1];

      if(isDefined(var_4ee3929839847059)) {
        leaderdialog(var_4ee3929839847059, game["attackers"]);
      }

      if(isDefined(var_96ca919c7ea4fd25)) {
        leaderdialog(var_96ca919c7ea4fd25, game["defenders"]);
      }

      var_1f91de433313a27f++;
    }

    if(timeleftint <= 10) {
      var_3e3368aa252685c2 = 1;

      if(timeleftint == 0) {
        break;
      }

      if(var_3e3368aa252685c2) {
        clocksoundalias = getclocksoundaliasfortimeleft(timeleft);
        clockobject playSound(clocksoundalias);
      }
    }

    if(timeleft - floor(timeleft) >= 0.05) {
      wait timeleft - floor(timeleft);
      continue;
    }

    wait 1;
  }
}

function function_95463f80d99928e4() {
  mapname = getmapname();
  var_a02abbeb72b0bec1 = getdvarint(@ "hash_89587b7750429c67", 1);

  if(var_a02abbeb72b0bec1 == 2) {
    mapname = "mp_jup_airstrip";
  }

  if(mapname == "mp_jup_launchfacility") {
    var_20ee2c907dd89357 = "dx_mp_mwm1_mode_t141_obin";
    var_9016b7d396ffbdbb = "dx_mp_mwm1_mode_spet_obid";
    game["dialog"]["offense_infil"] = "dx_mp_mwm1_mode_t141_inat";
    game["dialog"]["defense_infil"] = "dx_mp_mwm1_mode_spet_inde";
  }

  if(mapname == "mp_jup_skydiving") {
    var_20ee2c907dd89357 = "dx_mp_skyd_game_seal_obin";
    var_9016b7d396ffbdbb = "dx_mp_skyd_game_spet_obid";
    game["dialog"]["offense_infil"] = "dx_mp_skyd_game_seal_inaa";
    game["dialog"]["defense_infil"] = "dx_mp_skyd_game_spet_inde";
  }

  if(mapname == "mp_jup_dam") {}

  if(mapname == "mp_jup_airstrip") {}

  if(mapname == "mp_jup_gw_fallout" || mapname == "mp_jup_gw_fallout") {}

  game["dialog"]["offense_obj"] = var_20ee2c907dd89357;
  game["dialog"]["defense_obj"] = var_9016b7d396ffbdbb;
}

function function_7cb090fdef81777d() {
  return getdvarint(@ "hash_82f6efcd31660d79", 1);
}

function function_b4f31afe7ce91484(zonename, rounds) {
  return game["wm_objective_complete_time_round_" + rounds][zonename];
}

function sdhack() {}

function function_fc402cde7f63185() {
  if(self.team == game["attackers"]) {
    thread leaderdialogonplayers(level.var_c99eed54a2e150c7, [self]);
    return;
  }

  thread leaderdialogonplayers(level.var_e7cbc43f8f9aa5d3, [self]);
}

function function_864a61284fa3b80e() {
  precachestring(&"MP_INGAME_ONLY/OBJ_DEPLOY_CAPS");
  precachestring(&"MP_INGAME_ONLY/OBJ_PDS_CAPS");
  precachestring(&"MP_JUP_WM/CAN_NOT_MANUAL_DROP");
}

function function_359ad11d5cba23a(volumes) {
  if(!isDefined(self.oobtimelimit)) {
    self.oobtimelimit = 3;
    self.var_7fd12290e298a95b = 0;
    self.var_998a126afff171c3 = gettime();
  }

  foreach(volume in volumes) {
    if(function_f2d4f3c601ebc8aa(volume)) {
      if(!istrue(self.var_7fd12290e298a95b)) {
        self.oobstarttime = gettime();
        oobinterval = self.oobstarttime - self.var_998a126afff171c3;

        if(oobinterval > 5000) {
          self.oobtimelimit = 3;
        }
      }

      function_1955884947b9708f(volume);
    }
  }
}

function function_f2d4f3c601ebc8aa(volume) {
  if(!isDefined(self.owner) || !isPlayer(self.owner)) {
    return false;
  }

  if(istrue(self.var_7fd12290e298a95b)) {
    return false;
  }

  if(!self istouching(volume)) {
    return false;
  }

  if(!self.owner function_4e5c4b0545465079(volume)) {
    return false;
  }

  return true;
}

function function_1955884947b9708f(volume) {
  self.oob = 1;
  self.oobtype = 1;
  self.oobendtime = gettime() + self.oobtimelimit * 1000;
  self.var_7fd12290e298a95b = 1;
  function_736005736220cad7(self.oobtimelimit);
  thread function_6e066fa0b0311456(volume);

  if(istrue(self.var_7fd12290e298a95b)) {
    thread function_f59b23672547c2c4(self.oobtimelimit);
  }
}

function function_4a25b2929a443146() {
  self.oob = 0;
  self.oobtype = 0;
  self.var_7fd12290e298a95b = 0;
  self.var_998a126afff171c3 = gettime();

  if(isDefined(self.oobtimelimit) && isDefined(self.oobstarttime)) {
    self.oobtimelimit = int(self.oobtimelimit - (self.var_998a126afff171c3 - self.oobstarttime) / 1000);
  }

  self notify("recon_drone_left_wmOOB");
}

function function_f59b23672547c2c4(time) {
  self endon("recon_drone_left_wmOOB");
  self endon("death");

  if(time > 0) {
    wait time;
  }

  self.var_7fd12290e298a95b = 0;
  scripts\mp\outofbounds::onooboutoftime(self);
}

function function_6e066fa0b0311456(volume) {
  self endon("death");

  while(self istouching(volume)) {
    waitframe();
  }

  if(istrue(self.var_7fd12290e298a95b)) {
    function_4a25b2929a443146();
  }
}

function function_736005736220cad7(oob_time) {
  if(!isDefined(self.owner) || !isPlayer(self.owner) || istrue(self.owner.var_7fd12290e298a95b)) {
    return;
  }

  self.owner scripts\mp\gametypes\wm_ui::function_557efb699f50447b(oob_time);
  self.owner thread function_86f0acfd937bcc04(self);
}

function function_86f0acfd937bcc04(recon_drone) {
  self endon("death");
  recon_drone waittill_any_2("death", "recon_drone_left_wmOOB");
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function function_df0789ad547dd895() {
  while(true) {
    dvar = getdvarint(@ "hash_a77639f0906e8bdf", 0);

    if(dvar) {
      setDvar(@ "hash_a77639f0906e8bdf", 0);

      foreach(objective in level.zone.objectives) {
        level.objectives[objective].complete = 1;
        level.objectives[objective] scripts\mp\gameobjects::setvisibleteam("<dev string:x6c>");

        if(level.objectives[objective].objectivetype == 1) {
          level.objectives[objective] scripts\mp\gameobjects::allowuse("<dev string:x6c>");
        }
      }

      level notify("<dev string:x1b6>", level.zone.name);
    }

    if(isDefined(level.objectives) && level.objectives.size > 0) {
      level.var_29f22700ecf12d4c = [];

      foreach(objective in level.objectives) {
        level.var_29f22700ecf12d4c[level.var_29f22700ecf12d4c.size] = objective.objidnum;
      }
    }

    waitframe();
  }
}

function function_1f629022819f6f39() {
  while(true) {
    if(getdvarint(@ "hash_e2e0ee7a45b666be", 0) == 1) {
      function_9196e05712b31624();
      setdevdvar(@ "hash_e2e0ee7a45b666be", 0);
    } else if(getdvarint(@ "hash_f1bccd20e99da02a", 0) == 1) {
      function_77b9d11c06b1fd84();
      setdevdvar(@ "hash_f1bccd20e99da02a", 0);
    }

    wait 1;
  }
}

# /