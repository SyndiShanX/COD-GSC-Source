/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\weapon.gsc
***********************************************/

buildweapon_blueprintwithcustomattachments(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0) {
  _id_C7BD95B10C89CFF8 = weaponassetnamemap(_id_AB501F397D3CD312, variantid);
  _id_91BBF8D2294A656E = [];
  _id_9FF366D43A7BABF8 = [];
  _id_2A89BAEEA5B98584 = [];

  if(isDefined(attachments)) {
    foreach(_id_FE8F7703F6313ED4, attachment in attachments) {
      _id_1FCE8439ED13E7B3 = _func_891B1FB6A51B97B0(_id_C7BD95B10C89CFF8, attachment);
      _id_CDD4EC8C72DDB976 = _func_C6D15635447865C5(_id_C7BD95B10C89CFF8, attachment);

      foreach(_id_FCDA8728D88B5C5B in _id_CDD4EC8C72DDB976)
      _id_9FF366D43A7BABF8[_id_FCDA8728D88B5C5B] = 1;

      foreach(_id_93D6AF4397ECF6B4 in _id_1FCE8439ED13E7B3)
      _id_2A89BAEEA5B98584[_id_93D6AF4397ECF6B4] = 1;

      _id_8BAB4903A267774D = 0;

      if(isDefined(_id_F3464D71F01F614E) && isDefined(_id_F3464D71F01F614E[_id_FE8F7703F6313ED4]))
        _id_8BAB4903A267774D = _id_F3464D71F01F614E[_id_FE8F7703F6313ED4];

      _id_91BBF8D2294A656E[attachment] = _id_8BAB4903A267774D;
    }
  }

  _id_3482901E4B0E85E4 = weaponattachcustomtoidmap(_id_AB501F397D3CD312, variantid);

  if(isDefined(_id_3482901E4B0E85E4)) {
    foreach(attachment, id in _id_3482901E4B0E85E4) {
      if(_id_9FF366D43A7BABF8.size > 0) {
        slot = _func_4ADD228B999C26AA(_id_C7BD95B10C89CFF8, attachment);

        if(isDefined(_id_9FF366D43A7BABF8[slot]))
          continue;
      }

      if(_id_2A89BAEEA5B98584.size > 0) {
        type = _func_7C612AC92BA98DCB(_id_C7BD95B10C89CFF8, attachment);

        if(isDefined(_id_2A89BAEEA5B98584[type]))
          continue;
      }

      _id_91BBF8D2294A656E[attachment] = id;
    }
  }

  return buildweapon_attachmentidmap(_id_AB501F397D3CD312, _id_91BBF8D2294A656E, camo, reticle, variantid, cosmeticattachment, stickers, _id_11A1FA68AEB971C0);
}

buildweapon_blueprint(_id_AB501F397D3CD312, camo, reticle, variantid, cosmeticattachment, stickers, _id_11A1FA68AEB971C0) {
  _id_91BBF8D2294A656E = weaponattachcustomtoidmap(_id_AB501F397D3CD312, variantid);

  if(!isDefined(_id_91BBF8D2294A656E))
    _id_91BBF8D2294A656E = [];

  if(istrue(level._id_320BE3D1AF4EF493) && _id_91BBF8D2294A656E.size > 0) {
    foreach(attachment, id in _id_91BBF8D2294A656E) {
      if(issubstr(attachment, "laser"))
        _id_91BBF8D2294A656E[attachment] = undefined;
    }
  }

  return buildweapon_attachmentidmap(_id_AB501F397D3CD312, _id_91BBF8D2294A656E, camo, reticle, variantid, cosmeticattachment, stickers, _id_11A1FA68AEB971C0);
}

buildweapon_attachmentidmap(_id_AB501F397D3CD312, _id_91BBF8D2294A656E, camo, reticle, variantid, cosmeticattachment, stickers, _id_11A1FA68AEB971C0) {
  attachments = [];
  _id_F3464D71F01F614E = [];

  foreach(attachment, id in _id_91BBF8D2294A656E) {
    attachments[attachments.size] = attachment;
    _id_F3464D71F01F614E[_id_F3464D71F01F614E.size] = id;
  }

  return buildweapon(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0);
}

buildweapon(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0, _id_21DE0872BE9361B5) {
  _id_4CC9DE3064C7CF51 = level._id_EC2FB549B15AD827;

  if(!istrue(_id_E8B81323119C2572(_id_AB501F397D3CD312)))
    _id_AB501F397D3CD312 = getweaponrootname(_id_AB501F397D3CD312);

  if(isminigunweapon(_id_AB501F397D3CD312)) {
    _id_791C14FBD0F3282D = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845(_id_AB501F397D3CD312);
    return _id_791C14FBD0F3282D;
  }

  if(isDefined(attachments)) {} else
    attachments = [];

  if(!isDefined(camo))
    camo = "none";

  if(isDefined(variantid) && variantid <= 0)
    variantid = undefined;

  _id_C7BD95B10C89CFF8 = weaponassetnamemap(_id_AB501F397D3CD312, variantid);
  _id_91BBF8D2294A656E = buildweaponattachmentidmap(attachments, _id_F3464D71F01F614E);
  weaponobj = makeweapon(_id_C7BD95B10C89CFF8, [], undefined, camo, variantid);
  _id_DE230719CECF1C95 = _id_C7CB2EBF3712DC6C(_id_AB501F397D3CD312, _id_91BBF8D2294A656E, variantid, _id_C7BD95B10C89CFF8);

  if(isDefined(cosmeticattachment) && cosmeticattachment != "none")
    _id_DE230719CECF1C95[cosmeticattachment] = 0;

  _id_DE230719CECF1C95 = filterinvalidattachmentsfromidmap(_id_DE230719CECF1C95, _id_C7BD95B10C89CFF8, weaponobj);

  foreach(attachment, _id_27040FD5EA255709 in _id_DE230719CECF1C95) {
    if(isDefined(_id_21DE0872BE9361B5) && isDefined(_id_21DE0872BE9361B5[attachment])) {
      weaponobj = weaponobj withattachment(attachment, _id_27040FD5EA255709, _id_21DE0872BE9361B5[attachment]);
      continue;
    }

    _id_379CA50CA75BE2A9 = 0;
    _id_C7BD95B10C89CFF8 = weaponassetnamemap(_id_AB501F397D3CD312, variantid);
    _id_96AF313F39A1E436 = _func_55DB7A4374ED4B1B(_id_C7BD95B10C89CFF8, attachment);

    foreach(_id_445678F631CF47F0, id in _id_96AF313F39A1E436) {
      if(_id_27040FD5EA255709 == id) {
        _id_379CA50CA75BE2A9 = 1;
        break;
      }
    }

    if(_id_379CA50CA75BE2A9)
      weaponobj = weaponobj withattachment(attachment, _id_27040FD5EA255709);
    else
      weaponobj = weaponobj withattachment(attachment);
  }

  if(istrue(_id_11A1FA68AEB971C0)) {
    if(weaponsupportslaserir(_id_C7BD95B10C89CFF8, weaponobj) && _id_8A96B90526C40DF6(weaponobj, attachments)) {
      _id_38D50FF0E9EE470F = getweaponnvgattachment(weaponobj);

      if(_id_38D50FF0E9EE470F != "invalid" && !isDefined(_id_91BBF8D2294A656E[_id_38D50FF0E9EE470F]))
        weaponobj = weaponobj withattachment(_id_38D50FF0E9EE470F);
    }
  }

  if(isDefined(variantid) && (!isDefined(_id_4CC9DE3064C7CF51) || !istrue(_id_4CC9DE3064C7CF51) || level.gametype == "br"))
    weaponobj = weaponobj _meth_7E483D6E6B4B5688(variantid);

  if(isDefined(stickers)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < stickers.size; _id_AC0E594AC96AA3A8++) {
      _id_223521C35AE8A753 = stickers[_id_AC0E594AC96AA3A8];

      if(_id_223521C35AE8A753 == "none") {
        continue;
      }
      if("i/" != getsubstr(_id_223521C35AE8A753, 0, 2))
        _id_223521C35AE8A753 = "i/" + stickers[_id_AC0E594AC96AA3A8];

      weaponobj = weaponobj setsticker(_id_AC0E594AC96AA3A8, _id_223521C35AE8A753);
    }
  }

  if(isDefined(weaponobj.scope) && !isstartstr(weaponobj.scope, "ironsdefault")) {
    _id_6A42D475DFB96A31 = getreticleindex(reticle);

    if(isDefined(_id_6A42D475DFB96A31))
      weaponobj = weaponobj withreticle(_id_6A42D475DFB96A31);
  }

  return weaponobj;
}

