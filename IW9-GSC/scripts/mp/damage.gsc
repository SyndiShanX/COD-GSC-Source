/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\damage.gsc
***********************************************/

callback_playerdamage_internal(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, _id_B0FC59FF15058522, _id_BE4285B26ED99AB1) {
  if(isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "worldspawn")
    eattacker = undefined;

  if(isDefined(eattacker) && isDefined(eattacker.gunner))
    eattacker = eattacker.gunner;

  if(istrue(victim.plotarmor))
    _id_403E958ECD04F255(victim, "isTrue( victim.plotArmor )");
  else {
    if(scripts\mp\utility\player::isinlaststand(victim) && istrue(level._id_C53947782C7460F6)) {
      _id_403E958ECD04F255(victim, "isInLastStand( victim ) && IsTrue( level.laststand_always_disable_damage )");
      return;
    }

    if(_id_0B0385BB45379222::_id_F79445AE166C7150(eattacker, victim) || _id_46FDF7B12C5F5620::_id_7B08C98431ABDA40(eattacker, victim)) {
      _id_403E958ECD04F255(victim, "isInLastStand( victim ) && IsTrue( level.laststand_always_disable_damage )");
      return;
    }

    if(getdvarint("scr_dmz_pve_enabled", 0) && isPlayer(eattacker) && isPlayer(victim) && eattacker != victim) {
      _id_403E958ECD04F255(victim, "scr_dmz_pve_enabled 1");
      return;
    }

    if(istrue(victim.inlaststand) && istrue(level.laststandrequiresmelee) && smeansofdeath != "MOD_MELEE") {
      _id_403E958ECD04F255(victim, "istrue( victim.inLastStand ) && istrue( level.lastStandRequiresMelee ) && sMeansOfDeath != MOD_MELEE");
      return;
    }

    _id_FCDF19E3CDD29669 = victim.health;

    if(idflags &level.idflags_stun) {
      _id_403E958ECD04F255(victim, "iDFlags &level.iDFLAGS_STUN");
      return;
    }

    _id_FC92D300E26E37A0 = filterdamage(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc);

    if(isDefined(_id_FC92D300E26E37A0)) {
      _id_403E958ECD04F255(victim, "filterDamage true, " + _id_FC92D300E26E37A0);
      return;
    }

    _id_9668AA5A1A60E17B = scripts\mp\utility\damage::attackerishittingteam(victim, eattacker);
    iskillstreakweapon = isDefined(objweapon) && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename);

    if(!istrue(level.allowprematchdamage)) {
      if(istrue(game["inLiveLobby"]) || !scripts\mp\flags::gameflag("prematch_done") || istrue(level.infilcinematicactive)) {
        handledamagefeedback(einflictor, eattacker, victim, 0, smeansofdeath, objweapon, shitloc, idflags, 1, 1, iskillstreakweapon);
        _id_403E958ECD04F255(victim, "!istrue( level.allowPrematchDamage ) in prematch still");
        return;
      }
    }

    if(_id_9668AA5A1A60E17B) {
      idamage = handlefriendlyfiredamage(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, iskillstreakweapon);

      if(idamage == 0) {
        _id_403E958ECD04F255(victim, "handleFriendlyFireDamage damage == 0");
        return;
      }
    }

    if(istrue(_id_556B8AEAA691317F::_id_C61EE6D60763E771()) && istrue(_id_556B8AEAA691317F::_id_76CA0B3D8B2555CA(objweapon)) && scripts\engine\utility::isbulletdamage(smeansofdeath)) {
      idamage = 0;
      _id_403E958ECD04F255(victim, "super_stimPistol_getHostileRevivesEnabled() && super_stimPistol_isStimPistol() && isBulletDamage()");
      return;
    }

    if(istrue(victim.spawnprotection) || victim _meth_F1DCADC8F7C3477C()) {
      _id_D0D4AE57019E885D = smeansofdeath == "MOD_TRIGGER_HURT" || isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "trigger_hurt";
      _id_228C3B335149221A = smeansofdeath == "MOD_FALLING";
      _id_84E1133E7F895003 = smeansofdeath == "MOD_SUICIDE";

      if(!_id_D0D4AE57019E885D && !_id_228C3B335149221A && !_id_84E1133E7F895003) {
        handledamagefeedback(einflictor, eattacker, victim, 0, smeansofdeath, objweapon, shitloc, idflags, 1, 1, iskillstreakweapon);
        _id_403E958ECD04F255(victim, "( istrue( victim.spawnProtection ) || victim IsLastStandInvulnerable() ) && !wasHurtTrigger && !wasFallDamage");
        return;
      }
    }

    if(isDefined(eattacker) && istrue(eattacker.cranked))
      eattacker thread scripts\mp\cranked::oncrankedhit(victim);

    if(isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "script_origin" && isDefined(eattacker.type) && eattacker.type == "soft_landing") {
      _id_403E958ECD04F255(victim, "eAttacker.classname == script_origin && eAttacker.type == soft_landing");
      return;
    }

    if(isDefined(eattacker) && isDefined(victim) && isPlayer(victim))
      eattacker notify("on_damage_to_player", victim);

    _id_D35E82FC5AA0AA84 = 1.0;

    if(isDefined(_id_BE4285B26ED99AB1))
      _id_D35E82FC5AA0AA84 = idamage / _id_BE4285B26ED99AB1;

    idflags = idflags | level.idflags_no_knockback;

    if(_id_2669878CF5A1B6BC::isspreadweapon(objweapon) && scripts\cp_mp\utility\damage_utility::validshotcheck(smeansofdeath, eattacker)) {
      if(scripts\cp_mp\dragonsbreath::isdragonsbreathweapon(objweapon) && (scripts\mp\utility\weapon::getweapongroup(objweapon) == "weapon_shotgun" || _func_F30A6D3194F97C09(objweapon, "specialty_incendiary_alt")))
        victim thread dragonsbreathhitloccollection(shitloc, eattacker, objweapon);

      idamage = spreadshotdamagemod(victim, eattacker, objweapon, idamage, idflags);

      if(idamage == 0) {
        _id_403E958ECD04F255(victim, "isSpreadWeapon() && spreadShotDamageMod() iDamage == 0");
        return;
      }
    }

    _id_5C3F9357F11D2223 = objweapon.basename;

    if(!isDefined(_id_5C3F9357F11D2223)) {}

    equiptype = scripts\mp\utility\weapon::getequipmenttype(objweapon);

    if(isDefined(equiptype)) {
      if(equiptype == "lethal")
        idamage = lethalequipmentdamagemod(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon);
      else if(equiptype == "equipment_other") {} else if(equiptype == "tactical") {}

      damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir, undefined, undefined, partname, undefined, idflags, undefined, shitloc);
      result = scripts\mp\equipment::equiponplayerdamaged(damagedata);

      if(isDefined(result) && result == 0) {
        _id_403E958ECD04F255(victim, "isDefined( getEquipmentType ) && equipOnPlayerDamaged() == false");
        return;
      }
    }

    if(victim scripts\mp\utility\game::ismatchstartprotected()) {
      _id_E0815ED56506A6A3 = isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "minefield_mp";
      _id_4125D811C53D9546 = smeansofdeath == "MOD_SUICIDE";

      if(!_id_E0815ED56506A6A3 && !_id_4125D811C53D9546) {
        _id_54A24336CC9A143D = istrue(objweapon.isalternate);

        if(isDefined(equiptype) && !scripts\mp\utility\weapon::isthrowingknife(_id_5C3F9357F11D2223) || _id_54A24336CC9A143D || smeansofdeath == "MOD_EXPLOSIVE") {
          _id_54A88B0118510E9F = int(max(victim.health / 5, 1));

          if(idamage >= _id_54A88B0118510E9F)
            idamage = _id_54A88B0118510E9F;
        }
      }
    }

    _id_5669668B7085B3AC = scripts\mp\utility\weapon::getweapontype(_id_5C3F9357F11D2223);

    if(isDefined(_id_5669668B7085B3AC) && _id_5669668B7085B3AC == "killstreak") {
      idamage = killstreakdamagefilter(eattacker, victim, idamage, objweapon, smeansofdeath);

      if(idamage == 0) {
        _id_403E958ECD04F255(victim, "getWeaponType() == killstreak && iDamage == 0");
        return;
      }

      if(isDefined(level.gunshipplayer) && isDefined(eattacker) && level.gunshipplayer == eattacker)
        level notify("ai_pain", victim);
    }

    if(smeansofdeath == "MOD_CRUSH" && isDefined(eattacker) && isDefined(eattacker.streakname) && eattacker.streakname == "emp_drone")
      idamage = 0;

    [idamage, _id_1DA1A66B5C6A06A7] = modifydamagegeneral(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, _id_BE4285B26ED99AB1, partname);
    [idamage, _id_1DA1A66B5C6A06A7] = _id_694D74D8B5AC556F(eattacker, idamage, _id_1DA1A66B5C6A06A7, smeansofdeath, objweapon, victim);
    idamage = handleriotshieldhits(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, iskillstreakweapon);

    if(idamage == 0 && _id_1DA1A66B5C6A06A7 == 0) {
      _id_403E958ECD04F255(victim, "iDamage == 0 && lightArmorDamage == 0");
      return;
    }

    if(scripts\cp_mp\dragonsbreath::isdragonsbreathweapon(objweapon) && !_id_2669878CF5A1B6BC::isspreadweapon(objweapon))
      victim thread scripts\cp_mp\dragonsbreath::_id_0C206C109A26F598(idamage + _id_1DA1A66B5C6A06A7, eattacker, objweapon, shitloc);
    else if(scripts\cp_mp\crossbow::_id_FC87AFF67FB01E6F(objweapon))
      victim thread scripts\cp_mp\dragonsbreath::_id_5A05899BB304A6D4(shitloc, scripts\cp_mp\crossbow::_id_42B0DFEB350F6EA5());

    if(!istrue(victim.donotmodifydamage)) {
      _id_619984A4A37B8423 = cac_modified_damage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, einflictor, 0, idflags, iskillstreakweapon, _id_D35E82FC5AA0AA84);
      idamage = _id_619984A4A37B8423[0];
      _id_986B2E0350629522 = _id_619984A4A37B8423[1];
      _id_B2883531AFA6B83D = _id_1DA1A66B5C6A06A7 != 0 || _id_986B2E0350629522 != 0;
      shitloc = _id_619984A4A37B8423[2];
    } else {
      _id_986B2E0350629522 = 0;
      _id_B2883531AFA6B83D = 0;
    }

    if(iskilltradedamage(eattacker, victim, idamage, smeansofdeath, objweapon, _id_B0FC59FF15058522)) {
      _id_403E958ECD04F255(victim, "isKillTradeDamage()");
      return;
    }

    if(isDefined(victim.forcehitlocation)) {
      shitloc = victim.forcehitlocation;
      victim.forcehitlocation = undefined;
    }

    if(isPlayer(eattacker) && (_id_5C3F9357F11D2223 == "smoke_grenade_mp" || scripts\mp\utility\weapon::isthrowingknife(_id_5C3F9357F11D2223)))
      eattacker thread scripts\mp\gamelogic::threadedsetweaponstatbyname(_id_5C3F9357F11D2223, 1, "hits");

    _id_B4C09BD8D141ED77 = vdir;

    if(isDefined(idflags) && idflags &level.idflags_ricochet && idamage < self.health)
      _id_B4C09BD8D141ED77 = victim.origin - eattacker.origin;

    if(isenvironmentalscriptableinflictor(einflictor))
      idamage = 0;

    if(isPlayer(eattacker)) {
      if(_id_07C40FA80892A721::armorvest_washit(eattacker) || helmet_washit(eattacker)) {
        if(idamage < victim.health)
          idflags = idflags | level.idflags_br_armor_hit;
      }

      if(_id_07C40FA80892A721::armorvest_wasbroke(eattacker) || helmet_wasbroke(eattacker)) {
        if(idamage < victim.health)
          idflags = idflags | level.idflags_br_armor_break;
      }
    }

    if(isDefined(level.onplayerdamaged_func)) {
      if(![[level.onplayerdamaged_func]](smeansofdeath)) {
        _id_403E958ECD04F255(victim, "[[level.onPlayerDamaged_func]] == false");
        return;
      }
    }

    if(isDefined(einflictor) && isDefined(objweapon)) {
      if(isDefined(einflictor.equipmentref) && istrue(einflictor.equipmentref == "equip_throwstar"))
        idamage = _id_52D91CB28006A5BD::_id_DB4BBCFE23F19148(einflictor, victim, idamage, partname);

      if(isDefined(einflictor._id_AB13877362519A4F) && istrue(einflictor._id_AB13877362519A4F) && (istrue(einflictor.equipmentref == "equip_throwing_knife") || istrue(einflictor.equipmentref == "equip_shuriken") || istrue(einflictor.equipmentref == "equip_throwstar")))
        idamage = scripts\cp_mp\equipment\throwing_knife::_id_3D8B0933DF7505FD(victim);
    }

    if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker._id_91FF03702332CC07))
      eattacker._id_91FF03702332CC07 = eattacker._id_91FF03702332CC07 + idamage;

    if(isDefined(victim) && isPlayer(victim))
      victim._id_489F22C08F63BC0F = victim._id_489F22C08F63BC0F + idamage;

    preplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, _id_B4C09BD8D141ED77, shitloc, psoffsettime, modelindex, partname, _id_1DA1A66B5C6A06A7);
    victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, _id_B4C09BD8D141ED77, shitloc, psoffsettime, modelindex, partname, _id_B2883531AFA6B83D);
    postplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, _id_B4C09BD8D141ED77, shitloc, psoffsettime, modelindex, partname, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522, _id_FCDF19E3CDD29669, iskillstreakweapon);
  }
}

dragonsbreathhitloccollection(hitloc, eattacker, objweapon) {
  self notify("newDragonsBreathHitLoc");
  self endon("newDragonsBreathHitLoc");
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.dragonsbreathdamage))
    self.dragonsbreathdamage = scripts\cp_mp\dragonsbreath::_id_DF4E9A1E313EA352();

  self.dragonsbreathdamage.newhitlocs = scripts\engine\utility::array_add(self.dragonsbreathdamage.newhitlocs, hitloc);
  waittillframeend;
  newhitlocs = [];

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.dragonsbreathdamage)) {
    newhitlocs = self.dragonsbreathdamage.newhitlocs;
    self.dragonsbreathdamage.newhitlocs = [];
  }

  if(scripts\mp\utility\player::isreallyalive(self))
    scripts\cp_mp\dragonsbreath::_id_6DC8C5DE229E86FF(newhitlocs, eattacker, objweapon);
  else
    scripts\cp_mp\dragonsbreath::_id_56A694363DA738AC();
}

preplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, _id_1DA1A66B5C6A06A7) {
  _id_F2C6D9B76591B40B = idamage;
  victim.lastweaponused = victim getcurrentweapon();
  victim.wasaimingdownsightsondamage = victim scripts\mp\utility\player::isplayerads();

  if(_id_2F5049BBE3C5E733(objweapon, smeansofdeath)) {
    if(getdvarint("dvar_432DF71393030BE5", 0) == 1) {
      if(!isbot(eattacker))
        victim thread _id_49D8CC008E5F6722(eattacker, victim, idflags);
    }

    if(isPlayer(eattacker))
      eattacker setclientomnvar("autofire_hit_notify", gettime());
  }

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    _id_7212E8123765547D = int(clamp(idamage, 0, 100));
    victim setclientomnvar("ui_damage_intensity", _id_7212E8123765547D);
  }

  if(isai(self))
    self[[level.bot_funcs["on_damaged"]]](eattacker, idamage, smeansofdeath, objweapon, einflictor, shitloc, vpoint);

  if(isDefined(einflictor) && isDefined(einflictor.streakinfo) && isDefined(einflictor.streakinfo.hits))
    einflictor.streakinfo.hits++;

  if(isDefined(objweapon) && objweapon.basename == "bunkerbuster_round_mp") {
    if(isDefined(einflictor) && isDefined(victim)) {
      _id_84CA13F5A0250278 = distance(einflictor.origin, victim.origin);
      eattacker dlog_recordplayerevent("dlog_event_mp_bunkerbuster_expl_dist_to_enemy", ["victim", victim, "distance", _id_84CA13F5A0250278], 0);
    }
  }

  scripts\mp\perks\perkfunctions::bulletoutlinecheck(eattacker, victim, objweapon.basename, smeansofdeath);

  if(smeansofdeath == "MOD_FALLING")
    victim thread emitfalldamage(idamage);

  logattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, _id_1DA1A66B5C6A06A7);

  if(isDefined(einflictor) && isDefined(einflictor.owner) && isDefined(einflictor.owner.team) && einflictor.owner.team != victim.team)
    victim.lastdamagewasfromenemy = 1;
  else
    victim.lastdamagewasfromenemy = isDefined(eattacker) && eattacker != victim;

  if(victim.lastdamagewasfromenemy) {
    timestamp = gettime();
    eattacker.damagedplayers[victim.guid] = timestamp;
    eattacker._id_C826AB9D43C24233 = timestamp;
    victim.lastdamagedtime = timestamp;
  }

  victim thread scripts\mp\potg_events::onplayerdamaged(eattacker, victim, smeansofdeath);
  victim thread scripts\cp_mp\challenges::playerdamaged(einflictor, eattacker, idamage, smeansofdeath, objweapon, shitloc);

  if(isDefined(eattacker) && idamage != 0)
    eattacker notify("victim_damaged", victim, einflictor, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime);

  if(isDefined(level.preplayerdamaged))
    victim thread[[level.preplayerdamaged]](einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
}

_id_2F5049BBE3C5E733(objweapon, meansofdeath) {
  _id_F2C2804490DD2160 = isDefined(objweapon) && (weapontype(objweapon) == "bullet" || weapontype(objweapon) == "projectile") || objweapon.basename == "throwingknife_mp";
  return scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && (_id_F2C2804490DD2160 || meansofdeath == "MOD_MELEE");
}

postplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522, _id_FCDF19E3CDD29669, iskillstreakweapon) {
  _id_F2C6D9B76591B40B = idamage;
  _id_34459EB0EF220C40 = scripts\engine\utility::isbulletdamage(smeansofdeath);

  if(getdvarint("dvar_FB388F508F5527E3", 0) == 1 && isDefined(eattacker) && isDefined(eattacker.origin))
    victim _meth_95874C67F460495F(eattacker.origin);

  if(istrue(victim._id_808D06DDFC93A4E4))
    victim _id_19FD5B5D73D44C18::_id_903A8ABDE1F77240();

  if(istrue(victim.disguised) && isDefined(eattacker))
    victim _id_67015C88C47EC4F8::_id_15E7A42C79A6B4F6(idamage, eattacker);

  if(idamage > 10 && isDefined(einflictor) && !victim scripts\mp\utility\player::isusingremote() && isPlayer(victim)) {
    if(isPlayer(einflictor) && smeansofdeath == "MOD_MELEE") {
      if(isalive(victim) && !victim scripts\mp\utility\killstreak::isjuggernaut() && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        victim thread meleestagger(eattacker);
        victim.hitwithmeleetime = gettime();
      }

      einflictor thread scripts\mp\shellshock::bloodmeleeeffect(objweapon);
      victim playRumbleOnEntity("defaultweapon_melee");
      einflictor playRumbleOnEntity("defaultweapon_melee");
    }
  }

  if(isagent(self)) {
    if(scripts\mp\utility\killstreak::isplayerkillstreak(self)) {
      if(idamage >= self.health)
        idamage = self.health - 1;
      else {
        _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);
        self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](einflictor, eattacker, idamage, idflags, smeansofdeath, _id_366B0ECC2F28AEAD, vpoint, vdir, shitloc, psoffsettime);
      }
    } else {
      _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);
      self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](einflictor, eattacker, idamage, idflags, smeansofdeath, _id_366B0ECC2F28AEAD, vpoint, vdir, shitloc, psoffsettime);
    }
  } else
    scripts\cp_mp\challenges::_id_4AB6F9FBA6BB9CC5(self, idamage, _id_1DA1A66B5C6A06A7);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && isPlayer(eattacker))
    scripts\cp_mp\challenges::_id_F4D8C689AAF296E5(eattacker, objweapon, idamage, _id_1DA1A66B5C6A06A7);

  handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522, iskillstreakweapon, partname);
  _id_18525950B3CABA30(idamage, eattacker, smeansofdeath, vpoint, _id_1DA1A66B5C6A06A7, objweapon);

  if(_id_34459EB0EF220C40)
    victim thread scripts\mp\battlechatter_mp::adddamagetaken(eattacker, objweapon, idamage);

  if(isagent(eattacker) && isDefined(eattacker) && eattacker scripts\cp_mp\utility\player_utility::_isalive() && eattacker != victim)
    victim thread scripts\mp\battlechatter_mp::addrecentattacker(eattacker);

  if(isDefined(victim) && victim scripts\cp_mp\utility\player_utility::_isalive()) {
    if(victim.health < 30)
      victim thread scripts\mp\battlechatter_mp::hurtbadlywait();

    if(isDefined(eattacker) && eattacker != victim && isexplosivedamagemod(smeansofdeath)) {
      _id_A5269902CD18CA05 = isDefined(objweapon) && objweapon.basename == "safe_c4_mp";
      _id_46A8BB92AA6C8D0E = isDefined(objweapon) && objweapon.basename == "gas_mp";

      if(!isDefined(objweapon) || !_id_46A8BB92AA6C8D0E && !_id_A5269902CD18CA05)
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(victim, "stat_CAFA7AD7442C35D5", undefined, 0.5);
    }
  }

  scripts\mp\gamelogic::sethasdonecombat(victim, 1);

  if(isDefined(eattacker) && eattacker != victim)
    level.usestartspawns = 0;

  if(isPlayer(eattacker) && isDefined(eattacker.pers["participation"]))
    eattacker.pers["participation"]++;
  else if(isPlayer(eattacker))
    eattacker.pers["participation"] = 1;

  if(isDefined(level.cinematic_replay_recording) && isPlayer(einflictor)) {
    _id_04169C6A89B43F49 = spawnStruct();
    _id_04169C6A89B43F49.victim = victim;
    _id_04169C6A89B43F49.vpoint = vpoint;
    _id_04169C6A89B43F49.vdir = vdir;
    _id_04169C6A89B43F49.objweapon = objweapon;
    _id_04169C6A89B43F49.kill = !isalive(victim);
    einflictor.hitrecord[einflictor.hitrecord.size] = _id_04169C6A89B43F49;
  }

  if(isDefined(level.matchrecording_logeventmsg) && isPlayer(victim) && isDefined(einflictor) && isPlayer(einflictor) && _id_34459EB0EF220C40) {
    if(_id_FCDF19E3CDD29669 == victim.maxhealth && victim.health != self.maxhealth)
      victim.engagementstarttime = gettime();
  }

  if(allowdamageflash(eattacker, victim, objweapon, smeansofdeath, idamage))
    victim showuidamageflash();

  if(isDefined(eattacker) && idamage > 0) {
    if(eattacker scripts\mp\utility\perk::_hasperk("specialty_delayhealing"))
      eattacker thread scripts\mp\perks\perk_mark_targets::marktarget_run(victim, objweapon, smeansofdeath);

    if(_id_34459EB0EF220C40 && _id_1F2E4FF84140D164(objweapon, eattacker) && scripts\cp_mp\utility\damage_utility::islowerbodyshot(shitloc, smeansofdeath, eattacker) || objweapon.basename == "throwstar_mp")
      eattacker thread scripts\mp\perks\perkfunctions::ammodisabling_run(victim, objweapon.basename == "throwstar_mp");

    if(isPlayer(victim)) {
      if(_id_556B8AEAA691317F::_id_76CA0B3D8B2555CA(objweapon) && scripts\engine\utility::isbulletdamage(smeansofdeath) || eattacker scripts\mp\utility\perk::_hasperk("specialty_shrapnel") && isshrapnelsource(objweapon, smeansofdeath))
        victim.lastshrapneltime = gettime();
    }
  }

  if(isDefined(level.onplayerdamaged))
    victim thread[[level.onplayerdamaged]](einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

  _id_6CB0280F7AA7D3CD::_id_D1E4826B0A4DB6EE(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
  level notify("post_player_damaged", einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

  if(scripts\mp\utility\player::isreallyalive(victim)) {
    switch (smeansofdeath) {
      case "MOD_PROJECTILE":
      case "MOD_GRENADE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_EXPLOSIVE":
        victim scripts\mp\utility\stats::incpersstat("explosionsSurvived", 1);

        if(getdvarint("scr_live_ragdoll_on_explosives", 0) == 1) {
          if(isDefined(einflictor)) {
            _id_ACD8FAA0E7DDE1B2 = _id_347074F909E9DEA5(einflictor, objweapon);

            if(_id_ACD8FAA0E7DDE1B2[0] == 1)
              victim thread _id_BF56DBD2A1035901(_id_ACD8FAA0E7DDE1B2.size);
          }
        }

        break;
    }
  } else {
    if(isDefined(victim) && isDefined(einflictor) && _id_6E2BB9330396AFCB::_id_EAE0802093A7E5F5(einflictor)) {
      if(isDefined(einflictor._id_A5D118F040F60DB0))
        victim _meth_B3BBB3A877D45DF6(einflictor._id_A5D118F040F60DB0);
    }

    if(isDefined(idflags) && idflags &level.idflags_penetration && !(idflags &level.idflags_penetration_player_only)) {
      if(eattacker scripts\mp\utility\game::onlinestatsenabled()) {
        _id_ACCBD4DF9BCC6BBC = eattacker scripts\mp\playerstats_interface::getplayerstat("combatStats", "wallbangs") + 1;
        eattacker scripts\mp\playerstats_interface::setplayerstatbuffered(_id_ACCBD4DF9BCC6BBC, "combatStats", "wallbangs");
      }

      eattacker scripts\mp\utility\stats::incpersstat("penetrationKills", 1);
    }
  }

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagTrackPlayerBulletHitPlayer"))
    _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagTrackPlayerBulletHitPlayer", eattacker);
}

_id_1F2E4FF84140D164(objweapon, eattacker) {
  if(objweapon hasattachment("ammomod_slow") || eattacker scripts\mp\utility\perk::_hasperk("specialty_wounding"))
    return 1;

  return 0;
}

_id_347074F909E9DEA5(einflictor, objweapon) {
  if(isDefined(einflictor.equipmentref)) {
    _id_9B83EFBA8BFECC3F = scripts\mp\equipment::getequipmenttableinfo(einflictor.equipmentref);

    if(isDefined(_id_9B83EFBA8BFECC3F) && _id_9B83EFBA8BFECC3F.defaultslot == "primary")
      return [1];
  }

  if(isDefined(objweapon)) {
    if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon))
      return [1, 1];

    switch (objweapon.basename) {
      case "iw8_la_kgolf_mp":
      case "iw8_la_rpapa7_mp":
      case "iw9_la_juliet_mp":
      case "iw9_la_gromeo_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_gromeoks_mp":
        return [1];
    }
  }

  return [0];
}

_id_BF56DBD2A1035901(_id_EA3F6E5C800C0E9C, _id_AF9644F18EB1D154, velocity) {
  self endon("death_or_disconnect");

  if(!istrue(self._id_9E3BDDA27A519A9F))
    self setcamerathirdperson(1);

  if(istrue(_id_AF9644F18EB1D154)) {
    self _meth_BABD8AF3054D8ABE("torso_upper", velocity);
    wait 3;
  } else {
    self _meth_360874D9808F0724();
    wait(scripts\engine\utility::ter_op(_id_EA3F6E5C800C0E9C == 2, 5, 3));
  }

  scripts\mp\class::_id_C5CE8711741E44B8();
  self _meth_D87E1768229D0E3E();
}

meleestagger_anglesviewattack(victim, attacker) {
  vdir = anglesToForward((0, victim getplayerangles()[1], 0));
  _id_6F2237E4477CA77D = vectorNormalize((attacker.origin[0], attacker.origin[1], 0) - (victim.origin[0], victim.origin[1], 0));
  return scripts\engine\math::anglebetweenvectorssigned(vdir, _id_6F2237E4477CA77D, (0, 0, 1));
}

isshrapnelsource(objweapon, meansofdeath) {
  if(!isDefined(objweapon) || isnullweapon(objweapon))
    return 0;

  if(!isexplosivedamagemod(meansofdeath))
    return 0;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon))
    return 0;

  if(scripts\mp\utility\weapon::isvehicleweapon(objweapon))
    return 0;

  if(scripts\mp\utility\weapon::isgamemodeweapon(objweapon))
    return 0;

  _id_11D2F075E9A0E643 = scripts\mp\utility\weapon::getequipmenttype(objweapon);

  if(isDefined(_id_11D2F075E9A0E643)) {
    if(_id_11D2F075E9A0E643 != "lethal")
      return 0;
  }

  return 1;
}

meleestagger(attacker) {
  self endon("death_or_disconnect");
  _id_989EA0994C0BAFE0 = getdvarfloat("melee_stagger_shock_duration");
  _id_C0D3D09FB36A355E = getdvarfloat("melee_stagger_aftershock_duration");
  _id_E501FDB86740B153 = self getviewkickscale();

  if(isDefined(level.gamemodeoverridemeleeviewkickscale))
    self setviewkickscale(scripts\engine\utility::ter_op(attacker scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), level.gamemodeoverridemeleeviewkickscale * 2, level.gamemodeoverridemeleeviewkickscale));
  else
    self setviewkickscale(scripts\engine\utility::ter_op(attacker scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), 3, 1.5));

  duration = scripts\engine\utility::ter_op(attacker scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), _id_989EA0994C0BAFE0 * 1.5, _id_989EA0994C0BAFE0);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("melee_mp", "damage", duration, 0, 0);
  yaw = 0;

  if(isDefined(attacker) && attacker scripts\cp_mp\utility\player_utility::_isalive()) {
    angle = meleestagger_anglesviewattack(self, attacker);

    if(angle < 15)
      yaw = 10;
    else if(angle > -15)
      yaw = -10;
  }

  _id_1A1348BE52624ED9 = scripts\engine\utility::ter_op(attacker scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), 1.15, 1.0);
  self setplayerangles(self getplayerangles() + (-14 * _id_1A1348BE52624ED9, yaw, 0));
  thread meleedofroutine(attacker);
  self earthquakeforplayer(0.35, 0.2, self.origin, 400);
  self playrumbleonpositionforclient("plr_rumble_4_mp", self.origin);
  self setclientomnvar("ui_hud_shake", 1);
  wait 0.05;
  self setviewkickscale(_id_E501FDB86740B153);
  duration = scripts\engine\utility::ter_op(attacker scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), _id_C0D3D09FB36A355E * 1.5, _id_C0D3D09FB36A355E);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("melee_mp_after", "damage", duration, 0, 0);
}

meleedofroutine(attacker) {
  self notify("resetMeleeDOF");
  self endon("resetMeleeDOF");
  self endon("death_or_disconnect");
  _id_E0AF59BA48C8CB09 = 1;
  _id_FF6B46DA0D04E078 = 2;
  _id_2FE3DC2F1289D072 = 350;
  _id_7A6976D1E774FE57 = 1024;
  self setdepthoffield(_id_E0AF59BA48C8CB09, _id_FF6B46DA0D04E078, _id_2FE3DC2F1289D072, _id_7A6976D1E774FE57, 10, 9);
  _id_989EA0994C0BAFE0 = getdvarfloat("melee_stagger_shock_duration");
  wait(scripts\engine\utility::ter_op(attacker scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), _id_989EA0994C0BAFE0 * 3, _id_989EA0994C0BAFE0));

  while(_id_7A6976D1E774FE57 > 350) {
    _id_E0AF59BA48C8CB09 = clamp(_id_E0AF59BA48C8CB09 - 100, 0, 10000);
    _id_FF6B46DA0D04E078 = clamp(_id_FF6B46DA0D04E078 - 100, 0, 10000);
    _id_2FE3DC2F1289D072 = clamp(_id_2FE3DC2F1289D072 - 100, 0, 10000);
    _id_7A6976D1E774FE57 = clamp(_id_7A6976D1E774FE57 - 100, 0, 10000);
    self setdepthoffield(_id_E0AF59BA48C8CB09, _id_FF6B46DA0D04E078, _id_2FE3DC2F1289D072, _id_7A6976D1E774FE57, 10, 9);
    wait 0.05;
  }

  scripts\mp\utility\player::setdof_default();
}

monitormeleeoverlay(overlay) {
  scripts\engine\utility::waittill_any_timeout_1(2.0, "death_or_disconnect");
  overlay destroy();
}

allowdamageflash(attacker, victim, objweapon, meansofdeath, damage) {
  if(isagent(victim))
    return 0;

  if(damage == 0)
    return 0;

  if(suppressdamageflash(attacker, victim, objweapon, meansofdeath, damage))
    return 0;

  return 1;
}

suppressdamageflash(attacker, victim, objweapon, meansofdeath, damage) {
  if(isDefined(objweapon)) {
    switch (objweapon.basename) {
      default:
    }
  }

  return 0;
}

weaponignoresbrarmor(attacker, victim, damage, objweapon, smeansofdeath, inflictor, shitloc) {
  _id_5C3F9357F11D2223 = objweapon.basename;

  if(isDefined(_id_5C3F9357F11D2223) && _id_5C3F9357F11D2223 == "danger_circle_br")
    return 1;

  if(smeansofdeath == "MOD_EXECUTION")
    return 1;

  if(smeansofdeath == "MOD_FALLING")
    return 1;

  return 0;
}

