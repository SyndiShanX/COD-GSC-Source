/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\bradley_spawner.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\gametypes\dom;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace bradley_spawner;

function monitoradd(tank, timeout) {
  tank.script_timeout = timeout;
  level.tanktimeoutlist[level.tanktimeoutlist.size] = tank;
}

function spawntanks(tankstructs, team) {
  level endon("game_ended");
  wait 0.05;

  foreach(tankspawn in tankstructs) {
    if(!isDefined(tankspawn.angles)) {
      tankspawn.angles = (0, 0, 0);
    }

    refill = ter_op(isDefined(tankspawn.script_force_count), tankspawn.script_force_count, 0);
    timeout = ter_op(isDefined(tankspawn.script_timeout), tankspawn.script_timeout, 0);
    level thread spawntankandmonitor(tankspawn.origin, tankspawn.angles, team, refill, timeout);
  }
}

function spawntankandmonitor(origin, angles, team, refill, timeout) {
  level endon("game_ended");
  tank = spawntank(origin, angles, team, timeout, 0);

  if(refill) {
    while(true) {
      tank waittill("death");
      wait 3;
      tank = spawntank(origin, angles, team, timeout, 1);
    }
  }
}

function spawntank(origin, angles, team, timeout, infil) {
  assert(issharedfuncdefined("<dev string:x1c>", "<dev string:x2a>"), "<dev string:x3b>");

  if(!issharedfuncdefined("light_tank", "initSpawnData")) {
    return;
  }

  spawndata = spawnStruct();
  [[getsharedfunc("light_tank", "initSpawnData")]](spawndata);
  spawndata.cantimeout = 0;
  spawndata.spawnmethod = ter_op(istrue(infil), "airdrop_at_position_unsafe", "place_at_position_unsafe");
  spawndata.origin = origin;
  spawndata.angles = angles;
  spawndata.team = team;
  tank = [[getsharedfunc("light_tank", "tankSpawn")]](spawndata);

  if(timeout > 0) {
    monitoradd(tank, timeout);
  }

  return tank;
}

function inittankspawns() {
  level.tankstartspawnallies = getStructArray("tdm_bradley_allies", "targetname");
  level.tankstartspawnaxis = getStructArray("tdm_bradley_axis", "targetname");
  level.tankstartspawnneutral = getStructArray("tdm_bradley_neutral", "targetname");
  level.tankstartspawnalliesdom = getStructArray("dom_bradley_allies", "targetname");
  level.tankstartspawnaxisdom = getStructArray("dom_bradley_axis", "targetname");
  level.tankspawndom_a = getStructArray("dom_bradley_a", "targetname");
  level.tankspawndom_b = getStructArray("dom_bradley_b", "targetname");
  level.tankspawndom_c = getStructArray("dom_bradley_c", "targetname");
  level.tankstartspawnalliescmd = getStructArray("cmd_bradley_allies", "targetname");
  level.tankstartspawnaxiscmd = getStructArray("cmd_bradley_axis", "targetname");
  level.tankspawncmd_2 = getStructArray("cmd_bradley_2", "targetname");
  level.tankspawncmd_3 = getStructArray("cmd_bradley_3", "targetname");
  level.tankspawncmd_1 = getStructArray("cmd_bradley_1", "targetname");

  if(getdvarint(@ "hash_3bfe19e3234d5dff", 0) == 0) {
    return;
  }

  gametypes = ["cmd", "dom", "war", "arm", "conflict", "risk"];
  gameindex = array_find(gametypes, getgametype());

  if(!isDefined(gameindex)) {
    gameindex = gametypes.size;
  }

  for(i = gameindex; i < gametypes.size; i++) {
    testgametype = gametypes[i];

    if(testgametype == "war") {
      if(level.tankstartspawnallies.size != 0 || level.tankstartspawnaxis.size != 0 || level.tankstartspawnneutral.size != 0) {
        spawnstartingbradleystdm();

        if(level.tankstartspawnneutral.size != 0) {
          thread kickoffneutralbradleyspawnstdm();
        }

        break;
      }

      continue;
    }

    if(testgametype == "dom") {
      if(level.tankstartspawnalliesdom.size != 0 || level.tankstartspawnaxisdom.size != 0 || level.tankspawndom_a.size != 0 || level.tankspawndom_b.size != 0 || level.tankspawndom_c.size != 0) {
        thread kickoffneutralbradleyspawnsdom();
        break;
      }

      continue;
    }

    if(testgametype == "cmd") {
      if(level.tankstartspawnalliescmd.size != 0 || level.tankstartspawnaxiscmd.size != 0 || level.tankspawncmd_1.size != 0 || level.tankspawncmd_2.size != 0 || level.tankspawncmd_3.size != 0) {
        spawnstartingbradleyscmd();
        break;
      }
    }
  }
}

