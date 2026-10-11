/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2065d6673a0b3166.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_uk_male_surge_3;
#using xmodelalias\heads_civilian_uk_male_surge_3;
#namespace character_civilian_uk_male_surge_3;

function private autoexec init() {
  character = #"hash_57ec0e28209c1bf8";

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
    level.fncharacterxmodelalias[%"hash_7a550ff06988e207"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("bodies_civilian_uk_male_surge_3", xmodelalias\bodies_civilian_uk_male_surge_3::main());
  scripts\code\character::attachhead("heads_civilian_uk_male_surge_3", xmodelalias\heads_civilian_uk_male_surge_3::main());
  self setclothtype(#"cloth");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_uk_male_surge_3::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_uk_male_surge_3::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_b6b9e64d2702ed03":
      return xmodelalias\bodies_civilian_uk_male_surge_3::main();
    case #"hash_c629b4522a0f6298":
      return xmodelalias\heads_civilian_uk_male_surge_3::main();
  }

  assert(0, "character_civilian_uk_male_surge_3 do not have any xmodelalias");
}