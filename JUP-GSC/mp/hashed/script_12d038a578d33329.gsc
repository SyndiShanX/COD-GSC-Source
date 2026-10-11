/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_12d038a578d33329.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_1576dfeffbe556d5;

function private autoexec init() {
  character = #"hash_c8cbc6f0d613b899";

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
  self.animationarchetype = "warlord_maestro_rainmaker";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_ext_rainmaker");
  self attach("head_c_jup_ext_rainmaker", "", 1);
  self.headmodel = "head_c_jup_ext_rainmaker";
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
  precachemodel("body_c_jup_ext_rainmaker");
  precachemodel("head_c_jup_ext_rainmaker");
}

function precache_cpmp() {
  precache();
}