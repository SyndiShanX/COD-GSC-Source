/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hostmigration.gsc
***********************************************/

callback_hostmigration() {
  level.hostmigrationreturnedplayercount = 0;

  if(level.gameended) {
    return;
  }
  if(drawentitybounds())
    analyticsstreamerlogfilewritetobuffer();

  level thread hostmigrationconnectwatcher();

  foreach(var_1 in level.characters)
  var_1.hostmigrationcontrolsfrozen = 0;

  level.hostmigrationtimer = 1;
  setDvar("_encstr_A9E413E3C01707FE01A0B31317DF99C3336B2B2788", 1);
  level.hostmigration = 1;
  level notify("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  scripts\mp\gamelogic::updatetimerpausedness();

  foreach(var_1 in level.characters) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 thread hostmigrationtimerthink();

    if(isPlayer(var_1)) {
      var_1 setclientomnvar("_encstr_8BCB112DF3390A3B3A66FB3F820F10911F73FD", var_1.sessionstate);

      if(drawentitybounds())
        analyticsstreamerislogfilestreamingenabled(var_1.guid);
    }
  }

  level endon("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setDvar("_encstr_A9E413E3C01707FE01A0B31317DF99C3336B2B2788", 0);
  visionsetthermal(game["_encstr_8E4A0FA5C837EB73F67241705A0A33ED43"]);
  level.hostmigration = 0;
  level notify("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
  scripts\mp\gamelogic::updatetimerpausedness();
  level thread[[level.updategameevents]]();
}

hostmigrationconnectwatcher() {
  level endon("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
  level endon("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
  var_0 thread hostmigrationtimerthink();

  if(isPlayer(var_0))
    var_0 setclientomnvar("_encstr_8BCB112DF3390A3B3A66FB3F820F10911F73FD", var_0.sessionstate);
}

hostmigrationwait() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.ingraceperiod = 25;
  thread scripts\mp\gamelogic::matchstarttimer("_encstr_9B7914335F23B3913038778B606B6F3B91E7382FBE7F", 20.0);
  hostmigrationwaitforplayers();
  level.ingraceperiod = 10;
  thread scripts\mp\gamelogic::matchstarttimer("_encstr_A7B9121AE1F55FCC21058D83136854A394DED2B2", 5.0);
  wait 5;
  level.ingraceperiod = 0;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);
    var_1 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
  }

  if(istrue(level.forfeitinprogress) && !istrue(level.forfeit_aborted))
    setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_83B01780727008402A3B612F03529688AD8C6BD89D7FD18BB2");
}

hostmigrationwaitforplayers() {
  level endon("_encstr_8E3E1C86DEDCA35BB4CEE4B0E8A5EDB9F595B97B5D760D1C1BB0BC959CB9");
  wait 15;
}

hostmigrationname(var_0) {
  if(!isDefined(var_0))
    return "_encstr_9A0F0EAAD6370B87A3A96BFF9160B4E2";

  var_1 = -1;
  var_2 = "_encstr_9B4C023E";

  if(isDefined(var_0.entity_number))
    var_1 = var_0.entity_number;

  if(isPlayer(var_0) && isDefined(var_0.name))
    var_2 = var_0.name;

  if(isPlayer(var_0))
    return "_encstr_8EF80953D8E7BF07F0294C" + var_2 + "_encstr_834C028F";

  if(isagent(var_0) && scripts\mp\utility\entity::isgameparticipant(var_0))
    return "_encstr_8F9F14F3F815F34F896BA8B1F03332FE57A09A2B5A31" + var_1 + "_encstr_834C028F";

  if(isagent(var_0))
    return "_encstr_B1351862704A7BABD7704B689129FA7928292AA187C22DFD0659" + var_1 + "_encstr_834C028F";

  return "_encstr_A19C11D3B84772F773D02A27C84BB99B1BE709" + var_1 + "_encstr_834C028F";
}

hostmigrationtimerthink_internal() {
  level endon("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  level endon("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");

  while(!scripts\mp\utility\player::isreallyalive(self))
    self waittill("_encstr_BA350853C128FB939DB9");

  self.hostmigrationcontrolsfrozen = 1;
  scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_966B13D0059340417A6F1DC3DB82A8586C1CF8C9EA");
  level waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
}

hostmigrationtimerthink() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_966B13D0059340417A6F1DC3DB82A8586C1CF8C9EA");
    self.hostmigrationcontrolsfrozen = undefined;
  }
}

waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer))
    return 0;

  var_0 = gettime();
  level waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
  return gettime() - var_0;
}

waittillhostmigrationstarts(var_0) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  level endon("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  wait(var_0);
}

waitlongdurationwithhostmigrationpause(var_0) {
  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    waittillhostmigrationstarts((var_2 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_3 = waittillhostmigrationdone();
      var_2 = var_2 + var_3;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_1;
}

waittill_notify_or_timeout_hostmigration_pause(var_0, var_1) {
  self endon(var_0);

  if(var_1 == 0) {
    return;
  }
  var_2 = gettime();
  var_3 = gettime() + var_1 * 1000;

  while(gettime() < var_3) {
    waittillhostmigrationstarts((var_3 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_4 = waittillhostmigrationdone();
      var_3 = var_3 + var_4;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_2;
}

waitlongdurationwithgameendtimeupdate(var_0) {
  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    waittillhostmigrationstarts((var_2 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var_2 = var_2 + 1000;
      setgameendtime(int(var_2));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_2 = var_2 + 1000;
    setgameendtime(int(var_2));
    wait 1;
  }

  return gettime() - var_1;
}