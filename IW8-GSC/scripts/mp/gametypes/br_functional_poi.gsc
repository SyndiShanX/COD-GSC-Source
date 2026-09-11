/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_functional_poi.gsc
******************************************************/

function init() {
  scripts\mp\gametypes\br_plunder::init();
  scripts\mp\gametypes\br_armory_kiosk::init();
  scripts\mp\gametypes\br_armory_trader::init();
  _findgivearmoramountanddropleftovers::init();
  scripts\mp\gametypes\br_plunder_dispenser::init();
  scripts\mp\flags::gameflaginit("POIs_spawned", 0);
  thread _spawnpois();
}

function initplayer() {
  scripts\mp\gametypes\br_plunder::initplayer();
}

function onprematchdone() {
  scripts\mp\flags::gameflagwait("POIs_spawned");
  scripts\mp\gametypes\br_armory_kiosk::onprematchdone();
  scripts\mp\gametypes\br_armory_trader::onprematchdone();
  scripts\mp\gametypes\br_plunder_dispenser::onprematchdone();
}

function getinteractiveoutlineasset() {
  return "outline_depth_red";
}

function _spawnpois() {
  level endon("game_ended");
  var_0 = 0.05;
  var_1 = 5;
  var_2 = 5;
  var_3 = 7;
  var_4 = 7;

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    level.binoculars_checkexpirationtimer = getdvarint("scr_bmo_event_distribution_pad", 35);
    level.ref_12946 = getdvarint("scr_bmo_event_distribution_pad_push", 1);
    level.fly_over_path = getdvarint("scr_bmo_buystation_distribution_pad", 0);
    thread ref_1325b();
  }

  level.ref_11c41 = getdvarint("br_min_plunder_extractions", var_4);
  level.ref_11b6d = getdvarint("br_max_plunder_extractions", var_3);

  if(level.ref_11c41 < level.ref_11b6d) {
    level.ref_11b6d = randomintrange(level.ref_11c41, level.ref_11b6d + 1);
  }

  var_5 = getdvarint("br_max_armory_kiosk", 65);
  var_6 = scripts\mp\gametypes\br_armory_kiosk::registeraccesscardlocs();

  if(isDefined(var_6) && var_6.size > 0) {
    var_6 = play_lz_vo(var_6);
    var_6 = ai_semtex_swapp(var_6, var_5, level.fly_over_path);

    if(isDefined(var_6) && var_6.size > 0) {
      scripts\mp\gametypes\br_armory_kiosk::ref_131c0(var_6);
    }
  }

  var_7 = getdvarint("br_max_armory_trader", 65);
  var_8 = scripts\mp\gametypes\br_armory_trader::registeraccesscardlocs();

  if(isDefined(var_8) && var_8.size > 0) {
    var_8 = play_music_to_team(var_8);
    var_8 = ai_semtex_swapp(var_8, var_7, level.fly_over_path);

    if(isDefined(var_8) && var_8.size > 0) {
      scripts\mp\gametypes\br_armory_trader::ref_131c0(var_8);
    }
  }

  var_9 = scripts\mp\gametypes\br_plunder::register_vfx();

  if(isDefined(var_9) && var_9.size > 0) {
    var_9 = ai_semtex_swapp(var_9, level.ref_11b6d, 1);

    if(isDefined(var_9) && var_9.size > 0) {
      scripts\mp\gametypes\br_plunder::ref_1314b(var_9);
    }
  }

  var_10 = scripts\engine\utility::getStructArray("br_respawn_station", "targetname");

  for(var_11 = 0; var_11 < var_10.size; var_11++) {
    wait var_0;
    scripts\mp\gametypes\br_respawn::spawnambulance(var_10[var_11]);
  }

  scripts\mp\flags::gameflagset("POIs_spawned");
}

