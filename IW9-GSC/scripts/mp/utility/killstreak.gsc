/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\killstreak.gsc
***********************************************/

hasplayerdiedwhileusingkillstreak(streakinfo) {
  return streakinfo.lifeid != scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();
}

addtoactivekillstreaklist(streakname, threatbiasgroup, owner, outline, teamheadicon, _id_81DBFC1D134BF264, _id_CFB9E6D8091C048B) {
  entnumber = self getentitynumber();
  self.activeid = owner getactivekillstreakid();

  if(isDefined(streakname)) {
    if(isremotekillstreak(streakname)) {
      addtoremotekillstreaklist(entnumber);
      thread removefromremotekillstreaklistondeath(entnumber);
    }

    if(isuavkillstreak(streakname)) {
      addtouavlist(entnumber);
      thread removefromuavlistondeath(entnumber);
    } else if(isairstrikekillstreak(streakname)) {
      addtoairstrikelist(entnumber);
      thread removefromairstrikelistondeath(entnumber);
    } else if(islittlebirdkillstreak(streakname)) {
      addtolittlebirdlist(entnumber);
      thread removefromlittlebirdlistondeath(entnumber);
    } else if(ishelikillstreak(streakname)) {
      addtohelilist(entnumber);
      thread removefromhelilistondeath(entnumber);
    } else if(isturretkillstreak(streakname)) {
      addtoturretlist(entnumber);
      thread removefromturretlistondeathorcarry(entnumber);
    } else if(_id_26AB4629DC655C14(streakname)) {
      _id_F0EDB803C309D596(entnumber);
      thread _id_D3D9181348D12D5B(entnumber);
    } else if(isprojectilekillstreak(streakname)) {
      addtoprojectilelist(entnumber);
      thread removefromprojectilelistondeath(entnumber);
    } else if(issupportdronekillstreak(streakname)) {
      addtosupportdronelist(entnumber);
      thread removefromsupportdronelistondeath(entnumber);
    } else if(isassaultdronekillstreak(streakname)) {
      addtoassaultdronelist(entnumber);
      thread removefromassaultdronelistondeath(entnumber);
    } else {
      addtoplayerkillstreaklist(entnumber);
      thread removefromplayerkillstreaklistondeath(entnumber);
    }

    if(iskillstreaklockonable(streakname))
      self.affectedbylockon = 1;
  }

  level.activekillstreaks[entnumber] = self;
  level.activekillstreaks[entnumber].streakname = streakname;

  if(threatbiasgroup == "Killstreak_Air") {
    self.isairkillstreak = 1;

    if(!isDefined(streakname) || streakname != "directional_uav")
      self enableplayermarks("air_killstreak");
  } else {
    self.isairkillstreak = 0;
    self enableplayermarks("killstreak");
  }

  if(level.teambased)
    self filteroutplayermarks(owner.team);
  else
    self filteroutplayermarks(owner);

  if(istrue(outline)) {
    outlineid = undefined;
    _id_4E96765E8FD41C3D = undefined;

    if(level.teambased) {
      if(scripts\cp_mp\utility\killstreak_utility::isridekillstreak(streakname)) {
        foreach(player in level.players) {
          if(player.team == self.team && player != self.owner)
            outlineid = scripts\mp\utility\outline::outlineenableforplayer(self, player, "outline_nodepth_cyan", "lowest");

          if(isDefined(outlineid))
            thread removeoutlineonnotify(outlineid, _id_CFB9E6D8091C048B);
        }

        _id_4E96765E8FD41C3D = 1;
      } else
        outlineid = scripts\mp\utility\outline::outlineenableforteam(self, owner.team, "outline_nodepth_cyan", "lowest");
    } else
      outlineid = scripts\mp\utility\outline::outlineenableforplayer(self, owner, "outline_nodepth_cyan", "lowest");

    if(!istrue(_id_4E96765E8FD41C3D))
      thread removeoutlineonnotify(outlineid, _id_CFB9E6D8091C048B);
  }

  if(istrue(teamheadicon)) {
    ownerinvisible = 0;

    if(owner scripts\mp\utility\player::isusingremote())
      ownerinvisible = 1;

    icon = undefined;

    if(level.teambased)
      icon = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, _id_81DBFC1D134BF264, 1, 10000, undefined, undefined, 1, ownerinvisible);
    else {
      if(istrue(ownerinvisible)) {
        return;
      }
      icon = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(owner, "hud_icon_head_equipment_friendly", _id_81DBFC1D134BF264, 1, 10000, undefined, undefined, 1);
    }

    thread removeteamheadicononnotify(icon, _id_CFB9E6D8091C048B);
  }
}

getactivekillstreakid() {
  if(!isDefined(self.pers["nextActiveID"]))
    self.pers["nextActiveID"] = 0;

  _id_EC78825BED0280DE = self.pers["nextActiveID"];
  self.pers["nextActiveID"]++;
  return _id_EC78825BED0280DE;
}

