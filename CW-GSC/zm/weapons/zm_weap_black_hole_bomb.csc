/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_black_hole_bomb.csc
**************************************************/

#using scripts\core_common\ai\zombie_vortex;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_weap_black_hole_bomb;

function private autoexec __init__system__() {
  system::register(#"zm_weap_black_hole_bomb", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "" + # "hash_399ab6541d717dc7", 1, 1, "int", &function_9c02e124, 0, 0);
}

function private function_9c02e124(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(!is_true(bwastimejump) && isDefined(self.var_937df95)) {
    stopfx(fieldname, self.var_937df95);
    return;
  }

  self util::waittill_dobj(fieldname);
  tag = self haspart(fieldname, "j_spine4") ? "j_spine4" : "tag_origin";
  self.var_937df95 = self util::playFXOnTag(fieldname, "sr/fx9_obj_secure_soul_trail", self, tag);
}