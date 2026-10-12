/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\grnd.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\airdrop_multiple;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\grnd;
#using scripts\mp\gametypes\koth;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\persistence;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace grnd;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  allowed[1] = "dz_flare";
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 600);
    registerscorelimitdvar(getgametype(), 7500);
    registerroundlimitdvar(getgametype(), 1);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.getspawnpoint = &getspawnpoint;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerkilled = &scripts\mp\gametypes\koth::onplayerkilled;
  level.onrespawndelay = &scripts\mp\gametypes\koth::getrespawndelay;
  level.nosuspensemusic = 1;

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    game["dialog"]["gametype"] = "dx_mp_drop_game_uktl_dzt1";
  } else {
    game["dialog"]["gametype"] = "dx_mp_drop_game_uktl_dznm";
  }

  game["dialog"]["offense_obj"] = "dx_mp_drop_game_uktl_dzbo";
  game["dialog"]["defense_obj"] = "dx_mp_drop_game_uktl_dzbo";
  game["dialog"]["hp_new_location"] = "dx_mp_drop_game_uktl_dznl";
  game["dialog"]["hp_captured_enemy"] = "dx_mp_drop_game_uktl_dzcb";
  game["dialog"]["hp_captured_friendly"] = "dx_mp_drop_game_uktl_dzca";
  game["dialog"]["hp_contested"] = "dx_mp_drop_game_uktl_dzcn";
  game["dialog"]["hp_move_soon"] = "dx_mp_drop_game_uktl_dzms";
  game["dialog"]["hp_capturing_enemy"] = "dx_mp_drop_game_uktl_dzcd";
  game["dialog"]["hp_capturing_friendly"] = "dx_mp_drop_game_uktl_dzcc";
  setomnvar("ui_hq_status", -1);
  setomnvar("ui_hq_num_alive", 0);
  setomnvar("ui_hq_ownerteam", -1);
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_5ba53b16e2b96ecd", getmatchrulesdata("grndData", "dropTime"));
  setdynamicdvar(@ "hash_b19899b52321b991", getmatchrulesdata("grndData", "enableVariantDZ"));
  setdynamicdvar(@ "hash_e394adcc9f5c4ddc", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar(@ "hash_8d0b337fd3d7011e", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar(@ "hash_25ad50e5cdfaf602", getmatchrulesdata("kothData", "firstZoneActivationDelay"));
  setdynamicdvar(@ "hash_bbf8317503ce49c6", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar(@ "hash_6495e30f8aa00d93", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar(@ "hash_518afd934bd7f3ce", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar(@ "hash_c6311ea83485b20c", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar(@ "hash_4aab4c2d3976a925", 0);
  registerhalftimedvar("grnd", 0);
  setdynamicdvar(@ "hash_796f6d676d387bcb", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/GRND");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/GRND");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/GRND_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/DOM_HINT");
  }

  level thread setupzones();
  setmapsizespawnconsts();
  initspawns();
  level thread dzmainloop();

  if(level.droptime > 0) {
    level thread randomdrops();
  }
}

function updategametypedvars() {
  updatecommongametypedvars();
  level.droptime = dvarfloatvalue("dropTime", 15, 0, 60);
  level.zoneduration = dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.firstzoneactivationdelay = dvarfloatvalue("firstZoneActivationDelay", 30, 0, 120);
  level.zoneactivationdelay = dvarfloatvalue("zoneActivationDelay", 30, 0, 120);
  level.zonerandomlocationorder = dvarintvalue("randomLocationOrder", 0, 0, 1);
  level.zoneadditivescoring = dvarintvalue("additiveScoring", 0, 0, 1);
  level.pausemodetimer = dvarintvalue("pauseTime", 1, 0, 1);
  level.enablevariantdrops = dvarintvalue("enableVariantDZ", 0, 0, 1);

  if(matchmakinggame() && !isanymlgmatch() && getdvarint(@ "hash_56937a1bd450393d", 15) != 0) {
    level.zoneactivationdelay = adjustzoneactivationdelayforlargemaps();
  }
}

function adjustzoneactivationdelayforlargemaps() {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case #"hash_62c07791a2eda185":
    case #"hash_f09747c9feb47eb1":
    case #"hash_fcab5810ee4c6dc2":
      return getdvarint(@ "hash_56937a1bd450393d", 15);
    case #"hash_a8b272dba33a4aed":
      return (getdvarint(@ "hash_56937a1bd450393d", 15) + 15);
    default:
      return level.zoneactivationdelay;
  }
}

function setmapsizespawnconsts() {
  level.spawn_deadzone_dist = 1000;
  level.close_spawn_min_dist_sq = 10000;
  level.max_spawn_dist_sq = 25000000;
  level.enemy_spawn_influence_dist_sq = 12250000;
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default", 1);
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
  scripts\mp\spawnlogic::registerspawnset("normal", "mp_tdm_spawn");
  scripts\mp\spawnlogic::registerspawnset("fallback", "mp_tdm_spawn_secondary");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  enablespawnpointsbyclassname("mp_tdm_spawn");
  level.spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

  if(!level.spawnpoints.size) {
    assertmsg("<dev string:x1c>");
    return;
  }

  foreach(zone in level.objectives) {
    zone.furthestspawndistsq = 0;
    zone.spawnpoints = [];
    zone.fallbackspawnpoints = [];
  }

  foreach(spawnpoint in level.spawnpoints) {
    obj_zonecapture::calculatespawndisttozones(spawnpoint, 6000);
    originstring = scripts\mp\spawnlogic::getoriginidentifierstring(spawnpoint);

    if(isDefined(level.grndextraprimaryspawnpoints) && isDefined(level.grndextraprimaryspawnpoints[originstring])) {
      foreach(zoneindex in level.grndextraprimaryspawnpoints[originstring]) {
        zone = level.objectives[zoneindex];
        zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
      }
    }

    var_ba992cb19cb03b0c = 0;
    isstartspawn = spawnpoint.classname == "mp_tdm_spawn_allies_start" || spawnpoint.classname == "mp_tdm_spawn_axis_start";
    var_9967fe9b58eefafd = spawnpoint.classname == "mp_tdm_spawn";
    var_a46d96b282d563e7 = spawnpoint.classname == "mp_tdm_spawn_secondary";

    if(isstartspawn) {
      continue;
    }

    if(var_9967fe9b58eefafd || var_a46d96b282d563e7) {
      if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "") {
        var_ba992cb19cb03b0c = 1;
        zoneindicies = strtok(spawnpoint.script_noteworthy, " ");

        foreach(zoneindex in zoneindicies) {
          zone = level.objectives[zoneindex];

          if(var_9967fe9b58eefafd) {
            zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
            continue;
          }

          assertex(var_a46d96b282d563e7, "<dev string:x47>");
          zone.fallbackspawnpoints[zone.fallbackspawnpoints.size] = spawnpoint;
        }
      }
    }

    obj_zonecapture::calculatespawndisttozones(spawnpoint, 6000);

    if(!var_ba992cb19cb03b0c) {
      foreach(zone in level.objectives) {
        if(spawnpoint.scriptdata.var_c7e3d9e2f0dd4e7[zone.trigger getentitynumber()] < level.close_spawn_min_dist_sq || spawnpoint.scriptdata.var_c7e3d9e2f0dd4e7[zone.trigger getentitynumber()] > level.max_spawn_dist_sq) {
          spawnpoint.removespawn = 1;
        }

        if(var_9967fe9b58eefafd) {
          if(!isDefined(spawnpoint.removespawn)) {
            zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
          }
        } else {
          assert(var_a46d96b282d563e7);
          zone.fallbackspawnpoints[zone.fallbackspawnpoints.size] = spawnpoint;
        }

        spawnpoint.removespawn = undefined;
      }
    }
  }

  foreach(objid, zone in level.objectives) {
    assertex(zone.spawnpoints.size > 0, "<dev string:x91>" + objid + "<dev string:xaa>");
    zone.spawnset = "dropzone_" + objid;
    scripts\mp\spawnlogic::registerspawnset(zone.spawnset, zone.spawnpoints);
    zone.fallbackspawnset = "dropzone_fallback_" + objid;
    scripts\mp\spawnlogic::registerspawnset(zone.fallbackspawnset, zone.fallbackspawnpoints);
  }
}

function comparezoneindexes(zone_a, zone_b) {
  script_index_a = int(zone_a.objectivekey);
  script_index_b = int(zone_b.objectivekey);

  if(!isDefined(script_index_a) && !isDefined(script_index_b)) {
    println("<dev string:xce>" + zone_a.origin + "<dev string:xfe>" + zone_b.origin);
    return false;
  }

  if(!isDefined(script_index_a) && isDefined(script_index_b)) {
    println("<dev string:xce>" + zone_a.origin);
    return true;
  }

  if(isDefined(script_index_a) && !isDefined(script_index_b)) {
    println("<dev string:xce>" + zone_b.origin);
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
  trigs = getzonearray("grnd");

  if(level.mapname == "mp_piccadilly") {
    foreach(trig in trigs) {
      if(distance(trig.origin, (-1547, -1512, 165)) < 10) {
        trig.origin -= (0, 0, 10);
      }
    }
  } else if(level.mapname == "mp_aniyah") {
    foreach(trig in trigs) {
      if(distance(trig.origin, (-1117, 2295, 398)) < 10) {
        trig.origin -= (0, 0, 10);
        continue;
      }

      if(distance(trig.origin, (-4501, -2, 322)) < 10) {
        trig.script_label = "9";
        continue;
      }

      if(distance(trig.origin, (-4474, 1159, 388)) < 10) {
        trig.origin -= (0, 0, 20);
      }
    }
  }

  assert(isDefined(trigs.size > 3));
  maperrors = [];
  flares = getStructArray("dz_flare", "targetname");

  if(level.mapname == "mp_shipment") {
    removetrigs = [];

    foreach(trig in trigs) {
      if(trig.script_label == "1" && distance(trig.origin, (-333, 1999, 119)) < 5) {
        removetrigs[removetrigs.size] = trig;
        continue;
      }

      if(trig.script_label == "2" && distance(trig.origin, (189, 1564, 75)) < 5) {
        removetrigs[removetrigs.size] = trig;
        continue;
      }

      if(trig.script_label == "3" && distance(trig.origin, (-751, 2416, 81)) < 5) {
        removetrigs[removetrigs.size] = trig;
        continue;
      }

      if(trig.script_label == "4" && distance(trig.origin, (165, 2420, 79)) < 5) {
        removetrigs[removetrigs.size] = trig;
        continue;
      }

      if(trig.script_label == "5" && distance(trig.origin, (-823, 1536, 68)) < 5) {
        removetrigs[removetrigs.size] = trig;
      }
    }

    trigs = array_remove_array(trigs, removetrigs);
    removeflares = [];

    foreach(flare in flares) {
      if(distance(flare.origin, (192.944, 1583.51, 16.344)) < 5) {
        removeflares[removeflares.size] = flare;
        continue;
      }

      if(distance(flare.origin, (-743.056, 2447.51, 17.844)) < 5) {
        removeflares[removeflares.size] = flare;
        continue;
      }

      if(distance(flare.origin, (152.944, 2415.51, 16.344)) < 5) {
        removeflares[removeflares.size] = flare;
        continue;
      }

      if(distance(flare.origin, (-334.5, 1990.5, 17.25)) < 5) {
        removeflares[removeflares.size] = flare;
        continue;
      }

      if(distance(flare.origin, (-751.056, 1479.51, 16.844)) < 5) {
        removeflares[removeflares.size] = flare;
      }
    }

    flares = array_remove_array(flares, removeflares);
  } else if(level.mapname == "mp_catedral") {
    replacementtrigs = [];

    foreach(trig in trigs) {
      groundpos = drop_to_ground(trig.origin, 100);
      radius = 128;
      crateradius = undefined;

      switch (trig.script_label) {
        case #"hash_31100fbc01bd387c":
          radius = 210;
          break;
        case #"hash_311012bc01bd3d35":
          radius = 295;
          break;
        case #"hash_311011bc01bd3ba2":
          radius = 225;
          break;
        case #"hash_31100cbc01bd33c3":
          radius = 200;
          crateradius = 100;
          break;
        case #"hash_31100bbc01bd3230":
          radius = 345;
          break;
      }

      newtrig = spawn("trigger_radius", groundpos, 0, radius, 128);
      newtrig.script_label = trig.script_label;
      newtrig.script_gameobjectname = trig.script_gameobjectname;
      newtrig.targetname = trig.targetname;
      newtrig.crateradius = ter_op(isDefined(crateradius), crateradius, radius);
      replacementtrigs[replacementtrigs.size] = newtrig;
    }

    trigs = replacementtrigs;
  } else if(level.mapname == "mp_crossing") {
    replacementtrigs = [];

    foreach(trig in trigs) {
      groundpos = drop_to_ground(trig.origin, 100);
      radius = 128;
      crateradius = undefined;

      switch (trig.script_label) {
        case #"hash_31100fbc01bd387c":
          radius = 215;
          break;
        case #"hash_311012bc01bd3d35":
          radius = 190;
          break;
        case #"hash_311011bc01bd3ba2":
          radius = 350;
          break;
        case #"hash_31100cbc01bd33c3":
          radius = 350;
          break;
        case #"hash_31100bbc01bd3230":
          radius = 350;
          break;
      }

      newtrig = spawn("trigger_radius", groundpos, 0, radius, 128);
      newtrig.script_label = trig.script_label;
      newtrig.script_gameobjectname = trig.script_gameobjectname;
      newtrig.targetname = trig.targetname;
      newtrig.crateradius = ter_op(isDefined(crateradius), crateradius, radius);
      replacementtrigs[replacementtrigs.size] = newtrig;
    }

    trigs = replacementtrigs;
  }

  foreach(flare in flares) {
    groundpos = drop_to_ground(flare.origin, 100) + (0, 0, 1.25);
    scriptable = spawn("script_model", groundpos);
    scriptable.angles = flare.angles;
    scriptable setModel("dz_flare_scriptable");
    flare.scriptable = scriptable;
  }

  visuals = [];
  level.objectives = [];

  for(i = 0; i < flares.size; i++) {
    errored = 0;
    flare = flares[i];
    trig = undefined;

    for(j = 0; j < trigs.size; j++) {
      if(flare.scriptable istouching(trigs[j])) {
        if(isDefined(trig)) {
          maperrors[maperrors.size] = "flare at " + flare.origin + " is touching more than one \"flaretrigger\" trigger";
          errored = 1;
          break;
        }

        trig = trigs[j];
        break;
      }
    }

    if(!isDefined(trig)) {
      if(!errored) {
        maperrors[maperrors.size] = "flare at " + flare.origin + " is not inside any \"flaretrigger\" trigger";
        continue;
      }
    }

    assert(!errored);
    visuals = [];
    visuals[0] = flare.scriptable;
    zone = scripts\mp\gametypes\obj_zonecapture::setupobjective(trig, visuals);
    zone.origin = trig.origin;
    zone.offset3d = (0, 0, 120);
    level.objectives[zone.objectivekey] = zone;
  }

  if(maperrors.size > 0) {
    println("<dev string:x103>");

    for(i = 0; i < maperrors.size; i++) {
      println(maperrors[i]);
    }

    println("<dev string:x12d>");

    assertmsg("<dev string:x157>");
    return;
  }

  return 1;
}

function dzmainloop() {
  level endon("game_ended");
  seticonnames();
  initwaypointicons();
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  level.zone = getfirstzone();
  firstzone = 1;
  level.kothhillrotation = 0;

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
  setomnvar("ui_objective_timer_stopped", 0);
  var_570ba02607c0425c = 0;

  if(level.firstzoneactivationdelay) {
    var_570ba02607c0425c = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 6);
    level.zoneislocked = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "dz_control", "dz_control");
    level.zone thread scripts\mp\gameobjects::function_d36dcacac1708708(level.firstzoneactivationdelay);
    wait level.firstzoneactivationdelay;
    level.zoneislocked = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "dz_capture", "dz_capture");
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_obj_new");

  while(true) {
    level.zone.visuals[0] setscriptablepartstate("smoke", "idle", 0);
    level.objectivesetorder = 1;
    waittillframeend();
    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled) {
      level.zone thread scripts\mp\gametypes\obj_zonecapture::trackgametypevips();
    }

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(var_570ba02607c0425c, firstzone);
    firstzone = 0;
    var_570ba02607c0425c = 0;
    setomnvar("ui_hq_status", 8);
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();

    if(level.pausemodetimer) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level.lastcaptureteam = undefined;
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
    setomnvar("ui_hq_status", -1);
    spawn_next_zone();

    if(getgametype() == "grnd" && level.kothhillrotation == 4) {}

    setomnvar("ui_hq_status", -1);
    wait 1;
  }
}

