/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_task_utils.gsc
***************************************************/

_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0) {
  _id_B8EBE3F71A08AB40 = spawnStruct();
  _id_B8EBE3F71A08AB40.teams = [];
  _id_B8EBE3F71A08AB40._id_AA1ED8F12D71A7A5 = _id_EFA8EF05B190D7D0;
  _id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0 = _id_EFA8EF05B190D7D0;
  _id_B8EBE3F71A08AB40.funcs = [];
  _id_B8EBE3F71A08AB40.index = 0;
  return _id_B8EBE3F71A08AB40;
}

_id_325390EDB051CD5D(_id_BFBE9638E9832D90, locations, _id_A61C75B156FC1EE0) {
  if(!isDefined(self._id_B0F4BF8621B96C0A))
    self._id_B0F4BF8621B96C0A = [];

  foreach(location in locations) {
    index = self._id_B0F4BF8621B96C0A.size;
    self._id_B0F4BF8621B96C0A[index] = spawnStruct();
    self._id_B0F4BF8621B96C0A[index] scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_BFBE9638E9832D90, location, _id_A61C75B156FC1EE0);
  }
}

_id_8CD2AC82037F025C(_id_BFBE9638E9832D90, location, _id_A61C75B156FC1EE0) {
  if(!isDefined(self._id_B0F4BF8621B96C0A))
    self._id_B0F4BF8621B96C0A = [];

  index = self._id_B0F4BF8621B96C0A.size;
  self._id_B0F4BF8621B96C0A[index] = spawnStruct();
  self._id_B0F4BF8621B96C0A[index] scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_BFBE9638E9832D90, location, _id_A61C75B156FC1EE0);
}

_id_1851E9CFB7687F68(player) {
  if(isDefined(self._id_B0F4BF8621B96C0A)) {
    foreach(circle in self._id_B0F4BF8621B96C0A) {
      if(isDefined(circle))
        circle scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
    }
  }
}

_id_556FB3A465F0E978(player) {
  if(isDefined(self._id_B0F4BF8621B96C0A)) {
    foreach(circle in self._id_B0F4BF8621B96C0A) {
      if(isDefined(circle))
        circle scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
    }
  }
}

_id_E54DF8560BF7DC64(team) {
  if(isDefined(self._id_B0F4BF8621B96C0A)) {
    foreach(circle in self._id_B0F4BF8621B96C0A) {
      if(isDefined(circle))
        circle _id_739560269BC164CF(team);
    }
  }
}

_id_89951899F85B3465(team, circleindex) {
  if(!isDefined(self._id_B0F4BF8621B96C0A)) {
    return;
  }
  if(!isDefined(self._id_B0F4BF8621B96C0A[circleindex])) {
    return;
  }
  self._id_B0F4BF8621B96C0A[circleindex] _id_739560269BC164CF(team);
}

_id_2476DAEFA3384C5E() {
  if(isDefined(self._id_B0F4BF8621B96C0A)) {
    foreach(circle in self._id_B0F4BF8621B96C0A) {
      if(isDefined(circle))
        circle scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
    }
  }
}

_id_4E927BFE9B585059(index) {
  if(isDefined(self._id_B0F4BF8621B96C0A)) {
    self._id_B0F4BF8621B96C0A[index] scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
    self._id_B0F4BF8621B96C0A[index] = undefined;
  }
}

_id_AB50F62A3A730400(origin, radius) {
  return origin + scripts\engine\utility::_id_D553466CF817A4DA() * radius;
}

_id_E68B37E06549547E(_id_A9706ADAF7C52E27, _id_A66785EDEC9E567B, circleindex) {
  if(!isDefined(circleindex))
    circleindex = 0;

  if(!isDefined(_id_A9706ADAF7C52E27))
    _id_A9706ADAF7C52E27 = self._id_B0F4BF8621B96C0A[circleindex].mapcircle.origin;

  if(!isDefined(_id_A66785EDEC9E567B))
    _id_A66785EDEC9E567B = self._id_B0F4BF8621B96C0A[circleindex].mapcircle.origin[2];

  self._id_B0F4BF8621B96C0A[circleindex].mapcircle.origin = (_id_A9706ADAF7C52E27[0], _id_A9706ADAF7C52E27[1], _id_A66785EDEC9E567B);
}

