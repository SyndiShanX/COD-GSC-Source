/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_razer_gun.gsc
*****************************************************************/

init() {
  var_3 = (34.222, -0.23, 0);
  var_4 = length(var_3);
  var_5 = [];
  var_5[16]["noGib"] = 1;
  level._id_6DF9["default"]["razergun_zm"]["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  level._id_6DF9["default"]["razergun_zm"]["hit_zombie_action"] = "pain_paired_melee";
  level._id_6DF9["default"]["razergun_zm"]["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  level._id_6DF9["default"]["razergun_zm"]["fatal_zombie_action"] = "death_melee_razergun_zm";
  level._id_6DF9["default"]["razergun_zm"]["dismemberment_override"] = var_5;
  level._id_6DF9["default"]["razergun_zm"]["fatal_zombie_pos"] = var_3;
  level._id_6DF9["default"]["razergun_zm"]["fatal_zombie_dist"] = var_4;
  level._id_6DF9["heavy"]["razergun_zm"]["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  level._id_6DF9["heavy"]["razergun_zm"]["hit_zombie_action"] = "pain_paired_melee_razergun_zm";
  level._id_6DF9["heavy"]["razergun_zm"]["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  level._id_6DF9["heavy"]["razergun_zm"]["fatal_zombie_action"] = "death_melee_heavy_razergun_zm";
  level._id_6DF9["heavy"]["razergun_zm"]["dismemberment_override"] = var_5;
  level._id_6DF9["heavy"]["razergun_zm"]["fatal_zombie_pos"] = var_3;
  level._id_6DF9["heavy"]["razergun_zm"]["fatal_zombie_dist"] = var_4;
  level._id_6DF9["heavy"]["razergun_zm"]["no_flinch_time"] = 4;
  level._id_6DF9["default"]["razergun_melee_zm"] = level._id_6DF9["default"]["razergun_zm"];
  level._id_6DF9["heavy"]["razergun_melee_zm"] = level._id_6DF9["heavy"]["razergun_zm"];
  level._id_6DF9["default"]["razergun_pap_zm"] = level._id_6DF9["default"]["razergun_zm"];
  level._id_6DF9["heavy"]["razergun_pap_zm"] = level._id_6DF9["heavy"]["razergun_zm"];
  common_scripts\utility::_id_092C("razergun_projectile", "vfx/zombie/prototype_fx/razergun_projectile");
  common_scripts\utility::_id_092C("razergun_projectile_trail", "vfx/zombie/prototype_fx/razergun_projectile_trail");
  common_scripts\utility::_id_092C("zmb_razergun_white_trail", "vfx/map/mp_zombie_island/zmb_razergun_white_trail");
  common_scripts\utility::_id_092C("zmb_razergun_white_trail", "vfx/map/mp_zombie_island/zmb_razergun_white_trail_int");
  common_scripts\utility::_id_092C("zmb_razergun_cyan_trail", "vfx/map/mp_zombie_island/zmb_razergun_cyan_trail");
  common_scripts\utility::_id_092C("zmb_razergun_cyan_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_cyan_trail_int");
  common_scripts\utility::_id_092C("zmb_razergun_magenta_trail", "vfx/map/mp_zombie_island/zmb_razergun_magenta_trail");
  common_scripts\utility::_id_092C("zmb_razergun_magenta_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_magenta_trail_int");
  common_scripts\utility::_id_092C("zmb_razergun_yellow_trail", "vfx/map/mp_zombie_island/zmb_razergun_yellow_trail");
  common_scripts\utility::_id_092C("zmb_razergun_yellow_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_yellow_trail_int");
  common_scripts\utility::_id_092C("zmb_razergun_blue_trail", "vfx/map/mp_zombie_island/zmb_razergun_blue_trail");
  common_scripts\utility::_id_092C("zmb_razergun_blue_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_blue_trail_int");
  common_scripts\utility::_id_092C("zmb_razergun_green_trail", "vfx/map/mp_zombie_island/zmb_razergun_green_trail");
  common_scripts\utility::_id_092C("zmb_razergun_green_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_green_trail_int");
  common_scripts\utility::_id_092C("zmb_razergun_red_trail_runner", "vfx/map/mp_zombie_island/zmb_razergun_red_trail_runner");
  common_scripts\utility::_id_092C("zmb_razergun_red_trail", "vfx/map/mp_zombie_island/zmb_razergun_red_trail");
  common_scripts\utility::_id_092C("zmb_razergun_red_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_red_trail_int");
  common_scripts\utility::_id_092C("razergun_projectile_assassin", "vfx/zombie/prototype_fx/razergun_projectile_assassin");
  level._id_A9C8["razergun_melee_zm"] = ::razergun_heavy_melee_fatal;
  level._id_A9C8["razergun_zm"] = ::razergun_heavy_melee_fatal;
  level._id_A9C8["razergun_pap_zm"] = ::razergun_heavy_melee_fatal;
  level thread razergun_monitor();
  _id_0547::_id_7BA9(::monitor_razergun_kills);
  level.razer_touch_trigs = [];
  var_6 = getEntArray("trigger_multiple", "classname");

  if(!common_scripts\utility::_id_3C83("ripsaw_punch_active")) {
    common_scripts\utility::flag_init("ripsaw_punch_active");
  }

  foreach(var_8 in var_6) {
    if(isDefined(var_8._id_81C7) && var_8._id_81C7 == "razergun_blade_listener") {
      level.razer_touch_trigs[level.razer_touch_trigs.size] = var_8;
    }
  }

  level thread maps\mp\_utility::_id_6F74(::notify_razergun_fired);
  level thread maps\mp\_utility::_id_6F74(::notify_razergun_loaded);
  level thread maps\mp\_utility::_id_6F74(::notify_razergun_picked_up);
  level thread maps\mp\_utility::_id_6F74(::notify_razergun_taken);
}

get_razergun_melee_cost() {
  return 2250;
}

get_razergun_ranged_cost() {
  return 3000;
}

notify_razergun_fired() {
  for(;;) {
    self waittill("missile_fire", var_0, var_1);
    thread handle_sawgun_state_change("fired", var_1, 0);
  }
}

notify_razergun_loaded(var_0) {
  for(;;) {
    self waittill("reload");
    thread handle_sawgun_state_change("reloaded", self getcurrentweapon(), 1);
  }
}

notify_razergun_picked_up() {
  for(;;) {
    self waittill("weapon_switch_started", var_0);

    if(var_0 == "razergun_melee_zm") {
      thread handle_sawgun_state_change("switching to melee sawgun", var_0, 1);
      continue;
    }

    if(var_0 != "razergun_zm") {
      thread handle_sawgun_state_change("switching to other weapon", self getcurrentweapon(), 0);
      continue;
    }

    while(self getcurrentweapon() != "razergun_zm") {
      waitframe();
    }

    if(self getcurrentweaponclipammo() == 0) {
      continue;
    }
    thread handle_sawgun_state_change("switching to loaded sawgun", var_0, 1);
  }
}

notify_razergun_taken() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("weapon_taken", var_1);

    if(!issubstr(var_1, "razergun") || common_scripts\utility::_id_562E(var_0.isupgradingrazergunmodel)) {
      continue;
    }
    if(var_0 _meth_82D5() == "none") {
      var_2 = _id_0548::_id_454B(var_0, "shovel_zm");
      var_0 _id_0586::_id_078C(var_2);
      var_0 _id_0586::_id_078E(var_2);
    }
  }
}

handle_sawgun_state_change(var_0, var_1, var_2) {
  if(!_id_0547::_id_5565("razergun_zm", var_1) && !_id_0547::_id_5565("razergun_melee_zm", var_1) && !_id_0547::_id_5565("razergun_pap_zm", var_1)) {
    return;
  }
  if(var_2) {
    _id_0378::_id_8D74("aud_ripsaw_start_spinning");
  } else {
    _id_0378::_id_8D74("aud_ripsaw_stop_spinning");
  }
}

razergun_heavy_melee_fatal(var_0) {
  _id_0378::_id_8D74("ripsaw_fatal_melee");
  return common_scripts\utility::_id_562E(self._id_165B) || self adsButtonPressed();
}

razergun_monitor() {
  for(;;) {
    level waittill("player_spawned", var_0);
    var_0 thread override_razer_projectile();
    var_0 thread razer_charge_watcher();
    var_0 thread razer_bayochargewatcher();
  }
}

razer_charge_watcher() {
  self endon("death");
  self endon("disconnect");
  self notify("razer_charge_watcher");
  self endon("razer_charge_watcher");
  var_0 = common_scripts\utility::_id_5D92(0.05, 0, 1, 1, 1045);
  var_1 = common_scripts\utility::_id_5D92(1.0, 0, 1, 32, 128);
  self waittill("sprint_melee_charge_attack");

  for(;;) {
    do_electric_charge(var_0, var_1);
    self waittill("sprint_melee_charge_attack");
  }
}

razer_bayochargewatcher() {
  self endon("death");
  self endon("disconnect");
  self notify("razer_bayoCharge_watcher");
  self endon("razer_bayoCharge_watcher");

  for(;;) {
    self waittill("sprint_melee_charge_begin");
    var_0 = self getcurrentweapon();

    if(isDefined(var_0) && !issubstr(var_0, "razergun")) {
      return;
    }
    self.israzerguncharging = 1;
    togglemarathonability(0);
    maps\mp\_utility::_id_0735("specialty_marathon");
    _id_0380::_id_6844("wpn_ripsaw_bayonet_charge_start", undefined, self);
    self.razer_bayochargestophandle = _id_0380::_id_6844("wpn_ripsaw_bayonet_charge_loop", undefined, self, 0.2);
    thread razer_bayochargedeathtracking();
  }
}

razer_bayochargedeathtracking() {
  self endon("disconnect");
  var_0 = common_scripts\utility::waittill_any_return("death", "sprint_melee_charge_end", "sprint_melee_charge_attack");
  self.israzerguncharging = 0;
  togglemarathonability(1);

  if(var_0 == "sprint_melee_charge_end" && isDefined(self)) {
    _id_0380::_id_6850(self.razer_bayochargestophandle, 0.3);
    _id_0380::_id_6844("wpn_ripsaw_bayonet_charge_end", undefined, self);
  } else if(isDefined(self))
    _id_0380::_id_6850(self.razer_bayochargestophandle, 0.1);
}

togglemarathonability(var_0) {
  if(!_id_056A::_id_4B7E("runperk")) {
    return;
  }
  if(var_0) {
    maps\mp\_utility::giveperk("specialty_marathon");
  } else {
    maps\mp\_utility::_id_0735("specialty_marathon");
  }
}

zombie_on_electric_charge() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_44F5("zmb_elec_cherry_zombie");
  var_2 = var_0.origin + (0, 0, 40);
  playFX(var_1, var_2);
}

do_electric_charge(var_0, var_1) {
  var_2 = self.origin;
  var_3 = self getcurrentweapon();

  if(isDefined(var_3) && !issubstr(var_3, "razergun_zm") && !issubstr(var_3, "razergun_pap_zm")) {
    return;
  }
  playFX(common_scripts\utility::_id_44F5("zmb_elec_cherry_wv"), var_2);
  _id_0378::_id_8D74("electric_cherry_vfx");
  _playfxontagforclients(common_scripts\utility::_id_44F5("zmb_elec_cherry_player"), self, "J_Spine4", self);
  _id_053A::mini_stunning_burst_execute(var_2, self, var_1, 0.7, undefined, undefined, "zombie_fireman", ::zombie_on_electric_charge);
}

override_razer_projectile() {
  self endon("death");
  self endon("disconnect");
  self notify("razer_override_projectile");
  self endon("razer_override_projectile");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(isDefined(var_1) && issubstr(var_1, "razergun_zm") || issubstr(var_1, "razergun_pap_zm")) {
      var_0 transform_razer_projectile(self, var_1);
    }
  }
}

