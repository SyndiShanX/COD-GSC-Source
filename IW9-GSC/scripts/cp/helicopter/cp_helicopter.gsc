/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\helicopter\cp_helicopter.gsc
***************************************************/

heli_precache() {
  level._effect["smoke_trail"] = loadfx("vfx/core/smktrail/smoke_trail_white_heli.vfx");
  level._effect["aerial_explosion"] = loadfx("vfx/core/expl/aerial_explosion.vfx");
  level._effect["chopper_sparks"] = loadfx("vfx/iw8_cp/level/cp_stk_faridah/vfx_chopper_sparks.vfx");
  level._effect["blima_rocket_flash"] = loadfx("vfx/iw8/core/lbravo/vfx_lbravo_rocket_pod_launch.vfx");
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
}

heli_mg_create(_id_E686BAEE775AD49F, turret_weapon, _id_D585FC09C3D5709D, _id_54E555C4779C2A75) {
  tag = "tag_flash";

  if(isDefined(_id_D585FC09C3D5709D))
    tag = _id_D585FC09C3D5709D;

  _id_1E2F2224127D2990 = (0, 0, 0);

  if(isDefined(_id_54E555C4779C2A75))
    origin_offset = _id_54E555C4779C2A75;

  origin = self gettagorigin(tag);

  if(!isDefined(turret_weapon))
    turret_weapon = "sentry_minigun_mp";

  if(isDefined(level.heli_minigun_override))
    turret_weapon = level.heli_minigun_override;

  self.minigun = spawnturret("misc_turret", origin, turret_weapon);
  self.minigun.angles = self gettagangles(tag);

  if(isDefined(_id_E686BAEE775AD49F))
    self.minigun setModel(_id_E686BAEE775AD49F);
  else
    self.minigun setModel("veh8_mil_air_ahotel64_turret_wm");

  self.minigun setmode("manual");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(360);
  self.minigun setrightarc(360);
  self.minigun settoparc(5);
  self.minigun setbottomarc(90);
  self.minigun setconvergencetime(0.05, "yaw");
  self.minigun setconvergencetime(0.05, "pitch");
  self.minigun linkTo(self, tag, _id_1E2F2224127D2990, (0, 0, 0));
  self.minigun setturretteam("axis");
  self.minigun.chopper = self;
  thread scripts\engine\utility::delete_on_death(self.minigun);
}

heli_dmg_sparks() {
  self endon("death");
  playFXOnTag(level._effect["smoke_trail"], self, "tag_origin");
  count = 0;

  for(;;) {
    wait(randomfloatrange(0.2, 3));
    playFX(level._effect["chopper_sparks"], self.origin + (randomintrange(-100, 100), randomintrange(-50, 50), randomintrange(-100, 0)));
  }
}

heli_think_default(_id_8FDFAD46F0546243, chopper_height, _id_71A6211BC7ECFE18) {
  _id_8FDFAD46F0546243 endon("death");
  _id_8FDFAD46F0546243 endon("leave_area");

  if(isDefined(_id_71A6211BC7ECFE18))
    chopper_height = scripts\engine\utility::getStructArray(_id_71A6211BC7ECFE18, "script_noteworthy")[0].origin[2];
  else if(!isDefined(chopper_height))
    chopper_height = scripts\engine\utility::getStructArray("heli_search", "script_noteworthy")[0].origin[2];

  _id_8FDFAD46F0546243.chopper_height = chopper_height;
  _id_8FDFAD46F0546243 thread rumble_nearby_players();
  level thread evasive_think(_id_8FDFAD46F0546243);
  _id_8FDFAD46F0546243.minigun setmode("manual");
  _id_8FDFAD46F0546243.nextfiretime = gettime() + 2000;
  _id_ECBF90442E065A5F = 0;
  timeout = 5;
  _id_8FDFAD46F0546243 vehicle_setspeed(50, 30);

  for(;;) {
    if(_id_8FDFAD46F0546243.needs_to_evade) {
      _id_8FDFAD46F0546243 notify("evade");
      _id_8FDFAD46F0546243 waittill("evasive_action_done");
      _id_8FDFAD46F0546243.circling_target = 0;
      _id_8FDFAD46F0546243.needs_to_evade = 0;
    }

    _id_EC80496532425417 = _id_8FDFAD46F0546243 heli_get_target(undefined, 0);

    if(!isDefined(_id_EC80496532425417)) {
      wait 1;
      _id_ECBF90442E065A5F = _id_ECBF90442E065A5F + 1;

      if(_id_ECBF90442E065A5F > timeout) {
        _id_8FDFAD46F0546243 heli_go_search(undefined, undefined, _id_71A6211BC7ECFE18);
        _id_EC80496532425417 = _id_8FDFAD46F0546243.best_target;
        _id_ECBF90442E065A5F = 0;
      } else
        continue;
    }

    if(_id_8FDFAD46F0546243 should_move_to_target(_id_8FDFAD46F0546243.minigun, _id_EC80496532425417))
      _id_8FDFAD46F0546243 heli_move_to_target(_id_EC80496532425417);

    if(istrue(_id_8FDFAD46F0546243.nocircle))
      _id_8FDFAD46F0546243 thread engage_target_from_pos(_id_EC80496532425417);
    else
      _id_8FDFAD46F0546243 thread engage_target_circle_strafe(_id_EC80496532425417, chopper_height);

    _id_8FDFAD46F0546243 scripts\engine\utility::waittill_any_timeout_2(60, "target_engaged", "needs_to_evade");
    _id_8FDFAD46F0546243.nocircle = 0;
  }
}

