/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7e4910196dcbe632.gsc
***********************************************/

init() {
  _id_7603E82423679FC0 = [];

  foreach(loot in getlootscriptablearray()) {
    if(issubstr(loot.type, "panel")) {
      continue;
    }
    _id_7603E82423679FC0[_id_7603E82423679FC0.size] = loot;
  }

  foreach(ent in getentitylessscriptablearray()) {
    if(issubstr(ent.classname, "cache"))
      _id_7603E82423679FC0[_id_7603E82423679FC0.size] = ent;
  }

  level._id_37AA0062320EBD1A._id_7603E82423679FC0 = _id_7603E82423679FC0;
}

_id_5D1148BBED9FC1D7() {
  _id_74510C9A259939AD = 10;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_37AA0062320EBD1A._id_7603E82423679FC0.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + _id_74510C9A259939AD) {
    loops = min(_id_74510C9A259939AD, level._id_37AA0062320EBD1A._id_7603E82423679FC0.size - _id_AC0E594AC96AA3A8);

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < loops; _id_AC0E5C4AC96AAA41++)
      _id_F69F070E260B70AD(level._id_37AA0062320EBD1A._id_7603E82423679FC0[_id_AC0E594AC96AA3A8 + _id_AC0E5C4AC96AAA41]);

    waitframe();
  }
}

_id_F69F070E260B70AD(loot) {
  _id_0AFE002BFE37369A = 250;
  _id_92AE02E0013916B6 = 1024;
  _id_ACD7C234093147F0 = 10;
  _id_5E100759D6A30AE5 = -30;
  contents = scripts\engine\trace::create_world_contents() + scripts\engine\trace::create_item_contents();
  clip = scripts\engine\utility::drop_to_ground(loot.origin, _id_ACD7C234093147F0, _id_5E100759D6A30AE5, undefined, contents);
  noclip = _id_0A661C5FAD6BEDD8::_id_2227FE7B9C3E31A3(clip[2] - loot.origin[2], _id_5E100759D6A30AE5, 1);

  if(noclip) {
    _id_183BC29D2DAB9FDF("no clip", loot);
    return;
  }

  _id_DE5538C1E87E6BF7 = getclosestpointonnavmesh(clip);
  _id_AB1A67A4635ADC46 = distance2dsquared(_id_DE5538C1E87E6BF7, clip);
  _id_51304DDED8F135AC = abs(_id_DE5538C1E87E6BF7[2] - clip[2]);
  _id_D478708F077A4A52 = "";

  if(_id_AB1A67A4635ADC46 > _id_92AE02E0013916B6)
    _id_D478708F077A4A52 = _id_D478708F077A4A52 + (" hOffset: " + sqrt(_id_AB1A67A4635ADC46));

  if(_id_51304DDED8F135AC > _id_0AFE002BFE37369A)
    _id_D478708F077A4A52 = _id_D478708F077A4A52 + (" vOffset: " + _id_51304DDED8F135AC);

  if(_id_D478708F077A4A52.size > 0) {
    _id_D478708F077A4A52 = _id_D478708F077A4A52 + (" navmeshPoint: " + _id_DE5538C1E87E6BF7 + " clipPoint: " + clip);
    _id_183BC29D2DAB9FDF("no navmesh", loot, _id_D478708F077A4A52);
  }
}

_id_183BC29D2DAB9FDF(_id_0889F3D7E1C1EA6B, loot, _id_D478708F077A4A52) {
  _id_444A5451F436094A = "";

  if(isDefined(_id_0889F3D7E1C1EA6B))
    _id_444A5451F436094A = _id_444A5451F436094A + _id_0889F3D7E1C1EA6B;

  _id_444A5451F436094A = _id_444A5451F436094A + "; ";

  if(isDefined(loot) && isDefined(loot.type))
    _id_444A5451F436094A = _id_444A5451F436094A + loot.type;

  _id_444A5451F436094A = _id_444A5451F436094A + "; ";

  if(isDefined(loot) && isDefined(loot.origin))
    _id_444A5451F436094A = _id_444A5451F436094A + loot.origin;

  _id_444A5451F436094A = _id_444A5451F436094A + "; ";

  if(isDefined(_id_D478708F077A4A52))
    _id_444A5451F436094A = _id_444A5451F436094A + _id_D478708F077A4A52;

  _id_0A661C5FAD6BEDD8::_id_9A0A24DE119B078A("Loot", _id_444A5451F436094A);
}