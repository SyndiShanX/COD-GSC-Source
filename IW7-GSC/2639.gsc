/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2639.gsc
***************************************/

updatedamagefeedback(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isDefined(level.friendly_damage_check) && [[level.friendly_damage_check]](var_04, var_05, var_06)) {
    return;
  }
  if(!isplayer(self)) {
    return;
  }
  var_07 = "standard_cp";
  var_08 = undefined;

  if(isDefined(var_01) && var_01)
    self playlocalsound("cp_hit_alert_strong");
  else if(scripts\engine\utility::is_true(self.deadeye_charge))
    self playlocalsound("cp_hit_alert_perk");
  else
    self playlocalsound("cp_hit_alert");

  switch (var_00) {
    case "hitalienarmor":
      self setclientomnvar("damage_feedback_icon", var_00);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      var_03 = 1;
      break;
    case "hitcritical":
    case "hitaliensoft":
      var_08 = 1;
      break;
    case "stun":
    case "meleestun":
      if(!isDefined(self.meleestun)) {
        self playlocalsound("crate_impact");
        self.meleestun = 1;
      }

      self setclientomnvar("damage_feedback_icon", "hitcritical");
      self setclientomnvar("damage_feedback_icon_notify", gettime());
      wait 0.2;
      self.meleestun = undefined;
      break;
    case "high_damage":
      var_07 = "high_damage_cp";
      break;
    case "special_weapon":
      var_07 = "wor_weapon_cp";
      break;
    case "card_boosted":
      var_07 = "fnf_card_damage_cp";
      break;
    case "red_arcane_cp":
      var_07 = "red_arcane_cp";
      break;
    case "blue_arcane_cp":
      var_07 = "blue_arcane_cp";
      break;
    case "yellow_arcane_cp":
      var_07 = "yellow_arcane_cp";
      break;
    case "green_arcane_cp":
      var_07 = "green_arcane_cp";
      break;
    case "pink_arcane_cp":
      var_07 = "pink_arcane_cp";
      break;
    case "dewdrops_cp":
      var_07 = "dewdrops_cp";
      break;
    case "none":
      break;
    default:
      break;
  }

  updatehitmarker(var_07, var_08, var_02, var_03, var_01);
}

onplayertouchkilltrigger(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(level.gameended == 1) {
    return;
  }
  if(kill_trigger_event_was_processed()) {
    return;
  }
  set_kill_trigger_event_processed(self, 1);
  scripts\cp\cp_laststand::callback_defaultplayerlaststand(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, scripts\cp\cp_globallogic::func_7F56());
}

kill_trigger_event_was_processed() {
  return scripts\engine\utility::is_true(self.kill_trigger_event_processed);
}

set_kill_trigger_event_processed(var_00, var_01) {
  self.kill_trigger_event_processed = var_01;
}

updatehitmarker(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_04))
    var_04 = 0;

  if(!isDefined(var_01))
    var_01 = 0;

  if(!isDefined(var_03))
    var_03 = 0;

  self setclientomnvar("damage_scale_type", "standard");

  if(var_04)
    self setclientomnvar("damage_feedback_kill", 1);
  else
    self setclientomnvar("damage_feedback_kill", 0);

  if(var_03)
    self setclientomnvar("damage_scale_type", "hitalienarmor");

  if(var_01) {
    self setclientomnvar("damage_scale_type", "hitaliensoft");
    self setclientomnvar("damage_feedback_headshot", 1);
  } else
    self setclientomnvar("damage_feedback_headshot", 0);

  if(isDefined(var_02))
    self setclientomnvar("ui_damage_amount", int(var_02));

  self setclientomnvar("damage_feedback", var_00);
  self setclientomnvar("damage_feedback_notify", gettime());
}

