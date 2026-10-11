/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_25155d7e58eb515b.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_8ae0d8368506b48d;

function private autoexec init() {
  character = #"hash_9d7be683444b8d59";

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
  self setModel("c_jup_zmb_zombie_base_female_dress_blue_gz");
  self attach("c_jup_zmb_zombie_base_female_dress_head_02_blue_gz", "", 1);
  self.headmodel = "c_jup_zmb_zombie_base_female_dress_head_02_blue_gz";
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
  precachemodel("c_jup_zmb_zombie_base_female_dress_blue_gz");
  precachemodel("c_jup_zmb_zombie_base_female_dress_head_02_blue_gz");
}

function precache_cpmp() {
  precache();
}