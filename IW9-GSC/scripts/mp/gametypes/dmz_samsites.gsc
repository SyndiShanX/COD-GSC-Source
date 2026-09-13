/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_samsites.gsc
*************************************************/

_id_AD4172A44F169CB6() {
  if(!getdvarint("scr_dmz_samsites", 1)) {
    return;
  }
  level._id_D57C61FE001F1707 = spawnStruct();
  level._id_D57C61FE001F1707._id_AB56B9F3B70782A6 = getdvarint("dvar_BC26DF7F41837A1E", 3);
  level._id_D57C61FE001F1707._id_5975A9EF47C4674C = getdvarint("dvar_BC02F17F415B26FC", 7);
  level._id_D57C61FE001F1707._id_B78DD701038464F7 = getdvarint("dvar_05054D40F0BA76B1", 0);
  level._id_D57C61FE001F1707._id_029A79D378C70E0B = getdvarint("dvar_E8C36536AFD06323", 512);
  level._id_D57C61FE001F1707._id_C1EF96A923174C76 = getdvarint("dvar_65A4247A6A99D511", 500);
  level._id_D57C61FE001F1707._id_85BCA90B94DBBC20 = getdvarint("dvar_A9B2FFCF64BCDDF3", -50);
  level._id_D57C61FE001F1707.capturetime = getdvarint("dvar_A47D932B5DCB7A74", 60);
  level._id_D57C61FE001F1707._id_36576A67F06F7657 = getdvarint("dvar_CC862F7D0A6C378F", 5000);
  level._id_D57C61FE001F1707._id_AAFBA8D70563022B = getdvarint("dvar_AB0966FACF3E7683", 300);
  level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9 = getdvarint("dvar_7A4C18BDA90EAE0C", 16000);
  level._id_D57C61FE001F1707._id_F4F7F8E7AA14EE19 = getdvarint("dvar_C858E5FF90540E26", 50000);
  level._id_D57C61FE001F1707._id_D0F63034F54017E3 = getdvarint("dvar_7FF620132228B8A9", 2500);
  level._id_D57C61FE001F1707._id_A0B9A15E69B57D09 = getdvarint("dvar_53EFF3ABAE42511B", 1);
  level._id_D57C61FE001F1707._id_2A1F5932AA000DCB = getdvarint("dvar_1B80B788C9C3DA45", 1);
  level._id_D57C61FE001F1707._id_F2E28100A201E1D4 = getdvarint("dvar_A5B87D62EE975707", 1);
  level._id_D57C61FE001F1707._id_91701C5F0103B916 = getdvarint("dvar_175730BCCA744C75", 1);
  level._id_D57C61FE001F1707._id_4BB2FF3E6E82C373 = getdvarint("dvar_E2C51295CA08D914", 5);
  level._id_D57C61FE001F1707._id_FFB94540411249A9 = getdvarint("dvar_FCAF02F59D6AA9CE", 8);
  level._id_D57C61FE001F1707._id_FA3D844D56938A31 = getdvarint("dvar_3BB5A9C980D546D9", 8);
  level._id_D57C61FE001F1707._id_A098A0B9DBCFC30D = getdvarint("dvar_B6AADDBF47FC8DB6", 1);
  level._id_D57C61FE001F1707._id_125035462230088F = getdvarint("dvar_9134BB0C8C176121", 40);
  level._id_D57C61FE001F1707._id_18BE0584E3DC6151 = getdvarint("dvar_B2BACDB9FAC9E30F", 80);
  level._id_D57C61FE001F1707._id_5D016CC8C6057E32 = getdvarint("dvar_834C9AD109576FE1", 30);
  level._id_D57C61FE001F1707._id_FA313E2C568DBC16 = getdvarint("dvar_85B709709C5294AE", 1);
  level._id_D57C61FE001F1707._id_811577C954AEAC09 = getdvarint("dvar_5A734E432DD09671", 1);
  level._id_D57C61FE001F1707._id_0A8AE8076D571811 = getdvarint("dvar_BF8E2691659D83DF", 1000000);
  level._id_D57C61FE001F1707._id_5C03240772908114 = getdvarint("dvar_BA806C360E59EF1E", 500000);
  level._id_D57C61FE001F1707.travelspeed = getdvarint("dvar_2D20C5ED21B56E40", 2000);
  _id_A3D06C05AA850DED = getdvarint("dvar_437436F2598F5EDA", 200);
  level._id_D57C61FE001F1707._id_1B52E473AAE939E3 = _id_A3D06C05AA850DED * _id_A3D06C05AA850DED;
  _id_5EA3FE433148FA9F();
  level._effect["samsite_bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._id_9215E3A9DFE8A262 = ::_id_2CCF2416263812E2;
  level._id_D8D4808549090419 = ::_id_36DC1A84DE5BDB04;
  level._id_4691A578582AF454 = ::_id_C35CCF109CB08D19;
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_samsite_base", ::_id_5E0B45946652EEB3);
  _id_D805A86A5FE7AAF2 = getEntArray("dmz_samsite_brushmodel", "script_noteworthy");

  if(isDefined(_id_D805A86A5FE7AAF2))
    level._id_308F0EB1D9BD3F25 = _id_D805A86A5FE7AAF2[0];

  level._id_721546C4F8DF565D = [];

  foreach(team in level.teamnamelist) {
    start = level.teamdata[team]["startPoint"];

    if(!isDefined(start)) {
      continue;
    }
    if(!isDefined(level._id_721546C4F8DF565D[start._id_B205D90302DA2F07]))
      level._id_721546C4F8DF565D[start._id_B205D90302DA2F07] = [];

    level._id_721546C4F8DF565D[start._id_B205D90302DA2F07][level._id_721546C4F8DF565D[start._id_B205D90302DA2F07].size] = start;
  }

  locations = scripts\engine\utility::getStructArray("dmz_samsite", "targetname");
  _id_371C833EBA04930E = _id_5DEF7AF2A9F04234::_id_7E9CBC0F32DE6578();
  level._id_086CDE7DDE516573 = [];
  _id_622366932D8EA2CB = [];

  foreach(_id_AC0E594AC96AA3A8, location in locations) {
    if(!isDefined(location._id_B205D90302DA2F07))
      location._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(location.origin);

    _id_B205D90302DA2F07 = location._id_B205D90302DA2F07;

    if(!isDefined(_id_B205D90302DA2F07) || _id_371C833EBA04930E && !_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_B205D90302DA2F07)) {
      continue;
    }
    location.score = _id_E2D9A460B285095E(location);

    if(isDefined(_id_622366932D8EA2CB[_id_B205D90302DA2F07]) && _id_622366932D8EA2CB.size > 0) {
      if(_id_622366932D8EA2CB[_id_B205D90302DA2F07].score < location.score)
        _id_622366932D8EA2CB[_id_B205D90302DA2F07] = location;

      continue;
    }

    _id_622366932D8EA2CB[_id_B205D90302DA2F07] = location;
  }

  foreach(node in _id_622366932D8EA2CB)
  level._id_086CDE7DDE516573[level._id_086CDE7DDE516573.size] = node;

  level._id_CF3FEEAA65A4E3F0 = [];
  _id_FC617751F654A141 = randomintrange(level._id_D57C61FE001F1707._id_AB56B9F3B70782A6, level._id_D57C61FE001F1707._id_5975A9EF47C4674C + 1);

  if(istrue(level._id_D57C61FE001F1707._id_B78DD701038464F7)) {
    level._id_086CDE7DDE516573 = locations;
    _id_FC617751F654A141 = level._id_086CDE7DDE516573.size;
  }

  level._id_086CDE7DDE516573 = scripts\engine\utility::array_randomize(level._id_086CDE7DDE516573);

  for(_id_62E50AD3144802A8 = 0; _id_62E50AD3144802A8 < _id_FC617751F654A141 && _id_62E50AD3144802A8 < level._id_086CDE7DDE516573.size; _id_62E50AD3144802A8++) {
    node = level._id_086CDE7DDE516573[_id_62E50AD3144802A8];
    _id_C327ADFAD89EFC23 = _id_4BCDAA72E4FE9480(node);
    _id_C327ADFAD89EFC23 _id_0A94F5CEEAE751B8();
    _id_C327ADFAD89EFC23._id_B3AEFAFBA795117F = spawn("script_model", _id_C327ADFAD89EFC23.origin + (0, 0, 9000) + anglesToForward(_id_C327ADFAD89EFC23.angles) * 10000);
    _id_C327ADFAD89EFC23 settargetentity(_id_C327ADFAD89EFC23._id_B3AEFAFBA795117F);
    _id_C327ADFAD89EFC23 _id_DD951B288C7C19F8(node);
    _id_C327ADFAD89EFC23.curorigin = _id_C327ADFAD89EFC23.origin;
    _id_C327ADFAD89EFC23.offset3d = (0, 0, 100);
    _id_C327ADFAD89EFC23 scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
    scripts\mp\objidpoolmanager::update_objective_icon(_id_C327ADFAD89EFC23.objidnum, "ui_map_icon_obj_sam_site");
    scripts\mp\objidpoolmanager::update_objective_setbackground(_id_C327ADFAD89EFC23.objidnum, 4);
    objective_setbackground(_id_C327ADFAD89EFC23.objidnum, 1);
    objective_setpinned(_id_C327ADFAD89EFC23.objidnum, 1);
    objective_position(_id_C327ADFAD89EFC23.objidnum, _id_C327ADFAD89EFC23.origin + (0, 0, 50));
    objective_addalltomask(_id_C327ADFAD89EFC23.objidnum);
    objective_hidefromplayersinmask(_id_C327ADFAD89EFC23.objidnum);
    numagents = randomintrange(level._id_D57C61FE001F1707._id_4BB2FF3E6E82C373, level._id_D57C61FE001F1707._id_FFB94540411249A9 + 1);
    _id_C327ADFAD89EFC23 thread _id_920E785CFDD82B86(numagents);
    _id_C327ADFAD89EFC23._id_08EA2BEB55597DB7 = [];
    _id_C327ADFAD89EFC23 thread _id_594D850004436026();
  }

  thread _id_18A561A377CAC8A7();
  thread _id_CC5FA2FBA2F077A0();
}

