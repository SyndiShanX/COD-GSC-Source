/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_score.csc
*****************************************************/

#using scripts\core_common\clientfield_shared;
#namespace globallogic_score;

function autoexec __init__() {
  clientfield::register_clientuimodel("hudItems.scoreProtected", #"hud_items", #"scoreprotected", 1, 1, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.minorActions.action0", #"hud_items", [#"minoractions", #"action0"], 1, 1, "counter", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.minorActions.action1", #"hud_items", [#"minoractions", #"action1"], 1, 1, "counter", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.hotStreak.level", #"hud_items", [#"hotstreak", #"level"], 1, 3, "int", undefined, 0, 0);
}