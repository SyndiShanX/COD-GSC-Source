/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_multi_extracam.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace multi_extracam;

function autoexec __init__sytem__() {
  system::register("multi_extracam", & __init__, undefined, undefined);
}

function __init__(localclientnum) {
  callback::on_localclient_connect( & multi_extracam_init);
}

function multi_extracam_init(localclientnum) {
  triggers = getentarray(localclientnum, "multicam_enable", "targetname");
  for (i = 1; i <= 4; i++) {
    camerastruct = struct::get("extracam" + i, "targetname");
    if(isdefined(camerastruct)) {
      camera_ent = spawn(localclientnum, camerastruct.origin, "script_origin");
      camera_ent.angles = camerastruct.angles;
      width = (isdefined(camerastruct.extracam_width) ? camerastruct.extracam_width : -1);
      height = (isdefined(camerastruct.extracam_height) ? camerastruct.extracam_height : -1);
      camera_ent setextracam(i - 1, width, height);
    }
  }
}