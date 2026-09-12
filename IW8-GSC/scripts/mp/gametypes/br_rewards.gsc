/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_rewards.gsc
***********************************************/

function init_br_rewards() {
  processkillstreaksintotiers();
  level.tierrewardcounts = [];
  level.tierrewardcounts[3] = 0;
  level.tierrewardcounts[2] = 0;
  level.tierrewardcounts[1] = 0;
  level.tierrewardcounts[0] = 0;
}

function runmissionrewarddelivery(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(!isDefined(var_0.rewardlocation)) {
    var_4 = findclosestdroplocation(var_0);

    if(!isDefined(var_4)) {
      var_4 = calculatedroplocationnearlocation(var_0, 64, 2048);
    }
  } else {
    var_4 = var_0.rewardlocation;
  }

  if(isDefined(var_2)) {
    thread runkillstreakreward(var_4, var_1, var_2);
    return;
  }

  if(isDefined(var_3)) {
    thread runkillstreakreward(var_4, var_1, getkillstreak(var_3));
    return;
  }

  thread runkillstreakreward(var_4, var_1, getkillstreak(3));
}

function runkillstreakreward(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = undefined;

  if(!istrue(var_0.isinside)) {
    var_4 = 72;
  } else {
    var_4 = 40;
  }

  var_5 = scripts\mp\gameobjects::createobjidobject(var_1.origin, "neutral", (0, 0, var_4), undefined, "any");
  maskobjectivetoplayerssquad(var_5, var_2);
  var_5.origin = var_1.origin;
  var_5.angles = var_1.angles;
  thread docratedropsmoke(undefined, var_1, 16);
  var_5.iconname = "_incoming";
  var_5.lockupdatingicons = 0;
  var_5 scripts\mp\gameobjects::setobjectivestatusicons(var_3);
  var_5.lockupdatingicons = 1;
  wait 3;
  wait 1;

  if(!istrue(var_1.isinside)) {
    var_4 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var_2.team, var_3, var_1.origin, (0, randomint(360), 0), undefined);
    var_4.skipminimapicon = 1;
    var_4.nevertimeout = 0;
    var_4.waitforobjectiveactivate = 1;
    var_4.killminimapicon = 0;
    var_4.disallowheadiconid = 1;
    var_4.isarmcrate = 1;
    var_4 waittill("crate_dropped");
    var_5.useobj = var_4;
    var_5.origin = var_4.origin;
  } else {
    var_5.useobj = spawn("script_model", var_5.origin);
    var_5.useobj.disallowheadiconid = 1;
    var_5.useobj.cratetype = "arm_no_owner";
    var_6 = scripts\cp_mp\killstreaks\airdrop::getleveldata(var_5.useobj.cratetype);
    var_5.useobj.minimapicon = var_6.minimapicon;
    var_5.useobj.capturestring = var_6.capturestring;
    var_5.useobj.rerollstring = var_6.rerollstring;
    var_5.useobj.supportsreroll = var_6.supportsreroll;
    var_5.useobj.isdummyarmcrate = 1;
    var_5.useobj.isarmcrate = 1;
    var_5.useobj.data = scripts\cp_mp\killstreaks\airdrop::getarmcratedatabystreakname(var_3);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_5.objidnum, var_5.useobj);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_5.objidnum, 40);
  }

  var_7 = 0;
  var_8 = 0.1;

  if(istrue(var_1.isinside)) {
    var_9 = 15;
  } else {
    var_9 = 1;
  }

  wait var_9;

  if(!istrue(var_2.isinside)) {
    var_4 notify("objective_activate");
    scripts\mp\objidpoolmanager::update_objective_onentity(var_7.objidnum, var_4);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_7.objidnum, 72);
  } else {
    var_7.useobj scripts\cp_mp\killstreaks\airdrop::makecrateusable();
    var_6 = scripts\cp_mp\killstreaks\airdrop::getleveldata(var_7.useobj.cratetype);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_7.objidnum, 40);
  }

  var_7.iconname = "";
  var_7.lockupdatingicons = 0;
  var_7 scripts\mp\gameobjects::setobjectivestatusicons(var_4);
  var_7.lockupdatingicons = 1;
  objective_setlabel(var_7.objidnum, "");

  if(isDefined(var_4)) {
    var_4 waittill("death");
  } else {
    var_7.useobj waittill("death");
  }

  var_7 scripts\mp\gameobjects::setvisibleteam("none");
  var_7 scripts\mp\gameobjects::releaseid();
  var_7.visibleteam = "none";
}