function getfirstzone() {
  if(level.mapname == "mp_hardhat") {
    zone = level.objectives["5"];
    level.prevzoneindex = 5;
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
  level.zone.visuals[0] setscriptablepartstate("smoke", "off", 0);
  level.zone scripts\mp\gametypes\obj_zonecapture::deactivatezone();
  level.zone = getnextzone();
  level.kothhillrotation++;
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

function hqactivatenextzone(var_570ba02607c0425c, firstzone) {
  if(firstzone) {
    foreach(entry in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("obj_generic_capture", entry);
    }
  } else {
    foreach(entry in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("hp_new_location", entry);
    }
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_obj_new");
  level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("none");

  if(istrue(var_570ba02607c0425c)) {} else if(level.zoneactivationdelay) {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("zone_activation_delay", 0);
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 6);
    level.zoneislocked = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "dz_control", "dz_control");
    level.zone thread scripts\mp\gameobjects::function_d36dcacac1708708(level.zoneactivationdelay);
    wait level.zoneactivationdelay;
    level.zoneislocked = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "dz_capture", "dz_capture");
  }

  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  updateservericons("neutral", 0);

  if(level.zoneduration) {
    updateservericons("neutral", 0);
    thread movezoneaftertime(level.zoneduration);
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
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
    level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
    level.zone scripts\mp\gameobjects::cancontestclaim(1);

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime) {
      level thread scripts\mp\gametypes\grnd::randomdrops();
    }

    msg = level waittill_any_return_2("zone_captured", "zone_destroyed");

    if(msg == "zone_destroyed") {
      continue;
    }

    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
    scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_positive", ownerteam);
    scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_negative", getotherteam(ownerteam)[0]);
    thread scripts\mp\music_and_dialog::headquarters_newhq_music();
    thread updaterespawntimer();
    level waittill("zone_destroyed", destroy_team);
    level.spawndelay = undefined;

    if(isDefined(destroy_team)) {
      level.zone scripts\mp\gameobjects::setownerteam(destroy_team);
      continue;
    }

    level.zone scripts\mp\gameobjects::setownerteam("none");
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
    for(waittime = 0; waittime < seconds; waittime = 0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      waittime += level.framedurationseconds;

      if(level.zone.stalemate) {}
    }

    team = level.zone scripts\mp\gameobjects::getownerteam();

    if(team == "neutral") {
      continue;
    }

    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring) {
        score = level.zone.touchlist[team].size;
      }

      scripts\mp\gamescore::giveteamscoreforobjective(team, score, 0);

      foreach(object in level.zone.touchlist[team]) {
        object.player incpersstat("objTime", 1);

        if(isDefined(object.player.timebyrotation[level.kothhillrotation])) {
          object.player.timebyrotation[level.kothhillrotation]++;
        } else {
          object.player.timebyrotation[level.kothhillrotation] = 1;
        }

        object.player scripts\mp\persistence::statsetchild("round", "objTime", object.player.pers["objTime"]);
        object.player setextrascore0(object.player.pers["objTime"]);
        object.player scripts\mp\gamescore::giveplayerscore(#"hash_61e7451e5d97d089", 10);
      }
    }
  }
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
  level notify("zone_moved");
  level notify("zone_destroyed");
}

