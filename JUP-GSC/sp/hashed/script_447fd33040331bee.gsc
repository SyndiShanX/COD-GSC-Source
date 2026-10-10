/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_447fd33040331bee.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_fbbb7653df37fc26;

function private autoexec init() {
  character = #"hash_1ae8f329a30ab62a";

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
  self setModel("body_sp_opforce_pmc_with_strap_1_1");
  self attach("head_sp_opforce_pmc_no_goggles_3_1", "", 1);
  self.headmodel = "head_sp_opforce_pmc_no_goggles_3_1";
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
  precachemodel("body_sp_opforce_pmc_with_strap_1_1");
  precachemodel("head_sp_opforce_pmc_no_goggles_3_1");
}

function precache_cpmp() {
  precache();
}