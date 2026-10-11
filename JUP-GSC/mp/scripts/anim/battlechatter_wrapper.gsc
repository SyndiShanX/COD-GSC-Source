/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\anim\battlechatter_wrapper.gsc
*****************************************************/

#using scripts\anim\battlechatter;
#using scripts\anim\utility_common;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace battlechatter_wrapper;

function evaluatemoveevent(wasincover) {}

function evaluatereloadevent() {}

function function_f56c2de6db70455f(enemytype, enemy) {
  executeevent("spotted", [enemytype, enemy]);
}

function evaluateattackevent(type) {
  executeevent("attack", type);
}