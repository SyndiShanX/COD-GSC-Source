/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_rewards.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_rewards;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#namespace br_rewards;

function init_br_rewards() {
  processkillstreaksintotiers();
  level.tierrewardcounts = [];
  level.tierrewardcounts[3] = 0;
  level.tierrewardcounts[2] = 0;
  level.tierrewardcounts[1] = 0;
  level.tierrewardcounts[0] = 0;
}

function runmissionrewarddelivery(var_96fb3d33fbd543f9, creditplayer, streakname, streaktier) {
  droplocation = undefined;

  if(!isDefined(var_96fb3d33fbd543f9.rewardlocation)) {
    droplocation = findclosestdroplocation(var_96fb3d33fbd543f9);

    if(!isDefined(droplocation)) {
      droplocation = calculatedroplocationnearlocation(var_96fb3d33fbd543f9, 64, 2048);
    }
  } else {
    droplocation = var_96fb3d33fbd543f9.rewardlocation;
  }

  if(isDefined(streakname)) {
    thread runkillstreakreward(droplocation, creditplayer, streakname);
    return;
  }

  if(isDefined(streaktier)) {
    thread runkillstreakreward(droplocation, creditplayer, getkillstreak(streaktier));
    return;
  }

  thread runkillstreakreward(droplocation, creditplayer, getkillstreak(3));
}

function runkillstreakreward(location, creditplayer, streakname) {
  level endon("game_ended");
  crate = undefined;

  if(!istrue(location.isinside)) {
    offset = 72;
  } else {
    offset = 40;
  }

  object = scripts\mp\gameobjects::createobjidobject(location.origin, "neutral", (0, 0, offset), undefined, "any");
  maskobjectivetoplayerssquad(object, creditplayer);
  object.origin = location.origin;
  object.angles = location.angles;
  thread docratedropsmoke(undefined, location, 16);
  object.iconname = "_incoming";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons(streakname);
  object.lockupdatingicons = 1;
  wait 3;
  wait 1;

  if(!istrue(location.isinside)) {
    crate = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(creditplayer.team, streakname, location.origin, (0, randomint(360), 0), undefined);
    crate.skipminimapicon = 1;
    crate.nevertimeout = 0;
    crate.waitforobjectiveactivate = 1;
    crate.killminimapicon = 0;
    crate.disallowheadiconid = 1;
    crate.isarmcrate = 1;
    crate waittill("crate_dropped");
    object.useobj = crate;
    object.origin = crate.origin;
  } else {
    object.useobj = spawn("script_model", object.origin);
    object.useobj.disallowheadiconid = 1;
    object.useobj.cratetype = "arm_no_owner";
    leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata(object.useobj.cratetype);
    object.useobj.minimapicon = leveldata.minimapicon;
    object.useobj.capturestring = leveldata.capturestring;
    object.useobj.rerollstring = leveldata.rerollstring;
    object.useobj.supportsreroll = leveldata.supportsreroll;
    object.useobj.isdummyarmcrate = 1;
    object.useobj.isarmcrate = 1;
    object.useobj.data = scripts\cp_mp\killstreaks\airdrop::getarmcratedatabystreakname(streakname);
    scripts\mp\objidpoolmanager::update_objective_onentity(object.objidnum, object.useobj);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(object.objidnum, 40);
  }

  currentwait = 0;
  interval = 0.1;

  if(istrue(location.isinside)) {
    waittime = 15;
  } else {
    waittime = 1;
  }

  wait waittime;

  if(!istrue(location.isinside)) {
    crate notify("objective_activate");
    scripts\mp\objidpoolmanager::update_objective_onentity(object.objidnum, crate);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(object.objidnum, 72);
  } else {
    object.useobj scripts\cp_mp\killstreaks\airdrop::makecrateusable();
    leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata(object.useobj.cratetype);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(object.objidnum, 40);
  }

  object.iconname = "";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons(streakname);
  object.lockupdatingicons = 1;
  objective_setlabel(object.objidnum, "");

  if(isDefined(crate)) {
    crate waittill("death");
  } else {
    object.useobj waittill("death");
  }

  object scripts\mp\gameobjects::setvisibleteam("none");
  object scripts\mp\gameobjects::releaseid();
  object.visibleteam = "none";
}

