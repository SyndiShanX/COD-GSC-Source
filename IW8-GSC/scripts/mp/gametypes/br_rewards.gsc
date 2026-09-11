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

function runmissionrewarddelivery(var0, var1, var2, var3) {
  var4 = undefined;

  if(!isDefined(var0.rewardlocation)) {
    var4 = findclosestdroplocation(var0);

    if(!isDefined(var4)) {
      var4 = calculatedroplocationnearlocation(var0, 64, 2048);
    }
  } else {
    var4 = var0.rewardlocation;
  }

  if(isDefined(var2)) {
    thread runkillstreakreward(var4, var1, var2);
    return;
  }

  if(isDefined(var3)) {
    thread runkillstreakreward(var4, var1, getkillstreak(var3));
    return;
  }

  thread runkillstreakreward(var4, var1, getkillstreak(3));
}

function runkillstreakreward(var0, var1, var2) {
  level endon("game_ended");
  var3 = undefined;

  if(!istrue(var0.isinside)) {
    var4 = 72;
  } else {
    var4 = 40;
  }

  var5 = scripts\mp\gameobjects::createobjidobject(var1.origin, "neutral", (0, 0, var4), undefined, "any");
  maskobjectivetoplayerssquad(var5, var2);
  var5.origin = var1.origin;
  var5.angles = var1.angles;
  thread docratedropsmoke(undefined, var1, 16);
  var5.iconname = "_incoming";
  var5.lockupdatingicons = 0;
  var5 scripts\mp\gameobjects::setobjectivestatusicons(var3);
  var5.lockupdatingicons = 1;
  wait 3;
  wait 1;

  if(!istrue(var1.isinside)) {
    var4 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var2.team, var3, var1.origin, (0, randomint(360), 0), undefined);
    var4.skipminimapicon = 1;
    var4.nevertimeout = 0;
    var4.waitforobjectiveactivate = 1;
    var4.killminimapicon = 0;
    var4.disallowheadiconid = 1;
    var4.isarmcrate = 1;
    var4 waittill("crate_dropped");
    var5.useobj = var4;
    var5.origin = var4.origin;
  } else {
    var5.useobj = spawn("script_model", var5.origin);
    var5.useobj.disallowheadiconid = 1;
    var5.useobj.cratetype = "arm_no_owner";
    var6 = scripts\cp_mp\killstreaks\airdrop::getleveldata(var5.useobj.cratetype);
    var5.useobj.minimapicon = var6.minimapicon;
    var5.useobj.capturestring = var6.capturestring;
    var5.useobj.rerollstring = var6.rerollstring;
    var5.useobj.supportsreroll = var6.supportsreroll;
    var5.useobj.isdummyarmcrate = 1;
    var5.useobj.isarmcrate = 1;
    var5.useobj.data = scripts\cp_mp\killstreaks\airdrop::getarmcratedatabystreakname(var3);
    scripts\mp\objidpoolmanager::update_objective_onentity(var5.objidnum, var5.useobj);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var5.objidnum, 40);
  }

  var7 = 0;
  var8 = 0.1;

  if(istrue(var1.isinside)) {
    var9 = 15;
  } else {
    var9 = 1;
  }

  wait var9;

  if(!istrue(var2.isinside)) {
    var4 notify("objective_activate");
    scripts\mp\objidpoolmanager::update_objective_onentity(var7.objidnum, var4);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var7.objidnum, 72);
  } else {
    var7.useobj scripts\cp_mp\killstreaks\airdrop::makecrateusable();
    var6 = scripts\cp_mp\killstreaks\airdrop::getleveldata(var7.useobj.cratetype);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var7.objidnum, 40);
  }

  var7.iconname = "";
  var7.lockupdatingicons = 0;
  var7 scripts\mp\gameobjects::setobjectivestatusicons(var4);
  var7.lockupdatingicons = 1;
  objective_setlabel(var7.objidnum, "");

  if(isDefined(var4)) {
    var4 waittill("death");
  } else {
    var7.useobj waittill("death");
  }

  var7 scripts\mp\gameobjects::setvisibleteam("none");
  var7 scripts\mp\gameobjects::releaseid();
  var7.visibleteam = "none";
}

function dropcrate(var0, var1, var2) {
  var3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var2, var0, var1.origin, (0, randomint(360), 0), undefined);
  return var3;
}

