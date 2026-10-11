/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6966b1c751920a89.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_gz;
#namespace namespace_67a58aa194b651a3;

function private autoexec init() {
  character = #"hash_ac1e0c663416913f";

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
    level.fncharacterxmodelalias[%"hash_5a88c58ea1656e18"] = &function_ecf17a96e49ab67;
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
  self setModel("c_jup_zmb_zombie_base_male_long_shirt_body_gz");
  scripts\code\character::attachhead("c_jup_zmb_zombie_base_long_shirt_head_gz", xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_gz::main());
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
  precachemodel("c_jup_zmb_zombie_base_male_long_shirt_body_gz");
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_gz::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_b9e0372d177bcabe":
      return xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_gz::main();
  }

  assert(0, "<dev string:x1c>");
}