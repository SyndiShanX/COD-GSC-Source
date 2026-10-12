/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_lootchopper.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_lootchopper;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#namespace br_lootchopper;

function init() {
  level.averagealliesz = 0;
  level.loot_choppers = [];

  if(scripts\mp\utility\game::getsubgametype() != "plunder") {
    registersharedfunc("br_lootchopper", "lootChopper_onCrateUse", &lootchopper_oncrateuse);
  }

  level.quadgridcenterpoints = [];
  level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (-21299.2, 41779.2, 0);
  level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (37683.2, 41779.2, 0);
  level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (37683.2, -17203.2, 0);
  level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (-21299.2, -17203.2, 0);
  level thread registerleveldataforvehicle();

  setdevdvarifuninitialized(@ "hash_6e1432e14f4ba139", 0);
  setdevdvarifuninitialized(@ "hash_1853d73ee1c86fd4", 0);
  setdevdvarifuninitialized(@ "hash_d043ee66392f7b83", 6);
  setdevdvarifuninitialized(@ "hash_117db97fcbbffbb8", 4500);
  setdevdvarifuninitialized(@ "hash_6ab65ba1a8931841", 9999);
  setdevdvarifuninitialized(@ "hash_5db4b9205b63bbd3", 0);
  setdevdvarifuninitialized(@ "hash_880c7f3811901ea1", 1500);
  setdevdvarifuninitialized(@ "hash_ad78da1d72e62dd3", 4000);
  setdevdvarifuninitialized(@ "hash_38568daa586b1fe3", 6000);
  setdevdvarifuninitialized(@ "hash_31c380c6ba1eab38", 360);
  setdevdvarifuninitialized(@ "hash_31e696c6ba452352", 480);
  setdevdvarifuninitialized(@ "hash_c027db5b75ded4aa", 100000);
  setdevdvarifuninitialized(@ "hash_7daf22bb16ed19fe", 50000);
  setdevdvarifuninitialized(@ "hash_6b87854981a58552", 3);
}

function registerleveldataforvehicle() {
  while(!isDefined(level.vehicle)) {
    waitframe();
  }

  leveldataforvehicle = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("loot_chopper", 1);
  leveldataforvehicle.canfly = 1;
}

function lootchopper_initspawninfo(circleinfo) {
  var_a43491919a0d6a88 = lootchopper_getspawnlocations(circleinfo);
  level.loot_chopper_spawns = [];
  level.loot_chopper_spawns["quad_1"] = [];
  level.loot_chopper_spawns["quad_2"] = [];
  level.loot_chopper_spawns["quad_3"] = [];
  level.loot_chopper_spawns["quad_4"] = [];

  if(!isDefined(var_a43491919a0d6a88)) {
    return;
  }

  foreach(spawnzone in var_a43491919a0d6a88) {
    closestdist = undefined;
    closestquad = undefined;
    var_64602cfeef6c46da = undefined;

    if(circleinfo.isvalid) {
      foreach(quadindex, quad in circleinfo.quadpoints) {
        var_8d6061447ac0bf39 = distance2dsquared(spawnzone.origin, quad);

        if(!isDefined(closestdist) || var_8d6061447ac0bf39 < closestdist) {
          closestdist = var_8d6061447ac0bf39;
          closestquad = quad;
          var_64602cfeef6c46da = "quad_" + quadindex + 1;
        }
      }
    } else {
      foreach(quadindex, quad in level.quadgridcenterpoints) {
        var_8d6061447ac0bf39 = distance2dsquared(spawnzone.origin, quad);

        if(!isDefined(closestdist) || var_8d6061447ac0bf39 < closestdist) {
          closestdist = var_8d6061447ac0bf39;
          closestquad = quad;
          var_64602cfeef6c46da = "quad_" + quadindex + 1;
        }
      }
    }

    spawnzone.origin *= (1, 1, 0);
    spawnzone.origin = scripts\mp\gametypes\br::getoffsetspawnoriginmultitrace(spawnzone.origin, (0, 0, 10000));
    level.loot_chopper_spawns[var_64602cfeef6c46da][level.loot_chopper_spawns[var_64602cfeef6c46da].size] = spawnzone;
  }
}

