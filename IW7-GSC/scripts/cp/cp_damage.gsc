/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_damage.gsc
************************************/

updatedamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level.friendly_damage_check) && [[level.friendly_damage_check]](var_4, var_5, var_6)) {
    return;
  }

  if(!isplayer(self)) {
    return;
  }

  var_7 = "standard_cp";
  var_8 = undefined;
  if(isDefined(var_1) && var_1) {
    self playlocalsound("cp_hit_alert_strong");
  } else if(scripts\engine\utility::istrue(self.deadeye_charge)) {
    self playlocalsound("cp_hit_alert_perk");
  } else {
    self playlocalsound("cp_hit_alert");
  }

  switch (var_0) {
    case "hitalienarmor":
      self setclientomnvar("damage_feedback_icon", var_0);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      var_3 = 1;
      break;

    case "hitcritical":
    case "hitaliensoft":
      var_8 = 1;
      break;

    case "stun":
    case "meleestun":
      if(!isDefined(self.meleestun)) {
        self playlocalsound("crate_impact");
        self.meleestun = 1;
      }

      self setclientomnvar("damage_feedback_icon", "hitcritical");
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      wait(0.2);
      self.meleestun = undefined;
      break;

    case "high_damage":
      var_7 = "high_damage_cp";
      break;

    case "special_weapon":
      var_7 = "wor_weapon_cp";
      break;

    case "card_boosted":
      var_7 = "fnf_card_damage_cp";
      break;

    case "red_arcane_cp":
      var_7 = "red_arcane_cp";
      break;

    case "blue_arcane_cp":
      var_7 = "blue_arcane_cp";
      break;

    case "yellow_arcane_cp":
      var_7 = "yellow_arcane_cp";
      break;

    case "green_arcane_cp":
      var_7 = "green_arcane_cp";
      break;

    case "pink_arcane_cp":
      var_7 = "pink_arcane_cp";
      break;

    case "dewdrops_cp":
      var_7 = "dewdrops_cp";
      break;

    case "none":
      break;

    default:
      break;
  }

  updatehitmarker(var_7, var_8, var_2, var_3, var_1);
}

onplayertouchkilltrigger(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(level.gameended == 1) {
    return;
  }

  if(kill_trigger_event_was_processed()) {
    return;
  }

  set_kill_trigger_event_processed(self, 1);
  scripts\cp\cp_laststand::callback_defaultplayerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, scripts\cp\cp_globallogic::func_7F56());
}

kill_trigger_event_was_processed() {
  return scripts\engine\utility::istrue(self.kill_trigger_event_processed);
}

set_kill_trigger_event_processed(var_0, var_1) {
  self.kill_trigger_event_processed = var_1;
}