function dropcrate(killstreakname, droplocation, team) {
  crate = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(team, killstreakname, droplocation.origin, (0, randomint(360), 0), undefined);
  return crate;
}

function docratedropsmoke(crate, droplocation, duration) {
  var_e0d03a39e88dff15 = droplocation.origin + (0, 0, 2000);
  spawnpos = utility::groundpos(var_e0d03a39e88dff15, (0, 0, 1));
  droplocation.vfxent = spawn("script_model", spawnpos);
  droplocation.vfxent setModel("tag_origin");
  droplocation.vfxent.angles = (0, 0, 0);
  droplocation.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(getfx("vfx_smk_signal_gr"), droplocation.vfxent, "tag_origin");

  if(isDefined(crate)) {
    crate waittill_any_timeout_1(duration, "crate_dropped");
  } else {
    wait duration;
  }

  stopFXOnTag(getfx("vfx_smk_signal_gr"), droplocation.vfxent, "tag_origin");
  droplocation.vfxent delete();
}

function getkillstreak(tier) {
  if(!isDefined(level.killstreaktierlist)) {
    processkillstreaksintotiers();
  }

  level.killstreaktierlist[tier] = array_randomize(level.killstreaktierlist[tier]);
  return level.killstreaktierlist[tier][0];
}

function br_getrandomkillstreakreward() {
  totalchance = 0;
  rolloffset = 0;
  var_78d4698c80fe0610 = 0;
  tier1_done = 0;
  tier2_done = 0;
  tier3_done = 0;
  var_7f64b15a67fcd125 = 10;
  var_7f64b05a67fccef2 = 35;
  var_7f64af5a67fcccbf = 35;
  var_7f64ae5a67fcca8c = 20;

  if(isDefined(level.tierrewardcounts[0]) && level.tierrewardcounts[0] < 2 || false) {
    totalchance += 10;
  } else {
    var_78d4698c80fe0610 = 1;
    var_7f64b15a67fcd125 = 0;
  }

  if(isDefined(level.tierrewardcounts[1]) && level.tierrewardcounts[1] < -1 || -1 == -1) {
    totalchance += 35;

    if(!var_78d4698c80fe0610) {
      var_7f64b05a67fccef2 += 10;
    }
  } else {
    tier1_done = 1;
    var_7f64b05a67fccef2 = 0;
  }

  if(isDefined(level.tierrewardcounts[2]) && level.tierrewardcounts[2] < -1 || -1 == -1) {
    totalchance += 35;

    if(!var_78d4698c80fe0610) {
      var_7f64af5a67fcccbf += 10;
    }

    if(!tier1_done) {
      var_7f64af5a67fcccbf += 35;
    }
  } else {
    tier2_done = 1;
    var_7f64af5a67fcccbf = 0;
  }

  if(isDefined(level.tierrewardcounts[3]) && level.tierrewardcounts[3] < 15 || false) {
    totalchance += 20;

    if(!var_78d4698c80fe0610) {
      var_7f64ae5a67fcca8c += 10;
    }

    if(!tier1_done) {
      var_7f64ae5a67fcca8c += 35;
    }

    if(!tier1_done) {
      var_7f64ae5a67fcca8c += 35;
    }
  } else {
    tier3_done = 1;
    var_7f64ae5a67fcca8c = 0;
  }

  var_8b591b0bc361ab3d = randomintrange(1, totalchance);

  if(var_8b591b0bc361ab3d <= var_7f64b15a67fcd125) {
    level.tierrewardcounts[0]++;
    streaktierlist = array_randomize(level.killstreaktierlist[0]);
    return streaktierlist[0];
  }

  if(var_8b591b0bc361ab3d <= var_7f64b05a67fccef2) {
    level.tierrewardcounts[1]++;
    streaktierlist = array_randomize(level.killstreaktierlist[1]);
    return streaktierlist[0];
  }

  if(var_8b591b0bc361ab3d <= var_7f64af5a67fcccbf) {
    level.tierrewardcounts[2]++;
    streaktierlist = array_randomize(level.killstreaktierlist[2]);
    return streaktierlist[0];
  }

  level.tierrewardcounts[3]++;
  streaktierlist = array_randomize(level.killstreaktierlist[3]);
  return streaktierlist[0];
}

function processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level.killstreaktierlist[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaktierlist[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level.killstreaktierlist[0] = ["uav"];
}

function br_getrewardicon(streakname) {
  bundle = level.streakglobals.streakbundles[streakname];

  if(isDefined(bundle) && isDefined(bundle.hudicon)) {
    return bundle.hudicon;
  }

  return "";
}

function dropweaponcarepackage(position) {
  level endon("game_ended");
  dropstruct = scripts\cp_mp\killstreaks\airdrop::dropcratefrommanualheli(undefined, undefined, "battle_royale", position, (0, randomfloat(360), 0), 3000, 3000, position, scripts\cp_mp\killstreaks\airdrop::getbrcratedatabytype("weapon"));

  if(!isDefined(dropstruct)) {
    return undefined;
  } else if(!isDefined(dropstruct.crate)) {
    return undefined;
  }

  return dropstruct.crate;
}

function initdropbagsystem() {
  scripts\mp\gametypes\br_circle::registercirclecallbacks(17, &function_b90101a9db963bd1, &function_26a4c7cf6da4e2c0);
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.waypointstring["icon_waypoint_marker"] = "DROP_BAG";
  level.dropbagstruct = spawnStruct();
  level.dropbagstruct.clusters = getStructArray("dropBagCluterNode", "script_noteworthy");
  var_cf73b12323d082a = getStructArray("dropBagLocation", "script_noteworthy");

  foreach(location in var_cf73b12323d082a) {
    location.inuse = 0;

    foreach(cluster in level.dropbagstruct.clusters) {
      if(location.target == cluster.targetname) {
        if(!isDefined(cluster.droplocations)) {
          cluster.droplocations = [];
        }

        if(cluster.droplocations.size < 7) {
          cluster.droplocations[cluster.droplocations.size] = location;
        }
      }
    }
  }

  initdropbagvo();
}

function initdropbagvo() {
  game["dialog"]["dropbag_incoming"] = "drpb_grav_gmst";
}

function precomputedropbagpositions(var_d0de15f793f14825) {
  playerlist = [];
  positionlist = [];
  circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  circleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  teamlist = getarraykeys(level.teamdata);

  foreach(team in teamlist) {
    if(level.teamdata[team]["teamCount"] > 0) {
      foundsquadleader = 0;
      fallbackplayer = undefined;

      foreach(player in level.teamdata[team]["alivePlayers"]) {
        if(!isDefined(fallbackplayer) && !istrue(player.gulag)) {
          fallbackplayer = player;
        }

        if(istrue(player.issquadleader) && !istrue(player.gulag)) {
          foundsquadleader = 1;
          playerlist[playerlist.size] = player;

          if(istrue(var_d0de15f793f14825) && isDefined(level.br_spawns[player.team].groundorigin)) {
            positionlist[positionlist.size] = level.br_spawns[player.team].groundorigin;
          } else {
            positionlist[positionlist.size] = player.origin;
          }

          break;
        }
      }

      if(!foundsquadleader) {
        if(isDefined(fallbackplayer)) {
          player = fallbackplayer;
          playerlist[playerlist.size] = player;

          if(istrue(var_d0de15f793f14825) && isDefined(level.br_spawns[player.team].groundorigin)) {
            positionlist[positionlist.size] = level.br_spawns[player.team].groundorigin;
          } else {
            positionlist[positionlist.size] = player.origin;
          }

          continue;
        }

        if(level.teamdata[team]["aliveCount"] > 0) {
          player = level.teamdata[team]["alivePlayers"][0];
          playerlist[playerlist.size] = player;
          randangle = randomfloat(360);
          randrange = randomfloat(circleradius);
          randorigin = circleorigin + (cos(randangle) * randrange, sin(randangle) * randrange, 0);
          positionlist[positionlist.size] = randorigin;
        }
      }
    }
  }

  assert(positionlist.size == playerlist.size);
  var_342822c35fba7025 = 5;

  if(isDefined(level.dropbagstruct.clusters) && level.dropbagstruct.clusters.size && isDefined(level.dropbagstruct.clusters[0].droplocations)) {
    var_342822c35fba7025 = level.dropbagstruct.clusters[0].droplocations.size;
  }

  var_2827e1b47ae2ab6e = getdvarfloat(@ "scr_dropbag_mindist", 3000);
  var_deeef4b8cb10cae0 = getdvarfloat(@ "scr_dropbag_maxdist", 7000);
  defaultpos = spawnStruct();
  defaultpos.origin = (0, 0, 0);
  positions = [defaultpos];
  i_spread = getdvarint(@ "hash_5a52e56ad2e6cdfb", 128);

  if(isDefined(level.br_level)) {
    if(circleradius > 0) {
      positions = computedropbagpositions(positionlist, level.dropbagstruct.clusters, level.br_level.br_mapbounds, var_2827e1b47ae2ab6e, var_deeef4b8cb10cae0, 2000, var_342822c35fba7025, i_spread, circleorigin, circleradius);
    } else {
      positions = computedropbagpositions(positionlist, level.dropbagstruct.clusters, level.br_level.br_mapbounds, var_2827e1b47ae2ab6e, var_deeef4b8cb10cae0, 2000, var_342822c35fba7025, i_spread);
    }
  }

  if(isDefined(positions)) {
    assert(positions.size == playerlist.size);

    for(i = 0; i < positions.size; i++) {
      player = playerlist[i];

      if(isDefined(positions[i].node)) {
        assert(isDefined(positions[i].index));
        clusterindex = positions[i].node;
        assert(clusterindex < level.dropbagstruct.clusters.size);
        cluster = level.dropbagstruct.clusters[clusterindex];
        spotindex = positions[i].index;
        assert(spotindex < cluster.droplocations.size);
        player.precomputeddropbagpos = cluster.droplocations[spotindex].origin;
        continue;
      }

      player.precomputeddropbagpos = positions[i].origin;
    }

    level.precomputeddropbags = 1;
    level thread spawndropbagsovertime(playerlist);
  }

  level thread managedropbags();
}

function managedropbags() {
  level endon("game_ended");
  level notify("manageDropBags");
  level endon("manageDropBags");
  crateindex = -1;

  while(true) {
    if(!isDefined(level.br_pickups.crates) || !level.br_pickups.crates.size) {
      crateindex = -1;
      wait 1;
      continue;
    }

    crateindex = (crateindex + 1) % level.br_pickups.crates.size;
    crate = level.br_pickups.crates[crateindex];

    if(!isDefined(crate)) {
      level.br_pickups.crates = array_removeundefined(level.br_pickups.crates);
      waitframe();
      continue;
    }

    if(isDefined(crate.team) && crate.team != "neutral") {
      numuses = 0;

      if(isDefined(crate.numuses)) {
        numuses = crate.numuses;
      }

      if(numuses >= level.teamdata[crate.team]["teamCount"]) {
        crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        waitframe();
        continue;
      }
    }

    waitframe();
  }
}

function function_b90101a9db963bd1(dangercircleorigin, dangercircleradius, thresholdradius) {
  var_52d59c928eb97c81 = dangercircleradius + thresholdradius;
  var_c434624ff361bba2 = var_52d59c928eb97c81 * var_52d59c928eb97c81;

  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate)) {
      continue;
    }

    var_e4e4ae4481958d2e = distance2dsquared(crate.origin, dangercircleorigin) + level.var_53c0fa66001cff52 > var_c434624ff361bba2;

    if(var_e4e4ae4481958d2e) {
      crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
  }
}

