/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_c0dbf7797af3068.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_saba_pm_butcher_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_saba_pm_butcher_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_saba_pm_butcher_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_saba_pm_butcher_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_saba_pm_butcher_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-808.46, -9588, 4856), (0, 105, 0), undefined, "cspf_0_auto14", "dmz_butcher_ritual");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11984, 31856, 616), undefined, undefined, "cspf_0_auto4", "dmz_butcher_ritual");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1208.71, -9574.2, 4624), (0, 9, 0), "cspf_0_auto14", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-902.58, -9892.41, 4622), (0, 82, 0), "cspf_0_auto14", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (12114, 32232, 390), (0, 270, 0), "cspf_0_auto4", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11750, 32012, 390), (0, 342, 0), "cspf_0_auto4", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (12458, 31992, 390), (0, 198, 0), "cspf_0_auto4", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (12323, 31566, 390), (0, 128, 0), "cspf_0_auto4", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11882, 31576, 390), (0, 55, 0), "cspf_0_auto4", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-42716.3, 41472, -11100), (0, 161, 0), "cspf_0_auto3", undefined, "dmz_altar_portal_teleport_return");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (12112.5, 31870.5, 434), undefined, "cspf_0_auto4", "cspf_0_auto2", "dmz_altar_portal");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s.name = "scriptable_dmz_altar_portal";
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-42695.4, 41525.2, -11138), (0, 71, 0), "cspf_0_auto2", "cspf_0_auto3", "dmz_altar_portal_teleport");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-990.5, -9219.36, 4624), (0, 297, 0), "cspf_0_auto14", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-42221.1, 42281.3, -10912), (0, 225, 0), undefined, "cspf_0_auto1", "boss_butcher");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-41733.3, 43226.8, -11174), (0, 238, 0), "cspf_0_auto1", undefined, "boss_butcher_spawn");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-576.08, -9277.5, 4624), (0, 225, 0), "cspf_0_auto14", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-41799.7, 42130.9, -11216), (0, 225, 0), "cspf_0_auto1", undefined, "boss_butcher_minion");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-42254.9, 42190.9, -11214), (0, 225, 0), "cspf_0_auto1", undefined, "dmz_altar_portal_teleport");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-42167.4, 42990.9, -11270), (0, 225, 0), "cspf_0_auto1", undefined, "boss_butcher_minion");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-41358, 41844, -11174), (0, 240, 0), "cspf_0_auto1", undefined, "boss_butcher_minion");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-42705.8, 42565.3, -11214), (0, 225, 0), "cspf_0_auto1", undefined, "boss_butcher_minion");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-509.6, -9714.06, 4624), (0, 154, 0), "cspf_0_auto14", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-842.5, -9529, 4674), (0, 105, 0), "cspf_0_auto14", "cspf_0_auto2", "dmz_altar_portal");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-22280, -30768, 768), (0, 360, 0), undefined, "cspf_0_auto24", "dmz_butcher_ritual");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-22156, -30402, 546), (0, 270, 0), "cspf_0_auto24", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-22514, -30618, 544), (0, 342, 0), "cspf_0_auto24", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-21812, -30640, 542), (0, 198, 0), "cspf_0_auto24", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-21947, -31060, 546), (0, 128, 0), "cspf_0_auto24", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-22386, -31046, 544), (0, 55, 0), "cspf_0_auto24", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-22157.5, -30758.5, 586), (0, 360, 0), "cspf_0_auto24", "cspf_0_auto2", "dmz_altar_portal");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-19800, 12440, 584), (0, 360, 0), undefined, "cspf_0_auto34", "dmz_butcher_ritual");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-19686, 12816, 358), (0, 270, 0), "cspf_0_auto34", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-20042, 12596, 356), (0, 342, 0), "cspf_0_auto34", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-19340, 12574, 358), (0, 197.99, 0), "cspf_0_auto34", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-19475, 12150, 358), (0, 127.99, 0), "cspf_0_auto34", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-19910, 12168, 356), (0, 54.99, 0), "cspf_0_auto34", undefined, "dmz_altar");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-19679.5, 12454.5, 402), (0, 360, 0), "cspf_0_auto34", "cspf_0_auto2", "dmz_altar_portal");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}