/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_678adbed602da5eb.gsc
***********************************************/

_id_BCE89A6DE8A052AF() {
  if(!isDefined(level.turretsettings))
    level.turretsettings = [];

  if(isDefined(level.turretsettings["glTurret"])) {
    return;
  }
  level.turretsettings["glTurret"] = spawnStruct();
  level.turretsettings["glTurret"].health = 99999999;
  level.turretsettings["glTurret"].maxhealth = 99999999;
  level.turretsettings["glTurret"].maxrange = 156250000;
  level.turretsettings["glTurret"]._id_5D186451F21D7020 = 1960000;
  level.turretsettings["glTurret"]._id_947AF351CE904AA5 = 7562500;
  level.turretsettings["glTurret"].sentrymodeon = "manual";
  level.turretsettings["glTurret"].sentrymodeoff = "sentry_offline";
  level.turretsettings["glTurret"].weaponinfo = "sentry_turret_incursion";
  level.turretsettings["glTurret"].iskillstreak = 1;
  level.turretsettings["glTurret"]._id_F0FDB1FE0AC56838 = 4;
  level.turretsettings["glTurret"]._id_F120C7FE0AEBE052 = 6;
  level.turretsettings["glTurret"]._id_5CD643D2B6BE6DD0 = 5;
  level.turretsettings["glTurret"]._id_5CB339D2B698101A = 5.5;
  level.turretsettings["glTurret"]._id_1CA111FF86819C24 = 0.15;
  level.turretsettings["glTurret"]._id_B5BD9EDCB0BF65F1 = 1500;
  level.turretsettings["glTurret"]._id_7E1467DC63368749 = ::_id_3BF61AB8F285C8FB;
}

_id_9273BA79878B2221(struct, _id_076BA9E808A42F81) {
  config = level.turretsettings["glTurret"];
  turret = spawnturret("misc_turret", struct.origin, level.turretsettings["glTurret"].weaponinfo);
  turret.team = "axis";

  if(!isDefined(struct.angles))
    struct.angles = (0, 0, 0);

  turret.angles = struct.angles;
  turret.health = config.maxhealth;
  turret.maxhealth = config.maxhealth;
  turret.sentrytype = "glTurret";
  turret.turrettype = "glTurret";
  turret.maxrange = level.turretsettings["glTurret"].maxrange;
  turret._id_5D186451F21D7020 = level.turretsettings["glTurret"]._id_5D186451F21D7020;
  turret._id_947AF351CE904AA5 = level.turretsettings["glTurret"]._id_947AF351CE904AA5;
  turret.owner = turret;

  if(isDefined(struct.radius)) {
    _id_CDC5DD6C28C9709D = struct.radius * struct.radius;
    turret.maxrange = int(_id_CDC5DD6C28C9709D - _id_CDC5DD6C28C9709D * 0.1);
    turret._id_947AF351CE904AA5 = int(_id_CDC5DD6C28C9709D);
  }

  if(!isDefined(_id_076BA9E808A42F81))
    _id_076BA9E808A42F81 = "weapon_wm_mg_mobile_turret";

  turret setModel(_id_076BA9E808A42F81);
  turret setturretteam("axis");
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret maketurretinoperable();
  turret setleftarc(360);
  turret setrightarc(360);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(0.6, "pitch");
  turret setconvergencetime(0.6, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setdefaultdroppitch(-89.0);
  turret solid();
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentryturret_empcleared);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  struct.turret = turret;
  turret.spawner = struct;
  wait 1;
  turret._id_B81564300A56532B = level.turretsettings[turret.turrettype].sentrymodeon;
  turret setmode(level.turretsettings[turret.turrettype].sentrymodeon);
  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret sentryturret_empupdate();
  turret thread _id_009CAC9B6D1A6353();
  turret._id_B5BD9EDCB0BF65F1 = 2000;
  turret.covernode = spawncovernode(getclosestpointonnavmesh(turret.origin - anglesToForward(turret.angles) * 64), turret.angles, "Exposed", 0, undefined);
  return turret;
}