updatehitmarker(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self setclientomnvar("damage_scale_type", "standard");
  if(var_4) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(var_3) {
    self setclientomnvar("damage_scale_type", "hitalienarmor");
  }

  if(var_1) {
    self setclientomnvar("damage_scale_type", "hitaliensoft");
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(isDefined(var_2)) {
    self setclientomnvar("ui_damage_amount", int(var_2));
  }

  self setclientomnvar("damage_feedback", var_0);
  self setclientomnvar("damage_feedback_notify", gettime());
}

func_1118C(var_0, var_1, var_2) {
  scripts\engine\utility::waitframe();
  playFXOnTag(level._effect["stun_attack"], var_0.stun_struct.attack_bolt, "TAG_ORIGIN");
  playFXOnTag(level._effect["stun_shock"], var_0.stun_struct.attack_bolt, "TAG_ORIGIN");
  var_3 = undefined;
  if(isDefined(self.agent_type) && scripts\cp\cp_agent_utils::get_agent_type(self) == "seeder_spore") {
    var_3 = self gettagorigin("J_Spore_46");
  } else if(isDefined(self) && isalive(self) && scripts\cp\utility::has_tag(self.model, "J_SpineUpper")) {
    var_3 = self gettagorigin("J_SpineUpper");
  }

  if(isDefined(var_3)) {
    var_0.stun_struct.attack_bolt moveto(var_3, 0.05);
    wait(0.05);
    if(isDefined(self) && var_2 == "MOD_MELEE") {
      self playSound("trap_electric_shock");
    }

    wait(0.05);
    var_4 = int(var_1 / 2);
    if(isDefined(self)) {
      var_5 = self;
      if(isDefined(self.agent_type) && scripts\cp\cp_agent_utils::get_agent_type(self) == "seeder_spore") {
        var_5 = self.var_4353;
      }

      if(isDefined(var_5)) {
        var_5 dodamage(var_4, self.origin, var_0, var_0.stun_struct.attack_bolt, var_2);
      }
    }
  }

  stopFXOnTag(level._effect["stun_attack"], var_0.stun_struct.attack_bolt, "TAG_ORIGIN");
}

func_F29B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(var_1 == "xm25_mp" && var_0 == "MOD_IMPACT") {
      var_2 = 95;
    }

    if(var_1 == "spider_beam_mp") {
      var_2 = var_2 * 15;
    }

    if(var_1 == "alienthrowingknife_mp" && var_0 == "MOD_IMPACT") {
      if(can_hypno(var_3, 0, var_4, var_0, var_1, var_5, var_6, var_7, var_8, var_9)) {
        var_2 = 20000;
      } else if(scripts\cp\cp_agent_utils::get_agent_type(self) != "elite") {
        var_2 = 500;
      }
    }
  }

  return var_2;
}

can_hypno(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.var_38E0) && self.var_38E0) {
    return 0;
  }

  switch (self.agent_type) {
    case "seeder":
    case "locust":
    case "spitter":
    case "brute":
    case "goon4":
    case "goon3":
    case "goon2":
    case "goon":
      return 1;

    case "elite":
      if(var_0 scripts\cp\utility::is_upgrade_enabled("hypno_rhino_upgrade") || var_1) {
        return 1;
      }

      break;

    default:
      return 0;
  }
}

scale_alien_damage_by_perks(var_0, var_1, var_2, var_3) {
  var_4 = 1.05;
  if(scripts\engine\utility::isbulletdamage(var_2) && !func_9D39(var_3) && !func_9DB8(var_3)) {
    if(!func_9D39(var_3)) {
      var_1 = int(var_1 * var_0 scripts\cp\perks\perk_utility::perk_getbulletdamagescalar());
    } else if(func_9D38(var_3)) {
      var_1 = int(var_1 * var_0 scripts\cp\perks\perk_utility::func_CA43());
    }

    if(isDefined(var_0.var_1517)) {
      var_1 = int(var_1 * var_0.var_1517);
    }
  }

  if(var_2 == "MOD_EXPLOSIVE") {
    var_1 = int(var_1 * var_0 scripts\cp\perks\perk_utility::perk_getexplosivedamagescalar());
  }

  if(var_2 == "MOD_MELEE") {
    if(should_play_melee_blood_vfx(var_0)) {
      playFXOnTag(level._effect["melee_blood"], var_0, "tag_weapon_right");
    }

    var_1 = int(var_1 * var_0 scripts\cp\perks\perk_utility::perk_getmeleescalar());
    if(isDefined(var_0.var_1518)) {
      var_1 = int(var_1 * var_0.var_1518);
    }
  }

  if(var_0 scripts\cp\utility::is_upgrade_enabled("damage_booster_upgrade")) {
    var_1 = int(var_1 * var_4);
  }

  return var_1;
}

should_play_melee_blood_vfx(var_0) {
  if(isDefined(level.should_play_melee_blood_vfx_func)) {
    return [[level.should_play_melee_blood_vfx_func]](var_0);
  }

  return 1;
}

