/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4b02400dad63cafb.gsc
***********************************************/

setup_enemy_sentry(_id_804269875F5062F1, _id_0E86180E07331051, _id_076BA9E808A42F81) {
  sentrytype = "incursion_sentry";
  config = level.sentrysettings[sentrytype];
  turret = spawnturret("misc_turret", _id_804269875F5062F1.origin, level.sentrysettings[sentrytype].weaponinfo);
  turret.team = "axis";

  if(!isDefined(_id_804269875F5062F1.angles))
    _id_804269875F5062F1.angles = (0, 0, 0);

  turret.angles = _id_804269875F5062F1.angles;
  turret.health = config.maxhealth;
  turret.maxhealth = config.maxhealth;
  turret.sentrytype = sentrytype;
  turret.turrettype = sentrytype;
  turret._id_0E86180E07331051 = _id_0E86180E07331051;
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 2;
  turret.maxrange = level.sentrysettings[sentrytype].maxrange;
  turret._id_947AF351CE904AA5 = level.sentrysettings[sentrytype]._id_947AF351CE904AA5;
  turret.owner = turret;

  if(isDefined(_id_804269875F5062F1.radius)) {
    _id_CDC5DD6C28C9709D = _id_804269875F5062F1.radius * _id_804269875F5062F1.radius;
    turret.maxrange = int(_id_CDC5DD6C28C9709D - _id_CDC5DD6C28C9709D * 0.1);
    turret._id_947AF351CE904AA5 = int(_id_CDC5DD6C28C9709D);
  }

  if(!isDefined(_id_076BA9E808A42F81))
    _id_076BA9E808A42F81 = "";

  turret setModel(_id_076BA9E808A42F81);
  turret setturretteam("axis");
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.2);
  turret maketurretinoperable();
  turret setleftarc(180);
  turret setrightarc(180);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(0.6, "pitch");
  turret setconvergencetime(0.6, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setdefaultdroppitch(-89.0);
  turret setturretmodechangewait(1);
  turret solid();
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentryturret_empcleared);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  _id_804269875F5062F1.turret = turret;
  turret._id_779C916529C44B1A = _id_804269875F5062F1;

  if(!isDefined(level.killstreak_additional_targets))
    level.killstreak_additional_targets = [];

  level.killstreak_additional_targets = scripts\engine\utility::array_add(level.killstreak_additional_targets, turret);

  if(!isDefined(level._id_CEEF08CFB883A461))
    level._id_CEEF08CFB883A461 = [];

  level._id_CEEF08CFB883A461 = scripts\engine\utility::array_add(level._id_CEEF08CFB883A461, turret);
  wait 1;
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret sentryturret_empupdate();
  turret _id_43F24FF330813DEC();
  turret thread damage_feedback_watch();
  turret thread sentry_attacktargets();
  turret thread sentry_handledeath();

  if(turret._id_0E86180E07331051 == "airstrike")
    turret thread _id_6A1CA8DE6B373B9A();

  return turret;
}

