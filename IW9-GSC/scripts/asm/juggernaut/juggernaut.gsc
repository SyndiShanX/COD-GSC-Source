/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\juggernaut\juggernaut.gsc
*************************************************/

juggernaut(asmname) {
  self endon("asm_terminated");
  self endon("death");

  if(isDefined(self.subclass) && self.subclass == "juggernaut" || isDefined(self.agent_type) && self.agent_type == "juggernaut") {
    if(self._id_AE3EA15396B65C1F == "juggernaut" || self._id_AE3EA15396B65C1F == "juggernaut_cp" || self._id_AE3EA15396B65C1F == "juggernaut_lw")
      initanimspeedthresholds_juggernaut(self._id_AE3EA15396B65C1F);
  }
}

initanimspeedthresholds_juggernaut(_id_AE3EA15396B65C1F) {
  if(animspeedthresholdsexist(_id_AE3EA15396B65C1F)) {
    return;
  }
  anim.juggernautspeedthreholdsinitialized = 1;
  setspeedthreshold(_id_AE3EA15396B65C1F, "walk", 40);
  setspeedthreshold(_id_AE3EA15396B65C1F, "jog", 113);
  setspeedthreshold(_id_AE3EA15396B65C1F, "run", 170);
}

enable_casual_killer() {
  if(isDefined(self.combatmode))
    self.ck_combatmode = self.combatmode;

  self.combatmode = "no_cover";
  self allowedstances("stand");
  self.cautiousnavigation = 1;
  self.dontmeleeme = 1;
  self.dontmelee = 1;
  self.ck_grenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.ck_aggressivemode = istrue(self.aggressivemode);
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  scripts\engine\utility::set_movement_speed(50);
  self.turnrate = 0.1;
  self.allowstrafe = 0;
  self.disablepistol = 1;
  self.dontsyncmelee = 1;
  self.disablebulletwhizbyreaction = 1;
  self.neversprintforvariation = 1;
  self.disablerunngun = 1;
  self.casualkiller = 1;
  self.ignoreburstdelay = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self.pathenemyfightdist = 0;
  self._id_98ADD129A7ECB962 = 0;
  _id_0DD6BF5F9DBA888C = weaponclass(self.weapon);
  initanimspeedthresholds_juggernaut("juggernaut");
  self setbasearchetype("juggernaut");
  _id_C1CA5A5D2DDAD8E8 = "casual_killer";

  if(_id_0DD6BF5F9DBA888C == "mg")
    _id_C1CA5A5D2DDAD8E8 = "casual_killer_lmg";

  self setoverridearchetype("demeanor", _id_C1CA5A5D2DDAD8E8, 1);
  thread casual_killer_targeting();

  if(_id_0DD6BF5F9DBA888C == "mg" || _id_0DD6BF5F9DBA888C == "rifle" || _id_0DD6BF5F9DBA888C == "smg")
    thread casual_killer_sweep();

  if(_id_0DD6BF5F9DBA888C == "rifle" || _id_0DD6BF5F9DBA888C == "smg")
    self.shootstyleoverride = "full";

  thread casual_killer_enemy_reaction();
}

disable_casual_killer() {
  if(!istrue(self.leavecasualkiller))
    thread disable_casual_killer_internal();
}

disable_casual_killer_internal() {
  if(!isDefined(level.casualkillernewenemyreaction) || gettime() > level.casualkillernewenemyreaction) {
    self.newenemyreactiontime = gettime() + 3000;
    self.newenemyreaction = 1;
    self.forcenewenemyreaction = 1;
  }

  self.leavecasualkiller = 1;
  self clearentitytarget();
  self.favoriteenemy = undefined;
  self.gunposeoverride = undefined;

  if(isDefined(self.pathgoalpos))
    self setbtgoalpos(4, self getposonpath(64));

  scripts\engine\utility::waittill_any_2("leaveCasualKiller", "death");

  if(!isalive(self) || !isDefined(self)) {
    return;
  }
  self.cautiousnavigation = 0;
  self.dontmeleeme = 0;
  self.grenadeammo = self.ck_grenadeammo;

  if(istrue(self.ck_aggressivemode))
    self.aggressivemode = 1;

  scripts\common\utility::lookatentity(undefined);
  scripts\common\utility::lookatpos(undefined);
  self.ignoresuppression = 0;
  self.dontmelee = 0;
  self.turnrate = 0.3;
  scripts\common\utility::clear_movement_speed();
  self.disablepistol = 0;
  self.allowstrafe = 1;
  self.dontsyncmelee = undefined;
  self.disablebulletwhizbyreaction = 0;
  self.neversprintforvariation = undefined;
  self.disablerunngun = 0;
  self.casualkiller = 0;
  self.casualkillershootpos = undefined;
  self.pathenemyfightdist = 192;
  self.dontevershoot = 0;
  self.shootstyleoverride = undefined;
  self.ignoreburstdelay = undefined;
  self.dontgiveuponsuppression = undefined;
  self.forcesuppressai = 0;
  self.gunposeoverride = undefined;
  self.aimyawspeed = 0;
  self clearbtgoal(4);

  if(isDefined(self.ck_target))
    self.ck_target delete();

  self._id_98ADD129A7ECB962 = 1;
  self allowedstances("stand", "crouch", "prone");

  if(isDefined(self.ck_combatmode)) {
    self.combatmode = self.ck_combatmode;
    self.ck_combatmode = undefined;
  } else
    self.combatmode = "cover";
}

