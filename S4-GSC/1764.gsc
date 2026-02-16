/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1764.gsc
*************************************************/

issp() {
  if(!isDefined(level.issp)) {
    var_0 = getDvar("#x376847958d67972ef");
    var_1 = "";

    for(var_2 = 0; var_2 < min(var_0.size, 3); var_2++) {
      var_1 = var_1 + var_0[var_2];
    }

    level.issp = var_1 != "mp_" && var_1 != "cp_";
  }

  return level.issp;
}

iscp() {
  return scripts\engine\utility::string_starts_with(getDvar("#x376847958d67972ef"), "cp_");
}

_id_99D6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = [];
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(isDefined(level._id_5D6A) && isDefined([[level._id_5D6A]](var_0))) {
    var_4 = [[level._id_5D6A]](var_0);
  } else {
    var_4 = [[level._id_5D69]](var_0, var_1);
  }

  if(isent(self) && !isDefined(var_3)) {
    self setModel(getweaponmodel(var_4));
  }

  var_5 = getweaponattachmentworldmodels(var_4);

  foreach(var_7 in var_5) {
    if(istrue(var_2)) {
      var_8 = strtok(var_7, "_");

      foreach(var_11, var_10 in var_8) {
        if(var_11 == 0) {
          var_7 = var_10;
          continue;
        }

        if(var_10 == "wm") {
          var_7 = var_7 + "_vm";
          continue;
        }

        var_7 = var_7 + "_" + var_10;
      }
    }

    if(istrue(var_3)) {
      precachemodel(var_7);
      continue;
    }

    self attach(var_7);
  }

  if(!istrue(var_3)) {
    switch (var_0) {
      case "s4_pi_mike1911":
        self hidepart("j_b_loader");
        self hidepart("j_b_loader_01");
        self hidepart("j_b_loader_02");
        self hidepart("j_b_loader_03");
        self hidepart("j_b_loader_04");
        self hidepart("j_b_loader_05");
        self hidepart("j_b_loader_06");
        break;
      case "iw8_sh_romeo870":
        self hidepart("j_shell");
        self hidepart("j_shell_fired");
        break;
    }

    foreach(var_7 in var_5) {
      if(issubstr(var_7, "reflex")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_7, "holo")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_7, "acog")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_7, "snprscope")) {
        self hidepart("tag_sight_on");
      }
    }
  }
}

_id_99D5(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_4)) {
    var_5 = 0;

    if(isent(self) || isai(self)) {
      var_5 = 1;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(isDefined(level._id_5D6A) && isDefined([[level._id_5D6A]](var_0))) {
    var_6 = [[level._id_5D6A]](var_0);
  } else {
    var_6 = [[level._id_5D69]](var_0, var_1);
  }

  if(!istrue(var_4)) {
    if(isDefined(var_2)) {
      self attach(getweaponmodel(var_0), var_2);
    } else {
      self attach(getweaponmodel(var_0));
    }
  }

  self._id_1D85[0] = var_0;
  var_7 = getweaponattachmentworldmodels(var_6);

  foreach(var_9 in var_7) {
    if(istrue(var_3)) {
      var_10 = strtok(var_9, "_");

      foreach(var_13, var_12 in var_10) {
        if(var_13 == 0) {
          var_9 = var_12;
          continue;
        }

        if(var_12 == "wm") {
          var_9 = var_9 + "_vm";
          continue;
        }

        var_9 = var_9 + "_" + var_12;
      }
    }

    if(istrue(var_4)) {
      precachemodel(var_9);
      continue;
    }

    self attach(var_9);
    self._id_1D85 = scripts\engine\utility::array_add(self._id_1D85, var_9);
  }

  if(!istrue(var_4)) {
    switch (var_0) {
      case "s4_pi_mike1911":
        self hidepart("j_b_loader");
        self hidepart("j_b_loader_01");
        self hidepart("j_b_loader_02");
        self hidepart("j_b_loader_03");
        self hidepart("j_b_loader_04");
        self hidepart("j_b_loader_05");
        self hidepart("j_b_loader_06");
        break;
      case "iw8_sh_romeo870":
        self hidepart("j_shell");
        self hidepart("j_shell_fired");
        break;
    }

    foreach(var_9 in var_7) {
      if(issubstr(var_9, "reflex")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_9, "holo")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_9, "acog")) {
        self hidepart("tag_sight_on");
      }
    }
  }
}

_id_99D7(var_0, var_1, var_2) {
  var_3 = _id_66D3(var_1, var_2);
  var_4 = [[level._id_5D69]](var_0, var_3);
  return var_4;
}

_id_66D3(var_0, var_1) {
  if(isDefined(var_1) && var_1.size > 0) {
    if(var_0.size < 1) {
      return var_1[randomint(var_1.size)];
    }

    if(randomint(4)) {
      return var_1[randomint(var_1.size)];
    }
  }

  var_2 = [];

  if(var_0.size < 1) {
    return var_2;
  }

  foreach(var_5, var_4 in var_0) {
    if(isint(var_0[var_5][0])) {
      if(randomint(100) < var_0[var_5][0]) {
        var_2 = scripts\engine\utility::array_add(var_2, var_4[randomint(var_4.size - 1) + 1]);
      }

      continue;
    }

    return var_2;
  }

  var_6 = undefined;
  var_7 = undefined;

  foreach(var_5, var_9 in var_2) {
    if(issubstr(var_9, "grip")) {
      var_7 = var_5;
      continue;
    }

    if(issubstr(var_9, "ub_")) {
      var_6 = var_5;
    }
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    if(randomint(3) == 0) {
      var_2 = scripts\engine\utility::array_remove_index(var_2, var_6);
    } else {
      var_2 = scripts\engine\utility::array_remove_index(var_2, var_7);
    }
  }

  return var_2;
}

