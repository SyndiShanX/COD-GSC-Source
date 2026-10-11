/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_514982a76038da44.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_eb10246b8cd6f8f4;

function private autoexec init() {
  character = #"hash_dedb0dfc4b2b7ab0";

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
  self setModel("c_jup_zmb_zombie_base_female_dress");
  self attach("c_jup_zmb_zombie_base_female_dress_head_01_yz", "", 1);
  self.headmodel = "c_jup_zmb_zombie_base_female_dress_head_01_yz";
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
  precachemodel("c_jup_zmb_zombie_base_female_dress");
  precachemodel("c_jup_zmb_zombie_base_female_dress_head_01_yz");
}

function precache_cpmp() {
  precache();
}