/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_damage.gsc
***********************************************/

callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = createheadicon(var_5);
  var_15 = self;
  var_16 = isDefined(var_1);
  var_17 = var_16 && isPlayer(var_1);

  if(!var_17) {
    if(isDefined(var_1)) {
      if(isDefined(var_1.code_classname) && var_1.code_classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E")
        var_0 = var_1;

      if(isDefined(var_1.owner) && (isPlayer(var_1.owner) || isagent(var_1.owner))) {
        var_1 = var_1.owner;
        var_17 = 1;
        var_16 = 1;
      }
    }

    if(!var_17) {
      if(isDefined(var_0) && isDefined(var_0.owner) && (isPlayer(var_0.owner) || isagent(var_0.owner))) {
        var_1 = var_0.owner;
        var_17 = 1;
        var_16 = 1;
      }
    }
  }

  if(!shouldtakedamage(var_2, var_1, var_14, var_3, var_17)) {
    return;
  }
  if(damageflag(1)) {}

  if(var_4 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_0) && isDefined(var_15 scripts\cp_mp\utility\player_utility::getvehicle()) && var_15 scripts\cp_mp\utility\player_utility::getvehicle() == var_0) {
    return;
  }
  if(var_4 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_0) && istrue(var_0.little_bird_mg_enterend)) {
    return;
  }
  if(scripts\cp_mp\vehicles\vehicle::_id_14201(var_0, var_15, var_4, var_5)) {
    return;
  }
  if(istrue(var_15.inlaststand)) {
    return;
  }
  if(var_4 == "_encstr_AB590C99ED78875F650F3951034D") {
    if(isDefined(level.overcook_func[var_14]))
      level thread[[level.overcook_func[var_14]]](var_15, var_14);

    if(scripts\cp\cp_relics::try_start_fake_infil_chopper("_encstr_A7AA0CE456D85A36D72CB6C1AC32") && istrue(var_15._id_12A7E))
      var_2 = var_13;
  }

  var_3 = var_3 | 4;
  var_18 = isDefined(var_4) && (var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_4 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B");
  var_19 = isDefined(var_4) && var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5";
  var_20 = isfriendlyfire(self, var_1);
  var_21 = self.perk_data["_encstr_A2872499E4962B9B32D82FD7CA1E1C36DE6EB4B3ACF5C885B558ECB2D7932B8C571BD1A5DE37"] != 1.0;
  var_22 = var_16 && var_1 == self;
  var_23 = (var_22 || !var_16) && var_4 == "_encstr_AB590C99ED78875F650F3951034D";

  if(var_16) {
    if(var_1 == self) {
      if(var_18)
        var_2 = var_2 * self.perk_data["_encstr_A2872499E4962B9B32D82FD7CA1E1C36DE6EB4B3ACF5C885B558ECB2D7932B8C571BD1A5DE37"];
    } else if(var_20) {
      var_2 = 0;

      if(isPlayer(var_15) && isPlayer(var_1))
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_15, "_encstr_B621107140282E7F17C807BE3FD0893CD4B0");
    }

    if(var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF") {
      if(var_14 == "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860")
        var_2 = self.maxhealth * 0.9;

      var_2 = var_2 * scripts\cp\perks\cp_perks::get_perk("_encstr_841A21AC37B25BCBAFB2E138367B37D29DCAF519586BC27656AFC9AC91ABC61DB4DEE6");

      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(var_15)) {}

        var_2 = var_2 + var_2 * level.explosivedamagemod;
      }
    } else if(var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421") {
      if(isDefined(level.explosivedamagemod)) {
        if(isPlayer(var_15)) {}

        var_2 = var_2 + var_2 * level.explosivedamagemod;
      }
    }
  }

  if(var_4 == "_encstr_87A10C9D24E997A01F21838F3D34" && !scripts\cp\utility::turn_off_sniper_laser()) {
    if(scripts\cp\utility::_hasperk("_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"))
      var_2 = 0;
    else {
      if(getdvarint("_encstr_AB1C179B2F78394FC171F13A1BB0B36E20893F1443F8FE277D", 0) <= 0)
        var_2 = self.maxhealth + self.armor;

      physicsexplosionsphere(self.origin, 64, 64, 1);
    }
  }

  var_24 = 0.0;

  if(var_22 && !var_23)
    var_2 = int(var_2 * var_15 scripts\cp\utility::getdamagemodifiertotal());

  if(scripts\cp\cp_weapon::isflashgrenadedamage(var_5, var_4)) {
    var_25 = scripts\cp\cp_weapon::applyflashfromdamage(var_15, var_1, var_6, 0);

    if(!var_25)
      return;
  }

  var_26 = self getcurrentprimaryweapon();

  if(var_26.type == "_encstr_A6C7065BACB1CA95")
    var_2 = int(var_2 * self.perk_data["_encstr_8EC41D1F53B6ABF1C8B0AFB9C8703C1285978B8F2357A2A551FBA63EC0386A"]);

  if(var_26.basename == "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1") {
    if(!shouldskipdeathshield(var_0, var_1, var_4)) {
      if(isDefined(var_8) && var_8 == "_encstr_A32D07CFD14BAA94D0") {
        if(isDefined(self.riot_shield_damage))
          self.riot_shield_damage = self.riot_shield_damage - var_2;
      }
    }
  }

  if(self issprinting())
    var_2 = int(var_2 * self.perk_data["_encstr_88441577E012C0B05389F941B2DFFC68E15BDFCB94BE40"]);

  if(self.isreviving == 1)
    var_2 = int(var_2 * self.perk_data["_encstr_8D92153956CEA59DACD746C2DA0B9D95FA37D8161B1693"]);

  if(isDefined(self.super_invulnerable)) {
    if(var_17)
      self shellshock("_encstr_96430A6A65D59B40DE7A4CFB", 0.25);

    var_2 = 0;
  }

  if(isDefined(self.vehicle_riding_on)) {
    self.vehicle_riding_on dodamage(var_2, self.vehicle_riding_on.origin);
    var_2 = int(clamp(var_2, 0, self.health - 1));
  }

  var_2 = modifydamagegeneral(var_0, var_1, var_15, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(var_2 <= 0) {
    return;
  }
  if(isPlayer(self) && isDefined(self.jugg_health)) {
    self.jugg_health = self.jugg_health - var_2;

    if(self.jugg_health <= 0) {
      if(var_4 != "_encstr_87A10C9D24E997A01F21838F3D34")
        var_2 = 0;

      self notify("_encstr_88F016A6D53BCECAC93785571DFAAC9B32D7190BDA85EC56");
    }
  }

  if(var_16 && var_2 > 0) {
    if(!damageflag(1)) {
      if(getdvarint("_encstr_B19213DC8DC9F519B59DBE999C16B595D7B9B6A51C", 20) != 20)
        var_27 = getdvarint("_encstr_B19213DC8DC9F519B59DBE999C16B595D7B9B6A51C") * level.framedurationseconds * 1000;
      else
        var_27 = level.framedurationseconds * 1000 * 20;

      self.damageshieldexpiretime = gettime() + var_27;
    }

    if(isai(var_1) || isPlayer(var_1) && var_1 != self) {
      scripts\cp\cp_agent_damage::addattacker(self, var_1, var_0, var_5, var_2, var_6, var_7, var_8, var_9, var_4);

      if(!isDefined(var_1.damagedplayers))
        var_1.damagedplayers = [];

      var_28 = gettime();
      var_1.damagedplayers[var_15.guid] = var_28;
    }
  }

  if(isPlayer(var_1) && isDefined(var_1.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]))
    var_1.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]++;
  else if(isPlayer(var_1))
    var_1.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] = 1;

  if(isPlayer(self) && isDefined(self.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]))
    self.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]++;
  else if(isPlayer(self))
    self.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] = 1;

  scripts\cp\agents\gametype_cp_wave_sv::sethasdonecombat(self, 1);
  var_29 = 0;

  if(isDefined(var_1) && isai(var_1)) {
    if(istrue(self isinfreefall()) || istrue(self isskydiving()) || istrue(self isparachuting()))
      var_2 = 1;
  }

  if(!var_20) {
    if(scripts\cp\cp_armor::has_armor(self) && scripts\cp\cp_armor::armor_resistance_to_type(var_4, var_5, var_0, var_1)) {
      if(isDefined(var_8) && var_8 != "_encstr_A32D07CFD14BAA94D0") {
        var_2 = scripts\cp\cp_armor::damage_armored_player(self, var_0, var_1, var_2, var_3, var_4, var_14, var_6, var_7, var_8, var_9, var_24, var_10, var_11);
        var_29 = 1;
      }
    }

    if(isDefined(level.updateondamagerelicsfunc))
      level thread[[level.updateondamagerelicsfunc]](var_1, var_14, self);

    if(var_2 >= self.health && !shouldskipdeathshield(var_0, var_1, var_4)) {
      if(shouldactivatedeathshield(var_2)) {
        var_2 = self.health - 1;
        childthread deathshieldinvulnerability(var_2, var_1, var_7, var_6, undefined, undefined, var_0);
      }

      childthread damageui(var_2, var_1, var_7, var_6, undefined, undefined, var_0);
      childthread damageeffects(var_2, var_1, var_7, var_6, var_4, undefined, var_0);
      var_30 = scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var_30))
        self.bhitbyvehicle = 1;
      else if(weapon_is_a_vehicle_weapon(var_5))
        self.bhitbyvehicle = 1;
    }

    if(var_4 == "_encstr_8D4E0A501FCB898912CB3FA3" && var_2 >= self.health)
      self.shouldskiplaststand = 1;

    var_2 = int(var_2);

    if(var_17 && !isPlayer(self) && !var_22)
      var_1 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");

    if(istrue(self.shouldskipdeathsshield))
      self.shouldskipdeathsshield = undefined;

    if(istrue(self.oob)) {
      self.shouldskiplaststand = 1;
      var_2 = self.health + 100;
    }

    finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_14, var_6, var_7, var_8, var_9, var_24, var_10, var_11, var_29);
    self notify("_encstr_990C0F38C6859795397D2385B52CEC9519");
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance("_encstr_8D2509C1CAC9B9DEDC16B1", "_encstr_B2310D943398AE674DEE4B0270958B", var_2);

  if(var_2 != 0)
    thread scripts\cp\cp_hud_util::_id_12480();

  if(var_16) {
    if(isagent(var_1)) {
      if(!isDefined(var_1.damage_done))
        var_1.damage_done = 0;
      else
        var_1.damage_done = var_1.damage_done + var_2;

      self.recent_attacker = var_1;

      if(isDefined(level.current_challenge)) {
        if(isDefined(level.custom_playerdamage_challenge_func))
          self[[level.custom_playerdamage_challenge_func]](var_0, var_1, var_2, var_3, var_4, var_14, var_6, var_7, var_8);
      }
    }
  }

  if(scripts\engine\utility::isbulletdamage(var_4))
    var_15 thread scripts\cp\cp_player_battlechatter::adddamagetaken(var_1, var_5, var_2);

  if(isagent(var_1) && isDefined(var_1) && var_1 scripts\cp_mp\utility\player_utility::_isalive() && var_1 != var_15)
    var_15 thread scripts\cp\cp_player_battlechatter::addrecentattacker(var_1);

  if(isDefined(var_15) && var_15 scripts\cp_mp\utility\player_utility::_isalive() && var_15.health < 30)
    var_15 thread scripts\cp\cp_player_battlechatter::hurtbadlywait();

  if(isDefined(var_15) && var_15 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(var_1) && var_1 != var_15 && weaponclass(var_5) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_15, "_encstr_8B300CDBDBDE33AAC41707CB0B24", undefined, 1.0);

  if(isDefined(var_15) && var_15.health <= 1)
    var_15 scripts\cp\cp_player_battlechatter::onplayerkilled(var_0, var_1, var_2, var_4, var_5);
}