_id_685B(var_0, var_1) {
  var_2 = [];
  var_3 = getarraykeys(var_1);

  foreach(var_7, var_5 in var_0) {
    var_6 = scripts\engine\utility::_id_1BAB(var_3, var_5);

    if(isDefined(var_6)) {
      var_2[var_2.size] = var_1[var_3[var_6]];
      continue;
    }

    var_2[var_2.size] = 0;
  }

  var_8 = 0;

  foreach(var_10 in var_2) {
    var_8 = var_8 + var_10;
  }

  if(var_8 > 100) {}

  if(var_8 < 100) {
    var_12 = 100 - var_8;
    var_13 = 0;

    foreach(var_10 in var_2) {
      if(var_10 == 0) {
        var_13 = var_13 + 1;
      }
    }

    if(var_13 > 0) {
      var_16 = var_12 / var_13;

      foreach(var_7, var_10 in var_2) {
        if(var_10 == 0) {
          var_2[var_7] = var_16;
        }
      }
    }
  }

  var_18 = randomint(100);

  foreach(var_7, var_10 in var_2) {
    if(var_7 > 0) {
      var_2[var_7] = var_10 + var_2[var_7 - 1];
    }

    if(var_18 < var_2[var_7]) {
      return var_0[var_7];
    }
  }

  if(getdvarint("#x38d847dcafb0389fe")) {
    if(var_0.size > 1) {}
  }

  return var_0[0];
}

_id_97EE(var_0, var_1) {
  var_2 = 1;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  self._id_5509 = var_0;

  if(isDefined(var_0)) {
    self._id_9803 = 1;
    self setlookatentity(var_0, var_2);
  } else {
    self._id_9803 = 0;
    self setlookatentity();
  }
}

_id_97F1(var_0) {
  self._id_97F1 = var_0;

  if(isDefined(var_0)) {
    self setlookatstateoverride(var_0);
  } else {
    self setlookatstateoverride();
  }
}

_id_3776(var_0) {
  if(!isDefined(self._id_0323)) {
    return;
  }
  self._id_83D3 = self._id_5509;
  _id_97EE();
  _id_83D1(gettime(), var_0);
  _id_97EE(self._id_83D3);
  self._id_83D3 = undefined;
  self notify("glance_finished");
}

_id_83D1(var_0, var_1) {
  var_2 = 2500;
  var_3 = scripts\engine\utility::ter_op(isDefined(self._id_97F7), self._id_97F7, 75);

  while(var_0 + var_1 > gettime()) {
    var_4 = self _meth_84A6(var_3);
    var_4 = var_4 + (0, 0, 60);

    if(distancesquared(self.origin, var_4) < var_2) {
      break;
    }

    self setlookat(var_4);
    waitframe();
  }

  self stoplookat();
}

_id_700F() {
  self stoplookat();
}

_id_97F0(var_0, var_1) {
  self notify("newLookAt");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_0)) {
    self stoplookat();
  } else {
    self setlookat(var_0, var_1);
  }
}

_id_8B04(var_0) {
  var_1 = getweaponattachments(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "epic")) {
      return 1;
    }
  }

  return 0;
}

_id_87EC(var_0) {
  var_1 = self.damageweapon;

  if(!isDefined(var_1)) {
    return 0;
  }

  if(isnullweapon(var_1)) {
    return 0;
  }

  if(var_1.basename != getweaponbasename(var_0)) {
    return 0;
  }

  return 1;
}

_id_9D8A() {
  var_0 = ["mars_killstreak", "iw7_jackal_support_designator"];
  var_1 = self getcurrentweapon();

  if(scripts\engine\utility::array_contains(var_0, var_1.basename)) {
    return 1;
  }

  if(self isdroppingweapon()) {
    return 1;
  }

  if(self israisingweapon()) {
    if(scripts\engine\utility::array_contains(var_0, var_1.basename)) {
      return 1;
    }
  }

  return 0;
}

_id_10A0E() {
  if(!isDefined(self.damagemod) || self.damagemod != "MOD_MELEE") {
    return 0;
  }

  var_0 = self.damageweapon;

  if(!isDefined(var_0) || var_0.type != "shield") {
    return 0;
  }

  return 1;
}

_id_10A0D() {
  if(isDefined(self.damagemod)) {
    if(_func_010F(self.damagemod)) {
      return 1;
    }

    if(isDefined(self.damageweapon) && issubstr(self.damageweapon.basename, "molotov")) {
      return 1;
    }

    if(_id_10A0E()) {
      return 1;
    }

    if(self.damagemod == "MOD_MELEE" && isDefined(self.attacker) && isDefined(self.attacker._id_04B9) && self.attacker._id_04B9 == "c8") {
      return 1;
    }
  }

  if(gettime() - anim._id_8FA6 <= 50) {
    var_0 = anim._id_8FA5 * anim._id_8FA5 * 1.2 * 1.2;

    if(distancesquared(self.origin, anim._id_8FA3) < var_0) {
      var_1 = var_0 * 0.5 * 0.5;
      self._id_9CC6 = distancesquared(self.origin, anim._id_8FA4) < var_1;
      return 1;
    }
  }

  return 0;
}

_id_69C4(var_0) {
  if(!isDefined(var_0)) {
    return "unknown";
  }

  var_0 = tolower(var_0);

  switch (var_0) {
    case "melee":
    case "mod_crush":
    case "mod_melee":
      return "melee";
    case "bullet":
    case "mod_rifle_bullet":
    case "mod_pistol_bullet":
      return "bullet";
    case "splash":
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
      return "splash";
    case "mod_impact":
      return "impact";
    case "mod_execution":
      return "unknown";
    case "unknown":
      return "unknown";
    default:
      return "unknown";
  }
}

_id_89CF(var_0) {
  if(isDefined(var_0._id_75A5) && var_0._id_75A5) {
    var_1 = self.origin - var_0.origin;
    var_2 = vectornormalize((var_1[0], var_1[1], 0));
    var_3 = anglesToForward(var_0.angles);
    var_4 = vectordot(var_3, var_1);

    if(var_0._id_75A6) {
      if(var_4 > 0.766) {
        return 1;
      }
    } else if(var_4 < -0.766)
      return 1;
  }

  return 0;
}

