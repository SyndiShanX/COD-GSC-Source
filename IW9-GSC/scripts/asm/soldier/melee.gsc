/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\melee.gsc
***********************************************/

ischargetoreadycomplete(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._id_A97AC004F00C5DF9 && self._id_F2383297DD7B5E7E;
}

playmeleeanim_chargetoready_distcheck(statename) {
  self endon(statename + "_finished");
  _id_EA974C3C587825A6 = 4900;
  target = scripts\asm\asm_bb::bb_getmeleetarget();

  for(;;) {
    if(!isDefined(target)) {
      break;
    }

    distsq = distancesquared(self.origin, target.origin);

    if(distsq <= _id_EA974C3C587825A6) {
      if(self._id_A97AC004F00C5DF9)
        self._id_F2383297DD7B5E7E = 1;

      break;
    }

    wait 0.05;
  }
}

donotetracks_vsplayer(asmname, statename, _id_7ED79AD4FEC35DFB) {
  for(;;) {
    self waittill(statename, notes);

    if(!isarray(notes))
      notes = [notes];

    foreach(_id_A234A65C378F3289 in notes) {
      _id_194B5B05A592F2D3 = handlenotetrack_vsplayer(asmname, statename, _id_A234A65C378F3289);

      if(istrue(_id_194B5B05A592F2D3)) {
        return;
      }
      if(isDefined(_id_7ED79AD4FEC35DFB))
        self[[_id_7ED79AD4FEC35DFB]](_id_A234A65C378F3289, statename);
    }
  }
}

handlenotetrack_vsplayer(asmname, statename, _id_A234A65C378F3289) {
  switch (_id_A234A65C378F3289) {
    case "melee_attack_sfx":
      target = scripts\asm\asm_bb::bb_getmeleetarget();

      if(isDefined(target))
        self _meth_0F5FC845BE4CA3BE(target);

      break;
    case "end":
      return 1;
    case "stop":
      target = scripts\asm\asm_bb::bb_getmeleetarget();

      if(!isDefined(target))
        return 1;

      if(!isalive(target))
        return 1;

      if(!isDefined(self.enemy) || self.enemy != target)
        return 1;

      _id_9EE0DDD0A3A34811 = distancesquared(target.origin, self.origin);
      _id_C41C22F541A64291 = 4096;

      if(isDefined(self.meleestopattackdistsq))
        _id_C41C22F541A64291 = self.meleestopattackdistsq;

      if(_id_9EE0DDD0A3A34811 > _id_C41C22F541A64291)
        return 1;

      break;
    case "fire":
      target = scripts\asm\asm_bb::bb_getmeleetarget();
      _id_E157C0CE32F71CBE(target, 1, undefined, 0);
      break;
    default:
      _id_357B9A54DFEDBD4A::handlenotetrack(_id_A234A65C378F3289, statename);
  }
}

