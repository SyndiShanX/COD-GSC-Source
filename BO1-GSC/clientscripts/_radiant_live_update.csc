/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_radiant_live_update\.csc
**************************************************/

main() {
  thread scriptstruct_debug_render();
}
scriptstruct_debug_render() {
  while(1) {
    level waittill("liveupdate", selected_struct);
    if(isDefined(selected_struct)) {
      level thread render_struct(selected_struct);
    } else {
      level notify("stop_struct_render");
    }
  }
}
render_struct(selected_struct) {
  self endon("stop_struct_render");
  while(isDefined(selected_struct)) {
    Box(selected_struct.origin, (-16, -16, -16), (16, 16, 16), 0, (1, 0.4, 0.4));
    wait 0.01;
  }
}