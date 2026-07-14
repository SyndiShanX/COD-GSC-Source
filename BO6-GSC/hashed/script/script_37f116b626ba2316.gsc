/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_37f116b626ba2316.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\engine\utility;
#using scripts\mp\utility\killstreak;
#namespace namespace_fa9d758ed43a4b1e;

function private autoexec __init__system__() {
  system::register(#"hash_28b990765595701d", undefined, &__init__, undefined);
}

function __init__() {
  utility::registersharedfunc(#"chopper_door_gunner", #"init", &init);
  level thread main();
}

function main() {
  utility::flag_wait("chopper_shared_initialized");
  utility::registersharedfunc("chopper_door_gunner", #"hash_c44e13c75d2a5c1c", &function_195267a8faaaf094);
}

function init() {
  level callback::add(#"player_death", &onplayerkilled);
}

function onplayerkilled(deathdata) {
  objweapon = deathdata.objweapon;

  if(!isDefined(objweapon)) {
    return;
  }

  killstreakweaponname = killstreak::getkillstreaknamefromweapon(objweapon);
  var_abf06c4e271cd82 = killstreakweaponname == "chopper_door_gunner";

  if(!var_abf06c4e271cd82) {
    return;
  }

  attacker = deathdata.attacker;

  if(!isDefined(attacker.var_358f8c0520f39fc2)) {
    attacker.var_358f8c0520f39fc2 = 0;
  }

  attacker.var_358f8c0520f39fc2++;

  if(!isDefined(attacker.var_ca51a9033a8266a9)) {
    attacker.var_ca51a9033a8266a9 = gettime();
  }

  currenttime = gettime();
  killwindow = currenttime - attacker.var_ca51a9033a8266a9;

  if(killwindow <= 2000 && attacker.var_358f8c0520f39fc2 == 5) {
    attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc(#"chopper_gunner_multi");
    attacker.var_ca51a9033a8266a9 = undefined;
    attacker.var_358f8c0520f39fc2 = undefined;
    return;
  }

  if(killwindow > 2000) {
    attacker.var_ca51a9033a8266a9 = currenttime;
    attacker.var_358f8c0520f39fc2 = 1;
  }
}

function private function_749e94b841d2e996(var_b59a72bf8a2b7b5c, var_d46f595737de3fc, entityname, animorigin, animangles) {
  entity = var_b59a72bf8a2b7b5c scene::get_entity(entityname);
  shotindex = 0;
  anims = var_d46f595737de3fc scene::function_d0df7c35d793d179(entityname, shotindex);
  entity animScripted("", animorigin, animangles, anims[0]);
  entity scriptmodelplayanim(getanimname(anims[0]));
  alignmentinfo = var_b59a72bf8a2b7b5c scene::get_object_alignment(entityname, shotindex);
  alignmentinfo.alignent = entity;
  return entity;
}

function private function_195267a8faaaf094(gamescene) {
  var_b59a72bf8a2b7b5c = self;
  veh = var_b59a72bf8a2b7b5c.veh;
  var_d46f595737de3fc = {};
  var_d46f595737de3fc scene::set_scriptbundle(gamescene);
  veh.pilotent = function_749e94b841d2e996(var_b59a72bf8a2b7b5c, var_d46f595737de3fc, "Pilot", veh.origin, veh.angles);
  veh.var_fd454312254c8a23 = function_749e94b841d2e996(var_b59a72bf8a2b7b5c, var_d46f595737de3fc, "Copilot", veh.origin, veh.angles);
  veh.pilotent enableplayermarks(#"air_killstreak");
  veh.var_fd454312254c8a23 enableplayermarks(#"air_killstreak");

  if(level.teambased) {
    veh.pilotent filteroutplayermarks(veh.owner.team);
    veh.var_fd454312254c8a23 filteroutplayermarks(veh.owner.team);
    return;
  }

  veh.pilotent filteroutplayermarks(veh.owner);
  veh.var_fd454312254c8a23 filteroutplayermarks(veh.owner);
}