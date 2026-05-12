/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_razer_gun.gsc
*********************************************************/

func_00D5() {
  var_03 = (34.222, -0.23, 0);
  var_04 = length(var_03);
  var_05 = [];
  var_05[16]["noGib"] = 1;
  level.var_6DF9["default"]["razergun_zm"]["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  level.var_6DF9["default"]["razergun_zm"]["hit_zombie_action"] = "pain_paired_melee";
  level.var_6DF9["default"]["razergun_zm"]["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  level.var_6DF9["default"]["razergun_zm"]["fatal_zombie_action"] = "death_melee_razergun_zm";
  level.var_6DF9["default"]["razergun_zm"]["dismemberment_override"] = var_05;
  level.var_6DF9["default"]["razergun_zm"]["fatal_zombie_pos"] = var_03;
  level.var_6DF9["default"]["razergun_zm"]["fatal_zombie_dist"] = var_04;
  level.var_6DF9["heavy"]["razergun_zm"]["hit_worldmodel_anim"] = "va_melee_shovel_zom_hit_world";
  level.var_6DF9["heavy"]["razergun_zm"]["hit_zombie_action"] = "pain_paired_melee_razergun_zm";
  level.var_6DF9["heavy"]["razergun_zm"]["fatal_worldmodel_anim"] = "va_melee_shovel_zom_hit_crit_world";
  level.var_6DF9["heavy"]["razergun_zm"]["fatal_zombie_action"] = "death_melee_heavy_razergun_zm";
  level.var_6DF9["heavy"]["razergun_zm"]["dismemberment_override"] = var_05;
  level.var_6DF9["heavy"]["razergun_zm"]["fatal_zombie_pos"] = var_03;
  level.var_6DF9["heavy"]["razergun_zm"]["fatal_zombie_dist"] = var_04;
  level.var_6DF9["heavy"]["razergun_zm"]["no_flinch_time"] = 4;
  level.var_6DF9["default"]["razergun_melee_zm"] = level.var_6DF9["default"]["razergun_zm"];
  level.var_6DF9["heavy"]["razergun_melee_zm"] = level.var_6DF9["heavy"]["razergun_zm"];
  level.var_6DF9["default"]["razergun_pap_zm"] = level.var_6DF9["default"]["razergun_zm"];
  level.var_6DF9["heavy"]["razergun_pap_zm"] = level.var_6DF9["heavy"]["razergun_zm"];
  common_scripts\utility::func_092C("razergun_projectile", "vfx/zombie/prototype_fx/razergun_projectile");
  common_scripts\utility::func_092C("razergun_projectile_trail", "vfx/zombie/prototype_fx/razergun_projectile_trail");
  common_scripts\utility::func_092C("zmb_razergun_white_trail", "vfx/map/mp_zombie_island/zmb_razergun_white_trail");
  common_scripts\utility::func_092C("zmb_razergun_white_trail", "vfx/map/mp_zombie_island/zmb_razergun_white_trail_int");
  common_scripts\utility::func_092C("zmb_razergun_cyan_trail", "vfx/map/mp_zombie_island/zmb_razergun_cyan_trail");
  common_scripts\utility::func_092C("zmb_razergun_cyan_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_cyan_trail_int");
  common_scripts\utility::func_092C("zmb_razergun_magenta_trail", "vfx/map/mp_zombie_island/zmb_razergun_magenta_trail");
  common_scripts\utility::func_092C("zmb_razergun_magenta_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_magenta_trail_int");
  common_scripts\utility::func_092C("zmb_razergun_yellow_trail", "vfx/map/mp_zombie_island/zmb_razergun_yellow_trail");
  common_scripts\utility::func_092C("zmb_razergun_yellow_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_yellow_trail_int");
  common_scripts\utility::func_092C("zmb_razergun_blue_trail", "vfx/map/mp_zombie_island/zmb_razergun_blue_trail");
  common_scripts\utility::func_092C("zmb_razergun_blue_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_blue_trail_int");
  common_scripts\utility::func_092C("zmb_razergun_green_trail", "vfx/map/mp_zombie_island/zmb_razergun_green_trail");
  common_scripts\utility::func_092C("zmb_razergun_green_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_green_trail_int");
  common_scripts\utility::func_092C("zmb_razergun_red_trail_runner", "vfx/map/mp_zombie_island/zmb_razergun_red_trail_runner");
  common_scripts\utility::func_092C("zmb_razergun_red_trail", "vfx/map/mp_zombie_island/zmb_razergun_red_trail");
  common_scripts\utility::func_092C("zmb_razergun_red_trail_int", "vfx/map/mp_zombie_island/zmb_razergun_red_trail_int");
  common_scripts\utility::func_092C("razergun_projectile_assassin", "vfx/zombie/prototype_fx/razergun_projectile_assassin");
  level.var_A9C8["razergun_melee_zm"] = ::razergun_heavy_melee_fatal;
  level.var_A9C8["razergun_zm"] = ::razergun_heavy_melee_fatal;
  level.var_A9C8["razergun_pap_zm"] = ::razergun_heavy_melee_fatal;
  level thread razergun_monitor();
  lib_0547::func_7BA9(::monitor_razergun_kills);
  level.razer_touch_trigs = [];
  var_06 = getEntArray("trigger_multiple", "classname");
  if(!common_scripts\utility::func_3C83("ripsaw_punch_active")) {
    common_scripts\utility::func_3C87("ripsaw_punch_active");
  }

  foreach(var_08 in var_06) {
    if(isDefined(var_08.var_81C7) && var_08.var_81C7 == "razergun_blade_listener") {
      level.razer_touch_trigs[level.razer_touch_trigs.size] = var_08;
    }
  }

  level thread maps\mp\_utility::func_6F74(::notify_razergun_fired);
  level thread maps\mp\_utility::func_6F74(::notify_razergun_loaded);
  level thread maps\mp\_utility::func_6F74(::notify_razergun_picked_up);
  level thread maps\mp\_utility::func_6F74(::notify_razergun_taken);
}

get_razergun_melee_cost() {
  return 2250;
}

get_razergun_ranged_cost() {
  return 3000;
}

notify_razergun_fired() {
  for(;;) {
    self waittill("missile_fire", var_00, var_01);
    thread handle_sawgun_state_change("fired", var_01, 0);
  }
}

notify_razergun_loaded(param_00) {
  for(;;) {
    self waittill("reload");
    thread handle_sawgun_state_change("reloaded", self getcurrentweapon(), 1);
  }
}

notify_razergun_picked_up() {
  for(;;) {
    self waittill("weapon_switch_started", var_00);
    if(var_00 == "razergun_melee_zm") {
      thread handle_sawgun_state_change("switching to melee sawgun", var_00, 1);
      continue;
    }

    if(var_00 != "razergun_zm") {
      thread handle_sawgun_state_change("switching to other weapon", self getcurrentweapon(), 0);
      continue;
    }

    while(self getcurrentweapon() != "razergun_zm") {
      wait 0.05;
    }

    if(self getcurrentweaponclipammo() == 0) {
      continue;
    }

    thread handle_sawgun_state_change("switching to loaded sawgun", var_00, 1);
  }
}

notify_razergun_taken() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("weapon_taken", var_01);
    if(!issubstr(var_01, "razergun") || common_scripts\utility::func_562E(var_00.isupgradingrazergunmodel)) {
      continue;
    }

    if(var_00 method_82D5() == "none") {
      var_02 = maps\mp\zombies\_zombies_magicbox::func_454B(var_00, "shovel_zm");
      var_00 lib_0586::func_078C(var_02);
      var_00 lib_0586::func_078E(var_02);
    }
  }
}