function spawnstartingbradleystdm() {
  if(level.tankstartspawnallies.size != 0 && level.tankstartspawnaxis.size != 0) {
    angles = (0, 0, 0);

    if(isDefined(level.tankstartspawnallies[0].angles)) {
      angles = level.tankstartspawnallies[0].angles;
    }

    println("<dev string:xaa>" + level.tankstartspawnallies[0].origin);
    println("<dev string:xdb>" + angles);

    thread spawnbradleynoduration(level.tankstartspawnallies[0].origin, angles, "allies");
    angles = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxis[0].angles)) {
      angles = level.tankstartspawnaxis[0].angles;
    }

    println("<dev string:x10c>" + level.tankstartspawnaxis[0].origin);
    println("<dev string:x13b>" + angles);

    thread spawnbradleynoduration(level.tankstartspawnaxis[0].origin, angles, "axis");
  }
}

function spawnstartingbradleysdom() {
  if(level.tankstartspawnalliesdom.size != 0 && level.tankstartspawnaxisdom.size != 0) {
    var_7e4886c52a1bc723 = (0, 0, 0);
    allyorigin = (0, 0, 0);
    var_76fd430e3623fb30 = (0, 0, 0);
    axisorigin = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliesdom[0].angles)) {
      var_7e4886c52a1bc723 = level.tankstartspawnalliesdom[0].angles;
    }

    allyorigin = level.tankstartspawnalliesdom[0].origin;
    println("<dev string:x16a>" + level.tankstartspawnalliesdom[0].origin);

    if(isDefined(level.tankstartspawnaxisdom[0].angles)) {
      var_76fd430e3623fb30 = level.tankstartspawnaxisdom[0].angles;
    }

    axisorigin = level.tankstartspawnaxisdom[0].origin;
    println("<dev string:x19e>" + level.tankstartspawnaxisdom[0].origin);

    if(game["switchedsides"]) {
      thread spawnbradleynoduration(axisorigin, var_76fd430e3623fb30, "allies");
      thread spawnbradleynoduration(allyorigin, var_7e4886c52a1bc723, "axis");
      return;
    }

    thread spawnbradleynoduration(axisorigin, var_76fd430e3623fb30, "axis");
    thread spawnbradleynoduration(allyorigin, var_7e4886c52a1bc723, "allies");
  }
}

function spawnstartingbradleyscmd() {
  if(level.tankstartspawnalliescmd.size != 0 && level.tankstartspawnaxiscmd.size != 0) {
    angles = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliescmd[0].angles)) {
      angles = level.tankstartspawnalliescmd[0].angles;
    }

    println("<dev string:x1d0>" + level.tankstartspawnalliescmd[0].origin);
    println("<dev string:x204>" + angles);

    thread spawnbradleynoduration(level.tankstartspawnalliescmd[0].origin, angles, "allies");
    angles = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxiscmd[0].angles)) {
      angles = level.tankstartspawnaxiscmd[0].angles;
    }

    println("<dev string:x238>" + level.tankstartspawnaxiscmd[0].origin);
    println("<dev string:x26a>" + angles);

    thread spawnbradleynoduration(level.tankstartspawnaxiscmd[0].origin, angles, "axis");
  }
}

function kickoffneutralbradleyspawnstdm() {
  level endon("game_ended");
  wait 12;
  tankspawn = random(level.tankstartspawnneutral);
  angles = (0, 0, 0);

  if(isDefined(tankspawn.angles)) {
    angles = tankspawn.angles;
  }

  println("<dev string:x29c>" + tankspawn.origin);
  println("<dev string:x2bb>" + angles);

  thread spawnbradleynoduration(tankspawn.origin, angles);
  timelimit = gettimelimit();
  timelimitmin = timelimit / 3;
  spawntime = max(timelimitmin, 180);
  spawntime = min(spawntime, 240);

  while(true) {
    wait spawntime;

    if(vehicle_tracking_getgameinstances("light_tank").size < 2) {
      tankspawn = selectneutralspawn();
      thread spawnbradleynoduration(tankspawn.origin, tankspawn.angles);
    }
  }
}

