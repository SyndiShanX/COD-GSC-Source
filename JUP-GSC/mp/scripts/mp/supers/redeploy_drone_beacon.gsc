/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\redeploy_drone_beacon.gsc
*******************************************************/

#using script_608c50392df8c7d1;
#using script_610f57bddd265be2;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace redeploy_drone_beacon;

function private autoexec main() {
  level callback::add(#"register_super", &function_75599f41276484c2);
}

function private function_75599f41276484c2(params) {
  if(isDefined(params.var_47ce480103f7129f)) {
    level.var_b2b35840c12ce55c["redeploy_drone_beacon"] = &function_390bae294ff550a6;
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("super_redeploy_drone_beacon", &function_440dc164f57736cc);
    scripts\engine\utility::registersharedfunc(#"hash_7c77f410582a71b4", #"hash_3dd4fa0f710a2eff", &function_65be01ee23f70213);
    initvariables();

    initdevgui();
  }
}

function private initvariables() {
  level.var_4a77e3d00962be2 = spawnStruct();
  level.var_4a77e3d00962be2.var_c19b8ce5116231f = [];
  level.var_4a77e3d00962be2.var_c97f0d10fd296be9 = [];
  level.var_4a77e3d00962be2.var_733bd4c6564c29ac = function_ccda6348f3b3740a();
  level.var_4a77e3d00962be2.var_275b7412d175660b = getdvarfloat(@ "hash_fd4c74dc92420799", 60);
  level.var_4a77e3d00962be2.var_ec4cd7925159b233 = getdvarfloat(@ "hash_b44a498da7e9c4b9", 60);
  level.var_4a77e3d00962be2.var_e3ca47ee33036fa = getdvarint(@ "hash_fc527cb8aae04365");
  level.var_4a77e3d00962be2.var_6bca48baec64109c = getdvarint(@ "hash_936a0d8dbe3e4d50", 0);
  level.var_4a77e3d00962be2.superbundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_redeploy_drone_beacon");
  character = 0;
  world = 1;
  glass = 1;
  shotclip = 1;
  item = 0;
  vehicle = 1;
  playerclip = 1;
  ainosight = 0;
  itemclip = 0;
  vehicleclip = 1;
  waterclip = 0;
  cameraclip = 0;
  level.var_4a77e3d00962be2.physicscontents = scripts\engine\trace::create_contents(character, world, glass, shotclip, item, vehicle, playerclip, ainosight, itemclip, vehicleclip, waterclip, cameraclip);
  function_6893bcf648dabb43();
  function_d3323396f592c0ea();
}

function private getbrushmodel(targetname) {
  brushmodel = undefined;
  var_d6fb05359f76784e = getEntArray(targetname, "targetname");

  if(isDefined(var_d6fb05359f76784e) && var_d6fb05359f76784e.size > 0) {
    brushmodel = var_d6fb05359f76784e[0];
  }

  return brushmodel;
}

function private function_6893bcf648dabb43() {
  level.var_4a77e3d00962be2.var_477de27131738e4c = [];
  level.var_4a77e3d00962be2.var_477de27131738e4c[0] = getbrushmodel("dynamic_redeploy_drone");

  if(!isDefined(level.var_4a77e3d00962be2.var_477de27131738e4c[0])) {
    level.var_4a77e3d00962be2.var_477de27131738e4c[0] = getbrushmodel("dynamic_redeploy_drone_high");
  }

  level.var_4a77e3d00962be2.var_477de27131738e4c[2] = getbrushmodel("dynamic_redeploy_drone_short");
  level.var_4a77e3d00962be2.var_477de27131738e4c[3] = getbrushmodel("dynamic_redeploy_drone_very_short");
  level.var_4a77e3d00962be2.var_6395f1ed044d892d = [];

  foreach(dronetype, brushmodel in level.var_4a77e3d00962be2.var_477de27131738e4c) {
    if(isDefined(brushmodel)) {
      zoffset = (brushmodel.origin - brushmodel getpointinbounds(0, 0, -1))[2];
      level.var_4a77e3d00962be2.var_6395f1ed044d892d[dronetype] = (0, 0, zoffset);
    }
  }
}

function private function_d3323396f592c0ea() {
  level.var_4a77e3d00962be2.movementparameters = spawnStruct();
  level.var_4a77e3d00962be2.movementparameters.var_5f59cdfbf4669cc3 = getdvarint(@ "hash_521bf4fafecb1dca", 60);
  level.var_4a77e3d00962be2.movementparameters.var_73e374ce21fb4fb5 = getdvarint(@ "hash_88b474bd6434b0a1", 200);
  level.var_4a77e3d00962be2.movementparameters.var_64ab0a075a4d97e4 = getdvarfloat(@ "hash_b62baf4cdccb0ac4", 500);
  level.var_4a77e3d00962be2.movementparameters.var_f9b853a2bbd2f0d8 = getdvarfloat(@ "hash_d4bce7a24c7fce3", 0.03);
  level.var_4a77e3d00962be2.movementparameters.var_27ac068509a4d0ed = getdvarfloat(@ "hash_1aa5e66fc225fe8d", 10);
  level.var_4a77e3d00962be2.movementparameters.var_ae12b50991636b8c = getdvarfloat(@ "hash_c30189c200d92109", 0.5);
  level.var_4a77e3d00962be2.movementparameters.var_92f5e0dfc7e45f70 = getdvarfloat(@ "hash_9a3a9642c10c1abb", 0.7);
  level.var_4a77e3d00962be2.movementparameters.var_1f674850357ba893 = 1;
}

function private function_ccda6348f3b3740a() {
  if(isdvardefined(@ "hash_44fc3109edd021d8")) {
    var_a63d1a30ca2a83fa = getdvarint(@ "hash_44fc3109edd021d8");
  } else {
    var_6fc6776b75a85f30 = function_8c54b20b88b27071();
    var_a63d1a30ca2a83fa = default_to(var_6fc6776b75a85f30, 3000);
  }

  return var_a63d1a30ca2a83fa;
}

function private function_8c54b20b88b27071() {
  var_8995380e89c9aae7 = namespace_2c2703f78fc59600::function_fb714d8704f1953a();
  var_90413b36e94416d7 = -2147483647;
  var_d111aee19c5db833 = 0;

  if(isDefined(var_8995380e89c9aae7) && var_8995380e89c9aae7.size > 0) {
    foreach(redeploydrone in var_8995380e89c9aae7) {
      if(isDefined(redeploydrone) && isDefined(redeploydrone.origin) && var_90413b36e94416d7 < redeploydrone.origin[2]) {
        var_90413b36e94416d7 = redeploydrone.origin[2];
        var_d111aee19c5db833 = 1;
      }
    }
  }

  return ter_op(var_d111aee19c5db833, var_90413b36e94416d7, undefined);
}

function private function_65be01ee23f70213() {
  if(isDefined(level.var_4a77e3d00962be2) && isDefined(level.var_4a77e3d00962be2.var_c19b8ce5116231f)) {
    return level.var_4a77e3d00962be2.var_c19b8ce5116231f;
  }

  return [];
}

function private function_4315faf8afe96a33(messageref, var_4e3e03cb567ca764) {
  player = self;

  if(istrue(var_4e3e03cb567ca764)) {
    player playlocalsound("br_pickup_deny");
  }

  player scripts\mp\utility\lower_message::setlowermessageomnvar(messageref, undefined, 5);
}

function private function_5199f28630af211e() {
  player = self;
  candeploy = 1;
  failurereason = "";

  if(player isswimming()) {
    candeploy = 0;
    failurereason = "redeploy_drone_beacon_player_swimming";
  }

  return [candeploy, failurereason];
}

function private function_390bae294ff550a6(grenade) {
  player = self;
  beacon = grenade;

  if(!isDefined(beacon)) {
    return;
  }

  beacon endon("death");
  level endon("game_ended");
  beacon.bundle = level.var_4a77e3d00962be2.superbundle;
  function_c00efa701df608a0(player);

  if(isDefined(player)) {
    level.var_4a77e3d00962be2.var_c97f0d10fd296be9[player getentitynumber()] = beacon;
  }

  beacon waittill("missile_stuck");
  beacon thread scripts\mp\damage::monitordamage(beacon.bundle.maxhealth, "hitequip", &function_8504f78b7c008417, &function_79a97ee01dc267d3, 0);
  beacon scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_9d6c964e1422e8d1);
  [var_9879c458a14bced3, var_e43451c4c85f5b88] = function_b81276900edb7462(beacon.origin);
  [var_e2c8e19de00c206, failurereason] = function_aa3fa59493648c40(beacon, var_e43451c4c85f5b88);

  thread function_391adac64d5fa47(player, beacon, var_e43451c4c85f5b88);

  if(var_e2c8e19de00c206) {
    beacon setscriptablepartstate("super_redeploy_drone_beacon", "connected_to_drone");
    thread function_336fd2600db11346(beacon, var_e43451c4c85f5b88, var_9879c458a14bced3, player);
    scripts\cp_mp\challenges::onuseitem("redeploy_beacon");
    scripts\cp_mp\challenges::function_d997435895422ecc("super_personal_redeploy_drone", ae_utility::function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
    return;
  }

  beacon setscriptablepartstate("super_redeploy_drone_beacon", "disconnected_from_drone");
  beacon function_e64b345150b671df(player);
  beacon.headiconid = beacon scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 10);
  thread function_664ee2d91914fe61(beacon);
  function_4315faf8afe96a33(failurereason);
  level thread scripts\mp\gametypes\br_analytics::function_2053c090ebbe2e31(0);
}

function private function_c00efa701df608a0(player) {
  beacon = undefined;

  if(isDefined(player)) {
    beacon = level.var_4a77e3d00962be2.var_c97f0d10fd296be9[player getentitynumber()];
  }

  function_3a022f8c2f99b818(beacon);
}

function private function_8504f78b7c008417(data) {
  beacon = self;
  beacon function_529161497b92ec7f(data.attacker);
  function_3a022f8c2f99b818(self);
}

function private function_b81276900edb7462(positiononground) {
  var_6f5a566eda6020ce = positiononground[2];
  var_9879c458a14bced3 = undefined;
  cablelength = undefined;

  var_704389eea57812cf = getDvar(@ "hash_a020da1472e07198", "<dev string:x1c>");

  if(var_704389eea57812cf == "<dev string:x20>" || var_704389eea57812cf == "<dev string:x2b>") {
    var_9879c458a14bced3 = 0;
    cablelength = 2744;
    return [var_9879c458a14bced3, cablelength];
  } else if(var_704389eea57812cf == "<dev string:x35>") {
    var_9879c458a14bced3 = 2;
    cablelength = 2254;
    return [var_9879c458a14bced3, cablelength];
  } else if(var_704389eea57812cf == "<dev string:x3e>" || var_704389eea57812cf == "<dev string:x4c>") {
    var_9879c458a14bced3 = 3;
    cablelength = 1636;
    return [var_9879c458a14bced3, cablelength];
  }

  if(var_6f5a566eda6020ce + 2744 <= level.var_4a77e3d00962be2.var_733bd4c6564c29ac) {
    var_9879c458a14bced3 = 0;
    cablelength = 2744;
  } else if(var_6f5a566eda6020ce + 2254 <= level.var_4a77e3d00962be2.var_733bd4c6564c29ac) {
    var_9879c458a14bced3 = 2;
    cablelength = 2254;
  } else {
    var_9879c458a14bced3 = 3;
    cablelength = 1636;
  }

  if(!isDefined(level.var_4a77e3d00962be2.var_477de27131738e4c[var_9879c458a14bced3])) {
    var_9879c458a14bced3 = 0;
    cablelength = 2744;
  }

  return [var_9879c458a14bced3, cablelength];
}

function private function_aa3fa59493648c40(beacon, var_e43451c4c85f5b88) {
  canspawn = 1;
  failurereason = "";
  var_7ca34bfe0bc687c0 = default_to(level.var_fc4bb27a820f54dd.var_858ba27e4dbd844c, []);
  var_7ca34bfe0bc687c0[var_7ca34bfe0bc687c0.size] = beacon;

  if(istrue(level.var_4a77e3d00962be2.var_e3ca47ee33036fa) && level.var_4a77e3d00962be2.var_c19b8ce5116231f.size >= level.var_4a77e3d00962be2.var_e3ca47ee33036fa) {
    candeploy = 0;
    failurereason = "redeploy_drone_beacon_max_drones_limit_reached";
  } else if(beacon islinked()) {
    canspawn = 0;
    failurereason = "redeploy_drone_beacon_moving_platforms_not_allowed";
  } else if(scripts\mp\outofbounds::ispointinoutofbounds(beacon.origin)) {
    canspawn = 0;
    failurereason = "redeploy_drone_beacon_oob";
  } else if(!function_d0685499a8f0c239(beacon, var_e43451c4c85f5b88, var_7ca34bfe0bc687c0)) {
    canspawn = 0;
    failurereason = "redeploy_drone_beacon_insufficient_space";
  } else if(!function_359418189c5933ae(beacon, var_e43451c4c85f5b88, var_7ca34bfe0bc687c0)) {
    canspawn = 0;
    failurereason = "redeploy_drone_beacon_insufficient_space";
  }

  return [canspawn, failurereason];
}

function private function_d0685499a8f0c239(beacon, var_c1ae356f3991b37, var_7ca34bfe0bc687c0) {
  var_53d95aa12f63dcd = beacon.origin;
  var_69ee1aba18e8558c = 1;
  var_a6eb1b67d7b5a471 = var_53d95aa12f63dcd + (-90, -90, var_c1ae356f3991b37 - 50);
  var_a70e2d67d7dc13bf = var_53d95aa12f63dcd + (90, 90, var_c1ae356f3991b37 + 50);
  hashit = physics_aabbquery(var_a6eb1b67d7b5a471, var_a70e2d67d7dc13bf, level.var_4a77e3d00962be2.physicscontents, var_7ca34bfe0bc687c0, "physicsquery_any", var_69ee1aba18e8558c);
  return !istrue(hashit);
}

function private function_359418189c5933ae(beacon, var_c1ae356f3991b37, var_7ca34bfe0bc687c0) {
  [cablestartposition, cableendposition, sphereradius] = function_e3ed19e8256d0323(beacon, var_c1ae356f3991b37);
  hasfreespace = scripts\engine\trace::sphere_trace_passed(cablestartposition, cableendposition, sphereradius, var_7ca34bfe0bc687c0, level.var_4a77e3d00962be2.physicscontents);
  return istrue(hasfreespace);
}

function private function_e3ed19e8256d0323(beacon, var_c1ae356f3991b37) {
  var_1c806edea6ab9425 = 72;
  sphereradius = 32 * 0.7;
  cablestartposition = beacon.origin + (0, 0, var_c1ae356f3991b37);
  cableendposition = beacon.origin + (0, 0, var_1c806edea6ab9425 + sphereradius);
  return [cablestartposition, cableendposition, sphereradius];
}

function private function_336fd2600db11346(beacon, var_88986f82b7321745, var_9879c458a14bced3, ownerplayer) {
  level endon("game_ended");
  function_2f12bf57948c0ee7(ownerplayer);
  var_6cc7c7c4978597ad = function_53af621b4742ea1a(beacon, var_88986f82b7321745, var_9879c458a14bced3);
  var_6cc7c7c4978597ad thread watchgameended();
  var_6cc7c7c4978597ad thread function_c1069f1ca1ed8fb3();
  var_20b0d11891329487 = function_f1cd2c473addb49(ownerplayer, var_6cc7c7c4978597ad.origin);
  var_43deb00a486b70d4 = undefined;
  var_1f47ee8f1ad1320b = var_6cc7c7c4978597ad;
  var_73182d93936ed805 = 1;

  function_d3323396f592c0ea();

  var_a94c8546fb678b4b = namespace_2c2703f78fc59600::function_ce1ac8102a9fc02e(var_20b0d11891329487, var_43deb00a486b70d4, var_1f47ee8f1ad1320b, var_9879c458a14bced3, var_73182d93936ed805, level.var_4a77e3d00962be2.movementparameters);

  if(istrue(var_a94c8546fb678b4b)) {
    var_6cc7c7c4978597ad namespace_2c2703f78fc59600::function_ca6ea48c877cd367();
    var_6cc7c7c4978597ad function_a98c5a0487bcd428();
    var_6cc7c7c4978597ad thread function_b76a806bd4d7dec9(var_9879c458a14bced3);
    var_6cc7c7c4978597ad thread function_20f4ea786458af6a(var_9879c458a14bced3);
    var_6cc7c7c4978597ad thread function_8dc483f62b72804e(ownerplayer);
    var_6cc7c7c4978597ad thread function_bbc57fd5659b49c2(beacon);

    if(isDefined(beacon)) {
      beacon setscriptablepartstate("super_redeploy_drone_beacon", "inactive");
    }

    return;
  }

  function_88e0d424c8a772b(var_6cc7c7c4978597ad);
}

function private function_f1cd2c473addb49(ownerplayer, var_d1c48e73f2053374) {
  if(!isDefined(ownerplayer)) {
    return (var_d1c48e73f2053374 + (0, 0, 2800));
  }

  horizontaldir = var_d1c48e73f2053374 - ownerplayer.origin;
  horizontaldir = vectornormalize2(horizontaldir);
  return var_d1c48e73f2053374 + (horizontaldir[0] * -500, horizontaldir[1] * -500, 2800);
}

function private function_e64b345150b671df(ownerplayer) {
  beacon = self;

  if(isDefined(ownerplayer)) {
    beacon enablescriptableplayeruse(ownerplayer);
  }

  foreach(player in level.players) {
    if(isDefined(player)) {
      if(!isDefined(ownerplayer) || player != ownerplayer) {
        beacon disablescriptableplayeruse(player);
      }
    }
  }
}

function private function_53af621b4742ea1a(beacon, var_88986f82b7321745, var_9879c458a14bced3) {
  var_5aa1c7cf87120965 = beacon.origin;
  spawnposition = var_5aa1c7cf87120965 + (0, 0, var_88986f82b7321745);
  var_e36f5762cbb77971 = ["scriptable_redeploy_drone", "scriptable_redeploy_drone_extended", "scriptable_redeploy_drone_short", "scriptable_redeploy_drone_very_short"];
  scriptablename = var_e36f5762cbb77971[var_9879c458a14bced3];
  stationarydrone = spawnscriptable(scriptablename, spawnposition);
  assert(isDefined(stationarydrone));
  stationarydrone setscriptablepartstate("redeploy_drone", "unavailable");
  stationarydrone.var_7a6430ba88c4d983 = var_5aa1c7cf87120965;
  stationarydrone.var_47d27267be4655fb = 1;
  stationarydrone.beacon = beacon;
  stationarydrone.var_d77822da7628823 = 1;
  stationarydrone.var_9879c458a14bced3 = var_9879c458a14bced3;
  level.var_4a77e3d00962be2.var_c19b8ce5116231f = array_add(level.var_4a77e3d00962be2.var_c19b8ce5116231f, stationarydrone);
  level thread scripts\mp\gametypes\br_analytics::function_2053c090ebbe2e31(1);
  return stationarydrone;
}

function private function_a98c5a0487bcd428() {
  stationarydrone = self;
  assert(isDefined(level.var_4a77e3d00962be2.var_477de27131738e4c[stationarydrone.var_9879c458a14bced3]), "<dev string:x59>");
  var_5aa1c7cf87120965 = stationarydrone.var_7a6430ba88c4d983;
  var_c8ae7ccab7d5cc90 = var_5aa1c7cf87120965 + level.var_4a77e3d00962be2.var_6395f1ed044d892d[stationarydrone.var_9879c458a14bced3];
  stationarydrone.brushmodel = spawn("script_model", var_c8ae7ccab7d5cc90);
  stationarydrone.brushmodel clonebrushmodeltoscriptmodel(level.var_4a77e3d00962be2.var_477de27131738e4c[stationarydrone.var_9879c458a14bced3]);
}

function private function_20f4ea786458af6a(var_9879c458a14bced3) {
  var_6cc7c7c4978597ad = self;

  if(!isDefined(var_6cc7c7c4978597ad.brushmodel)) {
    return;
  }

  level endon("game_ended");
  var_6cc7c7c4978597ad endon("death");
  var_6cc7c7c4978597ad endon("redeploy_drone_destroyed");

  while(true) {
    var_6cc7c7c4978597ad.brushmodel waittill("touching_platform");

    if(var_6cc7c7c4978597ad getscriptablepartstate("redeploy_drone") == "available") {
      var_6cc7c7c4978597ad.var_afe0331c2ce31aec = 1;
      var_6cc7c7c4978597ad notify("force_drone_departure");
      return;
    }

    waitframe();
  }
}

function private function_2f12bf57948c0ee7(ownerplayer) {
  if(!isDefined(ownerplayer)) {
    return;
  }

  var_ec2736524e4a7410 = scripts\mp\utility\teams::getteamdata(ownerplayer.team, "alivePlayers");

  foreach(var_ee6c059b02d759a in var_ec2736524e4a7410) {
    if(!isDefined(var_ee6c059b02d759a) || istrue(var_ee6c059b02d759a scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) || istrue(var_ee6c059b02d759a.extracted) || isbot(var_ee6c059b02d759a)) {
      continue;
    }

    if(istrue(level.var_4a77e3d00962be2.var_6bca48baec64109c) && var_ee6c059b02d759a == ownerplayer) {
      continue;
    }

    var_ee6c059b02d759a thread scripts\mp\hud_message::showsplash("br_redeploy_drone_beacon_notification", undefined, ownerplayer);
  }
}

function private function_8dc483f62b72804e(var_6cca95858a117d69) {
  var_6cc7c7c4978597ad = self;

  if(!isDefined(var_6cca95858a117d69)) {
    return;
  }

  level endon("game_ended");
  var_6cca95858a117d69 endon("death_or_disconnect");
  var_6cc7c7c4978597ad endon("death");
  var_6cc7c7c4978597ad endon("redeploy_drone_destroyed");

  while(true) {
    var_6cc7c7c4978597ad waittill("redeploy_drone_scriptable_used", var_df86ca3cbac0af0c);

    if(isDefined(var_df86ca3cbac0af0c) && var_df86ca3cbac0af0c.team == var_6cca95858a117d69.team && var_df86ca3cbac0af0c != var_6cca95858a117d69) {
      var_6cca95858a117d69 scripts\mp\utility\points::doscoreevent(#"hash_620e56712709c31a");
    }
  }
}

function private function_bbc57fd5659b49c2(beacon) {
  var_6cc7c7c4978597ad = self;
  level endon("game_ended");
  var_6cc7c7c4978597ad endon("death");
  var_6cc7c7c4978597ad endon("redeploy_drone_destroyed");

  if(isDefined(beacon)) {
    beacon waittill("death");
  }

  var_6cc7c7c4978597ad notify("force_drone_departure");
}

function private function_88e0d424c8a772b(var_6cc7c7c4978597ad) {
  level.var_4a77e3d00962be2.var_c19b8ce5116231f = array_remove(level.var_4a77e3d00962be2.var_c19b8ce5116231f, var_6cc7c7c4978597ad);

  if(var_6cc7c7c4978597ad getscriptablepartstate("redeploy_drone") == "available") {
    var_6cc7c7c4978597ad namespace_2c2703f78fc59600::function_80ce8f3739b7a346();
  }

  function_b8f20ce3b3f59440(var_6cc7c7c4978597ad.brushmodel);
  function_3a022f8c2f99b818(var_6cc7c7c4978597ad.beacon);
  var_6cc7c7c4978597ad freescriptable();
  level thread scripts\mp\gametypes\br_analytics::function_e02dbe00c1c7d0d7();
  var_6cc7c7c4978597ad notify("death");
}

function private function_b8f20ce3b3f59440(brushmodel) {
  if(isDefined(brushmodel)) {
    brushmodel delete();
  }
}

function private watchgameended() {
  var_6cc7c7c4978597ad = self;
  var_6cc7c7c4978597ad endon("death");
  level waittill("game_ended");
  function_88e0d424c8a772b(var_6cc7c7c4978597ad);
}

function private function_c1069f1ca1ed8fb3() {
  var_6cc7c7c4978597ad = self;
  var_6cc7c7c4978597ad endon("death");
  var_6cc7c7c4978597ad waittill("redeploy_drone_destroyed");
  function_88e0d424c8a772b(var_6cc7c7c4978597ad);
}

function private function_440dc164f57736cc(instance, part, state, player, bautouse, usestring) {
  if(!isDefined(instance) || !isDefined(player)) {
    return;
  }

  beacon = instance;
  itemgiven = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, "brloot_super_redeploy_drone_beacon", 1, 1);

  if(istrue(itemgiven)) {
    view_origin = player getvieworigin();
    var_8598d3d3bc3d9ceb = 0;
    quantity = 1;
    player scripts\mp\gametypes\br_pickups::function_37be6e543436f3b3(64496, view_origin, var_8598d3d3bc3d9ceb, quantity);
    hasexplosion = 0;
    function_3a022f8c2f99b818(beacon.entity, hasexplosion);
  }
}

function private function_3a022f8c2f99b818(beacon, hasexplosion) {
  hasexplosion = default_to(hasexplosion, 1);

  if(isDefined(beacon)) {
    if(hasexplosion) {
      thread function_95c7e912851d6478(beacon.origin);
    }

    beacon delete();
  }
}

function private function_95c7e912851d6478(spawnposition) {
  if(istrue(level.gameended)) {
    return;
  }

  explosion = spawnscriptable("super_redeploy_drone_beacon_explosion", spawnposition);
  level waittill_any_timeout_1(5, "game_ended");
  explosion freescriptable();
}

function private function_664ee2d91914fe61(beacon) {
  if(!isDefined(beacon)) {
    return;
  }

  level endon("game_ended");
  beacon endon("death");
  waittime = level.var_4a77e3d00962be2.var_ec4cd7925159b233;
  wait waittime;
  function_3a022f8c2f99b818(beacon);
}

function private function_b76a806bd4d7dec9(var_9879c458a14bced3) {
  var_6cc7c7c4978597ad = self;
  var_6cc7c7c4978597ad notify("drone_departure_handler_thread_started");
  var_6cc7c7c4978597ad endon("drone_departure_handler_thread_started");
  level endon("game_ended");
  var_6cc7c7c4978597ad endon("death");
  var_6cc7c7c4978597ad endon("redeploy_drone_destroyed");
  waittime = level.var_4a77e3d00962be2.var_275b7412d175660b;
  var_6cc7c7c4978597ad waittill_any_timeout_1(waittime, "force_drone_departure");
  function_3a022f8c2f99b818(var_6cc7c7c4978597ad.beacon);
  function_b8f20ce3b3f59440(var_6cc7c7c4978597ad.brushmodel);
  var_6cc7c7c4978597ad namespace_2c2703f78fc59600::function_26aa223d0b9d14ba(var_9879c458a14bced3, var_6cc7c7c4978597ad.var_afe0331c2ce31aec);
  function_88e0d424c8a772b(var_6cc7c7c4978597ad);
}

function private function_529161497b92ec7f(attacker) {
  beacon = self;

  if(isPlayer(attacker) && isDefined(beacon.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(beacon.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::doscoreevent(#"destroyed_equipment");
  }
}

function private function_9d6c964e1422e8d1(data) {
  beacon = self;
  function_3a022f8c2f99b818(beacon);
}

function private initdevgui() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:xa6>");
  scripts\common\devgui::add_devgui_command("<dev string:xc1>", "<dev string:xda>");
  scripts\common\devgui::function_fe953f000498048f();
}

function private function_391adac64d5fa47(player, beacon, var_e43451c4c85f5b88) {
  if(!isDefined(player) || !isDefined(beacon)) {
    return;
  }

  player endon("<dev string:x121>");
  beacon endon("<dev string:x131>");
  level endon("<dev string:x13a>");
  waittime = 0.5;
  var_5ae08673376c9361 = (1, 0, 0);

  while(true) {
    wait waittime;
    isdebugenabled = getdvarint(@ "hash_e0b5816cbcf9bbd1", 0) == 1;

    if(!isdebugenabled) {
      continue;
    }

    function_a5f6aa4efd1afbe4(beacon, var_e43451c4c85f5b88, waittime, var_5ae08673376c9361);
  }
}

function private function_a5f6aa4efd1afbe4(beacon, var_e43451c4c85f5b88, waittime, var_5ae08673376c9361) {
  [cablestartposition, cableendposition, sphereradius] = function_e3ed19e8256d0323(beacon, var_e43451c4c85f5b88);
  level thread scripts\cp_mp\utility\debug_utility::drawcylinder(cablestartposition, sphereradius, cableendposition[2] - cablestartposition[2], waittime, var_5ae08673376c9361);
  level thread scripts\mp\utility\debug::drawsphere(cablestartposition, sphereradius, waittime, var_5ae08673376c9361);
  level thread scripts\mp\utility\debug::drawsphere(cableendposition, sphereradius, waittime, var_5ae08673376c9361);
}

# /