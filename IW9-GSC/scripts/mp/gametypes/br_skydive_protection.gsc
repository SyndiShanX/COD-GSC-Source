/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_skydive_protection.gsc
**********************************************************/

init() {
  _id_16E73B10A8080DD2 = isDefined(level.modifyplayerdamage) && level.modifyplayerdamage == _id_1E4A61DB11011446::brmodifyplayerdamage;

  if(_id_16E73B10A8080DD2) {
    level.modifyplayerdamage = ::_id_B18F9E23B7BBBC7F;
    level._id_3FF7C73209FCF59D = getdvarint("dvar_8DCDF86E1A8C0268", 1) == 1;
    level._id_C701C6304D25847B = getdvarint("dvar_FE4E43D689D53652", 1);
    level._id_62B412340037B5F2 = getdvarfloat("dvar_B8697B26628BF8F9", 15.0);
    level._id_762E79833C568872 = getdvarfloat("dvar_9B573A0D1AA67773", 0.2);
    level._id_A616020822A64869 = getdvarfloat("dvar_2D766A7032695E80", 0.1);
    level._id_F56012F3862E7747 = getdvarint("dvar_75A6778B7AFBE4AE", 2500);
    level._id_6C3525C5C767BE2F = getdvarint("dvar_135E4A643E2D5610", 750);
    level._id_99F79C82A10BB035 = getdvarfloat("dvar_014EAF6CEDD5CB4A", 0.25);
    level._id_94CE8B45176DB281 = getdvarfloat("dvar_7F2806A81CFAE7BC", 0.25);
    level._id_D5AF0D323EADE962 = getdvarfloat("dvar_EEFED2A5AB0F62F7", 750);
    level._id_B1FA8D290EF1D796 = level._id_D5AF0D323EADE962 * level._id_D5AF0D323EADE962;
  }
}

_id_FA674FB6E8372620() {
  if(!istrue(level._id_3FF7C73209FCF59D)) {
    return;
  }
  thread _id_211969A23699F797();
  thread _id_54559C834E6C17AA();
  thread _id_CF9F51CC2DA4F3BD();
  thread _id_21F0A8EE3F038D39();

  if(level._id_C701C6304D25847B)
    thread _id_6F97457196B089BD();
}

_id_54559C834E6C17AA() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self._id_38841D8E75A06AB3 = 1;

  while(!_id_F0F8107CB455BE5C()) {
    if(self isonground() || self _meth_E40102956C887F7C()) {
      break;
    }

    waitframe();
  }

  self._id_38841D8E75A06AB3 = undefined;
  self._id_762E79833C568872 = undefined;
  self notify("skydive_remove_spawn_protection");
}

_id_F0F8107CB455BE5C() {
  _id_63F004E086B39A49 = getdvarint("dvar_B943D9F6A81CEC77", 0);
  _id_12EF154B846BACFF = undefined;

  foreach(player in scripts\common\utility::playersnear(self.origin, level._id_D5AF0D323EADE962)) {
    if(!isDefined(player) || !isalive(player)) {
      continue;
    }
    if(!isDefined(player.team) || player.team == self.team) {
      continue;
    }
    if(_id_63F004E086B39A49 && isai(player)) {
      continue;
    }
    if(!player isonground() && !player _meth_E40102956C887F7C()) {
      continue;
    }
    if(distancesquared(self.origin, player.origin) < level._id_B1FA8D290EF1D796)
      return 1;
  }

  return 0;
}

_id_21F0A8EE3F038D39() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_launcher_protection");
  self._id_CE34E72182B33556 = 1;

  for(;;) {
    if(self isonground() || self _meth_E40102956C887F7C()) {
      break;
    }

    waitframe();
  }

  self._id_CE34E72182B33556 = undefined;
  self notify("skydive_remove_launcher_protection");
}

_id_211969A23699F797() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self._id_38841D8E75A06AB3 = 1;
  self waittill("weapon_fired");
  self._id_38841D8E75A06AB3 = undefined;
  self._id_762E79833C568872 = undefined;
  self notify("skydive_remove_spawn_protection");
}

_id_6F97457196B089BD() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self._id_38841D8E75A06AB3 = 1;
  wait(level._id_62B412340037B5F2);
  self._id_38841D8E75A06AB3 = undefined;
  self._id_762E79833C568872 = undefined;
  self notify("skydive_remove_spawn_protection");
}

_id_CF9F51CC2DA4F3BD() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self._id_762E79833C568872 = 1;

  for(;;) {
    _id_C14047C4299F9C74 = _id_2CCADD23CE09858E();

    if(_id_C14047C4299F9C74 < level._id_6C3525C5C767BE2F) {
      break;
    }

    range = level._id_F56012F3862E7747 - level._id_6C3525C5C767BE2F;
    _id_BE660A98AF9F4FD4 = clamp(_id_C14047C4299F9C74 / range, 0, 1);
    _id_C4353552B0C9F04B = level._id_99F79C82A10BB035 - level._id_94CE8B45176DB281;
    self._id_762E79833C568872 = _id_BE660A98AF9F4FD4 * _id_C4353552B0C9F04B + level._id_94CE8B45176DB281;
    waitframe();
  }

  self._id_38841D8E75A06AB3 = undefined;
  self._id_762E79833C568872 = undefined;
  self notify("skydive_remove_spawn_protection");
}

_id_CFCE6A9D8F6DE32F(objweapon) {
  return isDefined(objweapon) && scripts\mp\damage::_id_7B2F2A8A9AA41D44(objweapon.basename);
}

_id_B18F9E23B7BBBC7F(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1) {
  if(istrue(level._id_3FF7C73209FCF59D)) {
    if(!_id_CFCE6A9D8F6DE32F(objweapon)) {
      if(istrue(victim._id_38841D8E75A06AB3) && isDefined(victim._id_762E79833C568872))
        idamage = idamage * victim._id_762E79833C568872;

      if(isDefined(eattacker) && istrue(victim._id_CE34E72182B33556)) {
        switch (smeansofdeath) {
          case "MOD_GRENADE":
          case "MOD_GRENADE_SPLASH":
          case "MOD_PROJECTILE_SPLASH":
          case "MOD_EXPLOSIVE":
            idamage = idamage * level._id_A616020822A64869;
            break;
        }
      }
    }
  }

  _id_2BB9843391A39639 = idamage;
  idamage = _id_1E4A61DB11011446::brmodifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1);
  return idamage;
}

_id_2CCADD23CE09858E() {
  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1);
  _id_E5403EB19D281362 = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(self.origin, 0, -100000, _id_C3FBB6661B91750F);
  _id_C14047C4299F9C74 = self.origin[2] - _id_E5403EB19D281362[2];
  return _id_C14047C4299F9C74;
}