function docratedropsmoke(var0, var1, var2) {
  var3 = var1.origin + (0, 0, 2000);
  var4 = scripts\common\utility::groundpos(var3, (0, 0, 1));
  var1.vfxent = spawn("script_model", var4);
  var1.vfxent setModel("tag_origin");
  var1.vfxent.angles = (0, 0, 0);
  var1.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var1.vfxent, "tag_origin");

  if(isDefined(var0)) {
    var0 scripts\engine\utility::ref_143b9(var2, "crate_dropped");
  } else {
    wait var2;
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var1.vfxent, "tag_origin");
  var1.vfxent delete();
}

function getkillstreak(var0) {
  if(!isDefined(level.killstreaktierlist)) {
    processkillstreaksintotiers();
  }

  level.killstreaktierlist[var0] = scripts\engine\utility::array_randomize(level.killstreaktierlist[var0]);
  return level.killstreaktierlist[var0][0];
}

function br_getrandomkillstreakreward() {
  var0 = 0;
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = 0;
  var5 = 0;
  var6 = 10;
  var7 = 35;
  var8 = 35;
  var9 = 20;

  if(isDefined(level.tierrewardcounts[0]) && level.tierrewardcounts[0] < 2 || false) {
    var0 += 10;
  } else {
    var2 = 1;
    var6 = 0;
  }

  if(isDefined(level.tierrewardcounts[1]) && level.tierrewardcounts[1] < -1 || true) {
    var0 += 35;

    if(!var2) {
      var7 += 10;
    }
  } else {
    var3 = 1;
    var7 = 0;
  }

  if(isDefined(level.tierrewardcounts[2]) && level.tierrewardcounts[2] < -1 || true) {
    var0 += 35;

    if(!var2) {
      var8 += 10;
    }

    if(!var3) {
      var8 += 35;
    }
  } else {
    var4 = 1;
    var8 = 0;
  }

  if(isDefined(level.tierrewardcounts[3]) && level.tierrewardcounts[3] < 15 || false) {
    var0 += 20;

    if(!var2) {
      var9 += 10;
    }

    if(!var3) {
      var9 += 35;
    }

    if(!var3) {
      var9 += 35;
    }
  } else {
    var5 = 1;
    var9 = 0;
  }

  var10 = randomintrange(1, var0);

  if(var10 <= var6) {
    level.tierrewardcounts[0]++;
    var11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[0]);
    return var11[0];
  }

  if(var11 <= var8) {
    level.tierrewardcounts[1]++;
    var11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[1]);
    return var11[0];
  }

  if(var11 <= var10) {
    level.tierrewardcounts[2]++;
    var11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[2]);
    return var11[0];
  }

  level.tierrewardcounts[3]++;
  var11 = scripts\engine\utility::array_randomize(level.killstreaktierlist[3]);
  return var11[0];
}

function processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level.killstreaktierlist[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaktierlist[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level.killstreaktierlist[0] = ["uav"];
}

function br_getrewardicon(var0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var0]["hudIcon"];
}

function dropweaponcarepackage(var0) {
  level endon("game_ended");
  var1 = scripts\cp_mp\killstreaks\airdrop::dropcratefrommanualheli(undefined, undefined, "battle_royale", var0, (0, randomfloat(360), 0), 3000, 3000, var0, scripts\cp_mp\killstreaks\airdrop::getbrcratedatabytype("weapon"));

  if(!isDefined(var1)) {
    return undefined;
  } else if(!isDefined(var1.crate)) {
    return undefined;
  }

  return var1.crate;
}

function initdropbagsystem() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.waypointstring["icon_waypoint_marker"] = "DROP_BAG";
  level.dropbagstruct = spawnStruct();
  level.dropbagstruct.clusters = scripts\engine\utility::getStructArray("dropBagCluterNode", "script_noteworthy");
  var0 = scripts\engine\utility::getStructArray("dropBagLocation", "script_noteworthy");

  foreach(var2 in level.dropbagstruct.clusters) {
    var2.droplocations = undefined;
  }

  foreach(var5 in var0) {
    var5.inuse = 0;

    foreach(var2 in level.dropbagstruct.clusters) {
      if(var5.target == var2.targetname) {
        if(!isDefined(var2.droplocations)) {
          var2.droplocations = [];
        }

        var2.droplocations[var2.droplocations.size] = var5;
      }
    }
  }

  terminal_pusher_approach_entrance_array();
}

function terminal_pusher_approach_entrance_array() {
  game["dialog"]["dropbag_incoming"] = "gamestate_dropbag_incoming";
  game["dialog"]["dropbag_available"] = "gamestate_dropbag_available";
}

