/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_firingrange2_alt_scripted.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace mp_firingrange2_alt_scripted;

autoexec __init__system__() {
  system::register(#"mp_firingrange2_alt_scripted", &__init__, undefined, undefined);
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