/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4f7c27d4fef4bc09.gsc
***********************************************/

_id_5171170AC608CA01() {}

_id_563C8928520A0086(taskid) {
  setupagent();
  self._id_D41ED96694C55D83 = 1;
  self._id_1858803EA66E73E0 = 1;
  _id_1A8E8250C82242E2 = getdvarint("dvar_4DB8EAB33E045701", 0);

  if(_id_1A8E8250C82242E2 != 0) {
    self.health = self.health + _id_1A8E8250C82242E2;
    self.maxhealth = self.health;
  }

  if(self isscriptable())
    thread initscriptable();

  self._id_705E2628D263EE2C = loadfx("vfx/iw9/level/mp_sealion/vfx_ninja_smoke_bomb_iw9");
  self _meth_ 4924 F775ED21316();
  groundpos = getgroundposition(self.origin, 32);

  if(getdvarint("dvar_98874C4025EBE46D", 1) == 1 && distancesquared(self.origin, groundpos) < 400) {
    _id_4E0A3B3F9BEDD99D::_id_CA247899DBBCF9A4(self.origin);
    _id_4E0A3B3F9BEDD99D::_id_D93415244E99E763(self.origin, self.angles, getdvarint("dvar_37448409E13A1AF7", 1) == 1, 1);
    self setgoalpos(self.origin, 32.0);
  }

  self.pathenemyfightdist = 0;
  self.allowstrafe = 0;
  self setengagementmaxdist(0.1, 768.0);
  self _meth_7E763899297EC59C(1);
  self._id_DF41B7F76F62D9A2 = 0;
  self _meth_8BBCAEB23A1512EF("all", 0, "bt");
  return anim.success;
}

initscriptable() {
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

setupagent() {
  self._id_896173C5036728F9 = 1;
  self.ignoreme = 0;
  self.aistate = "idle";
  self._id_6E8BC2A1F79B2398 = "walk";
  self.sharpturnnotifydist = 100;
  self.radius = 15;
  self.height = 40;
  self._id_6EE412D13BCF28D2 = 2250000;
  self.ignoreclosefoliage = 1;
  self.guid = self getentitynumber();
  self._id_8D31C7EACB516468 = 1.0;
  self._id_0DA951E8204605E7 = 1.0;
  self._id_D2D25942E3B908E9 = 1.0;
  self._id_05B1209ECD2C2DE2 = 1.0;
  self._id_16734F091BFEBAA1 = 0;
  self._id_A045430175C98788 = 0;
  self.allowcrouch = 1;
  self._id_7C0157EC8B265F6E = 40;
  self._id_FA4CF34A0C3681B8 = 70;
  self._id_4BBA3A58F389E465 = self._id_FA4CF34A0C3681B8;
  self._id_A9BBCE143412F034 = 80;
  self._id_F5BD7EEB8C658300 = squared(self._id_FA4CF34A0C3681B8);
  self._id_3835F6FBD6173DC9 = squared(self._id_4BBA3A58F389E465);
  self.meleechargedistvsplayer = 125;
  self.meleechargedist = 125;
  self.meleebashmaxdistsq = 8100;
  self._id_8F438EA9E6AE83A2 = 12100;
  self._id_70DD5AB41A229510 = 1;
  self._id_B9DC79113497B05B = self.radius + 1;
  self.died_poorly = 0;
  self.damaged_by_player = 0;
  self.full_gib = 0;
  self._id_0805F8A6DA772965 = [];
  self.highlyawareradius = 200;
  self._id_0DC7052BBFE5C799 = 1;
  self._id_D491CD53E778C48E = gettime();
  self.lasthittime = [];
  self.combatmode = "no_cover";
  self.teamflashbangimmunity = 1;
  _id_CB920E03144E9344 = 15;

  if(isDefined(level._id_3DFCDEA6EFB8A124))
    _id_CB920E03144E9344 = level._id_3DFCDEA6EFB8A124;

  self _meth_748A16E0D1FE8B85(_id_CB920E03144E9344);

  if(!isDefined(self.a))
    self.a = spawnStruct();

  self.a.disablepain = getdvarint("dvar_38C150C4ACC3342A", 0) == 1;
  self.lastweapon = self.weapon;
  self.deathfunction = ::_id_47D82EC9B6EEE9E6;
  thread _id_4222D0ECF1D363BA();
  thread _id_3A6C3F63DA7103BF();
}

_id_3A6C3F63DA7103BF() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();
  self asmsetstate(self.asmname, "exposed_idle");
}

