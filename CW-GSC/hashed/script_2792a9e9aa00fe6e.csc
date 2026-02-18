/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2792a9e9aa00fe6e.csc
***********************************************/

#using script_14b99732aeac3ca6;
#using script_1f60f29863707208;
#using script_24f8d3e335c86c5a;
#using script_2c5f2d4e7aa698c4;
#using script_3a266261121385ee;
#using script_3dcf1dc8f679581e;
#using script_433016448b3d07bc;
#using script_5cd3f24eb1709844;
#using script_68732f44626820ed;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\archetype\archetype_zod_companion;
#using scripts\zm\zm_platinum_ww_quest;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_ping;
#using scripts\zm_common\zm_utility;
#namespace namespace_54685ebd;

function init() {
  clientfield::register("world", "" + # "hash_1c39840b9d4a1796", 24000, 1, "int", &function_1eabdf8e, 0, 0);
  clientfield::register("world", "" + # "hash_9472de3e8d1f6e1", 24000, 1, "int", &function_3bb686a9, 0, 0);
  clientfield::register("world", "" + # "hash_6f9aa7ac9543a791", 24000, 1, "int", &function_d3e5f256, 0, 0);
}

function function_1eabdf8e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    var_f5c1bd65 = struct::get("fuse_box_loc", "targetname");
    level.var_bb84f715 = playFX(fieldname, #"hash_3b9fd592c82308fa", var_f5c1bd65.origin, anglesToForward(var_f5c1bd65.angles), (0, 0, 1));
    return;
  }

  if(isDefined(level.var_bb84f715)) {
    stopfx(fieldname, level.var_bb84f715);
    level.var_bb84f715 = undefined;
  }
}

function function_3bb686a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    var_c2e428e = struct::get("switch_spark_loc", "targetname");
    level.var_c76e5c41 = playFX(fieldname, #"hash_179a76b8d709e8bb", var_c2e428e.origin, anglesToForward(var_c2e428e.angles), (0, 0, 1));
    playSound(fieldname, #"hash_487cbd8d6e939533", var_c2e428e.origin);
    return;
  }

  if(isDefined(level.var_c76e5c41)) {
    stopfx(fieldname, level.var_c76e5c41);
    level.var_c76e5c41 = undefined;
  }
}

function function_d3e5f256(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    var_a546a03e = struct::get("fuse_box_loc", "targetname");
    level.var_f9a78d10 = playFX(fieldname, #"hash_179a76b8d709e8bb", var_a546a03e.origin, anglesToForward(var_a546a03e.angles), (0, 0, 1));
    playSound(fieldname, #"hash_487cbd8d6e939533", var_a546a03e.origin);
  }
}