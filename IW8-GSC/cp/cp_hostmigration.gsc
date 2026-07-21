/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_hostmigration.gsc
***********************************************/

hostmigrationwait() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.ingraceperiod = 25;
  thread matchstarttimer("_encstr_9B7914335F23B3913038778B606B6F3B91E7382FBE7F", 20.0);
  hostmigrationwaitforplayers();
  level.ingraceperiod = 10;
  thread matchstarttimer("_encstr_A7B9121AE1F55FCC21058D83136854A394DED2B2", 5.0);
  wait 5;
  level.ingraceperiod = 0;
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

  if(isagent(var_0) && scripts\cp\utility::isgameparticipant(var_0))
    return "_encstr_8F9F14F3F815F34F896BA8B1F03332FE57A09A2B5A31" + var_1 + "_encstr_834C028F";

  if(isagent(var_0))
    return "_encstr_B1351862704A7BABD7704B689129FA7928292AA187C22DFD0659" + var_1 + "_encstr_834C028F";

  return "_encstr_A19C11D3B84772F773D02A27C84BB99B1BE709" + var_1 + "_encstr_834C028F";
}

hostmigrationtimerthink_internal() {
  level endon("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  level endon("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");

  while(!scripts\cp_mp\utility\player_utility::_isalive())
    self waittill("_encstr_BA350853C128FB939DB9");

  self.hostmigrationcontrolsfrozen = 1;
  scripts\cp\utility::freezecontrolswrapper(1);
  level waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
}

hostmigrationtimerthink() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    if(scripts\cp\utility::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      scripts\cp\utility::freezecontrolswrapper(0);

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

matchstarttimer(var_0, var_1) {
  self notify("_encstr_8DBA10DA2C47C60D35A3B0931D45A5B6569C");
  self endon("_encstr_8DBA10DA2C47C60D35A3B0931D45A5B6569C");
  level notify("_encstr_9AEF1C15BBD8A62328E3D38AEB95C7DB983B9572AF306FD7EBB86A327064");
  var_2 = int(var_1);

  if(var_2 >= 2) {
    setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", var_0);
    matchstarttimer_internal(var_2);
    visionsetnaked("_encstr_B40101", 3.0);
  } else {
    introvisionset();
    visionsetnaked("_encstr_B40101", 1.0);
  }
}

matchstarttimer_internal(var_0) {
  waittillframeend;
  introvisionset();
  level endon("_encstr_9AEF1C15BBD8A62328E3D38AEB95C7DB983B9572AF306FD7EBB86A327064");

  while(var_0 > 0 && !level.gameended) {
    foreach(var_2 in level.players) {
      var_2 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", var_0);
      var_2 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 0);
    }

    if(var_0 == 0)
      visionsetnaked("_encstr_B40101", 0);

    var_0--;
    wait 1.0;
  }

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);
    var_2 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
  }
}

introvisionset() {
  if(!isDefined(level.introvisionset))
    level.introvisionset = "_encstr_878D085F094302944838";

  visionsetnaked(level.introvisionset, 0);
}