function give_capture_credit(touchlist, capturetime, capture_team, lastcaptureteam, credit_player) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  first_player = credit_player;

  if(isDefined(first_player.owner)) {
    first_player = first_player.owner;
  }

  if(isPlayer(first_player)) {
    if(!isscoreboosting(first_player)) {
      var_7e2c53b0bcf117d9 = spawnStruct();
      var_7e2c53b0bcf117d9.player = first_player;
      var_7e2c53b0bcf117d9.eventname = "capture";
      var_7e2c53b0bcf117d9.position = first_player.origin;
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
      first_player thread doscoreevent(#"dz_capture");

      if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100) {
        first_player thread scripts\mp\utility\points::doscoreevent(#"hash_4d98aed9e6ebbf28");
      }

      if(first_player.lastkilltime + 500 > gettime()) {} else {
        first_player scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(first_player);
      }
    }
  }

  players = getarraykeys(touchlist);

  for(i = 0; i < players.size; i++) {
    player = touchlist[players[i]].player;
    player updatecapsperminute(lastcaptureteam);

    if(!isscoreboosting(player)) {
      player incpersstat("captures", 1);
      player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    } else {
      player iprintlnbold("<dev string:x170>");
    }

    wait 0.05;
  }
}

function randomdrops() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.grnd_previouscratetypes = [];

  while(true) {
    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
    var_4440147083abaf0a = 1;

    if(isDefined(ownerteam) && ownerteam != "neutral" && currentactivevehiclecount() < maxvehiclesallowed() && level.fauxvehiclecount + var_4440147083abaf0a < maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      cratetype = getdropzonecratetype();
      nodes = [];

      if(isDefined(level.zone.trigger.crateradius)) {
        nodes = getnodesinradius(level.zone.trigger.origin, level.zone.trigger.crateradius, 0);
      } else {
        nodes = getnodesintrigger(level.zone.trigger);
      }

      if(shoulddonodedrop(cratetype) && isDefined(nodes) && nodes.size > 0) {
        nodesnum = randomintrange(0, nodes.size);
        position = nodes[nodesnum];
        droporigin = getclosestpointonnavmesh(position.origin);
        tracestart = position.origin;
        traceend = droporigin;
        contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
        ignoreents = [];
        trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
        position = trace["position"];
      } else {
        position = getdropposition() + (randomintrange(-50, 50), randomintrange(-50, 50), 0);
      }

      if(cratetype == "mega") {
        streakinfo = spawnStruct();
        streakinfo.streakname = "airdrop_multiple";
        streakinfo.cratetype = undefined;
        streakinfo.numcrates = undefined;
        streakinfo.usephysics = undefined;
        scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(undefined, ownerteam, position, randomfloat(360), position, 1, streakinfo);
      } else {
        vehicleisreserved = scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scenenode = scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(undefined, ownerteam, cratetype, position, randomfloat(360), position, vehicleisreserved);

        foreach(crate in scenenode.crates) {
          crate.skipminimapicon = 1;
        }
      }

      waittime = level.droptime;
    } else {
      waittime = 0.5;
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(waittime);
  }
}

