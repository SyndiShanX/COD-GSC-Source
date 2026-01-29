/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1378.gsc
**************************************/

_id_42AB() {
  _id_42AC();
}

_id_42AC() {
  common_scripts\utility::flag_init("_stealth_found_corpse");
  level._id_0B6E._id_41ED._id_4250 = spawnStruct();
  level._id_0B6E._id_41ED._id_4250._id_4295 = undefined;
  level._id_0B6E._id_41ED._id_4250._id_42AD = [];
  _id_42AF();
  level._id_0B6E._id_41ED._id_4250._id_42AE = 6;
  _id_42B3();
  _id_42B1();
  level._id_0B6E._id_41D0._id_4250 = spawnStruct();
}

_id_42AF() {
  var_0 = [];
  var_0["player_dist"] = 1500;
  var_0["sight_dist"] = 1500;
  var_0["detect_dist"] = 256;
  var_0["found_dist"] = 96;
  var_0["found_dog_dist"] = 50;
  _id_42B0(var_0);
}

_id_42B0(var_0) {
  foreach(var_3, var_2 in var_0) {}
  level._id_0B6E._id_41ED._id_4250._id_42AD[var_3] = var_2;

  level._id_0B6E._id_41ED._id_4250._id_4298 = squared(level._id_0B6E._id_41ED._id_4250._id_42AD["player_dist"]);
  level._id_0B6E._id_41ED._id_4250._id_429E = squared(level._id_0B6E._id_41ED._id_4250._id_42AD["sight_dist"]);
  level._id_0B6E._id_41ED._id_4250._id_429F = squared(level._id_0B6E._id_41ED._id_4250._id_42AD["detect_dist"]);
  level._id_0B6E._id_41ED._id_4250._id_429B = squared(level._id_0B6E._id_41ED._id_4250._id_42AD["found_dist"]);
  level._id_0B6E._id_41ED._id_4250._id_429C = squared(level._id_0B6E._id_41ED._id_4250._id_42AD["found_dog_dist"]);
}

_id_42B1() {
  _id_42B2(30);
}

_id_42B2(var_0) {
  level._id_0B6E._id_41ED._id_4250._id_42A4 = var_0;
}

_id_42B3() {
  _id_42B4(60);
}

_id_42B4(var_0) {
  level._id_0B6E._id_41ED._id_4250._id_42B5 = var_0;
}

_id_42B6(var_0) {
  level._id_0B6E._id_41ED._id_4250._id_42AA = var_0;
}

_id_42B7() {
  level._id_0B6E._id_41ED._id_4250._id_42AA = undefined;
}