_id_4222D0ECF1D363BA() {
  self endon("death");
  level endon("game_ended");
  _id_206FD4337EA8ED6F = 0;

  for(;;) {
    if(length(self getvelocity()) == 0 && self.aistate == "move")
      _id_206FD4337EA8ED6F = _id_206FD4337EA8ED6F + 0.05;
    else
      _id_206FD4337EA8ED6F = 0;

    if(_id_206FD4337EA8ED6F > 2.0) {
      _id_30A6E70573ED723B = self getnegotiationstartnode();

      if(isDefined(_id_30A6E70573ED723B)) {
        _id_ABD9EE4725B96FC2 = distancesquared(self.origin, _id_30A6E70573ED723B.origin);

        if(_id_ABD9EE4725B96FC2 < squared(15))
          self setOrigin(_id_30A6E70573ED723B.origin, 0);
      }
    }

    wait 0.05;
  }
}

_id_8225E9DBF1FD31A5(taskid) {
  if(!istrue(self.scripted_mode))
    return anim.failure;

  return anim.running;
}

_id_16CF274FFC86E1E2(_id_3711CDF227CCD51B) {
  if(!0 || !isPlayer(self.enemy)) {
    return;
  }
  time = gettime();

  if(!isDefined(self.enemy._id_5A6732EFF9BD04B7))
    self.enemy._id_5A6732EFF9BD04B7 = time;
  else if(time < self.enemy._id_5A6732EFF9BD04B7) {
    return;
  }
  _id_B55FC573AAA3D8D4 = self.enemy.origin - self.origin;
  _id_CBDE868D773316B1 = anglesToForward(self.enemy.angles);
  dot = vectordot(_id_B55FC573AAA3D8D4, _id_CBDE868D773316B1);

  if(dot > 0 && _id_3711CDF227CCD51B < 250000) {
    self.enemy._id_5A6732EFF9BD04B7 = time + randomintrange(3000, 5000);
    self.enemy playlocalsound("zmb_player_impact_hit");
  }
}

_id_5213D881F2E26966(_id_4B091DCA55A95A42, _id_ED3E023B3E0009FE) {
  if(!isDefined(_id_ED3E023B3E0009FE))
    _id_ED3E023B3E0009FE = 1000;

  _id_4B091DCA55A95A42 = getclosestpointonnavmesh(_id_4B091DCA55A95A42, self);

  if(!isDefined(_id_4B091DCA55A95A42)) {
    return;
  }
  self._id_CB36CB356B9D9AD3 = _id_4B091DCA55A95A42;
  self._id_AAC0F7CD82056FD1 = _id_ED3E023B3E0009FE;
  self._id_CD9D7559236C5C9F = 0.25 * _id_ED3E023B3E0009FE;
  self._id_4114A481C65FD24C = 0.8 * _id_ED3E023B3E0009FE;
  self._id_6B9AC762E5CBE2F8 = 1;
}

_id_613F8BA3F0E080D3() {
  self._id_6B9AC762E5CBE2F8 = 0;
}

_id_47D82EC9B6EEE9E6() {
  _id_AB1C9A379F19D469 = scripts\common\utility::wasdamagedbyexplosive();

  if(istrue(_id_AB1C9A379F19D469))
    self _meth_36C9CC1AACACC4A8();

  return 0;
}