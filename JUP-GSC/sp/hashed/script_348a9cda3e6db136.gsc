/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_348a9cda3e6db136.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_female_heads_skintone_dark_nohair;
#namespace namespace_93cce028142990cc;

function private autoexec init() {
  character = #"hash_fb0663619494b2e0";

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
    level.fncharacterxmodelalias[%"hash_40b1d02cd872a2f"] = &function_ecf17a96e49ab67;
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
  self setModel("c_jup_body_civ_london_female_3_3");
  scripts\code\character::attachhead("civilian_london_female_heads_skintone_dark_nohair", xmodelalias\civilian_london_female_heads_skintone_dark_nohair::main());
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
  precachemodel("c_jup_body_civ_london_female_3_3");
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_heads_skintone_dark_nohair::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_29ca9550f178cfc1":
      return xmodelalias\civilian_london_female_heads_skintone_dark_nohair::main();
  }

  assert(0, "c_jup_civ_london_female_03_skintone_dark do not have any xmodelalias");
}