_id_89CE(var_0) {
  var_1 = 0;
  var_2 = self getcurrentweapon();
  var_3 = self adsButtonPressed();
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = anglesToForward(self.angles);
  var_8 = vectornormalize(var_0.origin - self.origin);
  var_9 = vectordot(var_8, var_7);

  if(var_9 > 0.5) {
    var_4 = 1;
  }

  if(var_2.basename == "iw6_axe_mp" || var_2.basename == "iw7_axe_zm") {
    var_6 = self getcurrentweaponclipammo();
    var_5 = 1;
  }

  if(var_5 && var_3 && var_4 && var_6 > 0) {
    self setweaponammoclip(var_2, var_6 - 1);
    self playSound("crate_impact");
    earthquake(0.75, 0.5, self.origin, 100);
    var_1 = 1;
  }

  return var_1;
}

_id_873E(var_0) {
  switch (var_0) {
    case "airdrop_tank_marker_mp":
    case "airdrop_sentry_marker_mp":
    case "airdrop_mega_marker_mp":
    case "airdrop_marker_support_mp":
    case "airdrop_marker_assault_mp":
    case "airdrop_marker_mp":
      return 1;
    default:
      return 0;
  }
}

_id_87FC(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "barrel_mp":
    case "destructible_toy":
    case "destructible_car":
    case "destructible":
      return 1;
  }

  return 0;
}

isentitylessdestructibleclass(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "scriptable_s4_") && issubstr(var_0, "_destp")) {
    return 1;
  }

  return 0;
}

_id_522D() {
  thread _id_522E();
}

_id_522E() {
  self endon("death");

  for(;;) {
    self._id_EF73 = 1;
    wait 0.05;
  }
}

_id_4A5B() {
  self._id_EF73 = undefined;
}

_id_D562(var_0) {
  self._id_5C99 = var_0;
}

_id_6946(var_0) {
  switch (var_0) {
    case "index":
      return 0;
    case "camoasset":
      return 1;
    case "bot_valid":
      return 2;
    case "category":
      return 3;
    default:
      return undefined;
  }
}

_id_69DE() {
  if(level._id_60E6 < 1) {
    return "easy";
  }

  if(level._id_60E6 < 2) {
    return "medium";
  }

  if(level._id_60E6 < 3) {
    return "hard";
  }

  return "fu";
}

_id_38ED() {
  self _meth_86EA();
}

_id_5C9F() {
  self._id_5CA2 = undefined;
}

_id_51E8(var_0) {
  if(self.type == "dog") {
    return;
  }
  if(!isDefined(var_0)) {
    self._id_3E36 = 1;
  }

  self._id_04A8 = 0.2;
  _id_47A7("cqb");
}

_id_49EF() {
  if(self.type == "dog") {
    return;
  }
  self._id_3E36 = undefined;
  self._id_04A8 = 0.3;

  if(isDefined(self._id_3E32)) {
    self._id_3E32 = undefined;
    self _meth_8866(0);
  }

  _id_38C7();
}

_id_47A7(var_0) {
  if(isDefined(self._id_0088) && (self._id_0088 == "soldier" || self._id_0088 == "rebel")) {
    switch (var_0) {
      case "casual_walk":
      case "alert":
      case "patrol":
      case "casual_killer":
      case "casual_gun":
        self._id_0047 = 0;
        break;
      default:
        self._id_0047 = 1;
    }
  }

  if(isDefined(self._id_1CB8) && (self._id_1CB8 == "soldier" || self._id_1CB8 == "soldier_cp")) {
    switch (var_0) {
      case "casual_walk":
      case "patrol":
      case "casual_killer":
      case "casual_gun":
      case "casual":
        self._id_04A8 = 0.1;
        break;
      case "alert":
      case "cqb":
        self._id_04A8 = 0.2;
        break;
      default:
        self._id_04A8 = 0.3;
        break;
    }

    switch (var_0) {
      case "cqb":
        scripts\engine\utility::set_movement_speed(120 * self.speedscalemult);
        var_0 = "combat";
        break;
      case "combat":
        _id_38ED();
        break;
      case "sprint":
        scripts\engine\utility::set_movement_speed(225 * self.speedscalemult);
        var_0 = "combat";
        break;
      case "alert":
      case "patrol":
        scripts\engine\utility::set_movement_speed(56);
        break;
    }
  }

  self._id_015B = var_0;
}

_id_38C7() {
  if(isDefined(self._id_0088) && (self._id_0088 == "soldier" || self._id_0088 == "rebel")) {
    if(isDefined(self._id_015B)) {
      switch (self._id_015B) {
        case "casual_walk":
        case "alert":
        case "patrol":
        case "casual_killer":
        case "casual_gun":
          self._id_0047 = 1;
          break;
      }
    }
  }

  self._id_015B = undefined;

  if(isDefined(self._id_1CB8) && self._id_1CB8 == "soldier") {
    self._id_04A8 = 0.3;
    _id_38ED();
  }
}

_id_8B07(var_0) {
  var_1 = getcompleteweaponname(var_0);
  return isDefined(self.weaponinfo[var_1]);
}

_id_82BA(var_0) {
  var_1 = getcompleteweaponname(var_0);
  self.weaponinfo[var_1] = spawnStruct();
  self.weaponinfo[var_1]._id_033E = "none";
  self.weaponinfo[var_1]._id_754D = 1;
  scripts\anim\weaponlist::_id_D8C8(var_0.classname);

  if(issp()) {
    var_2 = _func_00EE(var_0);

    if(isDefined(var_2) && var_2 != "" && (issubstr(var_2, "drum") || issubstr(var_2, "mag"))) {
      self.weaponinfo[var_1]._id_FE32 = 1;
      return;
    }

    self.weaponinfo[var_1]._id_FE32 = 0;
    return;
  } else
    self.weaponinfo[var_1]._id_FE32 = 0;
}

