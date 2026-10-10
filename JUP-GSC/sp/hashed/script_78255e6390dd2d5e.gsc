/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_78255e6390dd2d5e.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_c_jup_sp_enemy_rusgeneral;
#using xmodelalias\heads_jup_sp_enemy_kastovsoldier_01;
#namespace namespace_46d34fbf612b7824;

function private autoexec init() {
  character = #"hash_82f29847e3ebea90";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.var_7d97144daa7995cd)) {
    level.var_7d97144daa7995cd = [];
  }

  if(!isDefined(level.var_44bf7e31237b3073)) {
    level.var_44bf7e31237b3073 = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.var_7d97144daa7995cd[character] = &precache_sp;
    level.var_44bf7e31237b3073[%"hash_7f7ecde95ee7d6ef"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"russian";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_c_jup_sp_enemy_rusgeneral", xmodelalias\bodies_c_jup_sp_enemy_rusgeneral::main());
  scripts\code\character::attachhead("heads_jup_sp_enemy_kastovsoldier_01", xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main());
  self setclothtype(#"vestlight");
  self function_8abe5a968cc3c220(#"millghtgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\bodies_c_jup_sp_enemy_rusgeneral::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_ea7d15f95619d5f":
      return xmodelalias\bodies_c_jup_sp_enemy_rusgeneral::main();
    case #"hash_de3b73cd07d55560":
      return xmodelalias\heads_jup_sp_enemy_kastovsoldier_01::main();
  }

  assert(0, "character_jup_civ_rusgeneral do not have any xmodelalias");
}