_id_CC5FA2FBA2F077A0() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0) {
    foreach(player in level.players)
    _id_C327ADFAD89EFC23 enablescriptableplayeruse(player);
  }
}

#using_animtree("script_model");

_id_5EA3FE433148FA9F() {
  level.scr_animtree["samsite"] = #animtree;
  level.scr_anim["samsite"]["fire"] = level._id_1A209BD995A7FA83["iw9_mp_prop_samsite_launch"];
  animindex = "outro_gunship_death";
  level.scr_animtree["gunship"] = #animtree;
  level.scr_anim["gunship"][animindex] = % mp_acharlie130_death;
  level.scr_animname["gunship"][animindex] = "mp_acharlie130_death";
}

_id_E2D9A460B285095E(location) {
  score = 0;

  if(isDefined(level._id_721546C4F8DF565D[location._id_B205D90302DA2F07])) {
    foreach(start in level._id_721546C4F8DF565D[location._id_B205D90302DA2F07])
    score = score + distancesquared(location.origin, start.origin);
  }

  return score;
}

_id_4BCDAA72E4FE9480(location) {
  base = spawnscriptable("dmz_samsite_base", location.origin, location.angles);
  _id_C327ADFAD89EFC23 = spawnturret("misc_turret", location.origin, "dmz_sam_site_tur");
  base._id_C327ADFAD89EFC23 = _id_C327ADFAD89EFC23;
  _id_C327ADFAD89EFC23.base = base;

  if(!isDefined(location.angles))
    location.angles = (0, 0, 0);

  _id_C327ADFAD89EFC23.angles = location.angles;
  _id_C327ADFAD89EFC23 setModel("military_dmz_sam_site_turret_rig");
  _id_C327ADFAD89EFC23 settoparc(90);
  _id_C327ADFAD89EFC23 setbottomarc(0);
  _id_C327ADFAD89EFC23 setleftarc(360);
  _id_C327ADFAD89EFC23 setrightarc(360);
  _id_C327ADFAD89EFC23 setscriptablepartstate("dmz_samsite_base", "usable");
  _id_C327ADFAD89EFC23.icon = spawnscriptable("dmz_samsite_icon", _id_C327ADFAD89EFC23.origin, _id_C327ADFAD89EFC23.angles);
  _id_C327ADFAD89EFC23.icon setscriptablepartstate("icon", "healthy");
  _id_BC373C79FEFD251E = _id_C327ADFAD89EFC23.origin + 35 * anglesToForward(_id_C327ADFAD89EFC23.angles);
  _id_C327ADFAD89EFC23.navobstacleid = createnavobstaclebybounds(_id_BC373C79FEFD251E, (150, 120, 200), _id_C327ADFAD89EFC23.angles);

  if(isDefined(level._id_308F0EB1D9BD3F25)) {
    collision = spawn("script_model", _id_C327ADFAD89EFC23.origin);
    collision dontinterpolate();
    collision.angles = _id_C327ADFAD89EFC23.angles;
    collision clonebrushmodeltoscriptmodel(level._id_308F0EB1D9BD3F25);
    thread _id_7EF46292D6FB27B7(_id_C327ADFAD89EFC23, collision);
    collision setentityowner(_id_C327ADFAD89EFC23);
    collision disconnectPaths();
    collision.moverdoesnotkill = 1;
    collision._id_C327ADFAD89EFC23 = _id_C327ADFAD89EFC23;
    _id_C327ADFAD89EFC23.collision = collision;
    _id_C327ADFAD89EFC23 validatecollision(collision, level._id_308F0EB1D9BD3F25);
  }

  _id_C327ADFAD89EFC23 maketurretinoperable();
  _id_C327ADFAD89EFC23._id_073A88C066044E54 = 0;
  _id_C327ADFAD89EFC23._id_B205D90302DA2F07 = location._id_B205D90302DA2F07;
  _id_C327ADFAD89EFC23._id_90FB369A18926018 = [];
  level._id_CF3FEEAA65A4E3F0[level._id_CF3FEEAA65A4E3F0.size] = _id_C327ADFAD89EFC23;
  _id_E7D351AC340ECBF8 = scripts\engine\utility::getStructArray(location.target, "targetname");
  _id_C327ADFAD89EFC23._id_1E7ACA1E7D552608 = [];

  foreach(_id_E0386CBFBCCBBC5B in _id_E7D351AC340ECBF8) {
    if(isDefined(_id_E0386CBFBCCBBC5B.script_noteworthy) && issubstr(_id_E0386CBFBCCBBC5B.script_noteworthy, "guard"))
      _id_C327ADFAD89EFC23._id_1E7ACA1E7D552608[_id_C327ADFAD89EFC23._id_1E7ACA1E7D552608.size] = _id_E0386CBFBCCBBC5B;
  }

  return _id_C327ADFAD89EFC23;
}

_id_7EF46292D6FB27B7(_id_C327ADFAD89EFC23, brushmodel) {
  level endon("game_ended");
  tag = "tag_aim_animated";
  offset = (-14, 0, -88);
  angleoffset = (30.5, 0, 0);

  while(isDefined(_id_C327ADFAD89EFC23) && isDefined(brushmodel)) {
    tagorigin = _id_C327ADFAD89EFC23 gettagorigin(tag);
    _id_A43B0202C06E0907 = _id_C327ADFAD89EFC23 gettagangles(tag);
    _id_8D7B73CB1C4AB0E9 = _func_4AD9053267734CF2(offset, tagorigin, _id_A43B0202C06E0907);
    _id_A4A389D51E640577 = combineangles(_id_A43B0202C06E0907, angleoffset);
    brushmodel.origin = _id_8D7B73CB1C4AB0E9;
    brushmodel.angles = _id_A4A389D51E640577;
    waitframe();
  }
}