removeoutlineonnotify(outlineid, _id_CFB9E6D8091C048B) {
  _id_819382A0FC083B42 = ["death"];

  if(isDefined(_id_CFB9E6D8091C048B))
    _id_819382A0FC083B42[_id_819382A0FC083B42.size] = _id_CFB9E6D8091C048B;

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(_id_819382A0FC083B42);
  scripts\mp\utility\outline::outlinedisable(outlineid, self);
}

removeteamheadicononnotify(icon, _id_CFB9E6D8091C048B) {
  _id_819382A0FC083B42 = ["death"];

  if(isDefined(_id_CFB9E6D8091C048B))
    _id_819382A0FC083B42[_id_819382A0FC083B42.size] = _id_CFB9E6D8091C048B;

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(_id_819382A0FC083B42);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
}

removefromactivekillstreaklist(entnumber) {
  level.activekillstreaks[entnumber] = undefined;
}

activekillstreaklistcontains(entnumber) {
  if(!isDefined(level.activekillstreaks))
    return 0;

  return isDefined(level.activekillstreaks[entnumber]);
}

addtoremotekillstreaklist(entnumber) {
  if(!isDefined(level.remotekillstreaks))
    level.remotekillstreaks = [];

  level.remotekillstreaks[entnumber] = self;
}

removefromremotekillstreaklistondeath(entnumber) {
  self waittill("death");
  level.remotekillstreaks[entnumber] = undefined;
}

