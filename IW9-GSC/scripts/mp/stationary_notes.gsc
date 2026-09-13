/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\stationary_notes.gsc
***********************************************/

_id_D197EDBD2618C9D1() {
  if(getdvarint("dvar_219E4EB52E9A22D8", 1) == 0) {
    return;
  }
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("stationary_note", ::_id_C4A730F3FC3D42F5);
  level._id_AD243D07C52C2843 = spawnStruct();
  level._id_AD243D07C52C2843._id_4CC11EF35EB39AE8 = [];
  _id_E596ECA4A0DD77C5 = scripts\engine\utility::getStructArray("stationary_note", "script_noteworthy");
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  waitframe();

  foreach(loc in _id_E596ECA4A0DD77C5) {
    if(!isDefined(loc.targetname)) {
      continue;
    }
    _id_0F915120F9B1AD6E(loc);
  }
}

_id_597067D183E31ED9(loc) {
  switch (loc.targetname) {
    case "pmc_cartel_computer":
      return "stationary_note_computer";
  }

  if(!isDefined(loc.model))
    return "stationary_note_paper";

  switch (loc.model) {
    case "ee_stationary_intel_a_single_letter_01":
      return "stationary_note_paper";
    default:
      return "stationary_note_paper";
  }
}

_id_466D1FC9A557D7C9(key, _id_5FC921CA5DF09E7E) {
  level._id_AD243D07C52C2843._id_4CC11EF35EB39AE8[key] = _id_5FC921CA5DF09E7E;
}

_id_793A7B85FFB737D1(_id_5FC921CA5DF09E7E) {
  _id_09DD5D9E57E7E36D = tablelookuprownum("mp/immovablenotes.csv", 1, _id_5FC921CA5DF09E7E);

  if(!isDefined(_id_09DD5D9E57E7E36D)) {
    return;
  }
  id = tablelookupbyrow("mp/immovablenotes.csv", _id_09DD5D9E57E7E36D, 0);
  return id;
}

_id_0F915120F9B1AD6E(loc) {
  _id_5FC921CA5DF09E7E = loc.targetname;

  if(isDefined(level._id_AD243D07C52C2843._id_4CC11EF35EB39AE8[_id_5FC921CA5DF09E7E]))
    _id_5FC921CA5DF09E7E = level._id_AD243D07C52C2843._id_4CC11EF35EB39AE8[_id_5FC921CA5DF09E7E];

  scriptablename = _id_597067D183E31ED9(loc);

  if(!isDefined(loc.angles))
    loc.angles = (0, 0, 0);

  scriptable = spawnscriptable(scriptablename, loc.origin, loc.angles + (90, 0, 0));
  scriptable._id_70B5FD7365F6B50C = _id_793A7B85FFB737D1(_id_5FC921CA5DF09E7E);
}

_id_C4A730F3FC3D42F5(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  thread _id_528ACE3EB332DC64(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
}

_id_528ACE3EB332DC64(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(instance.type == "stationary_note_computer")
    scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "pmc_read_email", 1);

  _id_6A8EC730B2BFA844::_id_2B7CC5D62043202E(player);
  player setclientomnvar("ui_immovable_note", int(instance._id_70B5FD7365F6B50C));
  waitframe();
  player setclientomnvar("ui_immovable_note", 0);
}