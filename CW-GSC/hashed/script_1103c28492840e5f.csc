/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1103c28492840e5f.csc
***********************************************/

#using script_2bdd098a8215ac9f;
#using script_4ed01237ecbd380f;
#using script_538e87197f25d67;
#using script_5665e7d917abc3fc;
#using script_62c72c96978f9b04;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\objective_manager;
#namespace namespace_73df937d;

function private autoexec __init__system__() {
  system::register(#"hash_5ff56dba9074b0b4", &preinit, undefined, undefined, undefined);
}

function preinit() {
  level clientfield::register("scriptmover", "safehouse_claim_fx", 1, 1, "int", &safehouse_claim_fx, 0, 0);
}

function safehouse_claim_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.fxid = function_239993de(fieldname, "sr/fx9_safehouse_orb_idle", self, "tag_origin");

    if(!isDefined(self.var_94ebeb0a)) {
      self.var_94ebeb0a = self playLoopSound(#"hash_53c30ccf24ec3701");
    }

    return;
  }

  if(isDefined(self.fxid)) {
    killfx(fieldname, self.fxid);
  }

  if(isDefined(self.var_94ebeb0a)) {
    self stoploopsound(self.var_94ebeb0a);
    self.var_94ebeb0a = undefined;
  }

  playFX(fieldname, "sr/fx9_safehouse_orb_activate", self.origin);
  playSound(fieldname, #"hash_71e3b0dd2c4a7490", self.origin);
}