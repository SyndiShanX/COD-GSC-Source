/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\suicidebomber\combat.gsc
****************************************************/

bomber_init(taskid) {
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 0;
  self.allowstrafe = 0;
  self._id_98ADD129A7ECB962 = 0;

  if(isagent(self)) {
    self.bombercanexplodebehindtarget = 1;
    self.bomberusegrenade = 0;
    self._id_79C2DE8443D5F950 = 1;
  } else
    self.bomberusegrenade = 1;

  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.leftaimlimit = 34;
  self.rightaimlimit = -31;
  self.upaimlimit = -22;
  self.downaimlimit = 26;
  anim.aimyawdifffartolerance = 10;
  anim.aimyawdiffclosedistsq = 4096;
  anim.aimyawdiffclosetolerance = 45;
  anim.aimpitchdifftolerance = 20;
  self.skipdetonation = 0;
  self.bomberexplodedistance = 256;
  self.bomberexplodeangle = 65.0;
  self.bombersecondaryexplodedistance = 100;
  self.bomberexplodeheight = 100;
  self.bomberraisearmdistsquared = 250000;
  self.bomberraisearmtime = 0;
  self.bomberlookatdistance = 500;
  self.bomberlookattargettime = 0;
  self.bomberlookattarget = 0;
  self.framesclosetotarget = 0;
  self.framescloserequired = 60;
  self.disablebulletwhizbyreaction = 1;
  self.script_group = 1;
  self.nodrop = 1;
  self.a.nodeath = 0;
  vfxtag = undefined;

  if(self tagexists("j_sling_pivot"))
    vfxtag = "j_sling_pivot";
  else
    vfxtag = "j_cosmetic_4";

  self attach("offhand_2h_wm_c4_clacker_prop", "tag_accessory_right");

  if(!isDefined(self.repulsorname)) {
    self.repulsorname = "suicideguy " + self getentitynumber();
    createnavrepulsor(self.repulsorname, -1, self, 200, 1, "axis", "allies");
  }

  self setbtgoalRadius(3, 32);
  thread dochants();
  thread expl_dmg_monitor();

  if(scripts\common\utility::issp()) {
    playFXOnTag(scripts\engine\utility::getfx("suicide_bomber_clicker_flash"), self, vfxtag);

    if(level.gameskill < 2)
      self.health = 300;
  } else if(scripts\common\utility::iscp())
    scripts\engine\utility::delaythread(0.2, ::blinking_light_thread, vfxtag);

  return anim.success;
}

blinking_light_thread(vfxtag) {
  playFXOnTag(scripts\engine\utility::getfx("suicide_bomber_clicker_flash"), self, vfxtag);
}

expl_dmg_monitor() {
  self endon("death");
  _id_F67541979FA04FE2 = 0;

  for(;;) {
    self waittill("damage", damage, attacker, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, meansofdeath, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, objweapon, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, inflictor);

    if(scripts\engine\utility::is_equal(attacker, self)) {
      continue;
    }
    if(isDefined(meansofdeath) && damage >= 100 && isexplosivedamagemod(meansofdeath) && !_id_F67541979FA04FE2) {
      _id_F67541979FA04FE2 = 1;
      self.instantexplode = 1;
      self.explode = 1;

      if(istrue(self.magic_bullet_shield))
        scripts\common\ai::stop_magic_bullet_shield();

      self kill(self.origin, self.lastattacker, self.lastattacker, meansofdeath);
    }
  }
}

dochants() {
  self endon("death");
  _id_5B7B3E4A592FFB65 = randomintrange(1, 6);
  _id_DD9814DB846ED183 = "dx_bc_aqsc_hsbr_aqs";
  _id_DCEC46DB83B19BB8 = _id_DD9814DB846ED183 + _id_5B7B3E4A592FFB65 + "_yournationswillburn";
  _id_DCEC49DB83B1A251 = _id_DD9814DB846ED183 + _id_5B7B3E4A592FFB65 + "_wearethekillers";
  _id_DCEC48DB83B1A01E = _id_DD9814DB846ED183 + _id_5B7B3E4A592FFB65 + "_weareyourexecutioner";
  _id_DCEC4BDB83B1A6B7 = _id_DD9814DB846ED183 + _id_5B7B3E4A592FFB65 + "_wearethewolvesofsula";
  _id_AF94518387FF598D = [_id_DCEC46DB83B19BB8, _id_DCEC49DB83B1A251, _id_DCEC48DB83B1A01E, _id_DCEC4BDB83B1A6B7];
  _id_AF94518387FF598D = scripts\engine\utility::create_deck(_id_AF94518387FF598D, 1, 1);
  _id_5A5E35AAB381EE9D = 1.7;

  if(scripts\common\utility::iscp()) {
    _id_5A5E35AAB381EE9D = 3.7;
    wait 4;
  }

  for(;;) {
    alias = _id_AF94518387FF598D scripts\engine\utility::deck_draw();
    self thread[[anim.callbacks["PlaySoundAtViewHeight"]]](alias, "sound_done");
    self waittill("sound_done");
    wait(_id_5A5E35AAB381EE9D + randomfloat(0.7));
  }
}

