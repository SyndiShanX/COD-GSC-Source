/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2b283271ad65977c.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hover_jet", "set_vehicle_hit_damage_data", ::_id_C414D20013783E62);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hover_jet", "registerSentient", ::_id_C8ABABCAC24AD291);
  setdvarifuninitialized("dvar_66BEC5BD52437CAF", 60);
  _id_E19789EA16C33355 = spawnStruct();
  _id_E19789EA16C33355._id_F6F44AE79C7EB44D = "hover_jet_achieve";
  _id_E19789EA16C33355._id_CC5128455E1A40D4 = "hover_jet";
  _id_E19789EA16C33355._id_6E25C01B88FC2F76 = "hover_jet";
  scripts\cp\utility::_id_73AE764F6D95E017("hover_jet", _id_E19789EA16C33355);
}

_id_C414D20013783E62(ref, hitstokill) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(ref, hitstokill);
}

_id_C8ABABCAC24AD291(threatbiasgroup, _id_5C00772332CE642C) {
  scripts\cp\utility::make_entity_sentient_cp(_id_5C00772332CE642C.team);
  self setthreatbiasgroup(threatbiasgroup);
}