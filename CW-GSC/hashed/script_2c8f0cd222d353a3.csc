/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2c8f0cd222d353a3.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace namespace_daf1661f;

function init() {
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned(local_client_num) {
  level callback::function_6231c19(&on_weapon_change);
}

function on_weapon_change(params) {
  if(params.weapon.name == # "none") {
    return;
  }

  if(isstruct(self)) {
    return;
  }

  if(!self function_da43934d() || !isPlayer(self) || !isalive(self)) {
    return;
  }

  function_fad60cb1(params.localclientnum, params.weapon);
}