func_1118C(var_00, var_01, var_02) {
  scripts\engine\utility::waitframe();
  playFXOnTag(level._effect["stun_attack"], var_0.stun_struct.attack_bolt, "TAG_ORIGIN");
  playFXOnTag(level._effect["stun_shock"], var_0.stun_struct.attack_bolt, "TAG_ORIGIN");
  var_03 = undefined;

  if(isDefined(self.agent_type) && scripts\cp\cp_agent_utils::get_agent_type(self) == "seeder_spore")
    var_03 = self gettagorigin("J_Spore_46");
  else if(isDefined(self) && isalive(self) && scripts\cp\utility::has_tag(self.model, "J_SpineUpper"))
    var_03 = self gettagorigin("J_SpineUpper");

  if(isDefined(var_03)) {
    var_0.stun_struct.attack_bolt moveto(var_03, 0.05);
    wait 0.05;

    if(isDefined(self) && var_02 == "MOD_MELEE")
      self playSound("trap_electric_shock");

    wait 0.05;
    var_04 = int(var_01 / 2);

    if(isDefined(self)) {
      var_05 = self;

      if(isDefined(self.agent_type) && scripts\cp\cp_agent_utils::get_agent_type(self) == "seeder_spore")
        var_05 = self.func_4353;

      if(isDefined(var_05))
        var_05 getrandomarmkillstreak(var_04, self.origin, var_00, var_0.stun_struct.attack_bolt, var_02);
    }
  }

  stopFXOnTag(level._effect["stun_attack"], var_0.stun_struct.attack_bolt, "TAG_ORIGIN");
}

func_F29B(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(isDefined(var_01)) {
    if(var_01 == "xm25_mp" && var_00 == "MOD_IMPACT")
      var_02 = 95;

    if(var_01 == "spider_beam_mp")
      var_02 = var_02 * 15;

    if(var_01 == "alienthrowingknife_mp" && var_00 == "MOD_IMPACT") {
      if(can_hypno(var_03, 0, var_04, var_00, var_01, var_05, var_06, var_07, var_08, var_09))
        var_02 = 20000;
      else if(scripts\cp\cp_agent_utils::get_agent_type(self) != "elite")
        var_02 = 500;
    }
  }

  return var_02;
}

can_hypno(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(isDefined(self.func_38E0) && self.func_38E0)
    return 0;

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
      if(var_00 scripts\cp\utility::is_upgrade_enabled("hypno_rhino_upgrade") || var_01)
        return 1;
    default:
      return 0;
  }
}

scale_alien_damage_by_perks(var_00, var_01, var_02, var_03) {
  var_04 = 1.05;

  if(scripts\engine\utility::isbulletdamage(var_02) && !func_9D39(var_03) && !func_9DB8(var_03)) {
    if(!func_9D39(var_03))
      var_01 = int(var_01 * var_00 scripts\cp\perks\perk_utility::perk_getbulletdamagescalar());
    else if(func_9D38(var_03))
      var_01 = int(var_01 * var_00 scripts\cp\perks\perk_utility::func_CA43());

    if(isDefined(var_0.func_1517))
      var_01 = int(var_01 * var_0.func_1517);
  }

  if(var_02 == "MOD_EXPLOSIVE")
    var_01 = int(var_01 * var_00 scripts\cp\perks\perk_utility::perk_getexplosivedamagescalar());

  if(var_02 == "MOD_MELEE") {
    if(should_play_melee_blood_vfx(var_00))
      playFXOnTag(level._effect["melee_blood"], var_00, "tag_weapon_right");

    var_01 = int(var_01 * var_00 scripts\cp\perks\perk_utility::perk_getmeleescalar());

    if(isDefined(var_0.func_1518))
      var_01 = int(var_01 * var_0.func_1518);
  }

  if(var_00 scripts\cp\utility::is_upgrade_enabled("damage_booster_upgrade"))
    var_01 = int(var_01 * var_04);

  return var_01;
}

should_play_melee_blood_vfx(var_00) {
  if(isDefined(level.should_play_melee_blood_vfx_func))
    return [[level.should_play_melee_blood_vfx_func]](var_00);

  return 1;
}