function dropcrate(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var_2, var_0, var_1.origin, (0, randomint(360), 0), undefined);
  return var_3;
}

function docratedropsmoke(var_0, var_1, var_2) {
  var_3 = var_1.origin + (0, 0, 2000);
  var_4 = scripts\common\utility::groundpos(var_3, (0, 0, 1));
  var_1.vfxent = spawn("script_model", var_4);
  var_1.vfxent setModel("tag_origin");
  var_1.vfxent.angles = (0, 0, 0);
  var_1.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var_1.vfxent, "tag_origin");

  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::ref_143B9(var_2, "crate_dropped");
  } else {
    wait var_2;
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var_1.vfxent, "tag_origin");
  var_1.vfxent delete();
}

function getkillstreak(var_0) {
  if(!isDefined(level.killstreaktierlist)) {
    processkillstreaksintotiers();
  }

  level.killstreaktierlist[var_0] = scripts\engine\utility::array_randomize(level.killstreaktierlist[var_0]);
  return level.killstreaktierlist[var_0][0];
}

function br_getrandomkillstreakreward() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 10;
  var_7 = 35;
  var_8 = 35;
  var_9 = 20;

  if(isDefined(level.tierrewardcounts[0]) && level.tierrewardcounts[0] < 2 || false) {
    var_0 += 10;
  } else {
    var_2 = 1;
    var_6 = 0;
  }

  if(isDefined(level.tierrewardcounts[1]) && level.tierrewardcounts[1] < -1 || true) {
    var_0 += 35;

    if(!var_2) {
      var_7 += 10;
    }
  } else {
    var_3 = 1;
    var_7 = 0;
  }

  if(isDefined(level.tierrewardcounts[2]) && level.tierrewardcounts[2] < -1 || true) {
    var_0 += 35;

    if(!var_2) {
      var_8 += 10;
    }

    if(!var_3) {
      var_8 += 35;
    }
  } else {
    var_4 = 1;
    var_8 = 0;
  }

  if(isDefined(level.tierrewardcounts[3]) && level.tierrewardcounts[3] < 15 || false) {
    var_0 += 20;

    if(!var_2) {
      var_9 += 10;
    }

    if(!var_3) {
      var_9 += 35;
    }

    if(!var_3) {
      var_9 += 35;
    }
  } else {
    var_5 = 1;
    var_9 = 0;
  }

  var_10 = randomintrange(1, var_0);

  if(var_10 <= var_6) {
    level.tierrewardcounts[0]++;
    var_11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[0]);
    return var_11[0];
  }

  if(var_11 <= var_8) {
    level.tierrewardcounts[1]++;
    var_11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[1]);
    return var_11[0];
  }

  if(var_11 <= var_10) {
    level.tierrewardcounts[2]++;
    var_11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[2]);
    return var_11[0];
  }

  level.tierrewardcounts[3]++;
  var_11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[3]);
  return var_11[0];
}

function processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level.killstreaktierlist[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaktierlist[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level.killstreaktierlist[0] = ["uav"];
}

function br_getrewardicon(var_0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var_0]["hudIcon"];
}

