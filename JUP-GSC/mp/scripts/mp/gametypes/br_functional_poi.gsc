/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_functional_poi.gsc
*********************************************************/

#using script_67cc94c07ab18d3a;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_bank;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_mobile_armory;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_respawn;
#using scripts\mp\gametypes\br_satellite_truck;
#using scripts\mp\poi;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\teams;
#namespace br_functional_poi;

function init() {
  flags::gameflaginit("POIs_initialized", 0);
  thread function_3e699a442af97058();
  br_plunder::init();
  br_mobile_armory::init();
  br_satellite_truck::init();
  br_armory_kiosk::init();
  br_bank::init();
  namespace_52ebf044fee9e4cd::init();
  scripts\common\callbacks::callback("br_functional_poi_init");
  flags::gameflagset("POIs_initialized");
  flags::gameflaginit("POIs_spawned", 0);
  level notify("spawning_POIs");
  waittillframeend();
  level thread _spawnpois();

  level thread initdebug();
}

function private function_3e699a442af97058() {
  if(scripts\cp_mp\structspawnconfig::init()) {
    scripts\mp\gametypes\br::function_15fa5f9b3a2b7a52();
    level waittill("ssc_config_spawned");
    scripts\mp\gametypes\br::function_84e10866b5154784();
  }
}

function initplayer(revivespawn) {
  br_plunder::initplayer(revivespawn);
}

function initdebug() {
  devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  devgui::function_a9a864379a098ad6("<dev string:x36>", "<dev string:x47>", &rerollkiosks);
  devgui::function_fe953f000498048f();
}

function onprematchdone() {
  flags::gameflagwait("POIs_spawned");
  br_mobile_armory::onprematchdone();
  br_satellite_truck::onprematchdone();
  br_armory_kiosk::onprematchdone();
  scripts\common\callbacks::callback("br_functional_poi_on_prematch_done");

  if(isDefined(level.var_ed20ae31a47f989f)) {
    [[level.var_ed20ae31a47f989f.on_prematch_done]]();
  }
}

function getinteractiveoutlineasset() {
  return "outline_depth_red";
}