func_9D39(var_00) {
  if(!isDefined(var_00))
    return 0;

  switch (var_00) {
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

func_9DB8(var_00) {
  if(!isDefined(var_00))
    return 0;

  switch (var_00) {
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

func_9D38(var_00) {
  if(!isDefined(var_00))
    return 0;

  switch (var_00) {
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

scale_alien_damage_by_weapon_type(var_00, var_01, var_02, var_03, var_04) {
  if(isDefined(var_04) && var_04 != "none")
    var_01 = func_3D84(self, var_01, var_00, var_03, var_02);

  if(isDefined(var_02) && var_02 == "MOD_EXPLOSIVE_BULLET" && var_04 != "none") {
    if(scripts\cp\utility::coop_getweaponclass(var_03) == "weapon_shotgun")
      var_01 = var_01 + int(var_01 * level.shotgundamagemod);
    else
      var_01 = var_01 + int(var_01 * level.exploimpactmod);
  }

  return var_01;
}

scale_alien_damage_by_prestige(var_00, var_01) {
  if(isplayer(var_00)) {
    var_02 = var_00 scripts\cp\perks\prestige::prestige_getweapondamagescalar();
    var_01 = var_01 * var_02;
    var_01 = int(var_01);
  }

  return var_01;
}

func_3D84(var_00, var_01, var_02, var_03, var_04) {
  var_05 = 500;

  if(!isDefined(var_00) || !scripts\cp\utility::isreallyalive(var_00))
    return var_01;

  if(!isDefined(var_02) || !isplayer(var_02) || var_04 != "MOD_EXPLOSIVE_BULLET")
    return var_01;

  if(scripts\cp\utility::coop_getweaponclass(var_03) == "weapon_shotgun") {
    var_06 = distance(var_2.origin, var_0.origin);
    var_07 = max(1, var_06 / var_05);
    var_08 = var_01 * 8;
    var_09 = var_08 * var_07;

    if(var_06 > var_05)
      return var_01;

    return int(var_09);
  }

  return var_01;
}

check_for_special_damage(var_00, var_01, var_02) {
  if(var_02 == "MOD_MELEE" && weapontype(var_01) != "riotshield") {
    return;
  }
  if(isDefined(var_01) && var_01 == "alienims_projectile_mp") {
    return;
  }
  if(!isDefined(var_0.is_burning) && isalive(var_00)) {
    if((scripts\cp\utility::player_has_special_ammo(self, "incendiary_ammo") || scripts\cp\utility::player_has_special_ammo(self, "combined_ammo")) && var_02 != "MOD_UNKNOWN")
      var_00 thread catch_alien_on_fire(self, undefined, undefined, 1);
    else if(var_01 == "iw5_alienriotshield4_mp" && self.fireshield == 1.0)
      var_00 thread catch_alien_on_fire(self);
    else if((scripts\engine\utility::is_true(self.func_8B86) || scripts\engine\utility::is_true(self.func_8BAC)) && var_02 != "MOD_UNKNOWN")
      var_00 thread catch_alien_on_fire(self, undefined, undefined, 1);

    switch (var_01) {
      case "iw6_alienmk323_mp":
      case "iw6_alienmk324_mp":
      case "iw6_alienminigun4_mp":
      case "iw6_alienminigun3_mp":
      case "alien_manned_gl_turret4_mp":
      case "alienvulture_mp":
        var_00 thread catch_alien_on_fire(self);
        break;
    }
  } else {
    var_03 = scripts\cp\utility::getrawbaseweaponname(var_01);

    if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[var_03]) && self.special_ammocount[var_03] > 0)
      return;
  }
}

catch_alien_on_fire(var_00, var_01, var_02, var_03) {
  self endon("death");
  alien_fire_on();
  damage_alien_over_time(var_00, var_01, var_02, var_03);
  alien_fire_off();
}

damage_alien_over_time(var_00, var_01, var_02, var_03) {
  self endon("death");

  if(!isDefined(var_01) && !isDefined(var_02)) {
    var_04 = scripts\cp\cp_agent_utils::get_agent_type(self);

    switch (var_04) {
      case "goon4":
      case "goon3":
      case "goon2":
      case "goon":
        var_02 = 75;
        var_01 = 3;
      case "brute4":
      case "brute3":
      case "brute2":
      case "brute":
        var_02 = 100;
        var_01 = 4;
      case "spitter":
        var_02 = 133;
        var_01 = 4;
      case "elite_boss":
      case "elite":
        var_02 = 500;
        var_01 = 4;
      case "minion":
        var_02 = 100;
        var_01 = 2;
      default:
        var_02 = self.maxhealth * 0.5;
        var_01 = 3;
    }
  } else {
    if(!isDefined(var_02))
      var_02 = 150;

    if(!isDefined(var_01))
      var_01 = 3;
  }

  if(isDefined(var_00) && isDefined(var_03) && var_00 scripts\cp\utility::is_upgrade_enabled("incendiary_ammo_upgrade") && isDefined(var_03))
    var_02 = var_02 * 1.2;

  var_02 = var_02 * level.alien_health_per_player_scalar[level.players.size];
  var_05 = 0;
  var_06 = 6;
  var_07 = var_01 / var_06;
  var_08 = var_02 / var_06;

  for(var_09 = 0; var_09 < var_06; var_9++) {
    wait(var_07);

    if(isalive(self))
      self getrandomarmkillstreak(var_08, self.origin, var_00, var_00, "MOD_UNKNOWN");
  }
}

alien_fire_on() {
  if(!isDefined(self.is_burning))
    self.is_burning = 0;

  self.is_burning++;

  if(self.is_burning == 1 && self.species == "alien") {
    if(isDefined(self.agent_type) && self.agent_type != "minion")
      self setscriptablepartstate("animpart", "burning");
  }
}

alien_fire_off() {
  self.is_burning--;

  if(self.is_burning > 0) {
    return;
  }
  self.is_burning = undefined;
  self notify("fire_off");

  if(self.species == "alien")
    self setscriptablepartstate("animpart", "normal");
}

update_damage_score(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!isDefined(level.func_24B8) || var_01 != level.func_24B8) {
    if(isDefined(var_01) && isDefined(var_1.owner))
      scripts\cp\cp_agent_utils::store_attacker_info(var_1.owner, var_02 * 0.75);
    else if(isDefined(var_01) && isDefined(var_1.pet) && var_1.pet == 1)
      scripts\cp\cp_agent_utils::store_attacker_info(var_1.owner, var_02);
    else
      scripts\cp\cp_agent_utils::store_attacker_info(var_01, var_02);

    if(isDefined(var_01) && isDefined(var_05)) {
      if(isDefined(level.func_12D86))
        level thread[[level.func_12D86]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, self);
    }
  }

  update_zombie_damage_challenge(var_01, var_02, var_04);
}

update_zombie_damage_challenge(var_00, var_01, var_02) {
  if(isDefined(level.update_zombie_damage_challenge))
    [[level.update_zombie_damage_challenge]](var_00, var_01, var_02);
}

handlemissiledamage(var_00, var_01, var_02) {
  var_03 = var_02;

  switch (var_00) {
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
      var_03 = self.maxhealth + 1;
      break;
    case "hind_missile_mp":
    case "hind_bomb_mp":
    case "remote_tank_projectile_mp":
    case "switch_blade_child_mp":
      self.largeprojectiledamage = 0;
      var_03 = self.maxhealth + 1;
      break;
    case "heli_pilot_turret_mp":
    case "a10_30mm_turret_mp":
      self.largeprojectiledamage = 0;
      var_03 = var_03 * 2;
      break;
    case "sam_projectile_mp":
      self.largeprojectiledamage = 1;
      var_03 = var_02;
      break;
  }

  return var_03;
}

handlegrenadedamage(var_00, var_01, var_02) {
  if(isexplosivedamagemod(var_01)) {
    switch (var_00) {
      case "iw6_rgm_mp":
      case "proximity_explosive_mp":
      case "c4_zm":
        var_02 = var_02 * 3;
        break;
      case "iw6_mk32_mp":
      case "semtexproj_mp":
      case "bouncingbetty_mp":
      case "semtex_zm":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_02 = var_02 * 4;
        break;
      default:
        if(scripts\cp\utility::isstrstart(var_00, "alt_"))
          var_02 = var_02 * 3;

        break;
    }
  }

  return var_02;
}

handleapdamage(var_00, var_01, var_02, var_03) {
  if(var_01 == "MOD_RIFLE_BULLET" || var_01 == "MOD_PISTOL_BULLET") {
    if(var_03 scripts\cp\utility::_hasperk("specialty_armorpiercing") || scripts\cp\utility::isfmjdamage(var_00, var_01, var_03))
      return var_02 * level.armorpiercingmod;
  }

  return var_02;
}

onkillstreakkilled(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = 0;
  var_08 = undefined;

  if(isDefined(var_00) && isDefined(self.owner)) {
    if(isDefined(var_0.owner) && isplayer(var_0.owner))
      var_00 = var_0.owner;

    if(self.owner scripts\cp\utility::isenemy(var_00))
      var_08 = var_00;
  }

  if(isDefined(var_08)) {
    var_08 notify("destroyed_killstreak", var_01);
    var_09 = 100;
    var_07 = 1;
  }

  if(isDefined(self.owner) && isDefined(var_05))
    self.owner thread scripts\cp\utility::leaderdialogonplayer(var_05, undefined, undefined, self.origin);

  self notify("death");
  return var_07;
}

handlemeleedamage(var_00, var_01, var_02) {
  if(var_01 == "MOD_MELEE")
    return self.maxhealth + 1;

  return var_02;
}

handleempdamage(var_00, var_01, var_02) {
  if(var_00 == "emp_grenade_mp" && var_01 == "MOD_GRENADE_SPLASH") {
    self notify("emp_damage", var_0.owner, 8.0);
    return 0;
  }

  return var_02;
}

func_3343() {
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_00 = undefined;

  for(;;) {
    self waittill("damage", var_01, var_00, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(!isplayer(var_00) && !isagent(var_00)) {
      continue;
    }
    if(!friendlyfirecheck(self.owner, var_00)) {
      continue;
    }
    if(isDefined(var_09)) {
      switch (var_09) {
        case "ztransponder_mp":
        case "transponder_mp":
        case "concussion_grenade_mp":
        case "smoke_grenade_mp":
        case "flash_grenade_mp":
          continue;
      }
    }

    break;
  }

  if(level.c4explodethisframe)
    wait(0.1 + randomfloat(0.4));
  else
    wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  level.c4explodethisframe = 1;
  thread resetc4explodethisframe();

  if(isDefined(var_04) && (issubstr(var_04, "MOD_GRENADE") || issubstr(var_04, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isDefined(var_08) && var_08 &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  self.wasdamaged = 1;

  if(isDefined(var_00))
    self.damagedby = var_00;

  if(isplayer(var_00))
    var_00 updatedamagefeedback("c4");

  if(level.teambased) {
    if(isDefined(var_00) && isDefined(self.owner)) {
      var_10 = var_0.pers["team"];
      var_11 = self.owner.pers["team"];

      if(isDefined(var_10) && isDefined(var_11) && var_10 != var_11)
        var_00 notify("destroyed_equipment");
    }
  } else if(isDefined(self.owner) && isDefined(var_00) && var_00 != self.owner)
    var_00 notify("destroyed_equipment");

  if(self.weapon_name == "transponder_mp" || self.weapon_name == "ztransponder_mp")
    self.owner notify("transponder_update", 0);

  waittillframeend;
  self notify("detonateExplosive", var_00);
}

friendlyfirecheck(var_00, var_01, var_02) {
  if(!isDefined(var_00))
    return 1;

  if(!level.teambased)
    return 1;

  var_03 = var_1.team;
  var_04 = level.friendlyfire;

  if(isDefined(var_02))
    var_04 = var_02;

  if(var_04 != 0)
    return 1;

  if(var_01 == var_00)
    return 0;

  if(!isDefined(var_03))
    return 1;

  if(var_03 != var_0.team)
    return 1;

  return 0;
}

resetc4explodethisframe() {
  wait 0.05;
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
  self.func_1BD8++;
  self.func_1BD9 = _pow(0.68, (self.func_1BD8 + 1) * 0.35);
  self.func_1BD9 = max(0.58, self.func_1BD9);
  scripts\cp\perks\perkfunctions::func_12E78();
  wait 0.8;
  self.func_1BD8 = 0;
  self.func_1BD9 = 1.0;
  scripts\cp\perks\perkfunctions::func_12E78();
}

func_9BE5(var_00, var_01, var_02) {
  if(isDefined(var_02) && scripts\cp\utility::is_trap(var_02))
    return 0;

  if(var_00 == "MOD_UNKNOWN" && var_01 != "none")
    return 1;
  else
    return 0;
}

func_A010(var_00) {
  if(!isDefined(var_00))
    return 0;

  var_01 = getweaponbasename(var_00);

  switch (var_01) {
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