heli_rocket_think_default(_id_8FDFAD46F0546243) {
  if(!isDefined(_id_8FDFAD46F0546243) || !isalive(_id_8FDFAD46F0546243)) {
    return;
  }
  _id_8FDFAD46F0546243 endon("death");
  chopper_height = scripts\engine\utility::getStructArray("heli_search", "script_noteworthy")[0].origin[2];
  _id_8FDFAD46F0546243.has_rockets = 1;
  _id_8FDFAD46F0546243.chopper_height = chopper_height;
  _id_8FDFAD46F0546243 thread rumble_nearby_players();

  if(!isDefined(_id_8FDFAD46F0546243.evade_radius))
    _id_8FDFAD46F0546243.evade_radius = 2000;

  _id_8FDFAD46F0546243.rockets_ready = 1;
  level thread evasive_think(_id_8FDFAD46F0546243);

  if(isDefined(_id_8FDFAD46F0546243.minigun))
    _id_8FDFAD46F0546243.minigun setmode("manual");

  _id_8FDFAD46F0546243.nextfiretime = gettime() + 2000;
  _id_ECBF90442E065A5F = 0;
  timeout = 5;
  _id_8FDFAD46F0546243 vehicle_setspeed(50, 30);

  for(;;) {
    if(_id_8FDFAD46F0546243.needs_to_evade) {
      _id_8FDFAD46F0546243 notify("evade");
      _id_8FDFAD46F0546243 waittill("evasive_action_done");
      _id_8FDFAD46F0546243.circling_target = 0;
      _id_8FDFAD46F0546243.needs_to_evade = 0;
    }

    if(istrue(_id_8FDFAD46F0546243.force_search)) {
      _id_8FDFAD46F0546243 heli_go_search();
      _id_EC80496532425417 = _id_8FDFAD46F0546243.best_target;
      _id_ECBF90442E065A5F = 0;
    } else {
      _id_EC80496532425417 = _id_8FDFAD46F0546243 heli_get_target(undefined, 0);

      if(!isDefined(_id_EC80496532425417)) {
        wait 1;
        _id_ECBF90442E065A5F = _id_ECBF90442E065A5F + 1;

        if(_id_ECBF90442E065A5F > timeout) {
          _id_8FDFAD46F0546243 heli_go_search();
          _id_EC80496532425417 = _id_8FDFAD46F0546243.best_target;
          _id_ECBF90442E065A5F = 0;
        } else
          continue;
      }
    }

    if(_id_8FDFAD46F0546243 should_move_to_target(_id_8FDFAD46F0546243, _id_EC80496532425417))
      _id_8FDFAD46F0546243 heli_move_to_target(_id_EC80496532425417);

    if(istrue(_id_8FDFAD46F0546243.nocircle))
      _id_8FDFAD46F0546243 thread engage_target_from_pos(_id_EC80496532425417);
    else
      _id_8FDFAD46F0546243 thread engage_target_circle_strafe(_id_EC80496532425417, chopper_height);

    _id_8FDFAD46F0546243 scripts\engine\utility::waittill_any_2("target_engaged", "needs_to_evade");
  }
}

heli_move_to_target(target) {
  self endon("death");
  self endon("crashing");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(target);
  chopper_height = _id_68C2534A5EA3CD2B();
  _id_119D71E3F7006F18 = (self.gotopos[0], self.gotopos[1], chopper_height);

  if(distance2dsquared(self.origin, _id_119D71E3F7006F18) > 640000) {
    self setneargoalnotifydist(300);
    self vehicle_setspeed(50, 30, 30);
    self setvehgoalpos(_id_119D71E3F7006F18, 1);
  } else {
    self vehicle_setspeed(15, 12, 12);
    self setvehgoalpos(_id_119D71E3F7006F18, 0);
  }

  scripts\engine\utility::waittill_any_timeout_3(15, "goal", "goal_reached", "near_goal");
}

engage_target_circle_strafe(_id_EC80496532425417, chopper_height) {
  self endon("needs_to_evade");
  self endon("death");
  self endon("crashing");

  if(isDefined(self.minigun))
    self.minigun endon("death");

  _id_EC80496532425417 endon("last_stand");
  _id_EC80496532425417 endon("disconnect");
  thread circle_around_target(_id_EC80496532425417, chopper_height);
  self setlookatent(_id_EC80496532425417);

  if(isDefined(self.minigun))
    self.minigun settargetentity(_id_EC80496532425417, (0, 0, 40));

  _id_2909ED8B5CAE5917 = undefined;

  while(istrue(self.circling_target)) {
    wait 0.1;
    _id_5F9755FB2B4043C7 = heli_can_target(_id_EC80496532425417, (0, 0, 60));

    if(!_id_5F9755FB2B4043C7) {
      self clearlookatent();

      if(isDefined(self.rockets))
        _id_D04BB1DC67A18E1B = self gettagorigin("tag_rocket_left");
      else
        _id_D04BB1DC67A18E1B = self.minigun gettagorigin("tag_flash");

      _id_2909ED8B5CAE5917 = choose_new_target(_id_D04BB1DC67A18E1B);

      if(!isDefined(_id_2909ED8B5CAE5917)) {
        self notify("stop_circling");
        waitframe();
        self notify("target_engaged");
        return;
      } else {
        _id_5F9755FB2B4043C7 = 1;

        if(isDefined(self.minigun))
          self.minigun settargetentity(_id_2909ED8B5CAE5917);

        self setlookatent(_id_2909ED8B5CAE5917);
      }
    }

    if(isDefined(self.minigun)) {
      result = scripts\engine\utility::waittill_any_ents_or_timeout_return(2, self.minigun, "turret_on_target");

      if(result != "turret_on_target")
        continue;
    }

    if(istrue(self.has_rockets)) {
      if(istrue(self.rockets_ready)) {
        if(isDefined(_id_2909ED8B5CAE5917))
          thread hover_and_shoot_rockets(_id_2909ED8B5CAE5917);
        else
          thread hover_and_shoot_rockets(_id_EC80496532425417);

        while(istrue(self.hovering))
          wait 0.1;
      }

      continue;
    }

    if(isDefined(_id_2909ED8B5CAE5917))
      thread shoot_at_target(_id_2909ED8B5CAE5917);
    else
      thread shoot_at_target(_id_EC80496532425417);

    while(istrue(self._id_BAF5FEC88743C60C))
      wait 0.1;

    wait(randomintrange(2, 4));
  }

  self notify("target_engaged");
}

