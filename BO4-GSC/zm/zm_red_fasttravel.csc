/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_fasttravel.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_fasttravel;

#namespace zm_red_fasttravel;

init() {
  clientfield::register("toplayer", "column_to_park", 16000, 2, "int", &function_ec7e76a8, 0, 0);
  clientfield::register("toplayer", "column_to_fountain", 16000, 2, "int", &function_ec7e76a8, 0, 0);
  clientfield::register("toplayer", "fountain_to_park", 16000, 2, "int", &function_ec7e76a8, 0, 0);
  clientfield::register("toplayer", "fountain_to_column", 16000, 2, "int", &function_ec7e76a8, 0, 0);
  clientfield::register("toplayer", "park_to_column", 16000, 2, "int", &function_ec7e76a8, 0, 0);
  clientfield::register("toplayer", "park_to_fountain", 16000, 2, "int", &function_ec7e76a8, 0, 0);
  clientfield::register("allplayers", "" + #"hash_52693a3ba1bbc7ea", 16000, 1, "counter", &override_fasttravel_end_fx, 0, 0);
  clientfield::register("world", "" + #"hash_761511e09cb8324e", 16000, 1, "int", &function_e968fd4f, 0, 0);
  clientfield::register("scriptmover", "" + #"forcestream_crafted_item", 16000, 1, "int", &forcestream_crafted_item, 0, 0);
  level._effect[#"hash_7844498a1d0272cf"] = #"hash_36a8758df9221bce";
  level._effect[#"hash_1485000e3492adb9"] = #"hash_240783e54de51f0";
  level._effect[#"hash_359655df3976b4e0"] = #"hash_4df6f1dbc41bc9c3";
  level._effect[#"override_fasttravel_end_fx"] = #"hash_50655ac7dc942305";
}

main() {
  num = getdvarint(#"splitscreen_playercount", 0);

  if(num < 1) {
    num = 1;
  }

  for(localclientnum = 0; localclientnum < num; localclientnum++) {
    util::waitforclient(localclientnum);
  }

  if(!isDefined(level.var_3958c9ff)) {
    level.var_3958c9ff = [];
  } else if(!isarray(level.var_3958c9ff)) {
    level.var_3958c9ff = array(level.var_3958c9ff);
  }

  var_3958c9ff = struct::get_array("fasttravel_trigger");
  a_e_players = getlocalplayers();

  foreach(var_de3a312c in var_3958c9ff) {
    level.var_3958c9ff[var_de3a312c.script_string] = var_de3a312c;

    if(!isDefined(var_de3a312c.var_1b5be828)) {
      var_de3a312c.var_1b5be828 = [];
    } else if(!isarray(var_de3a312c.var_1b5be828)) {
      var_de3a312c.var_1b5be828 = array(var_de3a312c.var_1b5be828);
    }

    for(i = 0; i < a_e_players.size; i++) {
      var_de3a312c.var_1b5be828[i] = util::spawn_model(i, "tag_origin", var_de3a312c.origin + (0, 0, -16), var_de3a312c.angles);
    }
  }
}

function_ec7e76a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  while(!isDefined(level.var_3958c9ff)) {
    waitframe(1);
  }

  var_1b5be828 = level.var_3958c9ff[fieldname].var_1b5be828[localclientnum];

  if(!isDefined(var_1b5be828)) {
    return;
  }

  if(isDefined(var_1b5be828.var_b3673abf)) {
    var_1b5be828 stoploopsound(var_1b5be828.var_b3673abf);
  }

  if(isDefined(var_1b5be828.n_fx_id)) {
    deletefx(localclientnum, var_1b5be828.n_fx_id);
    var_1b5be828.n_fx_id = undefined;
  }

  switch (newval) {
    case 0:
      var_1b5be828.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"hash_359655df3976b4e0"], var_1b5be828, "tag_origin");
      break;
    case 1:
      var_1b5be828.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"hash_7844498a1d0272cf"], var_1b5be828, "tag_origin");
      var_1b5be828.var_b3673abf = var_1b5be828 playLoopSound(#"hash_67c353461c5e3f2c");
      var_1b5be828 playSound(localclientnum, #"hash_2cc8c6c1b8e764b9");
      break;
    case 2:
      var_1b5be828.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"hash_1485000e3492adb9"], var_1b5be828, "tag_origin");
      var_1b5be828.var_b3673abf = var_1b5be828 playLoopSound(#"hash_27fed7313de44e58");
      var_1b5be828 playSound(localclientnum, #"hash_3cf81bf9f70bc77d");
      break;
  }
}

override_fasttravel_end_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread zm_fasttravel::play_fasttravel_end_fx(localclientnum, "override_fasttravel_end_fx");
  }
}

function_e968fd4f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    forcestreamxmodel(#"p8_wz_foliage_tree_oak_md");
    return;
  }

  stopforcestreamingxmodel(#"p8_wz_foliage_tree_oak_md");
}

forcestream_crafted_item(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    forcestreamxmodel(self.model);
    return;
  }

  stopforcestreamingxmodel(self.model);
}