function lootchopper_getspawnlocations(circleinfo) {
  var_1b5b62b6222f38c0 = [];

  foreach(location in level.br_prematchspawnlocations) {
    if(circleinfo.isvalid) {
      if(distance2dsquared(location.origin, circleinfo.center) > circleinfo.radius * circleinfo.radius) {
        continue;
      }
    }

    newlocation = spawnStruct();
    newlocation.origin = location.origin;
    var_1b5b62b6222f38c0[var_1b5b62b6222f38c0.size] = newlocation;
  }

  return var_1b5b62b6222f38c0;
}

function lootchopper_initcircleinfo(circlecenter, circleradius) {
  circleinfo = spawnStruct();
  circleinfo.isvalid = isDefined(circlecenter) && isDefined(circleradius);

  if(circleinfo.isvalid) {
    circleinfo.center = circlecenter;
    circleinfo.radius = circleradius;
    var_28752bf2ea017628 = 45;
    cosangle = cos(var_28752bf2ea017628);
    var_50972e48b8d175a4 = sin(var_28752bf2ea017628);
    circleinfo.quadpoints[0] = circlecenter + (-1 * cosangle, var_50972e48b8d175a4, 0) * circleradius * 0.5;
    circleinfo.quadpoints[1] = circlecenter + (cosangle, var_50972e48b8d175a4, 0) * circleradius * 0.5;
    circleinfo.quadpoints[2] = circlecenter + (cosangle, -1 * var_50972e48b8d175a4, 0) * circleradius * 0.5;
    circleinfo.quadpoints[3] = circlecenter + (-1 * cosangle, -1 * var_50972e48b8d175a4, 0) * circleradius * 0.5;
  }

  return circleinfo;
}

function lootchopper_managespawns() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  circlecenter = undefined;
  circleradius = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    circlecenter = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    circleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  }

  circleinfo = scripts\mp\gametypes\br_lootchopper::lootchopper_initcircleinfo(circlecenter, circleradius);
  lootchopper_initspawninfo(circleinfo);

  level thread function_fb7c809b0f8f7639();

  level waittill("br_prematchEnded");
  var_e1ce21e5b4d1163f = getdvarint(@ "hash_d043ee66392f7b83", 6);
  var_477413d8c0675495 = getdvarint(@ "hash_38568daa586b1fe3", 6000);
  mincooldowntime = getdvarint(@ "hash_31c380c6ba1eab38", 360);
  maxcooldowntime = getdvarint(@ "hash_31e696c6ba452352", 480);

  if(level.mapname == "mp_br_mechanics") {
    var_477413d8c0675495 = 1000;
  }

  while(true) {
    var_992edc40264e2f58 = getdvarint(@ "hash_1853d73ee1c86fd4", 0);

    if(!var_992edc40264e2f58) {
      waitframe();
      continue;
    }

    spawninterval = randomintrange(mincooldowntime, maxcooldowntime);

    if(istrue(level.usemilestonephases)) {
      scripts\mp\flags::gameflagwait("activate_cash_helis");
    } else {
      wait spawninterval;
    }

    if(level.loot_choppers.size < var_e1ce21e5b4d1163f) {
      var_6eebc4632b89c8c8 = var_e1ce21e5b4d1163f - level.loot_choppers.size;

      for(i = 0; i < var_6eebc4632b89c8c8; i++) {
        quadid = i + 1;

        if(quadid > 4) {
          quadid = 1;
        }

        patrolzone = lootchopper_findunoccupiedpatrolzone(level.loot_chopper_spawns["quad_" + quadid], var_477413d8c0675495);

        if(!isDefined(patrolzone)) {
          iprintlnbold("<dev string:x1c>" + quadid + "<dev string:x64>");

          wait 1;
        }

        if(i == 0) {
          showsplashtoall("br_lootchopper_incoming");
        }

        lootchopper_spawn(patrolzone);

        if(istrue(level.usemilestonephases)) {
          wait randomintrange(1, 2);
        }
      }

      if(istrue(level.usemilestonephases)) {
        return;
      }

      continue;
    }

    while(level.loot_choppers.size >= var_e1ce21e5b4d1163f) {
      waitframe();
    }
  }
}

