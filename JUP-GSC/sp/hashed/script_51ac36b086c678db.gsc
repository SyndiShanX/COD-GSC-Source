/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_51ac36b086c678db.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civ_western_boy;
#using xmodelalias\heads_civ_western_boy;
#namespace namespace_101e56c5efacb7f;

function private autoexec init() {
  character = #"hash_ea6afb9310f07e4b";

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
    level.fncharacterxmodelalias[%"hash_51b9f6fa4245b552"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"fsa";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_civ_western_boy", xmodelalias\bodies_civ_western_boy::main());
  scripts\code\character::attachhead("heads_civ_western_boy", xmodelalias\heads_civ_western_boy::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civ_western_boy::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civ_western_boy::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_f3b4e6d18ab745b8":
      return xmodelalias\bodies_civ_western_boy::main();
    case #"hash_6b40d71d2f95d25":
      return xmodelalias\heads_civ_western_boy::main();
  }

  assert(0, "c_jup_civ_western_boy do not have any xmodelalias");
}