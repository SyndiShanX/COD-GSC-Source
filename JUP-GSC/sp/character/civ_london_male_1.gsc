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

  if(!isDefined(level.fncharacterprecache)) {
    level.fncharacterprecache = [];
  }

  if(!isDefined(level.fncharacterxmodelalias)) {
    level.fncharacterxmodelalias = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.fncharacterprecache[character] = &precache_sp;
    level.fncharacterxmodelalias[%"civ_london_male_1"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("civ_london_male_1", xmodelalias\civ_london_male_1::main());
  scripts\code\character::attachhead("test_civ_picc_heads", xmodelalias\test_civ_picc_heads::main());
  self setclothtype(#"vestlight");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

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