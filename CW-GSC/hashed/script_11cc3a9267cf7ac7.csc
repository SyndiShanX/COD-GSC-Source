/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_11cc3a9267cf7ac7.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_98decc78;

function private autoexec __init__system__() {
  system::register(#"hash_5cb28995c23c44a", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "" + # "hash_3a86c740229275b7", 1, 3, "counter", &function_d5270d1a, 0, 0);
}

function function_d5270d1a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  util::waittill_dobj(localclientnum);

  if(!isPlayer(self)) {
    return;
  }

  self thread postfx::playpostfxbundle(#"hash_1d2ed88d1700cf24");

  if(newval === 1) {
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin Y", 1);
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin X", 0);
  } else if(newval === 2) {
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin Y", -1);
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin X", 0);
  } else if(newval === 3) {
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin Y", 0);
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin X", 1);
  } else if(newval === 4) {
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin Y", 0);
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin X", -1);
  }

  if(!isDefined(self.var_f0007ebc)) {
    self.var_f0007ebc = 0;
  }

  self thread function_28efdb7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function function_28efdb7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self.var_d5e7df0f = 1;
  self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Opacity", 0);
  self util::lerp_generic(bwastimejump, 175, &function_606248f8, self.var_f0007ebc, 1, "Opacity", #"hash_1d2ed88d1700cf24");
  self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Screen Radius Inner", 0.5);
  self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Screen Radius Outer", 0.7);
  wait 0.175;
  self util::lerp_generic(bwastimejump, 1650, &function_606248f8, self.var_f0007ebc, 0, "Opacity", #"hash_1d2ed88d1700cf24");
}

function function_606248f8(currenttime, elapsedtime, localclientnum, duration, stagefrom, stageto, constant, postfx) {
  self endon(#"death");

  if(!self postfx::function_556665f2(#"hash_1d2ed88d1700cf24")) {
    return;
  }

  percent = stagefrom / stageto;
  amount = postfx * percent + constant * (1 - percent);
  self.var_f0007ebc = amount;
  self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Opacity", amount);
}