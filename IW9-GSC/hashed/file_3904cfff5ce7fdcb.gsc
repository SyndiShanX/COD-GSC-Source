/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3904cfff5ce7fdcb.gsc
***********************************************/

_id_88039A31EF9E74DD() {
  _id_BFB5641B1C288973 = isDefined(self.gulagloser) && !self.gulagloser;

  if(_id_BFB5641B1C288973) {
    return;
  }
  _id_B1DCA28C075E9C3A = self.ignoreme;
  _id_F5D1460CE90BFA57 = self.ignoreall;
  _id_0C31923566C85F07 = self botgetdifficulty();

  if(_id_0C31923566C85F07 != "recruit")
    self botsetdifficulty("recruit");
  else
    _id_0C31923566C85F07 = undefined;

  _id_C1A20B04AC6141BF();
  self.ignoreme = _id_B1DCA28C075E9C3A;
  self.ignoreall = _id_F5D1460CE90BFA57;

  if(isDefined(_id_0C31923566C85F07))
    self botsetdifficulty(_id_0C31923566C85F07);
}

_id_C1A20B04AC6141BF() {
  self endon("death_or_disconnect");
  self endon("gulag_end");
  level endon("game_ended");
  _id_5643932DE03D949D();
  _id_7B827EC625EAC6F5();
  _id_035C340E0C5D514F();
}

_id_5643932DE03D949D() {
  _id_59FF79D681BB860C::_id_2C2B5B435027F895(undefined);
  self.ignoreme = 1;
  self.ignoreall = 1;
  self botclearscriptgoal();

  while(!istrue(self.jailed) && !istrue(self.gulagarena))
    wait 1;
}

_id_7B827EC625EAC6F5() {
  _id_59FF79D681BB860C::_id_142B713A2846F9AC("Gulag 2F");

  while(istrue(self.jailed)) {
    self.ignoreall = 0;
    _id_DA842AD27513575B = randomint(100);

    if(_id_DA842AD27513575B < 20) {
      self botpressbutton("jump");
      wait 1;
      continue;
    }

    if(_id_DA842AD27513575B < 50) {
      self botclearscriptgoal();
      _id_BE2004030AD6E1AE = randomintrange(1, 3);
      wait(_id_BE2004030AD6E1AE);
      continue;
    }

    self botclearscriptgoal();
    arena = self.arena;
    _id_FE8F7703F6313ED4 = randomint(arena.jailspawns.size);
    _id_E24929C0E254D7B4 = arena.jailspawns[_id_FE8F7703F6313ED4].origin;
    _id_815D30728A6EF9D9 = _id_59FF79D681BB860C::_id_207BA502560FA1D2(_id_E24929C0E254D7B4);
    _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_815D30728A6EF9D9, randomintrange(50, 400));
    scripts\engine\utility::waittill_any_ents_or_timeout_return(5, self, "goal", self, "bad_path", self, "initPlayerArena");
  }
}

_id_035C340E0C5D514F() {
  self.ignoreme = 0;
  self.ignoreall = 0;
  self botclearscriptgoal();
  _id_59FF79D681BB860C::_id_142B713A2846F9AC("Gulag 1F");
  _id_D1D6C77A1C1B483F = undefined;
  target = undefined;
  _id_7A336BD948B61BD9 = 20;
  wait 0.2;

  while(!isDefined(target) && istrue(self.gulagarena)) {
    if(!isDefined(_id_D1D6C77A1C1B483F) || distance(self.origin, _id_D1D6C77A1C1B483F) <= _id_7A336BD948B61BD9) {
      _id_D1D6C77A1C1B483F = _id_80D441566C90EDC6();

      if(isDefined(_id_D1D6C77A1C1B483F))
        _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_D1D6C77A1C1B483F, _id_7A336BD948B61BD9);
    }

    target = _id_564A1E72E185FEDC();

    if(isDefined(target)) {
      break;
    }

    wait 0.2;
  }

  if(isDefined(target)) {
    self botclearscriptgoal();
    self getenemyinfo(target);
    self botsetscriptenemy(target);

    while(istrue(self.gulagarena))
      wait 0.5;

    self botclearscriptenemy();
  }
}

_id_564A1E72E185FEDC() {
  _id_CAA829FE86BC833B = 392;

  foreach(player in self.arena.arenaplayers) {
    if(player != self) {
      if(_id_59FF79D681BB860C::_id_3569A4BEC8B9AF17(player) || self botcanseeentity(player, 1) || distance(self.origin, player.origin) < _id_CAA829FE86BC833B)
        return player;
    }
  }

  return undefined;
}

_id_80D441566C90EDC6() {
  _id_7BB392E395BDB0D5 = undefined;

  foreach(player in self.arena.arenaplayers) {
    if(player != self) {
      _id_7BB392E395BDB0D5 = player.origin;
      break;
    }
  }

  if(!isDefined(_id_7BB392E395BDB0D5))
    _id_7BB392E395BDB0D5 = self.origin;

  _id_EE72848A8BF3667A = 392;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    destination = _id_59FF79D681BB860C::_id_5E0E534F768708A3(_id_EE72848A8BF3667A, _id_7BB392E395BDB0D5);

    if(abs(destination[2] - self.origin[2]) < 50)
      return destination;
  }

  return undefined;
}

