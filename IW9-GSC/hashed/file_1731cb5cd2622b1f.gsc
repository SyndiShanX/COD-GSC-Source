/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1731cb5cd2622b1f.gsc
***********************************************/

_id_94129D143415DD0E() {
  _id_4F068020AAD821EE = [];
  _id_4F068020AAD821EE["hunk_36C02722"] = ::_id_FFD597749E0E494C;
  _id_4F068020AAD821EE["hunk_39C1C991"] = ::_id_7F8D043CEFBDD1D7;
  _id_4F068020AAD821EE["hunk_C099F700"] = ::_id_A4C4ACAE0D28E986;
  _id_4F068020AAD821EE["hunk_6D8D1645"] = ::_id_8849C8F548F10BE7;
  _id_4F068020AAD821EE["hunk_3D7832F3"] = ::_id_87CFDAAD6CACA78E;
  _id_4F068020AAD821EE["hunk_44A4E2C8"] = ::_id_612769A4F650D5CA;
  _id_4F068020AAD821EE["hunk_11272493"] = ::_id_D56A44D325986C31;
  _id_4F068020AAD821EE["hunk_1920E002"] = ::_id_C89EC56F302E0B90;
  _id_4F068020AAD821EE["hunk_CD6183D2"] = ::_id_FEE0705A59559898;
  return _id_4F068020AAD821EE;
}

_id_FFD597749E0E494C(_id_B92F1CF567538EEE) {
  _id_B92F1CF567538EEE._id_B6AC580A2F02C7EB = (17680, 14430, 235);
  _id_B92F1CF567538EEE._id_562A413B88E3F653 = 24000;
}

_id_7F8D043CEFBDD1D7(_id_B92F1CF567538EEE) {
  _id_B92F1CF567538EEE.spawnpoint = _id_376C76DF4DA58945::_id_E8198B70AD5427EE("spawnpoint_5", "script_noteworthy");
  _id_B92F1CF567538EEE._id_9F3256AA0DB81EA4 = _id_B92F1CF567538EEE.spawnpoint.origin;
  _id_B92F1CF567538EEE.triggerdistance = 300;
  _id_B92F1CF567538EEE.destructible = _id_376C76DF4DA58945::_id_405B1D325FB9651F("mgl_quests_destructible", _id_B92F1CF567538EEE.spawnpoint);
  _id_B92F1CF567538EEE._id_17CB81B625BD3D4B = "destructible_damage";
}

_id_A4C4ACAE0D28E986(_id_B92F1CF567538EEE) {
  _id_B92F1CF567538EEE.spawnpoints = [];
  _id_B92F1CF567538EEE.spawnpoints[0] = _id_376C76DF4DA58945::_id_E8198B70AD5427EE("spawnpoint_1", "script_noteworthy");
  _id_B92F1CF567538EEE.spawnpoints[1] = _id_376C76DF4DA58945::_id_E8198B70AD5427EE("spawnpoint_2", "script_noteworthy");
  _id_B92F1CF567538EEE.spawnpoints[2] = _id_376C76DF4DA58945::_id_E8198B70AD5427EE("spawnpoint_3", "script_noteworthy");
  _id_B92F1CF567538EEE.spawnpoints[3] = _id_376C76DF4DA58945::_id_E8198B70AD5427EE("spawnpoint_4", "script_noteworthy");
  _id_B92F1CF567538EEE._id_9F3256AA0DB81EA4 = _id_B92F1CF567538EEE.spawnpoints[0].origin;
  _id_B92F1CF567538EEE.triggerdistance = 300;
  _id_B92F1CF567538EEE.interactables = [];
  _id_B92F1CF567538EEE.interactables[0] = _id_376C76DF4DA58945::_id_405B1D325FB9651F("mgl_quests_interactable_laptop_sequence", _id_B92F1CF567538EEE.spawnpoints[0]);
  _id_B92F1CF567538EEE.interactables[1] = _id_376C76DF4DA58945::_id_405B1D325FB9651F("mgl_quests_interactable_laptop_sequence", _id_B92F1CF567538EEE.spawnpoints[1]);
  _id_B92F1CF567538EEE.interactables[2] = _id_376C76DF4DA58945::_id_405B1D325FB9651F("mgl_quests_interactable_laptop_sequence", _id_B92F1CF567538EEE.spawnpoints[2]);
  _id_B92F1CF567538EEE.interactables[3] = _id_376C76DF4DA58945::_id_405B1D325FB9651F("mgl_quests_interactable_laptop_sequence", _id_B92F1CF567538EEE.spawnpoints[3]);
  _id_B92F1CF567538EEE.interactables[0].id = 0;
  _id_B92F1CF567538EEE.interactables[1].id = 1;
  _id_B92F1CF567538EEE.interactables[2].id = 2;
  _id_B92F1CF567538EEE.interactables[3].id = 3;
  _id_B92F1CF567538EEE._id_41075454B4246266 = "laptop_interaction";
  _id_B92F1CF567538EEE._id_96A94E85167224F5 = "open";
  _id_B92F1CF567538EEE._id_CBAFD5721CE50853 = "closed";
  _id_B92F1CF567538EEE._id_EC174465928B5A3E = 0.5;
  _id_B92F1CF567538EEE._id_94C9CF0D668973F0 = [3, 2, 0, 1];
}

