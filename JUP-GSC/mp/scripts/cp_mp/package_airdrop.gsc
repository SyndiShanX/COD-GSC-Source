/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\package_airdrop.gsc
***********************************************/

#using scripts\common\anim;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\script;
#namespace package_airdrop;

function autoexec main() {
  if(getdvarint(@ "hash_3f81fafbdd04d8c9", 1) == 0) {
    return;
  }

  utility::registersharedfunc("package_airdrop", "registerPackageScriptBundle", &registerpackagescriptbundle);
  utility::registersharedfunc("package_airdrop", "startPackageTypeAirdrop", &startpackagetypeairdrop);
  utility::registersharedfunc("package_airdrop", "isPackageRegistered", &ispackageregistered);
  function_5cbc7aee073fb038();
  thread function_ca306376c1c5321c();

  thread debug_init();
}

function private function_5cbc7aee073fb038() {
  if(!isDefined(level.package_airdrop)) {
    airdrop::function_67f7a9ae6d11ad89();
  }

  if(!level.package_airdrop.enabled) {
    return;
  }

  airdrop::function_2d058528b4c8c4ce("vfx/iw9/killstreaks/carepackage/vfx_carepackage_box_fx_fade.vfx");
  airdrop::function_2d058528b4c8c4ce("vfx/iw9/killstreaks/carepackage/vfx_carepackage_base_fx_fade.vfx");
  airdrop::function_2d058528b4c8c4ce("vfx/iw9/killstreaks/carepackage/vfx_carepackage_base_fx_fade_wtr.vfx");
}

function private function_ca306376c1c5321c() {
  level waittill("prematch_started");

  if(!isDefined(level.mapcorners) || level.mapcorners.size < 2) {
    return;
  }

  minx = level.mapcorners[0].origin[0];
  maxx = level.mapcorners[1].origin[0];
  miny = level.mapcorners[1].origin[1];
  maxy = level.mapcorners[0].origin[1];
  sizex = maxx - minx;
  sizey = maxy - miny;
  var_10d9ea287534a3aa = sizex > sizey ? sizey : sizex;
  level.package_airdrop.var_18f39f7d1db2fdec = ((minx + maxx) * 0.5, (miny + maxy) * 0.5, 0);
  level.package_airdrop.var_d770bd258ede87a8 = var_10d9ea287534a3aa * 0.75;
}

function private registerpackagescriptbundle(packagetype, packagescriptbundle) {
  if(!isDefined(packagescriptbundle)) {
    scripts\mp\utility\script::demoforcesre("Could not find scriptbundle package airdrop type " + packagetype);
    return undefined;
  }

  packagescriptbundle.packagetype = packagetype;
  packagescriptbundle.var_6c96508868e4b444 = getdvarint(hashcat(@ "hash_ede242fa12584aaa", packagetype, "_min_packages"), packagescriptbundle.var_6c96508868e4b444);
  packagescriptbundle.var_93c857c1e2091c6 = getdvarint(hashcat(@ "hash_ede242fa12584aaa", packagetype, "_max_packages"), packagescriptbundle.var_93c857c1e2091c6);
  packagescriptbundle.planescount = getdvarint(hashcat(@ "hash_ede242fa12584aaa", packagetype, "_planes_count"), packagescriptbundle.planescount);
  packagescriptbundle.var_fe88e6e7c8add110 = getdvarint(hashcat(@ "hash_ede242fa12584aaa", packagetype, "_inside_plane_path_safe_circle"), packagescriptbundle.var_fe88e6e7c8add110);
  packagescriptbundle.var_c5994554ba7952fd = getdvarint(hashcat(@ "hash_ede242fa12584aaa", packagetype, "_time_to_capture"), packagescriptbundle.var_c5994554ba7952fd);
  packagescriptbundle.useparachute = getdvarint(hashcat(@ "hash_ede242fa12584aaa", packagetype, "_enable_parachute"), packagescriptbundle.useparachute);
  packagescriptbundle.var_e2ebda8aedfdb4ee = getdvarint(hashcat(@ "hash_ede242fa12584aaa", packagetype, "_icon_fading_distance"), packagescriptbundle.var_e2ebda8aedfdb4ee);
  packagescriptbundle.var_e9b6802b9c57d0f6 = getdvarint(hashcat(@ "hash_ede242fa12584aaa", packagetype, "_icon_fading_buffer"), packagescriptbundle.var_e9b6802b9c57d0f6);
  planespeed = isDefined(packagescriptbundle.planespeed) ? packagescriptbundle.planespeed : scripts\mp\gametypes\br_c130::getc130speed();
  packagescriptbundle.planespeed = getdvarint(hashcat(@ "hash_9ef969e6002dec24", packagetype, "_plane_speed"), planespeed);
  level.package_airdrop.packagetypes[packagetype] = packagescriptbundle;
  thread function_e78fdb57b9db9b1b(packagetype);
}

