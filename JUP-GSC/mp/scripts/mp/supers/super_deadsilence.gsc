/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\supers\super_deadsilence.gsc
******************************************************/

#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace super_deadsilence;

function superdeadsilence_beginsuper() {
  result = function_ef312894c6cae23();
  return result;
}

function private function_ef312894c6cae23() {
  if(getdvarint(@ "hash_88050a1ca3a6c70f", 0) == 1) {
    return 1;
  }

  objweapon = makeweapon("deadsilence_device_mp");
  deploysuccess = scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable(objweapon);

  if(istrue(deploysuccess)) {
    return function_2649cdb548d89c04();
  }

  scripts\mp\supers::refundsuper();
}

function private function_2649cdb548d89c04() {
  giveperk("specialty_quieter");
  giveperk("specialty_no_battle_chatter");
  superbundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_deadsilence");

  if(istrue(superbundle.deadsilenceghost)) {
    self setplayerghost(1);
  }

  self.deadsilencekills = 0;
  self.super.isactive = 1;

  if(isDefined(self.pers["deadSilenceTime"])) {
    self.deadsilencestarttime = gettime();
  }

  self playlocalsound("deadsilence_start");
  namespace_a850435086c88de3::doonactionscoreevent(1, "deadSilenceUsed");
  superdeadsilence_updateuistate(0);
  scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "equipment_deployed");
  thread applyfovpresentation();
  thread superdeadsilence_watchforgameended();
  agents = getaiarrayinradius(self.origin, 2048);

  foreach(agent in agents) {
    if(agent getthreatsight(self) >= 1) {
      agent setthreatsight(self, 0);
    }
  }

  scripts\cp_mp\challenges::function_d997435895422ecc("super_deadsilence", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  thread function_43eba8eb08bb6edc();
  return true;
}

function superdeadsilence_endsuper(fromdeath) {
  if(getdvarint(@ "hash_88050a1ca3a6c70f", 0) == 1) {
    return false;
  }

  self setscriptablepartstate("deadSilenceFX", "end", 0);
  removeperk("specialty_quieter");
  removeperk("specialty_no_battle_chatter");
  superbundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_deadsilence");

  if(istrue(superbundle.deadsilenceghost) && !istrue(self.canghost)) {
    self setplayerghost(0);
  }

  self.super.isactive = 0;

  if(isDefined(self.pers["deadSilenceTime"])) {
    currenttime = gettime();
    timeindeadsilence = currenttime - self.deadsilencestarttime;
    scripts\mp\utility\stats::incpersstat("deadSilenceTime", timeindeadsilence);
  }

  if(getgametype() != "infect") {
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self, level.superglobals.staticsuperdata["super_deadsilence"].id, self.deadsilencekills, istrue(fromdeath));
  }

  thread superdeadsilence_endhudsequence();

  if(scripts\engine\utility::issharedfuncdefined("br", "superSlotCleanUp")) {
    [[scripts\engine\utility::getsharedfunc("br", "superSlotCleanUp")]](self);
  }

  if(isDefined(self.var_1bb565e508ac38a5)) {
    scripts\cp_mp\challenges::function_d997435895422ecc("super_deadsilence", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"end"), self.var_8c1b3c647dc1c8ca);
  }

  return false;
}

function superdeadsilence_onkill() {
  if(getdvarint(@ "hash_88050a1ca3a6c70f", 0) == 1) {
    return;
  }

  if(getgametype() != "infect") {
    scripts\mp\utility\stats::incpersstat("deadSilenceKills", 1);
    scripts\mp\supers::combatrecordsuperkill("super_deadsilence");
    self.deadsilencekills++;
    var_f8627bc73976807c = scripts\mp\supers::getcombatrecordsupermisc("super_deadsilence");

    if(self.deadsilencekills > var_f8627bc73976807c) {
      increment = self.deadsilencekills - var_f8627bc73976807c;
      scripts\mp\supers::combatrecordsupermisc("super_deadsilence", increment);
    }
  }

  self playlocalsound("deadsilence_start");
  superdeadsilence_updateuistate(1);
  scripts\mp\supers::resetsuperusepercent();
  thread applyfovpresentation();
}

function superdeadsilence_endhudsequence() {
  self endon("disconnect");
  superdeadsilence_updateuistate(2);
  wait 1;
  superdeadsilence_updateuistate(-1);
}

function superdeadsilence_updateuistate(newstate) {
  self.deadsilenceuistate = newstate;
  self setclientomnvar("ui_deadsilence_overlay", newstate);
}

function applyfovpresentation() {
  self endon("death_or_disconnect");
  self notify("applyFOVPresentation");
  self endon("applyFOVPresentation");
  self setscriptablepartstate("deadSilenceFX", "neutral", 0);
  waitframe();
  self lerpfovbypreset("zombiedefault");
  self playlocalsound("deadsilence_end");
  self setscriptablepartstate("deadSilenceFX", "start", 0);
  duration = self.super.staticdata.usetime;
  var_ecf8ff7b7b97525c = duration - 2;
  waittill_any_timeout_no_endon_death_1(var_ecf8ff7b7b97525c, "super_use_finished");
  self lerpfovbypreset("default_2seconds");
}

function superdeadsilence_watchforgameended() {
  self endon("death_or_disconnect");
  self endon("super_use_finished");
  self notify("superDeadsilence_watchForGameEnded");
  self endon("superDeadsilence_watchForGameEnded");
  level waittill_any_2("game_ended", "prematch_cleanup");
  thread scripts\mp\supers::superusefinished();
}

function function_43eba8eb08bb6edc() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("super_use_finished");
  self.var_8c1b3c647dc1c8ca = 0;
  var_6468f56d9f67c8bf = 39.3701;
  playerprevpos = self.origin;
  distanceinches = 0;

  while(isDefined(self.super) && self.super.isactive) {
    if(true) {
      var_cb1505ffb6643abe = self.origin;
      distanceinches += distance(var_cb1505ffb6643abe, playerprevpos);
      playerprevpos = var_cb1505ffb6643abe;
      self.var_8c1b3c647dc1c8ca = int(round(distanceinches / var_6468f56d9f67c8bf));
    }

    wait 0.1;
  }
}