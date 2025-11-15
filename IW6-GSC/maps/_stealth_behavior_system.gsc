/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_behavior_system.gsc
*********************************************/

stealth_behavior_system_main() {
  stealth_behavior_system_init();
}

stealth_behavior_system_init() {
  level._stealth.behavior = spawnStruct();
  level._stealth.node_search = spawnStruct();
  level._stealth.behavior.sound = [];
  level._stealth.behavior.sound["huh"] = 0;
  level._stealth.behavior.sound["hmph"] = 0;
  level._stealth.behavior.sound["name"] = 0;
  level._stealth.behavior.sound["wtf"] = 0;
  level._stealth.behavior.sound["spotted"] = [];
  level._stealth.behavior.sound["corpse"] = 0;
  level._stealth.behavior.sound["alert"] = 0;
  level._stealth.behavior.sound["acknowledge"] = 0;
  level._stealth.behavior.sound_reset_time = 3;
}