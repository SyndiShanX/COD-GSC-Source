/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_54c0478b7e9d6d81.csc
***********************************************/

#using scripts\core_common\system_shared;
#namespace gadget_clone_render;

function private autoexec __init__system__() {
  system::register(#"gadget_clone_render", &preinit, undefined, undefined, undefined);
}

function private preinit() {}

function transition_shader(localclientnum) {
  self endon(#"death");
  self endon(#"clone_shader_off");
  rampinshader = 0;

  while(rampinshader < 1) {
    if(isDefined(self)) {
      self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, rampinshader, 0, 0.04);
    }

    rampinshader += 0.04;
    waitframe(1);
  }
}