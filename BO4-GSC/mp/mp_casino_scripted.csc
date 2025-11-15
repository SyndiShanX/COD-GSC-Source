/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_casino_scripted.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace mp_casino_scripted;

autoexec __init__system__() {
  system::register(#"mp_casino_scripted", &__init__, undefined, undefined);
}

__init__() {
  callback::on_gameplay_started(&on_gameplay_started);
  callback::on_end_game(&on_end_game);
}

on_gameplay_started(localclientnum) {
  level thread function_5a9c338e(localclientnum);
}

function_5a9c338e(localclientnum) {
  level endon(#"hash_d5c5c322d0ccf8");
  a_v_pa[0] = (33, -1286, 292);
  a_v_pa[1] = (477, -919, 297);
  a_v_pa[2] = (-434, -961, 309);
  a_str_lines = array(#"hash_27b25c569e7a0e52", #"hash_27b25d569e7a1005", #"hash_27b25a569e7a0aec", #"hash_27b25b569e7a0c9f", #"hash_27b258569e7a0786", #"hash_27b259569e7a0939", #"hash_27b256569e7a0420", #"hash_27b257569e7a05d3", #"hash_27b264569e7a1bea", #"hash_27b265569e7a1d9d", #"hash_6e24cf2f49698a0f");
  wait 8;

  foreach(line in a_str_lines) {
    foreach(v_pa in a_v_pa) {
      playSound(localclientnum, line, v_pa);
    }

    wait randomfloatrange(35, 45);
  }
}

on_end_game(localclientnum) {
  level notify(#"hash_d5c5c322d0ccf8");
}