func_9D39(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "ball_drone_gun_mp":
    case "turret_minigun_alien_shock":
    case "alientank_rigger_turret_mp":
    case "alientank_turret_mp":
    case "turret_minigun_alien_grenade":
    case "turret_minigun_alien_railgun":
    case "turret_minigun_alien":
    case "alien_manned_minigun_turret4_mp":
    case "alien_manned_minigun_turret3_mp":
    case "alien_manned_minigun_turret2_mp":
    case "alien_manned_minigun_turret1_mp":
    case "alien_manned_minigun_turret_mp":
    case "alien_manned_gl_turret4_mp":
    case "alien_manned_gl_turret3_mp":
    case "alien_manned_gl_turret2_mp":
    case "alien_manned_gl_turret1_mp":
    case "alien_manned_gl_turret_mp":
    case "sentry_minigun_mp":
    case "alien_sentry_minigun_4_mp":
    case "alien_sentry_minigun_3_mp":
    case "alien_sentry_minigun_2_mp":
    case "alien_sentry_minigun_1_mp":
    case "alienvulture_mp":
    case "alien_ball_drone_gun4_mp":
    case "alien_ball_drone_gun3_mp":
    case "alien_ball_drone_gun2_mp":
    case "alien_ball_drone_gun1_mp":
    case "alien_ball_drone_gun_mp":
      return 1;

    default:
      return 0;
  }

  return 0;
}

func_9DB8(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "iw6_alienminigun4_mp":
    case "iw6_alienminigun3_mp":
    case "iw6_alienminigun2_mp":
    case "iw6_alienminigun1_mp":
    case "iw6_alienminigun_mp":
      return 1;

    default:
      return 0;
  }

  return 0;
}

func_9D38(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "alientank_rigger_turret_mp":
    case "alientank_turret_mp":
    case "turret_minigun_alien_grenade":
    case "turret_minigun_alien_railgun":
    case "turret_minigun_alien":
      return 1;

    default:
      return 0;
  }

  return 0;
}

scale_alien_damage_by_weapon_type(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && var_4 != "none") {
    var_1 = func_3D84(self, var_1, var_0, var_3, var_2);
  }

  if(isDefined(var_2) && var_2 == "MOD_EXPLOSIVE_BULLET" && var_4 != "none") {
    if(scripts\cp\utility::coop_getweaponclass(var_3) == "weapon_shotgun") {
      var_1 = var_1 + int(var_1 * level.shotgundamagemod);
    } else {
      var_1 = var_1 + int(var_1 * level.exploimpactmod);
    }
  }

  return var_1;
}

scale_alien_damage_by_prestige(var_0, var_1) {
  if(isplayer(var_0)) {
    var_2 = var_0 scripts\cp\perks\prestige::prestige_getweapondamagescalar();
    var_1 = var_1 * var_2;
    var_1 = int(var_1);
  }

  return var_1;
}

func_3D84(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 500;
  if(!isDefined(var_0) || !scripts\cp\utility::isreallyalive(var_0)) {
    return var_1;
  }

  if(!isDefined(var_2) || !isplayer(var_2) || var_4 != "MOD_EXPLOSIVE_BULLET") {
    return var_1;
  }

  if(scripts\cp\utility::coop_getweaponclass(var_3) == "weapon_shotgun") {
    var_6 = distance(var_2.origin, var_0.origin);
    var_7 = max(1, var_6 / var_5);
    var_8 = var_1 * 8;
    var_9 = var_8 * var_7;
    if(var_6 > var_5) {
      return var_1;
    }

    return int(var_9);
  }

  return var_5;
}