_id_A10B82CA662AB815(_id_447913206D1F7916, timeuntilspawn) {
  spawnorigin = _id_034FFA859CF805CB(_id_447913206D1F7916, timeuntilspawn);
  spawnangles = _id_5BAB271917698DC4::getanglesfacingorigin(spawnorigin, self.origin);
  height = scripts\cp_mp\parachute::getc130height();

  if(isDefined(level.br_circle)) {
    circleindex = level.br_circle.circleindex;
    _id_AE439BDE76B3E937 = _id_67708F418B1FAC79::getgulagclosedcircleindex();
    _id_F0B695BB4C38471B = isDefined(circleindex) && circleindex >= _id_AE439BDE76B3E937;

    if(_id_F0B695BB4C38471B)
      height = height * getdvarfloat("dvar_A1C2D6B19BB6A568", 0.55);
  }

  if(isDefined(level.respawnheightoverride))
    height = level.respawnheightoverride;

  _id_A6427A6A24F058DC = (0, 0, height);
  spawnorigin = _id_1E4A61DB11011446::getoffsetspawnorigin(spawnorigin, _id_A6427A6A24F058DC);
  spawnpoint = spawnStruct();
  spawnpoint.origin = spawnorigin;
  spawnpoint.angles = spawnangles;
  spawnpoint.height = height;
  return spawnpoint;
}

_id_034FFA859CF805CB(_id_447913206D1F7916, timeuntilspawn) {
  circleorigin = _id_2695A20D4011076D::getnextsafecircleorigin();
  circleradius = _id_2695A20D4011076D::getnextsafecircleradius();

  if(!isDefined(circleorigin))
    circleorigin = _id_2695A20D4011076D::getsafecircleorigin();

  if(!isDefined(circleradius))
    circleradius = _id_2695A20D4011076D::getsafecircleradius();

  _id_FE02B20F9AC0BD11 = undefined;
  _id_F0EA4030349A33D5 = _id_5BAB271917698DC4::playergetbestrespawnteammate(_id_447913206D1F7916, timeuntilspawn);

  if(isDefined(_id_F0EA4030349A33D5) && scripts\engine\utility::ispointinsidecircle(_id_F0EA4030349A33D5.origin, circleorigin, circleradius))
    _id_FE02B20F9AC0BD11 = _id_40E63DD222434655::_id_89B90EAAC28334C7(_id_F0EA4030349A33D5.origin);
  else if(isDefined(self.lastdeathpos) && scripts\engine\utility::ispointinsidecircle(self.lastdeathpos, circleorigin, circleradius))
    _id_FE02B20F9AC0BD11 = _id_40E63DD222434655::_id_89B90EAAC28334C7(self.lastdeathpos);

  _id_E29512CD0020BFCB = [];

  if(isDefined(_id_FE02B20F9AC0BD11) && isDefined(level._id_0DBCB33D81F7D48D) && isDefined(level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11]) && isDefined(level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11]._id_301D639DA97100C9))
    _id_E29512CD0020BFCB = level._id_0DBCB33D81F7D48D.zones[_id_FE02B20F9AC0BD11]._id_301D639DA97100C9;

  _id_301D639DA97100C9 = [];

  foreach(_id_0C3EA9B1A20FF199 in _id_E29512CD0020BFCB) {
    if(scripts\engine\utility::ispointinsidecircle(_id_0C3EA9B1A20FF199.origin, circleorigin, circleradius))
      _id_301D639DA97100C9[_id_301D639DA97100C9.size] = _id_0C3EA9B1A20FF199;
  }

  if(_id_301D639DA97100C9.size <= 0) {
    _id_D3C555D9A1762C92 = 5;
    _id_301D639DA97100C9 = [];
    _id_D5998E8874D77B02 = getdvarint("dvar_951C7B13FFDD6905", 1);
    _id_38A4C729748AD94C = getdvarint("dvar_7017AD29DBEDC8B1", 1);
    _id_1848FFDBD8A2E93E = getdvarfloat("dvar_4E9825C71CEB94FF", 0.9);
    _id_8970EF161276A714 = getdvarfloat("dvar_8EB0CED475A9BAF1", 0.5);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D3C555D9A1762C92; _id_AC0E594AC96AA3A8++) {
      _id_A1E44FC076FA3D6E = spawnStruct();
      _id_A1E44FC076FA3D6E.origin = _id_2695A20D4011076D::getrandompointinboundscircle(circleorigin, circleradius, _id_8970EF161276A714, _id_1848FFDBD8A2E93E, _id_D5998E8874D77B02, _id_38A4C729748AD94C, 0, timeuntilspawn);
      _id_301D639DA97100C9[_id_301D639DA97100C9.size] = _id_A1E44FC076FA3D6E;
    }
  }

  _id_CE0A2696747AC427 = 1900;
  spawnorigin = undefined;
  _id_2EFB40E78EFBF349 = undefined;
  enemies = scripts\mp\utility\teams::getenemyplayers(self.team, 1);

  foreach(_id_0C3EA9B1A20FF199 in _id_301D639DA97100C9) {
    _id_224B18E78659D6AD = 0;

    foreach(enemy in enemies) {
      if(scripts\engine\utility::ispointinsidecircle(enemy.origin, _id_0C3EA9B1A20FF199.origin, _id_CE0A2696747AC427))
        _id_224B18E78659D6AD = _id_224B18E78659D6AD + 1;
    }

    if(_id_224B18E78659D6AD <= 0) {
      spawnorigin = _id_0C3EA9B1A20FF199.origin;
      break;
    }

    if(!isDefined(spawnorigin)) {
      spawnorigin = _id_0C3EA9B1A20FF199.origin;
      _id_2EFB40E78EFBF349 = _id_224B18E78659D6AD;
    }

    if(_id_224B18E78659D6AD < _id_2EFB40E78EFBF349) {
      spawnorigin = _id_0C3EA9B1A20FF199.origin;
      _id_2EFB40E78EFBF349 = _id_224B18E78659D6AD;
    }
  }

  return getclosestpointonnavmesh(spawnorigin);
}