handle_sawgun_state_change(param_00, param_01, param_02) {
  if(!lib_0547::func_5565("razergun_zm", param_01) && !lib_0547::func_5565("razergun_melee_zm", param_01) && !lib_0547::func_5565("razergun_pap_zm", param_01)) {
    return;
  }

  if(param_02) {
    lib_0378::func_8D74("aud_ripsaw_start_spinning");
    return;
  }

  lib_0378::func_8D74("aud_ripsaw_stop_spinning");
}

razergun_heavy_melee_fatal(param_00) {
  lib_0378::func_8D74("ripsaw_fatal_melee");
  return common_scripts\utility::func_562E(self.var_165B) || self adsButtonPressed();
}

razergun_monitor() {
  for(;;) {
    level waittill("player_spawned", var_00);
    var_00 thread override_razer_projectile();
    var_00 thread razer_charge_watcher();
    var_00 thread razer_bayochargewatcher();
  }
}

razer_charge_watcher() {
  self endon("death");
  self endon("disconnect");
  self notify("razer_charge_watcher");
  self endon("razer_charge_watcher");
  var_00 = common_scripts\utility::func_5D92(0.05, 0, 1, 1, 1045);
  var_01 = common_scripts\utility::func_5D92(1, 0, 1, 32, 128);
  self waittill("sprint_melee_charge_attack");
  for(;;) {
    do_electric_charge(var_00, var_01);
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
    var_00 = self getcurrentweapon();
    if(isDefined(var_00) && !issubstr(var_00, "razergun")) {
      return;
    }

    self.israzerguncharging = 1;
    togglemarathonability(0);
    maps\mp\_utility::func_0735("specialty_marathon");
    lib_0380::func_6844("wpn_ripsaw_bayonet_charge_start", undefined, self);
    self.razer_bayochargestophandle = lib_0380::func_6844("wpn_ripsaw_bayonet_charge_loop", undefined, self, 0.2);
    thread razer_bayochargedeathtracking();
  }
}