function _spawnpois() {
  level endon("game_ended");
  var_4b52cea8cfcf246e = 0.05;
  var_bd889cf87f50abbd = 5;
  var_d318f12e1c67d749 = 5;
  var_ebe0ecfba3880c6a = 65;
  var_ee39b6fa3a924128 = 7;
  var_aaf40e524177e096 = 7;
  brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(brgametype == "plunder" && (level.mapname == "mp_saba" || level.mapname == "mp_saba2") || brgametype == "risk") {
    level.adjusteventdistributionpadding = getdvarint(@ "hash_325dd950793b218d", 35);
    level.pushdistributiontowardoppositecorner = getdvarint(@ "hash_e8812b2c1b71911e", 1);
    level.buystationsusepaddingdistribution = getdvarint(@ "hash_2bd779ec50609b29", 0);
    level thread setupmapquadrantcornersandgrid();
  }

  if(!getdvarint(@ "hash_28df7f89e6eab57c", 0) || !getdvarint(@ "scr_ssc_enabled", 0)) {
    level.minplunderextractions = getdvarint(@ "hash_eaacc4689dd5d721", var_aaf40e524177e096);
    level.maxplunderextractions = getdvarint(@ "hash_23f4eae3aeebefd3", var_ee39b6fa3a924128);

    if(level.minplunderextractions < level.maxplunderextractions) {
      level.maxplunderextractions = randomintrange(level.minplunderextractions, level.maxplunderextractions + 1);
    }
  }

  if((!getdvarint(@ "scr_ssc_use_buy_station", 0) || !getdvarint(@ "scr_ssc_enabled", 0)) && (!isDefined(level.br_armory_kiosk_enabled) || istrue(level.br_armory_kiosk_enabled))) {
    if(istrue(level.var_8dea6607b3189a60)) {
      scripts\mp\gametypes\br_armory_kiosk::function_e486c07c28a71f34();
    } else {
      var_9d5a5091f02c88bd = getdvarint(@ "br_max_armory_kiosk", var_ebe0ecfba3880c6a);
      kioskinstances = scripts\mp\gametypes\br_armory_kiosk::getallspawninstances();

      if(isDefined(kioskinstances) && kioskinstances.size > 0) {
        level.var_6aa304e25520289f = kioskinstances;
        kioskinstances = function_360198969036bd2a(kioskinstances);
        kioskinstances = _getlocationscircleinfluencedwithnoise(kioskinstances, var_9d5a5091f02c88bd, level.buystationsusepaddingdistribution);

        if(isDefined(kioskinstances) && kioskinstances.size > 0) {
          scripts\mp\gametypes\br_armory_kiosk::setspawninstances(kioskinstances);
          level.var_6aa304e25520289f = array_difference(level.var_6aa304e25520289f, kioskinstances);
        }
      }
    }

    scripts\mp\gametypes\br_armory_kiosk::function_86f5339f1334e16("buy_station");
  }

  if(!getdvarint(@ "hash_28df7f89e6eab57c", 0) || !getdvarint(@ "scr_ssc_enabled", 0)) {
    var_eb398f94f1b5b0f2 = br_plunder::getallextractspawninstances();

    if(isDefined(var_eb398f94f1b5b0f2) && var_eb398f94f1b5b0f2.size > 0) {
      var_eb398f94f1b5b0f2 = _getlocationscircleinfluencedwithnoise(var_eb398f94f1b5b0f2, level.maxplunderextractions, isDefined(level.paddedquadgridcenterpoints));

      if(isDefined(var_eb398f94f1b5b0f2) && var_eb398f94f1b5b0f2.size > 0) {
        br_plunder::setextractspawninstances(var_eb398f94f1b5b0f2);
      }
    }
  }

  var_aa43b883cba2c7fd = utility::getStructArray("br_respawn_station", "targetname");

  for(i = 0; i < var_aa43b883cba2c7fd.size; i++) {
    wait var_4b52cea8cfcf246e;
    br_respawn::spawnambulance(var_aa43b883cba2c7fd[i]);
  }

  var_3eaafd9e0db44ba4 = getdvarint(@ "hash_3a7e96b56579724d", var_bd889cf87f50abbd);
  mobileinstances = utility::getStructArray("br_mobile_armory_location", "targetname");

  if(mobileinstances.size > 0) {
    var_909064f7bd37eb5 = _getrandomlocations(mobileinstances, var_3eaafd9e0db44ba4);

    for(i = 0; i < var_909064f7bd37eb5.size; i++) {
      wait var_4b52cea8cfcf246e;
      br_mobile_armory::spawnmobilearmory(var_909064f7bd37eb5[i]);
    }
  }

  var_11d1cc3ed3670979 = getdvarint(@ "hash_8b6e7b7f2fa8c4a5", var_d318f12e1c67d749);
  truckinstances = utility::getStructArray("br_satellite_truck_location", "targetname");

  if(truckinstances.size > 0) {
    var_bbeceb885d5618b5 = _getrandomlocations(truckinstances, var_11d1cc3ed3670979);

    for(i = 0; i < var_bbeceb885d5618b5.size; i++) {
      wait var_4b52cea8cfcf246e;
      br_satellite_truck::spawnsatellitetruck(var_bbeceb885d5618b5[i]);
    }
  }

  flags::gameflagset("POIs_spawned");
  level notify("POIs_spawned");
}

function _getlocationscircleinfluencedwithnoise(allspawninstances, maxinstancecount, var_395f0c06f7abdcc1) {
  if(allspawninstances.size == 0 || maxinstancecount == 0) {
    return undefined;
  }

  if(maxinstancecount > allspawninstances.size) {
    maxinstancecount = allspawninstances.size;
  }

  brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(brgametype == "plunder" && (level.mapname == "mp_saba" || level.mapname == "mp_saba2") || brgametype == "risk") {
    return [[utility::getsharedfunc("plunder", "getPlunderExtractLocations")]](allspawninstances, maxinstancecount, var_395f0c06f7abdcc1);
  } else if(!isDefined(level.br_circle) || !isDefined(level.br_level)) {
    return _getrandomlocations(allspawninstances, maxinstancecount);
  }

  numcircles = level.br_level.br_circlecenters.size - 1;
  noisemax = int(max(1, numcircles * getdvarfloat(@ "hash_5455e317c3719308", 1)));

  for(i = 0; i < allspawninstances.size; i++) {
    instance = allspawninstances[i];
    noise = randomintrange(-1 * noisemax, noisemax + 1);
    instance.score = br_circle::getcircleindexforpoint(instance.origin) + noise;
  }

  instancessorted = utility::array_sort_with_func(allspawninstances, &comparescore);
  var_fdcac90056ed9215 = [];

  for(i = 0; i < maxinstancecount; i++) {
    var_fdcac90056ed9215[i] = instancessorted[i];
  }

  return utility::array_slice(instancessorted, 0, maxinstancecount);
}