_id_7B2F2A8A9AA41D44(_id_5C3F9357F11D2223) {
  return isDefined(_id_5C3F9357F11D2223) && _id_5C3F9357F11D2223 == "danger_circle_br";
}

cac_modified_damage(victim, attacker, damage, smeansofdeath, objweapon, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887, idflags, iskillstreakweapon, _id_D35E82FC5AA0AA84) {
  victim notify("damage_begin", attacker);

  if(!isDefined(_id_D35E82FC5AA0AA84))
    _id_D35E82FC5AA0AA84 = 1.0;

  _id_6CAC94B6632AA667 = 0;
  _id_986B2E0350629522 = 0;
  _id_7820F81EE1ADF7B9 = victim _id_07C40FA80892A721::hasarmor();
  _id_C258168E026ADB0F = victim _id_07C40FA80892A721::hashelmet();

  if(isPlayer(attacker)) {
    helmet_clearhit(attacker);
    helmet_clearbroke(attacker);
  }

  if(scripts\engine\utility::isbulletdamage(smeansofdeath)) {
    _id_5C3F9357F11D2223 = objweapon.basename;
    headshot = scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker);
    _id_26DF8FB7AD0299C0 = scripts\cp_mp\utility\damage_utility::istorsoshot(shitloc, smeansofdeath, attacker);

    if(isDefined(objweapon) && scripts\mp\utility\weapon::iscacprimaryorsecondary(_id_5C3F9357F11D2223)) {
      if(isbehindmeleevictim(attacker, victim) && isPlayer(victim))
        level thread scripts\mp\battlechatter_mp::saytoself(victim, "plr_hit_back", undefined, 0.1);
    }

    if(isDefined(idflags) && idflags &level.idflags_ricochet) {
      if(_id_5C3F9357F11D2223 != "none" && !scripts\mp\utility\weapon::issuperweapon(_id_5C3F9357F11D2223))
        damage = damage * 0.4;
    }

    if(isPlayer(attacker) && attacker scripts\mp\utility\perk::_hasperk("specialty_paint_pro") && !istrue(iskillstreakweapon))
      victim thread scripts\mp\perks\perkfunctions::setpainted(attacker);

    if(_id_2669878CF5A1B6BC::isminigunweapon(_id_5C3F9357F11D2223) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      damage = damage * _id_29C32B7117E01180::getminigundamagescale();

    hitarmorvest = _id_26DF8FB7AD0299C0 && victim scripts\mp\utility\perk::_hasperk("specialty_armorvest");
    _id_946CDAF05DB4ECA7 = headshot && _id_C258168E026ADB0F;
    hithelmet = headshot && istrue(victim.hasheadgear);
    _id_287AB4D602B23A2A = istrue(attacker.lastcrossbowhadstoppingpower) && _id_2669878CF5A1B6BC::getweaponrootname(objweapon) == "iw9_dm_crossbow";
    _id_2B1F3DA5885AE9EB = attacker scripts\mp\utility\perk::_hasperk("specialty_bulletdamage") || _id_287AB4D602B23A2A;
    _id_F059834C09FF45A7 = scripts\mp\utility\damage::isfmjdamage(objweapon, smeansofdeath);

    if(_id_946CDAF05DB4ECA7 && !istrue(victim.inlaststand)) {
      _id_AE95568A563D5912 = weaponclass(objweapon);
      _id_AC4A1F6F548136EA = 0;

      if(_id_AE95568A563D5912 == "sniper" || _id_AE95568A563D5912 == "dmr")
        _id_AC4A1F6F548136EA = 1;

      _id_F74A43B699B0AFD2 = victim _id_07C40FA80892A721::damagehelmet(damage, _id_AC4A1F6F548136EA, _id_483B72BBC1109AB2);
      damage = damage * _id_F74A43B699B0AFD2;
    }

    if(_id_2B1F3DA5885AE9EB && hitarmorvest)
      _id_07C40FA80892A721::armorvest_sethit(attacker);
    else if(_id_2B1F3DA5885AE9EB && damage > 0) {
      if(damage <= 0) {} else {
        _id_CF48C2B5F099E09A = applystoppingpower(objweapon, shitloc, smeansofdeath, attacker, damage, 100);
        _id_6CAC94B6632AA667 = _id_6CAC94B6632AA667 + (_id_CF48C2B5F099E09A - damage);
      }
    } else if(hitarmorvest && !istrue(victim.tookvesthit) && !_id_F059834C09FF45A7) {
      victim.tookvesthit = 1;
      _id_CF48C2B5F099E09A = adjustbulletstokill(damage, 100, level.armorvestbulletdelta);
      _id_6CAC94B6632AA667 = _id_6CAC94B6632AA667 + (_id_CF48C2B5F099E09A - damage);
      helmet_sethit(attacker);
    } else if(hithelmet && !_id_F059834C09FF45A7) {
      damagemod = scripts\mp\perks\headgear::getdamagemod();
      maxdamage = scripts\mp\perks\headgear::getmaxdamage();
      damagehelmet = int(clamp(damage * damagemod, 1, maxdamage));

      if(victim.health > 1)
        damagehelmet = int(min(victim.health - 1, damagehelmet));

      _id_A97D0CA28DA74569 = damage - damagehelmet;
      _id_6CAC94B6632AA667 = _id_6CAC94B6632AA667 - _id_A97D0CA28DA74569;
      victim notify("headgear_save");
      helmet_sethit(attacker);
    }

    if(isDefined(attacker) && isDefined(attacker.vehicleparent) && attacker.vehicleparent == "loot_chopper")
      damage = int(damage / 3);

    if(istrue(victim._id_E0672FBE459F5193)) {
      if(damage >= victim.health)
        victim.health = int(clamp(damage + 1, 1, victim.maxhealth));
    }

    if(attacker scripts\mp\utility\perk::_hasperk("specialty_headhunter") && headshot) {
      if(_id_D35E82FC5AA0AA84 <= 1)
        damage = damage + 10;
      else {
        _id_40F0A1F57008AF0C = distance(attacker.origin, victim.origin);

        if(_id_40F0A1F57008AF0C < level._id_A7B25D0A3D5B8F1E)
          damage = damage + 20 * _id_D35E82FC5AA0AA84;
        else if(_id_40F0A1F57008AF0C < level._id_A7B25D0A3D5B8F1E)
          damage = damage + 15 * _id_D35E82FC5AA0AA84;
        else
          damage = damage + 10 * _id_D35E82FC5AA0AA84;
      }
    }
  }

  _id_D089499E6152EF2C = scripts\mp\equipment\trophy_system::trophy_modifieddamage(attacker, victim, objweapon.basename, damage, _id_6CAC94B6632AA667);
  damage = _id_D089499E6152EF2C[0];
  _id_6CAC94B6632AA667 = _id_D089499E6152EF2C[1];

  if(victim scripts\mp\heavyarmor::hasheavyarmor()) {
    _id_D089499E6152EF2C = scripts\mp\heavyarmor::heavyarmormodifydamage(victim, attacker, damage, _id_6CAC94B6632AA667, smeansofdeath, objweapon.basename, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887);
    _id_986B2E0350629522 = _id_D089499E6152EF2C[0] > 0;
    damage = _id_D089499E6152EF2C[1];
    _id_6CAC94B6632AA667 = _id_D089499E6152EF2C[2];
  }

  if(scripts\mp\lightarmor::haslightarmor(victim)) {
    _id_D089499E6152EF2C = scripts\mp\lightarmor::lightarmor_modifydamage(victim, attacker, damage, _id_6CAC94B6632AA667, smeansofdeath, objweapon.basename, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887);
    _id_1DA1A66B5C6A06A7 = _id_D089499E6152EF2C[0] > 0;
    damage = _id_D089499E6152EF2C[1];
    _id_6CAC94B6632AA667 = _id_D089499E6152EF2C[2];
  }

  if(isPlayer(attacker)) {
    _id_1BD99D39B987C15E = victim _id_07C40FA80892A721::hasarmor();
    _id_3CFC0E54103A3F72 = victim _id_07C40FA80892A721::hashelmet();

    if(_id_7820F81EE1ADF7B9 && !_id_1BD99D39B987C15E)
      _id_07C40FA80892A721::armorvest_setbroke(attacker);

    if(_id_C258168E026ADB0F && !_id_3CFC0E54103A3F72)
      helmet_setbroke(attacker);
  }

  if(scripts\mp\utility\damage::hashealthshield(victim))
    damage = victim scripts\mp\utility\damage::gethealthshielddamage(damage);

  _id_7A63E4284C138381 = smeansofdeath == "MOD_FALLING" && damage >= victim.maxhealth;
  _id_FF20188C5460F129 = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);
  _id_EDF5C78DC8518F2D = getdvarfloat("dvar_A3A7191F4314591F", 0);

  if(istrue(victim.inlaststand) && _id_EDF5C78DC8518F2D > 0 && !_id_7A63E4284C138381) {
    if(_id_FF20188C5460F129 && (objweapon.basename == "semtex_mp" || objweapon.basename == "bunkerbuster_not_burrowed_mp")) {} else
      damage = int(ceil(damage / _id_EDF5C78DC8518F2D));
  }

  if(damage <= 1)
    damage = int(ceil(clamp(damage, 0, 1)));
  else
    damage = int(damage + _id_6CAC94B6632AA667);

  if(victim scripts\mp\utility\killstreak::isjuggernaut())
    damage = modify_juggernaut_damage(victim, attacker, damage, smeansofdeath, objweapon, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887, idflags, iskillstreakweapon);

  return [damage, _id_986B2E0350629522, shitloc];
}

modify_blast_shield_damage(damage, attacker, victim, _id_463424D8C7B063D4) {
  if(isDefined(_id_463424D8C7B063D4)) {
    _id_2D0E5379AB68DA90 = int(min(victim._id_81C247612E9C90C3, _id_463424D8C7B063D4 * damage));
    victim._id_81C247612E9C90C3 = victim._id_81C247612E9C90C3 - _id_2D0E5379AB68DA90;
    victim notify("blast_shield_damaged", victim._id_81C247612E9C90C3);

    if(victim._id_81C247612E9C90C3 <= 0)
      victim scripts\mp\perks\perkfunctions::_id_2E7374F107A12700();

    return damage - _id_2D0E5379AB68DA90;
  }

  _id_24096F38C6718C4C = level.blastshieldmod;
  _id_1422FD8555AB8BF0 = level.blastshieldclamp;
  _id_46381C94B0138DC7 = int(damage * _id_24096F38C6718C4C);

  if(attacker != victim)
    _id_46381C94B0138DC7 = clamp(_id_46381C94B0138DC7, 0, _id_1422FD8555AB8BF0);

  return _id_46381C94B0138DC7;
}

modify_juggernaut_damage(victim, attacker, damage, smeansofdeath, objweapon, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887, idflags, iskillstreakweapon) {
  _id_AE95568A563D5912 = weaponclass(objweapon);
  _id_5528888BDD4C85D6 = 1;

  if(isDefined(attacker) && attacker scripts\mp\utility\killstreak::isjuggernaut() && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_5528888BDD4C85D6 = _id_29C32B7117E01180::getjuggdamagescale();
  else if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
    _id_5528888BDD4C85D6 = 1.25;

  if(scripts\engine\utility::isbulletdamage(smeansofdeath)) {
    _id_B4A7D8CD8C4FB7DA = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

    switch (_id_AE95568A563D5912) {
      case "pistol":
      case "smg":
        damage = min(15, damage);
        break;
      case "mg":
      case "rifle":
        if(_id_2669878CF5A1B6BC::isminigunweapon(objweapon.basename))
          damage = min(50, damage);
        else
          damage = min(20, damage);

        break;
      case "spread":
        damage = min(25, damage);
        break;
      case "sniper":
        break;
      case "grenade":
        if(_id_B4A7D8CD8C4FB7DA)
          damage = int(self.maxhealth * 0.05);

        break;
      default:
        damage = min(15, damage);
        break;
    }

    damage = handleapdamage(objweapon, smeansofdeath, damage, attacker);
  } else if(isexplosivedamagemod(smeansofdeath)) {
    damage = _id_10268164AB1BCC31(damage, objweapon, attacker);
    weaponref = objweapon.basename;
    _id_B4A7D8CD8C4FB7DA = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

    switch (weaponref) {
      case "artillery_mp":
        damage = damage * 0.25;
        break;
      case "auto_drone_proj_mp":
        damage = damage * 1.5;
        break;
      case "semtex_mp":
        if(istrue(_id_B4A7D8CD8C4FB7DA))
          damage = int(self.maxhealth * 0.1);

        break;
      case "molotov_mp":
        if(istrue(_id_B4A7D8CD8C4FB7DA))
          damage = int(self.maxhealth * 0.011);

        break;
    }
  } else if(scripts\engine\utility::_id_55E3DE6210F3EAC0(smeansofdeath)) {
    weaponref = objweapon.basename;
    _id_B4A7D8CD8C4FB7DA = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

    switch (weaponref) {
      case "thermite_av_mp":
      case "thermite_ap_mp":
        if(istrue(_id_B4A7D8CD8C4FB7DA))
          damage = int(self.maxhealth * 0.023);

        break;
    }

    damage = _id_5E4AA8D548CC604E(damage, objweapon, attacker, smeansofdeath);
  } else if(scripts\engine\utility::_id_F1D312F6935BC2D2(smeansofdeath)) {
    switch (_id_AE95568A563D5912) {
      case "grenade":
        damage = min(10, damage);
        break;
      case "throwingknife":
        damage = min(100, damage);
        break;
    }
  } else if(scripts\engine\utility::_id_F86569FC5D5DC60F(inflictor, smeansofdeath)) {
    if(!isDefined(victim._id_59651A2893429638))
      victim._id_59651A2893429638 = 0;

    damage = min(50, damage);
    victim._id_59651A2893429638++;

    if(victim._id_59651A2893429638 >= 30) {
      [_id_6C53D859D582A421, _id_1B5EBB5A562AC4AC] = scripts\cp_mp\vehicles\vehicle_occupancy::_id_9D86FD9A89CD2702(victim, inflictor, victim.origin, 1);

      if(isDefined(_id_6C53D859D582A421)) {
        victim setOrigin(_id_6C53D859D582A421);
        victim._id_59651A2893429638 = undefined;
      }
    }
  }

  damage = int(damage * _id_5528888BDD4C85D6);

  if(isDefined(self._id_0A23031C04DF01BF))
    victim[[self._id_0A23031C04DF01BF]](damage, shitloc, smeansofdeath, attacker);

  return damage;
}

modifydestructibledamage(damage, inflictor, objweapon) {
  if(!isDefined(inflictor))
    return damage;

  if(!isnullweapon(objweapon))
    return damage;

  if(!isDefined(inflictor.code_classname) || inflictor.code_classname != "scriptable")
    return damage;

  classname = inflictor.classname;

  if(isDefined(classname) && isstartstr(classname, "scriptable_")) {
    classname = getsubstr(classname, 11, classname.size);
    _id_F9DE49798947A6A9 = ["uk_gas_tank_thin_cylinder", "uk_misc_fuel_jug", "uk_fire_extinguisher", "uk_misc_fuel_jug", "decor_barrels_gameplay_flammable", "un_propane_gas_tank", "machinery_oxygen_generator_tank", "sol_barrel", "box_wooden_grenade", "container_gas_tank", "decor_propane_tank", "equipment_propane_burner_stove", "equipment_propane_tank", "misc_propane_rocket", "oil_drum", "rp_propane_tank", "misc_exterior_oxygen_barrel"];

    foreach(_id_0AE9CFB330E2CD21 in _id_F9DE49798947A6A9) {
      if(isstartstr(classname, _id_0AE9CFB330E2CD21)) {
        if(scripts\mp\utility\game::isanymlgmatch())
          return 0;
        else
          return int(min(damage, 60));
      }
    }
  }

  return damage;
}

iskilltradedamage(eattacker, victim, idamage, smeansofdeath, objweapon, _id_B0FC59FF15058522) {
  if(isDefined(eattacker) && isPlayer(eattacker) && (!isalive(eattacker) || scripts\mp\utility\player::isinlaststand(eattacker))) {
    if(istrue(_id_B0FC59FF15058522) && _id_2669878CF5A1B6BC::isspreadweapon(objweapon))
      return 1;
    else if(idamage >= victim.health) {
      if(smeansofdeath == "MOD_MELEE")
        return 1;
      else if(istrue(_id_B0FC59FF15058522))
        return 1;
    }
  }

  return 0;
}

_id_2BE5B08ED39D6A54(eattacker, victim, objweapon) {
  if(objweapon.basename == "semtex_bolt_splash_mp" && isDefined(victim._id_EA445BB2097EAA16) && isDefined(eattacker) && scripts\engine\utility::array_contains(victim._id_EA445BB2097EAA16, eattacker))
    return 1;

  return 0;
}

issmallsplashdamage(objweapon) {
  if(objweapon.basename == "semtex_xmike109_splash_mp" || objweapon.basename == "thermite_xmike109_radius_mp" || objweapon.basename == "semtex_bolt_splash_mp" || objweapon.basename == "thermite_bolt_radius_mp")
    return 1;
  else
    return 0;
}

spreadshotdamagemod(victim, eattacker, objweapon, idamage, idflags) {
  if(isDefined(eattacker) && isDefined(victim)) {
    _id_A9F996CAF54DD68C = scripts\cp_mp\utility\weapon_utility::_id_88E9E2299BD29FD1(idflags);
    _id_BDA9C6703DCFCC16 = scripts\cp_mp\utility\weapon_utility::_id_D77E6B2580F74622(victim);
    time = gettime();

    if(!isDefined(eattacker.pelletweaponvictimids))
      eattacker.pelletweaponvictimids = [];

    foreach(_id_AD11AA18430D8799, _id_25762EF6BB7CED23 in eattacker.pelletweaponvictimids) {
      foreach(_id_48B7B944A7A02B2C, _id_3A99D1CAFE4A4BAC in _id_25762EF6BB7CED23) {
        if((time - _id_3A99D1CAFE4A4BAC.time) / 1000 > 0.1) {
          eattacker.pelletweaponvictimids[_id_AD11AA18430D8799] = scripts\engine\utility::array_remove_key(eattacker.pelletweaponvictimids[_id_AD11AA18430D8799], _id_48B7B944A7A02B2C);

          if(eattacker.pelletweaponvictimids[_id_AD11AA18430D8799].size == 0)
            eattacker.pelletweaponvictimids = scripts\engine\utility::array_remove_key(eattacker.pelletweaponvictimids, _id_AD11AA18430D8799);
        }
      }
    }

    if(!isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C]))
      eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C] = [];

    if(!isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]))
      eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16] = _id_C415D83582AAD1E4(eattacker, objweapon, time);

    eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_7981F7D372990A2B = 0;
    eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed = scripts\engine\utility::array_sort_with_func(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed, ::is_lower);

    if(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed.size >= eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_33AC4C9665BE6910) {
      if(idamage > eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed[0]) {
        _id_85D9D85F3AD5012A = idamage - eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed[0];
        eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed[0] = idamage;
        eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_7981F7D372990A2B = 1;
        idamage = _id_85D9D85F3AD5012A;
      } else
        return 0;
    } else
      eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed = scripts\engine\utility::array_insert(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed, idamage, 0);

    idamage = scripts\cp_mp\utility\weapon_utility::_id_1113FC99A0327D7D(eattacker, victim, idflags, idamage);
  }

  return idamage;
}

_id_C415D83582AAD1E4(eattacker, objweapon, time) {
  struct = spawnStruct();
  struct.time = time;
  struct.pelletdmgpassed = [];
  struct._id_9BB59738D095536E = 0;
  struct._id_33AC4C9665BE6910 = getspreadpelletspershot(eattacker, objweapon);

  if(objweapon hasattachment("trigger_heavy_p14"))
    struct._id_52F16F4C9CDBF165 = 300;
  else if(_id_A062727999A72D2F(objweapon.basename))
    struct._id_52F16F4C9CDBF165 = 120;
  else
    struct._id_52F16F4C9CDBF165 = 200;

  return struct;
}

is_lower(a, b) {
  return a < b;
}

getspreadpelletspershot(eattacker, objweapon) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(objweapon.basename);

  if(_id_AB501F397D3CD312 == "iw9_sh_charlie725" || _id_AB501F397D3CD312 == "iw9_pi_swhiskey") {
    if(eattacker isdualwielding())
      return 2;

    if(objweapon hasattachment("bar_sh_short_p14"))
      return 3;

    _id_8B953A03A24F231D = eattacker playerads() > 0.5;

    if(_id_8B953A03A24F231D) {
      return 4;
      return;
    }

    return 3;
    return;
  } else
    return 4;
}

helmet_washit(attacker) {
  return isDefined(attacker.hithelmet) && gettime() == attacker.hithelmet;
}

helmet_sethit(attacker) {
  attacker.hithelmet = gettime();
}

helmet_clearhit(attacker) {
  attacker.hithelmet = undefined;
}

helmet_wasbroke(attacker) {
  return isDefined(attacker.brokehelmet) && gettime() == attacker.brokehelmet;
}

helmet_setbroke(attacker) {
  attacker.brokehelmet = gettime();
}

helmet_clearbroke(attacker) {
  attacker.brokehelmet = undefined;
}

applystoppingpower(objweapon, shitloc, smeansofdeath, attacker, damage, maxhealth) {
  maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  _id_641B46C4C2F9A12F = getbulletstokill(maxhealth, damage);

  if(_id_641B46C4C2F9A12F == 2) {
    if(stoppingpowercanonehitkill(objweapon, shitloc, smeansofdeath, attacker))
      return maxhealth;
    else
      return 0.9 * maxhealth;
  }

  _id_585A576D50C69137 = -1;

  if(_id_641B46C4C2F9A12F >= 7)
    _id_585A576D50C69137 = -3;
  else if(_id_641B46C4C2F9A12F >= 5)
    _id_585A576D50C69137 = -2;

  return adjustbulletstokill(damage, maxhealth, _id_585A576D50C69137);
}

stoppingpowercanonehitkill(objweapon, shitloc, smeansofdeath, attacker) {
  _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
  _id_8F7990D96DF8BA76 = weaponclass(objweapon);

  if(_id_49E6EF3EDADD524E == "iw9_dm_crossbow")
    return 1;
  else if(_id_8F7990D96DF8BA76 == "sniper") {
    switch (_id_49E6EF3EDADD524E) {
      case "iw8_sn_sksierra":
      case "iw8_sn_mike14":
        if(scripts\cp_mp\utility\damage_utility::istorsouppershot(shitloc, smeansofdeath, attacker) || scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
          return 1;

        break;
      case "iw8_sn_sbeta":
      case "iw8_sn_delta":
      case "iw8_sn_kilo98":
        if(scripts\cp_mp\utility\damage_utility::istorsoshot(shitloc, smeansofdeath, attacker) || scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
          return 1;

        break;
      default:
        if(scripts\cp_mp\utility\damage_utility::isupperbodyshot(shitloc, smeansofdeath, attacker) || scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
          return 1;
    }
  } else if(_id_8F7990D96DF8BA76 == "pistol") {
    switch (_id_49E6EF3EDADD524E) {
      case "iw8_pi_decho":
      case "iw8_pi_cpapa":
        if(scripts\cp_mp\utility\damage_utility::istorsouppershot(shitloc, smeansofdeath, attacker) || scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
          return 1;

        break;
    }
  } else if(_id_8F7990D96DF8BA76 == "rifle") {
    switch (_id_49E6EF3EDADD524E) {
      case "iw8_ar_falima":
      case "iw8_ar_asierra12":
        if(scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
          return 1;

        break;
    }

    ammotype = getweaponammopoolname(objweapon);

    if(ammotype == "enum_0A9EFEF52B466AD3" || ammotype == "enum_6AA606A18241AD16") {
      if(scripts\cp_mp\utility\damage_utility::istorsouppershot(shitloc, smeansofdeath, attacker) || scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
        return 1;
    }
  }

  return 0;
}

adjustbulletstokill(damage, maxhealth, _id_3777ECE6A73EADA5) {
  damage = int(damage);
  _id_3777ECE6A73EADA5 = int(_id_3777ECE6A73EADA5);

  if(_id_3777ECE6A73EADA5 == 0)
    return damage;

  if(damage <= 0)
    return damage;

  _id_59D4CBB2EE26E823 = getbulletstokill(maxhealth, damage);
  _id_8242953F0E099BAF = _id_59D4CBB2EE26E823 + _id_3777ECE6A73EADA5;

  if(_id_8242953F0E099BAF <= 0)
    damage = damage * 1.4;
  else if(_id_8242953F0E099BAF == 1)
    damage = int(max(maxhealth, damage * 1.4));
  else {
    _id_FEBF29B2B2D803FA = scripts\engine\utility::ter_op(damage > maxhealth, maxhealth, damage);
    _id_477C1209E5432ABE = 0.0;

    if(_id_59D4CBB2EE26E823 == 1)
      _id_477C1209E5432ABE = 0.9;
    else {
      _id_69489BAD55E2B1A7 = int(ceil(maxhealth / (_id_59D4CBB2EE26E823 - 1)));
      _id_99CA83094B92BB05 = int(ceil(maxhealth / _id_59D4CBB2EE26E823));
      _id_477C1209E5432ABE = (_id_FEBF29B2B2D803FA - _id_99CA83094B92BB05) / (_id_69489BAD55E2B1A7 - _id_99CA83094B92BB05);
    }

    _id_6606D7544E8B2F6B = int(ceil(maxhealth / (_id_8242953F0E099BAF - 1)));
    _id_E06A97413F959BB1 = int(ceil(maxhealth / _id_8242953F0E099BAF));
    damage = int((_id_6606D7544E8B2F6B - _id_E06A97413F959BB1) * _id_477C1209E5432ABE + _id_E06A97413F959BB1);
  }

  return damage;
}

getbulletstokill(maxhealth, damage) {
  return int(ceil(maxhealth / damage));
}

isbehindmeleevictim(attacker, victim) {
  _id_B3E4C19E4D37BEA0 = vectorNormalize((victim.origin[0], victim.origin[1], 0) - (attacker.origin[0], attacker.origin[1], 0));
  _id_07A049B761920208 = anglesToForward((0, victim.angles[1], 0));
  return vectordot(_id_B3E4C19E4D37BEA0, _id_07A049B761920208) > 0.4;
}

killstreakdamagefilter(eattacker, victim, idamage, objweapon, smeansofdeath) {
  _id_B4D4D1947DA73E65 = 0;

  if(isDefined(level.gamemodespawnprotectedcallback))
    _id_B4D4D1947DA73E65 = [[level.gamemodespawnprotectedcallback]](eattacker, victim, idamage, objweapon, smeansofdeath);

  if(victim scripts\mp\utility\game::isspawnprotected() || istrue(_id_B4D4D1947DA73E65)) {
    _id_54A88B0118510E9F = int(max(victim.health / 4, 1));

    if(idamage >= _id_54A88B0118510E9F && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) && !scripts\mp\utility\weapon::weaponbypassspawnprotection(objweapon) && smeansofdeath != "MOD_MELEE")
      idamage = _id_54A88B0118510E9F;
  }

  return idamage;
}

_id_B1493282AF6C1334(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  _id_B51AB50E109AD01A = 0;

  if(isDefined(objweapon)) {
    switch (objweapon.basename) {
      case "none":
        if(isDefined(einflictor) && scripts\mp\utility\entity::isdronepackage(einflictor))
          _id_B51AB50E109AD01A = 1;

        break;
      case "bomb_site_mp":
      case "chopper_gunner_turret_mp":
      case "chopper_gunner_turret_ballistics_mp":
      case "trophy_mp":
        _id_B51AB50E109AD01A = 1;
        break;
    }
  }

  return _id_B51AB50E109AD01A;
}

handlefriendlyfiredamage(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, iskillstreakweapon) {
  if(isDefined(einflictor) && !isPlayer(einflictor)) {
    if(!isDefined(eattacker)) {
      if(isDefined(einflictor.owner))
        eattacker = einflictor.owner;
    } else if(!isPlayer(eattacker)) {
      if(isDefined(einflictor.owner))
        eattacker = einflictor.owner;
      else if(isDefined(eattacker.owner))
        eattacker = eattacker.owner;
    }
  }

  if(isDefined(objweapon)) {
    if(scripts\engine\utility::isbulletdamage(smeansofdeath) && (scripts\mp\utility\weapon::iscacprimaryweapon(objweapon.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon.basename)) && !_id_556B8AEAA691317F::_id_76CA0B3D8B2555CA(objweapon))
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(victim, "stat_2A23C8694884293E", undefined, 0.25);

    if(_id_556B8AEAA691317F::_id_76CA0B3D8B2555CA(objweapon))
      return 0;
  }

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19()) {
    if(isDefined(idflags) && idflags &level.idflags_ricochet && scripts\engine\utility::isbulletdamage(smeansofdeath))
      idamage = int(idamage * 0.2);
  }

  if(level.friendlyfire != 0) {
    if(level.maxallowedteamkills == -1)
      _id_685CAC64E1726643 = 0;
    else
      _id_685CAC64E1726643 = istrue(victim.isffprotectedaction) || istrue(victim.isdefusing) || istrue(victim.isplanting);

    _id_C7F72FFF4C765948 = isfriendlyfireprotectedperiod(eattacker);

    if(_id_685CAC64E1726643 || _id_C7F72FFF4C765948) {
      idamage = int(idamage * 0.5);

      if(idamage < 1)
        idamage = 1;

      if(idamage > victim.health)
        idamage = victim.health;

      eattacker.lastdamagewasfromenemy = 0;

      if(isDefined(eattacker.pers["teamdamage"]))
        eattacker scripts\mp\utility\stats::incpersstat("teamdamage", idamage);

      damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
      return 0;
    }
  }

  if(level.friendlyfire == 0 || !isPlayer(eattacker) && level.friendlyfire != 1) {
    if(scripts\mp\utility\damage::_id_7CC9753F2F84E883(eattacker, victim))
      eattacker handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon);

    return 0;
  } else if(level.friendlyfire == 1) {
    if(idamage < 1)
      idamage = 1;

    victim.lastdamagewasfromenemy = 0;
    logfriendlyfire(victim, eattacker, idamage, smeansofdeath);
    victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
    eattacker handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon);
    return 0;
  } else if(level.friendlyfire == 2) {
    idamage = int(idamage * 0.5);

    if(idamage < 1)
      idamage = 1;

    eattacker.lastdamagewasfromenemy = 0;

    if(!_id_B1493282AF6C1334(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname))
      damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

    return 0;
  } else if(level.friendlyfire == 3) {
    idamage = int(idamage * 0.5);

    if(idamage < 1)
      idamage = 1;

    victim.lastdamagewasfromenemy = 0;
    eattacker.lastdamagewasfromenemy = 0;
    logfriendlyfire(victim, eattacker, idamage, smeansofdeath);
    victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

    if(!_id_B1493282AF6C1334(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname))
      damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

    eattacker handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon);
    return 0;
  } else if(level.friendlyfire == 4) {
    _id_399AC373783533B5 = !_id_B1493282AF6C1334(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);

    if(_id_399AC373783533B5 && isDefined(eattacker.pers["teamdamage"]) && self.team == eattacker.team) {
      _id_64307762A309E5E1 = int(idamage);

      if(idamage > victim.health)
        _id_64307762A309E5E1 = victim.health;

      _id_EE03B1094657A1CA = !istrue(eattacker.pers["didHitFFPunishLimit"]) && iskillstreakweapon;

      if(!_id_EE03B1094657A1CA)
        eattacker scripts\mp\utility\stats::incpersstat("teamdamage", _id_64307762A309E5E1);

      _id_490BDE8509585600 = isDefined(level._id_843399BEE19793FE) && level._id_843399BEE19793FE > 0;

      if(_id_490BDE8509585600 && istrue(eattacker.pers["didHitFFPunishLimit"])) {
        eattacker scripts\mp\hud_message::showerrormessage("MP/FRIENDLY_FIRE_KICK_WARNING");

        if(eattacker.pers["teamdamage"] - eattacker.pers["totalFFDamageDoneBeforePunish"] >= level._id_843399BEE19793FE) {
          if(!istrue(eattacker.pers["didHitFFKickLimit"]))
            eattacker.pers["didHitFFKickLimit"] = 1;
          else if(istrue(eattacker.connected)) {
            kick(eattacker getentitynumber(), "EXE/PLAYERKICKED_TEAMKILLS");
            return 0;
          }
        }
      } else if(isDefined(level._id_DC3C7C5627A11E5E) && level._id_DC3C7C5627A11E5E > 0) {
        if(!istrue(eattacker._id_321F6FF131FFBB72) && eattacker.pers["teamdamage"] >= level._id_DC3C7C5627A11E5E) {
          eattacker._id_321F6FF131FFBB72 = 1;
          eattacker scripts\mp\hud_message::showerrormessage("MP/FRIENDLY_FIRE_WILL_NOT");
        }
      }
    }

    _id_554D89E1B2D5128B = isDefined(level._id_6706AAD138CBC31D) && level._id_6706AAD138CBC31D > 0;
    _id_189A3D91F762202B = isDefined(eattacker.pers["teamkills"]) && eattacker.pers["teamkills"] >= level.maxallowedteamkills;

    if(!_id_189A3D91F762202B && _id_554D89E1B2D5128B)
      _id_189A3D91F762202B = isDefined(eattacker.pers["teamdamage"]) && eattacker.pers["teamdamage"] >= level._id_6706AAD138CBC31D;

    if(_id_189A3D91F762202B && _id_399AC373783533B5) {
      idamage = int(idamage * 0.5);

      if(idamage < 1)
        idamage = 1;

      if(!istrue(eattacker.pers["didHitFFPunishLimit"])) {
        eattacker.pers["didHitFFPunishLimit"] = 1;
        eattacker.pers["totalFFDamageDoneBeforePunish"] = eattacker.pers["teamdamage"];
      }

      eattacker.lastdamagewasfromenemy = 0;
      damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
      return 0;
    }
  }

  return idamage;
}

isfriendlyfireprotectedperiod(attacker) {
  if(isDefined(level.gametype) && level.gametype == "havoc")
    return 0;

  if(scripts\mp\utility\game::isanymlgmatch() && !istrue(level._id_EC2FB549B15AD827))
    return 0;

  if(level.ingraceperiod)
    return 1;

  if(isDefined(attacker) && isDefined(attacker.pers) && isDefined(attacker.pers["teamkills"]) && attacker.pers["teamkills"] > 1 && scripts\mp\utility\game::gettimepassed() < level.graceperiod * 1000 + 8000 + attacker.pers["teamkills"] * 1000)
    return 1;

  return 0;
}

damageattacker(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(eattacker scripts\cp_mp\utility\player_utility::_isalive()) {
    eattacker.friendlydamage = 1;
    eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
    eattacker.friendlydamage = undefined;
  }
}

mlghitlocrequiresclamp(shitloc) {
  return shitloc == "head" || shitloc == "helmet" || shitloc == "neck";
}

mlgmodifyheadshotdamage(eattacker, idamage, smeansofdeath, objweapon, shitloc) {
  if(scripts\mp\utility\game::isanymlgmatch() && isDefined(eattacker) && isPlayer(eattacker) && !isnullweapon(objweapon) && scripts\mp\utility\weapon::isprimaryweapon(objweapon) && scripts\engine\utility::isbulletdamage(smeansofdeath) && mlghitlocrequiresclamp(shitloc)) {
    switch (objweapon.classname) {
      case "mg":
      case "rifle":
      case "pistol":
      case "smg":
        idamage = int(clamp(idamage, 0, objweapon.maxdamage * 1.3));
        break;
    }
  }

  return idamage;
}

modifyfalldamage(victim, idamage, idflags, smeansofdeath) {
  _id_702BFC08FABD86CB = idamage;

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_FALLING") {
    if(victim scripts\mp\utility\killstreak::isjuggernaut() || getdvarint("dvar_F1B2BD0A1FA58A73", 0))
      _id_702BFC08FABD86CB = victim scripts\mp\juggernaut::jugg_modifyfalldamage();
    else if(victim _id_63634D9FA080435A::_id_95ADB84C5CA51C36() || istrue(self._id_B6AA5954BF6A457A))
      _id_702BFC08FABD86CB = victim _id_63634D9FA080435A::_id_3A307FD8EB4F27EB();
    else if(istrue(victim.iszombie))
      _id_702BFC08FABD86CB = 0;
    else if(idflags &level._id_81A140202A2F4D30 && _id_702BFC08FABD86CB >= victim.health)
      _id_702BFC08FABD86CB = victim.health - 1;
    else if(_id_702BFC08FABD86CB < victim.maxhealth) {
      _id_702BFC08FABD86CB = _id_702BFC08FABD86CB / victim.maxhealth * (_id_702BFC08FABD86CB / victim.maxhealth) * victim.maxhealth;
      thread _id_6A5D3BF7A5B7064A::_id_2CA98396C7F5CC85(_id_702BFC08FABD86CB);

      if(istrue(self._id_808D06DDFC93A4E4))
        _id_702BFC08FABD86CB = 0;
      else if(_id_702BFC08FABD86CB >= victim.health)
        _id_702BFC08FABD86CB = victim.health - 1;
    }
  }

  return _id_702BFC08FABD86CB;
}