_id_C7CB2EBF3712DC6C(_id_AB501F397D3CD312, _id_91BBF8D2294A656E, variantid, _id_C7BD95B10C89CFF8) {
  if(!isDefined(_id_91BBF8D2294A656E))
    _id_91BBF8D2294A656E = [];

  _id_91BBF8D2294A656E = scripts\engine\utility::array_remove_key(_id_91BBF8D2294A656E, "none");
  _id_91BBF8D2294A656E = scripts\engine\utility::array_remove_key(_id_91BBF8D2294A656E, "");
  _id_3F065AF353909441 = weaponattachdefaulttoidmap(_id_AB501F397D3CD312, variantid);
  _id_C7BD95B10C89CFF8 = _id_072376783A92BE46(_id_AB501F397D3CD312);
  _id_85B2A5343FC91CCB = weaponassetnamemap(_id_AB501F397D3CD312, variantid);
  _id_F7E18E8FF85948B9 = _func_6527364C1ECCA6C6(_id_C7BD95B10C89CFF8);
  _id_234557A232185389 = [];
  _id_55559AF28DCAC702 = [];

  if(isDefined(variantid) && variantid > 0) {
    foreach(_id_766D3914F2A5D02E, id in _id_3F065AF353909441) {
      foreach(_id_68D755054A365715 in _id_F7E18E8FF85948B9) {
        if(_id_766D3914F2A5D02E == _id_68D755054A365715)
          _id_234557A232185389[_id_766D3914F2A5D02E] = id;
      }

      if(_func_4ADD228B999C26AA(_id_C7BD95B10C89CFF8, _id_766D3914F2A5D02E) == "other") {
        if(issubstr(_id_766D3914F2A5D02E, "akimbo")) {
          continue;
        }
        _id_234557A232185389[_id_766D3914F2A5D02E] = id;
      }
    }
  }

  if(_id_234557A232185389.size > 0) {
    _id_1B3DEC1306A82D04 = _func_6527364C1ECCA6C6(_id_C7BD95B10C89CFF8);

    foreach(_id_E5614CC9F3563E5B in _id_1B3DEC1306A82D04)
    _id_55559AF28DCAC702[_id_E5614CC9F3563E5B] = 0;

    _id_234557A232185389 = combinedefaultandcustomattachmentidmaps(_id_55559AF28DCAC702, _id_234557A232185389);
  }

  _id_71DAF4388D8CC783 = [];

  if(_id_234557A232185389.size > 0)
    _id_71DAF4388D8CC783 = combinedefaultandcustomattachmentidmaps(_id_234557A232185389, _id_91BBF8D2294A656E);
  else if(isDefined(_id_3F065AF353909441))
    _id_71DAF4388D8CC783 = combinedefaultandcustomattachmentidmaps(_id_3F065AF353909441, _id_91BBF8D2294A656E);

  _id_8B1AA9931D355839 = [];

  foreach(attachment, _id_27040FD5EA255709 in _id_71DAF4388D8CC783) {
    extra = attachmentmap_toextra(attachment);

    if(isDefined(extra)) {
      foreach(_id_DB701CDBDBE476AC in extra) {
        _id_201C473EBB366B33 = 0;

        if(isDefined(variantid))
          _id_201C473EBB366B33 = attachmentmap_extratovariantid(_id_DB701CDBDBE476AC, _id_AB501F397D3CD312, variantid, _id_27040FD5EA255709);
        else if(_id_27040FD5EA255709 != 0)
          _id_201C473EBB366B33 = _id_27040FD5EA255709;

        _id_8B1AA9931D355839[_id_DB701CDBDBE476AC] = _id_201C473EBB366B33;
      }
    }
  }

  if(_id_85B2A5343FC91CCB == "iw9_sh_charlie725_v10" && _id_8B1AA9931D355839 < 1)
    _id_8B1AA9931D355839["charlie725_doom_blueprint_tuning"] = 4;

  if(_id_8B1AA9931D355839.size > 0)
    _id_71DAF4388D8CC783 = scripts\engine\utility::array_combine_unique_keys(_id_71DAF4388D8CC783, _id_8B1AA9931D355839);

  if(_id_71DAF4388D8CC783.size > 0)
    _id_71DAF4388D8CC783 = filterattachmenttoidmap(_id_71DAF4388D8CC783, _id_AB501F397D3CD312, _id_C7BD95B10C89CFF8, _id_91BBF8D2294A656E);

  return _id_71DAF4388D8CC783;
}

filterattachmenttoidmap(_id_91BBF8D2294A656E, weaponname, _id_C7BD95B10C89CFF8, _id_3E66176ED86556B4) {
  _id_7CB19F95DBC68942 = [];
  attachments = [];

  if(isDefined(level.weaponmapdata[weaponname]) && isDefined(level.weaponmapdata[weaponname]._id_D43F9C4F6B647BA4))
    _id_91BBF8D2294A656E = _id_73948793BDD465E3(_id_91BBF8D2294A656E, _id_C7BD95B10C89CFF8);

  _id_91BBF8D2294A656E = _id_89579D7BA0194E4A(_id_91BBF8D2294A656E, _id_C7BD95B10C89CFF8);
  _id_BD4F329D016BBB83 = 1;
  _id_7CB73D334CB60B70 = _id_91BBF8D2294A656E;
  _id_12537F9EF0BC941E = _id_3E66176ED86556B4;
  _id_F564D1D37DF78CBD = _func_6527364C1ECCA6C6(_id_C7BD95B10C89CFF8);

  foreach(_id_7D28A5543F741DF1, id in _id_12537F9EF0BC941E) {
    foreach(_id_71C0C1C9B683339B in _id_F564D1D37DF78CBD) {
      if(_id_7D28A5543F741DF1 == _id_71C0C1C9B683339B)
        _id_12537F9EF0BC941E = scripts\engine\utility::array_remove_key(_id_12537F9EF0BC941E, _id_7D28A5543F741DF1);
    }
  }

  foreach(_id_7D28A5543F741DF1, _id_FE8F3003F630A2AF in _id_12537F9EF0BC941E) {
    foreach(_id_CDA1B0C40C7958FD, _id_FE8F3103F630A4E2 in _id_91BBF8D2294A656E) {
      if(_id_7D28A5543F741DF1 == _id_CDA1B0C40C7958FD)
        continue;
      else {
        _id_609C88FD5E06F606 = attachmentsconflict(_id_CDA1B0C40C7958FD, _id_7D28A5543F741DF1, weaponname, _id_BD4F329D016BBB83);

        if(_id_609C88FD5E06F606 == _id_7D28A5543F741DF1)
          _id_7CB73D334CB60B70 = scripts\engine\utility::array_remove_key(_id_7CB73D334CB60B70, _id_CDA1B0C40C7958FD);
      }
    }
  }

  _id_91BBF8D2294A656E = _id_7CB73D334CB60B70;
  _id_115F9572069455E3 = getfirstarraykey(_id_91BBF8D2294A656E);
  attachments[0] = _id_115F9572069455E3;

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < attachments.size; _id_DF6D8E005B4B8020++) {
    attachment = attachments[_id_DF6D8E005B4B8020];

    if(attachment != "none") {
      add = 1;

      for(_id_DDEBF4E10BB16DB6 = 0; _id_DDEBF4E10BB16DB6 < _id_7CB19F95DBC68942.size; _id_DDEBF4E10BB16DB6++) {
        _id_21B8398A03B0B779 = _id_7CB19F95DBC68942[_id_DDEBF4E10BB16DB6];

        if(_id_21B8398A03B0B779 == "") {
          continue;
        }
        if(attachment == _id_21B8398A03B0B779) {
          add = 0;
          break;
        }

        _id_609C88FD5E06F606 = attachmentsconflict(attachment, _id_21B8398A03B0B779, weaponname, _id_BD4F329D016BBB83);

        if(_id_609C88FD5E06F606 == attachment) {
          _id_7CB19F95DBC68942[_id_DDEBF4E10BB16DB6] = "";
          continue;
        }

        if(_id_609C88FD5E06F606 != "") {
          _id_7CB19F95DBC68942[_id_DDEBF4E10BB16DB6] = "";
          add = 0;
          _id_6D1E03F37D922BBB = [];
          _id_6D1E03F37D922BBB = strtok(_id_609C88FD5E06F606, " ");

          for(_id_78E21DA50AD1C7C2 = 0; _id_78E21DA50AD1C7C2 < _id_6D1E03F37D922BBB.size; _id_78E21DA50AD1C7C2++)
            attachments[attachments.size] = _id_6D1E03F37D922BBB[_id_78E21DA50AD1C7C2];

          break;
        }
      }

      if(add) {
        _id_393ECD11D41EC10B = _id_7CB19F95DBC68942.size;
        _id_7CB19F95DBC68942[_id_393ECD11D41EC10B] = attachment;
      }
    }

    if(_id_DF6D8E005B4B8020 == attachments.size - 1) {
      _id_115F9572069455E3 = getnextarraykey(_id_91BBF8D2294A656E, _id_115F9572069455E3);

      if(isDefined(_id_115F9572069455E3))
        attachments[attachments.size] = _id_115F9572069455E3;
    }
  }

  _id_1168362B7EEA93A9 = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < _id_7CB19F95DBC68942.size; _id_DF6D8E005B4B8020++) {
    attachment = _id_7CB19F95DBC68942[_id_DF6D8E005B4B8020];

    if(attachment != "") {
      _id_27040FD5EA255709 = scripts\engine\utility::ter_op(isDefined(_id_91BBF8D2294A656E[attachment]), _id_91BBF8D2294A656E[attachment], 0);
      _id_1168362B7EEA93A9[attachment] = _id_27040FD5EA255709;
    }
  }

  return _id_1168362B7EEA93A9;
}