function comparescore(left, right) {
  return left.score > right.score;
}

function _getrandomlocations(var_532388c61e12b9df, maxlocations) {
  if(var_532388c61e12b9df.size == 0 || maxlocations == 0) {
    return;
  }

  spawnstructs = [];

  if(var_532388c61e12b9df.size > 0) {
    var_532388c61e12b9df = utility::array_randomize(var_532388c61e12b9df);
    newarraysize = int(min(maxlocations, var_532388c61e12b9df.size));

    for(i = 0; i < newarraysize; i++) {
      spawnstructs[spawnstructs.size] = var_532388c61e12b9df[i];
    }
  }

  return spawnstructs;
}

function showmiscmessagetoteam(team, messageref, var_e951f1cf3374883d, var_8796ba8bdf940ab2) {
  if(isDefined(team)) {
    message_table = "mp/hints.csv";
    var_2a8f7b0deb4d3d93 = 1;
    messagerow = tablelookuprownum(message_table, var_2a8f7b0deb4d3d93, messageref);
    var_37690f69e01d6f71 = undefined;

    if(isDefined(var_8796ba8bdf940ab2)) {
      var_37690f69e01d6f71 = gettime() + var_8796ba8bdf940ab2;

      var_2dbc72ecf7915248 = 3;
      timerenabled = int(tablelookupbyrow(message_table, messagerow, var_2dbc72ecf7915248));
      assert(timerenabled);
    }

    teamplayers = teams::getteamdata(team, "players");

    foreach(squadmember in teamplayers) {
      squadmember lower_message::setlowermessageomnvar(messageref, var_37690f69e01d6f71, var_e951f1cf3374883d);
    }
  }
}

function initstatemachineforpoitype(poitype) {
  if(!isDefined(level.poistates)) {
    level.poistates = [];
  }

  assert(!isDefined(level.poistates[poitype]));
  level.poistates[poitype] = [];
}

function registerstatecallbacksforpoitype(poitype, stateid, onentercallback, var_bafefcb94d8333ae, onexitcallback) {
  assert(isDefined(level.poistates[poitype]));
  assert(!isDefined(level.poistates[poitype][stateid]));
  level.poistates[poitype][stateid] = spawnStruct();
  level.poistates[poitype][stateid].onenter = onentercallback;
  level.poistates[poitype][stateid].onupdate = var_bafefcb94d8333ae;
  level.poistates[poitype][stateid].onexit = onexitcallback;
}

function gotopoistate(poitype, newstate) {
  poiobject = self;

  if(isDefined(poiobject.currentstate)) {
    statecallbacks = level.poistates[poitype][poiobject.currentstate];

    if(isDefined(statecallbacks) && isDefined(statecallbacks.onexit)) {
      level[[statecallbacks.onexit]](poiobject);
    }
  }

  poiobject notify("poi_state_change");
  poiobject.currentstate = newstate;
  statecallbacks = level.poistates[poitype][poiobject.currentstate];

  if(isDefined(statecallbacks)) {
    if(isDefined(statecallbacks.onenter)) {
      level[[statecallbacks.onenter]](poiobject);
    }

    if(isDefined(statecallbacks.onupdate)) {
      poiobject thread _poistateupdate(statecallbacks.onupdate);
    }
  }
}

function gotopoistateontimer(poitype, newstate, var_ddb222c7faf5ab50) {
  poiobject = self;
  poiobject endon("death");
  poiobject endon("poi_state_change");
  wait var_ddb222c7faf5ab50;
  poiobject thread gotopoistate(poitype, newstate);
}

function getcurrentpoistate() {
  poiobject = self;
  return poiobject.currentstate;
}

function _poistateupdate(var_bafefcb94d8333ae) {
  poiobject = self;
  poiobject endon("death");
  updatingstate = poiobject.currentstate;

  while(updatingstate == poiobject.currentstate) {
    level[[var_bafefcb94d8333ae]](poiobject);
    waitframe();
  }
}

