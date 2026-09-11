/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\bradley_spawner.gsc
****************************************************/

function inittankspawnsplaced() {
  if(getdvarint("scr_allow_vehicles", 0) <= 0) {
    return;
  }

  var0 = scripts\engine\utility::getStructArray("veh_bromeo_neutral", "targetname");
  var1 = scripts\engine\utility::getStructArray("veh_bromeo_allies", "targetname");
  var2 = scripts\engine\utility::getStructArray("veh_bromeo_axis", "targetname");
  level.tanktimeoutlist = [];
  spawntanks(var0);
  spawntanks(var1, "allies");
  spawntanks(var2, "axis");
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

  foreach(var1 in level.tanktimeoutlist) {
    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var1);
    var3 = isDefined(var2) && var2.size > 0;

    if(!isDefined(var1.timeoutwasoccupied)) {
      if(var3) {
        var1.timeoutwasoccupied = 1;
      }

      continue;
    }

    if(isDefined(var1.timeouttime)) {
      if(var3) {
        var1.timeouttime = undefined;
      } else if(var1.timeouttime <= gettime()) {
        var1 thread scripts\cp_mp\vehicles\light_tank::light_tank_explode();
      }

      continue;
    }

    if(!var3) {
      var1.timeouttime = gettime() + var1.script_timeout * 1000;
    }
  }
}

function monitoradd(var0, var1) {
  var0.script_timeout = var1;
  level.tanktimeoutlist[level.tanktimeoutlist.size] = var0;
}

function spawntanks(var0, var1) {
  level endon("game_ended");
  wait 0.05;

  foreach(var3 in var0) {
    if(!isDefined(var3.angles)) {
      var3.angles = (0, 0, 0);
    }

    var4 = scripts\engine\utility::ter_op(isDefined(var3.script_force_count), var3.script_force_count, 0);
    var5 = scripts\engine\utility::ter_op(isDefined(var3.script_timeout), var3.script_timeout, 0);
    thread spawntankandmonitor(level, var3.origin, var3.angles, var1, var4);
  }
}

function spawntankandmonitor(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  var5 = spawntank(var0, var1, var2, var4, 0);

  if(var3) {
    for(;;) {
      var5 waittill("death");
      wait 3;
      var5 = spawntank(var0, var1, var2, var4, 1);
    }

    return;
  }
}

function spawntank(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var5);
  var5.cantimeout = 0;
  var5.spawnmethod = scripts\engine\utility::ter_op(istrue(var4), "airdrop_at_position_unsafe", "place_at_position_unsafe");
  var5.origin = var0;
  var5.angles = var1;
  var5.team = var2;
  var6 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var5);

  if(var3 > 0) {
    monitoradd(var6, var3);
  }

  return var6;
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

  var0 = ["cmd", "dom", "war", "arm"];
  var1 = scripts\engine\utility::array_find(var0, scripts\mp\utility\game::getgametype());

  if(!isDefined(var1)) {
    var1 = var0.size;
  }

  for(var2 = var1; var2 < var0.size; var2++) {
    var3 = var0[var2];

    if(var3 == "war") {
      if(level.tankstartspawnallies.size != 0 || level.tankstartspawnaxis.size != 0 || level.tankstartspawnneutral.size != 0) {
        spawnstartingbradleystdm();

        if(level.tankstartspawnneutral.size != 0) {
          thread kickoffneutralbradleyspawnstdm();
        }

        break;
      }

      continue;
    }

    if(var3 == "dom") {
      if(level.tankstartspawnalliesdom.size != 0 || level.tankstartspawnaxisdom.size != 0 || level.tankspawndom_a.size != 0 || level.tankspawndom_b.size != 0 || level.tankspawndom_c.size != 0) {
        thread kickoffneutralbradleyspawnsdom();
        break;
      }

      continue;
    }

    if(var3 == "cmd") {
      if(level.tankstartspawnalliescmd.size != 0 || level.tankstartspawnaxiscmd.size != 0 || level.tankspawncmd_1.size != 0 || level.tankspawncmd_2.size != 0 || level.tankspawncmd_3.size != 0) {
        spawnstartingbradleyscmd();
        break;
      }
    }
  }
}

function spawnstartingbradleystdm() {
  if(level.tankstartspawnallies.size != 0 && level.tankstartspawnaxis.size != 0) {
    var0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnallies[0].angles)) {
      var0 = level.tankstartspawnallies[0].angles;
    }

    thread spawnbradleynoduration(level.tankstartspawnallies[0].origin, var0, "allies");
    var0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxis[0].angles)) {
      var0 = level.tankstartspawnaxis[0].angles;
    }

    thread spawnbradleynoduration(level.tankstartspawnaxis[0].origin, var0, "axis");
    return;
  }
}

function spawnstartingbradleysdom() {
  if(level.tankstartspawnalliesdom.size != 0 && level.tankstartspawnaxisdom.size != 0) {
    var0 = (0, 0, 0);
    var1 = (0, 0, 0);
    var2 = (0, 0, 0);
    var3 = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliesdom[0].angles)) {
      var0 = level.tankstartspawnalliesdom[0].angles;
    }

    var1 = level.tankstartspawnalliesdom[0].origin;

    if(isDefined(level.tankstartspawnaxisdom[0].angles)) {
      var2 = level.tankstartspawnaxisdom[0].angles;
    }

    var3 = level.tankstartspawnaxisdom[0].origin;

    if(game["switchedsides"]) {
      thread spawnbradleynoduration(var3, var2, "allies");
      thread spawnbradleynoduration(var1, var0, "axis");
      return;
    }

    thread spawnbradleynoduration(var3, var2, "axis");
    thread spawnbradleynoduration(var1, var0, "allies");
    return;
  }
}

