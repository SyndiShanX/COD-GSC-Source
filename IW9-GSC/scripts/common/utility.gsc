/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\utility.gsc
***********************************************/

issp() {
  if(!isDefined(level.issp)) {
    mapname = getDvar("g_mapname");
    _id_848AB95939DCA3CC = "";

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < min(mapname.size, 3); _id_AC0E594AC96AA3A8++)
      _id_848AB95939DCA3CC = _id_848AB95939DCA3CC + mapname[_id_AC0E594AC96AA3A8];

    level.issp = _id_848AB95939DCA3CC != "mp_" && _id_848AB95939DCA3CC != "cp_" && _id_848AB95939DCA3CC != "zm_";
  }

  return level.issp;
}

iscp() {
  return scripts\engine\utility::string_starts_with(getDvar("g_mapname"), "cp_");
}

ismp() {
  return scripts\engine\utility::string_starts_with(getDvar("mapname"), "mp_") || isDefined(level.mapname) && scripts\engine\utility::string_starts_with(level.mapname, "mp_");
}

make_weapon_model(basename, attachments, viewmodel, precache) {
  if(!isDefined(attachments))
    attachments = [];

  if(!isDefined(viewmodel))
    viewmodel = 0;

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](basename)))
    weapon = [[level.fnbuildweaponspecial]](basename);
  else
    weapon = [[level.fnbuildweapon]](basename, attachments);

  if(isent(self) && !isDefined(precache))
    self setModel(getweaponmodel(weapon));

  _id_EB1CF0643B4A4706 = getweaponattachmentworldmodels(weapon);

  foreach(model in _id_EB1CF0643B4A4706) {
    if(istrue(viewmodel)) {
      array = strtok(model, "_");

      foreach(_id_AC0E594AC96AA3A8, _id_E97377032A878881 in array) {
        if(_id_AC0E594AC96AA3A8 == 0) {
          model = _id_E97377032A878881;
          continue;
        }

        if(_id_E97377032A878881 == "wm") {
          model = model + "_vm";
          continue;
        }

        model = model + "_" + _id_E97377032A878881;
      }
    }

    if(istrue(precache)) {
      precachemodel(model);
      continue;
    }

    self attach(model);
  }

  if(!istrue(precache)) {
    switch (basename) {
      case "iw8_pi_cpapa":
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

    foreach(model in _id_EB1CF0643B4A4706) {
      part = "tag_sight_on";

      if(issubstr(model, "reflex") && _id_1C61924EDF3431FD(model, part)) {
        self hidepart(part);
        continue;
      }

      if(issubstr(model, "holo")) {
        self hidepart(part);
        continue;
      }

      if(issubstr(model, "acog")) {
        self hidepart(part);
        continue;
      }

      if(issubstr(model, "scope"))
        self hidepart(part);
    }
  }
}

_id_1C61924EDF3431FD(model, part) {
  _id_E729413199FE30D3 = getnumparts(model);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E729413199FE30D3; _id_AC0E594AC96AA3A8++) {
    if(part == getpartname(model, _id_AC0E594AC96AA3A8))
      return 1;
  }

  return 0;
}

make_weapon_and_attach(basename, attachments, tagname, viewmodel, precache) {
  if(!istrue(precache)) {
    isvalid = 0;

    if(isent(self) || isai(self))
      isvalid = 1;
  }

  if(!isDefined(attachments))
    attachments = [];

  if(!isDefined(viewmodel))
    viewmodel = 0;

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](basename)))
    weapon = [[level.fnbuildweaponspecial]](basename);
  else
    weapon = [[level.fnbuildweapon]](basename, attachments);

  if(!istrue(precache)) {
    if(isDefined(tagname))
      self attach(getweaponmodel(basename), tagname);
    else
      self attach(getweaponmodel(basename));
  }

  self.attachedweaponmodels[0] = basename;
  _id_EB1CF0643B4A4706 = getweaponattachmentworldmodels(weapon);
  _id_11557132741C0723 = undefined;
  _id_AD93B928C004E7E9 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EB1CF0643B4A4706.size; _id_AC0E594AC96AA3A8++) {
    if(istrue(_id_AD93B928C004E7E9))
      model = _id_EB1CF0643B4A4706[_id_11557132741C0723];
    else
      model = _id_EB1CF0643B4A4706[_id_AC0E594AC96AA3A8];

    if(!isDefined(_id_AD93B928C004E7E9) && isstartstr(model, "att_wm_laser")) {
      _id_11557132741C0723 = _id_AC0E594AC96AA3A8;
      continue;
    }

    if(istrue(viewmodel)) {
      array = strtok(model, "_");

      foreach(_id_AC0E594AC96AA3A8, _id_E97377032A878881 in array) {
        if(_id_AC0E594AC96AA3A8 == 0) {
          model = _id_E97377032A878881;
          continue;
        }

        if(_id_E97377032A878881 == "wm") {
          model = model + "_vm";
          continue;
        }

        model = model + "_" + _id_E97377032A878881;
      }
    }

    if(istrue(precache))
      precachemodel(model);
    else {
      self attach(model);
      self.attachedweaponmodels = scripts\engine\utility::array_add(self.attachedweaponmodels, model);
    }

    if(!isDefined(_id_AD93B928C004E7E9) && isDefined(_id_11557132741C0723) && _id_AC0E594AC96AA3A8 == _id_EB1CF0643B4A4706.size - 1) {
      _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 - 1;
      _id_AD93B928C004E7E9 = 1;
    }
  }

  if(!istrue(precache)) {
    switch (basename) {
      case "iw8_pi_cpapa":
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

    foreach(model in _id_EB1CF0643B4A4706) {
      part = "tag_sight_on";

      if(issubstr(model, "reflex") && _id_1C61924EDF3431FD(model, part)) {
        self hidepart(part);
        continue;
      }

      if(issubstr(model, "holo")) {
        self hidepart(part);
        continue;
      }

      if(issubstr(model, "acog"))
        self hidepart(part);
    }
  }
}

make_weapon_random(weaponname, _id_0E052C0161D3EF54, _id_C8F4FE738C61245A, _id_C9C92192A039D262, _id_5DB02031665A8928) {
  attachments = get_random_attachments(_id_0E052C0161D3EF54, _id_C8F4FE738C61245A);
  weapon = [[level.fnbuildweapon]](weaponname, attachments);

  if(isDefined(_id_C9C92192A039D262) && _id_C9C92192A039D262.size > 0 && scripts\engine\utility::cointoss())
    weapon = weapon withcamo(_id_C9C92192A039D262[randomint(_id_C9C92192A039D262.size)]);

  if(istrue(_id_5DB02031665A8928)) {
    foreach(attachment in attachments) {
      if(isstartstr(attachment, "acog")) {
        weapon = weapon withreticle(randomint(8));
        continue;
      }

      if(isstartstr(attachment, "hybrid_west")) {
        weapon = weapon withreticle(randomint(8));
        continue;
      }

      if(isstartstr(attachment, "thermalsnpr")) {
        weapon = weapon withreticle(randomint(8));
        continue;
      }

      if(isstartstr(attachment, "thermal")) {
        weapon = weapon withreticle(randomint(8));
        continue;
      }

      if(isstartstr(attachment, "holo")) {
        weapon = weapon withreticle(randomint(11));
        continue;
      }

      if(isstartstr(attachment, "reflex")) {
        weapon = weapon withreticle(randomint(12));
        continue;
      }

      if(isstartstr(attachment, "minireddot")) {
        weapon = weapon withreticle(randomint(10));
        continue;
      }

      if(isstartstr(attachment, "snprscope")) {
        weapon = weapon withreticle(randomint(13));
        continue;
      }

      if(isstartstr(attachment, "vzscope"))
        weapon = weapon withreticle(randomint(13));
    }
  }

  return weapon;
}

