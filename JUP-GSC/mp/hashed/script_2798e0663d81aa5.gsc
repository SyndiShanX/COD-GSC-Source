/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2798e0663d81aa5.gsc
************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_iw9_enemy_aq_tier2_1;
#using xmodelalias\heads_iw9_enemy_aq_tier2_1;
#namespace namespace_225222435324057f;

function private autoexec init() {
  character = #"hash_39ad47aa2a901b43";

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
    level.var_44bf7e31237b3073[%"hash_2701f13846849e4c"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"alqatala";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_iw9_enemy_aq_tier2_1", xmodelalias\bodies_iw9_enemy_aq_tier2_1::main());
  scripts\code\character::attachhead("heads_iw9_enemy_aq_tier2_1", xmodelalias\heads_iw9_enemy_aq_tier2_1::main());
  self setclothtype(#"flowing");
  self function_8abe5a968cc3c220(#"millghtgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\bodies_iw9_enemy_aq_tier2_1::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_iw9_enemy_aq_tier2_1::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_67a91a02b6272370":
      return xmodelalias\bodies_iw9_enemy_aq_tier2_1::main();
    case #"hash_1f4d891f61d7ba03":
      return xmodelalias\heads_iw9_enemy_aq_tier2_1::main();
  }

  assert(0, "<dev string:x1c>");
}