_id_89579D7BA0194E4A(_id_91BBF8D2294A656E, weaponname, _id_C7BD95B10C89CFF8) {
  _id_7CB19F95DBC68942 = [];
  attachments = [];
  _id_115F9572069455E3 = getfirstarraykey(_id_91BBF8D2294A656E);
  attachments[0] = _id_115F9572069455E3;

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < attachments.size; _id_DF6D8E005B4B8020++) {
    attachment = attachments[_id_DF6D8E005B4B8020];

    if(attachment != "none") {
      add = 1;

      for(_id_DDEBF4E10BB16DB6 = 0; _id_DDEBF4E10BB16DB6 < _id_7CB19F95DBC68942.size; _id_DDEBF4E10BB16DB6++) {
        _id_21B8398A03B0B779 = _id_7CB19F95DBC68942[_id_DDEBF4E10BB16DB6];

        if(_id_21B8398A03B0B779 == "") {
          continue;
        }
        if(attachment == _id_21B8398A03B0B779) {
          add = 0;
          break;
        }

        _id_609C88FD5E06F606 = _id_B9F9C92EF7F1922B(attachment, _id_21B8398A03B0B779, weaponname);

        if(_id_609C88FD5E06F606 == attachment) {
          _id_7CB19F95DBC68942[_id_DDEBF4E10BB16DB6] = "";
          continue;
        }

        if(_id_609C88FD5E06F606 != "") {
          _id_7CB19F95DBC68942[_id_DDEBF4E10BB16DB6] = "";
          add = 0;
          _id_6D1E03F37D922BBB = [];
          _id_6D1E03F37D922BBB = strtok(_id_609C88FD5E06F606, " ");

          for(_id_78E21DA50AD1C7C2 = 0; _id_78E21DA50AD1C7C2 < _id_6D1E03F37D922BBB.size; _id_78E21DA50AD1C7C2++)
            attachments[attachments.size] = _id_6D1E03F37D922BBB[_id_78E21DA50AD1C7C2];

          break;
        }
      }

      if(add) {
        _id_393ECD11D41EC10B = _id_7CB19F95DBC68942.size;
        _id_7CB19F95DBC68942[_id_393ECD11D41EC10B] = attachment;
      }
    }

    if(_id_DF6D8E005B4B8020 == attachments.size - 1) {
      _id_115F9572069455E3 = getnextarraykey(_id_91BBF8D2294A656E, _id_115F9572069455E3);

      if(isDefined(_id_115F9572069455E3))
        attachments[attachments.size] = _id_115F9572069455E3;
    }
  }

  _id_1168362B7EEA93A9 = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < _id_7CB19F95DBC68942.size; _id_DF6D8E005B4B8020++) {
    attachment = _id_7CB19F95DBC68942[_id_DF6D8E005B4B8020];

    if(attachment != "") {
      _id_27040FD5EA255709 = scripts\engine\utility::ter_op(isDefined(_id_91BBF8D2294A656E[attachment]), _id_91BBF8D2294A656E[attachment], 0);
      _id_1168362B7EEA93A9[attachment] = _id_27040FD5EA255709;
    }
  }

  return _id_1168362B7EEA93A9;
}

_id_73948793BDD465E3(_id_91BBF8D2294A656E, _id_C7BD95B10C89CFF8) {
  _id_115F9572069455E3 = getfirstarraykey(_id_91BBF8D2294A656E);
  attachments[0] = _id_115F9572069455E3;
  _id_13F5CE59FEE67E25 = "";
  _id_FDDF44E25B1D3F14 = "";
  _id_B93F2890063CCF4E = 0;
  _id_40237D58734EA149 = 0;
  _id_07002135DC405CB0 = [];
  _id_D5D1E39EDB18D983 = 0;

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < attachments.size; _id_DF6D8E005B4B8020++) {
    attachment = attachments[_id_DF6D8E005B4B8020];
    _id_343CBA42BF800B55 = _func_C7F2F8CD775A57F8(_id_C7BD95B10C89CFF8, attachments[_id_DF6D8E005B4B8020]);

    if(_id_343CBA42BF800B55 != "")
      _id_40237D58734EA149 = 1;

    if(_id_DF6D8E005B4B8020 == attachments.size - 1) {
      _id_115F9572069455E3 = getnextarraykey(_id_91BBF8D2294A656E, _id_115F9572069455E3);

      if(isDefined(_id_115F9572069455E3))
        attachments[attachments.size] = _id_115F9572069455E3;
    }
  }

  if(!_id_40237D58734EA149)
    return _id_91BBF8D2294A656E;

  foreach(id, a in attachments) {
    for(counter = attachments.size; counter > id + 1; counter--) {
      _id_609C88FD5E06F606 = attachmentsconflict(a, attachments[counter - 1], _id_C7BD95B10C89CFF8);

      if(_id_609C88FD5E06F606 == attachments[counter - 1]) {
        _id_1B23D0F4EBCD81E2 = _func_4ADD228B999C26AA(_id_C7BD95B10C89CFF8, _id_609C88FD5E06F606);
        _id_AAF9CAEFBBE5181C = _func_4ADD228B999C26AA(_id_C7BD95B10C89CFF8, a);

        if(_id_1B23D0F4EBCD81E2 == _id_AAF9CAEFBBE5181C) {
          attachments[id] = _id_609C88FD5E06F606;
          break;
        } else {
          _id_13F5CE59FEE67E25 = a;
          _id_FDDF44E25B1D3F14 = _id_609C88FD5E06F606;
          _id_D5D1E39EDB18D983 = 1;
        }
      } else if(_id_609C88FD5E06F606 == a) {
        _id_13F5CE59FEE67E25 = attachments[counter - 1];
        _id_FDDF44E25B1D3F14 = _id_609C88FD5E06F606;
        _id_D5D1E39EDB18D983 = 1;
      }

      if(_id_D5D1E39EDB18D983) {
        _id_039A5D6439A89296 = _func_C7F2F8CD775A57F8(_id_C7BD95B10C89CFF8, _id_13F5CE59FEE67E25);
        _id_40C072E303020C37 = _func_4ADD228B999C26AA(_id_C7BD95B10C89CFF8, _id_13F5CE59FEE67E25);

        if(_id_039A5D6439A89296 != "") {
          _id_FEAA04125D5C7AB2 = _func_FA689AEE146FBCF9(_id_C7BD95B10C89CFF8, _id_039A5D6439A89296);

          foreach(_id_8F99D80BAC78DB05 in _id_FEAA04125D5C7AB2) {
            _id_7F067BF518E3B85F = attachmentsconflict(_id_8F99D80BAC78DB05, _id_FDDF44E25B1D3F14, _id_C7BD95B10C89CFF8);

            if(_id_7F067BF518E3B85F == _id_FDDF44E25B1D3F14)
              continue;
            else if(_id_7F067BF518E3B85F == _id_13F5CE59FEE67E25)
              continue;
            else {
              _id_7EB8FA9EA0957640 = _func_4ADD228B999C26AA(_id_C7BD95B10C89CFF8, _id_8F99D80BAC78DB05);

              if(_id_40C072E303020C37 == _id_7EB8FA9EA0957640) {
                foreach(id, a in attachments) {
                  if(a == _id_13F5CE59FEE67E25)
                    _id_B93F2890063CCF4E = id;
                }

                attachments[_id_B93F2890063CCF4E] = _id_8F99D80BAC78DB05;
                _id_07002135DC405CB0[_id_07002135DC405CB0.size] = _id_8F99D80BAC78DB05;
                _id_D5D1E39EDB18D983 = 0;
                break;
              }

              _id_D5D1E39EDB18D983 = 0;
            }
          }
        }
      }
    }
  }

  _id_1168362B7EEA93A9 = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < attachments.size; _id_DF6D8E005B4B8020++) {
    _id_74903B21BC06DFD7 = 0;
    attachment = attachments[_id_DF6D8E005B4B8020];

    if(attachment != "") {
      foreach(a, id in _id_91BBF8D2294A656E) {
        foreach(_id_5D5857FD46C08D4A in _id_07002135DC405CB0) {
          if(attachment == _id_5D5857FD46C08D4A) {
            _id_5ADBCA3B39BA22EA = _func_4ADD228B999C26AA(_id_C7BD95B10C89CFF8, a);
            _id_DF4BECEF128F8F21 = _func_4ADD228B999C26AA(_id_C7BD95B10C89CFF8, _id_5D5857FD46C08D4A);

            if(_id_5ADBCA3B39BA22EA == _id_DF4BECEF128F8F21) {
              if(id > 0) {
                _id_96AF313F39A1E436 = _func_55DB7A4374ED4B1B(_id_C7BD95B10C89CFF8, attachment);

                if(_id_96AF313F39A1E436.size > 0) {
                  _id_1168362B7EEA93A9[attachment] = id;
                  _id_74903B21BC06DFD7 = 1;
                  break;
                } else
                  break;
              }
            }
          }
        }
      }

      if(!_id_74903B21BC06DFD7) {
        _id_27040FD5EA255709 = scripts\engine\utility::ter_op(isDefined(_id_91BBF8D2294A656E[attachment]), _id_91BBF8D2294A656E[attachment], 0);
        _id_1168362B7EEA93A9[attachment] = _id_27040FD5EA255709;
      }
    }
  }

  return _id_1168362B7EEA93A9;
}

attachmentsconflict(_id_59F68715C04CE28F, _id_59F68815C04CE4C2, weapon, _id_BD4F329D016BBB83) {
  if(attachmentiscosmetic(_id_59F68715C04CE28F) && attachmentiscosmetic(_id_59F68815C04CE4C2))
    return _id_59F68715C04CE28F;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = getcompleteweaponname(weapon);
  else
    weaponname = weapon;

  if(iskillstreakweapon(weapon))
    weaponasset = weapon;
  else {
    _id_AB501F397D3CD312 = getweaponrootname(weapon);
    weaponasset = weaponassetnamemap(_id_AB501F397D3CD312);
  }

  if(!istrue(_id_BD4F329D016BBB83)) {
    _id_C1F45BF103F82583 = _func_4ADD228B999C26AA(weaponasset, _id_59F68715C04CE28F);
    _id_E571ECDD21DDCEE6 = _func_4ADD228B999C26AA(weaponasset, _id_59F68815C04CE4C2);

    if(_id_C1F45BF103F82583 == _id_E571ECDD21DDCEE6 && _id_C1F45BF103F82583 != "other") {
      _id_9223F12F525A29BB = _func_1DD1F56BC3D72B7E(weaponasset, _id_59F68715C04CE28F);
      _id_FE4A994289B5830A = _func_1DD1F56BC3D72B7E(weaponasset, _id_59F68815C04CE4C2);

      if(_id_9223F12F525A29BB >= _id_FE4A994289B5830A)
        return _id_59F68715C04CE28F;
      else
        return _id_59F68815C04CE4C2;
    }
  }

  _id_27CCFB6C99BBA30D = _attachmentblocks(weaponasset, _id_59F68715C04CE28F, _id_59F68815C04CE4C2);
  _id_B7B0B0D582725413 = _attachmentblocks(weaponasset, _id_59F68815C04CE4C2, _id_59F68715C04CE28F);

  if(_id_27CCFB6C99BBA30D && _id_B7B0B0D582725413)
    return _id_59F68715C04CE28F;
  else if(_id_27CCFB6C99BBA30D)
    return _id_59F68715C04CE28F;
  else if(_id_B7B0B0D582725413)
    return _id_59F68815C04CE4C2;

  return "";
}