_id_534445B413445ADE() {
  level._effect["gl_muzzleflash"] = loadfx("vfx/iw9/level/cp_mission_esc/vfx_cp_mission_esc_grenade_launcher_muzzflash_w.vfx");
}

_id_F3A3BBA54AA3A0A2(_id_2C5E84C1F846661B) {
  level endon("game_ended");
  self endon("guy_off_turret");
  _id_2C5E84C1F846661B waittill("death");
  _id_A08BB096BB00739A();
  self notify("guy_off_turret");
}

sentryturret_empstarted(data) {
  sentryturret_empupdate();
}

sentryturret_empcleared(_id_B3990D56E2779F79) {
  if(_id_B3990D56E2779F79) {
    return;
  }
  sentryturret_empupdate();
}

sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.turretsettings[self.turrettype].sentrymodeoff);
    self laseroff();
  } else {
    self turretfireenable();
    self setmode(level.turretsettings[self.turrettype].sentrymodeon);
  }
}

_id_A08BB096BB00739A() {
  self turretfiredisable();
  self setmode(level.turretsettings[self.turrettype].sentrymodeoff);
  self laseroff();
  self cleartargetentity();
}

_id_009CAC9B6D1A6353() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  self._id_94B870B278BACA37 = 10000;
  self._id_64927A06119069F8 = 1000;
  self.attractor = _func_46E031C1F4073D7E(self.origin + (0, 0, 64), self._id_94B870B278BACA37, self._id_64927A06119069F8);

  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon, origin, angles, normal, einflictor, eventid);

    if(!isDefined(eattacker) || !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }
    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      if(issubstr(objweapon.basename, "emp_drone")) {} else if(issubstr(objweapon.basename, "spotter_scope_mp"))
        continue;
    }

    if(isDefined(eattacker) && isDefined(eattacker.turrettype) && eattacker.turrettype == "glTurret") {
      continue;
    }
    _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(smeansofdeath) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && vpoint != "none";
    _id_93DDA441E5C43170 = isexplosivedamagemod(smeansofdeath);
    _id_379485F96865DB6D = isDefined(eattacker) && isPlayer(eattacker);
    _id_7543D4FE49C53684 = isDefined(eattacker.owner) && isPlayer(eattacker.owner);
    _id_B4A897B1262EA17C = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
    _id_F3B5D704CA2A9B3D = _id_B4A897B1262EA17C && smeansofdeath == "MOD_CRUSH";
    _id_23E8CEAC79674780 = 0;

    if(_id_A3192D2F80ED4FF8) {
      if(_id_93DDA441E5C43170)
        eattacker thread _id_354C862768CFE202::updatedamagefeedback("hitblastshield");
      else
        eattacker thread _id_354C862768CFE202::updatedamagefeedback("hitblastshield");

      _id_23E8CEAC79674780 = 1;
      level notify("hitblastshield", eattacker);
    }

    if(_id_379485F96865DB6D || _id_7543D4FE49C53684 || _id_F3B5D704CA2A9B3D) {
      if(_id_7543D4FE49C53684)
        eattacker = eattacker.owner;

      if(isDefined(objweapon))
        _id_6F1E07CE9FF97D5F::addattacker(self, eattacker, einflictor, objweapon, idamage, vpoint, vdir, undefined, undefined, smeansofdeath);
    }

    if(_id_23E8CEAC79674780) {
      self.health = self.health + idamage;
      continue;
    }

    _id_354C862768CFE202::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, _id_920FF4456CE9A2FC, undefined, self);
  }
}

