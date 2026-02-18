/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\repulsor.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace repulsor;

function private autoexec __init__system__() {
  system::register(#"repulsor", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("vehicle", "pulse_fx", 1, 1, "counter", &pulsefxhandler, 0, 0);
}

function private pulsefxhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  self endon(#"death");

  if(!isDefined(self)) {
    return;
  }

  self notify(#"pulsefx");
  self endon(#"pulsefx");

  if(wasdemojump) {
    self playSound(0, #"hash_32a17ce5991f5801");
    self mapshaderconstant(fieldname, 0, "scriptVector2", 0, 1);
    wait 1;
  }

  self mapshaderconstant(fieldname, 0, "scriptVector2", 0, 0.2);
}