function dropweaponcarepackage(var_0) {
  level endon("game_ended");
  var_1 = scripts\cp_mp\killstreaks\airdrop::dropcratefrommanualheli(undefined, undefined, "battle_royale", var_0, (0, randomfloat(360), 0), 3000, 3000, var_0, scripts\cp_mp\killstreaks\airdrop::getbrcratedatabytype("weapon"));

  if(!isDefined(var_1)) {
    return undefined;
  } else if(!isDefined(var_1.crate)) {
    return undefined;
  }

  return var_1.crate;
}

function initdropbagsystem() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.waypointstring["icon_waypoint_marker"] = "DROP_BAG";
  level.dropbagstruct = spawnStruct();
  level.dropbagstruct.clusters = scripts\engine\utility::getStructArray("dropBagCluterNode", "script_noteworthy");
  var_0 = scripts\engine\utility::getStructArray("dropBagLocation", "script_noteworthy");

  foreach(var_2 in level.dropbagstruct.clusters) {
    var_2.droplocations = undefined;
  }

  foreach(var_5 in var_0) {
    var_5.inuse = 0;

    foreach(var_2 in level.dropbagstruct.clusters) {
      if(var_5.target == var_2.targetname) {
        if(!isDefined(var_2.droplocations)) {
          var_2.droplocations = [];
        }

        var_2.droplocations[var_2.droplocations.size] = var_5;
      }
    }
  }

  terminal_pusher_approach_entrance_array();
}

function terminal_pusher_approach_entrance_array() {
  game["dialog"]["dropbag_incoming"] = "gamestate_dropbag_incoming";
  game["dialog"]["dropbag_available"] = "gamestate_dropbag_available";
}

function ref_1284D(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_4 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_5 = var_4;

  if(var_5 <= 0) {
    var_5 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  }

  var_6 = getarraykeys(level.teamdata);

  foreach(var_8 in var_6) {
    if(level.teamdata[var_8]["teamCount"] > 0) {
      var_9 = 0;
      var_10 = undefined;

      foreach(var_12 in level.teamdata[var_8]["alivePlayers"]) {
        if(!isDefined(var_10) && !istrue(var_12.gulag) && !istrue(var_12.unset_relic_gun_game)) {
          var_10 = var_12;
        }

        if(istrue(var_12.issquadleader) && !istrue(var_12.gulag) && !istrue(var_12.unset_relic_gun_game)) {
          var_9 = 1;
          var_1 = var_12;

          if(istrue(var_0) && isDefined(level.br_spawns[var_12.team].groundorigin)) {
            var_2 = level.br_spawns[var_12.team].groundorigin;
          } else {
            var_2 = var_12.origin;
          }

          break;
        }
      }

      if(!var_9) {
        if(isDefined(var_10)) {
          var_12 = var_10;
          var_1 = var_12;

          if(istrue(var_0) && isDefined(level.br_spawns[var_12.team].groundorigin)) {
            var_2 = level.br_spawns[var_12.team].groundorigin;
          } else {
            var_2 = var_12.origin;
          }
        } else if(level.teamdata[var_8]["aliveCount"] > 0) {
          var_12 = level.teamdata[var_8]["alivePlayers"][0];
          var_1 = var_12;
          var_14 = randomfloat(360);
          var_15 = randomfloat(var_5);
          var_16 = var_3 + (cos(var_14) * var_15, sin(var_14) * var_15, 0);
          var_2 = var_16;
        }
      }
    }
  }

  var_18 = 5;

  if(isDefined(level.dropbagstruct.clusters) && level.dropbagstruct.clusters.size && isDefined(level.dropbagstruct.clusters[0].droplocations)) {
    var_18 = level.dropbagstruct.clusters[0].droplocations.size;
    var_18 = int(min(var_18, 5));
  }

  var_19 = getdvarfloat("scr_dropbag_mindist", 3000);
  var_20 = getdvarfloat("scr_dropbag_maxdist", 7000);
  var_21 = spawnStruct();
  var_21.origin = (0, 0, 0);
  var_22 = [var_21];

  if(isDefined(level.br_level)) {
    if(var_4 > 0) {
      var_22 = getunusedlootcachepoints(var_2, level.dropbagstruct.clusters, level.br_level.br_mapbounds, var_19, var_20, 2000, var_18, 128, var_3, var_4);
    } else {
      var_22 = getunusedlootcachepoints(var_2, level.dropbagstruct.clusters, level.br_level.br_mapbounds, var_19, var_20, 2000, var_18, 128);
    }
  }

  if(isDefined(var_22)) {
    for(var_23 = 0; var_23 < var_22.size; var_23++) {
      var_12 = var_1[var_23];

      if(isDefined(var_22[var_23].node)) {
        var_24 = var_22[var_23].node;
        var_25 = level.dropbagstruct.clusters[var_24];
        var_26 = var_22[var_23].index;
        var_12.ref_1284B = var_25.droplocations[var_26].origin;
        continue;
      }

      var_12.ref_1284B = var_22[var_23].origin;
    }

    level.ref_1284C = 1;
    thread ref_1363B(level);
  }

  thread ref_11AAA();
}

