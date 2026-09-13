/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6a9e2d3385424b39.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_46C31E7AB1002CE0 = spawnStruct();
  level._id_46C31E7AB1002CE0.circleradius = getdvarint("dvar_6D7D606A7067C098", 800);
  level._id_46C31E7AB1002CE0._id_B04566C546A49C20 = getdvarint("dvar_8FEB68C00DA2144F", 3);
  level._id_46C31E7AB1002CE0._id_636C8575D7A7768B = getdvarint("dvar_DAAD8BC735AA6C40", 1000);
  level._id_46C31E7AB1002CE0._id_4F0FC1C36324AFFB = level._id_46C31E7AB1002CE0._id_636C8575D7A7768B * level._id_46C31E7AB1002CE0._id_636C8575D7A7768B;
  level._id_46C31E7AB1002CE0.maxdist = getdvarint("dvar_7F634531EC47F4AE", 6000);
  level._id_46C31E7AB1002CE0._id_CDC5DD6C28C9709D = level._id_46C31E7AB1002CE0.maxdist * level._id_46C31E7AB1002CE0.maxdist;
  level._id_51F143645ABC8911 = [];
  _id_25DD3020969AA0F6 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 60; _id_AC0E594AC96AA3A8++) {
    pos = (randomfloatrange(-40000, 40000), randomfloatrange(-40000, 40000), 0);
    z = getclosestpointonnavmesh(getgroundposition(pos, 15, 10000, 10000));
    struct = spawnStruct();
    struct.origin = z;
    struct.angles = (0, 0, 0);
    _id_25DD3020969AA0F6[_id_25DD3020969AA0F6.size] = struct;
  }

  foreach(node in _id_25DD3020969AA0F6) {
    if(istrue(node.taken)) {
      continue;
    }
    node.taken = 1;
    node.nodes = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_46C31E7AB1002CE0._id_B04566C546A49C20 - 1; _id_AC0E594AC96AA3A8++) {
      foreach(_id_1A7683A86F43BFF9 in _id_25DD3020969AA0F6) {
        if(istrue(_id_1A7683A86F43BFF9.taken)) {
          continue;
        }
        distsq = distance2dsquared(node.origin, _id_1A7683A86F43BFF9.origin);

        if(distsq > level._id_46C31E7AB1002CE0._id_4F0FC1C36324AFFB && distsq < level._id_46C31E7AB1002CE0._id_CDC5DD6C28C9709D) {
          node.nodes[node.nodes.size] = _id_1A7683A86F43BFF9;
          _id_1A7683A86F43BFF9.taken = 1;
          break;
        }
      }
    }

    if(node.nodes.size == level._id_46C31E7AB1002CE0._id_B04566C546A49C20 - 1) {
      level._id_51F143645ABC8911[level._id_51F143645ABC8911.size] = node;
      continue;
    }

    node.taken = 0;

    foreach(_id_1A7683A86F43BFF9 in node.nodes)
    _id_1A7683A86F43BFF9.taken = 0;
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_flare_site_use", ::_id_E63F55869E4D74ED);
  level._id_EF63E063E320ACFC["dmz_supply_drop"]._id_5CC8AC2ED7A3D9FA = ::_id_D8352A33E10DF5A8;
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_F641A4EFD6F76F39, level._id_51F143645ABC8911);
}

_id_F641A4EFD6F76F39(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_FA794F583171A19E;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_651EC6D76D0E7CD5;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_1DB1EAA131875C8C;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_5C452F9FB09A22CF;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_ACF1FC6FEC698927;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_20D0C1B71A58EDEE;
  _id_B8EBE3F71A08AB40.node = node;
  _id_B8EBE3F71A08AB40.ref = "dmz_supply_explore";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  return _id_B8EBE3F71A08AB40;
}

_id_FA794F583171A19E() {
  self.nodes = scripts\engine\utility::array_add(self.node.nodes, self.node);

  foreach(node in self.nodes) {
    node.site = spawnscriptable("dmz_flare_site", node.origin, node.angles);
    node.site._id_B8EBE3F71A08AB40 = self;
    node.site.node = node;

    foreach(player in level.players)
    node.site disablescriptableplayeruse(player);
  }

  self._id_EFA8EF05B190D7D0.origin = self.node.origin;
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.node.origin + (0, 0, 50));
  self._id_F42170AD6524CDC2 = 0;
}

