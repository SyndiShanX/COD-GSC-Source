/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\claymore.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace claymore;

function private autoexec __init__system__() {
  system::register(#"claymore", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::add_weapon_type(#"claymore", &claymore_spawned);
}

function claymore_spawned(localclientnum) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait 0.1;
      continue;
    }

    self waittill(#"stunned");
    stopfx(localclientnum, self.claymorelaserfxid);
  }
}