_id_87EA19D8830EA0B3(index) {
  return "mg0" + (index + 1);
}

_id_CC25275B4F14DF1B(num) {
  if(level._id_D57C61FE001F1707._id_811577C954AEAC09) {
    tag = _id_87EA19D8830EA0B3(num);
    self showpart(tag);
    self.missiles[num] = 1;
  } else
    self.missiles[num] = 1;
}

_id_0A94F5CEEAE751B8() {
  if(!isDefined(self.missiles))
    self.missiles = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    _id_CC25275B4F14DF1B(_id_AC0E594AC96AA3A8);
}

_id_13FFBC8076C6A2F3(_id_1600845F933938D5, target) {
  self endon("death");
  tag = _id_87EA19D8830EA0B3(_id_1600845F933938D5);

  if(level._id_D57C61FE001F1707._id_811577C954AEAC09) {
    if(!isDefined(self.missiles[_id_1600845F933938D5])) {
      return;
    }
    self.missiles[_id_1600845F933938D5] = undefined;
    self hidepart(tag);
  } else {
    if(!isDefined(self.missiles[_id_1600845F933938D5])) {
      return;
    }
    self.missiles[_id_1600845F933938D5] = undefined;
  }

  self setscriptablepartstate("launch", "on");
  origin = self gettagorigin(tag);
  angles = self gettagangles(tag);
  forward = anglesToForward(angles);
  _id_3865E73449A5A438 = makeweapon("samsite_missile_weapon");
  owner = undefined;

  if(isDefined(self._id_3A94ED22775A3C94) && isDefined(scripts\mp\utility\teams::getteamdata(self._id_3A94ED22775A3C94, "players"))) {
    players = scripts\mp\utility\teams::getteamdata(self._id_3A94ED22775A3C94, "players");

    if(players.size > 0)
      owner = players[0];
  }

  _id_D42E799E256E8C7A = scripts\cp_mp\utility\weapon_utility::_magicbullet(_id_3865E73449A5A438, origin, origin + forward * 1000, owner);
  self._id_D42E799E256E8C7A = _id_D42E799E256E8C7A;
  _id_D42E799E256E8C7A._id_C327ADFAD89EFC23 = self;
  _id_D42E799E256E8C7A setModel("military_dmz_sam_site_missile");
  _id_D42E799E256E8C7A setentityowner(self);
  _id_D42E799E256E8C7A._id_3A94ED22775A3C94 = self._id_3A94ED22775A3C94;
  self._id_073A88C066044E54++;
  _id_D42E799E256E8C7A setscriptablepartstate("military_samsite_missile", "on");
  _id_D42E799E256E8C7A thread _id_EA701DE0C74B3D7A(target);
  _id_D42E799E256E8C7A thread _id_A9720AE0CD1C43EC(target);
}

_id_EA701DE0C74B3D7A(target) {
  if(isDefined(target) && isDefined(target.ent) && isDefined(self)) {
    if(target.type == 0)
      self missile_settargetEnt(target.ent, (0, 0, -100));
    else if(target.type == 1)
      self missile_settargetEnt(target.ent, (level._id_D57C61FE001F1707.travelspeed, 0, 0));
    else if(target.type == 2)
      self missile_settargetEnt(target.ent, (0, 0, -100));
    else if(target.type == 3)
      self missile_settargetEnt(target.ent, (0, 0, -100));

    self missile_setflightmodedirect();
    self.lockontarget = target.ent;
    thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(target.ent, self);
    wait 4.0;

    if(isDefined(self))
      self notify("clearTargetLockedOntoByProjectile");
  }
}

_id_A9720AE0CD1C43EC(target) {
  level endon("game_ended");

  if(isDefined(target) && target.type == 1) {
    for(;;) {
      if(!isDefined(self) || !isDefined(target) || !isDefined(target.ent)) {
        return;
      }
      dist = distance(target.ent.origin, self.origin);

      if(dist < 600) {
        thread _id_666AD4E4E3CC4524(target.ent, self._id_3A94ED22775A3C94);
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("samsite_plane_hit", self._id_3A94ED22775A3C94);
        _id_6A8EC730B2BFA844::_id_19D6E799236E4435(self);
        self delete();
        return;
      }

      waitframe();
    }
  }
}

_id_666AD4E4E3CC4524(plane, team) {
  level._id_D57C61FE001F1707._id_CF0B6780C2D8A0F8 = 1;

  if(!istrue(plane.hit)) {
    plane notify("plane_hit", team);
    plane setCanDamage(0);
    plane.hit = 1;
    plane _id_4C4DBF406A67CE68();
    plane _id_25184BB26F5D9B31();
  }
}

_id_CE2565296095B940(target) {
  if(!isDefined(self._id_CC54CBA4C1D60EA4))
    self._id_CC54CBA4C1D60EA4 = 0;

  thread _id_13FFBC8076C6A2F3(self._id_CC54CBA4C1D60EA4, target);
  self._id_CC54CBA4C1D60EA4 = (self._id_CC54CBA4C1D60EA4 + 1) % 4;
  wait 1.0;

  if(self._id_CC54CBA4C1D60EA4 == 0 && self._id_073A88C066044E54 < level._id_D57C61FE001F1707._id_FA3D844D56938A31) {
    wait 5.0;
    _id_0A94F5CEEAE751B8();
  }
}

_id_AB3D52600E20B324() {
  for(;;) {
    thread _id_13FFBC8076C6A2F3(0);
    wait 5.0;
    thread _id_13FFBC8076C6A2F3(1);
    wait 5.0;
    thread _id_13FFBC8076C6A2F3(2);
    _id_0A94F5CEEAE751B8();
    wait 5.0;
  }
}

_id_FBFACB92D755DEDC(target) {
  velocity = undefined;
  origin = undefined;

  if(target.type == 0) {
    heli = target.ent;
    velocity = heli vehicle_getvelocity();
    origin = heli.occupants["driver"].origin;
  } else if(target.type == 1) {
    c130 = target.ent;
    velocity = c130.velocity;
    origin = c130.origin;
  } else if(target.type == 2 || target.type == 3) {
    heli = target.ent;
    velocity = heli vehicle_getvelocity();
    origin = heli.origin;
  }

  if(!isDefined(velocity) || !isDefined(origin))
    return undefined;

  dist = distance(self.origin, origin);
  _id_BA1ADD3AFE35926A = 6000;
  _id_D1E7847092585DDB = dist / _id_BA1ADD3AFE35926A;
  return origin + velocity * _id_D1E7847092585DDB;
}

