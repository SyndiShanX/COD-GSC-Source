/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_92b815b18f0ba61.gsc
************************************************/

#using script_638d701d263ee1ed;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_f4c0d6ef6396cb69;

function function_70ed29a8f9257bb3(params) {
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("green_city", "difficulty_easy");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("green_industrial_belt", "difficulty_easy");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("green_manor", "difficulty_easy");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("green_marina", "difficulty_easy");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("green_military_base", "difficulty_easy");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("green_resort", "difficulty_easy");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("green_rural", "difficulty_easy");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("green_suburbs", "difficulty_easy");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("green_village", "difficulty_easy");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("yellow_cargo", "difficulty_normal");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("yellow_city", "difficulty_normal");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("yellow_industrial_belt", "difficulty_normal");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("yellow_low_town", "difficulty_normal");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("yellow_outpost", "difficulty_normal");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("yellow_suburbs", "difficulty_normal");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("red_old_town_east", "difficulty_hard");
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("red_old_town_west", "difficulty_hard");
  level callback::callback("region_difficulties_registered");
}

function function_3c461caaf1b29a48(params) {
  function_70ed29a8f9257bb3(params);
}

function function_3c461faaf1b2a0e1(params) {
  function_70ed29a8f9257bb3(params);
}

function function_3c461eaaf1b29eae(params) {
  function_70ed29a8f9257bb3(params);
}

function function_3c4621aaf1b2a547(params) {
  function_70ed29a8f9257bb3(params);
}

function function_3c4620aaf1b2a314(params) {
  function_70ed29a8f9257bb3(params);
}

function function_3c4623aaf1b2a9ad(params) {
  function_70ed29a8f9257bb3(params);
}

function function_3c4622aaf1b2a77a(params) {
  function_70ed29a8f9257bb3(params);
}

function function_3c4615aaf1b28ae3(params) {
  function_70ed29a8f9257bb3(params);
}

function function_3c4614aaf1b288b0(params) {
  function_70ed29a8f9257bb3(params);
}

function function_40e7fdd70c68231f(params) {
  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_fortress", "difficulty_darkaether");
  } else if(getdvarint(@ "ob_rift_run", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_fortress", "difficulty_hard");
  } else if(getdvarint(@ "hash_596076b5ab54d511", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_fortress", "difficulty_normal");
  } else if(getdvarint(@ "ob_unstable_rift", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_fortress", "difficulty_darkaether");
  } else {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_fortress", "difficulty_easy");
  }

  level callback::callback("region_difficulties_registered");
}

function function_a397a005277bf6df(params) {
  if(getdvarint(@ "hash_2f25d49fdfabbf5d", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_fortress", "difficulty_darkaether");
  } else if(getdvarint(@ "hash_c385fef4df4638cb", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_fortress", "difficulty_hard");
  } else if(getdvarint(@ "hash_3a4e983e54a9ae7e", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_fortress", "difficulty_normal");
  } else {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_fortress", "difficulty_easy");
  }

  level callback::callback("region_difficulties_registered");
}

function function_452e757b6e673474(params) {
  if(getdvarint(@ "hash_bc2abb9e5752e088", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_hydro", "difficulty_darkaether");
  } else if(getdvarint(@ "ob_s3_rift_run", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_hydro", "difficulty_hard");
  } else if(getdvarint(@ "hash_596074b5ab54d0ab", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_hydro", "difficulty_normal");
  } else {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_hydro", "difficulty_easy");
  }

  level callback::callback("region_difficulties_registered");
}

function function_899963e9fdcf0037(params) {
  if(getdvarint(@ "hash_cc86ad6895d8aa2a", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_tower", "difficulty_darkaether");
  } else if(getdvarint(@ "ob_s5_rift_run", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_tower", "difficulty_hard");
  } else if(getdvarint(@ "hash_59607ab5ab54dddd", 0)) {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_tower", "difficulty_normal");
  } else {
    namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("region_dark_aether_tower", "difficulty_easy");
  }

  level callback::callback("region_difficulties_registered");
}

function function_738bba992e43ca7e(params) {
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("act1_region", "difficulty_normal");
  level callback::callback("region_difficulties_registered");
}

function function_3ececb453fbf07fe(params) {
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("yellow_resort_gw", "difficulty_normal");
  level callback::callback("region_difficulties_registered");
}

function function_74fd375468d1ae4(params) {
  namespace_4df2ab39b0e96ec7::function_d590d31d431a15c1("yellow_zakhaev", "difficulty_normal");
  level callback::callback("region_difficulties_registered");
}