razer_bayochargedeathtracking() {
  self endon("disconnect");
  var_00 = common_scripts\utility::func_A715("death", "sprint_melee_charge_end", "sprint_melee_charge_attack");
  self.israzerguncharging = 0;
  togglemarathonability(1);
  if(var_00 == "sprint_melee_charge_end" && isDefined(self)) {
    lib_0380::func_6850(self.razer_bayochargestophandle, 0.3);
    lib_0380::func_6844("wpn_ripsaw_bayonet_charge_end", undefined, self);
    return;
  }

  if(isDefined(self)) {
    lib_0380::func_6850(self.razer_bayochargestophandle, 0.1);
  }
}

togglemarathonability(param_00) {
  if(!lib_056A::func_4B7E("runperk")) {
    return;
  }

  if(param_00) {
    maps\mp\_utility::func_47A2("specialty_marathon");
    return;
  }

  maps\mp\_utility::func_0735("specialty_marathon");
}

zombie_on_electric_charge() {
  var_00 = self;
  var_01 = common_scripts\utility::func_44F5("zmb_elec_cherry_zombie");
  var_02 = var_00.var_0116 + (0, 0, 40);
  playFX(var_01, var_02);
}

do_electric_charge(param_00, param_01) {
  var_02 = self.var_0116;
  var_03 = self getcurrentweapon();
  if(isDefined(var_03) && !issubstr(var_03, "razergun_zm") && !issubstr(var_03, "razergun_pap_zm")) {
    return;
  }

  playFX(common_scripts\utility::func_44F5("zmb_elec_cherry_wv"), var_02);
  lib_0378::func_8D74("electric_cherry_vfx");
  playfxontagforclients(common_scripts\utility::func_44F5("zmb_elec_cherry_player"), self, "J_Spine4", self);
  lib_053A::mini_stunning_burst_execute(var_02, self, param_01, 0.7, undefined, undefined, "zombie_fireman", ::zombie_on_electric_charge);
}

override_razer_projectile() {
  self endon("death");
  self endon("disconnect");
  self notify("razer_override_projectile");
  self endon("razer_override_projectile");
  for(;;) {
    self waittill("missile_fire", var_00, var_01);
    if((isDefined(var_01) && issubstr(var_01, "razergun_zm")) || issubstr(var_01, "razergun_pap_zm")) {
      var_00 transform_razer_projectile(self, var_01);
    }
  }
}

