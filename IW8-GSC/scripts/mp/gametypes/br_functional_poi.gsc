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
  var0 = 0.05;
  var1 = 5;
  var2 = 5;
  var3 = 7;
  var4 = 7;

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    level.binoculars_checkexpirationtimer = getdvarint("scr_bmo_event_distribution_pad", 35);
    level.ref_12946 = getdvarint("scr_bmo_event_distribution_pad_push", 1);
    level.fly_over_path = getdvarint("scr_bmo_buystation_distribution_pad", 0);
    thread ref_1325b();
  }

  level.ref_11c41 = getdvarint("br_min_plunder_extractions", var4);
  level.ref_11b6d = getdvarint("br_max_plunder_extractions", var3);

  if(level.ref_11c41 < level.ref_11b6d) {
    level.ref_11b6d = randomintrange(level.ref_11c41, level.ref_11b6d + 1);
  }

  var5 = getdvarint("br_max_armory_kiosk", 65);
  var6 = scripts\mp\gametypes\br_armory_kiosk::registeraccesscardlocs();

  if(isDefined(var6) && var6.size > 0) {
    var6 = play_lz_vo(var6);
    var6 = ai_semtex_swapp(var6, var5, level.fly_over_path);

    if(isDefined(var6) && var6.size > 0) {
      scripts\mp\gametypes\br_armory_kiosk::ref_131c0(var6);
    }
  }

  var7 = getdvarint("br_max_armory_trader", 65);
  var8 = scripts\mp\gametypes\br_armory_trader::registeraccesscardlocs();

  if(isDefined(var8) && var8.size > 0) {
    var8 = play_music_to_team(var8);
    var8 = ai_semtex_swapp(var8, var7, level.fly_over_path);

    if(isDefined(var8) && var8.size > 0) {
      scripts\mp\gametypes\br_armory_trader::ref_131c0(var8);
    }
  }

  var9 = scripts\mp\gametypes\br_plunder::register_vfx();

  if(isDefined(var9) && var9.size > 0) {
    var9 = ai_semtex_swapp(var9, level.ref_11b6d, 1);

    if(isDefined(var9) && var9.size > 0) {
      scripts\mp\gametypes\br_plunder::ref_1314b(var9);
    }
  }

  var10 = scripts\engine\utility::getStructArray("br_respawn_station", "targetname");

  for(var11 = 0; var11 < var10.size; var11++) {
    wait var0;
    scripts\mp\gametypes\br_respawn::spawnambulance(var10[var11]);
  }

  scripts\mp\flags::gameflagset("POIs_spawned");
}

function ai_semtex_swapp(var0, var1, var2) {
  if(var0.size == 0 || var1 == 0) {
    return undefined;
  }

  if(var1 > var0.size) {
    var1 = var0.size;
  }

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    return scripts\mp\gametypes\br_gametype_dmz::ai_shooting_timer(var0, var1, var2);
  } else if(getDvar("scr_br_gametype", "") == "rat_race") {
    return scripts\mp\gametypes\br_gametype_rat_race::ai_shooting_timer(var0, var1, var2);
  } else if(!isDefined(level.br_circle) || !isDefined(level.br_level)) {
    return ai_shooting_watch(var0, var1);
  }

  var3 = level.br_level.default_class_chosen.size - 1;
  var4 = int(max(1, var3 * getdvarfloat("br_poi_noise", 1)));

  for(var5 = 0; var5 < var0.size; var5++) {
    var6 = var0[var5];
    var7 = randomintrange(-1 * var4, var4 + 1);
    var6.score = scripts\mp\gametypes\br_circle::relic_amped_reset_deathshield_on_revived(var6.origin) + var7;
  }

  var8 = scripts\engine\utility::array_sort_with_func(var0, &hidequestcircletoall);
  var9 = [];
  var5 = 0;

  if(var5 < var1) {
    GscBinSkip0(0x2e, var5, var8[var5]);
  }

  return scripts\engine\utility::array_slice(var8, 0, var1);
}

function hidequestcircletoall(var0, var1) {
  return var0.score > var1.score;
}

function ai_shooting_watch(var0, var1) {
  if(var0.size == 0 || var1 == 0) {
    return;
  }

  var2 = [];

  if(var0.size > 0) {
    var0 = scripts\engine\utility::array_randomize(var0);
    var3 = int(min(var1, var0.size));

    for(var4 = 0; var4 < var3; var4++) {
      var2 = var0[var4];
    }
  }

  return var2;
}