van_initdamage() {
  if(scripts\cp\utility\player::isusingremote())
    return 1;

  return 0;
}

shouldskipdeathshield(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 == self)
    return 1;

  if(istrue(self.shouldskipdeathsshield))
    return 1;

  if(getdvarint("_encstr_BD0B16AF2BDAB90DA322C6E9EADBB6D039930713C049A8CE", 0) != 0) {
    if(isDefined(var_0)) {
      if(isDefined(var_0.weapon_name)) {
        switch (var_0.weapon_name) {
          case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
          case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
          case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
            return 1;
        }
      }
    }
  }

  if(isDefined(var_0) && triggersafearea(var_0)) {
    if(var_2 == "_encstr_8D4E0A501FCB898912CB3FA3")
      return 1;
  }

  switch (var_2) {
    case "_encstr_AB590C99ED78875F650F3951034D":
    case "_encstr_87A10C9D24E997A01F21838F3D34":
    case "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3":
    case "_encstr_AA230E8CF56CD18DB12FC7E303C8C001":
      return 1;
  }

  return 0;
}

triggersafearea(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(level.cratedata) && isDefined(level.cratedata.crates)) {
    if(level.cratedata.crates.size > 0) {
      if(scripts\engine\utility::array_contains(level.cratedata.crates, var_0))
        return 1;
    }
  }

  return 0;
}

weapon_is_a_vehicle_weapon(var_0) {
  switch (var_0.basename) {
    case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
    case "_encstr_BE2610C077D0B2630B5683EB7B6E472168F1":
    case "_encstr_99E107C0F71E86B363":
    case "_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213":
    case "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0":
    case "_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148":
    case "_encstr_8CBA0AD33D120153A1AFA040":
    case "_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E":
    case "_encstr_AB6F081B8D7949AFC813":
    case "_encstr_A2CF0C31B4B37D985A2746D76B07":
    case "_encstr_B2F60B166F934917E1C5C7BA1B":
    case "_encstr_92B90BC2C11BBEE4AE6ED7AD0E":
    case "_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9":
    case "_encstr_A7A70785E89DD7AD0E":
    case "_encstr_A7AA0DE816C6D727DBCEB2C9EBB61C":
    case "_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43":
    case "_encstr_88E90F60526BE39B37B026C8BBEA614FB1":
    case "_encstr_8D7B0D3007F3805512A6C759B18AB1":
      return 1;
    default:
      return 0;
  }
}

isenemyinfrontofme(var_0, var_1) {
  var_2 = vectorNormalize((var_0.origin - self.origin) * (1, 1, 0));
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);

  if(!isDefined(var_1))
    return var_4 > 0;

  return var_4 > var_1;
}

isoneshotdamage(var_0, var_1) {
  if(var_1 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3" || var_1 == "_encstr_BDB50C41D83F8F9F030B60E80F5B" || var_1 == "_encstr_AB590C99ED78875F650F3951034D")
    return 0;

  if(var_0 >= self.health)
    return 1;

  return 0;
}

delayed_stun_damage(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  wait 0.05;
  self dodamage(2, self.origin, var_0, undefined, "_encstr_8DED0A21C79B660BC7588981");
}

stopusingremote() {
  self notify("_encstr_8BBA1296448F3B8763734B202AB195D13FF79D05");
}

useinvulnerability(var_0) {
  self.health = var_0 + 1;
  self.haveinvulnerabilityavailable = 0;
}

shouldtakedamage(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && (var_3 == 256 || var_3 == 258))
    return 0;

  if(isDefined(self.inlaststand) && self.inlaststand)
    return 0;

  if(damageflag(1))
    return 0;

  if(isDefined(level.intro_heli) && isbuiltinfunction(level.intro_heli)) {
    if(![[level.intro_heli]](self))
      return 0;
  }

  if(van_initdamage() && scripts\cp\utility::tryingtoleave())
    return 0;

  if(isDefined(self.ability_invulnerable))
    return 0;

  if(isDefined(var_2) && var_2 == "_encstr_A6EC1AF35710E12197F94BF3E22B6F6A11D54927EEEA28FD836280DA")
    return 0;

  if(isDefined(var_2) && var_2 == "_encstr_A2DC15EDEC9539DD8547D81AAFADA5E69BD236B2D7D81C")
    return 0;

  if(isDefined(var_2) && var_2 == "_encstr_B29611E09732D6F763B5882D4F3AD118B75748")
    return 0;

  if(istrue(self.inchopper))
    return 0;

  return 1;
}

check_for_explosive_shotgun_damage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 500;

  if(!isDefined(var_0) || !var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return var_1;

  if(!isDefined(var_2) || !isPlayer(var_2) || var_4 != "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5")
    return var_1;

  if(var_3.classname == "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9") {
    var_6 = distance(var_2.origin, var_0.origin);
    var_7 = max(1, var_6 / var_5);
    var_8 = var_1 * 8;
    var_9 = var_8 * var_7;

    if(var_6 > var_5)
      return var_1;

    return int(var_9);
  }

  return var_1;
}

kill_trigger_event_was_processed() {
  return istrue(self.kill_trigger_event_processed);
}

set_kill_trigger_event_processed(var_0, var_1) {
  self.kill_trigger_event_processed = var_1;
}

scale_alien_damage_by_weapon_type(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && var_4 != "_encstr_8BBA05185F8B99")
    var_1 = check_for_explosive_shotgun_damage(self, var_1, var_0, var_3, var_2);

  if(isDefined(var_2) && var_2 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && var_4 != "_encstr_8BBA05185F8B99") {
    if(var_3.classname == "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9")
      var_1 = var_1 + int(var_1 * level.shotgundamagemod);
    else
      var_1 = var_1 + int(var_1 * level.exploimpactmod);
  }

  return var_1;
}

scale_alien_damage_by_perks(var_0, var_1, var_2, var_3) {}

scale_alien_damage_by_prestige(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_2 = var_0 scripts\cp\perks\cp_prestige::prestige_getweapondamagescalar();
    var_1 = var_1 * var_2;
    var_1 = int(var_1);
  }

  return var_1;
}

