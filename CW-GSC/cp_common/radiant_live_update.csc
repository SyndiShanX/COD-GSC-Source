/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\radiant_live_update.csc
***********************************************/

#using scripts\core_common\system_shared;
#namespace radiant_live_update;

function private autoexec __init__system__() {
  system::register(#"radiant_live_update", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  thread scriptstruct_debug_render();
}

function scriptstruct_debug_render() {
  while(true) {
    waitresult = level waittill(#"liveupdate");

    if(isDefined(waitresult.selected_struct)) {
      level thread render_struct(waitresult.selected_struct);
      continue;
    }

    level notify(#"stop_struct_render");
  }
}

function render_struct(selected_struct) {
  self endon(#"stop_struct_render");

  while(isDefined(selected_struct) && isDefined(selected_struct.origin)) {
    box(selected_struct.origin, (-16, -16, -16), (16, 16, 16), 0, (1, 0.4, 0.4));
    wait 0.01;
  }
}