modifyvehicletoplayerdamage(einflictor, eattacker, victim, idamage, smeansofdeath) {
  _id_702BFC08FABD86CB = idamage;

  if(isDefined(einflictor) && einflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(victim scripts\mp\utility\killstreak::isjuggernaut())
      _id_702BFC08FABD86CB = victim scripts\mp\juggernaut::jugg_modifyvehicletoplayerdamage(idamage, smeansofdeath);

    if(getdvarint("scr_live_ragdoll_on_vehicles", 0) == 1) {
      velocity = einflictor vehicle_getvelocity();
      _id_702BFC08FABD86CB = victim.health - 1;

      if(victim.health > 0)
        victim thread _id_BF56DBD2A1035901(undefined, 1, velocity);
    }
  }

  return _id_702BFC08FABD86CB;
}

_id_053B212D296370F7(victim, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon) {
  _id_702BFC08FABD86CB = idamage;
  vehicle = victim scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle))
    _id_702BFC08FABD86CB = scripts\cp_mp\vehicles\vehicle_damage::_id_9CAC3AF67EE6B40A(vehicle, victim, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon);

  return _id_702BFC08FABD86CB;
}

modifycrushdamage(einflictor, eattacker, victim, idamage, smeansofdeath) {
  _id_702BFC08FABD86CB = idamage;

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_CRUSH") {
    if(isDefined(einflictor) && isDefined(eattacker) && einflictor == eattacker && eattacker scripts\mp\utility\killstreak::isjuggernaut() && victim scripts\mp\utility\killstreak::isjuggernaut())
      _id_702BFC08FABD86CB = victim scripts\mp\juggernaut::jugg_modifyherodroptoplayerdamage(idamage);
  }

  return _id_702BFC08FABD86CB;
}

_id_754E680A5B56B39E(eattacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1) {
  _id_702BFC08FABD86CB = idamage;

  if(isDefined(eattacker) && isDefined(smeansofdeath) && isDefined(objweapon)) {
    if(scripts\cp_mp\dragonsbreath::_id_0CFD2E1E48EDAF93(objweapon)) {
      objweapon = eattacker scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);

      if(!_id_2669878CF5A1B6BC::isspreadweapon(objweapon)) {
        _id_AD6E07429CABF92B = victim.health;
        _id_702BFC08FABD86CB = _id_BE4285B26ED99AB1;

        if(_id_702BFC08FABD86CB >= _id_AD6E07429CABF92B)
          _id_702BFC08FABD86CB = _id_AD6E07429CABF92B - 1;
      }
    }
  }

  return _id_702BFC08FABD86CB;
}

_id_2AA2C49EE1702368(eattacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1) {
  if(!scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
    return idamage;

  if(victim scripts\mp\utility\killstreak::isjuggernaut())
    return idamage;

  equiptype = scripts\mp\utility\weapon::getequipmenttype(objweapon);

  if(isDefined(equiptype)) {
    if(equiptype == "lethal")
      idamage = _id_88C7467B96144AFD(objweapon, idamage);
    else if(equiptype == "equipment_other") {} else if(equiptype == "tactical") {}
  }

  if(scripts\engine\utility::isbulletdamage(smeansofdeath))
    idamage = _id_18B0510FBCA05FF7(objweapon, idamage);

  return idamage;
}

_id_88C7467B96144AFD(objweapon, damage) {
  _id_3EB952B99F137248 = "dvar_303DBC969FD35E79";

  if(isDefined(objweapon.basename)) {
    _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF(_id_3EB952B99F137248, objweapon.basename);
    _id_B4BE57645C0CF041 = self.maxhealth / 100;
    damage = damage * getdvarfloat(_id_CEFFD5A372961F55, _id_B4BE57645C0CF041);
  }

  return damage;
}

_id_18B0510FBCA05FF7(objweapon, damage) {
  _id_3EB952B99F137248 = "dvar_303DBC969FD35E79";

  if(isDefined(objweapon.classname)) {
    _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF(_id_3EB952B99F137248, objweapon.classname);
    damageratio = getdvarfloat(_id_CEFFD5A372961F55, 0.0);
    damage = damage * scripts\engine\utility::ter_op(damageratio == 0.0, 1.0, damageratio);
  }

  if(isDefined(objweapon.basename)) {
    _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF(_id_3EB952B99F137248, objweapon.basename);
    damageratio = getdvarfloat(_id_CEFFD5A372961F55, 0.0);
    damage = damage * scripts\engine\utility::ter_op(damageratio == 0.0, 1.0, damageratio);
  }

  return damage;
}

_id_49F3D4DE0E352093(inflictor, attacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1, shitloc) {
  _id_702BFC08FABD86CB = idamage;
  iskillstreakweapon = istrue(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon));

  if(isexplosivedamagemod(smeansofdeath)) {
    if(isPlayer(attacker)) {
      if(attacker != victim && attacker scripts\mp\utility\perk::_hasperk("specialty_paint") && !iskillstreakweapon)
        victim thread scripts\mp\perks\perkfunctions::setpainted(attacker);
    }

    _id_702BFC08FABD86CB = modifydestructibledamage(_id_702BFC08FABD86CB, inflictor, objweapon);
    _id_702BFC08FABD86CB = scripts\mp\equipment\claymore::claymore_modifieddamage(victim, objweapon, inflictor, smeansofdeath, _id_702BFC08FABD86CB);
    _id_702BFC08FABD86CB = scripts\mp\equipment\at_mine::at_mine_modified_damage(victim, inflictor, objweapon, smeansofdeath, _id_702BFC08FABD86CB);
    _id_702BFC08FABD86CB = _id_10AD6174C8938599::_id_723AA6329B751BC7(victim, inflictor, objweapon, smeansofdeath, _id_702BFC08FABD86CB);

    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      switch (objweapon.basename) {
        case "flash_grenade_mp":
        case "concussion_grenade_mp":
          if(isDefined(victim) && _id_702BFC08FABD86CB >= victim.health) {
            if(isDefined(attacker))
              attacker _id_5762AC2F22202BA2::updatedamagefeedback("");

            _id_702BFC08FABD86CB = 0;
          }

          break;
      }
    }

    if(isPlayer(attacker) && weaponinheritsperks(objweapon) && (attacker scripts\mp\utility\perk::_hasperk("specialty_explosivedamage") && victim scripts\mp\utility\perk::_hasperk("specialty_blastshield"))) {} else if(isPlayer(attacker) && weaponinheritsperks(objweapon) && !iskillstreakweapon && attacker scripts\mp\utility\perk::_hasperk("specialty_explosivedamage"))
      _id_702BFC08FABD86CB = _id_702BFC08FABD86CB + _id_702BFC08FABD86CB * level.explosivedamagemod;
    else if(victim scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(attacker, victim, objweapon, smeansofdeath, inflictor, shitloc)) {
      _id_46381C94B0138DC7 = modify_blast_shield_damage(_id_702BFC08FABD86CB, attacker, victim, victim._id_08CBE63A199E19DE);
      victim scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_eod");
      _id_702BFC08FABD86CB = _id_702BFC08FABD86CB - (_id_702BFC08FABD86CB - _id_46381C94B0138DC7);
    }

    if(isDefined(level.lethaldelay) && !scripts\mp\equipment::lethaldelaypassed())
      _id_702BFC08FABD86CB = _id_702BFC08FABD86CB * level.graceperiodgrenademod;
  }

  return _id_702BFC08FABD86CB;
}

_id_112EE98A4FACA19A(inflictor, attacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1, shitloc) {
  _id_702BFC08FABD86CB = idamage;

  if(smeansofdeath == "MOD_FIRE") {
    if(victim scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(attacker, victim, objweapon, smeansofdeath, inflictor, shitloc)) {
      _id_46381C94B0138DC7 = modify_blast_shield_damage(_id_702BFC08FABD86CB, attacker, victim, victim._id_FB1106D94CC95901);
      victim scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_eod");
      _id_702BFC08FABD86CB = _id_702BFC08FABD86CB - (_id_702BFC08FABD86CB - _id_46381C94B0138DC7);
    }
  }

  return _id_702BFC08FABD86CB;
}

_id_7E8906E2DAB3D41E(inflictor, attacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1, shitloc) {
  _id_702BFC08FABD86CB = idamage;

  if(isDefined(objweapon) && isDefined(smeansofdeath) && victim scripts\mp\utility\perk::_hasperk("specialty_super_protection")) {
    weaponref = objweapon.basename;
    _id_AE95568A563D5912 = weaponclass(objweapon);
    _id_B4A7D8CD8C4FB7DA = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

    if(isDefined(weaponref) && isDefined(_id_AE95568A563D5912)) {
      if(scripts\engine\utility::isbulletdamage(smeansofdeath)) {
        switch (_id_AE95568A563D5912) {
          case "grenade":
            if(istrue(_id_B4A7D8CD8C4FB7DA))
              _id_702BFC08FABD86CB = min(1, idamage);

            break;
        }
      } else if(scripts\engine\utility::_id_F1D312F6935BC2D2(smeansofdeath)) {
        if(isDefined(_id_AE95568A563D5912)) {
          switch (_id_AE95568A563D5912) {
            case "throwingknife":
              _id_702BFC08FABD86CB = min(self.maxhealth, idamage);
              break;
          }
        }
      } else if(isexplosivedamagemod(smeansofdeath)) {
        switch (weaponref) {
          case "molotov_mp":
            if(istrue(_id_B4A7D8CD8C4FB7DA))
              _id_702BFC08FABD86CB = min(5, idamage);

            break;
        }
      } else if(scripts\engine\utility::_id_55E3DE6210F3EAC0(smeansofdeath)) {
        _id_B4A7D8CD8C4FB7DA = isDefined(inflictor) && (isDefined(inflictor.stuckto) && inflictor.stuckto == victim || isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim);

        switch (weaponref) {
          case "thermite_av_mp":
          case "thermite_ap_mp":
          case "thermite_mp":
            if(istrue(_id_B4A7D8CD8C4FB7DA))
              _id_702BFC08FABD86CB = min(5, idamage);

            break;
        }
      }
    }

    if(_id_702BFC08FABD86CB > 0) {
      modifier = 2;

      if(isagent(attacker))
        modifier = 4;

      _id_702BFC08FABD86CB = int(_id_702BFC08FABD86CB / modifier);
    }
  }

  return _id_702BFC08FABD86CB;
}

modifydamagegeneral(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, _id_BE4285B26ED99AB1, partname) {
  _id_69CFD14B4398C458 = idamage;
  idamage = mlgmodifyheadshotdamage(eattacker, idamage, smeansofdeath, objweapon, shitloc);
  idamage = modifyfalldamage(victim, idamage, idflags, smeansofdeath);
  idamage = modifyvehicletoplayerdamage(einflictor, eattacker, victim, idamage, smeansofdeath);
  idamage = _id_053B212D296370F7(victim, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon);
  idamage = modifycrushdamage(einflictor, eattacker, victim, idamage, smeansofdeath);
  idamage = _id_754E680A5B56B39E(eattacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1);
  idamage = _id_2AA2C49EE1702368(eattacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1);
  idamage = _id_49F3D4DE0E352093(einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1, shitloc);
  idamage = _id_112EE98A4FACA19A(einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1, shitloc);
  idamage = _id_7E8906E2DAB3D41E(einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, _id_BE4285B26ED99AB1, shitloc);

  if(isDefined(level.modifyplayerdamage))
    idamage = int([[level.modifyplayerdamage]](einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1));

  [idamage, _id_1DA1A66B5C6A06A7] = _id_07C40FA80892A721::_id_90CE8EB3DDAA4943(eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, _id_BE4285B26ED99AB1, _id_69CFD14B4398C458, partname);

  if(_id_1DA1A66B5C6A06A7 > 0 && isPlayer(eattacker)) {
    if(shouldrecorddamagestats(eattacker)) {
      eattacker scripts\mp\utility\stats::incpersstat("damage", _id_1DA1A66B5C6A06A7);
      eattacker scripts\mp\codcasterclientmatchdata::_id_D16498B27251DA56(1, _id_1DA1A66B5C6A06A7);

      if(isDefined(eattacker.pers["friendlyDamageDone"]) && victim.team == eattacker.team)
        eattacker scripts\mp\utility\stats::incpersstat("friendlyDamageDone", _id_1DA1A66B5C6A06A7);
    } else if(isDefined(level.onattackerdamagenottracked))
      eattacker[[level.onattackerdamagenottracked]](_id_1DA1A66B5C6A06A7);
  }

  if(smeansofdeath == "MOD_EXPLOSIVE_BULLET" && idamage != 1) {
    idamage = idamage * getdvarfloat("scr_explbulletmod");
    idamage = int(idamage);
  }

  if(smeansofdeath == "MOD_IMPACT" && idamage != 1) {
    if(istrue(objweapon.isalternate) && scripts\mp\weapons::isattachmentgrenadelauncher(objweapon.underbarrel)) {
      velocity = einflictor getmissilevelocity();
      speed = length(velocity);

      if(speed < 400)
        idamage = 10;
    }
  }

  if(objweapon.basename == "iw9_dm_crossbow_mp" && (isDefined(victim.inlaststand) && istrue(victim.inlaststand))) {
    idamage = victim.health;
    _id_EDF5C78DC8518F2D = getdvarfloat("dvar_A3A7191F4314591F", 0);

    if(_id_EDF5C78DC8518F2D > 0)
      idamage = idamage * _id_EDF5C78DC8518F2D;
  }

  if(!isDefined(victim.donotmodifydamage))
    idamage = int(idamage * victim scripts\cp_mp\utility\damage_utility::getdamagemodifiertotal(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc));

  if(isDefined(eattacker) && isDefined(eattacker._id_888410F22DA94AD0) && istrue(eattacker._id_888410F22DA94AD0))
    idamage = idamage * 0.5;

  if(scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker))
    smeansofdeath = "MOD_HEAD_SHOT";

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots") || scripts\mp\tweakables::gettweakablevalue("game", "one_tap_headshot")) {
    if(smeansofdeath == "MOD_HEAD_SHOT")
      idamage = 150;
  }

  return [idamage, _id_1DA1A66B5C6A06A7];
}

handleriotshieldhits(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, iskillstreakweapon) {
  if(shitloc != "shield")
    return idamage;

  if(isDefined(objweapon) && objweapon.basename == "super_laser_charge_mp") {
    victim.forcehitlocation = "none";
    return idamage;
  }

  data = scripts\cp_mp\utility\damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir, undefined, undefined, undefined, idflags);
  _id_638AF1E086448F2F = istrue(victim.ignoreriotshieldxp);
  isenemy = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(victim, eattacker));

  if(getdvarint("dvar_79392AE6DCFBA9E9", 0)) {
    isfriendly = isfriendlyfire(victim, eattacker);
    _id_DF49E818DFAC7DBA = isDefined(victim) && (isDefined(eattacker) && eattacker == victim || isDefined(eattacker.owner) && eattacker.owner == victim);

    if(isenemy || isfriendly && (scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19() || _id_DF49E818DFAC7DBA)) {
      if(_id_CD066C9463AD28C5(objweapon, smeansofdeath))
        victim._id_5C11205F47AF8B92 = gettime();
    }
  }

  if(isDefined(victim.owner)) {
    victim = victim.owner;

    if(eattacker == victim)
      return 0;
  }

  if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
    if(isPlayer(eattacker)) {
      eattacker.lastattackedshieldplayer = victim;
      eattacker.lastattackedshieldtime = gettime();
    }

    victim notify("shield_blocked");

    if(scripts\mp\utility\weapon::isenvironmentweapon(objweapon.basename))
      shielddamage = 25;
    else {
      _id_619984A4A37B8423 = cac_modified_damage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, einflictor, 0, idflags);
      shielddamage = _id_619984A4A37B8423[0];
      _id_986B2E0350629522 = _id_619984A4A37B8423[1];
      shitloc = _id_619984A4A37B8423[2];
    }

    victim scripts\mp\utility\stats::incpersstat("riotShieldDamageAbsorbed", shielddamage);

    if(isPlayer(eattacker) && isDefined(victim.rearguardattackers)) {
      _id_FE8F7703F6313ED4 = eattacker getentitynumber();

      if(!isDefined(victim.rearguardattackers[_id_FE8F7703F6313ED4]))
        victim.rearguardattackers[_id_FE8F7703F6313ED4] = shielddamage;
      else
        victim.rearguardattackers[_id_FE8F7703F6313ED4] = victim.rearguardattackers[_id_FE8F7703F6313ED4] + shielddamage;
    }

    if(_id_638AF1E086448F2F)
      return 0;

    if(!scripts\mp\utility\weapon::isenvironmentweapon(objweapon.basename) || scripts\engine\utility::cointoss())
      victim.shieldbullethits++;

    if(victim.shieldbullethits >= level.riotshieldxpbullets && isenemy) {
      _id_244C8B1A0FD7B3F2 = 1.0;

      if(self.recentshieldxp > 4)
        _id_244C8B1A0FD7B3F2 = 1.0 / self.recentshieldxp;

      basepoints = scripts\mp\rank::getscoreinfovalue("stat_8D58394A2E99BAE8");
      victim thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_8D58394A2E99BAE8", victim.currentweapon, basepoints * _id_244C8B1A0FD7B3F2);
      victim thread giverecentshieldxp();
      victim.shieldbullethits = 0;
    }
  }

  _id_33E2D54D8812E8CE = isDefined(einflictor) && isDefined(einflictor.stuckenemyentity) && einflictor.stuckenemyentity == victim;

  if(idflags &level.idflags_shield_explosive_impact) {
    victim.forcehitlocation = "none";

    if(!(idflags &level.idflags_shield_explosive_impact_huge)) {
      victim scripts\mp\utility\stats::incpersstat("riotShieldDamageAbsorbed", idamage);
      idamage = 0;
    }
  } else if(idflags &level.idflags_shield_explosive_splash) {
    victim.forcehitlocation = "none";

    if(victim scripts\cp_mp\utility\damage_utility::isstuckdamagekill(data))
      idamage = victim.maxhealth;
  } else
    return 0;

  if(smeansofdeath == "MOD_MELEE" && scripts\cp_mp\utility\weapon_utility::isriotshield(objweapon.basename))
    victim stunplayer(0.0);

  return idamage;
}

filterdamage(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc) {
  if(!idamage)
    return "!iDamage";

  if(isDefined(level.hostmigrationtimer))
    return "level.hostMigrationTimer";

  eattacker = scripts\mp\utility\damage::_validateattacker(eattacker);

  if(!isDefined(eattacker) && smeansofdeath != "MOD_FALLING")
    return "invalid attacker";

  victim = scripts\mp\utility\damage::_validatevictim(victim);

  if(!isDefined(victim))
    return "invalidVictim";

  if(isDefined(eattacker) && eattacker == victim && smeansofdeath == "MOD_EXPLOSIVE_BULLET")
    return "Bullet Splash Protection";

  if(game["state"] == "postgame")
    return "game[ state ] == postgame";

  if(isDefined(victim.sessionteam) && victim.sessionteam == "spectator")
    return "victim.sessionteam == spectator";

  if(isDefined(eattacker) && (isDefined(victim._id_FEE2CCC62E5CC50D) && victim._id_FEE2CCC62E5CC50D == eattacker.team || isDefined(eattacker._id_FEE2CCC62E5CC50D) && eattacker._id_FEE2CCC62E5CC50D == victim.team))
    return "damageBlockedTeam";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_362C58E8BB39BCDA::isbrgametypefuncdefined("filterDamage") && isDefined(einflictor)) {
    result = _id_362C58E8BB39BCDA::_id_D72AF9CCEDFC923B("filterDamage", einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc);

    if(isDefined(result))
      return result;
  }

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(shitloc != "head" && shitloc != "helmet") {
      if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET")
        return "getTweakableValue( game, onlyheadshots )";
    }
  }

  if(_id_2BE5B08ED39D6A54(eattacker, victim, objweapon))
    return "crossbow semtex splash damage on stuckto victim";

  if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && einflictor scripts\cp_mp\vehicles\vehicle::isvehicle() && victim scripts\cp_mp\utility\player_utility::isinvehicle())
    return "hitByVehicleWhileInVehicle";

  if(scripts\cp_mp\vehicles\vehicle::vehicle_playershouldignorecollisiondamage(einflictor, victim, smeansofdeath, objweapon))
    return "vehicle_playerShouldIgnoreCollisionDamage";

  if(scripts\cp_mp\vehicles\vehicle::_id_E4768BD722E98562(einflictor, victim, smeansofdeath))
    return "vehicle_isRubbingAgainstVehicle";
}

logattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, _id_1DA1A66B5C6A06A7) {
  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_FALLING")
    eattacker = victim;

  if(isDefined(eattacker) && (isPlayer(eattacker) || isagent(eattacker)))
    addattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, _id_1DA1A66B5C6A06A7);

  if(isDefined(eattacker) && !isPlayer(eattacker) && isDefined(eattacker.owner) && (!isDefined(eattacker.scrambled) || !eattacker.scrambled))
    addattacker(victim, eattacker.owner, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, _id_1DA1A66B5C6A06A7);
  else if(isDefined(eattacker) && !isPlayer(eattacker) && isDefined(eattacker.secondowner) && isDefined(eattacker.scrambled) && eattacker.scrambled)
    addattacker(victim, eattacker.secondowner, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, _id_1DA1A66B5C6A06A7);

  if(isDefined(einflictor) && isDefined(einflictor.owner)) {
    _id_AEAE22D243E7AF66 = isDefined(einflictor.owner.team) && einflictor.owner.team != victim.team || level.friendlyfire == 1;

    if(_id_AEAE22D243E7AF66 && isDefined(einflictor.owner.guid) && !isDefined(self.attackerdata[einflictor.owner.guid]))
      addattacker(victim, einflictor.owner, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, _id_1DA1A66B5C6A06A7);
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(objweapon) && eattacker != victim) {
    eattacker thread scripts\mp\weapons::checkhit(objweapon, victim, shitloc, idamage);
    eattacker thread scripts\mp\events::damagedplayer(self, idamage);
    victim.attackerposition = eattacker.origin;
  } else
    victim.attackerposition = undefined;
}

logattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon) {
  if(isDefined(eattacker) && isPlayer(eattacker))
    addattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon);

  if(isDefined(eattacker) && !isPlayer(eattacker) && isDefined(eattacker.owner) && (!isDefined(eattacker.scrambled) || !eattacker.scrambled)) {
    eattacker = eattacker.owner;
    addattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon);
  } else if(isDefined(eattacker) && !isPlayer(eattacker) && isDefined(eattacker.secondowner) && isDefined(eattacker.scrambled) && eattacker.scrambled) {
    eattacker = eattacker.secondowner;
    addattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon);
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(sweapon) && eattacker != victim)
    victim.attackerposition = eattacker.origin;
  else
    victim.attackerposition = undefined;
}

loggrenadedata(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon) {
  if((issubstr(smeansofdeath, "MOD_EXPLOSIVE") || issubstr(smeansofdeath, "MOD_PROJECTILE")) && isDefined(einflictor) && isDefined(eattacker)) {
    _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);
    victim.explosiveinfo = [];
    victim.explosiveinfo["damageTime"] = gettime();
    victim.explosiveinfo["damageId"] = einflictor getentitynumber();
    victim.explosiveinfo["returnToSender"] = 0;
    victim.explosiveinfo["counterKill"] = 0;
    victim.explosiveinfo["chainKill"] = 0;
    victim.explosiveinfo["cookedKill"] = 0;
    victim.explosiveinfo["throwbackKill"] = 0;
    victim.explosiveinfo["suicideGrenadeKill"] = 0;
    victim.explosiveinfo["weapon"] = _id_366B0ECC2F28AEAD;
    _id_952A9BAA37244541 = issubstr(objweapon.basename, "frag_");

    if(eattacker != victim) {
      if((issubstr(objweapon.basename, "c4_") || issubstr(objweapon.basename, "proximity_explosive_") || issubstr(objweapon.basename, "claymore_")) && isDefined(einflictor.owner)) {
        victim.explosiveinfo["returnToSender"] = einflictor.owner == victim;
        victim.explosiveinfo["counterKill"] = isDefined(einflictor.wasdamaged);
        victim.explosiveinfo["chainKill"] = isDefined(einflictor.waschained);
        victim.explosiveinfo["bulletPenetrationKill"] = isDefined(einflictor.wasdamagedfrombulletpenetration);
        victim.explosiveinfo["cookedKill"] = 0;
      }

      if(isDefined(eattacker.lastgrenadesuicidetime) && eattacker.lastgrenadesuicidetime >= gettime() - 50 && _id_952A9BAA37244541)
        victim.explosiveinfo["suicideGrenadeKill"] = 1;
    }

    if(_id_952A9BAA37244541) {
      victim.explosiveinfo["cookedKill"] = isDefined(einflictor.iscooked);
      victim.explosiveinfo["throwbackKill"] = isDefined(einflictor.threwback);
    }

    victim.explosiveinfo["stickKill"] = isDefined(einflictor.isstuck) && einflictor.isstuck == "enemy";
    victim.explosiveinfo["stickFriendlyKill"] = isDefined(einflictor.isstuck) && einflictor.isstuck == "friendly";

    if(isPlayer(eattacker) && eattacker != self && scripts\mp\utility\game::getgametype() != "aliens")
      updateinflictorstat(einflictor, eattacker, _id_366B0ECC2F28AEAD);
  }
}