function function_26a4c7cf6da4e2c0(dangercircleorigin, dangercircleradius, thresholdradius) {
  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate)) {
      continue;
    }

    var_e4e4ae4481958d2e = !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(crate.origin, level.var_53c0fa66001cff52);
    var_8724c89e365130a7 = scripts\mp\gametypes\br_circle_util::function_a465e3c1371d7dab(crate.origin);

    if(var_e4e4ae4481958d2e && !var_8724c89e365130a7) {
      crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
  }
}

function cleanupallbutxcratesforteam(team, cratecount) {
  var_52190e94ba536878 = [];

  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate) || !isDefined(crate.team) || crate.team != team) {
      continue;
    }

    var_52190e94ba536878[var_52190e94ba536878.size] = crate;
  }

  var_6e95fa22aad7c8a5 = var_52190e94ba536878.size - cratecount;

  if(var_6e95fa22aad7c8a5 <= 0) {
    return;
  }

  for(index = var_6e95fa22aad7c8a5 - 1; index >= 0; index--) {
    var_4f7ec11230295c92 = var_52190e94ba536878[index];
    var_4f7ec11230295c92 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

function function_b4255b6f102b056d(var_26784414a3b75d58) {
  var_68e6f05a4ee24dee = physics_createcontents(["physicscontents_water", "physicscontents_playerclip"]);
  raycaststart = var_26784414a3b75d58 + (0, 0, 100);
  raycastend = raycaststart + (0, 0, -10000);
  castresults = physics_raycast(raycaststart, raycastend, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_closest");

  if(isDefined(castresults) && castresults.size > 0) {
    var_23892b9ab76d2bf3 = castresults[0]["surfaceflags"];
    var_4b5a75d5223543c8 = physics_getsurfacetypefromflags(var_23892b9ab76d2bf3);
    var_2b9c39598d19ea34 = var_4b5a75d5223543c8["name"];

    if(isstartstr(var_2b9c39598d19ea34, "surftype_water")) {
      return true;
    }
  }

  return false;
}

function spawndropbagatposition(pos, dropbagspawntypeenum) {
  cleanupallbutxcratesforteam(self.team, 1);
  crate = scripts\cp_mp\killstreaks\airdrop::dropbrloadoutcrate(self.team, pos + (0, 0, 4096), pos + (0, 0, 512));
  assert(isDefined(crate));
  crate endon("death");

  if(scripts\engine\utility::issharedfuncdefined("redeploy_drone", "dropbag_collision_watcher")) {
    crate thread[[scripts\engine\utility::getsharedfunc("redeploy_drone", "dropbag_collision_watcher")]]();
  }

  if(scripts\mp\gametypes\br::function_374b5ec4199e8b21()) {
    crate setscriptablepartstate("objective_map", "custom");
    crate.scriptedobjid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(crate.scriptedobjid > -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(crate.scriptedobjid, "current", crate.origin, "ui_map_icon_drop_loadout");

      if(isDefined(crate.team)) {
        objective_removeallfrommask(crate.scriptedobjid);
        objective_showtoplayersinmask(crate.scriptedobjid);
        objective_addteamtomask(crate.scriptedobjid, crate.team);
        objective_setbackground(crate.scriptedobjid, 1);
      }

      objective_onentity(crate.scriptedobjid, crate);
      objective_setzoffset(crate.scriptedobjid, 70);
      crate thread function_164a7aa37ea0f8dd();
    }
  } else {
    crate.dropbagspawntypeenum = dropbagspawntypeenum;
    enabledropbagobjective(crate, dropbagspawntypeenum);
  }

  choosedropbagmodel(crate);
  voplayers = [];

  foreach(teammate in level.teamdata[self.team]["alivePlayers"]) {
    if(isDefined(teammate) && !teammate scripts\mp\gametypes\br_public::isplayeringulag()) {
      voplayers[voplayers.size] = teammate;

      if(dropbagspawntypeenum == 1) {
        teammate thread scripts\mp\hud_message::showsplash("br_airdrop_incoming_squad");
        continue;
      }

      teammate thread scripts\mp\hud_message::showsplash("br_airdrop_incoming");
    }
  }

  if(!scripts\mp\gametypes\br_public::istutorial()) {
    scripts\mp\gametypes\br_public::brleaderdialogteam("dropbag_incoming", self.team, 1, 2, undefined);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    assert(isnumber(dropbagspawntypeenum));
    scripts\mp\gametypes\br_analytics::branalytics_dropbagdeployed(self, pos, dropbagspawntypeenum, crate);
  }
}

function function_164a7aa37ea0f8dd() {
  level endon("game_ended");
  self waittill("death");
  scripts\mp\objidpoolmanager::returnobjectiveid(self.scriptedobjid);
}

function spawndropbagsovertime(playerlist) {
  foreach(player in playerlist) {
    if(!isDefined(player)) {
      continue;
    }

    position = player.precomputeddropbagpos;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
      circleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();

      if(distance2dsquared(circleorigin, position) > circleradius * circleradius) {
        var_6cc1148e1d19e91e = vectorNormalize(position - circleorigin);
        insidepos = circleorigin + var_6cc1148e1d19e91e * circleradius * 0.95;

        if(isnavmeshloaded()) {
          position = getclosestpointonnavmesh(insidepos);
        } else {
          position = insidepos;
        }
      }

      if(scripts\mp\outofbounds::ispointinoutofbounds(position)) {
        circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
        insidepos = scripts\mp\gametypes\br_c130::snappointtooutofboundstriggertrace(circleorigin, position);

        if(isnavmeshloaded()) {
          position = getclosestpointonnavmesh(insidepos);
        } else {
          position = insidepos;
        }
      }
    }

    if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414() || scripts\cp_mp\utility\game_utility::function_314ff105a27cc131()) {
      if(function_b4255b6f102b056d(position)) {
        if(isnavmeshloaded()) {
          position = getclosestpointonnavmesh(position);
        } else if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
          circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
          position = circleorigin;
        }
      }
    }

    var_902bf0ae43f091d9 = scripts\mp\gametypes\br_rewards::getdropbagspawntypeenum(0, 1, 0, 0, 0, 0);

    if(getdvarint(@ "hash_589c7488b192cb36", 0) == 1) {
      var_902bf0ae43f091d9 = scripts\mp\gametypes\br_rewards::getdropbagspawntypeenum(1, 0, 0, 0, 0, 0);
    }

    player spawndropbagatposition(position, var_902bf0ae43f091d9);
    waitframe();
  }
}