_id_4D6347F6777BF5D8(_id_AA440CDD07894C27) {
  new_target_dist = self.maxrange;

  if(isDefined(self.new_target_dist))
    new_target_dist = self.new_target_dist;

  if(!isDefined(_id_AA440CDD07894C27))
    _id_AA440CDD07894C27 = self.origin;

  _id_BDD628D52F94BAA9 = new_target_dist;
  _id_E031661B7146A294 = [];

  foreach(player in level.players) {
    if(!player scripts\cp\utility::is_valid_player() || distance2dsquared(_id_AA440CDD07894C27, player.origin) > _id_BDD628D52F94BAA9) {
      continue;
    }
    if(!_id_9250D1F0D4FDCA21(player)) {
      continue;
    }
    _id_E031661B7146A294[_id_E031661B7146A294.size] = player;
  }

  if(!_id_E031661B7146A294.size)
    return undefined;

  _id_E031661B7146A294 = sortbydistance(_id_E031661B7146A294, self.origin);
  _id_E031661B7146A294 = scripts\engine\utility::array_reverse(_id_E031661B7146A294);

  foreach(player in _id_E031661B7146A294) {
    if(isDefined(player.vehicle))
      return player;
  }

  return _id_E031661B7146A294[0];
}

_id_9250D1F0D4FDCA21(target, offset) {
  _id_5D186451F21D7020 = getdvarint("dvar_BEF0C6BF00094960", sqrt(self._id_5D186451F21D7020));
  maxrange = getdvarint("dvar_976BDE52F2AA5AA2", sqrt(self.maxrange));
  _id_5A19DAFA23E95368 = squared(_id_5D186451F21D7020);
  maxrangesq = squared(maxrange);

  if(!target scripts\cp\utility::is_valid_player() || distance2dsquared(self.origin, target.origin) > maxrangesq || distance2dsquared(self.origin, target.origin) < _id_5A19DAFA23E95368)
    return 0;

  if(!isDefined(offset))
    offset = (0, 0, 200);

  _id_D04BB1DC67A18E1B = self.origin + (0, 0, 250);

  if(!isDefined(target.vehicle)) {
    contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0);
    _id_D895C679F6A927E5 = [target gettagorigin("tag_origin") + (0, 0, 10), target gettagorigin("j_head") + (0, 0, 25)];
  } else {
    contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0);
    _id_D895C679F6A927E5 = [target.vehicle gettagorigin("tag_origin") + (0, 0, 100)];
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(_id_D04BB1DC67A18E1B + offset, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], self, contents)) {
      trace = scripts\engine\trace::ray_trace(_id_D04BB1DC67A18E1B + offset, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], self, contents);
      continue;
    }

    return 1;
  }

  return 0;
}

_id_781DDFF902DD09AD() {
  self notify("stop_shooting");
}

sentry_handledeath() {
  self waittill("death");
  level.killstreak_additional_targets = scripts\engine\utility::array_remove(level.killstreak_additional_targets, self);
  level._id_CEEF08CFB883A461 = scripts\engine\utility::array_remove(level._id_CEEF08CFB883A461, self);

  if(!isDefined(self)) {
    return;
  }
  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");

  if(isDefined(self.attackerdata)) {
    foreach(player in level.players) {
      _id_54351D786449EE9E = 0;

      if(isDefined(self.attackerdata[player.guid]) && isDefined(self.attackerdata[player.guid].damage)) {
        if(self.attackerdata[player.guid].damage >= self.maxhealth * 0.1)
          _id_54351D786449EE9E = 1;

        if(self.attackerdata[player.guid].damage >= self.maxhealth * 0.2)
          _id_54351D786449EE9E = 2;

        if(_id_54351D786449EE9E >= 1)
          player thread _id_187A04151C40FB72::giverankxp("stat_749EA84D7C098477", _id_187A04151C40FB72::getscoreinfovalue("stat_749EA84D7C098477"));
      }
    }
  }

  level notify("incursion_sentry_destroyed", self._id_0E86180E07331051);

  if(isDefined(self))
    thread sentry_deleteturret();
}

