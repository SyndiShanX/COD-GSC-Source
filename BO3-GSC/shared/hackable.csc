/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\hackable.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace hackable;

function autoexec __init__sytem__() {
  system::register("hackable", & init, undefined, undefined);
}

function init() {
  callback::on_localclient_connect( & on_player_connect);
}

function on_player_connect(localclientnum) {
  duplicate_render::set_dr_filter_offscreen("hacking", 75, "being_hacked", undefined, 2, "mc/hud_keyline_orange", 1);
}

function set_hacked_ent(local_client_num, ent) {
  if(!ent === self.hacked_ent) {
    if(isDefined(self.hacked_ent)) {
      self.hacked_ent duplicate_render::change_dr_flags(local_client_num, undefined, "being_hacked");
    }
    self.hacked_ent = ent;
    if(isDefined(self.hacked_ent)) {
      self.hacked_ent duplicate_render::change_dr_flags(local_client_num, "being_hacked", undefined);
    }
  }
}