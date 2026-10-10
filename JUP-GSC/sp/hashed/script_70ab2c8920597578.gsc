/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_70ab2c8920597578.gsc
*************************************************/

#using script_3798db193e76a866;
#using scripts\anim\notetracks_sp;
#using scripts\asm\asm_sp;
#using scripts\common\concussion_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\hud_util;
#using scripts\sp\player;
#using scripts\sp\spawner;
#using scripts\sp\vehicle;
#namespace namespace_657dc7e018dcfce9;

function init() {
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
  function_550bcd278c30275e();
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
  function_c1199c7cd79918b3();
  level thread function_cc460dedff0277f();
  function_1bc257700c3d014e();
  function_a30b248a8fc67a00();
  battlechatter_init();
  host_migration_init();
  function_f677f2d747d21482();
}

function gameskill_init() {}

function poi_init() {}

function stealth_init() {}

function anim_init() {
  registersharedfunc("anim", "scriptModelPlayAnimDeltaMotion", &function_ebd14952ee0df63e);
  registersharedfunc("anim", "ASM_PlayFacialAnim", &asm_playfacialanim_sp);
  registersharedfunc("anim", "HandleNoteTrack", &handlenotetrack);
}

function hud_init() {}

function killstreak_init() {
  registersharedfunc("killstreak", "createStreakInfo", &namespace_2032e3f42315b9b2::createstreakinfo);
  registersharedfunc("killstreak", "streakDeploy_doWeaponTabletDeploy", &namespace_2032e3f42315b9b2::function_8eafa4c9894723a3);
  registersharedfunc("killstreak", "getKillstreakAirStrikeHeightEnt", &namespace_2032e3f42315b9b2::getkillstreakairstrikeheightent);
  registersharedfunc("killstreak", "killstreak_setMainVision", &namespace_2032e3f42315b9b2::killstreak_setmainvision);
  registersharedfunc("killstreak", "killstreak_setSubVision", &namespace_2032e3f42315b9b2::killstreak_setsubvision);
  registersharedfunc("killstreak", "restoreKillstreakPlayerAngles", &namespace_2032e3f42315b9b2::restorekillstreakplayerangles);
  registersharedfunc("killstreak", "killstreak_setupVehicleDamageFunctionality", &namespace_2032e3f42315b9b2::killstreak_setupvehicledamagefunctionality);
  registersharedfunc("killstreak", "streakDeploy_doWeaponFiredDeploy", &namespace_2032e3f42315b9b2::function_edd13bb02e6204e4);
  registersharedfunc("hellstorm_missile", "assignTargetMarkers", &namespace_2032e3f42315b9b2::function_ceb8da3185ad3803);
  registersharedfunc("chopper_gunner", "assignTargetMarkers", &namespace_2032e3f42315b9b2::function_ceb8da3185ad3803);
  registersharedfunc("gunship", "assignTargetMarkers", &namespace_2032e3f42315b9b2::function_ceb8da3185ad3803);
  registersharedfunc("cruise_predator", "assignTargetMarkers", &namespace_2032e3f42315b9b2::function_ceb8da3185ad3803);
}

function equipment_init() {
  scripts\engine\utility::registersharedfunc("shellshock", "concussionInterruptDelayFunc", &scripts\common\concussion_utility::calculateinterruptdelay);
}

function entity_init() {}

function perk_init() {}

function player_init() {
  registersharedfunc("player", "_isAlive", &playerisalive);
  registersharedfunc("player", "fadeToBlackForPlayer", &fadetoblackforplayer);
  registersharedfunc("player", "freezeControls", &function_9e4bdc60395a22be);
  registersharedfunc("player", "getSuperFaction", &function_9f7f3dbbcc95bb29);
  registersharedfunc("player", "getPlayersInRadius", &scripts\sp\player::getplayersinradius);
  registersharedfunc("player", "get_rumble_ent", &utility::get_rumble_ent);
  registersharedfunc("player", "rumble_ramp_to", &utility::rumble_ramp_to);
  val::register("player_for_spawn_logic", 1, 0, "$self", &function_3b7b5cc9ae0f8ee2, "$value");
  level.enableexecutionattackfunc = &empty_func;
  level.disableexecutionattackfunc = &empty_func;
}

function host_migration_init() {
  registersharedfunc("hostmigration", "waitLongDurationWithPause", &function_3a8153b287c5ec7);
}

function vehicle_init() {
  registersharedfunc("vehicle", "reserveVehicle", &scripts\sp\vehicle::reservevehicle);
  registersharedfunc("vehicle", "spawnVehicle", &scripts\sp\vehicle::spawnvehicle_sp);
  registersharedfunc("vehicle", "deleteVehicle", &scripts\sp\vehicle::function_99d930044ab93cc);
  registersharedfunc("vehicle", "vehicle_damage_setCanDamage", &scripts\sp\vehicle::function_36dbb623c325c79);
  registersharedfunc("vehicle", "vehicle_driverShowViewModel", &scripts\sp\vehicle::function_9b59f5c375018695);
}

function game_init() {
  registersharedfunc("game", "targetMarkerGroup_off", &targetmarkergroup_off);
  registersharedfunc("game", "targetMarkerGroup_on", &targetmarkergroup_on);
  registersharedfunc("game", "getPlayerProgression", &getplayerprogression);
  registersharedfunc("game", "setPlayerProgression", &setplayerprogression);
}