_id_1549() {
  _id_151E("usability", ::_id_158A, ::_id_86F9);
  _id_151E("weapon", ::_id_158D, ::_id_871C);
  _id_151E("weapon_switch", ::_id_1593, ::_id_8724);
  _id_151E("weapon_switch_clip", ::_id_1594, ::_id_8725);
  _id_151E("script_weapon_switch", ::_id_157A, ::_id_86AC);
  _id_151E("weapon_pickup", ::_id_1591, ::_id_8721);
  _id_151E("offhand_weapons", ::_id_1562, ::_id_8650);
  _id_151E("offhand_primary_weapons", ::_id_155E, ::_id_864D);
  _id_151E("offhand_secondary_weapons", ::_id_155F, ::_id_864E);
  _id_151E("offhand_shield_weapons", ::_id_1560, ::_id_864F);
  _id_151E("offhand_throwback", ::_id_1561, ::is_offhand_throwback_allowed);
  _id_151E("prone", ::_id_1570, ::_id_868B);
  _id_151E("crouch", ::_id_1530, ::_id_858E);
  _id_151E("stand", ::_id_1582, ::_id_86D0);
  _id_151E("sprint", ::_id_1581, ::_id_86CF);
  _id_151E("mantle", ::_id_1553, ::_id_862E);
  _id_151E("fire", ::_id_153E, ::_id_85CE);
  _id_151E("ads", ::_id_151F, ::_id_8544);
  _id_151E("jump", ::_id_154E, ::_id_8616);
  _id_151E("wallrun", ::_id_158C, ::_id_8719);
  _id_151E("doublejump", ::_id_1534, ::_id_85AD);
  _id_151E("melee", ::_id_1554, ::_id_8631);
  _id_151E("melee_victim", ::_id_1555, ::is_melee_victim_allowed);
  _id_151E("slide", ::_id_157F, ::_id_86BB);
  _id_151E("reload", ::_id_1575, ::_id_869C);
  _id_151E("lean", ::_id_1551, ::_id_8620);
  _id_151E("mount_top", ::_id_1558, ::_id_8638);
  _id_151E("mount_side", ::_id_1557, ::_id_8637);
  _id_151E("autoreload", ::_id_1525, ::_id_8562);
  _id_151E("movement", ::_id_1559, ::is_movement_allowed);
  _id_151E("execution_attack", ::_id_153C, ::_id_30C5);
  _id_151E("execution_victim", ::_id_153D, ::_id_30B8);
  _id_151E("vehicle_use", ::_id_158B, ::_id_8710);
  _id_151E("crate_use", ::_id_152F, ::_id_858A);
  _id_151E("cough_gesture", ::_id_152D, ::_id_8586);
  _id_151E("ladder_placement", ::_id_1550, ::_id_861C);
  _id_151E("killstreaks", ::_id_154F, ::_id_861B);
  _id_151E("cp_munitions", ::_id_152E, ::is_cp_munitions_allowed);
  _id_151E("nvg", ::_id_155D, ::_id_8646);
}

_id_151E(var_0, var_1, var_2) {
  level._id_1542[tolower(var_0)] = var_1;
  level.allow_funcs_getters[tolower(var_0)] = var_2;
}

_id_1574(var_0, var_1) {
  level._id_157D[tolower(var_0)] = var_1;
}

_id_157C(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  _id_1523(level._id_157D[var_0], var_1, var_2);
}

_id_1523(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 = tolower(var_4);
    self thread[[level._id_1542[var_4]]](var_1, var_2);
  }
}

allow_is_allowed(var_0) {
  return _allow_get_internal(var_0);
}

allow_array_get(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_3] = allow_is_allowed(var_3);
  }

  return var_1;
}

allow_array_is_allowed(var_0) {
  foreach(var_2 in var_0) {
    var_3 = allow_is_allowed(var_2);

    if(!var_3) {
      return 0;
    }
  }

  return 1;
}

_allow_get_internal(var_0) {
  var_0 = tolower(var_0);
  var_1 = level.allow_funcs_getters[var_0];

  if(isDefined(var_1)) {
    return [[var_1]]();
  }

  return scripts\common\input_allow::_id_860C(var_0);
}

_id_1594(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("weaponSwitchClip", var_0, var_1);
  self _meth_859A(!istrue(var_2));
}

_id_8725() {
  return scripts\common\input_allow::_id_860C("weaponSwitchClip");
}

_id_158A(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("usability", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableusability();
    } else {
      self disableusability();
    }
  }
}

_id_86F9() {
  return scripts\common\input_allow::_id_860C("usability");
}

_id_158D(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("weapon", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    self enableweapons();

    if(isDefined(level._id_158F)) {
      self[[level._id_158F]](1);
    }
  } else if(isDefined(var_2) && !var_2) {
    if(isDefined(level._id_158F)) {
      self[[level._id_158F]](0);
    }

    self disableweapons();
  }
}

_id_871C() {
  return scripts\common\input_allow::_id_860C("weapon");
}

_id_1593(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("weaponSwitch", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    self enableweaponswitch();
  } else if(isDefined(var_2) && !var_2) {
    self disableweaponswitch();
  }
}

_id_8724() {
  return scripts\common\input_allow::_id_860C("weaponSwitch");
}

_id_157A(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("scriptWeaponSwitch", var_0, var_1);
}

_id_86AC() {
  return scripts\common\input_allow::_id_860C("scriptWeaponSwitch");
}

_id_1591(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("weaponPickup", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    self enableweaponpickup();
  } else if(isDefined(var_2) && !var_2) {
    self disableweaponpickup();
  }
}

_id_8721() {
  return scripts\common\input_allow::_id_860C("weaponPickup");
}

_id_1562(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhandWeaps", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandweapons();

      if(!isDefined(level.ismp) || level.ismp == 0) {
        _id_1560(1, "allow_offhand_weapons");
      }
    } else {
      self disableoffhandweapons();

      if(!isDefined(level.ismp) || level.ismp == 0) {
        _id_1560(0, "allow_offhand_weapons");
      }
    }
  }
}

_id_8650() {
  return scripts\common\input_allow::_id_860C("offhandWeaps");
}

_id_155E(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhandPrimaryWeaps", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandprimaryweapons();
    } else {
      self disableoffhandprimaryweapons();
    }
  }
}

_id_864D() {
  return scripts\common\input_allow::_id_860C("offhandPrimaryWeaps");
}

