/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_57e45d0a7c51fdf3.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_jup_sp_enemy_kastovsoldier_female;
#namespace namespace_58ab8c863bad9553;

function private autoexec init() {
  character = #"hash_669f6307a4b0acf7";

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
    level.fncharacterxmodelalias[%"hash_6fdc602242b62a52"] = &function_ecf17a96e49ab67;
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
  self setModel("body_c_jup_sp_hero_laswell_bdu");
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
  precachemodel("body_c_jup_sp_hero_laswell_bdu");
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

  assert(0, "c_jup_sp_enemy_kastovsoldier_female_bdu do not have any xmodelalias");
}