/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\character_hero_hadir_prisoner.gsc
**********************************************************/

#using scripts\common\utility;
#namespace character_hero_hadir_prisoner;

function private autoexec init() {
  character = #"character_hero_hadir_prisoner";

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
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_hero_hadir_prisoner");
  self attach("head_hero_hadir_teen_blendshape", "", 1);
  self.headmodel = "head_hero_hadir_teen_blendshape";
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
  precachemodel("body_hero_hadir_prisoner");
  precachemodel("head_hero_hadir_teen_blendshape");
}

function precache_cpmp() {
  precache();
}