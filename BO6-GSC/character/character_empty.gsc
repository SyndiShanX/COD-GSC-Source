/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_empty.gsc
*****************************************/

#using scripts\common\utility;
#namespace character_empty;

function private autoexec init() {
  character = % "character_empty";

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

  if(utility::issp()) {
    level.fncharacterprecache[character] = &precache_sp;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animsettings = "\xf2\xec\x1f\xf2\x18\x18(";
  self.animationarchetype = function_59343b14fa81305d(self.animsettings);
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "\xf2\xec\x1f\xf2\x18\x18(";
  self setModel("\x12\xbc\xa5,\xec\x83O \x91\x8a\xb7m\xe4\x10\xd5\x8cV\xf3>}\xd2\xe3K");
  self setclothtype(#"none");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
}

function precache_cpmp() {
  precache();
}