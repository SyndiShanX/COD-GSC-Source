/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2e6a95dfe7dfc5f8.gsc
***********************************************/

_id_A955D908F57B75CF() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("start_combat");

  if(!_id_26CCBFE3954CACF4::_id_D012729EAC1E7053())
    wait(getdvarint("dvar_DE394B7049BF2445", 20));

  if(istrue(level._id_7B37B2193F163B9B._id_B871280CBDC11CAF)) {
    return;
  }
  _id_3AF7DC40048A9337 = 0;
  _id_0BA5E7C3CFB3546A = undefined;

  for(;;) {
    _id_D012729EAC1E7053 = _id_26CCBFE3954CACF4::_id_D012729EAC1E7053();
    _id_B582B10663B5B2A9 = _id_B2502F3345564ABF();

    if(_id_D012729EAC1E7053) {
      if(!_id_B582B10663B5B2A9) {
        _id_7CAE93055DAE77EC();

        if(istrue(level._id_7B37B2193F163B9B._id_B871280CBDC11CAF)) {
          break;
        }

        _id_0BA5E7C3CFB3546A = undefined;
      } else {
        _id_5CAD1E6F9D962133 = _id_7E816FA0720D38A1::bot_is_in_gas() || _id_44F4640B93AB1B47::_id_0296623D26E11725() || isDefined(_id_0BA5E7C3CFB3546A) && _id_0BA5E7C3CFB3546A < gettime();

        if(_id_5CAD1E6F9D962133) {
          _id_54B60E1286F5AEFA();
          _id_0BA5E7C3CFB3546A = undefined;
        } else if(_id_3AF7DC40048A9337) {
          _id_EA111DE8E9327C27();
          _id_6EF184778CAA05C5 = 10000;
          _id_0BA5E7C3CFB3546A = gettime() + _id_6EF184778CAA05C5;
        }
      }
    } else if(_id_B582B10663B5B2A9)
      _id_0D3638CF9A2DA76A("unengaged and range [2D dist = (default), height = (default)] meets for(default) ms and not witnessed");

    msg = scripts\engine\utility::waittill_any_in_array_or_timeout(["off_navmesh", "death", "dormant_bot_suspending_chance"], 1);
    _id_3AF7DC40048A9337 = 0;

    if(msg == "off_navmesh") {
      success = _id_26CCBFE3954CACF4::_id_64432AF189B8A177(4, 0);

      if(success) {
        return;
      }
      continue;
    }

    if(msg == "dormant_bot_suspending_chance")
      _id_3AF7DC40048A9337 = 1;
  }
}

_id_B2502F3345564ABF(_id_72FDE5447014F573, height, _id_B09A01F7B1772EDC) {
  if(istrue(level._id_7B37B2193F163B9B._id_B871280CBDC11CAF))
    return 0;

  if(!_id_59FF79D681BB860C::isvalidplayer(self))
    return 0;

  if(_id_4C9BD9A3BF3F8CF7::_id_6F6C5CB39CD095B0())
    return 0;

  if(_id_40E63DD222434655::_id_5F352FB76C54705C())
    return 0;

  _id_6B7BEE46F2C6DA28 = gettime();

  if(!_id_40E63DD222434655::_id_C4053E29135C5D27()) {
    self._id_B4ADDE4C68BB0F24._id_5BCA0362E9475B80 = _id_6B7BEE46F2C6DA28;
    return 0;
  }

  if(!isDefined(_id_72FDE5447014F573)) {
    _id_D0EB1456103AB1E3 = getdvarint("dvar_0D0DC9E305F43690", 5900);
    _id_72FDE5447014F573 = _id_D0EB1456103AB1E3 * _id_D0EB1456103AB1E3;
  }

  if(!isDefined(height))
    height = getdvarint("dvar_68E3358AD64BEF77", 5900);

  if(!isDefined(_id_B09A01F7B1772EDC))
    _id_B09A01F7B1772EDC = getdvarint("dvar_8F312094BE1C23B0", 30000);

  if(_id_72FDE5447014F573 > 0 && height > 0) {
    foreach(player in level.players) {
      if(isDefined(player) && player.connected && !isbot(player)) {
        if(distance2dsquared(player.origin, self.origin) < _id_72FDE5447014F573 && abs(player.origin[2] - self.origin[2]) < height) {
          self._id_B4ADDE4C68BB0F24._id_5BCA0362E9475B80 = _id_6B7BEE46F2C6DA28;
          return 0;
        }
      }
    }
  }

  if(!isDefined(self._id_B4ADDE4C68BB0F24._id_5BCA0362E9475B80))
    self._id_B4ADDE4C68BB0F24._id_5BCA0362E9475B80 = _id_6B7BEE46F2C6DA28;

  if(_id_6B7BEE46F2C6DA28 - self._id_B4ADDE4C68BB0F24._id_5BCA0362E9475B80 >= _id_B09A01F7B1772EDC) {
    if(_id_40E63DD222434655::_id_16A5388D4963E316())
      self._id_B4ADDE4C68BB0F24._id_5BCA0362E9475B80 = _id_6B7BEE46F2C6DA28;
    else
      return 1;
  }

  return 0;
}

