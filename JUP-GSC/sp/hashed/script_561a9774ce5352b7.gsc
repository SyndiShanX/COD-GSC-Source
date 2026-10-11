/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_561a9774ce5352b7.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_c_jup_sp_enemy_rusdelegate;
#using xmodelalias\heads_jup_sp_enemy_kastovsoldier_01;
#namespace namespace_31e32219b3fc443b;

function private autoexec init() {
  character = #"hash_ad57875da8d4209f";

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
    level.fncharacterxmodelalias[%"hash_14f00cda41a0df6"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"russian";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_c_jup_sp_enemy_rusdelegate", xmodelalias\bodies_c_jup_sp_enemy_rusdelegate::main());
  scripts\code\character::attachhead("heads_jup_sp_enemy_kastovsoldier_01", xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_c_jup_sp_enemy_rusdelegate::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_e337c9cf32f37b46":
      return xmodelalias\bodies_c_jup_sp_enemy_rusdelegate::main();
    case #"hash_de3b73cd07d55560":
      return xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main();
  }

  assert(0, "character_jup_civ_rusdelegate do not have any xmodelalias");
}