function spawndropbagonlanding() {
  choosenlocation = undefined;
  choosenlocation = findunuseddropbaglocation(self);

  if(!isDefined(choosenlocation)) {
    var_2827e1b47ae2ab6e = getdvarfloat(@ "scr_dropbag_mindist", 3000);
    var_deeef4b8cb10cae0 = getdvarfloat(@ "scr_dropbag_maxdist", 7000);
    choosenlocation = calculatedroplocationnearlocation(self, var_2827e1b47ae2ab6e, var_deeef4b8cb10cae0);
  }

  if(isDefined(choosenlocation)) {
    var_d20de36666a6d60a = scripts\mp\gametypes\br_rewards::getdropbagspawntypeenum(0, 0, 0, 0, 1, 0);
    spawndropbagatposition(choosenlocation.origin, var_d20de36666a6d60a);
    level thread managedropbags();
  }
}

function findunuseddropbaglocation(player) {
  var_16add9d62303e2d6 = [];
  var_2827e1b47ae2ab6e = getdvarfloat(@ "scr_dropbag_mindist", 3000);
  var_deeef4b8cb10cae0 = getdvarfloat(@ "scr_dropbag_maxdist", 7000);
  mindistsq = var_2827e1b47ae2ab6e * var_2827e1b47ae2ab6e;
  maxdistsq = var_deeef4b8cb10cae0 * var_deeef4b8cb10cae0;

  foreach(cluster in level.dropbagstruct.clusters) {
    disttoplayer = distance2dsquared(player.origin, cluster.origin);

    if(disttoplayer >= mindistsq && disttoplayer <= maxdistsq) {
      var_16add9d62303e2d6[var_16add9d62303e2d6.size] = cluster;
    }
  }

  if(var_16add9d62303e2d6.size == 0) {
    return undefined;
  }

  var_16add9d62303e2d6 = array_randomize(var_16add9d62303e2d6);
  var_106ac5fc8e31ec9f = 0;

  foreach(cluster in var_16add9d62303e2d6) {
    var_d6d0d0ab47b5b334 = array_randomize(cluster.droplocations);

    foreach(location in var_d6d0d0ab47b5b334) {
      if(!location.inuse) {
        location.inuse = 1;
        return location;
      }
    }
  }

  return undefined;
}