should_play_melee_blood_vfx(var_0) {
  if(isDefined(level.should_play_melee_blood_vfx_func))
    return [[level.should_play_melee_blood_vfx_func]](var_0);

  return 1;
}

check_for_special_damage(var_0, var_1, var_2) {}

catch_alien_on_fire(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  alien_fire_on();
  damage_alien_over_time(var_0, var_1, var_2, var_3);
  alien_fire_off();
}

alien_fire_on() {
  if(!isDefined(self.is_burning))
    self.is_burning = 0;

  self.is_burning++;

  if(self.is_burning == 1 && self.species == "_encstr_97BB06B0C64B59B9") {
    if(isDefined(self.agent_type) && self.agent_type != "_encstr_B2BE07C03A35635803")
      self setscriptablepartstate("_encstr_86DA09B0CDD2D68316E4D1", "_encstr_A9B10826EAC9374BCDB3");
  }
}

alien_fire_off() {
  self.is_burning--;

  if(self.is_burning > 0) {
    return;
  }
  self.is_burning = undefined;
  self notify("_encstr_A7500961F4C298184A5B05");

  if(self.species == "_encstr_97BB06B0C64B59B9")
    self setscriptablepartstate("_encstr_86DA09B0CDD2D68316E4D1", "_encstr_820E07FAE8780B3A4C");
}

damage_alien_over_time(var_0, var_1, var_2, var_3) {
  var_4 = 150;
  var_5 = 100;
  var_6 = 75;
  var_7 = 133;
  var_8 = 500;
  var_9 = 100;
  var_10 = 3;
  var_11 = 4;
  var_12 = 3;
  var_13 = 4;
  var_14 = 4;
  var_15 = 2;
  var_16 = 1.2;
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1) && !isDefined(var_2)) {
    var_17 = scripts\cp\cp_agent_utils::get_agent_type(self);

    switch (var_17) {
      case "_encstr_A3CE06A740D02E07":
      case "_encstr_A7CE0617780F32EB":
      case "_encstr_A1CE06D9DEF6B946":
      case "_encstr_A77205F710801E":
        var_2 = var_6;
        var_1 = var_12;
      case "_encstr_B14E07630D5DA3857A":
      case "_encstr_A54E07F19B6F8D9862":
      case "_encstr_8D4E07A2EB0F43B80A":
      case "_encstr_BE1D0698E4D5472B":
        var_2 = var_5;
        var_1 = var_11;
      case "_encstr_B8CF0813A143B3E52FCB":
        var_2 = var_7;
        var_1 = var_13;
      case "_encstr_8E370BDB7C54A8B57FDA1883D3":
      case "_encstr_83AD06DDE1316B75":
        var_2 = var_8;
        var_1 = var_14;
      case "_encstr_B2BE07C03A35635803":
        var_2 = var_9;
        var_1 = var_15;
      default:
        var_2 = self.maxhealth * 0.5;
        var_1 = var_10;
    }
  } else {
    if(!isDefined(var_2))
      var_2 = var_4;

    if(!isDefined(var_1))
      var_1 = var_10;
  }

  if(isDefined(var_0) && isDefined(var_3) && var_0 scripts\cp\utility::is_upgrade_enabled("_encstr_AB8D18D288F6DFD5708B011A8381DE272940499BD35CCB4E088B") && isDefined(var_3))
    var_2 = var_2 * var_16;

  var_2 = var_2 * level.alien_health_per_player_scalar[level.players.size];
  var_18 = 0;
  var_19 = 6;
  var_20 = var_1 / var_19;
  var_21 = var_2 / var_19;

  for(var_22 = 0; var_22 < var_19; var_22++) {
    wait(var_20);

    if(isalive(self))
      self dodamage(var_21, self.origin, var_0, var_0, "_encstr_BDB50C41D83F8F9F030B60E80F5B");
  }
}

friendlyfirecheck(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    return 1;

  if(!level.teambased)
    return 1;

  var_3 = var_1.team;
  var_4 = level.friendlyfire;

  if(isDefined(var_2))
    var_4 = var_2;

  if(var_4 != 0)
    return 1;

  if(var_1 == var_0)
    return 0;

  if(!isDefined(var_3))
    return 1;

  if(var_3 != var_0.team)
    return 1;

  return 0;
}

update_damage_score(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isDefined(var_1.owner))
    scripts\cp\cp_agent_utils::store_attacker_info(var_1.owner, var_2 * 0.75);
  else if(isDefined(var_1) && isDefined(var_1.pet) && var_1.pet == 1)
    scripts\cp\cp_agent_utils::store_attacker_info(var_1.owner, var_2);
  else
    scripts\cp\cp_agent_utils::store_attacker_info(var_1, var_2);

  if(isDefined(var_1) && isDefined(var_5))
    level thread update_zombie_damage_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self);

  update_alien_damage_performance(var_1, var_2, var_4);
}

update_zombie_damage_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(istrue(self.died_poorly)) {
    return;
  }
  if(!isDefined(level.current_challenge)) {
    return;
  }
  if(isDefined(var_1) && isPlayer(var_1)) {
    var_11 = self[[level.custom_damage_challenge_func]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9, var_10);

    if(!istrue(var_11))
      return;
  }
}

update_alien_damage_performance(var_0, var_1, var_2) {
  if(isDefined(level.update_alien_damage_performance))
    [[level.update_alien_damage_performance]](var_0, var_1, var_2);
  else
    update_performance_zombie_damage(var_0, var_1, var_2);
}

update_performance_zombie_damage(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    return;
  }
  if(var_2 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3") {
    return;
  }
  scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "_encstr_B12D1598AAE503295F8FE568866716D78DD13820C23FA5", var_1);

  if(isPlayer(var_0))
    var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("_encstr_8D2509C1CAC9B9DEDC16B1", "_encstr_B12D1598AAE503295F8FE568866716D78DD13820C23FA5", var_1);
  else if(isDefined(var_0.owner))
    var_0.owner scripts\cp\cp_gamescore::update_personal_encounter_performance("_encstr_8D2509C1CAC9B9DEDC16B1", "_encstr_B12D1598AAE503295F8FE568866716D78DD13820C23FA5", var_1);
}

modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflag;

  if(isDefined(var_5) && (var_5 && level.idflags_ricochet))
    var_6 = 0.6 * var_4;
  else
    var_6 = var_4;

  var_6 = handleempdamage(var_2, var_3, var_6);
  var_6 = handlemissiledamage(var_2, var_3, var_6);
  var_6 = handlegrenadedamage(var_2, var_3, var_6);
  return var_6;
}

handlemissiledamage(var_0, var_1, var_2) {
  var_3 = var_2;

  switch (var_0.basename) {
    case "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      self.largeprojectiledamage = 1;
      var_3 = self.maxhealth + 1;
      break;
    case "_encstr_BE1015E9AFFA8BB93814D8B07B2FD83DB36B7B29AF32CF":
      self.largeprojectiledamage = 0;
      var_3 = var_3 * 2;
      break;
  }

  return var_3;
}

handlegrenadedamage(var_0, var_1, var_2) {
  if(isexplosivedamagemod(var_1)) {
    switch (var_0.basename) {
      case "_encstr_9AAE0876FCB7603101DB":
        var_2 = var_2 * 3;
        break;
      case "_encstr_8C5A1231DEEA37D82D9BD9F5312BA33AE5AFADC1":
      case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
      case "_encstr_92A70ABB8267F5E0D89F6351":
        var_2 = var_2 * 4;
        break;
      default:
        if(var_0.isalternate)
          var_2 = var_2 * 3;

        break;
    }
  }

  return var_2;
}

handlemeleedamage(var_0, var_1, var_2) {
  if(var_1 == "_encstr_8DED0A21C79B660BC7588981")
    return self.maxhealth + 1;

  return var_2;
}

handleempdamage(var_0, var_1, var_2) {
  return var_2;
}

handleapdamage(var_0, var_1, var_2, var_3) {
  var_4 = 1.0;
  var_5 = 1;

  if(isDefined(var_3) && isDefined(var_3.class) && var_3.class == "_encstr_8CFF09D56D88EC030D69EB" && isDefined(var_1) && scripts\engine\utility::isbulletdamage(var_1))
    var_4 = var_4 + var_5;
  else {
    var_6 = level.armorpiercingmod - 1;

    if(scripts\cp\utility::isfmjdamage(var_0, var_1, var_3))
      var_4 = var_4 + var_6;

    if(isDefined(level.armorpiercingmodks)) {
      var_7 = level.armorpiercingmodks - 1;

      if(isDefined(var_3) && var_3 scripts\cp\utility::_hasperk("_encstr_ACA91ACF3BE01F69593170F3B96902739A76D7C03A4690BBF64C43D8") && isDefined(self.streakname) && scripts\cp\cp_weapon::isprimaryweapon(var_0) && scripts\engine\utility::isbulletdamage(var_1))
        var_4 = var_4 + var_7;
    }
  }

  return var_2 * var_4;
}

