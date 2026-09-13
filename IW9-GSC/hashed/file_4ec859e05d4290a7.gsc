/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4ec859e05d4290a7.gsc
***********************************************/

_id_EE71C0848A6901D2() {
  if(_id_4C2E15BC834E979B::_id_FB6190FCD263559D()) {
    self.favoriteenemy = level.chopper_gunner._id_1A92A51A600CEFCB;
    _id_3433EE6B63C7E243::forceuseweapon("iw9_la_gromeo", "primary");
    self.dontevershoot = 1;
    thread _id_BC188B3013593CE8();
    self._id_01ED1C6A97DCFF01 = 1;
    thread _id_0DF4202E65548C20();
    _id_3ABFD0AEC654CD26 = 2000;
  }
}

_id_BC188B3013593CE8() {
  _id_D2781DBC3320BD3A = scripts\engine\utility::spawn_tag_origin();
  _id_D2781DBC3320BD3A.origin = self gettagorigin("tag_origin");
  _id_D2781DBC3320BD3A.angles = self gettagangles("tag_origin");
  _id_D2781DBC3320BD3A linkTo(self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("sniper_glint"), _id_D2781DBC3320BD3A, "tag_origin");
  scripts\engine\utility::waittill_any_2("death", "entitydeleted");

  if(isDefined(_id_D2781DBC3320BD3A)) {
    stopFXOnTag(scripts\engine\utility::getfx("sniper_glint"), _id_D2781DBC3320BD3A, "tag_origin");
    _id_D2781DBC3320BD3A delete();
  }
}

_id_0DF4202E65548C20() {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(_id_4C2E15BC834E979B::_id_FB6190FCD263559D())) {
    return;
  }
  self._id_D0FCBCDCDC4C4345 = 0;
  self.damaged = 0;
  self._id_D58E91E58E362A7A = 0;
  self.animname = "stinger_guy";
  self.suppress_uselastenemysightpos = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self.attackeraccuracy = 0;
  self._id_50BA41F491586FBF = 64000000;
  self.maxfaceenemydist = 20000;
  self.ignoresuppression = 1;
  self.fovcosine = 0.001;
  target_player = level.chopper_gunner._id_1A92A51A600CEFCB;
  target_player endon("death");

  for(;;) {
    if(!_id_4C2E15BC834E979B::_id_FB6190FCD263559D())
      wait 1;
    else
      target_player = level.chopper_gunner._id_1A92A51A600CEFCB;

    self.lastenemysightpos = target_player.origin + anglesToForward(target_player.angles) * 400;
    _id_A49FE39FE684C761 = sighttracepassed(self.origin, target_player.origin, 0, self, target_player);

    if(istrue(_id_A49FE39FE684C761)) {
      if(self._id_D0FCBCDCDC4C4345) {
        while(self._id_D0FCBCDCDC4C4345)
          waitframe();

        wait 3;
      }

      scripts\engine\utility::flag_set("locking_on_chopper");
      self notify("locking_onto_chopper");
      waitframe();
      thread _id_740C76864593AFDF();
      thread _id_DB1ECB7108C594DA();
      thread _id_0E20C964507BCB25();

      while(!self._id_D0FCBCDCDC4C4345 && !self.damaged)
        waitframe();

      if(!self._id_D0FCBCDCDC4C4345) {
        scripts\engine\utility::flag_clear("locking_on_chopper");
        self notify("lost_target_lock");
      }

      if(self.damaged) {
        while(self.damaged)
          waitframe();
      }

      if(self._id_D0FCBCDCDC4C4345) {
        while(self._id_D0FCBCDCDC4C4345)
          waitframe();
      }

      if(scripts\engine\utility::flag("chopper_evading")) {
        scripts\engine\utility::flag_waitopen("chopper_evading");
        wait 3;
      } else
        wait 3;
    }

    wait 0.1;
  }
}

