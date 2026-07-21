/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_maphints.gsc
***********************************************/

init() {
  if(getdvarint("_encstr_9A590D4FCB3A59291F9384A89AA3DE", 0) == 0) {
    level thread linker();
    return;
  }

  level._id_11AE4 = [];
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"] = [];
  level._id_11AE4["_encstr_934B073886DE73CAB9"] = [];
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"] = [];
  level thread onplayerconnect();
  level thread tank_death();

  if(scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    times_shot();
  else
    timer_sequence();

  scripts\engine\scriptable::_id_12F5B("_encstr_8D4211D7F0FBA43A7D8B3907A0DDEFB37352A3", ::_id_11ADF);

  if(0)
    level thread _id_11AE0();
}

linker() {
  wait 1.0;
  var_0 = tablelookupgetnumrows("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 0);

    if(isDefined(var_2) && var_2 != "_encstr_B40101") {
      var_3 = getentitylessscriptablearrayinradius(var_2, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

      foreach(var_5 in var_3)
      var_5 setscriptablepartstate("_encstr_99CC056A4818C4", "_encstr_BA19049F4B2D", 1);
    }
  }
}

timeremaining() {
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"] = [];
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][0] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][0].origin = (-17261, -44265, 40);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][1] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][1].origin = (-37520, -19013, 237);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][2] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][2].origin = (-39523, -2395, 30);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][3] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][3].origin = (-38640, -1902, -103);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][4] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][4].origin = (-15513, 43307, 105);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][5] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][5].origin = (2495, 41096, 1670);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][6] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][6].origin = (47600, 34582, 500);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][7] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][7].origin = (18622, -34634, -478);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][8] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][8].origin = (54279, -33994, 173);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][9] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][9].origin = (36350, 13586, 26);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][10] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][10].origin = (37390, 13383, -117);

  foreach(var_2, var_1 in level._id_11AE4["_encstr_AD8308B6562FC10B236E"])
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][var_2].scriptable = easepower("_encstr_87200FBD57096A9938587FA73832582289", var_1.origin);
}

times_in_b() {
  level._id_11AE4["_encstr_934B073886DE73CAB9"] = [];

  foreach(var_2, var_1 in level._id_11AE4["_encstr_934B073886DE73CAB9"])
  level._id_11AE4["_encstr_934B073886DE73CAB9"][var_2].scriptable = easepower("_encstr_9AE00EABDFD179B06A2D2ED0E99898FF", var_1.origin);
}

timer_sequence() {
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"] = [];
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][0] = spawnStruct();
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][0].origin = (8490, -11874, -239);
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][1] = spawnStruct();
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][1].origin = (-14585, 7982, -175);
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][2] = spawnStruct();
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][2].origin = (-34140, 3815, -55);
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][3] = spawnStruct();
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][3].origin = (5358, 51419, 1080);
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][4] = spawnStruct();
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][4].origin = (51078, -39445, 1125);
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][5] = spawnStruct();
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][5].origin = (17796, -8300, 1349);
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][6] = spawnStruct();
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][6].origin = (37275, -26745, -472);

  foreach(var_2, var_1 in level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"])
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][var_2].scriptable = easepower("_encstr_8D4211D7F0FBA43A7D8B3907A0DDEFB37352A3", var_1.origin);
}

times_in_c() {
  level._id_11AE4["_encstr_B1460728AAA7132807"] = [];
  level._id_11AE4["_encstr_B1460728AAA7132807"][0] = spawnStruct();
  level._id_11AE4["_encstr_B1460728AAA7132807"][0].origin = (-21440, 19434, -252);
  level._id_11AE4["_encstr_B1460728AAA7132807"][1] = spawnStruct();
  level._id_11AE4["_encstr_B1460728AAA7132807"][1].origin = (2896, 45445, 1630);

  foreach(var_2, var_1 in level._id_11AE4["_encstr_B1460728AAA7132807"])
  level._id_11AE4["_encstr_B1460728AAA7132807"][var_2].scriptable = easepower("_encstr_83A70E6B16E0342D73A3FA9C85C8B47B", var_1.origin);
}

_id_11AE1(var_0, var_1, var_2, var_3, var_4) {
  level thread allow_player_skip_deathshield(var_0, var_1, var_2, var_3, var_4);
}

