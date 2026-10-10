/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_60d10848dac5bd08.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_5a51621a8d5df346;

function private autoexec init() {
  character = #"hash_d1cd85675b186662";

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
  self.voice = #"sas";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_enemy_pmc_grunt_02");
  self attach("head_c_jup_sp_enemy_pmc_grunt_02", "", 1);
  self.headmodel = "head_c_jup_sp_enemy_pmc_grunt_02";
  self setclothtype(#"vestlight");
  self function_8abe5a968cc3c220(#"milmedgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_02");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_02");
}

function precache_cpmp() {
  precache();
}