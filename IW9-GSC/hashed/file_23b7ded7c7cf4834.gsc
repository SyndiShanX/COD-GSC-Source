/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_23b7ded7c7cf4834.gsc
***********************************************/

main() {
  thread _id_33E8A822AE8854DF();
}

_id_33E8A822AE8854DF() {
  level waittill("scriptables_ready");
  _id_865EFD86310EC840 = getscriptablearray("storm_sun_control", "targetname");

  if(!isDefined(_id_865EFD86310EC840) || _id_865EFD86310EC840.size == 0) {
    return;
  }
  setdvarifuninitialized("dvar_98382B38722E8EC4", 1);

  foreach(_id_707917097193DE27 in _id_865EFD86310EC840) {
    if(getdvarint("dvar_98382B38722E8EC4") != 0) {
      _id_707917097193DE27 setscriptablepartstate("sun_control", "flicker_on");
      continue;
    }

    _id_707917097193DE27 setscriptablepartstate("sun_control", "flicker_off");
  }
}