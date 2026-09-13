/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_999840d29045e44.gsc
***********************************************/

_id_EFB8F375317A862D(params) {
  return level.br_circle.circleindex >= params.circleindex;
}

_id_21E310B9815E5699(params) {
  _id_E86632D645C137D0 = level.br_circle.dangercircleent.origin[2];
  return _id_E86632D645C137D0 > params._id_D7BFCE72F2368972;
}

_id_8721B096AE4BEE70() {
  if(_id_08FFB283F4ABC438()) {
    foreach(ally in self._id_0FFDDBA74F404A30) {
      if(istrue(ally.inlaststand))
        return 1;
    }
  }

  return 0;
}

_id_0A568DFA416DEF0B(params) {
  _id_5B25E7620E424CB2 = getentitylessscriptablearray("scriptable_br_plunder_box", "classname", self.origin, params._id_9130F52078745877);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5B25E7620E424CB2.size; _id_AC0E594AC96AA3A8++) {
    _id_2FA65F34EB9042F5 = _id_5B25E7620E424CB2[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_2FA65F34EB9042F5.visible) && _id_2FA65F34EB9042F5.visible) {
      self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_E7CEE4FBB5B46EF2 = _id_2FA65F34EB9042F5;
      self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_B02409EACE93D10F = _id_2FA65F34EB9042F5.model;
      self._id_0657F5A0D17435BC._id_0480AA6483C54887.position = _id_2FA65F34EB9042F5.origin + (0, 0, 25);
      return 1;
    }
  }

  return 0;
}

_id_F95BAEC9742916BF() {
  self._id_0657F5A0D17435BC._id_6D2384744119499A._id_835249B5749EF6CC = _id_15C10CF294641928::_id_83964876B5D39A1E();

  if(self._id_0657F5A0D17435BC._id_6D2384744119499A._id_835249B5749EF6CC.size > 0) {
    foreach(_id_835249B5749EF6CC in self._id_0657F5A0D17435BC._id_6D2384744119499A._id_835249B5749EF6CC) {
      if(isDefined(_id_835249B5749EF6CC) && _id_835249B5749EF6CC.team == self.team)
        return 1;
    }
  }

  return 0;
}