_id_8849C8F548F10BE7(_id_B92F1CF567538EEE) {
  _id_B92F1CF567538EEE._id_4B4B03CC9E68B30A = "mgl_snowman_large";
  _id_B92F1CF567538EEE._id_6F0D08C8A9F06AB5 = 5;
  _id_B92F1CF567538EEE._id_1F7F5E3DB4B22AC8 = 20;
  _id_B92F1CF567538EEE._id_C4434A60A73730B7 = [];
  _id_B92F1CF567538EEE._id_4BA72F218EB934E0 = 1;
  _id_B92F1CF567538EEE._id_17CB81B625BD3D4B = "snowman_damage";
  _id_B92F1CF567538EEE.spawnpoints = _id_376C76DF4DA58945::_id_240FEC50BE236D8D("spawnpoint_group_c", "script_noteworthy");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B92F1CF567538EEE._id_6F0D08C8A9F06AB5; _id_AC0E594AC96AA3A8++) {
    spawnpoint = _id_376C76DF4DA58945::_id_B78E051D9B9BBCFB(_id_B92F1CF567538EEE.spawnpoints);

    if(isDefined(spawnpoint)) {
      scriptable = _id_376C76DF4DA58945::_id_405B1D325FB9651F(_id_B92F1CF567538EEE._id_4B4B03CC9E68B30A, spawnpoint);
      _id_B92F1CF567538EEE._id_C4434A60A73730B7 = scripts\engine\utility::array_add(_id_B92F1CF567538EEE._id_C4434A60A73730B7, scriptable);
    }
  }

  if(_id_B92F1CF567538EEE._id_4BA72F218EB934E0)
    level thread _id_376C76DF4DA58945::_id_36925DBC82D6E653(_id_B92F1CF567538EEE);
}

_id_87CFDAAD6CACA78E(_id_B92F1CF567538EEE) {
  _id_B92F1CF567538EEE._id_1F7F5E3DB4B22AC8 = 10;
  _id_B92F1CF567538EEE._id_17CB81B625BD3D4B = "snowman_damage";
  _id_B92F1CF567538EEE._id_7C3011400034B78E = _id_376C76DF4DA58945::_id_F019B80AB8A07366(undefined, 500);
}

