/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5397c119e47b7171.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_asm_female_1;
#using xmodelalias\heads_civilian_asm_female_1;
#namespace namespace_2e95a8b6544e0a75;

function private autoexec init() {
  character = #"hash_e4958db611e22ef9";

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
    level.fncharacterxmodelalias[%"hash_a9cf796b687e738"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react_loco";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_civilian_asm_female_1", xmodelalias\bodies_civilian_asm_female_1::main());
  scripts\code\character::attachhead("heads_civilian_asm_female_1", xmodelalias\heads_civilian_asm_female_1::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_asm_female_1::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_asm_female_1::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_331b1d4a38c318b8":
      return xmodelalias\bodies_civilian_asm_female_1::main();
    case #"hash_c28e27e15f6e919":
      return xmodelalias\heads_civilian_asm_female_1::main();
  }

  assert(0, "character_civilian_ams_female_1 do not have any xmodelalias");
}