function private ispackageregistered(packagetype) {
  return level.package_airdrop.enabled && isDefined(level.package_airdrop.packagetypes[packagetype]);
}

function private function_e78fdb57b9db9b1b(packagetype) {
  flag_wait("airdrop_init_crate_data");
  var_66e305edfafc3376 = level.package_airdrop.packagetypes[packagetype];
  leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata(packagetype);
  leveldata.capturestring = var_66e305edfafc3376.capturestring;
  leveldata.basemodel = var_66e305edfafc3376.packagemodel;
  leveldata.mountmantlemodel = undefined;
  leveldata.headicon = undefined;
  leveldata.timeout = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.onecaptureperplayer = 1;
  leveldata.destroyoncapture = var_66e305edfafc3376.var_b60de7134e4cf75;
  leveldata.var_c23ca3472233553d = 1;
  leveldata.isdropcrate = 1;
  leveldata.activatecallback = &function_812db8f460931b6d;
  leveldata.capturecallback = &function_27cac414d4d3c400;
  leveldata.destroycallback = &function_7c7a5b4d25cb8088;
  leveldata.capturevisualscallback = &function_93bae82917bb4e13;
}

function private function_812db8f460931b6d(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }
  }
}

function private function_27cac414d4d3c400(player) {
  package = self;
  var_66e305edfafc3376 = level.package_airdrop.packagetypes[package.packagetype];

  if(isDefined(var_66e305edfafc3376.var_d628101acde803fe)) {
    player[[var_66e305edfafc3376.var_d628101acde803fe]]();
  }

  package function_3bae844feb5b2577();
  package function_fe2e6cb1a454fc82();
}

function private function_7c7a5b4d25cb8088(immediate) {
  package = self;
  package function_3bae844feb5b2577();
}