function ref_11AAA() {
  level notify("manageDropBags");
  level endon("manageDropBags");
  var_0 = -1;
  var_1 = getdvarfloat("scr_br_circle_object_cleanup_threshold", 2400);

  for(;;) {
    if(!isDefined(level.br_pickups.crates) || !level.br_pickups.crates.size) {
      var_0 = -1;
      wait 1;
      continue;
    }

    var_0 = (var_0 + 1) % level.br_pickups.crates.size;
    var_2 = level.br_pickups.crates[var_0];

    if(!isDefined(var_2)) {
      level.br_pickups.crates = scripts\engine\utility::array_removeundefined(level.br_pickups.crates);
      waitframe();
      continue;
    }

    if(isDefined(var_2.team)) {
      var_3 = 0;

      if(isDefined(var_2.numuses)) {
        var_3 = var_2.numuses;
      }

      if(var_3 >= level.teamdata[var_2.team]["teamCount"]) {
        var_2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        waitframe();
        continue;
      }
    }

    var_4 = scripts\mp\gametypes\br_circle::getdangercircleradius();

    if(var_4 > 0) {
      var_5 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
      var_6 = distance2dsquared(var_2.origin, var_5);
      var_7 = max(0, var_4 + var_1);

      if(var_6 > var_7 * var_7) {
        var_2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        waitframe();
        continue;
      }
    }

    waitframe();
  }
}

function handlerelicshieldsonlyonkill(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.br_pickups.crates) {
    if(!isDefined(var_4) || !isDefined(var_4.team) || var_4.team != var_0) {
      continue;
    }

    var_2 = var_4;
  }

  var_6 = var_2.size - var_1;

  if(var_6 <= 0) {
    return;
  }

  for(var_7 = var_6 - 1; var_7 >= 0; var_7--) {
    var_8 = var_2[var_7];
    var_8 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

function ref_1363A(var_0, var_1, var_2) {
  handlerelicshieldsonlyonkill(self.team, 1);
  var_3 = 4096;
  var_4 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_3", "targetname");
  var_5 = (11240, 13287, 9200);
  var_6 = scripts\cp_mp\utility\game_utility::unsetchainkillstreaks() && distance2d(var_0, var_5) < getdvarint("scr_br_island_peak_rad", 7000) && getdvarint("scr_br_island_peak_bag", 1) == 1;

  if(istrue(self.umbra) || isDefined(var_4) && distance2d(var_0, var_4.origin) < 5000 || var_6) {
    var_3 = 10000;
  }

  var_7 = scripts\cp_mp\killstreaks\airdrop::dropbrloadoutcrate(self.team, var_0 + (0, 0, var_3), var_0 + (0, 0, 512));
  var_7 endon("death");
  ref_13C47(var_7);
  enabledropbagobjective(var_7);
  getzeroarray(var_7);

  foreach(var_9 in level.teamdata[self.team]["alivePlayers"]) {
    if(isDefined(var_9) && !var_9 scripts\mp\gametypes\br_public::isplayeringulag()) {
      var_10 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "br_airdrop_incoming");
      var_9 thread scripts\mp\hud_message::showsplash(var_10);
    }
  }

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_public::dmztut_luicallback("dropbag_incoming", self.team, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::destprogress(self, var_0, var_1, var_7);
    thread setup_minecart(var_7);
    thread handlecratehitbymissile(var_7);
    return;
  }
}

