/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3ae866a6dd08daf9.gsc
***********************************************/

main(_id_C5B53BB3563B607B) {
  _id_E7A64DF827074B05();
  init_laser_trap();
  level thread init_laser_traps(_id_C5B53BB3563B607B);
}

init_laser_trap() {
  level.scripted_laser_func = ::laser_func;
  level._id_1EF9906CAD3258C9 = scripts\engine\trace::create_character_contents();
}

load_laser_fx() {
  level._effect["vfx_laser_smoke"] = loadfx("vfx/iw8_cp/raid/vfx_cp_steampipe_exp.vfx");
  level._effect["vfx_laser_pointer"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp.vfx");
  level._effect["vfx_laser_pointer_thermal"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_thermalonly.vfx");
  level._effect["vfx_laser_pointer_nvg"] = loadfx("vfx/iw9/cp/vfx_red_laser_cp_nvgonly.vfx");
  level._effect["vfx_laser_destroy"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_destroy.vfx");
  level._effect["vfx_laser_burn"] = loadfx("vfx/iw8_cp/raid/lava/vfx_raid_laser_burn.vfx");
  level._effect["vfx_c4_light"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light.vfx");
  level._effect["vfx_turret_light"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light.vfx");
  level._effect["vfx_c4_explode"] = loadfx("vfx/iw9/core/equipment/c4/vfx_equip_c4_gen_ch.vfx");
  level._effect["vfx_c4_light_5"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light_0_5s.vfx");
  level._effect["vfx_turret_light_5"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_0_5s.vfx");
  level._effect["vfx_c4_light_175"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light_1_75s.vfx");
  level._effect["vfx_turret_light_175"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_1_75s.vfx");
  level._effect["vfx_c4_light_2"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light_2_0s.vfx");
  level._effect["vfx_turret_light_2"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_2_0s.vfx");
  level._effect["vfx_c4_light_3"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light_3_0s.vfx");
  level._effect["vfx_turret_light_3"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_3_0s.vfx");
  level._effect["vfx_laser_destroy_nvg"] = loadfx("vfx/iw9/cp/vfx_red_laser_cp_nvgonly_die.vfx");
  level._effect["vfx_laser_destroy_end"] = loadfx("vfx/iw9/core/lasers/vfx_laser_nvg_end_die.vfx");
}

laser_func() {
  level endon("game_ended");
  spawn_pos = self.origin;

  if(self.ent tagexists("tag_laser"))
    spawn_pos = self.ent gettagorigin("tag_laser");

  trace = scripts\engine\trace::ray_trace(spawn_pos, spawn_pos + anglestoup(self.angles) * int(self.struct.height));
  self.laser_start_ent_thermal = create_tag_origin(spawn_pos, self);
  self.laser_reset_position = self.laser_start_ent_thermal.origin;
  self.laser_end_ent_thermal = create_tag_origin(trace["position"], self);
  self.laser_show_position = self.laser_end_ent_thermal.origin;
  self.fx_thermal_end = spawnfx(level._effect["vfx_laser_burn"], self.laser_show_position);
  triggerfx(self.fx_thermal_end);
  self.fx_thermal = playfxontagsbetweenclients(level._effect["vfx_laser_pointer_nvg"], self.laser_start_ent_thermal, "tag_origin", self.laser_end_ent_thermal, "tag_origin");
  thread cleanup_target_stats_thermal(self.fx_thermal);
}

cleanup_target_stats(fx) {
  self endon("death");

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_4("cleanup_target", "delete_fx_between_points", "delete_trap", "death");

    if(isDefined(result) && (result == "delete_trap" || result == "delete_fx_between_points")) {
      if(isDefined(fx))
        fx delete();

      self.ent delete();
      self.laser_end_ent delete();
      self.laser_start_ent delete();
      self notify("cleanup_target_thermal");

      if(isDefined(self))
        self delete();
    }
  }
}

cleanup_target_stats_thermal(fx) {
  self endon("death");
  self notify("cleanup_target_stats_thermal");
  self endon("cleanup_target_stats_thermal");

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_5("cleanup_target_nvg", "hide_laser", "show_laser", "trigger_alarm", "disable_trap_no_alarm");

    if(isDefined(result)) {
      if(result == "disable_trap_no_alarm") {
        playFX(level._effect["vfx_laser_destroy"], self.laser_start_ent_thermal.origin);
        fx delete();
        self.laser_end_ent_thermal delete();
        self.fx_thermal_end delete();
        self.laser_start_ent_thermal delete();

        if(isDefined(self))
          self delete();
      }

      if(result == "trigger_alarm") {}

      if(result == "cleanup_target_nvg") {
        self.laser_start_ent_thermal playSound("recon_drone_explode");
        self.laser_end_ent_thermal playSound("recon_drone_explode");
        playFX(level._effect["vfx_laser_destroy"], self.laser_start_ent_thermal.origin);
        fx delete();
        self.laser_end_ent_thermal delete();
        self.fx_thermal_end delete();
        self.laser_start_ent_thermal delete();

        if(isDefined(self.ent))
          self.ent delete();

        if(isDefined(self))
          self delete();
      }

      if(result == "hide_laser") {
        playFX(level._effect["vfx_laser_destroy"], self.laser_start_ent_thermal.origin);
        fx delete();
      }

      if(result == "show_laser") {
        self.fx_thermal = playfxontagsbetweenclients(level._effect["vfx_laser_pointer_nvg"], self.laser_start_ent_thermal, "tag_origin", self.laser_end_ent_thermal, "tag_origin");
        thread cleanup_target_stats_thermal(self.fx_thermal);
      }
    }
  }
}

follow_tag_laser_attach(sniper, laser_start_ent) {
  laser_start_ent endon("death");

  for(;;) {
    _id_5638C3C19559C7F0 = sniper gettagorigin("tag_flash");
    laser_start_ent.origin = _id_5638C3C19559C7F0;
    waitframe();
  }
}

create_tag_origin(spawn_pos, sniper) {
  tag_origin = spawn("script_model", spawn_pos);
  tag_origin setModel("tag_origin");
  tag_origin thread clean_up_think(tag_origin, sniper);
  return tag_origin;
}

clean_up_think(tag_origin, sniper) {
  tag_origin endon("death");
  sniper waittill("death");
  tag_origin delete();
}

init_laser_traps(_id_C5B53BB3563B607B) {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::flag_wait("create_script_initialized");
  wait 1;

  if(!isDefined(_id_C5B53BB3563B607B)) {
    return;
  }
  triggers = getEntArray(_id_C5B53BB3563B607B, "targetname");

  foreach(trigger in triggers) {
    ent = getEnt(trigger.target, "targetname");
    ent.trigger = trigger;
    trigger.ent = ent;

    if(trigger.classname == "trigger_radius" || trigger.classname == "trigger_rotatable_radius")
      trigger enablelinkTo();

    trigger linkTo(ent);
    trigger initialize_laser_trap_entity(1);
    ent initialize_laser_trap_entity();
  }
}

initialize_laser_trap_entity(_id_69C8E45B8B8BB727) {
  if(!isDefined(level.laser_traps))
    level.laser_traps = [];

  if(istrue(_id_69C8E45B8B8BB727)) {
    if(isDefined(self.struct.script_groupname) && self.struct.script_groupname == "toggle") {
      self.current_state = 333;
      thread trap_toggle_logic();
    } else if(isDefined(self.struct.script_groupname) && self.struct.script_groupname == "toggle_fx") {
      thread laser_func();
      self.current_state = 69;
      toggle_fx_trap(96);
    } else
      self.current_state = 0;

    if(!isDefined(level.laser_traps[self.struct.script_groupname]))
      level.laser_traps[self.struct.script_groupname] = [];

    level.laser_traps[self.struct.script_groupname] = scripts\engine\utility::array_add(level.laser_traps[self.struct.script_groupname], self);
    thread trap_trigger_logic();
  } else {
    if(isDefined(self.trigger.struct.script_groupname) && self.trigger.struct.script_groupname == "toggle") {
      return;
    }
    if(isDefined(self.trigger.struct.script_groupname) && self.trigger.struct.script_groupname == "toggle_fx") {
      if(!istrue(level._id_8ACA98661B1886B1))
        thread watch_for_damage_on_trap();

      if(istrue(level._id_79928EC6A4845A9C)) {
        self makeusable();
        self setHintString(&"COOP_GAME_PLAY/DISABLE_TRAP");
        self sethintdisplayrange(120);
        self sethintdisplayfov(120);
        self setusefov(120);
        self setuserange(120);
        self sethintonobstruction("hide");
        self setuseholdduration("duration_medium");
        thread _id_E9FDA713611C4D4F();
      }
    } else {
      self.v_start_pos = self.origin;
      self.v_end_pos = scripts\engine\utility::getStruct(self.target, "targetname").origin;
      collision = spawn("script_model", self.origin);
      collision dontinterpolate();
      collision.angles = self.angles;
      collision clonebrushmodeltoscriptmodel(getEnt("care_package_col", "targetname"));
      collision linkTo(self);
      self.collision = collision;
      self.current_state = 0;
      return;
    }
  }
}

_id_E9FDA713611C4D4F() {
  self notify("model_use_thread");
  self endon("model_use_thread");
  self endon("death");

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      continue;
    }
    if(isPlayer(entity)) {
      self.trigger notify("disable_trap_no_alarm");
      self makeunusable();
    }
  }
}

watch_for_damage_on_trap() {
  self endon("death");
  self setCanDamage(1);
  self.health = 9999;
  self.maxhealth = 9999;
  self._id_ABBAA2FC2B3DA347 = 0;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker)) {
      continue;
    }
    if(meansofdeath == "MOD_GRENADE_SPLASH") {
      continue;
    }
    attacker thread _id_354C862768CFE202::updatedamagefeedback("hitturret", undefined, damage, 1);
    self._id_ABBAA2FC2B3DA347++;

    if(self._id_ABBAA2FC2B3DA347 < 2) {
      continue;
    }
    self.health = 9999;
    self.maxhealth = 9999;
    playFX(level._effect["vfx_laser_destroy"], self.trigger.laser_start_ent_thermal.origin);
    playFX(level._effect["vfx_laser_destroy"], self.trigger.laser_end_ent_thermal.origin);

    if(isDefined(level._id_DF3AD2237853744A)) {
      if(self[[level._id_DF3AD2237853744A]]())
        self.trigger notify("cleanup_target_nvg");

      continue;
    }

    radiusdamage(self.trigger.laser_start_ent_thermal.origin, 256, 666, 133);
    radiusdamage(self.trigger.laser_end_ent_thermal.origin, 256, 666, 133);
    self.trigger notify("cleanup_target_nvg");
  }
}

removesuppressioneffectsaftertimeout(timeout) {
  self endon("death");

  if(isDefined(self.trigger))
    self.trigger endon("death");

  self.trigger notify("hide_laser");
  wait(timeout);
  self.trigger notify("show_laser");
}

trap_trigger_logic(_id_C0D7A5FB530D544A) {
  self notify("trap_trigger_logic");
  self endon("trap_trigger_logic");
  self endon("death");

  for(;;) {
    self waittill("trigger", entity);

    if(self.struct.script_groupname != "toggle_fx") {
      if(self.current_state == 333)
        continue;
    }

    if(!isPlayer(entity) && !isai(entity)) {
      continue;
    }
    if(isPlayer(entity)) {
      if(isDefined(level._id_DD58FE315B085D35)) {
        self[[level._id_DD58FE315B085D35]](entity);
        continue;
      } else {
        entity push_players_back_and_deal_damage(entity);
        entity dodamage(entity.health + 10000, entity.origin);

        if(self.struct.script_groupname == "toggle_fx") {
          playFX(level._effect["vfx_laser_destroy"], self.laser_start_ent_thermal.origin);
          playFX(level._effect["vfx_laser_destroy"], self.laser_end_ent_thermal.origin);
          radiusdamage(self.laser_start_ent_thermal.origin, 256, 666, 133);
          radiusdamage(self.laser_end_ent_thermal.origin, 256, 666, 133);
        }

        self notify("cleanup_target_nvg");
        level notify("start_floor_spawners");
      }
    }
  }
}

trap_toggle_logic() {
  self notify("trap_toggle_logic");
  self endon("trap_toggle_logic");

  for(;;) {
    wait 5;
    toggle_trap();
  }
}

toggle_trap() {
  if(self.current_state == 333) {
    if(isDefined(self.smoke_fx))
      self.smoke_fx delete();

    if(isDefined(self.distort_fx))
      self.distort_fx delete();

    self.current_state = 666;
    playFX(level._effect["vfx_laser_smoke"], self.origin - (0, -8, 16), anglesToForward(self.angles), anglestoright(self.angles));
    childthread scripts\engine\utility::play_loop_sound_on_entity("fire_system_hiss");
    childthread scripts\engine\utility::playsoundonentity("fire_system_start");
  } else {
    self notify("stop soundfire_system_hiss");
    self notify("stop soundfire_system_start");
    self.current_state = 333;
  }
}

trap_toggle_fx_logic() {
  self endon("death");
  self notify("trap_toggle_fx_logic");
  self endon("trap_toggle_fx_logic");

  for(;;) {
    level waittill("smoke_grenade_explosion", position, radius, duration, delay);

    if(isDefined(delay))
      wait(delay);

    if(distance2dsquared(position, self.origin) > squared(radius)) {
      continue;
    }
    toggle_fx_trap(96);
    wait(duration);
    toggle_fx_trap(69);
  }
}

toggle_fx_trap(_id_A446477617A37C57) {
  self endon("death");

  if(isDefined(self.laser_end_ent))
    self.laser_end_ent endon("death");

  if(isDefined(_id_A446477617A37C57)) {
    if(_id_A446477617A37C57 == 69) {
      self.current_state = 69;

      if(isDefined(self.laser_fx))
        self.laser_fx delete();

      self.laser_end_ent moveTo(self.laser_reset_position, 0.05);
    } else {
      if(isDefined(self.laser_fx))
        self.laser_fx delete();

      self.current_state = 96;
    }
  } else if(self.current_state == 69) {
    if(isDefined(self.laser_fx))
      self.laser_fx delete();

    self.current_state = 96;
    self.laser_end_ent moveTo(self.laser_show_position, 0.05);
    thread laser_func();
  } else {
    self.current_state = 69;

    if(isDefined(self.laser_fx))
      self.laser_fx delete();

    self.laser_end_ent moveTo(self.laser_reset_position, 0.05);
  }
}

push_players_back_and_deal_damage(player) {
  dir = -1 * anglesToForward(player.angles);
  _id_D01387BDA9E91E50 = player getvelocity();
  _id_ADC4B2BF275805C7 = length2d(_id_D01387BDA9E91E50);

  if(_id_ADC4B2BF275805C7 == 0)
    _id_ADC4B2BF275805C7 = 60;

  if(_id_ADC4B2BF275805C7 < 60)
    _id_ADC4B2BF275805C7 = 60;

  _id_E73621F0A50827AC = player getvelocity();
  _id_E73621F0A50827AC = (_id_E73621F0A50827AC[0], _id_E73621F0A50827AC[1], 0);
  _id_2FDCE9F0DA5412E0 = length2d(_id_E73621F0A50827AC);

  if(_id_2FDCE9F0DA5412E0 > 0) {
    _id_3173030081735E94 = dir * _id_ADC4B2BF275805C7;
    _id_80E3E9C318E99CF1 = _id_E73621F0A50827AC + _id_3173030081735E94;
    _id_2297D1C3903888ED = length2d(_id_80E3E9C318E99CF1);

    if(vectordot(_id_80E3E9C318E99CF1, _id_3173030081735E94) < 0) {
      right = vectorcross((0, 0, 1), dir);

      if(vectordot(right, _id_E73621F0A50827AC) > 0) {
        _id_2FDCE9F0DA5412E0 = length2d(_id_E73621F0A50827AC);
        _id_E73621F0A50827AC = right * _id_2FDCE9F0DA5412E0;
      } else {
        left = right * -1;
        _id_2FDCE9F0DA5412E0 = length2d(_id_E73621F0A50827AC);
        _id_E73621F0A50827AC = left * _id_2FDCE9F0DA5412E0;
      }

      _id_80E3E9C318E99CF1 = _id_E73621F0A50827AC + _id_3173030081735E94;
      _id_ADC4B2BF275805C7 = length2d(_id_80E3E9C318E99CF1);
    } else {
      if(_id_2FDCE9F0DA5412E0 > _id_ADC4B2BF275805C7)
        _id_ADC4B2BF275805C7 = _id_2FDCE9F0DA5412E0;

      dir = vectorNormalize(_id_80E3E9C318E99CF1);
    }
  }

  player knockback(dir, _id_ADC4B2BF275805C7);
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

  if(getdvarint("dvar_094577B429C0E801", 1) != 0) {
    if(istrue(_id_74502A9E0EF1F19C::player_has_nvg())) {
      level.sentrysettings["bs_laser"].weaponinfo = "laser_trap_nvg";
      level.sentrysettings["bs_laser"].playerweaponinfo = "laser_trap_nvg";
    } else {
      level.sentrysettings["bs_laser"].weaponinfo = "laser_trap_not_nvg";
      level.sentrysettings["bs_laser"].playerweaponinfo = "laser_trap_not_nvg";
    }
  } else {
    level.sentrysettings["bs_laser"].weaponinfo = "sentry_turret_mp";
    level.sentrysettings["bs_laser"].playerweaponinfo = "sentry_turret_mp";
  }

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

  if(isDefined(level._id_2184802E7B6495DD))
    [[level._id_2184802E7B6495DD]]();
}

_id_9C405FFA3BB2DCF0(_id_804269875F5062F1, _id_0E86180E07331051, _id_076BA9E808A42F81, parent_struct, _id_507BA3530EF8559E, _id_5EC17B72139BF948) {
  sentrytype = scripts\engine\utility::ter_op(isDefined(_id_507BA3530EF8559E), _id_507BA3530EF8559E, "bs_laser");
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
  _id_804269875F5062F1._id_20868C2AF60860FA = undefined;

  if(isDefined(_id_804269875F5062F1.script_oneway))
    _id_804269875F5062F1._id_20868C2AF60860FA = int(_id_804269875F5062F1.script_oneway);

  if(isDefined(_id_804269875F5062F1.radius)) {
    _id_CDC5DD6C28C9709D = _id_804269875F5062F1.radius * _id_804269875F5062F1.radius;
    turret.maxrange = int(_id_CDC5DD6C28C9709D - _id_CDC5DD6C28C9709D * 0.1);
    turret._id_947AF351CE904AA5 = int(_id_CDC5DD6C28C9709D);
  }

  _id_804269875F5062F1.turret = turret;
  _id_804269875F5062F1._id_07F870143D9150C8 = 15;

  if(isDefined(_id_804269875F5062F1.script_duration))
    _id_804269875F5062F1._id_07F870143D9150C8 = int(_id_804269875F5062F1.script_duration);

  _id_804269875F5062F1._id_D7A35FD5BD92CC60 = undefined;

  if(isDefined(_id_804269875F5062F1.script_looping))
    _id_804269875F5062F1._id_D7A35FD5BD92CC60 = int(_id_804269875F5062F1.script_looping);

  turret._id_779C916529C44B1A = _id_804269875F5062F1;
  turret.parent_struct = parent_struct;

  if(!isDefined(_id_076BA9E808A42F81))
    _id_076BA9E808A42F81 = "electronics_ir_laser_device_assembly_nogeo";

  if(istrue(turret _id_B19F85F4A1D36E2B()))
    _id_076BA9E808A42F81 = "electronics_ir_laser_device_vertical_rig_skeleton";

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
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentryturret_empcleared);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);

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
  turret thread _id_42929A0D4354A323(_id_5EC17B72139BF948);
  turret notify("lasers_started");
  return turret;
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

sentryturret_setinactive(turret) {
  turret setdefaultdroppitch(30);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
}

_id_42929A0D4354A323(_id_5EC17B72139BF948) {
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

  if(!isDefined(self.targetent)) {
    self.targetent = spawn("script_model", self.origin);
    self.targetent setModel("tag_origin");
  }

  thread _id_A9A8361DACE89499();
  tag = "tag_laser";

  if(!scripts\engine\utility::hastag(self.model, tag))
    tag = "tag_turret";

  loc = self gettagorigin(tag) + anglesToForward(self gettagangles(tag)) * 3000;
  self.targetent.origin = loc;
  self.targetent dontinterpolate();
  self settargetentity(self.targetent);

  if(isDefined(self._id_71F08AA4E6A5186E))
    self[[self._id_71F08AA4E6A5186E]]();
  else {
    _id_1E536FC02CE7881D = self._id_779C916529C44B1A.origin;
    _id_4D16D428538FF673 = self._id_779C916529C44B1A.angles;
    _id_878BAE61ACA86FC5 = anglesToForward(_id_4D16D428538FF673);
    _id_A1B727D30FC62A0F = anglestoup(_id_4D16D428538FF673);
    _id_77064C73F538EE42 = anglestoup(_id_4D16D428538FF673) * -1;
    _id_1B77E17A42E2545B = anglestoleft(_id_4D16D428538FF673);
    _id_6232855EBA31163A = anglestoright(_id_4D16D428538FF673);
    _id_07F870143D9150C8 = self._id_779C916529C44B1A._id_07F870143D9150C8;
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
    _id_D11155AF3EF22CB0 = vectortoangles(_id_77064C73F538EE42);
    _id_3C19D396E8243A45 = vectortoangles(_id_878BAE61ACA86FC5);
    _id_A0D15869F98EFC85 = vectortoangles(_id_1B77E17A42E2545B);
    _id_10972F86BC3D391E = vectortoangles(_id_6232855EBA31163A);

    if(!isDefined(_id_5EC17B72139BF948))
      _id_5EC17B72139BF948 = 10;

    if(istrue(_id_B19F85F4A1D36E2B())) {
      if(!self._id_779C916529C44B1A _id_A0857113D8C32A2A()) {
        _id_64109B7CBA5261EB(_id_3C19D396E8243A45, _id_5EC17B72139BF948, "fwd");
        _id_1DF98BFA8297278B(_id_3C19D396E8243A45);
        waitframe();

        for(;;) {
          _id_64109B7CBA5261EB(_id_D5C157BF3EFDA129, _id_5EC17B72139BF948, "up");
          _id_64109B7CBA5261EB(_id_3C19D396E8243A45, _id_5EC17B72139BF948, "fwd");
          _id_64109B7CBA5261EB(_id_D11155AF3EF22CB0, _id_5EC17B72139BF948, "down");
          _id_64109B7CBA5261EB(_id_3C19D396E8243A45, _id_5EC17B72139BF948, "fwd");
        }
      } else {
        _id_64109B7CBA5261EB(_id_3C19D396E8243A45, _id_5EC17B72139BF948, "fwd");
        _id_60D6FD7D2CC9347A(_id_3C19D396E8243A45);
      }
    } else {
      if(!self._id_779C916529C44B1A _id_A0857113D8C32A2A()) {
        _id_1E536FC02CE7881D = self gettagorigin(tag);
        _id_1B5EBB5A562AC4AC = anglesToForward(_id_3C19D396E8243A45);
        _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 2000;
        trace = scripts\engine\trace::ray_trace(_id_1E536FC02CE7881D, _id_6C53D859D582A421, self);
        end = trace["position"];
        _id_1995DCCCB8336733 = (_id_6C53D859D582A421[0], _id_6C53D859D582A421[1], _id_1E536FC02CE7881D[2]);
        _id_98C102BF3750C771 = (_id_1E536FC02CE7881D + end) / 2;
        thread _id_0A890D51E917AD74(1, _id_98C102BF3750C771);
        waitframe();
        _id_F7269954C1D2798A = 0;

        for(;;) {
          if(!istrue(_id_F7269954C1D2798A)) {
            _id_F7269954C1D2798A = 1;
            _id_C2659DB9DBFFDA55(_id_5A8F11024E7733A5, 0.2, "left");
          }

          _id_C2659DB9DBFFDA55(_id_5A8F11024E7733A5, _id_5EC17B72139BF948, "left");
          _id_C2659DB9DBFFDA55(_id_3C19D396E8243A45, _id_5EC17B72139BF948, "fwd");
          _id_C2659DB9DBFFDA55(_id_6B5BD2EB86959740, _id_5EC17B72139BF948, "right");
          _id_C2659DB9DBFFDA55(_id_3C19D396E8243A45, _id_5EC17B72139BF948, "fwd");
        }

        return;
      }

      tag = "bi_base";

      if(!scripts\engine\utility::hastag(self.model, tag))
        tag = "tag_turret";

      _id_1E536FC02CE7881D = self gettagorigin(tag);
      _id_1B5EBB5A562AC4AC = anglesToForward(_id_3C19D396E8243A45);
      _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 2000;
      trace = scripts\engine\trace::ray_trace(_id_1E536FC02CE7881D, _id_6C53D859D582A421, self);
      end = trace["position"];
      _id_1995DCCCB8336733 = (_id_6C53D859D582A421[0], _id_6C53D859D582A421[1], _id_1E536FC02CE7881D[2]);
      _id_98C102BF3750C771 = (_id_1E536FC02CE7881D + end) / 2;
      self.targetent moveTo(_id_1995DCCCB8336733, 7.0, 1.5, 1.5);
      thread _id_0A890D51E917AD74(undefined, _id_98C102BF3750C771);
    }
  }
}

_id_B19F85F4A1D36E2B() {
  return istrue(self._id_779C916529C44B1A._id_20868C2AF60860FA);
}

_id_60D6FD7D2CC9347A(_id_3C19D396E8243A45) {
  tag = "tag_laser";

  if(!scripts\engine\utility::hastag(self.model, tag))
    tag = "tag_laser";

  _id_1E536FC02CE7881D = self gettagorigin(tag);
  _id_1B5EBB5A562AC4AC = anglesToForward(_id_3C19D396E8243A45);
  _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 2000;
  trace = scripts\engine\trace::ray_trace(_id_1E536FC02CE7881D, _id_6C53D859D582A421, self);
  end = trace["position"];
  _id_1995DCCCB8336733 = _id_6C53D859D582A421;
  _id_98C102BF3750C771 = (_id_1E536FC02CE7881D + end) / 2;
  self.targetent moveTo(_id_1995DCCCB8336733, 7.0, 1.5, 1.5);
  thread _id_0A890D51E917AD74(undefined, _id_98C102BF3750C771);
}

_id_1DF98BFA8297278B(_id_3C19D396E8243A45) {
  tag = "tag_laser";

  if(!scripts\engine\utility::hastag(self.model, tag))
    tag = "tag_laser";

  _id_1E536FC02CE7881D = self gettagorigin(tag);
  _id_1B5EBB5A562AC4AC = anglesToForward(_id_3C19D396E8243A45);
  _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 2000;
  trace = scripts\engine\trace::ray_trace(_id_1E536FC02CE7881D, _id_6C53D859D582A421, self);
  end = trace["position"];
  _id_1995DCCCB8336733 = _id_6C53D859D582A421;
  _id_98C102BF3750C771 = (_id_1E536FC02CE7881D + end) / 2;
  self.targetent moveTo(_id_1995DCCCB8336733, 7.0, 1.5, 1.5);
  thread _id_0A890D51E917AD74(undefined, _id_98C102BF3750C771);
}

_id_64109B7CBA5261EB(angles, _id_91AE7188F4C06C96, _id_6BD4BE25BC2A569A) {
  _id_91AE7188F4C06C96 = 4;
  tag = "tag_laser";
  _id_1B5EBB5A562AC4AC = anglesToForward(angles);
  _id_1E536FC02CE7881D = self gettagorigin(tag) + _id_1B5EBB5A562AC4AC * 2;
  _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 666;
  _id_1995DCCCB8336733 = (_id_6C53D859D582A421[0], _id_6C53D859D582A421[1], _id_1E536FC02CE7881D[2]);
  _id_1995DCCCB8336733 = _id_6C53D859D582A421;
  movetime = _id_91AE7188F4C06C96 * 0.7;
  _id_93912C82C941F846 = _id_91AE7188F4C06C96 * 0.15;
  _id_DBFA2182FE49A2AF = _id_91AE7188F4C06C96 * 0.15;
  _id_BEFE3B57021A5FF8 = anglestoup(angles);
  _id_6F60BBBC177C23EB = scripts\cp\utility::vectortoanglessafe(_id_1B5EBB5A562AC4AC, _id_BEFE3B57021A5FF8);
  self.targetent moveTo(_id_1995DCCCB8336733, movetime, _id_93912C82C941F846, _id_DBFA2182FE49A2AF);

  if(getdvarint("dvar_69DE6D4D9BA136D1", 0)) {
    if(isDefined(_id_6BD4BE25BC2A569A))
      announcement(_id_6BD4BE25BC2A569A);

    level thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, _id_1995DCCCB8336733, _id_91AE7188F4C06C96, (1, 0, 0));
  }

  if(isDefined(self._id_779C916529C44B1A._id_D7A35FD5BD92CC60))
    wait(movetime);
  else
    wait(_id_91AE7188F4C06C96);
}

_id_C2659DB9DBFFDA55(angles, _id_91AE7188F4C06C96, _id_6BD4BE25BC2A569A) {
  if(!isDefined(_id_91AE7188F4C06C96))
    _id_91AE7188F4C06C96 = 4;

  tag = "bi_base";

  if(!scripts\engine\utility::hastag(self.model, tag))
    tag = "tag_turret";

  _id_1E536FC02CE7881D = self gettagorigin(tag);
  _id_1B5EBB5A562AC4AC = anglesToForward(angles);
  _id_6C53D859D582A421 = _id_1E536FC02CE7881D + _id_1B5EBB5A562AC4AC * 2000;
  _id_1995DCCCB8336733 = (_id_6C53D859D582A421[0], _id_6C53D859D582A421[1], _id_1E536FC02CE7881D[2]);
  movetime = _id_91AE7188F4C06C96 * 0.7;
  _id_93912C82C941F846 = _id_91AE7188F4C06C96 * 0.15;
  _id_DBFA2182FE49A2AF = _id_91AE7188F4C06C96 * 0.15;
  _id_BEFE3B57021A5FF8 = anglestoup(angles);
  _id_6F60BBBC177C23EB = scripts\cp\utility::vectortoanglessafe(_id_1B5EBB5A562AC4AC, _id_BEFE3B57021A5FF8);
  self.targetent moveTo(_id_1995DCCCB8336733, movetime, _id_93912C82C941F846, _id_DBFA2182FE49A2AF);

  if(getdvarint("dvar_69DE6D4D9BA136D1", 0)) {
    if(isDefined(_id_6BD4BE25BC2A569A))
      announcement(_id_6BD4BE25BC2A569A);

    level thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, _id_1995DCCCB8336733, _id_91AE7188F4C06C96, (1, 0, 0));
  }

  if(isDefined(self._id_779C916529C44B1A._id_D7A35FD5BD92CC60))
    wait(movetime);
  else
    wait(_id_91AE7188F4C06C96);
}

_id_653B0E1837DA3974(struct, delay) {
  level endon("game_ended");
  wait(delay);
  struct._id_C1ABC60CE5507E66._id_5D646DCC86509253 = level._effect["vfx_shdb_killstreak_tablet_02_lnd"];
  playFXOnTag(struct._id_C1ABC60CE5507E66._id_5D646DCC86509253, struct.fx, "tag_origin");
}

_id_2CC59EA2A67BD2F4(struct, turrets) {
  struct._id_C1ABC60CE5507E66 = spawn("script_model", struct.origin);
  struct._id_C1ABC60CE5507E66.angles = struct.angles;

  if(isDefined(level._id_9BF3C4B5835FA48F)) {
    struct._id_C1ABC60CE5507E66 setModel(level._id_9BF3C4B5835FA48F);
    waitframe();
    struct.fx = scripts\engine\utility::spawn_tag_origin(struct.origin, struct.angles);
    struct.fx show();
    waitframe();
    thread _id_653B0E1837DA3974(struct, 2);
  } else
    struct._id_C1ABC60CE5507E66 setModel("offhand_2h_wm_c4_v0");

  struct._id_C1ABC60CE5507E66._id_E40178EE59662442 = scripts\engine\utility::getStructArray(struct.target, "targetname");
  struct._id_C1ABC60CE5507E66.parent_struct = struct;
  struct._id_C1ABC60CE5507E66 makeusable();
  hintstring = &"COOP_GAME_PLAY/DISABLE_TRAP";
  struct._id_C1ABC60CE5507E66 setHintString(hintstring);
  struct._id_C1ABC60CE5507E66 setCursorHint("HINT_BUTTON");
  struct._id_C1ABC60CE5507E66 sethintdisplayrange(256);
  struct._id_C1ABC60CE5507E66 sethintdisplayfov(80);
  struct._id_C1ABC60CE5507E66 setuserange(64);
  struct._id_C1ABC60CE5507E66 setusefov(50);
  struct._id_C1ABC60CE5507E66 sethintonobstruction("hide");
  struct._id_C1ABC60CE5507E66 setuseholdduration("duration_short");
  struct._id_C1ABC60CE5507E66 thread _id_2DE9D0204A3AFB2E(struct);
  thread _id_52C16DDCA816E35F(struct, turrets);
  thread _id_FA30749284648339(struct, turrets);
  return struct._id_C1ABC60CE5507E66;
}

_id_FA30749284648339(struct, turrets) {
  wait 2;

  if(_id_EE8A913E5BAF0C5D()) {
    struct._id_C1ABC60CE5507E66 thread _id_E071EFF8292BE8D4();

    foreach(turret in turrets)
    turret thread _id_E071EFF8292BE8D4(struct._id_C1ABC60CE5507E66, 1);
  }
}

_id_1B0D0F614DDF4A43() {
  self endon("disconnect");
  self endon("end_irlaser_hints");
  self notify("show_irlaser_hint");
  self endon("show_irlaser_hint");
  level endon("kill_irlasertraps_thread");

  while(!isDefined(level._id_B39EB382281F2D25))
    waitframe();

  ent = level._id_B39EB382281F2D25;
  player = self;

  if(!isDefined(self._id_AD598507B33FA7EE))
    self._id_AD598507B33FA7EE = 1;

  ent._id_9E9D858AB478C9D3 = "irlaser_" + self._id_AD598507B33FA7EE;
  self notify("show_irlaser_hint" + ent._id_9E9D858AB478C9D3);
  self endon("show_irlaser_hint" + ent._id_9E9D858AB478C9D3);

  if(!isDefined(level._id_93C0CE22B61E1683))
    level._id_93C0CE22B61E1683 = [];

  level._id_93C0CE22B61E1683[ent._id_9E9D858AB478C9D3] = 0;
  self._id_AD598507B33FA7EE++;
  player._id_2AF69B114646DC71 = 0;

  for(;;) {
    if(_func_EAC0CD99C9C6D8EE() == "spotted") {
      wait 2;
      continue;
    }

    if(self istouching(ent)) {
      if(self isnightvisionon()) {
        wait 3;
        continue;
      }

      if(istrue(player._id_4935C7889506B68C)) {
        wait 3;
        continue;
      }

      if(player._id_2AF69B114646DC71 >= 2) {
        return;
      }
      _id_05D149987BB3C462 = _id_8117DBC7D87D715D(player);

      if(!isDefined(_id_05D149987BB3C462)) {
        wait 3;
        continue;
      }

      if(!istrue(level._id_93C0CE22B61E1683[ent._id_9E9D858AB478C9D3])) {
        level._id_93C0CE22B61E1683[ent._id_9E9D858AB478C9D3] = 1;
        num = randomintrange(1, 8);
        player._id_4935C7889506B68C = 1;
        player._id_2AF69B114646DC71++;

        switch (num) {
          case 1:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 2:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 3:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 4:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 5:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 6:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 7:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          default:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
        }

        ent thread _id_D522DBAEBCB26E26(16 * player._id_2AF69B114646DC71, self);
      }
    } else if(istrue(level._id_93C0CE22B61E1683[ent._id_9E9D858AB478C9D3]))
      level._id_93C0CE22B61E1683[ent._id_9E9D858AB478C9D3] = 0;

    wait 3;
  }
}

_id_8117DBC7D87D715D(player) {
  if(!isDefined(level._id_7B5771F0D3E048A0))
    return undefined;

  _id_D593621DD76B812C = scripts\engine\utility::getclosest(player.origin, level._id_7B5771F0D3E048A0, 96);

  if(isDefined(_id_D593621DD76B812C))
    return _id_D593621DD76B812C;
  else {
    foreach(struct in level._id_7B5771F0D3E048A0) {
      if(player scripts\engine\math::point_in_fov(struct.origin))
        return struct;

      foreach(turret in struct.turrets) {
        if(player scripts\engine\math::point_in_fov(turret._id_4CF58793CC4F1AD6.origin))
          return turret._id_4CF58793CC4F1AD6;

        if(player scripts\engine\trace::can_see_origin(turret.origin))
          return turret;
      }
    }
  }
}

_id_D522DBAEBCB26E26(delay, player) {
  self endon("end_irlaser_hints");
  player scripts\engine\utility::waittill_any_timeout_1(delay / 3, "night_vision_on");
  player clearhudtutorialmessage();
  player scripts\engine\utility::waittill_any_timeout_1(delay / 6, "night_vision_on");
  player._id_4935C7889506B68C = undefined;
  level._id_93C0CE22B61E1683[self._id_9E9D858AB478C9D3] = undefined;
}

_id_2DE9D0204A3AFB2E(parentstruct) {
  self endon("death");

  if(getdvarint("dvar_5820CD337A0495F5") != 0) {
    return;
  }
  self setCanDamage(1);
  self.health = 9999;
  self.maxhealth = 9999;
  self._id_ABBAA2FC2B3DA347 = 0;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker)) {
      continue;
    }
    if(meansofdeath == "MOD_GRENADE_SPLASH") {
      continue;
    }
    attacker thread _id_354C862768CFE202::updatedamagefeedback("hitturret", undefined, damage, 1);
    self._id_ABBAA2FC2B3DA347++;

    if(self._id_ABBAA2FC2B3DA347 < 2) {
      continue;
    }
    self.health = 9999;
    self.maxhealth = 9999;
    _id_FF03DED389B65A7D = parentstruct;

    foreach(turret in _id_FF03DED389B65A7D.turrets) {
      if(!turret._id_779C916529C44B1A _id_A0857113D8C32A2A())
        turret _id_0D33F98412123374(1);
      else
        turret _id_0D33F98412123374();

      thread _id_277B35006FAB38DD(turret);
    }

    if(isDefined(self)) {
      if(_id_EE8A913E5BAF0C5D())
        _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 thread _id_876BC60D7AD75112();

      playFX(level._effect["vfx_c4_explode"], self.origin);
      self delete();
    }

    return;
  }
}

