/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_d5107ac428658c.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_saba_br_silos")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_saba_br_silos");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_saba_br_silos");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_saba_br_silos");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_saba_br_silos");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7826, 13971, 544), (0, 225.7, 0), "missile_silo", "cspf_0_auto15559");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4734, -43329.5, 175.15), (0, 7.83, 0), "missile_silo", "cspf_0_auto15563");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-21359.5, -38869.5, 516.12), (0, 351.19, 0), "missile_silo", "cspf_0_auto15556");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (23600, -20998.2, 1827.86), (0, 83.25, 0), "missile_silo", "cspf_0_auto15561");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (16166, -37007, 1115.48), (0, 359.29, 0), "missile_silo", "cspf_0_auto15562");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-33039.7, -15191.2, 257.96), (0, 244.16, 0), "missile_silo", "cspf_0_auto15557");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-26380.5, 9193, 2046.28), (0, 260.53, 0), "missile_silo", "cspf_0_auto15558");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (22897.1, 2553.56, 301), (0, 181.98, 0), "missile_silo", "cspf_0_auto15560");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (23773, -21032.5, 1835.5), (0, 352.54, 0), "cspf_0_auto15561", undefined, "s5_reveal_laptop");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (16160.5, -37183, 1123.22), (0, 268.3, 0), "cspf_0_auto15562", undefined, "s5_reveal_laptop");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4758.5, -43506, 182.5), (0, 277.79, 0), "cspf_0_auto15563", undefined, "s5_reveal_laptop");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-21381, -39045, 523.5), (0, 261.1, 0), "cspf_0_auto15556", undefined, "s5_reveal_laptop");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-33211.5, -15126, 258.73), (0, 153.88, 0), "cspf_0_auto15557", undefined, "s5_reveal_laptop");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-26560, 9228, 2053.5), (0, 177.2, 0), "cspf_0_auto15558", undefined, "s5_reveal_laptop");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7947, 14098, 552), (0, 139.5, 0), "cspf_0_auto15559", undefined, "s5_reveal_laptop");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_br_silos";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (22880, 2731, 308.5), (0, 91.8, 0), "cspf_0_auto15560", undefined, "s5_reveal_laptop");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}