bomber_gettarget() {
  if(isDefined(self.bombertarget))
    return self.bombertarget;

  return self.enemy;
}

bomber_terminate(taskid) {
  if(isDefined(self.repulsorname)) {
    destroynavrepulsor(self.repulsorname);
    self.repulsorname = undefined;
  }

  return anim.success;
}

bomber_updateeveryframe(taskid) {
  if(istrue(self._id_79C2DE8443D5F950))
    self _meth_79C2DE8443D5F950();

  _id_8483C4E961406C32 = bomber_gettarget();

  if(isDefined(_id_8483C4E961406C32)) {
    _id_06B54F8132C372EA = distance2dsquared(self.origin, _id_8483C4E961406C32.origin);

    if(isPlayer(_id_8483C4E961406C32) && !istrue(self.bomberplayerseesme)) {
      if(_id_06B54F8132C372EA < squared(300)) {
        if(vectordot(anglesToForward(_id_8483C4E961406C32.angles), self.origin - _id_8483C4E961406C32.origin) > 0)
          self.bomberplayerseesme = 1;
      } else if(_id_06B54F8132C372EA < squared(900)) {
        if(scripts\engine\utility::within_fov(_id_8483C4E961406C32.origin, _id_8483C4E961406C32.angles, self.origin, cos(45))) {
          if(scripts\engine\trace::ray_trace_passed(_id_8483C4E961406C32 getEye(), self getapproxeyepos(), [self, _id_8483C4E961406C32]))
            self.bomberplayerseesme = 1;
        }
      }

      if(self cansee(_id_8483C4E961406C32, 10000) && _id_06B54F8132C372EA < squared(900) && abs(self.origin[2] - _id_8483C4E961406C32.origin[2]) < self.bomberexplodeheight)
        self.framesclosetotarget++;
      else
        self.framesclosetotarget = 0;

      if(self.framesclosetotarget >= self.framescloserequired)
        self.explode = 1;
    }

    if(gettime() > self.bomberraisearmtime) {
      if(distancesquared(self.origin, _id_8483C4E961406C32.origin) < self.bomberraisearmdistsquared) {
        if(!istrue(self.bomberraisearm))
          self.bomberraisearmtime = gettime() + 4000;

        self.bomberraisearm = 1;
      } else {
        if(istrue(self.bomberraisearm))
          self.bomberraisearmtime = gettime() + 4000;

        self.bomberraisearm = 0;
      }
    }

    if(gettime() > self.bomberlookattargettime) {
      if(distancesquared(self.origin, _id_8483C4E961406C32.origin) < self.bomberlookatdistance * self.bomberlookatdistance) {
        if(!istrue(self.bomberlookattarget))
          self.bomberlookattargettime = gettime() + 3000;

        self.bomberlookattarget = 1;
        scripts\common\utility::lookatentity(_id_8483C4E961406C32);
      } else {
        if(!istrue(self.bomberlookattarget))
          self.bomberlookattargettime = gettime() + 1500;

        self.bomberlookattarget = 0;
        scripts\common\utility::lookatentity(undefined);
      }
    }
  }

  return anim.success;
}

bomber_shouldmove(taskid) {
  _id_8483C4E961406C32 = bomber_gettarget();

  if(!isDefined(_id_8483C4E961406C32))
    return anim.failure;

  if(istrue(self.bomberdisablemovebehavior))
    return anim.failure;

  return anim.success;
}

bomber_moveinit(taskid) {
  instancedata = spawnStruct();
  instancedata.nextupdatetime = 0;
  self.bt.instancedata[taskid] = instancedata;
}