engage_target_from_pos(_id_2909ED8B5CAE5917) {
  self endon("death");
  self endon("crashing");
  self sethoverparams(150, 35, 35);

  if(!istrue(self.has_rockets)) {
    self.minigun settargetentity(_id_2909ED8B5CAE5917, (0, 0, 40));
    result = scripts\engine\utility::waittill_any_ents_or_timeout_return(3, self.minigun, "turret_on_target");
  } else
    wait 2;

  if(istrue(self.has_rockets)) {
    if(istrue(self.rockets_ready))
      hover_and_shoot_rockets(_id_2909ED8B5CAE5917);
  } else
    shoot_at_target(_id_2909ED8B5CAE5917);

  self notify("target_engaged");
  self sethoverparams(0, 0, 0);
}

choose_new_target(_id_AA440CDD07894C27) {
  new_target_dist = 3500;

  if(isDefined(self.new_target_dist))
    new_target_dist = self.new_target_dist;

  _id_BDD628D52F94BAA9 = new_target_dist * new_target_dist;

  foreach(player in level.players) {
    if(!player scripts\cp\utility::is_valid_player() || distance2dsquared(_id_AA440CDD07894C27, player.origin) > _id_BDD628D52F94BAA9) {
      continue;
    }
    if(!heli_can_target(player)) {
      continue;
    }
    return player;
  }

  return undefined;
}

shoot_at_target(target_ent) {
  self endon("death");
  self endon("crashing");
  self.minigun endon("death");
  self._id_BAF5FEC88743C60C = 1;
  _id_89F949A75D92E1A4 = randomintrange(20, 30);
  self.minigun startbarrelspin();
  wait 2;

  if(isPlayer(target_ent) && target_ent scripts\cp\utility::_hasperk("specialty_covert_ops"))
    wait 2;

  if(!isDefined(self._id_07741CD64DD73611)) {
    if(isPlayer(target_ent))
      level notify("playerdamaged", target_ent, 1);
    else if(isDefined(target_ent.owner))
      level notify("playerdamaged", target_ent.owner, 1);

    self._id_07741CD64DD73611 = 1;
  }

  _id_FA2483033790AF38 = makeweapon("chopper_gunner_turret_cp");
  _id_2C90EA28723E0BF7 = weaponfiretime(_id_FA2483033790AF38);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4; _id_AC0E594AC96AA3A8++) {
    self.minigun shootturret(undefined, 1);
    wait(_id_2C90EA28723E0BF7);
  }

  self.minigun stopbarrelspin();
  wait 2;
  self._id_BAF5FEC88743C60C = undefined;
}

shoot_rockets_at_target(target, _id_71BCB4A9304229BF, _id_C877BB2EF57412DA, _id_A06F14BA0BCB9459, _id_F1E32DB18D45A178, _id_D16BBD820535E195) {
  self endon("death");
  self endon("needs_to_evade");
  _id_55A9F8B00C149E9D = 0;

  if(!isDefined(_id_71BCB4A9304229BF))
    _id_71BCB4A9304229BF = "tag_rocket_left";

  if(!isDefined(_id_C877BB2EF57412DA))
    _id_C877BB2EF57412DA = "tag_rocket_right";

  if(!isDefined(_id_A06F14BA0BCB9459))
    _id_A06F14BA0BCB9459 = (0, 0, 0);

  if(!isDefined(_id_F1E32DB18D45A178))
    _id_F1E32DB18D45A178 = (0, 0, 0);

  _id_998F2B7F3281921F = 100;
  _id_658431AA09DC28A9 = 1;

  if(isDefined(self._id_0EDFF35A4F2CD74E))
    _id_658431AA09DC28A9 = self._id_0EDFF35A4F2CD74E;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_658431AA09DC28A9; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_D16BBD820535E195))
      target[[_id_D16BBD820535E195]](self);

    end_pos = target.origin;
    _id_D5685B7BAEE6505E = self gettagorigin(_id_C877BB2EF57412DA);
    _id_CD16187C64D68DDC = self gettagangles(_id_C877BB2EF57412DA) + _id_F1E32DB18D45A178;
    _id_09BCFC72D255B4CE = (0, 0, 0);
    _id_AEADB5AEB7E1E046 = randomintrange(-20, 20);
    _id_F7B89AC0144D0ED3 = randomintrange(-20, 20);
    end_pos = (end_pos[0] + _id_AEADB5AEB7E1E046, end_pos[1] + _id_F7B89AC0144D0ED3, end_pos[2]);
    end_pos = end_pos + _id_09BCFC72D255B4CE;

    if(scripts\engine\utility::within_fov(_id_D5685B7BAEE6505E, _id_CD16187C64D68DDC, end_pos, cos(45))) {
      playFXOnTag(level._effect["blima_rocket_flash"], self, _id_C877BB2EF57412DA);
      fwd = anglesToForward(_id_CD16187C64D68DDC);
      fwd = fwd * _id_998F2B7F3281921F;
      _id_D5685B7BAEE6505E = _id_D5685B7BAEE6505E + fwd;
      _id_D24FC89ECB62B562 = "iw8_la_rpapa7_heli_cp";
      rocket = magicbullet(_id_D24FC89ECB62B562, _id_D5685B7BAEE6505E, end_pos);

      if(isDefined(rocket))
        rocket.owner = self;

      _id_55A9F8B00C149E9D = 1;
    }

    wait 0.25;
    _id_D5685B7BAEE6505E = self gettagorigin(_id_71BCB4A9304229BF);
    _id_CD16187C64D68DDC = self gettagangles(_id_71BCB4A9304229BF) + _id_A06F14BA0BCB9459;
    _id_09BCFC72D255B4CE = (0, 0, 0);
    _id_AEADB5AEB7E1E046 = randomintrange(-20, 20);
    _id_F7B89AC0144D0ED3 = randomintrange(-20, 20);
    end_pos = (end_pos[0] + _id_AEADB5AEB7E1E046, end_pos[1] + _id_F7B89AC0144D0ED3, end_pos[2]);
    end_pos = end_pos + _id_09BCFC72D255B4CE;

    if(scripts\engine\utility::within_fov(_id_D5685B7BAEE6505E, _id_CD16187C64D68DDC, end_pos, cos(45))) {
      _id_5DEACB5AAA2F45DA = undefined;

      if(istrue(self._id_FE39CA10C2CE0840))
        _id_5DEACB5AAA2F45DA = level.agentarray[0];

      playFXOnTag(level._effect["blima_rocket_flash"], self, _id_71BCB4A9304229BF);
      fwd = anglesToForward(_id_CD16187C64D68DDC);
      fwd = fwd * _id_998F2B7F3281921F;
      _id_D5685B7BAEE6505E = _id_D5685B7BAEE6505E + fwd;
      _id_D24FC89ECB62B562 = "iw8_la_rpapa7_heli_cp";
      rocket = magicbullet(_id_D24FC89ECB62B562, _id_D5685B7BAEE6505E, end_pos, _id_5DEACB5AAA2F45DA);

      if(isDefined(rocket))
        rocket.owner = self;

      _id_55A9F8B00C149E9D = 1;
    }

    wait 0.5;
  }

  if(_id_55A9F8B00C149E9D)
    thread rocket_fire_cooldown(randomfloatrange(5, 8));

  if(istrue(self._id_A2838155288F4E2D)) {
    wait(self._id_A2838155288F4E2D);
    return;
  }
}

