/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_molotov.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_weap_molotov;

function private autoexec __init__system__() {
  system::register(#"molotov_zm", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "molotov_zm_fire_fx", 1, 1, "int", &molotov_zm_fire_fx, 0, 0);
}

function molotov_zm_fire_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump) {
    self.var_e9d782a8 = playtagfxset(fieldname, "weapon_hero_molotov_fire_3p", self);
    return;
  }

  if(isDefined(self.var_e9d782a8)) {
    foreach(fx_id in self.var_e9d782a8) {
      stopfx(fieldname, fx_id);
    }
  }
}