_id_E157C0CE32F71CBE(target, _id_A7FA0E3C9034F2F4, _id_034AA97BBCE2BDE0, _id_CC0A7F51EB8B72D7) {
  if(!isDefined(target))
    return 1;

  if(isalive(target)) {
    if(isPlayer(target)) {
      if(self.meleeignorefinalzdiff)
        distsq = distance2dsquared(target.origin, self.origin);
      else
        distsq = distancesquared(target.origin, self.origin);

      _id_CDC5DD6C28C9709D = 4096;

      if(isDefined(self.meleebashmaxdistsq))
        _id_CDC5DD6C28C9709D = self.meleebashmaxdistsq;

      if(istrue(_id_CC0A7F51EB8B72D7) || distsq <= _id_CDC5DD6C28C9709D) {
        _id_53466AB1A7790144 = self.meleedamageoverride;
        width = undefined;
        height = undefined;
        _id_75CD327859CFBA08 = 30;
        _id_6B12B757693AE605 = 0.45;
        _id_0BDA0B1D6CCE0914 = 0.35;
        _id_C747E3B33AD16AC6 = isDefined(target.offhandshield) && target.offhandshield.active;

        if(isnullweapon(self.weapon))
          _id_53466AB1A7790144 = self.unarmedmeleedamageoverride;

        if(_id_C747E3B33AD16AC6) {
          _id_75CD327859CFBA08 = 10;
          _id_6B12B757693AE605 = 0.7;
          _id_0BDA0B1D6CCE0914 = 0.5;
          setsaveddvar("player_meleedamagemultiplier", 0.05);
        }

        if(isDefined(self._id_1A0D03789F333F98))
          _id_75CD327859CFBA08 = self._id_1A0D03789F333F98;

        _id_2103FE12FEA102DF = undefined;
        dist = sqrt(_id_CDC5DD6C28C9709D);

        if(istrue(_id_CC0A7F51EB8B72D7)) {
          _id_2103FE12FEA102DF = target;
          dist = self._id_E6B3EB176DDA8ABC;
        }

        _id_1D9FB21B4F3023F3 = self melee(_id_034AA97BBCE2BDE0, _id_53466AB1A7790144, dist, width, height, istrue(_id_CC0A7F51EB8B72D7), _id_2103FE12FEA102DF);

        if(isDefined(_id_1D9FB21B4F3023F3)) {
          if(isDefined(self._id_1449B46EDCCF92ED))
            self[[self._id_1449B46EDCCF92ED]](_id_1D9FB21B4F3023F3);

          if(_id_C747E3B33AD16AC6 && (self.unittype == "soldier" || self.unittype == "juggernaut"))
            self playSound("ai_melee_vs_shield");

          if(!istrue(self._id_70DD5AB41A229510))
            target player_impulse_from_origin(self.origin, _id_75CD327859CFBA08);

          target earthquakeforplayer(0.45, 0.35, target.origin, 1000);
          target playRumbleOnEntity("damage_heavy");

          if(!_id_C747E3B33AD16AC6) {
            _id_5EC195666EB7EC08 = 0;
            _id_20C094516733FFB1 = [self.origin, self getapproxeyepos(), (self.origin + self getapproxeyepos()) / 2];

            foreach(point in _id_20C094516733FFB1) {
              if(isDefined(target worldpointtoscreenpos(point, 55))) {
                _id_5EC195666EB7EC08 = 1;
                break;
              }
            }

            _id_E03584E4BA4276AC = 127;
            _id_7563028ECDC1EB0D = 0.5;
            _id_F97BC003A4789C2C = 0.25;

            if(_id_5EC195666EB7EC08 && isDefined(self._id_689BF433CB5C5322)) {
              _id_E03584E4BA4276AC = 30;
              target shellshock(self._id_689BF433CB5C5322, 1.25);
            }

            target thread _id_36E75EFE1D415CC2(_id_7563028ECDC1EB0D, _id_F97BC003A4789C2C);
            target viewkick(_id_E03584E4BA4276AC, self.origin);
          }
        } else if(istrue(_id_A7FA0E3C9034F2F4)) {
          self.nextmeleechecktime = gettime() + randomintrange(1500, 2500);
          self.lastfailedmeleechargetarget = target;
        }

        if(_id_C747E3B33AD16AC6) {
          setsaveddvar("player_meleedamagemultiplier", level.playermeleedamagemultiplier_dvar);
          return;
        }

        return;
      }

      if(istrue(_id_A7FA0E3C9034F2F4)) {
        self.nextmeleechecktime = gettime() + randomintrange(1500, 2500);
        self.lastfailedmeleechargetarget = target;
        return;
      }

      return;
    } else
      self melee();
  }
}

_id_36E75EFE1D415CC2(_id_7563028ECDC1EB0D, _id_F97BC003A4789C2C) {
  self endon("death_or_disconnect");
  self notify("stop_melee_blur");
  self endon("stop_melee_blur");
  self setblurforplayer(_id_7563028ECDC1EB0D, _id_F97BC003A4789C2C);
  wait(_id_F97BC003A4789C2C);
  self setblurforplayer(0, _id_F97BC003A4789C2C);
}

player_impulse_from_origin(origin, _id_6BD296FF8DB5AB91) {
  if(!self isonground())
    _id_6BD296FF8DB5AB91 = _id_6BD296FF8DB5AB91 * 0.1;

  dir = vectorNormalize(self.origin + (0, 0, 45) - origin);
  vel = dir * _id_6BD296FF8DB5AB91 * 10;
  self setvelocity(vel);
}

