/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4eea852b7e47f853.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civilian_london_female_body_02_skintone_med;
#using xmodelalias\civilian_london_female_heads_skintone_med;
#namespace namespace_6b9ab5ef278a209b;

function private autoexec init() {
  character = #"hash_1ad2c0ee96074077";

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
    level.fncharacterxmodelalias[%"hash_62abb1cc95e5474a"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react_female";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("c_jup_civilian_london_female_body_02_skintone_med", xmodelalias\c_jup_civilian_london_female_body_02_skintone_med::main());
  scripts\code\character::attachhead("civilian_london_female_heads_skintone_med", xmodelalias\civilian_london_female_heads_skintone_med::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_civilian_london_female_body_02_skintone_med::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_heads_skintone_med::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_3c67083b0947dcef":
      return xmodelalias\c_jup_civilian_london_female_body_02_skintone_med::main();
    case #"hash_84a4bd3e2168a189":
      return xmodelalias\civilian_london_female_heads_skintone_med::main();
  }

  assert(0, "c_jup_civ_london_female_02_skintone_med do not have any xmodelalias");
}