transform_razer_projectile(var_0, var_1, var_2, var_3) {
  self.is_razergun_projectile = 1;
  self.total_kills = 0;
  self.damage_players = common_scripts\utility::_id_562E(var_3);
  thread handle_reflection(var_0, var_1, var_2);
  thread handle_razer_blade_touch();
}

handle_reflection(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");
  var_3 = get_projectile_path();
  thread play_fx_on_razergun_projectile("razergun_projectile");

  if(!isDefined(self.current_trail_fx)) {
    if(!isDefined(var_2)) {
      var_2 = "zmb_razergun_red_trail";
    }

    var_4 = _id_055A::_id_4562(self.origin);

    if(_id_0547::_id_5565(var_4, "sub_pens_1_zone")) {
      if(isDefined(level._effect[var_2 + "_int"])) {
        var_2 = var_2 + "_int";
      }
    }

    thread play_fx_on_razergun_projectile(var_2);
    self.current_trail_fx = var_2;
  }

  childthread do_zombie_damage_better(var_0, self, var_1);
}

handle_razer_blade_touch() {
  self endon("death");
  self endon("entitydeleted");
  self endon("remove");
  self endon("missile_stuck");

  if(!isDefined(self)) {
    return;
  }
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(level.razer_touch_trigs)) {
      foreach(var_1 in level.razer_touch_trigs) {
        if(!isDefined(var_1) || _isremovedentity(var_1)) {
          level.razer_touch_trigs = common_scripts\utility::_id_0F93(level.razer_touch_trigs, var_1);
          continue;
        }

        if(self istouching(var_1)) {
          var_1 notify("razer_blade_touched", self);
        }
      }
    }

    waitframe();
  }
}

