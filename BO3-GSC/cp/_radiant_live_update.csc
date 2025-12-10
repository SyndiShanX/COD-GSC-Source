/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_radiant_live_update.csc
*************************************************/

#using scripts\shared\system_shared;
#namespace radiant_live_update;

function autoexec __init__sytem__() {
  system::register("", &__init__, undefined, undefined);
}

function __init__() {
  thread scriptstruct_debug_render();
}

function scriptstruct_debug_render() {
  while(true) {
    level waittill("liveupdate", selected_struct);
    if(isDefined(selected_struct)) {
      level thread render_struct(selected_struct);
    } else {
      level notify("stop_struct_render");
    }
  }
}

function render_struct(selected_struct) {
  self endon("stop_struct_render");
  while(isDefined(selected_struct) && isDefined(selected_struct.origin)) {
    box(selected_struct.origin, vectorscale((-1, -1, -1), 16), vectorscale((1, 1, 1), 16), 0, (1, 0.4, 0.4));
    wait(0.01);
  }
}