melee_decide_winner() {
  target = self._id_9BFC452192B23C7A;

  if(self.meleealwayswin) {
    self._id_74666F91F95A6EF8 = 1;
    target._id_74666F91F95A6EF8 = 0;
    return;
  } else if(target.meleealwayswin) {
    self._id_74666F91F95A6EF8 = 0;
    target._id_74666F91F95A6EF8 = 1;
    return;
  }

  if(isDefined(self.magic_bullet_shield)) {
    self._id_74666F91F95A6EF8 = 1;
    target._id_74666F91F95A6EF8 = 0;
  } else if(isDefined(target.magic_bullet_shield)) {
    self._id_74666F91F95A6EF8 = 0;
    target._id_74666F91F95A6EF8 = 1;
  } else {
    self._id_74666F91F95A6EF8 = scripts\engine\utility::cointoss();
    target._id_74666F91F95A6EF8 = !self._id_74666F91F95A6EF8;
  }
}

melee_calcsyncdirection() {
  target = self._id_9BFC452192B23C7A;
  _id_79B0B08B6461B1FF = self.origin - target.origin;
  _id_F38131FB9A95561A = vectortoyaw(_id_79B0B08B6461B1FF);
  _id_077B9E4B599269EB = angleclamp180(_id_F38131FB9A95561A - target.angles[1]);

  if(-45 < _id_077B9E4B599269EB && _id_077B9E4B599269EB < 45)
    return "8";
  else if(_id_077B9E4B599269EB > 135 || _id_077B9E4B599269EB < -135)
    return "2";
  else if(_id_077B9E4B599269EB > 45)
    return "4";

  return "6";
}

melee_shouldabortcharge(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self._id_A97AC004F00C5DF9)
    return 1;

  if(self._id_4ECD594AE357F55B)
    return 1;

  if(!isDefined(self._id_9BFC452192B23C7A))
    return 1;

  if(!isalive(self._id_9BFC452192B23C7A))
    return 1;

  if(istrue(self._id_9BFC452192B23C7A.dontmelee))
    return 1;

  return 0;
}