function showmiscmessagetoteam(var0, var1, var2, var3) {
  if(isDefined(var0)) {
    var4 = "mp/hints.csv";
    var5 = 1;
    var6 = 0;
    var7 = -1;
    var8 = tablelookuprownum(var4, var5, var1);

    if(isDefined(var8) && var8 >= 0) {
      var7 = int(tablelookupbyrow(var4, var8, var6));
    }

    if(var7 < 0) {
      return;
    }

    var9 = undefined;

    if(isDefined(var3)) {
      var9 = gettime() + var3;
    }

    var12 = scripts\mp\utility\teams::getteamdata(var0, "players");

    foreach(var14 in var12) {
      var14 scripts\mp\utility\lower_message::setlowermessageomnvar(var7, var9, var2);
    }

    return;
  }
}

function initstatemachineforpoitype(var0) {
  if(!isDefined(level.poistates)) {
    level.poistates = [];
  }

  level.poistates[var0] = [];
}

function registerstatecallbacksforpoitype(var0, var1, var2, var3, var4) {
  level.poistates[var0][var1] = spawnStruct();
  level.poistates[var0][var1].onenter = var2;
  level.poistates[var0][var1].onupdate = var3;
  level.poistates[var0][var1].onexit = var4;
}

function gotopoistate(var0, var1) {
  var2 = self;

  if(isDefined(var2.currentstate)) {
    var3 = level.poistates[var0][var2.currentstate];

    if(isDefined(var3) && isDefined(var3.onexit)) {
      level[[var3.onexit]](var2);
    }
  }

  var2 notify("poi_state_change");
  var2.currentstate = var1;
  var3 = level.poistates[var0][var2.currentstate];

  if(isDefined(var3)) {
    if(isDefined(var3.onenter)) {
      level[[var3.onenter]](var2);
    }

    if(isDefined(var3.onupdate)) {
      thread _poistateupdate(var2);
      return;
    }

    return;
  }
}

function gotopoistateontimer(var0, var1, var2) {
  var3 = self;
  var3 endon("death");
  var3 endon("poi_state_change");
  wait var2;
  thread gotopoistate(var3, var0);
}

function getcurrentpoistate() {
  var0 = self;
  return var0.currentstate;
}

function _poistateupdate(var0) {
  var1 = self;
  var1 endon("death");
  var2 = var1.currentstate;

  while(var2 == var1.currentstate) {
    level[[var0]](var1);
    waitframe();
  }
}

