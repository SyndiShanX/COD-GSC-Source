/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1d4b01c1ec829364.gsc
*************************************************/

#using script_2f4866552f0ba818;
#using script_64acb6ce534155b7;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hostmigration;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnselection;
#using scripts\mp\utility\teams;
#namespace namespace_1a51bfb381ca99d3;

function function_aa0d1f90dcc5d366() {
  level.br_armory_kiosk = spawnStruct();
  level.br_armory_kiosk.scriptables = [];
}

function function_d23c7c1add9fb181() {
  closestobj = undefined;
  closestdist = undefined;

  foreach(objective in level.objectives) {
    dist = distancesquared(self.origin, objective.curorigin);

    if(!isDefined(closestobj) || dist < closestdist) {
      closestobj = objective;
      closestdist = dist;
    }
  }

  return closestobj;
}

function function_1629419647b0f862() {
  level.var_1e17e3480b1d264d = 1;
  level.armoronweaponswitchlongpress = 1;
  level.var_44334833e57b459b = 1;
  scripts\mp\gametypes\br_armory_kiosk::init();
  level.var_6beff7b631ab7e18 = &function_6beff7b631ab7e18;
  level.var_3c8e175d92be01ea = &function_8529632b1fdb55a6;
  level.modifyvehicledamage = &modifyvehicledamage;
  level.var_468b95f3865fa8d3 = &function_468b95f3865fa8d3;
  level.var_95344ec32aa27f24 = getdvarfloat(@ "hash_fd13071a3ec6f158", 0.85);
  level.var_953451c32aa285bd = getdvarfloat(@ "hash_fd130a1a3ec6f7f1", 0.7);
  level.var_38931344c1be4d04 = getdvarint(@ "hash_8062b21f870de073", 12);
  upgrades = [];
  upgrade = spawnStruct();
  upgrade.ref = "research_upgrade_uav";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 1;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  upgrades[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "research_upgrade_vehicle";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 1;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  upgrades[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "research_upgrade_defense";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 1;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  upgrades[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "uav_ping";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 1;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  upgrades[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "uav_ping_radius";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 1;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  upgrades[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "uav_ping_duration";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 1;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  upgrades[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "uav_ping_global";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 1;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  upgrades[upgrade.ref] = upgrade;
  var_4df9c45025851e63 = [];
  upgrade = spawnStruct();
  upgrade.ref = "defense_spawn_armor_tier_1";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 0;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  var_4df9c45025851e63[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "defense_spawn_armor_tier_2";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 0;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  var_4df9c45025851e63[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "defense_spawn_plate_tier_1";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 0;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  var_4df9c45025851e63[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "defense_spawn_plate_tier_2";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 0;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  var_4df9c45025851e63[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "vehicle_defense_tier_1";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 0;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  var_4df9c45025851e63[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "vehicle_defense_tier_2";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 0;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  var_4df9c45025851e63[upgrade.ref] = upgrade;
  upgrade = spawnStruct();
  upgrade.ref = "vehicle_apc_improved_ammo";
  upgrade.purchased = 0;
  upgrade.var_98eafcae335d563a = 0;
  upgrade.persistentpurchase = 1;
  upgrade.purchasecount = 0;
  upgrade.var_492dba79acaac7e0 = 10;
  var_4df9c45025851e63[upgrade.ref] = upgrade;
  level.var_73e72117ada9cce6 = getdvarfloat(@ "hash_a19bc7851e3c41b6", level.flagcapturetime * 2);
  level.buystations = [];
  level.var_f2afbe97539d175d = [];

  foreach(team in level.teamnamelist) {
    level.var_f2afbe97539d175d[team] = [];
  }

  tracecontents = scripts\engine\trace::create_default_contents(1);

  while(level.objectives.size == 0) {
    waitframe();
  }

  var_198c1217542d88cd = [];
  radiantstations = getStructArray("buystation_loc", "targetname");

  foreach(ent in radiantstations) {
    var_198c1217542d88cd[ent.script_label] = ent;
  }

  foreach(key, objective in level.objectives) {
    groundorigin = (0, 0, 0);
    spawnangles = (0, 0, 0);

    if(isDefined(var_198c1217542d88cd[key])) {
      groundorigin = var_198c1217542d88cd[key].origin;
      spawnangles = var_198c1217542d88cd[key].angles;
    } else {
      groundorigin = drop_to_ground(objective.curorigin + anglesToForward(objective.trigger.angles) * 50, 50, -200, undefined, tracecontents);
      spawnangles = objective.trigger.angles;
    }

    buystation = spawnscriptable("br_plunder_box", groundorigin, spawnangles);
    buystation.objectivekey = key;
    level.buystations[key] = buystation;
    buystation setscriptablepartstate("br_plunder_box", "visible");
    buystation.var_5cfa621ebf61d8aa = 0;
    upgradestatus = spawnStruct();
    upgradestatus.tier = 0;
    upgradestatus.upgrades = upgrades;

    foreach(team in level.teamnamelist) {
      level.var_f2afbe97539d175d[team][key] = upgradestatus;
    }
  }

  upgradestatus = spawnStruct();
  upgradestatus.upgrades = var_4df9c45025851e63;

  foreach(team in level.teamnamelist) {
    level.var_f2afbe97539d175d[team]["global"] = upgradestatus;
  }

  level thread function_c800466f69dfc582();
}

function function_6beff7b631ab7e18(instance, player) {
  if(istrue(instance.var_5cfa621ebf61d8aa) || istrue(level.var_8e9daba162280a8e)) {
    player setclientomnvar("ui_buystation_override", scripts\cp_mp\utility\loot::function_54b046aa3ba2678a("personalOnly"));
  }

  var_f4802cadf5f79275 = getDvar(hashcat(@ "hash_de61cd75a31ab28", instance.objectivekey), "");

  if(var_f4802cadf5f79275 != "") {
    var_47df3a792140c443 = scripts\cp_mp\utility\loot::function_54b046aa3ba2678a(var_f4802cadf5f79275 + "_tier_" + level.var_f2afbe97539d175d[player.team][instance.objectivekey].tier);

    if(!isDefined(var_47df3a792140c443)) {
      var_47df3a792140c443 = scripts\cp_mp\utility\loot::function_54b046aa3ba2678a(var_f4802cadf5f79275);
    }

    if(isDefined(var_47df3a792140c443)) {
      player setclientomnvar("ui_buystation_override", var_47df3a792140c443);
    }
  }

  player function_e29957adfbe3c040(instance.objectivekey);
}

function function_e29957adfbe3c040(objectivekey) {
  omnvarvalue = 0;

  if(istrue(level.var_f2afbe97539d175d[self.team][objectivekey].upgrades["uav_ping"].purchased)) {
    omnvarvalue += 1;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team][objectivekey].upgrades["uav_ping_radius"].purchased)) {
    omnvarvalue += 2;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team][objectivekey].upgrades["uav_ping_duration"].purchased)) {
    omnvarvalue += 4;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team][objectivekey].upgrades["uav_ping_global"].purchased)) {
    omnvarvalue += 8;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team]["global"].upgrades["defense_spawn_armor_tier_1"].purchased)) {
    omnvarvalue += 16;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team]["global"].upgrades["defense_spawn_armor_tier_2"].purchased)) {
    omnvarvalue += 32;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team]["global"].upgrades["defense_spawn_plate_tier_1"].purchased)) {
    omnvarvalue += 64;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team]["global"].upgrades["defense_spawn_plate_tier_2"].purchased)) {
    omnvarvalue += 128;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team]["global"].upgrades["vehicle_defense_tier_1"].purchased)) {
    omnvarvalue += 256;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team]["global"].upgrades["vehicle_defense_tier_2"].purchased)) {
    omnvarvalue += 512;
  }

  if(istrue(level.var_f2afbe97539d175d[self.team]["global"].upgrades["vehicle_apc_improved_ammo"].purchased)) {
    omnvarvalue += 1024;
  }

  self setclientomnvar("ui_upgrade_status", omnvarvalue);
}