melee_shouldabort(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self._id_A97AC004F00C5DF9)
    return 1;

  if(self._id_4ECD594AE357F55B) {
    if(isDefined(self._id_9EA242CB88E6301E)) {
      if(self._id_9EA242CB88E6301E) {
        _id_56BF21256ACD1819 = scripts\asm\asm::asm_eventfired(asmname, "melee_stop");

        if(_id_56BF21256ACD1819)
          self._id_4C96A3A056B956E4 = 1;

        return _id_56BF21256ACD1819;
      }
    } else if(self._id_6A4A5C698277C54D) {
      _id_602E5B5E7DC6F071 = scripts\asm\asm::asm_eventfired(asmname, "melee_stop");

      if(!_id_602E5B5E7DC6F071) {
        self._id_9EA242CB88E6301E = 1;
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

candocovermelee_anim(asmname, statename, _id_F2B19B25D457C2A6, params) {}

chooseanim_syncmelee(asmname, statename, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, self.meleeanimalias);
}

evaluatesyncedmeleebyxanim(_id_2E845F8434FBA7F8, _id_63CAC41D4942D388) {
  target = self._id_9BFC452192B23C7A;
  targetangles = target.angles;
  _id_6A4277FF9E64049F = target.origin - self.origin;
  _id_51DA48562495C03A = vectortoyaw(_id_6A4277FF9E64049F);
  _id_5E7F52C1693E8F30 = 30;
  _id_5BABFFA7F03CE512 = angleclamp180(_id_51DA48562495C03A - self.angles[1]);

  if(abs(_id_5BABFFA7F03CE512) > _id_5E7F52C1693E8F30)
    return 0;

  if(_id_63CAC41D4942D388) {
    targetangles = target.angles - (0, _id_5BABFFA7F03CE512 * 0.5, 0);
    startpos = getstartorigin(target.origin, targetangles, _id_2E845F8434FBA7F8);
  } else {
    targetangles = target.angles - (0, _id_5BABFFA7F03CE512, 0);
    startpos = getstartorigin(target.origin, targetangles, _id_2E845F8434FBA7F8);
  }

  _id_6786A467900943C4 = self.origin - startpos;
  _id_E0E7D3C1E330D5D4 = vectorNormalize(target.origin - startpos);
  dot = vectordot(_id_E0E7D3C1E330D5D4, _id_6786A467900943C4);

  if(dot > 12 || dot < -12)
    return 0;

  if(_id_63CAC41D4942D388) {
    self._id_290BE0985580A7A0 = self.angles[1] + _id_5BABFFA7F03CE512 * 0.5;
    target._id_290BE0985580A7A0 = targetangles[1];
  } else {
    self._id_290BE0985580A7A0 = getstartangles(target.origin, targetangles, _id_2E845F8434FBA7F8)[1];
    target._id_290BE0985580A7A0 = targetangles[1];
  }

  target._id_3A185A212FDFEBCA = 1;
  return 1;
}

evaluatesyncedmelee(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(level._id_134C418FEA89D2AD))
    return [[level._id_134C418FEA89D2AD]](self, asmname, statename, _id_F2B19B25D457C2A6, params);

  target = self._id_9BFC452192B23C7A;

  if(isPlayer(target))
    return 0;

  if(istrue(self.dontsyncmelee) || istrue(target.dontsyncmelee))
    return 0;

  if(!isDefined(target.weapon))
    return 0;

  if(weaponclass(self.weapon) == "pistol" || weaponclass(target.weapon) == "pistol")
    return 0;

  if(!isDefined(self._id_74666F91F95A6EF8) || !isDefined(target._id_74666F91F95A6EF8))
    melee_decide_winner();

  _id_C8D126B90E9FB82A = params[0];

  if(self._id_74666F91F95A6EF8 != _id_C8D126B90E9FB82A)
    return 0;

  _id_63CAC41D4942D388 = params[1];
  _id_B1B11B4B82BB2C05 = melee_calcsyncdirection();
  _id_AE16228B86A3F433 = ["a"];

  if(_id_B1B11B4B82BB2C05 == "8") {
    _id_AE16228B86A3F433 = ["a", "b", "c"];
    _id_09DEEA831D8228F5 = 3;
    _id_8A8AE42021841E0C = randomint(_id_09DEEA831D8228F5);
    _id_8A8AE720218424A5 = randomint(_id_09DEEA831D8228F5);
    temp = _id_AE16228B86A3F433[_id_8A8AE42021841E0C];
    _id_AE16228B86A3F433[_id_8A8AE42021841E0C] = _id_AE16228B86A3F433[_id_8A8AE720218424A5];
    _id_AE16228B86A3F433[_id_8A8AE720218424A5] = temp;
  }

  _id_09DEEA831D8228F5 = _id_AE16228B86A3F433.size;

  for(_id_0B893FB72D541789 = 0; _id_0B893FB72D541789 < _id_09DEEA831D8228F5; _id_0B893FB72D541789++) {
    aliasname = _id_B1B11B4B82BB2C05 + _id_AE16228B86A3F433[_id_0B893FB72D541789];
    meleeanim = scripts\asm\asm::asm_lookupanimfromalias(_id_F2B19B25D457C2A6, aliasname);
    _id_2E845F8434FBA7F8 = scripts\asm\asm::asm_getxanim(_id_F2B19B25D457C2A6, meleeanim);

    if(evaluatesyncedmeleebyxanim(_id_2E845F8434FBA7F8, _id_63CAC41D4942D388)) {
      self.meleeanimalias = aliasname;
      target.meleeanimalias = aliasname;
      return 1;
    }
  }

  return 0;
}

candomeleeflip_angles(asmname, statename, _id_F2B19B25D457C2A6, params) {}

candomeleeflip_anim(asmname, statename, _id_F2B19B25D457C2A6, params) {}

candomeleewrestle_angles(asmname, statename, _id_F2B19B25D457C2A6, params) {}

candomeleewrestle_anim(asmname, statename, _id_F2B19B25D457C2A6, params) {}

candomeleebehind_angles(asmname, statename, _id_F2B19B25D457C2A6, params) {}

candomeleebehind_anim(asmname, statename, _id_F2B19B25D457C2A6, params) {}

candomeleeanim_internal(meleeanim) {
  target = self._id_9BFC452192B23C7A;
  targetpos = target.origin;
  _id_79B0B08B6461B1FF = self.origin - targetpos;
  targetangles = vectortoangles(_id_79B0B08B6461B1FF);
  startpos = getstartorigin(targetpos, targetangles, meleeanim);
  self._id_290BE0985580A7A0 = getstartangles(targetpos, targetangles, meleeanim)[1];
  target._id_290BE0985580A7A0 = targetangles[1];
  return 1;
}

candomeleeanim(_id_F2B19B25D457C2A6) {}

melee_validatepoints(startpos, targetpos, _id_889F170FB7DC87C5) {}

waitforpartnerdelete(statename, partner) {
  if(!isDefined(partner)) {
    return;
  }
  partner waittill("entitydeleted");
  self notify("melee_exit");
}

playmeleeanim_synced_waitforpartnerexit(asmname, statename) {
  self endon(statename + "_finished");
  childthread waitforpartnerdelete(statename, self._id_68D2F73EE95055FB);
  self waittill("melee_exit");
  self unlink();
  _id_F20F49840827ACF1 = scripts\asm\asm::asm_eventfired(asmname, "melee_interact");

  if(self._id_541E0EB7644F137F && !_id_F20F49840827ACF1)
    self._id_D8A098B0872BB2CB = 1;
  else if(_id_F20F49840827ACF1 && !scripts\asm\asm::asm_eventfired(asmname, "melee_death")) {
    if(self._id_B3C40D9762123312)
      self._id_D8A098B0872BB2CB = !scripts\asm\asm::asm_eventfired(asmname, "drop");
    else
      self._id_D8A098B0872BB2CB = 0;
  }

  if(!self._id_74666F91F95A6EF8) {
    if(self._id_D8A098B0872BB2CB) {
      self._id_4ECD594AE357F55B = 1;
      self._id_9EA242CB88E6301E = 0;
    } else if(scripts\asm\asm::asm_eventfired(asmname, "melee_no_recovery"))
      self._id_9AEDAF1DA799BD67 = 1;
    else if(scripts\asm\asm::asm_eventfired(asmname, "melee_stop"))
      self kill();
    else if(self._id_6A4A5C698277C54D)
      self._id_4ECD594AE357F55B = 1;
    else
      self._id_9AEDAF1DA799BD67 = 1;
  } else if(scripts\asm\asm::asm_eventfired(asmname, "fire"))
    self._id_9AEDAF1DA799BD67 = 1;
  else if(!self._id_42C47BF5F8A7FDF6)
    self._id_4ECD594AE357F55B = 1;
}

melee_shouldlosersurvive(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._id_D8A098B0872BB2CB;
}

melee_shouldstop(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._id_4C96A3A056B956E4;
}

melee_waitfordroppedweapon(statename) {
  self endon(statename + "_finished");
  self waittill("weapon_dropped", _id_0D2346943E5CB1F5);

  if(isDefined(_id_0D2346943E5CB1F5))
    self._id_ACA4DBBE78D6D478 = _id_0D2346943E5CB1F5;
}

melee_handlenotetracks(_id_A234A65C378F3289) {
  _id_DEC9BCCE93873125 = getsubstr(_id_A234A65C378F3289, 0, 3);
  _id_91DEE08B20E606A5 = 0;

  switch (_id_DEC9BCCE93873125) {
    case "ps_":
      _id_91DEE08B20E606A5 = 1;
      alias = getsubstr(_id_A234A65C378F3289, 3);
      self playSound(alias);
      break;
    case "td_":
      _id_91DEE08B20E606A5 = 1;
      _id_31FBB83644449C1C = getsubstr(_id_A234A65C378F3289, 3);
      params = strtok(_id_31FBB83644449C1C, ",");

      if(params.size >= 2)
        _id_4F145058CBB5099E(params[0], params[1]);

      break;
  }

  if(_id_91DEE08B20E606A5) {
    return;
  }
  switch (_id_A234A65C378F3289) {
    case "sync":
      if(!self._id_4ECD594AE357F55B) {
        if(isDefined(self._id_9BFC452192B23C7A)) {
          if(isalive(self._id_9BFC452192B23C7A))
            self linktoblendtotag(self._id_9BFC452192B23C7A, "tag_sync", 1, 1);
        } else if(self._id_3A185A212FDFEBCA && isDefined(self._id_68D2F73EE95055FB)) {
          if(isalive(self._id_68D2F73EE95055FB))
            self linktoblendtotag(self._id_68D2F73EE95055FB, "tag_sync", 1, 1);
        }
      }

      break;
    case "unsync":
      if(self._id_A54042B7B10263BE)
        melee_unlink();
      else
        self unlink();

      break;
    case "melee_interact":
      break;
    case "melee_death":
      return _id_A234A65C378F3289;
    case "attach_knife":
      self attach("weapon_vm_me_soscar_knife", "TAG_INHAND", 1);
      break;
    case "detach_knife":
      self detach("weapon_vm_me_soscar_knife", "TAG_INHAND", 1);
      break;
    case "stab":
      self playSound("melee_knife_hit_body");
      playFXOnTag(level._effect["melee_knife_ai"], self, "TAG_KNIFE_FX");
      break;
    case "melee_stop":
      break;
  }
}

playmeleeanim_synced_survive(asmname, statename, params) {
  _id_8C94C5136296A0A4 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_0FD6DF514234369A = scripts\asm\asm::asm_getxanim(statename, _id_8C94C5136296A0A4);
  self aisetanim(statename, _id_8C94C5136296A0A4);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_0FD6DF514234369A);
  self.meleeanimalias = undefined;
  scripts\asm\asm::asm_donotetracks(asmname, statename, ::melee_handlenotetracks);
}

