/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6cf4e656f0f29727.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_39c30f9ee41932c7;

function private autoexec init() {
  character = #"hash_2a22a52b71db8b8b";

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