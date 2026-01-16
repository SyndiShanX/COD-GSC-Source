/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\multi_extracam.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace multi_extracam;

autoexec __init__system__() {
  system::register(#"multi_extracam", &__init__, undefined, undefined);
}

__init__() {
  callback::on_localclient_connect(&multi_extracam_init);
}

multi_extracam_init(localclientnum) {
  triggers = getEntArray(localclientnum, "multicam_enable", "targetname");

  for(i = 1; i <= 4; i++) {
    camerastruct = struct::get("extracam" + i, "targetname");

    if(isDefined(camerastruct)) {
      camera_ent = spawn(localclientnum, camerastruct.origin, "script_origin");
      camera_ent.angles = camerastruct.angles;
      width = isDefined(camerastruct.extracam_width) ? camerastruct.extracam_width : -1;
      height = isDefined(camerastruct.extracam_height) ? camerastruct.extracam_height : -1;
      camera_ent setextracam(i - 1, width, height);
    }
  }
}