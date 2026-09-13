/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_78fe9876bb090d6b.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_CF05AFB32024800A = spawnStruct();
  level._id_CF05AFB32024800A.circleradius = getdvarint("dvar_83519EF779747386", 800);
  level._id_CF05AFB32024800A._id_B04566C546A49C20 = getdvarint("dvar_6D9EC532C0B1E0ED", 3);
  level._id_CF05AFB32024800A._id_636C8575D7A7768B = getdvarint("dvar_3B18AA46658249FE", 1000);
  level._id_CF05AFB32024800A._id_4F0FC1C36324AFFB = level._id_CF05AFB32024800A._id_636C8575D7A7768B * level._id_CF05AFB32024800A._id_636C8575D7A7768B;
  level._id_CF05AFB32024800A.maxdist = getdvarint("dvar_B95A7EF81C8FDE90", 6000);
  level._id_CF05AFB32024800A._id_CDC5DD6C28C9709D = level._id_CF05AFB32024800A.maxdist * level._id_CF05AFB32024800A.maxdist;
  level._id_D0A1B79D28EDCBB7 = [];
  allnodes = getentitylessscriptablearray("scriptable_dmz_crate_wood", "classname");
  _id_25DD3020969AA0F6 = [];

  foreach(node in allnodes) {
    if(!_id_0FF08D2B3254EA0D(node))
      _id_25DD3020969AA0F6[_id_25DD3020969AA0F6.size] = node;
  }

  _id_25DD3020969AA0F6 = scripts\engine\utility::array_randomize(_id_25DD3020969AA0F6);

  foreach(node in _id_25DD3020969AA0F6) {
    if(istrue(node.taken)) {
      continue;
    }
    node.taken = 1;
    node.nodes = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_CF05AFB32024800A._id_B04566C546A49C20 - 1; _id_AC0E594AC96AA3A8++) {
      foreach(_id_1A7683A86F43BFF9 in _id_25DD3020969AA0F6) {
        if(istrue(_id_1A7683A86F43BFF9.taken)) {
          continue;
        }
        _id_60DAFD3981C61E97 = scripts\engine\utility::array_add(node.nodes, node);
        _id_C980C8D719059445 = 1;

        foreach(_id_3DA66F9BE4E79ECC in _id_60DAFD3981C61E97) {
          distsq = distance2dsquared(_id_3DA66F9BE4E79ECC.origin, _id_1A7683A86F43BFF9.origin);

          if(distsq < level._id_CF05AFB32024800A._id_4F0FC1C36324AFFB || distsq > level._id_CF05AFB32024800A._id_CDC5DD6C28C9709D) {
            _id_C980C8D719059445 = 0;
            break;
          }
        }

        if(_id_C980C8D719059445) {
          node.nodes[node.nodes.size] = _id_1A7683A86F43BFF9;
          _id_1A7683A86F43BFF9.taken = 1;
          break;
        }
      }
    }

    if(node.nodes.size == level._id_CF05AFB32024800A._id_B04566C546A49C20 - 1) {
      level._id_D0A1B79D28EDCBB7[level._id_D0A1B79D28EDCBB7.size] = node;
      node._id_C93EA8F612F4AABA = 1;

      foreach(_id_1A7683A86F43BFF9 in node.nodes)
      _id_1A7683A86F43BFF9._id_C93EA8F612F4AABA = 1;

      continue;
    }

    node.taken = 0;

    foreach(_id_1A7683A86F43BFF9 in node.nodes)
    _id_1A7683A86F43BFF9.taken = 0;
  }

  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_1B08EECB1EF258C3, level._id_D0A1B79D28EDCBB7);
}

_id_0FF08D2B3254EA0D(node) {
  return _id_4948CDF739393D2D::_id_F59F68ADC71D49B3(node.origin) || _id_57D3850A12CF1D8F::_id_64332F29E2409E55(node.origin) || istrue(node._id_3E5D613E6F4D92E3);
}

