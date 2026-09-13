/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_611b35d0279eb120.gsc
***********************************************/

main() {
  waitframe();

  if(!getdvarint("dvar_9D28618B108B5283", 0)) {
    return;
  }
  level._id_A2B890D129C64761 = spawnStruct();
  level._id_A2B890D129C64761._id_AE723326800F7186 = getdvarint("dvar_FAA9C468AFB332AF", 1);
  level._id_A2B890D129C64761.capturetype = getdvarint("dvar_E45819DC2CEB297E", 0);
  level._id_A2B890D129C64761.usetime = getdvarfloat("dvar_74F9D7A8A450D786", 3);
  level._id_A2B890D129C64761.capturetime = getdvarfloat("dvar_0AAE48D9633D43C5", 20);
  level._id_A2B890D129C64761._id_8433181924C8E758 = getdvarint("dvar_DE2821E1E8645670", 1);
  level._id_A2B890D129C64761._id_A9375F419858B31D = getdvarint("dvar_77140A057CF0A92B", 0);
  level._id_A2B890D129C64761._id_7B1FAF384884829E = getdvarint("dvar_33F630ADB53F41F2", 0);
  level._id_A2B890D129C64761._id_7AFBC138485C2F7C = getdvarint("dvar_33D33AADB5191038", 0);
  level._id_A2B890D129C64761._id_E5D20DAC7C4B5F77 = getdvarfloat("dvar_FCFE3E616DE4891E", 0.5);
  level._id_A2B890D129C64761._id_AB8392FD7E88DFD6 = getdvarint("dvar_79ECC2BA2BA9E4FB", 2);
  level._id_A2B890D129C64761._id_BD3E92971CB005FA = getdvarint("dvar_7C5279D2337CB218", 0);
  level._id_A2B890D129C64761._id_FA55BCB71C71C51F = getdvarint("dvar_417F6B4E942F227F", 0);
  level._id_A2B890D129C64761._id_950874BDCA059EBA = getdvarint("dvar_DEB7DD9D9C63B780", 0);
  level._id_A2B890D129C64761._id_2DA00E8B3142EBC7 = getdvarint("dvar_A414816DCE5C1997", 18000.0);
  level._id_A2B890D129C64761._id_3CB86E5589BC18C5 = getdvarint("dvar_616C8529CA3FB0CB", 0);
  level._id_A2B890D129C64761._id_782E38B4F2AC96EA = getdvarint("dvar_9CCC2149828913B9", 1);
  level._id_A2B890D129C64761._id_6A9D71450A3A6052 = getdvarint("dvar_55D9754797CD078F", 1);
  level._id_A2B890D129C64761._id_F267F88C658A4472 = getdvarfloat("dvar_623E76725D77490B", 12.0);
  level._id_A2B890D129C64761._id_13AECE9B7DC02671 = getdvarfloat("dvar_BD983C7E6E7DD092", 2000);
  level._id_A2B890D129C64761._id_D3662B3C655BA592 = getdvarfloat("dvar_B5F647A17B30076C", 15.0);
  level._id_A2B890D129C64761._id_E1920D31E93302AC = getdvarfloat("dvar_7E56AE1363692F26", 0.5);
  level._id_A2B890D129C64761._id_92D9B21FF53EBA08 = getdvarfloat("dvar_442711D48892852D", 10000);
  level._id_A2B890D129C64761._id_85B9A46B341F8A88 = getdvarfloat("dvar_C5095E6B9C193FCD", 0.0);
  level._id_A2B890D129C64761._id_03B043818A571222 = getdvarfloat("dvar_33DD70AFEEFF1271", 0.6);
  level._id_A2B890D129C64761._id_CABF633EBF5787E8 = getdvarfloat("dvar_60A33CE9D8C34784", 8000.0);
  level._id_A2B890D129C64761._id_BE698ADC7F8793C1 = getdvarint("dvar_85A2AA334E07EB3A", 5);
  level._id_A2B890D129C64761._id_6B5164DC23169A95 = getdvarfloat("dvar_ED0765A1F35A9C08", 800);
  level._id_A2B890D129C64761._id_83CBC452240B923D = getdvarfloat("dvar_B15C4E1BA77B6BE8", 100);
  level._id_A2B890D129C64761._id_3705BCC56DCBDACF = getdvarint("dvar_C48E0705B24D2837", 600);
  level._id_A2B890D129C64761._id_7A734A019C378972 = getdvarint("dvar_E748F00B7BC0083A", 1800);
  level._id_A2B890D129C64761._id_55BADF39D8C0ADF8 = getdvarfloat("dvar_76C0990FECF54DDC", 0.5);
  level._id_A2B890D129C64761._id_F887A3C6038A17F7 = getdvarfloat("dvar_C7B351CD83E82BA1", 0.8);
  level._id_A2B890D129C64761._id_7026908F55D260E9 = getdvarint("dvar_5C30BD5CCA9D72E6", 1);
  level._id_A2B890D129C64761._id_5039CC33EF474075 = getDvar("dvar_74E9023F1B963418", "");
  level._id_A2B890D129C64761._id_DE0C0A02B71959F5 = [];
  level._id_A2B890D129C64761._id_6C8F3693DDC4B4CF = 0;
  level._id_A2B890D129C64761._id_924729CD78FE8C30 = randomintrange(level._id_A2B890D129C64761._id_7B1FAF384884829E, level._id_A2B890D129C64761._id_7AFBC138485C2F7C + 1);
  level._id_A2B890D129C64761._id_C4C835414F3BD6FA = randomfloat(1.0);
  level._id_A2B890D129C64761._id_BA657D0956DD724B = 0;
  level._id_A2B890D129C64761._id_0FC484BF07EC5682 = getEnt("reveal_missile_silo_col", "script_noteworthy");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("missile_silo_usable", ::_id_EB1DFD659C785A01);
  scripts\cp_mp\utility\script_utility::registersharedfunc("strongholds", "disableStrongholdSpawn", ::_id_0ADE3AE773C41C08);
  _id_37D11A3B084F00FF();
  _id_AA0FB4301A2106D9();
  _id_0F606ECAEC8E20E9();

  if(getdvarint("dvar_F6D437EE9DAA50B8", 0) && getdvarint("scr_ssc_enabled", 0)) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("missile_silo", ::_id_1BE9B8BFEE609007);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("missile_silo", ::_id_8BB01F4FFF6BD155);
  } else {
    _id_69ACA6F507F97C22 = _id_BA4889C460B3FD1B();

    if(isDefined(_id_69ACA6F507F97C22)) {
      foreach(_id_F3DCB764041B4525 in _id_69ACA6F507F97C22) {
        _id_5F060A7196599BEC = scripts\engine\utility::getStruct(_id_F3DCB764041B4525.targetname, "target");
        _id_C45248FDF60A7B9A = _id_8BB01F4FFF6BD155(_id_5F060A7196599BEC);
        _id_03B699446FF86659(_id_F3DCB764041B4525, _id_C45248FDF60A7B9A);
      }
    }
  }
}