function private function_3bae844feb5b2577() {
  package = self;

  if(isDefined(package.scriptedobjid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(package.scriptedobjid);
    package.scriptedobjid = undefined;
  }

  if(isDefined(package.var_ce50f3e2d3b96e24)) {
    package.var_ce50f3e2d3b96e24 delete();
  }

  if(isDefined(level.c130successfulairdrops)) {
    level.c130successfulairdrops = array_remove(level.c130successfulairdrops, package);
  }
}

function private function_93bae82917bb4e13(model) {
  if(!isDefined(self) || !isDefined(model)) {
    return;
  }

  animtime = scripts\cp_mp\killstreaks\airdrop::getdefaultcapturevisualsdeletiondelay();
  model.animname = "care_package";
  model scripts\common\anim::setanimtree();
  model thread scripts\common\anim::anim_single_solo(model, "care_package_capture");
  playFXOnTag(level.package_airdrop.loadedeffects["vfx/iw9/killstreaks/carepackage/vfx_carepackage_box_fx_fade.vfx"], model, "tag_fx");
  model playSound("mp_care_package_retrieve_mesh_net");

  if(isDefined(animtime)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(animtime);
  }

  var_83b7b7f8ffd39ed2 = istrue(self.inwater) ? "vfx/iw9/killstreaks/carepackage/vfx_carepackage_base_fx_fade_wtr.vfx" : "vfx/iw9/killstreaks/carepackage/vfx_carepackage_base_fx_fade.vfx";
  playFXOnTag(level.package_airdrop.loadedeffects[var_83b7b7f8ffd39ed2], model, "tag_origin");
}

function private function_fe2e6cb1a454fc82() {
  package = self;
  droporigin = self.origin;
  dropangles = self.angles;
  var_66e305edfafc3376 = level.package_airdrop.packagetypes[package.packagetype];
  itemlist = var_66e305edfafc3376.lootitems;
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003(itemlist.size, 0, 0);

  foreach(item in itemlist) {
    if(isDefined(item.lootscriptable) && scripts\mp\gametypes\br_lootcache::canspawnitemname(item.lootscriptable)) {
      for(i = 0; i < item.maxquantity; i++) {
        scripts\mp\gametypes\br_lootcache::lootspawnitem(item.lootscriptable, dropstruct, droporigin, dropangles, 0, 0);
      }
    }
  }
}

function private startpackagetypeairdrop(packagetype, player, team, var_722bce9390dff899) {
  level endon("game_ended");
  assert(isDefined(level.package_airdrop) && isDefined(level.package_airdrop.packagetypes[packagetype]), "<dev string:x1c>");

  if(!isDefined(var_722bce9390dff899)) {
    var_722bce9390dff899 = spawnStruct();
  }

  packagestruct = function_2873b552d2573e1(packagetype, player, team, var_722bce9390dff899);

  if(packagestruct.var_dba2df4af15a314b <= 0) {
    return 0;
  }

  packagestruct.var_96e9e80322851e31 = function_71c88a4c8a0a869f(packagestruct);
  var_fa6df9ad7c82e13f = function_66ba30a1e828a295(packagestruct);
  packagestruct.var_734798c9f67545df = packagestruct.var_dba2df4af15a314b;

  if(var_fa6df9ad7c82e13f.size > 0) {
    var_262f27f0417668 = int(ceil(packagestruct.var_dba2df4af15a314b / var_fa6df9ad7c82e13f.size));

    foreach(plane in var_fa6df9ad7c82e13f) {
      plane.var_785e6753581c6778 = var_262f27f0417668;
      plane thread function_91ae6777b25988fb(packagestruct);
    }
  } else {
    package = function_c57fe57efd284588(packagestruct, packagestruct.var_96e9e80322851e31.origin + (0, 0, level.c130airdrop_heightoverride), undefined);

    if(!isDefined(package)) {} else {
      packagestruct.var_734798c9f67545df--;
    }
  }

  var_3213596bcb8f90ce = function_b7e318cea4f188af(var_fa6df9ad7c82e13f);

  if(var_3213596bcb8f90ce > 0) {
    wait var_3213596bcb8f90ce;
  }

  return packagestruct.var_dba2df4af15a314b - packagestruct.var_734798c9f67545df;
}

function private function_2873b552d2573e1(packagetype, player, team, var_722bce9390dff899) {
  var_ccfe9ae54c02e151 = level.package_airdrop.packagetypes[packagetype];
  packagestruct = structcopy(var_ccfe9ae54c02e151, 1);
  packagestruct.var_dba2df4af15a314b = function_fb97028ef429affa(packagetype, var_722bce9390dff899);
  packagestruct.droptype = isDefined(var_722bce9390dff899.droptype) ? var_722bce9390dff899.droptype : packagestruct.droptype;
  packagestruct.planescount = function_21d08a5b20cecd37(packagestruct, isDefined(var_722bce9390dff899.planescount) ? var_722bce9390dff899.planescount : packagestruct.planescount);
  packagestruct.planespeed = isDefined(var_722bce9390dff899.planespeed) ? var_722bce9390dff899.planespeed : packagestruct.planespeed;
  packagestruct.var_4ad76844f4a4ef50 = var_722bce9390dff899.droporigin;
  packagestruct.var_194a1b7e23d175c4 = var_722bce9390dff899.dropradius;
  packagestruct.player = player;
  packagestruct.team = team;
  packagestruct.ownerplayer = packagestruct.var_7d4f6719bd8da7f7 == "player" ? player : undefined;
  packagestruct.ownerteam = isDefined(packagestruct.ownerplayer) || packagestruct.var_7d4f6719bd8da7f7 == "team" ? team : undefined;
  return packagestruct;
}

function private function_fb97028ef429affa(packagetype, var_722bce9390dff899) {
  packagestruct = level.package_airdrop.packagetypes[packagetype];

  if(isDefined(var_722bce9390dff899.var_26b4a9a987b88fb8)) {
    return var_722bce9390dff899.var_26b4a9a987b88fb8;
  }

  var_f221f82c7799d4f0 = isDefined(var_722bce9390dff899.var_6c96508868e4b444) ? var_722bce9390dff899.var_6c96508868e4b444 : packagestruct.var_6c96508868e4b444;
  var_8b1060cf81bb1d9a = isDefined(var_722bce9390dff899.var_93c857c1e2091c6) ? var_722bce9390dff899.var_93c857c1e2091c6 : packagestruct.var_93c857c1e2091c6;
  assert(var_f221f82c7799d4f0 <= var_8b1060cf81bb1d9a, "<dev string:x70>");
  return var_f221f82c7799d4f0 < var_8b1060cf81bb1d9a ? randomintrange(var_f221f82c7799d4f0, var_8b1060cf81bb1d9a + 1) : var_8b1060cf81bb1d9a;
}

function private function_66ba30a1e828a295(packagestruct) {
  if(packagestruct.planescount <= 0) {
    return [];
  }

  switch (packagestruct.droptype) {
    case #"hash_668c7fbd8fdca4e":
      return function_82e708bd8bcc57df(packagestruct);
    case #"hash_91af18cafff306f5":
      scripts\mp\utility\script::demoforcesre("Scriptbundle Package Airdrop: Formation drop currently not supported.");
      break;
  }

  planeheight = scripts\cp_mp\parachute::getc130airdropheight();
  flightangles = (0, randomfloat(360), 0);
  var_c84c54b834c9de5 = function_e7e58d93d3d79caa(packagestruct, packagestruct.var_96e9e80322851e31, flightangles, planeheight);
  return [var_c84c54b834c9de5];
}

function private function_e7e58d93d3d79caa(packagestruct, var_96e9e80322851e31, angles, height) {
  pathstruct = scripts\mp\gametypes\br_c130::spawnc130pathstructnewinternal(var_96e9e80322851e31.origin, angles, height);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  time = dist / packagestruct.planespeed;
  plane = spawn("script_model", pathstruct.startpt);
  plane setModel(isDefined(packagestruct.planemodel) ? packagestruct.planemodel : "veh9_mil_air_cargo_plane_wm");
  plane setCanDamage(0);
  plane.maxhealth = 100000;
  plane.health = plane.maxhealth;
  plane.startpt = pathstruct.startpt;
  plane.endpt = pathstruct.endpt;
  plane.centerpt = pathstruct.centerpt;
  plane.dir = vectorNormalize(plane.endpt - plane.startpt);
  plane.angles = vectortoangles(plane.dir);
  plane.pathdist = dist;
  plane.speed = packagestruct.planespeed;
  plane.lifetime = time;
  plane.owner = packagestruct.ownerplayer;
  plane.team = packagestruct.ownerteam;
  plane.var_96e9e80322851e31 = var_96e9e80322851e31;

  if(issharedfuncdefined("game", "createObjective")) {
    plane.minimapid = plane[[getsharedfunc("game", "createObjective")]](isDefined(packagestruct.var_6feeb131440b77b5) ? packagestruct.var_6feeb131440b77b5 : "hud_icon_minimap_vehicle_cargo_plane", undefined, undefined, 1, 1);

    if(isDefined(packagestruct.var_c996d363a9173609) && isDefined(plane.minimapid) && plane.minimapid > -1) {
      rgbcolor = utility::function_24b30e4d02b6d011(packagestruct.var_c996d363a9173609);
      scripts\mp\objidpoolmanager::function_846c2acd91309cd8(plane.minimapid, rgbcolor[0], rgbcolor[1], rgbcolor[2]);
    }
  }

  if(!isDefined(packagestruct.var_4ad76844f4a4ef50)) {
    var_5d3975e1f59f125 = plane function_c1920a80da64cb98(packagestruct, var_96e9e80322851e31);

    if(isDefined(var_5d3975e1f59f125)) {
      plane.var_96e9e80322851e31 = var_5d3975e1f59f125;
    }
  }

  level.package_airdrop.activeplanes[level.package_airdrop.activeplanes.size] = plane;
  return plane;
}

function private function_b291e0ff46acfb0e(packagestruct) {
  scripts\mp\utility\script::demoforcesre("Scriptbundle Package Airdrop: Formation drop currently not supported.");
  return [];
}

function private function_82e708bd8bcc57df(packagestruct) {
  var_6a89a8b0f8e10993 = int(ceil(360 / packagestruct.planescount));
  var_728bcf13c224ddd = 250;
  planeheight = scripts\cp_mp\parachute::getc130airdropheight();
  flightangles = (0, randomfloat(360), 0);
  planes = [];

  for(i = 0; i < packagestruct.planescount; i++) {
    plane = function_e7e58d93d3d79caa(packagestruct, packagestruct.var_96e9e80322851e31, flightangles, planeheight);
    plane.dropdelay = randomfloatrange(0, plane.var_96e9e80322851e31.radius / plane.speed);
    planes[planes.size] = plane;
    planeheight += var_728bcf13c224ddd;
    flightangles = (0, (flightangles[1] + var_6a89a8b0f8e10993) % 360, 0);
  }

  return planes;
}

function private function_21d08a5b20cecd37(packagestruct, var_168340652c332ae4) {
  planescount = var_168340652c332ae4;

  switch (packagestruct.droptype) {
    case #"hash_2ddf727834fd3c24":
      planescount = 1;
      break;
    case #"hash_179b3173a873fee":
      planescount = 0;
      break;
  }

  return min(planescount, packagestruct.var_dba2df4af15a314b);
}

function private function_91ae6777b25988fb(packagestruct) {
  plane = self;
  plane.packagestruct = packagestruct;

  if(packagestruct.planesound != "") {
    self playLoopSound(packagestruct.planesound);
  }

  plane moveTo(plane.endpt, plane.lifetime);
  plane thread function_1e67232308c02026();
  return plane function_987a5e3bf9cc8431(packagestruct);
}

function private function_1e67232308c02026() {
  plane = self;
  level endon("game_ended");
  function_cf308f348d516c65(plane.lifetime - 1, plane, "death");

  if(isDefined(plane)) {
    plane playSound(self.packagestruct.var_27f313fd45e9d878);
  }

  wait 1;

  if(isDefined(plane)) {
    if(isDefined(plane.minimapid)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(plane.minimapid);
    }

    level.package_airdrop.activeplanes = array_remove(level.package_airdrop.activeplanes, plane);
    plane delete();
    return;
  }

  level.package_airdrop.activeplanes = array_removeundefined(level.package_airdrop.activeplanes);
}

function function_b7e318cea4f188af(planes) {
  var_d3c1bf89d2967d62 = 0;

  foreach(plane in planes) {
    if(var_d3c1bf89d2967d62 < plane.lifetime) {
      var_d3c1bf89d2967d62 = plane.lifetime;
    }
  }

  return var_d3c1bf89d2967d62;
}

function private function_987a5e3bf9cc8431(packagestruct) {
  plane = self;
  var_bd34ecac3ada85b = plane.startpt;
  droppoint = plane.centerpt;
  planespeed = plane.speed;
  dropwaittime = (distance2d(var_bd34ecac3ada85b, droppoint) - plane.var_96e9e80322851e31.radius) / planespeed + (isDefined(plane.dropdelay) ? plane.dropdelay : 0);
  cratedroptime = plane.var_96e9e80322851e31.radius * 2 / plane.var_785e6753581c6778 / planespeed;

  for(i = 0; i < plane.var_785e6753581c6778 && packagestruct.var_734798c9f67545df > 0; i++) {
    wait dropwaittime;
    dropwaittime = cratedroptime;
    package = function_c57fe57efd284588(packagestruct, plane.origin, plane.angles);

    if(!isDefined(package)) {
      continue;
    }

    level.c130successfulairdrops[level.c130successfulairdrops.size] = package;
    packagestruct.var_734798c9f67545df--;
  }
}

function private function_c57fe57efd284588(packagestruct, origin, angles) {
  if(isDefined(angles) && !isDefined(packagestruct.var_4ad76844f4a4ef50)) {
    origin += anglesToForward(angles) * 500;
  }

  droplocation = function_f5b281dd5f7a4aae(origin);

  if(!isDefined(droplocation)) {
    return undefined;
  }

  package = scripts\cp_mp\killstreaks\airdrop::function_dab97789e02a5320(droplocation + (0, 0, level.c130airdrop_heightoverride - 100), droplocation, angles, packagestruct.packagetype, packagestruct.ownerteam, !packagestruct.useparachute);

  if(!isDefined(package)) {
    return undefined;
  }

  package thread function_c367b00fbee9e852(packagestruct);
  package.scriptedobjid = package function_fb053429aa31fef9(packagestruct);
  package.packagetype = packagestruct.packagetype;
  triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(package);
  triggerobject.usetimeoverride = packagestruct.var_c5994554ba7952fd;
  return package;
}

function function_f5b281dd5f7a4aae(starttrace) {
  droplocation = undefined;
  endtrace = starttrace - (0, 0, 20000);
  ignorelist = level.package_airdrop.activeplanes;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignorelist, contents);

  if(isDefined(trace) && trace["hittype"] != "hittype_none") {
    droplocation = trace["position"];
  }

  if(isDefined(droplocation)) {
    validpoint = scripts\mp\gametypes\br_c130::ispointinbounds(droplocation);

    if(!istrue(validpoint)) {
      droplocation = undefined;
    }
  }

  return droplocation;
}