function spawn_init() {}

function emp_init() {}

function execution_init() {
  registersharedfunc("executions", "is_in_takedown", &scripts\common\utility::function_bbebfbddd1b77a34);
}

function weapons_init() {}

function damage_init() {}

function sound_init() {
  registersharedfunc("sound", "playSoundToPlayer", &playsoundtoplayer_sp);
}

function flares_init() {}

function shellshock_init() {}

function fx_init() {
  registersharedfunc("fx", "SpawnFXForClient", &function_bbc64ca6213bb6ec);
}

function ai_init() {
  registersharedfunc("ai", "giveAIWeapon", &function_b38b4e8270e79930);
  registersharedfunc("ai", "GetFreeAICount", &function_ada2ef6d77db0d44);
  registersharedfunc("ai", "spawnNewAIType_SharedFunc", &function_e5c8a24ca58a645e);
}

function bots_init() {}

function function_550bcd278c30275e() {}

function outline_init() {}

function game_utility_init() {}

function rank_init() {}

function supers_init() {}

function gamescore_init() {}

function pers_init() {}

function dlog_init() {}

function challenges_init() {}

function function_a92ed2f4c44e5ffa() {}

function function_c1199c7cd79918b3() {}

function function_1bc257700c3d014e() {}

function function_a30b248a8fc67a00() {}

function battlechatter_init() {}

function function_f677f2d747d21482() {
  create_func_ref("setsaveddvar", &setsaveddvar);
}

function function_cc460dedff0277f() {
  while(!isDefined(level.mapname)) {
    waitframe();
  }

  startactivity(level.mapname);
}

function private function_3a8153b287c5ec7(delay) {
  delay = default_to(delay, 0);

  if(delay > 0) {
    wait delay;
  }
}

function private playsoundtoplayer_sp(aliasname, player, srcentity) {
  if(soundexists(aliasname)) {
    self playSound(aliasname);
  }
}

function private function_bbc64ca6213bb6ec(fxid, position, player, forward, up) {
  assert(isDefined(level.player) && player == level.player);
  return spawnfx(fxid, position, forward, up);
}

function private function_b38b4e8270e79930(weapname) {
  self.weapon = weapname;
}

function private function_ada2ef6d77db0d44() {
  return getfreeaicount();
}

function private function_e5c8a24ca58a645e(aitype, position, angles, team, var_42e5c77b1d7fe6e7) {
  newai = dospawnaitype(aitype, position, angles, 1, undefined, undefined, undefined, undefined, var_42e5c77b1d7fe6e7);

  if(isDefined(newai)) {
    newai thread scripts\sp\spawner::spawn_think();
  }

  return newai;
}

#using_animtree("script_model");

function private function_ebd14952ee0df63e(animname, notifystring, var_d3a7686bdb2b1c76, blendtype) {
  animation = function_d2fff5ce136ca7b(animname, #animtree);

  if(isDefined(animation)) {
    notifystring = default_to(notifystring, "anim_scripted");
    self useanimtree(#animtree);
    self animScripted(notifystring, self.origin, self.angles, animation);

    if(isDefined(var_d3a7686bdb2b1c76)) {
      coef = var_d3a7686bdb2b1c76 / getanimlength(animation);
      self setanimtime(animname, coef);
    }
  }
}

function fadetoblackforplayer(player, fadetoblack, fadetime) {
  fadetime = default_to(fadetime, 0);

  if(istrue(fadetoblack)) {
    scripts\sp\hud_util::fade_out(fadetime, "black");
    return;
  }

  scripts\sp\hud_util::fade_in(fadetime, "black");
}

function function_9e4bdc60395a22be(frozen, force, debug) {
  if(frozen) {
    val::set("sharedFunc", "freezecontrols", frozen);
    return;
  }

  val::reset("sharedFunc", "freezecontrols");
}

function function_9f7f3dbbcc95bb29(player) {
  return false;
}

function playerisalive() {
  return isalive(self);
}

function targetmarkergroup_on(var_21323aee11762c98, showto, tomark, groupowner, friendlymarker, markonspawn, var_262f4b55aa151de1) {
  if(isDefined(tomark) && !isarray(tomark)) {
    tomark = [tomark];
  }

  if(!isDefined(level.activetargetmarkergroups)) {
    level.activetargetmarkergroups = [];
  }

  id = level.activetargetmarkergroups.size;
  level.activetargetmarkergroups[id] = tomark;

  if(isarray(tomark)) {
    if(issubstr(var_21323aee11762c98, "enemy")) {
      array_thread(tomark, &scripts\engine\sp\utility::hudoutline_enable_new, "outline_nodepth_red");
    } else {
      array_thread(tomark, &scripts\engine\sp\utility::hudoutline_enable_new, "outline_nodepth_green");
    }
  }

  return id;
}

function targetmarkergroup_off(var_4226c12910d867d4) {
  if(isDefined(level.activetargetmarkergroups[var_4226c12910d867d4])) {
    if(isarray(level.activetargetmarkergroups[var_4226c12910d867d4])) {
      array_thread(level.activetargetmarkergroups[var_4226c12910d867d4], &scripts\engine\sp\utility::hudoutline_disable);
    }
  }

  level.activetargetmarkergroups[var_4226c12910d867d4] = undefined;
}

function private function_3b7b5cc9ae0f8ee2(b_value) {}

function private empty_func(b_value) {}