function ref_1284d(var0) {
  var1 = [];
  var2 = [];
  var3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var4 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var5 = var4;

  if(var5 <= 0) {
    var5 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  }

  var6 = getarraykeys(level.teamdata);

  foreach(var8 in var6) {
    if(level.teamdata[var8]["teamCount"] > 0) {
      var9 = 0;
      var10 = undefined;

      foreach(var12 in level.teamdata[var8]["alivePlayers"]) {
        if(!isDefined(var10) && !istrue(var12.gulag) && !istrue(var12.unset_relic_gun_game)) {
          var10 = var12;
        }

        if(istrue(var12.issquadleader) && !istrue(var12.gulag) && !istrue(var12.unset_relic_gun_game)) {
          var9 = 1;
          var1 = var12;

          if(istrue(var0) && isDefined(level.br_spawns[var12.team].groundorigin)) {
            var2 = level.br_spawns[var12.team].groundorigin;
          } else {
            var2 = var12.origin;
          }

          break;
        }
      }

      if(!var9) {
        if(isDefined(var10)) {
          var12 = var10;
          var1 = var12;

          if(istrue(var0) && isDefined(level.br_spawns[var12.team].groundorigin)) {
            var2 = level.br_spawns[var12.team].groundorigin;
          } else {
            var2 = var12.origin;
          }
        } else if(level.teamdata[var8]["aliveCount"] > 0) {
          var12 = level.teamdata[var8]["alivePlayers"][0];
          var1 = var12;
          var14 = randomfloat(360);
          var15 = randomfloat(var5);
          var16 = var3 + (cos(var14) * var15, sin(var14) * var15, 0);
          var2 = var16;
        }
      }
    }
  }

  var18 = 5;

  if(isDefined(level.dropbagstruct.clusters) && level.dropbagstruct.clusters.size && isDefined(level.dropbagstruct.clusters[0].droplocations)) {
    var18 = level.dropbagstruct.clusters[0].droplocations.size;
    var18 = int(min(var18, 5));
  }

  var19 = getdvarfloat("scr_dropbag_mindist", 3000);
  var20 = getdvarfloat("scr_dropbag_maxdist", 7000);
  var21 = spawnStruct();
  var21.origin = (0, 0, 0);
  var22 = [var21];

  if(isDefined(level.br_level)) {
    if(var4 > 0) {
      var22 = getunusedlootcachepoints(var2, level.dropbagstruct.clusters, level.br_level.br_mapbounds, var19, var20, 2000, var18, 128, var3, var4);
    } else {
      var22 = getunusedlootcachepoints(var2, level.dropbagstruct.clusters, level.br_level.br_mapbounds, var19, var20, 2000, var18, 128);
    }
  }

  if(isDefined(var22)) {
    for(var23 = 0; var23 < var22.size; var23++) {
      var12 = var1[var23];

      if(isDefined(var22[var23].node)) {
        var24 = var22[var23].node;
        var25 = level.dropbagstruct.clusters[var24];
        var26 = var22[var23].index;
        var12.ref_1284b = var25.droplocations[var26].origin;
        continue;
      }

      var12.ref_1284b = var22[var23].origin;
    }

    level.ref_1284c = 1;
    thread ref_1363b(level);
  }

  thread ref_11aaa();
}

function ref_11aaa() {
  level notify("manageDropBags");
  level endon("manageDropBags");
  var0 = -1;
  var1 = getdvarfloat("scr_br_circle_object_cleanup_threshold", 2400);

  for(;;) {
    if(!isDefined(level.br_pickups.crates) || !level.br_pickups.crates.size) {
      var0 = -1;
      wait 1;
      continue;
    }

    var0 = (var0 + 1) % level.br_pickups.crates.size;
    var2 = level.br_pickups.crates[var0];

    if(!isDefined(var2)) {
      level.br_pickups.crates = scripts\engine\utility::array_removeundefined(level.br_pickups.crates);
      waitframe();
      continue;
    }

    if(isDefined(var2.team)) {
      var3 = 0;

      if(isDefined(var2.numuses)) {
        var3 = var2.numuses;
      }

      if(var3 >= level.teamdata[var2.team]["teamCount"]) {
        var2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        waitframe();
        continue;
      }
    }

    var4 = scripts\mp\gametypes\br_circle::getdangercircleradius();

    if(var4 > 0) {
      var5 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
      var6 = distance2dsquared(var2.origin, var5);
      var7 = max(0, var4 + var1);

      if(var6 > var7 * var7) {
        var2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        waitframe();
        continue;
      }
    }

    waitframe();
  }
}