casual_killer_damage_func(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  if(scripts\engine\utility::is_equal(attacker, level.player))
    self notify("ck_player_attacked_me");
}

casual_killer_enemy_reaction() {
  self endon("leaveCasualKiller");
  self endon("death");

  if(!isDefined(self.damage_functions))
    self.damage_functions = [];

  self.damage_functions[self.damage_functions.size] = ::casual_killer_damage_func;
  self waittill("ck_player_attacked_me");
  self.favoriteenemy = undefined;
  self clearentitytarget();
  self setthreatbiasgroup("axis");
}

casual_killer_targeting() {
  self endon("leaveCasualKiller");
  self endon("death");
  wait 1;
  self.ck_target = spawn("script_origin", self.origin);
  thread scripts\engine\utility::delete_on_death(self.ck_target);
  _id_80C53303FB317FE2 = undefined;
  _id_47BCCB924D51B014 = 0;
  _id_BF49E927A147E7EA = undefined;
  _id_D9F67B70125E4D15 = undefined;

  for(;;) {
    waitframe();

    if(!isDefined(self) || !isalive(self) || istrue(self.leavecasualkiller)) {
      return;
    }
    self.gunposeoverride = "disable";
    forward = anglesToForward(self.angles);
    _id_63A5B32B096323BE = self getshootfrompos();

    if(_id_47BCCB924D51B014) {
      if(!isalive(_id_80C53303FB317FE2)) {
        _id_BF49E927A147E7EA = gettime();
        self setentitytarget(self.ck_target);
        self forcethreatupdate();
        _id_47BCCB924D51B014 = 0;
        _id_D9F67B70125E4D15 = undefined;
      } else
        self.ck_target.origin = _id_80C53303FB317FE2.origin;
    }

    _id_67C7CB82CFC5EE69 = int(gettime() / 50);

    if(self getentitynumber() % 4 != _id_67C7CB82CFC5EE69 % 4) {
      if(isDefined(_id_BF49E927A147E7EA) && _id_BF49E927A147E7EA + 3000 > gettime()) {
        _id_7F96D62F3ABBF9B9 = self.ck_target.origin - self.origin;

        if(length(_id_7F96D62F3ABBF9B9) > 100) {
          _id_7F96D62F3ABBF9B9 = vectorNormalize(_id_7F96D62F3ABBF9B9);
          _id_B38F9F63C4AE4218 = abs(angleclamp180(acos(clamp(vectordot(forward, _id_7F96D62F3ABBF9B9), -1.0, 1.0))));

          if(_id_B38F9F63C4AE4218 > 30 && gettime() < _id_BF49E927A147E7EA + 1500) {
            continue;
          }
          if(_id_B38F9F63C4AE4218 < 90)
            continue;
        }
      }

      _id_BF49E927A147E7EA = undefined;

      if(!isDefined(_id_D9F67B70125E4D15) || gettime() > _id_D9F67B70125E4D15 + 3000) {
        self clearentitytarget();
        self forcethreatupdate();

        if(isalive(self.enemy)) {
          if(_id_47BCCB924D51B014 && self.enemy == _id_80C53303FB317FE2) {
            _id_BD73C7ACC56CD20C = self.enemy;
            _id_9001DA663C7CDFEC = self.enemy.origin - self.origin;
            _id_9001DA663C7CDFEC = vectorNormalize(_id_9001DA663C7CDFEC);
            dot = clamp(vectordot(forward, _id_9001DA663C7CDFEC), -1.0, 1.0);
            _id_7EF311E27099889B = abs(angleclamp180(acos(dot)));

            if(_id_7EF311E27099889B > 70) {
              _id_70F421A55D12E111 = self getsecondarytargets();

              if(isDefined(_id_70F421A55D12E111)) {
                foreach(secondarytarget in _id_70F421A55D12E111) {
                  _id_7F96D62F3ABBF9B9 = secondarytarget.origin - self.origin;
                  _id_7F96D62F3ABBF9B9 = vectorNormalize(_id_7F96D62F3ABBF9B9);
                  _id_B38F9F63C4AE4218 = abs(angleclamp180(acos(clamp(vectordot(forward, _id_7F96D62F3ABBF9B9), -1.0, 1.0))));

                  if(_id_B38F9F63C4AE4218 < _id_7EF311E27099889B) {
                    _id_7EF311E27099889B = _id_B38F9F63C4AE4218;
                    _id_BD73C7ACC56CD20C = secondarytarget;
                  }
                }

                if(_id_BD73C7ACC56CD20C != self.enemy) {
                  if(issentient(_id_BD73C7ACC56CD20C)) {
                    self.favoriteenemy = _id_BD73C7ACC56CD20C;
                    self forcethreatupdate();
                    self.favoriteenemy = undefined;
                    _id_D9F67B70125E4D15 = gettime();
                  }
                }
              }
            }
          }

          _id_47BCCB924D51B014 = isalive(self.enemy);

          if(_id_47BCCB924D51B014)
            _id_80C53303FB317FE2 = self.enemy;
          else
            _id_80C53303FB317FE2 = undefined;

          continue;
        } else {
          self setentitytarget(self.ck_target);
          self forcethreatupdate();

          if(isDefined(_id_BF49E927A147E7EA) && _id_BF49E927A147E7EA + 7000 > gettime()) {
            if(vectordot(forward, self.ck_target.origin - _id_63A5B32B096323BE) > 0)
              continue;
          }

          self.ck_target.origin = self.origin + (0, 0, 40) + forward * 400;
        }
      }
    }
  }
}

