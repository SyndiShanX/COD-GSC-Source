/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\flags.gsc
**************************************/

#using scripts\engine\flags;
#using scripts\engine\utility;
#namespace flags;

function init_sp_flags() {
  if(!isDefined(level.flag)) {
    init_flags();
  }

  flags = ["\x95\b\x9b\xf5\xc6\xe9\xe2\x10\xbf\xae\xee\xc5>", "\xad\v\xac\x80SP:\x8f\x9c\xa9\xec\xb3\xca", "\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97"];

  foreach(flag in flags) {
    if(!utility::flag_exist(flag)) {
      utility::flag_init(flag);
    }
  }
}