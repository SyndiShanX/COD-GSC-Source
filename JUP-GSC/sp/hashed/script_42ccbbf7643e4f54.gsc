/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_42ccbbf7643e4f54.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civilian_russian_female_body;
#using xmodelalias\civilian_russian_female_head;
#namespace namespace_2c6d50e4a84f541a;

function private autoexec init() {
  character = #"hash_a54031b0dffd8686";

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
    level.var_44bf7e31237b3073[%"hash_52ccdeecdc01ba85"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react_female";
  self.voice = #"alqatalafemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("c_jup_civilian_russian_female_body", xmodelalias\c_jup_civilian_russian_female_body::main());
  scripts\code\character::attachhead("civilian_russian_female_head", xmodelalias\civilian_russian_female_head::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_civilian_russian_female_body::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_russian_female_head::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_2efc6259ad8b666":
      return xmodelalias\c_jup_civilian_russian_female_body::main();
    case #"hash_8d954660328473f6":
      return xmodelalias\civilian_russian_female_head::main();
  }

  assert(0, "c_jup_civ_russian_female do not have any xmodelalias");
}