_id_B9F9C92EF7F1922B(_id_59F68715C04CE28F, _id_59F68815C04CE4C2, weapon, _id_85CF583664CF2B09) {
  if(attachmentiscosmetic(_id_59F68715C04CE28F) && attachmentiscosmetic(_id_59F68815C04CE4C2))
    return _id_59F68715C04CE28F;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = getcompleteweaponname(weapon);
  else
    weaponname = weapon;

  if(iskillstreakweapon(weapon))
    weaponasset = weapon;
  else {
    _id_AB501F397D3CD312 = getweaponrootname(weapon);
    weaponasset = weaponassetnamemap(_id_AB501F397D3CD312);
  }

  _id_C1F45BF103F82583 = _func_4ADD228B999C26AA(weaponasset, _id_59F68715C04CE28F);
  _id_E571ECDD21DDCEE6 = _func_4ADD228B999C26AA(weaponasset, _id_59F68815C04CE4C2);

  if(_id_C1F45BF103F82583 == _id_E571ECDD21DDCEE6 && _id_C1F45BF103F82583 != "other") {
    _id_9223F12F525A29BB = _func_1DD1F56BC3D72B7E(weaponasset, _id_59F68715C04CE28F);
    _id_FE4A994289B5830A = _func_1DD1F56BC3D72B7E(weaponasset, _id_59F68815C04CE4C2);

    if(_id_9223F12F525A29BB >= _id_FE4A994289B5830A)
      return _id_59F68715C04CE28F;
    else
      return _id_59F68815C04CE4C2;
  }

  return "";
}

_attachmentblocks(weaponasset, _id_59F68715C04CE28F, _id_59F68815C04CE4C2) {
  _id_1FCE8439ED13E7B3 = _func_891B1FB6A51B97B0(weaponasset, _id_59F68715C04CE28F);
  _id_B28653DF677FB727 = _func_7C612AC92BA98DCB(weaponasset, _id_59F68815C04CE4C2);
  _id_513AE6D402F048E3 = _func_E843253D046AD859(weaponasset, _id_59F68715C04CE28F);

  foreach(_id_1439F86640D42E34 in _id_1FCE8439ED13E7B3) {
    if(_id_1439F86640D42E34 == _id_B28653DF677FB727)
      return 1;
  }

  _id_C1F45BF103F82583 = _func_4ADD228B999C26AA(weaponasset, _id_59F68715C04CE28F);
  _id_E571ECDD21DDCEE6 = _func_4ADD228B999C26AA(weaponasset, _id_59F68815C04CE4C2);

  if(_id_C1F45BF103F82583 == _id_E571ECDD21DDCEE6 && _id_C1F45BF103F82583 != "other")
    return 1;

  _id_CDD4EC8C72DDB976 = _func_C6D15635447865C5(weaponasset, _id_59F68715C04CE28F);

  foreach(slot in _id_CDD4EC8C72DDB976) {
    if(slot == _id_E571ECDD21DDCEE6)
      return 1;
  }

  foreach(attachment in _id_513AE6D402F048E3) {
    if(attachment == _id_59F68815C04CE4C2)
      return 1;
  }

  return 0;
}

_id_975E31B63F01FBCC(attachment) {
  return issubstr(attachment, "ironsdefault_");
}

_id_DE04E13AB01E1A10(attachment) {
  return issubstr(attachment, "ubshtgn") || issubstr(attachment, "ub_sh");
}

attachmentmap_tocategory(_id_659F734FC2A248FF) {
  if(isDefined(level._id_F83E21209BE1B993[_id_659F734FC2A248FF]))
    return level._id_F83E21209BE1B993[_id_659F734FC2A248FF];

  return undefined;
}

attachmentmap_toextra(_id_659F734FC2A248FF) {
  if(isDefined(level._id_50611D6541B815A3[_id_659F734FC2A248FF])) {
    _id_79B6F061BE629059 = [];
    _id_59BF6A1EAE2B42D8 = level._id_50611D6541B815A3[_id_659F734FC2A248FF];

    foreach(_id_F90358454413407F in _id_59BF6A1EAE2B42D8) {
      if(!isDefined(_id_F90358454413407F._id_C509A2E8A9D5D422) || _id_F90358454413407F._id_C509A2E8A9D5D422 == "") {
        continue;
      }
      _id_79B6F061BE629059[_id_F90358454413407F._id_C509A2E8A9D5D422] = _id_F90358454413407F._id_C509A2E8A9D5D422;
    }

    return _id_79B6F061BE629059;
  } else
    return undefined;
}

attachmentperkmap(weapon, _id_659F734FC2A248FF) {
  _id_23CC62CF981071E5 = _func_4F344EC5B7C45A3F(weapon, _id_659F734FC2A248FF);

  if(isDefined(_id_23CC62CF981071E5))
    return _id_23CC62CF981071E5;

  return undefined;
}

buildattachmentmaps() {
  level._id_50611D6541B815A3 = [];
  level.weaponattachments = [];
  level._id_8DD253609D606F1C = [];
  level._id_1F4C7D9CB262BA15 = [];
  _id_C471A035D22DF5EB();
  _id_6DF1FDD78EB73A36 = [];

  foreach(slot in level._id_C7008CFF883CD615) {
    if(slot == "visual") {
      continue;
    }
    _id_6DF1FDD78EB73A36[_id_6DF1FDD78EB73A36.size] = slot;
  }

  foreach(_id_E00EC0768D5F2B55 in level.weaponmapdata) {
    if(isDefined(_id_E00EC0768D5F2B55.assetname) && isDefined(_id_E00EC0768D5F2B55.group)) {
      foreach(slot in _id_6DF1FDD78EB73A36) {
        _id_63A235C3E361A6C3 = _func_75B035199842693D(_id_E00EC0768D5F2B55.assetname, slot);

        if(isDefined(_id_63A235C3E361A6C3)) {
          foreach(attachment in _id_63A235C3E361A6C3) {
            _id_25EA48876F86D21E = getscriptbundle(_func_2EF675C13CA1C4AF("enum_3C2C9813BB16552F", attachment));

            if(isDefined(_id_25EA48876F86D21E)) {
              lootid = _id_25EA48876F86D21E.lootid;

              if(isDefined(lootid)) {
                if(!isDefined(level._id_1F4C7D9CB262BA15[_id_E00EC0768D5F2B55.assetname]))
                  level._id_1F4C7D9CB262BA15[_id_E00EC0768D5F2B55.assetname] = [];

                if(!isDefined(level._id_1F4C7D9CB262BA15[_id_E00EC0768D5F2B55.assetname][lootid]))
                  level._id_1F4C7D9CB262BA15[_id_E00EC0768D5F2B55.assetname][lootid] = attachment;
              }

              if(isDefined(level.weaponattachments[attachment])) {
                continue;
              }
              if(isDefined(_id_25EA48876F86D21E._id_903BA58B5ABB6CC2) && _id_25EA48876F86D21E._id_903BA58B5ABB6CC2.size > 0) {
                if(!isDefined(level._id_50611D6541B815A3[attachment]))
                  level._id_50611D6541B815A3[attachment] = _id_25EA48876F86D21E._id_903BA58B5ABB6CC2;
              }

              if(isDefined(_id_25EA48876F86D21E.category) && _id_25EA48876F86D21E.category != "NONE" && !isDefined(level.weaponattachments[attachment]))
                level.weaponattachments[attachment] = _id_25EA48876F86D21E.lootid;
            }
          }
        }
      }
    }
  }

  if(getdvarint("dvar_D5C6A9526FC3F978", 0) != 0)
    _id_3BCC7E579D813F1C = getscriptbundle("enum_0CC2FCAE4B88731D");
  else
    _id_3BCC7E579D813F1C = getscriptbundle("enum_66F910033B84FC58");

  if(isDefined(_id_3BCC7E579D813F1C)) {
    foreach(index, data in _id_3BCC7E579D813F1C._id_F326EBC89E9419A6) {
      _id_659F734FC2A248FF = data._id_D442547D75DFFD09;

      if(isDefined(_id_659F734FC2A248FF)) {
        _id_3B55819C1EBEC007 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_3C2C9813BB16552F", _id_659F734FC2A248FF));
        _id_3B3077EE39BDCD6F = _func_40FD49171FAD19D3(_id_659F734FC2A248FF);

        if(isDefined(_id_3B55819C1EBEC007) && !isDefined(level._id_8DD253609D606F1C[_id_3B3077EE39BDCD6F]))
          level._id_8DD253609D606F1C[_id_3B3077EE39BDCD6F] = _id_3B55819C1EBEC007.lootid;
      }
    }
  }
}

_id_693E108CB61CEEB5(weaponname, _id_251FC0CE44D0B66D) {
  if(isDefined(level.weaponattachments[_id_251FC0CE44D0B66D]))
    return level.weaponattachments[_id_251FC0CE44D0B66D];

  return _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_251FC0CE44D0B66D);
}