function function_fb7c809b0f8f7639() {
  level endon("<dev string:xaf>");
  quadid = 0;

  while(true) {
    testspawn = getdvarint(@ "hash_6e1432e14f4ba139", 0);

    if(!testspawn) {
      waitframe();
      continue;
    }

    var_477413d8c0675495 = getdvarint(@ "hash_38568daa586b1fe3", 6000);

    if(level.mapname == "<dev string:xbd>") {
      var_477413d8c0675495 = 1000;
    }

    quadid++;

    if(quadid > 4) {
      quadid = 1;
    }

    patrolzone = lootchopper_findunoccupiedpatrolzone(level.loot_chopper_spawns["<dev string:xd0>" + quadid], var_477413d8c0675495);

    if(!isDefined(patrolzone)) {
      iprintlnbold("<dev string:x1c>" + quadid + "<dev string:x64>");
      wait 1;
    }

    showsplashtoall("<dev string:xd9>");
    lootchopper_spawn(patrolzone);
    setDvar(@ "hash_6e1432e14f4ba139", 0);
    waitframe();
  }
}

function lootchopper_findunoccupiedpatrolzone(availablespawns, var_6d423f3f70906691) {
  patrolzone = undefined;

  if(availablespawns.size > 0) {
    validspawns = [];

    foreach(potentialspawn in availablespawns) {
      if(istrue(potentialspawn.chopperoccupied)) {
        continue;
      }

      if(lootchopper_isnearbyoccupiedspawns(potentialspawn, var_6d423f3f70906691)) {
        continue;
      }

      validspawns[validspawns.size] = potentialspawn;
    }

    if(validspawns.size > 0) {
      patrolzone = validspawns[randomint(validspawns.size)];
    }

    if(isDefined(patrolzone)) {
      patrolzone.chopperoccupied = 1;
    }
  }

  return patrolzone;
}

function lootchopper_isnearbyoccupiedspawns(potentialspawn, var_6d423f3f70906691) {
  var_7128b7aee8de7665 = 0;
  allspawns = level.loot_chopper_spawns;
  mindistsq = var_6d423f3f70906691 * var_6d423f3f70906691;

  if(isDefined(allspawns)) {
    foreach(quadrantspawns in allspawns) {
      foreach(var_c629cfb5aee5be94 in quadrantspawns) {
        if(istrue(var_c629cfb5aee5be94.chopperoccupied)) {
          if(distance2dsquared(potentialspawn.origin, var_c629cfb5aee5be94.origin) < mindistsq) {
            var_7128b7aee8de7665 = 1;
            break;
          }
        }
      }

      if(istrue(var_7128b7aee8de7665)) {
        break;
      }
    }
  }

  return var_7128b7aee8de7665;
}

function lootchopper_getzonebyindex(index) {
  zonebyindex = undefined;
  zonecount = 0;

  foreach(zone in level.loot_chopper_spawns) {
    if(zonecount == index) {
      zonebyindex = zone;
      break;
    }

    zonecount++;
  }

  return zonebyindex;
}