check_for_special_damage(var_0, var_1, var_2) {
  if(var_2 == "MOD_MELEE" && weapontype(var_1) != "riotshield") {
    return;
  }

  if(isDefined(var_1) && var_1 == "alienims_projectile_mp") {
    return;
  }

  if(!isDefined(var_0.is_burning) && isalive(var_0)) {
    if((scripts\cp\utility::player_has_special_ammo(self, "incendiary_ammo") || scripts\cp\utility::player_has_special_ammo(self, "combined_ammo")) && var_2 != "MOD_UNKNOWN") {
      var_0 thread catch_alien_on_fire(self, undefined, undefined, 1);
    } else if(var_1 == "iw5_alienriotshield4_mp" && self.fireshield == 1) {
      var_0 thread catch_alien_on_fire(self);
    } else if((scripts\engine\utility::istrue(self.var_8B86) || scripts\engine\utility::istrue(self.var_8BAC)) && var_2 != "MOD_UNKNOWN") {
      var_0 thread catch_alien_on_fire(self, undefined, undefined, 1);
    }

    switch (var_1) {
      case "iw6_alienmk323_mp":
      case "iw6_alienmk324_mp":
      case "iw6_alienminigun4_mp":
      case "iw6_alienminigun3_mp":
      case "alien_manned_gl_turret4_mp":
      case "alienvulture_mp":
        var_0 thread catch_alien_on_fire(self);
        break;
    }

    return;
  }

  var_3 = scripts\cp\utility::getrawbaseweaponname(var_1);
  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[var_3]) && self.special_ammocount[var_3] > 0) {}
}

catch_alien_on_fire(var_0, var_1, var_2, var_3) {
  self endon("death");
  alien_fire_on();
  damage_alien_over_time(var_0, var_1, var_2, var_3);
  alien_fire_off();
}

damage_alien_over_time(var_0, var_1, var_2, var_3) {
  self endon("death");
  if(!isDefined(var_1) && !isDefined(var_2)) {
    var_4 = scripts\cp\cp_agent_utils::get_agent_type(self);
    switch (var_4) {
      case "goon4":
      case "goon3":
      case "goon2":
      case "goon":
        var_2 = 75;
        var_1 = 3;
        break;

      case "brute4":
      case "brute3":
      case "brute2":
      case "brute":
        var_2 = 100;
        var_1 = 4;
        break;

      case "spitter":
        var_2 = 133;
        var_1 = 4;
        break;

      case "elite_boss":
      case "elite":
        var_2 = 500;
        var_1 = 4;
        break;

      case "minion":
        var_2 = 100;
        var_1 = 2;
        break;

      default:
        var_2 = self.maxhealth * 0.5;
        var_1 = 3;
        break;
    }
  } else {
    if(!isDefined(var_2)) {
      var_2 = 150;
    }

    if(!isDefined(var_1)) {
      var_1 = 3;
    }
  }

  if(isDefined(var_0) && isDefined(var_3) && var_0 scripts\cp\utility::is_upgrade_enabled("incendiary_ammo_upgrade") && isDefined(var_3)) {
    var_2 = var_2 * 1.2;
  }

  var_2 = var_2 * level.alien_health_per_player_scalar[level.players.size];
  var_5 = 0;
  var_6 = 6;
  var_7 = var_1 / var_6;
  var_8 = var_2 / var_6;
  for(var_9 = 0; var_9 < var_6; var_9++) {
    wait(var_7);
    if(isalive(self)) {
      self dodamage(var_8, self.origin, var_0, var_0, "MOD_UNKNOWN");
    }
  }
}

alien_fire_on() {
  if(!isDefined(self.is_burning)) {
    self.is_burning = 0;
  }

  self.is_burning++;
  if(self.is_burning == 1 && self.species == "alien") {
    if(isDefined(self.agent_type) && self.agent_type != "minion") {
      self setscriptablepartstate("animpart", "burning");
    }
  }
}

alien_fire_off() {
  self.is_burning--;
  if(self.is_burning > 0) {
    return;
  }

  self.is_burning = undefined;
  self notify("fire_off");
  if(self.species == "alien") {
    self setscriptablepartstate("animpart", "normal");
  }
}

