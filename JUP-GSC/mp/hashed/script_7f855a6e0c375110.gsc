/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7f855a6e0c375110.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz;
#using xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe;
#namespace namespace_f7b05f139be19d92;

function private autoexec init() {
  character = #"hash_60df4f941e1388c6";

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
    level.fncharacterxmodelalias[%"hash_76190b55c88508e9"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe", xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe::main());
  scripts\code\character::attachhead("c_jup_zmb_zombie_base_long_shirt_head_yz", xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe::main());
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_b1fd5c5c381b02f0":
      return xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe::main();
    case #"hash_b9da372d17774d90":
      return xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz::main();
  }

  assert(0, "<dev string:x1c>");
}