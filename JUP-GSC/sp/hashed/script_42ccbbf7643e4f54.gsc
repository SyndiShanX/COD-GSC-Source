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

  if(!isDefined(level.fncharacterprecache)) {
    level.fncharacterprecache = [];
  }

  if(!isDefined(level.fncharacterxmodelalias)) {
    level.fncharacterxmodelalias = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.fncharacterprecache[character] = &precache_sp;
    level.fncharacterxmodelalias[%"hash_52ccdeecdc01ba85"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react_female";
  self.voice = #"alqatalafemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("c_jup_civilian_russian_female_body", xmodelalias\c_jup_civilian_russian_female_body::main());
  scripts\code\character::attachhead("civilian_russian_female_head", xmodelalias\civilian_russian_female_head::main());
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