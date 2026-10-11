/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7bb0b5b316a6e416.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_jup_sp_enemy_kastovsoldier_02;
#namespace namespace_2e61913aad60bd0c;

function private autoexec init() {
  character = #"hash_d1e5abf50b896ee0";

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
    level.fncharacterxmodelalias[%"hash_6b0fe7543b4115ef"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"russian";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_enemy_kastovsoldier_05d");
  scripts\code\character::attachhead("heads_jup_sp_enemy_kastovsoldier_02", xmodelalias\heads_jup_sp_enemy_kastovsoldier_02::main());
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
  precachemodel("body_c_jup_sp_enemy_kastovsoldier_05d");
  scripts\code\character::precachemodelarray(xmodelalias\heads_jup_sp_enemy_kastovsoldier_02::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_de3b76cd07d55a19":
      return xmodelalias\heads_jup_sp_enemy_kastovsoldier_02::main();
  }

  assert(0, "c_jup_sp_enemy_kastovsoldier_05b do not have any xmodelalias");
}