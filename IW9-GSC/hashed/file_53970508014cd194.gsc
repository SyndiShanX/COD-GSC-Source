/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_53970508014cd194.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("cp_observatory_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("cp_observatory_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "cp_observatory_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "cp_observatory_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "cp_observatory_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "jugg_aq";
  s.script_forcespawn = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4039.5, -12308, 4736), (0, 270, 0), "cp_observatory_spawner_storage_jugg", undefined, "jugg_aq");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3974.5, -12408.5, 4754), undefined, "cp_observatory_lockdoor", undefined, undefined, undefined, undefined, undefined, undefined, 150);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4327.5, -12326, 4754), undefined, "cp_observatory_lockdoor", undefined, undefined, undefined, undefined, undefined, undefined, 150);
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "jugg_aq";
  s.script_forcespawn = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4116, -12308.5, 4736), (0, 180, 0), "cp_observatory_spawner_storage_jugg", undefined, "jugg_aq");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (116.51, -13554.8, 4884.25), undefined, "cp_intel", undefined, "obs_intel_hd_01");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "jugg_aq";
  s.script_forcespawn = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4181.5, -12246.5, 4736), (0, 270, 0), "cp_observatory_spawner_storage_jugg", undefined, "jugg_aq");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "jugg_aq";
  s.script_forcespawn = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4219.5, -12184.5, 4736), (0, 270, 0), "cp_observatory_spawner_storage_jugg", undefined, "jugg_aq");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "jugg_aq";
  s.script_forcespawn = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4177.5, -12301, 4736), (0, 270, 0), "cp_observatory_spawner_storage_jugg", undefined, "jugg_aq");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "thumbdrive";
  s.scriptablename = "cp_intel_usb_thumb_drive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2286.96, -15515.7, 5084.05), undefined, "cp_intel", undefined, "obs_intel_usb_05");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "thumbdrive";
  s.scriptablename = "cp_intel_usb_thumb_drive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2136.45, -15368.8, 4828.29), undefined, "cp_intel", undefined, "obs_intel_usb_05");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "jugg_aq";
  s.script_forcespawn = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3972.5, -12308.5, 4736), (0, 270, 0), "cp_observatory_spawner_storage_jugg", undefined, "jugg_aq");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (27.95, -11113.5, 4743.93), (0, 262.17, 0), "cp_intel", undefined, "obs_intel_hd_02");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1556.67, -11947.9, 4768.36), (0, 106.96, 0), "cp_intel", undefined, "obs_intel_hd_04");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1438.5, -13960.5, 4910.75), (0, 0, 0), "cp_intel", undefined, "obs_intel_usb_04");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1373.25, -11836.8, 4855), undefined, "cspf_0_auto1", "cspf_0_auto2");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1372, -11834.5, 4855), (77.26, 305.62, -0), "obs_ghost_intel_03", "cspf_0_auto1");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1373.25, -11836.8, 4821), undefined, "cspf_0_auto2");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1391.5, -11836, 4854.25), undefined, "obs_purchase_intel_03");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "thumbdrive";
  s.scriptablename = "cp_intel_usb_thumb_drive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4135.75, -12227.5, 4771.25), (0, 335.26, 0), "cp_intel", undefined, "obs_intel_usb_01");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-295, -12635, 4895.25), undefined, "cp_intel", undefined, "obs_intel_hd_01");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-570.88, -11145.4, 4672), (0, 330, 0), "cp_intel", undefined, "obs_intel_hd_03");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "thumbdrive";
  s.scriptablename = "cp_intel_usb_thumb_drive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2636.75, -12320, 4769.5), (0, 315, 0), "cp_intel", undefined, "obs_intel_usb_02");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "thumbdrive";
  s.scriptablename = "cp_intel_usb_thumb_drive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1377.75, -11843.5, 4818.75), (34.08, 301.36, 0), "cp_intel", undefined, "obs_intel_usb_03");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3063, -14928.5, 4801), undefined, "cp_intel", undefined, "obs_intel_hd_05");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "thumbdrive";
  s.scriptablename = "cp_intel_usb_thumb_drive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1368, -15990.5, 4968), undefined, "cp_intel", undefined, "obs_intel_usb_05");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {
  _id_248EC5040062D3CE::main();
  _id_36967CE8EE2EA745::main();
}