buildweaponrootlist() {
  _id_B1AEF3DF89C0A092 = [];

  foreach(weapon, data in level.weaponmapdata) {
    if(isDefined(data.group)) {
      if(!issubstr(data.group, "weapon_")) {
        continue;
      }
      if(data.group == "weapon_other") {
        continue;
      }
      _id_B1AEF3DF89C0A092[_id_B1AEF3DF89C0A092.size] = weapon;
    }
  }

  return _id_B1AEF3DF89C0A092;
}

weaponattachcustomtoidmap(_id_4BB9768282D4260D, variantid) {
  if(isDefined(variantid) && variantid >= 0) {
    _id_928C1CAC31EA99E5 = _id_4BB9768282D4260D + "|" + variantid;

    if(getDvar("iw9_blueprints", "1") == "1") {
      if(isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5]) && isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachdefaulttoidmap))
        return level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachdefaulttoidmap;
    } else if(isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5]) && isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachcustomtoidmap))
      return level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachcustomtoidmap;
  }

  return undefined;
}

weaponattachdefaulttoidmap(_id_4BB9768282D4260D, variantid) {
  if(isDefined(variantid)) {
    _id_928C1CAC31EA99E5 = _id_4BB9768282D4260D + "|" + variantid;

    if(isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5]) && isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachdefaulttoidmap))
      return level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachdefaulttoidmap;
  }

  attachdefaulttoidmap = _id_792BACB194F6F862(_id_4BB9768282D4260D);

  if(isDefined(attachdefaulttoidmap))
    return attachdefaulttoidmap;

  return undefined;
}

weaponassetnamemap(_id_4BB9768282D4260D, variantid) {
  if(iskillstreakweapon(_id_4BB9768282D4260D))
    return _id_4BB9768282D4260D;

  if(isDefined(variantid)) {
    _id_B40B03D6BDC699B3 = _id_4BB9768282D4260D + "|" + variantid;

    if(isDefined(level.weaponlootmapdata[_id_B40B03D6BDC699B3]) && isDefined(level.weaponlootmapdata[_id_B40B03D6BDC699B3].assetoverridename))
      return level.weaponlootmapdata[_id_B40B03D6BDC699B3].assetoverridename;
  }

  if(isDefined(level.weaponmapdata[_id_4BB9768282D4260D]) && isDefined(level.weaponmapdata[_id_4BB9768282D4260D].assetname))
    return level.weaponmapdata[_id_4BB9768282D4260D].assetname;

  return _id_4BB9768282D4260D;
}

weapongroupmap(_id_4BB9768282D4260D) {
  if(isDefined(level.weaponmapdata[_id_4BB9768282D4260D]) && isDefined(level.weaponmapdata[_id_4BB9768282D4260D].group))
    return level.weaponmapdata[_id_4BB9768282D4260D].group;

  return undefined;
}

_id_89497FA763D431C0(_id_4BB9768282D4260D) {
  return isDefined(level.weaponmapdata[_id_4BB9768282D4260D]);
}

attachmentmap_extratovariantid(attachment, _id_4BB9768282D4260D, _id_FEDB77AAD2340743, _id_27040FD5EA255709) {
  _id_B40B03D6BDC699B3 = _id_4BB9768282D4260D + "|" + _id_FEDB77AAD2340743;

  if(isDefined(level.weaponlootmapdata[_id_B40B03D6BDC699B3]) && isDefined(_id_27040FD5EA255709) && _id_27040FD5EA255709 > 0)
    return _id_27040FD5EA255709;

  return 0;
}

buildweaponmap() {
  level.weaponmapdata = [];
  level.weapongroupdata = [];
  level.weaponlootmapdata = [];
  _id_0D2CA933F911B449 = _id_A221D76594EF4E8B();

  if(isDefined(_id_0D2CA933F911B449)) {
    foreach(weaponname in _id_0D2CA933F911B449) {
      _id_255E0DF33FAE6D5A = _id_8477D8595E0364A7(weaponname, ["stat_89E9C01960F4C582", "stat_DC57E42946F6E08C", "stat_E4FB3C98AEEAB347", "stat_C93B8EBCC208569B", "stat_C4BCADBA8E631B86", "stat_DFC4700DD7103CFD", "stat_BAA7982E38A124A2", "stat_1469D2B702A6D5F8", "stat_8028887F70BF5EBA", "stat_6C8515CD09624E5E", "stat_0119F70B4890BEFD"]);
      weapon = _id_255E0DF33FAE6D5A.ref;

      if(weapon != "") {
        level.weaponmapdata[weapon] = spawnStruct();
        group = _id_255E0DF33FAE6D5A.group;

        if(isDefined(group) && group != "") {
          level.weaponmapdata[weapon].group = group;
          _id_E3155B636CBA8EB9 = _id_255E0DF33FAE6D5A._id_5C13787574AA28DB;

          if(isDefined(_id_E3155B636CBA8EB9) && _id_E3155B636CBA8EB9 > -1) {
            if(!isDefined(level.weapongroupdata[group]))
              level.weapongroupdata[group] = [];

            level.weapongroupdata[group][level.weapongroupdata[group].size] = weapon;
          } else
            level.weaponmapdata[weapon].uihidden = 1;
        }

        assetname = _id_255E0DF33FAE6D5A._id_0DC609EF4988D3EF;

        if(isDefined(assetname) && assetname != "")
          level.weaponmapdata[weapon].assetname = assetname;

        locname = _id_255E0DF33FAE6D5A.name;

        if(isDefined(locname) && locname != &"")
          level.weaponmapdata[weapon].locname = locname;

        perk = _id_255E0DF33FAE6D5A.perk;

        if(isDefined(perk) && perk != "")
          level.weaponmapdata[weapon].perk = perk;

        level.weaponmapdata[weapon]._id_904C82687DDFEB02 = _id_255E0DF33FAE6D5A.lootid;
        movespeed = _id_255E0DF33FAE6D5A._id_BFF2A7822F594386;

        if(isDefined(movespeed))
          level.weaponmapdata[weapon].speed = movespeed;

        _id_D43F9C4F6B647BA4 = _id_255E0DF33FAE6D5A._id_D43F9C4F6B647BA4;

        if(isDefined(_id_D43F9C4F6B647BA4))
          level.weaponmapdata[weapon]._id_D43F9C4F6B647BA4 = _id_D43F9C4F6B647BA4;

        _id_E56BF18451002522 = _id_255E0DF33FAE6D5A._id_BCE1CF9927E810F2;

        if(isDefined(_id_E56BF18451002522))
          level.weaponmapdata[weapon]._id_E56BF18451002522 = strtok(_id_E56BF18451002522, "|");

        _id_B883CC44C69244CA = _id_255E0DF33FAE6D5A._id_EBA498255A3E0031;

        if(isDefined(_id_B883CC44C69244CA))
          level.weaponmapdata[weapon]._id_B883CC44C69244CA = _id_B883CC44C69244CA;

        if(_id_56F6E04546B058F7(weapon))
          level.weaponmapdata[weapon]._id_56F6E04546B058F7 = 1;

        if(isDefined(level.weaponmapdata[weapon].group) && (!isDefined(level.weaponmapdata[weapon].uihidden) || isDefined(level.gametype) && level.gametype == "br") || isDefined(level.weaponmapdata[weapon]) && istrue(level.weaponmapdata[weapon]._id_56F6E04546B058F7)) {
          _id_1092BC40C58C1C9A = 0;
          _id_928C1CAC31EA99E5 = weapon + "|" + _id_1092BC40C58C1C9A;
          level.weaponlootmapdata[_id_928C1CAC31EA99E5] = spawnStruct();
          level.weaponlootmapdata[_id_928C1CAC31EA99E5].variantid = _id_1092BC40C58C1C9A;
          level.weaponlootmapdata[_id_928C1CAC31EA99E5].lootid = _id_255E0DF33FAE6D5A.lootid;
          attachdefaulttoidmap = _id_792BACB194F6F862(weapon);

          if(isDefined(attachdefaulttoidmap))
            level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachdefaulttoidmap = attachdefaulttoidmap;

          _id_7925C6D018606A61 = _func_BB92A5000082832A(level.weaponmapdata[weapon].assetname);

          if(isDefined(_id_7925C6D018606A61)) {
            foreach(_id_9DA910194DABEABE, _id_FEDB77AAD2340743 in _id_7925C6D018606A61) {
              _id_928C1CAC31EA99E5 = weapon + "|" + _id_FEDB77AAD2340743;
              level.weaponlootmapdata[_id_928C1CAC31EA99E5] = spawnStruct();
              level.weaponlootmapdata[_id_928C1CAC31EA99E5].variantid = _id_FEDB77AAD2340743;
              _id_B59C0BABA823053C = _func_332B73D2ECA8C367(level.weaponmapdata[weapon].assetname, _id_9DA910194DABEABE);
              level.weaponlootmapdata[_id_928C1CAC31EA99E5].lootid = _id_B59C0BABA823053C.lootid;
              level.weaponlootmapdata[_id_928C1CAC31EA99E5]._id_9ADCB8BEA879F6C0 = _id_B59C0BABA823053C._id_2DA3D71EB40EA685;
              attachdefaulttoidmap = _func_3211981142EC5AEE(level.weaponmapdata[weapon].assetname, _id_9DA910194DABEABE);

              if(isDefined(attachdefaulttoidmap))
                level.weaponlootmapdata[_id_928C1CAC31EA99E5].attachdefaulttoidmap = attachdefaulttoidmap;
            }
          }
        }
      }
    }
  }
}