transform_razer_projectile(param_00, param_01, param_02, param_03) {
  self.is_razergun_projectile = 1;
  self.total_kills = 0;
  self.damage_players = common_scripts\utility::func_562E(param_03);
  thread handle_reflection(param_00, param_01, param_02);
  thread handle_razer_blade_touch();
}

handle_reflection(param_00, param_01, param_02) {
  self endon("death");
  self endon("entitydeleted");
  var_03 = get_projectile_path();
  thread play_fx_on_razergun_projectile("razergun_projectile");
  if(!isDefined(self.current_trail_fx)) {
    if(!isDefined(param_02)) {
      param_02 = "zmb_razergun_red_trail";
    }

    var_04 = lib_055A::func_4562(self.var_0116);
    if(lib_0547::func_5565(var_04, "sub_pens_1_zone")) {
      if(isDefined(level.var_0611[param_02 + "_int"])) {
        param_02 = param_02 + "_int";
      }
    }

    thread play_fx_on_razergun_projectile(param_02);
    self.current_trail_fx = param_02;
  }

  childthread do_zombie_damage_better(param_00, self, param_01);
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
      foreach(var_01 in level.razer_touch_trigs) {
        if(!isDefined(var_01) || function_0279(var_01)) {
          level.razer_touch_trigs = common_scripts\utility::func_0F93(level.razer_touch_trigs, var_01);
          continue;
        }

        if(self istouching(var_01)) {
          var_01 notify("razer_blade_touched", self);
        }
      }
    }

    wait 0.05;
  }
}

get_razorgun_gunname() {
  return "razergun";
}

sqrd_dist_between_segments(param_00, param_01, param_02, param_03) {
  var_04 = 1E-06;
  var_05 = param_03 - param_02;
  var_06 = param_01 - param_00;
  var_07 = param_00 - param_02;
  var_08 = vectordot(var_05, var_05);
  var_09 = vectordot(var_06, var_06);
  var_0A = vectordot(var_06, var_05);
  var_0B = vectordot(var_05, var_07);
  var_0C = vectordot(var_06, var_07);
  var_0D = var_08 * var_09 - var_0A * var_0A;
  var_0E = 0;
  var_0F = 0;
  if(var_0D <= var_04) {
    if(var_0A > var_08) {
      var_0E = var_0C / var_0A;
    } else {
      var_0E = var_0B / var_08;
    }
  } else {
    var_0E = var_0B * var_09 - var_0A * var_0C / var_0D;
    var_0F = var_0A * var_0B - var_0C * var_08 / var_0D;
  }

  var_0E = clamp(var_0E, 0, 1);
  var_0F = clamp(var_0F, 0, 1);
  var_10 = param_02 + var_05 * var_0E;
  var_11 = param_00 + var_06 * var_0F;
  var_12 = var_11 - var_10;
  var_13 = vectordot(var_12, var_12);
  return var_13;
}

do_zombie_trace_damage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 15;
  var_06 = 10;
  var_07 = var_05 + var_06 * var_05 + var_06;
  var_08 = lib_0547::func_408F();
  if(common_scripts\utility::func_562E(self.damage_players)) {
    var_08 = level.var_744A;
  }

  foreach(var_0A in var_08) {
    if(sqrd_dist_between_segments(param_00, param_01, var_0A.var_0116, var_0A.var_0116 + (0, 0, 60)) <= var_07) {
      if(common_scripts\utility::func_562E(var_0A.ripsaw_hardened)) {
        var_0A dodamage(400, self.var_0116, param_02, param_03, undefined, param_04);
        continue;
      }

      if(!isDefined(var_0A.zombie_shielding_func) && !common_scripts\utility::func_562E(self.damage_players) && common_scripts\utility::func_562E(var_0A.var_0A4B == "zombie_generic" || var_0A.var_0A4B == "zombie_berserker" || var_0A.var_0A4B == "zombie_exploder")) {
        var_0A dodamage(var_0A.var_00BC + 1, self.var_0116, param_02, param_03, undefined, param_04);
        continue;
      }

      if(lib_0547::func_5565(var_0A.var_0A4B, "zombie_assassin") && isDefined(var_0A.assassinabilityactivateaction)) {
        var_0A dodamage(1800, self.var_0116, param_02, param_03, undefined, param_04);
        continue;
      }

      var_0A dodamage(4000, self.var_0116, param_02, param_03, undefined, param_04);
    }
  }
}