function setup_minecart() {
  var_0 endon("death");
  wait 1;
  var_1 = var_0 physics_getbodyid(0);

  while(isDefined(var_0)) {
    var_2 = physics_getbodylinvel(var_1);

    if(abs(var_2[2]) < 0.01) {
      var_3 = [var_0];
      var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
      var_5 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 100), var_0.origin + (0, 0, -100), var_3, var_4);

      if(var_5["fraction"] == 1) {
        var_0 scripts\cp_mp\killstreaks\airdrop::infinite_chopper(var_0.origin, (0, 0, -10));
      } else {
        break;
      }
    }

    wait 0.5;
  }
}

function handlecratehitbymissile(var_0) {
  var_0 endon("death");
  wait 1;

  if(getdvarint("scr_br_airdrop_missile", 1) == 0) {
    return;
  }

  var_1 = var_0 physics_getbodyid(0);
  var_2 = 0;
  var_3 = 0;

  while(isDefined(var_0)) {
    var_4 = physics_getbodylinvel(var_1);
    var_5 = length(var_4);
    var_6 = getdvarint("scr_br_airdrop_missile_vel_stop", 500);

    if(var_5 - var_2 > var_6 || var_3 && var_5 > var_6) {
      var_7 = vectorNormalize(var_4);
      var_8 = var_7 * getdvarint("scr_br_airdrop_missile_vel_change", 0);
      physics_setbodyangvel(var_1, var_8[0], var_8[1], var_8[2]);
      var_9 = physics_getbodyangvel(var_1);
      var_10 = vectorNormalize(var_9);
      var_11 = var_10 * getdvarint("scr_br_airdrop_missile_ang_vel_change", 0);
      physics_setbodylinangvel(var_1, var_11[0], var_11[1], var_11[2]);
      var_3 = 1;
    } else {
      var_3 = 0;
    }

    var_2 = var_5;
    waitframe();
  }
}

function ref_1363B(var_0) {
  var_1 = undefined;

  if(isDefined(level.ref_12931)) {
    var_1 = level.ref_12931;
    level.ref_12931 = undefined;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = var_3.ref_1284B;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      var_5 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
      var_6 = scripts\mp\gametypes\br_circle::getsafecircleradius();

      if(distance2dsquared(var_5, var_4) > var_6 * var_6) {
        var_7 = vectorNormalize(var_4 - var_5);
        var_8 = var_5 + var_7 * var_6 * 0.95;

        if(isscriptabledefined()) {
          var_4 = getclosestpointonnavmesh(var_8);
        } else {
          var_4 = var_8;
        }
      } else if(istrue(level.ref_14089) && isscriptabledefined()) {
        var_4 = getclosestpointonnavmesh(var_4);
      }

      if(istrue(level.ref_1406F)) {
        var_4 = return_enemy_type_mask(var_4);
      }

      if(scripts\mp\outofbounds::ispointinoutofbounds(var_4)) {
        var_5 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
        var_8 = scripts\mp\gametypes\br_c130::ref_1342E(var_5, var_4);

        if(isscriptabledefined()) {
          var_4 = getclosestpointonnavmesh(var_8);
        } else {
          var_4 = var_8;
        }
      }
    }

    var_9 = relic_punchbullets_fire_fists(1, 0, 0, 0, 0);
    ref_1363A(var_3, var_4, var_9, var_1);
    waitframe();
  }
}

