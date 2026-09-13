/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\bradley_spawner.gsc
****************************************************/

monitoradd(tank, timeout) {
  tank.script_timeout = timeout;
  level.tanktimeoutlist[level.tanktimeoutlist.size] = tank;
}

spawntanks(_id_A85CE59E9FCD4439, team) {
  level endon("game_ended");
  wait 0.05;

  foreach(_id_99DCA11891EA4828 in _id_A85CE59E9FCD4439) {
    if(!isDefined(_id_99DCA11891EA4828.angles))
      _id_99DCA11891EA4828.angles = (0, 0, 0);

    refill = scripts\engine\utility::ter_op(isDefined(_id_99DCA11891EA4828.script_force_count), _id_99DCA11891EA4828.script_force_count, 0);
    timeout = scripts\engine\utility::ter_op(isDefined(_id_99DCA11891EA4828.script_timeout), _id_99DCA11891EA4828.script_timeout, 0);
    level thread spawntankandmonitor(_id_99DCA11891EA4828.origin, _id_99DCA11891EA4828.angles, team, refill, timeout);
  }
}

spawntankandmonitor(origin, angles, team, refill, timeout) {
  level endon("game_ended");
  tank = spawntank(origin, angles, team, timeout, 0);

  if(refill) {
    for(;;) {
      tank waittill("death");
      wait 3.0;
      tank = spawntank(origin, angles, team, timeout, 1);
    }
  }
}

spawntank(origin, angles, team, timeout, infil) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "initSpawnData")) {
    return;
  }
  spawndata = spawnStruct();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "initSpawnData")]](spawndata);
  spawndata.cantimeout = 0;
  spawndata.spawnmethod = scripts\engine\utility::ter_op(istrue(infil), "airdrop_at_position_unsafe", "place_at_position_unsafe");
  spawndata.origin = origin;
  spawndata.angles = angles;
  spawndata.team = team;
  tank = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "tankSpawn")]](spawndata);

  if(timeout > 0)
    monitoradd(tank, timeout);

  return tank;
}

inittankspawns() {
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
  _id_8B69C8D5076F9B30 = ["cmd", "dom", "war", "arm", "conflict", "risk"];
  _id_8C28012A76120A71 = scripts\engine\utility::array_find(_id_8B69C8D5076F9B30, scripts\mp\utility\game::getgametype());

  if(!isDefined(_id_8C28012A76120A71))
    _id_8C28012A76120A71 = _id_8B69C8D5076F9B30.size;

  for(_id_AC0E594AC96AA3A8 = _id_8C28012A76120A71; _id_AC0E594AC96AA3A8 < _id_8B69C8D5076F9B30.size; _id_AC0E594AC96AA3A8++) {
    _id_9FB431AE2D7ECE3B = _id_8B69C8D5076F9B30[_id_AC0E594AC96AA3A8];

    if(_id_9FB431AE2D7ECE3B == "war") {
      if(level.tankstartspawnallies.size != 0 || level.tankstartspawnaxis.size != 0 || level.tankstartspawnneutral.size != 0) {
        spawnstartingbradleystdm();

        if(level.tankstartspawnneutral.size != 0)
          thread kickoffneutralbradleyspawnstdm();

        break;
      }
    } else if(_id_9FB431AE2D7ECE3B == "dom") {
      if(level.tankstartspawnalliesdom.size != 0 || level.tankstartspawnaxisdom.size != 0 || level.tankspawndom_a.size != 0 || level.tankspawndom_b.size != 0 || level.tankspawndom_c.size != 0) {
        thread kickoffneutralbradleyspawnsdom();
        break;
      }
    } else if(_id_9FB431AE2D7ECE3B == "cmd") {
      if(level.tankstartspawnalliescmd.size != 0 || level.tankstartspawnaxiscmd.size != 0 || level.tankspawncmd_1.size != 0 || level.tankspawncmd_2.size != 0 || level.tankspawncmd_3.size != 0) {
        spawnstartingbradleyscmd();
        break;
      }
    }
  }
}