_id_44B193482FCAF1A4(params) {
  if(self._id_0657F5A0D17435BC._id_6D2384744119499A._id_835249B5749EF6CC.size > 0) {
    foreach(loadoutdrop in self._id_0657F5A0D17435BC._id_6D2384744119499A._id_835249B5749EF6CC) {
      if(isDefined(loadoutdrop)) {
        if(loadoutdrop.team == self.team && distance(loadoutdrop.origin, self.origin) <= params._id_38BB163D3F371E2B) {
          self._id_0657F5A0D17435BC._id_6D2384744119499A._id_495BB1C9678267C7 = loadoutdrop;
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_819AD84007C550D0() {
  return isDefined(self._id_0657F5A0D17435BC._id_6D2384744119499A._id_495BB1C9678267C7);
}

_id_880C8F3B2089065D() {
  return self isshooting();
}

_id_15FC0739BE906D50() {
  return !_id_880C8F3B2089065D();
}

_id_5226E5B60AF668D6(params) {
  _id_87C2A6B04DE18B12 = params._id_87C2A6B04DE18B12;
  return _id_87C2A6B04DE18B12 == self._id_0657F5A0D17435BC._id_3CEC2BC7BC141BED["GulagStarted"].isactive;
}

_id_86A11E66F57B7B07() {
  return self._id_0657F5A0D17435BC._id_3CEC2BC7BC141BED["PlayerShotByEnemy"].isactive;
}

_id_F66EBC45269B2970() {
  return !_id_86A11E66F57B7B07();
}

_id_ABFE9A8803709579(params) {
  _id_87C2A6B04DE18B12 = params._id_87C2A6B04DE18B12;
  _id_34D1B32BDCD8A27C = !_id_354A742E322499E9();

  if(getdvarint("dvar_9AD81949939066C0", 0) == 1)
    _id_34D1B32BDCD8A27C = 1;

  return _id_87C2A6B04DE18B12 == (_id_34D1B32BDCD8A27C && _id_15FC0739BE906D50() && _id_23A85A6F3340BF6F::_id_671C7049215EBC9C() && isalive(self));
}

_id_A0D0780CA5CB715D() {
  return 0;
}

_id_668450A761B15BBF() {
  if(self _meth_E69D7896FA6E5D23() && self getclientomnvar("ui_requestRedeployButton_state") > 1)
    return 1;

  return 0;
}

_id_4274D07F8BF2308B() {
  if(isDefined(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_71AFF0F17D48E44B)) {
    if(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_71AFF0F17D48E44B)
      return 1;

    return 0;
  }

  return 0;
}

_id_662D73AF81C49696() {
  if(isDefined(self._id_5A532B3D41B19C7A))
    return self._id_5A532B3D41B19C7A.size > 0;

  return 0;
}

_id_354A742E322499E9() {
  if(isDefined(self._id_802DE948F5F74D91))
    return self._id_802DE948F5F74D91.size > 0;

  return 0;
}

_id_08FFB283F4ABC438() {
  if(isDefined(self._id_0FFDDBA74F404A30))
    return self._id_0FFDDBA74F404A30.size > 0;

  return 0;
}

_id_2C8DE2B962F4FC26() {
  if(!_id_662D73AF81C49696())
    return 0;

  foreach(_id_80C53303FB317FE2 in self._id_5A532B3D41B19C7A) {
    if(isDefined(_id_80C53303FB317FE2) && _id_80C53303FB317FE2 isshooting())
      return 1;
  }

  return 0;
}

_id_FAD68735C883032B() {
  if(!_id_662D73AF81C49696())
    return 0;

  foreach(_id_80C53303FB317FE2 in self._id_5A532B3D41B19C7A) {
    if(!isalive(_id_80C53303FB317FE2)) {
      self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3.killedenemy = _id_80C53303FB317FE2;
      return 1;
    }
  }

  return 0;
}

_id_6D7CBC5DCDE6FF99() {
  if(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_AFC287EEC64AEB6E)
    return 1;

  return 0;
}

_id_0123BC3D0AA752E3(params) {
  mindistance = params.mindistance;
  maxdistance = params.maxdistance;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78.size; _id_AC0E594AC96AA3A8++) {
    _id_A122DC255EEE8CFA = getlootscriptablearrayinradius(level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[_id_AC0E594AC96AA3A8], undefined, self.origin, maxdistance);

    if(_id_A122DC255EEE8CFA.size >= 1) {
      _id_52C67624A2BB680E = _id_A122DC255EEE8CFA[0];
      dist = distance2d(_id_52C67624A2BB680E.origin, self.origin);

      if(dist >= mindistance) {
        self._id_0657F5A0D17435BC._id_9FD058151789294E._id_0D02731F86E1479E = _id_52C67624A2BB680E;
        return 1;
      }
    }
  }

  return 0;
}

_id_56BCE0DD2A67CF34(params) {
  return params._id_87C2A6B04DE18B12 == _id_2BA81D8D4F69CFAD::_id_AD5378568B077260(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_0D02731F86E1479E);
}

_id_BBD2783C3E7345FC(params) {
  return _id_0E626332AD1BD82B(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_CE7F7E62DF1E0B51, params._id_E003733BBA588F4B, self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_CE7F7E62DF1E0B51);
}

_id_7289FADA7729B540(params) {
  return _id_6DB11CEC60FC60C3(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_CE7F7E62DF1E0B51, params._id_E003733BBA588F4B, self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_CE7F7E62DF1E0B51);
}

_id_E0B7C71C5DAEB031(params) {
  return _id_0E626332AD1BD82B(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_CE7F7E62DF1E0B51, params._id_F933ABFE96DB9B2A, self._id_0657F5A0D17435BC._id_9FD058151789294E.waypoint);
}

_id_FDB35DCAA8FD2721(params) {
  _id_0746EE2B5D4B4096 = self._id_8F1C3552AEDDAFFE;

  if(params._id_F0C18E87EB4091E9)
    _id_0746EE2B5D4B4096 = self._id_0FFDDBA74F404A30;

  if(!isDefined(_id_0746EE2B5D4B4096))
    return 0;

  _id_3A8E5C380C3C79E7 = 0;

  foreach(ally in _id_0746EE2B5D4B4096) {
    if(!isalive(ally)) {
      self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_F99DDF933802D415 = ally;
      _id_3A8E5C380C3C79E7++;
    }
  }

  return _id_3A8E5C380C3C79E7 > 0 == params._id_069FC8669A623577;
}

_id_2337E40A59F43525() {
  if(!isDefined(self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_F99DDF933802D415))
    return 0;

  if(_id_23A85A6F3340BF6F::_id_BBD25202175D7F6F(self, self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_F99DDF933802D415))
    return 0;

  return 1;
}

_id_BE08A1CA7DB75F87() {
  wait 1;
  _id_D115192F0643E610 = self getcurrentprimaryweapon();

  foreach(_id_7DD111824A117DC6 in self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_C4473688E477750F) {
    if(_id_D115192F0643E610.basename == _id_7DD111824A117DC6)
      return 0;
  }

  if(isDefined(self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_7803C95645E637E1) && self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_7803C95645E637E1 != _id_D115192F0643E610) {
    _id_9725A0A5B31A25B3 = self getweaponammostock(self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_7803C95645E637E1) + self getweaponammoclip(self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_7803C95645E637E1);
    _id_6A3B7F7386AB3BE8 = self getweaponammostock(_id_D115192F0643E610) + self getweaponammoclip(_id_D115192F0643E610);
    _id_2454224C8377C053 = _id_9725A0A5B31A25B3 == 0 && _id_6A3B7F7386AB3BE8 == 0;
    _id_4E3B8D24D0506493 = self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_7803C95645E637E1 == self.primaryweapons[0] && _id_D115192F0643E610 == self.primaryweapons[1] || self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_7803C95645E637E1 == self.primaryweapons[1] && _id_D115192F0643E610 == self.primaryweapons[0];

    if(_id_4E3B8D24D0506493 && (_id_2454224C8377C053 || !(_id_9725A0A5B31A25B3 == 0)))
      return 1;
  }

  self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_7803C95645E637E1 = self getcurrentprimaryweapon();
  return 0;
}

_id_6985F6C8A8A0BD07(params) {
  if(self._id_0657F5A0D17435BC._id_11DDFA68D88BF6E0 >= params._id_FCF2301D78F01B4A)
    return 1;

  return 0;
}

_id_27F1FD373A18261D(params) {
  if(_id_08FFB283F4ABC438())
    return self._id_0FFDDBA74F404A30.size == params._id_38BAC1117024A027;

  return 0;
}

_id_6C1C1EAD6B70E1C3() {
  if(_id_08FFB283F4ABC438()) {
    foreach(ally in self._id_0FFDDBA74F404A30) {
      if(!ally isonground())
        return 0;
    }

    return 1;
  }

  return 0;
}

_id_B4BAD76D800E3C31(params) {
  _id_0FB1BE37BB7CDA28 = self _meth_793F941D7DFF15ED();

  if(isDefined(params) && isDefined(params._id_87C2A6B04DE18B12))
    return params._id_87C2A6B04DE18B12 == _id_0FB1BE37BB7CDA28;

  return _id_0FB1BE37BB7CDA28;
}

_id_42F01A7FA51ACC0D(params) {
  _id_0FB1BE37BB7CDA28 = self _meth_793F941D7DFF15ED() && self == _id_63002651C12F57E3::_id_EE15CB02C86EDC6E(self.vehicle);

  if(isDefined(params) && isDefined(params._id_87C2A6B04DE18B12))
    return params._id_87C2A6B04DE18B12 == _id_0FB1BE37BB7CDA28;

  return _id_0FB1BE37BB7CDA28;
}

_id_43C18A687082C9DA(params) {
  if(isDefined(self._id_0657F5A0D17435BC._id_EBF862078B683A7A._id_2F8A41AFC9EBEF12) && isDefined(self._id_0657F5A0D17435BC._id_EBF862078B683A7A._id_2F8A41AFC9EBEF12.itemsdropped)) {
    if(isDefined(self.lootcachesopened)) {
      if(self.lootcachesopened == self._id_0657F5A0D17435BC.lootcachesopened)
        return 1;
    } else if(self._id_0657F5A0D17435BC.lootcachesopened == 0)
      return 1;
  }

  return 0;
}

_id_C3DCD89A63B15279(params) {
  if(isDefined(self.inlaststand))
    return params._id_87C2A6B04DE18B12 == self.inlaststand;
  else
    return 1;
}

_id_77F548B16A31CB03(bot) {
  self waittill("waypoint_active");
  self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_CE7F7E62DF1E0B51 = scripts\engine\utility::drop_to_ground(bot.origin, 100) + (0, 0, 1);
  self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3.waypoint = _id_695A872D7D692EFA::_id_E5524FB8509827BF(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_CE7F7E62DF1E0B51, &"FTUE_MOBILE/PICK_UP_LOOT", "icon_waypoint_objective_general", 25, self, 1);
}

_id_0E626332AD1BD82B(position, _id_78B3A92FCADD7914, item) {
  if(isDefined(item)) {
    dist = distance(position, self.origin);
    maxdistance = _id_78B3A92FCADD7914 + _id_78B3A92FCADD7914 * 0.2;
    return dist >= maxdistance;
  }

  return 0;
}

_id_6DB11CEC60FC60C3(position, _id_78B3A92FCADD7914, item) {
  if(isDefined(item)) {
    dist = distance(position, self.origin);
    mindistance = _id_78B3A92FCADD7914 + _id_78B3A92FCADD7914 * 0.2;
    return dist <= mindistance;
  }

  return 0;
}

_id_043C47CF181121E3() {
  params = spawnStruct();
  params.amount = 4000;
  return _id_2BA81D8D4F69CFAD::_id_A380CF8DD38A32EE(params);
}