_id_37D11A3B084F00FF() {
  _id_FA3697898BE9A322 = "iw9_missile_silos_" + level.mapname;

  if(level._id_A2B890D129C64761._id_5039CC33EF474075 != "")
    _id_FA3697898BE9A322 = level._id_A2B890D129C64761._id_5039CC33EF474075;

  _id_D442547D75DFFD09 = getscriptbundle("missilesilos:" + _id_FA3697898BE9A322);

  if(!isDefined(_id_D442547D75DFFD09)) {
    return;
  }
  _id_A58A5F1E3BC357F3 = [];

  foreach(_id_1205AB05F7031332 in _id_D442547D75DFFD09._id_A58A5F1E3BC357F3) {
    _id_4624C9E93B0907F7 = spawnStruct();
    _id_4624C9E93B0907F7._id_69A45793029B3BB7 = _id_1205AB05F7031332._id_69A45793029B3BB7;
    _id_4624C9E93B0907F7.group = scripts\engine\utility::_id_53C4C53197386572(_id_1205AB05F7031332.group, "");
    _id_4624C9E93B0907F7.targetorigin = (scripts\engine\utility::_id_53C4C53197386572(_id_1205AB05F7031332.targetorigin.x, 0), scripts\engine\utility::_id_53C4C53197386572(_id_1205AB05F7031332.targetorigin.y, 0), scripts\engine\utility::_id_53C4C53197386572(_id_1205AB05F7031332.targetorigin.z, 0));
    _id_4624C9E93B0907F7._id_A6DB31654F0937DC = scripts\engine\utility::_id_53C4C53197386572(_id_1205AB05F7031332._id_A6DB31654F0937DC, 0);
    _id_A58A5F1E3BC357F3[_id_4624C9E93B0907F7.group] = scripts\engine\utility::_id_53C4C53197386572(_id_A58A5F1E3BC357F3[_id_4624C9E93B0907F7.group], []);
    _id_A58A5F1E3BC357F3[_id_4624C9E93B0907F7.group] = scripts\engine\utility::array_add(_id_A58A5F1E3BC357F3[_id_4624C9E93B0907F7.group], _id_4624C9E93B0907F7);
  }

  level._id_A2B890D129C64761._id_A58A5F1E3BC357F3 = _id_A58A5F1E3BC357F3;
  level._id_A2B890D129C64761._id_726B8413D1D9F802 = getarraykeys(_id_A58A5F1E3BC357F3);
  level._id_A2B890D129C64761._id_6523E7DF766D5380 = level._id_A2B890D129C64761._id_726B8413D1D9F802;
  _id_B662B14AA120B2C4 = spawnStruct();
  _id_B662B14AA120B2C4._id_B012D72D07F635D5 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_B012D72D07F635D5, "");
  _id_B662B14AA120B2C4._id_2C13CBD06F75F0EB = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_2C13CBD06F75F0EB, "");
  _id_B662B14AA120B2C4._id_2603BE52BF02F3D9 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_2603BE52BF02F3D9, "");
  _id_B662B14AA120B2C4.targetorigin = (scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1.targetorigin.x, 0), scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1.targetorigin.y, 0), scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1.targetorigin.z, 0));
  _id_B662B14AA120B2C4._id_6E56644C5FE6BEED = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_6E56644C5FE6BEED, 0);
  _id_B662B14AA120B2C4._id_E34B27B3C09E46F6 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_E34B27B3C09E46F6, 0.0);
  _id_B662B14AA120B2C4._id_DBFDA454AF269213 = (scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_DBFDA454AF269213.x, 0), scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_DBFDA454AF269213.y, 0), scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_DBFDA454AF269213.z, 0));
  _id_B662B14AA120B2C4._id_8C250069F8D238EC = _id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_8C250069F8D238EC;
  _id_B662B14AA120B2C4._id_43076B08E8B2E81A = _id_D442547D75DFFD09._id_C4F0A71B3DFAC5A1._id_43076B08E8B2E81A;
  level._id_A2B890D129C64761._id_C4F0A71B3DFAC5A1 = _id_B662B14AA120B2C4;
}

#using_animtree("script_model");

_id_AA0FB4301A2106D9() {
  level.scr_animtree["missile_silo"] = #animtree;
  level.scr_anim["missile_silo"]["missile_silo_capture_start"] = % military_launcher_computer_terminal_enter;
  level.scr_animname["missile_silo"]["missile_silo_capture_start"] = "military_launcher_computer_terminal_enter";
  level.scr_eventanim["missile_silo"]["missile_silo_capture_start"] = "use_missile_silo_enter";
  level.scr_viewmodelanim["missile_silo"]["missile_silo_capture_start"] = "military_launcher_computer_terminal_enter";
  level.scr_anim["missile_silo"]["missile_silo_capture_loop"] = % military_launcher_computer_terminal_idle;
  level.scr_animname["missile_silo"]["missile_silo_capture_loop"] = "military_launcher_computer_terminal_idle";
  level.scr_eventanim["missile_silo"]["missile_silo_capture_loop"] = "use_missile_silo_idle";
  level.scr_viewmodelanim["missile_silo"]["missile_silo_capture_loop"] = "military_launcher_computer_terminal_idle";
  level.scr_anim["missile_silo"]["missile_silo_capture_exit"] = % military_launcher_computer_terminal_exit;
  level.scr_animname["missile_silo"]["missile_silo_capture_exit"] = "military_launcher_computer_terminal_exit";
  level.scr_eventanim["missile_silo"]["missile_silo_capture_exit"] = "use_missile_silo_exit";
  level.scr_viewmodelanim["missile_silo"]["missile_silo_capture_exit"] = "military_launcher_computer_terminal_exit";
}

_id_83015C5ABCB34043(_id_57E8E2D401F79EF6, dialog) {
  _id_4D497C680119802D = getDvar(_func_2EF675C13CA1C4AF("dvar_C1AF2A02970B56E1", _id_57E8E2D401F79EF6));

  if(isDefined(_id_4D497C680119802D) && _id_4D497C680119802D != "") {
    if(_id_4D497C680119802D == "UNDEFINED") {
      return;
    }
    dialog = _id_4D497C680119802D;
  }

  game["dialog"][_id_57E8E2D401F79EF6] = dialog;
}

_id_0F606ECAEC8E20E9() {
  if(!getdvarint("dvar_2BE93DD484220A45", 0)) {
    _id_83015C5ABCB34043("missile_silo_miss", "dx_br_dmzc_assd_wzan_krom");
    _id_83015C5ABCB34043("missile_silo_hit", "dx_br_dmzc_prca_wzan_kroh");
  }
}

_id_0ADE3AE773C41C08(_id_276AC5E84835EA87) {
  if(!level._id_A2B890D129C64761._id_AE723326800F7186)
    return 0;

  return _id_276AC5E84835EA87._id_B205D90302DA2F07 == "saba_observatory";
}

_id_1BE9B8BFEE609007() {
  return scripts\engine\utility::getStructArray("missile_silo", "targetname");
}

_id_BA4889C460B3FD1B() {
  return scripts\engine\utility::getStructArray("s5_reveal_laptop", "script_noteworthy");
}

_id_8BB01F4FFF6BD155(_id_5F060A7196599BEC) {
  _id_C45248FDF60A7B9A = spawn("script_model", _id_5F060A7196599BEC.origin);
  _id_C45248FDF60A7B9A.angles = scripts\engine\utility::_id_53C4C53197386572(_id_5F060A7196599BEC.angles, (0, 0, 0));
  _id_C45248FDF60A7B9A setModel("military_launcher_container_single_full_missile_silo");
  _id_C45248FDF60A7B9A._id_CA3708C44459C6EA = 1;
  thread _id_9D10DFFE4F6AADD0(_id_C45248FDF60A7B9A);
  thread _id_92B1AA8766C210DC(_id_C45248FDF60A7B9A);
  thread _id_A712A65046C760C5(_id_C45248FDF60A7B9A);
  _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "idle");
  _id_02745C0FB0E502C9(_id_C45248FDF60A7B9A);
  level._id_A2B890D129C64761._id_DE0C0A02B71959F5[level._id_A2B890D129C64761._id_DE0C0A02B71959F5.size] = _id_C45248FDF60A7B9A;
  return _id_C45248FDF60A7B9A;
}

_id_02745C0FB0E502C9(_id_C45248FDF60A7B9A) {
  if(isDefined(level._id_A2B890D129C64761._id_0FC484BF07EC5682)) {
    _id_5EB5C5DCCE16FB6D = spawn("script_model", _id_C45248FDF60A7B9A.origin);
    _id_5EB5C5DCCE16FB6D clonebrushmodeltoscriptmodel(level._id_A2B890D129C64761._id_0FC484BF07EC5682);
    _id_5EB5C5DCCE16FB6D.angles = _id_C45248FDF60A7B9A.angles;
    _id_C45248FDF60A7B9A._id_5EB5C5DCCE16FB6D = _id_5EB5C5DCCE16FB6D;
    thread _id_9A905AD5676B211D(_id_C45248FDF60A7B9A, _id_5EB5C5DCCE16FB6D);
    return _id_5EB5C5DCCE16FB6D;
  }
}

_id_D7624E4CBDA6BF94(origin, player) {
  missile = magicgrenademanual("missile_silo_missile_proj", origin, (0, 0, 0), 50);

  if(isDefined(player)) {
    missile setotherent(player);
    missile setentityowner(player);
  }

  missile._id_410D75D1C571E537 = spawnStruct();
  return missile;
}

_id_11DEC6FD87C08A42(origin, velocity, player) {
  missile = magicgrenademanual("missile_silo_cluster_missile_proj", origin, velocity, 50);
  missile forcenetfieldhighlod(1);

  if(isDefined(player)) {
    missile setotherent(player);
    missile setentityowner(player);
  }

  return missile;
}

_id_C6621FAC8DF7A66A(origin) {
  _id_6A6582634164E845 = spawn("script_model", origin);
  _id_6A6582634164E845 setModel("tag_origin");
  return _id_6A6582634164E845;
}

