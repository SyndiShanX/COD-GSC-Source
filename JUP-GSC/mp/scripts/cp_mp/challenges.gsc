/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\challenges.gsc
***********************************************/

#using scripts\common\ae_utility;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\playerachievements;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace challenges;

function init() {
  if(!challengesenabled()) {
    return;
  }

  var_5ee013539b0ea23c = 0;

  if(utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
      var_5ee013539b0ea23c = 1;
    }
  }

  level.var_1850e46a71d6e72d = throttle::throttle_initialize("reportKillChallengeEvent", 1, level.framedurationseconds);

  if(!var_5ee013539b0ea23c && utility::issharedfuncdefined("game", "getGameType")) {
    gametype = [[utility::getsharedfunc("game", "getGameType")]]();

    if(isDefined(gametype) && (gametype == "brtdm" || gametype == "brtdm_mgl")) {
      var_5ee013539b0ea23c = 1;
    }
  }

  if(var_5ee013539b0ea23c) {
    level.challengetimersenabled = 1;
    level setupchallengelocales();
    level thread trackchallengetimers();
  }

  thread function_4f4a046a372e8158();

  registersharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", &reportchallengeuserserializedeventwrapper);
}

function function_4f4a046a372e8158() {
  while(true) {
    wait 1;

    if(!getdvarint(@ "hash_48ae63d778571691", 0)) {
      continue;
    }

    setDvar(@ "force_challenges", 1);
    setDvar(@ "hash_5a8c71e376f35349", 1);
    return;
  }
}

function setupchallengelocales() {
  level.localetriggers = [];
  areas = getEntArray("location_volume", "targetname");

  if(isDefined(areas) && areas.size > 0) {
    foreach(area in areas) {
      if(!isDefined(area.script_noteworthy)) {
        continue;
      }

      area.sprayid = -1;

      switch (area.script_noteworthy) {
        case #"hash_c51c246fdee94629":
          area.localeid = 1;
          area.sprayid = 0;
          break;
        case #"hash_3c20c20dc3935d6f":
          area.localeid = 2;
          area.sprayid = 1;
          break;
        case #"hash_2175f0b29e606ca5":
          area.localeid = 3;
          break;
        case #"hash_f48a166c03bb39c1":
          area.localeid = 4;
          break;
        case #"hash_2c5efc9850d0cbb5":
          area.localeid = 5;
          area.sprayid = 2;
          break;
        case #"hash_4b7c435745b1ad5e":
          area.localeid = 6;
          break;
        case #"hash_663b0900ff0e81c7":
          area.localeid = 7;
          break;
        case #"hash_959ab3efc8aa213":
          area.localeid = 8;
          area.sprayid = 3;
          break;
        case #"hash_2e0fe9d434d05e53":
          area.localeid = 9;
          break;
        case #"hash_209449a3db12c20f":
          area.localeid = 10;
          break;
        case #"hash_da04b46361bbb6a6":
          area.localeid = 11;
          break;
        case #"hash_1e6d9b2fb4016d60":
          area.localeid = 12;
          break;
        case #"hash_f00def58cc755ceb":
          area.localeid = 13;
          break;
        case #"hash_c72bae84b209b719":
          area.localeid = 14;
          break;
        case #"hash_5f22fd847b75bb06":
          area.localeid = 15;
          area.sprayid = 4;
          break;
        case #"hash_b445759ac0026f01":
          area.localeid = 16;
          break;
        case #"hash_6d93eae7a4e766a3":
          area.localeid = 17;
          break;
        case #"hash_7bff460df380c895":
          area.localeid = 18;
          break;
        case #"hash_fd6fbb1e09e1badf":
          area.localeid = 19;
          break;
        case #"hash_a86d6bdba8e7b140":
          area.localeid = 20;
          break;
        case #"hash_cc19bd6dfdb67a5e":
          area.localeid = 21;
          break;
        case #"hash_767c3e737b99b886":
          area.localeid = 22;
          break;
        case #"hash_dd3b42930dae140c":
          area.localeid = 23;
          break;
        case #"hash_7ae544b2ed0f7ef8":
          area.localeid = 24;
          break;
        case #"hash_69232c6439af5a83":
          area.localeid = 25;
          break;
        case #"hash_d10975a23b5f41c4":
          area.localeid = 26;
          break;
        case #"hash_58d20d02347be1fe":
          area.localeid = 27;
          break;
        case #"hash_c9e5d8c5fe0b0a49":
          area.localeid = 28;
          break;
        case #"hash_40928bf425cff80d":
          area.localeid = 29;
          break;
        case #"hash_afae508b9d633a55":
          area.localeid = 30;
          break;
        case #"hash_e534fd8ec73eafb4":
          area.localeid = 31;
          break;
        case #"hash_2094a957c0515134":
          area.localeid = 32;
          break;
        case #"hash_c0087eafd38b4fed":
          area.localeid = 33;
          break;
      }
    }

    level.localetriggers = areas;
  }
}

function challengesenabled() {
  return level.challengesallowed;
}

function challengesenabledforplayer() {
  if(!challengesenabled()) {
    return false;
  }

  if(!isPlayer(self) || isai(self)) {
    return false;
  }

  if(istrue(level.challengesdisabled)) {
    return false;
  }

  if(isDefined(self.var_56f36fd7cc3d8098)) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(!istrue(level.br_prematchstarted) && getdvarint(@ "hash_e76748b9932f4dbd", 0) == 0) {
      return false;
    }
  }

  return true;
}

function function_5c7e8bcdc167fd84() {
  if(!isDefined(level.var_31fe2d8a33b25b91)) {
    level.var_31fe2d8a33b25b91 = getdvarint(@ "hash_5fe27d3efac4a807", 0);
  }

  return level.var_31fe2d8a33b25b91;
}

function challengetimersenabledforplayer() {
  if(!istrue(level.challengetimersenabled)) {
    return false;
  }

  if(!challengesenabledforplayer()) {
    return false;
  }

  return true;
}

function validchallengetimer(challengename) {
  if(!isDefined(self.challengestarttime)) {
    return false;
  }

  if(!isDefined(self.challengestarttime[challengename])) {
    return false;
  }

  return true;
}

function resetchallengetimer(challengename) {
  if(!challengetimersenabledforplayer()) {
    return;
  }

  if(!validchallengetimer(challengename)) {
    return;
  }

  self.challengestarttime[challengename] = 0;
}

function startchallengetimer(challengename) {
  if(!challengetimersenabledforplayer()) {
    return;
  }

  if(!isDefined(self.challengestarttime)) {
    self.challengestarttime = [];
  }

  if(!isDefined(self.challengestarttime[challengename])) {
    self.challengestarttime[challengename] = 0;
  }

  self.challengestarttime[challengename] = gettime();
}

function stopchallengetimer(challengename) {
  if(!challengetimersenabledforplayer()) {
    return;
  }

  if(!validchallengetimer(challengename)) {
    return;
  }

  if(self.challengestarttime[challengename] > 0) {
    var_ac846be90e9552ab = gettime() - self.challengestarttime[challengename];

    if(var_ac846be90e9552ab > 0) {
      reportstat(challengename, var_ac846be90e9552ab);
    }

    self.challengestarttime[challengename] = 0;
  }
}

function checkandreportchallengetimer(challengename, elapsedtime) {
  if(!challengetimersenabledforplayer()) {
    return;
  }

  if(!validchallengetimer(challengename)) {
    return;
  }

  if(self.challengestarttime[challengename] > 0) {
    var_ac846be90e9552ab = gettime() - self.challengestarttime[challengename];

    if(var_ac846be90e9552ab >= elapsedtime) {
      reportstat(challengename, var_ac846be90e9552ab);
      self.challengestarttime[challengename] = gettime();
    }
  }
}

function trackchallengetimers() {
  level endon("game_ended");

  while(true) {
    if(isDefined(level.players)) {
      totalplayers = level.players.size;

      for(i = 0; i < totalplayers; i++) {
        if(isalive(level.players[i])) {
          level.players[i] checkandreportchallengetimer("driving", 60000);
        }
      }
    }

    wait 1;
  }
}

function function_11cf26edf87d512() {
  while(true) {
    wait 0.1;

    if(getdvarint(@ "hash_48ae63d778571691", 0)) {
      continue;
    }

    level.var_9d841fd2fd3b4182 = 0;
    closefile(level.var_37bf270d2c55a0c7);
    level.var_37bf270d2c55a0c7 = undefined;
    return;
  }
}

function function_7d97a2a745e514c4(event, params) {
  if(!getdvarint(@ "hash_48ae63d778571691", 0)) {
    return;
  }

  if(!isDefined(level.var_9d841fd2fd3b4182)) {
    thread function_11cf26edf87d512();
    level.var_9d841fd2fd3b4182 = 1;
  }

  filename = getDvar(@ "hash_7276451aeafc2854", "<dev string:x1c>");
  activatechallengeid = getDvar(@ "hash_4164d219a03096db", "<dev string:x37>");

  if(!isDefined(level.var_37bf270d2c55a0c7)) {
    level.var_8a69c8a5e52a8a84 = 0;
    level.var_37bf270d2c55a0c7 = openfile(filename, "<dev string:x40>");
    fprintln(level.var_37bf270d2c55a0c7, "<dev string:x49>");
    fprintln(level.var_37bf270d2c55a0c7, "<dev string:x58>");
    fprintln(level.var_37bf270d2c55a0c7, "<dev string:x7e>");
    fprintln(level.var_37bf270d2c55a0c7, "<dev string:x90>" + level.var_8a69c8a5e52a8a84 + "<dev string:xba>");
    fprintln(level.var_37bf270d2c55a0c7, "<dev string:xc0>");
    fprintln(level.var_37bf270d2c55a0c7, "<dev string:xe0>");
    fprintln(level.var_37bf270d2c55a0c7, "<dev string:xf3>");
    fprintln(level.var_37bf270d2c55a0c7, "<dev string:x118>");
    fprintln(level.var_37bf270d2c55a0c7, "<dev string:x13d>" + activatechallengeid + "<dev string:x153>");
    level.var_8a69c8a5e52a8a84 += 1;
    level.var_ba27ec806279b044 = [];
    nextrow = -1;

    while(true) {
      nextrow += 1;

      if(nextrow >= tablelookupgetnumrows("<dev string:x169>")) {
        break;
      }

      eventkeys = tablelookupbyrow("<dev string:x169>", nextrow, 5);

      if(!isDefined(eventkeys) || eventkeys == "<dev string:x182>") {
        continue;
      }

      var_e69af3c2055e35eb = int(tablelookupbyrow("<dev string:x169>", nextrow, 0));

      foreach(keyname in strtok(eventkeys, "<dev string:x186>")) {
        var_c94a0bb0d9c971a2 = int(tablelookup("<dev string:x18b>", 1, keyname, 0));
        keytype = tablelookup("<dev string:x18b>", 1, keyname, 2);
        var_289dd4d247bd6d9d = tablelookup("<dev string:x18b>", 1, keyname, 3);
        level.var_ba27ec806279b044[var_e69af3c2055e35eb]["<dev string:x1a8>"][var_c94a0bb0d9c971a2]["<dev string:x1b0>"] = keyname;
        level.var_ba27ec806279b044[var_e69af3c2055e35eb]["<dev string:x1a8>"][var_c94a0bb0d9c971a2]["<dev string:x1b8>"] = keytype;
        bitfield = [];

        foreach(bitpair in strtok(var_289dd4d247bd6d9d, "<dev string:x186>")) {
          var_2f4385dec49b4cbf = strtok(bitpair, "<dev string:x1c0>");
          bitname = var_2f4385dec49b4cbf[0];
          bitshift = int(var_2f4385dec49b4cbf[1]);
          bitfield[bitshift] = bitname;
        }

        level.var_ba27ec806279b044[var_e69af3c2055e35eb]["<dev string:x1a8>"][var_c94a0bb0d9c971a2]["<dev string:x1c5>"] = bitfield;
      }
    }
  }

  eventstring = tablelookup("<dev string:x169>", 0, event, 1);
  fprintln(level.var_37bf270d2c55a0c7, "<dev string:x182>");
  fprintln(level.var_37bf270d2c55a0c7, "<dev string:x49>");
  fprintln(level.var_37bf270d2c55a0c7, "<dev string:x1d1>" + eventstring);
  fprintln(level.var_37bf270d2c55a0c7, "<dev string:x1e4>" + event);
  fprintln(level.var_37bf270d2c55a0c7, "<dev string:x90>" + level.var_8a69c8a5e52a8a84 + "<dev string:xba>");
  fprintln(level.var_37bf270d2c55a0c7, "<dev string:x1f4>" + eventstring);
  fprintln(level.var_37bf270d2c55a0c7, "<dev string:xe0>");
  k = 0;

  while(k < params.size) {
    key = params[k];
    value = params[k + 1];
    keystring = "<dev string:x182>";
    keytype = "<dev string:x182>";
    keydescription = "<dev string:x182>";

    if(isDefined(level.var_ba27ec806279b044[int(event)]["<dev string:x1a8>"][key])) {
      keydata = level.var_ba27ec806279b044[int(event)]["<dev string:x1a8>"][key];
      keystring = keydata["<dev string:x1b0>"];
      keytype = keydata["<dev string:x1b8>"];
      var_289dd4d247bd6d9d = keydata["<dev string:x1c5>"];

      if(isDefined(value)) {
        if(keytype == "<dev string:x1c5>") {
          bitarray = function_3005ef56488df9be(value);

          for(n = 0; n < var_289dd4d247bd6d9d.size; n++) {
            if(!isDefined(bitarray[n]) || !bitarray[n]) {
              continue;
            }

            if(keydescription.size > 0) {
              keydescription += "<dev string:x186>";
            }

            keydescription += var_289dd4d247bd6d9d[n];
          }

          if(keydescription == "<dev string:x182>") {
            keydescription = "<dev string:x207>";
          }

          keydescription = "<dev string:x20c>" + keydescription;
        } else if(keystring == "<dev string:x212>" || keystring == "<dev string:x224>" || keystring == "<dev string:x237>") {
          keydescription = "<dev string:x20c>" + tablelookup("<dev string:x24d>", 0, value, 1);
        } else if(keystring == "<dev string:x26d>" || keystring == "<dev string:x283>" || keystring == "<dev string:x292>" || keystring == "<dev string:x2a5>") {
          keydescription = "<dev string:x20c>" + tablelookup("<dev string:x2bd>", 0, value, 2) + "<dev string:x2d5>" + tablelookup("<dev string:x2bd>", 0, value, 1) + "<dev string:x2db>";
        }
      }
    } else {
      keystring = tablelookup("<dev string:x18b>", 0, key, 1) + "<dev string:x2e0>";
    }

    comment = "<dev string:x182>";

    if(!isDefined(value)) {
      comment = "<dev string:x2f8>";
      value = "<dev string:x2fd>";
    }

    fprintln(level.var_37bf270d2c55a0c7, "<dev string:x30c>" + comment + "<dev string:x31c>" + key + "<dev string:x321>" + value + "<dev string:x328>" + keystring + "<dev string:x32f>" + keydescription);
    k += 2;
  }

  fprintln(level.var_37bf270d2c55a0c7, "<dev string:x182>");
  level.var_8a69c8a5e52a8a84 += 1;
}

function onplayerkilled(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }

  victim = self;

  if(!isPlayer(attacker)) {
    if(isDefined(inflictor) && isPlayer(inflictor)) {
      attacker = inflictor;
    } else {
      return;
    }
  }

  if(utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim)) {
      objweapon = attacker weapon_utility::function_1e3102980c3a4cc1(objweapon);
      modifiers1 = 0;
      modifiers2 = 0;
      modifiers3 = 0;
      attachmentflags = 0;
      hitloc = 0;

      if(isDefined(modifiers)) {
        modifiers1 = modifiers["mask"];

        if(isDefined(modifiers["mask2"])) {
          modifiers2 = modifiers["mask2"];
        }

        if(isDefined(modifiers["mask3"])) {
          modifiers3 = modifiers["mask3"];
        }

        attachmentflags = modifiers["attachment_flags"];
        hitloc = modifiers["hit_loc"];
      }

      victimstruct = function_137b512700167b00(attacker, victim);
      reportkillchallengeevent(attacker, victimstruct, modifiers1, modifiers2, modifiers3, objweapon, damage, meansofdeath, attachmentflags, hitloc);
    }
  }
}

function function_5a0ae8bc2b80c0c0(inflictor, attacker, damage, meansofdeath, objweapon, hitloc, modifiers, var_1d68c79557cc54ea, victim_team, var_bafbdb422ea9eaae) {
  if(!isDefined(inflictor)) {
    println("<dev string:x334>");
    return;
  }

  if(!isDefined(attacker)) {
    assertmsg("<dev string:x388>");
    return;
  }

  if(!isDefined(meansofdeath) || meansofdeath.size == 0) {
    assertmsg("<dev string:x3d2>");
    return;
  }

  if(!isDefined(objweapon)) {
    assertmsg("<dev string:x420>");
    return;
  }

  if(!attacker challengesenabledforplayer()) {
    return;
  }

  if(!isPlayer(attacker)) {
    if(isDefined(inflictor) && isPlayer(inflictor)) {
      attacker = inflictor;
    } else {
      return;
    }
  }

  if(isDefined(victim_team) && isDefined(attacker.team) && victim_team != attacker.team) {
    objweapon = attacker weapon_utility::function_1e3102980c3a4cc1(objweapon);
    modifiers1 = 0;
    modifiers2 = 0;
    modifiers3 = 0;
    attachmentflags = 0;
    hitloc = 0;

    if(isDefined(modifiers)) {
      modifiers1 = modifiers["mask"];

      if(isDefined(modifiers["mask2"])) {
        modifiers2 = modifiers["mask2"];
      }

      if(isDefined(modifiers["mask3"])) {
        modifiers3 = modifiers["mask3"];
      }

      attachmentflags = modifiers["attachment_flags"];
      hitloc = modifiers["hit_loc"];
    }

    reportkillchallengeevent(attacker, var_bafbdb422ea9eaae, modifiers1, modifiers2, modifiers3, objweapon, damage, meansofdeath, attachmentflags, hitloc, var_1d68c79557cc54ea);
  }
}

function vehiclekilled(vehicle, attacker, damage, objweapon) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }

  victim = vehicle;
  objweapon = attacker weapon_utility::function_1e3102980c3a4cc1(objweapon);
  meansofdeath = "MOD_UNKNOWN";
  modifiers1 = 0;
  modifiers2 = 0;
  modifiers3 = 0;
  attachmentflags = 0;
  hitloc = 0;
  attackervehicle = attacker player_utility::getvehicle(1);

  if(isDefined(attackervehicle)) {
    modifiers1 = scripts\cp_mp\challenges::function_6d40f12a09494350(modifiers1, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"invehicle"));

    if(attackervehicle scripts\common\vehicle::ishelicopter()) {
      modifiers2 = scripts\cp_mp\challenges::function_6d40f12a09494350(modifiers2, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"from_helicopter"));
    } else if(attackervehicle.vehiclename == "veh9_mil_lnd_mrap") {
      modifiers2 = scripts\cp_mp\challenges::function_6d40f12a09494350(modifiers2, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"hash_dbaf3685f1412e50"));
    }
  }

  platform = attacker getmovingplatformparent();

  if(isDefined(platform) && platform scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(istrue(platform.isheli)) {
      modifiers2 = scripts\cp_mp\challenges::function_6d40f12a09494350(modifiers2, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"from_helicopter"));
      ref = platform scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();

      if(ref == "veh9_palfa") {
        modifiers2 = function_6d40f12a09494350(modifiers2, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"hash_71e5f339792a9ef6"));
      }
    }

    if(!isDefined(attackervehicle) || platform != attackervehicle) {
      ref = scripts\cp_mp\utility\train_utility::function_e58b746157089c68(platform);

      if(isDefined(ref) && (ref == "cargo_train" || ref == "br_passenger_train")) {
        modifiers1 = scripts\cp_mp\challenges::function_6d40f12a09494350(modifiers1, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"ontrain"));

        if(ref == "cargo_train") {
          modifiers2 = scripts\cp_mp\challenges::function_6d40f12a09494350(modifiers2, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"on_cargo_train"));
        } else if(ref == "br_passenger_train") {
          modifiers2 = scripts\cp_mp\challenges::function_6d40f12a09494350(modifiers2, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e71c1787fdc7", #"hash_8345a13afbaa0f66"));
        }
      } else {
        modifiers1 = scripts\cp_mp\challenges::function_6d40f12a09494350(modifiers1, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"vehiclesurf"));

        if(platform.classname == "script_vehicle" && platform vehicle_getspeed() > 25) {
          modifiers1 = function_6d40f12a09494350(modifiers1, ae_utility::function_e2ff8f4b4e94f723(#"hash_7f94e81c1787ff7a", #"infastvehicle"));
        }
      }
    }
  }

  if(issharedfuncdefined("pmc_missions", "onVehicleDestroyed")) {
    level thread[[getsharedfunc("pmc_missions", "onVehicleDestroyed")]](vehicle);
  }

  victimstruct = function_137b512700167b00(attacker, victim);

  if(isDefined(level.var_9dd45392c2bffc71) && isDefined(level.var_9dd45392c2bffc71["id_assignPlayerKillModifiersTrimmed"])) {
    attacker[[level.var_9dd45392c2bffc71["id_assignPlayerKillModifiersTrimmed"]]](victimstruct, objweapon, meansofdeath, attacker);
    modifiers = attacker.modifiers;

    if(isDefined(victimstruct.team) && isDefined(attacker.team) && victimstruct.team != attacker.team) {
      modifiers1 = 0;
      modifiers2 = 0;
      modifiers3 = 0;
      attachmentflags = 0;
      hitloc = 0;

      if(isDefined(modifiers)) {
        modifiers1 = modifiers["mask"];

        if(isDefined(modifiers["mask2"])) {
          modifiers2 = modifiers["mask2"];
        }

        if(isDefined(modifiers["mask3"])) {
          modifiers3 = modifiers["mask3"];
        }

        attachmentflags = modifiers["attachment_flags"];
        hitloc = modifiers["hit_loc"];
      }
    }
  }

  reportkillchallengeevent(attacker, victimstruct, modifiers1, modifiers2, modifiers3, objweapon, damage, meansofdeath, attachmentflags, hitloc);
}