function setupmapquadrantcornersandgrid() {
  if(!isDefined(level.mapcorners)) {
    waitframe();
  }

  xmin = level.mapcorners[0].origin[0];
  xmax = level.mapcorners[1].origin[0];
  corner0 = (level.mapcorners[0].origin[0], level.mapcorners[0].origin[1], level.mapcorners[0].origin[2]);
  corner1 = (level.mapcorners[1].origin[0], level.mapcorners[0].origin[1], level.mapcorners[1].origin[2]);

  if(xmax < xmin) {
    corner0 = (level.mapcorners[1].origin[0], level.mapcorners[0].origin[1], level.mapcorners[1].origin[2]);
    corner1 = (level.mapcorners[0].origin[0], level.mapcorners[0].origin[1], level.mapcorners[0].origin[2]);
  }

  ymin = level.mapcorners[0].origin[1];
  ymax = level.mapcorners[1].origin[1];
  corner2 = (level.mapcorners[0].origin[0], level.mapcorners[1].origin[1], level.mapcorners[0].origin[2]);
  corner3 = (level.mapcorners[1].origin[0], level.mapcorners[1].origin[1], level.mapcorners[1].origin[2]);

  if(ymax < ymin) {
    corner2 = (level.mapcorners[1].origin[0], level.mapcorners[1].origin[1], level.mapcorners[1].origin[2]);
    corner3 = (level.mapcorners[0].origin[0], level.mapcorners[1].origin[1], level.mapcorners[0].origin[2]);
  }

  quadgridcenterpoints = [];

  if(game_utility::isdonetskmap()) {
    level.corner3to0dist = abs(distance(corner3, corner0));
    var_f40b5c2409b628b = level.corner3to0dist / 10;
    corner0 = (corner0[0] + var_f40b5c2409b628b, corner0[1] - var_f40b5c2409b628b, corner0[2]);
    corner1 = (corner1[0] - var_f40b5c2409b628b, corner1[1] - var_f40b5c2409b628b, corner1[2]);
    corner2 = (corner2[0] - var_f40b5c2409b628b, corner2[1] + var_f40b5c2409b628b, corner2[2]);
    corner3 = (corner3[0] + var_f40b5c2409b628b, corner3[1] + var_f40b5c2409b628b, corner3[2]);
    level.corner3to0dist = abs(distance(corner3, corner0));
    i = 1;

    while(i < 4) {
      posx = i * level.corner3to0dist / 2;
      j = 1;

      while(j < 4) {
        posy = j * level.corner3to0dist / 2;
        centerpointy = (corner3[0] + posx / 2, corner3[1] + posy / 2, 0);
        quadgridcenterpoints[quadgridcenterpoints.size] = centerpointy;
        j += 2;
      }

      i += 2;
    }
  }

  level.quadgridcenterpoints = [];

  if(level.mapname == "mp_br_mechanics") {
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (3965, 4054, 0);
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (4069, -4150, 0);
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (-4035, -4074, 0);
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (-4009, 4105, 0);
  } else if(level.mapname == "mp_br_money") {
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (46569.5, -8170, 0);
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (56849.5, -8170, 0);
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (67081.5, -17919.5, 0);
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (46593, -17919.5, 0);
  } else {
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (-21299.2, 41779.2, 0);
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (37683.2, 41779.2, 0);
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (37683.2, -17203.2, 0);
    level.quadgridcenterpoints[level.quadgridcenterpoints.size] = (-21299.2, -17203.2, 0);
  }

  level.quadgridcenterpoints = utility::array_randomize(level.quadgridcenterpoints);
  quadgridradius = 33704;
  level.quadgridradius2dsq = abs(quadgridradius * quadgridradius);

  if(level.adjusteventdistributionpadding > 0 && game_utility::isdonetskmap()) {
    level.randomcorner = randomintrange(0, 5);
    var_f40b5c2409b628b = level.corner3to0dist / 10;
    var_62090c76dab8d45a = level.corner3to0dist / 100 / level.adjusteventdistributionpadding;

    switch (level.randomcorner) {
      case 0:
        padcorner0 = (corner0[0] + var_f40b5c2409b628b, corner0[1] - var_f40b5c2409b628b, corner0[2]);
        padcorner1 = (corner1[0] - var_62090c76dab8d45a, corner1[1] - var_f40b5c2409b628b, corner1[2]);
        padcorner2 = (corner2[0] - var_62090c76dab8d45a, corner2[1] + var_62090c76dab8d45a, corner2[2]);
        padcorner3 = (corner3[0] + var_f40b5c2409b628b, corner3[1] + var_62090c76dab8d45a, corner3[2]);
        break;
      case 1:
        padcorner0 = (corner0[0] + var_62090c76dab8d45a, corner0[1] - var_f40b5c2409b628b, corner0[2]);
        padcorner1 = (corner1[0] - var_f40b5c2409b628b, corner1[1] - var_f40b5c2409b628b, corner1[2]);
        padcorner2 = (corner2[0] - var_62090c76dab8d45a, corner2[1] + var_f40b5c2409b628b, corner2[2]);
        padcorner3 = (corner3[0] + var_62090c76dab8d45a, corner3[1] + var_62090c76dab8d45a, corner3[2]);
        break;
      case 2:
        padcorner0 = (corner0[0] + var_62090c76dab8d45a, corner0[1] - var_62090c76dab8d45a, corner0[2]);
        padcorner1 = (corner1[0] - var_f40b5c2409b628b, corner1[1] - var_62090c76dab8d45a, corner1[2]);
        padcorner2 = (corner2[0] - var_f40b5c2409b628b, corner2[1] + var_f40b5c2409b628b, corner2[2]);
        padcorner3 = (corner3[0] + var_62090c76dab8d45a, corner3[1] + var_f40b5c2409b628b, corner3[2]);
        break;
      case 3:
        padcorner0 = (corner0[0] + var_f40b5c2409b628b, corner0[1] - var_62090c76dab8d45a, corner0[2]);
        padcorner1 = (corner1[0] - var_62090c76dab8d45a, corner1[1] - var_62090c76dab8d45a, corner1[2]);
        padcorner2 = (corner2[0] - var_62090c76dab8d45a, corner2[1] + var_f40b5c2409b628b, corner2[2]);
        padcorner3 = (corner3[0] + var_f40b5c2409b628b, corner3[1] + var_f40b5c2409b628b, corner3[2]);
        break;
      case 4:
        padcorner0 = (corner0[0] + var_62090c76dab8d45a, corner0[1] - var_62090c76dab8d45a, corner0[2]);
        padcorner1 = (corner1[0] - var_62090c76dab8d45a, corner1[1] - var_62090c76dab8d45a, corner1[2]);
        padcorner2 = (corner2[0] - var_62090c76dab8d45a, corner2[1] + var_62090c76dab8d45a, corner2[2]);
        padcorner3 = (corner3[0] + var_62090c76dab8d45a, corner3[1] + var_62090c76dab8d45a, corner3[2]);
        break;
      default:
        padcorner0 = (corner0[0] + var_62090c76dab8d45a, corner0[1] - var_62090c76dab8d45a, corner0[2]);
        padcorner1 = (corner1[0] - var_62090c76dab8d45a, corner1[1] - var_62090c76dab8d45a, corner1[2]);
        padcorner2 = (corner2[0] - var_62090c76dab8d45a, corner2[1] + var_62090c76dab8d45a, corner2[2]);
        padcorner3 = (corner3[0] + var_62090c76dab8d45a, corner3[1] + var_62090c76dab8d45a, corner3[2]);
        break;
    }

    var_6f5b4bc105542115 = [];
    level.paddedquadgridcenterpoints = [];
    level.padcorner3to0dist = abs(distance(padcorner3, padcorner0));
    level.pointinsquarewidth = level.padcorner3to0dist / 2;
    i = 1;

    while(i < 4) {
      posx = i * level.padcorner3to0dist / 2;
      j = 1;

      while(j < 4) {
        posy = j * level.padcorner3to0dist / 2;
        centerpointy = (padcorner3[0] + posx / 2, padcorner3[1] + posy / 2, 0);
        var_6f5b4bc105542115[var_6f5b4bc105542115.size] = centerpointy;
        j += 2;
      }

      i += 2;
    }

    if(level.pushdistributiontowardoppositecorner == 2) {
      level.paddedquadgridcenterpoints = utility::array_randomize(var_6f5b4bc105542115);
    } else {
      switch (level.randomcorner) {
        case 0:
          if(level.pushdistributiontowardoppositecorner) {
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[2];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[3];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[1];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[0];
          } else {
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[1];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[3];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[2];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[0];
          }

          break;
        case 1:
          if(level.pushdistributiontowardoppositecorner) {
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[0];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[2];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[3];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[1];
          } else {
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[3];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[2];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[0];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[1];
          }

          break;
        case 2:
          if(level.pushdistributiontowardoppositecorner) {
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[1];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[0];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[2];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[3];
          } else {
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[2];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[0];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[1];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[3];
          }

          break;
        case 3:
          if(level.pushdistributiontowardoppositecorner) {
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[3];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[1];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[0];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[2];
          } else {
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[0];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[1];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[3];
            level.paddedquadgridcenterpoints[level.paddedquadgridcenterpoints.size] = var_6f5b4bc105542115[2];
          }

          break;
        case 4:
          level.paddedquadgridcenterpoints = utility::array_randomize(var_6f5b4bc105542115);
          break;
        default:
          level.paddedquadgridcenterpoints = utility::array_randomize(var_6f5b4bc105542115);
          break;
      }
    }

    var_671bbd330e59016e = abs(distance(padcorner0, padcorner2));
    level.corner0to2dist = var_671bbd330e59016e;
    var_9f62e2ec55d8476e = var_671bbd330e59016e / 4.5;
    level.paddedquadgridradius2dsq = var_9f62e2ec55d8476e * var_9f62e2ec55d8476e;
  }
}

