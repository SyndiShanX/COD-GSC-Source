/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2233d3f42f06f2c8.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_511c9c74cf8dacf2;

function private autoexec init() {
  character = #"hash_c0786996319b6126";

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
  self.animationarchetype = "soldier";
  self.voice = #"sas";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_hero_shepherd_tundra");
  self attach("c_jup_head_hero_sheperd", "", 1);
  self.headmodel = "c_jup_head_hero_sheperd";
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
  precachemodel("body_c_jup_sp_hero_shepherd_tundra");
  precachemodel("c_jup_head_hero_sheperd");
}

function precache_cpmp() {
  precache();
}