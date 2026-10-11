/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_221f5ecaa8ea0040.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_male_body_skintone_light;
#using xmodelalias\civilian_uk_male_heads_skintone_light;
#namespace namespace_93bd26b0e435034;

function private autoexec init() {
  character = #"hash_8e2c7e7489f38cd0";

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
    level.fncharacterxmodelalias[%"hash_4e9981f4146a36d1"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("civilian_london_male_body_skintone_light", xmodelalias\civilian_london_male_body_skintone_light::main());
  scripts\code\character::attachhead("civilian_uk_male_heads_skintone_light", xmodelalias\civilian_uk_male_heads_skintone_light::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_male_body_skintone_light::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_uk_male_heads_skintone_light::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_28ea34504bd829fd":
      return xmodelalias\civilian_london_male_body_skintone_light::main();
    case #"hash_7bbbf17f0d0279ce":
      return xmodelalias\civilian_uk_male_heads_skintone_light::main();
  }

  assert(0, "c_jup_civ_london_male_skintone_01 do not have any xmodelalias");
}