function enabledropbagobjective(crate, spawntypeenum) {
  crate setotherent(self);

  if(spawntypeenum == 1) {
    crate setscriptablepartstate("objective", "active_squad");
  } else {
    crate setscriptablepartstate("objective", "active");
  }

  crate.objectivevisible = 1;
}

function function_4587a2683d863277(crate) {
  if(crate.dropbagspawntypeenum == 1) {
    crate setscriptablepartstate("objective", "active_squad");
  } else {
    crate setscriptablepartstate("objective", "active");
  }

  crate.objectivevisible = 1;
}

function disabledropbagobjective(crate) {
  crate setscriptablepartstate("objective", "inactive");
  crate.objectivevisible = 0;
}

function choosedropbagmodel(crate) {
  crate setotherent(self);
  crate setscriptablepartstate("model", "choose");
}

function delaydropbags(var_70bcbf0ad5028219) {
  level endon("game_ended");
  delaytimeused = 0;

  foreach(delayseconds in var_70bcbf0ad5028219) {
    waittime = delayseconds - delaytimeused;

    if(waittime > 0) {
      wait waittime;
    }

    delaytimeused = delayseconds;
    precomputedropbagpositions(0);
  }
}

function allowreuseofalldropbags() {
  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("dropbag")) {
    return;
  }

  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate) || !isDefined(crate.team) || crate.team != self.team) {
      continue;
    }

    var_c9dba2970d4506fc = isDefined(crate.playerscaptured) && isDefined(crate.playerscaptured[self getentitynumber()]);

    if(var_c9dba2970d4506fc) {
      crate.playerscaptured[self getentitynumber()] = undefined;

      for(index = 0; index < crate.playersused.size; index++) {
        if(isDefined(crate.playersused[index]) && crate.playersused[index] == self) {
          crate.playersused[index] = undefined;
        }
      }

      crate.playersused = array_removeundefined(crate.playersused);
      crate.numuses--;
    }

    if(!istrue(crate.objectivevisible)) {
      function_4587a2683d863277(crate);
    }
  }
}