get_razorgun_gunname() {
  return "razergun";
}

sqrd_dist_between_segments(var_0, var_1, var_2, var_3) {
  var_4 = 0.000001;
  var_5 = var_3 - var_2;
  var_6 = var_1 - var_0;
  var_7 = var_0 - var_2;
  var_8 = vectordot(var_5, var_5);
  var_9 = vectordot(var_6, var_6);
  var_10 = vectordot(var_6, var_5);
  var_11 = vectordot(var_5, var_7);
  var_12 = vectordot(var_6, var_7);
  var_13 = var_8 * var_9 - var_10 * var_10;
  var_14 = 0;
  var_15 = 0;

  if(var_13 <= var_4) {
    if(var_10 > var_8) {
      var_14 = var_12 / var_10;
    } else {
      var_14 = var_11 / var_8;
    }
  } else {
    var_14 = (var_11 * var_9 - var_10 * var_12) / var_13;
    var_15 = (var_10 * var_11 - var_12 * var_8) / var_13;
  }

  var_14 = clamp(var_14, 0.0, 1.0);
  var_15 = clamp(var_15, 0.0, 1.0);
  var_16 = var_2 + var_5 * var_14;
  var_17 = var_0 + var_6 * var_15;
  var_18 = var_17 - var_16;
  var_19 = vectordot(var_18, var_18);
  return var_19;
}

