/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\bradley_spawner.gsc
***********************************************/

inittankspawnsplaced() {
  if(getdvarint("_encstr_87EF136FB8EBF7BA6981651B6035B298D010ABBFA0", 0) <= 0) {
    return;
  }
  var_0 = scripts\engine\utility::getStructArray("_encstr_95491367B20DD7989CB75B95DE7D7356EA474E2C1B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStructArray("_encstr_BE62127393DB58DBA8BADDCF6DE9DEB4F8601D66", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStructArray("_encstr_BA0510D9CA43D78939DBDAB27BF5B0879637", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tanktimeoutlist = [];
  spawntanks(var_0);
  spawntanks(var_1, "_encstr_9A8507BA4040188D08");
  spawntanks(var_2, "_encstr_8E8405EA382B2A");
  level thread monitortimeout();
}

monitortimeout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    monitortimeoutupdate();
    wait 0.05;
  }
}

monitortimeoutupdate() {
  level.tanktimeoutlist = scripts\engine\utility::array_removeundefined(level.tanktimeoutlist);

  foreach(var_1 in level.tanktimeoutlist) {
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_1);
    var_3 = isDefined(var_2) && var_2.size > 0;

    if(!isDefined(var_1.timeoutwasoccupied)) {
      if(var_3)
        var_1.timeoutwasoccupied = 1;

      continue;
    }

    if(isDefined(var_1.timeouttime)) {
      if(var_3)
        var_1.timeouttime = undefined;
      else if(var_1.timeouttime <= gettime())
        var_1 thread scripts\cp_mp\vehicles\light_tank::light_tank_explode();

      continue;
    }

    if(!var_3)
      var_1.timeouttime = gettime() + var_1.script_timeout * 1000;
  }
}

monitoradd(var_0, var_1) {
  var_0.script_timeout = var_1;
  level.tanktimeoutlist[level.tanktimeoutlist.size] = var_0;
}

spawntanks(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.05;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.angles))
      var_3.angles = (0, 0, 0);

    var_4 = scripts\engine\utility::ter_op(isDefined(var_3.script_force_count), var_3.script_force_count, 0);
    var_5 = scripts\engine\utility::ter_op(isDefined(var_3.script_timeout), var_3.script_timeout, 0);
    level thread spawntankandmonitor(var_3.origin, var_3.angles, var_1, var_4, var_5);
  }
}

spawntankandmonitor(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 = spawntank(var_0, var_1, var_2, var_4, 0);

  if(var_3) {
    for(;;) {
      var_5 waittill("_encstr_AD75063D571AE108");
      wait 3.0;
      var_5 = spawntank(var_0, var_1, var_2, var_4, 1);
    }
  }
}

spawntank(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_5);
  var_5.cantimeout = 0;
  var_5.spawnmethod = scripts\engine\utility::ter_op(istrue(var_4), "_encstr_8A9A1B47D79A98B327BBE769254F29652A63A3D730A2C78D5DFFBFEC55", "_encstr_B813195051C942790FB923A7D920974723C3159399431857D9BFB5");
  var_5.origin = var_0;
  var_5.angles = var_1;
  var_5.team = var_2;
  var_6 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_5);

  if(var_3 > 0)
    monitoradd(var_6, var_3);

  return var_6;
}

