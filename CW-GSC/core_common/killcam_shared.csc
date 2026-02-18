/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\killcam_shared.csc
***********************************************/

#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace killcam;

function private autoexec __init__system__() {
  system::register(#"killcam", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(sessionmodeiszombiesgame()) {
    return;
  }

  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_killcam_begin(&on_killcam_begin);
  callback::on_killcam_end(&on_killcam_end);
  callback::function_9fcd5f60(&function_9fcd5f60);
  callback::add_callback(#"hash_1184c2c2ed4c24b3", &function_c8bff20a);
}

function on_localclient_connect(localclientnum) {
  if(!isDefined(level.killcam)) {
    level.killcam = [];
  }

  if(!isDefined(level.killcam[localclientnum])) {
    level.killcam[localclientnum] = {};
  }
}

function function_c8bff20a(eventstruct) {
  if(eventstruct.gamestate === # "pregame") {
    function_bb763df8(eventstruct.localclientnum);
  }
}

function function_549a01b9(localclientnum) {
  if(codcaster::function_b8fe9b52(localclientnum)) {
    return;
  }

  if(function_56e2eaa8(self) && isDefined(level.killcam[localclientnum]) && game.state !== # "pregame") {
    level.killcam[localclientnum].var_57426003 = util::getnextobjid(localclientnum);
    objective_add(localclientnum, level.killcam[localclientnum].var_57426003, "active", #"hash_e8ccf98fcea7a36", (0, 0, -10000));
    objective_onentity(localclientnum, level.killcam[localclientnum].var_57426003, self, 0, 0, 0);
  }
}

function function_bb763df8(localclientnum) {
  if(isDefined(level.killcam[localclientnum]) && isDefined(level.killcam[localclientnum].var_57426003)) {
    util::releaseobjid(localclientnum, level.killcam[localclientnum].var_57426003);
    objective_delete(localclientnum, level.killcam[localclientnum].var_57426003);
    level.killcam[localclientnum].var_57426003 = undefined;
  }
}

function on_killcam_begin(params) {
  player = function_27673a7(params.localclientnum);

  if(!isDefined(player)) {
    return;
  }

  number = player getentitynumber();
  test_player = getentbynum(params.localclientnum, number);

  if(test_player !== player) {
    return;
  }

  player function_2362a697(params.localclientnum, params.bundle);
  function_bb763df8(params.localclientnum);
  player function_549a01b9(params.localclientnum);
}

function on_killcam_end(params) {
  function_bb763df8(params.localclientnum);
  player = function_27673a7(params.localclientnum);

  if(!isDefined(player)) {
    return;
  }

  player function_dc3fa738(params.localclientnum);
}

function function_9fcd5f60(params) {
  player = function_27673a7(params.localclientnum);

  if(!isDefined(player)) {
    return;
  }

  player function_dc3fa738(params.localclientnum);
  player function_2362a697(params.localclientnum, params.bundle);
  function_bb763df8(params.localclientnum);
  player function_549a01b9(params.localclientnum);
}

function function_2362a697(localclientnum, script_bundle) {
  if(isDefined(level.killcam[localclientnum]) && isDefined(script_bundle)) {
    var_c8b06dda = script_bundle.("posteffect");

    if(isDefined(var_c8b06dda)) {
      self codeplaypostfxbundle(var_c8b06dda);
      level.killcam[localclientnum].var_c6128b93 = var_c8b06dda;
    }
  }
}

function function_dc3fa738(localclientnum) {
  if(isDefined(level.killcam[localclientnum].var_c6128b93)) {
    self codestoppostfxbundle(level.killcam[localclientnum].var_c6128b93);
    level.killcam[localclientnum].var_c6128b93 = undefined;
  }
}