addtouavlist(entnumber) {
  if(!isDefined(level.uavmodels))
    level.uavmodels = [];

  if(level.teambased)
    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
  else
    level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

removefromuavlistondeath(entnumber) {
  self waittill("death");

  if(isDefined(self.uavrig))
    self.uavrig delete();

  if(level.teambased) {
    team = self.team;
    level.uavmodels[team] = scripts\engine\utility::array_removeundefined(level.uavmodels[team]);
  } else
    level.uavmodels = scripts\engine\utility::array_removeundefined(level.uavmodels);

  if(isDefined(self))
    self delete();

  removefromactivekillstreaklist(entnumber);
}

addtoairstrikelist(entnumber) {
  if(!isDefined(level.airstrikemodels))
    level.airstrikemodels = [];

  level.airstrikemodels[entnumber] = self;
}

removefromairstrikelistondeath(entnumber) {
  self waittill("death");
  level.airstrikemodels[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

addtolittlebirdlist(entnumber) {
  if(!isDefined(level.littlebirds))
    level.littlebirds = [];

  level.littlebirds[entnumber] = self;
}

removefromlittlebirdlistondeath(entnumber) {
  self waittill("death");
  level.littlebirds[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

addtohelilist(entnumber) {
  if(!isDefined(level.helis))
    level.helis = [];

  level.helis[entnumber] = self;
}

removefromhelilist(entnumber) {
  level.helis[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

removefromhelilistondeath(entnumber) {
  self waittill("death");
  level.helis[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

addtoturretlist(entnumber) {
  if(!isDefined(level.turrets))
    level.turrets = [];

  level.turrets[entnumber] = self;
}

removefromturretlistondeathorcarry(entnumber) {
  scripts\engine\utility::waittill_any_2("death", "carried");
  level.turrets[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

_id_F0EDB803C309D596(entnumber) {
  if(!isDefined(level.mines))
    level.mines = [];

  level.mines[entnumber] = self;
}

_id_D3D9181348D12D5B(entnumber) {
  self waittill("death");
  level.mines[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

addtosupportdronelist(entnumber) {
  if(!isDefined(level.supportdrones))
    level.supportdrones = [];

  level.supportdrones[entnumber] = self;
}

removefromsupportdronelistondeath(entnumber) {
  self waittill("death");
  level.supportdrones[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

addtoassaultdronelist(entnumber) {
  if(!isDefined(level.assaultdrones))
    level.assaultdrones = [];

  level.assaultdrones[entnumber] = self;
}

removefromassaultdronelistondeath(entnumber) {
  self waittill("death");
  level.assaultdrones[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

addtoprojectilelist(entnumber) {
  if(!isDefined(level.projectilekillstreaks))
    level.projectilekillstreaks = [];

  level.projectilekillstreaks[entnumber] = self;
}

removefromprojectilelistondeath(entnumber) {
  self waittill("death");
  level.projectilekillstreaks[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

addtoplayerkillstreaklist(entnumber) {
  if(!isDefined(level.playerkillstreaks))
    level.playerkillstreaks = [];

  level.playerkillstreaks[entnumber] = self;
}

removefromplayerkillstreaklistondeath(entnumber) {
  self waittill("death");
  level.playerkillstreaks[entnumber] = undefined;
  removefromactivekillstreaklist(entnumber);
}

setkillstreakcontrolpriority(owner, hintstring, _id_DAF100468D8A5E15, _id_0A68F5A8AED5A3DE, _id_5B37B3F49E242039, userange, usepriority, _id_A4C898CA05DF4D4C, _id_EFE526BF6A23D275) {
  self makeusable();

  if(isDefined(_id_EFE526BF6A23D275)) {
    self setCursorHint("HINT_BUTTON");
    self sethinticon(_id_EFE526BF6A23D275);
  } else
    self setCursorHint("HINT_NOICON");

  self sethintonobstruction("show");
  self setHintString(hintstring);
  self sethintdisplayfov(_id_DAF100468D8A5E15);
  self setusefov(_id_0A68F5A8AED5A3DE);
  self sethintdisplayrange(_id_5B37B3F49E242039);
  self setuserange(userange);
  self setuseholdduration("duration_short");

  if(!isDefined(usepriority))
    usepriority = -1;

  self setusepriority(usepriority);
  level thread applyplayercontrolonconnect(self);

  foreach(player in level.players) {
    if(player == owner && !istrue(_id_A4C898CA05DF4D4C)) {
      self enableplayeruse(player);
      continue;
    }

    self disableplayeruse(player);
  }
}

applyplayercontrolonconnect(_id_92C89B8FAA10B85F) {
  _id_92C89B8FAA10B85F endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    _id_92C89B8FAA10B85F disableplayeruse(player);
  }
}

_id_BDFA4410167443AD(player, _id_1022173EA86A7090) {
  player thread _id_362C58E8BB39BCDA::runbrgametypefunc("onKillstreakDanger", _id_1022173EA86A7090);
}

applykillstreakplayeroutline(player, _id_F7093A78B325FF35) {
  _id_78F4F12BE3B7507A = self.team;
  _id_8E40F8E8DCC635A6 = self.owner;
  hudoutlineasset = undefined;
  _id_BD9782FE6A8732A3 = undefined;

  if(!player scripts\cp_mp\utility\player_utility::_isalive() || player.team == "spectator" || player.team == "codcaster") {
    return;
  }
  if(player == _id_8E40F8E8DCC635A6)
    hudoutlineasset = "outlinefill_depth_cyan";
  else if(player != _id_8E40F8E8DCC635A6) {
    if(level.teambased && player.team != _id_78F4F12BE3B7507A || !level.teambased) {
      hudoutlineasset = "outlinefill_depth_orange";
      _id_BD9782FE6A8732A3 = 1;
    } else
      return;
  }

  if(isDefined(hudoutlineasset)) {
    if(istrue(_id_BD9782FE6A8732A3)) {
      if(player scripts\mp\utility\perk::_hasperk("specialty_noplayertarget"))
        return;
    }

    id = scripts\mp\utility\outline::outlineenableforplayer(player, self.owner, hudoutlineasset, "killstreak");
    thread watchoutlineremoveonkillstreakend(id, player, _id_F7093A78B325FF35);
    thread watchoutlineremoveonplayerend(id, player, _id_F7093A78B325FF35);
  }
}

watchoutlineremoveonkillstreakend(id, player, _id_F7093A78B325FF35) {
  player endon("death_or_disconnect");
  level endon("game_ended");
  self waittill(_id_F7093A78B325FF35);
  scripts\mp\utility\outline::outlinedisable(id, player);
}

watchoutlineremoveonplayerend(id, player, _id_F7093A78B325FF35) {
  self endon(_id_F7093A78B325FF35);
  level endon("game_ended");
  player waittill("death_or_disconnect");
  scripts\mp\utility\outline::outlinedisable(id, player);
}

_id_394DE31762A977EB(weaponname, _id_1BE56CDC5D342875) {
  if(_id_1BE56CDC5D342875 == "stat_B76B2215370D2700") {
    return;
  }
  level._id_C6411E8929FA12B3[weaponname] = _id_1BE56CDC5D342875;
}

getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, amount, maxhealth, _id_CB15FA5174E71840, _id_BE7C04516C5D9CCD, _id_CA960A517459FE15, _id_8ACEB016BAAF67AF, _id_64103C6B531D18F0, _id_C14F0ED27327131A) {
  _id_F20BC25347C9BAAF = 0;
  _id_4D8DC8AA1757E7A9 = 0;

  if(isDefined(meansofdeath)) {
    switch (meansofdeath) {
      case "MOD_HEADSHOT":
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        break;
      case "MOD_EXPLOSIVE_BULLET":
      case "MOD_MELEE":
      case "MOD_FIRE":
      case "MOD_PROJECTILE":
      case "MOD_GRENADE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_EXPLOSIVE":
        _id_4D8DC8AA1757E7A9 = 1;
        break;
      default:
        break;
    }
  }

  if(_id_4D8DC8AA1757E7A9) {
    _id_F1563935AEEB5199 = undefined;

    if(meansofdeath != "MOD_MELEE") {
      _id_1BE56CDC5D342875 = undefined;

      if(isDefined(level._id_C6411E8929FA12B3) && isDefined(objweapon))
        _id_1BE56CDC5D342875 = level._id_C6411E8929FA12B3[objweapon.basename];

      if(!isDefined(_id_1BE56CDC5D342875) && isDefined(objweapon)) {
        switch (objweapon.basename) {
          case "cruise_proj_mp":
          case "nuke_mp":
            _id_1BE56CDC5D342875 = "stat_4ADD34036A9ACE2F";
            break;
          case "bradley_tow_proj_mp":
          case "iw8_la_kgolf_mp":
          case "iw8_la_rpapa7_mp":
          case "at_mine_mp":
          case "gunship_hellfire_mp":
          case "hover_jet_bomb_mp":
          case "chopper_gunner_proj_mp":
          case "fuelstrike_proj_mp":
          case "iw9_la_juliet_mp":
          case "iw9_la_gromeo_mp":
          case "gunship_105mm_mp":
          case "iw8_la_juliet_mp":
          case "iw8_la_gromeo_mp":
          case "hover_jet_proj_mp":
          case "iw8_la_gromeoks_mp":
          case "emp_drone_non_player_direct_mp":
          case "emp_drone_non_player_mp":
            _id_1BE56CDC5D342875 = "stat_B0408FEC4209F8D4";
            break;
          case "white_phosphorus_proj_mp":
          case "motorcycle_cruiser_2008_mp":
          case "scooter_eu_mp":
          case "dirt_bike_mp":
          case "hummer_mp":
          case "blima_mp":
          case "palfa_mp":
          case "pickup_2014_mp":
          case "cougar_mp":
          case "pwc_mp":
          case "sedan_hatchback_1985_hsk_mp":
          case "sedan_hatchback_1985_mp":
          case "chopped_pickup_mp":
          case "overland_2016_mp":
          case "suv_1996_wkd_mp":
          case "suv_1996_mp":
          case "patrol_boat_wkd_mp":
          case "patrol_boat_mp":
          case "jltv_mg_hsk_mp":
          case "jltv_mg_mp":
          case "jltv_hsk_mp":
          case "jltv_mp":
          case "rhib_mp":
          case "hoopty_truck_mp":
          case "van_mp":
          case "mrap_mp":
          case "cargo_truck_mg_mp":
          case "cargo_truck_mp":
          case "med_transport_mp":
          case "hoopty_mp":
          case "pickup_truck_mp":
          case "cop_car_mp":
          case "apc_rus_mp":
          case "large_transport_mp":
          case "atv_mp":
          case "tac_rover_mp":
          case "little_bird_mg_mp":
          case "little_bird_mp":
          case "technical_mp":
          case "lighttank_mp":
          case "iw9_tur_light_tank_mp":
          case "gunship_40mm_mp":
          case "iw9_tur_cougar_mp":
          case "iw9_mg_cougar_mp":
          case "toma_proj_mp":
          case "emp_grenade_mp":
            _id_1BE56CDC5D342875 = "stat_C76A095E1FFA22B6";
            break;
          case "bunkerbuster_round_mp":
          case "bunkerbuster_not_burrowed_mp":
          case "semtex_mp":
          case "t10_frag_grenade_mp":
          case "frag_grenade_mp":
          case "claymore_mp":
          case "at_mine_ap_mp":
          case "c4_mp":
          case "gunship_25mm_mp":
          case "pac_sentry_turret_mp":
          case "bunkerbuster_mp":
          case "semtex_bolt_mp":
          case "artillery_mp":
          case "bunkerbuster_burrowed_mp":
          case "semtex_xmike109_mp":
            _id_1BE56CDC5D342875 = "stat_125083191DAF6F61";
            break;
          case "thermite_xmike109_radius_mp":
          case "thermite_av_mp":
          case "thermite_bolt_mp":
          case "thermite_bolt_radius_mp":
          case "thermite_xmike109_mp":
            _id_1BE56CDC5D342875 = "stat_1E7683EF2EBC7684";
            break;
        }
      }
    } else
      _id_1BE56CDC5D342875 = "stat_F7CE14C7DEEF337B";

    if(isDefined(_id_1BE56CDC5D342875)) {
      if(_id_1BE56CDC5D342875 == "stat_4ADD34036A9ACE2F") {
        self.largeprojectiledamage = 1;
        self.killoneshot = 1;
        _id_F1563935AEEB5199 = 1;
      } else if(_id_1BE56CDC5D342875 == "stat_B0408FEC4209F8D4") {
        self.largeprojectiledamage = 1;
        _id_F1563935AEEB5199 = _id_CB15FA5174E71840;
      } else if(_id_1BE56CDC5D342875 == "stat_C76A095E1FFA22B6") {
        self.largeprojectiledamage = 1;
        _id_F1563935AEEB5199 = _id_BE7C04516C5D9CCD;
      } else if(_id_1BE56CDC5D342875 == "stat_125083191DAF6F61") {
        self.largeprojectiledamage = 0;
        _id_F1563935AEEB5199 = _id_CA960A517459FE15;
      } else if(_id_1BE56CDC5D342875 == "stat_1E7683EF2EBC7684") {
        self.largeprojectiledamage = 0;
        _id_F1563935AEEB5199 = _id_64103C6B531D18F0;
      } else if(_id_1BE56CDC5D342875 == "stat_F7CE14C7DEEF337B") {
        self.largeprojectiledamage = 0;
        _id_F1563935AEEB5199 = _id_8ACEB016BAAF67AF;
      }
    }

    if(isDefined(_id_F1563935AEEB5199)) {
      amount = ceil(maxhealth / _id_F1563935AEEB5199);
      _id_F20BC25347C9BAAF = 1;
    }
  }

  if(isDefined(_id_C14F0ED27327131A))
    self.largeprojectiledamage = _id_C14F0ED27327131A;

  _id_E688B198AA9A4B3F = 0;

  if(!_id_F20BC25347C9BAAF && isDefined(objweapon)) {
    amount = scripts\mp\damage::handleshotgundamage(objweapon, meansofdeath, amount);
    amount = scripts\mp\damage::handleapdamage(objweapon, meansofdeath, amount, attacker);
    amount = scripts\mp\damage::_id_5E4AA8D548CC604E(amount, objweapon, attacker, meansofdeath);
    amount = scripts\mp\damage::_id_10268164AB1BCC31(amount, objweapon, attacker);
  }

  if(isDefined(attacker) && isDefined(self.owner) && !_id_E688B198AA9A4B3F) {
    if(isDefined(attacker.owner))
      attacker = attacker.owner;

    if(attacker == self.owner && !istrue(self.killoneshot))
      amount = ceil(amount / 2);
  }

  return int(amount);
}

nulldamagecheck(attacker) {
  return isDefined(attacker) && attacker == self.owner;
}

dodamagetokillstreak(damage, attacker, inflictor, victimteam, _id_5B18ECAACD37D496, meansofdeath, weaponname) {
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  angles = (0, 0, 0);
  normal = (0, 0, 0);
  modelname = "";
  tagname = "";
  partname = "";
  idflags = undefined;

  if(isDefined(victimteam)) {
    if(level.teambased) {
      if(!scripts\mp\utility\entity::isvalidteamtarget(attacker, victimteam, self))
        return;
    } else if(!scripts\mp\utility\entity::isvalidffatarget(attacker, victimteam, self))
      return;
  }

  if(isagent(self))
    self dodamage(damage, _id_5B18ECAACD37D496, attacker, inflictor, meansofdeath, weaponname);
  else if(scripts\cp_mp\vehicles\vehicle::isvehicle())
    self dodamage(damage, _id_5B18ECAACD37D496, attacker, inflictor, meansofdeath, weaponname);
  else {
    weapon = makeweaponfromstring(weaponname);
    self notify("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, _id_5B18ECAACD37D496, angles, normal, inflictor);
  }
}

playdlightfx(_id_046E78EFB23851CA, angleoffset) {
  self endon("death");

  if(!isDefined(_id_046E78EFB23851CA))
    _id_046E78EFB23851CA = (0, 0, 0);

  if(!isDefined(angleoffset))
    angleoffset = (0, 0, 0);

  _id_87C3F78EC1108CDF = scripts\engine\utility::getfx("dlight_large");

  if(istrue(self.isairdrop))
    _id_87C3F78EC1108CDF = scripts\engine\utility::getfx("dlight_small");

  self.fxdlightent = spawn("script_model", self.origin);
  self.fxdlightent setModel("tag_origin");
  self.fxdlightent linkTo(self, "tag_origin", _id_046E78EFB23851CA, angleoffset);
  self.fxdlightent thread deleteonparentdeath(self);
  wait 0.1;
  playFXOnTag(_id_87C3F78EC1108CDF, self.fxdlightent, "tag_origin");
}

deleteonparentdeath(parent) {
  self endon("death");
  parent waittill("death");

  if(isDefined(self))
    self delete();
}

isaffectedbyblindeye(_id_D8061F26B5ECA018) {
  switch (_id_D8061F26B5ECA018) {
    case "sentry_shock":
    case "jackal":
      return 1;
  }

  return 0;
}

getplayerkillstreakcombatmode(ent) {
  combatmode = "NONE";

  if(isDefined(ent.owner) && isDefined(ent.owner.currentcombatmode))
    combatmode = ent.owner.currentcombatmode;

  return combatmode;
}

watchsupertrophynotify(owner) {
  owner endon("disconnect");
  self endon("explode");

  for(;;) {
    owner waittill("destroyed_by_trophy", _id_6B21EA0780AA76FE, _id_C1D3B25C841AF510, _id_D6946BBFC0F7A70B, targetorigin, targetangles);

    if(_id_D6946BBFC0F7A70B != self.weapon_name) {
      continue;
    }
    owner _id_5762AC2F22202BA2::updatedamagefeedback("");
    break;
  }
}

watchhostmigrationlifetime(_id_5303201F58DBBAFE, lifetime, _id_2A8BDE10871BEF3C) {
  if(_id_5303201F58DBBAFE != "death")
    self endon("death");

  self endon(_id_5303201F58DBBAFE);
  level endon("game_ended");
  _id_CEE2BAD66B391C7E = gettime() + int(lifetime * 1000);
  level waittill("host_migration_begin");
  self notify("host_migration_lifetime_update");
  _id_78DE27F09FD0F880 = gettime();
  _id_F88336D2444229A4 = _id_CEE2BAD66B391C7E - _id_78DE27F09FD0F880;
  level waittill("host_migration_end");
  _id_20FDEF21CD9F58B1 = gettime();
  _id_4046BF37E49E7A5C = _id_20FDEF21CD9F58B1 + _id_F88336D2444229A4;
  _id_F88336D2444229A4 = _id_F88336D2444229A4 / 1000;

  if(isDefined(self.streakname) && scripts\cp_mp\utility\killstreak_utility::isridekillstreak(self.streakname))
    self.owner setclientomnvar("ui_killstreak_countdown", _id_4046BF37E49E7A5C);

  self[[_id_2A8BDE10871BEF3C]](_id_F88336D2444229A4);
}

getenemytargets(owner) {
  enemytargets = [];

  foreach(player in level.players) {
    if(owner scripts\cp_mp\utility\player_utility::isenemy(player))
      enemytargets[enemytargets.size] = player;
  }

  return enemytargets;
}

_beginlocationselection(streakname, _id_3922786267CCC2A8, _id_8E536AA74B9C997D, _id_A61C75B156FC1EE0) {
  self beginlocationselection(_id_3922786267CCC2A8, _id_8E536AA74B9C997D, "circle_marker", _id_A61C75B156FC1EE0);
  self.selectinglocation = 1;
  self setblurforplayer(10.3, 0.3);
  thread endselectiononaction("cancel_location");
  thread endselectiononaction("death");
  thread endselectiononaction("disconnect");
  thread endselectiononaction("used");
  thread endselectiononaction("weapon_change");
  self endon("stop_location_selection");
  thread endselectiononendgame();

  if(isDefined(streakname) && self.team != "spectator" && self.team != "codcaster") {
    if(isDefined(self.streakmsg))
      self.streakmsg destroy();

    if(self issplitscreenplayer()) {
      self.streakmsg = scripts\mp\hud_util::createfontstring("default", 1.3);
      self.streakmsg scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -98);
    } else {
      self.streakmsg = scripts\mp\hud_util::createfontstring("default", 1.6);
      self.streakmsg scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -190);
    }
  }
}

stoplocationselection(disconnected, _id_401C3A2E68AAB0FD) {
  if(!isDefined(_id_401C3A2E68AAB0FD))
    _id_401C3A2E68AAB0FD = "generic";

  if(!disconnected) {
    self setblurforplayer(0, 0.3);
    self endlocationselection();
    self.selectinglocation = undefined;

    if(isDefined(self.streakmsg))
      self.streakmsg destroy();
  }

  self notify("stop_location_selection", _id_401C3A2E68AAB0FD);
}

endselectiononaction(_id_B0FDDB86A2358953) {
  self endon("stop_location_selection");
  self waittill(_id_B0FDDB86A2358953);
  thread stoplocationselection(_id_B0FDDB86A2358953 == "disconnect", _id_B0FDDB86A2358953);
}

endselectiononendgame() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  thread stoplocationselection(0, "end_game");
}

streakshouldchain(streakname) {
  _id_C45C5E5081953209 = scripts\mp\killstreaks\killstreaks::calcstreakcost(streakname);
  _id_631DF3F5D4971DDD = scripts\mp\killstreaks\killstreaks::getnextstreakname();
  nextstreakcost = scripts\mp\killstreaks\killstreaks::calcstreakcost(_id_631DF3F5D4971DDD);
  return _id_C45C5E5081953209 < nextstreakcost;
}

streakcheckistargetindoors(targetpos, ignorelist) {
  _id_E3D3DF168F5AFC37 = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(targetpos, targetpos + (0, 0, 10000), ignorelist, contents))
    _id_E3D3DF168F5AFC37 = 1;

  return _id_E3D3DF168F5AFC37;
}

isplayerkillstreak(ent) {
  if(!isDefined(ent.activeplayerstreak))
    return 0;

  switch (ent.activeplayerstreak) {
    default:
      return 0;
  }
}

_id_26AB4629DC655C14(streakname) {
  _id_26AB4629DC655C14 = 0;

  switch (streakname) {
    case "cluster_spike":
      _id_26AB4629DC655C14 = 1;
      break;
  }

  return _id_26AB4629DC655C14;
}

isremotekillstreak(streakname) {
  _id_1450FF6C22427141 = 0;

  switch (streakname) {
    case "gunship":
    case "cruise_predator":
    case "chopper_gunner":
    case "pac_sentry":
    case "assault_drone":
      _id_1450FF6C22427141 = 1;
      break;
  }

  return _id_1450FF6C22427141;
}

isuavkillstreak(streakname) {
  isuav = 0;

  switch (streakname) {
    case "counter_uav":
    case "uav_bigmap":
    case "directional_uav":
    case "uav":
      isuav = 1;
      break;
  }

  return isuav;
}

isairstrikekillstreak(streakname) {
  _id_CC5E6F089D31A891 = 0;

  switch (streakname) {
    case "multi_airstrike":
    case "precision_airstrike":
    case "gunship":
    case "fuel_airstrike":
    case "auto_drone":
    case "nuke":
      _id_CC5E6F089D31A891 = 1;
      break;
  }

  return _id_CC5E6F089D31A891;
}

islittlebirdkillstreak(streakname) {
  _id_68314E70523F69F2 = 0;

  switch (streakname) {
    case "airdrop_multiple":
    case "airdrop":
      _id_68314E70523F69F2 = 1;
      break;
  }

  return _id_68314E70523F69F2;
}

ishelikillstreak(streakname) {
  isheli = 0;

  switch (streakname) {
    case "hover_jet":
    case "chopper_gunner":
    case "airdrop_escort":
      isheli = 1;
      break;
  }

  return isheli;
}

isturretkillstreak(streakname) {
  isturret = 0;

  switch (streakname) {
    case "sentry_gun":
    case "manual_turret":
      isturret = 1;
      break;
  }

  return isturret;
}

isprojectilekillstreak(streakname) {
  _id_D112D057A062EE5E = 0;

  switch (streakname) {
    case "toma_strike":
    case "cruise_predator":
      _id_D112D057A062EE5E = 1;
      break;
  }

  return _id_D112D057A062EE5E;
}

issupportdronekillstreak(streakname) {
  _id_1CDA07AB27D6768E = 0;

  switch (streakname) {
    case "scrambler_drone_guard":
    case "radar_drone_recon":
      _id_1CDA07AB27D6768E = 1;
      break;
  }

  return _id_1CDA07AB27D6768E;
}

isassaultdronekillstreak(streakname) {
  isassaultdrone = 0;

  switch (streakname) {
    case "pac_sentry":
    case "assault_drone":
      isassaultdrone = 1;
      break;
  }

  return isassaultdrone;
}

iscarepackage(ent) {
  return isDefined(ent) && isDefined(ent.id) && ent.id == "care_package";
}

isjuggernaut() {
  return isDefined(self) && istrue(self.isjuggernaut);
}

isremotekillstreakweapon(weapon) {
  _id_608BEF26DD02E2C7 = 0;

  switch (weapon) {
    case "ks_remote_bomber_mp":
    case "ks_remote_drone_mp":
    case "ks_remote_hack_mp":
    case "ks_remote_gunship_mp":
    case "ks_remote_nuke_mp":
    case "ks_remote_map_mp":
    case "ks_remote_device_mp":
    case "ks_assault_drone_mp":
      _id_608BEF26DD02E2C7 = 1;
      break;
  }

  return _id_608BEF26DD02E2C7;
}

iskillstreaklockonable(streakname) {
  switch (streakname) {
    case "directional_uav":
    case "cruise_predator":
      return 0;
    default:
      return 1;
  }
}

isflyingkillstreak(streakname) {
  switch (streakname) {
    case "airdrop_assault":
    case "airdrop_sentry_minigun":
    case "helicopter":
    case "drone_hive":
    case "heli_pilot":
    case "airdrop":
    case "precision_airstrike":
    case "gunship":
      return 1;
    default:
      return 0;
  }
}

getkillstreakkills(streakname) {
  _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[streakname];

  if(!isDefined(_id_D442547D75DFFD09))
    return 0;

  cost = _id_D442547D75DFFD09.kills;

  if(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak") && streakname != "nuke")
    cost = _id_D442547D75DFFD09._id_A9C1A97568AFD1DC;
  else if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks"))
    cost = _id_D442547D75DFFD09._id_7A51669873868DD9;

  return scripts\engine\utility::ter_op(isDefined(cost), cost, 0);
}

getkillstreakoverheadicon(streakname) {
  _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[streakname];

  if(!isDefined(_id_D442547D75DFFD09))
    return "";

  return scripts\engine\utility::ter_op(isDefined(_id_D442547D75DFFD09._id_890BC2DE5DEADF64), _id_D442547D75DFFD09._id_890BC2DE5DEADF64, "");
}

currentactivevehiclecount(extra) {
  if(!isDefined(extra))
    extra = 0;

  count = extra;

  if(isDefined(level.helis))
    count = count + level.helis.size;

  if(isDefined(level.littlebirds))
    count = count + level.littlebirds.size;

  if(isDefined(level.ugvs))
    count = count + level.ugvs.size;

  if(isDefined(level.bradley) && isDefined(level.bradley.vehicles))
    count = count + level.bradley.size;

  if(isDefined(level.supportdrones))
    count = count + level.supportdrones.size;

  if(isDefined(level.assaultdrones))
    count = count + level.assaultdrones.size;

  return count;
}

maxvehiclesallowed() {
  return 8;
}

fauxvehiclecount() {
  return level.fauxvehiclecount;
}

incrementfauxvehiclecount(value) {
  if(!isDefined(value))
    level.fauxvehiclecount++;
  else
    level.fauxvehiclecount = level.fauxvehiclecount + value;
}

decrementfauxvehiclecount(value) {
  if(!isDefined(value))
    level.fauxvehiclecount--;
  else
    level.fauxvehiclecount = level.fauxvehiclecount - value;

  if(level.fauxvehiclecount < 0)
    level.fauxvehiclecount = 0;
}

isassaultkillstreak(_id_3BBEDEB9EB59D6A7) {
  switch (_id_3BBEDEB9EB59D6A7) {
    case "drone_hive":
    case "directional_uav":
    case "uav":
      return 1;
    default:
      return 0;
  }
}

isresourcekillstreak(_id_3BBEDEB9EB59D6A7) {
  switch (_id_3BBEDEB9EB59D6A7) {
    case "sam_turret":
    case "deployable_vest":
    case "aa_launcher":
    case "recon_agent":
    case "deployable_ammo":
    case "uav_3dping":
      return 1;
    default:
      return 0;
  }
}

issupportkillstreak(_id_3BBEDEB9EB59D6A7) {
  switch (_id_3BBEDEB9EB59D6A7) {
    default:
      return 0;
  }
}

isspecialistkillstreak(_id_3BBEDEB9EB59D6A7) {
  switch (_id_3BBEDEB9EB59D6A7) {
    default:
      return 0;
  }
}

gethelipilotmeshoffset() {
  return (0, 0, 5000);
}

gethelipilottraceoffset() {
  return (0, 0, 2500);
}

isnavmeshkillstreak(streakname) {
  _id_FE959831F166B337 = 0;
  return _id_FE959831F166B337;
}

iscontrollingproxyagent() {
  _id_9142BCF70507DD5E = 0;

  if(isDefined(self.playerproxyagent) && isalive(self.playerproxyagent))
    _id_9142BCF70507DD5E = 1;

  return _id_9142BCF70507DD5E;
}

killshouldaddtokillstreak(objweapon) {
  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets"))
    return 0;

  return !_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) && scripts\mp\utility\points::_id_CADDF81C02734FA0(objweapon);
}

getairdropcrates() {
  if(isDefined(level.cratedata))
    return level.cratedata.crates;

  return [];
}

getnumairdropcrates() {
  if(isDefined(level.cratedata))
    return level.cratedata.crates.size;

  return 0;
}

attackerinremotekillstreak() {
  if(!isDefined(self))
    return 0;

  if(isDefined(level.gunshipplayer) && self == level.gunshipplayer)
    return 1;

  if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && self == level.chopper.gunner)
    return 1;

  if(isDefined(self.using_remote_tank) && self.using_remote_tank)
    return 1;

  return 0;
}

killstreak_make_vehicle(streakname, scorepopup, vodestroyed, destroyedsplash) {
  self.vehiclename = streakname;
  self.scorepopup = scorepopup;
  self.vodestroyed = vodestroyed;
  self.destroyedsplash = destroyedsplash;
  self enableplayermarks("killstreak");

  if(level.teambased)
    self filteroutplayermarks(self.team);
  else
    self filteroutplayermarks(self.owner);

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(streakname, 1);
}

killstreak_vehicle_callback_init() {
  if(!istrue(level.kscallbackinitcomplete)) {
    level.kscallbackinitcomplete = 1;
    level.kspremoddamagecallback = ::killstreak_pre_mod_damage_callback;
    level.kspostmoddamagecallback = ::killstreak_post_mod_damage_callback;
    level.ksdeathcallback = ::killstreak_death_callback;
  }
}

killstreak_pre_mod_damage_callback(data) {
  damage = data.damage;
  attacker = data.attacker;

  if(!istrue(self.killoneshot) && !istrue(self._id_1FAA3D3DEC8D49BD)) {
    if(isDefined(attacker) && isDefined(self.owner) && attacker == self.owner)
      damage = int(ceil(damage * 0.5));

    data.damage = damage;
  }

  _id_35AB2DABE0210D0F = 1;
  _id_BACC6DD14316758C = self.kspremoddamagecallback;

  if(isDefined(_id_BACC6DD14316758C))
    _id_35AB2DABE0210D0F = self[[_id_BACC6DD14316758C]](data);

  return _id_35AB2DABE0210D0F;
}

killstreak_post_mod_damage_callback(data) {
  scripts\mp\killstreaks\killstreaks::killstreakhit(data.attacker, data.objweapon, self, data.meansofdeath, data.damage);
  _id_35AB2DABE0210D0F = 1;
  _id_7DA88D9C69433487 = self.kspostmoddamagecallback;

  if(isDefined(_id_7DA88D9C69433487))
    _id_35AB2DABE0210D0F = self[[_id_7DA88D9C69433487]](data);

  return _id_35AB2DABE0210D0F;
}

killstreak_death_callback(data) {
  scripts\mp\damage::onkillstreakkilled(self.streakname, data.attacker, data.objweapon, data.meansofdeath, data.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  _id_35AB2DABE0210D0F = 1;
  deathcallback = self.ksdeathcallback;

  if(isDefined(deathcallback))
    _id_35AB2DABE0210D0F = self[[deathcallback]](data);

  return _id_35AB2DABE0210D0F;
}

killstreak_set_pre_mod_damage_callback(streakname, _id_BACC6DD14316758C) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(streakname, level.kspremoddamagecallback);
  self.kspremoddamagecallback = _id_BACC6DD14316758C;
}

killstreak_set_post_mod_damage_callback(streakname, _id_7DA88D9C69433487) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(streakname, level.kspostmoddamagecallback);
  self.kspostmoddamagecallback = _id_7DA88D9C69433487;
}

killstreak_set_death_callback(streakname, deathcallback) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_death_callback(streakname, level.ksdeathcallback);
  self.ksdeathcallback = deathcallback;
}

getkillstreaknamefromweapon(objweapon) {
  basename = objweapon.basename;

  if(isDefined(level.killstreakweaponmap[basename]))
    return level.killstreakweaponmap[basename];

  return undefined;
}