_id_24AE66C814F14D3C(_id_C45248FDF60A7B9A) {
  origin = _id_C45248FDF60A7B9A.usable.origin;
  origin = (origin[0], origin[1], origin[2] - level._id_A2B890D129C64761._id_3705BCC56DCBDACF / 2);
  _id_AAC94CE6A0278A36 = spawn("noent_volume_trigger_radius", origin, 0, level._id_A2B890D129C64761._id_7A734A019C378972, level._id_A2B890D129C64761._id_3705BCC56DCBDACF);
  _id_AAC94CE6A0278A36._id_C45248FDF60A7B9A = _id_C45248FDF60A7B9A;
  _id_C45248FDF60A7B9A._id_AAC94CE6A0278A36 = _id_AAC94CE6A0278A36;
  return _id_AAC94CE6A0278A36;
}

_id_03B699446FF86659(_id_5EF42692B24E3DA0, _id_C45248FDF60A7B9A) {
  _id_5CCD62BA7DFE0E79 = scripts\engine\utility::_id_53C4C53197386572(_id_5EF42692B24E3DA0.angles, (0, 0, 0));
  _id_9EFE117534A94AF7 = _id_5EF42692B24E3DA0.origin;
  usable = spawnscriptable("missile_silo_usable", _id_9EFE117534A94AF7, _id_5CCD62BA7DFE0E79);
  _id_364384B9D084F84E(usable, 0);
  usable._id_C45248FDF60A7B9A = _id_C45248FDF60A7B9A;
  _id_C45248FDF60A7B9A.usable = usable;
  return usable;
}

_id_C641D94D6C38CA79(_id_C45248FDF60A7B9A, targetorigin) {
  _id_9AF72BBDFDEACE5D = _id_C45248FDF60A7B9A gettagorigin("j_military_launcher_taget");
  _id_8983DAA29FE0756F = targetorigin - _id_9AF72BBDFDEACE5D;
  _id_CE209026296965B3 = (0, vectortoyaw(_id_8983DAA29FE0756F), 0);
  vfx = spawn("script_model", _id_9AF72BBDFDEACE5D);
  vfx.angles = _id_CE209026296965B3;
  vfx setModel("missile_silo_missile_vfx");
  vfx forcenetfieldhighlod(1);
  return vfx;
}

_id_8DBD624CAADBBA39(_id_C45248FDF60A7B9A) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  _id_C45248FDF60A7B9A.objid = objid;
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", _id_C45248FDF60A7B9A.usable.origin + (0, 0, 70), "icon_s5_missile_single");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);

  if(istrue(level._id_A2B890D129C64761._id_FA55BCB71C71C51F))
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
  else
    _id_627B388E1CD025AC(objid);

  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::_id_41F90376AB869B9F(objid, 1);
  scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(objid, &"MP_BR_INGAME/MISSILE_SILO");
  scripts\mp\objidpoolmanager::_id_C3C6BFF089DFDD34(objid, "icon_medium");
  return objid;
}

_id_50D251544EFD9174(_id_C45248FDF60A7B9A, origin) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  _id_C45248FDF60A7B9A._id_75F558A60D4866EA = objid;
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", origin + (0, 0, 70), "ui_map_icon_missile_silo_red");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::_id_41F90376AB869B9F(objid, 1);
  scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(objid, &"MP_BR_INGAME/MISSILE_SILO");
  scripts\mp\objidpoolmanager::_id_C3C6BFF089DFDD34(objid, "icon_medium");
  return objid;
}

_id_90BEB4A379C452CC(origin, icon) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", origin, icon);
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 1);
  scripts\mp\objidpoolmanager::_id_41F90376AB869B9F(objid, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  scripts\mp\objidpoolmanager::_id_F21E9B2E78DE984B(objid, 35000, 37000);
  return objid;
}

_id_ABE0B1FD1B06AC9E(_id_C45248FDF60A7B9A) {
  _id_59AA8A9A4B200544 = _func_4AD9053267734CF2((70, -180, 30), _id_C45248FDF60A7B9A.origin, _id_C45248FDF60A7B9A.angles);
  smokesignal = spawn("script_model", _id_59AA8A9A4B200544);
  smokesignal setModel("missile_silo_smoke_signal");
  smokesignal setscriptablepartstate("missile_silo_smoke_signal", "on");
  smokesignal forcenetfieldhighlod(1);
  _id_C45248FDF60A7B9A.smokesignal = smokesignal;
  return smokesignal;
}

_id_E55AF4FF9B981CB6(_id_C9D3A177DA21FCD7) {
  if(!level._id_A2B890D129C64761._id_6A9D71450A3A6052 || !isDefined(_id_C9D3A177DA21FCD7.player)) {
    return;
  }
  origin = _id_C9D3A177DA21FCD7.targetorigin;
  marker = spawn("script_model", origin);
  marker setModel("missile_silo_marker");
  marker setscriptablepartstate("target", "on");
  marker hide();
  marker.objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add_objective(marker.objid, "current", (origin[0], origin[1], origin[2] + 50), "icon_s5_missile_single");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objid, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objid, 0);
  scripts\mp\objidpoolmanager::_id_41F90376AB869B9F(marker.objid, 1);
  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(marker.objid, _id_C9D3A177DA21FCD7.player);
  scripts\mp\objidpoolmanager::_id_F21E9B2E78DE984B(marker.objid, 3000, 3700);
  marker scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("missile_silo_marker", _id_C9D3A177DA21FCD7.targetorigin, level._id_A2B890D129C64761._id_13AECE9B7DC02671, _id_C9D3A177DA21FCD7.player);
  marker scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(_id_C9D3A177DA21FCD7.player.team, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    marker showtoplayer(player);
    marker scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
  }

  return marker;
}

_id_8D1C6E2CD8759299(player, origin, angles) {
  _id_03D38C1178E0256C = spawn("script_arms", origin, 0, 0, player);
  _id_03D38C1178E0256C.angles = angles;
  _id_03D38C1178E0256C useanimtree(#animtree);
  return _id_03D38C1178E0256C;
}

_id_BC70E115645C09B5(marker) {
  if(isDefined(marker)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(marker.objid);
    marker scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
    marker delete();
  }
}

_id_92B1AA8766C210DC(_id_C45248FDF60A7B9A) {
  level endon("game_ended");
  _id_C45248FDF60A7B9A endon("death");

  if(level._id_A2B890D129C64761.capturetype == 3) {
    return;
  }
  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1)
    scripts\mp\flags::_id_1240434F4201AC9D("infil_animatic_complete");
  else {
    scripts\mp\flags::_id_1240434F4201AC9D("prematch_fade_done");
    wait 5.0;
  }

  _id_364384B9D084F84E(_id_C45248FDF60A7B9A.usable, 1);

  if(istrue(level._id_A2B890D129C64761._id_BD3E92971CB005FA)) {
    _id_8DBD624CAADBBA39(_id_C45248FDF60A7B9A);

    if(level._id_A2B890D129C64761.capturetype == 1)
      _id_50D251544EFD9174(_id_C45248FDF60A7B9A, _id_C45248FDF60A7B9A.usable.origin);
  }
}

_id_A712A65046C760C5(_id_C45248FDF60A7B9A) {
  if(!level._id_A2B890D129C64761._id_950874BDCA059EBA) {
    return;
  }
  level endon("game_ended");
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_fade_done");

  for(;;) {
    wait 1.0;

    if(isDefined(level.br_ac130) && isDefined(level.infilstruct) && isDefined(level.infilstruct.c130pathstruct)) {
      break;
    }
  }

  smokesignal = _id_ABE0B1FD1B06AC9E(_id_C45248FDF60A7B9A);
  smokesignal endon("death");
  _id_7A05F5CEED8AB610 = _func_767CEA82B001F645(level.infilstruct.c130pathstruct.endpt - level.infilstruct.c130pathstruct.startpt);

  while(isDefined(level.br_ac130)) {
    wait 1;
    _id_DEEB3927A04A2453 = level.br_ac130.origin + _id_7A05F5CEED8AB610 * level._id_A2B890D129C64761._id_2DA00E8B3142EBC7;
    _id_C82BEF0C5439A709 = smokesignal.origin - _id_DEEB3927A04A2453;
    _id_A09A8BC6C7B30B99 = _func_C1AA7C066EC92CA5(_id_C82BEF0C5439A709, _id_7A05F5CEED8AB610);

    if(_id_A09A8BC6C7B30B99 <= 0.0) {
      smokesignal delete();
      return;
    }
  }
}