playmeleeanim_synced_cleanup(asmname, statename, params) {
  if(self._id_A97AC004F00C5DF9 && isDefined(self._id_68D2F73EE95055FB))
    self._id_68D2F73EE95055FB notify("melee_exit");

  if(isalive(self) && self._id_A97AC004F00C5DF9)
    melee_droppedweaponrestore();

  self unlink();

  if(self.unittype == "c6") {
    self.hackable = 1;
    self.ignoreme = 0;
  }

  self _meth_0BDCB37A9431E654(0);
}

melee_droppedweaponrestore() {
  if(!isnullweapon(self.weapon) && !isnullweapon(self.lastweapon)) {
    return;
  }
  if(isundefinedweapon(self._id_144130378B339AB7)) {
    return;
  }
  _id_3433EE6B63C7E243::forceuseweapon(self._id_144130378B339AB7, self._id_E616C5810A9C9B0B);

  if(isDefined(self._id_ACA4DBBE78D6D478)) {
    self._id_ACA4DBBE78D6D478 delete();
    self._id_ACA4DBBE78D6D478 = undefined;
  }
}

playmeleeanim_synced_victim(asmname, statename, params) {
  self endon(statename + "_finished");
  self._id_DFFF4C701BB9523C = 1;
  self animmode("nogravity");

  if(isDefined(self._id_290BE0985580A7A0))
    self orientmode("face angle", self._id_290BE0985580A7A0);
  else
    self orientmode("face current");

  melee_synced_setup(statename, 0);
  thread melee_waitfordroppedweapon(statename);
  _id_A553F65A4CB20B34 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_D41E1C8A87D0AA2A = scripts\asm\asm::asm_getxanim(statename, _id_A553F65A4CB20B34);
  self aisetanim(statename, _id_A553F65A4CB20B34);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_D41E1C8A87D0AA2A);
  stoptimes = getnotetracktimes(_id_D41E1C8A87D0AA2A, "melee_stop");

  if(stoptimes.size > 0)
    self._id_6A4A5C698277C54D = 1;

  interacttimes = getnotetracktimes(_id_D41E1C8A87D0AA2A, "melee_interact");

  if(interacttimes.size > 0)
    self._id_541E0EB7644F137F = 1;

  interactendtimes = getnotetracktimes(_id_D41E1C8A87D0AA2A, "drop");

  if(interactendtimes.size > 0)
    self._id_B3C40D9762123312 = 1;

  thread playmeleeanim_synced_waitforpartnerexit(asmname, statename);
  _id_8E7DD7004797F1B4 = scripts\asm\asm::asm_donotetracks(asmname, statename, ::melee_handlenotetracks);

  if((_id_8E7DD7004797F1B4 == "melee_death" || !self._id_74666F91F95A6EF8) && !self._id_D8A098B0872BB2CB) {
    self.a.nodeath = 0;

    if(isDefined(self._id_68D2F73EE95055FB) && self._id_68D2F73EE95055FB._id_A97AC004F00C5DF9)
      self._id_68D2F73EE95055FB._id_42C47BF5F8A7FDF6 = 1;

    self kill();
  }
}

