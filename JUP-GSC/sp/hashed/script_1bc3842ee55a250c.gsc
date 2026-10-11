/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1bc3842ee55a250c.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_asm_female_3;
#using xmodelalias\heads_civilian_asm_female_3;
#namespace namespace_b69519c261f5d840;

function private autoexec init() {
  character = #"hash_e0f3f1c9975bdd1c";

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
    level.fncharacterxmodelalias[%"hash_6d94b79c69bcfa3d"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("bodies_civilian_asm_female_3", xmodelalias\bodies_civilian_asm_female_3::main());
  scripts\code\character::attachhead("heads_civilian_asm_female_3", xmodelalias\heads_civilian_asm_female_3::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_asm_female_3::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_asm_female_3::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_331b1f4a38c31bde":
      return xmodelalias\bodies_civilian_asm_female_3::main();
    case #"hash_c28e07e15f6e5f3":
      return xmodelalias\heads_civilian_asm_female_3::main();
  }

  assert(0, "character_civilian_ams_female_3_sitting do not have any xmodelalias");
}