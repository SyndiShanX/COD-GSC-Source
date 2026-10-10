/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\c_jup_sp_enemy_pmc_grunt_03_winter.gsc
***************************************************************/

#using scripts\common\utility;
#namespace c_jup_sp_enemy_pmc_grunt_03_winter;

function private autoexec init() {
  character = #"c_jup_sp_enemy_pmc_grunt_03_winter";

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
  self setModel("body_c_jup_sp_enemy_pmc_grunt_03_winter");
  self attach("head_c_jup_sp_enemy_pmc_grunt_03", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_grunt_03";
  self setclothtype(#"nylon");
  self function_8abe5a968cc3c220(#"millghtgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_03_winter");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_03");
}

function precache_cpmp() {
  precache();
}