allow_player_skip_deathshield(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_AB0703DBB9") {
    playsoundatpos(var_3.origin, "_encstr_B63B0FC493FADACABC381619BE19ACB9F2");
    var_0 setscriptablepartstate("_encstr_87200FBD57096A9938587FA73832582289", "_encstr_BA19049F4B2D");
    wait 3;
    var_0 setscriptablepartstate("_encstr_87200FBD57096A9938587FA73832582289", "_encstr_AB0703DBB9");
  }
}

_id_11AE3(var_0, var_1, var_2, var_3, var_4) {
  level thread allowassassinationdamage(var_0, var_1, var_2, var_3, var_4);
}

allowassassinationdamage(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_AB0703DBB9") {
    playsoundatpos(var_3.origin, "_encstr_87B00EA0936159B07FA67D78847F38F3");
    var_0 setscriptablepartstate("_encstr_9AE00EABDFD179B06A2D2ED0E99898FF", "_encstr_BA19049F4B2D");
    wait 3;
    var_0 setscriptablepartstate("_encstr_9AE00EABDFD179B06A2D2ED0E99898FF", "_encstr_AB0703DBB9");
  }
}

_id_11ADF(var_0, var_1, var_2, var_3, var_4) {
  level thread allow_player_minimapforcedisable(var_0, var_1, var_2, var_3, var_4);
}

allow_player_minimapforcedisable(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_AB0703DBB9") {
    playsoundatpos(var_3.origin, "_encstr_8F2511B08E993F07E9AB580B88CD17CA728529");
    var_0 setscriptablepartstate("_encstr_8D4211D7F0FBA43A7D8B3907A0DDEFB37352A3", "_encstr_BA19049F4B2D");
    wait 3;
    var_0 setscriptablepartstate("_encstr_8D4211D7F0FBA43A7D8B3907A0DDEFB37352A3", "_encstr_AB0703DBB9");
  }
}

times_shot() {
  wait 5;
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"] = [];
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][0] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][0].origin = (-237, -2721, 60);
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][1] = spawnStruct();
  level._id_11AE4["_encstr_AD8308B6562FC10B236E"][1].origin = (-237, -2721, 260);

  foreach(var_1 in level._id_11AE4["_encstr_AD8308B6562FC10B236E"])
  var_2 = easepower("_encstr_87200FBD57096A9938587FA73832582289", var_1.origin);

  level._id_11AE4["_encstr_934B073886DE73CAB9"] = [];
  level._id_11AE4["_encstr_934B073886DE73CAB9"][0] = spawnStruct();
  level._id_11AE4["_encstr_934B073886DE73CAB9"][0].origin = (-21, -2721, 60);
  level._id_11AE4["_encstr_934B073886DE73CAB9"][1] = spawnStruct();
  level._id_11AE4["_encstr_934B073886DE73CAB9"][1].origin = (-21, -2721, 260);

  foreach(var_1 in level._id_11AE4["_encstr_934B073886DE73CAB9"])
  var_2 = easepower("_encstr_9AE00EABDFD179B06A2D2ED0E99898FF", var_1.origin);

  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"] = [];
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][0] = spawnStruct();
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][0].origin = (100, -2721, 60);
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][1] = spawnStruct();
  level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"][1].origin = (100, -2721, 260);

  foreach(var_1 in level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"])
  var_2 = easepower("_encstr_8D4211D7F0FBA43A7D8B3907A0DDEFB37352A3", var_1.origin);
}

_id_11AE0() {
  var_0 = 1;

  for(;;) {
    if(var_0) {
      foreach(var_2 in level._id_11AE4["_encstr_934B073886DE73CAB9"])
      thread scripts\mp\utility\debug::drawsphere(var_2.scriptable.origin, 64, 1, (0, 1, 0));
    }

    if(getdvarint("_encstr_8BFB17EB49383F98F948EB3172FDD16970463DAC133A73A3D3", 0) == 1) {
      foreach(var_2 in level._id_11AE4["_encstr_AD8308B6562FC10B236E"])
      var_2.scriptable freescriptable();

      foreach(var_2 in level._id_11AE4["_encstr_934B073886DE73CAB9"])
      var_2.scriptable freescriptable();

      foreach(var_2 in level._id_11AE4["_encstr_931F0AAEC5CAF9BB649F9060"])
      var_2.scriptable freescriptable();

      timeremaining();
      times_in_b();
      timer_sequence();
    }

    wait 1;
  }
}

