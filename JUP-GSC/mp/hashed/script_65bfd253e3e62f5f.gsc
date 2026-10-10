/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_65bfd253e3e62f5f.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\asm\shared\utility;
#using scripts\engine\utility;
#namespace cap_hostage;

function initcap(asmname, statename, params) {
  self animmode("noclip");
  self orientmode("face current");
  origin = self.origin;
  angles = self.angles;
}

function function_f3967267145e123(asmname, statename, params) {
  archetype = self.animsetname;
  aliases = archetypegetaliases(archetype, statename);
  alias = undefined;

  if(statename == "hostage_pickup") {
    alias = "hostage_pickup_" + self.animdir + "_" + self.animstance;
  } else {
    alias = "hostage_drop_" + self.animstance;
  }

  return scripts\asm\cap::function_658df657ca37f542(statename, alias);
}