_id_E7A64DF827074B05() {
  loadvfx();
  level.sentrysettings["incursion_sentry"] = spawnStruct();
  level.sentrysettings["incursion_sentry"].health = 999999;
  level.sentrysettings["incursion_sentry"].maxhealth = 350;
  level.sentrysettings["incursion_sentry"].burstmin = 20;
  level.sentrysettings["incursion_sentry"].burstmax = 120;
  level.sentrysettings["incursion_sentry"].pausemin = 0.15;
  level.sentrysettings["incursion_sentry"].pausemax = 0.35;
  level.sentrysettings["incursion_sentry"].maxrange = 4000000;
  level.sentrysettings["incursion_sentry"]._id_947AF351CE904AA5 = 7562500;
  level.sentrysettings["incursion_sentry"].lockstrength = 2;
  level.sentrysettings["incursion_sentry"].sentrymodeon = "manual";
  level.sentrysettings["incursion_sentry"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["incursion_sentry"].ammo = 200;
  level.sentrysettings["incursion_sentry"].timeout = 999999;
  level.sentrysettings["incursion_sentry"].spinuptime = 0.65;
  level.sentrysettings["incursion_sentry"].overheattime = 8.0;
  level.sentrysettings["incursion_sentry"].cooldowntime = 0.1;
  level.sentrysettings["incursion_sentry"].fxtime = 0.3;
  level.sentrysettings["incursion_sentry"].streakname = "sentry_gun";
  level.sentrysettings["incursion_sentry"].weaponinfo = "sentry_turret_mp";
  level.sentrysettings["incursion_sentry"].playerweaponinfo = "sentry_turret_mp";
  level.sentrysettings["incursion_sentry"].scriptable = "ks_sentry_turret_mp";
  level.sentrysettings["incursion_sentry"].modelbasecover = "killstreak_wm_mounted_turret";
  level.sentrysettings["incursion_sentry"].modelbaseground = "";
  level.sentrysettings["incursion_sentry"].modeldestroyedcover = "killstreak_wm_mounted_turret";
  level.sentrysettings["incursion_sentry"].modeldestroyedground = "";
  level.sentrysettings["incursion_sentry"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings["incursion_sentry"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["incursion_sentry"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["incursion_sentry"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["incursion_sentry"].headicon = 1;
  level.sentrysettings["incursion_sentry"].teamsplash = "used_sentry_gun";
  level.sentrysettings["incursion_sentry"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["incursion_sentry"].shouldsplash = 1;
  level.sentrysettings["incursion_sentry"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["incursion_sentry"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["incursion_sentry"].scorepopup = "destroyed_sentry";
  level.sentrysettings["incursion_sentry"].lightfxtag = "tag_fx";
  level.sentrysettings["incursion_sentry"].iskillstreak = 1;
  level.sentrysettings["incursion_sentry"].headiconoffset = (0, 0, 75);
  scripts\engine\utility::flag_init("flag_incursion_sentry_destroyed_rpg");
  scripts\engine\utility::flag_init("flag_incursion_sentry_destroyed_airstrike");
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
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
  } else {
    self turretfireenable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
  }
}

_id_A08BB096BB00739A() {
  self turretfiredisable();
  self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
  self laseroff();
}

_id_978BB8252BD3ABCD(target) {
  self turretfireenable();

  if(isDefined(target)) {
    self setmode("manual");
    target_ent = self gettargetentity();

    if(isDefined(target_ent) && target_ent == target) {
      return;
    }
    self settargetentity(target);
  } else
    self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
}

_id_43F24FF330813DEC() {
  if(!isDefined(self._id_0E86180E07331051)) {
    return;
  }
  if(self._id_0E86180E07331051 == "rpg" || self._id_0E86180E07331051 == "airstrike") {
    self.perks = [];
    self.perks[0] = "specialty_blastshield";
  }
}

enemy_sentry_debug() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  org = self.origin;
  interval = 0.05;
  _id_1AAD8F38CB38F703 = int(interval * 20);

  for(;;)
    wait(interval);
}

damage_feedback_watch() {
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

    if(isDefined(eattacker) && isDefined(eattacker.turrettype) && eattacker.turrettype == "incursion_sentry") {
      continue;
    }
    _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(smeansofdeath) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && vpoint != "none";
    _id_93DDA441E5C43170 = smeansofdeath == "MOD_EXPLOSIVE_BULLET" && (isDefined(vpoint) && vpoint == "none") || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE";
    _id_379485F96865DB6D = isDefined(eattacker) && isPlayer(eattacker);
    _id_7543D4FE49C53684 = isDefined(eattacker.owner) && isPlayer(eattacker.owner);
    _id_B4A897B1262EA17C = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
    _id_F3B5D704CA2A9B3D = _id_B4A897B1262EA17C && smeansofdeath == "MOD_CRUSH";
    _id_CC5E6F089D31A891 = _id_1B21FDF9F12EA073(einflictor);
    _id_23E8CEAC79674780 = 0;

    if(isDefined(self._id_0E86180E07331051)) {
      if(self._id_0E86180E07331051 == "rpg") {
        if(_id_A3192D2F80ED4FF8) {
          thread _id_7C45E56141D2CD55(eattacker);
          _id_23E8CEAC79674780 = 1;
        }
      } else if(self._id_0E86180E07331051 == "airstrike") {
        if(_id_A3192D2F80ED4FF8 || !istrue(_id_CC5E6F089D31A891)) {
          if(_id_93DDA441E5C43170)
            eattacker thread _id_354C862768CFE202::updatedamagefeedback("hitblastshield");
          else
            thread _id_7C45E56141D2CD55(eattacker);

          _id_23E8CEAC79674780 = 1;
        }
      }
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

_id_7C45E56141D2CD55(attacker) {
  if(isDefined(self.attackerdata)) {
    if(isDefined(self.attackerdata[attacker.guid])) {
      if(self.attackerdata[attacker.guid].hitcount > 0)
        thread _id_AF8AD708C9F347FD(attacker);
    }
  }
}

_id_AF8AD708C9F347FD(attacker) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self._id_14A53AC103E23D86))
    self._id_14A53AC103E23D86 = [];

  if(!isDefined(self._id_14A53AC103E23D86[attacker.guid]))
    self._id_14A53AC103E23D86[attacker.guid] = spawnStruct();

  if(!istrue(self._id_14A53AC103E23D86[attacker.guid]._id_694B2BA7C04CDA8B)) {
    self._id_14A53AC103E23D86[attacker.guid]._id_694B2BA7C04CDA8B = 1;
    attacker thread scripts\cp\cp_hud_message::tutorialprint(&"CP_INCURSION/BULLET_IMMUNITY", 3);
    wait 3;
    self._id_14A53AC103E23D86[attacker.guid]._id_694B2BA7C04CDA8B = undefined;
  }
}

_id_1B21FDF9F12EA073(einflictor) {
  return isDefined(einflictor) && isDefined(einflictor.weapon_name) && einflictor.weapon_name == "artillery_mp";
}

sentry_attacktargets() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread _id_BB1DD2CC161F6949();
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_any_3("turretstatechange", "cooled", "enter_idle");

    if(self isfiringturret()) {
      if(self.state != "idle")
        thread sentry_burstfirestart();

      continue;
    }

    self notify("lose_target");
    thread _id_83E30545DCCA591A();
  }
}

_id_30B63FB2CBF3DEC7() {
  self.state = "lost_LOS";

  if(!isDefined(self.targetent)) {
    loc = self gettagorigin("bi_base") + anglesToForward(self gettagangles("bi_base")) * 300;
    self.targetent = spawn("script_model", loc);
    self.targetent setModel("tag_origin");
  }

  loc = self gettagorigin("tag_laser") + anglesToForward(self gettagangles("tag_laser")) * 3000;
  self.targetent.origin = loc;
  self.targetent dontinterpolate();
  self settargetentity(self.targetent);
}

_id_42929A0D4354A323() {
  self endon("death");
  self endon("exit_idle");

  if(isDefined(self.state) && self.state == "idle") {
    return;
  }
  self stopfiring();
  self.state = "idle";
  self notify("enter_idle");
  self notify("stop_shooting");

  if(!isDefined(self.targetent)) {
    self.targetent = spawn("script_model", self.origin);
    self.targetent setModel("tag_origin");
  }

  loc = self gettagorigin("tag_laser") + anglesToForward(self gettagangles("tag_laser")) * 3000;
  self.targetent.origin = loc;
  self.targetent dontinterpolate();
  self settargetentity(self.targetent);

  if(isDefined(self._id_71F08AA4E6A5186E)) {
    self[[self._id_71F08AA4E6A5186E]]();
    return;
  }

  _id_1E536FC02CE7881D = self._id_779C916529C44B1A.origin;
  _id_4D16D428538FF673 = self._id_779C916529C44B1A.angles;
  _id_878BAE61ACA86FC5 = anglesToForward(_id_4D16D428538FF673);
  _id_A1B727D30FC62A0F = anglestoup(_id_4D16D428538FF673);
  _id_1B77E17A42E2545B = anglestoleft(_id_4D16D428538FF673);
  _id_6232855EBA31163A = anglestoright(_id_4D16D428538FF673);
  _id_07F870143D9150C8 = 60;
  _id_47F3F37D04065B9F = 300;
  _id_B716ED1E1043D49D = rotatepointaroundvector(_id_A1B727D30FC62A0F, _id_878BAE61ACA86FC5, _id_07F870143D9150C8);
  _id_37ACB3A5EF4E3396 = vectorNormalize(vectorcross(_id_B716ED1E1043D49D, _id_A1B727D30FC62A0F));
  _id_13B2C03F423EB4F1 = vectorcross(_id_37ACB3A5EF4E3396, _id_B716ED1E1043D49D);
  _id_5A8F11024E7733A5 = axistoangles(_id_B716ED1E1043D49D, _id_37ACB3A5EF4E3396, _id_13B2C03F423EB4F1);
  _id_F4FEEF348DDCCE80 = rotatepointaroundvector(_id_A1B727D30FC62A0F, _id_878BAE61ACA86FC5, _id_07F870143D9150C8 * -1);
  _id_28A104B41542054B = vectorNormalize(vectorcross(_id_F4FEEF348DDCCE80, _id_A1B727D30FC62A0F));
  _id_71068EF94589E94A = vectorcross(_id_28A104B41542054B, _id_F4FEEF348DDCCE80);
  _id_6B5BD2EB86959740 = axistoangles(_id_F4FEEF348DDCCE80, _id_28A104B41542054B, _id_71068EF94589E94A);
  _id_D5C157BF3EFDA129 = vectortoangles(_id_A1B727D30FC62A0F);
  _id_3C19D396E8243A45 = vectortoangles(_id_878BAE61ACA86FC5);
  _id_A0D15869F98EFC85 = vectortoangles(_id_1B77E17A42E2545B);
  _id_10972F86BC3D391E = vectortoangles(_id_6232855EBA31163A);

  for(;;) {
    _id_C2659DB9DBFFDA55(_id_5A8F11024E7733A5, 4, "left");
    _id_C2659DB9DBFFDA55(_id_3C19D396E8243A45, 4, "fwd");
    _id_C2659DB9DBFFDA55(_id_6B5BD2EB86959740, 4, "right");
    _id_C2659DB9DBFFDA55(_id_3C19D396E8243A45, 4, "fwd");
  }
}

_id_C2659DB9DBFFDA55(angles, _id_91AE7188F4C06C96, _id_6BD4BE25BC2A569A) {
  if(!isDefined(_id_91AE7188F4C06C96))
    _id_91AE7188F4C06C96 = 4;

  _id_1E536FC02CE7881D = self gettagorigin("bi_base");
  _id_1B5EBB5A562AC4AC = anglesToForward(angles);
  _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 2000;
  _id_1995DCCCB8336733 = (_id_6C53D859D582A421[0], _id_6C53D859D582A421[1], _id_1E536FC02CE7881D[2]);
  self.targetent moveTo(_id_1995DCCCB8336733, _id_91AE7188F4C06C96 * 0.7, _id_91AE7188F4C06C96 * 0.15, _id_91AE7188F4C06C96 * 0.15);

  if(getdvarint("dvar_69DE6D4D9BA136D1", 0)) {
    if(isDefined(_id_6BD4BE25BC2A569A))
      announcement(_id_6BD4BE25BC2A569A);

    level thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, _id_1995DCCCB8336733, _id_91AE7188F4C06C96, (1, 0, 0));
  }

  wait(_id_91AE7188F4C06C96);
}

_id_BB1DD2CC161F6949() {
  self endon("death");
  level endon("game_ended");
  _id_30B63FB2CBF3DEC7();
  _id_ECBF90442E065A5F = 0;
  timeout = 5;

  for(;;) {
    _id_EC80496532425417 = _id_F9D29AA273972C15();

    if(!isDefined(_id_EC80496532425417)) {
      if(self.state != "idle") {
        if(self.state != "lost_LOS")
          _id_30B63FB2CBF3DEC7();

        if(getdvarint("dvar_69DE6D4D9BA136D1", 0))
          announcement("Lost LOS: " + _id_ECBF90442E065A5F + " / " + timeout);

        wait 0.5;
        _id_ECBF90442E065A5F = _id_ECBF90442E065A5F + 0.5;

        if(_id_ECBF90442E065A5F > timeout) {
          thread _id_42929A0D4354A323();
          _id_ECBF90442E065A5F = 0;
          continue;
        } else
          continue;
      } else {
        wait 1;
        _id_ECBF90442E065A5F = 0;
        continue;
      }
    }

    thread _id_C9650DCF6C729ABF(_id_EC80496532425417);
    self waittill("target_engaged");
  }
}

_id_C9650DCF6C729ABF(_id_EC80496532425417) {
  self endon("death");
  _id_EC80496532425417 endon("last_stand");
  _id_EC80496532425417 endon("disconnect");
  _id_D04BB1DC67A18E1B = self gettagorigin("tag_flash");

  if(getdvarint("dvar_69DE6D4D9BA136D1", 0))
    announcement("Target Engaged");

  self settargetentity(_id_EC80496532425417);
  self notify("exit_idle");
  _id_2909ED8B5CAE5917 = undefined;

  for(;;) {
    _id_5F9755FB2B4043C7 = _id_9250D1F0D4FDCA21(_id_EC80496532425417);

    if(!_id_5F9755FB2B4043C7) {
      _id_2909ED8B5CAE5917 = _id_F9D29AA273972C15(_id_D04BB1DC67A18E1B);

      if(!isDefined(_id_2909ED8B5CAE5917)) {
        waitframe();
        self notify("target_engaged");
        return;
      } else {
        _id_5F9755FB2B4043C7 = 1;
        self notify("exit_idle");
        self settargetentity(_id_2909ED8B5CAE5917);

        if(getdvarint("dvar_69DE6D4D9BA136D1", 0))
          announcement("Target Engaged");
      }
    }

    result = scripts\engine\utility::waittill_any_ents_or_timeout_return(2, self, "turret_on_target");

    if(result != "turret_on_target") {
      continue;
    }
    self.state = "firing";

    if(isDefined(_id_2909ED8B5CAE5917))
      self startfiring();
    else
      self startfiring();

    wait 0.1;
  }
}

_id_F9D29AA273972C15(_id_AA440CDD07894C27) {
  new_target_dist = self.maxrange;

  if(isDefined(self.new_target_dist))
    new_target_dist = self.new_target_dist;

  if(!isDefined(_id_AA440CDD07894C27))
    _id_AA440CDD07894C27 = self.origin;

  _id_BDD628D52F94BAA9 = new_target_dist * new_target_dist;

  foreach(player in level.players) {
    if(!player scripts\cp\utility::is_valid_player() || distance2dsquared(_id_AA440CDD07894C27, player.origin) > _id_BDD628D52F94BAA9) {
      continue;
    }
    if(!_id_9250D1F0D4FDCA21(player)) {
      continue;
    }
    return player;
  }

  return undefined;
}

_id_9250D1F0D4FDCA21(target, offset) {
  _id_9C9B691C180DE12C = 3500;

  if(isDefined(self._id_9BE8B180467D1B6E))
    _id_9C9B691C180DE12C = self._id_9BE8B180467D1B6E;

  if(!target scripts\cp\utility::is_valid_player() || distance2d(self.origin, target.origin) > _id_9C9B691C180DE12C)
    return 0;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  _id_D04BB1DC67A18E1B = self gettagorigin("tag_flash");
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  _id_D895C679F6A927E5 = [target gettagorigin("j_mainroot"), target gettagorigin("tag_origin"), target gettagorigin("j_head")];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(_id_D04BB1DC67A18E1B + offset, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], self, contents)) {
      continue;
    }
    return 1;
  }

  return 0;
}

sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
}

sentry_spinup() {
  thread sentry_targetlocksound();
  self notify("found_target");
  self startbarrelspin();

  if(soundexists("weap_dblmg_spinup_npc"))
    self playSound("weap_dblmg_spinup_npc");

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

_id_83E30545DCCA591A() {
  self endon("found_target");
  self endon("death");
  wait 3;
  sentry_spindown();
  thread sentry_burstfirestop();
}

sentry_spindown() {
  self stopbarrelspin();

  if(soundexists("weap_dblmg_spindown_npc"))
    self playSound("weap_dblmg_spindown_npc");

  self.momentum = 0;
}

sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  self endon("enter_idle");
  level endon("game_ended");
  _id_A3C79B0698570DBF();
  sentry_spinup();
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  _id_3746EC1BEFD86AE8 = level.sentrysettings[self.sentrytype].burstmin;
  _id_3E92CD336A99CE02 = level.sentrysettings[self.sentrytype].burstmax;
  _id_5F622C39D6661B23 = level.sentrysettings[self.sentrytype].pausemin;
  _id_42AE243CD994C3BD = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    _id_89F949A75D92E1A4 = randomintrange(_id_3746EC1BEFD86AE8, _id_3E92CD336A99CE02 + 1);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4 && !self.overheated; _id_AC0E594AC96AA3A8++) {
      if(!sentry_shouldshoot()) {
        break;
      }

      self shootturret();
      self notify("bullet_fired");

      if(isDefined(level._id_81F873EAE0CBAC09) && isfunction(level._id_81F873EAE0CBAC09))
        self thread[[level._id_81F873EAE0CBAC09]]();

      self.heatlevel = self.heatlevel + firetime;
      wait(firetime);
    }

    wait(randomfloatrange(_id_5F622C39D6661B23, _id_42AE243CD994C3BD));
  }
}

