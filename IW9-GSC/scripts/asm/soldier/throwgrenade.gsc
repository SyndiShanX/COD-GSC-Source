/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\throwgrenade.gsc
************************************************/

playanim_throwgrenade(asmname, statename, params) {
  throwdata = spawnStruct();
  throwdata.xanim = self._id_7F098191F1773FBF;
  throwdata.vel = self._id_42FEBD687AF39D67;
  throwdata.target = self._blackboard.throwgrenadetarget;
  throwdata.targetpos = self._blackboard._id_166FAA0E61B0570C;
  throwdata.fastthrow = self._id_C054A6DA1261FEF2;
  throwdata.withbounce = self._id_18230B6226821ED4;
  throwdata.time = self._id_9B8861B6840CA825;
  self.ispreppinggrenade = 1;
  _id_865C56CFF05FE0AD = trygrenadethrow(asmname, statename, throwdata);

  if(!_id_865C56CFF05FE0AD) {
    self endon(statename + "_finished");
    wait 0.2;
    scripts\asm\asm::asm_fireevent(asmname, "end");
  }
}

playcoveranim_throwgrenade(asmname, statename, params) {
  if(isDefined(self.node))
    self.keepclaimednodeifvalid = 1;

  playanim_throwgrenade(asmname, statename, params);
}

playcoveranim_throwgrenade_cleanup(asmname, statename, params) {
  self _meth_4EA7891F787C6725();
  playanim_throwgrenade_cleanup(asmname, statename, params);
}

playanim_throwgrenade_cleanup(asmname, statename, params) {
  self._blackboard.throwdata = undefined;
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");

  if(scripts\common\utility::issp() && isDefined(self.isholdinggrenade)) {
    _id_13D1C402F1421C35::dropgrenade();
    self.isholdinggrenade = undefined;
  }

  self.ispreppinggrenade = undefined;
}

shouldbounce(_id_F9EEC358459D9350) {
  _id_195927E09B405481 = _id_F9EEC358459D9350.basename;
  return _id_195927E09B405481 != "antigrav" && _id_195927E09B405481 != "emp" && _id_195927E09B405481 != "c8_grenade";
}

trygrenadethrow(asmname, statename, throwdata, _id_973C51E9FD66D178) {
  destination = throwdata.targetpos;
  _id_A15426692301F3F0 = throwdata.target;
  withbounce = throwdata.withbounce;

  if(!isDefined(withbounce))
    withbounce = 1;

  if(isDefined(destination)) {
    _id_B1C462B90341E70E = getgrenadethrowoffset(statename, throwdata.xanim);

    if(!isDefined(throwdata.fastthrow))
      _id_EDCB23EB9E6141BE = self checkgrenadethrowpos(_id_B1C462B90341E70E, destination, withbounce, "min energy", "min time", "max time");
    else
      _id_EDCB23EB9E6141BE = self checkgrenadethrowpos(_id_B1C462B90341E70E, destination, withbounce, "min time", "min energy");
  } else
    _id_EDCB23EB9E6141BE = throwdata.vel;

  _id_A15426692301F3F0 = throwdata.target;

  if(isDefined(_id_EDCB23EB9E6141BE)) {
    if(!isDefined(self.oldgrenawareness))
      self.oldgrenawareness = self.grenadeawareness;

    self.grenadeawareness = 0;
    _id_3251B898A0907271 = getdesiredgrenadetimervalue();
    setgrenadetimer(min(gettime() + 3000, _id_3251B898A0907271));
    _id_E57AEA3945878349 = 0;

    if(isDefined(_id_A15426692301F3F0) && usingplayergrenadetimer()) {
      _id_A15426692301F3F0 _meth_E89F2BDB307F137E();
      thread reducegiptponkillanimscript(statename, _id_A15426692301F3F0);

      if(_id_A15426692301F3F0 _meth_4C108309DC0D7FD2() > 1)
        _id_E57AEA3945878349 = 1;

      if(self._id_CC183DF556F63DA0 == "lethal") {
        if(_id_A15426692301F3F0 _meth_4C108309DC0D7FD2() <= 1)
          _id_A15426692301F3F0 _meth_FF4AA047884E7A14(gettime());
      }
    }

    if(isDefined(_id_973C51E9FD66D178))
      thread dogrenadethrow(asmname, statename, throwdata.xanim, _id_EDCB23EB9E6141BE, _id_3251B898A0907271, _id_E57AEA3945878349);
    else
      dogrenadethrow(asmname, statename, throwdata.xanim, _id_EDCB23EB9E6141BE, _id_3251B898A0907271, _id_E57AEA3945878349);

    return 1;
  } else {}

  return 0;
}

getdesiredgrenadetimervalue() {
  _id_3251B898A0907271 = undefined;

  if(usingplayergrenadetimer()) {
    player = self._id_A3441D87A95E9040;
    _id_3251B898A0907271 = gettime() + player.gs.playergrenadebasetime + randomint(player.gs.playergrenaderangetime);
  } else
    _id_3251B898A0907271 = gettime() + 30000 + randomint(30000);

  return _id_3251B898A0907271;
}

