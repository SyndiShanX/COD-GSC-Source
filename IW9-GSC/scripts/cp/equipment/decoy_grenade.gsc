/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\decoy_grenade.gsc
**************************************************/

decoy_init() {
  level.decoygrenades = [];
  _id_962A30A9BB8C0F09 = spawnStruct();
  level.decoygrenadedata = _id_962A30A9BB8C0F09;
  _id_962A30A9BB8C0F09.firetypes = [];
  _id_962A30A9BB8C0F09.firetypeweights = [];
  _id_962A30A9BB8C0F09.firetimes = [];
  _id_962A30A9BB8C0F09.firemaxcounts = [];
  _id_962A30A9BB8C0F09.fireintervalmintimes = [];
  _id_962A30A9BB8C0F09.fireintervalmaxtimes = [];
  _id_962A30A9BB8C0F09.fireminupimpulse = [];
  _id_962A30A9BB8C0F09.firemaxupimpulse = [];
  _id_962A30A9BB8C0F09.fireminforwardimpulse = [];
  _id_962A30A9BB8C0F09.firemaxforwardimpulse = [];
  _id_962A30A9BB8C0F09.firetypes[_id_962A30A9BB8C0F09.firetypes.size] = "ar";
  _id_962A30A9BB8C0F09.firetypeweights["ar"] = 35;
  _id_962A30A9BB8C0F09.firetimes["ar"] = 0.4;
  _id_962A30A9BB8C0F09.firemaxcounts["ar"] = 0;
  _id_962A30A9BB8C0F09.fireintervalmintimes["ar"] = 0.5;
  _id_962A30A9BB8C0F09.fireintervalmaxtimes["ar"] = 2;
  _id_962A30A9BB8C0F09.fireminupimpulse["ar"] = 175;
  _id_962A30A9BB8C0F09.firemaxupimpulse["ar"] = 225;
  _id_962A30A9BB8C0F09.fireminforwardimpulse["ar"] = 55;
  _id_962A30A9BB8C0F09.firemaxforwardimpulse["ar"] = 125;
  _id_962A30A9BB8C0F09.firetypes[_id_962A30A9BB8C0F09.firetypes.size] = "smg";
  _id_962A30A9BB8C0F09.firetypeweights["smg"] = 50;
  _id_962A30A9BB8C0F09.firetimes["smg"] = 0.4;
  _id_962A30A9BB8C0F09.firemaxcounts["smg"] = 0;
  _id_962A30A9BB8C0F09.fireintervalmintimes["smg"] = 0.25;
  _id_962A30A9BB8C0F09.fireintervalmaxtimes["smg"] = 1;
  _id_962A30A9BB8C0F09.fireminupimpulse["smg"] = 80;
  _id_962A30A9BB8C0F09.firemaxupimpulse["smg"] = 125;
  _id_962A30A9BB8C0F09.fireminforwardimpulse["smg"] = 175;
  _id_962A30A9BB8C0F09.firemaxforwardimpulse["smg"] = 265;
  _id_962A30A9BB8C0F09.firetypes[_id_962A30A9BB8C0F09.firetypes.size] = "sniper";
  _id_962A30A9BB8C0F09.firetypeweights["sniper"] = 15;
  _id_962A30A9BB8C0F09.firetimes["sniper"] = 0.4;
  _id_962A30A9BB8C0F09.firemaxcounts["sniper"] = 0;
  _id_962A30A9BB8C0F09.fireintervalmintimes["sniper"] = 1;
  _id_962A30A9BB8C0F09.fireintervalmaxtimes["sniper"] = 3;
  _id_962A30A9BB8C0F09.fireminupimpulse["sniper"] = 250;
  _id_962A30A9BB8C0F09.firemaxupimpulse["sniper"] = 375;
  _id_962A30A9BB8C0F09.fireminforwardimpulse["sniper"] = 0;
  _id_962A30A9BB8C0F09.firemaxforwardimpulse["sniper"] = 60;

  if(!threatbiasgroupexists("axis"))
    createthreatbiasgroup("axis");

  createthreatbiasgroup("decoy_grenade");
  createthreatbiasgroup("decoy_grenade_ignore");
  setignoremegroup("decoy_grenade", "decoy_grenade_ignore");
}