_id_12EED3315BE94B9E(target) {
  _id_77294299D5BEE66B = 50;
  _id_F58FF7E9A26FD75D = 50;
  duration = 5.0;
  timer = 0.0;
  _id_316BDF341C07246B = 0;

  while(timer < duration && isDefined(self._id_3A94ED22775A3C94)) {
    if(!isDefined(target) || !isDefined(target.ent) || !_id_66BA1EE70DFA7F10(target))
      return 0;

    origin = target.ent.origin;
    _id_5FBECC8C72D34761 = [self];
    _id_C3BFCBF4E5BA2624 = self gettagorigin("tag_aim_animated");
    trace = scripts\engine\trace::ray_trace(_id_C3BFCBF4E5BA2624, origin, _id_5FBECC8C72D34761, undefined, 0, 1);
    _id_30E65BD6257F2186 = distance(self.origin, origin) * (1 - trace["fraction"]);

    if(_id_30E65BD6257F2186 > 200.0)
      return 0;

    if(isDefined(self.entlockedonto) && self.entlockedonto != target.ent)
      scripts\cp_mp\utility\weapon_utility::removelockedon(target.ent, self);

    if(!isDefined(self.entlockedonto))
      scripts\cp_mp\utility\weapon_utility::addlockedon(target.ent, self);

    origin = _id_FBFACB92D755DEDC(target);

    if(!isDefined(origin))
      return 0;

    _id_BB709894B649925B = vectorNormalize(origin - _id_C3BFCBF4E5BA2624) * 1000;
    self._id_B3AEFAFBA795117F.origin = _id_C3BFCBF4E5BA2624 + _id_BB709894B649925B;
    _id_D31AC54D3A05AD86 = anglesToForward(self gettagangles("tag_aim_animated")) * 1000;
    angle = scripts\engine\math::anglebetweenvectors(origin - _id_C3BFCBF4E5BA2624, _id_D31AC54D3A05AD86);

    if(abs(angle) > 15 && !_id_316BDF341C07246B) {
      self setscriptablepartstate("lock_start_audio", "on");
      _id_316BDF341C07246B = 1;
    }

    if(abs(angle) < 5)
      return 1;

    timer = timer + level.framedurationseconds;
    waitframe();
  }

  return 0;
}

_id_005B157A05A421CB(target) {
  if(self._id_073A88C066044E54 < level._id_D57C61FE001F1707._id_FA3D844D56938A31) {
    if(target.type == 1)
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("samsite_nearby_plane", self._id_3A94ED22775A3C94);
    else if(target.type == 0)
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("samsite_enemy_heli", self._id_3A94ED22775A3C94);

    self setscriptablepartstate("audio", "rotate_start");
    _id_F73F345E91F4546A = _id_12EED3315BE94B9E(target);
    self setscriptablepartstate("audio", "rotate_stop");

    if(isDefined(target.ent) && isDefined(target.ent.attackerslockedon) && isDefined(target.ent.attackerslockedon[self getentitynumber()]) && target.ent.attackerslockedon[self getentitynumber()] == self)
      scripts\cp_mp\utility\weapon_utility::removelockedon(target.ent, self);

    if(_id_F73F345E91F4546A) {
      self setscriptablepartstate("lock_fire_audio", "on");
      wait 0.3;
      _id_CE2565296095B940(target);
    }
  }
}

_id_66BA1EE70DFA7F10(target) {
  switch (target.type) {
    case 0:
      heli = target.ent;
      return heli.occupants.size && isDefined(self._id_3A94ED22775A3C94) && isDefined(heli.occupants["driver"]) && heli.occupants["driver"].team != self._id_3A94ED22775A3C94 && distance(heli.origin, self.origin) < level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9;
    case 1:
      c130 = target.ent;
      return isDefined(self._id_3A94ED22775A3C94) && distance2d(c130.origin, self.origin) < level._id_D57C61FE001F1707._id_F4F7F8E7AA14EE19 && !istrue(c130.hit);
    case 2:
      heli = target.ent;
      return isDefined(self._id_3A94ED22775A3C94) && distance(heli.origin, self.origin) < level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9;
    case 3:
      heli = target.ent;
      return isDefined(self._id_3A94ED22775A3C94) && distance(heli.origin, self.origin) < level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9;
  }
}

_id_F4442F000C3A0FEC(target) {
  switch (target.type) {
    case 0:
      return 100;
    case 1:
      return 200;
    case 2:
      return 300;
    case 3:
      return 50;
  }
}

_id_594D850004436026() {
  level endon("game_ended");

  if(getdvarint("dvar_E7366D21F0D5D8A0", 1) == 0) {
    return;
  }
  for(;;) {
    _id_A81AF2627597688A = isDefined(self._id_3A94ED22775A3C94);

    if(_id_A81AF2627597688A && isDefined(self._id_08EA2BEB55597DB7) && self._id_08EA2BEB55597DB7.size > 0) {
      besttarget = undefined;
      _id_24FF44101B202835 = [];
      priority = 0;

      foreach(target in self._id_08EA2BEB55597DB7) {
        if(isDefined(target.ent) && _id_66BA1EE70DFA7F10(target)) {
          _id_24FF44101B202835[_id_24FF44101B202835.size] = target;
          _id_506AAEEFD9242A6C = _id_F4442F000C3A0FEC(target);

          if(priority <= _id_506AAEEFD9242A6C) {
            besttarget = target;
            priority = _id_506AAEEFD9242A6C;
          }
        }
      }

      self._id_08EA2BEB55597DB7 = _id_24FF44101B202835;

      if(isDefined(besttarget))
        _id_005B157A05A421CB(besttarget);
    }

    wait 2.0;
  }
}

_id_DD951B288C7C19F8(location) {
  self._id_594D7B859FDB06F7 = [];

  if(isDefined(location.target)) {
    nodes = scripts\engine\utility::getStructArray(location.target, "targetname");

    foreach(node in nodes) {
      switch (node.script_noteworthy) {
        case "guard_sniper":
          self._id_594D7B859FDB06F7[self._id_594D7B859FDB06F7.size] = node;
          break;
      }
    }
  }
}

_id_920E785CFDD82B86(numagents) {
  while(!isDefined(level.struct_class_names) || !isDefined(level._id_41670C1C65F3D3CF) || _func_9A83377C98BCE82A("everybody") <= 0)
    waitframe();

  self.numagents = 0;
  self.agents = [];

  if(isDefined(self._id_1E7ACA1E7D552608) && self._id_1E7ACA1E7D552608.size >= 3) {
    foreach(node in self._id_1E7ACA1E7D552608) {
      _id_A784428198C5658B = issubstr(node.script_noteworthy, "stationary");
      agent = _id_48814951E916AF89::_id_591B22E0CA8A8BE1(node, _id_A784428198C5658B, undefined, "medium", "mission", "samInitialGuards");

      if(isDefined(agent))
        self.agents[self.agents.size] = agent;
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "overwatch");
      _id_0FB30E2E6ACA1D19 = randomfloatrange(144, 360);
      forward = anglesToForward(self.angles) * _id_0FB30E2E6ACA1D19;
      right = vectorcross((0, 0, 1), forward);
      _id_CB88E484EB1A3A92 = axistoangles(forward, right, (0, 0, 1));
      _id_88B83B0D7A43EA72 = _id_AC0E594AC96AA3A8 / numagents * 360 + randomfloatrange(-30.0, 30.0) % 360;
      offset = rotatepointaroundvector((0, 0, 1), forward, _id_88B83B0D7A43EA72);
      origin = self.origin + offset;

      if(issubstr(aitype, "sniper") && isDefined(self._id_594D7B859FDB06F7) && self._id_594D7B859FDB06F7.size > 0) {
        node = scripts\engine\utility::random(self._id_594D7B859FDB06F7);
        self._id_594D7B859FDB06F7 = scripts\engine\utility::array_remove(self._id_594D7B859FDB06F7, node);
        origin = node.origin;
        _id_CB88E484EB1A3A92 = node.angles;
      }

      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, _id_CB88E484EB1A3A92, "medium", "mission", "samInitialGuards", undefined, undefined, undefined, self._id_B205D90302DA2F07, 0, undefined, 1);

      if(isDefined(agent)) {
        self.agents[_id_AC0E594AC96AA3A8] = agent;
        thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
      }
    }
  }

  self.numagents = self.agents.size;
}

