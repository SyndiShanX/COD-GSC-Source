/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_62f2bc71cb0b4c2b.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_83314689f53741d1;

function private autoexec init() {
  character = #"hash_600c7b26b2b53cf5";

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
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_hero_ghost_urban");
  self attach("head_sp_hero_ghost_urban_lod", "", 1);
  self.headmodel = "head_sp_hero_ghost_urban_lod";
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
  precachemodel("body_c_jup_sp_hero_ghost_urban");
  precachemodel("head_sp_hero_ghost_urban_lod");
}

function precache_cpmp() {
  precache();
}