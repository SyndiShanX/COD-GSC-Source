/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6c6bc6450c8ef43d.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_shredded_body_rz;
#using xmodelalias\c_jup_zmb_zombie_base_male_shredded_head;
#namespace namespace_88ff94a40a5b5c87;

function private autoexec init() {
  character = #"hash_2fba29c1110d9b03";

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
    level.fncharacterxmodelalias[%"hash_2b10c650340fe05c"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "zombie_base";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_base";
  self function_6b0082dec4510b24("c_jup_zmb_zombie_base_male_shredded_body_rz", xmodelalias\c_jup_zmb_zombie_base_male_shredded_body_rz::main());
  scripts\code\character::attachhead("c_jup_zmb_zombie_base_male_shredded_head", xmodelalias\c_jup_zmb_zombie_base_male_shredded_head::main());
  self setclothtype(#"vestheavy");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_shredded_body_rz::main());
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_shredded_head::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_7e01741ecde44d15":
      return xmodelalias\c_jup_zmb_zombie_base_male_shredded_body_rz::main();
    case #"hash_9f43f5c1b4c2c376":
      return xmodelalias\c_jup_zmb_zombie_base_male_shredded_head::main();
  }

  assert(0, "<dev string:x1c>");
}