function return_enemy_type_mask(var_0) {
  if(isDefined(level.minigun_warning_time)) {
    if(!updatesecretstashhud(var_0, level.minigun_warning_time)) {
      var_1 = relic_bang_and_boom_think(var_0, level.minigun_warning_time);

      if(isDefined(var_1)) {
        var_0 = var_1;
      }
    }
  }

  return var_0;
}

function updatesecretstashhud(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3)) {
      return true;
    }
  }

  return false;
}

function relic_bang_and_boom_think(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = (var_0[0], var_0[1], 0);

  foreach(var_6 in var_1) {
    var_7 = (var_6.origin[0], var_6.origin[1], 0);
    var_8 = var_4 - var_7;
    var_9 = var_6.radius / length(var_8);
    var_8 *= var_9;
    var_10 = var_7 + var_8;
    var_11 = length(var_4 - var_10);

    if(!isDefined(var_3) || var_11 < var_3) {
      var_2 = var_10;
      var_3 = var_11;
    }
  }

  if(isDefined(var_2)) {
    var_2 = (var_2[0], var_2[1], var_0[2]);
  }

  return var_2;
}

function spawndropbagonlanding() {
  var_0 = undefined;
  var_0 = findunuseddropbaglocation(self);

  if(!isDefined(var_0)) {
    var_1 = getdvarfloat("scr_dropbag_mindist", 3000);
    var_2 = getdvarfloat("scr_dropbag_maxdist", 7000);
    var_0 = calculatedroplocationnearlocation(self, var_1, var_2);
  }

  if(isDefined(var_0)) {
    var_3 = relic_punchbullets_fire_fists(0, 0, 0, 1, 0);
    ref_1363A(var_0.origin, var_3);
    thread ref_11AAA();
    return;
  }
}

function findunuseddropbaglocation(var_0) {
  var_1 = [];
  var_2 = getdvarfloat("scr_dropbag_mindist", 3000);
  var_3 = getdvarfloat("scr_dropbag_maxdist", 7000);
  var_4 = var_2 * var_2;
  var_5 = var_3 * var_3;

  foreach(var_7 in level.dropbagstruct.clusters) {
    var_8 = distance2dsquared(var_0.origin, var_7.origin);

    if(var_8 >= var_4 && var_8 <= var_5) {
      var_1 = var_7;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_10 = 0;

  foreach(var_7 in var_1) {
    var_12 = scripts\engine\utility::array_randomize(var_7.droplocations);

    foreach(var_14 in var_12) {
      if(!var_14.inuse) {
        var_14.inuse = 1;
        return var_14;
      }
    }
  }

  return undefined;
}

function ref_13C47(var_0) {
  thread ref_13C48(level, var_0);
}

function ref_13C48(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_2 = var_1;
  var_3 = var_1.team;

  for(;;) {
    var_0 setotherent(var_2);
    var_2 waittill("disconnect");
    var_4 = undefined;
    var_5 = level.teamdata[var_3]["players"];

    foreach(var_1 in var_5) {
      if(isDefined(var_2) && var_2 == var_1) {
        continue;
      }

      var_4 = var_1;
      break;
    }

    if(!isDefined(var_4)) {
      break;
    }

    var_2 = var_4;
  }
}

function enabledropbagobjective(var_0) {
  var_0 setscriptablepartstate("objective", "active");
}

function getzeroarray(var_0) {
  var_0 setscriptablepartstate("model", "choose");
}

function kioskreviveplayer(var_0) {
  level endon("game_ended");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_4 = var_3 - var_1;

    if(var_4 > 0) {
      wait var_4;
    }

    var_1 = var_3;
    ref_1284D(0);

    if(level.delay_put_vehicles_on_compass) {
      scripts\mp\gametypes\br_armory_kiosk::ref_13169("supply_drop", 0);
    }
  }
}

function brking_initexternalfeatures() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("dropbag")) {
    return;
  }

  foreach(var_1 in level.br_pickups.crates) {
    if(!isDefined(var_1) || !isDefined(var_1.team) || var_1.team != self.team) {
      continue;
    }

    var_2 = isDefined(var_1.playerscaptured) && isDefined(var_1.playerscaptured[self getentitynumber()]);

    if(var_2) {
      var_1.playerscaptured[self getentitynumber()] = undefined;

      for(var_3 = 0; var_3 < var_1.playersused.size; var_3++) {
        if(isDefined(var_1.playersused[var_3]) && var_1.playersused[var_3] == self) {
          var_1.playersused[var_3] = undefined;
        }
      }

      var_1.playersused = scripts\engine\utility::array_removeundefined(var_1.playersused);
      var_1.numuses--;
    }
  }
}