inittankspawns() {
  level.tankstartspawnallies = scripts\engine\utility::getStructArray("_encstr_AD3013A323ADF598C9C232B12B97D7B06336D2ACE6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankstartspawnaxis = scripts\engine\utility::getStructArray("_encstr_9A1811A38CB6D7C427B01936CAE5D70BC3D26E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankstartspawnneutral = scripts\engine\utility::getStructArray("_encstr_962914A1B07A89A0725121ACEFBFAE7213C39B2AB16C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankstartspawnalliesdom = scripts\engine\utility::getStructArray("_encstr_B8F51370A20DE711AB095D41E56F7E63B57A80F0DB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankstartspawnaxisdom = scripts\engine\utility::getStructArray("_encstr_91A31119BF9531F60BAA3920F27F20886801BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankspawndom_a = scripts\engine\utility::getStructArray("_encstr_ACC00E2198BB07812D338F73E1A8964F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankspawndom_b = scripts\engine\utility::getStructArray("_encstr_BEC00EC0273561E2EBC2DA5CF8DBBFDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankspawndom_c = scripts\engine\utility::getStructArray("_encstr_8EC00E034F3979EA10516F75C9900F72", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankstartspawnalliescmd = scripts\engine\utility::getStructArray("_encstr_A5B713F9D9F108C53379B019355F6E0B7AF2793BCF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankstartspawnaxiscmd = scripts\engine\utility::getStructArray("_encstr_BDAC113ED5CA37C9F2FF5008F721A683B37CAE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankspawncmd_2 = scripts\engine\utility::getStructArray("_encstr_9B230E3649EA48061B9F491803915F7A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankspawncmd_3 = scripts\engine\utility::getStructArray("_encstr_83230E4713F531A22899B7BD3158D74F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.tankspawncmd_1 = scripts\engine\utility::getStructArray("_encstr_86230E9FB301E17043D92A717F90A1C7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(getdvarint("_encstr_84941453788589D31BFF2C2C85025FCAE9F09B3AE05D", 0) == 0) {
    return;
  }
  var_0 = ["_encstr_9719046E3182", "_encstr_8218041DF5FA", "_encstr_B41904BB8593", "_encstr_B81904B04E6B"];
  var_1 = scripts\engine\utility::array_find(var_0, scripts\mp\utility\game::getgametype());

  if(!isDefined(var_1))
    var_1 = var_0.size;

  for(var_2 = var_1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(var_3 == "_encstr_B41904BB8593") {
      if(level.tankstartspawnallies.size != 0 || level.tankstartspawnaxis.size != 0 || level.tankstartspawnneutral.size != 0) {
        spawnstartingbradleystdm();

        if(level.tankstartspawnneutral.size != 0)
          thread kickoffneutralbradleyspawnstdm();

        break;
      }
    } else if(var_3 == "_encstr_8218041DF5FA") {
      if(level.tankstartspawnalliesdom.size != 0 || level.tankstartspawnaxisdom.size != 0 || level.tankspawndom_a.size != 0 || level.tankspawndom_b.size != 0 || level.tankspawndom_c.size != 0) {
        thread kickoffneutralbradleyspawnsdom();
        break;
      }
    } else if(var_3 == "_encstr_9719046E3182") {
      if(level.tankstartspawnalliescmd.size != 0 || level.tankstartspawnaxiscmd.size != 0 || level.tankspawncmd_1.size != 0 || level.tankspawncmd_2.size != 0 || level.tankspawncmd_3.size != 0) {
        spawnstartingbradleyscmd();
        break;
      }
    }
  }
}

spawnstartingbradleystdm() {
  if(level.tankstartspawnallies.size != 0 && level.tankstartspawnaxis.size != 0) {
    var_0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnallies[0].angles))
      var_0 = level.tankstartspawnallies[0].angles;

    thread spawnbradleynoduration(level.tankstartspawnallies[0].origin, var_0, "_encstr_9A8507BA4040188D08");
    var_0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxis[0].angles))
      var_0 = level.tankstartspawnaxis[0].angles;

    thread spawnbradleynoduration(level.tankstartspawnaxis[0].origin, var_0, "_encstr_8E8405EA382B2A");
  }
}

spawnstartingbradleysdom() {
  if(level.tankstartspawnalliesdom.size != 0 && level.tankstartspawnaxisdom.size != 0) {
    var_0 = (0, 0, 0);
    var_1 = (0, 0, 0);
    var_2 = (0, 0, 0);
    var_3 = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliesdom[0].angles))
      var_0 = level.tankstartspawnalliesdom[0].angles;

    var_1 = level.tankstartspawnalliesdom[0].origin;

    if(isDefined(level.tankstartspawnaxisdom[0].angles))
      var_2 = level.tankstartspawnaxisdom[0].angles;

    var_3 = level.tankstartspawnaxisdom[0].origin;

    if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
      thread spawnbradleynoduration(var_3, var_2, "_encstr_9A8507BA4040188D08");
      thread spawnbradleynoduration(var_1, var_0, "_encstr_8E8405EA382B2A");
    } else {
      thread spawnbradleynoduration(var_3, var_2, "_encstr_8E8405EA382B2A");
      thread spawnbradleynoduration(var_1, var_0, "_encstr_9A8507BA4040188D08");
    }
  }
}

spawnstartingbradleyscmd() {
  if(level.tankstartspawnalliescmd.size != 0 && level.tankstartspawnaxiscmd.size != 0) {
    var_0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliescmd[0].angles))
      var_0 = level.tankstartspawnalliescmd[0].angles;

    thread spawnbradleynoduration(level.tankstartspawnalliescmd[0].origin, var_0, "_encstr_9A8507BA4040188D08");
    var_0 = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxiscmd[0].angles))
      var_0 = level.tankstartspawnaxiscmd[0].angles;

    thread spawnbradleynoduration(level.tankstartspawnaxiscmd[0].origin, var_0, "_encstr_8E8405EA382B2A");
  }
}

