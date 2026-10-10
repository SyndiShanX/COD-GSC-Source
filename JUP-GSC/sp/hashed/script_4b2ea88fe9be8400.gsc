/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4b2ea88fe9be8400.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_female_heads;
#using xmodelalias\test_alias_civ_london_female_2_body;
#namespace namespace_da52ca1eb04dd27a;

function private autoexec init() {
  character = #"hash_ac5418feffc25ece";

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
    level.var_44bf7e31237b3073[%"hash_3555c3e6a8b575c9"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react_female";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("test_alias_civ_london_female_2_body", xmodelalias\test_alias_civ_london_female_2_body::main());
  scripts\code\character::attachhead("civilian_london_female_heads", xmodelalias\civilian_london_female_heads::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\test_alias_civ_london_female_2_body::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_heads::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_439d1e6fc1c0e413":
      return xmodelalias\test_alias_civ_london_female_2_body::main();
    case #"hash_cebfd7e97d870708":
      return xmodelalias\civilian_london_female_heads::main();
  }

  assert(0, "c_jup_civ_london_female_02 do not have any xmodelalias");
}