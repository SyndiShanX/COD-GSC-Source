/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_73b1682d44226c3f.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_94e1a44d0608be01;

function private autoexec init() {
  character = #"hash_e671d37e39277eed";

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
  self.voice = #"unitedstates";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_sp_ally_usmc_ar_1_1");
  self attach("head_sp_ally_usmc_ar_1_1", "", 1);
  self.headmodel = "head_sp_ally_usmc_ar_1_1";
  self setclothtype(#"vestheavy");
  self function_8abe5a968cc3c220(#"milhvygr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_ally_usmc_ar_1_1");
  precachemodel("head_sp_ally_usmc_ar_1_1");
}

function precache_cpmp() {
  precache();
}