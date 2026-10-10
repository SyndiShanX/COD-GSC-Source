/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\character_civilian_me_male.gsc
*******************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_me_male_1;
#using xmodelalias\heads_civilian_me_male_1;
#namespace character_civilian_me_male;

function private autoexec init() {
  character = #"character_civilian_me_male";

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
    level.var_44bf7e31237b3073[%"character_civilian_me_male"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"fsa";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_civilian_me_male_1", xmodelalias\bodies_civilian_me_male_1::main());
  scripts\code\character::attachhead("heads_civilian_me_male_1", xmodelalias\heads_civilian_me_male_1::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_me_male_1::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_me_male_1::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_9a1e0326c664a102":
      return xmodelalias\bodies_civilian_me_male_1::main();
    case #"hash_d92591fbde4cfd85":
      return xmodelalias\heads_civilian_me_male_1::main();
  }

  assert(0, "character_civilian_me_male do not have any xmodelalias");
}