function private function_c367b00fbee9e852(packagestruct) {
  package = self;

  if(!isDefined(packagestruct.var_a9b8bcc86865726f)) {
    return;
  }

  package.var_ce50f3e2d3b96e24 = spawn("script_model", package.destination);
  package.var_ce50f3e2d3b96e24 setModel("tag_origin");
  package.var_ce50f3e2d3b96e24 forcenetfieldhighlod(1);

  if(packagestruct.var_37e362c5ada9087b != "") {
    package.var_ce50f3e2d3b96e24 playSound("smoke_carepackage_expl_trans");
    package.var_ce50f3e2d3b96e24 playLoopSound(packagestruct.var_37e362c5ada9087b);
  }

  waitframe();
  package.var_ce50f3e2d3b96e24.var_2643a0dd534a7787 = playFXOnTag(level.package_airdrop.loadedeffects[packagestruct.var_a9b8bcc86865726f], package.var_ce50f3e2d3b96e24, "tag_origin");
}

function private function_fb053429aa31fef9(packagestruct) {
  if(isDefined(packagestruct.var_ef16dcb12768aa27)) {
    package = self;
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", package.origin, packagestruct.var_ef16dcb12768aa27);
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(objid, 1);
      scripts\mp\objidpoolmanager::update_objective_onentity(objid, package);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 75);
      scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
      scripts\mp\objidpoolmanager::function_98ba077848896a3(objid, 1);
      scripts\mp\objidpoolmanager::function_f21e9b2e78de984b(objid, packagestruct.var_e2ebda8aedfdb4ee - packagestruct.var_e9b6802b9c57d0f6, packagestruct.var_e2ebda8aedfdb4ee);
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);

      if(isDefined(packagestruct.var_2e50724a9c6aa68f)) {
        rgbcolor = utility::function_24b30e4d02b6d011(packagestruct.var_2e50724a9c6aa68f);
        scripts\mp\objidpoolmanager::function_846c2acd91309cd8(objid, rgbcolor[0], rgbcolor[1], rgbcolor[2]);
      }

      if(isDefined(packagestruct.var_2ee59895d237b340)) {
        scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1(objid, packagestruct.var_2ee59895d237b340);
      }

      return objid;
    }
  }

  return undefined;
}

