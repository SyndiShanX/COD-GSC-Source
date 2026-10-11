/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1c1e81a5e2605820.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_17ee75c9f1c82076;

function private autoexec init() {
  character = #"hash_d3e60f363e464392";

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
  self.animationarchetype = "capture_bot";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "capture_bot";
  self setModel("tag_origin");
  self setclothtype(#"vestlight");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("tag_origin");
}

function precache_cpmp() {
  precache();
}