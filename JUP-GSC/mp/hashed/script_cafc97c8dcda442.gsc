/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_cafc97c8dcda442.gsc
************************************************/

#using scripts\common\utility;
#namespace namespace_dc1e24444442424e;

function private autoexec init() {
  character = #"hash_c5b8837f9f38f712";

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
  self setModel("c_jup_zmb_zombie_base_female_jeans_body_gz");
  self attach("c_jup_zmb_zombie_base_female_jeans_head_01_gz", "", 1);
  self.headmodel = "c_jup_zmb_zombie_base_female_jeans_head_01_gz";
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
  precachemodel("c_jup_zmb_zombie_base_female_jeans_body_gz");
  precachemodel("c_jup_zmb_zombie_base_female_jeans_head_01_gz");
}

function precache_cpmp() {
  precache();
}