_id_613DBC959F70FF26(_id_C45248FDF60A7B9A) {
  if(_id_C45248FDF60A7B9A.state == "idle") {
    _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "capturing_0_percent");
    wait 6.0;
  }

  if(_id_C45248FDF60A7B9A.state == "capturing_0_percent") {
    _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "capturing_50_percent");
    wait 13.0;
  }

  if(_id_C45248FDF60A7B9A.state == "capturing_50_percent") {
    _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "capturing_100_percent");
    wait 13.0;
  }

  if(_id_C45248FDF60A7B9A.state == "capturing_100_percent") {
    _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "ready");
    wait 1.0;
  }
}

_id_A8380084DC709AEF(_id_C45248FDF60A7B9A, state) {
  _id_C45248FDF60A7B9A setscriptablepartstate("missile_silo", state);
  _id_C45248FDF60A7B9A.state = state;

  if(state == "ready") {
    if(isDefined(_id_C45248FDF60A7B9A._id_5EB5C5DCCE16FB6D))
      _id_C45248FDF60A7B9A._id_5EB5C5DCCE16FB6D delete();
  }
}

_id_88CB27AA9FDAB581(_id_C45248FDF60A7B9A) {
  _id_AAC94CE6A0278A36 = _id_24AE66C814F14D3C(_id_C45248FDF60A7B9A);
  _id_C45248FDF60A7B9A playLoopSound("iw9_jup_rvl_missle_alarm");
  _id_AAC94CE6A0278A36 endon("death");
  _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "capturing_0_percent");

  if(isDefined(_id_C45248FDF60A7B9A.objid))
    scripts\mp\objidpoolmanager::objective_show_progress(_id_C45248FDF60A7B9A._id_75F558A60D4866EA, 1, undefined, 1);

  _id_C45248FDF60A7B9A._id_36E74A5C1B872594 = 0;
  _id_C45248FDF60A7B9A._id_20CC28D3805BC6DF = 0;

  if(istrue(level._id_291B51C7AF8D1204))
    objective_icon(_id_C45248FDF60A7B9A.objid, "ui_map_icon_missile_silo_red");

  scripts\mp\utility\trigger::makeenterexittrigger(_id_AAC94CE6A0278A36, ::_id_0F1799212994B809, ::_id_D519B2E3B8AE119B, undefined, undefined, ::_id_D5A919E5DDFADCE9);
  _id_396B752E11D52207 = 0;

  while(!istrue(_id_C45248FDF60A7B9A._id_2805526A6AFBEF5B)) {
    if(_id_C45248FDF60A7B9A._id_36E74A5C1B872594 > 0) {
      _id_396B752E11D52207 = _id_396B752E11D52207 + 0.2;
      _id_18F5387DF0880206(_id_C45248FDF60A7B9A, _id_396B752E11D52207);

      if(_id_396B752E11D52207 >= level._id_A2B890D129C64761.capturetime) {
        _id_DBE60E54B97480EB(_id_C45248FDF60A7B9A);
        break;
      }
    }

    wait 0.2;
  }

  if(isDefined(_id_C45248FDF60A7B9A._id_AAC94CE6A0278A36))
    _id_C45248FDF60A7B9A._id_AAC94CE6A0278A36 delete();
}

_id_EB1DFD659C785A01(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_C45248FDF60A7B9A = instance._id_C45248FDF60A7B9A;

  if(!isDefined(_id_C45248FDF60A7B9A)) {
    return;
  }
  thread _id_A3C014A439BADC49(_id_C45248FDF60A7B9A, player);
}

_id_364384B9D084F84E(_id_808FC2C6B227ADCE, isusable) {
  state = scripts\engine\utility::ter_op(isusable, "usable", "unusable");
  _id_808FC2C6B227ADCE setscriptablepartstate("missile_silo_usable", state);
}

_id_A3C014A439BADC49(_id_C45248FDF60A7B9A, player) {
  if(!_id_33AA2921A1917343(_id_C45248FDF60A7B9A, player, 1)) {
    return;
  }
  _id_C45248FDF60A7B9A._id_769B15F773ADECB6 = 1;
  _id_364384B9D084F84E(_id_C45248FDF60A7B9A.usable, 0);
  _id_8F988C6AFDAB65EF = _id_74888EE4EEC64FD4(player, _id_C45248FDF60A7B9A);

  if(_id_8F988C6AFDAB65EF) {
    switch (level._id_A2B890D129C64761.capturetype) {
      case 0:
        _id_DBE60E54B97480EB(_id_C45248FDF60A7B9A, player);
        break;
      case 1:
        _id_88CB27AA9FDAB581(_id_C45248FDF60A7B9A);
        break;
      case 2:
        if(isDefined(_id_C45248FDF60A7B9A._id_445F2D1BE8A9DD9E))
          [[_id_C45248FDF60A7B9A._id_445F2D1BE8A9DD9E]](_id_C45248FDF60A7B9A, player);

        break;
    }
  } else
    _id_364384B9D084F84E(_id_C45248FDF60A7B9A.usable, 1);

  _id_C45248FDF60A7B9A._id_769B15F773ADECB6 = 0;
}

_id_74888EE4EEC64FD4(player, _id_C45248FDF60A7B9A) {
  player setstance("stand");
  player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33(1);
  waitframe();
  usable = _id_C45248FDF60A7B9A.usable;
  origin = _func_4AD9053267734CF2((-10, 0, 0), usable.origin, usable.angles);
  angles = (0, usable.angles[1], 0);
  player._id_A68533829C9BF898 = player.origin;
  player setOrigin(origin);
  player.angles = angles;
  _id_03D38C1178E0256C = _id_8D1C6E2CD8759299(player, origin, angles);
  player playerlinktoabsolute(_id_03D38C1178E0256C, "tag_player");
  _id_03D38C1178E0256C showonlytoplayer(player);
  animstruct = spawnStruct();
  animstruct.origin = player.origin;
  animstruct.angles = player.angles;
  _id_8F988C6AFDAB65EF = _id_A1360E848C238539(player, _id_03D38C1178E0256C, _id_C45248FDF60A7B9A, animstruct);
  animstruct notify("death");
  player unlink();
  _id_03D38C1178E0256C delete();
  waitframe();
  player scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  player._id_A68533829C9BF898 = undefined;
  return istrue(_id_8F988C6AFDAB65EF);
}

_id_A1360E848C238539(player, _id_03D38C1178E0256C, _id_C45248FDF60A7B9A, animstruct) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  _id_C45248FDF60A7B9A endon("missile_silo_captured");
  player playlocalsound("iw9_jup_rvl_missile_keyboard");
  _id_FCD0021D5FBBA70B(player, "missile_silo_capture_start", _id_03D38C1178E0256C, animstruct);
  _id_FCD0021D5FBBA70B(player, "missile_silo_capture_loop", _id_03D38C1178E0256C, animstruct, level._id_A2B890D129C64761.usetime);
  _id_FCD0021D5FBBA70B(player, "missile_silo_capture_exit", _id_03D38C1178E0256C, animstruct);
  return 1;
}

_id_FCD0021D5FBBA70B(player, animname, _id_03D38C1178E0256C, animstruct, _id_871AFA377C70F27F) {
  animstruct childthread scripts\mp\anim::anim_player_solo(player, _id_03D38C1178E0256C, animname, undefined, undefined, "missile_silo");

  if(isDefined(_id_871AFA377C70F27F)) {
    scripts\engine\utility::waittill_any_timeout_1(_id_871AFA377C70F27F, animname);
    animstruct notify("death");
  } else
    animstruct waittill(animname);
}

_id_62C710D0E3679098(player, _id_67243B08ECF2E214) {
  if(isDefined(level.showerrormessagefunc) && isDefined(_id_67243B08ECF2E214))
    player[[level.showerrormessagefunc]](_id_67243B08ECF2E214);
}

_id_33AA2921A1917343(_id_C45248FDF60A7B9A, player, _id_D7F72825D583F8FE) {
  if(istrue(_id_C45248FDF60A7B9A._id_2805526A6AFBEF5B) || istrue(_id_C45248FDF60A7B9A._id_769B15F773ADECB6)) {
    if(istrue(_id_D7F72825D583F8FE))
      _id_62C710D0E3679098(player, "MP/CANNOT_USE_GENERIC");

    return 0;
  }

  if(!scripts\mp\utility\player::isreallyalive(player) || istrue(player.inlaststand)) {
    if(istrue(_id_D7F72825D583F8FE))
      _id_62C710D0E3679098(player, "MP/CANNOT_USE_GENERIC");

    return 0;
  }

  if(isDefined(player) && istrue(player._id_859654E0445A36D9)) {
    if(istrue(_id_D7F72825D583F8FE))
      _id_62C710D0E3679098(player, "MP/DENY_USE_CARRY");

    return 0;
  }

  if(player isthrowinggrenade() || player isswitchingweapon() || isDefined(player getheldoffhand()) && !isnullweapon(player getheldoffhand())) {
    if(istrue(_id_D7F72825D583F8FE))
      _id_62C710D0E3679098(player, "MP/CANNOT_USE_GENERIC");

    return 0;
  }

  return 1;
}

