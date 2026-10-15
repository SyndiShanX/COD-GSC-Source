/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_score.csc
*****************************************************/

#include scripts\core_common\clientfield_shared;

#namespace globallogic_score;

autoexec __init__() {
  clientfield::register("clientuimodel", "hudItems.scoreProtected", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "hudItems.minorActions.action0", 1, 1, "counter", undefined, 0, 0);
  clientfield::register("clientuimodel", "hudItems.minorActions.action1", 1, 1, "counter", undefined, 0, 0);
  clientfield::register("clientuimodel", "hudItems.hotStreak.level", 1, 3, "int", undefined, 0, 0);
}