_id_A764B87CDF6D8AC4(points, height) {
  _id_3C590D0EE220B409 = points[0][0];
  _id_C978C90E8E5AB1F7 = points[0][0];
  _id_3C590C0EE220B1D6 = points[0][1];
  _id_C978C80E8E5AAFC4 = points[0][1];

  foreach(point in points) {
    if(_id_3C590D0EE220B409 > point[0])
      _id_3C590D0EE220B409 = point[0];

    if(_id_C978C90E8E5AB1F7 < point[0])
      _id_C978C90E8E5AB1F7 = point[0];

    if(_id_3C590C0EE220B1D6 > point[1])
      _id_3C590C0EE220B1D6 = point[1];

    if(_id_C978C80E8E5AAFC4 < point[1])
      _id_C978C80E8E5AAFC4 = point[1];
  }

  center = ((_id_C978C90E8E5AB1F7 + _id_3C590D0EE220B409) / 2, (_id_C978C80E8E5AAFC4 + _id_3C590C0EE220B1D6) / 2, height);
  radiussq = 0;

  foreach(point in points) {
    distsq = distance2dsquared(center, point);

    if(radiussq <= distsq)
      radiussq = distsq;
  }

  return [center, sqrt(radiussq)];
}

_id_9E357E07833A0D1A(team) {
  level endon("game_ended");
  self endon("task_ended");
  wait 3;

  for(;;) {
    if(!isDefined(self._id_B0F4BF8621B96C0A) || self._id_B0F4BF8621B96C0A.size == 0 || !isDefined(self.icon)) {
      return;
    }
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players) {
      showicon = 1;

      foreach(circle in self._id_B0F4BF8621B96C0A) {
        if(!isDefined(circle.mapcircle)) {
          continue;
        }
        dist = distance2dsquared(player.origin, circle.mapcircle.origin);

        if(dist <= circle.mapcircle.origin[2] * circle.mapcircle.origin[2]) {
          showicon = 0;
          break;
        }
      }

      if(showicon) {
        _id_FBF23AE15945EE5A(player);
        continue;
      }

      _id_401535E3FA9E171C(player);
    }

    wait 1.0;
  }
}

_id_995813AD75B83C53(team, circleindex) {
  level endon("game_ended");
  self endon("task_ended");
  wait 3;

  for(;;) {
    if(!isDefined(self._id_B0F4BF8621B96C0A) || self._id_B0F4BF8621B96C0A.size == 0 || !isDefined(self.icon)) {
      return;
    }
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players) {
      showicon = 1;
      circle = self._id_B0F4BF8621B96C0A[circleindex];

      if(isDefined(circle.mapcircle)) {
        dist = distance2dsquared(player.origin, circle.mapcircle.origin);

        if(dist <= circle.mapcircle.origin[2] * circle.mapcircle.origin[2]) {
          showicon = 0;
          break;
        }
      }

      if(showicon) {
        _id_FBF23AE15945EE5A(player);
        continue;
      }

      _id_401535E3FA9E171C(player);
    }

    wait 1.0;
  }
}

_id_A9F8002E49A69313(dialog, _id_FABF84450735DD93) {
  _id_CB3339ECE72DBDEB = game["dialog"][dialog];

  foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"))
  _id_B2810E8D06E0A042 queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 2);
}

_id_4ED64AE8FC231A27(icon, _id_FABF84450735DD93, location, zoffset, waittime, _id_024C76FC549F7FD9) {
  level endon("game_ended");
  self endon("RemoveIcon");

  if(isDefined(waittime))
    wait(waittime);
  else
    waitframe();

  _id_0E88784387008BD2(icon, _id_FABF84450735DD93, location, zoffset, _id_024C76FC549F7FD9);
}