update_damage_score(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(level.var_24B8) || var_1 != level.var_24B8) {
    if(isDefined(var_1) && isDefined(var_1.triggerportableradarping)) {
      scripts\cp\cp_agent_utils::store_attacker_info(var_1.triggerportableradarping, var_2 * 0.75);
    } else if(isDefined(var_1) && isDefined(var_1.pet) && var_1.pet == 1) {
      scripts\cp\cp_agent_utils::store_attacker_info(var_1.triggerportableradarping, var_2);
    } else {
      scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);
    }

    if(isDefined(var_1) && isDefined(var_5)) {
      if(isDefined(level.var_12D86)) {
        level thread[[level.var_12D86]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self);
      }
    }
  }

  update_zombie_damage_challenge(var_1, var_2, var_4);
}

update_zombie_damage_challenge(var_0, var_1, var_2) {
  if(isDefined(level.update_zombie_damage_challenge)) {
    [[level.update_zombie_damage_challenge]](var_0, var_1, var_2);
  }
}

handlemissiledamage(var_0, var_1, var_2) {
  var_3 = var_2;
  switch (var_0) {
    case "iw6_panzerfaust3_mp":
    case "aamissile_projectile_mp":
    case "maverick_projectile_mp":
    case "drone_hive_projectile_mp":
    case "bomb_site_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "odin_projectile_small_rod_mp":
    case "odin_projectile_large_rod_mp":
      self.largeprojectiledamage = 1;
      var_3 = self.maxhealth + 1;
      break;

    case "hind_missile_mp":
    case "hind_bomb_mp":
    case "remote_tank_projectile_mp":
    case "switch_blade_child_mp":
      self.largeprojectiledamage = 0;
      var_3 = self.maxhealth + 1;
      break;

    case "heli_pilot_turret_mp":
    case "a10_30mm_turret_mp":
      self.largeprojectiledamage = 0;
      var_3 = var_3 * 2;
      break;

    case "sam_projectile_mp":
      self.largeprojectiledamage = 1;
      var_3 = var_2;
      break;
  }

  return var_3;
}

handlegrenadedamage(var_0, var_1, var_2) {
  if(isexplosivedamagemod(var_1)) {
    switch (var_0) {
      case "iw6_rgm_mp":
      case "proximity_explosive_mp":
      case "c4_zm":
        var_2 = var_2 * 3;
        break;

      case "iw6_mk32_mp":
      case "semtexproj_mp":
      case "bouncingbetty_mp":
      case "semtex_zm":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_2 = var_2 * 4;
        break;

      default:
        if(scripts\cp\utility::isstrstart(var_0, "alt_")) {
          var_2 = var_2 * 3;
        }
        break;
    }
  }

  return var_2;
}

handleapdamage(var_0, var_1, var_2, var_3) {
  if(var_1 == "MOD_RIFLE_BULLET" || var_1 == "MOD_PISTOL_BULLET") {
    if(var_3 scripts\cp\utility::_hasperk("specialty_armorpiercing") || scripts\cp\utility::isfmjdamage(var_0, var_1, var_3)) {
      return var_2 * level.armorpiercingmod;
    }
  }

  return var_2;
}

onkillstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0;
  var_8 = undefined;
  if(isDefined(var_0) && isDefined(self.triggerportableradarping)) {
    if(isDefined(var_0.triggerportableradarping) && isplayer(var_0.triggerportableradarping)) {
      var_0 = var_0.triggerportableradarping;
    }

    if(self.triggerportableradarping scripts\cp\utility::isenemy(var_0)) {
      var_8 = var_0;
    }
  }

  if(isDefined(var_8)) {
    var_8 notify("destroyed_killstreak", var_1);
    var_9 = 100;
    var_7 = 1;
  }

  if(isDefined(self.triggerportableradarping) && isDefined(var_5)) {
    self.triggerportableradarping thread scripts\cp\utility::leaderdialogonplayer(var_5, undefined, undefined, self.origin);
  }

  self notify("death");
  return var_7;
}

handlemeleedamage(var_0, var_1, var_2) {
  if(var_1 == "MOD_MELEE") {
    return self.maxhealth + 1;
  }

  return var_2;
}