function private function_71c88a4c8a0a869f(packagestruct) {
  var_96e9e80322851e31 = spawnStruct();

  if(isDefined(packagestruct.var_4ad76844f4a4ef50)) {
    var_96e9e80322851e31.origin = packagestruct.var_4ad76844f4a4ef50;
    var_96e9e80322851e31.radius = isDefined(packagestruct.var_194a1b7e23d175c4) ? packagestruct.var_194a1b7e23d175c4 : 1;
    return var_96e9e80322851e31;
  } else {
    var_add352c5f28c902a = function_10353e2ca468d363();

    switch (packagestruct.droplocationtype) {
      case #"hash_87d1443ef2805760":
        if(isDefined(packagestruct.ownerplayer)) {
          var_96e9e80322851e31.origin = packagestruct.ownerplayer.origin;
          var_96e9e80322851e31.radius = 50;
          break;
        }
      case #"hash_33857c6e26098e6c":
        if(isDefined(packagestruct.ownerteam)) {
          scripts\mp\utility\script::demoforcesre("Scriptbunle Package Airdrop: Team drop location not currently supported: " + packagestruct.packagetype);
        }
      case #"hash_bf1a695c21e57fe4":
        var_96e9e80322851e31 = var_add352c5f28c902a;
        break;
      case #"hash_82dd7c3e206217c2":
        if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
          var_96e9e80322851e31.origin = scripts\mp\gametypes\br_circle::getrandompointinsafecircle();
          var_96e9e80322851e31.radius = var_add352c5f28c902a.radius - distance2d(var_96e9e80322851e31.origin, var_add352c5f28c902a.origin);
        }

        break;
      default:
        scripts\mp\utility\script::demoforcesre("Scriptbunle Package Airdrop: Drop location type not supported" + packagestruct.packagetype);
        var_96e9e80322851e31 = var_add352c5f28c902a;
        break;
    }
  }

  return var_96e9e80322851e31;
}

