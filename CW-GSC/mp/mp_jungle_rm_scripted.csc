/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_jungle_rm_scripted.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace namespace_44084910;

function private autoexec __init__system__() {
  system::register(#"hash_21af03cfd94be6e7", &__init__, undefined, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "spawn_flavor_napalm_rumble", 1, 1, "counter", &spawn_flavor_napalm_rumble, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_gameplay_started(&on_gameplay_started);
}

function on_localclient_connect(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 8);
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 1);
}

function spawn_flavor_napalm_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = function_5c10bd79(bwastimejump);

  if(isDefined(localplayer)) {
    localplayer playrumbleonentity(bwastimejump, "napalm_rumble");
  }
}