function function_bd4827ad81a943a(vehicle, damagedata) {
  if(!isDefined(vehicle) || !isDefined(damagedata) || !isDefined(damagedata.attacker) || !isPlayer(damagedata.attacker) || !damagedata.attacker challengesenabledforplayer()) {
    return;
  }

  function_8359cadd253f9604(damagedata.attacker, "pop_vehicle_tire", 1);
}

function equipmentdestroyed(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }

  victim = self;

  if(!isPlayer(attacker)) {
    if(isDefined(inflictor) && isPlayer(inflictor)) {
      attacker = inflictor;
    } else {
      return;
    }
  }

  if(!isDefined(victim.owner)) {
    return;
  }

  if(utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim.owner)) {
      objweapon = attacker weapon_utility::function_1e3102980c3a4cc1(objweapon);
      modifiers1 = 0;
      modifiers2 = 0;
      modifiers3 = 0;
      attachmentflags = 0;

      if(isDefined(modifiers)) {
        modifiers1 = modifiers["mask"];

        if(isDefined(modifiers["mask2"])) {
          modifiers2 = modifiers["mask2"];
        }

        if(isDefined(modifiers["mask3"])) {
          modifiers3 = modifiers["mask3"];
        }

        attachmentflags = modifiers["attachment_flags"];
      }

      victimstruct = function_137b512700167b00(attacker, victim);
      reportkillchallengeevent(attacker, victimstruct, modifiers1, modifiers2, modifiers3, objweapon, damage, meansofdeath, attachmentflags, hitloc);
    }
  }
}

function killstreakkilled(killstreakname, owner, streakent, attacker, damage, damagetype, objweapon, scorepopupname) {
  if(!isDefined(attacker) || !attacker challengesenabledforplayer()) {
    return;
  }

  victim = self;

  if(!isPlayer(attacker)) {
    return;
  }

  if(!isDefined(victim.owner)) {
    return;
  }

  if(utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim.owner)) {
      objweapon = attacker weapon_utility::function_1e3102980c3a4cc1(objweapon);
      meansofdeath = "MOD_UNKNOWN";
      modifiers1 = 0;
      modifiers2 = 0;
      modifiers3 = 0;
      attachmentflags = 0;
      hitloc = 0;

      if(isDefined(attacker.modifiers)) {
        if(isDefined(attacker.modifiers["mask"])) {
          modifiers1 = attacker.modifiers["mask"];
        }

        if(isDefined(attacker.modifiers["mask2"])) {
          modifiers2 = attacker.modifiers["mask2"];
        }

        if(isDefined(attacker.modifiers["mask3"])) {
          modifiers3 = attacker.modifiers["mask3"];
        }

        if(isDefined(attacker.modifiers["attachment_flags"])) {
          attachmentflags = attacker.modifiers["attachment_flags"];
        }
      }

      victimstruct = function_137b512700167b00(attacker, victim);
      reportkillchallengeevent(attacker, victimstruct, modifiers1, modifiers2, modifiers3, objweapon, damage, meansofdeath, attachmentflags, hitloc);
    }
  }
}

function function_5b2c23ea4889f30b(invalue) {
  var_9d9f97a53c1e5d06 = invalue;

  if(issharedfuncdefined("poi", "try_TranslatePOI")) {
    var_9d9f97a53c1e5d06 = [[getsharedfunc("poi", "try_TranslatePOI")]](var_9d9f97a53c1e5d06);
  }

  return var_9d9f97a53c1e5d06;
}

function function_8359cadd253f9604(player, type, quantity, var_afda85311c8ed272, lootid, var_f237807396377232) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(var_afda85311c8ed272)) {
    var_afda85311c8ed272 = 1;
  }

  itemrarity = 0;

  if(isDefined(var_f237807396377232)) {
    itemrarity = var_f237807396377232.rarity;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  location = 0;
  location2 = 0;
  typeid = 0;

  if(isDefined(type)) {
    typeid = ae_utility::function_7042dad035dc176c(type);
  }

  if(isDefined(player.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(player.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(player.closestpoi));
  }

  aeeventname = #"collect_item";
  gamemode = function_68ffb11dc4c6b979(gamemode, aeeventname);
  gametype = function_68ffb11dc4c6b979(gametype, aeeventname);
  typeid = function_68ffb11dc4c6b979(typeid, aeeventname);
  location = function_68ffb11dc4c6b979(location, aeeventname);
  location2 = function_68ffb11dc4c6b979(location2, aeeventname);
  itemrarity = function_68ffb11dc4c6b979(itemrarity, aeeventname);
  quantity = function_68ffb11dc4c6b979(quantity, aeeventname);
  lootid = function_68ffb11dc4c6b979(lootid, aeeventname);
  function_8e81148472fb520a(player, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), quantity, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), lootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"zm_rarity"), itemrarity], var_afda85311c8ed272);
}

function function_5c3aa65db46763ff(vehicle, type) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(vehicle) || !isDefined(type)) {
    return;
  }

  vehiclename = findenemytype(vehicle)[0];
  vehiclename2 = function_8435d79a41ea37b0(vehicle);
  gametype = function_17c5d7feb226e256();
  typeid = ae_utility::function_7042dad035dc176c(type);
  location = 0;
  location2 = 0;

  if(isDefined(self.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(self.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(self.closestpoi));
  }

  gamemode = getchallengegamemode(self);
  aeeventname = #"vehicle";
  gamemode = function_68ffb11dc4c6b979(gamemode, aeeventname);
  gametype = function_68ffb11dc4c6b979(gametype, aeeventname);
  typeid = function_68ffb11dc4c6b979(typeid, aeeventname);
  location = function_68ffb11dc4c6b979(location, aeeventname);
  location2 = function_68ffb11dc4c6b979(location2, aeeventname);
  vehiclename = function_68ffb11dc4c6b979(vehiclename, aeeventname);
  vehiclename2 = function_68ffb11dc4c6b979(vehiclename2, aeeventname);
  function_8e81148472fb520a(self, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e2f5c601b57b3960"), vehiclename, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_22d8c6e760626656"), vehiclename2]);
  println("<dev string:x464>" + type);
}

function function_70abd486ae26235(player, type, quantity, var_afda85311c8ed272) {
  if(!isPlayer(player)) {
    return;
  }

  if(!player challengesenabledforplayer()) {
    return;
  }

  gametype = function_17c5d7feb226e256();
  typeid = ae_utility::function_7042dad035dc176c(type);
  location = 0;
  location2 = 0;

  if(isDefined(player.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(player.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(player.closestpoi));
  }

  gamemode = getchallengegamemode(player);
  aeeventname = #"unlock";
  function_8e81148472fb520a(player, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), quantity, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2], var_afda85311c8ed272);
  println("<dev string:x49b>" + type);
}

function function_b0f754c8a379154e(equipment, player, dist, eventtypebit, value) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  var_4adb82c833e8d5ab = function_3ea2b9fa713d6ed3(player);
  var_4adb83c833e8d7de = function_3ea2b9fa713d6ed3(player, 2);
  location = 0;
  location2 = 0;

  if(isDefined(player.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(player.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(player.closestpoi));
  }

  equipmentid = 0;
  equipmentid = loot::getlootidfromref(equipment);

  if(isDefined(value) && value < 0) {
    value = 0;
  }

  bitfield = 0;
  bitfield = function_6d40f12a09494350(bitfield, eventtypebit);
  aeeventname = #"equipment";
  function_8e81148472fb520a(player, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), value, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), equipmentid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"distance"), dist, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bd518e95df4103fe"), var_4adb82c833e8d5ab, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bd518d95df41024b"), var_4adb83c833e8d7de, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_83a2d67994d7e295"), bitfield]);
}

