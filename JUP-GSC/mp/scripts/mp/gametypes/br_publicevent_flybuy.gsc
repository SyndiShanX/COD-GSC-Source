/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_publicevent_flybuy.gsc
*************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_deployable_kiosk;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_util;
#namespace br_publicevent_flybuy;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"flybuy", &init);
}

function init(eventinfo) {
  eventinfo.validatefunc = &validatefunc;
  eventinfo.activatefunc = &activatefunc;
  eventinfo.waitfunc = &waitfunc;
  eventinfo.postinitfunc = &postinitfunc;
}

function postinitfunc() {
  game["dialog"]["flybuy_intro"] = "flyb_grav_pest";
  game["dialog"]["flybuy_desc"] = "pblc_grav_bsnv";
}

function validatefunc() {
  return true;
}

function waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
}

function activatefunc() {
  level endon("game_ended");
  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_flybuy_start", "splash_list_br_pe_flybuy");
  scripts\mp\gametypes\br_public::brleaderdialog("flybuy_intro", 1, undefined, undefined, 1);
  function_3c4cffdc51b69fa4();
  scripts\mp\gametypes\br_public::brleaderdialog("flybuy_desc", 1, undefined, undefined, 2.5);
}

function function_3c4cffdc51b69fa4() {
  level endon("game_ended");

  if(istrue(level.circleclosing)) {
    circleindex = level.br_circle.circleindex + 1;
  } else {
    circleindex = level.br_circle.circleindex;
  }

  circlecenter = level.br_level.br_circlecenters[circleindex];
  radius = level.br_level.br_circleradii[circleindex];
  count = getdvarint(@ "scr_spawn_flybuy_buystations_count", 6);
  step = 360 / count;
  yaw = 0;

  for(i = 0; i < count; i++) {
    randompoint = scripts\mp\gametypes\br_circle::getrandompointinboundscircle(circlecenter, radius, 0.25, 0.75, 1, 1, 1, undefined, yaw, yaw + step);
    yaw += step;
    scripts\mp\gametypes\br_deployable_kiosk::function_590979ef771686a8(undefined, randompoint, 1);
  }
}