function spawnstartingbradleyscmd() {
  if(level.tankstartspawnalliescmd.size != 0 && level.tankstartspawnaxiscmd.size != 0) {
    var0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliescmd[0].angles)) {
      var0 = level.tankstartspawnalliescmd[0].angles;
    }

    thread spawnbradleynoduration(level.tankstartspawnalliescmd[0].origin, var0, "allies");
    var0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxiscmd[0].angles)) {
      var0 = level.tankstartspawnaxiscmd[0].angles;
    }

    thread spawnbradleynoduration(level.tankstartspawnaxiscmd[0].origin, var0, "axis");
    return;
  }
}

function kickoffneutralbradleyspawnstdm() {
  level endon("game_ended");
  wait 12;
  var0 = scripts\engine\utility::random(level.tankstartspawnneutral);
  var1 = (0, 0, 0);

  if(isDefined(var0.angles)) {
    var1 = var0.angles;
  }

  thread spawnbradleynoduration(var0.origin, var1);
  var2 = scripts\mp\utility\game::gettimelimit();
  var3 = var2 / 3;
  var4 = max(var3, 180);
  var4 = min(var4, 240);

  for(;;) {
    wait var4;

    if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank").size < 2) {
      var0 = selectneutralspawn();
      thread spawnbradleynoduration(var0.origin, var0.angles);
    }
  }
}

function kickoffneutralbradleyspawnsdom() {
  level endon("game_ended");
  wait 60;
  var0 = scripts\mp\utility\game::gettimelimit();
  var1 = var0 / 3;
  var2 = max(var1, 180);
  var2 = min(var2, 240);

  for(;;) {
    wait var2;

    if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank").size < 2) {
      var3 = selectdomspawn();

      if(!isDefined(var3)) {
        var3 = delayspawnuntilpointcap();
      }

      spawndombradley(var3);
    }
  }
}

function spawndombradley(var0) {
  if(var0.objectivekey == "_a") {
    var1 = scripts\engine\utility::random(level.tankspawndom_a);
  } else if(var1.objectivekey == "_b") {
    var1 = scripts\engine\utility::random(level.tankspawndom_b);
  } else {
    var1 = scripts\engine\utility::random(level.tankspawndom_c);
  }

  if(isDefined(var1)) {
    var2 = (0, 0, 0);

    if(isDefined(var1.angles)) {
      var2 = var1.angles;
    }

    thread spawnbradleynoduration(var1.origin, var2);
    return;
  }
}

function tryspawnneutralbradleycmd(var0) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank").size < 2) {
    if(var0 == 1) {
      if(level.tankspawncmd_1.size != 0) {
        var1 = (0, 0, 0);
        var2 = scripts\engine\utility::random(level.tankspawncmd_1);

        if(isDefined(var2.angles)) {
          var1 = var2.angles;
        }

        thread spawnbradleynoduration(var2.origin, var1, "allies");
        return;
      }

      return;
    }

    if(var2 == 2) {
      if(level.tankspawncmd_2.size != 0) {
        var1 = (0, 0, 0);
        var2 = scripts\engine\utility::random(level.tankspawncmd_2);

        if(isDefined(var2.angles)) {
          var1 = var2.angles;
        }

        thread spawnbradleynoduration(var2.origin, var1, "allies");
        return;
      }

      return;
    }

    if(var2 == 3) {
      if(level.tankspawncmd_3.size != 0) {
        var1 = (0, 0, 0);
        var2 = scripts\engine\utility::random(level.tankspawncmd_3);

        if(isDefined(var2.angles)) {
          var1 = var2.angles;
        }

        thread spawnbradleynoduration(var2.origin, var1, "allies");
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
    var0 = selectdomspawn();

    if(isDefined(var0)) {
      return var0;
    }
  }
}

function selectneutralspawn() {
  var0 = scripts\engine\utility::random(level.tankstartspawnneutral);
  return var0;
}

function selectdomspawn() {
  var0 = scripts\mp\gametypes\dom::getteamdompoints("allies");
  var1 = scripts\mp\gametypes\dom::getteamdompoints("axis");
  var2 = scripts\mp\gametypes\dom::getteamdompoints("neutral");

  if(var0.size == 3 || var1.size == 3) {
    return undefined;
  } else if(var0.size < var1.size) {
    if(var0.size == 0) {
      return var2[0];
    }

    return var0[0];
  } else if(var0.size > var1.size) {
    if(var1.size == 0) {
      return var2[0];
    }

    return var1[0];
  }

  return undefined;
}

function spawnbradleynoduration(var0, var1, var2) {
  var3 = spawnStruct();
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var3);
  var3.cantimeout = 0;
  var3.spawnmethod = "airdrop_at_position";
  var3.origin = var0;
  var3.angles = var1;
  var3.team = var2;
  var4 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var3);
}