_id_155F(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhandSecondaryWeaps", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandsecondaryweapons();
      _id_1560(1, "allow_offhand_secondary_weapons");
    } else {
      self disableoffhandsecondaryweapons();
      _id_1560(0, "allow_offhand_secondary_weapons");
    }
  }
}

_id_864E() {
  return scripts\common\input_allow::_id_860C("offhandSecondaryWeaps");
}

_id_1560(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhandShieldWeaps", var_0, var_1);

  if(isDefined(var_2)) {
    self _meth_8509(var_2);
  }
}

_id_864F() {
  return scripts\common\input_allow::_id_860C("offhandShieldWeaps");
}

_id_1570(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("prone", var_0, var_1);

  if(isDefined(var_2)) {
    self allowprone(var_2);
  }
}

_id_868B() {
  return scripts\common\input_allow::_id_860C("prone");
}

_id_1530(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("crouch", var_0, var_1);

  if(isDefined(var_2)) {
    self allowcrouch(var_2);
  }
}

_id_858E() {
  return scripts\common\input_allow::_id_860C("crouch");
}

_id_1582(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("stand", var_0, var_1);

  if(isDefined(var_2)) {
    self allowstand(var_2);
  }
}

_id_86D0() {
  return scripts\common\input_allow::_id_860C("stand");
}

_id_1581(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("sprint", var_0, var_1);

  if(isDefined(var_2)) {
    self allowsprint(var_2);
  }
}

_id_154D(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("jog", var_0, var_1);

  if(isDefined(var_2)) {
    setsaveddvar("#x3f99a88d1df106b19", var_2);
  }
}

_id_86CF() {
  return scripts\common\input_allow::_id_860C("sprint");
}

_id_1553(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("mantle", var_0, var_1);

  if(isDefined(var_2)) {
    self allowmantle(var_2);
  }
}

_id_862E() {
  return scripts\common\input_allow::_id_860C("mantle");
}

_id_153E(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("fire", var_0, var_1);

  if(isDefined(var_2)) {
    self allowfire(var_2);
  }
}

_id_85CE() {
  return scripts\common\input_allow::_id_860C("fire");
}

_id_151F(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("ads", var_0, var_1);

  if(isDefined(var_2)) {
    self allowads(var_2);
  }
}

_id_8544() {
  return scripts\common\input_allow::_id_860C("ads");
}

_id_154E(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("jump", var_0, var_1);

  if(isDefined(var_2)) {
    self allowjump(var_2);
  }
}

_id_8616() {
  return scripts\common\input_allow::_id_860C("jump");
}

_id_158C(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("wallrun", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    self allowwallrun(1);
  } else if(isDefined(var_2) && !var_2) {
    self allowwallrun(0);
  }
}

_id_8719() {
  return scripts\common\input_allow::_id_860C("wallrun");
}

_id_1534(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("doubleJump", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self _meth_847E(0, self._id_4EA1);
      self _meth_8486(0, self._id_4EA2);
      self._id_4EA1 = undefined;
      self._id_4EA2 = undefined;
      self allowdoublejump(1);
    } else {
      self._id_4EA1 = self _meth_847D(0);
      self._id_4EA2 = self _meth_8485(0);
      self _meth_847E(0, 0);
      self _meth_8486(0, 0);
      self allowdoublejump(0);
    }
  }
}

_id_85AD() {
  return scripts\common\input_allow::_id_860C("doubleJump");
}

_id_1561(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhand_throwback", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandthrowback();
    } else {
      self disableoffhandthrowback();
    }
  }
}

is_offhand_throwback_allowed() {
  return scripts\common\input_allow::_id_860C("offhand_throwback");
}

_id_1554(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("melee", var_0, var_1);

  if(isDefined(var_2)) {
    if(isPlayer(self)) {
      self allowmelee(var_2);
    } else if(isDefined(var_2) && var_2 == 0) {
      self._id_4DA7 = 1;
    } else {
      self._id_4DA7 = undefined;
    }
  }
}

_id_8631() {
  return scripts\common\input_allow::_id_860C("melee");
}

_id_1555(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("melee_victim", var_0, var_1);

  if(isDefined(var_2) && var_2 == 0) {
    self._id_4DA7 = 1;
  } else {
    self._id_4DA7 = undefined;
  }
}

is_melee_victim_allowed() {
  return scripts\common\input_allow::_id_860C("melee_victim");
}

_id_157F(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("slide", var_0, var_1);

  if(isDefined(var_2)) {
    self allowslide(var_2);
  }
}

_id_86BB() {
  return scripts\common\input_allow::_id_860C("slide");
}

_id_153C(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("execution_attack", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self[[level._id_524E]]();
    } else {
      self[[level._id_4AB1]]();
    }
  }
}

_id_153D(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("execution_victim", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self[[level._id_5250]]();
    } else {
      self[[level._id_4AB3]]();
    }
  }
}

_id_30C5() {
  return scripts\common\input_allow::_id_860C("execution_attack");
}

_id_30B8() {
  return scripts\common\input_allow::_id_860C("execution_victim");
}

_id_154F(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("killstreaks", var_0, var_1);
}

_id_152E(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("cp_munitions", var_0, var_1);
}

is_cp_munitions_allowed() {
  return scripts\common\input_allow::_id_860C("cp_munitions");
}

_id_861B() {
  return scripts\common\input_allow::_id_860C("killstreaks");
}

_id_1587(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("supers", var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = !var_0;

    if(isDefined(level._id_D6FE)) {
      self[[level._id_D6FE]](var_3);
    }
  }
}

_id_86DB() {
  return scripts\common\input_allow::_id_860C("supers");
}

_id_157E(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("shellshock", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      if(isDefined(level._id_526B)) {
        self[[level._id_526B]]();
      }
    } else if(isDefined(level._id_4AE4))
      self[[level._id_4AE4]]();
  }
}

_id_86B6() {
  return scripts\common\input_allow::_id_860C("shellshock");
}

_id_6461() {
  if(!isDefined(self._id_4EA1)) {
    return self _meth_847D(0);
  }

  return self._id_4EA1;
}