_id_05A2F918C5578514(icon, _id_FABF84450735DD93, entity, zoffset, _id_024C76FC549F7FD9) {
  _id_0E88784387008BD2(icon, _id_FABF84450735DD93, entity.origin, zoffset, _id_024C76FC549F7FD9);
  scripts\mp\objidpoolmanager::update_objective_onentity(self.objidnum, entity);

  if(isDefined(zoffset))
    scripts\mp\objidpoolmanager::update_objective_setzoffset(self.objidnum, zoffset);
}

_id_0E88784387008BD2(icon, _id_FABF84450735DD93, location, zoffset, _id_024C76FC549F7FD9) {
  if(!isDefined(zoffset))
    zoffset = 0;

  self.curorigin = location;
  self.offset3d = (0, 0, zoffset);
  scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, icon);

  if(isDefined(_id_FABF84450735DD93))
    scripts\mp\objidpoolmanager::objective_teammask_single(self.objidnum, _id_FABF84450735DD93);
  else
    objective_removeallfrommask(self.objidnum);

  scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, scripts\engine\utility::ter_op(isDefined(_id_024C76FC549F7FD9), _id_024C76FC549F7FD9, "invisible"));
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 4);
}

_id_188BF2B5951A0060(_id_ADBAB86D1C12E542) {
  self._id_04F84F5E80FF9F3B = _id_ADBAB86D1C12E542;
  scripts\mp\objidpoolmanager::update_objective_onentity(self.objidnum, _id_ADBAB86D1C12E542);
}

_id_30C89AC91CFAE119(_id_FABF84450735DD93) {
  if(isDefined(_id_FABF84450735DD93) && isDefined(self.objidnum))
    scripts\mp\objidpoolmanager::objective_teammask_single(self.objidnum, _id_FABF84450735DD93);
}

_id_E8D8DF3DA4392F0F(_id_FABF84450735DD93) {
  if(isDefined(_id_FABF84450735DD93) && isDefined(self.objidnum)) {
    objective_removeteamfrommask(self.objidnum, _id_FABF84450735DD93);
    objective_showtoplayersinmask(self.objidnum);
  }
}

_id_D062142F367ED7B2() {
  self notify("RemoveIcon");

  if(isDefined(self) && isDefined(self.objidnum))
    scripts\mp\gameobjects::releaseid();
}

_id_F76241DB305FB78F(entity, zoffset) {
  if(!isDefined(zoffset))
    zoffset = 50;

  _id_C847BFD52C064289(entity.origin);

  if(isDefined(self.icon)) {
    objective_onentity(self.icon, entity);
    objective_setzoffset(self.icon, zoffset);
  }
}

_id_C847BFD52C064289(origin, type) {
  if(!isDefined(type))
    type = self._id_EFA8EF05B190D7D0.type;

  self.icon = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(!isDefined(self.icon) || self.icon == -1) {
    self.icon = undefined;
    return;
  }

  self._id_7919C8F3A10FEB86 = origin;
  objective_delete(self.icon);
  objective_icon(self.icon, _id_56F8D3E2552878BE(type));
  objective_setbackground(self.icon, 4);
  objective_position(self.icon, origin);
  objective_setplayintro(self.icon, 1);
  objective_setdescription(self.icon, &"MP_DMZ_MISSIONS/CONTRACT_ICON_LABEL");
  objective_state(self.icon, "current");
  scripts\mp\objidpoolmanager::_id_098BA077848896A3(self.icon, 0);
  objective_sethideelevation(self.icon, 1);
  _func_9427CB5974C925D9(self.icon, 1);
  _func_A13E72E0427ECAD2(self.icon, _func_58FB674A1DD27075());
  objective_addalltomask(self.icon);
  objective_hidefromplayersinmask(self.icon);
}