function handlerelicshieldsonlyonkill(var0, var1) {
  var2 = [];

  foreach(var4 in level.br_pickups.crates) {
    if(!isDefined(var4) || !isDefined(var4.team) || var4.team != var0) {
      continue;
    }

    var2 = var4;
  }

  var6 = var2.size - var1;

  if(var6 <= 0) {
    return;
  }

  for(var7 = var6 - 1; var7 >= 0; var7--) {
    var8 = var2[var7];
    var8 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

function ref_1363a(var0, var1, var2) {
  handlerelicshieldsonlyonkill(self.team, 1);
  var3 = 4096;
  var4 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_3", "targetname");
  var5 = (11240, 13287, 9200);
  var6 = scripts\cp_mp\utility\game_utility::unsetchainkillstreaks() && distance2d(var0, var5) < getdvarint("scr_br_island_peak_rad", 7000) && getdvarint("scr_br_island_peak_bag", 1) == 1;

  if(istrue(self.umbra) || isDefined(var4) && distance2d(var0, var4.origin) < 5000 || var6) {
    var3 = 10000;
  }

  var7 = scripts\cp_mp\killstreaks\airdrop::dropbrloadoutcrate(self.team, var0 + (0, 0, var3), var0 + (0, 0, 512));
  var7 endon("death");
  ref_13c47(var7);
  enabledropbagobjective(var7);
  getzeroarray(var7);

  foreach(var9 in level.teamdata[self.team]["alivePlayers"]) {
    if(isDefined(var9) && !var9 scripts\mp\gametypes\br_public::isplayeringulag()) {
      var10 = scripts\engine\utility::ter_op(isDefined(var2), var2, "br_airdrop_incoming");
      var9 thread scripts\mp\hud_message::showsplash(var10);
    }
  }

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_public::dmztut_luicallback("dropbag_incoming", self.team, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::destprogress(self, var0, var1, var7);
    thread setup_minecart(var7);
    thread handlecratehitbymissile(var7);
    return;
  }
}

function setup_minecart() {
  var0 endon("death");
  wait 1;
  var1 = var0 physics_getbodyid(0);

  while(isDefined(var0)) {
    var2 = physics_getbodylinvel(var1);

    if(abs(var2[2]) < 0.01) {
      var3 = [var0];
      var4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
      var5 = scripts\engine\trace::ray_trace(var0.origin + (0, 0, 100), var0.origin + (0, 0, -100), var3, var4);

      if(var5["fraction"] == 1) {
        var0 scripts\cp_mp\killstreaks\airdrop::infinite_chopper(var0.origin, (0, 0, -10));
      } else {
        break;
      }
    }

    wait 0.5;
  }
}

function handlecratehitbymissile(var0) {
  var0 endon("death");
  wait 1;

  if(getdvarint("scr_br_airdrop_missile", 1) == 0) {
    return;
  }

  var1 = var0 physics_getbodyid(0);
  var2 = 0;
  var3 = 0;

  while(isDefined(var0)) {
    var4 = physics_getbodylinvel(var1);
    var5 = length(var4);
    var6 = getdvarint("scr_br_airdrop_missile_vel_stop", 500);

    if(var5 - var2 > var6 || var3 && var5 > var6) {
      var7 = vectorNormalize(var4);
      var8 = var7 * getdvarint("scr_br_airdrop_missile_vel_change", 0);
      physics_setbodyangvel(var1, var8[0], var8[1], var8[2]);
      var9 = physics_getbodyangvel(var1);
      var10 = vectorNormalize(var9);
      var11 = var10 * getdvarint("scr_br_airdrop_missile_ang_vel_change", 0);
      physics_setbodylinangvel(var1, var11[0], var11[1], var11[2]);
      var3 = 1;
    } else {
      var3 = 0;
    }

    var2 = var5;
    waitframe();
  }
}

function ref_1363b(var0) {
  var1 = undefined;

  if(isDefined(level.ref_12931)) {
    var1 = level.ref_12931;
    level.ref_12931 = undefined;
  }

  foreach(var3 in var0) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = var3.ref_1284b;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      var5 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
      var6 = scripts\mp\gametypes\br_circle::getsafecircleradius();

      if(distance2dsquared(var5, var4) > var6 * var6) {
        var7 = vectorNormalize(var4 - var5);
        var8 = var5 + var7 * var6 * 0.95;

        if(isscriptabledefined()) {
          var4 = getclosestpointonnavmesh(var8);
        } else {
          var4 = var8;
        }
      } else if(istrue(level.ref_14089) && isscriptabledefined()) {
        var4 = getclosestpointonnavmesh(var4);
      }

      if(istrue(level.ref_1406f)) {
        var4 = return_enemy_type_mask(var4);
      }

      if(scripts\mp\outofbounds::ispointinoutofbounds(var4)) {
        var5 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
        var8 = scripts\mp\gametypes\br_c130::ref_1342e(var5, var4);

        if(isscriptabledefined()) {
          var4 = getclosestpointonnavmesh(var8);
        } else {
          var4 = var8;
        }
      }
    }

    var9 = relic_punchbullets_fire_fists(1, 0, 0, 0, 0);
    ref_1363a(var3, var4, var9, var1);
    waitframe();
  }
}