_id_97A6648F614830C8(projectile) {
  level endon("game_ended");

  if(!_id_4C2E15BC834E979B::_id_FB6190FCD263559D()) {
    return;
  }
  _id_C92764FB24B40ABF = level.chopper_gunner._id_1A92A51A600CEFCB;
  projectile missileoutline();
  projectile missilethermal();
  level thread _id_4C2E15BC834E979B::_id_697E013714C47E57(projectile, 7);
  _id_F51B79A7D12057D9 = _id_C92764FB24B40ABF;

  while(_id_4C2E15BC834E979B::_id_FB6190FCD263559D() && isDefined(projectile) && distance(projectile.origin, _id_F51B79A7D12057D9.origin) > 700) {
    if(scripts\engine\utility::flag("chopper_evading"))
      _id_F51B79A7D12057D9 = _id_C92764FB24B40ABF._id_35782E0C1036C9A6;
    else
      _id_F51B79A7D12057D9 = _id_C92764FB24B40ABF;

    projectile missile_settargetEnt(_id_F51B79A7D12057D9);
    projectile missile_setflightmodedirect();
    waitframe();
  }

  if(isDefined(projectile) && _id_4C2E15BC834E979B::_id_FB6190FCD263559D() && !_id_4C2E15BC834E979B::_id_1B3513B44EA880C3()) {
    if(isvalidmissile(projectile))
      level thread _id_4C2E15BC834E979B::_id_697E013714C47E57(projectile, 0.0);

    _id_CBBB045B041FFEBE = weapongetdamagemax("iw8_la_sidewinder_gs_medium");

    if(!scripts\engine\utility::flag("chopper_evading")) {
      level notify("stinger_hit");
      _id_C92764FB24B40ABF dodamage(_id_CBBB045B041FFEBE, projectile.origin, self, projectile, "MOD_EXPLOSIVE", "iw8_la_sidewinder_gs_medium");
    } else
      level notify("stinger_evaded");
  }

  scripts\engine\utility::flag_clear("chopper_evading");

  if(_id_4C2E15BC834E979B::_id_FB6190FCD263559D()) {
    level.chopper_gunner._id_1A92A51A600CEFCB._id_73BAFB4A8A1295DF = 0;
    level.chopper_gunner._id_1A92A51A600CEFCB notify("stinger_exploded");
  }
}

_id_740C76864593AFDF() {
  self endon("death");
  self endon("damage");
  self endon("locking_onto_chopper");
  self endon("lost_target_lock");
  wait 1.3;
  level thread _id_8DBBB045AE5B880B();
  wait 0.3;
  _id_01EDF64226F200F4();
}

_id_B5523610D689816A() {
  self endon("death");
  self endon("damage");
  self endon("locking_onto_chopper");
  self endon("lost_target_lock");
  wait 2.5;
  level thread _id_8DBBB045AE5B880B();
  wait 1.5;
  _id_01EDF64226F200F4();
}

_id_8DBBB045AE5B880B() {
  level endon("game_ended");

  if(!_id_4C2E15BC834E979B::_id_FB6190FCD263559D()) {
    return;
  }
  level.chopper_gunner._id_1A92A51A600CEFCB thread _id_58E45D9D6B85E258();
  level.chopper_gunner._id_1A92A51A600CEFCB notify("stinger_lockon_launched");
  level notify("stinger_locked_on");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", level.chopper_gunner, "killstreak");
  level.chopper_gunner scripts\cp\cp_hud_message::tutorialprint(&"CP_HILLS_MI/PRESS_FOR_FLARE", 2);
  wait 3;
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", level.chopper_gunner, "killstreak");
}

_id_58E45D9D6B85E258() {
  level endon("game_ended");
  self endon("death");

  if(!scripts\engine\utility::flag("heli_warning_sfx_playing")) {
    scripts\engine\utility::flag_set("heli_warning_sfx_playing");
    self playLoopSound("cp_heli_esc_incoming_warning");
  }

  level scripts\engine\utility::waittill_any_timeout_2(5, "stinger_hit", "stinger_evaded");
  self stoploopsound("cp_heli_esc_incoming_warning");
  scripts\engine\utility::flag_clear("heli_warning_sfx_playing");
}