spawnstartingbradleystdm() {
  if(level.tankstartspawnallies.size != 0 && level.tankstartspawnaxis.size != 0) {
    angles = (0, 0, 0);

    if(isDefined(level.tankstartspawnallies[0].angles))
      angles = level.tankstartspawnallies[0].angles;

    thread spawnbradleynoduration(level.tankstartspawnallies[0].origin, angles, "allies");
    angles = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxis[0].angles))
      angles = level.tankstartspawnaxis[0].angles;

    thread spawnbradleynoduration(level.tankstartspawnaxis[0].origin, angles, "axis");
  }
}

spawnstartingbradleysdom() {
  if(level.tankstartspawnalliesdom.size != 0 && level.tankstartspawnaxisdom.size != 0) {
    _id_7E4886C52A1BC723 = (0, 0, 0);
    _id_A6C0109970E785CD = (0, 0, 0);
    _id_76FD430E3623FB30 = (0, 0, 0);
    _id_C0E9F05D2F85A432 = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliesdom[0].angles))
      _id_7E4886C52A1BC723 = level.tankstartspawnalliesdom[0].angles;

    _id_A6C0109970E785CD = level.tankstartspawnalliesdom[0].origin;

    if(isDefined(level.tankstartspawnaxisdom[0].angles))
      _id_76FD430E3623FB30 = level.tankstartspawnaxisdom[0].angles;

    _id_C0E9F05D2F85A432 = level.tankstartspawnaxisdom[0].origin;

    if(game["switchedsides"]) {
      thread spawnbradleynoduration(_id_C0E9F05D2F85A432, _id_76FD430E3623FB30, "allies");
      thread spawnbradleynoduration(_id_A6C0109970E785CD, _id_7E4886C52A1BC723, "axis");
    } else {
      thread spawnbradleynoduration(_id_C0E9F05D2F85A432, _id_76FD430E3623FB30, "axis");
      thread spawnbradleynoduration(_id_A6C0109970E785CD, _id_7E4886C52A1BC723, "allies");
    }
  }
}

spawnstartingbradleyscmd() {
  if(level.tankstartspawnalliescmd.size != 0 && level.tankstartspawnaxiscmd.size != 0) {
    angles = (0, 0, 0);

    if(isDefined(level.tankstartspawnalliescmd[0].angles))
      angles = level.tankstartspawnalliescmd[0].angles;

    thread spawnbradleynoduration(level.tankstartspawnalliescmd[0].origin, angles, "allies");
    angles = (0, 0, 0);

    if(isDefined(level.tankstartspawnaxiscmd[0].angles))
      angles = level.tankstartspawnaxiscmd[0].angles;

    thread spawnbradleynoduration(level.tankstartspawnaxiscmd[0].origin, angles, "axis");
  }
}

kickoffneutralbradleyspawnstdm() {
  level endon("game_ended");
  wait 12;
  _id_99DCA11891EA4828 = scripts\engine\utility::random(level.tankstartspawnneutral);
  angles = (0, 0, 0);

  if(isDefined(_id_99DCA11891EA4828.angles))
    angles = _id_99DCA11891EA4828.angles;

  thread spawnbradleynoduration(_id_99DCA11891EA4828.origin, angles);
  timelimit = scripts\mp\utility\game::gettimelimit();
  _id_4551667111C2FDED = timelimit / 3;
  spawntime = max(_id_4551667111C2FDED, 180);
  spawntime = min(spawntime, 240);

  for(;;) {
    wait(spawntime);

    if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank").size < 2) {
      _id_99DCA11891EA4828 = selectneutralspawn();
      thread spawnbradleynoduration(_id_99DCA11891EA4828.origin, _id_99DCA11891EA4828.angles);
    }
  }
}

kickoffneutralbradleyspawnsdom() {
  level endon("game_ended");
  wait 60;
  timelimit = scripts\mp\utility\game::gettimelimit();
  _id_4551667111C2FDED = timelimit / 3;
  spawntime = max(_id_4551667111C2FDED, 180);
  spawntime = min(spawntime, 240);

  for(;;) {
    wait(spawntime);

    if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank").size < 2) {
      _id_892859FB1AE1E343 = selectdomspawn();

      if(!isDefined(_id_892859FB1AE1E343))
        _id_892859FB1AE1E343 = delayspawnuntilpointcap();

      spawndombradley(_id_892859FB1AE1E343);
    }
  }
}