function function_c800466f69dfc582() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(istrue(level.var_7f5be0207e7457b1)) {
    return;
  }

  foreach(key, buystation in level.buystations) {
    foreach(team in level.teamnamelist) {
      buystation function_8d03978a31faba3a(key, team);
    }
  }
}

function function_6ed651811c936a22() {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  if(istrue(level.var_7f5be0207e7457b1)) {
    return;
  }

  foreach(key, buystation in level.buystations) {
    ownerteam = level.objectives[key] scripts\mp\gameobjects::getownerteam();

    if(self.team == ownerteam) {
      buystation enablescriptableplayeruse(self);
      continue;
    }

    buystation disablescriptableplayeruse(self);
  }
}

function function_e8a6e840ef663c81(key, team) {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  if(istrue(level.var_7f5be0207e7457b1)) {
    return;
  }

  if(!isDefined(team) || !isgameplayteam(team)) {
    return;
  }

  foreach(player in level.players) {
    if(player.team == team) {
      level.buystations[key] enablescriptableplayeruse(player);
      continue;
    }

    level.buystations[key] disablescriptableplayeruse(player);
  }
}

function function_8d03978a31faba3a(key, team) {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  if(!isDefined(team) || !isgameplayteam(team)) {
    return;
  }

  players = getteamdata(team, "players");

  foreach(player in players) {
    level.buystations[key] disablescriptableplayeruse(player);
  }
}