function ai_semtex_swapp(var_0, var_1, var_2) {
  if(var_0.size == 0 || var_1 == 0) {
    return undefined;
  }

  if(var_1 > var_0.size) {
    var_1 = var_0.size;
  }

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    return scripts\mp\gametypes\br_gametype_dmz::ai_shooting_timer(var_0, var_1, var_2);
  } else if(getDvar("scr_br_gametype", "") == "rat_race") {
    return scripts\mp\gametypes\br_gametype_rat_race::ai_shooting_timer(var_0, var_1, var_2);
  } else if(!isDefined(level.br_circle) || !isDefined(level.br_level)) {
    return ai_shooting_watch(var_0, var_1);
  }

  var_3 = level.br_level.default_class_chosen.size - 1;
  var_4 = int(max(1, var_3 * getdvarfloat("br_poi_noise", 1)));

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];
    var_7 = randomintrange(-1 * var_4, var_4 + 1);
    var_6.score = scripts\mp\gametypes\br_circle::relic_amped_reset_deathshield_on_revived(var_6.origin) + var_7;
  }

  var_8 = scripts\engine\utility::array_sort_with_func(var_0, &hidequestcircletoall);
  var_9 = [];
  var_5 = 0;

  if(var_5 < var_1) {
    GscBinSkip0(0x2e, var_5, var_8[var_5]);
  }

  return scripts\engine\utility::array_slice(var_8, 0, var_1);
}

function hidequestcircletoall(var_0, var_1) {
  return var_0.score > var_1.score;
}

function ai_shooting_watch(var_0, var_1) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }

  var_2 = [];

  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_3 = int(min(var_1, var_0.size));

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_2 = var_0[var_4];
    }
  }

  return var_2;
}

function showmiscmessagetoteam(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    var_4 = "mp/hints.csv";
    var_5 = 1;
    var_6 = 0;
    var_7 = -1;
    var_8 = tablelookuprownum(var_4, var_5, var_1);

    if(isDefined(var_8) && var_8 >= 0) {
      var_7 = int(tablelookupbyrow(var_4, var_8, var_6));
    }

    if(var_7 < 0) {
      return;
    }

    var_9 = undefined;

    if(isDefined(var_3)) {
      var_9 = gettime() + var_3;
    }

    var_12 = scripts\mp\utility\teams::getteamdata(var_0, "players");

    foreach(var_14 in var_12) {
      var_14 scripts\mp\utility\lower_message::setlowermessageomnvar(var_7, var_9, var_2);
    }

    return;
  }
}

function initstatemachineforpoitype(var_0) {
  if(!isDefined(level.poistates)) {
    level.poistates = [];
  }

  level.poistates[var_0] = [];
}

function registerstatecallbacksforpoitype(var_0, var_1, var_2, var_3, var_4) {
  level.poistates[var_0][var_1] = spawnStruct();
  level.poistates[var_0][var_1].onenter = var_2;
  level.poistates[var_0][var_1].onupdate = var_3;
  level.poistates[var_0][var_1].onexit = var_4;
}

function gotopoistate(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2.currentstate)) {
    var_3 = level.poistates[var_0][var_2.currentstate];

    if(isDefined(var_3) && isDefined(var_3.onexit)) {
      level[[var_3.onexit]](var_2);
    }
  }

  var_2 notify("poi_state_change");
  var_2.currentstate = var_1;
  var_3 = level.poistates[var_0][var_2.currentstate];

  if(isDefined(var_3)) {
    if(isDefined(var_3.onenter)) {
      level[[var_3.onenter]](var_2);
    }

    if(isDefined(var_3.onupdate)) {
      thread _poistateupdate(var_2);
      return;
    }

    return;
  }
}

function gotopoistateontimer(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("poi_state_change");
  wait var_2;
  thread gotopoistate(var_3, var_0);
}

function getcurrentpoistate() {
  var_0 = self;
  return var_0.currentstate;
}

function _poistateupdate(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_2 = var_1.currentstate;

  while(var_2 == var_1.currentstate) {
    level[[var_0]](var_1);
    waitframe();
  }
}

