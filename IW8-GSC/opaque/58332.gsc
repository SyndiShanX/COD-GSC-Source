/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58332.gsc
***********************************************/

_id_14161() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_9AE622B0BF5CCFEB0A0AB8302E322BB3A3F7C88083E1C09B327734487AA97B9811D75830", scripts\mp\vehicles\damage::set_weapon_class_mod_damage_data_for_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_88C011F369FD8B97400FAD8739D95EA7AFC16A", scripts\mp\vehicles\damage::set_perk_mod_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8D88174B550B3FA8299F3810E04B7BED7177B999A725328330", scripts\mp\vehicles\damage::set_weapon_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79", scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8251188E33131BB80BEF5BC1B0596BFB6D411D5F3FD5CCFFB457", scripts\mp\vehicles\damage::set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795", scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_85A918C0514B5B122A2F5759E0BFD3EB674A07DF932355C16F8A", scripts\mp\vehicles\damage::set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_AF2619A06A23E1A88724F1E80C635153CED298D9C2FD2141A75BFA", scripts\mp\vehicles\damage::set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_99EA1113870319E55145A9343029C8C021AF4F", scripts\mp\vehicles\damage::set_death_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_A6250AB3B4ECCA9A8DED39AC", ::_id_14154);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_82D40AB35A679550EEB09346", ::_id_14153);
}

_id_14154(var_0, var_1, var_2) {
  if(istrue(var_2))
    scripts\mp\rank::scoreeventpopup(var_0);
  else
    scripts\mp\utility\points::giveunifiedpoints(var_0, var_1);
}

_id_14153(var_0, var_1, var_2) {
  thread scripts\mp\events::killeventtextpopup(var_0);

  if(!istrue(var_2))
    scripts\mp\awards::givemidmatchaward(var_0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
}