casual_killer_sweep() {
  self endon("leaveCasualKiller");
  self endon("death");
  _id_CC9867C158EFEA96 = 100;
  _id_F1F1BCB5C9023D10 = 1000;
  _id_455248BA6A05B7F6 = 20;
  _id_FE188FFDFBD991D8 = -1;
  _id_7BB1D92AEF3FBB8B = [40, 50, 60];
  _id_6D41EACB164DA117 = [20, 25, 30];
  _id_04AC58FB63979CC4 = 0;
  _id_728F77917E6CF88F = 0;
  _id_9B4A37BAF5F7793A = scripts\engine\utility::random(_id_7BB1D92AEF3FBB8B);
  _id_6FD0DE104684E9FE = scripts\engine\utility::random(_id_6D41EACB164DA117);
  _id_2E51CBD330774656 = 0;
  _id_5CAF41274F960E0D = undefined;
  _id_3085BDE8D3B9F336 = undefined;

  foreach(_id_07F870143D9150C8 in _id_6D41EACB164DA117) {
    if(_id_07F870143D9150C8 > _id_04AC58FB63979CC4)
      _id_04AC58FB63979CC4 = _id_07F870143D9150C8;
  }

  while(isalive(self) && isDefined(self)) {
    waitframe();
    self.leftaimlimit = 90;
    self.rightaimlimit = -90;
    self.aimyawspeed = 180;
    forward = anglesToForward(self.angles);
    _id_63A5B32B096323BE = self getshootfrompos();

    if(isDefined(self.enemy)) {
      if(!isDefined(self.pathgoalpos) || self.lookaheaddist > self aigetdesiredspeed())
        _id_5CAF41274F960E0D = self.enemy getshootatpos();
    }

    _id_7DFF387EDF36893B = scripts\asm\asm::asm_currentstatehasflag(self._id_A709FBD9FEA148F6, "aim") || scripts\asm\asm::asm_currentstatehasflag(self._id_A709FBD9FEA148F6, "notetrackAim");

    if(_id_7DFF387EDF36893B)
      _id_7DFF387EDF36893B = isDefined(_id_5CAF41274F960E0D);

    currentstate = scripts\asm\asm::asm_getcurrentstate(self.asmname);

    if(currentstate == "exposed_arrival" || currentstate == "exposed_reload")
      _id_7DFF387EDF36893B = 0;

    if(_id_7DFF387EDF36893B) {
      _id_F58D35FFFFDF0E30 = self getposonpath(self aigetdesiredspeed());
      _id_778D002D5BE90B60 = _id_5CAF41274F960E0D - _id_F58D35FFFFDF0E30;
      _id_778D002D5BE90B60 = (_id_778D002D5BE90B60[0], _id_778D002D5BE90B60[1], 0);
      _id_3C8323340D37BFFD = vectorNormalize(_id_778D002D5BE90B60);
      _id_4C3BAABE5686A741 = self.leftaimlimit;

      if(!istrue(_id_3085BDE8D3B9F336))
        _id_4C3BAABE5686A741 = max(0, self.leftaimlimit - 20);

      _id_9625B7F28569E37A = abs(angleclamp180(acos(clamp(vectordot(_id_3C8323340D37BFFD, forward), -1.0, 1.0))));

      if(_id_9625B7F28569E37A >= _id_4C3BAABE5686A741) {
        _id_5CAF41274F960E0D = undefined;
        _id_2E51CBD330774656 = 0;
        _id_7DFF387EDF36893B = 0;
      }
    }

    if(!istrue(_id_7DFF387EDF36893B)) {
      scripts\common\utility::lookatentity(undefined);
      scripts\common\utility::lookatpos(_id_63A5B32B096323BE + forward * 200);
      self.casualkillershootpos = _id_63A5B32B096323BE + forward * 200;
      _id_455248BA6A05B7F6 = 20 * _id_FE188FFDFBD991D8;
      _id_FE188FFDFBD991D8 = _id_FE188FFDFBD991D8 * -1;
      _id_2E51CBD330774656 = 0;
      self.dontevershoot = 1;
      _id_3085BDE8D3B9F336 = 0;
      continue;
    }

    _id_3085BDE8D3B9F336 = 1;
    self.dontevershoot = 0;

    if(isDefined(_id_5CAF41274F960E0D))
      scripts\common\utility::lookatpos(_id_5CAF41274F960E0D);
    else {
      scripts\common\utility::lookatentity(undefined);
      scripts\common\utility::lookatpos(undefined);
    }

    _id_778D002D5BE90B60 = _id_5CAF41274F960E0D - _id_63A5B32B096323BE;
    _id_10F0CE3CFFED6ABB = length(_id_778D002D5BE90B60);
    _id_3C8323340D37BFFD = vectorNormalize(_id_778D002D5BE90B60);
    _id_9625B7F28569E37A = abs(angleclamp180(acos(clamp(vectordot(forward, _id_3C8323340D37BFFD), -1.0, 1.0))));
    _id_40577E9AFA2538DF = axistoangles(_id_3C8323340D37BFFD, anglestoright(self.angles), anglestoup(self.angles));
    _id_1D68D29C186725D1 = _id_40577E9AFA2538DF[1];

    if(istrue(self.leavecasualkiller)) {
      if(_id_455248BA6A05B7F6 > 0) {
        _id_455248BA6A05B7F6 = _id_455248BA6A05B7F6 - min(_id_455248BA6A05B7F6, _id_9B4A37BAF5F7793A * level.framedurationseconds);
        _id_FE188FFDFBD991D8 = -1;
      } else if(_id_455248BA6A05B7F6 < 0) {
        _id_455248BA6A05B7F6 = _id_455248BA6A05B7F6 + min(_id_455248BA6A05B7F6 * -1, _id_9B4A37BAF5F7793A * level.framedurationseconds);
        _id_FE188FFDFBD991D8 = 1;
      }
    } else if(_id_9625B7F28569E37A + _id_04AC58FB63979CC4 < abs(self.leftaimlimit) && _id_9625B7F28569E37A + _id_04AC58FB63979CC4 < abs(self.rightaimlimit) && _id_10F0CE3CFFED6ABB > _id_CC9867C158EFEA96 && (_id_10F0CE3CFFED6ABB < _id_F1F1BCB5C9023D10 || isDefined(self.enemy) && self.enemy == level.player)) {
      if(gettime() > _id_728F77917E6CF88F) {
        _id_0F661D02C9F3036B = level.framedurationseconds * _id_9B4A37BAF5F7793A * _id_FE188FFDFBD991D8;
        _id_455248BA6A05B7F6 = _id_455248BA6A05B7F6 + _id_0F661D02C9F3036B;

        if(scripts\engine\utility::sign(_id_455248BA6A05B7F6) == scripts\engine\utility::sign(_id_FE188FFDFBD991D8) && abs(_id_455248BA6A05B7F6) > _id_6FD0DE104684E9FE) {
          _id_FE188FFDFBD991D8 = _id_FE188FFDFBD991D8 * -1;
          _id_9B4A37BAF5F7793A = scripts\engine\utility::random(_id_7BB1D92AEF3FBB8B);
          _id_6FD0DE104684E9FE = scripts\engine\utility::random(_id_6D41EACB164DA117);
          _id_728F77917E6CF88F = gettime() + 350;
        }
      }

      _id_1D68D29C186725D1 = _id_1D68D29C186725D1 + _id_455248BA6A05B7F6;
    }

    _id_A1142E485A655FEC = axistoangles(_id_3C8323340D37BFFD, anglestoright(self.angles), anglestoup(self.angles));
    _id_A1142E485A655FEC = (_id_A1142E485A655FEC[0], _id_1D68D29C186725D1, _id_A1142E485A655FEC[2]);
    _id_3C8323340D37BFFD = anglesToForward(_id_A1142E485A655FEC);
    self.casualkillershootpos = _id_3C8323340D37BFFD * _id_10F0CE3CFFED6ABB + _id_63A5B32B096323BE;

    if(istrue(self.leavecasualkiller) && _id_455248BA6A05B7F6 == 0)
      return;
  }
}