function lootchopper_spawn(patrolzone, overridevehicletype, overridemodel, overrideweapon) {
  patrollocation = undefined;
  patrolradius = getdvarint(@ "hash_ad78da1d72e62dd3", 4000);

  if(isDefined(patrolzone)) {
    patrollocation = patrolzone.origin;
  } else {
    playersalive = [];

    foreach(player in level.players) {
      if(isreallyalive(player)) {
        playersalive[playersalive.size] = player;
      }
    }

    if(playersalive.size > 0) {
      randomindex = randomint(playersalive.size);
      patrollocation = playersalive[randomindex].origin;
    }

    if(isDefined(patrollocation)) {
      patrollocation = scripts\mp\gametypes\br::getoffsetspawnoriginmultitrace(patrollocation, (0, 0, 10000));
    }
  }

  if(!isDefined(patrollocation)) {
    iprintlnbold("<dev string:xf4>");

    return;
  }

  startingposition = scripts\cp_mp\killstreaks\chopper_support::getpathstart(patrollocation);
  startingangles = vectortoangles(patrollocation - startingposition);

  if(getdvarint(@ "hash_f3aec952abe1e494", 1)) {
    var_e0be8bb269d1b3ee = scripts\mp\gametypes\br_public::function_cc755ff7170d3dd0();
    var_18459465a6813445 = var_e0be8bb269d1b3ee + 10000;

    if(startingposition[2] < var_18459465a6813445) {
      startingposition = (startingposition[0], startingposition[1], var_18459465a6813445);
    }
  }

  spawnvehicletype = ter_op(isDefined(overridevehicletype), overridevehicletype, "veh_chopper_support_dmz_mp");
  choppermodel = "veh8_mil_air_palfa_east";

  if(istrue(level.var_a83a4e71446bfef7)) {
    choppermodel = "veh9_mil_air_heli_hind";
  }

  if(isDefined(overridemodel)) {
    choppermodel = overridemodel;
  }

  chopper = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], startingposition, startingangles, spawnvehicletype, choppermodel);

  if(!isDefined(chopper)) {
    logstring("br_lootchopper::lootChopper_spawn - chopper failed to spawn!");
    return;
  }

  chopper.speed = 100;
  chopper.accel = 50;
  chopper.lifetime = getdvarint(@ "hash_6ab65ba1a8931841", 9999);
  chopper.team = "neutral";
  chopper.angles = startingangles;
  chopper.flaresreservecount = getdvarint(@ "hash_5db4b9205b63bbd3", 0);
  chopper.pathstart = startingposition;
  chopper.pathgoal = patrollocation;
  chopper.currentaction = "patrol";
  chopper.currenttarget = undefined;
  chopper.heightoffset = (0, 0, getdvarint(@ "hash_880c7f3811901ea1", 1500));
  chopper.patrolzone = patrolzone;
  chopper.patrollocation = patrollocation;
  chopper.patrolradius = patrolradius;
  chopper.stage3accradius = 35;
  chopper.crashoffset = chopper.heightoffset[2] - 250;
  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(chopper.speed, chopper.accel);
  chopper sethoverparams(50, 5, 2.5);
  chopper setturningability(0.5);
  chopper setyawspeed(100, 25, 25, 0.1);
  chopper setCanDamage(1);
  chopper setneargoalnotifydist(768);
  chopper setvehicleteam(chopper.team);
  chopper.health = getdvarint(@ "hash_117db97fcbbffbb8", 4500);
  chopper.maxhealth = getdvarint(@ "hash_117db97fcbbffbb8", 4500);
  chopper.currenthealth = getdvarint(@ "hash_117db97fcbbffbb8", 4500);
  chopper scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", chopper.team);
  chopper lootchopper_setupdamagefunctionality();
  chopper setscriptablepartstate("blinking_lights", "on", 0);
  chopper setscriptablepartstate("engine", "on", 0);
  turretmodel = "veh9_mil_air_heli_ahotel64_turret";
  linktag = "tag_turret_front";

  if(istrue(level.var_a83a4e71446bfef7)) {
    turretmodel = "veh9_mil_air_heli_hind_turret";
    linktag = "tag_turret";
  }

  weaponname = "chopper_support_turret_br";

  if(isDefined(overrideweapon)) {
    weaponname = overrideweapon;
  }

  chopper.frontturret = spawnturret("misc_turret", chopper gettagorigin(linktag), weaponname);
  chopper.frontturret setModel(turretmodel);
  chopper.frontturret.team = chopper.team;
  chopper.frontturret.angles = chopper.angles;
  chopper.frontturret.turreton = 1;
  chopper.frontturret.name = "front_turret";
  chopper.frontturret.attackingtarget = undefined;
  chopper.frontturret.vehicleparent = "loot_chopper";
  chopper.frontturret linkTo(chopper);
  chopper.frontturret setturretteam(chopper.team);
  chopper.frontturret setturretmodechangewait(0);
  chopper.frontturret setmode("manual");
  chopper.frontturret setdefaultdroppitch(45);
  chopper.frontturret.groundtargetent = spawn("script_model", chopper.origin);
  chopper.frontturret.groundtargetent setModel("tag_origin");
  chopper.frontturret.groundtargetent dontinterpolate();

  if(!istrue(level.var_a83a4e71446bfef7)) {
    chopper.rearturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_rear"), weaponname);
    chopper.rearturret setModel("veh9_mil_air_heli_ahotel64_turret");
    chopper.rearturret.team = chopper.team;
    chopper.rearturret.angles = chopper.angles;
    chopper.rearturret.turreton = 1;
    chopper.rearturret.name = "rear_turret";
    chopper.rearturret.attackingtarget = undefined;
    chopper.rearturret.vehicleparent = "loot_chopper";
    chopper.rearturret linkTo(chopper);
    chopper.rearturret setturretteam(chopper.team);
    chopper.rearturret setturretmodechangewait(0);
    chopper.rearturret setmode("manual");
    chopper.rearturret setdefaultdroppitch(45);
    chopper.rearturret.groundtargetent = spawn("script_model", chopper.origin);
    chopper.rearturret.groundtargetent setModel("tag_origin");
    chopper.rearturret.groundtargetent dontinterpolate();
  }

  level.loot_choppers[level.loot_choppers.size] = chopper;
  chopper.patrolfunc = &lootchopper_patrolzone;
  chopper.lootfunc = &lootchopper_droploot;
  chopper.cleanupfunc = &lootchopper_cleanup;
  chopper lootchopper_createobjective();
  chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();
  chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_watchdestroyed();

  if(issharedfuncdefined("flares", "handleIncomingStinger")) {
    chopper thread[[getsharedfunc("flares", "handleIncomingStinger")]](&scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);
  }

  chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(chopper.pathgoal, 1);
  return chopper;
}