function ref_12072() {
  brking_initexternalfeatures();
}

function relic_punchbullets_fire_fists(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0)) {
    return 0;
  }

  if(istrue(var_1)) {
    return 1;
  }

  if(istrue(var_2)) {
    return 2;
  }

  if(istrue(var_3)) {
    return 3;
  }

  if(istrue(var_4)) {
    return 4;
  }

  return -1;
}

function testmissionrewards() {
  runmissionrewarddelivery(level.players[0], level.players[0], undefined, 3);
}

function findclosestdroplocation(var_0) {
  var_1 = var_0 scripts\engine\utility::array_sort_with_func(level.dropbagstruct.clusters, &sortlocationsbydistance);

  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::array_randomize(var_3.droplocations);

    foreach(var_6 in var_4) {
      if(!var_6.inuse) {
        var_6.inuse = 1;
        return var_6;
      }
    }
  }

  return undefined;
}

function sortlocationsbydistance(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) < distancesquared(var_1.origin, self.origin);
}

function calculatedroplocationnearlocation(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1, 1);

  if(var_7 > 0) {
    var_4 = randomfloatrange(var_3[0] + var_1 * var_7, var_3[0] + var_2 * var_7);

    if(var_4 >= level.br_level.br_mapbounds[0][0]) {
      var_4 = level.br_level.br_mapbounds[0][0] - 250;
    }
  } else {
    var_4 = randomfloatrange(var_3[0] + var_2 * var_7, var_3[0] + var_1 * var_7);

    if(var_4 <= level.br_level.br_mapbounds[1][0]) {
      var_4 = level.br_level.br_mapbounds[1][0] + 250;
    }
  }

  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1, 1);

  if(var_7 > 0) {
    var_5 = randomfloatrange(var_3[1] + var_1 * var_7, var_3[1] + var_2 * var_7);

    if(var_5 >= level.br_level.br_mapbounds[0][1]) {
      var_5 = level.br_level.br_mapbounds[0][1] - 250;
    }
  } else {
    var_5 = randomfloatrange(var_3[1] + var_2 * var_7, var_3[1] + var_1 * var_7);

    if(var_5 <= level.br_level.br_mapbounds[1][1]) {
      var_5 = level.br_level.br_mapbounds[1][1] + 250;
    }
  }

  if(isscriptabledefined()) {
    var_8 = getclosestpointonnavmesh((var_4, var_5, var_3[2]));

    if(isDefined(var_8)) {
      var_9 = spawnStruct();
      var_9.origin = var_8;
      return var_9;
    }
  }

  var_9 = spawnStruct();
  var_9.origin = (var_5, var_6, var_4[2]);
  return var_9;
}

function debugsphereonlocation(var_0) {}

function maskobjectivetoplayerssquad(var_0, var_1) {
  var_0.visibilitymanuallycontrolled = 1;
  objective_removeallfrommask(var_0.objidnum);

  foreach(var_3 in level.squaddata[var_1.team][var_1.squadindex].players) {
    objective_addclienttomask(var_0.objidnum, var_3);
  }
}