sentry_deleteturret() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");
  wait 1.5;
  playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_aim");
  playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  self playSound("sentry_explode_smoke");

  if(isDefined(self.attractor))
    missile_deleteattractor(self.attractor);

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);

    self.minimapid = undefined;
  }

  wait 0.1;
  self notify("deleting");

  if(isDefined(self))
    self delete();
}

_id_3BF61AB8F285C8FB() {
  self endon("death");
  level endon("game_ended");
  self endon("guy_off_turret");
  self notify("turretLogic");
  self endon("turretLogic");

  for(;;) {
    _id_EC80496532425417 = _id_4D6347F6777BF5D8();

    if(!isDefined(_id_EC80496532425417)) {
      _id_781DDFF902DD09AD();
      wait 1;
      continue;
    }

    self settargetentity(_id_EC80496532425417);
    _id_BA7DF6EEACB835F6(_id_EC80496532425417);
  }
}

_id_EF2E5ED13E5A81D0(_id_EC80496532425417) {
  self endon("death");
  level endon("game_ended");
  self endon("guy_off_turret");

  if(isDefined(self._id_CDE5919EB9CA1669) && self._id_CDE5919EB9CA1669 == _id_EC80496532425417) {
    return;
  }
  if(!isDefined(self.targetent)) {
    self.targetent = spawn("script_model", self.origin);
    self.targetent setModel("tag_origin");
    self settargetentity(self.targetent);
  }

  while(isDefined(_id_EC80496532425417)) {
    _id_9C9514D2704DFAF2 = anglesToForward(_id_EC80496532425417.origin - self.origin) * 400;
    endpoint = self.origin + (0, _id_9C9514D2704DFAF2[1], 100);
    self.targetent moveTo(endpoint, 0.2);
    wait 0.2;
  }
}

_id_BA7DF6EEACB835F6(_id_EC80496532425417) {
  _id_A5218803B3C3BE55 = level.turretsettings["glTurret"];
  _id_F0FDB1FE0AC56838 = _id_A5218803B3C3BE55._id_F0FDB1FE0AC56838;
  _id_F120C7FE0AEBE052 = _id_A5218803B3C3BE55._id_F120C7FE0AEBE052;
  _id_5CD643D2B6BE6DD0 = _id_A5218803B3C3BE55._id_5CD643D2B6BE6DD0;
  _id_5CB339D2B698101A = _id_A5218803B3C3BE55._id_5CB339D2B698101A;
  _id_1CA111FF86819C24 = _id_A5218803B3C3BE55._id_1CA111FF86819C24;
  self._id_B5BD9EDCB0BF65F1 = _id_A5218803B3C3BE55._id_B5BD9EDCB0BF65F1;

  if(isDefined(self._id_2C5E84C1F846661B))
    self._id_2C5E84C1F846661B endon("death");

  _id_89F949A75D92E1A4 = randomintrange(_id_F0FDB1FE0AC56838, _id_F120C7FE0AEBE052);
  _id_58E50AEE46852766 = 0;
  waittime = getdvarint("dvar_96B43E3289B1CC41", 1);
  wait(waittime);
  _id_86DFAE2BAC2E7DA6 = 0;

  while(_id_58E50AEE46852766 < _id_89F949A75D92E1A4) {
    _id_3C891A0EE2552CDD = 0;

    if(_id_58E50AEE46852766 == 0)
      _id_3C891A0EE2552CDD = 1;

    targetent = _id_EC80496532425417;

    if(!isDefined(_id_EC80496532425417) || !isDefined(_id_EC80496532425417.classname))
      targetent = undefined;

    if(!isPlayer(targetent) && targetent.classname == "script_model")
      targetent = undefined;

    if(isDefined(targetent) && isDefined(targetent.vehicle))
      targetent = targetent.vehicle;

    _id_45700E2FD0A097B2(_id_3C891A0EE2552CDD, targetent, self._id_B5BD9EDCB0BF65F1);

    if(!istrue(_id_86DFAE2BAC2E7DA6)) {
      level notify("launcher_fired");
      _id_86DFAE2BAC2E7DA6 = 1;
    }

    wait(_id_1CA111FF86819C24);
    _id_58E50AEE46852766++;

    if(!isDefined(self._id_2C5E84C1F846661B))
      return;
  }

  wait(randomfloatrange(_id_5CD643D2B6BE6DD0, _id_5CB339D2B698101A));
}