_id_DBE60E54B97480EB(_id_C45248FDF60A7B9A, _id_245BF5C3AF6626E8, _id_C75905095A6EC021) {
  if(istrue(_id_C45248FDF60A7B9A._id_2805526A6AFBEF5B)) {
    return;
  }
  _id_C45248FDF60A7B9A._id_245BF5C3AF6626E8 = _id_245BF5C3AF6626E8;
  _id_364384B9D084F84E(_id_C45248FDF60A7B9A.usable, 0);
  _id_11366B1211380A98(_id_C45248FDF60A7B9A);
  level._id_A2B890D129C64761._id_6C8F3693DDC4B4CF++;
  _id_164622EB2B0F5390::_id_A692B5B8ADAD2899(_id_C45248FDF60A7B9A);
  _id_C45248FDF60A7B9A._id_2805526A6AFBEF5B = 1;
  _id_C45248FDF60A7B9A notify("missile_silo_captured");
  thread _id_82A701DE8D58907C(_id_C45248FDF60A7B9A);
  _id_613DBC959F70FF26(_id_C45248FDF60A7B9A);

  if(istrue(_id_C75905095A6EC021)) {
    return;
  }
  wait 6.0;
  _id_61152018CC47C0C7 = level._id_A2B890D129C64761._id_A9375F419858B31D > 0 && level._id_A2B890D129C64761._id_6C8F3693DDC4B4CF == level._id_A2B890D129C64761._id_A9375F419858B31D;
  _id_C2E69D0FD47E7122 = level._id_A2B890D129C64761._id_924729CD78FE8C30 > 0 && level._id_A2B890D129C64761._id_6C8F3693DDC4B4CF >= level._id_A2B890D129C64761._id_924729CD78FE8C30;

  if(_id_61152018CC47C0C7 || _id_C2E69D0FD47E7122) {
    if(_id_0D188AEEDCCAFAA3()) {
      thread _id_6925991D5B220A4F(_id_245BF5C3AF6626E8);
      return;
    }
  }

  switch (level._id_A2B890D129C64761._id_8433181924C8E758) {
    case 1:
      thread _id_E3B15FEDC85DC2FF(_id_C45248FDF60A7B9A);
      break;
    case 0:
      break;
  }
}

_id_11366B1211380A98(_id_C45248FDF60A7B9A) {
  if(isDefined(_id_C45248FDF60A7B9A.objid) && _id_C45248FDF60A7B9A.objid != -1) {
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_C45248FDF60A7B9A.objid);
    _id_C45248FDF60A7B9A.objid = undefined;
  }

  if(isDefined(_id_C45248FDF60A7B9A._id_C31012441CC7E210) && _id_C45248FDF60A7B9A._id_C31012441CC7E210 != -1) {
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_C45248FDF60A7B9A._id_C31012441CC7E210);
    _id_C45248FDF60A7B9A._id_C31012441CC7E210 = undefined;
  }

  if(isDefined(_id_C45248FDF60A7B9A._id_AAC94CE6A0278A36) && isDefined(_id_C45248FDF60A7B9A._id_AAC94CE6A0278A36.triggerenterents)) {
    foreach(_id_21280A92D9373B6F in _id_C45248FDF60A7B9A._id_AAC94CE6A0278A36.triggerenterents)
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(_id_C45248FDF60A7B9A._id_75F558A60D4866EA, _id_21280A92D9373B6F);

    scripts\mp\objidpoolmanager::objective_pin_global(_id_C45248FDF60A7B9A._id_75F558A60D4866EA, 0);
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_C45248FDF60A7B9A._id_75F558A60D4866EA);
    _id_C45248FDF60A7B9A._id_75F558A60D4866EA = undefined;
  }
}

_id_9D10DFFE4F6AADD0(_id_C45248FDF60A7B9A) {
  level endon("game_ended");
  _id_C45248FDF60A7B9A waittill("death");
  _id_11366B1211380A98(_id_C45248FDF60A7B9A);

  if(isDefined(_id_C45248FDF60A7B9A._id_AAC94CE6A0278A36))
    _id_C45248FDF60A7B9A._id_AAC94CE6A0278A36 delete();

  if(isDefined(_id_C45248FDF60A7B9A.usable))
    _id_C45248FDF60A7B9A.usable freescriptable();

  if(isDefined(_id_C45248FDF60A7B9A._id_5EB5C5DCCE16FB6D))
    _id_C45248FDF60A7B9A._id_5EB5C5DCCE16FB6D delete();

  if(isDefined(_id_C45248FDF60A7B9A.smokesignal))
    _id_C45248FDF60A7B9A.smokesignal delete();
}

_id_18F5387DF0880206(_id_C45248FDF60A7B9A, _id_F5576FB178AF593E) {
  _id_C45248FDF60A7B9A._id_20CC28D3805BC6DF = min(1.0, _id_F5576FB178AF593E / level._id_A2B890D129C64761.capturetime);

  if(_id_C45248FDF60A7B9A._id_20CC28D3805BC6DF >= level._id_A2B890D129C64761._id_F887A3C6038A17F7)
    _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "capturing_100_percent");
  else if(_id_C45248FDF60A7B9A._id_20CC28D3805BC6DF >= level._id_A2B890D129C64761._id_55BADF39D8C0ADF8)
    _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "capturing_50_percent");

  if(isDefined(_id_C45248FDF60A7B9A._id_75F558A60D4866EA))
    scripts\mp\objidpoolmanager::objective_set_progress(_id_C45248FDF60A7B9A._id_75F558A60D4866EA, _id_C45248FDF60A7B9A._id_20CC28D3805BC6DF);
}

_id_D5A919E5DDFADCE9(ent, _id_AAC94CE6A0278A36) {
  return !isPlayer(ent);
}

_id_0F1799212994B809(ent, _id_AAC94CE6A0278A36) {
  if(isDefined(_id_AAC94CE6A0278A36._id_C45248FDF60A7B9A._id_75F558A60D4866EA)) {
    scripts\mp\objidpoolmanager::objective_pin_player(_id_AAC94CE6A0278A36._id_C45248FDF60A7B9A._id_75F558A60D4866EA, ent);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(_id_AAC94CE6A0278A36._id_C45248FDF60A7B9A._id_75F558A60D4866EA, ent);
    scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(_id_AAC94CE6A0278A36._id_C45248FDF60A7B9A._id_75F558A60D4866EA, ent, 1, 2, &"MP_BR_INGAME/ARMING_SILO");
  }

  _id_C45248FDF60A7B9A = _id_AAC94CE6A0278A36._id_C45248FDF60A7B9A;
  _id_C45248FDF60A7B9A._id_36E74A5C1B872594++;
}

_id_D519B2E3B8AE119B(ent, _id_AAC94CE6A0278A36) {
  if(isDefined(_id_AAC94CE6A0278A36._id_C45248FDF60A7B9A._id_75F558A60D4866EA)) {
    scripts\mp\objidpoolmanager::objective_unpin_player(_id_AAC94CE6A0278A36._id_C45248FDF60A7B9A._id_75F558A60D4866EA, ent, 0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_AAC94CE6A0278A36._id_C45248FDF60A7B9A._id_75F558A60D4866EA, ent);
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(_id_AAC94CE6A0278A36._id_C45248FDF60A7B9A._id_75F558A60D4866EA, ent);
  }

  _id_C45248FDF60A7B9A = _id_AAC94CE6A0278A36._id_C45248FDF60A7B9A;
  _id_C45248FDF60A7B9A._id_36E74A5C1B872594--;
}

_id_50261ABCBBAFDCBC(_id_C45248FDF60A7B9A, _id_0F6DEBAD189A176A, _id_A58A5F1E3BC357F3, _id_7E595E8822A10F41) {
  _id_A8C398C786F5D02F = [];
  _id_FEB47AB3A5A2E77E = [];

  foreach(group in _id_0F6DEBAD189A176A) {
    foreach(_id_1205AB05F7031332 in _id_A58A5F1E3BC357F3[group]) {
      if(_id_7E595E8822A10F41 && !_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(_id_1205AB05F7031332.targetorigin)) {
        continue;
      }
      if(distance2dsquared(_id_1205AB05F7031332.targetorigin, _id_C45248FDF60A7B9A.origin) < 256000000) {
        continue;
      }
      _id_A8C398C786F5D02F[group] = scripts\engine\utility::array_add_safe(_id_A8C398C786F5D02F[group], _id_1205AB05F7031332);
      _id_FEB47AB3A5A2E77E = scripts\engine\utility::_id_6D6AF8144A5131F1(_id_FEB47AB3A5A2E77E, _id_1205AB05F7031332.group);
    }
  }

  return [_id_FEB47AB3A5A2E77E, _id_A8C398C786F5D02F];
}

