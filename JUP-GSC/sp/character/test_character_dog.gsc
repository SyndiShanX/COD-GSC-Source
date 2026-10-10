/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\test_character_dog.gsc
***********************************************/

#using scripts\common\utility;
#namespace test_character_dog;

function private autoexec init() {
  character = #"test_character_dog";

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
  self.animationarchetype = "dog";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "dog";
  self setModel("fullbody_dog_c");
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
  precachemodel("fullbody_dog_c");
}

function precache_cpmp() {
  precache();
}