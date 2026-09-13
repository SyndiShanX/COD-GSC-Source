/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_518ae857a3d351c.gsc
***********************************************/

init() {
  if(!isDefined(level._id_CBE618F35B332990))
    level._id_CBE618F35B332990 = spawn("script_origin", (0, 0, 0));

  load_laser_fx();
  _id_E7A64DF827074B05();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("trap_defuse_object", ::_id_836CDAC4B1D38941);
}

load_laser_fx() {
  level._effect["vfx_laser_smoke"] = loadfx("vfx/iw8_cp/raid/vfx_cp_steampipe_exp.vfx");
  level._effect["vfx_laser_pointer"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp.vfx");
  level._effect["vfx_laser_pointer_thermal"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_thermalonly.vfx");
  level._effect["vfx_laser_pointer_nvg"] = loadfx("vfx/iw9/cp/vfx_red_laser_cp_nvgonly.vfx");
  level._effect["vfx_laser_destroy"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_destroy.vfx");
  level._effect["vfx_laser_burn"] = loadfx("vfx/iw8_cp/raid/lava/vfx_raid_laser_burn.vfx");
  level._effect["vfx_turret_light"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light.vfx");
  level._effect["vfx_c4_explode"] = loadfx("vfx/iw9/core/equipment/c4/vfx_equip_c4_gen_ch.vfx");
  level._effect["vfx_turret_light_5"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_0_5s.vfx");
  level._effect["vfx_turret_light_175"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_1_75s.vfx");
  level._effect["vfx_turret_light_2"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_2_0s.vfx");
  level._effect["vfx_turret_light_3"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_3_0s.vfx");
  level._effect["vfx_laser_destroy_nvg"] = loadfx("vfx/iw9/cp/vfx_red_laser_cp_nvgonly_die.vfx");
  level._effect["vfx_laser_destroy_end"] = loadfx("vfx/iw9/core/lasers/vfx_laser_nvg_end_die.vfx");
}

_id_E7A64DF827074B05() {
  level.sentrysettings["bs_laser"] = spawnStruct();
  level.sentrysettings["bs_laser"].health = 999999;
  level.sentrysettings["bs_laser"].maxhealth = 350;
  level.sentrysettings["bs_laser"].burstmin = 20;
  level.sentrysettings["bs_laser"].burstmax = 120;
  level.sentrysettings["bs_laser"].pausemin = 0.15;
  level.sentrysettings["bs_laser"].pausemax = 0.35;
  level.sentrysettings["bs_laser"].maxrange = 4000000;
  level.sentrysettings["bs_laser"]._id_947AF351CE904AA5 = 7562500;
  level.sentrysettings["bs_laser"].lockstrength = 2;
  level.sentrysettings["bs_laser"].sentrymodeon = "manual";
  level.sentrysettings["bs_laser"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["bs_laser"].ammo = 200;
  level.sentrysettings["bs_laser"].timeout = 999999;
  level.sentrysettings["bs_laser"].spinuptime = 0.65;
  level.sentrysettings["bs_laser"].overheattime = 8.0;
  level.sentrysettings["bs_laser"].cooldowntime = 0.1;
  level.sentrysettings["bs_laser"].fxtime = 0.3;
  level.sentrysettings["bs_laser"].streakname = "sentry_gun";
  level.sentrysettings["bs_laser"].weaponinfo = "laser_trap_nvg";
  level.sentrysettings["bs_laser"].playerweaponinfo = "laser_trap_nvg";
  level.sentrysettings["bs_laser"].scriptable = "ks_sentry_turret_mp";
  level.sentrysettings["bs_laser"].modelbasecover = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].modelbaseground = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].modeldestroyedcover = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].modeldestroyedground = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings["bs_laser"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["bs_laser"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["bs_laser"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["bs_laser"].headicon = 1;
  level.sentrysettings["bs_laser"].teamsplash = "used_sentry_gun";
  level.sentrysettings["bs_laser"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["bs_laser"].shouldsplash = 1;
  level.sentrysettings["bs_laser"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["bs_laser"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["bs_laser"].scorepopup = "destroyed_sentry";
  level.sentrysettings["bs_laser"].lightfxtag = "tag_fx";
  level.sentrysettings["bs_laser"].iskillstreak = 1;
  level.sentrysettings["bs_laser"].headiconoffset = (0, 0, 75);
}

_id_D1ACADC2A0B9E115(config, struct, team, model, weapon) {
  turret = spawnturret("misc_turret", struct.origin, weapon);
  turret.team = team;
  turret setturretteam(team);
  turret.angles = struct.angles;
  turret.health = config.maxhealth;
  turret.maxhealth = config.maxhealth;
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 2;
  turret.maxrange = config.maxrange;
  turret._id_947AF351CE904AA5 = config._id_947AF351CE904AA5;

  if(isDefined(struct.radius)) {
    _id_CDC5DD6C28C9709D = struct.radius * struct.radius;
    turret.maxrange = int(_id_CDC5DD6C28C9709D - _id_CDC5DD6C28C9709D * 0.1);
    turret._id_947AF351CE904AA5 = int(_id_CDC5DD6C28C9709D);
  }

  turret setModel(model);
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
  return turret;
}

_id_9C405FFA3BB2DCF0(_id_804269875F5062F1, team, _id_0E86180E07331051, _id_076BA9E808A42F81, parent_struct, _id_4FE5CDFF2560E8C6) {
  sentrytype = "bs_laser";
  config = level.sentrysettings[sentrytype];

  if(!isDefined(_id_4FE5CDFF2560E8C6))
    _id_4FE5CDFF2560E8C6 = level.sentrysettings[sentrytype].weaponinfo;

  if(!isDefined(team))
    team = "axis";

  if(!isDefined(_id_804269875F5062F1.angles))
    _id_804269875F5062F1.angles = (0, 0, 0);

  if(!isDefined(_id_076BA9E808A42F81))
    _id_076BA9E808A42F81 = "electronics_ir_laser_device_assembly_nogeo";

  turret = _id_D1ACADC2A0B9E115(config, _id_804269875F5062F1, team, _id_076BA9E808A42F81, _id_4FE5CDFF2560E8C6);
  turret.sentrytype = sentrytype;
  turret.turrettype = sentrytype;
  turret._id_0E86180E07331051 = _id_0E86180E07331051;
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentryturret_empcleared);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  _id_804269875F5062F1.turret = turret;
  turret._id_779C916529C44B1A = _id_804269875F5062F1;
  turret.parent_struct = parent_struct;

  if(!isDefined(level.killstreak_additional_targets))
    level.killstreak_additional_targets = [];

  level.killstreak_additional_targets = scripts\engine\utility::array_add(level.killstreak_additional_targets, turret);

  if(!isDefined(level._id_CEEF08CFB883A461))
    level._id_CEEF08CFB883A461 = [];

  level._id_CEEF08CFB883A461 = scripts\engine\utility::array_add(level._id_CEEF08CFB883A461, turret);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret sentryturret_empupdate();
  turret laseron();
  turret thread _id_42929A0D4354A323();
  turret notify("lasers_started");
  return turret;
}

sentryturret_empstarted(data) {
  if(isDefined(data.attacker) && isPlayer(data.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      data.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("stat_7410841FD4C63028");
  }

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
  } else if(!istrue(self._id_6181D0250AFA3CEC)) {
    self turretfireenable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
    self laseron();
  }
}

sentryturret_setinactive(turret) {
  turret setdefaultdroppitch(30);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
}

_id_42929A0D4354A323() {
  self endon("death");
  self endon("exit_idle");
  self endon("stop_idle_movement");

  if(isDefined(self.state) && self.state == "idle") {
    return;
  }
  self stopfiring();
  self.state = "idle";
  self notify("enter_idle");
  self notify("stop_shooting");
  thread _id_A9A8361DACE89499();
  tag = "tag_laser";

  if(!scripts\engine\utility::hastag(self.model, tag))
    tag = "tag_turret";

  self._id_C507394A92387E01 = self gettagorigin(tag) + anglesToForward(self gettagangles(tag)) * 3000;

  if(isDefined(self._id_71F08AA4E6A5186E))
    self[[self._id_71F08AA4E6A5186E]]();
  else {
    _id_1E536FC02CE7881D = self._id_779C916529C44B1A.origin;
    _id_4D16D428538FF673 = self._id_779C916529C44B1A.angles;
    _id_878BAE61ACA86FC5 = anglesToForward(_id_4D16D428538FF673);
    _id_A1B727D30FC62A0F = anglestoup(_id_4D16D428538FF673);
    _id_1B77E17A42E2545B = anglestoleft(_id_4D16D428538FF673);
    _id_6232855EBA31163A = anglestoright(_id_4D16D428538FF673);
    _id_07F870143D9150C8 = 15;
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

    if(!self._id_779C916529C44B1A _id_A0857113D8C32A2A()) {
      _id_1E536FC02CE7881D = self gettagorigin(tag);
      _id_1B5EBB5A562AC4AC = anglesToForward(_id_3C19D396E8243A45);
      _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 2000;
      trace = scripts\engine\trace::ray_trace(_id_1E536FC02CE7881D, _id_6C53D859D582A421, self);
      end = trace["position"];
      self._id_C507394A92387E01 = (_id_6C53D859D582A421[0], _id_6C53D859D582A421[1], _id_1E536FC02CE7881D[2]);
      self _meth_83EA6F9EBC30C9A4(self._id_C507394A92387E01 - _id_1E536FC02CE7881D);
      _id_98C102BF3750C771 = (_id_1E536FC02CE7881D + end) / 2;
      _id_0A890D51E917AD74(1, _id_98C102BF3750C771);
      waitframe();

      for(;;) {
        _id_C2659DB9DBFFDA55(_id_5A8F11024E7733A5, 10, "left");
        _id_C2659DB9DBFFDA55(_id_3C19D396E8243A45, 10, "fwd");
        _id_C2659DB9DBFFDA55(_id_6B5BD2EB86959740, 10, "right");
        _id_C2659DB9DBFFDA55(_id_3C19D396E8243A45, 10, "fwd");
      }

      return;
    }

    tag = "tag_laser";

    if(!scripts\engine\utility::hastag(self.model, tag))
      tag = "tag_turret";

    _id_1E536FC02CE7881D = self gettagorigin(tag);
    _id_1B5EBB5A562AC4AC = anglesToForward(_id_3C19D396E8243A45);
    _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 2000;
    trace = scripts\engine\trace::ray_trace(_id_1E536FC02CE7881D, _id_6C53D859D582A421, self);
    end = trace["position"];
    self._id_C507394A92387E01 = (end[0], end[1], _id_1E536FC02CE7881D[2]);
    self _meth_83EA6F9EBC30C9A4(self._id_C507394A92387E01 - _id_1E536FC02CE7881D);
    _id_98C102BF3750C771 = (_id_1E536FC02CE7881D + end) / 2;
    thread _id_0A890D51E917AD74(undefined, _id_98C102BF3750C771);
  }
}

vectortoanglessafe(forward, up) {
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  return angles;
}

_id_C2659DB9DBFFDA55(angles, _id_91AE7188F4C06C96, _id_6BD4BE25BC2A569A) {
  if(!isDefined(_id_91AE7188F4C06C96))
    _id_91AE7188F4C06C96 = 4;

  _id_CAD92BFFBDE8F755 = _id_91AE7188F4C06C96 * 0.7;
  _id_CD491403D3C67FD0 = _id_91AE7188F4C06C96 - _id_CAD92BFFBDE8F755;
  tag = "tag_laser";

  if(!scripts\engine\utility::hastag(self.model, tag))
    tag = "tag_turret";

  _id_1E536FC02CE7881D = self gettagorigin(tag);
  _id_1B5EBB5A562AC4AC = anglesToForward(angles);
  _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 2000;
  _id_1995DCCCB8336733 = (_id_6C53D859D582A421[0], _id_6C53D859D582A421[1], _id_1E536FC02CE7881D[2]);
  _id_B7A91148551C964D = self._id_C507394A92387E01;
  _id_071DF66B50009254 = gettime();
  _id_F5DA80D787F5C5B2 = _id_CAD92BFFBDE8F755 * 1000;

  for(;;) {
    _id_B6E159BF85A17541 = gettime() - _id_071DF66B50009254;

    if(_id_B6E159BF85A17541 > _id_F5DA80D787F5C5B2) {
      break;
    }

    self._id_C507394A92387E01 = vectorlerp(_id_B7A91148551C964D, _id_1995DCCCB8336733, _id_B6E159BF85A17541 / _id_F5DA80D787F5C5B2);
    self _meth_83EA6F9EBC30C9A4(self._id_C507394A92387E01 - _id_1E536FC02CE7881D);
    waitframe();
  }

  wait(_id_CD491403D3C67FD0);
}

_id_2CC59EA2A67BD2F4(struct, turrets) {
  struct._id_F02C2ABB29F1DE90 = spawnscriptable("dmz_lasertrap", struct.origin, struct.angles);
  struct._id_F02C2ABB29F1DE90._id_E40178EE59662442 = scripts\engine\utility::getStructArray(struct.target, "targetname");
  struct._id_F02C2ABB29F1DE90.parent_struct = struct;

  if(!isDefined(level._id_DA28469A4F1D6123))
    level._id_DA28469A4F1D6123 = [];

  level._id_DA28469A4F1D6123[level._id_DA28469A4F1D6123.size] = struct;

  if(_id_EE8A913E5BAF0C5D()) {
    if(scripts\common\utility::iscp())
      wait 2;
    else {
      scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
      waitframe();
    }

    foreach(turret in turrets)
    turret thread _id_62171A49E3430E0A(struct);
  }
}

_id_EE8A913E5BAF0C5D() {
  if(getdvarint("dvar_7693C920BEBDB71B", 1) != 0)
    return 1;

  return 0;
}

_id_836CDAC4B1D38941(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(part == "trap_defuse_object") {
    instance setscriptablepartstate("trap_defuse_object", "off");
    _id_ADB161E045B9B602 = instance.parent_struct;
    dropfunc = scripts\cp_mp\utility\script_utility::getsharedfunc("lasertrap", "createLootDropInfo");

    if(isDefined(dropfunc)) {
      _id_CB4FAD49263E20C4 = [[dropfunc]](_id_ADB161E045B9B602.origin, _id_ADB161E045B9B602.angles, undefined, 0, 0, undefined, 1);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("lasertrap", "spawnPickup")]]("brloot_offhand_c4", _id_CB4FAD49263E20C4, 1, 1);
    }

    playsoundatpos(_id_ADB161E045B9B602.origin, "cp_laser_disable");

    foreach(turret in _id_ADB161E045B9B602.turrets) {
      sentryturret_setinactive(turret);
      playFX(level._effect["vfx_laser_destroy_nvg"], turret.origin);
      start = turret gettagorigin("tag_laser");
      trace = scripts\engine\trace::ray_trace(start, turret._id_C507394A92387E01);
      end = trace["position"];
      playFX(level._effect["vfx_laser_destroy_end"], start);
      playFX(level._effect["vfx_laser_destroy_end"], end);
      turret setmode("sentry_offline");
      turret laseroff();

      if(_id_EE8A913E5BAF0C5D())
        turret thread _id_571C0F2116929A45();

      turret notify("stop_idle_movement");

      if(!turret._id_779C916529C44B1A _id_A0857113D8C32A2A()) {
        turret _id_0D33F98412123374(1);
        continue;
      }

      turret _id_0D33F98412123374();
    }

    if(isDefined(player)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
        player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("stat_392CD4486F5AB82E");
    }
  }
}

_id_571C0F2116929A45() {
  if(isDefined(self.parent_struct.script_index)) {
    if(self.parent_struct.script_index == "0.5")
      stopFXOnTag(level._effect["vfx_turret_light_5"], self, "tag_fx");

    if(self.parent_struct.script_index == "1.75")
      stopFXOnTag(level._effect["vfx_turret_light_175"], self, "tag_fx");

    if(self.parent_struct.script_index == "2")
      stopFXOnTag(level._effect["vfx_turret_light_2"], self, "tag_fx");

    if(self.parent_struct.script_index == "3")
      stopFXOnTag(level._effect["vfx_turret_light_3"], self, "tag_fx");
  }
}

_id_A9A8361DACE89499() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_idle_movement");

  if(scripts\common\utility::iscp())
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  else
    scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");

  wait 2;
  _id_4A5D9D7667048BF3 = scripts\engine\trace::create_character_contents();

  for(;;) {
    if(scripts\cp_mp\emp_debuff::is_empd()) {
      waitframe();
      continue;
    }

    start = self gettagorigin("tag_laser");
    nearby_players = sortbydistancecullbyradius(level.players, start, 1024);

    if(nearby_players.size == 0) {
      waitframe();
      continue;
    }

    trace = scripts\engine\trace::ray_trace(start, self._id_C507394A92387E01);
    end = trace["position"];
    _id_DB9C2822E3D940DC = lengthsquared(start - end);
    trace = scripts\engine\trace::ray_trace(start, end, [], _id_4A5D9D7667048BF3);

    if(isDefined(trace["entity"]) && trace["hittype"] == "hittype_entity") {
      if(isPlayer(trace["entity"])) {
        player = trace["entity"];
        _id_FF03DED389B65A7D = self.parent_struct;

        if(isDefined(player) && isPlayer(player)) {
          player._id_230A3287F9AD2965 = 1;
          player.shouldskipdeathsshield = 1;
        }

        playsoundatpos(_id_FF03DED389B65A7D.origin, "cp_laser_trigger");
        time = min(2, lookupsoundlength("cp_laser_trigger") * 0.001);
        wait(time);
        playsoundatpos(_id_FF03DED389B65A7D.origin, "cp_laser_expl");
        mindamage = getdvarint("dvar_EA6E58C378D245E5", 100);
        maxdamage = getdvarint("dvar_D5FF13FE4588F203", 200);
        _id_F48557F5D46F1623 = getdvarint("dvar_DB8F6FD15E9A7DB6", 384);

        foreach(_id_96B5BEF64547D4C2 in _id_FF03DED389B65A7D.turrets) {
          if(!_id_96B5BEF64547D4C2 scripts\cp_mp\emp_debuff::is_empd())
            level._id_CBE618F35B332990 radiusdamage(_id_96B5BEF64547D4C2._id_4CF58793CC4F1AD6.origin, _id_F48557F5D46F1623, maxdamage, mindamage, level._id_CBE618F35B332990, "MOD_EXPLOSIVE", "frag_grenade_mp");
        }

        level._id_CBE618F35B332990 radiusdamage(_id_FF03DED389B65A7D.origin, _id_F48557F5D46F1623, maxdamage, mindamage, level._id_CBE618F35B332990, "MOD_EXPLOSIVE", "frag_grenade_mp");
        playrumbleonposition("grenade_rumble", _id_FF03DED389B65A7D.origin);
        earthquake(0.45, 0.7, _id_FF03DED389B65A7D.origin, 800);
        level notify("trigger_reinforcements_if_applicable");
        playFX(level._effect["vfx_laser_destroy_nvg"], start);
        playFX(level._effect["vfx_laser_destroy_end"], start);
        playFX(level._effect["vfx_laser_destroy_nvg"], end);
        playFX(level._effect["vfx_laser_destroy_end"], end);

        foreach(turret in _id_FF03DED389B65A7D.turrets) {
          if(!turret._id_779C916529C44B1A _id_A0857113D8C32A2A())
            turret _id_0D33F98412123374(1);
          else
            turret _id_0D33F98412123374();

          if(self != turret)
            thread _id_277B35006FAB38DD(turret);
        }

        if(isDefined(_id_FF03DED389B65A7D._id_F02C2ABB29F1DE90)) {
          _id_FF03DED389B65A7D._id_F02C2ABB29F1DE90 setscriptablepartstate("trap_defuse_object", "off");
          playFX(level._effect["vfx_c4_explode"], _id_FF03DED389B65A7D._id_F02C2ABB29F1DE90.origin);
        }

        thread _id_277B35006FAB38DD(self);
        return;
      }
    }

    waitframe();
  }
}

_id_277B35006FAB38DD(turret) {
  turret playSound("recon_drone_explode");

  if(_id_EE8A913E5BAF0C5D())
    turret thread _id_571C0F2116929A45();

  sentryturret_setinactive(turret);
  turret._id_6181D0250AFA3CEC = 1;
  turret laseroff();
  turret notify("stop_idle_movement");
}

_id_A0857113D8C32A2A() {
  if(isDefined(self.script_groupname) && self.script_groupname == "nomove")
    return 1;

  return 0;
}

_id_62171A49E3430E0A(struct) {
  self endon("death");
  self endon("stop_idle_movement");

  if(isDefined(struct.script_index)) {
    if(struct.script_index == "0.5")
      playFXOnTag(level._effect["vfx_turret_light_5"], self, "tag_fx");
    else if(struct.script_index == "1.75")
      playFXOnTag(level._effect["vfx_turret_light_175"], self, "tag_fx");
    else if(struct.script_index == "2")
      playFXOnTag(level._effect["vfx_turret_light_2"], self, "tag_fx");
    else if(struct.script_index == "3")
      playFXOnTag(level._effect["vfx_turret_light_3"], self, "tag_fx");
  }
}

_id_0A890D51E917AD74(_id_F095DF44CB4D44C3, _id_B1912D395068CF48) {
  self endon("death");
  wait 5;

  if(isDefined(_id_B1912D395068CF48) && isvector(_id_B1912D395068CF48))
    self._id_4CF58793CC4F1AD6 = spawn("script_model", _id_B1912D395068CF48);
  else
    self._id_4CF58793CC4F1AD6 = spawn("script_model", self.origin);

  self._id_4CF58793CC4F1AD6 setModel("tag_origin");
  waitframe();

  if(!istrue(_id_F095DF44CB4D44C3))
    self._id_4CF58793CC4F1AD6 playLoopSound("cp_laser_idle");
  else {
    self._id_4CF58793CC4F1AD6 linkTo(self, "tag_aim_pivot");
    self._id_4CF58793CC4F1AD6 playLoopSound("cp_laser_mvmt");
  }
}

_id_0D33F98412123374(_id_F095DF44CB4D44C3) {
  if(!istrue(_id_F095DF44CB4D44C3))
    self._id_4CF58793CC4F1AD6 stoploopsound("cp_laser_idle");
  else
    self._id_4CF58793CC4F1AD6 stoploopsound("cp_laser_mvmt");

  self._id_4CF58793CC4F1AD6 delete();
}