handleempdamage(var_0, var_1, var_2) {
  if(var_0 == "emp_grenade_mp" && var_1 == "MOD_GRENADE_SPLASH") {
    self notify("emp_damage", var_0.triggerportableradarping, 8);
    return 0;
  }

  return var_2;
}

func_3343() {
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;
  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(!isplayer(var_0) && !isagent(var_0)) {
      continue;
    }

    if(!friendlyfirecheck(self.triggerportableradarping, var_0)) {
      continue;
    }

    if(isDefined(var_9)) {
      switch (var_9) {
        case "ztransponder_mp":
        case "transponder_mp":
        case "concussion_grenade_mp":
        case "smoke_grenade_mp":
        case "flash_grenade_mp":
          break;
      }
    }

    break;
  }

  if(level.c4explodethisframe) {
    wait(0.1 + randomfloat(0.4));
  } else {
    wait(0.05);
  }

  if(!isDefined(self)) {
    return;
  }

  level.c4explodethisframe = 1;
  thread resetc4explodethisframe();
  if(isDefined(var_4) && issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE")) {
    self.waschained = 1;
  }

  if(isDefined(var_8) && var_8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;
  if(isDefined(var_0)) {
    self.damagedby = var_0;
  }

  if(isplayer(var_0)) {
    var_0 updatedamagefeedback("c4");
  }

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(self.triggerportableradarping)) {
      var_0A = var_0.pers["team"];
      var_0B = self.triggerportableradarping.pers["team"];
      if(isDefined(var_0A) && isDefined(var_0B) && var_0A != var_0B) {
        var_0 notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.triggerportableradarping) && isDefined(var_0) && var_0 != self.triggerportableradarping) {
    var_0 notify("destroyed_equipment");
  }

  if(self.weapon_name == "transponder_mp" || self.weapon_name == "ztransponder_mp") {
    self.triggerportableradarping notify("transponder_update", 0);
  }

  waittillframeend;
  self notify("detonateExplosive", var_0);
}

friendlyfirecheck(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  var_3 = var_1.team;
  var_4 = level.friendlyfire;
  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(var_4 != 0) {
    return 1;
  }

  if(var_1 == var_0) {
    return 0;
  }

  if(!isDefined(var_3)) {
    return 1;
  }

  if(var_3 != var_0.team) {
    return 1;
  }

  return 0;
}

resetc4explodethisframe() {
  wait(0.05);
  level.c4explodethisframe = 0;
}

func_20B9() {
  thread func_20BA();
}

func_20BA() {
  self notify("stop_applyAlienSnare");
  self endon("stop_applyAlienSnare");
  self endon("disconnect");
  self endon("death");
  self.var_1BD8++;
  self.var_1BD9 = pow(0.68, self.var_1BD8 + 1 * 0.35);
  self.var_1BD9 = max(0.58, self.var_1BD9);
  scripts\cp\perks\perkfunctions::func_12E78();
  wait(0.8);
  self.var_1BD8 = 0;
  self.var_1BD9 = 1;
  scripts\cp\perks\perkfunctions::func_12E78();
}

func_9BE5(var_0, var_1, var_2) {
  if(isDefined(var_2) && scripts\cp\utility::is_trap(var_2)) {
    return 0;
  }

  if(var_0 == "MOD_UNKNOWN" && var_1 != "none") {
    return 1;
  }

  return 0;
}

func_A010(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = getweaponbasename(var_0);
  switch (var_1) {
    case "iw7_shredderdummy_zm":
    case "iw7_facemelterdummy_zm":
    case "iw7_dischorddummy_zm":
    case "iw7_headcutterdummy_zm":
    case "iw7_headcutter3_zm":
    case "iw7_headcutter2_zm":
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
    case "iw7_facemelter_zm_pap1":
    case "iw7_facemelter_zm":
    case "iw7_dischord_zm_pap1":
    case "iw7_dischord_zm":
    case "iw7_shredder_zm_pap1":
    case "iw7_shredder_zm":
      return 1;

    default:
      return 0;
  }

  return 0;
}