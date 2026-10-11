/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_339858ff8a8d59d9.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_jup_sp_enemy_kastovsoldier_female;
#namespace namespace_e09839a3865ed4d1;

function private autoexec init() {
  character = #"hash_c73983f514c5157d";

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
    level.fncharacterxmodelalias[%"hash_69582fd2874d5d78"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "farah";
  self.voice = #"russianfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_hero_laswell_military");
  scripts\code\character::attachhead("heads_jup_sp_enemy_kastovsoldier_female", xmodelalias\heads_jup_sp_enemy_kastovsoldier_female::main());
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
  precachemodel("body_c_jup_sp_hero_laswell_military");
  scripts\code\character::precachemodelarray(xmodelalias\heads_jup_sp_enemy_kastovsoldier_female::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_1f13018c0ea66403":
      return xmodelalias\heads_jup_sp_enemy_kastovsoldier_female::main();
  }

  assert(0, "c_jup_sp_enemy_kastovsoldier_female do not have any xmodelalias");
}