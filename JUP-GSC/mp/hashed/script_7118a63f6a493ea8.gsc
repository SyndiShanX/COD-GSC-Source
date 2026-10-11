/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7118a63f6a493ea8.gsc
*************************************************/

#using scripts\anim\notetracks_mp;
#using scripts\asm\asm_mp;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace namespace_657dc7e018dcfce9;

function init() {
  setDvar(@ "hash_1fc47d6f68e1faf", 1);
  setDvar(@ "hash_633e1a62bb5ceeb2", 1);

  if(!isDefined(level.players)) {
    level.players = [];
  }

  level.var_19d38dec02a818ce = &scripts\engine\utility::issharedfuncdefined;
  level.var_49b393a31d0b0b95 = &scripts\engine\utility::getsharedfunc;
  anim_init();
  hud_init();
  killstreak_init();
  equipment_init();
  perk_init();
  player_init();
  vehicle_init();
  game_init();
  spawn_init();
  emp_init();
  execution_init();
  entity_init();
  weapons_init();
  damage_init();
  sound_init();
  flares_init();
  shellshock_init();
  fx_init();
  ai_init();
  bots_init();
  agents_init();
  outline_init();
  game_utility_init();
  rank_init();
  supers_init();
  gamescore_init();
  pers_init();
  dlog_init();
  challenges_init();
  function_a92ed2f4c44e5ffa();
  stealth_init();
  gameskill_init();
  poi_init();
  aggregator_init();
  cameras_init();
  function_a30b248a8fc67a00();
  battlechatter_init();
  host_migration_init();
  function_f677f2d747d21482();
}

function gameskill_init() {}

function poi_init() {}

function stealth_init() {}

function anim_init() {
  registersharedfunc("anim", "scriptModelPlayAnimDeltaMotion", &function_3ecab25ce099b78e);
  registersharedfunc("anim", "ASM_PlayFacialAnim", &asm_playfacialanim_mp);
  registersharedfunc("anim", "HandleNoteTrack", &handlenotetrack);
}

function hud_init() {}

function killstreak_init() {
  registersharedfunc("killstreak", "registerVisibilityOmnvarForKillstreak", &scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak);
  registersharedfunc("killstreak", "createStreakInfo", &scripts\cp_mp\utility\killstreak_utility::createstreakinfo);
  registersharedfunc("killstreak", "streakDeploy_doWeaponTabletDeploy", &scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy);
  registersharedfunc("killstreak", "getKillstreakAirStrikeHeightEnt", &scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent);
  registersharedfunc("killstreak", "playKillstreakOperatorDialog", &scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog);
  registersharedfunc("killstreak", "setVisibiilityOmnvarForKillstreak", &scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak);
  registersharedfunc("killstreak", "restoreKillstreakPlayerAngles", &scripts\cp_mp\utility\killstreak_utility::restorekillstreakplayerangles);
  registersharedfunc("killstreak", "recordKillstreakEndStats", &scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats);
  registersharedfunc("killstreak", "killstreak_setMainVision", &scripts\cp_mp\utility\killstreak_utility::killstreak_setmainvision);
  registersharedfunc("killstreak", "killstreak_setSubVision", &scripts\cp_mp\utility\killstreak_utility::killstreak_setsubvision);
  registersharedfunc("killstreak", "isKillstreakWeapon", &scripts\cp_mp\weapon::iskillstreakweapon);
  registersharedfunc("killstreak", "killstreak_registerMinimapInfo", &scripts\cp_mp\utility\killstreak_utility::killstreak_registerminimapinfo);
  registersharedfunc("killstreak", "killstreak_setupVehicleDamageFunctionality", &scripts\cp_mp\utility\killstreak_utility::killstreak_setupvehicledamagefunctionality);
  registersharedfunc("killstreak", "killstreak_updateDamageState", &scripts\cp_mp\utility\killstreak_utility::killstreak_updatedamagestate);
  registersharedfunc("killstreak", "playerKillstreakGetOwnerLookAtIgnoreEnts", &scripts\cp_mp\utility\killstreak_utility::playerkillstreakgetownerlookatignoreents);
  registersharedfunc("killstreak", "killstreak_dangerNotifyPlayersInRange", &scripts\cp_mp\utility\killstreak_utility::killstreak_dangernotifyplayersinrange);
  registersharedfunc("killstreak", "streakDeploy_doWeaponFiredDeploy", &scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy);
  registersharedfunc("player", "isEnemy", &scripts\cp_mp\utility\player_utility::isenemy);
  registersharedfunc("challenges", "onHack", &scripts\cp_mp\challenges::onhack);
}

function equipment_init() {}

function entity_init() {}

function perk_init() {}

function player_init() {
  registersharedfunc("player", "_isAlive", &scripts\cp_mp\utility\player_utility::_isalive);
  registersharedfunc("player", "getSuperFaction", &scripts\cp_mp\utility\player_utility::getplayersuperfaction);
  registersharedfunc("player", "getExecutionPartner", &getexecutionpartner);
}

