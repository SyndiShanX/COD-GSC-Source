/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_31fa1039ff4c08da.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_shortsleeves_body_gz;
#namespace namespace_7284c5b8ec4cf64e;

function private autoexec init() {
  character = #"hash_87f94518c4d081da";

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
    level.fncharacterxmodelalias[%"hash_5af9c7b07ca6be7b"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("c_jup_zmb_zombie_base_male_shortsleeves_body_gz", xmodelalias\c_jup_zmb_zombie_base_male_shortsleeves_body_gz::main());
  self attach("c_jup_zmb_zombie_base_male_head_1_gz", "", 1);
  self.headmodel = "c_jup_zmb_zombie_base_male_head_1_gz";
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_shortsleeves_body_gz::main());
  precachemodel("c_jup_zmb_zombie_base_male_head_1_gz");
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_9c6e573b6583ceac":
      return xmodelalias\c_jup_zmb_zombie_base_male_shortsleeves_body_gz::main();
  }

  assert(0, "<dev string:x1c>");
}