function private function_10353e2ca468d363() {
  circle = spawnStruct();

  if(isDefined(level.var_e486acb8f70c45a2) && flag("chokehold_closed")) {
    circle.origin = (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
    circle.radius = level.br_circle.dangercircleent.origin[2];
  } else if(istrue(level.var_2df69b8e552238b6)) {
    circle.origin = level.br_level.br_circlecenters[level.br_circle.circleindex + 1];
    circle.radius = level.br_level.br_circleradii[level.br_circle.circleindex + 1];
  } else if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    circle.origin = (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0);
    circle.radius = level.br_circle.safecircleent.origin[2];
  } else if(isDefined(level.br_level) && isDefined(level.br_level.br_mapcenter)) {
    circle.origin = level.br_level.br_mapcenter + scripts\mp\gametypes\br_c130::function_1f389456d7c530a();
    circle.radius = scripts\mp\gametypes\br_c130::getplanepathsaferadiusfromcenter();
  } else if(isDefined(level.package_airdrop.var_18f39f7d1db2fdec)) {
    circle.origin = level.package_airdrop.var_18f39f7d1db2fdec;
    circle.radius = level.package_airdrop.var_d770bd258ede87a8;
  } else {
    scripts\mp\utility\script::demoforcesre("Scriptbunle Package Airdrop: Could not find any valid map center");
  }

  return circle;
}