function function_4de8052758f986f3(objectivekey, team, ref) {
  if(!istrue(level.var_44334833e57b459b)) {
    return 0;
  }

  if(array_contains_key(level.var_f2afbe97539d175d[team]["global"].upgrades, ref)) {
    upgradedata = level.var_f2afbe97539d175d[team]["global"].upgrades[ref];
  } else {
    upgradedata = level.var_f2afbe97539d175d[team][objectivekey].upgrades[ref];
  }

  return upgradedata.purchased;
}

function function_3ce1055115edcbbb(player, ref) {
  if(!istrue(level.var_44334833e57b459b)) {
    return false;
  }

  objective = player function_d23c7c1add9fb181();

  if(objective.ownerteam != player.team) {
    return false;
  }

  applypurchase(objective.objectivekey, player.team, ref);
  return true;
}

function applypurchase(objectivekey, team, ref) {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  if(array_contains_key(level.var_f2afbe97539d175d[team]["global"].upgrades, ref)) {
    objectivekey = "global";
  }

  upgradedata = level.var_f2afbe97539d175d[team][objectivekey].upgrades[ref];

  if(isDefined(upgradedata) && upgradedata.purchased == 0) {
    upgradedata.purchasecount++;
    self iprintlnbold("Upgrade contribution " + upgradedata.purchasecount + "/" + upgradedata.var_492dba79acaac7e0);

    if(upgradedata.purchasecount == upgradedata.var_492dba79acaac7e0) {
      upgradedata.purchased = 1;

      switch (ref) {
        case #"hash_9789620b82d8908c":
        case #"hash_f0fd4758cf2900f0":
        case #"hash_f4fe496941705c28":
          upgradedata.purchased = 0;
          upgradedata.purchasecount = 0;
          level.var_f2afbe97539d175d[team][objectivekey].tier++;
          break;
      }
    } else {
      return;
    }
  }

  switch (ref) {
    case #"hash_e4154ddbab061c63":
      level.objectives[objectivekey] scripts\mp\gameobjects::setusetime(level.var_73e72117ada9cce6);
      objective_setstate(level.objectives[objectivekey].objidnum, 1);
      break;
    case #"hash_bb639a6ed9e9b88a":
      function_805aa14814fe1ff2(objectivekey, team);
      break;
    case #"hash_6235851dae0eeca8":
      level.objectives[objectivekey] thread function_c929fb023d29de5e(team);
      break;
    case #"hash_fd8da3bdddb8e1c2":
      namespace_317764fb96da42b0::function_e7ad80f4a663b94b(objectivekey, 5, team);
      break;
    case #"hash_dda8890cb35ca0bf":
      groupname = function_78759441c259f58a();
      agent = ai_mp_requestspawnagent("enemy_mp_jugg_base", level.objectives[objectivekey].trigger.origin, (0, 0, 0), "absolute", "everybody", "jugg", groupname, team);
      scripts\cp_mp\agents\agent_utils::function_1828f1e20e52b418(agent);
      agent thread function_b11c1964f528574b(agent);
      break;
    case #"hash_6c0c806bbf705a0c":
      break;
    case #"hash_9789620b82d8908c":
    case #"hash_f0fd4758cf2900f0":
    case #"hash_f4fe496941705c28":
      level.buystations[objectivekey] thread function_ada6203de7e0ad2f();
      break;
  }
}

function function_ada6203de7e0ad2f() {
  self setscriptablepartstate("br_plunder_box", "disabled");
  wait 1;
  self setscriptablepartstate("br_plunder_box", "opening");
  scripts\mp\gametypes\br_armory_kiosk::kioskfixupproneplayers();
}

function function_6e2299d954003d6c(team, objectivekey) {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  foreach(ref, upgrade in level.var_f2afbe97539d175d[team][objectivekey].upgrades) {
    if(upgrade.purchased && upgrade.persistentpurchase) {
      applypurchase(team, objectivekey, ref);
    }
  }
}

