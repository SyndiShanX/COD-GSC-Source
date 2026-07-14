/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_wrapper.gsc
**************************************************/

#using scripts\anim\battlechatter;
#namespace battlechatter_wrapper;

function evaluatemoveevent(var_2417cc6885f2aa05) {}

function evaluatereloadevent() {}

function function_c394840ed44eeeb6(enemytype, enemy) {
  battlechatter::executeevent("\x1f\x93?pK+\x9c", [enemytype, enemy]);
}

function evaluateattackevent(type) {
  battlechatter::executeevent("\x11\xf9\x9b\x01\xb2\xf4", type);
}