/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_maps_lighting.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace mp_maps_lighting;

autoexec __init__system__() {
  system::register(#"mp_maps_lighting", &__init__, undefined, undefined);
}

__init__() {
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