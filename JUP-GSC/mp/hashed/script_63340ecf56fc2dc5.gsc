/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_63340ecf56fc2dc5.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_7fc55966832875b1;

function private autoexec init() {
  character = #"hash_267eb65b46ea41cd";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.var_7d97144daa7995cd)) {
    level.var_7d97144daa7995cd = [];
  }

  if(!isDefined(level.var_44bf7e31237b3073)) {
    level.var_44bf7e31237b3073 = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.var_7d97144daa7995cd[character] = &precache_sp;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"shadowcompany";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_sp_ally_mex_sf_tier_1_2_1");
  self attach("head_sp_ally_mex_sf_tier_1_2_1", "", 1);
  self.headmodel = "head_sp_ally_mex_sf_tier_1_2_1";
  self setclothtype(#"cloth");
  self function_8abe5a968cc3c220(#"millghtgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_ally_mex_sf_tier_1_2_1");
  precachemodel("head_sp_ally_mex_sf_tier_1_2_1");
}

function precache_cpmp() {
  precache();
}