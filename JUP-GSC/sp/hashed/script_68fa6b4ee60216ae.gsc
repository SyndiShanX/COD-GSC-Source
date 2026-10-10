/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_68fa6b4ee60216ae.gsc
*************************************************/

#using scripts\cp\coop_stealth;
#using scripts\cp\spawning;
#using scripts\stealth\manager;
#using scripts\stealth\utility;
#namespace enemy_cp;

function init(aitype) {
  if(scripts\cp\coop_stealth::level_should_run_sp_stealth()) {
    thread function_5eeb4be2b32a5c41();
  }

  if(!isDefined(aitype)) {
    aitype = self.agent_type;
  }

  if(!scripts\cp\spawning::is_specified_unittype("dog")) {
    self.meleechargedistvsplayer = 50;
  }

  if(issubstr(aitype, "_smg")) {} else if(issubstr(aitype, "_ar")) {
    self.maxfaceenemydist = 3000;
  } else if(issubstr(aitype, "_sniper")) {
    self.maxfaceenemydist = 3000;
  } else if(issubstr(aitype, "_juggernaut")) {
    self.maxfaceenemydist = 3000;
  } else if(issubstr(aitype, "_shotgun")) {} else if(issubstr(aitype, "_lmg")) {
    self.maxfaceenemydist = 3000;
  } else if(issubstr(aitype, "_rpg")) {
    self.maxfaceenemydist = 3000;
  } else {
    self.maxfaceenemydist = 3000;
  }

  self.maxfacenewenemydist = 4000;
  function_48ea06dbce62f5b3();
}

function function_5eeb4be2b32a5c41() {
  self endon("death");

  while(!isDefined(self.stealth)) {
    waitframe();
  }

  while(!isDefined(self.stealth.funcs)) {
    waitframe();
  }

  if(getdvarint(@ "hash_216befcb8b10d029", 0) != 0) {
    scripts\stealth\utility::set_stealth_func("has_lost_enemy", &function_f2c466350f598ead);
  }
}

function function_ccdad4e4232d8253() {
  if(scripts\stealth\manager::anyone_in_combat()) {
    return true;
  }

  return false;
}

function function_f2c466350f598ead() {
  if(function_ccdad4e4232d8253()) {
    ctimetolose = 10000;
    var_7c08dd16ffa22ba8 = 15000;
    cstillrighttheredistsq = 50625;
  } else {
    ctimetolose = 10000;
    var_7c08dd16ffa22ba8 = 15000;
    cstillrighttheredistsq = 2500;
  }

  curtime = gettime();
  enemy = self.enemy;

  if(isDefined(enemy) && issentient(enemy) && isalive(enemy)) {
    if(enemy.team != "allies") {
      return false;
    }

    lasttime = self lastknowntime(enemy);

    if(curtime < lasttime + ctimetolose) {
      return false;
    }

    lastknownpostoenemy = self lastknownpos(enemy);

    if(lasttime > 0 && distancesquared(enemy.origin, lastknownpostoenemy) < cstillrighttheredistsq) {
      return false;
    }

    if(curtime < lasttime + var_7c08dd16ffa22ba8 && enemy hastacvis(lastknownpostoenemy)) {
      return false;
    }

    if(istrue(self.benemyinlowcover)) {
      return false;
    }
  }

  return true;
}

function function_48ea06dbce62f5b3() {
  if(getdvarint(@ "hash_880405187e0bd323", 0) == 0) {
    return;
  }

  if(!istrue(level.var_84b6efb0b4cdabd5)) {
    return;
  }

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
    return;
  }

  self[[self.fnsetstealthstate]]("hunt");
}