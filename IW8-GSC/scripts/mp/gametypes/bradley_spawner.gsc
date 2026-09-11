/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\bradley_spawner.gsc
****************************************************/

function inittankspawnsplaced() {
  if(getdvarint("scr_allow_vehicles", 0) <= 0) {
    return;
  }

  var_0 = scripts\engine\utility::getStructArray("veh_bromeo_neutral", "targetname");
  var_1 = scripts\engine\utility::getStructArray("veh_bromeo_allies", "targetname");
  var_2 = scripts\engine\utility::getStructArray("veh_bromeo_axis", "targetname");
  level.tanktimeoutlist = [];
  spawntanks(var_0);
  spawntanks(var_1, "allies");
  spawntanks(var_2, "axis");
  thread monitortimeout();
}

function monitortimeout() {
  level endon("game_ended");

  for(;;) {
    monitortimeoutupdate();
    wait 0.05;
  }
}

function monitortimeoutupdate() {
  level.tanktimeoutlist = scripts\engine\utility::array_removeundefined(level.tanktimeoutlist);

  foreach(var_1 in level.tanktimeoutlist) {
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_1);
    var_3 = isDefined(var_2) && var_2.size > 0;

    if(!isDefined(var_1.timeoutwasoccupied)) {
      if(var_3) {
        var_1.timeoutwasoccupied = 1;
      }

      continue;
    }

    if(isDefined(var_1.timeouttime)) {
      if(var_3) {
        var_1.timeouttime = undefined;
      } else if(var_1.timeouttime <= gettime()) {
        var_1 thread scripts\cp_mp\vehicles\light_tank::light_tank_explode();
      }

      continue;
    }

    if(!var_3) {
      var_1.timeouttime = gettime() + var_1.script_timeout * 1000;
    }
  }
}

function monitoradd(var_0, var_1) {
  var_0.script_timeout = var_1;
  level.tanktimeoutlist[level.tanktimeoutlist.size] = var_0;
}

function spawntanks(var_0, var_1) {
  level endon("game_ended");
  wait 0.05;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }

    var_4 = scripts\engine\utility::ter_op(isDefined(var_3.script_force_count), var_3.script_force_count, 0);
    var_5 = scripts\engine\utility::ter_op(isDefined(var_3.script_timeout), var_3.script_timeout, 0);
    thread spawntankandmonitor(level, var_3.origin, var_3.angles, var_1, var_4);
  }
}

function spawntankandmonitor(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_5 = spawntank(var_0, var_1, var_2, var_4, 0);

  if(var_3) {
    for(;;) {
      var_5 waittill("death");
      wait 3;
      var_5 = spawntank(var_0, var_1, var_2, var_4, 1);
    }

    return;
  }
}

function spawntank(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_5);
  var_5.cantimeout = 0;
  var_5.spawnmethod = scripts\engine\utility::ter_op(istrue(var_4), "airdrop_at_position_unsafe", "place_at_position_unsafe");
  var_5.origin = var_0;
  var_5.angles = var_1;
  var_5.team = var_2;
  var_6 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_5);

  if(var_3 > 0) {
    monitoradd(var_6, var_3);
  }

  return var_6;
}