_id_56F8D3E2552878BE(type) {
  icon = undefined;

  switch (type) {
    case "combat":
      icon = "ui_map_icon_obj_assassin";
      break;
    case "recon":
      icon = "ui_map_icon_obj_scavenger";
      break;
    case "bomb":
      icon = "ui_map_icon_obj_sh_bomb_defuse";
      break;
    case "recover":
      icon = "ui_map_icon_obj_recover";
      break;
    case "rescue":
      icon = "ui_map_icon_obj_rescue";
      break;
    case "sabotage":
      icon = "ui_map_icon_obj_bomb_collect";
      break;
    case "hunt":
      icon = "ui_map_icon_obj_hunt";
      break;
    case "vehicledrive":
      icon = "ui_map_icon_obj_cargo_delivery";
      break;
    case "boatdrive":
      icon = "ui_map_icon_obj_cargo_ship";
      break;
    case "radiation":
      icon = "ui_map_icon_obj_geiger_search";
      break;
    case "intel":
      icon = "ui_map_icon_obj_intel_dmz";
      break;
    case "trap":
      icon = "ui_map_icon_obj_trap";
      break;
    case "convoy_attack":
      icon = "ui_map_icon_obj_most_wanted";
      break;
    case "supply":
      icon = "ui_map_icon_obj_dmz_supply";
      break;
    case "hacker_phone":
      icon = "ui_map_icon_obj_hacker";
      break;
    default:
      icon = "ui_map_icon_obj_scavenger";
      break;
  }

  return icon;
}

_id_FBF23AE15945EE5A(player) {
  if(isDefined(self.icon))
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.icon, player);
}

_id_A92867E16C21DA22(team) {
  if(!isDefined(self.icon)) {
    return;
  }
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  _id_FBF23AE15945EE5A(player);
}

_id_401535E3FA9E171C(player) {
  if(isDefined(self.icon))
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.icon, player);
}

_id_743033B2E6C2D930(team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  _id_401535E3FA9E171C(player);
}

_id_629ED367D1393020() {
  if(isDefined(self.icon)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.icon);
    self.icon = -1;
  }
}

_id_CEF2ED613A8338BE(location) {
  if(isDefined(self.icon)) {
    self._id_7919C8F3A10FEB86 = location;
    objective_position(self.icon, location);
  }
}

_id_B3C1BA9FBD1DD01E(entity, zoffset) {
  if(!isDefined(zoffset))
    zoffset = 50;

  if(isDefined(self.icon)) {
    objective_onentity(self.icon, entity);

    if(isDefined(zoffset))
      objective_setzoffset(self.icon, zoffset);
  }
}

_id_9BE29AD72A155EE1(_id_B37714A572B93F0E, _id_9C40AF0F61186602) {
  self endon("death");
  weaponname = "intel_pickup_phone";

  if(isDefined(_id_B37714A572B93F0E))
    weaponname = _id_B37714A572B93F0E;

  if(istrue(self.insertingarmorplate)) {
    self notify("try_armor_cancel");

    while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp")
      waitframe();

    waitframe();
  }

  self notify("cancel_all_killstreak_deployments");

  while(scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(self getcurrentweapon()))
    waitframe();

  omnvar = _id_32E9314DEAF4C7BE(weaponname);

  if(isDefined(_id_9C40AF0F61186602))
    omnvar = _id_9C40AF0F61186602;

  _id_3B64EB40368C1450::set("show_intel", "weapon_switch", 0);
  _id_3B64EB40368C1450::set("show_intel", "mantle", 0);
  _id_3B64EB40368C1450::set("show_intel", "prone", 0);
  _id_3B64EB40368C1450::set("show_intel", "melee", 0);
  _id_3B64EB40368C1450::set("show_intel", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("show_intel", "weapon_pickup", 0);
  _id_3B64EB40368C1450::set("show_intel", "usability", 0);
  _id_3B64EB40368C1450::set("show_intel", "vehicle_use", 0);
  currentweapon = self getcurrentweapon();
  _id_2FAA2C4B7D9E16E4 = makeweapon(weaponname);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_2FAA2C4B7D9E16E4);
  self switchtoweapon(_id_2FAA2C4B7D9E16E4);
  self setclientomnvar("ui_tablet_usb", omnvar);
  thread _id_1EF3AEF709C7007C();
  wait(_id_2D0D55D0D1148C4D(weaponname));
  self takeweapon(_id_2FAA2C4B7D9E16E4);
  self switchtoweapon(currentweapon);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("show_intel");
  self setclientomnvar("ui_tablet_usb", 0);
  self notify("ui_tablet_reset");
}

