/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_74a406321183b21c.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, ::_id_E3D9D27A30E4D693, 2000);
}

_id_E0844A2B7F904B14(bot) {
  _id_CF5CD4F2D94252BF = bot.equipment["super"];

  if(!isDefined(_id_CF5CD4F2D94252BF))
    return 0;

  _id_7211C2F25E275C26 = "equip_munitionsbox";
  _id_A3BA12C6175CDC5F = "equip_armorbox";

  if(_id_CF5CD4F2D94252BF == _id_A3BA12C6175CDC5F) {
    _id_5324597EDFAFF57C = bot scripts\mp\equipment::getequipmentslotammo("health");

    if(isDefined(_id_5324597EDFAFF57C) && _id_5324597EDFAFF57C >= 2)
      return 0;
  } else if(_id_CF5CD4F2D94252BF == _id_7211C2F25E275C26) {
    primaryweapon = bot.primaryweaponobj;
    _id_8C25727711ED9168 = ["iw9_ar", "iw9_lm", "iw9_sn", "iw9_sm", "iw9_dm"];
    _id_6BE76F0842D9ED3F = 1;

    if(isDefined(primaryweapon) && isDefined(primaryweapon.basename)) {
      foreach(item in _id_8C25727711ED9168) {
        if(isstartstr(primaryweapon.basename, item)) {
          _id_6BE76F0842D9ED3F = 0;
          break;
        }
      }
    }

    if(_id_6BE76F0842D9ED3F)
      return 0;

    if(bot _id_40E63DD222434655::_id_813A1A6F2C5ABDDB(primaryweapon, 0.3))
      return 0;

    _id_40C280849DCE2292 = getEntArray("grenade", "classname");
    _id_2E5C1E9548E8884F = 0;

    foreach(item in _id_40C280849DCE2292) {
      issameteam = isDefined(item.team) && item.team == bot.team;
      _id_BC26A0088814DC94 = isDefined(item.weapon_name) && item.weapon_name == "support_box_mp";
      _id_A25E384B96346A66 = isDefined(item.origin) && distancesquared(bot.origin, item.origin) < self._id_E889B543C8E054AE._id_02070B5F48167A4A;

      if(issameteam && _id_BC26A0088814DC94 && _id_A25E384B96346A66) {
        _id_2E5C1E9548E8884F = 1;
        break;
      }
    }

    if(_id_2E5C1E9548E8884F)
      return 0;
  } else
    return 0;

  return self._id_E889B543C8E054AE.basescore;
}

_id_E3D9D27A30E4D693(bot) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Use field upgrade box", undefined, "main", bot.equipment["super"], ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C);
}

_id_35671B7B1A04BF58(bot) {
  bot botsetflag("disable_movement", 1);
  bot botlookatpoint(bot gettagorigin("j_mainroot"), 0.75);
  bot botpressbutton("special", 0.5);
  self._id_E042806C3ECE447A = 1;
  wait 4;
  bot botsetflag("disable_movement", 0);
  _id_C34CE1F95C70C360 = bot _id_D244CC7C3F9B8EAE();

  if(!isDefined(_id_C34CE1F95C70C360))
    return "No supply box thrown";

  targetpos = getclosestpointonnavmesh(_id_C34CE1F95C70C360.origin);
  bot _id_59FF79D681BB860C::_id_9E400058EF021B03(targetpos, 32);

  for(;;) {
    result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 5);

    if(result == "goal") {
      bot botlookatpoint(targetpos, 0.75);
      bot botpressbutton("use", 0.5);
      break;
    } else if(result != "timeout")
      return result;
  }
}

_id_F4CAAE7E8AF9D32C(action) {
  if(_id_0D74AE0B4AA21186::_id_D57DD414963503D1()) {
    if(action._id_E042806C3ECE447A)
      self.equipment["super"] = undefined;

    self botsetflag("disable_movement", 0);
  }
}

_id_D244CC7C3F9B8EAE() {
  _id_40C280849DCE2292 = getEntArray("grenade", "classname");
  _id_C34CE1F95C70C360 = undefined;

  foreach(item in _id_40C280849DCE2292) {
    if(isDefined(item.owner) && item.owner == self) {
      if(!isDefined(_id_C34CE1F95C70C360) || item._id_928E982159B87E18 > _id_C34CE1F95C70C360._id_928E982159B87E18)
        _id_C34CE1F95C70C360 = item;
    }
  }

  return _id_C34CE1F95C70C360;
}