get_random_attachments(_id_0E052C0161D3EF54, _id_C8F4FE738C61245A) {
  if(isDefined(_id_C8F4FE738C61245A) && _id_C8F4FE738C61245A.size > 0) {
    if(_id_0E052C0161D3EF54.size < 1)
      return _id_C8F4FE738C61245A[randomint(_id_C8F4FE738C61245A.size)];

    if(randomint(4) == 0)
      return _id_C8F4FE738C61245A[randomint(_id_C8F4FE738C61245A.size)];
  }

  attachments = [];

  if(_id_0E052C0161D3EF54.size < 1)
    return attachments;

  foreach(_id_AC0E594AC96AA3A8, type in _id_0E052C0161D3EF54) {
    if(isint(_id_0E052C0161D3EF54[_id_AC0E594AC96AA3A8][0])) {
      if(randomint(100) < _id_0E052C0161D3EF54[_id_AC0E594AC96AA3A8][0]) {
        if(level.script == "nightwar" && _id_AC0E594AC96AA3A8 == "scopes") {
          _id_26F853388D329915 = [];

          foreach(s, scope in type) {
            if(!issubstr(type[s], "therm") && !issubstr(type[s], "nvg"))
              _id_26F853388D329915 = scripts\engine\utility::array_add(_id_26F853388D329915, scope);
          }

          type = _id_26F853388D329915;
        }

        if(type.size > 1)
          attachments = scripts\engine\utility::array_add(attachments, type[randomint(type.size - 1) + 1]);
      }

      continue;
    }

    return attachments;
  }

  _id_F1E57ECB00D19239 = undefined;
  _id_D289518E47EB6442 = undefined;

  foreach(_id_AC0E594AC96AA3A8, attachment in attachments) {
    if(scripts\engine\utility::string_starts_with(attachment, "grip")) {
      _id_D289518E47EB6442 = _id_AC0E594AC96AA3A8;
      continue;
    }

    if(issubstr(attachment, "ub_") || issubstr(attachment, "glmini"))
      _id_F1E57ECB00D19239 = _id_AC0E594AC96AA3A8;
  }

  if(isDefined(_id_F1E57ECB00D19239) && isDefined(_id_D289518E47EB6442)) {
    if(randomint(3) == 0)
      attachments = scripts\engine\utility::array_remove_index(attachments, _id_F1E57ECB00D19239);
    else
      attachments = scripts\engine\utility::array_remove_index(attachments, _id_D289518E47EB6442);
  }

  return attachments;
}

get_weapon_weighted(weapons, _id_FDAB9B95B6294FB5) {
  probabilities = [];
  keys = getarraykeys(_id_FDAB9B95B6294FB5);

  foreach(_id_AC0E594AC96AA3A8, weapon in weapons) {
    index = scripts\engine\utility::array_find(keys, weapon);

    if(isDefined(index)) {
      probabilities[probabilities.size] = _id_FDAB9B95B6294FB5[keys[index]];
      continue;
    }

    probabilities[probabilities.size] = 0;
  }

  _id_AD5AF2D62789B80D = 0;

  foreach(_id_7E1B02C65B1197C8 in probabilities)
  _id_AD5AF2D62789B80D = _id_AD5AF2D62789B80D + _id_7E1B02C65B1197C8;

  if(_id_AD5AF2D62789B80D > 100) {}

  if(_id_AD5AF2D62789B80D < 100) {
    _id_2D3C546342A0A1EF = 100 - _id_AD5AF2D62789B80D;
    _id_42458DB5C26F0725 = 0;

    foreach(_id_7E1B02C65B1197C8 in probabilities) {
      if(_id_7E1B02C65B1197C8 == 0)
        _id_42458DB5C26F0725 = _id_42458DB5C26F0725 + 1;
    }

    if(_id_42458DB5C26F0725 > 0) {
      _id_FD631334ED8AFEAF = _id_2D3C546342A0A1EF / _id_42458DB5C26F0725;

      foreach(_id_AC0E594AC96AA3A8, _id_7E1B02C65B1197C8 in probabilities) {
        if(_id_7E1B02C65B1197C8 == 0)
          probabilities[_id_AC0E594AC96AA3A8] = _id_FD631334ED8AFEAF;
      }
    }
  }

  _id_8B591B0BC361AB3D = randomint(100);

  foreach(_id_AC0E594AC96AA3A8, _id_7E1B02C65B1197C8 in probabilities) {
    if(_id_AC0E594AC96AA3A8 > 0)
      probabilities[_id_AC0E594AC96AA3A8] = _id_7E1B02C65B1197C8 + probabilities[_id_AC0E594AC96AA3A8 - 1];

    if(_id_8B591B0BC361AB3D < probabilities[_id_AC0E594AC96AA3A8])
      return weapons[_id_AC0E594AC96AA3A8];
  }

  if(getdvarint("dvar_0045281F93550798")) {
    if(weapons.size > 1) {}
  }

  return weapons[0];
}

lookatentity(ent, intensity) {
  _id_B80E9591C1396BFD = 1;

  if(isDefined(intensity))
    _id_B80E9591C1396BFD = intensity;

  self.entitylookingat = ent;

  if(isDefined(ent)) {
    self.lookingatent = 1;
    self setlookatentity(ent, _id_B80E9591C1396BFD);
  } else {
    self.lookingatent = 0;
    self setlookatentity();
  }
}

lookatstateoverride(state) {
  self.lookatstateoverride = state;

  if(isDefined(state))
    self setlookatstateoverride(state);
  else
    self setlookatstateoverride();
}

civ_glancedownpath(duration) {
  if(!isDefined(self.pathgoalpos)) {
    return;
  }
  self.internal_entitytolookat = self.entitylookingat;
  lookatentity();
  internal_civglancedownpath(gettime(), duration);
  lookatentity(self.internal_entitytolookat);
  self.internal_entitytolookat = undefined;
  self notify("glance_finished");
}

internal_civglancedownpath(starttime, duration) {
  _id_F3EDCEFBABC5A8F0 = 2500;
  lookdownpathdist = scripts\engine\utility::ter_op(isDefined(self.lookdownpathdist), self.lookdownpathdist, 75);

  while(starttime + duration > gettime()) {
    glanceatpos = self getposonpath(lookdownpathdist);
    glanceatpos = glanceatpos + (0, 0, 60);

    if(distancesquared(self.origin, glanceatpos) < _id_F3EDCEFBABC5A8F0) {
      break;
    }

    self setlookat(glanceatpos);
    waitframe();
  }

  self stoplookat();
}

glancestop() {
  self stoplookat();
}

lookatpos(pos, intensity) {
  self notify("newLookAt");

  if(!isDefined(intensity))
    intensity = 1;

  if(!isDefined(pos))
    self stoplookat();
  else
    self setlookat(pos, intensity);
}

isweaponepic(weapon) {
  attachments = getweaponattachments(weapon);

  if(!isDefined(attachments))
    return 0;

  foreach(attachment in attachments) {
    if(issubstr(attachment, "epic"))
      return 1;
  }

  return 0;
}

isdamageweapon(weapon) {
  objweapon = self.damageweapon;

  if(!isDefined(objweapon))
    return 0;

  if(isnullweapon(objweapon))
    return 0;

  if(objweapon.basename != getweaponbasename(weapon))
    return 0;

  return 1;
}

meleegrab_ksweapon_used() {
  _id_3409A5225CC97C6A = ["mars_killstreak", "iw7_jackal_support_designator"];
  currentweapon = self getcurrentweapon();

  if(scripts\engine\utility::array_contains(_id_3409A5225CC97C6A, currentweapon.basename))
    return 1;

  if(self isdroppingweapon())
    return 1;

  if(self israisingweapon()) {
    if(scripts\engine\utility::array_contains(_id_3409A5225CC97C6A, currentweapon.basename))
      return 1;
  }

  return 0;
}

wasdamagedbyoffhandshield() {
  if(!isDefined(self.damagemod) || self.damagemod != "MOD_MELEE")
    return 0;

  objweapon = self.damageweapon;

  if(!isDefined(objweapon) || objweapon.type != "shield")
    return 0;

  return 1;
}

shouldburnfromdamage(damageweapon) {
  if(damageweapon.basename == "molotov" || damageweapon.basename == "molotov_mp" || istrue(damageweapon.isdragonsbreath))
    return 1;

  return 0;
}