_id_DB1ECB7108C594DA() {
  level endon("game_ended");
  self endon("death");
  self waittill("death");

  if(scripts\engine\utility::flag("locking_on_chopper"))
    scripts\engine\utility::flag_clear("locking_on_chopper");
}

_id_01EDF64226F200F4() {
  self endon("death");

  if(!_id_4C2E15BC834E979B::_id_FB6190FCD263559D()) {
    scripts\engine\utility::flag_clear("locking_on_chopper");
    return;
  }

  level.chopper_gunner._id_1A92A51A600CEFCB endon("death");
  self._id_D0FCBCDCDC4C4345 = 1;
  _id_27448AB6053BABEC = self.origin + (0, 0, 100);

  if(self tagexists("tag_flash")) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_rpg_v"), self, "tag_flash");
    _id_27448AB6053BABEC = self gettagorigin("tag_flash");
  } else if(isDefined(self._id_1F7846011C111ECD) && self._id_1F7846011C111ECD tagexists("tag_flash")) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_rpg_v"), self._id_1F7846011C111ECD, "tag_flash");
    _id_27448AB6053BABEC = self._id_1F7846011C111ECD gettagorigin("tag_flash");
  }

  _id_FA2483033790AF38 = makeweapon("iw8_la_sidewinder_gs_medium");
  projectile = magicbullet(_id_FA2483033790AF38, _id_27448AB6053BABEC, level.chopper_gunner._id_1A92A51A600CEFCB.origin);
  thread _id_97A6648F614830C8(projectile);
  scripts\engine\utility::flag_clear("locking_on_chopper");
  wait 4;
  self._id_D0FCBCDCDC4C4345 = 0;
}

_id_0122642ECA8CA4DB(chopper, player) {
  level endon("game_ended");
  chopper endon("death");
  player endon("death");
  player endon("disconnect");
  player setclientomnvar("ui_killstreak_flares", 1);
  chopper thread _id_AEFBF277A355199B(player, chopper);

  for(;;) {
    chopper waittill("stinger_lockon_launched");
    chopper scripts\engine\utility::waittill_any_timeout_1(15, "stinger_exploded");
    player setclientomnvar("ui_killstreak_flares", 1);
  }
}

_id_8324BA67964340F9() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("laststand", "death");

  if(isDefined(self)) {
    self notifyonplayercommandremove("deploy_flares", "+actionslot 2");
    self notifyonplayercommandremove("deploy_flares", "+smoke");
  }
}

_id_AEFBF277A355199B(player, chopper) {
  player endon("death");
  player endon("disconnect");
  chopper endon("death");
  player notifyonplayercommand("deploy_flares", "+actionslot 2");
  player notifyonplayercommand("deploy_flares", "+smoke");
  player thread _id_8324BA67964340F9();

  for(;;) {
    player waittill("deploy_flares");
    player setclientomnvar("ui_killstreak_flares", 0);
    scripts\engine\utility::flag_set("chopper_evading");
    chopper._id_73BAFB4A8A1295DF = 1;
    chopper playSound("sentry_gun_beep");
    chopper thread scripts\cp\cp_flares::flares_playFX("tag_turret");
    chopper thread _id_F486B763202F0CEB(3);
    chopper notify("deploying_flares");
    wait 4;
    chopper._id_73BAFB4A8A1295DF = undefined;
    player setclientomnvar("ui_killstreak_flares", 1);
    wait 0.5;
  }
}

_id_F486B763202F0CEB(time) {
  level endon("game_ended");
  wait(time);
  scripts\engine\utility::flag_clear("chopper_evading");
}