decoy_used(grenade) {
  grenade endon("death");
  grenade.grenade_owner_name = self.name;
  grenade.playersdebuffed = [];
  grenade.decoyassists = 0;
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::decoy_empapplied);
  grenade scripts\cp_mp\emp_debuff::allow_emp(0);
  decoy_addtogloballist(grenade);
  thread _id_74502A9E0EF1F19C::monitordisownedgrenade(self, grenade);
  wait 0.4;
  grenade scripts\cp_mp\emp_debuff::allow_emp(1);
  grenade thread _id_74502A9E0EF1F19C::monitordamage(19, "hitequip", ::decoy_handlefataldamage, ::decoy_handledamage);
  grenade thread decoy_monitorposition();
  wait 0.6;
  endtime = gettime() + 5000;
  _id_5DB609B6270B36F5 = gettime();
  _id_EDAA2169EC420478 = 3;

  while(gettime() < endtime) {
    if(gettime() >= _id_5DB609B6270B36F5) {
      _id_5DB609B6270B36F5 = gettime() + 200.0;

      if(grenade decoy_isonground()) {
        _id_EDAA2169EC420478--;

        if(_id_EDAA2169EC420478 == 0) {
          break;
        }
      } else
        _id_EDAA2169EC420478 = 3;
    }

    wait 0.2;
  }

  grenade thread decoy_monitorfuse();
  grenade thread decoy_activated();
}

decoy_activated() {
  self endon("death");
  self setotherent(self.owner);
  self setscriptablepartstate("beacon", "active", 0);
  firetype = decoy_getfiretype();

  for(;;) {
    decoy_firesequence(firetype);
    wait(randomfloatrange(0.5, 1.5));
  }
}

decoy_destroy() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread decoy_delete(0.1);
}

decoy_delete(delay) {
  if(!isDefined(delay))
    delay = 0;

  self notify("death");
  self.exploding = 1;
  decoy_removefromgloballist(self getentitynumber());
  wait(delay);
  self delete();
}

decoy_firesequence(firetype) {
  _id_962A30A9BB8C0F09 = decoy_getleveldata();
  _id_A2A92143787D00A4 = 1;

  if(_id_962A30A9BB8C0F09.firemaxcounts[firetype] > 0)
    _id_A2A92143787D00A4 = _id_A2A92143787D00A4 + randomint(_id_962A30A9BB8C0F09.firemaxcounts[firetype]);

  for(;;) {
    _id_A2A92143787D00A4--;
    decoy_fireevent(firetype);

    if(_id_A2A92143787D00A4 == 0) {
      break;
    }

    wait(randomfloatrange(_id_962A30A9BB8C0F09.fireintervalmintimes[firetype], _id_962A30A9BB8C0F09.fireintervalmaxtimes[firetype]));
  }
}

decoy_fireevent(firetype) {
  velocity = decoy_getvelocity();
  angles = decoy_getfireeventangles(velocity);
  _id_D71630B8BAF84FA8 = decoy_getfireeventimpulse(velocity, firetype, angles);
  _id_F24845EEAEEDC946 = self.owner getheldoffhand();

  if(!isDefined(_id_F24845EEAEEDC946) || _id_F24845EEAEEDC946.basename != "frag_grenade_mp")
    self.owner scripts\cp\utility::_launchgrenade("decoy_grenade_mp", self.origin, _id_D71630B8BAF84FA8, 100, 1, self);

  self setCanDamage(1);
  self setscriptablepartstate("beacon", "active", 0);
  self setscriptablepartstate("weaponFire", firetype + "Fire", 0);
  self setscriptablepartstate("weaponSounds", firetype + "Fire", 0);
  pinglocationenemyteams(self.origin, self.team, self.owner);
  scripts\cp\utility::make_entity_sentient_cp(self.team);
  self setthreatbiasgroup("decoy_grenade");
  decoy_debuffenemiesinrange(1);
  _id_962A30A9BB8C0F09 = decoy_getleveldata();
  wait(_id_962A30A9BB8C0F09.firetimes[firetype]);
}