wasdamagedbyexplosive() {
  if(isDefined(self.damagemod)) {
    if(isexplosivedamagemod(self.damagemod))
      return 1;

    if(isDefined(self.damageweapon) && shouldburnfromdamage(self.damageweapon))
      return 1;

    if(wasdamagedbyoffhandshield())
      return 1;

    if(self.damagemod == "MOD_MELEE" && isDefined(self.attacker) && isDefined(self.attacker.unittype) && self.attacker.unittype == "c8")
      return 1;
  }

  if(gettime() - anim.lastcarexplosiontime <= 50) {
    _id_5BF0CCB545DC79B2 = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;

    if(distancesquared(self.origin, anim.lastcarexplosiondamagelocation) < _id_5BF0CCB545DC79B2) {
      _id_BCE0AE3DBE49AC18 = _id_5BF0CCB545DC79B2 * 0.5 * 0.5;
      self.maydoupwardsdeath = distancesquared(self.origin, anim.lastcarexplosionlocation) < _id_BCE0AE3DBE49AC18;
      return 1;
    }
  }

  return 0;
}

getdamagetype(type) {
  if(!isDefined(type))
    return "unknown";

  type = tolower(type);

  switch (type) {
    case "mod_crush":
    case "mod_melee":
    case "melee":
      return "melee";
    case "bullet":
    case "mod_rifle_bullet":
    case "mod_pistol_bullet":
      return "bullet";
    case "splash":
    case "mod_explosive_bullet":
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

isprotectedbyriotshield(enemy) {
  if(istrue(enemy.hasriotshield)) {
    _id_3445E5886EF95E60 = self.origin - enemy.origin;
    _id_A79562CDED0C03A2 = vectorNormalize((_id_3445E5886EF95E60[0], _id_3445E5886EF95E60[1], 0));
    _id_CBDE868D773316B1 = anglesToForward(enemy.angles);
    _id_5D2CAFCFFFAB5EF7 = vectordot(_id_CBDE868D773316B1, _id_3445E5886EF95E60);

    if(istrue(enemy.hasriotshieldequipped) || isDefined(enemy.riotshieldmodel)) {
      if(_id_5D2CAFCFFFAB5EF7 > 0.766)
        return 1;
    } else if(_id_5D2CAFCFFFAB5EF7 < -0.766)
      return 1;
  }

  return 0;
}

isprotectedbyaxeblock(source) {
  _id_05C4172357DB8478 = 0;
  currentweapon = self getcurrentweapon();
  _id_636D503B57782BCC = self adsButtonPressed();
  _id_4AABE1C26E2CCCF7 = 0;
  _id_E8398F912490AC89 = 0;
  _id_0A0F0C6714056AAB = 0;
  _id_CB3A01DFC6DDD1BE = anglesToForward(self.angles);
  _id_602474D24A1F1F48 = vectorNormalize(source.origin - self.origin);
  _id_9913FD1FFEA99C33 = vectordot(_id_602474D24A1F1F48, _id_CB3A01DFC6DDD1BE);

  if(_id_9913FD1FFEA99C33 > 0.5)
    _id_4AABE1C26E2CCCF7 = 1;

  if(currentweapon.basename == "iw6_axe_mp" || currentweapon.basename == "iw7_axe_zm") {
    _id_0A0F0C6714056AAB = self getcurrentweaponclipammo();
    _id_E8398F912490AC89 = 1;
  }

  if(_id_E8398F912490AC89 && _id_636D503B57782BCC && _id_4AABE1C26E2CCCF7 && _id_0A0F0C6714056AAB > 0) {
    self setweaponammoclip(currentweapon, _id_0A0F0C6714056AAB - 1);
    self playSound("crate_impact");
    earthquake(0.75, 0.5, self.origin, 100);
    _id_05C4172357DB8478 = 1;
  }

  return _id_05C4172357DB8478;
}

isairdropmarker(weaponname) {
  switch (weaponname) {
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

isdestructibleweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  switch (weapon) {
    case "barrel_mp":
    case "destructible_toy":
    case "destructible_car":
    case "destructible":
      return 1;
  }

  return 0;
}

enable_teamflashbangimmunity() {
  thread enable_teamflashbangimmunity_proc();
}

enable_teamflashbangimmunity_proc() {
  self endon("death");

  for(;;) {
    self.teamflashbangimmunity = 1;
    wait 0.05;
  }
}

disable_teamflashbangimmunity() {
  self.teamflashbangimmunity = undefined;
}

setflashbangimmunity(_id_18B72B2000AF4C50) {
  self.flashbangimmunity = _id_18B72B2000AF4C50;
}

getcamotablecolumnindex(_id_661EF4EFCA99FB00) {
  switch (_id_661EF4EFCA99FB00) {
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

getdifficulty() {
  if(level.gameskill < 1)
    return "easy";

  if(level.gameskill < 2)
    return "medium";

  if(level.gameskill < 3)
    return "hard";

  return "fu";
}

clear_movement_speed() {
  self aiclearscriptdesiredspeed();
}

flashbangstop() {
  self.flashendtime = undefined;
}

enable_cqbwalk(_id_AD0A19E7A32A1837) {
  if(self.type == "dog") {
    return;
  }
  if(!isDefined(_id_AD0A19E7A32A1837))
    self.cqbenabled = 1;

  self.turnrate = 0.2;
  demeanor_override("cqb");
}

disable_cqbwalk() {
  if(self.type == "dog") {
    return;
  }
  self.cqbenabled = undefined;
  self.turnrate = 0.3;

  if(isDefined(self.cqb_point_of_interest)) {
    self.cqb_point_of_interest = undefined;
    self _meth_F7D83C92F61DCC31(0);
  }

  clear_demeanor_override();
}

demeanor_override(_id_F7EE87DC76B45E62) {
  self demeanoroverride(_id_F7EE87DC76B45E62);
}

clear_demeanor_override() {
  self _meth_12BCADDB0B667075();
}

isweaponinitialized(objweapon) {
  weaponname = getcompleteweaponname(objweapon);
  return isDefined(self.weaponinfo[weaponname]);
}

initweapon(objweapon) {
  weaponname = getcompleteweaponname(objweapon);
  self.weaponinfo[weaponname] = spawnStruct();
  self.weaponinfo[weaponname].position = "none";
  self.weaponinfo[weaponname].hasclip = 1;

  if(issp()) {
    clipmodel = getweaponclipmodel(objweapon);

    if(isDefined(clipmodel) && clipmodel != "" && (issubstr(clipmodel, "drum") || issubstr(clipmodel, "mag"))) {
      self.weaponinfo[weaponname].useclip = 1;
      return;
    }

    self.weaponinfo[weaponname].useclip = 0;
    return;
  } else
    self.weaponinfo[weaponname].useclip = 0;
}

get_doublejumpenergy() {
  if(!isDefined(self.doublejumpenergy))
    return self energy_getenergy(0);

  return self.doublejumpenergy;
}

set_doublejumpenergy(value) {
  if(!isDefined(self.doublejumpenergy))
    self energy_setenergy(0, value);
  else
    self.doublejumpenergy = value;
}

get_doublejumpenergyrestorerate() {
  if(!isDefined(self.doublejumpenergyrestorerate))
    return self energy_getrestorerate(0);

  return self.doublejumpenergyrestorerate;
}

set_doublejumpenergyrestorerate(value) {
  if(!isDefined(self.doublejumpenergyrestorerate))
    self energy_setrestorerate(0, value);
  else
    self.doublejumpenergyrestorerate = value;
}

playerarmorenabled() {
  return getdvarint("dvar_BFA6BEDC37206C58");
}

playerhelmetenabled() {
  return getdvarint("dvar_425E93B8DE8F141C");
}

spawn_vehicle() {
  return scripts\common\vehicle::vehicle_spawn(self);
}

groundpos(origin, up) {
  return scripts\engine\utility::drop_to_ground(origin, 0, -100000, up);
}

vehicle_detachfrompath() {
  scripts\common\vehicle_code::vehicle_pathdetach();
}

vehicle_resumepath() {
  thread scripts\common\vehicle_paths::vehicle_resumepathvehicle();
}

vehicle_land(_id_363C1A82A40B1004) {
  scripts\common\vehicle_code::vehicle_landvehicle(_id_363C1A82A40B1004);
}

vehicle_liftoff(height) {
  scripts\common\vehicle_code::vehicle_liftoffvehicle(height);
}

vehicle_dynamicpath(node, _id_162E61A6E56B7519) {
  scripts\common\vehicle::vehicle_paths(node, _id_162E61A6E56B7519);
}

getvehiclespawner(value, key) {
  spawners = getvehiclespawnerarray(value, key);
  return spawners[0];
}

getvehiclespawnerarray(value, key) {
  return scripts\common\vehicle_code::_getvehiclespawnerarray(value, key);
}

is_map_using_locales_only() {
  mapname = getDvar("g_mapname");

  if(mapname == "mp_donesk" || mapname == "mp_locale_test")
    return 1;

  return 0;
}

iswegameplatform() {
  return getdvarint("g_wegame_platform", 0) == 1;
}

_id_44DAA65837A12044(player, point, distance) {
  _id_EF98493C936A3155 = distancesquared(player.origin, point);
  _id_9799F8752D4AE4BF = distance * distance;

  if(_id_EF98493C936A3155 <= _id_9799F8752D4AE4BF)
    return 1;

  return 0;
}

_id_4FBF8D536D792C25(player, point, distancesquared) {
  _id_EF98493C936A3155 = distancesquared(player.origin, point);

  if(_id_EF98493C936A3155 <= distancesquared)
    return 1;

  return 0;
}

playersnear(point, distance) {
  return _id_0A92D0739B2373DF(point, distance, 1);
}

agentsnear(point, distance) {
  return _id_0A92D0739B2373DF(point, distance, 0);
}

_id_0A92D0739B2373DF(point, distance, _id_9DC460B17444614F) {
  _id_556DB0B72A96514E = physics_createcontents(["physicscontents_characterproxy"]);
  _id_B65B7AEAB526E1AC = (distance, distance, distance);
  _id_80745CF3E2877DF5 = point - _id_B65B7AEAB526E1AC;
  _id_809746F3E2AD954B = point + _id_B65B7AEAB526E1AC;
  hits = physics_aabbbroadphasequery(_id_80745CF3E2877DF5, _id_809746F3E2AD954B, _id_556DB0B72A96514E, []);

  if(!isDefined(_id_9DC460B17444614F))
    return hits;

  _id_9988326D7F084C40 = [];

  foreach(hit in hits) {
    if(isPlayer(hit) == _id_9DC460B17444614F)
      _id_9988326D7F084C40[_id_9988326D7F084C40.size] = hit;
  }

  return _id_9988326D7F084C40;
}

playersincylinder(point, radius, _id_213FDD3689D4B33E, _id_45ACCFF1681E0276) {
  return _id_98A826B6B6D0D118(point, radius, _id_213FDD3689D4B33E, _id_45ACCFF1681E0276, 1);
}

_id_98A826B6B6D0D118(point, radius, _id_73427010F72FA1D6, _id_45ACCFF1681E0276, _id_9DC460B17444614F) {
  _id_556DB0B72A96514E = physics_createcontents(["physicscontents_characterproxy"]);
  _id_C580CE41C807E164 = 1000;

  if(isDefined(_id_45ACCFF1681E0276))
    _id_C580CE41C807E164 = _id_45ACCFF1681E0276;

  _id_B65B7AEAB526E1AC = (radius, radius, _id_C580CE41C807E164);
  _id_80745CF3E2877DF5 = point - _id_B65B7AEAB526E1AC;
  _id_809746F3E2AD954B = point + _id_B65B7AEAB526E1AC;

  if(!isDefined(_id_73427010F72FA1D6))
    _id_73427010F72FA1D6 = [];

  hits = physics_aabbbroadphasequery(_id_80745CF3E2877DF5, _id_809746F3E2AD954B, _id_556DB0B72A96514E, _id_73427010F72FA1D6);
  _id_B7B4304B7E5B638D = [];
  _id_8FA87D2C8780E014 = radius * radius;

  foreach(hit in hits) {
    if(!isDefined(_id_9DC460B17444614F) || _id_9DC460B17444614F == isPlayer(hit)) {
      _id_F95436827E16D133 = distance2dsquared(hit.origin, point);

      if(_id_F95436827E16D133 < _id_8FA87D2C8780E014)
        _id_B7B4304B7E5B638D[_id_B7B4304B7E5B638D.size] = hit;
    }
  }

  return _id_B7B4304B7E5B638D;
}

playersinsphere(point, radius) {
  return _id_2D7FD59D039FA69B(point, radius, 1);
}

_id_2D7FD59D039FA69B(point, radius, _id_9DC460B17444614F) {
  characters = _id_0A92D0739B2373DF(point, radius, _id_9DC460B17444614F);
  _id_49E1E3266B6BE4E8 = [];
  _id_8FA87D2C8780E014 = radius * radius;

  foreach(_id_7DC3241E7F3C6B24 in characters) {
    _id_457471485336C961 = distancesquared(_id_7DC3241E7F3C6B24.origin, point);

    if(_id_457471485336C961 < _id_8FA87D2C8780E014)
      _id_49E1E3266B6BE4E8[_id_49E1E3266B6BE4E8.size] = _id_7DC3241E7F3C6B24;
  }

  return _id_49E1E3266B6BE4E8;
}

trycall(_id_303A0B57F1F9351A, param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807) {
  if(!isDefined(_id_303A0B57F1F9351A)) {
    return;
  }
  if(isDefined(_id_5A6A8AFA11882807))
    return [[_id_303A0B57F1F9351A]](param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807);
  else if(isDefined(_id_F3CB1651D632A555))
    return [[_id_303A0B57F1F9351A]](param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555);
  else if(isDefined(param8))
    return [[_id_303A0B57F1F9351A]](param1, param2, param3, param4, param5, param6, param7, param8);
  else if(isDefined(param7))
    return [[_id_303A0B57F1F9351A]](param1, param2, param3, param4, param5, param6, param7);
  else if(isDefined(param6))
    return [[_id_303A0B57F1F9351A]](param1, param2, param3, param4, param5, param6);
  else if(isDefined(param5))
    return [[_id_303A0B57F1F9351A]](param1, param2, param3, param4, param5);
  else if(isDefined(param4))
    return [[_id_303A0B57F1F9351A]](param1, param2, param3, param4);
  else if(isDefined(param3))
    return [[_id_303A0B57F1F9351A]](param1, param2, param3);
  else if(isDefined(param2))
    return [[_id_303A0B57F1F9351A]](param1, param2);
  else if(isDefined(param1))
    return [[_id_303A0B57F1F9351A]](param1);
  else
    return [[_id_303A0B57F1F9351A]]();
}

spawncorpsehider() {
  if(!iswegameplatform()) {
    return;
  }
  _id_56B6964EF71063F0 = 0;
  _id_97A5BAD4711794A1 = 1;
  _id_6089D94530A16181 = 2;
  _id_655D21C34D71F8B2 = 3;
  _id_617F4EC28F6D0389 = 4;
  _id_39CAA47343792E0C = 5;
  _id_862D7648C9C35048 = "sp/hideCorpseTable.csv";
  _id_64412919E6B0C72E = tolower(getDvar("g_mapname"));
  _id_84AE683600BF3B4C = tablelookupgetnumrows(_id_862D7648C9C35048);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_84AE683600BF3B4C; _id_AC0E594AC96AA3A8++) {
    if(_id_64412919E6B0C72E == tolower(tablelookupbyrow(_id_862D7648C9C35048, _id_AC0E594AC96AA3A8, _id_97A5BAD4711794A1))) {
      modelname = tablelookupbyrow(_id_862D7648C9C35048, _id_AC0E594AC96AA3A8, _id_6089D94530A16181);
      _id_93C6944E98F449EA = strtok(tablelookupbyrow(_id_862D7648C9C35048, _id_AC0E594AC96AA3A8, _id_655D21C34D71F8B2), "_");
      _id_754F514E821637B1 = strtok(tablelookupbyrow(_id_862D7648C9C35048, _id_AC0E594AC96AA3A8, _id_617F4EC28F6D0389), "_");
      _id_1F24BC4B5B83CCE0 = int(tablelookupbyrow(_id_862D7648C9C35048, _id_AC0E594AC96AA3A8, _id_39CAA47343792E0C));
      model = spawn("script_model", (float(_id_93C6944E98F449EA[0]), float(_id_93C6944E98F449EA[1]), float(_id_93C6944E98F449EA[2])));
      model setModel(modelname);
      model.angles = (float(_id_754F514E821637B1[0]), float(_id_754F514E821637B1[1]), float(_id_754F514E821637B1[2]));

      if(_id_1F24BC4B5B83CCE0 > 0)
        model solid();
      else
        model notsolid();
    }
  }
}

_id_35C178C80FA19CBD(part, state) {
  if(self isscriptable()) {
    if(self getscriptablehaspart(part)) {
      if(self getscriptableparthasstate(part, state)) {
        curstate = self getscriptablepartstate(part, 1);

        if(curstate == state)
          return 1;
      }
    }
  }

  return 0;
}

_id_3677F2BE30FDD581(part, state) {
  if(self isscriptable()) {
    if(self getscriptablehaspart(part)) {
      if(self getscriptableparthasstate(part, state)) {
        self setscriptablepartstate(part, state, 1);
        return 1;
      }
    }
  }

  return 0;
}

_id_6E506F39F121EA8A(parent, offset, angles) {
  if(isDefined(offset) && isDefined(angles))
    self scriptablesetparententity(parent, offset, angles);
  else if(isDefined(offset))
    self scriptablesetparententity(parent, offset);
  else
    self scriptablesetparententity(parent);

  self._id_BF8E5F003146AF44 = parent;

  if(!isDefined(parent._id_E478AC91AF0E92CB))
    parent._id_E478AC91AF0E92CB = [];

  parent._id_E478AC91AF0E92CB[parent._id_E478AC91AF0E92CB.size] = self;

  if(parent._id_E478AC91AF0E92CB.size % 10 == 0)
    parent._id_E478AC91AF0E92CB = scripts\engine\utility::array_removeundefined(parent._id_E478AC91AF0E92CB);
}

_id_CEFC758E6B25A243() {
  self scriptableclearparententity();
  parent = self._id_BF8E5F003146AF44;

  if(!isDefined(parent) || !isDefined(parent._id_E478AC91AF0E92CB)) {
    return;
  }
  parent._id_E478AC91AF0E92CB = scripts\engine\utility::array_remove(parent._id_E478AC91AF0E92CB, self);

  if(parent._id_E478AC91AF0E92CB.size == 0)
    parent._id_E478AC91AF0E92CB = undefined;

  self._id_BF8E5F003146AF44 = undefined;
}

_id_B6A59F7759A30482(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811)
    self[[level._id_74A171505D979CBC._id_950DA684EAE1C18A]]();
  else
    self[[level._id_74A171505D979CBC._id_A7013F4BC7F81AFF]]();
}

_id_1A479CAD9C3ADBB1(_id_E3108E412AFB3811) {
  self._id_1A479CAD9C3ADBB1 = _id_E3108E412AFB3811;
}

_id_C4EC7D985422CE24(_id_437409FD34EB2546) {
  self._id_7E7071F7B9501085 delete();
  level.scr_model["scripted_melee_player_rig"] = _id_437409FD34EB2546;
  self[[level._id_74A171505D979CBC._id_02EC260CA66F2378]]();
  self._id_7E7071F7B9501085 notsolid();
  self._id_7E7071F7B9501085 hide();
}

_id_AA54D0684BB8D0CF(weapon) {
  self._id_2CD5923C5934A055 = weapon;
}

_id_F0969C633B166F3E(_id_26BF4103F0ED37D5) {
  if(!isDefined(_id_26BF4103F0ED37D5))
    _id_26BF4103F0ED37D5 = 1;

  if(istrue(_id_26BF4103F0ED37D5))
    self._id_2CD5923C5934A055 = "att_vm_p33_me_tac_knife01_v0";
  else
    self._id_2CD5923C5934A055 = undefined;
}

_id_6D2D330FC885914C() {
  self endon("death");
  self waittill("scripted_melee_anim_ended");
  waittillframeend;

  while(istrue(self._id_E5E956F3DF0184EE))
    waitframe();
}

_id_A1260C3B5F229F69() {
  return "scripted_melee_start";
}

_id_AE9FB94402A02D07() {
  return "scripted_melee_anim_started";
}

_id_A73C26A3FEB8EF0E() {
  return "scripted_melee_anim_ended";
}

_id_835E274F31E87CF4() {
  return "scripted_melee_anim_ended_longest";
}

_id_7E105B48CE221583() {
  return self._id_A13EDA80C7C29501;
}

_id_D561019E2A68D6CF() {
  return level._id_74A171505D979CBC._id_A30FF6D320CC665E;
}

_id_EA3248E9ABE4700A() {
  return "scripted_melee_player_rig";
}

_id_7A5A6498179656FC(_id_56E57B64F9AC67C4, direction, rules, _id_FB8F407964E90B58, _id_B728A0A492AFF957, _id_587D102C235C401A, override, _id_2FE1D1A5E6E2B591, _id_122D342799919CAF, _id_F5C48C59E172E0CB) {
  direction = tolower(direction);
  array = [];
  array[direction]["animScene"] = _id_56E57B64F9AC67C4;

  if(isDefined(rules)) {
    if(isarray(rules))
      array[direction]["rules"] = rules;
    else
      array[direction]["rules"] = [[rules]]();
  } else
    array[direction]["rules"] = [[level._id_74A171505D979CBC._id_2EDA72772D041081]]();

  if(isDefined(_id_FB8F407964E90B58))
    array[direction]["victimLives"] = _id_FB8F407964E90B58;
  else
    array[direction]["victimLives"] = 0;

  if(isDefined(_id_B728A0A492AFF957))
    array[direction]["startStance"] = _id_587D102C235C401A;
  else
    array[direction]["startStance"] = undefined;

  if(isDefined(_id_587D102C235C401A))
    array[direction]["endStance"] = _id_587D102C235C401A;
  else
    array[direction]["endStance"] = undefined;

  if(isDefined(_id_2FE1D1A5E6E2B591))
    array[direction]["marina_hack"] = _id_2FE1D1A5E6E2B591;
  else
    array[direction]["marina_hack"] = undefined;

  if(isDefined(_id_122D342799919CAF))
    array[direction]["usePistol"] = _id_122D342799919CAF;
  else
    array[direction]["usePistol"] = undefined;

  if(isDefined(_id_F5C48C59E172E0CB))
    array[direction]["boneOverride"] = _id_F5C48C59E172E0CB;
  else
    array[direction]["boneOverride"] = "TAG_ACCESSORY_RIGHT";

  if(level == self)
    _id_5E7BDE4C30450810(level._id_74A171505D979CBC, _id_56E57B64F9AC67C4, direction, override, array);
  else {
    if(!isDefined(self._id_74A171505D979CBC))
      self._id_74A171505D979CBC = spawnStruct();

    _id_5E7BDE4C30450810(self._id_74A171505D979CBC, _id_56E57B64F9AC67C4, direction, override, array);
  }
}

_id_5E7BDE4C30450810(struct, _id_56E57B64F9AC67C4, direction, override, array) {
  if(istrue(override)) {
    if(!isDefined(struct._id_5E0A4F882198A116))
      struct._id_5E0A4F882198A116 = [];

    if(!isDefined(struct._id_5E0A4F882198A116[direction]))
      struct._id_5E0A4F882198A116[direction] = [];

    if(struct._id_5E0A4F882198A116[direction].size > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < struct._id_5E0A4F882198A116[direction].size; _id_AC0E594AC96AA3A8++) {
        if(isDefined(struct._id_5E0A4F882198A116[direction][_id_AC0E594AC96AA3A8]["animScene"]) && struct._id_5E0A4F882198A116[direction][_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          struct._id_5E0A4F882198A116[direction] = scripts\engine\utility::array_remove_index(struct._id_5E0A4F882198A116[direction], _id_AC0E594AC96AA3A8);
      }
    }

    struct._id_5E0A4F882198A116[direction] = scripts\engine\utility::array_combine(struct._id_5E0A4F882198A116[direction], array);
  } else {
    if(!isDefined(struct.anims))
      struct.anims = [];

    if(!isDefined(struct.anims[direction]))
      struct.anims[direction] = [];

    struct.anims[direction] = scripts\engine\utility::array_combine(struct.anims[direction], array);
  }
}

_id_41CB362E1D3B89B1(_id_56E57B64F9AC67C4, override) {
  if(istrue(override)) {
    if(isDefined(self._id_F145D382DCA7F7EE) && isDefined(self._id_74A171505D979CBC) && isDefined(self._id_74A171505D979CBC._id_5E0A4F882198A116))
      _id_2BB6F41FFCBD4BEA(self._id_74A171505D979CBC, _id_56E57B64F9AC67C4, override);
    else if(isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116) && isDefined(self._id_F145D382DCA7F7EE))
      _id_2BB6F41FFCBD4BEA(level._id_74A171505D979CBC, _id_56E57B64F9AC67C4, override);
    else
      iprintln("no overrides, doing nothing.");
  } else
    _id_2BB6F41FFCBD4BEA(level._id_74A171505D979CBC, _id_56E57B64F9AC67C4, override);
}

_id_2BB6F41FFCBD4BEA(struct, _id_56E57B64F9AC67C4, override) {
  if(istrue(override)) {
    _id_8E4D6CA7020FE22F = getarraykeys(struct._id_5E0A4F882198A116);

    foreach(direction in _id_8E4D6CA7020FE22F) {
      found = undefined;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < struct._id_5E0A4F882198A116[direction].size; _id_AC0E594AC96AA3A8++) {
        if(struct._id_5E0A4F882198A116[direction][_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          found = 1;

        if(istrue(found) && struct._id_5E0A4F882198A116[direction].size > 1) {
          struct._id_5E0A4F882198A116[direction] = scripts\engine\utility::array_remove_index(struct._id_5E0A4F882198A116[direction], _id_AC0E594AC96AA3A8);
          continue;
        }

        if(istrue(found)) {
          self._id_F145D382DCA7F7EE = scripts\engine\utility::array_remove(self._id_F145D382DCA7F7EE, direction);
          struct._id_5E0A4F882198A116 = scripts\engine\utility::array_remove_key(struct._id_5E0A4F882198A116, direction);
          break;
        }
      }
    }
  } else {
    _id_8E4D6CA7020FE22F = getarraykeys(struct.anims);

    foreach(direction in _id_8E4D6CA7020FE22F) {
      found = undefined;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < struct.anims[direction].size; _id_AC0E594AC96AA3A8++) {
        if(struct.anims[direction][_id_AC0E594AC96AA3A8]["animScene"] == _id_56E57B64F9AC67C4)
          found = 1;

        if(istrue(found) && struct.anims[direction].size > 1) {
          struct.anims[direction] = scripts\engine\utility::array_remove_index(struct.anims[direction], _id_AC0E594AC96AA3A8);
          continue;
        }

        if(istrue(found)) {
          struct.anims = scripts\engine\utility::array_remove_key(struct.anims, direction);
          break;
        }
      }
    }
  }
}

_id_299B43EE3353DACC(_id_56E57B64F9AC67C4, direction, rules, _id_FB8F407964E90B58, _id_28FED3DA1DF154FB, _id_B728A0A492AFF957, _id_587D102C235C401A, funcs, launch, _id_2FE1D1A5E6E2B591, _id_122D342799919CAF, _id_F5C48C59E172E0CB) {
  if(!isDefined(direction))
    direction = "all";

  direction = tolower(direction);

  if(!isDefined(_id_28FED3DA1DF154FB))
    _id_28FED3DA1DF154FB = 1;

  if(istrue(_id_28FED3DA1DF154FB))
    _id_A072535B3F7182FE(direction);

  if(!isDefined(self._id_F145D382DCA7F7EE))
    self._id_F145D382DCA7F7EE = [];

  if(!scripts\engine\utility::array_contains(self._id_F145D382DCA7F7EE, direction))
    self._id_F145D382DCA7F7EE = scripts\engine\utility::array_add(self._id_F145D382DCA7F7EE, direction);

  if(isDefined(rules) && isarray(rules) && scripts\engine\utility::array_contains(rules, "defaults")) {
    index = scripts\engine\utility::array_find(rules, "defaults");
    rules = scripts\engine\utility::array_remove_index(rules, index);
    rules = _id_33BEA9FCD7E7D254(rules);
  }

  _id_7A5A6498179656FC(_id_56E57B64F9AC67C4, direction, rules, _id_FB8F407964E90B58, _id_B728A0A492AFF957, _id_587D102C235C401A, 1, _id_2FE1D1A5E6E2B591, _id_122D342799919CAF, _id_F5C48C59E172E0CB);
  notetracks = ["cm_death", "cm_ragdoll"];
  _id_E830EBCF792A5EF2[0] = ::_id_26E31291E7D65683;
  _id_E830EBCF792A5EF2[1] = ::_id_6812BF6F8500B33A;

  foreach(n, notetrack in notetracks) {
    if(isDefined(level.scr_notetrack["generic"]) && isDefined(level.scr_notetrack["generic"][_id_56E57B64F9AC67C4]) && isDefined(level.scr_notetrack["generic"][_id_56E57B64F9AC67C4][notetrack]) && level.scr_notetrack["generic"][_id_56E57B64F9AC67C4][notetrack].size > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.scr_notetrack["generic"][_id_56E57B64F9AC67C4][notetrack].size; _id_AC0E594AC96AA3A8++) {
        if(isDefined(level.scr_notetrack["generic"][_id_56E57B64F9AC67C4][notetrack][_id_AC0E594AC96AA3A8]["function"])) {
          if(level.scr_notetrack["generic"][_id_56E57B64F9AC67C4][notetrack][_id_AC0E594AC96AA3A8]["function"] == _id_E830EBCF792A5EF2[n])
            level.scr_notetrack["generic"][_id_56E57B64F9AC67C4][notetrack][_id_AC0E594AC96AA3A8]["function"] = undefined;
        }
      }
    }
  }

  scripts\common\anim::addnotetrack_customfunction("generic", "cm_death", ::_id_26E31291E7D65683, _id_56E57B64F9AC67C4);
  scripts\common\anim::addnotetrack_customfunction("generic", "cm_ragdoll", ::_id_6812BF6F8500B33A, _id_56E57B64F9AC67C4);
  scripts\common\anim::addnotetrack_customfunction("generic", "cm_fx", ::_id_E24378166154FC99, _id_56E57B64F9AC67C4);
}

_id_26E31291E7D65683(guy) {
  [[level._id_74A171505D979CBC._id_0FBD8726770C4C39]](guy);
}

_id_6812BF6F8500B33A(guy) {
  [[level._id_74A171505D979CBC._id_8A66FB76621B9C84]](guy);
}

_id_E24378166154FC99(guy) {
  [[level._id_74A171505D979CBC._id_5415E799CAE1BAC7]](guy);
}

_id_DF3C0EBA274A0121(_id_56E57B64F9AC67C4) {
  _id_41CB362E1D3B89B1(_id_56E57B64F9AC67C4, 1);
}

_id_A072535B3F7182FE(direction, _id_79AA652300C68D5A) {
  if(isDefined(self._id_F145D382DCA7F7EE) && scripts\engine\utility::array_contains(self._id_F145D382DCA7F7EE, direction))
    self._id_F145D382DCA7F7EE = scripts\engine\utility::array_remove(self._id_F145D382DCA7F7EE, direction);

  if(!isDefined(_id_79AA652300C68D5A))
    _id_79AA652300C68D5A = 1;

  if(istrue(_id_79AA652300C68D5A) || self == level) {
    if(isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116) && isDefined(level._id_74A171505D979CBC._id_5E0A4F882198A116[direction]))
      level._id_74A171505D979CBC._id_5E0A4F882198A116[direction] = [];
  }
}

_id_37E61C71BCC30CF9(parent) {
  self._id_E3E345B123304389 = parent;
}

_id_33BEA9FCD7E7D254(rules) {
  if(!isarray(rules))
    rules = [rules];

  rules = scripts\engine\utility::array_combine([[level._id_74A171505D979CBC._id_2EDA72772D041081]](), rules);
  return rules;
}

_id_BBEBFBDDD1B77A34() {
  return self.in_melee_death;
}

_id_75B55C43BF528532() {
  return level._id_74A171505D979CBC.enabled;
}

_id_B88F4E5BAFF057A9(_id_48ACCC37953CFC3B) {
  if(_id_48ACCC37953CFC3B <= 0.25)
    return 0;
  else if(_id_48ACCC37953CFC3B <= 0.4)
    return 1;
  else if(_id_48ACCC37953CFC3B <= 0.6)
    return 2;
  else if(_id_48ACCC37953CFC3B <= 0.8)
    return 3;

  return 4;
}

_id_32FD8E6A43DA67B8(_id_CC748B6D457627FE) {
  if(_id_CC748B6D457627FE == 0.0)
    _id_EAABF9463637080F = 50;
  else if(_id_CC748B6D457627FE < 0.25)
    _id_EAABF9463637080F = _func_CF14FFC946066DBD(0.0, 0.25, 50, 25, _id_CC748B6D457627FE);
  else if(_id_CC748B6D457627FE < 0.75)
    _id_EAABF9463637080F = _func_CF14FFC946066DBD(0.25, 0.75, 25, 10, _id_CC748B6D457627FE);
  else if(_id_CC748B6D457627FE < 1.4)
    _id_EAABF9463637080F = _func_CF14FFC946066DBD(0.75, 1.4, 10, 5, _id_CC748B6D457627FE);
  else if(_id_CC748B6D457627FE < 3.5)
    _id_EAABF9463637080F = _func_CF14FFC946066DBD(1.4, 3.5, 5, 2, _id_CC748B6D457627FE);
  else if(_id_CC748B6D457627FE < 7.5)
    _id_EAABF9463637080F = _func_CF14FFC946066DBD(3.5, 7.5, 2, 1, _id_CC748B6D457627FE);
  else if(_id_CC748B6D457627FE < 14.0)
    _id_EAABF9463637080F = _func_CF14FFC946066DBD(7.5, 14.0, 1, 0.5, _id_CC748B6D457627FE);
  else
    _id_EAABF9463637080F = _func_CF14FFC946066DBD(14.0, 3.0, 0.5, 0, _id_CC748B6D457627FE);

  return _id_EAABF9463637080F;
}

dof_enable_autofocus(fstop, _id_B3AEFAFBA795117F, _id_965582B4F1F2F995, _id_A73DE14F2A32675F, angles, _id_387062334AB0E50E, ignorelist, ignorecollision, _id_4A0992CE3FF1D7EA) {
  _id_285752B1F53ED9F1::dyndof(fstop, _id_B3AEFAFBA795117F, _id_965582B4F1F2F995, _id_A73DE14F2A32675F, angles, _id_387062334AB0E50E, ignorelist, ignorecollision, _id_4A0992CE3FF1D7EA);
}

dof_disable_autofocus() {
  _id_285752B1F53ED9F1::dyndof_disable();
}

dof_enable(fstop, focusdistance, _id_B3AEFAFBA795117F, focusspeed, aperturespeed, _id_C06551440B16249C, _id_9AC1D65434108DCC) {
  if(!isDefined(focusdistance) && isstruct(_id_B3AEFAFBA795117F) && _id_B3AEFAFBA795117F == level) {} else if(!isDefined(focusdistance))
    focusdistance = 1;

  if(!isDefined(focusspeed))
    focusspeed = 1.0;

  if(!isDefined(aperturespeed))
    aperturespeed = 2.0;

  player = self;
  player notify("stop_dyndof");
  player notify("stop_dyndof_debug");

  if(issp())
    setsaveddvar("r_dof_physical_enable", 1);
  else
    setDvar("r_dof_physical_enable", 1);

  player enablephysicaldepthoffieldscripting();

  if(isDefined(_id_B3AEFAFBA795117F)) {
    if(isDefined(_id_9AC1D65434108DCC))
      _id_C06551440B16249C = _id_B3AEFAFBA795117F gettagorigin(_id_9AC1D65434108DCC);
    else
      _id_C06551440B16249C = _id_B3AEFAFBA795117F.origin;
  } else {}

  if(isDefined(_id_C06551440B16249C))
    player setphysicaldepthoffield(fstop, focusdistance, focusspeed, aperturespeed, _id_C06551440B16249C);
  else if(isDefined(aperturespeed))
    player setphysicaldepthoffield(fstop, focusdistance, focusspeed, aperturespeed);
  else if(isDefined(focusspeed))
    player setphysicaldepthoffield(fstop, focusdistance, focusspeed);
  else
    player setphysicaldepthoffield(fstop, focusdistance);
}

dof_disable() {
  self notify("stop_dyndof");
  self notify("stop_dyndof_debug");
  self disablephysicaldepthoffieldscripting();
}

_id_9A90DBEC5A937F84(fstop, focusspeed, aperturespeed) {
  _id_285752B1F53ED9F1::_id_C1F42ED707642A04(fstop, focusspeed, aperturespeed);
}

_id_B4ACCA4C27BC193F() {
  scripts\engine\utility::flag_set("dyndofexp_disable");
}

_id_0DE3E6FE532BD6CA() {
  scripts\engine\utility::flag_clear("dyndofexp_disable");
}

_id_2AF2E0EDE2893721() {
  level notify("stop_dyndof");
  level.dyndof = undefined;
  level.player disablephysicaldepthoffieldscripting();
}

_id_D5D0823D606A2A6E(_id_0B8B9E9EFD754D14) {
  if(isDefined(_id_0B8B9E9EFD754D14)) {
    if(isDefined(level.trial) && isDefined(level.trial["missionScript"]) && level.trial["missionScript"] == _id_0B8B9E9EFD754D14)
      return 1;
  } else if(isDefined(level.trial) && isDefined(level.trial["missionScript"]))
    return 1;

  return 0;
}

_id_A10967D736DC56E5() {
  return issp() || iscp() || istrue(level._id_289DF80E1DED586F) || getdvarint("scr_default_maxagents", 0) > 0;
}

_id_22490AAEBAAC105E(model_name, origin, angles, _id_4C51CF2B9C91C17C) {
  origin = scripts\engine\utility::_id_53C4C53197386572(origin, (0, 0, 0));
  angles = scripts\engine\utility::_id_53C4C53197386572(angles, (0, 0, 0));
  _id_4C51CF2B9C91C17C = scripts\engine\utility::_id_53C4C53197386572(_id_4C51CF2B9C91C17C, 0);

  for(;;) {
    model = spawn("script_model", origin, _id_4C51CF2B9C91C17C);

    if(isDefined(model)) {
      break;
    } else {}

    waitframe();
  }

  if(isstring(model_name))
    model setModel(model_name);
  else {}

  model.angles = angles;
  return model;
}

_id_FABDD936C0F438E2(_id_C21614AB5A22F7EA, _id_0ABA03C6E266EF63, angle) {
  setDvar("dvar_D2840794D9092EEC", _id_C21614AB5A22F7EA);
  setDvar("dvar_382EA3BA7840CED3", _id_0ABA03C6E266EF63);
  setDvar("dvar_C59327EE5D4929C1", cos(angle));
}

string_is_single_digit_integer(str) {
  if(str.size > 1)
    return 0;

  switch (str) {
    case "9":
    case "8":
    case "7":
    case "6":
    case "5":
    case "4":
    case "3":
    case "2":
    case "1":
    case "0":
      return 1;
    default:
      return 0;
  }
}

_id_1FB1CB439AA1E23C(str) {
  if(str.size > 1 && getsubstr(str, 0, 1) == "-")
    str = getsubstr(str, 1, str.size);

  isint = 1;

  for(_id_13F1DFB7040761D7 = 0; _id_13F1DFB7040761D7 < str.size; _id_13F1DFB7040761D7++) {
    isint = isint &string_is_single_digit_integer(getsubstr(str, _id_13F1DFB7040761D7, _id_13F1DFB7040761D7 + 1));

    if(!isint) {
      break;
    }
  }

  return isint;
}

_id_D5AD0EBC9D8935B6(v) {
  return "(" + v[0] + ", " + v[1] + ", " + v[2] + ")";
}

set_battlechatter(state) {
  if(!isalive(self) || !isDefined(level.battlechatter)) {
    return;
  }
  if(isDefined(self.script_bcdialog) && !self.script_bcdialog)
    state = 0;

  if(!isDefined(self.battlechatterallowed) && !state) {
    return;
  }
  self.battlechatterallowed = state;
}

_id_DA6A5AB17FFC2338(_id_A95A0F321427A749, _id_9B7269852D7BCCFC) {
  if(!isDefined(_id_A95A0F321427A749) || !isstring(_id_A95A0F321427A749) || !isDefined(_id_9B7269852D7BCCFC) || !isarray(_id_9B7269852D7BCCFC) || _id_9B7269852D7BCCFC.size < 2) {
    return;
  }
  foreach(state in _id_9B7269852D7BCCFC) {
    if(!isstring(state))
      return;
  }

  if(!_func_CBAD1443981C51CD(_id_A95A0F321427A749)) {
    return;
  }
  _id_34B4615F928D1A06(_id_A95A0F321427A749, _id_9B7269852D7BCCFC);
}

_id_34B4615F928D1A06(_id_A95A0F321427A749, _id_9B7269852D7BCCFC) {
  if(!isDefined(_id_A95A0F321427A749) || !isstring(_id_A95A0F321427A749) || !isDefined(_id_9B7269852D7BCCFC) || !isarray(_id_9B7269852D7BCCFC) || _id_9B7269852D7BCCFC.size < 2) {
    return;
  }
  foreach(state in _id_9B7269852D7BCCFC) {
    if(!isstring(state))
      return;
  }

  if(!_func_CBAD1443981C51CD(_id_A95A0F321427A749)) {
    return;
  }
  if(!isDefined(level._id_30B0731E36F29268))
    level._id_30B0731E36F29268 = [];

  level._id_30B0731E36F29268[_id_A95A0F321427A749] = _id_9B7269852D7BCCFC;
}

_id_195990D8AFFBA85B(_id_A95A0F321427A749, _id_071947160FFEDB67, _id_7D52B05C966F0D1C) {
  if(!isDefined(_id_A95A0F321427A749) || !isstring(_id_A95A0F321427A749) || !isDefined(_id_071947160FFEDB67) || !isstring(_id_071947160FFEDB67) || !isDefined(_id_7D52B05C966F0D1C) || !isnumber(_id_7D52B05C966F0D1C)) {
    return;
  }
  if(!isDefined(level._id_30B0731E36F29268) || !isDefined(level._id_30B0731E36F29268[_id_A95A0F321427A749]) || !scripts\engine\utility::array_contains(level._id_30B0731E36F29268[_id_A95A0F321427A749], _id_071947160FFEDB67)) {
    return;
  }
  _id_45253047E760F6A6 = _id_76D9F2B9AC5F8307(_id_A95A0F321427A749);

  if(_id_45253047E760F6A6 == _id_071947160FFEDB67) {
    return;
  }
  if(isDefined(level._id_C2C787DB15412CDB) && scripts\engine\utility::array_contains(level._id_C2C787DB15412CDB, _id_A95A0F321427A749)) {
    return;
  }
  if(!isDefined(level._id_C2C787DB15412CDB))
    level._id_C2C787DB15412CDB = [];

  level._id_C2C787DB15412CDB[level._id_C2C787DB15412CDB.size] = _id_A95A0F321427A749;
  scripts\engine\utility::script_func("area_swap_begin", _id_A95A0F321427A749, _id_071947160FFEDB67, _id_7D52B05C966F0D1C);
  _func_4CF525A6EF2C0D20(_id_A95A0F321427A749, _id_071947160FFEDB67);
  wait(_id_7D52B05C966F0D1C);
  _func_ 1 C1E3D250D7D89E(_id_A95A0F321427A749, _id_071947160FFEDB67);
  level._id_C2C787DB15412CDB = scripts\engine\utility::array_remove(level._id_C2C787DB15412CDB, _id_A95A0F321427A749);

  if(level._id_C2C787DB15412CDB.size == 0)
    level._id_C2C787DB15412CDB = undefined;

  level._id_30B0731E36F29268[_id_A95A0F321427A749] = scripts\engine\utility::array_insert(scripts\engine\utility::array_remove(level._id_30B0731E36F29268[_id_A95A0F321427A749], _id_071947160FFEDB67), _id_071947160FFEDB67, 0);
  entities = _func_366BF1E08B0BEC30(_id_A95A0F321427A749, _id_45253047E760F6A6);
  scriptables = _func_C24909A1554F8010(_id_A95A0F321427A749, _id_45253047E760F6A6);

  if(isDefined(level._id_2CBAC3F6932A1512)) {
    ents = [];

    foreach(player in level.players) {
      foreach(trigger in level._id_2CBAC3F6932A1512) {
        if(isDefined(player.vehicle)) {
          if(isDefined(player.vehicle.origin) && ispointinvolume(player.vehicle.origin, trigger)) {
            if(!scripts\engine\utility::array_contains(ents, player.vehicle))
              ents[ents.size] = player.vehicle;
          }
        }

        if(isDefined(player.origin) && ispointinvolume(player.origin, trigger)) {
          if(!scripts\engine\utility::array_contains(ents, player))
            ents[ents.size] = player;
        }
      }
    }

    if(ents.size > 0)
      entities = scripts\engine\utility::array_combine_unique(entities, ents);
  }

  if(isDefined(entities)) {
    foreach(entity in entities)
    entity thread scripts\engine\utility::script_func("delete_entity_in_swap");
  }

  if(isDefined(scriptables)) {
    foreach(scriptable in scriptables)
    scriptable thread scripts\engine\utility::script_func("delete_scriptable_in_swap");
  }

  scripts\engine\utility::script_func("area_swap_complete", _id_A95A0F321427A749, _id_071947160FFEDB67);
  level notify("area_swap_complete", _id_A95A0F321427A749, _id_071947160FFEDB67);
}

_id_76D9F2B9AC5F8307(_id_A95A0F321427A749) {
  if(!isDefined(_id_A95A0F321427A749) || !isstring(_id_A95A0F321427A749)) {
    return;
  }
  if(!isDefined(level._id_30B0731E36F29268) || !isDefined(level._id_30B0731E36F29268[_id_A95A0F321427A749])) {
    return;
  }
  return level._id_30B0731E36F29268[_id_A95A0F321427A749][0];
}

_id_16FDDF294A1DA917(_id_A95A0F321427A749) {
  if(!isDefined(_id_A95A0F321427A749) || !isstring(_id_A95A0F321427A749)) {
    return;
  }
  return isDefined(level._id_C2C787DB15412CDB) && scripts\engine\utility::array_contains(level._id_C2C787DB15412CDB, _id_A95A0F321427A749);
}

_id_42F93A2901D58B66() {
  return isDefined(level._id_C2C787DB15412CDB) && level._id_C2C787DB15412CDB.size > 0;
}

_id_D6B99CCF87941A5A(callback) {
  level._id_EEA8E3772A56914C = scripts\engine\utility::_id_6D6AF8144A5131F1(level._id_EEA8E3772A56914C, callback);
}

_id_9A36CE87B588749F(callback) {
  level._id_EEA8E3772A56914C = scripts\engine\utility::array_remove(level._id_EEA8E3772A56914C, callback);
}

_id_57257D1ED9CE2F48(callback) {
  self._id_0E36446187560069 = callback;
}

_id_0307245F5E6C7A85() {
  self._id_0E36446187560069 = undefined;
}

_id_326CC1213268415A(message, time, _id_3D39B8E45C2AE4D6, _id_3D39B9E45C2AE709, color) {}

_id_BD58CB04DDB828A2(message, time, _id_3D39B8E45C2AE4D6, _id_3D39B9E45C2AE709, color) {}

_id_0E180B0F4BE0C8BE() {}