_id_EE8A913E5BAF0C5D() {
  if(isDefined(level._id_9BF3C4B5835FA48F))
    return 0;

  if(getdvarint("dvar_7693C920BEBDB71B", 1) != 0)
    return 1;

  return 0;
}

_id_53DBC1C223362F47() {
  if(getdvarint("dvar_2648C1C97BDEDF8C", 0) != 0)
    return 1;

  return 0;
}

_id_52C16DDCA816E35F(struct, turrets) {
  struct._id_C1ABC60CE5507E66 endon("death");

  for(;;) {
    struct._id_C1ABC60CE5507E66 waittill("trigger", player);

    if(isPlayer(player)) {
      if(istrue(struct._id_C1ABC60CE5507E66._id_0788CF296B8CA51A)) {
        continue;
      }
      struct._id_C1ABC60CE5507E66 makeunusable();

      if(!isDefined(level._id_9BF3C4B5835FA48F))
        level thread _id_2A8FC67F80783750::_id_091BDCD29D2BCB28(struct, player);
      else
        killfxontag(struct._id_C1ABC60CE5507E66._id_5D646DCC86509253, struct.fx, "tag_origin");

      if(isDefined(level._id_0E0D2E656981CB02))
        playsoundatpos(struct.origin, level._id_0E0D2E656981CB02);
      else
        playsoundatpos(struct.origin, "cp_laser_disable");

      foreach(turret in turrets) {
        sentryturret_setinactive(turret);
        playFX(level._effect["vfx_laser_destroy_nvg"], turret.origin);
        start = turret gettagorigin("tag_laser");
        trace = scripts\engine\trace::ray_trace(start, turret.targetent.origin);
        end = trace["position"];
        playFX(level._effect["vfx_laser_destroy_end"], start);
        playFX(level._effect["vfx_laser_destroy_end"], end);
        turret setmode("sentry_offline");
        turret laseroff();

        if(_id_EE8A913E5BAF0C5D())
          turret thread _id_571C0F2116929A45();

        turret notify("stop_idle_movement");

        if(!turret._id_779C916529C44B1A _id_A0857113D8C32A2A())
          turret _id_0D33F98412123374(1);
        else
          turret _id_0D33F98412123374();

        if(_id_53DBC1C223362F47()) {
          if(isDefined(turret.targetent))
            turret.targetent delete();

          turret delete();
        }
      }

      if(_id_EE8A913E5BAF0C5D())
        struct._id_C1ABC60CE5507E66 thread _id_876BC60D7AD75112();

      scripts\engine\utility::flag_set("traps_defused_" + struct.script_noteworthy);
      return;
    }
  }
}

