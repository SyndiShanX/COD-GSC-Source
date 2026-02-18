/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\planemortar.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\planemortar_shared;
#namespace planemortar;

function private autoexec __init__system__() {
  system::register(#"planemortar", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
  clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
}

function planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  params = getscriptbundle("killstreak_planemortar");
  util::waittill_dobj(fieldname);

  if(bwastimejump) {
    self.fx = util::playFXOnTag(fieldname, params.var_dcbb40c5, self, params.var_d678978c);
    self.fx = util::playFXOnTag(fieldname, params.var_2375a152, self, params.var_e5082065);
  }
}