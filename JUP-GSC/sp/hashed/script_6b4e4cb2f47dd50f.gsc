/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6b4e4cb2f47dd50f.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_6cbbf28f4ffa9ff3;

function private autoexec init() {
  character = #"hash_438794d65fae84f";

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
  self.animationarchetype = "civilian_react_female";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_npc_f_whiskey_hacker");
  self attach("head_c_jup_sc_f_miller_whiskey_hacker", "", 1);
  self.headmodel = "head_c_jup_sc_f_miller_whiskey_hacker";
  self setclothtype(#"nylon");
  self function_8abe5a968cc3c220(#"none");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_npc_f_whiskey_hacker");
  precachemodel("head_c_jup_sc_f_miller_whiskey_hacker");
}

function precache_cpmp() {
  precache();
}