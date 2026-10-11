/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_995218a55dbb757.gsc
************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_female_heads_nohair;
#using xmodelalias\test_alias_civ_london_female_3_body;
#namespace namespace_da52cb1eb04dd4ad;

function private autoexec init() {
  character = #"hash_ac5419feffc26081";

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
    level.fncharacterxmodelalias[%"hash_3555c2e6a8b57416"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("test_alias_civ_london_female_3_body", xmodelalias\test_alias_civ_london_female_3_body::main());
  scripts\code\character::attachhead("civilian_london_female_heads_nohair", xmodelalias\civilian_london_female_heads_nohair::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\test_alias_civ_london_female_3_body::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_heads_nohair::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_b5da97720b51be66":
      return xmodelalias\test_alias_civ_london_female_3_body::main();
    case #"hash_4d42ed79d1742b42":
      return xmodelalias\civilian_london_female_heads_nohair::main();
  }

  assert(0, "c_jup_civ_london_female_03 do not have any xmodelalias");
}