tank_death() {
  level.trial_enemies_killed = [];
  scripts\mp\flags::gameflaginit("_encstr_A9F1202DB98EAC8DFAC6D085B18DACDCCE95B9AF3756E85D387D8DB7B538C62B3ACA", 0);
  var_0 = getdvarint("_encstr_9B220BA156B9CE4CBC57191F69", 0);
  level._id_129CC = getentitylessscriptablearrayinradius("_encstr_9186104BCD3AB236BE8DD0B0B18DCAB9B395", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 0);
    var_3 = tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 1);

    if(!isDefined(var_3) || var_3 == "_encstr_B40101") {
      break;
    }

    var_4 = int(tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 3));
    var_5 = int(tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 2));

    if(var_5 > var_0 && getdvarint("_encstr_85BA1B5B708DB1C7906D352490598B46C960A202E80B72E709DD3A3594", 0) == 0) {
      var_1++;
      continue;
    }

    var_6 = tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 4);
    var_7 = tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 5);
    var_8 = float(tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 6));
    var_9 = float(tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 7));
    var_10 = float(tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 8));
    var_11 = (var_8, var_9, var_10);
    var_12 = float(tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 9));
    var_13 = float(tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 10));
    var_14 = float(tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 11));
    var_15 = (var_12, var_13, var_14);
    var_16 = tablelookupbyrow("_encstr_A9D718C713E591381B7F7D9F412A67618C655D37D1F755EFAB96", var_1, 13);

    if(!isDefined(level.trial_enemies_killed[var_3])) {
      var_17 = spawnStruct();
      var_17.ref = var_3;
      var_17.stopdragonsbreath = var_4;
      var_17._id_145A6 = var_5;
      var_17.chopper_boss_player_monitor = var_6;
      var_17.origin = var_11;
      var_17.helis_assault3_fob = var_16;
      var_17.scriptables = [];
      level.trial_enemies_killed[var_3] = var_17;
    }

    if(var_4) {
      var_18 = getentitylessscriptablearrayinradius(var_2, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
      var_19 = var_18[0];

      if(!isDefined(var_19))
        var_19 = easepower("_encstr_A98F06181E4BCA85", var_11, var_15);

      var_19._id_11C74 = var_7;
      var_19.iscash = var_3;
      level.trial_enemies_killed[var_3].scriptables[var_2] = var_19;
    }

    var_1++;
  }

  level thread cargo_truck_mg_initspawning();
  scripts\engine\scriptable::scriptable_addusedcallback(::trial_headicon);
  var_20 = getentitylessscriptablearrayinradius("_encstr_9186104BCD3AB236BE8DD0B0B18DCAB9B395", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\flags::gameflagset("_encstr_A9F1202DB98EAC8DFAC6D085B18DACDCCE95B9AF3756E85D387D8DB7B538C62B3ACA");
}

cargo_truck_mg_initspawning() {
  wait 1.0;

  foreach(var_5, var_1 in level.trial_enemies_killed) {
    if(!var_1.stopdragonsbreath) {
      continue;
    }
    foreach(var_3 in level.trial_enemies_killed[var_5].scriptables)
    var_3 setscriptablepartstate("_encstr_A59306224004FA23", var_3._id_11C74);
  }
}

_id_1335C(var_0, var_1) {
  foreach(var_3 in level.trial_enemies_killed[var_1].scriptables)
  var_3 enablescriptableplayeruse(var_0);

  if(isDefined(level.battle_tracks_shouldstartbattletracks)) {
    foreach(var_6 in level.battle_tracks_shouldstartbattletracks) {
      if(var_6.iscash == var_1)
        var_6 showtoplayer(var_0);
    }
  }
}

