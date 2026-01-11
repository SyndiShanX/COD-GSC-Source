/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_corpse_system.gsc
*******************************************/

stealth_corpse_system_main() {
  stealth_corpse_system_init();
}

stealth_corpse_system_init() {
  common_scripts\utility::flag_init("_stealth_found_corpse");
  level._stealth.logic.corpse = spawnStruct();
  level._stealth.logic.corpse.last_pos = undefined;
  level._stealth.logic.corpse.distances = [];
  stealth_corpse_default_distances();
  level._stealth.logic.corpse.corpse_height = 6;
  stealth_corpse_default_forget_time();
  stealth_corpse_default_reset_time();
  level._stealth.behavior.corpse = spawnStruct();
}

stealth_corpse_default_distances() {
  var_0 = [];
  var_0["player_dist"] = 1500;
  var_0["sight_dist"] = 1500;
  var_0["detect_dist"] = 256;
  var_0["found_dist"] = 96;
  var_0["found_dog_dist"] = 50;
  stealth_corpse_set_distances(var_0);
}

stealth_corpse_set_distances(var_0) {
  foreach(var_3, var_2 in var_0) {
  level._stealth.logic.corpse.distances[var_3] = var_2;
  }

  level._stealth.logic.corpse.player_distsqrd = squared(level._stealth.logic.corpse.distances["player_dist"]);
  level._stealth.logic.corpse.sight_distsqrd = squared(level._stealth.logic.corpse.distances["sight_dist"]);
  level._stealth.logic.corpse.detect_distsqrd = squared(level._stealth.logic.corpse.distances["detect_dist"]);
  level._stealth.logic.corpse.found_distsqrd = squared(level._stealth.logic.corpse.distances["found_dist"]);
  level._stealth.logic.corpse.found_dog_distsqrd = squared(level._stealth.logic.corpse.distances["found_dog_dist"]);
}

stealth_corpse_default_reset_time() {
  stealth_corpse_set_reset_time(30);
}

stealth_corpse_set_reset_time(var_0) {
  level._stealth.logic.corpse.reset_time = var_0;
}

stealth_corpse_default_forget_time() {
  stealth_corpse_set_forget_time(60);
}

stealth_corpse_set_forget_time(var_0) {
  level._stealth.logic.corpse.forget_time = var_0;
}

stealth_corpse_set_collect_func(var_0) {
  level._stealth.logic.corpse.collect_func = var_0;
}

stealth_corpse_default_collect_func() {
  level._stealth.logic.corpse.collect_func = undefined;
}