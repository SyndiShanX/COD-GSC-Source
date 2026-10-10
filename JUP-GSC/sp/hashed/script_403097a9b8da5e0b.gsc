/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_403097a9b8da5e0b.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_cc6e6b60d5fc9e31;

function private autoexec init() {
  character = #"hash_f7d665cdbf70a9c5";

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
  self.voice = #"russian";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_enemy_pmc_shield_03");
  self attach("head_c_jup_sp_enemy_pmc_shield_03", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_shield_03";
  self setclothtype(#"vestheavy");
  self function_8abe5a968cc3c220(#"millghtgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_enemy_pmc_shield_03");
  precachemodel("head_c_jup_sp_enemy_pmc_shield_03");
}

function precache_cpmp() {
  precache();
}