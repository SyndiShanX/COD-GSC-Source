/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\radiant_live_update.csc
***********************************************/

#include scripts\core_common\system_shared;

#namespace radiant_live_update;

autoexec __init__system__() {
  system::register(#"radiant_live_update", &__init__, undefined, undefined);
}

__init__() {
  thread scriptstruct_debug_render();
}

scriptstruct_debug_render() {
  while(true) {
    waitresult = level waittill(#"liveupdate");

    if(isDefined(waitresult.selected_struct)) {
      level thread render_struct(waitresult.selected_struct);
      continue;
    }

    level notify(#"stop_struct_render");
  }
}

render_struct(selected_struct) {
  self endon(#"stop_struct_render");

  if(!isDefined(selected_struct.origin)) {
    return;
  }

  while(isDefined(selected_struct)) {
    box(selected_struct.origin, (-16, -16, -16), (16, 16, 16), 0, (1, 0.4, 0.4));
    waitframe(1);
  }
}