function ref_1325b() {
  if(!isDefined(level.mapcorners)) {
    waitframe();
  }

  var_0 = level.mapcorners[0].origin[0];
  var_1 = level.mapcorners[1].origin[0];
  var_2 = (level.mapcorners[0].origin[0], level.mapcorners[0].origin[1], level.mapcorners[0].origin[2]);
  var_3 = (level.mapcorners[1].origin[0], level.mapcorners[0].origin[1], level.mapcorners[1].origin[2]);

  if(var_1 < var_0) {
    var_2 = (level.mapcorners[1].origin[0], level.mapcorners[0].origin[1], level.mapcorners[1].origin[2]);
    var_3 = (level.mapcorners[0].origin[0], level.mapcorners[0].origin[1], level.mapcorners[0].origin[2]);
  }

  var_4 = level.mapcorners[0].origin[1];
  var_5 = level.mapcorners[1].origin[1];
  var_6 = (level.mapcorners[0].origin[0], level.mapcorners[1].origin[1], level.mapcorners[0].origin[2]);
  var_7 = (level.mapcorners[1].origin[0], level.mapcorners[1].origin[1], level.mapcorners[1].origin[2]);

  if(var_5 < var_4) {
    var_6 = (level.mapcorners[1].origin[0], level.mapcorners[1].origin[1], level.mapcorners[1].origin[2]);
    var_7 = (level.mapcorners[0].origin[0], level.mapcorners[1].origin[1], level.mapcorners[0].origin[2]);
  }

  var_8 = [];

  if(scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    level.ignorevehicleexplosivedamage = abs(distance(var_7, var_2));
    var_9 = level.ignorevehicleexplosivedamage / 10;
    var_2 = (var_2[0] + var_9, var_2[1] - var_9, var_2[2]);
    var_3 = (var_3[0] - var_9, var_3[1] - var_9, var_3[2]);
    var_6 = (var_6[0] - var_9, var_6[1] + var_9, var_6[2]);
    var_7 = (var_7[0] + var_9, var_7[1] + var_9, var_7[2]);
    level.ignorevehicleexplosivedamage = abs(distance(var_7, var_2));
    var_10 = 1;

    while(var_10 < 4) {
      var_11 = var_10 * level.ignorevehicleexplosivedamage / 2;
      var_12 = 1;

      while(var_12 < 4) {
        var_13 = var_12 * level.ignorevehicleexplosivedamage / 2;
        var_14 = (var_7[0] + var_11 / 2, var_7[1] + var_13 / 2, 0);
        var_8 = var_14;
        var_12 += 2;
      }

      var_10 += 2;
    }
  }

  level.ref_12950 = [];

  if(level.mapname == "mp_br_mechanics") {
    level.ref_12950[level.ref_12950.size] = (3965, 4054, 0);
    level.ref_12950[level.ref_12950.size] = (4069, -4150, 0);
    level.ref_12950[level.ref_12950.size] = (-4035, -4074, 0);
    level.ref_12950[level.ref_12950.size] = (-4009, 4105, 0);
  } else if(level.mapname == "mp_br_money") {
    level.ref_12950[level.ref_12950.size] = (46569.5, -8170, 0);
    level.ref_12950[level.ref_12950.size] = (56849.5, -8170, 0);
    level.ref_12950[level.ref_12950.size] = (67081.5, -17919.5, 0);
    level.ref_12950[level.ref_12950.size] = (46593, -17919.5, 0);
  } else if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    level.ref_12950[level.ref_12950.size] = (-21299.2, 41779.2, 0);
    level.ref_12950[level.ref_12950.size] = (37683.2, 41779.2, 0);
    level.ref_12950[level.ref_12950.size] = (37683.2, -17203.2, 0);
    level.ref_12950[level.ref_12950.size] = (-21299.2, -17203.2, 0);
  } else {
    var_15 = 0.8;
    var_16 = 0.5;
    var_17 = var_15 * var_16;
    level.ref_12950[level.ref_12950.size] = (var_0 * var_17, var_5 * var_17, 0);
    level.ref_12950[level.ref_12950.size] = (var_1 * var_17, var_5 * var_17, 0);
    level.ref_12950[level.ref_12950.size] = (var_1 * var_17, var_4 * var_17, 0);
    level.ref_12950[level.ref_12950.size] = (var_0 * var_17, var_4 * var_17, 0);
  }

  level.ref_12950 = scripts\engine\utility::array_randomize(level.ref_12950);

  if(level.binoculars_checkexpirationtimer > 0 && scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    var_18 = randomintrange(0, 5);
    var_9 = level.ignorevehicleexplosivedamage / 10;
    var_19 = level.ignorevehicleexplosivedamage / 100 / level.binoculars_checkexpirationtimer;

    switch (var_18) {
      case 0:
        var_20 = (var_2[0] + var_9, var_2[1] - var_9, var_2[2]);
        var_21 = (var_3[0] - var_19, var_3[1] - var_9, var_3[2]);
        var_22 = (var_6[0] - var_19, var_6[1] + var_19, var_6[2]);
        var_23 = (var_7[0] + var_9, var_7[1] + var_19, var_7[2]);
        break;
      case 1:
        var_20 = (var_6[0] + var_23, var_6[1] - var_22, var_6[2]);
        var_21 = (var_7[0] - var_22, var_7[1] - var_22, var_7[2]);
        var_22 = (var_9[0] - var_23, var_9[1] + var_22, var_9[2]);
        var_23 = (var_19[0] + var_23, var_19[1] + var_23, var_19[2]);
        break;
      case 2:
        var_20 = (var_9[0] + var_23, var_9[1] - var_23, var_9[2]);
        var_21 = (var_19[0] - var_22, var_19[1] - var_23, var_19[2]);
        var_22 = (var_22[0] - var_22, var_22[1] + var_22, var_22[2]);
        var_23 = (var_23[0] + var_23, var_23[1] + var_22, var_23[2]);
        break;
      case 3:
        var_20 = (var_22[0] + var_22, var_22[1] - var_23, var_22[2]);
        var_21 = (var_23[0] - var_23, var_23[1] - var_23, var_23[2]);
        var_22 = (var_22[0] - var_23, var_22[1] + var_22, var_22[2]);
        var_23 = (var_23[0] + var_22, var_23[1] + var_22, var_23[2]);
        break;
      case 4:
        var_20 = (var_22[0] + var_23, var_22[1] - var_23, var_22[2]);
        var_21 = (var_23[0] - var_23, var_23[1] - var_23, var_23[2]);
        var_22 = (var_22[0] - var_23, var_22[1] + var_23, var_22[2]);
        var_23 = (var_23[0] + var_23, var_23[1] + var_23, var_23[2]);
        break;
      default:
        var_20 = (var_22[0] + var_23, var_22[1] - var_23, var_22[2]);
        var_21 = (var_23[0] - var_23, var_23[1] - var_23, var_23[2]);
        var_22 = (var_22[0] - var_23, var_22[1] + var_23, var_22[2]);
        var_23 = (var_23[0] + var_23, var_23[1] + var_23, var_23[2]);
        break;
    }

    var_24 = [];
    level.ref_121bb = [];
    level.ref_121ba = abs(distance(var_23, var_20));
    level.ref_127de = level.ref_121ba / 2;
    var_10 = 1;

    while(var_10 < 4) {
      var_11 = var_10 * level.ref_121ba / 2;
      var_12 = 1;

      while(var_12 < 4) {
        var_13 = var_12 * level.ref_121ba / 2;
        var_14 = (var_23[0] + var_11 / 2, var_23[1] + var_13 / 2, 0);
        var_24 = var_14;
        var_12 += 2;
      }

      var_10 += 2;
    }

    if(level.ref_12946 == 2) {
      level.ref_121bb = scripts\engine\utility::array_randomize(var_24);
      return;
    }

    switch (var_21) {
      case 0:
        if(level.ref_12946) {
          level.ref_121bb[level.ref_121bb.size] = var_24[2];
          level.ref_121bb[level.ref_121bb.size] = var_24[3];
          level.ref_121bb[level.ref_121bb.size] = var_24[1];
          level.ref_121bb[level.ref_121bb.size] = var_24[0];
        } else {
          level.ref_121bb[level.ref_121bb.size] = var_24[1];
          level.ref_121bb[level.ref_121bb.size] = var_24[3];
          level.ref_121bb[level.ref_121bb.size] = var_24[2];
          level.ref_121bb[level.ref_121bb.size] = var_24[0];
        }

        break;
      case 1:
        if(level.ref_12946) {
          level.ref_121bb[level.ref_121bb.size] = var_24[0];
          level.ref_121bb[level.ref_121bb.size] = var_24[2];
          level.ref_121bb[level.ref_121bb.size] = var_24[3];
          level.ref_121bb[level.ref_121bb.size] = var_24[1];
        } else {
          level.ref_121bb[level.ref_121bb.size] = var_24[3];
          level.ref_121bb[level.ref_121bb.size] = var_24[2];
          level.ref_121bb[level.ref_121bb.size] = var_24[0];
          level.ref_121bb[level.ref_121bb.size] = var_24[1];
        }

        break;
      case 2:
        if(level.ref_12946) {
          level.ref_121bb[level.ref_121bb.size] = var_24[1];
          level.ref_121bb[level.ref_121bb.size] = var_24[0];
          level.ref_121bb[level.ref_121bb.size] = var_24[2];
          level.ref_121bb[level.ref_121bb.size] = var_24[3];
        } else {
          level.ref_121bb[level.ref_121bb.size] = var_24[2];
          level.ref_121bb[level.ref_121bb.size] = var_24[0];
          level.ref_121bb[level.ref_121bb.size] = var_24[1];
          level.ref_121bb[level.ref_121bb.size] = var_24[3];
        }

        break;
      case 3:
        if(level.ref_12946) {
          level.ref_121bb[level.ref_121bb.size] = var_24[3];
          level.ref_121bb[level.ref_121bb.size] = var_24[1];
          level.ref_121bb[level.ref_121bb.size] = var_24[0];
          level.ref_121bb[level.ref_121bb.size] = var_24[2];
        } else {
          level.ref_121bb[level.ref_121bb.size] = var_24[0];
          level.ref_121bb[level.ref_121bb.size] = var_24[1];
          level.ref_121bb[level.ref_121bb.size] = var_24[3];
          level.ref_121bb[level.ref_121bb.size] = var_24[2];
        }

        break;
      case 4:
        level.ref_121bb = scripts\engine\utility::array_randomize(var_24);
        break;
      default:
        level.ref_121bb = scripts\engine\utility::array_randomize(var_24);
        break;
    }

    return;
  }
}

