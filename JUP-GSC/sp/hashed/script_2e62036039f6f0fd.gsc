/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2e62036039f6f0fd.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_964511d684f883a1;

function private autoexec init() {
  character = #"hash_c2239cb9a2a2190d";

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
  self.animationarchetype = "soldier_makarov_handcuffed";
  self.voice = #"russian";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("c_jup_body_sp_heroe_nikolai_convoy");
  self attach("head_hero_nikolai_blendshape_iw9", "", 1);
  self.headmodel = "head_hero_nikolai_blendshape_iw9";
  self setclothtype(#"vestlight");
  self function_8abe5a968cc3c220(#"millghtgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("c_jup_body_sp_heroe_nikolai_convoy");
  precachemodel("head_hero_nikolai_blendshape_iw9");
}

function precache_cpmp() {
  precache();
}