melee_setmeleetimer(unittype, _id_CCBBA16287668F0A) {
  if(!isDefined(anim)) {
    return;
  }
  if(!isDefined(anim.meleechargeintervals)) {
    return;
  }
  if(!isDefined(unittype)) {
    return;
  }
  if(!isDefined(_id_CCBBA16287668F0A))
    _id_CCBBA16287668F0A = 1;

  if(isPlayer(self._id_9BFC452192B23C7A) && isDefined(anim.meleechargeplayerintervals[self.unittype]))
    anim.meleechargeplayertimers[self.unittype] = gettime() + anim.meleechargeplayerintervals[self.unittype] * _id_CCBBA16287668F0A;
  else if(isDefined(anim.meleechargeintervals[self.unittype]))
    anim.meleechargetimers[self.unittype] = gettime() + anim.meleechargeintervals[self.unittype] * _id_CCBBA16287668F0A;
}

melee_synced_setup(statename, _id_84BC2524A18FAECA) {
  self.meleestatename = statename;
  self._id_8DA037CBE81E4F8F = 1;
  self._id_144130378B339AB7 = self.weapon;
  self._id_E616C5810A9C9B0B = _id_7E4D332E911E1B90::getcurrentweaponslotname();
  self._id_A54042B7B10263BE = 1;

  if(_id_84BC2524A18FAECA) {
    melee_setmeleetimer(self.unittype);
    self.syncedmeleetarget = self._id_9BFC452192B23C7A;
  } else
    self.syncedmeleetarget = self._id_68D2F73EE95055FB;

  if(self.unittype == "c6") {
    self.hackable = 0;
    self.ignoreme = 1;
  }
}