_id_D1E7(var_0) {
  if(!isDefined(self._id_4EA1)) {
    self _meth_847E(0, var_0);
  } else {
    self._id_4EA1 = var_0;
  }
}

_id_6462() {
  if(!isDefined(self._id_4EA2)) {
    return self _meth_8485(0);
  }

  return self._id_4EA2;
}

_id_D1E8(var_0) {
  if(!isDefined(self._id_4EA2)) {
    self _meth_8486(0, var_0);
  } else {
    self._id_4EA2 = var_0;
  }
}

_id_1551(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("lean", var_0, var_1);

  if(isDefined(var_2)) {
    self allowlean(var_2);
  }
}

_id_8620() {
  return scripts\common\input_allow::_id_860C("lean");
}

_id_1558(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("mount_top", var_0, var_1);

  if(isDefined(var_2)) {
    self allowmounttop(var_2);
  }
}

_id_8638() {
  return scripts\common\input_allow::_id_860C("mount_top");
}

_id_1557(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("mount_side", var_0, var_1);

  if(isDefined(var_2)) {
    self allowmountside(var_2);
  }
}

_id_8637() {
  return scripts\common\input_allow::_id_860C("mount_side");
}

_id_152C(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("cinematic_motion", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      if(isDefined(level.player._id_371C)) {
        level.player _meth_8638(level.player._id_371C);
      } else {
        level.player _meth_8639();
      }
    } else
      self _meth_8638("disabled");
  }
}

_id_8570() {
  return scripts\common\input_allow::_id_860C("cinematic_motion");
}

set_console_cinematic_dynamic_res_threshold(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if((level.player _meth_8687() || level.player _meth_868A()) && level.player _meth_8865()) {
    if(var_0 && getdvarint("#x334e19a44cd0d6e61", 0)) {
      setsaveddvar("#x3712593d2c9493893", 30);
    }

    setsaveddvar("#x37ed35c199eba584b", 33.34);
  }
}

set_console_default_dynamic_res_threshold(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if((level.player _meth_8687() || level.player _meth_868A()) && level.player _meth_8865()) {
    if(var_0 && getdvarint("#x334e19a44cd0d6e61", 0)) {
      setsaveddvar("#x3712593d2c9493893", 60);
    }

    setsaveddvar("#x37ed35c199eba584b", 16.67);
  }
}

_id_1531(var_0, var_1) {
  if(!isDefined(self._id_440A)) {}

  var_2 = scripts\common\input_allow::allow_input_internal("death", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self[[self._id_440A]](0);
    } else {
      self[[self._id_440A]](1);
    }
  } else
    self[[self._id_440A]](1);
}

_id_859A() {
  return scripts\common\input_allow::_id_860C("death");
}

_id_1575(var_0, var_1, var_2) {
  var_3 = scripts\common\input_allow::allow_input_internal("reload", var_0, var_1);

  if(isDefined(var_3)) {
    if(var_3) {
      self allowreload(1);
    } else {
      self allowreload(0);

      if(!isDefined(var_2) || !var_2) {
        self cancelreload();
      }
    }
  }
}

_id_869C() {
  return scripts\common\input_allow::_id_860C("reload");
}

_id_1525(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("autoreload", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableautoreload();
    } else {
      self disableautoreload();
    }
  }
}

_id_8562() {
  return scripts\common\input_allow::_id_860C("autoreload");
}

_id_1559(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("movement", var_0, var_1);

  if(isDefined(var_2)) {
    self allowmovement(var_2);
  }
}

is_movement_allowed() {
  return scripts\common\input_allow::_id_860C("movement");
}

_id_1522(var_0, var_1) {
  if(!_id_B65F()) {
    return;
  }
  var_2 = scripts\common\input_allow::allow_input_internal("armor", var_0, var_1);

  if(isDefined(self._id_1B26) && isDefined(self._id_1B26._id_F2E5)) {
    self[[self._id_1B26._id_F2E5]]();
  }
}

_id_855D() {
  if(!_id_B65F()) {
    return 0;
  }

  return scripts\common\input_allow::_id_860C("armor");
}

_id_155D(var_0, var_1, var_2) {
  var_3 = 2;
  var_4 = scripts\common\input_allow::allow_input_internal("NVG", var_0, var_1, var_2);

  if(isDefined(var_4)) {
    if(var_4) {
      if(!isai(self)) {
        self setactionslot(var_3, "nightvision");
      }
    } else if(!isai(self))
      self setactionslot(var_3, "");
  }
}

_id_8646() {
  return scripts\common\input_allow::_id_860C("NVG");
}

_id_152F(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("crateUse", var_0, var_1);
}

_id_858A() {
  return scripts\common\input_allow::_id_860C("crateUse");
}

_id_158B(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("vehicle_use", var_0, var_1);

  if(isDefined(var_2)) {
    _func_0264(self, var_0);
  }
}

_id_8710() {
  return scripts\common\input_allow::_id_860C("vehicle_use");
}

_id_152D(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("cough_gesture", var_0, var_1);
}

_id_8586() {
  return scripts\common\input_allow::_id_860C("cough_gesture");
}

_id_1550(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("ladder_placement", var_0, var_1);
}

_id_861C() {
  return scripts\common\input_allow::_id_860C("ladder_placement");
}

_id_B65F() {
  return getdvarint("#x3893da84b7e2b47ea");
}

_id_B6D6() {
  return getdvarint("#x35cba99efad615a66");
}

_id_E235() {
  return scripts\common\vehicle::vehicle_spawn(self);
}

groundpos(var_0, var_1) {
  return scripts\engine\utility::_id_5000(var_0, 0, -100000, var_1);
}

_id_10093() {
  _id_06E9::_id_1022B();
}

_id_10248() {
  thread _id_06EB::_id_10249();
}

_id_1012D(var_0) {
  _id_06E9::_id_1012F(var_0);
}

_id_10131(var_0) {
  _id_06E9::_id_10132(var_0);
}

_id_100A2(var_0, var_1) {
  scripts\common\vehicle::_id_1022C(var_0, var_1);
}

_id_6E40(var_0, var_1) {
  var_2 = _id_6E41(var_0, var_1);
  return var_2[0];
}