function function_360198969036bd2a(allspawninstances) {
  if(getdvarint(@ "scr_br_kiosk_distribute", 0) == 0) {
    return allspawninstances;
  }

  var_e0a3fb2a899ec453 = getdvarfloat(@ "hash_333f89d956059704", 1);
  var_a9b92c79b1bac699 = getdvarfloat(@ "hash_7801d124d3586409", 7000);
  var_4f367c294562db01 = var_a9b92c79b1bac699 * var_a9b92c79b1bac699;
  filtered = [];
  pois = [];

  foreach(instance in allspawninstances) {
    poi_name = poi::poi_findpoioriginisin(instance.origin);

    if(!isDefined(pois[poi_name])) {
      pois[poi_name] = [];
    }

    pois[poi_name] = utility::array_add(pois[poi_name], instance);
  }

  foreach(poi in pois) {
    kiosks = utility::array_randomize(poi);
    filtered[filtered.size] = kiosks[0];
    var_b6e95e65d2b16845 = [];
    var_b6e95e65d2b16845[0] = kiosks[0];
    var_1ee3788af637048e = int(ceil(kiosks.size / var_e0a3fb2a899ec453));
    numfound = 1;

    for(i = 1; i < kiosks.size && numfound < var_1ee3788af637048e; i++) {
      nextkiosk = kiosks[i];
      valid = 1;

      foreach(poikiosk in var_b6e95e65d2b16845) {
        distsq = distance2dsquared(nextkiosk.origin, poikiosk.origin);

        if(distsq < var_4f367c294562db01) {
          valid = 0;
          break;
        }
      }

      if(valid) {
        filtered[filtered.size] = nextkiosk;
        var_b6e95e65d2b16845[var_b6e95e65d2b16845.size] = nextkiosk;
        numfound++;
      }
    }
  }

  return filtered;
}

function rerollkiosks() {
  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    armorykiosk setscriptablepartstate("<dev string:x68>", "<dev string:x7a>");
    armorykiosk.visible = undefined;
  }

  var_9d5a5091f02c88bd = getdvarint(@ "br_max_armory_kiosk", 65);
  kioskinstances = br_armory_kiosk::getallspawninstances();

  if(isDefined(kioskinstances) && kioskinstances.size > 0) {
    kioskinstances = function_360198969036bd2a(kioskinstances);
    kioskinstances = _getlocationscircleinfluencedwithnoise(kioskinstances, var_9d5a5091f02c88bd, level.buystationsusepaddingdistribution);

    if(isDefined(kioskinstances) && kioskinstances.size > 0) {
      br_armory_kiosk::setspawninstances(kioskinstances);
    }
  }

  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    armorykiosk setscriptablepartstate("<dev string:x68>", "<dev string:x84>");
    armorykiosk.visible = 1;
  }
}

# /