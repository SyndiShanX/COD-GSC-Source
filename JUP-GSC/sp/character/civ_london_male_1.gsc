/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\civ_london_male_1.gsc
***********************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civ_london_male_1;
#using xmodelalias\test_civ_picc_heads;
#namespace civ_london_male_1;

function private autoexec init() {
  character = #"civ_london_male_1";

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
    level.var_44bf7e31237b3073[%"civ_london_male_1"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("civ_london_male_1", xmodelalias\civ_london_male_1::main());
  scripts\code\character::attachhead("test_civ_picc_heads", xmodelalias\test_civ_picc_heads::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\civ_london_male_1::main());
  scripts\code\character::precachemodelarray(xmodelalias\test_civ_picc_heads::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_9f920eda3290e338":
      return xmodelalias\civ_london_male_1::main();
    case #"hash_9a07ec9827099f3c":
      return xmodelalias\test_civ_picc_heads::main();
  }

  assert(0, "civ_london_male_1 do not have any xmodelalias");
}