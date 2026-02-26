/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_13114d8a31c6152a.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\math_shared;
#namespace namespace_c8e236da;

function function_ebf737f8(var_e11b5b56) {
  if(!isDefined(level.var_f9c1d7d5)) {
    level.var_f9c1d7d5 = [];
  }

  level.var_f9c1d7d5[level.var_f9c1d7d5.size] = var_e11b5b56;

  if(!namespace_61e6d095::exists(#"hash_72cc4740fa4d3da3")) {
    namespace_61e6d095::create(#"hash_72cc4740fa4d3da3", #"hash_33da613c2715b7bb");
    namespace_61e6d095::function_46df0bc7(#"hash_72cc4740fa4d3da3", 999);
    namespace_61e6d095::function_d3c3e5c3(#"hash_72cc4740fa4d3da3", [#"interactive_map", #"dialog_tree", #"computer"]);
  }

  namespace_61e6d095::function_9ade1d9b(#"hash_72cc4740fa4d3da3", #"hash_732287e2565c2a79", 1, 1);
  namespace_61e6d095::function_f2a9266(#"hash_72cc4740fa4d3da3", level.var_f9c1d7d5.size, "ContentLine", var_e11b5b56, undefined, 1);
}

function function_abdf062(var_5a95d718, var_144abf82) {
  if(isDefined(level.var_f9c1d7d5)) {
    var_5a95d718 = math::clamp(var_5a95d718, 0, level.var_f9c1d7d5.size - 1);
    arrayinsert(level.var_f9c1d7d5, var_144abf82, var_5a95d718);

    for(i = var_5a95d718; i < level.var_f9c1d7d5.size; i++) {
      namespace_61e6d095::function_f2a9266(#"hash_72cc4740fa4d3da3", i + 1, "ContentLine", level.var_f9c1d7d5[i], undefined, 1);
    }

    return;
  }

  function_ebf737f8(var_144abf82);
}

function function_bf642b41(var_88e62a80, var_6262df45) {
  if(isDefined(var_6262df45)) {
    namespace_61e6d095::function_f2a9266(#"hash_72cc4740fa4d3da3", var_88e62a80 + 1, "ContentLine", var_6262df45);
    return;
  }

  namespace_61e6d095::function_7239e030(#"hash_72cc4740fa4d3da3", var_88e62a80 + 1);
  arrayremoveindex(level.var_f9c1d7d5, var_88e62a80);
}

function function_295a2a9e(var_e11b5b56) {
  if(!isDefined(level.var_f9c1d7d5)) {
    return 0;
  }

  return isinarray(level.var_f9c1d7d5, var_e11b5b56);
}

function function_f7362969(var_a5a2c782, var_541423e6 = 1) {
  if(var_541423e6) {
    namespace_61e6d095::function_df0d7a85(var_a5a2c782, #"hash_72cc4740fa4d3da3");
    return;
  }

  namespace_61e6d095::function_f96376c5(var_a5a2c782);
}

function clearlist() {
  if(namespace_61e6d095::exists(#"hash_72cc4740fa4d3da3")) {
    if(level.var_f9c1d7d5.size > 0) {
      for(i = 1; i < level.var_f9c1d7d5.size + 1; i++) {
        namespace_61e6d095::function_f2a9266(#"hash_72cc4740fa4d3da3", i, "ContentLine", #"");
      }
    }
  }
}

function removelist() {
  clearlist();

  if(namespace_61e6d095::exists(#"hash_72cc4740fa4d3da3")) {
    level.var_f9c1d7d5 = undefined;
    namespace_61e6d095::remove(#"hash_72cc4740fa4d3da3");
  }
}