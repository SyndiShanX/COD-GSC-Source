/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_65bfd253e3e62f5f.gsc
***********************************************/

_id_F044486D3882C43D(asmname, statename, params) {
  self animmode("noclip");
  self orientmode("face current");
  origin = self.origin;
  angles = self.angles;
}

_id_0F3967267145E123(asmname, statename, params) {
  archetype = self._id_AE3EA15396B65C1F;
  aliases = archetypegetaliases(archetype, statename);
  alias = undefined;

  if(statename == "hostage_pickup")
    alias = "hostage_pickup_" + self._id_A1E9BAABC1D61AE3 + "_" + self._id_08EE3FF7543AC0B4;
  else
    alias = "hostage_drop_" + self._id_08EE3FF7543AC0B4;

  return _id_4E1D4DD23699A8A4::_id_658DF657CA37F542(statename, alias);
}