_id_1DB1EAA131875C8C(player) {}

_id_5C452F9FB09A22CF(player) {
  _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);
  _id_6C4E8CEA70BF4B6D::_id_401535E3FA9E171C(player);
}

_id_651EC6D76D0E7CD5(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_6C4E8CEA70BF4B6D::_id_E54DF8560BF7DC64(_id_FABF84450735DD93);
  self._id_8BD50C7E994C7434 = players.size * self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11;
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_supply_assigned", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");

  foreach(node in self.nodes) {
    foreach(player in players)
    node.site enablescriptableplayeruse(player);
  }

  _id_79057FBCBF8EED31();
}

_id_ACF1FC6FEC698927(_id_FABF84450735DD93) {}

_id_20D0C1B71A58EDEE(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, undefined, undefined);
  _id_8250FD658E3AAE32();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
}

_id_8250FD658E3AAE32() {
  self._id_7EF0FA7A21303CCC = 1;
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
}

_id_AAF82D7C71B92A61(_id_FABF84450735DD93) {
  self notify("task_ended");
  _id_8250FD658E3AAE32();
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_E63F55869E4D74ED(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  instance setscriptablepartstate("dmz_flare_site_use", "unusable");
  instance setscriptablepartstate("dmz_flare_site", "dissipate");
  _id_64ACB6CE534155B7::utilflare_shootflare(instance.origin, "dom");
  instance._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_supply_loot");

  if(isDefined(player.team))
    instance._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_supply_fired", player.team);

  crate = _id_046CF752D93DC17B::_id_52F17E5FBEC318A6(instance.origin, level._id_EF63E063E320ACFC["dmz_supply_drop"]);

  if(isDefined(crate)) {
    crate._id_B8EBE3F71A08AB40 = instance._id_B8EBE3F71A08AB40;
    crate.site = instance;
    crate unlink();
    _id_F8048727716242B0 = (0, 0, 0);
    crate physicslaunchserver(crate.origin, (0, 0, 0));
    _id_212A44A5393C3B34 = crate physics_getbodyid(0);
    physics_setbodycenterofmassnormal(_id_212A44A5393C3B34, (0, 0, 0));
    crate.physicsactivated = 1;
    crate.usetime = 10;
    crate setscriptablepartstate("dmz_supply_drop", "usable");
  }
}

_id_D8352A33E10DF5A8(instance, player) {
  if(!isDefined(player) || !isDefined(player.team)) {
    return;
  }
  if(!isDefined(instance.contents)) {
    _id_B8EBE3F71A08AB40 = instance.entity._id_B8EBE3F71A08AB40;
    items = getscriptablelootcachecontents(instance);
    instance._id_46A3A8565AC0C17C = 3;
    instance.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
    _id_8BD50C7E994C7434 = int(instance.entity._id_B8EBE3F71A08AB40._id_8BD50C7E994C7434 / level._id_46C31E7AB1002CE0._id_B04566C546A49C20);
    instance.contents = _id_552B8E4EA5FF7DF1::_id_163D360C111CAA16(instance.contents, _id_8BD50C7E994C7434, 500);
    instance.entity.site.node.opened = 1;

    if(player.team != _id_B8EBE3F71A08AB40.teams[0]) {
      return;
    }
    _id_B8EBE3F71A08AB40._id_F42170AD6524CDC2++;

    if(_id_B8EBE3F71A08AB40._id_F42170AD6524CDC2 >= level._id_46C31E7AB1002CE0._id_B04566C546A49C20) {
      _id_B8EBE3F71A08AB40 _id_AAF82D7C71B92A61(player.team);
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_supply_secured", player.team);
    } else {
      if(level._id_46C31E7AB1002CE0._id_B04566C546A49C20 == 2)
        _id_1B4ADA49A21B51CA = "dmz_supply_1_2";
      else
        _id_1B4ADA49A21B51CA = ["dmz_supply_1_3", "dmz_supply_2_3"][_id_B8EBE3F71A08AB40._id_F42170AD6524CDC2 - 1];

      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF(_id_1B4ADA49A21B51CA, player.team);
      _id_B8EBE3F71A08AB40 _id_79057FBCBF8EED31();
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_supply_explore");
      return;
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

_id_B9A9EF982E2D12A1() {
  for(;;)
    waitframe();
}