function inittankspawns() {
  level.tankstartspawnallies = scripts\engine\utility::getStructArray("tdm_bradley_allies", "targetname");
  level.tankstartspawnaxis = scripts\engine\utility::getStructArray("tdm_bradley_axis", "targetname");
  level.tankstartspawnneutral = scripts\engine\utility::getStructArray("tdm_bradley_neutral", "targetname");
  level.tankstartspawnalliesdom = scripts\engine\utility::getStructArray("dom_bradley_allies", "targetname");
  level.tankstartspawnaxisdom = scripts\engine\utility::getStructArray("dom_bradley_axis", "targetname");
  level.tankspawndom_a = scripts\engine\utility::getStructArray("dom_bradley_a", "targetname");
  level.tankspawndom_b = scripts\engine\utility::getStructArray("dom_bradley_b", "targetname");
  level.tankspawndom_c = scripts\engine\utility::getStructArray("dom_bradley_c", "targetname");
  level.tankstartspawnalliescmd = scripts\engine\utility::getStructArray("cmd_bradley_allies", "targetname");
  level.tankstartspawnaxiscmd = scripts\engine\utility::getStructArray("cmd_bradley_axis", "targetname");
  level.tankspawncmd_2 = scripts\engine\utility::getStructArray("cmd_bradley_2", "targetname");
  level.tankspawncmd_3 = scripts\engine\utility::getStructArray("cmd_bradley_3", "targetname");
  level.tankspawncmd_1 = scripts\engine\utility::getStructArray("cmd_bradley_1", "targetname");

  if(getdvarint("scr_bradley_spawner", 0) == 0) {
    return;
  }

  var_0 = ["cmd", "dom", "war", "arm"];
  var_1 = scripts\engine\utility::array_find(var_0, scripts\mp\utility\game::getgametype());

  if(!isDefined(var_1)) {
    var_1 = var_0.size;
  }

  for(var_2 = var_1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(var_3 == "war") {
      if(level.tankstartspawnallies.size != 0 || level.tankstartspawnaxis.size != 0 || level.tankstartspawnneutral.size != 0) {
        spawnstartingbradleystdm();

        if(level.tankstartspawnneutral.size != 0) {
          thread kickoffneutralbradleyspawnstdm();
        }

        break;
      }

      continue;
    }

    if(var_3 == "dom") {
      if(level.tankstartspawnalliesdom.size != 0 || level.tankstartspawnaxisdom.size != 0 || level.tankspawndom_a.size != 0 || level.tankspawndom_b.size != 0 || level.tankspawndom_c.size != 0) {
        thread kickoffneutralbradleyspawnsdom();
        break;
      }

      continue;
    }

    if(var_3 == "cmd") {
      if(level.tankstartspawnalliescmd.size != 0 || level.tankstartspawnaxiscmd.size != 0 || level.tankspawncmd_1.size != 0 || level.tankspawncmd_2.size != 0 || level.tankspawncmd_3.size != 0) {
        spawnstartingbradleyscmd();
        break;
      }
    }
  }
}

function spawnstartingbradleystdm() {
  if(level.tankstartspawnallies.size != 0 && level.tankstartspawnaxis.size != 0) {
    var_0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnallies[0].angles)) {
      var_0 = level.tankstartspawnallies[0].angles;
    }

    thread spawnbradleynoduration(level.tankstartspawnallies[0].origin, var_0, "allies");
    var_0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxis[0].angles)) {
      var_0 = level.tankstartspawnaxis[0].angles;
    }

    thread spawnbradleynoduration(level.tankstartspawnaxis[0].origin, var_0, "axis");
    return;
  }
}

function spawnstartingbradleysdom() {
  if(level.tankstartspawnalliesdom.size != 0 && level.tankstartspawnaxisdom.size != 0) {
    var_0 = (0, 0, 0);
    var_1 = (0, 0, 0);
    var_2 = (0, 0, 0);
    var_3 = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliesdom[0].angles)) {
      var_0 = level.tankstartspawnalliesdom[0].angles;
    }

    var_1 = level.tankstartspawnalliesdom[0].origin;

    if(isDefined(level.tankstartspawnaxisdom[0].angles)) {
      var_2 = level.tankstartspawnaxisdom[0].angles;
    }

    var_3 = level.tankstartspawnaxisdom[0].origin;

    if(game["switchedsides"]) {
      thread spawnbradleynoduration(var_3, var_2, "allies");
      thread spawnbradleynoduration(var_1, var_0, "axis");
      return;
    }

    thread spawnbradleynoduration(var_3, var_2, "axis");
    thread spawnbradleynoduration(var_1, var_0, "allies");
    return;
  }
}

function spawnstartingbradleyscmd() {
  if(level.tankstartspawnalliescmd.size != 0 && level.tankstartspawnaxiscmd.size != 0) {
    var_0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliescmd[0].angles)) {
      var_0 = level.tankstartspawnalliescmd[0].angles;
    }

    thread spawnbradleynoduration(level.tankstartspawnalliescmd[0].origin, var_0, "allies");
    var_0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxiscmd[0].angles)) {
      var_0 = level.tankstartspawnaxiscmd[0].angles;
    }

    thread spawnbradleynoduration(level.tankstartspawnaxiscmd[0].origin, var_0, "axis");
    return;
  }
}