melee_unlink() {
  self unlink();

  if(isDefined(self._id_68D2F73EE95055FB) && isalive(self._id_68D2F73EE95055FB)) {
    self._id_68D2F73EE95055FB animmode("zonly_physics");
    self._id_68D2F73EE95055FB orientmode("face angle", self._id_68D2F73EE95055FB.angles[1]);
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
}

playmeleeanim_chargetoready(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_E02C0FA1FAE17F6D = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_B57783EEE95DC145 = scripts\asm\asm::asm_getxanim(statename, _id_E02C0FA1FAE17F6D);
  self aisetanim(statename, _id_E02C0FA1FAE17F6D);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_B57783EEE95DC145);
  thread playmeleeanim_chargetoready_distcheck(statename);
  scripts\asm\asm::asm_donotetracks(asmname, statename);
}

playmeleeanim_vsplayer(asmname, statename, params) {
  playmeleeattacksound();
  target = scripts\asm\asm_bb::bb_getmeleetarget();

  if(!isDefined(target))
    self orientmode("face current");
  else if(isDefined(self.enemy) && target == self.enemy)
    self orientmode("face enemy");
  else
    self orientmode("face point", target.origin);

  meleeanim = scripts\asm\asm::asm_getanim(asmname, statename);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");

  if(isDefined(params))
    self playSound(params);

  rate = 1.0;

  if(isDefined(self._id_2536E610F6EA9C94))
    rate = self._id_2536E610F6EA9C94;
  else if(isDefined(self.unittype) && self.unittype == "juggernaut")
    rate = 1.5;

  self aisetanim(statename, meleeanim, rate);
  self endon(statename + "_finished");
  donotetracks_vsplayer(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  scripts\asm\asm::asm_fireevent(asmname, "end");
}

playmeleeattacksound() {
  if(!isDefined(self.a.nextmeleeattacksound))
    self.a.nextmeleeattacksound = 0;

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a.nextmeleeattacksound) {
      _id_4ADE3AE5C138C8B3::saygenericdialogue("meleeattack");
      self.a.nextmeleeattacksound = gettime() + 8000;
    }
  }
}

playmeleechargesound() {
  if(!isDefined(self.a.nextmeleechargesound))
    self.a.nextmeleechargesound = 0;

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a.nextmeleechargesound) {
      _id_4ADE3AE5C138C8B3::saygenericdialogue("meleecharge");
      self.a.nextmeleechargesound = gettime() + 8000;
    }
  }
}

playmeleechargeanim(asmname, statename, params) {
  playmeleechargesound();
  self._id_5185ACCFC2476D43 = 1;
  self._id_001F91D3DA0786A2 = 1;
  scripts\asm\asm::_id_FB56C9527636713F(asmname, statename, self.moveplaybackrate);
}

