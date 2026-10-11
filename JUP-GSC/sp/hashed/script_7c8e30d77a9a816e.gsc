/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7c8e30d77a9a816e.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_1616dd61fc3dda2;

function private autoexec init() {
  character = #"hash_7a14f623332c374e";

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
  self.animationarchetype = "farah";
  self.voice = #"fsafemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_hero_farah_nvm");
  self attach("c_jup_head_hero_farah_no_hair", "", 1);
  self.headmodel = "c_jup_head_hero_farah_no_hair";
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
  precachemodel("body_c_jup_sp_hero_farah_nvm");
  precachemodel("c_jup_head_hero_farah_no_hair");
}

function precache_cpmp() {
  precache();
}