/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_44f4640b93ab1b47.gsc
*************************************************/

#using scripts\engine\utility;
#namespace uav_manager;

function function_360128ec8c9d243() {
  level.var_34eacc4ba5c409a7 = [];
  level thread function_8371656cac31e3e5();
  level thread function_ee39a757e5ab8fbe();
}

function function_8371656cac31e3e5() {
  level endon("game_ended");

  while(true) {
    level waittill("uav_started", uavowner, uavtype);

    if(!isDefined(uavowner) || isbot(uavowner)) {
      continue;
    }

    level.var_34eacc4ba5c409a7[uavowner getentitynumber()] = uavowner;
  }
}

function function_ee39a757e5ab8fbe() {
  level endon("game_ended");

  while(true) {
    level waittill("uav_finished", uavowner);

    if(isbot(uavowner)) {
      continue;
    }

    if(isDefined(uavowner)) {
      level.var_34eacc4ba5c409a7[uavowner getentitynumber()] = undefined;
    }

    level.var_34eacc4ba5c409a7 = array_removeundefined(level.var_34eacc4ba5c409a7);
  }
}

function function_296623d26e11725() {
  return level.var_34eacc4ba5c409a7.size > 0;
}