function private function_c1920a80da64cb98(packagestruct, var_96e9e80322851e31) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return var_96e9e80322851e31;
  }

  if(packagestruct.droplocationtype != "center" && packagestruct.droplocationtype != "random") {
    return var_96e9e80322851e31;
  }

  var_b3d62ab023b59bf6 = level.br_level.br_mapcenter + scripts\mp\gametypes\br_c130::function_1f389456d7c530a();
  var_6d7e4cc332c6d081 = scripts\mp\gametypes\br_c130::getplanepathsaferadiusfromcenter();
  var_8e0605cb0d8ae85e = math::function_d2c0d8330ab7ad7f(self.startpt, self.endpt, var_96e9e80322851e31.origin, var_96e9e80322851e31.radius);
  var_690b677ae1ff4e7c = math::function_d2c0d8330ab7ad7f(self.startpt, self.endpt, var_b3d62ab023b59bf6, var_6d7e4cc332c6d081);

  if(!isDefined(var_8e0605cb0d8ae85e) || !isDefined(var_690b677ae1ff4e7c) || var_690b677ae1ff4e7c.size < 2) {
    return var_96e9e80322851e31;
  }

  dropstart = math::function_3932a34161ac799(self.startpt, var_8e0605cb0d8ae85e, var_690b677ae1ff4e7c);
  dropend = math::function_3932a34161ac799(self.endpt, var_8e0605cb0d8ae85e, var_690b677ae1ff4e7c);
  self.centerpt = (dropstart + dropend) / 2;
  var_e3dab130cbd389fa = structcopy(var_96e9e80322851e31);
  var_e3dab130cbd389fa.radius = int(max(1, distance2d(dropstart, self.centerpt) - 50));
  return var_e3dab130cbd389fa;
}

