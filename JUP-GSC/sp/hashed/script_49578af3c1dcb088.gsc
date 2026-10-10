/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_49578af3c1dcb088.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civ_russian_male_body_flashback_soccerfan;
#using xmodelalias\civ_russian_male_head_1_flashback;
#namespace namespace_324eb5fcf2f8f166;

function private autoexec init() {
  character = #"hash_d1eb594579a88782";

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
    level.var_44bf7e31237b3073[%"hash_2cdb93a8b2747949"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("c_jup_civ_russian_male_body_flashback_soccerfan", xmodelalias\c_jup_civ_russian_male_body_flashback_soccerfan::main());
  scripts\code\character::attachhead("civ_russian_male_head_1_flashback", xmodelalias\civ_russian_male_head_1_flashback::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_civ_russian_male_body_flashback_soccerfan::main());
  scripts\code\character::precachemodelarray(xmodelalias\civ_russian_male_head_1_flashback::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_b09df7750e308419":
      return xmodelalias\c_jup_civ_russian_male_body_flashback_soccerfan::main();
    case #"hash_d1d30bfb5ae024f2":
      return xmodelalias\civ_russian_male_head_1_flashback::main();
  }

  assert(0, "c_jup_civ_russian_male_flashback_soccerfan do not have any xmodelalias");
}