_id_0E20C964507BCB25() {
  self endon("death");

  for(;;) {
    self waittill("damage");
    self.damaged = 1;
    wait 1.5;
    self.damaged = 0;
  }
}

_id_A21F32F25233607E(target_ent, start_origin, time, part) {
  target_ent endon("death");

  if(!isDefined(start_origin)) {
    _id_C1747BA3399508BC = self;

    if(!isai(self) && isDefined(self._id_1F7846011C111ECD))
      _id_C1747BA3399508BC = self._id_1F7846011C111ECD;

    _id_C9A397FD272C89F0 = scripts\engine\utility::spawn_tag_origin();
    _id_C9A397FD272C89F0.origin = _id_C1747BA3399508BC gettagorigin("tag_flash");
    _id_C9A397FD272C89F0.angles = _id_C1747BA3399508BC gettagangles("tag_flash");
    _id_C9A397FD272C89F0 setModel("weapon_wm_la_kgolf_missle");
  } else {
    _id_C9A397FD272C89F0 = scripts\engine\utility::spawn_tag_origin(start_origin, (0, 0, 0));
    _id_C9A397FD272C89F0 setModel("weapon_wm_la_kgolf_missle");
  }

  _id_C9A397FD272C89F0 show();
  _id_C9A397FD272C89F0 notsolid();
  playFXOnTag(scripts\engine\utility::getfx("vfx_rpg_trail_2"), _id_C9A397FD272C89F0, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("stinger_trail"), _id_C9A397FD272C89F0, "tag_origin");
  model = _id_C9A397FD272C89F0;

  if(!isDefined(time))
    time = 2.75;

  start = _id_C9A397FD272C89F0.origin;
  _id_2555CAFD1E701BA5 = 1;
  end = target_ent.origin;
  _id_9D9BCB154A71E0E6 = 1 / (time / 0.05);
  frac = 0;

  while(frac < 1) {
    if(isDefined(target_ent)) {
      end = target_ent.origin;

      if(isDefined(part))
        end = target_ent gettagorigin(part);
    } else
      end = level.chopper_gunner.origin + anglesToForward(level.chopper_gunner.angles) * 100 + (0, 0, -100);

    model.origin = scripts\engine\math::get_point_on_parabola(start, end, _id_2555CAFD1E701BA5, frac);
    model anglemortar();
    frac = frac + _id_9D9BCB154A71E0E6;
    wait 0.05;
  }

  model.origin = end;
  _id_E020078567E41613 = magicgrenademanual("frag", model.origin, model.origin + (0, 0, 1), 0.05);
  _id_E020078567E41613.owner = _id_E020078567E41613;
  _id_E020078567E41613.team = "axis";
  earthquake(0.4, 1.5, model.origin, 2000);
  playrumbleonposition("damage_heavy", model.origin);

  if(!isDefined(target_ent)) {
    return;
  }
  if(!istrue(target_ent._id_73BAFB4A8A1295DF)) {
    if(isDefined(self.weapon))
      target_ent dodamage(350, target_ent.origin, self, undefined, "MOD_EXPLOSIVE", self.weapon);
    else if(isDefined(self._id_1F7846011C111ECD) && isDefined(self._id_1F7846011C111ECD.objweapon))
      target_ent dodamage(350, target_ent.origin, self, undefined, "MOD_EXPLOSIVE", self._id_1F7846011C111ECD.objweapon);
  }

  target_ent notify("stinger_exploded", model.origin);
  target_ent._id_73BAFB4A8A1295DF = undefined;

  if(isDefined(_id_C9A397FD272C89F0)) {
    stopFXOnTag(scripts\engine\utility::getfx("sniper_glint"), _id_C9A397FD272C89F0, "tag_origin");
    _id_C9A397FD272C89F0 delete();
  }

  return end;
}

anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