kickoffneutralbradleyspawnstdm() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 12;
  var_0 = scripts\engine\utility::random(level.tankstartspawnneutral);
  var_1 = (0, 0, 0);

  if(isDefined(var_0.angles))
    var_1 = var_0.angles;

  thread spawnbradleynoduration(var_0.origin, var_1);
  var_2 = scripts\mp\utility\game::gettimelimit();
  var_3 = var_2 / 3;
  var_4 = max(var_3, 180);
  var_4 = min(var_4, 240);

  for(;;) {
    wait(var_4);

    if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_AF390B295782C3585F1B21D8C4").size < 2) {
      var_0 = selectneutralspawn();
      thread spawnbradleynoduration(var_0.origin, var_0.angles);
    }
  }
}

kickoffneutralbradleyspawnsdom() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 60;
  var_0 = scripts\mp\utility\game::gettimelimit();
  var_1 = var_0 / 3;
  var_2 = max(var_1, 180);
  var_2 = min(var_2, 240);

  for(;;) {
    wait(var_2);

    if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_AF390B295782C3585F1B21D8C4").size < 2) {
      var_3 = selectdomspawn();

      if(!isDefined(var_3))
        var_3 = delayspawnuntilpointcap();

      spawndombradley(var_3);
    }
  }
}

spawndombradley(var_0) {
  if(var_0.objectivekey == "_encstr_B20703DFCF")
    var_1 = scripts\engine\utility::random(level.tankspawndom_a);
  else if(var_0.objectivekey == "_encstr_B40703E96D")
    var_1 = scripts\engine\utility::random(level.tankspawndom_b);
  else
    var_1 = scripts\engine\utility::random(level.tankspawndom_c);

  if(isDefined(var_1)) {
    var_2 = (0, 0, 0);

    if(isDefined(var_1.angles))
      var_2 = var_1.angles;

    thread spawnbradleynoduration(var_1.origin, var_2);
  }
}

tryspawnneutralbradleycmd(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_AF390B295782C3585F1B21D8C4").size < 2) {
    if(var_0 == 1) {
      if(level.tankspawncmd_1.size != 0) {
        var_1 = (0, 0, 0);
        var_2 = scripts\engine\utility::random(level.tankspawncmd_1);

        if(isDefined(var_2.angles))
          var_1 = var_2.angles;

        thread spawnbradleynoduration(var_2.origin, var_1, "_encstr_9A8507BA4040188D08");
      }
    } else if(var_0 == 2) {
      if(level.tankspawncmd_2.size != 0) {
        var_1 = (0, 0, 0);
        var_2 = scripts\engine\utility::random(level.tankspawncmd_2);

        if(isDefined(var_2.angles))
          var_1 = var_2.angles;

        thread spawnbradleynoduration(var_2.origin, var_1, "_encstr_9A8507BA4040188D08");
      }
    } else if(var_0 == 3) {
      if(level.tankspawncmd_3.size != 0) {
        var_1 = (0, 0, 0);
        var_2 = scripts\engine\utility::random(level.tankspawncmd_3);

        if(isDefined(var_2.angles))
          var_1 = var_2.angles;

        thread spawnbradleynoduration(var_2.origin, var_1, "_encstr_9A8507BA4040188D08");
      }
    }
  }
}

delayspawnuntilpointcap() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 3;
    var_0 = selectdomspawn();

    if(isDefined(var_0))
      return var_0;
  }
}

selectneutralspawn() {
  var_0 = scripts\engine\utility::random(level.tankstartspawnneutral);
  return var_0;
}

selectdomspawn() {
  var_0 = _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getteamdompoints("_encstr_9A8507BA4040188D08");
  var_1 = _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getteamdompoints("_encstr_8E8405EA382B2A");
  var_2 = _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getteamdompoints("_encstr_A7A408B9CA5D1D4E2C63");

  if(var_0.size == 3 || var_1.size == 3)
    return undefined;
  else if(var_0.size < var_1.size) {
    if(var_0.size == 0)
      return var_2[0];

    return var_0[0];
  } else if(var_0.size > var_1.size) {
    if(var_1.size == 0)
      return var_2[0];

    return var_1[0];
  }

  return undefined;
}

spawnbradleynoduration(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_3);
  var_3.cantimeout = 0;
  var_3.spawnmethod = "_encstr_A5C114A1638A32DB6219592B88C1537F3BFB9B4C7006";
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.team = var_2;
  var_4 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var_3);
}