_id_612769A4F650D5CA(_id_B92F1CF567538EEE) {
  _id_7DB6235A7408E42F = [];
  _id_7DB6235A7408E42F = scripts\engine\utility::array_add(_id_7DB6235A7408E42F, [(17659, 16099, 1000)]);
  _id_7DB6235A7408E42F = scripts\engine\utility::array_add(_id_7DB6235A7408E42F, [(15833, 15118, 1000)]);
  _id_7DB6235A7408E42F = scripts\engine\utility::array_add(_id_7DB6235A7408E42F, [(15990, 17024, 800)]);
  _id_7DB6235A7408E42F = scripts\engine\utility::array_add(_id_7DB6235A7408E42F, [(17228, 17785, 900)]);
  _id_7DB6235A7408E42F = scripts\engine\utility::array_add(_id_7DB6235A7408E42F, [(18820, 18592, 1000)]);
  _id_7DB6235A7408E42F = scripts\engine\utility::array_add(_id_7DB6235A7408E42F, [(17659, 16099, 1000)]);
  _id_E7FADCC93B1F0B3D = [];

  for(index = 0; index < _id_7DB6235A7408E42F.size; index++) {
    _id_E7FADCC93B1F0B3D[index] = spawnStruct();
    _id_E7FADCC93B1F0B3D[index].origin = _id_7DB6235A7408E42F[index][0];
  }

  _id_B92F1CF567538EEE._id_E7FADCC93B1F0B3D = _id_E7FADCC93B1F0B3D;
  _id_B92F1CF567538EEE._id_809E5E54C4FD7BA6 = 500;
  _id_B92F1CF567538EEE._id_8BABBBA04884CE61 = 8.0;
  _id_B92F1CF567538EEE._id_17CB81B625BD3D4B = "snowman_damage";
  _id_B92F1CF567538EEE.destructible = spawnscriptable("mgl_quests_drone", (17659, 16099, 298), (0, 230, 0));
  thread _id_376C76DF4DA58945::_id_EE6AF2593B3F4F9F(_id_B92F1CF567538EEE.destructible, _id_B92F1CF567538EEE._id_809E5E54C4FD7BA6, _id_B92F1CF567538EEE._id_E7FADCC93B1F0B3D, _id_B92F1CF567538EEE._id_8BABBBA04884CE61);
}

_id_D56A44D325986C31(_id_B92F1CF567538EEE) {
  _id_612769A4F650D5CA(_id_B92F1CF567538EEE);
  _id_B92F1CF567538EEE._id_5C5B88CE7AE1228E = _id_B92F1CF567538EEE.destructible;
  _id_B92F1CF567538EEE.radius = 5000;
  _id_B92F1CF567538EEE._id_5888FE9DAC2D7D8E = 3000;
  _id_B92F1CF567538EEE._id_047D36EE50AD4738 = 3;
  _id_B92F1CF567538EEE._id_9F3256AA0DB81EA4 = _id_B92F1CF567538EEE.destructible.origin;
  _id_B92F1CF567538EEE.triggerdistance = 100;
  _id_B92F1CF567538EEE._id_0B2AA37A799B9FA7 = 60000;
}

_id_C89EC56F302E0B90(_id_B92F1CF567538EEE) {
  _id_B92F1CF567538EEE._id_4B4B03CC9E68B30A = "mgl_quests_destructible_meteor";
  _id_B92F1CF567538EEE._id_17CB81B625BD3D4B = "meteor_damage";
  _id_B92F1CF567538EEE._id_1F7F5E3DB4B22AC8 = 5;
  _id_EE90F5C1F0321D0E = _id_376C76DF4DA58945::_id_E8198B70AD5427EE("spawnpoint_b1", "script_noteworthy");
  _id_376C76DF4DA58945::_id_405B1D325FB9651F("mgl_quests_interactable_button", _id_EE90F5C1F0321D0E);
  _id_4DA48B81C75820B1 = "button_interaction";
  _id_B92F1CF567538EEE.spawnpoint = _id_376C76DF4DA58945::_id_E8198B70AD5427EE("spawnpoint_d1", "script_noteworthy");
  thread _id_376C76DF4DA58945::_id_1E00432625D13A4E(_id_4DA48B81C75820B1, _id_376C76DF4DA58945::_id_69DF5E0C6C8EB388, _id_B92F1CF567538EEE._id_4B4B03CC9E68B30A, _id_B92F1CF567538EEE.spawnpoint.origin, 400);
}

