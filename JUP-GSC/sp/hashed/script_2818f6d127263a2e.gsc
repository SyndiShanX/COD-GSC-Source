/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2818f6d127263a2e.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_female_heads_skintone_med_nohair;
#namespace namespace_1145ff44a7cb93a6;

function private autoexec init() {
  character = #"hash_53e087a7d2a7ebd2";

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
    level.fncharacterxmodelalias[%"hash_1187a0aa38b3b92f"] = &function_ecf17a96e49ab67;
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
  self setModel("c_jup_body_civ_london_female_3_2");
  scripts\code\character::attachhead("civilian_london_female_heads_skintone_med_nohair", xmodelalias\civilian_london_female_heads_skintone_med_nohair::main());
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
  precachemodel("c_jup_body_civ_london_female_3_2");
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_heads_skintone_med_nohair::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_599b0f30decbff15":
      return xmodelalias\civilian_london_female_heads_skintone_med_nohair::main();
  }

  assert(0, "c_jup_civ_london_female_03_skintone_med do not have any xmodelalias");
}