handledamagefeedback(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522, iskillstreakweapon, partname) {
  if(isDefined(victim.handledamagefeedback)) {
    [[victim.handledamagefeedback]](einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522, iskillstreakweapon);
    return;
  }

  _id_168973EAF883AEA1 = isDefined(eattacker) && isDefined(eattacker.classname) && !isDefined(eattacker.gunner) && (eattacker.classname == "script_vehicle" || eattacker.classname == "misc_turret" || eattacker.classname == "script_model");

  if(_id_168973EAF883AEA1 && isDefined(eattacker.gunner))
    _id_91EBB035A259E76A = eattacker.gunner;
  else if(isDefined(eattacker) && isDefined(eattacker.owner))
    _id_91EBB035A259E76A = eattacker.owner;
  else
    _id_91EBB035A259E76A = eattacker;

  _id_CDCEDB142F61B43E = "standard";

  if(isDefined(_id_91EBB035A259E76A) && _id_91EBB035A259E76A != victim && idamage + _id_1DA1A66B5C6A06A7 + _id_986B2E0350629522 > 0 && (!isDefined(shitloc) || shitloc != "shield")) {
    _id_4FFE32F42D51A763 = !victim scripts\cp_mp\utility\player_utility::_isalive() || isagent(victim) && idamage >= victim.health;
    _id_B44E627D6A911F55 = scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73();
    _id_DC726E8CC0B003A3 = isDefined(victim._id_BED158A6DFAC230D) && victim._id_BED158A6DFAC230D > 2;
    _id_A2FFD9894FD368C5 = isDefined(victim._id_04045F099F3DA4BD) && victim._id_04045F099F3DA4BD == "brloot_plate_carrier_tempered";
    _id_0CCF879B038E4391 = idamage + _id_1DA1A66B5C6A06A7 + _id_986B2E0350629522;
    _id_135003274A4CC703 = 0;

    if(istrue(_id_DC726E8CC0B003A3) && isDefined(victim.armorhealth))
      _id_135003274A4CC703 = victim.armorhealth + _id_0CCF879B038E4391 >= 150;

    if(isPlayer(eattacker) && scripts\mp\utility\damage::_id_3201A1BC3FF0E482(eattacker, victim, smeansofdeath, idflags))
      _id_CDCEDB142F61B43E = "hitsuppression";
    else if(victim scripts\mp\utility\perk::_hasperk("specialty_pistoldeath") && isDefined(victim.inlaststand) && victim.inlaststand == 1 && !victim.hasshownlaststandicon) {
      victim.hasshownlaststandicon = 1;
      _id_CDCEDB142F61B43E = "hitlaststand";
    } else if(!isagent(victim) && victim _meth_F1DCADC8F7C3477C())
      _id_CDCEDB142F61B43E = "hitlaststand";
    else if(istrue(victim.isjuggernaut))
      _id_CDCEDB142F61B43E = "hitjuggernaut";
    else if(victim scripts\mp\heavyarmor::hasheavyarmor() || victim scripts\mp\heavyarmor::hasheavyarmorinvulnerability())
      _id_CDCEDB142F61B43E = "hitarmorheavy";
    else if(idflags &level.idflags_stun)
      _id_CDCEDB142F61B43E = "stun";
    else if(scripts\mp\utility\damage::hashealthshield(victim))
      _id_CDCEDB142F61B43E = "hitarmorlight";
    else if(_id_07C40FA80892A721::armorvest_wasbroke(_id_91EBB035A259E76A)) {
      _id_CDCEDB142F61B43E = "hitarmorlightbreak";

      if(_id_DC726E8CC0B003A3 && !_id_B44E627D6A911F55)
        _id_CDCEDB142F61B43E = "hitarmormaxplatebreak";

      if(_id_A2FFD9894FD368C5 && !_id_B44E627D6A911F55)
        _id_CDCEDB142F61B43E = "hitarmortemperedbreak";
    } else if(scripts\mp\utility\damage::_id_7CC9753F2F84E883(eattacker, victim) || victim scripts\mp\utility\game::isspawnprotected() && iskillstreakweapon && !scripts\mp\utility\weapon::weaponbypassspawnprotection(objweapon))
      _id_CDCEDB142F61B43E = "hitspawnprotect";
    else if(helmet_wasbroke(_id_91EBB035A259E76A))
      _id_CDCEDB142F61B43E = "hithelmetlightbreak";
    else if(_id_07C40FA80892A721::armorvest_washit(_id_91EBB035A259E76A)) {
      _id_CDCEDB142F61B43E = "hitarmorlight";

      if((getdvarint("dvar_2F7767A2A092CE1A", 0) || !getdvarint("dvar_F786619A1F55409F", 0)) && _id_DC726E8CC0B003A3 && !_id_B44E627D6A911F55)
        _id_CDCEDB142F61B43E = "hitarmorlightmaxlevel";

      if(_id_A2FFD9894FD368C5 && !_id_B44E627D6A911F55)
        _id_CDCEDB142F61B43E = "hitarmorlighttempered";
    } else if(helmet_washit(_id_91EBB035A259E76A))
      _id_CDCEDB142F61B43E = "hithelmetlight";
    else if(_id_1DA1A66B5C6A06A7 > 0)
      _id_CDCEDB142F61B43E = "hitarmorlight";
    else if(victim scripts\mp\utility\perk::_hasperk("specialty_regen_delay_reduced"))
      _id_CDCEDB142F61B43E = "hitquickfix";
    else if(istrue(victim._id_808D06DDFC93A4E4))
      _id_CDCEDB142F61B43E = "hitbattlerage";
    else if(istrue(victim.iszombie) && istrue(victim._id_750C82BA41F3E2B1)) {
      _id_CDCEDB142F61B43E = "hitzombieshout";
      victim thread _id_43B6FEFD9C0E079F();
    } else if(scripts\mp\utility\damage::istacticaldamage(objweapon, smeansofdeath) && victim scripts\mp\utility\perk::_hasperk("specialty_stun_resistance"))
      _id_CDCEDB142F61B43E = "hittacresist";
    else if(victim scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(eattacker, victim, objweapon, smeansofdeath, einflictor, shitloc))
      _id_CDCEDB142F61B43E = "hitblastshield";
    else if(istrue(victim.adrenalinepoweractive))
      _id_CDCEDB142F61B43E = "hitadrenaline";
    else if(isDefined(objweapon) && objweapon.basename == "sound_veil_mp")
      _id_CDCEDB142F61B43E = "hitsoundveil";
    else if(getdvarint("dvar_1DB87C3B655B5645", 0) == 1)
      _id_CDCEDB142F61B43E = "hithealth";

    _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(smeansofdeath);
    _id_B98146816886D3C4 = scripts\engine\utility::ter_op(_id_A3192D2F80ED4FF8 && scripts\mp\utility\weapon::isprimaryweapon(objweapon), "standardspread", "standard");

    if(istrue(level._id_3FF7C73209FCF59D)) {
      if(_id_A3192D2F80ED4FF8 && istrue(victim._id_38841D8E75A06AB3) || isexplosivedamagemod(smeansofdeath) && istrue(victim._id_CE34E72182B33556))
        _id_CDCEDB142F61B43E = "hitskydiveprotection";
    }

    armorbreak = 0;

    if(_id_CDCEDB142F61B43E == "hitarmorlightbreak" || _id_CDCEDB142F61B43E == "hitarmormaxplatebreak" || _id_CDCEDB142F61B43E == "hitarmortemperedbreak") {
      armorbreak = 1;

      if(_id_A2FFD9894FD368C5) {
        _id_B98146816886D3C4 = "temperedarmorbreak";

        if(istrue(_id_B44E627D6A911F55) && !istrue(_id_135003274A4CC703))
          _id_B98146816886D3C4 = scripts\engine\utility::ter_op(_id_B98146816886D3C4 == "standardspread", "standardspreadarmorbreak", "standardarmorbreak");
      } else if(_id_DC726E8CC0B003A3) {
        _id_B98146816886D3C4 = "threeplatearmorbreak";

        if(istrue(_id_B44E627D6A911F55) && !istrue(_id_135003274A4CC703))
          _id_B98146816886D3C4 = scripts\engine\utility::ter_op(_id_B98146816886D3C4 == "standardspread", "standardspreadarmorbreak", "standardarmorbreak");
      } else if(_id_B98146816886D3C4 == "standardspread")
        _id_B98146816886D3C4 = "standardspreadarmorbreak";
      else
        _id_B98146816886D3C4 = "standardarmorbreak";
    } else if(_id_CDCEDB142F61B43E == "hitarmorlight" || _id_CDCEDB142F61B43E == "hitarmorlightmaxlevel" || _id_CDCEDB142F61B43E == "hitarmorlighttempered") {
      if(_id_A2FFD9894FD368C5) {
        _id_B98146816886D3C4 = "temperedarmor";

        if(istrue(_id_B44E627D6A911F55) && !istrue(_id_135003274A4CC703))
          _id_B98146816886D3C4 = scripts\engine\utility::ter_op(_id_B98146816886D3C4 == "standardspread", "standardspreadarmor", "standardarmor");
      } else if(_id_DC726E8CC0B003A3) {
        _id_B98146816886D3C4 = "threeplatearmor";

        if(istrue(_id_B44E627D6A911F55) && !istrue(_id_135003274A4CC703))
          _id_B98146816886D3C4 = scripts\engine\utility::ter_op(_id_B98146816886D3C4 == "standardspread", "standardspreadarmor", "standardarmor");
      } else if(_id_B98146816886D3C4 == "standardspread")
        _id_B98146816886D3C4 = "standardspreadarmor";
      else
        _id_B98146816886D3C4 = "standardarmor";
    } else if(_id_CDCEDB142F61B43E == "hitblastshield" && victim scripts\mp\utility\perk::_hasperk("specialty_flak_jacket"))
      _id_B98146816886D3C4 = "hitflakjacket";

    headshot = !_id_2669878CF5A1B6BC::isspreadweapon(objweapon) && scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);

    if(scripts\mp\utility\weapon::_id_160A992C78BDF589(objweapon) && scripts\cp_mp\utility\damage_utility::_id_B656251147D7D40B(partname))
      headshot = 1;

    if(eattacker scripts\mp\utility\perk::_hasperk("specialty_headhunter") && headshot)
      _id_CDCEDB142F61B43E = "hitheadhunter";

    _id_14B8F2EEBA6A3E78 = 1;
    _id_62CF84636D4CEF2C = smeansofdeath == "MOD_MELEE";
    _id_BDA9C6703DCFCC16 = "" + victim getentitynumber();

    if(_id_4FFE32F42D51A763 && isDefined(victim.body))
      _id_249FCA7089CD498F = victim.body getentitynumber();
    else
      _id_249FCA7089CD498F = victim getentitynumber();

    _id_65CB04EE667315BC = 0;

    if(!armorbreak && _id_2669878CF5A1B6BC::isspreadweapon(objweapon) && isDefined(_id_91EBB035A259E76A.pelletweaponvictimids)) {
      foreach(_id_4663BFAED1A30EC9 in _id_91EBB035A259E76A.pelletweaponvictimids) {
        if(isDefined(_id_4663BFAED1A30EC9[_id_BDA9C6703DCFCC16]) && _id_4663BFAED1A30EC9[_id_BDA9C6703DCFCC16].pelletdmgpassed.size > 1)
          _id_65CB04EE667315BC = 1;
      }
    }

    if(!_id_62CF84636D4CEF2C && _id_65CB04EE667315BC) {
      if(_id_4FFE32F42D51A763 || armorbreak)
        _id_62CF84636D4CEF2C = 1;
      else
        _id_14B8F2EEBA6A3E78 = 0;
    }

    if(_id_14B8F2EEBA6A3E78) {
      _id_F7EA2887B1E3535B = _id_07C40FA80892A721::_id_77B7145C92102847(victim _id_07C40FA80892A721::_id_AC266FC218266D08() + _id_1DA1A66B5C6A06A7);
      _id_91EBB035A259E76A _id_5762AC2F22202BA2::updatedamagefeedback(_id_CDCEDB142F61B43E, _id_4FFE32F42D51A763, headshot, _id_B98146816886D3C4, _id_62CF84636D4CEF2C, undefined, _id_249FCA7089CD498F, _id_F7EA2887B1E3535B);
    }
  }
}

_id_43B6FEFD9C0E079F() {
  victim = self;
  victim endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(level.brgametype._id_DBB3B2958AF5562B)) {
    return;
  }
  victim notify("start_damage_reduction_visual");
  victim endon("start_damage_reduction_visual");
  victim setclientomnvar("ui_br_zombie_damage_taken_reduced", 1);
  wait(level.brgametype._id_DBB3B2958AF5562B);
  victim setclientomnvar("ui_br_zombie_damage_taken_reduced", 0);
}

_id_18525950B3CABA30(idamage, eattacker, smeansofdeath, vpoint, _id_1DA1A66B5C6A06A7, objweapon) {
  _id_6A5D3BF7A5B7064A::damageeffects(idamage, eattacker, smeansofdeath, vpoint, _id_1DA1A66B5C6A06A7, objweapon);
}

lethalequipmentdamagemod(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon) {
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, undefined, undefined, undefined, undefined, undefined, idflags);

  if(isDefined(einflictor) && isDefined(einflictor.damagedby))
    eattacker = einflictor.damagedby;

  if(victim scripts\cp_mp\utility\damage_utility::isstuckdamagekill(data)) {
    if(victim scripts\mp\utility\killstreak::isjuggernaut())
      idamage = min(300, idamage);
    else
      idamage = victim.maxhealth;
  }

  if(isDefined(smeansofdeath) && smeansofdeath != "MOD_IMPACT") {
    if(victim != eattacker && isDefined(einflictor) && isDefined(einflictor.classname) && einflictor.classname == "grenade" && victim.lastspawntime + 3500 > gettime() && isDefined(victim.lastspawnpoint) && distance(einflictor.origin, victim.lastspawnpoint.origin) < 500)
      idamage = 0;
  }

  if(isPlayer(eattacker)) {
    loggrenadedata(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon);
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.weaponname = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
    _id_7E2C53B0BCF117D9.fullweaponname = getcompleteweaponname(objweapon);
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "damage";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = min(victim.health, idamage);
    _id_7E2C53B0BCF117D9.variantid = -1;
    _id_7E2C53B0BCF117D9.weaponobj = objweapon;
    eattacker _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  return idamage;
}

playerkilled_initdeathdata(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath) {
  _id_642470E1ABC1BBF9 = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, undefined, direction_vec, undefined, undefined, undefined, undefined, damageflags);
  _id_642470E1ABC1BBF9.hitloc = hitloc;
  _id_642470E1ABC1BBF9.psoffsettime = psoffsettime;
  _id_642470E1ABC1BBF9.deathanimduration = deathanimduration;
  _id_642470E1ABC1BBF9.isfauxdeath = isfauxdeath;

  if(meansofdeath == "MOD_EXECUTION")
    _id_642470E1ABC1BBF9.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(attacker);

  _id_642470E1ABC1BBF9.dokillcam = 0;
  _id_642470E1ABC1BBF9.dofinalkillcam = 1;
  _id_642470E1ABC1BBF9.killcamentity = undefined;
  _id_642470E1ABC1BBF9.killcamentityindex = -1;
  _id_642470E1ABC1BBF9.killcamentitystarttime = 0;
  _id_642470E1ABC1BBF9.inflictoragentinfo = undefined;
  _id_642470E1ABC1BBF9.killcamentstickstovictim = undefined;
  _id_642470E1ABC1BBF9.isfriendlyfire = undefined;
  _id_642470E1ABC1BBF9.primaryweapon = undefined;
  _id_642470E1ABC1BBF9.lifeid = undefined;
  _id_642470E1ABC1BBF9.attackerentnum = undefined;
  _id_642470E1ABC1BBF9.iskillstreakweapon = undefined;
  _id_642470E1ABC1BBF9._id_BFCDEBEE0E8A3189 = undefined;
  _id_642470E1ABC1BBF9.weaponfullstring = undefined;
  _id_642470E1ABC1BBF9.isnukekill = 0;
  _id_642470E1ABC1BBF9.deathscenetimesec = getdvarfloat("scr_death_scene_time", 1.75);
  _id_642470E1ABC1BBF9.deathscenetimems = int(_id_642470E1ABC1BBF9.deathscenetimesec * 1000);
  _id_642470E1ABC1BBF9.deathtime = gettime();
  _id_642470E1ABC1BBF9.brvictiminlaststand = undefined;
  _id_642470E1ABC1BBF9._id_F83C15ACB64C91B7 = isDefined(victim) && istrue(victim._id_F83C15ACB64C91B7);
  return _id_642470E1ABC1BBF9;
}

playerkilled_parameterfixup(_id_642470E1ABC1BBF9) {
  if(isDefined(_id_642470E1ABC1BBF9.inflictor) && istrue(_id_642470E1ABC1BBF9.inflictor._id_26FB072855FD4772)) {
    _id_642470E1ABC1BBF9.meansofdeath = "MOD_CRUSH";
    _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.inflictor;
    _id_642470E1ABC1BBF9.attacker.team = scripts\mp\utility\game::getotherteam(_id_642470E1ABC1BBF9.victim.team)[0];
  }

  if(_id_642470E1ABC1BBF9.victim == _id_642470E1ABC1BBF9.attacker && _id_642470E1ABC1BBF9.meansofdeath == "MOD_CRUSH")
    _id_642470E1ABC1BBF9.meansofdeath = "MOD_SUICIDE";

  if(_id_642470E1ABC1BBF9.objweapon.basename == "none") {
    if(isDefined(_id_642470E1ABC1BBF9.inflictor) && isDefined(_id_642470E1ABC1BBF9.inflictor.baseweapon))
      _id_642470E1ABC1BBF9.objweapon.basename = _id_642470E1ABC1BBF9.inflictor.baseweapon;
  }

  _id_642470E1ABC1BBF9.victim playerkilled_fixupattacker(_id_642470E1ABC1BBF9);

  if(scripts\cp_mp\utility\damage_utility::isheadshot(_id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.attacker))
    _id_642470E1ABC1BBF9.meansofdeath = "MOD_HEAD_SHOT";

  if(_id_642470E1ABC1BBF9.isfauxdeath) {
    _id_642470E1ABC1BBF9.dokillcam = 0;
    _id_642470E1ABC1BBF9.deathanimduration = _id_642470E1ABC1BBF9.victim playerforcedeathanim(_id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.direction_vec);
  }
}

playerkilled_fixupattacker(_id_642470E1ABC1BBF9) {
  _id_642470E1ABC1BBF9.attacker = scripts\mp\utility\damage::_validateattacker(_id_642470E1ABC1BBF9.attacker);

  if(isDefined(_id_642470E1ABC1BBF9.inflictor) && istrue(_id_642470E1ABC1BBF9.inflictor._id_26FB072855FD4772)) {
    if(isDefined(level._id_B6E3760A75368EFC))
      _id_642470E1ABC1BBF9.attacker = [[level._id_B6E3760A75368EFC]](_id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.victim);
  }

  assistedsuicide = 0;

  if(!isDefined(_id_642470E1ABC1BBF9.attacker))
    assistedsuicide = 1;
  else if(isDefined(_id_642470E1ABC1BBF9.attacker.classname) && (_id_642470E1ABC1BBF9.attacker.classname == "trigger_hurt" || _id_642470E1ABC1BBF9.attacker.classname == "worldspawn"))
    assistedsuicide = 1;
  else if(_id_642470E1ABC1BBF9.attacker == _id_642470E1ABC1BBF9.victim) {
    assistedsuicide = 1;

    if(_id_642470E1ABC1BBF9.meansofdeath == "MOD_SUICIDE")
      logattacker(_id_642470E1ABC1BBF9.victim, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.damage, undefined, undefined, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.psoffsettime, _id_642470E1ABC1BBF9.meansofdeath, 0);
  }

  if(assistedsuicide) {
    bestplayer = undefined;

    if(isDefined(_id_642470E1ABC1BBF9.victim.attackers) && self.attackers.size > 0) {
      foreach(player in _id_642470E1ABC1BBF9.victim.attackers) {
        if(!isDefined(player)) {
          continue;
        }
        if(!isDefined(_id_642470E1ABC1BBF9.victim)) {
          continue;
        }
        if(!isDefined(scripts\mp\utility\damage::_validateattacker(player))) {
          continue;
        }
        if(!isDefined(_id_642470E1ABC1BBF9.victim.attackerdata)) {
          continue;
        }
        if(!isDefined(_id_642470E1ABC1BBF9.victim.attackerdata[player.guid])) {
          continue;
        }
        if(!isDefined(_id_642470E1ABC1BBF9.victim.attackerdata[player.guid].damage)) {
          continue;
        }
        if(player == _id_642470E1ABC1BBF9.victim || level.teambased && player.team == _id_642470E1ABC1BBF9.victim.team) {
          continue;
        }
        if(_id_642470E1ABC1BBF9.victim.attackerdata[player.guid].damage > 1 && !isDefined(bestplayer)) {
          bestplayer = player;
          continue;
        }

        if(isDefined(bestplayer) && _id_642470E1ABC1BBF9.victim.attackerdata[player.guid].damage > _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].damage)
          bestplayer = player;
      }
    }

    if(!isDefined(bestplayer)) {
      if(isDefined(_id_642470E1ABC1BBF9.victim.debuffedbyplayers) && _id_642470E1ABC1BBF9.victim.debuffedbyplayers.size > 0) {
        _id_0F6F171FA9C145F8 = ["chargemode_mp", "cryo_mine_mp", "concussion_grenade_mp", "super_trophy_mp", "blackout_grenade_mp", "power_spider_grenade_mp", "emp_grenade_mp"];

        foreach(id, _id_065928E4C6195A5B in _id_0F6F171FA9C145F8) {
          _id_A676DF5D3D80A259 = scripts\mp\gamescore::getdebuffattackersbyweapon(_id_642470E1ABC1BBF9.victim, _id_065928E4C6195A5B);

          if(_id_A676DF5D3D80A259.size > 0) {
            for(_id_AC0E594AC96AA3A8 = _id_A676DF5D3D80A259.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
              _id_E0573162D646B530 = _id_A676DF5D3D80A259[_id_AC0E594AC96AA3A8];

              if(!isDefined(scripts\mp\utility\damage::_validateattacker(_id_E0573162D646B530))) {
                continue;
              }
              if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(_id_E0573162D646B530, _id_642470E1ABC1BBF9.victim))) {
                continue;
              }
              bestplayer = _id_E0573162D646B530;

              if(!isDefined(_id_642470E1ABC1BBF9.victim.attackerdata) || !isDefined(_id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid]))
                addattacker(_id_642470E1ABC1BBF9.victim, bestplayer, undefined, makeweapon(_id_065928E4C6195A5B), 0, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE");

              break;
            }
          }

          if(isDefined(bestplayer)) {
            break;
          }
        }
      }
    }

    if(isDefined(bestplayer)) {
      _id_642470E1ABC1BBF9.attacker = bestplayer;
      _id_642470E1ABC1BBF9.attacker.assistedsuicide = 1;
      _id_642470E1ABC1BBF9.objweapon = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].objweapon;
      _id_642470E1ABC1BBF9.direction_vec = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].vdir;
      _id_642470E1ABC1BBF9.hitloc = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].shitloc;
      _id_642470E1ABC1BBF9.psoffsettime = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].psoffsettime;
      _id_642470E1ABC1BBF9.meansofdeath = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].smeansofdeath;
      _id_642470E1ABC1BBF9.damage = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].damage;

      if(istrue(_id_642470E1ABC1BBF9.victim.squadwiped) && isDefined(_id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].inflictor))
        _id_642470E1ABC1BBF9.inflictor = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].inflictor;

      _id_642470E1ABC1BBF9.assistedsuicide = 1;
    } else if(!isDefined(_id_642470E1ABC1BBF9.attacker.team) || _id_642470E1ABC1BBF9.attacker.team == "neutral")
      _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.victim;
  }

  if(isDefined(_id_642470E1ABC1BBF9.attacker) && isDefined(_id_642470E1ABC1BBF9.attacker.code_classname)) {
    if(_id_642470E1ABC1BBF9.attacker.code_classname == "script_vehicle" && isDefined(_id_642470E1ABC1BBF9.attacker.owner))
      _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.attacker.owner;

    if(_id_642470E1ABC1BBF9.attacker.code_classname == "misc_turret" && isDefined(_id_642470E1ABC1BBF9.attacker.owner)) {
      if(isDefined(_id_642470E1ABC1BBF9.attacker.vehicle))
        _id_642470E1ABC1BBF9.attacker.vehicle notify("killedPlayer", _id_642470E1ABC1BBF9.victim);

      _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.attacker.owner;
    }

    if(isagent(_id_642470E1ABC1BBF9.attacker)) {
      if(isDefined(_id_642470E1ABC1BBF9.attacker.owner))
        _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.attacker.owner;
    }

    if(_id_642470E1ABC1BBF9.attacker.code_classname == "script_model" && isDefined(_id_642470E1ABC1BBF9.attacker.owner)) {
      _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.attacker.owner;

      if(!isfriendlyfire(_id_642470E1ABC1BBF9.victim, _id_642470E1ABC1BBF9.attacker) && _id_642470E1ABC1BBF9.attacker != _id_642470E1ABC1BBF9.victim)
        _id_642470E1ABC1BBF9.attacker notify("crushed_enemy");
    }
  }

  if(isDefined(_id_642470E1ABC1BBF9.inflictor) && !isPlayer(_id_642470E1ABC1BBF9.inflictor)) {
    if(!isDefined(_id_642470E1ABC1BBF9.attacker)) {
      if(isDefined(_id_642470E1ABC1BBF9.inflictor.owner))
        _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.inflictor.owner;
    } else if(!isPlayer(_id_642470E1ABC1BBF9.attacker)) {
      if(isDefined(_id_642470E1ABC1BBF9.inflictor.owner))
        _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.inflictor.owner;
    }
  }

  if(isDefined(_id_642470E1ABC1BBF9.attacker) && _id_642470E1ABC1BBF9.attacker != _id_642470E1ABC1BBF9.victim) {
    if(isDefined(_id_642470E1ABC1BBF9.inflictor) && _id_642470E1ABC1BBF9.inflictor == _id_642470E1ABC1BBF9.victim)
      _id_642470E1ABC1BBF9.inflictor = _id_642470E1ABC1BBF9.attacker;
  }

  if(isDefined(_id_642470E1ABC1BBF9.inflictor) && isDefined(_id_642470E1ABC1BBF9.inflictor._id_9328DED553F15D2B) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(_id_642470E1ABC1BBF9.victim, _id_642470E1ABC1BBF9.inflictor._id_9328DED553F15D2B)))
    _id_642470E1ABC1BBF9.attacker = self;

  _id_642470E1ABC1BBF9.attacker.assistedsuicide = 0;
}

playerkilled_precalc(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  objweapon = _id_642470E1ABC1BBF9.objweapon;
  victim.perkoutlined = 0;
  victim.deathspectatepos = undefined;
  victim.deathtime = _id_642470E1ABC1BBF9.deathtime;
  victim.attacker = attacker;
  victim.lastdeathpos = victim.origin;
  victim.lastdeathangles = victim getplayerangles();

  if(isDefined(inflictor) && !isPlayer(inflictor) && isDefined(inflictor.primaryweapon))
    _id_642470E1ABC1BBF9.primaryweapon = inflictor.primaryweapon;
  else if(isDefined(attacker) && isPlayer(attacker) && !isnullweapon(attacker getcurrentprimaryweapon()))
    _id_642470E1ABC1BBF9.primaryweapon = getcompleteweaponname(attacker getcurrentprimaryweapon());
  else if(objweapon.isalternate)
    _id_642470E1ABC1BBF9.primaryweapon = objweapon.basename;
  else
    _id_642470E1ABC1BBF9.primaryweapon = undefined;

  _id_642470E1ABC1BBF9.lifeid = victim.matchdatalifeindex;

  if(!isDefined(_id_642470E1ABC1BBF9.lifeid))
    _id_642470E1ABC1BBF9.lifeid = level.maxlives - 1;

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(attacker))
    _id_642470E1ABC1BBF9.attackerentnum = attacker getentitynumber();
  else
    _id_642470E1ABC1BBF9.attackerentnum = -1;

  _id_642470E1ABC1BBF9.iskillstreakweapon = _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename);
  _id_642470E1ABC1BBF9.weaponfullstring = getcompleteweaponname(objweapon);
  _id_642470E1ABC1BBF9._id_BFCDEBEE0E8A3189 = isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "bomb_site_mp";
  _id_642470E1ABC1BBF9.isfriendlyfire = isfriendlyfire(victim, attacker);
  _id_642470E1ABC1BBF9.isnukekill = objweapon.basename == "nuke_mp";
  _id_642470E1ABC1BBF9.brvictiminlaststand = scripts\mp\utility\player::isinlaststand(victim);
}

playerkilled_sharedlogic_early(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  objweapon = _id_642470E1ABC1BBF9.objweapon;
  damage = _id_642470E1ABC1BBF9.damage;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
  isfauxdeath = _id_642470E1ABC1BBF9.isfauxdeath;
  hitloc = _id_642470E1ABC1BBF9.hitloc;
  direction_vec = _id_642470E1ABC1BBF9.direction_vec;
  victim notify("killed_player");
  scripts\mp\outline::outlinedisableinternalall(victim);
  victim showuidamageflash();
  victim setblurforplayer(0, 0);
  victim scripts\mp\equipment\molotov::molotov_clear_fx();
  victim scripts\mp\weapons::_id_6B4A68DBDAE21499();

  if(!scripts\mp\utility\game::runleanthreadmode())
    scripts\mp\utility\print::printgameaction("death", victim);

  victim launchshield(damage, meansofdeath);
  victim scripts\mp\riotshield::riotshield_clear();

  if(isDefined(attacker.petwatch) && attacker != victim) {
    attacker scripts\cp_mp\pet_watch::addkillcharge();

    if(meansofdeath == "MOD_EXECUTION")
      attacker scripts\cp_mp\pet_watch::addexecutioncharge();
    else if(victim playerkilled_washitbyvehicle(meansofdeath, inflictor))
      attacker scripts\cp_mp\pet_watch::addvehicularmanslaughtercharge();
  }

  if(meansofdeath == "MOD_EXECUTION") {
    attacker scripts\mp\utility\stats::incpersstat("executionKills", 1);
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(attacker, "stat_197B54B4D0E467B7", undefined, 1.0);
  }

  _id_647F0CEC5589B0CA = victim getcurrentweapon();

  if(!victim _id_2669878CF5A1B6BC::iskillstreakweapon(_id_647F0CEC5589B0CA)) {
    scripts\mp\weapons::savetogglescopestates();
    scripts\mp\weapons::savealtstates();
  }

  victim scripts\mp\equipment\nvg::savenvgstate();
  scripts\mp\utility\inventory::handleweaponchangecallbacksondeath();

  if(!isfauxdeath) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(victim)) {
      if(isDefined(victim.vehicle))
        victim.vehicle notify("player_killed_no_faux_death");
    }
  } else {
    victim.fauxdead = 1;
    victim sethidenameplate(1);
    self notify("death");
    self notify("death_or_disconnect");
  }

  scripts\mp\perks\perks::updateactiveperks(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc, direction_vec);
  scripts\mp\supers::updateactivesupers(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc, direction_vec);
  scripts\mp\equipment\wristrocket::wristrocketcooksuicideexplodecheck(inflictor, attacker, victim, meansofdeath, objweapon);

  if(meansofdeath != "MOD_HEAD_SHOT" && !_id_642470E1ABC1BBF9.isnukekill) {
    if(isDefined(level.custom_death_sound))
      [[level.custom_death_sound]](victim, meansofdeath, inflictor);
    else if(meansofdeath != "MOD_MELEE")
      victim scripts\mp\utility\sound::playdeathsound(meansofdeath);
  }

  if(isDefined(level.custom_death_effect))
    [[level.custom_death_effect]](victim, meansofdeath, inflictor);

  if(meansofdeath != "MOD_SUICIDE" && (scripts\cp_mp\utility\game_utility::isaigameparticipant(victim) || scripts\cp_mp\utility\game_utility::isaigameparticipant(attacker)) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["get_attacker_ent"])) {
    _id_E2B86DD732390777 = [[level.bot_funcs["get_attacker_ent"]]](attacker, inflictor);

    if(isDefined(_id_E2B86DD732390777)) {
      if(scripts\cp_mp\utility\game_utility::isaigameparticipant(victim) && !isagent(victim))
        victim botmemoryevent("death", _id_642470E1ABC1BBF9.weaponfullstring, _id_E2B86DD732390777.origin, victim.origin, _id_E2B86DD732390777);

      if(scripts\cp_mp\utility\game_utility::isaigameparticipant(attacker) && !isagent(attacker)) {
        _id_6B82B9183BB9B5DF = 1;

        if(isDefined(_id_E2B86DD732390777.classname) && (_id_E2B86DD732390777.classname == "script_vehicle" && isDefined(_id_E2B86DD732390777.helitype) || _id_E2B86DD732390777.classname == "rocket" || _id_E2B86DD732390777.classname == "misc_turret"))
          _id_6B82B9183BB9B5DF = 0;

        if(_id_6B82B9183BB9B5DF)
          attacker botmemoryevent("kill", _id_642470E1ABC1BBF9.weaponfullstring, _id_E2B86DD732390777.origin, victim.origin, victim);
      }
    }
  }

  if((scripts\mp\utility\game::isteamreviveenabled() || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || victim scripts\mp\utility\perk::_hasperk("specialty_survivor")) && scripts\mp\flags::gameflag("prematch_done") && !istrue(victim.hvtnorevive) && istrue(victim.inlaststand))
    scripts\mp\laststand::ondeath(_id_642470E1ABC1BBF9);

  if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("prematch_done") && !istrue(victim.switching_teams)) {
    if(meansofdeath == "MOD_FALLING" && victim scripts\mp\teamrevive::isvalidrevivetriggerspawnposition())
      victim scripts\mp\teamrevive::setvalidreviveposition();

    _id_85A40249B07BE68E = istrue(self.isjuggernaut) && isDefined(self.juggcontext);

    if(isDefined(level._id_A12EC32A24E1A367))
      [[level._id_A12EC32A24E1A367]](victim);

    if(!_id_85A40249B07BE68E)
      respawnitems = victim scripts\mp\class::respawnitems_saveplayeritemstostruct();
    else
      respawnitems = self.juggcontext;

    victim scripts\mp\class::respawnitems_assignrespawnitems(respawnitems);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
      victim scripts\cp_mp\challenges::stopchallengetimer("alive_in_gas");
      victim scripts\cp_mp\challenges::stopchallengetimer("alive_not_downed");

      if(istrue(level.br_prematchstarted) && !_id_2CEDCC356F1B9FC8::isplayeringulag())
        _id_715028F54BAD19A1::branalytics_inventory_snapshot(self, "player_death");
    }
  }

  _id_87F4E7D1A685AEC1 = scripts\engine\utility::ter_op(scripts\mp\utility\killstreak::isplayerkillstreak(victim), victim.playerproxyagent, victim);

  if(attacker scripts\mp\utility\perk::_hasperk("specialty_scavenger"))
    _id_87F4E7D1A685AEC1 thread scripts\mp\weapons::dropscavengerfordeath(attacker, _id_642470E1ABC1BBF9.meansofdeath);

  _id_87F4E7D1A685AEC1[[level.weapondropfunction]](attacker, meansofdeath, undefined, damage);

  if(!isfauxdeath) {
    if(isPlayer(attacker))
      victim setclientomnvar("ui_killcam_killedby_id", attacker getentitynumber());
    else if(attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")
      victim setclientomnvar("ui_killcam_killedby_id", victim getentitynumber());
    else
      victim setclientomnvar("ui_killcam_killedby_id", -1);

    _id_9B1941CB7354665E = "dead";

    if(istrue(self._id_C4C8B91E0B16AA5E))
      _id_9B1941CB7354665E = "playing_but_spectating";
    else if(scripts\mp\utility\game::getsubgametype() == "dmz" && !istrue(level._id_291B51C7AF8D1204))
      _id_9B1941CB7354665E = "spectator";

    victim scripts\mp\utility\player::updatesessionstate(_id_9B1941CB7354665E);
  }

  _id_63C3344D9C1F9816 = istrue(victim.fauxdead) && istrue(victim.switching_teams);

  if(!_id_63C3344D9C1F9816) {
    if(!isDefined(level.modemayconsiderplayerdead) || [[level.modemayconsiderplayerdead]](victim))
      victim scripts\mp\playerlogic::removefromalivecount(undefined, "playerKilled");
  }

  if(!isDefined(victim.switching_teams)) {
    if(!istrue(level.ignorescoring) && !_id_642470E1ABC1BBF9.isfriendlyfire) {
      victim scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "deaths");

      if(victim.pers["deaths"] < 999) {
        victim scripts\mp\utility\stats::incpersstat("deaths", 1);
        victim.deaths = victim scripts\mp\utility\stats::getpersstat("deaths");
        victim scripts\mp\persistence::statsetchild("round", "deaths", victim.deaths, level.ignorekdrstats);
      }
    }
  }

  _id_4115733AAA384EEA = meansofdeath;

  if(isDefined(_id_642470E1ABC1BBF9.idflags) && _id_642470E1ABC1BBF9.idflags &level.idflags_penetration && !(_id_642470E1ABC1BBF9.idflags &level.idflags_penetration_player_only)) {
    if(isDefined(attacker.bulletkillsinaframecount) && attacker.bulletkillsinaframecount == 0) {
      _id_4115733AAA384EEA = "MOD_PENETRATION";

      if(isPlayer(attacker))
        attacker thread scripts\mp\utility\points::givexpwithtext("stat_86E6AB76A75129C7");
    }
  } else if(objweapon.basename == "semtex_xmike109_mp" && _id_642470E1ABC1BBF9.hitloc == "head" || _id_642470E1ABC1BBF9.hitloc == "helmet")
    _id_4115733AAA384EEA = "MOD_HEAD_SHOT";

  if(isDefined(_id_642470E1ABC1BBF9.inflictor) && istrue(_id_642470E1ABC1BBF9.inflictor.iswztrain))
    _id_4115733AAA384EEA = "MOD_CRUSH";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_F86DA5D91524E369 = [];

    if(isDefined(level._id_C5877DBE60FDDBF6))
      _id_F86DA5D91524E369 = level._id_C5877DBE60FDDBF6;

    if(isDefined(victim)) {
      victimteam = scripts\mp\utility\teams::getfriendlyplayers(victim.team, 0);

      if(isDefined(victimteam))
        _id_F86DA5D91524E369 = scripts\engine\utility::array_combine(_id_F86DA5D91524E369, victimteam);
    }

    if(isDefined(attacker) && isPlayer(attacker)) {
      attackerteam = scripts\mp\utility\teams::getfriendlyplayers(attacker.team, 0);

      if(isDefined(attackerteam) && victim.team != attacker.team)
        _id_F86DA5D91524E369 = scripts\engine\utility::array_combine(_id_F86DA5D91524E369, attackerteam);
    }

    if(_id_F86DA5D91524E369.size > 0) {
      _id_D7F5EF4A14230875 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::_id_4687F4DA72911323(_id_642470E1ABC1BBF9), "MOD_EXPLOSIVE", _id_4115733AAA384EEA);
      obituary(victim, attacker, objweapon, _id_D7F5EF4A14230875, _id_F86DA5D91524E369);
    }
  } else {
    _id_AAE3F6AFD894E63A = objweapon;

    if(isDefined(_id_4115733AAA384EEA) && _id_4115733AAA384EEA == "MOD_EXPLOSIVE" && (!isDefined(_id_AAE3F6AFD894E63A) || isnullweapon(_id_AAE3F6AFD894E63A)))
      _id_AAE3F6AFD894E63A = makeweapon("obit_explosive");

    _id_D7F5EF4A14230875 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::_id_4687F4DA72911323(_id_642470E1ABC1BBF9), "MOD_EXPLOSIVE", _id_4115733AAA384EEA);
    obituary(victim, attacker, _id_AAE3F6AFD894E63A, _id_D7F5EF4A14230875);
  }

  victim updatedeathdetails(victim.attackers, victim.attackerdata, attacker);
  victim.lastbounty = scripts\mp\bounty::playergetbountypoints();
  victim scripts\mp\bounty::playerresetbountypoints();
  victim scripts\mp\bounty::playerresetbountystreak();
  victim thread scripts\mp\supers::handledeath(attacker);
  victim scripts\mp\battlechatter_mp::onplayerkilled(inflictor, attacker, damage, meansofdeath, objweapon, _id_642470E1ABC1BBF9.direction_vec, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.psoffsettime, _id_642470E1ABC1BBF9.deathanimduration, _id_642470E1ABC1BBF9.lifeid);
  victim thread[[level.onplayerkilledcommon]](inflictor, attacker, damage, meansofdeath, objweapon, _id_642470E1ABC1BBF9.direction_vec, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.psoffsettime, _id_642470E1ABC1BBF9.deathanimduration, _id_642470E1ABC1BBF9.lifeid, _id_2669878CF5A1B6BC::iskillstreakweapon(_id_647F0CEC5589B0CA));

  if(isai(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_killed"]))
    victim thread[[level.bot_funcs["on_killed"]]](inflictor, attacker, damage, meansofdeath, _id_642470E1ABC1BBF9.weaponfullstring, _id_642470E1ABC1BBF9.direction_vec, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.psoffsettime, _id_642470E1ABC1BBF9.deathanimduration, _id_642470E1ABC1BBF9.lifeid);

  _id_D34B50843AA65C42 = (_id_642470E1ABC1BBF9.deathtime - victim.spawntime) / 1000;

  if(isDefined(victim.pers["shortestLife"])) {
    if(victim.pers["shortestLife"] == 0 || _id_D34B50843AA65C42 < victim.pers["shortestLife"])
      victim.pers["shortestLife"] = _id_D34B50843AA65C42;
  }

  if(isDefined(victim.pers["shortestLife"])) {
    if(victim.pers["longestLife"] == 0 || _id_D34B50843AA65C42 > victim.pers["longestLife"])
      victim.pers["longestLife"] = _id_D34B50843AA65C42;
  }

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    _id_16C2D930984F2FEF = self isreloading();

    if(_id_16C2D930984F2FEF) {
      _id_5814D27874B48E54 = spawnStruct();
      _id_5814D27874B48E54.player = self;
      _id_5814D27874B48E54._id_C739BA1EB6635B73 = getsystemtimeinmicroseconds();
      _id_5814D27874B48E54._id_C198F7CA473378FB = "DEATH";
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_reload_cancel", _id_5814D27874B48E54);
    }

    if(isDefined(attacker) && isDefined(attacker.team))
      level notify("kill_player_" + attacker.team, attacker, victim);
  }
}