function play_lz_vo(var_0) {
  if(getdvarint("scr_br_kiosk_distribute", 1) == 0 || !scripts\cp_mp\utility\game_utility::unsetchainkillstreaks()) {
    return var_0;
  }

  var_1 = getdvarfloat("scr_br_kiosk_distribute_min_per", 1);
  var_2 = getdvarfloat("scr_br_kiosk_distribute_min_dist", 7000);
  var_3 = var_2 * var_2;
  var_4 = [];
  var_5 = [];
  GscBinSkip0(0x2e, 0, battle_tracks_onexitvehicle((40925, -7519, 0), 49000000));
}

function play_music_to_team(var_0) {
  if(getdvarint("scr_br_trader_distribute", 1) == 0 || !scripts\cp_mp\utility\game_utility::turretdisabled()) {
    return var_0;
  }

  var_1 = getdvarfloat("scr_br_trader_distribute_min_per", 1);
  var_2 = getdvarfloat("scr_br_trader_distribute_min_dist", 7000);
  var_3 = var_2 * var_2;
  var_4 = [];

  foreach(var_6 in var_0) {
    var_7 = 0;

    foreach(var_9 in level.calloutglobals.calloutzones) {
      if(ispointinvolume(var_6.origin, var_9)) {
        if(!isDefined(var_9.ref_13c6a)) {
          var_9.ref_13c6a = [];
        }

        var_7 = 1;
        var_9.ref_13c6a[var_9.ref_13c6a.size] = var_6;
        break;
      }
    }

    if(!var_7) {
      var_4 = var_6;
    }
  }

  foreach(var_9 in level.calloutglobals.calloutzones) {
    if(!isDefined(var_9.ref_13c6a) || var_9.ref_13c6a.size == 0) {
      var_9.ref_13c6a = undefined;
      continue;
    }

    var_13 = scripts\engine\utility::array_randomize(var_9.ref_13c6a);
    var_4 = var_13[0];
    var_14 = [];
    var_14 = var_13[0];
    var_15 = int(ceil(var_13.size / var_1));
    var_16 = 1;

    for(var_17 = 1; var_17 < var_13.size && var_16 < var_15; var_17++) {
      var_18 = var_13[var_17];
      var_19 = 1;

      foreach(var_21 in var_14) {
        var_22 = distance2dsquared(var_18.origin, var_21.origin);

        if(var_22 < var_3) {
          var_19 = 0;
          break;
        }
      }

      if(var_19) {
        var_4 = var_18;
        var_14 = var_18;
        var_16++;
      }
    }

    var_9.ref_13c6a = undefined;
  }

  return var_4;
}

function battle_tracks_onexitvehicle(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.ref_129e5 = var_1;
  var_2.wait_for_computer_power = [];
  return var_2;
}

function player_give_intel_1_ks(var_0) {
  var_1 = incrementpersistentstat(level.players, self.origin, var_0);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !isalive(var_3)) {
      continue;
    }

    if(var_3 getstance() != "prone") {
      continue;
    }

    var_4 = var_3 getboundshalfsize();
    var_0 = var_4[0];
    var_5 = 2 * var_4[2];

    if(capsuletracepassed(var_3.origin, var_0, var_5, undefined, 0, 0)) {
      continue;
    }

    var_3 setstance("crouch", 1);
  }
}