_id_EE4A536A155313B7() {
  level._id_305637ED4E3E8513 = [];

  if(getdvarint("dvar_D5C6A9526FC3F978", 0) != 0)
    _id_4E536400FECD2A19 = getscriptbundle("camolist:mgl_camos");
  else
    _id_4E536400FECD2A19 = getscriptbundle("camolist:iw9_camos");

  foreach(camoname in _id_4E536400FECD2A19._id_AE30266B61809E7A) {
    if(!isDefined(camoname._id_1AE3A63ED6578D45)) {
      continue;
    }
    category = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_1345CC24140E89B8", camoname._id_1AE3A63ED6578D45), "stat_1A86D464182EDEB5");

    if(isDefined(category) && category == "camo_category_completion") {
      _id_5CFF225355038142 = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_1345CC24140E89B8", camoname._id_1AE3A63ED6578D45), "stat_89E9C01960F4C582");
      weaponref = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_1345CC24140E89B8", camoname._id_1AE3A63ED6578D45), "stat_E60F47DF1CFBB466");
      lootid = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_1345CC24140E89B8", camoname._id_1AE3A63ED6578D45), "stat_8028887F70BF5EBA");

      if(isDefined(weaponref)) {
        if(!isDefined(level._id_305637ED4E3E8513[weaponref]))
          level._id_305637ED4E3E8513[weaponref] = [];

        level._id_305637ED4E3E8513[weaponref][_id_5CFF225355038142] = lootid;
      }

      continue;
    }

    if(isDefined(category) && category == "camo_category_events") {
      _id_5CFF225355038142 = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_1345CC24140E89B8", camoname._id_1AE3A63ED6578D45), "stat_89E9C01960F4C582");
      weaponclass = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_1345CC24140E89B8", camoname._id_1AE3A63ED6578D45), "stat_B94259E0A6DAC8AB");
      lootid = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_1345CC24140E89B8", camoname._id_1AE3A63ED6578D45), "stat_8028887F70BF5EBA");

      if(isDefined(weaponclass)) {
        if(!isDefined(level._id_305637ED4E3E8513[weaponclass]))
          level._id_305637ED4E3E8513[weaponclass] = [];

        level._id_305637ED4E3E8513[weaponclass][_id_5CFF225355038142] = lootid;
      }
    }
  }
}

getweaponvarianttablename(_id_49E6EF3EDADD524E) {
  if(scripts\engine\utility::string_starts_with(_id_49E6EF3EDADD524E, "iw8_") || scripts\engine\utility::string_starts_with(_id_49E6EF3EDADD524E, "iw9_") || scripts\engine\utility::string_starts_with(_id_49E6EF3EDADD524E, "t10_"))
    _id_49E6EF3EDADD524E = getsubstr(_id_49E6EF3EDADD524E, 4);

  return "mp/gunsmith/" + _id_49E6EF3EDADD524E + "_variants.csv";
}

_id_792BACB194F6F862(weapon) {
  assetname = _id_072376783A92BE46(weapon);

  if(!isDefined(assetname))
    assetname = weapon;

  attachments = _func_6527364C1ECCA6C6(assetname);

  if(isDefined(attachments) && attachments.size > 0) {
    _id_F957368A964A7504 = [];

    foreach(attachment in attachments)
    _id_F957368A964A7504[attachment] = 0;

    return _id_F957368A964A7504;
  }

  return undefined;
}

parseattachdefaulttoidmap(_id_20145D1269BCFF3E) {
  if(_id_20145D1269BCFF3E != "") {
    _id_FA85F42B307080F2 = strtok(_id_20145D1269BCFF3E, " ");
    _id_F957368A964A7504 = [];

    foreach(_id_1CC7C9040CC89B48 in _id_FA85F42B307080F2) {
      _id_CBF22C9EDB76E72D = strtok(_id_1CC7C9040CC89B48, "|");

      if(_id_CBF22C9EDB76E72D.size == 2) {
        _id_F957368A964A7504[_id_CBF22C9EDB76E72D[0]] = int(_id_CBF22C9EDB76E72D[1]);
        continue;
      }

      _id_F957368A964A7504[_id_CBF22C9EDB76E72D[0]] = 0;
    }

    return _id_F957368A964A7504;
  }

  return undefined;
}

_id_072376783A92BE46(_id_AB501F397D3CD312) {
  if(isDefined(level.weaponmapdata[_id_AB501F397D3CD312]) && isDefined(level.weaponmapdata[_id_AB501F397D3CD312].assetname))
    return level.weaponmapdata[_id_AB501F397D3CD312].assetname;

  return undefined;
}

getweaponrootname(weapon) {
  if(!isDefined(level.weaponrootcache))
    level.weaponrootcache = [];

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  if(!isDefined(weaponname) || weaponname == "")
    weaponname = "none";

  _id_93AB397A467E3DD4 = level.weaponrootcache[weaponname];

  if(isDefined(_id_93AB397A467E3DD4))
    return _id_93AB397A467E3DD4;

  _id_7E8CE070B59848FD = weaponname;
  _id_67F14F8315CB0F2F = strtok(weaponname, "_");
  index = 0;

  if(_id_67F14F8315CB0F2F[0] == "alt")
    index++;

  if(_id_67F14F8315CB0F2F[index] == "iw8" || _id_67F14F8315CB0F2F[index] == "iw9" || _id_67F14F8315CB0F2F[index] == "t10" || _id_67F14F8315CB0F2F[index] == "jup") {
    _id_C0BB28E7846054F1 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "br"];

    if(_id_67F14F8315CB0F2F[index] == "jup" && isDefined(_id_67F14F8315CB0F2F[index + 2]) && scripts\engine\utility::array_contains(_id_C0BB28E7846054F1, _id_67F14F8315CB0F2F[index + 2]))
      weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1] + "_" + _id_67F14F8315CB0F2F[index + 2] + "_" + _id_67F14F8315CB0F2F[index + 3];
    else if(isDefined(_id_67F14F8315CB0F2F[index + 1]) && scripts\engine\utility::array_contains(_id_C0BB28E7846054F1, _id_67F14F8315CB0F2F[index + 1])) {
      if(_id_67F14F8315CB0F2F.size >= index + 4 && (_id_67F14F8315CB0F2F[index] == "t10" || _id_67F14F8315CB0F2F[index] == "jup"))
        weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1] + "_" + _id_67F14F8315CB0F2F[index + 2] + "_" + _id_67F14F8315CB0F2F[index + 3];
      else
        weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1] + "_" + _id_67F14F8315CB0F2F[index + 2];
    } else
      weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1];
  }

  if(level.weaponrootcache.size < 100)
    level.weaponrootcache[_id_7E8CE070B59848FD] = weaponname;

  return weaponname;
}

_id_0C9AF9FE37668DF2(weaponname) {
  _id_69F2F897B16483FD[0] = strtok(weaponname, "_")[1];
  _id_69F2F897B16483FD[1] = strtok(weaponname, "_")[2];

  foreach(_id_4CA4894D70478CEE in _id_69F2F897B16483FD) {
    if(!isDefined(_id_4CA4894D70478CEE)) {
      continue;
    }
    switch (_id_4CA4894D70478CEE) {
      case "kn":
      case "pi":
      case "dm":
      case "sn":
      case "sh":
      case "lm":
      case "sm":
      case "ar":
      case "me":
      case "la":
      case "br":
        return _id_4CA4894D70478CEE;
    }
  }

  return undefined;
}

attachmentiscosmetic(attachment) {
  return isDefined(attachment) && scripts\engine\utility::string_starts_with(attachment, "cos_");
}

issilencerattach(weapon, attachment) {
  return _func_1074E46972C88A69(weapon, attachment);
}

combinedefaultandcustomattachmentidmaps(_id_3F065AF353909441, _id_91BBF8D2294A656E) {
  _id_820A92B1182AE83E = [];

  foreach(key, value in _id_3F065AF353909441) {
    if(scripts\engine\utility::array_contains_key(_id_91BBF8D2294A656E, key)) {
      continue;
    }
    _id_820A92B1182AE83E[key] = value;
  }

  foreach(key, value in _id_91BBF8D2294A656E)
  _id_820A92B1182AE83E[key] = value;

  return _id_820A92B1182AE83E;
}

filterinvalidattachmentsfromidmap(_id_F44F790EFDADEEA0, _id_C7BD95B10C89CFF8, weaponobj) {
  _id_3AA0E5FBCA9E041C = [];

  foreach(attachment, _id_27040FD5EA255709 in _id_F44F790EFDADEEA0) {
    if(weaponobj canuseattachment(attachment)) {
      _id_3AA0E5FBCA9E041C[attachment] = _id_27040FD5EA255709;
      continue;
    }
  }

  return _id_3AA0E5FBCA9E041C;
}

weaponsupportslaserir(_id_5C3F9357F11D2223, weaponobj) {
  switch (_id_5C3F9357F11D2223) {
    case "iw9_minigunksjugg_reload_mp":
    case "iw9_minigunksjugg_mp":
    case "iw9_lm_dblmg2_cp":
    case "iw9_lm_dblmg_mp":
    case "iw9_lm_dblmg_execution_mp":
    case "iw9_lm_dblmg_jailer_mp":
      return 0;
  }

  if(iskillstreakweapon(_id_5C3F9357F11D2223))
    return 0;

  if(isDefined(weaponobj) && isDefined(weaponobj.extra) && weaponobj.extra == "charlie725_doom_blueprint_tuning")
    return 0;

  class = weaponclass(_id_5C3F9357F11D2223);
  return class == "rifle" || class == "mg" || class == "sniper" || class == "smg" || class == "spread";
}

