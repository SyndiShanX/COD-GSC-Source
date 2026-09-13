/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_dirt_bike.gsc
*************************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_civ_lnd_dirt_bike", ::_id_22E02886BA8D83BF);
}

_id_22E02886BA8D83BF() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_civ_lnd_dirt_bike")) {
    return;
  }
  if(scripts\common\utility::iscp()) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_civ_lnd_dirt_bike");

  if(getdvarint("dvar_12368A7F8188C51E", 1) == 1) {
    data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328("veh9_civ_lnd_dirt_bike");

    foreach(tag, damagedata in data.damage._id_AAB9695C92B0ED96) {
      if(isDefined(damagedata._id_7CBFFE9DE982BCAD)) {
        data.damage._id_AAB9695C92B0ED96[tag] = undefined;
        data.damage._id_9D70F02394C136DA[tag] = undefined;
        data.damage._id_CCFDE1208EF2964B[tag] = undefined;
      }
    }
  }
}