do_zombie_trace_damage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 15;
  var_6 = 10;
  var_7 = (var_5 + var_6) * (var_5 + var_6);
  var_8 = _id_0547::_id_408F();

  if(common_scripts\utility::_id_562E(self.damage_players)) {
    var_8 = level.players;
  }

  foreach(var_10 in var_8) {
    if(sqrd_dist_between_segments(var_0, var_1, var_10.origin, var_10.origin + (0, 0, 60)) <= var_7) {
      if(common_scripts\utility::_id_562E(var_10.ripsaw_hardened)) {
        var_10 dodamage(400.0, self.origin, var_2, var_3, undefined, var_4);
        continue;
      }

      if(!isDefined(var_10.zombie_shielding_func) && !common_scripts\utility::_id_562E(self.damage_players) && common_scripts\utility::_id_562E(var_10._id_0A4B == "zombie_generic" || var_10._id_0A4B == "zombie_berserker" || var_10._id_0A4B == "zombie_exploder")) {
        var_10 dodamage(var_10.health + 1, self.origin, var_2, var_3, undefined, var_4);
        continue;
      }

      if(_id_0547::_id_5565(var_10._id_0A4B, "zombie_assassin") && isDefined(var_10.assassinabilityactivateaction)) {
        var_10 dodamage(1800.0, self.origin, var_2, var_3, undefined, var_4);
        continue;
      }

      var_10 dodamage(4000, self.origin, var_2, var_3, undefined, var_4);
    }
  }
}