rocket_fire_cooldown(timer) {
  level endon("game_ended");
  self endon("death");
  self.rockets_ready = 0;
  wait(timer);
  self.rockets_ready = 1;
}

hover_and_shoot_rockets(target, _id_71BCB4A9304229BF, _id_C877BB2EF57412DA, _id_A06F14BA0BCB9459, _id_F1E32DB18D45A178, _id_D16BBD820535E195) {
  self endon("needs_to_evade");
  self notify("stop_circling");
  self.hovering = 1;
  self sethoverparams(25, 15, 10);
  self vehicle_setspeed(10, 10, 10);

  if(isPlayer(target) && target scripts\cp\utility::_hasperk("specialty_covert_ops"))
    wait 2;
  else if(isDefined(level._id_823764A36756DE4F))
    wait(level._id_823764A36756DE4F);

  shoot_rockets_at_target(target, _id_71BCB4A9304229BF, _id_C877BB2EF57412DA, _id_A06F14BA0BCB9459, _id_F1E32DB18D45A178, _id_D16BBD820535E195);
  self.hovering = 0;
}

heli_get_target(_id_AA440CDD07894C27, alert) {
  if(!isDefined(_id_AA440CDD07894C27))
    _id_AA440CDD07894C27 = self.origin;

  _id_114AB88507847C50 = undefined;
  _id_45D25409ACB2D4F9 = scripts\engine\utility::get_array_of_closest(_id_AA440CDD07894C27, level.players, undefined, undefined);

  foreach(player in _id_45D25409ACB2D4F9) {
    if(!player scripts\cp\utility::is_valid_player(undefined, 0) || istrue(player isinfreefall()) || istrue(player isskydiving()) || istrue(player isparachuting())) {
      continue;
    }
    chopper_height = _id_68C2534A5EA3CD2B(player);
    _id_AA440CDD07894C27 = (player.origin[0], player.origin[1], chopper_height);

    if(isDefined(player.vehicle))
      _id_072BD42692055CDD = [self, player, player.vehicle];
    else
      _id_072BD42692055CDD = [self, player];

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(_id_AA440CDD07894C27, player.origin + (0, 0, 10), _id_072BD42692055CDD)) {
        _id_114AB88507847C50 = player;
        self.gotopos = _id_AA440CDD07894C27;
      }
    }

    if(!isDefined(_id_114AB88507847C50)) {
      r = anglestoright(player.angles);
      _id_AC0E5E4AC96AAEA7 = anglestoleft(player.angles);
      f = anglesToForward(player.angles);
      b = f * -1;
      _id_D895C679F6A927E5 = [r, _id_AC0E5E4AC96AAEA7, f, b];

      foreach(point in _id_D895C679F6A927E5) {
        _id_AA440CDD07894C27 = (player.origin[0], player.origin[1], 0) + (point[0], point[1], 0) * 1800 + (0, 0, chopper_height);

        if(scripts\engine\trace::ray_trace_passed(_id_AA440CDD07894C27, player.origin + (0, 0, 10), _id_072BD42692055CDD)) {
          _id_114AB88507847C50 = player;
          self.gotopos = _id_AA440CDD07894C27;
          self.nocircle = 1;
          return _id_114AB88507847C50;
        }
      }
    }

    if(isDefined(_id_114AB88507847C50)) {
      break;
    }
  }

  return _id_114AB88507847C50;
}