function shoulddonodedrop(cratetype) {
  if(cratetype == "mega") {
    return false;
  }

  if(level.mapname == "mp_vacant") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "4") {
      return false;
    }
  } else if(issubstr(level.mapname, "mp_aniyah")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "1") {
      return false;
    }
  } else if(level.mapname == "mp_raid") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "6") {
      return false;
    }
  } else if(level.mapname == "mp_petrograd") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "1") {
      return false;
    }
  } else if(issubstr(level.mapname, "mp_hackney")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "4") {
      return false;
    }
  } else if(issubstr(level.mapname, "mp_shipment")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "1") {
      return false;
    }
  } else if(issubstr(level.mapname, "mp_emporium")) {
    return false;
  } else if(level.mapname == "mp_backlot2") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "5") {
      return false;
    }
  }

  return true;
}

function getdropposition() {
  if(level.mapname == "mp_vacant" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "4") {
    return (1760, 701, 122);
  } else if(level.mapname == "mp_emporium" && isDefined(level.zone.trigger.script_label)) {
    switch (level.zone.trigger.script_label) {
      case #"hash_31100fbc01bd387c":
        return (-732, -136, 608);
      case #"hash_311012bc01bd3d35":
        return (672, -1336, 608);
      case #"hash_311011bc01bd3ba2":
        return (44, 968, 608);
      case #"hash_31100cbc01bd33c3":
        return (-680, -1552, 608);
      case #"hash_31100bbc01bd3230":
        return (832, 4, 608);
    }
  } else if(level.mapname == "mp_backlot2" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "5") {
    return (-346, -2368, 66);
  }

  return level.zone.origin;
}

