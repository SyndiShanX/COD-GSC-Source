/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_62e2e15ec08cf4e2.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace namespace_87e11242;

autoexec __init__system__() {
  system::register(#"hash_3ee2bcf1f7dc56c8", &init, undefined, undefined);
}

init() {
  init_fx();
  init_clientfields();
  level.var_4a2723a3 = struct::get("server_scene", "script_noteworthy");
  level.var_faee939b = struct::get_array("aat_dmg_fx", "targetname");
  level.var_1d6643ed = 0;
  array::sort_by_script_int(level.var_faee939b, 1);
}

init_fx() {
  level._effect[#"server_spark_fx"] = #"hash_620a92bcd2225e0f";
  level._effect[#"hash_170e9793dab7aa5b"] = #"hash_14eb4b8e52dfe0bb";
  level._effect[#"hash_78b4a1a435fd8bf7"] = #"hash_62f9570a97e8f893";
}

init_clientfields() {
  clientfield::register("world", "" + #"hash_31a98ee76e835504", 1, 1, "int", &function_eae1fc85, 0, 0);
  clientfield::register("world", "" + #"hash_3284b0cf34bfe44e", 1, 1, "int", &function_85c61737, 0, 0);
  clientfield::register("world", "" + #"hash_b143d97bf92fc66", 1, 1, "counter", &function_e322771e, 0, 0);
  clientfield::register("world", "" + #"hash_28f972533bb468fd", 1, 1, "int", &function_d20d32f2, 0, 0);
}

function_eae1fc85(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  s_fix_server_spark_fx = struct::get("fix_server_spark_fx", "targetname");

  if(newval == 1) {
    level.var_6171ce61 = playFX(localclientnum, level._effect[#"server_spark_fx"], s_fix_server_spark_fx.origin);
    return;
  }

  if(isDefined(level.var_6171ce61)) {
    deletefx(localclientnum, level.var_6171ce61);
  }
}

function_85c61737(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    level.var_4a2723a3 scene::play("state_no_power");
    return;
  }

  if(isDefined(level.var_be3c5a78)) {
    deletefx(localclientnum, level.var_be3c5a78);
  }
}

function_e322771e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  str_index = "" + level.var_1d6643ed;
  level.var_4a2723a3 scene::play("state_" + level.var_1d6643ed);
  level.var_1d6643ed++;
}

function_d20d32f2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.var_4a2723a3 scene::play("state_15");
}