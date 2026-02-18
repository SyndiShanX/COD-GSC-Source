/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_20e6f33f311f7fe6.csc
***********************************************/

#using script_644007a8c3885fc;
#using scripts\core_common\item_world_fixup;
#namespace namespace_de6618fd;

function autoexec __init__() {
  gametype = getdvarstring(#"g_gametype");

  switch (gametype) {
    case # "fireteam_dirty_bomb":
      function_cbbf16a4();
      break;
    case # "hash_6463dea5fa2dbea5":
      function_e5d1b704();
      break;
    case # "fireteam_elimination":
      function_574dc51f();
      break;
    case # "fireteam_koth":
      function_1ed4cf79();
      break;
    case # "fireteam_satlink":
      function_11109d50();
      break;
    case # "zsurvival":
      function_bcd11f83();
      break;
    default:
      break;
  }

  function_d5eb555d();
  function_f05c9e0a();
}

function function_cbbf16a4() {
  function_c379f040();
}

function function_e5d1b704() {
  function_c379f040();
}

function function_574dc51f() {
  namespace_1c7b37c6::item_replacer(&item_world_fixup::function_6991057, #"hash_203198a6940492f9", #"hash_20fe5ea7eec81707");
  function_c379f040();
}

function function_1ed4cf79() {
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;
  var_edfbccd0 = &item_world_fixup::function_e70fa91c;
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"hash_203198a6940492f9", #"hash_59ceff804ad2c7b8");
  function_c379f040();
}

function function_11109d50() {
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;
  var_edfbccd0 = &item_world_fixup::function_e70fa91c;
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"hash_203198a6940492f9", #"hash_539207ef429bfa40");
  function_c379f040();
}

function function_bcd11f83() {
  namespace_1c7b37c6::item_replacer(&item_world_fixup::function_6991057, #"hash_203198a6940492f9", #"t9_empty_global");
  namespace_1c7b37c6::item_replacer(&item_world_fixup::function_6991057, #"hash_288ef692cd8b7c55", #"t9_empty_global");
  namespace_1c7b37c6::item_replacer(&item_world_fixup::function_6991057, #"hash_d735743f6964821", #"t9_empty_global");
  namespace_1c7b37c6::item_replacer(&item_world_fixup::function_6991057, #"hash_41061d68aef8439e", #"t9_empty_global");
}

function function_d5eb555d() {}

function function_f05c9e0a() {
  function_8341771e(function_91b29d2a("location_items_golova"), 7000, #"hash_5a88477bbf0736f1");
  function_8341771e(function_91b29d2a("location_items_farm"), 7000, #"hash_1c4eccf00713d9c7");
  function_8341771e(function_91b29d2a("location_items_mansion"), 9000, #"hash_d5c723294842e7c");
}

function function_8341771e(locations, radius, name) {
  var_32948f8f = function_91b29d2a("dirty_bomb_stash");

  foreach(location in locations) {
    foreach(var_64b8ecb8 in var_32948f8f) {
      var_d196e508 = var_64b8ecb8.origin;

      if(distance2dsquared(location.origin, var_d196e508) <= radius * radius) {
        item_world_fixup::function_a997e342(var_d196e508, 16);

        if(isDefined(name)) {
          item_world_fixup::add_spawn_point(var_d196e508, name, var_64b8ecb8.angles);
        }
      }
    }
  }
}

function function_c379f040() {}