playerkilled_logkill(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  objweapon = _id_642470E1ABC1BBF9.objweapon;
  weaponfullstring = _id_642470E1ABC1BBF9.weaponfullstring;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
  lifeid = _id_642470E1ABC1BBF9.lifeid;
  victim scripts\common\utility::trycall(level.clientmatchdata_logplayerdeath, attacker);
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_player_death", _id_642470E1ABC1BBF9);
  victim scripts\mp\analyticslog::logevent_path();
  victim scripts\mp\analyticslog::logevent_playerdeath(attacker, meansofdeath, weaponfullstring);

  if(isDefined(attacker) && isPlayer(attacker))
    attacker scripts\mp\analyticslog::logevent_playerkill(victim, meansofdeath, weaponfullstring);

  if(isPlayer(attacker) && attacker != self && (!level.teambased || level.teambased && self.team != attacker.team)) {
    _id_D4B54DC4008C298C = victim.lastdroppableweaponobj;

    if(isDefined(_id_D4B54DC4008C298C) && isDefined(inflictor)) {
      _id_D4B54DC4008C298C = scripts\mp\utility\weapon::mapweapon(_id_D4B54DC4008C298C, inflictor);
      _id_B2B6CAFCDB2218D2 = getcompleteweaponname(_id_D4B54DC4008C298C);

      if(_id_B2B6CAFCDB2218D2.size > 0 && meansofdeath.size > 0)
        thread scripts\mp\gamelogic::trackleaderboarddeathstats(attacker, victim, _id_B2B6CAFCDB2218D2, meansofdeath);
    }

    if(weaponfullstring.size > 0 && meansofdeath.size > 0)
      thread scripts\mp\gamelogic::trackattackerleaderboarddeathstats(attacker, victim, weaponfullstring, meansofdeath);
  } else if(isagent(attacker) && attacker != self && (!level.teambased || level.teambased && self.team != attacker.team)) {
    _id_D4B54DC4008C298C = victim.lastdroppableweaponobj;
    _id_D4B54DC4008C298C = scripts\mp\utility\weapon::mapweapon(_id_D4B54DC4008C298C, inflictor);
    _id_B2B6CAFCDB2218D2 = getcompleteweaponname(_id_D4B54DC4008C298C);
    victim thread scripts\mp\gamelogic::threadedsetweaponstatbyname(_id_B2B6CAFCDB2218D2, 1, "deaths", attacker);
  }

  if(isDefined(level.matchrecording_logeventmsg) && isDefined(inflictor) && isPlayer(inflictor) && scripts\engine\utility::isbulletdamage(meansofdeath)) {
    _id_B450825C6BF90C22 = inflictor.origin - victim.origin;
    _id_A25E56F3AB389DBC = vectorNormalize((_id_B450825C6BF90C22[0], _id_B450825C6BF90C22[1], 0));
    _id_C81FBF4D8B796013 = anglesToForward(victim.angles);
    _id_71082DE84D50D735 = vectorNormalize((_id_C81FBF4D8B796013[0], _id_C81FBF4D8B796013[1], 0));
    _id_EEC27AFB6560632A = clamp(_id_71082DE84D50D735[0] * _id_A25E56F3AB389DBC[0] + _id_71082DE84D50D735[1] * _id_A25E56F3AB389DBC[1], -1.0, 1.0);
    angle = acos(_id_EEC27AFB6560632A);

    if(!isDefined(victim.sidekillcount))
      victim.sidekillcount = 0;

    if(angle > 75.0)
      victim.sidekillcount++;

    engagementtime = 0.0;

    if(isDefined(victim.engagementstarttime))
      engagementtime = gettime() - victim.engagementstarttime;

    if(!isDefined(victim.engagementtime)) {
      victim.engagementtime = 0;
      victim.engagementcount = 0;
    }

    victim.engagementtime = victim.engagementtime + engagementtime;
    victim.engagementcount++;
    victim.engagementstarttime = undefined;
  }

  updatecombatrecordkillstats(attacker, victim, meansofdeath, objweapon);
}

playerkilled_finddeathtype(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;

  if(victim isswitchingteams())
    return "deathType_switchingTeams";
  else if(!isPlayer(attacker) || isPlayer(attacker) && meansofdeath == "MOD_FALLING")
    return "deathType_worldDeath";
  else if(attacker == victim || !scripts\cp_mp\utility\player_utility::playersareenemies(attacker, victim) && scripts\mp\utility\entity::isdronepackage(inflictor))
    return "deathType_suicide";
  else if(_id_642470E1ABC1BBF9.isfriendlyfire && !_id_642470E1ABC1BBF9.isnukekill)
    return "deathType_friendlyFire";
  else if(istrue(victim.inlaststand))
    return "deathType_inLastStand";
  else
    return "deathType_normal";
}

playerkilled_handledeathtype(_id_642470E1ABC1BBF9) {
  victim = _id_642470E1ABC1BBF9.victim;
  _id_642470E1ABC1BBF9.deathtype = playerkilled_finddeathtype(_id_642470E1ABC1BBF9);
  _id_656EC0ABFF30A4FF = 0;
  isfauxdeath = istrue(_id_642470E1ABC1BBF9.isfauxdeath);

  if(!isfauxdeath || getdvarint("dvar_896B182FBFA8D9DE", 0))
    victim notify("player_fatal_death");

  switch (_id_642470E1ABC1BBF9.deathtype) {
    case "deathType_switchingTeams":
      handleteamchangedeath();
      break;
    case "deathType_worldDeath":
      handleworlddeath(_id_642470E1ABC1BBF9, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.lifeid, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.hitloc);
      break;
    case "deathType_suicide":
      _id_656EC0ABFF30A4FF = 1;
      handlesuicidedeath(_id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.hitloc);
      break;
    case "deathType_friendlyFire":
      handlefriendlyfiredeath(_id_642470E1ABC1BBF9);
      break;
    case "deathType_inLastStand":
      handleinlaststanddeath(_id_642470E1ABC1BBF9);
      break;
    case "deathType_normal":
      handlenormaldeath(_id_642470E1ABC1BBF9.lifeid, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.meansofdeath, victim, _id_642470E1ABC1BBF9.iskillstreakweapon, _id_642470E1ABC1BBF9);
      break;
    default:
      break;
  }

  if(!scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() || isbot(_id_642470E1ABC1BBF9.attacker) && !_id_656EC0ABFF30A4FF)
    _id_8BE77B53BCBD6D2D(_id_642470E1ABC1BBF9.attacker, 0);
}

playerkilled_sharedlogic_late(_id_642470E1ABC1BBF9) {
  playerkilled_handlecorpse(_id_642470E1ABC1BBF9);
  scripts\mp\outofbounds::clearoob(self, 1);
  setdeathtimerlength(_id_642470E1ABC1BBF9);
  attacker = _id_642470E1ABC1BBF9.attacker;

  if(isDefined(attacker.owner))
    attacker = attacker.owner;

  if(!isPlayer(attacker)) {
    _id_642470E1ABC1BBF9.dokillcam = 0;
    _id_642470E1ABC1BBF9.dofinalkillcam = 0;
  }

  playerkilled_killcamsetup(_id_642470E1ABC1BBF9);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_715028F54BAD19A1::branalytics_down(_id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.victim, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.deathtype, _id_642470E1ABC1BBF9.meansofdeath);

  thread scripts\cp_mp\challenges::ondeath(_id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.damage, _id_642470E1ABC1BBF9.damageflags, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.attacker.modifiers);

  if(!scripts\mp\utility\game::runleanthreadmode() || getdvarint("dvar_EE4A7C4B0CF8C75B", 1))
    playerkilled_logkill(_id_642470E1ABC1BBF9);

  if(isDefined(level._id_0CC2C79DE99DB62C) && level._id_0CC2C79DE99DB62C) {
    scripts\mp\codcasterclientmatchdata::_id_94C8F3722D550646();
    level._id_0CC2C79DE99DB62C = 0;
  }

  _id_0CBB0697DE4C5728::_id_ECEB462B367E4B04(_id_642470E1ABC1BBF9);
  _id_4C770A9A4AD7659C::callback("player_death", _id_642470E1ABC1BBF9);

  if(_func_6B9F8406E6153597()) {
    if(isDefined(attacker) && isPlayer(attacker))
      attacker _meth_ 410078 BD7A6F4A1(1);

    if(isDefined(_id_642470E1ABC1BBF9.victim) && isPlayer(_id_642470E1ABC1BBF9.victim))
      _id_642470E1ABC1BBF9.victim _meth_ 410078 BD7A6F4A1(2);
  }
}

playerkilled_handlecorpse(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
  objweapon = _id_642470E1ABC1BBF9.objweapon;
  isfauxdeath = _id_642470E1ABC1BBF9.isfauxdeath;
  hitloc = _id_642470E1ABC1BBF9.hitloc;
  _id_F5B166094DC876C1 = 0;

  if(isDefined(victim.carryobject) && !isfauxdeath) {
    victim notify("drop_called");
    victim.carryobject thread scripts\mp\gameobjects::setdropped();
  }

  if(scripts\mp\utility\game::isteamreviveenabled() && !scripts\mp\outofbounds::isoob(self) && scripts\mp\flags::gameflag("prematch_done") && level.teambased)
    level thread scripts\mp\teamrevive::spawnrevivetrigger(victim, attacker, "new_trigger_spawned", meansofdeath);

  scripts\cp_mp\vehicles\vehicle::vehicle_playerkilledbycollision(_id_642470E1ABC1BBF9);

  if(!isDefined(self.nocorpse) && !istrue(victim.skipcorpse)) {
    if(istrue(self._id_C4C8B91E0B16AA5E))
      victim.body = victim;
    else {
      victim.body = victim cloneplayer(_id_642470E1ABC1BBF9.deathanimduration, attacker);
      victim.body.targetname = "player_corpse";
    }
  }

  if(!isDefined(self.nocorpse) && !istrue(victim.skipcorpse) && isDefined(victim.body)) {
    if(!isDefined(victim.switching_teams)) {
      if(isDefined(attacker) && isPlayer(attacker))
        thread scripts\mp\deathicons::adddeathicon(attacker, victim.body, victim, victim.team, 5.0);

      _id_E707F0032FA7B4BB = [];
      _id_B8F254D4FD3F46A2 = [];

      foreach(index, player in level.players) {
        if(isDefined(victim)) {
          if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, victim)) && player scripts\mp\utility\perk::_hasperk("specialty_kill_report")) {
            _id_E707F0032FA7B4BB[index] = player;
            continue;
          }

          if(player _meth_8420670EAFC8D391())
            _id_B8F254D4FD3F46A2[index] = player;
        }
      }

      if(_id_E707F0032FA7B4BB.size > 0 || _id_B8F254D4FD3F46A2.size > 0)
        thread scripts\mp\deathicons::addenemydeathicon(victim.body, victim, _id_E707F0032FA7B4BB, _id_B8F254D4FD3F46A2, getdvarfloat("perk_kill_report_icon_time"), 1);
    }

    if(!istrue(self._id_C4C8B91E0B16AA5E)) {
      if(_id_642470E1ABC1BBF9.isnukekill) {}

      if(_id_642470E1ABC1BBF9.isfauxdeath) {
        victim scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
        victim scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("damage::PlayerKilled_handleCorpse()");
        victim setsolid(0);
      }

      victim thread _startragdoll(_id_642470E1ABC1BBF9.victim.body, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.inflictor);
    }

    victim thread callcorpsetablefuncs();

    if(!istrue(_id_642470E1ABC1BBF9.assistedsuicide)) {
      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        if(scripts\mp\utility\game::getsubgametype() == "dmz" && istrue(self._id_C4C8B91E0B16AA5E))
          _id_F5B166094DC876C1 = 1;
        else if(isDefined(level._id_DBBD13CC9AD757C1))
          _id_F5B166094DC876C1 = !istrue(_id_14D3930854CB398C::_id_BFDFD3C9BA0CC7CB(victim));
        else
          _id_F5B166094DC876C1 = 1;
      } else
        _id_F5B166094DC876C1 = 1;
    }

    if(istrue(_id_F5B166094DC876C1))
      victim _id_0CBB0697DE4C5728::_id_1DD3A521EA9ECF27(attacker, objweapon, meansofdeath, hitloc, inflictor, _id_642470E1ABC1BBF9.executionref);
  } else if(!istrue(self._id_C4C8B91E0B16AA5E)) {
    if(isDefined(victim.nocorpse) && !istrue(victim.skipcorpse)) {
      victim.body = victim cloneplayer(_id_642470E1ABC1BBF9.deathanimduration);
      victim.body hide(1);
    }
  }

  if(!istrue(game["isLaunchChunk"])) {
    victim.streaktype = scripts\mp\class::loadout_getplayerstreaktype(victim.streaktype);

    if(scripts\mp\killstreaks\killstreaks::streaktyperesetsondeath(victim.streaktype)) {
      if(!level.casualscorestreaks && !victim scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
        victim scripts\mp\killstreaks\killstreaks::resetstreakpoints();
        victim scripts\mp\killstreaks\killstreaks::resetstreakavailability();
      } else if(level.casualscorestreaks) {
        _id_885AD6B3C9D47759 = scripts\mp\killstreaks\killstreaks::checkcasualstreaksreset();

        if(_id_885AD6B3C9D47759) {
          victim scripts\mp\killstreaks\killstreaks::resetstreakpoints();
          victim scripts\mp\killstreaks\killstreaks::resetstreakavailability();
        }
      }
    }
  }
}

_startragdoll(corpse, meansofdeath, inflictor) {
  if(!isDefined(corpse)) {
    return;
  }
  corpse endon("death");
  deathanim = corpse getcorpseanim();
  animduration = 0.0;

  if(animisleaf(deathanim))
    animduration = getanimlength(deathanim);

  _id_98125A9AD5CDA4F2 = undefined;
  vehicle = scripts\cp_mp\utility\player_utility::getvehicle();
  _id_B9E330C2BDA52FB5 = playerkilled_washitbyvehicle(meansofdeath, inflictor);
  _id_6126D8436C986BAF = undefined;
  _id_4030C4AD220257F2 = animhasnotetrack(deathanim, "delete_corpse");
  _id_41736EBFC0D6434C = animhasnotetrack(deathanim, "delete_corpse_delayed");
  noragdoll = animhasnotetrack(deathanim, "no_ragdoll");
  _id_CE8BCDF49C43B6D0 = animhasnotetrack(deathanim, "start_ragdoll");

  if(isDefined(vehicle) || isDefined(self._id_E9A71C27FEF1B65A) && isDefined(self._id_ABD157413AC4E022)) {
    if(isDefined(vehicle))
      _id_6126D8436C986BAF = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(vehicle, self);
    else {
      vehicle = self._id_ABD157413AC4E022;
      _id_6126D8436C986BAF = self._id_E9A71C27FEF1B65A;
    }

    if(noragdoll || _id_CE8BCDF49C43B6D0) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linkseatcorpse(corpse, vehicle, _id_6126D8436C986BAF);
      corpse setcorpsefalling(0);
      corpse.linktooriginandangles = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linktooriginandangles(vehicle, _id_6126D8436C986BAF);
    }

    if(_id_4030C4AD220257F2 || _id_41736EBFC0D6434C || noragdoll || _id_CE8BCDF49C43B6D0) {
      _id_F9E25038FED22BF0 = !noragdoll && !_id_CE8BCDF49C43B6D0 || isDefined(self._id_ABD157413AC4E022);
      duration = scripts\engine\utility::ter_op(_id_41736EBFC0D6434C, animduration, animduration + 3);
      thread playerkilled_deletecorpseoutofvehicle(corpse, vehicle, _id_6126D8436C986BAF, duration, _id_F9E25038FED22BF0);
    }
  }

  if(meansofdeath != "mod_execution" && !noragdoll) {
    _id_98125A9AD5CDA4F2 = 0;

    if(_id_CE8BCDF49C43B6D0 && animduration > 0.0) {
      _id_9296F7895C90C8ED = getnotetracktimes(deathanim, "start_ragdoll")[0];
      _id_98125A9AD5CDA4F2 = _id_9296F7895C90C8ED * animduration;
    }

    if(_id_B9E330C2BDA52FB5)
      _id_98125A9AD5CDA4F2 = 0;
  }

  if(isDefined(_id_98125A9AD5CDA4F2)) {
    wait(_id_98125A9AD5CDA4F2);

    if(!isDefined(corpse)) {
      return;
    }
    if(isDefined(vehicle)) {
      corpse thread _unlinkcorpsefromvehicle(vehicle, _id_6126D8436C986BAF, _id_4030C4AD220257F2, _id_41736EBFC0D6434C, _id_98125A9AD5CDA4F2, animduration);
      corpse notify("cancel_delete_corpse");
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_clearseatcorpse(corpse, vehicle, _id_6126D8436C986BAF);
    } else {
      if(!corpse isragdoll()) {
        if(_id_B9E330C2BDA52FB5)
          corpse startragdollfromvehiclehit(inflictor);
        else
          corpse startragdoll();
      }

      [_id_0B2AFBA0BE4E4E55, _id_CFF2E3774745E3DD] = _id_0CD0171313CCA081();

      if(isDefined(_id_0B2AFBA0BE4E4E55) && isDefined(_id_CFF2E3774745E3DD))
        corpse thread _id_C837DCC441A2D51B(_id_0B2AFBA0BE4E4E55, _id_CFF2E3774745E3DD);
      else
        corpse thread _donewithcorpse(_id_4030C4AD220257F2, _id_41736EBFC0D6434C, _id_98125A9AD5CDA4F2, animduration);
    }
  }
}

_donewithcorpse(_id_4030C4AD220257F2, _id_41736EBFC0D6434C, _id_98125A9AD5CDA4F2, animduration) {
  corpse = self;

  if(_id_4030C4AD220257F2 || _id_41736EBFC0D6434C) {
    deletedelay = animduration;

    if(_id_41736EBFC0D6434C)
      animduration = animduration + 3;

    if(isDefined(_id_98125A9AD5CDA4F2))
      deletedelay = deletedelay - _id_98125A9AD5CDA4F2;

    wait(deletedelay);

    if(!isDefined(corpse)) {
      return;
    }
    corpse delete();
  } else if(!scripts\mp\utility\game::isteamreviveenabled() && !isagent(self))
    corpse setplayercorpsedone();
}

_id_C837DCC441A2D51B(_id_0B2AFBA0BE4E4E55, _id_CFF2E3774745E3DD) {
  corpse = self;
  level endon("game_ended");

  if(isDefined(_id_0B2AFBA0BE4E4E55) && isDefined(_id_CFF2E3774745E3DD) && _id_CFF2E3774745E3DD > 0)
    corpse scripts\engine\utility::waittill_notify_or_timeout(_id_0B2AFBA0BE4E4E55, _id_CFF2E3774745E3DD);

  if(isDefined(corpse))
    corpse delete();
}

_id_0CD0171313CCA081() {
  player = self;

  if(istrue(player.gulag)) {
    arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(player);

    if(!isDefined(arena) || !isDefined(arena.time))
      return [undefined, undefined];
    else
      return ["corpse_manually_deleted", arena.time];
  }

  return [undefined, undefined];
}

_unlinkcorpsefromvehicle(vehicle, _id_6126D8436C986BAF, _id_4030C4AD220257F2, _id_41736EBFC0D6434C, _id_98125A9AD5CDA4F2, animduration) {
  corpse = self;
  _id_78235DCDEC40F390 = getdvarint("dvar_7C902421E1883986", 1);
  _id_14615B298620C411 = !_id_78235DCDEC40F390;
  _id_9D6E760E37BE3ED1 = getdvarint("dvar_C041B4135B55D8B7", 1);

  if(_id_78235DCDEC40F390) {
    if(!corpse isragdoll())
      corpse startragdoll(_id_9D6E760E37BE3ED1);
  }

  waittime = getdvarfloat("dvar_7D1401B6075479AC", 0.1);

  if(waittime > 0)
    wait(waittime);

  if(isDefined(corpse)) {
    if(isDefined(corpse.linktooriginandangles) && isDefined(vehicle)) {
      _id_1E2F2224127D2990 = (0, 0, 0);
      linktooriginandangles = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linktooriginandangles(vehicle, _id_6126D8436C986BAF);
      _id_1E2F2224127D2990 = linktooriginandangles.origin - corpse.linktooriginandangles.origin;
      _id_A4F5FB62BA3A113B = corpse.origin + _id_1E2F2224127D2990;
      _id_A918F1BE2147EC75 = linktooriginandangles.angles;
      corpse trajectoryupdateoriginandangles(_id_A4F5FB62BA3A113B, _id_A918F1BE2147EC75);
    }

    corpse unlink();

    if(_id_14615B298620C411)
      corpse startragdoll(_id_9D6E760E37BE3ED1);

    corpse thread _donewithcorpse(_id_4030C4AD220257F2, _id_41736EBFC0D6434C, _id_98125A9AD5CDA4F2, animduration);
  }
}

playerkilled_deletecorpseoutofvehicle(corpse, vehicle, seatid, duration, _id_F9E25038FED22BF0) {
  corpse endon("death");
  corpse endon("cancel_delete_corpse");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_assignseatcorpse(corpse, vehicle, seatid, _id_F9E25038FED22BF0);
  vehicle scripts\engine\utility::waittill_any_timeout_1(duration, "death");

  if(isDefined(corpse))
    corpse delete();
}

playerkilled_washitbyvehicle(meansofdeath, inflictor) {
  if(meansofdeath != "MOD_CRUSH")
    return 0;

  if(!isDefined(inflictor))
    return 0;

  if(!inflictor scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  return 1;
}

playerkilled_killcamsetup(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
  objweapon = _id_642470E1ABC1BBF9.objweapon;
  executionref = _id_642470E1ABC1BBF9.executionref;

  if(isDefined(attacker) && istrue(attacker.assistedsuicide) || level.teambased && isDefined(attacker) && scripts\engine\utility::is_equal(attacker.team, victim.team) || istrue(level._id_C2111AF4E4ECE485)) {
    _id_642470E1ABC1BBF9.dokillcam = 0;
    _id_642470E1ABC1BBF9.dofinalkillcam = 0;
  }

  if(!isDefined(_id_642470E1ABC1BBF9.killcamentity))
    _id_642470E1ABC1BBF9.killcamentity = victim scripts\mp\killcam::getkillcamentity(attacker, inflictor, objweapon, meansofdeath);

  if(isDefined(_id_642470E1ABC1BBF9.killcamentity)) {
    _id_642470E1ABC1BBF9.killcamentityindex = _id_642470E1ABC1BBF9.killcamentity getentitynumber();
    _id_642470E1ABC1BBF9.killcamentitystarttime = _id_642470E1ABC1BBF9.killcamentity.birthtime;

    if(!isDefined(_id_642470E1ABC1BBF9.killcamentitystarttime))
      _id_642470E1ABC1BBF9.killcamentitystarttime = 0;
  }

  if(isDefined(inflictor) && istrue(_id_642470E1ABC1BBF9.inflictor._id_26FB072855FD4772))
    _id_642470E1ABC1BBF9.dokillcam = 1;

  if(_id_642470E1ABC1BBF9.dokillcam) {
    victim scripts\mp\killcam::prekillcamnotify(attacker);

    if(isDefined(inflictor) && isagent(inflictor)) {
      _id_642470E1ABC1BBF9.inflictoragentinfo = spawnStruct();
      _id_642470E1ABC1BBF9.inflictoragentinfo.agent_type = inflictor.agent_type;
      _id_642470E1ABC1BBF9.inflictoragentinfo.lastspawntime = inflictor.lastspawntime;
    }
  }

  _id_642470E1ABC1BBF9.killcamentstickstovictim = meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_HEAD_SHOT" && isDefined(inflictor) || meansofdeath == "MOD_GRENADE" || isDefined(victim) && isDefined(victim.stuckbygrenade) && isDefined(inflictor) && victim.stuckbygrenade == inflictor || objweapon.basename == "throwingknifec4_mp";

  if(!_id_642470E1ABC1BBF9.iskillstreakweapon || _id_2669878CF5A1B6BC::_id_1A9394EB58E66A9B(objweapon))
    scripts\mp\killcam::setkillcamnormalweaponomnvars(objweapon, meansofdeath, inflictor, executionref, attacker);

  _id_ED6248B2A7A7A508 = isDefined(attacker) && isDefined(attacker.classname) && attacker.classname != "trigger_hurt" && attacker.classname != "worldspawn" && attacker != victim;

  if(level.recordfinalkillcam && _id_642470E1ABC1BBF9.dofinalkillcam) {
    if(!istrue(level.disable_killcam) && meansofdeath != "MOD_SUICIDE" && _id_ED6248B2A7A7A508)
      scripts\mp\final_killcam::recordfinalkillcam(5.0, victim, attacker, _id_642470E1ABC1BBF9.attackerentnum, inflictor, _id_642470E1ABC1BBF9.killcamentityindex, _id_642470E1ABC1BBF9.killcamentitystarttime, _id_642470E1ABC1BBF9.killcamentstickstovictim, objweapon, _id_642470E1ABC1BBF9.psoffsettime, meansofdeath);
  }
}

playerkilled_deathscene(_id_642470E1ABC1BBF9) {
  victim = _id_642470E1ABC1BBF9.victim;
  victim endon("spawned");

  if(victim scripts\mp\spawncamera::_id_581A8FC6F76D525D())
    victim scripts\mp\spawncamera::_id_CDFF2F0B5DCF3AA1();

  if(!_id_642470E1ABC1BBF9.isfauxdeath) {
    if(!isDefined(victim.respawntimerstarttime))
      victim.respawntimerstarttime = gettime() + _id_642470E1ABC1BBF9.deathscenetimems;

    wait(_id_642470E1ABC1BBF9.deathscenetimesec);

    if(_id_642470E1ABC1BBF9.dokillcam) {
      _id_E9E21D7DB272A441 = scripts\mp\final_killcam::skipkillcamduringdeathtimer(0.5);
      _id_642470E1ABC1BBF9.dokillcam = isDefined(_id_E9E21D7DB272A441) && !_id_E9E21D7DB272A441;
    }

    if(isDefined(victim)) {
      victim notify("death_delay_finished");

      if(getdvarint("dvar_8D86E6B3C30BFBF1", 1) == 1 && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        victim thread scripts\mp\playerlogic::_id_5C5F27D13E5EB129();
    }
  } else if(!isDefined(victim.respawntimerstarttime))
    victim.respawntimerstarttime = gettime();
}

playerkilled_killcam(_id_7CE346CC7A54D100) {
  _id_642470E1ABC1BBF9 = _id_7CE346CC7A54D100;

  if(!isDefined(_id_642470E1ABC1BBF9.victim)) {
    return;
  }
  deathtime = _id_642470E1ABC1BBF9.victim.deathtime;

  if(getdvarint("dvar_98F5C716D594181B", 1) && isDefined(_id_642470E1ABC1BBF9.victim.laststanddowneddata)) {
    _id_642470E1ABC1BBF9 = _id_642470E1ABC1BBF9.victim.laststanddowneddata;
    _id_642470E1ABC1BBF9.victim.laststanddowneddata = undefined;
    _id_642470E1ABC1BBF9.dokillcam = _id_7CE346CC7A54D100.dokillcam && isPlayer(_id_642470E1ABC1BBF9.attacker);
    deathtime = _id_642470E1ABC1BBF9.deathtime;
  }

  if(!isDefined(deathtime)) {
    return;
  }
  _id_642470E1ABC1BBF9.victim endon("spawned");
  victim = _id_642470E1ABC1BBF9.victim;
  attacker = _id_642470E1ABC1BBF9.attacker;
  _id_0B052F94A95993A6 = (gettime() - deathtime) / 1000;

  if(isDefined(level.modevalidatekillcam))
    [[level.modevalidatekillcam]](_id_642470E1ABC1BBF9);

  if(!istrue(victim.cancelkillcam) && _id_642470E1ABC1BBF9.dokillcam && level.killcam && game["state"] == "playing" && !victim scripts\mp\utility\player::isusingremote() && !level.showingfinalkillcam && !istrue(level._id_904AA57B8B22090C)) {
    timeuntilspawn = scripts\mp\playerlogic::timeuntilspawn(1);

    if(!isDefined(attacker) || !isDefined(attacker.pers))
      _id_2EC157FFFDE08FD7 = [];
    else {
      _id_2EC157FFFDE08FD7 = attacker.pers["loadoutPerks"];

      if(istrue(level._id_606EB45E074FF204) || istrue(level._id_9A849908E60B857C)) {
        if(isDefined(attacker._id_15F3E6DF722FB1CF) && !scripts\engine\utility::array_contains(_id_2EC157FFFDE08FD7, attacker._id_15F3E6DF722FB1CF))
          _id_2EC157FFFDE08FD7[_id_2EC157FFFDE08FD7.size] = attacker._id_15F3E6DF722FB1CF;

        if(isDefined(attacker._id_15F3E5DF722FAF9C) && !scripts\engine\utility::array_contains(_id_2EC157FFFDE08FD7, attacker._id_15F3E5DF722FAF9C))
          _id_2EC157FFFDE08FD7[_id_2EC157FFFDE08FD7.size] = attacker._id_15F3E5DF722FAF9C;
      }
    }

    if(!istrue(level.disablecopycatloadout))
      victim thread startcopycatoption(attacker);

    skippable = 1;
    victim scripts\mp\killcam::killcam(_id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.inflictoragentinfo, _id_642470E1ABC1BBF9.attackerentnum, _id_642470E1ABC1BBF9.killcamentityindex, _id_642470E1ABC1BBF9.killcamentitystarttime, undefined, _id_642470E1ABC1BBF9.killcamentstickstovictim, _id_642470E1ABC1BBF9.objweapon, _id_0B052F94A95993A6, _id_642470E1ABC1BBF9.psoffsettime, timeuntilspawn, scripts\mp\gamelogic::timeuntilroundend(), attacker, victim, _id_642470E1ABC1BBF9.meansofdeath, _id_2EC157FFFDE08FD7, skippable);

    if(isDefined(victim) && !istrue(level.disablecopycatloadout))
      victim thread stopcopycatoption();

    if(isDefined(level.onpostkillcamcallback))
      [[level.onpostkillcamcallback]]();
  }

  if(isDefined(victim))
    victim._id_7C813E50FF75BE27 = 0;
}

playerkilled_spawn(_id_642470E1ABC1BBF9) {
  victim = _id_642470E1ABC1BBF9.victim;

  if(!isDefined(victim)) {
    return;
  }
  if(isDefined(level.modeplayerkilledspawn) && [[level.modeplayerkilledspawn]](_id_642470E1ABC1BBF9, 1)) {
    return;
  }
  if(istrue(victim._id_C4C8B91E0B16AA5E)) {
    return;
  }
  victim endon("spawned");
  victim endon("disconnect");
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim resetplayervariables();
  victim resetplayeromnvarsonspawn();

  if(isDefined(attacker))
    victim.lastattacker = attacker;
  else
    victim.lastattacker = undefined;

  victim.wantsafespawn = 0;

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam) {
      victim scripts\mp\utility\player::updatesessionstate("dead");
      victim scripts\mp\utility\player::clearkillcamstate();
    }

    return;
  }

  if(scripts\mp\class::isvalidclass(victim.class))
    victim thread scripts\mp\playerlogic::spawnclient();
}