function lootchopper_setupdamagefunctionality() {
  self.vehiclename = "loot_chopper";
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(self.vehiclename, 20);
  lootchopper_modifyweapondamage("iw9_la_gromeo_mp", 4, 20);
  lootchopper_modifyweapondamage("iw9_la_kgolf_mp", 4, 20);
  lootchopper_modifyweapondamage("iw9_la_rpapa7_mp", 4, 20);
  lootchopper_modifyweapondamage("iw9_la_juliet_mp", 5, 20);
  lootchopper_modifyweapondamage("iw9_la_gromeo_mp", 4, 20);
  lootchopper_modifyweapondamage("iw9_la_mike32_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("c4_mp", 4, 20);
  lootchopper_modifyweapondamage("semtex_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("frag_grenade_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("pop_rocket_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("molotov_mp", 1.81818, 20);
  lootchopper_modifyweapondamage("at_mine_ap_mp", 1.81818, 20);
  lootchopper_modifyweapondamage("at_mine_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("thermite_mp", 1, 36);
  lootchopper_modifyweapondamage("thermite_av_mp", 1, 36);
  lootchopper_modifyweapondamage("thermite_bolt_mp", 1, 30);
  lootchopper_modifyweapondamage("thermite_xmike109_mp", 1, 52);
  lootchopper_modifyweapondamage("emp_grenade_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("claymore_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("semtex_bolt_mp", 2, 20);
  lootchopper_modifyweapondamage("semtex_xmike109_mp", 1.42857, 20);
  lootchopper_modifyweapondamage("chopper_gunner_proj_mp", 5, 20);
  lootchopper_modifyweapondamage("toma_proj_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("cruise_proj_mp", 6.66667, 20);
  lootchopper_modifyweapondamage("artillery_mp", 6.66667, 20);
  lootchopper_modifyweapondamage("nuke_mp", 10, 20);
  lootchopper_modifyweapondamage("gunship_hellfire_mp", 10, 20);
  lootchopper_modifyweapondamage("gunship_105mm_mp", 10, 20);
  lootchopper_modifyweapondamage("gunship_40mm_mp", 5, 20);
  lootchopper_modifyweapondamage("gunship_25mm_mp", 2.85714, 20);
  lootchopper_modifyweapondamage("hover_jet_proj_mp", 5, 20);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(self.vehiclename, 1);
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(self.vehiclename, &lootchopper_premodifydamage);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(self.vehiclename, &lootchopper_postmodifydamage);
  scripts\mp\vehicles\damage::set_death_callback(self.vehiclename, &lootchopper_handledeathdamage);
  scripts\cp_mp\utility\killstreak_utility::function_cfc5e3633ef950fd(1, 2000, &function_c300bcca405c826d);
  scripts\cp_mp\utility\killstreak_utility::function_cfc5e3633ef950fd(2, 1000, &function_f70041f0a83148ce);
  scripts\cp_mp\utility\killstreak_utility::function_cfc5e3633ef950fd(3, 500, &function_3cd972f38ff76d2c);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self);
}

function lootchopper_modifyweapondamage(weaponname, var_dc9cc1d7198502c2, var_e88cbe78a1e25e8a) {
  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle(weaponname, var_dc9cc1d7198502c2, self.vehiclename);
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon(self.vehiclename, var_e88cbe78a1e25e8a, weaponname);
}

function lootchopper_premodifydamage(data) {
  damage = data.damage;
  attacker = data.attacker;
  return true;
}

function lootchopper_postmodifydamage(data) {
  scripts\cp_mp\killstreaks\chopper_support::function_400022dabdb64055(data);

  if(!isDefined(self.attackers)) {
    self.attackers = [];
  }

  var_996b260954d28d79 = lootchopper_getattackerdata(data.attacker);

  if(!isDefined(var_996b260954d28d79)) {
    newattacker = spawnStruct();
    newattacker.player = data.attacker;
    newattacker.objweapon = data.objweapon;
    newattacker.totaldamage = data.damage;
    self.attackers[self.attackers.size] = newattacker;
  } else {
    var_996b260954d28d79.totaldamage += data.damage;
    var_996b260954d28d79.objweapon = data.objweapon;
  }

  scripts\cp_mp\utility\killstreak_utility::killstreak_updatedamagestate(self.currenthealth);
  return true;
}

function lootchopper_handledeathdamage(data) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);
  scoreevent = undefined;
  points = undefined;
  killer = data.attacker;

  foreach(attackerinfo in self.attackers) {
    if(isDefined(attackerinfo.player)) {
      if(isDefined(killer) && killer == attackerinfo.player) {
        scoreevent = #"hash_916af74a28436e1c";
      } else {
        scoreevent = #"hash_59b8198b31baf7ea";
      }

      points = scripts\mp\rank::getscoreinfovalue(scoreevent);
      attackerinfo.player thread scripts\mp\rank::giverankxp(scoreevent, points, attackerinfo.objweapon);
      attackerinfo.player thread scripts\mp\events::killeventtextpopup(scoreevent, 0);
      thread scripts\cp_mp\challenges::vehiclekilled(self, attackerinfo.player, 0, attackerinfo.objweapon);
    }
  }

  self notify("death");
  return true;
}

function lootchopper_patrolzone(initialpatrol) {
  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(initialpatrol)) {
    return;
  }

  self clearlookatent();
  self setneargoalnotifydist(300);
  var_65af68838583c396 = 0;
  var_b9a46106a6a99ee8 = 0;

  while(true) {
    if(self.currentaction == "attacking") {
      if(!istrue(var_65af68838583c396)) {
        var_65af68838583c396 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(initialpatrol) && istrue(var_65af68838583c396)) {
      var_65af68838583c396 = 0;
    }

    newgoal = self.patrollocation + anglesToForward((0, var_b9a46106a6a99ee8, 0)) * int(self.patrolradius / 1.2);
    var_b9a46106a6a99ee8 += 90;
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(newgoal, 1);

    if(var_b9a46106a6a99ee8 >= 360) {
      var_b9a46106a6a99ee8 = 0;
    }

    wait 0.5;
  }
}

function lootchopper_droploot() {
  droplocation = lootchopper_finddroplocation(self.origin + (0, 0, 500));

  if(isDefined(droplocation)) {
    plundercrate = scripts\cp_mp\killstreaks\airdrop::dropbrlootchoppercrate(self.origin, droplocation);
    triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(plundercrate);
    triggerobject.usetimeoverride = 10;
  }
}

function lootchopper_finddroplocation(starttrace) {
  droplocation = undefined;
  endtrace = starttrace - (0, 0, 20000);
  ignorelist = [];

  if(isent(self)) {
    ignorelist = [self, self.frontturret, self.rearturret];
    ignorelist = array_removeundefined(ignorelist);
  }

  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignorelist);

  if(isDefined(trace) && trace["hittype"] != "hittype_none") {
    droplocation = trace["position"];
  }

  return droplocation;
}

function lootchopper_oncrateuse(player) {
  plunderreward = getdvarint(@ "hash_c027db5b75ded4aa", 100000);

  if(istrue(level.bmoovertime)) {
    plunderbonus = getdvarint(@ "hash_7daf22bb16ed19fe", 50000);
    plunderreward += plunderbonus;
  }

  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  dropstruct.dropidx = 10;
  self.itemsdropped = 0;
  pickupents = scripts\mp\gametypes\br_plunder::dropplunderbyrarity(plunderreward / 100, dropstruct);

  foreach(ent in pickupents) {
    ent.lootsource = "loot_chopper";
  }

  if(!isDefined(player.lootcachesopened)) {
    player.lootcachesopened = 1;
  } else {
    player.lootcachesopened++;
  }

  if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder") {
    player scripts\mp\gametypes\br_public::updatebrscoreboardstat("lootCachesOpened", player.lootcachesopened);
  }

  player thread scripts\mp\utility\points::doscoreevent(#"hash_70e5de61cfaa916b");
}

function lootchopper_cleanup() {
  if(isDefined(self.dropzone)) {
    self.dropzone delete();
  }

  if(isDefined(self.patrolzone)) {
    self.patrolzone.chopperoccupied = undefined;
  }

  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  level.loot_choppers = array_remove(level.loot_choppers, self);
}

function lootchopper_createobjective() {
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "active", self.origin, "ui_mp_br_mapmenu_icon_boss_chopper", "icon_medium");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objectiveiconid);
    scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, self);
    objective_sethideelevation(objectiveiconid, 1);
  }

  self.objectiveiconid = objectiveiconid;
}

function lootchopper_getattackerdata(var_76b6b96d4589e81d) {
  attackerdata = undefined;

  if(!isDefined(var_76b6b96d4589e81d)) {
    return attackerdata;
  }

  foreach(var_6b478dcf436ae4c0 in self.attackers) {
    if(isDefined(var_6b478dcf436ae4c0.player) && var_76b6b96d4589e81d == var_6b478dcf436ae4c0.player) {
      attackerdata = var_6b478dcf436ae4c0;
      break;
    }
  }

  return attackerdata;
}

function function_c300bcca405c826d() {
  self setscriptablepartstate("body_damage_light", "on");
}

function function_f70041f0a83148ce() {
  self setscriptablepartstate("body_damage_medium", "on");
}

function function_3cd972f38ff76d2c() {
  self setscriptablepartstate("body_damage_heavy", "on");
}