function ref_1325b() {
  if(!isDefined(level.mapcorners)) {
    waitframe();
  }

  var0 = level.mapcorners[0].origin[0];
  var1 = level.mapcorners[1].origin[0];
  var2 = (level.mapcorners[0].origin[0], level.mapcorners[0].origin[1], level.mapcorners[0].origin[2]);
  var3 = (level.mapcorners[1].origin[0], level.mapcorners[0].origin[1], level.mapcorners[1].origin[2]);

  if(var1 < var0) {
    var2 = (level.mapcorners[1].origin[0], level.mapcorners[0].origin[1], level.mapcorners[1].origin[2]);
    var3 = (level.mapcorners[0].origin[0], level.mapcorners[0].origin[1], level.mapcorners[0].origin[2]);
  }

  var4 = level.mapcorners[0].origin[1];
  var5 = level.mapcorners[1].origin[1];
  var6 = (level.mapcorners[0].origin[0], level.mapcorners[1].origin[1], level.mapcorners[0].origin[2]);
  var7 = (level.mapcorners[1].origin[0], level.mapcorners[1].origin[1], level.mapcorners[1].origin[2]);

  if(var5 < var4) {
    var6 = (level.mapcorners[1].origin[0], level.mapcorners[1].origin[1], level.mapcorners[1].origin[2]);
    var7 = (level.mapcorners[0].origin[0], level.mapcorners[1].origin[1], level.mapcorners[0].origin[2]);
  }

  var8 = [];

  if(scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    level.ignorevehicleexplosivedamage = abs(distance(var7, var2));
    var9 = level.ignorevehicleexplosivedamage / 10;
    var2 = (var2[0] + var9, var2[1] - var9, var2[2]);
    var3 = (var3[0] - var9, var3[1] - var9, var3[2]);
    var6 = (var6[0] - var9, var6[1] + var9, var6[2]);
    var7 = (var7[0] + var9, var7[1] + var9, var7[2]);
    level.ignorevehicleexplosivedamage = abs(distance(var7, var2));
    var10 = 1;

    while(var10 < 4) {
      var11 = var10 * level.ignorevehicleexplosivedamage / 2;
      var12 = 1;

      while(var12 < 4) {
        var13 = var12 * level.ignorevehicleexplosivedamage / 2;
        var14 = (var7[0] + var11 / 2, var7[1] + var13 / 2, 0);
        var8 = var14;
        var12 += 2;
      }

      var10 += 2;
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
    var15 = 0.8;
    var16 = 0.5;
    var17 = var15 * var16;
    level.ref_12950[level.ref_12950.size] = (var0 * var17, var5 * var17, 0);
    level.ref_12950[level.ref_12950.size] = (var1 * var17, var5 * var17, 0);
    level.ref_12950[level.ref_12950.size] = (var1 * var17, var4 * var17, 0);
    level.ref_12950[level.ref_12950.size] = (var0 * var17, var4 * var17, 0);
  }

  level.ref_12950 = scripts\engine\utility::array_randomize(level.ref_12950);

  if(level.binoculars_checkexpirationtimer > 0 && scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    var18 = randomintrange(0, 5);
    var9 = level.ignorevehicleexplosivedamage / 10;
    var19 = level.ignorevehicleexplosivedamage / 100 / level.binoculars_checkexpirationtimer;

    switch (var18) {
      case 0:
        var20 = (var2[0] + var9, var2[1] - var9, var2[2]);
        var21 = (var3[0] - var19, var3[1] - var9, var3[2]);
        var22 = (var6[0] - var19, var6[1] + var19, var6[2]);
        var23 = (var7[0] + var9, var7[1] + var19, var7[2]);
        break;
      case 1:
        var20 = (var6[0] + var23, var6[1] - var22, var6[2]);
        var21 = (var7[0] - var22, var7[1] - var22, var7[2]);
        var22 = (var9[0] - var23, var9[1] + var22, var9[2]);
        var23 = (var19[0] + var23, var19[1] + var23, var19[2]);
        break;
      case 2:
        var20 = (var9[0] + var23, var9[1] - var23, var9[2]);
        var21 = (var19[0] - var22, var19[1] - var23, var19[2]);
        var22 = (var22[0] - var22, var22[1] + var22, var22[2]);
        var23 = (var23[0] + var23, var23[1] + var22, var23[2]);
        break;
      case 3:
        var20 = (var22[0] + var22, var22[1] - var23, var22[2]);
        var21 = (var23[0] - var23, var23[1] - var23, var23[2]);
        var22 = (var22[0] - var23, var22[1] + var22, var22[2]);
        var23 = (var23[0] + var22, var23[1] + var22, var23[2]);
        break;
      case 4:
        var20 = (var22[0] + var23, var22[1] - var23, var22[2]);
        var21 = (var23[0] - var23, var23[1] - var23, var23[2]);
        var22 = (var22[0] - var23, var22[1] + var23, var22[2]);
        var23 = (var23[0] + var23, var23[1] + var23, var23[2]);
        break;
      default:
        var20 = (var22[0] + var23, var22[1] - var23, var22[2]);
        var21 = (var23[0] - var23, var23[1] - var23, var23[2]);
        var22 = (var22[0] - var23, var22[1] + var23, var22[2]);
        var23 = (var23[0] + var23, var23[1] + var23, var23[2]);
        break;
    }

    var24 = [];
    level.ref_121bb = [];
    level.ref_121ba = abs(distance(var23, var20));
    level.ref_127de = level.ref_121ba / 2;
    var10 = 1;

    while(var10 < 4) {
      var11 = var10 * level.ref_121ba / 2;
      var12 = 1;

      while(var12 < 4) {
        var13 = var12 * level.ref_121ba / 2;
        var14 = (var23[0] + var11 / 2, var23[1] + var13 / 2, 0);
        var24 = var14;
        var12 += 2;
      }

      var10 += 2;
    }

    if(level.ref_12946 == 2) {
      level.ref_121bb = scripts\engine\utility::array_randomize(var24);
      return;
    }

    switch (var21) {
      case 0:
        if(level.ref_12946) {
          level.ref_121bb[level.ref_121bb.size] = var24[2];
          level.ref_121bb[level.ref_121bb.size] = var24[3];
          level.ref_121bb[level.ref_121bb.size] = var24[1];
          level.ref_121bb[level.ref_121bb.size] = var24[0];
        } else {
          level.ref_121bb[level.ref_121bb.size] = var24[1];
          level.ref_121bb[level.ref_121bb.size] = var24[3];
          level.ref_121bb[level.ref_121bb.size] = var24[2];
          level.ref_121bb[level.ref_121bb.size] = var24[0];
        }

        break;
      case 1:
        if(level.ref_12946) {
          level.ref_121bb[level.ref_121bb.size] = var24[0];
          level.ref_121bb[level.ref_121bb.size] = var24[2];
          level.ref_121bb[level.ref_121bb.size] = var24[3];
          level.ref_121bb[level.ref_121bb.size] = var24[1];
        } else {
          level.ref_121bb[level.ref_121bb.size] = var24[3];
          level.ref_121bb[level.ref_121bb.size] = var24[2];
          level.ref_121bb[level.ref_121bb.size] = var24[0];
          level.ref_121bb[level.ref_121bb.size] = var24[1];
        }

        break;
      case 2:
        if(level.ref_12946) {
          level.ref_121bb[level.ref_121bb.size] = var24[1];
          level.ref_121bb[level.ref_121bb.size] = var24[0];
          level.ref_121bb[level.ref_121bb.size] = var24[2];
          level.ref_121bb[level.ref_121bb.size] = var24[3];
        } else {
          level.ref_121bb[level.ref_121bb.size] = var24[2];
          level.ref_121bb[level.ref_121bb.size] = var24[0];
          level.ref_121bb[level.ref_121bb.size] = var24[1];
          level.ref_121bb[level.ref_121bb.size] = var24[3];
        }

        break;
      case 3:
        if(level.ref_12946) {
          level.ref_121bb[level.ref_121bb.size] = var24[3];
          level.ref_121bb[level.ref_121bb.size] = var24[1];
          level.ref_121bb[level.ref_121bb.size] = var24[0];
          level.ref_121bb[level.ref_121bb.size] = var24[2];
        } else {
          level.ref_121bb[level.ref_121bb.size] = var24[0];
          level.ref_121bb[level.ref_121bb.size] = var24[1];
          level.ref_121bb[level.ref_121bb.size] = var24[3];
          level.ref_121bb[level.ref_121bb.size] = var24[2];
        }

        break;
      case 4:
        level.ref_121bb = scripts\engine\utility::array_randomize(var24);
        break;
      default:
        level.ref_121bb = scripts\engine\utility::array_randomize(var24);
        break;
    }

    return;
  }
}

function play_lz_vo(var0) {
  if(getdvarint("scr_br_kiosk_distribute", 1) == 0 || !scripts\cp_mp\utility\game_utility::unsetchainkillstreaks()) {
    return var0;
  }

  var1 = getdvarfloat("scr_br_kiosk_distribute_min_per", 1);
  var2 = getdvarfloat("scr_br_kiosk_distribute_min_dist", 7000);
  var3 = var2 * var2;
  var4 = [];
  var5 = [];
  GscBinSkip0(0x2e, 0, battle_tracks_onexitvehicle((40925, -7519, 0), 49000000));
}

function play_music_to_team(var0) {
  if(getdvarint("scr_br_trader_distribute", 1) == 0 || !scripts\cp_mp\utility\game_utility::turretdisabled()) {
    return var0;
  }

  var1 = getdvarfloat("scr_br_trader_distribute_min_per", 1);
  var2 = getdvarfloat("scr_br_trader_distribute_min_dist", 7000);
  var3 = var2 * var2;
  var4 = [];

  foreach(var6 in var0) {
    var7 = 0;

    foreach(var9 in level.calloutglobals.calloutzones) {
      if(ispointinvolume(var6.origin, var9)) {
        if(!isDefined(var9.ref_13c6a)) {
          var9.ref_13c6a = [];
        }

        var7 = 1;
        var9.ref_13c6a[var9.ref_13c6a.size] = var6;
        break;
      }
    }

    if(!var7) {
      var4 = var6;
    }
  }

  foreach(var9 in level.calloutglobals.calloutzones) {
    if(!isDefined(var9.ref_13c6a) || var9.ref_13c6a.size == 0) {
      var9.ref_13c6a = undefined;
      continue;
    }

    var13 = scripts\engine\utility::array_randomize(var9.ref_13c6a);
    var4 = var13[0];
    var14 = [];
    var14 = var13[0];
    var15 = int(ceil(var13.size / var1));
    var16 = 1;

    for(var17 = 1; var17 < var13.size && var16 < var15; var17++) {
      var18 = var13[var17];
      var19 = 1;

      foreach(var21 in var14) {
        var22 = distance2dsquared(var18.origin, var21.origin);

        if(var22 < var3) {
          var19 = 0;
          break;
        }
      }

      if(var19) {
        var4 = var18;
        var14 = var18;
        var16++;
      }
    }

    var9.ref_13c6a = undefined;
  }

  return var4;
}

function battle_tracks_onexitvehicle(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;
  var2.ref_129e5 = var1;
  var2.wait_for_computer_power = [];
  return var2;
}

function player_give_intel_1_ks(var0) {
  var1 = incrementpersistentstat(level.players, self.origin, var0);

  foreach(var3 in var1) {
    if(!isDefined(var3) || !isalive(var3)) {
      continue;
    }

    if(var3 getstance() != "prone") {
      continue;
    }

    var4 = var3 getboundshalfsize();
    var0 = var4[0];
    var5 = 2 * var4[2];

    if(capsuletracepassed(var3.origin, var0, var5, undefined, 0, 0)) {
      continue;
    }

    var3 setstance("crouch", 1);
  }
}