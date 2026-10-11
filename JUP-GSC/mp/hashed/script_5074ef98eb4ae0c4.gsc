/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5074ef98eb4ae0c4.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_c1fc4ca6cefda452;

function private autoexec init() {
  character = #"hash_35a4a4f4c91fdfae";

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
  self.animationarchetype = "zombie_base";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_base";
  self setModel("c_jup_zmb_zombie_base_charred_female_body");
  self attach("c_jup_zmb_zombie_base_charred_female_head", "", 1);
  self.headmodel = "c_jup_zmb_zombie_base_charred_female_head";
  self setclothtype(#"vestheavy");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("c_jup_zmb_zombie_base_charred_female_body");
  precachemodel("c_jup_zmb_zombie_base_charred_female_head");
}

function precache_cpmp() {
  precache();
}