_id_32E9314DEAF4C7BE(_id_D5958F44DF33323A) {
  switch (_id_D5958F44DF33323A) {
    case "intel_pickup_phone_alt":
    case "intel_pickup_phone":
      return 1;
    case "intel_call_phone":
      return 2;
    case "intel_put_usb_in_tablet":
      return 3;
    case "intel_found_usb":
      return 8;
    default:
      return 0;
  }
}

_id_2D0D55D0D1148C4D(_id_D5958F44DF33323A) {
  switch (_id_D5958F44DF33323A) {
    case "intel_pickup_phone_alt":
    case "intel_pickup_phone":
      return 4;
    case "intel_call_phone":
      return 3;
    case "intel_put_usb_in_tablet":
      return 4.5;
    case "intel_found_usb":
      return 4;
    case "intel_pickup_phone_long":
      return 8;
  }

  return 5;
}

_id_1EF3AEF709C7007C() {
  self endon("ui_tablet_reset");
  level endon("game_ended");
  self waittill("death_or_disconnect");
  self setclientomnvar("ui_tablet_usb", 0);
}

_id_DA38BE107AE836FF(_id_6D5ED003AF1F9612, _id_52C67624A2BB680E) {
  _id_0774C9CA5D1D6221 = float(getdvarint("dvar_398B5ABEF8D572FA", _id_6D5ED003AF1F9612.size));
  return scripts\engine\utility::ter_op(_id_0774C9CA5D1D6221, _id_52C67624A2BB680E / _id_0774C9CA5D1D6221, 0);
}

_id_8C5476A01AFAB741(player, _id_52C67624A2BB680E) {
  _id_13D34A5606594FAB = scripts\engine\utility::_id_53C4C53197386572(_id_0B7A9CE0A2282B79::_id_07E5492B68492F80(player, 19), 0);
  _id_5E2BB202AE259B31 = 1 + 0.05 * _id_13D34A5606594FAB;
  return _id_52C67624A2BB680E * _id_5E2BB202AE259B31;
}

_id_CD4F277CF0D6A560(_id_FABF84450735DD93, _id_52C67624A2BB680E) {
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  if(!isDefined(_id_6D5ED003AF1F9612) || !isarray(_id_6D5ED003AF1F9612) || _id_6D5ED003AF1F9612.size == 0) {
    return;
  }
  if(!isDefined(_id_52C67624A2BB680E))
    _id_52C67624A2BB680E = self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11;

  _id_DCE14F374C0BCD61 = _id_DA38BE107AE836FF(_id_6D5ED003AF1F9612, _id_52C67624A2BB680E);

  foreach(player in _id_6D5ED003AF1F9612) {
    _id_9F870CCAE9510EAB = _id_8C5476A01AFAB741(player, _id_DCE14F374C0BCD61);
    _id_C65DF5EF44DD0AA1 = int(ceil(_id_9F870CCAE9510EAB));
    player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_C65DF5EF44DD0AA1);
  }
}

_id_9C6AB63C4B6BD08B(_id_FABF84450735DD93, _id_52C67624A2BB680E) {
  _id_BBAC576AADE31A1E = 0;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  if(!isDefined(_id_6D5ED003AF1F9612) || !isarray(_id_6D5ED003AF1F9612) || _id_6D5ED003AF1F9612.size == 0) {
    return;
  }
  if(!isDefined(_id_52C67624A2BB680E))
    _id_52C67624A2BB680E = self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11;

  _id_DCE14F374C0BCD61 = _id_DA38BE107AE836FF(_id_6D5ED003AF1F9612, _id_52C67624A2BB680E);

  foreach(player in _id_6D5ED003AF1F9612) {
    _id_9F870CCAE9510EAB = _id_8C5476A01AFAB741(player, _id_DCE14F374C0BCD61);
    _id_BBAC576AADE31A1E = _id_BBAC576AADE31A1E + _id_9F870CCAE9510EAB;
  }

  return int(ceil(_id_BBAC576AADE31A1E));
}