heli_can_target(target, offset) {
  _id_9C9B691C180DE12C = 3500;

  if(isDefined(self.heli_can_target_dist))
    _id_9C9B691C180DE12C = self.heli_can_target_dist;

  if(!target scripts\cp\utility::is_valid_player() || distance2d(self.origin, target.origin) > _id_9C9B691C180DE12C)
    return 0;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  _id_D04BB1DC67A18E1B = self.minigun gettagorigin("tag_flash");
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  _id_D895C679F6A927E5 = [target gettagorigin("j_head"), target gettagorigin("j_mainroot"), target gettagorigin("tag_origin")];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(_id_D04BB1DC67A18E1B + offset, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], self, contents)) {
      continue;
    }
    return 1;
  }

  return 0;
}

heli_go_search(_id_CBD3F7020EC784E3, build_path, _id_71A6211BC7ECFE18) {
  self endon("death");
  self endon("heli_alerted");

  if(isDefined(_id_CBD3F7020EC784E3))
    _id_D3D48626775E0588 = _id_CBD3F7020EC784E3;
  else if(isDefined(_id_71A6211BC7ECFE18))
    _id_D3D48626775E0588 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray(_id_71A6211BC7ECFE18, "script_noteworthy"));
  else
    _id_D3D48626775E0588 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("heli_search", "script_noteworthy"));

  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();

  if(isDefined(self.minigun))
    self.minigun cleartargetentity();

  _id_556F4728526B670D = scripts\engine\utility::getStruct(_id_D3D48626775E0588.target, "targetname");
  self setvehgoalpos(_id_D3D48626775E0588.origin, 0);
  thread heli_check_players();
  scripts\engine\utility::waittill_any_timeout_2(15, "goal", "goal_reached");
  self vehicle_setspeed(30, 15);
  self setneargoalnotifydist(500);

  for(;;) {
    self setvehgoalpos(_id_556F4728526B670D.origin, 0);
    scripts\engine\utility::waittill_any_timeout_2(15, "goal", "goal_reached");
    _id_556F4728526B670D = scripts\engine\utility::getStruct(_id_556F4728526B670D.target, "targetname");
  }
}

heli_check_players() {
  self endon("death");
  self endon("heli_alerted");
  self endon("evade");
  self.best_target = undefined;

  for(;;) {
    _id_EC80496532425417 = heli_get_target(undefined, 0);

    if(!isDefined(_id_EC80496532425417)) {
      wait 1;
      continue;
    } else
      break;
  }

  self vehicle_setspeed(50, 30);
  self.best_target = _id_EC80496532425417;
  self notify("heli_alerted");
}

evasive_think(vehicle) {
  vehicle endon("death");

  if(!isDefined(vehicle.needs_to_evade))
    vehicle.needs_to_evade = 0;

  while(vehicle.health_remaining > 0) {
    vehicle waittill("evade", player);
    vehicle.circling_target = 0;
    chopper_height = vehicle _id_68C2534A5EA3CD2B();
    vehicle thread heli_evade((vehicle.origin[0], vehicle.origin[1], chopper_height));
    vehicle waittill("evasive_action_done");
  }
}

should_move_to_target(_id_A59EE877388B07FB, target) {
  _id_18F8FC61EB07BE87 = 3400;

  if(isDefined(self.should_move_to_target_dist))
    _id_18F8FC61EB07BE87 = self.should_move_to_target_dist;

  if(istrue(self.landed)) {
    self.landed = undefined;
    return 1;
  }

  if(distance2d(_id_A59EE877388B07FB.origin, target.origin) > _id_18F8FC61EB07BE87 || isDefined(self.gotopos) && distance(_id_A59EE877388B07FB.origin, self.gotopos) > _id_18F8FC61EB07BE87)
    return 1;

  return 0;
}

rumble_nearby_players() {
  self endon("death");
  self notify("rumble_players");
  self endon("rumble_players");

  for(;;) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.1;
  }
}

_id_0208126A1361C976() {
  self makeentitysentient("axis", 1);
  self._id_D1F953C063DFF1EB = 1;
}

circle_around_target(target_ent, chopper_height) {
  self endon("evade");
  self endon("death");
  self endon("stop_circling");
  self endon("crashing");
  self.circling_target = 1;
  circle_radius = 1500;

  if(isDefined(self.circle_radius))
    circle_radius = self.circle_radius;

  chopper_height = _id_68C2534A5EA3CD2B();
  target = (target_ent.origin[0], target_ent.origin[1], chopper_height);
  points = create_radius_around_point(target, 8, circle_radius);
  _id_2F05FDC372F83530 = 0;
  start_point = points[0];
  _id_7206821DC4564B24 = distance2dsquared(self.origin, points[0].origin);

  foreach(index, point in points) {
    dist = distance2dsquared(self.origin, point.origin);

    if(dist < _id_7206821DC4564B24) {
      _id_7206821DC4564B24 = dist;
      start_point = point;
      _id_2F05FDC372F83530 = index;
    }
  }

  self setvehgoalpos(points[_id_2F05FDC372F83530].origin);
  self.goalpos = points[_id_2F05FDC372F83530].origin;
  self setneargoalnotifydist(192);

  if(isDefined(self._id_9ED6827753DB2370))
    self vehicle_setspeed(self._id_9ED6827753DB2370, self._id_F9FF3A209AA9DB43, self._id_434136CAD96E6F3A);
  else
    self vehicle_setspeed(12, 10, 10);

  self.veh_speed_vals = (12, 10, 10);
  self.can_rocket_hover = 1;
  _id_0DB715BCDE296BEC = 0;
  index = _id_2F05FDC372F83530 + 1;

  while(_id_0DB715BCDE296BEC < points.size - 1) {
    while(istrue(self.hovering))
      wait 0.1;

    if(index >= points.size)
      index = 0;

    if(!isalive(target_ent)) {
      break;
    }

    _id_6F5A0897ADB0B19E = target_ent.origin + (0, 0, 60);

    if(!sighttracepassed(points[index].origin, _id_6F5A0897ADB0B19E, 0, undefined)) {
      wait 0.1;
      _id_0DB715BCDE296BEC++;
      index++;
      continue;
    }

    self setvehgoalpos(points[index].origin, 0);
    self.goalpos = points[_id_2F05FDC372F83530].origin;
    scripts\engine\utility::waittill_notify_or_timeout("near_goal", 60);
    _id_0DB715BCDE296BEC++;
    index++;
  }

  self.can_rocket_hover = 0;
  self.circling_target = 0;
}

