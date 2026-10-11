/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_472227ccbec0290.gsc
************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_hoodie_body_yz;
#using xmodelalias\c_jup_zmb_zombie_base_male_hoodie_head;
#namespace namespace_7ffe79862593b2;

function private autoexec init() {
  character = #"hash_56870dc3d696c906";

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
    level.fncharacterxmodelalias[%"hash_e605c40016e0cf9"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("c_jup_zmb_zombie_base_male_hoodie_body_yz", xmodelalias\c_jup_zmb_zombie_base_male_hoodie_body_yz::main());
  scripts\code\character::attachhead("c_jup_zmb_zombie_base_male_hoodie_head", xmodelalias\c_jup_zmb_zombie_base_male_hoodie_head::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_hoodie_body_yz::main());
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_hoodie_head::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_482a5f44cc0dff85":
      return xmodelalias\c_jup_zmb_zombie_base_male_hoodie_body_yz::main();
    case #"hash_a813d896007c958b":
      return xmodelalias\c_jup_zmb_zombie_base_male_hoodie_head::main();
  }

  assert(0, "<dev string:x1c>");
}