_id_1B08EECB1EF258C3(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_96771C28A0FF4628;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_AA932AB67844F7AB;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_776101FE1E75A23A;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_F2E92A7C1FD7DB79;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_4F6565BDADAF8FC1;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_BA813599D8AA3E30;
  _id_B8EBE3F71A08AB40.node = node;
  _id_B8EBE3F71A08AB40.ref = "dmz_scav";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  return _id_B8EBE3F71A08AB40;
}

_id_96771C28A0FF4628() {
  self.nodes = scripts\engine\utility::array_add(self.node.nodes, self.node);

  foreach(node in self.nodes) {
    node._id_B8EBE3F71A08AB40 = self;
    node._id_534E0CF170A981B7 = ::_id_D8352A33E10DF5A8;
  }

  foreach(node in self.nodes) {
    if(_id_0FF08D2B3254EA0D(node)) {
      _id_8250FD658E3AAE32();
      _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
      return;
    }
  }

  self._id_7D3FB1CD4B3104A2 = scripts\engine\utility::array_randomize(["brloot_plate_carrier_2", "brloot_backpack_medium", "brloot_self_revive"]);
  self._id_BA9295056B43D556 = scripts\engine\utility::array_randomize(["brloot_plate_carrier_2_medic", "brloot_plate_carrier_2_comms", "brloot_plate_carrier_2_stealth", "brloot_plate_carrier_3", "brloot_equip_gasmask_scuba", "brloot_equip_gasmask_durable", "brloot_backpack_large", "brloot_battlerage_self_revive", "brloot_super_self_revive_box", "brloot_super_armorbox"]);
  self._id_EFA8EF05B190D7D0.origin = self.node.origin;
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.node.origin + (0, 0, 50));
  self._id_F42170AD6524CDC2 = 0;
}

_id_776101FE1E75A23A(player) {
  _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);
  _id_6C4E8CEA70BF4B6D::_id_FBF23AE15945EE5A(player);
}

_id_F2E92A7C1FD7DB79(player) {
  _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);
  _id_6C4E8CEA70BF4B6D::_id_401535E3FA9E171C(player);
}

_id_AA932AB67844F7AB(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_6C4E8CEA70BF4B6D::_id_E54DF8560BF7DC64(_id_FABF84450735DD93);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("supply_assigned", _id_FABF84450735DD93, 3.0);
  self._id_8BD50C7E994C7434 = _id_6C4E8CEA70BF4B6D::_id_9C6AB63C4B6BD08B(_id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_supply_assigned", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
  _id_79057FBCBF8EED31();
  _id_4E8F2A6350EC3613();
}

_id_4F6565BDADAF8FC1(_id_FABF84450735DD93) {}

_id_BA813599D8AA3E30(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, undefined, undefined);
  _id_8250FD658E3AAE32();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
}

_id_8250FD658E3AAE32() {
  self._id_7EF0FA7A21303CCC = 1;
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
}

