/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\friendly.gsc
****************************************/

#using scripts\engine\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\debug;
#using scripts\stealth\manager;
#using scripts\stealth\utility;
#namespace friendly;

function main() {
  if(!isDefined(level.stealth)) {
    stealth_manager::main();
  }

  init_settings();
  self.stealth_groupname = self.script_stealthgroup;
  thread spotted_thread();

  thread debug::debug_friendly();
}

function init_settings() {
  assert(!isDefined(self.stealth), "<dev string:x24>");
  self.stealth = spawnStruct();
  self.stealth.funcs = [];
  utility::ent_flag_init("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  utility::ent_flag_set("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  utility::ent_flag_init("v8\xde\xcb\x1a\x8b>w\xac\xf2sJ\xfd_\xf3\xe4\x8f");
  utility::group_flag_init("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
  utility::group_add();
  self.stealth_bsmstate = 0;
}

function spotted_thread() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xd6\xa8G\x05\x81\xbfSOXm\xea%M\x04");
  self endon("\xd6\xa8G\x05\x81\xbfSOXm\xea%M\x04");

  while(true) {
    utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    utility::group_flag_waitopen("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");

    if(!utility::ent_flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
      utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    }

    thread state_hidden();
    utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    utility::group_flag_wait("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");

    if(!utility::ent_flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
      utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    }

    thread state_spotted();
  }
}

function state_hidden() {
  thread utility::setbattlechatter(0);
  self.stealth.oldgrenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.forcesidearm = 0;
  self.dontevershoot = 1;
  self.dontattackme = 1;

  if(isDefined(self.stealth.funcs["\xf8VZW\xd3\xad"])) {
    callbacks::stealth_call_thread("\xf8VZW\xd3\xad");
  }
}

function state_spotted() {
  assert(!isPlayer(self));
  thread utility::setbattlechatter(1);

  if(isDefined(self.stealth.oldgrenadeammo)) {
    self.grenadeammo = self.stealth.oldgrenadeammo;
  } else {
    self.grenadeammo = 3;
  }

  self.dontevershoot = 0;
  self.dontattackme = 0;
  self pushplayer(0);

  if(isDefined(self.stealth.funcs["\x1f\x93?pK+\x9c"])) {
    callbacks::stealth_call_thread("\x1f\x93?pK+\x9c");
  }
}

function getup_from_prone() {
  self endon("\x1e\xfd\xd1\xa2\a");
}

function visibility_thread() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("*\xeb\x7f!\xa4\xb9\xe6/\xcf\a");

  while(true) {
    utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");

    if(!isDefined(self.stealth.ignore_visibility)) {
      self.maxvisibledist = get_detect_range();
    }

    wait 0.05;
  }
}

function get_detect_range() {
  stance = self.currentpose;

  if(stance == "\x8a+\xf04") {
    stance = "GX\xa9]\x82";
  }

  if(utility::group_spotted_flag()) {
    detection = "\x1f\x93?pK+\x9c";
  } else {
    detection = "\xf8VZW\xd3\xad";
  }

  range = function_5cd47b5f438ec45f(detection, stance);

  if(utility::ent_flag("v8\xde\xcb\x1a\x8b>w\xac\xf2sJ\xfd_\xf3\xe4\x8f")) {
    range = max(function_5cd47b5f438ec45f("\xf8VZW\xd3\xad", "GX\xa9]\x82"), range * 0.5);
  }

  return range;
}