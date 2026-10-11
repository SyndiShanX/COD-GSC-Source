/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_64789bc2c1aa0a99.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_jup_sp_enemy_pmc_surge_plain;
#using xmodelalias\heads_jup_sp_enemy_pmc_surge_plain;
#namespace namespace_decb60e0cf6eb5f7;

function private autoexec init() {
  character = #"hash_8f0ffb361f632a2b";

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
    level.fncharacterxmodelalias[%"hash_1a9da5c20be48f70"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"shadowcompany";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_jup_sp_enemy_pmc_surge_plain", xmodelalias\bodies_jup_sp_enemy_pmc_surge_plain::main());
  scripts\code\character::attachhead("heads_jup_sp_enemy_pmc_surge_plain", xmodelalias\heads_jup_sp_enemy_pmc_surge_plain::main());
  self setclothtype(#"vestlight");
  self setgeartype(#"milmedgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\bodies_jup_sp_enemy_pmc_surge_plain::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_jup_sp_enemy_pmc_surge_plain::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_1a0a88b103364d47":
      return xmodelalias\bodies_jup_sp_enemy_pmc_surge_plain::main();
    case #"hash_647c13a7bb70982c":
      return xmodelalias\heads_jup_sp_enemy_pmc_surge_plain::main();
  }

  assert(0, "c_jup_sp_enemy_pmc_grunt_surge_plain do not have any xmodelalias");
}