_id_5E0B45946652EEB3(instance, part, state, _id_FBA0376E0036DE8D, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!_id_C076A54F4BDF7BCE(_id_FBA0376E0036DE8D)) {
    _id_FBA0376E0036DE8D scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
    return;
  }

  _id_C327ADFAD89EFC23 = instance.entity;

  if(isDefined(_id_C327ADFAD89EFC23._id_118719DB7C3B0EEF)) {
    _id_F6CE5FBAE9847FB9 = scripts\mp\utility\teams::getteamdata(_id_C327ADFAD89EFC23._id_118719DB7C3B0EEF, "players");

    foreach(player in _id_F6CE5FBAE9847FB9) {
      if(isDefined(player)) {
        objective_hideprogressforclient(_id_C327ADFAD89EFC23.objidnum, player);
        _func_D1B64C3D055CEEB0(0, player);
      }
    }
  }

  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FBA0376E0036DE8D.team, "players");

  foreach(player in level.players)
  instance enablescriptableplayeruse(player);

  foreach(player in _id_E2B2BBD9E6539F11)
  instance disablescriptableplayeruse(player);

  _id_C327ADFAD89EFC23._id_21280A92D9373B6F = _id_FBA0376E0036DE8D;
  _id_C327ADFAD89EFC23._id_118719DB7C3B0EEF = _id_FBA0376E0036DE8D.team;
  _id_C327ADFAD89EFC23 notify("start_capture");
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FBA0376E0036DE8D.team, "dmz_activity_action", 1.0, "dmz_activity_action_classic");
  _id_C327ADFAD89EFC23 thread _id_7D87C71B552407A4();
  _id_C327ADFAD89EFC23.base thread _id_8A39DC2E70FA624B(_id_C327ADFAD89EFC23);
  _id_C327ADFAD89EFC23 _id_FF2AEEA62B8FFB41();
  _id_C327ADFAD89EFC23 thread _id_30CF9BA4BF893A9A();
}

_id_FF2AEEA62B8FFB41() {
  foreach(player in self._id_90FB369A18926018) {
    if(isDefined(player))
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);
  }
}

_id_30CF9BA4BF893A9A() {
  self endon("start_capture");
  level endon("game_ended");
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_118719DB7C3B0EEF, "players");
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("samsite_begin_capture", self._id_118719DB7C3B0EEF);
  objective_removeallfrommask(self.objidnum);

  foreach(player in _id_E2B2BBD9E6539F11) {}

  objective_showtoplayersinmask(self.objidnum);
  waitframe();
  objective_setplayintro(self.objidnum, 0);
  self._id_7B45AAAC74192C14 = _id_48814951E916AF89::_id_353FECD1549F5F42(self.origin, level._id_D57C61FE001F1707._id_D0F63034F54017E3);

  if(self._id_7B45AAAC74192C14.size < 5)
    thread _id_ADBD4A9D1BB7572B();

  starttime = gettime();
  _id_AC85CEAC5AE0C89A = 0.0;
  duration = level._id_D57C61FE001F1707.capturetime * 1000;
  self._id_90FB369A18926018 = [];

  while(_id_AC85CEAC5AE0C89A < duration) {
    _id_B1E1B0A993DBD52A = 0;
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_118719DB7C3B0EEF, "players");

    if(!isDefined(_id_E2B2BBD9E6539F11) || _id_E2B2BBD9E6539F11.size == 0) {
      objective_addalltomask(self.objidnum);
      objective_hidefromplayersinmask(self.objidnum);
      self._id_118719DB7C3B0EEF = undefined;
      return;
    }

    foreach(player in _id_E2B2BBD9E6539F11) {
      if(scripts\mp\utility\player::isreallyalive(player) && isDefined(player.origin)) {
        dist = distance2dsquared(player.origin, self.origin);
        _id_5357ACDB76B0BD75 = player.origin[2] - self.origin[2];
        _id_40C1778CD1FFFB56 = level._id_D57C61FE001F1707._id_85BCA90B94DBBC20 <= _id_5357ACDB76B0BD75 && _id_5357ACDB76B0BD75 <= level._id_D57C61FE001F1707._id_C1EF96A923174C76;

        if(dist < level._id_D57C61FE001F1707._id_029A79D378C70E0B * level._id_D57C61FE001F1707._id_029A79D378C70E0B && _id_40C1778CD1FFFB56) {
          _id_B1E1B0A993DBD52A = 1;

          if(!scripts\engine\utility::array_contains(self._id_90FB369A18926018, player)) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
            scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(self.objidnum, player, 1, 2, &"DMZ/SAMSITE_CAPTURE_PROGRESS");
            self._id_90FB369A18926018 = scripts\engine\utility::array_add(self._id_90FB369A18926018, player);
          }

          objective_addclienttomask(self.objidnum, player);
        } else if(scripts\engine\utility::array_contains(self._id_90FB369A18926018, player)) {
          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objidnum, player);
          scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);
          self._id_90FB369A18926018 = scripts\engine\utility::array_remove(self._id_90FB369A18926018, player);
        }
      }
    }

    if(istrue(_id_B1E1B0A993DBD52A)) {
      _id_AC85CEAC5AE0C89A = _id_AC85CEAC5AE0C89A + level.frameduration;
      progress = _id_AC85CEAC5AE0C89A / duration;
      objective_setprogress(self.objidnum, progress);
      objective_showtoplayersinmask(self.objidnum);
    }

    waitframe();
  }

  self notify("captured");
  _id_FF2AEEA62B8FFB41();
  objective_addalltomask(self.objidnum);
  objective_hidefromplayersinmask(self.objidnum);
  _id_7408ED52662703D3 = level._id_B205D90302DA2F07[self._id_B205D90302DA2F07]["players"];
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_118719DB7C3B0EEF, "players");
  _id_7408ED52662703D3 = scripts\engine\utility::array_remove_array(_id_7408ED52662703D3, _id_E2B2BBD9E6539F11);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_samsite_captured", _id_E2B2BBD9E6539F11, self._id_B205D90302DA2F07);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_samsite_captured_others", _id_7408ED52662703D3, self._id_B205D90302DA2F07);

  if(isDefined(self._id_3A94ED22775A3C94)) {
    _id_CE6B5424F8072ED9 = scripts\mp\utility\teams::getteamdata(self._id_3A94ED22775A3C94, "players");
    _id_7408ED52662703D3 = scripts\engine\utility::array_remove_array(_id_7408ED52662703D3, _id_CE6B5424F8072ED9);
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("samsite_counter_capture", self._id_3A94ED22775A3C94);
    self.icon setscriptablepartstate("icon", "healthy");
    waitframe();
  }

  thread _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("samsite_others_captured", _id_7408ED52662703D3, 2.0);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("samsite_captured", self._id_118719DB7C3B0EEF, 2.0);
  _id_65F58F3C394DCF9A::_id_CAEAF68AB0E87565(_id_7408ED52662703D3, "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self._id_118719DB7C3B0EEF, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  self._id_3A94ED22775A3C94 = self._id_118719DB7C3B0EEF;
  self._id_118719DB7C3B0EEF = undefined;
  _id_6A8EC730B2BFA844::_id_B71395F12AF20A42(self);
  self.icon setscriptablepartstate("icon", "attacked");
  self.icon _meth_FCA5BDBE24070D20("icon", self._id_3A94ED22775A3C94);
  thread _id_43F27B5852D28616();
}

_id_7F8E0B88438E1071(pos) {
  right = level._id_D57C61FE001F1707.travelspeed * scripts\engine\math::random_vector_2d();
  _id_0A26FCF699AD1159 = -99999999;
  _id_0A040EF69986F137 = 99999999;

  foreach(_id_DC8625458EE5ED14 in level.br_level.br_mapboundsfull) {
    foreach(_id_6E7C70B904418DAA in [0, 1]) {
      t = (_id_DC8625458EE5ED14[_id_6E7C70B904418DAA] - pos[_id_6E7C70B904418DAA]) / right[_id_6E7C70B904418DAA];

      if(t > 0) {
        _id_0A040EF69986F137 = min(_id_0A040EF69986F137, t);
        continue;
      }

      _id_0A26FCF699AD1159 = max(_id_0A26FCF699AD1159, t);
    }
  }

  _id_9C22DBECB3D2D61B = (pos[0] + _id_0A26FCF699AD1159 * right[0], pos[1] + _id_0A26FCF699AD1159 * right[1], scripts\cp_mp\parachute::getc130height());
  _id_D686C2BF0F2C7E39 = (pos[0] + _id_0A040EF69986F137 * right[0], pos[1] + _id_0A040EF69986F137 * right[1], scripts\cp_mp\parachute::getc130height());
  pathdir = vectorNormalize(_id_D686C2BF0F2C7E39 - _id_9C22DBECB3D2D61B);
  pathstruct = spawnStruct();
  pathstruct.startpt = _id_9C22DBECB3D2D61B;
  pathstruct.endpt = _id_D686C2BF0F2C7E39;
  pathstruct.angle = vectortoangles(pathdir);
  return pathstruct;
}

