/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_deltacamp_anim.gsc
**********************************************/

main() {
  _id_4069();
  _id_4CBB();
  fx();
}

#using_animtree("generic_human");

_id_4069() {
  level._id_0C59["generic"]["sandman_idle"][0] = % killhouse_sas_price_idle;
  level._id_0C59["generic"]["truck_idle"][0] = % killhouse_gaz_idleb;
  level._id_0C59["generic"]["grinch_idle"][0] = % sitting_guard_loadak_idle;
}

_id_4CBB() {
  level.scr_sound["generic"]["so_deltacamp_snd_thanks"] = "so_deltacamp_snd_thanks";
  level.scr_sound["generic"]["so_deltacamp_snd_nicelydone"] = "so_deltacamp_snd_nicelydone";
  level.scr_sound["generic"]["so_deltacamp_snd_nogood"] = "so_deltacamp_snd_nogood";
  level.scr_sound["generic"]["so_deltacamp_trk_youreup"] = "so_deltacamp_trk_youreup";
  level.scr_sound["generic"]["so_deltacamp_trk_startingarea"] = "so_deltacamp_trk_startingarea";
  level.scr_sound["generic"]["so_deltacamp_trk_owntoys"] = "so_deltacamp_trk_owntoys";
  level._id_11BB["so_deltacamp_trk_tangos"] = "so_deltacamp_trk_tangos";
  level._id_11BB["so_deltacamp_trk_vehicles"] = "so_deltacamp_trk_vehicles";
  level._id_11BB["so_deltacamp_trk_targets"] = "so_deltacamp_trk_targets";
  level._id_11BB["so_deltacamp_trk_clear"] = "so_deltacamp_trk_clear";
  level._id_11BB["so_deltacamp_trk_knife"] = "so_deltacamp_trk_knife";
  level._id_11BB["so_deltacamp_trk_upthestairs"] = "so_deltacamp_trk_upthestairs";
  level._id_11BB["so_deltacamp_trk_allclear"] = "so_deltacamp_trk_allclear";
  level._id_11BB["so_deltacamp_trk_dogs"] = "so_deltacamp_trk_dogs";
  level._id_11BB["so_deltacamp_trk_bridgeclear"] = "so_deltacamp_trk_bridgeclear";
  level._id_11BB["so_deltacamp_trk_moveup"] = "so_deltacamp_trk_moveup";
  level._id_11BB["so_deltacamp_trk_civilians"] = "so_deltacamp_trk_civilians";
  level._id_11BB["so_deltacamp_trk_dontshoot"] = "so_deltacamp_trk_dontshoot";
  level._id_11BB["so_trainer2_trk_breach"] = "so_trainer2_trk_breach";
  level._id_11BB["so_trainer2_trk_roomclear"] = "so_trainer2_trk_roomclear";
  level._id_11BB["so_trainer2_trk_sniper"] = "so_trainer2_trk_sniper";
  level._id_11BB["so_trainer2_trk_anothercharge"] = "so_trainer2_trk_anothercharge";
  level._id_11BB["so_trainer2_trk_downstairs"] = "so_trainer2_trk_downstairs";
  level._id_11BB["so_trainer2_trk_uponbridge"] = "so_trainer2_trk_uponbridge";
  level._id_11BB["so_trainer2_trk_lastgroup"] = "so_trainer2_trk_lastgroup";
  level._id_11BB["so_deltacamp_trk_sprinttofinish"] = "so_deltacamp_trk_sprinttofinish";
  level._id_11BB["so_deltacamp_trk_runthecourse"] = "so_deltacamp_trk_runthecourse";
  level._id_11BB["so_deltacamp_trk_notgood"] = "so_deltacamp_trk_notgood";
  level._id_11BB["so_deltacamp_trk_betterthan"] = "so_deltacamp_trk_betterthan";
  level._id_11BB["so_deltacamp_trk_teamrecord"] = "so_deltacamp_trk_teamrecord";
  level._id_11BB["so_deltacamp_trk_personalbest"] = "so_deltacamp_trk_personalbest";
  level._id_11BB["so_deltacamp_trk_yourgo"] = "so_deltacamp_trk_yourgo";
  level._id_11BB["so_deltacamp_trk_whenever"] = "so_deltacamp_trk_whenever";
  level._id_11BB["so_deltacamp_trk_showinoff"] = "so_deltacamp_trk_showinoff";
}

fx() {}