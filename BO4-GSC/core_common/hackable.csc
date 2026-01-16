/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\hackable.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\duplicaterender_mgr;
#include scripts\core_common\system_shared;

#namespace hackable;

autoexec __init__system__() {
  system::register(#"hackable", &init, undefined, undefined);
}

init() {
  callback::on_localclient_connect(&on_player_connect);
}

on_player_connect(localclientnum) {
  duplicate_render::set_dr_filter_offscreen("hacking", 75, "being_hacked", undefined, 2, "mc/hud_keyline_orange", 1);
}

set_hacked_ent(local_client_num, ent) {
  if(!(ent === self.hacked_ent)) {
    if(isDefined(self.hacked_ent)) {
      self.hacked_ent duplicate_render::change_dr_flags(local_client_num, undefined, "being_hacked");
    }

    self.hacked_ent = ent;

    if(isDefined(self.hacked_ent)) {
      self.hacked_ent duplicate_render::change_dr_flags(local_client_num, "being_hacked", undefined);
    }
  }
}