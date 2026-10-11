/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_cfcd57998bbed90.gsc
************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_female_heads_skintone_light_nohair;
#namespace namespace_5e657191f39aeb84;

function private autoexec init() {
  character = #"hash_8a1f64bfd74ccf90";

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
    level.fncharacterxmodelalias[%"hash_28dfb486128fa91"] = &function_ecf17a96e49ab67;
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
  self setModel("c_jup_body_civ_london_female_3_1");
  scripts\code\character::attachhead("civilian_london_female_heads_skintone_light_nohair", xmodelalias\civilian_london_female_heads_skintone_light_nohair::main());
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
  precachemodel("c_jup_body_civ_london_female_3_1");
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_heads_skintone_light_nohair::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_8497e23461d7c267":
      return xmodelalias\civilian_london_female_heads_skintone_light_nohair::main();
  }

  assert(0, "c_jup_civ_london_female_03_skintone_light do not have any xmodelalias");
}