create_radius_around_point(point, _id_037D6F0C041A42D0, _id_9973F603063C1FED) {
  _id_6F5F9433C7E91215 = 360 / _id_037D6F0C041A42D0;
  _id_E4B7E99A96C8829F = [];
  fwd = (1, 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 360; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + _id_6F5F9433C7E91215) {
    _id_EACD072FEDC3FFAD = fwd * _id_9973F603063C1FED;
    _id_59C8F7E2D87D3710 = (cos(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[0] - sin(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[1], sin(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[0] + cos(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[1], _id_EACD072FEDC3FFAD[2]);
    pos = point + _id_59C8F7E2D87D3710;
    position = spawnStruct();
    position.origin = pos;
    z = _id_68C2534A5EA3CD2B();
    position.origin = (position.origin[0], position.origin[1], z);
    _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = position;
  }

  return _id_E4B7E99A96C8829F;
}

heli_evade(target) {
  self notify("taking_evasive_actions");
  self endon("taking_evasive_actions");
  self endon("death");
  _id_CB920E03144E9344 = 5000;

  if(isDefined(self.evade_radius))
    _id_CB920E03144E9344 = self.evade_radius;

  if(have_custom_evade_start(self)) {
    do_custom_evade_start(self);
    chopper_height = _id_68C2534A5EA3CD2B();
    target = (self.origin[0], self.origin[1], chopper_height);
  }

  points = create_radius_around_point(target, 8, _id_CB920E03144E9344);
  _id_2F05FDC372F83530 = 0;
  start_point = points[0];
  self cleargoalyaw();
  self cleartargetyaw();
  self clearlookatent();

  foreach(index, point in points) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, point.origin, cos(25))) {
      start_point = point;
      _id_2F05FDC372F83530 = index;
      break;
    }
  }

  self setvehgoalpos(points[_id_2F05FDC372F83530].origin, 0);
  _id_31B102D6A07A30A9 = 1500;
  _id_31B102D6A07A30A9 = _id_31B102D6A07A30A9 * (_id_CB920E03144E9344 / 5000);
  _id_E4CF8DCD09CD238D = 100;
  _id_E4CF8DCD09CD238D = _id_E4CF8DCD09CD238D * (_id_CB920E03144E9344 / 5000);
  self setneargoalnotifydist(1500);
  self vehicle_setspeed(100, 50, 50);
  _id_0DB715BCDE296BEC = 0;
  index = _id_2F05FDC372F83530 + 1;
  _id_392FFC940F74DEB1 = randomint(4);

  while(_id_0DB715BCDE296BEC < points.size - 1) {
    if(index >= points.size)
      index = 0;

    self setvehgoalpos(points[index].origin, 0);
    scripts\engine\utility::waittill_notify_or_timeout("near_goal", 15);
    _id_0DB715BCDE296BEC++;
    index++;

    if(_id_0DB715BCDE296BEC == _id_392FFC940F74DEB1) {
      break;
    }
  }

  self notify("evasive_action_done");
}

do_custom_evade_start(heli) {
  _id_679126DD7A6B091B = undefined;
  _id_962B53768CC00622 = get_evade_start_structs_in_front(heli);

  if(_id_962B53768CC00622.size > 0)
    _id_679126DD7A6B091B = scripts\engine\utility::getclosest(heli.origin, _id_962B53768CC00622);
  else
    _id_679126DD7A6B091B = scripts\engine\utility::getclosest(heli.origin, scripts\engine\utility::getStructArray(heli.evade_start_targetname, "targetname"));

  heli setneargoalnotifydist(250);
  heli vehicle_setspeed(100, 50, 50);
  heli setvehgoalpos(_id_679126DD7A6B091B.origin, 0);
  heli scripts\engine\utility::waittill_notify_or_timeout("near_goal", 15);
}

have_custom_evade_start(heli) {
  if(!isDefined(heli.evade_start_targetname))
    return 0;

  _id_2F41E1143965AFB8 = scripts\engine\utility::getStructArray(heli.evade_start_targetname, "targetname");

  if(_id_2F41E1143965AFB8.size == 0)
    return 0;

  return 1;
}

get_evade_start_structs_in_front(heli) {
  results = [];
  _id_2F41E1143965AFB8 = scripts\engine\utility::getStructArray(heli.evade_start_targetname, "targetname");
  _id_DBE327EBE587CF07 = anglesToForward(heli.angles);

  foreach(_id_679126DD7A6B091B in _id_2F41E1143965AFB8) {
    _id_04E20552F0E10666 = vectorNormalize(_id_679126DD7A6B091B.origin - heli.origin);

    if(vectordot(_id_04E20552F0E10666, _id_DBE327EBE587CF07) > 0)
      results[results.size] = _id_679126DD7A6B091B;
  }

  return results;
}

setup_pilot(_id_EC2E74A36772E6A1, _id_6093339B5F662BF8, _id_0AD670034E262DEE, _id_F4F7CEB1B8D0BB38) {
  _id_F204DACE25365C76 = "tag_pilot";

  if(isDefined(_id_6093339B5F662BF8))
    _id_F204DACE25365C76 = _id_6093339B5F662BF8;

  if(!self tagexists(_id_F204DACE25365C76) && self tagexists("tag_pilot1"))
    _id_F204DACE25365C76 = "tag_pilot1";

  if(!self tagexists(_id_F204DACE25365C76)) {
    return;
  }
  _id_535116D8E57C6F31 = (0, 0, 0);

  if(isDefined(_id_0AD670034E262DEE))
    _id_535116D8E57C6F31 = _id_0AD670034E262DEE;

  _id_7595128B0DFBCB5B = (0, 0, 0);

  if(isDefined(_id_F4F7CEB1B8D0BB38))
    _id_7595128B0DFBCB5B = _id_F4F7CEB1B8D0BB38;

  pilot = spawn("script_model", self gettagorigin(_id_F204DACE25365C76));
  pilot setModel("aq_pilot_fullbody_1");
  pilot linkTo(self, _id_F204DACE25365C76, _id_535116D8E57C6F31, _id_7595128B0DFBCB5B);
  pilot scriptmodelplayanim("vh_mindia8_pilot_idle");
  self.pilot = pilot;

  if(istrue(_id_EC2E74A36772E6A1))
    thread heli_damagemonitor();

  return pilot;
}

heli_damagemonitor(_id_227A4202BBFA2F79, starting_health, _id_4B35C4051D5DDC1D) {
  self endon("death");
  _id_8DFD4474EF371775 = 0;
  self.health = 1000000;
  self.custom_damage_handler = 1;

  if(!isDefined(starting_health))
    starting_health = 2500;

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, dmgpoint, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.health = 1000000;

    if(isDefined(self._id_2C72DD1407C28DE0) && isDefined(objweapon) && isDefined(objweapon.classname) && objweapon.classname == "rocketlauncher") {
      continue;
    }
    if(isDefined(attacker) && attacker == self) {
      continue;
    }
    if(isDefined(inflictor) && isDefined(inflictor.owner) && inflictor.owner == self) {
      continue;
    }
    if(isDefined(attacker) && isDefined(self.minigun) && attacker == self.minigun) {
      continue;
    }
    if(isDefined(attacker) && isDefined(attacker.owner) && attacker.owner scripts\cp\utility::is_valid_player())
      attacker = attacker.owner;

    if(is_snipe_kill(attacker, dmgpoint, objweapon)) {
      _id_8DFD4474EF371775++;

      if(_id_8DFD4474EF371775 == 1) {
        attacker thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_F88A0D21A577AA90");
        attacker _id_3BCAA2CBAF54ABDD::give_player_currency(500, "large");
        thread do_heli_crash(attacker);
        return;
      }

      attacker.lasthitmarkertime = undefined;
      attacker _id_354C862768CFE202::updatedamagefeedback("hitvehcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      attacker.lasthitmarkertime = undefined;
      attacker _id_354C862768CFE202::updatedamagefeedback("hitvehstandard");
    } else {
      attacker.lasthitmarkertime = undefined;
      attacker _id_354C862768CFE202::updatedamagefeedback("hitvehcritical");

      if(isDefined(objweapon) && isDefined(objweapon.basename)) {
        switch (objweapon.basename) {
          case "iw8_thermite_mp":
            break;
          case "emp_drone_player_mp":
            amount = 1400;
            break;
          default:
            break;
        }
      } else if(amount < 700)
        amount = 700;

      if(isDefined(_id_227A4202BBFA2F79) && scripts\engine\utility::flag_exist(_id_227A4202BBFA2F79) && !scripts\engine\utility::flag(_id_227A4202BBFA2F79))
        scripts\engine\utility::flag_set(_id_227A4202BBFA2F79);
      else if(!istrue(self._id_4B048EED990A0102)) {
        if(!istrue(self.needs_to_evade))
          self.needs_to_evade = 1;

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      switch (objweapon.basename) {
        case "cruise_proj_mp":
          amount = self.health_remaining;
          break;
        case "iw8_la_gromeo_mp":
        case "iw9_la_gromeo_mp":
          amount = self.health_remaining;
          break;
      }
    }

    if(self.health_remaining <= starting_health * 0.75) {
      if(isDefined(_id_227A4202BBFA2F79) && scripts\engine\utility::flag_exist(_id_227A4202BBFA2F79) && !scripts\engine\utility::flag(_id_227A4202BBFA2F79))
        scripts\engine\utility::flag_set(_id_227A4202BBFA2F79);
    }

    if(scripts\engine\utility::isbulletdamage(meansofdeath)) {
      amount = min(15, amount);

      if(isDefined(_id_4B35C4051D5DDC1D))
        amount = _id_4B35C4051D5DDC1D;
    }

    self.health_remaining = self.health_remaining - amount;

    if(self.health_remaining <= starting_health * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["aerial_explosion"], self.origin);
      self setscriptablepartstate("body_damage_heavy", "on");
      self.deathfx = 1;
    } else if(self.health_remaining <= starting_health * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("body_damage_medium", "on");
      playFX(level._effect["aerial_explosion"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= starting_health * 0.75 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("body_damage_light", "on");
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon))
        deleteheadicon(self.headicon);

      level.attack_heli = undefined;
      self.headicon = undefined;

      if(isDefined(attacker) && isPlayer(attacker)) {
        attacker thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_F88A0D21A577AA90");
        attacker _id_3BCAA2CBAF54ABDD::give_player_currency(500, "large");
      }

      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      attacker _id_354C862768CFE202::updatedamagefeedback("hitvehcritical", 1);
      level notify("heli_down", self, attacker);
      playFX(level._effect["vfx_blima_explosion"], self.origin);

      if(istrue(self.nocrash))
        thread mid_air_explode(attacker);
      else
        thread do_heli_crash(attacker);

      return;
    } else if(isDefined(attacker) && isPlayer(attacker) && !istrue(self._id_1F6F35745B7F63FE))
      attacker _id_3BCAA2CBAF54ABDD::give_player_currency(10, "large");
  }
}

do_heli_crash(attacker) {
  if(isDefined(self._id_78DA61277C9DEE0A)) {
    self[[self._id_78DA61277C9DEE0A]](attacker);
    return;
  }

  self notify("crashing");

  if(isDefined(self.headicon)) {
    deleteheadicon(self.headicon);
    self.headicon = undefined;
  }

  self.crash_speed = 150;
  thread crash_deathfx();

  if(istrue(self._id_5ABE2C141F995FB2)) {
    position = anglestoright(self.angles) * randomintrange(-500, 500);
    groundpos = getgroundposition(self.origin + position, 128);
    pos = spawnStruct();
    pos.origin = groundpos;
    pos.angles = (0, 0, 0);
    level.helicopter_crash_locations[level.helicopter_crash_locations.size] = pos;
  }

  self notify("death", attacker, "MOD_EXPLOSIVE", undefined, self.origin);
}

mid_air_explode(attacker) {
  playFX(level._effect["helidown_rpghit"], self.origin);

  if(isDefined(self.pilot))
    self.pilot delete();

  self delete();
}

crash_deathfx(_id_2910A48F23770A55) {
  _id_6BF9171C6C8FF4DB = self.origin;

  if(!istrue(_id_2910A48F23770A55))
    self waittill("vehicle_deathComplete", _id_6BF9171C6C8FF4DB);

  playFX(level._effect["vfx_blima_explosion"], _id_6BF9171C6C8FF4DB + (0, 0, -100));
  playsoundatpos(_id_6BF9171C6C8FF4DB, "cp_br_syrk_chopper_crash");

  if(isDefined(self))
    self stoploopsound();

  wait 0.15;
  playFX(level._effect["vfx_blima_explosion"], _id_6BF9171C6C8FF4DB + (0, 0, -100));
  earthquake(0.45, 3, _id_6BF9171C6C8FF4DB + (0, 0, -100), 1024);
  radiusdamage(_id_6BF9171C6C8FF4DB + (0, 0, -100), 1024, 500, 50);

  if(isDefined(self)) {
    if(isDefined(self.pilot))
      self.pilot delete();

    self delete();
  }
}

is_snipe_kill(attacker, dmgpoint, objweapon) {
  _id_8407DBB0B29C1AE1 = isDefined(objweapon) && isDefined(objweapon.classname) && objweapon.classname == "sniper";

  if(!ispointnearpilot(self, dmgpoint) || !_id_8407DBB0B29C1AE1)
    return 0;

  return 1;
}

ispointnearpilot(heli, dmgpoint) {
  fwd = anglesToForward(self.angles);
  left = anglestoleft(self.angles);
  point1 = self.origin + fwd * 133 + (0, 0, -70);
  _id_BF69DB3C5A539FAD = self.origin + fwd * 112 + left * 17 + (0, 0, -70);
  _id_BF69DA3C5A539D7A = self.origin + fwd * 112 + (0, 0, -50);

  if(distance(dmgpoint, point1) <= 20)
    return 1;
  else if(distance(dmgpoint, _id_BF69DB3C5A539FAD) <= 20)
    return 1;
  else if(distance(dmgpoint, _id_BF69DA3C5A539D7A) <= 20)
    return 1;
  else
    return 0;
}

_id_68C2534A5EA3CD2B(target_ent) {
  _id_FE6F01B34661F92A = (0, 0, 1000);

  if(isDefined(self._id_6F81C60BA2B5B081))
    _id_FE6F01B34661F92A = self._id_6F81C60BA2B5B081;

  if(isDefined(self.chopper_height))
    chopper_height = self.chopper_height;

  if(isDefined(target_ent))
    chopper_height = getgroundposition(target_ent.origin + (0, 0, 10), 4) + _id_FE6F01B34661F92A;
  else
    chopper_height = getgroundposition(self.origin, 128, 10000, 2000) + (0, 0, 1000);

  if(isvector(chopper_height))
    return chopper_height[2];
  else
    return chopper_height;
}

_id_D025DD1F241613D6(heli) {
  if(!isDefined(level.special_lockon_target_list))
    level.special_lockon_target_list = [];

  level.special_lockon_target_list[level.special_lockon_target_list.size] = heli;
}

_id_01F281293E100467(heli) {
  if(!isDefined(level.killstreak_additional_targets))
    level.killstreak_additional_targets = [];

  level.killstreak_additional_targets[level.killstreak_additional_targets.size] = heli;
}

_id_29D0C931FF7731CD(heli) {
  position = anglestoright(heli.angles) * randomintrange(-500, 500);
  groundpos = getgroundposition(heli.origin + position + (0, 0, -100), 128);
  pos = spawnStruct();
  pos.origin = groundpos;
  pos.angles = (0, 0, 0);
  return pos;
}

_id_B7E4041A3C02D74A() {
  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      if(isDefined(rider._blackboard) && isDefined(rider._blackboard.chosenvehicleanimpos) && istrue(rider._blackboard._id_41C9F8C7891F19DA)) {
        _id_ADF3664B12362142 = 500.0;
        velocity = self vehicle_getvelocity();
        rider.do_immediate_ragdoll = 1;
        rider.ragdollhitloc = "torso_lower";
        rider.ragdollimpactvector = (rider.origin - self.origin) * _id_ADF3664B12362142 + velocity;
        rider._blackboard._id_80912EC8ADE08716 = 1;
      }

      rider kill();
    }
  }

  thread crash_deathfx(1);
}