sentry_shouldshoot() {
  if(istrue(self.dont_shoot_parachutes)) {
    target = self getturrettarget(0);

    if(isDefined(target) && isPlayer(target) && target isparachuting())
      return 0;
  }

  return 1;
}

sentry_burstfirestop() {
  self notify("stop_shooting");
}

_id_A3C79B0698570DBF() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  maxrange = self.maxrange;
  target = self getturrettarget(0);

  for(;;) {
    if(!isDefined(target)) {
      return;
    }
    if(distance2dsquared(self.origin, target.origin) > maxrange) {
      wait 0.1;
      continue;
    }

    return;
  }
}

_id_0AB8DF173CD07CAD() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  maxrange = self._id_947AF351CE904AA5 + 50;
  target = self getturrettarget(0);

  for(;;) {
    if(!isDefined(target)) {
      return;
    }
    if(distance2dsquared(self.origin, target.origin) > maxrange)
      return;
    else
      wait 0.1;
  }
}

sentry_heatmonitor() {
  if(istrue(self.skip_overheat)) {
    return;
  }
  self endon("death");
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  _id_C81D1AE9575CD803 = 0;
  _id_06D613D4ED09F7CA = 0;
  overheattime = level.sentrysettings[self.sentrytype].overheattime;
  overheatcooldown = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != _id_C81D1AE9575CD803)
      wait(firetime);
    else
      self.heatlevel = max(0, self.heatlevel - 0.05);

    if(self.heatlevel > overheattime) {
      self.overheated = 1;
      thread playheatfx();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - overheatcooldown);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    _id_C81D1AE9575CD803 = self.heatlevel;
    wait 0.05;
  }
}

playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level.sentrysettings[self.sentrytype].fxtime);
  }
}

sentry_beepsounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3.0;

    if(!isDefined(self.carriedby))
      self playSound("sentry_gun_beep");
  }
}

sentry_handledeath() {
  self waittill("death");
  level.killstreak_additional_targets = scripts\engine\utility::array_remove(level.killstreak_additional_targets, self);
  level._id_CEEF08CFB883A461 = scripts\engine\utility::array_remove(level._id_CEEF08CFB883A461, self);
  thread _id_86D00513B000B479();

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
  scripts\engine\utility::flag_set("flag_incursion_sentry_destroyed_" + self._id_0E86180E07331051);

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

loadvfx() {
  level._effect["sniper_red_laser_bright"] = loadfx("vfx/iw9/core/lasers/vfx_hipaimlaser_red_bright.vfx");
}

_id_184EB1D2AA71225C(target) {
  self endon("death");
  level endon("game_ended");
  self endon("lose_target");
  target endon("death_or_disconnect");
  maxrange = self._id_947AF351CE904AA5;

  for(;;) {
    if(distance2dsquared(target.origin, self.origin) < maxrange) {
      break;
    }

    wait 0.1;
  }
}

_id_86D00513B000B479() {
  waittillframeend;

  if(isDefined(self.laser_fx)) {
    self.laser_fx notify("death");
    self.laser_fx delete();
  }
}

_id_95C492792C7BCB56(_id_6B68C7899B0ED705) {
  _id_844661B1EEA5FFEE = self gettagorigin("tag_laser");
  laser_start_ent = scripts\engine\utility::spawn_tag_origin(_id_844661B1EEA5FFEE, (0, 0, 0));
  laser_start_ent show();
  thread follow_tag_laser_attach(laser_start_ent);
  _id_ED46B526E028A1FB = get_laser_end_loc();
  self.laser_end_ent = scripts\engine\utility::spawn_tag_origin(_id_ED46B526E028A1FB, (0, 0, 0));
  self.laser_end_ent show();
  laser_fx = playfxontagsbetweenclients(_id_6B68C7899B0ED705, laser_start_ent, "tag_origin", self.laser_end_ent, "tag_origin");
  self.laser_end_ent thread follow_first_vehicle_driver(self, self.laser_end_ent);
  laser_start_ent thread _id_1BA1B8853F211BE3(laser_start_ent, laser_fx, self);
  self.laser_end_ent thread _id_1BA1B8853F211BE3(self.laser_end_ent, laser_fx, self);
  return laser_fx;
}

_id_5DCA38EFA635E474() {
  if(!isDefined(self.laser_end_ent) || !isent(self.laser_end_ent)) {
    return;
  }
  _id_ED46B526E028A1FB = get_laser_end_loc();
  self.laser_end_ent.origin = _id_ED46B526E028A1FB;
}

follow_first_vehicle_driver(sentry, laser_end_ent) {
  laser_end_ent endon("death");
  sentry endon("death");

  for(;;) {
    endpos = sentry get_laser_end_loc();

    if(isDefined(endpos))
      laser_end_ent.origin = endpos;

    waitframe();
  }
}

follow_tag_laser_attach(laser_start_ent) {
  laser_start_ent endon("death");
  self endon("death");

  for(;;) {
    _id_5638C3C19559C7F0 = self gettagorigin("tag_laser");
    _id_6A5DAF9FBF65C11E = self gettagangles("tag_laser");
    _id_50BE9A8C628554B7 = anglesToForward(_id_6A5DAF9FBF65C11E);
    _id_CE978C0D67AFEB68 = anglestoright(_id_6A5DAF9FBF65C11E);
    _id_CED390888B8D7F80 = _id_5638C3C19559C7F0 + _id_50BE9A8C628554B7 + _id_CE978C0D67AFEB68;
    laser_start_ent.origin = _id_CED390888B8D7F80;
    _id_5DCA38EFA635E474();
    waitframe();
  }
}

get_laser_end_loc() {
  _id_5638C3C19559C7F0 = self gettagorigin("tag_laser");
  _id_6A5DAF9FBF65C11E = self gettagangles("tag_laser");
  _id_50BE9A8C628554B7 = anglesToForward(_id_6A5DAF9FBF65C11E);
  _id_CE978C0D67AFEB68 = anglestoright(_id_6A5DAF9FBF65C11E);
  _id_3A82B54F7D442282 = sqrt(self._id_947AF351CE904AA5);
  _id_78CEB106D9B681B1 = _id_5638C3C19559C7F0 + _id_50BE9A8C628554B7 * _id_3A82B54F7D442282 + _id_CE978C0D67AFEB68;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  trace = scripts\engine\trace::ray_trace(_id_5638C3C19559C7F0, _id_78CEB106D9B681B1, self, contents);
  _id_F1E10E9899492069 = length(trace["position"] - _id_5638C3C19559C7F0);
  _id_78CEB106D9B681B1 = _id_5638C3C19559C7F0 + _id_50BE9A8C628554B7 * _id_F1E10E9899492069 + _id_CE978C0D67AFEB68;
  return _id_78CEB106D9B681B1;
}

_id_1BA1B8853F211BE3(_id_E58D98C4472E2132, laser_fx, sentry) {
  scripts\engine\utility::waittill_any_ents(laser_fx, "death", sentry, "death");
  _id_E58D98C4472E2132 delete();
}

_id_6A1CA8DE6B373B9A() {
  self endon("death");
  self._id_04431562DD584123 = _id_67AE16B6BC959B45();

  if(!isDefined(level.grenades))
    level.grenades = [];

  if(!isDefined(level.missiles))
    level.missiles = [];

  if(!isDefined(level.mines))
    level.mines = [];

  if(!isDefined(level.mortars))
    level.mortars = [];

  trophy_castcontents = _id_D0FC086404C2751B();

  for(;;) {
    _id_2CC97E113610CA14 = _id_39953DBB71494277();
    _id_C70B9ADBC218860A = [];
    _id_C70B9ADBC218860A[0] = level.grenades;
    _id_C70B9ADBC218860A[1] = level.missiles;
    _id_C70B9ADBC218860A[2] = level.mines;
    _id_C70B9ADBC218860A[3] = level.mortars;
    _id_9AC253C93282B297 = scripts\engine\utility::array_combine_multiple(_id_C70B9ADBC218860A);

    foreach(_id_1DBABE317739127E in _id_9AC253C93282B297) {
      if(!isDefined(_id_1DBABE317739127E)) {
        continue;
      }
      if(istrue(_id_1DBABE317739127E.exploding)) {
        continue;
      }
      if(_id_EA9DAD5328291A70(_id_1DBABE317739127E)) {
        continue;
      }
      _id_1BA7B2D16DC215E1 = _id_1DBABE317739127E.owner;

      if(!isDefined(_id_1BA7B2D16DC215E1) && isDefined(_id_1DBABE317739127E.weapon_name) && weaponclass(_id_1DBABE317739127E.weapon_name) == "grenade")
        _id_1BA7B2D16DC215E1 = getmissileowner(_id_1DBABE317739127E);

      if(isDefined(_id_1BA7B2D16DC215E1) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, _id_1BA7B2D16DC215E1))) {
        continue;
      }
      if(distancesquared(_id_1DBABE317739127E.origin, self.origin) > _id_AD122B596D24FBB8(_id_1DBABE317739127E, 65536)) {
        continue;
      }
      _id_E021C2744CC7ED68 = physics_raycast(_id_2CC97E113610CA14, _id_1DBABE317739127E.origin, trophy_castcontents, [self, _id_1DBABE317739127E], 0, "physicsquery_closest");

      if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
        continue;
      }
      _id_979247D21A3350FB(_id_1DBABE317739127E);
    }

    waitframe();
  }
}