usingplayergrenadetimer() {
  return self._id_58C197914DD654E0 && isDefined(self._id_A3441D87A95E9040);
}

reducegiptponkillanimscript(statename, _id_A15426692301F3F0) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill(statename + "_finished");

  if(isDefined(_id_A15426692301F3F0))
    _id_A15426692301F3F0 _meth_A33073D6FD58E58E();
}

dogrenadethrow(asmname, statename, _id_A9112040A3D575F1, _id_EDCB23EB9E6141BE, _id_3251B898A0907271, _id_E57AEA3945878349) {
  self endon("killanimscript");
  self endon(statename + "_finished");
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "start");
  covernode = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(covernode) || covernode.type == "Exposed" || covernode.type == "Path")
    self orientmode("face direction", _id_EDCB23EB9E6141BE);

  _id_D5C987658103BFFD = scripts\asm\asm::asm_getbodyknob();
  _id_7E86F9ECD18C5801 = scripts\asm\asm::asm_getxanim(statename, _id_A9112040A3D575F1);
  _id_2CFBD51B20C32D37::evaluateattackevent(self.grenadeweapon.basename);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_7E86F9ECD18C5801);
  self aisetanim(statename, _id_A9112040A3D575F1, fasteranimspeed());
  thread scripts\asm\asm::asm_donotetracks(asmname, statename);
  model = _id_2B79931B08683E0A::getgrenademodel();
  _id_07924DB5D06B35FB = "none";
  _id_9930AFEA4DE87021 = 0;

  while(!_id_9930AFEA4DE87021) {
    self waittill(statename, notes);

    if(!isarray(notes))
      notes = [notes];

    foreach(notetrack in notes) {
      if(notetrack == "grenade_right") {
        _id_07924DB5D06B35FB = attachgrenademodel(statename, model, "tag_accessory_right");
        self.isholdinggrenade = 1;
      } else if(notetrack == "grenade_left") {
        _id_07924DB5D06B35FB = attachgrenademodel(statename, model, "tag_accessory_left");
        self.isholdinggrenade = 1;
      }

      if(notetrack == "grenade_throw" || notetrack == "grenade throw") {
        _id_9930AFEA4DE87021 = 1;
        continue;
      }

      if(notetrack == "end") {
        self._id_A3441D87A95E9040 _meth_A33073D6FD58E58E();
        self notify("dont_reduce_giptp_on_killanimscript");
        return 0;
      }
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");
  _id_DDDA1DBC4B1D9BFB = usingplayergrenadetimer();

  if(_id_DDDA1DBC4B1D9BFB)
    thread watchgrenadetowardsplayer(statename, self._id_A3441D87A95E9040, _id_3251B898A0907271);
  else {
    thread _id_8337CAB97D859A28(statename);
    setgrenadetimer(_id_3251B898A0907271);
  }

  _id_2249366B1972061F = self throwgrenade();

  if(_id_E57AEA3945878349 && _id_DDDA1DBC4B1D9BFB) {
    player = self._id_A3441D87A95E9040;

    if(player _meth_4C108309DC0D7FD2() > 1 || gettime() - player _meth_DF95FE0FCEE94BF3() < 2000)
      _func_E4DA167DC330B3D3(player, gettime() + min(5000, player.gs.playerdoublegrenadetime));
  }

  self notify("stop grenade check");

  if(_id_07924DB5D06B35FB != "none")
    self detach(model, _id_07924DB5D06B35FB);

  self.isholdinggrenade = undefined;
  self.ispreppinggrenade = undefined;
  self.grenadeawareness = self.oldgrenawareness;
  self.oldgrenawareness = undefined;
  self.throwgrenadeatenemyasap = 0;

  if(isDefined(_id_2249366B1972061F) && self.team == "axis")
    level notify("enemy_grenade_fire", _id_2249366B1972061F);

  self waittillmatch(statename, "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
}

fasteranimspeed() {
  return 1.5;
}

attachgrenademodel(statename, model, tag) {
  self attach(model, tag);
  thread detachgrenadeonscriptchange(statename, model, tag);
  return tag;
}

waittillscriptchange(statename) {
  self endon(statename + "_finished");
  self waittill("killanimscript");
}

detachgrenadeonscriptchange(statename, model, tag) {
  self endon("stop grenade check");
  waittillscriptchange(statename);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.oldgrenawareness)) {
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
  }

  self detach(model, tag);
}

_id_8337CAB97D859A28(statename) {
  _id_E97DD4A810914DB1 = spawnStruct();
  _id_E97DD4A810914DB1 thread _id_E8C7815BB3D09756(5);
  _id_E97DD4A810914DB1 endon("watchGrenadeTowardsTargetTimeout");
  grenade = getgrenadeithrew(statename);

  if(!isDefined(grenade)) {
    return;
  }
  prevorigin = grenade.origin;

  for(;;) {
    wait 0.1;

    if(!isDefined(grenade)) {
      break;
    }

    if(distancesquared(grenade.origin, prevorigin) < 400) {
      _func_16BAE3E0B0AA09E3(grenade.origin);
      break;
    }

    prevorigin = grenade.origin;
  }
}