function function_666a2979def5d705(team, objectivekey) {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  foreach(ref, upgrade in level.var_f2afbe97539d175d[team][objectivekey].upgrades) {
    removeupgrade(team, objectivekey, ref);
  }
}

function removeupgrade(team, objectivekey, ref) {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  upgrade = level.var_f2afbe97539d175d[team][objectivekey].upgrades[ref];

  if(!upgrade.var_98eafcae335d563a || upgrade.persistentpurchase) {
    return;
  }

  level.var_f2afbe97539d175d[team][objectivekey].upgrades[ref] = 0;

  switch (ref) {
    case #"hash_e4154ddbab061c63":
      level.objectives[objectivekey] scripts\mp\gameobjects::setusetime(level.flagcapturetime);
      objective_setstate(level.objectives[objectivekey].objidnum, 0);
      break;
    case #"hash_bb639a6ed9e9b88a":
      foreach(team in level.teamnamelist) {
        function_87215631aacdabe9(objectivekey, team);
      }

      break;
    case #"hash_6235851dae0eeca8":
      level.objectives[objectivekey] thread disableuavping();
      break;
    case #"hash_6c0c806bbf705a0c":
    case #"hash_dda8890cb35ca0bf":
    case #"hash_fd8da3bdddb8e1c2":
      break;
  }
}

function function_805aa14814fe1ff2(key, team) {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  if(!isDefined(team) || !isgameplayteam(team)) {
    return;
  }

  level.var_f08df4288eee30f5[key] show();
  players = getteamdata(team, "players");

  foreach(player in players) {
    level.var_f08df4288eee30f5[key] enablescriptableplayeruse(player);
  }
}

function function_87215631aacdabe9(key, team) {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  if(!isDefined(team) || !isgameplayteam(team)) {
    return;
  }

  level.var_f08df4288eee30f5[key] hide();
  players = getteamdata(team, "players");

  foreach(player in players) {
    level.var_f08df4288eee30f5[key] disablescriptableplayeruse(player);
  }
}

function function_c929fb023d29de5e(team) {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  if(!isDefined(team) || !isgameplayteam(team)) {
    return;
  }

  self endon("disableUAVPing");

  while(true) {
    radius = ter_op(istrue(level.var_f2afbe97539d175d[team][self.objectivekey].upgrades["uav_ping_radius"].purchased), getdvarint(@ "hash_6bbb6d984ba826b4", 3000), getdvarint(@ "hash_bbf08a38c88577", 1000));
    duration = ter_op(istrue(level.var_f2afbe97539d175d[team][self.objectivekey].upgrades["uav_ping_duration"].purchased), getdvarfloat(@ "hash_d3e12b5a75c3aada", 2), getdvarfloat(@ "hash_e34e9ea29b7cc0a9", 4));

    if(istrue(level.var_f2afbe97539d175d[team][self.objectivekey].upgrades["uav_ping_global"].purchased)) {
      foreach(objective in level.objectives) {
        if(objective.ownerteam == team) {
          triggerportableradarpingteam(objective.curorigin, team, radius, int(duration * 1000));
        }
      }
    } else {
      triggerportableradarpingteam(self.curorigin, team, radius, int(duration * 1000));
    }

    wait duration;
  }
}

function disableuavping() {
  if(!istrue(level.var_44334833e57b459b)) {
    return;
  }

  self notify("disableUAVPing");
}

function function_efbc646224fda4fa() {
  level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(self.origin, "revive");
  spawnheight = getdvarfloat(@ "hash_3db53fbbad853ffc", 8000);
  spawnorigin = self.origin;
  spawnorigin += (0, 0, spawnheight);
  var_ad4dd16f29e24b77 = 0;
  var_dfab0807d83a77fe = 0.5;
  thread scripts\mp\playerlogic::managerespawnfade(var_ad4dd16f29e24b77, var_dfab0807d83a77fe);

  if(var_ad4dd16f29e24b77 > 0) {
    self waittill("fadeDown_complete");
  }

  facingorigin = (level.mapcorners[0].origin + level.mapcorners[1].origin) * 0.5;
  toselection = facingorigin - spawnorigin;
  spawnangles = vectortoangles(vectorNormalize(toselection));
  self setOrigin(spawnorigin);
  self setplayerangles(spawnangles);

  if(level.parachutecancutautodeploy) {
    self skydive_cutautodeployon();
  } else {
    self skydive_cutautodeployoff();
  }

  if(level.parachutecancutparachute) {
    self skydive_cutparachuteon();
  } else {
    self skydive_cutparachuteoff();
  }

  thread scripts\cp_mp\parachute::startfreefall(level.parachutedeploydelay, 0, undefined, undefined, 1);
}