playmeleeanim_synced(asmname, statename, params) {
  self._id_DFFF4C701BB9523C = 1;
  target = self._id_9BFC452192B23C7A;
  meleeanim = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_2E845F8434FBA7F8 = scripts\asm\asm::asm_getxanim(statename, meleeanim);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  melee_synced_setup(statename, 1);
  stoptimes = getnotetracktimes(_id_2E845F8434FBA7F8, "melee_stop");

  if(stoptimes.size > 0)
    self._id_6A4A5C698277C54D = 1;

  interacttimes = getnotetracktimes(_id_2E845F8434FBA7F8, "melee_interact");

  if(interacttimes.size > 0)
    self._id_541E0EB7644F137F = 1;

  thread melee_waitfordroppedweapon(statename);

  if(isDefined(target _meth_92435C7A6AE85C3C()))
    target _meth_EA63241A4D3092C4();

  target scripts\asm\asm::asm_setstate(statename + "_victim");
  self animmode("zonly_physics");
  self orientmode("face angle", self._id_290BE0985580A7A0);
  self aisetanim(statename, meleeanim);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_2E845F8434FBA7F8);
  thread playmeleeanim_synced_waitforpartnerexit(asmname, statename);
  self endon(statename + "_finished");
  _id_8E7DD7004797F1B4 = scripts\asm\asm::asm_donotetracks(asmname, statename, ::melee_handlenotetracks);

  if((_id_8E7DD7004797F1B4 == "melee_death" || !self._id_74666F91F95A6EF8) && !self._id_D8A098B0872BB2CB) {
    self.a.nodeath = 0;

    if(isDefined(self._id_9BFC452192B23C7A) && self._id_9BFC452192B23C7A._id_A97AC004F00C5DF9)
      self._id_9BFC452192B23C7A._id_42C47BF5F8A7FDF6 = 1;

    self kill();
  }
}

_id_4F145058CBB5099E(_id_D59FC6B752DF85F0, _id_D570FD1CD4EA6CC3) {
  _id_5F29F5B939C96795 = "";

  switch (_id_D570FD1CD4EA6CC3) {
    case "cloth":
      _id_5F29F5B939C96795 = "_cloth";

      if(istrue(self._id_F85AA26E953E8279))
        _id_5F29F5B939C96795 = "_gear";

      break;
    case "surface":
      _id_5F29F5B939C96795 = "_dirt";
      _id_7DD9592388E2E093 = self.lastgroundtype;

      if(isDefined(_id_7DD9592388E2E093)) {
        switch (_id_7DD9592388E2E093) {
          case "carpet_metal":
          case "carpet_wood":
          case "cinderblock":
          case "wood_solid":
          case "tile":
          case "ice_thin":
          case "glass_broken":
          case "concrete_wet":
          case "concrete_dry":
          case "drywall":
          case "wood_floor":
          case "ceramic":
          case "rock":
          case "bark":
          case "brick":
          case "plastic":
          case "metal_car":
          case "metal_tank":
          case "metal_thin":
          case "metal_thick":
          case "metal_grate":
          case "asphalt_wet":
          case "asphalt_dry":
          case "glass_solid":
          case "glass_pane":
            _id_5F29F5B939C96795 = "_wood";
            break;
        }
      }

      break;
  }

  _id_D59FC6B752DF85F0 = _id_D59FC6B752DF85F0 + _id_5F29F5B939C96795;

  if(soundexists(_id_D59FC6B752DF85F0))
    self playSound(_id_D59FC6B752DF85F0);
}

_id_6CDE2D3AE248271D(_id_A234A65C378F3289, flagname) {
  if(!isDefined(self._id_E6B3EB176DDA8ABC))
    self._id_E6B3EB176DDA8ABC = 64.0;

  if(!isDefined(self._id_F88C7E674F2B356E))
    self._id_F88C7E674F2B356E = 45.0;

  players = scripts\common\utility::_id_98A826B6B6D0D118(self.origin, self._id_E6B3EB176DDA8ABC, undefined, 100);
  fwd = anglesToForward(self.angles);

  foreach(player in players) {
    _id_24C6F607CFEED805 = player.origin - self.origin;

    if(abs(_func_C1AA7C066EC92CA5(_id_24C6F607CFEED805, fwd)) > cos(self._id_F88C7E674F2B356E))
      _id_E157C0CE32F71CBE(player, 0, undefined, 1);
  }
}