_id_84E79AB809A8EEA3(_id_5E671FC71E72D5E8, _id_644A33D86D8514BF) {
  if(isDefined(_id_5E671FC71E72D5E8)) {
    players = scripts\mp\utility\teams::getteamdata(_id_5E671FC71E72D5E8, "players");

    if(isDefined(players)) {
      foreach(player in players)
      level thread _id_4480C6CE37B2BDF3::_id_1BE19E52E991D817(player);
    }
  }

  self._id_EFA8EF05B190D7D0 _id_03314ADD7998AB13::_id_018D4E8025EC24A0(self, _id_5E671FC71E72D5E8, _id_644A33D86D8514BF);
}

_id_6F6F83AB76483811(instance, player) {
  if(!isDefined(instance) || !isDefined(instance._id_B8EBE3F71A08AB40)) {
    return;
  }
  _id_B8EBE3F71A08AB40 = instance._id_B8EBE3F71A08AB40;

  if(scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.teams, player.team))
    _id_B8EBE3F71A08AB40 _id_84E79AB809A8EEA3(player.team);
}

_id_8158903A6E2F32FD(_id_B8EBE3F71A08AB40, player) {
  return isDefined(_id_B8EBE3F71A08AB40) && isDefined(_id_B8EBE3F71A08AB40.teams) && isDefined(player) && isDefined(player.team) && scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.teams, player.team);
}

_id_65A2513D3692EA1A(_id_FABF84450735DD93) {
  _id_1759ACFD39BB5EDF("dmz_generic_" + self._id_EFA8EF05B190D7D0.type + "_mission_assigned", _id_FABF84450735DD93);
}