function function_5a1699b27399a21e() {
  level endon("game_ended");
  teamscore = undefined;
  otherteamscore = undefined;
  level waittill("prematch_done");
  level thread scripts\mp\spawnselection::updatefobindanger();

  while(!level.gameended) {
    wait getdvarint(@ "hash_ac8e27080e51148b", 20);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    domflags = getowneddomflags();

    if(!isDefined(level.cashtick)) {
      level.cashtick = [];
    }

    foreach(entry in level.teamnamelist) {
      level.cashtick[entry] = 0;
    }

    if(domflags.size) {
      for(i = 1; i < domflags.size; i++) {
        domflag = domflags[i];
        flagscore = gettime() - domflag.capturetime;

        for(j = i - 1; j >= 0 && flagscore > gettime() - domflags[j].capturetime; j--) {
          domflags[j + 1] = domflags[j];
        }

        domflags[j + 1] = domflag;
      }

      foreach(domflag in domflags) {
        team = domflag scripts\mp\gameobjects::getownerteam();
        assert(scripts\mp\utility\teams::isgameplayteam(team));
        var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount(team);

        if(var_fee716687dd29378 >= level.flagsrequiredtoscore) {
          level.cashtick[team] += level.var_1f42dab41eff5cb2;
        }
      }
    }

    updatecash();
  }
}

function updatecash() {
  foreach(entry in level.teamnamelist) {
    if(level.cashtick[entry] > 0) {
      foreach(player in scripts\mp\utility\teams::getteamdata(entry, "players")) {
        player[[level.var_9c1e3c18b99409e9]](level.cashtick[entry]);
      }
    }
  }
}

function getowneddomflags() {
  domflags = [];

  foreach(domflag in level.objectives) {
    if(domflag scripts\mp\gameobjects::getownerteam() != "neutral" && isDefined(domflag.capturetime)) {
      domflags[domflags.size] = domflag;
    }
  }

  return domflags;
}

function function_8529632b1fdb55a6(player) {
  armorvalue = undefined;
  var_10fd8ed3fed0e0ae = undefined;

  if(istrue(level.var_f2afbe97539d175d[player.team]["global"].upgrades["defense_spawn_armor_tier_2"].purchased)) {
    armorvalue = player.maxarmorhealth;
  } else if(istrue(level.var_f2afbe97539d175d[player.team]["global"].upgrades["defense_spawn_armor_tier_1"].purchased)) {
    armorvalue = level.spawnarmor + level.var_4b78859bacc88808;
  }

  if(istrue(level.var_f2afbe97539d175d[player.team]["global"].upgrades["defense_spawn_plate_tier_2"].purchased)) {
    var_10fd8ed3fed0e0ae = scripts\cp_mp\armor::function_47320a25b8ee003();
  } else if(istrue(level.var_f2afbe97539d175d[player.team]["global"].upgrades["defense_spawn_plate_tier_1"].purchased)) {
    var_10fd8ed3fed0e0ae = level.spawnarmorplates + 1;
  }

  return [armorvalue, var_10fd8ed3fed0e0ae];
}

function modifyvehicledamage(data) {
  switch (data.victim.vehiclename) {
    case #"hash_41afa3eacdeba917":
    case #"hash_7c54070d9b704f70":
      if(istrue(level.var_f2afbe97539d175d[data.victim.team]["global"].upgrades["vehicle_defense_tier_2"].purchased)) {
        data.damage = int(data.damage * level.var_953451c32aa285bd);
      } else if(istrue(level.var_f2afbe97539d175d[data.victim.team]["global"].upgrades["vehicle_defense_tier_1"].purchased)) {
        data.damage = int(data.damage * level.var_95344ec32aa27f24);
      }

      break;
  }

  return data.damage;
}

function function_468b95f3865fa8d3(vehicle) {
  if(istrue(level.var_f2afbe97539d175d[vehicle.team]["global"].upgrades["vehicle_apc_improved_ammo"].purchased)) {
    return level.var_38931344c1be4d04;
  }

  return undefined;
}