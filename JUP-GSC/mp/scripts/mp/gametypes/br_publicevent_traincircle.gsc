/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_traincircle.gsc
***************************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#namespace br_publicevent_traincircle;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"trainCircle", &init);
}

function init(eventinfo) {
  eventinfo.validatefunc = &validatefunc;
  eventinfo.postinitfunc = &postinitfunc;
  eventinfo.waitfunc = &waitfunc;
  eventinfo.canactivatefunc = &canactivatefunc;
  eventinfo.activatefunc = &activatefunc;
}

function validatefunc() {
  if(!scripts\cp_mp\utility\game_utility::function_eb4bce9b222e36ac()) {
    return false;
  }

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("circle")) {
    return false;
  }

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("trainCircle")) {
    return false;
  }

  return true;
}

function postinitfunc() {
  level.var_b8d90d6d7fcd43bc = spawnStruct();
  level.var_b8d90d6d7fcd43bc.var_e6252826301d5e3c = 1;
  level thread function_208df6f2463fdebf();
  game["dialog"]["br_pe_traincircle_name"] = "urzk_grav_rupi";
  game["dialog"]["br_pe_traincircle_description"] = "urzk_grav_rted";
}

function private function_208df6f2463fdebf() {
  level waittill("calc_circle_centers");
  level.var_b8d90d6d7fcd43bc.var_e6252826301d5e3c = 0;
}

function canactivatefunc() {
  return level.var_b8d90d6d7fcd43bc.var_e6252826301d5e3c;
}

function waitfunc() {}

function activatefunc() {
  level.var_d6abdba343a5c88f = 1;
  scripts\mp\gametypes\br_circle::applycirclesettings();
  level.var_a34a94a1dea4ff9d = 1;
  level.var_1737daa0a28a71f4 = getdvarint(@ "hash_d9e4dfff23390df", 1);
  level thread function_73fe13acea885461();
  level callback::add("on_circle_attach_to_train_pre", &function_1f30106ae9f83884);
}

function private function_73fe13acea885461() {
  level endon("game_ended");
  shouldshow = getdvarint(@ "hash_61a1077305131d3f", 0);

  if(!shouldshow) {
    return;
  }

  level waittill("infils_ready");
  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_traincircle_attach");
}

function private function_1f30106ae9f83884(params) {
  shouldshow = getdvarint(@ "hash_2c733205ce5369e4", 1);

  if(!shouldshow) {
    return;
  }

  var_36287bf5740651aa = getdvarint(@ "hash_b7c431df670a8fa3", 0);
  var_45e62ff78023a500 = level.br_level.br_circledelaytimes[level.br_circle.circleindex] + level.br_level.br_circleclosetimes[level.br_circle.circleindex];
  var_b7a0d8f63f0477da = max(var_45e62ff78023a500 - var_36287bf5740651aa, 0);
  level thread function_220c9684c37eacd9(var_b7a0d8f63f0477da);
}

function private function_220c9684c37eacd9(delaytime) {
  level endon("game_ended");
  wait delaytime;
  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_traincircle_attach");
  scripts\mp\gametypes\br_public::brleaderdialog("br_pe_traincircle_name", 1, undefined, undefined, 0, undefined, "dx_br_urzi_");
  scripts\mp\gametypes\br_public::brleaderdialog("br_pe_traincircle_description", 1, undefined, undefined, 0, undefined, "dx_br_urzi_");
}