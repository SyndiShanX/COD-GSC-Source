/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_fe330b67250ed3f.gsc
************************************************/

#using script_53651341190c5aab;
#using scripts\asm\asm_bb;
#using scripts\engine\utility;
#namespace namespace_3f720e0f50e8409f;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_4d7ca12cb5ce1028":
      return &startcap;
    case #"hash_96053be986d24f88":
      return &function_8add99cb1b82b964;
    case #"hash_b74f6be2a082d8a4":
      return &function_c41ad0adbb33bbd7;
    case #"hash_9910be4166a4ce32":
      return &function_67556aff182e237a;
    case #"hash_ad4d7bc640ba9c5b":
      return &function_ca8028e5808a134b;
  }

  return namespace_f901a4f9d899be59::function_efcea5d26798e5b6(funcid);
}

function startcap(statename, params) {
  walkspeed = 50;
  scripts\asm\asm_bb::bb_setcivilianstate("casual");
  scripts\asm\asm_bb::bb_civilianrequestspeed(walkspeed);
  namespace_f901a4f9d899be59::startcap(statename, params);
}

function function_8add99cb1b82b964(interactionid) {
  namespace_f901a4f9d899be59::function_25c933655d73066a(interactionid);
  return namespace_f901a4f9d899be59::function_8add99cb1b82b964(interactionid);
}

function function_c41ad0adbb33bbd7(params) {
  id = self function_92435c7a6ae85c3c();
  return function_60d6151af81a343(id, "OverflowBypass");
}

function function_67556aff182e237a(params) {
  self.var_be96bc0cf51de950 = 1;
}

function function_ca8028e5808a134b(params) {
  self.var_be96bc0cf51de950 = undefined;
}