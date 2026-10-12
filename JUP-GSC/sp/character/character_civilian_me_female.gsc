/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_civilian_me_female.gsc
******************************************************/



#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_me_female_bodies;
#using xmodelalias\civilian_me_female_heads;
#namespace character_civilian_me_female;

function private autoexec init() {
  character = #"character_civilian_me_female";

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
    level.fncharacterxmodelalias[%"character_civilian_me_female"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react_female";
  self.voice = #"fsafemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("civilian_me_female_bodies", xmodelalias\civilian_me_female_bodies::main());
  scripts\code\character::attachhead("civilian_me_female_heads", xmodelalias\civilian_me_female_heads::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\civilian_me_female_bodies::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_me_female_heads::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_2ea77bff67edb529":
      return xmodelalias\civilian_me_female_bodies::main();
    case #"hash_a5e3635a140ed050":
      return xmodelalias\civilian_me_female_heads::main();
  }

  assert(0, "character_civilian_me_female do not have any xmodelalias");
}