_id_24BC18F46B5C19E7(start, end) {
  speed = self._id_B5BD9EDCB0BF65F1;
  time = distance(start, end) / speed;
  playFXOnTag(level._effect["gl_muzzleflash"], self, "tag_flash");
  _id_D42E799E256E8C7A = magicbullet("iw8_la_mike32_fakefire", start, end);
  _id_D42E799E256E8C7A._id_835D1CD2262DAD74 = 1;
  grenade = spawn("script_model", start);
  grenade setModel("mike32_projectile_fake");
  grenade.team = "axis";
  _id_5464F27F04BB1114(grenade, start, end, time);
  grenade _id_168B58562A9B8A73(end);
  grenade delete();
}

_id_5464F27F04BB1114(model, start, end, time) {
  model endon("death");
  _id_2555CAFD1E701BA5 = 150;
  _id_9D9BCB154A71E0E6 = 1 / (time / 0.05);
  frac = 0;
  _id_E1EC1ADE6AFDBB7A = undefined;

  while(frac < 1) {
    if(isDefined(_id_E1EC1ADE6AFDBB7A)) {
      if(frac + _id_9D9BCB154A71E0E6 < 1) {
        model.origin = _id_E1EC1ADE6AFDBB7A;
        model notify("early_impact");
        return;
      }
    }

    model.origin = scripts\engine\math::get_point_on_parabola(start, end, _id_2555CAFD1E701BA5, frac);
    _id_630782B398951805 = frac + _id_9D9BCB154A71E0E6;
    _id_BE27B40782202CF5 = scripts\engine\math::get_point_on_parabola(start, end, _id_2555CAFD1E701BA5, _id_630782B398951805);
    _id_E1EC1ADE6AFDBB7A = check_for_early_impact(model, _id_BE27B40782202CF5);
    frac = frac + _id_9D9BCB154A71E0E6;
    waitframe();
  }

  model.origin = end;
}

check_for_early_impact(_id_92753DA39919F200, _id_04830B28D31D6219) {
  _id_1BFA180C6FDD09DD = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  _id_214D77BB9D513C28 = scripts\engine\trace::ray_trace(_id_92753DA39919F200.origin, _id_04830B28D31D6219, _id_92753DA39919F200, _id_1BFA180C6FDD09DD);

  if(_id_214D77BB9D513C28["hittype"] != "hittype_none")
    return _id_04830B28D31D6219;
}

_id_168B58562A9B8A73(end) {
  self._id_CEFCAFDECC575902 = 1;
  self setscriptablepartstate("default", "explode");
  wait 3;
}

_id_4E6066E802D5C49E() {
  _id_31DDD6E67EA2E527 = 1048576;

  if(getdvarint("dvar_BEC519CF8B1E3C68", 0) > 0)
    _id_31DDD6E67EA2E527 = getdvarint("dvar_BEC519CF8B1E3C68", 0);

  _id_EB7F0D4243AC35BC = 0;

  foreach(player in level.players) {
    if(abs(self.origin[2] - player.origin[2]) > 64) {
      continue;
    }
    if(distancesquared(player.origin, self.origin) < _id_31DDD6E67EA2E527)
      _id_EB7F0D4243AC35BC = 1;
  }

  return _id_EB7F0D4243AC35BC;
}

_id_1030F50AC202D018() {
  if(istrue(self._id_416B5861A117F5D4))
    return 0;

  _id_1433F38A8E5D0286 = 1;

  foreach(player in level.players) {
    if(abs(self.origin[2] - player.origin[2]) < 64)
      _id_1433F38A8E5D0286 = 0;

    if(distancesquared(player.origin, self.origin) < 1048576)
      _id_1433F38A8E5D0286 = 0;
  }

  return _id_1433F38A8E5D0286;
}

