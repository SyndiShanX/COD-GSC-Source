/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_63a095cc940ab84e.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_9454fe4fe0ae604a;

function private autoexec init() {
  character = #"hash_1386b2032a701206";

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
  self setModel("body_c_jup_sp_hero_gaz_cheminfil");
  self attach("head_c_jup_sp_hero_gaz_urban", "", 1);
  self.headmodel = "head_c_jup_sp_hero_gaz_urban";
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
  precachemodel("body_c_jup_sp_hero_gaz_cheminfil");
  precachemodel("head_c_jup_sp_hero_gaz_urban");
}

function precache_cpmp() {
  precache();
}