function return_enemy_type_mask(var0) {
  if(isDefined(level.minigun_warning_time)) {
    if(!updatesecretstashhud(var0, level.minigun_warning_time)) {
      var1 = relic_bang_and_boom_think(var0, level.minigun_warning_time);

      if(isDefined(var1)) {
        var0 = var1;
      }
    }
  }

  return var0;
}

function updatesecretstashhud(var0, var1) {
  foreach(var3 in var1) {
    if(ispointinvolume(var0, var3)) {
      return true;
    }
  }

  return false;
}

function relic_bang_and_boom_think(var0, var1) {
  var2 = undefined;
  var3 = undefined;
  var4 = (var0[0], var0[1], 0);

  foreach(var6 in var1) {
    var7 = (var6.origin[0], var6.origin[1], 0);
    var8 = var4 - var7;
    var9 = var6.radius / length(var8);
    var8 *= var9;
    var10 = var7 + var8;
    var11 = length(var4 - var10);

    if(!isDefined(var3) || var11 < var3) {
      var2 = var10;
      var3 = var11;
    }
  }

  if(isDefined(var2)) {
    var2 = (var2[0], var2[1], var0[2]);
  }

  return var2;
}

function spawndropbagonlanding() {
  var0 = undefined;
  var0 = findunuseddropbaglocation(self);

  if(!isDefined(var0)) {
    var1 = getdvarfloat("scr_dropbag_mindist", 3000);
    var2 = getdvarfloat("scr_dropbag_maxdist", 7000);
    var0 = calculatedroplocationnearlocation(self, var1, var2);
  }

  if(isDefined(var0)) {
    var3 = relic_punchbullets_fire_fists(0, 0, 0, 1, 0);
    ref_1363a(var0.origin, var3);
    thread ref_11aaa();
    return;
  }
}

function findunuseddropbaglocation(var0) {
  var1 = [];
  var2 = getdvarfloat("scr_dropbag_mindist", 3000);
  var3 = getdvarfloat("scr_dropbag_maxdist", 7000);
  var4 = var2 * var2;
  var5 = var3 * var3;

  foreach(var7 in level.dropbagstruct.clusters) {
    var8 = distance2dsquared(var0.origin, var7.origin);

    if(var8 >= var4 && var8 <= var5) {
      var1 = var7;
    }
  }

  if(var1.size == 0) {
    return undefined;
  }

  var1 = scripts\engine\utility::array_randomize(var1);
  var10 = 0;

  foreach(var7 in var1) {
    var12 = scripts\engine\utility::array_randomize(var7.droplocations);

    foreach(var14 in var12) {
      if(!var14.inuse) {
        var14.inuse = 1;
        return var14;
      }
    }
  }

  return undefined;
}

function ref_13c47(var0) {
  thread ref_13c48(level, var0);
}

function ref_13c48(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  var2 = var1;
  var3 = var1.team;

  for(;;) {
    var0 setotherent(var2);
    var2 waittill("disconnect");
    var4 = undefined;
    var5 = level.teamdata[var3]["players"];

    foreach(var1 in var5) {
      if(isDefined(var2) && var2 == var1) {
        continue;
      }

      var4 = var1;
      break;
    }

    if(!isDefined(var4)) {
      break;
    }

    var2 = var4;
  }
}

function enabledropbagobjective(var0) {
  var0 setscriptablepartstate("objective", "active");
}

function getzeroarray(var0) {
  var0 setscriptablepartstate("model", "choose");
}