_id_E8B81323119C2572(weapon) {
  _id_671F8321B1420D22 = 0;
  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon))
    _id_C27E2A04BAB78C1F = weapon.basename;
  else {
    _id_C27E2A04BAB78C1F = _id_072376783A92BE46(weapon);

    if(!isDefined(_id_C27E2A04BAB78C1F))
      _id_C27E2A04BAB78C1F = weapon;
  }

  if(issubstr(_id_C27E2A04BAB78C1F, "_mp")) {
    if(iskillstreakweapon(_id_C27E2A04BAB78C1F) && isminigunweapon(_id_C27E2A04BAB78C1F))
      _id_671F8321B1420D22 = 1;
  }

  return _id_671F8321B1420D22;
}

_id_417760651C48814B(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(!isstring(weapon))
    weapon = weapon.basename;

  if(_id_602A4626CABC6981(weapon))
    return 1;

  if(!isDefined(level.superglobals) || !isDefined(level.superglobals.superweapons) || !isDefined(level.superglobals.superweapons[weapon]))
    return undefined;

  return isDefined(level.superglobals.superweapons[weapon]);
}

_id_6C51B05CE2E9AED3(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else {
    weaponname = _id_072376783A92BE46(weapon);

    if(!isDefined(weaponname))
      weaponname = weapon;
  }

  switch (weaponname) {
    case "tempv_mp":
    case "emp_pulse_device_mp":
    case "electric_discharge_mp":
    case "battlerage_nebulizer_mp":
      return 1;
  }

  return 0;
}

_id_602A4626CABC6981(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(!isstring(weapon))
    weapon = weapon.basename;

  switch (weapon) {
    case "iw9_pi_stimpistol_mp":
    case "iw9_oxygenmask_mp":
      return 1;
    default:
      return 0;
  }
}

_id_03DE73A849ECEA0D(weapon) {
  if(!isDefined(weapon))
    return 0;

  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    _id_C27E2A04BAB78C1F = weapon.basename;
  } else {
    if(weapon == "none")
      return 0;

    _id_C27E2A04BAB78C1F = weapon;
  }

  return _id_C27E2A04BAB78C1F == "iw9_oxygenmask" || _id_C27E2A04BAB78C1F == "iw9_oxygenmask_mp";
}

isminigunweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    _id_C27E2A04BAB78C1F = weapon.basename;
  } else {
    if(weapon == "none")
      return 0;

    _id_C27E2A04BAB78C1F = weapon;
  }

  return _id_C27E2A04BAB78C1F == "iw9_minigunksjugg_mp" || _id_C27E2A04BAB78C1F == "iw9_minigunksjugg_reload_mp" || _id_C27E2A04BAB78C1F == "iw8_lm_dblmg_mp" || _id_C27E2A04BAB78C1F == "iw9_lm_dblmg_mp" || _id_C27E2A04BAB78C1F == "iw9_lm_dblmg2_cp";
}

iskillstreakweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else {
    weaponname = _id_072376783A92BE46(weapon);

    if(!isDefined(weaponname))
      weaponname = weapon;
  }

  if(isDefined(level.killstreakweaponmap) && isDefined(level.killstreakweaponmap[weaponname]))
    return 1;

  return 0;
}

_id_F30B8F5EE8F3E7F8(streakname, _id_D8A64ED9BCDF7185) {
  if(!isDefined(level.killstreakweaponmap))
    level.killstreakweaponmap = [];

  level.killstreakweaponmap[_id_D8A64ED9BCDF7185] = streakname;
}

_id_B4B623B6321CD521() {
  if(!isDefined(level.killstreakweaponmap))
    level.killstreakweaponmap = [];

  level.killstreakweaponmap["tacops_beacon_mp"] = "marker";
  level.killstreakweaponmap["radar_drone_proj_mp"] = "radar_drone_recon";
  level.killstreakweaponmap["gunship_105mm_mp"] = "gunship";
  level.killstreakweaponmap["manual_turret_mp"] = "manual_turret";
  level.killstreakweaponmap["nuke_mp"] = "nuke";
  level.killstreakweaponmap["artillery_mp"] = "precision_airstrike";
  level.killstreakweaponmap["iw9_spotter_scope_mp"] = "precision_airstrike";
  level.killstreakweaponmap["deploy_airdrop_mp"] = "airdrop";
  level.killstreakweaponmap["deploy_airdrop_sticky_mp"] = "airdrop";
  level.killstreakweaponmap["nuke_multi_mp"] = "nuke_multi";
  level.killstreakweaponmap["cruise_proj_mp"] = "cruise_predator";
  level.killstreakweaponmap["pac_sentry_turret_mp"] = "pac_sentry";
  level.killstreakweaponmap["toma_proj_mp"] = "toma_strike";
  level.killstreakweaponmap["iw9_laser_large_ir_mp"] = "toma_strike";
  level.killstreakweaponmap["chopper_gunner_turret_mp"] = "chopper_gunner";
  level.killstreakweaponmap["chopper_gunner_proj_mp"] = "chopper_gunner";
  level.killstreakweaponmap["chopper_gunner_turret_cp"] = "chopper_gunner";
  level.killstreakweaponmap["chopper_gunner_proj_cp"] = "chopper_gunner";
  level.killstreakweaponmap["gunship_25mm_mp"] = "gunship";
  level.killstreakweaponmap["gunship_40mm_mp"] = "gunship";
  level.killstreakweaponmap["gunship_hellfire_mp"] = "gunship";
  level.killstreakweaponmap["fuelstrike_proj_mp"] = "fuel_airstrike";
  level.killstreakweaponmap["chopper_support_turret_mp"] = "chopper_support";
  level.killstreakweaponmap["chopper_support_turret_br"] = "chopper_support";
  level.killstreakweaponmap["deploy_sentry_mp"] = "sentry_gun";
  level.killstreakweaponmap["sentry_turret_mp"] = "sentry_gun";
  level.killstreakweaponmap["hover_jet_turret_mp"] = "hover_jet";
  level.killstreakweaponmap["hover_jet_proj_mp"] = "hover_jet";
  level.killstreakweaponmap["hover_jet_bomb_mp"] = "hover_jet";
  level.killstreakweaponmap["iw9_minigunksjugg_mp"] = "juggernaut";
  level.killstreakweaponmap["iw9_minigunksjugg_reload_mp"] = "juggernaut";
  level.killstreakweaponmap["deploy_juggernaut_mp"] = "juggernaut";
  level.killstreakweaponmap["assault_drone_mp"] = "assault_drone";
  level.killstreakweaponmap["assault_drone_danger_mp"] = "assault_drone";
  level.killstreakweaponmap["auto_drone_proj_mp"] = "auto_drone";
  level.killstreakweaponmap["cluster_spike_mp"] = "cluster_spike";
  level.killstreakweaponmap["cluster_spike_proj_mp"] = "cluster_spike";
  level.killstreakweaponmap["airdrop_escort_turret_mp"] = "airdrop_escort";
  level.killstreakweaponmap["super_laser_charge_mp"] = "super_laser_charge";
  level.killstreakweaponmap["electric_discharge_mp"] = "super_electric_discharge";
  level.killstreakweaponmap["high_jump_mp"] = "super_high_jump";
  level.killstreakweaponmap["airdrop_escort_turret_ballistics_mp"] = "airdrop_escort";
  level.killstreakweaponmap["chopper_gunner_turret_ballistics_mp"] = "chopper_gunner";
  level.killstreakweaponmap["hover_jet_turret_ballistics_mp"] = "hover_jet";
}

_id_1A9394EB58E66A9B(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else {
    weaponname = _id_072376783A92BE46(weapon);

    if(!isDefined(weaponname))
      weaponname = weapon;
  }

  if(isDefined(level.killstreakweaponmap) && isDefined(level.killstreakweaponmap[weaponname])) {
    switch (weaponname) {
      case "electric_discharge_mp":
      case "high_jump_mp":
      case "super_laser_charge_mp":
        return 1;
    }
  }

  return 0;
}

_id_AEA26B825F926E9C(weapon, _id_659F734FC2A248FF) {
  if(_id_659F734FC2A248FF == "none")
    return 1;

  if(!isDefined(weapon) || isstring(weapon) && (weapon == "none" || weapon == ""))
    return 0;

  _id_AB501F397D3CD312 = getweaponrootname(weapon);
  weaponasset = weaponassetnamemap(_id_AB501F397D3CD312);
  weaponattachments = _id_91D352B50D9A0630(weaponasset);
  _id_0CF52C7D54D715D8 = _func_4ADD228B999C26AA(weaponasset, _id_659F734FC2A248FF);
  _id_18F0A5759A8E40D9 = weaponattachments[_id_0CF52C7D54D715D8];

  if(isDefined(_id_18F0A5759A8E40D9) && scripts\engine\utility::array_contains(_id_18F0A5759A8E40D9, _id_659F734FC2A248FF))
    return 1;

  return 0;
}

_id_6E7BC1B23AFA0EA8(weapon, _id_10DC579C373A93DD) {
  if(_id_AEA26B825F926E9C(weapon, _id_10DC579C373A93DD))
    return _id_10DC579C373A93DD;
  else {
    _id_AB501F397D3CD312 = getweaponrootname(weapon);
    weaponasset = weaponassetnamemap(_id_AB501F397D3CD312);
    return _func_667F43CE2EE5B5DD(weaponasset, "receiver", 0);
  }
}

buildweaponattachmentidmap(attachments, _id_F3464D71F01F614E) {
  _id_91BBF8D2294A656E = [];

  foreach(_id_FE8F7703F6313ED4, a in attachments) {
    if(isDefined(_id_F3464D71F01F614E) && _id_FE8F7703F6313ED4 < _id_F3464D71F01F614E.size) {
      _id_91BBF8D2294A656E[a] = _id_F3464D71F01F614E[_id_FE8F7703F6313ED4];
      continue;
    }

    _id_91BBF8D2294A656E[a] = 0;
  }

  return _id_91BBF8D2294A656E;
}

