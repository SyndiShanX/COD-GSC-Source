/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1ccc5c4e16b6741.gsc
************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_male_body_skintone_med;
#using xmodelalias\civilian_uk_male_heads_skintone_med;
#namespace namespace_4b103e6c7f466347;

function private autoexec init() {
  character = #"hash_fca379073af9b863";

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
    level.fncharacterxmodelalias[%"hash_39ca71bf6636af90"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("civilian_london_male_body_skintone_med", xmodelalias\civilian_london_male_body_skintone_med::main());
  scripts\code\character::attachhead("civilian_uk_male_heads_skintone_med", xmodelalias\civilian_uk_male_heads_skintone_med::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_male_body_skintone_med::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_uk_male_heads_skintone_med::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_f078727cd9c2a92b":
      return xmodelalias\civilian_london_male_body_skintone_med::main();
    case #"hash_bf18e3bb4e1e42cc":
      return xmodelalias\civilian_uk_male_heads_skintone_med::main();
  }

  assert(0, "c_jup_civ_london_male_skintone_med do not have any xmodelalias");
}