_id_43F27B5852D28616() {
  level endon("game_ended");
  self endon("captured");

  if(level._id_D57C61FE001F1707._id_AAFBA8D70563022B < 0) {
    return;
  }
  _id_AAFBA8D70563022B = level._id_D57C61FE001F1707._id_AAFBA8D70563022B;

  if(isDefined(self._id_21280A92D9373B6F)) {
    _id_5332CDA4054641DA = scripts\engine\utility::_id_53C4C53197386572(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("instanceInventory", "getUpgradeCount", self._id_21280A92D9373B6F, 26), 0);
    _id_AAFBA8D70563022B = _id_AAFBA8D70563022B + _id_5332CDA4054641DA * getdvarfloat("dvar_FE5EB9987B622E18", 30);
  }

  wait(_id_AAFBA8D70563022B);
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_3A94ED22775A3C94, "players");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_samsite_lost", _id_E2B2BBD9E6539F11, self._id_B205D90302DA2F07);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("samsite_capture_over", self._id_3A94ED22775A3C94, 2.0);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self._id_3A94ED22775A3C94, "dmz_activity_lose", 0.0, "dmz_activity_lose_classic");

  foreach(player in _id_E2B2BBD9E6539F11)
  self enablescriptableplayeruse(player);

  self.icon setscriptablepartstate("icon", "healthy");
  self._id_3A94ED22775A3C94 = undefined;
}

_id_ADBD4A9D1BB7572B() {
  level endon("game_ended");
  agents = undefined;

  while(!isDefined(agents)) {
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(5, self.origin, "medium", "mission", "samReinforcements", undefined, undefined, 1, self._id_B205D90302DA2F07);

    if(!isDefined(agents))
      wait 1.0;
  }
}

_id_BEA9C8EDA67E6310(ent, type) {
  _id_6B9E1657765FCD4E = spawnStruct();
  _id_6B9E1657765FCD4E.ent = ent;
  _id_6B9E1657765FCD4E.type = type;
  return _id_6B9E1657765FCD4E;
}

_id_4210F9B65C3DB5B9(_id_C327ADFAD89EFC23, ent) {
  foreach(_id_8912843E32CFD589 in _id_C327ADFAD89EFC23._id_08EA2BEB55597DB7) {
    if(_id_8912843E32CFD589.ent == ent)
      return 1;
  }

  return 0;
}

_id_2CCF2416263812E2(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  vehicle thread _id_C0F043E80F479C20();
}

_id_36DC1A84DE5BDB04(_id_3CFEBEB76C5403A7) {
  _id_3CFEBEB76C5403A7.chopper thread _id_4E1A28CCE5BE373A();
}

_id_C35CCF109CB08D19(heli) {
  heli thread _id_0FF7B51833A73E61();
}

_id_C0F043E80F479C20() {
  level endon("game_ended");

  if(!level._id_D57C61FE001F1707._id_A0B9A15E69B57D09) {
    return;
  }
  while(isDefined(self) && self.occupants.size > 0) {
    foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0) {
      if(isDefined(_id_C327ADFAD89EFC23._id_3A94ED22775A3C94) && isDefined(self.occupants["driver"]) && _id_C327ADFAD89EFC23._id_3A94ED22775A3C94 != self.occupants["driver"].team && distancesquared(_id_C327ADFAD89EFC23.origin, self.origin) < level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9 * level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9 && !_id_4210F9B65C3DB5B9(_id_C327ADFAD89EFC23, self))
        _id_C327ADFAD89EFC23._id_08EA2BEB55597DB7[_id_C327ADFAD89EFC23._id_08EA2BEB55597DB7.size] = _id_BEA9C8EDA67E6310(self, 0);
    }

    wait 5.0;
  }
}

_id_0FF7B51833A73E61() {
  level endon("game_ended");

  if(!level._id_D57C61FE001F1707._id_91701C5F0103B916) {
    return;
  }
  while(isDefined(self) && !istrue(self._id_598F3BB771CB1027)) {
    foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0) {
      if(isDefined(_id_C327ADFAD89EFC23._id_3A94ED22775A3C94) && distancesquared(_id_C327ADFAD89EFC23.origin, self.origin) < level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9 * level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9 && !_id_4210F9B65C3DB5B9(_id_C327ADFAD89EFC23, self))
        _id_C327ADFAD89EFC23._id_08EA2BEB55597DB7[_id_C327ADFAD89EFC23._id_08EA2BEB55597DB7.size] = _id_BEA9C8EDA67E6310(self, 3);
    }

    wait 5.0;
  }
}

_id_4E1A28CCE5BE373A() {
  level endon("game_ended");

  if(!level._id_D57C61FE001F1707._id_F2E28100A201E1D4) {
    return;
  }
  while(isDefined(self)) {
    foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0) {
      if(isDefined(_id_C327ADFAD89EFC23._id_3A94ED22775A3C94) && distancesquared(_id_C327ADFAD89EFC23.origin, self.origin) < level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9 * level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9 && !_id_4210F9B65C3DB5B9(_id_C327ADFAD89EFC23, self))
        _id_C327ADFAD89EFC23._id_08EA2BEB55597DB7[_id_C327ADFAD89EFC23._id_08EA2BEB55597DB7.size] = _id_BEA9C8EDA67E6310(self, 2);
    }

    wait 5.0;
  }
}

_id_91D32D800E116BFA() {
  level endon("game_ended");

  if(!level._id_D57C61FE001F1707._id_2A1F5932AA000DCB) {
    return;
  }
  while(isDefined(self)) {
    foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0) {
      dist = distance2d(_id_C327ADFAD89EFC23.origin, self.origin);

      if(isDefined(_id_C327ADFAD89EFC23._id_3A94ED22775A3C94) && dist < level._id_D57C61FE001F1707._id_F4F7F8E7AA14EE19 && !_id_4210F9B65C3DB5B9(_id_C327ADFAD89EFC23, self))
        _id_C327ADFAD89EFC23._id_08EA2BEB55597DB7[_id_C327ADFAD89EFC23._id_08EA2BEB55597DB7.size] = _id_BEA9C8EDA67E6310(self, 1);
    }

    wait 5.0;
  }
}

_id_A23A2A8C5D40C210() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.health = self.health + damage;

    if(isDefined(idflags) && idflags &level.idflags_penetration)
      self.wasdamagedfrombulletpenetration = 1;

    if(isDefined(idflags) && idflags &level.idflags_ricochet)
      self.wasdamagedfrombulletricochet = 1;

    _id_702BFC08FABD86CB = int(damage);

    if(isDefined(objweapon)) {
      class = weaponclass(objweapon);

      if(isDefined(class) && class == "rocketlauncher")
        _id_702BFC08FABD86CB = _id_702BFC08FABD86CB + int(self.maxhealth / 2);
    }

    self.wasdamaged = 1;
    self.damagetaken = self.damagetaken + _id_702BFC08FABD86CB;
    self.health = self.health - _id_702BFC08FABD86CB;
    _id_B3990D56E2779F79 = self.health <= 0;

    if(isDefined(attacker) && isPlayer(attacker))
      attacker _id_5762AC2F22202BA2::updatehitmarker("standard", _id_B3990D56E2779F79, 0, 1);

    if(_id_B3990D56E2779F79) {
      team = undefined;

      if(isDefined(attacker))
        team = attacker.team;

      thread _id_666AD4E4E3CC4524(self, team);
      return;
    }
  }
}

