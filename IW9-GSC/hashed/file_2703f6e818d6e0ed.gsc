/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2703f6e818d6e0ed.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("cp_raid1_boss1_shell_cs")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("cp_raid1_boss1_shell_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "cp_raid1_boss1_shell_cs");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "cp_raid1_boss1_shell_cs");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "cp_raid1_boss1_shell_cs");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (10177.9, 8406.23, 400), (0, 314, 0), "kitchen", undefined, "static_death_cam");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15078, 8066, 604), (0, 90, 0), "sub_bay", undefined, "static_death_cam");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (10199, 9597.63, 398), (0, 94, 0), "FIL", undefined, "static_death_cam");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7804.03, 14281.7, 339), (0, 306, 0), "FIL_1", undefined, "static_death_cam");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (6304.35, 14574.8, 433), (0, 268, 0), "tunnel", undefined, "static_death_cam");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5112.86, 11436.6, 3145), (40.03, 21.1, 13.94), "silo", undefined, "static_death_cam");
  s = scripts\common\create_script_utility::s();
  s.height = 200;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (13609.5, 8771, -14), undefined, "struct_dogtag_relocate", "cspf_0_auto2", undefined, undefined, undefined, undefined, undefined, 600);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14264.5, 8773, 78.5), undefined, "cspf_0_auto2");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14320, 8764.23, 178.25), undefined, "boss_ee_dogtag_relocate");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (12023.5, 7336, 302.5), undefined, "cspf_0_auto3");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11945, 7336.5, 302.5), undefined, "twomandoor_crusher", "cspf_0_auto3");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7802.5, 10389, -109));
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}