playerkilled_internal(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath) {
  victim endon("spawned");

  if(game["state"] == "postgame") {
    victim.pers["telemetry"]._id_4ECAC4D4233CECA4 = 0;
    return;
  }

  _id_642470E1ABC1BBF9 = victim playerkilled_initdeathdata(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath);
  playerkilled_parameterfixup(_id_642470E1ABC1BBF9);
  playerkilled_precalc(_id_642470E1ABC1BBF9);
  playerkilled_sharedlogic_early(_id_642470E1ABC1BBF9);
  playerkilled_handledeathtype(_id_642470E1ABC1BBF9);
  playerkilled_sharedlogic_late(_id_642470E1ABC1BBF9);
  playerkilled_deathscene(_id_642470E1ABC1BBF9);
  playerkilled_killcam(_id_642470E1ABC1BBF9);
  playerkilled_spawn(_id_642470E1ABC1BBF9);
}

isswitchingteams() {
  if(isDefined(self.switching_teams))
    return 1;

  return 0;
}

isteamswitchbalanced() {
  _id_3511C7EE351E5C90 = scripts\mp\teams::countplayers();
  _id_3511C7EE351E5C90[self.leaving_team]--;
  _id_3511C7EE351E5C90[self.joining_team]++;
  return _id_3511C7EE351E5C90[self.joining_team] - _id_3511C7EE351E5C90[self.leaving_team] < 2;
}

isfriendlyfire(victim, attacker) {
  if(!level.teambased)
    return 0;

  if(!isDefined(attacker))
    return 0;

  if(!isPlayer(attacker) && !isDefined(attacker.team))
    return 0;

  if(victim.team != attacker.team)
    return 0;

  if(victim == attacker)
    return 0;

  return 1;
}

killedself(attacker) {
  if(!isPlayer(attacker))
    return 0;

  if(attacker != self)
    return 0;

  return 1;
}

handleteamchangedeath() {
  if(!level.teambased) {
    return;
  }
  if(self.joining_team == "spectator" || !isteamswitchbalanced()) {
    scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "suicides");
    scripts\mp\utility\stats::incpersstat("suicides", 1);
  }

  if(isDefined(level.onteamchangedeath))
    [[level.onteamchangedeath]](self);
}

handleworlddeath(_id_642470E1ABC1BBF9, attacker, lifeid, smeansofdeath, shitloc) {
  victim = _id_642470E1ABC1BBF9.victim;
  victim.deathspectatepos = victim.origin;

  if(!isDefined(attacker)) {
    return;
  }
  scripts\mp\events::playerworlddeath(attacker, smeansofdeath);

  if(!isDefined(attacker.team) || attacker.team == "neutral" || attacker == victim) {
    handlesuicidedeath(smeansofdeath, shitloc);
    return;
  }

  if(level.teambased && attacker.team != self.team || !level.teambased) {
    if(isDefined(level.onnormaldeath) && (isPlayer(attacker) || isagent(attacker)) && attacker.team != "spectator" || isDefined(attacker._id_ACB55A437C3145C0)) {
      if(!level.gameended)
        [[level.onnormaldeath]](self, attacker, lifeid, smeansofdeath);
    }
  }

  if(isagent(attacker) || scripts\mp\utility\teams::_id_44A6F98CC3C0F5F4(attacker.team)) {
    _id_642470E1ABC1BBF9.dokillcam = 1;
    thread handlenormaldeath_sounds(attacker, victim, smeansofdeath);
  }
}

handlesuicidedeath(smeansofdeath, shitloc) {
  scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "suicides");
  scripts\mp\utility\stats::incpersstat("suicides", 1);
  scripts\mp\codcasterclientmatchdata::_id_5A82C337B996BAA5(6, 0);
  _id_8B35ACA16DAC0449 = scripts\mp\tweakables::gettweakablevalue("game", "suicidepointloss");
  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - _id_8B35ACA16DAC0449);

  if(scripts\mp\weapons::grenadeheldatdeath() && smeansofdeath == "MOD_SUICIDE" && shitloc == "none")
    self.lastgrenadesuicidetime = gettime();

  if(isDefined(level.onsuicidedeath))
    [[level.onsuicidedeath]](self);

  self.suicidespawndelay = 1;

  if(isDefined(self.friendlydamage))
    self.friendlyfiredeath = 1;

  thread _id_4E8BD2BD787C0DDA(smeansofdeath);
}

handlefriendlyfiredeath(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
  _id_F03E984A6FB59137 = 0;

  if(meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH") {
    _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

    if(_id_C8F4C582625F492D == "stat_084E1CB596B7E53E" || _id_C8F4C582625F492D == "stat_018BECD72BBC155B") {
      if(isDefined(victim.isonobjective) && istrue(victim.isonobjective))
        _id_F03E984A6FB59137 = 1;
    }
  } else if(istrue(_id_642470E1ABC1BBF9.iskillstreakweapon))
    _id_F03E984A6FB59137 = 1;

  if(istrue(_id_642470E1ABC1BBF9._id_BFCDEBEE0E8A3189)) {
    return;
  }
  if(_id_F03E984A6FB59137 && attacker.pers["teamkills"] < level.maxallowedteamkills) {
    return;
  }
  attacker thread scripts\mp\rank::scoreeventpopup("stat_76CF2380A7683FDC");
  attacker.pers["teamkills"] = attacker.pers["teamkills"] + 1.0;
  victim scripts\mp\codcasterclientmatchdata::_id_5A82C337B996BAA5(6, 0);

  if(scripts\mp\tweakables::gettweakablevalue("team", "teamkillpointloss")) {
    _id_8B35ACA16DAC0449 = scripts\mp\rank::getscoreinfovalue("stat_EF9582D72160F199");
    scripts\mp\gamescore::_setplayerscore(attacker, scripts\mp\gamescore::_getplayerscore(attacker) - _id_8B35ACA16DAC0449);
  }

  if(level.maxallowedteamkills < 0) {
    return;
  }
  teamkilldelay = attacker scripts\mp\playerlogic::teamkilldelay();

  if(teamkilldelay > 0) {
    attacker.pers["teamKillPunish"] = 1;
    attacker notify("team_kill_punish");

    if(attacker scripts\mp\utility\player::isusingremote())
      attacker thread scripts\mp\utility\damage::suicide_on_end_remote();
    else
      attacker thread scripts\mp\utility\damage::suicide_on_alive();
  }

  if(level.friendlyfire == 4) {
    if(!istrue(attacker.pers["hitFFLimit"]) && attacker.pers["teamkills"] >= level.maxallowedteamkills) {
      attacker.pers["hitFFLimit"] = 1;
      attacker scripts\mp\hud_message::showerrormessage("MP/FRIENDLY_FIRE_PUNISH_SWITCH");
    } else if(istrue(level._id_7D731C7DCBEFBF3D))
      attacker scripts\mp\hud_message::showerrormessage("MP/FRIENDLY_FIRE_WILL_NOT");
  }
}

handleinlaststanddeath(_id_642470E1ABC1BBF9) {
  if(!istrue(_id_642470E1ABC1BBF9.victim.disable_killcam))
    _id_642470E1ABC1BBF9.dokillcam = 1;

  if(!_id_642470E1ABC1BBF9.iskillstreakweapon)
    _id_642470E1ABC1BBF9.attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_04B2FAAEAB2B30DB", _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.victim);

  if(isDefined(self.laststandattacker))
    self.laststandattacker _id_213650502F1ED86F(_id_642470E1ABC1BBF9.victim);

  _id_24244B97C44B0386 = undefined;

  if(isDefined(self.laststandattacker) && _id_642470E1ABC1BBF9.attacker != self.laststandattacker) {
    _id_24244B97C44B0386 = 1;
    thread scripts\cp_mp\challenges::onplayerkilled(self.laststandattacker, self.laststandattacker, 0, _id_642470E1ABC1BBF9.damageflags, self.laststandmeansofdeath, self.laststandweaponobj, _id_642470E1ABC1BBF9.hitloc, self.laststandattackermodifiers);

    if(isDefined(level._id_90420335F9A84867))
      self[[level._id_90420335F9A84867]](self.laststandattacker, 0);

    self.laststandattacker thread scripts\mp\rank::scoreeventpopup("stat_E24741BA71BBB56B");
  }

  _id_B9C265F657115663 = 0;

  if(istrue(_id_24244B97C44B0386))
    _id_B9C265F657115663 = 1;

  handlenormaldeath(_id_642470E1ABC1BBF9.lifeid, _id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.meansofdeath, self, _id_642470E1ABC1BBF9.iskillstreakweapon, _id_642470E1ABC1BBF9, 1, _id_B9C265F657115663);
  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststandattackermodifiers = undefined;
}

handlenormaldeath_sounds(attacker, victim, smeansofdeath, einflictor) {
  _id_E08E0D086A79892B = 0;
  ent = victim;

  if(!isDefined(attacker.lastkillalertsoundtime)) {
    attacker.lastkillalertsoundtime = gettime();
    _id_E08E0D086A79892B = 1;
  } else if(gettime() > attacker.lastkillalertsoundtime + 700) {
    attacker.lastkillalertsoundtime = gettime();
    _id_E08E0D086A79892B = 1;
  }

  _id_31920AA482F41AE8 = !scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924() || getdvarint("dvar_C2989C398361DBB3", 0) != 0;
  _id_E7D4A41E01C7228C = scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924() && getdvarint("dvar_58F2C5B698828174", 0) != 0;

  if(_id_80ADE967129C9845()) {} else if(isagent(attacker)) {
    if(!scripts\engine\utility::isbulletdamage(smeansofdeath) || isDefined(einflictor) && attacker != einflictor) {} else if(smeansofdeath == "MOD_HEAD_SHOT") {
      ent playsoundtoplayer("bullet_impact_headshot_plr", victim);
      ent playsoundtoteam("bullet_impact_headshot_npc", victim.team, victim);
    } else
      ent playsoundtoteam("mp_hit_alert_final_npc", victim.team);
  } else if(!scripts\engine\utility::isbulletdamage(smeansofdeath) || isDefined(einflictor) && attacker != einflictor) {
    if(_id_E08E0D086A79892B) {
      if(smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH")
        ent playsoundtoplayer("mp_kill_alert", attacker);
      else
        ent playsoundtoplayer("mp_kill_alert_quiet", attacker);
    }
  } else if(smeansofdeath == "MOD_HEAD_SHOT" && _id_31920AA482F41AE8) {
    ent playsoundtoplayer("bullet_impact_headshot_plr", victim);
    ent playsoundtoplayer("bullet_impact_headshot", attacker);

    if(_id_E08E0D086A79892B)
      ent playsoundtoplayer("mp_headshot_alert", attacker);

    ent playsoundtoteam("bullet_impact_headshot_npc", victim.team, victim);
    ent playsoundtoteam("bullet_impact_headshot_npc", attacker.team, attacker);
  } else {
    ent playsoundtoteam("mp_hit_alert_final_npc", victim.team);
    ent playsoundtoteam("mp_hit_alert_final_npc", attacker.team, attacker);

    if(_id_E08E0D086A79892B) {
      _id_506B055E36391339 = scripts\engine\utility::ter_op(_id_E7D4A41E01C7228C, "mp_kill_alert_quiet", "mp_kill_alert");
      ent playsoundtoplayer(_id_506B055E36391339, attacker);
    }
  }

  if(isPlayer(victim)) {
    if(smeansofdeath != "MOD_EXECUTION" && (smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_SUICIDE"))
      victim playlocalsound("deaths_door_death_quiet");
    else if(smeansofdeath != "MOD_EXECUTION")
      victim playlocalsound("deaths_door_death");

    victim clearsoundsubmix("deaths_door_mp", 2);
    victim notify("deaths_door_exit");
    victim.deathsdoor = 0;
  }
}

_id_4E8BD2BD787C0DDA(smeansofdeath) {
  if(isPlayer(self)) {
    if(smeansofdeath != "MOD_EXECUTION" && (smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_SUICIDE"))
      self playlocalsound("deaths_door_death_quiet");
    else if(smeansofdeath != "MOD_EXECUTION")
      self playlocalsound("deaths_door_death");

    self clearsoundsubmix("deaths_door_mp", 2);
    self notify("deaths_door_exit");
    self.deathsdoor = 0;
  }
}

_id_80ADE967129C9845() {
  return istrue(level._id_57ECE26E490AD8C4);
}

handlenormaldeath(lifeid, attacker, einflictor, objweapon, smeansofdeath, victim, iskillstreakweapon, _id_642470E1ABC1BBF9, _id_C7944407E05A6F77, _id_B9C265F657115663) {
  if(smeansofdeath == "MOD_GRENADE" && einflictor == attacker)
    addattacker(victim, attacker, einflictor, objweapon, _id_642470E1ABC1BBF9.damage, (0, 0, 0), _id_642470E1ABC1BBF9.direction_vec, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.psoffsettime, smeansofdeath);

  _id_642470E1ABC1BBF9.dokillcam = 1;

  if(isai(victim) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"]))
    _id_642470E1ABC1BBF9.dokillcam = victim[[level.bot_funcs["should_do_killcam"]]]();

  if(istrue(level.disable_killcam) || istrue(victim.disable_killcam))
    _id_642470E1ABC1BBF9.dokillcam = 0;

  attacker thread scripts\mp\events::killedplayer(lifeid, self, objweapon, smeansofdeath, einflictor, _id_642470E1ABC1BBF9);

  if(!istrue(level.disablestattracking)) {
    self._id_F215F63A4834BB72 = isDefined(self.lastattackedshieldplayer) && isDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker;
    victim thread scripts\cp_mp\challenges::onplayerkilled(einflictor, attacker, _id_642470E1ABC1BBF9.damage, _id_642470E1ABC1BBF9.damageflags, smeansofdeath, objweapon, _id_642470E1ABC1BBF9.hitloc, attacker.modifiers);

    if(isDefined(level._id_90420335F9A84867))
      self[[level._id_90420335F9A84867]](attacker, istrue(_id_B9C265F657115663));

    scripts\mp\codcasterclientmatchdata::_id_6F792F70FFE4CD4D(attacker, victim);
    victim.pers["cur_death_streak"]++;

    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "headshots");
      attacker scripts\mp\utility\stats::incpersstat("headshots", 1);
      attacker.headshots = attacker scripts\mp\utility\stats::getpersstat("headshots");

      switch (weaponclass(objweapon.basename)) {
        case "rifle":
          attacker scripts\mp\utility\stats::incpersstat("arHeadshots", 1);
          break;
        case "smg":
          attacker scripts\mp\utility\stats::incpersstat("smgHeadshots", 1);
          break;
        case "spread":
          attacker scripts\mp\utility\stats::incpersstat("shotgunHeadshots", 1);
          break;
        case "mg":
          attacker scripts\mp\utility\stats::incpersstat("lmgHeadshots", 1);
          break;
        case "sniper":
          attacker scripts\mp\utility\stats::incpersstat("sniperHeadshots", 1);
          break;
        case "rocketlauncher":
          attacker scripts\mp\utility\stats::incpersstat("launcherHeadshots", 1);
          break;
        case "pistol":
          attacker scripts\mp\utility\stats::incpersstat("pistolHeadshots", 1);
          break;
      }
    }

    if(isDefined(einflictor) && istrue(einflictor.isequipment)) {
      switch (einflictor.equipmentref) {
        case "equip_frag":
          attacker scripts\mp\utility\stats::incpersstat("fragKills", 1);
          break;
        case "equip_semtex":
          attacker scripts\mp\utility\stats::incpersstat("semtexKills", 1);
          break;
        case "equip_molotov":
          attacker scripts\mp\utility\stats::incpersstat("molotovKills", 1);
          break;
        case "equip_claymore":
          attacker scripts\mp\utility\stats::incpersstat("claymoreKills", 1);
          break;
        case "equip_throwing_knife":
        case "equip_throwing_knife_electric":
        case "equip_throwing_knife_fire":
          attacker scripts\mp\utility\stats::incpersstat("throwingKnifeKills", 1);
          attacker scripts\cp_mp\pet_watch::addthrowingknifecharge();
          break;
        case "equip_c4":
          attacker scripts\mp\utility\stats::incpersstat("c4Kills", 1);
          break;
        case "equip_thermite":
          attacker scripts\mp\utility\stats::incpersstat("thermiteKills", 1);
          break;
        case "equip_at_mine":
          attacker scripts\mp\utility\stats::incpersstat("proximityMineKills", 1);
          break;
      }
    }
  }

  if(isDefined(einflictor) && istrue(einflictor._id_26FB072855FD4772)) {
    return;
  }
  thread handlenormaldeath_sounds(attacker, victim, smeansofdeath, einflictor);
  _id_D2DB6CB7F6D5D36D = attacker;

  if(isDefined(attacker.commanding_bot))
    _id_D2DB6CB7F6D5D36D = attacker.commanding_bot;

  if(!istrue(_id_C7944407E05A6F77) && !isfriendlyfire(victim, attacker))
    attacker _id_213650502F1ED86F(victim);

  if(!istrue(level.disablestattracking)) {
    scripts\mp\codcasterclientmatchdata::_id_5A82C337B996BAA5(6, 0);

    if(isPlayer(attacker)) {
      attacker scripts\mp\codcasterclientmatchdata::_id_1882F80B14421089(6, 1);
      consecutiveKills = attacker._id_01A34ED8EB5C6E9C[6];

      if(!(consecutiveKills % 5)) {
        if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
          _id_548072087C9FD504::_id_7D42D3F8DD68280C(13, attacker.team, attacker getentitynumber(), consecutiveKills);
      }
    }
  }

  if(!istrue(_id_D2DB6CB7F6D5D36D.pers["ignoreWeaponMatchBonus"]) && (scripts\mp\utility\weapon::iscacprimaryweapon(objweapon) || scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon))) {
    if(!isDefined(_id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"]))
      _id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"] = 1;
    else
      _id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"]++;

    if(_id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"] > scripts\mp\weaponrank::getgametypekillspermatchmaximum()) {
      _id_D2DB6CB7F6D5D36D.pers["ignoreWeaponMatchBonus"] = 1;
      _id_D2DB6CB7F6D5D36D.pers["weaponMatchBonusKills"] = undefined;
      _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"] = undefined;
    } else {
      if(!isDefined(_id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"]))
        _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"] = [];

      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
      _id_B590DD50C4FE1F77 = 0;

      foreach(_id_5DC27A5BF459C504, data in _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"]) {
        if(_id_5DC27A5BF459C504 == _id_AB501F397D3CD312) {
          data.killcount++;
          _id_B590DD50C4FE1F77 = 1;
          break;
        }
      }

      if(!_id_B590DD50C4FE1F77) {
        data = spawnStruct();
        data.killcount = 1;
        data.basename = objweapon.basename;
        data.orderindex = _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"].size;
        _id_D2DB6CB7F6D5D36D.pers["killsPerWeapon"][_id_AB501F397D3CD312] = data;
      }
    }
  }

  _id_90AB65120E5446C7 = attacker.pers["cur_kill_streak"];

  if(!istrue(level.ignorescoring) && (isalive(attacker) || isDefined(attacker.streaktype) && attacker.streaktype == "support")) {
    if(smeansofdeath == "MOD_MELEE" && !attacker scripts\mp\utility\killstreak::isjuggernaut() || attacker scripts\mp\utility\killstreak::killshouldaddtokillstreak(objweapon))
      attacker registerkill(objweapon, smeansofdeath, 1, iskillstreakweapon);

    if(attacker.pers["cur_kill_streak"] > attacker scripts\mp\utility\stats::getpersstat("longestStreak"))
      attacker.pers["longestStreak"] = attacker.pers["cur_kill_streak"];
  }

  attacker.pers["cur_death_streak"] = 0;

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    if(!istrue(level.ignorescoring) && attacker.pers["cur_kill_streak"] > attacker scripts\mp\persistence::statgetchild("round", "killStreak"))
      attacker scripts\mp\persistence::statsetchild("round", "killStreak", attacker.pers["cur_kill_streak"]);

    if(!istrue(level.ignorescoring) && attacker scripts\mp\utility\game::onlinestatsenabled()) {
      if(attacker.pers["cur_kill_streak"] > attacker.bestlifetimekillstreak) {
        attacker scripts\mp\playerstats_interface::setplayerstat(attacker.pers["cur_kill_streak"], "bestStats", "killStreak");
        attacker.bestlifetimekillstreak = attacker.pers["cur_kill_streak"];
      }
    }
  }

  if(!istrue(iskillstreakweapon) && !scripts\mp\utility\weapon::iskillstreakvehicleinflictor(einflictor) || scripts\mp\utility\points::isforcekillstreakprogressweapon(objweapon)) {
    attacker thread scripts\mp\events::killeventtextpopup("stat_EF9582D72160F199", 0);
    _id_4D407FE4BF2C6305 = undefined;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done"))
      _id_4D407FE4BF2C6305 = 100;

    _id_4B5A99C16ABFDFB1 = undefined;

    if(scripts\mp\utility\game::getsubgametype() == "dmz")
      _id_4B5A99C16ABFDFB1 = getdvarint("dvar_DEFD7006EFDE9127", 100);

    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_EF9582D72160F199", objweapon, _id_4D407FE4BF2C6305, _id_4B5A99C16ABFDFB1, victim);
    attacker scripts\mp\bounty::bountyincreasestreak();
    attacker scripts\mp\bounty::bountycollect(victim.lastbounty, victim.origin);
  }

  _id_8B35ACA16DAC0449 = scripts\mp\tweakables::gettweakablevalue("game", "deathpointloss");

  if(isDefined(level.gunshipplayer) && level.gunshipplayer == attacker)
    level notify("ai_killed", self);

  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - _id_8B35ACA16DAC0449);
  level notify("player_got_killstreak_" + attacker.pers["cur_kill_streak"], attacker);
  attacker notify("killed_enemy");

  if(istrue(attacker.inlaststand))
    attacker thread scripts\mp\laststand::onlaststandkillenemy(_id_642470E1ABC1BBF9);

  if(isDefined(level.onnormaldeath) && (isDefined(attacker.pers) && attacker.pers["team"] != "spectator") && !istrue(level.ignorescoring))
    [[level.onnormaldeath]](self, attacker, lifeid, smeansofdeath, objweapon, iskillstreakweapon);

  if(!attacker scripts\mp\utility\player::isusingremote()) {
    weaponlist = victim getweaponslistprimaries();
    _id_5D4277E0C084DE15 = 0;

    foreach(weapon in weaponlist) {
      if(weaponclass(weapon.basename) == "sniper") {
        _id_5D4277E0C084DE15 = 1;
        break;
      }
    }

    if(_id_5D4277E0C084DE15)
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(attacker, "stat_2EE580BBE139941A", undefined, 0.75);
    else
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(attacker, "stat_29C83D721F765AB4", undefined, 0.75);
  }

  _id_5A127424B8DF87B6 = undefined;

  switch (victim.loadoutarchetype) {
    case "archetype_assault":
      _id_5A127424B8DF87B6 = "plr_killfirm_warfighter";
      break;
  }

  if(isDefined(_id_5A127424B8DF87B6))
    level thread scripts\mp\battlechatter_mp::saytoself(attacker, _id_5A127424B8DF87B6, "plr_killfirm_generic", 0.75);

  if(istrue(self._id_F215F63A4834BB72) && !istrue(level.disablestattracking)) {
    _id_6D6B794A7B5386A0 = getdvarint("dvar_089C66B6F125F4F6", 2500);

    if(gettime() - self.lastattackedshieldtime < _id_6D6B794A7B5386A0)
      self.lastattackedshieldplayer thread scripts\mp\gamescore::processshieldassist(self);
    else if(isalive(self.lastattackedshieldplayer) && gettime() - self.lastattackedshieldtime < 5000) {
      forwardvec = vectorNormalize(anglesToForward(self.angles));
      _id_5A1DAE383F6C2BDE = vectorNormalize(self.lastattackedshieldplayer.origin - self.origin);

      if(vectordot(_id_5A1DAE383F6C2BDE, forwardvec) > 0.925)
        self.lastattackedshieldplayer thread scripts\mp\gamescore::processshieldassist(self);
      else
        self.lastattackedshieldplayer scripts\mp\gamescore::_id_5A687B65C904B197(attacker, self, attacker.team);
    } else
      self.lastattackedshieldplayer scripts\mp\gamescore::_id_5A687B65C904B197(attacker, self, attacker.team);
  }

  if(!scripts\mp\utility\game::runleanthreadmode())
    scripts\mp\gamescore::awardbuffdebuffassists(attacker, self);

  _id_986A03FF4BA86052 = 1;

  if(!istrue(level.disablestattracking) && isDefined(self.attackers)) {
    foreach(player in self.attackers) {
      if(!isDefined(scripts\mp\utility\damage::_validateattacker(player))) {
        continue;
      }
      if(player == attacker) {
        continue;
      }
      if(self == player) {
        continue;
      }
      if(isDefined(level.assists_disabled)) {
        continue;
      }
      _id_54351D786449EE9E = 0;
      _id_907BB577FE481752 = undefined;

      if(isDefined(self.attackerdata)) {
        attackerdata = self.attackerdata[player.guid];

        if(isDefined(attackerdata))
          _id_907BB577FE481752 = attackerdata.objweapon;

        if(isDefined(attackerdata.damage)) {
          if(attackerdata.damage >= 35)
            _id_54351D786449EE9E = 1;

          if(attackerdata.damage >= 70)
            _id_54351D786449EE9E = 2;
        }
      }

      if(!(istrue(_id_B9C265F657115663) && isDefined(self.laststandattacker) && player == self.laststandattacker))
        player thread scripts\mp\gamescore::processassist(self, _id_907BB577FE481752, _id_54351D786449EE9E);

      _id_986A03FF4BA86052 = 0;

      if(isDefined(player.super)) {
        if(player.super.staticdata.ref == "super_battlerage")
          player _id_19FD5B5D73D44C18::_id_3F783A5ACA22152D();
      }

      if(player scripts\mp\utility\perk::_hasperk("specialty_boom"))
        victim thread scripts\mp\perks\perkfunctions::setboominternal(player);
    }
  }

  if(isDefined(attacker.pers["soloKills"]) && _id_986A03FF4BA86052 && attacker.team != victim.team)
    attacker scripts\mp\utility\stats::incpersstat("soloKills", 1);

  if(isDefined(self.markedbyboomperk) && !istrue(level.disablestattracking)) {
    foreach(player in level.players) {
      if(player.team == self.team) {
        continue;
      }
      if(scripts\engine\utility::array_contains(self.attackers, player)) {
        continue;
      }
      if(scripts\engine\utility::array_contains_key(self.markedbyboomperk, player scripts\mp\utility\player::getuniqueid()))
        player thread scripts\mp\gamescore::processassist(self, objweapon);
    }
  }

  if(level.teambased) {
    if(isDefined(attacker.team) && isDefined(level.uavmodels) && isDefined(level.uavmodels[attacker.team]) && level.uavmodels[attacker.team].size > 0) {
      _id_543EE40D273786C8 = [];

      foreach(uav in level.uavmodels[attacker.team]) {
        if(isDefined(uav) && isDefined(uav.owner) && uav.owner != attacker && !scripts\engine\utility::array_contains(_id_543EE40D273786C8, uav.uavtype)) {
          eventname = _func_2EF675C13CA1C4AF(_func_1823FF50BB28148D(uav.uavtype), "_assist");
          _id_91185FF4A2E16A72 = undefined;

          if(!isDefined(uav.assistsgiven))
            uav.assistsgiven = 0;

          _id_CCFE1EB50C191E67 = scripts\engine\utility::ter_op(uav.uavtype == "directional_uav", 15, 10);

          if(uav.assistsgiven < _id_CCFE1EB50C191E67)
            uav.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE(eventname, undefined, _id_91185FF4A2E16A72, undefined, undefined, undefined, undefined, undefined, uav.streakinfo);
          else
            uav.owner thread scripts\mp\utility\points::givexpwithtext(eventname, _id_91185FF4A2E16A72);

          uav.assistsgiven++;

          switch (uav.uavtype) {
            case "uav":
              uav.owner scripts\mp\utility\stats::incpersstat("killstreakUAVAssists", 1);
              break;
            case "counter_uav":
              uav.owner scripts\mp\utility\stats::incpersstat("killstreakCUAVAssists", 1);
              break;
            case "directional_uav":
              uav.owner scripts\mp\utility\stats::incpersstat("killstreakAUAVAssists", 1);
              break;
          }

          _id_543EE40D273786C8[_id_543EE40D273786C8.size] = uav.uavtype;
          scripts\cp_mp\challenges::processuavassist(uav.owner, uav.uavtype);
          uav.owner scripts\mp\utility\script::bufferednotify("update_uav_assist_buffered");
          uav.owner combatrecordkillstreakstat(uav.uavtype);
        }
      }
    }

    if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
      foreach(drone in level.supportdrones) {
        if(level.teambased && drone.team == attacker.team && drone.owner != attacker) {
          if(isDefined(drone.enemiesmarked) && isDefined(drone.enemiesmarked[self getentitynumber()]))
            drone.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE(_func_2EF675C13CA1C4AF(_func_1823FF50BB28148D(drone.streakinfo.streakname), "_assist"));
        }

        if(drone.helperdronetype == "scrambler_drone_guard") {
          if(level.teambased && drone.team == attacker.team && drone.owner != attacker) {
            eventname = _func_2EF675C13CA1C4AF(_func_1823FF50BB28148D(drone.streakinfo.streakname), "_assist");

            if(!isDefined(drone.assistsgiven))
              drone.assistsgiven = 0;

            if(drone.assistsgiven < 10)
              drone.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE(eventname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, drone.streakinfo);
            else
              drone.owner thread scripts\mp\utility\points::givexpwithtext(eventname);

            drone.assistsgiven++;
            drone.owner scripts\mp\utility\stats::incpersstat("killstreakCUAVAssists", 1);
          }
        }
      }
    }

    scripts\mp\equipment\binoculars::binoculars_giveassistpoints(attacker, self);

    if(isDefined(attacker.team) && isDefined(level.activewpzones) && level.activewpzones.size > 0) {
      _id_B16682794BB72308 = level.activewpzones[0];
      _id_BFB78B87A67E2EB9 = _id_B16682794BB72308.owner;
      _id_A9BE838EF5E091EF = _id_B16682794BB72308.team;

      if(attacker.team == _id_A9BE838EF5E091EF && attacker != _id_BFB78B87A67E2EB9) {
        if(istrue(victim.wpdisorient) || istrue(victim.wpburning)) {
          eventname = "stat_213B00973AF47F5E";

          if(!isDefined(_id_B16682794BB72308.assistsgiven))
            _id_B16682794BB72308.assistsgiven = 0;

          if(_id_B16682794BB72308.assistsgiven < 15)
            _id_BFB78B87A67E2EB9 thread scripts\mp\utility\points::_id_0366980B6A8796AE(eventname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, _id_B16682794BB72308.streakinfo);
          else
            _id_BFB78B87A67E2EB9 thread scripts\mp\utility\points::givexpwithtext(eventname);

          _id_B16682794BB72308.assistsgiven++;
          _id_BFB78B87A67E2EB9 scripts\mp\utility\stats::incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
        }
      }
    }
  }

  if(isPlayer(attacker)) {
    _id_B908A35B0981168E();

    if(!_id_E42EFE66FA95CA55()) {
      attacker setclientomnvar("ui_killed_player", self getentitynumber());
      attacker setclientomnvar("ui_killed_player_notify", gettime());
    }
  }
}

_id_213650502F1ED86F(victim) {
  _id_D2DB6CB7F6D5D36D = self;

  if(!istrue(level.ignorescoring)) {
    if(!victim _id_2CEDCC356F1B9FC8::playeriszombie())
      _id_D2DB6CB7F6D5D36D playerincrementscoreboardkills();

    if(isbehindmeleevictim(_id_D2DB6CB7F6D5D36D, victim)) {
      _id_D2DB6CB7F6D5D36D scripts\mp\utility\stats::incpersstat("killsFromBehind", 1);
      victim scripts\mp\utility\stats::incpersstat("deathsFromBehind", 1);
    }
  } else if(isDefined(level.prematchaddkillfunc))
    _id_D2DB6CB7F6D5D36D[[level.prematchaddkillfunc]]();
}

playerincrementscoreboardkills() {
  _id_D2DB6CB7F6D5D36D = self;
  _id_D2DB6CB7F6D5D36D scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "kills");

  if(_id_D2DB6CB7F6D5D36D.pers["kills"] < 14999) {
    _id_D2DB6CB7F6D5D36D scripts\mp\utility\stats::incpersstat("kills", 1);
    _id_D2DB6CB7F6D5D36D.kills = _id_D2DB6CB7F6D5D36D scripts\mp\utility\stats::getpersstat("kills");
    _id_D2DB6CB7F6D5D36D scripts\mp\persistence::statsetchild("round", "kills", _id_D2DB6CB7F6D5D36D.kills, level.ignorekdrstats);
  }
}

callback_playerkilled(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration) {
  playerkilled_internal(inflictor, attacker, self, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, 0);
}

launchshield(damage, meansofdeath) {
  if(scripts\mp\riotshield::riotshield_hasweapon()) {
    if(isDefined(self.riotshieldmodel))
      scripts\mp\riotshield::riotshield_detach(1);

    if(isDefined(self.riotshieldmodelstowed))
      scripts\mp\riotshield::riotshield_detach(0);
  }
}

resetplayervariables() {
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.pers["cur_kill_streak"] = 0;
  self.killcountthislife = 0;
  self.laststandattacker = undefined;
  self.laststandattackermodifiers = undefined;
  scripts\mp\gameobjects::detachusemodels();
}

resetplayeromnvarsonspawn() {
  scripts\mp\playerlogic::resetuiomnvarscommon();
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_shrapnel_overlay", 0);
}

hitlocdebug(attacker, victim, damage, hitloc, _id_44E290FB31B85206) {
  colors = [];
  colors[0] = 2;
  colors[1] = 3;
  colors[2] = 5;
  colors[3] = 7;

  if(!getdvarint("scr_hitloc_debug")) {
    return;
  }
  if(!isDefined(attacker.hitlocinited)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++)
      attacker setclientdvar(_func_2EF675C13CA1C4AF("ui_hitloc_", scripts\engine\utility::string(_id_AC0E594AC96AA3A8)), "");

    attacker.hitlocinited = 1;
  }

  if(level.splitscreen || !isPlayer(attacker)) {
    return;
  }
  _id_F2F77B9518946235 = 6;

  if(!isDefined(attacker.damageinfo)) {
    attacker.damageinfo = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F2F77B9518946235; _id_AC0E594AC96AA3A8++) {
      attacker.damageinfo[_id_AC0E594AC96AA3A8] = spawnStruct();
      attacker.damageinfo[_id_AC0E594AC96AA3A8].damage = 0;
      attacker.damageinfo[_id_AC0E594AC96AA3A8].hitloc = "";
      attacker.damageinfo[_id_AC0E594AC96AA3A8].bp = 0;
      attacker.damageinfo[_id_AC0E594AC96AA3A8].colorindex = 0;
    }

    attacker.damageinfocolorindex = 0;
    attacker.damageinfovictim = undefined;
  }

  for(_id_AC0E594AC96AA3A8 = _id_F2F77B9518946235 - 1; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    attacker.damageinfo[_id_AC0E594AC96AA3A8].damage = attacker.damageinfo[_id_AC0E594AC96AA3A8 - 1].damage;
    attacker.damageinfo[_id_AC0E594AC96AA3A8].hitloc = attacker.damageinfo[_id_AC0E594AC96AA3A8 - 1].hitloc;
    attacker.damageinfo[_id_AC0E594AC96AA3A8].bp = attacker.damageinfo[_id_AC0E594AC96AA3A8 - 1].bp;
    attacker.damageinfo[_id_AC0E594AC96AA3A8].colorindex = attacker.damageinfo[_id_AC0E594AC96AA3A8 - 1].colorindex;
  }

  attacker.damageinfo[0].damage = damage;
  attacker.damageinfo[0].hitloc = hitloc;
  attacker.damageinfo[0].bp = _id_44E290FB31B85206 &level.idflags_penetration;

  if(isDefined(attacker.damageinfovictim) && attacker.damageinfovictim != victim) {
    attacker.damageinfocolorindex++;

    if(attacker.damageinfocolorindex == colors.size)
      attacker.damageinfocolorindex = 0;
  }

  attacker.damageinfovictim = victim;
  attacker.damageinfo[0].colorindex = attacker.damageinfocolorindex;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F2F77B9518946235; _id_AC0E594AC96AA3A8++) {
    color = "^" + colors[attacker.damageinfo[_id_AC0E594AC96AA3A8].colorindex];

    if(attacker.damageinfo[_id_AC0E594AC96AA3A8].hitloc != "") {
      val = color + attacker.damageinfo[_id_AC0E594AC96AA3A8].hitloc;

      if(attacker.damageinfo[_id_AC0E594AC96AA3A8].bp)
        val = val + " (BP)";

      attacker setclientdvar(_func_2EF675C13CA1C4AF("ui_hitloc_", scripts\engine\utility::string(_id_AC0E594AC96AA3A8)), val);
    }

    attacker setclientdvar(_func_2EF675C13CA1C4AF("ui_hitloc_damage_", scripts\engine\utility::string(_id_AC0E594AC96AA3A8)), color + attacker.damageinfo[_id_AC0E594AC96AA3A8].damage);
  }
}