_id_8C4F2C8B34AB0EB5(turret) {
  self._id_416B5861A117F5D4 = undefined;
  turret _id_781DDFF902DD09AD();
  turret notify("guy_off_turret");
  turret _id_A08BB096BB00739A();
  turret._id_2C5E84C1F846661B = undefined;
  turret scripts\common\ai::ai_dismount_turret(self);
  self._id_4979CA90A2818DA0 = 0;
  self._id_FE3B2F26B45598BA = undefined;
  self.turret = undefined;
}

_id_C2A191D39BC83A61(sentry) {
  self._id_4979CA90A2818DA0 = 1;
  self._id_416B5861A117F5D4 = 1;
  self.goalradius = 8;
  self setgoalpos(sentry gettagorigin("tag_gunner"));
  self waittill("goal");
  self.goalradius = 1024;
  sentry._id_2C5E84C1F846661B = self;
  self.turret = sentry;
  sentry scripts\common\ai::ai_operate_turret(self, sentry);
  sentry thread[[level.turretsettings[sentry.turrettype]._id_7E1467DC63368749]]();
  sentry thread _id_F3A3BBA54AA3A0A2(self);
  sentry notify("guy_on_turret");
}

_id_200CFD3D04D2510F(turret) {
  self endon("death");

  while(!isDefined(level.players) || level.players.size < 1)
    wait 1;

  for(;;) {
    wait 0.1;

    if(_id_4E6066E802D5C49E()) {
      _id_8C4F2C8B34AB0EB5(turret);
      continue;
    }

    if(_id_1030F50AC202D018())
      _id_C2A191D39BC83A61(turret);
  }
}

_id_BA8597CB7C12D254(idamage, smeansofdeath, sweapon, partname, _id_B17964B5DA7540EA) {
  return istrue(self._id_4979CA90A2818DA0);
}