handleshotgundamage(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    return var_2;

  if(var_0.basename == "_encstr_8BBA05185F8B99")
    return var_2;

  if(weaponclass(var_0) != "_encstr_A1100738A33A638123")
    return var_2;

  return int(min(150, var_2));
}

armormitigation(var_0, var_1, var_2) {
  return 1.0;
}

isfriendlyfire(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  if(isDefined(level.givematchplacementchallenge) && isDefined(level.choppergunners) && isDefined(level.choppergunners[0]) && isDefined(level.choppergunners[0].turret)) {
    if(level.givematchplacementchallenge == var_1)
      return 0;

    if(scripts\engine\utility::is_equal(level.choppergunners[0], var_1))
      return 0;

    if(scripts\engine\utility::is_equal(level.choppergunners[0].turret, var_1))
      return 0;
  }

  if(!level.teambased)
    return 0;

  if(!isPlayer(var_1) && !isDefined(var_1.team))
    return 0;

  if(var_0.team != var_1.team)
    return 0;

  if(var_0 == var_1)
    return 0;

  return 1;
}

finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(!callback_killingblow(var_0, var_1, var_2 - var_2 * var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(isPlayer(self)) {
    if(var_2 >= self.health) {
      if(van_initdamage()) {
        if(!isDefined(var_7))
          var_7 = (0, 0, 0);

        if(!isDefined(var_1))
          var_1 = self;

        if(!isDefined(var_0))
          var_0 = var_1;

        scripts\cp\utility::allow_player_ignore_me(1);
        var_14 = self playerforcedeathanim(var_0, var_4, var_5, var_8, var_7);
        self.fauxdead = 1;
        self.shouldskiplaststand = 1;
        self notify("_encstr_86BE0AA88AC3514E3BD5078D");

        if(!isDefined(self.nocorpse))
          self.body = self cloneplayer(var_14, var_1);

        if(!isDefined(self.nocorpse) && isDefined(self.body)) {
          self.body.targetname = "_encstr_A3AA0E181930D3F313C0BFC003075BA3";
          self playerhide();
          self setsolid(0);
          thread _startragdoll(self.body, var_4, var_0);
        }

        if(van_initdamage()) {
          thread _id_127E1();
          self waittill("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");
          var_2 = self.health + 100000;

          if(var_8 == "_encstr_A32D07CFD14BAA94D0")
            var_8 = "_encstr_952B0C65857BBFB80F9FC0B8A75A";
        }

        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
        self setsolid(1);
        scripts\cp\utility::allow_player_ignore_me(0);
      } else if(isDefined(level.interiordoor) && isbuiltinfunction(level.interiordoor)) {
        self.health = 1;
        var_2 = 0;
        self[[level.interiordoor]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
        var_2 = self.health + 100000;

        if(var_8 == "_encstr_A32D07CFD14BAA94D0")
          var_8 = "_encstr_952B0C65857BBFB80F9FC0B8A75A";

        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      } else if(istrue(self.isjuggernaut)) {
        self waittill("_encstr_88B00FB037873113F3557705AB596B58EC");
        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
      } else if(isDefined(self.vehicle)) {
        scripts\engine\utility::_id_143BA(2, "_encstr_9A010FA803DC612103C7A415D81FA90987", "_encstr_A9130DC330104912F19DE1677B831B");
        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
        self disableusability();
      } else
        self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    } else
      self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  }

  damageshellshockandrumble(var_0, var_5, var_4, var_2, var_3, var_1);
}

_startragdoll(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("_encstr_AD75063D571AE108");
  var_3 = var_0 getcorpseanim();
  var_4 = undefined;
  var_5 = getanimlength(var_3);
  var_6 = undefined;
  var_7 = animhasnotetrack(var_3, "_encstr_8DD20EA40BA09F1B7D3EEA12A3CFCF57");
  var_8 = animhasnotetrack(var_3, "_encstr_88E316B9B510AF5BC80F2E08C2CFE75BD63C9914C7138353");
  var_9 = animhasnotetrack(var_3, "_encstr_ABF60BCDBDFA39C23B46BDB163");
  var_10 = animhasnotetrack(var_3, "_encstr_A6B50E7F1099CAFB7FFE960FED37326C");
  var_4 = 0;

  if(var_10) {
    var_11 = getnotetracktimes(var_3, "_encstr_A6B50E7F1099CAFB7FFE960FED37326C")[0];
    var_4 = var_11 * var_5;
  }

  wait(var_4);

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_0 isragdoll())
    var_0 startragdoll();

  if(var_7 || var_8) {
    var_12 = var_5;

    if(var_8)
      var_5 = var_5 + 3;

    if(isDefined(var_4))
      var_12 = var_12 - var_4;

    wait(var_12);
    var_0 delete();
  } else
    var_0 setplayercorpsedone();
}

callback_killingblow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && var_2 >= self.health && isDefined(self.combathigh) && self.combathigh == "_encstr_A7CF1212F71BE2B1F1803B1701A97E5AE7871D0F") {
    scripts\cp\utility::giveperk("_encstr_A7CF1212F71BE2B1F1803B1701A97E5AE7871D0F");
    return 0;
  }

  return 1;
}

_id_127E1() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A5510A30AA778D28B3C97D51");
  self waittill("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");
  wait 0.1;

  if(!self.inlaststand)
    self suicide();
}

damageshellshockandrumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread onweapondamage(var_0, var_1, var_2, var_3, var_5);

  if(!isai(self))
    self playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
}

onweapondamage(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  switch (var_1) {
    default:
      if(allowshellshockondamage(var_1) && !isai(var_4))
        scripts\cp\cp_weapon::shellshockondamage(var_2, var_3);

      break;
  }
}

allowshellshockondamage(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_AF671089643BA7481348C3EA2017475B29CB":
      case "_encstr_BE1A18D8D0BD0783B227BE317BB9CDEB5BA5CD4BCEABE67DB138":
        return 0;
    }
  }

  return 1;
}

istacticaldamage(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_1) || var_1 == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 0;

  switch (var_0.basename) {
    case "_encstr_AA830D5B0B32A731FF4BE57F38FD73":
    case "_encstr_BDC9145E757AAF080F8FF0B1DF4A81FD021F45488DC3":
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
    case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
      return 1;
    case "_encstr_84661447C3CBFCDDDB636EC17A098B7753F83A0F1859":
    case "_encstr_92EA0A290B32FF88A90170EB":
      return 0;
    default:
      return 0;
  }
}

damage_should_ignore_blast_shield(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_0, var_1, undefined, var_2, var_3, var_4);

  if(var_3 == "_encstr_911B0C7DA090E9A7F799FD50DD48")
    return 1;

  if(var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F")
    return 1;

  if(isDefined(var_0) && var_0 == var_1)
    return 1;

  if(var_1 scripts\cp_mp\utility\damage_utility::isstuckdamage(var_6))
    return 1;

  if(weaponignoresblastshield(var_2, var_5))
    return 1;

  return 0;
}

weaponignoresblastshield(var_0, var_1) {
  var_2 = var_0.basename;

  if(scripts\cp\utility::issuperweapon(var_2))
    return 1;

  switch (var_2) {
    case "_encstr_93EF10678060C4934B101AD460275AA7A890":
    case "_encstr_A3DA1116382CC6D056BE8EAE27E42BA3AFB583":
    case "_encstr_A2950D16C9E8D2361B59932FF55BC1":
    case "_encstr_8DCB0F47F22330CEE7996B13A2E390583A":
    case "_encstr_95E70D8EDBDA85F5839CED35F5B683":
    case "_encstr_AC740FAA3BF169D025C6A373200C27E06B":
    case "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E":
    case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
    case "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898":
    case "_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E":
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
    case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
    case "_encstr_99410C4B48C39AB7D0CD95B769DB":
    default:
      return 1;
    default:
      return 0;
  }
}

modifydamagegeneral(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_5 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && var_3 != 1) {
    var_3 = var_3 * getdvarfloat("_encstr_957C12339F73694AF85AD35DD79258EFD8B98238");
    var_3 = int(var_3);
  }

  if(isDefined(level.modifyplayerdamage_relics) && isarray(level.modifyplayerdamage_relics)) {
    foreach(var_12 in level.modifyplayerdamage_relics)
    var_3 = [[var_12]](var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(level.modifyplayerdamage))
    var_3 = [[level.modifyplayerdamage]](var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9);

  if(!isDefined(var_2.donotmodifydamage))
    var_3 = int(var_3 * var_2 scripts\cp\utility::getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_5, var_6, var_9));

  if(scripts\cp\utility::tryingtoleave())
    return var_3;

  if(isPlayer(self)) {
    if(isDefined(var_1) && isagent(var_1) && !isexplosivedamagemod(var_5) && !isenemyinfrontofme(var_1) && !istrue(var_5 == "_encstr_8DED0A21C79B660BC7588981"))
      var_3 = var_3 * 0.5;
  }

  return var_3;
}