getweaponnvgattachment(weaponobj) {
  _id_7EFCEF2AB37C2C45 = ["laserir_box", "laserir_cyl", "laserir_pstl"];

  foreach(attachment in _id_7EFCEF2AB37C2C45) {
    if(weaponobj canuseattachment(attachment))
      return attachment;
  }

  return "invalid";
}

_id_623AF97AE297F796() {
  _id_3A974E1DFD9D5CCC = [];
  _id_977F24E61599CBBA = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(index = 0; index < _id_977F24E61599CBBA; index++) {
    _id_659F734FC2A248FF = tablelookupbyrow("mp/attachmenttable.csv", index, 4);

    if(_id_659F734FC2A248FF == "") {
      continue;
    }
    _id_3A974E1DFD9D5CCC[_id_659F734FC2A248FF] = _id_659F734FC2A248FF;
  }

  return _id_3A974E1DFD9D5CCC;
}

getreticleindex(_id_763BF17ADB1939E4) {
  if(!isDefined(_id_763BF17ADB1939E4))
    return undefined;

  _id_7CD7A4C761684176 = int(tablelookup("mp/reticleTable.csv", 1, _id_763BF17ADB1939E4, 5));

  if(!isDefined(_id_7CD7A4C761684176) || _id_7CD7A4C761684176 == 0)
    return undefined;

  return _id_7CD7A4C761684176;
}

_id_591EBA85202CFEB5() {
  if(!isDefined(level._id_51A85DF6511FB7E7)) {
    if(isDefined(level._id_1A2B600A06EC21F4))
      level._id_51A85DF6511FB7E7 = level._id_1A2B600A06EC21F4._id_DDAED03EBCC9CCF9;
  }

  return level._id_51A85DF6511FB7E7;
}

_id_A221D76594EF4E8B() {
  if(isDefined(level._id_4A2A11B7C5A0AF01))
    return level._id_4A2A11B7C5A0AF01;

  _id_95E750BC139E9DA9 = _func_811510B694DDD963();

  if(isDefined(_id_95E750BC139E9DA9) && isDefined(_id_95E750BC139E9DA9._id_A090981B133743B9)) {
    _id_4A2A11B7C5A0AF01 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_7ECCB7F3E167E22B", _id_95E750BC139E9DA9._id_A090981B133743B9));

    if(isDefined(_id_4A2A11B7C5A0AF01) && isDefined(_id_4A2A11B7C5A0AF01.weapons)) {
      level._id_4A2A11B7C5A0AF01 = [];

      foreach(index, struct in _id_4A2A11B7C5A0AF01.weapons) {
        if(isDefined(struct) && isDefined(struct._id_BAE77D8848F4D84D))
          level._id_4A2A11B7C5A0AF01[index] = struct._id_BAE77D8848F4D84D;
      }

      return level._id_4A2A11B7C5A0AF01;
    }
  }
}

_id_8477D8595E0364A7(weapon, keys) {
  return _func_50F8A8F765BAD85E(_func_2EF675C13CA1C4AF("enum_31705BF9ED477170", weapon), keys);
}

_id_A622D54BB517923A(attachment, keys) {
  return _func_50F8A8F765BAD85E(_func_2EF675C13CA1C4AF("enum_3C2C9813BB16552F", attachment), keys);
}

_id_B8811A0FC04E4B9D(weapon, key, def) {
  value = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_31705BF9ED477170", weapon), key);

  if(!isDefined(value))
    return def;

  return value;
}

_id_91D352B50D9A0630(weapon) {
  _id_6DF1FDD78EB73A36 = _id_C471A035D22DF5EB();
  _id_AC82E189F4D06152 = [];

  foreach(slot in _id_6DF1FDD78EB73A36) {
    _id_63A235C3E361A6C3 = _func_75B035199842693D(weapon, slot);
    _id_AC82E189F4D06152[slot] = _id_63A235C3E361A6C3;
  }

  return _id_AC82E189F4D06152;
}

_id_C471A035D22DF5EB() {
  if(!isDefined(level._id_C7008CFF883CD615)) {
    level._id_C7008CFF883CD615 = [];
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "frontpiece";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "backpiece";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "magazine";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "override";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "muzzle";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "reargrip";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "trigger";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "extra";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "scope";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "underbarrel";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "modifier";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "visual";
    level._id_C7008CFF883CD615[level._id_C7008CFF883CD615.size] = "other";
  }

  return level._id_C7008CFF883CD615;
}

_id_5419AC7173288FC1(weapon) {
  weaponname = weapon.basename;

  if(!isDefined(weaponname))
    return 0;

  currentweapon = 0;

  switch (weaponname) {
    case "super_remote_map_mp":
    case "ks_remote_map_mp":
      currentweapon = 1;
      break;
  }

  return currentweapon;
}

_id_ADA582163D1ACA5E(weapon) {
  weaponname = weapon.basename;

  if(!isDefined(weaponname))
    return 0;

  currentweapon = 0;

  switch (weaponname) {
    case "super_remote_device_mp":
    case "ks_remote_device_mp":
      currentweapon = 1;
      break;
  }

  return currentweapon;
}

_id_AA8B0F148CA930AA(weapon) {
  weaponname = weapon.basename;

  if(!isDefined(weaponname))
    return 0;

  return weaponname == "super_remote_map_mp";
}

_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid) {
  _id_928C1CAC31EA99E5 = _id_AB501F397D3CD312 + "|" + variantid;

  if(isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5]) && isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5].lootid))
    return level.weaponlootmapdata[_id_928C1CAC31EA99E5].lootid;

  return 0;
}

_id_115404A4DBD59830(_id_AB501F397D3CD312, variantid) {
  if(!isDefined(variantid))
    variantid = 0;

  _id_928C1CAC31EA99E5 = _id_AB501F397D3CD312 + "|" + variantid;

  if(isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5]) && isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5]._id_9ADCB8BEA879F6C0))
    return level.weaponlootmapdata[_id_928C1CAC31EA99E5]._id_9ADCB8BEA879F6C0;

  return 0;
}

_id_9C331F88BE5A1478(weapon) {
  variantid = 0;
  _id_AB501F397D3CD312 = getweaponrootname(weapon);

  if(isDefined(weapon.variantid))
    variantid = weapon.variantid;

  return _id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);
}

_id_B0D37B9BE0027733(customweaponname) {
  _id_AB501F397D3CD312 = getweaponrootname(customweaponname);
  ref = _id_AB501F397D3CD312;
  return _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);
}

_id_98BAC17512F9C622(weapon) {
  _id_904C82687DDFEB02 = 0;
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  if(isDefined(weaponname)) {
    _id_49E6EF3EDADD524E = getweaponrootname(weaponname);

    if(isDefined(level.weaponmapdata[_id_49E6EF3EDADD524E]) && isDefined(level.weaponmapdata[_id_49E6EF3EDADD524E]._id_904C82687DDFEB02))
      _id_904C82687DDFEB02 = level.weaponmapdata[_id_49E6EF3EDADD524E]._id_904C82687DDFEB02;
  }

  return _id_904C82687DDFEB02;
}

_id_89A83AE9A4C4142A(weapon) {
  if(getdvarint("dvar_8F727124CB64AE24", 1) == 1) {
    _id_904C82687DDFEB02 = _id_98BAC17512F9C622(weapon);

    if(_id_904C82687DDFEB02 != 0)
      return _id_904C82687DDFEB02;
  }

  if(!isDefined(level._id_A6A25CF55FD9CB30))
    level._id_A6A25CF55FD9CB30 = [];

  weaponname = _id_C2BC8497963042D5(weapon);

  if(!isDefined(weaponname))
    return 0;

  if(isDefined(level._id_A6A25CF55FD9CB30[weaponname]))
    return level._id_A6A25CF55FD9CB30[weaponname];

  id = tablelookup("loot/special_weapon_ids.csv", 1, weaponname, 0);

  if(!isDefined(id) || id == "0" || id == "")
    return 0;

  id = int(id);

  if(isDefined(id)) {
    level._id_A6A25CF55FD9CB30[weaponname] = id;
    return id;
  }

  return _id_9C331F88BE5A1478(weapon);
}

_id_C2BC8497963042D5(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "iw9_tur_mrap_mp":
    case "iw9_mg_mrap_mp":
      weaponname = "iw9_tur_mrap_mp";
      break;
    case "iw9_mg_patrol_boat_back_mp":
    case "iw9_mg_patrol_boat_front_mp":
      weaponname = "iw9_mg_patrol_boat_front_mp";
      break;
    case "iw9_mg_cougar_mp":
    case "iw9_tur_cougar_mp":
      weaponname = "iw9_tur_cougar_mp";
      break;
  }

  return weaponname;
}

getgrenadeinpullback() {
  offhandweapon = self getheldoffhand();

  if(isDefined(self.gestureweapon) && offhandweapon == makeweaponfromstring(self.gestureweapon))
    offhandweapon = nullweapon();

  return offhandweapon;
}

_id_4652EF19CC5BBE0F(weapon) {
  return istrue(weapon.inventorytype == "offhand");
}

_id_56F6E04546B058F7(weapon) {
  if(weapon == "iw9_knifestab")
    return 1;

  return 0;
}

_id_309BCC0C19DE2D18(weapon) {
  _id_AB501F397D3CD312 = getweaponrootname(weapon);
  return level.weaponmapdata[_id_AB501F397D3CD312]._id_E56BF18451002522;
}

_id_8A96B90526C40DF6(weapon, attachments) {
  foreach(attachment in attachments) {
    if(issubstr(attachment, "laser") || issubstr(attachment, "flashlight"))
      return 0;
  }

  return 1;
}

isspreadweapon(objweapon) {
  return isDefined(objweapon) && isDefined(weaponclass(objweapon)) && weaponclass(objweapon) == "spread";
}