_id_979247D21A3350FB(_id_1DBABE317739127E) {
  _id_1DBABE317739127E setCanDamage(0);
  _id_1DBABE317739127E.exploding = 1;
  _id_1DBABE317739127E stopsounds();
  _id_D7030318CA9E674A = _id_1DBABE317739127E.origin;
  _id_CC29543DE9737588 = _id_1DBABE317739127E.angles;

  if(_id_74502A9E0EF1F19C::isplantedequipment(_id_1DBABE317739127E))
    _id_1DBABE317739127E _id_74502A9E0EF1F19C::deleteexplosive();
  else
    _id_1DBABE317739127E delete();

  self._id_04431562DD584123 thread _id_6448B48D7023756B(_id_D7030318CA9E674A, _id_CC29543DE9737588);

  if(!isDefined(self._id_780FCD96E8F599E0))
    self._id_780FCD96E8F599E0 = 0;

  self._id_780FCD96E8F599E0++;
}

_id_39953DBB71494277() {
  return self.origin + anglestoup(self.angles) * 45;
}

_id_D0FC086404C2751B() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item"]);
}

_id_AD122B596D24FBB8(_id_1DBABE317739127E, _id_05B95596970B49B4) {
  if(isDefined(_id_1DBABE317739127E.weapon_name) && isDefined(_id_1DBABE317739127E.owner)) {
    switch (_id_1DBABE317739127E.weapon_name) {
      case "drone_hive_projectile_mp":
      case "jackal_cannon_mp":
      case "switch_blade_child_mp":
      case "iw8_la_kgolf_mp":
        if(147456 > _id_05B95596970B49B4)
          _id_05B95596970B49B4 = 147456;

        break;
      case "iw7_arclassic_mp":
      case "iw8_la_mike32_mp":
      case "iw8_la_rpapa7_mp":
      case "pop_rocket_proj_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_gromeoks_mp":
        if(65536 > _id_05B95596970B49B4)
          _id_05B95596970B49B4 = 65536;

        break;
    }
  }

  return _id_05B95596970B49B4;
}

