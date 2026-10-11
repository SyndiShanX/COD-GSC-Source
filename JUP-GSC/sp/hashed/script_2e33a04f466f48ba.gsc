/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2e33a04f466f48ba.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\test_alias_civilian_male_surge_body;
#using xmodelalias\test_alias_civilian_male_surge_head;
#namespace namespace_52db1799df323fa4;

function private autoexec init() {
  character = #"hash_d9faffaa0ca9fc98";

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
    level.fncharacterxmodelalias[%"hash_7287acfc2d3d04b3"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("test_alias_civilian_male_surge_body", xmodelalias\test_alias_civilian_male_surge_body::main());
  scripts\code\character::attachhead("test_alias_civilian_male_surge_head", xmodelalias\test_alias_civilian_male_surge_head::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\test_alias_civilian_male_surge_body::main());
  scripts\code\character::precachemodelarray(xmodelalias\test_alias_civilian_male_surge_head::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_ee701c7f31892b34":
      return xmodelalias\test_alias_civilian_male_surge_body::main();
    case #"hash_d58bf93f2192efda":
      return xmodelalias\test_alias_civilian_male_surge_head::main();
  }

  assert(0, "test_character_civilian_male_surge do not have any xmodelalias");
}