_id_6E41(var_0, var_1) {
  return _id_06E9::_id_0C10(var_0, var_1);
}

_id_862F() {
  var_0 = getDvar("#x376847958d67972ef");

  if(var_0 == "mp_donesk" || var_0 == "mp_locale_test") {
    return 1;
  }

  return 0;
}

_id_8B11() {
  return getdvarint("#x32e26f48b11f563be", 0) == 1;
}

_id_B7C7(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_characterproxy"]);
  var_3 = (var_1, var_1, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;
  var_6 = _func_02BF(var_4, var_5, var_2, []);
  var_6 = scripts\engine\utility::_id_1BD0(var_6);
  return var_6;
}

_id_B7B6(var_0, var_1, var_2, var_3) {
  var_4 = physics_createcontents(["physicscontents_characterproxy"]);
  var_5 = 1000;

  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = (var_1, var_1, var_5);
  var_7 = var_0 - var_6;
  var_8 = var_0 + var_6;

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  var_9 = _func_02BF(var_7, var_8, var_4, var_2);
  var_9 = scripts\engine\utility::_id_1BD0(var_9);
  var_10 = [];
  var_11 = var_1 * var_1;

  foreach(var_13 in var_9) {
    var_15 = distance2dsquared(var_13.origin, var_0);

    if(var_15 < var_11) {
      var_10[var_10.size] = var_13;
    }
  }

  return var_10;
}

_id_B7BF(var_0, var_1) {
  var_2 = _id_B7C7(var_0, var_1);
  var_3 = [];
  var_4 = var_1 * var_1;

  foreach(var_6 in var_2) {
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < var_4) {
      var_3[var_3.size] = var_6;
    }
  }

  return var_3;
}

_id_F73A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_10)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else if(isDefined(var_9)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_8)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_7)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    return [[var_0]](var_1, var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    return [[var_0]](var_1, var_2, var_3);
  } else if(isDefined(var_2)) {
    return [[var_0]](var_1, var_2);
  } else if(isDefined(var_1)) {
    return [[var_0]](var_1);
  } else {
    return [[var_0]]();
  }
}

_id_E28D() {
  if(!_id_8B11()) {
    return;
  }
  var_0 = 0;
  var_1 = 1;
  var_2 = 2;
  var_3 = 3;
  var_4 = 4;
  var_5 = 5;
  var_6 = "sp/hideCorpseTable.csv";
  var_7 = tolower(getDvar("#x376847958d67972ef"));
  var_8 = tablelookupgetnumrows(var_6);

  for(var_9 = 0; var_9 < var_8; var_9++) {
    if(var_7 == tolower(tablelookupbyrow(var_6, var_9, var_1))) {
      var_10 = tablelookupbyrow(var_6, var_9, var_2);
      var_11 = strtok(tablelookupbyrow(var_6, var_9, var_3), "_");
      var_12 = strtok(tablelookupbyrow(var_6, var_9, var_4), "_");
      var_13 = int(tablelookupbyrow(var_6, var_9, var_5));
      var_14 = spawn("script_model", (float(var_11[0]), float(var_11[1]), float(var_11[2])));
      var_14 setModel(var_10);
      var_14.angles = (float(var_12[0]), float(var_12[1]), float(var_12[2]));

      if(var_13 > 0) {
        var_14 solid();
      } else {
        var_14 notsolid();
      }
    }
  }
}