_id_E3B15FEDC85DC2FF(_id_C45248FDF60A7B9A) {
  _id_0FCC547A018F928B = [];
  _id_A8C398C786F5D02F = [];

  if(level._id_A2B890D129C64761._id_7026908F55D260E9)
    [_id_0FCC547A018F928B, _id_A8C398C786F5D02F] = _id_50261ABCBBAFDCBC(_id_C45248FDF60A7B9A, level._id_A2B890D129C64761._id_6523E7DF766D5380, level._id_A2B890D129C64761._id_A58A5F1E3BC357F3, 1);

  if(!level._id_A2B890D129C64761._id_7026908F55D260E9 || _id_0FCC547A018F928B.size == 0)
    [_id_0FCC547A018F928B, _id_A8C398C786F5D02F] = _id_50261ABCBBAFDCBC(_id_C45248FDF60A7B9A, level._id_A2B890D129C64761._id_6523E7DF766D5380, level._id_A2B890D129C64761._id_A58A5F1E3BC357F3, 0);

  if(_id_0FCC547A018F928B.size > 0) {
    group = scripts\engine\utility::random(_id_0FCC547A018F928B);
    _id_1205AB05F7031332 = scripts\engine\utility::random(_id_A8C398C786F5D02F[group]);
    level._id_A2B890D129C64761._id_6523E7DF766D5380 = scripts\engine\utility::array_remove(level._id_A2B890D129C64761._id_6523E7DF766D5380, group);
    _id_D7C48ECCAE06E020 = scripts\engine\utility::_id_D553466CF817A4DA() * _id_1205AB05F7031332._id_A6DB31654F0937DC;
    _id_7B59B41B01684053 = _id_1205AB05F7031332.targetorigin + _id_D7C48ECCAE06E020;
    thread _id_BDC6DC3258946B3E(_id_C45248FDF60A7B9A, _id_7B59B41B01684053);
  } else
    thread _id_B278C12CFD15747C(_id_C45248FDF60A7B9A);
}

_id_B278C12CFD15747C(_id_C45248FDF60A7B9A) {
  _id_C9D3A177DA21FCD7 = _id_8EDA9E36458AB3FE(_id_C45248FDF60A7B9A.origin, _id_C45248FDF60A7B9A._id_245BF5C3AF6626E8, (0, 0, 0), 0);
  _id_CEBBC0D4BB1408DE(_id_C45248FDF60A7B9A, _id_C9D3A177DA21FCD7);
}

_id_BDC6DC3258946B3E(_id_C45248FDF60A7B9A, targetorigin) {
  _id_C9D3A177DA21FCD7 = _id_8EDA9E36458AB3FE(_id_C45248FDF60A7B9A.origin, _id_C45248FDF60A7B9A._id_245BF5C3AF6626E8, targetorigin);
  _id_CEBBC0D4BB1408DE(_id_C45248FDF60A7B9A, _id_C9D3A177DA21FCD7);
}

_id_9A905AD5676B211D(_id_C45248FDF60A7B9A, _id_5EB5C5DCCE16FB6D) {
  level endon("game_ended");
  _id_5EB5C5DCCE16FB6D endon("death");
  _id_C45248FDF60A7B9A endon("death");

  for(;;) {
    wait 0.1;
    _id_5EB5C5DCCE16FB6D.origin = _id_C45248FDF60A7B9A gettagorigin("j_military_launcher");
    angles = _id_C45248FDF60A7B9A gettagangles("j_military_launcher_taget");
    _id_5EB5C5DCCE16FB6D.angles = (angles[0] + (0, 0, 20)[0], angles[1] + (0, 0, 20)[1], angles[2] + (0, 0, 20)[2]);
  }
}

_id_D00249BE2439640C() {
  if(level._id_A2B890D129C64761._id_AB8392FD7E88DFD6 > 0 && isDefined(level.br_circle) && isDefined(level.br_circle.circleindex))
    return level.br_circle.circleindex < level._id_A2B890D129C64761._id_AB8392FD7E88DFD6;

  return 1;
}

_id_293AA3733711ADE6() {
  _id_A95A0F321427A749 = level._id_A2B890D129C64761._id_C4F0A71B3DFAC5A1._id_B012D72D07F635D5;
  _id_EC8AD76722A4A14A = level._id_A2B890D129C64761._id_C4F0A71B3DFAC5A1._id_2C13CBD06F75F0EB;
  _id_6E56644C5FE6BEED = level._id_A2B890D129C64761._id_C4F0A71B3DFAC5A1._id_6E56644C5FE6BEED;
  _id_7408ED52662703D3 = 0;

  if(_id_6E56644C5FE6BEED == 0)
    return 0;

  _id_D7D61DAA027E8EAD = scripts\common\utility::_id_76D9F2B9AC5F8307(_id_A95A0F321427A749);
  entities = _func_366BF1E08B0BEC30(_id_A95A0F321427A749, _id_D7D61DAA027E8EAD);

  foreach(ent in entities) {
    if(isPlayer(ent)) {
      _id_7408ED52662703D3++;

      if(_id_7408ED52662703D3 > _id_6E56644C5FE6BEED)
        return 1;
    }
  }

  return 0;
}

_id_0D188AEEDCCAFAA3() {
  if(!level._id_A2B890D129C64761._id_AE723326800F7186)
    return 0;

  if(level._id_A2B890D129C64761._id_BA657D0956DD724B)
    return 0;

  if(level._id_A2B890D129C64761._id_C4F0A71B3DFAC5A1._id_B012D72D07F635D5 == "")
    return 0;

  if(getdvarint("dvar_2BE93DD484220A45", 0) == 0) {
    if(_id_293AA3733711ADE6())
      return 0;

    if(!_id_BD876E8E730B6B13())
      return 0;

    if(!_id_D00249BE2439640C())
      return 0;
  }

  return 1;
}

_id_BD876E8E730B6B13() {
  if(level._id_A2B890D129C64761._id_E5D20DAC7C4B5F77 != 0.0 && level._id_A2B890D129C64761._id_E5D20DAC7C4B5F77 < 1.0) {
    if(level._id_A2B890D129C64761._id_C4C835414F3BD6FA > level._id_A2B890D129C64761._id_E5D20DAC7C4B5F77)
      return 0;
  }

  return 1;
}

_id_6925991D5B220A4F(_id_21280A92D9373B6F) {
  _id_C4F0A71B3DFAC5A1 = level._id_A2B890D129C64761._id_C4F0A71B3DFAC5A1;
  level._id_863221A01F7A8258 = 1;
  level._id_A2B890D129C64761._id_BA657D0956DD724B = 1;

  if(!getdvarint("dvar_2BE93DD484220A45", 0)) {
    if(isDefined(_id_21280A92D9373B6F))
      _id_21280A92D9373B6F scripts\mp\hud_message::showsplash("br_s5_reveal_observatory_attack_initiated");
  }

  foreach(_id_C45248FDF60A7B9A in level._id_A2B890D129C64761._id_DE0C0A02B71959F5)
  thread _id_DBE60E54B97480EB(_id_C45248FDF60A7B9A, undefined, 1);

  _id_4C33DA9F545BD9B2 = 0;

  while(!_id_4C33DA9F545BD9B2) {
    waitframe();
    _id_4C33DA9F545BD9B2 = 1;

    foreach(_id_C45248FDF60A7B9A in level._id_A2B890D129C64761._id_DE0C0A02B71959F5) {
      if(_id_C45248FDF60A7B9A.state != "ready") {
        _id_4C33DA9F545BD9B2 = 0;
        break;
      }
    }
  }

  if(level._id_A2B890D129C64761._id_782E38B4F2AC96EA) {
    setmusicstate("mx_jup_rvl_launch_sequence");

    if(istrue(level._id_291B51C7AF8D1204))
      thread _id_558E317F6FB659D8();
  }

  if(!getdvarint("dvar_2BE93DD484220A45", 0))
    scripts\mp\hud_util::showsplashtoall("br_s5_reveal_observatory_missile_strike");

  scripts\engine\utility::script_func("missile_silos_ready_to_fire");

  foreach(_id_C45248FDF60A7B9A in level._id_A2B890D129C64761._id_DE0C0A02B71959F5) {
    _id_81E7EE4D98262708 = randomfloat(_id_C4F0A71B3DFAC5A1._id_E34B27B3C09E46F6);
    thread _id_0C5384399B152A48(_id_C45248FDF60A7B9A, _id_C4F0A71B3DFAC5A1.targetorigin, _id_81E7EE4D98262708);
  }

  level thread scripts\common\utility::_id_195990D8AFFBA85B(level._id_A2B890D129C64761._id_C4F0A71B3DFAC5A1._id_B012D72D07F635D5, level._id_A2B890D129C64761._id_C4F0A71B3DFAC5A1._id_2C13CBD06F75F0EB, level._id_A2B890D129C64761._id_C4F0A71B3DFAC5A1._id_2603BE52BF02F3D9);
  wait 16.75;

  foreach(player in level.players)
  player thread _id_1E797C3B699FC853();

  if(level._id_A2B890D129C64761._id_3CB86E5589BC18C5) {
    wait 7.5;
    thread scripts\mp\hud_util::showsplashtoall(_id_C4F0A71B3DFAC5A1._id_43076B08E8B2E81A);
    wait 3.0;
    _id_B1AC6F4AAF828994 = _id_90BEB4A379C452CC(_id_C4F0A71B3DFAC5A1._id_DBFDA454AF269213, _id_C4F0A71B3DFAC5A1._id_8C250069F8D238EC);
    _id_2CEDCC356F1B9FC8::brleaderdialog("missile_silo_bunker_revealed", 1, undefined, 0, 0, undefined, "");
    wait 20.0;
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_B1AC6F4AAF828994);
  }
}