_id_A1738A95D7AA8094(_id_1B4ADA49A21B51CA, _id_1BBEB265EF74BC60, _id_723B8F7CB71CEB11, _id_FABF84450735DD93) {
  _id_D4FC3B4E84704775 = level._id_1B7407DFFE81E6E8._id_B2F15037287A033A[_id_1BBEB265EF74BC60].index;
  params = _id_64ACB6CE534155B7::packsplashparambits(_id_D4FC3B4E84704775, _id_723B8F7CB71CEB11);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(_id_1B4ADA49A21B51CA, scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"), undefined, params);
}

_id_1759ACFD39BB5EDF(_id_1B4ADA49A21B51CA, _id_FABF84450735DD93) {
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(_id_1B4ADA49A21B51CA, scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"), self.node._id_B205D90302DA2F07);
}

_id_3A1B792C4EAB210F(_id_1B4ADA49A21B51CA) {
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(_id_1B4ADA49A21B51CA, level.players);
}

_id_C9F97BAA0D7F59BF(_id_1B4ADA49A21B51CA, _id_FABF84450735DD93) {
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(_id_1B4ADA49A21B51CA, scripts\engine\utility::array_remove_array(level.players, scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players")), self.node._id_B205D90302DA2F07);
}

_id_137D718C82AC0947(_id_FABF84450735DD93) {
  if(!isDefined(level._id_33A2175A9A4306BC) || !istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6)) {
    wait 5.0;

    if(!istrue(level._id_644A33D86D8514BF))
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_contract_reminder", scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"));
  }
}

_id_1458F4E9320A8AE1(point) {
  radius = 0;

  if(point.spawnflags & 4)
    radius = 256;
  else if(point.spawnflags & 2)
    radius = 128;
  else if(point.spawnflags & 1)
    radius = 168;

  return radius;
}

_id_70313F3B61E1AEEF() {
  if(isDefined(level._id_FE29A5BF2F96B5D3) && level._id_FE29A5BF2F96B5D3.size > 1)
    return level._id_FE29A5BF2F96B5D3;

  return [];
}

_id_739560269BC164CF(_id_FABF84450735DD93) {
  foreach(player in scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"))
  scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
}

_id_9688F0DC7DFD3D53(_id_FABF84450735DD93) {
  foreach(player in scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"))
  scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
}

_id_42718C89B38E260B(objidnum, teams) {
  foreach(team in teams)
  _id_6DAD7E4D170DE4BA(objidnum, team);
}

_id_6DAD7E4D170DE4BA(objidnum, team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    scripts\mp\objidpoolmanager::objective_unpin_player(objidnum, player);
    scripts\mp\objidpoolmanager::_id_7299A742781A5030(0, player);
  }
}

_id_83DD17F313FFDEC0(_id_7E05C139FBBD8374, _id_5B9C864B21207FF6, _id_B8EBE3F71A08AB40) {
  _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache", _id_7E05C139FBBD8374, _id_5B9C864B21207FF6);
  _id_B038ED928EC17A81 setscriptablepartstate("body", "open_usable");
  _id_C573D8A23F7FAF06(_id_B038ED928EC17A81, []);
  _id_B038ED928EC17A81._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  _id_B8EBE3F71A08AB40._id_B038ED928EC17A81 = _id_B038ED928EC17A81;
  return _id_B038ED928EC17A81;
}

_id_C573D8A23F7FAF06(_id_B038ED928EC17A81, teams) {
  validplayers = [];

  foreach(team in teams)
  validplayers = scripts\engine\utility::array_combine(validplayers, scripts\mp\utility\teams::getteamdata(team, "players"));

  foreach(player in level.players) {
    if(scripts\engine\utility::array_contains(validplayers, player)) {
      _id_B038ED928EC17A81 enablescriptableplayeruse(player);
      continue;
    }

    _id_B038ED928EC17A81 disablescriptableplayeruse(player);
  }
}

_id_F8CD22FB229F4138(_id_52C67624A2BB680E) {
  if(!isDefined(_id_52C67624A2BB680E) || _id_52C67624A2BB680E == 0)
    return 1;

  return int(_id_52C67624A2BB680E / 25 - 1);
}

_id_B43E9536B7E60884(player, index) {
  player _id_64ACB6CE534155B7::setquestindexomnvar(index);
}

_id_B7BBE29ED551EE90(index, tier, _id_FABF84450735DD93) {
  foreach(player in scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"))
  _id_B43E9536B7E60884(player, index);

  if(!isDefined(tier))
    tier = 1;

  _id_64ACB6CE534155B7::setquestrewardtier(_id_FABF84450735DD93, tier);
}

_id_6D93BE335873296E(player) {
  player _id_64ACB6CE534155B7::setquestindexomnvar(0);
}

_id_83D7EB52598BE0B3(_id_FABF84450735DD93) {
  foreach(player in scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"))
  _id_6D93BE335873296E(player);
}

_id_5314298E777E5688(ref) {
  self.ref = ref;
  self._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(self.ref);
  tier = 1;

  if(isDefined(self._id_EFA8EF05B190D7D0)) {
    _id_723B8F7CB71CEB11 = self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11;
    tier = _id_F8CD22FB229F4138(_id_723B8F7CB71CEB11);
  }

  foreach(team in self.teams)
  _id_B7BBE29ED551EE90(self._id_30E8A65CFF941C7A, tier, team);
}

_id_DFFCBCE998C9EE50(_id_FABF84450735DD93) {
  key = self._id_65513AD5397A67EF;
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players)
  player._id_65513AD5397A67EF = key;
}

_id_45BD3184FF146B46(_id_FABF84450735DD93) {
  if(isDefined(_id_FABF84450735DD93)) {
    players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

    foreach(player in players)
    player._id_65513AD5397A67EF = undefined;
  }
}

_id_D86771EDADBA8B4A(instance, _id_B8EBE3F71A08AB40, player) {
  _id_B8EBE3F71A08AB40 endon("bomb_planted");
  _id_B8EBE3F71A08AB40 endon("bomb_defused");
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  player endon("enter_live_ragdoll");
  player notifyonplayercommand("cancel", "+weapnext");
  instance._id_A4CF15C49F3E9EEF = 0;
  player waittill("cancel");
  instance._id_A4CF15C49F3E9EEF = 1;
}