_id_EA9DAD5328291A70(_id_1DBABE317739127E) {
  weaponname = _id_1DBABE317739127E.weapon_name;

  if(!isDefined(weaponname) && isDefined(_id_1DBABE317739127E.weapon_object))
    weaponname = _id_1DBABE317739127E.weapon_object.basename;

  if(isDefined(weaponname)) {
    if(_id_2669878CF5A1B6BC::iskillstreakweapon(weaponname))
      return 1;

    switch (weaponname) {
      case "trophy_cp":
        if(_id_74502A9E0EF1F19C::isplantedequipment(_id_1DBABE317739127E))
          return 1;

        break;
      case "uplinkball_tracking_mp":
      case "snapshot_grenade_danger_mp":
      case "micro_turret_mp":
      case "lighttank_mp":
      case "at_mine_ap_mp":
      case "pop_rocket_mp":
      case "throwingknife_mp":
        return 1;
    }
  }

  return 0;
}

_id_6F40090EAB9E1DB0(position) {
  tags = level.trophy.tags;
  _id_445ACA8C2C95592E = undefined;
  _id_5D32298B837DFF31 = undefined;

  foreach(id, tag in tags) {
    origin = self gettagorigin(tag);
    angles = self gettagangles(tag);
    forward = anglesToForward(angles);
    dot = vectordot(vectorNormalize(position - origin), forward);

    if(id == 0 || dot > _id_445ACA8C2C95592E) {
      _id_445ACA8C2C95592E = dot;
      _id_5D32298B837DFF31 = tag;
    }
  }

  return _id_5D32298B837DFF31;
}

