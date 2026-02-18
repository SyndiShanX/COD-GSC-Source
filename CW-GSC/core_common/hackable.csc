/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\hackable.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace hackable;

function private autoexec __init__system__() {
  system::register(#"hackable", &init, undefined, undefined, undefined);
}

function init() {
  callback::on_localclient_connect(&on_player_connect);
}

function on_player_connect(localclientnum) {}

function set_hacked_ent(local_client_num, ent) {
  if(ent !== self.hacked_ent) {
    if(isDefined(self.hacked_ent)) {}

    self.hacked_ent = ent;

    if(isDefined(self.hacked_ent)) {}
  }
}