watch_for_bounces(param_00, param_01, param_02) {
  for(;;) {
    self waittill("projectile_bounce", param_02, var_03, var_04, var_05);
    do_zombie_trace_damage(self.razer_old_pos, var_03, param_00, param_01, param_02);
    self.razer_old_pos = var_03;
  }
}

do_zombie_damage_better(param_00, param_01, param_02) {
  self.razer_old_pos = self.var_0116;
  childthread watch_for_bounces(param_00, param_01, param_02);
  while(isDefined(self)) {
    wait 0.05;
    waittillframeend;
    if(isDefined(self)) {
      do_zombie_trace_damage(self.razer_old_pos, self.var_0116, param_00, param_01, param_02);
      self.razer_old_pos = self.var_0116;
    }
  }
}

do_zombie_damage_inefficient(param_00, param_01, param_02) {
  while(isDefined(self)) {
    var_03 = lib_0547::func_408F();
    foreach(var_05 in var_03) {
      if(distance(var_05.var_0116 + (0, 0, 48), self.var_0116) < 32) {
        if(common_scripts\utility::func_562E(var_05.var_0A4B == "zombie_generic" || var_05.var_0A4B == "zombie_berserker" || var_05.var_0A4B == "zombie_exploder")) {
          var_05 dodamage(var_05.var_00BC + 1, self.var_0116, param_00, param_01, undefined, param_02);
          continue;
        }

        var_05 dodamage(4000, self.var_0116, param_00, param_01, undefined, param_02);
      }
    }

    wait 0.05;
  }
}

get_projectile_path() {
  var_00 = self.var_0116;
  wait 0.05;
  var_01 = self.var_0116;
  return 10000 * vectornormalize(anglesToForward(vectortoangles(var_01 - var_00)));
}

draw_destination() {
  while(isDefined(self)) {
    var_00 = self.var_0116;
    wait(0.125);
    var_01 = self.var_0116;
    if(!isDefined(var_01)) {
      break;
    }

    var_02 = vectornormalize(anglesToForward(vectortoangles(var_01 - var_00)));
  }
}

monitor_razergun_kills(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isPlayer(param_01)) {
    return;
  }

  if(!issubstr(param_04, "razergun_zm") && !issubstr(param_04, "razergun_pap_zm")) {
    return;
  }

  if(isDefined(param_00) && common_scripts\utility::func_562E(param_00.is_razergun_projectile)) {
    param_00.total_kills++;
    if(param_00.total_kills == 13 && maps\mp\_utility::func_4571() == "mp_zombie_island") {
      param_01 maps\mp\gametypes\zombies::func_47C8("DLC1_ZM_BAKERS");
    }

    if(param_00 should_razgun_expire(param_00.total_kills, param_04)) {
      param_00 thread delete_the_projectile();
    }
  }
}

should_razgun_expire(param_00, param_01) {
  if(maps\mp\_utility::func_3FA0("insta_kill")) {
    return 0;
  }

  if(issubstr(param_01, "razergun_pap_zm")) {
    return param_00 >= 20;
  }

  if(issubstr(param_01, "razergun_zm")) {
    return param_00 >= 3;
  }

  return 0;
}

delete_the_projectile() {
  killfxontag(common_scripts\utility::func_44F5("razergun_projectile"), self, "tag_origin");
  killfxontag(common_scripts\utility::func_44F5(self.current_trail_fx), self, "tag_origin");
  self delete();
}

play_fx_on_razergun_projectile(param_00) {
  playFXOnTag(common_scripts\utility::func_44F5(param_00), self, "tag_origin");
}