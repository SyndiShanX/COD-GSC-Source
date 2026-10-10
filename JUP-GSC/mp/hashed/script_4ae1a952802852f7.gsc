/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4ae1a952802852f7.gsc
*************************************************/

#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#namespace wander;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore, &createaction);
}

function evaluatescore(bot) {
  return self.constants.basescore;
}

function createaction(bot) {
  return createactionbase("wander", undefined, "main", "", &actionprocess, self);
}

function actionprocess(bot) {
  if(isDefined(level.bot_funcs["mp_wander_select_destination"])) {
    pointonnavmesh = bot[[level.bot_funcs["mp_wander_select_destination"]]]();
  } else {
    pointonnavmesh = bot selectdestination();
  }

  if(!isDefined(pointonnavmesh)) {
    return "No destination";
  }

  bot setscriptgoal(pointonnavmesh, 400);
  result = bot waittill_any_in_array_or_timeout(["goal", "bad_path", "long_path"], 15);

  if(result != "goal" && result != "timeout") {
    return result;
  }
}