function kickoffneutralbradleyspawnstdm() {
  level endon("game_ended");
  wait 12;
  var_0 = scripts\engine\utility::random(level.tankstartspawnneutral);
  var_1 = (0, 0, 0);

  if(isDefined(var_0.angles)) {
    var_1 = var_0.angles;
  }

  thread spawnbradleynoduration(var_0.origin, var_1);
  var_2 = scripts\mp\utility\game::gettimelimit();
  var_3 = var_2 / 3;
  var_4 = max(var_3, 180);
  var_4 = min(var_4, 240);

  for(;;) {
    wait var_4;

    if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank").size < 2) {
      var_0 = selectneutralspawn();
      thread spawnbradleynoduration(var_0.origin, var_0.angles);
    }
  }
}

function kickoffneutralbradleyspawnsdom() {
  level endon("game_ended");
  wait 60;
  var_0 = scripts\mp\utility\game::gettimelimit();
  var_1 = var_0 / 3;
  var_2 = max(var_1, 180);
  var_2 = min(var_2, 240);

  for(;;) {
    wait var_2;

    if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank").size < 2) {
      var_3 = selectdomspawn();

      if(!isDefined(var_3)) {
        var_3 = delayspawnuntilpointcap();
      }

      spawndombradley(var_3);
    }
  }
}

function spawndombradley(var_0) {
  if(var_0.objectivekey == "_a") {
    var_1 = scripts\engine\utility::random(level.tankspawndom_a);
  } else if(var_1.objectivekey == "_b") {
    var_1 = scripts\engine\utility::random(level.tankspawndom_b);
  } else {
    var_1 = scripts\engine\utility::random(level.tankspawndom_c);
  }

  if(isDefined(var_1)) {
    var_2 = (0, 0, 0);

    if(isDefined(var_1.angles)) {
      var_2 = var_1.angles;
    }

    thread spawnbradleynoduration(var_1.origin, var_2);
    return;
  }
}

function tryspawnneutralbradleycmd(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank").size < 2) {
    if(var_0 == 1) {
      if(level.tankspawncmd_1.size != 0) {
        var_1 = (0, 0, 0);
        var_2 = scripts\engine\utility::random(level.tankspawncmd_1);

        if(isDefined(var_2.angles)) {
          var_1 = var_2.angles;
        }

        thread spawnbradleynoduration(var_2.origin, var_1, "allies");
        return;
      }

      return;
    }

    if(var_2 == 2) {
      if(level.tankspawncmd_2.size != 0) {
        var_1 = (0, 0, 0);
        var_2 = scripts\engine\utility::random(level.tankspawncmd_2);

        if(isDefined(var_2.angles)) {
          var_1 = var_2.angles;
        }

        thread spawnbradleynoduration(var_2.origin, var_1, "allies");
        return;
      }

      return;
    }

    if(var_2 == 3) {
      if(level.tankspawncmd_3.size != 0) {
        var_1 = (0, 0, 0);
        var_2 = scripts\engine\utility::random(level.tankspawncmd_3);

        if(isDefined(var_2.angles)) {
          var_1 = var_2.angles;
        }

        thread spawnbradleynoduration(var_2.origin, var_1, "allies");
        return;
      }

      return;
    }

    return;
  }
}

function delayspawnuntilpointcap() {
  level endon("game_ended");

  for(;;) {
    wait 3;
    var_0 = selectdomspawn();

    if(isDefined(var_0)) {
      return var_0;
    }
  }
}

function selectneutralspawn() {
  var_0 = scripts\engine\utility::random(level.tankstartspawnneutral);
  return var_0;
}

function selectdomspawn() {
  var_0 = scripts\mp\gametypes\dom::getteamdompoints("allies");
  var_1 = scripts\mp\gametypes\dom::getteamdompoints("axis");
  var_2 = scripts\mp\gametypes\dom::getteamdompoints("neutral");

  if(var_0.size == 3 || var_1.size == 3) {
    return undefined;
  } else if(var_0.size < var_1.size) {
    if(var_0.size == 0) {
      return var_2[0];
    }

    return var_0[0];
  } else if(var_0.size > var_1.size) {
    if(var_1.size == 0) {
      return var_2[0];
    }

    return var_1[0];
  }

  return undefined;
}

function spawnbradleynoduration(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_3);
  var_3.cantimeout = 0;
  var_3.spawnmethod = "airdrop_at_position";
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.team = var_2;
  var_4 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var_3);
}