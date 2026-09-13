/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_63b29db74b692a3d.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_delta_champion_bombsites_cs")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_delta_champion_bombsites_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_delta_champion_bombsites_cs");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_delta_champion_bombsites_cs");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_delta_champion_bombsites_cs");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (10685, 1139, 135), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (12418, -9855, 237), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1283, -9308, 134), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (2952, -13946, 122), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7368, -7191, 243), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4547, 2538, 363), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5715, 6997, 102), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-169, 9605, 985), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7997, 14390, 110), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-11104, 7400, 237), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6842, 2004, 64), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4039, -254, 202), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2119, 5579, 175.51), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7791, -10183, 49), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13372, -5182, 57), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4148, -5137, 13), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8527, -1816, 123), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (8289, -2382, 144), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (289, -800, 143));
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (331, -855, 145));
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (374, -801, 144));
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-335, -662, 126), (0, 0, 0), "elite_arrow_spawn");
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (255, -882, 144));
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (219, -797, 144));
  s = scripts\common\create_script_utility::s();
  s.is_cs_scriptable = 1;
  s._id_2C1B5F4EC5220279 = "high";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (187, -875, 144));
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s.modelscale = "1";
  s._id_63205D4DDB640D1A = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14597, -10951, 43), (0, 0, 0), "elite_arrow_spawn");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}