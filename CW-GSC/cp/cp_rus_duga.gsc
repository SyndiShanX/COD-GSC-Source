/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_duga.gsc
***********************************************/

#using script_305169d9fdb05b9;
#using script_3d6cf0d984c55aac;
#using script_4d0e7ced9714e7d4;
#using script_5513c8efed5ff300;
#using script_773cf156b9b5ef18;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_rus_duga_ambush;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace cp_rus_duga;

function event_handler[level_init] main(eventstruct) {
  setclearanceceiling(16);
  init_callbacks();
  init_clientfields();
  function_37dfd679();
  load::main();
  level function_cf9b0986();
  setDvar(#"compassmaxrange", "2100");
}

function function_37dfd679() {
  skipto::function_eb91535d("comprimised", &namespace_d6f0b09d::function_60a583d8, &namespace_d6f0b09d::function_ad4c4af2, "Intro", &namespace_d6f0b09d::function_be4e11a7);
  skipto::function_eb91535d("ambush", &duga_ambush::main, &duga_ambush::starting, "Ambush", &duga_ambush::cleanup);
  skipto::function_eb91535d("loose_ends", &namespace_3562695::main, &namespace_3562695::starting, "Loose Ends", &namespace_3562695::cleanup);

  skipto::add_dev("<dev string:x38>", &namespace_3562695::function_dbe8c8f4, &namespace_3562695::function_f5d9adcd, "<dev string:x4e>");
  skipto::add_dev("<dev string:x60>", &function_b679cee1, &function_4c352dc6, "<dev string:x71>");
  skipto::add_dev("<dev string:x7e>", &function_a3a9332, &function_b3fbad5c, "<dev string:x98>");
  skipto::add_dev("<dev string:xae>", &function_7eb26947, &function_ef6b71e7, "<dev string:xcd>");
}

function function_b679cee1(var_805ed574, var_50cc0d4f) {}

function function_4c352dc6(var_805ed574) {}

function init_clientfields() {
  clientfield::register("toplayer", "pstfx_slow_motion", 1, 1, "int");
  clientfield::register("toplayer", "pstfx_player_stabbed", 1, 1, "int");
  clientfield::register("toplayer", "pstfx_player_executed", 1, 1, "int");
  clientfield::register("toplayer", "pstfx_player_rpg_explosion", 1, 1, "int");
  clientfield::register("toplayer", "pstfx_chromatic_aberration", 1, 1, "int");
  clientfield::register("toplayer", "clf_pstfx_burn_safehouse", 1, 1, "int");
  clientfield::register("world", "dmg_models_and_vol_decals_burning", 1, 1, "int");
  clientfield::register("world", "dmg_setdress_rpg_ambush", 1, 1, "int");
  clientfield::register("world", "stream_intro_truck", 1, 1, "int");
  clientfield::register("toplayer", "force_stream_weapons", 1, 1, "int");
  serverfield::register("sf_jp_sku", 1, 1, "int", &function_fcc96189);
}

function init_callbacks() {
  callback::on_spawned(&on_spawned);
  callback::on_connect(&on_connect);
}

function function_48737ebb() {
  level.var_de6ca1e4 = self namespace_70eba6e6::function_33bf99f8(1);
  var_1584d516 = self player_decision::function_1c4fb6d4();
  level.var_96d76ea = self player_decision::function_d9f060cc();

  var_99b11734 = getdvarint(#"hash_242537bc5f13e42f", -1);
  var_9a7b5d79 = getdvarint(#"hash_4dd19684bf68597b", -1);

  if(var_99b11734 != -1) {
    level.var_96d76ea = var_99b11734;
  }

  if(var_9a7b5d79 != -1) {
    var_1584d516 = var_9a7b5d79;
  }

  switch (var_1584d516) {
    case 0:
      level.var_deda09e = "park";
      break;
    case 1:
      level.var_deda09e = "lazar";
      break;
    case 2:
      level.var_deda09e = undefined;
      break;
  }
}

function function_cf9b0986() {
  sp = getent("lazar", "targetname");
  sp spawner::add_spawn_function(&function_9995e4d5);
  sp = getent("park", "targetname");
  sp spawner::add_spawn_function(&function_9995e4d5);
}

function function_9995e4d5() {
  level.var_c1881cdd = self;
}

function on_connect() {
  self function_48737ebb();

  if(isDefined(level.var_28c22d88) && array::contains(level.var_28c22d88, "comprimised") || level.var_28c22d88.size == 0) {
    util::function_f3cadc9a("cp_duga_player_ready");

    if(isDefined(level.var_d7d201ba) && !self flag::exists(level.var_d7d201ba)) {
      self flag::init(level.var_d7d201ba);
    }
  }
}

function function_fcc96189(oldval, newval) {
  self.var_fcd1efa7 = newval;
  println("<dev string:xe8>" + newval);
}

function on_spawned() {
  if(!isDefined(self.var_fcd1efa7)) {
    self.var_fcd1efa7 = 0;
  }

  level.player_connected = 1;
  self setcharacterbodytype(0);
  self setcharacteroutfit(0);
  self util::function_a5318821();
  wait 0.2;

  switch (level.var_28c22d88[0]) {
    case # "comprimised":
      self thread namespace_ac5221d7::function_292592aa(1);
      break;
    case # "ambush":
      self thread namespace_ac5221d7::function_292592aa(1);
      break;
    case # "loose_ends":
      self thread namespace_ac5221d7::function_a22db743(1);
      break;
    default:
      self thread namespace_ac5221d7::function_a22db743(1);
      break;
  }
}

function function_b3fbad5c(str_objective) {}

function function_a3a9332(str_objective, var_50cc0d4f) {
  level namespace_ac5221d7::function_ae1eba32();
}

function function_ef6b71e7(str_objective) {}

function function_7eb26947(str_objective, var_50cc0d4f) {
  level.var_b00240a2 = 1;
  level namespace_ac5221d7::function_ae1eba32();
}