_id_995605DB75897B06(plane, time) {
  level endon("game_ended");
  plane endon("plane_hit");
  plane endon("death");
  time = scripts\engine\utility::ter_op(time >= 1, time, 1);
  wait(time - 1);

  if(istrue(level._id_D57C61FE001F1707._id_FA313E2C568DBC16))
    plane setscriptablepartstate("audio_exit", "on", 0);

  wait 1;

  if(istrue(level._id_D57C61FE001F1707._id_FA313E2C568DBC16))
    plane setscriptablepartstate("audio_loop", "off", 0);

  plane thread _id_25184BB26F5D9B31();
}

_id_E596D7D6322CAB83() {
  if(!isDefined(level.mapname))
    return (randomfloatrange(-30000, 30000), randomfloatrange(-30000, 30000), 0);

  switch (level.mapname) {
    case "mp_saba":
    case "mp_saba_pm":
    case "mp_saba2":
      return (randomfloatrange(-30000, 30000), randomfloatrange(-30000, 30000), 0);
    case "mp_sealion":
      return (randomfloatrange(-3000, 2000), randomfloatrange(-10000, 0), 0);
    case "mp_delta":
      return (randomfloatrange(-15000, 15000), randomfloatrange(-10000, 0), 0);
    default:
      return (randomfloatrange(-30000, 30000), randomfloatrange(-30000, 30000), 0);
  }
}

_id_18A561A377CAC8A7() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level._id_D57C61FE001F1707._id_A098A0B9DBCFC30D)) {
    return;
  }
  if(!isDefined(level.br_level) || !isDefined(level.br_level.br_mapboundsfull)) {
    return;
  }
  level._id_BFAA41854743F890 = undefined;
  spawntime = 0;

  for(;;) {
    if(!isDefined(level._id_BFAA41854743F890)) {
      if(istrue(level._id_D57C61FE001F1707._id_CF0B6780C2D8A0F8)) {
        level._id_D57C61FE001F1707._id_CF0B6780C2D8A0F8 = undefined;
        wait(level._id_D57C61FE001F1707._id_5D016CC8C6057E32);
      }

      wait(randomfloatrange(level._id_D57C61FE001F1707._id_125035462230088F, level._id_D57C61FE001F1707._id_18BE0584E3DC6151));
      level._id_BFAA41854743F890 = _id_9C57F5D58C4333CE();
    }

    wait 5.0;
  }
}

_id_9C57F5D58C4333CE() {
  _id_6FDED323B6B347C9 = _id_E596D7D6322CAB83();
  pathstruct = _id_7F8E0B88438E1071(_id_6FDED323B6B347C9);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = level._id_D57C61FE001F1707.travelspeed;
  time = dist / travelspeed;
  c130 = _id_046CF752D93DC17B::_id_2496CDD7BABAED39(pathstruct, dist, travelspeed, time, "veh9_mil_air_cargo_plane_wm_dmz");

  if(istrue(level._id_D57C61FE001F1707._id_FA313E2C568DBC16))
    c130 setscriptablepartstate("audio_loop", "on", 0);

  c130 moveTo(c130.endpt, c130.lifetime);
  c130.velocity = (pathstruct.endpt - pathstruct.startpt) / time;
  c130 setCanDamage(1);
  c130.maxhealth = getdvarint("dvar_090B9A05ED8A66BA", 5000);
  c130.health = c130.maxhealth;
  c130.damagetaken = 0;
  c130 thread _id_91D32D800E116BFA();
  c130 thread _id_A23A2A8C5D40C210();
  level thread _id_995605DB75897B06(c130, time);
  return c130;
}

_id_4C4DBF406A67CE68() {
  level endon("game_ended");
  _id_633EAA5F21008B6F = self gettagorigin("engine_propeller_l_01_jnt");
  self.leftwingfxent = spawn("script_model", _id_633EAA5F21008B6F);
  self.leftwingfxent setModel("dmz_samsite_plane");
  self.leftwingfxent.angles = self.angles;
  self.leftwingfxent setotherent(self.owner);
  self.leftwingfxent linkTo(self, "engine_propeller_l_01_jnt", (0, 0, 0), (0, 0, 0));
  _id_3EACD3938CCD4B6C = self gettagorigin("engine_propeller_r_01_jnt");
  self.rightwingfxent = spawn("script_model", _id_3EACD3938CCD4B6C);
  self.rightwingfxent setModel("dmz_samsite_plane");
  self.rightwingfxent.angles = self.angles;
  self.rightwingfxent setotherent(self.owner);
  self.rightwingfxent linkTo(self, "engine_propeller_r_01_jnt", (0, 0, 0), (0, 0, 0));
  waitframe();
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self._id_BA27AAC5A0F799E0 = spawn("script_model", self.origin);
  self._id_BA27AAC5A0F799E0 setModel("tag_origin");
  self._id_BA27AAC5A0F799E0.angles = vectortoangles(anglesToForward(self.angles));
  _id_CE1134BA0CDA2FB9 = spawn("script_model", self.origin);
  _id_CE1134BA0CDA2FB9 setModel("dmz_samsite_plane_mesh");
  _id_CE1134BA0CDA2FB9.angles = self.angles;
  _id_CE1134BA0CDA2FB9.animname = "gunship";
  _id_CE1134BA0CDA2FB9 scripts\common\anim::setanimtree();
  _id_D4A561CABC248249 = "crash_air";
  self.leftwingfxent setscriptablepartstate(_id_D4A561CABC248249, "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "delayEntDelete"))
    _id_CE1134BA0CDA2FB9 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](10);

  self setscriptablepartstate("dmz_audio_explosion", "on");
  _id_1041B7883E5D3DA5 = "outro_gunship_death";
  _id_F7380E0BA9C6762F = scripts\common\anim::_id_52351C3338DA63F4("gunship", _id_1041B7883E5D3DA5);
  thread _id_B4F2B6316268F9C4();
  thread _id_40A9DFD673B1177B(_id_F7380E0BA9C6762F, self.origin);
  thread _id_3033111851FA46EA(_id_F7380E0BA9C6762F);
  self._id_BA27AAC5A0F799E0 scripts\common\anim::anim_single_solo(_id_CE1134BA0CDA2FB9, _id_1041B7883E5D3DA5);
}

_id_3033111851FA46EA(time) {
  wait(time * 0.5);
  crate = _id_046CF752D93DC17B::_id_52F17E5FBEC318A6(self.origin - (0, 0, level._id_5D2AF95280A3CF58), level._id_EF63E063E320ACFC["dmz_samsite_drop"]);

  if(isDefined(crate)) {
    crate unlink();
    _id_F8048727716242B0 = (0, 0, 0);

    if(distance2d(crate.origin, (0, 0, 0)) > level._id_D57C61FE001F1707._id_1B52E473AAE939E3) {
      dir = (0, 0, 0) - crate.origin;
      _id_F8048727716242B0 = _func_767CEA82B001F645(dir) * level._id_D57C61FE001F1707._id_0A8AE8076D571811;
      _id_F8048727716242B0 = (_id_F8048727716242B0[0], _id_F8048727716242B0[1], randomfloatrange(-500000, 500000));
    } else
      _id_F8048727716242B0 = scripts\engine\utility::randomvector(level._id_D57C61FE001F1707._id_5C03240772908114);

    crate physicslaunchserver(crate.origin, (0, 0, 0));
    _id_212A44A5393C3B34 = crate physics_getbodyid(0);
    physics_setbodycenterofmassnormal(_id_212A44A5393C3B34, (0, 0, 0));
    crate.physicsactivated = 1;
    crate physics_applyimpulse(crate.origin, _id_F8048727716242B0);
    crate.usetime = 10;
    crate setscriptablepartstate("dmz_supply_drop", "usable");
  }
}