_id_544DE143314C88EF(_id_FABF84450735DD93) {
  self notify("task_ended");
  _id_8250FD658E3AAE32();
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("supply_win", _id_FABF84450735DD93, 3.0);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_D8352A33E10DF5A8(instance, player) {
  if(!isDefined(player) || !isDefined(player.team)) {
    return;
  }
  if(!isDefined(instance._id_B8EBE3F71A08AB40) || !isDefined(instance._id_B8EBE3F71A08AB40.teams[0]) || player.team != instance._id_B8EBE3F71A08AB40.teams[0] || istrue(instance._id_B8EBE3F71A08AB40._id_7EF0FA7A21303CCC)) {
    player scripts\mp\hud_message::showerrormessage("MP_DMZ_MISSIONS/GEIGER_SEARCH_GC_CACHE_ERR");
    return 0;
  }

  if(!isDefined(instance._id_05FCB8B7F9F6B2E9)) {
    _id_B8EBE3F71A08AB40 = instance._id_B8EBE3F71A08AB40;
    items = getscriptablelootcachecontents(instance);
    instance._id_46A3A8565AC0C17C = 3;
    instance.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
    _id_8BD50C7E994C7434 = int(ceil(instance._id_B8EBE3F71A08AB40._id_8BD50C7E994C7434 / level._id_CF05AFB32024800A._id_B04566C546A49C20));
    instance.contents = _id_552B8E4EA5FF7DF1::_id_163D360C111CAA16(instance.contents, _id_8BD50C7E994C7434, 500);
    _id_72BDD1D2DFBCAA5E = _id_B8EBE3F71A08AB40._id_7D3FB1CD4B3104A2[_id_B8EBE3F71A08AB40._id_F42170AD6524CDC2];
    _id_DB35956D84816F27 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_72BDD1D2DFBCAA5E);
    instance.contents = _id_552B8E4EA5FF7DF1::_id_848E20CF1D6CAB8F(instance.contents, 1, _id_DB35956D84816F27);
    _id_5332CDA4054641DA = _id_0B7A9CE0A2282B79::_id_E860C1BE7FF11F5B(player.team, 24);

    if(_id_5332CDA4054641DA) {
      _id_0FD3A3A7662A333A = [0.5, 0.75, 0.95];
      _id_302E82DA1A1989AD = _id_0FD3A3A7662A333A[_id_5332CDA4054641DA - 1];

      if(randomfloat(1.0) < _id_302E82DA1A1989AD) {
        _id_CB2E5F9C72C8939C = _id_B8EBE3F71A08AB40._id_BA9295056B43D556[_id_B8EBE3F71A08AB40._id_F42170AD6524CDC2];
        _id_94947BB1861C9E61 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_CB2E5F9C72C8939C);
        instance.contents = _id_552B8E4EA5FF7DF1::_id_848E20CF1D6CAB8F(instance.contents, 1, _id_94947BB1861C9E61);
      }
    }

    instance.opened = 1;
    instance._id_05FCB8B7F9F6B2E9 = 1;
    _id_B8EBE3F71A08AB40._id_F42170AD6524CDC2++;
    _id_B8EBE3F71A08AB40 _id_4E8F2A6350EC3613();

    if(_id_B8EBE3F71A08AB40._id_F42170AD6524CDC2 >= level._id_CF05AFB32024800A._id_B04566C546A49C20) {
      _id_B8EBE3F71A08AB40 _id_544DE143314C88EF(player.team);
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_supply_secured", player.team);
    } else {
      if(level._id_CF05AFB32024800A._id_B04566C546A49C20 == 2)
        _id_1B4ADA49A21B51CA = "dmz_supply_1_2";
      else
        _id_1B4ADA49A21B51CA = ["dmz_supply_2_3", "dmz_supply_1_3"][_id_B8EBE3F71A08AB40._id_F42170AD6524CDC2 - 1];

      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF(_id_1B4ADA49A21B51CA, player.team);
      _id_B8EBE3F71A08AB40 _id_79057FBCBF8EED31();
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_scav");
      thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("supply_secured", player.team, 3.0);
    }
  }
}

_id_79057FBCBF8EED31() {
  if(!isDefined(self.teams[0])) {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");
  _id_F95FEB63C772E28F = (0, 0, 0);
  numplayers = 0;

  foreach(player in players) {
    if(isDefined(player) && isDefined(player.origin)) {
      _id_F95FEB63C772E28F = _id_F95FEB63C772E28F + player.origin;
      numplayers++;
    }
  }

  _id_F95FEB63C772E28F = _id_F95FEB63C772E28F / max(numplayers, 1);
  _id_64104068F7078B84 = 99999999999;
  _id_D6EB01B1DC33FFDC = self.node;

  foreach(node in self.nodes) {
    if(istrue(node.opened)) {
      continue;
    }
    distsq = distancesquared(node.origin, _id_F95FEB63C772E28F);

    if(distsq < _id_64104068F7078B84) {
      _id_D6EB01B1DC33FFDC = node;
      _id_64104068F7078B84 = distsq;
    }
  }

  _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(_id_D6EB01B1DC33FFDC.origin + (0, 0, 50));
}

_id_4E8F2A6350EC3613() {
  _id_64ACB6CE534155B7::_id_E2AA45E2C6B5DEC1(level._id_CF05AFB32024800A._id_B04566C546A49C20 - self._id_F42170AD6524CDC2);
}

_id_B9A9EF982E2D12A1() {
  for(;;)
    waitframe();
}