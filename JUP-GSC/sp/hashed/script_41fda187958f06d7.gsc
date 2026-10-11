/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_41fda187958f06d7.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\test_alias_civilian_female_surge_body;
#using xmodelalias\test_alias_civilian_female_surge_head;
#namespace namespace_e69dae6a8a15d1b1;

function private autoexec init() {
  character = #"hash_8faafc5084514115";

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
    level.fncharacterxmodelalias[%"hash_40a7dbe106c9c596"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("test_alias_civilian_female_surge_body", xmodelalias\test_alias_civilian_female_surge_body::main());
  scripts\code\character::attachhead("test_alias_civilian_female_surge_head", xmodelalias\test_alias_civilian_female_surge_head::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\test_alias_civilian_female_surge_body::main());
  scripts\code\character::precachemodelarray(xmodelalias\test_alias_civilian_female_surge_head::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_917dd15b39af92a7":
      return xmodelalias\test_alias_civilian_female_surge_body::main();
    case #"hash_e904a03550281bb5":
      return xmodelalias\test_alias_civilian_female_surge_head::main();
  }

  assert(0, "test_character_civilian_female_surge do not have any xmodelalias");
}