_id_89B861AA78808ED8() {
  _id_B09A01F7B1772EDC = getdvarint("dvar_8F312094BE1C23B0", 30000);
  self._id_B4ADDE4C68BB0F24._id_5BCA0362E9475B80 = gettime() - _id_B09A01F7B1772EDC;
}

_id_0D3638CF9A2DA76A(_id_401C3A2E68AAB0FD) {
  if(istrue(level._id_7B37B2193F163B9B._id_B871280CBDC11CAF))
    return 0;

  if(!isDefined(_id_401C3A2E68AAB0FD))
    _id_401C3A2E68AAB0FD = "unknown reason";

  self._id_B4ADDE4C68BB0F24._id_C2AD339C4E95C7FE = strtok(_id_401C3A2E68AAB0FD, " ")[0];
  thread _id_B20F2224A6FA748E();
  return 1;
}

_id_B20F2224A6FA748E() {
  deactivate();
  _id_395064CE6C6B6619();
}

deactivate() {
  if(!_id_26CCBFE3954CACF4::_id_D012729EAC1E7053()) {
    _id_72AF5A878A9D3397::_id_B1C37E649A5CD380("dormant");
    _id_59FF79D681BB860C::_id_142B713A2846F9AC("Deactivated - Dormant");
    self._id_B4ADDE4C68BB0F24._id_D012729EAC1E7053 = 1;
    self._id_B4ADDE4C68BB0F24._id_7197E7FD2ADACF43 = gettime();
    _id_0D74AE0B4AA21186::_id_05E44C9968544264(0, ["Wander", "EscapeGas"]);
    _id_59FF79D681BB860C::_id_2C2B5B435027F895(undefined);
    level._id_7B37B2193F163B9B._id_892FA74A6B549EF0[level._id_7B37B2193F163B9B._id_892FA74A6B549EF0.size] = self;
    level notify("ui_bot_counter_updated");
  }
}

_id_7CAE93055DAE77EC() {
  if(_id_26CCBFE3954CACF4::_id_D012729EAC1E7053()) {
    _id_72AF5A878A9D3397::_id_B1C37E649A5CD380("active");
    _id_59FF79D681BB860C::_id_142B713A2846F9AC("Activated - Dormant");
    self._id_B4ADDE4C68BB0F24._id_D012729EAC1E7053 = 0;
    _id_0D74AE0B4AA21186::_id_05E44C9968544264(1);
    level._id_7B37B2193F163B9B._id_892FA74A6B549EF0 = scripts\engine\utility::array_remove(level._id_7B37B2193F163B9B._id_892FA74A6B549EF0, self);
    level notify("ui_bot_counter_updated");
    self notify("dormant_bot_activated");
    _id_54B60E1286F5AEFA();
  }
}

_id_395064CE6C6B6619() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("dormant_bot_activated");
  level endon("no_human_alive");

  while(!_id_26CCBFE3954CACF4::_id_7A5B6228C3FE75F6()) {
    _id_C4B11F08034979A4 = getdvarint("dvar_F3A6B99340F5A95F", 20);
    point = _id_26CCBFE3954CACF4::_id_0F7D87293D8DDA36();

    if(isDefined(point))
      _id_C4B11F08034979A4 = _id_26CCBFE3954CACF4::_id_E3B7C7A52E05AC10(point);

    _id_307A1F35AB3C8C7B = level._id_7B37B2193F163B9B._id_156F390A5362BC55.size < _id_C4B11F08034979A4;

    if(_id_307A1F35AB3C8C7B && _id_44DB1017D85B121F()) {
      success = _id_4C9BD9A3BF3F8CF7::_id_0D3638CF9A2DA76A("dormant recycle to ui bot");

      if(success)
        return;
    }

    wait 1;
  }
}

_id_44DB1017D85B121F() {
  if(_id_44F4640B93AB1B47::_id_0296623D26E11725())
    return 0;

  if(_id_40E63DD222434655::_id_5F352FB76C54705C())
    return 0;

  _id_D32939F3A50EFD12 = gettime() - self._id_B4ADDE4C68BB0F24._id_7197E7FD2ADACF43 > getdvarint("dvar_3B0DBF95A91A8233", 30000);

  if(_id_D32939F3A50EFD12 || _id_7E816FA0720D38A1::bot_is_in_gas())
    return 1;

  return 0;
}

issuspended() {
  return istrue(self._id_B4ADDE4C68BB0F24.issuspended);
}

_id_EA111DE8E9327C27() {
  if(!issuspended()) {
    self botsetflag("suspended", 1);
    self._id_B4ADDE4C68BB0F24.issuspended = 1;
    _id_59FF79D681BB860C::_id_142B713A2846F9AC("Deactivated - Dormant(Suspended)");
    self notify("bot_suspended");
  }
}

_id_54B60E1286F5AEFA() {
  if(issuspended()) {
    self botsetflag("suspended", 0);
    self._id_B4ADDE4C68BB0F24.issuspended = 0;
    _id_59FF79D681BB860C::_id_142B713A2846F9AC("Deactivated - Dormant");
    scripts\mp\bots\bots::bot_restart_think_threads();
  }
}