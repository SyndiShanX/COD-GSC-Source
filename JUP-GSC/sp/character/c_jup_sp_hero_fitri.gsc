/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\c_jup_sp_hero_fitri.gsc
************************************************/

#using scripts\common\utility;
#namespace c_jup_sp_hero_fitri;

function private autoexec init() {
  character = #"c_jup_sp_hero_fitri";

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
  self.animationarchetype = "soldier_female";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_hero_fitri");
  self attach("c_jup_head_hero_samara", "", 1);
  self.headmodel = "c_jup_head_hero_samara";
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
  precachemodel("body_c_jup_sp_hero_fitri");
  precachemodel("c_jup_head_hero_samara");
}

function precache_cpmp() {
  precache();
}