_id_FEE0705A59559898(_id_B92F1CF567538EEE) {
  if(level.br_infils_disabled) {
    return;
  }
  _id_B92F1CF567538EEE._id_CF9946A2B5867288 = "veh9_mil_air_ufo_small";
  _id_B92F1CF567538EEE._id_87A4F533A559BEF3 = "vfx_quests_spaceship_explosion";
  _id_B92F1CF567538EEE._id_6B0ED600522A41C8 = "vfx_quests_spaceship_smoke";
  _id_B92F1CF567538EEE._id_43EF94BB02928D59 = "vfx_quests_spaceship_explosion";
  _id_B92F1CF567538EEE._id_62EB54694D73E7F5 = "vfx_quests_spaceship_linger";

  switch (2) {
    case 1:
      thread _id_56BF21591EB4504D(_id_B92F1CF567538EEE);
      break;
    case 2:
      thread _id_E9DF5FE0473A6F22(_id_B92F1CF567538EEE);
      break;
  }
}

_id_56BF21591EB4504D(_id_B92F1CF567538EEE) {
  level waittill("infils_ready");
  wait 2;
  _id_B92F1CF567538EEE._id_A8B1CC7DB86436F8 = level.infilstruct.c130pathstruct.startpt;
  _id_B92F1CF567538EEE._id_1329177FFF6E9779 = level.infilstruct.c130pathstruct.endpt;
  _id_B92F1CF567538EEE._id_C0619D5E95F2F93E = vectorNormalize(_id_B92F1CF567538EEE._id_1329177FFF6E9779 - _id_B92F1CF567538EEE._id_A8B1CC7DB86436F8);
  _id_B92F1CF567538EEE._id_0D49778F53699B36 = distance2d(_id_B92F1CF567538EEE._id_A8B1CC7DB86436F8, level.br_circle.safecircleent.origin) * 2;
  _id_B92F1CF567538EEE._id_4EEFB0BF29A11004 = _id_45B2B4A889E633FA::getc130speed();
  _id_B92F1CF567538EEE._id_9011E2780F5C124B = spawn("script_model", _id_B92F1CF567538EEE._id_A8B1CC7DB86436F8 + (0, 0, 2000));
  waitframe();
  _id_B92F1CF567538EEE._id_9011E2780F5C124B setModel(_id_B92F1CF567538EEE._id_CF9946A2B5867288);
  _id_B92F1CF567538EEE._id_9011E2780F5C124B.angles = vectortoangles(_id_B92F1CF567538EEE._id_C0619D5E95F2F93E);
  _id_B92F1CF567538EEE._id_FB936CA0C0B59368 = 5;
  _id_B92F1CF567538EEE._id_8E15C5F8EF27AFFC = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B92F1CF567538EEE._id_FB936CA0C0B59368; _id_AC0E594AC96AA3A8++) {
    _id_9011E2780F5C124B = spawn("script_model", _id_B92F1CF567538EEE._id_A8B1CC7DB86436F8 + (randomfloatrange(-4000, 4000), randomfloatrange(-4000, 4000), randomfloatrange(700, 2500)));
    _id_9011E2780F5C124B setModel(_id_B92F1CF567538EEE._id_CF9946A2B5867288);
    _id_B92F1CF567538EEE._id_8E15C5F8EF27AFFC[_id_AC0E594AC96AA3A8] = _id_9011E2780F5C124B;
  }

  _id_B92F1CF567538EEE._id_85E1D048E879C6F6 = 20000;
  _id_B92F1CF567538EEE._id_D0EA399E12ACB44E = level.br_ac130.origin + vectorNormalize(scripts\engine\utility::randomvectorrange(1, 2)) * 600 + _id_B92F1CF567538EEE._id_C0619D5E95F2F93E * 5000;
  _id_B92F1CF567538EEE._id_95589E686A2D4AD6 = _id_B92F1CF567538EEE._id_D0EA399E12ACB44E + _id_B92F1CF567538EEE._id_C0619D5E95F2F93E * randomfloatrange(_id_B92F1CF567538EEE._id_0D49778F53699B36 / 12, _id_B92F1CF567538EEE._id_0D49778F53699B36 / 8);
  _id_B92F1CF567538EEE._id_5F6EFFB5FFEB0640 = scripts\engine\utility::drop_to_ground((14475, 14180, 171));
  _id_B92F1CF567538EEE._id_2D40677C4CF806F3 = vectorNormalize(_id_B92F1CF567538EEE._id_5F6EFFB5FFEB0640 - _id_B92F1CF567538EEE._id_95589E686A2D4AD6);
  _id_A17C2E3D52385BB9 = distance(_id_B92F1CF567538EEE._id_A8B1CC7DB86436F8, _id_B92F1CF567538EEE._id_1329177FFF6E9779) / _id_B92F1CF567538EEE._id_85E1D048E879C6F6;

  foreach(_id_9011E2780F5C124B in _id_B92F1CF567538EEE._id_8E15C5F8EF27AFFC)
  _id_9011E2780F5C124B moveTo(_id_B92F1CF567538EEE._id_1329177FFF6E9779, _id_A17C2E3D52385BB9);

  _id_EBEB6C45213A480C = distance(_id_B92F1CF567538EEE._id_9011E2780F5C124B.origin, _id_B92F1CF567538EEE._id_D0EA399E12ACB44E) / _id_B92F1CF567538EEE._id_85E1D048E879C6F6;
  _id_B92F1CF567538EEE._id_9011E2780F5C124B moveTo(_id_B92F1CF567538EEE._id_D0EA399E12ACB44E, _id_EBEB6C45213A480C);
  _id_B92F1CF567538EEE._id_9011E2780F5C124B rotateby((0, 2000, 0), 0.5);

  while(distance(_id_B92F1CF567538EEE._id_9011E2780F5C124B.origin, _id_B92F1CF567538EEE._id_D0EA399E12ACB44E) > 1)
    waitframe();

  _id_F167ED12404E7E23 = distance(_id_B92F1CF567538EEE._id_D0EA399E12ACB44E, _id_B92F1CF567538EEE._id_95589E686A2D4AD6) / _id_B92F1CF567538EEE._id_4EEFB0BF29A11004;
  _id_B92F1CF567538EEE._id_9011E2780F5C124B moveTo(_id_B92F1CF567538EEE._id_95589E686A2D4AD6, _id_F167ED12404E7E23 + 0.5);
  _id_B92F1CF567538EEE._id_9011E2780F5C124B rotateby((0, 2000, 0), _id_F167ED12404E7E23 + 0.5);

  while(distance(_id_B92F1CF567538EEE._id_9011E2780F5C124B.origin, _id_B92F1CF567538EEE._id_95589E686A2D4AD6) > 100)
    waitframe();

  if(isDefined(_id_B92F1CF567538EEE._id_87A4F533A559BEF3) && scripts\engine\utility::fxexists(_id_B92F1CF567538EEE._id_87A4F533A559BEF3))
    playFX(scripts\engine\utility::getfx(_id_B92F1CF567538EEE._id_87A4F533A559BEF3), _id_B92F1CF567538EEE._id_9011E2780F5C124B.origin);

  if(isDefined(_id_B92F1CF567538EEE._id_6B0ED600522A41C8) && scripts\engine\utility::fxexists(_id_B92F1CF567538EEE._id_6B0ED600522A41C8))
    playFXOnTag(scripts\engine\utility::getfx(_id_B92F1CF567538EEE._id_6B0ED600522A41C8), _id_B92F1CF567538EEE._id_9011E2780F5C124B, "tag_origin");

  _id_ADBBA6F901E73941 = 3;
  _id_B92F1CF567538EEE._id_9011E2780F5C124B moveTo(_id_B92F1CF567538EEE._id_5F6EFFB5FFEB0640, _id_ADBBA6F901E73941, _id_ADBBA6F901E73941 / 2);
  _id_B92F1CF567538EEE._id_9011E2780F5C124B rotateby((300, -1080, -50), _id_ADBBA6F901E73941, _id_ADBBA6F901E73941 / 2);

  while(distance(_id_B92F1CF567538EEE._id_9011E2780F5C124B.origin, _id_B92F1CF567538EEE._id_5F6EFFB5FFEB0640) > 100)
    waitframe();

  if(isDefined(_id_B92F1CF567538EEE._id_43EF94BB02928D59) && scripts\engine\utility::fxexists(_id_B92F1CF567538EEE._id_43EF94BB02928D59))
    playFXOnTag(scripts\engine\utility::getfx(_id_B92F1CF567538EEE._id_43EF94BB02928D59), _id_B92F1CF567538EEE._id_9011E2780F5C124B, "tag_origin");

  _id_B42FCD6310C60CC7(_id_B92F1CF567538EEE);
}

