/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_326bc91b281ccf55.gsc
*************************************************/

#using script_27fdece778e999d8;
#using script_59ff79d681bb860c;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace namespace_22333af54656799d;

function main() {
  setup_callbacks();
  setup_bot_brtdm();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  initialize();
  level.bot_funcs["mp_wander_select_destination"] = &function_90aa80a0d854dd5d;
}

function setup_bot_brtdm() {
  allieshq = level.brtdm_config.spawnorigin["allies"];
  axishq = level.brtdm_config.spawnorigin["axis"];
  level.var_24991391ba4dcb18 = vectornormalize2(allieshq - axishq);
  level.var_3d6c69ce45dea7d7 = (allieshq - axishq) * 0.5 + axishq;
  level.var_32e9fb0b5827e025 = vectornormalize2(level.brtdm_config.circlecenter - level.var_3d6c69ce45dea7d7);
  level.var_8d51410017e80cd1 = (level.brtdm_config.circleradius - distance2d(level.brtdm_config.circlecenter, level.var_3d6c69ce45dea7d7)) * 0.8;
  level.var_3fa58ccdbda67f38 = level.var_8d51410017e80cd1 * 0.2;
}

function function_90aa80a0d854dd5d() {
  randompoint = level.var_3d6c69ce45dea7d7 + (randomfloat(2) - 1) * level.var_8d51410017e80cd1 * level.var_32e9fb0b5827e025 + (randomfloat(2) - 1) * level.var_3fa58ccdbda67f38 * level.var_24991391ba4dcb18;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  randompoint = scripts\engine\utility::drop_to_ground((randompoint[0], randompoint[1], 4000), undefined, undefined, undefined, contents);
  randompoint = function_207ba502560fa1d2(randompoint);
  return randompoint;
}