function onplayerrespawn() {
  allowreuseofalldropbags();
}

function getdropbagspawntypeenum(var_dbe2a1d0a7766cfc, var_ef7a6a300ebf9493, isfromgrenade, var_283b7b1c42ab77de, var_fc0b9eab91a21b10, var_56f78457d5bfbac6) {
  assertex(var_dbe2a1d0a7766cfc + var_ef7a6a300ebf9493 + isfromgrenade + var_283b7b1c42ab77de + var_fc0b9eab91a21b10 + var_56f78457d5bfbac6 == 1, "<dev string:x1c>");

  if(istrue(var_dbe2a1d0a7766cfc)) {
    return 0;
  }

  if(istrue(var_ef7a6a300ebf9493)) {
    return 1;
  }

  if(istrue(isfromgrenade)) {
    return 1;
  }

  if(istrue(var_283b7b1c42ab77de)) {
    return 2;
  }

  if(istrue(var_fc0b9eab91a21b10)) {
    return 3;
  }

  if(istrue(var_56f78457d5bfbac6)) {
    return 4;
  }

  assertmsg("<dev string:x60>");
  return -1;
}

function function_efb496dab102df58() {
  if(!isDefined(self) || istrue(self.gulag)) {
    return;
  }

  mindist = 120;
  maxdist = 360;
  var_90438c7f217dc4a0 = calculatedroplocationnearlocation(self, mindist, maxdist);

  if(isDefined(var_90438c7f217dc4a0)) {
    var_c46075dfa7ca36d4 = scripts\mp\gametypes\br_rewards::getdropbagspawntypeenum(0, 0, 0, 0, 0, 1);
    spawndropbagatposition(var_90438c7f217dc4a0.origin, var_c46075dfa7ca36d4);
    level thread managedropbags();
  }
}

