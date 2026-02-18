/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2c6e6e28dd66dcc4.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_ping;
#namespace namespace_9d3ef6c5;

function private autoexec __init__system__() {
  system::register(#"hash_3c412421c33b7764", &preinit, undefined, undefined, undefined);
}

function preinit() {
  init_clientfields();
  zm_ping::function_5ae4a10c(undefined, "aether_tunnel", #"hash_4a0616e4966dcff5", undefined, #"hash_7d007703c89ea64a");
}

function init_clientfields() {
  clientfield::register("scriptmover", "" + # "fasttravel_playfx", 1, 2, "int", &fasttravel_playfx, 0, 0);
}

function fasttravel_playFX(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.fx = util::playFXOnTag(fieldname, #"hash_76a47d3490330bb6", self, "tag_origin");
    self.sfx = self playLoopSound("zmb_darkaether_portal_lp", undefined, (25, 0, 0));
    self function_bc183609(fieldname);
    return;
  }

  if(bwastimejump == 2) {
    self.fx = util::playFXOnTag(fieldname, #"hash_11996c3130b523ff", self, "tag_origin");
    self.sfx = self playLoopSound("zmb_darkaether_portal_lp", undefined, (25, 0, 0));
    self function_bc183609(fieldname);
    return;
  }

  if(bwastimejump == 0) {
    if(isDefined(self.fx)) {
      stopfx(fieldname, self.fx);
      self.fx = undefined;
    }

    if(isDefined(self.sfx)) {
      self stoploopsound(self.sfx);
      self.sfx = undefined;
    }

    if(isDefined(self.var_520069d0)) {
      self.var_520069d0 delete();
    }
  }
}

function private function_bc183609(localclientnum) {
  if(isDefined(self.var_520069d0)) {
    return;
  }

  self.var_520069d0 = util::spawn_model(localclientnum, #"hash_753879ed23d447bb", self.origin);
  self.var_520069d0.var_fc558e74 = "aether_tunnel";
  self.var_520069d0 function_619a5c20();
}