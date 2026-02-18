/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_46a1e199a5662ca1.gsc
***********************************************/

#using script_c8d806d2487b617;
#using scripts\core_common\util_shared;
#namespace namespace_fc40d35f;

function function_d23da828() {
  gametype = function_be90acca(util::get_game_type());

  if(gametype === "fireteam_elimination") {
    return true;
  }

  return false;
}

function function_dd83b835() {
  level.var_c43aac04 = isDefined(getgametypesetting(#"hash_42e2dad88a1923f")) ? getgametypesetting(#"hash_42e2dad88a1923f") : 1;
  level.var_c465c363 = [];
  level.var_c465c363[0] = isDefined(getgametypesetting(#"hash_50db74c28a479a47")) ? getgametypesetting(#"hash_50db74c28a479a47") : 50;
  level.var_c465c363[1] = isDefined(getgametypesetting(#"hash_50db75c28a479bfa")) ? getgametypesetting(#"hash_50db75c28a479bfa") : 50;
  level.var_c465c363[2] = isDefined(getgametypesetting(#"hash_50db76c28a479dad")) ? getgametypesetting(#"hash_50db76c28a479dad") : 50;
  level.var_c465c363[3] = isDefined(getgametypesetting(#"hash_50db6fc28a4791c8")) ? getgametypesetting(#"hash_50db6fc28a4791c8") : 50;
  level.var_c465c363[4] = isDefined(getgametypesetting(#"hash_50db70c28a47937b")) ? getgametypesetting(#"hash_50db70c28a47937b") : 50;
  level.var_4fdf11d8 = isDefined(getgametypesetting(#"hash_240103f4ab18fb65")) ? getgametypesetting(#"hash_240103f4ab18fb65") : 1;
  level.var_77a24482 = int((isDefined(getgametypesetting(#"hash_96b031e14b14f60")) ? getgametypesetting(#"hash_96b031e14b14f60") : 0) * 1000);
  level.var_f87355e5 = isDefined(getgametypesetting(#"hash_319a587185662631")) ? getgametypesetting(#"hash_319a587185662631") : 1;
  level.var_a6cec0dc = int((isDefined(getgametypesetting(#"hash_3a632986946a73c4")) ? getgametypesetting(#"hash_3a632986946a73c4") : 0) * 1000);
  level.var_c4b33b66 = isDefined(getgametypesetting(#"hash_1a752e2bc25636a5")) ? getgametypesetting(#"hash_1a752e2bc25636a5") : 0;
  level.var_ee660ce0 = isDefined(getgametypesetting(#"hash_1b0c670ecc0a5d0f")) ? getgametypesetting(#"hash_1b0c670ecc0a5d0f") : 0;
  level.var_bb0c0222 = int((isDefined(getgametypesetting(#"hash_44ec378104d04bcd")) ? getgametypesetting(#"hash_44ec378104d04bcd") : 0) * 1000);
  level.var_f569833a = isDefined(getgametypesetting(#"hash_43e47c63e18d2790")) ? getgametypesetting(#"hash_43e47c63e18d2790") : 0;

  for(i = 0; i < level.var_c43aac04; i++) {
    namespace_956bd4dd::function_df1ecefe(level.var_c465c363[i], level.var_c4b33b66, i, i);
  }

  namespace_956bd4dd::function_df1ecefe(1, 1, level.var_c43aac04, level.var_c43aac04);
  var_32adf91d = 0;
  var_32adf91d++;
  namespace_956bd4dd::function_1cb3c52d(#"disable_perks", var_32adf91d, 0, #"hash_1d314eaef40aeb56");
  var_32adf91d++;
  namespace_956bd4dd::function_1cb3c52d(#"disable_perks", var_32adf91d, 0, #"hash_1d314eaef40aeb56");
  namespace_956bd4dd::function_1cb3c52d(#"hash_53d8a06b13ec49d9", var_32adf91d, 0, #"hash_5a56d7c195afe83b");
  var_32adf91d++;
  namespace_956bd4dd::function_1cb3c52d(#"disable_perks", var_32adf91d, 0, #"hash_1d314eaef40aeb56");
  namespace_956bd4dd::function_1cb3c52d(#"hash_53d8a06b13ec49d9", var_32adf91d, 0, #"hash_5a56d7c195afe83b");
  namespace_956bd4dd::function_1cb3c52d(#"dot", var_32adf91d, 0, #"hash_4a0fb4fb83a8430a");
  var_32adf91d++;
  var_32adf91d++;
}