decoy_debuffenemiesinrange(_id_0FCE8828ABF8327B) {
  _id_16B6286D1893C20D = scripts\common\utility::_id_98A826B6B6D0D118(self.origin, 800);

  foreach(enemy in _id_16B6286D1893C20D) {
    if(!enemy scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, enemy))) {
      continue;
    }
    if(istrue(_id_0FCE8828ABF8327B) && isagent(enemy)) {
      enemy aieventlistenerevent("gunshot", self, self.origin);
      continue;
    }

    enemy aieventlistenerevent("decoy_grenade", self, self.origin);
  }
}

decoy_aiseenplayerrecently(ai) {
  _id_934F2BD9F0E5C04B = 1.5;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(ai seerecently(level.players[_id_AC0E594AC96AA3A8], _id_934F2BD9F0E5C04B))
      return 1;
  }

  return 0;
}

decoy_aicanseeanyplayer(ai) {
  foreach(player in level.players) {
    if(decoy_canseeplayer(ai, player))
      return 1;
  }

  return 0;
}

decoy_canseeplayer(ai, player) {
  _id_17BF930968A3057D = ai cansee(player);

  if(_id_17BF930968A3057D) {
    passed = sighttracepassed(ai getEye(), player getEye(), 0, ai, 1);

    if(!passed)
      return 0;

    contents = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(ai getEye(), player getEye(), ai, contents))
      return 0;

    return 1;
  }

  return 0;
}

decoy_ignoredbyenemy(ai) {
  ai setthreatbiasgroup("decoy_grenade_ignore");
}

decoy_clearaithreatbiasgroup(ai) {
  group = ai getthreatbiasgroup();

  if(group == "decoy_grenade_ignore")
    ai setthreatbiasgroup("axis");
}

decoy_debuffenemy(ai) {
  level endon("game_ended");
  self endon("death");
  owner = self.owner;
  owner endon("disconnect");
  self notify("decoy_debuffEnemy_" + ai getentitynumber());
  self endon("decoy_debuffEnemy_" + ai getentitynumber());
  self endon("decoy_stopTracking_" + ai getentitynumber());

  if(!isDefined(self.playersdebuffed[ai getentitynumber()])) {
    self.playersdebuffed[ai getentitynumber()] = ai;
    level thread decoy_delaystoptrackingassist(self, ai, 10);
    decoy_clearaithreatbiasgroup(ai);
  }

  result = "";
  ai waittill("death");
  waitframe();

  if(isDefined(self))
    self.playersdebuffed[ai getentitynumber()] = undefined;

  if(isDefined(ai.attackers)) {
    foreach(attacker in ai.attackers)
    decoy_giveassistpoint(attacker, ai, owner);
  } else if(isDefined(ai.attacker))
    decoy_giveassistpoint(ai.attacker, ai, owner);
}

decoy_delaystoptrackingassist(grenade, ai, delay) {
  level endon("game_ended");
  ai endon("death");
  grenade endon("death");
  ai.baitedbydecoy = grenade;
  wait(delay);
  grenade notify("decoy_stopTracking_" + ai getentitynumber());
}

decoy_giveassistpoint(player, ai, owner) {
  if(!isDefined(_id_6F1E07CE9FF97D5F::_validateattacker(player))) {
    return;
  }
  if(player == owner) {
    return;
  }
  _id_152B8F126AF5871D = ai.team;

  if(!isDefined(ai.team) && isDefined(ai.agentteam))
    _id_152B8F126AF5871D = ai.agentteam;

  if(isDefined(_id_152B8F126AF5871D) && isDefined(owner.team) && _id_152B8F126AF5871D != owner.team) {
    if(self.decoyassists < 3) {
      owner thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_EF68378274BC9C41");
      owner thread _id_293BC33BD79CABD1::killeventtextpopup("stat_EF68378274BC9C41");
      self.decoyassists++;
    }
  }
}

decoy_monitorposition() {
  self endon("death");

  for(;;) {
    oldposition = self.origin;
    waitframe();
    self.oldposition = oldposition;
  }
}

