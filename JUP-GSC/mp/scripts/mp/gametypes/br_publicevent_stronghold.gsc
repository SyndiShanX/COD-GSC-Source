/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_publicevent_stronghold.gsc
*****************************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_util;
#namespace br_publicevent_stronghold;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"stronghold", &init);
}

function init(eventinfo) {
  eventinfo.validatefunc = &validatefunc;
  eventinfo.activatefunc = &activatefunc;
  eventinfo.waitfunc = &waitfunc;
  eventinfo.postinitfunc = &postinitfunc;
}

function postinitfunc() {
  level thread function_1386247d217a2b2e();
}

function function_1386247d217a2b2e() {
  level endon("br_stronghold_pe_start");
  level waittill_any_2("br_pe_start", "br_pe_no_event");
  level.var_b098cf330b024cb9 = 0;
  level notify("br_stronghold_pe_start");
}

function validatefunc() {
  return true;
}

function waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  waittime = getdvarfloat(@ "hash_ea37831ad1304a1c", 0);
  wait waittime;
}

function activatefunc() {
  level endon("game_ended");
  level notify("br_stronghold_pe_start");
}