_id_45700E2FD0A097B2(_id_3C891A0EE2552CDD, target, _id_6201FB806AD1B5D7) {
  self endon("death");

  if(istrue(self._id_8EF48A17AC8ED417)) {
    _id_2469D29AACB59A4E(target);
    return;
  }

  _id_DAFD1CFDC4DA09B6 = int(_id_6201FB806AD1B5D7);
  _id_A5BB1FA786D5B61E = distance(self.origin, target.origin);
  _id_45353FC34D0B4031 = _id_A5BB1FA786D5B61E / _id_DAFD1CFDC4DA09B6;
  maxspeed = 0;

  if(!isPlayer(target)) {
    _id_A474C9C03DF90F98 = length(target vehicle_getvelocity());
    angles = target.angles;
  } else {
    _id_A474C9C03DF90F98 = length(target getvelocity());
    angles = vectortoangles(target getvelocity());
  }

  fwd = vectortoangles(target.origin - self.origin);
  start = self.origin + (0, 0, 40);

  if(self tagexists("tag_flash"))
    start = self gettagorigin("tag_flash");

  if(istrue(_id_3C891A0EE2552CDD)) {
    if(isPlayer(target))
      _id_A474C9C03DF90F98 = _id_A474C9C03DF90F98 * 2;
    else
      _id_A474C9C03DF90F98 = _id_A474C9C03DF90F98 * 1.5;
  }

  _id_48BD8D850D8A3BE6 = int(_id_A474C9C03DF90F98 * _id_45353FC34D0B4031);
  _id_DBDB6416D2651728 = getgroundposition(target.origin + anglesToForward(angles) * _id_48BD8D850D8A3BE6, 8, 1000, 1000) + (0, 0, 2);

  if(distance2dsquared(self.origin, _id_DBDB6416D2651728) < squared(2000))
    _id_DBDB6416D2651728 = getgroundposition(_id_DBDB6416D2651728 + (randomintrange(-250, 250), randomintrange(-250, 250), 0), 8, 1000, 1000) + (0, 0, 2);

  _id_8C1D7E7AE38471BD = distance(start, _id_DBDB6416D2651728);
  _id_5561E4F23C58767D = _id_8C1D7E7AE38471BD / _id_DAFD1CFDC4DA09B6;
  _id_06B54F8132C372EA = distance2dsquared(self.origin, _id_DBDB6416D2651728);

  if(isDefined(self.maxrange) && _id_06B54F8132C372EA > self.maxrange) {
    self notify("blocked");
    return;
  }

  _id_7FE710B31B2B752D = self gettagorigin("tag_flash");
  _id_7FE710B31B2B752D = _id_7FE710B31B2B752D + anglesToForward(self gettagangles("tag_flash")) * 250 + (0, 0, 150);
  trace = scripts\engine\trace::ray_trace(_id_7FE710B31B2B752D, _id_DBDB6416D2651728, [], undefined, undefined, 1, 0);

  if(_id_06B54F8132C372EA > squared(3000))
    trace["fraction"] = 1;

  if(trace["fraction"] < 1) {
    trace = scripts\engine\trace::ray_trace(_id_7FE710B31B2B752D, _id_DBDB6416D2651728 + (0, 0, 60), [], undefined, undefined, 1, 0);

    if(trace["fraction"] < 1)
      return;
  }

  if(getdvarint("dvar_2CDD5346EAC517D3", 0) > 0) {
    _id_1AAD8F38CB38F703 = int(_id_5561E4F23C58767D * 20);
    thread scripts\engine\utility::draw_angles(angles, _id_DBDB6416D2651728, (1, 1, 0), _id_1AAD8F38CB38F703 + 40, 120);
  }

  if(!scripts\engine\utility::within_fov(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), _id_DBDB6416D2651728, cos(45))) {
    self notify("blocked");
    return;
  }

  _id_DBDB6416D2651728 = getgroundposition(_id_DBDB6416D2651728 + (randomintrange(-150, 150), randomintrange(-150, 150), 0), 8, 1000, 1000) + (0, 0, 2);

  if(distancesquared(start, _id_DBDB6416D2651728) < squared(256)) {
    return;
  }
  thread _id_24BC18F46B5C19E7(start, _id_DBDB6416D2651728);
}

_id_2469D29AACB59A4E(target) {
  self endon("death");
  fwd = vectortoangles(target.origin - self.origin);
  start = self.origin + (0, 0, 40);

  if(self tagexists("tag_flash"))
    start = self gettagorigin("tag_flash");

  _id_06B54F8132C372EA = distance2dsquared(self.origin, target.origin);

  if(isDefined(self.maxrange) && _id_06B54F8132C372EA > self.maxrange) {
    self notify("blocked");
    return;
  }

  _id_DBDB6416D2651728 = target.origin + (0, 0, 60);
  _id_7FE710B31B2B752D = self gettagorigin("tag_flash") + (0, 0, 50);
  ignore = scripts\cp\cp_agent_utils::get_alive_enemies();
  ignore[ignore.size] = self;
  ignore[ignore.size] = target;
  _id_7FE710B31B2B752D = _id_7FE710B31B2B752D + anglesToForward(self gettagangles("tag_flash")) * 50;
  trace = scripts\engine\trace::ray_trace(_id_7FE710B31B2B752D, _id_DBDB6416D2651728, [self, target], undefined, undefined, 1, 0);

  if(trace["fraction"] < 1) {
    return;
  }
  if(!scripts\engine\utility::within_fov(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), _id_DBDB6416D2651728, cos(45))) {
    self notify("blocked");
    return;
  }

  if(distancesquared(start, _id_DBDB6416D2651728) < squared(256)) {
    self notify("blocked");
    return;
  }

  thread _id_24BC18F46B5C19E7(start, _id_DBDB6416D2651728);
}