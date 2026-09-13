/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1fa444cdc9dbf364.gsc
***********************************************/

_id_F04C619138BAAFD8() {
  if(getdvarint("dvar_E1FCA8F6AB32AACC", 1) == 0) {
    return;
  }
  _id_2A5B2BEE2F55466A = level.struct_class_names["script_noteworthy"]["boss_trapper_claymore"];
  _id_E2176A2D7C0E42A4 = level.struct_class_names["script_noteworthy"]["boss_trapper_at_mine"];
  _id_535166B783F2C94D = level.struct_class_names["script_noteworthy"]["boss_trapper_cluster"];
  _id_CCD66FB268CE4CA7 = [_id_2A5B2BEE2F55466A, _id_E2176A2D7C0E42A4, _id_535166B783F2C94D];
  _id_0B028768E8EE7243 = ["claymore", "at_mine", "sound_veil"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CCD66FB268CE4CA7.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(_id_CCD66FB268CE4CA7[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    foreach(node in _id_CCD66FB268CE4CA7[_id_AC0E594AC96AA3A8]) {
      _id_282B1925C4AF6F1F = spawnStruct();
      _id_282B1925C4AF6F1F.origin = node.origin;
      _id_282B1925C4AF6F1F.angles = node.angles;
      _id_282B1925C4AF6F1F.ref = "equip_" + _id_0B028768E8EE7243[_id_AC0E594AC96AA3A8];
      thread _id_FD5966A3A1FDF6B8(_id_282B1925C4AF6F1F);
    }
  }
}

_id_AC625F4C2BF0906B(equipmentref) {
  _id_028FD9FF71D008A9 = self getvieworigin();
  _id_655F4170C63B668C = self getplayerangles();
  _id_738A7094C7BFDE17 = anglesToForward(_id_655F4170C63B668C);
  _id_3EB394D231FB9C74 = _id_028FD9FF71D008A9 + _id_738A7094C7BFDE17 * 256;
  _id_2FC7B90001702E5C = self;
  _id_E76C084D206CFB7F = scripts\engine\trace::create_contents(1, 0, 0, 1, 0, 1, 0, 1, 1);
  _id_F17A61AFB63DFD27 = scripts\engine\trace::ray_trace(_id_028FD9FF71D008A9, _id_3EB394D231FB9C74, _id_2FC7B90001702E5C, _id_E76C084D206CFB7F, 0, 0, 1);

  if(_id_F17A61AFB63DFD27["hittype"] == "hittype_none") {
    return;
  }
  _id_A0377A1DAF3300D0 = _id_F17A61AFB63DFD27["position"];
  _id_A4387F1E6D5EABA7 = scripts\engine\math::vector_project_onto_plane(vectorNormalize(self.origin - _id_F17A61AFB63DFD27["position"]), _id_F17A61AFB63DFD27["normal"]);
  _id_D924F30F835C73B7 = _id_F17A61AFB63DFD27["normal"];
  _id_DF8625CE05B92B48 = vectorcross(_id_A4387F1E6D5EABA7, _id_D924F30F835C73B7);
  _id_3A43D29B943AAF0C = axistoangles(_id_A4387F1E6D5EABA7, _id_DF8625CE05B92B48, _id_D924F30F835C73B7);
  _id_282B1925C4AF6F1F = spawnStruct();
  _id_282B1925C4AF6F1F.origin = _id_A0377A1DAF3300D0;
  _id_282B1925C4AF6F1F.angles = _id_3A43D29B943AAF0C;
  _id_282B1925C4AF6F1F.ref = equipmentref;
  _id_FD5966A3A1FDF6B8(_id_282B1925C4AF6F1F);
}

_id_FD5966A3A1FDF6B8(_id_282B1925C4AF6F1F, agentteam, _id_51095D4B426987DE) {
  weaponref = _id_282B1925C4AF6F1F.ref;
  _id_187AC8C12B417727 = issubstr(_id_282B1925C4AF6F1F.ref, "equip_");
  weaponobj = undefined;

  if(_id_187AC8C12B417727) {
    _id_8BF83D28BE4C2D4F = scripts\mp\equipment::getequipmenttableinfo(_id_282B1925C4AF6F1F.ref);

    if(isDefined(_id_8BF83D28BE4C2D4F.objweapon)) {
      weaponref = _id_8BF83D28BE4C2D4F.objweapon.basename;
      weaponobj = _id_8BF83D28BE4C2D4F.objweapon;
    }
  } else
    weaponobj = makeweapon(weaponref);

  _id_2884ADC8D320F897 = _id_48814951E916AF89::_id_AF3034A7C69D7EDB(_id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC("merc"));
  grenade = _id_2884ADC8D320F897 scripts\mp\utility\weapon::_launchgrenade(weaponref, _id_282B1925C4AF6F1F.origin, (0, 0, 0), undefined, 0, undefined, 0.0);
  grenade.angles = _id_282B1925C4AF6F1F.angles;

  if(isDefined(_id_51095D4B426987DE)) {
    waittillframeend;
    grenade notify("missile_stuck", _id_51095D4B426987DE);
  }

  return grenade;
}