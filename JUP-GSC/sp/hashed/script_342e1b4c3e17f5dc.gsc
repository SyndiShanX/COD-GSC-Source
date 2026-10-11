/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_342e1b4c3e17f5dc.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_uk_male_surge_1;
#using xmodelalias\heads_civilian_uk_male_surge_1;
#namespace character_civilian_uk_male_surge_1;

function private autoexec init() {
  character = #"hash_57ec1028209c1f5e";

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
    level.fncharacterxmodelalias[%"hash_7a5511f06988e56d"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("bodies_civilian_uk_male_surge_1", xmodelalias\bodies_civilian_uk_male_surge_1::main());
  scripts\code\character::attachhead("heads_civilian_uk_male_surge_1", xmodelalias\heads_civilian_uk_male_surge_1::main());
  self setclothtype(#"nylon");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_uk_male_surge_1::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_uk_male_surge_1::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_b6b9e84d2702f029":
      return xmodelalias\bodies_civilian_uk_male_surge_1::main();
    case #"hash_c629b6522a0f65be":
      return xmodelalias\heads_civilian_uk_male_surge_1::main();
  }

  assert(0, "character_civilian_uk_male_surge_1 do not have any xmodelalias");
}