damageinvulnerability(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getinvultime();
  enabledamageinvulnerability();
  wait(var_7);
  disabledamageinvulnerability();
}

shoulddodamageinvulnerabilty(var_0) {
  if(scripts\engine\utility::ent_flag("_encstr_82D81E47C480B3DD42B8ED8386C7D66895DB8F2FF050AD61A64EBE7D53394EC8"))
    return 0;

  if(damageflag(1))
    return 0;

  return 1;
}

getinvultime() {
  return self.gs.invultime_ondamagemin;
}

enabledamageinvulnerability() {
  scripts\engine\utility::ent_flag_set("_encstr_82D81E47C480B3DD42B8ED8386C7D66895DB8F2FF050AD61A64EBE7D53394EC8");
  self.attackeraccuracy = 0;
  self.ignorerandombulletdamage = 1;
}

disabledamageinvulnerability() {
  scripts\engine\utility::ent_flag_clear("_encstr_82D81E47C480B3DD42B8ED8386C7D66895DB8F2FF050AD61A64EBE7D53394EC8");
  scripts\cp\cp_gameskill::update_player_attacker_accuracy();
}

deathshieldinvulnerability(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getdeathsshieldduration();
  var_8 = getdeathsdoorduration();

  if(!scripts\cp\utility::tryingtoleave())
    var_7 = getdvarint("_encstr_8F8B0C87060369D7CC9F19C94A0F", 1);

  setdamageflag(1, 1);
  enabledamageinvulnerability();
  enabledeathsdoor();
  var_9 = level.framedurationseconds * 1000 * 40;

  if(istrue(level._id_12BAC))
    var_9 = level.framedurationseconds * 1000 * 10;

  self.damageshieldexpiretime = gettime() + var_9;

  if(!istrue(self.adrenalinepoweractive))
    _id_1433E(var_7, "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");

  setdamageflag(1, 0);
  disabledamageinvulnerability();

  if(!istrue(self.adrenalinepoweractive))
    _id_1433E(var_8, "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");

  disabledeathsdoor();
}

_id_1433E(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
}

getdeathsdoorduration() {
  return self.gs.deathsdoorduration;
}

getdeathsshieldduration() {
  return self.gs.invultime_deathshieldduration * self.gs.scripteddeathshielddurationscale;
}

enabledeathsdoor() {
  setdamageflag(2, 1);

  if(!scripts\cp_mp\utility\player_utility::_id_12510()) {
    var_0 = 0.5;
    var_1 = 2 + getdeathsdoorduration() + gethealthregentime() - var_0;
    thread deathsdooroverlaypulse(var_1);
    var_2 = 0.5;
    var_3 = var_1 - var_2;
    thread bloodoverlay(1, var_3, var_2);
    updatedeathsdoorvisionset();
    self painvisionon();
  }
}

deathsdooroverlaypulse(var_0) {
  self notify("_encstr_B18C10D58D6F63212AB87870330AC3B88F35");
  self endon("_encstr_B18C10D58D6F63212AB87870330AC3B88F35");
  self endon("_encstr_923611D7F1A013400B28652523C8AA0A0F436F");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 1;
  thread lerpdeathsdoorpulsenorm(var_0);

  while(var_1 > 0) {
    var_2 = gettime();
    var_3 = var_2;
    var_4 = scripts\engine\math::factor_value(1000, 600, self.deathsdoorpulsenorm);

    while(var_2 < var_3 + var_4) {
      var_2 = gettime();
      var_5 = 0.1;
      var_6 = 0.4;
      var_7 = (var_2 - var_3) / var_4;
      var_8 = scripts\engine\math::normalized_cos_wave(var_7);
      var_1 = scripts\engine\math::factor_value(var_5, var_6, var_8);
      var_1 = var_1 * self.deathsdoorpulsenorm;
      self.damage.deathsdooroverlaypulse fadeovertime(0.05);
      self.damage.deathsdooroverlaypulse.alpha = var_1;
      waitframe();
    }
  }
}

deathsdooroverlaypulsefinal() {
  self.damage.deathsdooroverlaypulse fadeovertime(0.05);
  self.damage.deathsdooroverlaypulse.alpha = 0.7;
  waitframe();
  self.damage.deathsdooroverlaypulse fadeovertime(0.5);
  self.damage.deathsdooroverlaypulse.alpha = 0.4;
}

bloodoverlay(var_0, var_1, var_2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }
  self endon("_encstr_923611D7F1A013400B28652523C8AA0A0F436F");
  self.damage.bloodoverlay fadeovertime(0.05);
  self.damage.bloodoverlay.alpha = var_0;
  _id_1433E(var_1, "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");

  if(var_2 <= 0)
    var_2 = 1;

  self.damage.bloodoverlay fadeovertime(var_2);
  self.damage.bloodoverlay.alpha = 0;
}

updatedeathsdoorvisionset() {
  if(!damageflag(2))
    return 0;

  if(self isnightvisionon() || scripts\cp_mp\utility\game_utility::isnightmap())
    visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "_encstr_A2220E0B57101A7187E131FDDADFAB8B", "_encstr_ABC90B462C5B0B76CABE37D99D"), 0);
  else
    visionsetpain("_encstr_9B0E08E058D2B9D7B538");
}

disabledeathsdoor(var_0) {
  self notify("_encstr_A20E12ABEB8E225248890F4F21A090DBFD0F7F7B");
  self endon("_encstr_A20E12ABEB8E225248890F4F21A090DBFD0F7F7B");

  if(!isDefined(var_0))
    var_0 = 0;

  if(!var_0)
    var_1 = gethealthregentime();
  else
    var_1 = 0.0;

  var_2 = getvisionlerprate(var_1);
  setdamageflag(2, 0);
}

getvisionlerprate(var_0) {
  var_1 = 1 / max(0.01, var_0);
  return clamp(var_1, 0, 30);
}

lerpdeathsdoorpulsenorm(var_0) {
  self notify("_encstr_AF891380E7BBF971DBC94B04C07FF8AF60A50DE081");
  self endon("_encstr_AF891380E7BBF971DBC94B04C07FF8AF60A50DE081");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = var_0;
  self.deathsdoorpulsenorm = 1;

  while(var_1 > 0) {
    self.deathsdoorpulsenorm = scripts\engine\math::normalize_value(0, var_0, var_1);
    self.deathsdoorpulsenorm = scripts\engine\math::normalized_float_smooth_out(self.deathsdoorpulsenorm);
    var_1 = var_1 - 0.05;
    waitframe();
  }

  self.deathsdoorpulsenorm = 0;
}

shouldactivatedeathshield(var_0) {
  if(scripts\engine\utility::flag_exist("_encstr_BE331528AF7B29C53AAF40D587C221B0EF6FD0C8E70CC1") && scripts\engine\utility::flag("_encstr_BE331528AF7B29C53AAF40D587C221B0EF6FD0C8E70CC1"))
    return 0;

  if(damageflag(1))
    return 0;

  if(damageflag(2))
    return 0;

  return 1;
}

damageflag(var_0) {
  return self.damage.flags &var_0;
}

setdamageflag(var_0, var_1) {
  if(var_1)
    self.damage.flags = self.damage.flags | var_0;
  else
    self.damage.flags = self.damage.flags &~var_0;
}

initplayerdamagefunctions() {
  initplayerentflags();
  initplayerdamage();
  self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 0);
  self setclientomnvar("_encstr_970213DFDBA87265587B353E3060AD9BAF49076399", "_encstr_848A120FAB6B37CEC4D1C3791B28D76EB83D8582");
}

initplayerentflags() {
  scripts\engine\utility::ent_flag_init("_encstr_8711139DC6DB31B036F5865ACD8EEBA5DCBEAB6EAC");
  scripts\engine\utility::ent_flag_init("_encstr_82D81E47C480B3DD42B8ED8386C7D66895DB8F2FF050AD61A64EBE7D53394EC8");
}

initplayerdamage() {
  self.damage = spawnStruct();
  self.damage.impactsfx = scripts\engine\utility::spawn_script_origin();
  self.damage.impactsfx linkTo(self);
  self.damage.pulsesfx = scripts\engine\utility::spawn_script_origin();
  self.damage.pulsesfx linkTo(self);
  self.damage.activescreeneffectoverlays = [];
  self.damage.flags = 0;
  self.damage.firedamage = 0;
  self.damage.firehealth = 100;
  self.damage.altdirectionalbloodoverlay = 0;
  self.damage.lastdiretionalbloodtime = -99999;
  initdamageoverlay();
  initdeathsdooroverlaypulse();
  initbloodoverlay();
}

