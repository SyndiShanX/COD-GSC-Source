/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_loadoutdrop.gsc
***************************************************************/

#using script_261e315c49e5e4ef;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_util;
#namespace br_publicevent_loadoutdrop;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"loadoutdrop", &init);

  debug_init();
}

function init(eventinfo) {
  eventinfo.validatefunc = &validatefunc;
  eventinfo.activatefunc = &activatefunc;
  eventinfo.postinitfunc = &postinitfunc;
}

function activatefunc() {
  level thread function_ad91760f4f41c169(0);
  level thread function_ab8c6a785614ca99(0);
  var_70bcbf0ad5028219 = [1, 1];
  namespace_f51c41a139e03299::function_607167c18661377b(var_70bcbf0ad5028219, undefined, 1);
}

function validatefunc() {
  return true;
}

function postinitfunc() {}

function __debug() {}

function debug_init() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x34>", "<dev string:x44>", &function_db70bae7732f5204);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_db70bae7732f5204() {
  level thread scripts\mp\gametypes\br_publicevents::function_e37ee072d95a7c98(%"loadoutdrop");
}

# /