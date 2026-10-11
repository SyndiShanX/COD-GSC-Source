/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7f8f546d45e1e353.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_3c44d0d8e5daedad;

function private autoexec init() {
  character = #"hash_96f036d16ecf6781";

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
  self setModel("body_c_jup_sp_hero_soap_urban");
  self attach("head_c_jup_sp_hero_soap_urban", "", 1);
  self.headmodel = "head_c_jup_sp_hero_soap_urban";
  self setclothtype(#"nylon");
  self setgeartype(#"milmedgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_hero_soap_urban");
  precachemodel("head_c_jup_sp_hero_soap_urban");
}

function precache_cpmp() {
  precache();
}