function getbestplayer() {
  bestplayer = undefined;
  besttime = 0;
  ownerteam = level.zone scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    return bestplayer;
  }

  foreach(object in level.zone.touchlist[ownerteam]) {
    if(besttime == 0 || besttime > object.starttime) {
      besttime = object.starttime;
      bestplayer = object.player;
    }
  }

  return bestplayer;
}

function getspawnpoint() {
  spawnteam = self.pers["team"];
  var_2fa17baefe0fa286 = getobjzonedeadzonedist();
  var_ba0a9fd614a3f6ee = scripts\mp\spawnfactor::function_75c03ed937b75b22(level.zone.visuals[0] getentitynumber(), level.zone.visuals[0].furthestspawndistsq, var_2fa17baefe0fa286 * var_2fa17baefe0fa286, level.enemy_spawn_influence_dist_sq);

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers", undefined, var_ba0a9fd614a3f6ee);
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders", undefined, var_ba0a9fd614a3f6ee);
    }
  } else {
    if(!isDefined(level.switchedtohardpointspawnlogic)) {
      level.switchedtohardpointspawnlogic = 1;

      if(function_bff229a11ecd1e34()) {
        scripts\mp\spawnlogic::setactivespawnlogic(#"objective");
      } else {
        scripts\mp\spawnlogic::setactivespawnlogic("DZ", "Crit_Default");
      }
    }

    spawnpoints = removespawnsinactivedz(level.zone.spawnpoints);
    fallbackspawnpoints = removespawnsinactivedz(level.zone.fallbackspawnpoints);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.zone.spawnset, level.zone.fallbackspawnset, 2, var_ba0a9fd614a3f6ee);
  }

  return spawnpoint;
}