_id_871D(var_0) {
  var_1 = tablelookupgetnumrows("sp/weapon_tuning.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = tablelookupbyrow("sp/weapon_tuning.csv", var_2, 1);

    if(isDefined(var_3) && var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_6857(var_0, var_1) {
  var_2 = tablelookupgetnumrows("sp/weapon_tuning.csv");

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = tablelookupbyrow("sp/weapon_tuning.csv", var_3, 1);

    if(isDefined(var_4) && var_4 == var_0) {
      return float(tablelookupbyrow("sp/weapon_tuning.csv", var_3, var_1));
    }
  }

  return -1;
}

_id_12AB() {
  level notify("ai_lod_control_watcher");
  level endon("ai_lod_control_watcher");
  setdvarifuninitialized("#x37a2df966e2f76448", 0);
  setdvarifuninitialized("#x36c62f2dcb002b188", "high");
  setdvarifuninitialized("#x32d1f8883d184201", 0);
  setdvarifuninitialized("#x3e443461c88a89df0", 0);
  setdvarifuninitialized("#x3529041bf43ef47ec", 1.0);
  setdvarifuninitialized("#x37ce40b0c19ed9f5e", 0);
  waitframe();
  var_0 = 0.5;
  var_1 = int(var_0 * 20);

  for(;;) {
    wait(var_0);
    var_2 = _id_6760("axis");
    var_3 = _id_6760("allies");

    if(!getdvarint("#x37a2df966e2f76448", 1)) {
      var_4 = getDvar("#x36c62f2dcb002b188", "high");

      foreach(var_6 in var_2) {
        if(var_4 == "low") {
          var_6 _id_D282(var_1);
          continue;
        }

        var_6 _id_D248(var_1);
      }

      foreach(var_6 in var_3) {
        if(var_4 == "low") {
          var_6 _id_D282(var_1);
          continue;
        }

        var_6 _id_D248(var_1);
      }

      continue;
    }

    var_10 = getdvarint("#x32d1f8883d184201", 0);
    var_11 = getdvarint("#x3e443461c88a89df0", 0);
    var_2 = _func_0204(var_2, level.player.origin, undefined, 1);
    var_3 = _func_0204(var_3, level.player.origin, undefined, 1);
    var_12 = 0;

    foreach(var_6 in var_2) {
      if(!var_6 _meth_81C7() && isalive(var_6) && var_12 < var_11) {
        var_12++;
        var_6 _id_D248(var_1);
        continue;
      }

      var_6 _id_D282(var_1);
    }

    var_15 = max(var_10 - var_11, var_10 - var_12);
    var_16 = 0;

    foreach(var_6 in var_3) {
      if(!var_6 _meth_81C7() && isalive(var_6) && var_16 < var_15) {
        var_16++;
        var_6 _id_D248(var_1);
        continue;
      }

      var_6 _id_D282(var_1);
    }
  }
}

_id_D248(var_0) {
  self._id_12AC._id_3A9C = 0.0;
  self._id_12AC._id_85F1 = 1;
  self._id_12AC.axis_damage_shield_watcher_frame_time = 0.1;
}

_id_D282(var_0) {
  self._id_12AC._id_3A9C = 0.0;
  self._id_12AC._id_85F1 = 0;
  self._id_12AC.axis_damage_shield_watcher_frame_time = 0.25;
}

_id_6760(var_0) {
  var_1 = _func_0070(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(var_4._id_04B9 == "soldier") {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_E5A1(var_0, var_1) {
  self._id_002F = 1;

  if(isDefined(var_0)) {
    self._id_1228 = var_0;
    self._id_1227 = istrue(var_1);
  }
}

_id_38A7() {
  self._id_002F = 0;
  self._id_1228 = undefined;
  self._id_1227 = undefined;
}

_id_8549() {
  return istrue(self._id_002F);
}

_id_74CF() {
  return istrue(self._id_002F) && isDefined(self._id_1228);
}

_id_6306() {
  return self._id_1228;
}

_id_854A() {
  return istrue(self._id_002F) && istrue(self._id_1227);
}

_id_854B(var_0) {
  if(isDefined(self._id_13E8) && isDefined(var_0) && self._id_13E8 == var_0) {
    return 1;
  }

  return 0;
}

_id_51EC(var_0) {
  var_0 = var_0 * 1000;
  self._id_0176 = 1;
  self._id_0151 = var_0;
  self._id_A441 = undefined;
}

_id_49F2() {
  self._id_0176 = 0;
  self._id_A441 = 1;
}

_id_D1FB() {
  self._id_01C2 = 1;
}

_id_D1FA() {
  self._id_01C2 = 0;
}

_id_D236(var_0) {
  self._id_0201 = var_0;
}

_id_4A5A() {
  self._id_02E3 = 0;
}

_id_522B() {
  self._id_02E3 = _func_0219(512);
}

_id_49E2() {
  self._id_4A83 = 1;
}

_id_51E0() {
  self._id_4A83 = undefined;
}

_id_D36E() {
  self._id_4E6C = 1;
}

_id_C5E0() {
  self._id_4E6C = 0;
}

_id_5219() {
  _id_D36E();
  _id_49E2();
  scripts\engine\utility::_id_4A32();
  _id_4A5A();
  self._id_AA0E = self._id_0151;
  _id_49F2();
  self._id_4AA4 = 1;
  self._id_4ABB = 1;
  self._id_AA12 = self._id_01C2;
  _id_D1FB();
  self._id_AA14 = self._id_0201;
  _id_D236(16);
  self._id_AA15 = self._id_025E;
  self._id_025E = 1;
  self._id_7D1D = 1;
  self._id_016A = 1;
}

_id_4A3D() {
  _id_C5E0();
  _id_51E0();
  scripts\engine\utility::_id_5212();
  _id_522B();

  if(isDefined(self._id_AA0E)) {
    _id_51EC(self._id_AA0E);
  }

  self._id_4AA4 = undefined;
  self._id_4ABB = 0;

  if(!self._id_AA12) {
    _id_D1FA();
  }

  if(isDefined(self._id_AA14)) {
    _id_D236(self._id_AA14);
  }

  if(isDefined(self._id_AA15)) {
    self._id_025E = self._id_AA15;
  }

  self._id_7D1D = undefined;
  self._id_016A = 0;
}

_id_DD4E(var_0, var_1, var_2, var_3, var_4) {
  thread _id_DD4F(var_0, var_1, var_2, var_3, var_4);
}

_id_DD4F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = gettime();
  var_7 = 0;
  var_8 = 0;

  if(isDefined(level._id_DE54) && _func_0107(level._id_DE54)) {
    while(isDefined(level._id_DE54[var_8])) {
      var_8++;
    }
  }

  var_9 = 0;

  if(!isDefined(var_3)) {
    var_3 = 2147483647;
  }

  while(var_7 < var_2 && var_9 < var_3) {
    if(isDefined(var_4)) {
      var_5 = _func_0071(var_0, var_1, var_4);
    } else {
      var_5 = _func_0071(var_0, var_1);
    }

    foreach(var_11 in var_5) {
      if(!istrue(var_11._id_CF79)) {
        var_11._id_DD50 = spawnStruct();
        var_11._id_DD50._id_9350 = var_8;
        var_11._id_DD50.origin = var_0;
        var_9++;
      }
    }

    var_7 = gettime() - var_6;
    waitframe();
  }
}

_id_EA56(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    if(isDefined(var_2)) {
      return _id_EA56(var_2);
    }

    return "undefined";
  }

  if(_func_0121(var_0) || isint(var_0)) {
    return var_0;
  }

  if(_func_0110(var_0)) {
    if(!isDefined(var_1)) {
      return int(var_0);
    }

    return _func_0438(var_0, var_1);
  }

  if(isvector(var_0)) {
    if(!isDefined(var_1)) {
      return (int(var_0[0]), int(var_0[1]), int(var_0[2]));
    }

    return (_func_0438(var_0[0], var_1), _func_0438(var_0[1], var_1), _func_0438(var_0[2], var_1));
  }

  if(_func_0107(var_0)) {
    var_3 = "[";
    var_4 = "";

    foreach(var_6 in var_0) {
      var_3 = var_3 + var_4;
      var_3 = var_3 + _id_EA56(var_6, var_1, var_2);
      var_4 = ", ";
    }

    var_3 = var_3 + "]";
    return var_3;
  }

  if(isent(var_0)) {
    return "e$" + var_0 getentitynumber();
  }

  if(_func_02DE(var_0)) {
    return "some_struct";
  }

  return "some_object";
}

_id_C94D(var_0) {
  if(var_0 - int(var_0) >= 0.5) {
    return int(var_0 + 1);
  } else {
    return int(var_0);
  }
}