/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_stealth_behavior_system.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_stealth_utility;

stealth_behavior_system_main() {
  stealth_behavior_system_init();
}

stealth_behavior_system_init() {
  assertEX(isDefined(level._stealth), "There is no level._stealth struct.You ran stealth behavior before running the detection logic.Run _stealth_logic::main() in your level load first");

  level._stealth.behavior = spawnStruct();
  level._stealth.node_search = spawnStruct();

  level._stealth.behavior.sound = [];
  level._stealth.behavior.sound["huh"] = false;
  level._stealth.behavior.sound["hmph"] = false;
  level._stealth.behavior.sound["name"] = false;
  level._stealth.behavior.sound["wtf"] = false;
  level._stealth.behavior.sound["spotted"] = [];
  level._stealth.behavior.sound["corpse"] = false;
  level._stealth.behavior.sound["alert"] = false;
  level._stealth.behavior.sound["acknowledge"] = false;

  level._stealth.behavior.sound_reset_time = 3;
}