function function_57f4ba1fd9ececba(player) {
  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  placement = 0;

  if(isDefined(player.teamplacement) && player.teamplacement > 0) {
    placement = player.teamplacement;
  }

  var_ea6974f3b567cbaa = 0;

  if(isDefined(player.gulaguses) && player.gulaguses > 0) {
    var_ea6974f3b567cbaa = function_6d40f12a09494350(var_ea6974f3b567cbaa, ae_utility::function_e2ff8f4b4e94f723(#"hash_b4508a899f18c65", #"hash_16c4738561824b4b"));
  }

  aeeventname = #"match_placement";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"placement"), placement, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_b4508a899f18c65"), var_ea6974f3b567cbaa];
  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_b5929663421247fa(player, result, winner) {
  if(!isDefined(player)) {
    assertmsg("<dev string:x4d0>");
    return;
  }

  if(!player challengesenabledforplayer()) {
    return;
  }

  operatorlootid = player function_aff35122a61a900b(player.team);

  if(!isDefined(operatorlootid)) {
    operatorlootid = 0;
  }

  gamemode = getchallengegamemode(player);
  teamsize = 0;

  if(gamemode & 8) {
    teamsize = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();
  }

  placement = 0;

  if(isDefined(player.teamplacement) && player.teamplacement > 0) {
    placement = player.teamplacement;
  }

  playlistid = getplaylistid();
  lobbyid = function_4f9373a1227db35c();
  location = 0;
  location2 = 0;

  if(isDefined(player.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(player.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(player.closestpoi));
  }

  var_8142a29197569218 = 0;

  if(isDefined(player.pers) && isDefined(player.pers["kills"])) {
    if(player.pers["kills"] >= 15) {
      var_8142a29197569218 = function_6d40f12a09494350(var_8142a29197569218, ae_utility::function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"15kills"));
    }
  }

  if(!istrue(player.disconnecting) || isDefined(level.endgamewinner)) {
    if(utility::issharedfuncdefined("score", "getHighestScoringPlayer")) {
      winningplayer = [[utility::getsharedfunc("score", "getHighestScoringPlayer")]]();

      if(isDefined(winningplayer) && winningplayer == player) {
        var_8142a29197569218 = function_6d40f12a09494350(var_8142a29197569218, ae_utility::function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_de6c2ec52bf2a850"));
      }
    }
  }

  if(isDefined(player.gulaguses) && player.gulaguses > 0) {
    var_8142a29197569218 = function_6d40f12a09494350(var_8142a29197569218, ae_utility::function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_16c4738561824b4b"));
  }

  if(isDefined(level.secondaryvictory) && istrue(player.extracted)) {
    var_8142a29197569218 = function_6d40f12a09494350(var_8142a29197569218, ae_utility::function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_cca3beee360a3bdd"));
  }

  if(isDefined(level.var_8fc589b1edff1fb2) && istrue(level.var_8fc589b1edff1fb2[player.guid])) {
    var_8142a29197569218 = function_6d40f12a09494350(var_8142a29197569218, ae_utility::function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_600ba733abaa2896"));
  }

  if(istrue(player.var_ded04cdd264a7e00)) {
    var_8142a29197569218 = function_6d40f12a09494350(var_8142a29197569218, ae_utility::function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_4f5ea2cfeb163c9d"));
  }

  var_6bd1aebdc320269c = getdvarint(@ "hash_d5a1ed391dd67630", 0);

  if(var_6bd1aebdc320269c) {
    var_8142a29197569218 = function_6d40f12a09494350(var_8142a29197569218, ae_utility::function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_f04084f13423c3b4"));
  }

  if(isDefined(level.arrow)) {
    if(istrue(level.arrow.var_c93fb612b08a50d1) && isDefined(level.arrow.var_a21db1ee260a96c3) && level.arrow.var_a21db1ee260a96c3 == player.team) {
      var_8142a29197569218 = function_6d40f12a09494350(var_8142a29197569218, ae_utility::function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_e4efa895facf6b7b"));
    }

    if(istrue(level.arrow.endingdetonated)) {
      var_8142a29197569218 = function_6d40f12a09494350(var_8142a29197569218, ae_utility::function_e2ff8f4b4e94f723(#"hash_8dd9828579063e7", #"hash_65ecff89121dd351"));
    }
  }

  objtime = 0;

  if(isDefined(player.pers) && isDefined(player.pers["objTime"])) {
    objtime = player.pers["objTime"];
  }

  if(!isDefined(player.var_1949291e417ccc24)) {
    player.var_1949291e417ccc24 = 0;
  }

  if(!isDefined(player.kills)) {
    player.kills = 0;
  }

  partysize = default_to(player getprivatepartysize(), 1);
  gametype = function_17c5d7feb226e256();
  var_bb38571cca0414f = function_c1945f26d99b0ed9(player);
  aeeventname = #"end_match";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"match_result"), result, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_8dd9828579063e7"), var_8142a29197569218, ae_utility::function_d6f771aedba70ce7(aeeventname, #"placement"), placement, ae_utility::function_d6f771aedba70ce7(aeeventname, #"playlist_id"), playlistid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"team_size"), teamsize, ae_utility::function_d6f771aedba70ce7(aeeventname, #"lobby_id"), lobbyid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287b83e723dcd4"), var_bb38571cca0414f[0], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287c83e723de87"), var_bb38571cca0414f[1], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287d83e723e03a"), var_bb38571cca0414f[2], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287e83e723e1ed"), var_bb38571cca0414f[3], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287783e723d608"), var_bb38571cca0414f[4], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"match_id"), function_94c7ae7049488358(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"objective_time"), objtime, ae_utility::function_d6f771aedba70ce7(aeeventname, #"reload_amount"), player.var_1949291e417ccc24, ae_utility::function_d6f771aedba70ce7(aeeventname, #"kill_amount"), player.kills, ae_utility::function_d6f771aedba70ce7(aeeventname, #"party_size"), partysize];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_8df2c1c1377b79be(cashvalue) {
  return cashvalue * 10;
}

function function_dc52e14b64052dda(lootid, quantity) {
  if(isDefined(lootid)) {
    scriptablename = loot::getscriptablefromlootid(lootid);

    if(isDefined(scriptablename)) {
      if(lootid == 8395) {
        return function_8df2c1c1377b79be(quantity);
      }

      if(utility::issharedfuncdefined("pickups", "isDogTag") && [[utility::getsharedfunc("pickups", "isDogTag")]](scriptablename) || utility::issharedfuncdefined("pickups", "isGasMask") && [[utility::getsharedfunc("pickups", "isGasMask")]](scriptablename)) {
        return 1;
      }
    }
  }

  return quantity;
}

function function_1ba256da09a9878a(player, lootid, lootref, loottype, quantity, cashvalue, var_e7d05247043893ad, var_f237807396377232, var_1e3b09444dc30b1b) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gametype = function_17c5d7feb226e256();
  gamemode = getchallengegamemode(player);
  var_99bd169488e48ac1 = 0;
  typeid = 0;

  if(!isDefined(var_f237807396377232)) {
    if(isDefined(lootref)) {
      var_99bd169488e48ac1 = ae_utility::function_7042dad035dc176c(lootref);
    }

    if(isDefined(lootid)) {
      typeid = function_c43d8b7a5461cdce(lootid);
      typeid = ter_op(isDefined(typeid), typeid, 0);
    }

    if(isDefined(loottype) && typeid == 0) {
      typeid = ae_utility::function_7042dad035dc176c(loottype);
    }

    quantity = function_dc52e14b64052dda(lootid, quantity);
    cashvalue = function_8df2c1c1377b79be(cashvalue);
  }

  location = 0;
  location2 = 0;

  if(isDefined(self.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(self.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(self.closestpoi));
  }

  var_f6eb539d20b3ab44 = 0;

  if(istrue(var_1e3b09444dc30b1b)) {
    bitid = ae_utility::function_e2ff8f4b4e94f723(#"hash_54e349112fcb5cd8", #"hash_fc5a7e86e1b3ad93");
    var_f6eb539d20b3ab44 = function_6d40f12a09494350(var_f6eb539d20b3ab44, bitid);
  }

  aeeventname = #"buy_item";
  itemrarity = 0;
  var_7d9803744a905b95 = 0;
  var_48c0c20123a7896a = 0;

  if(isDefined(var_f237807396377232)) {
    itemrarity = var_f237807396377232.rarity;
    var_7d9803744a905b95 = var_f237807396377232.var_7d9803744a905b95;
    var_48c0c20123a7896a = var_f237807396377232.pap_level;
  }

  gamemode = function_68ffb11dc4c6b979(gamemode, aeeventname);
  gametype = function_68ffb11dc4c6b979(gametype, aeeventname);
  typeid = function_68ffb11dc4c6b979(typeid, aeeventname);
  location = function_68ffb11dc4c6b979(location, aeeventname);
  location2 = function_68ffb11dc4c6b979(location2, aeeventname);
  itemrarity = function_68ffb11dc4c6b979(itemrarity, aeeventname);
  quantity = function_68ffb11dc4c6b979(quantity, aeeventname);
  var_e7d05247043893ad = function_68ffb11dc4c6b979(var_e7d05247043893ad, aeeventname);
  var_99bd169488e48ac1 = function_68ffb11dc4c6b979(var_99bd169488e48ac1, aeeventname);
  lootid = function_68ffb11dc4c6b979(lootid, aeeventname);
  cashvalue = function_68ffb11dc4c6b979(cashvalue, aeeventname);
  var_7d9803744a905b95 = function_68ffb11dc4c6b979(var_7d9803744a905b95, aeeventname);
  var_48c0c20123a7896a = function_68ffb11dc4c6b979(var_48c0c20123a7896a, aeeventname);
  var_f6eb539d20b3ab44 = function_68ffb11dc4c6b979(var_f6eb539d20b3ab44, aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"string_ref"), var_99bd169488e48ac1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), quantity, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), lootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d7806c74c1d4a500"), typeid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"cash_value"), cashvalue, ae_utility::function_d6f771aedba70ce7(aeeventname, #"buy_action"), var_e7d05247043893ad, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"zm_rarity"), itemrarity, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e6b742f2dbcdaa7a"), var_7d9803744a905b95, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c1df2daa62247afe"), var_48c0c20123a7896a, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_54e349112fcb5cd8"), var_f6eb539d20b3ab44];
  function_8e81148472fb520a(player, aeeventname, params);
}

function function_affb3af6af110594(player, activitytype, poi) {
  gametype = function_17c5d7feb226e256();
  gamemode = getchallengegamemode(player);
  location = 0;
  location2 = 0;

  if(isDefined(poi)) {
    location = getlocation(poi);
    location2 = function_55be16fb0f5f4a19(poi);
  }

  aeeventname = #"start_activity";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"activity_type"), activitytype ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_2635cdb5e985eaab(player, activitytype, poi) {
  gametype = function_17c5d7feb226e256();
  gamemode = getchallengegamemode(player);
  location = 0;
  location2 = 0;

  if(isDefined(poi)) {
    location = getlocation(poi);
    location2 = function_55be16fb0f5f4a19(poi);
  }

  aeeventname = #"end_activity";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"activity_type"), activitytype ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_f4d8c689aaf296e5(player, weapon, healthdamage, armordamage) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  if(isagent(player)) {
    return;
  }

  if(!isDefined(weapon)) {
    return;
  }

  var_b28608820870666 = function_ce112254f7cba89e(weapon);

  if(!isDefined(var_b28608820870666)) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  damagetotal = healthdamage + armordamage;
  aeeventname = #"weapon_damage";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_a0dd9c7405f2d85e"), var_b28608820870666, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), damagetotal];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_4ab6f9fba6bb9cc5(player, healthdamage, armordamage) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  if(isagent(player)) {
    return;
  }

  if(!isDefined(healthdamage)) {
    healthdamage = 0;
  }

  healthdamage = int(healthdamage);

  if(!isDefined(armordamage)) {
    armordamage = 0;
  }

  armordamage = int(armordamage);
  var_6ddcf3c092eaf383 = level.var_ec851999e0e99879;

  if(!isDefined(var_6ddcf3c092eaf383)) {
    var_6ddcf3c092eaf383 = function_6b7aeb2012efc4af();
  }

  aeeventname = #"damaged";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);

  if(!isDefined(level.var_1511634f42f188a6)) {
    level.var_1511634f42f188a6 = [];
  }

  if(!isDefined(level.var_a7f8fb431b350d82)) {
    level.var_a7f8fb431b350d82 = [];
  }

  if(!istrue(level.var_a7f8fb431b350d82[#"reportstats"])) {
    level.var_1511634f42f188a6[#"version"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"version");
    level.var_1511634f42f188a6[#"gamemode"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode");
    level.var_1511634f42f188a6[#"gametype"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype");
    level.var_1511634f42f188a6[#"damage_type"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"damage_type");
    level.var_1511634f42f188a6[#"value"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"value");
    level.var_1511634f42f188a6[#"hash_2330531abd5ccdac"] = ae_utility::function_e2ff8f4b4e94f723(#"damage_type", #"health");
    level.var_1511634f42f188a6[#"hash_756cdafda9ab288d"] = ae_utility::function_e2ff8f4b4e94f723(#"damage_type", #"armor");
  }

  paramcache = level.var_1511634f42f188a6;
  var_eeff650640a93fe1 = 0;

  if(healthdamage > 0) {
    var_eeff650640a93fe1 = function_6d40f12a09494350(var_eeff650640a93fe1, paramcache[#"hash_2330531abd5ccdac"]);
  }

  if(armordamage > 0) {
    var_eeff650640a93fe1 = function_6d40f12a09494350(var_eeff650640a93fe1, paramcache[#"hash_756cdafda9ab288d"]);
  }

  eventparams = [paramcache[#"version"], 1, paramcache[#"gamemode"], var_6ddcf3c092eaf383.gamemode, paramcache[#"gametype"], var_6ddcf3c092eaf383.gametype, paramcache[#"damage_type"], var_eeff650640a93fe1, paramcache[#"value"], healthdamage + armordamage];

  function_7d97a2a745e514c4(aeeventid, eventparams);

  player reportchallengeuserserializedeventwrapper(aeeventid, eventparams);
}

function function_b4b8d881af22f7bd(player, weapon) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  if(isagent(player)) {
    return;
  }

  if(!isDefined(weapon)) {
    return;
  }

  var_b28608820870666 = function_ce112254f7cba89e(weapon);
  weaponlootid = weapon::getweaponlootid(weapon);
  var_5c1805bb8abe637c = isDefined(player.var_5c1805bb8abe637c) ? player.var_5c1805bb8abe637c : 0;

  if(!isDefined(var_b28608820870666) || !isDefined(weaponlootid)) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  aeeventname = #"reload";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  var_c78bf6b063fc5789 = default_to(player.var_c78bf6b063fc5789, 0);
  var_6c8527bddb06741d = 0;

  if(var_5c1805bb8abe637c) {
    var_6c8527bddb06741d = scripts\cp_mp\challenges::function_6d40f12a09494350(var_6c8527bddb06741d, function_e2ff8f4b4e94f723(#"hash_9b42cd62a982eb88", #"hash_6d190b2e7aefb9a0"));
  }

  if(issharedfuncdefined("weapons", "recommendedStatusBySeason")) {
    var_2420b2d3569c0c6 = [[utility::getsharedfunc("weapons", "recommendedStatusBySeason")]](player.primaryweaponobj, player);

    if(isDefined(var_2420b2d3569c0c6)) {
      if(var_2420b2d3569c0c6[0]) {
        var_6c8527bddb06741d = function_6d40f12a09494350(var_6c8527bddb06741d, ae_utility::function_e2ff8f4b4e94f723(#"hash_9b42cd62a982eb88", #"recommended_season_0"));
      }

      if(var_2420b2d3569c0c6[1]) {
        var_6c8527bddb06741d = function_6d40f12a09494350(var_6c8527bddb06741d, ae_utility::function_e2ff8f4b4e94f723(#"hash_9b42cd62a982eb88", #"recommended_season_1"));
      }

      if(var_2420b2d3569c0c6[2]) {
        var_6c8527bddb06741d = function_6d40f12a09494350(var_6c8527bddb06741d, ae_utility::function_e2ff8f4b4e94f723(#"hash_9b42cd62a982eb88", #"recommended_season_2"));
      }

      if(var_2420b2d3569c0c6[3]) {
        var_6c8527bddb06741d = function_6d40f12a09494350(var_6c8527bddb06741d, ae_utility::function_e2ff8f4b4e94f723(#"hash_9b42cd62a982eb88", #"recommended_season_3"));
      }

      if(var_2420b2d3569c0c6[4]) {
        var_6c8527bddb06741d = function_6d40f12a09494350(var_6c8527bddb06741d, ae_utility::function_e2ff8f4b4e94f723(#"hash_9b42cd62a982eb88", #"recommended_season_4"));
      }

      if(var_2420b2d3569c0c6[5]) {
        var_6c8527bddb06741d = function_6d40f12a09494350(var_6c8527bddb06741d, ae_utility::function_e2ff8f4b4e94f723(#"hash_9b42cd62a982eb88", #"recommended_season_5"));
      }

      if(var_2420b2d3569c0c6[6]) {
        var_6c8527bddb06741d = function_6d40f12a09494350(var_6c8527bddb06741d, ae_utility::function_e2ff8f4b4e94f723(#"hash_9b42cd62a982eb88", #"recommended_season_6"));
      }
    }
  }

  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_a0dd9c7405f2d85e"), var_b28608820870666, ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), weaponlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_9b42cd62a982eb88"), var_6c8527bddb06741d];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_d312ec9b34f1dfa(player) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  if(isagent(player)) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  aeeventname = #"on_hit";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  playlistid = getplaylistid();
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"playlist_id"), playlistid];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_fb2db8647d693699(player) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  aeeventname = #"downed";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_b8e86c6dea0ac027(player, streak) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  aeeventname = #"squad_wiped";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

  if(isDefined(streak)) {
    params[params.size] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"squad_wipe_streak");
    params[params.size] = streak;
  }

  function_7d97a2a745e514c4(aeeventid, params);
  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function ondeath(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  teamsize = 0;

  if(gamemode & 8) {
    teamsize = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();
  }

  in_prematch = istrue(level.inprematch);
  aeeventname = #"death";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"team_size"), teamsize, ae_utility::function_d6f771aedba70ce7(aeeventname, #"in_prematch"), in_prematch];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_868b6d4fbec3938c(player) {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  aeeventname = #"hash_672d2c0185c09e4e";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_5d99311b5a7dffda() {
  var_4fd3df97f86a664c = getdvarint(@ "hash_bd0f7ad1bb2671a5", -1);

  if(var_4fd3df97f86a664c >= 0) {
    return var_4fd3df97f86a664c;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(!isDefined(level.var_67b3435949f31707)) {
      level.var_67b3435949f31707 = 0;

      foreach(team in level.teamnamelist) {
        teamcount = level.teamdata[team]["teamCount"];

        if(isDefined(level.var_7b37b2193f163b9b)) {
          teamcount += level.teamdata[team]["UIBotCount"];
        }

        if(teamcount) {
          level.var_67b3435949f31707++;
        }
      }
    }

    return (level.var_67b3435949f31707 - 1);
  }

  if(isDefined(level.teamswithplayers)) {
    return int(max(level.teamswithplayers.size - 1, 0));
  }

  return 0;
}

function function_247ba07507f78ac2(victim, attacker, var_2c151652ca2c1756) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }

  if(utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim)) {
      gamemode = getchallengegamemode(attacker);
      gametype = function_17c5d7feb226e256();
      var_3fff36caeace1b84 = function_5d99311b5a7dffda();

      if(isDefined(level.var_c596a10a13c5cd7c)) {
        var_3fff36caeace1b84 = [[level.var_c596a10a13c5cd7c]](var_3fff36caeace1b84, victim);
      }

      weaponlootid = undefined;

      if(isDefined(attacker.primaryweaponobj)) {
        weaponlootid = weapon::getweaponlootid(attacker.primaryweaponobj);
      }

      if(!isDefined(weaponlootid)) {
        weaponlootid = 0;
      }

      if(issharedfuncdefined("weapons", "recommendedStatusBySeason")) {
        var_2420b2d3569c0c6 = [[utility::getsharedfunc("weapons", "recommendedStatusBySeason")]](attacker.primaryweaponobj, attacker);
        var_158bd631747ae80 = 0;

        if(isDefined(var_2420b2d3569c0c6)) {
          if(var_2420b2d3569c0c6[0]) {
            var_158bd631747ae80 = function_6d40f12a09494350(var_158bd631747ae80, ae_utility::function_e2ff8f4b4e94f723(#"hash_2d6d28e2d2af4ddc", #"recommended_season_0"));
          }

          if(var_2420b2d3569c0c6[1]) {
            var_158bd631747ae80 = function_6d40f12a09494350(var_158bd631747ae80, ae_utility::function_e2ff8f4b4e94f723(#"hash_2d6d28e2d2af4ddc", #"recommended_season_1"));
          }

          if(var_2420b2d3569c0c6[2]) {
            var_158bd631747ae80 = function_6d40f12a09494350(var_158bd631747ae80, ae_utility::function_e2ff8f4b4e94f723(#"hash_2d6d28e2d2af4ddc", #"recommended_season_2"));
          }

          if(var_2420b2d3569c0c6[3]) {
            var_158bd631747ae80 = function_6d40f12a09494350(var_158bd631747ae80, ae_utility::function_e2ff8f4b4e94f723(#"hash_2d6d28e2d2af4ddc", #"recommended_season_3"));
          }

          if(var_2420b2d3569c0c6[4]) {
            var_158bd631747ae80 = function_6d40f12a09494350(var_158bd631747ae80, ae_utility::function_e2ff8f4b4e94f723(#"hash_2d6d28e2d2af4ddc", #"recommended_season_4"));
          }

          if(var_2420b2d3569c0c6[5]) {
            var_158bd631747ae80 = function_6d40f12a09494350(var_158bd631747ae80, ae_utility::function_e2ff8f4b4e94f723(#"hash_2d6d28e2d2af4ddc", #"recommended_season_5"));
          }

          if(var_2420b2d3569c0c6[6]) {
            var_158bd631747ae80 = function_6d40f12a09494350(var_158bd631747ae80, ae_utility::function_e2ff8f4b4e94f723(#"hash_2d6d28e2d2af4ddc", #"recommended_season_6"));
          }
        }
      }

      weaponclassarray = getweaponclassarray();
      var_b28608820870666 = 0;
      var_b28608820870666 = function_ce112254f7cba89e(attacker.primaryweaponobj);
      in_prematch = istrue(level.inprematch);
      aeeventname = #"assist";
      aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
      params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_a0dd9c7405f2d85e"), var_b28608820870666, ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), weaponlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_ab2e7c9b727a3d6c"), var_3fff36caeace1b84, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_2d6d28e2d2af4ddc"), var_158bd631747ae80, ae_utility::function_d6f771aedba70ce7(aeeventname, #"in_prematch"), in_prematch];

      if(!getdvarint(@ "hash_dda9d67c21b0f4b4", 0)) {
        params[params.size] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_359929d5b509d3a");
        params[params.size] = var_2c151652ca2c1756;
      }

      function_7d97a2a745e514c4(aeeventid, params);

      attacker reportchallengeuserserializedeventwrapper(aeeventid, params);
    }
  }
}

function function_817629c461ea3540(victim, var_815f9c7c319d9eac, attacker) {
  if(!var_815f9c7c319d9eac challengesenabledforplayer()) {
    return;
  }

  if(utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[utility::getsharedfunc("player", "isFriendly")]](attacker.team, victim) && [[utility::getsharedfunc("player", "isFriendly")]](var_815f9c7c319d9eac.team, attacker)) {
      gamemode = getchallengegamemode(var_815f9c7c319d9eac);
      gametype = function_17c5d7feb226e256();
      var_3fff36caeace1b84 = function_5d99311b5a7dffda();

      if(isDefined(level.var_c596a10a13c5cd7c)) {
        var_3fff36caeace1b84 = [[level.var_c596a10a13c5cd7c]](var_3fff36caeace1b84, victim);
      }

      in_prematch = istrue(level.inprematch);
      aeeventname = #"unassisted_kill";
      aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
      params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_ab2e7c9b727a3d6c"), var_3fff36caeace1b84, ae_utility::function_d6f771aedba70ce7(aeeventname, #"in_prematch"), in_prematch];

      function_7d97a2a745e514c4(aeeventid, params);

      var_815f9c7c319d9eac reportchallengeuserserializedeventwrapper(aeeventid, params);
    }
  }
}

function function_d8f43796d36ed5bf(ref, source) {
  if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"killstreak_available";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_597bc208d923a465(ref, totalkills) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(ref) || !isDefined(totalkills)) {
    return;
  }

  gametype = function_17c5d7feb226e256();
  gamemode = getchallengegamemode(self);
  bitfield = 0;
  total_kills = totalkills;
  operatorlootid = function_aff35122a61a900b(self.team);

  if(!isDefined(operatorlootid)) {
    operatorlootid = 0;
  }

  killstreak_lootid = loot::getlootidfromref(ref);
  var_5c27042ad7a17e62 = function_3ea2b9fa713d6ed3(self);
  var_5c27032ad7a17c2f = function_3ea2b9fa713d6ed3(self, 2);
  aeeventname = #"killstreak_end";
  gametype = function_68ffb11dc4c6b979(gametype, aeeventname);
  gamemode = function_68ffb11dc4c6b979(gamemode, aeeventname);
  total_kills = function_68ffb11dc4c6b979(total_kills, aeeventname);
  operatorlootid = function_68ffb11dc4c6b979(operatorlootid, aeeventname);
  killstreak_lootid = function_68ffb11dc4c6b979(killstreak_lootid, aeeventname);
  var_5c27042ad7a17e62 = function_68ffb11dc4c6b979(var_5c27042ad7a17e62, aeeventname);
  var_5c27032ad7a17c2f = function_68ffb11dc4c6b979(var_5c27032ad7a17c2f, aeeventname);
  bitfield = function_68ffb11dc4c6b979(bitfield, aeeventname);
  function_8e81148472fb520a(self, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"kill_amount"), total_kills, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_834ae5ef756e04aa"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_797a1495585997f4"), bitfield, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), killstreak_lootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bd518e95df4103fe"), var_5c27042ad7a17e62, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bd518d95df41024b"), var_5c27032ad7a17c2f]);
}

function function_68ffb11dc4c6b979(value, aeeventname) {
  if(isDefined(value) && !isint(value) && !isstring(value)) {
    println("<dev string:x520>" + value + "<dev string:x536>" + function_3c8848a3a11b2553(aeeventname));
    return int(0);
  }

  if(!isDefined(value)) {
    println("<dev string:x573>" + function_3c8848a3a11b2553(aeeventname));
    return int(0);
  }

  return value;
}

function function_d997435895422ecc(ref, eventtypebit, value) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_335ba1ebe269094 = 0;
  gametype = function_17c5d7feb226e256();
  gamemode = getchallengegamemode(self);

  if(isDefined(value) && value < 0) {
    value = 1;
  }

  var_335ba1ebe269094 = loot::getlootidfromref(ref);

  if(!isDefined(var_335ba1ebe269094) || var_335ba1ebe269094 == 0) {
    println("<dev string:x5cb>" + ref + "<dev string:x5e4>");
  }

  location = 0;
  location2 = 0;

  if(isDefined(self.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(self.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(self.closestpoi));
  }

  var_4adb82c833e8d5ab = function_3ea2b9fa713d6ed3(self);
  var_4adb83c833e8d7de = function_3ea2b9fa713d6ed3(self, 2);
  bitfield = 0;
  bitfield = function_6d40f12a09494350(bitfield, eventtypebit);
  aeeventname = #"field_upgrade";
  function_8e81148472fb520a(self, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), value, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), var_335ba1ebe269094, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_83a2d67994d7e295"), bitfield, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bd518e95df4103fe"), var_4adb82c833e8d5ab, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bd518d95df41024b"), var_4adb83c833e8d7de]);
}

function function_bd59aa7e8cece1ab(ref, value) {
  if(!challengesenabledforplayer()) {
    return;
  }

  field_upgrade = ref;
  amount = value;
  aeeventname = #"field_end";
  function_8e81148472fb520a(self, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"string_ref"), field_upgrade, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), amount]);
}

function oncapture(modifiers) {
  if(!isPlayer(self)) {
    if(istrue(level.var_c48ab672d4fb36a) && isDefined(self.subclass) && self.subclass == "capture_bot" || !istrue(level.var_c48ab672d4fb36a) && issharedfuncdefined("super_capture_bot", "captureBot_isGrenadeEntity") && function_f3bb4f4911a1beb2("super_capture_bot", "captureBot_isGrenadeEntity")) {
      owner = self.owner;

      if(utility::issharedfuncdefined("player", "getCurrentSuperRef")) {
        superref = owner[[utility::getsharedfunc("player", "getCurrentSuperRef")]]();
        lootid = loot::getlootidfromref(superref);
      }
    } else {
      return;
    }
  } else {
    owner = self;
    lootid = 0;
  }

  if(!owner challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"capture";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), lootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), getchallengegamemode(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), function_17c5d7feb226e256()];
  owner reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_c51330573171a1be(player) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  aeeventname = #"defuse";
  function_8e81148472fb520a(player, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype]);
}

function onplant() {
  function_4fb61d33f02e8203(self, 1);
}

function function_f05d761dc1bfa1b5() {
  if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"hash_372efa96b8695b65";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  weaponlootid = undefined;

  if(isDefined(self.currentprimaryweapon)) {
    weaponlootid = weapon::getweaponlootid(self.currentprimaryweapon);
  }

  if(!isDefined(weaponlootid)) {
    weaponlootid = 0;
  }

  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), getchallengegamemode(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), function_17c5d7feb226e256(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), weaponlootid];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_79abd07d1b2903d7(challengetype, runtime) {
  if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"hash_8bdd6b126d7ad7c0";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  var_86b2badc4337eea6 = 0;
  var_947b262137165984 = 0;

  if(isDefined(runtime)) {
    var_86b2badc4337eea6 = runtime;
  }

  if(isDefined(challengetype)) {
    var_947b262137165984 = ae_utility::function_7042dad035dc176c(challengetype);
  }

  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), getchallengegamemode(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), function_17c5d7feb226e256(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"objective_time"), var_86b2badc4337eea6, ae_utility::function_d6f771aedba70ce7(aeeventname, #"string_ref"), var_947b262137165984];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_9dd45fb7c1b7de56(challengetype, var_2b5b01555f2ce481) {
  if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"hash_7cc30c44053e7cab";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  var_947b262137165984 = 0;
  value = 0;

  if(isDefined(challengetype)) {
    var_947b262137165984 = ae_utility::function_7042dad035dc176c(challengetype);
  }

  if(isDefined(var_2b5b01555f2ce481)) {
    value = var_2b5b01555f2ce481;
  }

  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), getchallengegamemode(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), function_17c5d7feb226e256(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"string_ref"), var_947b262137165984, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), value];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function onstun(equipment) {
  if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"stun";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e2a522a357642b64"), equipment, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function onstim(health_recovered) {
  if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"stim";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), health_recovered, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function onhack(equipment) {
  if(isDefined(self.equipmentref) && self.equipmentref == "equip_capture_bot") {
    if(!self.owner challengesenabledforplayer()) {
      return;
    }
  } else if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"hack";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  owner = self;
  var_6172623b415f2e5e = 0;
  var_5ea1e2f4234ceef0 = 0;

  if(isDefined(self.equipmentref) && self.equipmentref == "equip_capture_bot") {
    owner = self.owner;

    if(utility::issharedfuncdefined("player", "getCurrentSuperRef")) {
      superref = owner[[utility::getsharedfunc("player", "getCurrentSuperRef")]]();
      var_6172623b415f2e5e = loot::getlootidfromref(superref);
    }
  }

  if(isDefined(getlootidfromref(equipment))) {
    var_5ea1e2f4234ceef0 = getlootidfromref(equipment);
  }

  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_1e968d7574076fcd"), var_5ea1e2f4234ceef0, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), var_6172623b415f2e5e, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), getchallengegamemode(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), function_17c5d7feb226e256()];
  owner reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function gettouchinglocaletriggers(attacker, victim) {
  buffer = "";

  if(!isDefined(level.localetriggers)) {
    return buffer;
  }

  found = 0;

  foreach(trigger in level.localetriggers) {
    if(attacker istouching(trigger) || isDefined(victim) && victim istouching(trigger)) {
      if(isDefined(trigger.localeid)) {
        if(found) {
          buffer += "|";
        }

        buffer += trigger.localeid;
        found = 1;
      }
    }
  }

  return buffer;
}

function gettouchingspraylocaletriggers(player) {
  if(!isDefined(level.localetriggers)) {
    return -1;
  }

  foreach(trigger in level.localetriggers) {
    if(player istouching(trigger)) {
      valid_spray = isDefined(trigger.sprayid) && trigger.sprayid > -1;
      var_50ba7204daa28034 = isDefined(player.sprayed) && player.sprayed & 1 << trigger.sprayid;

      if(valid_spray && !var_50ba7204daa28034) {
        if(!isDefined(player.sprayed)) {
          player.sprayed = 0;
        }

        player.sprayed |= 1 << trigger.sprayid;
        return trigger.sprayid;
      }
    }
  }

  return -1;
}

function oncontractstart(contractid, var_a705a5a5884ebf9c) {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  operatorlootid = function_aff35122a61a900b(self.team);
  location = 0;
  location2 = 0;

  if(isDefined(var_a705a5a5884ebf9c) && isDefined(var_a705a5a5884ebf9c.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(var_a705a5a5884ebf9c.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(var_a705a5a5884ebf9c.closestpoi));
  }

  aeeventname = #"contract_start";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), contractid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function oncontractend(contractid, completed, var_1229758a8a60ba86, startingpoi, contractname, var_caac1a3de59f50c0, islegendarycontract) {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  operatorlootid = function_aff35122a61a900b(self.team);
  location = 0;
  location2 = 0;

  if(isDefined(startingpoi)) {
    location = getlocation(startingpoi);
    location2 = function_55be16fb0f5f4a19(startingpoi);
  }

  circleindex = 0;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    circleindex = level.br_circle.circleindex;
  }

  var_98ffdd148b962576 = 0;

  if(isalive(self)) {
    var_98ffdd148b962576 = function_6d40f12a09494350(var_98ffdd148b962576, ae_utility::function_e2ff8f4b4e94f723(#"hash_bf1744b6c07743aa", #"alive"));
  }

  if(istrue(var_caac1a3de59f50c0)) {
    var_98ffdd148b962576 = function_6d40f12a09494350(var_98ffdd148b962576, ae_utility::function_e2ff8f4b4e94f723(#"hash_bf1744b6c07743aa", #"hash_1ad08b7d5759dd9a"));
  }

  if(completed) {
    var_98ffdd148b962576 = function_6d40f12a09494350(var_98ffdd148b962576, ae_utility::function_e2ff8f4b4e94f723(#"hash_bf1744b6c07743aa", #"completed"));
  } else {
    var_98ffdd148b962576 = function_6d40f12a09494350(var_98ffdd148b962576, ae_utility::function_e2ff8f4b4e94f723(#"hash_bf1744b6c07743aa", #"failed"));
  }

  if(var_1229758a8a60ba86 == 1) {
    var_98ffdd148b962576 = function_6d40f12a09494350(var_98ffdd148b962576, ae_utility::function_e2ff8f4b4e94f723(#"hash_bf1744b6c07743aa", #"team1"));
  } else if(var_1229758a8a60ba86 == 2) {
    var_98ffdd148b962576 = function_6d40f12a09494350(var_98ffdd148b962576, ae_utility::function_e2ff8f4b4e94f723(#"hash_bf1744b6c07743aa", #"team2"));
  }

  if(isDefined(contractname)) {
    typeid = ae_utility::function_7042dad035dc176c(contractname);
  }

  if(istrue(islegendarycontract)) {
    var_98ffdd148b962576 = function_6d40f12a09494350(var_98ffdd148b962576, ae_utility::function_e2ff8f4b4e94f723(#"hash_bf1744b6c07743aa", #"hash_c3ad90409cf171ce"));
  }

  var_bb38571cca0414f = function_c1945f26d99b0ed9(self);
  aeeventname = #"contract_end";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), contractid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bf1744b6c07743aa"), var_98ffdd148b962576, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287b83e723dcd4"), var_bb38571cca0414f[0], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287c83e723de87"), var_bb38571cca0414f[1], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287d83e723e03a"), var_bb38571cca0414f[2], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287e83e723e1ed"), var_bb38571cca0414f[3], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f3287783e723d608"), var_bb38571cca0414f[4], ae_utility::function_d6f771aedba70ce7(aeeventname, #"circle_index"), circleindex];

  if(isDefined(typeid)) {
    params[params.size] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"contract_type");
    params[params.size] = typeid;
  }

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function private function_417907aeeb08baac(instancetype) {
  switch (instancetype) {
    case #"hash_6d3a7f28d4e30af0":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"bar_cabinet"));
    case #"hash_2808ce3c4558142d":
    case #"hash_93553b29704c0d3":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"cash_register"));
    case #"hash_2cbf29aaf45c022d":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"clothes"));
    case #"hash_44904bb5898785d9":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"computer"));
    case #"hash_8387e0bfe22abc5d":
    case #"hash_f1db14019ca6a516":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"dmz_dead_drop"));
    case #"hash_3b6111354af78459":
    case #"hash_8193a20e7851382b":
    case #"hash_a7972bf23ae4418b":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"hash_b7a47ac5e86a7c8"));
    case #"hash_be635d272d652f68":
    case #"hash_42af86e7be283722":
    case #"hash_8756bee9b861200":
    case #"hash_1c5319d275640df":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"dmz_safe"));
    case #"hash_5fb47d4344357148":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"hash_4b14731043e2457a"));
    case #"hash_993262832973e0d":
    case #"hash_61f36140da68c992":
    case #"hash_5fe210289499bd6e":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"dmz_supply_drop"));
    case #"hash_15ffdff5c5e4cca2":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"dresser"));
    case #"hash_7635d9926e3b434":
    case #"hash_763609926e3b8ed":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"duffel_bag"));
    case #"hash_50e52e4dc37fb7a8":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"hash_40ad471432d12503"));
    case #"hash_a6fd900b15b2be21":
    case #"hash_acc339f27e6535d8":
    case #"hash_acc33cf27e653a91":
    case #"hash_bd0a50437d51e6e7":
    case #"hash_bd0a51437d51e87a":
    case #"hash_8a31c0680349ff7b":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"fridge"));
    case #"hash_f5264031983561d3":
    case #"hash_f526413198356366":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"locker"));
    case #"hash_9c4e1145f143be53":
    case #"hash_ac6eb824cf784951":
    case #"hash_ac6eb924cf784ae4":
    case #"hash_fd428ac2a2886e03":
    case #"hash_fd428fc2a28875e2":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"loot_backpack"));
    case #"hash_f086d807b107cbfd":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"mail_kiosk"));
    case #"hash_469a90a45e97eda9":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"medicine_cabinet"));
    case #"hash_c82c626607f41c61":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"office_cabinet"));
    case #"hash_183cb58bad34bd86":
    case #"hash_b1814c3921b5bcf2":
    case #"hash_33a1ab3969e0b64e":
    case #"hash_b5b4216883bf84b8":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"pack"));
    case #"hash_8944097b14faec32":
    case #"hash_4ca1dc2e1b0de0d3":
    case #"hash_4654cfd269b6fc02":
    case #"hash_417c605750c7baa5":
    case #"hash_9c5f01407ae504fc":
    case #"hash_a10a247457819cda":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"supply_box"));
    case #"hash_19ba8d41970911ad":
    case #"hash_d1616a5975b7a941":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"hash_10bcbd45df39494e"));
    case #"hash_4c9cda73b7cb8b41":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"tool_box"));
    case #"hash_1a50c41f80fb532b":
      return function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_1e306cba757eda6f", #"weapon_locker"));
    default:
      return 0;
  }
}

function function_da9003df08944b01(instance) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(instance) && !isDefined(instance.type)) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  operatorlootid = function_aff35122a61a900b(self.team);
  location = 0;
  location2 = 0;

  if(isDefined(self.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(self.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(self.closestpoi));
  }

  var_8f3a85e26344fedf = function_417907aeeb08baac(instance.type);
  var_b17708bcdca61ba6 = 0;
  var_b17708bcdca61ba6 = function_6d40f12a09494350(var_b17708bcdca61ba6, ae_utility::function_e2ff8f4b4e94f723(#"hash_f42835693a3d7da5", #"hash_d77de70746f0150e"));
  aeeventname = #"loot_cache";
  function_8e81148472fb520a(self, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_1e306cba757eda6f"), var_8f3a85e26344fedf, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f42835693a3d7da5"), var_b17708bcdca61ba6]);
}

function onkioskpurchaseitem(itemtyperef, itemref, lootid, quantity, cashvalue, var_827283fbf3803e56) {
  buy_action = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"buy_action", #"buy"));
  function_1ba256da09a9878a(self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action, undefined, var_827283fbf3803e56);
}

function function_ea50038423fc4cfc(itemtyperef, itemref, lootid, quantity, cashvalue, var_f237807396377232) {
  buy_action = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"buy_action", #"sell"));
  function_1ba256da09a9878a(self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action, var_f237807396377232);
}

function function_7ba17fb69c312e2c(itemtyperef, itemref, lootid, quantity, cashvalue) {
  buy_action = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"buy_action", #"trade"));
  function_1ba256da09a9878a(self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action);
  loot_method = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_2af1f13aa6ae3b5f", #"loot"));
  function_d24138b32084fc3e(self, lootid, itemtyperef, loot_method, quantity);
}

function function_c2c80007aff49924(itemtyperef, itemref, lootid, quantity, cashvalue) {
  buy_action = scripts\cp_mp\challenges::function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"buy_action", #"hash_8007c41db906acd9"));
  function_1ba256da09a9878a(self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action);
}

function function_3d8a8b0878f9f129(itemtyperef, itemref, lootid, quantity, cashvalue) {
  buy_action = scripts\cp_mp\challenges::function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"buy_action", #"hash_23f44b864cfb53cd"));
  function_1ba256da09a9878a(self, lootid, itemref, itemtyperef, quantity, cashvalue, buy_action);
}

function onpickupitem(itemtyperef) {
  if(!challengesenabledforplayer()) {
    return;
  }

  pickupweapon = 0;
  pickupplunder = 0;

  if(itemtyperef == "weapon") {
    pickupweapon = 1;
    return;
  }

  if(itemtyperef == "plunder") {
    pickupplunder = 1;
  }
}

function onpickupweapon(objweapon) {
  if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"pickup_weapon";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  var_349e390338192305 = findgunsmithattachments(objweapon);
  weaponlootid = weapon::function_89a83ae9a4c4142a(objweapon);
  isloadoutweapon = utility::function_f3bb4f4911a1beb2("weapons", "isLoadoutWeapon", objweapon);

  if(!isDefined(weaponlootid)) {
    weaponlootid = 0;
  }

  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), weaponlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment1"), var_349e390338192305[0], ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment2"), var_349e390338192305[1], ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment3"), var_349e390338192305[2], ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment4"), var_349e390338192305[3], ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment5"), var_349e390338192305[4], ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment6"), var_349e390338192305[5], ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment7"), var_349e390338192305[6], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_af7ce1c514ea64cd"), var_349e390338192305[7], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_af7ce0c514ea631a"), var_349e390338192305[8], ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_1b7a08e28a2f9d76"), var_349e390338192305[9], ae_utility::function_d6f771aedba70ce7(aeeventname, #"loadout_weapon"), isloadoutweapon];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function oncollectitem(itemtyperef) {
  if(!challengesenabledforplayer()) {
    return;
  }

  self reportchallengeuserevent("collect_item", itemtyperef, getoperators());
}

function onuseitem(type) {
  if(!challengesenabledforplayer()) {
    return;
  }

  function_cfeb523fd3aa9ecf(self, undefined, type);
}

function onunlockitem(itemunlockref) {
  if(!challengesenabledforplayer()) {
    return;
  }

  self reportchallengeuserevent("collect_item", itemunlockref);
}

function onloadout(loadouttype) {
  if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"loadout";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), loadouttype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function onping(pingtype) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(pingtype != "enemy") {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  var_85003fd01430b0c6 = 0;

  if(pingtype == "enemy") {
    var_85003fd01430b0c6 = function_6d40f12a09494350(var_85003fd01430b0c6, ae_utility::function_e2ff8f4b4e94f723(#"hash_fc7c59e1de2e79aa", #"hash_cf5caa96f917f27d"));
  }

  aeeventname = #"ping";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_fc7c59e1de2e79aa"), var_85003fd01430b0c6];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_fb73a02201f647ba(amount) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(amount <= 0) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  var_1860d02fbe1e944d = amount;
  aeeventname = #"hash_a5a0373bb326846a";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), var_1860d02fbe1e944d];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_9d15fd5e1f063810(amount) {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  var_51ad66e2c88d974e = amount;
  var_a28fbb80211e2892 = 0;

  if(isDefined(self.plunderbanked)) {
    var_a28fbb80211e2892 = self.plunderbanked;
  }

  aeeventname = #"hash_d58b81f7202281bc";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_13551ba8b18421d"), amount, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5ecdbc36385e80e8"), var_a28fbb80211e2892];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_8c51020c52153152() {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  aeeventname = #"interrogate";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function onlaststandrevive(reviver, revivee) {
  gamemode = getchallengegamemode(reviver);
  gametype = function_17c5d7feb226e256();

  if(reviver challengesenabledforplayer()) {
    aeeventname = #"revive";
    var_160460001cc37359 = 0;
    var_160460001cc37359 = function_6d40f12a09494350(var_160460001cc37359, ae_utility::function_e2ff8f4b4e94f723(#"hash_c6554ef3de205884", #"reviver"));
    operatorlootid = reviver function_aff35122a61a900b(reviver.team);

    if(reviver == revivee) {
      var_160460001cc37359 = function_6d40f12a09494350(var_160460001cc37359, ae_utility::function_e2ff8f4b4e94f723(#"hash_c6554ef3de205884", #"revivee"));
    }

    function_8e81148472fb520a(reviver, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c6554ef3de205884"), var_160460001cc37359]);
  }

  if(reviver != revivee && revivee challengesenabledforplayer()) {
    aeeventname = #"revive";
    var_160460001cc37359 = 0;
    var_160460001cc37359 = function_6d40f12a09494350(var_160460001cc37359, ae_utility::function_e2ff8f4b4e94f723(#"hash_c6554ef3de205884", #"revivee"));
    operatorlootid = revivee function_aff35122a61a900b(revivee.team);
    function_8e81148472fb520a(revivee, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c6554ef3de205884"), var_160460001cc37359]);
  }
}

function function_b2306d0693ba65c1(iswinner) {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  operatorlootid = function_aff35122a61a900b(self.team);
  bitfield1 = 0;

  if(iswinner) {
    bitfield1 = function_6d40f12a09494350(bitfield1, ae_utility::function_e2ff8f4b4e94f723(#"hash_2614881933cc996e", #"win"));
  } else {
    bitfield1 = function_6d40f12a09494350(bitfield1, ae_utility::function_e2ff8f4b4e94f723(#"hash_2614881933cc996e", #"loss"));
  }

  teamsize = 0;

  if(gamemode & 8) {
    teamsize = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();
  }

  aeeventname = #"gulag_end";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_2614881933cc996e"), bitfield1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"team_size"), teamsize];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function onspray() {
  if(!challengesenabledforplayer()) {
    return;
  }

  locale = gettouchingspraylocaletriggers(self);

  if(locale != -1) {
    aeeventname = #"spray";
    aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
    params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), locale, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1];
    reportchallengeuserserializedeventwrapper(aeeventid, params);
  }
}

function function_f09e914e200d1a42(objweapon) {
  weaponname = undefined;

  if(!isDefined(objweapon) || !isDefined(objweapon.basename)) {
    weaponname = "";
  }

  if(!isDefined(weaponname)) {
    weaponname = "";

    if(utility::issharedfuncdefined("equipment", "getEquipmentRefFromWeapon")) {
      weaponname = [[utility::getsharedfunc("equipment", "getEquipmentRefFromWeapon")]](objweapon);
    }

    if(!isDefined(weaponname)) {
      if(utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
        weaponname = [[utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](objweapon.basename);
      }
    }

    if(weaponname == "equip_throwing_knife_fire" || weaponname == "equip_throwing_knife_electric" || weaponname == "equip_shuriken") {
      weaponname = "equip_throwing_knife";
    }
  }

  return weaponname;
}

function function_ce112254f7cba89e(objweapon) {
  weaponclassarray = getweaponclassarray();

  if(!isDefined(objweapon)) {
    return 0;
  }

  weaponname = undefined;

  if(isweapon(objweapon)) {
    weaponname = objweapon.basename;
  } else {
    assert(isstring(objweapon));
    weaponname = objweapon;
  }

  if(!isDefined(weaponname)) {
    return 0;
  }

  weaponroot = weapon::getweaponrootname(objweapon);

  if(isDefined(level.weaponmapdata[weaponroot]) && isDefined(level.weaponmapdata[weaponroot].group)) {
    weapongroup = level.weaponmapdata[weaponroot].group;
  } else {
    return 0;
  }

  var_b28608820870666 = 0;

  if(weaponroot == "iw9_ar_golf3" || weaponname == "iw9_ar_schotel" || weaponname == "iw9_br_msecho" || weaponname == "iw9_br_soscar14") {
    var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["battle"]);
    return var_b28608820870666;
  }

  switch (weapongroup) {
    case #"hash_8af0086b038622b5":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["rifle"]);
      break;
    case #"hash_47368bc0d2ef1565":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["marksman"]);
      break;
    case #"hash_c095d67337b1f5a1":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["sniper"]);
      break;
    case #"hash_9d18adab1b65a661":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["rocketlauncher"]);
      break;
    case #"hash_bef5ec0b3e197ae":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["mg"]);
      break;
    case #"hash_34340d457a63e7f1":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["pistol"]);
      break;
    case #"hash_16cf6289ab06bd30":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["spread"]);
      break;
    case #"hash_ab10f9c080fe4faf":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["smg"]);
      break;
    case #"hash_dd616da0b395a0b0":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["battle"]);
      break;
    case #"hash_86b11ac21f992552":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["melee_primary"]);
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["melee"]);
      break;
    case #"hash_a1f27f97be15d620":
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["melee_secondary"]);
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["melee"]);
      break;
    default:
      return 0;
  }

  return var_b28608820870666;
}

function function_6d40f12a09494350(bitfield, bit) {
  if(!isDefined(level.aedisabled)) {
    level.aedisabled = getdvarint(@ "hash_f0c3671383d467f8", 0) > 0;
  }

  if(level.aedisabled) {
    return 0;
  }

  if(!isDefined(bit)) {
    return bitfield;
  }

  if(bit > 31 || isstring(bitfield)) {
    return function_1db72f37b2e59440(bitfield + "", bit);
  }

  return bitfield | 1 << bit;
}

function function_b2e5ca0ecf2215ab(bitfield, bit) {
  if(!isDefined(level.aedisabled)) {
    level.aedisabled = getdvarint(@ "hash_f0c3671383d467f8", 0) > 0;
  }

  if(level.aedisabled) {
    return 0;
  }

  if(!isDefined(bit)) {
    return bitfield;
  }

  if(bit > 31 || isstring(bitfield)) {
    return function_66164156979f643b(bitfield + "", bit);
  }

  return bitfield &~(1 << bit);
}

function function_3005ef56488df9be(bitfield) {
  var_cc819de748cb6689 = bitfield + "";
  stringlength = var_cc819de748cb6689.size;
  characters = [];

  for(k = 0; k < stringlength; k++) {
    characters[stringlength - k - 1] = int(var_cc819de748cb6689[stringlength - k - 1]);
  }

  lastcharacter = stringlength - 1;
  result = [];
  nextresult = 0;

  while(true) {
    mod2 = characters[lastcharacter] % 2;
    result[nextresult] = mod2 == 1;
    nextresult += 1;

    if(mod2 == 1) {
      characters[lastcharacter] -= 1;
    }

    allzero = 1;

    for(k = 0; k < stringlength; k++) {
      character = characters[stringlength - k - 1];

      if(character != 0) {
        allzero = 0;
      }

      if(character % 2 == 1) {
        characters[stringlength - k] += 5;
      }

      characters[stringlength - k - 1] = int(character / 2);
    }

    if(allzero) {
      return result;
    }
  }
}

function getchallengegamemode(player) {
  gamemode = 0;

  if(game_utility::function_21322da268e71c19()) {
    gamemode = function_6d40f12a09494350(gamemode, 5);
  }

  if(istrue(level.var_ec2fb549b15ad827)) {
    gamemode = function_6d40f12a09494350(gamemode, 6);
    return gamemode;
  }

  if(istrue(level.var_5ac73e9eb9eea898)) {
    gamemode = function_6d40f12a09494350(gamemode, 10);
    return gamemode;
  }

  if(istrue(level.var_77907d733abe8b63)) {
    gamemode = function_6d40f12a09494350(gamemode, 7);
    return gamemode;
  }

  if(utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
      gamemode = function_6d40f12a09494350(gamemode, 3);
      return gamemode;
    }
  }

  if(utility::issharedfuncdefined("game", "getGameType")) {
    gametype = [[utility::getsharedfunc("game", "getGameType")]]();

    if(isDefined(gametype)) {
      if(gametype == "brtdm" || gametype == "brtdm_mgl") {
        gamemode = function_6d40f12a09494350(gamemode, 3);
        return gamemode;
      } else if(utility::iscp()) {
        gamemode = function_6d40f12a09494350(gamemode, 2);
        return gamemode;
      } else if(utility::issp()) {
        gamemode = function_6d40f12a09494350(gamemode, 0);
        return gamemode;
      } else if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.aegamemode) && level.gamemodebundle.aegamemode == "OB") {
        gamemode = function_6d40f12a09494350(gamemode, 9);
        return gamemode;
      } else {
        gamemode = function_6d40f12a09494350(gamemode, 1);
        return gamemode;
      }
    }
  }

  return 0;
}

function function_aff35122a61a900b(team) {
  if(isDefined(team) && utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
    operatorref = self[[utility::getsharedfunc("player", "lookupCurrentOperator")]](team);
    lootid = loot::getlootidfromref(operatorref);

    if(!isDefined(lootid) || lootid < 0) {
      return 0;
    }

    return lootid;
  }

  return 0;
}

function private function_261cfb5c8119ea2b(gametypekey) {
  if(!isDefined(gametypekey)) {
    return 0;
  }

  if(!isDefined(level.challengeandeventglobals.game_type_col) || !isDefined(level.challengeandeventglobals.game_type_col[gametypekey])) {
    return 0;
  }

  if(getdvarint(@ "hash_2be93dd484220a45", 0) == 1) {
    return ae_utility::function_b40278e5e468c6c1(#"gametype", #"hash_ddfda95920353859");
  }

  return level.challengeandeventglobals.game_type_col[gametypekey];
}

function function_17c5d7feb226e256() {
  if(!getdvarint(@ "hash_78653010d584aa6e")) {
    gametype = undefined;

    if(utility::issharedfuncdefined("game", "getGameType")) {
      gametype = [[utility::getsharedfunc("game", "getGameType")]]();
    }

    if(!isDefined(gametype)) {
      gametype = scripts\cp_mp\utility\game_utility::getgametype();
    }

    gametypecol = function_261cfb5c8119ea2b(gametype);
    return gametypecol;
  }

  return function_261cfb5c8119ea2b(level.gametypebundle.var_d20acad05758f0d8);
}

function getweaponclassarray() {
  if(!isDefined(level.weaponclassarray)) {
    level.weaponclassarray = spawnStruct();
    level.weaponclassarray.classes = [];
    level.weaponclassarray.classes["none"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"none");
    level.weaponclassarray.classes["sniper"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"sniper");
    level.weaponclassarray.classes["mg"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"lmg");
    level.weaponclassarray.classes["smg"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"smg");
    level.weaponclassarray.classes["spread"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"shotgun");
    level.weaponclassarray.classes["pistol"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"pistol");
    level.weaponclassarray.classes["grenade"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"grenade");
    level.weaponclassarray.classes["rocketlauncher"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"launcher");
    level.weaponclassarray.classes["turret"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"turret");
    level.weaponclassarray.classes["throwingknife"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"throwing_knife");
    level.weaponclassarray.classes["non-player"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"non_player");
    level.weaponclassarray.classes["item"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"item");
    level.weaponclassarray.classes["beam"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"beam");
    level.weaponclassarray.classes["ball"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"ball");
    level.weaponclassarray.classes["rifle"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"assault");
    level.weaponclassarray.classes["battle"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"battle");
    level.weaponclassarray.classes["marksman"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"marksman");
    level.weaponclassarray.classes["killstreak"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"killstreak");
    level.weaponclassarray.classes["melee_primary"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"melee_primary");
    level.weaponclassarray.classes["melee_secondary"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"melee_secondary");
    level.weaponclassarray.classes["melee"] = ae_utility::function_e2ff8f4b4e94f723(#"hash_a0dd9c7405f2d85e", #"melee");
  }

  return level.weaponclassarray.classes;
}

function function_d6973792fd45b035() {
  if(!isDefined(level.var_e4f4a057080c0ed5)) {
    level.var_e4f4a057080c0ed5 = [];
    level.var_e4f4a057080c0ed5["specialty_survivor"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_survivor");
    level.var_e4f4a057080c0ed5["specialty_extra_tactical"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_extra_tactical");
    level.var_e4f4a057080c0ed5["specialty_overwatch"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_overwatch");
    level.var_e4f4a057080c0ed5["specialty_grenade_expert"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_grenade_expert");
    level.var_e4f4a057080c0ed5["specialty_eod"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_eod");
    level.var_e4f4a057080c0ed5["specialty_focus"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_focus");
    level.var_e4f4a057080c0ed5["specialty_restock"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_restock");
    level.var_e4f4a057080c0ed5["specialty_overcharge_field_upgrade"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_overcharge_field_upgrade");
    level.var_e4f4a057080c0ed5["specialty_warhead"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_warhead");
    level.var_e4f4a057080c0ed5["specialty_munitions_2"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_munitions_2");
    level.var_e4f4a057080c0ed5["specialty_scavenger_plus"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_scavenger");
    level.var_e4f4a057080c0ed5["specialty_guerrilla"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_guerrilla");
    level.var_e4f4a057080c0ed5["specialty_hardline"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_hardline");
    level.var_e4f4a057080c0ed5["specialty_huntmaster"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_huntmaster");
    level.var_e4f4a057080c0ed5["specialty_tactical_recon"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_tactical_recon");
    level.var_e4f4a057080c0ed5["specialty_hustle"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_hustle");
    level.var_e4f4a057080c0ed5["specialty_covert_ops"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_covert_ops");
    level.var_e4f4a057080c0ed5["specialty_tac_resist"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"hash_228c132d78456c6");
    level.var_e4f4a057080c0ed5["specialty_surveillance"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"hash_b3aa7c0a8c7ed3ac");
    level.var_e4f4a057080c0ed5["specialty_quick_fix"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"hash_b7589c37d759ad90");
    level.var_e4f4a057080c0ed5["specialty_null"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"speciality_null");
    level.var_e4f4a057080c0ed5["specialty_tac_mask"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_tac_mask");
    level.var_e4f4a057080c0ed5["specialty_hijacked_iff_strobe"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_hijacked_iff_strobe");
    level.var_e4f4a057080c0ed5["specialty_high_gain_antenna"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_high_gain_antenna");
    level.var_e4f4a057080c0ed5["specialty_tac_gloves"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_tac_gloves");
    level.var_e4f4a057080c0ed5["specialty_acoustic_sensor"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_acoustic_sensor");
    level.var_e4f4a057080c0ed5["specialty_lr_detector"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_lr_detector");
    level.var_e4f4a057080c0ed5["specialty_signal_jammer"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_signal_jammer");
    level.var_e4f4a057080c0ed5["specialty_monomer_plate"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_monomer_plate");
    level.var_e4f4a057080c0ed5["specialty_thermal_camo"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_thermal_camo");
    level.var_e4f4a057080c0ed5["specialty_elasomer_pads"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_elasomer_pads");
    level.var_e4f4a057080c0ed5["specialty_dex_gloves"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_dex_gloves");
    level.var_e4f4a057080c0ed5["specialty_canvas_sneakers"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_canvas_sneakers");
    level.var_e4f4a057080c0ed5["specialty_maritime_boots"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_maritime_boots");
    level.var_e4f4a057080c0ed5["specialty_ultra_light_boots"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_ultra_light_boots");
    level.var_e4f4a057080c0ed5["specialty_extra_deadly"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_extra_deadly");
    level.var_e4f4a057080c0ed5["specialty_blacklight_flashlight"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_blacklight_flashlight");
    level.var_e4f4a057080c0ed5["specialty_taccom_system"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_taccom_system");
    level.var_e4f4a057080c0ed5["specialty_bone_conduction"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_bone_conduction");
    level.var_e4f4a057080c0ed5["specialty_nods"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_nods");
    level.var_e4f4a057080c0ed5["specialty_dauntless_boots"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_dauntless_boots");
    level.var_e4f4a057080c0ed5["specialty_intel_jacker"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_intel_jacker");
    level.var_e4f4a057080c0ed5["specialty_shielded_carrier"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_shielded_carrier");
    level.var_e4f4a057080c0ed5["specialty_suspension_pads"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_suspension_pads");
    level.var_e4f4a057080c0ed5["specialty_flame_res_insulation"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_flame_res_insulation");
    level.var_e4f4a057080c0ed5["specialty_cct_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_cct_vest");
    level.var_e4f4a057080c0ed5["specialty_assault_gloves"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_assault_gloves");
    level.var_e4f4a057080c0ed5["specialty_silicon_gloves"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_silicon_gloves");
    level.var_e4f4a057080c0ed5["specialty_impact_res_gloves"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_impact_res_gloves");
    level.var_e4f4a057080c0ed5["specialty_custom_gloves"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_custom_gloves");
    level.var_e4f4a057080c0ed5["specialty_tac_pads"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_tac_pads");
    level.var_e4f4a057080c0ed5["specialty_running_sneakers"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_running_sneakers");
    level.var_e4f4a057080c0ed5["specialty_treadless_boots"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_treadless_boots");
    level.var_e4f4a057080c0ed5["specialty_eod_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_eod_vest");
    level.var_e4f4a057080c0ed5["specialty_infantry_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_infantry_vest");
    level.var_e4f4a057080c0ed5["specialty_infantry_vest_ranked"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_infantry_vest");
    level.var_e4f4a057080c0ed5["specialty_ghost_camo"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_ghost_camo");
    level.var_e4f4a057080c0ed5["specialty_grenadier_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_grenadier_vest");
    level.var_e4f4a057080c0ed5["specialty_scout_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_scout_vest");
    level.var_e4f4a057080c0ed5["specialty_overkill_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_overkill_vest");
    level.var_e4f4a057080c0ed5["specialty_tac_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_tac_vest");
    level.var_e4f4a057080c0ed5["specialty_black_market_phone"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_black_market_phone");
    level.var_e4f4a057080c0ed5["specialty_stalker_boots"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_stalker_boots");
    level.var_e4f4a057080c0ed5["specialty_marksman_gloves"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_marksman_gloves");
    level.var_e4f4a057080c0ed5["specialty_gunner_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_gunner_vest");
    level.var_e4f4a057080c0ed5["specialty_fast_reload"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_fast_reload");
    level.var_e4f4a057080c0ed5["specialty_ninja_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_ninja_vest");
    level.var_e4f4a057080c0ed5["specialty_pistol_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_pistol_vest");
    level.var_e4f4a057080c0ed5["specialty_ninja_gloves"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_ninja_gloves");
    level.var_e4f4a057080c0ed5["specialty_compression_carrier_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_compression_carrier_vest");
    level.var_e4f4a057080c0ed5["specialty_compression_plate"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_compression_plate");
    level.var_e4f4a057080c0ed5["specialty_rhino_rig"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"specialty_rhino_rig");
    level.var_e4f4a057080c0ed5["none"] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"speciality_null");
    level.var_e4f4a057080c0ed5[""] = function_e2ff8f4b4e94f723(#"hash_bd518e95df4103fe", #"speciality_null");
  }

  return level.var_e4f4a057080c0ed5;
}

function function_343f3f4300421f65() {
  if(!isDefined(level.var_920b8666b284c605)) {
    level.var_920b8666b284c605 = [];
    level.var_e4f4a057080c0ed5["none"] = function_e2ff8f4b4e94f723(#"hash_bd518d95df41024b", #"speciality_null");
    level.var_e4f4a057080c0ed5[""] = function_e2ff8f4b4e94f723(#"hash_bd518d95df41024b", #"speciality_null");
    level.var_920b8666b284c605["specialty_combined_arms_vest"] = function_e2ff8f4b4e94f723(#"hash_bd518d95df41024b", #"specialty_combined_arms_vest");
  }

  return level.var_920b8666b284c605;
}

function getlocation(poi, sublocation) {
  location = 0;

  if(isDefined(level.mapname)) {
    switch (level.mapname) {
      case #"hash_57eba45b7ddbdcd6":
      case #"hash_63326ac3e12f8da0":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"mp_saba"));
        break;
      case #"hash_4617d802bdced46":
      case #"hash_a82a4d91a314a926":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"mp_sealion"));
        break;
      case #"hash_c0437228d481a553":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"mp_cruce"));
        break;
      case #"hash_721bd15904e6ff51":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"mp_bio_lab"));
        break;
      case #"hash_3eff14ec1d9395c1":
      case #"hash_636b409bbce21729":
      case #"hash_e817308cc606e9e1":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"mp_delta"));
        break;
      default:
        break;
    }
  }

  if(isDefined(poi)) {
    if(!isDefined(level.var_93d766d265995ec6)) {
      level.var_93d766d265995ec6 = [];
    }

    if(isDefined(level.var_93d766d265995ec6[poi])) {
      var_b8d53bb8326b1bbb = level.var_93d766d265995ec6[poi];
    } else {
      var_b8d53bb8326b1bbb = poi;
    }

    switch (var_b8d53bb8326b1bbb) {
      case #"hash_2fc7c295b037f8c8":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_airport"));
        break;
      case #"hash_323a903afe21c55":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_moderncity"));
        break;
      case #"hash_55998447da820c51":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_lone"));
        break;
      case #"hash_bf64f3350855cdc0":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_fishtwn"));
        break;
      case #"hash_8c3b9af8bb8c1820":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_sira"));
        break;
      case #"hash_bfacd3c12e3210d5":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_sunken"));
        break;
      case #"hash_7c61ad10d89b8ce6":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_oasis"));
        break;
      case #"hash_24913acf39b1b9d":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_oilfield"));
        break;
      case #"hash_e9beb39bd45dace9":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_caves"));
        break;
      case #"hash_37758f87479407e4":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_fort"));
        break;
      case #"hash_f18f60036d48d0f":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_observatory"));
        break;
      case #"hash_c95fc729a312805c":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_wartorn"));
        break;
      case #"hash_c8ec8fdd7804347d":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_marshland"));
        break;
      case #"hash_8d517c7cd4c59daf":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_oldtwn"));
        break;
      case #"hash_94cea40522328dd7":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_mtntwn"));
        break;
      case #"hash_3ca65c5d8ac073f1":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_exhume"));
        break;
      case #"hash_ceed33ec74498ad9":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_cemetery"));
        break;
      case #"hash_1488720cef98266d":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_hydro"));
        break;
      case #"hash_cf5e052f7a158621":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_01"));
        break;
      case #"hash_cf5e022f7a158168":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_02"));
        break;
      case #"hash_cf5e032f7a1582fb":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_03"));
        break;
      case #"hash_cf5e082f7a158ada":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_04"));
        break;
      case #"hash_cf5e092f7a158c6d":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_05"));
        break;
      case #"hash_cf5e062f7a1587b4":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_06"));
        break;
      case #"hash_cf5e072f7a158947":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_07"));
        break;
      case #"hash_cf5dfc2f7a1577f6":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_08"));
        break;
      case #"hash_cf5dfd2f7a157989":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_09"));
        break;
      case #"hash_cf610a2f7a17cc97":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_10"));
        break;
      case #"hash_cf61092f7a17cb04":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_11"));
        break;
      case #"hash_cf610c2f7a17cfbd":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_12"));
        break;
      case #"hash_cf610b2f7a17ce2a":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_13"));
        break;
      case #"hash_cf61062f7a17c64b":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_suburbs_14"));
        break;
      case #"hash_c45f27b96f2ad068":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"hash_8ff0c309b1a1908"));
        break;
      case #"hash_fea386fb2aa41ed6":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sealion_beachclub"));
        break;
      case #"hash_ee3a4e86c1774bb7":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sealion_castle"));
        break;
      case #"hash_b74d2013e0a73b91":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sealion_coastalruins"));
        break;
      case #"hash_42039e0dfa3b0be4":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"hash_5d07baf686ac81a4"));
        break;
      case #"hash_425ebb3f3dd8bf73":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sealion_culdesac"));
        break;
      case #"hash_c5c4b2288656dc11":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sealion_powerplant"));
        break;
      case #"hash_202632819760f0f3":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sealion_residential"));
        break;
      case #"hash_a15a99827cbcb8cd":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sealion_shipwreck"));
        break;
      case #"hash_45a8eb1e8a07af8a":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"hash_76b4cdd1fe62556a"));
        break;
      case #"hash_c3ce7ba6414ef022":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sealion_watertreatment"));
        break;
      case #"hash_f58c21f8c451efe6":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sealion_waterways"));
        break;
      case #"hash_5065eaea648578ee":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_castle"));
        break;
      case #"hash_b4fec2c123adbfd2":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_cemetary"));
        break;
      case #"hash_14bbe6b90c8369ca":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_cityhall"));
        break;
      case #"hash_4f1ad34662aa3a82":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_firestation"));
        break;
      case #"hash_53022f086491e02a":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_fleamarket"));
        break;
      case #"hash_5b71b0ea2ed56595":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"hash_97f878cab4a2b055"));
        break;
      case #"hash_239a49cd4504b4dd":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_library"));
        break;
      case #"hash_acf6b546ae4484dc":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"hash_e4b969708fad633c"));
        break;
      case #"hash_ee6fcf2d91c2b6ca":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_museum"));
        break;
      case #"hash_ae4c218f1f8dd217":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"hash_9938a76de295bb97"));
        break;
      case #"hash_2b66f465e931d3c4":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"hash_b49b4b47ef66b904"));
        break;
      case #"hash_b4fe333572abf8ec":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"hash_737542d6543379cc"));
        break;
      case #"hash_e26564d1e7044875":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_stadium"));
        break;
      case #"hash_b4aa823331182196":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_station"));
        break;
      case #"hash_c6f07a0b07c6b7b2":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"delta_terminal"));
        break;
      default:
        break;
    }
  }

  if(isDefined(sublocation)) {
    switch (sublocation) {
      case #"hash_95e472767d515c8b":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"sira_mall"));
        break;
      case #"hash_7c61ad10d89b8ce6":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_92939ab8dccb3d82", #"saba_oasis"));
        break;
    }
  }

  return location;
}

function function_55be16fb0f5f4a19(poi, sublocation) {
  location = 0;

  if(isDefined(level.mapname)) {
    switch (level.mapname) {
      case #"hash_5d52d1f62d321d14":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"mp_biobunker"));
        break;
      case #"hash_a3e3924c74796689":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"mp_jup_escape5"));
        break;
      case #"hash_da8f14763f037922":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"mp_jup_sm_island_2"));
        break;
      case #"hash_aeddd44c5b27b2d":
      case #"hash_73e90c896fdaebc3":
      case #"hash_9ae3f9a4f2372775":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"mp_jup_bigmap_wz2"));
        break;
      default:
        break;
    }
  }

  if(isDefined(poi)) {
    if(isDefined(level.var_93d766d265995ec6[poi])) {
      var_b8d53bb8326b1bbb = level.var_93d766d265995ec6[poi];
    } else {
      var_b8d53bb8326b1bbb = poi;
    }

    switch (var_b8d53bb8326b1bbb) {
      case #"hash_ba41f5c24ec17e19":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_49a924e7bcee6519"));
        break;
      case #"hash_ba41f2c24ec17960":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_49a921e7bcee6000"));
        break;
      case #"hash_ba41f3c24ec17af3":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_49a922e7bcee61b3"));
        break;
      case #"hash_ba41f8c24ec182d2":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_49a927e7bcee6a32"));
        break;
      case #"hash_ba41f9c24ec18465":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_49a928e7bcee6be5"));
        break;
      case #"hash_ba41f6c24ec17fac":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_49a925e7bcee66cc"));
        break;
      case #"hash_ba41f7c24ec1813f":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_49a926e7bcee687f"));
        break;
      case #"hash_15cac143ca27b652":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"delta_windmill"));
        break;
      case #"hash_bca86ea7c2b31316":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"delta_zoo"));
        break;
      case #"hash_e1decce80236cc9c":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"biobunker_radiation"));
        break;
      case #"hash_82f3ea371858dcb6":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"biobunker_flooded"));
        break;
      case #"hash_56a519e2698f4c00":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_cfb48576228a3860"));
        break;
      case #"hash_195a417c219fffbd":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_636e6ce763a20fdd"));
        break;
      case #"hash_c143cfedc1927b39":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_4bc4bb88131e8699"));
        break;
      case #"hash_cdd6ca24ce96d8bd":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"biobunker_office"));
        break;
      case #"hash_59a0dd972742aeb9":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"biobunker_controlroom"));
        break;
      case #"hash_7fbb5f9f358faed0":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"biobunker_datacenter"));
        break;
      case #"hash_d992c10dffeca81e":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_a1e793ac26a12e17"));
        break;
      case #"hash_ef4466fc27e2335b":
      case #"hash_d840fc340f4fb2a9":
      case #"hash_4405af9f9355826f":
      case #"hash_70e8ff17062df539":
      case #"hash_ca6f3ef251522f6e":
      case #"hash_9f0c1996da0a141d":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_702d936788ebb392"));
        break;
      case #"hash_d00b2649393d575e":
      case #"hash_5f470fe723f4ac62":
      case #"hash_6345a03814056e63":
      case #"hash_9895bca361f5ee79":
      case #"hash_3a3e3fad3c7e0fd8":
      case #"hash_4c0ccbf75bd12a9e":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_6c9971dc95f5ea2e"));
        break;
      case #"hash_aa790d5061be7e0":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_4a491dc568ffb351"));
        break;
      case #"hash_e9f055c957f58c7b":
      case #"hash_b23f3c4bcab3389f":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_dac79abf66b30786"));
        break;
      case #"hash_d56f56b926ffa5a8":
      case #"hash_67f0b15012940b27":
      case #"hash_48248177a355e6d0":
      case #"hash_29b5b1340ca62859":
      case #"hash_cf710b2d0741957":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_cf02ca46b264404b"));
        break;
      case #"hash_56ce07d688a8cc35":
      case #"hash_3ab1f47b170779e7":
      case #"hash_86be6f0df24e7175":
      case #"hash_cbc8b9454f10b472":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_3153e18b02a7b2fe"));
        break;
      case #"hash_1c3b698670b92bd8":
      case #"hash_7f9fd6541d224e4f":
      case #"hash_8fa5c0d46f66aba":
      case #"hash_9f99e2558bc2ee75":
      case #"hash_ad290bc3879a61a5":
      case #"hash_b291f62c4f838d69":
      case #"hash_d2873e6c50d30c9a":
      case #"hash_de9bd027765ded6a":
      case #"hash_cbbab3d1181cc5aa":
      case #"hash_faf020a111b1d553":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_cc47ef5350239996"));
        break;
      case #"hash_6742dc8335627d03":
      case #"hash_d21569d9eedad28b":
      case #"hash_e49fb665377a1c78":
      case #"hash_f1f4f066db011804":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_5e5c0da166eb1c7c"));
        break;
      case #"hash_58caefecc905d836":
      case #"hash_540ae336fcf22f3c":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_d796dffa9020677"));
        break;
      case #"hash_8a71d33feb6bee7e":
      case #"hash_76200439abcbd7af":
      case #"hash_3b58e913535cb270":
      case #"hash_7589f405905760b3":
      case #"hash_c729f1b3c5ef3ba8":
      case #"hash_edfe2d2de8981b7e":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_3e2b15e9829ad6ad"));
        break;
      case #"hash_fa5350c47461cdad":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"escape5_prison"));
        break;
      case #"hash_9d44a22d47871cea":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_6d747250cfa0cc6a"));
        break;
      case #"hash_4d22a809b9daf0d4":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_9c9dc5fc8944ee34"));
        break;
      case #"hash_8d3d09b5687be1d1":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_ba848c18711dffd1"));
        break;
      case #"hash_6bbdec4731818079":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_74d927a1a805d619"));
        break;
      case #"hash_57a2f934a51922a9":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_c5b253d95a30f6a9"));
        break;
      case #"hash_e511218d3e76eebb":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_b70c0b13f056695b"));
        break;
      case #"hash_4a1b678534be0385":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_11842a72533ae4c5"));
        break;
      case #"hash_f8ec7086767dc988":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_5e9d4e6f0ea0baa8"));
        break;
      case #"hash_d282c45d2d7de82c":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_6ddc58665e5c03cc"));
        break;
      case #"hash_c06d52f6584cdb57":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_cabb4fc631185cf7"));
        break;
      case #"hash_eaaa01412d116ecc":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_6e6cd64e3490034c"));
        break;
      case #"hash_aeffa38470394174":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_2244f829f0e6ae94"));
        break;
      case #"hash_3a890daeae33881e":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_688f3f5fa37effe"));
        break;
      case #"hash_5249f2b5caecd083":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_81b484874993bc6"));
        break;
      case #"hash_7ebc2d64a0fa944f":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_7f91b27c1cb28baf"));
        break;
      case #"hash_b9e6c4761e35be16":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_10b5c24cd8264496"));
        break;
      case #"hash_2a77698ee6f594eb":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_b2964fcc2da9f2cb"));
        break;
      case #"hash_621f7eb9b90d883c":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_3a93b1226ffdc3dc"));
        break;
      case #"hash_1a4fa3789f58993b":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_478b09adb6177c5b"));
        break;
      case #"hash_92d9c60efd43b00f":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_8661390318e942ef"));
        break;
      case #"hash_7d5b98defb3f6bf0":
      case #"hash_888969ad74c91df2":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"hash_4ab90ab25ca1ed92"));
        break;
      default:
        break;
    }
  }

  if(isDefined(sublocation)) {
    switch (sublocation) {
      case #"hash_70402ffb70386a5c":
        location = function_6d40f12a09494350(location, ae_utility::function_e2ff8f4b4e94f723(#"hash_dc0d981f2d59d210", #"saba_sandstorm"));
        break;
    }
  }

  return location;
}

function private function_d1f7d516770b2b32() {
  location = 0;
  location2 = 0;

  if(isDefined(self) && isDefined(self.var_766d1e8b079cbd07)) {
    poinames = function_5b2c23ea4889f30b(self.var_766d1e8b079cbd07);

    if(isDefined(poinames)) {
      location = getlocation(poinames);
      location2 = function_55be16fb0f5f4a19(poinames);
    }
  }

  return [location, location2];
}

function function_3ea2b9fa713d6ed3(player, var_154881e25e509d00) {
  loadout_perks = findloadoutperks(player);
  var_e4f4a057080c0ed5 = [];

  if(!isDefined(var_154881e25e509d00)) {
    var_154881e25e509d00 = 1;
  }

  switch (var_154881e25e509d00) {
    case 1:
      var_e4f4a057080c0ed5 = function_d6973792fd45b035();
      break;
    case 2:
      var_e4f4a057080c0ed5 = function_343f3f4300421f65();
      break;
  }

  var_7fb63b7fac6d1698 = 0;

  foreach(perk in loadout_perks) {
    if(isDefined(var_e4f4a057080c0ed5[perk])) {
      var_7fb63b7fac6d1698 = function_6d40f12a09494350(var_7fb63b7fac6d1698, var_e4f4a057080c0ed5[perk]);
    }
  }

  return var_7fb63b7fac6d1698;
}

function function_b050ed1983293d8(player, eventtypebit, perkref, value) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();

  if(isDefined(value) && value < 0) {
    value = 1;
  }

  perkid = 0;

  if(isDefined(perkref)) {
    perkid = loot::getlootidfromref(perkref);
  }

  bitfield = 0;
  bitfield = function_6d40f12a09494350(bitfield, eventtypebit);
  location = 0;
  location2 = 0;

  if(isDefined(player.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(player.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(player.closestpoi));
  }

  aeeventname = #"perk";
  function_8e81148472fb520a(player, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), value, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), perkid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_83a2d67994d7e295"), bitfield]);
}

function function_2aff99309a417c21(eventparamsstruct, aeeventname, aekeyname, value) {
  keyid = ae_utility::function_d6f771aedba70ce7(aeeventname, aekeyname);
  assertex(isDefined(keyid), "<dev string:x5f5>" + function_3c8848a3a11b2553(aekeyname) + "<dev string:x61e>");
  assertex(isDefined(value), "<dev string:x643>" + function_3c8848a3a11b2553(aekeyname) + "<dev string:x61e>");

  if(isDefined(keyid) && isDefined(value)) {
    eventparamsstruct.eventparams[eventparamsstruct.eventparams.size] = keyid;
    eventparamsstruct.eventparams[eventparamsstruct.eventparams.size] = value;
  }
}

function function_137b512700167b00(attacker, victim) {
  if(isagent(victim) || isPlayer(victim)) {
    onzipline = victim isonzipline();
  }

  victimstruct = spawnStruct();
  victimstruct.var_e4738651e7e13c78 = function_9da07c7f4a49e349(victim);
  [victimstruct.enemytype, victimstruct.var_7b718ef6c64f049f] = findenemytype(victim);
  victimstruct.var_14edc6d1db3695bc = isDefined(victim.var_d37b75616f7c2ee) && victim.var_d37b75616f7c2ee.var_14edc6d1db3695bc;
  victimstruct.v_distance = int(distance(attacker.origin, victim.origin));
  victimstruct.origin = victim.origin;
  victimstruct.team = victim.team;
  victimstruct.on_zipline = istrue(onzipline);
  victimstruct.var_379d31f8d73d8b2f = 1;
  return victimstruct;
}

function reportkillchallengeevent(attacker, victimstruct, modifiers1, modifiers2, modifiers3, objweapon, damage, meansofdeath, attachmentflags, hitloc, var_1d68c79557cc54ea) {
  if(!isDefined(attacker)) {
    assertmsg("<dev string:x66c>");
    return;
  }

  var_6ddcf3c092eaf383 = level.var_ec851999e0e99879;

  if(!isDefined(var_6ddcf3c092eaf383)) {
    var_6ddcf3c092eaf383 = function_6b7aeb2012efc4af();
  }

  modifiers1 = default_to(modifiers1, 0);
  modifiers2 = default_to(modifiers2, 0);
  modifiers3 = default_to(modifiers3, 0);
  attachmentflags = default_to(attachmentflags, 0);
  hitloc = default_to(hitloc, 0);
  gametype = var_6ddcf3c092eaf383.gametype;
  gamemode = var_6ddcf3c092eaf383.gamemode;
  enemytype = victimstruct.enemytype;
  var_7b718ef6c64f049f = victimstruct.var_7b718ef6c64f049f;
  var_e4738651e7e13c78 = victimstruct.var_e4738651e7e13c78;

  if(!isDefined(attacker.criticalstreak)) {
    attacker.criticalstreak = 0;
  }

  if(istrue(victimstruct.var_14edc6d1db3695bc)) {
    attacker.criticalstreak++;
  } else {
    attacker.criticalstreak = 0;
  }

  criticalstreak = isDefined(attacker.criticalstreak) ? attacker.criticalstreak : 0;

  if(!isDefined(attacker.var_a0595326ca4cf35d)) {
    attacker.var_a0595326ca4cf35d = 0;
  }

  attacker.var_a0595326ca4cf35d++;
  var_a0595326ca4cf35d = attacker.var_a0595326ca4cf35d;
  v_distance = victimstruct.v_distance;
  victim = undefined;
  killing_event = spawnStruct();
  throttle::function_f632348cbb773537(level.var_1850e46a71d6e72d, killing_event);
  var_349e390338192305 = findgunsmithattachments(objweapon);
  var_4adb82c833e8d5ab = function_3ea2b9fa713d6ed3(attacker);
  var_4adb83c833e8d7de = function_3ea2b9fa713d6ed3(attacker, 2);
  var_b5eec3b49cf346d2 = [damage, 0];
  var_a5958dc7369199c7 = "none";

  if(isDefined(attacker.super) && isDefined(attacker.super.staticdata) && isDefined(attacker.super.staticdata.ref) && attacker.super.isactive) {
    var_a5958dc7369199c7 = attacker.super.staticdata.ref;
  }

  var_c0d251f100091822 = loot::getlootidfromref(var_a5958dc7369199c7);
  operatorlootid = attacker function_aff35122a61a900b(attacker.team);

  if(!isDefined(operatorlootid)) {
    operatorlootid = 0;
  }

  weaponlootid = weapon::function_89a83ae9a4c4142a(objweapon);

  if(!isDefined(weaponlootid)) {
    weaponlootid = 0;
  }

  var_9eeb614f9aee06b3 = 0;
  weaponcamo = 0;

  if(isDefined(objweapon) && isDefined(objweapon.camo)) {
    weaponcamoname = objweapon.camo;

    if(utility::issharedfuncdefined("zombie", "get_pap_level")) {
      var_29a8ba8c9dd43fd2 = attacker utility::function_f3bb4f4911a1beb2("zombie", "get_pap_level", objweapon);
      var_3a56a10345d2e89a = objweapon.var_9d7facbe889e667c;

      if(isarray(attacker.var_c37e65eb7cc773eb) && isDefined(var_3a56a10345d2e89a) && isDefined(var_29a8ba8c9dd43fd2) && var_29a8ba8c9dd43fd2 != 0) {
        overridecamo = attacker.var_c37e65eb7cc773eb[var_3a56a10345d2e89a];

        if(isDefined(overridecamo)) {
          weaponcamoname = overridecamo;
        }
      }
    }

    if(issubstr(weaponcamoname, "_comp_01")) {
      if(issubstr(weaponcamoname, "_ob_")) {
        weaponcamo = ae_utility::function_b40278e5e468c6c1(#"hash_e378877c59549e7d", #"hash_1425cef80244bd8a");
      } else {
        weaponcamo = ae_utility::function_b40278e5e468c6c1(#"hash_e378877c59549e7d", #"weapon_camo_type_gold");
      }
    } else if(issubstr(weaponcamoname, "_comp_02")) {
      if(issubstr(weaponcamoname, "_ob_")) {
        weaponcamo = ae_utility::function_b40278e5e468c6c1(#"hash_e378877c59549e7d", #"hash_90d460c1776ac629");
      } else {
        weaponcamo = ae_utility::function_b40278e5e468c6c1(#"hash_e378877c59549e7d", #"weapon_camo_type_platinium");
      }
    } else if(issubstr(weaponcamoname, "_comp_03")) {
      if(issubstr(weaponcamoname, "_ob_")) {
        weaponcamo = ae_utility::function_b40278e5e468c6c1(#"hash_e378877c59549e7d", #"hash_47b3cb5f609633a5");
      } else {
        weaponcamo = ae_utility::function_b40278e5e468c6c1(#"hash_e378877c59549e7d", #"weapon_camo_type_polyatomic");
      }
    } else if(issubstr(weaponcamoname, "_comp_04")) {
      if(issubstr(weaponcamoname, "_ob_")) {
        weaponcamo = ae_utility::function_b40278e5e468c6c1(#"hash_e378877c59549e7d", #"hash_14352924a5376243");
      } else {
        weaponcamo = ae_utility::function_b40278e5e468c6c1(#"hash_e378877c59549e7d", #"weapon_camo_type_orion");
      }
    }
  }

  weaponclassarray = getweaponclassarray();
  var_b28608820870666 = 0;
  var_b28608820870666 = function_ce112254f7cba89e(objweapon);
  iskillstreak = weapon::iskillstreakweapon(objweapon) || istrue(attacker.isjuggernaut);
  isvehicle = utility::issharedfuncdefined("vehicle", "isVehicleWeapon") && [[utility::getsharedfunc("vehicle", "isVehicleWeapon")]](objweapon);
  isequipment = 0;
  equipmentid = 0;

  if(weaponlootid == 0) {
    equipmentweaponname = function_f09e914e200d1a42(objweapon);
    equipmentstruct = level.equipment.table[equipmentweaponname];

    if(isDefined(equipmentstruct)) {
      weaponlootid = loot::getlootidfromref(equipmentstruct.ref);
      isequipment = 1;
    }
  }

  blueprintlootid = 0;

  if(isDefined(objweapon) && isDefined(objweapon.weaponblueprint)) {
    blueprintlootid = objweapon.weaponblueprint.lootid;
  }

  if(isequipment) {
    if(!isDefined(var_b28608820870666)) {
      var_b28608820870666 = 0;
    }

    if(isDefined(attacker) && isDefined(objweapon) && isDefined(weaponclassarray[weaponclass(objweapon)])) {
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray[weaponclass(objweapon)]);
    }
  }

  location = 0;
  location2 = 0;

  if(isDefined(attacker.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(attacker.closestpoi), attacker.sublocation);
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(attacker.closestpoi), attacker.sublocation);
  }

  if(iskillstreak) {
    if(!isDefined(var_b28608820870666)) {
      var_b28608820870666 = 0;
    }

    var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["killstreak"]);

    if(isDefined(level.killstreakweaponmap)) {
      killstreakweaponname = level.killstreakweaponmap[objweapon.basename];

      if(isDefined(killstreakweaponname)) {
        weaponlootid = loot::getlootidfromref(killstreakweaponname);
      }
    }
  }

  var_bb38571cca0414f = function_c1945f26d99b0ed9(attacker);
  var_3fff36caeace1b84 = function_5d99311b5a7dffda();

  if(isDefined(level.var_c596a10a13c5cd7c)) {
    var_3fff36caeace1b84 = [[level.var_c596a10a13c5cd7c]](var_3fff36caeace1b84, victim);
  }

  in_prematch = istrue(level.inprematch);
  teamsize = var_6ddcf3c092eaf383.teamsize;

  if(issharedfuncdefined("pmc_missions", "onEnemyKilled")) {
    attacker thread[[getsharedfunc("pmc_missions", "onEnemyKilled")]](attacker, victim, objweapon, modifiers1);
  }

  if(!isDefined(attacker.var_c78bf6b063fc5789)) {
    attacker.var_c78bf6b063fc5789 = 0;
  }

  attacker.var_c78bf6b063fc5789 += 1;
  var_4a7a1118f15a4c9 = attacker.var_c78bf6b063fc5789;

  if(!isDefined(attacker.var_79a1a1fe9f3bf357)) {
    attacker.var_79a1a1fe9f3bf357 = 0;
  }

  if(objweapon == attacker getcurrentweapon()) {
    attacker.var_79a1a1fe9f3bf357 += 1;
  }

  var_79a1a1fe9f3bf357 = attacker.var_79a1a1fe9f3bf357;
  victim_on_zipline = victimstruct.on_zipline;
  aeeventname = #"kill";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  playlistid = getplaylistid();

  if(!isDefined(level.var_a3dfc554743efd89)) {
    level.var_a3dfc554743efd89 = [];
  }

  if(!isDefined(level.var_a7f8fb431b350d82)) {
    level.var_a7f8fb431b350d82 = [];
  }

  if(!istrue(level.var_a7f8fb431b350d82[#"reportkillchallengeevent"])) {
    level.var_a3dfc554743efd89[#"gamemode"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode");
    level.var_a3dfc554743efd89[#"hash_834ae5ef756e04aa"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_834ae5ef756e04aa");
    level.var_a3dfc554743efd89[#"weapon_loot_id"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id");
    level.var_a3dfc554743efd89[#"gametype"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype");
    level.var_a3dfc554743efd89[#"version"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"version");
    level.var_a3dfc554743efd89[#"weapon_attachment1"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment1");
    level.var_a3dfc554743efd89[#"weapon_attachment2"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment2");
    level.var_a3dfc554743efd89[#"weapon_attachment3"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment3");
    level.var_a3dfc554743efd89[#"weapon_attachment4"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment4");
    level.var_a3dfc554743efd89[#"weapon_attachment5"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment5");
    level.var_a3dfc554743efd89[#"weapon_attachment6"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment6");
    level.var_a3dfc554743efd89[#"weapon_attachment7"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_attachment7");
    level.var_a3dfc554743efd89[#"hash_af7ce1c514ea64cd"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_af7ce1c514ea64cd");
    level.var_a3dfc554743efd89[#"hash_af7ce0c514ea631a"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_af7ce0c514ea631a");
    level.var_a3dfc554743efd89[#"hash_1b7a08e28a2f9d76"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_1b7a08e28a2f9d76");
    level.var_a3dfc554743efd89[#"hash_a0dd9c7405f2d85e"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_a0dd9c7405f2d85e");
    level.var_a3dfc554743efd89[#"hash_7f94e81c1787ff7a"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_7f94e81c1787ff7a");
    level.var_a3dfc554743efd89[#"hash_7f94e71c1787fdc7"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_7f94e71c1787fdc7");
    level.var_a3dfc554743efd89[#"hash_7f94e61c1787fc14"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_7f94e61c1787fc14");
    level.var_a3dfc554743efd89[#"hash_e2f5c601b57b3960"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e2f5c601b57b3960");
    level.var_a3dfc554743efd89[#"hash_92939ab8dccb3d82"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82");
    level.var_a3dfc554743efd89[#"hash_dc0d981f2d59d210"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210");
    level.var_a3dfc554743efd89[#"hash_bd518e95df4103fe"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bd518e95df4103fe");
    level.var_a3dfc554743efd89[#"hash_bd518d95df41024b"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bd518d95df41024b");
    level.var_a3dfc554743efd89[#"loot_id"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id");
    level.var_a3dfc554743efd89[#"hash_194a05cc530d4e0d"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_194a05cc530d4e0d");
    level.var_a3dfc554743efd89[#"distance"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"distance");
    level.var_a3dfc554743efd89[#"hash_1ce058287dc8c73b"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_1ce058287dc8c73b");
    level.var_a3dfc554743efd89[#"weapon_camo"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_camo");
    level.var_a3dfc554743efd89[#"hit_loc"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hit_loc");
    level.var_a3dfc554743efd89[#"team_size"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"team_size");
    level.var_a3dfc554743efd89[#"hash_ab2e7c9b727a3d6c"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_ab2e7c9b727a3d6c");
    level.var_a3dfc554743efd89[#"hash_2f109e5ad9e45eff"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_2f109e5ad9e45eff");
    level.var_a3dfc554743efd89[#"hash_7e912c64fa5c6cde"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_7e912c64fa5c6cde");
    level.var_a3dfc554743efd89[#"hash_16db99d7417ef29d"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_16db99d7417ef29d");
    level.var_a3dfc554743efd89[#"hash_22d8c6e760626656"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_22d8c6e760626656");
    level.var_a3dfc554743efd89[#"playlist_id"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"playlist_id");
    level.var_a3dfc554743efd89[#"victim_on_zipline"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"victim_on_zipline");
    level.var_a3dfc554743efd89[#"hash_648b2ad7f16589f0"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_648b2ad7f16589f0");
    level.var_a3dfc554743efd89[#"hash_3e038eef2f8914a6"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_3e038eef2f8914a6");
    level.var_a3dfc554743efd89[#"hash_4a2a8345ce12358"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_4a2a8345ce12358");
    level.var_a3dfc554743efd89[#"hash_37ac48cb5a8cddea"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_37ac48cb5a8cddea");
    level.var_a7f8fb431b350d82[#"reportkillchallengeevent"] = 1;
  }

  paramcache = level.var_a3dfc554743efd89;
  eventparams = [paramcache[#"gamemode"], gamemode, paramcache[#"hash_834ae5ef756e04aa"], operatorlootid, paramcache[#"weapon_loot_id"], weaponlootid, paramcache[#"gametype"], gametype, paramcache[#"version"], 1, paramcache[#"weapon_attachment1"], var_349e390338192305[0], paramcache[#"weapon_attachment2"], var_349e390338192305[1], paramcache[#"weapon_attachment3"], var_349e390338192305[2], paramcache[#"weapon_attachment4"], var_349e390338192305[3], paramcache[#"weapon_attachment5"], var_349e390338192305[4], paramcache[#"weapon_attachment6"], var_349e390338192305[5], paramcache[#"weapon_attachment7"], var_349e390338192305[6], paramcache[#"hash_af7ce1c514ea64cd"], var_349e390338192305[7], paramcache[#"hash_af7ce0c514ea631a"], var_349e390338192305[8], paramcache[#"hash_1b7a08e28a2f9d76"], var_349e390338192305[9], paramcache[#"hash_a0dd9c7405f2d85e"], var_b28608820870666, paramcache[#"hash_7f94e81c1787ff7a"], modifiers1, paramcache[#"hash_7f94e71c1787fdc7"], modifiers2, paramcache[#"hash_e2f5c601b57b3960"], enemytype, paramcache[#"hash_92939ab8dccb3d82"], location, paramcache[#"hash_dc0d981f2d59d210"], location2, paramcache[#"hash_bd518e95df4103fe"], var_4adb82c833e8d5ab, paramcache[#"hash_bd518d95df41024b"], var_4adb83c833e8d7de, paramcache[#"loot_id"], var_c0d251f100091822, paramcache[#"hash_194a05cc530d4e0d"], blueprintlootid, paramcache[#"distance"], v_distance, paramcache[#"hash_1ce058287dc8c73b"], attachmentflags, paramcache[#"weapon_camo"], weaponcamo, paramcache[#"hit_loc"], hitloc, paramcache[#"team_size"], teamsize, paramcache[#"hash_ab2e7c9b727a3d6c"], var_3fff36caeace1b84, paramcache[#"hash_2f109e5ad9e45eff"], criticalstreak, paramcache[#"hash_7e912c64fa5c6cde"], var_79a1a1fe9f3bf357, paramcache[#"hash_16db99d7417ef29d"], var_a0595326ca4cf35d, paramcache[#"hash_22d8c6e760626656"], var_7b718ef6c64f049f, paramcache[#"hash_7f94e61c1787fc14"], modifiers3, paramcache[#"playlist_id"], playlistid, paramcache[#"victim_on_zipline"], victim_on_zipline];

  if(isDefined(var_1d68c79557cc54ea)) {
    if(isDefined(var_1d68c79557cc54ea[0])) {
      eventparams[eventparams.size] = paramcache[#"hash_648b2ad7f16589f0"];
      eventparams[eventparams.size] = var_1d68c79557cc54ea[0];
    }

    if(isDefined(var_1d68c79557cc54ea[1])) {
      eventparams[eventparams.size] = paramcache[#"hash_3e038eef2f8914a6"];
      eventparams[eventparams.size] = var_1d68c79557cc54ea[1];
    }

    if(isDefined(var_1d68c79557cc54ea[2])) {
      eventparams[eventparams.size] = paramcache[#"hash_4a2a8345ce12358"];
      eventparams[eventparams.size] = var_1d68c79557cc54ea[2];
    }
  }

  if(var_e4738651e7e13c78 > 0) {
    eventparams[eventparams.size] = paramcache[#"hash_37ac48cb5a8cddea"];
    eventparams[eventparams.size] = var_e4738651e7e13c78;
  }

  attacker reportchallengeuserserializedeventwrapper(aeeventid, eventparams);
  eventparamssquad = [];

  if(isDefined(var_1d68c79557cc54ea)) {
    if(isDefined(victimstruct) && isDefined(victimstruct.var_aaf0465944b061ed) && victimstruct.var_aaf0465944b061ed == "warlord_kia") {
      eventparamssquad = [paramcache[#"gamemode"], gamemode, paramcache[#"gametype"], gametype, paramcache[#"version"], 1];
    }

    if(isDefined(var_1d68c79557cc54ea[0])) {
      eventparamssquad[eventparamssquad.size] = paramcache[#"hash_648b2ad7f16589f0"];
      eventparamssquad[eventparamssquad.size] = var_1d68c79557cc54ea[0];
    }

    if(isDefined(var_1d68c79557cc54ea[1])) {
      eventparamssquad[eventparamssquad.size] = paramcache[#"hash_3e038eef2f8914a6"];
      eventparamssquad[eventparamssquad.size] = var_1d68c79557cc54ea[1];
    }

    if(isDefined(var_1d68c79557cc54ea[2])) {
      eventparamssquad[eventparamssquad.size] = paramcache[#"hash_4a2a8345ce12358"];
      eventparamssquad[eventparamssquad.size] = var_1d68c79557cc54ea[2];
    }
  }

  if(isDefined(victimstruct) && istrue(victimstruct.var_379d31f8d73d8b2f)) {
    function_fee0bee456eac877(attacker, aeeventname, eventparamssquad, victimstruct);
  }
}

function function_e6ba0866eca5b87b(attacker, iskillstreak) {
  if(!isDefined(attacker)) {
    assertmsg("<dev string:x66c>");
    return;
  }

  var_9b8336914d1339a9 = attacker.currentmultikill;

  if(!isDefined(var_9b8336914d1339a9) || !isDefined(iskillstreak)) {
    return;
  }

  gamemode = getchallengegamemode(attacker);
  gametype = function_17c5d7feb226e256();
  aeeventname = #"multikill";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  objweapon = attacker getcurrentweapon();

  if(isDefined(objweapon)) {
    weaponlootid = weapon::function_89a83ae9a4c4142a(objweapon);

    if(!isDefined(weaponlootid)) {
      weaponlootid = 0;
    }

    if(weaponlootid == 0) {
      equipmentweaponname = function_f09e914e200d1a42(objweapon);
      equipmentstruct = level.equipment.table[equipmentweaponname];

      if(isDefined(equipmentstruct)) {
        weaponlootid = loot::getlootidfromref(equipmentstruct.ref);
      }
    }
  }

  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"kill_amount"), var_9b8336914d1339a9, ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), weaponlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"is_killstreak"), iskillstreak];
  attacker reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_aad625406f236f34(value, attacker, objweapon) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }

  if(isagent(attacker) || !isDefined(objweapon)) {
    return;
  }

  weaponlootid = weapon::function_89a83ae9a4c4142a(objweapon);

  if(!isDefined(weaponlootid)) {
    weaponlootid = 0;
  }

  weaponclassarray = getweaponclassarray();
  var_b28608820870666 = 0;
  var_b28608820870666 = function_ce112254f7cba89e(objweapon);
  iskillstreak = weapon::iskillstreakweapon(objweapon) || istrue(attacker.isjuggernaut);
  isequipment = 0;

  if(weaponlootid == 0) {
    equipmentweaponname = function_f09e914e200d1a42(objweapon);
    equipmentstruct = level.equipment.table[equipmentweaponname];

    if(isDefined(equipmentstruct)) {
      weaponlootid = loot::getlootidfromref(equipmentstruct.ref);
      isequipment = 1;
    }
  }

  if(isequipment) {
    if(!isDefined(var_b28608820870666)) {
      var_b28608820870666 = 0;
    }

    if(isDefined(attacker) && isDefined(objweapon) && isDefined(weaponclassarray[weaponclass(objweapon)])) {
      var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray[weaponclass(objweapon)]);
    }
  }

  if(iskillstreak) {
    if(!isDefined(var_b28608820870666)) {
      var_b28608820870666 = 0;
    }

    var_b28608820870666 = function_6d40f12a09494350(var_b28608820870666, weaponclassarray["killstreak"]);

    if(isDefined(level.killstreakweaponmap)) {
      killstreakweaponname = level.killstreakweaponmap[objweapon.basename];

      if(isDefined(killstreakweaponname)) {
        weaponlootid = loot::getlootidfromref(killstreakweaponname);
      }
    }
  }

  gamemode = getchallengegamemode(attacker);
  gametype = function_17c5d7feb226e256();
  aeeventname = #"hash_ac96abd2c9cfa32e";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  attacker.var_ada2682fdf125e83 = undefined;
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_a0dd9c7405f2d85e"), var_b28608820870666, ae_utility::function_d6f771aedba70ce7(aeeventname, #"weapon_loot_id"), weaponlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), value];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_c43d8b7a5461cdce(lootid) {
  var_25978461c6e4f61b = loot::getscriptablefromlootid(lootid);
  itemtype = undefined;

  if(!isDefined(var_25978461c6e4f61b)) {
    itemtype = loot::function_282cf83c9eeda744(lootid);

    if(!isDefined(itemtype)) {
      return undefined;
    }
  } else {
    itemtype = level.br_pickups.br_itemtype[var_25978461c6e4f61b];
  }

  switch (itemtype) {
    case #"ammo":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_390ee15442e26b5a");
    case #"gear":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_586b8242aa331357");
    case #"health":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_5eb3ab4da847b262");
    case #"revive":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_6c8b69bd795806f5");
    case #"lethal":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_60a1e08b6f7a43fe");
    case #"tactical":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_66450f4f8837c2d9");
    case #"killstreak":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_98c2539a8ef0aef6");
    case #"super":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_722533776029e257");
    case #"weapon":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_f10ff7a627660838");
    case #"plunder":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_36993f9c4257b726");
    case #"attachment":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_729a9e5d9c8e2de1");
    case #"plate_carrier":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_aab4443965fdeddf");
    case #"keycard":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_27c621c0e4e32925");
    case #"key":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_59f198f5cae765f3");
    case #"valuable":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_10f39a5c7ed87e9e");
    case #"personal":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_796e898cedfe7de4");
    case #"dogtag":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_896fd6caf251de1e");
    case #"weaponcase":
      return ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_6f88af36718a54b1");
    default:
      return undefined;
  }
}

function function_cfeb523fd3aa9ecf(player, lootid, type, method, quantity, var_f237807396377232) {
  if(!player challengesenabledforplayer()) {
    return 0;
  }

  if(!isDefined(quantity)) {
    quantity = 1;
  }

  gamemode = scripts\cp_mp\challenges::getchallengegamemode(player);
  gametype = scripts\cp_mp\challenges::function_17c5d7feb226e256();
  aeeventname = #"use_item";
  typeid = 0;

  if(isDefined(type)) {
    typeid = ae_utility::function_7042dad035dc176c(type);
  }

  itemrarity = 0;

  if(isDefined(var_f237807396377232)) {
    itemrarity = var_f237807396377232.rarity;
  }

  if(!isDefined(method)) {
    method = 0;
    method = scripts\cp_mp\challenges::function_6d40f12a09494350(method, ae_utility::function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  }

  operatorlootid = player function_aff35122a61a900b(player.team);
  gametype = function_68ffb11dc4c6b979(gametype, aeeventname);
  gamemode = function_68ffb11dc4c6b979(gamemode, aeeventname);
  quantity = function_68ffb11dc4c6b979(quantity, aeeventname);
  operatorlootid = function_68ffb11dc4c6b979(operatorlootid, aeeventname);
  lootid = function_68ffb11dc4c6b979(lootid, aeeventname);
  itemrarity = function_68ffb11dc4c6b979(itemrarity, aeeventname);
  typeid = function_68ffb11dc4c6b979(typeid, aeeventname);
  method = function_68ffb11dc4c6b979(method, aeeventname);
  function_8e81148472fb520a(player, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), quantity, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), lootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_83a2d67994d7e295"), method, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"zm_rarity"), itemrarity]);
}

function function_d24138b32084fc3e(player, lootid, type, method, quantity, source, poi) {
  if(!player challengesenabledforplayer()) {
    return 0;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  typeid = undefined;

  if(isDefined(type)) {
    typeid = ae_utility::function_7042dad035dc176c(type);
  }

  loottype = undefined;

  if(isDefined(lootid)) {
    loottype = function_c43d8b7a5461cdce(lootid);
  }

  location = 0;
  location2 = 0;
  location = getlocation(utility::ter_op(isDefined(poi), poi, function_5b2c23ea4889f30b(player.closestpoi)));
  location2 = function_55be16fb0f5f4a19(utility::ter_op(isDefined(poi), poi, function_5b2c23ea4889f30b(player.closestpoi)));
  quantity = function_dc52e14b64052dda(lootid, quantity);

  if(isDefined(typeid) && typeid < 0) {
    logstring("IW9-592971: reportLootItemEvent::typeID is negative");
  }

  if(isDefined(quantity) && quantity < 0) {
    logstring("IW9-592971: reportLootItemEvent::quantity is negative");
  }

  if(isDefined(gamemode) && gamemode < 0) {
    logstring("IW9-592971: reportLootItemEvent::gameMode is negative");
  }

  if(isDefined(gametype) && gametype < 0) {
    logstring("IW9-592971: reportLootItemEvent::gameType is negative");
  }

  if(isDefined(location) && isint(location) && location < 0) {
    logstring("IW9-592971: reportLootItemEvent::location is negative");
  }

  if(isDefined(lootid) && lootid < 0) {
    logstring("IW9-592971: reportLootItemEvent::lootID is negative");
  }

  if(isDefined(method) && isint(method) && method < 0) {
    logstring("IW9-592971: reportLootItemEvent::method is negative");
  }

  if(isDefined(loottype) && loottype < 0) {
    logstring("IW9-592971: reportLootItemEvent::lootType is negative");
  }

  if(isDefined(source) && isint(source) && source < 0) {
    logstring("IW9-592971: reportLootItemEvent::source is negative");
  }

  aeeventname = #"loot_item";
  function_8e81148472fb520a(player, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"string_ref"), typeid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"value"), quantity, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), lootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_2af1f13aa6ae3b5f"), method, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d7806c74c1d4a500"), loottype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_source"), source]);
  println("<dev string:x6c1>");

  if(isDefined(level.var_97ea4daf8989e0c6)) {
    return [[level.var_97ea4daf8989e0c6]](player, lootid, loottype);
  }
}

function private reportstat(statname, amount) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(amount <= 0) {
    return;
  }

  var_e3fbce1c8509474f = hashcat(@ "hash_af7cfd1e80e4fb55", statname);
  var_a75e138cb4bcfef8 = getdvarint(var_e3fbce1c8509474f, 0);

  if(var_a75e138cb4bcfef8 > 0) {
    return;
  }

  reportstats = 0;
  damage_amount = 0;
  score_amount = 0;
  time_driving = 0;
  var_6eae97b1c039638c = 0;
  var_8dbdb5edd5a730f9 = 0;

  switch (statname) {
    case #"hash_1cc8a923a608c2a0":
      damage_amount = amount;
      reportstats = 1;
      break;
    case #"hash_2c58990905f03e75":
      score_amount = amount;
      reportstats = 1;
      break;
    case #"hash_32e41af5a3ef1340":
      time_driving = amount;
      reportstats = 1;
      break;
    case #"hash_76c0ec96dd3ab432":
      var_6eae97b1c039638c = int(amount / 1000);
      reportstats = 1;
      break;
    case #"hash_8d8693c020b1c720":
      var_8dbdb5edd5a730f9 = amount;
      reportstats = 1;
      break;
    case #"hash_804c8279b22808c2":
      break;
    case #"hash_3440d3368c358eaf":
      break;
    case #"hash_f402bcef661bfd9b":
      break;
    case #"hash_5b0b9aa2fec5584d":
      break;
    case #"hash_e85acef6a699314d":
      break;
    case #"hash_f3cef86f1056f64a":
      break;
    case #"hash_80804c8d4d60b774":
      break;
  }

  if(reportstats) {
    var_6ddcf3c092eaf383 = level.var_ec851999e0e99879;

    if(!isDefined(var_6ddcf3c092eaf383)) {
      var_6ddcf3c092eaf383 = function_6b7aeb2012efc4af();
    }

    aeeventname = #"stats";

    if(!isDefined(level.var_d44156bac78184ca)) {
      level.var_d44156bac78184ca = [];
    }

    if(!isDefined(level.var_a7f8fb431b350d82)) {
      level.var_a7f8fb431b350d82 = [];
    }

    if(!istrue(level.var_a7f8fb431b350d82[#"reportstats"])) {
      level.var_d44156bac78184ca[#"version"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"version");
      level.var_d44156bac78184ca[#"gamemode"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode");
      level.var_d44156bac78184ca[#"gametype"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype");
      level.var_d44156bac78184ca[#"damage"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"damage");
      level.var_d44156bac78184ca[#"score"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"score");
      level.var_d44156bac78184ca[#"team_size"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"team_size");
      level.var_d44156bac78184ca[#"time_driving"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"time_driving");
      level.var_d44156bac78184ca[#"value"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"value");
      level.var_d44156bac78184ca[#"hash_6ee3cf6540c5bcac"] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_6ee3cf6540c5bcac");
    }

    paramcache = level.var_d44156bac78184ca;
    eventparams = [paramcache[#"version"], 1, paramcache[#"gamemode"], var_6ddcf3c092eaf383.gamemode, paramcache[#"gametype"], var_6ddcf3c092eaf383.gametype, paramcache[#"damage"], damage_amount, paramcache[#"score"], score_amount, paramcache[#"team_size"], var_6ddcf3c092eaf383.teamsize, paramcache[#"time_driving"], time_driving, paramcache[#"value"], var_6eae97b1c039638c, paramcache[#"hash_6ee3cf6540c5bcac"], var_8dbdb5edd5a730f9];

    if(!isDefined(level.var_6de4f66f58ecd7b1)) {
      level.var_6de4f66f58ecd7b1 = [];
    }

    aeeventid = level.var_6de4f66f58ecd7b1[aeeventname];

    if(!isDefined(aeeventid)) {
      aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
      level.var_6de4f66f58ecd7b1[aeeventname] = aeeventid;
    }

    function_7d97a2a745e514c4(aeeventid, eventparams);

    reportchallengeuserserializedeventwrapper(aeeventid, eventparams);
  }
}

function private function_6b7aeb2012efc4af() {
  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  teamsize = 0;

  if(gamemode & 8) {
    teamsize = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();
  }

  basevalues = {
    #teamsize: teamsize, #gametype: gametype, #gamemode: gamemode
  };
  level.var_ec851999e0e99879 = basevalues;
  return basevalues;
}

function function_8a0395089290faf6(player) {
  function_b050ed1983293d8(player, ae_utility::function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"), "specialty_scavenger_plus", undefined);
}

function function_563606223ef09517(player, amount) {
  method = function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_2af1f13aa6ae3b5f", #"loot"));
  function_d24138b32084fc3e(player, 8395, ae_utility::function_b40278e5e468c6c1(#"itemtypes", #"hash_36993f9c4257b726"), method, amount, 0);
}

function findgunsmithattachments(objweapon) {
  var_349e390338192305 = [];

  if(!utility::issharedfuncdefined("weapons", "isCACPrimaryOrSecondary") || [[utility::getsharedfunc("weapons", "isCACPrimaryOrSecondary")]](objweapon)) {
    if(isDefined(objweapon.attachments)) {
      weaponrootname = weapon::getweaponrootname(objweapon);
      var_7208e21ea18240fb = 0;

      foreach(attachment in objweapon.attachments) {
        if(issubstr(attachment, "snprscope")) {
          var_7208e21ea18240fb = 1;
        }

        if(utility::issharedfuncdefined("weapons", "attachmentIsSelectable")) {
          if([[utility::getsharedfunc("weapons", "attachmentIsSelectable")]](objweapon, attachment)) {
            var_349e390338192305[var_349e390338192305.size] = weapon::function_693e108cb61ceeb5(weaponrootname, attachment);
          }
        }
      }

      if(var_7208e21ea18240fb) {
        var_349e390338192305[var_349e390338192305.size] = weapon::function_693e108cb61ceeb5(weaponrootname, "default_sniper_scope");
      }
    }
  }

  for(attachindex = var_349e390338192305.size; attachindex < 10; attachindex++) {
    var_349e390338192305[attachindex] = 0;
  }

  return var_349e390338192305;
}

function findloadoutperks(attacker) {
  loadout_perks = [];

  if(isDefined(attacker.classstruct)) {
    if(isDefined(attacker.classstruct.loadoutperks)) {
      foreach(perk in attacker.classstruct.loadoutperks) {
        loadout_perks = utility::array_add(loadout_perks, perk);
      }
    }

    if(isDefined(attacker.classstruct.var_15f3e6df722fb1cf)) {
      loadout_perks = utility::array_add(loadout_perks, attacker.classstruct.var_15f3e6df722fb1cf);
    }

    if(isDefined(attacker.classstruct.var_15f3e5df722faf9c)) {
      loadout_perks = utility::array_add(loadout_perks, attacker.classstruct.var_15f3e5df722faf9c);
    }
  }

  return loadout_perks;
}

function function_9da07c7f4a49e349(victim) {
  var_e4738651e7e13c78 = 0;

  if(!isDefined(victim.agent_type)) {
    return var_e4738651e7e13c78;
  }

  if(issubstr(victim.agent_type, "enemy_warlord_")) {
    if(issubstr(victim.agent_type, "_rushhour")) {
      return 1;
    } else if(issubstr(victim.agent_type, "_gunslinger")) {
      return 2;
    } else if(issubstr(victim.agent_type, "_shadow")) {
      return 3;
    } else if(issubstr(victim.agent_type, "_chemist")) {
      return 4;
    } else if(issubstr(victim.agent_type, "_hammernaut")) {
      return 5;
    } else if(issubstr(victim.agent_type, "_phalanx")) {
      return 6;
    } else if(issubstr(victim.agent_type, "_techmaestro")) {
      return 7;
    } else if(issubstr(victim.agent_type, "_rainmaker")) {
      return 8;
    } else if(issubstr(victim.agent_type, "_allforone")) {
      return 9;
    } else if(issubstr(victim.agent_type, "_md")) {
      return 10;
    } else if(issubstr(victim.agent_type, "_vera")) {
      return 11;
    } else if(issubstr(victim.agent_type, "_jugg")) {
      return 5;
    }
  }

  return var_e4738651e7e13c78;
}

function findenemytype(victim) {
  enemytype = 0;
  var_7b718ef6c64f049f = 0;

  if(isPlayer(victim)) {
    enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"player"));
  }

  isground = 0;
  var_ae8eb6d66c120397 = 0;
  issupport = 0;
  var_24f040a6728b6dc4 = 0;
  var_b93834c5c289dcdc = 0;

  if(isDefined(victim.streakinfo)) {
    enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"killstreak"));
    killstreakname = victim.streakinfo.streakname;
    var_b93834c5c289dcdc = iskillstreakvehicle(killstreakname);

    switch (killstreakname) {
      case #"hash_10e585c25e7e9f60":
      case #"hash_4220be38a5f150b8":
      case #"hash_4d35eb58f9d545f0":
      case #"hash_56979e0566996b2e":
      case #"hash_b161e185f1b8e117":
      case #"hash_b571a6187bf67f9e":
      case #"hash_ed469a6bfff6b265":
        var_24f040a6728b6dc4 = 1;
        break;
      case #"hash_4ad475e6e15635bd":
      case #"hash_4d5aa76e8707f47b":
      case #"hash_52d9b7ed584bec3e":
      case #"hash_cd0a0403551fc411":
      case #"hash_cf0ef5bef19a311b":
      case #"hash_e477c24ee18bb2f6":
        isground = 1;
        break;
      case #"hash_195360490caa3220":
      case #"hash_28d0236400e33fd0":
      case #"hash_349713b5ad494dda":
      case #"hash_413c38e72fe8b5bf":
      case #"hash_48cc3a9a58208f82":
      case #"hash_691f39dddd9116b8":
      case #"hash_a1031216158c7882":
      case #"hash_e6bea339d3cbd3e8":
        var_ae8eb6d66c120397 = 1;
        break;
      case #"hash_f64c697bfb4c6b54":
      case #"hash_27002778019fb447":
      case #"hash_e51f2e3d5cdd8ed8":
        var_ae8eb6d66c120397 = 1;
        issupport = 1;
        break;
      case #"hash_19dd9a3a4147e09e":
        isground = 1;
        var_24f040a6728b6dc4 = 1;
        break;
      case #"hash_2289ec11d77bce8f":
        issupport = 1;
        var_24f040a6728b6dc4 = 1;
        break;
      case #"hash_b4ac3581c343a029":
      case #"hash_8c766d6477287bb6":
      case #"hash_bf2f9adbd2b41d5":
      case #"hash_7a687f6a4d685110":
      case #"hash_6362d6aae3e5a62e":
        var_ae8eb6d66c120397 = 1;
        var_24f040a6728b6dc4 = 1;
        break;
      case #"hash_e171e5b86ef0a4cc":
      case #"hash_887ad77192b9c4fb":
      case #"hash_634b246c3da5c56f":
        var_ae8eb6d66c120397 = 1;
        issupport = 1;
        var_24f040a6728b6dc4 = 1;
        break;
    }

    if(isground) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"ground"));
    }

    if(var_ae8eb6d66c120397) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"aerial"));
    }

    if(issupport) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"support"));
    }

    if(var_24f040a6728b6dc4) {
      var_7b718ef6c64f049f = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"auto_killstreak"));
    } else {
      var_7b718ef6c64f049f = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"hash_26588836ee582767"));
    }
  }

  if(isDefined(victim.vehiclename)) {
    enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"vehicle"));
    canfly = istrue(victim vehicle::vehiclecanfly());
    isboat = istrue(victim vehicle::isvehicleboat());

    if(isground && !canfly && !isboat) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"ground"));
    } else if(var_ae8eb6d66c120397 || canfly) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"aerial"));
    }

    if(victim.vehiclename == "dmz_boss_chopper") {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"boss"));
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"chopper_boss"));
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"aerial"));
    } else if(victim.vehiclename == "pac_sentry") {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"boss"));
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"wheelson_boss"));
    } else if(victim.vehiclename == "veh9_armored_acv_6x6") {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"hash_12648e6785f3475b"));
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"boss"));
    }

    vehicletype = undefined;

    switch (victim.vehiclename) {
      case #"hash_c93466c10cc10ba":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"atv");
        break;
      case #"hash_7c54070d9b704f70":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"light_tank");
        break;
      case #"hash_9d4e22a00fc630b5":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"little_bird");
        break;
      case #"hash_112ffa8db1ed9ebd":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_acv_6x6");
        break;
      case #"hash_2ddb1b1fa5093dd1":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_apc_8x8");
        break;
      case #"hash_835a3b4bb4e34233":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_blima");
        break;
      case #"hash_b8b8fefba61ac382":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_chopped_pickup");
        break;
      case #"hash_cb2498c4a1e415fd":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_cougar");
        break;
      case #"hash_cbbafedb48ea9aea":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_hummer");
        break;
      case #"hash_d63b8f48fb92540d":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_jltv_mg");
        break;
      case #"hash_d212f4961f28eb58":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_jltv");
        break;
      case #"hash_f9260a8d132b789":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_mil_cargo_truck");
        break;
      case #"hash_5211f142350a63e1":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_overland_2016");
        break;
      case #"hash_66c8846b85d8c948":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_palfa");
        break;
      case #"hash_a2c475614741731":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_patrol_boat");
        break;
      case #"hash_d589a6a019e9defe":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_pickup_2014");
        break;
      case #"hash_81ea99824b4eacca":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_pwc");
        break;
      case #"hash_44d67727616d3059":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_rhib");
        break;
      case #"hash_228830c793bd36cb":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_sedan_hatchback_1985");
        break;
      case #"hash_f690b9139a2baa7e":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_suv_1996");
        break;
      case #"hash_cb367b51338c9d6":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_techo_rebel_armor");
        break;
      case #"hash_a7bdb3825f53a60d":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"veh9_utv");
        break;
    }

    if(isDefined(vehicletype)) {
      enemytype = function_6d40f12a09494350(enemytype, vehicletype);
    }

    if(isDefined(victim.riders)) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"ai_vehicle"));

      if(victim.vehiclename == "little_bird" || victim.vehiclename == "veh9_blima") {
        enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"reinforcement_chopper"));
      }
    }

    if(vehicle::vehicle_isenemytoplayer(victim, self)) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"enemy_vehicle"));
    }
  } else if(var_b93834c5c289dcdc) {
    enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"vehicle"));
  }

  if(isDefined(victim.equipmentref)) {
    enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"equipment"));
  }

  if(isagent(victim)) {
    if(isDefined(victim.aitype)) {
      enemytype = return_enemy_type_mask(enemytype, victim);
    } else if(isDefined(victim.agent_type)) {
      [enemytype, var_7b718ef6c64f049f] = function_e9dc49603ac403d(enemytype, var_7b718ef6c64f049f, victim);
    }
  }

  return [enemytype, var_7b718ef6c64f049f];
}

function function_8435d79a41ea37b0(victim) {
  enemytype = 0;
  vehicletype = undefined;

  if(isDefined(victim) && isDefined(victim.vehiclename)) {
    switch (victim.vehiclename) {
      case #"hash_8b763c32b6a3f882":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"veh_jup_jltv_mg");
        break;
      case #"hash_885f51af68244d3":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"veh_jup_suv_1996");
        break;
      case #"hash_c9d9aa17e7c175a5":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"veh_jup_pickup_2014");
        break;
      case #"hash_a4c3ae5c9f3a69f":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"hash_f56b6b0fcad9f6bf");
        break;
      case #"hash_c7645976ba1894f":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"veh9_motorcycle_blood_burner_physics");
        break;
      case #"hash_b5677ac5bf174357":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"veh_jup_orav");
        break;
      case #"hash_63cf913c1ee55d64":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"veh_jup_razorback");
        break;
      case #"hash_6437bb8a3a27be5e":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"veh_jup_truck_tech_hmg");
        break;
      case #"hash_da4cefbee9ff0d74":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"veh_jup_truck_tech_aa");
        break;
      case #"hash_cb654f4f90755a46":
        vehicletype = ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"veh_jup_space_shipment_transport");
        break;
    }
  }

  if(isDefined(vehicletype)) {
    enemytype = function_6d40f12a09494350(enemytype, vehicletype);
  }

  return enemytype;
}

function function_c7496288999ac847(agenttype, subcategory) {
  return issubstr(agenttype, "cartel") || function_7ee65fae13124702() && isDefined(subcategory) && subcategory == "elimTarget";
}

function function_e9dc49603ac403d(enemytype, var_7b718ef6c64f049f, victim) {
  enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"agent"));

  if(issubstr(victim.agent_type, "civilian")) {
    enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"civilian"));
  } else {
    var_86df29145c484d9c = issubstr(victim.agent_type, "biolab") || issubstr(victim.agent_type, "merc");

    if(!var_86df29145c484d9c) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"combatant"));
    }

    if(issubstr(victim.agent_type, "jugg")) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"juggernaut"));
    } else if(issubstr(victim.agent_type, "riotshield")) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"riotshield"));
    } else if(issubstr(victim.agent_type, "velikan")) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"boss"));
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"velikan_boss"));
    } else if(issubstr(victim.agent_type, "firebug")) {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"firebug"));
    } else if(issubstr(victim.agent_type, "butcher")) {
      var_7b718ef6c64f049f = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"hash_e016c28fc0fa9c90"));
    } else if(issubstr(victim.agent_type, "swamp")) {
      var_7b718ef6c64f049f = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"hash_d3d79e53ba73ecf1"));
    } else if(issubstr(victim.agent_type, "mummy")) {
      var_7b718ef6c64f049f = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"hash_529b2a005c09f2a4"));
    } else {
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"soldier"));
    }

    if(utility::issharedfuncdefined("ai_mp_controller", "agentPers_getAgentPersData")) {
      getagentpersdata = utility::getsharedfunc("ai_mp_controller", "agentPers_getAgentPersData");

      if(istrue([[getagentpersdata]](victim, "elite"))) {
        enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"elite"));
      }

      tier = [[getagentpersdata]](victim, "tier");

      if(isDefined(tier)) {
        if(tier == 1) {
          enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"tier1"));
        } else if(tier == 2) {
          enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"tier2"));
        } else {
          enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"tier3"));
        }

        if(tier == 2 || tier == 3) {
          enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"armored"));
        }
      }

      category = [[getagentpersdata]](victim, "category");
      subcategory = [[getagentpersdata]](victim, "subcategory");

      if(issubstr(victim.agent_type, "aq")) {
        enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"AQ"));
      } else if(var_86df29145c484d9c) {
        enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"shadow_company"));
      } else if(function_c7496288999ac847(victim.agent_type, subcategory)) {
        enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"cartel"));
      } else if(issubstr(victim.agent_type, "ru")) {
        enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"russian"));
      }

      if(isDefined(category) && isDefined(subcategory)) {
        if(category == "mission" && subcategory == "elimTarget") {
          enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"elim_target"));
        }

        if(category == "bosses") {
          enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"boss"));

          if(subcategory == "jugg") {
            enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"juggernaut_boss"));
          } else if(subcategory == "chemistBoss") {
            enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"chemist_boss"));
          } else if(subcategory == "trapperBoss") {
            enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"trapper_boss"));
          } else if(subcategory == " pyroBoss") {
            enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"pyro_boss"));
          } else if(subcategory == "ratBoss") {
            enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"scav_boss"));
          } else if(subcategory == "sniperBoss") {
            enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"sniper_boss"));
          } else if(subcategory == "rusherBoss") {
            enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"rusher_boss"));
          } else if(subcategory == "jailerBoss") {
            var_7b718ef6c64f049f = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_22d8c6e760626656", #"rat_boss"));
          }
        }

        if(subcategory == "jailerBossMinion") {
          var_7b718ef6c64f049f = function_6d40f12a09494350(enemytype, function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"rat"));
        }
      }
    }
  }

  return [enemytype, var_7b718ef6c64f049f];
}

function return_enemy_type_mask(enemytype, victim) {
  if(!isDefined(victim.aitype)) {
    return enemytype;
  }

  switch (victim.aitype) {
    case #"hash_44aaeb0edd152195":
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"soldier"));
      break;
    case #"hash_4ad475e6e15635bd":
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"juggernaut"));
      break;
    case #"hash_1403dfb5d1265ddc":
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"suicidebomber"));
      break;
    case #"hash_321a9678047d0a4e":
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"riotshield"));
      break;
    default:
      enemytype = function_6d40f12a09494350(enemytype, ae_utility::function_e2ff8f4b4e94f723(#"hash_e2f5c601b57b3960", #"agent"));
      break;
  }

  return enemytype;
}

function private function_742decc7f891bb0e(bitfield1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  operatorlootid = function_aff35122a61a900b(self.team);
  location = 0;
  location2 = 0;

  if(isDefined(self.closestpoi)) {
    location = getlocation(function_5b2c23ea4889f30b(self.closestpoi));
    location2 = function_55be16fb0f5f4a19(function_5b2c23ea4889f30b(self.closestpoi));
  }

  aeeventname = #"champions_quest";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_ecf2f40148801ac5"), bitfield1];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_52035021c9edec95(var_b9c95d2f33c0d8b) {
  var_d405f79d63134727 = scripts\cp_mp\playerachievements::function_ec4c795c2898be52(self, var_b9c95d2f33c0d8b, "progress", 0);
  println("<dev string:x6f2>" + self.name + "<dev string:x72c>" + var_b9c95d2f33c0d8b + "<dev string:x739>" + var_d405f79d63134727);
  self.var_d405f79d63134727 = var_d405f79d63134727;
}

function function_3d871e989c0bdb6d() {
  if(!isDefined(self.var_d405f79d63134727)) {
    self.var_d405f79d63134727 = 0;
  }

  return self.var_d405f79d63134727;
}

function function_ca0ab723ebcf6d79() {
  if(!isDefined(self.var_d405f79d63134727)) {
    self.var_d405f79d63134727 = 0;
  }

  self.var_d405f79d63134727 += 1;
  awardflag = 0;
  awardflag = function_6d40f12a09494350(awardflag, ae_utility::function_e2ff8f4b4e94f723(#"hash_ecf2f40148801ac5", #"token_award"));
  function_742decc7f891bb0e(awardflag);
}

function function_8935e658d461fc50() {
  if(!isDefined(self.var_d405f79d63134727)) {
    self.var_d405f79d63134727 = 0;
  }

  if(self.var_d405f79d63134727 > 0) {
    self.var_d405f79d63134727 -= 1;
    var_bc2c612dd7d7cf33 = 0;
    var_bc2c612dd7d7cf33 = function_6d40f12a09494350(var_bc2c612dd7d7cf33, ae_utility::function_e2ff8f4b4e94f723(#"hash_ecf2f40148801ac5", #"hash_33af2318f82518f3"));
    function_742decc7f891bb0e(var_bc2c612dd7d7cf33);
  }
}

function function_711143d9696bcf8e() {
  if(!isDefined(self.var_d405f79d63134727)) {
    self.var_d405f79d63134727 = 0;
  }

  self.var_d405f79d63134727 += 1;
  var_7d11b9c775efcd2d = 0;
  var_7d11b9c775efcd2d = function_6d40f12a09494350(var_7d11b9c775efcd2d, ae_utility::function_e2ff8f4b4e94f723(#"hash_ecf2f40148801ac5", #"hash_85bf1c06ebe9374d"));
  function_742decc7f891bb0e(var_7d11b9c775efcd2d);
}

function private function_8feb2dc462cfc7f4() {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(!function_fa23fe9cc3517344()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  operatorlootid = function_aff35122a61a900b(self.team);
  [location, location2] = function_d1f7d516770b2b32();
  command = function_e2ff8f4b4e94f723(#"hash_7164db7c4d5bdb1c", #"overwrite");
  var_4befd2eb647c235a = function_5d39564f7e34587a(#"hash_4a7f024e87253788");
  aeeventname = #"game_flags";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"operator_id"), operatorlootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_92939ab8dccb3d82"), location, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_dc0d981f2d59d210"), location2, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_7164db7c4d5bdb1c"), command, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_4a7f024e87253788"), var_4befd2eb647c235a, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_4a7f054e87253ca1"), 0];
  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_5f8b4216068156b5(userflags, var_4befd2eb647c235a) {
  self.var_c770d7c80bb5d9ac = [];
  self.var_c770d7c80bb5d9ac[#"hash_1384ba8ab1971c0f"] = userflags;
  self.var_c770d7c80bb5d9ac[#"hash_4a7f024e87253788"] = var_4befd2eb647c235a;
}

function function_fa23fe9cc3517344() {
  return isDefined(self.var_c770d7c80bb5d9ac);
}

function initgameflags(var_8ca33da989ab6666) {
  userflags = scripts\cp_mp\playerachievements::function_ec4c795c2898be52(self, var_8ca33da989ab6666, "user", 0);
  var_4befd2eb647c235a = scripts\cp_mp\playerachievements::function_ec4c795c2898be52(self, var_8ca33da989ab6666, "bitfield1", 0);
  println("<dev string:x74f>" + self.name + "<dev string:x72c>" + var_8ca33da989ab6666 + "<dev string:x784>" + userflags + "<dev string:x32f>" + var_4befd2eb647c235a);
  function_5f8b4216068156b5(userflags, var_4befd2eb647c235a);
}

function function_3a54cb391f6b8cf8(var_8a6d55b19a5a2a1c) {
  switch (var_8a6d55b19a5a2a1c) {
    case #"hash_1384ba8ab1971c0f":
      return 1;
    case #"hash_4a7f024e87253788":
      return 1;
    default:
      return 0;
  }
}

function private function_5d39564f7e34587a(var_8a6d55b19a5a2a1c) {
  if(!function_fa23fe9cc3517344()) {
    return undefined;
  }

  if(!isDefined(var_8a6d55b19a5a2a1c)) {
    return undefined;
  }

  if(!isDefined(self.var_c770d7c80bb5d9ac)) {
    return undefined;
  }

  if(!isDefined(self.var_c770d7c80bb5d9ac[var_8a6d55b19a5a2a1c])) {
    return undefined;
  }

  var_e8931c453757b3a9 = self.var_c770d7c80bb5d9ac[var_8a6d55b19a5a2a1c];
  return var_e8931c453757b3a9;
}

function private function_6b23401be7d04d06(var_8a6d55b19a5a2a1c, flagbits) {
  if(!function_fa23fe9cc3517344()) {
    return;
  }

  if(!isDefined(var_8a6d55b19a5a2a1c)) {
    return;
  }

  if(!isDefined(flagbits)) {
    return;
  }

  if(!isDefined(self.var_c770d7c80bb5d9ac)) {
    return;
  }

  if(!isDefined(self.var_c770d7c80bb5d9ac[var_8a6d55b19a5a2a1c])) {
    return;
  }

  if(var_8a6d55b19a5a2a1c == #"hash_1384ba8ab1971c0f") {
    return;
  }

  self.var_c770d7c80bb5d9ac[var_8a6d55b19a5a2a1c] = flagbits;
  function_8feb2dc462cfc7f4();
}

function function_cfe6dcedf7278543(var_8a6d55b19a5a2a1c, gameflag) {
  var_b80aa2e168c7f17a = function_5d39564f7e34587a(var_8a6d55b19a5a2a1c);

  if(!isDefined(var_b80aa2e168c7f17a)) {
    return 0;
  }

  var_49f12c4b264b2ec0 = function_e2ff8f4b4e94f723(var_8a6d55b19a5a2a1c, gameflag);

  if(!isDefined(var_49f12c4b264b2ec0)) {
    return 0;
  }

  isset = (var_b80aa2e168c7f17a & 1 << var_49f12c4b264b2ec0) != 0;
  return isset;
}

function private function_6c6907d448b3ba6c(var_8a6d55b19a5a2a1c, gameflag, enabled) {
  var_b80aa2e168c7f17a = function_5d39564f7e34587a(var_8a6d55b19a5a2a1c);

  if(!isDefined(var_b80aa2e168c7f17a)) {
    return 0;
  }

  var_49f12c4b264b2ec0 = function_e2ff8f4b4e94f723(var_8a6d55b19a5a2a1c, gameflag);

  if(!isDefined(var_49f12c4b264b2ec0)) {
    return;
  }

  if(enabled) {
    var_b80aa2e168c7f17a = function_6d40f12a09494350(var_b80aa2e168c7f17a, var_49f12c4b264b2ec0);
  } else {
    var_b80aa2e168c7f17a = function_b2e5ca0ecf2215ab(var_b80aa2e168c7f17a, var_49f12c4b264b2ec0);
  }

  function_6b23401be7d04d06(var_8a6d55b19a5a2a1c, var_b80aa2e168c7f17a);
}

function function_b7793133df5fb0df(var_8a6d55b19a5a2a1c, gameflag) {
  function_6c6907d448b3ba6c(var_8a6d55b19a5a2a1c, gameflag, 1);
}

function function_5b58181f4c00ba56(var_8a6d55b19a5a2a1c, gameflag) {
  function_6c6907d448b3ba6c(var_8a6d55b19a5a2a1c, gameflag, 0);
}

function function_38e2bca264061aa0() {
  gametype = function_17c5d7feb226e256();
  function_8359cadd253f9604(self, "complete_blacksite", 1);
}

function function_45ab928fbc73f76c() {
  gametype = function_17c5d7feb226e256();
  function_8359cadd253f9604(self, "complete_stronghold", 1);
}

function onplayerteamrevive(reviver, revivee) {}

function onsuccessfulhit() {
  function_d312ec9b34f1dfa(self);
}

function onspawn() {
  thread watchplayerunderwater();
}

function watchplayerunderwater() {
  player = self;
  player notify("watchPlayerUnderwater");
  player endon("watchPlayerUnderwater");
  player endon("death_or_disconnect");
  player endon("game_ended");

  while(true) {
    if(player scripts\common\swim_common::isplayerunderwater()) {
      player childthread function_f71341a16372f41c();
    }

    player waittill("scr_change_breath_state");
  }
}

function function_f71341a16372f41c() {
  player = self;
  player endon("scr_change_breath_state");
  wait 35;
  function_8359cadd253f9604(player, "underwater_challenge_completed", 1);
}

function function_565d6af7da923110(success) {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  operatorlootid = function_aff35122a61a900b(self.team);
  aeeventname = #"hash_8f093c85d9262e5d";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"completed"), istrue(success)];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_7c5850e37b6857dc() {
  if(!challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(self);
  gametype = function_17c5d7feb226e256();
  operatorlootid = function_aff35122a61a900b(self.team);
  aeeventname = #"hash_ff0f2afd6e4375e9";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_4a14be27c7c571c4(var_5b3fe777f2d1c693) {
  if(!challengesenabledforplayer()) {
    return;
  }

  aeeventname = #"armory_trader";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  var_7493c6798abb5b8 = utility::function_f3bb4f4911a1beb2("game", "getWeaponPickupRarity", var_5b3fe777f2d1c693);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_bda2749e1ae2d4d6"), var_7493c6798abb5b8];

  function_7d97a2a745e514c4(aeeventid, params);

  reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function updatesuperweaponkills(objweapon, inflictor) {}

function updatesuperkills(superref, meansofdeath, var_b34cda8a56dd46c5) {}

function resistedstun(attacker) {}

function triggereddelayedexplosion() {}

function minedestroyed(mine, attacker, type) {}

function roundbegin() {}

function roundend(winnerstring) {}

function playerdamaged(inflictor, attacker, damage, meansofdeath, objweapon, shitloc) {
  self.var_a0595326ca4cf35d = 0;
  self.var_5c1805bb8abe637c = istrue(self isreloading());
}

function processuavassist(owner, uavtype) {}

function killstreakdamaged(killstreakname, owner, attacker, weapon, damage) {}

function iskillstreakvehicle(killstreakname) {
  switch (killstreakname) {
    case #"hash_28d0236400e33fd0":
    case #"hash_4ad475e6e15635bd":
    case #"hash_4d5aa76e8707f47b":
    case #"hash_52d9b7ed584bec3e":
      return false;
  }

  return true;
}

function processfinalkillchallenges(attacker, victim) {}

function usedkillstreak(streakname, eventtypebit) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(streakname)) {
    return;
  }

  gametype = function_17c5d7feb226e256();
  gamemode = getchallengegamemode(self);
  var_8ef23f5608447435 = 0;
  var_8ef23f5608447435 = function_6d40f12a09494350(var_8ef23f5608447435, eventtypebit);
  killstreak_lootid = loot::getlootidfromref(streakname);
  aeeventname = #"killstreak";
  function_8e81148472fb520a(self, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"loot_id"), killstreak_lootid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_83a2d67994d7e295"), var_8ef23f5608447435]);
}

function getoperators() {
  operators = [];

  if(utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
    operators[0] = self[[utility::getsharedfunc("player", "lookupCurrentOperator")]](self.team);
  } else {
    operators[0] = "";
  }

  if(utility::issharedfuncdefined("player", "lookupOtherOperator")) {
    operators[1] = self[[utility::getsharedfunc("player", "lookupOtherOperator")]](self.team);
  } else {
    operators[1] = "";
  }

  return operators;
}

function function_73317c391c8e6d10(player, amount) {
  player reportstat("damage", amount);
}

function function_cf995e658ab79867(player, points) {
  player reportstat("score", points);
}

function function_4fb61d33f02e8203(player, increment) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  playlistid = getplaylistid();
  aeeventname = #"capture";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"playlist_id"), playlistid];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_90d26b6dc5331196(player) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  playlistid = getplaylistid();
  aeeventname = #"capture_assist";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"playlist_id"), playlistid];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_183b2d4a1ccd46b3(player) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  playlistid = getplaylistid();
  aeeventname = #"in_obj";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"playlist_id"), playlistid];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_58e830149fcb9a1e(player, increment) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  playlistid = getplaylistid();
  aeeventname = #"confirmed_kill";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"playlist_id"), playlistid];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_4cb78ed013587e76(player, increment) {
  if(!player challengesenabledforplayer()) {
    return;
  }

  gamemode = getchallengegamemode(player);
  gametype = function_17c5d7feb226e256();
  playlistid = getplaylistid();
  aeeventname = #"denied_kill";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"version"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gametype"), gametype, ae_utility::function_d6f771aedba70ce7(aeeventname, #"playlist_id"), playlistid];

  function_7d97a2a745e514c4(aeeventid, params);

  player reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_8e81148472fb520a(eventplayer, aeeventname, params, var_afda85311c8ed272) {
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);

  if(!isDefined(aeeventid) || !isint(aeeventid) && !isstring(aeeventid) || !isDefined(params)) {
    iprintln("<dev string:x790>");

    return;
  }

  function_7d97a2a745e514c4(aeeventid, params);

  eventplayer reportchallengeuserserializedeventwrapper(aeeventid, params);
}

function function_fee0bee456eac877(player, aeeventname, params, victimstruct) {
  if(!isDefined(player)) {
    return;
  }

  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);

  if(!isDefined(aeeventid) || !isint(aeeventid) && !isstring(aeeventid)) {
    iprintln("<dev string:x7f5>");

    return;
  }

  if(isDefined(victimstruct) && isDefined(victimstruct.var_21a8839dd03e31cd)) {
    if(isarray(victimstruct.var_21a8839dd03e31cd)) {
      foreach(assistplayer in victimstruct.var_21a8839dd03e31cd) {
        if(assistplayer == player || !isDefined(assistplayer)) {
          continue;
        }

        assistplayer reportchallengeuserserializedeventwrapper(aeeventid, params);
        assistplayer.var_4f4d3b6fe9b3e3c9 = 1;
      }
    }
  }

  if(issharedfuncdefined("squad_utility", "getSquadMembers")) {
    squad = player[[getsharedfunc("squad_utility", "getSquadMembers")]]();
  }

  if(isDefined(squad)) {
    params[params.size] = ae_utility::function_d6f771aedba70ce7(aeeventname, #"squad_event");
    params[params.size] = 1;

    foreach(squadmember in squad) {
      if(isDefined(squadmember) && player != squadmember) {
        if(!isDefined(squadmember.var_4f4d3b6fe9b3e3c9)) {
          squadmember.var_4f4d3b6fe9b3e3c9 = 0;
        }

        if(!istrue(squadmember.var_4f4d3b6fe9b3e3c9)) {
          squadmember reportchallengeuserserializedeventwrapper(aeeventid, params);
        }

        squadmember.var_4f4d3b6fe9b3e3c9 = 0;
      }
    }
  }
}

function function_c1945f26d99b0ed9(player) {
  var_a8af9a2935dd804f = [];

  if(isagent(player) || !istrue(level.onlinegame)) {
    for(index = 0; index < 5; index++) {
      var_a8af9a2935dd804f[index] = 0;
    }

    return var_a8af9a2935dd804f;
  }

  squadmates = player getfireteammembers();

  for(index = 0; index < 5; index++) {
    if(isDefined(var_a8af9a2935dd804f) && isDefined(squadmates[index]) && squadmates[index] function_7a32b0201993d7f7() != "") {
      var_a8af9a2935dd804f[index] = squadmates[index] function_7a32b0201993d7f7();
      continue;
    }

    var_a8af9a2935dd804f[index] = 0;
  }

  return var_a8af9a2935dd804f;
}

function reportchallengeuserserializedeventwrapper(eventid, params) {
  if(isDefined(level.challengesallowed) && level.challengesallowed && isDefined(eventid)) {
    self function_db073176839d77fb(eventid, params);
  }
}