watch_for_bounces(var_0, var_1, var_2) {
  for(;;) {
    self waittill("projectile_bounce", var_2, var_3, var_4, var_5);
    do_zombie_trace_damage(self.razer_old_pos, var_3, var_0, var_1, var_2);
    self.razer_old_pos = var_3;
  }
}

do_zombie_damage_better(var_0, var_1, var_2) {
  self.razer_old_pos = self.origin;
  childthread watch_for_bounces(var_0, var_1, var_2);

  while(isDefined(self)) {
    waitframe();
    waittillframeend;

    if(isDefined(self)) {
      do_zombie_trace_damage(self.razer_old_pos, self.origin, var_0, var_1, var_2);
      self.razer_old_pos = self.origin;
    }
  }
}

do_zombie_damage_inefficient(var_0, var_1, var_2) {
  while(isDefined(self)) {
    var_3 = _id_0547::_id_408F();

    foreach(var_5 in var_3) {
      if(distance(var_5.origin + (0, 0, 48), self.origin) < 32) {
        if(common_scripts\utility::_id_562E(var_5._id_0A4B == "zombie_generic" || var_5._id_0A4B == "zombie_berserker" || var_5._id_0A4B == "zombie_exploder")) {
          var_5 dodamage(var_5.health + 1, self.origin, var_0, var_1, undefined, var_2);
          continue;
        }

        var_5 dodamage(4000, self.origin, var_0, var_1, undefined, var_2);
      }
    }

    waitframe();
  }
}

get_projectile_path() {
  var_0 = self.origin;
  waitframe();
  var_1 = self.origin;
  return 10000 * vectorNormalize(anglesToForward(vectortoangles(var_1 - var_0)));
}

draw_destination() {
  while(isDefined(self)) {
    var_0 = self.origin;
    wait 0.125;
    var_1 = self.origin;

    if(!isDefined(var_1)) {
      break;
    }

    var_2 = vectorNormalize(anglesToForward(vectortoangles(var_1 - var_0)));
  }
}

monitor_razergun_kills(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isPlayer(var_1)) {
    return;
  }
  if(!issubstr(var_4, "razergun_zm") && !issubstr(var_4, "razergun_pap_zm")) {
    return;
  }
  if(isDefined(var_0) && common_scripts\utility::_id_562E(var_0.is_razergun_projectile)) {
    var_0.total_kills++;

    if(var_0.total_kills == 13 && maps\mp\_utility::_id_4571() == "mp_zombie_island") {
      var_1 maps\mp\gametypes\zombies::_id_47C8("DLC1_ZM_BAKERS");
    }

    if(var_0 should_razgun_expire(var_0.total_kills, var_4)) {
      var_0 thread delete_the_projectile();
    }
  }
}

should_razgun_expire(var_0, var_1) {
  if(maps\mp\_utility::gameflag("insta_kill")) {
    return 0;
  }

  if(issubstr(var_1, "razergun_pap_zm")) {
    return var_0 >= 20;
  }

  if(issubstr(var_1, "razergun_zm")) {
    return var_0 >= 3;
  }

  return 0;
}

delete_the_projectile() {
  _killfxontag(common_scripts\utility::_id_44F5("razergun_projectile"), self, "tag_origin");
  _killfxontag(common_scripts\utility::_id_44F5(self.current_trail_fx), self, "tag_origin");
  self delete();
}

play_fx_on_razergun_projectile(var_0) {
  _playFXOnTag(common_scripts\utility::_id_44F5(var_0), self, "tag_origin");
}