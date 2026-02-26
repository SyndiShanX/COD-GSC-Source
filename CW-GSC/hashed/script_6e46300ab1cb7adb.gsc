/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6e46300ab1cb7adb.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#namespace namespace_a43d1663;

function init(var_4bf53b01 = # "", var_76e98c1f = # "", var_2a015e7e = 0, var_f8f020e3 = 0, var_919728b0 = 5, var_c18a5a8b = var_919728b0 + 5) {
  if(var_919728b0 >= float(function_60d95f53()) / 1000) {
    wait var_919728b0;
  }

  level add(var_4bf53b01, var_76e98c1f, var_2a015e7e, var_f8f020e3);

  if(var_c18a5a8b >= float(function_60d95f53()) / 1000) {
    wait var_c18a5a8b;
  }

  level remove();
}

function private add(var_4bf53b01, var_76e98c1f, var_2a015e7e, var_f8f020e3) {
  if(namespace_61e6d095::exists(#"hash_2c29a54813fff877")) {
    namespace_61e6d095::remove(#"hash_2c29a54813fff877");
  }

  namespace_61e6d095::create(#"hash_2c29a54813fff877", #"hash_4782a7f29b84b022");
  namespace_61e6d095::function_d3c3e5c3(#"hash_2c29a54813fff877", [#"dialog_tree"]);
  namespace_61e6d095::function_9ade1d9b(#"hash_2c29a54813fff877", "text", var_4bf53b01);
  namespace_61e6d095::function_9ade1d9b(#"hash_2c29a54813fff877", "image", var_76e98c1f);
  namespace_61e6d095::function_9ade1d9b(#"hash_2c29a54813fff877", "earnedCount", var_2a015e7e);
  namespace_61e6d095::function_9ade1d9b(#"hash_2c29a54813fff877", "maxCount", var_f8f020e3);
  player = getplayers()[0];
  player playSound(#"hash_1d0d39163d572a71");
}

function remove() {
  if(namespace_61e6d095::exists(#"hash_2c29a54813fff877")) {
    namespace_61e6d095::remove(#"hash_2c29a54813fff877");
  }
}