initdamageoverlay() {
  self.damage.overlay = newclienthudelem(self);
  self.damage.overlay.sort = 2;
  self.damage.overlay.x = 0;
  self.damage.overlay.y = 0;
  self.damage.overlay.alignx = "_encstr_A5AD056A019C63";
  self.damage.overlay.aligny = "_encstr_AC190479FF92";
  self.damage.overlay.foreground = 0;
  self.damage.overlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.overlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.overlay.alpha = 0;
  self.damage.overlay.enablehudlighting = 1;
  self.damage.overlay.lowresbackground = 1;
  self.damage.overlay setshader("_encstr_BEED1EED4B6182131782E29B2EF75FBC80BF7441EB488FFFD078CB9293C19770", 640, 480);
}

initfiredamageoverlay() {
  self.damage.firedamageoverlay = newclienthudelem(self);
  self.damage.firedamageoverlay.sort = -1;
  self.damage.firedamageoverlay.x = 0;
  self.damage.firedamageoverlay.y = 0;
  self.damage.firedamageoverlay.alignx = "_encstr_A5AD056A019C63";
  self.damage.firedamageoverlay.aligny = "_encstr_AC190479FF92";
  self.damage.firedamageoverlay.foreground = 0;
  self.damage.firedamageoverlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.firedamageoverlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.firedamageoverlay.alpha = 0;
  self.damage.firedamageoverlay.enablehudlighting = 1;
  self.damage.firedamageoverlay.lowresbackground = 1;
  self.damage.firedamageoverlay setshader("_encstr_B8981CBA4BBE0ED8C25EB293F5832C4B377DCC963956AFDBEC56938DC2F2", 640, 480);
}

initfirepainoverlay() {
  self.damage.firepainoverlay = newclienthudelem(self);
  self.damage.firepainoverlay.sort = -2;
  self.damage.firepainoverlay.x = 0;
  self.damage.firepainoverlay.y = 0;
  self.damage.firepainoverlay.alignx = "_encstr_A5AD056A019C63";
  self.damage.firepainoverlay.aligny = "_encstr_AC190479FF92";
  self.damage.firepainoverlay.foreground = 0;
  self.damage.firepainoverlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.firepainoverlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.firepainoverlay.alpha = 0;
  self.damage.firepainoverlay.enablehudlighting = 1;
  self.damage.firepainoverlay.lowresbackground = 1;
  self.damage.firepainoverlay setshader("_encstr_AC761EEBAACF0B502102F773388A196013B1C9FF89712FEB37E50382FAB9EF2B", 640, 480);
}

initdeathsdooroverlaypulse() {
  self.damage.deathsdooroverlaypulse = newclienthudelem(self);
  self.damage.deathsdooroverlaypulse.sort = 0;
  self.damage.deathsdooroverlaypulse.x = 0;
  self.damage.deathsdooroverlaypulse.y = 0;
  self.damage.deathsdooroverlaypulse.alignx = "_encstr_A5AD056A019C63";
  self.damage.deathsdooroverlaypulse.aligny = "_encstr_AC190479FF92";
  self.damage.deathsdooroverlaypulse.foreground = 0;
  self.damage.deathsdooroverlaypulse.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.deathsdooroverlaypulse.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.deathsdooroverlaypulse.alpha = 0;
  self.damage.deathsdooroverlaypulse.enablehudlighting = 1;
  self.damage.deathsdooroverlaypulse.lowresbackground = 1;
  self.damage.deathsdooroverlaypulse setshader("_encstr_AD7F285796EBC1630B2F569CBE38C2A537AF23AC0B4743DC23DEEDC9F583BAB1E62BBE7BB32B4E632CBC", 640, 480);
}

initbloodoverlay() {
  self.damage.bloodoverlay = newclienthudelem(self);
  self.damage.bloodoverlay.sort = 1;
  self.damage.bloodoverlay.x = 0;
  self.damage.bloodoverlay.y = 0;
  self.damage.bloodoverlay.alignx = "_encstr_A5AD056A019C63";
  self.damage.bloodoverlay.aligny = "_encstr_AC190479FF92";
  self.damage.bloodoverlay.foreground = 0;
  self.damage.bloodoverlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.bloodoverlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.damage.bloodoverlay.alpha = 0;
  self.damage.bloodoverlay.enablehudlighting = 1;
  self.damage.bloodoverlay.lowresbackground = 1;
  self.damage.bloodoverlay setshader("_encstr_AA6C1DF347D62B401F238D5636EF2AD708B12A3A987F9259EDDE3913AA47D0", 640, 480);
}

damageui(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  childthread takecoverwarning(var_0, var_1, var_2, var_3, var_4);
}

takecoverwarning(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();

  if(shouldshowcoverwarning(var_5)) {
    self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 1);
    wait 1;
    self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 2);
    wait 1;
    self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 3);
    wait 1;
    self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 4);
    wait 1;
    self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 5);
    wait 1;
    self setclientomnvar("_encstr_ADD1141D20997F2BD98348BF1F7B6272B7EBB91E3878", 0);
  }
}

shouldshowcoverwarning(var_0, var_1) {
  if(van_initdamage())
    return 0;

  if(self islinked())
    return 0;

  if(self.ignoreme)
    return 0;

  if(isDefined(self.vehicle))
    return 0;

  if(!damageflag(1))
    return 0;

  if(damageflag(8))
    return 0;

  if(istrue(self.disabletakecoverwarning))
    return 0;

  return 1;
}

damageeffects(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1) || van_initdamage()) {
    return;
  }
  var_7 = [::damagerumble, ::damagebloodoverlay, ::damagepainvision, ::damagescreenshake, ::updatedamageoverlay, ::damageshock];
  var_8 = damageratio(var_0);

  foreach(var_10 in var_7)
  self childthread[[var_10]](var_1.origin, var_8, var_4);
}

damageratio(var_0) {
  return scripts\engine\math::normalize_value(40, 160, var_0 / self.damagemultiplier);
}

damagesfx(var_0, var_1, var_2) {
  self endon("_encstr_AB910E7DE9DD6B3C67D907E6899DD860");

  if(!scripts\cp\cp_armor::player_have_armor(self)) {
    var_3 = "_encstr_815A18590B9B1040BA155B3031925031D2B7D9FFF7B24F80C3AB";
    var_4 = "_encstr_8B74153B2D4AC10E63DF93B1C3994F88F9054690558950";
  } else {
    var_3 = "_encstr_AFC21E03198649C82040BB457E98F5B251939B47FBA10391C04B79CE3308270B";
    var_4 = "_encstr_95B8154B0A45296BD62D414D50897050F011F3034B18CB";
  }

  self.damage.impactsfx playSound(var_3);
  wait 0.25;

  if(!damageflag(4)) {
    var_5 = scripts\engine\math::factor_value(0.75, 1.75, var_1);
    self.damage.impactsfx playSound(var_4);
    setdamageflag(4, 1);
    scripts\engine\utility::delaythread(3.0, ::setdamageflag, 4, 0);
  }
}

damagerumble(var_0, var_1, var_2) {
  if(var_1 > 0.4)
    self playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
  else
    self playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
}

damageradialdistortion(var_0, var_1, var_2) {
  self endon("_encstr_923611D7F1A013400B28652523C8AA0A0F436F");

  if(damageflag(32)) {
    return;
  }
  var_3 = scripts\engine\math::factor_value(0.045, 0.045, var_1);
  var_4 = scripts\engine\math::factor_value(0.09, 0.09, var_1);
  var_5 = scripts\engine\math::factor_value(0.2, 0.2, var_1);
  radial_distortion(var_3, var_4, var_5, var_0);
}

radial_distortion(var_0, var_1, var_2, var_3, var_4) {
  self notify("_encstr_8E9E11C95819960B63114B6E1DDE273AD2DEE6");
  self endon("_encstr_8E9E11C95819960B63114B6E1DDE273AD2DEE6");
  self setclientdvar("_encstr_8A310BE1041BC7CB4519391151", var_0);
  self setclientdvar("_encstr_96D10B395A2A949A4D51D42915", -1);
  self setclientdvar("_encstr_8F260BC11E9D5939F9EF71E331", var_1);

  if(isDefined(var_3)) {
    self setclientdvar("_encstr_970F0B1DCFB1AFE1C085D78FBD", 1);
    self setclientdvar("_encstr_85140B4002713B9F95FFA127FD", var_3);
  }

  if(isDefined(var_4)) {
    if(isstring(var_4)) {
      self endon(var_4);
      thread removeradialdistortion_notify(var_4);
    } else if(isarray(var_4)) {
      foreach(var_6 in var_4) {
        self endon(var_6);
        thread removeradialdistortion_notify(var_6);
      }
    }
  }

  if(isDefined(var_2))
    removeradialdistortion(var_2);
}

lerp_saveddvar(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  self notify(var_0 + "_encstr_8B1510D751A0125338F3B2CB198DDB4BE815");
  self endon(var_0 + "_encstr_8B1510D751A0125338F3B2CB198DDB4BE815");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  if(var_6 > 0) {
    for(var_7 = var_4 / var_6; var_6; var_6--) {
      var_3 = var_3 + var_7;
      self setclientdvar(var_0, var_3);
      wait(var_5);
    }
  }

  self setclientdvar(var_0, var_1);
}