_id_2519699D1F9A2D5C() {
  level endon("game_ended");
  level notify("single_stinger_VO_watcher");
  level endon("single_stinger_VO_watcher");

  for(;;) {
    level waittill("stinger_locked_on");
    thread _id_18641EB2DA7BBFFF();
    result = level scripts\engine\utility::waittill_any_return_2("stinger_hit", "stinger_evaded");

    if(result == "stinger_hit") {
      _id_BC583F6D212A17F3();
      continue;
    }

    _id_EC0AAC42EF6B624D();
  }
}

_id_18641EB2DA7BBFFF() {
  level endon("game_ended");

  if(!_id_4C2E15BC834E979B::_id_FB6190FCD263559D()) {
    return;
  }
  lines = ["dx_cp_cpes_shhl_hlp1_incomingmissile", "dx_cp_cpes_shhl_hlp1_missile", "dx_cp_cpes_shhl_hlp1_werebracketed", "dx_cp_cpes_shhl_hlp1_werepainted", "dx_cp_cpes_shhl_hlp1_theyvegotmissilelock", "dx_cp_cpes_shhl_hlp1_werelockedon", "dx_cp_cpes_shhl_hlp1_flaresflares", "dx_cp_cpes_shhl_hlp1_deployflares", "dx_cp_cpes_shhl_hlp1_deploycountermeasure"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines), level.chopper_gunner);
}

_id_BC583F6D212A17F3() {
  level endon("game_ended");

  if(!_id_4C2E15BC834E979B::_id_FB6190FCD263559D()) {
    return;
  }
  lines = ["dx_cp_cpes_shhl_hlp1_shitbraceforimpact", "dx_cp_cpes_shhl_hlp1_ohshit", "dx_cp_cpes_shhl_hlp1_werehit", "dx_cp_cpes_shhl_hlp1_takingfire", "dx_cp_cpes_shhl_hlp1_takingfiretakingfire", "dx_cp_cpes_shhl_hlp1_thatonestungus", "dx_cp_cpes_shhl_hlp1_lateflare", "dx_cp_cpes_shhl_hlp1_badflarebraceforimpa"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines), level.chopper_gunner);
  _id_AC2C5AB094E31AF6 = ["dx_cp_cpes_shhl_lasw_12deployyourflaresto", "dx_cp_cpes_shhl_lasw_airteamuseyourflares", "dx_cp_cpes_shhl_lasw_12yourflareswilldeco", "dx_cp_cpes_shhl_lasw_awelltimedflarewillc", "dx_cp_cpes_shhl_lasw_12youhavecountermeas", "dx_cp_cpes_shhl_lasw_12useyourflares", "dx_cp_cpes_shhl_lasw_useyourflares", "dx_cp_cpes_shhl_lasw_useflarestodecoythos"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(_id_AC2C5AB094E31AF6), level.chopper_gunner);
}

_id_EC0AAC42EF6B624D() {
  level endon("game_ended");

  if(!_id_4C2E15BC834E979B::_id_FB6190FCD263559D()) {
    return;
  }
  lines = ["dx_cp_cpes_shhl_hlp1_flaresout", "dx_cp_cpes_shhl_hlp1_deployingcountermeas", "dx_cp_cpes_shhl_hlp1_werebracketed", "dx_cp_cpes_shhl_hlp1_werepainted", "dx_cp_cpes_shhl_hlp1_theyvegotmissilelock", "dx_cp_cpes_shhl_hlp1_werelockedon", "dx_cp_cpes_shhl_hlp1_flaresflares", "dx_cp_cpes_shhl_hlp1_deployflares", "dx_cp_cpes_shhl_hlp1_deploycountermeasure", "dx_cp_cpes_shhl_hlp1_goodflaregoodflare", "dx_cp_cpes_shhl_hlp1_goodflare", "dx_cp_cpes_shhl_hlp1_nottodayfucker"];
  _id_166B4F052DA169A7::_id_775CD164C569E279(scripts\engine\utility::random(lines), level.chopper_gunner);
}