_id_E9DF5FE0473A6F22(_id_B92F1CF567538EEE) {
  level waittill("infils_ready");
  _id_B92F1CF567538EEE._id_A8B1CC7DB86436F8 = level.infilstruct.c130pathstruct.startpt;
  _id_B92F1CF567538EEE._id_1329177FFF6E9779 = level.infilstruct.c130pathstruct.endpt;
  _id_B92F1CF567538EEE._id_C0619D5E95F2F93E = vectorNormalize(_id_B92F1CF567538EEE._id_1329177FFF6E9779 - _id_B92F1CF567538EEE._id_A8B1CC7DB86436F8);
  _id_B92F1CF567538EEE._id_0D49778F53699B36 = distance2d(_id_B92F1CF567538EEE._id_A8B1CC7DB86436F8, level.br_circle.safecircleent.origin) * 2;
  _id_B92F1CF567538EEE._id_4EEFB0BF29A11004 = _id_45B2B4A889E633FA::getc130speed();
  _id_B92F1CF567538EEE._id_9011E2780F5C124B = spawn("script_model", _id_B92F1CF567538EEE._id_A8B1CC7DB86436F8 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 6000));
  waitframe();
  _id_B92F1CF567538EEE._id_9011E2780F5C124B setModel(_id_B92F1CF567538EEE._id_CF9946A2B5867288);
  _id_B92F1CF567538EEE._id_9011E2780F5C124B.angles = vectortoangles(_id_B92F1CF567538EEE._id_C0619D5E95F2F93E);
  _id_B92F1CF567538EEE._id_9011E2780F5C124B rotatepitch(-30, 1);
  thread scripts\common\utility::_id_BD58CB04DDB828A2("Infil start position: " + _id_B92F1CF567538EEE._id_A8B1CC7DB86436F8, 999);
  thread scripts\common\utility::_id_BD58CB04DDB828A2("Infil direction: " + _id_B92F1CF567538EEE._id_C0619D5E95F2F93E, 999);
  thread scripts\common\utility::_id_BD58CB04DDB828A2("Infil distance: " + _id_B92F1CF567538EEE._id_0D49778F53699B36, 999);
  _id_B92F1CF567538EEE._id_85E1D048E879C6F6 = _id_B92F1CF567538EEE._id_4EEFB0BF29A11004 + 4000;
  _id_B92F1CF567538EEE._id_5F6EFFB5FFEB0640 = scripts\engine\utility::drop_to_ground((14475, 14180, 171));

  if(isDefined(_id_B92F1CF567538EEE._id_6B0ED600522A41C8) && scripts\engine\utility::fxexists(_id_B92F1CF567538EEE._id_6B0ED600522A41C8))
    playFXOnTag(scripts\engine\utility::getfx(_id_B92F1CF567538EEE._id_6B0ED600522A41C8), _id_B92F1CF567538EEE._id_9011E2780F5C124B, "tag_origin");

  _id_ADBBA6F901E73941 = distance(_id_B92F1CF567538EEE._id_9011E2780F5C124B.origin, _id_B92F1CF567538EEE._id_5F6EFFB5FFEB0640) / _id_B92F1CF567538EEE._id_85E1D048E879C6F6;
  _id_B92F1CF567538EEE._id_9011E2780F5C124B moveTo(_id_B92F1CF567538EEE._id_5F6EFFB5FFEB0640, _id_ADBBA6F901E73941);
  _id_B92F1CF567538EEE._id_9011E2780F5C124B rotateby((20, -3500, 0), _id_ADBBA6F901E73941, _id_ADBBA6F901E73941 / 2);

  while(distance(_id_B92F1CF567538EEE._id_9011E2780F5C124B.origin, _id_B92F1CF567538EEE._id_5F6EFFB5FFEB0640) > 100)
    waitframe();

  if(isDefined(_id_B92F1CF567538EEE._id_43EF94BB02928D59) && scripts\engine\utility::fxexists(_id_B92F1CF567538EEE._id_43EF94BB02928D59))
    playFXOnTag(scripts\engine\utility::getfx(_id_B92F1CF567538EEE._id_43EF94BB02928D59), _id_B92F1CF567538EEE._id_9011E2780F5C124B, "tag_origin");

  _id_B42FCD6310C60CC7(_id_B92F1CF567538EEE);
}

