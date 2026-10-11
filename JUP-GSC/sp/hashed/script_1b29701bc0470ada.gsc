/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1b29701bc0470ada.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_uk_girl_surge_2;
#using xmodelalias\heads_civilian_uk_girl_surge_2;
#namespace namespace_1f60801f63fa1ff0;

function private autoexec init() {
  character = #"hash_f89696d778b70924";

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
    level.fncharacterxmodelalias[%"hash_72db03c57a3ace13"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_civilian_uk_girl_surge_2", xmodelalias\bodies_civilian_uk_girl_surge_2::main());
  scripts\code\character::attachhead("heads_civilian_uk_girl_surge_2", xmodelalias\heads_civilian_uk_girl_surge_2::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_uk_girl_surge_2::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_uk_girl_surge_2::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_96fb55b0990b0d67":
      return xmodelalias\bodies_civilian_uk_girl_surge_2::main();
    case #"hash_bfb858baed0f8544":
      return xmodelalias\heads_civilian_uk_girl_surge_2::main();
  }

  assert(0, "character_civilian_uk_girl_surge_2 do not have any xmodelalias");
}