function host_migration_init() {}

function vehicle_init() {
  registersharedfunc("vehicle", "vehicle_damage_setCanDamage", &scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage);
  registersharedfunc("vehicle", "vehicle_spawn_setClearanceCheckMinRadius", &scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_setclearancecheckminradius);
  registersharedfunc("vehicle", "vehicle_damage_clearVisuals", &scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals);
  registersharedfunc("vehicle", "vehicleCanFly", &scripts\cp_mp\vehicles\vehicle::vehiclecanfly);
  registersharedfunc("vehicle", "getVehicle", &scripts\cp_mp\utility\player_utility::getvehicle);
  registersharedfunc("vehicle", "vehicle_occupancy_getOccupantSeat", &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat);
  registersharedfunc("vehicle", "vehicle_occupancy_exit", &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit);
}

function game_init() {
  registersharedfunc("game", "ForceNetfieldHighLoD", &function_c7a3d9af98179e8e);
  registersharedfunc("game", "getProgressionData", &getprogressiondata);
  registersharedfunc("game", "setProgressionData", &setprogressiondata);
  registersharedfunc("game", "getTimePassed", &scripts\cp_mp\utility\game_utility::gettimepassed);
}

function spawn_init() {}

function emp_init() {
  registersharedfunc("emp", "clear_emp", &scripts\cp_mp\emp_debuff::clear_emp);
  registersharedfunc("emp", "allow_emp", &scripts\cp_mp\emp_debuff::allow_emp);
  registersharedfunc("emp", "emp_debuff_get_emp_count", &scripts\cp_mp\emp_debuff::emp_debuff_get_emp_count);
  registersharedfunc("emp", "is_empd", &scripts\cp_mp\emp_debuff::is_empd);
  registersharedfunc("emp", "play_scramble", &scripts\cp_mp\emp_debuff::play_scramble);
  registersharedfunc("emp", "stop_scramble", &scripts\cp_mp\emp_debuff::stop_scramble);
}

function execution_init() {
  registersharedfunc("executions", "is_in_takedown", &scripts\cp_mp\execution::is_in_takedown);
}

function weapons_init() {
  registersharedfunc("weapons", "setMissileMinimapVisible", &function_cee516993ce8a5f4);
}

function damage_init() {}

function sound_init() {
  registersharedfunc("sound", "playSoundToPlayer", &function_6bc1c74e258d55bc);
}

function flares_init() {}

function shellshock_init() {}

function fx_init() {
  registersharedfunc("fx", "SpawnFXForClient", &function_8795a2cca25c0164);
  registersharedfunc("fx", "SetFXKillDefOnDelete", &function_3fc0d2ad4f715ea4);
}

function ai_init() {
  registersharedfunc("ai", "giveAIWeapon", &function_c77ea258b33422b0);
  registersharedfunc("ai", "onUsedArmorPlate", &function_b535fe740f1cf507);
  registersharedfunc("ai", "getCorpseEntity", &getcorpseentity);
}

function bots_init() {}

function agents_init() {}

function outline_init() {}

function game_utility_init() {}

function rank_init() {}

function supers_init() {}

function gamescore_init() {}

function pers_init() {}

function dlog_init() {}

function challenges_init() {}

function function_a92ed2f4c44e5ffa() {}

function aggregator_init() {}

function cameras_init() {
  registersharedfunc("cameras", "GetCameraThirdPerson", &function_d08336d8c0380c5e);
  registersharedfunc("cameras", "GetCameraThirdPersonOrigin", &function_85c5056c9011e1bc);
}

function function_a30b248a8fc67a00() {}

function battlechatter_init() {
  level.var_276311a22caaf5ac = &function_38dd76fb84086a72;
}

function function_38dd76fb84086a72(origin, maxdist) {
  maxdist = default_to(maxdist, level.bcs_maxdist);
  return function_e3b3f0128f632da5(origin, maxdist);
}

function function_f677f2d747d21482() {
  create_func_ref("setsaveddvar", &setdvar);
}

function private function_c7a3d9af98179e8e(set) {
  self forcenetfieldhighlod(set);
}

function private function_6bc1c74e258d55bc(aliasname, player, srcentity) {
  self playsoundtoplayer(aliasname, player, srcentity);
}

function private function_8795a2cca25c0164(fxid, position, player, forward, up) {
  return spawnfxforclient(fxid, position, player, forward, up);
}

function private function_3fc0d2ad4f715ea4() {
  self setfxkilldefondelete();
}

function private function_c77ea258b33422b0(weapname) {
  self giveweapon(weapname);
}

function private function_3ecab25ce099b78e(animname, notifystring, animstarttimeseconds, blendtype) {
  self scriptmodelplayanimdeltamotion(animname, notifystring, animstarttimeseconds, blendtype);
}

function private function_cee516993ce8a5f4(set) {
  self setmissileminimapvisible(set);
}

function private function_d08336d8c0380c5e() {
  return self getcamerathirdperson();
}

function private function_85c5056c9011e1bc() {
  return self getcamerathirdpersonorigin();
}