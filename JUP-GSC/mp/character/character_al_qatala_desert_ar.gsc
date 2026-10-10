/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\character\character_al_qatala_desert_ar.gsc
**********************************************************/

#using scripts\common\utility;
#namespace character_al_qatala_desert_ar;

function private autoexec init() {
  character = #"character_al_qatala_desert_ar";

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
  self.animationarchetype = "rebel";
  self.voice = #"alqatala";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_al_qatala_desert_01");
  self attach("head_al_qatala_desert_01", "", 1);
  self.headmodel = "head_al_qatala_desert_01";
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
  precachemodel("body_al_qatala_desert_01");
  precachemodel("head_al_qatala_desert_01");
}

function precache_cpmp() {
  precache();
}