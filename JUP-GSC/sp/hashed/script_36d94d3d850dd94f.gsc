/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_36d94d3d850dd94f.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_uk_female_surge_3;
#using xmodelalias\heads_civilian_uk_female_surge_3;
#namespace namespace_548f178492b6eddd;

function private autoexec init() {
  character = #"hash_8bfa6b7e191cdcf9";

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
    level.fncharacterxmodelalias[%"hash_6edeb92df21453d6"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("bodies_civilian_uk_female_surge_3", xmodelalias\bodies_civilian_uk_female_surge_3::main());
  scripts\code\character::attachhead("heads_civilian_uk_female_surge_3", xmodelalias\heads_civilian_uk_female_surge_3::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_uk_female_surge_3::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_uk_female_surge_3::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_34f1942b13ba15f2":
      return xmodelalias\bodies_civilian_uk_female_surge_3::main();
    case #"hash_f9c54381ea2ec6b9":
      return xmodelalias\heads_civilian_uk_female_surge_3::main();
  }

  assert(0, "character_civilian_uk_female_surge_3 do not have any xmodelalias");
}