function kickoffneutralbradleyspawnsdom() {
  level endon("game_ended");
  wait 60;
  timelimit = gettimelimit();
  timelimitmin = timelimit / 3;
  spawntime = max(timelimitmin, 180);
  spawntime = min(spawntime, 240);

  while(true) {
    wait spawntime;

    if(vehicle_tracking_getgameinstances("light_tank").size < 2) {
      dompt = selectdomspawn();

      if(!isDefined(dompt)) {
        dompt = delayspawnuntilpointcap();
      }

      spawndombradley(dompt);
    }
  }
}

function spawndombradley(dompt) {
  if(dompt.objectivekey == "_a") {
    tankspawn = random(level.tankspawndom_a);
  } else if(dompt.objectivekey == "_b") {
    tankspawn = random(level.tankspawndom_b);
  } else {
    tankspawn = random(level.tankspawndom_c);
  }

  if(isDefined(tankspawn)) {
    angles = (0, 0, 0);

    if(isDefined(tankspawn.angles)) {
      angles = tankspawn.angles;
    }

    thread spawnbradleynoduration(tankspawn.origin, angles);
  }
}

function tryspawnneutralbradleycmd(point) {
  if(vehicle_tracking_getgameinstances("light_tank").size < 2) {
    if(point == 1) {
      if(level.tankspawncmd_1.size != 0) {
        angles = (0, 0, 0);
        tankspawn = random(level.tankspawncmd_1);

        if(isDefined(tankspawn.angles)) {
          angles = tankspawn.angles;
        }

        thread spawnbradleynoduration(tankspawn.origin, angles, "allies");
      }

      return;
    }

    if(point == 2) {
      if(level.tankspawncmd_2.size != 0) {
        angles = (0, 0, 0);
        tankspawn = random(level.tankspawncmd_2);

        if(isDefined(tankspawn.angles)) {
          angles = tankspawn.angles;
        }

        thread spawnbradleynoduration(tankspawn.origin, angles, "allies");
      }

      return;
    }

    if(point == 3) {
      if(level.tankspawncmd_3.size != 0) {
        angles = (0, 0, 0);
        tankspawn = random(level.tankspawncmd_3);

        if(isDefined(tankspawn.angles)) {
          angles = tankspawn.angles;
        }

        thread spawnbradleynoduration(tankspawn.origin, angles, "allies");
      }
    }
  }
}

function delayspawnuntilpointcap() {
  level endon("game_ended");

  while(true) {
    wait 3;
    dompt = selectdomspawn();

    if(isDefined(dompt)) {
      return dompt;
    }
  }
}

function selectneutralspawn() {
  tankspawn = random(level.tankstartspawnneutral);
  return tankspawn;
}

function selectdomspawn() {
  allypoints = scripts\mp\gametypes\dom::getteamdompoints("allies");
  axispoints = scripts\mp\gametypes\dom::getteamdompoints("axis");
  neutralpoints = scripts\mp\gametypes\dom::getteamdompoints("neutral");

  if(allypoints.size == 3 || axispoints.size == 3) {
    return undefined;
  } else if(allypoints.size < axispoints.size) {
    if(allypoints.size == 0) {
      return neutralpoints[0];
    }

    return allypoints[0];
  } else if(allypoints.size > axispoints.size) {
    if(axispoints.size == 0) {
      return neutralpoints[0];
    }

    return axispoints[0];
  }

  return undefined;
}

function spawnbradleynoduration(position, angles, team) {
  assert(issharedfuncdefined("<dev string:x1c>", "<dev string:x2a>"), "<dev string:x3b>");

  if(!issharedfuncdefined("light_tank", "initSpawnData")) {
    return;
  }

  spawndata = spawnStruct();
  [[getsharedfunc("light_tank", "initSpawnData")]](spawndata);
  spawndata.cantimeout = 0;
  spawndata.spawnmethod = "airdrop_at_position";
  spawndata.origin = position;
  spawndata.angles = angles;
  spawndata.team = team;
  tank = [[getsharedfunc("light_tank", "tankSpawn")]](spawndata);
}