_id_B42FCD6310C60CC7(_id_B92F1CF567538EEE) {
  _id_C077AD85B4D516EE = [];
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["bridge_dirt_pile_01_lm_half", (-80, 20, -30), (0, 50, 0)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["bridge_dirt_pile_01_lm_half", (32, -92, -30), (0, 0, 0)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["bridge_dirt_pile_01_lm_half", (8, 100, -30), (0, 170, 0)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib1", (-106, 60, 0), (0, 75, 0)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib1", (-148, -136, 0), (0, 250, 0)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib1", (154, -211, 0), (345, 78, -165)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib1", (-408, 103, 0), (346, 133, -165)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib2", (-69, -178, 0), (304, 26, -143)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib2", (-164, 104, 0), (304, 201, -143)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib3", (-264, 116, 0), (0, 0, 0)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib3", (-360, -136, 0), (2, 260, -170)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib3", (-14, -387, 0), (1, 175, -170)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib4", (-439, 153, 0), (5, 76, -170)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib4", (-160, -196, 0), (0, 310, -9)]);
  _id_C077AD85B4D516EE = scripts\engine\utility::array_add(_id_C077AD85B4D516EE, ["veh9_mil_air_ufo_dst_gib5", (-196, 140, 0), (80, 0, -55)]);
  _id_543F2191DDE2B7F6 = _id_B92F1CF567538EEE._id_9011E2780F5C124B.origin;
  _id_B92F1CF567538EEE._id_9011E2780F5C124B.origin = (0, 0, 0);
  waitframe();
  _id_E4B7E99A96C8829F = [];

  foreach(_id_07D1202BF8CA7396 in _id_C077AD85B4D516EE)
  _id_E4B7E99A96C8829F = scripts\engine\utility::array_add(_id_E4B7E99A96C8829F, scripts\engine\utility::drop_to_ground(_id_543F2191DDE2B7F6 + _id_07D1202BF8CA7396[1]) + (0, 0, _id_07D1202BF8CA7396[1][2]));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C077AD85B4D516EE.size; _id_AC0E594AC96AA3A8++)
    scripts\common\utility::_id_22490AAEBAAC105E(_id_C077AD85B4D516EE[_id_AC0E594AC96AA3A8][0], _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8], _id_C077AD85B4D516EE[_id_AC0E594AC96AA3A8][2]);

  _id_B92F1CF567538EEE._id_9011E2780F5C124B.origin = _id_543F2191DDE2B7F6;

  if(isDefined(_id_B92F1CF567538EEE._id_62EB54694D73E7F5) && scripts\engine\utility::fxexists(_id_B92F1CF567538EEE._id_62EB54694D73E7F5))
    playFX(scripts\engine\utility::getfx(_id_B92F1CF567538EEE._id_62EB54694D73E7F5), _id_B92F1CF567538EEE._id_9011E2780F5C124B.origin);
}