/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\laser_traps\cp_laser_traps.gsc
*****************************************************/

main() {
  init_laser_trap();
}

init_laser_trap() {
  level.scripted_laser_func = ::laser_func;
}

load_laser_fx() {
  level._effect["vfx_drone_explo"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
  level._effect["smoke_pipe"] = loadfx("vfx/iw8_cp/raid/vfx_cp_steampipe_exp.vfx");
  level._effect["vfx_bullet_impact"] = loadfx("vfx/test/tracey/bullet_impact.vfx");
  level._effect["vfx_blood_spurt"] = loadfx("vfx/test/tracey/blood_spurt_large.vfx");
  level._effect["vfx_blood_screen_right"] = loadfx("vfx/iw8/level/highway/vfx_blood_screen_right.vfx");
  level._effect["vfx_blood_screen_left"] = loadfx("vfx/iw8/level/highway/vfx_blood_screen_left.vfx");
  level._effect["vfx_illumination_flare_unlit"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_unlit.vfx");
  level._effect["vfx_illumination_flare"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare.vfx");
  level._effect["vfx_illumination_flare_launch_trail"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_launch_trail.vfx");
  level._effect["vfx_laser_pointer"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp.vfx");
  level._effect["vfx_laser_pointer_thermal"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_thermalonly.vfx");
  level._effect["vfx_laser_pointer_nvg"] = loadfx("vfx/iw9/cp/vfx_red_laser_cp_nvgonly.vfx");
  level._effect["vfx_laser_destroy"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_destroy.vfx");
  level._effect["vfx_cp_iw8_water_elec"] = loadfx("vfx/iw8_cp/elec/vfx_cp_iw8_water_elec.vfx");
}

laser_func() {
  level endon("game_ended");
  spawn_pos = self.origin;

  if(self.ent tagexists("tag_laser"))
    spawn_pos = self.ent gettagorigin("tag_laser");

  self.laser_start_ent_thermal = create_tag_origin(spawn_pos, self);
  self.laser_reset_position = self.laser_start_ent_thermal.origin;
  trace = scripts\engine\trace::ray_trace(spawn_pos, spawn_pos + anglestoup(self.angles) * int(self.struct.height));
  self.laser_end_ent_thermal = create_tag_origin(trace["position"], self);
  self.laser_show_position = self.laser_end_ent_thermal.origin;
  self.fx_thermal_end = spawnfx(level._effect["vfx_raid_laser_burn"], self.laser_show_position);
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
    result = scripts\engine\utility::waittill_any_return_3("cleanup_target_nvg", "hide_laser", "show_laser");

    if(isDefined(result)) {
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

init_laser_traps() {
  triggers = getEntArray("cs_trigger", "targetname");
  level.laser_trap_triggers = [];
  level.laser_traps_saved_origins = [];

  foreach(trigger in triggers) {
    if(!isDefined(trigger.target)) {
      if(scripts\engine\utility::array_contains(level.laser_traps_saved_origins, trigger.origin)) {
        trigger delete();
        continue;
      }

      level.laser_traps_saved_origins = scripts\engine\utility::array_add(level.laser_traps_saved_origins, trigger.origin);
      continue;
    }

    if(trigger.script_noteworthy != "laser_trap_trigger") {
      if(scripts\engine\utility::array_contains(level.laser_traps_saved_origins, trigger.origin)) {
        trigger delete();
        continue;
      }

      level.laser_traps_saved_origins = scripts\engine\utility::array_add(level.laser_traps_saved_origins, trigger.origin);
      continue;
    }

    if(scripts\engine\utility::array_contains(level.laser_traps_saved_origins, trigger.origin)) {
      trigger delete();

      if(isDefined(trigger.target)) {
        ent = getEnt(trigger.target, "targetname");

        if(isDefined(ent))
          ent delete();
      }

      continue;
    }

    level.laser_traps_saved_origins = scripts\engine\utility::array_add(level.laser_traps_saved_origins, trigger.origin);
    ent = getEnt(trigger.target, "targetname");
    ent.origin = trigger.origin;

    if(trigger.classname == "trigger_radius" || trigger.classname == "trigger_rotatable_radius")
      trigger enablelinkTo();

    trigger linkTo(ent);
    ent.trigger = trigger;
    trigger.ent = ent;
    trigger initialize_laser_trap_entity(1);
    ent initialize_laser_trap_entity();
    level.laser_trap_triggers = scripts\engine\utility::array_add(level.laser_trap_triggers, trigger);
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
      if(isDefined(level.scripted_laser_func))
        self thread[[level.scripted_laser_func]]();

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
    if(isDefined(self.trigger.struct.script_groupname) && self.trigger.struct.script_groupname == "toggle_fx")
      thread watch_for_damage_on_trap();
    else {
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

watch_for_damage_on_trap() {
  self endon("death");
  self setCanDamage(1);
  self.health = 9999;
  self.maxhealth = 9999;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker)) {
      continue;
    }
    if(meansofdeath == "MOD_GRENADE_SPLASH") {
      continue;
    }
    if(istrue(self.suppressedlaser)) {
      continue;
    }
    self.health = 9999;
    self.maxhealth = 9999;
    playFX(level._effect["vfx_laser_destroy"], self.trigger.laser_start_ent_thermal.origin);
    playFX(level._effect["vfx_laser_destroy"], self.trigger.laser_end_ent_thermal.origin);
    attacker thread _id_354C862768CFE202::updatedamagefeedback("hitturret", undefined, damage, 1);
    radiusdamage(self.trigger.laser_start_ent_thermal.origin, 256, 666, 133);
    radiusdamage(self.trigger.laser_end_ent_thermal.origin, 256, 666, 133);
    level notify("start_floor_spawners");
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
  self.suppressedlaser = undefined;
}

trap_trigger_logic(_id_C0D7A5FB530D544A) {
  self notify("trap_trigger_logic");
  self endon("trap_trigger_logic");
  self endon("death");

  if(istrue(_id_C0D7A5FB530D544A)) {}

  for(;;) {
    self waittill("trigger", entity);

    if(self.struct.script_groupname != "toggle_fx") {
      if(self.current_state == 333)
        continue;
    }

    if(!isPlayer(entity) && !isai(entity)) {
      continue;
    }
    if(isDefined(self.ent)) {
      if(istrue(self.ent.suppressedlaser))
        continue;
    }

    if(isPlayer(entity)) {
      entity push_players_back_and_deal_damage(entity);
      entity dodamage(entity.health + 10000, entity.origin);

      if(self.struct.script_groupname == "toggle_fx") {
        playFX(level._effect["vfx_laser_destroy"], self.laser_start_ent_thermal.origin);
        playFX(level._effect["vfx_laser_destroy"], self.laser_end_ent_thermal.origin);
        radiusdamage(self.laser_start_ent_thermal.origin, 256, 666, 133);
        radiusdamage(self.laser_end_ent_thermal.origin, 256, 666, 133);
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
    playFX(level._effect["smoke_pipe"], self.origin - (0, -8, 16), anglesToForward(self.angles), anglestoright(self.angles));
    childthread scripts\engine\utility::play_loop_sound_on_entity("fire_system_hiss");
    childthread scripts\cp\utility::play_sound_on_entity("fire_system_start");
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

    if(isDefined(level.scripted_laser_func))
      self thread[[level.scripted_laser_func]]();
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