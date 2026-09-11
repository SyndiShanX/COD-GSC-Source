/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\friendly.gsc
***********************************************/

function main() {
  if(!isDefined(level.stealth)) {
    scripts\stealth\manager::main();
  }

  init_settings();
  thread spotted_thread();
  thread visibility_thread();
}

function init_settings() {
  self.stealth = spawnStruct();
  self.stealth.spotted_list = [];
  self.stealth.funcs = [];
  scripts\engine\utility::ent_flag_init("stealth_enabled");
  scripts\engine\utility::ent_flag_init("stealth_override_goal");
  scripts\engine\utility::ent_flag_set("stealth_enabled");
  scripts\engine\utility::ent_flag_init("stealth_in_shadow");
  scripts\stealth\utility::group_flag_init("stealth_spotted");
  scripts\stealth\utility::group_add();
  self.stealth.bsmstate = 0;
}

function spotted_thread() {
  self endon("death");
  self notify("spotted_thread");
  self endon("spotted_thread");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    scripts\stealth\utility::group_flag_waitopen("stealth_spotted");

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      scripts\engine\utility::ent_flag_wait("stealth_enabled");
    }

    thread state_hidden();
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    scripts\stealth\utility::group_flag_wait("stealth_spotted");

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      scripts\engine\utility::ent_flag_wait("stealth_enabled");
    }

    thread state_spotted();
  }
}

function state_hidden() {
  thread scripts\stealth\utility::setbattlechatter(0);
  self.stealth.oldgrenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.forcesidearm = 0;
  self.dontevershoot = 1;
  self.dontattackme = 1;

  if(isDefined(self.stealth.funcs["hidden"])) {
    scripts\stealth\callbacks::stealth_call_thread("hidden");
    return;
  }
}

function state_spotted() {
  thread scripts\stealth\utility::setbattlechatter(1);

  if(isDefined(self.stealth.oldgrenadeammo)) {
    self.grenadeammo = self.stealth.oldgrenadeammo;
  } else {
    self.grenadeammo = 3;
  }

  self.dontevershoot = 0;
  self.dontattackme = 0;
  self pushplayer(0);

  if(isDefined(self.stealth.funcs["spotted"])) {
    scripts\stealth\callbacks::stealth_call_thread("spotted");
    return;
  }
}

function getup_from_prone() {
  self endon("death");
}

function visibility_thread() {
  self endon("death");
  self endon("long_death");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");

    if(!isDefined(self.stealth.ignore_visibility)) {
      self.maxvisibledist = get_detect_range();
    }

    wait 0.05;
  }
}

function get_detect_range() {
  var0 = self.currentpose;

  if(var0 == "back") {
    var0 = "prone";
  }

  if(scripts\stealth\utility::group_spotted_flag()) {
    var1 = "spotted";
  } else {
    var1 = "hidden";
  }

  var2 = level.stealth.detect.range[var1][var1];

  if(scripts\engine\utility::ent_flag("stealth_in_shadow")) {
    var2 = max(level.stealth.detect.range["hidden"]["prone"], var2 * 0.5);
  }

  return var2;
}