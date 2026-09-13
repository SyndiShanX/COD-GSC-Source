/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_9285e51407085b0.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_fishtown_gw_gametype_cs")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_fishtown_gw_gametype_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_fishtown_gw_gametype_cs");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_fishtown_gw_gametype_cs");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_fishtown_gw_gametype_cs");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s.height = 144;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (8426.07, -39413.8, 212), undefined, "ctf_flag_allies_CS", undefined, "ctf_flag_allies_CS", undefined, undefined, undefined, undefined, 64);
  s = scripts\common\create_script_utility::s();
  s.height = 144;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7336, -50264.5, 160), undefined, "ctf_flag_axis_CS", undefined, "ctf_flag_axis_CS", undefined, undefined, undefined, undefined, 64);
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}