removeradialdistortion(var_0) {
  childthread lerp_saveddvar("_encstr_8A310BE1041BC7CB4519391151", 0, var_0);
  childthread lerp_saveddvar("_encstr_96D10B395A2A949A4D51D42915", 0, var_0);
  childthread lerp_saveddvar("_encstr_8F260BC11E9D5939F9EF71E331", 0, var_0);
  childthread lerp_saveddvar("_encstr_970F0B1DCFB1AFE1C085D78FBD", 0, var_0);
}

removeradialdistortion_notify(var_0) {
  self waittill(var_0);
  self setclientdvar("_encstr_8A310BE1041BC7CB4519391151", 0);
  self setclientdvar("_encstr_96D10B395A2A949A4D51D42915", 0);
  self setclientdvar("_encstr_8F260BC11E9D5939F9EF71E331", 0);
  self setclientdvar("_encstr_970F0B1DCFB1AFE1C085D78FBD", 0);
}

damagepainvision(var_0, var_1, var_2) {
  self endon("_encstr_AB910E7DE9DD6B3C67D907E6899DD860");

  if(!shoulddopainvision())
    return 0;

  if(!scripts\cp\cp_armor::has_armor(self)) {
    if(self isnightvisionon() || scripts\cp_mp\utility\game_utility::isnightmap())
      visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "_encstr_A2220E0B57101A7187E131FDDADFAB8B", "_encstr_ABC90B462C5B0B76CABE37D99D"), 0);
    else
      visionsetpain("_encstr_9B0E08E058D2B9D7B538");

    var_3 = scripts\engine\math::factor_value(0.0, 0.0, var_1);
    var_4 = scripts\engine\math::factor_value(1.9, 1.9, var_1);
    var_5 = scripts\engine\math::factor_value(0.05, 0.05, var_1);
  } else {
    visionsetpain(scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "_encstr_A2220E0B57101A7187E131FDDADFAB8B", "_encstr_AAA90DC8997239892BC76FFDA3E04A"), 0);
    var_3 = scripts\engine\math::factor_value(0.0, 0.0, var_1);
    var_4 = scripts\engine\math::factor_value(1.9, 1.9, var_1);
    var_5 = scripts\engine\math::factor_value(0.05, 0.05, var_1);
  }

  self painvisionon();
  wait(var_5);
  self painvisionoff();
}

shoulddopainvision() {
  if(damageflag(2))
    return 0;

  if(self.health == 1)
    return 0;

  return 1;
}

damagescreenshake(var_0, var_1, var_2) {
  var_3 = scripts\engine\math::factor_value(0.82, 1.2, var_1);
  var_4 = scripts\engine\math::factor_value(0.65, 0.8, var_1);
  var_5 = scripts\engine\math::factor_value(0.68, 1.25, var_1);
  var_6 = scripts\engine\math::factor_value(1.12, 1.85, var_1);
  var_7 = scripts\engine\math::factor_value(0.1, 0.32, var_1);
  var_8 = var_6 - var_7 - 0.05;

  if(isexplosivedamagemod(var_2)) {
    var_3 = var_3 * 5;
    var_4 = var_4 * 5;
    var_5 = var_5 * 5;
  }
}

updatedamageoverlay(var_0, var_1, var_2) {
  self endon("_encstr_AB910E7DE9DD6B3C67D907E6899DD860");
  self endon("_encstr_923611D7F1A013400B28652523C8AA0A0F436F");

  if(scripts\cp_mp\utility\player_utility::_id_12510()) {
    return;
  }
  if(!scripts\cp\cp_armor::has_armor(self)) {
    self.damage.overlay setshader("_encstr_BEED1EED4B6182131782E29B2EF75FBC80BF7441EB488FFFD078CB9293C19770", 640, 480);
    var_3 = 0.8;
  } else {
    self.damage.overlay setshader("_encstr_BEED1EED4B6182131782E29B2EF75FBC80BF7441EB488FFFD078CB9293C19770", 640, 480);
    var_3 = 0.6;
  }

  self.damage.overlay fadeovertime(0.05);
  self.damage.overlay.alpha = max(self.damage.overlay.alpha, var_3);
  wait 0.05;
  var_4 = scripts\engine\math::factor_value(0.2, 0.2, var_1);
  self.damage.overlay fadeovertime(var_4);
  self.damage.overlay.alpha = 0;
}

damagebloodoverlay(var_0, var_1, var_2) {
  damagebloodoverlayfullscreen(var_0, var_1, var_2);
}

damagebloodoverlaydirectional(var_0, var_1, var_2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }
  var_3 = gettime();

  if(var_3 - self.damage.lastdiretionalbloodtime < 200)
    return;
  else
    self.damage.lastdiretionalbloodtime = var_3;

  var_4 = ["_encstr_911B0C7DA090E9A7F799FD50DD48", "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421"];
  var_5 = ["_encstr_84670F0D974DCF124E3F7A931851A1FB9F", "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B", "_encstr_B45C0E2DFF41B17F437FB870E733FBFF"];
  var_6 = getplayersidesfromposition(var_0);
  var_7 = "_encstr_B40101";

  if(scripts\engine\utility::array_contains(var_4, var_1)) {
    return;
  }
  if(scripts\engine\utility::array_contains(var_5, var_1))
    var_8 = "_encstr_977711D0B3FD31837F8A4DB57E67A9E3A20BA1";
  else if(!scripts\cp\cp_armor::has_armor(self)) {
    var_8 = "_encstr_86E7123B0828C49B778EE79FF867C29C10708B57";

    if(self.damage.altdirectionalbloodoverlay) {
      var_7 = "_encstr_874305A1720B08";
      self.damage.altdirectionalbloodoverlay = 0;
    } else
      self.damage.altdirectionalbloodoverlay = 1;
  } else
    var_8 = "_encstr_AA6512CC57B1639B8D9CCA959BD7C2936BED93AF";

  if(!isDefined(var_2))
    var_2 = 2.0;

  foreach(var_13, var_1 in var_6) {
    var_10 = var_8 + var_13;
    var_11 = var_10 + "_encstr_A5AD0859C39703EE2011";
    var_10 = var_10 + var_7;
    var_12 = createscreeneffectoffsets(randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
    createscreeneffect(var_13, var_10, 0.15, var_2, var_12, 1);
    createscreeneffect(var_13, var_11, 0.15, 0.15, var_12, 0);
  }
}

damagebloodoverlayfullscreen(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\player_utility::_id_12510()) {
    return;
  }
  if(damageflag(2)) {
    return;
  }
  if(istrue(self.isjuggernaut)) {
    return;
  }
  var_3 = scripts\engine\math::factor_value(0.6, 0.3, healthratio());
  var_4 = gethealthregendelay();
  var_5 = gethealthregentime();
  thread bloodoverlay(var_3, var_4, var_5);
}

damageshock(var_0, var_1, var_2) {
  if(isexplosivedamagemod(var_2)) {
    var_3 = scripts\engine\math::factor_value(2, 3, var_1);
    self shellshock("_encstr_A1AF126BBB9AA198BBC8B75B7170474B572B8DB5", var_3);
  }
}

healthratio() {
  return self.health / self.maxhealth;
}

createscreeneffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newclienthudelem(self);
  var_6.sort = 3;
  var_6.foreground = 0;
  var_6.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_6.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_6.alpha = 0;
  var_6.enablehudlighting = 1;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = scripts\engine\math::factor_value(0.9, 1.0, var_4["_encstr_B8FB06FF970A2908"]);

  switch (var_0) {
    case "_encstr_A5AD056A019C63":
      var_6.aligny = "_encstr_AC190479FF92";
      var_6.alignx = "_encstr_A5AD056A019C63";
      var_7 = -640;
      var_8 = scripts\engine\math::factor_value(-30, 30, var_4["_encstr_AA4C0279"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::factor_value(-55, 0, var_4["_encstr_814C02A2"]);
      break;
    case "_encstr_8253060E2B5FE330":
      var_6.aligny = "_encstr_AC190479FF92";
      var_6.alignx = "_encstr_8253060E2B5FE330";
      var_7 = 1280;
      var_8 = scripts\engine\math::factor_value(-30, 30, var_4["_encstr_AA4C0279"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::factor_value(0, 55, var_4["_encstr_814C02A2"]) + 640;
      break;
    case "_encstr_A146078E65FB5158DD":
      var_6.aligny = "_encstr_A146078E65FB5158DD";
      var_6.alignx = "_encstr_A5AD056A019C63";
      var_8 = 960;
      var_7 = scripts\engine\math::factor_value(-50, 50, var_4["_encstr_814C02A2"]);
      var_10 = scripts\engine\math::factor_value(0, 50, var_4["_encstr_AA4C0279"]);
      var_10 = var_10 + 480;
      var_9 = var_7;
      break;
  }

  var_6.x = var_7;
  var_6.y = var_8;
  var_6 setshader(var_1);
  thread screeneffectcleanup(var_6);
}

animatescreeneffect(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("_encstr_82A71A087AF2D97B8739EE763DF7A0F31FF288A883050551DB448FEB");

  if(!var_6) {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0 moveovertime(var_1);
    var_0.x = var_3;
    var_0.y = var_4;
    var_1 = 0.05;
    var_0.alpha = 1;
    wait 0.05;
  } else {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0.x = var_3;
    var_0.y = var_4;
    wait 0.15;
    var_0 fadeovertime(var_1);
    var_0.alpha = 1;
    wait(var_1);
  }

  var_0 fadeovertime(var_2);
  var_0.alpha = 0;
  wait(var_2 + 0.05);
  var_0 notify("_encstr_82A71A087AF2D97B8739EE763DF7A0F31FF288A883050551DB448FEB");
}

screeneffectcleanup(var_0) {
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_add(self.damage.activescreeneffectoverlays, var_0);
  var_0 waittill("_encstr_82A71A087AF2D97B8739EE763DF7A0F31FF288A883050551DB448FEB");
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_remove(self.damage.activescreeneffectoverlays, var_0);
  var_0 destroy();
}

createscreeneffectoffsets(var_0, var_1, var_2) {
  var_3 = [];
  var_3["_encstr_814C02A2"] = var_0;
  var_3["_encstr_AA4C0279"] = var_1;
  var_3["_encstr_B8FB06FF970A2908"] = var_2;
  return var_3;
}

getplayersidesfromposition(var_0) {
  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];

  if(abs(var_4) > 0.819152)
    var_6["_encstr_A146078E65FB5158DD"] = 1;
  else if(var_5 > 0)
    var_6["_encstr_8253060E2B5FE330"] = 1;
  else
    var_6["_encstr_A5AD056A019C63"] = 1;

  return var_6;
}

oldhealthregen(var_0, var_1) {
  self notify("_encstr_AA7D13C37B919B5363C2E994D398B2CB9A93219A3B");
  self endon("_encstr_AA7D13C37B919B5363C2E994D398B2CB9A93219A3B");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(self.selfdamaging) && self.selfdamaging)
    wait 0.2;

  if(scripts\cp\utility::ishealthregendisabled()) {
    return;
  }
  var_2 = spawnStruct();
  scripts\cp\utility::getregendata(var_2);
  wait(var_2.activatetime);
  var_3 = gettime();

  for(;;) {
    var_4 = scripts\cp\cp_laststand::gethealthcap();
    var_2 = spawnStruct();
    scripts\cp\utility::getregendata(var_2);
    var_1 = self.health / self.maxhealth;

    if(self.health < int(var_4)) {
      var_5 = int(self.health + var_2.regenamount);

      if(var_5 > var_4)
        var_5 = var_4;

      self.health = var_5;
    } else
      break;

    scripts\engine\utility::_id_143B9(var_2.waittimebetweenregen, "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
  }

  self notify("_encstr_8FB50718DD41DB3FA9");

  if(isDefined(level.playerinitinvulnerability))
    self[[level.playerinitinvulnerability]]();

  scripts\cp\utility::resetattackerlist();
}

core_health_regen() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_86BE0AA88AC3514E3BD5078D");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AF("_encstr_B2BE0788BAF573592F", "_encstr_864C1459EDDEE045DB8163C97BFFE8903247F5C39487", "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5", "_encstr_BA891ABEBD416B9F59A32FE72B0A2528B2C541B33D013F081591E2BA");

    if(var_0 == "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5") {
      regenerate_health();
      continue;
    }

    if(!scripts\cp\utility::canregenhealth()) {
      continue;
    }
    _id_12ACE();
    regenerate_health();
  }
}

_id_12ACE() {
  self endon("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
  var_0 = gethealthregendelay();
  wait(var_0);

  while(damageflag(2) || damageflag(32))
    waitframe();
}

regenerate_health() {
  var_0 = self.health;
  thread scripts\cp\utility::breathingmanager(gettime(), healthratio());

  while(self.health < self.maxhealth) {
    var_1 = gethealthregenpersecond();
    var_2 = var_1 * 0.05;
    var_0 = clamp(var_0 + var_2, 0, self.maxhealth);
    set_normalhealth(var_0 / self.maxhealth);
    waitframe();
  }

  self notify("_encstr_8FB50718DD41DB3FA9");
}

gethealthregenpersecond() {
  var_0 = 1;

  if(istrue(self.adrenalinepoweractive))
    var_0 = var_0 * 10;
  else if(scripts\cp\utility::_hasperk("_encstr_977E25B90ECAB14BC2C6D1CBF5935932D58D59D74E593B2BDCD791AC6316F2EBF69BAFDA961BB1")) {
    if(isDefined(self.hostdamagefactormedium) && self.hostdamagefactormedium > 2)
      var_0 = var_0 * 2;
  }

  return var_0 * self.gs.healthregenrate;
}

getfireinvulseconds() {
  return self.gs.healthfireinvulseconds;
}

getfireengulfrate() {
  return self.gs.healthfireengulfrate;
}

gethealthregentime() {
  var_0 = self.maxhealth - self.health;
  var_1 = var_0 / gethealthregenpersecond();
  return var_1;
}

gethealthregendelay() {
  return self.gs.healthregendelay;
}

set_normalhealth(var_0) {
  self setnormalhealth(var_0);
  self.lasthealth = self.health;
}

getmodifiedantikillstreakdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_3 = handleshotgundamage(var_1, var_2, var_3);
  var_3 = handleapdamage(var_1, var_2, var_3, var_0);
  var_11 = var_1.isalternatemode;
  var_12 = 0;

  if(istrue(var_11)) {
    var_13 = scripts\cp\utility::getweaponattachmentsbasenames(var_1);

    foreach(var_15 in var_13) {
      if(var_15 == "_encstr_8A07035972") {
        var_12 = 1;
        break;
      }
    }
  }

  var_17 = undefined;

  if(var_2 != "_encstr_8DED0A21C79B660BC7588981") {
    switch (var_1.basename) {
      case "_encstr_A29408E6D5D6CAAF5B1C":
      case "_encstr_8DCB0F47F22330CEE7996B13A2E390583A":
        self.largeprojectiledamage = 1;
        self.killoneshot = 1;
        var_17 = 1;
        break;
      case "_encstr_B20A13E6C5D1CBAA99F8F2EA78F722FBC8225795DF":
      case "_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E":
      case "_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07":
      case "_encstr_AC740FAA3BF169D025C6A373200C27E06B":
      case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
      case "_encstr_AAC517BEE0390F6BED2A408B187B8722C6CF7429D2C0E94F20":
      case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
      case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
      case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
      case "_encstr_81430B218B3F7018458997D78A":
      case "_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB":
        self.largeprojectiledamage = 1;
        var_17 = var_5;
        break;
      case "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9":
      case "_encstr_95E70D8EDBDA85F5839CED35F5B683":
      case "_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1":
      case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
      case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
      case "_encstr_BE2610C077D0B2630B5683EB7B6E472168F1":
      case "_encstr_99E107C0F71E86B363":
      case "_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213":
      case "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0":
      case "_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148":
      case "_encstr_8CBA0AD33D120153A1AFA040":
      case "_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E":
      case "_encstr_A2CF0C31B4B37D985A2746D76B07":
      case "_encstr_B2F60B166F934917E1C5C7BA1B":
      case "_encstr_92B90BC2C11BBEE4AE6ED7AD0E":
      case "_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9":
      case "_encstr_A7A70785E89DD7AD0E":
      case "_encstr_A7AA0DE816C6D727DBCEB2C9EBB61C":
      case "_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43":
      case "_encstr_88E90F60526BE39B37B026C8BBEA614FB1":
      case "_encstr_8D7B0D3007F3805512A6C759B18AB1":
      case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      case "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E":
        self.largeprojectiledamage = 1;
        var_17 = var_6;
        break;
      case "_encstr_A2950D16C9E8D2361B59932FF55BC1":
      case "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579":
      case "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860":
      case "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B":
      case "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898":
      case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
      case "_encstr_9AAE0876FCB7603101DB":
      case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
      case "_encstr_92A70ABB8267F5E0D89F6351":
        self.largeprojectiledamage = 0;
        var_17 = var_7;
        break;
    }
  } else {
    self.largeprojectiledamage = 0;
    var_17 = var_8;
  }

  if(isDefined(var_10))
    self.largeprojectiledamage = var_10;

  if(isDefined(var_17) && isDefined(var_2) && (var_2 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_2 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" || var_2 == "_encstr_9B0D099AD3887D91252954" || var_2 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_2 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_2 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_2 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_2 == "_encstr_8DED0A21C79B660BC7588981"))
    var_3 = ceil(var_4 / var_17);

  var_18 = 0;

  if(isDefined(var_0) && isDefined(self.owner) && !var_18) {
    if(isDefined(var_0.owner))
      var_0 = var_0.owner;

    if(var_0 == self.owner && !istrue(self.killoneshot))
      var_3 = ceil(var_3 / 2);
  }

  return int(var_3);
}