bomber_checktarget(_id_8483C4E961406C32) {
  _id_9001DA663C7CDFEC = _id_8483C4E961406C32.origin - self.origin;

  if(lengthsquared(_id_9001DA663C7CDFEC) < self.bomberexplodedistance * self.bomberexplodedistance) {
    if(istrue(self.bombercanexplodebehindtarget)) {
      if(abs(_id_9001DA663C7CDFEC[2]) < self.bomberexplodeheight) {
        if(self cansee(_id_8483C4E961406C32))
          return 1;
      } else if(_id_9001DA663C7CDFEC[2] > 0 && _id_9001DA663C7CDFEC[2] < 200 && !isDefined(self.pathgoalpos) && !self.pathpending) {
        if(self seerecently(_id_8483C4E961406C32, 1))
          return 1;

        _id_DA461B632FC8E9DE = (self.origin[0], self.origin[1], _id_8483C4E961406C32.origin[2]);
        contents = scripts\engine\trace::create_default_contents(1);

        if(scripts\engine\trace::ray_trace_passed(self.origin, _id_DA461B632FC8E9DE, undefined, contents))
          return 1;
      }
    } else if(abs(_id_9001DA663C7CDFEC[2]) < self.bomberexplodeheight) {
      _id_47EA45F5BCF10FC3 = anglesToForward(self.angles);
      _id_7EF311E27099889B = acos(clamp(vectordot(_id_47EA45F5BCF10FC3, vectorNormalize(_id_9001DA663C7CDFEC)), -1.0, 1.0));

      if(_id_7EF311E27099889B < self.bomberexplodeangle && self cansee(_id_8483C4E961406C32)) {
        if(istrue(self.bomberplayerseesme) || !isPlayer(_id_8483C4E961406C32))
          return 1;
      }
    }
  }

  return 0;
}

bomber_move(taskid) {
  _id_8483C4E961406C32 = bomber_gettarget();

  if(!istrue(self.explode)) {
    instancedata = self.bt.instancedata[taskid];
    _id_6B7BEE46F2C6DA28 = gettime();
    _id_8C39E0358466E309 = isDefined(instancedata.targetpos);

    if(_id_6B7BEE46F2C6DA28 >= instancedata.nextupdatetime) {
      instancedata.nextupdatetime = _id_6B7BEE46F2C6DA28 + 500;
      instancedata.targetpos = self getclosestreachablepointonnavmesh(_id_8483C4E961406C32.origin);
      self setbtgoalpos(3, instancedata.targetpos);
    }

    _id_F71445B3C737CB34 = self getposonpath(self.bomberexplodedistance);

    if(bomber_checktarget(_id_8483C4E961406C32))
      self.explode = 1;
    else if(!istrue(self.bomberignoresecondarytargets)) {
      if(isDefined(self.enemy) && _id_8483C4E961406C32 != self.enemy && bomber_checktarget(self.enemy) && distancesquared(self.enemy.origin, _id_F71445B3C737CB34) < self.bombersecondaryexplodedistance * self.bombersecondaryexplodedistance)
        self.explode = 1;
      else {
        _id_BD73C7ACC56CD20C = undefined;
        _id_098F5C7F85707AF7 = -1;
        _id_70F421A55D12E111 = self getsecondarytargets();

        if(isDefined(_id_70F421A55D12E111)) {
          foreach(secondarytarget in _id_70F421A55D12E111) {
            if(bomber_checktarget(secondarytarget) && distancesquared(secondarytarget.origin, _id_F71445B3C737CB34) < self.bombersecondaryexplodedistance * self.bombersecondaryexplodedistance) {
              dist = distancesquared(secondarytarget.origin, self.origin);

              if(!isDefined(_id_BD73C7ACC56CD20C) || dist < _id_098F5C7F85707AF7) {
                _id_BD73C7ACC56CD20C = secondarytarget;
                _id_098F5C7F85707AF7 = dist;
              }
            }
          }
        }

        if(isDefined(_id_BD73C7ACC56CD20C))
          self.explode = 1;
      }

      if(!istrue(self.explode) && _id_8C39E0358466E309 && !isDefined(self.pathgoalpos) && lengthsquared(self.origin, instancedata.targetpos) < 1024) {
        if(self hastacvis(_id_8483C4E961406C32, 0, self.bomberexplodedistance, 1) || _id_8483C4E961406C32 hastacvis(self, 0, self.bomberexplodedistance, 1))
          self.explode = 1;
      }
    }
  }

  self._id_5185ACCFC2476D43 = 1;
  self._id_001F91D3DA0786A2 = 1;
  scripts\engine\utility::set_movement_speed(170);
  return anim.running;
}

bomber_moveterminate(taskid) {
  self._id_5185ACCFC2476D43 = 0;
  self.bt.instancedata[taskid] = undefined;
  self clearbtgoal(3);
}