_id_558E317F6FB659D8() {
  wait 120;
  setmusicstate("mx_jup_rvl_canister_run");
}

_id_1E797C3B699FC853() {
  self endon("disconnect");
  _id_CA16950260700BDD = (-1500, -15000, 0);
  _id_D0EB1456103AB1E3 = distance2d(self.origin, _id_CA16950260700BDD);
  _id_74B5B12BB6514385 = _id_D0EB1456103AB1E3 / 13798.4;
  wait(_id_74B5B12BB6514385);
  self earthquakeforplayer(0.2, 5.5, self.origin, 300);
  wait 5.5;
  self earthquakeforplayer(0.1, 5.0, self.origin, 300);
}

_id_8EDA9E36458AB3FE(_id_B979F793DCCB4061, player, targetorigin, _id_942A5DFA25BB1B34) {
  _id_5628337C93D98639 = 1;
  _id_75DC36B697351600 = 1000;
  _id_D4044BCCDCF46B61 = scripts\engine\trace::create_default_contents(_id_5628337C93D98639);
  _id_0DB1541018D7BADF = scripts\engine\trace::ray_trace(targetorigin + (0, 0, _id_75DC36B697351600), targetorigin - (0, 0, _id_75DC36B697351600), undefined, _id_D4044BCCDCF46B61);
  _id_B7ED55D0AAC423A9 = targetorigin;

  if(_id_0DB1541018D7BADF["hittype"] != "hittype_none")
    _id_B7ED55D0AAC423A9 = _id_0DB1541018D7BADF["position"];

  _id_A33944C0AFD39F27 = _func_767CEA82B001F645(_id_B979F793DCCB4061 - _id_B7ED55D0AAC423A9);
  _id_D2F5DF879F022A64 = level._id_A2B890D129C64761._id_92D9B21FF53EBA08;
  _id_F4AC4A1F6A212A7B = (_id_B7ED55D0AAC423A9[0], _id_B7ED55D0AAC423A9[1], _id_D2F5DF879F022A64);
  _id_C9D3A177DA21FCD7 = spawnStruct();
  _id_C9D3A177DA21FCD7.player = player;
  _id_C9D3A177DA21FCD7.targetorigin = _id_B7ED55D0AAC423A9;
  _id_C9D3A177DA21FCD7._id_F4AC4A1F6A212A7B = _id_F4AC4A1F6A212A7B + _id_A33944C0AFD39F27 * level._id_A2B890D129C64761._id_85B9A46B341F8A88;
  _id_C9D3A177DA21FCD7._id_CADF17FF70B1047A = vectorlerp(_id_C9D3A177DA21FCD7._id_F4AC4A1F6A212A7B, _id_C9D3A177DA21FCD7.targetorigin, level._id_A2B890D129C64761._id_03B043818A571222);
  _id_C9D3A177DA21FCD7._id_AF320C9002F8A5AC = scripts\engine\utility::_id_53C4C53197386572(_id_942A5DFA25BB1B34, 1);
  return _id_C9D3A177DA21FCD7;
}

_id_CEBBC0D4BB1408DE(_id_C45248FDF60A7B9A, _id_C9D3A177DA21FCD7) {
  _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "firing");
  scripts\mp\hud_util::showsplashtoall("br_s5_reveal_missile_launching");
  marker = _id_E55AF4FF9B981CB6(_id_C9D3A177DA21FCD7);
  thread _id_14249EEC955C8409(_id_C9D3A177DA21FCD7, marker);
  thread _id_DA002F2B24B50FA6(_id_C45248FDF60A7B9A);
  earthquake(0.12, 3.0, _id_C45248FDF60A7B9A.origin, 400);
  _id_5FE5A5DD5176F2ED = _id_C641D94D6C38CA79(_id_C45248FDF60A7B9A, _id_C9D3A177DA21FCD7.targetorigin);
  _id_5FE5A5DD5176F2ED setscriptablepartstate("missile", "firing");
  wait(level._id_A2B890D129C64761._id_D3662B3C655BA592);
  _id_5FE5A5DD5176F2ED delete();
  missile = _id_D7624E4CBDA6BF94(_id_C9D3A177DA21FCD7._id_F4AC4A1F6A212A7B, _id_C9D3A177DA21FCD7.player);
  _id_6A6582634164E845 = _id_C6621FAC8DF7A66A(_id_C9D3A177DA21FCD7._id_F4AC4A1F6A212A7B);
  missile linkTo(_id_6A6582634164E845, "tag_origin");

  if(_id_C9D3A177DA21FCD7._id_AF320C9002F8A5AC) {
    _id_3D6309782EA7B4AD(_id_6A6582634164E845, _id_C9D3A177DA21FCD7);
    thread _id_17F36775AE896F62(_id_C9D3A177DA21FCD7.player, missile._id_410D75D1C571E537);
    thread _id_BA04BC1A0FCD3C12(missile, _id_C9D3A177DA21FCD7);
    thread _id_B9D5214DEDB21320(missile, _id_6A6582634164E845);
  } else {
    missile delete();
    _id_6A6582634164E845 delete();
  }

  thread _id_A7205FCACA7AADDD(_id_C45248FDF60A7B9A, _id_C9D3A177DA21FCD7, missile._id_410D75D1C571E537);
  wait 1.0;
  _id_BC70E115645C09B5(marker);
  _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "ready");
}

_id_0C5384399B152A48(_id_C45248FDF60A7B9A, _id_F2FB88A3936F823E, _id_81E7EE4D98262708) {
  wait(_id_81E7EE4D98262708);
  _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "firing_coordinated_attack");
  thread _id_DA002F2B24B50FA6(_id_C45248FDF60A7B9A);
  earthquake(0.12, 3.0, _id_C45248FDF60A7B9A.origin, 400);
  _id_5FE5A5DD5176F2ED = _id_C641D94D6C38CA79(_id_C45248FDF60A7B9A, _id_F2FB88A3936F823E);
  _id_5FE5A5DD5176F2ED setscriptablepartstate("missile", "firing_coordinated_attack");
  wait 10.0;
  _id_A8380084DC709AEF(_id_C45248FDF60A7B9A, "ready");
  _id_5FE5A5DD5176F2ED delete();
}

_id_14249EEC955C8409(_id_C9D3A177DA21FCD7, marker) {
  wait(level._id_A2B890D129C64761._id_F267F88C658A4472);
  scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(_id_C9D3A177DA21FCD7.player, _id_C9D3A177DA21FCD7.player.team, level._id_A2B890D129C64761._id_13AECE9B7DC02671, "missile_silo", _id_C9D3A177DA21FCD7.targetorigin);

  if(isDefined(marker))
    marker scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
}

_id_DA002F2B24B50FA6(_id_C45248FDF60A7B9A) {
  wait 1.5;
  origin = _func_4AD9053267734CF2((0, 205, 365), _id_C45248FDF60A7B9A.origin, _id_C45248FDF60A7B9A.angles);
  players = scripts\mp\utility\player::getplayersinradius(origin, 50);

  if(isDefined(players)) {
    foreach(player in players) {
      if(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive())
        player scripts\mp\utility\damage::_suicide(undefined, 1);
    }
  }
}