function getobjzonedeadzonedist() {
  return level.spawn_deadzone_dist;
}

function removespawnsinactivedz(spawnpoints) {
  var_d294628716ab60f9 = [];

  if(isDefined(spawnpoints)) {
    foreach(spawnpoint in spawnpoints) {
      if(!ispointinvolume(spawnpoint.origin, level.zone.trigger)) {
        var_d294628716ab60f9[var_d294628716ab60f9.size] = spawnpoint;
      }
    }
  }

  return var_d294628716ab60f9;
}

function onplayerconnect(player) {
  player.numcaps = 0;
  player.capsperminute = 0;
  player.timebyrotation = [];
  player setextrascore0(0);

  if(isDefined(player.pers["objTime"])) {
    player setextrascore0(player.pers["objTime"]);
  }

  player setextrascore1(0);

  if(isDefined(player.pers["defends"])) {
    player setextrascore1(player.pers["defends"]);
  }
}

function onplayerspawned(player) {
  while(true) {
    player waittill("spawned");
  }
}

function onspawnplayer(revivespawn) {
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  thread updatematchstatushintonspawn();
  level.personalnukecostoverride = 30;
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

function seticonnames() {
  level.icontarget = "dz_target";
  level.iconneutral = "dz_neutral";
  level.iconcapture = "dz_enemy";
  level.icondefend = "dz_friendly";
  level.iconcontested = "dz_contested";
  level.icontaking = "dz_taking";
  level.iconlosing = "dz_losing";
  level.icondefending = "dz_defending";
}

function initwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("dz_enemy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_friendly", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dz", 1);
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

function writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("alliesRoundScore", level.kothhillrotation, getteamscore("allies"));
    setmatchdata("axisRoundScore", level.kothhillrotation, getteamscore("axis"));
  }
}

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(istrue(level.zoneislocked)) {
    scripts\mp\hud_message::function_f004ef4606b9efdc("dz_control");
    return;
  }

  scripts\mp\hud_message::function_f004ef4606b9efdc("dz_capture");
}