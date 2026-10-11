/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_bd1533c9129da34.gsc
************************************************/

#using scripts\common\utility;
#namespace namespace_88ff95a40a5b5eba;

function private autoexec init() {
  character = #"hash_2fba2ac1110d9cb6";

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
  self setModel("c_jup_zombie_base_male_shredded_02");
  self attach("c_jup_zombie_base_male_shredded_02_head_half_oz", "", 1);
  self.headmodel = "c_jup_zombie_base_male_shredded_02_head_half_oz";
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
  precachemodel("c_jup_zombie_base_male_shredded_02");
  precachemodel("c_jup_zombie_base_male_shredded_02_head_half_oz");
}

function precache_cpmp() {
  precache();
}