watchgrenadetowardsplayer(statename, player, _id_3251B898A0907271) {
  player endon("death");
  watchgrenadetowardsplayerinternal(statename, _id_3251B898A0907271);

  if(isDefined(player))
    player _meth_A33073D6FD58E58E();
}

watchgrenadetowardsplayerinternal(statename, _id_3251B898A0907271) {
  _id_CC183DF556F63DA0 = self._id_CC183DF556F63DA0;
  _id_E97DD4A810914DB1 = spawnStruct();
  _id_E97DD4A810914DB1 thread _id_E8C7815BB3D09756(5);
  _id_E97DD4A810914DB1 endon("watchGrenadeTowardsTargetTimeout");
  type = self.grenadeweapon.basename;
  grenade = getgrenadeithrew(statename);

  if(!isDefined(grenade)) {
    return;
  }
  setgrenadetimer(min(gettime() + 5000, _id_3251B898A0907271));
  _id_E4DD0EED70BE5B70 = 62500;
  _id_70167AE0BB5ABD9D = 160000;

  if(type == "flash_grenade") {
    _id_E4DD0EED70BE5B70 = 810000;
    _id_70167AE0BB5ABD9D = 1690000;
  }

  _id_FE16F116477F0084 = level.players;
  prevorigin = grenade.origin;
  _id_6A984A8887A1A08B = 0;

  for(;;) {
    wait 0.1;

    if(!isDefined(grenade)) {
      break;
    }

    if(distancesquared(grenade.origin, prevorigin) < 400) {
      if(!_id_6A984A8887A1A08B) {
        _func_16BAE3E0B0AA09E3(grenade.origin);
        _id_6A984A8887A1A08B = 1;
      }

      _id_2ED5956D72563348 = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FE16F116477F0084.size; _id_AC0E594AC96AA3A8++) {
        player = _id_FE16F116477F0084[_id_AC0E594AC96AA3A8];

        if(!isDefined(player) || !isalive(player)) {
          continue;
        }
        distsqrd = distancesquared(grenade.origin, player.origin);

        if(distsqrd < _id_E4DD0EED70BE5B70) {
          player grenadelandednearplayer(_id_CC183DF556F63DA0, _id_3251B898A0907271);
          continue;
        }

        if(distsqrd < _id_70167AE0BB5ABD9D)
          _id_2ED5956D72563348[_id_2ED5956D72563348.size] = player;
      }

      _id_FE16F116477F0084 = _id_2ED5956D72563348;

      if(_id_FE16F116477F0084.size == 0) {
        break;
      }
    }

    prevorigin = grenade.origin;
  }
}

grenadelandednearplayer(_id_CC183DF556F63DA0, _id_3251B898A0907271) {
  player = self;
  _func_98DEAE9464F6C005(0);
  _id_6B7BEE46F2C6DA28 = gettime();

  if(_id_6B7BEE46F2C6DA28 - player _meth_DF95FE0FCEE94BF3() < 3000)
    _func_E4DA167DC330B3D3(player, _id_6B7BEE46F2C6DA28 + player.gs.playerdoublegrenadetime);

  player _meth_4F19CF7B3C28ACD7(_id_6B7BEE46F2C6DA28);
  _id_7ABB90C7E07FF11B = _func_9752A69F79A06B7A(player, _id_CC183DF556F63DA0);
  _func_B4EBE6632D7E8EFE(player, _id_CC183DF556F63DA0, max(_id_3251B898A0907271, _id_7ABB90C7E07FF11B));
}

setgrenadetimer(_id_8F617FFD000EB682) {
  if(usingplayergrenadetimer() && isalive(self._id_A3441D87A95E9040)) {
    player = self._id_A3441D87A95E9040;
    weapontype = self._id_CC183DF556F63DA0;
    _id_7ABB90C7E07FF11B = _func_9752A69F79A06B7A(player, weapontype);
    _func_B4EBE6632D7E8EFE(player, weapontype, max(_id_8F617FFD000EB682, _id_7ABB90C7E07FF11B));
  } else {
    weapontype = self._id_CC183DF556F63DA0;
    _id_7ABB90C7E07FF11B = _func_9752A69F79A06B7A(undefined, weapontype);
    _func_B4EBE6632D7E8EFE(undefined, weapontype, max(_id_8F617FFD000EB682, _id_7ABB90C7E07FF11B));
  }
}

getgrenadeithrew(statename) {
  self endon("killanimscript");
  self endon(statename + "_finished");
  self waittill("grenade_fire", grenade);
  return grenade;
}

_id_E8C7815BB3D09756(_id_5F6346F9ECD5E22A) {
  wait(_id_5F6346F9ECD5E22A);
  self notify("watchGrenadeTowardsTargetTimeout");
}

offsettoorigin(start) {
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  up = anglestoup(self.angles);
  forward = forward * start[0];
  right = right * start[1];
  up = up * start[2];
  return forward + right + up;
}