_id_17F36775AE896F62(player, _id_410D75D1C571E537) {
  if(!isDefined(player)) {
    return;
  }
  level endon("game_ended");
  player endon("disconnect");
  _id_410D75D1C571E537._id_8ABA3809EFED9EED = scripts\engine\utility::_id_53C4C53197386572(_id_410D75D1C571E537._id_8ABA3809EFED9EED, 0);
  _id_410D75D1C571E537._id_2B00EAA34070C8F7 = scripts\engine\utility::_id_53C4C53197386572(_id_410D75D1C571E537._id_2B00EAA34070C8F7, 0);
  childthread _id_93C30D67ED98A2ED(player, _id_410D75D1C571E537);
  childthread _id_78DD80291A3DB4F7(player, _id_410D75D1C571E537);
  wait 5;
  _id_410D75D1C571E537 notify("stop_tracking");

  if(isDefined(player)) {
    _id_C144FC65EE31418C = _id_410D75D1C571E537._id_8ABA3809EFED9EED > 0 || _id_410D75D1C571E537._id_2B00EAA34070C8F7 > 0;
    dialog = scripts\engine\utility::ter_op(_id_C144FC65EE31418C, "missile_silo_hit", "missile_silo_miss");
    _id_2CEDCC356F1B9FC8::brleaderdialog(dialog, 1, [player], 0, 0, undefined, "");
  }
}

_id_93C30D67ED98A2ED(player, _id_410D75D1C571E537) {
  _id_410D75D1C571E537 endon("stop_tracking");

  while(isDefined(player)) {
    player waittill("update_rapid_kill_buffered", recentkillcount, _id_C094DB262CE4DFA0);

    if(isDefined(_id_C094DB262CE4DFA0) && (_id_C094DB262CE4DFA0 == "missile_silo_cluster_missile_proj" || _id_C094DB262CE4DFA0 == "missile_silo_missile_proj"))
      _id_410D75D1C571E537._id_8ABA3809EFED9EED++;
  }
}

_id_78DD80291A3DB4F7(player, _id_410D75D1C571E537) {
  _id_410D75D1C571E537 endon("stop_tracking");

  while(isDefined(player)) {
    player waittill("update_rapid_agent_kill_buffered", recentkillcount, _id_C094DB262CE4DFA0);

    if(isDefined(_id_C094DB262CE4DFA0) && (_id_C094DB262CE4DFA0 == "missile_silo_cluster_missile_proj" || _id_C094DB262CE4DFA0 == "missile_silo_missile_proj"))
      _id_410D75D1C571E537._id_2B00EAA34070C8F7++;
  }
}

_id_E7E992C39008E087(_id_B979F793DCCB4061, _id_B22687643226C3C1) {
  _id_9523E27B0F4FE3AF = _id_B22687643226C3C1 - _id_B979F793DCCB4061;
  right = (0, 1, 0);
  _id_801D37E9149BBC7C = vectorNormalize(_id_9523E27B0F4FE3AF);
  _id_B570F920AD69649A = vectorNormalize(vectorcross(right, _id_801D37E9149BBC7C));
  _id_104F0F7EB194F37B = vectorNormalize(vectorcross(_id_801D37E9149BBC7C, _id_B570F920AD69649A));
  return axistoangles(_id_104F0F7EB194F37B, _id_B570F920AD69649A, _id_801D37E9149BBC7C);
}

_id_3D6309782EA7B4AD(_id_6A6582634164E845, _id_C9D3A177DA21FCD7) {
  _id_6A6582634164E845.origin = _id_C9D3A177DA21FCD7._id_F4AC4A1F6A212A7B;
  _id_6A6582634164E845.angles = _id_E7E992C39008E087(_id_C9D3A177DA21FCD7._id_F4AC4A1F6A212A7B, _id_C9D3A177DA21FCD7._id_CADF17FF70B1047A);
  _id_6A6582634164E845 moveTo(_id_C9D3A177DA21FCD7._id_CADF17FF70B1047A, level._id_A2B890D129C64761._id_E1920D31E93302AC, 0, 0);
  wait(level._id_A2B890D129C64761._id_E1920D31E93302AC);
}

_id_BA04BC1A0FCD3C12(missile, _id_C9D3A177DA21FCD7) {
  _id_B979F793DCCB4061 = missile.origin;

  for(_id_CD64997EB367F635 = 0; _id_CD64997EB367F635 < level._id_A2B890D129C64761._id_BE698ADC7F8793C1; _id_CD64997EB367F635++) {
    targetorigin = _id_C9D3A177DA21FCD7.targetorigin + scripts\engine\utility::_id_D553466CF817A4DA() * level._id_A2B890D129C64761._id_6B5164DC23169A95;
    initialvelocity = vectorNormalize(targetorigin - _id_B979F793DCCB4061) * level._id_A2B890D129C64761._id_CABF633EBF5787E8;
    spawnorigin = _id_B979F793DCCB4061 + scripts\engine\utility::randomonunitsphere() * level._id_A2B890D129C64761._id_83CBC452240B923D;
    _id_ADE237F13FD2E52F = _id_11DEC6FD87C08A42(spawnorigin, initialvelocity, _id_C9D3A177DA21FCD7.player);
    _id_ADE237F13FD2E52F setscriptablepartstate("trail", "active");
    thread _id_574FAF5736598585(_id_ADE237F13FD2E52F);
    waitframe();
  }
}

_id_B9D5214DEDB21320(missile, _id_6A6582634164E845) {
  missile setscriptablepartstate("explode", "active");
  wait 2;
  missile delete();
  _id_6A6582634164E845 delete();
}

_id_574FAF5736598585(_id_ADE237F13FD2E52F) {
  impactinfo = _id_ADE237F13FD2E52F scripts\cp_mp\killstreaks\cruise_predator::cruisepredator_waittillexplode("missile_stuck", "missile_water_impact");
  _id_ADE237F13FD2E52F setscriptablepartstate("explode", "active", 1);
  earthquake(0.35, 1.3, _id_ADE237F13FD2E52F.origin, 1000);
  wait 5;
  _id_ADE237F13FD2E52F delete();
}

_id_82A701DE8D58907C(_id_C45248FDF60A7B9A) {
  wait 7;
  _id_C45248FDF60A7B9A stoploopsound("iw9_jup_rvl_missle_alarm");
  playsoundatpos(_id_C45248FDF60A7B9A.origin + (0, 200, 370), "iw9_jup_reveal_missile_silo_lift_lock_end_02");
}

_id_627B388E1CD025AC(objid) {
  foreach(player in level.players) {
    if(isDefined(player))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
  }
}

_id_A7205FCACA7AADDD(_id_A6487FB1572C9B44, _id_C9D3A177DA21FCD7, _id_410D75D1C571E537) {
  if(_id_C9D3A177DA21FCD7._id_AF320C9002F8A5AC)
    _id_410D75D1C571E537 waittill("stop_tracking");

  _id_FF9C293B18A77B86(_id_A6487FB1572C9B44, _id_C9D3A177DA21FCD7.targetorigin, _id_410D75D1C571E537._id_8ABA3809EFED9EED, _id_410D75D1C571E537._id_2B00EAA34070C8F7);
}

_id_FF9C293B18A77B86(_id_A6487FB1572C9B44, targetorigin, _id_8ABA3809EFED9EED, _id_2B00EAA34070C8F7) {
  if(!getdvarint("dvar_2BE93DD484220A45", 0) && _id_715028F54BAD19A1::branalytics_validation()) {
    _id_BB375C218F327301 = 0;

    if(isDefined(_id_A6487FB1572C9B44._id_245BF5C3AF6626E8))
      _id_BB375C218F327301 = _id_A6487FB1572C9B44._id_245BF5C3AF6626E8 _meth_7A32B0201993D7F7();

    _id_EC6A81EAC0E4DC61 = [];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "match_time";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = scripts\mp\utility\game::gettimepassed();
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "launch_origin_x";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_A6487FB1572C9B44.origin[0];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "launch_origin_y";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_A6487FB1572C9B44.origin[1];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "launch_origin_z";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_A6487FB1572C9B44.origin[2];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "launch_target_x";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = targetorigin[0];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "launch_target_y";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = targetorigin[1];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "launch_target_z";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = targetorigin[2];
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_player_kills";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_8ABA3809EFED9EED;
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_agent_kills";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_2B00EAA34070C8F7;
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "capture_player_unoid";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_BB375C218F327301;
    dlog_recordevent("dlog_event_missile_silo_launched", _id_EC6A81EAC0E4DC61);
  }
}