_id_876BC60D7AD75112() {
  if(isDefined(self.parent_struct.script_index)) {
    if(self.parent_struct.script_index == "0.5")
      stopFXOnTag(level._effect["vfx_c4_light_5"], self, "tag_fx");

    if(self.parent_struct.script_index == "1.75")
      stopFXOnTag(level._effect["vfx_c4_light_175"], self, "tag_fx");

    if(self.parent_struct.script_index == "2")
      stopFXOnTag(level._effect["vfx_c4_light_2"], self, "tag_fx");

    if(self.parent_struct.script_index == "3")
      stopFXOnTag(level._effect["vfx_c4_light_3"], self, "tag_fx");
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
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 2;
  _id_4A5D9D7667048BF3 = level._id_1EF9906CAD3258C9;

  if(isDefined(level._id_29BFEE4A5CE55C20))
    _id_4A5D9D7667048BF3 = level._id_29BFEE4A5CE55C20;

  for(;;) {
    start = self gettagorigin("tag_laser");
    nearby_players = sortbydistancecullbyradius(level.players, start, 1024);

    if(nearby_players.size == 0) {
      waitframe();
      continue;
    }

    _id_01D4621C77C9108F = getaiarray();
    trace = scripts\engine\trace::ray_trace(start, self.targetent.origin, undefined, undefined);
    end = trace["position"];
    _id_DB9C2822E3D940DC = lengthsquared(start - end);
    trace = scripts\engine\trace::ray_trace(start, end, _id_01D4621C77C9108F, _id_4A5D9D7667048BF3);

    if(isDefined(trace["entity"]) && trace["hittype"] == "hittype_entity") {
      _id_2056EE644F4C232A = trace["entity"] scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp\utility::_id_AAE723485E3B0E9D() && isDefined(level._id_F107BD5B4C54277E);

      if(isPlayer(trace["entity"]) || istrue(_id_2056EE644F4C232A) || isPlayer(trace["entity"].owner)) {
        player = trace["entity"];

        if(getdvarint("dvar_69CB90D22E939F4F", 0) == 0 || getdvarint("dvar_69CB90D22E939F4F", 0) == 2) {
          _id_FF03DED389B65A7D = self.parent_struct;

          if(isDefined(player) && isPlayer(player)) {
            player._id_230A3287F9AD2965 = 1;
            player.shouldskipdeathsshield = 1;
          }

          _id_FF03DED389B65A7D._id_C1ABC60CE5507E66._id_0788CF296B8CA51A = 1;

          if(isPlayer(player))
            player _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();

          playsoundatpos(_id_FF03DED389B65A7D.origin, "cp_laser_trigger");
          time = lookupsoundlength("cp_laser_trigger") * 0.001;

          if(_id_D416AC98347DE9CF()) {
            self setturretteam("allies");

            if(!isPlayer(player)) {
              if(isDefined(player.owner))
                player = player.owner;
            }

            self setturretowner(player);
            player.nocorpse = 1;
            player.skipcorpse = 1;
          }

          wait(time);
          playsoundatpos(_id_FF03DED389B65A7D.origin, "cp_laser_expl");

          foreach(_id_96B5BEF64547D4C2 in _id_FF03DED389B65A7D.turrets) {
            if(isDefined(_id_96B5BEF64547D4C2)) {
              radiusdamage(_id_96B5BEF64547D4C2._id_4CF58793CC4F1AD6.origin, 384, 666, 333, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");

              foreach(_id_9405DD2F9DE7366E in level.players) {
                if(distance(_id_9405DD2F9DE7366E.origin, _id_96B5BEF64547D4C2._id_4CF58793CC4F1AD6.origin) <= 384)
                  _id_9405DD2F9DE7366E._id_1983AF7858AA2ABA = 1;
              }
            }
          }

          waitframe();
          radiusdamage(_id_FF03DED389B65A7D.origin, 384, 666, 333, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
          playrumbleonposition("grenade_rumble", _id_FF03DED389B65A7D.origin);
          earthquake(0.45, 0.7, _id_FF03DED389B65A7D.origin, 800);
          level notify("trigger_reinforcements_if_applicable");

          if(!_id_D416AC98347DE9CF()) {
            playFX(level._effect["vfx_laser_destroy_nvg"], start);
            playFX(level._effect["vfx_laser_destroy_end"], start);
            playFX(level._effect["vfx_laser_destroy_nvg"], end);
            playFX(level._effect["vfx_laser_destroy_end"], end);
          }

          if(isPlayer(player))
            thread _id_2A8FC67F80783750::_id_3E2F7FDFD94F71BA(player);

          if(!_id_D416AC98347DE9CF()) {
            foreach(turret in _id_FF03DED389B65A7D.turrets) {
              if(!turret._id_779C916529C44B1A _id_A0857113D8C32A2A())
                turret _id_0D33F98412123374(1);
              else
                turret _id_0D33F98412123374();

              if(self != turret)
                thread _id_277B35006FAB38DD(turret);
            }

            if(isDefined(_id_FF03DED389B65A7D._id_C1ABC60CE5507E66)) {
              if(_id_EE8A913E5BAF0C5D())
                _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 thread _id_876BC60D7AD75112();

              playFX(level._effect["vfx_c4_explode"], _id_FF03DED389B65A7D._id_C1ABC60CE5507E66.origin);
              _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 makeunusable();

              if(isDefined(level._id_9BF3C4B5835FA48F)) {
                if(isDefined(_id_FF03DED389B65A7D._id_C1ABC60CE5507E66._id_5D646DCC86509253))
                  killfxontag(_id_FF03DED389B65A7D._id_C1ABC60CE5507E66._id_5D646DCC86509253, _id_FF03DED389B65A7D.fx, "tag_origin");
              }
            }

            thread _id_277B35006FAB38DD(self);
            return;
          } else {
            self setturretowner(undefined);
            self setturretteam("axis");
            self laseron();

            if(scripts\cp\utility::_id_AAE723485E3B0E9D()) {
              if(isPlayer(trace["entity"])) {} else if(isDefined(trace["entity"].id) && trace["entity"].id == "armor")
                trace["entity"] _id_511E19D41C23E8AA::supportbox_delete();
              else if(isDefined(trace["entity"].turrettype) && trace["entity"].turrettype == "sentry_turret")
                trace["entity"] notify("kill_turret");
              else if(isDefined(trace["entity"].weapon_name) && trace["entity"].weapon_name == "c4_mp")
                trace["entity"] delete();
              else if(isDefined(trace["entity"].weapon_name) && trace["entity"].weapon_name == "at_mine_mp")
                trace["entity"] delete();

              if(isDefined(level._id_F107BD5B4C54277E) && !istrue(level._id_CD59367309B1C64C))
                self[[level._id_F107BD5B4C54277E]](player, _id_FF03DED389B65A7D);
            }
          }
        }
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
  turret laseroff();
  turret notify("stop_idle_movement");
}

_id_A0857113D8C32A2A() {
  if(isDefined(self.script_groupname) && self.script_groupname == "nomove")
    return 1;

  return 0;
}

_id_E071EFF8292BE8D4(hintobj, _id_7CDBE41E37064DDB) {
  self endon("death");
  pos = self gettagorigin("tag_fx");

  if(istrue(_id_7CDBE41E37064DDB)) {
    self endon("stop_idle_movement");

    if(isDefined(hintobj.parent_struct.script_index)) {
      if(hintobj.parent_struct.script_index == "0.5")
        playFXOnTag(level._effect["vfx_turret_light_5"], self, "tag_fx");

      if(hintobj.parent_struct.script_index == "1.75")
        playFXOnTag(level._effect["vfx_turret_light_175"], self, "tag_fx");

      if(hintobj.parent_struct.script_index == "2")
        playFXOnTag(level._effect["vfx_turret_light_2"], self, "tag_fx");

      if(hintobj.parent_struct.script_index == "3")
        playFXOnTag(level._effect["vfx_turret_light_3"], self, "tag_fx");
    }
  } else if(isDefined(self.parent_struct.script_index)) {
    if(self.parent_struct.script_index == "0.5")
      playFXOnTag(level._effect["vfx_c4_light_5"], self, "tag_fx");

    if(self.parent_struct.script_index == "1.75")
      playFXOnTag(level._effect["vfx_c4_light_175"], self, "tag_fx");

    if(self.parent_struct.script_index == "2")
      playFXOnTag(level._effect["vfx_c4_light_2"], self, "tag_fx");

    if(self.parent_struct.script_index == "3")
      playFXOnTag(level._effect["vfx_c4_light_3"], self, "tag_fx");
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
  if(!isDefined(self._id_4CF58793CC4F1AD6)) {
    return;
  }
  if(!istrue(_id_F095DF44CB4D44C3))
    self._id_4CF58793CC4F1AD6 stoploopsound("cp_laser_idle");
  else
    self._id_4CF58793CC4F1AD6 stoploopsound("cp_laser_mvmt");

  self._id_4CF58793CC4F1AD6 delete();
}

_id_D416AC98347DE9CF() {
  return istrue(level._id_608454029F3370F2);
}