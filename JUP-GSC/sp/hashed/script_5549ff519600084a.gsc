/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5549ff519600084a.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_84ac6eea6babcf10;

function private autoexec init() {
  character = #"hash_996b429535b5721c";

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
  self.animationarchetype = "rebel";
  self.voice = #"sas";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_sp_hero_kyle_marina");
  self attach("head_hero_kyle_marina_blendshape", "", 1);
  self.headmodel = "head_hero_kyle_marina_blendshape";
  self setclothtype(#"wetsuit");
  self setgeartype(#"milmedgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_hero_kyle_marina");
  precachemodel("head_hero_kyle_marina_blendshape");
}

function precache_cpmp() {
  precache();
}