spawn_compound_final_push(var_0, var_1) {
  foreach(var_3 in level.trial_enemies_killed[var_1].scriptables)
  var_3 disablescriptableplayeruse(var_0);

  if(isDefined(level.battle_tracks_shouldstartbattletracks)) {
    foreach(var_6 in level.battle_tracks_shouldstartbattletracks) {
      if(var_6.iscash == var_1)
        var_6 hidefromplayer(var_0);
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread cargo_truck_mg_initlate();
  }
}

cargo_truck_mg_initlate() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\flags::gameflagwait("_encstr_A9F1202DB98EAC8DFAC6D085B18DACDCCE95B9AF3756E85D387D8DB7B538C62B3ACA");

  foreach(var_1 in level._id_129CC)
  var_1 disablescriptableplayeruse(self);

  foreach(var_5, var_4 in level.trial_enemies_killed) {
    if(!var_4.stopdragonsbreath) {
      continue;
    }
    spawn_compound_final_push(self, var_5);
  }

  self.audio_panodes = [];

  if(getdvarint("_encstr_85BA1B5B708DB1C7906D352490598B46C960A202E80B72E709DD3A3594", 0) == 1) {
    var_6 = [];

    foreach(var_5, var_4 in level.trial_enemies_killed) {
      if(!var_4.stopdragonsbreath) {
        continue;
      }
      var_6[var_6.size] = var_5;
    }

    self.audio_panodes = var_6;
  } else {
    var_8 = 3001;
    var_9 = undefined;

    foreach(var_5, var_4 in level.trial_enemies_killed) {
      if(var_4._id_145A6 < var_8) {
        continue;
      }
      if(var_8 < var_4._id_145A6)
        var_8 = var_4._id_145A6;

      if(isDefined(var_9) && var_9 < var_4._id_145A6)
        var_9 = undefined;

      var_11 = self getplayerdata("_encstr_8C07031599", "_encstr_A2B510AD2D9BCD5AF6730D7BB6E063B2D159", var_5);

      if(!isDefined(var_9) && !var_11) {
        var_9 = var_4._id_145A6;
        var_8++;
        self.audio_panodes[self.audio_panodes.size] = var_5;
      }
    }
  }

  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_5, var_4 in level.trial_enemies_killed) {
    if(!var_4.stopdragonsbreath) {
      continue;
    }
    if(scripts\engine\utility::array_contains(self.audio_panodes, var_5))
      _id_1335C(self, var_5);
  }
}

trial_headicon(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_0.type) && var_0.type == "_encstr_A98F06181E4BCA85") {
    var_5 = 1;

    if(!scripts\engine\utility::array_contains(var_3.audio_panodes, var_0.iscash))
      var_5 = 0;

    if(var_0.iscash == "_encstr_8494155220DF04E3DBFD241F8E81A7CAD788DF295A07EB") {
      if(!var_3 scripts\mp\utility\perk::_hasperk("_encstr_B86B0F0F88EB3F6A91A01141914B12E24B")) {
        var_5 = 0;
        playsoundatpos(var_3.origin, "_encstr_8F2511B08E993F07E9AB580B88CD17CA728529");
      }
    }

    if(var_5) {
      if(level.trial_enemies_killed[var_0.iscash].scriptables.size > 1 && istrue(level.trial_enemies_killed[var_0.iscash].helis_assault3_fob)) {
        if(!isDefined(var_3.pers[var_0.iscash]))
          var_3.pers[var_0.iscash] = 1;
        else
          var_3.pers[var_0.iscash]++;

        var_6 = level.trial_enemies_killed[var_0.iscash].scriptables.size;

        if(var_3.pers[var_0.iscash] < var_6) {
          var_0 disablescriptableplayeruse(var_3);
          var_3 playsoundtoplayer("_encstr_A20D12EFEB98A25E888905C120708CBAE6134F63", var_3);
          return;
        }
      }

      spawn_compound_final_push(var_3, var_0.iscash);
      var_3 reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", level.trial_enemies_killed[var_0.iscash].chopper_boss_player_monitor);
      var_3 playsoundtoplayer("_encstr_A20D12EFEB98A25E888905C120708CBAE6134F63", var_3);
    }
  }
}

updatematchstatushintonnoflag(var_0, var_1) {
  return isDefined(var_0.audio_panodes) && scripts\engine\utility::array_contains(var_0.audio_panodes, var_1);
}

_id_11B12(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

  foreach(var_4 in var_2) {
    if(updatematchstatushintonnoflag(var_4, var_1.iscash))
      trial_headicon(var_1, undefined, undefined, var_4);
  }
}

x1opsbink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_AB770C81EB09798E707B29137D77", var_0);
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.attacker, 0);

    foreach(var_3 in var_1) {
      if(updatematchstatushintonnoflag(var_3, self.iscash))
        trial_headicon(self.scriptable, undefined, undefined, var_3);
    }
  }
}