/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_503081a86c1539d3.gsc
*************************************************/

#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\utility;
#namespace namespace_5e75b5a54fb4603f;

function function_a57e56c880e80cdd() {
  aitypes = function_3290e192ac188e2d("zombie_base");
  base_aitype = undefined;

  foreach(aitype in aitypes) {
    strlen = aitype.size;

    if(!isDefined(base_aitype) || base_aitype.size > strlen) {
      base_aitype = aitype;
    }
  }

  var_931e0bfccfc26fa5 = base_aitype;
  level.var_ec9d44662c92bb5c = var_931e0bfccfc26fa5;
}