spawndombradley(_id_892859FB1AE1E343) {
  if(_id_892859FB1AE1E343.objectivekey == "_a")
    _id_99DCA11891EA4828 = scripts\engine\utility::random(level.tankspawndom_a);
  else if(_id_892859FB1AE1E343.objectivekey == "_b")
    _id_99DCA11891EA4828 = scripts\engine\utility::random(level.tankspawndom_b);
  else
    _id_99DCA11891EA4828 = scripts\engine\utility::random(level.tankspawndom_c);

  if(isDefined(_id_99DCA11891EA4828)) {
    angles = (0, 0, 0);

    if(isDefined(_id_99DCA11891EA4828.angles))
      angles = _id_99DCA11891EA4828.angles;

    thread spawnbradleynoduration(_id_99DCA11891EA4828.origin, angles);
  }
}

tryspawnneutralbradleycmd(point) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank").size < 2) {
    if(point == 1) {
      if(level.tankspawncmd_1.size != 0) {
        angles = (0, 0, 0);
        _id_99DCA11891EA4828 = scripts\engine\utility::random(level.tankspawncmd_1);

        if(isDefined(_id_99DCA11891EA4828.angles))
          angles = _id_99DCA11891EA4828.angles;

        thread spawnbradleynoduration(_id_99DCA11891EA4828.origin, angles, "allies");
      }
    } else if(point == 2) {
      if(level.tankspawncmd_2.size != 0) {
        angles = (0, 0, 0);
        _id_99DCA11891EA4828 = scripts\engine\utility::random(level.tankspawncmd_2);

        if(isDefined(_id_99DCA11891EA4828.angles))
          angles = _id_99DCA11891EA4828.angles;

        thread spawnbradleynoduration(_id_99DCA11891EA4828.origin, angles, "allies");
      }
    } else if(point == 3) {
      if(level.tankspawncmd_3.size != 0) {
        angles = (0, 0, 0);
        _id_99DCA11891EA4828 = scripts\engine\utility::random(level.tankspawncmd_3);

        if(isDefined(_id_99DCA11891EA4828.angles))
          angles = _id_99DCA11891EA4828.angles;

        thread spawnbradleynoduration(_id_99DCA11891EA4828.origin, angles, "allies");
      }
    }
  }
}

delayspawnuntilpointcap() {
  level endon("game_ended");

  for(;;) {
    wait 3;
    _id_892859FB1AE1E343 = selectdomspawn();

    if(isDefined(_id_892859FB1AE1E343))
      return _id_892859FB1AE1E343;
  }
}

selectneutralspawn() {
  _id_99DCA11891EA4828 = scripts\engine\utility::random(level.tankstartspawnneutral);
  return _id_99DCA11891EA4828;
}

selectdomspawn() {
  _id_81813E4560DA38E8 = _id_2DC3A143158CEC7C::getteamdompoints("allies");
  _id_31CD4798CE98E96F = _id_2DC3A143158CEC7C::getteamdompoints("axis");
  _id_9BB266F7BF9B6CBB = _id_2DC3A143158CEC7C::getteamdompoints("neutral");

  if(_id_81813E4560DA38E8.size == 3 || _id_31CD4798CE98E96F.size == 3)
    return undefined;
  else if(_id_81813E4560DA38E8.size < _id_31CD4798CE98E96F.size) {
    if(_id_81813E4560DA38E8.size == 0)
      return _id_9BB266F7BF9B6CBB[0];

    return _id_81813E4560DA38E8[0];
  } else if(_id_81813E4560DA38E8.size > _id_31CD4798CE98E96F.size) {
    if(_id_31CD4798CE98E96F.size == 0)
      return _id_9BB266F7BF9B6CBB[0];

    return _id_31CD4798CE98E96F[0];
  }

  return undefined;
}

spawnbradleynoduration(position, angles, team) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "initSpawnData")) {
    return;
  }
  spawndata = spawnStruct();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "initSpawnData")]](spawndata);
  spawndata.cantimeout = 0;
  spawndata.spawnmethod = "airdrop_at_position";
  spawndata.origin = position;
  spawndata.angles = angles;
  spawndata.team = team;
  tank = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "tankSpawn")]](spawndata);
}