_id_5E1D118DB3DC68DE(tag) {
  tags = level.trophy.tags;

  foreach(id, t in tags) {
    if(t == tag)
      return "protect" + (id + 1);
  }

  return undefined;
}

_id_67AE16B6BC959B45() {
  explosion = spawn("script_model", self.origin);
  explosion.killcament = self;
  explosion.owner = self.owner;
  explosion.team = self.team;
  explosion.equipmentref = self.equipmentref;
  explosion.weapon_name = self.weapon_name;
  explosion setotherent(explosion.owner);
  explosion setentityowner(explosion.owner);
  explosion setModel("trophy_system_mp_explode");
  explosion.explode1available = 1;
  explosion.explode2available = 1;
  explosion thread _id_83B6BDC2EDF58923(self, 0.1);
  return explosion;
}

_id_6448B48D7023756B(position, angles) {
  self dontinterpolate();
  self.origin = position;
  self.angles = angles;

  if(self.explode1available) {
    self setscriptablepartstate("explode1", "activeDirectional", 0);
    self.explode1available = 0;
  } else if(self.explode2available) {
    self setscriptablepartstate("explode2", "activeDirectional", 0);
    self.explode1available = 0;
  }
}

_id_83B6BDC2EDF58923(parent, delay) {
  self endon("death");
  parent waittill("death");
  wait(delay);
  self delete();
}