giverecentshieldxp() {
  self endon("death_or_disconnect");
  self notify("giveRecentShieldXP");
  self endon("giveRecentShieldXP");
  self.recentshieldxp++;
  wait 20.0;
  self.recentshieldxp = 0;
}

updateinflictorstat(einflictor, eattacker, sweapon, _id_AE9ACDDA1C693FA6) {
  if(!isDefined(einflictor) || !isDefined(einflictor.alreadyhit) || !einflictor.alreadyhit || !scripts\mp\utility\weapon::issinglehitweapon(sweapon))
    scripts\mp\gamelogic::setinflictorstat(einflictor, eattacker, sweapon);

  if(isDefined(einflictor))
    einflictor.alreadyhit = 1;
}

addattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, _id_1DA1A66B5C6A06A7) {
  if(!isDefined(eattacker.guid) && (isagent(eattacker) || isPlayer(eattacker)))
    eattacker.guid = eattacker scripts\mp\utility\player::getuniqueid();

  if(!isDefined(eattacker.guid)) {
    return;
  }
  if(!isDefined(victim.attackerdata))
    victim.attackerdata = [];

  currenttime = gettime();

  if(!isDefined(victim.attackerdata[eattacker.guid])) {
    victim.attackers[eattacker.guid] = eattacker;
    victim.attackerdata[eattacker.guid] = spawnStruct();
    victim.attackerdata[eattacker.guid].damage = 0;
    victim.attackerdata[eattacker.guid]._id_D69D6CC16D8B71FB = 0;
    victim.attackerdata[eattacker.guid].attackerent = eattacker;
    victim.attackerdata[eattacker.guid].firsttimedamaged = currenttime;
    victim.attackerdata[eattacker.guid].hitcount = 0;
  }

  attackerdata = victim.attackerdata[eattacker.guid];

  if(isDefined(level._id_B5224F533F8FFFB0) && isDefined(level._id_B5224F533F8FFFB0[objweapon.basename]) && isDefined(level._id_B5224F533F8FFFB0[objweapon.basename][eattacker.guid]))
    objweapon = level._id_B5224F533F8FFFB0[objweapon.basename][eattacker.guid];

  if(scripts\mp\utility\weapon::iscacprimaryweapon(objweapon) && !scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon))
    attackerdata.diddamagewithprimary = 1;

  if(isDefined(smeansofdeath) && smeansofdeath != "MOD_MELEE")
    attackerdata.didnonmeleedamage = 1;

  _id_11D2F075E9A0E643 = scripts\mp\utility\weapon::getequipmenttype(objweapon);

  if(isDefined(_id_11D2F075E9A0E643)) {
    if(_id_11D2F075E9A0E643 == "lethal")
      attackerdata.diddamagewithlethalequipment = 1;

    if(_id_11D2F075E9A0E643 == "tactical")
      attackerdata.diddamagewithtacticalequipment = 1;
  }

  idamage = scripts\engine\utility::_id_53C4C53197386572(idamage, 0);
  _id_1DA1A66B5C6A06A7 = scripts\engine\utility::_id_53C4C53197386572(_id_1DA1A66B5C6A06A7, 0);

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_SUICIDE")
    totalhealth = victim.maxhealth + scripts\engine\utility::_id_53C4C53197386572(victim.armorhealth, 0) + _id_1DA1A66B5C6A06A7;
  else
    totalhealth = victim.health + scripts\engine\utility::_id_53C4C53197386572(victim.armorhealth, 0) + _id_1DA1A66B5C6A06A7;

  totaldamage = idamage + _id_1DA1A66B5C6A06A7;
  _id_D69D6CC16D8B71FB = scripts\engine\utility::ter_op(totaldamage > totalhealth, totalhealth, totaldamage);
  attackerdata _id_6A5D3BF7A5B7064A::_id_F74C4C476C9489F6();
  attackerdata.hitcount++;
  attackerdata.damage = attackerdata.damage + totaldamage;
  attackerdata._id_D69D6CC16D8B71FB = attackerdata._id_D69D6CC16D8B71FB + _id_D69D6CC16D8B71FB;
  attackerdata.objweapon = objweapon;
  attackerdata.vpoint = vpoint;
  attackerdata.vdir = vdir;
  attackerdata.shitloc = shitloc;
  attackerdata.psoffsettime = psoffsettime;
  attackerdata.smeansofdeath = smeansofdeath;
  attackerdata.attackerent = eattacker;
  attackerdata.lasttimedamaged = currenttime;
  attackerdata.inflictor = einflictor;
  attackerdata._id_4CE88B2DFE0BFA52 = istrue(victim._id_4CE88B2DFE0BFA52);

  if(!isDefined(attackerdata._id_282F568E901445CE))
    attackerdata._id_282F568E901445CE = [];

  _id_22DE319BDC95FEA2 = "none";
  _id_1189BD7FBE2861F8 = scripts\mp\equipment::getequipmentreffromweapon(objweapon);

  if(isDefined(_id_1189BD7FBE2861F8))
    _id_22DE319BDC95FEA2 = _id_1189BD7FBE2861F8;
  else if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon))
    _id_22DE319BDC95FEA2 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(objweapon);
  else if(isDefined(smeansofdeath) && (smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_EXECUTION"))
    _id_22DE319BDC95FEA2 = smeansofdeath;
  else if(istrue(victim.islaststandbleedoutdmg) || istrue(victim._id_1CAE08F4D3D931C1) || istrue(victim._id_4CE88B2DFE0BFA52))
    _id_22DE319BDC95FEA2 = "BLEED_TICK";
  else if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE" && isDefined(einflictor) && einflictor.code_classname == "scriptable" || istrue(victim._id_28E103726B808009))
    _id_22DE319BDC95FEA2 = "ENV_EXPLOSIVE";
  else if(scripts\mp\utility\weapon::isbombsiteweapon(objweapon))
    _id_22DE319BDC95FEA2 = "BOMB_SITE";
  else if(istrue(victim._id_93532EA94ACCABDB))
    _id_22DE319BDC95FEA2 = "OOB";
  else if(isDefined(objweapon.basename))
    _id_22DE319BDC95FEA2 = objweapon.basename;

  if(!isDefined(attackerdata._id_282F568E901445CE[_id_22DE319BDC95FEA2]))
    attackerdata._id_282F568E901445CE[_id_22DE319BDC95FEA2] = 1;

  attackerdata._id_8519CF56B38D717D = _id_22DE319BDC95FEA2;
}

addattackerkillstreak(victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, sweapon) {
  if(!isDefined(victim.attackerdata))
    victim.attackerdata = [];

  if(!isDefined(victim.attackerdata[eattacker.guid])) {
    victim.attackers[eattacker.guid] = eattacker;
    victim.attackerdata[eattacker.guid] = spawnStruct();
    victim.attackerdata[eattacker.guid].damage = 0;
    victim.attackerdata[eattacker.guid].attackerent = eattacker;
    victim.attackerdata[eattacker.guid].firsttimedamaged = gettime();
    victim.attackerdata[eattacker.guid].hitcount = 1;
  }

  victim.attackerdata[eattacker.guid] _id_6A5D3BF7A5B7064A::_id_F74C4C476C9489F6();
  victim.attackerdata[eattacker.guid].damage = victim.attackerdata[eattacker.guid].damage + idamage;
  victim.attackerdata[eattacker.guid].vpoint = vpoint;
  victim.attackerdata[eattacker.guid].vdir = vdir;
  victim.attackerdata[eattacker.guid].partname = partname;
  victim.attackerdata[eattacker.guid].smeansofdeath = smeansofdeath;
  victim.attackerdata[eattacker.guid].attackerent = eattacker;
  victim.attackerdata[eattacker.guid].lasttimedamaged = gettime();
}

resetattackerlist() {
  self.attackers = [];
  self.attackerdata = [];
}

callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, _id_B0FC59FF15058522, _id_BE4285B26ED99AB1) {
  _id_8F8788FAE5311B0A = gettime();
  callback_playerdamage_internal(einflictor, eattacker, self, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, _id_B0FC59FF15058522, _id_BE4285B26ED99AB1);
}

_id_F9237EC4A57B0FF9(eattacker, _id_BA9DC00E6D5896DC, idamage, _id_D7BC24CD73DFC712, objweapon, shitloc) {
  if(shouldrecorddamagestats(eattacker)) {
    eattacker scripts\mp\utility\stats::incpersstat("damage", _id_BA9DC00E6D5896DC);

    if(isDefined(eattacker.pers["friendlyDamageDone"]) && self.team == eattacker.team)
      eattacker scripts\mp\utility\stats::incpersstat("friendlyDamageDone", _id_BA9DC00E6D5896DC);

    if(!isDefined(eattacker.damagethisround))
      eattacker.damagethisround = _id_BA9DC00E6D5896DC;
    else
      eattacker.damagethisround = eattacker.damagethisround + _id_BA9DC00E6D5896DC;

    if(eattacker != self && self.team != eattacker.team) {
      eattacker scripts\mp\codcasterclientmatchdata::_id_D16498B27251DA56(1, _id_BA9DC00E6D5896DC);
      fullweaponname = getcompleteweaponname(objweapon);
      _id_A1D4E7D5EF9DA660 = min(self.health, idamage);
      eattacker thread scripts\mp\gamelogic::threadedsetweaponstatbyname(fullweaponname, _id_A1D4E7D5EF9DA660, "damage", self);
    }

    if(shitloc == "head" && isDefined(eattacker.pers["shotsHitHead"]))
      eattacker scripts\mp\utility\stats::incpersstat("shotsHitHead", 1);

    eattacker scripts\common\utility::trycall(level.matchdata_logweaponstat, _id_2669878CF5A1B6BC::getweaponrootname(objweapon), "damage", min(self.health, idamage), -1);
    weaponobj = scripts\mp\utility\weapon::mapweapon(objweapon);
    sweapon = getcompleteweaponname(weaponobj);
    eattacker thread scripts\mp\gamelogic::threadedsetweaponstatbyname(sweapon, _id_BA9DC00E6D5896DC, "damage_dealt");
  } else if(isDefined(level.onattackerdamagenottracked))
    eattacker[[level.onattackerdamagenottracked]](_id_BA9DC00E6D5896DC);
}

finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, _id_B2883531AFA6B83D) {
  idamage = int(idamage);
  _id_BA9DC00E6D5896DC = int(min(idamage, self.health));

  if(isDefined(eattacker) && isPlayer(eattacker))
    _id_F9237EC4A57B0FF9(eattacker, _id_BA9DC00E6D5896DC, idamage, _id_D7BC24CD73DFC712, objweapon, shitloc);
  else if(isDefined(einflictor) && einflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    vehicle = einflictor;

    if(isDefined(vehicle.owner) && isPlayer(vehicle.owner))
      _id_F9237EC4A57B0FF9(vehicle.owner, _id_BA9DC00E6D5896DC, idamage, _id_D7BC24CD73DFC712, objweapon, shitloc);
  }

  if(isPlayer(self) && shouldrecorddamagestats(self)) {
    weaponobj = self.lastdroppableweaponobj;
    weaponobj = scripts\mp\utility\weapon::mapweapon(weaponobj);
    sweapon = getcompleteweaponname(weaponobj);
    scripts\mp\utility\stats::incpersstat("damageTaken", _id_BA9DC00E6D5896DC);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(sweapon, 1, "hit_markers_taken");
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(sweapon, _id_BA9DC00E6D5896DC, "damage_taken");
  }

  if(isDefined(einflictor) && isDefined(einflictor.streakinfo) && isDefined(einflictor.streakinfo.damage))
    einflictor.streakinfo.damage = einflictor.streakinfo.damage + idamage;

  if(scripts\mp\utility\damage::playershoulddofauxdeath() && idamage >= self.health && !(idflags &level.idflags_stun) && allowfauxdeath()) {
    if(!isDefined(vdir))
      vdir = (0, 0, 0);

    if(!isDefined(eattacker))
      eattacker = self;

    if(!isDefined(einflictor))
      einflictor = eattacker;

    playerkilled_internal(einflictor, eattacker, self, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, 0, 1);
  } else {
    if(isDefined(self._id_5C11205F47AF8B92)) {
      _id_289C10E1777AFAE0 = idamage >= self.health;
      _id_F0A50955D3420BE9 = gettime() - self._id_5C11205F47AF8B92 <= 1000 && scripts\mp\riotshield::riotshield_hasweapon() && _id_CD066C9463AD28C5(objweapon, smeansofdeath);
      _id_ED364FC58A359515 = !scripts\mp\utility\player::isusingremote();

      if(_id_289C10E1777AFAE0 && _id_F0A50955D3420BE9 && _id_ED364FC58A359515) {
        self suicide();
        _id_403E958ECD04F255(self, "forcing suicide on riot shield player");
        return;
      }
    }

    if(!callback_killingblow(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime)) {
      _id_403E958ECD04F255(self, "Callback_KillingBlow == false");
      return;
    }

    if(!isalive(self)) {
      _id_403E958ECD04F255(self, "!IsAlive");
      return;
    }

    if(isPlayer(self)) {
      if(!isDefined(partname))
        partname = "";

      if(!isDefined(_id_B2883531AFA6B83D))
        _id_B2883531AFA6B83D = 0;

      if(shoulduseexplosiveindicator(smeansofdeath))
        idflags = idflags | level.idflags_ricochet;

      _id_E9A18BDAF2A766E9 = smeansofdeath == "MOD_TRIGGER_HURT" && isDefined(self.islaststandbleedoutdmg);
      _id_4943BE858022033B = !_id_E9A18BDAF2A766E9;

      if(isDefined(eattacker) && isPlayer(eattacker) && eattacker != self) {
        if(!isDefined(eattacker._id_198B774C93C48891))
          eattacker._id_198B774C93C48891 = gettime();
      }

      if(!isDefined(self._id_9691E7D8CDE294F2))
        self._id_9691E7D8CDE294F2 = gettime();

      if(scripts\mp\utility\game::isteamreviveenabled() && istrue(level._id_1A52552BE0B92C9B) && idamage >= self.health && !scripts\mp\laststand::_id_27D0EA02ED3CC35F(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, 500)) {
        if(istrue(self.inlaststand))
          self laststandrevive();

        self notify("enter_live_ragdoll");
        idamage = int(self.health - 1);
        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, 0.0, modelindex, partname, _id_B2883531AFA6B83D, _id_4943BE858022033B, _id_D7BC24CD73DFC712);

        if(isDefined(einflictor) && isDefined(eattacker))
          self _meth_0AA7CFAF65F9B354(einflictor, eattacker);

        scripts\mp\utility\player::_freezecontrols(1, undefined, "liveRagdoll");
        self sethidenameplate(1);
        self.healthregendisabled = 1;
        self._id_C4C8B91E0B16AA5E = 1;
        self _meth_6B4C8718BC36D1EF(1);
        self _meth_E4CCD01FB7EC7A6F(1);
        self _meth_360874D9808F0724();
        scripts\mp\class::_id_C5CE8711741E44B8();

        if(!isDefined(einflictor) && !isDefined(eattacker)) {
          einflictor = self;
          eattacker = self;
        }

        thread playerkilled_internal(einflictor, eattacker, self, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, 500, 0);

        if(getdvarint("dvar_8DAB2B41A06260C6", 0) == 1) {
          self notify("death");
          self notify("death_or_disconnect");

          if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
            _id_16C2D930984F2FEF = self isreloading();

            if(_id_16C2D930984F2FEF) {
              _id_5814D27874B48E54 = spawnStruct();
              _id_5814D27874B48E54.player = self;
              _id_5814D27874B48E54._id_C739BA1EB6635B73 = getsystemtimeinmicroseconds();
              _id_5814D27874B48E54._id_C198F7CA473378FB = "DEATH";
              _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_reload_cancel", _id_5814D27874B48E54);
            }
          }
        }
      } else
        self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, 0.0, modelindex, partname, _id_B2883531AFA6B83D, _id_4943BE858022033B, _id_D7BC24CD73DFC712);
    }
  }

  if(smeansofdeath == "MOD_EXPLOSIVE_BULLET")
    scripts\cp_mp\utility\shellshock_utility::_shellshock("damage_mp", "damage", getdvarfloat("scr_csmode"), 0, 0);

  damageshellshockandrumble(einflictor, objweapon, smeansofdeath, idamage, idflags, eattacker);
}

shoulduseexplosiveindicator(smeansofdeath) {
  return smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_FIRE";
}

callback_playerimpaled(eattacker, objweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34) {
  thread scripts\mp\weapons::impale(eattacker, self, objweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34);
}

allowfauxdeath() {
  if(!isDefined(level.allowfauxdeath))
    level.allowfauxdeath = 1;

  return level.allowfauxdeath;
}

callback_playerlaststand(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  _id_6D8F177C77496430 = isforcedlaststand(self, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc);
  _id_4A823A0C8E9ADBB7 = scripts\mp\laststand::_id_27D0EA02ED3CC35F(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration);

  if(!_id_6D8F177C77496430 && !_id_4A823A0C8E9ADBB7)
    return 0;

  if(isDefined(attacker) && isPlayer(attacker) && attacker != self && !istrue(attacker.gulag) && !istrue(level._id_FDB13CCD60AFE05C))
    attacker thread scripts\mp\hud_message::showsplash("br_enemy_downed", undefined, self);

  if(isDefined(level.parachuteprelaststandfunc))
    self[[level.parachuteprelaststandfunc]]();

  if(self isskydiving())
    self skydive_interrupt();

  lifeid = self.matchdatalifeindex;

  if(!isDefined(lifeid))
    lifeid = level.maxlives - 1;

  _id_5B5DEACCB6CC0F8A = 0;

  if(isDefined(attacker) && !(isDefined(attacker.classname) && attacker.classname == "worldspawn")) {
    if(!isPlayer(attacker)) {
      if(isDefined(attacker.owner) && isPlayer(attacker.owner))
        attacker = attacker.owner;
      else if(isDefined(einflictor) && isDefined(einflictor.owner) && isPlayer(einflictor.owner))
        attacker = einflictor.owner;
    }

    _id_642470E1ABC1BBF9 = playerkilled_initdeathdata(einflictor, attacker, self, idamage, 0, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, 0);
    playerkilled_parameterfixup(_id_642470E1ABC1BBF9);
    playerkilled_precalc(_id_642470E1ABC1BBF9);
    _id_642470E1ABC1BBF9.laststandkill = 1;
    self.playergoingintols = 1;

    if(isPlayer(attacker) && attacker != self) {
      self.laststandattacker = attacker;
      self.laststandmeansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
      self.laststandweaponobj = objweapon;
      attacker thread scripts\mp\events::_id_B7F154368ABBE463(self, objweapon, smeansofdeath, einflictor, _id_642470E1ABC1BBF9);
      self.laststandattackermodifiers = attacker.modifiers;
    }

    self.lastbounty = scripts\mp\bounty::playergetbountypoints();
    scripts\mp\bounty::playerresetbountypoints();
    scripts\mp\bounty::playerresetbountystreak();
    _id_642470E1ABC1BBF9.isfriendlyfire = isfriendlyfire(self, attacker);

    if(getdvarint("dvar_98F5C716D594181B", 1))
      self.laststanddowneddata = _id_642470E1ABC1BBF9;

    if(!_id_642470E1ABC1BBF9.isfriendlyfire && attacker != self) {
      _id_5B5DEACCB6CC0F8A = 1;

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        if(isPlayer(attacker) && attacker != self) {
          attacker _id_2CEDCC356F1B9FC8::incrementplayersdownedstat();
          attacker thread scripts\mp\rank::scoreeventpopup("stat_0AA2E5AEC76CD59C");
          _id_F4DB485B689515A8 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(objweapon);
          _id_CC5E6F089D31A891 = isDefined(_id_F4DB485B689515A8) && _id_F4DB485B689515A8 == "precision_airstrike";

          if(_id_CC5E6F089D31A891) {
            if(isDefined(attacker._id_9A5AED1448C04687))
              attacker._id_9A5AED1448C04687++;
          }

          if(attacker ispcplayer() && scripts\mp\flags::gameflag("prematch_done"))
            attacker setclientomnvar("nVidiaHighlights_events", 24);
        }

        if(attacker != self) {
          if(getDvar("dvar_7611A2790A0BF7FE", "") != "plunder" && getDvar("dvar_7611A2790A0BF7FE", "") != "risk" && getDvar("dvar_7611A2790A0BF7FE", "") != "kingslayer" && getDvar("dvar_7611A2790A0BF7FE", "") != "rumble_mgl" && level.teamdata[self.team]["alivePlayers"].size > 0 && isPlayer(attacker)) {
            _id_F86DA5D91524E369 = [];

            if(isDefined(level._id_C5877DBE60FDDBF6))
              _id_F86DA5D91524E369 = level._id_C5877DBE60FDDBF6;

            _id_F86DA5D91524E369 = scripts\engine\utility::array_combine(_id_F86DA5D91524E369, level.teamdata[attacker.team]["alivePlayers"]);
            obituary(self, attacker, objweapon, "MOD_DOWN", _id_F86DA5D91524E369);
          }

          _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("squad_down_enemy", scripts\mp\utility\teams::_id_3D0F2343793D709B(self.team, self._id_0FF97225579DE16A, 1));
        } else
          _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("squad_down_self", scripts\mp\utility\teams::_id_3D0F2343793D709B(self.team, self._id_0FF97225579DE16A, 1));

        if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && getDvar("dvar_7611A2790A0BF7FE", "") != "rumble_mgl") {
          circle = min(max(1, level.br_circle.circleindex), 6);
          event = _func_2EF675C13CA1C4AF("stat_C1F834FEB9236EC8", scripts\engine\utility::string(circle));

          if(scripts\mp\rank::_id_377A94F711D96927(event))
            attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE(event, objweapon);
        }
      }
    }
  }

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk")
    _id_6AFF3948CF4CCA03::plunder_allowallrepositoryuseforplayer(self, 0, 1);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_715028F54BAD19A1::branalytics_down(attacker, self, objweapon, "downed", smeansofdeath);

    if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor.classname) && einflictor.classname == "script_vehicle")
      playsoundatpos(self.origin + (0, 0, 18), "vehicle_body_hit");
  }

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) {
    if(isDefined(attacker) && isPlayer(attacker) && !isbot(attacker))
      attacker notify("enemy_in_laststand");
  }

  if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "champion") {
    if(isDefined(attacker) && isDefined(attacker.team))
      level notify("down_enemy_laststand_" + attacker.team, attacker, self);
  }

  if(isDefined(level.checkforlaststandwipe)) {
    if([[level.checkforlaststandwipe]](self)) {
      self.playergoingintols = 0;
      return 0;
    }
  }

  if(isDefined(level._id_2D3EE92902BA30FA))
    self thread[[level._id_2D3EE92902BA30FA]]();
  else
    thread scripts\mp\laststand::laststandthink();

  if(isPlayer(self)) {
    _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "player_knocked_down");

    if(isPlayer(attacker))
      _id_189B67B2735B981D::_id_55B08D6D71B41402(attacker, "knocked_down_enemy");
  }

  if(_id_5B5DEACCB6CC0F8A && isDefined(attacker.guid)) {
    _id_B908A35B0981168E(1);
    _id_8BE77B53BCBD6D2D(attacker, 1);
  }

  return 1;
}

_id_B908A35B0981168E(isdowned) {
  if(getdvarint("dvar_3352584DB9B5AE7B", 1) == 0) {
    return;
  }
  if(istrue(self._id_07744DF488B629B5)) {
    return;
  }
  attackercount = 0;

  foreach(data in self.attackerdata) {
    if(data.attackerent == self) {
      continue;
    }
    attackercount++;
  }

  attackercount = int(clamp(attackercount, 0, 15));
  self setclientomnvar("ui_num_attackers", attackercount);
  self._id_07744DF488B629B5 = 1;

  if(attackercount > 1)
    thread scripts\mp\rank::scoreeventpopup("stat_59943F6A740F581B");
  else if(istrue(isdowned)) {
    if(getdvarint("dvar_A188996B14552063", 0) == 1)
      thread scripts\mp\rank::scoreeventpopup("stat_F954FA77F78FCA21");
  }
}

isforcedlaststand(victim, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc) {
  _id_6D8F177C77496430 = 0;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(_id_2CEDCC356F1B9FC8::istutorial())
      return 1;

    if(!scripts\mp\flags::gameflagexists("prematch_done") || scripts\mp\flags::gameflag("prematch_done")) {
      if(smeansofdeath == "MOD_FALLING" && !istrue(self.gulagarena) && !istrue(self.inlaststand))
        _id_6D8F177C77496430 = 1;
    }
  }

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func))
    _id_6D8F177C77496430 = 1;

  if(istrue(level._id_C8DBB5A3E916546F))
    _id_6D8F177C77496430 = 1;

  return _id_6D8F177C77496430;
}

gethitlocheight(shitloc) {
  switch (shitloc) {
    case "neck":
    case "head":
    case "helmet":
      return 60;
    case "torso_upper":
    case "left_arm_lower":
    case "right_hand":
    case "right_arm_upper":
    case "right_arm_lower":
    case "left_arm_upper":
    case "gun":
    case "left_hand":
      return 48;
    case "torso_lower":
      return 40;
    case "right_leg_upper":
    case "left_leg_upper":
      return 32;
    case "left_leg_lower":
    case "right_leg_lower":
      return 10;
    case "left_foot":
    case "right_foot":
      return 5;
  }

  return 48;
}

damageshellshockandrumble(einflictor, objweapon, smeansofdeath, idamage, idflags, eattacker) {
  thread scripts\mp\weapons::onweapondamage(einflictor, objweapon, smeansofdeath, idamage, eattacker);

  if(!isai(self) && scripts\common\utility::getdamagetype(smeansofdeath) != "bullet") {
    self playRumbleOnEntity("damage_heavy");

    if(isDefined(einflictor) && isDefined(einflictor._id_9C675043198097A3))
      self[[einflictor._id_9C675043198097A3]](einflictor);
    else if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && smeansofdeath == "MOD_TRIGGER_HURT")
      self playsoundtoplayer("trigger_hurt_impact_plr", self);
  }
}

callback_killingblow(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime) {
  return 1;
}

_id_49D8CC008E5F6722(eattacker, victim, idflags) {
  if(!isDefined(eattacker) || !isDefined(victim)) {
    return;
  }
  eattacker endon("disconnect");
  victim endon("disconnect");
  _id_6ACB3CD9C5BB74E9 = "outline_nodepth_trans_white";

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    if(!isPlayer(eattacker) && isDefined(eattacker.owner))
      eattacker = eattacker.owner;

    if(!isPlayer(eattacker))
      return;
  }

  victim scripts\mp\outline::hudoutline_enable_internal(eattacker, "damage", _id_6ACB3CD9C5BB74E9);
  wait 0.2;
  victim scripts\mp\outline::_id_32DFA50C47325ABE(eattacker, "damage", 1);
}

emitfalldamage(idamage) {
  physicsexplosionsphere(self.origin, 64, 64, 1);
}

gamemodemodifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1) {
  if(isDefined(eattacker) && isPlayer(eattacker) && isalive(eattacker)) {
    if(level.matchrules_damagemultiplier)
      idamage = idamage * level.matchrules_damagemultiplier;

    if(level.matchrules_vampirism) {
      eattacker.health = int(min(float(eattacker.maxhealth), min(eattacker.health + idamage, float(eattacker.health + 20))));
      eattacker notify("vampirism");
    }

    if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19() && scripts\engine\utility::isbulletdamage(smeansofdeath) && !_id_2669878CF5A1B6BC::isspreadweapon(objweapon)) {
      switch (shitloc) {
        case "neck":
        case "head":
        case "helmet":
          if(!victim scripts\mp\utility\killstreak::isjuggernaut()) {
            idamage = victim.maxhealth;

            if(isDefined(victim._id_8790C077C95DB752))
              idamage = idamage + victim._id_8790C077C95DB752;
          }

          break;
        default:
          break;
      }
    }

    if(istrue(game["isLaunchChunk"])) {
      if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
        if(!isbot(victim)) {
          if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT") {
            _id_E87FBCD39DE22D1B = 80;

            if(!isPlayer(eattacker) || !isPlayer(victim))
              return 0;

            _id_CB116AC8AA94CE55 = victim getplayerangles();
            _id_524B19D2034E1406 = eattacker getplayerangles();
            _id_077B9E4B599269EB = angleclamp180(_id_CB116AC8AA94CE55[1] - _id_524B19D2034E1406[1]);

            if(abs(_id_077B9E4B599269EB) < _id_E87FBCD39DE22D1B)
              idamage = idamage * 0.3;
          }
        }
      }
    }
  }

  return idamage;
}

registerkill(objweapon, smeansofdeath, _id_082A240A652326F8, iskillstreakweapon) {
  self.killcountthislife++;
  self.pers["cur_kill_streak"]++;

  if(_id_E42EFE66FA95CA55()) {
    return;
  }
  self setclientomnvar("ui_life_kill_count", self.killcountthislife);
}

_id_E42EFE66FA95CA55() {
  return istrue(level._id_E42EFE66FA95CA55);
}

monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble, _id_22435C27E2916650) {
  self endon("death");
  level endon("game_ended");
  self endon("monitorDamageEnd");

  if(!isDefined(rumble))
    rumble = 0;

  self setCanDamage(1);
  self.health = 2147483647;
  self.maxhealth = maxhealth;

  if(!isDefined(self.damagetaken) || istrue(_id_22435C27E2916650))
    self.damagetaken = 0;

  if(!isDefined(_id_A1823AC1157568DB))
    _id_A1823AC1157568DB = 0;

  for(running = 1; running; running = monitordamageoneshot(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB)) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = scripts\mp\utility\weapon::mapweapon(objweapon, inflictor);

    if(rumble)
      self playRumbleOnEntity("damage_light");

    if(_id_A1823AC1157568DB) {
      weaponname = "none";

      if(isDefined(objweapon))
        weaponname = getcompleteweaponname(objweapon);

      logattackerkillstreak(self, damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weaponname);
    }
  }
}

monitordamageend() {
  self notify("monitorDamageEnd");
  self.damagetaken = undefined;
  self.attackers = undefined;
  self.wasdamaged = undefined;
  self.wasdamagedfrombulletpenetration = undefined;
  self.wasdamagedfrombulletricochet = undefined;
  self setCanDamage(0);
}

monitordamageoneshot(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB) {
  if(!isDefined(self))
    return 0;

  if(isDefined(attacker) && isDefined(attacker.owner))
    attacker = attacker.owner;

  if(isDefined(attacker) && !scripts\cp_mp\utility\game_utility::isgameparticipant(attacker))
    return 1;

  if(isDefined(attacker) && !scripts\mp\weapons::friendlyfirecheck(self.owner, attacker)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_tac_cover") {} else
      return 1;
  }

  _id_702BFC08FABD86CB = damage;

  if(!istrue(self.skipignoredamage) && scripts\mp\utility\damage::non_player_should_ignore_damage(attacker, objweapon, inflictor, meansofdeath))
    return 1;

  if(isDefined(objweapon)) {
    damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);

    if(!isDefined(_id_D7B6456018542238))
      _id_D7B6456018542238 = ::modifydamage;

    _id_702BFC08FABD86CB = self[[_id_D7B6456018542238]](damagedata);
  }

  if(_id_702BFC08FABD86CB <= 0)
    return 1;

  self.wasdamaged = 1;
  self.damagetaken = self.damagetaken + int(_id_702BFC08FABD86CB);
  self.health = 2147483647;

  if(isDefined(idflags) && idflags &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  if(isDefined(idflags) && idflags &level.idflags_ricochet)
    self.wasdamagedfrombulletricochet = 1;

  if(istrue(_id_A1823AC1157568DB))
    scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, _id_702BFC08FABD86CB);

  if(isDefined(attacker)) {
    if(isPlayer(attacker))
      attacker _id_5762AC2F22202BA2::updatedamagefeedback(damagefeedback);
  }

  if(self.damagetaken >= self.maxhealth) {
    damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);
    self thread[[_id_C5D89C3A1224B118]](damagedata);
    return 0;
  }

  return 1;
}

modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflag = data.idflag;

  if(isDefined(idflag) && (idflag && level.idflags_ricochet))
    _id_702BFC08FABD86CB = 0.6 * damage;
  else
    _id_702BFC08FABD86CB = damage;

  _id_702BFC08FABD86CB = handleempdamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = handlemissiledamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = handlegrenadedamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = handleapdamage(objweapon, type, _id_702BFC08FABD86CB, attacker);
  return _id_702BFC08FABD86CB;
}

handlemissiledamage(objweapon, meansofdeath, damage) {
  _id_ADAD6640398C7B3A = damage;

  switch (objweapon.basename) {
    case "bomb_site_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_rpapa7_mp":
    case "gunship_hellfire_mp":
    case "gunship_40mm_mp":
    case "iw9_la_juliet_mp":
    case "iw9_la_gromeo_mp":
    case "gunship_105mm_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
      self.largeprojectiledamage = 1;
      _id_ADAD6640398C7B3A = self.maxhealth + 1;
      break;
    case "heli_pilot_turret_mp":
      self.largeprojectiledamage = 0;
      _id_ADAD6640398C7B3A = _id_ADAD6640398C7B3A * 2;
      break;
  }

  return _id_ADAD6640398C7B3A;
}

handlegrenadedamage(objweapon, _id_D95DA0355CF4CCB4, _id_702BFC08FABD86CB) {
  if(isexplosivedamagemod(_id_D95DA0355CF4CCB4)) {
    _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(objweapon);

    switch (_id_49E6EF3EDADD524E) {
      case "c4":
        _id_702BFC08FABD86CB = _id_702BFC08FABD86CB * 3;
        break;
      case "bouncing_betty":
      case "frag_grenade":
      case "semtex":
        _id_702BFC08FABD86CB = _id_702BFC08FABD86CB * 4;
        break;
      default:
        if(objweapon.isalternate)
          _id_702BFC08FABD86CB = _id_702BFC08FABD86CB * 3;

        break;
    }
  }

  return _id_702BFC08FABD86CB;
}

handlemeleedamage(objweapon, meansofdeath, damage) {
  if(meansofdeath == "MOD_MELEE")
    return self.maxhealth + 1;

  return damage;
}

handleempdamage(objweapon, meansofdeath, damage) {
  return damage;
}

handleapdamage(objweapon, meansofdeath, damage, attacker, victim) {
  modifier = 1.0;
  armorpiercingmod = level.armorpiercingmod - 1;

  if(scripts\mp\utility\damage::isfmjdamage(objweapon, meansofdeath)) {
    if(!isDefined(victim) || !isPlayer(victim))
      modifier = modifier + armorpiercingmod;
  }

  _id_F08F2B140236EBF2 = armorpiercingmod + 0.5;

  if(scripts\mp\utility\damage::_id_73D1D5D600A0CBC3(meansofdeath, attacker)) {
    modifier = modifier + _id_F08F2B140236EBF2;
    attacker _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(1, "suppressionRoundHit");
  }

  return int(damage * modifier);
}

_id_C599A0001CA06DC9(objweapon, smeansofdeath, damage, _id_BE4285B26ED99AB1) {
  if(!scripts\mp\utility\damage::isfmjdamage(objweapon, smeansofdeath))
    return damage;

  _id_527BB875E0D92D99 = 0;

  if(damage / _id_BE4285B26ED99AB1 < _id_527BB875E0D92D99)
    damage = int(_id_BE4285B26ED99AB1 * _id_527BB875E0D92D99);

  return damage;
}

_id_5E4AA8D548CC604E(damage, objweapon, attacker, meansofdeath) {
  modifier = 1.0;

  if(scripts\mp\utility\damage::_id_04766094B15B00A8(objweapon, meansofdeath, attacker))
    modifier = level._id_3395494B137909BB;

  return int(damage * modifier);
}

_id_10268164AB1BCC31(damage, objweapon, attacker) {
  modifier = 1.0;

  if(scripts\mp\utility\damage::_id_E287831520AA308B(objweapon, attacker))
    modifier = level._id_3395494B137909BB;

  return int(damage * modifier);
}

_id_71A1605C1A9BDDD7(objweapon, meansofdeath, damage, attacker, victim) {
  if(!scripts\mp\utility\weapon::isakimbo(objweapon))
    return damage;

  modifier = 1.0;

  switch (objweapon.basename) {}

  return int(damage * modifier);
}

handleshotgundamage(objweapon, meansofdeath, damage) {
  if(!isDefined(objweapon))
    return damage;

  if(objweapon.basename == "none")
    return damage;

  if(weaponclass(objweapon) != "spread")
    return damage;

  return int(min(150, damage));
}

onkillstreakdamaged(_id_D8061F26B5ECA018, attacker, weapon, damage) {
  _id_2D113E958C753976 = undefined;

  if(isDefined(attacker) && isDefined(self.owner)) {
    if(isDefined(attacker.owner) && isPlayer(attacker.owner))
      attacker = attacker.owner;

    if(isPlayer(attacker) && self.owner scripts\cp_mp\utility\player_utility::isenemy(attacker))
      _id_2D113E958C753976 = attacker;
  }

  if(isDefined(_id_2D113E958C753976))
    thread scripts\cp_mp\challenges::killstreakdamaged(_id_D8061F26B5ECA018, self.owner, _id_2D113E958C753976, weapon, damage);
}

onkillstreakkilled(_id_D8061F26B5ECA018, attacker, objweapon, _id_D95DA0355CF4CCB4, damage, _id_92D090CE35588AD2, leaderdialog, _id_6342E2DA1DC12454, _id_DC695757F69ED065) {
  _id_40EA91E2825FA07A = 0;
  _id_2D113E958C753976 = undefined;

  if(isDefined(attacker) && isDefined(self.owner)) {
    if(isDefined(attacker.owner) && isPlayer(attacker.owner))
      attacker = attacker.owner;

    if(issentient(self.owner) && issentient(attacker)) {
      if(!isalliedsentient(self.owner, attacker))
        _id_2D113E958C753976 = attacker;
    } else if(self.owner scripts\cp_mp\utility\player_utility::isenemy(attacker))
      _id_2D113E958C753976 = attacker;
  }

  if(isDefined(_id_2D113E958C753976)) {
    if(isDefined(level._id_CE95C7540070F7D0))
      [[level._id_CE95C7540070F7D0]](_id_D8061F26B5ECA018, self.team, _id_2D113E958C753976);

    if(isDefined(_id_6342E2DA1DC12454))
      _id_2D113E958C753976 scripts\mp\battlechatter_mp::killstreakdestroyed(_id_D8061F26B5ECA018);

    thread scripts\mp\events::killedkillstreak(_id_D8061F26B5ECA018, _id_2D113E958C753976, objweapon);
    thread scripts\cp_mp\challenges::killstreakkilled(_id_D8061F26B5ECA018, self.owner, self, _id_2D113E958C753976, damage, _id_D95DA0355CF4CCB4, objweapon, _id_92D090CE35588AD2);
    scripts\cp_mp\gestures::processcalloutdeath(self, _id_2D113E958C753976);
    _id_40EA91E2825FA07A = 1;
  }

  thread scripts\mp\events::processscrapassist(_id_2D113E958C753976);

  if(isDefined(self.owner) && isDefined(leaderdialog))
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_08959C1606F65E65(_id_D8061F26B5ECA018, leaderdialog);

  if(!istrue(_id_DC695757F69ED065))
    self notify("death");

  return _id_40EA91E2825FA07A;
}

updatedeathdetails(_id_FB0ECE5F482AFF3E, attackerdata, _id_6181DE250AFA5BB6) {
  attackercount = 0;

  if(isDefined(_id_6181DE250AFA5BB6) && isPlayer(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.health)) {
    if(!_id_6181DE250AFA5BB6 scripts\cp_mp\utility\player_utility::_isalive())
      self setclientomnvar("ui_death_details_enemy_health", 0);
    else
      self setclientomnvar("ui_death_details_enemy_health", int(clamp(_id_6181DE250AFA5BB6.health, 0, _id_6181DE250AFA5BB6.maxhealth)) / _id_6181DE250AFA5BB6.maxhealth);
  } else
    self setclientomnvar("ui_death_details_enemy_health", -1);

  if(isDefined(_id_FB0ECE5F482AFF3E) && isDefined(attackerdata)) {
    foreach(guid, attacker in _id_FB0ECE5F482AFF3E) {
      if(!isPlayer(attacker)) {
        continue;
      }
      _id_3010362406C84DCF = attacker getentitynumber();
      self setclientomnvar("ui_death_details_attacker_" + attackercount, _id_3010362406C84DCF);
      self setclientomnvar("ui_death_details_hits_" + attackercount, int(min(attackerdata[guid].hitcount, 10)));
      attackercount++;

      if(attackercount >= 4) {
        break;
      }
    }
  }

  for(_id_ED391F2E5D37DC2A = attackercount; _id_ED391F2E5D37DC2A < 4; _id_ED391F2E5D37DC2A++)
    self setclientomnvar("ui_death_details_attacker_" + _id_ED391F2E5D37DC2A, -1);
}

setdeathtimerlength(_id_642470E1ABC1BBF9) {
  victim = _id_642470E1ABC1BBF9.victim;
  _id_D8D2129EFF08B4B1 = 0;

  if(victim scripts\mp\playerlogic::mayspawn() && !level.disablespawncamera) {
    timeuntilspawn = scripts\mp\playerlogic::timeuntilspawn(1);
    _id_906A882502DD814A = 2.25;
    _id_0B5C34C3BC6C7E65 = 1;
    timeuntilspawn = max(timeuntilspawn + _id_0B5C34C3BC6C7E65, _id_906A882502DD814A);
    _id_D8D2129EFF08B4B1 = timeuntilspawn + _id_642470E1ABC1BBF9.deathscenetimesec;
  }

  victim.death_timer_length = int(_id_D8D2129EFF08B4B1 * 10);
}

getindexfromhitloc(shitloc) {
  switch (shitloc) {
    case "torso_upper":
      return 0;
    case "torso_lower":
      return 1;
    case "helmet":
      return 2;
    case "head":
      return 3;
    case "neck":
      return 4;
    case "left_arm_upper":
      return 5;
    case "left_arm_lower":
      return 6;
    case "left_hand":
      return 7;
    case "right_arm_upper":
      return 8;
    case "right_arm_lower":
      return 9;
    case "right_hand":
      return 10;
    case "left_leg_upper":
      return 11;
    case "left_leg_lower":
      return 12;
    case "left_foot":
      return 13;
    case "right_leg_upper":
      return 14;
    case "right_leg_lower":
      return 15;
    case "right_foot":
      return 16;
    case "gun":
      return 17;
    case "none":
      return 18;
  }

  return 0;
}

showuidamageflash() {
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

updatecombatrecordkillstats(attacker, victim, meansofdeath, objweapon) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  if(isDefined(attacker) && isPlayer(attacker) && attacker != victim) {
    if(isDefined(objweapon)) {
      _id_11D2F075E9A0E643 = scripts\mp\utility\weapon::getequipmenttype(objweapon);

      if(isDefined(_id_11D2F075E9A0E643) && _id_11D2F075E9A0E643 == "lethal") {
        equipment = scripts\mp\equipment::getequipmentreffromweapon(objweapon);

        if(!isDefined(equipment))
          equipment = "";

        if(equipment == "equip_throwing_knife_fire" || equipment == "equip_throwing_knife_electric" || equipment == "equip_shuriken")
          equipment = "equip_throwing_knife";

        attacker combatrecordlethalkill(equipment);
      } else {
        _id_F406BE343AB9CC93 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(objweapon);

        if(isDefined(_id_F406BE343AB9CC93)) {
          if(isenumvaluevalid(level._id_5D69837CF4DB0407, "LethalScorestreakStatItems", _id_F406BE343AB9CC93))
            attacker combatrecordkillstreakstat(_id_F406BE343AB9CC93);
        }

        if(istrue(attacker.personalradaractive))
          attacker combatrecordtacticalstat("power_periphVis");

        if(istrue(attacker.adrenalinepoweractive))
          attacker combatrecordtacticalstat("equip_adrenaline");
      }
    }
  }
}

combatrecordequipmentused(weapon) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  _id_4918B66CEBC7FBE7 = scripts\mp\equipment::isequipmentlethal(weapon);

  if(weapon == "equip_throwing_knife_fire" || weapon == "equip_throwing_knife_electric" || weapon == "equip_shuriken")
    weapon = "equip_throwing_knife";

  if(_id_4918B66CEBC7FBE7) {
    _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "lethalStats", weapon, "uses");
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "lethalStats", weapon, "uses", _id_7ABB90C7E07FF11B + 1);
  } else {
    _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "tacticalStats", weapon, "uses");
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "tacticalStats", weapon, "uses", _id_7ABB90C7E07FF11B + 1);
  }
}

combatrecordlethalkill(weapon) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "lethalStats", weapon, "kills");
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "lethalStats", weapon, "kills", _id_7ABB90C7E07FF11B + 1);
}

combatrecordtacticalstat(weapon, _id_D2194902E87613EB) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats() || isagent(self)) {
    return;
  }
  if(!isDefined(_id_D2194902E87613EB))
    _id_D2194902E87613EB = 1;

  _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "tacticalStats", weapon, "extraStat1");
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "tacticalStats", weapon, "extraStat1", _id_7ABB90C7E07FF11B + _id_D2194902E87613EB);
}

combatrecordkillstreakstat(streakname) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  _id_B326F2FC8716B6D8 = scripts\mp\utility\stats::getstreakrecordtype(streakname);

  if(!isDefined(_id_B326F2FC8716B6D8)) {
    return;
  }
  _id_7ABB90C7E07FF11B = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_B326F2FC8716B6D8, streakname, "extraStat1");
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", _id_B326F2FC8716B6D8, streakname, "extraStat1", _id_7ABB90C7E07FF11B + 1);
}

enqueuecorpsetablefunc(_id_CC4F2E0388379546, func) {
  if(!isDefined(self.corpsetablefuncs)) {
    self.corpsetablefuncs = [];
    self.corpsetablefunccounts = [];
  }

  if(!isDefined(self.corpsetablefuncs[_id_CC4F2E0388379546])) {
    self.corpsetablefuncs[_id_CC4F2E0388379546] = func;
    self.corpsetablefunccounts[_id_CC4F2E0388379546] = 0;
  }

  self.corpsetablefunccounts[_id_CC4F2E0388379546]++;
}

dequeuecorpsetablefunc(_id_CC4F2E0388379546) {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }
  if(!isDefined(self.corpsetablefuncs[_id_CC4F2E0388379546])) {
    return;
  }
  self.corpsetablefunccounts[_id_CC4F2E0388379546]--;

  if(self.corpsetablefunccounts[_id_CC4F2E0388379546] <= 0) {
    self.corpsetablefuncs[_id_CC4F2E0388379546] = undefined;
    self.corpsetablefunccounts[_id_CC4F2E0388379546] = undefined;
  }
}

callcorpsetablefuncs() {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }
  _id_3741EA5B9FB53EC3 = self.body;

  foreach(func in self.corpsetablefuncs)
  self thread[[func]](_id_3741EA5B9FB53EC3);

  thread clearcorpsetablefuncs();
}

clearcorpsetablefuncs() {
  self notify("clearCorpsetableFuncs");
  self.corpsetablefuncs = undefined;
  self.corpsetablefunccounts = undefined;
}

startcopycatoption(attacker) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_copy_cat_option");

  if(!isDefined(attacker) || !isPlayer(attacker) || isbot(self)) {
    return;
  }
  while(self copyloadoutbuttonPressed())
    waitframe();

  while(!self copyloadoutbuttonPressed())
    waitframe();

  scripts\mp\class::copyclassfornextlife(attacker);
}

stopcopycatoption() {
  self notify("stop_copy_cat_option");
}

isenvironmentalscriptableinflictor(einflictor) {
  _id_619C67271783522F = 0;

  if(isDefined(einflictor) && isDefined(einflictor.code_classname) && einflictor.code_classname == "scriptable") {
    switch (einflictor.classname) {
      case "scriptable_rp_propane_tank_long_01":
        _id_619C67271783522F = 1;
        break;
    }
  }

  return _id_619C67271783522F;
}

shouldrecorddamagestats(player) {
  if(istrue(level.disabledamagestattracking))
    return 0;

  if(isDefined(level.disabledamagestattrackingfunc) && ![[level.disabledamagestattrackingfunc]](player))
    return 0;

  return 1;
}

logfriendlyfire(player, attacker, damage, _id_3EAA9F644DBE7834) {
  if(!isDefined(player) || !isDefined(attacker) || !isDefined(_id_3EAA9F644DBE7834)) {
    return;
  }
  _id_DA8C4C2CB070B775 = damage >= player.health;
  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.weaponname = _id_2669878CF5A1B6BC::getweaponrootname(attacker.currentweapon);
  _id_7E2C53B0BCF117D9.fullweaponname = getcompleteweaponname(attacker.currentweapon);
  _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "friendly_fire_damage";
  _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = int(min(damage, player.health));
  _id_7E2C53B0BCF117D9.variantid = -1;
  _id_7E2C53B0BCF117D9.weaponobj = attacker.currentweapon;
  attacker _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  player dlog_recordplayerevent("dlog_event_friendly_fire", ["attacker", attacker, "damage", damage, "is_fatal_damage", _id_DA8C4C2CB070B775, "damage_method", _id_3EAA9F644DBE7834]);
}

_id_694D74D8B5AC556F(eattacker, idamage, _id_1DA1A66B5C6A06A7, smeansofdeath, objweapon, victim) {
  if(!isscriptedagent(eattacker))
    return [idamage, _id_1DA1A66B5C6A06A7];

  if(smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_DOWN")
    return [idamage, _id_1DA1A66B5C6A06A7];

  maxdamage = undefined;

  if(isDefined(eattacker) && isDefined(eattacker._id_2A3891ADA6ABEA80))
    maxdamage = eattacker._id_2A3891ADA6ABEA80;
  else if(isDefined(level._id_ED524AE7534D93E6))
    maxdamage = level._id_ED524AE7534D93E6;
  else if(isDefined(level._id_E38979EB8FD7F7FD) && level._id_E38979EB8FD7F7FD != -1) {
    class = weaponclass(objweapon);

    switch (class) {
      case "mg":
      case "rifle":
        maxdamage = level._id_6BA4985B66D62A71;
        break;
      case "sniper":
        maxdamage = level._id_7EB56682F591EA8D;
        break;
      case "spread":
        maxdamage = level._id_9CF526926A72864C;
        break;
      default:
        if(isexplosivedamagemod(smeansofdeath))
          maxdamage = level._id_47AEDB539717AEA5;
        else if(smeansofdeath == "MOD_MELEE")
          maxdamage = level._id_0E2FBC9E65108B1E;
        else
          maxdamage = level._id_E38979EB8FD7F7FD;
    }
  }

  if(isDefined(maxdamage)) {
    invehicle = scripts\cp_mp\utility\player_utility::isinvehicle();

    if(invehicle && isDefined(level._id_4899061E2E21DD13) && level._id_4899061E2E21DD13 != -1)
      maxdamage = int(maxdamage * level._id_4899061E2E21DD13);

    if(_id_1DA1A66B5C6A06A7 >= maxdamage) {
      if(isDefined(self.armorhealth))
        victim _id_07C40FA80892A721::_id_AC7803D45979135C(self.armorhealth + _id_1DA1A66B5C6A06A7 - maxdamage);

      _id_1DA1A66B5C6A06A7 = maxdamage;
      idamage = 0;
    } else {
      maxdamage = maxdamage - _id_1DA1A66B5C6A06A7;

      if(idamage > maxdamage)
        idamage = maxdamage;
    }
  }

  return [idamage, _id_1DA1A66B5C6A06A7];
}

_id_FE5EE0F83D4109EB(einflictor, attacker, smeansofdeath, objweapon) {
  if(isDefined(attacker) && attacker == self)
    return 1;

  if(isDefined(smeansofdeath) && (smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_SUICIDE"))
    return 1;

  if(scripts\mp\utility\entity::isdronepackage(einflictor))
    return 1;

  return 0;
}

_id_E07D55B45FC82AE0(einflictor, attacker) {
  if(!isDefined(attacker))
    return 0;

  if(!isPlayer(attacker) && !isDefined(attacker.team))
    return 0;

  if(self.team != attacker.team)
    return 0;

  if(self == attacker)
    return 0;

  return 1;
}

_id_CD066C9463AD28C5(objweapon, smeansofdeath) {
  if(!isDefined(objweapon))
    return 0;

  if(!isDefined(objweapon.basename))
    return 0;

  _id_F91BACB796F4FDE4 = 0;

  switch (objweapon.basename) {
    case "airdrop_escort_turret_ballistics_champion":
    case "chopper_gunner_turret_ballistics_dmz":
    case "hover_jet_turret_ballistics_mp":
    case "chopper_gunner_turret_ballistics_mp":
    case "airdrop_escort_turret_ballistics_mp":
      _id_F91BACB796F4FDE4 = 1;
      break;
    default:
      if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET")
        _id_F91BACB796F4FDE4 = 1;

      break;
  }

  return _id_F91BACB796F4FDE4;
}

_id_A062727999A72D2F(weaponname) {
  _id_F8C0529126C5FB04 = ["iw9_sh_vecho_mp", "iw9_pi_swhiskey_mp", "iw9_sh_tsierra12_mp"];

  foreach(_id_AC0E594AC96AA3A8 in _id_F8C0529126C5FB04) {
    if(_id_AC0E594AC96AA3A8 == weaponname)
      return 1;
  }

  return 0;
}

_id_403E958ECD04F255(victim, _id_401C3A2E68AAB0FD) {
  if(getdvarint("dvar_A658B504AC40C111", 1) == 1)
    logprint("[DamageEarlyOut] Victim Client " + victim getentitynumber() + " '" + victim.name + "' - Reason: " + _id_401C3A2E68AAB0FD);
}

_id_8BE77B53BCBD6D2D(attacker, type) {
  if(getdvarint("dvar_8484954D9812DEC1", 1) == 0) {
    return;
  }
  if(!isDefined(self.attackerdata)) {
    return;
  }
  if(isDefined(attacker) && isDefined(attacker.guid)) {
    if(!isDefined(self.attackerdata[attacker.guid])) {
      return;
    }
    if(type == 0)
      self.attackerdata[attacker.guid].killedby = 1;
    else if(type == 1)
      self.attackerdata[attacker.guid]._id_76207F194A157FB5 = 1;
  }

  _id_D614B27C91DFD5F9 = [];

  if(isDefined(attacker) && isDefined(attacker.guid))
    _id_D614B27C91DFD5F9[0] = self.attackerdata[attacker.guid];

  currenttime = gettime();
  _id_4C2335DB73179A86 = getdvarfloat("dvar_568C61C9CB10A05A", 20.0) * 1000;
  _id_27759D6E184C86E1 = getdvarint("dvar_10925A6DDD9190C1", 0) == 0;

  for(;;) {
    _id_21AA6F16D3025AF6 = undefined;
    _id_753E95A387880B4F = undefined;

    foreach(guid, attackerdata in self.attackerdata) {
      if(scripts\engine\utility::array_contains(_id_D614B27C91DFD5F9, attackerdata)) {
        continue;
      }
      if(_id_27759D6E184C86E1 && istrue(attackerdata._id_4CE88B2DFE0BFA52)) {
        continue;
      }
      _id_E0BA1A2E8FFB8E1E = attackerdata.lasttimedamaged - currenttime;

      if(abs(_id_E0BA1A2E8FFB8E1E) > _id_4C2335DB73179A86) {
        continue;
      }
      if(!isDefined(_id_753E95A387880B4F) || _id_753E95A387880B4F > _id_E0BA1A2E8FFB8E1E) {
        _id_21AA6F16D3025AF6 = attackerdata;
        _id_753E95A387880B4F = _id_E0BA1A2E8FFB8E1E;
      }
    }

    if(isDefined(_id_21AA6F16D3025AF6)) {
      _id_D614B27C91DFD5F9[_id_D614B27C91DFD5F9.size] = _id_21AA6F16D3025AF6;
      continue;
    }

    break;
  }

  _id_C41DADD6F0B10385 = 0;

  for(index = 0; index < 6; index++) {
    if(index < _id_D614B27C91DFD5F9.size) {
      data = _id_D614B27C91DFD5F9[index];
      lootid = _id_2669878CF5A1B6BC::_id_9C331F88BE5A1478(data.objweapon);

      if(lootid == 0) {
        _id_1189BD7FBE2861F8 = scripts\mp\equipment::getequipmentreffromweapon(data.objweapon);

        if(isDefined(_id_1189BD7FBE2861F8))
          lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_1189BD7FBE2861F8);
        else if(_id_2669878CF5A1B6BC::iskillstreakweapon(data.objweapon)) {
          _id_D8061F26B5ECA018 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(data.objweapon);
          lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_D8061F26B5ECA018);
        } else if(isDefined(data.objweapon.basename))
          lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(data.objweapon.basename);
      }

      attackerent = scripts\engine\utility::_id_53C4C53197386572(data.attackerent, undefined);
      lootid = int(clamp(scripts\engine\utility::_id_53C4C53197386572(lootid, 0), 0, 2147483647));
      _id_9D0080BA4B9A0226 = scripts\engine\utility::_id_53C4C53197386572(data._id_282F568E901445CE.size > 1, 0);
      damage = int(clamp(scripts\engine\utility::_id_53C4C53197386572(data._id_D69D6CC16D8B71FB, 0), 0, 1023));
      hitcount = int(clamp(scripts\engine\utility::_id_53C4C53197386572(data.hitcount, 0), 0, 255));
      _id_76207F194A157FB5 = scripts\engine\utility::_id_53C4C53197386572(istrue(data._id_76207F194A157FB5), 0);
      killedby = scripts\engine\utility::_id_53C4C53197386572(istrue(data.killedby), 0);
      _id_3E2EF879EE8848E2 = scripts\engine\utility::_id_53C4C53197386572(scripts\mp\utility\player::isfriendly(self.team, data.attackerent), 0);
      _id_F5E1C7E19D1F681C = 0;

      if(isDefined(data._id_8519CF56B38D717D)) {
        switch (data._id_8519CF56B38D717D) {
          case "MOD_FALLING":
            _id_F5E1C7E19D1F681C = 1;
            break;
          case "danger_circle_br":
            _id_F5E1C7E19D1F681C = 2;
            break;
          case "BLEED_TICK":
            _id_F5E1C7E19D1F681C = 3;
            break;
          case "ENV_EXPLOSIVE":
            _id_F5E1C7E19D1F681C = 4;
            break;
          case "BOMB_SITE":
            _id_F5E1C7E19D1F681C = 5;
            break;
          case "MOD_CRUSH":
            _id_F5E1C7E19D1F681C = 6;
            break;
          case "MOD_MELEE":
            _id_F5E1C7E19D1F681C = 7;
            break;
          case "MOD_EXECUTION":
            _id_F5E1C7E19D1F681C = 8;
            break;
          case "OOB":
            _id_F5E1C7E19D1F681C = 9;
            break;
          default:
            _id_F5E1C7E19D1F681C = 10;

            if(isDefined(data.smeansofdeath) && data.smeansofdeath == "MOD_SUICIDE")
              _id_F5E1C7E19D1F681C = 9;

            break;
        }
      }

      self setclientomnvar("ui_combat_report_attacker_" + index, attackerent);
      self setclientomnvar("ui_combat_report_weapon_lootid_" + index, lootid);
      self setclientomnvar("ui_combat_report_multi_weapon_" + index, _id_9D0080BA4B9A0226);
      self setclientomnvar("ui_combat_report_damage_" + index, damage);
      self setclientomnvar("ui_combat_report_hits_" + index, hitcount);
      self setclientomnvar("ui_combat_report_downedby_" + index, _id_76207F194A157FB5);
      self setclientomnvar("ui_combat_report_killedby_" + index, killedby);
      self setclientomnvar("ui_combat_report_friendly_" + index, _id_3E2EF879EE8848E2);
      self setclientomnvar("ui_combat_report_damage_type_override_" + index, _id_F5E1C7E19D1F681C);
      continue;
    }

    self setclientomnvar("ui_combat_report_attacker_" + index, undefined);
    self setclientomnvar("ui_combat_report_weapon_lootid_" + index, 0);
    self setclientomnvar("ui_combat_report_multi_weapon_" + index, 0);
    self setclientomnvar("ui_combat_report_damage_" + index, 0);
    self setclientomnvar("ui_combat_report_hits_" + index, 0);
    self setclientomnvar("ui_combat_report_downedby_" + index, 0);
    self setclientomnvar("ui_combat_report_killedby_" + index, 0);
    self setclientomnvar("ui_combat_report_friendly_" + index, 0);
    self setclientomnvar("ui_combat_report_damage_type_override_" + index, 0);
  }

  _id_768FE1AF4DDA51AD = scripts\engine\utility::_id_53C4C53197386572(_id_D614B27C91DFD5F9.size, 0);
  _id_768FE1AF4DDA51AD = int(clamp(_id_768FE1AF4DDA51AD, 0, 6));
  self setclientomnvar("ui_combat_report_num_attackers", _id_768FE1AF4DDA51AD);
}