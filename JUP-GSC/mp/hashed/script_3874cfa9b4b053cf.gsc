/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3874cfa9b4b053cf.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_8be01b33c6501993;

function private autoexec init() {
  character = #"hash_41bf12cef4f8205f";

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
  self.animationarchetype = "juggernaut";
  self.voice = #"alqatala";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_sp_opforce_aq_jugg_basebody");
  self attach("head_sp_opforce_aq_jugg", "", 1);
  self.headmodel = "head_sp_opforce_aq_jugg";
  self setclothtype(#"vestheavy");
  self setgeartype(#"milhvygr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_opforce_aq_jugg_basebody");
  precachemodel("head_sp_opforce_aq_jugg");
}

function precache_cpmp() {
  precache();
}