function testmissionrewards() {
  runmissionrewarddelivery(level.players[0], level.players[0], undefined, 3);
}

function findclosestdroplocation(startlocation) {
  var_206c7349dd628bc8 = startlocation array_sort_with_func(level.dropbagstruct.clusters, &sortlocationsbydistance);

  foreach(cluster in var_206c7349dd628bc8) {
    var_d6d0d0ab47b5b334 = array_randomize(cluster.droplocations);

    foreach(location in var_d6d0d0ab47b5b334) {
      if(!location.inuse) {
        location.inuse = 1;
        return location;
      }
    }
  }

  return undefined;
}

function sortlocationsbydistance(location1, location2) {
  return distancesquared(location1.origin, self.origin) < distancesquared(location2.origin, self.origin);
}

function calculatedroplocationnearlocation(location, mindist, maxdist) {
  pos = location.origin;
  x = undefined;
  y = undefined;
  var_8b591b0bc361ab3d = randomint(2);
  direction = ter_op(var_8b591b0bc361ab3d, -1, 1);

  if(direction > 0) {
    x = randomfloatrange(pos[0] + mindist * direction, pos[0] + maxdist * direction);

    if(x >= level.br_level.br_mapbounds[0][0]) {
      x = level.br_level.br_mapbounds[0][0] - 250;
    }
  } else {
    x = randomfloatrange(pos[0] + maxdist * direction, pos[0] + mindist * direction);

    if(x <= level.br_level.br_mapbounds[1][0]) {
      x = level.br_level.br_mapbounds[1][0] + 250;
    }
  }

  var_8b591b0bc361ab3d = randomint(2);
  direction = ter_op(var_8b591b0bc361ab3d, -1, 1);

  if(direction > 0) {
    y = randomfloatrange(pos[1] + mindist * direction, pos[1] + maxdist * direction);

    if(y >= level.br_level.br_mapbounds[0][1]) {
      y = level.br_level.br_mapbounds[0][1] - 250;
    }
  } else {
    y = randomfloatrange(pos[1] + maxdist * direction, pos[1] + mindist * direction);

    if(y <= level.br_level.br_mapbounds[1][1]) {
      y = level.br_level.br_mapbounds[1][1] + 250;
    }
  }

  if(isnavmeshloaded()) {
    pointonnavmesh = getclosestpointonnavmesh((x, y, pos[2]));

    if(isDefined(pointonnavmesh)) {
      droplocation = spawnStruct();
      droplocation.origin = pointonnavmesh;
      return droplocation;
    }
  }

  droplocation = spawnStruct();
  droplocation.origin = (x, y, pos[2]);
  return droplocation;
}

function debugsphereonlocation(origin) {
  sphere(origin, 200, (1, 0, 0), 0, 5000);
}

function maskobjectivetoplayerssquad(objective, var_9c34764b7d5ac247) {
  objective.visibilitymanuallycontrolled = 1;
  objective_removeallfrommask(objective.objidnum);

  foreach(player in level.squaddata[var_9c34764b7d5ac247.team][var_9c34764b7d5ac247.sessionsquadid].players) {
    objective_addclienttomask(objective.objidnum, player);
  }
}