function debug_init() {
  wait 1;

  if(!isDefined(level.package_airdrop.packagetypes) || level.package_airdrop.packagetypes.size <= 0) {
    return;
  }

  droptypes = ["<dev string:xdd>", "<dev string:xed>", "<dev string:xfd>", "<dev string:x10c>"];

  foreach(droptype in droptypes) {
    scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x11f>" + droptype + "<dev string:x13e>");

    foreach(packagename, packagetype in level.package_airdrop.packagetypes) {
      scripts\common\devgui::function_b23a59dfb4ca49a1(packagename, packagename + "<dev string:x143>" + packagename + "<dev string:x143>" + droptype, &function_b56e024a85b1ba22);
    }

    scripts\common\devgui::function_fe953f000498048f();
  }
}

function function_b56e024a85b1ba22(params) {
  packagetype = params[0];
  airdroptype = params[1];
  packagestruct = level.package_airdrop.packagetypes[packagetype];
  var_722bce9390dff899 = spawnStruct();
  var_722bce9390dff899.droptype = airdroptype;

  if(isdvardefined(@ "hash_9783c1c17e0b4fd0")) {
    var_722bce9390dff899.planescount = getdvarint(@ "hash_9783c1c17e0b4fd0", packagestruct.planescount);
    var_722bce9390dff899.var_6c96508868e4b444 = int(max(var_722bce9390dff899.planescount, packagestruct.var_6c96508868e4b444));
    var_722bce9390dff899.var_93c857c1e2091c6 = int(max(var_722bce9390dff899.var_6c96508868e4b444, packagestruct.var_93c857c1e2091c6));
  }

  thread startpackagetypeairdrop(packagetype, undefined, undefined, var_722bce9390dff899);
}

# /