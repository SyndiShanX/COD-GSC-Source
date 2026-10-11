/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_65e7570ed0fea149.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_asm_male_2;
#using xmodelalias\heads_civilian_asm_male_2;
#namespace namespace_81ce9a00408c19e9;

function private autoexec init() {
  character = #"hash_939870e4cc53173d";

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
    level.fncharacterxmodelalias[%"hash_204547f4a534590"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react_loco";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_civilian_asm_male_2", xmodelalias\bodies_civilian_asm_male_2::main());
  scripts\code\character::attachhead("heads_civilian_asm_male_2", xmodelalias\heads_civilian_asm_male_2::main());
  self setclothtype(#"cloth");
  self setgeartype(#"wstlghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_asm_male_2::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_asm_male_2::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_7255fd41517a7110":
      return xmodelalias\bodies_civilian_asm_male_2::main();
    case #"hash_8262988ebe19d35d":
      return xmodelalias\heads_civilian_asm_male_2::main();
  }

  assert(0, "character_civilian_ams_male_2 do not have any xmodelalias");
}