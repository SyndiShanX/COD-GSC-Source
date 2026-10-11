/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_154c8e0f0c53a024.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_asm_male_5;
#using xmodelalias\heads_civilian_asm_male_5;
#namespace namespace_81ce9b00408c1c1c;

function private autoexec init() {
  character = #"hash_939869e4cc530b58";

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
    level.fncharacterxmodelalias[%"hash_2045b7f4a535175"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("bodies_civilian_asm_male_5", xmodelalias\bodies_civilian_asm_male_5::main());
  scripts\code\character::attachhead("heads_civilian_asm_male_5", xmodelalias\heads_civilian_asm_male_5::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_asm_male_5::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_asm_male_5::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_72560441517a7c15":
      return xmodelalias\bodies_civilian_asm_male_5::main();
    case #"hash_8262918ebe19c858":
      return xmodelalias\heads_civilian_asm_male_5::main();
  }

  assert(0, "character_civilian_ams_male_5 do not have any xmodelalias");
}