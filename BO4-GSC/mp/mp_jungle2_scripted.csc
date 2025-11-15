/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_jungle2_scripted.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace mp_jungle2_scripted;

autoexec __init__system__() {
  system::register(#"mp_jungle2_scripted", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "spawn_flavor_napalm_rumble", 1, 1, "counter", &spawn_flavor_napalm_rumble, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_gameplay_started(&on_gameplay_started);
}

on_localclient_connect(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 8);
}

on_gameplay_started(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 1);
}

spawn_flavor_napalm_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = function_5c10bd79(localclientnum);

  if(isDefined(localplayer)) {
    localplayer playrumbleonentity(localclientnum, "napalm_rumble");
  }
}