decoy_monitorfuse() {
  self endon("death");
  wait 7;
  thread decoy_destroy();
}

decoy_empapplied(_id_E527F023260C562C) {
  _id_E527F023260C562C.victim decoy_givepointsfordestroy(_id_E527F023260C562C.attacker);
  _id_E527F023260C562C.victim thread decoy_destroy();
}

decoy_handledamage(data) {
  return data.damage;
}

decoy_handlefataldamage(data) {
  decoy_givepointsfordestroy(data.attacker);
  thread decoy_destroy();
}

decoy_getfiretype() {
  _id_A78DC38B12EAFEBA = 0;
  _id_2873368D0CD5753F = [];
  _id_962A30A9BB8C0F09 = decoy_getleveldata();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_962A30A9BB8C0F09.firetypes.size; _id_AC0E594AC96AA3A8++) {
    firetype = _id_962A30A9BB8C0F09.firetypes[_id_AC0E594AC96AA3A8];
    _id_A78DC38B12EAFEBA = _id_A78DC38B12EAFEBA + _id_962A30A9BB8C0F09.firetypeweights[firetype];
    _id_2873368D0CD5753F[_id_AC0E594AC96AA3A8] = _id_A78DC38B12EAFEBA;
  }

  _id_854B5C669A29592A = randomint(_id_A78DC38B12EAFEBA);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2873368D0CD5753F.size; _id_AC0E594AC96AA3A8++) {
    if(_id_854B5C669A29592A < _id_2873368D0CD5753F[_id_AC0E594AC96AA3A8])
      return _id_962A30A9BB8C0F09.firetypes[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

decoy_getvelocity() {
  if(!isDefined(self.oldposition))
    return undefined;

  return (self.origin - self.oldposition) / level.framedurationseconds;
}

decoy_getfireeventangles(velocity) {
  angles = undefined;

  if(!isDefined(velocity))
    angles = (0, randomint(360), 0);
  else if(velocity * (1, 1, 0) == (0, 0, 0))
    angles = (0, randomint(360), 0);
  else if(randomint(100) < 20)
    angles = (0, randomint(360), 0);
  else {
    angles = vectortoangles(velocity * (1, 1, 0));
    yaw = angleclamp180(angles[1]);
    yaw = yaw + angleclamp(-30.0 + randomint(61));
    angles = (angles[0], yaw, angles[2]);
  }

  return angles;
}

decoy_getfireeventimpulse(velocity, firetype, _id_7F51BB920D03D261) {
  _id_962A30A9BB8C0F09 = decoy_getleveldata();
  _id_D71630B8BAF84FA8 = velocity;
  _id_D71630B8BAF84FA8 = _id_D71630B8BAF84FA8 + anglestoup(_id_7F51BB920D03D261) * randomfloatrange(_id_962A30A9BB8C0F09.fireminupimpulse[firetype], _id_962A30A9BB8C0F09.firemaxupimpulse[firetype]);
  _id_D71630B8BAF84FA8 = _id_D71630B8BAF84FA8 + anglesToForward(_id_7F51BB920D03D261) * randomfloatrange(_id_962A30A9BB8C0F09.fireminforwardimpulse[firetype], _id_962A30A9BB8C0F09.firemaxforwardimpulse[firetype]);
  return _id_D71630B8BAF84FA8;
}

decoy_isonground() {
  vel = decoy_getvelocity();

  if(!isDefined(vel) || abs(vel[2]) <= 200) {
    if(decoy_isongroundraycastonly())
      return 1;
  }

  return 0;
}

decoy_isongroundraycastonly() {
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1);
  caststart = self.origin + (0, 0, 1);
  castend = caststart + (0, 0, -5);
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0)
    return 1;

  return 0;
}

decoy_givepointsfordestroy(attacker) {
  if(isDefined(attacker) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)))
    attacker notify("destroyed_equipment");
}

decoy_addtogloballist(grenade) {
  level.decoygrenades[grenade getentitynumber()] = grenade;
}

decoy_removefromgloballist(entnum) {
  level.decoygrenades[entnum] = undefined;
}

decoy_getleveldata() {
  return level.decoygrenadedata;
}