/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_embassy.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\load;

#namespace mp_embassy;

event_handler[level_init] main(eventstruct) {
  clientfield::register("scriptmover", "spawn_flavor_apc_explosion", 1, 1, "counter", &spawn_flavor_apc_explosion, 0, 0);
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  level.draftxcam = #"ui_cam_draft_common";
  level.var_482af62e = #"hash_12263e5d70551bf9";
  level.var_4970b0af = 1;
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_gameplay_started(&on_gameplay_started);
  load::main();
  util::waitforclient(0);
}

on_localclient_connect(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 8);
}

on_gameplay_started(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 1);
}

spawn_flavor_apc_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  model = self.model;
  forcestreamxmodel(model);
  playFX(localclientnum, "explosions/fx8_vexp_fav_buggy", self gettagorigin("tag_body_d0"), anglesToForward(self gettagangles("tag_body_d0")));
  playrumbleonposition(localclientnum, "mp_embassy_apc_explosion", self.origin);
  wait 2;
  stopforcestreamingxmodel(model);
}