function kioskreviveplayer(var0) {
  level endon("game_ended");
  var1 = 0;

  foreach(var3 in var0) {
    var4 = var3 - var1;

    if(var4 > 0) {
      wait var4;
    }

    var1 = var3;
    ref_1284d(0);

    if(level.delay_put_vehicles_on_compass) {
      scripts\mp\gametypes\br_armory_kiosk::ref_13169("supply_drop", 0);
    }
  }
}

function brking_initexternalfeatures() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("dropbag")) {
    return;
  }

  foreach(var1 in level.br_pickups.crates) {
    if(!isDefined(var1) || !isDefined(var1.team) || var1.team != self.team) {
      continue;
    }

    var2 = isDefined(var1.playerscaptured) && isDefined(var1.playerscaptured[self getentitynumber()]);

    if(var2) {
      var1.playerscaptured[self getentitynumber()] = undefined;

      for(var3 = 0; var3 < var1.playersused.size; var3++) {
        if(isDefined(var1.playersused[var3]) && var1.playersused[var3] == self) {
          var1.playersused[var3] = undefined;
        }
      }

      var1.playersused = scripts\engine\utility::array_removeundefined(var1.playersused);
      var1.numuses--;
    }
  }
}

function ref_12072() {
  brking_initexternalfeatures();
}

function relic_punchbullets_fire_fists(var0, var1, var2, var3, var4) {
  if(istrue(var0)) {
    return 0;
  }

  if(istrue(var1)) {
    return 1;
  }

  if(istrue(var2)) {
    return 2;
  }

  if(istrue(var3)) {
    return 3;
  }

  if(istrue(var4)) {
    return 4;
  }

  return -1;
}

function testmissionrewards() {
  runmissionrewarddelivery(level.players[0], level.players[0], undefined, 3);
}

function findclosestdroplocation(var0) {
  var1 = var0 scripts\engine\utility::array_sort_with_func(level.dropbagstruct.clusters, &sortlocationsbydistance);

  foreach(var3 in var1) {
    var4 = scripts\engine\utility::array_randomize(var3.droplocations);

    foreach(var6 in var4) {
      if(!var6.inuse) {
        var6.inuse = 1;
        return var6;
      }
    }
  }

  return undefined;
}

function sortlocationsbydistance(var0, var1) {
  return distancesquared(var0.origin, self.origin) < distancesquared(var1.origin, self.origin);
}

function calculatedroplocationnearlocation(var0, var1, var2) {
  var3 = var0.origin;
  var4 = undefined;
  var5 = undefined;
  var6 = randomint(2);
  var7 = scripts\engine\utility::ter_op(var6, -1, 1);

  if(var7 > 0) {
    var4 = randomfloatrange(var3[0] + var1 * var7, var3[0] + var2 * var7);

    if(var4 >= level.br_level.br_mapbounds[0][0]) {
      var4 = level.br_level.br_mapbounds[0][0] - 250;
    }
  } else {
    var4 = randomfloatrange(var3[0] + var2 * var7, var3[0] + var1 * var7);

    if(var4 <= level.br_level.br_mapbounds[1][0]) {
      var4 = level.br_level.br_mapbounds[1][0] + 250;
    }
  }

  var6 = randomint(2);
  var7 = scripts\engine\utility::ter_op(var6, -1, 1);

  if(var7 > 0) {
    var5 = randomfloatrange(var3[1] + var1 * var7, var3[1] + var2 * var7);

    if(var5 >= level.br_level.br_mapbounds[0][1]) {
      var5 = level.br_level.br_mapbounds[0][1] - 250;
    }
  } else {
    var5 = randomfloatrange(var3[1] + var2 * var7, var3[1] + var1 * var7);

    if(var5 <= level.br_level.br_mapbounds[1][1]) {
      var5 = level.br_level.br_mapbounds[1][1] + 250;
    }
  }

  if(isscriptabledefined()) {
    var8 = getclosestpointonnavmesh((var4, var5, var3[2]));

    if(isDefined(var8)) {
      var9 = spawnStruct();
      var9.origin = var8;
      return var9;
    }
  }

  var9 = spawnStruct();
  var9.origin = (var5, var6, var4[2]);
  return var9;
}

function debugsphereonlocation(var0) {}

function maskobjectivetoplayerssquad(var0, var1) {
  var0.visibilitymanuallycontrolled = 1;
  objective_removeallfrommask(var0.objidnum);

  foreach(var3 in level.squaddata[var1.team][var1.squadindex].players) {
    objective_addclienttomask(var0.objidnum, var3);
  }
}