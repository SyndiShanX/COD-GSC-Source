/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\friendly.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\stealth\callbacks;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\utility;
#namespace namespace_32a4062b;

function main() {
  if(!isDefined(level.stealth)) {
    stealth_manager::function_f9682fd();
  }

  self init_settings();
  self thread spotted_thread();
  self thread visibility_thread();

  self thread stealth_debug::debug_friendly();
}

function init_settings() {
  assert(!isDefined(self.stealth), "<dev string:x38>");
  self.stealth = spawnStruct();
  self.stealth.spotted_list = [];
  self.stealth.funcs = [];
  self flag::init("stealth_enabled");
  self flag::init("stealth_override_goal");
  self flag::set("stealth_enabled");
  self namespace_979752dc::assign_unique_id();
  self namespace_979752dc::group_add();
  self.stealth.var_103386e8 = self namespace_979752dc::group_flag_init("stealth_spotted");
  self.stealth.bsmstate = -1;
}

function spotted_thread() {
  self endon(#"death");
  self notify(#"spotted_thread");
  self endon(#"spotted_thread");

  while(true) {
    self flag::wait_till("stealth_enabled");
    self namespace_979752dc::group_flag_waitopen("stealth_spotted");

    if(!self flag::get("stealth_enabled")) {
      self flag::wait_till("stealth_enabled");
    }

    self thread state_hidden();
    self flag::wait_till("stealth_enabled");
    self namespace_979752dc::group_flag_wait("stealth_spotted");

    if(!self flag::get("stealth_enabled")) {
      self flag::wait_till("stealth_enabled");
    }

    self thread state_spotted();
  }
}

function state_hidden() {
  self thread namespace_979752dc::setbattlechatter(0);
  self.stealth.oldgrenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.forcesidearm = 0;
  self.dontevershoot = 1;
  self.dontattackme = 1;

  if(isDefined(self.stealth.funcs[#"hidden"])) {
    self namespace_b2b86d39::stealth_call_thread("hidden");
  }
}

function state_spotted() {
  assert(!isPlayer(self));
  self thread namespace_979752dc::setbattlechatter(1);

  if(isDefined(self.stealth.oldgrenadeammo)) {
    self.grenadeammo = self.stealth.oldgrenadeammo;
  } else {
    self.grenadeammo = 3;
  }

  self.dontevershoot = 0;
  self.dontattackme = 0;
  self pushplayer(0);

  if(isDefined(self.stealth.funcs[#"spotted"])) {
    self namespace_b2b86d39::stealth_call_thread("spotted");
  }
}

function getup_from_prone() {
  self endon(#"death");
}

function visibility_thread() {
  self endon(#"death");
  self endon(#"long_death");

  while(true) {
    self flag::wait_till("stealth_enabled");

    if(!isDefined(self.stealth.ignore_visibility)) {
      self.maxvisibledist = self get_detect_range();
    }

    wait 0.05;
  }
}

function get_detect_range() {
  stance = self.currentpose;

  if(stance === "back") {
    stance = "prone";
  }

  if(self namespace_979752dc::group_spotted_flag()) {
    detection = "spotted";
  } else {
    detection = "hidden";
  }

  range = level.stealth.detect.range[detection][stance];

  if(self flag::get("stealth_in_shadow")) {
    range = max(level.stealth.detect.range[#"hidden"][#"prone"], range * 0.5);
  }

  return range;
}