_id_B4F2B6316268F9C4() {
  level endon("game_ended");
  wait 0.05;
  self hide();
}

_id_40A9DFD673B1177B(_id_74B5B12BB6514385, origin) {
  level endon("game_ended");
  _id_14B1D0692795AF2F = _id_74B5B12BB6514385 - 2;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_14B1D0692795AF2F);
  radius = 30000;

  if(_func_A794FCF9545F2062()) {
    players = _func_B1EEF70090B5B7B5(origin, radius, _func_869CCB4E3451B8C6(["etype_player"]));

    foreach(player in players) {
      frac = distance(player.origin, origin) / radius;

      if(player scripts\cp_mp\utility\player_utility::_isalive())
        player earthquakeforplayer(0.25, 2, origin, radius);
    }
  }
}

_id_25184BB26F5D9B31() {
  if(isDefined(self.leftwingfxent))
    self.leftwingfxent delete();

  if(isDefined(self.rightwingfxent))
    self.rightwingfxent delete();

  if(isDefined(self.chassis))
    self.chassis delete();

  if(isDefined(self._id_BA27AAC5A0F799E0))
    self._id_BA27AAC5A0F799E0 delete();

  if(isDefined(self)) {
    self notify("deleted");
    self delete();
  }
}

_id_F3354DDC02E867C9(_id_16EFCF27E6EFCBE8) {
  _id_C327ADFAD89EFC23 = scripts\engine\utility::getclosest(self.origin, level._id_CF3FEEAA65A4E3F0, level._id_D57C61FE001F1707._id_36576A67F06F7657);
  _id_13A5E22C2A2E9FA0 = isDefined(_id_C327ADFAD89EFC23) && isDefined(_id_C327ADFAD89EFC23._id_3A94ED22775A3C94) && self.team != _id_C327ADFAD89EFC23._id_3A94ED22775A3C94;

  if(_id_13A5E22C2A2E9FA0)
    _id_16EFCF27E6EFCBE8._id_67243B08ECF2E214 = "DMZ/SAMSITE_BLOCK_KILLSTREAK_ERR_MSG";

  return _id_13A5E22C2A2E9FA0;
}

_id_F14F2CD0267B6AB7() {
  return scripts\engine\utility::ter_op(isDefined(level._id_CF3FEEAA65A4E3F0), level._id_CF3FEEAA65A4E3F0, []);
}

_id_7D87C71B552407A4() {
  level endon("game_ended");

  if(!isDefined(self._id_9129D285EF878ECC) || self._id_9129D285EF878ECC == 0)
    self._id_9129D285EF878ECC = 1;
  else if(isDefined(self._id_9129D285EF878ECC) && self._id_9129D285EF878ECC == 1) {
    return;
  }
  wait 1;
  self setscriptablepartstate("warning_alarm_audio", "alarm_start");
  wait 20.5;
  self._id_9129D285EF878ECC = 0;
}

_id_8A39DC2E70FA624B(_id_C327ADFAD89EFC23) {
  level endon("game_ended");
  self setscriptablepartstate("interaction_audio", "interaction_audio_start");
  msg = _id_C327ADFAD89EFC23 scripts\engine\utility::waittill_any_return_2("start_capture", "captured");

  if(msg == "captured")
    self setscriptablepartstate("interaction_audio", "interaction_audio_success");
  else
    self setscriptablepartstate("interaction_audio", "interaction_audio_off");
}

_id_3A49A55088058778() {
  for(;;) {
    if(getdvarint("dvar_E09236524985B845", 0)) {
      foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0)
      _id_C327ADFAD89EFC23._id_B3AEFAFBA795117F.origin = level.players[0].origin;
    }

    if(getdvarint("dvar_E2EFBEC1DBE653F9", 0)) {
      origin = getdvarvector("dvar_557CCA80FB410B65", (0, 0, 0));
      angles = getdvarvector("dvar_253D7D4B4E329166", (0, 0, 0));

      foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0) {
        _id_C327ADFAD89EFC23.collision unlink();
        _id_C327ADFAD89EFC23.collision linkTo(_id_C327ADFAD89EFC23, "tag_aim_animated", origin, angles);
      }
    }

    if(getdvarint("dvar_899A5D114B54C419", 0)) {
      setDvar("dvar_899A5D114B54C419", 0);
      player = level.players[0];
      forward = anglesToForward(player getplayerangles());
      _id_41B5F78FDDAAD23F = level.players[0].origin + forward * 100;
      _id_EC426EC417310C3A = _id_41B5F78FDDAAD23F + forward * 1000;
      _id_3865E73449A5A438 = makeweapon("samsite_missile_weapon");
      _id_D42E799E256E8C7A = magicbullet(_id_3865E73449A5A438, _id_41B5F78FDDAAD23F, _id_EC426EC417310C3A);
      _id_D42E799E256E8C7A setModel("military_dmz_sam_site_missile");
      _id_D42E799E256E8C7A setscriptablepartstate("military_samsite_missile", "on");
    }

    if(getdvarint("dvar_50797ED9F6AFFA3D", 0)) {
      setDvar("dvar_50797ED9F6AFFA3D", 0);

      foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0)
      _id_C327ADFAD89EFC23 _id_CE2565296095B940();
    }

    if(getdvarint("dvar_227F7408CD5466D4", 0)) {
      setDvar("dvar_227F7408CD5466D4", 0);

      foreach(_id_C327ADFAD89EFC23 in level._id_CF3FEEAA65A4E3F0) {
        foreach(player in level.players) {
          _id_C327ADFAD89EFC23 disablescriptableplayeruse(player);
          _id_C327ADFAD89EFC23 enablescriptableplayeruse(player);
        }
      }
    }

    if(getdvarint("dvar_EADC761BC3051CB1", 0)) {
      setDvar("dvar_EADC761BC3051CB1", 0);

      if(isDefined(level._id_BFAA41854743F890))
        _id_666AD4E4E3CC4524(level._id_BFAA41854743F890);
    }

    _id_265F9F6B5EE59C25 = getDvar("dvar_2FD705C3C5DABFDD", "");

    if(_id_265F9F6B5EE59C25 != "" && isDefined(level.players) && isDefined(level.players[0])) {
      _id_042A7CD0B06E308F = strtok(_id_265F9F6B5EE59C25, ",");

      foreach(index in _id_042A7CD0B06E308F) {
        index = int(index);

        if(!isDefined(level._id_CF3FEEAA65A4E3F0[index - 1])) {
          continue;
        }
        _id_C327ADFAD89EFC23 = level._id_CF3FEEAA65A4E3F0[index - 1];
        dist = distance(level.players[0].origin, _id_C327ADFAD89EFC23.origin);
        scale = dist / 750;
        thread scripts\engine\utility::draw_circle(_id_C327ADFAD89EFC23.origin, level._id_D57C61FE001F1707._id_D0F63034F54017E3, (0, 1, 0));
        thread scripts\engine\utility::draw_circle(_id_C327ADFAD89EFC23.origin, level._id_D57C61FE001F1707._id_1DECB3B28FA5E1C9, (0, 0, 1));
        thread scripts\engine\utility::draw_circle(_id_C327ADFAD89EFC23.origin, level._id_D57C61FE001F1707._id_F4F7F8E7AA14EE19, (1, 0, 0));
      }
    }

    waitframe();
  }
}

_id_C076A54F4BDF7BCE(player) {
  if(isDefined(player) && istrue(player._id_859654E0445A36D9))
    return 0;

  return 1;
}